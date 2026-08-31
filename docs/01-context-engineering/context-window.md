# Context Window y atención efectiva

La capacidad técnica de contexto no equivale a relevancia efectiva.

## Context Window y atención efectiva

## Context Window

La **ventana de contexto** representa cuánta información puede manejar el modelo dentro de una inferencia.

Puede contener:

```text
System Prompt
+
AGENTS.md
+
Skills cargadas
+
Tools
+
mensajes
+
resultados de Tools
+
archivos
+
memoria
+
otros datos
```

---

---


## Atención efectiva

Que algo quepa dentro de la ventana de contexto **no significa que todo sea igualmente relevante para el modelo**.

Por ejemplo:

```text
100.000 tokens de contexto
```

pueden caber técnicamente.

Pero si:

```text
2.000 tokens
```

son realmente relevantes para resolver la tarea, introducir enormes cantidades de información adicional puede generar ruido.

Por eso:

```text
Más contexto
≠
Mejor resultado
```

Lo que buscamos es:

```text
Context Engineering
        ↓
Contexto correcto
        +
Momento correcto
        +
Cantidad correcta
```

---

---

## Cómo se aplica

Todos estos conceptos forman parte de algo más amplio:

**Context Engineering**.

El objetivo no es:

```text
Darle al LLM toda la información posible.
```

El objetivo es:

```text
Darle al LLM
la información correcta
en el momento correcto
y en la cantidad correcta.
```

Podemos aplicar Progressive Disclosure sobre:

```text
Documentación
      ↓
Filesystem Retrieval

Skills
      ↓
Skill Loading

Tools
      ↓
Tool Retrieval

Datos
      ↓
MCP / APIs / Database

Memoria
      ↓
Memory Retrieval
```

Todo converge en:

```text
                 CONTEXT ENGINEERING
                         │
                         ▼
              Progressive Disclosure
                         │
       ┌─────────────────┼─────────────────┐
       │                 │                 │
       ▼                 ▼                 ▼
     Skills          Documents           Tools
       │                 │                 │
       ▼                 ▼                 ▼
   Retrieval         Retrieval         Retrieval
       │                 │                 │
       └─────────────────┼─────────────────┘
                         ▼
                        LLM
                         │
                         ▼
                    Agent Loop
```

---


[← Anterior](introduccion.md) · [Índice](../../README.md) · [Siguiente →](static-context.md)

