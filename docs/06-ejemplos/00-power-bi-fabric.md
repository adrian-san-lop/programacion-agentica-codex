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
carga Skill DAX
   ↓
LLM
   ↓
necesita inspeccionar Sales YTD
   ↓
Tool Retrieval
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
Tool Retrieval
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

---



---

[← Anterior](../05-trabajo-en-equipo/05-flujo-git-y-pull-requests.md) · [Índice](../../README.md)

