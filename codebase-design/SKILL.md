---
name: extract-frontend-blueprint
description: Extract a reusable frontend blueprint from a specific reference frontend application repository. Use when the user wants to turn one mature frontend repo into a greenfield architecture, UI, testing, and developer-experience guide.
---

# extract-frontend-blueprint

Use this skill to reverse-engineer one mature frontend application repository into a reusable blueprint for future greenfield frontend projects.

The job is not to summarize the repository.
The job is to turn repository evidence into reusable frontend engineering guidance without copying business-specific UI, branding, or product logic.

The leading rule is evidence:

- claim only what the repository shows;
- separate confirmed patterns from inference;
- send missing but desirable practices to a gaps section instead of inventing them;
- distinguish reusable frontend architecture from product-specific implementation.

## Use

Use this skill when the user explicitly wants to analyze a specific frontend application repository and keep the result as a reusable architecture reference.

Typical use cases:

- extracting a React, Next.js, Vue, Nuxt, Svelte, Angular, or mobile-web frontend blueprint;
- documenting component architecture and UI patterns from a reference app;
- capturing testing, state management, routing, forms, accessibility, and design-system conventions;
- creating a reusable starting guide for future frontend applications.

## Redirect

Do not use this skill:

- for a general repository summary;
- for backend-only API repositories;
- for mixed-product design work where the frontend is not the primary target;
- when the source repository is not identified;
- when the user wants implementation instead of documentation;
- when the user wants to copy visual design or business-specific screens directly.

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
- framework config files
- `src/`, `app/`, `pages/`, `routes/`, or equivalent application code
- routing and layout files
- components and feature modules
- hooks, composables, stores, services, and client-side data access
- API clients, query/cache layers, and generated clients
- design-system files, themes, tokens, style config, and component primitives
- form schemas, validators, and user-input handling
- tests and test setup files
- Storybook or visual documentation files
- Docker and Compose files when relevant
- environment and config files
- CI/CD workflows
- lint, format, typecheck, and build config
- architecture docs or ADRs

Do not rely on file names alone.
Inspect representative source files, screens, components, tests, and config from each claimed area.

Completion criterion:
Every major section of the future blueprint has concrete evidence or an explicit note that the area is absent or weak.

### 3. Extract reusable patterns

Analyze the repository across these dimensions:

1. project identity
2. tech stack
3. repository structure
4. frontend architectural style
5. routing and layout strategy
6. component architecture
7. state management
8. server state, data fetching, and cache
9. forms and validation
10. styling and design system
11. accessibility
12. testing strategy
13. performance and rendering strategy
14. error handling and resilience
15. security
16. configuration and environment
17. developer experience
18. CI/CD and quality gates
19. reusable starter patterns

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

## Analysis Notes

### Project Identity

Document:

- what the frontend application does;
- product surface and primary flows;
- main domain concepts visible in the UI;
- primary users or actors;
- runtime assumptions;
- deployment assumptions;
- whether it is SPA, SSR, SSG, hybrid, mobile-first, dashboard, admin panel, public site, or app shell.

### Tech Stack

Document:

- language and runtime;
- framework;
- router;
- package manager;
- build tool or meta-framework;
- styling system;
- component library;
- state management library;
- data fetching and cache library;
- form library;
- validation library;
- testing libraries;
- visual testing or Storybook tooling;
- linting and formatting;
- CI/CD;
- deployment target.

Separate confirmed evidence from inference.

### Repository Structure

Analyze:

- app entrypoints;
- route organization;
- layout organization;
- feature folders;
- shared component folders;
- design-system folders;
- hooks, utilities, services, and API client placement;
- generated code;
- test placement;
- config placement;
- public/static assets;
- environment files.

Explain which parts are reusable and which are product-specific.

### Frontend Architectural Style

Identify whether the repository uses:

- feature-based architecture;
- layered frontend architecture;
- atomic design;
- design-system-first architecture;
- route-driven architecture;
- app-shell architecture;
- microfrontend patterns;
- server/client component separation;
- container/presenter separation;
- smart/dumb component boundaries;
- colocated components, tests, and styles.

For each confirmed pattern, document evidence and reuse guidance.

### Routing and Layout Strategy

Analyze:

- route definitions;
- nested layouts;
- protected routes;
- public/private sections;
- loading states;
- error boundaries;
- not-found pages;
- metadata/head handling;
- route params and query params;
- navigation patterns;
- breadcrumb patterns.

### Component Architecture

Analyze:

- component layering;
- reusable primitives;
- composed feature components;
- page/screen components;
- naming conventions;
- prop conventions;
- composition patterns;
- slot/render-prop patterns when present;
- separation between UI and business logic;
- colocated styles and tests;
- component documentation.

### State Management

Analyze:

- local component state;
- shared client state;
- server state;
- global stores;
- URL state;
- persisted state;
- derived state;
- state normalization;
- optimistic updates;
- invalidation strategy;
- anti-patterns such as duplicated server state.

### Server State, Data Fetching, and Cache

Analyze:

- API client structure;
- fetch wrappers;
- generated clients;
- query hooks;
- cache keys;
- invalidation;
- mutation patterns;
- loading states;
- error states;
- retry behavior;
- pagination, filtering, sorting;
- real-time updates when present;
- SSR/SSG data loading when relevant.

### Forms and Validation

Analyze:

- form library usage;
- schema validation;
- field components;
- error presentation;
- async validation;
- submit lifecycle;
- dirty/touched state handling;
- default values;
- form composition;
- accessibility of form errors.

### Styling and Design System

Analyze:

- styling approach;
- tokens;
- theme system;
- color, spacing, typography, radius, and shadow conventions;
- responsive design;
- component variants;
- dark mode;
- CSS architecture;
- utility classes;
- design-system boundaries;
- third-party component library usage;
- icon system.

Mark visual branding as product-specific unless it demonstrates a reusable engineering pattern.

### Accessibility

Analyze:

- semantic HTML;
- keyboard navigation;
- focus management;
- aria usage;
- form labels and descriptions;
- dialogs, menus, and popovers;
- color contrast practices;
- screen-reader behavior when evident;
- automated accessibility checks when present.

Mark missing accessibility practice as a gap.

### Testing Strategy

Analyze the real testing approach:

- unit tests;
- component tests;
- integration tests;
- e2e tests;
- visual regression tests;
- accessibility tests;
- test setup;
- mocks, stubs, fakes, and network handlers;
- fixtures and builders;
- routing tests;
- data-fetching tests;
- form tests;
- error-state tests;
- regression style;
- naming conventions;
- commands;
- coverage expectations when present.

Recommend a frontend testing pyramid based on the evidence.

### Performance and Rendering Strategy

Analyze:

- SSR, SSG, ISR, SPA, or hybrid rendering;
- code splitting;
- lazy loading;
- suspense/loading boundaries;
- image optimization;
- bundle analysis;
- memoization;
- virtualization;
- cache strategy;
- prefetching;
- performance budgets;
- Core Web Vitals practices when present.

### Error Handling and Resilience

Analyze:

- error boundaries;
- not-found handling;
- empty states;
- loading states;
- retry UI;
- toast/notification patterns;
- API error mapping;
- offline behavior when present;
- graceful degradation.

### Security

Analyze:

- authentication handling;
- authorization gates;
- token storage;
- sensitive data exposure;
- XSS prevention;
- HTML sanitization;
- CORS assumptions;
- CSRF considerations;
- safe redirect handling;
- dependency or security scanning;
- environment variable exposure rules.

### Configuration and Environment

Document:

- environment variables;
- public vs private env conventions;
- config validation;
- local development setup;
- test environment setup;
- Docker or Compose usage when relevant;
- secret handling;
- environment-specific behavior.

### Developer Experience

Document:

- install command;
- dev command;
- build command;
- preview/start command;
- test commands;
- lint and typecheck commands;
- formatting commands;
- Storybook commands when present;
- local setup sequence;
- recommended first-time developer workflow.

### CI/CD and Quality Gates

Analyze:

- GitHub Actions or equivalent CI;
- lint gates;
- typecheck gates;
- test gates;
- build gates;
- coverage gates;
- visual regression gates;
- accessibility gates;
- deployment pipeline;
- required checks before merge.

## Rules

- do not modify production code;
- do not invent repository patterns;
- do not produce a vague best-practices article;
- prefer concrete, reusable rules extracted from the repository;
- distinguish evidence from recommendations;
- keep framework-specific guidance separate from general frontend architecture guidance;
- do not copy business-specific UI, branding, copy, or product flows unless they demonstrate a reusable engineering pattern;
- do not include secrets, credentials, internal URLs, or sensitive operational details;
- do not make the generated blueprint part of the default project workflow;
- do not claim accessibility, testing, performance, or security maturity without repository evidence;
- mark missing but desirable practices under gaps and recommended improvements.
