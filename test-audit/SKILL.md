---
name: test-audit
description: Audit whether a project's tests protect real business behavior or are sloppy tests written for the sake of testing.
disable-model-invocation: true
argument-hint: "Scope (optional): a path, a task range (T3-T7), or a branch. Default: the whole suite."
---

# Test Audit

A test earns its place only by the **bug it catches**: a realistic defect in a business behavior that would make it go red. A test with no such bug is **sloppy**, however green it is. This audit judges every test in scope by that question and reports which flows are really protected.

It is read-only: never edit, delete, or rewrite tests or code. Fixes happen later, through `tdd`, for the verdicts the user picks.

## Steps

### 1. Pin the scope

Take the scope from the argument: a path, a task range (`T3-T7`: the tests those tasks' files and summaries name), or a branch (tests added or changed since its merge-base). With no argument, audit the whole suite.

Completion criterion: you can list every test file in scope.

### 2. Build the ruler

The ruler is the set of business behaviors tests should protect:

- If `docs/PRD.md` exists, take its acceptance criteria (AC-n), plus the behaviors listed in `docs/tasks/T<n>.md` test-first plans.
- Otherwise, infer **flows** from the code's entry points (routes, handlers, use cases, CLI commands, jobs, public functions of domain modules) and number them F-n, each one line in domain language.

Use `docs/GLOSSARY.md` vocabulary when it exists.

Completion criterion: a numbered list of ACs or flows, each one line, that every later verdict can point at.

### 3. Run the suite once

Run the scope's tests with the project's test command (from `PROJECT.md` or the build scripts). Record the result, total time, the slowest files, and any test that failed or behaved differently from what its code suggests.

Completion criterion: the run's command and summary are captured, or the reason it could not run is stated.

### 4. Judge every test

For each test case (not file), decide:

- **Protects**: which AC or flow it guards, or `none`.
- **Bug it catches**: one line naming a realistic defect that turns it red, or `none`.
- **Verdict**: `keep`, `rewrite`, `merge`, or `delete`, with a reason code from [RUBRIC.md](RUBRIC.md).

Then the other direction: for each AC or flow, which `keep` tests protect it, and whether its edge cases and failure paths are covered or only its happy path.

For a large scope, split by directory across sub-agents, each given the ruler and the rubric, and merge their tables.

Completion criterion: every test case in scope has all three fields, and every AC or flow has a coverage status (`covered`, `weak`, `missing`).

### 5. Prove the suspicious ones with mutation (optional)

Reading suggests; mutation proves. Pick the **critical modules**: the ones behind the most important ACs or flows, and the ones whose tests drew `rewrite`/`delete` verdicts. Detect the project's mutation tool (Stryker for JS/TS, mutmut for Python, cargo-mutants for Rust, PIT for JVM, go-mutesting for Go).

If none is installed, propose the command, preferring a throwaway run (`npx`, `uvx`) that leaves no committed config, and wait for the user's confirmation before installing or running anything. If the user declines, skip this step and say so in the report.

A **surviving mutant** is code broken on purpose while every test stayed green: it marks a flow whose tests catch no bug there.

Completion criterion: surviving mutants are listed per critical module with the test that should have caught each, or the step is recorded as skipped and why.

### 6. Write the report

Write `docs/reports/test-audit-<YYYY-MM-DD>.md` (append `-<scope>` when scoped) using [REPORT-FORMAT.md](REPORT-FORMAT.md).

Completion criterion: the file exists, its counts match the table in step 4, and every `delete`/`rewrite`/`merge` verdict cites its reason code.

### 7. Hand back

Tell the user the report path, the verdict counts, the ACs or flows that are `missing` or `weak`, and the three findings that matter most. Offer to fix the chosen verdicts through `tdd`, one AC or flow at a time.
