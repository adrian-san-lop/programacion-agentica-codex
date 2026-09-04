# Agentic Programming Documentation

## Purpose

Maintain beginner-friendly documentation about agentic programming with the Codex extension for VS Code, using Power BI and Fabric as practical context.

This course explores Codex through a ChatGPT subscription. We do not use the OpenAI API as a hands-on environment; the API is only mentioned for comparison when it helps distinguish a general agentic pattern from a Codex-specific capability.

This documentation is not about the OpenAI API, ChatGPT SDKs, or application development with OpenAI APIs. Its purpose is to teach the fundamentals of agentic programming and put them into practice using Codex in VS Code.

The documentation should enable a complete beginner to understand the core concepts and progressively build a small practical example using what has been learned.

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

When answering, define unfamiliar terms, cite the files consulted, and distinguish general patterns, Codex behavior, API comparisons, observations and inferences. Do not modify files unless explicitly asked.

## Editing rules

1. Keep explanations simple, progressive, and introduce terms before using them.
2. Preserve the order and pagination links in the recommended route.
3. Distinguish model, runtime, agent, Tool, Skill, MCP, and CLI.
4. Do not present Cursor or Claude Code behavior as Codex behavior without verification.
5. Verify current Codex/OpenAI behavior against authoritative sources when documentation depends on product features that may change.
6. Validate local links and runnable examples after changes.
7. Keep Skills and operational instructions concise.
8. Persist important project knowledge and decisions in repository files rather than relying only on conversation context.

## Git workflow

- Work from `dev` in a task branch.
- Before starting a new task, create a task branch from `dev` using the `git-branch` skill.
- Review changes before committing.
- Target task-branch pull requests at `dev`; promote `dev` to `main` separately.
