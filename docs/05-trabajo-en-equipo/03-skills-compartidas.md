# Skills compartidas

Una Skill contiene instrucciones y un workflow reutilizable. No es necesario convertir toda la documentación en Skills.

```text
Concepto o referencia → docs/
Workflow repetible    → Skill
Regla del proyecto    → AGENTS.md
Acción breve           → Command
```

Para decidir dónde mantener una Skill:

```text
Skill específica del proyecto
→ dentro del repositorio

Skill reutilizable en varios proyectos
→ repositorio independiente
```

Las Skills del proyecto se benefician del mismo control de cambios que la documentación: rama de trabajo, revisión y pull request. Una Skill externa debe versionarse y mantenerse en su propio repositorio.

Separar Skills demasiado pronto puede añadir sincronización y mantenimiento innecesarios. Los submódulos Git también introducen coordinación adicional, por lo que solo convienen cuando la separación es realmente necesaria.

---

[← Anterior](02-monorepo-y-documentacion.md) · [Índice](../../README.md) · [Siguiente →](04-subagentes-y-delegacion.md)
