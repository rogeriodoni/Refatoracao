#==============================================================================
# SweepReportForms.ps1
# Roda CorretorAutomatico apenas em Forms em forms/relatorios/.
# Uso: powershell -ExecutionPolicy Bypass -File SweepReportForms.ps1
#==============================================================================

param([int]$Parallel = 4)

$ErrorActionPreference = "Stop"

$basePath = "C:\4c\projeto\app\forms\relatorios"
$corretorScript = "C:\4c\automation\CorretorAutomatico.ps1"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SWEEP - Forms REPORT" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$formFiles = Get-ChildItem -Path $basePath -Filter "Form*.prg" | Where-Object { $_.Name -notmatch "\.bak$" }

Write-Host "Forms REPORT encontrados: $($formFiles.Count)" -ForegroundColor Yellow
Write-Host "Paralelismo: $Parallel workers" -ForegroundColor Yellow
Write-Host ""

$startTime = Get-Date

$workerScript = {
    param($ArquivoPrg, $CorretorScriptPath)
    try {
        $output = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $CorretorScriptPath -ArquivoPrg $ArquivoPrg 2>&1 | Out-String
        $totalCorr = 0
        $p168 = 0
        $warn168 = 0
        if ($output -match "Correcoes aplicadas:\s*(\d+)") { $totalCorr = [int]$matches[1] }
        $p168 = ([regex]::Matches($output, "Pattern #168\] Linha")).Count
        $warn168 = ([regex]::Matches($output, "WARN-168")).Count
        return [PSCustomObject]@{
            Arquivo = Split-Path $ArquivoPrg -Leaf
            TotalCorrecoes = $totalCorr
            Pattern168Hits = $p168
            Warn168Missing = $warn168
        }
    } catch {
        return [PSCustomObject]@{
            Arquivo = Split-Path $ArquivoPrg -Leaf
            TotalCorrecoes = -1
            Pattern168Hits = 0
            Warn168Missing = 0
        }
    }
}

$runspacePool = [runspacefactory]::CreateRunspacePool(1, $Parallel)
$runspacePool.Open()
$jobs = @()

foreach ($f in $formFiles) {
    $ps = [powershell]::Create().AddScript($workerScript).AddArgument($f.FullName).AddArgument($corretorScript)
    $ps.RunspacePool = $runspacePool
    $jobs += [PSCustomObject]@{
        PS = $ps
        Handle = $ps.BeginInvoke()
        Arquivo = $f.Name
    }
}

$results = @()
$done = 0
$total = $jobs.Count
foreach ($j in $jobs) {
    $r = $j.PS.EndInvoke($j.Handle)
    $j.PS.Dispose()
    $done++
    if ($r.Pattern168Hits -gt 0) {
        Write-Host ("[{0,3}/{1,3}] {2,-30} {3} corr, {4} Pattern #168 hits" -f $done, $total, $r.Arquivo, $r.TotalCorrecoes, $r.Pattern168Hits) -ForegroundColor Green
    } elseif ($r.Warn168Missing -gt 0) {
        Write-Host ("[{0,3}/{1,3}] {2,-30} {3} corr, WARN-168 (fundo ausente)" -f $done, $total, $r.Arquivo, $r.TotalCorrecoes) -ForegroundColor Yellow
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
Write-Host "Total Forms processados:    $($results.Count)" -ForegroundColor White
Write-Host "Total correcoes:            $((($results | Measure-Object -Property TotalCorrecoes -Sum).Sum))" -ForegroundColor White
Write-Host "Total Pattern #168 hits:    $((($results | Measure-Object -Property Pattern168Hits -Sum).Sum))" -ForegroundColor Green
Write-Host "Total WARN-168 (missing):   $((($results | Measure-Object -Property Warn168Missing -Sum).Sum))" -ForegroundColor Yellow
Write-Host "Forms com Pattern #168:     $(($results | Where-Object { $_.Pattern168Hits -gt 0 }).Count)" -ForegroundColor Green
Write-Host "Forms com WARN-168:         $(($results | Where-Object { $_.Warn168Missing -gt 0 }).Count)" -ForegroundColor Yellow
Write-Host "Forms com erro:             $(($results | Where-Object { $_.TotalCorrecoes -lt 0 }).Count)" -ForegroundColor $(if (($results | Where-Object { $_.TotalCorrecoes -lt 0 }).Count -eq 0) { 'Gray' } else { 'Red' })
Write-Host "Tempo total:                $($elapsed.TotalMinutes.ToString('F1')) min" -ForegroundColor White
Write-Host ""

$hit = $results | Where-Object { $_.Pattern168Hits -gt 0 } | Sort-Object Arquivo
if ($hit.Count -gt 0) {
    Write-Host "=== Forms com Pattern #168 aplicado (BackColor removida) ===" -ForegroundColor Green
    foreach ($h in $hit) {
        Write-Host ("  {0,-30} {1} hits" -f $h.Arquivo, $h.Pattern168Hits) -ForegroundColor Green
    }
}

$warn = $results | Where-Object { $_.Warn168Missing -gt 0 } | Sort-Object Arquivo
if ($warn.Count -gt 0) {
    Write-Host ""
    Write-Host "=== Forms com WARN-168 (fundo_cad_1003.jpg ausente) ===" -ForegroundColor Yellow
    foreach ($w in $warn) {
        Write-Host ("  {0}" -f $w.Arquivo) -ForegroundColor Yellow
    }
}
