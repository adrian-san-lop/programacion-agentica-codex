# Qué es un agente y Agent Loop

Un agente combina un modelo de lenguaje, un orquestador y capacidades externas para alcanzar un objetivo.

## Agente

Un **agente** es un sistema que utiliza un LLM como motor de razonamiento y que puede interactuar con su entorno mediante herramientas.

Una forma simplificada de verlo:

```text
Usuario
   ↓
Agente / Orquestador
   ↓
LLM
   ↓
Decisión
   ↓
Tool
   ↓
Resultado
   ↓
LLM
   ↓
...
   ↓
Respuesta final
```

El **LLM no ejecuta directamente las herramientas**.

El LLM puede solicitar una acción mediante una **Tool Call** y es el agente/orquestador quien:

1. Recibe la solicitud del LLM.
2. Valida la llamada.
3. Ejecuta la herramienta.
4. Obtiene el resultado.
5. Devuelve ese resultado al LLM.
6. El LLM decide qué hacer a continuación.

A este proceso iterativo se le suele llamar **Agent Loop**.

---

---


## Agent Loop

El **Agent Loop** es el ciclo mediante el cual el agente intenta conseguir un objetivo.

Conceptualmente:

```text
        ┌─────────────────────┐
        │                     │
        ▼                     │
     OBSERVAR                 │
        ↓                     │
     RAZONAR                  │
        ↓                     │
     DECIDIR                  │
        ↓                     │
      ACTUAR                  │
        ↓                     │
     RESULTADO ───────────────┘
```

Por ejemplo:

```text
Usuario:
"¿Cuántas ventas tuvimos este año?"

        ↓

LLM:
"Necesito consultar el modelo."

        ↓

Tool Call:
execute_dax(...)

        ↓

Agente ejecuta Tool

        ↓

Resultado:
12.543.221 €

        ↓

LLM:
"Ya tengo suficiente información."

        ↓

Respuesta al usuario
```

Si el resultado de una Tool no es suficiente, el LLM puede solicitar otra Tool y continuar el ciclo.

---


[Índice](../../README.md) · [Siguiente →](01-actores-y-responsabilidades.md)

