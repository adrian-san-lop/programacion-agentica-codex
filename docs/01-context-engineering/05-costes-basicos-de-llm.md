# Costes básicos al usar LLMs

En este curso usamos Codex dentro de ChatGPT mediante suscripción. Las fórmulas de tokens y las referencias de la API sirven para entender conceptos, pero no representan automáticamente una factura ni un contador visible de nuestra suscripción.

Los LLMs procesan texto en **tokens**. En una interacción hay que distinguir, como mínimo, entre los tokens que entran al modelo y los que genera como respuesta.

## Input y output

Los **input tokens** no son solo el texto que escribe el usuario. Pueden incluir:

- instrucciones del sistema;
- definiciones de Tools;
- Skills e `AGENTS.md`;
- historial relevante;
- archivos leídos;
- resultados de Tools;
- la petición actual.

Los **output tokens** son los que genera el modelo. En un agente, una sola petición puede provocar varias interacciones internas: búsquedas, lecturas, llamadas a Tools, validaciones, errores y reintentos.

```text
Input
  → contexto + petición

Output
  → respuesta o Tool Call
```

## Cálculo conceptual

Los precios reales dependen del modelo, proveedor, producto y modalidad de uso. Para entender la fórmula podemos utilizar precios ficticios:

```text
Input:  1 $ por 1M tokens
Output: 5 $ por 1M tokens
```

Si una petición contiene 14.008 input tokens y genera 7 output tokens:

```text
Coste de input:
14.008 / 1.000.000 × 1 $ = 0,014008 $

Coste de output:
7 / 1.000.000 × 5 $ = 0,000035 $
```

Es un ejemplo pedagógico, no una tarifa real ni una estimación del coste de Codex mediante suscripción.

## El contexto se repite

En una conversación posterior, la respuesta anterior puede formar parte del input necesario para entender la nueva petición:

```text
Turno 1:
petición → input
respuesta → output

Turno 2:
contexto anterior + nueva petición → input
nueva respuesta → output
```

Los output tokens no se vuelven a contar como output, pero parte de esa información puede pasar a formar parte del input de turnos posteriores.

## Codex no es lo mismo que la API

Cuando Codex se utiliza mediante un plan de ChatGPT, la interfaz puede mostrar uso, límites o créditos disponibles. Si la interfaz ofrece `/status`, puede utilizarse para consultar el estado de la sesión o sus límites.

Eso no equivale necesariamente a una factura monetaria por token. En una aplicación propia mediante API, input, cached input y output pueden tener categorías y tarifas separadas. Consulta siempre la información oficial del producto y del modelo utilizado.

La documentación oficial distingue entre input, output, cached input y límites de uso en productos que los exponen. En Codex mediante suscripción debemos utilizar los límites y el consumo que muestre el propio cliente, sin inferir una tarifa por token. [Understanding and counting tokens](https://help.openai.com/en/articles/4936856-understanding-and-counting-tokens).

## Idea que debemos conservar

El tamaño de la respuesta visible no representa todo el trabajo del agente. Para controlar consumo y calidad hay que reducir contexto innecesario, evitar exploración repetida y cargar solo la información relevante.

---

[← Anterior](04-progressive-disclosure.md) · [Índice](../../README.md) · [Siguiente →](06-prompt-caching.md)
