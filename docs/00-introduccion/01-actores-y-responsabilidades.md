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

## Cómo leerlo en Codex

En Codex para VS Code, la persona interactúa con una interfaz de producto que coordina el trabajo. No es necesario identificar cada proceso interno para entender el modelo mental: basta con distinguir el modelo que propone, el runtime que controla y las capacidades que se ejecutan.

Por ejemplo, ante una petición sobre una medida DAX:

| Pregunta | Responsable conceptual |
|---|---|
| ¿Qué necesita la persona? | Persona usuaria |
| ¿Qué siguiente acción podría ayudar? | LLM/modelo |
| ¿Se puede realizar esa acción? | Runtime y permisos |
| ¿Cómo se consulta el modelo? | Tool, posiblemente proporcionada por MCP |
| ¿Quién revisa el resultado? | Persona y agente, según el workflow |

Esta tabla describe responsabilidades, no necesariamente componentes visibles o separados en la interfaz.

Si estos términos se confunden, consulta [Conceptos que no deben confundirse](02-conceptos-que-no-deben-confundirse.md) antes de continuar.
---

[← Anterior](00-que-es-un-agente.md) · [Índice](../../README.md) · [Siguiente →](02-conceptos-que-no-deben-confundirse.md)
