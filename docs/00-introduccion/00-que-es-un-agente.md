# Qué es un agente y Agent Loop

Un agente utiliza un modelo para decidir cómo avanzar hacia un objetivo, actúa mediante herramientas y utiliza los resultados para decidir el siguiente paso.

## Qué aprendemos en este curso

Aprendemos programación agéntica utilizando la extensión de Codex para VS Code con una suscripción de ChatGPT Business. No construimos otro Codex: aprendemos a orientar su trabajo y a comprobar sus resultados.

Partimos de experiencia en programación y Power BI, pero no de conocimientos previos sobre agentes. Power BI y Fabric nos ayudan a entender los ejemplos; todavía no es necesario conectar un modelo real.

## De un script a un agente

En un script, tú defines de antemano la lógica, incluidas sus condiciones y bucles. En un agente, parte de la elección de los siguientes pasos se delega al modelo según el objetivo y los resultados disponibles. Puede combinar procedimientos predefinidos con esas decisiones.

Lo agéntico no es simplemente conversar ni generar código: es cerrar el ciclo entre decisión, acción y resultado. Tampoco significa autonomía sin límites.

## Vocabulario para empezar

Un **modelo de lenguaje o LLM** (Large Language Model) procesa lenguaje y genera respuestas. Un **prompt** es la petición o instrucción que recibe. Un **flujo de trabajo o workflow** es una secuencia de pasos para resolver una tarea. El **workspace** es la carpeta o entorno de trabajo del proyecto.

## Tres piezas

- **Modelo o LLM:** interpreta la tarea y propone la siguiente acción o respuesta.
- **Runtime u orquestador:** entorno que prepara el contexto, coordina la ejecución y aplica permisos.
- **Tool o herramienta:** capacidad ejecutable, como leer un archivo o consultar una medida.

El **agente** es el sistema completo, no sólo el modelo ni sólo el runtime. Una **Tool Call** es la solicitud de utilizar una herramienta con unos argumentos.

## Nuestra historia: revisar Sales YTD

Seguiremos esta petición a lo largo de los capítulos:

> Analiza la medida Sales YTD y explica si hay algún problema. No modifiques nada.

Es un caso conceptual. Los nombres de herramientas que aparezcan son ilustrativos; no garantizan que existan con ese nombre en una instalación.

```text
Persona: define objetivo y límite de sólo lectura
  ↓
Runtime: reúne instrucciones y contexto disponible
  ↓
Modelo: propone consultar la expresión de Sales YTD
  ↓
Runtime: comprueba la llamada y los permisos
  ↓
Tool: obtiene la expresión
  ↓
Runtime: devuelve el resultado al modelo
  ↓
Modelo: decide si necesita relaciones o reglas del proyecto
  ↓
Otra consulta, respuesta final o petición de información
```

Los textos atribuidos al modelo son una explicación didáctica de la decisión, no una transcripción de su razonamiento interno.

## Agent Loop: el ciclo del agente

El **Agent Loop** repite observación, decisión, acción y lectura del resultado. El modelo no ejecuta directamente la herramienta: el runtime coordina su ejecución.

El ciclo puede terminar porque:

- hay información suficiente para responder al objetivo;
- falta un dato o permiso que debe aportar la persona;
- una herramienta falla y no hay una alternativa segura;
- se alcanza un límite o la persona cancela.

En nuestra historia, terminar bien significa explicar los hallazgos con evidencia o declarar qué falta. No significa modificar la medida ni demostrar a toda costa que hay un error.

## Cómo formular un encargo

Esta pauta del curso ayuda a orientar y evaluar el trabajo:

```text
Objetivo → fuentes → restricciones → entrega → criterio de finalización
```

| Pieza | En la revisión de Sales YTD |
|---|---|
| Objetivo | Explicar el comportamiento y posibles problemas de la medida |
| Fuentes | Expresión actual, reglas DAX y relaciones necesarias |
| Restricciones | Sólo lectura; no inventar datos que falten |
| Entrega | Hallazgos con fuentes, hipótesis y límites del análisis |
| Criterio de finalización | Hay evidencia suficiente para responder o se identifica qué impide concluir |

El criterio de finalización permite reconocer cuándo terminar; no exige encontrar un error. El capítulo de [recuperación](../01-context-engineering/07-recuperacion-profunda.md) desarrolla cómo seleccionar las fuentes.

## Comprueba que lo entiendes

**¿El modelo puede modificar Sales YTD porque cree que ha encontrado una mejora?**

No. La petición autoriza analizar, no escribir. Una propuesta útil no amplía el permiso.

**¿Una herramienta que falla rompe necesariamente todo el trabajo?**

No. El resultado del fallo puede permitir corregir la consulta o buscar una alternativa autorizada. Si no la hay, el agente debe explicar el bloqueo.

---

[Índice](../../README.md) · [Siguiente →](01-actores-y-responsabilidades.md)

