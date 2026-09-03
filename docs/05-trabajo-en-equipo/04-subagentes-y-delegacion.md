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
+ criterios de éxito
```

En las versiones locales actuales de Codex, la delegación puede solicitarse explícitamente o estar indicada por `AGENTS.md` o una Skill. Los subagentes heredan la política de permisos del agente principal y cada uno ejecuta su propio trabajo con el modelo y las Tools disponibles, por lo que el flujo puede consumir más tokens que una ejecución equivalente con un solo agente.

El subagente puede consultar documentación adicional si el proyecto se lo indica mediante `AGENTS.md` o instrucciones específicas. No conviene enviarle toda la documentación desde el principio: aumenta el ruido y el consumo de contexto.

El agente principal coordina y revisa el resultado; la persona valida la decisión final.

Consulta la [documentación oficial sobre subagentes en Codex](https://learn.chatgpt.com/es-419/docs/agent-configuration/subagents) para comprobar disponibilidad y configuración en el cliente utilizado.

---

[← Anterior](03-skills-compartidas.md) · [Índice](../../README.md) · [Siguiente →](05-flujo-git-y-pull-requests.md)
