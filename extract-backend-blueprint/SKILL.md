---
name: extract-backend-blueprint
description: Extract a reusable backend blueprint from a specific reference API repository. Use when the user wants to turn one backend repo into a greenfield architecture guide.
---

# extract-backend-blueprint

Use this skill to reverse-engineer one mature backend repository into a reusable blueprint for future greenfield projects.

The job is not to summarize the repository.
The job is to turn repository evidence into reusable engineering guidance without copying business-specific code.

The leading rule is evidence:

- claim only what the repository shows;
- separate confirmed patterns from inference;
- send missing but desirable practices to a gaps section instead of inventing them.

## Use

Use this skill when the user explicitly wants to analyze a specific backend API repository and keep the result as a reusable architecture reference.

## Redirect

Do not use this skill:

- for a general repo summary;
- for frontend or mixed-product design work that is not primarily backend;
- when the source repository is not identified;
- when the user wants implementation instead of documentation.

## Output

Write one of:

- `blueprints/backend/<repo-name>-blueprint.md`
- `BACKEND_BLUEPRINT.md` when the user explicitly asks for a standalone file

If the repository already has a blueprint convention, follow it.

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
- `src/` or equivalent application code
- controllers, services, repositories, use cases, and modules
- DTOs, schemas, validators, guards, interceptors, middlewares
- entities, models, migrations, seeds, and persistence setup
- tests and test setup files
- Docker and Compose files
- environment and config files
- CI/CD workflows
- lint, format, and typecheck config
- architecture docs or ADRs

Do not rely on file names alone.
Inspect representative source files and tests from each claimed area.

Completion criterion:
Every major section of the future blueprint has concrete evidence or an explicit note that the area is absent or weak.

### 3. Extract reusable patterns

Analyze the repository across these dimensions:

1. project identity
2. tech stack
3. repository structure
4. architectural style
5. dependency injection
6. SOLID and engineering principles
7. testing strategy
8. API design
9. data and persistence
10. configuration and environment
11. observability and operations
12. security
13. developer experience
14. CI/CD and quality gates
15. reusable starter patterns

For each pattern you keep, capture:

- where it appears;
- why it matters;
- how to reuse it;
- when not to use it.

Completion criterion:
Each claimed reusable pattern is backed by repository evidence and framed as guidance for a new project.

### 4. Separate patterns from gaps

When the repository lacks something important, record it under gaps or recommended improvements.

Do not present missing practices as existing patterns.

Completion criterion:
The blueprint never confuses observed behavior with suggested improvements.

### 5. Write the blueprint

Use this structure:

```md
# Backend Blueprint: <Repository or Architecture Name>

## 1. Purpose

## 2. Source Repository

## 3. Tech Stack

## 4. Repository Structure

## 5. Architectural Style

## 6. Dependency Injection

## 7. SOLID and Engineering Principles

## 8. Testing Strategy

## 9. API Design

## 10. Data and Persistence

## 11. Configuration and Environment

## 12. Observability and Operations

## 13. Security

## 14. Developer Experience

## 15. CI/CD and Quality Gates

## 16. Reusable Patterns

## 17. Anti-Patterns to Avoid

## 18. Greenfield Backend Starter Guide

## 19. Evidence Matrix

## 20. Gaps and Recommended Improvements
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
The written blueprint is reusable for greenfield work without rereading the source repository.

### 6. Close with practical guidance

In the final response, report:

- the output file path;
- the repository areas inspected;
- the strongest reusable patterns found;
- the weakest areas or gaps;
- how the user should reuse the blueprint in a future project.

Completion criterion:
The user can act on the blueprint immediately.

## Analysis Notes

### Project Identity

Document:

- what the backend does;
- API style;
- main domain concepts;
- primary users or actors;
- runtime assumptions;
- deployment assumptions.

### Tech Stack

Document:

- language and runtime;
- framework;
- package manager;
- database;
- ORM or query builder;
- cache;
- queue or broker;
- authn and authz tooling;
- validation library;
- testing libraries;
- build tooling;
- linting and formatting;
- CI/CD;
- infrastructure tooling.

Separate confirmed evidence from inference.

### Dependency Injection

Analyze:

- container or module system;
- provider registration pattern;
- interface-to-implementation binding;
- service lifetimes or scopes when relevant;
- dependency inversion boundaries;
- how tests replace dependencies;
- anti-patterns to avoid.

### SOLID and Engineering Principles

Tie principles to repository evidence.

Do not write textbook definitions.
Explain how the repository demonstrates or violates:

- SRP;
- OCP;
- LSP when relevant;
- ISP;
- DIP;
- KISS;
- YAGNI;
- DRY;
- testability.

### Testing Strategy

Analyze the real testing approach:

- unit tests;
- integration tests;
- e2e or API tests;
- test database setup;
- fixtures, factories, builders, or seed helpers;
- mocks, stubs, fakes, and dependency overrides;
- auth setup in tests;
- error-path coverage;
- regression style;
- naming conventions;
- commands;
- coverage expectations when present.

Recommend a testing pyramid based on the evidence.

### API Design

Analyze:

- route and controller organization;
- request validation;
- response shape;
- DTO or schema conventions;
- pagination, filtering, and sorting;
- error responses;
- status code usage;
- auth guards or middleware;
- versioning;
- OpenAPI or Swagger when present.

### Data and Persistence

Analyze:

- entity and model structure;
- repository pattern;
- query organization;
- transactions;
- migrations;
- seeds;
- connection management;
- database constraints;
- consistency and concurrency patterns;
- persistence error handling.

### Configuration and Environment

Document:

- environment variables;
- config validation;
- local development setup;
- test environment setup;
- Docker or Compose usage;
- secret handling;
- environment-specific behavior.

### Observability and Operations

Analyze:

- logging;
- metrics;
- tracing;
- health checks;
- readiness and liveness checks;
- error reporting;
- background jobs;
- retries;
- rate limiting;
- operational scripts.

Mark missing operational practices as gaps.

### Security

Analyze:

- authentication;
- authorization;
- input validation;
- token and password handling;
- sensitive data handling;
- CORS;
- security headers;
- SQL injection prevention;
- safe error exposure;
- dependency or security scanning.

### Developer Experience

Document:

- install command;
- run command;
- test commands;
- lint and typecheck commands;
- migration commands;
- formatting commands;
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
- migration validation;
- deployment pipeline;
- required checks before merge.

## Rules

- do not modify production code;
- do not invent repository patterns;
- do not produce a vague best-practices article;
- prefer concrete, reusable rules extracted from the repository;
- distinguish evidence from recommendations;
- keep framework-specific guidance separate from general backend guidance;
- do not copy business-specific logic unless it demonstrates a reusable engineering pattern;
- do not include secrets, credentials, internal URLs, or sensitive operational details;
- do not make the generated blueprint part of the default project workflow.
