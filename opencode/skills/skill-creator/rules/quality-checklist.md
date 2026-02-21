# Quality Checklist — Extended

Use this checklist for thorough validation. The abbreviated version is in the main SKILL.md Phase 4.

## 1. Description Quality

- [ ] Starts with a strong action verb (Create, Query, Automate, Test, Deploy, Generate)
- [ ] Contains the specific objects/domain the skill covers
- [ ] Names the tool, CLI, API, or mechanism used
- [ ] Includes 3+ literal trigger phrases users would say
- [ ] Under 200 characters for the core message
- [ ] No vague verbs: "help", "assist", "manage", "handle", "support"
- [ ] No filler words: "easily", "efficiently", "seamlessly"
- [ ] Passes 5-positive / 3-negative activation test

## 2. Frontmatter Validity

- [ ] `name` matches `^[a-z0-9]+(-[a-z0-9]+)*$`
- [ ] `name` matches the directory name character-for-character
- [ ] `description` is between 1-1024 characters
- [ ] Only known keys used: name, description, license, compatibility, metadata, mcp
- [ ] YAML uses spaces (no tabs)
- [ ] Multi-line strings use `>-` or `|` properly
- [ ] No secrets or API keys in frontmatter (use `${ENV_VAR}` for mcp)

## 3. Structure

- [ ] File starts with YAML frontmatter (`---` delimiters)
- [ ] Body starts with `# Title` heading
- [ ] "When to Use Me" appears within first 20 lines of body
- [ ] "When NOT to Use Me" section exists (explicit boundaries)
- [ ] At least one code block or command example exists
- [ ] Anti-Patterns section exists with 3+ items
- [ ] No section exceeds 80 lines (split to rules/ if needed)
- [ ] Total SKILL.md under 600 lines

## 4. Content Quality

- [ ] First screen = action (mission + triggers + first step), not philosophy
- [ ] Every BLOCKING gate has explicit pass/fail criteria
- [ ] Every anti-pattern has all 3 parts: action, consequence, alternative
- [ ] Every code block is copy-pasteable (only placeholder substitution needed)
- [ ] Placeholders use `<SCREAMING_CASE>` format
- [ ] No hardcoded versions, paths, or organization names
- [ ] Decision logic uses tables, not prose paragraphs
- [ ] Commands grouped by user intent, not tool syntax

## 5. Scope Discipline

- [ ] Skill can be described in one sentence without "and"
- [ ] The one-sentence description is under 15 words
- [ ] Scope doesn't overlap with any existing installed skill
- [ ] Skill has clear boundaries (what it does NOT do)
- [ ] If multi-mode, has ≤4 modes with a detection table

## 6. Archetype Adherence

### If Workflow Engine:
- [ ] Has numbered phases with entry/exit criteria
- [ ] Has at least one BLOCKING gate
- [ ] Has a decision table
- [ ] Each phase defines what "done" looks like

### If Command Cookbook:
- [ ] Commands grouped by task (not alphabetically)
- [ ] Each command has a complete copy-paste example
- [ ] Placeholders clearly marked
- [ ] Expected output format described

### If Tool Reference:
- [ ] Tools grouped by use-case
- [ ] Input schemas shown (parameter tables)
- [ ] Minimal working examples included
- [ ] Workflow Integration section prevents "API dump" trap

### If Persona:
- [ ] Role definition changes agent behavior (not generic)
- [ ] Anti-patterns are specific (named bad patterns, not "avoid bad things")
- [ ] Principles are actionable, not philosophical
- [ ] DO/DON'T contrasts with concrete examples

## 7. File System

- [ ] SKILL.md is at the correct path (global or project-local)
- [ ] Directory name matches `name` in frontmatter
- [ ] Any `rules/` files are linked from SKILL.md with relative paths
- [ ] No sensitive files (secrets, credentials) in the skill directory

## 8. Activation Testing

- [ ] 3 positive prompts that SHOULD trigger — all match description keywords
- [ ] 2 negative prompts that SHOULD NOT trigger — none false-positive match
- [ ] If any negative prompt matches, description has been refined
