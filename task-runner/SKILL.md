---
name: task-runner
description: Execute the next planned implementation task from docs/TASKS.md or docs/tasks/*.md. Use after task-planner or generate-project when the user wants to continue implementation one task at a time.
---

# task-runner

Use this skill to run one planned implementation task through a tight loop:

1. select one runnable task;
2. prepare the smallest context pack that `tdd` needs;
3. run `tdd` for that task only;
4. record the outcome;
5. stop.

This skill orchestrates implementation.
It does not replace `tdd`.
It must not silently continue into a second task.

## Use

Use this skill when:

- a task plan already exists in `docs/TASKS.md` or `docs/tasks/*.md`;
- the user wants to continue planned implementation;
- the user wants the next task executed without carrying the whole project history forward;
- the user says "run the next task", "continue the task loop", or equivalent.

## Redirect

Do not use this skill when:

- no task plan exists;
- feature or refactor work is missing `docs/PRD.md`;
- requirements are still being clarified;
- the project foundation still needs to be generated;
- the user wants broad implementation without task boundaries.

If the task plan is missing, return to `task-planner`.

If the project foundation is missing for a greenfield project, return to `generate-project`.

## Inputs

Read only the files needed to select and execute the next task.

Possible inputs:

1. `PROJECT.md`
2. `CONTEXT.md`
3. `docs/PRD.md`
4. `docs/TASKS.md`
5. `docs/tasks/*.md`
6. `docs/adr/`
7. `docs/GLOSSARY.md`
8. previous files in `docs/task-runs/`

Do not load every document blindly.

## Task Selection

Select exactly one task from the active task plan.

Priority:

1. first task with `Status: ready`;
2. otherwise first task with `Status: planned`;
3. otherwise first task with `Status: blocked` only if the blocker is now resolved;
4. otherwise stop and report that there is no runnable task.

Do not take tasks marked `done`, `cancelled`, `blocked`, or `in_progress` unless the user explicitly names that task.

## Tight Loop

### 1. Load just enough context

Read the smallest set of planning and memory files needed to understand the next runnable task.

Completion criterion:
You can name the active task-plan file, the selected task id, and the acceptance criteria that task serves.

### 2. Claim one task

Mark the selected task as `Status: in_progress` before implementation starts.

Completion criterion:
Exactly one task in the active plan is marked `in_progress` for this run.

### 3. Build the context pack

Create or update:

`docs/task-runs/<task-id>-context.md`

Use this structure:

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

Keep the context pack tight.
Summarize only the material needed for this task.
Do not paste the full PRD or full task plan.

Completion criterion:
`tdd` can execute the task from the context pack without loading unrelated history.

### 4. Hand off to `tdd`

Run `tdd` for the selected task only.

`tdd` should:

- write or update the failing test first when feasible;
- implement only the minimum code needed for this task;
- run relevant validation;
- refactor only after tests pass;
- avoid unrelated edits.

Completion criterion:
Implementation and validation attempted only within the selected task boundary.

### 5. Record the outcome

Update the task plan status based on the result.

Allowed statuses:

- `planned`
- `ready`
- `in_progress`
- `blocked`
- `done`
- `cancelled`

Use:

```txt
Status: done
```

when the task is complete.

Use:

```txt
Status: blocked
Blocker: <reason>
```

when the task cannot continue.

If validation fails and the issue cannot be fixed within scope, mark:

```txt
Status: blocked
Blocker: failing validation
```

Create or update:

`docs/task-runs/<task-id>-summary.md`

Use this structure:

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

This summary is the default prior-run context for future task executions.

Completion criterion:
The task plan status and the task summary both match the actual outcome of the run.

### 6. Stop

After one task is `done` or `blocked`, stop.

The final response must say:

- which task was executed;
- whether it completed or blocked;
- what the next runnable task is.

Completion criterion:
No second task is started automatically.

## Memory Updates

After the run, decide whether the task revealed durable project knowledge.

Update `CONTEXT.md` only for durable decisions, risks, domain rules, or implementation discoveries.

Update `PROJECT.md` only if stable operational knowledge changed, such as scripts, setup, commands, architecture overview, or required services.

Do not copy task-run summaries into `CONTEXT.md`.

## Commits

After a completed task, commit only when the environment allows it and the user has authorized commits.

Commits must be atomic and describe the actual change, not the task number.

Good examples:

```txt
Add project health check endpoint
Configure integration test database setup
Implement user creation validation
```

Bad examples:

```txt
Done task 2
Update files
Fix stuff
```

Do not commit broken code unless the user explicitly asks for that state.

## Rules

- execute exactly one task per run;
- do not implement unrelated tasks;
- do not load unnecessary context;
- do not continue when scope is ambiguous;
- do not overwrite unrelated user changes;
- do not run destructive commands;
- do not mark a task `done` without validation evidence or an explicit limitation;
- do not bypass `tdd` for implementation;
- do not edit the PRD to fit the implementation.

## Checklist

Before finishing, verify:

- exactly one task was selected;
- the task maps to explicit acceptance criteria;
- a context pack was created or updated;
- `tdd` was used for implementation;
- tests were added or updated when feasible;
- relevant validation commands were run or explicitly skipped with reason;
- the task-plan status was updated;
- a handoff summary was written;
- the next runnable task is clear;
- no unrelated task work was included.
