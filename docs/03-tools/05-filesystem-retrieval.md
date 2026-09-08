# Filesystem Retrieval

**Filesystem Retrieval** significa recuperar información desde archivos. En nuestro entorno, sirve para consultar documentación del workspace cuando hace falta.

## Nuestra historia

`AGENTS.md` indica dónde están las reglas DAX. Ante la revisión de Sales YTD, Codex puede localizar ese documento y leerlo con las herramientas de archivos disponibles.

```text
Necesidad: conocer la regla YTD del proyecto
  ↓
Localizar el documento
  ↓
Leer el contenido pertinente
  ↓
Usarlo como contexto de la revisión
```

Una ruta clara evita explorar documentos de despliegue o diseño visual que no aportan a la pregunta. Leer un archivo también es una operación mediante una Tool: no ocurre por el mero hecho de que exista en el workspace.

## Archivos sobre herramientas

Podemos documentar una capacidad esperada en `tools/get-measure.md`. Ese documento ayuda a comprenderla, pero **no implementa, registra ni habilita una Tool**.

Antes de invocarla, debe existir una capacidad ejecutable en el entorno y utilizarse su contrato real. Si el catálogo documental y la Tool disponible discrepan, no se debe inventar una llamada.

Recuperar documentación de una herramienta no demuestra que Codex difiera la carga de su definición interna.

## Cómo aplicarlo

- Usa nombres y rutas comprensibles.
- Mantén en `AGENTS.md` referencias a los documentos relevantes.
- Separa reglas consolidadas y notas provisionales.
- Pide las fuentes utilizadas y comprueba su vigencia.
- No crees un buscador propio para resolver lo que una referencia de archivo ya permite explicar.

## Comprueba que lo entiendes

**¿Crear `tools/get-measure.md` permite consultar Power BI inmediatamente?**

No. Es documentación. La consulta requiere una Tool real y una conexión autorizada.

---

[Continuar con lo esencial: MCP y CLI →](07-mcp-vs-cli.md). Tool Search es una ampliación opcional.

[← Anterior](04-tool-retrieval.md) · [Índice](../../README.md) · [Siguiente →](06-tool-search.md)

