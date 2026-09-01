# Programación agéntica

Documentación sobre los conceptos, componentes y patrones utilizados para diseñar agentes basados en modelos de lenguaje.

## Ruta recomendada

1. [Qué es un agente](docs/00-introduccion/que-es-un-agente.md)
2. [Actores y responsabilidades](docs/00-introduccion/actores-y-responsabilidades.md)
3. [Context Engineering](docs/01-context-engineering/introduccion.md)
4. [Componentes del agente](docs/02-componentes/system-prompt.md)
5. [Tools y Tool Calling](docs/03-tools/que-es-una-tool.md)
6. [Mediación, Upfront, Retrieval y estrategia híbrida](docs/03-tools/mediacion-de-tools.md)
7. [MCP e integraciones](docs/04-integraciones/mcp-introduccion.md)
8. [Ejemplo Power BI / Fabric](docs/05-ejemplos/power-bi-fabric.md)

## Índice completo

### Introducción

- [Qué es un agente y Agent Loop](docs/00-introduccion/que-es-un-agente.md)
- [Actores y responsabilidades](docs/00-introduccion/actores-y-responsabilidades.md)

### Context Engineering

- [Introducción](docs/01-context-engineering/introduccion.md)
- [Context Window y atención efectiva](docs/01-context-engineering/context-window.md)
- [Static Context](docs/01-context-engineering/static-context.md)
- [Dynamic Context](docs/01-context-engineering/dynamic-context.md)
- [Progressive Disclosure](docs/01-context-engineering/progressive-disclosure.md)

### Componentes del agente

- [System Prompt](docs/02-componentes/system-prompt.md)
- [AGENTS.md](docs/02-componentes/agents-md.md)
- [Skills](docs/02-componentes/skills.md)
- [Commands](docs/02-componentes/commands.md)

### Tools

- [Qué es una Tool](docs/03-tools/que-es-una-tool.md)
- [Tool Calling](docs/03-tools/tool-calling.md)
- [Mediación de Tools, proxies y gateways](docs/03-tools/mediacion-de-tools.md)
- [Tool Definitions Upfront](docs/03-tools/tool-definitions-upfront.md)
- [Tool Retrieval](docs/03-tools/tool-retrieval.md)
- [Filesystem Retrieval](docs/03-tools/filesystem-retrieval.md)
- [Tool Search](docs/03-tools/tool-search.md)
- [MCP vs CLI](docs/03-tools/mcp-vs-cli.md)
- [Estrategia híbrida](docs/03-tools/estrategia-hibrida.md)

### Integraciones

- [MCP — Model Context Protocol](docs/04-integraciones/mcp-introduccion.md)
- [Configuración](docs/04-integraciones/configuracion.md)
- [Credenciales](docs/04-integraciones/credenciales.md)
- [MCP vs Tool Retrieval](docs/04-integraciones/mcp-vs-tool-retrieval.md)

### Ejemplos

- [Power BI y Fabric](docs/05-ejemplos/power-bi-fabric.md)

### Automatización del repositorio

- [Skill de workflow Git](skills/git-commit/SKILL.md)
- [Script seguro de commit](scripts/commit.ps1)

#### Cómo utilizarlo

Cuando termines una tarea, pide a Codex que revise los cambios y prepare un commit usando la Skill `git-commit`. La Skill revisa el diff, propone un mensaje coherente y evita mezclar archivos no relacionados.

También puedes ejecutar el script directamente desde la raíz de `documentation`:

```powershell
.\scripts\commit.ps1 -Message "docs: update agentic programming documentation" -Path README.md,docs/02-componentes/commands.md
```

Si has comprobado que todos los cambios del `git status` pertenecen a la misma tarea, puedes usar `-All`:

```powershell
.\scripts\commit.ps1 -Message "docs: update course notes" -All
```

El script muestra el resumen staged y solicita confirmación antes de crear el commit. `-All` incluye también eliminaciones; úsalo solo después de revisar el estado.

## Idea central

> El objetivo del Context Engineering no es proporcionar toda la información posible, sino la información correcta, en el momento correcto y en la cantidad correcta.

## Convenciones

- Los nombres de archivo están en minúsculas y usan kebab-case.
- La numeración de carpetas indica el orden conceptual; los títulos no llevan numeración manual.
- Cada documento trata un tema concreto y enlaza con los temas relacionados.
- Los ejemplos específicos de Power BI se mantienen separados de los fundamentos generales.
