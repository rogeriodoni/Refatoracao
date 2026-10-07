# Reset task023 migration etapa
# Raiz do repo = pai de automation\ (era C:\4c\ fixo ate 2026-10-06; o repo vive em C:\4c\refatoracao)
$RaizRepo4c = Split-Path -Parent $PSScriptRoot

$state = Get-Content "$($RaizRepo4c)\tasks\task023\task_state.json" -Raw | ConvertFrom-Json
$state.etapas.'05_migracao'.status = 'PENDING'
$state.etapas.'05_migracao'.tentativas = 0
$state.etapas.'05_migracao'.erro = $null
$state.etapas.'05_migracao'.inicio = $null
$state.etapas.'05_migracao'.fim = $null
$state | ConvertTo-Json -Depth 10 | Set-Content "$($RaizRepo4c)\tasks\task023\task_state.json" -Encoding UTF8
Write-Host "Task023 migration status reset to PENDING"
