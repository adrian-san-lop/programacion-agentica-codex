# Programación agéntica — Conceptos fundamentales

## 1. Agente

Un **agente** es un sistema que utiliza un LLM como motor de razonamiento y que puede interactuar con su entorno mediante herramientas.

Una forma simplificada de verlo:

```text
Usuario
   ↓
Agente / Orquestador
   ↓
LLM
   ↓
Decisión
   ↓
Tool
   ↓
Resultado
   ↓
LLM
   ↓
...
   ↓
Respuesta final
```

El **LLM no ejecuta directamente las herramientas**.

El LLM solicita una acción mediante una **tool call** y es el agente/orquestador quien:

1. Recibe la solicitud del LLM.
2. Valida la llamada.
3. Ejecuta la herramienta.
4. Obtiene el resultado.
5. Devuelve ese resultado al LLM.
6. El LLM decide qué hacer a continuación.

A este proceso iterativo se le suele llamar **Agent Loop**.

---

# 2. System Prompt

El **System Prompt** contiene las instrucciones de más alto nivel que definen cómo debe comportarse el agente.

Ejemplos:

* Qué rol tiene.
* Qué restricciones debe respetar.
* Qué comportamiento general debe seguir.
* Qué prioridades tiene.

Ejemplo conceptual:

```text
You are a senior Power BI developer.

Prefer inspecting the existing semantic model before making changes.

Never perform destructive operations without explicit approval.
```

El system prompt ayuda a **moldear el comportamiento del agente**, pero no contiene necesariamente todas las tools.

---

# 3. Tools / Herramientas

Las **tools** son capacidades que el agente puede utilizar para interactuar con sistemas externos.

Ejemplos:

```text
read_file()
write_file()
execute_sql()
list_measures()
create_measure()
execute_dax()
```

Cada tool suele tener:

* Nombre.
* Descripción.
* Parámetros de entrada.
* Schema de dichos parámetros.
* Opcionalmente, descripción de su resultado.

Ejemplo conceptual:

```json
{
  "name": "execute_dax",
  "description": "Executes a DAX query against a semantic model",
  "parameters": {
    "semantic_model": "string",
    "query": "string"
  }
}
```

Estas definiciones **no tienen por qué estar literalmente dentro del System Prompt**.

Normalmente el runtime/API del agente las proporciona al modelo como una sección estructurada de herramientas disponibles.

---

# 4. Tool Call

Una **tool call** es una solicitud del LLM para utilizar una herramienta.

Ejemplo:

```text
Usuario:
"¿Cuántas ventas hubo este año?"
```

El LLM podría decidir:

```text
Necesito consultar el modelo.
```

Y solicitar:

```text
execute_dax(
    semantic_model="Sales",
    query="..."
)
```

El flujo sería:

```text
LLM
 ↓
solicita tool call
 ↓
Agente
 ↓
ejecuta la tool
 ↓
Power BI / Fabric
 ↓
resultado
 ↓
Agente
 ↓
LLM
```

---

# 5. Contexto estático

El **Static Context** es la información que el agente carga de forma habitual o desde el inicio de una interacción.

Puede incluir:

* System Prompt.
* Instrucciones generales.
* `AGENTS.md`.
* Memoria persistente que se cargue siempre.
* Definiciones de tools, si el runtime las carga de forma eager/upfront.
* Metadata de Skills disponible desde el principio.

Importante:

```text
Configuración MCP ≠ necesariamente contexto del LLM
```

Por ejemplo:

```text
config.toml
```

puede decirle a Codex:

```text
"Conéctate al MCP de Power BI"
```

pero eso no significa que el contenido de `config.toml` se envíe entero al LLM.

---

# 6. Contexto dinámico

El **Dynamic Context** es la información que se va incorporando conforme avanza la interacción.

Ejemplos:

### Messages

Mensajes de la conversación:

```text
Usuario → agente
Agente → usuario
```

### Tool results

Resultados obtenidos mediante herramientas:

```text
get_measures()
    ↓
[Sales, Sales YTD, Margin, ...]
```

### MCP calls

Resultados recuperados mediante herramientas proporcionadas por servidores MCP.

### Skills loading

Una Skill puede detectarse inicialmente mediante metadata mínima y cargarse completamente sólo cuando sea relevante.

### Filesystem retrieval

El agente puede buscar y leer archivos sólo cuando los necesita.

Ejemplo:

```text
AGENTS.md
   ↓
"Para DAX consultar docs/dax.md"
   ↓
tarea DAX
   ↓
read_file("docs/dax.md")
```

Esto es un ejemplo de **Progressive Disclosure**.

---

# 7. Progressive Disclosure

**Progressive Disclosure** consiste en no cargar toda la información desde el principio.

En su lugar:

```text
Contexto mínimo
      ↓
El agente detecta una necesidad
      ↓
Busca información adicional
      ↓
Carga sólo lo relevante
      ↓
Continúa trabajando
```

Objetivo:

```text
menos ruido
+
menos tokens
+
contexto más relevante
```

No significa simplemente reducir tokens.

También busca mejorar la **calidad de la atención del modelo**.

---

# 8. AGENTS.md

`AGENTS.md` contiene instrucciones persistentes sobre **cómo trabajar dentro de un proyecto**.

Ejemplos:

```text
- Cómo ejecutar tests.
- Cómo ejecutar lint.
- Convenciones de arquitectura.
- Reglas para modificar código.
- Documentación disponible.
- Criterios de finalización.
```

Ejemplo:

```md
# Commands

npm test
npm run lint

# Architecture

- Follow the existing domain architecture.
- Keep domain logic independent from infrastructure.

# Documentation

Detailed guidelines live in `docs/`.

Do NOT read all docs upfront.
Read only the documentation relevant to the current task.
```

No debería convertirse en un enorme repositorio de conocimiento.

Lo ideal es utilizarlo como **mapa de navegación**.

```text
AGENTS.md
   ↓
docs/
   ├── dax.md
   ├── semantic-models.md
   ├── testing.md
   └── deployment.md
```

Esto favorece Progressive Disclosure.

### Jerarquía

Los `AGENTS.md` pueden existir en diferentes niveles del árbol del proyecto.

Ejemplo:

```text
project/
├── AGENTS.md
│
├── frontend/
│   └── AGENTS.md
│
└── backend/
    └── AGENTS.md
```

Las instrucciones más específicas pueden complementar o sobrescribir instrucciones más generales dependiendo del runtime.

En Codex, `AGENTS.md` es un mecanismo soportado directamente.

Otros agentes pueden utilizar otros nombres o mecanismos equivalentes.

Por ejemplo, Claude Code utiliza principalmente `CLAUDE.md`.

---

# 9. Context Window vs atención efectiva

## Context Window

La **ventana de contexto** es la cantidad máxima de información que el modelo puede recibir durante una inferencia.

Puede contener:

```text
System Prompt
+
AGENTS.md
+
Skills cargadas
+
Tools
+
mensajes
+
resultados de tools
+
archivos
+
otros datos
```

## Atención

Aunque determinada información quepa dentro de la ventana de contexto, no significa que toda tenga la misma relevancia.

Un contexto enorme puede contener mucho ruido.

Por ejemplo:

```text
100.000 tokens
```

pueden caber técnicamente, pero si sólo 2.000 son relevantes para la tarea, los otros 98.000 pueden reducir la claridad del contexto.

Por eso en programación agéntica interesa:

```text
Context Engineering
        ↓
Contexto correcto
        +
Momento correcto
        +
Cantidad correcta
```

Más contexto no siempre significa mejores resultados.

---

# 10. Commands

Los **Commands** son atajos reutilizables que permiten ejecutar prompts o workflows predefinidos.

Son una funcionalidad dependiente del cliente/agente.

Ejemplo conceptual:

```text
/commit
```

podría expandirse internamente a:

```text
Review the current changes.

Create a commit following Conventional Commits.

Do not include unrelated files.
```

Permiten evitar escribir el mismo prompt repetidamente.

Por ejemplo:

```text
/commit
/review
/test
/deploy
```

Importante:

```text
Commands ≠ estándar universal de agentes
```

Cada herramienta puede implementar commands de forma diferente.

---

# 11. Skills

Las **Skills** encapsulan conocimiento, instrucciones y workflows especializados.

Ejemplos:

```text
skills/
├── dax/
│   └── SKILL.md
│
├── power-query/
│   └── SKILL.md
│
└── semantic-model/
    └── SKILL.md
```

Una Skill puede indicar:

```text
- cuándo utilizarse
- qué procedimiento seguir
- qué tools utilizar
- qué validaciones hacer
- qué documentación consultar
- cómo presentar el resultado
```

Ejemplo:

```text
Usuario:
"Optimiza esta medida DAX"
```

El agente puede detectar:

```text
Esto es una tarea DAX.
```

Y cargar:

```text
skills/dax/SKILL.md
```

Las Skills son especialmente útiles para **empaquetar workflows reutilizables y conocimiento especializado**.

También permiten Progressive Disclosure:

```text
Metadata de Skill
       ↓
¿Es relevante?
   │
   ├── NO → no cargar
   │
   └── SÍ
        ↓
     SKILL.md
        ↓
  references necesarias
```

---

# 12. MCP — Model Context Protocol

MCP es un protocolo que permite conectar agentes con herramientas y fuentes externas de forma estandarizada.

Ejemplos:

```text
Codex
  │
  ├── MCP Power BI
  ├── MCP Fabric
  ├── MCP SQL
  ├── MCP GitHub
  └── MCP filesystem
```

Un **MCP Server** puede exponer:

* Tools.
* Resources.
* Prompts.
* Otras capacidades definidas por el protocolo.

Ejemplo:

```text
Power BI MCP
     │
     ├── get_measures
     ├── execute_dax
     ├── get_model_schema
     └── update_measure
```

Tú normalmente configuras **el servidor MCP**, no cada herramienta individual.

Ejemplo conceptual en Codex:

```toml
[mcp_servers.powerbi]
command = "..."
args = ["..."]
```

Después:

```text
Codex
   ↓
se conecta al MCP
   ↓
MCP anuncia sus tools
   ↓
Codex descubre las capacidades disponibles
```

---

# 13. Configuración MCP y credenciales

La configuración de un MCP puede vivir en archivos como:

```text
config.toml
mcp.json
...
```

dependiendo del cliente.

Pero:

```text
NO asumir:
MCP = mcp.json
```

MCP es el protocolo.

`mcp.json`, `config.toml`, etc. son simplemente mecanismos de configuración de determinados clientes.

Tampoco es recomendable guardar secretos directamente en estos archivos.

Preferir:

```text
Environment Variables
Secret Stores
Credential Managers
OAuth
```

frente a:

```json
{
  "password": "MiPassword123"
}
```

---

# 14. Muchas tools y consumo de contexto

Supongamos que tenemos:

```text
Power BI MCP → 30 tools
Fabric MCP   → 40 tools
GitHub MCP   → 30 tools

Total: 100 tools
```

Una implementación simple podría proporcionar al LLM las 100 definiciones completas:

```text
Tool 1
  nombre
  descripción
  JSON Schema

Tool 2
  nombre
  descripción
  JSON Schema

...

Tool 100
```

Esto puede consumir muchos tokens y generar ruido.

---

# 15. Tool Retrieval / Filesystem Retrieval

Para evitar cargar todas las definiciones completas desde el principio se puede aplicar **Progressive Disclosure a las tools**.

En lugar de:

```text
100 tools completas
        ↓
       LLM
```

podemos hacer:

```text
Índice ligero de capacidades
        ↓
       LLM
        ↓
"Necesito consultar DAX"
        ↓
Retrieval
        ↓
execute_dax
get_model_schema
        ↓
cargar schemas completos
        ↓
LLM
```

---

# 16. Filesystem Retrieval

**Filesystem Retrieval** es una posible implementación del retrieval utilizando archivos.

Por ejemplo:

```text
tools/
├── execute-dax.md
├── update-measure.md
├── get-schema.md
└── create-measure.md
```

Inicialmente el agente podría tener únicamente información ligera que le permita descubrir capacidades.

Después:

```text
Usuario:
"¿Cuántas ventas tuvimos este año?"
```

El agente/LLM determina:

```text
"Necesito consultar el modelo."
```

Busca:

```text
semantic_search("execute dax query")
```

Obtiene:

```text
tools/execute-dax.md
```

Lee:

```text
read_file("tools/execute-dax.md")
```

Y sólo entonces obtiene:

```text
nombre
+
descripción
+
argumentos
+
schema
```

Ahora el LLM puede solicitar correctamente:

```text
execute_dax(...)
```

---

# 17. Filesystem Retrieval NO significa pasar sólo nombres

Una simplificación peligrosa sería:

```text
Filesystem Retrieval
=
pasarle solamente los nombres de las tools
```

No necesariamente.

Puede utilizar:

* Nombre.
* Descripción corta.
* Categoría.
* Keywords.
* Embeddings.
* Índices semánticos.
* Metadata.

La idea fundamental es:

> No cargar inicialmente las definiciones completas de todas las herramientas.

Primero se descubre qué capacidad es relevante.

Después se carga su definición detallada.

---

# 18. Tool Retrieval vs MCP

Son conceptos distintos.

```text
MCP
=
¿Qué herramientas existen?
¿Cómo puedo ejecutarlas?
```

Mientras que:

```text
Tool Retrieval
=
¿Cuáles de todas esas herramientas necesito cargar ahora?
```

Por tanto:

```text
MCP Server
    ↓
expone 80 tools
    ↓
Tool Retrieval
    ↓
selecciona 3 relevantes
    ↓
LLM
```

MCP por sí solo **no implica necesariamente que las definiciones de todas las tools se carguen de forma progresiva**.

Eso depende del runtime/agente.

---

# 19. Las tres etapas del uso eficiente de Tools

## Etapa 1 — Tool definitions upfront

Se proporcionan al modelo las definiciones completas de las tools desde el principio.

```text
LLM
│
├── Tool A + schema
├── Tool B + schema
├── Tool C + schema
├── ...
└── Tool Z + schema
```

Ventaja:

```text
Simple
```

Problema:

```text
Muchas tools
    ↓
Muchos tokens
    ↓
Más ruido contextual
```

---

## Etapa 2 — Tool Retrieval

Se proporciona al modelo un mecanismo ligero para descubrir capacidades.

```text
Usuario
   ↓
LLM
   ↓
"Necesito ejecutar DAX"
   ↓
semantic_search(...)
   ↓
encuentra execute_dax
   ↓
read_file(...)
   ↓
carga schema
```

Sólo se incorpora al contexto la definición necesaria.

Esto transforma:

```text
Static Context
```

en:

```text
Dynamic Context
```

mediante Progressive Disclosure.

---

## Etapa 3 — Ejecución y Agent Loop

Una vez cargada la definición:

```text
LLM
   ↓
solicita execute_dax(...)
   ↓
Agente / Orquestador
   ↓
valida
   ↓
ejecuta tool
   ↓
MCP Server
   ↓
Power BI
   ↓
resultado
   ↓
Agente
   ↓
LLM
```

El LLM evalúa el resultado y puede:

```text
Responder
```

o decidir:

```text
Necesito otra tool
       ↓
nuevo ciclo
```

Ese ciclo constituye el **Agent Loop**.

---

# 20. Mapa mental final

```text
                     AGENTE
                       │
        ┌──────────────┼───────────────┐
        │              │               │
        ▼              ▼               ▼
   AGENTS.md         Skills           MCP
   reglas          conocimiento     capacidades
                      │               │
                      │               └── Tools
                      │
                      ▼
              Progressive Disclosure
                      │
             ┌────────┴─────────┐
             ▼                  ▼
        Skill Loading      Tool Retrieval
             │                  │
             └────────┬─────────┘
                      ▼
                     LLM
                      │
                 Tool Call
                      │
                      ▼
              Agente/Orquestador
                      │
                      ▼
                    Tool
                      │
                      ▼
                  Resultado
                      │
                      ▼
                     LLM
                      │
                siguiente paso
```

# 21. Resumen en una frase

```text
System Prompt → cómo debe comportarse

AGENTS.md → cómo trabajar en este proyecto

Skills → cómo resolver tareas especializadas

MCP → qué capacidades externas están disponibles

Tools → acciones concretas

Retrieval → qué información cargar ahora

Tool Call → qué acción solicita el LLM

Agent Loop → observar → decidir → actuar → observar → repetir

Progressive Disclosure → cargar información sólo cuando sea necesaria

Context Engineering → conseguir que el modelo tenga el contexto adecuado en el momento adecuado
```
