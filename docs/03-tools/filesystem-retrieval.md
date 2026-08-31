# Filesystem Retrieval

Implementación de Tool Retrieval basada en definiciones almacenadas en archivos.

## Una implementación de Tool Retrieval: Filesystem Retrieval

**Filesystem Retrieval** es una posible implementación de Retrieval utilizando archivos.

Por ejemplo:

```text
tools/
├── execute-dax.md
├── get-measures.md
├── get-tables.md
├── update-measure.md
└── create-measure.md
```

El agente no necesita cargar todos esos archivos desde el principio.

Podría tener un índice ligero.

Por ejemplo:

```text
execute-dax      → execute DAX queries
get-measures     → inspect semantic model measures
get-tables       → inspect model tables
update-measure   → modify an existing measure
create-measure   → create a new measure
```

Ante:

```text
"¿Cuántas ventas tuvimos este año?"
```

podría ocurrir:

```text
LLM
 ↓
"Necesito ejecutar DAX"
 ↓
semantic_search("execute DAX query")
 ↓
tools/execute-dax.md
 ↓
read_file(...)
 ↓
definición completa
 ↓
LLM
 ↓
execute_dax(...)
```

---

---


---

## Filesystem Retrieval no significa pasar sólo nombres

Una simplificación peligrosa sería:

```text
Filesystem Retrieval
=
pasar únicamente nombres de Tools
```

No necesariamente.

El índice ligero podría contener:

- Nombre.
- Descripción corta.
- Categoría.
- Keywords.
- Metadata.
- Embeddings.
- Información semántica.

Por ejemplo:

```text
Tool: execute_dax
Category: Power BI / DAX
Description: Execute a DAX query against a semantic model
```

Sin proporcionar todavía todo:

```text
JSON Schema
argumentos completos
documentación
ejemplos
casos especiales
```

La idea importante es:

> Descubrir primero qué Tool es relevante y cargar después la información detallada necesaria para utilizarla.

---


[← Anterior](tool-retrieval.md) · [Índice](../../README.md) · [Siguiente →](estrategia-hibrida.md)

