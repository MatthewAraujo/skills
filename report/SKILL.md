---
name: report
description: Write a learning report of what was built, decided and measured in this project, from its tasks and docs.
disable-model-invocation: true
argument-hint: "Scope: whole project, a task range (T6-T10), or a topic (benchmarks, locking)"
---

The user is building this project to **learn**. Write a **report** that lets them understand what happened from start to end, and above all **why**: every decision, alternative, measurement and trade-off, even after the grill and PRD are long forgotten.

A report is a read-only synthesis. Never edit code, tasks, ADRs or `CONTEXT.md`.

## Scope

Take the scope from the argument: the whole project, a task range, or a topic. If none is given, use the whole project. State the scope in the report's first paragraph.

## Evidence

The repository is the only source. Never fill a gap from memory; if the docs don't say why, write "not recorded" and flag it as an open question.

Read, in this order, whatever exists:

1. `PROJECT.md`, `CONTEXT.md`, `docs/PRD.md`: the goal, non-goals, vocabulary.
2. `docs/TASKS.md` and `docs/tasks/*.md`: the plan, dependencies, acceptance criteria and test-first plans.
3. `docs/task-runs/*`: what each task's run actually did. `*-CONTEXT.md` holds the discoveries, `*-summary.md` the outcome.
4. `docs/adr/*`: the formal decisions.
5. `docs/experiments/*`, `docs/benchmark.md`, `docs/reads-sql.md`: measurements, raw numbers, and the SQL itself.
6. `git log` and `git status` for the scope: real order of events, plus work not yet committed. Read the diff of anything the docs describe thinly (migrations, triggers, queries).

## Writing

Follow [REPORT-FORMAT.md](./REPORT-FORMAT.md). The unit of the report is the **decision**: problem, alternatives, choice, why, cost. Tell it chronologically, so the reader sees each decision arrive with the knowledge available at that time, and later reversals or confirmations appear where they happened.

Teach while reporting. Explain each technical concept (a lock, a covering index, keyset pagination, a trigger) in one plain paragraph the first time it appears, then a link to a primary source. Quote real numbers, SQL and file paths rather than paraphrasing them.

Write in the user's language (Portuguese if they wrote to you in Portuguese), keeping code, identifiers and established English terms as they are.

## Output

Write only the **body fragment** (no `<html>`, no CSS) to the scratchpad, using the classes in [REPORT-FORMAT.md](./REPORT-FORMAT.md). Then build the page:

```
python3 ~/.claude/skills/report/assets/build.py "<title>" <body.html> docs/reports/<YYYY-MM-DD>-<dash-case-scope>.html
```

`build.py` pastes `assets/report.css` into the page's `<style>` and adds the table of contents, so every report looks alike and needs no styling work from you. **Never link the stylesheet**: browsers sandboxed by Flatpak/Snap (Zen, for one) open only the single file, so a relative `<link>` fails silently and the page renders unstyled. To change the look for all reports, edit `assets/report.css`; older reports keep their embedded copy.

When a headless browser is available, screenshot the file and read the image back before saying it is ready. Then open it for the user with `xdg-open <absolute path of the report>`, and give them the absolute path and its `file://` URL.

Finish by telling the user the path and the three decisions you think matter most.

## Done

The report is done when:

- every task and ADR in scope appears in it, each with its outcome;
- every decision has its **why** and **cost**, or is marked "not recorded";
- every number and SQL snippet traces to a cited file;
- work found in `git status` but not in the docs is listed under "Uncommitted".
