# Template: Workflow Engine

**Use when**: The skill guides a multi-step process with decisions, gates, and phases.
**Examples**: git-master, this skill-creator skill itself.
**Signature**: Numbered phases, decision tables, BLOCKING checkpoints, clear entry/exit criteria.

## Skeleton

```markdown
---
name: <skill-name>
description: >-
  <Action verb> <objects> via <mechanism>.
  Use when <trigger phrases>.
---

# <Skill Title>

<One-line mission: what this skill produces.>

## Quickstart

1. <First action after loading>
2. <Second action>
3. <Continue to phases below>

## When to Use Me

- <Trigger scenario 1>
- <Trigger scenario 2>
- <Trigger scenario 3>

## When NOT to Use Me

- <Boundary 1>
- <Boundary 2>

---

## Mode Detection (if multi-mode)

| User Request Pattern | Mode | Jump To |
|---------------------|------|---------|
| "<pattern 1>" | MODE_A | Phase A1 |
| "<pattern 2>" | MODE_B | Phase B1 |

---

## Phase 1: <Name>

**Entry criteria**: <what must be true to start this phase>
**BLOCKING**: <what must be verified before proceeding>

<Phase content — steps, decisions, actions>

### Decision Point

| Condition | Action |
|-----------|--------|
| <If X> | <Do Y> |
| <If A> | <Do B> |

---

## Phase 2: <Name>

**Entry criteria**: Phase 1 complete
**BLOCKING**: <gate>

<Phase content>

---

## Phase 3: <Name>

<Continue pattern...>

---

## Anti-Patterns (NEVER)

- **NEVER** <action> — <consequence> → <alternative>
- **NEVER** <action> — <consequence> → <alternative>

## Error Recovery

| Error | Cause | Fix |
|-------|-------|-----|
| <Error 1> | <Why> | <What to do> |
| <Error 2> | <Why> | <What to do> |

## Quick Reference

<Cheat sheet table or summary for fast lookup>
```

## Key Patterns

### BLOCKING Gates
Use these at phase transitions to force verification:
```markdown
**BLOCKING — Do not proceed until <condition>.**
```

### Decision Tables
Use tables over prose for branching logic:
```markdown
| Condition | Action |
|-----------|--------|
| X is true | Do A |
| Y is true | Do B |
| Neither   | Ask user |
```

### Mandatory Output
Force the agent to show its work before proceeding:
```markdown
**MANDATORY OUTPUT — Print this before moving to Phase N:**
```

## Tips

- Keep phases to 3-6 (more = agent loses track)
- Every phase should have entry criteria and a BLOCKING gate
- Put the most common path first, edge cases second
- Decision tables are more reliable than if/else prose
- Consider a "Quick Reference" section at the end for returning users
