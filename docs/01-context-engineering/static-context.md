# Static Context

Información disponible de forma permanente o desde el inicio de una interacción.

## Definición

El **Static Context** es la información que se proporciona de forma habitual o desde el inicio de la interacción.

Puede incluir:

- System Prompt.
- Instrucciones generales.
- `AGENTS.md`.
- Memoria persistente cargada siempre.
- Definiciones de Tools si se cargan upfront.
- Metadata de Skills.
- Otra información permanente necesaria para el agente.

Ejemplo:

```text
Petición al LLM
│
├── System Prompt
├── AGENTS.md
├── Tool definitions
├── Skill metadata
├── Memory
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



---

[← Anterior](context-window.md) · [Índice](../../README.md) · [Siguiente →](dynamic-context.md)

