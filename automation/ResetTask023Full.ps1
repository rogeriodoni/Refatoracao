# Reset task023 for retry
# Raiz do repo = pai de automation\ (era C:\4c\ fixo ate 2026-10-06; o repo vive em C:\4c\refatoracao)
$RaizRepo4c = Split-Path -Parent $PSScriptRoot

$state = Get-Content "$($RaizRepo4c)\tasks\task023\task_state.json" -Raw | ConvertFrom-Json

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

$state | ConvertTo-Json -Depth 10 | Set-Content "$($RaizRepo4c)\tasks\task023\task_state.json" -Encoding UTF8
Write-Host "Task023 reset for retry"
