# ResetTask.ps1 - Reset task state for reprocessing

param(
    [Parameter(Mandatory=$true)]
    [string]$TaskId,

    [Parameter(Mandatory=$false)]
    [string]$FromEtapa = "05_migracao"
)

$taskPath = "C:\4c\tasks\$TaskId"
$stateFile = Join-Path $taskPath "task_state.json"

if (-not (Test-Path $stateFile)) {
    Write-Host "ERRO: Task state nao encontrado: $stateFile" -ForegroundColor Red
    exit 1
}

$state = Get-Content $stateFile -Raw | ConvertFrom-Json

# Marca task como em progresso
$state.status = "IN_PROGRESS"

# Etapas a resetar baseado no ponto de inicio
$etapasOrdenadas = @(
    "01_moverArquivos",
    "02_extractCode",
    "02b_analisarTarefa",
    "03_gerarMetaPrompt",
    "04_gerarMapeamento",
    "04b_gerarEsqueletos",
    "05_migracao",
    "05b_corrigirAutomatico",
    "05c_validarCompilacao",
    "06_testForm",
    "06b_testeAutomatico",
    "07_validarUI",
    "08_gerarTestManual"
)

$resetando = $false
foreach ($etapa in $etapasOrdenadas) {
    if ($etapa -eq $FromEtapa) {
        $resetando = $true
    }

    if ($resetando) {
        if ($state.etapas.$etapa) {
            $state.etapas.$etapa.status = "PENDING"
            $state.etapas.$etapa.tentativas = 0
            $state.etapas.$etapa.erro = $null
            Write-Host "  Reset: $etapa" -ForegroundColor Yellow
        }
    }
}

$state | ConvertTo-Json -Depth 10 | Set-Content $stateFile -Encoding UTF8

Write-Host ""
Write-Host "Task $TaskId resetada para reprocessamento a partir de $FromEtapa" -ForegroundColor Green
