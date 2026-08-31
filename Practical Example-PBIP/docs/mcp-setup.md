# Power BI MCP setup

## What this file does

`.vscode/mcp.json` registers Microsoft's Power BI Modeling MCP server for VS Code MCP-compatible clients.

It does not contain credentials and it does not open Power BI Desktop automatically.

## Prerequisites

- Windows with Power BI Desktop installed.
- Node.js and `npx` available on `PATH`.
- VS Code with an MCP-compatible client, such as GitHub Copilot Chat.
- The real PBIP project opened in Power BI Desktop when connecting to the live Desktop model.

## Start the server

1. Open the actual project root in VS Code.
2. Ensure `.vscode/mcp.json` is present.
3. Open the MCP server view or Command Palette.
4. Start `powerbi-modeling-mcp`.
5. Approve the server if VS Code asks for confirmation.

The package is downloaded by `npx` on first use. Pin a tested package version instead of `latest` when reproducibility is required.

## Connect to Power BI Desktop

1. Open the real `accounting.pbip` in Power BI Desktop.
2. Wait until the report and semantic model are fully loaded.
3. Start the MCP server.
4. In the agent chat, use the MCP prompt `ConnectToPowerBIDesktop` or ask:

```text
Connect to the Power BI Desktop instance for accounting.pbip and inspect the semantic model.
```

The server discovers the local Analysis Services instance used by the running Power BI Desktop session.

## Connect to the PBIP files

When the goal is to inspect the project definition on disk rather than the live Desktop instance, use the MCP prompt `ConnectToPBIP` or ask:

```text
Connect to the PBIP project in this workspace and inspect its semantic model definition.
```

This uses the local `*.SemanticModel/` files. It is different from connecting to the live model currently loaded by Power BI Desktop.

## Connection modes

```text
VS Code
  ↓
Power BI Modeling MCP
  ├── ConnectToPowerBIDesktop → live local model
  └── ConnectToPBIP            → PBIP files on disk
```

## Smoke test

After connecting, ask:

```text
List the tables and measures available in the connected Accounting model.
```

Then test a read-only operation:

```text
Show me the definition of the Gross Margin YTD measure. Do not modify anything.
```

## Safety

- Start with read-only inspection.
- Keep Power BI Desktop open when using `ConnectToPowerBIDesktop`.
- Do not use `--skipconfirmation`.
- Review and approve write operations explicitly.
- Keep `.pbi/localSettings.json` and `.pbi/cache.abf` out of source control.
