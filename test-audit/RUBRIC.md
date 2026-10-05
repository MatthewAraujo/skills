# Test Audit Rubric

The question behind every verdict: **what realistic bug in a business behavior would turn this test red?**

## Verdicts

- `keep`: protects an AC or flow at a public seam and catches a nameable bug.
- `rewrite`: protects a real behavior but in a way that misses its bug or breaks on refactor (reason codes below).
- `merge`: one of several tests checking the same behavior at the same seam with inputs that exercise no different branch; collapse them into one, table-driven if the variants matter.
- `delete`: no realistic bug would turn it red, and no AC or flow needs it.

A test of pure domain logic (a pricing rule, a state transition, a validation) is a business test even when it is a unit test. Judge the behavior, not the test type.

## Reason codes

| Code | Smell | Usual verdict |
|---|---|---|
| `TAUTOLOGY` | The expected value is recomputed the way the code computes it, or a constant is asserted against itself; it passes by construction | rewrite |
| `IMPL-COUPLED` | Asserts internals: private methods, call counts or order on internal collaborators, internal state reached past the interface | rewrite |
| `MOCKS-SUBJECT` | Mocks so much that the code under test barely runs; the assertion checks the mock's own setup | rewrite or delete |
| `WEAK-ASSERT` | Asserts only existence or absence of failure (`toBeDefined`, `not.toThrow`, status 200 with no body check) where the behavior has a checkable outcome | rewrite |
| `SNAPSHOT-DUMP` | Large snapshot nobody reviews; any change is re-approved blindly | rewrite |
| `TRIVIAL` | Exercises code with no logic: getters, setters, constructors, plain data mapping, re-exports | delete |
| `FRAMEWORK` | Tests the framework, language, or a library rather than this project's behavior (the ORM saves, the router routes) | delete |
| `TYPE-GUARANTEED` | Checks what the type system already guarantees | delete |
| `DUPLICATE` | Same behavior, same seam, no new branch as another test | merge |
| `NO-AC` | Real behavior, but no AC or flow needs it: possible scope creep in the tests or a gap in the PRD; flag it, don't silently delete | keep or delete, ask |
| `HAPPY-ONLY` | Covers an AC's success path while its rules, edge cases, or failure paths go untested | keep, and mark the AC `weak` |
| `SURVIVED` | A mutant in the code it covers survived while it stayed green | rewrite |

## Coverage status per AC or flow

- `covered`: at least one `keep` test catches the bug in its main path, and its listed edge cases and failure paths each have one.
- `weak`: only the happy path is protected, or its only tests carry `rewrite` verdicts.
- `missing`: no `keep` or `rewrite` test protects it.

Line coverage is not a signal here: a line can run under a test that would catch no bug in it.
