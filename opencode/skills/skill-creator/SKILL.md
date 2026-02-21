---
name: skill-creator
description: >-
  Create and refine OpenCode SKILL.md files (agent skills) via a phased skill-creation workflow
  with frontmatter templates and naming/placement commands. Use when you need to create a skill,
  write a skill, draft a new skill, make a SKILL.md, build a skill for a repeated workflow,
  or design an agent skill.
---

# Skill Creator

Create high-quality OpenCode skills that agents actually load and use correctly.

## Quickstart

After loading this skill, do these steps immediately:

1. **Ask what the skill should do** — get a one-sentence answer from the user
2. **Run Triage** (Phase 0) — confirm a new skill is warranted
3. **Write the description first** (Phase 1) — this is the most important line
4. **Pick archetype + generate structure** (Phases 2-3)
5. **Validate + test activation** (Phases 4-5)

## Output Contract — "Done" Means

A skill is **done** when you have produced:

1. **A valid skill directory** at `~/.config/opencode/skills/<name>/SKILL.md` (global) or `.opencode/skills/<name>/SKILL.md` (project-local)
2. **A SKILL.md** with:
   - YAML frontmatter: `name` (kebab-case, matches dir) + `description` (trigger-dense)
   - Body: mission, triggers, workflow/commands, anti-patterns
   - References to any `rules/` files used
3. **Optional `rules/` files** if templates or checklists were needed
4. **Validation evidence**: frontmatter schema check, name/path match, no secrets
5. **Activation tests**: 5 simulated prompts:
   - 3 that SHOULD load the skill (contain trigger phrases)
   - 2 that SHOULD NOT load (near-miss prompts)
   - One-line expectation for each ("loads" / "doesn't load")

---

## When to Use Me

- User asks to create, write, build, or draft a new skill
- User asks to improve or refactor an existing SKILL.md
- User mentions SKILL.md, agent skill, or opencode skill
- User wants to automate a repeated workflow as a reusable skill
- User asks "how do I make a skill?"

## When NOT to Use Me

- User wants to **use** an existing skill (just load it)
- User wants project-specific AGENTS.md rules (different system)
- The task is a one-off (see Triage below)
- User wants to list or search available skills

---

## Phase 0: Triage — Is a New Skill Warranted?

**BLOCKING — Do not proceed to Phase 1 unless ALL checks pass.**

| Check | Threshold | Question |
|-------|-----------|----------|
| **Reuse** | ≥3 times | Has this workflow been needed 3+ times across sessions? (Or does user explicitly request it now?) |
| **Payoff** | ≥10 min saved | Will the skill save ≥10 minutes per reuse, or reduce meaningful risk? |
| **Stability** | Won't change this week | Is the workflow stable, not still being explored? |
| **Scope** | One sentence, no "and" | Can it be described in one sentence without "and"? |
| **Non-duplication** | No existing skill covers it | Could an existing skill be extended with a small patch instead? |

### If a Check Fails

| Failed check | Default action |
|-------------|----------------|
| Reuse / Payoff / Stability | Produce a **one-off response or template**, not a skill |
| Scope | **Split** into multiple skills |
| Non-duplication | **Extend** the existing skill instead of creating a new one |

**Skill budget**: At most 1 new skill per request unless the user insists and the reuse threshold is met.

**Ask the user** if the answer to any check is unclear. Do not guess.

---

## Phase 1: Description-First Authoring

**The description is the most important line in the entire skill.** It's the ONLY thing the agent sees when deciding whether to load. The body is invisible until after loading.

### Description Formula

```
[Action verb] [specific objects] via [tool/mechanism].
Use when [literal trigger phrase 1], [trigger phrase 2], or [trigger phrase 3].
```

### Rules

1. **Front-load action verbs**: Create, Query, Automate, Test, Deploy, Generate
2. **Include literal trigger phrases** the user would say — these are keyword matches
3. **Name the tools/mechanisms** involved (CLI, API, MCP server, workflow, etc.)
4. **Stay under 200 characters** for the core message (can extend to 1024 max)
5. **NEVER use vague words**: "help with", "assist in", "manage" — these match everything

### Good vs Bad Descriptions

```
GOOD: "Query Azure DevOps work items, bugs, user stories, and sprint data
       via the az CLI. Use when tickets, work items, or ADO IDs are mentioned."
  → Clear action, specific objects, named tool, explicit triggers

BAD:  "Help manage Azure DevOps tasks and projects."
  → Vague verb, no tool, no triggers, matches too broadly
```

### Write the Description FIRST

Before writing any body content:
1. Draft the description
2. List 5 prompts that SHOULD trigger this skill
3. List 3 prompts that SHOULD NOT trigger this skill
4. Verify the description contains keywords from all 5 positive prompts
5. Verify none of the 3 negative prompts would false-positive match

**Do not proceed to Phase 2 until the description passes this test.**

---

## Phase 2: Scope & Boundaries

### Name Rules

- **Format**: kebab-case, lowercase alphanumeric + hyphens only
- **Regex**: `^[a-z0-9]+(-[a-z0-9]+)*$`
- **Must match** the directory name exactly
- **Good**: `git-master`, `azure-devops`, `skill-creator`, `api-tester`
- **Bad**: `GitMaster`, `azure_devops`, `my skill`, `SKILL-CREATOR`

### Scope Test

Complete this sentence:

> "This skill teaches an agent to ________________."

- If the blank needs "and" → **split into two skills**
- If the blank is longer than 15 words → **too broad, narrow it**
- If the blank is vague ("do stuff with X") → **get more specific**

### Location Decision

| Location | When to use |
|----------|-------------|
| `~/.config/opencode/skills/<name>/` | Global — useful across all projects |
| `.opencode/skills/<name>/` | Project-local — specific to one codebase |

Default to **global** unless the skill references project-specific paths, configs, or conventions.

### Archetype Selection

Choose the PRIMARY archetype, then 0-1 secondary:

| Archetype | Best for | Signature pattern | Example |
|-----------|----------|-------------------|---------|
| **Workflow Engine** | Multi-step processes | Phases, decision trees, blocking gates | git-master |
| **Command Cookbook** | Tool/CLI usage | Copy-paste commands, parameter tables | azure-devops |
| **Tool Reference** | API/MCP integration | Tool listings, input schemas | playwright |
| **Persona** | Qualitative judgment | Principles, taste, anti-patterns | frontend-ui-ux |

**Most good skills blend 2 archetypes.** The best (dev-browser) blends 3: Tool Reference + Workflow Engine + Error Recovery.

For detailed templates per archetype, see:
- [rules/template-workflow-engine.md](rules/template-workflow-engine.md)
- [rules/template-command-cookbook.md](rules/template-command-cookbook.md)
- [rules/template-tool-reference.md](rules/template-tool-reference.md)
- [rules/template-persona.md](rules/template-persona.md)

---

## Phase 3: Generate Files

### Frontmatter (Required)

```yaml
---
name: my-skill-name          # REQUIRED — kebab-case, must match directory
description: >-               # REQUIRED — the billboard (see Phase 1)
  Action verb objects via mechanism.
  Use when trigger phrases.
---
```

For the full frontmatter schema including optional fields (`license`, `compatibility`, `metadata`, `mcp`), see [rules/frontmatter-schema.md](rules/frontmatter-schema.md).

### Body Structure — Minimal Skeleton

Every skill body follows this skeleton. Adapt based on archetype:

```markdown
# Skill Title

[One-line mission statement]

## When to Use Me
[Trigger scenarios — 3-7 bullet points]

## When NOT to Use Me
[Explicit boundary — what this skill does NOT cover]

## [Core Content: Workflow Phases / Commands / API / Principles]
[The actual substance — organized by the primary archetype's pattern]

## Anti-Patterns (NEVER)
[Forbidden behaviors — 3-part format: action, consequence, alternative]

## Error Recovery
[What to do when things fail]
```

### First Screen Rule

The first thing an agent sees after loading is the top of the body. It MUST contain:

1. **What this skill does** (1 line)
2. **When to use it** (3-7 bullet points)
3. **The first concrete action** (command, decision, or template)

Do NOT start with philosophy, history, or architecture. Start with action.

### Anti-Pattern Format

Anti-patterns ("NEVER do X") constrain LLM behavior MORE effectively than positive guidance ("prefer Y"). Each needs all three parts:

```markdown
- **NEVER** [specific action] — [why it's bad] → [what to do instead]
```

### Length Guidelines

| Complexity | Target Lines | Example |
|------------|-------------|---------|
| Simple (single tool/command) | 50-100 | azure-devops |
| Medium (workflow + commands) | 100-200 | dev-browser |
| Complex (multi-mode + phases) | 200-400 | git-master |

**Hard max**: 600 lines for SKILL.md. Move reference content to `rules/` subdirectory.

**Rule of thumb**: If a section exceeds 50 lines, move it to `rules/` and link: `See [rules/topic.md](rules/topic.md)`.

### Using rules/ Subdirectory

Files in `rules/` are **NOT auto-read** — the agent only sees them when SKILL.md explicitly tells it to open them. Use `rules/` for:

- Template libraries (one per archetype)
- Extended checklists
- Example galleries
- Schema references

**Always include a relative link** from SKILL.md: `[rules/filename.md](rules/filename.md)`

---

## Phase 4: Validation

Run this checklist before delivering. **Every item must pass.**

### Frontmatter

- [ ] `name` present and matches regex `^[a-z0-9]+(-[a-z0-9]+)*$`
- [ ] `name` matches directory name exactly
- [ ] `description` present, 1-1024 characters
- [ ] `description` starts with an action verb
- [ ] `description` contains literal trigger phrases
- [ ] No unknown frontmatter keys
- [ ] YAML is valid (no tabs, proper quoting)

### Structure

- [ ] Body starts with `# Title`
- [ ] "When to Use Me" section within first 20 lines of body
- [ ] At least one code block or command example
- [ ] Anti-patterns section exists
- [ ] No single section exceeds 80 lines

### Quality

- [ ] Description passes the 5-positive / 3-negative prompt test
- [ ] Scope passes the one-sentence test
- [ ] First screen shows action, not philosophy
- [ ] Every BLOCKING gate has explicit pass/fail criteria
- [ ] Every "NEVER" has a reason AND alternative
- [ ] Placeholders clearly marked (`<NAME>` format)
- [ ] No vague verbs: "help", "assist", "manage", "handle"

For the extended quality checklist, see [rules/quality-checklist.md](rules/quality-checklist.md).

### File System Check

```bash
# Verify the file exists
ls -la ~/.config/opencode/skills/<name>/SKILL.md

# Verify name matches directory
# Directory: my-skill/ → name: my-skill ✓
# Directory: my-skill/ → name: mySkill  ✗
```

---

## Phase 5: Activation Testing

Before delivering, simulate prompts to verify the description triggers correctly.

### Generate 5 Test Prompts

**3 Positive** (SHOULD activate):
1. State the prompt
2. Identify which keyword(s) in the description match
3. Confirm the match is correct

**2 Negative** (SHOULD NOT activate):
1. State the prompt
2. Confirm no description keywords false-positive match
3. If any DO match → refine the description

### Example Activation Test

```
POSITIVE (should load):
  "Create a skill for docker deployment"     → "create a skill"    ✓
  "I need a new SKILL.md for testing"        → "SKILL.md"          ✓
  "Write an agent skill for linting"         → "write a skill"     ✓

NEGATIVE (should NOT load):
  "What skills are installed?"               → informational       ✓
  "Load the git-master skill"                → using, not creating ✓
```

If any test fails, go back to Phase 1 and revise the description.

---

## Anti-Patterns (NEVER)

- **NEVER** skip Triage — unnecessary skills pollute the registry and confuse activation → Run the 5-check triage first
- **NEVER** write the body before the description — the description is the product; the body is the manual → Description-first, always
- **NEVER** use vague descriptions ("help with", "manage", "assist") — they match everything and distinguish nothing → Specific action verbs + literal triggers
- **NEVER** make a skill that requires "and" to describe — it's two skills → Split at the "and"
- **NEVER** hardcode versions, paths, or org names — they go stale → Use `<PLACEHOLDER>` notation
- **NEVER** write a skill for a one-off task — skills are for repeated workflows → Suggest AGENTS.md or a one-off template instead
- **NEVER** exceed 600 lines in SKILL.md — wall of text → Move reference content to `rules/`
- **NEVER** create a skill that overlaps an existing skill's domain without checking → Extend the existing skill or clearly differentiate

---

## Quick Reference: File Locations

```
Global skills (all projects):
  ~/.config/opencode/skills/<name>/SKILL.md

Project-local skills:
  .opencode/skills/<name>/SKILL.md

Alternative paths (also supported):
  .claude/skills/<name>/SKILL.md
  .agents/skills/<name>/SKILL.md

Modular rules (NOT auto-read — must be linked from SKILL.md):
  <skill-dir>/rules/<topic>.md
```
