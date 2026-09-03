# Tool Search

**Tool Search** es una estrategia en la que el runtime ofrece al modelo una capacidad de búsqueda sobre un catálogo de Tools y carga las definiciones completas sólo cuando son necesarias.

```text
Contexto inicial
├── prompt e instrucciones
├── catálogo ligero de Tools
└── Tool Search
        ↓
   definición completa
        ↓
     Tool Call
```

El catálogo puede estar en un servicio especializado o en la infraestructura del proveedor del modelo. La búsqueda devuelve las Tools relevantes y sus schemas; el agente las incorpora al contexto antes de invocarlas.

## Tool Search frente a Filesystem Retrieval

Ambas estrategias retrasan la carga de definiciones, pero la búsqueda ocurre en lugares diferentes:

| Estrategia | Índice | Quién recupera | Ventaja principal |
|---|---|---|---|
| Filesystem Retrieval | Archivos locales | Agente mediante Tools de filesystem | Transparencia, control y facilidad para versionar |
| Tool Search | Catálogo o servicio de Tools | Runtime o proveedor | Escala mejor cuando hay cientos o miles de Tools |

El resultado conceptual es similar: el modelo recibe una selección pequeña y relevante en lugar de todos los schemas.

## ¿Está disponible en Codex?

No debe asumirse que una implementación de Tool Search de otro proveedor exista con la misma interfaz en Codex. Su disponibilidad depende del runtime, la versión del cliente y cómo estén integradas las Tools.

Por eso la documentación de un proyecto debe distinguir:

- **Patrón general**: búsqueda diferida de definiciones.
- **Implementación concreta**: mecanismo que ofrece el runtime utilizado.
- **Fallback portable**: Filesystem Retrieval mediante archivos, índices y Tools de búsqueda.

En Codex se puede documentar Tool Search como una posibilidad del runtime, pero no debe presentarse como una Tool o comando disponible sin comprobarlo en la instalación concreta.

Para la diferencia entre el `tool_search` configurable de la API y el comportamiento no completamente expuesto de Codex mediante suscripción, consulta [Contexto y Tool Retrieval en Codex mediante suscripción](10-codex-suscripcion-contexto-y-tool-retrieval.md).

## Coste y trade-offs

Tool Search reduce el contexto inicial, pero añade una fase de descubrimiento. Hay que valorar:

- Coste y latencia de la búsqueda.
- Calidad del catálogo y sus descripciones.
- Riesgo de recuperar Tools parecidas pero incorrectas.
- Caché de definiciones ya recuperadas.
- Tratamiento de errores cuando no se encuentra ninguna Tool.

No existe un porcentaje universal de ahorro. Las cifras publicadas por Cursor o Anthropic corresponden a sus propios runtimes, catálogos y mediciones, y no deben extrapolarse directamente a Codex.

## Referencias comparativas

- [Dynamic context discovery · Cursor](https://cursor.com/blog/dynamic-context-discovery): describe un mecanismo propio de recuperación de descripciones MCP mediante archivos y publica una medición del 46,9 % en su entorno.
- [Scale to many tools with tool search · Claude Code](https://code.claude.com/docs/en/agent-sdk/tool-search): documenta la búsqueda diferida de Tools en el runtime de Claude y sus trade-offs de contexto, latencia y selección.

Estas referencias sirven para comparar patrones. No describen el comportamiento interno de Codex.

---

[← Anterior](05-filesystem-retrieval.md) · [Índice](../../README.md) · [Siguiente →](07-mcp-vs-cli.md)
