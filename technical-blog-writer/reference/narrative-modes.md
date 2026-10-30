# Narrative modes — questions, not ready-made outlines

Choose a dominant mode **after** identifying the reader's question and the evidence. These are editorial decision guides, not headings to copy. One post may borrow elements of another mode without mixing their claims.

| Mode | Reader's question | Investigation path | Evidence to prioritize | Avoid |
|---|---|---|---|---|
| Performance investigation | What made this slow? | Baseline → bottleneck → change → comparable result → trade-offs | Profiles, traces, percentiles, CI queue time and reproducible runs | Speedup without baseline; confusing CI with CD |
| Incident / reliability | What failed, and why did safeguards miss it? | Symptom → trigger → propagation → mitigation → prevention | Timelines, logs, retries, blast radius | Invented incident, blame, false root-cause certainty |
| Architecture decision / migration | Why change an architecture that used to work? | Original constraint → new constraint → options → safe transition → cost | ADRs, diffs, rollback and deployment evidence | Treating an unshipped proposal as delivered |
| Build journal / experiment | What did the author actually discover? | Goal → setup → real iteration → outcome → limitation | Commits, tests, sessions, demos | Fictional "naive version" or invented setback |
| Technical concept / tutorial | How does this behavior work? | Runnable example → mechanism → boundary cases | Code, docs, tests, SQL plans | Dictionary lead, excess boilerplate |
| Myth testing / opinion | When does an accepted assumption fail? | Steelman → specific counterexample → scope → practical rule | Concrete comparisons, citations | Strawmen and manufactured controversy |
| Research synthesis | What does the evidence support? | Question → findings → disagreements → quality → recommendation | Papers, technical docs, replications | Cherry-picking or flattening contexts |
| Comparative evaluation | Which choice fits my conditions? | Criteria → fair setup → results → cost/friction → conditional advice | Comparable workloads, config, constraints | Fake universal winner |

## Lead selection

Select the most truthful opening: a documented consequence, an unexpected measurement with its boundaries, a specific real scene, a design paradox, a precise technical question, or an observed outcome. Do not invent scenes, benchmarks or feelings for a stronger hook.

## Editorial flexibility

- A migration need not read like a benchmark, a tutorial need not be a retrospective, and a project write-up need not feature a failed first attempt.
- If no reliable measurement exists, explain the mechanism and a testable hypothesis instead of asserting improvement.
- If the draft sounds interchangeable with the author's last articles, reconsider the **angle** and evidence path, not just the vocabulary.
- Follow the observed timeline and causal relationships; avoid reverse-engineering a chronology from a desired conclusion.
