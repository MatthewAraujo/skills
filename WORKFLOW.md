# AI Engineering Workflow

This document defines how the agent must operate when using AI work skills.

## Core Principle

The agent must behave as a structured engineering workflow, not as an improvisational coding assistant.

Every meaningful implementation should move through four skill stages:

`grill-with-docs → to-prd → task-planner → tdd`

The purpose of this workflow is to separate discovery, specification, implementation planning, and test-driven execution.

Project memory must be loaded before those stages when available:

`PROJECT.md → CONTEXT.md → grill-with-docs → to-prd → task-planner → tdd`

---

## Project Memory Artifacts

The workflow may use two root-level memory files:

- `PROJECT.md`
- `CONTEXT.md`

They are complementary and must not duplicate the same information.

### `PROJECT.md`

`PROJECT.md` is the stable project handbook.

It should answer:

**What is this project and how do I work on it?**

Use it for:

- project overview and purpose;
- tech stack, frameworks, runtime, database, cache, queue, and external services;
- repository structure and important directories;
- setup, build, run, lint, test, and migration commands;
- environment variable patterns and secret handling expectations;
- development conventions;
- CI/CD and quality gates;
- deployment notes;
- stable links to PRDs, task plans, ADRs, glossary, and other documentation.

`PROJECT.md` should stay concise, operational, and current.

### `CONTEXT.md`

`CONTEXT.md` is the evolving project memory.

It should answer:

**What do we know, what have we decided, and what should future work remember?**

Use it for:

- accumulated project understanding;
- domain rules, business constraints, invariants, and edge cases;
- decisions and rationale that are not formalized as ADRs;
- rejected alternatives and trade-offs;
- implementation discoveries;
- fragile areas;
- known risks and technical debt;
- open questions and assumptions.

`CONTEXT.md` can be created or updated by `grill-with-docs`, but it is not limited to the current task or session. It may be reused across future work.

### Duplication Rule

Do not store the same content in both files.

When information appears relevant to both files:

- keep the detailed reasoning, risk, and historical context in `CONTEXT.md`;
- add only the short operational summary or pointer in `PROJECT.md`.

Examples:

- Test command belongs in `PROJECT.md`.
- Why a specific test strategy was chosen belongs in `CONTEXT.md`.
- Tech stack belongs in `PROJECT.md`.
- Rationale for choosing that stack belongs in `CONTEXT.md` or an ADR.
- A stable setup command belongs in `PROJECT.md`.
- A fragile implementation discovery belongs in `CONTEXT.md`.

---

## Planning Artifacts

The workflow uses two planning artifacts after discovery:

- `docs/PRD.md`
- `docs/TASKS.md` or `docs/tasks/<feature>.md`

### `docs/PRD.md`

`docs/PRD.md` defines accepted product or behavior requirements.

It should answer:

**What must be true when this work is done?**

Use it for:

- problem statement;
- goals;
- non-goals;
- users or actors;
- functional requirements;
- non-functional requirements;
- acceptance criteria;
- edge cases;
- constraints;
- validation expectations.

### `docs/TASKS.md` or `docs/tasks/<feature>.md`

The task plan defines how the PRD becomes implementation work.

It should answer:

**How should this be implemented safely, incrementally, and test-first?**

Use it for:

- acceptance criteria mapping;
- task breakdown;
- affected files and areas;
- test-first plan;
- dependencies and execution order;
- risk plan;
- completion signals;
- handoff to `tdd`.

Do not put product requirements that belong in the PRD only in the task plan. Do not put low-level implementation tasks in the PRD unless they are necessary constraints.

---

## Skill Definitions

### `grill-with-docs`

A relentless interview used to sharpen the plan or design before PRD synthesis.

Use it to:

- clarify goals, constraints, and success criteria;
- challenge assumptions;
- identify edge cases;
- define domain vocabulary;
- create or update `CONTEXT.md` with reusable project memory;
- create or update ADRs;
- create or update glossary entries;
- decide whether the task is ready for PRD synthesis.

This phase is complete only when the relevant decisions are explicit enough to synthesize a PRD.

### `to-prd`

A synthesis skill that turns the current conversation and supporting docs into `docs/PRD.md`.

Use it to:

- consolidate already-discussed requirements;
- use `PROJECT.md` for stable project constraints when available;
- use `CONTEXT.md` for relevant accumulated project memory when available;
- define scope and non-scope;
- document user stories or functional requirements;
- define acceptance criteria;
- document technical constraints;
- define validation expectations.

This skill must not restart the interview. It should synthesize what is already known.

### `task-planner`

An implementation planning skill that turns `docs/PRD.md` into a concrete, repository-aware task plan.

Use it to:

- read `PROJECT.md`, `CONTEXT.md`, `docs/PRD.md`, relevant ADRs, glossary entries, existing tests, and relevant project scripts;
- create or update `docs/TASKS.md` or `docs/tasks/<feature>.md`;
- map each PRD acceptance criterion to tasks and tests;
- identify affected files, modules, APIs, database objects, UI surfaces, and integration boundaries;
- define task order, dependencies, risks, and completion signals;
- define the test-first plan for `tdd`;
- decide whether implementation is ready to start.

This skill must not implement code. It exists to make implementation small, viable, and traceable.

If the PRD is missing or insufficient, return to `to-prd` or `grill-with-docs`.

### `tdd`

A test-driven development skill used for implementation and bug fixing.

Use it to:

- read `docs/PRD.md` before coding;
- read `docs/TASKS.md` or `docs/tasks/<feature>.md` before coding when present or required;
- read relevant `PROJECT.md` and `CONTEXT.md` sections before implementation;
- derive tests from the task plan and PRD acceptance criteria;
- write a failing test first when feasible;
- implement the minimum code needed to pass;
- refactor after tests pass;
- add regression tests for bugs;
- run relevant test commands when possible;
- update memory files only when implementation reveals durable project knowledge.

---

## Standard Task Flow

### 1. Start a New Session

For every new feature, refactor, or substantial bug fix:

- start from a fresh task context;
- restate the user's goal;
- avoid carrying hidden assumptions from unrelated work.

---

### 2. Load Project Memory

Before discovery, planning, or implementation:

1. read project-local `AGENTS.md` if it exists and may affect the task;
2. read `PROJECT.md` if it exists;
3. read `CONTEXT.md` if it exists and may affect the task;
4. identify whether prior docs, code, or decisions must also be inspected;
5. summarize only the memory that materially affects the current task.

If `PROJECT.md` is missing and the repository is expected to be reused, propose creating it.
If `CONTEXT.md` is missing and the task produces reusable decisions, risks, or domain knowledge, create it or propose creating it.

---

### 3. Discovery and Design: `grill-with-docs`

The task MUST begin with `grill-with-docs` when requirements are not already fully specified.

During this phase, the agent must produce or update supporting documentation as decisions are made.

Expected artifacts may include:

- `CONTEXT.md` for reusable project memory;
- `docs/adr/NNNN-title.md` for architectural decisions;
- `docs/GLOSSARY.md` for domain vocabulary;
- notes about open questions, constraints, and accepted assumptions.

The agent must not proceed to PRD synthesis while major decisions remain unresolved.

When updating `CONTEXT.md`, prefer structured sections such as:

- current understanding;
- decisions and rationale;
- domain knowledge;
- implementation notes;
- known risks;
- open questions.

---

### 4. PRD Synthesis: `to-prd`

After the plan is sufficiently resolved, use `to-prd`.

The expected output is:

- `docs/PRD.md`

The PRD must include:

- problem statement;
- goals;
- non-goals;
- users or actors;
- functional requirements;
- non-functional requirements, when relevant;
- acceptance criteria;
- edge cases;
- dependencies and constraints;
- validation and test expectations;
- implementation notes only when they are necessary to preserve decisions.

The agent must not add new requirements that were not discussed or accepted.

---

### 5. Implementation Planning: `task-planner`

After `docs/PRD.md` exists and represents the accepted scope, use `task-planner`.

The expected output is one of:

- `docs/TASKS.md`
- `docs/tasks/<feature>.md`

The task plan must include:

- source context;
- implementation goal;
- non-goals;
- acceptance criteria mapping;
- task breakdown;
- test strategy;
- risk plan;
- execution order;
- open questions;
- handoff to `tdd`.

The agent must not proceed to implementation while the task plan contains blocking open questions.

Each task should be small enough to implement and validate independently.

---

### 6. Implementation: `tdd`

Implementation may start only after `docs/PRD.md` exists and the task plan is ready.

The agent must:

- read `docs/PRD.md` before coding;
- read `docs/TASKS.md` or the relevant `docs/tasks/<feature>.md` before coding;
- read relevant `PROJECT.md` and `CONTEXT.md` sections before coding;
- map tasks to tests;
- write or update tests first whenever feasible;
- implement the smallest useful increment;
- run relevant tests;
- refactor only after tests pass;
- keep changes small and reviewable.

Recommended loop:

1. select one task or acceptance criterion;
2. write a failing test;
3. implement the minimum code to pass;
4. run tests;
5. refactor;
6. update the task status or report logical progress;
7. repeat for the next task.

---

### 7. Memory Update Check

Before finishing implementation or documentation work, check whether the task changed durable project knowledge.

Update `PROJECT.md` when stable operational knowledge changed, such as:

- project purpose or scope;
- tech stack;
- setup, run, build, lint, test, or migration commands;
- repository structure;
- environment or secret handling conventions;
- CI/CD or deployment flow;
- stable links to documentation.

Update `CONTEXT.md` when evolving project knowledge changed, such as:

- domain rules;
- business constraints;
- design rationale;
- implementation discoveries;
- known risks;
- technical debt;
- rejected alternatives;
- open questions.

Do not update either file for trivial, temporary, or task-local details that will not help future work.

---

### 8. Validation and Final Report

Before finishing, the agent must validate the work against:

- `docs/PRD.md`;
- `docs/TASKS.md` or the relevant task plan;
- acceptance criteria;
- tests added or updated;
- relevant existing behavior;
- known risks from `CONTEXT.md`, ADRs, or prior discussion;
- project conventions from `PROJECT.md`.

The final report must include:

- what changed;
- which files were affected;
- which tests were added or updated;
- which commands were run;
- whether `PROJECT.md`, `CONTEXT.md`, `docs/PRD.md`, or task plans were updated;
- unresolved risks or follow-up work.

---

## Task Type Rules

### Feature

Required sequence:

`load project memory → grill-with-docs → to-prd → task-planner → tdd → validation report`

### Refactor

Required sequence:

`load project memory → grill-with-docs → to-prd → task-planner → tdd → validation report`

The PRD may be lightweight, but it must define preserved behavior and validation strategy. The task plan must break the refactor into safe, reviewable increments.

### Bug Fix

Default sequence:

`load project memory → grill-with-docs → to-prd → task-planner → tdd → validation report`

Allowed shortcut, only with explicit user approval:

`load project memory → task-planner → tdd → validation report`

The shortcut still requires:

- clear failing behavior;
- expected behavior;
- affected area;
- regression test when feasible;
- final validation;
- memory updates when the bug reveals durable project knowledge.

### Documentation-Only Work

Use `grill-with-docs` if clarification is needed.
Use `to-prd` only when the documentation defines requirements.
Use `task-planner` only when the documentation change requires multi-step execution, migration, or validation planning.
Do not use `tdd` unless executable validation is relevant.

### Review-Only Work

If the user requests only review or feedback:

- load project memory when it may affect the review;
- do not force `to-prd`;
- do not force `task-planner` unless implementation planning is requested;
- inspect the relevant diff, files, or documents;
- report issues, risks, and suggested tests;
- do not implement unless explicitly requested.

---

## Execution Rules

- Never start implementation before the discovery/design phase is resolved, unless the user explicitly requests an approved shortcut.
- Never run `to-prd` as an interview; it is synthesis only.
- Never run `task-planner` as a PRD rewrite; it is implementation decomposition only.
- Never start coding before reading `docs/PRD.md` for feature/refactor work.
- Never start coding before reading the task plan for feature/refactor work.
- Never ignore relevant `PROJECT.md` or `CONTEXT.md` content.
- Never duplicate the same memory in both `PROJECT.md` and `CONTEXT.md`.
- Never implement large changes in one blind pass.
- Never ignore acceptance criteria.
- Prefer small, testable, reversible changes.
- Prefer explicit assumptions over silent guesses.

---

## Documentation Rules

- Store stable project handbook information in root-level `PROJECT.md`.
- Store evolving project memory in root-level `CONTEXT.md`.
- Store product requirements in `docs/PRD.md`.
- Store implementation task plans in `docs/TASKS.md` or `docs/tasks/<feature>.md`.
- Store architectural decisions in `docs/adr/`.
- Store shared vocabulary in `docs/GLOSSARY.md`.
- Keep documentation concise and decision-oriented.
- Update docs when implementation reveals a material change in scope, design, or durable project knowledge.

---

## Testing Rules

During `tdd`, the agent must consider:

- unit tests for isolated logic;
- integration tests for database, API, filesystem, network, or service boundaries;
- regression tests for bug fixes;
- edge cases from the PRD;
- task-specific tests from `docs/TASKS.md` or `docs/tasks/<feature>.md`;
- known risks from `CONTEXT.md`;
- existing test conventions from `PROJECT.md` and repository files.

Tests should be meaningful, not only coverage-oriented.

---

## Commit Strategy

If the environment allows commits and the user has authorized them:

- commit after meaningful, working increments;
- do not commit broken code;
- keep commits atomic and readable;
- use English commit messages;
- do not mix unrelated changes.

If commits are not authorized, report logical commit points in the final summary instead.

---

## Guardrails

The agent MUST pause and confirm before:

- destructive operations;
- force push, reset, or history rewrite;
- deleting files or data;
- changing public APIs in incompatible ways;
- applying broad migrations;
- overwriting unrelated local changes;
- bypassing the required workflow;
- ignoring project memory that is present and relevant to the task;
- skipping `task-planner` for feature/refactor implementation.

---

## Anti-Patterns

Forbidden by default:

- coding without clarified requirements;
- using `to-prd` before the plan is resolved;
- treating `to-prd` as another interview;
- using `task-planner` to invent new requirements;
- using `task-planner` to implement code;
- implementing without reading `docs/PRD.md`;
- implementing without reading the task plan for feature/refactor work;
- ignoring relevant `PROJECT.md` or `CONTEXT.md`;
- duplicating the same content in `PROJECT.md` and `CONTEXT.md`;
- skipping tests during implementation when tests are feasible;
- large unreviewed changes;
- speculative features not present in the PRD;
- ignoring ADRs, glossary decisions, or task-plan constraints.
