# Skills

Conocimiento e instrucciones especializadas que se cargan según el tipo de tarea.

## Definición

Las **Skills** encapsulan conocimiento, instrucciones y workflows especializados.

Ejemplo:

```text
.agents/skills/
│
├── dax/
│   └── SKILL.md
│
├── power-query/
│   └── SKILL.md
│
├── semantic-model/
│   └── SKILL.md
│
└── report-design/
    └── SKILL.md
```

En Codex, las Skills locales auto-descubiertas se organizan en carpetas `.agents/skills/` dentro de los ámbitos soportados. Este repositorio también contiene carpetas `skills/` para versionar workflows y documentación operativa; esa carpeta no debe presentarse automáticamente como la ubicación estándar de auto-descubrimiento de Codex.

Una Skill puede indicar:

- Cuándo utilizarse.
- Qué procedimiento seguir.
- Qué reglas aplicar.
- Qué Tools utilizar.
- Qué validaciones realizar.
- Qué documentación consultar.
- Cómo presentar el resultado.

Por ejemplo:

```text
Usuario:

"Optimiza esta medida DAX"

        ↓

Agente:

"Esto es una tarea DAX"

        ↓

Carga o invoca:

.agents/skills/dax/SKILL.md
```

Las Skills son una forma de **empaquetar conocimiento y workflows reutilizables**.

Para una persona que empieza, la diferencia esencial es:

```text
Skill → qué procedimiento seguir y qué comprobar
Tool  → qué operación puede ejecutarse
```

Una Skill puede recomendar `get_measure` antes de `update_measure`, pero no se convierte por ello en la Tool ni obtiene permisos adicionales.

---

## Skills y Progressive Disclosure

No necesariamente queremos cargar todas las Skills completas desde el principio.

Podemos tener:

```text
Catálogo o lista de Skills disponibles (si el runtime la ofrece)
        ↓
LLM / Agente
        ↓
¿qué Skill necesito?
        │
        ├── DAX
        ├── Power Query
        ├── Semantic Model
        └── Report Design
```

Si la tarea es DAX:

```text
Carga o invoca:
.agents/skills/dax/SKILL.md
```

pero no:

```text
.agents/skills/power-query/SKILL.md
.agents/skills/report-design/SKILL.md
...
```

Esto puede ser un ejemplo de **Progressive Disclosure**, pero no debemos asumir que Codex expone exactamente este catálogo ni que usa una fase interna concreta de metadata antes de leer cada `SKILL.md`. La ubicación y el formato documentados no revelan por sí solos el mecanismo interno de selección.

---


Si el proyecto mantiene workflows en `skills/`, Codex puede utilizarlos cuando se le indiquen explícitamente o cuando exista una integración que los exponga. Para que una Skill local sea auto-descubierta por Codex, utiliza la estructura `.agents/skills/` documentada por OpenAI. Si la distribución es importante, considera empaquetarla como plugin. Consulta [Skills compartidas](../05-trabajo-en-equipo/03-skills-compartidas.md) y la [documentación oficial para crear Skills](https://learn.chatgpt.com/es-419/docs/build-skills).

[← Anterior](01-agents-md.md) · [Índice](../../README.md) · [Siguiente →](03-commands.md)

