# Actores y responsabilidades

Un agente se entiende mejor si se separan sus responsabilidades. El modelo propone razonamientos y acciones; el runtime controla el contexto y la ejecución.

```text
Usuario
  ↓
Runtime / orquestador
  ├── construye el contexto
  ├── proporciona Tools al LLM
  ├── valida y ejecuta Tool Calls
  └── devuelve resultados
       ↓
      LLM
       ↓
  Tool / API / MCP Server / filesystem
```

- **LLM**: interpreta la petición, razona y propone la siguiente acción.
- **Runtime u orquestador**: implementa el Agent Loop y aplica las políticas del sistema.
- **Tool**: capacidad concreta que puede invocarse con argumentos.
- **MCP Server**: servidor que expone Tools u otros recursos mediante MCP.

La separación es conceptual: un producto concreto puede agrupar varias de estas funciones bajo el nombre de agente o cliente.
---


---

[← Anterior](00-que-es-un-agente.md) · [Índice](../../README.md) · [Siguiente →](../01-context-engineering/00-introduccion.md)
