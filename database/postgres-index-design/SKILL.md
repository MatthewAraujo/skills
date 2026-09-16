---
name: postgres-index-design
description: Design and choose PostgreSQL B-Tree indexes for a table or feature — picking which columns to index, in what order, and whether an index earns its write/storage cost. Use when the user is adding a new table/column and asks which indexes to create, wants to audit existing indexes for redundancy or over-indexing, needs to decide composite index column order, or is choosing between a plain, partial, functional, or covering index. For diagnosing an already-slow query from an EXPLAIN plan, use postgres-query-analysis instead.
---

# Postgres Index Design

An index is designed from the queries a table serves, not from the table alone — the access patterns decide which columns, in what order, and whether the write cost is worth it. Go through every step below for every table under discussion; skipping one is how a table ends up with three overlapping indexes nobody remembers choosing.

## 1. List every access pattern the index must serve

Write down every real `WHERE`, `JOIN`, and `ORDER BY` combination that touches this table across the queries that matter — not just the one query that prompted the question. An index tuned for a single query is often a near-miss for the other four that hit the same table.

Completion criterion: every query you know touches this table is listed with its filter/join/sort columns, not just the first one mentioned.

## 2. Check selectivity for every candidate filter column

For each column used with `=`, `IN`, or a range in step 1, find out what fraction of the table it actually keeps, on real data:

```sql
SELECT count(*) FILTER (WHERE <condition>), count(*) FROM table;
```

A column that keeps more than roughly 5-10% of the table on its typical value won't earn its index — the planner will (correctly) prefer a sequential scan over it. See `postgres-query-analysis`'s `PATTERNS.md` → "The selectivity gate" for the full reasoning. Check per candidate value, not once: a status column can be selective for one value (`= 5`) and worthless for another (`= 3`) — one index still serves both, the planner simply won't use it for the non-selective one.

Completion criterion: every filter column from step 1 has a measured fraction, not an assumption.

## 3. Order composite columns: Equality → Sort → Range

For any index covering more than one column:

1. Equality (`=`) columns first.
2. The `ORDER BY` column(s) next — so rows inside each equality group already come out sorted, avoiding a real sort.
3. Range/inequality columns (`>`, `<`, `BETWEEN`, `LIKE 'x%'`) last.

A range column placed before the sort column breaks the free ordering: inside a range of values, each value has its own sorted sub-block, not one order spanning the whole range. Putting range last turns it into a residual filter that doesn't disturb the sort.

Completion criterion: the chosen order is justified against every access pattern from step 1 that touches this index, not just the one with the most columns.

## 4. Check for overlap with what already exists

```sql
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = '<table>';
```

A B-Tree index also serves any query using a leftmost prefix of its columns — `(a, b, c)` already covers `a`, `a+b`, and `a+b+c`. Adding `(a)` or `(a, b)` next to an existing `(a, b, c)` is dead weight, not protection.

Completion criterion: confirmed no existing index (or prefix of one) already covers the new access pattern; if one does, extend or replace it instead of adding another.

## 5. Choose the index flavor

- **Plain** (`CREATE INDEX ON t (col)`) — default, use unless one of the below clearly applies.
- **Partial** (`... WHERE condition`) — only when the condition scopes to a *minority* of the table (e.g. non-archived rows), or is combined with another indexed column to exclude rows nothing ever queries. A partial index on the *majority* value fails the same selectivity gate as a plain one — it doesn't dodge step 2.
- **Functional** (`CREATE INDEX ON t (lower(col))`) — only when the query truly can't avoid wrapping the column in a function (case-insensitive search, normalized comparison).
- **Covering** (`... INCLUDE (col2, col3)`) — when the query's `SELECT` list needs a couple of extra columns and adding them lets Postgres answer entirely from the index (Index-Only Scan), skipping the table.

Completion criterion: one flavor is picked with a stated reason tied to steps 1-4, not "just in case it helps."

## 6. Create it and verify the planner actually uses it

```sql
CREATE INDEX CONCURRENTLY idx_name ON table (...);
```

Use `CONCURRENTLY` outside a throwaway/dev database — without it, `CREATE INDEX` locks the table against writes for the build's duration. After creating it, re-run `EXPLAIN (ANALYZE, BUFFERS)` on the access patterns from step 1 and confirm the new index actually shows up in the plan — existing is not the same as used.

Completion criterion: for every access pattern the index was meant to serve, the plan either uses it, or there is a stated, selectivity-backed reason the planner is right to skip it.

## Ongoing: watch total index count on write-heavy tables

Every index adds cost to every `INSERT`/`UPDATE`/`DELETE` that touches its columns. Periodically audit for dead weight:

```sql
SELECT indexrelname, idx_scan FROM pg_stat_user_indexes WHERE idx_scan = 0;
```

An index with `idx_scan = 0` after a representative period of real traffic is pure write cost with no read benefit — drop it.
