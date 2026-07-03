# Visual Improvement Flow

Goal:
Improve the visual quality of an existing application screen without changing the core business logic.

Input:
- Screenshot or description of the current screen
- Relevant project docs
- Existing design system/theme
- Current frontend implementation, when available

Steps:

1. Run grill-with-docs
   Validate whether the screen matches the project intent, product requirements, domain rules, and existing documentation.

2. Run visual-ui-reviewer
   Review the screen mainly from a visual/design perspective:
   - layout balance
   - spacing
   - typography
   - colors
   - contrast
   - visual hierarchy
   - density
   - component polish
   - empty/loading/error states
   - perceived quality

3. Run design-system-aligner
   Convert visual suggestions into reusable design-system decisions:
   - tokens
   - component variants
   - spacing scale
   - color usage
   - radius
   - shadows
   - typography scale
   - button/input/card/table patterns

4. Run frontend-implementation-planner
   Transform the visual improvement plan into concrete frontend tasks:
   - files to change
   - components to extract
   - layout adjustments
   - CSS/theme changes
   - acceptance criteria
