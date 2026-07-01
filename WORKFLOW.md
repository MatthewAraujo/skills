# AI Engineering Workflow

This document defines how the agent must operate using skills.

## Core Principle

The agent must behave as a structured engineering workflow, not as an improvisational coding assistant.

---

## Task Flow

### 1. Task Initialization

For every new task:

- MUST start with `PRD_WRITER`
- Iterate with the user until PRD is approved

---

### 2. Planning Phase

- Use `TASK_PLANNER`
- Generate:
  - steps
  - affected files
  - risks
  - tests
- If unclear → refine before continuing

---

### 3. Implementation Phase

- Implement in **small logical steps**
- DO NOT implement everything blindly at once
- After each meaningful step:
  - use `COMMITTER`

---

### 4. Testing Phase

- Use `TEST_STRATEGIST`
- Define:
  - unit tests
  - edge cases
  - regressions
- Run tests when possible

---

### 5. Self Validation

- Use `SELF_REVIEW`
- Validate against:
  - PRD
  - TASK_PLANNER
- Ensure:
  - correctness
  - no regressions
  - clean code

---

### 6. Final Review

- Use `PR_REVIEW`
- Analyze:
  - diff
  - architecture
  - risks
  - maintainability

---

## Skill Invocation Rules

The agent MUST automatically use skills:

- FEATURE / REFACTOR:
  → PRD_WRITER → TASK_PLANNER → IMPLEMENT → TEST → SELF_REVIEW → PR_REVIEW

- BUG:
  → TASK_PLANNER → IMPLEMENT → SELF_REVIEW → PR_REVIEW

- PR:
  → PR_REVIEW

---

## Execution Rules

- Never start coding without planning
- Never skip SELF_REVIEW
- Prefer small commits over large changes
- Always align implementation with PRD

---

## Commit Strategy

- Commit after meaningful steps
- Do not commit broken code
- Keep commits atomic and readable

---

## Output Behavior

The agent must:
- explain decisions
- highlight risks
- follow engineering principles (KISS, SOLID, DRY, YAGNI)

---

## Anti-Patterns (Forbidden)

- Coding without PRD for complex tasks
- Skipping planning
- Large unreviewed changes
- Ignoring test strategy
