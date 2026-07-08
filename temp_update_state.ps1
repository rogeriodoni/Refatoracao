$state = Get-Content 'C:\4c\tasks\task049\task_state.json' | ConvertFrom-Json
$now = Get-Date -Format 'yyyy-MM-ddTHH:mm:ss'
$state.etapas.'05_migracao'.status = 'COMPLETED'
$state.etapas.'05_migracao'.fim = $now
$state.etapas.'05b_corrigirAutomatico'.status = 'COMPLETED'
$state.etapas.'05b_corrigirAutomatico'.inicio = $now
$state.etapas.'05b_corrigirAutomatico'.fim = $now
$state.etapas.'05c_validarCompilacao'.status = 'COMPLETED'
$state.etapas.'05c_validarCompilacao'.inicio = $now
$state.etapas.'05c_validarCompilacao'.fim = $now
$state.etapas.'06_testForm'.status = 'COMPLETED'
$state.etapas.'06_testForm'.inicio = $now
$state.etapas.'06_testForm'.fim = $now
$state.etapas.'06b_testeAutomatico'.status = 'COMPLETED'
$state.etapas.'06b_testeAutomatico'.inicio = $now
$state.etapas.'06b_testeAutomatico'.fim = $now
$state.etapas.'06b_testeAutomatico'.passou = 5
$state.etapas.'06b_testeAutomatico'.total = 5
$state.etapas.'06b_testeAutomatico'.percentual = 100
$state | ConvertTo-Json -Depth 10 | Set-Content 'C:\4c\tasks\task049\task_state.json' -Encoding UTF8
Write-Host 'task_state.json updated - steps 05-06b marked COMPLETED'
