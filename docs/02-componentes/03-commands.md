# Commands

Atajos reutilizables para lanzar prompts o workflows predefinidos.

## Definición

Los **Commands** son atajos reutilizables que permiten lanzar prompts o workflows predefinidos.

Son una funcionalidad dependiente del cliente/agente.

Por ejemplo:

```text
/commit
```

podría expandirse conceptualmente a:

```text
Review the current changes.

Create a commit following Conventional Commits.

Do not include unrelated files.
```

Otros ejemplos:

```text
/commit
/review
/test
/deploy
```

Esto evita tener que escribir repetidamente el mismo prompt.

IMPORTANTE:

```text
Commands
≠
estándar universal
```

Cada agente o herramienta puede implementarlos de forma diferente.

## Workflow Git del repositorio

En este repositorio, el flujo repetitivo de revisar cambios, seleccionar archivos y crear un commit está separado en dos piezas:

- La [Skill `git-commit`](../../skills/git-commit/SKILL.md) contiene el criterio que debe seguir Codex: revisar el diff, detectar cambios no relacionados y proponer un mensaje de Conventional Commits.
- El [script `scripts/commit.ps1`](../../scripts/commit.ps1) ejecuta las operaciones mecánicas de Git y pide confirmación antes del commit.

Desde la raíz del repositorio se puede ejecutar así:

```powershell
.\scripts\commit.ps1 -Message "docs: update commands documentation" -Path docs/02-componentes/03-commands.md
```

La opción `-All` equivale a seleccionar todos los cambios actuales, incluidas las eliminaciones, y requiere revisar antes el `git status`:

```powershell
.\scripts\commit.ps1 -Message "docs: update documentation" -All
```

No se asume que `/commit` exista como comando slash universal en Codex. La forma portable es pedir explícitamente a Codex que use la Skill o ejecutar el script. Así el conocimiento del proceso y la ejecución quedan documentados y versionados en el propio repositorio.

---

[← Anterior](02-skills.md) · [Índice](../../README.md) · [Siguiente →](../03-tools/00-que-es-una-tool.md)

