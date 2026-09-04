# Flujo Git y pull requests

El repositorio permite colaborar sin cargar todo el trabajo sobre `main`.

```text
dev
  ↓
rama de trabajo
  ↓
commit
  ↓
push
  ↓
pull request hacia dev
  ↓
pull request de dev hacia main
```

En este proyecto:

- `main` contiene la documentación estable.
- `dev` integra cambios revisados.
- Las ramas de trabajo parten de `dev`.
- Las Skills `git-branch`, `git-commit` y `git-push` ayudan a aplicar el procedimiento.
- Las pull requests siguen siendo revisadas y creadas por la persona responsable.

Este flujo conecta la colaboración humana con el trabajo del agente: Codex puede inspeccionar archivos y ejecutar comandos CLI, pero el equipo decide qué cambios aceptar y cuándo promoverlos.

---

[← Anterior](04-subagentes-y-delegacion.md) · [Índice](../../README.md) · [Siguiente →](../06-ejemplos/00-agent-loop-minimo.md)
