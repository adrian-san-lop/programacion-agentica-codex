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
| Qué es un agente y Agent Loop | Cubierto | [`docs/00-introduccion/00-que-es-un-agente.md`](docs/00-introduccion/00-que-es-un-agente.md) | Añadir un ejemplo ejecutable cuando comience la parte práctica |
| Actores y responsabilidades | Cubierto | [`docs/00-introduccion/01-actores-y-responsabilidades.md`](docs/00-introduccion/01-actores-y-responsabilidades.md) | Mantener la separación entre LLM, runtime y agente |
| Conceptos que se confunden | Cubierto | [`docs/00-introduccion/02-conceptos-que-no-deben-confundirse.md`](docs/00-introduccion/02-conceptos-que-no-deben-confundirse.md) | Revisar el documento cuando aparezcan nuevos términos |
| Context Engineering | Cubierto | [`docs/01-context-engineering/`](docs/01-context-engineering/00-introduccion.md) · [`Contexto y recuperación en profundidad`](docs/01-context-engineering/07-recuperacion-profunda.md) | Mantener la selección de contexto aplicada a Codex; dejar RAG como ampliación futura |
| Costes y Prompt Caching | Parcial | [`docs/01-context-engineering/05-costes-basicos-de-llm.md`](docs/01-context-engineering/05-costes-basicos-de-llm.md) · [`docs/01-context-engineering/06-prompt-caching.md`](docs/01-context-engineering/06-prompt-caching.md) | Mantener Prompt Caching como optimización avanzada, no como práctica principal |
| Componentes del agente | Cubierto | [`docs/02-componentes/`](docs/02-componentes/00-system-prompt.md) | Mostrar cómo se combinan en una sesión completa |
| Tools y Tool Calling | Cubierto | [`docs/03-tools/`](docs/03-tools/00-que-es-una-tool.md) | Añadir implementación mínima y manejo de errores |
| MCP, contexto y Tool Retrieval en Codex | Parcial | [`docs/03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md`](docs/03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md) · [`docs/04-integraciones/`](docs/04-integraciones/00-mcp-introduccion.md) | Mantener la documentación alineada con cambios del producto |
| Trabajo en equipo y Git | Cubierto | [`docs/05-trabajo-en-equipo/`](docs/05-trabajo-en-equipo/00-introduccion.md) | Mantenerlo separado de la teoría del agente |
| Ejemplo mínimo de Agent Loop | Cubierto | [`docs/06-ejemplos/00-agent-loop-minimo.md`](docs/06-ejemplos/00-agent-loop-minimo.md) | Mantenerlo como base ejecutable e independiente |
| Ejemplo Power BI / Fabric | Parcial | [`docs/06-ejemplos/01-power-bi-fabric.md`](docs/06-ejemplos/01-power-bi-fabric.md) | Desarrollar el ejemplo práctico paso a paso |

## Pendientes prioritarios

### 1. Del concepto a la implementación

**Estado:** Parcial

El [ejemplo mínimo de Agent Loop](docs/06-ejemplos/00-agent-loop-minimo.md) muestra el ciclo, los mensajes, la validación, una Tool y la condición de finalización. Sigue pendiente ampliar con una implementación conectada a un modelo real y explicar:

- el bucle principal;
- los mensajes y roles de una petición;
- una definición con JSON Schema;
- la validación de argumentos;
- los resultados y errores de una Tool;
- los reintentos, timeouts y límites de iteraciones;
- la respuesta final y la cancelación.

### 2. Diseño seguro de Tools

**Estado:** Parcial

Ampliar los documentos actuales con idempotencia, efectos secundarios, permisos, operaciones de solo lectura frente a escritura, aprobación humana, límites de argumentos y tratamiento de datos sensibles.

### 3. Contexto y recuperación en profundidad

**Estado:** Cubierto como base teórica; pendiente de validación con un modelo real

La documentación [Contexto y recuperación en profundidad](docs/01-context-engineering/07-recuperacion-profunda.md) desarrolla, con un ejemplo DAX trazable:

- cómo se construye una petición real al modelo;
- cómo se selecciona y ordena el contexto recuperado;
- diferencias entre búsqueda por texto, búsqueda semántica e índices;
- caché, compresión, resumen y caducidad del contexto;
- memoria de sesión frente a memoria persistente;
- cómo medir coste, latencia y calidad de la recuperación.

Queda pendiente conectar el registro conceptual con una ejecución real y comparar configuraciones mediante un dataset de evaluación.

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

**Estado:** Futuro

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
