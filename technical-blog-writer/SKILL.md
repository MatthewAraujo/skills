---
name: blog-post-writer
description: Evidence-backed technical articles from real engineering work. Use when the user wants a project retrospective or lessons-learned post grounded in repository files, Codex sessions, commits, or project docs, or when another skill needs a publishable narrative from implementation evidence.
---

# Blog Post Writer

Turn real project work into a publishable technical article without inventing facts.

Do not use this skill for marketing copy, release notes, README generation, or fictional stories.

## Defaults

- Audience: software developers.
- Tone: clear, technical, reflective.
- Voice: first person only when the user owns the work.
- Language: same language as the user.
- Format: Markdown article unless the user asks for another format.
- Angle: engineering case study.
- Images: always create one cover image brief; add supporting image briefs only when they materially improve the article.
- Images: always create 700x380px image.
- Image generator: OpenAI image API, using the local key from `/home/matthew/keys.md` when execution is required.

Never print, paste, or embed the API key in the article, image prompts, or logs.

## Workflow

### 1. Fix the brief

Identify or infer:

- project;
- article goal;
- audience;
- tone;
- format;
- language;
- include/avoid list;
- one-sentence thesis.

Do not block on missing inputs unless they materially change the article. Use the defaults and move on.

Done when: you can summarize the article in one sentence: "`<project>` is a post about `<problem or decision>` for `<reader>`."

### 2. Build the evidence map

Inspect only sources that can support the thesis:

- repository docs and source;
- tests and config;
- Codex sessions;
- commits, PRs, issues, or diffs;
- user notes.

For each major claim, record:

- claim;
- evidence;
- source;
- status: implemented, planned, attempted, or inferred.

Use [reference/evidence-checklist.md](reference/evidence-checklist.md) when the repository is large or the source sweep is still fuzzy.

Done when: every planned section has supporting evidence, or the section is cut.

### 3. Choose the frame

Pick the article pattern that best fits the evidence and the user goal.

Use [reference/article-patterns.md](reference/article-patterns.md) when the structure is not obvious.

Use [reference/akita-style-reference.md](reference/akita-style-reference.md) only when the user explicitly wants a sharper, opinionated, evidence-backed voice.

Use [reference/mdx-format.md](reference/mdx-format.md) and [assets/mdx-post-template.mdx](assets/mdx-post-template.mdx) only when the output must be publication-ready MDX.

Done when: you have a title direction and section outline that fit one clear pattern.

### 4. Plan the visuals

Always produce a cover image brief grounded in the article thesis.

Add supporting image briefs only when an image will explain the system, sequence, or contrast better than prose alone.

For each planned image, define:

- role: cover or supporting;
- placement: article lead or target section;
- purpose;
- prompt or visual brief;
- alt text;
- evidence status: direct, abstracted, or conceptual.

Make every prompt ready for OpenAI image generation without depending on hidden context from the article draft.

Do not add an image for every section by default.

Do not propose visuals that depend on unsupported architecture, metrics, or private material.

Done when: the article has one cover image brief and every extra image clearly earns its place.

### 5. Draft from evidence

Write the article so that it:

- leads with the concrete problem, result, or claim;
- explains decisions, trade-offs, failed starts, and lessons;
- uses concrete examples and numbers when available;
- keeps planned, attempted, implemented, and inferred content distinct;
- preserves the user's voice when notes support it.

Do not paste raw session transcripts.

Do not invent architecture, benchmarks, business goals, user counts, production usage, or personal lessons.

Done when: every section advances the thesis and every non-trivial claim is traceable to evidence.

### 6. Final pass

Check that:

- the article has a clear thesis;
- it explains why the project matters;
- it shows what was built and why the design choices mattered;
- the cover image fits the thesis and any supporting images improve the article instead of decorating it;
- tone and format match the request;
- no secrets, private URLs, or internal-only details are exposed.

If useful, include a short references section listing the main files or sessions used.

Done when: the article is publishable without unsupported claims or cleanup notes.

## Output

Unless the user asks otherwise, return:

1. Suggested title.
2. Short summary.
3. Cover image brief.
4. Supporting image briefs, only when they materially improve the article.
5. Full article.
6. References used, when they materially improve trust or traceability.

If the user asks for MDX output, return the suggested `content/posts/<slug>.mdx` path and the complete file content that matches [reference/mdx-format.md](reference/mdx-format.md).

Keep the cover image brief and any supporting image briefs outside the MDX body unless the user provides or approves exact image paths or placement conventions for the target blog.
