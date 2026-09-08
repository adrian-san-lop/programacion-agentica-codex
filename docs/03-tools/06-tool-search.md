# Tool Search

**Ampliación opcional.** Estudiamos la idea, no una configuración obligatoria de Codex.

## Patrón general

Tool Search es buscar capacidades en un catálogo para recuperar las definiciones pertinentes antes de utilizarlas.

```text
Necesito consultar una medida
  ↓
Buscar una capacidad adecuada
  ↓
Conocer su contrato
  ↓
Proponer una llamada
  ↓
Runtime comprueba y coordina la ejecución
```

Descubrir una herramienta no concede autorización para ejecutarla.

## Diferencia frente a buscar archivos

Buscar una regla DAX recupera conocimiento del proyecto. Buscar una Tool recupera información sobre una capacidad ejecutable. Ambas búsquedas pueden aportar contexto, pero no encuentran el mismo tipo de información.

## En Codex

No debes añadir un nombre como `tool_search` a `AGENTS.md` esperando crear una herramienta. Comprueba qué capacidades están expuestas en tu sesión y qué documenta el cliente.

Si una traza muestra una herramienta de búsqueda, puedes describir esa observación concreta. No basta para afirmar cómo se seleccionan todas las Tools de Codex.

Para el curso es suficiente separar [lo que controlamos y lo que observamos](10-codex-suscripcion-contexto-y-tool-retrieval.md). No necesitamos activar una estrategia interna de búsqueda para utilizar una integración compatible.

## Comprueba que lo entiendes

**¿Que Codex utilice una Tool MCP demuestra que la encontró mediante Tool Search?**

No. Demuestra que pudo utilizarla; el mecanismo de descubrimiento requiere evidencia adicional.

---

[← Anterior](05-filesystem-retrieval.md) · [Índice](../../README.md) · [Siguiente →](07-mcp-vs-cli.md)
