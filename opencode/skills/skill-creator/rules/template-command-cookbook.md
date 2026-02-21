# Template: Command Cookbook

**Use when**: The skill is primarily about providing copy-paste commands for a tool or CLI.
**Examples**: azure-devops.
**Signature**: Grouped commands, placeholder parameters, expected output, tips.

## Skeleton

```markdown
---
name: <skill-name>
description: >-
  <Action verb> <objects> via <tool/CLI>.
  Use when <trigger phrases>.
---

# <Skill Title>

## What I Do

<1-2 sentences: what tool, what it's for, authentication status.>

## When to Use Me

- <Trigger scenario 1>
- <Trigger scenario 2>
- <Trigger scenario 3>

## When NOT to Use Me

- <Boundary 1>
- <Boundary 2>

## Commands

### <Task Group 1: e.g., "Get a specific item">

\```bash
<full command with placeholders clearly marked>
\```

### <Task Group 2: e.g., "Search by keyword">

\```bash
<full command>
\```

### <Task Group 3: e.g., "List active items">

\```bash
<full command>
\```

## Reading Results Effectively

<How to interpret output — what fields matter, what to look for.>

1. **Always <do X>** in addition to <Y>
2. **Pay attention to <Z>** — it often contains <important info>
3. **Recommended workflow**: First <step 1>, then <step 2>

## Tips

- <Tip about output format>
- <Tip about common fields>
- <Tip about limitations>
- Replace `<YOUR_ORG>` and `<YOUR_PROJECT>` with actual values
```

## Key Patterns

### Placeholder Convention
Always use angle brackets with SCREAMING_CASE:
```
<YOUR_ORG>, <PROJECT_NAME>, <ITEM_ID>, <KEYWORD>
```

### Command Grouping
Group by **task** (what the user wants to do), not by **command** (the tool's subcommand):
```markdown
## Commands

### Get a specific work item       ← Task-oriented ✓
### Search by keyword               ← Task-oriented ✓
### List my active items            ← Task-oriented ✓

## NOT:
### az boards work-item show        ← Tool-oriented ✗
### az boards query                 ← Tool-oriented ✗
```

### Expected Output
When output format matters, show what to expect:
```markdown
### Get item details

\```bash
az boards work-item show --id <ID> --output json
\```

Returns JSON with fields: `System.Title`, `System.State`, `System.Description`.
```

### Workarounds
When the primary tool can't do something, provide alternatives:
```markdown
### Get comments (workaround)

The CLI does not support this directly. Use the REST API:

\```bash
curl -s -u ":<TOKEN>" "https://api.example.com/items/<ID>/comments"
\```
```

## Tips

- Keep commands to 10-15 max (more = reference doc, not a skill)
- Every command should be copy-pasteable with only placeholder substitution
- Group by user intent, not by tool syntax
- Add "Tips" section for non-obvious gotchas
- Include `--output json` or equivalent for parseable results
