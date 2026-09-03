# Monorepo y documentación

Centralizar la documentación en un monorepositorio resulta útil cuando varios proyectos comparten conceptos, convenciones y ejemplos.

```text
repo/
├── AGENTS.md
├── docs/
├── skills/
└── scripts/
```

`AGENTS.md` debe actuar como mapa del proyecto. Puede indicar dónde están los conceptos de programación agéntica, las integraciones y los ejemplos, pero no debe contener todo el conocimiento.

La carpeta `skills/` del esquema es una convención de este repositorio. En Codex, las Skills locales que deben auto-descubrirse se organizan en `.agents/skills/`; las que permanezcan en `skills/` deben consultarse mediante una referencia explícita o mediante la integración que las exponga.

La carpeta `docs/` es principalmente para las personas y para consultas concretas del agente. Tener muchos documentos en el repositorio no significa que todos entren en el contexto. El coste depende de lo que se lea durante la tarea.

```text
AGENTS.md
  ↓
índice o capítulo relevante
  ↓
sección necesaria
```

Esta organización aplica Context Engineering y Progressive Disclosure: primero se descubre dónde está la información y después se carga solo la parte necesaria.

---

[← Anterior](01-personas-agentes-y-responsabilidades.md) · [Índice](../../README.md) · [Siguiente →](03-skills-compartidas.md)
