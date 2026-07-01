# AI Engineering Workflow

This document defines how the agent must operate when using AI work skills.

## Core Principle

The agent must behave as a structured engineering workflow, not as an improvisational coding assistant.

Every meaningful implementation should move through three stages:

`grill-with-docs → to-prd → tdd`

The purpose of this workflow is to separate thinking, specification, and implementation.

---

## Skill Definitions

### `grill-with-docs`

A relentless interview used to sharpen the plan or design before implementation.

Use it to:

- clarify goals, constraints, and success criteria;
- challenge assumptions;
- identify edge cases;
- define domain vocabulary;
- create or update ADRs;
- create or update glossary entries;
- decide whether the task is ready for PRD synthesis.

This phase is complete only when the relevant decisions are explicit enough to synthesize a PRD.

### `to-prd`

A synthesis skill that turns the current conversation and supporting docs into `docs/PRD.md`.

Use it to:

- consolidate already-discussed requirements;
- define scope and non-scope;
- document user stories or functional requirements;
- define acceptance criteria;
- document technical constraints;
- define validation expectations.

This skill must not restart the interview. It should synthesize what is already known.

### `tdd`

A test-driven development skill used for implementation and bug fixing.

Use it to:

- derive tests from the PRD acceptance criteria;
- write a failing test first when feasible;
- implement the minimum code needed to pass;
- refactor after tests pass;
- add regression tests for bugs;
- run relevant test commands when possible.

---

## Standard Task Flow

### 1. Start a New Session

For every new feature, refactor, or substantial bug fix:

- start from a fresh task context;
- restate the user's goal;
- identify whether existing docs, code, or prior decisions must be inspected;
- avoid carrying hidden assumptions from unrelated work.

---

### 2. Discovery and Design: `grill-with-docs`

The task MUST begin with `grill-with-docs` when requirements are not already fully specified.

During this phase, the agent must produce or update supporting documentation as decisions are made.

Expected artifacts may include:

- `docs/adr/NNNN-title.md` for architectural decisions;
- `docs/GLOSSARY.md` for domain vocabulary;
- notes about open questions, constraints, and accepted assumptions.

The agent must not proceed to PRD synthesis while major decisions remain unresolved.

---

### 3. PRD Synthesis: `to-prd`

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

### 4. Implementation: `tdd`

Implementation may start only after `docs/PRD.md` exists and represents the accepted scope.

The agent must:

- read `docs/PRD.md` before coding;
- map acceptance criteria to tests;
- write or update tests first whenever feasible;
- implement the smallest useful increment;
- run relevant tests;
- refactor only after tests pass;
- keep changes small and reviewable.

Recommended loop:

1. select one acceptance criterion;
2. write a failing test;
3. implement the minimum code to pass;
4. run tests;
5. refactor;
6. repeat for the next criterion.

---

### 5. Validation and Final Report

Before finishing, the agent must validate the work against:

- `docs/PRD.md`;
- acceptance criteria;
- tests added or updated;
- relevant existing behavior;
- known risks from ADRs or prior discussion.

The final report must include:

- what changed;
- which files were affected;
- which tests were added or updated;
- which commands were run;
- unresolved risks or follow-up work.

---

## Task Type Rules

### Feature

Required sequence:

`grill-with-docs → to-prd → tdd → validation report`

### Refactor

Required sequence:

`grill-with-docs → to-prd → tdd → validation report`

The PRD may be lightweight, but it must define preserved behavior and validation strategy.

### Bug Fix

Default sequence:

`grill-with-docs → to-prd → tdd → validation report`

Allowed shortcut, only with explicit user approval:

`tdd → validation report`

The shortcut still requires:

- clear failing behavior;
- a regression test when feasible;
- final validation.

### Documentation-Only Work

Use `grill-with-docs` if clarification is needed.
Use `to-prd` only when the documentation defines requirements.
Do not use `tdd` unless executable validation is relevant.

### Review-Only Work

If the user requests only review or feedback:

- do not force `to-prd`;
- inspect the relevant diff, files, or documents;
- report issues, risks, and suggested tests;
- do not implement unless explicitly requested.

---

## Execution Rules

- Never start implementation before the discovery/design phase is resolved, unless the user explicitly requests an approved shortcut.
- Never run `to-prd` as an interview; it is synthesis only.
- Never start coding before reading `docs/PRD.md` for feature/refactor work.
- Never implement large changes in one blind pass.
- Never ignore acceptance criteria.
- Prefer small, testable, reversible changes.
- Prefer explicit assumptions over silent guesses.

---

## Documentation Rules

- Store product requirements in `docs/PRD.md`.
- Store architectural decisions in `docs/adr/`.
- Store shared vocabulary in `docs/GLOSSARY.md`.
- Keep documentation concise and decision-oriented.
- Update docs when implementation reveals a material change in scope or design.

---

## Testing Rules

During `tdd`, the agent must consider:

- unit tests for isolated logic;
- integration tests for database, API, filesystem, network, or service boundaries;
- regression tests for bug fixes;
- edge cases from the PRD;
- existing test conventions in the repository.

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
- bypassing the required workflow.

---

## Anti-Patterns

Forbidden by default:

- coding without clarified requirements;
- using `to-prd` before the plan is resolved;
- treating `to-prd` as another interview;
- implementing without reading `docs/PRD.md`;
- skipping tests during implementation when tests are feasible;
- large unreviewed changes;
- speculative features not present in the PRD;
- ignoring ADRs or glossary decisions.
