# Dynamic Context

Información que se incorpora mientras progresa la interacción.

## Definición

El **Dynamic Context** es la información que se incorpora conforme avanza la interacción.

Ejemplos:

## Messages

Mensajes de la conversación:

```text
Usuario → Agente
Agente → Usuario
Usuario → Agente
...
```

---

---


## Tool Results

Resultados obtenidos mediante herramientas:

```text
list_measures()
      ↓
Sales
Sales YTD
Margin
Margin %
```

Estos resultados pueden añadirse al contexto para que el LLM pueda razonar sobre ellos.

---

## MCP Tool Results

Resultados obtenidos mediante Tools proporcionadas por servidores MCP.

Por ejemplo:

```text
LLM
 ↓
get_semantic_model_schema()
 ↓
MCP Power BI
 ↓
resultado
 ↓
LLM
```

---

## Skills Loading

Una Skill puede descubrirse inicialmente mediante metadata mínima y cargarse completamente sólo cuando sea relevante.

```text
Usuario:
"Optimiza esta medida DAX"

        ↓

Agente detecta:
"Esto es DAX"

        ↓

Carga:
skills/dax/SKILL.md
```

---

## Filesystem Retrieval

El agente puede buscar y leer archivos únicamente cuando son necesarios.

Por ejemplo:

```text
AGENTS.md

"Para tareas DAX consultar Practical Example-PBIP/docs/dax-rules.md"

        ↓

Tarea DAX

        ↓

read_file("Practical Example-PBIP/docs/dax-rules.md")
```

Esto es un ejemplo de **Progressive Disclosure**.

---


[← Anterior](static-context.md) · [Índice](../../README.md) · [Siguiente →](progressive-disclosure.md)

