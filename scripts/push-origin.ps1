[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [switch]$AllowProtectedBranch
)

$ErrorActionPreference = 'Stop'

function Invoke-Git {
    param([string[]]$Arguments)

    & git @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Git exited with code ${LASTEXITCODE}: git $($Arguments -join ' ')"
    }
}

$repoRoot = (& git rev-parse --show-toplevel 2>$null).Trim()
if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($repoRoot)) {
    throw 'The current directory is not inside a Git repository.'
}

$status = @(& git -C $repoRoot status --porcelain)
if ($LASTEXITCODE -ne 0) { throw 'Could not read the repository status.' }
if ($status.Count -gt 0) {
    throw 'The workspace is not clean. Commit or resolve all changes before pushing.'
}

if ((Test-Path (Join-Path $repoRoot '.git/MERGE_HEAD')) -or
    (Test-Path (Join-Path $repoRoot '.git/CHERRY_PICK_HEAD')) -or
    (Test-Path (Join-Path $repoRoot '.git/rebase-merge')) -or
    (Test-Path (Join-Path $repoRoot '.git/rebase-apply'))) {
    throw 'A Git operation is in progress. Finish it before pushing.'
}

$branch = (& git -C $repoRoot branch --show-current).Trim()
if ([string]::IsNullOrWhiteSpace($branch)) {
    throw 'The repository is in detached HEAD state.'
}
if (($branch -in @('main', 'dev')) -and -not $AllowProtectedBranch) {
    throw "Protected branch '$branch'. Re-run with -AllowProtectedBranch only when explicitly authorized."
}

& git -C $repoRoot remote get-url origin *> $null
if ($LASTEXITCODE -ne 0) { throw 'The remote origin is not configured.' }

$upstream = (& git -C $repoRoot rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>$null).Trim()
Write-Host "Branch: $branch"
Write-Host 'Remote: origin'
if ([string]::IsNullOrWhiteSpace($upstream)) {
    Write-Host "First push: origin/$branch"
    $pushArguments = @('-C', $repoRoot, 'push', '--set-upstream', 'origin', $branch)
} else {
    Write-Host "Upstream: $upstream"
    $pushArguments = @('-C', $repoRoot, 'push')
}

$confirmation = Read-Host "Push '$branch' to origin? [y/N]"
if ($confirmation -notmatch '^[yY]$') {
    Write-Warning 'Push cancelled.'
    exit 0
}

Invoke-Git -Arguments $pushArguments
Write-Host 'Final status:'
& git -C $repoRoot status --short
Write-Host 'Published branch:'
& git -C $repoRoot branch -vv | Select-String "^\*"
