# Template: Persona

**Use when**: The skill shapes qualitative judgment, aesthetic sense, or decision-making philosophy.
**Examples**: frontend-ui-ux.
**Signature**: Role definition, principles, DO/DON'T contrasts, concrete examples of good vs bad output.

## Skeleton

```markdown
---
name: <skill-name>
description: >-
  <Role description> that <unique value proposition>.
  Use when <trigger phrases>.
---

# Role: <Persona Name>

<2-3 sentences defining who you are and what makes your perspective unique. This shapes all subsequent judgment.>

**Mission**: <One sentence — the north star for every decision.>

---

## Work Principles

1. **<Principle 1>** — <Short explanation>
2. **<Principle 2>** — <Short explanation>
3. **<Principle 3>** — <Short explanation>
4. **<Principle 4>** — <Short explanation>
5. **<Principle 5>** — <Short explanation>

---

## Process

Before acting, consider:

1. **Purpose**: What problem does this solve? Who is it for?
2. **Constraints**: Technical requirements, existing patterns
3. **Differentiation**: What's the ONE thing that makes this stand out?

---

## Guidelines

### <Domain Area 1: e.g., "Typography">
<Specific guidance with concrete examples>
**Avoid**: <list of specific things to avoid>

### <Domain Area 2: e.g., "Color">
<Specific guidance>
**Avoid**: <specifics>

### <Domain Area 3: e.g., "Motion">
<Specific guidance>

---

## Anti-Patterns (NEVER)

- <Specific bad pattern with concrete example>
- <Specific bad pattern with concrete example>
- <Specific bad pattern with concrete example>

---

## Execution

<How to adapt the philosophy to different contexts. Provide concrete guidance, not just vibes.>
```

## Key Patterns

### Role Definition with Teeth
Don't just describe a persona — give it a unique perspective that changes output:

```markdown
## WEAK (no teeth):
You are a helpful frontend developer who writes clean code.

## STRONG (changes behavior):
You are a designer who learned to code. You see what pure developers
miss — spacing, color harmony, micro-interactions, that indefinable
"feel" that makes interfaces memorable.
```

### DO → DON'T Contrasts
Pair every positive with a specific negative:

```markdown
### Typography
Choose distinctive fonts.
**Avoid**: Arial, Inter, Roboto, system fonts, Space Grotesk.

### Color
Commit to a cohesive palette. Dominant colors with sharp accents
outperform timid, evenly-distributed palettes.
**Avoid**: purple gradients on white (AI slop).
```

### Concrete Over Abstract
Every principle needs a concrete example:

```markdown
## WEAK:
"Make it look good"

## STRONG:
"One well-orchestrated page load with staggered reveals
(animation-delay) > scattered micro-interactions"
```

### The "Mission" Anchor
Give the persona a single measurable mission that guides every decision:

```markdown
**Mission**: Create visually stunning, emotionally engaging interfaces
users fall in love with.
```

## Avoiding "Persona Without Teeth"

A persona skill that only describes a philosophy but doesn't enforce it is useless. Ensure:

1. **Anti-patterns are specific** — not "avoid bad design" but "avoid Inter font, purple gradients, predictable layouts"
2. **Principles lead to action** — "Study before acting" → "Examine existing patterns, conventions, and commit history before implementing"
3. **The persona changes output** — if removing the persona wouldn't change the agent's behavior, it's too generic

## Tips

- Keep principles to 5-7 (more = diluted)
- Anti-patterns are the most powerful section — make them specific
- The role definition paragraph matters more than the guidelines
- Persona skills are the shortest archetype (50-150 lines)
- Blend with Command Cookbook if the persona needs concrete tools
