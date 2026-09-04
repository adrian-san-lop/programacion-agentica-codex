# Static Context

Información disponible de forma permanente o desde el inicio de una interacción.

## Definición

El **Static Context** es la información que se proporciona de forma habitual o desde el inicio de la interacción.

Puede incluir:

- System Prompt.
- Instrucciones generales.
- `AGENTS.md`.
- Memoria o estado que el runtime decida incorporar.
- Definiciones de Tools si se cargan upfront.
- Información resumida de Skills, si el runtime la expone.
- Otra información permanente necesaria para el agente.

Ejemplo:

```text
Petición al LLM
│
├── System Prompt
├── AGENTS.md
├── Tool definitions
├── Skill information (if exposed)
├── Memory or state (if loaded)
└── User Prompt
```

Cuanto mayor sea el Static Context:

```text
más tokens
+
más información
+
potencialmente más ruido
```

Por eso interesa mantenerlo pequeño y relevante.

IMPORTANTE: este esquema es conceptual. No implica que Codex incorpore siempre cada elemento ni permite deducir el contenido de su system prompt interno. El contexto del IDE —por ejemplo, archivos abiertos o selecciones que la persona añade— también puede incorporarse de forma explícita y no equivale a indexar automáticamente todo el repositorio.

IMPORTANTE:

```text
Configuración MCP
≠
necesariamente contexto del LLM
```

Por ejemplo, un:

```text
config.toml
```

puede indicarle a Codex:

```text
"Conéctate al MCP de Power BI"
```

pero eso no significa que el contenido completo de `config.toml` se envíe al LLM.

---

[← Anterior](01-context-window.md) · [Índice](../../README.md) · [Siguiente →](03-dynamic-context.md)

