# Programación agéntica

Documentación para entender cómo funciona un agente, orientar su trabajo y evaluar sus resultados utilizando Codex en VS Code.

- [Roadmap y temas pendientes](ROADMAP.md)

`AGENTS.md` contiene las instrucciones de navegación que utiliza Codex al trabajar en este repositorio.

## Alcance del curso

El objetivo es que un data scientist con experiencia en programación y Power BI, pero sin conocimientos de programación agéntica, aprenda a comprender, orientar y supervisar un agente.

Trabajamos con la extensión de Codex para VS Code y una suscripción de ChatGPT Business. Quedan fuera la documentación, los ejemplos y las referencias de la API de OpenAI. No construimos nuestro propio runtime.

La fase actual es conceptual. Power BI y Fabric proporcionan ejemplos familiares; no necesitas tener una integración funcionando. El ejemplo Python y la plantilla PBIP son materiales para después, no requisitos para entender los fundamentos.

## Ruta recomendada

La numeración y los enlaces conservan el recorrido completo. En una primera lectura:

- **Esencial:** introducción, contexto y recuperación, componentes, Tools y sus límites, MCP, seguridad, fundamentos de hooks y responsabilidad humana.
- **Ampliación opcional:** caching, mediación, definiciones upfront, Tool Search y estrategia híbrida. Sus capítulos indican qué idea conservar sin estudiar infraestructura.
- **Fase posterior:** ejecutar la simulación Python y aplicar la plantilla PBIP cuando el curso llegue a la práctica.

La misma historia une los bloques: «Analiza la medida Sales YTD y explica si hay algún problema. No modifiques nada». Lee las preguntas de comprobación y sus respuestas antes de continuar.

Los bloques con prefijo `04` se leen en este orden: integraciones → seguridad y hooks → trabajo en equipo (`05`). Conservamos las rutas anteriores; los enlaces de navegación recogen esta ampliación. La configuración real de hooks y el estudio de contenedores quedan para una fase posterior.

### Recorrido completo

1. [Qué es un agente](docs/00-introduccion/00-que-es-un-agente.md)
2. [Actores y responsabilidades](docs/00-introduccion/01-actores-y-responsabilidades.md)
3. [Conceptos que no deben confundirse](docs/00-introduccion/02-conceptos-que-no-deben-confundirse.md)
4. [Introducción a Context Engineering](docs/01-context-engineering/00-introduccion.md)
5. [Context Window y atención efectiva](docs/01-context-engineering/01-context-window.md)
6. [Static Context](docs/01-context-engineering/02-static-context.md)
7. [Dynamic Context](docs/01-context-engineering/03-dynamic-context.md)
8. [Progressive Disclosure](docs/01-context-engineering/04-progressive-disclosure.md)
9. [Costes básicos de LLM](docs/01-context-engineering/05-costes-basicos-de-llm.md)
10. [Prompt Caching](docs/01-context-engineering/06-prompt-caching.md)
11. [Contexto y recuperación en profundidad](docs/01-context-engineering/07-recuperacion-profunda.md)
12. [Compactación de contexto en Codex](docs/01-context-engineering/08-compactacion-de-contexto-en-codex.md)
13. [System Prompt](docs/02-componentes/00-system-prompt.md)
14. [AGENTS.md](docs/02-componentes/01-agents-md.md)
15. [Skills](docs/02-componentes/02-skills.md)
16. [Commands](docs/02-componentes/03-commands.md)
17. [Qué es una Tool](docs/03-tools/00-que-es-una-tool.md)
18. [Tool Calling](docs/03-tools/01-tool-calling.md)
19. [Mediación de Tools, proxies y gateways](docs/03-tools/02-mediacion-de-tools.md)
20. [Tool Definitions Upfront](docs/03-tools/03-tool-definitions-upfront.md)
21. [Tool Retrieval](docs/03-tools/04-tool-retrieval.md)
22. [Filesystem Retrieval](docs/03-tools/05-filesystem-retrieval.md)
23. [Tool Search](docs/03-tools/06-tool-search.md)
24. [MCP vs CLI](docs/03-tools/07-mcp-vs-cli.md)
25. [Estrategia híbrida](docs/03-tools/08-estrategia-hibrida.md)
26. [Guía práctica de Tools en Codex para VS Code](docs/03-tools/09-guia-practica-tools-en-codex.md)
27. [Contexto y Tool Retrieval en Codex mediante suscripción](docs/03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md)
28. [MCP — Model Context Protocol](docs/04-integraciones/00-mcp-introduccion.md)
29. [Configuración de MCP](docs/04-integraciones/01-configuracion.md)
30. [MCP y credenciales](docs/04-integraciones/02-credenciales.md)
31. [MCP vs Tool Retrieval](docs/04-integraciones/03-mcp-vs-tool-retrieval.md)
32. [Seguridad en el Agent Loop](docs/04-seguridad-y-hooks/00-seguridad-en-el-agent-loop.md)
33. [Permisos, sandbox y secretos](docs/04-seguridad-y-hooks/01-permisos-sandbox-y-secretos.md)
34. [Hooks en Codex](docs/04-seguridad-y-hooks/02-hooks-en-codex.md)
35. [Caso guiado: Sales YTD con controles](docs/04-seguridad-y-hooks/03-caso-guiado-sales-ytd.md)
36. [Trabajo en equipo](docs/05-trabajo-en-equipo/00-introduccion.md)
37. [Personas, agentes y responsabilidades](docs/05-trabajo-en-equipo/01-personas-agentes-y-responsabilidades.md)
38. [Monorepo y documentación](docs/05-trabajo-en-equipo/02-monorepo-y-documentacion.md)
39. [Skills compartidas](docs/05-trabajo-en-equipo/03-skills-compartidas.md)
40. [Subagentes y delegación](docs/05-trabajo-en-equipo/04-subagentes-y-delegacion.md)
41. [Flujo Git y pull requests](docs/05-trabajo-en-equipo/05-flujo-git-y-pull-requests.md)
42. [Ejemplo mínimo de Agent Loop](docs/06-ejemplos/00-agent-loop-minimo.md)
43. [Ejemplo Power BI / Fabric](docs/06-ejemplos/01-power-bi-fabric.md)

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
- [Costes básicos de LLM](docs/01-context-engineering/05-costes-basicos-de-llm.md)
- [Prompt Caching](docs/01-context-engineering/06-prompt-caching.md)
- [Contexto y recuperación en profundidad](docs/01-context-engineering/07-recuperacion-profunda.md)
- [Compactación de contexto en Codex](docs/01-context-engineering/08-compactacion-de-contexto-en-codex.md)

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
- [Contexto y Tool Retrieval en Codex mediante suscripción](docs/03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md)

### Integraciones

- [MCP — Model Context Protocol](docs/04-integraciones/00-mcp-introduccion.md)
- [Configuración](docs/04-integraciones/01-configuracion.md)
- [Credenciales](docs/04-integraciones/02-credenciales.md)
- [MCP vs Tool Retrieval](docs/04-integraciones/03-mcp-vs-tool-retrieval.md)

### Seguridad y hooks

- [Seguridad en el Agent Loop](docs/04-seguridad-y-hooks/00-seguridad-en-el-agent-loop.md)
- [Permisos, sandbox y secretos](docs/04-seguridad-y-hooks/01-permisos-sandbox-y-secretos.md)
- [Hooks en Codex](docs/04-seguridad-y-hooks/02-hooks-en-codex.md)
- [Caso guiado: Sales YTD con controles](docs/04-seguridad-y-hooks/03-caso-guiado-sales-ytd.md)

### Trabajo en equipo

- [Introducción](docs/05-trabajo-en-equipo/00-introduccion.md)
- [Personas, agentes y responsabilidades](docs/05-trabajo-en-equipo/01-personas-agentes-y-responsabilidades.md)
- [Monorepo y documentación](docs/05-trabajo-en-equipo/02-monorepo-y-documentacion.md)
- [Skills compartidas](docs/05-trabajo-en-equipo/03-skills-compartidas.md)
- [Subagentes y delegación](docs/05-trabajo-en-equipo/04-subagentes-y-delegacion.md)
- [Flujo Git y pull requests](docs/05-trabajo-en-equipo/05-flujo-git-y-pull-requests.md)

### Ejemplos

- [Ejemplo mínimo de Agent Loop](docs/06-ejemplos/00-agent-loop-minimo.md)
- [Power BI y Fabric](docs/06-ejemplos/01-power-bi-fabric.md)
- [Plantilla práctica para un proyecto PBIP](<Practical Example-PBIP/README.md>)

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
