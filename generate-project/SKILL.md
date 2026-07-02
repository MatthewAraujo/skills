---
name: generate-project
description: Generate a new project skeleton from docs/PRD.md, the task plan, and an optional blueprint. Use when the user wants to bootstrap a new codebase before feature implementation starts.
---

# generate-project

Use this skill to create the first usable foundation of a new project from approved planning artifacts.

The job is to generate the smallest production-oriented skeleton that the task plan needs so implementation can continue through `tdd`.

This skill creates the foundation only.
It does not implement product features.
It does not replace `task-planner` or `tdd`.

## Use

Use this skill when:

- the user wants a new project bootstrapped from approved repository artifacts;
- `docs/PRD.md` and a task plan already define the scope;
- a backend or frontend blueprint should shape the architecture;
- the next useful step is creating the initial repository structure, tooling, test harness, and project docs.

## Redirect

Do not use this skill:

- for feature work inside an existing project;
- before requirements are approved;
- before a task plan exists;
- to clone a reference repository verbatim;
- to generate speculative modules, infrastructure, or features outside the approved scope.

If `docs/PRD.md` is missing, return to `to-prd`.

If the task plan is missing, return to `task-planner`.

If the target directory already contains a meaningful project, stop and ask whether to generate in a new location or adapt to the existing codebase.

## Inputs

Read these inputs in order when they exist:

1. `docs/PRD.md`
2. `docs/TASKS.md`
3. `docs/tasks/*.md`
4. `PROJECT.md`
5. `CONTEXT.md`
6. `docs/adr/*.md`
7. `docs/GLOSSARY.md`

`docs/PRD.md` is mandatory.

An existing task plan is mandatory because it defines the boundary for the generated foundation.

## Optional Blueprint Inputs

Load these only when relevant:

- `blueprints/backend/*.md`
- `blueprints/frontend/*.md`
- existing local conventions in adjacent generated projects
- explicit stack constraints from the user

When a blueprint is present, treat it as the primary architecture reference.
Use it to shape the foundation, not to expand scope.

## Foundation Loop

### 1. Load the approved boundary

Read the PRD, task plan, and the smallest amount of project memory needed to understand what the new project must support first.

Completion criterion:
You can name the project type, selected stack, baseline runtime/tooling, and the first planned implementation tasks the foundation must enable.

### 2. Check generation safety

Confirm the target location is safe to generate into.

Stop if:

- generation would overwrite a meaningful existing project;
- the stack is still ambiguous;
- the task plan is too vague to define a minimal skeleton.

Completion criterion:
The generation target and safety boundary are explicit.

### 3. Design the minimal foundation

Choose the smallest production-oriented structure that supports the approved scope.

Decide only what is needed now:

- runtime and package manager;
- framework and entrypoint shape;
- folder structure;
- configuration loading;
- validation approach;
- dependency injection approach when relevant;
- test harness;
- lint, format, and typecheck tooling when relevant;
- baseline operational files such as Docker or Compose only when the scope actually needs them.

Completion criterion:
You can list the files and directories to create and explain why each one exists.

### 4. Generate the foundation

Create only the files needed to bootstrap the project safely.

Typical baseline files include:

- dependency manifest files;
- framework and tool configuration;
- source directory skeleton;
- application entrypoint;
- health check or equivalent baseline behavior;
- configuration module or loader;
- validation setup;
- dependency injection setup when relevant;
- test setup;
- one example unit test;
- one example integration or e2e test when relevant;
- environment example file.

Prefer explicit structure over hidden code generation magic.

Do not generate large unused modules, speculative abstractions, or features from later tasks.

Completion criterion:
The repository contains a coherent starter structure with no speculative code outside the approved foundation.

### 5. Document and validate

Generate or update the docs that make the foundation usable.

At minimum, create or update:

- `README.md`;
- `PROJECT.md` when the project should have a stable handbook;
- an initial ADR when the generated architecture introduces a durable decision.

Documentation should cover:

- install steps;
- run commands;
- test commands;
- lint, format, and typecheck commands when present;
- environment variable expectations;
- a short structure overview;
- how work continues from the task plan.

Validate that the structure matches the PRD, the task plan, and the blueprint when present.
If a full test or runtime setup cannot yet be executed, document the gap explicitly.

Completion criterion:
A new contributor can see how to install, run, test, and continue the project from the generated docs.

### 6. Hand off to `tdd`

End with a direct handoff to implementation.

Use language like:

```txt
Ready for `tdd`.

Start with the first task in the task plan.
Write the failing test first, then implement the minimum code needed to pass.
```

Completion criterion:
The first implementation task and the first test-first move are clear.

## Blueprint Rules

If a blueprint is provided:

- read it before generating files;
- extract only the parts relevant to the selected stack and current scope;
- adapt its architecture patterns to the new project;
- preserve useful conventions around structure, validation, persistence, testing, configuration, observability, CI/CD, and documentation;
- do not copy domain-specific code or irrelevant modules.

The blueprint is guidance, not a template dump.

## Safety Rules

- do not overwrite an existing project without explicit user confirmation;
- do not delete existing files;
- do not generate secrets;
- do not hardcode credentials;
- do not install dependencies without user approval;
- do not run destructive commands;
- do not generate large unused modules;
- do not implement features beyond the approved PRD;
- do not skip test setup;
- do not skip documentation.

## Checklist

Before finishing, verify:

- the generated project matches the PRD;
- the generated structure matches the task plan boundary;
- the blueprint was followed where relevant;
- install, run, and test instructions exist;
- baseline test setup exists;
- a health check or equivalent baseline behavior exists when relevant;
- environment variable documentation exists;
- no secrets were generated;
- no speculative features were added;
- the next `tdd` step is explicit.
