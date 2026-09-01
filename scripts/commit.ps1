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
        throw "Git ha terminado con código ${LASTEXITCODE}: git $($Arguments -join ' ')"
    }
}

$repoRoot = (& git rev-parse --show-toplevel 2>$null).Trim()
if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($repoRoot)) {
    throw 'El directorio actual no pertenece a un repositorio Git.'
}

Write-Host "Repositorio: $repoRoot"
Write-Host "Estado inicial:"
& git -C $repoRoot status --short
if ($LASTEXITCODE -ne 0) { throw 'No se pudo consultar el estado del repositorio.' }

& git -C $repoRoot diff --check
if ($LASTEXITCODE -ne 0) { throw 'El diff contiene errores de whitespace. Corrígelos antes de continuar.' }

if ($All -and $Path.Count -gt 0) {
    throw 'Usa -All o -Path, pero no ambas opciones.'
}
if (-not $All -and $Path.Count -eq 0) {
    throw 'Indica al menos una ruta con -Path o confirma todos los cambios con -All.'
}

if ($All) {
    Invoke-Git -Arguments @('-C', $repoRoot, 'add', '-A')
} else {
    Invoke-Git -Arguments (@('-C', $repoRoot, 'add', '--') + $Path)
}

& git -C $repoRoot diff --cached --check
if ($LASTEXITCODE -ne 0) { throw 'Los cambios staged contienen errores de whitespace.' }

& git -C $repoRoot diff --cached --quiet
if ($LASTEXITCODE -eq 0) { throw 'No hay cambios staged para crear el commit.' }

Write-Host 'Cambios que se van a confirmar:'
& git -C $repoRoot diff --cached --stat
if ($LASTEXITCODE -ne 0) { throw 'No se pudo leer el resumen staged.' }

$confirmation = Read-Host "Crear commit '$Message'? [s/N]"
if ($confirmation -notmatch '^[sSyY]$') {
    Write-Warning 'Commit cancelado. Los cambios siguen staged para que puedas revisarlos.'
    exit 0
}

Invoke-Git -Arguments @('-C', $repoRoot, 'commit', '-m', $Message)

Write-Host 'Estado final:'
& git -C $repoRoot status --short
Write-Host 'Último commit:'
& git -C $repoRoot log -1 --oneline
