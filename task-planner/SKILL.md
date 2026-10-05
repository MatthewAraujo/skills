---
name: task-planner
description: Turn docs/PRD.md into an implementation plan — an index at docs/TASKS.md plus one file per task in docs/tasks/. Use after to-prd and before tdd when a feature, refactor, or substantial bug fix needs task breakdown.
---

# task-planner

Transform the PRD into a plan that is specific to the repository, split into small tasks, and traceable to acceptance criteria.

The plan is an **index plus task files**:

- `docs/TASKS.md` — the index. Routes to every task, and is the only place that tracks progress.
- `docs/tasks/T<n>.md` — one spec per task, written once by this skill.
- `docs/task-runs/T<n>-CONTEXT.md` and `docs/task-runs/T<n>-summary.md` — written later by `task-runner`, never by this skill. The index links to them once they exist.

Do not implement code, rewrite the PRD (unless a blocking gap exists), or invent requirements absent from the PRD or accepted project context.

## Inputs

Read in order, when they exist: `PROJECT.md`, `CONTEXT.md`, `docs/PRD.md`, `docs/adr/`, `docs/GLOSSARY.md`, then the tests and scripts relevant to the change.

`docs/PRD.md` is mandatory for feature and refactor work. If it is missing or insufficient, stop and send the user back to `to-prd` or `grill-with-docs`. An urgent narrow bug fix may skip it only with the user's explicit approval; the plan must then still name the failing behavior, expected behavior, affected area, and regression test.

If the repository structure is unclear, inspect it before planning. Follow existing project conventions.

## Steps

### 1. Draft vertical slices

Break the work into small, reversible tasks, each implementable and validatable on its own. Never merge unrelated acceptance criteria into one task. Plan no broad rewrites unless the PRD requires them.

Each task is a **tracer bullet**: a narrow but complete path through every layer it touches (schema, API, UI, tests), demoable or verifiable on its own, and sized to fit a single fresh context window. Look for prefactoring that makes the rest easier ("make the change easy, then make the easy change") and plan it first.

**Wide refactors are the exception.** A wide refactor is one mechanical change (rename a column, retype a shared symbol) whose blast radius fans across the codebase, so no vertical slice can land green. Sequence it as **expand–contract**: expand (add the new form beside the old), migrate call sites in batches sized by blast radius (each batch a task depending on the expand), then contract (remove the old form, depending on every batch).

Present the breakdown as a numbered list (title, depends on, ACs served, what it delivers) and ask:

- Does the granularity feel right (too coarse / too fine)?
- Are the dependencies correct: does each task only depend on tasks that genuinely gate it?
- Should any tasks be merged or split?

Iterate until the user approves, then write the files.

Completion criterion: the user approved the breakdown.

### 2. Write the task files

Create one `docs/tasks/T<n>.md` per task (ids sequential: `T1`, `T2`, …):

```md
# T<n> — <task title>

## Objective

## Acceptance Criteria Served

## Affected Files / Areas

## Test-First Plan

## Implementation Notes

## Dependencies

## Completion Signal
```

Task files carry no status. They must be self-contained: `task-runner` builds a context pack from one task file, not from the whole plan.

A test-first plan lists **behaviors to protect**, not test names: one line per behavior as `AC-n → behavior → seam → bug it catches`, covering each AC's rules, edge cases, and failure paths, not only its happy path. A behavior with no nameable bug gets no test.

Test-first plans prefer integration tests where behavior crosses API, database, filesystem, network, queue, cache, or service boundaries, and unit tests for pure logic. Where tests are infeasible, state why and name the safest validation alternative.

Completion criterion: every PRD acceptance criterion is served by at least one task file, or is explicitly marked documentation-only, already satisfied, or blocked; every task file has a test-first plan and a checkable completion signal.

### 3. Write the index

Create or update `docs/TASKS.md`:

```md
# Tasks

## Source Context
PRD path, ADRs, glossary entries, memory files, relevant modules/tests/scripts.

## Implementation Goal
One short paragraph derived from the PRD. No new scope.

## Non-Goals
What must not be implemented.

## Tasks

| Task | Title | Depends on | Status | Context | Summary |
| --- | --- | --- | --- | --- | --- |
| [T1](tasks/T1.md) | … | — | planned | — | — |

## Acceptance Criteria Mapping

| Acceptance Criterion | Task(s) | Test(s) | Status |
| --- | --- | --- | --- |
| AC-1 | T1, T2 | unit/integration/e2e | planned |

## Test Strategy
Unit, integration, e2e/manual, regression, PRD edge cases, commands to run.

## Risk Plan
Risks and mitigations: data loss, public API, security, performance, concurrency, migrations, compatibility, UI regressions, flaky tests, operations.

## Execution Order
Recommended `tdd` order that keeps the project working after each step.

## Open Questions
Only blocking or materially relevant ones, otherwise: `No blocking open questions.`

## Handoff
Ready for `task-runner`. Start with T1.
```

The **Tasks** table is the routing surface and the progress ledger:

- Statuses: `planned`, `ready`, `in_progress`, `blocked`, `done`, `cancelled`. Every new task starts `planned` (or `ready` when it has no dependencies).
- The **Context** and **Summary** cells hold `—` until `task-runner` links `task-runs/T<n>-CONTEXT.md` and `task-runs/T<n>-summary.md` there.
- Progress lives only in this table; task files are never edited to record it.

Completion criterion: every file in `docs/tasks/` appears in the table, every table row links to an existing task file, and every section above is present.

## Rules

- No production-code edits, no silent scope expansion.
- One task = one file; never re-inline task bodies into `TASKS.md`.
- Re-planning an existing plan: update task files and rows in place, and leave the status and run links of `done` tasks untouched.
