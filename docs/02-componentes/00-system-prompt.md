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

- las instrucciones internas del producto, que no intentamos reconstruir ni sustituir en este curso;
- las instrucciones del proyecto, como `AGENTS.md`, que sí podemos mantener dentro del workspace.

`AGENTS.md` puede influir en el trabajo de Codex, pero no es sinónimo del system prompt. Esta distinción se mantendrá en todo el curso.

IMPORTANTE:

Las definiciones de las Tools **no tienen por qué estar literalmente dentro del System Prompt**.

Que el modelo conozca una Tool no permite deducir dónde aparece su definición en el contexto interno. Para trabajar con Codex no necesitamos reconstruir ese mensaje.

---

## Nuestra historia y comprobación

«No modifiques nada» acota la revisión de Sales YTD. Las reglas permanentes del proyecto pueden reforzar cómo revisar y qué fuentes utilizar.

**¿Tengo que sustituir el system prompt interno para establecer esa restricción?**

No. Puedes expresar el alcance de la tarea y mantener instrucciones de proyecto. Las instrucciones no sustituyen a los controles de permisos.

[← Anterior](../01-context-engineering/08-compactacion-de-contexto-en-codex.md) · [Índice](../../README.md) · [Siguiente →](01-agents-md.md)

