---
name: git-branch
description: Creates work branches for documentation changes in Codex. Always uses dev as the base and follows the stable main -> integration dev -> task branch flow.
---

# Git branch workflow

Use this Skill when modifying documentation and isolating the work from `main`.

## Workflow

1. Check `git status --short` and `git branch --show-current`.
2. Do not create the branch if the workspace has changes, untracked files, or an operation in progress.
3. Verify that the local `dev` branch exists and is the approved base.
4. Use a descriptive name:

   ```text
   docs/<descripcion>
   fix/<descripcion>
   chore/<descripcion>
   ```

5. Run the script:

   ```powershell
   .\scripts\new-branch.ps1 -Name "docs/update-codex-guide"
   ```

6. Confirm the active branch and clean status before starting work.

## Policy

- `main`: stable version.
- `dev`: integration branch.
- Work branches always start from `dev` and return to `dev` through a pull request.
- The promotion from `dev` to `main` uses a separate pull request.
- Do not push, merge, rebase, stash, or delete branches automatically.
- Do not branch from `main` except for an urgent `hotfix/<description>`.
