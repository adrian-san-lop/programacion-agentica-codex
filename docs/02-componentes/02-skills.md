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
Información inicial de las Skills disponibles
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

En Codex este patrón está documentado: inicialmente se presentan nombre y descripción de las Skills, junto con su ruta, y se lee el `SKILL.md` completo al utilizarlas. La selección puede ser explícita o depender de la tarea. Esto no garantiza que siempre se elija la misma Skill ni describe la recuperación de Tools. [Fuente oficial](https://learn.chatgpt.com/docs/build-skills).

---


Si el proyecto mantiene workflows en `skills/`, Codex puede utilizarlos cuando se le indiquen explícitamente o cuando exista una integración que los exponga. Para que una Skill local sea auto-descubierta por Codex, utiliza la estructura `.agents/skills/` documentada por OpenAI. Si la distribución es importante, considera empaquetarla como plugin. Consulta [Skills compartidas](../05-trabajo-en-equipo/03-skills-compartidas.md) y la [documentación oficial para crear Skills](https://learn.chatgpt.com/es-419/docs/build-skills).

## Nuestra historia y comprobación

Para revisar Sales YTD, el procedimiento DAX puede pedir comprobar expresión, relaciones y calendario, y separar hechos de hipótesis. La regla concreta sobre el calendario pertenece a la documentación del proyecto.

**¿Puedo guardar todas las reglas de negocio dentro de cada Skill?**

Podrías duplicarlas, pero dificultarías su mantenimiento. Es preferible que la Skill indique cuándo consultar la fuente de reglas.

[← Anterior](01-agents-md.md) · [Índice](../../README.md) · [Siguiente →](03-commands.md)

