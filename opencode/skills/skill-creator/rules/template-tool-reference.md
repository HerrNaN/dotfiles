# Template: Tool Reference

**Use when**: The skill documents an API surface, MCP server tools, or library interface.
**Examples**: playwright.
**Signature**: Tool listings with input schemas, minimal examples, use-case grouping.

## Skeleton

```markdown
---
name: <skill-name>
description: >-
  <Action verb> <objects> via <tool/MCP server>.
  Use when <trigger phrases>.
---

# <Skill Title>

<One-line: what this tool does and when to use it.>

## Setup

<Any initialization, installation, or connection steps needed before using the tools.>

\```bash
<setup command if needed>
\```

## When to Use Me

- <Trigger scenario 1>
- <Trigger scenario 2>

## Tools by Use Case

### <Use Case 1: e.g., "Navigation">

#### `<tool_name>`
<One-line description>

**Parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| `param1` | string | yes | <what it does> |
| `param2` | boolean | no | <what it does> |

**Example:**
\```typescript
// <what this accomplishes>
await tool_name({ param1: "value" });
\```

#### `<tool_name_2>`
<Same pattern...>

### <Use Case 2: e.g., "Data Extraction">

<Same pattern...>

## Workflow Integration

<How these tools fit together in a typical workflow. This section prevents the skill from being a pure API dump.>

1. **Start**: <first tool to use>
2. **Iterate**: <tools for the main loop>
3. **Finish**: <cleanup tools>

## Anti-Patterns (NEVER)

- **NEVER** <common misuse> — <consequence> → <correct approach>

## Error Recovery

| Error | Cause | Fix |
|-------|-------|-----|
| <Error 1> | <Why> | <What to do> |
```

## Key Patterns

### Use-Case Grouping (NOT Alphabetical)
```markdown
## Tools by Use Case

### Navigation          ← What the user wants to do
### Form Interaction    ← What the user wants to do  
### Data Extraction     ← What the user wants to do

## NOT:
### browser_click       ← Alphabetical tool list
### browser_fill        ← Alphabetical tool list
### browser_navigate    ← Alphabetical tool list
```

### Schema Tables
For tools with parameters, use tables:
```markdown
| Name | Type | Required | Description |
|------|------|----------|-------------|
| `url` | string | yes | The URL to navigate to |
| `timeout` | number | no | Max wait in ms (default: 30000) |
```

### MCP Tool Invocation
If the skill wraps an MCP server, show the invocation pattern:
```markdown
Use `skill_mcp` with `mcp_name="<server>"` to invoke:

\```
skill_mcp(mcp_name="my-server", tool_name="my_tool", arguments={"key": "value"})
\```
```

## Avoiding the "API Dump" Trap

A pure tool listing without workflow guidance is the **weakest** skill archetype. Always add:

1. **Workflow Integration section** — how tools compose into a loop
2. **"Choosing Your Approach" section** — when to use which tool
3. **Error Recovery** — what to do when tools fail

This transforms a reference into a useful skill. The best tool reference skills (dev-browser) blend in Workflow Engine patterns.

## Tips

- Group by use-case, never alphabetically
- Show the minimal working example, not every parameter combination
- Add a Workflow Integration section to avoid being a pure API dump
- Include Error Recovery — tools fail, and agents need guidance on what to do next
