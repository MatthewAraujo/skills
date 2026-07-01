---
name: generate-project
description: Generate a new software project from an approved PRD, task plan, and optional architecture blueprint. Use when the user wants to create a new project from scratch using existing workflow artifacts and reference blueprints.
---

# generate-project

Use this skill to generate the first commit of a new project from approved planning artifacts.

The goal is to create a minimal, production-oriented foundation that is ready for implementation through `tdd`.

## When to Use

Use this skill when the user wants to create a new project from scratch and the specification already exists in repository artifacts or in the current conversation.

Typical triggers:

- a new project must be bootstrapped from `docs/PRD.md`;
- a task plan already exists in `docs/TASKS.md` or `docs/tasks/*.md`;
- a backend or frontend blueprint exists and should guide the architecture;
- the user wants the initial structure, tooling, documentation, and test setup generated before feature work starts.

## When Not to Use

Do not use this skill:

- for feature work inside an existing project;
- as a substitute for `tdd`;
- before requirements are approved;
- when `docs/PRD.md` is missing and the conversation does not provide equivalent requirements;
- to clone a reference repository verbatim;
- to generate speculative modules, features, or infrastructure not required by the approved scope.

## Required Inputs

Read the available specification artifacts before generating files.

Inspect these inputs in this order when they exist:

1. `docs/PRD.md`
2. `docs/TASKS.md`
3. `docs/tasks/*.md`
4. `PROJECT.md`
5. `CONTEXT.md`
6. `docs/adr/*.md`
7. `docs/GLOSSARY.md`

`docs/PRD.md` is mandatory unless the user explicitly provides equivalent requirements in the current conversation.

`docs/TASKS.md` or an equivalent task plan is strongly recommended and should be treated as the implementation boundary for the generated skeleton.

Before generating files, identify:

- the target project type;
- the selected stack;
- the baseline runtime and tooling;
- whether the project is backend, frontend, full-stack, CLI, library, or another defined type;
- the smallest viable structure needed to support the approved scope.

## Optional Inputs

Load these inputs when available and relevant:

- `blueprints/backend/*.md`
- `blueprints/frontend/*.md`
- existing repository conventions in adjacent generated projects;
- any user-provided stack constraints from the current conversation

A blueprint is optional, but when one is provided it becomes the primary architecture reference.

Use optional inputs to refine structure and conventions, not to expand scope.

## Generation Flow

Follow this flow:

1. Load specification artifacts
   Read the PRD, task plan, glossary, ADRs, and project memory that define scope and constraints.
2. Load optional blueprint
   Read the relevant backend or frontend blueprint before generating files.
3. Identify target stack and project type
   Confirm the runtime, framework, package manager, testing tools, and project shape.
4. Define minimal project skeleton
   Choose the smallest production-oriented structure that satisfies the PRD and task plan.
5. Generate baseline files
   Create only the files needed to bootstrap the project safely.
6. Add test infrastructure
   Add the initial unit and integration or e2e setup required for `tdd`.
7. Add documentation
   Document install, run, test, configuration, and extension guidance.
8. Validate generated structure
   Check that the generated output matches the PRD, task plan, and blueprint when present.
9. Produce handoff to tdd
   End with a clear next step for feature implementation.

At every step, prefer KISS, YAGNI, DRY, SOLID where useful, testability, explicitness, and incrementality.

## Blueprint Handling

If a blueprint is provided:

1. Read the blueprint before generating files.
2. Treat the blueprint as the primary architecture reference.
3. Extract only the parts that are relevant to the current PRD, task plan, and selected stack.
4. Adapt the blueprint to the new project instead of copying domain-specific code or irrelevant modules.
5. Preserve useful conventions around:
   - folder structure;
   - dependency injection;
   - testing;
   - validation;
   - error handling;
   - persistence;
   - configuration;
   - observability;
   - CI/CD;
   - documentation.

The blueprint is a guide, not a source code template.

Do not blindly copy the reference repository.

## Project Skeleton Requirements

Generate a minimal, production-oriented baseline.

Create only the files required to bootstrap the project and begin implementation safely.

Include relevant foundational files such as:

- package or dependency manifest files;
- framework configuration;
- source directory structure;
- application entrypoint;
- health check endpoint or equivalent baseline behavior;
- configuration module or configuration loading;
- validation setup;
- dependency injection setup when relevant to the stack;
- test setup;
- first example unit test;
- first example integration or e2e test when relevant;
- lint, format, and typecheck configuration;
- Docker or Docker Compose files when relevant;
- environment variable example file.

Prefer clear structure over hidden magic.

Do not generate large unused modules, speculative abstractions, or infrastructure that the PRD does not require.

## Documentation Requirements

Produce documentation that explains how to install, run, test, and extend the generated project.

At minimum, generate or update:

- `README.md`;
- `PROJECT.md` when the generated project should have a stable project handbook;
- an initial ADR when a meaningful architecture decision is made.

Documentation should cover:

- setup and dependency installation steps;
- local run commands;
- test commands;
- lint, format, and typecheck commands when present;
- environment variable expectations;
- a short explanation of the generated structure;
- how future work should continue from the task plan.

## Testing Requirements

Do not skip test setup.

The generated project must be ready for `tdd` from the first commit.

Add:

- the selected test framework and configuration;
- one example unit test;
- one example integration or e2e test when the project type makes that relevant;
- baseline commands or scripts for running tests.

Prefer tests that exercise public behavior and make future tracer-bullet development straightforward.

If a full integration or e2e setup is not yet feasible, generate the safest minimal test infrastructure and document the gap explicitly.

## Safety Rules

- Do not overwrite an existing project unless the user explicitly confirms.
- Do not delete existing files.
- Do not generate secrets.
- Do not hardcode credentials.
- Do not install dependencies without user approval.
- Do not run destructive commands.
- Do not generate large unused modules.
- Do not implement features beyond the approved PRD.
- Do not skip test setup.
- Do not skip documentation.

If the target directory already contains meaningful files, stop and ask whether generation should occur in a new location or be adapted to the existing project.

## Handoff to tdd

End the generation process with an explicit handoff.

Use language like:

Ready for `tdd`.

Start with the first task in `docs/TASKS.md`.
Write the failing test first, then implement the minimum code needed to pass.

This skill creates the foundation only.

Actual feature implementation must continue through `tdd`.

## Quality Checklist

Before finishing, verify:

- the generated project matches the PRD;
- the generated structure follows the blueprint when provided;
- the project has install, run, and test instructions;
- the project has a basic test setup;
- the project has a health check or equivalent baseline behavior;
- the project has environment variable documentation;
- no secrets were generated;
- no speculative features were added;
- the next step for `tdd` is clear.
