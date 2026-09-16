# Patterns

Each pattern: how to recognize it in an `EXPLAIN (ANALYZE, BUFFERS)` plan, and what it means. Check every one against every node that matters — don't rely on remembering which ones applied last time.

## Cache hit vs read

`Buffers: shared hit=X read=Y`. `hit` = served from cache (Postgres shared buffers or the OS page cache); `read` = physical disk I/O. A run with `read=0` can look great purely because the data happened to be warm — it proves nothing about behavior on a cold cache or under memory pressure. Never call a plan "fixed" from one warm run; check whether the *plan shape* changed, not just the number. Two runs of the identical plan can differ by seconds just from cache state.

## Buffers-in-loop

A node with `loops=N` where `N > 1` multiplies that node's per-call buffer cost by N in the parent's total. Two very different situations produce this:

- **Cheap per call** — a parameterized index scan or a well-indexed `LATERAL`, each call touching a handful of buffers. Fine, even when N is in the thousands.
- **Expensive per call** — a `Seq Scan` with a large `Rows Removed by Filter` inside the loop, repeated N times. This is the single most common cause of a query that "should be fast" (it's filtered to a handful of rows) taking hundreds of milliseconds: the same full table gets scanned once per loop iteration instead of once total.

Look at the buffers *per single call* (total ÷ loops), not just the total, to tell which one you're looking at.

## The estimate gap

Compare `rows=X` in the cost estimate against `rows=Y (actual ...)` on the same node. A gap under ~10x is normal planner slop. A gap of hundreds or thousands of times means the planner's model of the data is wrong — usually from correlated columns, an `OR` spanning two tables, or an opaque expression (`COALESCE`, `CASE`) the planner can't attach real statistics to. A plan built on a bad estimate can flip to something far worse the moment cache state or input parameters change, even if it happens to run fine today. Fix the estimate (rewrite the condition) rather than tolerating a plan that only works by luck.

## Un-pushed-down aggregation

A CTE or subquery doing `GROUP BY`/aggregation that isn't `MATERIALIZED` and isn't scoped by a `WHERE`/join key to what the outer query actually needs. Because the aggregation has to complete before anything can filter its output, the whole aggregate gets computed — sometimes over the entire table — even when the final result only uses a handful of its rows. Fix: turn it into a `LATERAL` subquery correlated to the specific key the outer query already has, so it only computes what's needed. Watch for `Disk Usage`/`Batches > 1` on the aggregate node — a sign it's grouping far more than intended.

## Correlated top-N-per-group without a supporting index

A `LATERAL (... ORDER BY ... LIMIT 1)` or similar per-row lookup. Without an index on `(correlation_column, order_column DESC/ASC, tiebreak DESC/ASC)`, every call does a full scan + sort of the correlated table just to find one row. Unlike a broad `WHERE` filter, this pattern doesn't need to pass the selectivity gate below — an exact-match-then-order lookup benefits from an index almost every time, because it always throws away all but one row per call regardless of table size.

## The selectivity gate

Before creating an index for a `WHERE` filter (as opposed to a top-N-per-group lookup above), check what fraction of the table the filter actually keeps (`Rows Removed by Filter` vs total rows scanned). An index beats a sequential scan only when the filter excludes a clear majority of rows — a filter that keeps, say, half the table will likely make an index scan slower than a seq scan (more random I/O for no real gain), and the planner may simply refuse to use the index at all. Always check this with a realistic filter value, not whatever the test happened to use — a wide date range or a common status code can pass the test as "not selective" while a narrow one genuinely is, or vice versa.

## Missing filter check

Before analyzing performance at all, confirm every `WHERE` condition you expect actually shows up as a `Filter:` or `Index Cond:` somewhere in the plan. A silently dropped predicate (lost parameter, template bug, an `X OR TRUE` that always passes) can make a query look surprisingly fast or scan far more than intended — and no amount of tuning fixes a query that's returning the wrong rows.

## Forcing a plan to find the real cost

`SET enable_seqscan = off`, `enable_nestloop = off`, etc., then re-run: this reveals the cost of the plan the planner *didn't* pick, which tells you whether its original choice was actually right. Sometimes disabling something makes the query much worse — e.g. removing access to a parameterized index scan that only exists inside a nested loop — which confirms the original plan was correct all along, not a bug to fix. Always revert the setting afterward; it's a diagnostic, not a permanent fix.

## Non-sargable predicate (function-wrapped column)

`Filter:` shows a function applied to the column itself (`date_trunc(...)`, `UPPER(...)`, `length(...)`) instead of the column compared directly to a value. Even when an index exists on the raw column, the planner can't use it for this predicate — and it also can't estimate selectivity correctly, since it has no statistics on the function's output (compounds with "the estimate gap" above). Fix: rewrite the condition so the column stands alone on one side (turn `date_trunc('day', col) BETWEEN a AND b` into `col >= a AND col < b + interval '1 day'`); only fall back to a functional index (`CREATE INDEX ON t (date_trunc('day', col))`) when the transformation genuinely can't be done in SQL.

## Sorting by a derived expression

`Sort Key:` built from a function of a column (`to_char(date, 'DD/MM/YYYY')`, `lower(name)`) instead of the column itself. This is two separate problems, not one: it can never be served by an index on the raw column (so it always costs a real sort), and formatting before sorting can silently change the order (`'25/01/2026'` sorts before `'05/03/2026'` as text, even though it's later as a date) — a correctness bug wearing a performance costume. Fix: sort by the raw column, format only in the final `SELECT` list.

## Hash join spilling to disk

`Batches: N` with `N > 1` on a `Hash`/`Parallel Hash` node, or `external merge Disk:` under a `Sort` feeding into a join. The build side didn't fit in `work_mem`, so Postgres partitioned it to disk mid-join. Cheap to confirm: bump `work_mem` for the session (`SET work_mem = '128MB'`) and re-run — if `Batches` drops to 1 and the temp I/O disappears, that confirms the diagnosis. Fixing it doesn't always fix total time (a plan can still be dominated by scanning large, unfiltered build-side tables) — but it removes disk I/O as a variable so the real remaining bottleneck becomes visible.

## Zero actual rows is not proof a branch is dead

A node with `loops=N` showing `rows=0` on every one of those N calls, in one `EXPLAIN ANALYZE` run, only describes that run's parameters and that moment's data — it is not a general guarantee the branch never matches anything. Before deleting a join/`UNION`/`COALESCE` branch on the strength of one plan's zero-row evidence, validate against a business-level aggregate (`SUM`, `COUNT`) that the old and new query agree on, across more than one representative parameter window. A branch that's empty for this month's data can be exactly the one that carries last year's edge case — and for financial or otherwise consequential data, that gap is a silent data-loss bug, not a performance win.

## UNION ALL split is not automatically better

Splitting an `OR` across two tables into two separately-filtered branches (each usable with its own index/statistics) looks like a clean way to recover per-column selectivity — but test it, don't assume it wins. If either branch ends up applying its filter *after* a parameterized per-row lookup (inside a nested loop), Postgres tends to floor the row estimate near 1 per call, which compounds into a worse total estimate than a single bulk filter would have had. Compare actual numbers before keeping this rewrite.
