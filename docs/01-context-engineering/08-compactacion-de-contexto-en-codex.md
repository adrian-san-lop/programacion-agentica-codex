# Compactación de contexto en Codex

Este capítulo explica la compactación de contexto en Codex utilizado mediante una suscripción de ChatGPT Business, especialmente desde la extensión de VS Code y la CLI. No es una guía para programar con la API de OpenAI.

## Qué es el contexto

El **contexto** es la información disponible para que el modelo produzca su siguiente respuesta o decida su siguiente acción. No contiene sólo el último mensaje de la persona. Puede incluir instrucciones aplicables, mensajes anteriores, archivos consultados, llamadas a Tools y resultados.

Una conversación puede crecer aunque la petición de la persona sea breve:

```text
petición
  + instrucciones
  + archivos consultados
  + llamadas a Tools
  + resultados
  + decisiones anteriores
```

Hay que distinguir tres ideas:

| Concepto | Qué significa |
|---|---|
| Ventana de contexto | Cantidad máxima que puede utilizarse en una inferencia. |
| Consumo acumulado | Trabajo procesado durante la tarea o la conversación. |
| Límite o cupo | Presupuesto de uso que muestra el producto o el plan. |

Que una conversación tenga espacio disponible no significa que todo lo anterior sea igual de relevante.

## Qué es la compactación

La **compactación** sustituye parte de un historial extenso por una representación más pequeña para que Codex pueda continuar la misma tarea con menos contexto activo.

```text
historial extenso
       ↓
compactación
       ↓
representación más pequeña
       ↓
continuación de la misma tarea
```

La compactación no equivale a:

- abrir una conversación nueva;
- crear necesariamente un subagente;
- borrar los archivos del workspace;
- deshacer cambios de Git;
- recuperar automáticamente cualquier detalle omitido.

Es mejor pensar en ella como una transformación del contexto de la conversación, no como una copia literal de todo el historial.

## Compactación automática

Codex dispone de un umbral de compactación automática. La configuración distingue entre la ventana de contexto del modelo y el umbral que activa la compactación; si este último no se establece, se utilizan los valores predeterminados del modelo.

Por tanto:

- no hay que esperar necesariamente a alcanzar el 100 % de la ventana;
- no existe un porcentaje universal que sirva para todos los modelos y versiones;
- cambiar un umbral no aumenta por sí mismo la capacidad real del modelo.

Para el curso, lo importante es entender la función del umbral, no memorizar una cifra concreta.

## Compactación manual

La documentación actual de comandos de Codex incluye `/compact` en la CLI y en la interfaz IDE. Su finalidad es resumir el chat visible para liberar contexto y continuar con los puntos importantes.

Tiene sentido valorar la compactación cuando:

- la tarea sigue siendo la misma;
- se ha realizado una exploración extensa;
- existen muchos resultados transitorios en el historial;
- las decisiones importantes ya están guardadas o se pueden guardar antes.

No conviene utilizarla después de cada respuesta ni sólo para reducir el indicador de contexto. Si empieza un objetivo independiente, una conversación nueva con una descripción breve y los archivos relevantes puede ser más clara.

## Qué puede perderse

La compactación intenta conservar lo necesario para continuar, pero no debemos asumir que mantiene literalmente cada detalle. Puede ser vulnerable información como:

- una excepción de negocio mencionada una sola vez;
- el motivo exacto para descartar una alternativa;
- una línea concreta de un error;
- la diferencia entre una hipótesis y una conclusión comprobada;
- un requisito secundario.

Esto no significa que esos datos se pierdan siempre. Significa que una conversación larga no debe ser la única fuente de verdad.

Antes de compactar una tarea importante, conviene persistir un estado breve y verificable:

```text
Objetivo:
Hecho:
Decisiones:
Restricciones:
Pruebas realizadas:
Errores pendientes:
Siguiente paso:
Archivos relevantes:
```

Ese estado puede vivir en un documento del proyecto, mientras que Git conserva los cambios registrados. Compactar no crea commits ni sustituye a la documentación persistente.

## Compactación, memoria y Prompt Caching

Son mecanismos diferentes:

```text
Context Window
  → cuánto contexto cabe en una inferencia

Compaction
  → cómo se reduce parte del historial para continuar

Memory
  → información que puede conservarse entre sesiones

Prompt Caching
  → reutilización de trabajo sobre prefijos repetidos
```

La compactación cambia parte del contenido histórico. Por inferencia, eso puede afectar a la coincidencia de prefijos de una caché, pero no permite afirmar que toda la caché se invalide ni calcular un coste universal para cada compactación. El comportamiento depende del producto, el modelo y la ejecución concreta.

## Qué sabemos y qué no debemos inferir

| Tipo de afirmación | Formulación adecuada |
|---|---|
| Documentada | Codex ofrece `/compact` y dispone de un umbral configurable de compactación automática. |
| Observada en implementación | El código público puede mostrar rutas de compactación y preparación del contexto. |
| Inferida | Una compactación puede cambiar el prefijo que se reutiliza en peticiones posteriores. |
| No establecida | No debemos afirmar qué modelo interno resume siempre ni que exista un subagente específico. |

El código público ayuda a estudiar mecanismos, pero no garantiza que cada detalle interno sea idéntico en todas las versiones o superficies de Codex.

## Idea principal

La compactación permite continuar una tarea larga con menos contexto activo, pero no proporciona memoria perfecta ni sustituye a guardar las decisiones importantes en el proyecto.

Para trabajar de forma fiable:

1. Mantén `AGENTS.md` breve y estable.
2. Guarda decisiones y estado relevante en archivos consultables.
3. Usa Git para conservar cambios revisables.
4. Compacta cuando la tarea continúe y el historial ya sea demasiado grande.
5. Comprueba los archivos y las pruebas antes de confiar en un resumen.

## Fuentes

- [Unrolling the Codex agent loop](https://openai.com/index/unrolling-the-codex-agent-loop/)
- [Developer commands](https://learn.chatgpt.com/docs/developer-commands?surface=ide)
- [Configuration Reference](https://learn.chatgpt.com/docs/config-file/config-reference)
- [Custom instructions with AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md)
- [Pricing and usage](https://learn.chatgpt.com/docs/pricing)

---

[← Anterior](07-recuperacion-profunda.md) · [Índice](../../README.md) · [Siguiente →](../02-componentes/00-system-prompt.md)
