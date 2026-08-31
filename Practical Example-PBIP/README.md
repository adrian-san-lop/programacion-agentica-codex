# Practical Example: PBIP Agent Workspace

Context and operating template for using a local agent alongside a Power BI project in PBIP format.

> This folder does not contain a `.pbip` file or the native `.Report` and `.SemanticModel` folders. Place it in the root folder that contains the real Power BI project.

## Usage

1. Copy this folder, or its contents, to the PBIP project root.
2. Open the project root in VS Code.
3. Open `AGENTS.md` and complete the project-specific model details.
4. Review `docs/semantic-model.md` and `docs/dax-rules.md`.
5. Use the Skills and Tools according to the task.
6. Run `scripts/validate-project.ps1` before delivering changes.

## Structure

- `AGENTS.md`: persistent instructions for the agent.
- `docs/`: project-specific knowledge.
- `skills/`: specialized workflows.
- `tools/`: expected capability catalogue.
- `scripts/`: local validation scripts.
- `.vscode/`: recommended text-editing settings.
- `.vscode/mcp.json`: local Power BI Modeling MCP registration.

## Requirement

The working root should contain a PBIP project with a structure similar to:

```text
accounting.pbip
accounting.Report/
accounting.SemanticModel/
```

Names may differ, but an actual report folder and semantic model folder must exist.

## Agent scope

The agent can inspect and document the project, review DAX, and propose changes. Actual query execution or modifications depend on the Tools and connections available in the local runtime.

## Documentation

- [Architecture](docs/architecture.md)
- [Semantic model](docs/semantic-model.md)
- [DAX rules](docs/dax-rules.md)
- [Data sources](docs/data-sources.md)
- [Deployment](docs/deployment.md)
- [Power BI MCP setup](docs/mcp-setup.md)
- [DAX Skill](skills/dax/SKILL.md)
- [Tools catalogue](tools/README.md)
