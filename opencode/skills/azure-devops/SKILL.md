---
name: azure-devops
description: >-
  Query, create, and update Azure DevOps work items, bugs, user stories, and sprint data
  via the az CLI. Use when tickets, work items, ADO IDs, sprints, or backlogs are mentioned.
---

# Azure DevOps

Query and manage Azure DevOps work items from the command line using `az boards`.
The CLI is already installed and authenticated.

## When to Use Me

- User mentions a work item ID (e.g., "ticket 1234", "bug 5678", "story 910")
- User asks about current sprint, backlog, or assigned work
- User wants to understand requirements before implementing
- User references ADO, Azure DevOps, or work items
- User needs the full context of a work item including discussion history
- User wants to create, update, or link work items
- User asks about parent/child relationships between work items

## When NOT to Use Me

- Managing ADO pipelines, repos, or artifacts (different CLI commands, not `az boards`)
- Admin tasks: permissions, process templates, org settings
- Pull request workflows (use `az repos pr` instead)
- Wiki or documentation management

---

## Setup — Configure Defaults

**Do this first.** Setting defaults eliminates `--org` and `--project` from every command.

```bash
az devops configure -d organization=https://dev.azure.com/<YOUR_ORG> project=<YOUR_PROJECT>
```

Verify defaults are set:

```bash
az devops configure -l
```

After configuration, all commands below work without `--org` and `--project` flags.
If the user has NOT configured defaults, append `--org https://dev.azure.com/<YOUR_ORG> --project <YOUR_PROJECT>` to each command.

---

## Commands — Read

### Get a specific work item

```bash
az boards work-item show --id <ID> --output json
```

### Get a work item with relations (parent, child, linked)

```bash
az boards work-item show --id <ID> --expand relations --output json
```

The `relations` field in the response contains linked work items with their relation type (`Parent`, `Child`, `Related`, etc.) and target URL. Extract the ID from the URL suffix.

### Get work item comments/discussion

```bash
curl -s -H "Authorization: Bearer $(az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798 --query accessToken -o tsv)" \
  "https://dev.azure.com/<YOUR_ORG>/<YOUR_PROJECT>/_apis/wit/workItems/<ID>/comments?api-version=7.1-preview.4&order=asc" \
  | jq '.comments[] | {id: .commentId, date: .createdDate, author: .createdBy.displayName, text: .text}'
```

This uses the already-authenticated `az` session — no separate PAT needed.
If `jq` is not available, omit the pipe and parse the raw JSON.

---

## Commands — Query (WIQL)

Always use `--output json` for parseable results.

### My active work items

```bash
az boards query --wiql "SELECT [System.Id], [System.Title], [System.State], [System.WorkItemType] FROM WorkItems WHERE [System.AssignedTo] = @Me AND [System.State] <> 'Closed' ORDER BY [System.ChangedDate] DESC" --output json
```

### Current sprint items

```bash
az boards query --wiql "SELECT [System.Id], [System.Title], [System.State], [System.AssignedTo] FROM WorkItems WHERE [System.IterationPath] = @CurrentIteration" --output json
```

### Search by title keyword

```bash
az boards query --wiql "SELECT [System.Id], [System.Title], [System.State] FROM WorkItems WHERE [System.Title] CONTAINS '<keyword>'" --output json
```

### Filter by tag

```bash
az boards query --wiql "SELECT [System.Id], [System.Title], [System.State] FROM WorkItems WHERE [System.Tags] CONTAINS '<tag>'" --output json
```

### Filter by area path

```bash
az boards query --wiql "SELECT [System.Id], [System.Title], [System.State] FROM WorkItems WHERE [System.AreaPath] UNDER '<PROJECT>\<AREA>'" --output json
```

### Recently changed (last N days)

```bash
az boards query --wiql "SELECT [System.Id], [System.Title], [System.State], [System.ChangedDate] FROM WorkItems WHERE [System.ChangedDate] >= @Today - 7 ORDER BY [System.ChangedDate] DESC" --output json
```

### Child items of a parent (link query)

```bash
az boards query --wiql "SELECT [System.Id], [System.Title], [System.State] FROM WorkItemLinks WHERE ([Source].[System.Id] = <PARENT_ID>) AND ([System.Links.LinkType] = 'System.LinkTypes.Hierarchy-Forward') MODE (MustContain)" --output json
```

---

## Commands — Write

### Create a work item

```bash
az boards work-item create --title "<TITLE>" --type "<TYPE>" --output json
```

Common options:

| Flag | Purpose | Example |
|------|---------|---------|
| `--type` | Work item type | `Bug`, `Task`, `User Story`, `Feature` |
| `--assigned-to` | Assignee email | `user@company.com` |
| `--description` | Description body | `"Steps to reproduce..."` |
| `--discussion` | Add a comment | `"Created from CLI"` |
| `--iteration` | Sprint path | `"Project\Sprint 5"` |
| `--area` | Area path | `"Project\Team"` |
| `--fields` | Custom fields | `"Priority=1 Severity=2 - High"` |

### Update a work item

```bash
az boards work-item update --id <ID> --state "Active" --output json
```

Update multiple fields:

```bash
az boards work-item update --id <ID> --fields "System.AssignedTo=user@company.com" "System.Title=New title" --output json
```

### Link work items (add relation)

```bash
az boards work-item relation add --id <ID> --relation-type <TYPE> --target-id <TARGET_ID> --output json
```

Common relation types: `Parent`, `Child`, `Related`, `Duplicate`, `Successor`, `Predecessor`.

### Remove a relation

```bash
az boards work-item relation remove --id <ID> --relation-type <TYPE> --target-id <TARGET_ID> --output json
```

---

## Workflow: Understanding Requirements

When fetching a work item to understand requirements:

1. **Get the work item** with `az boards work-item show --id <ID> --expand relations --output json`
2. **Fetch comments** via the REST API (see above) — comments often contain decisions, clarifications, and scope changes made after the original description
3. **Pay attention to timestamps** — newer comments may override earlier decisions in the description or acceptance criteria
4. **Check relations** — parent items provide broader context, child items show task breakdown
5. **Read both description AND acceptance criteria** — they are separate fields:
   - `[System.Description]` — overview/context
   - `[Microsoft.VSTS.Common.AcceptanceCriteria]` — specific requirements

---

## Anti-Patterns (NEVER)

- **NEVER** omit `--output json` — table/TSV output is unparseable and lossy → Always use `--output json`
- **NEVER** hardcode org URLs in repeated commands — they change per user → Use `az devops configure` defaults
- **NEVER** read only the description and skip comments — comments contain critical scope changes → Always fetch both
- **NEVER** ignore `--expand relations` when investigating work item context — parent/child links reveal scope → Expand relations when you need the full picture
- **NEVER** store PATs in command history or scripts — they are secrets → Use `az account get-access-token` for bearer auth

---

## Error Recovery

| Error | Cause | Fix |
|-------|-------|-----|
| `az: command not found` | Azure CLI not installed | Ask the user to install it: `curl -sL https://aka.ms/InstallAzureCLIDeb \| sudo bash` (Debian/Ubuntu) or see [install docs](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) |
| `Please run 'az login'` or `AADSTS700082` | Not logged in or token expired | Run `az login`. For headless/SSH environments use `az login --use-device-code` |
| `'boards' is not in the 'az' command group` | `azure-devops` extension not installed | Run `az extension add --name azure-devops` |
| `TF401019: The Git repository not found` | Wrong project or not in a git repo | Add `--project <PROJECT>` explicitly |
| `TF400813: Resource not available` | Auth expired or insufficient permissions | Run `az login` to re-authenticate |
| `The conditional access policy does not allow token issuance` | MFA/CA policy block | Run `az login --use-device-code` |
| `WIQL syntax error` | Malformed query | Check field names — use `[System.Title]` not `Title`. Use single quotes around string values in WIQL |
| `--expand is not a recognized argument` | Old CLI version | Run `az extension update --name azure-devops` |
| Empty results from query | Defaults not set, wrong project scope | Verify with `az devops configure -l` |

---

## Tips

- Work item IDs are numeric — extract from URLs like `.../_workitems/edit/1234`
- Use `--fields` to limit returned fields if output is too large
- `@Me` in WIQL resolves to the authenticated user
- `@CurrentIteration` resolves to the active sprint
- `@Today` resolves to the current date (use `@Today - N` for date math)
- WIQL uses `CONTAINS` for partial string match, `=` for exact match
- WIQL link queries use `MODE (MustContain)` — always include this for link queries
