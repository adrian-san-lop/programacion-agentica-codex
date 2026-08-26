# Tool Retrieval

Estrategia para descubrir y cargar únicamente las herramientas relevantes.

# 21. Estrategia B — Tool Retrieval

**Tool Retrieval es una alternativa a cargar todas las Tools completas upfront.**

El objetivo es proporcionar inicialmente suficiente información para descubrir qué capacidades existen, pero sin cargar necesariamente todas sus definiciones completas.

Conceptualmente:

```text
Petición inicial
│
├── System Prompt
├── AGENTS.md
├── índice ligero de capacidades
└── User Prompt
```

Por ejemplo:

```text
Capacidades:

- consultar modelos semánticos
- consultar medidas
- ejecutar DAX
- modificar medidas
- consultar relaciones
- trabajar con tablas
```

El usuario pregunta:

```text
"¿Cuántas ventas tuvimos este año?"
```

El LLM determina:

```text
Necesito ejecutar una consulta DAX.
```

Entonces:

```text
Necesidad
   ↓
Tool Retrieval
   ↓
encuentra execute_dax
   ↓
recupera definición completa
   ↓
nombre
+
descripción
+
JSON Schema
```

Ahora el LLM conoce suficiente información para solicitar:

```text
execute_dax(...)
```

Esto permite pasar parte del contexto de:

```text
Static Context
```

a:

```text
Dynamic Context
```

---

---

# 22. Upfront vs Retrieval

Las dos estrategias son alternativas:

```text
              ¿Cómo conoce el LLM las Tools?
                         │
              ┌──────────┴──────────┐
              │                     │
              ▼                     ▼
       ESTRATEGIA A           ESTRATEGIA B

          Upfront               Retrieval

     todas completas        descubrir primero
      desde inicio          y cargar después

              │                     │
              └──────────┬──────────┘
                         │
                         ▼
                LLM conoce la Tool
                         │
                         ▼
                     Tool Call
                         │
                         ▼
                    Agent Loop
```

Por tanto:

```text
A → Tool Call
```

o:

```text
B → Tool Call
```

NO:

```text
A → B → Tool Call
```

---

