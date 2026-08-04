#==============================================================================
# CorrigirTodosFormularios.ps1
#
# PROPOSITO: Executa CorretorAutomatico.ps1 em TODOS os formularios e BOs
#            existentes no projeto. Util quando novos patterns sao adicionados
#            ao CorretorAutomatico e precisam ser aplicados retroativamente.
#
# USO:
#   .\CorrigirTodosFormularios.ps1                    # paralelo default (4 workers)
#   .\CorrigirTodosFormularios.ps1 -Parallel 8        # aumenta workers
#   .\CorrigirTodosFormularios.ps1 -Parallel 1        # modo sequencial (para debug)
#   .\CorrigirTodosFormularios.ps1 -ApenasListar      # apenas lista arquivos
#
# PARALELIZACAO: Usa RunspacePool (in-process threads) compativel com PS 5.1.
# Cada worker roda CorretorAutomatico.ps1 num runspace isolado (state nao
# compartilhado entre workers - safe para paralelismo por arquivo).
# Speedup esperado: ~N/1.5 (bloqueio em I/O + GC) para N workers.
#
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-02-05 (paralelizacao 2026-08-04)
#==============================================================================

param(
    [switch]$ApenasListar,
    [int]$Parallel = 4
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CORRIGIR TODOS OS FORMULARIOS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Modo: $(if ($Parallel -le 1) { 'SEQUENCIAL' } else { "PARALELO ($Parallel workers)" })" -ForegroundColor Yellow
Write-Host ""

$basePath = "C:\4c\projeto\app"
$corretorScript = "C:\4c\automation\CorretorAutomatico.ps1"

# Pattern #116: valida integridade do stub fwprogressbar antes do sweep.
# O stub em classes/fwprogressbar.prg DEVE expor todos os membros da interface
# do framework legado (Titulo/SubTitulo/Rodape/lblPercentage). Se algum estiver
# ausente, forms migrados que acessam esses membros estouram "Unknown member"
# em runtime. Origem: Erro26 (2026-07-07, Formsigrepes.prg linha 4562).
Write-Host "Pre-sweep: validando stub fwprogressbar.prg..." -ForegroundColor Yellow
. $corretorScript
Corrigir-FwProgressBarStubMembros | Out-Null
Write-Host ""

# Encontra todos os forms
$formFiles = Get-ChildItem -Path "$basePath\forms" -Recurse -Filter "*.prg" -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -notmatch "\.bak$|\.BAK$" }

# Encontra todos os BOs
$boFiles = Get-ChildItem -Path "$basePath\classes" -Recurse -Filter "*BO.prg" -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -notmatch "\.bak$|\.BAK$" }

$totalFiles = @()
$totalFiles += $formFiles
$totalFiles += $boFiles

Write-Host "Arquivos encontrados:" -ForegroundColor Yellow
Write-Host "  Forms: $($formFiles.Count)" -ForegroundColor White
Write-Host "  BOs:   $($boFiles.Count)" -ForegroundColor White
Write-Host "  Total: $($totalFiles.Count)" -ForegroundColor White
Write-Host ""

if ($ApenasListar) {
    Write-Host "=== LISTA DE ARQUIVOS ===" -ForegroundColor Cyan
    foreach ($file in $totalFiles) {
        Write-Host "  $($file.FullName)" -ForegroundColor Gray
    }
    exit 0
}

#------------------------------------------------------------------------------
# Bloco de trabalho executado por cada runspace
#------------------------------------------------------------------------------
$workerScript = {
    param($ArquivoPrg, $CorretorScriptPath)

    $resultado = [PSCustomObject]@{
        FullName     = $ArquivoPrg
        Name         = [System.IO.Path]::GetFileName($ArquivoPrg)
        Status       = 'unknown'
        NumCorrecoes = 0
        ErrorMsg     = $null
        ElapsedMs    = 0
    }

    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    try {
        $output = & $CorretorScriptPath -ArquivoPrg $ArquivoPrg 2>&1
        $outputText = $output | Out-String

        if ($outputText -match "(\d+) correcao\(oes\) aplicada") {
            $resultado.NumCorrecoes = [int]$Matches[1]
            if ($resultado.NumCorrecoes -gt 0) {
                $resultado.Status = 'corrigido'
            } else {
                $resultado.Status = 'sem_correcao'
            }
        } elseif ($outputText -match "Nenhuma correcao necessaria") {
            $resultado.Status = 'sem_correcao'
        } else {
            $resultado.Status = 'processado'
        }
    } catch {
        $resultado.Status = 'erro'
        $resultado.ErrorMsg = $_.Exception.Message
    }
    $sw.Stop()
    $resultado.ElapsedMs = $sw.ElapsedMilliseconds
    return $resultado
}

#------------------------------------------------------------------------------
# Execucao
#------------------------------------------------------------------------------
$corrigidos = 0
$semCorrecao = 0
$erros = 0
$processados = 0
$total = $totalFiles.Count
$swTotal = [System.Diagnostics.Stopwatch]::StartNew()

if ($Parallel -le 1) {
    #--- Modo SEQUENCIAL (fallback / debug) ---
    foreach ($file in $totalFiles) {
        $processados++
        $r = & $workerScript $file.FullName $corretorScript
        $tempo = "{0:0.0}s" -f ($r.ElapsedMs / 1000)
        switch ($r.Status) {
            'corrigido' {
                Write-Host ("[{0,3}/{1}] {2,-45} {3,7}  -> {4} correcao(oes)" -f $processados, $total, $r.Name, $tempo, $r.NumCorrecoes) -ForegroundColor Green
                $corrigidos++
            }
            'erro' {
                Write-Host ("[{0,3}/{1}] {2,-45} {3,7}  -> ERRO: {4}" -f $processados, $total, $r.Name, $tempo, $r.ErrorMsg) -ForegroundColor Red
                $erros++
            }
            default {
                Write-Host ("[{0,3}/{1}] {2,-45} {3,7}  -> sem correcoes" -f $processados, $total, $r.Name, $tempo) -ForegroundColor Gray
                $semCorrecao++
            }
        }
    }
} else {
    #--- Modo PARALELO com RunspacePool ---
    $iss = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
    $pool = [runspacefactory]::CreateRunspacePool(1, $Parallel, $iss, $Host)
    $pool.ApartmentState = 'STA'
    $pool.Open()

    $jobs = New-Object System.Collections.Generic.List[object]

    Write-Host "Enfileirando $total arquivos em pool de $Parallel workers..." -ForegroundColor Yellow

    foreach ($file in $totalFiles) {
        $ps = [PowerShell]::Create()
        $ps.RunspacePool = $pool
        [void]$ps.AddScript($workerScript).AddArgument($file.FullName).AddArgument($corretorScript)
        $handle = $ps.BeginInvoke()
        $jobs.Add([PSCustomObject]@{
            PowerShell = $ps
            Handle     = $handle
            File       = $file
        })
    }
    Write-Host "$total jobs enfileirados. Aguardando conclusao..." -ForegroundColor Yellow
    Write-Host ""

    # Poll ate todos completarem, imprimindo resultado quando cada um encerra
    $pendentes = $jobs.Count
    while ($pendentes -gt 0) {
        for ($i = 0; $i -lt $jobs.Count; $i++) {
            $j = $jobs[$i]
            if ($null -eq $j) { continue }
            if ($j.Handle.IsCompleted) {
                try {
                    $r = $j.PowerShell.EndInvoke($j.Handle)
                } catch {
                    $r = [PSCustomObject]@{
                        Name         = $j.File.Name
                        Status       = 'erro'
                        NumCorrecoes = 0
                        ErrorMsg     = $_.Exception.Message
                        ElapsedMs    = 0
                    }
                }
                $j.PowerShell.Dispose()
                $processados++
                $pendentes--
                $jobs[$i] = $null

                $tempo = "{0:0.0}s" -f ($r.ElapsedMs / 1000)
                switch ($r.Status) {
                    'corrigido' {
                        Write-Host ("[{0,3}/{1}] {2,-45} {3,7}  -> {4} correcao(oes)" -f $processados, $total, $r.Name, $tempo, $r.NumCorrecoes) -ForegroundColor Green
                        $corrigidos++
                    }
                    'erro' {
                        Write-Host ("[{0,3}/{1}] {2,-45} {3,7}  -> ERRO: {4}" -f $processados, $total, $r.Name, $tempo, $r.ErrorMsg) -ForegroundColor Red
                        $erros++
                    }
                    default {
                        Write-Host ("[{0,3}/{1}] {2,-45} {3,7}  -> sem correcoes" -f $processados, $total, $r.Name, $tempo) -ForegroundColor Gray
                        $semCorrecao++
                    }
                }
                [Console]::Out.Flush()
            }
        }
        if ($pendentes -gt 0) { Start-Sleep -Milliseconds 200 }
    }

    $pool.Close()
    $pool.Dispose()
}

$swTotal.Stop()
$tempoTotal = [TimeSpan]::FromMilliseconds($swTotal.ElapsedMilliseconds)

# Resumo
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  RESUMO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ("  Arquivos com correcoes: {0}" -f $corrigidos) -ForegroundColor Green
Write-Host ("  Arquivos sem correcoes: {0}" -f $semCorrecao) -ForegroundColor Gray
Write-Host ("  Erros:                  {0}" -f $erros) -ForegroundColor $(if ($erros -gt 0) { "Red" } else { "Gray" })
Write-Host ("  Tempo total:            {0:hh\:mm\:ss}" -f $tempoTotal) -ForegroundColor Cyan
if ($processados -gt 0) {
    $avgSec = $swTotal.ElapsedMilliseconds / 1000 / $processados
    Write-Host ("  Media por arquivo:      {0:0.0}s (wall clock, com {1} workers)" -f $avgSec, $Parallel) -ForegroundColor Cyan
}
Write-Host ""

# Limpa FXP
Write-Host "Limpando arquivos .FXP..." -ForegroundColor Yellow
Get-ChildItem -Path $basePath -Recurse -Filter "*.fxp" -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem -Path $basePath -Recurse -Filter "*.FXP" -ErrorAction SilentlyContinue | Remove-Item -Force
Write-Host "FXP limpos!" -ForegroundColor Green
Write-Host ""

Write-Host "Concluido!" -ForegroundColor Green
