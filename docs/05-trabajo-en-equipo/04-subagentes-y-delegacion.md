# Subagentes y delegación

Un subagente es un agente especializado al que se delega una tarea aislada. No sustituye a la documentación ni a una Skill.

```text
Agente principal
├── subagente revisor de enlaces
├── subagente auditor de documentación
└── subagente validador de ejemplos
```

La delegación debe incluir solo lo necesario:

```text
tarea concreta
+ archivos relevantes
+ restricciones y alcance autorizado
+ criterios de éxito
+ evidencia y formato de entrega
```

En las versiones locales actuales de Codex, la delegación puede solicitarse explícitamente o estar indicada por `AGENTS.md` o una Skill. Los subagentes heredan la política de permisos del agente principal y cada uno ejecuta su propio trabajo con el modelo y las Tools disponibles, por lo que el flujo puede consumir más tokens que una ejecución equivalente con un solo agente.

El subagente puede consultar documentación adicional si el proyecto se lo indica mediante `AGENTS.md` o instrucciones específicas. No conviene enviarle toda la documentación desde el principio: aumenta el ruido y el consumo de contexto.

## Cuándo ayuda delegar

| Situación | Criterio del curso |
|---|---|
| Dos análisis de lectura independientes | Puede compensar repartirlos si cada uno tiene un resultado acotado |
| Tarea breve o cuyo siguiente paso depende del anterior | Mantener un solo agente evita coordinación innecesaria |
| Varios agentes modificarían los mismos archivos | Evitar repartir escrituras sin separar responsabilidades y revisar conflictos |
| Faltan datos esenciales para todos | Obtener o aclarar esos datos antes de multiplicar el trabajo |

OpenAI recomienda empezar por tareas independientes de lectura y advierte de los conflictos y la coordinación adicional al escribir en paralelo. Esta tabla adapta esa orientación a nuestro curso. [Criterios oficiales de delegación](https://learn.chatgpt.com/docs/agent-configuration/subagents), revisados el 2026-09-08.

## Qué entregar y cómo revisarlo

En Sales YTD, un encargo delegado debe conservar el límite de sólo lectura y pedir fuentes, hallazgos, hipótesis y datos pendientes. El subagente debe indicar qué pudo comprobar y qué quedó fuera de su alcance.

El agente principal contrasta la entrega con las fuentes y el objetivo, resuelve discrepancias y reúne las conclusiones. Dos agentes que coinciden no constituyen por sí solos una validación independiente: pueden haber usado la misma fuente incompleta. La persona valida la decisión final.

## Comprueba que lo entiendes

**¿Más subagentes garantizan una revisión mejor?**

No. Ayudan cuando el trabajo puede separarse y sus resultados se pueden revisar. Añaden consumo y coordinación.

**¿El subagente puede corregir Sales YTD si sólo se le pidió analizarla?**

No. Debe conservar las restricciones del encargo y devolver su propuesta con evidencia, sin ejecutar la modificación.

Consulta la [documentación oficial sobre subagentes en Codex](https://learn.chatgpt.com/es-419/docs/agent-configuration/subagents) para comprobar disponibilidad y configuración en el cliente utilizado.

---

[← Anterior](03-skills-compartidas.md) · [Índice](../../README.md) · [Siguiente →](05-flujo-git-y-pull-requests.md)
