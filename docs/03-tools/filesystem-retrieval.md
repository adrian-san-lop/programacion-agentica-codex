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

## Aplicación más allá de las Tools

El mismo patrón sirve para documentación técnica y conocimiento de negocio. En lugar de añadir todas las métricas, notas de reuniones o decisiones de producto al contexto inicial, se pueden organizar en archivos recuperables:

```text
business_metrics/
├── ventas.md
├── retención.md
├── pipeline.md
└── definiciones.md
```

El agente puede buscar términos relevantes, leer sólo los archivos necesarios y utilizarlos para planificar o responder. La jerarquía, los nombres y las descripciones deben ser consistentes para que la recuperación sea fiable.

## Comparación con Cursor

Cursor ha documentado un mecanismo propio que sincroniza descripciones de Tools MCP en archivos agrupados por servidor y utiliza búsquedas sobre esos archivos. Es una implementación de Cursor, no una capacidad que deba atribuirse automáticamente a Codex.

Lo que sí es portable a Codex es el patrón: mantener un catálogo ligero y recuperar la definición completa sólo cuando el runtime disponga de una ruta clara para hacerlo. Si Codex no ofrece ese mecanismo integrado, puede implementarse mediante Skills, Tools de filesystem o un gateway propio.

---


[← Anterior](tool-retrieval.md) · [Índice](../../README.md) · [Siguiente →](tool-search.md)

