---
name: git-branch
description: Creates isolated documentation branches in Codex. Use when starting documentation work that must branch from dev instead of main.
---

# Git branch workflow

Use this Skill when modifying documentation and isolating the work from `main`.

## Workflow

1. Check `git status --short` and `git branch --show-current`.
2. Stop if the workspace is dirty or a Git operation is in progress.
3. Ensure local `dev` exists and is up to date.
4. Use a descriptive name:

   ```text
   docs/<description>
   fix/<description>
   chore/<description>
   ```

5. Run the script:

   ```powershell
   .\scripts\new-branch.ps1 -Name "docs/update-codex-guide"
   ```

6. Confirm the active branch and clean status before starting work.

## Policy

- `main`: stable documentation.
- `dev`: integration branch.
- Work branches always start from `dev` and return to `dev` through a pull request.
- Promote `dev` to `main` through a separate pull request.
- Do not push, merge, rebase, stash, or delete branches automatically.
- Use `hotfix/<description>` from `main` only for urgent fixes.
