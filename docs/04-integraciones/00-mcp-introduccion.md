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

Entre ellas, Tools e instrucciones generales para utilizarlas. En Codex, las instrucciones del servidor se leen durante la inicialización y sirven como orientación común para sus Tools; no sustituyen a `AGENTS.md` ni al system prompt interno de Codex.

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

## Host, cliente y servidor

Estos nombres describen posiciones distintas en la conexión:

```text
Host o aplicación que ejecuta la experiencia
  ↓
Cliente MCP integrado en el runtime
  ↓
Servidor MCP
  ├── Tools
  ├── Resources
  ├── Prompts
  └── instrucciones del servidor
```

En el curso, Codex es la experiencia de agente que utilizamos en VS Code. El cliente MCP forma parte del entorno que conecta Codex con un servidor, y el servidor es el componente que ofrece capacidades sobre Power BI, Fabric u otro sistema. Un servidor no es el modelo y una Tool no es el servidor completo.

MCP tampoco garantiza que todas las capacidades anunciadas se presenten siempre al modelo ni que puedan ejecutarse sin permisos. La conexión, el descubrimiento, la selección y la autorización son preguntas relacionadas, pero distintas.

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

Para recordar la relación:

```text
MCP       → protocolo y conexión
Servidor  → componente que expone capacidades
Tool      → operación ejecutable concreta
Runtime   → decide cómo incorporar y ejecutar esa capacidad
```

---


[← Anterior](../03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md) · [Índice](../../README.md) · [Siguiente →](01-configuracion.md)

