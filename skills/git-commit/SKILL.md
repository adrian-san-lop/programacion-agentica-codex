---
name: git-commit
description: Reviews and commits one logical change using Conventional Commits. Use when the user asks to review changes, prepare a commit, or create a local commit.
---

# Git commit workflow

1. Run `git status --short`, `git branch --show-current`, `git diff`, and `git diff --cached`.
2. Exclude unrelated, generated, sensitive, and untracked files that do not belong to the task.
3. Run `git diff --check`; stop if validation fails.
4. Use `type(scope): description` with a concise message.
5. Verify the exact files and summarize them before committing.
6. Run the repository script:

   ```powershell
   ./scripts/commit.ps1 -Message "docs: update guide" -Path docs/guide.md
   ```

   Use `-All` only after the user explicitly approves all current changes.
7. Afterward, run `git status --short` and `git log -1 --oneline`.

## Safety

- Never commit secrets or unrelated changes.
- Never use `git add .` blindly.
- Never use `--no-verify`, `--amend`, force push, or history rewriting unless explicitly requested.
- Do not create branches, push, merge, rebase, or delete branches.
- Stop during a merge, rebase, or cherry-pick.
