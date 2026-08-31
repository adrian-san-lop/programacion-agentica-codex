# Accounting PBIP Agent

## Objective

Work safely and reproducibly on the Accounting Power BI project in PBIP format.

## Language rule

Even when the user prompt is written in Spanish, all agent responses, documentation, explanations, generated content, and descriptive names must be written in English unless the user explicitly requests another language.

## Project structure

- `*.pbip`: project entry point.
- `*.Report/`: report definition, pages, visuals, and bookmarks.
- `*.SemanticModel/`: semantic model definition, tables, columns, measures, and relationships.
- `docs/`: functional and technical documentation.
- `skills/`: specialized procedures.
- `tools/`: catalogue of available or expected capabilities.
- `.vscode/mcp.json`: local Power BI Modeling MCP registration.

## General rules

1. Inspect the actual project structure before editing files.
2. Never assume table, column, or measure names; verify them in the model.
3. Read only the documentation relevant to the task.
4. Do not modify local settings or cache files.
5. Do not delete, rename, or overwrite elements without explicit confirmation.
6. Keep report and semantic model changes separate.
7. Always explain which files were modified and why.

## DAX task workflow

1. Read `skills/dax/SKILL.md`.
2. Consult `docs/semantic-model.md`.
3. Locate the affected measure, table, or column.
4. Review dependencies and filter context.
5. Propose the change before applying it if results may change.
6. Validate syntax and results.
7. Document relevant decisions.

## MCP connection workflow

1. Read `docs/mcp-setup.md`.
2. For live Desktop work, ensure the target PBIP is open in Power BI Desktop.
3. Use `ConnectToPowerBIDesktop` for the live local model or `ConnectToPBIP` for definitions on disk.
4. Start with read-only inspection.
5. Require explicit approval before write operations.

## Report task workflow

1. Read `skills/report-design/SKILL.md`.
2. Identify the affected page, visual, or bookmark.
3. Check whether the change depends on model measures or fields.
4. Avoid mass changes to JSON files without subsequent validation in Power BI Desktop.

## Reference documentation

- Model: `docs/semantic-model.md`
- DAX: `docs/dax-rules.md`
- Sources: `docs/data-sources.md`
- Deployment: `docs/deployment.md`

## Definition of done

A task is complete when the change is applied or clearly documented, available validation has been run, and any pending Power BI Desktop checks are stated.
