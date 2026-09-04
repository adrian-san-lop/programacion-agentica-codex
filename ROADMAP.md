# Roadmap de programación agéntica

Este documento sirve para controlar qué conceptos del curso ya están documentados y qué temas quedan pendientes. No pretende sustituir a `docs/notes.txt`: las notas son el espacio de captura y este roadmap es el espacio de seguimiento.

## Cómo utilizarlo

Cuando aparezca una idea nueva:

1. Anotarla primero en [`docs/notes.txt`](docs/notes.txt), manteniendo el contexto, enlaces y dudas originales.
2. Añadirla a la tabla de pendientes de este documento si requiere investigación o una nueva explicación.
3. Cuando se convierta en documentación estable, enlazar el documento resultante y cambiar su estado a `Cubierto`.
4. Si la documentación sólo cubre una parte, mantenerla como `Parcial` y describir qué falta.

Las notas pueden ser desordenadas o provisionales. Antes de convertirlas en documentación hay que contrastar las afirmaciones dependientes del producto, del runtime o de la versión utilizada.

## Estados

- `Cubierto`: existe documentación suficiente y enlazada.
- `Parcial`: existe una primera explicación, pero falta profundidad, ejemplos o verificación.
- `Pendiente`: el tema está identificado, pero todavía no tiene documentación suficiente.
- `Investigación`: requiere contrastar fuentes o comprobar el comportamiento real del runtime.
- `Futuro`: útil para una fase posterior del curso.

## Situación actual

| Área | Estado | Documentación relacionada | Próximo paso |
|---|---|---|---|
| Qué es un agente y Agent Loop | Cubierto | [`docs/00-introduccion/00-que-es-un-agente.md`](docs/00-introduccion/00-que-es-un-agente.md) | Reforzar objetivo, observación, decisión, acción, resultado y condición de parada con un ejemplo conceptual antes de pasar a código |
| Actores y responsabilidades | Cubierto | [`docs/00-introduccion/01-actores-y-responsabilidades.md`](docs/00-introduccion/01-actores-y-responsabilidades.md) | Mantener la separación entre LLM, runtime y agente |
| Conceptos que se confunden | Cubierto | [`docs/00-introduccion/02-conceptos-que-no-deben-confundirse.md`](docs/00-introduccion/02-conceptos-que-no-deben-confundirse.md) | Crear un glosario acumulativo y revisar que cada término se introduzca antes de reutilizarlo |
| Context Engineering | Cubierto | [`docs/01-context-engineering/`](docs/01-context-engineering/00-introduccion.md) · [`Contexto y recuperación en profundidad`](docs/01-context-engineering/07-recuperacion-profunda.md) | Mejorar el puente entre contexto estático/dinámico y una sesión real de Codex; dejar RAG y la implementación de índices como ampliación futura |
| Costes y Prompt Caching | Parcial | [`docs/01-context-engineering/05-costes-basicos-de-llm.md`](docs/01-context-engineering/05-costes-basicos-de-llm.md) · [`docs/01-context-engineering/06-prompt-caching.md`](docs/01-context-engineering/06-prompt-caching.md) | Separar con más claridad coste conceptual, límites de suscripción y precios de API; mantener Prompt Caching como optimización avanzada |
| Componentes del agente | Cubierto | [`docs/02-componentes/`](docs/02-componentes/00-system-prompt.md) | Añadir un recorrido conceptual único que muestre cómo se combinan System Prompt, `AGENTS.md`, Skill, Tool y Command en Codex |
| Tools y Tool Calling | Cubierto | [`docs/03-tools/`](docs/03-tools/00-que-es-una-tool.md) | Explicar el ciclo conceptual completo —catálogo, contrato, llamada, validación, resultado, error y decisión siguiente— antes de abordar una implementación |
| MCP, contexto y Tool Retrieval en Codex | Parcial | [`docs/03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md`](docs/03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md) · [`docs/04-integraciones/`](docs/04-integraciones/00-mcp-introduccion.md) | Mantener la documentación alineada con cambios del producto |
| Trabajo en equipo y Git | Cubierto | [`docs/05-trabajo-en-equipo/`](docs/05-trabajo-en-equipo/00-introduccion.md) | Mantenerlo separado de la teoría del agente |
| Ejemplo mínimo de Agent Loop | Cubierto | [`docs/06-ejemplos/00-agent-loop-minimo.md`](docs/06-ejemplos/00-agent-loop-minimo.md) | Mantenerlo como base ejecutable e independiente |
| Ejemplo Power BI / Fabric | Parcial | [`docs/06-ejemplos/01-power-bi-fabric.md`](docs/06-ejemplos/01-power-bi-fabric.md) | Desarrollar el ejemplo práctico paso a paso |

## Mejoras de la fase actual: fundamentos y claridad

La fase actual del curso no pretende todavía enseñar a construir una integración completa. Su objetivo es que una persona con experiencia en Power BI, pero sin experiencia previa en programación agéntica, pueda explicar qué ocurre en una tarea y por qué interviene cada componente.

Estas mejoras tienen prioridad antes de ampliar la práctica:

### A. Consolidar el modelo mental básico

**Estado:** Pendiente

Revisar los primeros capítulos para que el lector pueda seguir una única historia conceptual desde una petición hasta una respuesta final:

```text
objetivo
  → observación del contexto
  → decisión del modelo
  → validación del runtime
  → acción mediante una Tool
  → resultado
  → nueva decisión o finalización
```

La explicación debe distinguir siempre entre:

- el objetivo de la persona;
- la propuesta del modelo;
- la decisión autorizada por el runtime;
- la acción ejecutada en el entorno;
- la evidencia que devuelve la acción;
- la condición que permite terminar.

Antes de introducir código, conviene añadir recapitulaciones conceptuales breves y preguntas de comprobación que no requieran configurar herramientas.

### B. Crear un glosario progresivo y una terminología estable

**Estado:** Pendiente

Mantener una tabla central, enlazada desde los capítulos, para introducir cada término con:

- definición sencilla en castellano;
- término original en inglés entre paréntesis cuando sea útil;
- ejemplo dentro de Codex en VS Code;
- diferencia frente al concepto más cercano;
- indicación de si es un patrón general o una capacidad concreta de Codex.

Como mínimo, el glosario debe cubrir: modelo, LLM, runtime, agente, Agent Loop, contexto, Tool, Tool Call, Tool result, Skill, Command, `AGENTS.md`, MCP, cliente, host, servidor, catálogo, contrato, retrieval, memoria, permisos y aprobación.

No introducir siglas o términos avanzados —por ejemplo RAG, gateway, embedding, TTL o JSON Schema— sin una definición y una razón para que el principiante los necesite en ese punto.

### C. Hacer explícita la frontera entre teoría general y Codex

**Estado:** Parcial

Cada capítulo que mencione API, MCP, retrieval, memoria, caché o permisos debe indicar qué afirmación pertenece a:

1. el patrón general de los sistemas agénticos;
2. una aplicación propia que use una API;
3. Codex como producto utilizado mediante suscripción;
4. la extensión de Codex dentro de VS Code.

La documentación debe conservar una etiqueta o fórmula reconocible, por ejemplo `Patrón general`, `En Codex`, `Comparación con la API` y `No documentado públicamente`. Así se evita que una explicación de la API se interprete como una instrucción de configuración para el curso.

### D. Mejorar el puente entre Context Engineering y una sesión de Codex

**Estado:** Parcial

Los capítulos de contexto explican bien las piezas, pero deben terminar con una misma plantilla de lectura:

```text
Qué información estaba disponible al inicio
Qué información apareció durante la tarea
Quién decidió incorporarla
Qué parte controlaba la persona
Qué parte gestionaba Codex
Qué no podemos observar directamente
```

Esto permitirá conectar `AGENTS.md`, Skills, archivos abiertos, resultados de Tools, memoria, permisos y compaction sin presentarlos como sinónimos ni afirmar que todo entra literalmente en el prompt.

### E. Completar el modelo conceptual de Tools y MCP

**Estado:** Parcial

Antes de la fase práctica, aclarar con diagramas y ejemplos no ejecutables:

- catálogo frente a contrato frente a invocación;
- Tool local frente a Tool proporcionada por MCP;
- cliente MCP, host y servidor MCP;
- Tool, Resource, Prompt e instrucciones del servidor;
- descubrimiento de una capacidad frente a autorización para ejecutarla;
- resultado correcto frente a error, rechazo y timeout;
- operación de lectura frente a operación con efectos secundarios.

El lector debe poder responder “qué es MCP” sin confundirlo con una Tool concreta, una API, una Skill o un mecanismo de búsqueda de Tools.

### F. Introducir seguridad como propiedad del modelo mental

**Estado:** Parcial

La seguridad no debe aparecer sólo como una ampliación de diseño. En los fundamentos debe quedar claro que:

- el modelo propone, pero no concede permisos;
- el runtime valida la llamada y aplica políticas;
- la persona conserva la responsabilidad sobre aprobaciones y cambios relevantes;
- el contenido recuperado puede ser incorrecto o malicioso;
- leer una instrucción no autoriza a escribir, borrar, publicar o exfiltrar datos.

Este bloque debe ser conceptual y no requiere todavía implementar controles.

### G. Reordenar la carga cognitiva sin cambiar la ruta conceptual

**Estado:** Pendiente

Mantener el orden general del README, pero revisar cada capítulo con esta secuencia:

1. idea en una frase;
2. vocabulario mínimo;
3. diagrama o ejemplo de Power BI/Fabric;
4. explicación del mecanismo;
5. qué ocurre en Codex;
6. qué no debe inferirse;
7. resumen y pregunta de comprobación;
8. enlace al siguiente concepto.

Los capítulos sobre Prompt Caching, Tool Retrieval, mediación y recuperación profunda deben conservarse, pero presentarse como capas posteriores del modelo mental, no como requisitos para entender primero qué es un agente.

### H. Mantener una matriz de verificación de producto

**Estado:** Investigación

Para las afirmaciones que puedan cambiar, registrar en el roadmap o en una nota de mantenimiento:

- cliente: extensión IDE de Codex para VS Code;
- modalidad: suscripción de ChatGPT;
- fecha de comprobación;
- comportamiento observado;
- fuente oficial;
- diferencia entre hecho documentado, observación local e inferencia.

La matriz debe cubrir especialmente `AGENTS.md`, Skills, MCP, permisos, subagentes, memoria, compaction y Tool Retrieval. No usar documentación de Cursor, Claude Code o de la API como evidencia directa del comportamiento de Codex.

## Pendientes prioritarios

### 1. Del concepto a la implementación

**Estado:** Futuro — fase práctica

El [ejemplo mínimo de Agent Loop](docs/06-ejemplos/00-agent-loop-minimo.md) muestra el ciclo, los mensajes, la validación, una Tool y la condición de finalización. Sigue pendiente ampliar con una implementación conectada a un modelo real y explicar:

- el bucle principal;
- los mensajes y roles de una petición;
- una definición con JSON Schema;
- la validación de argumentos;
- los resultados y errores de una Tool;
- los reintentos, timeouts y límites de iteraciones;
- la respuesta final y la cancelación.

### 2. Diseño seguro de Tools

**Estado:** Futuro — fase práctica, después de consolidar la seguridad conceptual

Ampliar los documentos actuales con idempotencia, efectos secundarios, permisos, operaciones de solo lectura frente a escritura, aprobación humana, límites de argumentos y tratamiento de datos sensibles.

### 3. Contexto y recuperación en profundidad

**Estado:** Cubierto como base teórica; pendiente de validación con un modelo real

La documentación [Contexto y recuperación en profundidad](docs/01-context-engineering/07-recuperacion-profunda.md) desarrolla, con un ejemplo DAX conceptual y trazable:

- cómo se construye una petición real al modelo;
- cómo se selecciona y ordena el contexto recuperado;
- diferencias entre búsqueda por texto, búsqueda semántica e índices;
- caché, compresión, resumen y caducidad del contexto;
- memoria de sesión frente a memoria persistente;
- cómo medir coste, latencia y calidad de la recuperación.

La ejecución real y la comparación mediante un dataset de evaluación quedan reservadas para la fase práctica.

### 4. Contexto y Tool Retrieval en Codex mediante suscripción

**Estado:** Investigación

La documentación específica de Codex está en [Contexto y Tool Retrieval en Codex mediante suscripción](docs/03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md). Las notas contienen además observaciones sobre Cursor y Claude Code. Hay que separar tres niveles antes de documentar más:

1. el patrón general de retrieval;
2. la implementación concreta de Cursor o Claude;
3. las capacidades realmente disponibles en Codex para esta instalación.

No trasladar porcentajes de ahorro de otros productos a Codex sin una medición comparable.

### 5. MCP con más detalle

**Estado:** Parcial

Documentar, cuando sea necesario para el curso, la relación entre host, cliente y servidor MCP, el ciclo de conexión, el descubrimiento de capacidades, Tools, Resources, Prompts e instrucciones del servidor, transportes, autenticación y límites de la integración concreta de Power BI.

### 6. Subagentes y sistemas multiagente

**Estado:** Parcial

Ampliar la introducción actual con patrones de delegación, aislamiento de contexto, handoff, paralelismo, coordinación, herencia de permisos, coste, criterios para no delegar y validación de resultados del subagente.

### 7. Evaluación, observabilidad y fiabilidad

**Estado:** Pendiente

Añadir cómo evaluar un agente más allá de que produzca una respuesta:

- tasa de éxito de tareas;
- Tool Calls inválidas;
- calidad de los argumentos;
- latencia y coste;
- trazas y auditoría;
- regresiones al cambiar prompts, Skills o Tools;
- datasets y casos de prueba;
- revisión humana de operaciones de riesgo.

### 8. Seguridad específica de agentes

**Estado:** Parcial

Profundizar en prompt injection, instrucciones no confiables recuperadas del workspace, exfiltración de secretos, escalada de permisos, herramientas destructivas, aislamiento del entorno y límites de red o filesystem.

### 9. Ejemplo práctico de Power BI / Fabric

**Estado:** Futuro — fase práctica

Construir el ejemplo cuando el curso llegue a la parte práctica:

```text
Tarea DAX
  ↓
AGENTS.md
  ↓
Skill especializada
  ↓
documentación del modelo
  ↓
Tool MCP de inspección
  ↓
análisis y propuesta
  ↓
aprobación
  ↓
modificación y validación
```

Debe distinguir siempre qué ocurre en el modelo, qué hace el runtime y qué capacidad proporciona el MCP.

### 10. Modos de trabajo, hooks y flujo completo

**Estado:** Pendiente

Incorporar los temas del curso que todavía no tienen un capítulo específico en esta documentación:

- diferencias entre modos de trabajo como Ask, Plan, Agent y Debug, sin asumir que todos los clientes los denominan igual;
- hooks y controles deterministas alrededor del Agent Loop;
- recorrido desde una tarea o issue hasta el plan, la implementación, las pruebas y la entrega a producción;
- relación entre Progressive Disclosure, Skills, MCP, documentación y subagentes en ese recorrido.

## Temas que pueden aparecer en nuevas notas

Al actualizar `docs/notes.txt`, revisar si aparecen conceptos de estas familias:

- planificación, descomposición y selección de acciones;
- memoria y estado;
- evaluación y tracing;
- seguridad y gobernanza;
- arquitecturas multiagente;
- streaming, concurrencia y eventos;
- costes, latencia y caching;
- modelos, SDKs y APIs concretas;
- despliegue, versionado y operación en producción.

No todos deben entrar automáticamente en el curso. Antes de añadir un tema hay que comprobar si ayuda al objetivo actual, si depende de una tecnología concreta y en qué capítulo encaja.

## Registro de actualizaciones desde `notes.txt`

| Fecha | Tema detectado | Acción | Documento resultante |
|---|---|---|---|
| 2026-09-03 | Roadmap inicial a partir de la revisión de la documentación existente | Crear este roadmap y definir el flujo notes → documentación | — |
