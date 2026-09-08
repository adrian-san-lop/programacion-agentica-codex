# Commands

Acciones del cliente para controlar la sesión o iniciar un procedimiento.

## Definición

Un **Command** es una acción disponible en el cliente. Puede controlar la sesión o iniciar un flujo de trabajo. Un **prompt** es la petición o instrucción que dirigimos al agente; no todos los comandos se limitan a insertar uno.

Son una funcionalidad dependiente del cliente/agente.

## Comandos de Codex en la extensión IDE

| Comando | Función |
|---|---|
| `/status` | Muestra el identificador de la conversación, uso de contexto y límites de uso |
| `/compact` | Compacta el contexto de la conversación actual |
| `/mcp` | Abre el estado de los servidores MCP conectados |

Son acciones del producto; no requieren iniciar una Skill. La lista disponible se consulta escribiendo `/` en el cuadro de mensaje. [Comandos oficiales de la extensión IDE](https://learn.chatgpt.com/docs/developer-commands?surface=ide), revisados el 2026-09-08.

## Atajos personalizados: ejemplo conceptual

Un cliente o una integración podría ofrecer un atajo como:

```text
/commit
```

podría expandirse conceptualmente a:

```text
Review the current changes.

Create a commit following Conventional Commits.

Do not include unrelated files.
```

Otros nombres ilustrativos de atajos personalizados, cuya existencia habría que comprobar:

```text
/commit
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

Un comando que inicia un procedimiento no sustituye al razonamiento del agente ni garantiza su ejecución sin validaciones o aprobaciones. Un comando de sesión puede actuar directamente sobre el cliente. Ninguno es sinónimo de Skill o Tool.

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

## Nuestra historia y comprobación

Puedes iniciar la revisión escribiendo «Analiza Sales YTD. No modifiques nada». No necesitas inventar un comando con barra para cada tarea.

**¿Un Command, una Skill y una Tool son tres nombres de lo mismo?**

No. El Command controla la sesión o inicia una acción disponible en el cliente; la Skill describe un procedimiento; la Tool ejecuta una operación. La petición en lenguaje natural también puede iniciar el trabajo.

[← Anterior](02-skills.md) · [Índice](../../README.md) · [Siguiente →](../03-tools/00-que-es-una-tool.md)

