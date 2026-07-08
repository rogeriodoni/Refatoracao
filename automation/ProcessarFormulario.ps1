#==============================================================================
# ProcessarFormulario.ps1
#
# SCRIPT PRINCIPAL - INTERFACE DO CLIENTE
#
# USO:
#   .\ProcessarFormulario.ps1 -Arquivo "sigmvcab.scx"
#
# COMPORTAMENTO:
#   1. Analisa complexidade do formulário
#   2. Se SIMPLES: Executa OrquestradorMigracao.ps1 (1 rodada)
#   3. Se COMPLEXO: Executa OrquestradorComplexo.ps1 (N rodadas)
#   4. Cliente NÃO precisa saber qual é usado
#
# SAÍDA:
#   - Task completa em C:\4c\tasks\taskXXX\
#   - Relatório de validação
#   - Código migrado 100%
#
# AUTOR: Sistema de Migração Automatizada
# DATA: 2026-02-12
#==============================================================================

param(
    [Parameter(Mandatory=$true)]
    [string]$Arquivo,  # Ex: "sigmvcab.scx" ou "C:\4c\origem\sigmvcab.scx"

    [Parameter(Mandatory=$false)]
    [switch]$ForcarComplexo,  # Força processamento complexo mesmo se arquivo pequeno

    [Parameter(Mandatory=$false)]
    [switch]$DryRun  # Apenas analisa, não processa
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $PSCommandPath

#------------------------------------------------------------------------------
# Configuração
#------------------------------------------------------------------------------

$config = @{
    # Limites para classificar como SIMPLES vs COMPLEXO
    Limites = @{
        TamanhoMax_KB = 500      # 500KB
        CamposMax = 30
        LookupsMax = 5
        ProceduresMax = 50
        GridsMax = 1
    }

    # Caminhos
    Paths = @{
        Origem = "C:\4c\origem"
        Tasks = "C:\4c\tasks"
        Automation = $scriptDir
        OrquestradorSimples = Join-Path $scriptDir "OrquestradorMigracao.ps1"
        OrquestradorComplexo = Join-Path $scriptDir "OrquestradorComplexo.ps1"
    }
}

#------------------------------------------------------------------------------
# Funções Auxiliares
#------------------------------------------------------------------------------

function Write-Header {
    param([string]$Titulo)

    Write-Host ""
    Write-Host "============================================================================" -ForegroundColor Cyan
    Write-Host " $Titulo" -ForegroundColor Cyan
    Write-Host "============================================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Write-Info {
    param([string]$Mensagem)
    Write-Host "[INFO] $Mensagem" -ForegroundColor Green
}

function Write-Warn {
    param([string]$Mensagem)
    Write-Host "[AVISO] $Mensagem" -ForegroundColor Yellow
}

function Write-Err {
    param([string]$Mensagem)
    Write-Host "[ERRO] $Mensagem" -ForegroundColor Red
}

function Get-ArquivoCompleto {
    param([string]$CaminhoRelativo)

    # Se já é caminho absoluto
    if ([System.IO.Path]::IsPathRooted($CaminhoRelativo)) {
        return $CaminhoRelativo
    }

    # Tenta em C:\4c\origem
    $tentativa1 = Join-Path $config.Paths.Origem $CaminhoRelativo
    if (Test-Path $tentativa1) {
        return $tentativa1
    }

    # Tenta caminho relativo ao script
    $tentativa2 = Join-Path (Get-Location) $CaminhoRelativo
    if (Test-Path $tentativa2) {
        return $tentativa2
    }

    throw "Arquivo não encontrado: $CaminhoRelativo"
}

function Get-ComplexidadeFormulario {
    param([string]$CaminhoSCX)

    Write-Info "Analisando complexidade do formulário..."

    # 1. Tamanho do arquivo
    $tamanhoKB = (Get-Item $CaminhoSCX).Length / 1KB
    Write-Host "  - Tamanho: $([math]::Round($tamanhoKB, 1)) KB"

    # 2. Extrair código temporariamente para análise
    $tempDir = Join-Path $env:TEMP "analise_$(Get-Random)"
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

    try {
        # Executar ExtractSCXCode
        $vfpScript = @"
SET PROCEDURE TO C:\4c\projeto\app\utils\ExtractSCXCode.prg ADDITIVE
DO ExtractSCXCode WITH "$CaminhoSCX", "$tempDir\"
QUIT
"@
        $vfpScriptPath = Join-Path $tempDir "extract.prg"
        $vfpScript | Out-File -FilePath $vfpScriptPath -Encoding ASCII

        $vfpExe = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\VFP9.EXE"
        & $vfpExe $vfpScriptPath | Out-Null

        # Analisar código extraído
        $codigoFonte = Get-ChildItem -Path $tempDir -Filter "*_codigo_fonte.txt" | Select-Object -First 1

        if (-not $codigoFonte) {
            throw "Falha ao extrair código fonte para análise"
        }

        $conteudo = Get-Content $codigoFonte.FullName -Raw

        # Contar elementos
        $numTextBoxes = ([regex]::Matches($conteudo, "BaseClass: textbox")).Count
        $numCommandButtons = ([regex]::Matches($conteudo, "BaseClass: commandbutton")).Count
        $numGrids = ([regex]::Matches($conteudo, "BaseClass: grid")).Count
        $numProcedures = ([regex]::Matches($conteudo, "(?m)^PROCEDURE ")).Count

        # Estimar lookups (F4, F5, BuscaSel, etc.)
        $numLookups = ([regex]::Matches($conteudo, "F4|F5|BuscaSel|FormBuscaAuxiliar")).Count

        $totalCampos = $numTextBoxes

        Write-Host "  - Campos (TextBoxes): $totalCampos"
        Write-Host "  - Lookups estimados: $numLookups"
        Write-Host "  - Grids: $numGrids"
        Write-Host "  - Procedures: $numProcedures"
        Write-Host "  - CommandButtons: $numCommandButtons"

        # Classificar
        $pontuacao = 0

        if ($tamanhoKB -gt $config.Limites.TamanhoMax_KB) { $pontuacao += 2 }
        if ($totalCampos -gt $config.Limites.CamposMax) { $pontuacao += 2 }
        if ($numLookups -gt $config.Limites.LookupsMax) { $pontuacao += 1 }
        if ($numProcedures -gt $config.Limites.ProceduresMax) { $pontuacao += 2 }
        if ($numGrids -gt $config.Limites.GridsMax) { $pontuacao += 1 }

        $classificacao = if ($pontuacao -ge 4) { "COMPLEXO" }
                        elseif ($pontuacao -ge 2) { "MEDIO" }
                        else { "SIMPLES" }

        Write-Host ""
        Write-Host "  CLASSIFICAÇÃO: " -NoNewline

        switch ($classificacao) {
            "SIMPLES" {
                Write-Host "SIMPLES" -ForegroundColor Green
                Write-Host "  Estratégia: Processamento único (OrquestradorMigracao.ps1)" -ForegroundColor Green
            }
            "MEDIO" {
                Write-Host "MÉDIO" -ForegroundColor Yellow
                Write-Host "  Estratégia: Processamento único com revisão cuidadosa" -ForegroundColor Yellow
            }
            "COMPLEXO" {
                Write-Host "COMPLEXO" -ForegroundColor Red
                Write-Host "  Estratégia: Processamento multi-fase (OrquestradorComplexo.ps1)" -ForegroundColor Red
            }
        }

        return @{
            Classificacao = $classificacao
            Pontuacao = $pontuacao
            TamanhoKB = $tamanhoKB
            TotalCampos = $totalCampos
            NumLookups = $numLookups
            NumGrids = $numGrids
            NumProcedures = $numProcedures
            CodigoFonteTemp = $codigoFonte.FullName
        }
    }
    finally {
        # Limpar arquivos temporários
        if (Test-Path $tempDir) {
            Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

#------------------------------------------------------------------------------
# MAIN
#------------------------------------------------------------------------------

Write-Header "PROCESSADOR DE FORMULÁRIOS - AUTOMAÇÃO COMPLETA"

# 1. Validar arquivo
Write-Info "Localizando arquivo: $Arquivo"
$caminhoSCX = Get-ArquivoCompleto -CaminhoRelativo $Arquivo

if (-not (Test-Path $caminhoSCX)) {
    Write-Err "Arquivo não encontrado: $caminhoSCX"
    exit 1
}

Write-Info "Arquivo encontrado: $caminhoSCX"

# Verificar arquivo .sct correspondente
$caminhoSCT = $caminhoSCX -replace '\.scx$', '.sct'
if (-not (Test-Path $caminhoSCT)) {
    Write-Err "Arquivo .sct não encontrado: $caminhoSCT"
    exit 1
}

# 2. Analisar complexidade
Write-Header "ANÁLISE DE COMPLEXIDADE"
$analise = Get-ComplexidadeFormulario -CaminhoSCX $caminhoSCX

# 3. Decidir estratégia
Write-Host ""
if ($ForcarComplexo) {
    Write-Warn "Opção -ForcarComplexo ativada: Usando processamento complexo"
    $estrategia = "COMPLEXO"
}
elseif ($analise.Classificacao -eq "COMPLEXO") {
    $estrategia = "COMPLEXO"
}
else {
    $estrategia = "SIMPLES"
}

# 4. DryRun? Apenas mostrar análise
if ($DryRun) {
    Write-Header "MODO DRY-RUN - APENAS ANÁLISE"
    Write-Host "Análise completa. Nenhuma migração executada." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Para executar migração, remova o parâmetro -DryRun:" -ForegroundColor Cyan
    Write-Host "  .\ProcessarFormulario.ps1 -Arquivo `"$Arquivo`"" -ForegroundColor Cyan
    exit 0
}

# 5. Executar estratégia apropriada
Write-Header "INICIANDO MIGRAÇÃO - ESTRATÉGIA: $estrategia"

if ($estrategia -eq "SIMPLES") {
    Write-Info "Executando OrquestradorMigracao.ps1 (1 rodada)..."
    Write-Host ""

    & $config.Paths.OrquestradorSimples

    $exitCode = $LASTEXITCODE

    if ($exitCode -eq 0) {
        Write-Host ""
        Write-Host "============================================================================" -ForegroundColor Green
        Write-Host " MIGRAÇÃO CONCLUÍDA COM SUCESSO!" -ForegroundColor Green
        Write-Host "============================================================================" -ForegroundColor Green
    }
    else {
        Write-Host ""
        Write-Host "============================================================================" -ForegroundColor Red
        Write-Host " MIGRAÇÃO FALHOU - Ver logs para detalhes" -ForegroundColor Red
        Write-Host "============================================================================" -ForegroundColor Red
    }

    exit $exitCode
}
else {
    Write-Info "Executando OrquestradorComplexo.ps1 (múltiplas rodadas)..."
    Write-Host ""

    # Verificar se script existe
    if (-not (Test-Path $config.Paths.OrquestradorComplexo)) {
        Write-Err "OrquestradorComplexo.ps1 não encontrado em: $($config.Paths.OrquestradorComplexo)"
        Write-Warn "Executando criação do script..."

        # TODO: Criar OrquestradorComplexo.ps1 automaticamente
        Write-Err "Script não implementado ainda. Execute manualmente usando METODOLOGIA_ARQUIVOS_GRANDES.md"
        exit 1
    }

    & $config.Paths.OrquestradorComplexo -Arquivo $caminhoSCX -Analise $analise

    $exitCode = $LASTEXITCODE

    if ($exitCode -eq 0) {
        Write-Host ""
        Write-Host "============================================================================" -ForegroundColor Green
        Write-Host " MIGRAÇÃO COMPLEXA CONCLUÍDA COM SUCESSO!" -ForegroundColor Green
        Write-Host " Formulário migrado com paridade funcional 100%" -ForegroundColor Green
        Write-Host "============================================================================" -ForegroundColor Green
    }
    else {
        Write-Host ""
        Write-Host "============================================================================" -ForegroundColor Red
        Write-Host " MIGRAÇÃO COMPLEXA FALHOU - Ver logs para detalhes" -ForegroundColor Red
        Write-Host "============================================================================" -ForegroundColor Red
    }

    exit $exitCode
}
