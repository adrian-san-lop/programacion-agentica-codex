# Context Engineering

En este curso aplicaremos estos conceptos a Codex dentro de ChatGPT mediante suscripción. Cuando aparezca la API de OpenAI será únicamente como comparación; no es el runtime que vamos a construir ni probar.

El Context Engineering consiste en proporcionar al modelo la información correcta, en el momento correcto y en la cantidad correcta.

```text
Context Engineering
├── Static Context
├── Dynamic Context
├── Progressive Disclosure
│   ├── documentación
│   ├── Skills
│   ├── Tools
│   └── datos externos
├── Costes y Prompt Caching
└── Recuperación profunda
```

La ventana de contexto marca el límite técnico, pero no garantiza que todo lo incluido sea igualmente relevante. Por eso el objetivo no es cargarlo todo, sino controlar qué información entra, cuándo entra y durante cuánto tiempo permanece disponible.

El resto de este capítulo explica esas piezas, cómo recuperar contexto paso a paso y cómo afectan al coste y la reutilización. Los capítulos de Componentes, Tools e Integraciones muestran cómo se aplican en un agente real.

## Plantilla para analizar una sesión

Cuando estudiemos un ejemplo, usa siempre estas preguntas:

| Pregunta | Qué estamos intentando identificar |
|---|---|
| ¿Qué estaba disponible al inicio? | Contexto estático: instrucciones, reglas y capacidades conocidas. |
| ¿Qué apareció durante la tarea? | Contexto dinámico: mensajes, archivos leídos y resultados. |
| ¿Quién decidió incorporarlo? | La persona, el runtime o una decisión del modelo, según el caso. |
| ¿Qué controlaba la persona? | Objetivo, restricciones, permisos y aprobaciones visibles. |
| ¿Qué gestionaba Codex? | Orquestación, selección de contexto y ejecución que el producto controla. |
| ¿Qué no podemos afirmar? | Detalles internos no documentados o no observables. |

Esta plantilla evita asumir que todo lo que existe en el workspace se incorpora automáticamente al modelo o que todo el contexto tiene el mismo origen.
---

[← Anterior](../00-introduccion/02-conceptos-que-no-deben-confundirse.md) · [Índice](../../README.md) · [Siguiente →](01-context-window.md)
