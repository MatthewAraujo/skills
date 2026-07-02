---
name: extract-frontend-blueprint
description: Extract a reusable frontend blueprint from a specific reference frontend repository. Use when the user wants a greenfield frontend guide from one mature app.
---

# extract-frontend-blueprint

Turn one mature frontend application repository into a reusable greenfield frontend blueprint.

The leading rule is evidence:

- claim only what the repository shows;
- separate confirmed patterns from inference;
- send missing but desirable practices to gaps instead of inventing them;
- keep reusable frontend architecture separate from product-specific UI, branding, and flows.

## Redirect

Do not use this skill:

- for a general repository summary;
- for backend-first repositories;
- when the source repository is not identified;
- when the user wants implementation instead of documentation;
- when the goal is to copy business-specific screens, branding, or copy.

## Output

Write one of:

- `blueprints/frontend/<repo-name>-blueprint.md`
- `FRONTEND_BLUEPRINT.md` when the user explicitly asks for a standalone file

If the repository already has a blueprint convention, follow it.

The generated blueprint is a reference artifact for future greenfield projects.
It is not part of the default project workflow.

## Evidence Loop

### 1. Fix the source and output boundary

Confirm the exact repository being analyzed and the output path to write.

Completion criterion:
The source repository and output file path are both explicit.

### 2. Gather representative evidence

Inspect repository evidence before writing claims.

Typical evidence sources:

- `README.md`
- dependency manifests and lockfiles
- framework and build config
- application entrypoints, routes, layouts, and screens
- components, feature modules, hooks, stores, and client-side services
- design-system, styling, and theme files
- forms, validators, and user-input handling
- tests and test setup files
- Storybook or visual documentation when present
- environment, Docker, and CI/CD files
- architecture docs or ADRs

Do not rely on file names alone.
Inspect representative source files and tests from each claimed area.

When step 2 or 3 needs an area-by-area checklist, load [`AREAS.md`](AREAS.md).

Completion criterion:
Every major section of the future blueprint has concrete evidence or an explicit note that the area is absent or weak.

### 3. Extract reusable patterns

Analyze the repository across the frontend areas in [`AREAS.md`](AREAS.md).

For each pattern you keep, capture:

- where it appears;
- why it matters;
- how to reuse it;
- when not to use it.

Completion criterion:
Each claimed reusable pattern is backed by repository evidence and framed as guidance for a new frontend project.

### 4. Separate patterns from gaps

When the repository lacks something important, record it under gaps or recommended improvements.

Do not present missing practices as existing patterns.

Completion criterion:
The blueprint never confuses observed behavior with suggested improvements.

### 5. Write the blueprint

Use this structure:

```md
# Frontend Blueprint: <Repository or Architecture Name>

## 1. Purpose

## 2. Source Repository

## 3. Tech Stack

## 4. Repository Structure

## 5. Frontend Architectural Style

## 6. Routing and Layout Strategy

## 7. Component Architecture

## 8. State Management

## 9. Server State, Data Fetching, and Cache

## 10. Forms and Validation

## 11. Styling and Design System

## 12. Accessibility

## 13. Testing Strategy

## 14. Performance and Rendering Strategy

## 15. Error Handling and Resilience

## 16. Security

## 17. Configuration and Environment

## 18. Developer Experience

## 19. CI/CD and Quality Gates

## 20. Reusable Patterns

## 21. Anti-Patterns to Avoid

## 22. Greenfield Frontend Starter Guide

## 23. Evidence Matrix

## 24. Gaps and Recommended Improvements
```

Use this pattern format for major reusable findings:

```md
### Pattern: <pattern name>

Evidence:
- `<file path>`
- `<file path>`

Why it matters:
<explanation>

How to reuse:
<instructions for future projects>

When not to use:
<constraints or caveats>
```

Completion criterion:
The written blueprint is reusable for greenfield frontend work without rereading the source repository.

### 6. Close with practical guidance

In the final response, report:

- the output file path;
- the repository areas inspected;
- the strongest reusable frontend patterns found;
- the weakest areas or gaps;
- how the user should reuse the blueprint in a future frontend project.

Completion criterion:
The user can act on the blueprint immediately.

## Guardrails

- do not modify production code;
- do not produce a generic best-practices article;
- keep framework-specific guidance separate from general frontend architecture guidance;
- do not include business-specific UI, branding, copy, or product flows unless they demonstrate a reusable engineering pattern;
- do not include secrets, credentials, internal URLs, or sensitive operational details;
- do not claim accessibility, testing, performance, or security maturity without repository evidence;
- mark missing but desirable practices under gaps and recommended improvements.
