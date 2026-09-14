#==============================================================================
# OrquestradorComplexo.ps1
#
# ORQUESTRADOR MULTI-FASE PARA FORMULARIOS COMPLEXOS
#
# RESPONSABILIDADE:
#   Executa TODAS as fases da metodologia automaticamente:
#   - FASE 0: Inventario (extracao + analise)
#   - FASE 1: Business Object
#   - FASE 2: Estrutura Visual
#   - FASE 3: Campos (dividido em N grupos)
#   - FASE 4: Lookups
#   - FASE 5: Grids
#   - FASE 6: Sincronizacao (FormParaBO/BOParaForm)
#   - FASE 7: Logica de Negocio (dividido em N grupos)
#   - FASE 8: Validacao Final
#
# ESTRATEGIA:
#   1. Cada fase = 1 invocacao do Claude CLI com prompt especifico
#   2. Resultados acumulados entre fases (merge de codigo)
#   3. Escalacao automatica: sonnet(1x) -> sonnet(2x) -> opus(3x)
#   4. Deteccao de arquivos pos-timeout (Claude grava antes de morrer)
#   5. Usage limit detection com abort imediato
#
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-02-12 | REESCRITO: 2026-02-26
#==============================================================================

param(
    [Parameter(Mandatory=$true)]
    [string]$Arquivo,

    [Parameter(Mandatory=$false)]
    [int]$MaxRetries = 2
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $PSCommandPath

#------------------------------------------------------------------------------
# Carregar modulos (APENAS TaskManager - os demais sao scripts standalone)
#------------------------------------------------------------------------------

. (Join-Path $scriptDir "TaskManager.ps1")

#------------------------------------------------------------------------------
# Configuracao
#------------------------------------------------------------------------------

$config = Get-Content (Join-Path $scriptDir "config.json") -Raw | ConvertFrom-Json

#------------------------------------------------------------------------------
# Variaveis globais de analise (populadas apos Fase 0)
#------------------------------------------------------------------------------

$script:analiseData = $null      # Dados de analise.json
$script:formSubDir  = "cadastros" # Subdiretorio do form (cadastros ou relatorios)
$script:formType    = "CRUD"      # Tipo do form (CRUD ou REPORT)

#------------------------------------------------------------------------------
# Variaveis de escalacao (atualizadas por Invoke-Fase a cada tentativa)
#------------------------------------------------------------------------------

$script:faseTimeout = [int]$config.claude.timeout
$script:faseModel   = $config.claude.model

#------------------------------------------------------------------------------
# Funcao auxiliar: Get-NextTaskNumber
#------------------------------------------------------------------------------

function Get-NextTaskNumber {
    $existingTasks = Get-ChildItem -Path $config.paths.tasks -Directory -ErrorAction SilentlyContinue |
                     Where-Object { $_.Name -match '^task(\d+)$' } |
                     ForEach-Object { [int]($_.Name -replace 'task', '') } |
                     Sort-Object -Descending

    if ($existingTasks.Count -eq 0) {
        return 1
    }

    return ($existingTasks[0] + 1)
}

#------------------------------------------------------------------------------
# Funcao auxiliar: Carregar analise.json e popular variaveis globais
#------------------------------------------------------------------------------

function Load-AnaliseData {
    param([string]$TaskPath)

    $analiseFile = Join-Path $TaskPath "analise.json"
    if (Test-Path $analiseFile) {
        $script:analiseData = Get-Content $analiseFile -Raw | ConvertFrom-Json

        if ($script:analiseData.form.formType -eq "REPORT") {
            $script:formSubDir = "relatorios"
            $script:formType = "REPORT"
        } else {
            $script:formSubDir = "cadastros"
            $script:formType = "CRUD"
        }

        Write-Host "[Analise] Tipo: $($script:formType) | SubDir: $($script:formSubDir)" -ForegroundColor DarkGray
        return $true
    }

    Write-Host "[Analise] analise.json nao encontrado em $TaskPath" -ForegroundColor Yellow
    return $false
}

#------------------------------------------------------------------------------
# Funcao auxiliar: Obter caminho esperado do Form
#------------------------------------------------------------------------------

function Get-FormFilePath {
    return (Join-Path $config.paths.projeto "app\forms\$($script:formSubDir)\Form${baseName}.prg")
}

#------------------------------------------------------------------------------
# Funcao auxiliar: Obter caminho esperado do BO
#------------------------------------------------------------------------------

function Get-BOFilePath {
    return (Join-Path $config.paths.projeto "app\classes\${baseName}BO.prg")
}

#------------------------------------------------------------------------------
# Funcao auxiliar: Invocar VFP via VFPExecutor.ps1 (script standalone)
#------------------------------------------------------------------------------

function Invoke-VFP {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ScriptPrg,

        [Parameter(Mandatory=$false)]
        [string[]]$Parameters = @(),

        [Parameter(Mandatory=$false)]
        [string]$LogFile = "",

        [Parameter(Mandatory=$false)]
        [string]$OutputFile = ""
    )

    $vfpScript = Join-Path $scriptDir "VFPExecutor.ps1"
    $splatArgs = @{
        ScriptPrg = $ScriptPrg
        Timeout   = [int]$config.vfp.timeout
    }

    if ($Parameters.Count -gt 0) { $splatArgs.Parameters = $Parameters }
    if ($LogFile)                { $splatArgs.LogFile     = $LogFile }
    if ($OutputFile)             { $splatArgs.OutputFile  = $OutputFile }

    & $vfpScript @splatArgs
}

#------------------------------------------------------------------------------
# Funcao auxiliar: Invocar Claude CLI via ClaudeInvoker.ps1 (script standalone)
#------------------------------------------------------------------------------

function Invoke-Claude {
    param(
        [Parameter(Mandatory=$true)]
        [string]$PromptFile,

        [Parameter(Mandatory=$true)]
        [string]$OutputFile,

        [Parameter(Mandatory=$false)]
        [string]$LogFile = "",

        [Parameter(Mandatory=$false)]
        [string[]]$ContextFiles = @(),

        [Parameter(Mandatory=$false)]
        [string]$Model = $script:faseModel,

        [Parameter(Mandatory=$false)]
        [int]$Timeout = $script:faseTimeout
    )

    $claudeScript = Join-Path $scriptDir "ClaudeInvoker.ps1"
    $splatArgs = @{
        PromptFile                  = $PromptFile
        OutputFile                  = $OutputFile
        Model                       = $Model
        Timeout                     = [int]$Timeout
        RateLimitMaxRetries         = [int]$config.rateLimitRetry.maxRetries
        RateLimitInitialDelaySeconds = [int]$config.rateLimitRetry.initialDelaySeconds
        RateLimitMaxDelaySeconds    = [int]$config.rateLimitRetry.maxDelaySeconds
        RateLimitBackoffMultiplier  = [int]$config.rateLimitRetry.backoffMultiplier
        UsageLimitWaitSeconds       = [int]$config.rateLimitRetry.usageLimitWaitSeconds
        MaxOutputTokens             = [int]$config.claude.maxOutputTokens
        FailFastOnUsageLimit        = $true  # OrquestradorComplexo: abort imediato em usage limit
    }

    if ($LogFile)                  { $splatArgs.LogFile      = $LogFile }
    if ($ContextFiles.Count -gt 0) { $splatArgs.ContextFiles = $ContextFiles }

    Write-Host "  [Claude] Modelo: $Model | Timeout: ${Timeout}s" -ForegroundColor DarkGray

    & $claudeScript @splatArgs

    $localExitCode = $LASTEXITCODE

    # Exit code 50 = usage limit (FailFastOnUsageLimit)
    if ($localExitCode -eq 50) {
        # Ler mensagem de erro do output
        $limitMsg = ""
        if (Test-Path $OutputFile) {
            $limitMsg = Get-Content $OutputFile -Raw -ErrorAction SilentlyContinue
        }
        throw "USAGE_LIMIT: $($limitMsg.Trim())"
    }

    # Verifica usage limit no output (fallback para outros exit codes)
    if ($localExitCode -ne 0 -and (Test-Path $OutputFile)) {
        $outputContent = Get-Content $OutputFile -Raw -ErrorAction SilentlyContinue
        if ($outputContent -match "(?i)(hit.{0,10}(your|the).{0,10}limit|usage.limit|resets?\s+\d)") {
            throw "USAGE_LIMIT: $($outputContent.Trim())"
        }
    }

    return $localExitCode
}

#------------------------------------------------------------------------------
# Funcao auxiliar: Verificar se arquivo gerado existe e e valido (>1KB)
#------------------------------------------------------------------------------

function Test-ArquivoGerado {
    param(
        [string]$FilePath,
        [string]$Descricao,
        [int]$MinSizeBytes = 500
    )

    if (Test-Path $FilePath) {
        $fileSize = (Get-Item $FilePath).Length
        if ($fileSize -ge $MinSizeBytes) {
            Write-Host "  [OK] $Descricao encontrado no disco ($fileSize bytes)" -ForegroundColor Green
            return $true
        } else {
            Write-Host "  [WARN] $Descricao encontrado mas muito pequeno ($fileSize bytes < $MinSizeBytes)" -ForegroundColor Yellow
            return $false
        }
    }

    return $false
}

#------------------------------------------------------------------------------
# Funcao auxiliar: Validar completude do codigo gerado (anti-TODO/stubs)
#------------------------------------------------------------------------------

function Test-CompletudeCodigo {
    param(
        [string]$FilePath,
        [string]$Descricao
    )

    if (-not (Test-Path $FilePath)) {
        Write-Host "  [WARN] $Descricao nao encontrado: $FilePath" -ForegroundColor Yellow
        return $false
    }

    $content = Get-Content $FilePath -Raw -ErrorAction SilentlyContinue
    if (-not $content) { return $false }

    $problemas = @()

    # 1. Detectar TODO/FIXME/HACK/PLACEHOLDER em comentarios VFP (*--)
    $todoPattern = "(?im)^\s*\*\-?\-?\s*(TODO|FIXME|HACK|XXX|PLACEHOLDER)\b"
    $todoMatches = [regex]::Matches($content, $todoPattern)
    foreach ($m in $todoMatches) {
        $problemas += "Marcador encontrado: $($m.Value.Trim())"
    }

    # 2. Detectar procedures/methods vazios (PROCEDURE ... apenas comentarios ... ENDPROC)
    $procPattern = "(?ims)PROCEDURE\s+(\w+)\s*(\(.*?\))?\s*\r?\n(.*?)ENDPROC"
    $procMatches = [regex]::Matches($content, $procPattern)
    foreach ($m in $procMatches) {
        $procName = $m.Groups[1].Value
        $body = $m.Groups[3].Value

        # Ignorar procedures que sao DODEFAULT() only (heranca normal)
        if ($body -match "DODEFAULT\(\)") { continue }

        # Remover comentarios e linhas em branco
        $codeLines = ($body -split "`n" |
                      Where-Object { $_ -match "\S" -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&" } |
                      Measure-Object).Count

        if ($codeLines -eq 0) {
            $problemas += "Procedure vazia (sem codigo): $procName"
        }
    }

    # 3. Detectar "implementar depois" / "proxima fase" em comentarios
    $laterPattern = "(?im)\*.*?(implementar\s+(depois|later|futur)|pr[oó]xima\s+fase|pendente|nao\s+implement)"
    $laterMatches = [regex]::Matches($content, $laterPattern)
    foreach ($m in $laterMatches) {
        $problemas += "Indicador de pendencia: $($m.Value.Trim())"
    }

    if ($problemas.Count -gt 0) {
        Write-Host "  [COMPLETUDE] $Descricao tem $($problemas.Count) problemas:" -ForegroundColor Yellow
        foreach ($p in $problemas[0..([math]::Min(9, $problemas.Count - 1))]) {
            Write-Host "    - $p" -ForegroundColor Yellow
        }
        if ($problemas.Count -gt 10) {
            Write-Host "    ... e mais $($problemas.Count - 10) problemas" -ForegroundColor Yellow
        }
        return $false
    }

    Write-Host "  [OK] ${Descricao} - nenhum TODO/stub/procedure vazia detectado" -ForegroundColor Green
    return $true
}

#------------------------------------------------------------------------------
# Estado da migracao complexa
#------------------------------------------------------------------------------

$estadoMigracao = @{
    TaskId = $null
    FaseAtual = 0
    TotalFases = 0
    Fases = @()
    ArquivosGerados = @{
        BO = $null
        Form = $null
    }
    Inicio = Get-Date
}

#------------------------------------------------------------------------------
# Funcoes de Estado
#------------------------------------------------------------------------------

function Write-FaseHeader {
    param(
        [int]$NumeroFase,
        [int]$TotalFases,
        [string]$NomeFase
    )

    Write-Host ""
    Write-Host "============================================================================" -ForegroundColor Magenta
    Write-Host " FASE $NumeroFase de ${TotalFases}: $NomeFase" -ForegroundColor Magenta
    Write-Host "============================================================================" -ForegroundColor Magenta
    Write-Host ""
}

function Save-EstadoMigracao {
    param([string]$TaskPath)

    $estadoPath = Join-Path $TaskPath "estado_migracao_complexa.json"
    $estadoMigracao | ConvertTo-Json -Depth 10 | Out-File -FilePath $estadoPath -Encoding UTF8
    Write-Host "[Estado] Salvo em: $estadoPath" -ForegroundColor DarkGray
}

function Load-EstadoMigracao {
    param([string]$TaskPath)

    $estadoPath = Join-Path $TaskPath "estado_migracao_complexa.json"

    if (Test-Path $estadoPath) {
        $loaded = Get-Content $estadoPath -Raw | ConvertFrom-Json

        $script:estadoMigracao.TaskId = $loaded.TaskId
        $script:estadoMigracao.FaseAtual = $loaded.FaseAtual
        $script:estadoMigracao.TotalFases = $loaded.TotalFases
        $script:estadoMigracao.Fases = @($loaded.Fases)
        $script:estadoMigracao.ArquivosGerados = @{
            BO = $loaded.ArquivosGerados.BO
            Form = $loaded.ArquivosGerados.Form
        }

        Write-Host "[Estado] Carregado de: $estadoPath" -ForegroundColor DarkGray
        return $true
    }

    return $false
}

#------------------------------------------------------------------------------
# Gerador de Prompts (com substituicao COMPLETA de placeholders)
#------------------------------------------------------------------------------

function New-PromptFase {
    param(
        [string]$NomeFase,
        [string]$TaskPath,
        [hashtable]$Parametros
    )

    $promptsDir = Join-Path $TaskPath "prompts_gerados"
    if (-not (Test-Path $promptsDir)) {
        New-Item -ItemType Directory -Path $promptsDir -Force | Out-Null
    }

    $promptPath = Join-Path $promptsDir "$NomeFase.md"

    # Construir dicionario COMPLETO de placeholders
    $allPlaceholders = @{
        # Dados da task
        TaskId     = $estadoMigracao.TaskId
        TotalFases = $estadoMigracao.TotalFases
        Timestamp  = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        TaskPath   = $TaskPath
        BaseName   = $baseName

        # Dados de analise (se disponiveis)
        FormSubDir = $script:formSubDir
        FormType   = $script:formType
    }

    # Adicionar dados de analise.json se disponiveis
    if ($script:analiseData) {
        $ad = $script:analiseData

        # Contar campos e lookups do analise.json
        $numCampos  = 0
        $numLookups = 0
        $numGrids   = 0

        if ($ad.campos)  { $numCampos  = @($ad.campos).Count }
        if ($ad.lookups) { $numLookups = @($ad.lookups).Count }
        if ($ad.grid -and $ad.grid.temGrid) { $numGrids = 1 }

        $allPlaceholders.TotalCampos  = $numCampos
        $allPlaceholders.NumLookups   = $numLookups
        $allPlaceholders.NumGrids     = $numGrids
        $allPlaceholders.NomeTabela   = if ($ad.form.tabela) { $ad.form.tabela } else { "" }
        $allPlaceholders.DataValidacao = (Get-Date).ToString("yyyy-MM-dd")

        # Gerar lista de lookups formatada
        $listaLookups = ""
        if ($ad.lookups) {
            $idx = 1
            foreach ($lk in $ad.lookups) {
                $listaLookups += "| $idx | $($lk.campo) | $($lk.tabela) | $($lk.campoCodigo) | $($lk.tecla) |`n"
                $idx++
            }
        }
        $allPlaceholders.ListaLookups = $listaLookups

        # Gerar lista de campos formatada
        $listaCampos = ""
        if ($ad.campos) {
            $idx = 1
            foreach ($cp in $ad.campos) {
                $listaCampos += "| $idx | $($cp.nomeOriginal) | $($cp.nomeNovo) |`n"
                $idx++
            }
        }
        $allPlaceholders.ListaCampos = $listaCampos
    } else {
        # Defaults quando analise nao esta disponivel
        $allPlaceholders.TotalCampos    = 0
        $allPlaceholders.NumLookups     = 0
        $allPlaceholders.NumGrids       = 0
        $allPlaceholders.NomeTabela     = ""
        $allPlaceholders.DataValidacao  = (Get-Date).ToString("yyyy-MM-dd")
        $allPlaceholders.ListaLookups   = "(nenhum lookup identificado)"
        $allPlaceholders.ListaCampos    = "(nenhum campo identificado)"
    }

    # Mesclar parametros especificos da fase (sobrescrevem defaults)
    foreach ($key in $Parametros.Keys) {
        $allPlaceholders[$key] = $Parametros[$key]
    }

    # Carregar template se existir
    # Normalizar nome: "03A_Campos" -> template "03_Campos"
    $templateName = $NomeFase -replace '(\d{2})[A-Z]_', '$1_'
    $templatePath = Join-Path $scriptDir "templates_prompts\$templateName.md"

    if (Test-Path $templatePath) {
        $template = Get-Content $templatePath -Raw

        # Substituir TODOS os placeholders
        foreach ($key in $allPlaceholders.Keys) {
            $template = $template -replace "\{\{$key\}\}", "$($allPlaceholders[$key])"
        }

        # FOOTER OBRIGATORIO: Anti-TODO/stubs (adicionado a TODOS os prompts)
        $antiTodoFooter = @"

---

## REGRA OBRIGATORIA DE COMPLETUDE (APLICADA A ESTA FASE)

**PROIBIDO** incluir no codigo gerado:
- Comentarios ``*-- TODO``, ``*-- FIXME``, ``*-- HACK``, ``*-- PLACEHOLDER``
- Procedures/metodos vazios (sem codigo real)
- Comentarios indicando "implementar depois" ou "proxima fase"
- Stubs que retornam valores fixos sem logica real
- Metodos com apenas ``DODEFAULT()`` quando devem ter logica propria

**CADA metodo gerado DEVE ter implementacao COMPLETA e FUNCIONAL.**

Se nao souber como implementar algo, analise o codigo fonte original e replique a logica.
NUNCA omitir funcionalidade - paridade 100% com o sistema legado.
O resultado sera validado automaticamente e **fases com TODOs/stubs serao REJEITADAS**.
"@
        $template += $antiTodoFooter

        $template | Out-File -FilePath $promptPath -Encoding UTF8
        Write-Host "  [Prompt] Template usado: $templateName.md" -ForegroundColor DarkGray
    }
    else {
        # Gerar prompt generico (fallback)
        $prompt = @"
# MIGRACAO VFP9 - $NomeFase

## CONTEXTO
- Projeto: Migracao VFP9 - Sistema 4C
- Task: $($estadoMigracao.TaskId)
- Fase: $NomeFase
- Formulario: $baseName
- Tipo: $($script:formType)

## ARQUIVOS DE REFERENCIA
- CLAUDE.md: C:\4c\CLAUDE.md (regras do projeto - LER OBRIGATORIAMENTE)
- Codigo Original: $TaskPath\${baseName}_form_codigo_fonte.txt
- Schema SQL: C:\4c\docs\schema.sql

## TAREFA
$($allPlaceholders.Descricao)

## REGRAS OBRIGATORIAS
$($allPlaceholders.Regras)

## ENTREGA ESPERADA
$($allPlaceholders.Entrega)

## VALIDACAO
$($allPlaceholders.Validacao)
"@

        $prompt | Out-File -FilePath $promptPath -Encoding UTF8
        Write-Host "  [Prompt] Generico gerado (template $templateName.md nao encontrado)" -ForegroundColor Yellow
    }

    return $promptPath
}

#------------------------------------------------------------------------------
# Executor de Fases (com escalacao automatica e deteccao pos-timeout)
#
# Escalacao por tentativa:
#   1: sonnet, 1x timeout (300s)
#   2: sonnet, 2x timeout (600s)
#   3: opus,   3x timeout (900s)
#------------------------------------------------------------------------------

function Invoke-Fase {
    param(
        [string]$NomeFase,
        [string]$Descricao,
        [scriptblock]$Script,
        [int]$MaxTentativas = $MaxRetries,

        # Arquivos esperados - se existirem apos timeout, fase e considerada OK
        [string[]]$ExpectedFiles = @()
    )

    $numFase = $estadoMigracao.FaseAtual + 1
    $totalFases = $estadoMigracao.TotalFases

    Write-FaseHeader -NumeroFase $numFase -TotalFases $totalFases -NomeFase $NomeFase

    for ($tentativa = 1; $tentativa -le ($MaxTentativas + 1); $tentativa++) {
        $inicio = Get-Date

        # === ESCALACAO: Ajustar timeout e modelo por tentativa ===
        $script:faseTimeout = [int]($config.claude.timeout * [math]::Min($tentativa, 3))
        $script:faseModel = if ($tentativa -ge 3) { "opus" } else { $config.claude.model }

        if ($tentativa -gt 1) {
            Write-Host "[FASE $numFase] Tentativa $tentativa de $($MaxTentativas + 1) (modelo: $($script:faseModel), timeout: $($script:faseTimeout)s)..." -ForegroundColor Yellow
        }

        try {
            # Executar script da fase
            & $Script

            $duracao = (Get-Date) - $inicio

            # Registrar sucesso
            $estadoMigracao.Fases += @{
                Nome = $NomeFase
                Status = "COMPLETED"
                Duracao = $duracao.TotalSeconds
                Tentativa = $tentativa
                Modelo = $script:faseModel
                Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            }

            $estadoMigracao.FaseAtual = $numFase

            Write-Host ""
            Write-Host "[FASE $numFase] Concluida com sucesso em $([math]::Round($duracao.TotalMinutes, 1)) min" -ForegroundColor Green

            Save-EstadoMigracao -TaskPath $taskPath

            return $true
        }
        catch {
            $duracao = (Get-Date) - $inicio
            $erroMsg = $_.Exception.Message

            Write-Host ""
            Write-Host "[FASE $numFase] FALHOU (tentativa $tentativa): $erroMsg" -ForegroundColor Red

            # === USAGE LIMIT: Abortar imediatamente ===
            if ($erroMsg -match "USAGE_LIMIT") {
                Write-Host ""
                Write-Host "========================================================" -ForegroundColor Red
                Write-Host "USAGE LIMIT ATINGIDO - Abortando migracao." -ForegroundColor Red
                Write-Host "Aguarde o reset e re-execute o script." -ForegroundColor Red
                Write-Host "O estado foi salvo - a execucao continuara da fase $numFase." -ForegroundColor Yellow
                Write-Host "========================================================" -ForegroundColor Red

                $estadoMigracao.Fases += @{
                    Nome = $NomeFase
                    Status = "FAILED_USAGE_LIMIT"
                    Erro = $erroMsg
                    Duracao = $duracao.TotalSeconds
                    Tentativa = $tentativa
                    Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                }
                Save-EstadoMigracao -TaskPath $taskPath

                throw "Usage limit atingido na Fase $numFase ($NomeFase). Re-execute apos o reset."
            }

            # === DETECCAO POS-TIMEOUT: Verificar se arquivos foram criados ===
            if ($ExpectedFiles.Count -gt 0) {
                $allFound = $true
                foreach ($ef in $ExpectedFiles) {
                    if (-not (Test-ArquivoGerado -FilePath $ef -Descricao (Split-Path $ef -Leaf))) {
                        $allFound = $false
                    }
                }

                if ($allFound) {
                    Write-Host ""
                    Write-Host "[FASE $numFase] Arquivos encontrados no disco apesar do timeout/erro!" -ForegroundColor Green
                    Write-Host "[FASE $numFase] Considerando fase como SUCESSO." -ForegroundColor Green

                    $estadoMigracao.Fases += @{
                        Nome = $NomeFase
                        Status = "COMPLETED_POST_TIMEOUT"
                        Duracao = $duracao.TotalSeconds
                        Tentativa = $tentativa
                        Modelo = $script:faseModel
                        Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                    }

                    $estadoMigracao.FaseAtual = $numFase
                    Save-EstadoMigracao -TaskPath $taskPath

                    return $true
                }
            }

            # === RETRY: Se ainda tem tentativas, aguardar e continuar ===
            if ($tentativa -le $MaxTentativas) {
                $waitSeconds = 10 * $tentativa
                Write-Host "Aguardando ${waitSeconds}s antes de retry (escalando modelo/timeout)..." -ForegroundColor Yellow
                Start-Sleep -Seconds $waitSeconds
                continue
            }

            # === ESGOTOU TENTATIVAS: Registrar e pular fase ===
            $estadoMigracao.Fases += @{
                Nome = $NomeFase
                Status = "FAILED"
                Erro = $erroMsg
                Duracao = $duracao.TotalSeconds
                Tentativa = $tentativa
                Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            }

            Write-Host "[FASE $numFase] Esgotou tentativas. Pulando fase." -ForegroundColor Red
            $estadoMigracao.FaseAtual = $numFase
            Save-EstadoMigracao -TaskPath $taskPath

            return $false
        }
    }
}

#==============================================================================
# INICIO DA EXECUCAO
#==============================================================================

# Validar arquivo de entrada
if (-not (Test-Path $Arquivo)) {
    Write-Host "ERRO: Arquivo nao encontrado: $Arquivo" -ForegroundColor Red
    exit 1
}

$baseName = [System.IO.Path]::GetFileNameWithoutExtension($Arquivo)

Write-Host ""
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host " ORQUESTRADOR COMPLEXO - Migracao Multi-Fase" -ForegroundColor Cyan
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host "  Arquivo: $baseName" -ForegroundColor White
Write-Host "  Max retries por fase: $MaxRetries" -ForegroundColor White
Write-Host "  Timeout base: $($config.claude.timeout)s" -ForegroundColor White
Write-Host "  Escalacao: sonnet(1x) -> sonnet(2x) -> opus(3x)" -ForegroundColor White
Write-Host ""

#------------------------------------------------------------------------------
# Criar ou continuar task
#------------------------------------------------------------------------------

$taskNumber = Get-NextTaskNumber
$taskId = "task{0:D3}" -f $taskNumber
$taskPath = Join-Path $config.paths.tasks $taskId

# Verificar se ja existe task para este arquivo (por nome do SCX na pasta)
$existingTaskPath = $null
Get-ChildItem -Path $config.paths.tasks -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    # Verifica se a task tem o SCX com mesmo baseName
    $scxInTask = Join-Path $_.FullName "$baseName.SCX"
    $estadoPath = Join-Path $_.FullName "estado_migracao_complexa.json"

    if ((Test-Path $scxInTask) -and (Test-Path $estadoPath)) {
        $existingTaskPath = $_.FullName
    }
}

if ($existingTaskPath) {
    $taskPath = $existingTaskPath
    $taskId = Split-Path $existingTaskPath -Leaf
    $continuar = Load-EstadoMigracao -TaskPath $taskPath
    if ($continuar) {
        Write-Host "Estado anterior encontrado ($taskId). Continuando da FASE $($estadoMigracao.FaseAtual + 1)..." -ForegroundColor Yellow

        # Carregar analise.json se existir
        Load-AnaliseData -TaskPath $taskPath | Out-Null

        # Recuperar paths de arquivos gerados se ja existem
        $boPath = Get-BOFilePath
        $formPath = Get-FormFilePath
        if ((Test-Path $boPath) -and -not $estadoMigracao.ArquivosGerados.BO) {
            $estadoMigracao.ArquivosGerados.BO = $boPath
            Write-Host "  BO detectado: $boPath" -ForegroundColor DarkGray
        }
        if ((Test-Path $formPath) -and -not $estadoMigracao.ArquivosGerados.Form) {
            $estadoMigracao.ArquivosGerados.Form = $formPath
            Write-Host "  Form detectado: $formPath" -ForegroundColor DarkGray
        }
    }
}
else {
    # Criar nova task
    Write-Host "Criando nova task: $taskId" -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $taskPath -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $taskPath "logs") -Force | Out-Null

    $estadoMigracao.TaskId = $taskId

    # Copiar arquivos SCX/SCT para task
    Copy-Item -Path $Arquivo -Destination $taskPath
    $sctFile = $Arquivo -replace '(?i)\.scx$', '.sct'
    if (Test-Path $sctFile) {
        Copy-Item -Path $sctFile -Destination $taskPath
    }
}

#------------------------------------------------------------------------------
# Definir total de fases (sera recalculado apos Fase 0 com analise.json)
#------------------------------------------------------------------------------

if ($estadoMigracao.TotalFases -eq 0) {
    $estadoMigracao.TotalFases = 9  # Default: 0 a 8
}

Write-Host "Migracao complexa planejada: $($estadoMigracao.TotalFases) fases" -ForegroundColor Cyan
Write-Host ""

#==============================================================================
# EXECUTAR FASES
#==============================================================================

# ============================================================================
# FASE 0: Inventario (extracao de codigo + analise)
# ============================================================================
if ($estadoMigracao.FaseAtual -lt 1) {
    Invoke-Fase -NomeFase "00_Inventario" -Descricao "Extrair codigo e analisar" -Script {
        Write-Host "Extraindo codigo fonte..." -ForegroundColor Cyan

        $extractScript = Join-Path $config.paths.projeto "app\utils\ExtractSCXCode.prg"
        $scxFile = Join-Path $taskPath "$baseName.SCX"
        $logFile = Join-Path $taskPath "logs\00_inventario.log"

        Invoke-VFP -ScriptPrg $extractScript `
                   -Parameters @($scxFile) `
                   -LogFile $logFile `
                   -OutputFile (Join-Path $taskPath "vfp_output.txt")

        # Verificar se codigo foi extraido
        $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_form_codigo_fonte.txt" -File
        if ($txtFiles.Count -eq 0) {
            # Tentar tambem *_codigo_fonte.txt (formato alternativo)
            $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_codigo_fonte.txt" -File
        }
        if ($txtFiles.Count -eq 0) {
            throw "Arquivo de codigo fonte nao foi gerado"
        }

        $txtFile = $txtFiles[0].FullName
        Write-Host "Codigo fonte extraido: $txtFile" -ForegroundColor Green

        # Executar AnalisadorTarefa
        Write-Host "Analisando tarefa..." -ForegroundColor Cyan
        $analisadorScript = Join-Path $config.paths.projeto "app\utils\AnalisadorTarefa.prg"

        Invoke-VFP -ScriptPrg $analisadorScript `
                   -Parameters @($txtFile) `
                   -LogFile (Join-Path $taskPath "logs\00_analise.log") `
                   -OutputFile (Join-Path $taskPath "vfp_output.txt")

        $analiseFile = Join-Path $taskPath "analise.json"
        if (Test-Path $analiseFile) {
            Write-Host "Analise gerada: $analiseFile" -ForegroundColor Green
        }

        # Executar GeradorMapeamento
        Write-Host "Gerando mapeamento..." -ForegroundColor Cyan
        $mapeamentoScript = Join-Path $config.paths.projeto "app\utils\GeradorMapeamento.prg"

        Invoke-VFP -ScriptPrg $mapeamentoScript `
                   -Parameters @($txtFile, $taskPath) `
                   -LogFile (Join-Path $taskPath "logs\00_mapeamento.log") `
                   -OutputFile (Join-Path $taskPath "vfp_output.txt")

        $mapeamentoFile = Join-Path $taskPath "mapeamento.json"
        if (Test-Path $mapeamentoFile) {
            Write-Host "Mapeamento gerado: $mapeamentoFile" -ForegroundColor Green
        }

        Write-Host "Inventario completo" -ForegroundColor Green
    }
}

#------------------------------------------------------------------------------
# Carregar analise.json (apos Fase 0 ou ao retomar)
#------------------------------------------------------------------------------

Load-AnaliseData -TaskPath $taskPath | Out-Null

# Recalcular total de fases com dados de analise
$gruposCampos = 1
$gruposLogica = 1

if ($script:analiseData) {
    $numCampos = 0
    if ($script:analiseData.campos) { $numCampos = @($script:analiseData.campos).Count }

    if ($numCampos -gt 30) {
        $gruposCampos = [math]::Ceiling($numCampos / 20)
    }

    # Contar procedures no codigo fonte para dividir Fase 7
    $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_codigo_fonte.txt" -File
    if ($txtFiles.Count -gt 0) {
        $sourceContent = Get-Content $txtFiles[0].FullName -Raw -ErrorAction SilentlyContinue
        if ($sourceContent) {
            # Contar PROCEDURE declaradas (excluindo Init/Destroy/Click padrao)
            $procMatches = [regex]::Matches($sourceContent, "(?im)^\s*PROCEDURE\s+(\w+)")
            $customProcs = @($procMatches | ForEach-Object { $_.Groups[1].Value } |
                            Where-Object { $_ -notin @("Init","Destroy","Click","DblClick","Load","Unload","Activate","Deactivate","GotFocus","LostFocus","KeyPress","Valid","When","Refresh","Error") })
            $numProcedures = $customProcs.Count
            Write-Host "  Procedures customizadas detectadas: $numProcedures" -ForegroundColor DarkGray

            if ($numProcedures -gt 30) {
                $gruposLogica = [math]::Ceiling($numProcedures / 20)
                Write-Host "  Logica dividida em $gruposLogica grupos" -ForegroundColor DarkGray
            }
        }
    }
}

$totalFasesCalculado = 9 + ($gruposCampos - 1) + ($gruposLogica - 1)
if ($estadoMigracao.TotalFases -lt $totalFasesCalculado) {
    $estadoMigracao.TotalFases = $totalFasesCalculado
    Write-Host "Total de fases recalculado: $totalFasesCalculado" -ForegroundColor DarkGray
}

# ============================================================================
# FASE 1: Business Object
# ============================================================================
if ($estadoMigracao.FaseAtual -lt 2) {

    $expectedBO = Get-BOFilePath

    Invoke-Fase -NomeFase "01_BusinessObject" -Descricao "Criar BO completo" `
                -ExpectedFiles @($expectedBO) -Script {

        Write-Host "Gerando prompt para criacao do BO..." -ForegroundColor Cyan

        $promptPath = New-PromptFase -NomeFase "01_BusinessObject" -TaskPath $taskPath -Parametros @{
            BaseName = $baseName
        }

        # Contexto: codigo fonte + mapeamento
        $contextFiles = @()
        $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_codigo_fonte.txt" -File
        if ($txtFiles.Count -gt 0) { $contextFiles += $txtFiles[0].FullName }
        $mapeamento = Join-Path $taskPath "mapeamento.json"
        if (Test-Path $mapeamento) { $contextFiles += $mapeamento }

        $outputFile = Join-Path $taskPath "fase_01_output.txt"
        $logFile = Join-Path $taskPath "logs\01_bo.log"

        $exitCode = Invoke-Claude -PromptFile $promptPath -OutputFile $outputFile `
                                  -LogFile $logFile -ContextFiles $contextFiles

        # Verificar arquivo gerado (mesmo com exit code != 0)
        $boFile = Get-BOFilePath
        if (Test-ArquivoGerado -FilePath $boFile -Descricao "BO") {
            $estadoMigracao.ArquivosGerados.BO = $boFile
            Write-Host "BO gerado: $boFile" -ForegroundColor Green
        } elseif ($exitCode -ne 0) {
            throw "Claude CLI falhou ao gerar BO (exit code: $exitCode)"
        } else {
            throw "BO nao foi gerado: $boFile"
        }
    }
}

# ============================================================================
# FASE 2: Estrutura Visual
# ============================================================================
if ($estadoMigracao.FaseAtual -lt 3) {

    $expectedForm = Get-FormFilePath

    Invoke-Fase -NomeFase "02_EstruturaVisual" -Descricao "Criar estrutura do form" `
                -ExpectedFiles @($expectedForm) -Script {

        Write-Host "Gerando prompt para estrutura visual..." -ForegroundColor Cyan

        $promptPath = New-PromptFase -NomeFase "02_EstruturaVisual" -TaskPath $taskPath -Parametros @{
            BaseName   = $baseName
            FormSubDir = $script:formSubDir
        }

        $contextFiles = @()
        $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_codigo_fonte.txt" -File
        if ($txtFiles.Count -gt 0) { $contextFiles += $txtFiles[0].FullName }
        $mapeamento = Join-Path $taskPath "mapeamento.json"
        if (Test-Path $mapeamento) { $contextFiles += $mapeamento }

        # Adicionar BO como contexto (Form precisa saber propriedades do BO)
        $boFile = Get-BOFilePath
        if (Test-Path $boFile) {
            $contextFiles += $boFile
            Write-Host "  [Contexto] BO adicionado: $boFile" -ForegroundColor DarkGray
        }

        # Adicionar relatoriobase.prg ao contexto se for REPORT
        if ($script:formType -eq "REPORT") {
            $relBase = Join-Path $config.paths.projeto "app\classes\relatoriobase.prg"
            if (Test-Path $relBase) {
                $contextFiles += $relBase
                Write-Host "  [REPORT] relatoriobase.prg adicionado ao contexto" -ForegroundColor DarkGray
            }
        }

        $outputFile = Join-Path $taskPath "fase_02_output.txt"
        $logFile = Join-Path $taskPath "logs\02_estrutura.log"

        $exitCode = Invoke-Claude -PromptFile $promptPath -OutputFile $outputFile `
                                  -LogFile $logFile -ContextFiles $contextFiles

        # Verificar arquivo gerado (mesmo com exit code != 0)
        $formFile = Get-FormFilePath
        if (Test-ArquivoGerado -FilePath $formFile -Descricao "Form") {
            $estadoMigracao.ArquivosGerados.Form = $formFile
            Write-Host "Form gerado: $formFile" -ForegroundColor Green
        } elseif ($exitCode -ne 0) {
            throw "Claude CLI falhou ao gerar estrutura visual (exit code: $exitCode)"
        } else {
            throw "Form nao foi gerado: $formFile"
        }
    }
}

# ============================================================================
# FASE 3: Campos (pode ser dividido em N sub-fases)
# ============================================================================

for ($idx = 0; $idx -lt $gruposCampos; $idx++) {
    $faseNum = 3 + $idx
    $grupoLetra = [char](65 + $idx)
    # Capturar variaveis do loop ANTES do scriptblock (evita closure bug)
    $localIdx = $idx
    $localGrupoLetra = $grupoLetra

    if ($estadoMigracao.FaseAtual -lt ($faseNum + 1)) {
        Invoke-Fase -NomeFase "03${localGrupoLetra}_Campos" -Descricao "Adicionar campos grupo $localGrupoLetra" -Script {
            Write-Host "Gerando prompt para campos grupo $localGrupoLetra..." -ForegroundColor Cyan

            $campoInicio = ($localIdx * 20) + 1
            $totalCampos = 0
            if ($script:analiseData -and $script:analiseData.campos) {
                $totalCampos = @($script:analiseData.campos).Count
            }
            $campoFim = if ($totalCampos -gt 0) { [math]::Min(($localIdx + 1) * 20, $totalCampos) } else { 20 }

            $promptPath = New-PromptFase -NomeFase "03${localGrupoLetra}_Campos" -TaskPath $taskPath -Parametros @{
                BaseName      = $baseName
                GrupoLetra    = "$localGrupoLetra"
                CampoInicio   = "$campoInicio"
                CampoFim      = "$campoFim"
                TotalCamposGrupo = "$($campoFim - $campoInicio + 1)"
            }

            $contextFiles = @()
            $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_codigo_fonte.txt" -File
            if ($txtFiles.Count -gt 0) { $contextFiles += $txtFiles[0].FullName }

            $outputFile = Join-Path $taskPath "fase_03${localGrupoLetra}_output.txt"
            $logFile = Join-Path $taskPath "logs\03${localGrupoLetra}_campos.log"

            $exitCode = Invoke-Claude -PromptFile $promptPath -OutputFile $outputFile `
                                      -LogFile $logFile -ContextFiles $contextFiles

            if ($exitCode -ne 0) {
                throw "Claude CLI falhou ao adicionar campos grupo $localGrupoLetra (exit code: $exitCode)"
            }

            # Validar completude - sem TODOs/stubs
            $formFile = Get-FormFilePath
            if (Test-Path $formFile) {
                Test-CompletudeCodigo -FilePath $formFile -Descricao "Form (apos campos grupo $localGrupoLetra)" | Out-Null
            }

            Write-Host "Campos grupo $localGrupoLetra adicionados" -ForegroundColor Green
        }
    }
}

# ============================================================================
# FASE 4: Lookups
# ============================================================================
$faseLookupsNum = 3 + $gruposCampos

if ($estadoMigracao.FaseAtual -lt ($faseLookupsNum + 1)) {
    Invoke-Fase -NomeFase "04_Lookups" -Descricao "Implementar lookups" -Script {
        Write-Host "Gerando prompt para lookups..." -ForegroundColor Cyan

        $promptPath = New-PromptFase -NomeFase "04_Lookups" -TaskPath $taskPath -Parametros @{
            BaseName = $baseName
        }

        $contextFiles = @()
        $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_codigo_fonte.txt" -File
        if ($txtFiles.Count -gt 0) { $contextFiles += $txtFiles[0].FullName }

        # Adicionar lookup_implementation.md ao contexto
        $lookupGuide = Join-Path $config.paths.projeto "..\docs\lookup_implementation.md"
        if (Test-Path $lookupGuide) { $contextFiles += (Resolve-Path $lookupGuide).Path }

        $outputFile = Join-Path $taskPath "fase_04_output.txt"
        $logFile = Join-Path $taskPath "logs\04_lookups.log"

        $exitCode = Invoke-Claude -PromptFile $promptPath -OutputFile $outputFile `
                                  -LogFile $logFile -ContextFiles $contextFiles

        if ($exitCode -ne 0) {
            throw "Claude CLI falhou ao implementar lookups (exit code: $exitCode)"
        }

        # Validar completude - sem TODOs/stubs nos lookups
        $formFile = Get-FormFilePath
        if (Test-Path $formFile) {
            Test-CompletudeCodigo -FilePath $formFile -Descricao "Form (apos lookups)" | Out-Null
        }

        Write-Host "Lookups implementados" -ForegroundColor Green
    }
}

# ============================================================================
# FASE 5: Grids (se houver)
# ============================================================================
$faseGridsNum = $faseLookupsNum + 1

$temGrid = $false
if ($script:analiseData -and $script:analiseData.grid -and $script:analiseData.grid.temGrid) {
    $temGrid = $true
}

if ($temGrid) {
    if ($estadoMigracao.FaseAtual -lt ($faseGridsNum + 1)) {
        Invoke-Fase -NomeFase "05_Grids" -Descricao "Implementar grids de detalhe" -Script {
            Write-Host "Gerando prompt para grids..." -ForegroundColor Cyan

            $promptPath = New-PromptFase -NomeFase "05_Grids" -TaskPath $taskPath -Parametros @{
                BaseName = $baseName
            }

            $contextFiles = @()
            $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_codigo_fonte.txt" -File
            if ($txtFiles.Count -gt 0) { $contextFiles += $txtFiles[0].FullName }

            # Adicionar grid_implementation.md ao contexto
            $gridGuide = Join-Path $config.paths.projeto "..\docs\grid_implementation.md"
            if (Test-Path $gridGuide) { $contextFiles += (Resolve-Path $gridGuide).Path }

            $outputFile = Join-Path $taskPath "fase_05_output.txt"
            $logFile = Join-Path $taskPath "logs\05_grids.log"

            $exitCode = Invoke-Claude -PromptFile $promptPath -OutputFile $outputFile `
                                      -LogFile $logFile -ContextFiles $contextFiles

            if ($exitCode -ne 0) {
                throw "Claude CLI falhou ao implementar grids"
            }

            Write-Host "Grids implementados" -ForegroundColor Green
        }
    }
} else {
    Write-Host ""
    Write-Host "[FASE $($faseGridsNum)] Pulada - nenhum grid detectado" -ForegroundColor DarkGray
    if ($estadoMigracao.FaseAtual -lt ($faseGridsNum + 1)) {
        $estadoMigracao.FaseAtual = $faseGridsNum
        $estadoMigracao.Fases += @{
            Nome = "05_Grids"
            Status = "SKIPPED"
            Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        }
    }
}

# ============================================================================
# FASE 6: Sincronizacao (FormParaBO/BOParaForm)
# ============================================================================
$faseSyncNum = $faseGridsNum + 1

if ($estadoMigracao.FaseAtual -lt ($faseSyncNum + 1)) {
    Invoke-Fase -NomeFase "06_Sincronizacao" -Descricao "Sincronizar Form <-> BO" -Script {
        Write-Host "Gerando prompt para sincronizacao..." -ForegroundColor Cyan

        $promptPath = New-PromptFase -NomeFase "06_Sincronizacao" -TaskPath $taskPath -Parametros @{
            BaseName = $baseName
        }

        $contextFiles = @()
        $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_codigo_fonte.txt" -File
        if ($txtFiles.Count -gt 0) { $contextFiles += $txtFiles[0].FullName }

        # Adicionar BO como contexto (para mapear propriedades)
        $boFile = Get-BOFilePath
        if (Test-Path $boFile) {
            $contextFiles += $boFile
            Write-Host "  [Contexto] BO adicionado" -ForegroundColor DarkGray
        }

        # Adicionar Form como contexto (para mapear campos da UI)
        $formFile = Get-FormFilePath
        if (Test-Path $formFile) {
            $contextFiles += $formFile
            Write-Host "  [Contexto] Form adicionado" -ForegroundColor DarkGray
        }

        $outputFile = Join-Path $taskPath "fase_06_output.txt"
        $logFile = Join-Path $taskPath "logs\06_sync.log"

        $exitCode = Invoke-Claude -PromptFile $promptPath -OutputFile $outputFile `
                                  -LogFile $logFile -ContextFiles $contextFiles

        if ($exitCode -ne 0) {
            throw "Claude CLI falhou ao implementar sincronizacao (exit code: $exitCode)"
        }

        # Validar completude - FormParaBO/BOParaForm devem ter todos os campos
        $formFile = Get-FormFilePath
        if (Test-Path $formFile) {
            Test-CompletudeCodigo -FilePath $formFile -Descricao "Form (apos sincronizacao)" | Out-Null
        }

        Write-Host "Sincronizacao implementada" -ForegroundColor Green
    }
}

# ============================================================================
# FASE 7: Logica de Negocio (pode ser dividido em N sub-fases)
# ============================================================================
$faseLogicaBaseNum = $faseSyncNum + 1

for ($idx = 0; $idx -lt $gruposLogica; $idx++) {
    $faseNum = $faseLogicaBaseNum + $idx
    $grupoLetra = [char](65 + $idx)
    $localIdx = $idx
    $localGrupoLetra = $grupoLetra

    if ($estadoMigracao.FaseAtual -lt ($faseNum + 1)) {
        Invoke-Fase -NomeFase "07${localGrupoLetra}_Logica" -Descricao "Logica de negocio grupo $localGrupoLetra" -Script {
            Write-Host "Gerando prompt para logica grupo $localGrupoLetra..." -ForegroundColor Cyan

            $promptPath = New-PromptFase -NomeFase "07${localGrupoLetra}_Logica" -TaskPath $taskPath -Parametros @{
                BaseName    = $baseName
                GrupoLetra  = "$localGrupoLetra"
            }

            $contextFiles = @()
            $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_codigo_fonte.txt" -File
            if ($txtFiles.Count -gt 0) { $contextFiles += $txtFiles[0].FullName }

            # Adicionar BO como contexto
            $boFile = Get-BOFilePath
            if (Test-Path $boFile) { $contextFiles += $boFile }

            # Adicionar Form como contexto (logica manipula o Form)
            $formFile = Get-FormFilePath
            if (Test-Path $formFile) { $contextFiles += $formFile }

            $outputFile = Join-Path $taskPath "fase_07${localGrupoLetra}_output.txt"
            $logFile = Join-Path $taskPath "logs\07${localGrupoLetra}_logica.log"

            $exitCode = Invoke-Claude -PromptFile $promptPath -OutputFile $outputFile `
                                      -LogFile $logFile -ContextFiles $contextFiles

            if ($exitCode -ne 0) {
                throw "Claude CLI falhou ao implementar logica grupo $localGrupoLetra (exit code: $exitCode)"
            }

            # Validar completude
            $formFile = Get-FormFilePath
            if (Test-Path $formFile) {
                Test-CompletudeCodigo -FilePath $formFile -Descricao "Form (apos logica grupo $localGrupoLetra)" | Out-Null
            }
            $boFile = Get-BOFilePath
            if (Test-Path $boFile) {
                Test-CompletudeCodigo -FilePath $boFile -Descricao "BO (apos logica grupo $localGrupoLetra)" | Out-Null
            }

            Write-Host "Logica grupo $localGrupoLetra implementada" -ForegroundColor Green
        }
    }
}

# ============================================================================
# FASE 8: Validacao Final
# ============================================================================
$faseValidacaoNum = $faseLogicaBaseNum + $gruposLogica

if ($estadoMigracao.FaseAtual -lt ($faseValidacaoNum + 1)) {
    Invoke-Fase -NomeFase "08_ValidacaoFinal" -Descricao "Validacao e testes finais" -Script {

        $formFile = $estadoMigracao.ArquivosGerados.Form
        $boFile = $estadoMigracao.ArquivosGerados.BO

        # Se paths nao estao no estado, tentar detectar
        if (-not $formFile) { $formFile = Get-FormFilePath }
        if (-not $boFile) { $boFile = Get-BOFilePath }

        $validacaoProblemas = @()

        # === ETAPA 1: Verificar existencia dos arquivos ===
        Write-Host "--- Etapa 1: Verificando arquivos gerados ---" -ForegroundColor Cyan
        if (-not (Test-Path $boFile)) {
            $validacaoProblemas += "BO nao encontrado: $boFile"
            Write-Host "  [ERRO] BO nao encontrado: $boFile" -ForegroundColor Red
        } else {
            Write-Host "  [OK] BO: $boFile ($((Get-Item $boFile).Length) bytes)" -ForegroundColor Green
        }
        if (-not (Test-Path $formFile)) {
            $validacaoProblemas += "Form nao encontrado: $formFile"
            Write-Host "  [ERRO] Form nao encontrado: $formFile" -ForegroundColor Red
        } else {
            Write-Host "  [OK] Form: $formFile ($((Get-Item $formFile).Length) bytes)" -ForegroundColor Green
        }

        # === ETAPA 2: Validacao de completude (anti-TODO/stubs) ===
        Write-Host ""
        Write-Host "--- Etapa 2: Validando completude (anti-TODO/stubs) ---" -ForegroundColor Cyan
        if ((Test-Path $formFile) -and -not (Test-CompletudeCodigo -FilePath $formFile -Descricao "Form")) {
            $validacaoProblemas += "Form contem TODOs, stubs ou procedures vazias"
        }
        if ((Test-Path $boFile) -and -not (Test-CompletudeCodigo -FilePath $boFile -Descricao "BO")) {
            $validacaoProblemas += "BO contem TODOs, stubs ou procedures vazias"
        }

        # === ETAPA 3: Executar CorretorAutomatico ===
        Write-Host ""
        Write-Host "--- Etapa 3: Executando CorretorAutomatico ---" -ForegroundColor Cyan
        $corretorScript = Join-Path $scriptDir "CorretorAutomatico.ps1"

        if ((Test-Path $formFile) -and (Test-Path $corretorScript)) {
            Write-Host "  Corrigindo Form..." -ForegroundColor DarkGray
            $corretorOutput = & $corretorScript -Arquivo $formFile 2>&1 | Out-String
            $numCorrecoes = ([regex]::Matches($corretorOutput, "(?i)(corrig|fix|remov)")).Count
            Write-Host "  Form: ~$numCorrecoes correcoes aplicadas" -ForegroundColor DarkGray
        }
        if ((Test-Path $boFile) -and (Test-Path $corretorScript)) {
            Write-Host "  Corrigindo BO..." -ForegroundColor DarkGray
            $corretorOutput = & $corretorScript -Arquivo $boFile 2>&1 | Out-String
            $numCorrecoes = ([regex]::Matches($corretorOutput, "(?i)(corrig|fix|remov)")).Count
            Write-Host "  BO: ~$numCorrecoes correcoes aplicadas" -ForegroundColor DarkGray
        }

        # === ETAPA 4: Deletar .fxp para garantir recompilacao ===
        Write-Host ""
        Write-Host "--- Etapa 4: Limpando cache .fxp ---" -ForegroundColor Cyan
        $fxpCount = (Get-ChildItem -Path (Join-Path $config.paths.projeto "app") -Filter "*.fxp" -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count
        Get-ChildItem -Path (Join-Path $config.paths.projeto "app") -Filter "*.fxp" -Recurse -ErrorAction SilentlyContinue |
            Remove-Item -Force -ErrorAction SilentlyContinue
        Write-Host "  $fxpCount arquivos .fxp removidos" -ForegroundColor DarkGray

        # === ETAPA 5: Executar ValidarUIFidelity via VFP ===
        Write-Host ""
        Write-Host "--- Etapa 5: Executando ValidarUIFidelity ---" -ForegroundColor Cyan
        $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_codigo_fonte.txt" -File
        $validacaoOutputFile = Join-Path $taskPath "vfp_output_validacao.txt"

        if ($txtFiles.Count -gt 0 -and (Test-Path $formFile)) {
            $validarScript = Join-Path $config.paths.projeto "app\utils\ValidarUIFidelity.prg"
            $formClassName = "Form$baseName"

            if (Test-Path $validarScript) {
                Invoke-VFP -ScriptPrg $validarScript `
                           -Parameters @($txtFiles[0].FullName, $formClassName) `
                           -LogFile (Join-Path $taskPath "logs\08_validacao.log") `
                           -OutputFile $validacaoOutputFile

                # Parsear resultado da validacao
                if (Test-Path $validacaoOutputFile) {
                    $validacaoContent = Get-Content $validacaoOutputFile -Raw -ErrorAction SilentlyContinue
                    if ($validacaoContent) {
                        # Contar erros e diferencas (excluindo Dataenvironment e FormBase)
                        $errosCriticos = ([regex]::Matches($validacaoContent, "(?im)(ERRO|ERROR)(?!.*Dataenvironment)")).Count
                        $diferencas = ([regex]::Matches($validacaoContent, "(?im)DIFERENCA")).Count

                        Write-Host "  ValidarUIFidelity: $errosCriticos erros criticos, $diferencas diferencas" -ForegroundColor $(if($errosCriticos -gt 0 -or $diferencas -gt 5){'Yellow'}else{'Green'})

                        if ($errosCriticos -gt 4) {
                            $validacaoProblemas += "ValidarUIFidelity: $errosCriticos erros criticos (max aceitavel: 4 Dataenvironment)"
                        }
                    }
                }
            } else {
                Write-Host "  [WARN] ValidarUIFidelity.prg nao encontrado" -ForegroundColor Yellow
            }
        } else {
            Write-Host "  [WARN] Arquivo de codigo fonte ou Form nao disponivel para validacao" -ForegroundColor Yellow
        }

        # === ETAPA 6: Registrar no config.prg (SET PROCEDURE) ===
        Write-Host ""
        Write-Host "--- Etapa 6: Registrando no config.prg ---" -ForegroundColor Cyan
        $configPrg = Join-Path $config.paths.projeto "app\start\config.prg"

        if (Test-Path $configPrg) {
            $configContent = Get-Content $configPrg -Raw

            $alterado = $false

            # Registrar BO (se nao existe)
            $boFileName = "${baseName}BO.prg"
            if ($configContent -notmatch [regex]::Escape($boFileName)) {
                # Encontrar ponto de insercao: antes do primeiro "Formularios" ou no final dos BOs
                $insertPattern = "(?m)^\s*\*--\s*Formularios"
                if ($configContent -match $insertPattern) {
                    $insertMatch = [regex]::Match($configContent, $insertPattern)
                    $boLine = "    SET PROCEDURE TO (gcCaminhoClasses + `"$boFileName`") ADDITIVE`r`n"
                    $configContent = $configContent.Insert($insertMatch.Index, $boLine)
                    $alterado = $true
                    Write-Host "  [OK] BO registrado: $boFileName" -ForegroundColor Green
                } else {
                    Write-Host "  [WARN] Nao encontrou ponto de insercao para BO no config.prg" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  [OK] BO ja registrado: $boFileName" -ForegroundColor DarkGray
            }

            # Registrar Form (se nao existe)
            $formFileName = "Form${baseName}.prg"
            if ($configContent -notmatch [regex]::Escape($formFileName)) {
                # Inserir no final do arquivo (antes de ENDPROC se existir)
                $formLine = "    SET PROCEDURE TO (gcCaminhoForms + `"$($script:formSubDir)\$formFileName`") ADDITIVE`r`n"
                $endprocPattern = "(?m)^\s*ENDPROC\s*$"
                $endprocMatches = [regex]::Matches($configContent, $endprocPattern)
                if ($endprocMatches.Count -gt 0) {
                    $lastEndproc = $endprocMatches[$endprocMatches.Count - 1]
                    $configContent = $configContent.Insert($lastEndproc.Index, $formLine)
                    $alterado = $true
                    Write-Host "  [OK] Form registrado: $formFileName" -ForegroundColor Green
                } else {
                    Write-Host "  [WARN] Nao encontrou ponto de insercao para Form no config.prg" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  [OK] Form ja registrado: $formFileName" -ForegroundColor DarkGray
            }

            if ($alterado) {
                $configContent | Out-File -FilePath $configPrg -Encoding ASCII -NoNewline
                Write-Host "  config.prg atualizado" -ForegroundColor Green
            }
        } else {
            Write-Host "  [WARN] config.prg nao encontrado: $configPrg" -ForegroundColor Yellow
        }

        # === RESUMO FINAL ===
        Write-Host ""
        Write-Host "--- Resumo da Validacao ---" -ForegroundColor Cyan
        if ($validacaoProblemas.Count -gt 0) {
            Write-Host "  PROBLEMAS ENCONTRADOS ($($validacaoProblemas.Count)):" -ForegroundColor Yellow
            foreach ($p in $validacaoProblemas) {
                Write-Host "    - $p" -ForegroundColor Yellow
            }
            Write-Host ""
            Write-Host "  [WARN] Migracao concluida com problemas. Revisar manualmente." -ForegroundColor Yellow
        } else {
            Write-Host "  [OK] Todas as validacoes passaram!" -ForegroundColor Green
        }

        Write-Host "Validacao final concluida" -ForegroundColor Green
    }
}

#==============================================================================
# CONCLUSAO
#==============================================================================

$duracaoTotal = (Get-Date) - $estadoMigracao.Inicio

$fasesCompletas = @($estadoMigracao.Fases | Where-Object { $_.Status -match "COMPLETED" }).Count
$fasesFalharam  = @($estadoMigracao.Fases | Where-Object { $_.Status -eq "FAILED" }).Count
$fasesPuladas   = @($estadoMigracao.Fases | Where-Object { $_.Status -eq "SKIPPED" }).Count

Write-Host ""
Write-Host "============================================================================" -ForegroundColor $(if($fasesFalharam -gt 0){'Yellow'}else{'Green'})
Write-Host " MIGRACAO COMPLEXA CONCLUIDA" -ForegroundColor $(if($fasesFalharam -gt 0){'Yellow'}else{'Green'})
Write-Host "============================================================================" -ForegroundColor $(if($fasesFalharam -gt 0){'Yellow'}else{'Green'})
Write-Host ""
Write-Host "  Task: $taskId" -ForegroundColor Cyan
Write-Host "  Formulario: $baseName ($($script:formType))" -ForegroundColor Cyan
Write-Host "  Fases completas: $fasesCompletas/$($estadoMigracao.TotalFases)" -ForegroundColor $(if($fasesFalharam -gt 0){'Yellow'}else{'Cyan'})
if ($fasesFalharam -gt 0) {
    Write-Host "  Fases com falha: $fasesFalharam" -ForegroundColor Yellow
}
if ($fasesPuladas -gt 0) {
    Write-Host "  Fases puladas: $fasesPuladas" -ForegroundColor DarkGray
}
Write-Host "  Duracao total: $([math]::Round($duracaoTotal.TotalMinutes, 1)) minutos" -ForegroundColor Cyan
Write-Host ""

# Mostrar arquivos gerados
$boFile = $estadoMigracao.ArquivosGerados.BO
$formFile = $estadoMigracao.ArquivosGerados.Form
if (-not $boFile) { $boFile = Get-BOFilePath }
if (-not $formFile) { $formFile = Get-FormFilePath }

if ($boFile -and (Test-Path $boFile)) {
    $boSize = (Get-Item $boFile).Length
    Write-Host "  BO:   $boFile ($boSize bytes)" -ForegroundColor White
} else {
    Write-Host "  BO:   NAO GERADO" -ForegroundColor Red
}

if ($formFile -and (Test-Path $formFile)) {
    $formSize = (Get-Item $formFile).Length
    Write-Host "  Form: $formFile ($formSize bytes)" -ForegroundColor White
} else {
    Write-Host "  Form: NAO GERADO" -ForegroundColor Red
}

Write-Host ""

# Resumo das fases
Write-Host "  Resumo por fase:" -ForegroundColor DarkGray
foreach ($fase in $estadoMigracao.Fases) {
    $statusColor = switch ($fase.Status) {
        "COMPLETED"              { "Green" }
        "COMPLETED_POST_TIMEOUT" { "Green" }
        "SKIPPED"                { "DarkGray" }
        "FAILED"                 { "Red" }
        "FAILED_USAGE_LIMIT"     { "Red" }
        default                  { "White" }
    }
    $modelo = if ($fase.Modelo) { " [$($fase.Modelo)]" } else { "" }
    Write-Host "    $($fase.Nome): $($fase.Status)$modelo" -ForegroundColor $statusColor
}

Write-Host ""

Save-EstadoMigracao -TaskPath $taskPath

# Retornar codigo de saida baseado no resultado
if ($fasesFalharam -gt 0) {
    exit 1
} else {
    exit 0
}
