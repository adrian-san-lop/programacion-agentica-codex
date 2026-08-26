[CmdletBinding()]
param(
    [string]$ProjectRoot = (Get-Location).Path
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $ProjectRoot).Path

$pbipFiles = @(Get-ChildItem -LiteralPath $root -Filter '*.pbip' -File)
$reportFolders = @(Get-ChildItem -LiteralPath $root -Directory -Filter '*.Report')
$modelFolders = @(Get-ChildItem -LiteralPath $root -Directory -Filter '*.SemanticModel')

$errors = [System.Collections.Generic.List[string]]::new()
if ($pbipFiles.Count -eq 0) { $errors.Add('No .pbip file found in the project root.') }
if ($reportFolders.Count -eq 0) { $errors.Add('No *.Report folder found in the project root.') }
if ($modelFolders.Count -eq 0) { $errors.Add('No *.SemanticModel folder found in the project root.') }

foreach ($folder in $reportFolders) {
    if (-not (Test-Path -LiteralPath (Join-Path $folder.FullName 'definition.pbir'))) {
        $errors.Add("definition.pbir is missing from $($folder.Name).")
    }
}
foreach ($folder in $modelFolders) {
    if (-not (Test-Path -LiteralPath (Join-Path $folder.FullName 'definition.pbism'))) {
        $errors.Add("definition.pbism is missing from $($folder.Name).")
    }
}

if ($errors.Count -gt 0) {
    Write-Host 'Validation failed:' -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
    exit 1
}

Write-Host 'Basic PBIP structure detected successfully.' -ForegroundColor Green
Write-Host "PBIP: $($pbipFiles[0].Name)"
Write-Host "Report: $($reportFolders[0].Name)"
Write-Host "Semantic model: $($modelFolders[0].Name)"
