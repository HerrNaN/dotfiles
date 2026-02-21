# Frontmatter Schema Reference

## Required Fields

| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| `name` | string | kebab-case, regex: `^[a-z0-9]+(-[a-z0-9]+)*$`, must match directory name | Unique skill identifier |
| `description` | string | 1-1024 characters, should start with action verb | The ONLY loading signal — agent sees this before deciding to load |

## Optional Fields

| Field | Type | Description |
|-------|------|-------------|
| `license` | string | License identifier (e.g., `MIT`, `Apache-2.0`) |
| `compatibility` | object | Version constraints for opencode |
| `metadata` | object | Arbitrary key-value pairs (author, version, tags) |
| `mcp` | object | **(oh-my-opencode only)** Auto-provision MCP servers when skill loads |

## Full Example

```yaml
---
name: my-skill-name
description: >-
  Create and deploy Docker containers via docker CLI and Dockerfile templates.
  Use when asked to containerize, dockerize, write a Dockerfile, or deploy containers.
license: MIT
compatibility:
  opencode: ">=1.0.0"
metadata:
  author: "your-name"
  version: "1.0.0"
  tags: ["docker", "containers", "deployment"]
mcp:
  mcpServers:
    my-mcp-server:
      command: npx
      args: ["-y", "@my-org/my-mcp-server"]
      env:
        API_KEY: "${MY_API_KEY}"
---
```

## MCP Auto-Provisioning (oh-my-opencode)

The `mcp` field auto-provisions MCP servers when the skill is loaded. Structure:

```yaml
mcp:
  mcpServers:
    <server-name>:
      command: <executable>        # e.g., npx, node, python
      args: [<arg1>, <arg2>]       # Command arguments
      env:                         # Optional environment variables
        KEY: "value"
        SECRET: "${ENV_VAR}"       # Reference env vars with ${} syntax
```

**NEVER** hardcode secrets in the `mcp` field. Always use `${ENV_VAR}` references.

## Common Mistakes

| Mistake | Problem | Fix |
|---------|---------|-----|
| `name: mySkill` | Not kebab-case | `name: my-skill` |
| `name: my-skill` in dir `myskill/` | Name/dir mismatch | Make them identical |
| `description:` (empty) | No loading signal | Write a trigger-dense description |
| `description: "Helps with stuff"` | Too vague | Use formula: verb + objects + mechanism + triggers |
| Using tabs in YAML | Parse error | Use spaces only |
| Unknown key `author:` at top level | Schema violation | Put it under `metadata:` |
