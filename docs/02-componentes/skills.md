# Skills

Conocimiento e instrucciones especializadas que se cargan según el tipo de tarea.

## Definición

Las **Skills** encapsulan conocimiento, instrucciones y workflows especializados.

Ejemplo:

```text
skills/
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

Carga:

skills/dax/SKILL.md
```

Las Skills son una forma de **empaquetar conocimiento y workflows reutilizables**.

---

---

## Skills y Progressive Disclosure

No necesariamente queremos cargar todas las Skills completas desde el principio.

Podemos tener:

```text
Metadata de Skills
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
Carga:
skills/dax/SKILL.md
```

pero no:

```text
skills/power-query/SKILL.md
skills/report-design/SKILL.md
...
```

Esto es nuevamente **Progressive Disclosure**.

---

