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

Una Skill puede estar disponible en el entorno y sus instrucciones incorporarse cuando se invoca. Codex documenta ubicaciones concretas para descubrir Skills, pero el mecanismo interno exacto que decide qué metadata o contenido carga no debe darse por supuesto.

```text
Usuario:
"Optimiza esta medida DAX"

        ↓

Agente detecta:
"Esto es DAX"

        ↓

Carga o invoca:
.agents/skills/dax/SKILL.md
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

## Tool Search

Cuando el runtime dispone de un catálogo especializado, puede buscar una Tool por intención y cargar su definición sólo después de encontrarla. Es otra forma de construir contexto dinámico, distinta de buscar manualmente archivos en el workspace.

No debe darse por hecho que todos los clientes ofrecen la misma capacidad. En cada runtime hay que comprobar si la búsqueda pertenece al cliente, al proveedor del modelo o a una Tool explícita.

## Carga durante la sesión

El contexto dinámico se construye durante la sesión. Si se añade una Skill, un servidor o una nueva instrucción después de que el runtime haya inicializado la conversación, puede que no esté disponible en esa sesión. En ese caso hay que recargar la configuración o iniciar una nueva sesión, según el cliente.

Esto explica algunos fallos aparentemente inexplicables: el archivo existe, pero no forma parte del contexto ni del catálogo que el runtime cargó al iniciar.

---

El contexto dinámico también afecta a la posibilidad de reutilizar prefijos. Consulta [Prompt Caching](06-prompt-caching.md) después de entender cómo se construye este contexto.

[← Anterior](02-static-context.md) · [Índice](../../README.md) · [Siguiente →](04-progressive-disclosure.md)

