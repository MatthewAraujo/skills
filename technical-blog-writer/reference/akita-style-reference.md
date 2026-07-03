# AkitaOnRails Style Reference

## Purpose

Use this reference when writing technical blog posts inspired by the editorial structure of AkitaOnRails articles.

Do not copy Fabio Akita's text, phrasing, jokes, paragraphs, or distinctive voice. Use this only as a structural and analytical reference.

The goal is not to imitate the author. The goal is to produce articles with:
- Strong technical opinion.
- Concrete engineering evidence.
- Clear problem framing.
- Real numbers when available.
- Practical implementation details.
- Lessons learned from actual work.
- A direct, developer-to-developer tone.

## Reference articles

Use these articles as structural references:

- https://akitaonrails.com/en/2026/03/01/ai-jail-sandbox-for-ai-agents-from-shell-script-to-real-tool/
- https://akitaonrails.com/en/2026/03/01/software-is-never-done-4-projects-life-after-deploy-one-shot-prompt-myth/
- https://akitaonrails.com/en/2026/02/20/zero-to-post-production-in-1-week-using-ai-on-real-projects-behind-the-m-akita-chronicles/
- https://akitaonrails.com/en/2026/04/20/clean-code-for-ai-agents/

## Observed article pattern

AkitaOnRails articles usually follow this pattern:

1. Strong title
   - The title is direct, opinionated, and specific.
   - It usually contains the project, the claim, or the conflict.

2. Immediate context
   - The article starts with what happened.
   - It avoids a slow generic introduction.
   - It quickly tells the reader why the topic matters.

3. Concrete numbers
   - Commits, tests, days, releases, dependencies, platforms, file sizes, or production data are used when available.
   - Numbers are used to make the story credible.

4. Problem before solution
   - The article explains the pain first.
   - Then it presents the tool, project, refactor, or decision.

5. Engineering narrative
   - The article is not only "what I built".
   - It explains why decisions were made.
   - It includes constraints, rejected alternatives, trade-offs, and production reality.

6. Practical sections
   - Sections are concrete and scannable.
   - Examples:
     - The Problem
     - From Script to Tool
     - Installation
     - Basic Usage
     - Technical Details
     - Lessons
     - Conclusion

7. Opinion backed by evidence
   - The article can be opinionated, but the opinion must be supported by project evidence.
   - Avoid vague claims like "this is better".
   - Prefer claims like "this was better for this project because..."

8. Real-world friction
   - Bugs, failed assumptions, rewrites, deployment issues, and limitations are part of the story.
   - Do not hide the messy parts.

9. Lessons learned
   - The article should end with a clear lesson.
   - The lesson should be useful to another developer.

10. Strong conclusion
   - The ending should restate the main thesis.
   - It should not be a generic summary.
   - It should tell the reader what to take away.

## Recommended tone

Use:
- Direct technical voice.
- First person when describing personal work.
- Clear claims.
- Concrete examples.
- Practical conclusions.
- Controlled skepticism.
- Developer-oriented explanations.

Avoid:
- Marketing tone.
- Generic motivational writing.
- Copying Akita's exact phrasing.
- Overly polished corporate language.
- Unsupported hype.
- Fake certainty.
- Claims not grounded in repository evidence.

## Article template inspired by this structure

```md
# <Strong, specific title>

<intro: what happened, what was built, and why this matters>

## The problem

<explain the concrete problem or motivation>

## What I built

<describe the project in practical terms>

## The first version was not enough

<explain what was missing, broken, naive, or incomplete>

## The architecture

<explain the technical design>

## The development process

<use Codex sessions, commits, diffs, or notes to explain how the project evolved>

## The parts that were harder than expected

<describe bugs, trade-offs, debugging, integration issues, or design constraints>

## The numbers

<include commits, tests, files, endpoints, modules, performance data, or other concrete metrics when available>

## What I learned

<extract lessons that another developer can reuse>

## What I would do differently

<future improvements or limitations>

## Conclusion

<close with a strong thesis and practical takeaway>
````

## Evidence rules

When writing the article:

* Use repository files as evidence.
* Use Codex sessions as evidence of process.
* Use commits and diffs as evidence of evolution.
* Use tests and CI as evidence of quality.
* Use README/docs as evidence of intent.
* Use user notes as evidence of personal learning.

Never invent:

* Production usage.
* Benchmarks.
* Security properties.
* Architecture decisions.
* Business goals.
* User numbers.
* Performance improvements.
* Lessons the user did not actually mention or imply.

