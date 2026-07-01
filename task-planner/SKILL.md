---
name: task-planner
description: Turn docs/PRD.md into a concrete, viable implementation plan for the current project. Use after to-prd and before tdd when a feature, refactor, or substantial bug fix needs task breakdown, affected files, risks, dependencies, and validation strategy.
---

# task-planner

Use this skill after `to-prd` has produced or updated `docs/PRD.md` and before implementation starts with `tdd`.

The purpose of this skill is to transform the PRD into an implementation-ready plan that is specific to the repository, small enough to execute safely, and directly traceable to acceptance criteria.

This skill must not implement code.
This skill must not rewrite the PRD unless it finds a blocking gap.
This skill must not invent requirements that are not present in the PRD or accepted project context.

## Required Inputs

Before planning, read the available project memory and specification files in this order when they exist:

1. `PROJECT.md`
2. `CONTEXT.md`
3. `docs/PRD.md`
4. `docs/adr/`
5. `docs/GLOSSARY.md`
6. Existing test files and project scripts relevant to the change

`docs/PRD.md` is mandatory for feature and refactor work.

For urgent narrow bug fixes, a full PRD may be skipped only if the user explicitly approved the shortcut. In that case, the planner must still identify the failing behavior, expected behavior, regression test, and affected area before implementation.

## Planning Goals

The planner must produce a plan that answers:

- what needs to be changed;
- where the change is likely to happen;
- which acceptance criteria each task satisfies;
- which tests should be written or updated first;
- what dependencies or ordering constraints exist;
- what risks must be controlled;
- what should not be changed.

The output must make implementation with `tdd` straightforward.

## Required Output

Create or update one of:

- `docs/TASKS.md` for a single active implementation plan; or
- `docs/tasks/<feature-name>.md` when the repository keeps multiple task plans.

Prefer `docs/TASKS.md` unless the project already has a different convention.

The task plan must include the following sections.

### 1. Source Context

List the documents and repository areas used to create the plan.

Include:

- PRD path;
- relevant ADRs;
- relevant glossary entries;
- project memory files consulted;
- relevant existing modules, tests, or scripts.

### 2. Implementation Goal

Summarize the implementation objective in one short paragraph.

This must be derived from `docs/PRD.md` and must not introduce new scope.

### 3. Non-Goals

List what must not be implemented during this task.

Use this to enforce YAGNI and prevent speculative additions.

### 4. Acceptance Criteria Mapping

Create a mapping from PRD acceptance criteria to implementation tasks and tests.

Each acceptance criterion should map to at least one task or be explicitly marked as documentation-only, already satisfied, or blocked.

Use this format:

| Acceptance Criterion | Task(s) | Test(s) | Status |
| --- | --- | --- | --- |
| AC-1 | T1, T2 | unit/integration/e2e | planned |

### 5. Task Breakdown

Break the work into small, ordered tasks.

Each task must include:

- task id;
- objective;
- affected files or areas;
- implementation notes;
- test-first plan;
- dependencies;
- completion signal.

Tasks must be small enough to implement and validate independently.

Use this format:

```md
## T1 — <task title>

Objective:

Affected files / areas:

Test-first plan:

Implementation notes:

Dependencies:

Completion signal:
```

### 6. Test Strategy

Define the expected test coverage before `tdd` starts.

Include:

- unit tests;
- integration tests;
- e2e or manual tests when relevant;
- regression tests for bugs;
- edge cases from the PRD;
- commands expected to run.

If tests are not feasible, explain why and define the safest validation alternative.

### 7. Risk Plan

List implementation risks and mitigation steps.

Consider:

- data loss;
- public API changes;
- authorization/security;
- performance;
- concurrency;
- migrations;
- compatibility;
- UI regressions;
- flaky tests;
- operational risk.

### 8. Execution Order

Provide the recommended order for `tdd` execution.

The order should minimize risk and keep the project working after each meaningful step.

### 9. Open Questions

List only questions that block or materially affect implementation.

If no questions remain, state:

`No blocking open questions.`

### 10. Handoff to tdd

End with a concise instruction for the next phase.

Example:

`Ready for tdd. Start with T1 and write the failing test described in the test-first plan.`

## Rules

- Do not start implementation.
- Do not edit production code.
- Do not silently expand scope beyond the PRD.
- Do not collapse multiple unrelated acceptance criteria into one large task.
- Do not plan broad rewrites unless the PRD explicitly requires them.
- Prefer small, reversible tasks.
- Prefer integration tests when behavior crosses API, database, filesystem, network, queue, cache, or service boundaries.
- Prefer unit tests for pure logic and deterministic transformations.
- Preserve existing project conventions.
- If repository structure is unclear, inspect before planning.
- If `docs/PRD.md` is missing or insufficient, stop and ask to return to `to-prd` or `grill-with-docs`.

## Planning Quality Checklist

Before finishing, verify:

- every PRD acceptance criterion is mapped;
- every task has a test-first plan;
- task order is explicit;
- affected files or areas are identified;
- risks are documented;
- non-goals are explicit;
- no implementation was performed;
- the plan is ready for `tdd`.
