# Contexto y recuperación en profundidad

Este documento explica una idea sencilla:

> Recuperar contexto significa darle a Codex sólo la información que necesita para resolver una tarea concreta.

El entorno práctico del curso es **Codex dentro de ChatGPT mediante suscripción**. No vamos a construir un buscador mediante la API ni a crear índices vectoriales. Primero aprenderemos a organizar y pedir correctamente el contexto del workspace.

La API de OpenAI aparece únicamente como comparación posterior. Sus endpoints y métricas no son controles disponibles automáticamente en nuestra suscripción.

## 1. El problema: un proyecto contiene demasiada información

Imagina un proyecto con:

```text
100 documentos
20 Skills
15 Tools
varios archivos del modelo Power BI
```

Y la petición del usuario:

```text
Optimiza la medida Sales YTD.
```

Codex no necesita leerlo todo. Probablemente necesita:

```text
AGENTS.md
Skill de DAX
reglas DAX
definición de Sales YTD
esquema del modelo
```

Eso es recuperación de contexto:

```text
no cargar todo
      ↓
buscar lo necesario
      ↓
usar sólo lo encontrado
```

No significa que tengas que programar un buscador. Significa decidir qué información debe consultar Codex y cuál no necesita.

## 2. Cómo aplicarlo en Codex

El flujo conceptual para esta tarea sería:

```text
1. Codex entiende que es una tarea DAX.
2. Consulta las instrucciones del proyecto.
3. Busca o utiliza la Skill de DAX.
4. Lee las reglas DAX relevantes.
5. Obtiene la definición actual de Sales YTD mediante una Tool.
6. Obtiene el esquema del modelo si lo necesita.
7. Analiza la medida.
8. Propone un cambio.
```

La organización del proyecto ayuda a que este flujo sea posible:

```text
AGENTS.md
    ↓
indica dónde buscar

Skill DAX
    ↓
indica cómo trabajar

documentación DAX
    ↓
aporta reglas

MCP / Tools
    ↓
aportan datos actuales del modelo
```

Una petición práctica podría ser:

```text
Quiero optimizar la medida Sales YTD.

Lee primero AGENTS.md.
Después consulta la Skill de DAX y las reglas DAX del proyecto.
Obtén la definición actual de Sales YTD mediante las Tools disponibles.
No modifiques nada.
Indica qué información has utilizado y qué dato te falta.
```

Este prompt ya aplica Context Engineering y recuperación de contexto. No hemos utilizado la API ni hemos construido un sistema de búsqueda.

En Codex, el runtime gestionado por el producto prepara una petición combinando varias capas. Nosotros no vemos ni controlamos todo el mensaje interno; podemos registrar una representación aproximada para analizar qué contexto visible aportamos:

```text
instrucciones del sistema
+ instrucciones del proyecto
+ historial o estado de la conversación
+ definiciones de Tools disponibles
+ contexto recuperado
+ petición actual
        ↓
petición al modelo
```

El orden y el formato exactos dependen del producto. No necesitas escribir este JSON para trabajar con Codex; es sólo un registro opcional para analizar el contexto visible:

```json
{
  "instructions": "Analiza y explica; no modifiques el modelo sin aprobación.",
  "project_context": ["AGENTS.md", "docs/dax-rules.md"],
  "tools": ["get_measure", "get_model_schema"],
  "retrieved_context": [
    {"source": "docs/dax-rules.md", "score": 0.91, "text": "..."}
  ],
  "user_request": "Optimiza Sales YTD"
}
```

Este JSON es un registro pedagógico, no el formato interno de Codex ni una petición que vayamos a enviar directamente. La pregunta importante es: ¿qué contexto visible aportamos, por qué lo aportamos, en qué orden lo presentamos y con qué versión?

## 3. Ejemplo trazable: optimizar una medida DAX

Supongamos que el workspace contiene estos fragmentos:

| ID | Fuente | Contenido resumido |
|---|---|---|
| A | `docs/dax-rules.md` | Usar una tabla calendario marcada como Date table. |
| B | `docs/dax-rules.md` | Patrón aprobado para medidas YTD. |
| C | `docs/report-design.md` | Convenciones de formato de tarjetas. |
| D | `docs/deployment.md` | Pasos para publicar en Fabric. |
| E | `docs/semantic-model.md` | La tabla de hechos y sus relaciones. |

Petición:

```text
Optimiza la medida Sales YTD y explica qué cambiarías.
```

### Paso 1: interpretar la necesidad

El runtime o el agente identifica una tarea DAX. `AGENTS.md` puede dirigir a las reglas DAX y una Skill puede definir el procedimiento. Esto es orientación y recuperación de conocimiento; no es todavía una llamada a una Tool.

### Paso 2: recuperar candidatos

Una búsqueda produce candidatos, no una respuesta final:

```text
consulta = "optimizar medida Sales YTD calendario relaciones tabla de hechos"

resultado inicial = [B, E, A, C, D]
```

Cada resultado debería conservar, como mínimo, su identificador, fuente, fragmento, puntuación o motivo de selección y versión/fecha si existe.

### Paso 3: filtrar y ordenar

Una política sencilla puede ser:

1. eliminar documentos fuera del alcance del proyecto;
2. eliminar duplicados;
3. exigir que el fragmento trate de DAX o del modelo;
4. priorizar reglas específicas sobre documentación general;
5. ordenar por relevancia y después por autoridad y actualidad;
6. limitar el presupuesto, por ejemplo a 3 fragmentos o 1.500 tokens.

El contexto final podría quedar así:

```text
1. B — regla YTD específica — score 0.94
2. E — relaciones del modelo — score 0.88
3. A — calendario del proyecto — score 0.84
```

No se incluyen C ni D: pueden ser documentos válidos, pero no ayudan a esta pregunta. Guardar esta lista permite reproducir por qué el modelo recibió esos tres fragmentos.

### Paso 4: construir la petición

```text
INSTRUCCIONES
Analiza la medida. Usa únicamente el contexto recuperado como evidencia del proyecto.
No escribas cambios. Señala cualquier dato que falte.

CONTEXTO RECUPERADO
[B] Regla YTD: ...
[E] Modelo: ...
[A] Calendario: ...

PETICIÓN
Optimiza la medida Sales YTD y explica qué cambiarías.
```

El modelo propone una respuesta basándose en ese contexto. Si necesita conocer la expresión real o el esquema actual, solicita `get_measure` o `get_model_schema`; sus resultados vuelven a ser contexto dinámico y el ciclo continúa.

## 4. Tres formas de buscar: teoría posterior

Estas formas de búsqueda son importantes para entender cómo se construyen agentes, pero no son pasos que tengamos que programar ahora en Codex.

### Búsqueda por texto

Busca coincidencias de palabras o términos normalizados. Un índice invertido relaciona cada palabra con los documentos donde aparece.

- Ventaja: exacta y explicable para nombres como `Sales YTD`, tablas o IDs.
- Riesgo: no encuentra bien sinónimos o paráfrasis.

### Búsqueda semántica

Convierte la consulta y los fragmentos en representaciones numéricas y compara su proximidad. Puede encontrar que “acumulado anual” se relaciona con “YTD” aunque no compartan exactamente las palabras.

- Ventaja: tolera lenguaje distinto.
- Riesgo: puede devolver algo parecido pero incorrecto para el modelo concreto.

### Índices y búsqueda híbrida

Un índice no es una tercera clase de significado: es una estructura para buscar más rápido. Un índice invertido sirve para texto; un índice vectorial sirve para proximidad semántica. Una estrategia híbrida combina ambos resultados y reordena con una regla explícita.

```text
texto:     [B, A, E]
semántica: [A, B, C]
filtros:   sólo docs del proyecto y DAX
fusión:    B, A, E, C
reranking: B, E, A
```

Como comparación, la API de OpenAI documenta File Search como una herramienta que combina búsqueda semántica y por palabras clave sobre archivos cargados en vector stores. La referencia de búsqueda muestra filtros, número máximo de resultados, reescritura de consulta y puntuaciones. Esto describe la API, no una promesa sobre el mecanismo interno ni las herramientas disponibles en Codex mediante suscripción.

## 5. Qué hacer con el contexto seleccionado

### Caché

La caché reutiliza trabajo sobre un prefijo repetido. No es memoria ni búsqueda:

```text
prefijo estable + petición nueva
        ↓
puede reutilizarse el prefijo
```

Como regla general, conviene colocar primero las instrucciones y el contexto estable y dejar al final la información dinámica. En Codex mediante suscripción no asumiremos que podemos inspeccionar o configurar la caché como en la API; sólo registraremos efectos observables si el cliente los muestra.

### Resumen y compresión

Un resumen sustituye muchos mensajes o resultados por una representación más corta. Debe conservar objetivo, decisiones, IDs, resultados de Tools, supuestos, bloqueos y siguiente acción.

La compresión es una transformación con pérdida potencial: hay que conservar una copia auditable si los detalles originales pueden ser necesarios. La Responses API ofrece una operación de compaction para conversaciones largas; es una comparación de API y no debe presentarse como una operación disponible ni como el funcionamiento interno confirmado de Codex.

### Caducidad

Cada dato debería tener una política:

| Dato | Ejemplo | Caducidad razonable |
|---|---|---|
| Regla estable | Convención DAX | Hasta cambio de versión |
| Esquema | Tablas y relaciones | Hasta cambiar el modelo |
| Resultado de consulta | Medidas actuales | Minutos o invalidación tras escritura |
| Memoria de trabajo | Decisión de esta sesión | Fin de la tarea |

La fecha de caducidad no se debe confundir con la fecha del documento. Una escritura en el modelo puede invalidar inmediatamente un resultado cacheado aunque su TTL no haya terminado.

## 6. Sesión, memoria y fuente de verdad

```text
Memoria de sesión
→ mensajes y resultados necesarios para continuar esta tarea

Memoria persistente
→ preferencias o aprendizajes que pueden reutilizarse después

Documentación / sistema fuente
→ reglas y hechos que deben poder verificarse
```

La memoria persistente no debe convertirse en la autoridad para datos cambiantes. Por ejemplo, una memoria que diga “Sales YTD usa calendario Date” debe contrastarse con el modelo actual y con la documentación versionada.

En Codex, las memorias locales y el contexto de una conversación son capas distintas de `AGENTS.md`, Skills, Tools y contexto explícito del IDE. La disponibilidad depende del cliente; por eso el curso debe enseñar a preguntar qué fuente se ha utilizado y no asumir una memoria infinita.

## 7. Cómo medirlo cuando tengamos un entorno observable

Crear un pequeño dataset de preguntas con una respuesta esperada y fuentes relevantes. Para cada ejecución registrar:

- consulta original y consulta reescrita;
- candidatos y resultados finales, con puntuación;
- fragmentos realmente enviados al modelo;
- indicadores de uso que Codex o el cliente muestren, si están disponibles;
- latencia de búsqueda, modelo y Tool Calls;
- respuesta, citas y errores.

Métricas iniciales:

```text
Recall@k = documentos relevantes recuperados en los k primeros
           -----------------------------------------------
           documentos relevantes existentes

Precision@k = documentos relevantes recuperados en los k primeros
              --------------------------------------------------
              documentos recuperados en los k primeros
```

Para el agente completo añadir:

- exactitud de la respuesta respecto a la evidencia;
- tasa de respuestas con fuente suficiente;
- tasa de Tool Calls correctas;
- latencia media y p95;
- límites o consumo mostrado por Codex, sin convertirlo automáticamente en una factura por tokens;
- tasa de éxito de la tarea y revisión humana en operaciones de riesgo.

Una recuperación mejor no es la que devuelve más fragmentos, sino la que permite responder correctamente con el menor contexto y tiempo compatibles con la calidad requerida.

## 8. Qué puedes hacer ahora y qué queda para después

### Puedes hacerlo ahora en Codex

- organizar el workspace;
- mantener `AGENTS.md` como mapa de navegación;
- indicar qué Skill y documentación debe consultarse;
- pedir que Codex trabaje con archivos concretos;
- utilizar las Tools disponibles para obtener datos actuales;
- pedir una lista de fuentes utilizadas;
- revisar el resultado antes de aprobar cambios.

### Es teoría o requiere otro entorno

- construir un índice invertido o vectorial;
- configurar `File Search` o `vector stores`;
- utilizar `tool_search` de la API;
- controlar el ranking interno de Codex;
- ver las puntuaciones internas de recuperación;
- inspeccionar el system prompt completo;
- conocer el TTL interno de la caché de Codex;
- medir los tokens internos si el cliente no los muestra.

## 9. Qué es general y qué depende de OpenAI

| Concepto | General | Documentado específicamente en OpenAI |
|---|---:|---:|
| Filtrar, ordenar y limitar contexto | Sí | Es una decisión de arquitectura |
| Búsqueda textual y semántica | Sí | File Search de la API las combina; Codex no se presupone igual |
| Índice invertido/vectorial | Sí | La implementación interna no se presupone |
| Prompt caching | Sí | La API expone opciones; Codex puede ocultar esos controles |
| Compaction | Patrón general | La Responses API ofrece un endpoint; no se atribuye a Codex |
| Memoria interna de Codex mediante suscripción | No | No se debe inferir sin documentación o prueba |
| Orden exacto del contexto interno de Codex | No | No está expuesto públicamente con ese detalle |

El objetivo didáctico es que una persona pueda trazar cada pieza sin confundir el patrón de Context Engineering con una capacidad concreta de un producto.

## Fuentes oficiales consultadas

- [Personalización de Codex](https://learn.chatgpt.com/es-419/docs/customization/overview)
- [Extensión IDE de Codex](https://developers.openai.com/codex/ide)
- [File Search en la Responses API — comparación](https://developers.openai.com/api/docs/guides/tools-file-search)
- [Retrieval y búsqueda de vector stores](https://developers.openai.com/api/reference/python/resources/vector_stores/methods/search)
- [Prompt Caching](https://developers.openai.com/api/docs/guides/prompt-caching)
- [Conversation state](https://developers.openai.com/api/docs/guides/conversation-state)
- [Compact a response](https://developers.openai.com/api/reference/java/resources/responses/methods/compact)

[← Anterior](06-prompt-caching.md) · [Índice](../../README.md) · [Siguiente →](../02-componentes/00-system-prompt.md)
