# Contexto y Tool Retrieval en Codex mediante suscripción

Trabajamos en la extensión de Codex para VS Code, autenticada mediante nuestra suscripción de ChatGPT Business. Entender el Agent Loop no exige reconstruir el mensaje interno del producto.

## Qué controlamos

| Persona | Codex y el entorno |
|---|---|
| Objetivo, límites y criterios de aceptación | Coordinación del Agent Loop |
| Instrucciones en `AGENTS.md` | Incorporación de instrucciones según ámbito |
| Procedimientos mediante Skills | Descubrimiento y uso de Skills |
| Archivos y fuentes que señalamos | Lecturas y preparación del contexto |
| Integraciones y preferencias permitidas | Capacidades efectivas y políticas de ejecución |
| Revisión y autorización de cambios | Ejecución o rechazo conforme a los controles |

Puedes elegir las opciones que exponga tu cliente, dentro de las políticas de tu organización. Esto no equivale a controlar el orden exacto de todo el contexto, el system prompt interno ni la implementación de caching o recuperación.

## Instrucciones y contexto del IDE

`AGENTS.md` aporta instrucciones persistentes del proyecto; no es el system prompt interno. Codex combina instrucciones según el ámbito documentado. [Referencia oficial de AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md).

También puedes aportar archivos y selecciones desde el editor. No deduzcas por ello que se ha leído o indexado todo el repositorio. [Extensión IDE](https://learn.chatgpt.com/docs/codex/ide).

## Skills: progressive disclosure documentado

OpenAI documenta que Codex parte de nombre y descripción de las Skills, con su ruta en el catálogo inicial, y lee el `SKILL.md` completo cuando decide utilizar una. Puede seleccionarse explícitamente o por correspondencia con la tarea. [Skills en Codex](https://learn.chatgpt.com/docs/build-skills).

Esto sí permite explicar una carga progresiva concreta. No permite afirmar qué Skill elegirá siempre para cada frase ni equipararla al mecanismo de descubrimiento de Tools.

## MCP: conexión, no estrategia de búsqueda

Un servidor MCP expone capacidades externas. Configurarlo permite a Codex conectarse; el acceso efectivo depende de permisos y autenticación. Las instrucciones del servidor orientan el uso de sus herramientas, sin sustituir las reglas del proyecto. [MCP en Codex](https://learn.chatgpt.com/docs/extend/mcp).

Que una consulta MCP funcione no demuestra si el modelo recibió todas las definiciones al inicio o si recuperó una selección después.

## Tool Retrieval: qué podemos afirmar

Como patrón general, consiste en recuperar definiciones pertinentes en lugar de cargar todas desde el principio.

Para atribuir un mecanismo concreto a Codex necesitamos documentación específica o una observación acotada a la sesión. No trasladamos mecanismos de otros productos ni inventamos controles del workspace.

En nuestra historia, lo necesario es comprobar que hay una capacidad autorizada para leer Sales YTD. No necesitamos demostrar la arquitectura interna de su descubrimiento.

## Observación frente a inferencia

| Evidencia visible | Conclusión prudente |
|---|---|
| Lectura de un archivo | Su contenido se ha consultado, dentro del alcance visible |
| Llamada MCP con resultado | Esa capacidad se ha utilizado |
| Skill aplicada | Se ha utilizado su procedimiento; puede revisarse si se siguió |
| Herramienta de búsqueda en una traza | Esa búsqueda ocurrió; no describe por sí sola todas las Tools |
| Contexto libre después de varias preguntas | Ese es el indicador observado, no una prueba de ahorro atribuible a la documentación |

Pedir al agente que describa su funcionamiento no sustituye a la evidencia. Su explicación también debe contrastarse.

## Continuidad de la tarea

El historial ayuda durante la conversación. Las decisiones importantes deben conservarse en archivos cuando se autorice su escritura. No dependemos de una memoria automática entre sesiones.

La [compactación](../01-context-engineering/08-compactacion-de-contexto-en-codex.md) permite reducir contexto activo y continuar; no borra archivos ni garantiza conservar cada detalle.

## Comprueba que lo entiendes

**¿El procedimiento de una Skill puede obligar a habilitar una Tool inexistente?**

No. Aporta instrucciones, no capacidades ni permisos.

**¿Podemos enseñar progressive disclosure sin conocer el prompt interno completo?**

Sí. Podemos explicar y revisar la consulta selectiva de documentos y la carga documentada de Skills, distinguiéndolas de lo que no observamos.

---

[← Anterior](09-guia-practica-tools-en-codex.md) · [Índice](../../README.md) · [Siguiente →](../04-integraciones/00-mcp-introduccion.md)
