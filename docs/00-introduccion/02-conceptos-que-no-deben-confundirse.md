# Conceptos que no deben confundirse

Estos conceptos están relacionados, pero no son sinónimos. Separarlos desde el principio evita muchos errores al diseñar o utilizar un agente.

## LLM, agente y runtime

Un **LLM** es el modelo que interpreta texto y genera una respuesta. Por sí solo no accede a una base de datos, no ejecuta comandos y no modifica archivos.

Un **agente** es el sistema completo que utiliza un LLM para alcanzar un objetivo mediante un ciclo de decisiones y acciones.

El **runtime** u **orquestador** es el componente que ejecuta ese ciclo: construye el contexto, presenta capacidades al modelo, valida sus llamadas, ejecuta las Tools y devuelve los resultados.

```text
LLM       → propone la siguiente decisión
Runtime   → controla y ejecuta la decisión
Agente    → conjunto formado por modelo, runtime, reglas y capacidades
```

Por eso, decir que «el LLM ejecuta una Tool» es una simplificación incorrecta. El LLM propone una Tool Call y el runtime decide si puede ejecutarse y la ejecuta.

## Chatbot y agente

Un **chatbot** puede limitarse a responder con texto a cada mensaje.

Un **agente** puede descomponer un objetivo, consultar información, ejecutar acciones, observar resultados y continuar iterando hasta completar la tarea.

La frontera no depende de que exista una interfaz de chat. Depende de si el sistema puede actuar sobre un entorno y utilizar los resultados de esas acciones.

## Tool, Skill y Command

| Concepto | Qué es | Ejemplo en un proyecto PBIP |
|---|---|---|
| Tool | Capacidad ejecutable con argumentos | Obtener una medida o ejecutar DAX |
| Skill | Procedimiento y reglas para resolver una clase de tareas | Revisar una medida DAX de forma segura |
| Command | Atajo para iniciar un workflow | `/commit` o una petición equivalente |

Una Skill no es una Tool: explica cómo trabajar y qué validar, pero no ejecuta por sí misma. Un Command tampoco contiene necesariamente todo el conocimiento del proceso; normalmente inicia un workflow cuya lógica está en una Skill.

```text
Command → inicia el workflow
Skill   → explica el procedimiento
Tool    → ejecuta una acción concreta
```

## AGENTS.md, documentación y Skills

Estos tres recursos pueden ser archivos Markdown, pero cumplen funciones distintas:

```text
AGENTS.md → reglas persistentes y mapa de navegación
docs/     → conocimiento conceptual o específico del proyecto
Skill     → workflow reutilizable con pasos y validaciones
```

`AGENTS.md` debería indicar dónde encontrar la información, no contener toda la información. La documentación explica; la Skill prescribe cómo actuar en una tarea repetible.

## MCP, API, Tool y Tool Retrieval

Una **API** es una interfaz que permite comunicarse con un servicio.

Una **Tool** es una operación concreta que el agente puede solicitar, normalmente envolviendo una API, una consulta, un script o una capacidad local.

**MCP** es un protocolo para descubrir y exponer capacidades —entre ellas Tools— a un cliente compatible.

**Tool Retrieval** es la estrategia para decidir qué definiciones de Tools se presentan al modelo en cada tarea. No es un protocolo de conexión.

```text
MCP            → cómo se conectan y anuncian capacidades
Tool           → qué operación concreta puede ejecutarse
Tool Retrieval → qué operación se muestra al modelo ahora
```

Un servidor MCP puede exponer muchas Tools y el runtime puede presentarlas todas upfront o recuperar sólo las relevantes. MCP no implica automáticamente Retrieval.

## Glosario mínimo

| Término | Definición sencilla |
|---|---|
| Modelo o LLM | Sistema que interpreta entradas y genera texto o decisiones propuestas. |
| Runtime | Capa que reúne contexto, aplica políticas y coordina la ejecución. |
| Agente | Sistema completo formado por modelo, runtime, instrucciones y capacidades. |
| Agent Loop | Ciclo de observar, decidir, actuar, recibir el resultado y continuar o terminar. |
| Contexto | Información disponible para tomar la siguiente decisión. |
| Tool | Capacidad ejecutable con argumentos. |
| Tool Call | Solicitud estructurada para utilizar una Tool. |
| Tool result | Resultado que la Tool devuelve al runtime y que puede volver al contexto. |
| Skill | Procedimiento especializado con instrucciones y validaciones. |
| Command | Atajo o petición que inicia un workflow. |
| MCP | Protocolo para conectar un cliente con servidores que exponen capacidades. |
| Retrieval | Recuperación selectiva de información o definiciones relevantes. |
| Permiso | Regla que limita qué puede leer, escribir o ejecutar el runtime. |
| Aprobación | Confirmación humana requerida antes de una operación determinada. |

Cuando aparezca un término nuevo, conviene ubicarlo en esta tabla antes de estudiar sus detalles. Una Tool puede pertenecer a un servidor MCP, una Skill puede indicar cuándo utilizarla y un permiso puede impedir la ejecución; ninguno de esos conceptos es intercambiable.

## Catálogo, contrato e invocación

No debe confundirse saber que existe una Tool con tener información suficiente para usarla:

```text
Catálogo    → execute_query existe y sirve para consultar datos
Contrato    → nombre, argumentos, tipos, restricciones y errores
Invocación  → execute_query({ query: "SELECT ..." })
Resultado   → datos que vuelven al contexto del modelo
```

El catálogo facilita el descubrimiento; el contrato permite construir una llamada válida; la invocación produce un resultado que alimenta el Agent Loop.

## MCP y CLI

Una **CLI** es una interfaz de línea de comandos. El agente suele utilizarla a través de una Tool de terminal o shell.

En este repositorio, una separación habitual es:

```text
MCP → inspeccionar o modificar Power BI mediante una interfaz estructurada
CLI → Git, validadores, tests y scripts del repositorio
```

Una Skill puede coordinar ambos. Por ejemplo, puede usar MCP para validar una medida y CLI para revisar el diff del proyecto.

## Resumen para recordar

```text
El modelo decide.
El runtime controla y ejecuta.
Las Tools hacen acciones.
Las Skills explican workflows.
Los Commands los inician.
MCP conecta capacidades.
Tool Retrieval decide cuáles presentar.
AGENTS.md orienta.
docs/ documenta.
```

Estas distinciones son conceptuales. Un producto concreto puede agrupar varias funciones bajo el mismo nombre, por lo que siempre conviene comprobar cómo las implementa el runtime utilizado.

## Comprobación

Antes de continuar, intenta contestar sin mirar el texto:

1. ¿Qué diferencia hay entre el modelo y el runtime?
2. ¿Por qué una Skill no es una Tool?
3. ¿Qué aporta MCP que no aporta una Tool concreta?
4. ¿Por qué descubrir una capacidad no significa tener permiso para ejecutarla?

[← Anterior](01-actores-y-responsabilidades.md) · [Índice](../../README.md) · [Siguiente →](../01-context-engineering/00-introduccion.md)
