# Reset task023 migration etapa
$state = Get-Content 'C:\4c\tasks\task023\task_state.json' -Raw | ConvertFrom-Json
$state.etapas.'05_migracao'.status = 'PENDING'
$state.etapas.'05_migracao'.tentativas = 0
$state.etapas.'05_migracao'.erro = $null
$state.etapas.'05_migracao'.inicio = $null
$state.etapas.'05_migracao'.fim = $null
$state | ConvertTo-Json -Depth 10 | Set-Content 'C:\4c\tasks\task023\task_state.json' -Encoding UTF8
Write-Host "Task023 migration status reset to PENDING"
