# MCP vs Tool Retrieval

MCP describe la conexión y las capacidades; Tool Retrieval describe cómo se presentan al modelo.

## MCP vs Tool Retrieval

MCP y Tool Retrieval **NO son lo mismo**.

Esta diferencia forma parte de un conjunto más amplio de conceptos relacionados. El mapa introductorio está disponible en [Conceptos que no deben confundirse](../00-introduccion/02-conceptos-que-no-deben-confundirse.md).

MCP describe la interfaz de integración. Upfront y Retrieval describen la estrategia del runtime para decidir qué Tools se presentan al LLM. Por tanto, un runtime puede usar Tool Retrieval sobre las Tools que descubre a través de MCP.

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



---

[← Anterior](02-credenciales.md) · [Índice](../../README.md) · [Siguiente →](../05-trabajo-en-equipo/00-introduccion.md)

