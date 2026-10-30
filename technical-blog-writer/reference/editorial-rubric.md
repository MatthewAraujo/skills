# Editorial rubric — internal review

Score each dimension from 0 to 2: 0 = missing/misleading, 1 = partial, 2 = strong and supported. Maximum 20. **Technical inaccuracy or a confidentiality breach fails review regardless of total**. A score above 16 suggests copyediting readiness, not guaranteed editorial quality.

1. **Reader contract:** target audience and payoff are obvious.
2. **Opening:** specific and truthful tension appears early.
3. **Unique insight:** more useful than a generic framework guide or changelog.
4. **Mechanism:** causal explanation, not a component inventory.
5. **Evidence:** claims trace to sources and have explicit status.
6. **Metrics:** baseline, unit, percentile, comparison context and limitations are clear when relevant.
7. **Trade-offs:** credible options or important bounds are considered where appropriate.
8. **Architecture of argument:** sections advance the central question.
9. **Original voice:** authentic engineer-to-engineer prose without borrowed mannerisms or boilerplate.
10. **Ending:** answers the opening question with a reusable finding or next test.

Do not demand benchmark numbers, incidents, personal anecdotes or counterarguments when the evidence/topic does not warrant them.

## Red flags

- Generic opening that could introduce any software article.
- Repeated "não é X, é Y" / "it's not X, it's Y" constructions.
- Every post starts with "The problem" and ends with "Lessons" and "Conclusion".
- Paragraphs repeat the thesis in different words; sections can be reordered without changing the reasoning.
- Broad feature lists without one concrete investigation.
- Dramatic hooks with unverified numbers, user impact, incidents or guarantees.
- A reported time reduction that conflates queueing, build, deploy and end-to-end lead time.
- Planned architectures written as completed rollouts.
- Invented first-person experience, emotions or failures.
- Summary that restates instead of resolving the initial question.

## Calibrating to this blog

The following are editorial **questions**, not claims about production:

- Pagination: when mentioning a real latency issue, is there a query plan or reproducible demonstration? If not, is the evidentiary boundary explicit?
- Agent orchestration: does the reader understand the threat model and limitations before encountering Docker/worktrees/configuration details?
- CI/CD: are agent wait, checkout, build, deployment and total delivery time separately defined?
- Broad guides: would one focused decision or failure mechanism be more valuable than listing everything a tool can do?

Before publication, ask: "What did the evidence teach the author that another developer can apply, and what could make the conclusion false?"

## Independent review usage

Use this rubric as one input to the fresh-context reviewer described in [independent-review.md](independent-review.md). Give the reviewer the article and a minimal, sanitized evidence map, **not** the writer's scores, intentions, discarded angles or previous critique.

A score is a diagnostic aid, not a release authorization. The separate reviewer should identify concrete defects with quotes and severity. A high score does not override a blocking claim, confidentiality problem or unsupported production metric. A self-assessment is not independent review.
