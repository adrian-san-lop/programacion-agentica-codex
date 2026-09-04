# Ejemplo: Power BI y Fabric

Ejemplo completo de un agente especializado en proyectos pbip, DAX y modelos semánticos.

## Ejemplo Power BI / Fabric

Supongamos que estamos creando un agente propio para trabajar con proyectos `.pbip`.

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
"Optimiza la medida Sales YTD."
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

Aquí tenemos **Progressive Disclosure en varios niveles**:

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
   └── Tool Retrieval
           ↓
       get_measure
       get_model_schema
```

No cargamos todo desde el principio.

La plantilla que acompaña a este repositorio está en [`Practical Example-PBIP`](../../Practical Example-PBIP/README.md). Contiene un `AGENTS.md`, documentación específica, Skills, catálogo de Tools y un script de validación para practicar este flujo sobre un proyecto PBIP real.

## Cómo practicar el recorrido completo

1. Copia `Practical Example-PBIP` en la carpeta raíz de un proyecto PBIP y ábrela en VS Code.
2. Lee `AGENTS.md`: indica el objetivo, la estructura, las reglas y el procedimiento de trabajo.
3. Para una tarea DAX, consulta explícitamente `skills/dax/SKILL.md` en esta plantilla; si quieres auto-descubrimiento local de Codex, coloca la Skill bajo `.agents/skills/`.
4. Inspecciona el modelo mediante las Tools disponibles; si proceden de Power BI, Codex las utiliza a través del MCP configurado en VS Code.
5. Empieza por operaciones de lectura, revisa la propuesta y solicita aprobación antes de modificar el modelo.
6. Ejecuta `scripts/validate-project.ps1` y revisa los cambios antes de entregarlos.

En este recorrido, `AGENTS.md` orienta, la Skill define el workflow, la documentación aporta conocimiento, el MCP proporciona Tools y el script comprueba el proyecto. Codex coordina el ciclo, pero la persona revisa y valida el resultado.

---

[← Anterior](00-agent-loop-minimo.md) · [Índice](../../README.md)

