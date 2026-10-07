# RunLoop.ps1 - Executa OrquestradorMigracao.ps1 em loop ate esvaziar <repo>\origem
# Raiz do repo = pai de automation\ (era C:\4c\ fixo ate 2026-10-06; o repo vive em C:\4c\refatoracao)
$RaizRepo4c = Split-Path -Parent $PSScriptRoot

$logFile = "$($RaizRepo4c)\automation\logs\pipeline_loop_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
$origemDir = "$($RaizRepo4c)\origem"
$contador = 0

# Criar pasta de logs se nao existir
if (-not (Test-Path "$($RaizRepo4c)\automation\logs")) {
    New-Item -ItemType Directory -Path "$($RaizRepo4c)\automation\logs" -Force | Out-Null
}

Write-Host "=== PIPELINE LOOP ===" | Tee-Object -FilePath $logFile
Write-Host "Log: $logFile" | Tee-Object -FilePath $logFile -Append
Write-Host "Inicio: $(Get-Date)" | Tee-Object -FilePath $logFile -Append
Write-Host ""

# Pre-flight: garantir BOM UTF-8 em todos os .ps1 (evita falha de parser CP1252)
# VerificarEncodingPS1.ps1 usa `throw` em falha - nao checar $LASTEXITCODE (carrega de comando anterior do shell)
try {
    & "$($RaizRepo4c)\automation\VerificarEncodingPS1.ps1" 2>&1 | Tee-Object -FilePath $logFile -Append
}
catch {
    throw "Verificacao de encoding falhou: $_"
}
Write-Host ""

$taskIds = @()  # Coleta IDs das tasks processadas nesta rodada

while ($true) {
    $arquivos = Get-ChildItem -Path $origemDir -Filter "*.SCX" -ErrorAction SilentlyContinue
    if ($arquivos.Count -eq 0) {
        Write-Host "`n=== PIPELINE LOOP FINALIZADO ===" | Tee-Object -FilePath $logFile -Append
        Write-Host "Total processado: $contador arquivo(s)" | Tee-Object -FilePath $logFile -Append
        Write-Host "Fim: $(Get-Date)" | Tee-Object -FilePath $logFile -Append
        break
    }

    $contador++
    $proximo = $arquivos[0].Name
    Write-Host "`n============================================================" | Tee-Object -FilePath $logFile -Append
    Write-Host " [$contador] Processando: $proximo (restam $($arquivos.Count))" | Tee-Object -FilePath $logFile -Append
    Write-Host " Inicio: $(Get-Date)" | Tee-Object -FilePath $logFile -Append
    Write-Host "============================================================" | Tee-Object -FilePath $logFile -Append

    try {
        & "$($RaizRepo4c)\automation\OrquestradorMigracao.ps1" 2>&1 | Tee-Object -FilePath $logFile -Append
        Write-Host " [$contador] $proximo - CONCLUIDO ($(Get-Date))" | Tee-Object -FilePath $logFile -Append
    }
    catch {
        Write-Host " [$contador] $proximo - ERRO: $($_.Exception.Message)" | Tee-Object -FilePath $logFile -Append
        Write-Host " Continuando com proximo arquivo..." | Tee-Object -FilePath $logFile -Append
    }
}

# ============================================================================
# RETROSPECTIVA AUTOMATICA (Fase 1 + Fase 2)
# ============================================================================
if ($contador -gt 0) {
    Write-Host "" | Tee-Object -FilePath $logFile -Append
    Write-Host "============================================================" | Tee-Object -FilePath $logFile -Append
    Write-Host " EXECUTANDO RETROSPECTIVA AUTOMATICA..." | Tee-Object -FilePath $logFile -Append
    Write-Host "============================================================" | Tee-Object -FilePath $logFile -Append
    try {
        & "$($RaizRepo4c)\automation\Retrospectiva.ps1" -UltimasNTasks $contador 2>&1 | Tee-Object -FilePath $logFile -Append
    }
    catch {
        Write-Host " [AVISO] Retrospectiva falhou: $($_.Exception.Message)" | Tee-Object -FilePath $logFile -Append
    }
}
