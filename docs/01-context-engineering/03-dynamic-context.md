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
Modelo solicita consultar el esquema
 ↓
Runtime comprueba y coordina
 ↓
Tool del servidor MCP consulta el modelo semántico
 ↓
Resultado vuelve al modelo a través del runtime
```

---

## Skills Loading

Una Skill disponible aporta inicialmente su nombre y descripción; Codex lee las instrucciones completas al utilizarla. Esta carga progresiva está documentada, aunque no garantiza cuál se elegirá para cada tarea. [Skills en Codex](https://learn.chatgpt.com/docs/build-skills).

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

Conviene comprobar cada recurso por separado:

- **Skills:** Codex detecta automáticamente cambios y nuevas instalaciones. Si una no aparece, OpenAI recomienda reiniciar Codex. Detectarla no significa que ya haya leído sus instrucciones completas. [Detección de Skills](https://learn.chatgpt.com/docs/build-skills).
- **Servidores MCP:** hay que comprobar su configuración, conexión y capacidades disponibles; crear un archivo documental no establece una conexión. [MCP en Codex](https://learn.chatgpt.com/docs/extend/mcp).
- **Instrucciones de AGENTS.md:** Codex construye la cadena de instrucciones al iniciar la ejecución. No debe atribuirse a estos archivos la misma detección automática de las Skills. [Descubrimiento de instrucciones](https://learn.chatgpt.com/docs/agent-configuration/agents-md).

Fuentes revisadas el 2026-09-08. La existencia de un archivo, su descubrimiento y la lectura de su contenido son comprobaciones diferentes.

---

El siguiente paso es entender la consulta selectiva de información. [Prompt Caching](06-prompt-caching.md) queda como ampliación opcional.

[← Anterior](02-static-context.md) · [Índice](../../README.md) · [Siguiente →](04-progressive-disclosure.md)

