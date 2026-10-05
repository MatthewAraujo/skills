---
name: retro
description: "Conduct a retrospective on a coding session."
disable-model-invocation: true
---

The user has asked for a **retrospective**. You are suggesting improvements to the coding agent's **environment** to improve future runs, not to the code.

## Steps

1. Call the Skill tool with "writing-great-skills" for the writing style guide.

2. Read the primary sources for the session the user specifies. This may mean searching session logs on this machine (Claude Code: `~/.claude/projects/`; Codex: `~/.codex/sessions/`). If the user doesn't specify a session, default to the current one.

3. Look for candidates for improvement in these categories.

- **Navigation**: how easy was it for the agent to find the right files? Are there hidden dependencies between files? Would a **navigation pointer** (in `PROJECT.md`, or a skill) make it easier? _Use when_ the session took a long time to find a piece of information.
- **Automated checks**: are there automated checks that could catch errors the agent made? Linting, typing, tests, filesystem linters? Read the repo's own check command first (its `package.json`/build-tool `lint`/`check` scripts, its CI workflow), so a check that already exists but sits unwired or silently broken is the finding, not a reinvention. A repo with no **guardrail** (no pre-commit hook and no CI job running its lint/typecheck/test command) is itself a finding. _Use when_ the agent made a mistake an automated check could have caught, or the repo has no guardrail at all.
- **Coding standards**: should `pr-review` be given a new rule to enforce? Should an existing rule be removed or clarified? Classify the violation first: a **mechanical** one (a fixed syntactic pattern, a banned API, an import shape, a file-location rule) gets a deterministic check: a custom rule in the repo's own linter, a new pre-commit hook, or a new CI job, whichever is cheapest. Default to building the check over writing the rule. Reserve `CODING_STANDARDS.md` for genuine **judgement calls** (cross-file consistency, "matches the surrounding style," anything no guardrail could substitute for). _Use when_ the review failed to catch a mistake.
- **Steering files**: are there instructions in `~/.claude/CLAUDE.md` / `~/.codex/AGENTS.md` or a repo's `CLAUDE.md`/`AGENTS.md` that belong in a skill, in coding standards, or in an automated check instead? _Use when_ a steering file is large.
- **Skills**: did a skill fire when it shouldn't, fail to fire, or send the agent down a wrong path? Is a skill's description (its pointer) too weak, or its body missing a branch the session hit? _Use when_ the session fought the workflow.
- **Project memory**: did the session discover something durable that never reached `CONTEXT.md`, `docs/GLOSSARY.md`, or an ADR, or did stale memory mislead it? _Use when_ the agent relearned or misread something.
- **Tool economy**: did the agent make expensive tool calls that could be streamlined? Is any custom tooling (CLIs, MCPs) particularly token-inefficient? _Use when_ the agent made an expensive tool call.
- **No-ops**: look for instructions in steering files that don't modify the agent's behavior. _Use when_ the steering files are large and unwieldy.
- **Information access**: look for opportunities to increase the agent's access to information: teeing dev server logs, readonly access to third-party services. _Use when_ a crucial piece of information was not available to the agent.

4. Present these candidates to the user, in order of severity, each with the file it would change. Change nothing until the user picks.

## Reference

### Implementation vs review

All work goes through two stages: implementation (`tdd`, via `task-runner`) and review (`pr-review`). The implementation agent has the most **context pressure**: it explores, writes code, and debugs failures. The review agent has the least: it receives a diff, so no exploration is needed.

So the review stage should impose coding standards, not the implementation stage.

### Files

- `~/.claude/CLAUDE.md` / `~/.codex/AGENTS.md` and repo `CLAUDE.md`/`AGENTS.md`: pushed into every session's context. Keep them sparse: routing, guardrails, and **navigation pointers** to other files.
- `PROJECT.md`: stable project handbook. `CONTEXT.md`: evolving project memory. `docs/GLOSSARY.md` and `docs/adr/`: domain language and decisions.
- `CODING_STANDARDS.md`: read during review, not implementation. Add navigation pointers to docs folders if it grows past 1,000 lines.
- Skills: use them for procedures (their description sits in the context window), or for user-invoked commands. Global skills live in `~/.claude/skills/` and are synced to `~/.codex/skills/`.
