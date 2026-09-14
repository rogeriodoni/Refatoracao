#==============================================================================
# AplicarPatchComplexidade_v2.ps1 - VERSAO CORRIGIDA
#==============================================================================

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $PSCommandPath
$orquestradorPath = Join-Path $scriptDir "OrquestradorMigracao.ps1"
$patchPath = Join-Path $scriptDir "PATCH_OrquestradorMigracao.ps1"
$backupPath = Join-Path $scriptDir "OrquestradorMigracao.ps1.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"

Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host " APLICAR PATCH DE DETECCAO AUTOMATICA" -ForegroundColor Cyan
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host ""

# Validar arquivos
if (-not (Test-Path $orquestradorPath)) {
    Write-Host "ERRO: OrquestradorMigracao.ps1 nao encontrado" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $patchPath)) {
    Write-Host "ERRO: PATCH_OrquestradorMigracao.ps1 nao encontrado" -ForegroundColor Red
    exit 1
}

# Fazer backup
Write-Host "[1/4] Criando backup..." -ForegroundColor Yellow
Copy-Item -Path $orquestradorPath -Destination $backupPath -Force
Write-Host "  Backup salvo em: $backupPath" -ForegroundColor Green
Write-Host ""

# Ler arquivos
Write-Host "[2/4] Lendo arquivos..." -ForegroundColor Yellow
$linhas = Get-Content -Path $orquestradorPath
$conteudoPatch = Get-Content -Path $patchPath
Write-Host "  Arquivos lidos com sucesso" -ForegroundColor Green
Write-Host ""

# Encontrar ponto de insercao
Write-Host "[3/4] Inserindo codigo de deteccao..." -ForegroundColor Yellow

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
    Write-Host "ERRO: Nao foi possivel encontrar ponto de insercao" -ForegroundColor Red
    exit 1
}

# Inserir patch
$novasLinhas = @()
$novasLinhas += $linhas[0..($pontoInsercao - 1)]
$novasLinhas += ""
$novasLinhas += "#=============================================================================="
$novasLinhas += "# PATCH APLICADO: Deteccao Automatica de Complexidade"
$novasLinhas += "# Data: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$novasLinhas += "#=============================================================================="
$novasLinhas += $conteudoPatch
$novasLinhas += $linhas[$pontoInsercao..($linhas.Count - 1)]

# Salvar
$novasLinhas | Out-File -FilePath $orquestradorPath -Encoding UTF8 -Force

Write-Host "  Patch inserido na linha $pontoInsercao" -ForegroundColor Green
Write-Host ""

# Validar
Write-Host "[4/4] Validando..." -ForegroundColor Yellow

$conteudoNovo = Get-Content -Path $orquestradorPath -Raw

if ($conteudoNovo -notmatch "Get-ComplexidadeFormulario") {
    Write-Host "ERRO: Patch nao foi aplicado corretamente!" -ForegroundColor Red
    Write-Host "Restaurando backup..." -ForegroundColor Yellow
    Copy-Item -Path $backupPath -Destination $orquestradorPath -Force
    exit 1
}

Write-Host "  Validacao OK!" -ForegroundColor Green
Write-Host ""

# Resumo
Write-Host "============================================================================" -ForegroundColor Green
Write-Host " PATCH APLICADO COM SUCESSO!" -ForegroundColor Green
Write-Host "============================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "MUDANCAS:" -ForegroundColor Cyan
Write-Host "  - Adicionada funcao Get-ComplexidadeFormulario()" -ForegroundColor White
Write-Host "  - Adicionado roteamento automatico (SIMPLES/COMPLEXO)" -ForegroundColor White
Write-Host "  - Backup criado em: $backupPath" -ForegroundColor White
Write-Host ""
Write-Host "USO:" -ForegroundColor Cyan
Write-Host "  .\OrquestradorMigracao.ps1" -ForegroundColor White
Write-Host ""
Write-Host "COMPORTAMENTO:" -ForegroundColor Cyan
Write-Host "  - Formulario SIMPLES -> Processa normalmente (8 etapas)" -ForegroundColor Green
Write-Host "  - Formulario COMPLEXO -> Redireciona para OrquestradorComplexo.ps1" -ForegroundColor Yellow
Write-Host ""

exit 0
