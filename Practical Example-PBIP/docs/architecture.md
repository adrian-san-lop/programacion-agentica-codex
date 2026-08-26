# Project architecture

## Layers

```text
PBIP project
├── Report
├── Semantic model
├── Agent context
├── Skills
├── Tools
└── Validation
```

## Responsibilities

| Area | Responsibility |
|---|---|
| Report | Pages, visuals, filters, and bookmarks |
| Semantic model | Tables, columns, measures, and relationships |
| `AGENTS.md` | Agent operating rules |
| `docs/` | Business and project-specific knowledge |
| `skills/` | Procedures for specific tasks |
| `tools/` | Capabilities the agent can invoke or discover |
| `scripts/` | Repeatable local checks |

## Operating principle

The agent should retrieve the minimum required context first and expand it only when the task requires it.
