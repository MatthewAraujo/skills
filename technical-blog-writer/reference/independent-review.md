# Independent article review — fresh-context subagent protocol

## Purpose

The writer has read project details, chosen the narrative, defended technical decisions and iterated on the text. Those choices can create **anchoring and confirmation bias**. A fresh-context reviewer acts as a skeptical, constructive reader who was not involved in drafting.

A fresh agent is not guaranteed unbiased or more accurate. The benefit comes from **separate context, a critical task, and access to checkable evidence**, not merely from naming an agent "reviewer". This protocol is for publishable technical articles, not snippets or brainstorming.

## Execution contract

1. **Writer completes draft and internal editorial pass.** The writer should not evaluate its own final result as "independently reviewed".
2. **Prepare a minimal, sanitized review packet**:
   - article title and complete Markdown/MDX body;
   - intended audience and one-sentence reader promise;
   - chosen publishing constraints (format, language, allowed visuals);
   - concise claim ledger with statuses (observed, measured, implemented, proposed, inferred, externally reported or unknown);
   - verifiable evidence references: public links, excerpts authorized for disclosure, citations, repo paths/commit IDs or sanitized measurements, with enough context to check important claims;
   - whether the reviewer can open references or must treat them as inaccessible.
3. **Spawn a new subagent/session with isolated context** if the host actually supports it (for example, a native task/agent delegation mechanism). Send only this packet and the reviewer instructions below. **Do not send** chat history, earlier drafts, the writer's self-ratings, preferred angle, internal debate, or rationale for contentious decisions. Avoid copying internal chain-of-thought.
4. **Read the review report as a set of hypotheses.** Check each concrete finding against the cited text and evidence; do not blindly adopt inaccurate advice or soften correct claims to satisfy the reviewer. Address blocking findings before publication.
5. **Re-review only changed sections when needed.** One focused follow-up is normally sufficient for blocker verification. Record any unresolved concern accurately instead of silently dropping it.

**If no independent agent tool exists:** perform the same review checklist in the current context, but explicitly label the result `self-review (not independent)`. Starting a new section in the same conversation, role-playing a critic, or restating the prompt does *not* create independent context. Do not promise that delegation occurred.

## Reviewer instruction — copy verbatim into the isolated task

> You are an independent technical-blog peer reviewer. You did not participate in planning or writing this draft. Your purpose is to find errors, omissions, overclaims, weak explanations, and places where a capable reader loses interest—not to validate the author's choices.
>
> Read the entire article as a new reader. Critique the **argument and evidence**, not the author's personality. Never invent new facts or improvements. Preserve the intended audience and the author's legitimate voice.
>
> Verify central technical claims against the supplied evidence when accessible. If the evidence is not supplied or cannot be accessed, write `unverified`, not `false` and not `verified`. Distinguish observed measurements from proposed optimizations; distinguish correlation from causation. Do not infer production usage, speedups or safety guarantees from design descriptions alone.
>
> Evaluate the opening, the reader's central question, logical progression, technical mechanisms, alternatives, diagrams/code placement, novelty, specificity, repeated rhetorical devices, unsupported certainty, and ending. Apply the rubric when provided, but prioritize concrete findings above scores.
>
> Quote the smallest passage needed to identify a problem. For each finding, assign `BLOCKER`, `MAJOR`, or `MINOR`; identify its location; explain why it matters to the intended reader; cite available evidence or mark verification unavailable; propose a small actionable fix. Do not rewrite the full article.
>
> **BLOCKER:** factual contradiction supported by evidence, secret/confidential data exposure, materially misleading claim (such as invented benchmark, production rollout or security guarantee), or broken required publication contract. **MAJOR:** important logical gap, insufficiently supported central thesis, loss of reader orientation, or repeated structure that undermines the piece. **MINOR:** style, redundancy, syntax and optional improvements.
>
> Give credit only for actual strengths found in the draft. Do not invent problems to fill a quota. Flag uncertainty and possible false positives. Return the structured report below and a release recommendation, with no hidden reasoning transcript.

## Expected report

```yaml
review_type: independent-fresh-context   # only if actually delegated
verdict: request_changes                # approve | request_changes | needs_evidence
strengths:
  - "One specific, text-supported strength"
findings:
  - severity: MAJOR
    location: "Section heading or paragraph"
    excerpt: "Short exact quotation"
    issue: "Why this affects accuracy, comprehension or interest"
    evidence: "Source/claim ID, or unverified when inaccessible"
    recommended_change: "Specific, proportional revision"
unverified_claims:
  - "Claim and the missing measurement/source"
publication_risks:
  - "Any privacy, attribution, broken MDX, or other risk"
editorial_score:
  total: 0   # 0..20, supportive diagnostic only
  notes: "Most consequential dimensions, referencing editorial-rubric.md"
```

This is a **human-readable schema**, not a guarantee that a specific agent runtime supports YAML output. Markdown structured with the same fields is acceptable.

## Acceptance gate

- No unresolved BLOCKER finding before publication.
- All MAJOR findings are resolved, explicitly scoped, or documented as deliberately not adopted with a checkable reason.
- Central external/technical claims have traceable evidence or are labeled uncertain/hypothetical; inaccessible sources are not silently called verified.
- No secrets or unauthorized corporate information in the article or review packet.
- Required MDX metadata and rendering constraints remain valid.
- Reviewer status is reported honestly: `independent-fresh-context`, `self-review (not independent)`, or `not reviewed`.

The writer remains accountable for the final article. The reviewer cannot replace a code review, benchmark reproduction, human domain expert, or legal/security approval.
