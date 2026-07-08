#==============================================================================
# PATCH para OrquestradorMigracao.ps1
#
# OBJETIVO: Adicionar detecção automática de complexidade
#
# INSERIR ESTE CÓDIGO após linha 100 (após Get-NextTaskNumber)
# e ANTES do início do processamento principal
#==============================================================================

#------------------------------------------------------------------------------
# NOVO: Função de Detecção de Complexidade
#------------------------------------------------------------------------------

function Get-ComplexidadeFormulario {
    param([string]$CaminhoSCX)

    Write-Host ""
    Write-Host "============================================================================" -ForegroundColor Cyan
    Write-Host " ANÁLISE DE COMPLEXIDADE" -ForegroundColor Cyan
    Write-Host "============================================================================" -ForegroundColor Cyan
    Write-Host ""

    # 1. Tamanho do arquivo
    $tamanhoKB = (Get-Item $CaminhoSCX).Length / 1KB
    Write-Host "  Tamanho: $([math]::Round($tamanhoKB, 1)) KB" -ForegroundColor White

    # 2. Extrair código temporariamente para análise
    $tempDir = Join-Path $env:TEMP "analise_$(Get-Random)"
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

    try {
        # Executar ExtractSCXCode
        $vfpScript = @"
CD C:\4c\projeto\app\utils
SET PROCEDURE TO ExtractSCXCode.prg ADDITIVE
DO ExtractSCXCode WITH "$CaminhoSCX", "$tempDir\"
QUIT
"@
        $vfpScriptPath = Join-Path $tempDir "extract.prg"
        $vfpScript | Out-File -FilePath $vfpScriptPath -Encoding ASCII

        $vfpExe = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\VFP9.EXE"
        $null = & $vfpExe $vfpScriptPath 2>&1

        # Analisar código extraído
        $codigoFonte = Get-ChildItem -Path $tempDir -Filter "*_codigo_fonte.txt" -ErrorAction SilentlyContinue | Select-Object -First 1

        if (-not $codigoFonte) {
            Write-Host "  [AVISO] Não foi possível extrair código para análise. Assumindo SIMPLES." -ForegroundColor Yellow
            return @{
                Classificacao = "SIMPLES"
                Pontuacao = 0
                TamanhoKB = $tamanhoKB
                TotalCampos = 0
                NumLookups = 0
                NumGrids = 0
                NumProcedures = 0
            }
        }

        $conteudo = Get-Content $codigoFonte.FullName -Raw

        # Contar elementos
        $numTextBoxes = ([regex]::Matches($conteudo, "BaseClass: textbox")).Count
        $numCommandButtons = ([regex]::Matches($conteudo, "BaseClass: commandbutton")).Count
        $numGrids = ([regex]::Matches($conteudo, "BaseClass: grid")).Count
        $numProcedures = ([regex]::Matches($conteudo, "(?m)^PROCEDURE ")).Count
        $numLookups = ([regex]::Matches($conteudo, "F4|F5|BuscaSel|FormBuscaAuxiliar")).Count

        $totalCampos = $numTextBoxes

        Write-Host "  Campos (TextBoxes): $totalCampos" -ForegroundColor White
        Write-Host "  Lookups estimados: $numLookups" -ForegroundColor White
        Write-Host "  Grids: $numGrids" -ForegroundColor White
        Write-Host "  Procedures: $numProcedures" -ForegroundColor White
        Write-Host "  CommandButtons: $numCommandButtons" -ForegroundColor White
        Write-Host ""

        # Classificar
        $pontuacao = 0

        # Limites (configuráveis)
        $limites = @{
            TamanhoMax_KB = 500
            CamposMax = 30
            LookupsMax = 5
            ProceduresMax = 50
            GridsMax = 1
        }

        if ($tamanhoKB -gt $limites.TamanhoMax_KB) { $pontuacao += 2 }
        if ($totalCampos -gt $limites.CamposMax) { $pontuacao += 2 }
        if ($numLookups -gt $limites.LookupsMax) { $pontuacao += 1 }
        if ($numProcedures -gt $limites.ProceduresMax) { $pontuacao += 2 }
        if ($numGrids -gt $limites.GridsMax) { $pontuacao += 1 }

        $classificacao = if ($pontuacao -ge 4) { "COMPLEXO" }
                        elseif ($pontuacao -ge 2) { "MEDIO" }
                        else { "SIMPLES" }

        Write-Host "  CLASSIFICAÇÃO: " -NoNewline

        switch ($classificacao) {
            "SIMPLES" {
                Write-Host "SIMPLES" -ForegroundColor Green
                Write-Host "  Estratégia: Processamento único (8 etapas padrão)" -ForegroundColor Green
            }
            "MEDIO" {
                Write-Host "MÉDIO" -ForegroundColor Yellow
                Write-Host "  Estratégia: Processamento único com atenção redobrada" -ForegroundColor Yellow
            }
            "COMPLEXO" {
                Write-Host "COMPLEXO" -ForegroundColor Red
                Write-Host "  Estratégia: Processamento multi-fase automático" -ForegroundColor Red
            }
        }

        Write-Host ""

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
# NOVO: Lógica de Roteamento Automático
#------------------------------------------------------------------------------

# INSERIR ANTES DO INÍCIO DO PROCESSAMENTO PRINCIPAL
# (logo após carregar configuração e antes de buscar próximo arquivo)

# Se há arquivo específico ou continua de task anterior, detectar complexidade
$usarProcessamentoComplexo = $false
$analiseComplexidade = $null

if ($TaskId) {
    # Continuando task específica
    $taskPath = Join-Path $config.paths.tasks $TaskId
    $scxFile = Get-ChildItem -Path $taskPath -Filter "*.scx" -ErrorAction SilentlyContinue | Select-Object -First 1

    if ($scxFile) {
        $analiseComplexidade = Get-ComplexidadeFormulario -CaminhoSCX $scxFile.FullName

        if ($analiseComplexidade.Classificacao -eq "COMPLEXO") {
            $usarProcessamentoComplexo = $true
        }
    }
}
elseif (-not $ContinueFromLastTask) {
    # Processando novo arquivo de origem
    $proximoArquivo = Get-NextOriginalFile  # Função já existente no OrquestradorMigracao.ps1

    if ($proximoArquivo) {
        $analiseComplexidade = Get-ComplexidadeFormulario -CaminhoSCX $proximoArquivo.SCX

        if ($analiseComplexidade.Classificacao -eq "COMPLEXO") {
            $usarProcessamentoComplexo = $true
        }
    }
}

# Se detectou formulário COMPLEXO, delegar para OrquestradorComplexo.ps1
if ($usarProcessamentoComplexo) {
    Write-Host "============================================================================" -ForegroundColor Magenta
    Write-Host " REDIRECIONANDO PARA PROCESSAMENTO MULTI-FASE" -ForegroundColor Magenta
    Write-Host "============================================================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "Formulário classificado como COMPLEXO." -ForegroundColor Yellow
    Write-Host "Executando OrquestradorComplexo.ps1 para processamento em múltiplas fases..." -ForegroundColor Yellow
    Write-Host ""

    $orquestradorComplexo = Join-Path $scriptDir "OrquestradorComplexo.ps1"

    if (-not (Test-Path $orquestradorComplexo)) {
        Write-Host "ERRO: OrquestradorComplexo.ps1 não encontrado em: $orquestradorComplexo" -ForegroundColor Red
        Write-Host ""
        Write-Host "Este formulário requer processamento multi-fase devido à complexidade:" -ForegroundColor Yellow
        Write-Host "  - Tamanho: $([math]::Round($analiseComplexidade.TamanhoKB, 1)) KB" -ForegroundColor Yellow
        Write-Host "  - Campos: $($analiseComplexidade.TotalCampos)" -ForegroundColor Yellow
        Write-Host "  - Procedures: $($analiseComplexidade.NumProcedures)" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "SOLUÇÃO:" -ForegroundColor Cyan
        Write-Host "  1. Usar metodologia manual: C:\4c\docs\METODOLOGIA_ARQUIVOS_GRANDES.md" -ForegroundColor Cyan
        Write-Host "  2. OU implementar OrquestradorComplexo.ps1" -ForegroundColor Cyan
        Write-Host ""
        exit 1
    }

    # Executar OrquestradorComplexo.ps1 e repassar exit code
    if ($TaskId) {
        & $orquestradorComplexo -TaskId $TaskId
    }
    else {
        & $orquestradorComplexo -Arquivo $proximoArquivo.SCX -Analise $analiseComplexidade
    }

    exit $LASTEXITCODE
}

# Se chegou aqui, é formulário SIMPLES/MÉDIO - continuar com processamento normal
Write-Host "Prosseguindo com processamento padrão (8 etapas)..." -ForegroundColor Green
Write-Host ""

# O CÓDIGO ORIGINAL DO OrquestradorMigracao.ps1 CONTINUA AQUI...
