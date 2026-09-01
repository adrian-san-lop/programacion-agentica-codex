# System Prompt

Instrucciones de alto nivel que definen el comportamiento general del agente.

## Definición

El **System Prompt** contiene instrucciones de alto nivel que definen cómo debe comportarse el agente.

Puede definir:

- Rol.
- Restricciones.
- Comportamiento general.
- Prioridades.
- Reglas de seguridad.
- Forma general de trabajar.

Ejemplo conceptual:

```text
You are a senior Power BI developer.

Prefer inspecting the existing semantic model before making changes.

Never perform destructive operations without explicit approval.
```

El System Prompt ayuda a **moldear el comportamiento del agente**.

IMPORTANTE:

Las definiciones de las Tools **no tienen por qué estar literalmente dentro del System Prompt**.

Dependiendo del runtime/API, las Tools pueden proporcionarse al modelo mediante un campo estructurado específico.

---



---

[← Anterior](../01-context-engineering/04-progressive-disclosure.md) · [Índice](../../README.md) · [Siguiente →](01-agents-md.md)

