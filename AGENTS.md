# Agentic Programming Documentation

## Purpose

Maintain beginner-friendly documentation about agentic programming with the Codex extension for VS Code, using Power BI and Fabric as practical context.

The learning environment is the Codex extension for VS Code, authenticated through a ChatGPT Business subscription. Exclude OpenAI API documentation, examples, parameters, endpoints, pricing and links, including comparisons and optional appendices.

Teach an experienced data scientist and Power BI practitioner with no agentic background to understand, guide and evaluate Codex. Do not teach how to build a replacement runtime or optimize hidden infrastructure.

Prioritize conceptual understanding now. Use a shared read-only Sales YTD review story; introduce actual Power BI/Fabric practice only when the course reaches that phase. Preserve provisional notes as capture material, not authoritative content.

## Navigation and progressive disclosure

-  `README.md` only for humans. Do not use this file for progressive disclosure and/or navigation.
- For a focused question, use the smallest relevant path below; do not read all of `docs/`.
- Read the target document first and follow links only when they are needed.
- Treat `docs/notes.txt` as provisional notes, not course content.

| Topic | Starting path |
|---|---|
| Agent Loop and core terms | `docs/00-introduccion/00-que-es-un-agente.md` |
| LLM, runtime, Tool, Skill or MCP differences | `docs/00-introduccion/02-conceptos-que-no-deben-confundirse.md` |
| Context and context rot | `docs/01-context-engineering/00-introduccion.md` |
| Progressive Disclosure or retrieval | `docs/01-context-engineering/04-progressive-disclosure.md` |
| System Prompt, `AGENTS.md`, Skills and Commands | `docs/02-componentes/00-system-prompt.md` |
| Tools, retrieval and Tool Calling | `docs/03-tools/00-que-es-una-tool.md` |
| Codex subscription behavior | `docs/03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md` |
| MCP and integrations | `docs/04-integraciones/00-mcp-introduccion.md` |
| Collaboration and subagents | `docs/05-trabajo-en-equipo/00-introduccion.md` |
| Power BI and Fabric | `docs/06-ejemplos/01-power-bi-fabric.md` |

When answering, define unfamiliar terms, cite the files consulted, and distinguish general patterns, Codex behavior, observations and inferences. Do not modify files unless explicitly asked.

## Editing rules

1. Keep explanations simple, progressive, and introduce terms before using them.
2. Preserve the order and pagination links in the recommended route.
3. Distinguish model, runtime, agent, Tool, Skill, MCP, and CLI.
4. Do not present Cursor or Claude Code behavior as Codex behavior without verification.
5. Verify current Codex/OpenAI behavior against authoritative sources when documentation depends on product features that may change.
6. Validate local links and runnable examples after changes.
7. Keep Skills and operational instructions concise.
8. Persist important project knowledge and decisions in repository files rather than relying only on conversation context.
9. Separate essential reading from optional mechanisms. Add short comprehension checks with answers and distinguish observable evidence from inference.

## Git workflow

- Work from `dev` in a task branch.
- Before starting a new task, create a task branch from `dev` using the `git-branch` skill.
- Review changes before committing.
- Target task-branch pull requests at `dev`; promote `dev` to `main` separately.
