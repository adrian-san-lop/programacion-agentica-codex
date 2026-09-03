# Agentic Programming Documentation

## Purpose

Maintain beginner-friendly documentation about agentic programming with Codex in VS Code, using Power BI and Fabric as practical context.

The documentation should enable a complete beginner to understand the core concepts and progressively build a small practical example using what has been learned.

## Navigation

- Start with `README.md` and follow its recommended route.
- Use `docs/` for conceptual explanations.
- Use `docs/notes.txt` as working notes; do not treat it as finished documentation.
- Use `examples/` for runnable examples.
- Use `Practical Example-PBIP/` for the Power BI project template.

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
- Review changes before committing.
- Target task-branch pull requests at `dev`; promote `dev` to `main` separately.