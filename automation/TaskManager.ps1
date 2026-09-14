#==============================================================================
# TaskManager.ps1
#
# PROPOSITO: Gerencia estado de tasks de migracao (JSON)
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-01-22
#==============================================================================

#------------------------------------------------------------------------------
# Funcoes publicas
#------------------------------------------------------------------------------

function New-Task {
    param(
        [string]$TaskId,
        [string]$ArquivoOriginal,
        [string]$TipoArquivo,
        [string]$TasksDir
    )

    $taskPath = Join-Path $TasksDir $TaskId
    $stateFile = Join-Path $taskPath "task_state.json"

    # Cria diretorio da task se nao existir
    if (-not (Test-Path $taskPath)) {
        New-Item -ItemType Directory -Path $taskPath -Force | Out-Null
    }

    # Cria subdiretorio de logs
    $logsPath = Join-Path $taskPath "logs"
    if (-not (Test-Path $logsPath)) {
        New-Item -ItemType Directory -Path $logsPath -Force | Out-Null
    }

    # Cria estado inicial baseado no template
    $templatePath = Join-Path (Split-Path -Parent $PSScriptRoot) "automation\task_state_template.json"
    $state = Get-Content -Path $templatePath -Raw | ConvertFrom-Json

    # Atualiza campos
    $state.taskId = $TaskId
    $state.arquivoOriginal = $ArquivoOriginal
    $state.tipoArquivo = $TipoArquivo
    $state.status = "PENDING"
    $state.criadoEm = Get-Date -Format "yyyy-MM-ddTHH:mm:ss"
    $state.atualizadoEm = $state.criadoEm

    # Salva estado
    $state | ConvertTo-Json -Depth 10 | Set-Content -Path $stateFile -Encoding UTF8

    Write-Host "[TaskManager] Task criada: $TaskId"

    return $state
}

function Get-TaskState {
    param(
        [string]$TaskId,
        [string]$TasksDir
    )

    $stateFile = Join-Path $TasksDir "$TaskId\task_state.json"

    if (-not (Test-Path $stateFile)) {
        throw "Task nao encontrada: $TaskId"
    }

    return Get-Content -Path $stateFile -Raw | ConvertFrom-Json
}

function Set-TaskState {
    param(
        [object]$State,
        [string]$TasksDir
    )

    $taskId = $State.taskId
    $stateFile = Join-Path $TasksDir "$taskId\task_state.json"

    # Atualiza timestamp
    $State.atualizadoEm = Get-Date -Format "yyyy-MM-ddTHH:mm:ss"

    # Salva estado
    $State | ConvertTo-Json -Depth 10 | Set-Content -Path $stateFile -Encoding UTF8

    Write-Host "[TaskManager] Estado atualizado: $taskId"
}

function Update-TaskStatus {
    param(
        [string]$TaskId,
        [string]$Status,
        [string]$TasksDir
    )

    $state = Get-TaskState -TaskId $TaskId -TasksDir $TasksDir
    $state.status = $Status
    Set-TaskState -State $state -TasksDir $TasksDir
}

function Start-Etapa {
    param(
        [string]$TaskId,
        [string]$Etapa,
        [string]$TasksDir
    )

    $state = Get-TaskState -TaskId $TaskId -TasksDir $TasksDir

    # Cria a etapa dinamicamente se nao existir (para etapas novas adicionadas apos criacao da task)
    if (-not $state.etapas.PSObject.Properties[$Etapa]) {
        $novaEtapa = @{
            status = "PENDING"
            inicio = $null
            fim = $null
            tentativas = 0
            erro = $null
        }
        $state.etapas | Add-Member -MemberType NoteProperty -Name $Etapa -Value ([PSCustomObject]$novaEtapa) -Force
        Write-Host "[TaskManager] Etapa criada dinamicamente: $Etapa" -ForegroundColor Yellow
    }

    $state.etapas.$Etapa.status = "IN_PROGRESS"
    $state.etapas.$Etapa.inicio = Get-Date -Format "yyyy-MM-ddTHH:mm:ss"
    $state.etapas.$Etapa.tentativas++
    Set-TaskState -State $state -TasksDir $TasksDir

    Write-Host "[TaskManager] Etapa iniciada: $Etapa (tentativa $($state.etapas.$Etapa.tentativas))"
}

function Complete-Etapa {
    param(
        [string]$TaskId,
        [string]$Etapa,
        [string]$TasksDir,
        [hashtable]$Metadata
    )

    $state = Get-TaskState -TaskId $TaskId -TasksDir $TasksDir
    $state.etapas.$Etapa.status = "COMPLETED"
    $state.etapas.$Etapa.fim = Get-Date -Format "yyyy-MM-ddTHH:mm:ss"

    # Adiciona metadata (arquivos gerados, etc)
    if ($Metadata) {
        foreach ($key in $Metadata.Keys) {
            $state.etapas.$Etapa | Add-Member -MemberType NoteProperty -Name $key -Value $Metadata[$key] -Force
        }
    }

    Set-TaskState -State $state -TasksDir $TasksDir

    Write-Host "[TaskManager] Etapa completada: $Etapa"
}

function Fail-Etapa {
    param(
        [string]$TaskId,
        [string]$Etapa,
        [string]$ErroMsg,
        [string]$TasksDir,
        [hashtable]$Metadata = @{}
    )

    $state = Get-TaskState -TaskId $TaskId -TasksDir $TasksDir
    $state.etapas.$Etapa.status = "FAILED"
    $state.etapas.$Etapa.fim = Get-Date -Format "yyyy-MM-ddTHH:mm:ss"
    $state.etapas.$Etapa.erro = $ErroMsg
    # Merge metadata if provided
    foreach ($key in $Metadata.Keys) {
        $state.etapas.$Etapa | Add-Member -NotePropertyName $key -NotePropertyValue $Metadata[$key] -Force
    }
    Set-TaskState -State $state -TasksDir $TasksDir

    Write-Host "[TaskManager] Etapa falhou: $Etapa - $ErroMsg" -ForegroundColor Red
}

function Get-PendingTasks {
    param([string]$TasksDir)

    $tasks = @()

    Get-ChildItem -Path $TasksDir -Directory | ForEach-Object {
        $stateFile = Join-Path $_.FullName "task_state.json"

        if (Test-Path $stateFile) {
            $state = Get-Content -Path $stateFile -Raw | ConvertFrom-Json

            if ($state.status -eq "PENDING" -or $state.status -eq "IN_PROGRESS") {
                $tasks += $state
            }
        }
    }

    return $tasks
}

function Get-TaskLogPath {
    param(
        [string]$TaskId,
        [string]$Etapa,
        [string]$TasksDir
    )

    $etapaNumero = $Etapa -replace '^\d+_', ''
    return Join-Path $TasksDir "$TaskId\logs\$Etapa.log"
}

#------------------------------------------------------------------------------
# NOTA: Export-ModuleMember removido - TaskManager.ps1 eh carregado via
# dot-sourcing (. script.ps1) no OrquestradorMigracao.ps1, nao como modulo.
# Todas as funcoes ficam automaticamente disponiveis no escopo do caller.
#------------------------------------------------------------------------------
