[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Name
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
    throw 'The workspace is not clean. Save or commit changes before creating a branch.'
}

if ((Test-Path (Join-Path $repoRoot '.git/MERGE_HEAD')) -or
    (Test-Path (Join-Path $repoRoot '.git/CHERRY_PICK_HEAD')) -or
    (Test-Path (Join-Path $repoRoot '.git/rebase-merge')) -or
    (Test-Path (Join-Path $repoRoot '.git/rebase-apply'))) {
    throw 'A Git operation is in progress. Finish it before creating a branch.'
}

& git -C $repoRoot check-ref-format --branch $Name *> $null
if ($LASTEXITCODE -ne 0) { throw "Invalid branch name: $Name" }
if ($Name -in @('main', 'dev')) { throw 'main and dev cannot be used as work branch names.' }

& git -C $repoRoot show-ref --verify --quiet 'refs/heads/dev'
if ($LASTEXITCODE -ne 0) { throw 'The local dev branch does not exist. Create it from main first.' }

& git -C $repoRoot show-ref --verify --quiet "refs/heads/$Name"
if ($LASTEXITCODE -eq 0) { throw "Branch already exists: $Name" }

Write-Host "Base branch: dev"
Write-Host "New branch: $Name"
Invoke-Git -Arguments @('-C', $repoRoot, 'switch', '--create', $Name, 'dev')

Write-Host 'Final status:'
& git -C $repoRoot status --short
Write-Host 'Active branch:'
& git -C $repoRoot branch --show-current
