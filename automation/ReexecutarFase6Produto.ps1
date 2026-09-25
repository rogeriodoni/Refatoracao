#==============================================================================
# ReexecutarFase6Produto.ps1
#
# PROPOSITO: re-executar SO a Fase 6 da task569 (SIGCDPRO / Erro178).
#
#   Na rodada de 2026-09-24 a Fase 6 ("Form - Campos Restantes e Lookups")
#   voltou em 13 segundos com o modelo respondendo
#     "this appears to be context-loading rather than an active request...
#      What would you like me to do next?"
#   exit code 0 e o .prg INTACTO. O orquestrador contou como sucesso e seguiu.
#   O prompt (fase_6_prompt.md) esta correto e ficou gravado na task, entao da
#   para re-executar a fase isolada, com o MESMO contexto que o orquestrador usa.
#
#   A guarda de no-op instalada no OrquestradorMigracao.ps1 (hash do alvo antes
#   e depois) evita que isso volte a passar batido nas proximas rodadas; aqui a
#   mesma checagem eh feita localmente, porque esta chamada nao passa por ele.
#
# USO:
#   .\ReexecutarFase6Produto.ps1
#   .\ReexecutarFase6Produto.ps1 -Model opus
#==============================================================================

param(
    [string]$TaskDir = "C:\4c\tasks\task569",
    [string]$Model   = "sonnet",
    [int]$Timeout    = 3600
)

$ErrorActionPreference = "Stop"

$config     = Get-Content "C:\4c\automation\config.json" -Raw | ConvertFrom-Json
$promptFile = Join-Path $TaskDir "fase_6_prompt.md"
$outputFile = Join-Path $TaskDir "fase_6_output_rerun.txt"
$logFile    = Join-Path $TaskDir "logs\05_migracao_fase6_rerun.log"
$alvo       = "C:\4c\projeto\app\forms\cadastros\FormProduto.prg"

if (-not (Test-Path $promptFile)) { throw "prompt da Fase 6 nao encontrado: $promptFile" }
if (-not (Test-Path $alvo))       { throw "FormProduto.prg nao encontrado: $alvo" }
$logDir = Split-Path -Parent $logFile
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir -Force | Out-Null }

# Mesmo contexto que o orquestrador monta para as fases de Form
$contextFiles = @(
    "C:\4c\docs\FORMCOR_LICOES_APRENDIDAS.md",
    "C:\4c\docs\migration_guide.md",
    "C:\4c\docs\framework_frmcadastro_layout.md",
    (Join-Path $TaskDir "comportamento.json"),
    (Join-Path $TaskDir "layout.json")
)
$contextFiles += (Get-ChildItem (Join-Path $TaskDir "sigcdpro_*.png") | ForEach-Object { $_.FullName })
$contextFiles += (Join-Path $TaskDir "sigcdpro_form_codigo_fonte_nanoSlim.txt")
$contextFiles += (Join-Path $TaskDir "mapeamento.json")
$contextFiles = $contextFiles | Where-Object { Test-Path $_ }

$antesHash   = (Get-FileHash $alvo -Algorithm MD5).Hash
$antesLinhas = (Get-Content $alvo).Count
Write-Host "ANTES : $antesLinhas linhas  ($antesHash)" -ForegroundColor Cyan
Write-Host "Contexto: $($contextFiles.Count) arquivo(s) | Modelo: $Model" -ForegroundColor Cyan

& "C:\4c\automation\ClaudeInvoker.ps1" `
    -PromptFile $promptFile `
    -OutputFile $outputFile `
    -Model $Model `
    -Timeout $Timeout `
    -LogFile $logFile `
    -ContextFiles $contextFiles `
    -RateLimitMaxRetries $config.rateLimitRetry.maxRetries `
    -RateLimitInitialDelaySeconds $config.rateLimitRetry.initialDelaySeconds `
    -RateLimitMaxDelaySeconds $config.rateLimitRetry.maxDelaySeconds `
    -RateLimitBackoffMultiplier $config.rateLimitRetry.backoffMultiplier `
    -UsageLimitWaitSeconds $config.rateLimitRetry.usageLimitWaitSeconds `
    -MaxOutputTokens $config.claude.maxOutputTokens

$depoisHash   = (Get-FileHash $alvo -Algorithm MD5).Hash
$depoisLinhas = (Get-Content $alvo).Count
Write-Host "DEPOIS: $depoisLinhas linhas  ($depoisHash)" -ForegroundColor Cyan

if ($antesHash -eq $depoisHash) {
    Write-Host ""
    Write-Host "[NO-OP] a Fase 6 NAO alterou o FormProduto.prg de novo." -ForegroundColor Red
    $out = if (Test-Path $outputFile) { Get-Content $outputFile -Raw } else { "" }
    if ($out.Length -gt 600) { $out = $out.Substring($out.Length - 600) }
    Write-Host "Fim do output:" -ForegroundColor DarkGray
    Write-Host $out -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "Proximo passo: re-executar com -Model opus" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host ("OK: a fase alterou o arquivo (+{0} linhas)" -f ($depoisLinhas - $antesLinhas)) -ForegroundColor Green
Write-Host "Conferir com: .\VerificarRemigracaoProduto.ps1" -ForegroundColor Cyan
exit 0
