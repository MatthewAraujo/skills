# Parallel branch

Split the plan into **lanes** — independent task chains touching disjoint files — and run one background subagent per lane. You are the orchestrator: partition, dispatch, unblock sync points, own the index, integrate, report. You write no lane code; every task still goes through `tdd` via the lane's `task-runner` loop.

One lane = one subagent = one ordered task list = one set of paths nobody else touches. That isolation is the whole safety model. If the plan cannot be cut into clean lanes, say so instead of forcing it.

## Redirect

- Plan is one sequential dependency chain with heavy file overlap → do not spawn; run the sequential loop in `SKILL.md`.
- No plan → `task-planner`. Requirements fuzzy → `grill-with-docs`.

## 1. Confirm inputs

Read `docs/TASKS.md` and the in-scope `docs/tasks/T*.md`; for a multi-repo change, the plan in each repo. From each task file take **id**, **Affected Files / Areas**, **Dependencies**; from the index take **Status** and **Execution Order**. Only `planned`/`ready` tasks are in scope unless the user names others. If tasks lack paths or dependencies, return to `task-planner`.

Ask for the lane count if not given (default 2).

Completion criterion: every in-scope task has a known id, path set, and dependency list.

## 2. Partition into lanes

- A lane is an ordered chain; same-lane tasks may share files and depend on each other freely.
- Tasks in **different** lanes must not modify the same file or have a dependency edge live while both lanes run.
- A cross-lane dependency is a **sync point**: the downstream task pauses until you release it after the upstream task is done. A lane that is mostly waiting is not a lane.
- Tasks the plan says must land together stay in one lane, adjacent.

Report the partition: lane count, ordered tasks per lane, every sync point, honest parallelism. If the graph supports fewer lanes than requested, propose that number; if one, run sequentially. Get the user's explicit approval before spawning.

Completion criterion: each task sits in exactly one lane; no two lanes share a path; every cross-lane edge is a listed sync point; the user approved.

## 3. Write a lane brief per lane

One file per lane: `docs/task-runs/<feature>-lane-<n>.md`, stating:

- the ordered task ids the lane owns, one-line objective each;
- the repo / directory it works in;
- **the path boundary** — "modify only these files/dirs; if a task needs a file outside them, stop and report";
- each sync point — "before `<task-id>`, stop and wait for the orchestrator's go";
- the loop — "for each task in order, run `task-runner` in **lane mode** for that task";
- stop conditions — report when the list is finished or a task is `blocked`; never continue past `blocked`.

Completion criterion: one brief per lane, each naming its tasks, path boundary, sync points, and stop conditions.

## 4. Dispatch

Spawn one subagent per lane with the Agent tool, `subagent_type: fork`. Pass the brief path and: "execute the lane directly — do not spawn further subagents; work in your lane only." They run in the background.

If the user wants each lane isolated, pass `isolation: "worktree"`. A worktree only sees committed files, so commit the briefs first (or paste each brief into the prompt), and merge the lane branches back one at a time in step 6.

Completion criterion: one running subagent per lane, each pointed at its brief.

## 5. Orchestrate

Lanes never edit `docs/TASKS.md`; you own the index, so concurrent lanes never race on it. Commit your index updates yourself, on the integration branch.

- Wait for lane notifications. Never report progress you have not been told — if asked, say the lane is still running.
- Set a task's row to `in_progress` when its lane starts it.
- When a task finishes, set its row's **Status** and link its `task-runs/T<n>-CONTEXT.md` and `task-runs/T<n>-summary.md`.
- At a sync point, confirm the upstream summary exists and checks are green, then release the waiting lane (`SendMessage` it, or spawn a follow-up subagent).
- A lane reports `blocked`: decide with the user — hand its remaining tasks to another lane, or hold.
- Keep `docs/task-runs/<feature>-dispatch.md`: task, lane, state.

Completion criterion: every lane reported done or blocked; every sync point released or recorded as blocking; every finished task's index row shows its status and run links.

## 6. Integrate and report

Run the full typecheck + lint + test suite in each affected repo. Resolve friction between lanes (near-zero if the partition held); merge lane branches if used. Report lanes run, tasks completed, blocked, remaining, and the next runnable task.

Completion criterion: full suite green in each repo; report names completed, blocked, and remaining tasks.

## Rules

- Never spawn more lanes than the partition supports; lanes never share a file.
- Commit per task, not per lane.
- No lane continues past `blocked` without a decision.
- Never fabricate a pending lane's result.
