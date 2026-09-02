---
name: git-push
description: Publishes the current Git branch to GitHub origin. Use after committing a task branch when the user asks to push changes or prepare a pull request.
---

# Git push workflow

Use this Skill after a local commit is ready to publish.

1. Check `git status --short` and `git branch --show-current`.
2. Stop if the workspace is dirty, the branch is detached, or a Git operation is in progress.
3. Verify the `origin` remote and the current branch.
4. Do not push `main` or `dev` unless the user explicitly authorizes it.
5. Run the script:

   ```powershell
   .\scripts\push-origin.ps1
   ```

6. Confirm the remote branch and report the pull request target: work branches target `dev`.

## Policy

- Never force-push.
- Never push uncommitted changes.
- Never create a pull request automatically.
- Push task branches with their current name and set upstream on first push.
- Promote changes through `task branch -> dev -> main` pull requests.
