# Tool Calling

Cómo solicita el modelo una acción y cómo se ejecuta realmente.

## Qué ocurre durante una llamada

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

