---
name: git-branch
description: Creates isolated documentation branches in Codex from dev. Use when starting documentation work that must stay separate from main.
---

# Git branch workflow

1. Check `git status --short` and `git branch --show-current`.
2. Stop if the workspace is dirty or a Git operation is in progress.
3. Verify that local `dev` exists and is current.
4. Use `docs/<description>`, `fix/<description>`, or `chore/<description>`.
5. Run:

   ```powershell
   ./scripts/new-branch.ps1 -Name "docs/update-codex-guide"
   ```

6. Confirm the active branch and clean status.

## Branch policy

- `main`: stable documentation.
- `dev`: integration branch.
- Work branches start from `dev` and target `dev` through a pull request.
- Promote `dev` to `main` through a separate pull request.
- Do not push, merge, rebase, stash, or delete branches automatically.
- Use `hotfix/<description>` from `main` only for urgent fixes.
