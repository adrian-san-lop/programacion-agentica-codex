[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Message,

    [Parameter(Mandatory = $false)]
    [string[]]$Path = @(),

    [Parameter(Mandatory = $false)]
    [switch]$All
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

Write-Host "Repository: $repoRoot"
Write-Host "Initial status:"
& git -C $repoRoot status --short
if ($LASTEXITCODE -ne 0) { throw 'Could not read the repository status.' }

& git -C $repoRoot diff --check
if ($LASTEXITCODE -ne 0) { throw 'El diff contiene errores de whitespace. Corrígelos antes de continuar.' }

if ($All -and $Path.Count -gt 0) {
    throw 'Use -All or -Path, but not both.'
}
if (-not $All -and $Path.Count -eq 0) {
    throw 'Provide at least one path with -Path or explicitly select all changes with -All.'
}

if ($All) {
    Invoke-Git -Arguments @('-C', $repoRoot, 'add', '-A')
} else {
    Invoke-Git -Arguments (@('-C', $repoRoot, 'add', '--') + $Path)
}

& git -C $repoRoot diff --cached --check
if ($LASTEXITCODE -ne 0) { throw 'Staged changes contain whitespace errors.' }

& git -C $repoRoot diff --cached --quiet
if ($LASTEXITCODE -eq 0) { throw 'There are no staged changes to commit.' }

Write-Host 'Changes to be committed:'
& git -C $repoRoot diff --cached --stat
if ($LASTEXITCODE -ne 0) { throw 'Could not read the staged summary.' }

$confirmation = Read-Host "Create commit '$Message'? [y/N]"
if ($confirmation -notmatch '^[sSyY]$') {
    Write-Warning 'Commit cancelled. Changes remain staged for review.'
    exit 0
}

Invoke-Git -Arguments @('-C', $repoRoot, 'commit', '-m', $Message)

Write-Host 'Final status:'
& git -C $repoRoot status --short
Write-Host 'Latest commit:'
& git -C $repoRoot log -1 --oneline
