# Report Format

## Sections, in order

1. **Summary**: scope, what the project is, and the whole arc in under ten lines. Include a timeline of tasks with status.
2. **Map**: which concepts, layers and files the reader meets, so later sections have somewhere to land.
3. **Story**: one chapter per task or coherent group of tasks, chronological. Each chapter has:
   - *Goal*: what the task set out to do and which PRD story it serves.
   - *What was built*: files, migrations, queries, tests, briefly.
   - *Decisions*: one entry per decision (see below).
   - *Learned*: discoveries, surprises, dead ends, from the task-run context files.
4. **Measurements**: for benchmarks and experiments, the question asked, the method, the raw numbers in a table, and the conclusion. Say what would change the conclusion.
5. **Concepts**: a glossary of every technical term used, one paragraph each, with a primary-source link.
6. **Open questions and risks**: things "not recorded", known technical debt, unproven assumptions.
7. **Uncommitted**: work in the tree not yet in any doc.
8. **Test yourself**: five to ten recall questions on the non-obvious decisions, answers hidden behind `<details>`. Questions ask *why*, never *what*.

## Decision entry

```
Decision: <the choice, one line>          Source: <file link>
Problem:      what forced a choice
Alternatives: each option and why it lost (with numbers if measured)
Choice:       what was picked
Why:          the reason, in plain words
Cost:         what the choice gives up
Later:        confirmed, reversed or refined by <task/ADR>, if it happened
```

An ADR is one decision entry; do not restate it twice. Where a decision has no ADR, take it from the task or context files and say so.

## Body fragment

Write plain HTML: `<h1>` title, `<p class="meta">` scope and date, then `<h2>` per section and `<h3>` per chapter (the sticky table of contents is generated from them). Available pieces:

- Decision entry: `<div class="decision"><strong>Choice <span class="src"><a href="...">ADR 0008</a></span></strong><dl><dt>Problem</dt><dd>...</dd><dt>Alternatives</dt><dd>...</dd><dt>Choice</dt><dd>...</dd><dt>Why</dt><dd>...</dd><dt class="cost">Cost</dt><dd>...</dd><dt class="later">Later</dt><dd>...</dd></dl></div>`
- Status: `<span class="tag done">done</span>`; risks or "not recorded": `<div class="callout">...</div>`
- Numbers: plain `<table>`; SQL and code: `<pre><code>`.
- Test yourself: `<details><summary>question</summary>answer</details>`.
