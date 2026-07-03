# MDX Format Reference

## Purpose

Use this reference only when the user wants publication-ready `.mdx` output for the user's MDX-based blog.

This file defines the output format for that MDX branch of the `blog-post-writer` skill.

The final article should be written as a publication-ready `.mdx` file.

The content must be compatible with a Next.js blog that uses file-based MDX posts stored under:

```txt
content/posts/
```

Each `.mdx` file represents one blog post.

## Required file location

Every generated post should include a suggested file path using this format:

```txt
content/posts/<slug>.mdx
```

Example:

```txt
content/posts/building-ai-backend-factory-with-codex.mdx
```

## Slug rules

The slug must be generated from the article title.

Use these rules:

* Use lowercase.
* Use hyphens between words.
* Remove accents.
* Remove punctuation.
* Avoid spaces.
* Avoid special characters.
* Keep the slug descriptive.
* Avoid very long slugs.
* Prefer English slugs for English articles.
* Prefer Portuguese slugs for Portuguese articles.

Examples:

```txt
Building AI Backend Factory with Codex
```

becomes:

```txt
building-ai-backend-factory-with-codex
```

```txt
O que eu aprendi criando um gerador de backends com IA
```

becomes:

```txt
o-que-eu-aprendi-criando-um-gerador-de-backends-com-ia
```

## Required metadata format

Every MDX post must start with an exported `metadata` object.

Use exactly this shape:

```tsx
export const metadata = {
  title: "Post title",
  publishDate: "YYYY-MM-DD",
  description: "Short post description.",
};
```

Required fields:

* `title`: the public article title.
* `publishDate`: publication date in `YYYY-MM-DD` format.
* `description`: short article summary for previews, cards, SEO, and blog index pages.

Do not use YAML frontmatter.

Do not write:

```md
---
title: Post title
date: 2026-07-02
---
```

Use the JavaScript/TypeScript metadata export instead.

## Metadata rules

### `title`

The title should be:

* Specific.
* Technical.
* Clear.
* Interesting to developers.
* Grounded in the actual project.

Avoid vague titles like:

```txt
My Project
```

Prefer specific titles like:

```txt
Building AI Backend Factory: What I Learned from Turning Codex Sessions into a Real Tool
```

### `publishDate`

Use the date provided by the user.

If the user does not provide a date, use the current date.

The date must follow this format:

```txt
YYYY-MM-DD
```

Example:

```txt
2026-07-02
```

### `description`

The description should be short and useful.

It should explain what the article is about in one sentence.

Avoid generic descriptions like:

```txt
A blog post about my project.
```

Prefer concrete descriptions like:

```txt
What I learned building an AI-assisted backend generator using Codex sessions, repository context, and architecture-driven development.
```

## Important rendering rule

The target blog renders the article title from `metadata.title`.

Because of that, do not include a duplicate top-level `# Title` heading inside the MDX body.

Correct:

```mdx
export const metadata = {
  title: "Building AI Backend Factory",
  publishDate: "2026-07-02",
  description: "What I learned building an AI-assisted backend generator with Codex sessions.",
};

I started this project because I wanted to understand how far an AI coding agent could go when it had enough project context.

## The problem

The first version of the idea was simple...
```

Incorrect:

```mdx
export const metadata = {
  title: "Building AI Backend Factory",
  publishDate: "2026-07-02",
  description: "What I learned building an AI-assisted backend generator with Codex sessions.",
};

# Building AI Backend Factory

I started this project because...
```

## Body structure

After the metadata export, start directly with the introduction paragraph.

Do not add:

* A duplicate `# Title`.
* YAML frontmatter.
* A table of contents unless the user asks for it.
* A generic "Introduction" heading unless it improves the article.

Preferred structure:

```mdx
export const metadata = {
  title: "{{title}}",
  publishDate: "{{publishDate}}",
  description: "{{description}}",
};

{{intro}}

## The problem

{{problem}}

## What I built

{{what_i_built}}

## Architecture

{{architecture}}

## Development process

{{development_process}}

## The parts that were harder than expected

{{challenges}}

## What I learned

{{learnings}}

## What I would improve next

{{future_work}}

## Conclusion

{{conclusion}}
```

The exact section names may change depending on the selected article pattern, but the output must remain valid MDX.

## Heading rules

Use headings consistently.

Allowed heading levels:

```md
## Major section
### Subsection
#### Small subsection
```

Do not use `#` inside the body because the title is already rendered from `metadata.title`.

Prefer `##` for main sections.

Use `###` only when a section needs further subdivision.

Avoid deeply nested headings unless the article is long and technical.

## Paragraph rules

Use short to medium paragraphs.

Prefer clear technical prose.

Avoid very long walls of text.

Each paragraph should usually focus on one idea:

* Problem.
* Decision.
* Trade-off.
* Implementation detail.
* Lesson.
* Limitation.
* Future work.

## Lists

Use lists when they improve readability.

Good use cases:

* Explaining constraints.
* Listing architecture components.
* Showing trade-offs.
* Summarizing lessons.
* Describing steps.

Avoid excessive lists.

The article should still feel like an essay, not documentation.

## Code block rules

When including code, always use fenced code blocks with explicit language identifiers.

Correct:

```ts
type BlogPostMetadata = {
  title: string;
  publishDate: string;
  description: string;
};
```

Incorrect:

```
type BlogPostMetadata = {
  title: string;
  publishDate: string;
  description: string;
};
```

Common language identifiers:

```txt
ts
tsx
js
jsx
json
bash
sh
md
mdx
sql
go
py
rs
yaml
dockerfile
```

Do not include large code dumps unless the user explicitly asks for them.

Prefer short code snippets that support the article's argument.

## Inline code rules

Use inline code for:

* File names.
* Commands.
* Function names.
* Class names.
* Package names.
* API routes.
* Environment variable names, without exposing values.
* Configuration keys.

Examples:

```md
The posts live in `content/posts/`.

The route imports each file using `@/content/posts/${slug}.mdx`.

The first version used `README.md` as the main source of project context.
```

Do not expose secret values in inline code.

Incorrect:

```md
The API key was `sk-...`.
```

Correct:

```md
The API key was loaded from an environment variable and intentionally kept out of the article.
```

## Links

Use standard Markdown links.

Example:

```md
The project is available on [GitHub](https://github.com/example/repo).
```

Only include links provided by the user or found in public project documentation.

Do not invent links.

Do not include private repository links unless the user explicitly wants them published.

## Blockquotes

Use blockquotes sparingly.

Good use cases:

* Highlighting a key lesson.
* Separating a design principle.
* Calling attention to a constraint.

Example:

```md
> The important lesson was not that the agent could write code. It was that the agent became useful only after the project had enough structure.
```

Do not overuse blockquotes.

## MDX component rules

Do not import React components unless the user explicitly asks for interactive MDX content and the target blog supports those components.

Avoid:

```mdx
import { Callout } from "@/components/callout";

<Callout>
  This assumes a component that may not exist.
</Callout>
```

Prefer plain Markdown:

```md
> This was the main design constraint behind the implementation.
```

Do not assume that custom components exist.

Do not use ShadCN, charts, cards, tabs, callouts, or custom JSX unless the user confirms that the blog supports them.

## JSX rules

Because MDX allows JSX, be careful with characters that may be interpreted as JSX.

Avoid writing raw angle brackets casually.

Prefer:

```md
The architecture followed a simple flow: Frontend → API → database → cache.
```

Instead of:

```md
Frontend < API > database
```

When discussing generic types, wrap them in inline code:

```md
The function returns `Promise<Post[]>`.
```

## Images

Always prepare one cover image brief for every article.

Keep the cover image brief outside the MDX body unless the user confirms the blog's cover-image metadata or file-path convention.

Add supporting images only when they materially improve comprehension or narrative flow.

When a supporting image is approved for placement in the post, use Markdown image syntax:

```md
![Architecture diagram](/images/ai-backend-factory-architecture.png)
```

Rules:

* Use descriptive alt text.
* Always include exactly one cover image brief.
* Do not add inline images for every section by default.
* Do not invent blog-specific metadata fields for images.
* Do not invent image paths.
* Do not include external images unless the user provides or approves them.
* Do not include copyrighted images without permission.

For each image brief, specify:

* role: cover or supporting;
* placement: article lead or target section;
* purpose;
* prompt or visual brief;
* alt text.

## Tables

Use Markdown tables only when they improve clarity.

Good use cases:

* Comparing alternatives.
* Showing trade-offs.
* Mapping claims to evidence.
* Listing architecture components.

Example:

```md
| Decision | Why it mattered |
|---|---|
| File-based sessions | Made the development process inspectable |
| MDX output | Made the final article directly publishable |
```

Avoid large tables in narrative posts.

## Tone and style

The MDX format only defines the output structure.

The writing style should come from:

* `akita-style-reference.md`
* `article-patterns.md`
* `../assets/mdx-post-template.mdx`
* The user's explicit instructions

Default writing style:

* Technical.
* Direct.
* First-person when describing the user's own work.
* Reflective.
* Grounded in real project evidence.
* Useful to other developers.

Avoid:

* Marketing copy.
* Fake hype.
* Unsupported claims.
* Generic motivational writing.
* Corporate announcement tone.
* Copying the voice of any specific author.

## Evidence and accuracy

Every important technical claim should be grounded in at least one of these:

* Repository files.
* README.
* Documentation.
* Source code.
* Tests.
* Commit history.
* PRs.
* Issues.
* Diffs.
* Codex sessions.
* User-provided notes.

Do not invent:

* Benchmarks.
* Production usage.
* User numbers.
* Deployment status.
* Test coverage.
* Security guarantees.
* Performance improvements.
* Business impact.
* Architecture decisions.
* Lessons the user did not actually mention or imply.

Use careful wording when evidence is partial.

Examples:

```md
The current version focuses on...

From the available sessions, the project seems to have evolved from...

Based on the repository structure, the main architectural split is...

A clear next step would be...
```

## Privacy and safety

Before generating the final MDX file, remove or avoid:

* API keys.
* Access tokens.
* Passwords.
* Private URLs.
* Internal infrastructure details.
* Sensitive logs.
* Credentials.
* Personal data from other people.
* Private company information.
* Unpublished confidential details.
* Anything from Codex sessions that should not be public.

When sensitive information appears in the evidence, summarize it safely instead of quoting it.

## Default MDX template

Use this as the default template when no other article pattern is more appropriate:

```mdx
export const metadata = {
  title: "{{title}}",
  publishDate: "{{publishDate}}",
  description: "{{description}}",
};

{{intro}}

## The problem

{{problem}}

## What I built

{{what_i_built}}

## Architecture

{{architecture}}

## Development process

{{development_process}}

## The parts that were harder than expected

{{challenges}}

## What I learned

{{learnings}}

## What I would improve next

{{future_work}}

## Conclusion

{{conclusion}}
```

## Output requirements

When returning a generated article, use this response shape:

```txt
Suggested file path:
content/posts/<slug>.mdx

Metadata:
export const metadata = {
  title: "...",
  publishDate: "YYYY-MM-DD",
  description: "...",
};

Cover image brief:
...

Supporting image briefs:
...

Full MDX:
```

Then provide the complete `.mdx` content.

The final MDX must be ready to paste into:

```txt
content/posts/<slug>.mdx
```

## Final validation checklist

Before returning the final MDX post, verify:

* The file path uses `content/posts/<slug>.mdx`.
* The slug is lowercase and hyphenated.
* The post starts with `export const metadata`.
* The metadata includes `title`, `publishDate`, and `description`.
* Exactly one cover image brief is included outside the MDX body.
* Any supporting image briefs are justified by the article instead of added by default.
* The date uses `YYYY-MM-DD`.
* The body does not include a duplicate `# Title`.
* Main sections use `##`.
* Code blocks have language identifiers.
* No unsupported MDX components are used.
* No secrets or private data are included.
* Claims are grounded in repository, session, or user-provided evidence.
* The article is publishable as MDX.
