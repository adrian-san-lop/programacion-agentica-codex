# AGENTS.md

Archivo de instrucciones persistentes para trabajar dentro de un proyecto.

## Propósito

`AGENTS.md` contiene instrucciones persistentes sobre **cómo trabajar dentro de un proyecto**.

Puede contener:

- Cómo ejecutar tests.
- Cómo ejecutar lint.
- Convenciones de arquitectura.
- Reglas para modificar código.
- Documentación disponible.
- Criterios de finalización.
- Comandos importantes.

Ejemplo:

```md
# Commands

npm test
npm run lint

# Architecture

- Follow the existing domain architecture.
- Keep domain logic independent from infrastructure.

# Documentation

Detailed guidelines live in `docs/`.

Do NOT read all docs upfront.
Read only the documentation relevant to the current task.
```

`AGENTS.md` no debería convertirse en un enorme repositorio de conocimiento.

Lo ideal es utilizarlo como **mapa de navegación**.

Por ejemplo:

```text
AGENTS.md
   │
   ▼
docs/
├── dax.md
├── semantic-models.md
├── power-query.md
├── testing.md
└── deployment.md
```

Esto permite aplicar **Progressive Disclosure**.

---

---


---

## AGENTS.md jerárquicos

Los `AGENTS.md` pueden existir en diferentes niveles del árbol de un proyecto.

Ejemplo:

```text
project/
│
├── AGENTS.md
│
├── frontend/
│   └── AGENTS.md
│
└── backend/
    └── AGENTS.md
```

Esto permite tener:

```text
AGENTS.md raíz
        ↓
reglas generales

frontend/AGENTS.md
        ↓
reglas específicas frontend

backend/AGENTS.md
        ↓
reglas específicas backend
```

Las instrucciones más específicas pueden complementar o prevalecer sobre las generales dependiendo del runtime.

En **Codex**, `AGENTS.md` es un mecanismo soportado. Codex busca estos archivos desde el ámbito global y desde la raíz del proyecto hasta la carpeta de trabajo; los combina en ese orden para construir la cadena de instrucciones de la ejecución. Un `AGENTS.override.md` puede sustituir al `AGENTS.md` equivalente en un ámbito. La documentación oficial indica además un límite predeterminado de 32 KiB para esa cadena, configurable por el proyecto.

Por tanto, en Codex las instrucciones más cercanas a la carpeta donde se trabaja aparecen después y pueden concretar o sobrescribir las generales. Esta es la regla operativa que debemos enseñar aquí; otros runtimes pueden resolver la jerarquía de otra forma.

Otros agentes pueden utilizar otros mecanismos.

Por ejemplo, Claude Code utiliza principalmente:

```text
CLAUDE.md
```

---


En un equipo, este mapa ayuda a que personas, agentes y subagentes encuentren la misma información. Consulta [Monorepo y documentación](../05-trabajo-en-equipo/02-monorepo-y-documentacion.md).

[← Anterior](00-system-prompt.md) · [Índice](../../README.md) · [Siguiente →](02-skills.md)

