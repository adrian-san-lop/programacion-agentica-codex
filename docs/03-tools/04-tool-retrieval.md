# Tool Retrieval

Estrategia para descubrir y cargar únicamente las herramientas relevantes.

## Estrategia B — Tool Retrieval

**Tool Retrieval es una alternativa a cargar todas las Tools completas upfront.**

Es una estrategia de presentación de Tools al modelo, no un protocolo de conexión. Puede aplicarse a Tools locales, APIs o Tools expuestas por un servidor MCP.

## Tres enfoques para presentar Tools

La evolución habitual puede resumirse así:

| Enfoque | Qué recibe inicialmente el modelo | Coste principal |
|---|---|---|
| Tradicional / upfront | Todas las definiciones completas y sus schemas | Mucho contexto estático y más ruido |
| Filesystem Retrieval | Catálogo o nombres recuperables desde archivos | Requiere búsqueda y lectura durante la sesión |
| Tool Search | Catálogo consultable por el runtime o proveedor | Añade una fase de búsqueda y depende del runtime |

El objetivo común es evitar que todas las definiciones compitan por la atención del modelo en cada tarea.

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


---

## Comparación de enfoques

Upfront, Filesystem Retrieval y Tool Search son estrategias diferentes para resolver el mismo problema. Pueden coexistir en una arquitectura híbrida.

```text
              ¿Cómo conoce el LLM las Tools?
                         │
              ┌──────────┼──────────┐
              │          │          │
              ▼          ▼          ▼
           Upfront   Filesystem   Tool Search
              │       Retrieval       │
              │          │            │
              └──────────┼────────────┘
                         ▼
                LLM conoce la Tool
                         │
                         ▼
                     Tool Call
                         │
                         ▼
                    Agent Loop
```

Después de cualquiera de ellas, el flujo es el mismo: el modelo recibe la definición necesaria, genera un Tool Call y el runtime lo valida y ejecuta.

---

Retrieval puede reducir el contexto inicial, pero añade búsquedas y lecturas. Estos trade-offs forman parte del consumo de una interacción; consulta [Costes básicos de LLM](../01-context-engineering/05-costes-basicos-de-llm.md).

[← Anterior](03-tool-definitions-upfront.md) · [Índice](../../README.md) · [Siguiente →](05-filesystem-retrieval.md)

