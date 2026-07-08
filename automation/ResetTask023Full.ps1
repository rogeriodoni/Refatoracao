# Reset task023 for retry
$state = Get-Content 'C:\4c\tasks\task023\task_state.json' -Raw | ConvertFrom-Json

# Reset 02a_reduzirArquivo if exists
if ($state.etapas.PSObject.Properties['02a_reduzirArquivo']) {
    $state.etapas.'02a_reduzirArquivo'.status = 'PENDING'
    $state.etapas.'02a_reduzirArquivo'.tentativas = 0
    $state.etapas.'02a_reduzirArquivo'.erro = $null
}

# Reset 05_migracao
$state.etapas.'05_migracao'.status = 'PENDING'
$state.etapas.'05_migracao'.tentativas = 0
$state.etapas.'05_migracao'.erro = $null

$state | ConvertTo-Json -Depth 10 | Set-Content 'C:\4c\tasks\task023\task_state.json' -Encoding UTF8
Write-Host "Task023 reset for retry"
