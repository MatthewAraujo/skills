---
name: extract-backend-blueprint
description: Analyze a mature reference backend API repository and extract a reusable backend architecture blueprint for future greenfield projects. Use only when the user explicitly wants to turn a specific repository into a reusable reference document.
---

# extract-backend-blueprint

Use this skill when the user explicitly asks to analyze a backend API repository that they consider a high-quality reference and extract a reusable blueprint for future projects.

## Purpose

The goal is not to summarize the repository.

The goal is to reverse-engineer its reusable engineering patterns into a practical backend blueprint covering architecture, testing, dependency injection, SOLID boundaries, code organization, API conventions, persistence, configuration, security, CI/CD, and developer experience.

The resulting document must help an AI agent or developer create a new backend API using the same proven engineering style without blindly copying the original repository.

## Output Location

Create one of the following files:

```text
blueprints/backend/<repo-name>-blueprint.md
```

Preferred example:

```text
blueprints/backend/nestjs-clean-api-blueprint.md
```

If the user explicitly asks for a standalone file, create:

```text
BACKEND_BLUEPRINT.md
```

If the current repository already has a blueprint convention, follow it.

## Required Inputs

Before writing the blueprint, inspect the repository evidence.

Read relevant files such as:

- `README.md`
- `package.json`, `pnpm-lock.yaml`, `yarn.lock`, `package-lock.json`, or equivalent
- framework config files
- `src/` or application source directories
- module/controller/service/repository/use-case files
- dependency injection modules/providers
- DTOs, schemas, validators, pipes, guards, interceptors, middlewares
- database models/entities/migrations/seeds
- test files
- test setup files
- Docker and Docker Compose files
- environment/config files
- CI/CD workflows
- lint/format/typecheck config
- existing docs, ADRs, or architecture notes

Do not rely only on file names. Inspect representative source files and tests.

## Repository Analysis Checklist

Analyze the repository across these dimensions.

### 1. Project Identity

Document:

- what the backend does;
- API style;
- main domain concepts;
- primary users or actors;
- runtime assumptions;
- deployment assumptions.

### 2. Tech Stack

Document:

- language and runtime;
- framework;
- package manager;
- database;
- ORM/query builder;
- cache;
- queue/broker;
- authentication/authorization;
- validation library;
- testing libraries;
- build tooling;
- linting/formatting;
- CI/CD;
- infrastructure tooling.

Separate confirmed evidence from inferred assumptions.

### 3. Repository Structure

Document important folders and their responsibilities.

Look for:

- application entrypoints;
- module boundaries;
- domain/application/infrastructure separation;
- shared/common utilities;
- test structure;
- configuration structure;
- migration structure;
- scripts and automation.

### 4. Architectural Style

Identify the actual architectural style used by the repository.

Examples may include:

- layered architecture;
- clean architecture;
- hexagonal architecture;
- modular monolith;
- controller/service/repository;
- use-case driven architecture;
- domain-driven boundaries;
- ports and adapters.

For each pattern, document:

- where it appears;
- why it matters;
- how to reproduce it in a new project;
- when not to apply it.

Do not claim the repository uses a pattern unless there is visible evidence.

### 5. Dependency Injection

Analyze how dependencies are declared, registered, composed, and replaced.

Document:

- DI container or module system;
- provider registration pattern;
- interface-to-implementation binding;
- service lifetimes or scopes;
- dependency inversion boundaries;
- how dependencies are mocked or replaced in tests;
- anti-patterns to avoid.

### 6. SOLID and Engineering Principles

Tie design principles to concrete repository examples.

Analyze:

- Single Responsibility Principle;
- Open/Closed Principle;
- Liskov Substitution Principle, if relevant;
- Interface Segregation Principle;
- Dependency Inversion Principle;
- KISS;
- YAGNI;
- DRY;
- testability.

Do not write generic textbook definitions. Explain how the repository demonstrates or violates each principle.

### 7. Testing Strategy

Analyze the repository's real testing approach.

Document:

- unit test patterns;
- integration test patterns;
- e2e/API test patterns;
- test database setup;
- fixtures, factories, builders, or seed helpers;
- mocks, stubs, fakes, and dependency overrides;
- authentication setup in tests;
- error scenario testing;
- regression testing style;
- test naming conventions;
- test commands;
- coverage expectations, if present.

Produce a recommended testing pyramid for future projects based on the repository evidence.

### 8. API Design

Analyze:

- route/controller organization;
- request validation;
- response format;
- DTO or schema conventions;
- pagination/filtering/sorting;
- error response shape;
- status code usage;
- auth guards or middleware;
- API versioning;
- OpenAPI/Swagger conventions, if present.

### 9. Data and Persistence

Analyze:

- entity/model structure;
- repository pattern;
- query organization;
- transactions;
- migrations;
- seeds;
- connection management;
- database constraints;
- consistency and concurrency patterns;
- persistence error handling.

### 10. Configuration and Environment

Document:

- environment variables;
- config validation;
- local development setup;
- test environment setup;
- Docker or Docker Compose usage;
- secret handling;
- environment-specific behavior.

### 11. Observability and Operations

Analyze:

- logging;
- metrics;
- tracing;
- health checks;
- readiness/liveness checks;
- error reporting;
- background jobs;
- retries;
- rate limiting;
- operational scripts.

If these are missing, mark them as gaps.

### 12. Security

Analyze:

- authentication;
- authorization;
- input validation;
- token/password handling;
- sensitive data handling;
- CORS;
- security headers;
- SQL injection prevention;
- safe error exposure;
- dependency/security scanning.

### 13. Developer Experience

Document:

- install command;
- run command;
- test commands;
- lint/typecheck commands;
- migration commands;
- formatting commands;
- local setup sequence;
- recommended first-time developer workflow.

### 14. CI/CD and Quality Gates

Analyze:

- GitHub Actions or equivalent CI;
- lint gate;
- typecheck gate;
- test gate;
- build gate;
- coverage gate;
- migration validation;
- deployment pipeline;
- required checks before merge.

### 15. Reusable Project Template

Create a practical section for future greenfield projects.

Include:

- recommended initial folder structure;
- first files to create;
- required dependencies;
- DI setup;
- config setup;
- database setup;
- first endpoint pattern;
- first service/use-case pattern;
- first repository/adapter pattern;
- first unit test pattern;
- first integration/e2e test pattern;
- minimum CI quality gates.

## Required Blueprint Structure

The generated blueprint must use this structure:

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

## Evidence Requirement

Every major recommendation must cite concrete repository evidence.

Use this format:

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

If a practice is not present but would be useful, document it under `Gaps and Recommended Improvements`, not as an existing pattern.

## Output Quality Rules

- Do not modify production code.
- Do not invent repository patterns.
- Do not produce a vague best-practices article.
- Prefer concrete, reusable rules extracted from the repository.
- Distinguish evidence from recommendations.
- Mark weak or missing areas explicitly.
- Keep framework-specific guidance separate from general backend architecture guidance.
- Do not copy business-specific logic into the blueprint unless it demonstrates a reusable engineering pattern.
- Do not include secrets, credentials, internal URLs, or sensitive operational details.
- Do not make the generated blueprint part of the default project workflow.

## Final Response

After generating the blueprint, report:

- output file path;
- repository areas inspected;
- strongest reusable patterns found;
- gaps or weak areas;
- how the user can reuse the blueprint in a future project.

Keep the final response concise and practical.
