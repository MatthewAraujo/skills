# Frontend Blueprint Areas

Use this reference during step 2 and step 3 of [`SKILL.md`](SKILL.md) when you need area-by-area checks.

## Project Identity

Document:

- what the frontend application does;
- product surface and primary flows;
- main domain concepts visible in the UI;
- primary users or actors;
- runtime assumptions;
- deployment assumptions;
- whether it is SPA, SSR, SSG, hybrid, mobile-first, dashboard, admin panel, public site, or app shell.

## Tech Stack

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

## Repository Structure

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

## Frontend Architectural Style

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

## Routing and Layout Strategy

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

## Component Architecture

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

## State Management

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

## Server State, Data Fetching, and Cache

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

## Forms and Validation

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

## Styling and Design System

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

## Accessibility

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

## Testing Strategy

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

## Performance and Rendering Strategy

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

## Error Handling and Resilience

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

## Security

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

## Configuration and Environment

Document:

- environment variables;
- public vs private env conventions;
- config validation;
- local development setup;
- test environment setup;
- Docker or Compose usage when relevant;
- secret handling;
- environment-specific behavior.

## Developer Experience

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

## CI/CD and Quality Gates

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

## Reusable Starter Patterns

Synthesize the starter patterns that a new frontend project should copy from the repository:

- structure and module boundaries;
- routing and layout conventions;
- state and data-fetching defaults;
- form and validation defaults;
- design-system and styling defaults;
- testing defaults;
- developer workflow and quality gates.
