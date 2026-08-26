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

El LLM puede solicitar una acción mediante una **Tool Call** y es el agente/orquestador quien:

1. Recibe la solicitud del LLM.
2. Valida la llamada.
3. Ejecuta la herramienta.
4. Obtiene el resultado.
5. Devuelve ese resultado al LLM.
6. El LLM decide qué hacer a continuación.

A este proceso iterativo se le suele llamar **Agent Loop**.

---

# 2. Agent Loop

El **Agent Loop** es el ciclo mediante el cual el agente intenta conseguir un objetivo.

Conceptualmente:

```text
        ┌─────────────────────┐
        │                     │
        ▼                     │
     OBSERVAR                 │
        ↓                     │
     RAZONAR                  │
        ↓                     │
     DECIDIR                  │
        ↓                     │
      ACTUAR                  │
        ↓                     │
     RESULTADO ───────────────┘
```

Por ejemplo:

```text
Usuario:
"¿Cuántas ventas tuvimos este año?"

        ↓

LLM:
"Necesito consultar el modelo."

        ↓

Tool Call:
execute_dax(...)

        ↓

Agente ejecuta Tool

        ↓

Resultado:
12.543.221 €

        ↓

LLM:
"Ya tengo suficiente información."

        ↓

Respuesta al usuario
```

Si el resultado de una Tool no es suficiente, el LLM puede solicitar otra Tool y continuar el ciclo.

---

# 3. System Prompt

El **System Prompt** contiene instrucciones de alto nivel que definen cómo debe comportarse el agente.

Puede definir:

- Rol.
- Restricciones.
- Comportamiento general.
- Prioridades.
- Reglas de seguridad.
- Forma general de trabajar.

Ejemplo conceptual:

```text
You are a senior Power BI developer.

Prefer inspecting the existing semantic model before making changes.

Never perform destructive operations without explicit approval.
```

El System Prompt ayuda a **moldear el comportamiento del agente**.

IMPORTANTE:

Las definiciones de las Tools **no tienen por qué estar literalmente dentro del System Prompt**.

Dependiendo del runtime/API, las Tools pueden proporcionarse al modelo mediante un campo estructurado específico.

---

# 4. Tools / Herramientas

Las **Tools** son capacidades que el agente puede utilizar para interactuar con su entorno.

Ejemplos:

```text
read_file()
write_file()

execute_sql()

list_measures()
get_measure()
create_measure()
update_measure()

execute_dax()
```

Una Tool suele tener:

- Nombre.
- Descripción.
- Parámetros de entrada.
- Schema de dichos parámetros.
- Opcionalmente, descripción de su resultado.

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

El LLM necesita conocer suficiente información sobre una Tool para poder solicitar correctamente su ejecución.

---

# 5. Tool Call

Una **Tool Call** es una solicitud del LLM para utilizar una herramienta.

Ejemplo:

```text
Usuario:

"¿Cuántas ventas tuvimos este año?"
```

El LLM puede razonar:

```text
Necesito consultar el modelo semántico.
```

Y solicitar:

```text
execute_dax(
    semantic_model="Sales",
    query="..."
)
```

Pero el LLM **no ejecuta realmente `execute_dax()`**.

El flujo es:

```text
LLM
 │
 │ solicita Tool Call
 ▼
Agente / Orquestador
 │
 │ valida y ejecuta
 ▼
Tool
 │
 ▼
Power BI / Fabric
 │
 │ resultado
 ▼
Tool
 │
 ▼
Agente
 │
 │ añade resultado al contexto
 ▼
LLM
```

Por tanto:

> El LLM decide qué Tool quiere utilizar.
>
> El agente/orquestador ejecuta realmente la Tool.

---

# 6. Static Context

El **Static Context** es la información que se proporciona de forma habitual o desde el inicio de la interacción.

Puede incluir:

- System Prompt.
- Instrucciones generales.
- `AGENTS.md`.
- Memoria persistente cargada siempre.
- Definiciones de Tools si se cargan upfront.
- Metadata de Skills.
- Otra información permanente necesaria para el agente.

Ejemplo:

```text
Petición al LLM
│
├── System Prompt
├── AGENTS.md
├── Tool definitions
├── Skill metadata
├── Memory
└── User Prompt
```

Cuanto mayor sea el Static Context:

```text
más tokens
+
más información
+
potencialmente más ruido
```

Por eso interesa mantenerlo pequeño y relevante.

IMPORTANTE:

```text
Configuración MCP
≠
necesariamente contexto del LLM
```

Por ejemplo, un:

```text
config.toml
```

puede indicarle a Codex:

```text
"Conéctate al MCP de Power BI"
```

pero eso no significa que el contenido completo de `config.toml` se envíe al LLM.

---

# 7. Dynamic Context

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

"Para tareas DAX consultar docs/dax.md"

        ↓

Tarea DAX

        ↓

read_file("docs/dax.md")
```

Esto es un ejemplo de **Progressive Disclosure**.

---

# 8. Progressive Disclosure

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

Objetivos:

```text
menos tokens
+
menos ruido
+
contexto más relevante
+
mejor atención
```

No consiste únicamente en ahorrar tokens.

También busca que el modelo tenga:

> La información correcta, en el momento correcto.

Ejemplo:

```text
❌ Cargar siempre:

DAX
Power Query
SQL
PySpark
Deployment
Testing
Power BI
Fabric
Azure
...

────────────────────────

✅ Progressive Disclosure:

Tarea DAX
   ↓
cargar Skill DAX
   ↓
cargar documentación DAX
   ↓
continuar
```

---

# 9. AGENTS.md

`AGENTS.md` contiene instrucciones persistentes sobre **cómo trabajar dentro de un proyecto**.

Puede contener:

- Cómo ejecutar tests.
- Cómo ejecutar lint.
- Convenciones de arquitectura.
- Reglas para modificar código.
- Documentación disponible.
- Criterios de finalización.
- Comandos importantes.

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

`AGENTS.md` no debería convertirse en un enorme repositorio de conocimiento.

Lo ideal es utilizarlo como **mapa de navegación**.

Por ejemplo:

```text
AGENTS.md
   │
   ▼
docs/
├── dax.md
├── semantic-models.md
├── power-query.md
├── testing.md
└── deployment.md
```

Esto permite aplicar **Progressive Disclosure**.

---

# 10. AGENTS.md jerárquicos

Los `AGENTS.md` pueden existir en diferentes niveles del árbol de un proyecto.

Ejemplo:

```text
project/
│
├── AGENTS.md
│
├── frontend/
│   └── AGENTS.md
│
└── backend/
    └── AGENTS.md
```

Esto permite tener:

```text
AGENTS.md raíz
        ↓
reglas generales

frontend/AGENTS.md
        ↓
reglas específicas frontend

backend/AGENTS.md
        ↓
reglas específicas backend
```

Las instrucciones más específicas pueden complementar o prevalecer sobre las generales dependiendo del runtime.

En **Codex**, `AGENTS.md` es un mecanismo soportado.

Otros agentes pueden utilizar otros mecanismos.

Por ejemplo, Claude Code utiliza principalmente:

```text
CLAUDE.md
```

---

# 11. Context Window vs atención efectiva

## Context Window

La **ventana de contexto** representa cuánta información puede manejar el modelo dentro de una inferencia.

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
resultados de Tools
+
archivos
+
memoria
+
otros datos
```

---

## Atención efectiva

Que algo quepa dentro de la ventana de contexto **no significa que todo sea igualmente relevante para el modelo**.

Por ejemplo:

```text
100.000 tokens de contexto
```

pueden caber técnicamente.

Pero si:

```text
2.000 tokens
```

son realmente relevantes para resolver la tarea, introducir enormes cantidades de información adicional puede generar ruido.

Por eso:

```text
Más contexto
≠
Mejor resultado
```

Lo que buscamos es:

```text
Context Engineering
        ↓
Contexto correcto
        +
Momento correcto
        +
Cantidad correcta
```

---

# 12. Commands

Los **Commands** son atajos reutilizables que permiten lanzar prompts o workflows predefinidos.

Son una funcionalidad dependiente del cliente/agente.

Por ejemplo:

```text
/commit
```

podría expandirse conceptualmente a:

```text
Review the current changes.

Create a commit following Conventional Commits.

Do not include unrelated files.
```

Otros ejemplos:

```text
/commit
/review
/test
/deploy
```

Esto evita tener que escribir repetidamente el mismo prompt.

IMPORTANTE:

```text
Commands
≠
estándar universal
```

Cada agente o herramienta puede implementarlos de forma diferente.

---

# 13. Skills

Las **Skills** encapsulan conocimiento, instrucciones y workflows especializados.

Ejemplo:

```text
skills/
│
├── dax/
│   └── SKILL.md
│
├── power-query/
│   └── SKILL.md
│
├── semantic-model/
│   └── SKILL.md
│
└── report-design/
    └── SKILL.md
```

Una Skill puede indicar:

- Cuándo utilizarse.
- Qué procedimiento seguir.
- Qué reglas aplicar.
- Qué Tools utilizar.
- Qué validaciones realizar.
- Qué documentación consultar.
- Cómo presentar el resultado.

Por ejemplo:

```text
Usuario:

"Optimiza esta medida DAX"

        ↓

Agente:

"Esto es una tarea DAX"

        ↓

Carga:

skills/dax/SKILL.md
```

Las Skills son una forma de **empaquetar conocimiento y workflows reutilizables**.

---

# 14. Skills y Progressive Disclosure

No necesariamente queremos cargar todas las Skills completas desde el principio.

Podemos tener:

```text
Metadata de Skills
        ↓
LLM / Agente
        ↓
¿qué Skill necesito?
        │
        ├── DAX
        ├── Power Query
        ├── Semantic Model
        └── Report Design
```

Si la tarea es DAX:

```text
Carga:
skills/dax/SKILL.md
```

pero no:

```text
skills/power-query/SKILL.md
skills/report-design/SKILL.md
...
```

Esto es nuevamente **Progressive Disclosure**.

---

# 15. MCP — Model Context Protocol

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

Entre ellas, Tools.

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

---

# 16. Configuración de un MCP

Dependiendo del cliente, la configuración puede vivir en:

```text
config.toml
mcp.json
settings.json
...
```

Por ejemplo, conceptualmente en Codex:

```toml
[mcp_servers.powerbi]
command = "..."
args = ["..."]
```

Esto significa:

```text
Codex
   ↓
conéctate a este MCP
   ↓
Power BI MCP
   ↓
expone sus capacidades
```

IMPORTANTE:

```text
MCP
≠
mcp.json
```

MCP es el **protocolo**.

`mcp.json`, `config.toml`, etc. son mecanismos de configuración utilizados por diferentes clientes.

---

# 17. MCP y credenciales

Un MCP puede necesitar autenticarse contra servicios externos.

Por ejemplo:

```text
MCP
 ↓
Fabric API
 ↓
Azure / Entra ID
```

No es recomendable almacenar secretos directamente en archivos versionados.

Evitar:

```json
{
  "password": "MiPassword123"
}
```

Preferir mecanismos como:

```text
Environment Variables
Secret Stores
Credential Managers
OAuth
Managed Identity
```

dependiendo del entorno.

---

# 18. MCP y Tools

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

---

# 19. El problema de tener muchas Tools

Supongamos:

```text
Power BI MCP → 30 Tools
Fabric MCP   → 40 Tools
GitHub MCP   → 30 Tools

TOTAL        → 100 Tools
```

Para que el LLM pueda utilizar una Tool necesita conocer suficiente información sobre ella.

Aquí aparecen diferentes estrategias.

IMPORTANTE:

Las siguientes estrategias **NO son etapas consecutivas**.

Son formas alternativas de proporcionar Tools al LLM.

---

# 20. Estrategia A — Tool Definitions Upfront

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

# 21. Estrategia B — Tool Retrieval

**Tool Retrieval es una alternativa a cargar todas las Tools completas upfront.**

El objetivo es proporcionar inicialmente suficiente información para descubrir qué capacidades existen, pero sin cargar necesariamente todas sus definiciones completas.

Conceptualmente:

```text
Petición inicial
│
├── System Prompt
├── AGENTS.md
├── índice ligero de capacidades
└── User Prompt
```

Por ejemplo:

```text
Capacidades:

- consultar modelos semánticos
- consultar medidas
- ejecutar DAX
- modificar medidas
- consultar relaciones
- trabajar con tablas
```

El usuario pregunta:

```text
"¿Cuántas ventas tuvimos este año?"
```

El LLM determina:

```text
Necesito ejecutar una consulta DAX.
```

Entonces:

```text
Necesidad
   ↓
Tool Retrieval
   ↓
encuentra execute_dax
   ↓
recupera definición completa
   ↓
nombre
+
descripción
+
JSON Schema
```

Ahora el LLM conoce suficiente información para solicitar:

```text
execute_dax(...)
```

Esto permite pasar parte del contexto de:

```text
Static Context
```

a:

```text
Dynamic Context
```

---

# 22. Upfront vs Retrieval

Las dos estrategias son alternativas:

```text
              ¿Cómo conoce el LLM las Tools?
                         │
              ┌──────────┴──────────┐
              │                     │
              ▼                     ▼
       ESTRATEGIA A           ESTRATEGIA B

          Upfront               Retrieval

     todas completas        descubrir primero
      desde inicio          y cargar después

              │                     │
              └──────────┬──────────┘
                         │
                         ▼
                LLM conoce la Tool
                         │
                         ▼
                     Tool Call
                         │
                         ▼
                    Agent Loop
```

Por tanto:

```text
A → Tool Call
```

o:

```text
B → Tool Call
```

NO:

```text
A → B → Tool Call
```

---

# 23. Estrategia híbrida

Upfront y Retrieval tampoco tienen por qué ser 100 % excluyentes.

Se pueden combinar.

Por ejemplo:

```text
100 Tools disponibles
        │
        ├── 5 Tools fundamentales
        │       ↓
        │    Upfront
        │
        └── 95 Tools especializadas
                ↓
             Retrieval
```

El LLM podría tener siempre disponibles:

```text
read_file()
search()
list_directory()
tool_search()
get_help()
```

Y descubrir dinámicamente herramientas más específicas:

```text
execute_dax()
create_measure()
update_relationship()
deploy_semantic_model()
...
```

Esto permite equilibrar:

```text
simplicidad
+
flexibilidad
+
consumo de contexto
```

---

# 24. Una implementación de Tool Retrieval: Filesystem Retrieval

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

# 25. Filesystem Retrieval NO significa pasar sólo nombres

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

# 27. Tool Calling después de Upfront o Retrieval

Independientemente de cómo haya conocido la Tool el LLM:

```text
             Upfront
                │
                │
                ▼
              TOOL
                ▲
                │
                │
            Retrieval
```

una vez dispone de suficiente información:

```text
LLM
 ↓
Tool Call
 ↓
Agente / Orquestador
 ↓
valida
 ↓
ejecuta Tool
 ↓
resultado
 ↓
LLM
```

Si el LLM necesita más información:

```text
resultado
   ↓
LLM
   ↓
"Necesito otra Tool"
   ↓
Tool Call
   ↓
resultado
   ↓
LLM
```

Eso forma parte del **Agent Loop**.

---

# 28. Resumen del ciclo completo de Tools

La representación correcta es:

```text
                    TOOLS DISPONIBLES
                           │
                           ▼
                ¿Cómo las conoce el LLM?
                           │
              ┌────────────┴────────────┐
              │                         │
              ▼                         ▼
           UPFRONT                  RETRIEVAL
              │                         │
     schemas completos        descubrir relevantes
       desde inicio              y cargar schemas
              │                         │
              └────────────┬────────────┘
                           │
                           ▼
                   LLM conoce la Tool
                           │
                           ▼
                       TOOL CALL
                           │
                           ▼
                  AGENTE / ORQUESTADOR
                           │
                           ▼
                         TOOL
                           │
                           ▼
                    SISTEMA EXTERNO
                           │
                           ▼
                       RESULTADO
                           │
                           ▼
                          LLM
                           │
                   ¿Objetivo cumplido?
                      │          │
                     SÍ         NO
                      │          │
                      ▼          └──────┐
                  RESPUESTA             │
                                       ▼
                                  NUEVA TOOL CALL
```

---

# 29. Ejemplo Power BI / Fabric

Supongamos que estamos creando un agente propio para trabajar con proyectos `.pbip`.

Tenemos:

```text
Power BI Agent
│
├── AGENTS.md
│
├── Skills
│   ├── DAX
│   ├── Power Query
│   ├── Semantic Models
│   └── Report Design
│
└── Power BI MCP
    ├── list_tables
    ├── list_measures
    ├── get_measure
    ├── execute_dax
    ├── create_measure
    ├── update_measure
    ├── get_relationships
    └── ...
```

El usuario solicita:

```text
"Optimiza la medida Sales YTD."
```

El flujo podría ser:

```text
Usuario
   ↓
Agente
   ↓
AGENTS.md
   ↓
detecta tarea DAX
   ↓
carga Skill DAX
   ↓
LLM
   ↓
necesita inspeccionar Sales YTD
   ↓
Tool Retrieval
   ↓
get_measure
   ↓
Tool Call
   ↓
Power BI MCP
   ↓
devuelve medida
   ↓
LLM analiza DAX
   ↓
necesita comprobar modelo
   ↓
Tool Retrieval
   ↓
get_model_schema
   ↓
Tool Call
   ↓
Power BI MCP
   ↓
resultado
   ↓
LLM
   ↓
propone optimización
```

Aquí tenemos **Progressive Disclosure en varios niveles**:

```text
AGENTS.md
   │
   ├── Skill Retrieval
   │       ↓
   │     DAX Skill
   │
   ├── Documentation Retrieval
   │       ↓
   │     docs/dax.md
   │
   └── Tool Retrieval
           ↓
       get_measure
       get_model_schema
```

No cargamos todo desde el principio.

---

# 30. Context Engineering

Todos estos conceptos forman parte de algo más amplio:

**Context Engineering**.

El objetivo no es:

```text
Darle al LLM toda la información posible.
```

El objetivo es:

```text
Darle al LLM
la información correcta
en el momento correcto
y en la cantidad correcta.
```

Podemos aplicar Progressive Disclosure sobre:

```text
Documentación
      ↓
Filesystem Retrieval

Skills
      ↓
Skill Loading

Tools
      ↓
Tool Retrieval

Datos
      ↓
MCP / APIs / Database

Memoria
      ↓
Memory Retrieval
```

Todo converge en:

```text
                 CONTEXT ENGINEERING
                         │
                         ▼
              Progressive Disclosure
                         │
       ┌─────────────────┼─────────────────┐
       │                 │                 │
       ▼                 ▼                 ▼
     Skills          Documents           Tools
       │                 │                 │
       ▼                 ▼                 ▼
   Retrieval         Retrieval         Retrieval
       │                 │                 │
       └─────────────────┼─────────────────┘
                         ▼
                        LLM
                         │
                         ▼
                    Agent Loop
```

---

# 31. Mapa mental final

```text
                         AGENTE
                           │
         ┌─────────────────┼─────────────────┐
         │                 │                 │
         ▼                 ▼                 ▼
    AGENTS.md           Skills             MCP
    reglas              conocimiento       capacidades
                           │                 │
                           │                 ▼
                           │               Tools
                           │                 │
                           ▼                 ▼
                    Progressive Disclosure
                           │
                  ┌────────┴────────┐
                  ▼                 ▼
             Skill Loading     Tool Retrieval
                  │                 │
                  └────────┬────────┘
                           ▼
                          LLM
                           │
                      Tool Call
                           │
                           ▼
                 Agente / Orquestador
                           │
                           ▼
                         Tool
                           │
                           ▼
                   Sistema externo
                           │
                           ▼
                       Resultado
                           │
                           ▼
                          LLM
                           │
                    siguiente paso
                           │
                           └──→ Agent Loop
```

---

# 32. Reglas mentales rápidas

## System Prompt

```text
¿Cómo debe comportarse el agente?
```

## AGENTS.md

```text
¿Cómo debe trabajar en este proyecto?
```

## Skill

```text
¿Cómo debe resolver este tipo concreto de tarea?
```

## MCP

```text
¿Qué capacidades externas puede tener disponibles?
```

## Tool

```text
¿Qué acción concreta puede realizar?
```

## Tool Call

```text
¿Qué acción está solicitando ejecutar el LLM?
```

## Tool Retrieval

```text
¿Qué Tool necesito conocer ahora?
```

## Filesystem Retrieval

```text
¿Qué información necesito recuperar ahora desde archivos?
```

## Progressive Disclosure

```text
No cargar todo desde el principio.
Descubrir y cargar información cuando sea necesaria.
```

## Agent Loop

```text
Observar
   ↓
Razonar
   ↓
Decidir
   ↓
Actuar
   ↓
Observar resultado
   ↓
Repetir
```

## Context Engineering

```text
Información correcta
+
momento correcto
+
cantidad correcta
```

---

# 33. Resumen definitivo

```text
System Prompt
→ comportamiento general

AGENTS.md
→ reglas del proyecto

Skills
→ conocimiento y workflows especializados

MCP
→ conexión estandarizada con capacidades externas

Tools
→ acciones concretas

Upfront
→ cargar definiciones de Tools desde el principio

Tool Retrieval
→ descubrir/cargar sólo Tools relevantes

Filesystem Retrieval
→ recuperar información bajo demanda desde archivos

Tool Call
→ solicitud del LLM para ejecutar una Tool

Agent / Orchestrator
→ ejecuta realmente la Tool

Agent Loop
→ observar → razonar → actuar → observar → repetir

Progressive Disclosure
→ cargar información sólo cuando sea necesaria

Context Engineering
→ gestionar qué contexto recibe el LLM, cuándo y cuánto
```

---

# 34. Idea clave sobre Tools

NO pensar:

```text
Etapa 1
   ↓
Etapa 2
   ↓
Etapa 3
```

Pensar:

```text
             TOOLS
               │
      ¿Cómo las expongo?
               │
      ┌────────┴────────┐
      ▼                 ▼
   UPFRONT          RETRIEVAL
      │                 │
Static Context     Dynamic Context
      │                 │
      └────────┬────────┘
               ▼
           TOOL CALL
               ▼
           AGENT LOOP
```

Además, ambas estrategias pueden combinarse:

```text
Tools frecuentes
      ↓
   Upfront

Tools especializadas
      ↓
   Retrieval
```

Esta estrategia híbrida puede ser especialmente útil cuando un agente dispone de un gran número de herramientas.

# Ejemplo simple en Power BI: Upfront vs Tool Retrieval

Supongamos que nuestro agente de Power BI tiene disponibles estas Tools:

```text
get_tables()
get_measures()
execute_dax()
create_measure()
update_measure()
```

---

## Estrategia A — Tool Definitions Upfront

El LLM recibe **desde el inicio las definiciones completas de todas las Tools**:

```text
get_tables
├── descripción
└── JSON Schema

get_measures
├── descripción
└── JSON Schema

execute_dax
├── descripción
└── JSON Schema

create_measure
├── descripción
└── JSON Schema

update_measure
├── descripción
└── JSON Schema
```

El usuario pregunta:

```text
"¿Cuáles son las ventas de este año?"
```

Como el LLM ya conoce completamente `execute_dax`, puede solicitar directamente:

```text
LLM
 ↓
execute_dax(...)
 ↓
Agente / Orquestador
 ↓
Power BI
 ↓
Resultado
```

**Ventaja:** es simple y el LLM conoce inmediatamente todas las Tools.

**Problema:** todas las definiciones consumen contexto aunque para esta tarea sólo necesitemos una.

---

## Estrategia B — Tool Retrieval

Es una **alternativa a Upfront**.

El LLM no recibe inicialmente los schemas completos de todas las Tools.

Ante:

```text
"¿Cuáles son las ventas de este año?"
```

el agente/modelo determina que necesita una capacidad relacionada con ejecutar DAX:

```text
Necesidad:
"ejecutar una consulta DAX"
        ↓
Tool Retrieval
        ↓
encuentra:
execute_dax
        ↓
carga su definición completa
        ↓
LLM conoce ahora su schema
        ↓
execute_dax(...)
        ↓
Agente / Orquestador
        ↓
Power BI
```

De esta forma, sólo cargamos la definición detallada de la Tool cuando es necesaria.

---

## Filesystem Retrieval

**Filesystem Retrieval es una forma concreta de implementar Tool Retrieval.**

No es una tercera estrategia al mismo nivel que Upfront y Tool Retrieval.

Por ejemplo, podemos guardar las definiciones de las Tools en archivos:

```text
tools/
├── execute-dax.md
├── get-measures.md
├── get-tables.md
├── create-measure.md
└── update-measure.md
```

Ante:

```text
"¿Cuáles son las ventas de este año?"
```

el flujo podría ser:

```text
LLM
 ↓
"Necesito ejecutar DAX"
 ↓
buscar Tool relevante
 ↓
encuenttra:
tools/execute-dax.md
 ↓
leer execute-dax.md
 ↓
obtener descripción + argumentos + schema
 ↓
LLM
 ↓
execute_dax(...)
 ↓
Agente / Orquestador
 ↓
Power BI
```

Así evitamos cargar desde el principio:

```text
get_tables      + schema
get_measures    + schema
execute_dax     + schema
create_measure  + schema
update_measure  + schema
```

y cargamos únicamente:

```text
execute_dax + schema
```

cuando realmente lo necesitamos.

---

## Relación entre los tres conceptos

```text
              ¿Cómo conoce el LLM las Tools?
                         │
             ┌───────────┴───────────┐
             │                       │
             ▼                       ▼
          UPFRONT               TOOL RETRIEVAL
             │                       │
     todas completas          sólo las relevantes
     desde el inicio             bajo demanda
                                     │
                                     ▼
                           FILESYSTEM RETRIEVAL
                           puede ser una forma
                           de implementarlo
```

Por tanto:

```text
Upfront
= cargar las definiciones completas de las Tools desde el inicio.

Tool Retrieval
= descubrir y cargar sólo las Tools relevantes cuando sean necesarias.

Filesystem Retrieval
= una posible implementación de Tool Retrieval utilizando archivos.
```

### Regla mental

> **Upfront vs Retrieval son estrategias alternativas.**
>
> **Filesystem Retrieval es una posible implementación de Retrieval.**