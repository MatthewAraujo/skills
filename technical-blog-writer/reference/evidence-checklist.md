# Evidence checklist

Review only materials relevant to the article's central question:

- README, ADRs, architecture notes and user-provided project context;
- `AGENTS.md`, `WORKFLOW.md`, `CONTEXT.md` or equivalent instructions;
- source modules, tests, database schemas, migrations and config;
- CI/CD files, operational records, logs and traces where safe to access;
- commits, diffs, PRs, issues, agent sessions and field notes;
- authoritative external docs, papers or benchmarks when needed.

For each consequential claim record: **claim, evidence/source, status, confidence, publication safety**. Use observed / measured / implemented / proposed / inferred / externally reported / unknown.

For numbers, check baseline, units, measurement method, workload, environment, sample/window and confounders. Distinguish p50, p95, p99, queue time, build time and deployment time. Never present estimated gains as measured improvements.

For first-person claims, verify the author personally performed or observed the action. Commits or session transcripts are not permission to invent emotions, incidents or a sequence of mistakes.

Scrub API keys, tokens, internal URLs, customer data, sensitive logs, unpublished system details and confidential metrics. Reframe unsupported claims as hypotheses or remove them.

Cut background material that does not advance the article's main question, even if technically true.
