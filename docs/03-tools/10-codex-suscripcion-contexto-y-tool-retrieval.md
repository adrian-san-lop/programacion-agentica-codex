# Contexto y Tool Retrieval en Codex mediante suscripción

Este documento analiza Codex como producto utilizado mediante una suscripción, por ejemplo desde la extensión IDE o la aplicación de escritorio. No describe cómo construir una aplicación con la API de OpenAI.

La distinción es importante: en una aplicación API el desarrollador construye la petición y puede declarar `tools`, `tool_search` y `defer_loading`. En Codex mediante suscripción, el producto controla internamente el runtime que prepara el contexto y ejecuta las capacidades.

## Qué controlamos y qué controla Codex

El modelo mental correcto es:

```text
Usuario
  ↓
Codex mediante suscripción
  ├── instrucciones internas
  ├── contexto de la tarea
  ├── Tools y servidores conectados
  ├── permisos y aprobaciones
  ├── Agent Loop
  └── ejecución en el entorno
       ↓
      modelo
```

Nosotros podemos aportar o configurar:

- instrucciones del proyecto mediante `AGENTS.md`;
- Skills y sus procedimientos;
- servidores MCP y su configuración;
- permisos y preferencias disponibles en el cliente;
- archivos, selección y contexto del workspace;
- la petición y las restricciones de la tarea.

Codex mantiene bajo control del producto:

- el system prompt interno completo;
- el orden exacto de todos los mensajes que recibe el modelo;
- la implementación concreta del Agent Loop;
- la selección interna de modelos y Tools en cada ejecución;
- los mecanismos internos de caching, compaction y retrieval.

Por tanto, una configuración del workspace puede influir en el comportamiento, pero no equivale a controlar toda la petición que Codex envía al modelo.

## ¿Existe un system prompt configurable?

Codex utiliza instrucciones internas del producto, pero el usuario no dispone de una interfaz para sustituirlas o inspeccionarlas completamente.

`AGENTS.md` es una superficie documentada para aportar instrucciones y contexto del proyecto. Codex descubre estos archivos, los combina siguiendo el ámbito y la precedencia establecidos y los incorpora a la cadena de instrucciones. La documentación oficial indica que esta carga se realiza al iniciar una ejecución y que existe un límite de tamaño configurable.

```text
System prompt interno de Codex
        +
AGENTS.md global y del proyecto
        +
Skills, configuración y contexto de la tarea
        +
Petición del usuario
```

La representación anterior es conceptual. No conocemos el formato exacto ni el orden completo de todos los elementos internos.

La consecuencia práctica es:

```text
AGENTS.md → instrucciones persistentes que podemos mantener
System prompt → instrucciones internas del producto que no controlamos
```

No debemos escribir en la documentación que `AGENTS.md` “es el system prompt”. Es más preciso decir que Codex lo incorpora como instrucciones de proyecto dentro de su contexto de ejecución.

## Qué sabemos sobre `AGENTS.md`

La documentación oficial de Codex confirma que:

- Codex lee `AGENTS.md` antes de trabajar.
- Puede existir orientación global y orientación específica del proyecto.
- Los archivos más cercanos al directorio de trabajo aparecen después y pueden prevalecer sobre instrucciones anteriores.
- Se puede utilizar `AGENTS.override.md` para sustituir el archivo equivalente en un ámbito.
- Codex deja de buscar al llegar al directorio de trabajo actual.
- La cadena tiene un límite de tamaño, 32 KiB por defecto según la documentación consultada.

Esto sí nos permite documentar un mecanismo concreto de contexto estático en Codex. No nos permite inferir cómo se cargan todas las Tools ni cómo se construye el system prompt interno.

## Qué sabemos sobre Skills

Las Skills son una forma de aportar procedimientos especializados a Codex. Por ejemplo, una Skill puede indicar cómo revisar una medida DAX, qué documentación consultar y qué validaciones realizar.

En el plano del curso podemos afirmar:

```text
Skill → instrucciones y workflow reutilizable
Tool  → capacidad ejecutable
```

Codex puede descubrir Skills disponibles y utilizar su contenido cuando la tarea es relevante. Sin embargo, no debemos presentar como hecho el mecanismo interno exacto —por ejemplo, qué metadata entra inicialmente, cuándo se lee el archivo completo o cómo se calcula la relevancia— salvo que el producto lo documente explícitamente o lo comprobemos en una versión concreta.

## Qué sabemos sobre MCP

MCP conecta Codex con Tools y contexto externos. Un servidor MCP puede proporcionar Tools y también instrucciones generales del servidor.

```text
Codex
  ↓
cliente MCP
  ↓
servidor MCP
  ├── instrucciones del servidor
  └── Tools
```

La documentación oficial indica que la aplicación de escritorio de ChatGPT, Codex CLI y la extensión IDE pueden compartir la configuración MCP del mismo host. También documenta servidores STDIO, servidores Streamable HTTP y el uso del campo `instructions` del servidor.

Esto responde a la pregunta “¿cómo conecta Codex capacidades externas?”, pero no necesariamente a la pregunta “¿cómo decide qué definiciones de Tools ve el modelo en cada turno?”.

## Tool Retrieval: patrón frente a implementación

`Tool Retrieval` puede significar dos cosas distintas:

### Patrón general

Evitar cargar todas las definiciones completas desde el principio y recuperar sólo las relevantes.

```text
Catálogo ligero
    ↓
necesidad detectada
    ↓
definición de la Tool
    ↓
Tool Call
```

Este patrón es útil para razonar sobre context engineering y context rot.

### Tool Search configurable en la API

La documentación de la API expone un mecanismo llamado `tool_search`. La aplicación debe declararlo y marcar Tools o servidores MCP para diferir su carga mediante `defer_loading`.

```text
Aplicación API
  ├── tools
  ├── tool_search
  └── defer_loading
```

Eso es una capacidad de la API. No demuestra por sí solo que Codex mediante suscripción utilice el mismo mecanismo ni que el usuario pueda configurarlo desde el workspace.

### Mecanismo interno de Codex

En Codex mediante suscripción, la documentación pública consultada no especifica de forma completa:

- si todas las definiciones MCP se envían upfront;
- si se utiliza un catálogo ligero interno;
- si existe un `tool_search` interno equivalente;
- si se utiliza Filesystem Retrieval para Tools;
- cuándo se incorporan Skills completas al contexto;
- qué parte del proceso ocurre en el runtime y qué parte en el proveedor.

La formulación correcta es:

> Codex dispone de Tools, Skills y MCP, pero no debemos atribuirle automáticamente el mecanismo de Tool Search de la API ni el Filesystem Retrieval de Cursor. Esos mecanismos deben tratarse como implementaciones distintas hasta disponer de verificación específica.

## Qué podemos observar

Aunque el contexto interno completo no sea visible, podemos reunir evidencias sobre el comportamiento del runtime:

| Observación | Qué permite afirmar | Qué no permite afirmar |
|---|---|---|
| Una Tool aparece en el cliente | Está disponible para esa sesión o entorno | Que todas las Tools se hayan cargado en el modelo |
| Codex utiliza una Tool MCP | El runtime pudo descubrirla y ejecutarla | Que use Tool Search para descubrirla |
| Codex lee un `AGENTS.md` | Ese archivo forma parte de las instrucciones aplicadas | Que sea el system prompt completo |
| Una Skill se aplica a una tarea | El runtime pudo utilizarla | El momento exacto en que se cargó |
| Reiniciar hace visible una configuración | La inicialización volvió a detectar el recurso | El mecanismo interno exacto de inicialización |

Esta separación entre observación e inferencia es esencial para no documentar como hechos detalles internos que no podemos verificar.

## Cómo investigar sin confundir productos

Para una versión concreta de Codex, registrar:

1. Cliente utilizado: escritorio, IDE o CLI.
2. Versión del cliente y fecha de comprobación.
3. Modelo seleccionado, si el cliente lo muestra.
4. Tools y servidores MCP visibles antes de iniciar la tarea.
5. Qué ocurre al añadir o modificar un `AGENTS.md`, Skill o servidor.
6. Si el recurso aparece después de reiniciar el cliente o la extensión.
7. Qué Tool utiliza Codex ante una tarea que requiere varias capacidades.
8. Qué parte es visible en la interfaz y qué parte es una inferencia.

No debe intentarse deducir el contenido del system prompt interno a partir de una única respuesta del modelo. Una respuesta demuestra comportamiento observado, no la arquitectura completa que lo produjo.

## Resumen

```text
Codex mediante suscripción
    → runtime gestionado por Codex
    → Tools y MCP disponibles según configuración
    → AGENTS.md como instrucciones de proyecto
    → Skills como workflows especializados
    → system prompt interno no editable ni completamente visible
    → Tool Retrieval interno no documentado con el detalle de la API
```

Para este curso, la conclusión teórica es suficiente: podemos estudiar el Agent Loop y el Context Engineering usando Codex como runtime real, pero debemos separar siempre lo que configura el usuario, lo que documenta OpenAI y lo que sólo podemos observar experimentalmente.

## Fuentes oficiales consultadas

- [Custom instructions with AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
- [Model Context Protocol en Codex](https://learn.chatgpt.com/docs/extend/mcp)
- [Tool search en la API de OpenAI](https://developers.openai.com/api/docs/guides/tools-tool-search)

[← Anterior](09-guia-practica-tools-en-codex.md) · [Índice](../../README.md) · [Siguiente →](../04-integraciones/00-mcp-introduccion.md)
