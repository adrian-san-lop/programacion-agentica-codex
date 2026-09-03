# Prompt Caching

**Prompt Caching** permite reutilizar parte del trabajo realizado sobre un input que vuelve a aparecer en peticiones posteriores. Es especialmente útil cuando una conversación o un agente repite instrucciones, Tools y contexto estable.

No debe confundirse con:

```text
Context Window → cantidad máxima de contexto que cabe en una petición
Compaction     → resumir contexto antiguo para poder continuar
Memory         → conservar información entre sesiones
Prompt Caching → reutilizar trabajo sobre un prefijo repetido
```

## Modelo mental sencillo

Podemos imaginar una inferencia en estas fases:

```text
Tokenización
    ↓
Prefill: procesar el input
    ↓
Decode: generar la salida
    ↓
Detokenización
```

El caching se relaciona principalmente con el `prefill`: si el principio de una nueva petición coincide con un prefijo ya procesado, el sistema puede reutilizar parte de ese trabajo.

## Cache miss y cache hit

En la primera petición puede no existir un estado reutilizable:

```text
System prompt + Tools + Skills + AGENTS.md + petición
                         ↓
                    CACHE MISS
```

En una petición posterior, si el prefijo coincide:

```text
System prompt + Tools + Skills + AGENTS.md   → CACHED
historial nuevo + petición nueva             → NEW
```

Un **cache hit** no significa que toda la petición sea idéntica ni que se elimine el trabajo restante.

## El orden del contexto importa

El modelo mental correcto no es “buscar cualquier texto repetido”, sino comprobar cuánto del principio de la petición coincide.

Por eso conviene colocar:

```text
Contexto estable
  ↓
Contexto compartido
  ↓
Información dinámica
  ↓
Petición actual
```

Un `AGENTS.md` corto, estable y operativo puede ayudar doblemente: reduce el contexto y favorece que el prefijo se mantenga reutilizable.

También conviene generar de forma determinista las definiciones de Tools. Cambiar su orden, añadirlas o eliminarlas continuamente puede modificar una parte temprana del input.

## Qué puede reducir un cache hit

Entre otras situaciones:

- cambiar las instrucciones estáticas;
- modificar `AGENTS.md`;
- cambiar las definiciones de Tools;
- cambiar de modelo;
- generar prompts con pequeñas variaciones;
- superar el tiempo de vida de la caché;
- reconstruir el contexto de forma diferente.

El comportamiento exacto depende del producto, modelo y runtime. No se debe asumir que Codex, Cursor y Claude Code utilizan el mismo TTL, la misma invalidación o la misma caché.

## Coste y límites

El input recuperado desde caché puede tener un tratamiento distinto del input normal en productos que ofrecen Prompt Caching. La caché puede reducir coste de input y latencia, pero:

- no aumenta la Context Window;
- no proporciona memoria infinita;
- no evita procesar la parte nueva;
- no garantiza un porcentaje universal de ahorro.

En la API de OpenAI, la documentación explica el uso de prefijos comunes y la medición de tokens recuperados desde caché. [Prompt Caching in the API](https://openai.com/index/api-prompt-caching/).

Codex utilizado mediante un plan de ChatGPT no debe tratarse automáticamente como una aplicación propia facturada por API. Para precios, cache writes, TTL y límites hay que consultar la modalidad concreta y la documentación vigente.

## Subagentes

No es correcto afirmar que un subagente siempre empieza con la caché vacía. Depende de cómo el runtime construya su contexto: puede recibir una tarea pequeña, parte del contexto padre, instrucciones propias, otro modelo o Tools diferentes.

Delegar una tarea pequeña puede reducir el contexto que necesita ese subagente, pero eso es una decisión de arquitectura y no una propiedad universal del Prompt Caching.

## Regla práctica

```text
Mantén estable lo que se repite.
Coloca lo dinámico al final.
Evita duplicar instrucciones.
No cambies Tools sin necesidad.
Mide los cached tokens cuando el producto lo permita.
```

---

[← Anterior](05-costes-basicos-de-llm.md) · [Índice](../../README.md) · [Siguiente →](../02-componentes/00-system-prompt.md)
