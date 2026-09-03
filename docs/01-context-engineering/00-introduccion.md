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
---


---

[← Anterior](../00-introduccion/02-conceptos-que-no-deben-confundirse.md) · [Índice](../../README.md) · [Siguiente →](01-context-window.md)
