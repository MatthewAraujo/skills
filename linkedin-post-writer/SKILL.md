---
name: linkedin-post-writer
description: Turn a technical article into a strong LinkedIn post.
disable-model-invocation: true
---

# LinkedIn Post Writer

Turn a real technical article into a LinkedIn post that sounds like the author and makes the full piece worth clicking.

This skill is for promotion, not article writing. Base every claim on the article. Do not invent impact, adoption, metrics, or outcomes.

## Inputs

Start from the article itself. The most useful extra inputs are:

- article URL
- target audience
- desired tone
- whether the link should live in the post or first comment
- whether the post should lean recruiter-facing
- anything the user wants included or avoided

If the article is MDX, read `metadata.title` and `metadata.description` first, then use the body for the real substance.

## Process

### 1. Extract the article spine

Pull out the few facts the post must preserve:

- what was built or argued
- why it matters
- the most interesting technical decision, trade-off, or lesson
- the concrete technologies or engineering areas involved
- the intended reader
- the article language
- the article URL, if provided

If you cannot state the article's main point in one or two sentences, read again before drafting.

### 2. Pick one angle

Choose one angle only. Do not try to summarize the whole article.

Common angles:

- project + lesson
- technical breakdown
- strong thesis
- AI-assisted workflow
- concise teaser

Use [references/linkedin-post-patterns.md](references/linkedin-post-patterns.md) only if you need help choosing a structure.

### 3. Draft the post

Write a post that:

- opens with a clear first line
- uses short paragraphs
- highlights specific technical substance
- creates curiosity about the article without becoming bait
- sounds like a practitioner, not a brand account
- ends with one simple call to action

Use the same language as the article unless the user asks otherwise.

### 4. Add professional signal only when it helps

If the user wants stronger recruiter positioning, make the work legible through concrete signals like ownership, architecture, testing, debugging, trade-offs, or end-to-end delivery.

Do this naturally. Do not turn the post into a keyword list or ask for a job directly.

Use [references/recruiting-context.md](references/recruiting-context.md) only when that recruiter-facing angle matters.

### 5. Package the result

Unless the user asks for something narrower, return:

```txt
## LinkedIn post

<post>

## Optional shorter version

<shorter post>

## Suggested first comment

<comment with the article link, or a note that the link can be added after publishing>

## Hashtags

<0 to 5 relevant hashtags>
```

If the user asks for only one post, return only the final post.

## Hard rules

- Do not invent production usage, users, benchmarks, business impact, recruiter response, or any other unsupported result.
- Do not write corporate-announcement language like "thrilled to announce" or generic hype like "game-changer" and "revolutionary."
- Do not use engagement bait such as "Thoughts?", "Agree?", or "Comment YES."
- Do not make the post a flat summary of the article.
- Do not overload it with hashtags. Use none if they do not help.

## Quality bar

Before returning, check that the post:

- is grounded in the article
- has one clear angle
- signals real technical work
- sounds human
- is easy to scan on mobile
- makes the article more worth reading
