# Cover Art House Style — Matthew Systems Journal

## Purpose

Create a recognizable series of **original visual metaphors for software engineering**. The inspiration is the visual *genre* of historic scientific engravings and architectural plates, including the atmosphere of covers in [Matheus Fidelis's system-design series](https://fidelissauro.dev/category/system-design/). This is a reference for transferable design principles, **not** a request to replicate specific artwork, compositions, characters, or the creator's identifiable visual signature.

Use this guide for Matthew's blog by default. The user may choose a different style for an individual article or opt out.

## Core identity: "The Engraved Systems Atlas"

A speculative old-world engineering workshop: complex invisible software mechanisms become tangible machines, spaces, routes and instruments that an engineer can inspect. Think **technical curiosity + craftsmanship + restrained mystery**, not a fantasy poster.

### Constants — repeat across the series

- **Medium:** monochrome copperplate/wood-engraving-inspired ink illustration with very fine cross-hatching, stippling, line work and paper grain. Crisp printed linework over photographic realism; avoid cheap distressed filters.
- **Palette:** charcoal/black ink with muted ivory, stone gray and optional slight cool-gray or sepia paper tint. Restrict accents; no neon, gradients, saturated CGI, colorful dashboards.
- **Composition:** wide editorial landscape; one readable primary subject, supporting story details, layered depth, and 10–12% crop-safe margins. The focal point must survive at 320 px width.
- **Atmosphere:** historical scientific atlas, architecture sketchbook, instrument-maker's workshop or printmaking plate; detailed but legible, thoughtful rather than bombastic.
- **Content:** allegorical physical systems that convey a real engineering relationship—routing, isolation, indexing, contention, validation, feedback, migration.
- **Typography:** no embedded title, lettering, numbers, labels, watermarks or logo. Title lives in the site UI, not the illustration.
- **Authenticity:** avoid mimicking the composition of any specific reference image. Do not use artist names or exact copyrighted works in generation prompts.

### Variables — change for each article

Change **at least two** of: primary scene, object family, visual angle, human presence, scale, perspective, environmental location, and the main mechanism represented.

Examples of legitimate subject families: clockwork engines, ports and locks, astronomical instruments, old libraries and indexing tables, dry docks, workshop chambers, telescopes, pulley networks, aqueducts, printing presses, bridges, foundries, navigation charts, guarded doors and mechanical switches.

Never make each cover a robed old scholar beside a scroll, pyramid or crystal ball. Those are possible props, not the brand identity.

## Editorial art-direction workflow

1. **Extract the thesis:** summarize one specific engineering behavior the article demonstrates, without claiming unverified outcomes.
2. **Invent three metaphors:** choose visually different representations; reject any that depend on a specific existing illustration.
3. **Select a central mechanism:** it must illuminate an actual relation (e.g. request routing vs. redundant computation), not merely show generic infrastructure.
4. **Sketch the focal hierarchy:** identify one subject, one meaningful secondary cue and one background layer. Avoid a collage of all topics mentioned in the post.
5. **Write a standalone generation prompt:** include subject, action, symbolism, medium, camera/perspective, palette, composition, exclusions, requested aspect ratio and output constraints; reference the article's concept in plain language rather than relying on hidden context.
6. **Review thumbnail readability, semantic alignment, originality, publication safety and evidence status.** Iterate the concept before polishing the prompt.
7. **Generate only if requested and available:** when an image-generation tool is available in the host and the workflow calls for actual assets, use it; otherwise output a complete image-generation brief and clearly state that no image file was generated.

## Output contract for the cover brief

```yaml
cover_art_direction: "One-sentence editorial art direction"
cover_art_concept: "What happens in the scene, with one focal subject"
cover_art_symbolism: "Concrete mapping: depicted object -> article concept"
cover_art_prompt: "Standalone, tool-ready image generation prompt"
cover_art_alt: "Literal accessible description of the scene, not a keyword list"
cover_art_evidence_status: "conceptual" # conceptual | abstracted | direct
```

Only include `cover_art_asset_path` once an asset has actually been generated or an approved existing path has been confirmed.

**Evidence rule:** a metaphorical scene is conceptual. A technical diagram must be sourced/validated separately; it must not invent measured values or actual system topology.

## Default prompt structure

```text
Original horizontal editorial engraving for a software engineering article about [precise thesis].
Main scene: [one clear subject carrying one concrete action].
Physical metaphor: [specific physical mechanism] represents [specific system behavior];
[secondary element] represents [one documented constraint].
Medium: fine monochrome ink etching, copperplate-inspired cross-hatching, stippling,
antique scientific illustration, slightly textured warm-gray archival paper,
dense handcrafted linework, sharp focal hierarchy, believable physical geometry.
Composition: landscape approximately 1.84:1 unless target site specifies otherwise;
primary subject occupies central field; detailed but legible at thumbnail size;
10–12% safe margins; coherent light and perspective.
Palette: charcoal / black / subtle off-white, no saturated colors.
Avoid: captions, text, letters, digits, logos, watermark, UI screenshots, glowing neon,
generic stock 3D, cyberpunk circuits, duplicate subjects, poster typography,
specific existing artwork, direct imitation of any contemporary illustrator.
This is a conceptual visual metaphor, not a claim that this architecture exists.
```

The previous skill used 700×380 px; consider it an **unverified historic target**, not a hardcoded current website requirement. Prefer the site's confirmed export dimensions. If an image tool cannot produce the requested exact dimensions, render at a supported nearby ratio and crop/resize carefully only when actually saving the file.

## Example rejection tests

- "A programmer staring at green code" — generic, no article-specific mechanism.
- "A silver robot holding a GitHub logo" — stock-tech cliché, potentially unauthorized brand.
- "The same hooded engineer using a crystal ball in every cover" — visual repetition.
- "A picture of an exact production architecture inferred from a private repo" — factual/confidentiality risk.
- "Copy the exact Fidelissauro cover, but remove the watermark" — unacceptable direct imitation.

## Visual-review mini-checklist

Would a reader understand the *kind of tension* before opening the article? Is there exactly one focal relationship? Could the thumbnail be recognized without any lettering? Does this image belong to the same visual universe as past covers while having a distinct story? Are all unverified design elements treated as metaphor rather than system evidence?
