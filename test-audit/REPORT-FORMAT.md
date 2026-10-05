# Test Audit Report Format

Write in English, like every repository doc. Keep test names, file paths, and identifiers verbatim.

```md
# Test Audit — <scope> — <YYYY-MM-DD>

## Summary

Scope: <whole suite | path | T3-T7 | branch>. Ruler: <PRD ACs | inferred flows>.
Suite run: `<command>` — <N> tests, <time>, <failures/flaky or "all green">.

| Verdict | Tests | Share |
|---|---|---|
| keep | | |
| rewrite | | |
| merge | | |
| delete | | |

<Two or three sentences: is the suite protecting the real flows, and where is the effort wasted?>

## Coverage by acceptance criterion

| AC / Flow | Behavior | Protecting tests (keep) | Status | Gap |
|---|---|---|---|---|
| AC-1 | | | covered / weak / missing | <untested edge case or failure path> |

## Findings

Only tests with a verdict other than `keep`, grouped by reason code, worst first.

| Test | Location | Protects | Bug it catches | Verdict | Code | Note |
|---|---|---|---|---|---|---|
| <test name> | `path:line` | AC-n / none | <one line> / none | rewrite | WEAK-ASSERT | <what to assert instead> |

## Mutation

<Tool and command, critical modules, mutation score per module, surviving mutants with the test that should have caught each — or "Skipped: <reason>".>

## Kept tests

<Collapsed list of `keep` tests per AC or flow, so the reader can verify the verdicts.>

## Next steps

Ordered: first the `missing` and `weak` ACs (tests to write), then `rewrite`, then `merge`/`delete`. Each item names the AC or flow it serves, so it can go straight to `tdd`.
```
