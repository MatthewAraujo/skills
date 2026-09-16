---
name: postgres-query-analysis
description: Diagnose why a PostgreSQL query is slow using EXPLAIN (ANALYZE, BUFFERS) and guide the fix. Use when the user pastes an EXPLAIN/query plan, asks why a Postgres query is slow, has a parameterized or templated query (ORM output, `$1`/`$2` placeholders, string-interpolated SQL) that needs turning into a runnable EXPLAIN test, is comparing a query rewrite against a baseline, or is deciding whether a new index is worth creating for a specific slow-query finding. For designing indexes from scratch with no slow query yet, use postgres-index-design instead.
---

# Postgres Query Analysis

Diagnosing a slow Postgres query is a loop, not a one-shot verdict: normalize the query, read the plan bottom-up, name the real cause behind every big number, propose the cheapest fix first, test it, compare against the previous run, repeat. [`PATTERNS.md`](PATTERNS.md) holds the checklist of red flags used in the diagnose step — check every item against the plan each time, don't rely on memory of what you found last time.

## 1. Normalize the query

Before anything can run, turn whatever the user gives you into one standalone, valid SQL statement:

- Inline any template literals (`${...}`, string concatenation, ORM-generated fragments) at the exact point they're used — never leave a `${SOMETHING}` in the output.
- Replace positional placeholders (`$1`, `$2`, ...) with concrete example values. If the user hasn't given values, pick realistic ones and say out loud which ones you assumed — a wrong assumption here (e.g. a date range far wider than production ever uses) silently invalidates every number you'll read later.
- Wrap the result in `EXPLAIN (ANALYZE, BUFFERS)`.

Completion criterion: the query is something you could paste into `psql` with no unresolved template syntax and no unbound parameter, and every substituted value has been stated to the user.

## 2. Get real numbers

If you have a way to run SQL against the target database yourself (a configured connection, credentials in env, a DB tool), run the prepared query and read its own output. Otherwise, hand the query to the user and ask them to run it and paste back the full output.

Never fabricate, estimate, or guess at `EXPLAIN` output. A plan without `actual time=` and `Buffers:` lines is not `ANALYZE`'d — ask for the `ANALYZE, BUFFERS` version specifically; an estimate-only `EXPLAIN` cannot answer "why is this slow."

Completion criterion: you're holding actual output with `actual time=`, `rows=`, and `Buffers:` on the executed nodes.

## 3. Diagnose bottom-up

Read the plan starting from the innermost/deepest nodes outward — that's where actual data gets touched, and where misestimates and full scans originate before they cascade up through joins. Check every node against [`PATTERNS.md`](PATTERNS.md).

Completion criterion: every node responsible for a meaningful share of total time or buffers (rule of thumb: >10%) has a named cause from the checklist, not just "this looks slow." If the causes you found don't add up to roughly the total execution time, keep digging — there's a node you skipped.

## 4. Propose the cheapest fix first

For each finding, prefer in this order:

1. **A query rewrite** — materializing a CTE, replacing an `OR` across two tables with `COALESCE`, correlating a global aggregate into a `LATERAL` scoped to what's actually needed. This fixes the planner's *model* of the data, not just which scan method wins, so the win holds up under different inputs and cache states.
2. **An index** — only once the finding has passed the selectivity gate (`PATTERNS.md`): the filter must exclude a clear majority of the table for an index to beat a sequential scan. Never create an index against a filter you haven't checked for selectivity with a realistic value — a too-wide test range hides the real answer.
3. **A planner hint or a permanent `SET enable_x = off`** — last resort only; useful earlier as a *diagnostic* (`PATTERNS.md` → forcing a plan) but revert it once you've learned what you needed.

State which specific finding each proposed fix targets and what you expect to change in the next `EXPLAIN` because of it.

Completion criterion: every finding from step 3 has either a proposed fix or an explicit "this is real, necessary work, not waste" verdict.

## 5. Test and compare

Re-run steps 1-2 on the fixed query. Keep a running comparison table across every iteration in the conversation, not just before/after — time, `Buffers: hit`/`read`, and the top estimate gap. State plainly whether it got better, worse, or mixed, and tie the verdict back to the finding it was meant to fix. A lower time alone doesn't prove the fix worked — a warm cache can produce that too (`PATTERNS.md` → cache hit vs read).

If the fix removed, merged, or restructured any join/branch/condition — not just changed which scan method wins — also compare a business-level aggregate (`COUNT(*)`, `SUM(...)`) between the old and new query on the same data. A faster query that quietly returns fewer or different rows is a correctness bug, not a fix (`PATTERNS.md` → zero actual rows is not proof a branch is dead).

Completion criterion: the comparison table has a new row, the verdict is anchored to specific numbers, and — if any logic was removed or restructured — a matching aggregate check, not just a faster plan.

## 6. Loop or stop

Go back to step 3 with the new plan if a finding still accounts for a meaningful share of time. Stop when no remaining finding does, when the user says to stop, or when the remaining cost is real work the query legitimately has to do — state which one it is.

## 7. Offer to write it up

Once the loop ends, offer — don't do it unprompted — to save the tested query variants and log a short case study (the comparison table plus the one or two decisions that mattered) somewhere the user tracks this kind of thing. Only write it if they say yes.
