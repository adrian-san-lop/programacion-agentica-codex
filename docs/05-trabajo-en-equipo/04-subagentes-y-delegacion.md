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

El subagente puede consultar documentación adicional si el proyecto se lo indica mediante `AGENTS.md` o instrucciones específicas. No conviene enviarle toda la documentación desde el principio: aumenta el ruido y el consumo de contexto.

El agente principal coordina y revisa el resultado; la persona valida la decisión final.

---

[← Anterior](03-skills-compartidas.md) · [Índice](../../README.md) · [Siguiente →](05-flujo-git-y-pull-requests.md)
