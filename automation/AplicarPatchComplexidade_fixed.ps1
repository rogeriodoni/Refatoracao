#==============================================================================
# AplicarPatchComplexidade.ps1
#
# APLICA PATCH de detecc~ao autom'atica ao OrquestradorMigracao.ps1
#
# USO:
#   .\AplicarPatchComplexidade.ps1
#
# O QUE FAZ:
#   1. Faz backup do OrquestradorMigracao.ps1 original
#   2. Adiciona c'odigo de detecc~ao de complexidade
#   3. Adiciona roteamento autom'atico (SIMPLES -> normal, COMPLEXO -> multi-fase)
#   4. Mant'em compatibilidade com uso atual
#
# RESULTADO:
#   OrquestradorMigracao.ps1 passa a ter detecc~ao autom'atica interna
#==============================================================================

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $PSCommandPath
$orquestradorPath = Join-Path $scriptDir "OrquestradorMigracao.ps1"
$patchPath = Join-Path $scriptDir "PATCH_OrquestradorMigracao.ps1"
$backupPath = Join-Path $scriptDir "OrquestradorMigracao.ps1.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"

Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host " APLICAR PATCH DE DETECC~AO AUTOM'ATICA" -ForegroundColor Cyan
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host ""

# Validar arquivos
if (-not (Test-Path $orquestradorPath)) {
    Write-Host "ERRO: OrquestradorMigracao.ps1 n~ao encontrado em: $orquestradorPath" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $patchPath)) {
    Write-Host "ERRO: PATCH_OrquestradorMigracao.ps1 n~ao encontrado em: $patchPath" -ForegroundColor Red
    exit 1
}

# Fazer backup
Write-Host "[1/4] Criando backup..." -ForegroundColor Yellow
Copy-Item -Path $orquestradorPath -Destination $backupPath -Force
Write-Host "  Backup salvo em: $backupPath" -ForegroundColor Green
Write-Host ""

# Ler arquivos
Write-Host "[2/4] Lendo arquivos..." -ForegroundColor Yellow
$conteudoOriginal = Get-Content -Path $orquestradorPath -Raw
$conteudoPatch = Get-Content -Path $patchPath -Raw
Write-Host "  Arquivos lidos com sucesso" -ForegroundColor Green
Write-Host ""

# Encontrar ponto de inserc~ao (ap'os Get-NextTaskNumber, linha ~100)
Write-Host "[3/4] Inserindo c'odigo de detecc~ao..." -ForegroundColor Yellow

$linhas = Get-Content -Path $orquestradorPath

# Encontrar linha ap'os "function Get-NextTaskNumber" + "}"
$pontoInsercao = -1
$dentroFuncao = $false

for ($i = 0; $i -lt $linhas.Count; $i++) {
    if ($linhas[$i] -match "^function Get-NextTaskNumber") {
        $dentroFuncao = $true
    }

    if ($dentroFuncao -and $linhas[$i] -match "^}$") {
        $pontoInsercao = $i + 1
        break
    }
}

if ($pontoInsercao -eq -1) {
    Write-Host "ERRO: N~ao foi poss'ivel encontrar ponto de inserc~ao (ap'os Get-NextTaskNumber)" -ForegroundColor Red
    exit 1
}

# Inserir patch
$novasLinhas = @()
$novasLinhas += $linhas[0..($pontoInsercao - 1)]
$novasLinhas += ""
$novasLinhas += "#==============================================================================`r`n# PATCH APLICADO: Detecc~ao Autom'atica de Complexidade`r`n# Data: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`r`n#=============================================================================="
$novasLinhas += $conteudoPatch -split "`r?`n"
$novasLinhas += $linhas[$pontoInsercao..($linhas.Count - 1)]

# Salvar arquivo modificado
$novasLinhas | Out-File -FilePath $orquestradorPath -Encoding UTF8 -Force

Write-Host "  Patch inserido na linha $pontoInsercao" -ForegroundColor Green
Write-Host ""

# Validar
Write-Host "[4/4] Validando..." -ForegroundColor Yellow

# Verificar se arquivo foi modificado
$conteudoNovo = Get-Content -Path $orquestradorPath -Raw

if ($conteudoNovo -notmatch "Get-ComplexidadeFormulario") {
    Write-Host "ERRO: Patch n~ao foi aplicado corretamente!" -ForegroundColor Red
    Write-Host "Restaurando backup..." -ForegroundColor Yellow
    Copy-Item -Path $backupPath -Destination $orquestradorPath -Force
    exit 1
}

Write-Host "  Validac~ao OK!" -ForegroundColor Green
Write-Host ""

# Resumo
Write-Host "============================================================================" -ForegroundColor Green
Write-Host " PATCH APLICADO COM SUCESSO!" -ForegroundColor Green
Write-Host "============================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "MUDANCAS:" -ForegroundColor Cyan
Write-Host "  
iconv: AplicarPatchComplexidade.ps1:116:14: cannot convert
