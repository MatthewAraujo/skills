---
name: task-runner
description: Execute implementation tasks one at a time from docs/TASKS.md by preparing minimal context, invoking tdd for a single task, updating task status, and writing a handoff summary. Use after task-planner or generate-project when the user wants to progress through tasks safely without overloading context.
---

# task-runner

Use this skill to execute exactly one implementation task from `docs/TASKS.md`.

The goal is to keep implementation sessions small, traceable, and safe by selecting a single runnable task, preparing a minimal context pack, handing that task to `tdd`, recording the outcome, and stopping.

This skill is an orchestration skill.

It must not implement every task in one pass.
It must not replace `tdd`.

## When to Use

Use this skill when:

- `docs/TASKS.md` exists;
- the user wants to execute the next planned task;
- the user wants to continue implementation after `generate-project`;
- the user wants to avoid context bloat across many tasks;
- the user says "run next task", "continue task loop", "execute TASKS.md", or similar.

## When Not to Use

Do not use this skill when:

- there is no `docs/TASKS.md`;
- the PRD is missing for feature or refactor work;
- the task plan is not clear;
- the user is still discussing requirements;
- the user wants to generate a project skeleton first;
- the user asks for a broad implementation without task boundaries.

If `docs/TASKS.md` is missing, return to `task-planner`.

If the project skeleton is missing, return to `generate-project`.

## Required Inputs

Read these files when they exist:

1. `PROJECT.md`
2. `CONTEXT.md`
3. `docs/PRD.md`
4. `docs/TASKS.md`
5. `docs/adr/`
6. `docs/GLOSSARY.md`
7. `docs/task-runs/`

Do not load all files blindly.

Load only the documents needed to select and execute the next task.

## Task Selection

Select exactly one task.

Task priority:

1. first task with `Status: ready`;
2. otherwise first task with `Status: planned`;
3. otherwise first task with `Status: blocked` only if the blocking condition has been resolved;
4. otherwise report that there are no runnable tasks.

Do not execute tasks marked:

- `done`
- `cancelled`
- `blocked`
- `in_progress`

unless the user explicitly requests that task.

## Context Pack

Before invoking `tdd`, create or update:

`docs/task-runs/<task-id>-context.md`

The context pack must include:

```md
# <task-id> Context

## Task

## Related PRD Acceptance Criteria

## Relevant Prior Summaries

## Files Likely Affected

## Test-First Plan

## Constraints

## Risks

## Definition of Done
```

The context pack must be minimal.

Do not paste the entire PRD or entire TASKS file into the context pack.

Summarize only the parts relevant to the selected task.

## Execution Flow

Use this flow:

1. Load project memory and task plan.
2. Select one runnable task.
3. Mark the task as `in_progress`.
4. Create a minimal task context pack.
5. Invoke `tdd` for that single task.
6. Run or request relevant tests.
7. Update task status.
8. Write task summary.
9. Stop.

## Interaction With tdd

After the context pack is prepared, hand off to `tdd`.

`tdd` must:

- write or update the failing test first when feasible;
- implement the minimum code needed for the selected task;
- run relevant tests;
- refactor only after tests pass;
- avoid unrelated changes.

The selected task is the only implementation scope.

## Task Status Updates

Update `docs/TASKS.md` after the run.

Allowed statuses:

- `planned`
- `ready`
- `in_progress`
- `blocked`
- `done`
- `cancelled`

If the task is completed, mark it:

```txt
Status: done
```

If the task cannot continue, mark it:

```txt
Status: blocked
Blocker: <reason>
```

If tests fail and cannot be fixed within the task scope, mark it:

```txt
Status: blocked
Blocker: failing validation
```

## Handoff Summary

After each task, create or update:

`docs/task-runs/<task-id>-summary.md`

The summary must include:

```md
# <task-id> Summary

## Status

## What Changed

## Files Changed

## Tests Added or Updated

## Commands Run

## Validation Result

## Decisions Made

## Follow-up Needed

## Context for Next Task
```

This summary is the only previous-task context that future task runs should load by default.

Do not rely on the full conversation history.

## Memory Update Rules

After task completion, decide whether the task revealed durable project knowledge.

If yes, update `CONTEXT.md` only for durable decisions, risks, domain rules, or implementation discoveries.

Update `PROJECT.md` only if stable operational project information changed, such as scripts, setup, test commands, architecture overview, or required services.

Do not duplicate task summaries into `CONTEXT.md`.

## Stop Rule

After one task is completed or blocked, stop.

Do not automatically start the next task unless the user explicitly asks.

The final response must say which task was executed and what the next runnable task is.

## Safety Rules

- Execute exactly one task per run.
- Do not implement unrelated tasks.
- Do not load unnecessary context.
- Do not continue if task scope is ambiguous.
- Do not overwrite unrelated user changes.
- Do not run destructive commands.
- Do not mark a task as done without validation evidence or an explicit limitation.
- Do not bypass `tdd` for implementation.
- Do not silently edit the PRD to fit the implementation.

## Quality Checklist

Before finishing, verify:

- exactly one task was selected;
- the task had a clear acceptance criterion mapping;
- a context pack was created or updated;
- `tdd` was used for implementation;
- tests were added or updated when feasible;
- relevant validation commands were run or explicitly skipped with reason;
- `docs/TASKS.md` status was updated;
- a handoff summary was written;
- next task is clear;
- no unrelated tasks were implemented.
