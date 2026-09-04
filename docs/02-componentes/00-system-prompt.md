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

En Codex dentro de VS Code conviene separar dos ideas:

- el system prompt interno del producto, que no controlamos ni podemos inspeccionar por completo;
- las instrucciones del proyecto, como `AGENTS.md`, que sí podemos mantener dentro del workspace.

`AGENTS.md` puede influir en el trabajo de Codex, pero no es sinónimo del system prompt. Esta distinción se mantendrá en todo el curso.

IMPORTANTE:

Las definiciones de las Tools **no tienen por qué estar literalmente dentro del System Prompt**.

Dependiendo del runtime/API, las Tools pueden proporcionarse al modelo mediante un campo estructurado específico.

---

[← Anterior](../01-context-engineering/06-prompt-caching.md) · [Índice](../../README.md) · [Siguiente →](01-agents-md.md)

