# TesteProcessamentoFaseado.ps1
# Script para testar detecção de complexidade e processamento faseado

param(
    [string]$TaskId = "task012"  # Default: sigmvcab
)

Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "  TESTE: DETECÇÃO DE COMPLEXIDADE E PROCESSAMENTO FASEADO" -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host ""

# Carrega configuração
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$configFile = Join-Path $scriptDir "config.json"

if (-not (Test-Path $configFile)) {
    Write-Host "ERRO: config.json não encontrado em $configFile" -ForegroundColor Red
    exit 1
}

$config = Get-Content $configFile -Raw | ConvertFrom-Json

# Carrega funções do OrquestradorMigracao.ps1
. (Join-Path $scriptDir "OrquestradorMigracao.ps1")

# Testa detecção de complexidade
$taskPath = Join-Path $config.paths.tasks $TaskId
$txtFiles = Get-ChildItem -Path $taskPath -Filter "*_form_codigo_fonte.txt" -File | Where-Object { $_.Name -notlike "*_slim*" }

if ($txtFiles.Count -eq 0) {
    Write-Host "ERRO: Arquivo *_form_codigo_fonte.txt não encontrado em $taskPath" -ForegroundColor Red
    exit 1
}

$txtFile = $txtFiles[0].FullName

Write-Host "Testando arquivo: $($txtFiles[0].Name)" -ForegroundColor Yellow
Write-Host ""

# Testa função Get-ComplexidadeArquivo
Write-Host "[TESTE 1] Get-ComplexidadeArquivo" -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Cyan

$complexidade = Get-ComplexidadeArquivo -CaminhoTxt $txtFile

Write-Host "Resultado:" -ForegroundColor Yellow
Write-Host "  - Tamanho: $($complexidade.TamanhoKB) KB" -ForegroundColor White
Write-Host "  - Linhas: $($complexidade.Linhas)" -ForegroundColor White
Write-Host "  - Classificação: $($complexidade.Classificacao)" -ForegroundColor $(if ($complexidade.Classificacao -eq "COMPLEXO") { "Yellow" } else { "Green" })

if ($complexidade.Classificacao -eq "COMPLEXO") {
    Write-Host "  - Número de Fases: $($complexidade.NumFases)" -ForegroundColor White
    Write-Host "  - Motivo: $($complexidade.Motivo)" -ForegroundColor White
}

Write-Host ""

# Testa geração de prompt de fase
if ($complexidade.Classificacao -eq "COMPLEXO") {
    Write-Host "[TESTE 2] New-PromptFase (Fase 1)" -ForegroundColor Cyan
    Write-Host "----------------------------------------" -ForegroundColor Cyan

    # Extrai BaseName do nome do arquivo
    $fileName = $txtFiles[0].BaseName
    $baseName = $fileName -replace "_form_codigo_fonte$", ""

    $metaPromptFile = Join-Path $taskPath "meta_prompt.md"
    if (Test-Path $metaPromptFile) {
        $metaPromptOriginal = Get-Content $metaPromptFile -Raw
    } else {
        $metaPromptOriginal = "# Meta Prompt Original (não encontrado)"
    }

    $promptFase1 = New-PromptFase -NumeroFase 1 -TotalFases 4 `
        -TaskPath $taskPath -BaseName $baseName `
        -MetaPromptOriginal $metaPromptOriginal

    $promptTestFile = Join-Path $taskPath "teste_fase1_prompt.md"
    Set-Content -Path $promptTestFile -Value $promptFase1 -Encoding UTF8

    Write-Host "Prompt Fase 1 gerado: $promptTestFile" -ForegroundColor Green
    Write-Host ""
    Write-Host "Primeiras linhas:" -ForegroundColor Yellow
    Get-Content $promptTestFile | Select-Object -First 20 | ForEach-Object { Write-Host "  $_" -ForegroundColor White }
    Write-Host ""
}

# Resumo do teste
Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "  RESUMO DO TESTE" -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host ""

if ($complexidade.Classificacao -eq "COMPLEXO") {
    Write-Host "✅ Arquivo detectado como COMPLEXO" -ForegroundColor Green
    Write-Host "✅ Função Get-ComplexidadeArquivo funcionando" -ForegroundColor Green
    Write-Host "✅ Função New-PromptFase funcionando" -ForegroundColor Green
    Write-Host ""
    Write-Host "Próximo passo: Executar migração com processamento faseado" -ForegroundColor Yellow
    Write-Host "  Comando: .\OrquestradorMigracao.ps1 -TaskId $TaskId" -ForegroundColor Cyan
} else {
    Write-Host "⚠️ Arquivo detectado como SIMPLES" -ForegroundColor Yellow
    Write-Host "   Processamento faseado NÃO será ativado" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Para testar processamento faseado, use arquivo > 800KB ou > 15.000 linhas" -ForegroundColor Cyan
}

Write-Host ""
