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

## El ciclo completo de una Tool Call

Una llamada no termina cuando el modelo escribe el nombre de la Tool. El ciclo conceptual completo es:

1. El modelo propone una Tool y sus argumentos.
2. El runtime comprueba que la Tool exista y que la llamada tenga el formato esperado.
3. El runtime aplica permisos, límites y, cuando corresponda, solicita aprobación.
4. La Tool se ejecuta o se rechaza.
5. El resultado o el error vuelve al runtime.
6. El modelo interpreta la evidencia y decide si responde, corrige la llamada o continúa con otra Tool.

Un error, un rechazo y un resultado vacío también son resultados del ciclo. No deben ocultarse ni tratarse automáticamente como una respuesta correcta. Esta idea será importante cuando estudiemos seguridad, MCP y validación.

---

[← Anterior](00-que-es-una-tool.md) · [Índice](../../README.md) · [Siguiente →](02-mediacion-de-tools.md)

