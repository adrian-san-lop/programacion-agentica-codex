# MCP — Model Context Protocol

Protocolo para conectar agentes con herramientas y fuentes externas de forma estandarizada.

## MCP — Model Context Protocol

MCP es un protocolo que permite conectar agentes con herramientas y fuentes externas de una forma estandarizada.

Por ejemplo:

```text
Codex
  │
  ├── MCP Power BI
  ├── MCP Fabric
  ├── MCP SQL
  ├── MCP GitHub
  └── MCP filesystem
```

Un **MCP Server** puede exponer diferentes capacidades.

Entre ellas, Tools.

Ejemplo conceptual:

```text
Power BI MCP
     │
     ├── get_measures
     ├── execute_dax
     ├── get_model_schema
     ├── create_measure
     └── update_measure
```

El desarrollador normalmente configura **el servidor MCP**, no cada una de sus Tools manualmente.

---

---


---

## MCP y Tools

Una distinción fundamental:

```text
MCP Server
=
servidor que expone capacidades
```

Mientras que:

```text
Tool
=
una capacidad concreta
```

Por ejemplo:

```text
Power BI MCP Server
│
├── Tool: get_tables
├── Tool: get_measures
├── Tool: execute_dax
├── Tool: create_measure
└── Tool: update_measure
```

Tú normalmente configuras:

```text
Power BI MCP Server
```

y el servidor anuncia las Tools que tiene disponibles.

No necesitas escribir manualmente todas esas Tools en:

```text
AGENTS.md
```

ni necesariamente en:

```text
config.toml
```

---


[← Anterior](../03-tools/09-guia-practica-tools-en-codex.md) · [Índice](../../README.md) · [Siguiente →](01-configuracion.md)

