#==============================================================================
# SweepReportBOs.ps1
# Roda CorretorAutomatico apenas em BOs que herdam de RelatorioBase.
# Uso: powershell -ExecutionPolicy Bypass -File SweepReportBOs.ps1
#==============================================================================

param([int]$Parallel = 4)

$ErrorActionPreference = "Stop"

$basePath = "C:\4c\projeto\app\classes"
$corretorScript = "C:\4c\automation\CorretorAutomatico.ps1"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SWEEP - BOs REPORT (RelatorioBase)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Encontra BOs que herdam de RelatorioBase
$allBos = Get-ChildItem -Path $basePath -Filter "*BO.prg" | Where-Object { $_.Name -notmatch "\.bak$" }
$reportBos = @()
foreach ($f in $allBos) {
    $content = Get-Content -Path $f.FullName -Raw -Encoding UTF8
    if ($content -match '(?i)DEFINE\s+CLASS\s+\w+\s+AS\s+RelatorioBase\b') {
        $reportBos += $f
    }
}

Write-Host "BOs REPORT encontrados: $($reportBos.Count)" -ForegroundColor Yellow
Write-Host "Paralelismo: $Parallel workers" -ForegroundColor Yellow
Write-Host ""

$startTime = Get-Date

# Worker script (roda em runspace isolado)
$workerScript = {
    param($ArquivoPrg, $CorretorScriptPath)
    try {
        $output = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $CorretorScriptPath -ArquivoPrg $ArquivoPrg 2>&1 | Out-String
        # Extrai contagens
        $totalCorr = 0
        $p167 = 0
        if ($output -match "Correcoes aplicadas:\s*(\d+)") { $totalCorr = [int]$matches[1] }
        $p167 = ([regex]::Matches($output, "\[Pattern #167\]")).Count
        return [PSCustomObject]@{
            Arquivo = Split-Path $ArquivoPrg -Leaf
            TotalCorrecoes = $totalCorr
            Pattern167Hits = $p167
            OutputSnippet = if ($p167 -gt 0) { ($output -split "`n" | Select-String "Pattern #167") -join "`n" } else { "" }
        }
    } catch {
        return [PSCustomObject]@{
            Arquivo = Split-Path $ArquivoPrg -Leaf
            TotalCorrecoes = -1
            Pattern167Hits = 0
            OutputSnippet = "ERRO: $($_.Exception.Message)"
        }
    }
}

# Setup RunspacePool
$runspacePool = [runspacefactory]::CreateRunspacePool(1, $Parallel)
$runspacePool.Open()
$jobs = @()

foreach ($bo in $reportBos) {
    $ps = [powershell]::Create().AddScript($workerScript).AddArgument($bo.FullName).AddArgument($corretorScript)
    $ps.RunspacePool = $runspacePool
    $jobs += [PSCustomObject]@{
        PS = $ps
        Handle = $ps.BeginInvoke()
        Arquivo = $bo.Name
    }
}

# Wait + collect
$results = @()
$done = 0
$total = $jobs.Count
foreach ($j in $jobs) {
    $r = $j.PS.EndInvoke($j.Handle)
    $j.PS.Dispose()
    $done++
    if ($r.Pattern167Hits -gt 0) {
        Write-Host ("[{0,3}/{1,3}] {2,-30} {3} corr, {4} Pattern #167 hits" -f $done, $total, $r.Arquivo, $r.TotalCorrecoes, $r.Pattern167Hits) -ForegroundColor Green
    } elseif ($r.TotalCorrecoes -gt 0) {
        Write-Host ("[{0,3}/{1,3}] {2,-30} {3} corr (outros patterns)" -f $done, $total, $r.Arquivo, $r.TotalCorrecoes) -ForegroundColor Gray
    } elseif ($r.TotalCorrecoes -lt 0) {
        Write-Host ("[{0,3}/{1,3}] {2,-30} ERRO" -f $done, $total, $r.Arquivo) -ForegroundColor Red
    } else {
        Write-Host ("[{0,3}/{1,3}] {2,-30} sem correcoes" -f $done, $total, $r.Arquivo) -ForegroundColor DarkGray
    }
    $results += $r
}

$runspacePool.Close()
$runspacePool.Dispose()

$elapsed = (Get-Date) - $startTime

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  RESUMO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total BOs processados:  $($results.Count)" -ForegroundColor White
Write-Host "Total correcoes:        $((($results | Measure-Object -Property TotalCorrecoes -Sum).Sum))" -ForegroundColor White
Write-Host "Total Pattern #167:     $((($results | Measure-Object -Property Pattern167Hits -Sum).Sum))" -ForegroundColor Green
Write-Host "BOs com Pattern #167:   $(($results | Where-Object { $_.Pattern167Hits -gt 0 }).Count)" -ForegroundColor Green
Write-Host "BOs com erro:           $(($results | Where-Object { $_.TotalCorrecoes -lt 0 }).Count)" -ForegroundColor $(if (($results | Where-Object { $_.TotalCorrecoes -lt 0 }).Count -eq 0) { 'Gray' } else { 'Red' })
Write-Host "Tempo total:            $($elapsed.TotalMinutes.ToString('F1')) min" -ForegroundColor White
Write-Host ""

# Lista BOs com Pattern #167 hits
$hit = $results | Where-Object { $_.Pattern167Hits -gt 0 } | Sort-Object Arquivo
if ($hit.Count -gt 0) {
    Write-Host "=== BOs com Pattern #167 aplicado ===" -ForegroundColor Yellow
    foreach ($h in $hit) {
        Write-Host ("  {0,-30} {1} hits" -f $h.Arquivo, $h.Pattern167Hits) -ForegroundColor Green
    }
}

# Erros
$errors = $results | Where-Object { $_.TotalCorrecoes -lt 0 }
if ($errors.Count -gt 0) {
    Write-Host ""
    Write-Host "=== ERROS ===" -ForegroundColor Red
    foreach ($e in $errors) { Write-Host ("  {0}: {1}" -f $e.Arquivo, $e.OutputSnippet) -ForegroundColor Red }
}
