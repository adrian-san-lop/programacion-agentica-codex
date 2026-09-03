# Programación agéntica

Documentación sobre los conceptos, componentes y patrones utilizados para diseñar agentes basados en modelos de lenguaje.

- [Roadmap y temas pendientes](ROADMAP.md)

## Ruta recomendada

1. [Qué es un agente](docs/00-introduccion/00-que-es-un-agente.md)
2. [Actores y responsabilidades](docs/00-introduccion/01-actores-y-responsabilidades.md)
3. [Conceptos que no deben confundirse](docs/00-introduccion/02-conceptos-que-no-deben-confundirse.md)
4. [Introducción a Context Engineering](docs/01-context-engineering/00-introduccion.md)
5. [Context Window y atención efectiva](docs/01-context-engineering/01-context-window.md)
6. [Static Context](docs/01-context-engineering/02-static-context.md)
7. [Dynamic Context](docs/01-context-engineering/03-dynamic-context.md)
8. [Progressive Disclosure](docs/01-context-engineering/04-progressive-disclosure.md)
9. [System Prompt](docs/02-componentes/00-system-prompt.md)
10. [AGENTS.md](docs/02-componentes/01-agents-md.md)
11. [Skills](docs/02-componentes/02-skills.md)
12. [Commands](docs/02-componentes/03-commands.md)
13. [Qué es una Tool](docs/03-tools/00-que-es-una-tool.md)
14. [Tool Calling](docs/03-tools/01-tool-calling.md)
15. [Mediación de Tools, proxies y gateways](docs/03-tools/02-mediacion-de-tools.md)
16. [Tool Definitions Upfront](docs/03-tools/03-tool-definitions-upfront.md)
17. [Tool Retrieval](docs/03-tools/04-tool-retrieval.md)
18. [Filesystem Retrieval](docs/03-tools/05-filesystem-retrieval.md)
19. [Tool Search](docs/03-tools/06-tool-search.md)
20. [MCP vs CLI](docs/03-tools/07-mcp-vs-cli.md)
21. [Estrategia híbrida](docs/03-tools/08-estrategia-hibrida.md)
22. [Guía práctica de Tools en Codex para VS Code](docs/03-tools/09-guia-practica-tools-en-codex.md)
23. [MCP — Model Context Protocol](docs/04-integraciones/00-mcp-introduccion.md)
24. [Configuración de MCP](docs/04-integraciones/01-configuracion.md)
25. [MCP y credenciales](docs/04-integraciones/02-credenciales.md)
26. [MCP vs Tool Retrieval](docs/04-integraciones/03-mcp-vs-tool-retrieval.md)
27. [Trabajo en equipo](docs/05-trabajo-en-equipo/00-introduccion.md)
28. [Personas, agentes y responsabilidades](docs/05-trabajo-en-equipo/01-personas-agentes-y-responsabilidades.md)
29. [Monorepo y documentación](docs/05-trabajo-en-equipo/02-monorepo-y-documentacion.md)
30. [Skills compartidas](docs/05-trabajo-en-equipo/03-skills-compartidas.md)
31. [Subagentes y delegación](docs/05-trabajo-en-equipo/04-subagentes-y-delegacion.md)
32. [Flujo Git y pull requests](docs/05-trabajo-en-equipo/05-flujo-git-y-pull-requests.md)
33. [Ejemplo Power BI / Fabric](docs/06-ejemplos/00-power-bi-fabric.md)

## Índice completo

### Introducción

- [Qué es un agente y Agent Loop](docs/00-introduccion/00-que-es-un-agente.md)
- [Actores y responsabilidades](docs/00-introduccion/01-actores-y-responsabilidades.md)
- [Conceptos que no deben confundirse](docs/00-introduccion/02-conceptos-que-no-deben-confundirse.md)

### Context Engineering

- [Introducción](docs/01-context-engineering/00-introduccion.md)
- [Context Window y atención efectiva](docs/01-context-engineering/01-context-window.md)
- [Static Context](docs/01-context-engineering/02-static-context.md)
- [Dynamic Context](docs/01-context-engineering/03-dynamic-context.md)
- [Progressive Disclosure](docs/01-context-engineering/04-progressive-disclosure.md)

### Componentes del agente

- [System Prompt](docs/02-componentes/00-system-prompt.md)
- [AGENTS.md](docs/02-componentes/01-agents-md.md)
- [Skills](docs/02-componentes/02-skills.md)
- [Commands](docs/02-componentes/03-commands.md)

### Qué es una Tool

- [Qué es una Tool](docs/03-tools/00-que-es-una-tool.md)
- [Tool Calling](docs/03-tools/01-tool-calling.md)
- [Mediación de Tools, proxies y gateways](docs/03-tools/02-mediacion-de-tools.md)
- [Tool Definitions Upfront](docs/03-tools/03-tool-definitions-upfront.md)
- [Tool Retrieval](docs/03-tools/04-tool-retrieval.md)
- [Filesystem Retrieval](docs/03-tools/05-filesystem-retrieval.md)
- [Tool Search](docs/03-tools/06-tool-search.md)
- [MCP vs CLI](docs/03-tools/07-mcp-vs-cli.md)
- [Estrategia híbrida](docs/03-tools/08-estrategia-hibrida.md)
- [Guía práctica de Tools en Codex para VS Code](docs/03-tools/09-guia-practica-tools-en-codex.md)

### Integraciones

- [MCP — Model Context Protocol](docs/04-integraciones/00-mcp-introduccion.md)
- [Configuración](docs/04-integraciones/01-configuracion.md)
- [Credenciales](docs/04-integraciones/02-credenciales.md)
- [MCP vs Tool Retrieval](docs/04-integraciones/03-mcp-vs-tool-retrieval.md)

### Trabajo en equipo

- [Introducción](docs/05-trabajo-en-equipo/00-introduccion.md)
- [Personas, agentes y responsabilidades](docs/05-trabajo-en-equipo/01-personas-agentes-y-responsabilidades.md)
- [Monorepo y documentación](docs/05-trabajo-en-equipo/02-monorepo-y-documentacion.md)
- [Skills compartidas](docs/05-trabajo-en-equipo/03-skills-compartidas.md)
- [Subagentes y delegación](docs/05-trabajo-en-equipo/04-subagentes-y-delegacion.md)
- [Flujo Git y pull requests](docs/05-trabajo-en-equipo/05-flujo-git-y-pull-requests.md)

### Ejemplos

- [Power BI y Fabric](docs/06-ejemplos/00-power-bi-fabric.md)

### Automatización del repositorio

- [Skill de workflow Git](skills/git-commit/SKILL.md)
- [Script seguro de commit](scripts/commit.ps1)
- [Skill de ramas de documentación](skills/git-branch/SKILL.md)
- [Script para crear ramas desde `dev`](scripts/new-branch.ps1)
- [Skill para publicar ramas en GitHub](skills/git-push/SKILL.md)
- [Script para hacer push a `origin`](scripts/push-origin.ps1)

#### Cómo utilizarlo

Cuando termines una tarea, pide a Codex que revise los cambios y prepare un commit usando la Skill `git-commit`. La Skill revisa el diff, propone un mensaje coherente y evita mezclar archivos no relacionados.

También puedes ejecutar el script directamente desde la raíz de `documentation`:

```powershell
.\scripts\commit.ps1 -Message "docs: update agentic programming documentation" -Path README.md,docs/02-componentes/03-commands.md
```

Si has comprobado que todos los cambios del `git status` pertenecen a la misma tarea, puedes usar `-All`:

```powershell
.\scripts\commit.ps1 -Message "docs: update course notes" -All
```

El script muestra el resumen staged y solicita confirmación antes de crear el commit. `-All` incluye también eliminaciones; úsalo solo después de revisar el estado.

#### Flujo de ramas

`main` contiene la versión estable, `dev` integra los cambios y cada tarea se desarrolla en una rama creada desde `dev`:

```powershell
git switch dev
git pull --ff-only
.\scripts\new-branch.ps1 -Name "docs/update-codex-guide"
```

La rama de trabajo se integra en `dev` mediante Pull Request. Después de validar `dev`, se crea otra Pull Request hacia `main`. El script exige un workspace limpio y no hace `push`, merge ni rebase automáticamente.

Después de crear el commit local, publica la rama actual con:

```powershell
.\scripts\push-origin.ps1
```

El script configura el upstream en el primer push, solicita confirmación y no crea la Pull Request. Las ramas de trabajo se publican para abrir una Pull Request hacia `dev`; la promoción posterior de `dev` a `main` se realiza mediante otra Pull Request.

## Idea central

> El objetivo del Context Engineering no es proporcionar toda la información posible, sino la información correcta, en el momento correcto y en la cantidad correcta.

## Convenciones

- Los nombres de archivo están en minúsculas y usan kebab-case.
- La numeración de carpetas y archivos indica el orden conceptual; los títulos no llevan numeración manual.
- Cada documento trata un tema concreto y enlaza con los temas relacionados.
- Los ejemplos específicos de Power BI se mantienen separados de los fundamentos generales.
- Los recursos compartidos se almacenan en `assets/`; las imágenes se organizan por área dentro de `assets/images/`.
