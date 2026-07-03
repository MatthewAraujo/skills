---
name: visual-ui-polisher
description: Polish an existing application screen without changing product scope or business logic. Use when the user wants a UI to look better, less generic, more balanced, more premium, or more production-ready, or when another skill needs a visual diagnosis before design-system alignment or frontend implementation planning.
---

# visual-ui-polisher

A polish pass improves perceived quality, hierarchy, and coherence without inventing new product behavior.

Use the broader stage order in [final-flow.md](final-flow.md) when the task spans discovery, system alignment, planning, and QA. Use [visual-polisher.md](visual-polisher.md) as the detailed review checklist during diagnosis.

## Scope Guard

- Preserve accepted product scope, business logic, and critical flows.
- Prefer improvements to hierarchy, spacing, typography, color discipline, density, and component consistency.
- Treat new features, information-architecture changes, and copy rewrites as out of scope unless the user explicitly asks.
- If requirements or intended behavior are unclear, return to `grill-with-docs` before judging the UI.

## Required Inputs

Read only the context needed for the screen:

1. `PROJECT.md`
2. `CONTEXT.md`
3. `docs/PRD.md`
4. `docs/TASKS.md` or relevant task docs
5. `AGENTS.md`
6. the current UI evidence: screenshot, route, component files, or user description
7. the existing design system, theme, tokens, and shared components if they affect the screen

The skill can run from a screenshot alone, but implementation-ready advice requires the relevant frontend code and design-system context.

## Workflow

### 1. Frame the polish target

State:

- what screen or flow is being polished;
- what must remain unchanged;
- what evidence is available;
- whether this run is diagnosis-only or implementation-oriented.

Completion criterion: the screen, constraints, and evidence are explicit.

### 2. Diagnose the visual weaknesses

Review the screen with [visual-polisher.md](visual-polisher.md). Prioritize the few issues most responsible for the UI feeling generic, noisy, unbalanced, cramped, sparse, or unfinished.

For each issue, explain:

- what is wrong;
- where it appears;
- why it hurts perceived quality.

Completion criterion: the major polish blockers are ranked and evidence-backed.

### 3. Turn diagnosis into concrete polish moves

Convert each major issue into a concrete visual change. Prefer specific moves over abstract taste:

- rebalance layout or section grouping;
- tighten or loosen spacing;
- strengthen hierarchy with type scale and weight;
- reduce noisy color usage;
- standardize borders, radius, shadow, and surface treatment;
- improve empty, loading, or dense-data states when they visibly lower quality.

Completion criterion: every major issue has at least one specific UI change that would visibly improve the screen.

### 4. Separate local fixes from reusable system decisions

Identify which recommendations should become shared tokens, component variants, or layout patterns and which should stay local to the screen.

If the broader flow includes `design-system-aligner`, prepare that handoff.
If not, produce the reusable design-system recommendations directly in this run.

Completion criterion: reusable decisions and one-off fixes are clearly separated.

### 5. Prepare implementation guidance

Translate the polish moves into small frontend tasks:

- files or components likely affected;
- layout, CSS, or theme changes;
- reusable component or token changes;
- validation approach, including responsive checks and visual regression risk.

If the broader flow includes `frontend-implementation-planner`, prepare that handoff.
If not, produce implementation-ready tasks directly in this run.

Completion criterion: a frontend engineer could start the work without reinterpreting the visual intent.

### 6. Report the polish pass

Use this output structure:

```md
## Overall visual diagnosis
## Biggest visual problems
## Concrete visual improvements
## Design system recommendations
## Implementation-ready tasks
## Risks and scope guards
```

Completion criterion: the report is actionable, scoped, and aligned with the evidence.

## Rules

- Do not praise the UI without identifying the trade-offs that still matter.
- Do not suggest generic "make it modern" changes without naming the exact visual move.
- Do not expand product scope to solve a visual problem.
- Do not recommend a new design system when local polish or small token cleanup is enough.
- Prefer the smallest set of changes that meaningfully improves perceived quality.
- When the screen already follows strong product constraints, say so and focus only on real polish gaps.
- When downstream skills are unavailable, produce their needed outputs instead of stopping.
