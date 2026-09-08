# Ejemplo mínimo de Agent Loop

**Material opcional para la fase práctica.** Esta simulación Python permite observar el ciclo con una Tool local y sin dependencias externas. No es un agente real ni un requisito para seguir los fundamentos.

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

La función `model` simula la decisión con reglas fijas: no interpreta libremente lo que escribe el usuario. No vamos a conectarla a un proveedor; al pasar a la práctica utilizaremos Codex. `run_agent` representa de forma didáctica al runtime que valida y ejecuta la Tool.

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
