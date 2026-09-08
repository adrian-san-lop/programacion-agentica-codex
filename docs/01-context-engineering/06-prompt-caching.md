# Prompt Caching

**Ampliación opcional.** Basta con entender qué significa; no tienes que configurarlo para aprender programación agéntica.

## La idea en una frase

Prompt Caching es reutilizar parte del trabajo de procesamiento de un comienzo de contexto que se repite, en lugar de procesarlo siempre desde cero.

A ese comienzo se le llama **prefijo**. No consiste en reutilizar automáticamente una respuesta anterior.

## Nuestra historia

Entre dos consultas sobre Sales YTD puede repetirse parte de las instrucciones. Conceptualmente, ese trabajo podría reutilizarse. Sin embargo, ver instrucciones repetidas no demuestra que se haya utilizado una caché.

No necesitamos conocer su implementación para organizar bien el proyecto.

## No confundir

| Concepto | Para qué sirve |
|---|---|
| Recuperación | Encontrar información pertinente |
| Compactación | Reducir el historial activo para continuar |
| Memoria persistente | Conservar información para trabajos posteriores |
| Prompt Caching | Reutilizar trabajo de procesamiento repetido |

Caching no amplía la ventana de contexto ni corrige una regla equivocada.

## Qué hacemos en Codex

Mantenemos instrucciones claras y evitamos duplicaciones porque ayudan al trabajo del agente. No organizamos el curso alrededor de ordenar internamente las Tools, ajustar tiempos de caché o perseguir porcentajes de ahorro.

La construcción interna del contexto no es un control del workspace. Tampoco debemos conservar instrucciones desactualizadas por miedo a afectar una caché: la corrección tiene prioridad.

## Comprueba que lo entiendes

**¿Necesito configurar caching antes de utilizar una Skill DAX?**

No. La Skill aporta un procedimiento; caching es un mecanismo distinto. Puedes continuar con [recuperación de contexto](07-recuperacion-profunda.md).

---

[Continuar con lo esencial: recuperación de contexto →](07-recuperacion-profunda.md).

[← Anterior](05-costes-basicos-de-llm.md) · [Índice](../../README.md) · [Siguiente →](07-recuperacion-profunda.md)
