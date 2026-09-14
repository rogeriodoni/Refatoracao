#==============================================================================
# RemigrarTodosFormularios.ps1
#
# PROPOSITO: Re-executa a migracao de TODOS os formularios existentes nas tasks
#            Reseta as tasks a partir da etapa de migracao e re-executa o
#            OrquestradorMigracao.ps1 para gerar novos arquivos Form/BO.
#
# USO:
#   .\RemigrarTodosFormularios.ps1                    # Remigra todos
#   .\RemigrarTodosFormularios.ps1 -TaskId "task006"  # Remigra apenas uma
#   .\RemigrarTodosFormularios.ps1 -FromEtapa "02b_analisarTarefa" # Reinicia de etapa anterior
#   .\RemigrarTodosFormularios.ps1 -ApenasListar     # Lista tasks sem executar
#
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-02-05
#==============================================================================

param(
    [Parameter(Mandatory=$false)]
    [string]$TaskId,

    [Parameter(Mandatory=$false)]
    [string]$FromEtapa = "05_migracao",  # Padrao: reinicia da migracao Claude

    [Parameter(Mandatory=$false)]
    [switch]$ApenasListar,

    [Parameter(Mandatory=$false)]
    [switch]$Sequencial  # Processa uma task por vez (padrao: paralelo)
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $PSCommandPath
$tasksPath = "C:\4c\tasks"
$resetScript = Join-Path $scriptDir "ResetTask.ps1"
$orquestradorScript = Join-Path $scriptDir "OrquestradorMigracao.ps1"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  REMIGRAR TODOS OS FORMULARIOS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

#------------------------------------------------------------------------------
# Lista todas as tasks existentes
#------------------------------------------------------------------------------

$taskFolders = Get-ChildItem -Path $tasksPath -Directory -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -match '^task\d+$' } |
    Sort-Object { [int]($_.Name -replace 'task', '') }

if ($taskFolders.Count -eq 0) {
    Write-Host "ERRO: Nenhuma task encontrada em $tasksPath" -ForegroundColor Red
    exit 1
}

# Se TaskId especificado, filtra apenas essa
if ($TaskId) {
    $taskFolders = $taskFolders | Where-Object { $_.Name -eq $TaskId }
    if ($taskFolders.Count -eq 0) {
        Write-Host "ERRO: Task $TaskId nao encontrada" -ForegroundColor Red
        exit 1
    }
}

Write-Host "Tasks encontradas: $($taskFolders.Count)" -ForegroundColor Yellow
Write-Host "Etapa inicial: $FromEtapa" -ForegroundColor Yellow
Write-Host ""

#------------------------------------------------------------------------------
# Lista detalhada das tasks
#------------------------------------------------------------------------------

$tasksInfo = @()

foreach ($folder in $taskFolders) {
    $stateFile = Join-Path $folder.FullName "task_state.json"

    if (Test-Path $stateFile) {
        try {
            $state = Get-Content $stateFile -Raw | ConvertFrom-Json
            $baseName = $state.etapas.'01_moverArquivos'.baseName
            $formClass = $state.etapas.'03_gerarMetaPrompt'.formClass
            $status = $state.status

            $tasksInfo += [PSCustomObject]@{
                TaskId = $folder.Name
                BaseName = $baseName
                FormClass = $formClass
                Status = $status
                Path = $folder.FullName
            }

            $statusColor = switch ($status) {
                "COMPLETED" { "Green" }
                "FAILED" { "Red" }
                "IN_PROGRESS" { "Yellow" }
                default { "Gray" }
            }

            Write-Host "  $($folder.Name): $baseName -> $formClass [$status]" -ForegroundColor $statusColor
        }
        catch {
            Write-Host "  $($folder.Name): [ERRO ao ler state]" -ForegroundColor Red
        }
    }
    else {
        Write-Host "  $($folder.Name): [Sem task_state.json]" -ForegroundColor Gray
    }
}

Write-Host ""

if ($ApenasListar) {
    Write-Host "Modo -ApenasListar: nenhuma acao executada." -ForegroundColor Yellow
    exit 0
}

#------------------------------------------------------------------------------
# Confirma execucao
#------------------------------------------------------------------------------

Write-Host "ATENCAO: Isso ira re-executar a migracao de $($tasksInfo.Count) task(s)." -ForegroundColor Yellow
Write-Host "Os arquivos Form*.prg e *BO.prg serao REGENERADOS." -ForegroundColor Yellow
Write-Host ""
Write-Host "Pressione ENTER para continuar ou CTRL+C para cancelar..."
$null = Read-Host

#------------------------------------------------------------------------------
# Limpa FXP primeiro
#------------------------------------------------------------------------------

Write-Host "Limpando arquivos .FXP..." -ForegroundColor Yellow
Get-ChildItem -Path "C:\4c\projeto\app" -Recurse -Filter "*.fxp" -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem -Path "C:\4c\projeto\app" -Recurse -Filter "*.FXP" -ErrorAction SilentlyContinue | Remove-Item -Force
Write-Host "FXP limpos!" -ForegroundColor Green
Write-Host ""

#------------------------------------------------------------------------------
# Mata processos VFP9 que possam estar travados
#------------------------------------------------------------------------------

$vfpProcesses = Get-Process -Name "vfp9" -ErrorAction SilentlyContinue
if ($vfpProcesses) {
    Write-Host "Encerrando processos VFP9 anteriores..." -ForegroundColor Yellow
    $vfpProcesses | Stop-Process -Force
    Start-Sleep -Milliseconds 500
}

#------------------------------------------------------------------------------
# Processa cada task
#------------------------------------------------------------------------------

$resultados = @()
$sucessos = 0
$falhas = 0

foreach ($taskInfo in $tasksInfo) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Processando: $($taskInfo.TaskId)" -ForegroundColor Cyan
    Write-Host "  Form: $($taskInfo.FormClass)" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""

    $startTime = Get-Date

    try {
        # 1. Reset da task
        Write-Host "1. Resetando task a partir de $FromEtapa..." -ForegroundColor Yellow
        & $resetScript -TaskId $taskInfo.TaskId -FromEtapa $FromEtapa

        # 2. Executa orquestrador
        Write-Host ""
        Write-Host "2. Executando OrquestradorMigracao..." -ForegroundColor Yellow
        & $orquestradorScript -TaskId $taskInfo.TaskId

        $endTime = Get-Date
        $duracao = ($endTime - $startTime).TotalSeconds

        # Verifica resultado
        $stateFile = Join-Path $taskInfo.Path "task_state.json"
        $state = Get-Content $stateFile -Raw | ConvertFrom-Json

        if ($state.status -eq "COMPLETED") {
            Write-Host ""
            Write-Host "SUCESSO: $($taskInfo.TaskId) migrado em $([int]$duracao) segundos" -ForegroundColor Green
            $sucessos++
            $resultados += [PSCustomObject]@{
                TaskId = $taskInfo.TaskId
                FormClass = $taskInfo.FormClass
                Status = "SUCESSO"
                Duracao = [int]$duracao
            }
        }
        else {
            Write-Host ""
            Write-Host "FALHA: $($taskInfo.TaskId) - Status: $($state.status)" -ForegroundColor Red
            $falhas++
            $resultados += [PSCustomObject]@{
                TaskId = $taskInfo.TaskId
                FormClass = $taskInfo.FormClass
                Status = "FALHA"
                Duracao = [int]$duracao
            }
        }
    }
    catch {
        Write-Host ""
        Write-Host "ERRO: $($taskInfo.TaskId) - $($_.Exception.Message)" -ForegroundColor Red
        $falhas++
        $resultados += [PSCustomObject]@{
            TaskId = $taskInfo.TaskId
            FormClass = $taskInfo.FormClass
            Status = "ERRO: $($_.Exception.Message)"
            Duracao = 0
        }
    }

    # Pausa entre tasks para evitar sobrecarga
    if (-not $Sequencial) {
        Start-Sleep -Seconds 2
    }
}

#------------------------------------------------------------------------------
# Aplica correcoes automaticas em todos os forms
#------------------------------------------------------------------------------

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  APLICANDO CORRECOES AUTOMATICAS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$corretorScript = Join-Path $scriptDir "CorrigirTodosFormularios.ps1"
if (Test-Path $corretorScript) {
    & $corretorScript
}

#------------------------------------------------------------------------------
# Resumo final
#------------------------------------------------------------------------------

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  RESUMO DA REMIGRACAO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

foreach ($resultado in $resultados) {
    $cor = if ($resultado.Status -eq "SUCESSO") { "Green" } else { "Red" }
    Write-Host "  $($resultado.TaskId): $($resultado.FormClass) - $($resultado.Status) ($($resultado.Duracao)s)" -ForegroundColor $cor
}

Write-Host ""
Write-Host "Total: $($resultados.Count)" -ForegroundColor White
Write-Host "  Sucessos: $sucessos" -ForegroundColor Green
Write-Host "  Falhas:   $falhas" -ForegroundColor $(if ($falhas -gt 0) { "Red" } else { "Gray" })
Write-Host ""

# Salva log
$logFile = "C:\4c\automation\logs\remigracao_$(Get-Date -Format 'yyyyMMdd_HHmmss').json"
$logDir = Split-Path $logFile
if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

@{
    data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    fromEtapa = $FromEtapa
    totalTasks = $resultados.Count
    sucessos = $sucessos
    falhas = $falhas
    resultados = $resultados
} | ConvertTo-Json -Depth 5 | Set-Content $logFile -Encoding UTF8

Write-Host "Log salvo em: $logFile" -ForegroundColor Gray
Write-Host ""
Write-Host "Concluido!" -ForegroundColor Green
