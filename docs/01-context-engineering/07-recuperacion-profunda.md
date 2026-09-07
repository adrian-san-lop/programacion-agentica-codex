# Contexto y recuperación en profundidad

Recuperar contexto significa buscar y consultar la información que falta para una tarea. Aquí profundizamos en cómo elegir y comprobar las fuentes, no en construir un buscador.

## 1. Partimos de una pregunta concreta

> Analiza la medida Sales YTD y explica si hay algún problema. No modifiques nada.

La historia es conceptual: no necesitas tener Power BI conectado para seguirla.

Supongamos que el proyecto contiene reglas DAX, documentación de relaciones, diseño visual y despliegue. Tener esos archivos no significa que Codex ya los haya leído.

## 2. Qué aporta cada pieza

| Pieza | Pregunta que resuelve |
|---|---|
| `AGENTS.md` | ¿Qué reglas seguir y dónde consultar? |
| Skill DAX | ¿Qué procedimiento de revisión usar? |
| Reglas DAX | ¿Qué convenciones debe cumplir la medida? |
| Definición actual de Sales YTD | ¿Qué expresión estamos analizando? |
| Relaciones y calendario | ¿En qué modelo se evalúa? |

La Skill explica cómo trabajar; no contiene necesariamente la expresión actual. La documentación del modelo puede orientar, pero hay que comprobar que sigue vigente.

## 3. Un recorrido trazable

**Trazable** significa poder relacionar cada conclusión con la información que la respalda.

1. Codex consulta las instrucciones aplicables.
2. Utiliza el procedimiento DAX disponible, si lo hay.
3. Lee las reglas relevantes y localiza la definición de la medida.
4. Si faltan datos actuales, el modelo solicita una Tool disponible; el runtime comprueba permisos y coordina la consulta.
5. El resultado permite decidir si hace falta consultar relaciones o calendario.
6. Codex explica qué ha comprobado, qué es una hipótesis y qué falta.

No se incluyen los pasos de despliegue ni el formato de las tarjetas porque no ayudan a esta pregunta.

Esto es una secuencia explicativa, no una promesa del orden interno exacto de Codex.

## 4. Cómo orientarlo con una petición

```text
Analiza la medida Sales YTD y explica si hay algún problema.
No modifiques nada.

Consulta las instrucciones del proyecto y las reglas DAX pertinentes.
Si existe un procedimiento DAX aplicable, úsalo.
Comprueba la expresión actual y las relaciones que necesites.
Si no puedes obtenerlas, indícalo y no inventes su contenido.

Separa hallazgos comprobados, hipótesis y datos pendientes.
Indica las fuentes utilizadas.
```

No hace falta repetir todo el proyecto en el mensaje. Una referencia clara a un archivo puede ser suficiente para orientarlo.

## 5. Elegir fuentes y resolver contradicciones

Antes de usar una fuente, pregunta:

- **Pertinencia:** ¿trata de esta medida o de una regla necesaria?
- **Vigencia:** ¿describe el estado que estamos revisando?
- **Autoridad:** ¿es una regla aprobada, un dato actual o una nota provisional?
- **Suficiencia:** ¿permite sostener la conclusión?

Ejemplo: la documentación dice que la medida usa `DimDate`, pero la expresión consultada referencia otra tabla. Codex debe mostrar la discrepancia y comprobarla, no escoger silenciosamente la versión que encaje con su respuesta.

`docs/notes.txt` conserva dudas y apuntes; no sustituye a la documentación consolidada ni al modelo actual.

Una instrucción encontrada dentro de un dato tampoco concede permisos para modificar el modelo.

## 6. Qué hacer si falta información

| Situación | Respuesta adecuada |
|---|---|
| No aparece Sales YTD | Confirmar nombre y modelo; no inventar la medida |
| No hay Tool de conexión | Explicar el límite; pedir la expresión o una fuente local autorizada |
| La consulta falla | Revisar el error y probar sólo alternativas seguras |
| Faltan relaciones | Ofrecer un análisis limitado y señalar lo que no puede comprobarse |
| Hay evidencia suficiente | Responder con fuentes, sin seguir buscando por inercia |

No siempre es necesario un MCP: una expresión proporcionada por la persona puede permitir un análisis parcial. Lo importante es declarar ese alcance.

## 7. Cómo evaluar la recuperación

Pide una entrega breve:

```text
Fuentes consultadas:
Qué demuestra cada fuente:
Hallazgos comprobados:
Hipótesis:
Datos que faltan:
Cambios realizados: ninguno.
```

Contrasta esas fuentes con los archivos y resultados visibles cuando estén disponibles. Una lista redactada por Codex no es, por sí sola, una traza completa de ejecución.

Evalúa si la respuesta usa información pertinente, suficiente y vigente. No necesitas puntuaciones internas, fragmentos con valores numéricos ni una reconstrucción del mensaje completo enviado al modelo.

## 8. Contexto durante y después de la tarea

Los mensajes y resultados ayudan a continuar la sesión. Si cambia la medida o el modelo, una lectura anterior puede dejar de representar su estado actual y habrá que consultarlo de nuevo.

Las decisiones importantes deben guardarse en archivos del proyecto cuando se autorice hacerlo. No dependas sólo del historial para recuperarlas en otra conversación.

En una sesión larga, Codex puede compactar contexto. La [compactación](08-compactacion-de-contexto-en-codex.md) reduce historial activo; no sustituye a las fuentes originales.

## Ampliación opcional: buscar no siempre significa lo mismo

- **Búsqueda por texto:** encuentra nombres o palabras, como `Sales YTD`.
- **Búsqueda semántica:** busca semejanza de significado, como relacionar «acumulado anual» con «YTD».
- **Índice:** estructura que facilita localizar información; no garantiza su calidad.

Estos términos ayudan a entender alternativas de búsqueda. No implican que Codex utilice una de ellas en una tarea concreta ni que debamos implementar índices en el curso.

## Comprueba que lo entiendes

**¿Leer todas las reglas garantiza una revisión correcta?**

No. Falta comprobar la expresión y el contexto del modelo.

**¿Si no hay conexión, el agente debe inventar un resultado probable?**

No. Debe declarar el límite y pedir lo necesario o realizar un análisis parcial explícito.

La idea que debes conservar: orientar las consultas, comprobar las fuentes y detener la exploración cuando la evidencia sea suficiente.

---

[← Anterior](06-prompt-caching.md) · [Índice](../../README.md) · [Siguiente →](08-compactacion-de-contexto-en-codex.md)
