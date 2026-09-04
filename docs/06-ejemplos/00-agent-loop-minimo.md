# Ejemplo mínimo de Agent Loop

Antes de utilizar MCP o Power BI, conviene observar el ciclo básico con una Tool local. El ejemplo funciona con Python y no necesita API key ni dependencias externas.

Código: [`examples/minimal-agent-loop/agent.py`](../../examples/minimal-agent-loop/agent.py).

## Ejecutarlo en VS Code

Desde la raíz del repositorio, abre el terminal integrado y ejecuta:

```powershell
python examples/minimal-agent-loop/agent.py
```

El programa simula el modelo para que podamos centrarnos en la mecánica del agente.

La salida esperada es similar a esta:

```text
USER: ¿Cuánto es 6 por 7?
MODEL: solicita calculate
RUNTIME: Tool ejecutada -> 42
MODEL: genera la respuesta final
FINAL: El resultado es 42.
```

## Qué ocurre

```text
Petición del usuario
  ↓
Modelo propone calculate
  ↓
Runtime valida nombre y argumentos
  ↓
Runtime ejecuta la Tool
  ↓
Resultado de la Tool vuelve al contexto
  ↓
Modelo genera la respuesta final
```

La función `model` representa al modelo. En una aplicación real se sustituiría por una llamada al proveedor elegido. El runtime está representado por `run_agent` y es quien valida y ejecuta la Tool.

La función `calculate` es la Tool. Su contrato está reflejado en `validate_tool_call`, que rechaza Tools u operaciones no permitidas antes de ejecutarlas.

El bucle tiene un límite de tres iteraciones. La condición normal de finalización es recibir una respuesta de tipo `final`; si no ocurre, el runtime detiene el proceso para evitar un bucle indefinido.

## Relación con lo aprendido

| Concepto | Dónde aparece |
|---|---|
| Usuario y modelo | `user_request` y `model` |
| Agent Loop | `run_agent` |
| Tool Calling | respuesta `tool_call` |
| Runtime | validación y ejecución |
| Tool | `calculate` |
| Tool result | mensaje con `role: tool` |
| Seguridad | validación antes de ejecutar |
| Contexto dinámico | mensajes que se añaden durante el ciclo |

Este ejemplo no implementa MCP ni Tool Retrieval. Es una base mínima para entenderlos después: MCP cambiará la forma de obtener la Tool y su conexión, pero no elimina la necesidad de que el runtime coordine el ciclo.

---

[← Anterior](../05-trabajo-en-equipo/05-flujo-git-y-pull-requests.md) · [Índice](../../README.md) · [Siguiente →](01-power-bi-fabric.md)
