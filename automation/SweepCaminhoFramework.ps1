#==============================================================================
# SweepCaminhoFramework.ps1
# Roda Pattern #170 (Corrigir-GcCaminhoBasePlusFramework) em todos .prg
# que contenham 'gc_4c_CaminhoBase + "Framework\...".
#==============================================================================

param([int]$Parallel = 4)

$ErrorActionPreference = "Stop"

. "C:\4c\automation\CorretorAutomatico.ps1"

$basePath = "C:\4c\projeto\app"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SWEEP - Pattern #170 (Framework path)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Pre-filter: apenas arquivos que contem o anti-padrao
$allFiles = Get-ChildItem -Path $basePath -Recurse -Filter "*.prg" | Where-Object { $_.Name -notmatch "\.bak$" }
$affectedFiles = @()
foreach ($f in $allFiles) {
    $content = Get-Content -Path $f.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
    if ($content -match '(?i)gc_4c_CaminhoBase\s*\+\s*"Framework\\') {
        $affectedFiles += $f
    }
}

Write-Host "Arquivos afetados: $($affectedFiles.Count)" -ForegroundColor Yellow
Write-Host ""

$startTime = Get-Date
$totalHits = 0
$results = @()

foreach ($f in $affectedFiles) {
    $linhas = Get-Content -Path $f.FullName -Encoding UTF8
    $novaLinhas = Corrigir-GcCaminhoBasePlusFramework -Linhas $linhas
    # Conta hits comparando linhas antes/depois (nao depende de $script:Correcoes que tem
    # escopo problematico entre dot-sourced modules e script chamador)
    $hits = 0
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        if ($linhas[$i] -ne $novaLinhas[$i]) {
            # conta ocorrencias na linha ORIGINAL do padrao
            $matches = [regex]::Matches($linhas[$i], '(?i)gc_4c_CaminhoBase\s*\+\s*"Framework\\')
            $hits += $matches.Count
        }
    }

    if ($hits -gt 0) {
        # Backup + salvar
        Copy-Item -Path $f.FullName -Destination ($f.FullName + ".bak") -Force
        $conteudoFinal = $novaLinhas -join "`r`n"
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($f.FullName, $conteudoFinal, $utf8NoBom)

        $totalHits += $hits
        $results += [PSCustomObject]@{
            Arquivo = $f.Name
            Pasta = Split-Path (Split-Path $f.FullName -Parent) -Leaf
            Hits = $hits
        }
        Write-Host ("[FIX] " + (Split-Path (Split-Path $f.FullName -Parent) -Leaf) + "/" + $f.Name + " (" + $hits + " sites)") -ForegroundColor Green
    }
}

$elapsed = (Get-Date) - $startTime

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  RESUMO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Arquivos afetados:       $($affectedFiles.Count)" -ForegroundColor White
Write-Host "Total Pattern #170 hits: $totalHits" -ForegroundColor Green
Write-Host "Tempo total:             $($elapsed.TotalSeconds.ToString('F1')) s" -ForegroundColor White
Write-Host ""

$results | Group-Object Pasta | ForEach-Object {
    Write-Host ("--- " + $_.Name + " (" + $_.Count + " arquivos, " + (($_.Group | Measure-Object Hits -Sum).Sum) + " hits) ---") -ForegroundColor Cyan
    foreach ($r in $_.Group | Sort-Object Arquivo) {
        Write-Host ("  " + $r.Arquivo + "  (" + $r.Hits + " sites)") -ForegroundColor Gray
    }
}
