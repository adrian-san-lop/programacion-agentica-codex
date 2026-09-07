# Tool Calling

Cómo solicita el modelo una acción y cómo se ejecuta realmente.

## Qué ocurre durante una llamada

Una **Tool Call** es una solicitud del LLM para utilizar una herramienta.

Ejemplo:

```text
Usuario:

"Analiza la medida Sales YTD y explica si hay algún problema. No modifiques nada."
```

El LLM puede razonar:

```text
Necesito consultar la expresión actual de Sales YTD.
```

Y solicitar:

```text
get_measure(
    table="tabla verificada",
    measure="Sales YTD"
)
```

Pero el LLM **no ejecuta realmente `get_measure()`**. Es un nombre ilustrativo: el contrato real debe comprobarse en la Tool disponible.

El flujo es:

```text
LLM
 │
 │ solicita Tool Call
 ▼
Runtime / orquestador
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
> El runtime coordina la ejecución real de la Tool.

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

## Comprueba que lo entiendes

**¿Un resultado vacío demuestra que la medida no existe?**

No necesariamente. Hay que comprobar el modelo, el nombre, los filtros y el alcance de la consulta antes de concluirlo.

[← Anterior](00-que-es-una-tool.md) · [Índice](../../README.md) · [Siguiente →](02-mediacion-de-tools.md)

