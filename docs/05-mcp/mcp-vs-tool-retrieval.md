# MCP vs Tool Retrieval

MCP describe la conexión y las capacidades; Tool Retrieval describe cómo se presentan al modelo.

# 26. MCP vs Tool Retrieval

MCP y Tool Retrieval **NO son lo mismo**.

MCP responde principalmente a:

> ¿Qué capacidades ofrece este servidor y cómo puedo invocarlas?

Tool Retrieval responde a:

> De todas las Tools disponibles, ¿qué definiciones necesito cargar en el contexto del LLM ahora?

Por ejemplo:

```text
Power BI MCP
      ↓
expone 80 Tools
      ↓
¿Cómo se las proporcionamos al LLM?
      │
      ├──────────────┐
      ▼              ▼
   Upfront        Retrieval
      │              │
80 schemas      sólo relevantes
      │              │
      └──────┬───────┘
             ▼
            LLM
```

Por tanto:

> MCP por sí solo no implica necesariamente Progressive Disclosure de Tools.

La estrategia utilizada para proporcionar esas Tools al LLM depende del runtime/agente.

---

