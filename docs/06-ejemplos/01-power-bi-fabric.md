# Ejemplo guiado: Power BI y Fabric

Recorrido guiado para diseñar un agente especializado en proyectos PBIP, DAX y modelos semánticos. Es una arquitectura de aprendizaje: la plantilla aporta el contexto y la validación, pero las capacidades reales dependen de la conexión y las Tools disponibles.

## Ejemplo Power BI / Fabric

Supongamos que organizamos un workspace para orientar a Codex en un proyecto `.pbip`. No estamos creando un runtime propio.

Tenemos:

```text
Power BI Agent
│
├── AGENTS.md
│
├── Skills
│   ├── DAX
│   ├── Power Query
│   ├── Semantic Models
│   └── Report Design
│
└── Power BI MCP
    ├── list_tables
    ├── list_measures
    ├── get_measure
    ├── execute_dax
    ├── create_measure
    ├── update_measure
    ├── get_relationships
    └── ...
```

El usuario solicita:

```text
"Analiza la medida Sales YTD. No modifiques nada."
```

El flujo podría ser:

```text
Usuario
   ↓
Agente
   ↓
AGENTS.md
   ↓
detecta tarea DAX
   ↓
consulta o invoca la Skill DAX
   ↓
LLM
   ↓
necesita inspeccionar Sales YTD
   ↓
selecciona una Tool disponible
   ↓
get_measure
   ↓
Tool Call
   ↓
Power BI MCP
   ↓
devuelve medida
   ↓
LLM analiza DAX
   ↓
necesita comprobar modelo
   ↓
selecciona una Tool disponible
   ↓
get_model_schema
   ↓
Tool Call
   ↓
Power BI MCP
   ↓
resultado
   ↓
LLM
   ↓
propone optimización
```

Aquí podemos explicar la consulta progresiva de Skills y documentos. La selección de una Tool disponible es otro paso, pero no demuestra cómo Codex carga internamente sus definiciones:

```text
AGENTS.md
   │
   ├── Skill Retrieval
   │       ↓
   │     DAX Skill
   │
   ├── Documentation Retrieval
   │       ↓
   │     Practical Example-PBIP/docs/dax-rules.md
   │
   └── Consulta mediante Tools disponibles
           ↓
       get_measure
       get_model_schema
```

La intención es consultar sólo lo necesario; el diagrama no describe un mecanismo interno de Tool Retrieval.

La plantilla que acompaña a este repositorio está en [`Practical Example-PBIP`](../../Practical Example-PBIP/README.md). Contiene un `AGENTS.md`, documentación específica, Skills, catálogo de Tools y un script de validación para practicar este flujo sobre un proyecto PBIP real.

## Cómo practicar el recorrido completo — fase posterior

1. Cuando llegue la práctica, copia el contenido de `Practical Example-PBIP` a la raíz de un proyecto PBIP de prueba, revisando antes posibles colisiones. `AGENTS.md`, `docs/`, `skills/` y `scripts/` deben quedar junto al archivo `.pbip`, sin sobrescribir instrucciones o archivos existentes.
2. Lee `AGENTS.md`: indica el objetivo, la estructura, las reglas y el procedimiento de trabajo.
3. Para una tarea DAX, consulta explícitamente `skills/dax/SKILL.md` en esta plantilla; si quieres auto-descubrimiento local de Codex, coloca la Skill bajo `.agents/skills/`.
4. Inspecciona el modelo mediante las Tools disponibles; si proceden de Power BI, Codex las utiliza a través del MCP configurado en VS Code.
5. Empieza por operaciones de lectura, revisa la propuesta y solicita aprobación antes de modificar el modelo.
6. Ejecuta `scripts/validate-project.ps1` y revisa los cambios antes de entregarlos.

En este recorrido, `AGENTS.md` orienta, la Skill define el workflow, la documentación aporta conocimiento, el MCP proporciona Tools y el script comprueba el proyecto. Codex coordina el ciclo, pero la persona revisa y valida el resultado.

---

[← Anterior](00-agent-loop-minimo.md) · [Índice](../../README.md)

