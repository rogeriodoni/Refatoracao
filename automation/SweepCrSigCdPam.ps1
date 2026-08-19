#==============================================================================
# SweepCrSigCdPam.ps1
# Roda apenas Pattern #169 (Corrigir-CrSigCdPamNaoPopulado) em todos Form*.prg.
# WARNING-only: nao muta arquivos.
#==============================================================================

$ErrorActionPreference = "Stop"

. "C:\4c\automation\CorretorAutomatico.ps1"

$basePath = "C:\4c\projeto\app\forms"

$formFiles = Get-ChildItem -Path $basePath -Recurse -Filter "Form*.prg" | Where-Object { $_.Name -notmatch "\.bak$" }

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SWEEP - Pattern #169 (crSigCdPam)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Forms encontrados: $($formFiles.Count)" -ForegroundColor Yellow
Write-Host ""

$startTime = Get-Date
$warnings = @()

foreach ($f in $formFiles) {
    $linhas = Get-Content -Path $f.FullName -Encoding UTF8
    $script:Correcoes = @()
    $null = Corrigir-CrSigCdPamNaoPopulado -Linhas $linhas
    if ($script:Correcoes.Count -gt 0) {
        foreach ($c in $script:Correcoes) {
            $warnings += [PSCustomObject]@{
                Arquivo = $f.Name
                Pasta = Split-Path (Split-Path $f.FullName -Parent) -Leaf
                Linha = $c.Linha
                Original = $c.Original
            }
        }
        Write-Host ("[HIT] " + (Split-Path (Split-Path $f.FullName -Parent) -Leaf) + "/" + $f.Name) -ForegroundColor Yellow
    }
}

$elapsed = (Get-Date) - $startTime

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  RESUMO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total Forms processados: $($formFiles.Count)" -ForegroundColor White
Write-Host "Total WARN-169 hits:     $($warnings.Count)" -ForegroundColor Yellow
Write-Host "Tempo total:             $($elapsed.TotalSeconds.ToString('F1')) s" -ForegroundColor White
Write-Host ""

if ($warnings.Count -gt 0) {
    Write-Host "=== Forms afetados (BO precisa popular crSigCdPam em Init) ===" -ForegroundColor Yellow
    $warnings | Group-Object Pasta | ForEach-Object {
        Write-Host ""
        Write-Host ("--- " + $_.Name + " (" + $_.Count + " hits) ---") -ForegroundColor Cyan
        foreach ($w in $_.Group) {
            Write-Host ("  " + $w.Arquivo + "  [linha " + $w.Linha + "]") -ForegroundColor Yellow
            Write-Host ("    " + $w.Original) -ForegroundColor Gray
        }
    }
}
