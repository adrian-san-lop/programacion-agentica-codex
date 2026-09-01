---
name: git-commit
description: Reviews, selects, and commits repository changes using a consistent Conventional Commits message.
---

# Git commit workflow

Use this Skill when the user asks to review changes, prepare a commit, or automate the `status -> add -> commit` workflow.

## Required workflow

1. Run `git status --short` and review the diff, including both unstaged and staged changes.

2. Separate unrelated changes. Do not include secrets, generated files, or user changes that do not belong to the task.

3. Run `git diff --check` and fix any errors before committing.

4. Propose a short message using the Conventional Commits format:

   `type(scope): description`

   Common types: `feat`, `fix`, `docs`, `refactor`, `test`, and `chore`.

5. Use the repository script to select the files and create the commit:

   ```powershell
   .\scripts\commit.ps1 -Message "docs: update agentic programming documentation" -Path README.md,docs/02-componentes/commands.md
   ```

   To include all changes visible in `status`, only if the user has explicitly approved it:

   ```powershell
   .\scripts\commit.ps1 -Message "docs: update course notes" -All
   ```

6. Before committing, show a summary of the staged files and ask for confirmation if the user has not explicitly requested the commit to be created.

7. After the commit, run `git status --short` and report the commit hash or the first line of the commit.

## Safety rules

- Do not use `git add .` blindly. The script requires explicit paths or the deliberate `-All` option.

- Do not use `git commit --no-verify`, `--amend`, or history rewriting unless explicitly requested.

- Do not mix changes from multiple tasks in the same commit.

- If the user cancels, clearly state what remains staged so they can review or undo it manually.

This Skill defines the workflow criteria; `scripts/commit.ps1` performs the mechanical Git operations.