# Tool Definitions Upfront

Estrategia que proporciona al modelo las definiciones completas de las herramientas desde el inicio.

## Estrategia A — Tool Definitions Upfront

La estrategia más sencilla consiste en proporcionar al LLM las definiciones completas de todas las Tools desde el principio.

```text
Petición al LLM
│
├── System Prompt
├── AGENTS.md
│
├── Tool: get_tables
│   ├── description
│   └── JSON Schema
│
├── Tool: get_measures
│   ├── description
│   └── JSON Schema
│
├── Tool: execute_dax
│   ├── description
│   └── JSON Schema
│
├── ...
│
└── User Prompt
```

El LLM conoce directamente cómo utilizar todas las Tools.

Por ejemplo:

```text
Usuario:
"Ejecuta esta consulta DAX"

        ↓

LLM ya conoce execute_dax

        ↓

Tool Call:

execute_dax(...)
```

### Ventaja

Es sencillo.

El LLM tiene inmediatamente toda la información necesaria.

### Problema

Si tenemos muchas Tools:

```text
100 Tools
×
nombre
×
descripción
×
JSON Schema
=
muchos tokens
```

Además, estamos introduciendo información sobre Tools que probablemente no sean necesarias.

Por tanto:

```text
Tool Definitions Upfront
        ↓
más Static Context
```

---



---

[← Anterior](mediacion-de-tools.md) · [Índice](../../README.md) · [Siguiente →](tool-retrieval.md)

