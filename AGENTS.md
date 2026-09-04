# Agentic Programming Documentation

## Purpose

Maintain beginner-friendly documentation about agentic programming with the Codex extension for VS Code, using Power BI and Fabric as practical context.

This course explores Codex through a ChatGPT subscription. We do not use the OpenAI API as a hands-on environment; the API is only mentioned for comparison when it helps distinguish a general agentic pattern from a Codex-specific capability.

This documentation is not about the OpenAI API, ChatGPT SDKs, or application development with OpenAI APIs. Its purpose is to teach the fundamentals of agentic programming and put them into practice using Codex in VS Code.

The documentation should enable a complete beginner to understand the core concepts and progressively build a small practical example using what has been learned.

## Navigation

- Start with `README.md` and follow its recommended route.
- Use `docs/` for conceptual explanations.
- Use `skills/` for reusable repository skills, including Git workflow tasks.
- Use `docs/notes.txt` as working notes; do not treat it as finished documentation.
- Use `examples/` for runnable examples.
- Use `Practical Example-PBIP/` for the Power BI project template.

## Progressive disclosure for questions

Use this repository as a guided learning workspace. Do not read every document for a focused question.

1. Identify the user's topic.
2. Start with the matching entry in the topic map below.
3. Read only the relevant sections of that document.
4. Follow links to related documents only when the first source is insufficient.
5. Summarize the answer before adding optional background.

### Topic map

| User asks about... | Start here |
|---|---|
| Agent or Agent Loop | `docs/00-introduccion/00-que-es-un-agente.md` |
| LLM, runtime, agent, Tool, Skill or MCP differences | `docs/00-introduccion/02-conceptos-que-no-deben-confundirse.md` |
| Context, context window or context rot | `docs/01-context-engineering/` |
| Progressive Disclosure or retrieval | `docs/01-context-engineering/04-progressive-disclosure.md` |
| System Prompt, `AGENTS.md`, Skills or Commands | `docs/02-componentes/` |
| Tools or Tool Calling | `docs/03-tools/` |
| Codex subscription behavior | `docs/03-tools/10-codex-suscripcion-contexto-y-tool-retrieval.md` |
| MCP | `docs/04-integraciones/` |
| Collaboration, subagents or Git | `docs/05-trabajo-en-equipo/` |
| Power BI or Fabric | `docs/06-ejemplos/01-power-bi-fabric.md` |

The topic map is a routing aid, not a replacement for the full course route in `README.md`.

## Response rules for learners

- Explain concepts progressively and define a term before using it extensively.
- Prefer the smallest set of files that answers the question.
- Mention which repository documents support the answer.
- Distinguish general agentic patterns, Codex behavior, and OpenAI API comparisons.
- Treat product behavior as version-dependent and identify facts, local observations, and inferences separately.
- Treat `docs/notes.txt` as provisional working material, not authoritative course content.
- Do not modify files unless the user explicitly asks for a change.

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
