# Guía de lectura de una tarea con Tools en Codex

Esta guía une los conceptos sin exigir todavía una conexión real. Nuestro entorno es la extensión de Codex para VS Code con una suscripción de ChatGPT Business.

## 1. Nuestra petición

> Analiza la medida Sales YTD y explica si hay algún problema. No modifiques nada.

El objetivo es una revisión sustentada en datos. No autoriza corregir la medida.

## 2. Del contexto a una acción

| Paso conceptual | Quién interviene | Qué ocurre |
|---|---|---|
| Orientación | Persona e instrucciones del proyecto | Definen objetivo, límites y fuentes |
| Preparación | Runtime | Proporciona contexto y capacidades disponibles |
| Decisión | Modelo | Identifica que necesita la expresión actual |
| Solicitud | Modelo | Propone una Tool Call con argumentos |
| Control | Runtime y sistema conectado | Aplican los permisos y controles correspondientes |
| Ejecución | Tool | Consulta la medida o devuelve un error |
| Continuación | Runtime y modelo | Incorporan el resultado y deciden si falta información |

Es una explicación del ciclo, no una transcripción de mensajes internos de Codex.

## 3. Catálogo, contrato e invocación

- **Catálogo:** inventario de capacidades que ayuda a descubrir qué existe.
- **Contrato:** descripción y argumentos admitidos por una Tool.
- **Invocación:** petición concreta para utilizarla.

Ejemplo ilustrativo:

```text
Catálogo: existe una capacidad para consultar medidas.
Contrato: necesita identificar modelo, tabla y medida.
Invocación: consulta Sales YTD en la tabla y el modelo verificados.
```

Los nombres y argumentos reales deben comprobarse en las Tools disponibles. Escribir un contrato en Markdown no crea ni registra una herramienta.

## 4. Qué podemos hacer nosotros

- Indicar el objetivo y que la tarea es de sólo lectura.
- Organizar las reglas en `AGENTS.md` y los documentos del proyecto.
- Usar una Skill para repetir un procedimiento de revisión.
- Configurar integraciones compatibles cuando llegue la práctica.
- Revisar la herramienta y el destino antes de aprobar operaciones.
- Pedir fuentes, límites del análisis y comprobaciones realizadas.

No elegimos desde un documento qué definiciones internas se envían primero al modelo. Upfront, retrieval y estrategias híbridas explican posibilidades de diseño, no un selector que este curso presuponga disponible en VS Code.

## 5. Cuando algo no funciona

Si no hay conexión, Codex puede pedir la expresión o consultar archivos autorizados. Si faltan relaciones, debe limitar sus conclusiones. Si la Tool rechaza una operación, debe explicar el rechazo y no intentar eludirlo.

En ningún caso una instrucción recuperada amplía la autorización inicial.

El bloque de [seguridad y hooks](../04-seguridad-y-hooks/00-seguridad-en-el-agent-loop.md) desarrolla los controles de este ciclo y sus límites, incluidos los de una conexión remota.

## 6. Cómo revisar la entrega

Comprueba que:

1. Identifica qué medida y modelo analizó.
2. Cita las reglas, archivos o resultados utilizados.
3. Separa hechos de hipótesis.
4. Explica qué comprobaciones no pudo realizar.
5. No presenta una mejora propuesta como una mejora validada.
6. No ha modificado nada.

Cuando llegue la práctica, podremos comparar tareas equivalentes observando pertinencia de fuentes, errores, tiempo y resultado. Un porcentaje de contexto aislado no prueba que una estrategia funcione mejor.

## Comprueba que lo entiendes

Después del bloque de seguridad, puedes seguir la [revisión narrada de Sales YTD](../04-seguridad-y-hooks/04-lectura-guiada-decisiones-sales-ytd.md): desde el encargo hasta la entrega, con cada consulta y su motivo explicados. No requiere una conexión real.

**¿Necesito crear un catálogo propio para que Codex utilice un servidor MCP configurado?**

No. El servidor expone sus capacidades. Un catálogo documental puede explicarlas, pero no es la conexión.

**¿Una Tool que devuelve datos garantiza una conclusión correcta?**

No. Hay que comprobar que corresponden al modelo, medida y alcance adecuados.

Referencias de producto: [extensión IDE](https://learn.chatgpt.com/docs/codex/ide) y [MCP en Codex](https://learn.chatgpt.com/docs/extend/mcp).

---

[← Anterior](08-estrategia-hibrida.md) · [Índice](../../README.md) · [Siguiente →](10-codex-suscripcion-contexto-y-tool-retrieval.md)
