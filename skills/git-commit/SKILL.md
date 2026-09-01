---
name: git-commit
description: Safely reviews and commits repository changes using Conventional Commits. Use when the user asks to review changes, prepare a commit, or create a local Git commit.
---

# Git commit workflow

1. Inspect the repository:

   ```powershell
   git status --short
   git branch --show-current
   git diff
   git diff --cached
   ```

2. Commit only one logical change. Exclude unrelated, generated, or potentially sensitive files.

3. Run:

   ```powershell
   git diff --check
   ```

   Do not commit if validation fails.

4. Generate a Conventional Commit message:

   ```text
   type(scope): description
   ```

   Prefer `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, or `perf`.

5. Before committing, verify the exact files to include and summarize them to the user.

6. Use the repository script for staging and committing:

   ```powershell
   .\scripts\commit.ps1 -Message "<message>" -Path <paths>
   ```

   Use `-All` only when the user explicitly approves all current changes.

7. After committing, run:

   ```powershell
   git status --short
   git log -1 --oneline
   ```

## Safety

- Never commit secrets or credentials.
- Never blindly use `git add .`.
- Never mix unrelated changes.
- Never use `--no-verify`, `--amend`, history rewriting, force push, or destructive Git commands unless explicitly requested.
- Do not create or switch branches, push, merge, rebase, or create pull requests in this Skill.
- If the repository is in the middle of a merge, rebase, or cherry-pick, stop and report it.
- If direct commits are forbidden on the current branch, stop and report it.

`SKILL.md` defines the workflow and safety criteria. `scripts/commit.ps1` performs the mechanical staging and commit operations.