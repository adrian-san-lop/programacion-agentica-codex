# Tool Retrieval

**Patrón general.** Recuperar las definiciones pertinentes de herramientas permite presentar capacidades bajo demanda. No describe una estrategia universal de Codex ni un selector que debamos configurar para seguir el curso.

## Qué se recupera

Una definición de Tool describe su nombre, argumentos y restricciones. El runtime debe disponer de una capacidad ejecutable y proporcionar un contrato suficiente para que el modelo pueda solicitarla.

Hay tres comprobaciones distintas:

| Comprobación | Qué demuestra | Qué no demuestra |
|---|---|---|
| Leer documentación de una capacidad | Conocemos lo que el documento describe | Que exista una Tool con ese contrato en la sesión |
| Disponer de una Tool y su contrato real | La capacidad está expuesta y sabemos cómo solicitarla | Que esté autorizada para esta tarea |
| Comprobar permisos y alcance | La operación está permitida dentro del encargo | Que su resultado vaya a ser correcto |

Crear o leer `tools/get-measure.md` no registra una Tool. Si la documentación discrepa del contrato disponible, hay que aclarar la diferencia; no inventar una llamada.

## Dos patrones de presentación

**Upfront** significa «desde el inicio». Esta comparación explica posibilidades de diseño, no una evolución obligatoria:

| Patrón | Qué recibe el modelo | Contrapartida |
|---|---|---|
| Definiciones upfront | Las definiciones completas previstas por el runtime desde el inicio | Ocupan contexto aunque algunas no ayuden a la tarea |
| Recuperación bajo demanda | Información para descubrir capacidades y después los contratos pertinentes | Añade una fase de búsqueda o carga |

Ambos pueden coexistir. **Tool Search** es una forma de buscar capacidades en un catálogo; **Filesystem Retrieval** recupera información desde archivos. Leer archivos sobre herramientas puede ayudar a entenderlas, pero no demuestra que su definición ejecutable se haya cargado bajo demanda.

## Nuestra historia

Para revisar Sales YTD, un recorrido ilustrativo podría ser:

```text
Necesidad: consultar la expresión actual
  → descubrir una capacidad de consulta
  → obtener su contrato real, si está disponible
  → proponer una llamada con los argumentos adecuados
  → runtime y sistema conectado aplican sus controles
  → herramienta devuelve un resultado o error
  → modelo decide cómo continuar
```

Si falta la capacidad, el agente debe declarar el límite o utilizar otra fuente autorizada. Un nombre encontrado en un documento no basta.

## Qué podemos afirmar sobre Codex

La documentación de MCP explica cómo configurar servidores y sus capacidades. Que una Tool MCP funcione no prueba si Codex presentó su definición desde el inicio o la recuperó después. [MCP en Codex](https://learn.chatgpt.com/docs/extend/mcp), revisado el 2026-09-08.

Para el curso basta con comprobar la capacidad disponible, su contrato y el alcance autorizado. La [frontera entre control y observación](10-codex-suscripcion-contexto-y-tool-retrieval.md) desarrolla esta distinción.

## Comprueba que lo entiendes

**¿Leer el contrato descrito en un Markdown habilita una herramienta?**

No. El entorno debe exponer una capacidad ejecutable con su contrato real. Después siguen aplicándose permisos y restricciones.

**¿Recuperar menos definiciones garantiza una respuesta mejor?**

No. Puede reducir contexto inicial, pero también añade búsqueda y puede dejar fuera información necesaria. Hay que evaluar el resultado y las fuentes.

Consulta [Contexto, consumo y límites de uso](../01-context-engineering/05-costes-basicos-de-llm.md) para relacionar esas búsquedas con el trabajo realizado.

---

[← Anterior](03-tool-definitions-upfront.md) · [Índice](../../README.md) · [Siguiente →](05-filesystem-retrieval.md)
