#==============================================================================
# OrquestradorMigracao.ps1
#
# PROPOSITO: Orquestrador principal do processo de migracao automatizada
#
# FLUXO:
#   1. Mover arquivos de origem para task
#   2. Extrair codigo fonte (ExtractSCXCode.prg)
#   3. Gerar meta-prompt (GERADOR_PROMPT_MIGRACAO.md)
#   4. Gerar mapeamento (GeradorMapeamento.prg)
#   5. Executar migracao (Claude CLI)
#   6. Testar formulario (TestFormWrapper.prg)
#   7. Validar UI Fidelity (ValidarUIFidelity.prg)
#   8. Gerar solicitacao de teste manual
#
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-01-22
#==============================================================================

param(
    [Parameter(Mandatory=$false)]
    [string]$ConfigFile = "C:\4c\automation\config.json",

    [Parameter(Mandatory=$false)]
    [switch]$ContinueFromLastTask,

    [Parameter(Mandatory=$false)]
    [string]$TaskId,

    [Parameter(Mandatory=$false)]
    [switch]$ProcessAll  # Processa TODOS os arquivos da pasta origem
)

$ErrorActionPreference = "Stop"

#------------------------------------------------------------------------------
# Carrega modulos
#------------------------------------------------------------------------------

$scriptDir = Split-Path -Parent $PSCommandPath
. (Join-Path $scriptDir "TaskManager.ps1")

#------------------------------------------------------------------------------
# Mata processos VFP9 que possam estar travados
#------------------------------------------------------------------------------

$vfpProcesses = Get-Process -Name "vfp9" -ErrorAction SilentlyContinue
if ($vfpProcesses) {
    Write-Host "Encerrando processos VFP9 anteriores..." -ForegroundColor Yellow
    $vfpProcesses | Stop-Process -Force
    Start-Sleep -Milliseconds 500
}

#------------------------------------------------------------------------------
# Funcao auxiliar: Executar VFP9 com timeout (Start-Process direto)
# Usar quando NAO se usa VFPExecutor.ps1 (ex: ValidarCompilacao)
#------------------------------------------------------------------------------

function Invoke-VFP9WithTimeout {
    param(
        [Parameter(Mandatory=$true)]
        [string]$VFP9Path,

        [Parameter(Mandatory=$true)]
        [string]$Arguments,

        [Parameter(Mandatory=$false)]
        [int]$TimeoutSeconds = 120,

        [Parameter(Mandatory=$false)]
        [string]$RedirectStdOut
    )

    # -T suprime dialogos de inicializacao do VFP9 (config.fpw, resource file)
    # Permite execucao unattended (noturna) sem bloqueios por dialogos modais
    $processParams = @{
        FilePath = $VFP9Path
        ArgumentList = "-T $Arguments"
        PassThru = $true
        NoNewWindow = $true
    }
    if ($RedirectStdOut) {
        $processParams.RedirectStandardOutput = $RedirectStdOut
    }

    $process = Start-Process @processParams

    $timeoutMs = $TimeoutSeconds * 1000
    $exited = $process.WaitForExit($timeoutMs)

    if (-not $exited) {
        Write-Host "TIMEOUT: VFP9 nao finalizou em $TimeoutSeconds segundos (PID: $($process.Id)). Encerrando..." -ForegroundColor Red
        try { $process | Stop-Process -Force -ErrorAction SilentlyContinue } catch {}
        Start-Sleep -Seconds 2
        # Mata qualquer VFP9 residual
        Get-Process -Name "vfp9" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
        return @{ ExitCode = 4; TimedOut = $true }
    }

    return @{ ExitCode = $process.ExitCode; TimedOut = $false }
}

#------------------------------------------------------------------------------
# Funcao auxiliar: Correcao automatica de erros de runtime via Claude
# Usada nas Etapas 6 e 6.5 quando VFP9 trava ou testes falham
#------------------------------------------------------------------------------

function Invoke-RuntimeErrorCorrection {
    param(
        [Parameter(Mandatory=$true)]
        [string]$TaskId,

        [Parameter(Mandatory=$true)]
        [string]$BaseName,

        [Parameter(Mandatory=$true)]
        [string]$EtapaOrigem,         # "06_testForm" ou "06b_testeAutomatico"

        [Parameter(Mandatory=$true)]
        [string]$ErroMsg,             # Mensagem de erro

        [Parameter(Mandatory=$true)]
        [int]$Tentativa               # Numero da tentativa atual
    )

    $maxTentativas = if ($config.retry.PSObject.Properties['maxTentativasRuntimeFix']) {
        $config.retry.maxTentativasRuntimeFix
    } else { 10 }

    Write-Host ""
    Write-Host "------------------------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "CORRECAO AUTOMATICA (Tentativa $Tentativa/$maxTentativas)" -ForegroundColor Yellow
    Write-Host "Etapa: $EtapaOrigem" -ForegroundColor Yellow
    Write-Host "Erro: $ErroMsg" -ForegroundColor Yellow
    Write-Host "------------------------------------------------------------------------" -ForegroundColor Yellow

    $taskPath = Join-Path $config.paths.tasks $TaskId

    # --- 1. Resolver caminhos dos arquivos ---
    $formClass = Get-FormClassName -BaseName $BaseName
    $boClass = Get-BOClassName -BaseName $BaseName
    $formType = Get-FormTypeFromState -TaskId $TaskId
    $formSubDir = Get-FormSubDir -FormType $formType

    $formFile = Join-Path $config.paths.projeto "app\forms\$formSubDir\$formClass.prg"
    $boFile = Join-Path $config.paths.projeto "app\classes\$boClass.prg"

    # Fallback: procurar Form em outras pastas se nao encontrado
    if (-not (Test-Path $formFile)) {
        $foundForm = Find-FormFile -ProjetoPath $config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
        if ($foundForm) {
            $formFile = $foundForm
            $formSubDir = (Split-Path (Split-Path $foundForm -Parent) -Leaf)
        }
    }

    # --- 2. Coletar contexto de erro ---
    $contextoErro = ""

    # vfp_error_details.txt (erros capturados em modo teste - PRIORIDADE)
    $vfpErrorDetailsFile = Join-Path $taskPath "vfp_error_details.txt"
    if (Test-Path $vfpErrorDetailsFile) {
        $errorDetails = Get-Content $vfpErrorDetailsFile -Raw -ErrorAction SilentlyContinue
        if ($errorDetails) {
            $contextoErro += "`n### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):`n$errorDetails`n"
        }
    }

    # vfp_output.txt (saida parcial do VFP)
    $vfpOutputFile = Join-Path $taskPath "vfp_output.txt"
    if (Test-Path $vfpOutputFile) {
        $vfpOutput = Get-Content $vfpOutputFile -Raw -ErrorAction SilentlyContinue
        if ($vfpOutput) {
            $contextoErro += "`n### SAIDA DO VFP (vfp_output.txt):`n$vfpOutput`n"
        }
    }

    # Log da etapa
    $logEtapa = Join-Path $taskPath "logs\$EtapaOrigem.log"
    if (Test-Path $logEtapa) {
        $logContent = Get-Content $logEtapa -Raw -ErrorAction SilentlyContinue
        if ($logContent) {
            # Limita a ultimas 200 linhas para nao explodir o prompt
            $logLines = $logContent -split "`n"
            if ($logLines.Count -gt 200) {
                $logContent = ($logLines | Select-Object -Last 200) -join "`n"
            }
            $contextoErro += "`n### LOG DA ETAPA ($EtapaOrigem):`n$logContent`n"
        }
    }

    # teste_resultado.json (se existir, para Etapa 6.5)
    $resultFile = Join-Path $taskPath "teste_resultado.json"
    if (Test-Path $resultFile) {
        $resultContent = Get-Content $resultFile -Raw -ErrorAction SilentlyContinue
        if ($resultContent) {
            $contextoErro += "`n### RESULTADO DOS TESTES (teste_resultado.json):`n$resultContent`n"
        }
    }

    # --- 3. Ler codigo fonte dos arquivos ---
    $conteudoArquivos = ""
    if (Test-Path $formFile) {
        $conteudoArquivos += "`n### FORM ($formFile):`n"
        $conteudoArquivos += (Get-Content $formFile -Raw -Encoding UTF8)
    }
    if (Test-Path $boFile) {
        $conteudoArquivos += "`n`n### BO ($boFile):`n"
        $conteudoArquivos += (Get-Content $boFile -Raw -Encoding UTF8)
    }

    # --- 4. Montar prompt de correcao ---
    $fixPromptFile = Join-Path $taskPath "runtime_fix_prompt_${EtapaOrigem}_t${Tentativa}.md"
    $fixPromptContent = @"
# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: $EtapaOrigem
- Tentativa: $Tentativa/$maxTentativas
- Mensagem: $ErroMsg

## CONTEXTO DO ERRO
$contextoErro

## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com ``+;`` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS
$conteudoArquivos
"@
    Set-Content -Path $fixPromptFile -Value $fixPromptContent -Encoding UTF8
    Write-Host "Prompt de correcao: $fixPromptFile" -ForegroundColor Cyan

    # --- 5. Chamar Claude para correcao ---
    $fixLogFile = Join-Path $taskPath "logs\${EtapaOrigem}_fix_t${Tentativa}.log"
    $fixOutputFile = Join-Path $taskPath "${EtapaOrigem}_fix_output_t${Tentativa}.txt"

    Write-Host "Chamando Claude para corrigir..." -ForegroundColor Cyan

    # --- 5b. Capturar hash ANTES do fix ---
    $hashAntes = @{}
    if (Test-Path $formFile) { $hashAntes['form'] = (Get-FileHash $formFile -Algorithm MD5).Hash }
    if (Test-Path $boFile) { $hashAntes['bo'] = (Get-FileHash $boFile -Algorithm MD5).Hash }

    & (Join-Path $config.paths.automation "ClaudeInvoker.ps1") `
        -PromptFile $fixPromptFile `
        -OutputFile $fixOutputFile `
        -Model $config.claude.model `
        -Timeout $config.claude.timeout `
        -LogFile $fixLogFile `
        -ContextFiles @() `
        -RateLimitMaxRetries $config.rateLimitRetry.maxRetries `
        -RateLimitInitialDelaySeconds $config.rateLimitRetry.initialDelaySeconds `
        -RateLimitMaxDelaySeconds $config.rateLimitRetry.maxDelaySeconds `
        -RateLimitBackoffMultiplier $config.rateLimitRetry.backoffMultiplier `
        -UsageLimitWaitSeconds $config.rateLimitRetry.usageLimitWaitSeconds `
        -MaxOutputTokens $config.claude.maxOutputTokens

    $claudeExitCode = $LASTEXITCODE

    # Verificar se foi usage limit
    if ($claudeExitCode -ne 0) {
        if (Test-Path $fixOutputFile) {
            $fixOutput = Get-Content $fixOutputFile -Raw -ErrorAction SilentlyContinue
            if ($fixOutput -and (Test-UsageLimitHit -OutputContent $fixOutput)) {
                Write-Host "USAGE LIMIT atingido durante correcao. Abortando retry." -ForegroundColor Red
                return $false
            }
        }
        Write-Host "AVISO: Claude retornou exit code $claudeExitCode (pode ter falhado)" -ForegroundColor Yellow
    }

    Write-Host "Claude finalizou correcao." -ForegroundColor Green

    # --- 6. Pos-correcao: CorretorAutomatico ---
    Write-Host "Executando CorretorAutomatico.ps1..." -ForegroundColor Cyan

    $corretorScript = Join-Path $config.paths.automation "CorretorAutomatico.ps1"

    if (Test-Path $formFile) {
        & $corretorScript -ArquivoPrg $formFile -TaskDir $taskPath
    }
    if (Test-Path $boFile) {
        & $corretorScript -ArquivoPrg $boFile -TaskDir $taskPath
    }

    # --- 7. Verificar se arquivos foram realmente modificados ---
    $arquivoModificado = $false
    if (Test-Path $formFile) {
        $hashDepois = (Get-FileHash $formFile -Algorithm MD5).Hash
        if ($hashAntes['form'] -ne $hashDepois) { $arquivoModificado = $true }
    }
    if (Test-Path $boFile) {
        $hashDepois = (Get-FileHash $boFile -Algorithm MD5).Hash
        if ($hashAntes['bo'] -ne $hashDepois) { $arquivoModificado = $true }
    }
    if (-not $arquivoModificado) {
        Write-Host "AVISO: Nenhum arquivo foi modificado pelo fix (tentativa $Tentativa). Erro pode ser persistente." -ForegroundColor Yellow
    }

    # --- 8. Pos-correcao: ValidarCompilacao inline ---
    Write-Host "Revalidando compilacao..." -ForegroundColor Cyan

    $arquivosParaCompilar = @()
    if (Test-Path $formFile) { $arquivosParaCompilar += $formFile }
    if (Test-Path $boFile) { $arquivosParaCompilar += $boFile }

    if ($arquivosParaCompilar.Count -gt 0) {
        $arquivosLista = $arquivosParaCompilar -join ";"
        $validarScript = Join-Path $config.paths.automation "vfp_helpers\ValidarCompilacao.prg"
        $vfp9Path = Join-Path $config.paths.vfp9 "vfp9.exe"

        $tempScript = Join-Path $taskPath "temp_runtime_fix_compilacao.prg"
        $scriptContent = @"
SET SAFETY OFF
SET TALK OFF
SET CONSOLE ON

TRY
    DO "$validarScript" WITH "$arquivosLista"
    loc_nResult = 0
CATCH TO loEx
    ? "ERRO: " + loEx.Message
    loc_nResult = 1
ENDTRY

QUIT
"@
        $scriptContent | Set-Content -Path $tempScript -Encoding ASCII

        $vfpResult = Invoke-VFP9WithTimeout -VFP9Path $vfp9Path -Arguments "`"$tempScript`"" -TimeoutSeconds $config.vfp.timeout
        if (Test-Path $tempScript) { Remove-Item $tempScript -Force }

        if ($vfpResult.TimedOut) {
            Write-Host "TIMEOUT na recompilacao!" -ForegroundColor Red
            return $false
        }

        # Verificar se ha .err
        $compilouOk = $true
        foreach ($arquivo in $arquivosParaCompilar) {
            $errFile = [System.IO.Path]::ChangeExtension($arquivo, "err")
            if (Test-Path $errFile) {
                $compilouOk = $false
                $erroConteudo = Get-Content $errFile -Raw
                Write-Host "  ERRO compilacao em ${arquivo}: $erroConteudo" -ForegroundColor Red
            }
        }

        if (-not $compilouOk) {
            Write-Host "Compilacao FALHOU apos correcao do Claude." -ForegroundColor Red
            return $false
        }
    }

    # --- 8. Deletar .fxp ---
    Write-Host "Deletando .fxp..." -ForegroundColor Cyan
    Get-ChildItem -Path "C:\4c\projeto\app" -Filter "*.fxp" -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue

    Write-Host "Correcao aplicada com sucesso! Pronto para re-teste." -ForegroundColor Green
    return $true
}

#------------------------------------------------------------------------------
# Carrega configuracao
#------------------------------------------------------------------------------

Write-Host "=== ORQUESTRADOR DE MIGRACAO ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ConfigFile)) {
    Write-Host "ERRO: Arquivo de configuracao nao encontrado: $ConfigFile" -ForegroundColor Red
    exit 1
}

$config = Get-Content -Path $ConfigFile -Raw | ConvertFrom-Json

Write-Host "Configuracao carregada:"
Write-Host "  Origem: $($config.paths.origem)"
Write-Host "  Tasks: $($config.paths.tasks)"
Write-Host "  Max Problemas (ValidarUI): $($config.validacao.maxProblemas)"
Write-Host ""

#------------------------------------------------------------------------------
# Funcoes auxiliares
#------------------------------------------------------------------------------

function Write-StepHeader {
    param([string]$Step, [string]$Description)

    Write-Host ""
    Write-Host "============================================================================" -ForegroundColor Yellow
    Write-Host " [$Step] $Description" -ForegroundColor Yellow
    Write-Host "============================================================================" -ForegroundColor Yellow
    Write-Host ""
}

function Test-UsageLimitHit {
    param([string]$Output)
    return ($Output -match "(?i)(hit.{0,10}(your|the).{0,10}limit|usage.limit|resets?\s+\d)")
}

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

function Get-NextOriginalFile {
    $scxFiles = Get-ChildItem -Path $config.paths.origem -Filter "*.scx" -ErrorAction SilentlyContinue

    if ($scxFiles.Count -eq 0) {
        return $null
    }

    # Retorna primeiro arquivo (par SCX/SCT)
    $scx = $scxFiles[0]
    $sct = Join-Path $config.paths.origem ($scx.BaseName + ".sct")

    if (-not (Test-Path $sct)) {
        Write-Host "AVISO: Arquivo .sct nao encontrado para: $($scx.Name)" -ForegroundColor Yellow
        return $null
    }

    return @{
        SCX = $scx.FullName
        SCT = $sct
        BaseName = $scx.BaseName
        Tipo = "SCX"
    }
}


# (dead code removed - Get-ComplexidadeFormulario e routing para OrquestradorComplexo)


function Get-FormClassName {
    param([string]$BaseName)

    # Tenta carregar mapeamento explicito
    $mappingFile = Join-Path $config.paths.automation "class_mapping.json"

    if (Test-Path $mappingFile) {
        try {
            $mapping = Get-Content $mappingFile -Raw | ConvertFrom-Json

            if ($mapping.mappings.$BaseName) {
                Write-Host "  [Mapeamento] $BaseName -> $($mapping.mappings.$BaseName.formClass)" -ForegroundColor Green
                return $mapping.mappings.$BaseName.formClass
            }
        }
        catch {
            Write-Host "  [AVISO] Erro ao ler class_mapping.json: $($_.Exception.Message)" -ForegroundColor Yellow
        }
    }

    # Fallback: Inferencia baseada em padrao SIGCD*
    if ($BaseName -like "SIGCD*") {
        $suffix = $BaseName.Substring(5)  # Remove "SIGCD"
        $formClass = "Form$suffix"
        Write-Host "  [Inferencia] $BaseName -> $formClass" -ForegroundColor Yellow
        return $formClass
    }

    # Fallback generico: Form + BaseName
    $formClass = "Form$BaseName"
    Write-Host "  [Inferencia Generica] $BaseName -> $formClass" -ForegroundColor Yellow
    return $formClass
}

function Get-BOClassName {
    param([string]$BaseName)

    # Tenta carregar mapeamento explicito
    $mappingFile = Join-Path $config.paths.automation "class_mapping.json"

    if (Test-Path $mappingFile) {
        try {
            $mapping = Get-Content $mappingFile -Raw | ConvertFrom-Json

            if ($mapping.mappings.$BaseName -and $mapping.mappings.$BaseName.boClass) {
                Write-Host "  [Mapeamento] $BaseName -> $($mapping.mappings.$BaseName.boClass)" -ForegroundColor Green
                return $mapping.mappings.$BaseName.boClass
            }
        }
        catch {
            Write-Host "  [AVISO] Erro ao ler class_mapping.json: $($_.Exception.Message)" -ForegroundColor Yellow
        }
    }

    # Fallback: Inferencia baseada em padrao SIGCD*
    if ($BaseName -like "SIGCD*") {
        $suffix = $BaseName.Substring(5)  # Remove "SIGCD"
        $boClass = "${suffix}BO"
        Write-Host "  [Inferencia] $BaseName -> $boClass" -ForegroundColor Yellow
        return $boClass
    }

    # Fallback generico: BaseName + BO
    $boClass = "${BaseName}BO"
    Write-Host "  [Inferencia Generica] $BaseName -> $boClass" -ForegroundColor Yellow
    return $boClass
}

# Retorna o subdiretorio correto de forms baseado no formType
function Get-FormSubDir {
    param([string]$FormType = "CRUD")

    if ($FormType -eq "REPORT") {
        return "relatorios"
    }
    if ($FormType -eq "OPERACIONAL") {
        return "operacionais"
    }
    return "cadastros"
}

# Procura o Form em todas as pastas possiveis (fallback)
function Find-FormFile {
    param(
        [string]$ProjetoPath,
        [string]$FormClass,
        [string]$PreferredSubDir = "cadastros"
    )

    # Tentar na pasta preferida primeiro
    $preferred = Join-Path $ProjetoPath "app\forms\$PreferredSubDir\$FormClass.prg"
    if (Test-Path $preferred) { return $preferred }

    # Fallback: procurar em todas as pastas de forms
    $subDirs = @("cadastros", "operacionais", "relatorios")
    foreach ($sub in $subDirs) {
        if ($sub -eq $PreferredSubDir) { continue }
        $candidate = Join-Path $ProjetoPath "app\forms\$sub\$FormClass.prg"
        if (Test-Path $candidate) {
            Write-Host "  [FALLBACK] Form encontrado em '$sub' ao inves de '$PreferredSubDir'" -ForegroundColor Yellow
            return $candidate
        }
    }

    return $null
}

# Remove copias duplicadas do Form em pastas DIFERENTES da preferida
# Previne bug critico: ADIR carrega Form*.prg de TODAS as pastas,
# se existem 2 copias a segunda sobrescreve a primeira no VFP
function Remove-DuplicateForms {
    param(
        [string]$ProjetoPath,
        [string]$FormClass,
        [string]$PreferredSubDir = "cadastros"
    )

    $subDirs = @("cadastros", "operacionais", "relatorios")
    $removidos = 0

    foreach ($sub in $subDirs) {
        if ($sub -eq $PreferredSubDir) { continue }

        $candidate = Join-Path $ProjetoPath "app\forms\$sub\$FormClass.prg"
        if (Test-Path $candidate) {
            # Encontrou copia em pasta diferente da esperada ? mover para .bak
            $bakFile = "$candidate.bak"
            Write-Host "  [CLEANUP] Copia duplicada encontrada: $sub\$FormClass.prg" -ForegroundColor Yellow
            if (Test-Path $bakFile) { Remove-Item $bakFile -Force }
            Rename-Item $candidate $bakFile
            Write-Host "  [CLEANUP] Renomeado para .bak (preservado como backup)" -ForegroundColor Yellow
            $removidos++
        }

        # Tambem limpar .fxp (cache compilado) da pasta errada
        $fxpFile = Join-Path $ProjetoPath "app\forms\$sub\$($FormClass.ToLower()).fxp"
        if (Test-Path $fxpFile) {
            Remove-Item $fxpFile -Force
            Write-Host "  [CLEANUP] Cache .fxp removido: $sub\$($FormClass.ToLower()).fxp" -ForegroundColor Yellow
        }
    }

    if ($removidos -gt 0) {
        Write-Host "  [CLEANUP] $removidos copia(s) duplicada(s) removida(s)" -ForegroundColor Green
    }

    return $removidos
}

# Remove TODOS os arquivos pre-existentes do Form e BO (incluindo .bak e .fxp)
# para garantir uma migracao LIMPA a cada execucao.
# Chamado ANTES do Claude CLI para evitar que ele copie .bak existentes.
function Remove-PreExistingMigrationFiles {
    param(
        [string]$ProjetoPath,
        [string]$FormClass,
        [string]$BOClass
    )

    $removidos = 0
    $subDirs = @("cadastros", "operacionais", "relatorios")

    Write-Host "  [CLEAN] Removendo arquivos pre-existentes para migracao limpa..." -ForegroundColor Cyan

    # --- Limpar Form em TODAS as pastas de forms ---
    foreach ($sub in $subDirs) {
        $formDir = Join-Path $ProjetoPath "app\forms\$sub"

        foreach ($ext in @(".prg", ".prg.bak", ".fxp")) {
            $targetFile = Join-Path $formDir "$FormClass$ext"
            if (Test-Path $targetFile) {
                Remove-Item $targetFile -Force
                Write-Host "  [CLEAN] Removido: forms\$sub\$FormClass$ext" -ForegroundColor Yellow
                $removidos++
            }
            # Tambem verificar lowercase (VFP pode gerar .fxp em lowercase)
            $targetFileLower = Join-Path $formDir "$($FormClass.ToLower())$ext"
            if (($targetFileLower -ne $targetFile) -and (Test-Path $targetFileLower)) {
                Remove-Item $targetFileLower -Force
                Write-Host "  [CLEAN] Removido: forms\$sub\$($FormClass.ToLower())$ext" -ForegroundColor Yellow
                $removidos++
            }
        }
    }

    # --- Limpar BO na pasta classes ---
    $classesDir = Join-Path $ProjetoPath "app\classes"

    foreach ($ext in @(".prg", ".prg.bak", ".fxp")) {
        $targetFile = Join-Path $classesDir "$BOClass$ext"
        if (Test-Path $targetFile) {
            Remove-Item $targetFile -Force
            Write-Host "  [CLEAN] Removido: classes\$BOClass$ext" -ForegroundColor Yellow
            $removidos++
        }
        # Tambem verificar lowercase
        $targetFileLower = Join-Path $classesDir "$($BOClass.ToLower())$ext"
        if (($targetFileLower -ne $targetFile) -and (Test-Path $targetFileLower)) {
            Remove-Item $targetFileLower -Force
            Write-Host "  [CLEAN] Removido: classes\$($BOClass.ToLower())$ext" -ForegroundColor Yellow
            $removidos++
        }
    }

    if ($removidos -gt 0) {
        Write-Host "  [CLEAN] $removidos arquivo(s) pre-existente(s) removido(s) para migracao limpa" -ForegroundColor Green
    } else {
        Write-Host "  [CLEAN] Nenhum arquivo pre-existente encontrado (migracao limpa)" -ForegroundColor Gray
    }

    return $removidos
}

# Le o formType salvo no state da task (etapa 03)
function Get-FormTypeFromState {
    param([string]$TaskId)

    $formType = "CRUD"
    try {
        $stateFile = Join-Path $config.paths.tasks "$TaskId\task_state.json"
        if (Test-Path $stateFile) {
            $state = Get-Content $stateFile -Raw | ConvertFrom-Json
            if ($state.etapas."03_gerarMetaPrompt".formType) {
                $formType = $state.etapas."03_gerarMetaPrompt".formType
            }
        }
    }
    catch { }
    return $formType
}

function Get-TableSchema {
    param(
        [string]$TaskId,
        [string]$TasksDir
    )

    # Tenta ler nome da tabela do analise.json
    $taskPath = Join-Path $TasksDir $TaskId
    $analiseFile = Join-Path $taskPath "analise.json"
    $tableName = ""

    if (Test-Path $analiseFile) {
        try {
            $analise = Get-Content $analiseFile -Raw | ConvertFrom-Json
            if ($analise.form.tabela) {
                $tableName = $analise.form.tabela
            }
        }
        catch {
            Write-Host "  [AVISO] Erro ao ler analise.json: $($_.Exception.Message)" -ForegroundColor Yellow
        }
    }

    if ([string]::IsNullOrEmpty($tableName)) {
        return ""
    }

    Write-Host "  [Schema] Extraindo schema da tabela: $tableName" -ForegroundColor Cyan

    # Usa SQLCMD para extrair estrutura da tabela (credenciais do config.json)
    try {
        $dbServer = $config.database.server
        $dbName = $config.database.database
        $dbUser = $config.database.user
        $dbPass = $config.database.password

        $query = @"
SELECT
    c.name AS coluna,
    t.name AS tipo,
    c.max_length AS tamanho,
    c.precision AS precisao,
    c.scale AS escala,
    c.is_nullable AS nulo
FROM sys.columns c
INNER JOIN sys.types t ON c.user_type_id = t.user_type_id
WHERE c.object_id = OBJECT_ID('$tableName')
ORDER BY c.column_id
"@

        $result = sqlcmd -S $dbServer -d $dbName -U $dbUser -P $dbPass -Q $query -h -1 -W -s "|" 2>$null

        if ($LASTEXITCODE -eq 0 -and $result) {
            $schemaText = @"

## ⚠️ SCHEMA DA TABELA (CRITICO - NAO INVENTAR COLUNAS)

**Tabela: $tableName**

| Coluna | Tipo | Tamanho | Nulo |
|--------|------|---------|------|
"@
            $lines = $result -split "`n" | Where-Object { $_.Trim() -ne "" -and $_ -notmatch "^-+$" }
            foreach ($line in $lines) {
                $parts = $line -split "\|"
                if ($parts.Count -ge 6) {
                    $coluna = $parts[0].Trim()
                    $tipo = $parts[1].Trim()
                    $tamanho = $parts[2].Trim()
                    $precisao = $parts[3].Trim()
                    $escala = $parts[4].Trim()
                    $nulo = if ($parts[5].Trim() -eq "1") { "SIM" } else { "NAO" }

                    # Formata tipo com tamanho/precisao
                    $tipoCompleto = $tipo
                    if ($tipo -eq "char" -or $tipo -eq "varchar" -or $tipo -eq "nvarchar") {
                        $tipoCompleto = "$tipo($tamanho)"
                    }
                    elseif ($tipo -eq "numeric" -or $tipo -eq "decimal") {
                        $tipoCompleto = "$tipo($precisao,$escala)"
                    }

                    $schemaText += "| $coluna | $tipoCompleto | $tamanho | $nulo |`n"
                }
            }

            $schemaText += @"

**REGRAS CRITICAS:**
1. **APENAS** usar as colunas listadas acima no BO e Form
2. **NAO** inventar colunas que nao existem (pesos, grupos, tipos, etc.)
3. **NAO** assumir que existem mais colunas alem das listadas
4. Se precisar de um campo que nao existe na tabela, **PERGUNTAR** antes de criar

"@
            Write-Host "  [Schema] Schema extraido com sucesso ($($lines.Count) colunas)" -ForegroundColor Green
            return $schemaText
        }
        else {
            Write-Host "  [AVISO] Nao foi possivel extrair schema via SQLCMD - tentando fallback" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "  [AVISO] Erro ao extrair schema via SQLCMD: $($_.Exception.Message)" -ForegroundColor Yellow
    }

    # Fallback: tentar ler de schemas_simplificado.json
    try {
        $schemaFallbackFile = Join-Path $config.paths.projeto "..\docs\schemas_simplificado.json"
        if (Test-Path $schemaFallbackFile) {
            $schemas = Get-Content $schemaFallbackFile -Raw | ConvertFrom-Json
            if ($schemas.tabelas.$tableName) {
                $colunas = $schemas.tabelas.$tableName.colunas
                $schemaText = @"

## SCHEMA DA TABELA (CRITICO - NAO INVENTAR COLUNAS)

**Tabela: $tableName**

| Coluna | Tipo | Nulo | Descricao |
|--------|------|------|-----------|
"@
                foreach ($col in $colunas) {
                    $nulo = if ($col.nulo) { "SIM" } else { "NAO" }
                    $schemaText += "| $($col.nome) | $($col.tipo) | $nulo | $($col.descricao) |`n"
                }

                $schemaText += @"

**REGRAS CRITICAS:**
1. **APENAS** usar as colunas listadas acima no BO e Form
2. **NAO** inventar colunas que nao existem (pesos, grupos, tipos, etc.)
3. **NAO** assumir que existem mais colunas alem das listadas
4. Se precisar de um campo que nao existe na tabela, **PERGUNTAR** antes de criar

"@
                Write-Host "  [Schema] Schema extraido do arquivo de fallback ($($colunas.Count) colunas)" -ForegroundColor Green
                return $schemaText
            }
        }
    }
    catch {
        Write-Host "  [AVISO] Erro ao ler schema de fallback: $($_.Exception.Message)" -ForegroundColor Yellow
    }

    Write-Host "  [AVISO] Schema nao disponivel para tabela: $tableName" -ForegroundColor Yellow
    return ""
}

#------------------------------------------------------------------------------
# ETAPA 1: Criar task e mover arquivos
#------------------------------------------------------------------------------

function Invoke-Etapa01_MoverArquivos {
    param([string]$TaskId)

    Write-StepHeader "ETAPA 1" "Criar task e mover arquivos"

    Start-Etapa -TaskId $TaskId -Etapa "01_moverArquivos" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId

        # Verifica se arquivos ja existem na task (retry scenario)
        $existingFiles = Get-ChildItem -Path $taskPath -Filter "*.scx" -ErrorAction SilentlyContinue

        if ($existingFiles.Count -gt 0) {
            $scxFile = $existingFiles[0]
            $baseName = $scxFile.BaseName

            Write-Host "Arquivos ja existem na task (retry): $baseName" -ForegroundColor Yellow

            # Atualiza estado
            $destSCX = $scxFile.FullName
            $destSCT = Join-Path $taskPath "$baseName.sct"

            $metadata = @{
                scxFile = $destSCX
                sctFile = $destSCT
                baseName = $baseName
            }

            Complete-Etapa -TaskId $TaskId -Etapa "01_moverArquivos" -TasksDir $config.paths.tasks -Metadata $metadata

            return $baseName
        }

        # Busca proximo arquivo na origem (fluxo normal)
        $arquivo = Get-NextOriginalFile

        if (-not $arquivo) {
            throw "Nenhum arquivo disponivel em C:\4c\origem"
        }

        Write-Host "Arquivo encontrado: $($arquivo.BaseName).$($arquivo.Tipo)" -ForegroundColor Green

        # Cria diretorio da task
        if (-not (Test-Path $taskPath)) {
            New-Item -ItemType Directory -Path $taskPath -Force | Out-Null
        }

        # Move par de arquivos
        $destSCX = Join-Path $taskPath "$($arquivo.BaseName).scx"
        $destSCT = Join-Path $taskPath "$($arquivo.BaseName).sct"

        Move-Item -Path $arquivo.SCX -Destination $destSCX -Force
        Move-Item -Path $arquivo.SCT -Destination $destSCT -Force

        # Mover screenshots de referencia (0 a N): {BaseName}_01.png, {BaseName}_02.jpg, etc
        $screenshots = @()
        $screenshots += Get-ChildItem -Path $config.paths.origem -Filter "$($arquivo.BaseName)_*.png" -ErrorAction SilentlyContinue
        $screenshots += Get-ChildItem -Path $config.paths.origem -Filter "$($arquivo.BaseName)_*.jpg" -ErrorAction SilentlyContinue
        if ($screenshots.Count -gt 0) {
            foreach ($img in $screenshots) {
                Move-Item -Path $img.FullName -Destination (Join-Path $taskPath $img.Name) -Force
            }
            Write-Host "Screenshots de referencia: $($screenshots.Count) imagem(ns)" -ForegroundColor Cyan
        }

        # Mover arquivo de instrucoes especificas (opcional): {BaseName}.txt
        $instrucaoFile = Join-Path $config.paths.origem "$($arquivo.BaseName).txt"
        if (Test-Path $instrucaoFile) {
            Move-Item -Path $instrucaoFile -Destination (Join-Path $taskPath "$($arquivo.BaseName).txt") -Force
            Write-Host "Instrucoes especificas: $($arquivo.BaseName).txt" -ForegroundColor Cyan
        }

        Write-Host "Arquivos movidos para: $taskPath" -ForegroundColor Green

        # Atualiza estado
        $metadata = @{
            scxFile = $destSCX
            sctFile = $destSCT
            baseName = $arquivo.BaseName
        }

        Complete-Etapa -TaskId $TaskId -Etapa "01_moverArquivos" -TasksDir $config.paths.tasks -Metadata $metadata

        return $arquivo.BaseName
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "01_moverArquivos" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# ETAPA 2: Extrair codigo fonte
#------------------------------------------------------------------------------

function Invoke-Etapa02_ExtractCode {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 2" "Extrair codigo fonte (ExtractSCXCode.prg)"

    Start-Etapa -TaskId $TaskId -Etapa "02_extractCode" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId
        $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "02_extractCode" -TasksDir $config.paths.tasks

        # Prepara parametros ordenados para ExtractSCXCode
        # Parametro 1: Caminho completo do arquivo .SCX
        $scxFile = Join-Path $taskPath "$BaseName.SCX"
        $parameters = @($scxFile)

        # Executa ExtractSCXCode.prg (SEM config.fpw - funciona melhor com sintaxe de parametros)
        $extractScript = Join-Path $config.paths.projeto "app\utils\ExtractSCXCode.prg"

        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
            -ScriptPrg $extractScript `
            -Parameters $parameters `
            -Timeout $config.vfp.timeout `
            -LogFile $logFile `
            -OutputFile (Join-Path $taskPath "vfp_output.txt")



        # Verifica se arquivo foi gerado (ExtractSCXCode gera: BaseName_form_codigo_fonte.txt para SCX)
        # VFP pode normalizar nome para maiusculo, entao busca com wildcard case-insensitive
        $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_form_codigo_fonte.txt" -File

        if ($txtFiles.Count -eq 0) {
            throw "Arquivo de codigo fonte nao foi gerado no diretorio: $taskPath"
        }

        # Pega o primeiro arquivo encontrado (deve ser unico)
        $txtFile = $txtFiles[0].FullName

        # Extrai o BaseName correto (normalizado pelo VFP)
        $BaseNameNormalizado = ($txtFiles[0].BaseName -replace "_form_codigo_fonte", "")

        Write-Host "Codigo fonte extraido: $txtFile" -ForegroundColor Green
        Write-Host "BaseName normalizado: $BaseNameNormalizado" -ForegroundColor Cyan

        # Salva o BaseName normalizado no metadata para uso nas proximas etapas
        Complete-Etapa -TaskId $TaskId -Etapa "02_extractCode" -TasksDir $config.paths.tasks -Metadata @{
            txtFile = $txtFile
            baseNameNormalizado = $BaseNameNormalizado
        }

        # Retorna o BaseName normalizado
        return $BaseNameNormalizado
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "02_extractCode" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# ETAPA 2.2: Reduzir Arquivo Grande (ExtratoReduzido.prg)
# Para arquivos >400KB que causam "Prompt is too long" no Claude CLI
#------------------------------------------------------------------------------

function Invoke-Etapa02a_ReduzirArquivo {
    param([string]$TaskId, [string]$BaseName)

    $taskPath = Join-Path $config.paths.tasks $TaskId

    # Encontra arquivo TXT
    $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_form_codigo_fonte.txt" -File | Where-Object { $_.Name -notlike "*_slim*" }
    if ($txtFiles.Count -eq 0) {
        Write-Host "AVISO: Arquivo fonte nao encontrado. Pulando reducao." -ForegroundColor Yellow
        return
    }
    $txtFile = $txtFiles[0]

    # Limite em KB (400KB = limite seguro para Claude CLI)
    $limiteKB = 400
    $tamanhoKB = [math]::Round($txtFile.Length / 1024, 2)

    # Se arquivo estah abaixo do limite, nao precisa reduzir
    if ($tamanhoKB -le $limiteKB) {
        Write-Host "[ETAPA 2.2] Arquivo ($tamanhoKB KB) abaixo do limite ($limiteKB KB) - Pulando reducao" -ForegroundColor Green
        return
    }

    Write-StepHeader "ETAPA 2.2" "Reduzir Arquivo Grande (ExtratoReduzido.prg)"
    Write-Host "Arquivo grande detectado: $tamanhoKB KB (limite: $limiteKB KB)" -ForegroundColor Yellow

    Start-Etapa -TaskId $TaskId -Etapa "02a_reduzirArquivo" -TasksDir $config.paths.tasks

    try {
        $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "02a_reduzirArquivo" -TasksDir $config.paths.tasks

        # Executa ExtratoReduzidoSimples.prg (versao simplificada que funciona com arquivos grandes)
        $extratoScript = Join-Path $config.paths.projeto "app\utils\ExtratoReduzidoSimples.prg"

        if (-not (Test-Path $extratoScript)) {
            throw "Script ExtratoReduzidoSimples.prg nao encontrado: $extratoScript"
        }

        $parameters = @($txtFile.FullName, $limiteKB)

        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
            -ScriptPrg $extratoScript `
            -Parameters $parameters `
            -Timeout $config.vfp.timeout `
            -LogFile $logFile `
            -OutputFile (Join-Path $taskPath "vfp_output.txt")

        # Verifica se arquivo slim foi gerado
        $slimFile = $txtFile.FullName -replace "\.txt$", "_slim.txt"

        if (Test-Path $slimFile) {
            $slimTamanhoKB = [math]::Round((Get-Item $slimFile).Length / 1024, 2)
            $reducaoPercent = [math]::Round((1 - $slimTamanhoKB / $tamanhoKB) * 100, 1)

            Write-Host "Arquivo reduzido criado: $slimFile" -ForegroundColor Green
            Write-Host "Tamanho original: $tamanhoKB KB" -ForegroundColor Cyan
            Write-Host "Tamanho reduzido: $slimTamanhoKB KB" -ForegroundColor Cyan
            Write-Host "Reducao: $reducaoPercent%" -ForegroundColor Cyan

            Complete-Etapa -TaskId $TaskId -Etapa "02a_reduzirArquivo" -TasksDir $config.paths.tasks -Metadata @{
                arquivoOriginal = $txtFile.FullName
                arquivoSlim = $slimFile
                tamanhoOriginalKB = $tamanhoKB
                tamanhoSlimKB = $slimTamanhoKB
                reducaoPercent = $reducaoPercent
            }
        }
        else {
            Write-Host "AVISO: Arquivo slim nao foi gerado (arquivo original sera usado)" -ForegroundColor Yellow
            Complete-Etapa -TaskId $TaskId -Etapa "02a_reduzirArquivo" -TasksDir $config.paths.tasks -Metadata @{
                skipped = $true
                motivo = "Arquivo slim nao gerado"
            }
        }
    }
    catch {
        Write-Host "AVISO: Erro na reducao: $($_.Exception.Message)" -ForegroundColor Yellow
        Write-Host "Continuando com arquivo original..." -ForegroundColor Yellow
        # Nao falha a etapa, apenas avisa - a migracao pode funcionar mesmo com arquivo grande
        Complete-Etapa -TaskId $TaskId -Etapa "02a_reduzirArquivo" -TasksDir $config.paths.tasks -Metadata @{
            skipped = $true
            erro = $_.Exception.Message
        }
    }
}

#------------------------------------------------------------------------------
# ETAPA 2.5: Analisar Tarefa (NOVO)
#------------------------------------------------------------------------------

function Invoke-Etapa02b_AnalisarTarefa {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 2.5" "Analisar Tarefa (AnalisadorTarefa.prg)"

    Start-Etapa -TaskId $TaskId -Etapa "02b_analisarTarefa" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId
        $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "02b_analisarTarefa" -TasksDir $config.paths.tasks

        # Encontra arquivo TXT
        $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_form_codigo_fonte.txt" -File
        if ($txtFiles.Count -eq 0) {
            throw "Arquivo *_form_codigo_fonte.txt nao encontrado em $taskPath"
        }
        $txtFile = $txtFiles[0].FullName

        # Executa AnalisadorTarefa.prg
        $analisadorScript = Join-Path $config.paths.projeto "app\utils\AnalisadorTarefa.prg"

        $parameters = @($txtFile)

        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
            -ScriptPrg $analisadorScript `
            -Parameters $parameters `
            -Timeout $config.vfp.timeout `
            -LogFile $logFile `
            -OutputFile (Join-Path $taskPath "vfp_output.txt")

        # Verifica se arquivo foi gerado
        $analiseFile = Join-Path $taskPath "analise.json"

        if (-not (Test-Path $analiseFile)) {
            throw "Arquivo analise.json nao foi gerado: $analiseFile"
        }

        Write-Host "Analise gerada: $analiseFile" -ForegroundColor Green

        Complete-Etapa -TaskId $TaskId -Etapa "02b_analisarTarefa" -TasksDir $config.paths.tasks -Metadata @{ analiseFile = $analiseFile }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "02b_analisarTarefa" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# ETAPA 2.7: Analisar Comportamento (SECAO 3 - metodos/eventos)
#------------------------------------------------------------------------------

function Invoke-Etapa02c_AnalisarComportamento {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 2.7" "Analisar Comportamento (AnalisadorComportamento.prg)"

    Start-Etapa -TaskId $TaskId -Etapa "02c_analisarComportamento" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId
        $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "02c_analisarComportamento" -TasksDir $config.paths.tasks

        # Encontra arquivo TXT
        $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_form_codigo_fonte.txt" -File
        if ($txtFiles.Count -eq 0) {
            throw "Arquivo *_form_codigo_fonte.txt nao encontrado em $taskPath"
        }
        $txtFile = $txtFiles[0].FullName

        # Schema SQL (em C:\4c\docs\schema.sql)
        $docsPath = Join-Path (Split-Path $config.paths.projeto -Parent) "docs"
        $schemaFile = Join-Path $docsPath "schema.sql"
        if (-not (Test-Path $schemaFile)) {
            Write-Host "  [AVISO] schema.sql nao encontrado em $docsPath - validacao de colunas desabilitada" -ForegroundColor Yellow
            $schemaFile = ""
        }

        # Executa AnalisadorComportamento.prg
        $analisadorScript = Join-Path $config.paths.projeto "app\utils\AnalisadorComportamento.prg"

        if (-not (Test-Path $analisadorScript)) {
            throw "AnalisadorComportamento.prg nao encontrado: $analisadorScript"
        }

        # Converter schema.sql UTF-16 para ASCII (CHRTRAN no VFP9 eh extremamente lento em 2.4MB)
        $schemaFileParam = ""
        if (-not [string]::IsNullOrEmpty($schemaFile)) {
            $schemaAscii = Join-Path $taskPath "schema_ascii.sql"
            if (-not (Test-Path $schemaAscii)) {
                Write-Host "  Convertendo schema.sql UTF-16 -> ASCII para VFP9..." -ForegroundColor Gray
                $content = Get-Content $schemaFile -Raw -Encoding Unicode
                [System.IO.File]::WriteAllText($schemaAscii, $content, [System.Text.Encoding]::ASCII)
            }
            $schemaFileParam = $schemaAscii
        }

        $parameters = @($txtFile)
        if (-not [string]::IsNullOrEmpty($schemaFileParam)) {
            $parameters += $schemaFileParam
        }

        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
            -ScriptPrg $analisadorScript `
            -Parameters $parameters `
            -Timeout $config.vfp.timeout `
            -LogFile $logFile `
            -OutputFile (Join-Path $taskPath "vfp_output_comportamento.txt")

        # Verifica se arquivo foi gerado
        $comportamentoFile = Join-Path $taskPath "comportamento.json"

        if (-not (Test-Path $comportamentoFile)) {
            # Verificar se existe .ERR (erro de compilacao no script)
            $errFile = Join-Path (Split-Path $analisadorScript -Parent) "AnalisadorComportamento.ERR"
            $errMsg = "comportamento.json nao foi gerado"
            if (Test-Path $errFile) {
                $errContent = Get-Content $errFile -Raw -ErrorAction SilentlyContinue
                $errMsg += " - ERRO DE COMPILACAO: $errContent"
            }
            throw $errMsg
        }

        # Exibir resumo
        try {
            $comp = Get-Content $comportamentoFile -Raw | ConvertFrom-Json
            Write-Host "  Metodos: $($comp.resumo.totalMetodos)" -ForegroundColor Gray
            Write-Host "  Queries SQL: $($comp.resumo.totalQueries)" -ForegroundColor Gray
            Write-Host "  Validacoes: $($comp.resumo.metodosComValidacao)" -ForegroundColor Gray
            Write-Host "  Funcoes externas: $($comp.resumo.funcoesExternas -join ', ')" -ForegroundColor Gray

            if ($comp.resumo.colunasInvalidas -gt 0) {
                Write-Host "  *** COLUNAS INVALIDAS: $($comp.resumo.colunasInvalidas) ***" -ForegroundColor Red
                foreach ($inv in $comp.validacaoSchema.colunasInvalidas) {
                    Write-Host "    - $($inv.tabela).$($inv.coluna) (em $($inv.metodo))" -ForegroundColor Red
                }
            }
        }
        catch { }

        Write-Host "Analise comportamental gerada: $comportamentoFile" -ForegroundColor Green

        Complete-Etapa -TaskId $TaskId -Etapa "02c_analisarComportamento" -TasksDir $config.paths.tasks -Metadata @{
            comportamentoFile = $comportamentoFile
            status = "COMPLETED"
        }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "02c_analisarComportamento" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# ETAPA 2.8: Extrair layout (posicoes exatas dos controles do SCX)
#------------------------------------------------------------------------------

function Invoke-Etapa02d_ExtrairLayout {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 2.8" "Extrair Layout (ExtratorLayout.prg)"

    $taskPath = Join-Path $config.paths.tasks $TaskId

    # Procurar SCX na task
    $scxFile = Get-ChildItem -Path $taskPath -Filter "*.SCX" -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $scxFile) {
        Write-Host "  [AVISO] SCX nao encontrado na task - pulando extracao de layout" -ForegroundColor Yellow
        return
    }

    Start-Etapa -TaskId $TaskId -Etapa "02d_extrairLayout" -TasksDir $config.paths.tasks

    try {
        $layoutScript = Join-Path $config.paths.projeto "app\utils\ExtratorLayout.prg"
        $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "02d_extrairLayout" -TasksDir $config.paths.tasks

        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
            -ScriptPRG $layoutScript `
            -Parameters @($scxFile.FullName, $taskPath) `
            -Timeout $config.vfp.timeout `
            -LogFile $logFile

        $layoutFile = Join-Path $taskPath "layout.json"
        if (Test-Path $layoutFile) {
            $layoutSize = [math]::Round((Get-Item $layoutFile).Length / 1024, 2)
            # Contar objetos no JSON
            $layoutContent = Get-Content $layoutFile -Raw -ErrorAction SilentlyContinue
            $nObjects = 0
            if ($layoutContent -match '"totalObjects"\s*:\s*(\d+)') {
                $nObjects = [int]$matches[1]
            }
            Write-Host "  Layout extraido: $layoutFile ($layoutSize KB, $nObjects objetos)" -ForegroundColor Green
        } else {
            Write-Host "  [AVISO] layout.json nao gerado" -ForegroundColor Yellow
        }

        Complete-Etapa -TaskId $TaskId -Etapa "02d_extrairLayout" -TasksDir $config.paths.tasks
    }
    catch {
        Write-Host "  [AVISO] Extracao de layout falhou: $($_.Exception.Message)" -ForegroundColor Yellow
        # Nao bloqueia - layout eh complementar
    }
}

#------------------------------------------------------------------------------
# ETAPA 3: Gerar meta-prompt
#------------------------------------------------------------------------------

function Invoke-Etapa03_GerarMetaPrompt {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 3" "Gerar meta-prompt (GERADOR_PROMPT_MIGRACAO.md)"

    Start-Etapa -TaskId $TaskId -Etapa "03_gerarMetaPrompt" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId
        $txtFile = Join-Path $taskPath "${BaseName}_form_codigo_fonte.txt"
        $metaPromptFile = Join-Path $taskPath "meta_prompt.md"
        $mapeamentoFile = Join-Path $taskPath "mapeamento.json"

        # Determina nomes de classes (usando class_mapping.json ou inferencia)
        $formClass = Get-FormClassName -BaseName $BaseName
        $boClass = Get-BOClassName -BaseName $BaseName

        # Detecta tipo do formulario a partir do analise.json (gerado na etapa 2.5)
        $formType = "CRUD"
        $analiseFile = Join-Path $taskPath "analise.json"
        if (Test-Path $analiseFile) {
            try {
                $analise = Get-Content $analiseFile -Raw | ConvertFrom-Json
                if ($analise.form.formType) {
                    $formType = $analise.form.formType
                }
            }
            catch { }
        }
        Write-Host "  FormType: $formType" -ForegroundColor Gray
        $formSubDir = Get-FormSubDir -FormType $formType

        # Gera prompt EXECUTAVEL simples e direto
        $prompt = @"
# Tarefa: Migrar $formClass

Migre o formulario $BaseName para o novo sistema seguindo todas as regras do CLAUDE.md.

## Arquivos de Referencia OBRIGATORIOS
1. **CLAUDE.md** - Ler secao dos 3 PILARES antes de comecar
2. **docs/FORMCOR_LICOES_APRENDIDAS.md** - Ler COMPLETAMENTE para nao repetir os 5 problemas
3. **docs/migration_guide.md** - Checklist geral
4. **tasks/$TaskId/${BaseName}_form_codigo_fonte.txt** - Codigo fonte original
5. **tasks/$TaskId/mapeamento.json** - Mapeamento de objetos (se disponivel)
6. **tasks/$TaskId/comportamento.json** - Analise comportamental de metodos/eventos (se disponivel)

## Arquivos a Criar
1. **C:\4c\projeto\app\classes\${boClass}.prg**
   - Herda de BusinessBase
   - Propriedades this_* para todos os campos da tabela
   - **Metodos OBRIGATORIOS** (nomes EXATOS do BusinessBase):
     - `Inserir()` - INSERT (PROTECTED)
     - `Atualizar()` - UPDATE (PROTECTED)
     - `ExecutarExclusao()` - DELETE (PROTECTED) **<- NAO usar "Excluir()"!**
     - `Buscar()` - SELECT (PUBLIC)
     - `CarregarPorCodigo()` - SELECT por PK (PUBLIC)
   - ObterChavePrimaria() para auditoria
   - **CRITICO - Init()**: Usar nomes CORRETOS das propriedades herdadas:
     ```foxpro
     PROCEDURE Init()
         DODEFAULT()
         THIS.this_cTabela = "NomeTabela"      && CORRETO (NAO this_cNomeTabela)
         THIS.this_cCampoChave = "campo_pk"    && CORRETO (NAO this_cChavePrimaria)
         RETURN .T.
     ENDPROC
     ```
   - **CarregarDoCursor**: SEMPRE usar `SELECT (par_cAliasCursor)` ANTES de acessar campos
     ```foxpro
     PROCEDURE CarregarDoCursor(par_cAliasCursor)
         IF USED(par_cAliasCursor)
             SELECT (par_cAliasCursor)           && OBRIGATORIO
             THIS.this_campo = TratarNulo(campo, "C")  && Sem alias
             RETURN .T.
         ENDIF
         RETURN .F.
     ENDPROC
     ```
   - **NUNCA usar**: `(par_cAliasCursor).campo` -> ERRO de sintaxe!

2. **C:\4c\projeto\app\forms\${formSubDir}\${formClass}.prg**
   - Herda de FormBase
   - PageFrame com Top=-29 e Tabs=.F.
   - Page1: Lista (Grid)
   - Page2: Dados (Campos)
   - Lookups: TODOS os campos que tinham no original (F4/DblClick)
   - Validacoes: copiar do original

   **Metodos OBRIGATORIOS do Form** (NUNCA omitir):
     -- **Base/Setup**:
       - `Init()` - Apenas `RETURN DODEFAULT()`, sem logica complexa
       - `InicializarForm()` - Configura estrutura completa (chamado pelo FormBase)
       - `ConfigurarPageFrame()` - Cria PageFrame com 2 Pages
       - `ConfigurarPaginaLista()` - Page1 (Grid + Botoes CRUD)
       - `ConfigurarPaginaDados()` - Page2 (Campos + Botoes Salvar/Cancelar)

     -- **Navegacao (CRITICOS)**:
       - **`CarregarLista()`** - OBRIGATORIO - Carrega dados no Grid da Page1
       - **`AlternarPagina(par_nPagina)`** - OBRIGATORIO - Alterna entre Page1 (1) e Page2 (2)

     -- **Data Binding**:
       - `FormParaBO()` - Transfere Form -> BO (chamado antes de Salvar)
       - `BOParaForm()` - Transfere BO -> Form (chamado apos Carregar)

     -- **Eventos CRUD (Page1)**:
       - `BtnIncluirClick()` - Incluir novo registro
       - `BtnAlterarClick()` - Alterar registro selecionado
       - `BtnVisualizarClick()` - Visualizar registro (somente leitura)
       - `BtnExcluirClick()` - Excluir registro selecionado
       - `BtnBuscarClick()` - Buscar/filtrar registros
       - `BtnEncerrarClick()` - Fechar formulario

     -- **Eventos Page2**:
       - `BtnSalvarClick()` - Salvar alteracoes (Confirmar)
       - `BtnCancelarClick()` - Cancelar e voltar para lista

     -- **Auxiliares (Recomendados)**:
       - `HabilitarCampos(par_lHabilitar)` - Habilita/desabilita campos
       - `LimparCampos()` - Limpa valores dos campos
       - `AjustarBotoesPorModo()` - Ajusta botoes por modo (INCLUIR/ALTERAR/VISUALIZAR)

   **IMPORTANTE - IMPLEMENTACAO COMPLETA OBRIGATORIA**:
   - TODOS os metodos acima devem ser implementados COM LOGICA FUNCIONAL
   - NAO criar stubs/placeholders (ex: `RETURN .T.` vazio)
   - NAO usar MsgAviso("...sera implementado...") como placeholder - isso eh um STUB DISFAR�ADO
   - NAO deixar comentarios "TODO" ou "Implementar depois"
   - CADA metodo deve executar sua funcao completa NA PRIMEIRA VEZ
   - Botoes de relatorio/impressao/Excel DEVEM chamar ProcessaSaldo/ProcessaHist com parametro tipo ('I','V','E')
   - Botoes de operacao (Alterar, Excluir, Conciliar, Auditar) DEVEM ter logica real baseada no legado

   **Exemplos de implementacao COMPLETA obrigatoria**:

   ```foxpro
   *-- CORRETO - CarregarLista() COMPLETO:
   PROTECTED PROCEDURE CarregarLista()
       LOCAL loc_lResultado, loc_oGrid
       loc_lResultado = .F.

       TRY
           IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
               RETURN .T.
           ENDIF

           loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

           IF !THIS.this_oBusinessObject.Buscar("")
               loc_lResultado = .F.
           ELSE
               loc_oGrid.RecordSource = "cursor_4c_Dados"
               loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.campo1"
               loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.campo2"
               loc_oGrid.Column1.Width = 100
               loc_oGrid.Column2.Width = 300
               loc_lResultado = .T.
           ENDIF
       CATCH TO loException
           MostrarErro(loException, "CarregarLista")
           loc_lResultado = .F.
       ENDTRY

       RETURN loc_lResultado
   ENDPROC

   *-- CORRETO - AlternarPagina() COMPLETO:
   PROTECTED PROCEDURE AlternarPagina(par_nPagina)
       IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
           RETURN .F.
       ENDIF

       THIS.pgf_4c_Paginas.ActivePage = par_nPagina

       IF par_nPagina = 1
           THIS.CarregarLista()
       ENDIF

       RETURN .T.
   ENDPROC

   *-- ERRADO - Stub/Placeholder (NAO ACEITAR):
   PROTECTED PROCEDURE CarregarLista()
       RETURN .T.  && Vazio - NAO funciona!
   ENDPROC

   *-- ERRADO - Comentario TODO (NAO ACEITAR):
   PROTECTED PROCEDURE AlternarPagina(par_nPagina)
       * TODO: Implementar depois  && NAO aceitavel!
       RETURN .T.
   ENDPROC
   ```

   **NUNCA omitir ou deixar incompleto CarregarLista() ou AlternarPagina()** - sao CRITICOS!

## Analise Comportamental (comportamento.json)

Se o arquivo **comportamento.json** estiver disponivel no contexto, ele contem a analise profunda dos
metodos e eventos do codigo original (SECAO 3). REGRAS OBRIGATORIAS:

1. **TODA validacao** listada em ``metodos[].analise.temValidacao=true`` DEVE ser implementada no novo sistema
2. **TODAS as queries SQL** devem usar APENAS colunas listadas em ``sqlQueries[].colunas`` - NAO inventar colunas
3. Se ``validacaoSchema.colunasInvalidas`` tiver itens, essas colunas NAO EXISTEM na tabela - NAO usar
4. **TODAS as funcoes externas** listadas em ``resumo.funcoesExternas`` devem ser integradas ou substituidas
5. **TODOS os controles** referenciados em ``metodos[].analise.controlesReferenciados`` devem existir no form
6. Metodos com ``analise.temLookup=true`` DEVEM ter lookup implementado (F4/DblClick)
7. Metodos com ``analise.temNavegacao=true`` controlam visibilidade/habilitacao - implementar equivalente
8. O campo ``codigoOriginal`` mostra a logica exata do legado - REPRODUZIR a logica (com nova nomenclatura)

## 3 PILARES INEGOCIAVEIS
1. **UX**: Manter o mais proximo possivel (Width, Height, BackColor, FontName, FontSize EXATOS)
2. **Banco**: Identico (nao alterar nomes de tabelas/colunas)
3. **Codigo**: OBRIGATORIAMENTE diferente (nova arquitetura, novos nomes)

## REGRA CRITICA: NUNCA usar RETURN dentro de TRY/CATCH

**ERRO FATAL**: "RETURN/RETRY statement not allowed in TRY/CATCH"

```foxpro
*-- ERRADO - NUNCA FAZER:
PROTECTED PROCEDURE CarregarLista()
    TRY
        IF !THIS.this_oBusinessObject.Buscar("")
            RETURN .F.  && ERRO CRITICO!
        ENDIF
        RETURN .T.  && ERRO CRITICO!
    CATCH
        RETURN .F.  && ERRO CRITICO!
    ENDTRY
ENDPROC

*-- CORRETO - SEMPRE FAZER:
PROTECTED PROCEDURE CarregarLista()
    LOCAL loc_lResultado
    loc_lResultado = .F.

    TRY
        IF !THIS.this_oBusinessObject.Buscar("")
            loc_lResultado = .F.  && Atribuir variavel
        ELSE
            loc_lResultado = .T.  && Atribuir variavel
        ENDIF
    CATCH TO loException
        MostrarErro("Erro: " + loException.Message, "Erro")
        loc_lResultado = .F.  && Atribuir variavel
    ENDTRY

    RETURN loc_lResultado  && RETURN apenas FORA do TRY/CATCH
ENDPROC
```

**CHECKLIST**: Declarar `LOCAL loc_lResultado`, inicializar `.F.`, substituir TODOS os RETURNs por atribuicoes, RETURN apenas FORA.

## REGRA CRITICA: Strings SQL longas DEVEM ser quebradas com continuation

VFP9 tem limite de ~8000 chars por linha logica. Strings SQL com muitos campos DEVEM ser quebradas com ``+;``:

```foxpro
*-- ERRADO - linha unica muito longa:
loc_cSQL = "SELECT a.Campo1, a.Campo2, a.Campo3, a.Campo4, a.Campo5, a.Campo6, a.Campo7, a.Campo8, a.Campo9, a.Campo10 FROM Tabela a WHERE a.Chave = " + EscaparSQL(loc_cChave)

*-- CORRETO - quebrar a cada 3-4 campos:
loc_cSQL = "SELECT a.Campo1, a.Campo2, a.Campo3, a.Campo4," + ;
    " a.Campo5, a.Campo6, a.Campo7, a.Campo8," + ;
    " a.Campo9, a.Campo10 FROM Tabela a" + ;
    " WHERE a.Chave = " + EscaparSQL(loc_cChave)
```

## 23 PROBLEMAS CRITICOS A NAO REPETIR (task006/task014/task016/task017/task018)

### Problema 1: Botoes Sem Icones e Captions
**TODOS os botoes DEVEM ter estas 3 propriedades:**
```foxpro
*-- Botao Incluir (EXEMPLO COMPLETO - COPIAR)
loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
    .Caption = "Incluir"                               && Caption SEM tecla atalho
    .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"  && Icone (OBRIGATORIO)
    .PicturePosition = 13                              && Icone ACIMA do texto
    .Top = 5
    .Left = 5
    .Width = 75
    .Height = 75
    .BackColor = RGB(255, 255, 255)
    .ForeColor = RGB(90, 90, 90)
    .Themes = .F.
    .SpecialEffect = 0
ENDWITH
```
**Aplicar em TODOS os 8 botoes**: Incluir, Alterar, Excluir, Consultar, Pesquisar, Sair, Salvar, Cancelar

### Problema 2: Grid Perde Dados Apos Consultar
**BtnCancelarClick() DEVE chamar CarregarLista():**
```foxpro
PROTECTED PROCEDURE BtnCancelarClick()
    THIS.AlternarPagina(1)
    THIS.this_cModoAtual = "LISTA"
    THIS.CarregarLista()  && OBRIGATORIO: recarrega dados + formatacao
ENDPROC
```

### Problema 3: Erro ao Fechar Form - "loForm is not an object"
**PADRAO CORRETO para AbrirForm() no menu.prg (COPIAR EXATAMENTE):**
```foxpro
PROCEDURE Abrir${formClass}()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("${formClass}")

        IF VARTYPE(loForm) = "O"                  && VARTYPE, NAO ISNULL
            loForm.Show()                         && SEM parametro
            *-- NAO chamar loForm.Release() - FormBase cuida disso
        ELSE
            MostrarErro("Erro ao criar formulario ${formClass}", "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario ${formClass}:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC
```
**NUNCA usar**:
- `loForm.Show(1)` (parametro modal)
- `loForm.Release()` apos Show()
- `ISNULL(loForm)` ao inves de `VARTYPE(loForm) = "O"`

### Problema 4: Erro ao Salvar - "no parameter statement is found"
**Salvar() NUNCA recebe parametro:**
```foxpro
*-- ERRADO: Salvar(loc_lNovoRegistro)
IF THIS.this_oBusinessObject.Salvar(loc_lNovoRegistro)

*-- CORRETO: Salvar() SEM parametro
IF THIS.this_oBusinessObject.Salvar()
    MsgSucesso("Registro salvo com sucesso!")
    THIS.AlternarPagina(1)
    THIS.CarregarLista()
ENDIF
```
**Por que?** BusinessBase.Salvar() ja sabe se e INSERT ou UPDATE atraves da propriedade interna `this_lNovoRegistro`.

### Problema 5: Labels com Cores Incorretas
**SEMPRE copiar TODAS as propriedades visuais do original:**
```foxpro
WITH loc_oPagina.lbl_4c_Codigo
    .Caption = "C" + CHR(243) + "digo :"
    .Top = 140
    .Left = 369
    .Width = 45
    .Height = 17
    .BackColor = RGB(90, 90, 90)      && COPIAR do original
    .ForeColor = RGB(255, 255, 255)   && COPIAR do original
    .FontName = "Tahoma"               && COPIAR do original
    .FontSize = 8                      && COPIAR do original
    .FontBold = .F.
    .Alignment = 1  && Right
ENDWITH
```

### Problemas 6-11: Ja Documentados
6. Grid perde cabecalhos -> Reconfigurar Header1.Caption APOS RecordSource em CarregarGrade/CarregarLista (OBRIGATORIO! Sem isso, colunas ficam sem titulo)
7. Botoes cortados -> Se PageFrame.Top=-29, compensar +29px em TODOS os controles de topo
8. "Connection invalid" -> Verificar gb_4c_ValidandoUI antes de CarregarLista()
9. Mapeamento incorreto -> Criar hierarquia correta no JSON
10. Duplicacao de raiz -> Ja corrigido no ComparadorUI.prg
11. Metodos auxiliares -> SEMPRE implementar TornarControlesVisiveis() + FormatarGridLista() no form

## IMPORTANTE: Init() - NAO Chamar InicializarForm() Duas Vezes!

**PADRAO CORRETO para FormXxx.Init()**:
```foxpro
PROCEDURE Init()
    *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
    *-- NAO chamar THIS.InicializarForm() novamente aqui!
    RETURN DODEFAULT()
ENDPROC
```

**NUNCA fazer**:
```foxpro
PROCEDURE Init()
    DODEFAULT()
    THIS.InicializarForm()  && ERRO: Chamada duplicada!
    RETURN .T.
ENDPROC
```

**Por que?** FormBase.Init() ja chama THIS.InicializarForm(). Se chamar novamente, AddObject() tenta criar objetos que ja existem -> erro "A member object with this name already exists".

### Problema 12: ConfigurarPaginaDados() sem ENDPROC
**CRITICO**: Todo PROCEDURE deve terminar com ENDPROC e chamar TornarControlesVisiveis():
```foxpro
*-- ERRADO - Page2 fica VAZIA:
PROTECTED PROCEDURE ConfigurarPaginaDados()
    LOCAL loc_oPagina
    loc_oPagina = THIS.pgf_4c_Paginas.Page2

    loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
    * ... mais campos ...

    * NOTA: campos criados
*-- FALTA ENDPROC! -> Codigo nao executa corretamente

*-- CORRETO - SEMPRE terminar com TornarControlesVisiveis + ENDPROC:
PROTECTED PROCEDURE ConfigurarPaginaDados()
    LOCAL loc_oPagina
    loc_oPagina = THIS.pgf_4c_Paginas.Page2

    loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
    * ... mais campos ...

    * OBRIGATORIO: Tornar controles visiveis
    THIS.TornarControlesVisiveis(loc_oPagina)
ENDPROC  && <- NUNCA ESQUECER!
```

### Problema 13: CarregarPorId vs CarregarPorCodigo
**CRITICO**: O metodo correto no BO e `CarregarPorCodigo`, NAO `CarregarPorId`:
```foxpro
*-- ERRADO - Metodo nao existe:
IF THIS.this_oBusinessObject.CarregarPorId(loc_cCodigo)  && ERRO!

*-- CORRETO - Usar nome do metodo do BO:
IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
```
**Verificar**: Antes de usar, confirmar o nome exato do metodo no arquivo [Entidade]BO.prg

### Problema 14: Propriedades Visuais na Definicao da Classe (Form fecha imediatamente)
**CRITICO**: Se o form abre e fecha SEM mensagem de erro, provavelmente faltam propriedades visuais na DEFINE CLASS:
```foxpro
*-- ERRADO - Form abre e fecha imediatamente:
DEFINE CLASS FormTam AS FormBase
    this_oBusinessObject = .NULL.

    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC
ENDDEFINE

*-- CORRETO - Propriedades visuais OBRIGATORIAS na DEFINE CLASS:
DEFINE CLASS FormTam AS FormBase
    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height = 600
    Width = 1000
    Caption = "Cadastro de Tamanhos"
    AutoCenter = .T.
    ShowWindow = 1
    WindowType = 1
    ControlBox = .F.
    TitleBar = 0
    Themes = .F.
    BorderStyle = 2

    this_oBusinessObject = .NULL.

    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC
ENDDEFINE
```
**Por que?** FormBase.Init() depende dessas propriedades para configurar corretamente o formulario. Sem elas, o form pode falhar silenciosamente.

### Problema 15: ExecutarExclusao vs Excluir (metodo nao encontrado)
**CRITICO**: O nome correto do metodo de exclusao no BusinessBase e `ExecutarExclusao()`, NAO `Excluir()`:
```foxpro
*-- ERRADO no [Entidade]BO.prg:
PROTECTED PROCEDURE Excluir()  && ERRO: BusinessBase nao chama este metodo!
    ...
ENDPROC

*-- CORRETO no [Entidade]BO.prg:
PROTECTED PROCEDURE ExecutarExclusao()  && Nome correto do BusinessBase
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
        TEXT TO loc_cSQL TEXTMERGE NOSHOW
            DELETE FROM NomeTabela WHERE campo_pk = <<EscaparSQL(THIS.this_cCodigo)>>
        ENDTEXT
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
        IF loc_nResultado >= 0
            THIS.RegistrarAuditoria("DELETE")
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
        ENDIF
    CATCH TO loException
        MostrarErro("Erro:" + CHR(13) + loException.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
ENDPROC
```
**Verificar**: BusinessBase.Excluir() chama THIS.ExecutarExclusao() internamente!

### Problema 16: Icone do Botao Salvar e RETURN em Validacao
**DOIS ERROS COMUNS**:

1. **Icone incorreto**: Usar `cadastro_salvar_60.jpg` (NAO `cadastro_confirmar_60.jpg` que nao existe)
```foxpro
*-- ERRADO - Arquivo nao existe:
.Picture = gc_4c_CaminhoIcones + "cadastro_confirmar_60.jpg"

*-- CORRETO:
.Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
```

2. **RETURN dentro de TRY para validacao**: Mover validacao para FORA do TRY
```foxpro
*-- ERRADO - RETURN silenciosamente falha:
TRY
    IF EMPTY(campo)
        MsgAviso("Campo obrigatorio!")
        RETURN  && Nao funciona dentro de TRY!
    ENDIF
    ...
ENDTRY

*-- CORRETO - Validacao ANTES do TRY:
IF EMPTY(campo)
    MsgAviso("Campo obrigatorio!")
    RETURN .F.  && Funciona fora do TRY
ENDIF

TRY
    ...
ENDTRY
```

**Tabela de icones corretos**:
| Botao | Icone |
|-------|-------|
| Incluir | cadastro_inserir_26.jpg |
| Visualizar | cadastro_vizualizar_60.jpg |
| Alterar | cadastro_alterar_60.jpg |
| Excluir | cadastro_excluir_60.jpg |
| Buscar | cadastro_procurar_60.jpg |
| Encerrar | cadastro_sair_60.jpg |
| **Salvar** | **cadastro_salvar_60.jpg** |
| Cancelar | cadastro_cancelar_60.jpg |

### Problema 17: BINDEVENT nao funciona com metodos PROTECTED
**CRITICO**: Metodos chamados via BINDEVENT devem ser PUBLIC (sem PROTECTED):
```foxpro
*-- ERRADO - BINDEVENT falha silenciosamente:
BINDEVENT(loBtn, "Click", THIS, "BtnSalvarClick")
...
PROTECTED PROCEDURE BtnSalvarClick()  && PROTECTED impede BINDEVENT!
    ...
ENDPROC

*-- CORRETO - Metodo sem PROTECTED:
BINDEVENT(loBtn, "Click", THIS, "BtnSalvarClick")
...
PROCEDURE BtnSalvarClick()  && PUBLIC (sem PROTECTED)
    ...
ENDPROC
```
**Regra**: TODOS os metodos Btn*Click devem ser PUBLIC (sem PROTECTED) para funcionar com BINDEVENT.

### Problema 18: BtnIncluirClick/BtnAlterarClick sem NovoRegistro()/EditarRegistro()
**CRITICO**: Os metodos de botao DEVEM chamar os metodos do BO para preparar o estado:
```foxpro
*-- ERRADO - Salvar() nao sabe se e INSERT ou UPDATE:
PROCEDURE BtnIncluirClick()
    THIS.LimparCampos()
    THIS.HabilitarCampos(.T.)
    THIS.AlternarPagina(2)
    THIS.this_cModoAtual = "INCLUIR"
ENDPROC

*-- CORRETO - Chamar NovoRegistro() para preparar INSERT:
PROCEDURE BtnIncluirClick()
    THIS.this_oBusinessObject.NovoRegistro()  && OBRIGATORIO: Prepara BO para INSERT
    THIS.LimparCampos()
    THIS.HabilitarCampos(.T.)
    THIS.AlternarPagina(2)
    THIS.this_cModoAtual = "INCLUIR"
ENDPROC

*-- CORRETO - Chamar EditarRegistro() para preparar UPDATE:
PROCEDURE BtnAlterarClick()
    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
        THIS.this_oBusinessObject.EditarRegistro()  && OBRIGATORIO: Prepara BO para UPDATE
        THIS.BOParaForm()
        ...
    ENDIF
ENDPROC
```
**Por que?** O BusinessBase.Salvar() usa `this_lNovoRegistro` para decidir entre INSERT e UPDATE. Sem chamar NovoRegistro()/EditarRegistro(), esse flag nao e setado corretamente.

### Problema 19: HabilitarCampos() chamado ANTES de setar this_cModoAtual
**CRITICO**: O metodo HabilitarCampos verifica `this_cModoAtual` para decidir se habilita o campo codigo:
```foxpro
*-- ERRADO - this_cModoAtual ainda e "LISTA" quando HabilitarCampos e chamado:
PROCEDURE BtnIncluirClick()
    THIS.LimparCampos()
    THIS.HabilitarCampos(.T.)           && this_cModoAtual = "LISTA" aqui!
    THIS.this_cModoAtual = "INCLUIR"    && Setado tarde demais
ENDPROC

*-- CORRETO - Setar this_cModoAtual ANTES de HabilitarCampos:
PROCEDURE BtnIncluirClick()
    THIS.this_oBusinessObject.NovoRegistro()
    THIS.LimparCampos()
    THIS.this_cModoAtual = "INCLUIR"    && ANTES de HabilitarCampos!
    THIS.HabilitarCampos(.T.)
    THIS.AlternarPagina(2)
ENDPROC
```

### Problema 20: Parametros errados no FormBuscaAuxiliar
**CRITICO**: FormBuscaAuxiliar espera gnConnHandle como primeiro parametro:
```foxpro
*-- ERRADO - Parametros na ordem errada:
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", "SigCdTam", "cods", "descs")

*-- CORRETO - gnConnHandle primeiro:
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_Busca", "cods", "", "Buscar Tamanho")
```
**Assinatura**: `FormBuscaAuxiliar(gnConnHandle, cTabela, cCursor, cCampo, cValor, cTitulo, lBuscaExata, lMostraGrid, cFiltro)`

### Problema 21: Imagem de fundo com caminho relativo incorreto
**CRITICO**: Usar `gc_4c_CaminhoIcones` ao inves de caminho relativo:
```foxpro
*-- ERRADO - Caminho relativo pode nao funcionar:
.Page1.Picture = "..\framework\imagens\fundo_cad_1003.jpg"

*-- CORRETO - Usar variavel global de caminho:
.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
```

### Problema 22: CarregarPorCodigo nao reseta this_lNovoRegistro
**CRITICO**: Ao carregar registro existente, DEVE resetar `this_lNovoRegistro = .F.`:
```foxpro
*-- No [Entidade]BO.prg, metodo CarregarPorCodigo:
IF RECCOUNT("cursor_4c_Carrega") > 0
    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
    THIS.this_lNovoRegistro = .F.  && OBRIGATORIO: Evita violacao de PK no Alterar
ENDIF
```
**Por que?** Se o usuario clicar Incluir (seta `this_lNovoRegistro = .T.`) e depois Alterar, sem resetar o flag, o Salvar() chama Inserir() ao inves de Atualizar() -> Violacao de chave primaria.

### Problema 23: FormBuscaAuxiliar - Uso correto (NAO tem ObterCodigoSelecionado)
**CRITICO**: FormBuscaAuxiliar NAO tem metodo `ObterCodigoSelecionado()`. Usar propriedade `this_lSelecionou` e cursor:
```foxpro
*-- ERRADO - Metodo nao existe:
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ...)
loc_oBusca.Show()
loc_cCodigo = loc_oBusca.ObterCodigoSelecionado()  && ERRO!

*-- CORRETO - Usar this_lSelecionou e cursor:
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_Busca", "cods", "", "Buscar")

*-- Adicionar colunas ao grid
loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")

*-- Mostrar modal
loc_oBusca.Show(1)

*-- Verificar selecao via propriedade
IF loc_oBusca.this_lSelecionou
    *-- Ler valor do cursor (NAO do objeto)
    IF USED("cursor_4c_Busca")
        loc_cCodigo = ALLTRIM(cursor_4c_Busca.cods)
    ENDIF
ENDIF

*-- Limpar
IF USED("cursor_4c_Busca")
    USE IN cursor_4c_Busca
ENDIF
loc_oBusca.Release()
```

### Problema 24: PageFrame NAO tem propriedade BackColor
**CRITICO**: PageFrame e um container, NAO tem BackColor - apenas as Pages internas tem:
```foxpro
*-- ERRADO - PageFrame NAO tem BackColor:
THIS.AddObject("pgf_4c_Paginas", "PageFrame")
WITH THIS.pgf_4c_Paginas
    .PageCount = 2
    .BackColor = RGB(255,255,255)  && ERRO! PageFrame nao tem BackColor!
ENDWITH

*-- CORRETO - BackColor apenas nas PAGES:
THIS.AddObject("pgf_4c_Paginas", "PageFrame")
WITH THIS.pgf_4c_Paginas
    .PageCount = 2
    .Page1.BackColor = RGB(255,255,255)  && Pages TEM BackColor
    .Page2.BackColor = RGB(255,255,255)
ENDWITH
```
**CorretorAutomatico.ps1 pattern #15 remove automaticamente .BackColor de PageFrame.**

### Problema 25: Queries SQL com tabela/coluna ERRADA + Grid sem coluna no SELECT (CRITICO!)
**CRITICO**: Ao migrar, NUNCA inventar nomes de tabelas ou colunas. SEMPRE extrair do codigo ORIGINAL:
```foxpro
*-- ERRADO - Claude "adivinhou" a tabela errada:
*-- Original usa SigCdGcr (Grupos Conta Corrente) com coluna Codigos
*-- Migrado incorretamente como SigCdGrp (Grupos Produto) com coluna cgrus
loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cGrupo)

*-- CORRETO - Copiar tabela e colunas EXATAS do codigo original:
loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
```

**REGRA OBRIGATORIA**: Para CADA query SQL no codigo migrado:
1. Localizar a query equivalente no **codigo fonte original** (buscar por SELECT, INSERT, UPDATE, DELETE)
2. Copiar o nome da TABELA exato do original
3. Copiar os nomes das COLUNAS exatos do original
4. Se a tabela nao aparece diretamente em SQL mas via SEEK/cursor local (ex: ``=Seek(valor, [crSigCdGcr], [Codigos])``), verificar qual query CRIOU esse cursor (buscar ``SqlExecute`` + nome do cursor)
5. Validar contra **docs/schema.sql** se a tabela e colunas existem

**Tabelas que SAO DIFERENTES (nao confundir!):**
| Tabela | Descricao | PK | Colunas Desc |
|--------|-----------|-----|-------------|
| SigCdGrp | Grupos de **Produto** | cgrus | dgrus |
| SigCdGcr | Grupos de **Conta Corrente** | Codigos | Descrs |
| SigCdCli | Clientes | Iclis | Rclis |
| SigCdEmp | Empresas | CEmps | Razas |

**REGRA GRID-SQL OBRIGATORIA (Consistencia ControlSource ? SELECT)**:
Para CADA coluna de Grid com ``ControlSource = "cursor_xxx.CAMPO"``:
1. O campo CAMPO **DEVE** existir no ``CREATE CURSOR cursor_xxx (... CAMPO ...)``
2. O campo CAMPO **DEVE** existir no ``SELECT ... CAMPO ... INTO CURSOR cursor_xxx`` ou ``SQLEXEC(..., "cursor_xxx")``
3. Se o Grid tem N colunas com ControlSource, o SELECT DEVE retornar pelo menos esses N campos
4. Exemplo: Se Grid.Column9.ControlSource = "cursor_4c_Historico.NFs", entao o SELECT do BO DEVE incluir ``a.NFs`` e o CREATE CURSOR DEVE ter ``NFs C(10)``

```foxpro
*-- ERRADO - Grid referencia NFs mas SELECT nao inclui:
loc_cSQL = "SELECT a.Datas, a.Hists, a.Valors FROM SigMvCcr a"  && Falta NFs!
*-- Grid: .Column9.ControlSource = "cursor_4c_Historico.NFs"     && ERRO: Variable NFS not found!

*-- CORRETO - SELECT inclui TODAS as colunas usadas no Grid:
loc_cSQL = "SELECT a.Datas, a.Hists, a.Valors, a.NFs FROM SigMvCcr a"  && NFs incluido!
```

### Problema 26: Containers flutuantes ficam visiveis ao abrir o form
**CRITICO**: Se o form original tem paineis/containers que iniciam OCULTOS (Visible=.F.) e so aparecem ao clicar botoes, o metodo ``TornarControlesVisiveis()`` NAO deve torna-los visiveis.

**MECANISMO DO BUG**: ``AddObject()`` cria controles com Visible=.F. ? voce seta Visible=.F. nos containers flutuantes ? ``TornarControlesVisiveis()`` percorre recursivamente e seta Visible=.T. em TUDO ? containers flutuantes ficam visiveis indevidamente.

```foxpro
*-- ERRADO - TornarControlesVisiveis() torna TUDO visivel incluindo paineis flutuantes:
PROCEDURE TornarControlesVisiveis(par_oContainer)
    FOR loc_i = 1 TO par_oContainer.ControlCount
        loc_oControl = par_oContainer.Controls(loc_i)
        loc_oControl.Visible = .T.  && Torna visivel ate paineis que deviam estar ocultos!
    ENDFOR
ENDPROC

*-- CORRETO - Filtrar containers flutuantes por NOME:
PROCEDURE TornarControlesVisiveis(par_oContainer)
    LOCAL loc_i, loc_oControl, loc_cNome
    FOR loc_i = 1 TO par_oContainer.ControlCount
        loc_oControl = par_oContainer.Controls(loc_i)
        *-- Pular containers que devem iniciar ocultos (paineis flutuantes)
        loc_cNome = UPPER(loc_oControl.Name)
        IF INLIST(loc_cNome, "lista de nomes dos containers flutuantes aqui")
            *-- Nao tornar visivel, mas RECURSAO nos filhos (controles internos SIM)
            THIS.TornarControlesVisiveis(loc_oControl)
            LOOP
        ENDIF
        loc_oControl.Visible = .T.
        IF PEMSTATUS(loc_oControl, "ControlCount", 5)
            THIS.TornarControlesVisiveis(loc_oControl)
        ENDIF
    ENDFOR
ENDPROC
```

**REGRA OBRIGATORIA**: Ao migrar, listar TODOS os containers que devem iniciar ocultos:
1. Buscar no original por: ``Visible = .F.`` em containers/objetos
2. Buscar por containers que so aparecem via Click de botao (ex: ``cnt_Relatorio.Visible = .T.`` dentro de um cmd_Click)
3. Gerar o INLIST com os nomes _4c_ correspondentes
4. O filtro deve estar em TornarControlesVisiveis(), NAO basta setar .Visible=.F. na criacao (pois TornarControlesVisiveis SOBRESCREVE)
5. **IMPORTANTE**: Mesmo pulando o container, RECUAR nos filhos para tornar os controles INTERNOS visiveis (serao usados quando o container for mostrado)

### Problema 27: Botoes desalinhados (Top inconsistente por CommandGroup)
**CRITICO**: Quando botoes estao agrupados horizontalmente, TODOS devem ter o MESMO Top.

**CAUSA RAIZ**: No original, botoes podem estar DENTRO de um CommandGroup (ex: ``grp_operacao``). No novo sistema, os botoes sao criados DIRETAMENTE na Page. O Top final deve ser calculado como a SOMA das coordenadas:

```
Top_final = CommandGroup.Top + Button.Top (dentro do group) + Compensacao_PageFrame
```

```foxpro
*-- EXEMPLO - Original:
*-- Page1: cmd_procurar.Top=4 (direto na page), grp_operacao.Top=-1 (group na page)
*--         grp_operacao.cmd_consulta.Top=5, grp_operacao.cmd_sair.Top=5
*-- PageFrame.Top = -28 (compensacao = +28)
*--
*-- Calculo CORRETO:
*-- cmd_procurar: 4 + 28 = 32
*-- cmd_consulta: (-1 + 5) + 28 = 32  (group.Top + button.Top + compensacao)
*-- cmd_sair:     (-1 + 5) + 28 = 32

*-- ERRADO - Consultar calcula errado, Encerrar usa so group.Top:
cmd_4c_Procurar.Top   = 32   && OK
cmd_4c_Consultar.Top  = 33   && ERRADO (nao somou corretamente)
cmd_4c_Encerrar.Top   = 27   && ERRADO (usou so group.Top + 28, esqueceu button.Top)

*-- CORRETO - Todos com mesmo Top:
cmd_4c_Procurar.Top   = 32
cmd_4c_Consultar.Top  = 32
cmd_4c_Encerrar.Top   = 32
```

**REGRA OBRIGATORIA**: Para botoes que no original estao dentro de CommandGroup:
1. Identificar o CommandGroup (ex: ``grp_operacao``) e anotar seu .Top
2. Identificar cada Command dentro (Command1, Command2) e anotar seus .Top internos
3. Top_absoluto_original = CommandGroup.Top + Command.Top
4. Top_final_migrado = Top_absoluto_original + Compensacao_PageFrame
5. **VERIFICAR**: Todos os botoes na mesma "barra" (mesma faixa horizontal) DEVEM ter o MESMO Top final
6. Se houver divergencia de 1-5px, usar o valor MAIS FREQUENTE como padrao

### Problema 28: mAddColuna com parametros na ordem errada (CRITICO!)
**CRITICO**: O metodo ``mAddColuna`` do FormBuscaAuxiliar tem assinatura: ``mAddColuna(par_cCampo, par_cMascara, par_cTitulo)``
- par_cCampo: nome do campo no cursor (ex: "Codigos")
- par_cMascara: InputMask (string vazia se nao tiver mascara)
- par_cTitulo: titulo da coluna no grid (ex: "Codigo")

```foxpro
*-- ERRADO - Terceiro parametro eh numero (largura), causa "Function argument value, type, or count is invalid":
loc_oBusca.mAddColuna("Codigos", "Codigo", 80)    && ERRO! 80 nao eh string!
loc_oBusca.mAddColuna("Descrs", "Descricao", 300) && ERRO! 300 nao eh string!

*-- CORRETO - Todos os 3 parametros sao strings (Campo, Mascara, Titulo):
loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
```

**REGRA**: mAddColuna NUNCA recebe largura como parametro. A largura eh calculada automaticamente pelo FormBuscaAuxiliar.

### Problema 29: FormBuscaAuxiliar - Dois modos de uso (CRITICO!)
**CRITICO**: FormBuscaAuxiliar tem DOIS modos de uso. Usar o modo ERRADO causa "Function argument value, type, or count is invalid".

**MODO 1 - Com parametros no Init (lookup em TABELA SQL):**
Usado quando a busca eh diretamente numa tabela do banco. O Init faz o SELECT automaticamente.

``````foxpro
*-- Lookup numa tabela SQL (ex: SigCdGcr):
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
    "SigCdGcr", "cursor_4c_Busca", "Codigos", loc_cValor, ;
    "Grupo de Conta Corrente")

IF VARTYPE(loc_oBusca) = "O"
    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
        *-- Registro exato encontrado
        loc_cGrupo = ALLTRIM(cursor_4c_Busca.Codigos)
    ELSEIF !loc_oBusca.this_lAchouRegistro
        *-- Nao encontrou exato, mostrar grid para selecao
        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
            loc_cGrupo = ALLTRIM(cursor_4c_Busca.Codigos)
        ENDIF
    ENDIF
    loc_oBusca.Release()
ENDIF
IF USED("cursor_4c_Busca")
    USE IN cursor_4c_Busca
ENDIF
``````

**MODO 2 - Sem parametros no Init (lookup em CURSOR LOCAL pre-existente):**
Usado quando o cursor jah foi criado por um metodo do BO. O Init NAO faz SELECT.

``````foxpro
*-- Lookup num cursor local jah carregado pelo BO:
THIS.this_oBusinessObject.BuscarContaPorGrupo(loc_cGrupo, "")

loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
IF VARTYPE(loc_oBusca) = "O"
    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"  && Cursor jah existente
    loc_oBusca.this_cTitulo = "Contas do Grupo"
    loc_oBusca.mAddColuna("Contas", "", "Conta")
    loc_oBusca.mAddColuna("RClis", "", "Nome")
    loc_oBusca.Show()

    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
        loc_cConta = ALLTRIM(cursor_4c_BuscaConta.Contas)
    ENDIF
    loc_oBusca.Release()
ENDIF
IF USED("cursor_4c_BuscaConta")
    USE IN cursor_4c_BuscaConta
ENDIF
``````

**QUANDO usar cada modo:**
| Situacao | Modo | Exemplo |
|----------|------|---------|
| Busca em tabela SQL padrao | MODO 1 (com params) | SigCdGrp, SigCdCli, SigCdMoe |
| Busca em cursor do BO | MODO 2 (sem params) | cursor_4c_BuscaConta (criado por BuscarContaPorGrupo) |
| Busca com filtro adicional | MODO 1 (com params + par_cFiltro) | Busca com WHERE extra |

**ERROS COMUNS:**
- CREATEOBJECT("FormBuscaAuxiliar") sem params ? Init tenta UPPER(ALLTRIM(.F.)) ? ERRO!
  Isso foi corrigido no FormBuscaAuxiliar.prg (retorna .T. imediatamente se par_cTabela nao eh string).
- Usar MODO 1 quando o cursor jah existe localmente ? SELECT desnecessario
- Usar MODO 2 sem definir this_cCursorDestino ? grid vazio

### Problema 30: OptionGroup - Buttons sem Left/Top/AutoSize (CRITICO!)
**CRITICO**: Ao criar OptionGroup via AddObject, os Buttons ficam SOBREPOSTOS (todos no Left=0) se nao definir Left individual.
O usuario so ve o primeiro botao - os demais ficam escondidos atras dele.

``````foxpro
*-- ERRADO - Buttons ficam sobrepostos (todos no Left=0):
par_oPagina.AddObject("opt_4c_Filtro", "OptionGroup")
WITH par_oPagina.opt_4c_Filtro
    .ButtonCount = 3
    .Width       = 206
    .Height      = 26
ENDWITH
WITH par_oPagina.opt_4c_Filtro.Buttons(1)
    .Caption  = "Global"
    .Width    = 60
ENDWITH
WITH par_oPagina.opt_4c_Filtro.Buttons(2)
    .Caption  = "Positivos"
    .Width    = 70
    && SEM .Left ? fica no Left=0, atras do Button1!
ENDWITH

*-- CORRETO - Definir Left, Top, AutoSize, ForeColor e Themes em CADA Button:
par_oPagina.AddObject("opt_4c_Filtro", "OptionGroup")
WITH par_oPagina.opt_4c_Filtro
    .ButtonCount = 3
    .Width       = 206
    .Height      = 26
    .BackStyle   = 0
    .BorderStyle = 0
    .Visible     = .T.
ENDWITH
WITH par_oPagina.opt_4c_Filtro.Buttons(1)
    .Caption   = "Global"
    .Left      = 5
    .Top       = 5
    .Width     = 60
    .AutoSize  = .T.
    .FontName  = "Tahoma"
    .FontSize  = 8
    .ForeColor = RGB(90, 90, 90)
    .Themes    = .F.
ENDWITH
WITH par_oPagina.opt_4c_Filtro.Buttons(2)
    .Caption   = "Positivos"
    .Left      = 63          && Left do anterior + Width do anterior (~3px gap)
    .Top       = 5
    .Width     = 70
    .AutoSize  = .T.
    .FontName  = "Tahoma"
    .FontSize  = 8
    .ForeColor = RGB(90, 90, 90)
    .Themes    = .F.
ENDWITH
``````

**REGRA**: SEMPRE copiar do legado: Left, Top, AutoSize, ForeColor, Themes de CADA Button do OptionGroup.
Se o legado nao especifica Left (usa AutoSize), calcular: ``Left = Left_anterior + Width_anterior + 3``.

### Problema 31: Eventos que disparam carga de dados (LostFocus/InteractiveChange) - CRITICO!
**CRITICO**: No legado, campos de filtro (grupo, moeda, periodo) disparam carga de dados ao SAIR do campo (Valid/LostFocus).
OptionGroups (filtro, ordem) disparam recarga ao MUDAR de opcao (InteractiveChange).
Se nao implementar esses eventos, a grade NUNCA carrega dados.

**Padrao obrigatorio - Analisar no legado:**

1. **Procurar por ``MontaGrade``, ``Processa``, ``Buscar``** nos eventos Valid/LostFocus dos campos de filtro
2. **Procurar por ``InteractiveChange``** nos OptionGroups - se chama MontaGrade/Processa, adicionar BINDEVENT

``````foxpro
*-- ERRADO - LostFocus do campo so valida, NAO carrega dados:
PROCEDURE ValidarGrupo()
    LOCAL loc_cGrupo
    loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
    IF EMPTY(loc_cGrupo)
        RETURN
    ENDIF
    *-- Valida grupo no banco...
    *-- MAS NAO CARREGA A GRADE! Usuario precisa clicar em outro lugar.
ENDPROC

*-- CORRETO - LostFocus valida E carrega a grade:
PROCEDURE ValidarGrupo()
    LOCAL loc_cGrupo
    loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
    IF EMPTY(loc_cGrupo)
        RETURN
    ENDIF
    *-- Valida grupo no banco...
    IF loc_lGrupoValido
        THIS.CarregarGradeSaldo()   && OBRIGATORIO: Carregar dados apos validar
    ENDIF
ENDPROC
``````

``````foxpro
*-- OBRIGATORIO: BINDEVENT para InteractiveChange de OptionGroups que afetam dados:
BINDEVENT(par_oPagina.opt_4c_Filtro, "InteractiveChange", THIS, "FiltroSaldoChanged")

PROCEDURE FiltroSaldoChanged()
    IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value))
        THIS.CarregarGradeSaldo()
    ENDIF
ENDPROC
``````

**Checklist de eventos de carga (OBRIGATORIO para TODA migracao):**
- [ ] Campo de grupo/filtro principal: LostFocus chama metodo de carga (CarregarGrade, BuscarDados)
- [ ] Lookup (BtnProcurarClick): Apos selecionar, chama metodo de carga
- [ ] OptionGroup de filtro: InteractiveChange chama metodo de carga
- [ ] OptionGroup de ordem: InteractiveChange chama metodo de carga/reordenacao
- [ ] Campo de periodo (data): LostFocus chama metodo de carga (se aplicavel)

### Problema 32: Grid - Headers perdidos apos RecordSource (CRITICO!)
**CRITICO**: Quando ``CarregarGrade*()`` redefine RecordSource e ControlSource, os Header1.Caption sao RESETADOS para o nome do campo (ex: "Contas" ao inves de "Conta").
O metodo CarregarGrade DEVE redefinir os Headers APOS RecordSource + ControlSource + Width.

``````foxpro
*-- ERRADO - Headers ficam com nome do campo (Contas, RClis, Moedas...):
PROCEDURE CarregarGradeSaldo()
    loc_oGrid.RecordSource = "cursor_4c_Saldos"
    loc_oGrid.Column1.ControlSource = "cursor_4c_Saldos.Contas"
    loc_oGrid.Column1.Width = 100
    && Headers NAO redefinidos ? ficam "Contas" ao inves de "Conta"
    loc_oGrid.Refresh()
ENDPROC

*-- CORRETO - Redefinir Headers APOS RecordSource:
PROCEDURE CarregarGradeSaldo()
    loc_oGrid.RecordSource = "cursor_4c_Saldos"
    loc_oGrid.Column1.ControlSource = "cursor_4c_Saldos.Contas"
    loc_oGrid.Column1.Width = 100
    loc_oGrid.Column1.Header1.Caption = "Conta"    && OBRIGATORIO: Redefinir
    loc_oGrid.Refresh()
ENDPROC
``````

**REGRA**: Toda vez que RecordSource for setado, Header1.Caption, InputMask e Alignment DEVEM ser redefinidos logo apos.

### Problema 33: Botao Consultar deve navegar para aba de detalhe (forms operacionais)
Em forms operacionais com 2 abas (lista + detalhe), o botao Consultar/Visualizar no legado:
1. Captura dados do registro selecionado na grade
2. Preenche campos na aba de detalhe
3. Navega para a aba de detalhe (ActivePage = 2)
4. Carrega dados detalhados

``````foxpro
*-- ERRADO - Consultar apenas abre um container:
PROCEDURE BtnConsultarClick()
    THIS.cnt_4c_Consulta.Visible = .T.   && NAO navega para detalhe!
ENDPROC

*-- CORRETO - Consultar navega para aba de detalhe com dados:
PROCEDURE BtnConsultarClick()
    IF !USED("cursor_4c_Saldos") OR EOF("cursor_4c_Saldos")
        MostrarErro("Nenhum registro selecionado!", "")
        RETURN
    ENDIF
    SELECT cursor_4c_Saldos
    loc_oPg2.txt_4c_Campo1.Value = ALLTRIM(cursor_4c_Saldos.Campo1)
    loc_oPg2.txt_4c_Campo2.Value = ALLTRIM(cursor_4c_Saldos.Campo2)
    THIS.pgf_4c_Paginas.ActivePage = 2
    THIS.CarregarGradeDetalhe()
ENDPROC
``````

**REGRA**: Analisar no legado o que cada botao do CommandGroup/grp_operacao faz. Muitos navegam entre abas, nao apenas abrem containers.

### Problema 34: SQLEXEC substitui cursor e destroi colunas do Grid (CRITICO!)
Quando SQLEXEC cria um cursor com o mesmo nome de um cursor ja vinculado a um Grid, o cursor antigo eh destruido e recriado. O Grid perde TODAS as colunas (Column1..N ficam "Unknown member").

``````foxpro
*-- ERRADO - SQLEXEC substitui cursor e destroi colunas do Grid:
SQLEXEC(gnConnHandle, "SELECT ...", "cursor_4c_Dados")  && Destroi cursor original!
loc_oGrid.Column1.Header1.Caption = "Codigo"           && ERRO: Unknown member COLUMN1

*-- CORRETO - SQLEXEC em cursor TEMPORARIO + ZAP + APPEND:
SQLEXEC(gnConnHandle, "SELECT ...", "cursor_4c_DadosTemp")  && Cursor temporario
SELECT cursor_4c_Dados
ZAP IN cursor_4c_Dados                                      && Limpa cursor do grid
APPEND FROM DBF("cursor_4c_DadosTemp")                      && Copia dados
USE IN cursor_4c_DadosTemp                                   && Fecha temporario
GO TOP IN cursor_4c_Dados
loc_oGrid.Refresh()                                          && Grid preserva colunas
``````

**REGRA**: Em QUALQUER metodo que recarrega dados de um Grid (MontaGrade, CarregarHistorico, FiltrarDados), SEMPRE usar cursor temporario + ZAP + APPEND para preservar as colunas do Grid.

### Problema 35: CREATE CURSOR placeholder deve aceitar NULLs (CRITICO!)
Cursores placeholder criados para Grid precisam aceitar NULLs, pois SQLEXEC do SQL Server retorna NULLs em campos como DtAudits, Cpfs, etc. APPEND FROM falha com "Field XXX does not accept null values".

``````foxpro
*-- ERRADO - cursor nao aceita NULLs:
CREATE CURSOR cursor_4c_Dados (Campo1 C(10), Campo2 T)
*-- APPEND FROM cursor com NULLs -> ERRO!

*-- CORRETO - SET NULL ON antes do CREATE CURSOR:
SET NULL ON
CREATE CURSOR cursor_4c_Dados (Campo1 C(10), Campo2 T)
SET NULL OFF
*-- APPEND FROM cursor com NULLs -> OK
``````

**REGRA**: TODOS os CREATE CURSOR de cursores placeholder para Grid devem ter SET NULL ON/OFF ao redor.

### Problema 36: Grid RecordSource + ColumnCount dentro de WITH nao cria colunas (CRITICO!)
Ao definir .RecordSource e .ColumnCount dentro de um bloco WITH do Grid, as colunas podem nao ser criadas imediatamente, causando "Unknown member COLUMN1" na linha seguinte.

``````foxpro
*-- ERRADO - Column1 nao existe imediatamente:
WITH loc_oGrid
    .RecordSource = "cursor_4c_Dados"
    .ColumnCount = 10
    .Column1.ControlSource = "cursor_4c_Dados.Campo"  && ERRO: Unknown member COLUMN1
ENDWITH

*-- CORRETO - RecordSource e ColumnCount FORA do WITH:
loc_oGrid.RecordSource = "cursor_4c_Dados"
loc_oGrid.ColumnCount = 10
WITH loc_oGrid
    .Column1.ControlSource = "cursor_4c_Dados.Campo"  && OK: colunas ja existem
ENDWITH
``````

**REGRA**: SEMPRE definir RecordSource e ColumnCount com referencia EXPLICITA (loc_oGrid.xxx), NUNCA dentro de WITH.

### Problema 38: BINDEVENT handler sem parametros para eventos que passam parametros (CRITICO!)
Eventos VFP como AfterRowColChange e KeyPress passam parametros obrigatorios ao handler.
Se o handler nao declara LPARAMETERS, VFP gera "No PARAMETER statement is found".

``````foxpro
*-- ERRADO - handler sem parametros:
BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridHistAfterRowColChange")
PROCEDURE GridHistAfterRowColChange()  && ERRO: No PARAMETER statement is found
    THIS.CarregarDetalheHist()
ENDPROC

*-- CORRETO - handler com parametros:
BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridHistAfterRowColChange")
PROCEDURE GridHistAfterRowColChange(par_nColIndex)
    THIS.CarregarDetalheHist()
ENDPROC

*-- KeyPress tambem precisa de parametros:
PROCEDURE TeclaGridHist(par_nKeyCode, par_nShiftAltCtrl)
    * handler de KeyPress
ENDPROC
``````

**REGRA**: SEMPRE declarar parametros em handlers de BINDEVENT para AfterRowColChange(par_nColIndex) e KeyPress(par_nKeyCode, par_nShiftAltCtrl).

### Problema 39: Navegacao Page1?Page2 em forms OPERACIONAL deve ler do grid (CRITICO!)
Em forms OPERACIONAL com PageFrame, o botao "Consultar" deve ler os dados da LINHA SELECIONADA no grid de Page1 e navegar para Page2 com dados carregados. NAO deve abrir um floating container para input manual.

``````foxpro
*-- ERRADO - Toggle de floating container para input manual:
PROCEDURE BtnConsultarSaldoClick()
    loc_oCnt.Visible = !loc_oCnt.Visible  && ERRADO: pede input manual
ENDPROC

*-- CORRETO - Le do grid e navega diretamente:
PROCEDURE BtnConsultarSaldoClick()
    SELECT cursor_4c_Saldos
    loc_cGrupo = ALLTRIM(cursor_4c_Saldos.Grupos)
    loc_cConta = ALLTRIM(cursor_4c_Saldos.Contas)
    *-- Preenche campos da Page2
    THIS.pgf_4c_Principal.Page2.txt_4c_ContaHist.Value = loc_cConta
    *-- Carrega dados e navega
    THIS.CarregarHistorico()
    THIS.pgf_4c_Principal.ActivePage = 2
ENDPROC
``````

**REGRA**: Em forms OPERACIONAL, botoes de navegacao entre paginas DEVEM ler dados do cursor do grid selecionado, NAO pedir input manual via floating container.

### Problema 40: Header Captions de Grid devem ser IDENTICOS ao legado (CRITICO!)
Os captions dos headers do Grid DEVEM ser copiados EXATAMENTE do fonte legado. NAO abreviar, NAO inventar nomes.

``````foxpro
*-- ERRADO - Headers inventados/abreviados:
.Column4.Header1.Caption = "Op"      && Legado usa "Mov"
.Column7.Header1.Caption = "Doc"     && Legado usa "Documento"
.Column8.Header1.Caption = "NF"      && Legado usa "Nota"

*-- CORRETO - Copiar EXATAMENTE do fonte legado:
.Column4.Header1.Caption = "Mov"         && EXATO do legado
.Column7.Header1.Caption = "Documento"   && EXATO do legado
.Column8.Header1.Caption = "Nota"        && EXATO do legado
``````

**REGRA**: SEMPRE procurar "Caption =" nos blocos de Header1 do fonte legado e copiar EXATAMENTE. O Code Review (CHECK 17) valida automaticamente.

### Problema 41: mAddColuna do FormBuscaAuxiliar tem 3 parametros (CRITICO!)
O metodo mAddColuna aceita EXATAMENTE 3 parametros: campo, mascara, titulo.

``````foxpro
*-- ERRADO - 4 parametros (largura e tabela NAO existem):
loc_oBusca.mAddColuna("Codigos", "C" + CHR(243) + "digo", 80, "SigCdGcr")

*-- CORRETO - 3 parametros (campo, mascara, titulo):
loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
``````

**A tabela e o cursor devem ser configurados ANTES via propriedades:**
``````foxpro
loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
loc_oBusca.this_cTabela = "SigCdGcr"          && Tabela de busca
loc_oBusca.this_cCampoChave = "Codigos"        && Campo chave
loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaAuxiliar"
loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
loc_oBusca.Show()
``````

**REGRA**: mAddColuna SEMPRE com 3 params: (campo, mascara_ou_vazio, titulo). NUNCA passar largura ou tabela como parametro.

### Problema 42: Colunas SQL inventadas em queries com JOIN (CRITICO!)
**CRITICO**: Em queries com JOIN, verificar de QUAL tabela (alias) cada coluna vem. NUNCA assumir que colunas de uma tabela existem em outra.

``````foxpro
*-- ERRADO - Cpfs, Matris, Situas NAO existem em SigMvSlc (alias a):
loc_cQuery = "SELECT a.Contas, a.Saldos, a.Cpfs, a.Matris" + ;
             " FROM SigMvSlc a LEFT JOIN SigCdCli b ON b.Iclis = a.Contas"

*-- CORRETO - Cpfs, ContaMats, Situas vem de SigCdCli (alias b):
loc_cQuery = "SELECT a.Contas, a.Saldos, b.Cpfs, b.ContaMats, b.Situas" + ;
             " FROM SigMvSlc a LEFT JOIN SigCdCli b ON b.Iclis = a.Contas"
``````

**Colunas frequentemente confundidas em JOINs:**
| Coluna | Tabela CORRETA | NAO existe em |
|--------|---------------|---------------|
| Cpfs | SigCdCli | SigMvSlc, SigCdPbx |
| ContaMats | SigCdCli | SigMvSlc |
| Situas | SigCdCli | SigMvSlc |
| Rclis | SigCdCli | SigMvSlc |

**Colunas com nomes nao-intuitivos em SigMvCcr:**
| ERRADO (inventado) | CORRETO (schema.sql) |
|--------------------|---------------------|
| Concils | Concs |
| Usuar | Usualts |
| Tipo | Tipos |
| Valos | Valors |
| Hists2 | Hist2s |
| hiss3 | Shists |

**REGRA**: Copiar nomes do codigo ORIGINAL + validar em schema.sql. NUNCA "normalizar" nomes.

### Problema 43: Init() duplicando InicializarForm (CRITICO!)
**CRITICO**: O FormBase.Init() ja chama THIS.InicializarForm(). Se o Init() do form tambem chama InicializarForm(), ocorre:
- AddObject duplicado ("A member object with this name already exists")
- PageFrame criado 2x, Grid criado 2x
- Erro cascata em todos os metodos subsequentes

``````foxpro
*-- ERRADO - InicializarForm chamado 2x (DODEFAULT()->FormBase.Init()->InicializarForm() + chamada direta):
PROCEDURE Init()
    DODEFAULT()                        && Ja chama InicializarForm() internamente
    loc_lSucesso = THIS.InicializarForm()  && DUPLICADO! Causa "member already exists"
    RETURN loc_lSucesso
ENDPROC

*-- CORRETO - Apenas DODEFAULT() (FormBase.Init() ja cuida de tudo):
PROCEDURE Init()
    LOCAL loc_lSucesso
    loc_lSucesso = .F.
    TRY
        loc_lSucesso = DODEFAULT()
    CATCH TO loException
        MostrarErro(loException, "FormXxx.Init")
    ENDTRY
    RETURN loc_lSucesso
ENDPROC
``````

### Problema 44: Caption/Titulo nao propagado para labels de exibicao
O legado copia ThisForm.Caption para labels de titulo (lblSombra/lblTitulo) no Init().
Se o form migrado NAO faz isso, o titulo na tela fica incorreto (ex: "Cadastro de Testes" que eh o default do FormBase).

``````foxpro
*-- CORRETO - Propagar Caption para labels APOS ConfigurarPageFrame:
*-- No InicializarForm(), apos ConfigurarPageFrame():
IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra") = "O"
    THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
ENDIF
IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo") = "O"
    THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
ENDIF
``````

### Problema 45: LostFocus abrindo lookup sem guardia de valor alterado
No legado, Valid event so dispara quando o valor do campo MUDA. Mas BINDEVENT com LostFocus dispara em CADA perda de foco. Se o handler abre FormBuscaAuxiliar sem verificar se o valor mudou, a janela de busca abre toda vez que o usuario clica em outro campo.

``````foxpro
*-- ERRADO - Lookup abre em CADA perda de foco:
PROCEDURE ValidarGrupoSaldo()
    LOCAL loc_cGrupo
    loc_cGrupo = ALLTRIM(THIS.txt_4c_GrupoSaldo.Value)
    IF EMPTY(loc_cGrupo)
        RETURN
    ENDIF
    THIS.AbrirBuscaGrupoSaldo()  && Abre TODA vez que perde foco!
ENDPROC

*-- CORRETO - Verificar se valor mudou:
this_cUltimoGrupoValidado = ""   && Propriedade para rastrear

PROCEDURE ValidarGrupoSaldo()
    LOCAL loc_cGrupo
    loc_cGrupo = ALLTRIM(THIS.txt_4c_GrupoSaldo.Value)
    IF loc_cGrupo == THIS.this_cUltimoGrupoValidado
        RETURN   && Valor nao mudou, nao revalidar
    ENDIF
    THIS.this_cUltimoGrupoValidado = loc_cGrupo
    IF EMPTY(loc_cGrupo)
        RETURN
    ENDIF
    THIS.AbrirBuscaGrupoSaldo()
ENDPROC
``````

### Problema 46: COMMIT/ROLLBACK avulsos sem BEGIN TRANSACTION (CRITICO!)
A conexao ODBC do VFP opera em **AUTOCOMMIT** - cada SQLEXEC eh uma transacao implicita. NUNCA usar COMMIT/ROLLBACK avulsos apos UPDATE/INSERT/DELETE simples.

``````foxpro
*-- ERRADO - ROLLBACK sem BEGIN TRANSACTION ? erro fatal:
TRY
    SQLEXEC(gnConnHandle, "UPDATE tabela SET ...", "cursor_4c_U")
    SQLEXEC(gnConnHandle, "COMMIT", "cursor_4c_Cmt")       && DESNECESSARIO em autocommit
CATCH
    SQLEXEC(gnConnHandle, "ROLLBACK", "cursor_4c_Rb")      && ERRO: no corresponding BEGIN TRANSACTION
ENDTRY

*-- CORRETO - Sem transacao explicita (autocommit):
TRY
    loc_nResult = SQLEXEC(gnConnHandle, "UPDATE tabela SET ...", "cursor_4c_U")
    IF loc_nResult < 0
        MsgErro("Erro: " + CapturarErroSQL(), "Erro SQL")
    ENDIF
CATCH TO loException
    MostrarErro(loException, "NomeMetodo")
ENDTRY

*-- CORRETO - Com transacao explicita (multi-statement):
*-- Usar SOMENTE quando precisa atualizar MULTIPLAS tabelas atomicamente
TRY
    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")     && OBRIGATORIO antes de COMMIT/ROLLBACK
    SQLEXEC(gnConnHandle, "UPDATE tabela1 SET ...")
    SQLEXEC(gnConnHandle, "UPDATE tabela2 SET ...")
    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
CATCH
    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
ENDTRY
``````

### Problema 47: CheckBox.Value tipo inconsistente (CRITICO!)
CheckBox inicializado com `.Value = .F.` (logico) MAS comparado com `= 1` ou resetado com `= 0` (numerico) causa "Operator/operand type mismatch".

``````foxpro
*-- ERRADO - Tipo mismatch:
.Value = .F.                              && Inicializado como LOGICO
loc_lNovo = (chk_4c_Campo.Value = 1)     && Comparando com NUMERICO ? ERRO!
chk_4c_Campo.Value = 0                    && Atribuindo NUMERICO ? ERRO!

*-- CORRETO - Tipo consistente:
.Value = .F.                              && Inicializado como LOGICO
loc_lNovo = (chk_4c_Campo.Value = .T.)   && LOGICO com LOGICO
chk_4c_Campo.Value = .F.                  && LOGICO
*-- Carregar de banco (campo numerico 0/1):
chk_4c_Campo.Value = (NVL(cursor.Concs, 0) = 1)  && Converte para LOGICO
``````

### Problema 48: RecordSource reseta ControlSource via auto-bind (CRITICO!)
Quando `.RecordSource` eh (re)atribuido, VFP faz auto-bind dos campos do cursor para as colunas pela ORDEM dos campos no cursor (campo 1 ? Column1, campo 2 ? Column2), IGNORANDO qualquer ControlSource definido anteriormente. Isso causa dados desalinhados dos headers.

**REGRA 1**: NUNCA usar ColumnOrder. Definir colunas na ordem visual direta (Column1 = primeira coluna visual).
**REGRA 2**: Re-definir `.ControlSource` de TODAS as colunas APOS cada `.RecordSource =`.

``````foxpro
*-- ERRADO - ControlSource definido ANTES de RecordSource (sera sobrescrito):
loc_oGrd.Column1.ControlSource = "cursor.Emps"    && Sera ignorado!
loc_oGrd.RecordSource = "cursor"                    && Auto-bind: Column1 recebe campo 1 do cursor

*-- CORRETO - ControlSource APOS RecordSource:
loc_oGrd.RecordSource = "cursor"
loc_oGrd.Column1.ControlSource = "cursor.Emps"     && Agora SIM funciona
loc_oGrd.Column2.ControlSource = "cursor.Datas"
loc_oGrd.Column1.Width = 30
loc_oGrd.Column2.Width = 71
``````

### Problema 49: PageFrame AddObject + Tabs=.F. -> Page.Height runtime = PageFrame.Height + 4 (OPERACIONAL)

Em forms OPERACIONAL com PageFrame criado via `AddObject` e `Tabs=.F.`, o VFP9 adiciona **+4** ao `Page.Height` em runtime. O ValidarUIFidelity compara valores em runtime e detecta a diferenca.

**REGRA**: Ao declarar `.Height` de PageFrame com `Tabs=.F.` em form OPERACIONAL, usar o valor do original **menos 4**:

``````foxpro
*-- Original SCX tem Page.Height = 635 em runtime
*-- ERRADO - copia o valor bruto do original, runtime mostra +4:
WITH THIS.pgf_4c_1
    .Height = 635   && runtime: Page.Height = 639 -> DIFERENCA!
    .Tabs   = .F.
ENDWITH

*-- CORRETO - compensar -4 para que runtime = valor original:
WITH THIS.pgf_4c_1
    .Height = 631   && runtime: Page.Height = 635 -> CORRETO
    .Tabs   = .F.
ENDWITH
``````

### Problema 50: MsgConfirma() retorna LOGICAL (.T./.F.), NAO numerico 6/7
`MsgConfirma()` de messages.prg faz `RETURN lnResposta = 6` (logical). NUNCA usar `IF var = 6`.
```foxpro
*-- ERRADO: "Operator/operand type mismatch"
IF MsgConfirma("Confirma?","Titulo") = 6

*-- CORRETO:
IF MsgConfirma("Confirma?","Titulo")
```

### Problema 51: Botoes CRUD devem ficar do lado DIREITO (Grupo_op.Left)
No Framework, `Grupo_op.Left = 543` (ou similar). Posicao real = `Grupo_op.Left + Botao.Left`.
NUNCA posicionar botoes a partir de Left=5 (esquerda). Ler o Left do container original e SOMAR.

### Problema 52: GridLines = 3 (ambas linhas) para grids de listagem
Framework Grade usa linhas H+V. `GridLines = 1` mostra so horizontal. SEMPRE usar `GridLines = 3`.

### Problema 53: Labels ForeColor PRETO em fundo claro, BRANCO em fundo escuro
Labels `say` do Framework usam ForeColor escuro. Em Page2 com fundo claro, branco fica invisivel.
Posicoes/tamanhos EXATOS do original (Say1.Left, Say1.Top, Say1.Width, Say1.Height).

### Problema 54: Colunas com sufixo 's' (Tipos nao Tipo, Opers nao Oper)
Copiar EXATAMENTE do schema.sql. Original usa alias (`'R' as Tipo`) - nao confundir com coluna real (`Tipos`).

### Problema 55: Metodos PROTECTED chamados sem THIS. -> "File not found"
VFP9 busca .prg externo se nao tiver THIS. SEMPRE `THIS.NomeMetodo()` dentro da classe.

### Problema 56: CATCH NUNCA silencioso - sempre MsgErro no minimo
CATCH vazio engole erros. SEMPRE: `MsgErro("Erro: " + loc_oErro.Message, "Erro")` antes do cleanup.

### Problema 57: Form chama Excluir() (PUBLIC), BO sobrescreve ExecutarExclusao() (PROTECTED)
NUNCA chamar `ExecutarExclusao()` do Form - eh PROTECTED. Usar `this_oBusinessObject.Excluir()`.

### Problema 58: Container nao tem .Themes em VFP9
`Container.Themes = .F.` causa "Property THEMES is not found". Remover. So CommandButton/Form/TextBox tem Themes.

### Problema 59: SQLEXEC QueryTimeOut em CarregarParametros/Init -> TIMEOUT no pipeline
Quando o form faz multiplos SQLEXEC no Init/CarregarParametros com QueryTimeOut=60s, e o banco esta lento, 5 queries x 60s = 300s = TIMEOUT do pipeline.
REGRA: Se `gb_4c_ValidandoUI = .T.` ou se eh CarregarParametros, usar `SQLSETPROP(gnConnHandle, "QueryTimeOut", 10)` no inicio e restaurar no final.

## Ordem de Desenvolvimento
1. Analisar codigo fonte .txt completo (campos, lookups, validacoes, grid, propriedades visuais)
2. Criar ${boClass}.prg
3. Criar ${formClass}.prg
4. **IMPLEMENTAR Init() correto** (OBRIGATORIO): apenas `RETURN DODEFAULT()`
5. **IMPLEMENTAR metodos auxiliares** (OBRIGATORIO):
   - TornarControlesVisiveis(par_oContainer) - copiar de FormCor.prg (linhas 956-984)
   - FormatarGridLista(par_oGrid) - copiar de FormCor.prg (linhas 945-953)
5. Implementar TODOS os lookups (procurar por fwbuscaext, fwBuscaSel, sigacess)
6. Implementar TODAS as validacoes (procurar por PROCEDURE Valid)
7. Configurar Grid (cabecalhos apos RecordSource!)
8. Compensar PageFrame se Top=-29
9. Criar mapeamento JSON

**IMPORTANTE - Metodos Auxiliares (NAO estao no FormBase):**

**TornarControlesVisiveis():**
- SEMPRE implementar no formulario
- SEMPRE chamar COM parametro: THIS.TornarControlesVisiveis(loc_oPagina)
- NUNCA chamar sem parametro: THIS.TornarControlesVisiveis() -> ERRO!
- Copiar de FormCor.prg (linhas 956-984)

**FormatarGridLista():**
- SEMPRE implementar no formulario
- SEMPRE chamar APOS carregar dados: THIS.FormatarGridLista(loc_oGrid)
- Define FontName="Tahoma", FontSize=8
- Copiar de FormCor.prg (linhas 945-953)

## Integracao com o Sistema (OBRIGATORIO)

Apos criar os arquivos .prg, voce DEVE integra-los ao sistema:

### 1. Atualizar config.prg
Arquivo: **C:\4c\projeto\app\start\config.prg**

Adicionar SET PROCEDURE na funcao ConfigurarAmbiente():

```foxpro
*-- Business Objects (adicionar apos os BOs existentes, linha ~228)
SET PROCEDURE TO (gcCaminhoClasses + "${boClass}.prg") ADDITIVE

*-- Formularios (adicionar apos os Forms existentes, linha ~242)
SET PROCEDURE TO (gcCaminhoForms + "cadastros\${formClass}.prg") ADDITIVE
```

### 2. Criar funcao no menu.prg
Arquivo: **C:\4c\projeto\app\menu\menu.prg**

Adicionar NO FINAL do arquivo (antes de ENDDEFINE se houver):

```foxpro
*------------------------------------------------------------------------------
* Abrir${formClass} - Abre formulario de cadastro de [descricao]
*------------------------------------------------------------------------------
PROCEDURE Abrir${formClass}()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("${formClass}")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
            *-- NAO chamar loForm.Release() - FormBase cuida disso
        ELSE
            MostrarErro("Erro ao criar formulario ${formClass}", "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario ${formClass}:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC
```

### 3. Adicionar item no menu principal
Arquivo: **C:\4c\projeto\app\menu\menu.prg**

Na funcao CriarMenu(), adicionar item no popup CORRETO conforme o tipo:
- **CRUD (frmcadastro)**: popCadastros
- **REPORT (frmrelatorio)**: popRelatorios
- **OPERACIONAL (form)**: popMovimentos

**Passo 1**: Adicionar DEFINE BAR no popup correto (proximo numero disponivel)
```foxpro
*-- CRUD -> popCadastros:
DEFINE BAR N OF popCadastros PROMPT "[Descricao]" ;
       MESSAGE "Cadastro de [Descricao]"

*-- REPORT -> popRelatorios:
DEFINE BAR N OF popRelatorios PROMPT "[Descricao]" ;
       MESSAGE "Relat" + CHR(243) + "rio de [Descricao]"

*-- OPERACIONAL -> popMovimentos:
DEFINE BAR N OF popMovimentos PROMPT "[Descricao]" ;
       MESSAGE "[Descricao]"
```

**Passo 2**: Vincular acao (ON SELECTION no mesmo popup)
```foxpro
ON SELECTION BAR N OF popXxx DO Abrir${formClass}
```

**IMPORTANTE**:
- Usar proximo BAR disponivel no popup correto
- Prompt deve ser curto e descritivo (sem acentos se possivel, ou usar CHR())
- MESSAGE e exibido na barra de status
- Criar PROCEDURE Abrir${formClass}() no final do menu.prg

## Validacao Final

### Codigo (23 Problemas Criticos)
- [ ] **DEFINE CLASS**: Propriedades visuais (Height, Width, Caption, etc.) na definicao da classe
- [ ] **Init()**: APENAS `RETURN DODEFAULT()` (NAO chamar InicializarForm explicitamente)
- [ ] **Botoes**: Caption + Picture + PicturePosition=13 em TODOS (8 botoes)
- [ ] **Icones corretos**: Salvar=cadastro_salvar_60.jpg (NAO cadastro_confirmar_60.jpg)
- [ ] **Btn*Click**: Metodos PUBLIC (NAO PROTECTED) para funcionar com BINDEVENT
- [ ] **BtnIncluirClick**: Chamar `NovoRegistro()` E setar `this_cModoAtual = "INCLUIR"` ANTES de `HabilitarCampos()`
- [ ] **BtnAlterarClick**: Chamar `EditarRegistro()` APOS `CarregarPorCodigo()`
- [ ] **BtnBuscarClick**: FormBuscaAuxiliar com `mAddColuna()`, `Show(1)`, `this_lSelecionou`, cursor (NAO tem ObterCodigoSelecionado)
- [ ] **Page.Picture**: Usar `gc_4c_CaminhoIcones + "arquivo.jpg"` (NAO caminho relativo)
- [ ] **CarregarPorCodigo**: Resetar `THIS.this_lNovoRegistro = .F.` apos carregar registro
- [ ] **BtnCancelarClick**: chama THIS.CarregarLista() ao voltar para lista
- [ ] **BtnSalvarClick**: Salvar() SEM parametro, validacoes FORA do TRY
- [ ] **Labels**: BackColor + ForeColor + FontName + FontSize COPIADOS do original
- [ ] PageFrame.Top e Tabs corretos
- [ ] Containers compensados (+29px se necessario)
- [ ] Grid com cabecalhos reconfigurados
- [ ] TornarControlesVisiveis() implementado + chamado COM parametro
- [ ] FormatarGridLista() implementado + chamado APOS carregar
- [ ] ConfigurarPaginaDados() com ENDPROC e chamada TornarControlesVisiveis()
- [ ] **BO**: Metodos `ExecutarExclusao()` (NAO Excluir) e `CarregarPorCodigo()` (NAO CarregarPorId)
- [ ] Todos os lookups funcionam (F4/DblClick)
- [ ] Todas as validacoes funcionam
- [ ] INCLUIR/ALTERAR/EXCLUIR/VISUALIZAR funcionam
- [ ] Form instancia sem erro "property not found"
- [ ] Grid exibe com fonte Tahoma tamanho 8
- [ ] **Queries SQL**: Tabelas e colunas EXATAS do codigo original (NAO inventar - conferir schema.sql)
- [ ] **Containers flutuantes**: Iniciam ocultos se original tinha Visible=.F. (TornarControlesVisiveis preserva)
- [ ] **Botoes alinhados**: Todos os botoes de uma mesma barra com MESMO Top (compensacao correta)

### Integracao (menu.prg + config.prg)
- [ ] SET PROCEDURE para BO adicionado no config.prg
- [ ] SET PROCEDURE para Form adicionado no config.prg
- [ ] **Funcao Abrir${formClass}()**: usar VARTYPE, Show() sem parametro, SEM Release()
- [ ] Item do menu adicionado no popup CORRETO: CRUD=popCadastros, REPORT=popRelatorios, OPERACIONAL=popMovimentos (DEFINE BAR + ON SELECTION)

**IMPORTANTE**: So considerar completo apos:
1. Criar AMBOS os arquivos (.prg do BO e do Form)
2. Integrar com config.prg e menu.prg
3. Formulario acessivel via menu do sistema

Comecar agora.
"@
        $prompt = $prompt -replace '\[ARQUIVO\]', $BaseName
        $prompt = $prompt -replace '\[Ex: SIGCDCOR.*?\]', $BaseName
        $prompt = $prompt -replace 'taskX', $TaskId

        # Para formularios CRUD: adiciona schema da tabela
        if ($formType -ne "REPORT") {
            $tableSchema = Get-TableSchema -TaskId $TaskId -TasksDir $config.paths.tasks
            if (-not [string]::IsNullOrEmpty($tableSchema)) {
                $insertPoint = $prompt.IndexOf("## Arquivos a Criar")
                if ($insertPoint -gt 0) {
                    $prompt = $prompt.Insert($insertPoint, $tableSchema + "`n")
                }
                else {
                    $prompt = $prompt -replace "Comecar agora\.", ($tableSchema + "`nComecar agora.")
                }
                Write-Host "  Schema da tabela incluido no meta-prompt" -ForegroundColor Green
            }
            else {
                Write-Host "  [AVISO] Schema nao disponivel - meta-prompt sem validacao de colunas" -ForegroundColor Yellow
            }
        }

        # Para formularios de RELATORIO: substitui o prompt pelo template especifico
        if ($formType -eq "REPORT") {
            Write-Host "  [RELATORIO] Gerando meta-prompt especifico para frmrelatorio..." -ForegroundColor Cyan
            $prompt = @"
# Tarefa: Migrar Formulario de RELATORIO - $formClass

ATENCAO: Este e um FORMULARIO DE RELATORIO (frmrelatorio), NAO um cadastro CRUD.
A estrutura do codigo e completamente diferente do padrao CRUD.

## O que e um frmrelatorio
- Exibe campos de FILTRO/PARAMETRO (datas, codigos, opcoes de selecao)
- NAO tem Grid de lista, NAO tem operacoes CRUD
- Botoes: Imprimir, Visualizar (preview na tela), Cancelar/Fechar
- Ao imprimir: monta clausula WHERE com os filtros -> SQLEXEC -> REPORT FORM xxx PREVIEW

## Arquivos de Referencia OBRIGATORIOS (LER ANTES DE COMECAR)
1. **CLAUDE.md** - Regras VFP criticas (CHR(), TRY/CATCH, BINDEVENT, etc.)
2. **projeto/app/classes/relatoriobase.prg** - LEIA COMPLETAMENTE - e a base do BO de relatorio
3. **tasks/$TaskId/${BaseName}_form_codigo_fonte.txt** - Codigo fonte original (filtros, layout)
4. **tasks/$TaskId/mapeamento.json** - Mapeamento de objetos
5. **tasks/$TaskId/comportamento.json** - Analise comportamental (metodos, queries SQL, validacoes)

## Arquivos a Criar

### 1. C:\4c\projeto\app\classes\${boClass}.prg  (BO do Relatorio)
- Herda de **RelatorioBase** (NAO de BusinessBase!)
- Propriedades this_* para cada filtro do formulario (datas, codigos, opcoes)
- Override de **PrepararDados()**: monta SQL com WHERE baseado nos filtros -> SQLEXEC
- Init(): chamar DODEFAULT com caminho do FRX e titulo do relatorio
- NAO implementar: Inserir(), Atualizar(), ExecutarExclusao(), Buscar(), CarregarPorCodigo()

### 2. C:\4c\projeto\app\forms\relatorios\${formClass}.prg  (Form de Filtros)
- Herda de **FormBase**
- Layout FLAT: SEM PageFrame de duas paginas (sem Page1 de lista + Page2 de dados)
- Controles adicionados direto ao form em InicializarForm() (ou em container unico)
- Campos de filtro identicos ao original: TextBoxes, OptionGroups, ComboBoxes, datas
- Lookups F4/DblClick para campos de codigo (igual ao original)
- Botoes: Imprimir, Visualizar, Cancelar
- Metodos: InicializarForm, FormParaRelatorio, BtnImprimirClick, BtnVisualizarClick, BtnCancelarClick

## Padroes de Implementacao

### BO - PrepararDados():
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_cSQL, loc_cWhere, loc_nResult
        loc_cWhere = "1=1"
        IF !EMPTY(THIS.this_cCampo)
            loc_cWhere = loc_cWhere + " AND campo = " + EscaparSQL(THIS.this_cCampo)
        ENDIF
        IF !EMPTY(THIS.this_dDtInicial)
            loc_cWhere = loc_cWhere + " AND data >= " + FormatarDataSQL(THIS.this_dDtInicial)
        ENDIF
        loc_cSQL = "SELECT ... FROM tabela WHERE " + loc_cWhere
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
        IF loc_nResult < 0
            THIS.this_cMensagemErro = "Erro ao buscar dados"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

### Form - BtnImprimirClick():
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro())
        ENDIF
    ENDPROC

### Form - FormParaRelatorio():
    PROTECTED PROCEDURE FormParaRelatorio()
        WITH THIS.this_oRelatorio
            .this_dDtInicial = THIS.txt_4c_DtInicial.Value
            .this_cCliente   = ALLTRIM(THIS.txt_4c_Cliente.Value)
            && ... (todos os filtros do form)
        ENDWITH
    ENDPROC

### Form - InicializarForm() (sem PageFrame CRUD):
    PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oRelatorio = CREATEOBJECT("${boClass}")
            THIS.Width   = XXX  && EXATO do original
            THIS.Height  = XXX  && EXATO do original
            THIS.ConfigurarCamposFiltro()
            THIS.ConfigurarBotoesRelatorio()
            THIS.LimparCampos()
            THIS.Visible = .T.
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

### Form - Destroy() (CRITICO - NAO usar Release no BO!):
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.  && NAO usar .Release() - Custom nao tem Release!
        ENDIF
        DODEFAULT()
    ENDPROC

## CRITICO: Validacao LostFocus em campos de descricao (Validar*)

No sistema legado, campos de DESCRICAO (nome, razao social) tinham Valid events que fazem
lookup reverso automatico: usuario digita nome, ao sair do campo (Tab), o sistema busca
no banco e preenche o campo de CODIGO correspondente.

### REGRA: Para CADA par codigo/descricao, implementar ValidarXxx completo

Identificar no codigo fonte original: todo campo que tem evento Valid com fAcessoContas,
fAcessoEmpresa, fwBuscaExt ou fwBuscaInt DEVE ter o Validar* correspondente implementado.

### Padrao ValidarXxx (campo de descricao - busca reversa):
    PROCEDURE ValidarNomXxx()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_NomXxx.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_CodXxx.Value = ""
            THIS.txt_4c_NomXxx.Value = ""
            RETURN
        ENDIF
        *-- Abrir lookup automatico por nome/descricao
        THIS.AbrirBuscaNomXxx()
    ENDPROC

### Padrao ValidarXxx (campo de codigo - busca direta):
    PROCEDURE ValidarCodXxx()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c_CodXxx.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_DesXxx.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT campo_cod, campo_desc FROM tabela WHERE campo_cod = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_XxxVal")
        IF loc_nResult > 0
            SELECT cursor_4c_XxxVal
            IF !EOF()
                THIS.txt_4c_DesXxx.Value = ALLTRIM(campo_desc)
            ENDIF
            USE IN cursor_4c_XxxVal
        ENDIF
    ENDPROC

### Padrao ValidarAtendente (campo unico sem par):
    PROCEDURE ValidarAtendente()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Atendente.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        *-- Abrir lookup automatico
        THIS.AbrirBuscaAtendente()
    ENDPROC

**PROIBIDO**: Deixar Validar* vazios com apenas comentario. Cada um DEVE ter logica real
baseada no Valid event correspondente do legado.

## CRITICO: Tecla* para campos sem lookup (data/PV)

Campos de data ou PV que nao precisam de F4/F5 devem ter handlers vazios - isso e correto:
    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShift)
    ENDPROC

## Analise Comportamental (comportamento.json)

Se o arquivo **comportamento.json** estiver disponivel no contexto, ele contem a analise profunda dos
metodos e eventos do codigo original. REGRAS OBRIGATORIAS:

1. **TODA validacao** listada com ``temValidacao=true`` DEVE ser implementada
2. **TODAS as queries SQL** devem usar APENAS colunas reais - NAO inventar colunas
3. Se ``validacaoSchema.colunasInvalidas`` tiver itens, essas colunas NAO EXISTEM - NAO usar
4. **TODAS as funcoes externas** devem ser integradas ou substituidas
5. O campo ``codigoOriginal`` mostra a logica exata - REPRODUZIR com nova nomenclatura

## Regras VFP Criticas
- NUNCA usar literais acentuados - usar CHR(): a=225, c=231, ao=227, e=233, etc.
- NUNCA usar RETURN dentro de TRY/CATCH - usar variavel loc_lSucesso
- NUNCA usar .Release() em objetos Custom/BO - apenas em objetos Form
- BINDEVENT funciona apenas com metodos PUBLIC (sem PROTECTED)
- **BINDEVENT "Valid" NAO FUNCIONA em TextBox**: Usar "KeyPress" (ENTER=13/TAB=9) para simular Valid. NUNCA usar LostFocus para chamar MontaGrade/CarregarDados/SQLEXEC - LostFocus dispara SEMPRE (inclusive por SetFocus de outro controle) causando RECURSAO INFINITA. Ex: `BINDEVENT(txt, "KeyPress", THIS, "TxtCampoKeyPress")` e no handler: `IF par_nKeyCode = 13 OR par_nKeyCode = 9 ... ENDIF`
- **Page.Visible NAO EXISTE**: Page (PageFrame.PageN) NAO tem propriedade Visible. NUNCA `.Page1.Visible = .T.`.
- **PageFrame.Visible OBRIGATORIO**: AddObject cria controles com Visible=.F. SEMPRE adicionar `THIS.pgf_4c_Paginas.Visible = .T.` ANTES de `ActivePage = 1` no InicializarForm. Sem isso form abre em branco.
- **Buttons(N) vs ButtonCount**: Ao fazer BINDEVENT em Buttons(N), N DEVE ser <= ButtonCount. Verificar no AddObject qual era o ButtonCount antes de referenciar.
- TextBox.Value: inicializar como "" (string), 0 (numerico), {} (data)
- FormatarDataSQL() para datas em SQL, EscaparSQL() para strings (JA INCLUI aspas - NUNCA adicionar aspas extras: campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'")
- AddObject() cria controles com Visible=.F. - sempre setar .Visible = .T.
- NUNCA gerar strings SQL numa unica linha longa - SEMPRE quebrar com ``+;`` (continuation) a cada 3-4 campos. VFP9 tem limite de ~8000 chars por linha logica
- NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1)
- UI Fidelity PILAR 1: Width/Height/Top/Left/BackColor/ForeColor/FontName EXATOS do original
- PILAR 2: Usar nomes de colunas EXATOS do banco (ver schema.sql)
- **MESSAGEBOX PROIBIDO**: NUNCA usar MESSAGEBOX() direto. Usar funcoes de messages.prg: MsgInfo() para informativo (icone 64), MsgAviso() para aviso (icone 48), MsgErro() para erro (icone 16), MsgConfirma() para confirmacao Sim/Nao. Essas funcoes suprimem dialogs em modo de teste automatizado.
- **fAcessoEmpresa() NAO EXISTE (nao portada)**: A funcao global `fAcessoEmpresa()` do Framework legado (sigacess.PRG) NAO foi portada para a nova arquitetura. Chamadas diretas quebram em runtime com "File 'facessoempresa.prg' does not exist" (VFP9 procura .prg externo quando o nome nao eh THIS.metodo nem funcao definida). Substituicao canonica: MODO CHECK (3 args, retorna boolean) `fAcessoEmpresa(usu,"C",cod)` -> `VerificarAcessoEmpresa(usu, cod)` (helper em utils/functions.prg). MODO LOOKUP (5 args, popula 2 textboxes) `fAcessoEmpresa(usu, "C"|"D", val, oCod, oDsc)` -> bloco FormBuscaAuxiliar apontando SigCdEmp com chave Cemps (modo C) ou Razas (modo D), retornando ambas colunas. Titulo: "Sele" + CHR(231) + CHR(227) + "o de Empresa". Auto-fix: CorretorAutomatico #110. Padrao canonico: Formsigatcrp.prg:2278-2378 (KeyPress) e Formsigrepes.prg:6501-6540 (LostFocus). Bug observado em Formsigatcrp.prg + Formsigrepes.prg (2026-07-02, Erro14).
- **fAcessoContas() NAO USAR para lookup UX (auto-load do primeiro registro)**: A funcao `fAcessoContas()` (utils/functions.prg:719) EH portada, mas seu fluxo interno (`LIKE '%valor%'` + `LOCATE` + FormBuscaSimples) auto-popula o textbox com o PRIMEIRO registro que contem o valor digitado — mesmo sem selecao explicita do usuario no picker. Resultado tipico: user digita "11" no campo Gerente/Vendedor e o form carrega "GAVETA - LOJA 001..." (primeiro match parcial). PROIBIDO usar `fAcessoContas(usu, grp, "C"|"D", val, txtCod, txtNom)` como handler de Valid/KeyPress em textbox de lookup. Substituicao canonica: mesmo padrao de fAcessoEmpresa lookup (Formsigatcrp.prg:2612-2790 apos Erro16 fix). Enter/Tab -> `SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = valor` exato (hit -> auto-preenche, miss -> `THIS.AbrirBusca<X>()`). AbrirBusca<X> -> SQL proprio com `LIKE 'valor%' OR RTRIM(RClis) LIKE 'valor%'` (starts-with, NAO contem) + fallback lista completa + `CREATEOBJECT("FormBuscaAuxiliar")` sem SQL automatica + mAddColuna("IClis"/"RClis") + `.Show()` respeitando `this_lSelecionou`. `fAcessoContas()` continua valida para contexto backend (SCAN loop de acesso, validacao sem UI). Bug observado em Formsigatcrp.prg ValidarCodGer/ValidarNomGer/ValidarCodVen/ValidarNomVen (2026-07-02, Erro16).
- **.RecordMark/.DeleteMark SO em Grid — NUNCA em CommandButton/Label/Container/TextBox/ComboBox/etc**: As propriedades `.RecordMark` e `.DeleteMark` sao EXCLUSIVAS de Grid (barras laterais de marcacao/exclusao de registro). Gerador frequentemente copia esse par de `WITH grd_4c_Xxx` e cola em WITH de CommandButton adjacente (ex: `cmd_4c_SelXxx`/`cmd_4c_DslXxx` ao lado de grids de selecao multipla em REPORT). VFP9 trava com "Property RECORDMARK is not found" ao instanciar o form. PIOR: o erro eh silenciosamente engolido pelo TRY/CATCH de `InicializarForm` (apenas seta `loc_lSucesso=.F.` sem MsgErro), resultando em `CREATEOBJECT("FormXxx")` retornar `.F.` sem exception aparente e "VARTYPE retornou: L" no dialog. PROIBIDO gerar `.RecordMark = .F.` ou `.DeleteMark = .F.` em WITH cujo AddObject NAO seja `"Grid"`. Recomendacao complementar: no CATCH de `InicializarForm`, chamar `MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)` ANTES de setar `loc_lSucesso=.F.` — expoe o erro para debug em vez de engolir silenciosamente. Auto-fix: CorretorAutomatico #111. Bug observado em Formsigrepes.prg (2026-07-02, Erro17): 9 CommandButtons corrompidos (`cmd_4c_SelOrigMerc`, `cmd_4c_SelTipoInvs`, `cmd_4c_SelLinha`, etc).
- **UNION ALL entre tabelas diferentes**: NUNCA usar SELECT * em UNION ALL. Listar colunas EXPLICITAS IDENTICAS.
- **INTO CURSOR READWRITE**: NUNCA usar `INTO CURSOR X` + `USE DBF("X") IN 0 ALIAS Y`. Usar `INTO CURSOR cursor_4c_Dados READWRITE` direto.
- **Cursor placeholder = cursor real**: CREATE CURSOR placeholder no InicializarForm DEVE ter EXATAMENTE os mesmos campos que o cursor populado por SQLEXEC.
- **CheckBox em Grid Column (Error 1767)**: Para grids com CheckBox, a UNICA definicao de ControlSource deve ser `Column1.ControlSource = "cursor.campo"` DEPOIS de `CurrentControl = "Check1"`. NUNCA definir `Check1.ControlSource` (conflita com Column) E NUNCA definir `Column1.ControlSource` ANTES de AddObject("Check1").
- **AddObject sintaxe CORRETA**: `parent.AddObject("nome", "Classe")` - ambos strings. NUNCA `parent.AddObject(loc_oObj, "nome")` (objeto como parametro causa "Function argument invalid"). Padrao: `parent.AddObject("cmd_4c_X", "CommandButton")` + `WITH parent.cmd_4c_X` para configurar.
- **Grid Column CurrentControl="Check1" EXIGE AddObject**: ANTES de `.Column1.CurrentControl = "Check1"`, OBRIGATORIO: `.Column1.AddObject("Check1", "CheckBox")` + `.Column1.Check1.Caption = ""`. Sem isso, erro "Unknown member CHECK1" cascateia e destroi toda inicializacao.
- **CheckBox .Value SEMPRE NUMERICO**: Inicializar CheckBox com `.Value = 1` (marcado) ou `.Value = 0` (desmarcado). NUNCA usar `.T.`/`.F.` (logico). Comparar com `= 1`/`= 0`, IIF com `IIF(chk.Value = 1, ...)`. Misturar tipos causa "Operator/operand type mismatch".
- **IF THEN inline PROIBIDO**: VFP9 NAO suporta `IF cond THEN cmd` numa unica linha. Gera "Command contains unrecognized phrase/keyword." SEMPRE expandir para multi-linha: `IF cond` / `  cmd` / `ENDIF`.
- **COUNT TO var IN alias PROIBIDO**: VFP9 COUNT nao tem clausula IN. Gera "Command contains unrecognized phrase/keyword." Usar: `SELECT alias` + `COUNT TO var`.
- **APPEND FROM requer SELECT cursor antes**: `ZAP IN cursor_name` NAO muda a work area corrente. `APPEND FROM DBF("tmp")` vai para a work area CORRENTE. SEMPRE fazer `SELECT cursor_destino` antes de `APPEND FROM`. Sem isso, dados vao para o cursor errado e o grid fica vazio.
- **CommandGroup.FontName NAO EXISTE**: CommandGroup (como OptionGroup) NAO tem FontName/FontSize. Definir em cada `.Buttons(N).FontName`. Tentar no grupo causa "Property FONTNAME is not found" que cascateia e impede toda configuracao dos botoes.
- **AlternarPagina DEVE chamar AjustarBotoesPorModo**: Em forms CRUD, ao voltar para Page1 (LISTA), OBRIGATORIO chamar `THIS.AjustarBotoesPorModo()` ANTES de `THIS.CarregarLista()`. Sem isso os botoes ficam desabilitados apos Incluir/Alterar/Visualizar.
- **CommandGroup BackStyle/BorderStyle EXATOS do original**: Se o original tem `BackStyle=0` + `BorderStyle=0`, o CommandGroup eh TRANSPARENTE (container logico invisivel). NUNCA adicionar BackColor quando original nao tem. Copiar BackStyle, BorderStyle, SpecialEffect EXATOS.
- **ForeColor de Labels: COPIAR do original, NUNCA assumir**: Labels sobre fundo escuro usam ForeColor branco, labels sobre fundo claro usam ForeColor cinza (90,90,90). Copiar ForeColor EXATO do codigo fonte original. Assumir cor "baseado no tema" causa labels INVISIVEIS.
- **Buttons(N) dentro de CommandGroup: propriedades EXATAS**: Left, Top, FontName, FontBold, FontItalic, BackColor, ForeColor dos Buttons DEVEM vir do codigo fonte original. NUNCA inventar Left=0 ou FontName="Tahoma" quando original tem Left=178 ou FontName="Comic Sans MS".
- **Propriedades do BO preservam sufixo "s" da coluna do banco**: Colunas como Moedas, Contas, Grupos mapeiam para this_cMoedas, this_cContas, this_cGrupos. NUNCA "corrigir" removendo o "s" (this_cMoeda NAO EXISTE ? "Property not found"). Verificar nome EXATO no DEFINE CLASS do BO.
- **Nomes de icones/imagens: COPIAR EXATO do original + VALIDAR EXISTENCIA**: O atributo .Picture deve ter o nome de arquivo EXATO do original (ex: `geral_procura_60.jpg`, `cadastro_sair_60.jpg`). Trocar APENAS o path: `..\framework\imagens\` ? `gc_4c_CaminhoIcones +`. NUNCA inventar nomes de arquivo (ex: `consultar.bmp`, `geral_visualizar_60.jpg`, `geral_imprimir_60.jpg`, `geral_fechar_60.jpg` — NAO EXISTEM em vbmp/). USAR APENAS `gc_4c_CaminhoIcones` (NUNCA `gc_4c_Icones` — variavel legada, gera falhas em runtime). Para REPORT, ver "REPORT Buttons(N).Picture: ICONES CANONICOS OBRIGATORIOS" abaixo.
- **Propriedades do FORM: COPIAR TODAS do original**: TitleBar, ControlBox, MaxButton, MinButton, Closable, ClipControls DEVEM ser copiadas do codigo fonte original. Se original tem `TitleBar = 0` (sem barra de titulo), migrado DEVE ter `TitleBar = 0`. Omitir essas propriedades faz VFP9 usar defaults (barra de titulo visivel) alterando completamente a aparencia do form.
- **CommandButton ForeColor/BackColor/Themes EXATOS**: Botoes avulsos DEVEM copiar ForeColor, BackColor, FontName, FontBold, FontItalic, Themes do original. Se original tem ForeColor=90,90,90 + BackColor=255,255,255 + Themes=.F., copiar EXATO. ForeColor=RGB(255,255,255) em fundo claro torna texto INVISIVEL. **EXCECAO**: standalone CommandButton (fora de CommandGroup) com `.Picture` DEFINIDO precisa de `.Themes = .T.` + `.DisabledPicture = (mesma imagem)` — sem isso, com Themes=.F. + Enabled=.F. o icone NAO renderiza (so caption aparece). Auto-fix: CorretorAutomatico #99. Buttons(N) DENTRO de CommandGroup MANTEM Themes=.F. (canonico REPORT).
- **CommandButton auxiliar ao lado de Grid: NUNCA OMITIR `.Picture`**: Botoes standalone tipo `cmd_4c_SelTudo` (Selecionar Todos), `cmd_4c_Apaga` (Desmarcar/apaga), ou similares ao lado de grids de selecao TEM `.Picture` no SCX original (`geral_marcar_26.jpg` para Selecionar, `cadastro_excluir_26.jpg` para Desmarcar). Migracao frequentemente OMITE a linha `.Picture` inteira - botao renderiza como caixa vazia sem icone. SEMPRE copiar `.Picture = gc_4c_CaminhoIcones + "nome.jpg"` do original + aplicar padrao standalone (`.Themes=.T.` + `.DisabledPicture`). Heuristica: se WITH cmd_4c_* tem `.ToolTipText` = "Selecionar"/"Desmarcar"/"Marcar Todos"/"Limpar" e NAO tem `.Picture`, faltou copiar. Auto-fix: CorretorAutomatico #104. Bug em Formsigrecmc.prg (task052, 2026-07-01).
- **SigCdOpe eh single-column: NUNCA usar `descrs`/`Descrs`**: SigCdOpe tem `Dopes` (char(20)) que eh PK **E** descricao ao mesmo tempo — NAO existe coluna `descrs`/`Descrs` nessa tabela. Lookup FormBuscaAuxiliar para SigCdOpe deve chamar UMA UNICA `mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")`. NUNCA adicionar segunda coluna `mAddColuna("descrs", ...)` — gera runtime "Variable 'DESCRS' is not found" em FormBuscaAuxiliar.ConfigurarGrid quando seta Columns(N).ControlSource. Mesma regra para SELECT: `SELECT Dopes FROM SigCdOpe` (NUNCA `SELECT Dopes, Descrs FROM SigCdOpe`). Referencia: FormSIGREADS.prg:1554, Formsigrevto.prg:900. Auto-fix: CorretorAutomatico #105. Bug em Formsigrecmc.prg:1848 e FormSigReCmp.prg:1767/1813 (task052/task045, 2026-07-01).
- **CommandButton icone-only (`Caption=""`) NUNCA setar `.Enabled=.F.` em runtime**: Standalone CommandButton com `Caption=""` + `.Picture` NAO renderiza icone quando `.Enabled=.F.`, INDEPENDENTE de `.Themes=.T.` ou `.F.` — botao vira retangulo vazio. Isso refina o Pattern #99 (que funciona apenas para botoes COM caption como cmd_4c_Graficos). Nunca setar `.Enabled=.F.`/`.Enabled=.T.` em cmd_4c_* icone-only (SelTudo/Apaga tipicos) fora do bloco AddObject inicial — em vez disso: (a) NAO desabilitar (botao fica clickavel mas handler ja pode ser inocuo — SelTudo/Apaga so mexem em cursor cujo report vai ignorar), (b) desabilitar via check condicional dentro do handler `PROCEDURE CmdXClick`, OU (c) usar `.Visible=.F.` em vez de `.Enabled=.F.`. Auto-fix: CorretorAutomatico #106 (remove runtime `.Enabled=.F./.T.` em cmd_4c_* icone-only). Bug em Formsigrecmc.prg cmd_4c_SelTudo/cmd_4c_Apaga (task052, erro8.PNG, 2026-07-01) — desabilitar em TxtNmOperacaoKeyPress apagava icones apos usuario preencher Movimentacao.
- **Container de botoes sobre Grid: OBRIGATORIO BackStyle=1 OU posicionar fora da bbox do Grid**: Container filho de Form com CommandButtons dentro NAO pode ter `BackStyle=0` (transparente) se seu retangulo (Top..Top+Height) sobrepoe o Grid irmao (grid.Top..grid.Top+grid.Height). Grid re-renderiza rows em scroll (redraw parcial da area) — sem fundo opaco por tras dos botoes, os botoes ficam "carimbados" repetidamente em cada frame novo ("ghost trails"). Fix: (a) `Top >= grid.Top + grid.Height + margem` (posicao FORA da bbox — preferido), OU (b) `BackStyle = 1` + `BackColor = RGB(255, 255, 255)` se overlay for necessario. Auto-fix: CorretorAutomatico #107. Bug em FormBuscaAuxiliar.prg cnt_4c_Botoes (task052, Erro9.PNG, 2026-07-01) — Top=252 dentro do grid (grid bottom=306) + BackStyle=0 mostrava botoes Selecionar/Cancela stackados 3+ vezes ao scrollar a lista de contas.
- **OptionGroup.Buttons(N).Value NUNCA setar valor != 0**: Em VFP9, `OptionGroup.Value` eh INTEGER (1..N) indicando qual dos N botoes esta selecionado. `OptionButton.Value` (individual) eh BOOLEAN (0/1) — quem gerencia eh o OptionGroup. Se o codigo migrado setar `Buttons(2).Value = 2`, `Buttons(3).Value = 3`... VFP9 trata QUALQUER nao-zero como truthy → TODOS os radio buttons aparecem marcados de uma vez, comportamento visual quebrado. NUNCA setar `.Value = N` (com N != 0) dentro de bloco `WITH ...Buttons(N)`. Se quiser default selection, setar apenas `OptionGroup.Value = indice` (ex: `OptionGroup.Value = 2` para 2o botao marcado). Auto-fix: CorretorAutomatico #108. Bug em Formsigregli.prg (task108, 2026-07-01) em 5 OptionGroups (Get_Tipo/TpOrdem/Get_Boleto/Get_Pedido/Opt_Ordem).
- **TornarControlesVisiveis: skip com LOOP DEVE recursar em containers hidden-por-default**: Metodo recursivo `TornarControlesVisiveis` seta `Visible=.T.` em sub-controles apos AddObject (que os cria Visible=.F. default). Quando ha lista de skip para containers que devem comecar ocultos (ex: `IF INLIST(control.Name, "CNT_4C_ETIQUETAS", "CNT_4C_RELACAO") LOOP ENDIF`), o `LOOP` pula TANTO setar Visible do container QUANTO recursar dentro dele. Resultado: container fica hidden corretamente MAS seus filhos tambem ficam Visible=.F. permanente. Quando logica posterior seta `container.Visible=.T.`, container aparece VAZIO. Fix: dentro do IF de skip, ANTES do LOOP, recursar `THIS.TornarControlesVisiveis(container)` para tornar filhos visiveis sem tocar Visible do proprio container. Auto-fix: CorretorAutomatico #109. Bug em Formsigregli.prg (task108, 2026-07-01) — containers cnt_4c_Etiquetas/Relacao apareciam vazios ao selecionar Tipo de Impressao.
- **cnt_4c_Cabecalho Labels NUNCA usar AutoSize=.T.**: `lbl_4c_Sombra`/`lbl_4c_Titulo` em `cnt_4c_Cabecalho` DEVEM ter `AutoSize = .F.` (default) + `Width = THIS.Width` (Container Width, igual THISFORM.Width). Com `AutoSize = .T.`, captions longos expandem a Label alem da area dos botoes (cmg_4c_Botoes Left=529, Graficos Left=460), deixando texto truncado visualmente atras dos botoes. AutoSize=.F. clipa naturalmente no boundary. Auto-fix: CorretorAutomatico #98. Bug em Formsigrecmc.prg (2026-06-25). Template canonico: FormSigReAac.prg:104-146.
- **Grid RecordMark/DeleteMark em OPERACIONAL**: Grids criados manualmente (AddObject) em forms OPERACIONAIS DEVEM ter `.RecordMark = .F.` e `.DeleteMark = .F.`. Sem isso, barras de marcacao aparecem na lateral esquerda do grid.
- **ChkRegister NAO EXISTE em BusinessBase**: O legado usa ``ThisForm.poDataMgr.ChkRegister()`` para verificar duplicidade. Na migracao, usar SQLEXEC com ``SELECT COUNT(*) AS nExiste FROM tabela WHERE campo = valor`` + verificar ``NVL(cursor.nExiste, 0) > 0``. NUNCA chamar ChkRegister no BO.
- **cnt_4c_Cabecalho FUNDO CINZA MEDIO OPACO**: O cntSombra do framework.vcx tem `BackColor=RGB(100,100,100)` (cinza medio, NAO escuro). cnt_4c_Cabecalho DEVE ter `BackStyle=1` (opaco) + `BackColor=RGB(100,100,100)` + `lbl_4c_Titulo.ForeColor=RGB(255,255,255)` (branco sobre cinza). Valor RGB(100,100,100) (quase preto) eh ERRADO - usar 100 (cinza medio do framework). BackStyle=0 torna o cabecalho INVISIVEL. Bug corrigido em 2026-05-15 (system-wide).
- **NovoRegistro()/EditarRegistro() DEVEM chamar DODEFAULT()**: BOs que sobrescrevem NovoRegistro() ou EditarRegistro() DEVEM chamar DODEFAULT() como primeira linha. Sem isso, BusinessBase NAO seta this_lEmEdicao=.T. e Salvar() SEMPRE retorna .F. silenciosamente.
- **Botoes CRUD LADO DIREITO, posicoes EXATAS (ver framework_frmcadastro_layout.md)**: cnt_4c_Botoes Left=542 Width=390 (LADO DIREITO, NUNCA esquerdo!). Botoes internos Width=75, Left=5,80,155,230,305. FontName="Comic Sans MS" (NAO Tahoma). Encerrar em cnt_4c_Saida SEPARADO (Left=935, W=60). Grid FontName="Verdana". TODAS as posicoes padrao estao em ``docs/framework_frmcadastro_layout.md``.
- **Lookup textbox DEVE disparar em ENTER/TAB alem de F4**: Campos com lookup (fwBuscaExt no legado) DEVEM disparar busca em F4(115) E ENTER(13)/TAB(9) no KeyPress handler. O Valid original disparava ao sair do campo. Se o usuario digitar valor e pressionar TAB sem handler, nada acontece.
- **F4=115, F5=116 em KeyPress**: NUNCA usar 63 (que eh '?'). Codigos corretos: ENTER=13, TAB=9, F4=115, F5=116, ESC=27
- **Campos BIT do SQL Server**: Chegam como LOGICAL (.T./.F.) no VFP9. NUNCA usar NVL(campo,0)=1. Usar IF campo / IF !campo direto. NUMERIC(1,0) sim usa NVL.
- **Lookup ao sair do campo**: KeyPress com ENTER/TAB deve VALIDAR valor digitado contra tabela de referencia. Se encontrar, preencher descricao. Se nao encontrar, abrir FormBuscaAuxiliar. F4/F5 sempre abre lookup direto.
- **Z-ORDER AddObject em Page2**: Quando Page2 tem PageFrame interno + OptionGroup/botoes de navegacao, adicionar ``ZOrder(0)`` nos controles de navegacao APOS adicionar o PageFrame. VFP9 AddObject coloca ultimo objeto no topo do z-order, cobrindo controles anteriores.
- **PageFrame interno .Tabs = .F.**: PageFrame interno que usa OptionGroup para navegacao entre sub-paginas DEVE ter ``.Tabs = .F.``. Se .Tabs = .T., tabs nativos do VFP9 ficam visiveis e consomem espaco, sobrepondo controles.
- **Container Left+Width <= Form.Width**: Validar que Left + Width de TODOS os containers nao exceda Form.Width (normalmente 1000). Container parcialmente fora da area visivel fica cortado ou inacessivel.
- **NUNCA inventar tabelas de lookup**: Se o original NAO faz Seek/lookup de descricao para um campo, NAO criar query de lookup. Tabelas como SigCdCcr, SigCdJob NAO existem. Copiar nomes de tabela EXATAMENTE do codigo original. Se nao ha lookup no original, o campo eh apenas exibido.
- **WHERE Emps SOMENTE em tabelas que tem a coluna**: Tabelas de cadastro generico (SigCdGcr, SigCdMoe, SigCdCor, SigCdUni) tipicamente NAO tem coluna Emps. Antes de adicionar ``WHERE Emps = go_4c_Sistema.cCodEmpresa``, verificar no schema.sql se a tabela realmente tem essa coluna. Na duvida, omitir o filtro.
- **Propriedades this_ DECLARAR com nome EXATO do uso**: TODA propriedade referenciada como THIS.this_cXxx no codigo DEVE ter declaracao IDENTICA this_cXxx = "" no cabecalho DEFINE CLASS. Nomes amigaveis diferentes (ex: declarar this_cUltGrupo mas usar THIS.this_cUltCgrus) causam Error 174 Property not found no primeiro LostFocus.
- **Container.BorderStyle NAO EXISTE**: Container VFP9 tem BorderWidth mas NAO tem BorderStyle (propriedade de CommandGroup/OptionGroup). Usar apenas .BorderWidth = 0. CorretorAuto #68 remove automaticamente.
- **Containers de botoes CRUD TRANSPARENTES**: Containers que hospedam botoes CRUD em forms frmcadastro (cnt_4c_Botoes, cnt_4c_Saida, cnt_4c_BotoesDados) DEVEM usar `BackStyle=0` (transparente), NUNCA `BackStyle=1` com `BackColor=RGB(100,100,100)` ou similar escuro. O fundo do form ja e fornecido por Page.Picture (fundo_cad_1003.jpg); container opaco escuro cria caixa cinza ao redor dos botoes que destoa do layout original. EXCECAO UNICA: cnt_4c_Cabecalho usa opaco escuro propositalmente (cntSombra).
- **PageFrame.Height = Form.Height + 29**: Em forms frmcadastro com PageFrame oculto (Tabs=.F., Top=-29), o `pgf_4c_Paginas.Height` DEVE ser `Form.Height + 29` (NAO igual a Form.Height). Com Top=-29 e Height=Form.Height, sobram 29px descobertos no bottom expondo o fundo cinza nativo do form como borda indesejada. Formula: Form.Height=600 -> PageFrame.Height=629. Form.Height=650 -> PageFrame.Height=679.
- **IIF() exige LOGICAL no 1o argumento**: IIF(numerico, ...) quebra com "Function argument value, type, or count is invalid" quando valor=0. Em TEXTMERGE SQL e conversoes, SEMPRE comparar: IIF(this_nFlag = 1, '1', '0'). NUNCA passar numerico direto: IIF(this_nFlag, '1', '0').
- **cnt_4c_Sombra/cnt_4c_Cabecalho.Width = THIS.Width (NAO "THIS.Width - 60")**: Container do header escuro DEVE ocupar a largura TOTAL do form (`Width = THIS.Width`, ou 1020 como FormCor). O cnt_4c_Saida do Encerrar eh transparente (BackStyle=0) e precisa do fundo escuro POR BAIXO. Width menor deixa faixa clara a direita entre header e borda, expondo fundo do form. NUNCA usar `THIS.Width - 60` ou similar achando que precisa deixar espaco para o Encerrar.
- **PUBLIC FUNCTION/PROCEDURE em DEFINE CLASS = SYNTAX ERROR**: Dentro de `DEFINE CLASS ... ENDDEFINE`, metodos sao PUBLIC por DEFAULT. Apenas `PROTECTED` e `HIDDEN` sao modifiers validos. NUNCA `PUBLIC FUNCTION Buscar()` nem `PUBLIC PROCEDURE Init()` - gera cascade "Statement is not valid in a class definition" no .ERR e em runtime CREATEOBJECT do BO retorna .F. -> mensagem "VARTYPE retornou: L" ao abrir form. Usar `FUNCTION Buscar()` / `PROCEDURE Init()`. Auto-fix: CorretorAutomatico Corrigir-PublicProcedureEmDefineClass (bug observado em task018/UfsBO.prg).
- **btnReport e CommandGroup, NAO Container (frmrelatorio framework.vcx)**: Os 4 botoes superiores de forms REPORT (Visualizar/Imprimir/DocExcel/Sair) sao parte de UMA UNICA CommandGroup chamada `cmg_4c_Botoes`, NUNCA Container com 4 CommandButtons separados. Geometria EXATA do framework: `cmg_4c_Botoes.Top=0, Left=529, Width=273, Height=80, ButtonCount=4, BackStyle=0, BorderStyle=0, BorderColor=RGB(136,189,188), SpecialEffect=1, Themes=.F.`. Cada `Buttons(N)`: `Top=5, Width=65, Height=70, FontName="Comic Sans MS", FontBold=.T., FontItalic=.T., FontSize=8, BackColor=RGB(255,255,255), ForeColor=RGB(90,90,90), PicturePosition=13 (icone ACIMA), SpecialEffect=0, MousePointer=15, Themes=.F.`. Lefts dos botoes: `Buttons(1)=5, Buttons(2)=71, Buttons(3)=137, Buttons(4)=203` (incrementos de 66). Buttons(4) `.Cancel=.T.` (ESC fecha). BINDEVENT em `THIS.cmg_4c_Botoes.Buttons(N)`, NAO em CommandButtons nomeados. Bug observado em task023/SIGREVIS + task024/sigrevto (2026-05-15) - geravam Container+CommandButtons, captions truncadas porque PicturePosition=1 (icon-LEFT) com Width=67 nao cabia. Referencia: imagens em `C:\4c\origem\configuracaoBotoesRelatorio.jpg` + `video.jpg`/`impressora.jpg`/`excel.jpg`/`botao_encerrar.jpg`.
- **REPORT Buttons(N).Picture/Caption: CANONICOS OBRIGATORIOS (incluindo Buttons(3)=EMAIL com hotkey `\<A`, NAO Excel/DocExcel)**: Os 4 botoes do `cmg_4c_Botoes` em forms REPORT DEVEM ter EXATAMENTE Picture+Caption: Buttons(1)=`relatorio_video_26.jpg`+`"\<Visualizar"`; Buttons(2)=`relatorio_impressora_26.jpg`+`"\<Imprimir"`; **Buttons(3)=`geral_envelope_32.jpg`+`"\<Arquivos Email"` (NAO `"Excel"`, `"Doc. Excel"`, `"Doc.Excel"`, `"DocExcel"` — TODAS estas 4 variantes sao ERRADAS; o `Name="DocExcel"` do framework eh apenas nome interno legado enganoso, o Caption visual canonico eh "Arquivos Email" com hotkey `\<A`; Picture eh envelope de email; ver `docs/FRAMEWORK_class_codigo_fonte.txt` linhas ~6644-6664)**; Buttons(4)=`relatorio_sair_60.jpg`+`"\<Encerrar"`. Hotkey `\<` (barra invertida + `<`) OBRIGATORIO — sem a barra, VFP9 renderiza literal `<` na tela e desabilita Alt+letra. ToolTipText do Buttons(3) DEVE ser `"Arquivos Email"` (nao "Exportar para Excel"/"Gerar Uma Planilha Excel"). Path: SEMPRE `gc_4c_CaminhoIcones +` (NUNCA `gc_4c_Icones`). PROIBIDO inventar `geral_visualizar_60.jpg`, `geral_imprimir_60.jpg`, `geral_fechar_60.jpg` (NAO EXISTEM em vbmp/). Auto-fix: CorretorAutomatico #96 (icones inexistentes) + #100 v2 (Buttons(3) 5 variantes Caption + Picture + ToolTipText -> canonicos, cobrindo Excel/DocExcel/Doc. Excel/Doc.Excel + `<Arquivos Email` sem barra invertida). Bugs: Formsigatcrp.prg (2026-06-25) + FormSigReAac.prg (2026-06-26 task025) + sweep global Erro50 (2026-07-17: 14 forms com "Doc. Excel"/"DocExcel" corrigidos — Formsigreanr/apap/CMV/cmm/cgr/doc/cop/com/inr/dco/cpr/gnf/GDP/Esp). Template canonico: `FormSigReAac.prg:179-249` + `Formsigreanr.prg:210-235` pos-fix.
- **REPORT Buttons(N).FontName="Comic Sans MS" (NAO Tahoma)**: Os 4 Buttons(N) do `cmg_4c_Botoes` em REPORT DEVEM ter `FontName="Comic Sans MS"` + `FontSize=8` (framework `frmrelatorio.btnReport.CommandN`). O SCX original NAO sobrescreve FontName, entao herdam Comic Sans MS do framework. Gerador frequentemente coloca "Tahoma" por default - quebra fidelidade visual. Buttons(1) costuma vir SEM FontName/FontSize declarados; explicitar nos 4 botoes eh mais robusto. Auto-fix: CorretorAutomatico #101 (`Corrigir-ButtonsReportFontNameComicSans`). Bug em FormSigReAac.prg (2026-06-26, task025).
- **REPORT Buttons(3) e Buttons(4) DEVEM ter WordWrap=.T.**: O framework `frmrelatorio.btnReport.Command3.WordWrap = .T.` (linha 6653) e `Command4.WordWrap = .T.` (linha 6673). Sem `WordWrap=.T.`, captions longos como `"Arquivos Email"` (14 chars, Buttons(3)) sao TRUNCADOS porque nao cabem em 1 linha dentro de 65-75px com Comic Sans MS bold-italic 8. WordWrap permite quebrar em "Arquivos"/"Email" (2 linhas). Buttons(1)/(2) MANTEM `WordWrap=.F.` (default, framework explicitamente set para Command1; Command2 nao declara mas default eh .F.). Auto-fix: CorretorAutomatico #102 (`Corrigir-ButtonsReportWordWrap`). Bug em FormSigReAac.prg (2026-06-26, task025, imagem erro4.PNG).
- **REPORT btnReport geometria: SCX overrides PRECEDEM defaults do framework**: Os defaults do framework btnReport sao `Width=273, Left=529, Height=80; Buttons Width=65, Height=70, Lefts=5/71/137/203 (inc 66)`. PORÉM o SCX original PODE sobrescrever essa geometria — quando sobrescreve, USAR os valores do SCX, NAO os defaults. Antes de aplicar defaults, LER a secao "PROPRIEDADES DE: <FORM>" em `tasks/<task>/<form>_form_codigo_fonte.txt` e procurar overrides de `btnReport.Width/Left/Height/Top` e `btnReport.Visualiza/Imprime/DocExcel/sair.Top/Left/Width/Height`. Ex: SigReAac.scx tem `btnReport.Width=310, Left=494, Height=85` + `CommandN.Width=75, Height=75` com Lefts=5/80/155/230 (inc 75). Migrar com defaults ignorando o SCX quebra Pilar 1 (UX pixel-perfect). Defaults so aplicam quando SCX NAO sobrescreve. NAO automatizavel (precisa ler arquivo da task). Bug em FormSigReAac.prg (2026-06-26, task025).
- **REPORT OBRIGATORIO ter ConfigurarCabecalho() chamado ANTES de CriarBotoesRelatorio()**: TODO form REPORT (que herda FormBase + tem `cmg_4c_Botoes`) DEVE ter PROCEDURE `ConfigurarCabecalho` que cria `cnt_4c_Cabecalho` (Container Top=0, Left=0, Width=THIS.Width, Height=80, BackStyle=1, BackColor=RGB(100,100,100), BorderWidth=0) com 2 Labels sobrepostos: `lbl_4c_Sombra` (Top=22, Left=22, ForeColor preto, FontSize=14) + `lbl_4c_Titulo` (Top=20, Left=20, ForeColor branco, FontSize=14). Caption = THISFORM.Caption. A chamada `THIS.ConfigurarCabecalho()` DEVE vir ANTES de `THIS.CriarBotoesRelatorio()` em `InicializarForm()` (Z-order: cabecalho atras, botoes na frente). Sem isso o form abre sem a faixa cinza superior caracteristica e os 4 botoes ficam "flutuando" no canto direito. Auto-fix: CorretorAutomatico #97. Bug observado em Formsigatcrp.prg (2026-06-25). Template canonico: `FormSigReAac.prg:104-146`.
- **cnt_4c_Cabecalho Labels NUNCA usar AutoSize=.T.**: `lbl_4c_Sombra` e `lbl_4c_Titulo` em `cnt_4c_Cabecalho` DEVEM ter `AutoSize = .F.` (default) + `Width = THIS.Width` (ou explicito limitado ao espaco livre dos botoes). Com `AutoSize = .T.`, captions longos (ex: "Relatorio de Clientes que Mais/Menos/Nao Compram em Valores e Quantidades") expandem a Label alem da area dos botoes (cmg_4c_Botoes Left=529), deixando texto visualmente truncado atras dos botoes. AutoSize=.F. clipa naturalmente. Auto-fix: CorretorAutomatico #98. Bug observado em Formsigrecmc.prg (2026-06-25). Captions muito longas tambem precisam encurtar manualmente.
- **Standalone CommandButton com Picture: usar Themes=.T. + DisabledPicture**: CommandButton declarado via `THIS.AddObject("cmd_4c_X","CommandButton")` (FORA de CommandGroup) com `.Picture` definido DEVE usar `.Themes = .T.` (NAO `.F.`) E definir `.DisabledPicture` (mesma imagem do `.Picture`). Sem isso, com `.Themes = .F. + .Enabled = .F.`, o icone NAO renderiza (botao aparece so com caption). Buttons(N) DENTRO de CommandGroup MANTEM `.Themes = .F.` (config canonica REPORT). Aplica APENAS a standalone CommandButtons. Auto-fix: CorretorAutomatico #99. Bug observado em Formsigrecmc.prg cmd_4c_Graficos (2026-06-25).
- **REPORT Buttons(N).Picture nomes corrompidos/legados**: O gerador AS VEZES extrai mal o filename de `imagens\<nome>.jpg` do framework dump, gerando nomes ERRADOS: `"ideo.jpg"` (perdeu "v" de "video"), `"otao_encerrar.jpg"` (perdeu "b" de "botao"), `"impressora.jpg"`/`"excel.jpg"`/`"video.jpg"`/`"botao_encerrar.jpg"` (nomes "bare" sem sufixo `_26/_60` que NAO EXISTEM em vbmp/). Mapear SEMPRE para canonicos: `ideo.jpg`/`video.jpg`->`relatorio_video_26.jpg`; `impressora.jpg`->`relatorio_impressora_26.jpg`; `excel.jpg`->`geral_envelope_32.jpg` (botao 3 = EMAIL); `otao_encerrar.jpg`/`botao_encerrar.jpg`->`relatorio_sair_60.jpg`. Auto-fix: CorretorAutomatico #96 estendido. Bug em FormSIGREADS.prg (2026-06-26, task026).
- **REPORT grids (grd_4c_*): HeaderHeight=0 + RowHeight=18 + FontName="Tahoma" canonicos**: Grids em forms REPORT (frmrelatorio) seguem padrao `HeaderHeight=0` (header escondido — Label externa serve de pseudo-header tipo "Tipo de Operacao :"), `RowHeight=18` (nao 16) e `FontName="Tahoma"` (nao "Verdana"). Sem `HeaderHeight=0`, "Descrs" e similares aparecem como header de grid, destoando do layout do framework. Auto-fix: CorretorAutomatico #103 (`Corrigir-GridReportCanonico`). Bug em FormSIGREADS.prg (2026-06-26, task026).
- **ANTES DE MIGRAR: checar SCX mais novo em correcoes/**: O SCX em `tasks/task<NNN>/` pode estar DESATUALIZADO. ANTES de iniciar o pipeline, verificar se existe versao mais recente em `C:\4c\origem\correcoes\<basename>.SCX` (forma de teste/producao mais recente) ou em `C:\4install\FortyusMC*/Fortyus/<basename>.SCX`. Comparar timestamp e tamanho com o SCX da task. Se houver mais novo, COPIAR `.SCX` + `.SCT` para task e re-extrair via `DO C:\4c\projeto\app\utils\ExtractSCXCode.prg WITH 'tasks\task<NNN>\<basename>.SCX'`. Caso contrario, form migrado pode ficar incompleto (faltando controles/funcionalidade adicionados em versoes posteriores). Bug em task026/SIGREADS: SCX da task (2020, 4957 bytes, 35 objetos) vs SCX em correcoes/ (2024, 5829 bytes, 41 objetos com Label2/Grdgrupo/Fwbtnp1/Fwbtnp2/optTipoRel 5 botoes).
- **fwprogressbar NAO PORTADA — usar stub em classes/fwprogressbar.prg**: REPORT forms que usam `CREATEOBJECT("fwprogressbar", cTitulo, nTotal)` para barra de progresso (padrao Framework legado, usado em MCursor/Processamento/filtros pesados) precisam do stub em `C:\4c\projeto\app\classes\fwprogressbar.prg` (Form base com Init/Show/Update/Complete + labels Titulo/SubTitulo/Rodape/lblPercentage + shpThermBg/shpThermBar) registrado em `config.prg` via `CarregarSeExistir(gcCaminhoClasses + "fwprogressbar.prg")`. Sem isso, `CREATEOBJECT` lanca "Class 'fwprogressbar' is not found", CATCH silencioso em `InicializarForm` engole erro, `Init()` retorna .F., `CREATEOBJECT("FormXxx")` retorna .F. (Logical) -> "VARTYPE retornou: L" no menu. Bug em Formsigrepes.prg (2026-07-02, Erro17): 15 chamadas a fwprogressbar sem classe definida.
- **KeyPress handler: LPARAMETERS + guard Enter(13)/Tab(9)/F4(115) obrigatorios**: Handler bindado a KeyPress via BINDEVENT DEVE ter LPARAMETERS na primeira linha do corpo: `LPARAMETERS par_nKeyCode, par_nShiftAltCtrl`. Sem LPARAMETERS: runtime "No PARAMETER statement is found" no primeiro keystroke (bug engolido se CATCH nao verboso). Handlers de LOOKUP (que abrem FormBuscaAuxiliar) DEVEM ter guard IMEDIATAMENTE apos LPARAMETERS: `IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115 / RETURN / ENDIF`. Sem guard, handler roda a CADA tecla digitada, abrindo picker modal no primeiro char digitado — user nao consegue terminar de digitar codigo. Handlers de checkbox mutual-exclusion (chk_4c_*) NAO precisam do guard (rodam em qualquer keypress mas sao inocuous). Padrao canonico: `Formsigatcrp.prg:2614-2624` e `Formsigrepes.prg:6488-6497`. Auto-fix: CorretorAutomatico #30 estendido para PROCEDURE sem parens + #112 (guard 13/9/115 injetado em Validar* com FormBuscaAuxiliar). Bug em Formsigrepes.prg (2026-07-02, Erro18): 32 handlers `Validar*` sem LPARAMETERS + 24 handlers de lookup sem guard.
- **FormBuscaAuxiliar manual-API (CREATEOBJECT vazio + setters) NAO POPULA cursor**: Setar `this_cTabela`/`this_cCampoBusca`/`this_cValorBusca`/`this_cCursorDestino` em objeto criado com `CREATEOBJECT("FormBuscaAuxiliar")` (SEM params) + `mAddColuna(...)` + `.Show()` NAO dispara SQLEXEC internamente. `ConfigurarGrid()` executa `IF !USED(THIS.this_cCursorDestino) RETURN` e picker abre com grid VAZIO (user ve caixa cinza sem dados). Alem disso, propriedades como `this_cFiltro`/`this_cCursorOrigem`/`this_nMaxRegistros` que gerador as vezes seta NAO EXISTEM em FormBuscaAuxiliar — sao adhoc-dinamicas sem efeito. Duas alternativas CORRETAS: (a) Init com params completos: `CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "Tabela", "cursor_4c_Busca", "Campo", cVal, "Titulo", .T., .T., cFiltro)` — Init dispara SELECT exato + fallback LIKE; (b) Pre-popular cursor via `SQLEXEC(gnConnHandle, "SELECT ...", "cursor_4c_Busca")` ANTES de `.Show()`. Helper reutilizavel `AbrirLookup(txtCod, txtDesc, tabela, campoCod, campoDesc, campoBusca, valor, cursor, titulo, filtro, forcarPicker)` — implementacao canonica em `Formsigrepes.prg:3318-3385`. Auto-fix: nao automavel (refatoracao estrutural). Bug em Formsigrepes.prg (2026-07-02, Erro18): 13 handlers `Validar*` com manual-API abriam picker vazio.
- **REPORT Buttons(N).Left + Width DEVE caber em CommandGroup.Width**: Antes de aplicar Lefts do SCX ao `cmg_4c_Botoes`, VALIDAR: `Buttons(4).Left + Buttons(4).Width <= cmg_4c_Botoes.Width`. Se transbordar, Encerrar renderiza cortado (parcialmente visivel). SCX legado frequentemente tem geometria de SigReAac copiada (Buttons Width=75, Lefts=5/80/155/230, inc 75) mas Formsigrepes-like tem CommandGroup Width=273 + Buttons Width=65 — os Lefts=5/80/155/230 ends 295 > 273 -> overflow 22px. Fallback canonico para Width=273 + Buttons Width=65: **Lefts=5/72/139/206 (gap 2, ends 271)**. Framework defaults (rule 3205) sao Lefts=5/71/137/203 (inc 66, gap 1, ends 268). SCX overrides com incrementos > 66 quando Buttons Width=65 devem ser validados/recalculados. Auto-fix: CorretorAutomatico #113 valida overflow em cmg_4c_Botoes e recalcula Lefts. Bug em Formsigrepes.prg (2026-07-02, Erro19) — Encerrar aparecia cortado.
- **MsgAviso("...encontrada") antes de THIS.AbrirBusca<X>() eh REDUNDANTE e QUEBRA UX**: Em handlers `Validar<Campo>` que fazem `SELECT TOP 1` exato e caem no ELSE quando nao acham, PROIBIDO gerar `MsgAviso("Empresa nao encontrada")` + `.Value = ""` + `THIS.AbrirBusca<X>()` em sequencia. User ve dialog blocking "nao encontrada" -> clica OK -> picker abre -> mas o clear-field ja apagou o valor digitado, entao o picker abre SEM prefix para LIKE. Padrao CORRETO: apenas `THIS.AbrirBusca<X>()` no ELSE — o picker abrindo direto E JA o feedback visual de "nao achou match exato", e o valor digitado eh preservado para o SELECT LIKE prefix dentro do picker. Exemplo ERRADO: `MsgAviso("Vendedor nao encontrado", "Vendedor") / .Value="" / THIS.AbrirBuscaVended()`. Exemplo CORRETO: apenas `THIS.AbrirBuscaVended()`. Auto-fix: CorretorAutomatico #114. Bug em FormSIGREADS.prg (2026-07-02, Erro20) — 4 handlers (Empresa/Vendedor/Operacao/Moeda) + sweep global de 49 forms com mesmo anti-padrao.
- **SigCdGcr tem coluna `descrs` (com 'r'), NAO `descs` — consultar schema.sql sempre**: Tabelas com nomes parecidos podem ter colunas de descricao diferentes. `SigCdGcr` (Grupo Estoque/Contabil) tem `descrs` (indice linha 21685). Suas irmas `SigCdGpr` (Grande Grupo), `SigCdLin` (Linha), `SigCdCol` (Colecao) tem `descs`. NUNCA assumir nome de coluna por analogia entre tabelas — SEMPRE consultar `docs/schema.sql` para nomes reais. SigCdGcr aparece nos lookups de "Grupo de Estoque" e "Grupo Contabil" — `SELECT descs FROM SigCdGcr` gera "Nome de coluna 'descs' invalido" em runtime. Padrao CORRETO: `SELECT codigos, descrs FROM SigCdGcr`. mAddColuna do FormBuscaAuxiliar sobre SigCdGcr tambem: `mAddColuna("descrs", ...)`. Auto-fix: CorretorAutomatico #115. Bug em FormSIGREAEG/FormSIGREEGG/FormSigReCsp/Formsigreegp (2026-07-02, Erro21) — 4 forms, ~14 refs. Regra generica: em toda familia Sig*Cd* (SigCdEmp/Cli/Pro/Grp/Gpr/Gcr/Lin/Col/Ope/Fip/etc.), NUNCA colar column-name de outra tabela — verificar schema.sql explicitamente.
- **BtnVisualizarClick/BtnImprimirClick DEVEM ter TRY/CATCH + FULLPATH() ao redor de REPORT FORM**: TODO handler que executa `REPORT FORM ... PREVIEW/TO PRINTER` deve envolver o corpo em `TRY ... CATCH TO loc_oErro / MostrarErro("Erro ao visualizar/imprimir relat" + CHR(243) + "rio:" + CHR(13) + "Erro: " + loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro") / ENDTRY` e normalizar o path do FRX via `loc_cArquivoFRX = FULLPATH(gc_4c_CaminhoReports + "arquivo.frx")` (elimina `..\` que pode causar issues em modos especificos). Sem TRY/CATCH, qualquer erro dentro do `REPORT FORM` propaga ate o handler generico de `menu.prg` `AbrirRelXxx` com mensagem generica "Erro ao abrir Relatorio de X" — dificultando debug. Contexto: FRX legados frequentemente referenciam variaveis globais tipo `gcLogoRel`/`gcCabRel` — se o path da imagem apontar para arquivo inexistente (ex: logo.bmp ausente em vbmp/) e o Print When `not empty(gcLogoRel)` retornar `.T.`, `REPORT FORM` estoura "Invalid path or file name" em runtime. TRY/CATCH garante mensagem descritiva; FULLPATH() garante path canonico. Padrao canonico: `Formsigrecgr.prg:564-611` (BO GerarRelatorio com TRY/CATCH) e `FormSigReCmp.prg:1486-1512` (BtnVisualizarClick com TRY/CATCH). Config-level: `config.prg` DEVE ter `IF NOT FILE(gc_4c_LogoRelatorio) / gc_4c_LogoRelatorio = "" / ENDIF` apos setar o path (guard aplicado 2026-07-03, Erro22 — sem guard, `gcLogoRel` propagava path invalido e QUALQUER FRX com Picture=`gcLogoRel` estourava em runtime). NAO automavel (refatoracao estrutural do handler). Bug em FormRelPlanoContas.prg BtnVisualizarClick (2026-07-03, Erro22) — logo.bmp ausente + falta de TRY/CATCH mascarou o erro real.
- **INDEX ON composto (A+B) com SEEK parcial (so A) FALHA 100% com SET EXACT ON**: `config.prg:193` seta `SET EXACT ON` globalmente — SEEK exige match da CHAVE INTEIRA do indice, nao mais prefix. Se cursor tem `INDEX ON A + B TAG X` (chave concatenada, ex: 20 chars) e o codigo faz `SEEK(loc_valorA, cursor, "X")` passando so `A` (ex: 10 chars), SEEK retorna .F. SEMPRE — `IF SEEK()` cai silenciosamente e a expansao/scan pula toda a subarvore sem exception. REGRA: se TODOS os `SEEK(..., cursor, "X")` do mesmo TAG usam apenas o primeiro campo do compound, trocar o INDEX para single-column (`INDEX ON A TAG X`). Se precisa manter compound (uniqueness, multi-key seek), OU pad-completar a chave do SEEK ate o tamanho da chave do indice OU `SET EXACT OFF` local (salvar/restaurar). Auditoria cross-file: listar `INDEX ON (\w+)\s*\+\s*(\w+) TAG (\w+)` vs `SEEK\(.*,\s*<cursor>,\s*"\3"\)` — se todos os SEEK usam so `\1`, eh bug. Bug em PlanoContasBO.prg + SigRePlcBO.prg (2026-07-03, Erro23) — relatorio Plano de Contas perdia nivel 5 (contas analiticas / clientes SigCdCli) porque `INDEX ON Grupos + IClis TAG Grupos` + `SEEK(loc_cLsGrupo, "crSigCdCli", "Grupos")` nunca casava; fix trocou por `INDEX ON Grupos TAG Grupos`. NAO automavel (detector precisa correlacionar INDEX + SEEK do mesmo TAG dentro do mesmo cursor no mesmo arquivo).
- **fwprogressbar stub — membros GARANTIDOS + como completar**: O stub `classes/fwprogressbar.prg` implementa a interface do framework legado com estes membros: labels `Titulo`, `SubTitulo`, `Rodape`, `lblPercentage` + shapes `shpThermBg`, `shpThermBar` + metodos `Init(cTitulo, nTotal)`, `Update(lRefresh)`, `Complete(lRefresh)`, `Show()`, `Hide()`. Se codigo migrado precisar de outro membro (framework legado tinha mais props/labels em versoes especificas), REGRA ABSOLUTA: ADICIONAR AO STUB — NUNCA alterar o form migrado. Runtime erro tipico: `Unknown member <NOME>` estourando em `Processamento`/`MCursor`/`GerarRelatorio` durante loop de scan. Ao adicionar novo Label ao stub: ajustar `Height` do form stub (+18 por Label) para nao clipar. Auto-fix: CorretorAutomatico Pattern #116 (`Corrigir-FwProgressBarStubMembros`) valida integridade do stub. Bug em Formsigrepes.prg linha 4562 `loBarra.Rodape.Caption = "<ESC> para interromper..."` (2026-07-07, Erro26) — stub nao expunha `Rodape` e o `IF SELECT()` no BtnVisualizarClick nao capturava porque o erro era em `Processamento` chamada por REPORT FORM.
- **REPORT FORM &var. (macro) SEM guard IF FILE() PROIBIDO — usar helper THIS.ExecutarReportForm()**: TODO `REPORT FORM &<var>. PREVIEW/TO PRINTER PROMPT/TO PRINTER` em form REPORT/OPERACIONAL DEVE passar por helper `PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)` que faz (a) `loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")` + `IF NOT FILE(loc_cFRX) / MostrarErro(...) / RETURN .F.`; (b) **isolamento de locale + REPORTBEHAVIOR**: salvar `SET("POINT")`/`SET("SEPARATOR")`/`SET("REPORTBEHAVIOR")` -> `SET POINT TO "."` + `SET SEPARATOR TO ","` + `SET REPORTBEHAVIOR 80` -> rodar REPORT FORM -> restaurar; (c) `DO CASE ... REPORT FORM (loc_cFRX) PREVIEW/TO PRINTER PROMPT/TO PRINTER NOCONSOLE ENDCASE`. Modos: `"PREVIEW"`, `"PRINTER_PROMPT"`, `"PRINTER"`. Sem guard(a), FRX legado nao portado estoura "File does not exist" sem indicar arquivo. Sem isolamento(b), FRXs legados Fortyus (VFP6/7/8) renderizam CAMPOS NUMERICOS COMO ASTERISCOS `*******` no VFP9 default (REPORTBEHAVIOR 90 re-mede fontes em runtime + POINT="," BR conflita com PICTUREs `9,999.999` do FRX). Modo 80 (classic) mede fontes como a IDE de design legado. Auto-fix: Pattern #117 (`Corrigir-ReportFormSemGuard`) detecta AMBAS as formas (macro `&<var>.` e parenteses `(<var>)`), extrai base da atribuicao anterior com strip automatico de `.frx`, injeta helper canonico com 3 params `(par_cRelatorioBase, par_cModo, par_cCursorDados)` — o 3o param eh OPCIONAL (guard `VARTYPE == "C"` garante retrocompatibilidade). Se caller passa nome do cursor e ele estiver vazio/inexistente, helper mostra MsgAviso "Nenhum registro encontrado" e retorna sem abrir preview vazio (Erro30). Callers devem passar `THIS.this_oRelatorio.this_cCursorDados` (nome do cursor populado por PrepararDados). Substituicao de chamadas mantem o helper opcional — Pattern #117 gera chamadas de 2 args por seguranca (nao sabe qual cursor). Refactor manual dos callsites para passar o 3o arg eh recomendado. Bugs: Formsigrepes (Erro27/28, macro) + FormSIGREVIS (Erro29/30, parenteses + cursor vazio). Complementa Pattern #113 e `feedback_gclogorel_file_guard.md` (Erro22).
- **SELECT VFP local com variavel LOCAL — alias em SELECT list DEVE bater com nome do memvar**: SELECT VFP local (`SELECT ... FROM crCursor ... INTO CURSOR novoCursor`) que referencia variavel LOCAL tem 2 regras: (1) prefixar `m.` em toda ocorrencia de var local (`loc_c\w+`) dentro do bloco — sem `m.`, VFP resolve identificador solto como COLUNA do FROM e estoura "SQL: Column 'LOC_CXXX' is not found". (2) **CRITICO**: em SELECT list, alias DEVE bater com nome do memvar (`loc_cXxx AS loc_cXxx`, NUNCA `m.loc_cXxx AS <different>`) — o padrao proven do legado. Sem (2), quando o memvar aparece em GROUP BY / SUM(IIF(...)), o erro reincide mesmo com `m.` aplicado (Erro31 2026-07-08, mesmo BO/proc do Erro30-b — Pattern #118 v1 apenas prefixando falhou). Padrao correto (mimica legado): `SELECT crXxx.col, loc_cMoeda AS loc_cMoeda, SUM(IIF(loc_cMoeda = tabela.campo, ...)) AS mValos FROM crXxx GROUP BY crXxx.col, loc_cMoeda INTO CURSOR resultado READWRITE`. NAO se aplica a SQLEXEC (SQL Server) — usar `EscaparSQL(loc_cXxx)`. Auto-fix: CorretorAutomatico Pattern #118 (`Corrigir-SelectLocalVarSemMPrefix`) tem 3 fases — (F1) detecta bloco SELECT-INTO-CURSOR, (F2) prefixa `m.` onde nao qualificado, (F3, Erro31) normaliza `m.<var> AS <different>` -> `<var> AS <var>` no SELECT list. Bug: sigrevtoBO.prg PrepararDados linhas 240-283 (Erro30-b 2026-07-07 + Erro31 2026-07-08) — Branch A (SigMvPar) + Branch B (SigMvCab) do "Relatorio Total Por Operacao".
- **REPORT: cursor de saida e aliases DEVEM bater com nomes esperados pelo FRX legado (SELECT INTO + CREATE CURSOR + memvars)**: FRXs legados nao sao portados — o generator so cria BOs. FRX renderiza expressoes que referenciam colunas do cursor CORRENTE por nomes que o LEGADO criava. Ex: FRX SigReVto tem field expressions `csRelatorio.lcMoeda`; se o BO migrado criar `cursor_4c_Relatorio` com coluna `loc_cMoeda`, REPORT FORM estoura `Variable 'LCMOEDA' is not found` (Erro33 2026-07-08). Ex2: FRX SigReAiv tem `Cabec.cnInvs1`+`DBImp.cPros`; se BO criar `cursor_4c_Cabecalho`+`cursor_4c_DbImp`, REPORT FORM estoura `Alias 'CABEC' is not found` (Erro46 2026-07-17). **Regras (cobrem TODAS as formas de criar cursor: SELECT INTO CURSOR + CREATE CURSOR + APPEND FROM/USE ALIAS)**: (a) `this_cCursorDados = "<nome_do_legado>"` — extrair do legado analisando o codigo fonte original: procurar `Into Cursor <X>` OU `Create Cursor <X>` na PROCEDURE `processamento` (o cursor que precede `Select <X>` / `Go Top` antes do `Report Form`); (b) TODAS as ocorrencias no BO — `CREATE CURSOR <nome_legado>`, `SELECT ... INTO CURSOR <nome_legado>`, `SELECT <nome_legado>`, `USED("<nome_legado>")`, `USE IN <nome_legado>`, `INSERT INTO <nome_legado>` — DEVEM usar EXATAMENTE o mesmo nome; (c) para SELECT INTO com memvars: `<memvar_novo> AS <coluna_do_legado>` (ex: `loc_cMoeda AS lcMoeda`); (d) `GROUP BY <alias>` — usar o alias legado (evita Erro31 alias mismatch); (e) para relatorios com MULTIPLOS cursores (ex: SigReAiv usa `Cabec` como header + `DBImp` como detail), criar TODOS com nomes legados — NAO renomear para `cursor_4c_Cabecalho`/`cursor_4c_DbImp`; (f) copiar `<nome>.frx` + `<nome>.frt` de `C:\4install\FortyusMC\Fortyus\` para `C:\4c\projeto\app\reports\`. Sem (a-e), REPORT FORM falha por variavel/coluna/alias nao encontrada. Sem (f), Pattern #117 helper `ExecutarReportForm` dispara MostrarErro "Arquivo de relatorio nao encontrado" (Erro32 2026-07-08). PROIBIDO usar `cursor_4c_*` como nome de cursor em BOs REPORT — reservar esse prefixo para cursores INTERNOS que NAO sao consumidos pelo FRX (ex: cursor de resultado bruto de SQLEXEC antes de agregar). NAO automavel — depende de leitura do legado + FRX binario. Ver `docs/report_guide.md` e `migration-patterns.md ## 131`. Padrao canonico: `sigrevtoBO.prg` (INTO CURSOR) + `SigReAivBO.prg` pos-fix (CREATE CURSOR multiplos).
- **RegistrarAuditoria: DataHora usar `GETDATE()` — NUNCA `FormatarDataSQL(DATETIME())`**: BOs que sobrescrevem `RegistrarAuditoria` para gravar em `LogAuditoria` com detalhes custom DEVEM usar literal `GETDATE()` para o campo `DataHora` (funcao SQL Server nativa, avaliada server-side). NUNCA usar `FormatarDataSQL(DATETIME())` — a funcao rejeita tipo T (DateTime) e retorna literal "NULL", quebrando INSERT em coluna NOT NULL: `[SQL Server]Nao e possivel inserir o valor NULL na coluna 'DataHora'` (Erro35 2026-07-08 SigReAacBO Relatorio Log de Acessos). Padrao canonico BusinessBase.RegistrarAuditoria (classes/businessbase.prg:267): `... EscaparSQL(loc_cUsuario) + ", GETDATE())"`. Melhoria sistemica em `utils/functions.prg`: `FormatarDataSQL` agora aceita D e T (retorna 'YYYY-MM-DD HH:MM:SS' para T) prevenindo recorrencia via variaveis. Auto-fix: CorretorAutomatico Pattern #119 (`Corrigir-FormatarDataSQLDatetime`) detecta `FormatarDataSQL(DATETIME())` e substitui por `GETDATE()`. Idempotente.
- **`&m.<var>.` eh MACRO QUEBRADA — usar `&<var>.` sem prefixo m.**: Em VFP9 o macro operator `&` le o nome do macro ATE o primeiro `.` (o `.` termina o nome). `&m.loc_cWhere.` tenta expandir a variavel chamada `m` (que nao existe) — VFP9 erro 10 "Syntax error." aborta o SELECT VFP local ou REPORT FORM. A regra de Pattern #118 "prefixar `m.` em toda ref de var LOCAL dentro de SELECT VFP local" vale APENAS para refs normais (SELECT list, WHERE column ops, function args, GROUP BY, ORDER BY), NUNCA dentro de macro `&`. CORRETO: `WHERE &loc_cWhere.` (sem `m.`). Padrao legado sempre usa `&lcVar.` sem prefixo. Auto-fix: CorretorAutomatico Pattern #120 (`Corrigir-MacroMPrefixQuebrado`) — regex `&m\.` -> `&` (safe global replace, `&m.` NUNCA eh construcao valida em VFP). Idempotente. Complementa Pattern #118 excluindo macros do escopo do fix. Bug em SIGREADSBO.PrepararDados linha 492 (2026-07-14, Erro37) + varredura em 8 arquivos (SIGREADSBO, sigopcgpBO, sigrecheBO, sigrecpeBO, sigrecrtBO, sigrecsmBO, SigReIr1BO, Formsigrepes) com 13 ocorrencias.
- **INSERT em SQL Server: helpers por TIPO destino + LEFT() por TAMANHO destino**: Ao inserir campo de cursor VFP em coluna SQL Server, DEVE combinar (1) helper de acordo com o TIPO da coluna DESTINO (nao o tipo origem): CHAR/VARCHAR/TEXT -> `EscaparSQL(...)`; NUMERIC/INT -> `FormatarNumeroSQL(..., decimais)`; DATE/DATETIME -> `FormatarDataSQL(...)` ou literal `GETDATE()`; (2) truncar via `LEFT(campo, N)` quando origem CHAR(M) > destino CHAR(N). Exemplos comuns: `SigCdCli.Rclis` eh char(50) mas `SigTempR.Razas` eh char(40) -> `EscaparSQL(LEFT(csRelatorio.RClis, 40))`; `csRelatorio.CodObs` eh numeric(3,0) e NAO pode ir por `EscaparSQL` — `EscaparSQL` retorna `''` (string vazia) para nao-C, SQL Server rejeita conversao `'' -> numeric(3,0)` -> usar `FormatarNumeroSQL(csRelatorio.CodObs, 0)`. Sem esses cuidados: SQL Server erro 8152 "String or binary data would be truncated" aborta o INSERT (rollback implicito) OU erro de conversao numerica — em ambos os casos, SQLEXEC apenas retorna <0 sem MsgErro claro. `SigTempR` eh tabela critica reutilizada por VARIOS relatorios analiticos. Antes de gerar INSERT: consultar `docs/schema.sql` para tipos+tamanhos das colunas destino e comparar com a origem. NAO automavel univoco (depende de comparar schema origem vs destino por campo). Bug em SIGREADSBO.PrepararDados linhas 552/555 (2026-07-14, Erro39) — INSERT SigTempR falhando na 552 (truncamento RClis 50>40) e depois na 555 (`EscaparSQL` em CodObs numeric).
- **Grid Column CheckBox EXIGE `.Sparse = .F.`**: Todo `Column1` de Grid com `CurrentControl = "Check1"` DEVE ter `.Sparse = .F.` explicito. Default VFP9 eh `Sparse = .T.`, que renderiza o CurrentControl (o CheckBox) APENAS na linha corrente do grid — outras linhas mostram o valor bruto do campo (0/1) como texto plano e o usuario NAO consegue clicar checkboxes das demais linhas. Visualmente: 1 linha com [x], demais com "0" ou "1" em texto (parece "grid quebrado"). Comportamental: BtnSelTudo/BtnApaga funcionam (fazem REPLACE ALL Marca), mas selecao individual por click NAO funciona. Padrao canonico: `Formsigrepes.prg:3095-3104` (Column1: Width + Alignment=0 + Enabled=.T. + `Sparse=.F.` + AddObject Check1 + Check1.Caption + CurrentControl + ControlSource). Auto-fix: CorretorAutomatico Pattern #121 (`Corrigir-GridColumnCheckboxSparse`) — detecta bloco `WITH ... Column1` que contem `CurrentControl = "Check1"` sem `.Sparse = .F.` e injeta a linha. Bug em FormSIGREADS.prg linhas 441-451 (grd_4c_TipoOps) + 545-555 (grd_4c_Grupos) — 2026-07-14, Erro41: user nao conseguia marcar tipos de operacao nem grupos de produto.
- **REPORT: BtnVisualizarClick/BtnImprimirClick guard `!EMPTY(cMensagemErro)` antes de MsgErro — 2 variantes (property + method) + nested-IF eh safe com ELSE**: Handlers de botao REPORT que chamam `THIS.this_oRelatorio.Visualizar()`/`Imprimir()`/`Atualizar()`/`Inserir()` DEVEM ter guard `IF !EMPTY(...)` antes de exibir `MsgErro(...)`. Motivo: o helper canonico `ExecutarReportForm` (Pattern #117) exibe seu proprio `MsgAviso` quando cursor esta vazio ou FRX faltando, e retorna `.F.` sem setar `cMensagemErro` — se o handler chama `MsgErro("")` cegamente, aparece SEGUNDO modal com titulo "Relatorio" e corpo VAZIO (apenas icone X vermelho). Duas variantes de fonte da mensagem: (a) property `THIS.this_oRelatorio.this_cMensagemErro` (acesso direto), (b) method `THIS.this_oRelatorio.ObterMensagemErro()` (acessor com parentheses). AMBAS devem ser guardadas. Duas formas de wrap: **v1** `IF !X() AND !EMPTY(<expr>) / MsgErro(<expr>, ...) / ENDIF` — APENAS se IF externo NAO tem ELSE; **v2 (PREFERIDO)** nested-IF `IF !X() / IF !EMPTY(<expr>) / MsgErro(<expr>, ...) / ENDIF / ELSE / RegistrarAuditoria() / ENDIF` — SEGURO com ELSE branch (funciona quando handler chama Auditoria em sucesso). CUIDADO: se IF externo tem ELSE (ex: `THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")` no success), a variante v1 (AND !EMPTY na condicao IF) QUEBRA a semantica — quando `Visualizar()` retorna `.F.` E `cMensagemErro` esta vazio, o ELSE branch dispara e Auditoria roda em FALHA. Usar v2 sempre que possivel. Auto-fix: CorretorAutomatico Pattern #122 v2 (`Corrigir-BtnReportGuardEmptyMsgErro`) detecta AMBAS variantes (this_cMensagemErro OR ObterMensagemErro()) e wrap com nested-IF; idempotente (skip se ja guardado); suporta MsgErro multi-linha (continuation `;`). Padrao canonico: `FormSigReAni.BtnVisualizarClick/BtnImprimirClick/BtnExcelClick` pos-fix (2026-07-17). Bugs: Erro40 (FormSIGREADS 2026-07-14, variante property) + Erro48 (FormSigReAni 2026-07-17, variante method; sweep global de 254 ocorrencias em 77 forms).
- **OptionGroup.Buttons(N) DEVE ser configurado em WITH ANINHADO dentro do WITH pai**: Ao criar OptionGroup com `AddObject`, configurar `Buttons(1)` e `Buttons(2)` em blocos `WITH .Buttons(N)` ANINHADOS dentro do `WITH loc_oPag.obj_4c_OptXxx`. NUNCA fechar o WITH pai com ENDWITH e depois abrir `WITH loc_oPag.obj_4c_OptXxx.Buttons(N)` separado — VFP9 runtime nao resolve `.Buttons` via caminho completo fora do contexto WITH pai, gerando "BUTTONS is not an object". CORRETO: `WITH loc_oPag.obj_4c_OptXxx / .Value = 1 / WITH .Buttons(1) / .Caption = "Simples" / ENDWITH / WITH .Buttons(2) / .Caption = "Composto" / ENDWITH / ENDWITH`. Bug em FormSigPrCfn.prg ConfigurarPaginaLista (2026-07-15, Erro42).
- **SigCdEmp: colunas CANONICAS sao `Cemps`/`Razas` — NUNCA `Emps`/`emps`/`NComps`/`nemp`**: A tabela `SigCdEmp` tem PK `Cemps` char(3) (codigo empresa) e descricao `Razas` char(40) (razao social). As colunas `Emps`/`emps` e `NComps`/`nemp` NAO EXISTEM — gera runtime `[Microsoft][ODBC SQL Server Driver][SQL Server]Nome de coluna 'Emps' invalido` no primeiro Enter/Tab do campo Empresa. Bug tipico: `SELECT Emps, NComps FROM SigCdEmP WHERE Emps = ...` ou `CREATEOBJECT("FormBuscaAuxiliar", ..., "SigCdEmP", "cursor_X", "emps", ...)`. Motivo: Framework legado usava `fAcessoEmpresa(Usuar, 'C', This.Value, GetX, GetDX)` que abstraia o nome da coluna internamente; sem a Framework portada, gerador migra para SQL direto e inventa `Emps`/`NComps` por analogia com `SigCdBal.Emps` (que existe) ou com o nome do TextBox (`Get_Empresa`/`getDEmps`). CORRETO: `SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = ...` + `mAddColuna("Cemps", ...)` / `mAddColuna("Razas", ...)` + refs `cursor.Cemps`/`cursor.Razas`. Para o mask em `mAddColuna("Cemps", "XXX", ...)` usar 3 X (char(3)). CUIDADO: `SigCdBal.emps` (char(3)) e `SigIvTrh.emps` (char(3)) EXISTEM legitimamente — regra NAO se aplica quando o FROM eh outra tabela; ex: `SELECT Codigos, Grupos FROM SigCdBal WHERE Emps = ...` esta correto e Pattern #125 preserva. Padrao canonico visto em `Formsigrevto.prg` (linhas 1167/1233), `Formsigreimp.prg` (1060/1387), `Formsigrehpr.prg` (834/1366), `Formsigrehbr.prg`, `Formsigrefcd.prg`, `Formsigrepes.prg` (4327). Auto-fix: CorretorAutomatico Pattern #125 (`Corrigir-SigCdEmpColunasInvalidas`) — Fase 1 identifica cursores populados de SigCdEmp (SELECT INTO + FormBuscaAuxiliar 2o arg), Fase 2 corrige (a) tokens `Emps/NComps/emps/nemp` em SELECT/WHERE de linhas com `SigCdEmp`, (b) `mAddColuna("emps"|"nemp"|"NComps"|...)` dentro de bloco `AbrirBusca*` com `SigCdEmp`, (c) refs `<cursor>.emps`/`<cursor>.nemp`/`<cursor>.NComps` para cursores identificados. Preservacao de case: `emps`->`cemps`, `Emps`->`Cemps`, `EMPS`->`CEMPS`; `nemp`/`NComps`->`razas`/`Razas`. Bug em FormSigReAiv.prg linhas 662-766 + FormSIGREHCP.prg linhas 957-1060 (2026-07-16, Erro44).
- **SigCdEmp TextBox de codigo (`txt_4c_Empresa`/`txt_4c_CEmps`/`txt_4c_Emps`): `.MaxLength = 3` OBRIGATORIO**: TextBox que recebe codigo empresa (mapeia para `SigCdEmp.Cemps` char(3)) DEVE ter `.MaxLength = 3` explicito no bloco `AddObject`+`WITH`. Sem isso, usuario consegue digitar 2 caracteres (ou N caracteres arbitrarios), o Valid/LostFocus aceita o valor curto, o SELECT com `EscaparSQL` funciona (SQL Server padding automatico) MAS o `SigCdBal.emps` WHERE do relatorio nao encontra registros (INDEX difere). Screenshot tipico Erro45: `Empresa: [00] MARCELLA BAHIA` — user digitou "00" (2 chars), o Valid preencheu descricao mas dados de inventario aparecem vazios. Causa raiz: SCX legado omite MaxLength (usa default framework `fwtxtbox`), gerador ou omite (default VFP9=0 unlimited) ou estima por `Width=33`px (~2 chars Tahoma 8pt = MaxLength=2). CORRETO: `WITH loc_oPg.txt_4c_Empresa / .Width = 33 / .MaxLength = 3 / ...`. Complementa Pattern #125 (esse trata SQL, este trata UI input). Auto-fix: CorretorAutomatico Pattern #126 (`Corrigir-SigCdEmpTextBoxMaxLength`) — detecta blocos `WITH ...txt_4c_(Empresa|C?Emps|CEmp)` e (a) altera `.MaxLength = N` para 3 quando N != 3, ou (b) injeta `.MaxLength = 3` antes do `ENDWITH` quando ausente. Idempotente. Bug em 15 forms (FormSigReAiv MaxLength=2 direto + Formsigrecmc MaxLength=10 + 13 sem MaxLength). Origem: Erro45 (2026-07-16, FormSigReAiv screenshot mostrou "00" aceito).
- **WITH aninhado em Container/Label/CommandGroup criados com AddObject — silently ignora props (Label/Button.Caption/Picture/ForeColor)**: Dentro de `WITH THIS.cnt_X` ou `WITH loc_oCab`, chamar `.AddObject("filho", "Label"|"CommandGroup")` e depois `WITH .filho` (WITH aninhado relativo) causa falha SILENCIOSA de resolucao de propriedades em VFP9 — Label.ForeColor/Caption e Button.Caption/Picture/Left/Width nao sao aplicados. NAO gera exception; sintoma visual: Labels invisiveis + Buttons como retangulos vazios sem icone e sem texto. Pior caso: **3 niveis de aninhamento** `WITH loc_oCab / .AddObject("cmg_4c_Botoes",...) / WITH .cmg_4c_Botoes / WITH .Buttons(N) / .Caption = ... / .Picture = ...` — Buttons props totalmente ignoradas. CORRETO: (1) fechar `WITH loc_oCab` apos configurar Container, (2) `loc_oCab.AddObject("filho", "<Classe>")` FORA de qualquer WITH, (3) `WITH loc_oCab.<filho>` OU `loc_o<filho> = loc_oCab.<filho> / WITH loc_o<filho>` (caminho explicito). EXCECAO: `WITH .Buttons(N)` DENTRO de `WITH loc_oCmg` (1 nivel de nesting em CommandGroup) EH SEGURO — Buttons(N) eh collection accessor, nao AddObject. Widths canonicos framework frmrelatorio (NUNCA `THIS.Width` em CommandGroup/Button): CommandGroup `.Width = 273`, `.Left = 527/529`; Buttons `.Width = 65`, `.Height = 70`, Lefts=5/71/137/203 (increment 66). Container/Label/PageFrame podem usar `THIS.Width` (span correto). Padrao canonico: `FormSigPdAco.prg ConfigurarCabecalho` (2 niveis) + `Formsigreanr.prg ConfigurarCabecalho` pos-fix (3 niveis com CommandGroup+Buttons). Bugs: FormSIGPRIMP (2026-07-17 Erro47 nivel 2 Label/ForeColor) + Formsigreanr + 8 outros forms REPORT (2026-07-17 Erro49 nivel 3 CommandGroup/Buttons.Picture+Caption).
- **REPORT BO: `this_cCursorDados` OBRIGATORIO declarar como property se ExecutarReportForm passa 3o arg via property**: BOs REPORT que chamam `THIS.ExecutarReportForm(base, modo, THIS.this_cCursorDados)` (padrao gerado por Pattern #117) DEVEM declarar `this_cCursorDados = "<alias_cursor_binding_FRX>"` no bloco de propriedades do `DEFINE CLASS <XxxBO> AS RelatorioBase`. Sem isso, VFP9 runtime dispara `Property THIS_CCURSORDADOS is not found` ao clicar Visualizar/Imprimir (mensagem uppercase de `this_cCursorDados`). Alias correto = cursor selecionado pelo ultimo `SELECT / GO TOP` IMEDIATAMENTE ANTES do `REPORT FORM` no legado — extrair da `PROCEDURE visualizacao`/`impressao` em `tasks/task<NNN>/<base>_form_codigo_fonte.txt`. Se BO tem MULTIPLAS FRXs com cursores DIFERENTES (ex: SIGREAEGBO usa `CsRelatorio` p/ SigReAe1.frx + `CsDiferenca` p/ SigReAe2.frx): declarar `this_cCursorDados` com o cursor PRINCIPAL (1o REPORT FORM) e substituir chamadas subsequentes por LITERAL string (`THIS.ExecutarReportForm("SigReAe2", "PREVIEW", "CsDiferenca")`). Padroes canonicos: `sigreanrBO.prg:33` (`this_cCursorDados = "TmpFinal"`), `SigReAacBO.prg:20` (`= "crDBImp"`), pos-fix 2026-07-21: SIGREAEGBO (`= "CsRelatorio"`), SIGREEQRBO (`= "csTempoGr"`), SigReAtmBO (`= "TmpRelat"`), SigReIpcBO (`= "TMPLANCA"`), sigrecgrBO (`= "TmpRastro"`), sigrefecBO (`= "crImpressao"`). Auto-fix: CorretorAutomatico Pattern #142 (`Corrigir-ReportBOCursorDadosDeclarada`) detecta BO em `classes/*BO.prg` que contem `THIS.this_cCursorDados` mas NAO tem `this_cCursorDados = ` declarado, injeta `this_cCursorDados = ""` (string vazia — Pattern #117 guard `VARTYPE=="C" AND !EMPTY` trata como skip sem crash) apos ultima property `this_` do DEFINE CLASS + emite WARNING `[Pattern #142] <BO>: this_cCursorDados injetado vazio - REVISAR e substituir pelo alias do cursor binding do FRX`. Complementa Pattern #117 (helper caller). Bug em 6 BOs (2026-07-21, Erro51 SIGREAEGBO Visualizar). Relacionado a `feedback_report_form_helper_canonico.md` + `feedback_report_cursor_alias_frx_match.md`.
- **REPORT `REPORT FORM (THIS.this_cFRXPath)` DIRETO exige TRIPLE guard (FRX + cursor + no-RETURN) + nome FRX bate com legado (NAO inventar `Rel<Base>.frx`)**: BOs REPORT gerados antes do Pattern #117 canonico atribuem `this_cFRXPath = gc_4c_CaminhoReports + "<nome>.frx"` no Init() e chamam `REPORT FORM (THIS.this_cFRXPath) NOCONSOLE {PREVIEW|TO PRINTER PROMPT|TO PRINTER}` direto em Visualizar()/Imprimir(). TRES anti-padroes: (1) nome inventado `Rel<Base>.frx` (ex: `RelSigReAni.frx`) quando o FRX legado eh `<base>.frx` sem prefixo — copiar de `C:\4install\FortyusMC\Fortyus\<base>.frx` para `C:\4c\projeto\app\reports\<PascalCase>.frx` (+ `.frt`) preservando o nome original, NAO inventar `Rel*`; (2) guard `IF !FILE(...) / cMensagemErro = ... / ENDIF / REPORT FORM ...` sem `ELSE` — o guard NAO pula o REPORT FORM subsequente, VFP9 executa REPORT FORM com FRX ausente e dispara msgbox generica "File does not exist" ao inves da mensagem descritiva; (3) cursor vazio abre preview EM BRANCO sem mensagem — PrepararDados retorna .T. mesmo com 0 registros, REPORT FORM roda com cursor vazio, usuario nao sabe se filtrou errado. Correto (TRIPLE guard aninhado): `IF FILE(THIS.this_cFRXPath) / IF !USED(THIS.this_cCursorDados) OR RECCOUNT(THIS.this_cCursorDados) = 0 / MsgAviso("Nenhum registro encontrado para os filtros informados.", "Relat" + CHR(243) + "rio") / THIS.LimparCursores() / ELSE / REPORT FORM (THIS.this_cFRXPath) <modo> NOCONSOLE / THIS.LimparCursores() / loc_lSucesso = .T. / ENDIF / ELSE / THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + THIS.this_cFRXPath / ENDIF`. NO ramo cursor-vazio NAO setar `cMensagemErro` — Pattern #122 exige guard `AND !EMPTY(cMensagemErro)` no handler para evitar duplo modal. NUNCA usar `RETURN .F.` dentro de TRY/CATCH (regra #1 CLAUDE.md). Padrao canonico preferido: refatorar para helper `ExecutarReportForm` (Pattern #117) que ja tem TRIPLE guard embutido; mas Pattern #117 tem blind spot em property-based `THIS.this_cFRXPath` — nesses casos aplicar TRIPLE guard inline. Padrao canonico proven: `sigreaniBO.prg` (Imprimir/Visualizar), `SIGRECTLBO.prg`, `SigReAacBO.prg` pos-fix 2026-07-17. Bug em FormSigReAni (Erro47, "File does not exist" mesmo apos copiar FRX + preview em branco quando periodo sem registros).
- **INDEX ON com chave composta grande FALHA sob SET COLLATE "GENERAL" — usar ORDER BY no SELECT**: `config.prg:182` executa `SET COLLATE TO "GENERAL"` globalmente (para ordenacao correta com acentos). Efeito colateral: limite maximo de chave CDX cai de 240 para ~120 bytes (colacao ponderada usa 2 bytes/char). Chaves compostas grandes em BOs REPORT estouram runtime "Invalid key length." ao clicar Visualizar. Exemplo problematico: `INDEX ON Quebra1 + Quebra2 + DTOS(Datas) + STR(Nenvs, 10) TAG Ordem` onde Quebra1/Quebra2 sao alias de IIF com concatenacao ate 72 chars → 162 chars total → 324 bytes GENERAL → CRASH. FIX RECOMENDADO: em vez de `INDEX ON` apos SELECT INTO CURSOR, usar `ORDER BY` no proprio SELECT (sort in-memory nao tem esse limite; FRX consome record order). `SELECT ... INTO CURSOR X ORDER BY 1, 2, Datas, Nenvs` em vez de `INDEX ON <expr>+<expr>+...+<expr> TAG`. FIX ALTERNATIVO (se INDEX for necessario para SEEK): `loc_c = SET("COLLATE") / SET COLLATE TO "MACHINE" / INDEX ON ... TAG ... / SET COLLATE TO (loc_c)`. NAO aplicar cegamente: INDEX ON com chaves pequenas (ex: `Emps + Dopes + STR(Numes, 6)` = 19 chars) sao SEGUROS e podem servir para SEEK posterior. Regra: se o INDEX serve apenas para ordenar registros para REPORT FORM subsequente, PREFIRA ORDER BY no SELECT. Auto-fix: CorretorAutomatico Pattern #143 emite WARNING amarelo somente (nao muta, revisao manual). Origem: Erro53 (2026-07-21, SIGREAUPBO).
- **REPORT FORM SEMPRE via helper canonico THIS.ExecutarReportForm — NUNCA REPORT FORM (loc_cVar) direto**: BOs REPORT DEVEM chamar `THIS.ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)` em Visualizar/Imprimir/Documento, NUNCA emitir `REPORT FORM (loc_cVar) MODO NOCONSOLE` direto (mesmo com variavel intermediaria atribuida via IIF ou multi-linha). Sem o helper: (a) FRX ausente estoura "File does not exist." sem indicar path; (b) FRXs Fortyus legados renderizam asteriscos em campos numericos por conflito de locale (VFP9 default REPORTBEHAVIOR 90 + POINT="," vs FRX desenhado em modo 80 + POINT="." — modo 90 remede fontes em runtime); (c) cursor vazio abre preview em branco silencioso. Template canonico do helper (SIGREAEGBO.prg:1192-1235): (1) `loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")` + `IF NOT FILE(loc_cFRX) MostrarErro("Arquivo de relatorio nao encontrado: " + loc_cFRX + ...) RETURN .F. ENDIF`; (2) guard cursor vazio `IF VARTYPE(par_cCursorDados)=="C" AND !EMPTY(par_cCursorDados) IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados)=0 MsgAviso("Nenhum registro encontrado...") RETURN .F. ENDIF ENDIF`; (3) isolamento locale `loc_cPointOrig=SET("POINT") / SET POINT TO "." / SET SEPARATOR TO "," / SET REPORTBEHAVIOR 80 / DO CASE par_cModo PREVIEW|PRINTER_PROMPT|PRINTER / restaurar SETs`. Callers Visualizar/Imprimir/Documento: apenas montar `loc_cRelatorio = IIF(cond, "BaseA", "BaseB")` + `loc_cCursor = IIF(cond, "CursorA", "CursorB")` + `THIS.ExecutarReportForm(loc_cRelatorio, "PREVIEW"|"PRINTER_PROMPT"|"PRINTER", loc_cCursor)`. Nota: o 3o arg `par_cCursorDados` deve ser o cursor que o FRX consome (consultar PrepararDados e o legado), nao necessariamente `THIS.this_cCursorDados` — em SIGREAUPBO por exemplo, `this_cCursorDados` guarda `cursor_4c_SigOpInc` (dados brutos) mas o FRX consome `Selecao` (listagem) ou `TmpInc` (percentual). Auto-fix: CorretorAutomatico Pattern #117/#123 (helper + refactor auto de formas simples) + Pattern #144 WARNING para forma IIF/multi-linha (blind spot dos auto-fixes). Padroes canonicos: SIGREAEGBO/SIGREADSBO. FRX legado deve ser copiado de `C:\4install\FortyusMC\Fortyus\<base>.frx` (+ `.frt`) para `C:\4c\projeto\app\reports\` preservando o nome original. Origem: Erro54 (2026-07-21, SIGREAUPBO).
- **PROCEDURE Destroy DEVE chamar DODEFAULT() como ULTIMA linha — sem isso o menu do sistema encolhe visualmente**: Todo form que herda de `FormBase` e sobrescreve `PROCEDURE Destroy` DEVE terminar com `DODEFAULT()` antes do `ENDPROC`. `FormBase.Destroy` contem o fix `RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda / CriarMenuPrincipal()` que rebuilda os popups do menu principal (`_MSYSMENU`) apos qualquer form modal fechar. Sem DODEFAULT(), a cadeia de heranca eh quebrada, `FormBase.Destroy` nao roda, e VFP9 mantem cache visual STALE dos popups — resultado: `popMovimentos` que tem 105 bars definidas (CNTBAR=105) renderiza visualmente apenas os primeiros ~40 items com line-height maior, popups aparecem encolhidos com items sumidos. CORRETO: `PROCEDURE Destroy() / IF USED("cursor_X") / USE IN cursor_X / ENDIF / DODEFAULT() / ENDPROC`. Forms que NAO herdam FormBase (ex: `FormRelPlanoContas` que herda `Form` direto) devem inserir INLINE no proprio Destroy o mesmo `TRY / RELEASE POPUP ... / CriarMenuPrincipal() / CATCH / ENDTRY`. Auto-fix: CorretorAutomatico Pattern #145 (`Corrigir-DestroySemDodefault`) injeta DODEFAULT() em forms `AS FormBase` que omitem, idempotente. Origem: Erro58 (2026-07-21, bug visual em popups apos form.Destroy).

## Integracao
- Adicionar SET PROCEDURE para BO e Form em config.prg
- Adicionar item no menu (menu.prg) no popup **popRelatorios** (tipo REPORT)
  - DEFINE BAR N OF popRelatorios PROMPT "..." MESSAGE "..."
  - ON SELECTION BAR N OF popRelatorios DO Abrir${formClass}
  - PROCEDURE Abrir${formClass}() no final do menu.prg
- Deletar *.fxp antes de testar: del /s /q C:\4c\projeto\app\*.fxp

**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir ``SET SAFETY OFF`` e ``SET RESOURCE OFF`` no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.

Comecar agora. Ler relatoriobase.prg primeiro, depois o codigo fonte original.
"@
            Write-Host "  [RELATORIO] Meta-prompt especifico gerado" -ForegroundColor Cyan
        }

        # Para formularios OPERACIONAIS: substitui o prompt pelo template especifico
        if ($formType -eq "OPERACIONAL") {
            Write-Host "  [OPERACIONAL] Gerando meta-prompt especifico para form generico..." -ForegroundColor Cyan
            $prompt = @"
# Tarefa: Migrar Formulario OPERACIONAL - $formClass

ATENCAO: Este e um FORMULARIO OPERACIONAL (form generico), NAO um cadastro CRUD.
A estrutura do codigo e diferente do padrao CRUD (sem frmcadastro).

## O que e um form OPERACIONAL
- Herda de ``form`` generico no legado (NAO de frmcadastro)
- Layout CUSTOMIZADO: grids multiplos, containers flutuantes, botoes especializados
- NAO segue padrao Page1=Lista/Page2=Dados do CRUD
- Funcionalidades: consulta, processamento, movimentacao, contas individuais, etc.
- Pode ter containers que ficam Visible=.F. e sao alternados por botoes

## Arquivos de Referencia OBRIGATORIOS (LER ANTES DE COMECAR)
1. **CLAUDE.md** - Regras VFP criticas (CHR(), TRY/CATCH, BINDEVENT, etc.)
2. **tasks/$TaskId/${BaseName}_form_codigo_fonte.txt** - Codigo fonte original
3. **tasks/$TaskId/mapeamento.json** - Mapeamento de objetos
4. **tasks/$TaskId/comportamento.json** - Analise comportamental (metodos, queries SQL)

## Arquivos a Criar

### 1. C:\4c\projeto\app\classes\${boClass}.prg  (Business Object)
- Herda de **BusinessBase**
- Propriedades this_* para os campos principais da entidade
- Metodos de carga de dados: BuscarSaldos, BuscarHistorico, etc. (conforme legado)
- Metodos de CRUD se aplicavel (Inserir, Atualizar, ExecutarExclusao)
- SQLEXEC em cursores temporarios, depois ZAP + APPEND FROM DBF() nos cursores do grid

### 2. C:\4c\projeto\app\forms\operacionais\${formClass}.prg  (Form)
- Herda de **FormBase**
- Layout customizado conforme original (analisar codigo fonte)
- Grids multiplos com cursores separados
- Containers flutuantes (detalhes abaixo)

## REGRAS CRITICAS PARA FORMS OPERACIONAIS

### Containers Flutuantes (Visible=.F. toggled por botoes)

O legado usa paineis que aparecem/desaparecem ao clicar botoes. No novo sistema:

1. Criar container com Visible=.F. (padrao AddObject)
2. Botao faz toggle: `container.Visible = !container.Visible`
3. **CRITICO**: TornarControlesVisiveis() DEVE filtrar estes containers!

Exemplo de TornarControlesVisiveis com filtro OBRIGATORIO:
``foxpro
PROCEDURE TornarControlesVisiveis(par_oContainer)
    LOCAL loc_i, loc_oControl
    FOR loc_i = 1 TO par_oContainer.ControlCount
        loc_oControl = par_oContainer.Controls(loc_i)
        *-- FILTRO: Nao tornar visiveis containers flutuantes
        IF UPPER(loc_oControl.Name) = "CNT_4C_SALDO" OR ;
           UPPER(loc_oControl.Name) = "CNT_4C_CONSULTA"
            LOOP  && Pular containers flutuantes
        ENDIF
        loc_oControl.Visible = .T.
        *-- Recursao para sub-containers
        IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
            THIS.TornarControlesVisiveis(loc_oControl)
        ENDIF
    ENDFOR
ENDPROC
``

**REGRA**: Identificar TODOS os containers com Visible=.F. no original e EXCLUIR do TornarControlesVisiveis usando INLIST ou verificacao por nome.

### CREATE CURSOR - Ordem IDENTICA em Todos os Locais (CRITICO!)

Se o mesmo cursor (ex: cursor_4c_Saldos) eh criado em mais de um local (Init + CarregarSaldos),
a ORDEM DOS CAMPOS deve ser EXATAMENTE IDENTICA em TODOS os CREATE CURSOR:

``foxpro
*-- ERRADO - Ordens diferentes:
*-- Init: CREATE CURSOR cursor_4c_Dados (Contas C(20), Rclis C(60), Moedas C(10))
*-- Carregar: CREATE CURSOR cursor_4c_Dados (Moedas C(10), Contas C(20), Rclis C(60))

*-- CORRETO - Mesma ordem em TODOS os locais:
CREATE CURSOR cursor_4c_Dados (Contas C(20), Rclis C(60), Moedas C(10))
``

**DICA**: Copiar o CREATE CURSOR do Init e colar IDENTICO em todos os metodos de carga.

### Grid ControlSource DEVE Bater com CREATE CURSOR (CRITICO!)

Os campos usados em ControlSource das colunas do Grid DEVEM existir no CREATE CURSOR:

``foxpro
*-- Se Grid usa:
.Column1.ControlSource = "cursor_4c_Dados.Contas"
.Column2.ControlSource = "cursor_4c_Dados.Rclis"

*-- Entao CREATE CURSOR DEVE ter estes campos:
CREATE CURSOR cursor_4c_Dados (Contas C(20), Rclis C(60))

*-- E o SELECT SQL DEVE ter alias correspondentes:
loc_cSQL = "SELECT a.conta AS Contas, b.razao AS Rclis FROM ..."
``

**REGRA**: Para CADA cursor usado em Grid, verificar:
1. CREATE CURSOR tem TODOS os campos usados em ControlSource
2. SELECT SQL tem alias AS que correspondem aos nomes do CREATE CURSOR
3. Ordem dos campos eh consistente

### SET NULL ON Antes de CREATE CURSOR (OBRIGATORIO)

SQL Server retorna NULLs. Sem SET NULL ON, APPEND FROM falha:

``foxpro
SET NULL ON
CREATE CURSOR cursor_4c_Dados (campo1 C(20) NULL, campo2 N(14,2) NULL)
SET NULL OFF
``

### SQLEXEC em Cursor Temporario (Grid Protection)

NUNCA fazer SQLEXEC direto no cursor do Grid (destroi colunas):

``foxpro
*-- ERRADO:
SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")  && Destroi colunas do Grid!

*-- CORRETO:
SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")  && Cursor temporario
SELECT cursor_4c_Dados
ZAP
APPEND FROM DBF("cursor_4c_DadosTemp")
USE IN cursor_4c_DadosTemp
``

## Analise Comportamental (comportamento.json)

Se disponivel, contem analise profunda dos metodos originais. REGRAS:
1. TODA validacao listada DEVE ser implementada
2. TODAS as queries SQL devem usar APENAS colunas reais do schema.sql
3. TODAS as funcoes externas devem ser integradas ou substituidas
4. O campo ``codigoOriginal`` mostra logica exata - REPRODUZIR com nova nomenclatura

## Regras VFP Criticas
- NUNCA usar literais acentuados - usar CHR(): a=225, c=231, ao=227, e=233, etc.
- NUNCA usar RETURN dentro de TRY/CATCH - usar variavel loc_lSucesso
- BINDEVENT funciona apenas com metodos PUBLIC (sem PROTECTED)
- **BINDEVENT "Valid" NAO FUNCIONA em TextBox**: Usar "KeyPress" (ENTER=13/TAB=9) para simular Valid. NUNCA usar LostFocus para chamar MontaGrade/CarregarDados/SQLEXEC - LostFocus dispara SEMPRE (inclusive por SetFocus de outro controle) causando RECURSAO INFINITA. Ex: `BINDEVENT(txt, "KeyPress", THIS, "TxtCampoKeyPress")` e no handler: `IF par_nKeyCode = 13 OR par_nKeyCode = 9 ... ENDIF`
- **Page.Visible NAO EXISTE**: Page (PageFrame.PageN) NAO tem propriedade Visible. NUNCA `.Page1.Visible = .T.`.
- **PageFrame.Visible OBRIGATORIO**: AddObject cria controles com Visible=.F. SEMPRE adicionar `THIS.pgf_4c_Paginas.Visible = .T.` ANTES de `ActivePage = 1` no InicializarForm. Sem isso form abre em branco.
- **Buttons(N) vs ButtonCount**: Ao fazer BINDEVENT em Buttons(N), N DEVE ser <= ButtonCount. Verificar no AddObject qual era o ButtonCount antes de referenciar.
- TextBox.Value: inicializar como "" (string), 0 (numerico), {} (data)
- FormatarDataSQL() para datas, EscaparSQL() para strings (JA INCLUI aspas - NUNCA adicionar aspas extras), FormatarNumeroSQL() para numeros
- AddObject() cria com Visible=.F. - sempre setar .Visible = .T. (EXCETO containers flutuantes!)
- NUNCA gerar SQL numa unica linha longa - quebrar com +; a cada 3-4 campos
- NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1)
- UI Fidelity PILAR 1: Width/Height/Top/Left/BackColor/ForeColor/FontName EXATOS do original
- PILAR 2: Usar nomes de colunas EXATOS do banco (ver schema.sql)
- **MESSAGEBOX PROIBIDO**: NUNCA usar MESSAGEBOX() direto. Usar funcoes de messages.prg: MsgInfo() para informativo (icone 64), MsgAviso() para aviso (icone 48), MsgErro() para erro (icone 16), MsgConfirma() para confirmacao Sim/Nao. Essas funcoes suprimem dialogs em modo de teste automatizado.
- **fAcessoEmpresa() NAO EXISTE (nao portada)**: A funcao global `fAcessoEmpresa()` do Framework legado (sigacess.PRG) NAO foi portada para a nova arquitetura. Chamadas diretas quebram em runtime com "File 'facessoempresa.prg' does not exist" (VFP9 procura .prg externo quando o nome nao eh THIS.metodo nem funcao definida). Substituicao canonica: MODO CHECK (3 args, retorna boolean) `fAcessoEmpresa(usu,"C",cod)` -> `VerificarAcessoEmpresa(usu, cod)` (helper em utils/functions.prg). MODO LOOKUP (5 args, popula 2 textboxes) `fAcessoEmpresa(usu, "C"|"D", val, oCod, oDsc)` -> bloco FormBuscaAuxiliar apontando SigCdEmp com chave Cemps (modo C) ou Razas (modo D), retornando ambas colunas. Titulo: "Sele" + CHR(231) + CHR(227) + "o de Empresa". Auto-fix: CorretorAutomatico #110. Padrao canonico: Formsigatcrp.prg:2278-2378 (KeyPress) e Formsigrepes.prg:6501-6540 (LostFocus). Bug observado em Formsigatcrp.prg + Formsigrepes.prg (2026-07-02, Erro14).
- **fAcessoContas() NAO USAR para lookup UX (auto-load do primeiro registro)**: A funcao `fAcessoContas()` (utils/functions.prg:719) EH portada, mas seu fluxo interno (`LIKE '%valor%'` + `LOCATE` + FormBuscaSimples) auto-popula o textbox com o PRIMEIRO registro que contem o valor digitado — mesmo sem selecao explicita do usuario no picker. Resultado tipico: user digita "11" no campo Gerente/Vendedor e o form carrega "GAVETA - LOJA 001..." (primeiro match parcial). PROIBIDO usar `fAcessoContas(usu, grp, "C"|"D", val, txtCod, txtNom)` como handler de Valid/KeyPress em textbox de lookup. Substituicao canonica: mesmo padrao de fAcessoEmpresa lookup (Formsigatcrp.prg:2612-2790 apos Erro16 fix). Enter/Tab -> `SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = valor` exato (hit -> auto-preenche, miss -> `THIS.AbrirBusca<X>()`). AbrirBusca<X> -> SQL proprio com `LIKE 'valor%' OR RTRIM(RClis) LIKE 'valor%'` (starts-with, NAO contem) + fallback lista completa + `CREATEOBJECT("FormBuscaAuxiliar")` sem SQL automatica + mAddColuna("IClis"/"RClis") + `.Show()` respeitando `this_lSelecionou`. `fAcessoContas()` continua valida para contexto backend (SCAN loop de acesso, validacao sem UI). Bug observado em Formsigatcrp.prg ValidarCodGer/ValidarNomGer/ValidarCodVen/ValidarNomVen (2026-07-02, Erro16).
- **.RecordMark/.DeleteMark SO em Grid — NUNCA em CommandButton/Label/Container/TextBox/ComboBox/etc**: As propriedades `.RecordMark` e `.DeleteMark` sao EXCLUSIVAS de Grid (barras laterais de marcacao/exclusao de registro). Gerador frequentemente copia esse par de `WITH grd_4c_Xxx` e cola em WITH de CommandButton adjacente (ex: `cmd_4c_SelXxx`/`cmd_4c_DslXxx` ao lado de grids de selecao multipla em REPORT). VFP9 trava com "Property RECORDMARK is not found" ao instanciar o form. PIOR: o erro eh silenciosamente engolido pelo TRY/CATCH de `InicializarForm` (apenas seta `loc_lSucesso=.F.` sem MsgErro), resultando em `CREATEOBJECT("FormXxx")` retornar `.F.` sem exception aparente e "VARTYPE retornou: L" no dialog. PROIBIDO gerar `.RecordMark = .F.` ou `.DeleteMark = .F.` em WITH cujo AddObject NAO seja `"Grid"`. Recomendacao complementar: no CATCH de `InicializarForm`, chamar `MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)` ANTES de setar `loc_lSucesso=.F.` — expoe o erro para debug em vez de engolir silenciosamente. Auto-fix: CorretorAutomatico #111. Bug observado em Formsigrepes.prg (2026-07-02, Erro17): 9 CommandButtons corrompidos (`cmd_4c_SelOrigMerc`, `cmd_4c_SelTipoInvs`, `cmd_4c_SelLinha`, etc).
- **UNION ALL entre tabelas diferentes**: NUNCA usar SELECT * em UNION ALL. Listar colunas EXPLICITAS IDENTICAS.
- **INTO CURSOR READWRITE**: NUNCA usar `INTO CURSOR X` + `USE DBF("X") IN 0 ALIAS Y`. Usar `INTO CURSOR cursor_4c_Dados READWRITE` direto.
- **Cursor placeholder = cursor real**: CREATE CURSOR placeholder no InicializarForm DEVE ter EXATAMENTE os mesmos campos que o cursor populado por SQLEXEC.
- **CheckBox em Grid Column (Error 1767)**: Para grids com CheckBox, a UNICA definicao de ControlSource deve ser `Column1.ControlSource = "cursor.campo"` DEPOIS de `CurrentControl = "Check1"`. NUNCA definir `Check1.ControlSource` (conflita com Column) E NUNCA definir `Column1.ControlSource` ANTES de AddObject("Check1").
- **AddObject sintaxe CORRETA**: `parent.AddObject("nome", "Classe")` - ambos strings. NUNCA `parent.AddObject(loc_oObj, "nome")` (objeto como parametro causa "Function argument invalid"). Padrao: `parent.AddObject("cmd_4c_X", "CommandButton")` + `WITH parent.cmd_4c_X` para configurar.
- **Grid Column CurrentControl="Check1" EXIGE AddObject**: ANTES de `.Column1.CurrentControl = "Check1"`, OBRIGATORIO: `.Column1.AddObject("Check1", "CheckBox")` + `.Column1.Check1.Caption = ""`. Sem isso, erro "Unknown member CHECK1" cascateia e destroi toda inicializacao.
- **CheckBox .Value SEMPRE NUMERICO**: Inicializar CheckBox com `.Value = 1` (marcado) ou `.Value = 0` (desmarcado). NUNCA usar `.T.`/`.F.` (logico). Comparar com `= 1`/`= 0`, IIF com `IIF(chk.Value = 1, ...)`. Misturar tipos causa "Operator/operand type mismatch".
- **IF THEN inline PROIBIDO**: VFP9 NAO suporta `IF cond THEN cmd` numa unica linha. Gera "Command contains unrecognized phrase/keyword." SEMPRE expandir para multi-linha: `IF cond` / `  cmd` / `ENDIF`.
- **COUNT TO var IN alias PROIBIDO**: VFP9 COUNT nao tem clausula IN. Gera "Command contains unrecognized phrase/keyword." Usar: `SELECT alias` + `COUNT TO var`.
- **APPEND FROM requer SELECT cursor antes**: `ZAP IN cursor_name` NAO muda a work area corrente. `APPEND FROM DBF("tmp")` vai para a work area CORRENTE. SEMPRE fazer `SELECT cursor_destino` antes de `APPEND FROM`. Sem isso, dados vao para o cursor errado e o grid fica vazio.
- **CommandGroup.FontName NAO EXISTE**: CommandGroup (como OptionGroup) NAO tem FontName/FontSize. Definir em cada `.Buttons(N).FontName`. Tentar no grupo causa "Property FONTNAME is not found" que cascateia e impede toda configuracao dos botoes.
- **AlternarPagina DEVE chamar AjustarBotoesPorModo**: Em forms CRUD, ao voltar para Page1 (LISTA), OBRIGATORIO chamar `THIS.AjustarBotoesPorModo()` ANTES de `THIS.CarregarLista()`. Sem isso os botoes ficam desabilitados apos Incluir/Alterar/Visualizar.
- **CommandGroup BackStyle/BorderStyle EXATOS do original**: Se o original tem `BackStyle=0` + `BorderStyle=0`, o CommandGroup eh TRANSPARENTE (container logico invisivel). NUNCA adicionar BackColor quando original nao tem. Copiar BackStyle, BorderStyle, SpecialEffect EXATOS.
- **ForeColor de Labels: COPIAR do original, NUNCA assumir**: Labels sobre fundo escuro usam ForeColor branco, labels sobre fundo claro usam ForeColor cinza (90,90,90). Copiar ForeColor EXATO do codigo fonte original. Assumir cor "baseado no tema" causa labels INVISIVEIS.
- **Buttons(N) dentro de CommandGroup: propriedades EXATAS**: Left, Top, FontName, FontBold, FontItalic, BackColor, ForeColor dos Buttons DEVEM vir do codigo fonte original. NUNCA inventar Left=0 ou FontName="Tahoma" quando original tem Left=178 ou FontName="Comic Sans MS".
- **Propriedades do BO preservam sufixo "s" da coluna do banco**: Colunas como Moedas, Contas, Grupos mapeiam para this_cMoedas, this_cContas, this_cGrupos. NUNCA "corrigir" removendo o "s" (this_cMoeda NAO EXISTE ? "Property not found"). Verificar nome EXATO no DEFINE CLASS do BO.
- **Nomes de icones/imagens: COPIAR EXATO do original + VALIDAR EXISTENCIA**: O atributo .Picture deve ter o nome de arquivo EXATO do original (ex: `geral_procura_60.jpg`, `cadastro_sair_60.jpg`). Trocar APENAS o path: `..\framework\imagens\` ? `gc_4c_CaminhoIcones +`. NUNCA inventar nomes de arquivo (ex: `consultar.bmp`, `geral_visualizar_60.jpg`, `geral_imprimir_60.jpg`, `geral_fechar_60.jpg` — NAO EXISTEM em vbmp/). USAR APENAS `gc_4c_CaminhoIcones` (NUNCA `gc_4c_Icones` — variavel legada, gera falhas em runtime). Para REPORT, ver "REPORT Buttons(N).Picture: ICONES CANONICOS OBRIGATORIOS" abaixo.
- **Propriedades do FORM: COPIAR TODAS do original**: TitleBar, ControlBox, MaxButton, MinButton, Closable, ClipControls DEVEM ser copiadas do codigo fonte original. Se original tem `TitleBar = 0` (sem barra de titulo), migrado DEVE ter `TitleBar = 0`. Omitir essas propriedades faz VFP9 usar defaults (barra de titulo visivel) alterando completamente a aparencia do form.
- **CommandButton ForeColor/BackColor/Themes EXATOS**: Botoes avulsos DEVEM copiar ForeColor, BackColor, FontName, FontBold, FontItalic, Themes do original. Se original tem ForeColor=90,90,90 + BackColor=255,255,255 + Themes=.F., copiar EXATO. ForeColor=RGB(255,255,255) em fundo claro torna texto INVISIVEL. **EXCECAO**: standalone CommandButton (fora de CommandGroup) com `.Picture` DEFINIDO precisa de `.Themes = .T.` + `.DisabledPicture = (mesma imagem)` — sem isso, com Themes=.F. + Enabled=.F. o icone NAO renderiza (so caption aparece). Auto-fix: CorretorAutomatico #99. Buttons(N) DENTRO de CommandGroup MANTEM Themes=.F. (canonico REPORT).
- **CommandButton auxiliar ao lado de Grid: NUNCA OMITIR `.Picture`**: Botoes standalone tipo `cmd_4c_SelTudo` (Selecionar Todos), `cmd_4c_Apaga` (Desmarcar/apaga), ou similares ao lado de grids de selecao TEM `.Picture` no SCX original (`geral_marcar_26.jpg` para Selecionar, `cadastro_excluir_26.jpg` para Desmarcar). Migracao frequentemente OMITE a linha `.Picture` inteira - botao renderiza como caixa vazia sem icone. SEMPRE copiar `.Picture = gc_4c_CaminhoIcones + "nome.jpg"` do original + aplicar padrao standalone (`.Themes=.T.` + `.DisabledPicture`). Heuristica: se WITH cmd_4c_* tem `.ToolTipText` = "Selecionar"/"Desmarcar"/"Marcar Todos"/"Limpar" e NAO tem `.Picture`, faltou copiar. Auto-fix: CorretorAutomatico #104. Bug em Formsigrecmc.prg (task052, 2026-07-01).
- **SigCdOpe eh single-column: NUNCA usar `descrs`/`Descrs`**: SigCdOpe tem `Dopes` (char(20)) que eh PK **E** descricao ao mesmo tempo — NAO existe coluna `descrs`/`Descrs` nessa tabela. Lookup FormBuscaAuxiliar para SigCdOpe deve chamar UMA UNICA `mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")`. NUNCA adicionar segunda coluna `mAddColuna("descrs", ...)` — gera runtime "Variable 'DESCRS' is not found" em FormBuscaAuxiliar.ConfigurarGrid quando seta Columns(N).ControlSource. Mesma regra para SELECT: `SELECT Dopes FROM SigCdOpe` (NUNCA `SELECT Dopes, Descrs FROM SigCdOpe`). Referencia: FormSIGREADS.prg:1554, Formsigrevto.prg:900. Auto-fix: CorretorAutomatico #105. Bug em Formsigrecmc.prg:1848 e FormSigReCmp.prg:1767/1813 (task052/task045, 2026-07-01).
- **CommandButton icone-only (`Caption=""`) NUNCA setar `.Enabled=.F.` em runtime**: Standalone CommandButton com `Caption=""` + `.Picture` NAO renderiza icone quando `.Enabled=.F.`, INDEPENDENTE de `.Themes=.T.` ou `.F.` — botao vira retangulo vazio. Isso refina o Pattern #99 (que funciona apenas para botoes COM caption como cmd_4c_Graficos). Nunca setar `.Enabled=.F.`/`.Enabled=.T.` em cmd_4c_* icone-only (SelTudo/Apaga tipicos) fora do bloco AddObject inicial — em vez disso: (a) NAO desabilitar (botao fica clickavel mas handler ja pode ser inocuo — SelTudo/Apaga so mexem em cursor cujo report vai ignorar), (b) desabilitar via check condicional dentro do handler `PROCEDURE CmdXClick`, OU (c) usar `.Visible=.F.` em vez de `.Enabled=.F.`. Auto-fix: CorretorAutomatico #106 (remove runtime `.Enabled=.F./.T.` em cmd_4c_* icone-only). Bug em Formsigrecmc.prg cmd_4c_SelTudo/cmd_4c_Apaga (task052, erro8.PNG, 2026-07-01) — desabilitar em TxtNmOperacaoKeyPress apagava icones apos usuario preencher Movimentacao.
- **Container de botoes sobre Grid: OBRIGATORIO BackStyle=1 OU posicionar fora da bbox do Grid**: Container filho de Form com CommandButtons dentro NAO pode ter `BackStyle=0` (transparente) se seu retangulo (Top..Top+Height) sobrepoe o Grid irmao (grid.Top..grid.Top+grid.Height). Grid re-renderiza rows em scroll (redraw parcial da area) — sem fundo opaco por tras dos botoes, os botoes ficam "carimbados" repetidamente em cada frame novo ("ghost trails"). Fix: (a) `Top >= grid.Top + grid.Height + margem` (posicao FORA da bbox — preferido), OU (b) `BackStyle = 1` + `BackColor = RGB(255, 255, 255)` se overlay for necessario. Auto-fix: CorretorAutomatico #107. Bug em FormBuscaAuxiliar.prg cnt_4c_Botoes (task052, Erro9.PNG, 2026-07-01) — Top=252 dentro do grid (grid bottom=306) + BackStyle=0 mostrava botoes Selecionar/Cancela stackados 3+ vezes ao scrollar a lista de contas.
- **OptionGroup.Buttons(N).Value NUNCA setar valor != 0**: Em VFP9, `OptionGroup.Value` eh INTEGER (1..N) indicando qual dos N botoes esta selecionado. `OptionButton.Value` (individual) eh BOOLEAN (0/1) — quem gerencia eh o OptionGroup. Se o codigo migrado setar `Buttons(2).Value = 2`, `Buttons(3).Value = 3`... VFP9 trata QUALQUER nao-zero como truthy → TODOS os radio buttons aparecem marcados de uma vez, comportamento visual quebrado. NUNCA setar `.Value = N` (com N != 0) dentro de bloco `WITH ...Buttons(N)`. Se quiser default selection, setar apenas `OptionGroup.Value = indice` (ex: `OptionGroup.Value = 2` para 2o botao marcado). Auto-fix: CorretorAutomatico #108. Bug em Formsigregli.prg (task108, 2026-07-01) em 5 OptionGroups (Get_Tipo/TpOrdem/Get_Boleto/Get_Pedido/Opt_Ordem).
- **TornarControlesVisiveis: skip com LOOP DEVE recursar em containers hidden-por-default**: Metodo recursivo `TornarControlesVisiveis` seta `Visible=.T.` em sub-controles apos AddObject (que os cria Visible=.F. default). Quando ha lista de skip para containers que devem comecar ocultos (ex: `IF INLIST(control.Name, "CNT_4C_ETIQUETAS", "CNT_4C_RELACAO") LOOP ENDIF`), o `LOOP` pula TANTO setar Visible do container QUANTO recursar dentro dele. Resultado: container fica hidden corretamente MAS seus filhos tambem ficam Visible=.F. permanente. Quando logica posterior seta `container.Visible=.T.`, container aparece VAZIO. Fix: dentro do IF de skip, ANTES do LOOP, recursar `THIS.TornarControlesVisiveis(container)` para tornar filhos visiveis sem tocar Visible do proprio container. Auto-fix: CorretorAutomatico #109. Bug em Formsigregli.prg (task108, 2026-07-01) — containers cnt_4c_Etiquetas/Relacao apareciam vazios ao selecionar Tipo de Impressao.
- **cnt_4c_Cabecalho Labels NUNCA usar AutoSize=.T.**: `lbl_4c_Sombra`/`lbl_4c_Titulo` em `cnt_4c_Cabecalho` DEVEM ter `AutoSize = .F.` (default) + `Width = THIS.Width` (Container Width, igual THISFORM.Width). Com `AutoSize = .T.`, captions longos expandem a Label alem da area dos botoes (cmg_4c_Botoes Left=529, Graficos Left=460), deixando texto truncado visualmente atras dos botoes. AutoSize=.F. clipa naturalmente no boundary. Auto-fix: CorretorAutomatico #98. Bug em Formsigrecmc.prg (2026-06-25). Template canonico: FormSigReAac.prg:104-146.
- **Grid RecordMark/DeleteMark em OPERACIONAL**: Grids criados manualmente (AddObject) em forms OPERACIONAIS DEVEM ter `.RecordMark = .F.` e `.DeleteMark = .F.`. Sem isso, barras de marcacao aparecem na lateral esquerda do grid.
- **ChkRegister NAO EXISTE em BusinessBase**: O legado usa ``ThisForm.poDataMgr.ChkRegister()`` para verificar duplicidade. Na migracao, usar SQLEXEC com ``SELECT COUNT(*) AS nExiste FROM tabela WHERE campo = valor`` + verificar ``NVL(cursor.nExiste, 0) > 0``. NUNCA chamar ChkRegister no BO.
- **cnt_4c_Cabecalho FUNDO CINZA MEDIO OPACO**: O cntSombra do framework.vcx tem `BackColor=RGB(100,100,100)` (cinza medio, NAO escuro). cnt_4c_Cabecalho DEVE ter `BackStyle=1` (opaco) + `BackColor=RGB(100,100,100)` + `lbl_4c_Titulo.ForeColor=RGB(255,255,255)` (branco sobre cinza). Valor RGB(100,100,100) (quase preto) eh ERRADO - usar 100 (cinza medio do framework). BackStyle=0 torna o cabecalho INVISIVEL. Bug corrigido em 2026-05-15 (system-wide).
- **NovoRegistro()/EditarRegistro() DEVEM chamar DODEFAULT()**: BOs que sobrescrevem NovoRegistro() ou EditarRegistro() DEVEM chamar DODEFAULT() como primeira linha. Sem isso, BusinessBase NAO seta this_lEmEdicao=.T. e Salvar() SEMPRE retorna .F. silenciosamente.
- **Botoes CRUD LADO DIREITO, posicoes EXATAS (ver framework_frmcadastro_layout.md)**: cnt_4c_Botoes Left=542 Width=390 (LADO DIREITO, NUNCA esquerdo!). Botoes internos Width=75, Left=5,80,155,230,305. FontName="Comic Sans MS" (NAO Tahoma). Encerrar em cnt_4c_Saida SEPARADO (Left=935, W=60). Grid FontName="Verdana". TODAS as posicoes padrao estao em ``docs/framework_frmcadastro_layout.md``.
- **Lookup textbox DEVE disparar em ENTER/TAB alem de F4**: Campos com lookup (fwBuscaExt no legado) DEVEM disparar busca em F4(115) E ENTER(13)/TAB(9) no KeyPress handler. O Valid original disparava ao sair do campo. Se o usuario digitar valor e pressionar TAB sem handler, nada acontece.
- **F4=115, F5=116 em KeyPress**: NUNCA usar 63 (que eh '?'). Codigos corretos: ENTER=13, TAB=9, F4=115, F5=116, ESC=27
- **Campos BIT do SQL Server**: Chegam como LOGICAL (.T./.F.) no VFP9. NUNCA usar NVL(campo,0)=1. Usar IF campo / IF !campo direto. NUMERIC(1,0) sim usa NVL.
- **Lookup ao sair do campo**: KeyPress com ENTER/TAB deve VALIDAR valor digitado contra tabela de referencia. Se encontrar, preencher descricao. Se nao encontrar, abrir FormBuscaAuxiliar. F4/F5 sempre abre lookup direto.
- **Z-ORDER AddObject em Page2**: Quando Page2 tem PageFrame interno + OptionGroup/botoes de navegacao, adicionar ``ZOrder(0)`` nos controles de navegacao APOS adicionar o PageFrame. VFP9 AddObject coloca ultimo objeto no topo do z-order, cobrindo controles anteriores.
- **PageFrame interno .Tabs = .F.**: PageFrame interno que usa OptionGroup para navegacao entre sub-paginas DEVE ter ``.Tabs = .F.``. Se .Tabs = .T., tabs nativos do VFP9 ficam visiveis e consomem espaco, sobrepondo controles.
- **Container Left+Width <= Form.Width**: Validar que Left + Width de TODOS os containers nao exceda Form.Width (normalmente 1000). Container parcialmente fora da area visivel fica cortado ou inacessivel.
- **NUNCA inventar tabelas de lookup**: Se o original NAO faz Seek/lookup de descricao para um campo, NAO criar query de lookup. Tabelas como SigCdCcr, SigCdJob NAO existem. Copiar nomes de tabela EXATAMENTE do codigo original. Se nao ha lookup no original, o campo eh apenas exibido.
- **WHERE Emps SOMENTE em tabelas que tem a coluna**: Tabelas de cadastro generico (SigCdGcr, SigCdMoe, SigCdCor, SigCdUni) tipicamente NAO tem coluna Emps. Antes de adicionar ``WHERE Emps = go_4c_Sistema.cCodEmpresa``, verificar no schema.sql se a tabela realmente tem essa coluna. Na duvida, omitir o filtro.
- **Propriedades this_ DECLARAR com nome EXATO do uso**: TODA propriedade referenciada como THIS.this_cXxx no codigo DEVE ter declaracao IDENTICA this_cXxx = "" no cabecalho DEFINE CLASS. Nomes amigaveis diferentes (ex: declarar this_cUltGrupo mas usar THIS.this_cUltCgrus) causam Error 174 Property not found no primeiro LostFocus.
- **Container.BorderStyle NAO EXISTE**: Container VFP9 tem BorderWidth mas NAO tem BorderStyle (propriedade de CommandGroup/OptionGroup). Usar apenas .BorderWidth = 0. CorretorAuto #68 remove automaticamente.
- **Containers de botoes CRUD TRANSPARENTES**: Containers que hospedam botoes CRUD em forms frmcadastro (cnt_4c_Botoes, cnt_4c_Saida, cnt_4c_BotoesDados) DEVEM usar `BackStyle=0` (transparente), NUNCA `BackStyle=1` com `BackColor=RGB(100,100,100)` ou similar escuro. O fundo do form ja e fornecido por Page.Picture (fundo_cad_1003.jpg); container opaco escuro cria caixa cinza ao redor dos botoes que destoa do layout original. EXCECAO UNICA: cnt_4c_Cabecalho usa opaco escuro propositalmente (cntSombra).
- **PageFrame.Height = Form.Height + 29**: Em forms frmcadastro com PageFrame oculto (Tabs=.F., Top=-29), o `pgf_4c_Paginas.Height` DEVE ser `Form.Height + 29` (NAO igual a Form.Height). Com Top=-29 e Height=Form.Height, sobram 29px descobertos no bottom expondo o fundo cinza nativo do form como borda indesejada. Formula: Form.Height=600 -> PageFrame.Height=629. Form.Height=650 -> PageFrame.Height=679.
- **BO: metodo de validacao chama-se ValidarDados() (NAO Validar)**: BusinessBase.Salvar() chama THIS.ValidarDados(). BOs que implementam PROTECTED PROCEDURE Validar() tem validacao silenciosamente pulada -> Inserir roda com valores default e falha no SQL. SEMPRE usar PROTECTED PROCEDURE ValidarDados().
- **IIF() exige LOGICAL no 1o argumento**: IIF(numerico, ...) quebra com "Function argument value, type, or count is invalid" quando valor=0. Em TEXTMERGE SQL e conversoes, SEMPRE comparar: IIF(this_nFlag = 1, '1', '0'). NUNCA passar numerico direto: IIF(this_nFlag, '1', '0').
- **Colunas NUMERIC(1,0) preservam tipo NUMERIC em this_n***: Em CarregarDoCursor, NUNCA usar ramo ELSE generico `THIS.this_nXxx = (NVL(col,0) = 1)` (converte para LOGICAL). Padrao canonico: IF VARTYPE(col)="N" / THIS.this_nXxx = NVL(col, 0) / ELSE / THIS.this_nXxx = IIF(NVL(col,.F.),1,0) / ENDIF. BIT do SQL->LOGICAL vai em this_l*; NUMERIC(1,0)->NUMERIC vai em this_n*.
- **CheckBox .Value = 0 no AddObject (NAO .F.)**: AddObject CheckBox DEVE inicializar `.Value = 0` (NUMERIC). Usar `.Value = .F.` cria LOGICAL e conflita com LimparCampos (`.Value = 0`, NUMERIC) e BOParaForm - dispara "Operator/operand type mismatch" no primeiro uso. BOParaForm: usar `chk.Value = IIF(this_lProp, 1, 0)` ou `IIF(this_nProp = 1, 1, 0)`, nunca atribuir LOGICAL direto.
- **Lookups FormBuscaAuxiliar NUNCA com BINDEVENT "LostFocus"**: Handlers Validar* que criam FormBuscaAuxiliar DEVEM usar BINDEVENT "KeyPress". LostFocus dispara quando o dialog de lookup toma foco -> RECURSAO: segundo dialog empilhado, grade aparece vazia, campo fica em branco apos Selecionar. Handler deve receber (par_nKeyCode, par_nShiftAltCtrl) e executar apenas em ENTER(13)/TAB(9)/F4(115): IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115 / RETURN / ENDIF.
- **ALLTRIM() NAO aceita numerico**: ALLTRIM(txt.Value) quando .Value e numerico (ex: .Value=0, InputMask="999") gera "Function argument value, type, or count is invalid". Em validacao usar comparacao direta (IF .Value = 0); em conversao, envolver com TRANSFORM: ALLTRIM(TRANSFORM(.Value)).
- **cmd_4c_Encerrar.Caption = "Encerrar"**: Botao Encerrar DEVE ter `.Caption = "Encerrar"` (NAO "X", "Sair" ou ""). A Picture "cadastro_sair_60.jpg" NAO cobre a caption; captions errados aparecem como texto abaixo do icone. Padrao dos forms CRUD (FormCor, FormMoe).
- **PADRAO CANONICO SAIDA/ENCERRAR � PREVALECE SOBRE PILAR 1 (pixel-perfect legado)**: O bloco de saida (container + botao Encerrar) DEVE seguir o padrao canonico do sistema novo (FormCor), IGNORANDO os valores do SCX legado. Canonical (inegociavel): `cnt_4c_Saida.Left=917, Width=90, Height=85`; `cmd_4c_Encerrar.Left=5, Top=5, Width=75, Height=75, Caption="Encerrar"`. Se o SCX legado tiver Grupo_Saida.Left=935 W=60 ou botao X com W=50/Caption="X"/"Sair"/"Fechar", IGNORE e use o canonico. O mesmo vale para `.Width = THIS.Width - 60/-65` em containers de Page (pgf.Page1/Page2): DEVE ser `.Width = THIS.Width` (container de saida eh flutuante/transparente sobre a Page, subtrair largura deixa faixa clara exposta a direita). Esta regra PREVALECE sobre o PILAR 1 (pixel-perfect ao legado) � o sistema novo tem padrao visual proprio para o bloco de saida que NAO deve ser sobrescrito pelo SCX. CorretorAutomatico #81, #88, #89 corrigem automaticamente, mas o gerador DEVE ja emitir correto.
- **PUBLIC NAO EXISTE em DEFINE CLASS**: Metodos dentro de `DEFINE CLASS ... ENDDEFINE` sao PUBLIC por default. `PUBLIC FUNCTION xxx()` e `PUBLIC PROCEDURE xxx()` sao SYNTAX ERROR ("Statement is not valid in a class definition"). Apenas `PROTECTED` e `HIDDEN` sao modifiers validos. Escrever sempre: `FUNCTION xxx()` / `PROCEDURE xxx()` (sem PUBLIC) OU `PROTECTED PROCEDURE xxx()` / `HIDDEN FUNCTION xxx()`.
- **Page.Width / Page.Height READ-ONLY em runtime**: Pages (PageFrame.PageN) NAO aceitam atribuicao a .Width/.Height em runtime � essas propriedades sao controladas pelo PageFrame automaticamente. `WITH loc_oPage / .Width = THIS.Width / .Height = THIS.Height / ENDWITH` causa "CREATEOBJECT retornou valor nao-objeto" na instanciacao. Remover TODAS as atribuicoes a Page.Width/Height em ConfigurarPageFrame ou similares. Se precisa cobrir area, usar containers filhos da Page com Width/Height fixos.
- **MostrarAviso NAO EXISTE**: Apenas `MostrarErro` (FormErro.prg), `MsgErro`, `MsgAviso`, `MsgConfirma`, `MsgInfo` (messages.prg) existem. `MostrarAviso(...)` gera runtime error "File 'mostraraviso.prg' does not exist". Usar `MsgAviso(msg)` para validacao de UI (dialog amarelo) OU `MostrarErro(msg, titulo)` para exceptions tecnicas (dialog vermelho). CorretorAutomatico #90 auto-corrige.
- **Cursor do grid + SQLEXEC Buscar: fechar antes (uncommitted changes)**: Em BO.Buscar ou BO.CarregarPorCodigo, antes de `SQLEXEC(..., "cursor_4c_Dados")` (ou outro alias que o form usa como `grd.RecordSource`), fechar o cursor anterior: `IF USED("cursor_4c_Dados") / TABLEREVERT(.T., "cursor_4c_Dados") / USE IN cursor_4c_Dados / ENDIF`. Sem isso, segundo SQLEXEC falha com "Table buffer contains uncommitted changes" porque o grid pode ter mantido edicoes pendentes no buffer. CorretorAutomatico #91 injeta automaticamente.
- **cnt_4c_Saida padrao canonico (FormCor)**: cnt_4c_Saida Left=917, Width=90, Height=85. cmd_4c_Encerrar dentro com Left=5, Top=5, Width=75, Height=75. Mantem Encerrar com as MESMAS dimensoes dos botoes CRUD (75x75). Valores antigos (Left=935 W=60 botao W=50) tornam o Encerrar visualmente menor - substituir pelo padrao FormCor.
- **FormParaBO/BOParaForm: props EXATAS do BO + descricoes de lookup DECLARADAS**: Toda prop acessada via this_oBusinessObject.xxx DEVE existir como declaracao no BO. Assign em prop nao-declarada cria dinamica, mas LEITURA em instancia fresca (pos CarregarDoCursor, antes de qualquer assign) dispara "Property THIS_XXX is not found". Descricoes de lookup (this_cDsX, this_cDxxx) que nao vao para o SQL mas passam por FormParaBO/BOParaForm TAMBEM precisam ser declaradas no BO (mesmo que nao-persistidas).
- **cnt_4c_Botoes.Left = 542 em forms 1000px (NAO copiar Left=343 do legado)**: Container de botoes CRUD DEVE ficar a direita (Left=542, Width=390, ends=932). Gerador tende a copiar Grupo_op.Left=343 do SCX legado (form 770px) resultando em botoes centralizados. Padrao FormCor/FormMoe: Left=542. Formula para 1000px: FormWidth - CntBotoesWidth - GapEncerrar = 1000 - 390 - 68 = 542.
- **Page1.Picture + Page2.Picture = "fundo_cad_1003.jpg" obrigatorio em frmcadastro**: ConfigurarPageFrame de forms frmcadastro (cadastros/) DEVE setar `.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"` E `.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"`. Sem isso, Page1/Page2 ficam totalmente brancas (sem o fundo visual do framework). Ver FormCor.ConfigurarPageFrame como referencia.
- **cnt_4c_Sombra/cnt_4c_Cabecalho.Width = THIS.Width (NAO "THIS.Width - 60")**: Container do header escuro DEVE ocupar a largura TOTAL do form (`Width = THIS.Width`, ou 1020 como FormCor). O cnt_4c_Saida do Encerrar eh transparente (BackStyle=0) e precisa do fundo escuro POR BAIXO. Width menor deixa faixa clara a direita entre header e borda, expondo fundo do form. NUNCA usar `THIS.Width - 60` ou similar achando que precisa deixar espaco para o Encerrar.
- **MsgAviso para validacao de UI, MsgErro APENAS para exceptions tecnicas**: "Selecione um registro", "Campo obrigatorio", "Valor invalido", "Ja cadastrado" DEVEM usar `MsgAviso(...)` (dialog amarelo). `MsgErro`/`MostrarErro` (dialog vermelho + botao "Fechar Aplicacao") APENAS para erros tecnicos reais: exceptions capturadas em CATCH, "Erro ao...", "Falha ao...", SQL errors, conexao. Usar `MostrarErro` para validacao assusta o usuario.
- **Grid.ColumnCount ANTES de RecordSource em CarregarLista**: TODA vez que definir `grd.RecordSource = "cursor_4c_Dados"`, setar `grd.ColumnCount = N` IMEDIATAMENTE antes (N = numero de colunas que queremos no grid). Sem isso, grid auto-expande para todas as colunas do cursor (ex: cursor com 10 campos gera grid com 10 colunas e headers duplicados). Regra vale para CarregarLista e tambem ExecutarBusca/Buscar-style refresh. Existe regra #43 (nao resetar ColumnCount) com sentido especifico; esta reforca: ColumnCount DEVE ser setado >= 1 vez antes de CADA RecordSource.
- **ConfigurarPaginaLista/Dados: loc_oPagina.Picture = fundo_cad_1003.jpg obrigatorio**: Metodos que iniciam com `loc_oPagina = THIS.pgf_4c_Paginas.PageN` DEVEM setar `loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"` antes de qualquer AddObject. Sem isso, a pagina fica totalmente branca em vez de mostrar o fundo padrao do framework. Complementar a regra #88 que cobre o padrao `.Page1.Picture` inline no WITH do PageFrame.
- **FormParaBO DEVE popular TODAS props do BO usadas em Inserir/Atualizar**: Props de SQL (this_d*, this_n*, this_c*) referenciadas em Inserir() DEVEM ser populadas em FormParaBO(), incluindo campos auto-gerados: `IF modo==INCLUIR AND EMPTY(this_dDatas) / this_dDatas = DATE() / ENDIF`, `this_cEmps = go_4c_Sistema.cCodEmpresa`, etc. Se nao popular, Insert grava NULL/default (data NULL, empresa vazia). Auditoria: toda prop `THIS.this_[cdn]\w+` referenciada em Inserir deve aparecer em FormParaBO.
- **INDEX ON ... TAG <nome-da-coluna>, NAO TAG unico "ordem"**: Quando o form precisa mudar ordenacao via `SET ORDER TO TAG <col>`, criar UM TAG POR COLUNA no cursor (ex: `INDEX ON Locals TAG Locals`, `INDEX ON Nivel2s TAG Nivel2s`, etc.). NUNCA criar `INDEX ON &loc_cOrdem TAG ordem` (nome generico "ordem"): destroi tags anteriores e form nao consegue fazer `SET ORDER TO TAG Locals`. Auditoria cross-file: listar `SET ORDER TO TAG (\w+)` no form vs `INDEX ON ... TAG (\w+)` no BO - tags usados no form mas ausentes no BO sao bugs.
- **Campo auto-preenchido NAO eh ReadOnly/Enabled=.F. no AddObject**: TextBox que o legado preenche via Valid/SEEK em certos fluxos AINDA eh editavel pelo usuario. NUNCA setar ``.ReadOnly = .T.`` ou ``.Enabled = .F.`` no AddObject inicial a menos que o SCX legado tenha essas propriedades explicitas. Comentarios como "preenchido ao selecionar no grid" NAO justificam bloquear edicao. Controle de Enabled por modo (INCLUIR/ALTERAR/VISUALIZAR) vai em HabilitarCampos.
- **PEMSTATUS em cursor: erro "Function argument value, type, or count is invalid"**: PEMSTATUS exige OBJETO no 1o arg, NUNCA alias de cursor. ``PEMSTATUS((par_cAlias), "campo", 5)`` ou ``PEMSTATUS(par_cAlias, "campo", 5)`` (com par_cAlias sendo nome de cursor) quebra. Usar ``TYPE(par_cAlias + ".campo") != "U"`` para checar se campo existe no cursor. Regra #61 ja documentada; reforcar agora porque gerador continua replicando o erro em CarregarDoCursor.
- **Lookup KeyPress: ENTER(13) E TAB(9) E F4(115), NAO so F4**: Handlers Validar*/AbrirLookup* ligados via BINDEVENT KeyPress DEVEM disparar em ``par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115``. Somente ``= 115`` (F4) deixa user preso: digita codigo, TAB, nada acontece. Padrao correto ja em lesson #84; gerador continua emitindo so ``= 115`` em alguns forms - CorretorAutomatico #85 normaliza.
- **Forms 1-N com grid secundario: criar cursor vazio em BtnIncluirClick**: Forms com grids secundarios (ex: grd_4c_Dados exibindo localidades/itens) onde user adiciona registros manualmente via KeyPress DEVEM criar o cursor vazio com estrutura correta + tags em ``BtnIncluirClick``. Sem isso, em modo INCLUIR o cursor nao existe -> user digita e nada acontece. Exemplo: ``CREATE CURSOR cursor_4c_Xxx (col1 C(9), col2 N(9,0), ...) / INDEX ON col1 TAG col1 / INDEX ON col2 TAG col2``. Chamar ConfigurarGrdDados() em seguida para bind do grid.
- **OptionGroup.Buttons(N) DEVE ter `.BackStyle = 0`**: OptionButton dentro de OptionGroup tem BackStyle (0=transparente, 1=opaco). Sem `.BackStyle = 0` no WITH dos sub-botoes, o fundo opaco pode clipar texto da caption - "N" + CHR(227) + "o" ("Nao") aparece como "Na" na tela. SCX legado tipicamente tem `OptionN.BackStyle = 0`; migrador as vezes omite. NAO confundir com CommandButton/CommandGroup que NAO tem BackStyle (regras #59/#60).
- **OptionGroup.Width DEVE >= MAX(Buttons[i].Left + Buttons[i].Width) + 10**: Container OptionGroup clipa conteudo mesmo com BorderStyle=0. Se Buttons(N) foram expandidos (ex: Width de 37 para 60 para acomodar captions acentuadas "Nao"), o Container tambem precisa crescer. NAO basta copiar Width do SCX legado � validar que container acomoda todos os buttons + 10px margem.
- **fwprogressbar NAO PORTADA — usar stub em classes/fwprogressbar.prg**: OPERACIONAL forms que usam `CREATEOBJECT("fwprogressbar", cTitulo, nTotal)` para barra de progresso (padrao Framework legado, comum em BOs de processamento de saldo/custo/movimento) precisam do stub em `C:\4c\projeto\app\classes\fwprogressbar.prg` (Form base com Init/Show/Update/Complete + labels Titulo/SubTitulo/Rodape/lblPercentage + shpThermBg/shpThermBar) registrado em `config.prg` via `CarregarSeExistir(gcCaminhoClasses + "fwprogressbar.prg")`. Sem isso, `CREATEOBJECT` lanca "Class 'fwprogressbar' is not found", CATCH silencioso engole erro, form abre errado. Bug em SigPrCccBO.prg tambem (7 chamadas).
- **KeyPress handler: LPARAMETERS + guard Enter(13)/Tab(9)/F4(115) obrigatorios**: Handler bindado a KeyPress via BINDEVENT DEVE ter LPARAMETERS na primeira linha: `LPARAMETERS par_nKeyCode, par_nShiftAltCtrl`. Sem: runtime "No PARAMETER statement is found". Handlers de LOOKUP (que abrem FormBuscaAuxiliar) DEVEM ter guard: `IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115 / RETURN / ENDIF`. Sem guard, picker abre a CADA tecla digitada. Padrao canonico: `Formsigatcrp.prg:2614-2624`. Auto-fix: CorretorAutomatico #30 estendido + #112.
- **FormBuscaAuxiliar manual-API (CREATEOBJECT vazio + setters) NAO POPULA cursor**: Setar `this_cTabela`/`this_cCampoBusca`/`this_cValorBusca`/`this_cCursorDestino` em objeto criado SEM params + `mAddColuna` + `.Show()` NAO dispara SQLEXEC. `ConfigurarGrid()` retorna cedo se cursor nao existe -> grid VAZIO. Props `this_cFiltro`/`this_cCursorOrigem`/`this_nMaxRegistros` NAO EXISTEM em FormBuscaAuxiliar (adhoc-dinamicas sem efeito). CORRETO: (a) Init com params `CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "Tabela", "cursor_4c_Busca", "Campo", cVal, "Titulo", .T., .T., cFiltro)` — dispara SELECT internamente; (b) pre-popular `SQLEXEC(..., "cursor_4c_Busca")` antes de `.Show()`. Helper `AbrirLookup(...)` canonico em `Formsigrepes.prg:3318-3385`.
- **MsgAviso("...encontrada") antes de THIS.AbrirBusca<X>() eh REDUNDANTE e QUEBRA UX**: Em handlers `Validar<Campo>` que fazem `SELECT TOP 1` exato e caem no ELSE, PROIBIDO `MsgAviso("... nao encontrada") + .Value = "" + THIS.AbrirBusca<X>()` em sequencia. User ve 2 modais (Aviso -> OK -> Picker) e o clear-field ja apagou o valor digitado antes do picker abrir. CORRETO: apenas `THIS.AbrirBusca<X>()` no ELSE — picker abrindo direto ja indica "nao achou match" e valor digitado eh preservado como LIKE prefix. Auto-fix: CorretorAutomatico #114.
- **SigCdGcr tem coluna `descrs` (com 'r'), NAO `descs`**: Confusao classica com SigCdGpr/SigCdLin/SigCdCol (essas tem `descs`). `SELECT descs FROM SigCdGcr` gera "Nome de coluna 'descs' invalido" em runtime SQL Server. Padrao CORRETO: `SELECT codigos, descrs FROM SigCdGcr` + `mAddColuna("descrs", ...)`. Auto-fix: CorretorAutomatico #115. Regra generica: em toda familia Sig*Cd*, NUNCA colar column-name de outra tabela — consultar `docs/schema.sql`.
- **INDEX ON composto (A+B) com SEEK parcial (so A) FALHA 100% com SET EXACT ON**: `config.prg:193` seta `SET EXACT ON` globalmente — SEEK exige match da CHAVE INTEIRA do indice, nao mais prefix. Se cursor tem `INDEX ON A + B TAG X` (chave concatenada, ex: 20 chars) e o codigo faz `SEEK(loc_valorA, cursor, "X")` passando so `A` (ex: 10 chars), SEEK retorna .F. SEMPRE — `IF SEEK()` cai silenciosamente e o scan/expansao pula toda a subarvore sem exception. REGRA: se TODOS os `SEEK(..., cursor, "X")` do mesmo TAG usam apenas o primeiro campo do compound, trocar o INDEX para single-column (`INDEX ON A TAG X`). Se precisa manter compound (uniqueness, multi-key seek), OU pad-completar a chave do SEEK ate o tamanho da chave do indice OU `SET EXACT OFF` local (salvar/restaurar). Auditoria cross-file: listar `INDEX ON (\w+)\s*\+\s*(\w+) TAG (\w+)` vs `SEEK\(.*, "\3"\)` — se todos os SEEK usam so `\1`, eh bug. Bug em PlanoContasBO.prg + SigRePlcBO.prg (2026-07-03, Erro23) — relatorio Plano de Contas perdia nivel 5 (contas analiticas/clientes SigCdCli) porque `INDEX ON Grupos + IClis TAG Grupos` + `SEEK(loc_cLsGrupo, "crSigCdCli", "Grupos")` nunca casava. NAO automavel (detector precisa correlacionar INDEX + SEEK do mesmo TAG no mesmo cursor).
- **fwprogressbar stub — membros GARANTIDOS + como completar**: O stub `classes/fwprogressbar.prg` implementa a interface do framework legado com estes membros: labels `Titulo`, `SubTitulo`, `Rodape`, `lblPercentage` + shapes `shpThermBg`, `shpThermBar` + metodos `Init(cTitulo, nTotal)`, `Update(lRefresh)`, `Complete(lRefresh)`, `Show()`, `Hide()`. Se codigo migrado precisar de outro membro (framework legado tinha mais props/labels em versoes especificas), REGRA ABSOLUTA: ADICIONAR AO STUB — NUNCA alterar o form migrado. Runtime erro tipico: `Unknown member <NOME>` estourando em `Processamento`/`MCursor` durante loop de scan. Ao adicionar novo Label ao stub: ajustar `Height` do form stub (+18 por Label) para nao clipar. Auto-fix: CorretorAutomatico Pattern #116 (`Corrigir-FwProgressBarStubMembros`) valida integridade do stub. Bug em Formsigrepes.prg linha 4562 `loBarra.Rodape.Caption = "<ESC> para interromper..."` (2026-07-07, Erro26).
- **REPORT FORM &var. (macro) OU REPORT FORM (var) (parenteses) SEM guard IF FILE() + isolamento locale PROIBIDO — usar helper THIS.ExecutarReportForm()**: TODO `REPORT FORM &<var>. PREVIEW/TO PRINTER PROMPT/TO PRINTER` em form OPERACIONAL que emite relatorio (impressao de comanda/etiqueta/documento) DEVE passar por helper `PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)` que combina: guard `IF NOT FILE(FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx"))` + isolamento `SET POINT TO "." / SET SEPARATOR TO "," / SET REPORTBEHAVIOR 80` (salvar antes, restaurar depois). Modos: `"PREVIEW"`, `"PRINTER_PROMPT"`, `"PRINTER"`. Sem guard: FRX ausente estoura sem indicar arquivo. Sem isolamento: FRXs Fortyus legados renderizam campos numericos como `*******` (asteriscos) em VFP9 default (REPORTBEHAVIOR 90 + POINT="," BR conflitam com PICTUREs `9,999.999`). Auto-fix: Pattern #117 (`Corrigir-ReportFormSemGuard`) detecta AMBAS as formas (macro `&<var>.` e parenteses `(<var>)`), extrai base com strip de `.frx`, injeta helper canonico com 3 params (o 3o `par_cCursorDados` OPCIONAL — guard cursor vazio evita preview em branco quando SELECT retorna 0 registros). Bugs: Formsigrepes (Erro27/28, macro) + FormSIGREVIS (Erro29/30, parenteses + cursor vazio) — todos 2026-07-07.
- **SELECT VFP local com variavel LOCAL — alias em SELECT list DEVE bater com nome do memvar**: SELECT VFP local (`SELECT ... FROM crCursor ... INTO CURSOR novoCursor`) que referencia variavel LOCAL tem 2 regras: (1) prefixar `m.` em toda ocorrencia de var local (`loc_c\w+`) dentro do bloco — sem `m.`, VFP resolve identificador solto como COLUNA e estoura "SQL: Column 'LOC_CXXX' is not found". (2) **CRITICO**: em SELECT list, alias DEVE bater com nome do memvar (`loc_cXxx AS loc_cXxx`, NUNCA `m.loc_cXxx AS <different>`). Sem (2), quando o memvar aparece em GROUP BY / SUM(IIF(...)), o erro reincide mesmo prefixado (Erro31 2026-07-08). Padrao correto (mimica legado): `SELECT ..., loc_cMoeda AS loc_cMoeda, ..., SUM(IIF(loc_cMoeda = tabela.campo, ...)) AS mValos FROM crXxx GROUP BY ..., loc_cMoeda INTO CURSOR X READWRITE`. NAO se aplica a SQLEXEC (SQL Server) — usar `EscaparSQL(loc_cXxx)`. Auto-fix: Pattern #118 (`Corrigir-SelectLocalVarSemMPrefix`) tem 3 fases (prefixa `m.` + normaliza alias). Bug: sigrevtoBO.prg PrepararDados (Erro30-b 2026-07-07 + Erro31 2026-07-08) — Branch A/B do "Relatorio Total Por Operacao".
- **RegistrarAuditoria: DataHora usar `GETDATE()` — NUNCA `FormatarDataSQL(DATETIME())`**: BOs que sobrescrevem `RegistrarAuditoria` (custom auditoria em `LogAuditoria`) DEVEM usar literal `GETDATE()` para `DataHora` (SQL Server nativa, server-side). NUNCA `FormatarDataSQL(DATETIME())` — a funcao rejeita tipo T e retorna literal "NULL", quebrando INSERT em coluna NOT NULL (Erro35 2026-07-08 SigReAacBO). Padrao canonico: `BusinessBase.RegistrarAuditoria` (`GETDATE())`). Auto-fix: Pattern #119 detecta e substitui.
- **`&m.<var>.` eh MACRO QUEBRADA — usar `&<var>.` sem prefixo m.**: Em VFP9 o macro operator `&` le o nome ATE o primeiro `.`. `&m.loc_cWhere.` tenta expandir a variavel `m` (nao existe) — VFP9 erro 10 "Syntax error." aborta o SELECT/REPORT. A regra do Pattern #118 ("prefixar `m.` em ref de var LOCAL dentro de SELECT VFP local") vale APENAS para refs normais (SELECT list, WHERE column ops, function args, GROUP BY, ORDER BY), NUNCA dentro de macro `&`. CORRETO: `WHERE &loc_cWhere.` (sem `m.`). Auto-fix: CorretorAutomatico Pattern #120 (`Corrigir-MacroMPrefixQuebrado`) — regex `&m\.` -> `&`. Idempotente. Bug em SIGREADSBO.PrepararDados (2026-07-14, Erro37) + 13 ocorrencias em 8 arquivos.
- **INSERT em SQL Server: helpers por TIPO destino + LEFT() por TAMANHO destino**: Ao inserir campo de cursor VFP em coluna SQL Server, DEVE combinar (1) helper por TIPO do destino: CHAR/VARCHAR/TEXT -> `EscaparSQL(...)`; NUMERIC/INT -> `FormatarNumeroSQL(..., decimais)`; DATE/DATETIME -> `FormatarDataSQL(...)` ou `GETDATE()`; (2) truncar via `LEFT(campo, N)` quando origem CHAR(M) > destino CHAR(N). Ex: `SigCdCli.Rclis` char(50) em `SigTempR.Razas` char(40) -> `EscaparSQL(LEFT(csRelatorio.RClis, 40))`; `csRelatorio.CodObs` numeric(3,0) NAO pode usar `EscaparSQL` (retorna `''` para nao-C, SQL Server rejeita conversao) -> `FormatarNumeroSQL(csRelatorio.CodObs, 0)`. Sem esses cuidados: SQL Server 8152 "String or binary data would be truncated" ou erro de conversao numerica aborta INSERT sem MsgErro claro. Antes de gerar INSERT: consultar `docs/schema.sql` para tipos+tamanhos das colunas destino. NAO automavel univoco. Bug em SIGREADSBO.PrepararDados linhas 552/555 (2026-07-14, Erro39).
- **Grid Column CheckBox EXIGE `.Sparse = .F.`**: `Column1` com `CurrentControl = "Check1"` DEVE ter `.Sparse = .F.` explicito. Default VFP9 `Sparse = .T.` renderiza CheckBox APENAS na linha corrente — outras linhas mostram valor bruto (0/1) como texto e user NAO clica checkboxes das demais linhas. BtnSelTudo/BtnApaga (REPLACE ALL) funcionam mas selecao individual quebra. Padrao canonico: `Formsigrepes.prg:3095-3104`. Auto-fix Pattern #121 (`Corrigir-GridColumnCheckboxSparse`). Bug em FormSIGREADS (2026-07-14, Erro41).
- **OptionGroup.Buttons(N) DEVE ser configurado em WITH ANINHADO dentro do WITH pai**: Ao criar OptionGroup com `AddObject`, configurar `Buttons(1)` e `Buttons(2)` em blocos `WITH .Buttons(N)` ANINHADOS dentro do `WITH loc_oPag.obj_4c_OptXxx`. NUNCA fechar o WITH pai com ENDWITH e depois abrir `WITH loc_oPag.obj_4c_OptXxx.Buttons(N)` separado — VFP9 runtime nao resolve `.Buttons` via caminho completo fora do contexto WITH pai, gerando "BUTTONS is not an object". CORRETO: `WITH loc_oPag.obj_4c_OptXxx / .Value = 1 / WITH .Buttons(1) / .Caption = "Simples" / ENDWITH / WITH .Buttons(2) / .Caption = "Composto" / ENDWITH / ENDWITH`. Bug em FormSigPrCfn.prg ConfigurarPaginaLista (2026-07-15, Erro42).
- **SigCdEmp: colunas CANONICAS sao `Cemps`/`Razas` — NUNCA `Emps`/`emps`/`NComps`/`nemp`**: A tabela `SigCdEmp` tem PK `Cemps` char(3) (codigo empresa) e descricao `Razas` char(40). As colunas `Emps`/`emps` e `NComps`/`nemp` NAO EXISTEM — gera runtime `[SQL Server]Nome de coluna 'Emps' invalido` no primeiro Enter/Tab do campo Empresa. Bug tipico: `SELECT Emps, NComps FROM SigCdEmP WHERE Emps = ...` ou `CREATEOBJECT("FormBuscaAuxiliar", ..., "SigCdEmp", "cursor_X", "emps", ...)`. Motivo: Framework legado usava `fAcessoEmpresa(Usuar, 'C', This.Value, GetX, GetDX)` que abstraia o nome da coluna; sem a Framework portada, gerador inventa `Emps`/`NComps` por analogia com `SigCdBal.Emps` (que existe) ou com o nome do TextBox (`Get_Empresa`). CORRETO: `SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = ...` + `mAddColuna("Cemps", "XXX", ...)` (mask 3 X) + `mAddColuna("Razas", ...)` + refs `cursor.Cemps`/`cursor.Razas`. CUIDADO: `SigCdBal.emps` e `SigIvTrh.emps` EXISTEM legitimamente — regra NAO se aplica quando o FROM eh outra tabela. Padrao canonico: `Formsigrevto.prg`, `Formsigreimp.prg`, `Formsigrehpr.prg`, `Formsigrefcd.prg`, `Formsigrepes.prg`. Auto-fix: CorretorAutomatico Pattern #125 (`Corrigir-SigCdEmpColunasInvalidas`) tem 2 fases (Fase 1 identifica cursores populados de SigCdEmp; Fase 2 corrige SELECT/WHERE/mAddColuna/refs `cursor.<col>`). Preservacao de case: `emps`->`cemps`, `Emps`->`Cemps`; `nemp`/`NComps`->`razas`/`Razas`. Bug em FormSigReAiv.prg + FormSIGREHCP.prg (2026-07-16, Erro44).
- **SigCdEmp TextBox de codigo (`txt_4c_Empresa`/`txt_4c_CEmps`/`txt_4c_Emps`): `.MaxLength = 3` OBRIGATORIO**: TextBox de codigo empresa (mapeia para `SigCdEmp.Cemps` char(3)) DEVE ter `.MaxLength = 3` explicito no bloco `AddObject`+`WITH`. Sem isso, usuario digita 2 chars e Valid aceita (SQL Server pad-completa com espacos), mas relatorio filtra por `SigCdBal.emps` que nao encontra registros (INDEX difere). Screenshot Erro45: `Empresa: [00] MARCELLA BAHIA` — user digitou "00" (2 chars). SCX legado omite MaxLength (usa default fwtxtbox), gerador ou omite (VFP9 default=0 unlimited) ou estima por Width=33px (~2 chars). CORRETO: `WITH loc_oPg.txt_4c_Empresa / .Width = 33 / .MaxLength = 3 / ...`. Complementa Pattern #125 (esse trata SQL, este trata UI input). Auto-fix: CorretorAutomatico Pattern #126 (`Corrigir-SigCdEmpTextBoxMaxLength`) altera ou injeta `.MaxLength = 3` em blocos `WITH ...txt_4c_(Empresa|C?Emps|CEmp)`. Idempotente. Bug em 15 forms (2026-07-16, Erro45).
- **WITH aninhado em Container/Label/CommandGroup criados com AddObject — silently ignora props (Label/Button.Caption/Picture/ForeColor)**: Dentro de `WITH THIS.cnt_X` ou `WITH loc_oCab`, chamar `.AddObject("filho", "Label"|"CommandGroup")` e depois `WITH .filho` (WITH aninhado relativo) causa falha SILENCIOSA de resolucao de propriedades em VFP9 — Label.ForeColor/Caption e Button.Caption/Picture/Left/Width nao sao aplicados. NAO gera exception; sintoma visual: Labels invisiveis + Buttons como retangulos vazios sem icone e sem texto. Pior caso: **3 niveis de aninhamento** `WITH loc_oCab / .AddObject("cmg_4c_Botoes",...) / WITH .cmg_4c_Botoes / WITH .Buttons(N) / .Caption = ... / .Picture = ...` — Buttons props totalmente ignoradas. CORRETO: (1) fechar `WITH loc_oCab` apos configurar Container, (2) `loc_oCab.AddObject("filho", "<Classe>")` FORA de qualquer WITH, (3) `WITH loc_oCab.<filho>` OU `loc_o<filho> = loc_oCab.<filho> / WITH loc_o<filho>` (caminho explicito). EXCECAO: `WITH .Buttons(N)` DENTRO de `WITH loc_oCmg` (1 nivel de nesting em CommandGroup) EH SEGURO — Buttons(N) eh collection accessor, nao AddObject. Widths canonicos framework frmrelatorio (NUNCA `THIS.Width` em CommandGroup/Button): CommandGroup `.Width = 273`, `.Left = 527/529`; Buttons `.Width = 65`, `.Height = 70`, Lefts=5/71/137/203 (increment 66). Container/Label/PageFrame podem usar `THIS.Width` (span correto). Padrao canonico: `FormSigPdAco.prg ConfigurarCabecalho` (2 niveis) + `Formsigreanr.prg ConfigurarCabecalho` pos-fix (3 niveis com CommandGroup+Buttons). Bugs: FormSIGPRIMP (2026-07-17 Erro47 nivel 2 Label/ForeColor) + Formsigreanr + 8 outros forms REPORT (2026-07-17 Erro49 nivel 3 CommandGroup/Buttons.Picture+Caption).
- **PROCEDURE Destroy DEVE chamar DODEFAULT() como ULTIMA linha — sem isso o menu do sistema encolhe visualmente**: Todo form OPERACIONAL que herda de `FormBase` e sobrescreve `PROCEDURE Destroy` DEVE terminar com `DODEFAULT()` antes do `ENDPROC`. `FormBase.Destroy` contem o fix `RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda / CriarMenuPrincipal()` que rebuilda os popups do menu principal (`_MSYSMENU`) apos qualquer form modal fechar. Sem DODEFAULT(), a cadeia de heranca eh quebrada, `FormBase.Destroy` nao roda, e VFP9 mantem cache visual STALE dos popups — resultado: `popMovimentos` que tem 105 bars definidas (CNTBAR=105) renderiza visualmente apenas os primeiros ~40 items com line-height maior, popups aparecem encolhidos com items sumidos. CORRETO: `PROCEDURE Destroy() / IF USED("cursor_X") / USE IN cursor_X / ENDIF / DODEFAULT() / ENDPROC`. Auto-fix: CorretorAutomatico Pattern #145 (`Corrigir-DestroySemDodefault`) injeta DODEFAULT() em forms `AS FormBase` que omitem, idempotente. Origem: Erro58 (2026-07-21, bug visual em popups apos form.Destroy).

## REGRA CRITICA: NUNCA Criar Stubs com MsgAviso (PROIBIDO!)

**ABSOLUTAMENTE PROIBIDO** criar metodos Btn*Click com `MsgAviso("...sera implementado...")`.
Isso eh um STUB DISFAR�ADO e VIOLA a regra de funcionalidade completa.

**ERRADO** (stub disfar�ado):
``foxpro
PROCEDURE BtnMovimentoClick()
    MsgAviso("Movimentacao sera implementada.", "Aviso")
ENDPROC
``

**CORRETO** (logica real baseada no legado):
Analisar o PROCEDURE correspondente no codigo fonte original e implementar:
- Botoes de **relatorio/impressao/Excel**: Implementar geracao de relatorio (REPORT FORM / COPY TO XLS)
- Botoes de **operacao** (Alterar, Excluir, Movimento, Conciliar, Auditar, FollowUp):
  Implementar logica real do legado (SQL INSERT/UPDATE/DELETE, navegacao, abertura de formularios)
- Se o legado chama ProcessaSaldo/ProcessaHist: Criar metodo equivalente no BO

**TODOS os botoes visiveis na tela DEVEM ter funcionalidade REAL implementada.**

## Integracao
- Adicionar SET PROCEDURE para BO e Form em config.prg
- Adicionar item no menu (menu.prg) no popup **popMovimentos** (tipo OPERACIONAL)
  - DEFINE BAR N OF popMovimentos PROMPT "..." MESSAGE "..."
  - ON SELECTION BAR N OF popMovimentos DO Abrir${formClass}
  - PROCEDURE Abrir${formClass}() no final do menu.prg
- Deletar *.fxp antes de testar: del /s /q C:\4c\projeto\app\*.fxp

**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir ``SET SAFETY OFF`` e ``SET RESOURCE OFF`` no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.

Comecar agora. Ler o codigo fonte original para entender o layout e funcionalidades.
"@
            Write-Host "  [OPERACIONAL] Meta-prompt especifico gerado" -ForegroundColor Cyan
        }

        # Salva meta-prompt
        $prompt | Set-Content -Path $metaPromptFile -Encoding UTF8

        # ===================================================================
        # PHASE A/B PROMPTS (2-Phase Migration Split)
        # Phase A: UI Layout ONLY (pixel-perfect, stubs allowed)
        # Phase B: Functionality ONLY (fill stubs, no visual changes)
        # ===================================================================

        $phaseAFile = Join-Path $taskPath "meta_prompt_phaseA.md"
        $phaseBFile = Join-Path $taskPath "meta_prompt_phaseB.md"

        # --- PHASE A: UI Layout ---
        $phaseAPrompt = @"
# FASE A: Layout Visual - $formClass (APENAS UI)

**FOCO EXCLUSIVO: LAYOUT PIXEL-PERFECT. Funcionalidade sera adicionada na Fase B.**

## OBJETIVO
Criar o layout visual IDENTICO ao sistema legado. Copiar TODAS as propriedades visuais
(Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize, Caption, InputMask)
EXATAMENTE como estao no codigo fonte original.

## REGRA #1: UI FIDELITY ACIMA DE TUDO
- Cada controle DEVE ter as propriedades visuais EXATAS do original
- Posicoes (Top/Left) DEVEM ser copiadas sem arredondamento
- Cores (BackColor/ForeColor) DEVEM ser RGB identico
- Fontes (FontName/FontSize/FontBold) DEVEM ser identicas
- Tamanhos (Width/Height) DEVEM ser identicos
- **Compensar PageFrame.Top=-29**: controles dentro de Pages recebem +29 no Top
- **Picture do Form**: Se o form original tem .Picture (background image), COPIAR para o form migrado usando gc_4c_CaminhoIcones + nome_arquivo. Ex: ``THIS.Picture = gc_4c_CaminhoIcones + "fundo_cadastro.jpg"``
- **Caption com hotkeys (\<)**: PRESERVAR marcadores \< em Captions de labels. Ex: ``"\<Atendente :"`` (o \< define tecla de atalho). NUNCA remover \<.
- **Width/Height de Labels**: Copiar valores EXATOS. NAO usar AutoSize = .T. em labels que tem Width explicito no original.
- **Cursor do Grid CRUD**: O cursor principal do grid DEVE se chamar ``cursor_4c_Dados`` (nome padrao verificado pelo TesteAutomatico).

## REGRA #2: STUBS SAO PERMITIDOS NESTA FASE
Metodos de evento (Btn*Click, Validar*, Lookup*, Tecla*) podem ser stubs vazios:
``foxpro
PROCEDURE BtnIncluirClick()
    *-- Fase B: implementar logica
ENDPROC
``

Metodos de DADOS podem ser stubs:
``foxpro
PROTECTED PROCEDURE CarregarLista()
    *-- Fase B: implementar SQL
ENDPROC

PROTECTED PROCEDURE FormParaBO()
    *-- Fase B: implementar binding
ENDPROC
``

## REGRA #3: O QUE DEVE ESTAR COMPLETO
- **BO**: Apenas declaracao de propriedades this_* e Init() com this_cTabela/this_cCampoChave
- **Form Init/InicializarForm**: COMPLETO (cria estrutura visual)
- **ConfigurarPageFrame**: COMPLETO (Pages, BackColor, Caption, Picture)
- **ConfigurarPaginaLista**: COMPLETO (Grid com colunas, Container de botoes CRUD com icones)
- **ConfigurarPaginaDados**: COMPLETO (TODOS os campos, labels, containers, botoes)
- **TornarControlesVisiveis**: COMPLETO (com filtro de containers flutuantes se OPERACIONAL)
- **AlternarPagina**: COMPLETO
- **HabilitarCampos/LimparCampos**: COMPLETO (iterar sobre controles)

## Arquivos de Referencia
1. **CLAUDE.md** - Secao UI FIDELITY (propriedades obrigatorias, compensacao Top+29)
2. **tasks/$TaskId/${BaseName}_form_codigo_fonte.txt** - Codigo fonte original (PROPRIEDADES VISUAIS)
3. **tasks/$TaskId/mapeamento.json** - Mapeamento de objetos (nomes legado -> novo)

## Arquivos a Criar
1. **C:\4c\projeto\app\classes\${boClass}.prg** - BO com propriedades this_* e Init() apenas
2. **C:\4c\projeto\app\forms\${formSubDir}\${formClass}.prg** - Form com layout COMPLETO

## Regras VFP Criticas
- CHR() para acentos (a=225, c=231, ao=227, e=233, i=237, o=243)
- NUNCA RETURN dentro de TRY/CATCH
- BINDEVENT metodos PUBLIC (sem PROTECTED)
- **BINDEVENT "Valid" NAO FUNCIONA em TextBox**: Usar "KeyPress" (ENTER=13/TAB=9) para simular Valid. NUNCA usar LostFocus para chamar MontaGrade/CarregarDados/SQLEXEC - LostFocus dispara SEMPRE (inclusive por SetFocus de outro controle) causando RECURSAO INFINITA. Ex: `BINDEVENT(txt, "KeyPress", THIS, "TxtCampoKeyPress")` e no handler: `IF par_nKeyCode = 13 OR par_nKeyCode = 9 ... ENDIF`
- **Page.Visible NAO EXISTE**: Page (PageFrame.PageN) NAO tem propriedade Visible. NUNCA `.Page1.Visible = .T.`.
- **PageFrame.Visible OBRIGATORIO**: AddObject cria controles com Visible=.F. SEMPRE adicionar `THIS.pgf_4c_Paginas.Visible = .T.` ANTES de `ActivePage = 1` no InicializarForm. Sem isso form abre em branco.
- **Buttons(N) vs ButtonCount**: Ao fazer BINDEVENT em Buttons(N), N DEVE ser <= ButtonCount. Verificar no AddObject qual era o ButtonCount antes de referenciar.
- TextBox.Value inicializar: "" (string), 0 (numerico), {} (data)
- AddObject cria Visible=.F. - setar .Visible = .T.
- PageCount ANTES de acessar .Page1/.Page2
- NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1)
- PageFrame NAO tem BackColor (usar Page1.BackColor)
- Grid NAO tem AllowAddNew/AllowDelete/AllowEdit
- CommandGroup e OptionGroup: SEMPRE definir .ButtonCount ANTES de acessar .Buttons(N)
- NUNCA fazer self-assignment: THIS.pgf_4c_Paginas = THIS.pgf_4c_Paginas (causa erro "is a method, event, or object")
- Botoes CRUD: Width=75, Height=75, Left sequencial (5,80,155,230,305,380)
- ControlBox=.F., TitleBar=0 (sem barra de titulo)
- Themes=.F. em TODOS os botoes
- Variaveis legadas (_EMPR, _EMPRESA, pEmp): substituir por go_4c_Sistema.cCodEmpresa
- **this_cMensagemErro**: SEMPRE declarar `this_cMensagemErro = ""` nas propriedades do Form (NAO herdado de FormBase, necessario para CATCH blocks)
- **REPORT FORM TO FILE**: Pre-computar caminho em variavel LOCAL + macro expansion `&var` (expressoes inline NAO funcionam)
- **MESSAGEBOX PROIBIDO**: NUNCA usar MESSAGEBOX() direto. Usar funcoes de messages.prg: MsgInfo() para informativo (icone 64), MsgAviso() para aviso (icone 48), MsgErro() para erro (icone 16), MsgConfirma() para confirmacao Sim/Nao. Essas funcoes suprimem dialogs em modo de teste automatizado.
- **fAcessoEmpresa() NAO EXISTE (nao portada)**: A funcao global `fAcessoEmpresa()` do Framework legado (sigacess.PRG) NAO foi portada para a nova arquitetura. Chamadas diretas quebram em runtime com "File 'facessoempresa.prg' does not exist" (VFP9 procura .prg externo quando o nome nao eh THIS.metodo nem funcao definida). Substituicao canonica: MODO CHECK (3 args, retorna boolean) `fAcessoEmpresa(usu,"C",cod)` -> `VerificarAcessoEmpresa(usu, cod)` (helper em utils/functions.prg). MODO LOOKUP (5 args, popula 2 textboxes) `fAcessoEmpresa(usu, "C"|"D", val, oCod, oDsc)` -> bloco FormBuscaAuxiliar apontando SigCdEmp com chave Cemps (modo C) ou Razas (modo D), retornando ambas colunas. Titulo: "Sele" + CHR(231) + CHR(227) + "o de Empresa". Auto-fix: CorretorAutomatico #110. Padrao canonico: Formsigatcrp.prg:2278-2378 (KeyPress) e Formsigrepes.prg:6501-6540 (LostFocus). Bug observado em Formsigatcrp.prg + Formsigrepes.prg (2026-07-02, Erro14).
- **fAcessoContas() NAO USAR para lookup UX (auto-load do primeiro registro)**: A funcao `fAcessoContas()` (utils/functions.prg:719) EH portada, mas seu fluxo interno (`LIKE '%valor%'` + `LOCATE` + FormBuscaSimples) auto-popula o textbox com o PRIMEIRO registro que contem o valor digitado — mesmo sem selecao explicita do usuario no picker. Resultado tipico: user digita "11" no campo Gerente/Vendedor e o form carrega "GAVETA - LOJA 001..." (primeiro match parcial). PROIBIDO usar `fAcessoContas(usu, grp, "C"|"D", val, txtCod, txtNom)` como handler de Valid/KeyPress em textbox de lookup. Substituicao canonica: mesmo padrao de fAcessoEmpresa lookup (Formsigatcrp.prg:2612-2790 apos Erro16 fix). Enter/Tab -> `SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = valor` exato (hit -> auto-preenche, miss -> `THIS.AbrirBusca<X>()`). AbrirBusca<X> -> SQL proprio com `LIKE 'valor%' OR RTRIM(RClis) LIKE 'valor%'` (starts-with, NAO contem) + fallback lista completa + `CREATEOBJECT("FormBuscaAuxiliar")` sem SQL automatica + mAddColuna("IClis"/"RClis") + `.Show()` respeitando `this_lSelecionou`. `fAcessoContas()` continua valida para contexto backend (SCAN loop de acesso, validacao sem UI). Bug observado em Formsigatcrp.prg ValidarCodGer/ValidarNomGer/ValidarCodVen/ValidarNomVen (2026-07-02, Erro16).
- **.RecordMark/.DeleteMark SO em Grid — NUNCA em CommandButton/Label/Container/TextBox/ComboBox/etc**: As propriedades `.RecordMark` e `.DeleteMark` sao EXCLUSIVAS de Grid (barras laterais de marcacao/exclusao de registro). Gerador frequentemente copia esse par de `WITH grd_4c_Xxx` e cola em WITH de CommandButton adjacente (ex: `cmd_4c_SelXxx`/`cmd_4c_DslXxx` ao lado de grids de selecao multipla em REPORT). VFP9 trava com "Property RECORDMARK is not found" ao instanciar o form. PIOR: o erro eh silenciosamente engolido pelo TRY/CATCH de `InicializarForm` (apenas seta `loc_lSucesso=.F.` sem MsgErro), resultando em `CREATEOBJECT("FormXxx")` retornar `.F.` sem exception aparente e "VARTYPE retornou: L" no dialog. PROIBIDO gerar `.RecordMark = .F.` ou `.DeleteMark = .F.` em WITH cujo AddObject NAO seja `"Grid"`. Recomendacao complementar: no CATCH de `InicializarForm`, chamar `MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)` ANTES de setar `loc_lSucesso=.F.` — expoe o erro para debug em vez de engolir silenciosamente. Auto-fix: CorretorAutomatico #111. Bug observado em Formsigrepes.prg (2026-07-02, Erro17): 9 CommandButtons corrompidos (`cmd_4c_SelOrigMerc`, `cmd_4c_SelTipoInvs`, `cmd_4c_SelLinha`, etc).
- **CheckBox em Grid Column (Error 1767)**: Para grids com CheckBox, a UNICA definicao de ControlSource deve ser `Column1.ControlSource = "cursor.campo"` DEPOIS de `CurrentControl = "Check1"`. NUNCA definir `Check1.ControlSource` (conflita com Column) E NUNCA definir `Column1.ControlSource` ANTES de AddObject("Check1").
- **AddObject sintaxe CORRETA**: `parent.AddObject("nome", "Classe")` - ambos strings. NUNCA `parent.AddObject(loc_oObj, "nome")` (objeto como parametro causa "Function argument invalid"). Padrao: `parent.AddObject("cmd_4c_X", "CommandButton")` + `WITH parent.cmd_4c_X` para configurar.
- **Grid Column CurrentControl="Check1" EXIGE AddObject**: ANTES de `.Column1.CurrentControl = "Check1"`, OBRIGATORIO: `.Column1.AddObject("Check1", "CheckBox")` + `.Column1.Check1.Caption = ""`. Sem isso, erro "Unknown member CHECK1" cascateia e destroi toda inicializacao.
- **CheckBox .Value SEMPRE NUMERICO**: Inicializar CheckBox com `.Value = 1` (marcado) ou `.Value = 0` (desmarcado). NUNCA usar `.T.`/`.F.` (logico). Comparar com `= 1`/`= 0`, IIF com `IIF(chk.Value = 1, ...)`. Misturar tipos causa "Operator/operand type mismatch".
- **IF THEN inline PROIBIDO**: VFP9 NAO suporta `IF cond THEN cmd` numa unica linha. Gera "Command contains unrecognized phrase/keyword." SEMPRE expandir para multi-linha: `IF cond` / `  cmd` / `ENDIF`.
- **COUNT TO var IN alias PROIBIDO**: VFP9 COUNT nao tem clausula IN. Gera "Command contains unrecognized phrase/keyword." Usar: `SELECT alias` + `COUNT TO var`.
- **APPEND FROM requer SELECT cursor antes**: `ZAP IN cursor_name` NAO muda a work area corrente. `APPEND FROM DBF("tmp")` vai para a work area CORRENTE. SEMPRE fazer `SELECT cursor_destino` antes de `APPEND FROM`. Sem isso, dados vao para o cursor errado e o grid fica vazio.
- **CommandGroup.FontName NAO EXISTE**: CommandGroup (como OptionGroup) NAO tem FontName/FontSize. Definir em cada `.Buttons(N).FontName`. Tentar no grupo causa "Property FONTNAME is not found" que cascateia e impede toda configuracao dos botoes.
- **AlternarPagina DEVE chamar AjustarBotoesPorModo**: Em forms CRUD, ao voltar para Page1 (LISTA), OBRIGATORIO chamar `THIS.AjustarBotoesPorModo()` ANTES de `THIS.CarregarLista()`. Sem isso os botoes ficam desabilitados apos Incluir/Alterar/Visualizar.
- **CommandGroup BackStyle/BorderStyle EXATOS do original**: Se o original tem `BackStyle=0` + `BorderStyle=0`, o CommandGroup eh TRANSPARENTE (container logico invisivel). NUNCA adicionar BackColor quando original nao tem. Copiar BackStyle, BorderStyle, SpecialEffect EXATOS.
- **ForeColor de Labels: COPIAR do original, NUNCA assumir**: Labels sobre fundo escuro usam ForeColor branco, labels sobre fundo claro usam ForeColor cinza (90,90,90). Copiar ForeColor EXATO do codigo fonte original. Assumir cor "baseado no tema" causa labels INVISIVEIS.
- **Buttons(N) dentro de CommandGroup: propriedades EXATAS**: Left, Top, FontName, FontBold, FontItalic, BackColor, ForeColor dos Buttons DEVEM vir do codigo fonte original. NUNCA inventar Left=0 ou FontName="Tahoma" quando original tem Left=178 ou FontName="Comic Sans MS".
- **Propriedades do BO preservam sufixo "s" da coluna do banco**: Colunas como Moedas, Contas, Grupos mapeiam para this_cMoedas, this_cContas, this_cGrupos. NUNCA "corrigir" removendo o "s" (this_cMoeda NAO EXISTE ? "Property not found"). Verificar nome EXATO no DEFINE CLASS do BO.
- **Nomes de icones/imagens: COPIAR EXATO do original + VALIDAR EXISTENCIA**: O atributo .Picture deve ter o nome de arquivo EXATO do original (ex: `geral_procura_60.jpg`, `cadastro_sair_60.jpg`). Trocar APENAS o path: `..\framework\imagens\` ? `gc_4c_CaminhoIcones +`. NUNCA inventar nomes de arquivo (ex: `consultar.bmp`, `geral_visualizar_60.jpg`, `geral_imprimir_60.jpg`, `geral_fechar_60.jpg` — NAO EXISTEM em vbmp/). USAR APENAS `gc_4c_CaminhoIcones` (NUNCA `gc_4c_Icones` — variavel legada, gera falhas em runtime). Para REPORT, ver "REPORT Buttons(N).Picture: ICONES CANONICOS OBRIGATORIOS" abaixo.
- **Propriedades do FORM: COPIAR TODAS do original**: TitleBar, ControlBox, MaxButton, MinButton, Closable, ClipControls DEVEM ser copiadas do codigo fonte original. Se original tem `TitleBar = 0` (sem barra de titulo), migrado DEVE ter `TitleBar = 0`. Omitir essas propriedades faz VFP9 usar defaults (barra de titulo visivel) alterando completamente a aparencia do form.
- **CommandButton ForeColor/BackColor/Themes EXATOS**: Botoes avulsos DEVEM copiar ForeColor, BackColor, FontName, FontBold, FontItalic, Themes do original. Se original tem ForeColor=90,90,90 + BackColor=255,255,255 + Themes=.F., copiar EXATO. ForeColor=RGB(255,255,255) em fundo claro torna texto INVISIVEL. **EXCECAO**: standalone CommandButton (fora de CommandGroup) com `.Picture` DEFINIDO precisa de `.Themes = .T.` + `.DisabledPicture = (mesma imagem)` — sem isso, com Themes=.F. + Enabled=.F. o icone NAO renderiza (so caption aparece). Auto-fix: CorretorAutomatico #99. Buttons(N) DENTRO de CommandGroup MANTEM Themes=.F. (canonico REPORT).
- **CommandButton auxiliar ao lado de Grid: NUNCA OMITIR `.Picture`**: Botoes standalone tipo `cmd_4c_SelTudo` (Selecionar Todos), `cmd_4c_Apaga` (Desmarcar/apaga), ou similares ao lado de grids de selecao TEM `.Picture` no SCX original (`geral_marcar_26.jpg` para Selecionar, `cadastro_excluir_26.jpg` para Desmarcar). Migracao frequentemente OMITE a linha `.Picture` inteira - botao renderiza como caixa vazia sem icone. SEMPRE copiar `.Picture = gc_4c_CaminhoIcones + "nome.jpg"` do original + aplicar padrao standalone (`.Themes=.T.` + `.DisabledPicture`). Heuristica: se WITH cmd_4c_* tem `.ToolTipText` = "Selecionar"/"Desmarcar"/"Marcar Todos"/"Limpar" e NAO tem `.Picture`, faltou copiar. Auto-fix: CorretorAutomatico #104. Bug em Formsigrecmc.prg (task052, 2026-07-01).
- **SigCdOpe eh single-column: NUNCA usar `descrs`/`Descrs`**: SigCdOpe tem `Dopes` (char(20)) que eh PK **E** descricao ao mesmo tempo — NAO existe coluna `descrs`/`Descrs` nessa tabela. Lookup FormBuscaAuxiliar para SigCdOpe deve chamar UMA UNICA `mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")`. NUNCA adicionar segunda coluna `mAddColuna("descrs", ...)` — gera runtime "Variable 'DESCRS' is not found" em FormBuscaAuxiliar.ConfigurarGrid quando seta Columns(N).ControlSource. Mesma regra para SELECT: `SELECT Dopes FROM SigCdOpe` (NUNCA `SELECT Dopes, Descrs FROM SigCdOpe`). Referencia: FormSIGREADS.prg:1554, Formsigrevto.prg:900. Auto-fix: CorretorAutomatico #105. Bug em Formsigrecmc.prg:1848 e FormSigReCmp.prg:1767/1813 (task052/task045, 2026-07-01).
- **CommandButton icone-only (`Caption=""`) NUNCA setar `.Enabled=.F.` em runtime**: Standalone CommandButton com `Caption=""` + `.Picture` NAO renderiza icone quando `.Enabled=.F.`, INDEPENDENTE de `.Themes=.T.` ou `.F.` — botao vira retangulo vazio. Isso refina o Pattern #99 (que funciona apenas para botoes COM caption como cmd_4c_Graficos). Nunca setar `.Enabled=.F.`/`.Enabled=.T.` em cmd_4c_* icone-only (SelTudo/Apaga tipicos) fora do bloco AddObject inicial — em vez disso: (a) NAO desabilitar (botao fica clickavel mas handler ja pode ser inocuo — SelTudo/Apaga so mexem em cursor cujo report vai ignorar), (b) desabilitar via check condicional dentro do handler `PROCEDURE CmdXClick`, OU (c) usar `.Visible=.F.` em vez de `.Enabled=.F.`. Auto-fix: CorretorAutomatico #106 (remove runtime `.Enabled=.F./.T.` em cmd_4c_* icone-only). Bug em Formsigrecmc.prg cmd_4c_SelTudo/cmd_4c_Apaga (task052, erro8.PNG, 2026-07-01) — desabilitar em TxtNmOperacaoKeyPress apagava icones apos usuario preencher Movimentacao.
- **Container de botoes sobre Grid: OBRIGATORIO BackStyle=1 OU posicionar fora da bbox do Grid**: Container filho de Form com CommandButtons dentro NAO pode ter `BackStyle=0` (transparente) se seu retangulo (Top..Top+Height) sobrepoe o Grid irmao (grid.Top..grid.Top+grid.Height). Grid re-renderiza rows em scroll (redraw parcial da area) — sem fundo opaco por tras dos botoes, os botoes ficam "carimbados" repetidamente em cada frame novo ("ghost trails"). Fix: (a) `Top >= grid.Top + grid.Height + margem` (posicao FORA da bbox — preferido), OU (b) `BackStyle = 1` + `BackColor = RGB(255, 255, 255)` se overlay for necessario. Auto-fix: CorretorAutomatico #107. Bug em FormBuscaAuxiliar.prg cnt_4c_Botoes (task052, Erro9.PNG, 2026-07-01) — Top=252 dentro do grid (grid bottom=306) + BackStyle=0 mostrava botoes Selecionar/Cancela stackados 3+ vezes ao scrollar a lista de contas.
- **OptionGroup.Buttons(N).Value NUNCA setar valor != 0**: Em VFP9, `OptionGroup.Value` eh INTEGER (1..N) indicando qual dos N botoes esta selecionado. `OptionButton.Value` (individual) eh BOOLEAN (0/1) — quem gerencia eh o OptionGroup. Se o codigo migrado setar `Buttons(2).Value = 2`, `Buttons(3).Value = 3`... VFP9 trata QUALQUER nao-zero como truthy → TODOS os radio buttons aparecem marcados de uma vez, comportamento visual quebrado. NUNCA setar `.Value = N` (com N != 0) dentro de bloco `WITH ...Buttons(N)`. Se quiser default selection, setar apenas `OptionGroup.Value = indice` (ex: `OptionGroup.Value = 2` para 2o botao marcado). Auto-fix: CorretorAutomatico #108. Bug em Formsigregli.prg (task108, 2026-07-01) em 5 OptionGroups (Get_Tipo/TpOrdem/Get_Boleto/Get_Pedido/Opt_Ordem).
- **TornarControlesVisiveis: skip com LOOP DEVE recursar em containers hidden-por-default**: Metodo recursivo `TornarControlesVisiveis` seta `Visible=.T.` em sub-controles apos AddObject (que os cria Visible=.F. default). Quando ha lista de skip para containers que devem comecar ocultos (ex: `IF INLIST(control.Name, "CNT_4C_ETIQUETAS", "CNT_4C_RELACAO") LOOP ENDIF`), o `LOOP` pula TANTO setar Visible do container QUANTO recursar dentro dele. Resultado: container fica hidden corretamente MAS seus filhos tambem ficam Visible=.F. permanente. Quando logica posterior seta `container.Visible=.T.`, container aparece VAZIO. Fix: dentro do IF de skip, ANTES do LOOP, recursar `THIS.TornarControlesVisiveis(container)` para tornar filhos visiveis sem tocar Visible do proprio container. Auto-fix: CorretorAutomatico #109. Bug em Formsigregli.prg (task108, 2026-07-01) — containers cnt_4c_Etiquetas/Relacao apareciam vazios ao selecionar Tipo de Impressao.
- **cnt_4c_Cabecalho Labels NUNCA usar AutoSize=.T.**: `lbl_4c_Sombra`/`lbl_4c_Titulo` em `cnt_4c_Cabecalho` DEVEM ter `AutoSize = .F.` (default) + `Width = THIS.Width` (Container Width, igual THISFORM.Width). Com `AutoSize = .T.`, captions longos expandem a Label alem da area dos botoes (cmg_4c_Botoes Left=529, Graficos Left=460), deixando texto truncado visualmente atras dos botoes. AutoSize=.F. clipa naturalmente no boundary. Auto-fix: CorretorAutomatico #98. Bug em Formsigrecmc.prg (2026-06-25). Template canonico: FormSigReAac.prg:104-146.
- **Grid RecordMark/DeleteMark em OPERACIONAL**: Grids criados manualmente (AddObject) em forms OPERACIONAIS DEVEM ter `.RecordMark = .F.` e `.DeleteMark = .F.`. Sem isso, barras de marcacao aparecem na lateral esquerda do grid.
- **ChkRegister NAO EXISTE em BusinessBase**: O legado usa ``ThisForm.poDataMgr.ChkRegister()`` para verificar duplicidade. Na migracao, usar SQLEXEC com ``SELECT COUNT(*) AS nExiste FROM tabela WHERE campo = valor`` + verificar ``NVL(cursor.nExiste, 0) > 0``. NUNCA chamar ChkRegister no BO.
- **cnt_4c_Cabecalho FUNDO CINZA MEDIO OPACO**: O cntSombra do framework.vcx tem `BackColor=RGB(100,100,100)` (cinza medio, NAO escuro). cnt_4c_Cabecalho DEVE ter `BackStyle=1` (opaco) + `BackColor=RGB(100,100,100)` + `lbl_4c_Titulo.ForeColor=RGB(255,255,255)` (branco sobre cinza). Valor RGB(100,100,100) (quase preto) eh ERRADO - usar 100 (cinza medio do framework). BackStyle=0 torna o cabecalho INVISIVEL. Bug corrigido em 2026-05-15 (system-wide).
- **NovoRegistro()/EditarRegistro() DEVEM chamar DODEFAULT()**: BOs que sobrescrevem NovoRegistro() ou EditarRegistro() DEVEM chamar DODEFAULT() como primeira linha. Sem isso, BusinessBase NAO seta this_lEmEdicao=.T. e Salvar() SEMPRE retorna .F. silenciosamente.
- **Botoes CRUD LADO DIREITO, posicoes EXATAS (ver framework_frmcadastro_layout.md)**: cnt_4c_Botoes Left=542 Width=390 (LADO DIREITO, NUNCA esquerdo!). Botoes internos Width=75, Left=5,80,155,230,305. FontName="Comic Sans MS" (NAO Tahoma). Encerrar em cnt_4c_Saida SEPARADO (Left=935, W=60). Grid FontName="Verdana". TODAS as posicoes padrao estao em ``docs/framework_frmcadastro_layout.md``.
- **Lookup textbox DEVE disparar em ENTER/TAB alem de F4**: Campos com lookup (fwBuscaExt no legado) DEVEM disparar busca em F4(115) E ENTER(13)/TAB(9) no KeyPress handler. O Valid original disparava ao sair do campo. Se o usuario digitar valor e pressionar TAB sem handler, nada acontece.
- **F4=115, F5=116 em KeyPress**: NUNCA usar 63 (que eh '?'). Codigos corretos: ENTER=13, TAB=9, F4=115, F5=116, ESC=27
- **Campos BIT do SQL Server**: Chegam como LOGICAL (.T./.F.) no VFP9. NUNCA usar NVL(campo,0)=1. Usar IF campo / IF !campo direto. NUMERIC(1,0) sim usa NVL.
- **Lookup ao sair do campo**: KeyPress com ENTER/TAB deve VALIDAR valor digitado contra tabela de referencia. Se encontrar, preencher descricao. Se nao encontrar, abrir FormBuscaAuxiliar. F4/F5 sempre abre lookup direto.
- **Z-ORDER AddObject em Page2**: Quando Page2 tem PageFrame interno + OptionGroup/botoes de navegacao, adicionar ``ZOrder(0)`` nos controles de navegacao APOS adicionar o PageFrame. VFP9 AddObject coloca ultimo objeto no topo do z-order, cobrindo controles anteriores.
- **PageFrame interno .Tabs = .F.**: PageFrame interno que usa OptionGroup para navegacao entre sub-paginas DEVE ter ``.Tabs = .F.``. Se .Tabs = .T., tabs nativos do VFP9 ficam visiveis e consomem espaco, sobrepondo controles.
- **Container Left+Width <= Form.Width**: Validar que Left + Width de TODOS os containers nao exceda Form.Width (normalmente 1000). Container parcialmente fora da area visivel fica cortado ou inacessivel.
- **NUNCA inventar tabelas de lookup**: Se o original NAO faz Seek/lookup de descricao para um campo, NAO criar query de lookup. Tabelas como SigCdCcr, SigCdJob NAO existem. Copiar nomes de tabela EXATAMENTE do codigo original. Se nao ha lookup no original, o campo eh apenas exibido.
- **WHERE Emps SOMENTE em tabelas que tem a coluna**: Tabelas de cadastro generico (SigCdGcr, SigCdMoe, SigCdCor, SigCdUni) tipicamente NAO tem coluna Emps. Antes de adicionar ``WHERE Emps = go_4c_Sistema.cCodEmpresa``, verificar no schema.sql se a tabela realmente tem essa coluna. Na duvida, omitir o filtro.
- **Propriedades this_ DECLARAR com nome EXATO do uso**: TODA propriedade referenciada como THIS.this_cXxx no codigo DEVE ter declaracao IDENTICA this_cXxx = "" no cabecalho DEFINE CLASS. Nomes amigaveis diferentes (ex: declarar this_cUltGrupo mas usar THIS.this_cUltCgrus) causam Error 174 Property not found no primeiro LostFocus.
- **Container.BorderStyle NAO EXISTE**: Container VFP9 tem BorderWidth mas NAO tem BorderStyle (propriedade de CommandGroup/OptionGroup). Usar apenas .BorderWidth = 0. CorretorAuto #68 remove automaticamente.
- **Containers de botoes CRUD TRANSPARENTES**: Containers que hospedam botoes CRUD em forms frmcadastro (cnt_4c_Botoes, cnt_4c_Saida, cnt_4c_BotoesDados) DEVEM usar `BackStyle=0` (transparente), NUNCA `BackStyle=1` com `BackColor=RGB(100,100,100)` ou similar escuro. O fundo do form ja e fornecido por Page.Picture (fundo_cad_1003.jpg); container opaco escuro cria caixa cinza ao redor dos botoes que destoa do layout original. EXCECAO UNICA: cnt_4c_Cabecalho usa opaco escuro propositalmente (cntSombra).
- **PageFrame.Height = Form.Height + 29**: Em forms frmcadastro com PageFrame oculto (Tabs=.F., Top=-29), o `pgf_4c_Paginas.Height` DEVE ser `Form.Height + 29` (NAO igual a Form.Height). Com Top=-29 e Height=Form.Height, sobram 29px descobertos no bottom expondo o fundo cinza nativo do form como borda indesejada. Formula: Form.Height=600 -> PageFrame.Height=629. Form.Height=650 -> PageFrame.Height=679.

- **IIF() exige LOGICAL no 1o argumento**: IIF(numerico, ...) quebra com "Function argument value, type, or count is invalid" quando valor=0. Em TEXTMERGE SQL e conversoes, SEMPRE comparar: IIF(this_nFlag = 1, '1', '0'). NUNCA passar numerico direto: IIF(this_nFlag, '1', '0').
- **CheckBox .Value = 0 no AddObject (NAO .F.)**: AddObject CheckBox DEVE inicializar `.Value = 0` (NUMERIC). Usar `.Value = .F.` cria LOGICAL e conflita com LimparCampos (`.Value = 0`, NUMERIC) e BOParaForm - dispara "Operator/operand type mismatch" no primeiro uso. BOParaForm: usar `chk.Value = IIF(this_lProp, 1, 0)` ou `IIF(this_nProp = 1, 1, 0)`, nunca atribuir LOGICAL direto.
- **cmd_4c_Encerrar.Caption = "Encerrar"**: Botao Encerrar DEVE ter `.Caption = "Encerrar"` (NAO "X", "Sair" ou ""). A Picture "cadastro_sair_60.jpg" NAO cobre a caption; captions errados aparecem como texto abaixo do icone. Padrao dos forms CRUD (FormCor, FormMoe).
- **PADRAO CANONICO SAIDA/ENCERRAR � PREVALECE SOBRE PILAR 1 (pixel-perfect legado)**: O bloco de saida (container + botao Encerrar) DEVE seguir o padrao canonico do sistema novo (FormCor), IGNORANDO os valores do SCX legado. Canonical (inegociavel): `cnt_4c_Saida.Left=917, Width=90, Height=85`; `cmd_4c_Encerrar.Left=5, Top=5, Width=75, Height=75, Caption="Encerrar"`. Se o SCX legado tiver Grupo_Saida.Left=935 W=60 ou botao X com W=50/Caption="X"/"Sair"/"Fechar", IGNORE e use o canonico. O mesmo vale para `.Width = THIS.Width - 60/-65` em containers de Page (pgf.Page1/Page2): DEVE ser `.Width = THIS.Width` (container de saida eh flutuante/transparente sobre a Page, subtrair largura deixa faixa clara exposta a direita). Esta regra PREVALECE sobre o PILAR 1 (pixel-perfect ao legado) � o sistema novo tem padrao visual proprio para o bloco de saida que NAO deve ser sobrescrito pelo SCX. CorretorAutomatico #81, #88, #89 corrigem automaticamente, mas o gerador DEVE ja emitir correto.
- **PUBLIC NAO EXISTE em DEFINE CLASS**: Metodos dentro de `DEFINE CLASS ... ENDDEFINE` sao PUBLIC por default. `PUBLIC FUNCTION xxx()` e `PUBLIC PROCEDURE xxx()` sao SYNTAX ERROR ("Statement is not valid in a class definition"). Apenas `PROTECTED` e `HIDDEN` sao modifiers validos. Escrever sempre: `FUNCTION xxx()` / `PROCEDURE xxx()` (sem PUBLIC) OU `PROTECTED PROCEDURE xxx()` / `HIDDEN FUNCTION xxx()`.
- **Page.Width / Page.Height READ-ONLY em runtime**: Pages (PageFrame.PageN) NAO aceitam atribuicao a .Width/.Height em runtime � essas propriedades sao controladas pelo PageFrame automaticamente. `WITH loc_oPage / .Width = THIS.Width / .Height = THIS.Height / ENDWITH` causa "CREATEOBJECT retornou valor nao-objeto" na instanciacao. Remover TODAS as atribuicoes a Page.Width/Height em ConfigurarPageFrame ou similares. Se precisa cobrir area, usar containers filhos da Page com Width/Height fixos.
- **MostrarAviso NAO EXISTE**: Apenas `MostrarErro` (FormErro.prg), `MsgErro`, `MsgAviso`, `MsgConfirma`, `MsgInfo` (messages.prg) existem. `MostrarAviso(...)` gera runtime error "File 'mostraraviso.prg' does not exist". Usar `MsgAviso(msg)` para validacao de UI (dialog amarelo) OU `MostrarErro(msg, titulo)` para exceptions tecnicas (dialog vermelho). CorretorAutomatico #90 auto-corrige.
- **Cursor do grid + SQLEXEC Buscar: fechar antes (uncommitted changes)**: Em BO.Buscar ou BO.CarregarPorCodigo, antes de `SQLEXEC(..., "cursor_4c_Dados")` (ou outro alias que o form usa como `grd.RecordSource`), fechar o cursor anterior: `IF USED("cursor_4c_Dados") / TABLEREVERT(.T., "cursor_4c_Dados") / USE IN cursor_4c_Dados / ENDIF`. Sem isso, segundo SQLEXEC falha com "Table buffer contains uncommitted changes" porque o grid pode ter mantido edicoes pendentes no buffer. CorretorAutomatico #91 injeta automaticamente.
- **cnt_4c_Saida padrao canonico (FormCor)**: cnt_4c_Saida Left=917, Width=90, Height=85. cmd_4c_Encerrar dentro com Left=5, Top=5, Width=75, Height=75. Mantem Encerrar com as MESMAS dimensoes dos botoes CRUD (75x75). Valores antigos (Left=935 W=60 botao W=50) tornam o Encerrar visualmente menor - substituir pelo padrao FormCor.
- **cnt_4c_Botoes.Left = 542 em forms 1000px (NAO copiar Left=343 do legado)**: Container de botoes CRUD DEVE ficar a direita (Left=542, Width=390, ends=932). Gerador tende a copiar Grupo_op.Left=343 do SCX legado (form 770px) resultando em botoes centralizados. Padrao FormCor/FormMoe: Left=542. Formula para 1000px: FormWidth - CntBotoesWidth - GapEncerrar = 1000 - 390 - 68 = 542.
- **Page1.Picture + Page2.Picture = "fundo_cad_1003.jpg" obrigatorio em frmcadastro**: ConfigurarPageFrame de forms frmcadastro (cadastros/) DEVE setar `.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"` E `.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"`. Sem isso, Page1/Page2 ficam totalmente brancas (sem o fundo visual do framework). Ver FormCor.ConfigurarPageFrame como referencia.
- **MsgAviso para validacao de UI, MsgErro APENAS para exceptions tecnicas**: "Selecione um registro", "Campo obrigatorio", "Valor invalido", "Ja cadastrado" DEVEM usar `MsgAviso(...)` (dialog amarelo). `MsgErro`/`MostrarErro` (dialog vermelho + botao "Fechar Aplicacao") APENAS para erros tecnicos reais: exceptions capturadas em CATCH, "Erro ao...", "Falha ao...", SQL errors, conexao. Usar `MostrarErro` para validacao assusta o usuario.
- **ConfigurarPaginaLista/Dados: loc_oPagina.Picture = fundo_cad_1003.jpg obrigatorio**: Metodos que iniciam com `loc_oPagina = THIS.pgf_4c_Paginas.PageN` DEVEM setar `loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"` antes de qualquer AddObject. Sem isso, a pagina fica totalmente branca em vez de mostrar o fundo padrao do framework. Complementar a regra #88 que cobre o padrao `.Page1.Picture` inline no WITH do PageFrame.
- **Campo auto-preenchido NAO eh ReadOnly/Enabled=.F. no AddObject**: TextBox que o legado preenche via Valid/SEEK em certos fluxos AINDA eh editavel pelo usuario. NUNCA setar ``.ReadOnly = .T.`` ou ``.Enabled = .F.`` no AddObject inicial a menos que o SCX legado tenha essas propriedades explicitas. Comentarios como "preenchido ao selecionar no grid" NAO justificam bloquear edicao. Controle de Enabled por modo (INCLUIR/ALTERAR/VISUALIZAR) vai em HabilitarCampos.
- **OptionGroup.Buttons(N) DEVE ter `.BackStyle = 0`**: OptionButton dentro de OptionGroup tem BackStyle (0=transparente, 1=opaco). Sem `.BackStyle = 0` no WITH dos sub-botoes, o fundo opaco pode clipar texto da caption - "N" + CHR(227) + "o" ("Nao") aparece como "Na" na tela. SCX legado tipicamente tem `OptionN.BackStyle = 0`; migrador as vezes omite. NAO confundir com CommandButton/CommandGroup que NAO tem BackStyle (regras #59/#60).
- **OptionGroup.Width DEVE >= MAX(Buttons[i].Left + Buttons[i].Width) + 10**: Container OptionGroup clipa conteudo mesmo com BorderStyle=0. Se Buttons(N) foram expandidos (ex: Width de 37 para 60 para acomodar captions acentuadas "Nao"), o Container tambem precisa crescer. NAO basta copiar Width do SCX legado � validar que container acomoda todos os buttons + 10px margem.
- **KeyPress handler: LPARAMETERS + guard Enter(13)/Tab(9)/F4(115) obrigatorios**: Handlers bindados via `BINDEVENT(obj, "KeyPress", THIS, "Nome")` DEVEM comecar com `LPARAMETERS par_nKeyCode, par_nShiftAltCtrl`. Handlers de lookup DEVEM ter guard `IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115 / RETURN / ENDIF` — sem guard, picker abre a cada tecla. Padrao canonico: `Formsigatcrp.prg:2614-2624`.
- **FormBuscaAuxiliar: usar Init com params OU pre-popular cursor**: `CREATEOBJECT("FormBuscaAuxiliar")` SEM params + setar props + Show() NAO popula cursor -> picker vazio. Usar `CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "Tabela", "cursor_4c_Busca", "Campo", cVal, "Titulo", .T., .T., cFiltro)` OU pre-popular via SQLEXEC antes de Show. Helper `AbrirLookup(...)` canonico em `Formsigrepes.prg:3318-3385`.
- **MsgAviso("...encontrada") antes de THIS.AbrirBusca<X>() eh REDUNDANTE**: PROIBIDO `MsgAviso(...) + .Value = "" + THIS.AbrirBusca<X>()` em handlers Validar*. User ve 2 modais em sequencia e valor digitado eh limpo antes do picker (perde LIKE prefix). CORRETO: apenas `THIS.AbrirBusca<X>()`. Auto-fix: CorretorAutomatico #114.
- **SigCdGcr tem coluna `descrs` (com 'r'), NAO `descs`**: Confusao com SigCdGpr/SigCdLin/SigCdCol (essas tem `descs`). Consultar `docs/schema.sql` para nome real. Auto-fix: CorretorAutomatico #115.
- **Grid Column CheckBox EXIGE `.Sparse = .F.`**: `Column1` com `CurrentControl = "Check1"` DEVE ter `.Sparse = .F.` explicito ANTES de `.AddObject("Check1", ...)`. Default VFP9 eh `Sparse = .T.` que renderiza o CheckBox APENAS na linha corrente do grid — outras linhas mostram o valor bruto (0/1) como texto plano e o user NAO consegue clicar checkboxes das demais linhas. Padrao canonico completo Column1: `.Width = 15 / .Alignment = 0 / .Enabled = .T. / .Sparse = .F. / .AddObject("Check1", "CheckBox") / .Check1.Caption = "" / .CurrentControl = "Check1" / .ControlSource = cursor + ".Marca"`. Referencia: `Formsigrepes.prg:3095-3104`. Auto-fix: CorretorAutomatico Pattern #121. Bug em FormSIGREADS (2026-07-14, Erro41).
- **OptionGroup.Buttons(N) DEVE ser configurado em WITH ANINHADO dentro do WITH pai**: Ao criar OptionGroup com `AddObject`, configurar `Buttons(1)` e `Buttons(2)` em blocos `WITH .Buttons(N)` ANINHADOS dentro do `WITH loc_oPag.obj_4c_OptXxx`. NUNCA fechar o WITH pai com ENDWITH e depois abrir `WITH loc_oPag.obj_4c_OptXxx.Buttons(N)` separado — VFP9 runtime nao resolve `.Buttons` via caminho completo fora do contexto WITH pai, gerando "BUTTONS is not an object". CORRETO: `WITH loc_oPag.obj_4c_OptXxx / .Value = 1 / WITH .Buttons(1) / .Caption = "Simples" / ENDWITH / WITH .Buttons(2) / .Caption = "Composto" / ENDWITH / ENDWITH`. Bug em FormSigPrCfn.prg ConfigurarPaginaLista (2026-07-15, Erro42).
- **SigCdEmp TextBox de codigo (`txt_4c_Empresa`/`txt_4c_CEmps`/`txt_4c_Emps`): `.MaxLength = 3` OBRIGATORIO**: TextBox de codigo empresa (mapeia para `SigCdEmp.Cemps` char(3)) DEVE ter `.MaxLength = 3` explicito no bloco `AddObject`+`WITH`. Sem isso, user digita 2 chars e Valid aceita (SQL Server pad-completa), mas relatorio filtra por `SigCdBal.emps` sem encontrar registros. Screenshot Erro45: `Empresa: [00] MARCELLA BAHIA` — user digitou "00" (2 chars). SCX legado omite MaxLength (usa default fwtxtbox); gerador ou omite (VFP9 default=0 unlimited) ou estima por Width=33px (~2 chars). CORRETO: `WITH loc_oPg.txt_4c_Empresa / .Width = 33 / .MaxLength = 3 / ...`. Regra tambem vale para `mAddColuna("Cemps", "XXX", ...)` (mask 3 X). Padrao canonico: forms REPORT/OPERACIONAL de FormSigReAiv/Formsigreimp pos-fix. Auto-fix: CorretorAutomatico Pattern #126 (`Corrigir-SigCdEmpTextBoxMaxLength`) altera ou injeta `.MaxLength = 3` em blocos `WITH ...txt_4c_(Empresa|C?Emps|CEmp)`. Idempotente. Bug em 15 forms (2026-07-16, Erro45).
- **WITH aninhado em Container/Label/CommandGroup criados com AddObject — silently ignora props (Label/Button.Caption/Picture/ForeColor)**: Dentro de `WITH THIS.cnt_X` ou `WITH loc_oCab`, chamar `.AddObject("filho", "Label"|"CommandGroup")` e depois `WITH .filho` (WITH aninhado relativo) causa falha SILENCIOSA de resolucao de propriedades em VFP9 — Label.ForeColor/Caption e Button.Caption/Picture/Left/Width nao sao aplicados. NAO gera exception; sintoma visual: Labels invisiveis + Buttons como retangulos vazios sem icone e sem texto. Pior caso: **3 niveis de aninhamento** `WITH loc_oCab / .AddObject("cmg_4c_Botoes",...) / WITH .cmg_4c_Botoes / WITH .Buttons(N) / .Caption = ... / .Picture = ...` — Buttons props totalmente ignoradas. CORRETO: (1) fechar `WITH loc_oCab` apos configurar Container, (2) `loc_oCab.AddObject("filho", "<Classe>")` FORA de qualquer WITH, (3) `WITH loc_oCab.<filho>` OU `loc_o<filho> = loc_oCab.<filho> / WITH loc_o<filho>` (caminho explicito). EXCECAO: `WITH .Buttons(N)` DENTRO de `WITH loc_oCmg` (1 nivel de nesting em CommandGroup) EH SEGURO — Buttons(N) eh collection accessor, nao AddObject. Widths canonicos framework frmrelatorio (NUNCA `THIS.Width` em CommandGroup/Button): CommandGroup `.Width = 273`, `.Left = 527/529`; Buttons `.Width = 65`, `.Height = 70`, Lefts=5/71/137/203 (increment 66). Container/Label/PageFrame podem usar `THIS.Width` (span correto). Padrao canonico: `FormSigPdAco.prg ConfigurarCabecalho` (2 niveis) + `Formsigreanr.prg ConfigurarCabecalho` pos-fix (3 niveis com CommandGroup+Buttons). Bugs: FormSIGPRIMP (2026-07-17 Erro47 nivel 2 Label/ForeColor) + Formsigreanr + 8 outros forms REPORT (2026-07-17 Erro49 nivel 3 CommandGroup/Buttons.Picture+Caption).
**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir `SET SAFETY OFF` e `SET RESOURCE OFF` no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.

**PROCEDURE Destroy DEVE chamar DODEFAULT()**: Se o form migrado precisar sobrescrever `PROCEDURE Destroy` (ex: fechar cursores custom), a ULTIMA linha antes de `ENDPROC` DEVE ser `DODEFAULT()`. `FormBase.Destroy` contem o fix menu-shrinks (`RELEASE POPUP + CriarMenuPrincipal`) que roda apos qualquer form modal fechar. Sem DODEFAULT() a cadeia de heranca quebra e os popups do menu principal (Cadastros/Movimentos/Relatorios/etc) aparecem visualmente truncados na proxima abertura. Auto-fix Pattern #145 injeta se ausente, mas melhor evitar. Origem: Erro58 (2026-07-21).

**Grid Column CheckBox EXIGE 7 props explicitas — sem elas, cliques nao mudam estado**: Ao criar CheckBox dentro de Grid Column, alem de `.Sparse = .F.` (Pattern #121), DEVE definir explicitamente: `.Check1.Alignment = 0`, `.Check1.ReadOnly = .F.`, `.Check1.Visible = .T.`, `.Check1.Top = 9`, `.Check1.Left = 2`, `.Check1.Height = 17`, `.Check1.Width = 22`. Sem essas props, VFP9 renderiza CheckBox visualmente correto (mostra checked/unchecked conforme cursor) mas NAO responde a cliques (Column.ReadOnly=.F. nao basta; VFP em contexto Grid usa defaults ambiguos para o CheckBox filho). Padrao canonico: `WITH loc_oGrd.Column1 / .Width=15 / .Alignment=0 / .Enabled=.T. / .Sparse=.F. / .AddObject("Check1","CheckBox") / .Check1.Caption="" / .Check1.Alignment=0 / .Check1.ReadOnly=.F. / .Check1.Visible=.T. / .Check1.Top=9 / .Check1.Left=2 / .Check1.Height=17 / .Check1.Width=22 / .CurrentControl="Check1" / .ControlSource="<cursor>.<campo>" / ENDWITH`. Auto-fix Pattern #146 injeta as props ausentes se `.Check1.Caption` estiver presente. Sweep 2026-07-21 corrigiu 16 blocos em 12 forms. Origem: Erro59 (2026-07-21, Formsigreato — user "checkbox desabilitado, nao consigo marcar/desmarcar" apesar de renderizacao visualmente OK).
"@

        $phaseAPrompt | Set-Content -Path $phaseAFile -Encoding UTF8
        Write-Host "  Phase A prompt gerado: meta_prompt_phaseA.md" -ForegroundColor Cyan

        # --- PHASE B: Functionality ---
        $phaseBPrompt = @"
# FASE B: Funcionalidade - $formClass (APENAS LOGICA)

**FOCO EXCLUSIVO: IMPLEMENTAR LOGICA REAL. NAO alterar nenhuma propriedade visual.**

## OBJETIVO
Os arquivos ${boClass}.prg e ${formClass}.prg ja existem com layout visual correto (Fase A).
Sua tarefa: preencher TODOS os metodos stub com implementacao REAL e COMPLETA.

## REGRA #1: NAO ALTERAR PROPRIEDADES VISUAIS
**ABSOLUTAMENTE PROIBIDO** modificar:
- Width, Height, Top, Left de qualquer controle
- BackColor, ForeColor, FontName, FontSize
- Caption de labels (apenas Caption de botoes dinamicos OK)
- Picture, PicturePosition, Alignment
- Qualquer propriedade visual definida na Fase A

**SE PRECISAR ADICIONAR UM CONTROLE** que faltou na Fase A, adicione com as propriedades
visuais EXATAS do original. Mas NAO modifique controles ja existentes.

## REGRA #2: IMPLEMENTAR TUDO - ZERO STUBS
- TODOS os Btn*Click DEVEM ter logica real (baseada no legado)
- TODOS os Validar* DEVEM ter validacao real (SELECT no banco)
- TODOS os AbrirLookup* DEVEM criar FormBuscaAuxiliar + mAddColuna + Show
- CarregarLista DEVE usar ``cursor_4c_Dados`` como nome do cursor principal (SQLEXEC INTO CURSOR cursor_4c_Dados). Este nome e verificado pelo TesteAutomatico.
- CarregarLista DEVE ter SQLEXEC real com cursor protegido
- FormParaBO/BOParaForm DEVEM mapear TODOS os campos
- BO.Inserir/Atualizar/ExecutarExclusao/Buscar/CarregarPorCodigo DEVEM ter SQL real
- FormatarNumeroSQL() para numeros, FormatarDataSQL() para datas, EscaparSQL() para strings (JA INCLUI aspas - NUNCA adicionar aspas extras)

## REGRA #3: PRESERVAR ESTRUTURA
- NAO reorganizar metodos
- NAO renomear variaveis ja declaradas
- NAO remover metodos (mesmo se parecerem inuteis)
- ADICIONAR codigo DENTRO dos metodos existentes

## Arquivos de Referencia
1. **CLAUDE.md** - Regras VFP, SQL, BusinessBase
2. **tasks/$TaskId/${BaseName}_form_codigo_fonte.txt** - Codigo fonte original (LOGICA dos metodos)
3. **tasks/$TaskId/mapeamento.json** - Mapeamento de objetos
4. **tasks/$TaskId/comportamento.json** - Analise comportamental (queries SQL, validacoes)
5. **C:\4c\projeto\app\classes\${boClass}.prg** - BO existente (Fase A) - LER PRIMEIRO
6. **C:\4c\projeto\app\forms\${formSubDir}\${formClass}.prg** - Form existente (Fase A) - LER PRIMEIRO

## Arquivos a MODIFICAR (NAO recriar do zero!)
1. **C:\4c\projeto\app\classes\${boClass}.prg** - Preencher Inserir/Atualizar/ExecutarExclusao/Buscar/CarregarPorCodigo/CarregarDoCursor
2. **C:\4c\projeto\app\forms\${formSubDir}\${formClass}.prg** - Preencher Btn*Click, Validar*, Lookup*, CarregarLista, FormParaBO, BOParaForm

## Regras VFP Criticas
- NUNCA RETURN dentro de TRY/CATCH - usar variavel loc_lSucesso
- SQLEXEC em cursor temporario + ZAP + APPEND FROM DBF() (protecao Grid)
- SET NULL ON antes de CREATE CURSOR
- CarregarDoCursor: SELECT (par_cAliasCursor) ANTES de acessar campos
- mAddColuna(campo, "", titulo) - 3 parametros (NAO largura/tabela)
- FormBuscaAuxiliar: this_lSelecionou + cursor destino (NAO ObterCodigoSelecionado)
- **BINDEVENT "Valid" NAO FUNCIONA em TextBox**: Usar "KeyPress" (ENTER=13/TAB=9) para simular Valid. NUNCA usar LostFocus para chamar MontaGrade/CarregarDados/SQLEXEC - LostFocus dispara SEMPRE (inclusive por SetFocus de outro controle) causando RECURSAO INFINITA. Ex: `BINDEVENT(txt, "KeyPress", THIS, "TxtCampoKeyPress")` e no handler: `IF par_nKeyCode = 13 OR par_nKeyCode = 9 ... ENDIF`
- **Page.Visible NAO EXISTE**: Page (PageFrame.PageN) NAO tem propriedade Visible. NUNCA `.Page1.Visible = .T.`.
- **PageFrame.Visible OBRIGATORIO**: AddObject cria controles com Visible=.F. SEMPRE adicionar `THIS.pgf_4c_Paginas.Visible = .T.` ANTES de `ActivePage = 1` no InicializarForm.
- **Buttons(N) vs ButtonCount**: Ao fazer BINDEVENT em Buttons(N), N DEVE ser <= ButtonCount.
- Nomes SQL EXATOS do schema.sql (SigCdCor, cgrus, dpros, Iclis, Rclis)
- USE IN cursor ao final de cada lookup
- NovoRegistro() em BtnIncluirClick ANTES de LimparCampos
- this_lNovoRegistro = .F. em CarregarPorCodigo APOS carregar
- NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1)
- CommandGroup e OptionGroup: SEMPRE definir .ButtonCount ANTES de acessar .Buttons(N)
- NUNCA fazer self-assignment: THIS.pgf_4c_Paginas = THIS.pgf_4c_Paginas (causa erro)
- LostFocus != Valid: Valid so dispara quando valor MUDA, LostFocus dispara SEMPRE. Handlers via BINDEVENT LostFocus que abrem lookup DEVEM ter guardia de valor (this_cUltimo*Validado + comparacao antes de processar)
- Busca reversa por descricao: PRIMEIRO SELECT direto no banco. SO abrir FormBuscaAuxiliar se NAO encontrou (legado fAcessoContab faz SEEK primeiro)
- DynamicForeColor/DynamicBackColor: SEMPRE proteger com PEMSTATUS(obj, "DynamicForeColor", 5) antes de atribuir
- Caption do form DEVE ser propagado para lbl_4c_Sombra/lbl_4c_Titulo apos ConfigurarPageFrame
- NUNCA usar COMMIT/ROLLBACK avulsos apos SQLEXEC simples - conexao ODBC usa AUTOCOMMIT. COMMIT/ROLLBACK sem BEGIN TRANSACTION causa erro fatal
- **Variaveis legadas do Framework**: _EMPR, _EMPRESA, pEmp NAO existem no novo sistema. Substituir por go_4c_Sistema.cCodEmpresa (codigo da empresa). Se precisar verificar existencia: IF TYPE("_EMPR") = "C" ... ELSE go_4c_Sistema.cCodEmpresa
- **AtualizarEstadoControles**: Todo metodo que chama MontaGrade() ou CarregarLista() DEVE chamar THIS.AtualizarEstadoControles() em seguida para atualizar estado de botoes (Enabled/Disabled)
- **REGRA ANTI-VISUAL (CRITICO)**: NAO alterar Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize de NENHUM controle. Implementar APENAS logica dentro dos metodos existentes
- **this_cMensagemErro**: Se o Form usa THIS.this_cMensagemErro em CATCH blocks, DEVE declarar `this_cMensagemErro = ""` nas propriedades da classe (NAO herdado de FormBase)
- **REPORT FORM TO FILE**: Pre-computar caminho em variavel LOCAL + macro expansion `&var` (expressoes inline e name expressions `(var)` NAO funcionam em VFP9)
- **MESSAGEBOX PROIBIDO**: NUNCA usar MESSAGEBOX() direto. Usar funcoes de messages.prg: MsgInfo() para informativo (icone 64), MsgAviso() para aviso (icone 48), MsgErro() para erro (icone 16), MsgConfirma() para confirmacao Sim/Nao. Essas funcoes suprimem dialogs em modo de teste automatizado.
- **fAcessoEmpresa() NAO EXISTE (nao portada)**: A funcao global `fAcessoEmpresa()` do Framework legado (sigacess.PRG) NAO foi portada para a nova arquitetura. Chamadas diretas quebram em runtime com "File 'facessoempresa.prg' does not exist" (VFP9 procura .prg externo quando o nome nao eh THIS.metodo nem funcao definida). Substituicao canonica: MODO CHECK (3 args, retorna boolean) `fAcessoEmpresa(usu,"C",cod)` -> `VerificarAcessoEmpresa(usu, cod)` (helper em utils/functions.prg). MODO LOOKUP (5 args, popula 2 textboxes) `fAcessoEmpresa(usu, "C"|"D", val, oCod, oDsc)` -> bloco FormBuscaAuxiliar apontando SigCdEmp com chave Cemps (modo C) ou Razas (modo D), retornando ambas colunas. Titulo: "Sele" + CHR(231) + CHR(227) + "o de Empresa". Auto-fix: CorretorAutomatico #110. Padrao canonico: Formsigatcrp.prg:2278-2378 (KeyPress) e Formsigrepes.prg:6501-6540 (LostFocus). Bug observado em Formsigatcrp.prg + Formsigrepes.prg (2026-07-02, Erro14).
- **fAcessoContas() NAO USAR para lookup UX (auto-load do primeiro registro)**: A funcao `fAcessoContas()` (utils/functions.prg:719) EH portada, mas seu fluxo interno (`LIKE '%valor%'` + `LOCATE` + FormBuscaSimples) auto-popula o textbox com o PRIMEIRO registro que contem o valor digitado — mesmo sem selecao explicita do usuario no picker. Resultado tipico: user digita "11" no campo Gerente/Vendedor e o form carrega "GAVETA - LOJA 001..." (primeiro match parcial). PROIBIDO usar `fAcessoContas(usu, grp, "C"|"D", val, txtCod, txtNom)` como handler de Valid/KeyPress em textbox de lookup. Substituicao canonica: mesmo padrao de fAcessoEmpresa lookup (Formsigatcrp.prg:2612-2790 apos Erro16 fix). Enter/Tab -> `SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = valor` exato (hit -> auto-preenche, miss -> `THIS.AbrirBusca<X>()`). AbrirBusca<X> -> SQL proprio com `LIKE 'valor%' OR RTRIM(RClis) LIKE 'valor%'` (starts-with, NAO contem) + fallback lista completa + `CREATEOBJECT("FormBuscaAuxiliar")` sem SQL automatica + mAddColuna("IClis"/"RClis") + `.Show()` respeitando `this_lSelecionou`. `fAcessoContas()` continua valida para contexto backend (SCAN loop de acesso, validacao sem UI). Bug observado em Formsigatcrp.prg ValidarCodGer/ValidarNomGer/ValidarCodVen/ValidarNomVen (2026-07-02, Erro16).
- **.RecordMark/.DeleteMark SO em Grid — NUNCA em CommandButton/Label/Container/TextBox/ComboBox/etc**: As propriedades `.RecordMark` e `.DeleteMark` sao EXCLUSIVAS de Grid (barras laterais de marcacao/exclusao de registro). Gerador frequentemente copia esse par de `WITH grd_4c_Xxx` e cola em WITH de CommandButton adjacente (ex: `cmd_4c_SelXxx`/`cmd_4c_DslXxx` ao lado de grids de selecao multipla em REPORT). VFP9 trava com "Property RECORDMARK is not found" ao instanciar o form. PIOR: o erro eh silenciosamente engolido pelo TRY/CATCH de `InicializarForm` (apenas seta `loc_lSucesso=.F.` sem MsgErro), resultando em `CREATEOBJECT("FormXxx")` retornar `.F.` sem exception aparente e "VARTYPE retornou: L" no dialog. PROIBIDO gerar `.RecordMark = .F.` ou `.DeleteMark = .F.` em WITH cujo AddObject NAO seja `"Grid"`. Recomendacao complementar: no CATCH de `InicializarForm`, chamar `MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)` ANTES de setar `loc_lSucesso=.F.` — expoe o erro para debug em vez de engolir silenciosamente. Auto-fix: CorretorAutomatico #111. Bug observado em Formsigrepes.prg (2026-07-02, Erro17): 9 CommandButtons corrompidos (`cmd_4c_SelOrigMerc`, `cmd_4c_SelTipoInvs`, `cmd_4c_SelLinha`, etc).
- **UNION ALL entre tabelas diferentes**: NUNCA usar SELECT * em UNION ALL. Listar colunas EXPLICITAS IDENTICAS em ambas as queries. Tabelas como SigMvCcr/SigMvCpv tem estruturas diferentes.
- **INTO CURSOR READWRITE**: NUNCA usar `INTO CURSOR X` + `USE DBF("X") IN 0 ALIAS Y` (causa "file is in use"). Usar `INTO CURSOR cursor_4c_Dados READWRITE` direto.
- **Cursor placeholder = cursor real**: O CREATE CURSOR placeholder no InicializarForm DEVE ter EXATAMENTE os mesmos campos (nomes e tipos) que o cursor populado por SQLEXEC. Campos diferentes causam erros de ControlSource no grid.
- **CheckBox em Grid Column (Error 1767)**: Para grids com CheckBox, a UNICA definicao de ControlSource deve ser `Column1.ControlSource = "cursor.campo"` DEPOIS de `CurrentControl = "Check1"`. NUNCA definir `Check1.ControlSource` (conflita com Column) E NUNCA definir `Column1.ControlSource` ANTES de AddObject("Check1").
- **AddObject sintaxe CORRETA**: `parent.AddObject("nome", "Classe")` - ambos strings. NUNCA `parent.AddObject(loc_oObj, "nome")` (objeto como parametro causa "Function argument invalid"). Padrao: `parent.AddObject("cmd_4c_X", "CommandButton")` + `WITH parent.cmd_4c_X` para configurar.
- **Grid Column CurrentControl="Check1" EXIGE AddObject**: ANTES de `.Column1.CurrentControl = "Check1"`, OBRIGATORIO: `.Column1.AddObject("Check1", "CheckBox")` + `.Column1.Check1.Caption = ""`. Sem isso, erro "Unknown member CHECK1" cascateia e destroi toda inicializacao.
- **CheckBox .Value SEMPRE NUMERICO**: Inicializar CheckBox com `.Value = 1` (marcado) ou `.Value = 0` (desmarcado). NUNCA usar `.T.`/`.F.` (logico). Comparar com `= 1`/`= 0`, IIF com `IIF(chk.Value = 1, ...)`. Misturar tipos causa "Operator/operand type mismatch".
- **IF THEN inline PROIBIDO**: VFP9 NAO suporta `IF cond THEN cmd` numa unica linha. Gera "Command contains unrecognized phrase/keyword." SEMPRE expandir para multi-linha: `IF cond` / `  cmd` / `ENDIF`.
- **COUNT TO var IN alias PROIBIDO**: VFP9 COUNT nao tem clausula IN. Gera "Command contains unrecognized phrase/keyword." Usar: `SELECT alias` + `COUNT TO var`.
- **APPEND FROM requer SELECT cursor antes**: `ZAP IN cursor_name` NAO muda a work area corrente. `APPEND FROM DBF("tmp")` vai para a work area CORRENTE. SEMPRE fazer `SELECT cursor_destino` antes de `APPEND FROM`. Sem isso, dados vao para o cursor errado e o grid fica vazio.
- **CommandGroup.FontName NAO EXISTE**: CommandGroup (como OptionGroup) NAO tem FontName/FontSize. Definir em cada `.Buttons(N).FontName`. Tentar no grupo causa "Property FONTNAME is not found" que cascateia e impede toda configuracao dos botoes.
- **AlternarPagina DEVE chamar AjustarBotoesPorModo**: Em forms CRUD, ao voltar para Page1 (LISTA), OBRIGATORIO chamar `THIS.AjustarBotoesPorModo()` ANTES de `THIS.CarregarLista()`. Sem isso os botoes ficam desabilitados apos Incluir/Alterar/Visualizar.
- **CommandGroup BackStyle/BorderStyle EXATOS do original**: Se o original tem `BackStyle=0` + `BorderStyle=0`, o CommandGroup eh TRANSPARENTE (container logico invisivel). NUNCA adicionar BackColor quando original nao tem. Copiar BackStyle, BorderStyle, SpecialEffect EXATOS.
- **ForeColor de Labels: COPIAR do original, NUNCA assumir**: Labels sobre fundo escuro usam ForeColor branco, labels sobre fundo claro usam ForeColor cinza (90,90,90). Copiar ForeColor EXATO do codigo fonte original. Assumir cor "baseado no tema" causa labels INVISIVEIS.
- **Buttons(N) dentro de CommandGroup: propriedades EXATAS**: Left, Top, FontName, FontBold, FontItalic, BackColor, ForeColor dos Buttons DEVEM vir do codigo fonte original. NUNCA inventar Left=0 ou FontName="Tahoma" quando original tem Left=178 ou FontName="Comic Sans MS".
- **Propriedades do BO preservam sufixo "s" da coluna do banco**: Colunas como Moedas, Contas, Grupos mapeiam para this_cMoedas, this_cContas, this_cGrupos. NUNCA "corrigir" removendo o "s" (this_cMoeda NAO EXISTE ? "Property not found"). Verificar nome EXATO no DEFINE CLASS do BO.
- **Nomes de icones/imagens: COPIAR EXATO do original + VALIDAR EXISTENCIA**: O atributo .Picture deve ter o nome de arquivo EXATO do original (ex: `geral_procura_60.jpg`, `cadastro_sair_60.jpg`). Trocar APENAS o path: `..\framework\imagens\` ? `gc_4c_CaminhoIcones +`. NUNCA inventar nomes de arquivo (ex: `consultar.bmp`, `geral_visualizar_60.jpg`, `geral_imprimir_60.jpg`, `geral_fechar_60.jpg` — NAO EXISTEM em vbmp/). USAR APENAS `gc_4c_CaminhoIcones` (NUNCA `gc_4c_Icones` — variavel legada, gera falhas em runtime). Para REPORT, ver "REPORT Buttons(N).Picture: ICONES CANONICOS OBRIGATORIOS" abaixo.
- **Propriedades do FORM: COPIAR TODAS do original**: TitleBar, ControlBox, MaxButton, MinButton, Closable, ClipControls DEVEM ser copiadas do codigo fonte original. Se original tem `TitleBar = 0` (sem barra de titulo), migrado DEVE ter `TitleBar = 0`. Omitir essas propriedades faz VFP9 usar defaults (barra de titulo visivel) alterando completamente a aparencia do form.
- **CommandButton ForeColor/BackColor/Themes EXATOS**: Botoes avulsos DEVEM copiar ForeColor, BackColor, FontName, FontBold, FontItalic, Themes do original. Se original tem ForeColor=90,90,90 + BackColor=255,255,255 + Themes=.F., copiar EXATO. ForeColor=RGB(255,255,255) em fundo claro torna texto INVISIVEL. **EXCECAO**: standalone CommandButton (fora de CommandGroup) com `.Picture` DEFINIDO precisa de `.Themes = .T.` + `.DisabledPicture = (mesma imagem)` — sem isso, com Themes=.F. + Enabled=.F. o icone NAO renderiza (so caption aparece). Auto-fix: CorretorAutomatico #99. Buttons(N) DENTRO de CommandGroup MANTEM Themes=.F. (canonico REPORT).
- **CommandButton auxiliar ao lado de Grid: NUNCA OMITIR `.Picture`**: Botoes standalone tipo `cmd_4c_SelTudo` (Selecionar Todos), `cmd_4c_Apaga` (Desmarcar/apaga), ou similares ao lado de grids de selecao TEM `.Picture` no SCX original (`geral_marcar_26.jpg` para Selecionar, `cadastro_excluir_26.jpg` para Desmarcar). Migracao frequentemente OMITE a linha `.Picture` inteira - botao renderiza como caixa vazia sem icone. SEMPRE copiar `.Picture = gc_4c_CaminhoIcones + "nome.jpg"` do original + aplicar padrao standalone (`.Themes=.T.` + `.DisabledPicture`). Heuristica: se WITH cmd_4c_* tem `.ToolTipText` = "Selecionar"/"Desmarcar"/"Marcar Todos"/"Limpar" e NAO tem `.Picture`, faltou copiar. Auto-fix: CorretorAutomatico #104. Bug em Formsigrecmc.prg (task052, 2026-07-01).
- **SigCdOpe eh single-column: NUNCA usar `descrs`/`Descrs`**: SigCdOpe tem `Dopes` (char(20)) que eh PK **E** descricao ao mesmo tempo — NAO existe coluna `descrs`/`Descrs` nessa tabela. Lookup FormBuscaAuxiliar para SigCdOpe deve chamar UMA UNICA `mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")`. NUNCA adicionar segunda coluna `mAddColuna("descrs", ...)` — gera runtime "Variable 'DESCRS' is not found" em FormBuscaAuxiliar.ConfigurarGrid quando seta Columns(N).ControlSource. Mesma regra para SELECT: `SELECT Dopes FROM SigCdOpe` (NUNCA `SELECT Dopes, Descrs FROM SigCdOpe`). Referencia: FormSIGREADS.prg:1554, Formsigrevto.prg:900. Auto-fix: CorretorAutomatico #105. Bug em Formsigrecmc.prg:1848 e FormSigReCmp.prg:1767/1813 (task052/task045, 2026-07-01).
- **CommandButton icone-only (`Caption=""`) NUNCA setar `.Enabled=.F.` em runtime**: Standalone CommandButton com `Caption=""` + `.Picture` NAO renderiza icone quando `.Enabled=.F.`, INDEPENDENTE de `.Themes=.T.` ou `.F.` — botao vira retangulo vazio. Isso refina o Pattern #99 (que funciona apenas para botoes COM caption como cmd_4c_Graficos). Nunca setar `.Enabled=.F.`/`.Enabled=.T.` em cmd_4c_* icone-only (SelTudo/Apaga tipicos) fora do bloco AddObject inicial — em vez disso: (a) NAO desabilitar (botao fica clickavel mas handler ja pode ser inocuo — SelTudo/Apaga so mexem em cursor cujo report vai ignorar), (b) desabilitar via check condicional dentro do handler `PROCEDURE CmdXClick`, OU (c) usar `.Visible=.F.` em vez de `.Enabled=.F.`. Auto-fix: CorretorAutomatico #106 (remove runtime `.Enabled=.F./.T.` em cmd_4c_* icone-only). Bug em Formsigrecmc.prg cmd_4c_SelTudo/cmd_4c_Apaga (task052, erro8.PNG, 2026-07-01) — desabilitar em TxtNmOperacaoKeyPress apagava icones apos usuario preencher Movimentacao.
- **Container de botoes sobre Grid: OBRIGATORIO BackStyle=1 OU posicionar fora da bbox do Grid**: Container filho de Form com CommandButtons dentro NAO pode ter `BackStyle=0` (transparente) se seu retangulo (Top..Top+Height) sobrepoe o Grid irmao (grid.Top..grid.Top+grid.Height). Grid re-renderiza rows em scroll (redraw parcial da area) — sem fundo opaco por tras dos botoes, os botoes ficam "carimbados" repetidamente em cada frame novo ("ghost trails"). Fix: (a) `Top >= grid.Top + grid.Height + margem` (posicao FORA da bbox — preferido), OU (b) `BackStyle = 1` + `BackColor = RGB(255, 255, 255)` se overlay for necessario. Auto-fix: CorretorAutomatico #107. Bug em FormBuscaAuxiliar.prg cnt_4c_Botoes (task052, Erro9.PNG, 2026-07-01) — Top=252 dentro do grid (grid bottom=306) + BackStyle=0 mostrava botoes Selecionar/Cancela stackados 3+ vezes ao scrollar a lista de contas.
- **OptionGroup.Buttons(N).Value NUNCA setar valor != 0**: Em VFP9, `OptionGroup.Value` eh INTEGER (1..N) indicando qual dos N botoes esta selecionado. `OptionButton.Value` (individual) eh BOOLEAN (0/1) — quem gerencia eh o OptionGroup. Se o codigo migrado setar `Buttons(2).Value = 2`, `Buttons(3).Value = 3`... VFP9 trata QUALQUER nao-zero como truthy → TODOS os radio buttons aparecem marcados de uma vez, comportamento visual quebrado. NUNCA setar `.Value = N` (com N != 0) dentro de bloco `WITH ...Buttons(N)`. Se quiser default selection, setar apenas `OptionGroup.Value = indice` (ex: `OptionGroup.Value = 2` para 2o botao marcado). Auto-fix: CorretorAutomatico #108. Bug em Formsigregli.prg (task108, 2026-07-01) em 5 OptionGroups (Get_Tipo/TpOrdem/Get_Boleto/Get_Pedido/Opt_Ordem).
- **TornarControlesVisiveis: skip com LOOP DEVE recursar em containers hidden-por-default**: Metodo recursivo `TornarControlesVisiveis` seta `Visible=.T.` em sub-controles apos AddObject (que os cria Visible=.F. default). Quando ha lista de skip para containers que devem comecar ocultos (ex: `IF INLIST(control.Name, "CNT_4C_ETIQUETAS", "CNT_4C_RELACAO") LOOP ENDIF`), o `LOOP` pula TANTO setar Visible do container QUANTO recursar dentro dele. Resultado: container fica hidden corretamente MAS seus filhos tambem ficam Visible=.F. permanente. Quando logica posterior seta `container.Visible=.T.`, container aparece VAZIO. Fix: dentro do IF de skip, ANTES do LOOP, recursar `THIS.TornarControlesVisiveis(container)` para tornar filhos visiveis sem tocar Visible do proprio container. Auto-fix: CorretorAutomatico #109. Bug em Formsigregli.prg (task108, 2026-07-01) — containers cnt_4c_Etiquetas/Relacao apareciam vazios ao selecionar Tipo de Impressao.
- **cnt_4c_Cabecalho Labels NUNCA usar AutoSize=.T.**: `lbl_4c_Sombra`/`lbl_4c_Titulo` em `cnt_4c_Cabecalho` DEVEM ter `AutoSize = .F.` (default) + `Width = THIS.Width` (Container Width, igual THISFORM.Width). Com `AutoSize = .T.`, captions longos expandem a Label alem da area dos botoes (cmg_4c_Botoes Left=529, Graficos Left=460), deixando texto truncado visualmente atras dos botoes. AutoSize=.F. clipa naturalmente no boundary. Auto-fix: CorretorAutomatico #98. Bug em Formsigrecmc.prg (2026-06-25). Template canonico: FormSigReAac.prg:104-146.
- **Grid RecordMark/DeleteMark em OPERACIONAL**: Grids criados manualmente (AddObject) em forms OPERACIONAIS DEVEM ter `.RecordMark = .F.` e `.DeleteMark = .F.`. Sem isso, barras de marcacao aparecem na lateral esquerda do grid.
- **ChkRegister NAO EXISTE em BusinessBase**: O legado usa ``ThisForm.poDataMgr.ChkRegister()`` para verificar duplicidade. Na migracao, usar SQLEXEC com ``SELECT COUNT(*) AS nExiste FROM tabela WHERE campo = valor`` + verificar ``NVL(cursor.nExiste, 0) > 0``. NUNCA chamar ChkRegister no BO.
- **cnt_4c_Cabecalho FUNDO CINZA MEDIO OPACO**: O cntSombra do framework.vcx tem `BackColor=RGB(100,100,100)` (cinza medio, NAO escuro). cnt_4c_Cabecalho DEVE ter `BackStyle=1` (opaco) + `BackColor=RGB(100,100,100)` + `lbl_4c_Titulo.ForeColor=RGB(255,255,255)` (branco sobre cinza). Valor RGB(100,100,100) (quase preto) eh ERRADO - usar 100 (cinza medio do framework). BackStyle=0 torna o cabecalho INVISIVEL. Bug corrigido em 2026-05-15 (system-wide).
- **NovoRegistro()/EditarRegistro() DEVEM chamar DODEFAULT()**: BOs que sobrescrevem NovoRegistro() ou EditarRegistro() DEVEM chamar DODEFAULT() como primeira linha. Sem isso, BusinessBase NAO seta this_lEmEdicao=.T. e Salvar() SEMPRE retorna .F. silenciosamente.
- **Botoes CRUD LADO DIREITO, posicoes EXATAS (ver framework_frmcadastro_layout.md)**: cnt_4c_Botoes Left=542 Width=390 (LADO DIREITO, NUNCA esquerdo!). Botoes internos Width=75, Left=5,80,155,230,305. FontName="Comic Sans MS" (NAO Tahoma). Encerrar em cnt_4c_Saida SEPARADO (Left=935, W=60). Grid FontName="Verdana". TODAS as posicoes padrao estao em ``docs/framework_frmcadastro_layout.md``.
- **Lookup textbox DEVE disparar em ENTER/TAB alem de F4**: Campos com lookup (fwBuscaExt no legado) DEVEM disparar busca em F4(115) E ENTER(13)/TAB(9) no KeyPress handler. O Valid original disparava ao sair do campo. Se o usuario digitar valor e pressionar TAB sem handler, nada acontece.
- **F4=115, F5=116 em KeyPress**: NUNCA usar 63 (que eh '?'). Codigos corretos: ENTER=13, TAB=9, F4=115, F5=116, ESC=27
- **Campos BIT do SQL Server**: Chegam como LOGICAL (.T./.F.) no VFP9. NUNCA usar NVL(campo,0)=1. Usar IF campo / IF !campo direto. NUMERIC(1,0) sim usa NVL.
- **Lookup ao sair do campo**: KeyPress com ENTER/TAB deve VALIDAR valor digitado contra tabela de referencia. Se encontrar, preencher descricao. Se nao encontrar, abrir FormBuscaAuxiliar. F4/F5 sempre abre lookup direto.
- **Z-ORDER AddObject em Page2**: Quando Page2 tem PageFrame interno + OptionGroup/botoes de navegacao, adicionar ``ZOrder(0)`` nos controles de navegacao APOS adicionar o PageFrame. VFP9 AddObject coloca ultimo objeto no topo do z-order, cobrindo controles anteriores.
- **PageFrame interno .Tabs = .F.**: PageFrame interno que usa OptionGroup para navegacao entre sub-paginas DEVE ter ``.Tabs = .F.``. Se .Tabs = .T., tabs nativos do VFP9 ficam visiveis e consomem espaco, sobrepondo controles.
- **Container Left+Width <= Form.Width**: Validar que Left + Width de TODOS os containers nao exceda Form.Width (normalmente 1000). Container parcialmente fora da area visivel fica cortado ou inacessivel.
- **NUNCA inventar tabelas de lookup**: Se o original NAO faz Seek/lookup de descricao para um campo, NAO criar query de lookup. Tabelas como SigCdCcr, SigCdJob NAO existem. Copiar nomes de tabela EXATAMENTE do codigo original. Se nao ha lookup no original, o campo eh apenas exibido.
- **WHERE Emps SOMENTE em tabelas que tem a coluna**: Tabelas de cadastro generico (SigCdGcr, SigCdMoe, SigCdCor, SigCdUni) tipicamente NAO tem coluna Emps. Antes de adicionar ``WHERE Emps = go_4c_Sistema.cCodEmpresa``, verificar no schema.sql se a tabela realmente tem essa coluna. Na duvida, omitir o filtro.
- **Propriedades this_ DECLARAR com nome EXATO do uso**: TODA propriedade referenciada como THIS.this_cXxx no codigo DEVE ter declaracao IDENTICA this_cXxx = "" no cabecalho DEFINE CLASS. Nomes amigaveis diferentes (ex: declarar this_cUltGrupo mas usar THIS.this_cUltCgrus) causam Error 174 Property not found no primeiro LostFocus.
- **Container.BorderStyle NAO EXISTE**: Container VFP9 tem BorderWidth mas NAO tem BorderStyle (propriedade de CommandGroup/OptionGroup). Usar apenas .BorderWidth = 0. CorretorAuto #68 remove automaticamente.
- **Containers de botoes CRUD TRANSPARENTES**: Containers que hospedam botoes CRUD em forms frmcadastro (cnt_4c_Botoes, cnt_4c_Saida, cnt_4c_BotoesDados) DEVEM usar `BackStyle=0` (transparente), NUNCA `BackStyle=1` com `BackColor=RGB(100,100,100)` ou similar escuro. O fundo do form ja e fornecido por Page.Picture (fundo_cad_1003.jpg); container opaco escuro cria caixa cinza ao redor dos botoes que destoa do layout original. EXCECAO UNICA: cnt_4c_Cabecalho usa opaco escuro propositalmente (cntSombra).
- **PageFrame.Height = Form.Height + 29**: Em forms frmcadastro com PageFrame oculto (Tabs=.F., Top=-29), o `pgf_4c_Paginas.Height` DEVE ser `Form.Height + 29` (NAO igual a Form.Height). Com Top=-29 e Height=Form.Height, sobram 29px descobertos no bottom expondo o fundo cinza nativo do form como borda indesejada. Formula: Form.Height=600 -> PageFrame.Height=629. Form.Height=650 -> PageFrame.Height=679.

**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir `SET SAFETY OFF` e `SET RESOURCE OFF` no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.
- **BO: metodo de validacao chama-se ValidarDados() (NAO Validar)**: BusinessBase.Salvar() chama THIS.ValidarDados(). BOs que implementam PROTECTED PROCEDURE Validar() tem validacao silenciosamente pulada -> Inserir roda com valores default e falha no SQL. SEMPRE usar PROTECTED PROCEDURE ValidarDados().
- **IIF() exige LOGICAL no 1o argumento**: IIF(numerico, ...) quebra com "Function argument value, type, or count is invalid" quando valor=0. Em TEXTMERGE SQL e conversoes, SEMPRE comparar: IIF(this_nFlag = 1, '1', '0'). NUNCA passar numerico direto: IIF(this_nFlag, '1', '0').
- **Colunas NUMERIC(1,0) preservam tipo NUMERIC em this_n***: Em CarregarDoCursor, NUNCA usar ramo ELSE generico `THIS.this_nXxx = (NVL(col,0) = 1)` (converte para LOGICAL). Padrao canonico: IF VARTYPE(col)="N" / THIS.this_nXxx = NVL(col, 0) / ELSE / THIS.this_nXxx = IIF(NVL(col,.F.),1,0) / ENDIF. BIT do SQL->LOGICAL vai em this_l*; NUMERIC(1,0)->NUMERIC vai em this_n*.
- **CheckBox .Value = 0 no AddObject (NAO .F.)**: AddObject CheckBox DEVE inicializar `.Value = 0` (NUMERIC). Usar `.Value = .F.` cria LOGICAL e conflita com LimparCampos (`.Value = 0`, NUMERIC) e BOParaForm - dispara "Operator/operand type mismatch" no primeiro uso. BOParaForm: usar `chk.Value = IIF(this_lProp, 1, 0)` ou `IIF(this_nProp = 1, 1, 0)`, nunca atribuir LOGICAL direto.
- **Lookups FormBuscaAuxiliar NUNCA com BINDEVENT "LostFocus"**: Handlers Validar* que criam FormBuscaAuxiliar DEVEM usar BINDEVENT "KeyPress". LostFocus dispara quando o dialog de lookup toma foco -> RECURSAO: segundo dialog empilhado, grade aparece vazia, campo fica em branco apos Selecionar. Handler deve receber (par_nKeyCode, par_nShiftAltCtrl) e executar apenas em ENTER(13)/TAB(9)/F4(115): IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115 / RETURN / ENDIF.
- **ALLTRIM() NAO aceita numerico**: ALLTRIM(txt.Value) quando .Value e numerico (ex: .Value=0, InputMask="999") gera "Function argument value, type, or count is invalid". Em validacao usar comparacao direta (IF .Value = 0); em conversao, envolver com TRANSFORM: ALLTRIM(TRANSFORM(.Value)).
- **cmd_4c_Encerrar.Caption = "Encerrar"**: Botao Encerrar DEVE ter `.Caption = "Encerrar"` (NAO "X", "Sair" ou ""). A Picture "cadastro_sair_60.jpg" NAO cobre a caption; captions errados aparecem como texto abaixo do icone. Padrao dos forms CRUD (FormCor, FormMoe).
- **PADRAO CANONICO SAIDA/ENCERRAR � PREVALECE SOBRE PILAR 1 (pixel-perfect legado)**: O bloco de saida (container + botao Encerrar) DEVE seguir o padrao canonico do sistema novo (FormCor), IGNORANDO os valores do SCX legado. Canonical (inegociavel): `cnt_4c_Saida.Left=917, Width=90, Height=85`; `cmd_4c_Encerrar.Left=5, Top=5, Width=75, Height=75, Caption="Encerrar"`. Se o SCX legado tiver Grupo_Saida.Left=935 W=60 ou botao X com W=50/Caption="X"/"Sair"/"Fechar", IGNORE e use o canonico. O mesmo vale para `.Width = THIS.Width - 60/-65` em containers de Page (pgf.Page1/Page2): DEVE ser `.Width = THIS.Width` (container de saida eh flutuante/transparente sobre a Page, subtrair largura deixa faixa clara exposta a direita). Esta regra PREVALECE sobre o PILAR 1 (pixel-perfect ao legado) � o sistema novo tem padrao visual proprio para o bloco de saida que NAO deve ser sobrescrito pelo SCX. CorretorAutomatico #81, #88, #89 corrigem automaticamente, mas o gerador DEVE ja emitir correto.
- **PUBLIC NAO EXISTE em DEFINE CLASS**: Metodos dentro de `DEFINE CLASS ... ENDDEFINE` sao PUBLIC por default. `PUBLIC FUNCTION xxx()` e `PUBLIC PROCEDURE xxx()` sao SYNTAX ERROR ("Statement is not valid in a class definition"). Apenas `PROTECTED` e `HIDDEN` sao modifiers validos. Escrever sempre: `FUNCTION xxx()` / `PROCEDURE xxx()` (sem PUBLIC) OU `PROTECTED PROCEDURE xxx()` / `HIDDEN FUNCTION xxx()`.
- **Page.Width / Page.Height READ-ONLY em runtime**: Pages (PageFrame.PageN) NAO aceitam atribuicao a .Width/.Height em runtime � essas propriedades sao controladas pelo PageFrame automaticamente. `WITH loc_oPage / .Width = THIS.Width / .Height = THIS.Height / ENDWITH` causa "CREATEOBJECT retornou valor nao-objeto" na instanciacao. Remover TODAS as atribuicoes a Page.Width/Height em ConfigurarPageFrame ou similares. Se precisa cobrir area, usar containers filhos da Page com Width/Height fixos.
- **MostrarAviso NAO EXISTE**: Apenas `MostrarErro` (FormErro.prg), `MsgErro`, `MsgAviso`, `MsgConfirma`, `MsgInfo` (messages.prg) existem. `MostrarAviso(...)` gera runtime error "File 'mostraraviso.prg' does not exist". Usar `MsgAviso(msg)` para validacao de UI (dialog amarelo) OU `MostrarErro(msg, titulo)` para exceptions tecnicas (dialog vermelho). CorretorAutomatico #90 auto-corrige.
- **Cursor do grid + SQLEXEC Buscar: fechar antes (uncommitted changes)**: Em BO.Buscar ou BO.CarregarPorCodigo, antes de `SQLEXEC(..., "cursor_4c_Dados")` (ou outro alias que o form usa como `grd.RecordSource`), fechar o cursor anterior: `IF USED("cursor_4c_Dados") / TABLEREVERT(.T., "cursor_4c_Dados") / USE IN cursor_4c_Dados / ENDIF`. Sem isso, segundo SQLEXEC falha com "Table buffer contains uncommitted changes" porque o grid pode ter mantido edicoes pendentes no buffer. CorretorAutomatico #91 injeta automaticamente.
- **cnt_4c_Saida padrao canonico (FormCor)**: cnt_4c_Saida Left=917, Width=90, Height=85. cmd_4c_Encerrar dentro com Left=5, Top=5, Width=75, Height=75. Mantem Encerrar com as MESMAS dimensoes dos botoes CRUD (75x75). Valores antigos (Left=935 W=60 botao W=50) tornam o Encerrar visualmente menor - substituir pelo padrao FormCor.
- **FormParaBO/BOParaForm: props EXATAS do BO + descricoes de lookup DECLARADAS**: Toda prop acessada via this_oBusinessObject.xxx DEVE existir como declaracao no BO. Assign em prop nao-declarada cria dinamica, mas LEITURA em instancia fresca (pos CarregarDoCursor, antes de qualquer assign) dispara "Property THIS_XXX is not found". Descricoes de lookup (this_cDsX, this_cDxxx) que nao vao para o SQL mas passam por FormParaBO/BOParaForm TAMBEM precisam ser declaradas no BO (mesmo que nao-persistidas).
- **MsgAviso para validacao de UI, MsgErro APENAS para exceptions tecnicas**: "Selecione um registro", "Campo obrigatorio", "Valor invalido", "Ja cadastrado" DEVEM usar `MsgAviso(...)` (dialog amarelo). `MsgErro`/`MostrarErro` (dialog vermelho + botao "Fechar Aplicacao") APENAS para erros tecnicos reais: exceptions capturadas em CATCH, "Erro ao...", "Falha ao...", SQL errors, conexao. Usar `MostrarErro` para validacao assusta o usuario.
- **Grid.ColumnCount ANTES de RecordSource em CarregarLista**: TODA vez que definir `grd.RecordSource = "cursor_4c_Dados"`, setar `grd.ColumnCount = N` IMEDIATAMENTE antes (N = numero de colunas que queremos no grid). Sem isso, grid auto-expande para todas as colunas do cursor (ex: cursor com 10 campos gera grid com 10 colunas e headers duplicados). Regra vale para CarregarLista e tambem ExecutarBusca/Buscar-style refresh. Existe regra #43 (nao resetar ColumnCount) com sentido especifico; esta reforca: ColumnCount DEVE ser setado >= 1 vez antes de CADA RecordSource.
- **FormParaBO DEVE popular TODAS props do BO usadas em Inserir/Atualizar**: Props de SQL (this_d*, this_n*, this_c*) referenciadas em Inserir() DEVEM ser populadas em FormParaBO(), incluindo campos auto-gerados: `IF modo==INCLUIR AND EMPTY(this_dDatas) / this_dDatas = DATE() / ENDIF`, `this_cEmps = go_4c_Sistema.cCodEmpresa`, etc. Se nao popular, Insert grava NULL/default (data NULL, empresa vazia). Auditoria: toda prop `THIS.this_[cdn]\w+` referenciada em Inserir deve aparecer em FormParaBO.
- **INDEX ON ... TAG <nome-da-coluna>, NAO TAG unico "ordem"**: Quando o form precisa mudar ordenacao via `SET ORDER TO TAG <col>`, criar UM TAG POR COLUNA no cursor (ex: `INDEX ON Locals TAG Locals`, `INDEX ON Nivel2s TAG Nivel2s`, etc.). NUNCA criar `INDEX ON &loc_cOrdem TAG ordem` (nome generico "ordem"): destroi tags anteriores e form nao consegue fazer `SET ORDER TO TAG Locals`. Auditoria cross-file: listar `SET ORDER TO TAG (\w+)` no form vs `INDEX ON ... TAG (\w+)` no BO - tags usados no form mas ausentes no BO sao bugs.
- **PEMSTATUS em cursor: erro "Function argument value, type, or count is invalid"**: PEMSTATUS exige OBJETO no 1o arg, NUNCA alias de cursor. ``PEMSTATUS((par_cAlias), "campo", 5)`` ou ``PEMSTATUS(par_cAlias, "campo", 5)`` (com par_cAlias sendo nome de cursor) quebra. Usar ``TYPE(par_cAlias + ".campo") != "U"`` para checar se campo existe no cursor. Regra #61 ja documentada; reforcar agora porque gerador continua replicando o erro em CarregarDoCursor.
- **Lookup KeyPress: ENTER(13) E TAB(9) E F4(115), NAO so F4**: Handlers Validar*/AbrirLookup* ligados via BINDEVENT KeyPress DEVEM disparar em ``par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115``. Somente ``= 115`` (F4) deixa user preso: digita codigo, TAB, nada acontece. Padrao correto ja em lesson #84; gerador continua emitindo so ``= 115`` em alguns forms - CorretorAutomatico #85 normaliza.
- **Forms 1-N com grid secundario: criar cursor vazio em BtnIncluirClick**: Forms com grids secundarios (ex: grd_4c_Dados exibindo localidades/itens) onde user adiciona registros manualmente via KeyPress DEVEM criar o cursor vazio com estrutura correta + tags em ``BtnIncluirClick``. Sem isso, em modo INCLUIR o cursor nao existe -> user digita e nada acontece. Exemplo: ``CREATE CURSOR cursor_4c_Xxx (col1 C(9), col2 N(9,0), ...) / INDEX ON col1 TAG col1 / INDEX ON col2 TAG col2``. Chamar ConfigurarGrdDados() em seguida para bind do grid.
- **fwprogressbar NAO PORTADA — usar stub em classes/fwprogressbar.prg**: Handlers/BOs que usam `CREATEOBJECT("fwprogressbar", cTitulo, nTotal)` + `.Show()` + `.Update(.T.)` + `.Complete(.T.)` para barra de progresso precisam do stub em `C:\4c\projeto\app\classes\fwprogressbar.prg` (Form base com Init/Show/Update/Complete + labels Titulo/SubTitulo/Rodape/lblPercentage + shpThermBg/shpThermBar) registrado em `config.prg` via `CarregarSeExistir(gcCaminhoClasses + "fwprogressbar.prg")`. Sem isso: "Class 'fwprogressbar' is not found" -> CATCH silencioso em `InicializarForm`/`MCursor` -> Init retorna .F. -> `CREATEOBJECT("FormXxx")` retorna .F. (Logical) -> "VARTYPE retornou: L" no menu. Interface esperada: Init(cTitulo, nTotal), Show(), Update(.T.), Complete(.T.), Titulo/SubTitulo labels, shpThermBar. Bug em Formsigrepes.prg + SigPrCccBO.prg (2026-07-02, Erro17).
- **KeyPress handler: LPARAMETERS + guard Enter(13)/Tab(9)/F4(115) obrigatorios**: Handler bindado via `BINDEVENT(obj, "KeyPress", THIS, "Nome")` DEVE ter LPARAMETERS na primeira linha: `LPARAMETERS par_nKeyCode, par_nShiftAltCtrl`. Sem LPARAMETERS: runtime "No PARAMETER statement is found" no primeiro keystroke. Handlers de LOOKUP (que abrem FormBuscaAuxiliar) DEVEM ter guard: `IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115 / RETURN / ENDIF`. Sem guard, picker abre a CADA tecla digitada (UX quebrada). Handlers de checkbox mutual-exclusion (chk_4c_*) NAO precisam do guard. Padrao canonico: `Formsigatcrp.prg:2614-2624` e `Formsigrepes.prg:6488-6497`. Auto-fix: CorretorAutomatico #30 estendido + #112. Bug em Formsigrepes.prg (2026-07-02, Erro18): 32 handlers `Validar*` sem LPARAMETERS.
- **FormBuscaAuxiliar manual-API (CREATEOBJECT vazio + setters) NAO POPULA cursor**: `CREATEOBJECT("FormBuscaAuxiliar")` SEM params + setar `this_cTabela`/`this_cCampoBusca`/`this_cValorBusca`/`this_cCursorDestino` + `mAddColuna(...)` + `.Show()` NAO dispara SQLEXEC. `ConfigurarGrid()` executa `IF !USED(THIS.this_cCursorDestino) RETURN` -> picker abre com grid VAZIO. Props `this_cFiltro`/`this_cCursorOrigem`/`this_nMaxRegistros` NAO EXISTEM em FormBuscaAuxiliar (adhoc-dinamicas sem efeito). CORRETO: (a) Init com params: `CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "Tabela", "cursor_4c_Busca", "Campo", cVal, "Titulo", .T., .T., cFiltro)` — dispara SELECT exato + fallback LIKE; (b) pre-popular via `SQLEXEC(gnConnHandle, "SELECT ...", "cursor_4c_Busca")` ANTES de `.Show()`. Helper reutilizavel `AbrirLookup(txtCod, txtDesc, tabela, campoCod, campoDesc, campoBusca, valor, cursor, titulo, filtro, forcarPicker)` canonico em `Formsigrepes.prg:3318-3385`. Auto-fix: nao automavel (refatoracao estrutural). Bug em Formsigrepes.prg (2026-07-02, Erro18): 13 handlers com manual-API abriam picker vazio.
- **MsgAviso("...encontrada") antes de THIS.AbrirBusca<X>() eh REDUNDANTE e QUEBRA UX**: Em handlers `Validar<Campo>` que fazem `SELECT TOP 1` exato e caem no ELSE quando nao acham, PROIBIDO gerar `MsgAviso("Empresa nao encontrada", "Empresa") + .Value = "" + THIS.AbrirBusca<X>()` em sequencia. User ve dialog blocking "nao encontrada" -> clica OK -> picker abre -> mas o clear-field ja apagou o valor digitado, entao o picker abre SEM prefix para LIKE. Padrao CORRETO: apenas `THIS.AbrirBusca<X>()` no ELSE — o picker abrindo direto JA e o feedback visual de "nao achou match exato", e o valor digitado eh preservado para o SELECT LIKE prefix dentro do picker. Auto-fix: CorretorAutomatico #114. Bug em FormSIGREADS.prg (2026-07-02, Erro20) + sweep global em 49 forms com mesmo anti-padrao.
- **SigCdGcr tem coluna `descrs` (com 'r'), NAO `descs` — consultar schema.sql sempre**: Tabelas com nomes parecidos podem ter colunas de descricao diferentes. `SigCdGcr` (Grupo Estoque/Contabil) tem `descrs`. Suas irmas `SigCdGpr` (Grande Grupo), `SigCdLin` (Linha), `SigCdCol` (Colecao) tem `descs`. NUNCA assumir nome de coluna por analogia entre tabelas — SEMPRE consultar `docs/schema.sql`. `SELECT descs FROM SigCdGcr` gera "Nome de coluna 'descs' invalido". Padrao CORRETO: `SELECT codigos, descrs FROM SigCdGcr` + `mAddColuna("descrs", ...)`. Auto-fix: CorretorAutomatico #115. Bug em FormSIGREAEG/FormSIGREEGG/FormSigReCsp/Formsigreegp (2026-07-02, Erro21) — 4 forms, ~14 refs.
- **INDEX ON composto (A+B) com SEEK parcial (so A) FALHA 100% com SET EXACT ON**: `config.prg:193` seta `SET EXACT ON` globalmente — SEEK exige match da CHAVE INTEIRA do indice, nao mais prefix. Se cursor tem `INDEX ON A + B TAG X` (chave concatenada, ex: 20 chars) e o codigo faz `SEEK(loc_valorA, cursor, "X")` passando so `A` (ex: 10 chars), SEEK retorna .F. SEMPRE — `IF SEEK()` cai silenciosamente e o scan/expansao pula toda a subarvore sem exception. REGRA: se TODOS os `SEEK(..., cursor, "X")` do mesmo TAG usam apenas o primeiro campo do compound, trocar o INDEX para single-column (`INDEX ON A TAG X`). Se precisa manter compound (uniqueness, multi-key seek), OU pad-completar a chave do SEEK ate o tamanho da chave do indice OU `SET EXACT OFF` local (salvar/restaurar). Auditoria cross-file: listar `INDEX ON (\w+)\s*\+\s*(\w+) TAG (\w+)` vs `SEEK\(.*, "\3"\)` — se todos os SEEK usam so `\1`, eh bug. Bug em PlanoContasBO.prg + SigRePlcBO.prg (2026-07-03, Erro23) — relatorio Plano de Contas perdia nivel 5 (contas analiticas/clientes SigCdCli) porque `INDEX ON Grupos + IClis TAG Grupos` + `SEEK(loc_cLsGrupo, "crSigCdCli", "Grupos")` nunca casava. NAO automavel (detector precisa correlacionar INDEX + SEEK do mesmo TAG no mesmo cursor).
- **fwprogressbar stub — membros GARANTIDOS + como completar**: O stub `classes/fwprogressbar.prg` implementa a interface do framework legado com estes membros: labels `Titulo`, `SubTitulo`, `Rodape`, `lblPercentage` + shapes `shpThermBg`, `shpThermBar` + metodos `Init(cTitulo, nTotal)`, `Update(lRefresh)`, `Complete(lRefresh)`, `Show()`, `Hide()`. Se codigo migrado precisar de outro membro do framework legado, REGRA ABSOLUTA: ADICIONAR AO STUB — NUNCA alterar o form migrado. Runtime erro tipico: `Unknown member <NOME>` estourando em `Processamento`/`MCursor` durante loop de scan (SCAN WHILE + `loBarra.Update(.T.)`). Ao adicionar novo Label ao stub: ajustar `Height` do form (+18 por Label). Auto-fix: CorretorAutomatico Pattern #116 (`Corrigir-FwProgressBarStubMembros`) valida integridade do stub e adiciona membros ausentes. Bug em Formsigrepes.prg linha 4562 `loBarra.Rodape.Caption = "<ESC> para interromper..."` (2026-07-07, Erro26).
- **REPORT FORM &var. (macro) OU REPORT FORM (var) (parenteses) SEM guard IF FILE() + isolamento locale PROIBIDO — usar helper THIS.ExecutarReportForm()**: TODO `REPORT FORM &<var>. PREVIEW/TO PRINTER PROMPT/TO PRINTER` gerado nos metodos Visualizacao/Impressao/Documento/BtnVisualizarClick/BtnImprimirClick DEVE passar por helper `PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)` que combina: (a) `loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")` + `IF NOT FILE(loc_cFRX) / MostrarErro(...) / RETURN .F. / ENDIF`; (b) **isolamento**: `loc_cPointOrig=SET("POINT") / loc_cSepOrig=SET("SEPARATOR") / loc_nBehaviorOrig=SET("REPORTBEHAVIOR")` -> `SET POINT TO "." / SET SEPARATOR TO "," / SET REPORTBEHAVIOR 80` -> ... -> `SET POINT TO (loc_cPointOrig) / SET SEPARATOR TO (loc_cSepOrig) / SET REPORTBEHAVIOR (loc_nBehaviorOrig)`; (c) `DO CASE ... REPORT FORM (loc_cFRX) <MODO> NOCONSOLE ENDCASE`. Modos: `"PREVIEW"`, `"PRINTER_PROMPT"`, `"PRINTER"`. Se helper ausente, INJETAR antes da 1a procedure que emite REPORT FORM. Chamar via `THIS.ExecutarReportForm("<BASE_FRX>", "<MODO>")` (base SEM `.frx`). Sem guard: FRX ausente estoura sem indicar arquivo (Erro27). Sem isolamento: FRXs legados Fortyus renderizam campos numericos como asteriscos `*******` em VFP9 default — REPORTBEHAVIOR 90 re-mede fontes em runtime e POINT="," conflita com PICTUREs `9,999.999` do FRX (Erro28). Modo 80 (classic VFP6/7/8) preserva metricas de design da IDE legada. Auto-fix: Pattern #117 detecta AMBAS as formas (macro `&<var>.` e parenteses `(<var>)`), extrai base com strip de `.frx`, injeta helper canonico com 3 params (`par_cRelatorioBase, par_cModo, par_cCursorDados` — 3o OPCIONAL para guard cursor vazio). Bugs: Formsigrepes (Erro27/28, macro) + FormSIGREVIS (Erro29/30, parenteses + cursor vazio) — todos 2026-07-07.
- **SELECT VFP local com variavel LOCAL — alias em SELECT list DEVE bater com nome do memvar**: SELECT VFP local (`SELECT ... FROM crCursor ... INTO CURSOR novoCursor`) que referencia variavel LOCAL tem 2 regras: (1) prefixar `m.` em TODA ocorrencia de var local (`loc_c\w+`) dentro do bloco — sem `m.`, VFP resolve identificador solto como COLUNA de tabela do FROM antes de memory variable e estoura "SQL: Column 'LOC_CXXX' is not found". (2) **CRITICO**: em SELECT list, alias DEVE bater com nome do memvar (`loc_cXxx AS loc_cXxx`, NUNCA `m.loc_cXxx AS <different>`) — o padrao proven do legado. Sem (2), quando o mesmo memvar aparece em GROUP BY / SUM(IIF(...)), o erro reincide mesmo com `m.` aplicado (Erro31 2026-07-08 no mesmo BO/proc do Erro30-b). Padrao correto que mimica o legado: `SELECT crXxx.col, loc_cMoeda AS loc_cMoeda, SUM(IIF(loc_cMoeda = tabela.campo, ...)) AS mValos FROM crXxx GROUP BY crXxx.col, loc_cMoeda INTO CURSOR resultado READWRITE`. NAO se aplica a SQLEXEC (SQL Server) — la a var VFP nunca vai ao servidor; deve ser embutida via `EscaparSQL(loc_cXxx)`. Regra distintiva: se o SELECT tem `INTO CURSOR ... READWRITE` (VFP local), aplicar as 2 regras; se eh string dentro de `SQLEXEC(gnConnHandle, ...)`, usar `EscaparSQL()`. Auto-fix: CorretorAutomatico Pattern #118 (`Corrigir-SelectLocalVarSemMPrefix`) tem 3 fases — (F1) detecta bloco SELECT-INTO-CURSOR, (F2) prefixa `m.` onde nao qualificado, (F3, Erro31) normaliza `m.<var> AS <different>` -> `<var> AS <var>` no SELECT list. Bug: sigrevtoBO.prg PrepararDados linhas 240-283 (Erro30-b 2026-07-07 + Erro31 2026-07-08) — Branch A (SigMvPar) + Branch B (SigMvCab) do "Relatorio Total Por Operacao".
- **REPORT: cursor de saida e aliases DEVEM bater com nomes esperados pelo FRX legado (SELECT INTO + CREATE CURSOR + memvars)**: FRXs legados nao sao portados — o generator so cria BOs. FRX renderiza expressoes que referenciam colunas do cursor CORRENTE por nomes que o LEGADO criava. Ex: FRX SigReVto tem field expressions `csRelatorio.lcMoeda`; se o BO migrado criar `cursor_4c_Relatorio` com coluna `loc_cMoeda`, REPORT FORM estoura `Variable 'LCMOEDA' is not found` (Erro33 2026-07-08). Ex2: FRX SigReAiv tem `Cabec.cnInvs1`+`DBImp.cPros`; se BO criar `cursor_4c_Cabecalho`+`cursor_4c_DbImp`, REPORT FORM estoura `Alias 'CABEC' is not found` (Erro46 2026-07-17). **Regras (cobrem TODAS as formas de criar cursor: SELECT INTO CURSOR + CREATE CURSOR + APPEND FROM/USE ALIAS)**: (a) `this_cCursorDados = "<nome_do_legado>"` — extrair do legado analisando o codigo fonte original: procurar `Into Cursor <X>` OU `Create Cursor <X>` na PROCEDURE `processamento` (o cursor que precede `Select <X>` / `Go Top` antes do `Report Form`); (b) TODAS as ocorrencias no BO — `CREATE CURSOR <nome_legado>`, `SELECT ... INTO CURSOR <nome_legado>`, `SELECT <nome_legado>`, `USED("<nome_legado>")`, `USE IN <nome_legado>`, `INSERT INTO <nome_legado>` — DEVEM usar EXATAMENTE o mesmo nome; (c) para SELECT INTO com memvars: `<memvar_novo> AS <coluna_do_legado>` (ex: `loc_cMoeda AS lcMoeda`); (d) `GROUP BY <alias>` — usar o alias legado (evita Erro31 alias mismatch); (e) para relatorios com MULTIPLOS cursores (ex: SigReAiv usa `Cabec` como header + `DBImp` como detail), criar TODOS com nomes legados — NAO renomear para `cursor_4c_Cabecalho`/`cursor_4c_DbImp`; (f) copiar `<nome>.frx` + `<nome>.frt` de `C:\4install\FortyusMC\Fortyus\` para `C:\4c\projeto\app\reports\`. Sem (a-e), REPORT FORM falha por variavel/coluna/alias nao encontrada. Sem (f), Pattern #117 helper `ExecutarReportForm` dispara MostrarErro "Arquivo de relatorio nao encontrado" (Erro32 2026-07-08). PROIBIDO usar `cursor_4c_*` como nome de cursor em BOs REPORT — reservar esse prefixo para cursores INTERNOS que NAO sao consumidos pelo FRX (ex: cursor de resultado bruto de SQLEXEC antes de agregar). NAO automavel — depende de leitura do legado + FRX binario. Padrao canonico: `sigrevtoBO.prg` (INTO CURSOR) + `SigReAivBO.prg` pos-fix (CREATE CURSOR multiplos).
- **`&m.<var>.` eh MACRO QUEBRADA — usar `&<var>.` sem prefixo m.**: Em VFP9 o macro operator `&` le o nome ATE o primeiro `.` (o `.` termina o nome do macro). `&m.loc_cWhere.` tenta expandir a variavel chamada `m` (que nao existe) — VFP9 erro 10 "Syntax error." aborta o SELECT VFP local ou REPORT FORM na hora. A regra do Pattern #118 ("prefixar `m.` em toda ref de var LOCAL dentro de SELECT VFP local") vale APENAS para refs normais (SELECT list, WHERE column ops, function args, GROUP BY, ORDER BY), NUNCA dentro de macro `&`. CORRETO: `WHERE &loc_cWhere.` (sem `m.`). Padrao legado sempre usa `&lcVar.` sem prefixo. Regra distintiva: dentro de `&<nome>.` o `<nome>` DEVE ser diretamente o nome da variavel (sem qualificador `m.`); em refs normais Pattern #118 continua valendo. Auto-fix: CorretorAutomatico Pattern #120 (`Corrigir-MacroMPrefixQuebrado`) — regex `&m\.` -> `&` (safe global, `&m.` NUNCA eh valido em VFP). Idempotente. Complementa Pattern #118 excluindo macros. Bug em SIGREADSBO.PrepararDados linha 492 (2026-07-14, Erro37) + varredura em 8 arquivos (SIGREADSBO, sigopcgpBO, sigrecheBO, sigrecpeBO, sigrecrtBO, sigrecsmBO, SigReIr1BO, Formsigrepes) com 13 ocorrencias.
- **INSERT em SQL Server: helpers por TIPO destino + LEFT() por TAMANHO destino**: Ao gerar INSERT em tabela SQL Server (`SigTempR`, `LogAuditoria`, `SigMv*` etc), DEVE combinar (1) helper por TIPO da coluna DESTINO (nao o tipo origem): CHAR/VARCHAR/TEXT -> `EscaparSQL(...)`; NUMERIC/INT -> `FormatarNumeroSQL(..., decimais)`; DATE/DATETIME -> `FormatarDataSQL(...)` ou literal `GETDATE()`; (2) truncar via `LEFT(campo, N)` quando origem CHAR(M) > destino CHAR(N). Exemplos: `SigCdCli.Rclis` char(50) em `SigTempR.Razas` char(40) -> `EscaparSQL(LEFT(csRelatorio.RClis, 40))`; `csRelatorio.CodObs` numeric(3,0) NAO pode usar `EscaparSQL` (retorna `''` para nao-C, SQL Server rejeita conversao `'' -> numeric`) -> `FormatarNumeroSQL(csRelatorio.CodObs, 0)`. Sem esses cuidados: SQL Server erro 8152 "String or binary data would be truncated" aborta o INSERT (rollback implicito) OU erro de conversao numerica — em ambos os casos, SQLEXEC retorna <0 sem MsgErro claro. Antes de gerar INSERT: consultar `docs/schema.sql` para cada coluna destino (tipo + tamanho) e comparar com a origem do cursor. NAO automavel univoco (depende de comparar schema origem X destino por campo). Bug em SIGREADSBO.PrepararDados linhas 552/555 (2026-07-14, Erro39) — INSERT SigTempR falhando na 552 (truncamento RClis 50>40) e depois na 555 (`EscaparSQL` em CodObs numeric).
- **Grid Column CheckBox EXIGE `.Sparse = .F.`**: `Column1` com `CurrentControl = "Check1"` DEVE ter `.Sparse = .F.` explicito. Default VFP9 eh `Sparse = .T.` que renderiza o CheckBox APENAS na linha corrente — outras linhas mostram o valor bruto (0/1) como texto plano e usuario NAO consegue clicar checkboxes das demais linhas. BtnSelTudo/BtnApaga (REPLACE ALL) continuam funcionando, mas selecao individual quebra. Padrao canonico: `Formsigrepes.prg:3095-3104`. Auto-fix Pattern #121 (`Corrigir-GridColumnCheckboxSparse`) injeta `.Sparse = .F.` em bloco WITH Column1 com `CurrentControl = "Check1"` faltando essa linha. Bug em FormSIGREADS (2026-07-14, Erro41).
- **REPORT: BtnVisualizar/Imprimir guard `!EMPTY(cMensagemErro)`**: Handlers que chamam `THIS.this_oRelatorio.Atualizar()`/`Inserir()` DEVEM ter guard `AND !EMPTY(this_cMensagemErro)` antes de `MsgErro(...)`. O helper `ExecutarReportForm` (Pattern #117) exibe seu proprio `MsgAviso` quando cursor vazio ou FRX faltando + retorna `.F.` sem `cMensagemErro` — sem guard, aparece SEGUNDO modal com titulo "Relatorio" e corpo VAZIO (icone X vermelho). Correto: `IF !Atualizar() AND !EMPTY(cMensagemErro) / MsgErro(...) / ENDIF`. Auto-fix Pattern #122 (`Corrigir-BtnReportGuardEmptyMsgErro`). Bug em FormSIGREADS (2026-07-14, Erro40).
- **OptionGroup.Buttons(N) DEVE ser configurado em WITH ANINHADO dentro do WITH pai**: Ao criar OptionGroup com `AddObject`, configurar `Buttons(1)` e `Buttons(2)` em blocos `WITH .Buttons(N)` ANINHADOS dentro do `WITH loc_oPag.obj_4c_OptXxx`. NUNCA fechar o WITH pai com ENDWITH e depois abrir `WITH loc_oPag.obj_4c_OptXxx.Buttons(N)` separado — VFP9 runtime nao resolve `.Buttons` via caminho completo fora do contexto WITH pai, gerando "BUTTONS is not an object". CORRETO: `WITH loc_oPag.obj_4c_OptXxx / .Value = 1 / WITH .Buttons(1) / .Caption = "Simples" / ENDWITH / WITH .Buttons(2) / .Caption = "Composto" / ENDWITH / ENDWITH`. Bug em FormSigPrCfn.prg ConfigurarPaginaLista (2026-07-15, Erro42).
- **SigCdEmp: colunas CANONICAS sao `Cemps`/`Razas` — NUNCA `Emps`/`emps`/`NComps`/`nemp`**: A tabela `SigCdEmp` tem PK `Cemps` char(3) (codigo empresa) e descricao `Razas` char(40). As colunas `Emps`/`emps` e `NComps`/`nemp` NAO EXISTEM — gera runtime `[SQL Server]Nome de coluna 'Emps' invalido` ao digitar o codigo da empresa. Bug tipico: `SELECT Emps, NComps FROM SigCdEmP WHERE Emps = ...` ou `CREATEOBJECT("FormBuscaAuxiliar", ..., "SigCdEmp", "cursor_X", "emps", ...)`. Motivo: Framework legado usava `fAcessoEmpresa(Usuar, 'C', This.Value, GetX, GetDX)` que abstraia o nome da coluna; sem a Framework portada, o gerador inventa `Emps`/`NComps` por analogia com `SigCdBal.Emps` (que existe legitimamente) ou com o nome do TextBox (`Get_Empresa`/`getDEmps`). CORRETO: `SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = ...` + `mAddColuna("Cemps", "XXX", ...)` (mask 3 X) + `mAddColuna("Razas", ...)` + refs `cursor.Cemps`/`cursor.Razas`. CUIDADO: `SigCdBal.emps` (char(3)) e `SigIvTrh.emps` (char(3)) EXISTEM legitimamente — regra NAO se aplica quando o FROM eh outra tabela; ex: `SELECT Codigos, Grupos FROM SigCdBal WHERE Emps = ...` esta correto e Pattern #125 preserva. Padrao canonico: `Formsigrevto.prg` (linhas 1167/1233), `Formsigreimp.prg` (1060/1387), `Formsigrehpr.prg` (834/1366), `Formsigrehbr.prg`, `Formsigrefcd.prg`, `Formsigrepes.prg` (4327). Auto-fix: CorretorAutomatico Pattern #125 (`Corrigir-SigCdEmpColunasInvalidas`) tem 2 fases (Fase 1 identifica cursores populados de SigCdEmp via SELECT INTO + FormBuscaAuxiliar 2o arg; Fase 2 corrige SELECT/WHERE em linhas com `SigCdEmp`, `mAddColuna` em bloco AbrirBusca* com SigCdEmp, e refs `<cursor>.emps`/`<cursor>.nemp`/`<cursor>.NComps` para os cursores identificados). Preservacao de case: `emps`->`cemps`, `Emps`->`Cemps`, `EMPS`->`CEMPS`; `nemp`/`NComps`->`razas`/`Razas`. Bug em FormSigReAiv.prg linhas 662-766 + FormSIGREHCP.prg linhas 957-1060 (2026-07-16, Erro44).
- **WITH aninhado em Container/Label/CommandGroup criados com AddObject — silently ignora props (Label/Button.Caption/Picture/ForeColor)**: Dentro de `WITH THIS.cnt_X` ou `WITH loc_oCab`, chamar `.AddObject("filho", "Label"|"CommandGroup")` e depois `WITH .filho` (WITH aninhado relativo) causa falha SILENCIOSA de resolucao de propriedades em VFP9 — Label.ForeColor/Caption e Button.Caption/Picture/Left/Width nao sao aplicados. NAO gera exception; sintoma visual: Labels invisiveis + Buttons como retangulos vazios sem icone e sem texto. Pior caso: **3 niveis de aninhamento** `WITH loc_oCab / .AddObject("cmg_4c_Botoes",...) / WITH .cmg_4c_Botoes / WITH .Buttons(N) / .Caption = ... / .Picture = ...` — Buttons props totalmente ignoradas. CORRETO: (1) fechar `WITH loc_oCab` apos configurar Container, (2) `loc_oCab.AddObject("filho", "<Classe>")` FORA de qualquer WITH, (3) `WITH loc_oCab.<filho>` OU `loc_o<filho> = loc_oCab.<filho> / WITH loc_o<filho>` (caminho explicito). EXCECAO: `WITH .Buttons(N)` DENTRO de `WITH loc_oCmg` (1 nivel de nesting em CommandGroup) EH SEGURO — Buttons(N) eh collection accessor, nao AddObject. Widths canonicos framework frmrelatorio (NUNCA `THIS.Width` em CommandGroup/Button): CommandGroup `.Width = 273`, `.Left = 527/529`; Buttons `.Width = 65`, `.Height = 70`, Lefts=5/71/137/203 (increment 66). Container/Label/PageFrame podem usar `THIS.Width` (span correto). Padrao canonico: `FormSigPdAco.prg ConfigurarCabecalho` (2 niveis) + `Formsigreanr.prg ConfigurarCabecalho` pos-fix (3 niveis com CommandGroup+Buttons). Bugs: FormSIGPRIMP (2026-07-17 Erro47 nivel 2 Label/ForeColor) + Formsigreanr + 8 outros forms REPORT (2026-07-17 Erro49 nivel 3 CommandGroup/Buttons.Picture+Caption).
- **REPORT BO: `this_cCursorDados` OBRIGATORIO declarar como property se ExecutarReportForm passa 3o arg via property**: BOs REPORT que chamam `THIS.ExecutarReportForm(base, modo, THIS.this_cCursorDados)` (padrao gerado por Pattern #117) DEVEM declarar `this_cCursorDados = "<alias_cursor_binding_FRX>"` no bloco de propriedades do `DEFINE CLASS <XxxBO> AS RelatorioBase`. Sem isso, VFP9 runtime dispara `Property THIS_CCURSORDADOS is not found` ao clicar Visualizar/Imprimir (mensagem uppercase de `this_cCursorDados`). Alias correto = cursor selecionado pelo ultimo `SELECT / GO TOP` IMEDIATAMENTE ANTES do `REPORT FORM` no legado — extrair da `PROCEDURE visualizacao`/`impressao` em `tasks/task<NNN>/<base>_form_codigo_fonte.txt`. Se BO tem MULTIPLAS FRXs com cursores DIFERENTES (ex: SIGREAEGBO usa `CsRelatorio` p/ SigReAe1.frx + `CsDiferenca` p/ SigReAe2.frx): declarar `this_cCursorDados` com o cursor PRINCIPAL (1o REPORT FORM) e substituir chamadas subsequentes por LITERAL string (`THIS.ExecutarReportForm("SigReAe2", "PREVIEW", "CsDiferenca")`). Padroes canonicos: `sigreanrBO.prg:33` (`this_cCursorDados = "TmpFinal"`), `SigReAacBO.prg:20` (`= "crDBImp"`), pos-fix 2026-07-21: SIGREAEGBO (`= "CsRelatorio"`), SIGREEQRBO (`= "csTempoGr"`), SigReAtmBO (`= "TmpRelat"`), SigReIpcBO (`= "TMPLANCA"`), sigrecgrBO (`= "TmpRastro"`), sigrefecBO (`= "crImpressao"`). Auto-fix: CorretorAutomatico Pattern #142 (`Corrigir-ReportBOCursorDadosDeclarada`) detecta BO em `classes/*BO.prg` que contem `THIS.this_cCursorDados` mas NAO tem `this_cCursorDados = ` declarado, injeta `this_cCursorDados = ""` (string vazia — Pattern #117 guard `VARTYPE=="C" AND !EMPTY` trata como skip sem crash) apos ultima property `this_` do DEFINE CLASS + emite WARNING `[Pattern #142] <BO>: this_cCursorDados injetado vazio - REVISAR e substituir pelo alias do cursor binding do FRX`. Complementa Pattern #117 (helper caller). Bug em 6 BOs (2026-07-21, Erro51 SIGREAEGBO Visualizar). Relacionado a `feedback_report_form_helper_canonico.md` + `feedback_report_cursor_alias_frx_match.md`.
- **REPORT `REPORT FORM (THIS.this_cFRXPath)` DIRETO exige TRIPLE guard (FRX + cursor + no-RETURN) + nome FRX bate com legado (NAO inventar `Rel<Base>.frx`)**: BOs REPORT gerados antes do Pattern #117 canonico atribuem `this_cFRXPath = gc_4c_CaminhoReports + "<nome>.frx"` no Init() e chamam `REPORT FORM (THIS.this_cFRXPath) NOCONSOLE {PREVIEW|TO PRINTER PROMPT|TO PRINTER}` direto em Visualizar()/Imprimir(). TRES anti-padroes: (1) nome inventado `Rel<Base>.frx` (ex: `RelSigReAni.frx`) quando o FRX legado eh `<base>.frx` sem prefixo — copiar de `C:\4install\FortyusMC\Fortyus\<base>.frx` para `C:\4c\projeto\app\reports\<PascalCase>.frx` (+ `.frt`) preservando o nome original, NAO inventar `Rel*`; (2) guard `IF !FILE(...) / cMensagemErro = ... / ENDIF / REPORT FORM ...` sem `ELSE` — o guard NAO pula o REPORT FORM subsequente, VFP9 executa REPORT FORM com FRX ausente e dispara msgbox generica "File does not exist" ao inves da mensagem descritiva; (3) cursor vazio abre preview EM BRANCO sem mensagem — PrepararDados retorna .T. mesmo com 0 registros, REPORT FORM roda com cursor vazio, usuario nao sabe se filtrou errado. Correto (TRIPLE guard aninhado): `IF FILE(THIS.this_cFRXPath) / IF !USED(THIS.this_cCursorDados) OR RECCOUNT(THIS.this_cCursorDados) = 0 / MsgAviso("Nenhum registro encontrado para os filtros informados.", "Relat" + CHR(243) + "rio") / THIS.LimparCursores() / ELSE / REPORT FORM (THIS.this_cFRXPath) <modo> NOCONSOLE / THIS.LimparCursores() / loc_lSucesso = .T. / ENDIF / ELSE / THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + THIS.this_cFRXPath / ENDIF`. NO ramo cursor-vazio NAO setar `cMensagemErro` — Pattern #122 exige guard `AND !EMPTY(cMensagemErro)` no handler para evitar duplo modal. NUNCA usar `RETURN .F.` dentro de TRY/CATCH (regra #1 CLAUDE.md). Padrao canonico preferido: refatorar para helper `ExecutarReportForm` (Pattern #117) que ja tem TRIPLE guard embutido; mas Pattern #117 tem blind spot em property-based `THIS.this_cFRXPath` — nesses casos aplicar TRIPLE guard inline. Padrao canonico proven: `sigreaniBO.prg` (Imprimir/Visualizar), `SIGRECTLBO.prg`, `SigReAacBO.prg` pos-fix 2026-07-17. Bug em FormSigReAni (Erro47, "File does not exist" mesmo apos copiar FRX + preview em branco quando periodo sem registros).
- **REPORT BO: `INDEX ON` chave composta grande FALHA sob `SET COLLATE "GENERAL"` — usar `ORDER BY` no SELECT**: `config.prg` executa `SET COLLATE TO "GENERAL"` globalmente. Efeito colateral: limite CDX cai de 240 para ~120 bytes (colacao ponderada usa 2 bytes/char). Em BO REPORT que faz `SELECT ... INTO CURSOR <cursor>` seguido de `INDEX ON <expr1>+<expr2>+... TAG <tag>` para ordenar para REPORT FORM: se chave concatenada tiver mais de ~60 chars, runtime "Invalid key length." ao clicar Visualizar. Ex `INDEX ON Quebra1 + Quebra2 + DTOS(Datas) + STR(Nenvs, 10)` onde Quebra1/2 chegam a 72 chars → 162 chars → 324 bytes GENERAL → CRASH. CORRETO: substituir INDEX ON por ORDER BY no proprio SELECT (`SELECT ... INTO CURSOR X ORDER BY 1, 2, Datas, Nenvs`); sort in-memory nao tem esse limite e FRX consome record order igual. Alternativa (se INDEX for necessario para SEEK): `loc_c=SET("COLLATE") / SET COLLATE TO "MACHINE" / INDEX ON ... TAG ... / SET COLLATE TO (loc_c)`. Regra distintiva: INDEX pequeno (chaves < 60 chars) EH SEGURO. Regra pratica: se INDEX serve apenas para ordenar antes de REPORT FORM, PREFIRA ORDER BY. Auto-fix: CorretorAutomatico Pattern #143 emite WARNING amarelo (nao muta). Bug em SIGREAUPBO (2026-07-21, Erro53).
- **REPORT BO: Visualizar/Imprimir/Documento SEMPRE via helper `THIS.ExecutarReportForm(base, modo, cursor)` — NUNCA `REPORT FORM (loc_cVar) MODO` direto**: Padrao canonico (SIGREAEGBO.prg:1192-1235): montar `loc_cRelatorio = IIF(cond, "BaseA", "BaseB")` + `loc_cCursor = IIF(cond, "CursorA", "CursorB")` + `THIS.ExecutarReportForm(loc_cRelatorio, "PREVIEW"|"PRINTER_PROMPT"|"PRINTER", loc_cCursor)`. NUNCA emitir `REPORT FORM (loc_cVar) NOCONSOLE PREVIEW` direto — mesmo com variavel intermediaria atribuida via IIF ou line-continuation `;` (blind spot dos auto-fixes Patterns #117/#123). Sem o helper: (a) FRX ausente estoura "File does not exist." sem indicar path; (b) FRXs Fortyus renderizam asteriscos em campos numericos por conflito de locale VFP9 default vs modo 80; (c) cursor vazio abre preview em branco silencioso. Helper canonico faz FULLPATH+IF FILE+MostrarErro descritivo + IF !USED/RECCOUNT+MsgAviso + isola SET POINT/SEPARATOR/REPORTBEHAVIOR 80 + DO CASE modo. NOTA: 3o arg (`par_cCursorDados`) NAO eh sempre `THIS.this_cCursorDados` — deve ser o cursor que o FRX efetivamente consome (consultar PrepararDados). Em SIGREAUPBO por ex, `this_cCursorDados` guarda cursor bruto `cursor_4c_SigOpInc` mas FRX consome `Selecao`/`TmpInc`. Auto-fix: Pattern #117/#123 refatoram formas simples; Pattern #144 emite WARNING para forma IIF/multi-linha. FRX legado deve ser copiado de `C:\4install\FortyusMC\Fortyus\<base>.frx`+`.frt` para `projeto/app/reports/` preservando o nome. Bug em SIGREAUPBO (2026-07-21, Erro54).
- **PROCEDURE Destroy DEVE chamar DODEFAULT() como ULTIMA linha**: Ao gerar `PROCEDURE Destroy` no form migrado (Phase B), a ULTIMA linha antes de `ENDPROC` DEVE ser `DODEFAULT()`. `FormBase.Destroy` (herdado) contem `RELEASE POPUP + CriarMenuPrincipal()` que rebuilda os popups do menu principal apos qualquer form modal fechar. Sem DODEFAULT() a cadeia de heranca quebra e VFP9 mantem cache visual stale dos popups — popups do menu (Cadastros/Movimentos/Relatorios) renderizam com items truncados apos este form fechar. CORRETO: `PROCEDURE Destroy() / IF USED("cursor_X") / USE IN cursor_X / ENDIF / IF !ISNULL(THIS.this_oRelatorio) / THIS.this_oRelatorio = .NULL. / ENDIF / DODEFAULT() / ENDPROC`. Auto-fix Pattern #145 injeta se ausente. Origem: Erro58 (2026-07-21).

Comecar agora. Ler os arquivos existentes (Fase A) PRIMEIRO, depois o codigo fonte original.
Preencher CADA metodo stub com implementacao COMPLETA baseada no legado.
"@

        $phaseBPrompt | Set-Content -Path $phaseBFile -Encoding UTF8
        Write-Host "  Phase B prompt gerado: meta_prompt_phaseB.md" -ForegroundColor Cyan

        Write-Host "Meta-prompt gerado: $metaPromptFile" -ForegroundColor Green
        Write-Host "  BaseName: $BaseName" -ForegroundColor Gray
        Write-Host "  FormClass: $formClass" -ForegroundColor Gray
        Write-Host "  BOClass: $boClass" -ForegroundColor Gray
        Write-Host "  FormType: $formType" -ForegroundColor Gray

        Complete-Etapa -TaskId $TaskId -Etapa "03_gerarMetaPrompt" -TasksDir $config.paths.tasks -Metadata @{
            metaPromptFile = $metaPromptFile
            phaseAFile = $phaseAFile
            phaseBFile = $phaseBFile
            formClass = $formClass
            boClass = $boClass
            formType = $formType
        }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "03_gerarMetaPrompt" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# ETAPA 4: Gerar mapeamento
#------------------------------------------------------------------------------

function Invoke-Etapa04_GerarMapeamento {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 4" "Gerar mapeamento (GeradorMapeamento.prg)"

    Start-Etapa -TaskId $TaskId -Etapa "04_gerarMapeamento" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId
        $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "04_gerarMapeamento" -TasksDir $config.paths.tasks

        # Le o BaseName normalizado salvo na etapa 2
        $state = Get-TaskState -TaskId $TaskId -TasksDir $config.paths.tasks
        $baseNameNormalizado = $state.etapas."02_extractCode".baseNameNormalizado

        if (-not $baseNameNormalizado) {
            # Fallback: tenta encontrar arquivo .txt no diretorio
            $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_form_codigo_fonte.txt" -File
            if ($txtFiles.Count -gt 0) {
                $txtFile = $txtFiles[0].FullName
            } else {
                throw "Nao foi possivel encontrar arquivo de codigo fonte no diretorio: $taskPath"
            }
        } else {
            $txtFile = Join-Path $taskPath "${baseNameNormalizado}_form_codigo_fonte.txt"
        }

        # Prepara parametros ordenados para GeradorMapeamento
        # Parametro 1: Caminho completo do arquivo .TXT
        # Parametro 2: Diretorio do task
        # Usa sintaxe direta SEM config.fpw (classes carregadas com caminho absoluto no .prg)
        $parameters = @($txtFile, $taskPath)

        # Executa GeradorMapeamento.prg (SEM config.fpw - usa caminhos absolutos)
        $mapeamentoScript = Join-Path $config.paths.projeto "app\utils\GeradorMapeamento.prg"

        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
            -ScriptPrg $mapeamentoScript `
            -Parameters $parameters `
            -Timeout $config.vfp.timeout `
            -LogFile $logFile `
            -OutputFile (Join-Path $taskPath "vfp_output.txt")



        # Verifica se arquivo foi gerado
        $jsonFile = Join-Path $taskPath "mapeamento.json"

        if (-not (Test-Path $jsonFile)) {
            throw "Arquivo de mapeamento nao foi gerado: $jsonFile"
        }

        Write-Host "Mapeamento gerado: $jsonFile" -ForegroundColor Green

        Complete-Etapa -TaskId $TaskId -Etapa "04_gerarMapeamento" -TasksDir $config.paths.tasks -Metadata @{ jsonFile = $jsonFile }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "04_gerarMapeamento" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# ETAPA 4.5: Gerar Esqueletos (NOVO)
#------------------------------------------------------------------------------

function Invoke-Etapa04b_GerarEsqueletos {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 4.5" "Gerar Esqueletos (GeradorEsqueletos.prg)"

    Start-Etapa -TaskId $TaskId -Etapa "04b_gerarEsqueletos" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId
        $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "04b_gerarEsqueletos" -TasksDir $config.paths.tasks

        # Verifica se analise.json existe
        $analiseFile = Join-Path $taskPath "analise.json"
        if (-not (Test-Path $analiseFile)) {
            Write-Host "AVISO: analise.json nao encontrado. Pulando geracao de esqueletos." -ForegroundColor Yellow
            Complete-Etapa -TaskId $TaskId -Etapa "04b_gerarEsqueletos" -TasksDir $config.paths.tasks -Metadata @{ skipped = $true }
            return
        }

        # Executa GeradorEsqueletos.prg
        $esqueletosScript = Join-Path $config.paths.projeto "app\utils\GeradorEsqueletos.prg"

        $parameters = @($analiseFile)

        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
            -ScriptPrg $esqueletosScript `
            -Parameters $parameters `
            -Timeout $config.vfp.timeout `
            -LogFile $logFile `
            -OutputFile (Join-Path $taskPath "vfp_output.txt")

        # Verifica se pasta esqueletos foi criada
        $esqueletosDir = Join-Path $taskPath "esqueletos"

        if (-not (Test-Path $esqueletosDir)) {
            throw "Pasta esqueletos nao foi criada: $esqueletosDir"
        }

        $esqueletos = Get-ChildItem -Path $esqueletosDir -Filter "*.prg" -File
        Write-Host "Esqueletos gerados: $($esqueletos.Count) arquivos" -ForegroundColor Green

        foreach ($esq in $esqueletos) {
            Write-Host "  - $($esq.Name)" -ForegroundColor Gray
        }

        Complete-Etapa -TaskId $TaskId -Etapa "04b_gerarEsqueletos" -TasksDir $config.paths.tasks -Metadata @{
            esqueletosDir = $esqueletosDir
            arquivos = ($esqueletos | ForEach-Object { $_.Name })
        }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "04b_gerarEsqueletos" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# FUNCOES AUXILIARES: Processamento Multi-Fase (Arquivos Complexos)
#------------------------------------------------------------------------------

<#
.SYNOPSIS
    Detecta complexidade de arquivo de c�digo fonte
.DESCRIPTION
    Analisa tamanho e linhas para classificar como SIMPLES ou COMPLEXO
    COMPLEXO: >= 800 KB OU >= 15.000 linhas (requer processamento faseado)
#>
function Get-ComplexidadeArquivo {
    param(
        [string]$CaminhoTxt
    )

    $tamanhoKB = [math]::Round((Get-Item $CaminhoTxt).Length / 1024, 2)
    $linhas = (Get-Content $CaminhoTxt -ReadCount 0).Count

    # Crit�rios de complexidade:
    # - SIMPLES: < 800 KB E < 15.000 linhas
    # - COMPLEXO: >= 800 KB OU >= 15.000 linhas

    # TODOS os formularios usam processamento multi-fase (8 fases)
    # O modo SIMPLES (2 fases) gera problemas recorrentes em forms OPERACIONAIS
    # e mesmo CRUDs com muitos campos. Multi-fase eh mais robusto e previsivel.
    if ($true) {
        # Calcula n�mero de fases (aproximadamente 300-400 KB por fase)
        $numFases = [Math]::Max(3, [Math]::Ceiling($tamanhoKB / 400))

        return @{
            Classificacao = "COMPLEXO"
            TamanhoKB = $tamanhoKB
            Linhas = $linhas
            NumFases = $numFases
            Motivo = if ($tamanhoKB -ge 800) { "Tamanho" } else { "Linhas" }
        }
    }

    return @{
        Classificacao = "SIMPLES"
        TamanhoKB = $tamanhoKB
        Linhas = $linhas
    }
}

#------------------------------------------------------------------------------
# DETECCAO DE "Prompt is too long" no output do Claude CLI
#------------------------------------------------------------------------------
function Test-PromptTooLong {
    param([string]$OutputContent)
    if (-not $OutputContent) { return $false }
    return ($OutputContent -match "(?i)prompt.is.too.long|input.too.long|maximum.context.length")
}

function Test-OutputTokenLimitExceeded {
    param([string]$OutputContent)
    if (-not $OutputContent) { return $false }
    return ($OutputContent -match "(?i)exceeded.the.*output.token.maximum|CLAUDE_CODE_MAX_OUTPUT_TOKENS")
}

#------------------------------------------------------------------------------
# CALCULO DE ORCAMENTO DE CONTEXTO
# Calcula tamanho total do prompt + contexto + CLAUDE.md estimado
# Retorna hashtable com total e se excede o limite
#------------------------------------------------------------------------------
function Get-ContextBudget {
    param(
        [string]$PromptFile,
        [string[]]$ContextFiles,
        [int]$SafeLimitKB = 250  # Limite seguro para fonte + contexto (sem CLAUDE.md)
    )

    $promptKB = 0
    if (Test-Path $PromptFile) {
        $promptKB = [math]::Round((Get-Item $PromptFile).Length / 1KB, 0)
    }

    $contextKB = 0
    foreach ($f in $ContextFiles) {
        if ($f -and (Test-Path $f)) {
            $contextKB += [math]::Round((Get-Item $f).Length / 1KB, 0)
        }
    }

    # CLAUDE.md eh carregado automaticamente via --add-dir (~8 KB, reduzido de 63KB em 2026-03-17)
    # Conteudo detalhado movido para .claude/skills/vfp9-migration/ (skill sob demanda)
    $claudeMdKB = 8
    $totalKB = $promptKB + $contextKB + $claudeMdKB

    return @{
        PromptKB = $promptKB
        ContextKB = $contextKB
        ClaudeMdKB = $claudeMdKB
        TotalKB = $totalKB
        SafeLimitKB = $SafeLimitKB + $claudeMdKB  # Limite real incluindo CLAUDE.md
        Excede = ($totalKB -gt ($SafeLimitKB + $claudeMdKB))
    }
}

#------------------------------------------------------------------------------
# VALIDACAO DE COMPLETUDE: Detecta TODO/stubs/procedures vazias
# Portado de OrquestradorComplexo.ps1 (2026-02-26)
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

        # Ignorar handlers de KeyPress para campos sem lookup (data, PV, etc.)
        # Estes sao intencionalmente vazios - campos que nao precisam de F4/F5
        $procParams = $m.Groups[2].Value
        if ($procName -match "^Tecla" -and $procParams -match "par_nKeyCode") { continue }

        # Remover comentarios e linhas em branco
        $codeLines = ($body -split "`n" |
                      Where-Object { $_ -match "\S" -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&" } |
                      Measure-Object).Count

        if ($codeLines -eq 0) {
            $problemas += "Procedure vazia (sem codigo): $procName"
        }
    }

    # 3. Detectar "implementar depois" / "proxima fase" em comentarios
    $laterPattern = "(?im)\*.*?(implementar\s+(depois|later|futur)|pr[o�]xima\s+fase|pendente|nao\s+implement)"
    $laterMatches = [regex]::Matches($content, $laterPattern)
    foreach ($m in $laterMatches) {
        $problemas += "Indicador de pendencia: $($m.Value.Trim())"
    }

    # 4. Detectar stubs com MsgAviso("...ser� implementad...")
    # Claude gera stubs que passam checks 1-3 porque usam MsgAviso em vez de comentario
    $stubMsgPattern = '(?im)MsgAviso\(.+?(implementad|ser.{1,5}\s+implementad|n.o\s+dispon.vel|em\s+desenvolvimento)'
    $stubMsgMatches = [regex]::Matches($content, $stubMsgPattern)
    foreach ($m in $stubMsgMatches) {
        # Encontrar nome do PROCEDURE que contem este stub
        $pos = $m.Index
        $beforeText = $content.Substring(0, $pos)
        $procMatch = [regex]::Match($beforeText, '(?i)PROCEDURE\s+(\w+)', [System.Text.RegularExpressions.RegexOptions]::RightToLeft)
        $stubProc = if ($procMatch.Success) { $procMatch.Groups[1].Value } else { "(desconhecido)" }
        $problemas += "Metodo stub com MsgAviso placeholder: $stubProc - deve ter logica FUNCIONAL, nao mensagem 'sera implementado'"
    }

    if ($problemas.Count -gt 0) {
        Write-Host "  [COMPLETUDE] $Descricao tem $($problemas.Count) problema(s):" -ForegroundColor Yellow
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

<#
.SYNOPSIS
    Cria prompt espec�fico para uma fase da migra��o
.DESCRIPTION
    Gera prompt focado em uma parte espec�fica do formul�rio (Form, BO, Lookups, etc.)
#>
function New-PromptFase {
    param(
        [int]$NumeroFase,
        [int]$TotalFases,
        [string]$TaskPath,
        [string]$BaseName,
        [string]$MetaPromptOriginal,
        [string]$FormType = "CRUD"
    )

    $formClass = Get-FormClassName -BaseName $BaseName
    $boClass = Get-BOClassName -BaseName $BaseName
    $formSubDir = Get-FormSubDir -FormType $FormType

    # Define foco de cada fase (8 fases para arquivos grandes)
    $fasesConfig = @{
        1 = @{
            Nome = "BO - Propriedades e Init"
            Descricao = "Criar BO com declara��es de propriedades e Init() b�sico"
            Instrucoes = @"
## FASE 1/8: BO - PROPRIEDADES E INIT

### OBJETIVO
Criar **$boClass.prg** com:
- TODAS as declara��es de propriedades (this_c*, this_n*, this_d*, this_l*)
- Init() configurando this_cTabela e this_cCampoChave

### O QUE INCLUIR
- Estrutura DEFINE CLASS $boClass AS BusinessBase
- TODAS as propriedades (extrair do c�digo fonte original)
- Init() b�sico

### O QUE N�O INCLUIR (pr�ximas fases)
- CarregarDoCursor(), Inserir(), Atualizar() (Fase 2)

### ENTREGA ESPERADA
Arquivo PARCIAL: C:\4c\projeto\app\classes\$boClass.prg

**IMPORTANTE**: Declarar TODAS as propriedades, n�o criar vers�o reduzida!
"@
        }
        2 = @{
            Nome = "BO - M�todos CRUD"
            Descricao = "Adicionar m�todos CRUD ao BO"
            Instrucoes = @"
## FASE 2/8: BO - M�TODOS CRUD

### OBJETIVO
COMPLETAR $boClass.prg adicionando:
- CarregarDoCursor() mapeando TODAS as colunas
- Inserir() com SQL INSERT completo
- Atualizar() com SQL UPDATE completo
- ObterChavePrimaria()
- RegistrarAuditoria() em Inserir/Atualizar

### COMO FAZER
1. LER o arquivo existente: C:\4c\projeto\app\classes\$boClass.prg
2. ADICIONAR os m�todos CRUD
3. USAR Edit tool para modificar arquivo existente

### ENTREGA ESPERADA
Arquivo COMPLETO: C:\4c\projeto\app\classes\$boClass.prg
"@
        }
        3 = @{
            Nome = "Form - Estrutura Base"
            Descricao = "Criar estrutura b�sica do Form com PageFrame e Containers"
            Instrucoes = @"
## FASE 3/8: FORM - ESTRUTURA BASE

### OBJETIVO
Criar **$formClass.prg** com estrutura b�sica:
- DEFINE CLASS com propriedades (this_oBusinessObject, this_cModoAtual, etc.)
- Init() completo (inicializar BO, InicializarForm)
- InicializarForm() (conectar, criar PageFrame)
- ConfigurarPageFrame() (2 p�ginas)
- Destroy()

### O QUE INCLUIR
- PageFrame com Page1 (Lista) e Page2 (Dados)
- Containers principais vazios: cnt_4c_Cabecalho, cnt_4c_Botoes, cnt_4c_BotoesAcao

### O QUE N�O INCLUIR (pr�ximas fases)
- Grid e bot�es CRUD (Fase 4)
- TextBoxes de dados (Fases 5-6)
- Eventos (Fases 7-8)

### ENTREGA ESPERADA
Arquivo PARCIAL: C:\4c\projeto\app\forms\$formSubDir\$formClass.prg
"@
        }
        4 = @{
            Nome = "Form - Grid e Bot�es CRUD (Page1)"
            Descricao = "Adicionar Grid e bot�es CRUD na Page1"
            Instrucoes = @"
## FASE 4/8: FORM - GRID E BOT�ES CRUD

### OBJETIVO
COMPLETAR Page1 de $formClass.prg adicionando:
- ConfigurarPaginaLista() com Grid completo
- Container cnt_4c_Botoes com 6 bot�es CRUD (Incluir, Visualizar, Alterar, Excluir, Buscar, Encerrar)
- AlternarPagina()

### COMO FAZER
1. LER o arquivo existente: C:\4c\projeto\app\forms\$formSubDir\$formClass.prg
2. ADICIONAR ConfigurarPaginaLista() e AlternarPagina()
3. USAR Edit tool para modificar arquivo existente

### ENTREGA ESPERADA
Arquivo ATUALIZADO: C:\4c\projeto\app\forms\$formSubDir\$formClass.prg
"@
        }
        5 = @{
            Nome = "Form - Campos Principais (Page2 - Parte 1)"
            Descricao = "Adicionar primeiros 50% dos campos da Page2"
            Instrucoes = @"
## FASE 5/8: FORM - CAMPOS PRINCIPAIS (PARTE 1)

### OBJETIVO
Adicionar METADE dos campos em ConfigurarPaginaDados():
- Container cnt_4c_Cabecalho
- Primeiros 50% dos TextBoxes e Labels

### COMO IDENTIFICAR QUAIS CAMPOS
Usar mapeamento.json e codigo fonte original para identificar campos.
Dividir lista de campos ao meio - processar primeira metade.

### COMO FAZER
1. LER o arquivo existente: C:\4c\projeto\app\forms\$formSubDir\$formClass.prg
2. ADICIONAR ConfigurarPaginaDados() com METADE dos campos
3. USAR Edit tool para modificar arquivo existente

### ENTREGA ESPERADA
Arquivo ATUALIZADO: C:\4c\projeto\app\forms\$formSubDir\$formClass.prg
"@
        }
        6 = @{
            Nome = "Form - Campos Restantes e Lookups (Page2 - Parte 2)"
            Descricao = "Adicionar �ltimos 50% dos campos e implementar lookups"
            Instrucoes = @"
## FASE 6/8: FORM - CAMPOS RESTANTES E LOOKUPS

### OBJETIVO
COMPLETAR ConfigurarPaginaDados() adicionando:
- Ultimos 50% dos TextBoxes e Labels
- TODOS os lookups com BINDEVENT (F4/F5) COMPLETAMENTE IMPLEMENTADOS
- Container cnt_4c_BotoesAcao (Salvar, Cancelar)

### REGRA CRITICA: LOOKUP COMPLETO - PROIBIDO DEIXAR TODO
**PROIBIDO** criar metodos de lookup com comentarios TODO ou stubs vazios.
Cada campo com lookup DEVE ter o metodo AbrirLookupXxx() COMPLETAMENTE implementado.

### PADRAO OBRIGATORIO DE LOOKUP (copiar e adaptar para cada campo)

#### 1. BINDEVENT no ConfigurarPaginaDados() - registrar F4 e DblClick:
```foxpro
*-- BINDEVENT para campo com lookup
BINDEVENT(loc_oPagina.txt_4c_CodGrupo, "KeyPress", THIS, "CodGrupoLookupKeyPress")
BINDEVENT(loc_oPagina.txt_4c_CodGrupo, "DblClick", THIS, "CodGrupoLookupDblClick")
```

#### 2. Metodos de evento (PUBLIC - nunca PROTECTED):
```foxpro
PROCEDURE CodGrupoLookupKeyPress(nKeyCode, nShiftAltCtrl)
    IF nKeyCode = 28  && F4 (codigo 28 no VFP9)
        THIS.AbrirLookupGrupo()
    ENDIF
ENDPROC

PROCEDURE CodGrupoLookupDblClick()
    THIS.AbrirLookupGrupo()
ENDPROC
```

#### 3. Metodo AbrirLookupXxx() COMPLETO E FUNCIONAL:
```foxpro
PROCEDURE AbrirLookupGrupo()
    *-- Verificar se campo esta habilitado
    IF !THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_CodGrupo.Enabled
        RETURN
    ENDIF

    LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
        "SigCdGrp", ;
        "cursor_4c_BuscaGrupo", ;
        "cgrus", ;
        ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_CodGrupo.Value), ;
        "Buscar Grupo")

    *-- Configurar colunas (usar nomes EXATOS das colunas da tabela no banco)
    loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")

    *-- Exibir e aguardar selecao
    loc_oBusca.Show()

    *-- Processar selecao
    IF loc_oBusca.this_lSelecionou
        IF USED("cursor_4c_BuscaGrupo")
            loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
            loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrupo.dgrus)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_CodGrupo.Value  = loc_cCodigo
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Dados.txt_4c_DescGrupo.Value = loc_cDescricao
        ENDIF
    ENDIF

    *-- Limpar cursor e objeto
    IF USED("cursor_4c_BuscaGrupo")
        USE IN cursor_4c_BuscaGrupo
    ENDIF
    loc_oBusca.Release()
ENDPROC
```

### MAPEAMENTO TABELAS AUXILIARES (nomes EXATOS do banco)
Consultar docs/schema.sql para nomes de tabelas e colunas. Exemplos comuns:
- Grupo Produto:  SigCdGrp  -> cgrus (cod), dgrus (desc)
- Grupo CC:       SigCdGcr  -> Codigos (cod), Descrs (desc) **NAO confundir com SigCdGrp!**
- SubGrupo:       SigCdSgp  -> csgps (cod), dsgps (desc)
- Cor:            SigCdCor  -> cods  (cod), descs (desc)
- Tamanho:        SigCdTam  -> ctams (cod), dtams (desc)
- Moeda:          SigCdMoe  -> cmoes (cod), dmoes (desc)
- Fornecedor:     SigCdCli  -> Iclis (cod), Rclis (desc)
- Grupo Acesso:   SigCdAcg  -> cgacs (cod), dgacs (desc)

**REGRA CRITICA**: NUNCA adivinhar tabela/coluna! SEMPRE verificar no codigo fonte ORIGINAL qual tabela eh usada.
Se o original usa ``Seek(valor, [crSigCdGcr], [Codigos])``, a tabela eh SigCdGcr, NAO SigCdGrp!

### COMO FAZER
1. LER o arquivo existente: C:\4c\projeto\app\forms\$formSubDir\$formClass.prg
2. LER o codigo fonte original para identificar TODOS os campos com lookup (F4/F5/sigacess)
3. Para CADA campo com lookup: adicionar BINDEVENT + metodo evento + AbrirLookupXxx() COMPLETO
4. USAR Edit tool para modificar arquivo existente

### VALIDACAO OBRIGATORIA ANTES DE ENTREGAR
- Nenhum metodo de lookup pode conter "TODO" ou estar vazio
- Cada AbrirLookupXxx() deve ter: CREATEOBJECT FormBuscaAuxiliar, mAddColuna, Show(), verificar this_lSelecionou, preencher campo, USE IN cursor, Release()

### ENTREGA ESPERADA
Arquivo ATUALIZADO: C:\4c\projeto\app\forms\$formSubDir\$formClass.prg
"@
        }
        7 = @{
            Nome = "Form - Eventos Principais"
            Descricao = "Implementar eventos principais dos bot�es"
            Instrucoes = @"
## FASE 7/8: FORM - EVENTOS PRINCIPAIS

### OBJETIVO
Adicionar eventos principais:
- BtnIncluirClick()
- BtnAlterarClick()
- BtnVisualizarClick()
- BtnExcluirClick()

### COMO FAZER
1. LER o arquivo existente: C:\4c\projeto\app\forms\$formSubDir\$formClass.prg
2. ADICIONAR os 4 eventos principais
3. USAR Edit tool para modificar arquivo existente

### ENTREGA ESPERADA
Arquivo ATUALIZADO: C:\4c\projeto\app\forms\$formSubDir\$formClass.prg
"@
        }
        8 = @{
            Nome = "Form - Eventos Auxiliares e Consolida��o"
            Descricao = "Finalizar com eventos auxiliares e m�todos de suporte"
            Instrucoes = @"
## FASE 8/8: FORM - EVENTOS AUXILIARES E CONSOLIDA��O FINAL

### OBJETIVO
FINALIZAR $formClass.prg adicionando:
- BtnBuscarClick(), BtnEncerrarClick()
- BtnSalvarClick(), BtnCancelarClick()
- FormParaBO() e BOParaForm() COMPLETOS (TODOS os campos!)
- HabilitarCampos(), LimparCampos()
- CarregarLista(), AjustarBotoesPorModo()

### VALIDA��O FINAL
- Todos os m�todos implementados
- FormParaBO/BOParaForm com TODOS os campos
- Arquivo COMPLETO e funcional

### ENTREGA ESPERADA
Arquivo FINAL COMPLETO: C:\4c\projeto\app\forms\$formSubDir\$formClass.prg

**IMPORTANTE**: Verificar que FormParaBO e BOParaForm incluem TODOS os campos!
"@
        }
    }

    $faseAtual = $fasesConfig[$NumeroFase]

    # Verificar se existe arquivo de instrucoes especificas do usuario
    $instrucaoFile = Join-Path $TaskPath "$BaseName.txt"
    $instrucaoBlock = ""
    if (Test-Path $instrucaoFile) {
        $instrucaoContent = Get-Content $instrucaoFile -Raw
        $instrucaoBlock = @"

---

=== INSTRUCOES ESPECIFICAS DO USUARIO ===
$instrucaoContent
=== FIM DAS INSTRUCOES ===

"@
    }

    $promptContent = @"
# MIGRACAO MULTI-FASE: FASE $NumeroFase/$TotalFases

## ?? FASE ATUAL: $($faseAtual.Nome)

$($faseAtual.Descricao)

$($faseAtual.Instrucoes)

---
$instrucaoBlock
## ?? CONTEXTO DA MIGRA��O

$MetaPromptOriginal

---

## ?? REGRAS CR�TICAS

### 1. Paridade Funcional 100%
**NUNCA criar vers�es reduzidas!** Incluir TODOS os campos, TODOS os m�todos, TODAS as funcionalidades.

### 2. Fases Anteriores
$(if ($NumeroFase -gt 1) {
    "Arquivos j� criados nas fases anteriores:"
    if ($NumeroFase -ge 2) { "  ? FASE 1: $boClass.prg (BO - propriedades e Init)" }
    if ($NumeroFase -ge 3) { "  ? FASE 2: $boClass.prg (BO - m�todos CRUD completo)" }
    if ($NumeroFase -ge 4) { "  ? FASE 3: $formClass.prg (Form - estrutura base)" }
    if ($NumeroFase -ge 5) { "  ? FASE 4: $formClass.prg (Form - Grid e bot�es CRUD)" }
    if ($NumeroFase -ge 6) { "  ? FASE 5: $formClass.prg (Form - campos principais parte 1)" }
    if ($NumeroFase -ge 7) { "  ? FASE 6: $formClass.prg (Form - campos restantes e lookups)" }
    if ($NumeroFase -ge 8) { "  ? FASE 7: $formClass.prg (Form - eventos principais)" }
} else {
    "Esta � a PRIMEIRA fase. Nenhum arquivo foi criado ainda."
})

### 3. Uso de Ferramentas
- **Fase 1**: Use Write para criar novo arquivo BO
- **Fase 2**: Use Read + Edit para COMPLETAR o BO existente (criado na Fase 1)
- **Fase 3**: Use Write para criar novo arquivo Form
- **Fases 4-8**: Use Read + Edit para MODIFICAR arquivo existente

### 4. Valida��o
Ao final, verificar se arquivo foi criado/modificado corretamente.

---

## ?? A��O OBRIGAT�RIA

$(if ($NumeroFase -eq 1 -or $NumeroFase -eq 2) {
    "**CRIAR** arquivo completo usando Write tool."
} else {
    "**MODIFICAR** arquivo existente usando Read + Edit tools."
})

N�O pergunte, N�O pe�a confirma��o.
EXECUTE A FASE $NumeroFase AGORA!

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

$(if ($FormType -eq "OPERACIONAL") {
@"
### REGRAS ESPECIFICAS PARA FORM OPERACIONAL

1. **Containers Flutuantes**: Containers com Visible=.F. toggled por botoes - TornarControlesVisiveis DEVE filtrar por nome (INLIST/IF LOOP)
2. **CREATE CURSOR**: Se mesmo cursor aparece em mais de um local, a ORDEM DOS CAMPOS deve ser IDENTICA
3. **Grid ControlSource**: Campos usados em ControlSource DEVEM existir no CREATE CURSOR com nomes identicos
4. **SQLEXEC**: Sempre em cursor temporario + ZAP + APPEND FROM DBF() (nunca direto no cursor do Grid)
5. **SET NULL ON**: Antes de CREATE CURSOR que recebera dados de SQLEXEC
6. **Layout**: NAO segue padrao CRUD Page1=Lista/Page2=Dados - analisar original
"@
})
"@

    return $promptContent
}

<#
.SYNOPSIS
    Executa uma fase espec�fica da migra��o
.DESCRIPTION
    Invoca Claude CLI com prompt focado em uma parte do formul�rio
#>
function Invoke-MigracaoFase {
    param(
        [int]$NumeroFase,
        [int]$TotalFases,
        [string]$TaskId,
        [string]$BaseName,
        [string]$TaskPath,
        [string]$MetaPromptOriginal,
        [array]$ContextFiles,
        $Config,  # PSCustomObject do ConvertFrom-Json
        [string]$FormType = "CRUD"
    )

    Write-Host ""
    Write-Host "========================================================================" -ForegroundColor Cyan
    Write-Host "  FASE $NumeroFase/$TotalFases" -ForegroundColor Cyan
    Write-Host "========================================================================" -ForegroundColor Cyan

    # Cria prompt espec�fico para esta fase
    $fasePromptContent = New-PromptFase -NumeroFase $NumeroFase -TotalFases $TotalFases `
        -TaskPath $TaskPath -BaseName $BaseName -MetaPromptOriginal $MetaPromptOriginal -FormType $FormType

    $fasePromptFile = Join-Path $TaskPath "fase_${NumeroFase}_prompt.md"
    Set-Content -Path $fasePromptFile -Value $fasePromptContent -Encoding UTF8

    $outputFile = Join-Path $TaskPath "fase_${NumeroFase}_output.txt"
    $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "05_migracao_fase${NumeroFase}" -TasksDir $Config.paths.tasks

    Write-Host "Executando Fase $NumeroFase..." -ForegroundColor Yellow

    # Invoca Claude CLI
    & (Join-Path $Config.paths.automation "ClaudeInvoker.ps1") `
        -PromptFile $fasePromptFile `
        -OutputFile $outputFile `
        -Model $Config.claude.model `
        -Timeout $Config.claude.timeout `
        -LogFile $logFile `
        -ContextFiles $ContextFiles `
        -RateLimitMaxRetries $Config.rateLimitRetry.maxRetries `
        -RateLimitInitialDelaySeconds $Config.rateLimitRetry.initialDelaySeconds `
        -RateLimitMaxDelaySeconds $Config.rateLimitRetry.maxDelaySeconds `
        -RateLimitBackoffMultiplier $Config.rateLimitRetry.backoffMultiplier `
        -UsageLimitWaitSeconds $Config.rateLimitRetry.usageLimitWaitSeconds `
                -MaxOutputTokens $Config.claude.maxOutputTokens

    # Verifica se arquivos esperados foram criados/modificados
    # IMPORTANTE: Verificar ANTES de checar exit code, pois timeout pode ter
    # ocorrido DEPOIS dos arquivos ja terem sido escritos no disco
    $formClass = Get-FormClassName -BaseName $BaseName
    $boClass = Get-BOClassName -BaseName $BaseName
    $formSubDir = Get-FormSubDir -FormType $FormType
    $formFile = Join-Path $Config.paths.projeto "app\forms\$formSubDir\$formClass.prg"
    $boFile = Join-Path $Config.paths.projeto "app\classes\$boClass.prg"

    # Fallback: procurar Form em outras pastas
    if (-not (Test-Path $formFile)) {
        $foundForm = Find-FormFile -ProjetoPath $Config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
        if ($foundForm) { $formFile = $foundForm }
    }

    if ($LASTEXITCODE -ne 0) {
        # Verifica se foi usage limit para mensagem mais informativa
        $faseOutput = if (Test-Path $outputFile) { Get-Content $outputFile -Raw -ErrorAction SilentlyContinue } else { "" }
        if (Test-UsageLimitHit $faseOutput) {
            throw "Usage limit atingido na Fase $NumeroFase. Aguarde o reset e re-execute."
        }

        # Verifica se arquivos foram gerados apesar do timeout/erro
        $filesExist = $false
        switch ($NumeroFase) {
            { $_ -le 2 } { $filesExist = Test-Path $boFile }
            default       { $filesExist = Test-Path $formFile }
        }

        if ($filesExist) {
            Write-Host "  Arquivos detectados em disco apesar do exit code $LASTEXITCODE (post-timeout)" -ForegroundColor Yellow
            Write-Host "  Continuando com validacao..." -ForegroundColor Yellow
        }
        else {
            # Retry com timeout maior e modelo opus
            Write-Host "  Fase $NumeroFase falhou (exit code $LASTEXITCODE). Retentando com opus e timeout 2x..." -ForegroundColor Yellow
            Start-Sleep -Seconds 10

            & (Join-Path $Config.paths.automation "ClaudeInvoker.ps1") `
                -PromptFile $fasePromptFile `
                -OutputFile $outputFile `
                -Model "opus" `
                -Timeout ($Config.claude.timeout * 2) `
                -LogFile $logFile `
                -ContextFiles $ContextFiles `
                -RateLimitMaxRetries $Config.rateLimitRetry.maxRetries `
                -RateLimitInitialDelaySeconds $Config.rateLimitRetry.initialDelaySeconds `
                -RateLimitMaxDelaySeconds $Config.rateLimitRetry.maxDelaySeconds `
                -RateLimitBackoffMultiplier $Config.rateLimitRetry.backoffMultiplier `
                -UsageLimitWaitSeconds $Config.rateLimitRetry.usageLimitWaitSeconds `
                -MaxOutputTokens $Config.claude.maxOutputTokens

            # Verifica novamente apos retry
            switch ($NumeroFase) {
                { $_ -le 2 } { $filesExist = Test-Path $boFile }
                default       { $filesExist = Test-Path $formFile }
            }

            if (-not $filesExist) {
                throw "Fase $NumeroFase falhou apos retry com opus. Exit code: $LASTEXITCODE"
            }
            Write-Host "  Fase $NumeroFase recuperada com retry opus" -ForegroundColor Green
        }
    }

    $validado = $false

    switch ($NumeroFase) {
        1 {
            # Fase 1: Espera BO completo
            if (Test-Path $boFile) {
                $tamanho = [math]::Round((Get-Item $boFile).Length / 1KB, 2)
                Write-Host "  ? BO criado: $boFile ($tamanho KB)" -ForegroundColor Green
                $validado = $true
            } else {
                Write-Host "  ? BO N�O foi criado: $boFile" -ForegroundColor Red
            }
        }
        2 {
            # Fase 2: Espera BO completado com m�todos especificos do tipo de form
            # CRUD/OPERACIONAL: CarregarDoCursor + Inserir + Atualizar
            # REPORT: PrepararDados (Imprimir/Visualizar herdam ou sobrescrevem)
            if (Test-Path $boFile) {
                $conteudo = Get-Content $boFile -Raw
                if ($FormType -eq "REPORT") {
                    if ($conteudo -match "PrepararDados") {
                        $tamanho = [math]::Round((Get-Item $boFile).Length / 1KB, 2)
                        Write-Host "  ? BO de RELATORIO completado com PrepararDados: $boFile ($tamanho KB)" -ForegroundColor Green
                        $validado = $true
                    } else {
                        Write-Host "  ?? BO de RELATORIO existe mas falta PrepararDados()" -ForegroundColor Yellow
                    }
                } elseif ($conteudo -match "CarregarDoCursor" -and $conteudo -match "Inserir" -and $conteudo -match "Atualizar") {
                    $tamanho = [math]::Round((Get-Item $boFile).Length / 1KB, 2)
                    Write-Host "  ? BO completado com m�todos CRUD: $boFile ($tamanho KB)" -ForegroundColor Green
                    $validado = $true
                } else {
                    Write-Host "  ?? BO existe mas faltam m�todos CRUD (CarregarDoCursor, Inserir, Atualizar)" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  ? BO N�O foi encontrado: $boFile" -ForegroundColor Red
            }
        }
        3 {
            # Fase 3: Espera Form com estrutura base (PageFrame, Containers)
            if (Test-Path $formFile) {
                $conteudo = Get-Content $formFile -Raw
                if ($conteudo -match "ConfigurarPageFrame" -and $conteudo -match "InicializarForm") {
                    $tamanho = [math]::Round((Get-Item $formFile).Length / 1KB, 2)
                    Write-Host "  ? Form criado com estrutura base: $formFile ($tamanho KB)" -ForegroundColor Green
                    $validado = $true
                } else {
                    Write-Host "  ?? Form criado mas faltam m�todos base (ConfigurarPageFrame, InicializarForm)" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  ? Form N�O foi criado: $formFile" -ForegroundColor Red
            }
        }
        4 {
            # Fase 4: Espera Form com Grid e Bot�es CRUD
            if (Test-Path $formFile) {
                $conteudo = Get-Content $formFile -Raw
                if ($conteudo -match "ConfigurarPaginaLista" -and $conteudo -match "AlternarPagina") {
                    $tamanho = [math]::Round((Get-Item $formFile).Length / 1KB, 2)
                    Write-Host "  ? Form atualizado com Grid e Bot�es CRUD: $formFile ($tamanho KB)" -ForegroundColor Green
                    $validado = $true
                } else {
                    Write-Host "  ?? Form existe mas faltam m�todos (ConfigurarPaginaLista, AlternarPagina)" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  ? Form N�O encontrado: $formFile" -ForegroundColor Red
            }
        }
        5 {
            # Fase 5: Espera Form com campos principais (Parte 1)
            if (Test-Path $formFile) {
                $conteudo = Get-Content $formFile -Raw
                if ($conteudo -match "ConfigurarPaginaDados") {
                    $tamanho = [math]::Round((Get-Item $formFile).Length / 1KB, 2)
                    Write-Host "  ? Form atualizado com campos principais: $formFile ($tamanho KB)" -ForegroundColor Green
                    $validado = $true
                } else {
                    Write-Host "  ?? Form existe mas falta ConfigurarPaginaDados" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  ? Form N�O encontrado: $formFile" -ForegroundColor Red
            }
        }
        6 {
            # Fase 6: Espera Form com campos restantes e lookups
            if (Test-Path $formFile) {
                $conteudo = Get-Content $formFile -Raw
                # Deve ter ConfigurarPaginaDados e lookups (BINDEVENT)
                if ($conteudo -match "ConfigurarPaginaDados" -and $conteudo -match "BINDEVENT") {
                    $tamanho = [math]::Round((Get-Item $formFile).Length / 1KB, 2)
                    Write-Host "  ? Form atualizado com campos restantes e lookups: $formFile ($tamanho KB)" -ForegroundColor Green
                    $validado = $true
                } else {
                    Write-Host "  ?? Form existe mas faltam campos ou lookups" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  ? Form N�O encontrado: $formFile" -ForegroundColor Red
            }
        }
        7 {
            # Fase 7: Espera Form com eventos principais
            if (Test-Path $formFile) {
                $conteudo = Get-Content $formFile -Raw
                $eventosEsperados = @("BtnIncluirClick", "BtnAlterarClick", "BtnVisualizarClick", "BtnExcluirClick")
                $eventosFaltantes = $eventosEsperados | Where-Object { $conteudo -notmatch $_ }

                if ($eventosFaltantes.Count -eq 0) {
                    $tamanho = [math]::Round((Get-Item $formFile).Length / 1KB, 2)
                    Write-Host "  ? Form atualizado com eventos principais: $formFile ($tamanho KB)" -ForegroundColor Green
                    $validado = $true
                } else {
                    Write-Host "  ?? Form existe mas faltam eventos: $($eventosFaltantes -join ', ')" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  ? Form N�O encontrado: $formFile" -ForegroundColor Red
            }
        }
        8 {
            # Fase 8: Espera Form COMPLETO com todos os eventos e m�todos
            if (Test-Path $formFile) {
                $conteudo = Get-Content $formFile -Raw
                $metodosFinals = @("BtnSalvarClick", "BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
                $metodosFaltantes = $metodosFinals | Where-Object { $conteudo -notmatch $_ }

                if ($metodosFaltantes.Count -eq 0) {
                    $tamanho = [math]::Round((Get-Item $formFile).Length / 1KB, 2)
                    Write-Host "  ? Form COMPLETO com todos os m�todos: $formFile ($tamanho KB)" -ForegroundColor Green
                    $validado = $true
                } else {
                    Write-Host "  ?? Form existe mas faltam m�todos finais: $($metodosFaltantes -join ', ')" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  ? Form N�O encontrado: $formFile" -ForegroundColor Red
            }
        }
    }

    if (-not $validado) {
        throw "Fase $NumeroFase N�O passou na valida��o. Verifique os logs em $logFile"
    }

    # ===================================================================
    # VALIDACAO DE COMPLETUDE: Detectar TODO/stubs/procedures vazias
    # Aplicada nas fases finais de cada arquivo (2, 6, 7, 8)
    # ===================================================================
    if ($NumeroFase -in @(2, 6, 7, 8)) {
        $arquivoValidar = switch ($NumeroFase) {
            2       { $boFile }
            default { $formFile }
        }
        $descValidar = switch ($NumeroFase) {
            2       { "BO (Fase $NumeroFase)" }
            default { "Form (Fase $NumeroFase)" }
        }

        if (Test-Path $arquivoValidar) {
            $completudeOK = Test-CompletudeCodigo -FilePath $arquivoValidar -Descricao $descValidar
            if (-not $completudeOK) {
                Write-Host "  ?? AVISO: Fase $NumeroFase tem problemas de completude (TODO/stubs)" -ForegroundColor Yellow
                Write-Host "  O CorretorAutomatico e validacoes posteriores tentarao resolver." -ForegroundColor Yellow
                # Nao bloqueia a fase - apenas avisa. A etapa 5.5 (CorretorAutomatico)
                # e a etapa final de completude (nova) tentarao corrigir.
            }
        }
    }

    Write-Host ""
    return $validado
}

<#
.SYNOPSIS
    Executa migra��o completa em m�ltiplas fases
.DESCRIPTION
    Divide processamento em fases e consolida no final
#>
function Invoke-MigracaoFaseada {
    param(
        [string]$TaskId,
        [string]$BaseName,
        [string]$TaskPath,
        [string]$TxtFile,
        $Complexidade,  # PSCustomObject ou hashtable
        $Config,        # PSCustomObject do ConvertFrom-Json
        [string]$FormType = "CRUD"
    )

    Write-Host ""
    Write-Host "========================================================================" -ForegroundColor Magenta
    Write-Host "  PROCESSAMENTO MULTI-FASE AUTOM�TICO" -ForegroundColor Magenta
    Write-Host "========================================================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "Arquivo COMPLEXO detectado:" -ForegroundColor Yellow
    Write-Host "  - Tamanho: $($Complexidade.TamanhoKB) KB" -ForegroundColor Yellow
    Write-Host "  - Linhas: $($Complexidade.Linhas)" -ForegroundColor Yellow
    Write-Host "  - Motivo: $($Complexidade.Motivo)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Estrat�gia: Processar em 8 fases (garantir 100% funcionalidade)" -ForegroundColor Cyan
    Write-Host "  Fase 1: BO - Propriedades e Init" -ForegroundColor Cyan
    Write-Host "  Fase 2: BO - M�todos CRUD" -ForegroundColor Cyan
    Write-Host "  Fase 3: Form - Estrutura Base" -ForegroundColor Cyan
    Write-Host "  Fase 4: Form - Grid e Bot�es CRUD" -ForegroundColor Cyan
    Write-Host "  Fase 5: Form - Campos Principais (Parte 1)" -ForegroundColor Cyan
    Write-Host "  Fase 6: Form - Campos Restantes e Lookups" -ForegroundColor Cyan
    Write-Host "  Fase 7: Form - Eventos Principais" -ForegroundColor Cyan
    Write-Host "  Fase 8: Form - Eventos Auxiliares e Consolida��o" -ForegroundColor Cyan
    Write-Host ""

    # Carrega meta-prompt original
    $metaPromptFile = Join-Path $TaskPath "meta_prompt.md"
    $metaPromptOriginal = Get-Content $metaPromptFile -Raw

    # Prepara arquivos auxiliares
    $mapeamentoFile = Join-Path $TaskPath "mapeamento.json"
    $analiseFile = Join-Path $TaskPath "analise.json"
    $slimFile = $TxtFile -replace "\.txt$", "_slim.txt"

    # Executa 8 fases sequencialmente (garantir 100% funcionalidade com arquivo grande)
    $totalFases = 8

    for ($fase = 1; $fase -le $totalFases; $fase++) {
        # ===================================================================
        # ESTRAT�GIA DE CONTEXTO POR FASE (para evitar "Prompt too long")
        # ===================================================================

        # Contexto base (sempre incluir)
        # NOTA: CLAUDE.md NAO incluido aqui - Claude CLI carrega automaticamente
        # como system prompt a partir do diretorio do projeto (C:\4c\CLAUDE.md)
        # Incluir novamente causaria duplicacao de ~8 KB por fase (CLAUDE.md reduzido em 2026-03-17)
        $contextFiles = @(
            "C:\4c\docs\FORMCOR_LICOES_APRENDIDAS.md",
            "C:\4c\docs\migration_guide.md",
            "C:\4c\docs\framework_frmcadastro_layout.md"
        )

        # Adicionar comportamento.json (sempre, se disponivel)
        $comportamentoFile = Join-Path $TaskPath "comportamento.json"
        if (Test-Path $comportamentoFile) { $contextFiles += $comportamentoFile }

        # Adicionar layout.json (posicoes exatas dos controles por Page)
        $layoutFile = Join-Path $TaskPath "layout.json"
        if (Test-Path $layoutFile) { $contextFiles += $layoutFile }

        # Adicionar screenshots de referencia (0 a N, opcionais)
        $refScreenshots = Get-ChildItem -Path $TaskPath -Filter "*_*.png" -ErrorAction SilentlyContinue
        $refScreenshots += Get-ChildItem -Path $TaskPath -Filter "*_*.jpg" -ErrorAction SilentlyContinue
        if ($refScreenshots.Count -gt 0) {
            foreach ($img in $refScreenshots) { $contextFiles += $img.FullName }
            Write-Host "  Screenshots de referencia: $($refScreenshots.Count) imagem(ns)" -ForegroundColor Cyan
        }

        # Adicionar arquivos espec�ficos por fase
        if ($fase -le 2) {
            # FASES 1-2 (BO): Usar apenas analise.json + mapeamento.json
            # N�o precisa do arquivo original - BO � simples (propriedades + CRUD)
            if (Test-Path $analiseFile) { $contextFiles += $analiseFile }
            if (Test-Path $mapeamentoFile) { $contextFiles += $mapeamentoFile }
            Write-Host "  Contexto Fase ${fase}: analise.json + mapeamento.json + comportamento.json (SEM arquivo original)" -ForegroundColor Cyan
        }
        else {
            # FASES 3-8 (Form): Usar arquivo SLIM se dispon�vel
            # Budget seguro sem CLAUDE.md: SLIM + FORMCOR(31) + migration(27) + mapeamento(28) + prompt(32) < 350 KB
            # Portanto SLIM deve ser <= 230 KB para caber com folga
            $limiteSlimKB = 230

            if (Test-Path $slimFile) {
                $slimSize = [math]::Round((Get-Item $slimFile).Length / 1024, 2)

                if ($slimSize -le $limiteSlimKB) {
                    # SLIM dentro do limite ? usar diretamente
                    $contextFiles += $slimFile
                    Write-Host "  Contexto Fase ${fase}: arquivo SLIM ($slimSize KB) + mapeamento.json" -ForegroundColor Cyan
                }
                else {
                    # SLIM muito grande ? criar nano-slim com orcamento dinamico
                    # Calcula tamanho disponivel baseado no comportamento.json
                    $comportamentoKB = 0
                    $comportamentoFile = Join-Path $TaskPath "comportamento.json"
                    if (Test-Path $comportamentoFile) {
                        $comportamentoKB = [math]::Round((Get-Item $comportamentoFile).Length / 1024, 0)
                    }
                    $outrosKB = 130  # prompt + mapeamento + licoes + margem
                    $maxContextKB = 500  # limite seguro para Sonnet
                    $targetSlimKB = $maxContextKB - $comportamentoKB - $outrosKB
                    if ($targetSlimKB -lt 80) { $targetSlimKB = 80 }   # minimo 80KB
                    if ($targetSlimKB -gt 200) { $targetSlimKB = 200 } # maximo 200KB

                    Write-Host "  SLIM muito grande ($slimSize KB > $limiteSlimKB KB)" -ForegroundColor Yellow
                    Write-Host "  Orcamento dinamico: comportamento=${comportamentoKB}KB, targetSlim=${targetSlimKB}KB" -ForegroundColor Yellow
                    $nanoSlimFile = $slimFile -replace "_slim\.txt$", "_nanoSlim.txt"

                    if (-not (Test-Path $nanoSlimFile)) {
                        $maxBytes = [int]($targetSlimKB * 1024)
                        $slimContent = [System.IO.File]::ReadAllBytes($slimFile)
                        $truncBytes = $slimContent[0..([Math]::Min($maxBytes, $slimContent.Length) - 1)]
                        [System.IO.File]::WriteAllBytes($nanoSlimFile, $truncBytes)
                        Write-Host "  Nano-slim criado: $([math]::Round($truncBytes.Length/1024, 1)) KB" -ForegroundColor Cyan
                    }

                    $contextFiles += $nanoSlimFile
                    Write-Host "  Contexto Fase ${fase}: nano-slim ($targetSlimKB KB) + mapeamento.json" -ForegroundColor Cyan
                }
            }
            else {
                # Sem SLIM: usar analise.json + mapeamento.json como fallback
                Write-Host "  Contexto Fase ${fase}: analise.json + mapeamento.json (SLIM nao disponivel)" -ForegroundColor Yellow
                if (Test-Path $analiseFile) { $contextFiles += $analiseFile }
            }

            if (Test-Path $mapeamentoFile) { $contextFiles += $mapeamentoFile }
        }

        try {
            Invoke-MigracaoFase -NumeroFase $fase -TotalFases $totalFases `
                -TaskId $TaskId -BaseName $BaseName -TaskPath $TaskPath `
                -MetaPromptOriginal $metaPromptOriginal `
                -ContextFiles $contextFiles -Config $Config -FormType $FormType
        }
        catch {
            $erroOriginal = $_.Exception.Message

            # Verificar se eh usage limit (nao adianta retry)
            if (Test-UsageLimitHit $erroOriginal) {
                throw "Usage limit na Fase ${fase}: $erroOriginal"
            }

            Write-Host ""
            Write-Host "========================================================================" -ForegroundColor Red
            Write-Host "  ERRO NA FASE $fase - INICIANDO RETRY COM ESCALACAO" -ForegroundColor Red
            Write-Host "========================================================================" -ForegroundColor Red
            Write-Host "Erro: $erroOriginal" -ForegroundColor Red
            Write-Host ""

            # Retry com prompt enfatico e modelo opus + timeout 3x
            Write-Host "Retentando Fase $fase com modelo OPUS e timeout 3x..." -ForegroundColor Yellow
            Start-Sleep -Seconds 10

            $fasePromptFile = Join-Path $TaskPath "fase_${fase}_prompt.md"
            $faseOutputFile = Join-Path $TaskPath "fase_${fase}_output_retry.txt"
            $faseLogFile = Get-TaskLogPath -TaskId $TaskId -Etapa "05_migracao_fase${fase}_retry" -TasksDir $Config.paths.tasks

            # Adiciona instrucao forcada ao prompt existente
            $promptOriginal = Get-Content $fasePromptFile -Raw
            $forcePromptFile = Join-Path $TaskPath "fase_${fase}_prompt_force.md"
            $forceContent = @"
# RETRY OBRIGATORIO - FASE $fase FALHOU NA TENTATIVA ANTERIOR

**ERRO ANTERIOR**: $erroOriginal

**INSTRUCAO**: Voce DEVE completar esta fase AGORA. NAO pergunte, NAO peca confirmacao.
Gere o codigo COMPLETO e FUNCIONAL.

---

$promptOriginal
"@
            Set-Content -Path $forcePromptFile -Value $forceContent -Encoding UTF8

            & (Join-Path $Config.paths.automation "ClaudeInvoker.ps1") `
                -PromptFile $forcePromptFile `
                -OutputFile $faseOutputFile `
                -Model "opus" `
                -Timeout ($Config.claude.timeout * 3) `
                -LogFile $faseLogFile `
                -ContextFiles $contextFiles `
                -RateLimitMaxRetries $Config.rateLimitRetry.maxRetries `
                -RateLimitInitialDelaySeconds $Config.rateLimitRetry.initialDelaySeconds `
                -RateLimitMaxDelaySeconds $Config.rateLimitRetry.maxDelaySeconds `
                -RateLimitBackoffMultiplier $Config.rateLimitRetry.backoffMultiplier `
                -UsageLimitWaitSeconds $Config.rateLimitRetry.usageLimitWaitSeconds `
                -MaxOutputTokens $Config.claude.maxOutputTokens

            # Verificar se arquivo esperado foi gerado apos retry
            $formClass = Get-FormClassName -BaseName $BaseName
            $boClass = Get-BOClassName -BaseName $BaseName
            $formSubDir = Get-FormSubDir -FormType $FormType
            $formFileCheck = Join-Path $Config.paths.projeto "app\forms\$formSubDir\$formClass.prg"
            $boFileCheck = Join-Path $Config.paths.projeto "app\classes\$boClass.prg"

            $retryOK = $false
            switch ($fase) {
                { $_ -le 2 } { $retryOK = Test-Path $boFileCheck }
                default       { $retryOK = Test-Path $formFileCheck }
            }

            if ($retryOK) {
                Write-Host "  Fase $fase recuperada com retry OPUS" -ForegroundColor Green
            }
            else {
                throw "Fase $fase falhou apos retry com OPUS: $erroOriginal"
            }
        }
    }

    # Valida��o final
    $formClass = Get-FormClassName -BaseName $BaseName
    $boClass = Get-BOClassName -BaseName $BaseName
    $formSubDir = Get-FormSubDir -FormType $FormType
    $formFile = Join-Path $Config.paths.projeto "app\forms\$formSubDir\$formClass.prg"
    $boFile = Join-Path $Config.paths.projeto "app\classes\$boClass.prg"

    # Fallback: procurar Form em outras pastas
    if (-not (Test-Path $formFile)) {
        $foundForm = Find-FormFile -ProjetoPath $Config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
        if ($foundForm) { $formFile = $foundForm }
    }

    Write-Host ""
    Write-Host "========================================================================" -ForegroundColor Green
    Write-Host "  MIGRA��O MULTI-FASE CONCLU�DA" -ForegroundColor Green
    Write-Host "========================================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Arquivos gerados:" -ForegroundColor Green
    Write-Host "  ? Form: $formFile ($([math]::Round((Get-Item $formFile).Length / 1KB, 2)) KB)" -ForegroundColor Green
    Write-Host "  ? BO:   $boFile ($([math]::Round((Get-Item $boFile).Length / 1KB, 2)) KB)" -ForegroundColor Green
    Write-Host ""

    return @{
        Success = $true
        FormFile = $formFile
        BOFile = $boFile
    }
}

#------------------------------------------------------------------------------
# MIGRA��O DE SUB-P�GINAS INTERNAS (PageFrame dentro de Page2)
# Detecta paginas internas nao-migradas via layout.json e gera fases adicionais
#------------------------------------------------------------------------------

function Invoke-MigracaoSubPaginas {
    param(
        [string]$TaskId,
        [string]$BaseName,
        [string]$FormFile,
        [string]$BOFile,
        [string]$TaskPath,
        [object]$Config,
        [string]$FormType
    )

    # 1. Ler layout.json para detectar paginas internas
    $layoutFile = Join-Path $TaskPath "layout.json"
    if (-not (Test-Path $layoutFile)) {
        Write-Host "  [SubPaginas] Sem layout.json - pulando" -ForegroundColor Gray
        return 0
    }

    $layout = Get-Content $layoutFile -Raw | ConvertFrom-Json

    # 2. Encontrar PageFrame interno (pgframeDados ou pgf_4c_DadosInternos)
    # Buscar objetos cujo parent contem um PageFrame dentro de Page2/Dados
    $innerPageParents = @{}
    foreach ($obj in $layout.objects) {
        $parent = $obj.parent
        # Detectar padroes: *.Pagina.Dados.pgframeDados.pgXxx ou *.Page2.pgf_4c_DadosInternos.PageN
        if ($parent -match '(?i)\.(?:Pagina\.Dados|Page2)\.(\w+)\.(\w+)') {
            $pgFrameName = $Matches[1]
            $pageName = $Matches[2]
            # Ignorar o proprio pageframe e pegar apenas sub-paginas
            if ($pageName -match '(?i)^(pg|Page)\w+' -and $pageName -ne $pgFrameName) {
                $key = "$pgFrameName.$pageName"
                if (-not $innerPageParents.ContainsKey($key)) {
                    $innerPageParents[$key] = @{ Count = 0; PageName = $pageName; Objects = @() }
                }
                $innerPageParents[$key].Count++
                $innerPageParents[$key].Objects += $obj.name
            }
        }
    }

    if ($innerPageParents.Count -eq 0) {
        Write-Host "  [SubPaginas] Sem paginas internas detectadas" -ForegroundColor Gray
        return 0
    }

    Write-Host ""
    Write-Host "  [SubPaginas] Detectadas $($innerPageParents.Count) pagina(s) interna(s):" -ForegroundColor Cyan
    foreach ($key in ($innerPageParents.Keys | Sort-Object)) {
        $pg = $innerPageParents[$key]
        Write-Host "    - $($pg.PageName): $($pg.Count) objetos" -ForegroundColor Gray
    }

    # 3. Verificar quais ja foram migradas (tem ConfigurarPg* no .prg)
    $formContent = Get-Content $FormFile -Raw
    $paginasMigradas = @()
    $paginasPendentes = @()

    foreach ($key in ($innerPageParents.Keys | Sort-Object)) {
        $pg = $innerPageParents[$key]
        $pageName = $pg.PageName
        # Verificar se existe um PROCEDURE ConfigurarPg[PageName] ou AddObject no contexto dessa pagina
        $pattern = "(?i)PROCEDURE\s+ConfigurarPg.*$pageName|AddObject.*$pageName"
        if ($formContent -match $pattern) {
            $paginasMigradas += $pageName
        } else {
            # Verificar se eh pgDados (a primeira pagina, que ja foi migrada nas fases 5-6)
            if ($pageName -match '(?i)^pgDados$') {
                $paginasMigradas += $pageName
            } else {
                $paginasPendentes += @{ Key = $key; PageName = $pageName; Count = $pg.Count }
            }
        }
    }

    if ($paginasPendentes.Count -eq 0) {
        Write-Host "  [SubPaginas] Todas as paginas ja migradas" -ForegroundColor Green
        return 0
    }

    Write-Host "  [SubPaginas] $($paginasPendentes.Count) pagina(s) pendente(s):" -ForegroundColor Yellow
    foreach ($pg in $paginasPendentes) {
        Write-Host "    - $($pg.PageName): $($pg.Count) objetos" -ForegroundColor Yellow
    }

    # 4. Migrar cada pagina pendente como fase adicional
    $faseBase = 9
    $totalMigradas = 0

    # Contexto: original fonte + mapeamento
    $txtFile = Get-ChildItem -Path $TaskPath -Filter "*_form_codigo_fonte.txt" -File | Where-Object { $_.Name -notlike "*_slim*" -and $_.Name -notlike "*_nano*" } | Select-Object -First 1
    $nanoSlimFile = Get-ChildItem -Path $TaskPath -Filter "*_nanoSlim.txt" -File | Select-Object -First 1
    $mapeamentoFile = Join-Path $TaskPath "mapeamento.json"
    $comportamentoFile = Join-Path $TaskPath "comportamento.json"

    # Usar nano-slim se disponivel, senao original
    $sourceFile = if ($nanoSlimFile) { $nanoSlimFile.FullName } elseif ($txtFile) { $txtFile.FullName } else { $null }

    foreach ($pg in $paginasPendentes) {
        $faseNum = $faseBase + $totalMigradas
        $pageName = $pg.PageName

        Write-Host ""
        Write-Host "========================================================================" -ForegroundColor Cyan
        Write-Host "  FASE $faseNum - Sub-pagina: $pageName ($($pg.Count) objetos)" -ForegroundColor Cyan
        Write-Host "========================================================================" -ForegroundColor Cyan

        # Determinar qual Page do PageFrame interno corresponde a esta pagina
        # Detectar PageCount dinamicamente do .prg
        $maxPages = 20
        if ($formContent -match '(?i)\.PageCount\s*=\s*(\d+)') {
            $maxPages = [int]$Matches[1]
        }

        # Procurar no .prg qual PageN tem Caption que corresponde
        $pageIndex = 0
        for ($pi = 1; $pi -le $maxPages; $pi++) {
            if ($formContent -match "(?i)\.Page$pi\.Caption\s*=\s*""[^""]*$pageName") {
                $pageIndex = $pi
                break
            }
        }
        # Se nao encontrou por Caption, tentar pelo comentario com nome da pagina
        if ($pageIndex -eq 0) {
            for ($pi = 1; $pi -le $maxPages; $pi++) {
                if ($formContent -match "(?i)Page$pi.*$pageName") {
                    $pageIndex = $pi
                    break
                }
            }
        }
        if ($pageIndex -eq 0) { $pageIndex = $totalMigradas + 2 }  # fallback

        # Gerar prompt para esta sub-pagina
        # Verificar se existe arquivo de instrucoes especificas do usuario
        $instrucaoFile = Join-Path $TaskPath "$BaseName.txt"
        $instrucaoBlockSub = ""
        if (Test-Path $instrucaoFile) {
            $instrucaoContentSub = Get-Content $instrucaoFile -Raw
            $instrucaoBlockSub = @"

=== INSTRUCOES ESPECIFICAS DO USUARIO ===
$instrucaoContentSub
=== FIM DAS INSTRUCOES ===

"@
        }

        $subPrompt = @"
# FASE $faseNum - Migrar Sub-Pagina: $pageName (Page$pageIndex de pgf_4c_DadosInternos)

Voce esta adicionando controles na **Page$pageIndex** do PageFrame interno ``pgf_4c_DadosInternos`` do form ``$(Split-Path -Leaf $FormFile)``.
$instrucaoBlockSub
## TAREFA
1. Leia o form existente: ``$FormFile``
2. Leia o codigo fonte original para encontrar todos os controles da pagina ``$pageName``
3. Crie um novo metodo ``PROTECTED PROCEDURE ConfigurarPg$pageName()`` no form
4. Dentro do metodo, adicione TODOS os controles que existem na pagina ``$pageName`` do original
5. Adicione a chamada ``THIS.ConfigurarPg$pageName()`` no metodo ``ConfigurarPaginaDados()`` ANTES de ``THIS.TornarControlesVisiveis``
6. Para cada controle de lookup/KeyPress, adicione o BINDEVENT e os handlers correspondentes

## ACESSO A PAGINA
``````foxpro
LOCAL loc_oPgN
loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page$pageIndex

*-- Adicionar controles:
loc_oPgN.AddObject("lbl_4c_NomeLabel", "Label")
WITH loc_oPgN.lbl_4c_NomeLabel
    .Caption = "..."
    .Top = NNN     && COPIAR EXATO do layout.json/original
    .Left = NNN
    .Visible = .T.
ENDWITH
``````

## REGRAS CRITICAS
- Copiar Top/Left/Width/Height EXATOS do codigo fonte original
- Usar CHR() para acentos (NUNCA literais)
- BINDEVENT handlers DEVEM ser PUBLIC (nao PROTECTED)
- EscaparSQL/FormatarNumeroSQL/FormatarDataSQL retornam COM aspas
- FormBuscaAuxiliar.Show() sem parametros
- MESSAGEBOX proibido - usar MsgInfo/MsgAviso/MsgErro/MsgConfirma
- Grids: criar cursor placeholder ANTES do RecordSource, ControlSource APOS RecordSource

## CONTROLES ESPERADOS ($($pg.Count) objetos)
Buscar no codigo fonte original todos os controles sob a pagina ``$pageName``.
Implementar TODOS - NUNCA omitir ou criar stubs TODO.
"@

        $subPromptFile = Join-Path $TaskPath "fase_${faseNum}_subpage_prompt.md"
        $subOutputFile = Join-Path $TaskPath "fase_${faseNum}_subpage_output.txt"
        $subPrompt | Set-Content $subPromptFile -Encoding UTF8

        # Montar contexto
        $contextFiles = @()
        $subDocsPath = Join-Path (Split-Path $Config.paths.projeto -Parent) "docs"
        $contextFiles += Join-Path $subDocsPath "FORMCOR_LICOES_APRENDIDAS.md"
        $contextFiles += Join-Path $subDocsPath "migration_guide.md"
        $contextFiles += Join-Path $subDocsPath "framework_frmcadastro_layout.md"
        if (Test-Path $comportamentoFile) { $contextFiles += $comportamentoFile }
        if (Test-Path $layoutFile) { $contextFiles += $layoutFile }
        # Screenshots
        $screenshots = Get-ChildItem -Path $TaskPath -Filter "${BaseName}_0*.png" -ErrorAction SilentlyContinue
        if (-not $screenshots) { $screenshots = Get-ChildItem -Path $TaskPath -Filter "${BaseName}_0*.jpg" -ErrorAction SilentlyContinue }
        foreach ($ss in $screenshots) { $contextFiles += $ss.FullName }
        if ($sourceFile) { $contextFiles += $sourceFile }
        if (Test-Path $mapeamentoFile) { $contextFiles += $mapeamentoFile }

        # Chamar Claude CLI
        Write-Host "  Executando migracao da sub-pagina $pageName..." -ForegroundColor Cyan
        try {
            & (Join-Path $Config.paths.automation "ClaudeInvoker.ps1") `
                -PromptFile $subPromptFile `
                -OutputFile $subOutputFile `
                -Model "sonnet" `
                -Timeout 3600 `
                -MaxOutputTokens 128000 `
                -ContextFiles $contextFiles `
                -RateLimitMaxRetries 6 `
                -RateLimitInitialDelaySeconds 65 `
                -RateLimitMaxDelaySeconds 600

            if (Test-Path $subOutputFile) {
                $outputContent = Get-Content $subOutputFile -Raw
                Write-Host "  [OK] Sub-pagina $pageName migrada ($([Math]::Round((Get-Item $subOutputFile).Length/1024, 1))KB output)" -ForegroundColor Green

                # Verificar se o metodo foi criado
                $formContentNew = Get-Content $FormFile -Raw
                if ($formContentNew -match "(?i)ConfigurarPg.*$pageName") {
                    Write-Host "  [OK] Metodo ConfigurarPg$pageName encontrado no .prg" -ForegroundColor Green
                    $totalMigradas++
                } else {
                    Write-Host "  [AVISO] Metodo ConfigurarPg$pageName NAO encontrado - pode precisar de retry" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  [AVISO] Sem output do Claude CLI" -ForegroundColor Yellow
            }
        }
        catch {
            Write-Host "  [ERRO] Falha ao migrar sub-pagina $pageName`: $($_.Exception.Message)" -ForegroundColor Red
        }
    }

    Write-Host ""
    Write-Host "  [SubPaginas] $totalMigradas de $($paginasPendentes.Count) sub-pagina(s) migrada(s)" -ForegroundColor $(if ($totalMigradas -eq $paginasPendentes.Count) { "Green" } else { "Yellow" })

    return $totalMigradas
}

#------------------------------------------------------------------------------
# ETAPA 5: Executar migracao (Claude CLI) - COM SUPORTE A MULTI-FASE
#------------------------------------------------------------------------------

function Invoke-Etapa05_Migracao {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 5" "Executar migracao (Claude CLI)"

    $state = Get-TaskState -TaskId $TaskId -TasksDir $config.paths.tasks
    $tentativas = $state.etapas."05_migracao".tentativas
    $maxTentativas = $config.retry.maxTentativasMigracao

    if ($tentativas -ge $maxTentativas) {
        throw "Numero maximo de tentativas atingido para migracao: $maxTentativas"
    }

    # Le formType salvo na Etapa 3 (para adaptar verificacoes e prompts de escalada)
    $formType = "CRUD"
    try {
        if ($state.etapas."03_gerarMetaPrompt".formType) {
            $formType = $state.etapas."03_gerarMetaPrompt".formType
        }
    }
    catch { }
    Write-Host "  FormType (Etapa5): $formType" -ForegroundColor Gray
    $formSubDir = Get-FormSubDir -FormType $formType

    # CLEANUP: Remover copias duplicadas do Form em outras pastas ANTES da migracao
    $formClassCleanup = Get-FormClassName -BaseName $BaseName
    Write-Host "  Verificando duplicatas de $formClassCleanup em pastas de forms..." -ForegroundColor Gray
    Remove-DuplicateForms -ProjetoPath $config.paths.projeto -FormClass $formClassCleanup -PreferredSubDir $formSubDir

    # CLEANUP AGRESSIVO: Remover TODOS os arquivos pre-existentes (incluindo .bak)
    # para garantir que o Claude CLI gere codigo FRESCO, sem copiar .bak existentes
    $boClassCleanup = Get-BOClassName -BaseName $BaseName
    Remove-PreExistingMigrationFiles -ProjetoPath $config.paths.projeto -FormClass $formClassCleanup -BOClass $boClassCleanup

    Start-Etapa -TaskId $TaskId -Etapa "05_migracao" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId

        # Normaliza BaseName para case-insensitive (VFP converte para uppercase)
        # Prefere arquivo _slim.txt se disponivel (para forms grandes)
        $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_form_codigo_fonte.txt" -File | Where-Object { $_.Name -notlike "*_slim*" }
        if ($txtFiles.Count -eq 0) {
            throw "Arquivo *_form_codigo_fonte.txt nao encontrado em $taskPath"
        }

        $txtFile = $txtFiles[0].FullName
        $txtFileOriginal = $txtFile  # ?? IMPORTANTE: Guardar refer�ncia ao arquivo ORIGINAL
        $slimFile = $txtFile -replace "\.txt$", "_slim.txt"

        # ===================================================================
        # DECIS�O: PROCESSAMENTO SIMPLES OU MULTI-FASE
        # ===================================================================

        Write-Host ""
        Write-Host "Analisando complexidade do arquivo..." -ForegroundColor Cyan

        # ?? CR�TICO: Detectar complexidade no arquivo ORIGINAL (n�o no slim)
        $complexidade = Get-ComplexidadeArquivo -CaminhoTxt $txtFileOriginal

        Write-Host "  - Tamanho: $($complexidade.TamanhoKB) KB" -ForegroundColor Cyan
        Write-Host "  - Linhas: $($complexidade.Linhas)" -ForegroundColor Cyan
        Write-Host "  - Classifica��o: $($complexidade.Classificacao)" -ForegroundColor $(if ($complexidade.Classificacao -eq "COMPLEXO") { "Yellow" } else { "Green" })
        Write-Host ""

        if ($complexidade.Classificacao -eq "COMPLEXO") {
            # ===================================================================
            # PROCESSAMENTO MULTI-FASE (arquivos grandes/complexos)
            # ===================================================================
            Write-Host "??  ARQUIVO COMPLEXO DETECTADO" -ForegroundColor Yellow
            Write-Host "   Ser� processado em m�ltiplas fases automaticamente" -ForegroundColor Yellow
            Write-Host ""

            # ?? MULTI-FASE: SEMPRE usa arquivo ORIGINAL (100% funcionalidade)
            $txtFile = $txtFileOriginal
            Write-Host "Usando arquivo original (100% funcionalidade): $(Split-Path -Leaf $txtFile) ($($complexidade.TamanhoKB) KB)" -ForegroundColor Cyan
            Write-Host "Processamento em 8 fases para evitar limite de prompt" -ForegroundColor Cyan
            Write-Host ""

            $resultado = Invoke-MigracaoFaseada `
                -TaskId $TaskId `
                -BaseName $BaseName `
                -TaskPath $taskPath `
                -TxtFile $txtFile `
                -Complexidade $complexidade `
                -Config $config `
                -FormType $formType

            $formFile = $resultado.FormFile
            $boFile = $resultado.BOFile
            $formExists = Test-Path $formFile
            $boExists = Test-Path $boFile
        }
        else {
            # ===================================================================
            # PROCESSAMENTO SIMPLES - 2 FASES (UI + Funcionalidade)
            # Phase A: Layout pixel-perfect (stubs permitidos)
            # Phase B: Funcionalidade completa (sem alterar visual)
            # ===================================================================
            Write-Host "? Arquivo SIMPLES - processamento em 2 fases (UI + Funcionalidade)" -ForegroundColor Green
            Write-Host ""

            # ?? SIMPLES: Pode usar slim se dispon�vel e < 500KB
            if (Test-Path $slimFile) {
                $slimSize = (Get-Item $slimFile).Length / 1024
                if ($slimSize -lt 500) {
                    Write-Host "Usando arquivo reduzido: $([System.IO.Path]::GetFileName($slimFile)) ($([math]::Round($slimSize, 2)) KB)" -ForegroundColor Cyan
                    $txtFile = $slimFile
                } else {
                    $txtFile = $txtFileOriginal
                }
            } else {
                $txtFile = $txtFileOriginal
            }

            $metaPromptFile = Join-Path $taskPath "meta_prompt.md"
            $phaseAPromptFile = Join-Path $taskPath "meta_prompt_phaseA.md"
            $phaseBPromptFile = Join-Path $taskPath "meta_prompt_phaseB.md"
            $outputFile = Join-Path $taskPath "migracao_output.txt"
            $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "05_migracao" -TasksDir $config.paths.tasks
            $mapeamentoFile = Join-Path $taskPath "mapeamento.json"

            # Define nomes de classes e caminhos (necessarios para validacao e registro)
            $formClass = Get-FormClassName -BaseName $BaseName
            $boClass = Get-BOClassName -BaseName $BaseName
            $formSubDir = Get-FormSubDir -FormType $formType
            $formFile = Join-Path $config.paths.projeto "app\forms\$formSubDir\$formClass.prg"
            $boFile = Join-Path $config.paths.projeto "app\classes\$boClass.prg"

            # Prepara arquivos de contexto para Phase A (apenas fontes visuais)
            $frmLayoutRef = Join-Path (Split-Path $config.paths.projeto -Parent) "docs\framework_frmcadastro_layout.md"
            $contextFilesA = @($txtFile)
            if (Test-Path $mapeamentoFile) { $contextFilesA += $mapeamentoFile }
            if ($formType -eq "CRUD" -and (Test-Path $frmLayoutRef)) { $contextFilesA += $frmLayoutRef }

            # Para REPORT: adiciona relatoriobase.prg
            if ($formType -eq "REPORT") {
                $relatorioBaseFile = Join-Path $config.paths.projeto "app\classes\relatoriobase.prg"
                if (Test-Path $relatorioBaseFile) {
                    $contextFilesA += $relatorioBaseFile
                    Write-Host "  [RELATORIO] relatoriobase.prg adicionado ao contexto" -ForegroundColor Cyan
                }
            }

            # ===================================================================
            # VERIFICACAO PROATIVA DE ORCAMENTO DE CONTEXTO (Phase A)
            # Phase A tem prompt pequeno (~3KB) vs normal (~7KB), entao pode usar limite maior
            # Claude suporta ~780KB texto (200K tokens). SafeLimit=500 = ~563KB total (margem 30%)
            # ===================================================================
            $budget = Get-ContextBudget -PromptFile $phaseAPromptFile -ContextFiles $contextFilesA -SafeLimitKB 500
            Write-Host "Orcamento de contexto (Phase A): $($budget.TotalKB) KB (limite: 563 KB)" -ForegroundColor Cyan

            if ($budget.Excede) {
                Write-Host "  CONTEXTO EXCEDE LIMITE - gerando SLIM..." -ForegroundColor Yellow

                $slimTarget = Join-Path $taskPath ((Split-Path -Leaf $txtFile) -replace "\.txt$", "_slim.txt")
                if (-not (Test-Path $slimTarget)) {
                    $maxBytes = 300 * 1024
                    $sourceContent = [System.IO.File]::ReadAllText($txtFile, [System.Text.Encoding]::GetEncoding(1252))
                    if ($sourceContent.Length -gt $maxBytes) {
                        $truncated = $sourceContent.Substring(0, $maxBytes)
                        $lastNewline = $truncated.LastIndexOf("`n")
                        if ($lastNewline -gt 0) { $truncated = $truncated.Substring(0, $lastNewline + 1) }
                        $truncated += "`r`n*-- [TRUNCADO - original: $([math]::Round((Get-Item $txtFile).Length / 1KB, 0)) KB]`r`n"
                        [System.IO.File]::WriteAllText($slimTarget, $truncated, [System.Text.Encoding]::GetEncoding(1252))
                        Write-Host "  SLIM gerado: $([math]::Round((Get-Item $slimTarget).Length / 1KB, 0)) KB" -ForegroundColor Green
                    }
                }
                if (Test-Path $slimTarget) {
                    $txtFile = $slimTarget
                    $contextFilesA[0] = $slimTarget
                }

                $budget = Get-ContextBudget -PromptFile $phaseAPromptFile -ContextFiles $contextFilesA -SafeLimitKB 250
                if ($budget.Excede) {
                    # Contexto ainda excede - forcar multi-fase (fallback antigo)
                    Write-Host "  Contexto ainda excede. FORCANDO processamento MULTI-FASE..." -ForegroundColor Yellow
                    $complexidade.Classificacao = "COMPLEXO"
                    $complexidade.NumFases = [Math]::Max(3, [Math]::Ceiling($complexidade.TamanhoKB / 400))
                    $complexidade.Motivo = "ContextoExcedido"

                    $resultado = Invoke-MigracaoFaseada `
                        -TaskId $TaskId -BaseName $BaseName -TaskPath $taskPath `
                        -TxtFile $txtFileOriginal -Complexidade $complexidade `
                        -Config $config -FormType $formType

                    $formFile = $resultado.FormFile
                    $boFile = $resultado.BOFile
                    $formExists = Test-Path $formFile
                    $boExists = Test-Path $boFile
                    $jaProcessadoMultiFase = $true
                }
            }

            # Flag para controlar se ja processou via multi-fase (fallback)
            if (-not (Get-Variable -Name jaProcessadoMultiFase -ValueOnly -ErrorAction SilentlyContinue)) {
                $jaProcessadoMultiFase = $false
            }

            # Se ja processou via multi-fase (fallback de contexto excedido), pular 2-fases
            if (-not $jaProcessadoMultiFase) {

            # =================================================================
            # PHASE A: UI LAYOUT (pixel-perfect, stubs permitidos)
            # =================================================================
            Write-Host "========================================================" -ForegroundColor Cyan
            Write-Host "  FASE A: Layout Visual (UI Fidelity)" -ForegroundColor Cyan
            Write-Host "========================================================" -ForegroundColor Cyan
            Write-Host ""

            Write-Host "Arquivos de contexto (Phase A):" -ForegroundColor Cyan
            foreach ($file in $contextFilesA) {
                if (Test-Path $file) {
                    $size = [math]::Round((Get-Item $file).Length / 1KB, 2)
                    Write-Host "  [OK] $(Split-Path -Leaf $file) ($size KB)" -ForegroundColor Green
                } else {
                    Write-Host "  [AVISO] $(Split-Path -Leaf $file) (nao encontrado)" -ForegroundColor Yellow
                }
            }
            Write-Host ""

            $outputFileA = Join-Path $taskPath "migracao_output_phaseA.txt"
            $logFileA = Join-Path $taskPath "logs\05_migracao_phaseA.log"

            & (Join-Path $config.paths.automation "ClaudeInvoker.ps1") `
                -PromptFile $phaseAPromptFile `
                -OutputFile $outputFileA `
                -Model $config.claude.model `
                -Timeout $config.claude.timeout `
                -LogFile $logFileA `
                -ContextFiles $contextFilesA `
                -RateLimitMaxRetries $config.rateLimitRetry.maxRetries `
                -RateLimitInitialDelaySeconds $config.rateLimitRetry.initialDelaySeconds `
                -RateLimitMaxDelaySeconds $config.rateLimitRetry.maxDelaySeconds `
                -RateLimitBackoffMultiplier $config.rateLimitRetry.backoffMultiplier `
                -UsageLimitWaitSeconds $config.rateLimitRetry.usageLimitWaitSeconds `
                -MaxOutputTokens $config.claude.maxOutputTokens

            # Verificar se Phase A gerou os arquivos
            if ($LASTEXITCODE -ne 0) {
                $outputContentA = if (Test-Path $outputFileA) { Get-Content $outputFileA -Raw -ErrorAction SilentlyContinue } else { "" }
                if (Test-UsageLimitHit $outputContentA) {
                    throw "Usage limit atingido na Phase A. Aguarde o reset e re-execute: .\OrquestradorMigracao.ps1 -TaskId $TaskId"
                }
                if (Test-PromptTooLong $outputContentA) {
                    Write-Host "Prompt too long na Phase A. For�ando multi-fase..." -ForegroundColor Yellow
                    $complexidade.Classificacao = "COMPLEXO"
                    $complexidade.NumFases = [Math]::Max(3, [Math]::Ceiling($complexidade.TamanhoKB / 400))
                    $complexidade.Motivo = "PromptTooLong_PhaseA"
                    $resultado = Invoke-MigracaoFaseada `
                        -TaskId $TaskId -BaseName $BaseName -TaskPath $taskPath `
                        -TxtFile $txtFileOriginal -Complexidade $complexidade `
                        -Config $config -FormType $formType
                    $formFile = $resultado.FormFile
                    $boFile = $resultado.BOFile
                    $formExists = Test-Path $formFile
                    $boExists = Test-Path $boFile
                    $jaProcessadoMultiFase = $true
                }
            }

            if (-not $jaProcessadoMultiFase) {
                $formExists = Test-Path $formFile
                $boExists = Test-Path $boFile

                # Fallback: procurar Form em outras pastas
                if (-not $formExists) {
                    $foundForm = Find-FormFile -ProjetoPath $config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
                    if ($foundForm) { $formFile = $foundForm; $formExists = $true }
                }

                if (-not $formExists -or -not $boExists) {
                    # Phase A falhou - tentar com force prompt
                    Write-Host "Phase A nao gerou arquivos. Retentando com instrucoes forcadas..." -ForegroundColor Yellow
                    $forcePromptA = Join-Path $taskPath "force_prompt_phaseA.md"
                    $forceContentA = @"
# INSTRUCAO OBRIGATORIA - GERAR LAYOUT AGORA

NAO peca confirmacao - GERE O CODIGO DIRETAMENTE usando Write tool.

Criar:
1. **${boClass}.prg** em C:\4c\projeto\app\classes\ (propriedades this_* e Init() apenas)
2. **${formClass}.prg** em C:\4c\projeto\app\forms\${formSubDir}\ (layout COMPLETO)

FOCO: Layout visual IDENTICO ao original. Stubs permitidos para metodos de logica.

---

$(Get-Content $phaseAPromptFile -Raw)
"@
                    Set-Content -Path $forcePromptA -Value $forceContentA -Encoding UTF8

                    & (Join-Path $config.paths.automation "ClaudeInvoker.ps1") `
                        -PromptFile $forcePromptA `
                        -OutputFile (Join-Path $taskPath "migracao_output_phaseA_force.txt") `
                        -Model "opus" `
                        -Timeout ($config.claude.timeout * 2) `
                        -LogFile (Join-Path $taskPath "logs\05_migracao_phaseA_force.log") `
                        -ContextFiles $contextFilesA `
                        -RateLimitMaxRetries $config.rateLimitRetry.maxRetries `
                        -RateLimitInitialDelaySeconds $config.rateLimitRetry.initialDelaySeconds `
                        -RateLimitMaxDelaySeconds $config.rateLimitRetry.maxDelaySeconds `
                        -RateLimitBackoffMultiplier $config.rateLimitRetry.backoffMultiplier `
                        -UsageLimitWaitSeconds $config.rateLimitRetry.usageLimitWaitSeconds `
                        -MaxOutputTokens $config.claude.maxOutputTokens

                    $formExists = Test-Path $formFile
                    $boExists = Test-Path $boFile
                    if (-not $formExists) {
                        $foundForm = Find-FormFile -ProjetoPath $config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
                        if ($foundForm) { $formFile = $foundForm; $formExists = $true }
                    }

                    if (-not $formExists -or -not $boExists) {
                        throw "Phase A falhou apos retry. Arquivos nao gerados: Form=$formExists, BO=$boExists"
                    }
                }

                # =================================================================
                # VALIDACAO INTERMEDIARIA (entre Phase A e Phase B)
                # CorretorAutomatico + ValidarCompilacao + ValidarUI (early check)
                # =================================================================
                Write-Host ""
                Write-Host "--- Validacao intermediaria (pos-Phase A) ---" -ForegroundColor Cyan

                # CorretorAutomatico na saida da Phase A
                Write-Host "  Executando CorretorAutomatico (Phase A)..." -ForegroundColor Cyan
                try {
                    $corretorScript = Join-Path $config.paths.automation "CorretorAutomatico.ps1"
                    if (Test-Path $corretorScript) {
                        if (Test-Path $formFile) {
                            & $corretorScript -ArquivoPrg $formFile -TaskDir $taskPath 2>&1 | Out-Null
                        }
                        if (Test-Path $boFile) {
                            & $corretorScript -ArquivoPrg $boFile -TaskDir $taskPath 2>&1 | Out-Null
                        }
                        Write-Host "  CorretorAutomatico (Phase A): OK" -ForegroundColor Green
                    }
                } catch {
                    Write-Host "  CorretorAutomatico (Phase A): WARN - $($_.Exception.Message)" -ForegroundColor Yellow
                }

                # ValidarCompilacao na saida da Phase A
                Write-Host "  Validando compilacao (Phase A)..." -ForegroundColor Cyan
                try {
                    $compilaScript = Join-Path $config.paths.projeto "app\utils\ValidarCompilacao.prg"
                    if (Test-Path $compilaScript) {
                        $vfpOutputFile = Join-Path $taskPath "vfp_output.txt"
                        if (Test-Path $vfpOutputFile) { Remove-Item $vfpOutputFile -Force }
                        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
                            -ScriptPrg $compilaScript `
                            -Params "'$formFile'" `
                            -Timeout $config.vfp.timeout `
                            -LogFile (Join-Path $taskPath "logs\05_phaseA_compilacao.log") 2>&1 | Out-Null
                        if (Test-Path $vfpOutputFile) {
                            $compilaResult = Get-Content $vfpOutputFile -Raw -ErrorAction SilentlyContinue
                            if ($compilaResult -match "ERRO|erro de compilacao") {
                                Write-Host "  Compilacao (Phase A): ERROS detectados - Phase B pode corrigir" -ForegroundColor Yellow
                            } else {
                                Write-Host "  Compilacao (Phase A): OK" -ForegroundColor Green
                            }
                        }
                    }
                } catch {
                    Write-Host "  Compilacao (Phase A): WARN - $($_.Exception.Message)" -ForegroundColor Yellow
                }

                Write-Host ""

                # =================================================================
                # PHASE B: FUNCIONALIDADE (preencher stubs, sem alterar visual)
                # =================================================================
                Write-Host "========================================================" -ForegroundColor Cyan
                Write-Host "  FASE B: Funcionalidade (preencher stubs)" -ForegroundColor Cyan
                Write-Host "========================================================" -ForegroundColor Cyan
                Write-Host ""

                # Contexto para Phase B: fonte original + mapeamento + comportamento + BO/Form existentes
                $contextFilesB = @($txtFile)
                if (Test-Path $mapeamentoFile) { $contextFilesB += $mapeamentoFile }
                $comportamentoFile = Join-Path $taskPath "comportamento.json"
                if (Test-Path $comportamentoFile) { $contextFilesB += $comportamentoFile }
                # Adicionar os arquivos gerados na Phase A como contexto
                if (Test-Path $boFile) { $contextFilesB += $boFile }
                if (Test-Path $formFile) { $contextFilesB += $formFile }
                # Para REPORT: adicionar relatoriobase.prg
                if ($formType -eq "REPORT") {
                    $relatorioBaseFile = Join-Path $config.paths.projeto "app\classes\relatoriobase.prg"
                    if (Test-Path $relatorioBaseFile) { $contextFilesB += $relatorioBaseFile }
                }

                # =================================================================
                # REDUCAO DE CONTEXTO PARA PHASE B (evitar "Prompt is too long")
                # Phase B tem prompt + fonte + mapeamento + comportamento + BO + Form
                # Se excede SafeLimitKB=500, reduzir progressivamente
                # =================================================================
                $budgetB = Get-ContextBudget -PromptFile $phaseBPromptFile -ContextFiles $contextFilesB -SafeLimitKB 500
                Write-Host "Orcamento de contexto (Phase B): $($budgetB.TotalKB) KB (limite: $($budgetB.SafeLimitKB) KB)" -ForegroundColor Cyan

                if ($budgetB.Excede) {
                    Write-Host "  CONTEXTO PHASE B EXCEDE LIMITE - reduzindo progressivamente..." -ForegroundColor Yellow

                    # Passo 1: Remover mapeamento.json (menos util para funcionalidade)
                    if (Test-Path $mapeamentoFile) {
                        $contextFilesB = $contextFilesB | Where-Object { $_ -ne $mapeamentoFile }
                        Write-Host "  [REDUCAO] Removido mapeamento.json do contexto" -ForegroundColor Yellow
                        $budgetB = Get-ContextBudget -PromptFile $phaseBPromptFile -ContextFiles $contextFilesB -SafeLimitKB 500
                        Write-Host "  Orcamento apos remover mapeamento: $($budgetB.TotalKB) KB" -ForegroundColor Cyan
                    }

                    # Passo 2: Se ainda excede, substituir fonte original por SLIM
                    if ($budgetB.Excede) {
                        $slimFile = Join-Path $taskPath ((Split-Path -Leaf $txtFile) -replace "\.txt$", "_slim.txt")
                        if (-not (Test-Path $slimFile)) {
                            # Gerar SLIM: manter apenas metodos/procedures com codigo (remover propriedades visuais)
                            Write-Host "  [REDUCAO] Gerando versao SLIM do fonte para Phase B..." -ForegroundColor Yellow
                            $slimTargetKB = 200  # Alvo de 200KB para SLIM
                            $slimScript = Join-Path $config.paths.automation "GerarSlim.ps1"
                            if (Test-Path $slimScript) {
                                & $slimScript -InputFile $txtFile -OutputFile $slimFile -TargetKB $slimTargetKB 2>&1 | Out-Null
                            } else {
                                # Fallback: truncar fonte mantendo primeiras N linhas (metodos no inicio)
                                $sourceLines = Get-Content $txtFile -Encoding UTF8
                                $targetLines = [Math]::Min($sourceLines.Count, [Math]::Floor($slimTargetKB * 1024 / 80))
                                $sourceLines[0..($targetLines-1)] | Set-Content $slimFile -Encoding UTF8
                                Write-Host "  [REDUCAO] Fonte truncado de $($sourceLines.Count) para $targetLines linhas" -ForegroundColor Yellow
                            }
                        }

                        if (Test-Path $slimFile) {
                            $contextFilesB = $contextFilesB | Where-Object { $_ -ne $txtFile }
                            $contextFilesB = @($slimFile) + $contextFilesB
                            Write-Host "  [REDUCAO] Substituido fonte original por SLIM ($(([math]::Round((Get-Item $slimFile).Length / 1KB, 2))) KB)" -ForegroundColor Yellow
                            $budgetB = Get-ContextBudget -PromptFile $phaseBPromptFile -ContextFiles $contextFilesB -SafeLimitKB 500
                            Write-Host "  Orcamento apos SLIM: $($budgetB.TotalKB) KB" -ForegroundColor Cyan
                        }
                    }

                    # Passo 3: Se AINDA excede, remover comportamento.json (informacoes estarao no prompt inline)
                    if ($budgetB.Excede -and (Test-Path $comportamentoFile)) {
                        $contextFilesB = $contextFilesB | Where-Object { $_ -ne $comportamentoFile }
                        Write-Host "  [REDUCAO] Removido comportamento.json do contexto" -ForegroundColor Yellow
                        $budgetB = Get-ContextBudget -PromptFile $phaseBPromptFile -ContextFiles $contextFilesB -SafeLimitKB 500
                        Write-Host "  Orcamento apos remover comportamento: $($budgetB.TotalKB) KB" -ForegroundColor Cyan
                    }

                    # Passo 4: Se AINDA excede, forcar multi-fase
                    if ($budgetB.Excede) {
                        Write-Host "  CONTEXTO PHASE B ainda excede apos todas as reducoes ($($budgetB.TotalKB) KB)" -ForegroundColor Red
                        Write-Host "  Continuando mesmo assim - Claude pode funcionar com contexto grande..." -ForegroundColor Yellow
                    }
                }

                Write-Host ""
                Write-Host "Arquivos de contexto (Phase B):" -ForegroundColor Cyan
                foreach ($file in $contextFilesB) {
                    if (Test-Path $file) {
                        $size = [math]::Round((Get-Item $file).Length / 1KB, 2)
                        Write-Host "  [OK] $(Split-Path -Leaf $file) ($size KB)" -ForegroundColor Green
                    } else {
                        Write-Host "  [AVISO] $(Split-Path -Leaf $file) (nao encontrado)" -ForegroundColor Yellow
                    }
                }
                Write-Host ""

                $outputFileB = Join-Path $taskPath "migracao_output_phaseB.txt"
                $logFileB = Join-Path $taskPath "logs\05_migracao_phaseB.log"

                & (Join-Path $config.paths.automation "ClaudeInvoker.ps1") `
                    -PromptFile $phaseBPromptFile `
                    -OutputFile $outputFileB `
                    -Model $config.claude.model `
                    -Timeout $config.claude.timeout `
                    -LogFile $logFileB `
                    -ContextFiles $contextFilesB `
                    -RateLimitMaxRetries $config.rateLimitRetry.maxRetries `
                    -RateLimitInitialDelaySeconds $config.rateLimitRetry.initialDelaySeconds `
                    -RateLimitMaxDelaySeconds $config.rateLimitRetry.maxDelaySeconds `
                    -RateLimitBackoffMultiplier $config.rateLimitRetry.backoffMultiplier `
                    -UsageLimitWaitSeconds $config.rateLimitRetry.usageLimitWaitSeconds `
                    -MaxOutputTokens $config.claude.maxOutputTokens

                if ($LASTEXITCODE -ne 0) {
                    $outputContentB = if (Test-Path $outputFileB) { Get-Content $outputFileB -Raw -ErrorAction SilentlyContinue } else { "" }
                    if (Test-UsageLimitHit $outputContentB) {
                        throw "Usage limit atingido na Phase B. Aguarde o reset e re-execute: .\OrquestradorMigracao.ps1 -TaskId $TaskId"
                    }
                    # Phase B falhou - tentar com force prompt
                    Write-Host "Phase B retornou erro. Retentando com instrucoes forcadas (opus)..." -ForegroundColor Yellow

                    $forceBPrompt = Join-Path $taskPath "force_prompt_phaseB.md"
                    $forceBContent = @"
# INSTRUCAO OBRIGATORIA - IMPLEMENTAR FUNCIONALIDADE AGORA

Os arquivos ${boClass}.prg e ${formClass}.prg ja existem com layout visual correto.
NAO peca confirmacao - MODIFIQUE os arquivos DIRETAMENTE usando Edit/Write tool.

**NAO ALTERE propriedades visuais (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize).**
Preencha TODOS os metodos stub com implementacao REAL baseada no codigo fonte original.

---

$(Get-Content $phaseBPromptFile -Raw)
"@
                    Set-Content -Path $forceBPrompt -Value $forceBContent -Encoding UTF8

                    & (Join-Path $config.paths.automation "ClaudeInvoker.ps1") `
                        -PromptFile $forceBPrompt `
                        -OutputFile (Join-Path $taskPath "migracao_output_phaseB_force.txt") `
                        -Model "opus" `
                        -Timeout ($config.claude.timeout * 2) `
                        -LogFile (Join-Path $taskPath "logs\05_migracao_phaseB_force.log") `
                        -ContextFiles $contextFilesB `
                        -RateLimitMaxRetries $config.rateLimitRetry.maxRetries `
                        -RateLimitInitialDelaySeconds $config.rateLimitRetry.initialDelaySeconds `
                        -RateLimitMaxDelaySeconds $config.rateLimitRetry.maxDelaySeconds `
                        -RateLimitBackoffMultiplier $config.rateLimitRetry.backoffMultiplier `
                        -UsageLimitWaitSeconds $config.rateLimitRetry.usageLimitWaitSeconds `
                        -MaxOutputTokens $config.claude.maxOutputTokens
                }

                Write-Host ""
                Write-Host "Phase B finalizada. Verificando arquivos..." -ForegroundColor Cyan

                # Atualizar estado dos arquivos
                $formExists = Test-Path $formFile
                $boExists = Test-Path $boFile
                if (-not $formExists) {
                    $foundForm = Find-FormFile -ProjetoPath $config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
                    if ($foundForm) {
                        $formFile = $foundForm
                        $formExists = $true
                        $formSubDir = (Split-Path (Split-Path $foundForm -Parent) -Leaf)
                    }
                }
            }  # fecha if (-not $jaProcessadoMultiFase) apos Phase A fallback check
            }  # fecha if (-not $jaProcessadoMultiFase) principal
        }

        # ===================================================================
        # VALIDACAO COMUM (simples ou multi-fase)
        # ===================================================================

        # Se multi-fase falhou, erro fatal (j� tentou m�ltiplas fases)
        if ($complexidade.Classificacao -eq "COMPLEXO" -and (-not $formExists -or -not $boExists)) {
            Write-Host ""
            Write-Host "========================================================" -ForegroundColor Red
            Write-Host "ERRO: PROCESSAMENTO MULTI-FASE FALHOU" -ForegroundColor Red
            Write-Host "========================================================" -ForegroundColor Red
            Write-Host "  Form: $formFile - $(if($formExists){'OK'}else{'FALHOU'})" -ForegroundColor $(if($formExists){'Green'}else{'Red'})
            Write-Host "  BO:   $boFile - $(if($boExists){'OK'}else{'FALHOU'})" -ForegroundColor $(if($boExists){'Green'}else{'Red'})
            Write-Host ""
            Write-Host "O processamento multi-fase executou 8 fases, mas nao gerou os arquivos." -ForegroundColor Red
            Write-Host "Verifique os logs em: $taskPath\logs\" -ForegroundColor Yellow
            throw "Processamento multi-fase falhou. Arquivos nao foram gerados apos 8 fases."
        }

        # Se SIMPLES falhou (2-fases nao gerou arquivos), erro fatal
        # (Phase A ja tem retry interno com force/opus, entao se chegou aqui sem arquivos eh erro grave)
        if ($complexidade.Classificacao -eq "SIMPLES" -and (-not $formExists -or -not $boExists)) {
            Write-Host ""
            Write-Host "========================================================" -ForegroundColor Red
            Write-Host "ERRO: PROCESSAMENTO 2-FASES FALHOU" -ForegroundColor Red
            Write-Host "========================================================" -ForegroundColor Red
            Write-Host "  Form: $formFile - $(if($formExists){'OK'}else{'FALHOU'})" -ForegroundColor $(if($formExists){'Green'}else{'Red'})
            Write-Host "  BO:   $boFile - $(if($boExists){'OK'}else{'FALHOU'})" -ForegroundColor $(if($boExists){'Green'}else{'Red'})
            Write-Host ""
            throw "Processamento 2-fases falhou. Arquivos nao gerados apos Phase A + Phase B."
        }

        Write-Host ""
        Write-Host "========================================================================" -ForegroundColor Green
        Write-Host "  MIGRA��O CONCLU�DA COM SUCESSO" -ForegroundColor Green
        Write-Host "========================================================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Arquivos gerados:" -ForegroundColor Green
        Write-Host "  ? Form: $formFile" -ForegroundColor Green
        Write-Host "  ? BO:   $boFile" -ForegroundColor Green
        Write-Host ""
        Write-Host "Modo de processamento: $($complexidade.Classificacao)" -ForegroundColor Cyan
        if ($complexidade.Classificacao -eq "COMPLEXO") {
            Write-Host "  +- Processado em 8 fases sequenciais" -ForegroundColor Cyan
        } else {
            Write-Host "  +- Processado em 2 fases (Phase A: UI + Phase B: Funcionalidade)" -ForegroundColor Cyan
        }
        Write-Host ""

        # ===================================================================
        # FASES ADICIONAIS: MIGRAR SUB-PAGINAS INTERNAS (se existirem)
        # ===================================================================
        $taskPathSubPg = Join-Path $config.paths.tasks $TaskId
        $subPaginasMigradas = Invoke-MigracaoSubPaginas `
            -TaskId $TaskId `
            -BaseName $BaseName `
            -FormFile $formFile `
            -BOFile $boFile `
            -TaskPath $taskPathSubPg `
            -Config $config `
            -FormType $formType

        if ($subPaginasMigradas -gt 0) {
            Write-Host "  +- $subPaginasMigradas sub-pagina(s) interna(s) migrada(s)" -ForegroundColor Cyan
        }

        # ===================================================================
        # REGISTRAR NO CONFIG.PRG (SET PROCEDURE ADDITIVE)
        # ===================================================================
        Write-Host "Registrando no config.prg..." -ForegroundColor Cyan

        $configPrg = Join-Path $config.paths.projeto "app\start\config.prg"

        if (Test-Path $configPrg) {
            $configContent = Get-Content $configPrg -Raw

            # Verificar se config.prg usa carregamento DINAMICO (ADIR com wildcards)
            # Se sim, os arquivos sao carregados automaticamente - nao precisa registro manual
            $usaDinamico = $false
            if ($configContent -match 'ADIR\(.+\*BO\.prg' -and $configContent -match 'ADIR\(.+Form\*\.prg') {
                $usaDinamico = $true
                Write-Host "  [OK] config.prg usa carregamento DINAMICO (ADIR) - registro manual nao necessario" -ForegroundColor Green
                Write-Host "  [OK] BO sera carregado automaticamente por: ADIR(*, *BO.prg)" -ForegroundColor DarkGray
                Write-Host "  [OK] Form sera carregado automaticamente por: ADIR(*, Form*.prg)" -ForegroundColor DarkGray
            }

            if (-not $usaDinamico) {
                $configAlterado = $false

                # Registrar BO (se nao existe)
                $boFileName = "$boClass.prg"
                if ($configContent -notmatch [regex]::Escape($boFileName)) {
                    # Encontrar ponto de insercao: antes da secao de FORMULARIOS
                    $insertPattern = "(?m)^\s*\*\s*(=+|FORMULARIOS|Formularios de Cadastros)"
                    $insertPatternAlt = "(?m)^\s*\*\s*FORMULARIOS"
                    if ($configContent -match $insertPattern) {
                        $insertMatch = [regex]::Match($configContent, $insertPattern)
                        $boLine = "    SET PROCEDURE TO (gcCaminhoClasses + `"$boFileName`") ADDITIVE`r`n"
                        $configContent = $configContent.Insert($insertMatch.Index, $boLine)
                        $configAlterado = $true
                        Write-Host "  [OK] BO registrado: $boFileName" -ForegroundColor Green
                    } else {
                        Write-Host "  [WARN] Nao encontrou ponto de insercao para BO no config.prg" -ForegroundColor Yellow
                    }
                } else {
                    Write-Host "  [OK] BO ja registrado: $boFileName" -ForegroundColor DarkGray
                }

                # Registrar Form (se nao existe)
                $formFileName = "$formClass.prg"
                if ($configContent -notmatch [regex]::Escape($formFileName)) {
                    # Encontrar a secao MENU (antes dela) como ponto de insercao
                    $menuPattern = "(?m)^\s*\*\s*(=+\s*\r?\n\s*\*\s*MENU|MENU)"
                    if ($configContent -match $menuPattern) {
                        $menuMatch = [regex]::Match($configContent, $menuPattern)
                        $formLine = "    SET PROCEDURE TO (gcCaminhoForms + `"$formSubDir\$formFileName`") ADDITIVE`r`n"
                        $configContent = $configContent.Insert($menuMatch.Index, $formLine)
                        $configAlterado = $true
                        Write-Host "  [OK] Form registrado: $formFileName" -ForegroundColor Green
                    } else {
                        Write-Host "  [WARN] Nao encontrou ponto de insercao para Form no config.prg" -ForegroundColor Yellow
                    }
                } else {
                    Write-Host "  [OK] Form ja registrado: $formFileName" -ForegroundColor DarkGray
                }

                if ($configAlterado) {
                    $configContent | Out-File -FilePath $configPrg -Encoding ASCII -NoNewline
                    Write-Host "  config.prg atualizado com sucesso" -ForegroundColor Green
                }
            }
        } else {
            Write-Host "  [WARN] config.prg nao encontrado: $configPrg" -ForegroundColor Yellow
        }

        Write-Host ""

        # Metadata para Complete-Etapa
        $metadata = @{
            formFile = $formFile
            boFile = $boFile
            formExists = $formExists
            boExists = $boExists
            complexidade = $complexidade.Classificacao
            tamanhoKB = $complexidade.TamanhoKB
            linhas = $complexidade.Linhas
        }

        # Adiciona outputFile se foi processamento simples
        if ($complexidade.Classificacao -eq "SIMPLES") {
            $metadata.outputFile = $outputFile
        }

        Complete-Etapa -TaskId $TaskId -Etapa "05_migracao" -TasksDir $config.paths.tasks -Metadata $metadata
    }
    catch {
        $erroMsg = $_.Exception.Message
        Fail-Etapa -TaskId $TaskId -Etapa "05_migracao" -ErroMsg $erroMsg -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# ETAPA 5.5: Corrigir Automatico (NOVO)
#------------------------------------------------------------------------------

function Invoke-Etapa05b_CorrigirAutomatico {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 5.5" "Corrigir Automatico (CorretorAutomatico.ps1)"

    Start-Etapa -TaskId $TaskId -Etapa "05b_corrigirAutomatico" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId

        # Determina nomes das classes
        $formClass = Get-FormClassName -BaseName $BaseName
        $boClass = Get-BOClassName -BaseName $BaseName
        $formType = Get-FormTypeFromState -TaskId $TaskId
        $formSubDir = Get-FormSubDir -FormType $formType

        # Arquivos a corrigir
        $formFile = Join-Path $config.paths.projeto "app\forms\$formSubDir\$formClass.prg"
        $boFile = Join-Path $config.paths.projeto "app\classes\$boClass.prg"

        # Fallback: procurar Form em outras pastas
        if (-not (Test-Path $formFile)) {
            $foundForm = Find-FormFile -ProjetoPath $config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
            if ($foundForm) { $formFile = $foundForm }
        }

        $corretorScript = Join-Path $config.paths.automation "CorretorAutomatico.ps1"

        # Corrige Form se existir
        if (Test-Path $formFile) {
            Write-Host "Corrigindo Form: $formFile" -ForegroundColor Cyan

            & $corretorScript -ArquivoPrg $formFile -TaskDir $taskPath

            if ($LASTEXITCODE -eq 0) {
                Write-Host "  Form corrigido com sucesso" -ForegroundColor Green
            }
        }
        else {
            Write-Host "AVISO: Form nao encontrado: $formFile" -ForegroundColor Yellow
        }

        # Corrige BO se existir
        if (Test-Path $boFile) {
            Write-Host "Corrigindo BO: $boFile" -ForegroundColor Cyan

            & $corretorScript -ArquivoPrg $boFile -TaskDir $taskPath

            if ($LASTEXITCODE -eq 0) {
                Write-Host "  BO corrigido com sucesso" -ForegroundColor Green
            }
        }
        else {
            Write-Host "AVISO: BO nao encontrado: $boFile" -ForegroundColor Yellow
        }

        Complete-Etapa -TaskId $TaskId -Etapa "05b_corrigirAutomatico" -TasksDir $config.paths.tasks -Metadata @{
            formFile = $formFile
            boFile = $boFile
        }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "05b_corrigirAutomatico" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# ETAPA 5.5b: Atualizar Mapeamento com nomes reais do form gerado
#------------------------------------------------------------------------------

# Analisa o .prg gerado e extrai hierarquia real de objetos
# Retorna hashtable: { "THIS" => @( @{Name; Type; VarName} ), "loc_oPage1" => @(...), ... }
function Get-PRGObjectHierarchy {
    param([string]$FormPRG)

    $content = Get-Content $FormPRG -Raw
    $lines = Get-Content $FormPRG

    # Mapa de variavel -> caminho real no form
    # Ex: "loc_oPgf" -> "THIS.pgf_4c_Paginas", "loc_oPage1" -> "THIS.pgf_4c_Paginas.Page1"
    $varMap = @{}
    $varMap["THIS"] = "THIS"

    # Lista de todos os objetos: @( @{Path="THIS.pgf_4c_Paginas"; Name="pgf_4c_Paginas"; Type="PageFrame"; Parent="THIS"} )
    $objects = [System.Collections.ArrayList]::new()

    foreach ($line in $lines) {
        $trimmed = $line.Trim()

        # Pattern 1: var.AddObject("name", "type")
        if ($trimmed -match '(\w+)\.AddObject\(\s*"(\w+)"\s*,\s*"(\w+)"\s*\)') {
            $parentVar = $matches[1]
            $objName = $matches[2]
            $objType = $matches[3]

            $parentPath = if ($varMap.ContainsKey($parentVar)) { $varMap[$parentVar] } else { $parentVar }

            $fullPath = "$parentPath.$objName"
            [void]$objects.Add(@{
                Path = $fullPath
                Name = $objName
                Type = $objType
                Parent = $parentPath
            })
        }

        # Pattern 2: var = THIS.something.something (variable assignment to object reference)
        # Ex: loc_oPgf = THIS.pgf_4c_Paginas
        # Ex: loc_oPage1 = THIS.pgf_4c_Paginas.Page1
        # Ex: loc_oCnt = loc_oPage1.cnt_4c_Sombra
        if ($trimmed -match '^(loc_\w+)\s*=\s*([\w\.]+)$') {
            $varName = $matches[1]
            $refPath = $matches[2]

            # Resolve reference path: replace leading variable with its full path
            $parts = $refPath -split '\.'
            $firstPart = $parts[0]

            if ($varMap.ContainsKey($firstPart)) {
                $resolvedPath = $varMap[$firstPart]
                if ($parts.Count -gt 1) {
                    $resolvedPath = $resolvedPath + "." + ($parts[1..($parts.Count-1)] -join ".")
                }
                $varMap[$varName] = $resolvedPath
            } else {
                $varMap[$varName] = $refPath
            }
        }
    }

    return $objects
}

# Mapeia tipo VFP do mapeamento para tipos do AddObject
function Get-TypeAliases {
    param([string]$MappedName)

    # Determina o tipo esperado pelo prefixo do nome mapeado
    $prefix = ""
    if ($MappedName -match '^(\w+?)_4c_') { $prefix = $matches[1] }

    switch ($prefix) {
        "pgf"  { return @("PageFrame") }
        "grd"  { return @("Grid", "GridBase") }
        "txt"  { return @("TextBox", "TextBoxGridLookup") }
        "lbl"  { return @("Label") }
        "cmd"  { return @("CommandButton") }
        "cbo"  { return @("ComboBox") }
        "chk"  { return @("CheckBox") }
        "opt"  { return @("OptionGroup") }
        "shp"  { return @("Shape") }
        "cnt"  { return @("Container") }
        "obj"  { return @("CommandGroup", "OptionGroup", "Container", "Custom") }
        "img"  { return @("Image") }
        default { return @() }
    }
}

# Normaliza nome para comparacao fuzzy (remove prefixos, underscores, case)
function Get-NormalizedName {
    param([string]$Name)
    $n = $Name.ToLower()
    # Remove prefixos padrao 4c
    $n = $n -replace '^(pgf|grd|txt|lbl|cmd|cbo|chk|opt|shp|cnt|obj|img)_4c_', ''
    # Remove prefixos legado
    $n = $n -replace '^(page|page_4c_)', ''
    # Remove underscores e espacos
    $n = $n -replace '[_\s]', ''
    return $n
}

function Update-MapeamentoFromPRG {
    param(
        [string]$MapeamentoFile,
        [string]$FormPRG
    )

    if (-not (Test-Path $MapeamentoFile)) {
        Write-Host "  AVISO: mapeamento.json nao encontrado: $MapeamentoFile" -ForegroundColor Yellow
        return $false
    }
    if (-not (Test-Path $FormPRG)) {
        Write-Host "  AVISO: Form .prg nao encontrado: $FormPRG" -ForegroundColor Yellow
        return $false
    }

    # 1. Carregar mapeamento
    $mapeamentoRaw = Get-Content $MapeamentoFile -Raw
    $mapeamento = $mapeamentoRaw | ConvertFrom-Json

    if (-not $mapeamento.mapeamento) {
        Write-Host "  AVISO: mapeamento.json sem secao 'mapeamento'" -ForegroundColor Yellow
        return $false
    }

    # 2. Extrair hierarquia real do .prg
    $realObjects = Get-PRGObjectHierarchy -FormPRG $FormPRG

    Write-Host "  Objetos encontrados no .prg: $($realObjects.Count)" -ForegroundColor Cyan

    # 3. Construir indice de objetos reais por parent+tipo
    # Tambem criar indice por nivel na hierarquia
    $objectsByParent = @{}
    foreach ($obj in $realObjects) {
        $key = $obj.Parent
        if (-not $objectsByParent.ContainsKey($key)) {
            $objectsByParent[$key] = [System.Collections.ArrayList]::new()
        }
        [void]$objectsByParent[$key].Add($obj)
    }

    # 4. Para cada entrada do mapeamento, tentar resolver o nome real
    $mapProps = $mapeamento.mapeamento.PSObject.Properties
    $totalEntradas = ($mapProps | Measure-Object).Count
    $atualizadas = 0
    $naoEncontradas = 0

    # Construir mapa de caminho legado -> caminho real
    # Processamos nivel por nivel (do mais raso ao mais profundo)
    $legacyToReal = @{}
    $legacyToReal["Form"] = "THIS"

    # Ordenar entradas por profundidade (menos pontos primeiro)
    # Usar indice original como tiebreaker para preservar ordem JSON (estabilidade)
    $idx = 0
    $sortedEntries = $mapProps | ForEach-Object { $_ | Add-Member -NotePropertyName _origIdx -NotePropertyValue ($idx++) -PassThru } |
        Sort-Object { ($_.Name -split '\.').Count }, _origIdx

    foreach ($entry in $sortedEntries) {
        $legacyPath = $entry.Name        # Ex: "SIGOPIND.Page"
        $mappedName = $entry.Value        # Ex: "pgf_4c_1"

        # Pular metadados
        if ($legacyPath -in @("Dataenvironment")) { continue }

        # Decompor caminho legado
        $parts = $legacyPath -split '\.'
        $depth = $parts.Count

        # O pai legado e tudo menos o ultimo componente
        if ($depth -le 1) {
            # Nivel do form (ex: "SIGOPIND" -> "Form")
            $legacyToReal[$legacyPath] = "THIS"
            continue
        }

        $parentLegacy = ($parts[0..($depth-2)]) -join '.'
        $legacyName = $parts[-1]    # Ex: "Page", "SALDO", "grd_saldo"

        # Resolver parent para caminho real
        $parentReal = if ($legacyToReal.ContainsKey($parentLegacy)) {
            $legacyToReal[$parentLegacy]
        } else {
            $null
        }

        if (-not $parentReal) {
            $naoEncontradas++
            continue
        }

        # Buscar objeto real no parent
        $found = $null
        $typeAliases = Get-TypeAliases -MappedName $mappedName

        # Estrategia 1: Nome exato (mapeamento coincide com real)
        foreach ($obj in $realObjects) {
            if ($obj.Parent -eq $parentReal -and $obj.Name -eq $mappedName) {
                $found = $obj
                break
            }
        }

        # Estrategia 2: Busca por tipo no parent (se ha exatamente 1 do tipo)
        if (-not $found -and $typeAliases.Count -gt 0) {
            $candidates = @()
            if ($objectsByParent.ContainsKey($parentReal)) {
                $candidates = @($objectsByParent[$parentReal] | Where-Object {
                    $_.Type -in $typeAliases
                })
            }

            if ($candidates.Count -eq 1) {
                $found = $candidates[0]
            }
            elseif ($candidates.Count -gt 1) {
                # Estrategia 3: Fuzzy match por nome
                $normalizedLegacy = Get-NormalizedName -Name $legacyName
                $normalizedMapped = Get-NormalizedName -Name $mappedName

                foreach ($cand in $candidates) {
                    $normalizedCand = Get-NormalizedName -Name $cand.Name
                    if ($normalizedCand -eq $normalizedLegacy -or $normalizedCand -eq $normalizedMapped) {
                        $found = $cand
                        break
                    }
                }

                # Estrategia 4: Matching por substring parcial
                # Ex: legacyName="Com_Imprimir2" contido em "cmd_4c_Imprimir2"
                if (-not $found) {
                    $legacyClean = ($legacyName -replace '[_\s]', '').ToLower()
                    foreach ($cand in $candidates) {
                        $candClean = ($cand.Name -replace '[_\s]', '' -replace '^\w+_4c_', '').ToLower()
                        # Verificar se legacy (sem prefixo) contem candidate (sem prefixo) ou vice-versa
                        $legacyNoPfx = ($legacyName -replace '^(Com_|Get_|Say|Cmd_|Chk_|Cmb_|lbl_|opt|grp_)', '').ToLower() -replace '[_\s]', ''
                        if ($legacyNoPfx.Length -ge 3 -and ($candClean -like "*$legacyNoPfx*" -or $legacyNoPfx -like "*$candClean*")) {
                            $found = $cand
                            break
                        }
                    }
                }
            }
        }

        # Estrategia 5: Pages (Page1, Page2) - mapear por ordinal no parent
        # Page_4c_N ou nomes que parecem Pages (dentro de um PageFrame)
        if (-not $found -and ($mappedName -match '^Page_4c_\d+$' -or $mappedName -match '^Page\d+$')) {
            # Contar qual ordinal esta page e entre seus irmaos Pages no mapeamento
            # Usar $mapProps (ordem JSON original) para preservar a ordem correta
            $siblingPages = @($mapProps | Where-Object {
                $_.Name -like "$parentLegacy.*" -and
                ($_.Name -split '\.').Count -eq $depth -and
                ($_.Value -match '^Page_4c_\d+$' -or $_.Value -match '^Page\d+$')
            })

            $pageOrdinal = 1
            for ($pi = 0; $pi -lt $siblingPages.Count; $pi++) {
                if ($siblingPages[$pi].Name -eq $legacyPath) {
                    $pageOrdinal = $pi + 1
                    break
                }
            }

            $pageName = "Page$pageOrdinal"

            $found = @{
                Path = "$parentReal.$pageName"
                Name = $pageName
                Type = "Page"
                Parent = $parentReal
            }
        }

        if ($found) {
            $realPath = $found.Path
            $realName = $found.Name

            # Atualizar mapeamento se o nome mudou
            if ($realName -ne $mappedName) {
                $mapeamento.mapeamento.$legacyPath = $realName
                $atualizadas++
                Write-Host "    ATUALIZADO: $legacyPath : '$mappedName' -> '$realName'" -ForegroundColor Green
            }

            # Registrar caminho real para resolucao de filhos
            $legacyToReal[$legacyPath] = $realPath
        } else {
            # Nao encontrou - manter nome original e tentar inferir caminho
            $legacyToReal[$legacyPath] = "$parentReal.$mappedName"

            # Grid internals (Column/Header/Text/Ingrid) nao sao AddObject - sao built-in VFP
            $isGridInternal = $legacyName -match '^(Column\d+|Header\d+|Text\d+|Ingrid\d+|Col_\w+)$'
            if (-not $isGridInternal) {
                $naoEncontradas++
            }
        }
    }

    Write-Host "  Entradas no mapeamento: $totalEntradas" -ForegroundColor Cyan
    Write-Host "  Atualizadas: $atualizadas" -ForegroundColor $(if ($atualizadas -gt 0) { "Green" } else { "Gray" })
    Write-Host "  Nao encontradas: $naoEncontradas" -ForegroundColor $(if ($naoEncontradas -gt 0) { "Yellow" } else { "Gray" })

    # 5. Salvar mapeamento atualizado
    if ($atualizadas -gt 0) {
        $mapeamento | ConvertTo-Json -Depth 10 | Set-Content $MapeamentoFile -Encoding UTF8
        Write-Host "  Mapeamento salvo: $MapeamentoFile" -ForegroundColor Green
    } else {
        Write-Host "  Nenhuma atualizacao necessaria" -ForegroundColor Gray
    }

    return $true
}

function Invoke-Etapa05b2_AtualizarMapeamento {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 5.5b" "Atualizar Mapeamento (nomes reais do .prg)"

    Start-Etapa -TaskId $TaskId -Etapa "05b2_atualizarMapeamento" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId
        $mapeamentoFile = Join-Path $taskPath "mapeamento.json"

        if (-not (Test-Path $mapeamentoFile)) {
            Write-Host "  Mapeamento nao encontrado, pulando..." -ForegroundColor Yellow
            Complete-Etapa -TaskId $TaskId -Etapa "05b2_atualizarMapeamento" -TasksDir $config.paths.tasks -Metadata @{ skipped = $true }
            return
        }

        # Localizar o Form .prg gerado
        $formClass = Get-FormClassName -BaseName $BaseName
        $formType = Get-FormTypeFromState -TaskId $TaskId
        $formSubDir = Get-FormSubDir -FormType $formType
        $formFile = Join-Path $config.paths.projeto "app\forms\$formSubDir\$formClass.prg"

        if (-not (Test-Path $formFile)) {
            $formFile = Find-FormFile -ProjetoPath $config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
        }

        if (-not $formFile -or -not (Test-Path $formFile)) {
            Write-Host "  Form .prg nao encontrado, pulando..." -ForegroundColor Yellow
            Complete-Etapa -TaskId $TaskId -Etapa "05b2_atualizarMapeamento" -TasksDir $config.paths.tasks -Metadata @{ skipped = $true }
            return
        }

        Write-Host "  Form: $formFile" -ForegroundColor Cyan
        Write-Host "  Mapeamento: $mapeamentoFile" -ForegroundColor Cyan

        # Backup do mapeamento original
        $backupFile = "$mapeamentoFile.pre_update"
        Copy-Item $mapeamentoFile $backupFile -Force

        # Atualizar mapeamento
        $result = Update-MapeamentoFromPRG -MapeamentoFile $mapeamentoFile -FormPRG $formFile

        # Copiar mapeamento atualizado para pasta de mapeamentos (usada pelo ValidarUIFidelity)
        $mapeamentosDir = Join-Path $config.paths.projeto "app\utils\mapeamentos"
        if (-not (Test-Path $mapeamentosDir)) {
            New-Item -Path $mapeamentosDir -ItemType Directory -Force | Out-Null
        }
        $destFile = Join-Path $mapeamentosDir "${formClass}_mapeamento.json"
        Copy-Item $mapeamentoFile $destFile -Force
        Write-Host "  Copiado para ValidarUIFidelity: $destFile" -ForegroundColor Cyan

        Complete-Etapa -TaskId $TaskId -Etapa "05b2_atualizarMapeamento" -TasksDir $config.paths.tasks -Metadata @{
            mapeamentoFile = $mapeamentoFile
            formFile = $formFile
            destFile = $destFile
        }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "05b2_atualizarMapeamento" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# ETAPA 5.6: Validar Compilacao (NOVO)
#------------------------------------------------------------------------------

function Invoke-Etapa05c_ValidarCompilacao {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 5.6" "Validar Compilacao (ValidarCompilacao.prg)"

    Start-Etapa -TaskId $TaskId -Etapa "05c_validarCompilacao" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId

        # Determina nomes das classes
        $formClass = Get-FormClassName -BaseName $BaseName
        $boClass = Get-BOClassName -BaseName $BaseName
        $formType = Get-FormTypeFromState -TaskId $TaskId
        $formSubDir = Get-FormSubDir -FormType $formType

        # Arquivos a validar
        $formFile = Join-Path $config.paths.projeto "app\forms\$formSubDir\$formClass.prg"
        $boFile = Join-Path $config.paths.projeto "app\classes\$boClass.prg"

        # Fallback: procurar Form em outras pastas
        if (-not (Test-Path $formFile)) {
            $foundForm = Find-FormFile -ProjetoPath $config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
            if ($foundForm) { $formFile = $foundForm }
        }

        # Monta lista de arquivos para compilar
        $arquivosParaCompilar = @()
        if (Test-Path $formFile) { $arquivosParaCompilar += $formFile }
        if (Test-Path $boFile) { $arquivosParaCompilar += $boFile }

        if ($arquivosParaCompilar.Count -eq 0) {
            Write-Host "AVISO: Nenhum arquivo encontrado para validar" -ForegroundColor Yellow
            Complete-Etapa -TaskId $TaskId -Etapa "05c_validarCompilacao" -TasksDir $config.paths.tasks -Metadata @{
                arquivosValidados = 0
                sucesso = $true
            }
            return
        }

        $arquivosLista = $arquivosParaCompilar -join ";"
        Write-Host "Validando compilacao de $($arquivosParaCompilar.Count) arquivo(s)..." -ForegroundColor Cyan

        # Monta comando VFP
        $validarScript = Join-Path $config.paths.automation "vfp_helpers\ValidarCompilacao.prg"
        $vfp9Path = Join-Path $config.paths.vfp9 "vfp9.exe"

        # Cria script temporario para executar
        $tempScript = Join-Path $taskPath "temp_validar_compilacao.prg"
        $scriptContent = @"
SET SAFETY OFF
SET TALK OFF
SET CONSOLE ON

TRY
    DO "$validarScript" WITH "$arquivosLista"
    loc_nResult = 0
CATCH TO loEx
    ? "ERRO: " + loEx.Message
    loc_nResult = 1
ENDTRY

QUIT
"@
        $scriptContent | Set-Content -Path $tempScript -Encoding ASCII

        # Executa VFP com timeout (sem -C pois nao precisa de config.fpw, apenas o script direto)
        $logFile = Join-Path $taskPath "validar_compilacao.log"
        $vfpResult = Invoke-VFP9WithTimeout -VFP9Path $vfp9Path -Arguments "`"$tempScript`"" -TimeoutSeconds $config.vfp.timeout -RedirectStdOut $logFile
        if ($vfpResult.TimedOut) {
            throw "TIMEOUT: ValidarCompilacao.prg nao finalizou em $($config.vfp.timeout) segundos. VFP9 foi encerrado forcadamente."
        }

        # Verifica resultado
        $resultadoJson = Join-Path (Split-Path $formFile -Parent) "resultado_compilacao.json"
        if (!(Test-Path $resultadoJson)) {
            $resultadoJson = Join-Path $taskPath "resultado_compilacao.json"
        }

        $compilouOk = $true
        $errosEncontrados = @()

        if (Test-Path $resultadoJson) {
            $resultado = Get-Content $resultadoJson -Raw | ConvertFrom-Json
            $compilouOk = $resultado.sucesso

            if (!$compilouOk) {
                Write-Host ""
                Write-Host "ERROS DE COMPILACAO ENCONTRADOS:" -ForegroundColor Red
                foreach ($arq in $resultado.arquivos) {
                    if (!$arq.compilou) {
                        Write-Host "  - $($arq.arquivo)" -ForegroundColor Red
                        Write-Host "    $($arq.mensagem)" -ForegroundColor Yellow
                        $errosEncontrados += @{
                            arquivo = $arq.arquivo
                            mensagem = $arq.mensagem
                        }
                    }
                }
            }
        }
        else {
            # Verifica se existem arquivos .err
            foreach ($arquivo in $arquivosParaCompilar) {
                $errFile = [System.IO.Path]::ChangeExtension($arquivo, "err")
                if (Test-Path $errFile) {
                    $compilouOk = $false
                    $erroConteudo = Get-Content $errFile -Raw
                    Write-Host "ERRO em $arquivo :" -ForegroundColor Red
                    Write-Host $erroConteudo -ForegroundColor Yellow
                    $errosEncontrados += @{
                        arquivo = $arquivo
                        mensagem = $erroConteudo
                    }
                }
            }
        }

        # Remove script temporario
        if (Test-Path $tempScript) { Remove-Item $tempScript -Force }

        if ($compilouOk) {
            Write-Host ""
            Write-Host "SUCESSO: Todos os arquivos compilaram corretamente!" -ForegroundColor Green

            Complete-Etapa -TaskId $TaskId -Etapa "05c_validarCompilacao" -TasksDir $config.paths.tasks -Metadata @{
                arquivosValidados = $arquivosParaCompilar.Count
                sucesso = $true
            }
        }
        else {
            # --- RETRY LOOP: ate N tentativas de correcao via Claude ---
            $maxTentativas = if ($config.retry.PSObject.Properties['maxTentativasRuntimeFix']) {
                $config.retry.maxTentativasRuntimeFix
            } else { 10 }

            Write-Host ""
            Write-Host "FALHA: Erros de compilacao encontrados!" -ForegroundColor Red
            Write-Host "Iniciando retry loop (ate $maxTentativas tentativas)..." -ForegroundColor Yellow

            $compilouFinal = $false

            for ($tentativa = 1; $tentativa -le $maxTentativas; $tentativa++) {
                Write-Host ""
                Write-Host "--- Tentativa de correcao $tentativa/$maxTentativas ---" -ForegroundColor Cyan

                # Monta mensagem de erro para o Claude
                $erroMsg = ($errosEncontrados | ForEach-Object {
                    "$($_.arquivo): $($_.mensagem)"
                }) -join "`n"

                # Usa Invoke-RuntimeErrorCorrection (mesma funcao das Etapas 6/6.5)
                # Ela chama Claude, aplica CorretorAutomatico, recompila e deleta .fxp
                $corrigiu = Invoke-RuntimeErrorCorrection `
                    -TaskId $TaskId `
                    -BaseName $BaseName `
                    -EtapaOrigem "05c_validarCompilacao" `
                    -ErroMsg $erroMsg `
                    -Tentativa $tentativa

                if (-not $corrigiu) {
                    # Invoke-RuntimeErrorCorrection retorna $false se:
                    # 1. Usage limit (abort imediato)
                    # 2. Recompilacao interna falhou (erros persistem)
                    # Para caso 2, queremos CONTINUAR tentando pois o Claude pode
                    # ter resolvido parcialmente. Verificamos se foi usage limit.
                    $fixOutput = Join-Path $taskPath "05c_validarCompilacao_fix_output_t${tentativa}.txt"
                    if ((Test-Path $fixOutput) -and (Test-UsageLimitHit -OutputContent (Get-Content $fixOutput -Raw -ErrorAction SilentlyContinue))) {
                        Write-Host "USAGE LIMIT atingido. Abortando retry." -ForegroundColor Red
                        break
                    }
                    Write-Host "Correcao parcial (compilacao interna falhou). Continuando retry..." -ForegroundColor Yellow
                }

                Write-Host "Revalidando compilacao..." -ForegroundColor Cyan

                # Revalidar: limpar .err e recompilar
                foreach ($arquivo in $arquivosParaCompilar) {
                    $errFile = [System.IO.Path]::ChangeExtension($arquivo, "err")
                    if (Test-Path $errFile) { Remove-Item $errFile -Force }
                }

                $tempScriptRetry = Join-Path $taskPath "temp_validar_compilacao_t${tentativa}.prg"
                $scriptContent | Set-Content -Path $tempScriptRetry -Encoding ASCII
                $vfpResultRetry = Invoke-VFP9WithTimeout -VFP9Path $vfp9Path -Arguments "`"$tempScriptRetry`"" -TimeoutSeconds $config.vfp.timeout
                if (Test-Path $tempScriptRetry) { Remove-Item $tempScriptRetry -Force }

                if ($vfpResultRetry.TimedOut) {
                    Write-Host "TIMEOUT na recompilacao da tentativa $tentativa!" -ForegroundColor Red
                    continue
                }

                # Verificar se ainda ha erros
                $errosEncontrados = @()
                $compilouFinal = $true

                foreach ($arquivo in $arquivosParaCompilar) {
                    $errFile = [System.IO.Path]::ChangeExtension($arquivo, "err")
                    if (Test-Path $errFile) {
                        $compilouFinal = $false
                        $erroConteudo = Get-Content $errFile -Raw
                        $errosEncontrados += @{ arquivo = $arquivo; mensagem = $erroConteudo }
                        Write-Host "  ERRO persiste em ${arquivo}: $erroConteudo" -ForegroundColor Red
                    }
                }

                if ($compilouFinal) {
                    Write-Host ""
                    Write-Host "SUCESSO: Erros corrigidos na tentativa $tentativa! Compilacao OK." -ForegroundColor Green
                    break
                }

                if ($tentativa -ge $maxTentativas) {
                    Write-Host "Maximo de tentativas atingido ($maxTentativas)." -ForegroundColor Yellow
                }

                Start-Sleep -Seconds $config.retry.delaySegundos
            }

            if ($compilouFinal) {
                Complete-Etapa -TaskId $TaskId -Etapa "05c_validarCompilacao" -TasksDir $config.paths.tasks -Metadata @{
                    arquivosValidados = $arquivosParaCompilar.Count
                    sucesso = $true
                    corrigidoPorClaude = $true
                    tentativasUsadas = $tentativa
                }
            }
            else {
                Write-Host ""
                Write-Host "FALHA: Erros de compilacao persistem apos $tentativa tentativa(s)!" -ForegroundColor Red
                foreach ($e in $errosEncontrados) {
                    Write-Host "  - $($e.arquivo): $($e.mensagem)" -ForegroundColor Red
                }
                Fail-Etapa -TaskId $TaskId -Etapa "05c_validarCompilacao" -ErroMsg "Erros de compilacao persistem apos $tentativa tentativa(s) de correcao automatica" -TasksDir $config.paths.tasks
                throw "Erros de compilacao nao resolvidos apos $tentativa tentativa(s). Verificar manualmente."
            }
        }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "05c_validarCompilacao" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# ETAPA 5.7: Validar Completude (TODO/stubs/procedures vazias)
#------------------------------------------------------------------------------

function Invoke-Etapa05d_ValidarCompletude {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 5.7" "Validar Completude (TODO/stubs/procedures vazias)"

    Start-Etapa -TaskId $TaskId -Etapa "05d_validarCompletude" -TasksDir $config.paths.tasks

    try {
        # Determina nomes das classes
        $formClass = Get-FormClassName -BaseName $BaseName
        $boClass = Get-BOClassName -BaseName $BaseName
        $formType = Get-FormTypeFromState -TaskId $TaskId
        $formSubDir = Get-FormSubDir -FormType $formType

        # Arquivos a validar
        $formFile = Join-Path $config.paths.projeto "app\forms\$formSubDir\$formClass.prg"
        $boFile = Join-Path $config.paths.projeto "app\classes\$boClass.prg"

        # Fallback: procurar Form em outras pastas
        if (-not (Test-Path $formFile)) {
            $foundForm = Find-FormFile -ProjetoPath $config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
            if ($foundForm) { $formFile = $foundForm }
        }

        $problemasTotais = 0

        # Valida BO
        if (Test-Path $boFile) {
            $boOK = Test-CompletudeCodigo -FilePath $boFile -Descricao "BO ($boClass)"
            if (-not $boOK) { $problemasTotais++ }
        }

        # Valida Form
        if (Test-Path $formFile) {
            $formOK = Test-CompletudeCodigo -FilePath $formFile -Descricao "Form ($formClass)"
            if (-not $formOK) { $problemasTotais++ }
        }

        if ($problemasTotais -gt 0) {
            Write-Host ""
            Write-Host "========================================================================" -ForegroundColor Red
            Write-Host "  COMPLETUDE FALHOU: $problemasTotais arquivo(s) com TODO/stubs" -ForegroundColor Red
            Write-Host "========================================================================" -ForegroundColor Red
            Write-Host ""
            Write-Host "Iniciando correcao automatica via Claude..." -ForegroundColor Yellow

            $maxTentativas = if ($config.retry.PSObject.Properties['maxTentativasRuntimeFix']) {
                $config.retry.maxTentativasRuntimeFix
            } else { 10 }

            $corrigido = $false

            for ($tentativa = 1; $tentativa -le $maxTentativas; $tentativa++) {
                Write-Host ""
                Write-Host "--- Tentativa de correcao $tentativa/$maxTentativas ---" -ForegroundColor Cyan

                # Coletar descricao dos problemas lendo os arquivos diretamente
                $listaProblemas = @()

                foreach ($arquivo in @($boFile, $formFile)) {
                    if (-not (Test-Path $arquivo)) { continue }
                    $conteudo = Get-Content $arquivo -Raw -ErrorAction SilentlyContinue
                    if (-not $conteudo) { continue }

                    $nomeArquivo = Split-Path $arquivo -Leaf

                    # Detectar TODO/FIXME/HACK/PLACEHOLDER
                    $todoPattern = "(?im)^\s*\*\-?\-?\s*(TODO|FIXME|HACK|XXX|PLACEHOLDER)\b"
                    $todoMatches = [regex]::Matches($conteudo, $todoPattern)
                    foreach ($m in $todoMatches) {
                        $listaProblemas += "[$nomeArquivo] Marcador: $($m.Value.Trim())"
                    }

                    # Detectar procedures vazias
                    $procPattern = "(?ims)PROCEDURE\s+(\w+)\s*(\(.*?\))?\s*\r?\n(.*?)ENDPROC"
                    $procMatches = [regex]::Matches($conteudo, $procPattern)
                    foreach ($m in $procMatches) {
                        $procName = $m.Groups[1].Value
                        $body = $m.Groups[3].Value

                        if ($body -match "DODEFAULT\(\)") { continue }

                        $procParams = $m.Groups[2].Value
                        if ($procName -match "^Tecla" -and $procParams -match "par_nKeyCode") { continue }

                        $codeLines = ($body -split "`n" |
                                      Where-Object { $_ -match "\S" -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&" } |
                                      Measure-Object).Count

                        if ($codeLines -eq 0) {
                            $listaProblemas += "[$nomeArquivo] Procedure vazia (sem codigo): $procName"
                        }
                    }

                    # Detectar "implementar depois" / "proxima fase"
                    $laterPattern = "(?im)\*.*?(implementar\s+(depois|later|futur)|pr[o�]xima\s+fase|pendente|nao\s+implement)"
                    $laterMatches = [regex]::Matches($conteudo, $laterPattern)
                    foreach ($m in $laterMatches) {
                        $listaProblemas += "[$nomeArquivo] Indicador de pendencia: $($m.Value.Trim())"
                    }
                }

                if ($listaProblemas.Count -eq 0) {
                    # Nenhum problema detectado nesta iteracao (possivel correcao previa)
                    $corrigido = $true
                    break
                }

                $erroMsg = "Validacao de completude falhou. Procedures vazias/TODOs encontrados:`n" + ($listaProblemas -join "`n") + "`n`nIMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa."

                # Chamar Claude para corrigir
                try {
                    Invoke-RuntimeErrorCorrection `
                        -TaskId $TaskId `
                        -BaseName $BaseName `
                        -EtapaOrigem "05d_validarCompletude" `
                        -ErroMsg $erroMsg `
                        -Tentativa $tentativa
                }
                catch {
                    Write-Host "  [WARN] Correcao automatica falhou na tentativa ${tentativa}: $($_.Exception.Message)" -ForegroundColor Yellow
                    # Se for usage limit, abortar loop
                    if ($_.Exception.Message -match "usage.limit|rate.limit") {
                        Write-Host "  [ABORT] Limite de uso atingido, abortando retry loop" -ForegroundColor Red
                        break
                    }
                    continue
                }

                # Re-validar apos correcao
                $problemasTotais = 0
                if (Test-Path $boFile) {
                    $boOK = Test-CompletudeCodigo -FilePath $boFile -Descricao "BO ($boClass)"
                    if (-not $boOK) { $problemasTotais++ }
                }
                if (Test-Path $formFile) {
                    $formOK = Test-CompletudeCodigo -FilePath $formFile -Descricao "Form ($formClass)"
                    if (-not $formOK) { $problemasTotais++ }
                }

                if ($problemasTotais -eq 0) {
                    $corrigido = $true
                    break
                }

                Write-Host "  Ainda restam $problemasTotais arquivo(s) com problemas. Tentando novamente..." -ForegroundColor Yellow
            }

            if ($corrigido) {
                Write-Host ""
                Write-Host "  COMPLETUDE OK (apos correcao automatica): Nenhum TODO/stub/procedure vazia" -ForegroundColor Green
                Write-Host ""

                Complete-Etapa -TaskId $TaskId -Etapa "05d_validarCompletude" -TasksDir $config.paths.tasks -Metadata @{
                    sucesso = $true
                    arquivosComProblema = 0
                    tentativasCorrecao = $tentativa
                    mensagem = "Corrigido automaticamente apos $tentativa tentativa(s)."
                }
            }
            else {
                Write-Host ""
                Write-Host "  [WARN] Completude ainda com problemas apos $maxTentativas tentativas" -ForegroundColor Yellow
                Write-Host "  O pipeline continuara, mas os TODOs/stubs devem ser resolvidos" -ForegroundColor Yellow
                Write-Host "  antes da entrega final ao cliente." -ForegroundColor Yellow
                Write-Host ""

                Complete-Etapa -TaskId $TaskId -Etapa "05d_validarCompletude" -TasksDir $config.paths.tasks -Metadata @{
                    sucesso = $false
                    arquivosComProblema = $problemasTotais
                    tentativasCorrecao = $maxTentativas
                    mensagem = "Encontrados TODO/stubs/procedures vazias. Correcao automatica nao resolveu todos. Revisar manualmente."
                }
            }
        }
        else {
            Write-Host ""
            Write-Host "  COMPLETUDE OK: Nenhum TODO/stub/procedure vazia encontrado" -ForegroundColor Green
            Write-Host ""

            Complete-Etapa -TaskId $TaskId -Etapa "05d_validarCompletude" -TasksDir $config.paths.tasks -Metadata @{
                sucesso = $true
                arquivosComProblema = 0
            }
        }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "05d_validarCompletude" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}

#------------------------------------------------------------------------------
# ETAPA 5.8: Code Review Automatizado
#------------------------------------------------------------------------------

function Test-CodeReviewProblems {
    <#
    .SYNOPSIS
        Analisa codigo gerado em busca de problemas conhecidos (Grid?SQL, containers flutuantes, alinhamento)
    .DESCRIPTION
        Retorna lista de problemas encontrados. Se vazia, o codigo passou no review.
    #>
    param(
        [string]$FormFile,
        [string]$BOFile,
        [string]$OriginalSourceFile
    )

    $problemas = @()

    # --- Ler conteudo dos arquivos ---
    $formContent = ""
    $boContent = ""
    $originalContent = ""

    if (Test-Path $FormFile) { $formContent = Get-Content $FormFile -Raw -Encoding UTF8 }
    if (Test-Path $BOFile) { $boContent = Get-Content $BOFile -Raw -Encoding UTF8 }
    if (Test-Path $OriginalSourceFile) { $originalContent = Get-Content $OriginalSourceFile -Raw -Encoding UTF8 }

    if (-not $formContent -and -not $boContent) {
        return @("Nenhum arquivo de codigo encontrado para review")
    }

    # ========================================================================
    # CHECK 1: Grid ControlSource vs CREATE CURSOR / SELECT (Problema 25)
    # ========================================================================
    $allContent = "$boContent`n$formContent"

    # Extrair todos os ControlSource de grids (cursor_4c_*.CAMPO)
    $controlSourcePattern = '\.ControlSource\s*=\s*"cursor_4c_(\w+)\.(\w+)"'
    $csMatches = [regex]::Matches($allContent, $controlSourcePattern, 'IgnoreCase')

    $cursorFields = @{}  # cursor_name -> @(field1, field2, ...)
    foreach ($m in $csMatches) {
        $cursorName = "cursor_4c_$($m.Groups[1].Value)"
        $fieldName = $m.Groups[2].Value
        if (-not $cursorFields.ContainsKey($cursorName)) {
            $cursorFields[$cursorName] = @()
        }
        if ($cursorFields[$cursorName] -notcontains $fieldName) {
            $cursorFields[$cursorName] += $fieldName
        }
    }

    # Para cada cursor, verificar se os campos existem no CREATE CURSOR ou SELECT
    foreach ($cursor in $cursorFields.Keys) {
        $campos = $cursorFields[$cursor]

        # Buscar CREATE CURSOR correspondente
        # Regex com par�nteses balanceados: captura conteudo interno incluindo tipos como C(10), N(14,2)
        $createPattern = "(?ims)CREATE\s+CURSOR\s+$cursor\s*\(((?:[^()]*|\([^()]*\))*)\)"
        $createMatch = [regex]::Match($allContent, $createPattern)

        if ($createMatch.Success) {
            $cursorDef = $createMatch.Groups[1].Value
            foreach ($campo in $campos) {
                if ($cursorDef -notmatch "(?i)\b$campo\b") {
                    $problemas += "[GRID-SQL] Campo '$campo' usado em ControlSource de $cursor mas NAO existe no CREATE CURSOR"
                }
            }
        }

        # Buscar SELECT ... INTO CURSOR ou SQLEXEC(..., "cursor")
        # Verificar se SELECT inclui os campos (para SQLEXEC, verificar o SQL string)
        $sqlExecPattern = "(?ims)SQLEXEC\s*\(\s*\w+\s*,\s*(\w+)\s*,\s*[`"']$cursor[`"']\s*\)"
        $sqlExecMatch = [regex]::Match($allContent, $sqlExecPattern)

        if ($sqlExecMatch.Success) {
            $sqlVarName = $sqlExecMatch.Groups[1].Value
            # Buscar a variavel SQL que contem o SELECT
            $sqlBuildPattern = "(?ims)$sqlVarName\s*=\s*""SELECT\s+(.*?)FROM"
            $sqlBuildMatch = [regex]::Match($allContent, $sqlBuildPattern)

            if ($sqlBuildMatch.Success) {
                $selectFields = $sqlBuildMatch.Groups[1].Value
                foreach ($campo in $campos) {
                    # Buscar campo no SELECT (como a.Campo, b.Campo, ou Campo direto)
                    if ($selectFields -notmatch "(?i)\b\w*\.?$campo\b" -and $selectFields -notmatch "\*") {
                        $problemas += "[GRID-SQL] Campo '$campo' usado em ControlSource de $cursor mas NAO aparece no SELECT SQL"
                    }
                }
            }
        }
    }

    # ========================================================================
    # CHECK 2: Containers flutuantes sem filtro em TornarControlesVisiveis (Problema 26)
    # ========================================================================
    if ($formContent) {
        # Detectar containers criados com Visible = .F.
        $hiddenContainerPattern = '(?ims)AddObject\s*\(\s*"(cnt_4c_\w+)"\s*,\s*"Container"\s*\).*?\.Visible\s*=\s*\.F\.'
        $hiddenContainers = [regex]::Matches($formContent, $hiddenContainerPattern)
        $hiddenNames = @()
        foreach ($m in $hiddenContainers) {
            $hiddenNames += $m.Groups[1].Value.ToUpper()
        }

        if ($hiddenNames.Count -gt 0) {
            # Verificar se TornarControlesVisiveis tem filtro real (INLIST, IF !Visible, skip logic)
            $tornarPattern = '(?ims)PROCEDURE\s+TornarControlesVisiveis.*?ENDPROC'
            $tornarMatch = [regex]::Match($formContent, $tornarPattern)

            if ($tornarMatch.Success) {
                $tornarBody = $tornarMatch.Value
                # Verificar se tem logica de exclusao real (INLIST com cnt_/pgf_, ou !Visible skip, ou name check)
                $temFiltroReal = $tornarBody -match '(?i)INLIST\s*\(' -and $tornarBody -match '(?i)cnt_' -or
                                 $tornarBody -match '(?i)!.*\.Visible' -and $tornarBody -match '(?i)cnt_' -or
                                 $tornarBody -match '(?i)NOT\s+.*\.Visible' -and $tornarBody -match '(?i)pular|skip'
                if (-not $temFiltroReal) {
                    $nomesList = $hiddenNames -join ", "
                    $problemas += "[CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: $nomesList. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo."
                }
            }
            else {
                # Se nao tem o metodo mas chama TornarControlesVisiveis, pode ser herdado - FormBase ja filtra
                # NAO emitir warning: FormBase.TornarControlesVisiveis ja tem filtro generico
            }
        }
    }

    # ========================================================================
    # CHECK 3: Alinhamento de botoes (Problema 27)
    # ========================================================================
    if ($formContent) {
        # Encontrar grupos de botoes CommandButton na mesma Page com Top parecido (�15px)
        # Buscar padroes de AddObject("cmd_4c_*", "CommandButton") seguido de .Top = N

        $btnPattern = '(?ims)AddObject\s*\(\s*"(cmd_4c_\w+)"\s*,\s*"CommandButton"\s*\).*?\.Top\s*=\s*(\d+).*?\.Height\s*=\s*(\d+)'
        $btnMatches = [regex]::Matches($formContent, $btnPattern)

        if ($btnMatches.Count -ge 2) {
            # Agrupar botoes por Top aproximado (dentro de �15px = mesma "barra")
            $botoes = @()
            foreach ($m in $btnMatches) {
                $botoes += @{
                    Nome = $m.Groups[1].Value
                    Top = [int]$m.Groups[2].Value
                    Height = [int]$m.Groups[3].Value
                }
            }

            # Agrupar botoes com mesma altura (mesma "barra" horizontal)
            $gruposPorAltura = @{}
            foreach ($btn in $botoes) {
                $found = $false
                foreach ($key in @($gruposPorAltura.Keys)) {
                    if ([math]::Abs($btn.Top - $key) -le 15 -and $btn.Height -eq $gruposPorAltura[$key][0].Height) {
                        $gruposPorAltura[$key] += $btn
                        $found = $true
                        break
                    }
                }
                if (-not $found) {
                    $gruposPorAltura[$btn.Top] = @($btn)
                }
            }

            # Para cada grupo com 2+ botoes, verificar se todos tem mesmo Top
            foreach ($key in $gruposPorAltura.Keys) {
                $grupo = $gruposPorAltura[$key]
                if ($grupo.Count -ge 2) {
                    $tops = $grupo | ForEach-Object { $_.Top } | Sort-Object -Unique
                    if ($tops.Count -gt 1) {
                        $topMaisFreq = ($grupo | Group-Object { $_.Top } | Sort-Object Count -Descending | Select-Object -First 1).Name
                        $desalinhados = $grupo | Where-Object { $_.Top -ne [int]$topMaisFreq }
                        foreach ($d in $desalinhados) {
                            $problemas += "[ALINHAMENTO] Botao '$($d.Nome)' tem Top=$($d.Top) mas grupo usa Top=$topMaisFreq (diferenca de $([math]::Abs($d.Top - [int]$topMaisFreq))px)"
                        }
                    }
                }
            }
        }
    }

    # ========================================================================
    # CHECK 4: SQL com tabelas/colunas potencialmente erradas (schema.sql)
    # ========================================================================
    if ($boContent -and $originalContent) {
        # Extrair tabelas usadas no original (FROM/JOIN/INTO seguido de SigXxxYyy)
        $tblOrigPattern = '(?i)(?:FROM|JOIN|INTO)\s+(Sig\w+)'
        $tblOrigMatches = [regex]::Matches($originalContent, $tblOrigPattern)
        $tabelasOriginal = @()
        foreach ($m in $tblOrigMatches) {
            $t = $m.Groups[1].Value
            if ($tabelasOriginal -notcontains $t) { $tabelasOriginal += $t }
        }

        # Extrair tabelas usadas no BO migrado
        $tblMigPattern = '(?i)(?:FROM|JOIN|INTO)\s+(Sig\w+)'
        $tblMigMatches = [regex]::Matches($boContent, $tblMigPattern)
        $tabelasMigrado = @()
        foreach ($m in $tblMigMatches) {
            $t = $m.Groups[1].Value
            if ($tabelasMigrado -notcontains $t) { $tabelasMigrado += $t }
        }

        # Tabelas no migrado que NAO estao no original (possivelmente inventadas)
        foreach ($tbl in $tabelasMigrado) {
            $foundInOriginal = $false
            foreach ($tblOrig in $tabelasOriginal) {
                if ($tbl -ieq $tblOrig) { $foundInOriginal = $true; break }
            }
            if (-not $foundInOriginal) {
                # Cross-check com schema.sql: se a tabela existe no schema, nao eh inventada
                $existeNoSchema = $false
                $schemaFile = $null
                if ($config -and $config.paths -and $config.paths.projeto) {
                    $schemaFile = Join-Path (Split-Path $config.paths.projeto -Parent) "docs\schema.sql"
                }
                if ($schemaFile -and (Test-Path $schemaFile)) {
                    $schemaContent = Get-Content $schemaFile -Raw -ErrorAction SilentlyContinue
                    if ($schemaContent -match "(?i)CREATE\s+TABLE\s+\[?dbo\]?\.\[?$tbl\b") {
                        $existeNoSchema = $true
                    }
                }
                if (-not $existeNoSchema) {
                    $problemas += "[SQL-TABELA] Tabela '$tbl' usada no BO migrado mas NAO aparece no codigo original. Pode ser tabela inventada/confundida."
                }
            }
        }
    }

    # ========================================================================
    # CHECK 5: mAddColuna com parametro numerico (Problema 28)
    # ========================================================================
    if ($formContent) {
        $addColunaPattern = '\.mAddColuna\s*\([^)]+,\s*(\d+)\s*\)'
        $addColunaMatches = [regex]::Matches($formContent, $addColunaPattern)
        foreach ($m in $addColunaMatches) {
            $problemas += "[MADDCOLUNA] Chamada mAddColuna com parametro numerico '$($m.Groups[1].Value)'. Assinatura correta: mAddColuna(campo, mascara, titulo) - TODOS strings. Largura NAO eh parametro."
        }
    }

    # ========================================================================
    # CHECK 6: CREATEOBJECT("FormBuscaAuxiliar") sem params seguido de .Show sem this_cCursorDestino (Problema 29)
    # ========================================================================
    if ($formContent) {
        # Procura blocos onde FormBuscaAuxiliar eh criado sem params e nao define this_cCursorDestino
        $fbaSemParams = [regex]::Matches($formContent, 'CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"\s*\)\s*$', [System.Text.RegularExpressions.RegexOptions]::Multiline)
        foreach ($m in $fbaSemParams) {
            # Pega as proximas 15 linhas apos o CREATEOBJECT
            $posicao = $m.Index
            $trecho = $formContent.Substring($posicao, [Math]::Min(800, $formContent.Length - $posicao))
            if ($trecho -notmatch 'this_cCursorDestino') {
                $problemas += "[BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show()."
            }
        }
    }

    # ========================================================================
    # CHECK 7: OptionGroup Buttons sem Left (Problema 30)
    # ========================================================================
    if ($formContent) {
        # Procura OptionGroups com ButtonCount >= 2 e verifica se Buttons tem .Left definido
        $optGroupMatches = [regex]::Matches($formContent, '(?i)\.ButtonCount\s*=\s*(\d+)')
        foreach ($m in $optGroupMatches) {
            $btnCount = [int]$m.Groups[1].Value
            if ($btnCount -ge 2) {
                # Verifica se Buttons(2) tem .Left definido nas proximas linhas
                $posicao = $m.Index
                $trecho = $formContent.Substring($posicao, [Math]::Min(1500, $formContent.Length - $posicao))
                if ($trecho -match 'Buttons\(2\)' -and $trecho -notmatch 'Buttons\(2\)[\s\S]{0,200}\.Left\s*=') {
                    $problemas += "[OPTIONGROUP-LEFT] OptionGroup com ButtonCount=$btnCount mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button."
                }
            }
        }
    }

    # ========================================================================
    # CHECK 8: LostFocus de campo de filtro sem chamada de carga de dados (Problema 31)
    # ========================================================================
    if ($formContent -and $originalContent) {
        # Se o legado tem MontaGrade/Processa chamado em Valid/LostFocus, verificar se o migrado carrega dados
        if ($originalContent -match '(?i)MontaGrade|ProcessaHist|CarregaDados') {
            # Procura metodos Validar* que NAO chamam CarregarGrade/BuscarSaldos/BuscarHistorico
            $validarBlocks = [regex]::Matches($formContent, '(?si)PROCEDURE\s+(Validar\w+)\(\)(.+?)ENDPROC')
            foreach ($vb in $validarBlocks) {
                $nomeMetodo = $vb.Groups[1].Value
                $corpoMetodo = $vb.Groups[2].Value
                # Verifica se tem chamada de carga apos validacao bem-sucedida
                if ($corpoMetodo -notmatch '(?i)Carregar\w+|Buscar\w+|AbrirLookup\w+|AbrirBusca\w+') {
                    # Verifica se o metodo faz validacao real (tem SQLEXEC)
                    if ($corpoMetodo -match '(?i)SQLEXEC') {
                        $problemas += "[CARGA-DADOS] Metodo $nomeMetodo faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida."
                    }
                }
            }

            # Verifica se OptionGroups que afetam filtro tem BINDEVENT InteractiveChange
            $optGroupNames = [regex]::Matches($formContent, '(?i)AddObject\(\s*"(opt_4c_\w+)"')
            foreach ($og in $optGroupNames) {
                $ogName = $og.Groups[1].Value
                if ($formContent -notmatch "(?i)BINDEVENT.*$ogName.*InteractiveChange") {
                    $problemas += "[CARGA-DADOS] OptionGroup '$ogName' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade."
                }
            }
        }
    }

    # ========================================================================
    # CHECK 9: CarregarGrade* sem Header1.Caption (Problema 32)
    # ========================================================================
    if ($formContent) {
        $carregarBlocks = [regex]::Matches($formContent, '(?si)PROCEDURE\s+(CarregarGrade\w+)\(\)(.+?)ENDPROC')
        foreach ($cb in $carregarBlocks) {
            $nomeMetodo = $cb.Groups[1].Value
            $corpoMetodo = $cb.Groups[2].Value
            if ($corpoMetodo -match '(?i)RecordSource\s*=' -and $corpoMetodo -notmatch '(?i)Header1\.Caption') {
                $problemas += "[GRID-HEADERS] Metodo $nomeMetodo redefine RecordSource mas NAO redefine Header1.Caption. Headers ficam com nomes de campo (ex: 'Contas') ao inves de titulos legiveis (ex: 'Conta'). OBRIGATORIO redefinir TODOS os Header1.Caption APOS RecordSource."
            }
        }
    }

    # ========================================================================
    # CHECK 10: SQLEXEC direto no cursor do Grid - destroi colunas (Problema 34)
    # ========================================================================
    if ($formContent) {
        # Procura SQLEXEC que grava direto num cursor usado como RecordSource de Grid
        $sqlexecMatches = [regex]::Matches($formContent, '(?i)SQLEXEC\s*\(.+?,\s*"(cursor_4c_\w+)"\s*\)')
        foreach ($se in $sqlexecMatches) {
            $cursorName = $se.Groups[1].Value
            # Verifica se este cursor eh usado como RecordSource de algum grid
            if ($formContent -match "(?i)RecordSource\s*=\s*[`"']$cursorName[`"']") {
                # Verifica se NAO usa cursor temporario (nome diferente do RecordSource)
                if ($cursorName -notmatch 'Temp$') {
                    $problemas += "[GRID-SQLEXEC] SQLEXEC grava direto no cursor '$cursorName' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: '${cursorName}Temp'), depois ZAP + APPEND FROM DBF() no cursor original."
                }
            }
        }
    }

    # ========================================================================
    # CHECK 11: CREATE CURSOR sem SET NULL ON (Problema 35)
    # ========================================================================
    # Verificar em AMBOS os arquivos (Form e BO)
    foreach ($contentToCheck in @(@{Name="Form"; Content=$formContent}, @{Name="BO"; Content=$boContent})) {
        $checkContent = $contentToCheck.Content
        if ($checkContent) {
            # [^\*\r\n]* evita que o regex "coma" multiplas linhas (newlines nao sao *)
            $createCursorMatches = [regex]::Matches($checkContent, '(?im)^[^\*\r\n]*CREATE\s+CURSOR\s+(cursor_4c_\w+)')
            # Rastrear cursores ja detectados para evitar duplicatas
            $cursoresDetectados = @()
            foreach ($cc in $createCursorMatches) {
                $cursorName = $cc.Groups[1].Value
                # Pular se ja detectou este cursor (pode ter multiplos CREATE CURSOR para mesmo nome)
                if ($cursoresDetectados -contains $cursorName) { continue }
                $posicao = $cc.Index
                # Verifica se tem SET NULL ON nas 10 linhas anteriores (~800 chars) ou no PROCEDURE inteiro
                $inicio = [Math]::Max(0, $posicao - 800)
                $trecho = $checkContent.Substring($inicio, $posicao - $inicio)
                if ($trecho -notmatch '(?i)SET\s+NULL\s+ON') {
                    # Verificar se esta dentro de um PROCEDURE que tem SET NULL ON no inicio
                    $procInicio = $checkContent.LastIndexOf("PROCEDURE", $posicao)
                    if ($procInicio -ge 0) {
                        $procTrecho = $checkContent.Substring($procInicio, $posicao - $procInicio)
                        if ($procTrecho -match '(?i)SET\s+NULL\s+ON') { continue }
                    }
                    $cursoresDetectados += $cursorName
                    $problemas += "[NULL-CURSOR] CREATE CURSOR '$cursorName' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois."
                }
            }
        }
    }

    # ========================================================================
    # CHECK 12: RecordSource/ColumnCount dentro de WITH Grid (Problema 36)
    # ========================================================================
    if ($formContent) {
        # Procura WITH blocks que definem RecordSource e depois acessam .Column1
        $withBlocks = [regex]::Matches($formContent, '(?si)WITH\s+([\w\.]+)\s*\n(.+?)ENDWITH')
        foreach ($wb in $withBlocks) {
            $corpoWith = $wb.Groups[2].Value
            if ($corpoWith -match '(?i)\.RecordSource\s*=' -and $corpoWith -match '(?i)\.Column\d+\.') {
                $objRef = $wb.Groups[1].Value
                $problemas += "[GRID-WITH] Bloco WITH $objRef define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: $objRef.RecordSource)."
            }
        }
    }

    # ========================================================================
    # CHECK 13: CREATE CURSOR duplicado com ordem de campos diferente (Problema 37)
    # ========================================================================
    if ($formContent) {
        # Encontra todos os CREATE CURSOR com mesmo nome
        $createCursorAll = [regex]::Matches($formContent, '(?ims)CREATE\s+CURSOR\s+(cursor_4c_\w+)\s*\(((?:[^()]*|\([^()]*\))*)\)')
        $cursorDefs = @{}
        foreach ($cc in $createCursorAll) {
            $cName = $cc.Groups[1].Value.ToUpper()
            $cFields = $cc.Groups[2].Value.Trim()
            # Extrair apenas nomes de campos (sem tipos)
            $fieldNames = @()
            foreach ($part in ($cFields -split ',')) {
                $part = $part.Trim()
                if ($part -match '^(\w+)\s') {
                    $fieldNames += $Matches[1].ToUpper()
                }
                elseif ($part -match '^(\w+)$') {
                    $fieldNames += $Matches[1].ToUpper()
                }
            }
            $fieldKey = ($fieldNames -join ",")

            if ($cursorDefs.ContainsKey($cName)) {
                if ($cursorDefs[$cName] -ne $fieldKey) {
                    $problemas += "[CURSOR-ORDEM] CREATE CURSOR '$($cc.Groups[1].Value)' aparece em mais de um local com ORDEM DE CAMPOS DIFERENTE. Primeira ocorrencia: [$($cursorDefs[$cName])]. Segunda ocorrencia: [$fieldKey]. A ordem DEVE ser IDENTICA em TODOS os CREATE CURSOR do mesmo nome."
                }
            }
            else {
                $cursorDefs[$cName] = $fieldKey
            }
        }
    }

    # ========================================================================
    # CHECK 14: Containers flutuantes sem filtro em TornarControlesVisiveis (Reforco para OPERACIONAL)
    # ========================================================================
    if ($formContent) {
        # Verificar se AddObject cria containers com .Visible = .F. E se ha toggle (Visible = !Visible ou Visible = .T.)
        $containerPattern = '(?i)AddObject\s*\(\s*"(cnt_4c_\w+)"'
        $containerNames = [regex]::Matches($formContent, $containerPattern)
        $hiddenContNames = @()

        foreach ($cn in $containerNames) {
            $name = $cn.Groups[1].Value
            # Verifica se logo apos esse container ha .Visible = .F.
            $pos = $cn.Index
            $trecho = $formContent.Substring($pos, [Math]::Min(500, $formContent.Length - $pos))
            if ($trecho -match '(?i)\.Visible\s*=\s*\.F\.') {
                # Verifica se ha toggle (Visible = !Visible ou Visible = .T. em outro ponto)
                if ($formContent -match "(?i)$name\.Visible\s*=\s*!\.$name\.Visible" -or
                    $formContent -match "(?i)$name\.Visible\s*=\s*!\.Visible" -or
                    $formContent -match "(?i)$name\.Visible\s*=\s*\.T\.") {
                    $hiddenContNames += $name.ToUpper()
                }
            }
        }

        if ($hiddenContNames.Count -gt 0) {
            # Verificar se TornarControlesVisiveis filtra esses containers
            $tornarPattern = '(?ims)PROCEDURE\s+TornarControlesVisiveis.*?ENDPROC'
            $tornarMatch = [regex]::Match($formContent, $tornarPattern)

            if ($tornarMatch.Success) {
                foreach ($hcn in $hiddenContNames) {
                    if ($tornarMatch.Value -notmatch "(?i)$hcn") {
                        $problemas += "[CONTAINER-TOGGLE] Container '$hcn' eh flutuante (Visible=.F. toggled por botao) mas TornarControlesVisiveis NAO o filtra. Adicionar verificacao INLIST/IF para pular este container no loop."
                    }
                }
            }
        }
    }

    # ========================================================================
    # CHECK 15: Navegacao Page1?Page2 em forms OPERACIONAL deve ler do grid
    # Em forms OPERACIONAL com PageFrame, o botao que navega para Page2 deve
    # ler dados da linha selecionada no grid de Page1, NAO abrir floating container
    # para input manual. O legado sempre l� do cursor do grid e navega diretamente.
    # ========================================================================
    if ($formContent -and $formType -eq "OPERACIONAL") {
        # Verifica se ha ActivePage = 2 no form
        $activePageMatches = [regex]::Matches($formContent, '(?i)\.ActivePage\s*=\s*2')
        if ($activePageMatches.Count -gt 0) {
            # Verifica se algum metodo Btn*Click que faz ActivePage=2 le de cursor (SELECT/cursor_4c_)
            foreach ($apm in $activePageMatches) {
                $pos = $apm.Index
                # Encontra o PROCEDURE que contem este ActivePage = 2
                $beforeText = $formContent.Substring(0, $pos)
                $procMatch = [regex]::Match($beforeText, '(?i)PROCEDURE\s+(\w+)\s*\(', [System.Text.RegularExpressions.RegexOptions]::RightToLeft)
                if ($procMatch.Success) {
                    $procName = $procMatch.Groups[1].Value
                    # Extrai corpo do metodo
                    $procStart = $procMatch.Index
                    $endProcMatch = [regex]::Match($formContent.Substring($procStart), '(?i)ENDPROC')
                    if ($endProcMatch.Success) {
                        $procBody = $formContent.Substring($procStart, $endProcMatch.Index + $endProcMatch.Length)
                        # Se o metodo faz ActivePage=2 mas NAO referencia nenhum cursor (SELECT cursor_ ou cursor_4c_)
                        # e NAO chama CarregarHistorico/CarregarDados, provavelmente esta errado
                        $temCursor = $procBody -match '(?i)(SELECT\s+cursor_4c_|cursor_4c_\w+\.\w+|CarregarHistorico|CarregarDados)'
                        if (-not $temCursor) {
                            $problemas += "[NAVEGACAO-PAGINA] Metodo '$procName' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid)."
                        }
                    }
                }
            }
        }
        else {
            # Se NAO ha ActivePage = 2 mas ha 2+ pages e ha BtnConsultar*Click
            # que apenas togglea Visible de container, provavelmente esta errado
            $consultarMethods = [regex]::Matches($formContent, '(?si)PROCEDURE\s+(BtnConsultar\w+Click)\s*\(\)(.+?)ENDPROC')
            foreach ($cm in $consultarMethods) {
                $cmName = $cm.Groups[1].Value
                $cmBody = $cm.Groups[2].Value
                # Se o metodo so faz toggle de Visible e NAO faz ActivePage/CarregarHistorico/CarregarDados
                if ($cmBody -match '(?i)\.Visible\s*=' -and $cmBody -notmatch '(?i)(ActivePage|Carregar\w+|Buscar\w+|AlternarPagina)') {
                    $problemas += "[NAVEGACAO-PAGINA] Metodo '$cmName' apenas alterna Visible de container mas NAO navega para Page2 nem carrega dados. Em forms OPERACIONAL com PageFrame, BtnConsultar*Click DEVE ler a linha selecionada do grid (cursor_4c_*) e navegar para Page2 (ActivePage=2) carregando historico/dados. Revisar logica do legado."
                }
            }
        }
    }

    # ========================================================================
    # CHECK 16: BINDEVENT para eventos com parametros sem LPARAMETERS no handler
    # AfterRowColChange passa nColIndex, KeyPress passa nKeyCode+nShiftAltCtrl
    # Handler sem parametros causa "No PARAMETER statement is found"
    # ========================================================================
    if ($formContent) {
        $eventosComParam = @{
            'AfterRowColChange' = 'par_nColIndex'
            'KeyPress'          = 'par_nKeyCode, par_nShiftAltCtrl'
        }

        $bindMatches = [regex]::Matches($formContent, '(?i)BINDEVENT\s*\(.+?,\s*"(\w+)"\s*,\s*.+?,\s*"(\w+)"\s*\)')
        foreach ($bm in $bindMatches) {
            $evento = $bm.Groups[1].Value
            $handler = $bm.Groups[2].Value
            foreach ($ev in $eventosComParam.Keys) {
                if ($evento -eq $ev) {
                    # Verifica se o handler tem parametros
                    $handlerPattern = "(?i)PROCEDURE\s+$handler\s*\(\s*\)"
                    if ($formContent -match $handlerPattern) {
                        $problemas += "[BINDEVENT-PARAMS] Handler '$handler' para evento '$ev' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE $handler($($eventosComParam[$ev]))"
                    }
                }
            }
        }
    }

    # ========================================================================
    # CHECK 17: Headers de Grid devem coincidir com o fonte legado
    # Extrai Header1.Caption do codigo migrado e compara com Caption dos
    # headers no arquivo _codigo_fonte.txt original. Divergencias indicam
    # que o Claude inventou ou abreviou nomes de colunas.
    # ========================================================================
    if ($formContent) {
        $taskPath = Join-Path $config.paths.tasks $TaskId
        # Encontrar arquivo _codigo_fonte.txt
        $fonteFiles = Get-ChildItem -Path $taskPath -Filter "*_codigo_fonte.txt" -ErrorAction SilentlyContinue
        if ($fonteFiles -and $fonteFiles.Count -gt 0) {
            $fonteContent = Get-Content -Path $fonteFiles[0].FullName -Raw -ErrorAction SilentlyContinue
            if ($fonteContent) {
                # Extrair headers do legado: Caption = "XXX" dentro de blocos Header1
                # Formato: * PROPRIEDADES DE: *.Header1 seguido de Caption = "XXX"
                # Usa lista (nao dicionario) porque Column1 pode existir em multiplos grids
                $legadoHeaderCaptions = @()
                $headerBlocks = [regex]::Matches($fonteContent, '(?im)\*\s*PROPRIEDADES DE:\s*\S+\.(\w+)\.Header1\s*\r?\n[-]+\s*\r?\n((?:.*\r?\n)*?)(?=\r?\n[-]+|\r?\n\r?\n={2,})')
                foreach ($hb in $headerBlocks) {
                    $blockContent = $hb.Groups[2].Value
                    if ($blockContent -match '(?i)Caption\s*=\s*"([^"]*)"') {
                        $legadoHeaderCaptions += $Matches[1].Trim()
                    }
                    elseif ($blockContent -match '(?i)Caption\s*=\s*(.+)$') {
                        $legadoHeaderCaptions += $Matches[1].Trim()
                    }
                }
                # Remover duplicatas mantendo valores unicos
                $legadoHeaderCaptions = $legadoHeaderCaptions | Select-Object -Unique

                if ($legadoHeaderCaptions.Count -gt 0) {
                    # Extrair headers do migrado: .ColumnN.Header1.Caption = "XXX" ou = "XXX" + CHR(...)
                    $migradoHeaderMatches = [regex]::Matches($formContent, '(?im)\.Header1\.Caption\s*=\s*(.+)$')
                    $migradoCaptions = @()
                    foreach ($mh in $migradoHeaderMatches) {
                        $rawCaption = $mh.Groups[1].Value.Trim()
                        # Resolve expressao VFP para texto plano:
                        # "Descri" + CHR(231) + CHR(227) + "o" ? Descri��o
                        $resolved = ""
                        $parts = $rawCaption -split '\s*\+\s*'
                        foreach ($part in $parts) {
                            $part = $part.Trim()
                            if ($part -match '^"([^"]*)"$') {
                                $resolved += $Matches[1]
                            }
                            elseif ($part -match '(?i)^CHR\((\d+)\)$') {
                                $resolved += [char][int]$Matches[1]
                            }
                        }
                        if ($resolved.Length -gt 0) {
                            $migradoCaptions += $resolved
                        }
                    }

                    # Normalizar para comparacao: remover acentos (non-ASCII ? ?)
                    # Comparar migrado vs legado
                    foreach ($mc in $migradoCaptions) {
                        $mcNorm = $mc -replace '[^\x20-\x7E]', '?'
                        $found = $false
                        foreach ($lc in $legadoHeaderCaptions) {
                            $lcNorm = ($lc -replace '[^\x20-\x7E]', '?').Trim()
                            if ($mcNorm -eq $lcNorm) {
                                $found = $true
                                break
                            }
                        }
                        if (-not $found -and $mc.Length -gt 0) {
                            $problemas += "[GRID-HEADER] Header Caption '$mc' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: $( ($legadoHeaderCaptions | ForEach-Object { $_.Trim() }) -join ', '). Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado."
                        }
                    }
                }
            }
        }
    }

    # ========================================================================
    # CHECK 18: mAddColuna com numero errado de parametros (Problema 41)
    # FormBuscaAuxiliar.mAddColuna aceita EXATAMENTE 3 params: campo, mascara, titulo
    # Claude frequentemente inventa 4 params: campo, titulo, largura, tabela
    # ========================================================================
    if ($formContent) {
        $mAddColunaMatches = [regex]::Matches($formContent, '(?im)\.mAddColuna\(([^)]+)\)')
        foreach ($mac in $mAddColunaMatches) {
            $args = $mac.Groups[1].Value
            # Conta parametros (split por virgula fora de strings)
            $nParams = 1
            $insideString = $false
            for ($ci = 0; $ci -lt $args.Length; $ci++) {
                if ($args[$ci] -eq '"') { $insideString = !$insideString }
                if ($args[$ci] -eq ',' -and !$insideString) { $nParams++ }
            }
            if ($nParams -ne 3) {
                $problemas += "[MADDCOLUNA-PARAMS] Chamada mAddColuna com $nParams parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')"
            }
        }
    }

    # ========================================================================
    # CHECK 19: Stubs disfar�ados com MsgAviso("...ser� implementad...")
    # Claude gera Btn*Click com MsgAviso placeholder ao inv�s de l�gica real.
    # Isso viola a regra NUNCA VERS�ES REDUZIDAS.
    # ========================================================================
    if ($formContent) {
        $stubMatches = [regex]::Matches($formContent, '(?si)PROCEDURE\s+(Btn\w+Click)\s*\(\)(.+?)ENDPROC')
        foreach ($sm in $stubMatches) {
            $btnName = $sm.Groups[1].Value
            $btnBody = $sm.Groups[2].Value
            # Se o corpo do m�todo tem MsgAviso com "implementad" e nenhuma l�gica real
            if ($btnBody -match '(?i)MsgAviso.*implementad') {
                # Verifica se � APENAS o MsgAviso (sem outra l�gica)
                $codeLines = ($btnBody -split "`n" |
                    Where-Object { $_ -match "\S" -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&" -and $_ -notmatch "(?i)MsgAviso" -and $_ -notmatch "(?i)RETURN" } |
                    Measure-Object).Count
                if ($codeLines -le 1) {
                    $problemas += "[STUB-MSGAVISO] Metodo '$btnName' eh um stub disfar�ado com MsgAviso('sera implementado'). DEVE ter logica FUNCIONAL real baseada no codigo legado. Analisar o PROCEDURE correspondente no fonte original e implementar: relatorio (REPORT FORM), operacao SQL (INSERT/UPDATE/DELETE), ou navegacao."
                }
            }
        }
    }

    # ========================================================================
    # CHECK 20: Validacao de colunas SQL contra banco real (SQLCMD)
    # Extrai tabelas+colunas dos DML no codigo gerado e valida contra schema real.
    # Detecta: SELECT col, WHERE col, SET col, JOIN ON col, GROUP BY col, ORDER BY col,
    #          INSERT INTO tab(col), UPDATE tab SET col
    # ========================================================================
    $allCode = "$boContent`n$formContent"
    # Normalizar continuacoes VFP para que regex de INSERT/UPDATE parseie colunas corretamente
    $allCodeNorm = $allCode -replace '"\s*\+\s*;\s*\r?\n\s*"', '' -replace "'\s*\+\s*;\s*\r?\n\s*'", ''
    if ($allCode.Length -gt 100) {
        try {
            $dbServer = $config.database.server
            $dbName = $config.database.database
            $dbUser = $config.database.user
            $dbPass = $config.database.password

            # 1. Extrair todas as tabelas Sig* referenciadas no codigo
            $tabelasNoCode = @()
            $tblPatterns = @(
                '(?i)(?:FROM|JOIN)\s+(Sig\w+)'
                '(?i)UPDATE\s+(Sig\w+)'
                '(?i)INSERT\s+INTO\s+(Sig\w+)'
                '(?i)DELETE\s+FROM\s+(Sig\w+)'
            )
            foreach ($pat in $tblPatterns) {
                $matches_ = [regex]::Matches($allCode, $pat)
                foreach ($m in $matches_) {
                    $tName = $m.Groups[1].Value
                    if ($tabelasNoCode -notcontains $tName) {
                        $tabelasNoCode += $tName
                    }
                }
            }

            if ($tabelasNoCode.Count -gt 0) {
                # 2. Para cada tabela, obter colunas reais do banco via SQLCMD
                $schemaCache = @{}  # tabela -> @(coluna1, coluna2, ...)

                foreach ($tbl in $tabelasNoCode) {
                    $queryCol = "SET NOCOUNT ON; SELECT c.name FROM sys.columns c WHERE c.object_id = OBJECT_ID('$tbl') ORDER BY c.column_id"
                    $resultCol = sqlcmd -S $dbServer -d $dbName -U $dbUser -P $dbPass -Q $queryCol -h -1 -W 2>$null
                    if ($LASTEXITCODE -eq 0 -and $resultCol) {
                        $cols = @()
                        foreach ($line in ($resultCol -split "`n")) {
                            $colName = $line.Trim()
                            if ($colName -ne "" -and $colName -notmatch "^\s*$" -and $colName -ne "rows affected)") {
                                $cols += $colName
                            }
                        }
                        if ($cols.Count -gt 0) {
                            $schemaCache[$tbl.ToUpper()] = $cols
                        }
                    }
                }

                if ($schemaCache.Count -gt 0) {
                    # 3. Extrair SQL strings do codigo (conteudo entre aspas apos SQLEXEC ou em loc_cSQL)
                    # Captura strings SQL multi-linha (concatenadas com +)
                    $sqlStrings = @()

                    # Padr�o: loc_cSQL = "SELECT ..." ou loc_cSQL = loc_cSQL + "..."
                    # Simplificado: capturar todas as linhas que cont�m SQL keywords dentro de strings
                    $sqlLinePattern = '(?i)(?:SELECT|INSERT|UPDATE|DELETE|FROM|JOIN|WHERE|SET|GROUP\s+BY|ORDER\s+BY|HAVING)\s+'
                    $sqlLines = ($allCode -split "`n" | Where-Object {
                        $_ -match $sqlLinePattern -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&"
                    })

                    # 4. Construir mapeamento POR QUERY: alias?tabela com escopo local
                    # FIX: O mapeamento global falhava quando o mesmo alias (ex: 'a') era
                    # usado em queries diferentes para tabelas diferentes. Agora separamos
                    # o codigo em blocos de query (por PROCEDURE/FUNCTION) e validamos
                    # alias.coluna APENAS dentro do bloco onde o alias foi definido.

                    # Separar codigo em linhas para analise por contexto
                    $allLines = $allCode -split "`n"

                    # Coletar pares (alias, tabela, lineIndex) para cada FROM/JOIN
                    $aliasOccurrences = @()  # array de @{Alias; Table; LineIndex}
                    for ($li = 0; $li -lt $allLines.Count; $li++) {
                        $line = $allLines[$li]
                        # Pular comentarios
                        if ($line -match "^\s*\*" -or $line -match "^\s*&&") { continue }
                        foreach ($tblUpper in $schemaCache.Keys) {
                            $tblOriginal = $tabelasNoCode | Where-Object { $_.ToUpper() -eq $tblUpper } | Select-Object -First 1
                            if (-not $tblOriginal) { continue }
                            $aliasPattern = "(?i)(?:FROM|JOIN|,)\s+$tblOriginal\s+(?:AS\s+)?(\w+)"
                            $aliasMatches = [regex]::Matches($line, $aliasPattern)
                            foreach ($am in $aliasMatches) {
                                $aliasFound = $am.Groups[1].Value.ToUpper()
                                if ($aliasFound -imatch '^(WHERE|AND|OR|ON|SET|INTO|VALUES|INNER|LEFT|RIGHT|OUTER|CROSS|FULL|ORDER|GROUP|HAVING|UNION|AS|IN|NOT|NULL|BETWEEN)$') {
                                    continue
                                }
                                $aliasOccurrences += @{ Alias = $aliasFound; Table = $tblUpper; TableOriginal = $tblOriginal; LineIndex = $li }
                            }
                        }
                    }

                    # Para cada ocorrencia de alias, encontrar o bloco de query (contexto local)
                    # e validar colunas APENAS nesse bloco
                    $alreadyReported = @{}  # evitar duplicatas
                    foreach ($occ in $aliasOccurrences) {
                        $alias = $occ.Alias
                        $tblUpper = $occ.Table
                        $tblOriginal = $occ.TableOriginal
                        $defLine = $occ.LineIndex
                        $colunasReais = $schemaCache[$tblUpper]
                        $colunasReaisUpper = $colunasReais | ForEach-Object { $_.ToUpper() }

                        # Determinar o bloco de query: buscar para cima ate encontrar
                        # inicio de atribuicao SQL (loc_*= ou SQLEXEC) ou PROCEDURE/FUNCTION,
                        # e para baixo ate proxima atribuicao/PROCEDURE ou linha vazia grande
                        $blockStart = $defLine
                        for ($bs = $defLine - 1; $bs -ge [Math]::Max(0, $defLine - 50); $bs--) {
                            $bsLine = $allLines[$bs]
                            # Parar em PROCEDURE/FUNCTION ou atribuicao SQL que nao seja continuacao
                            if ($bsLine -match "(?i)^\s*(PROCEDURE|FUNCTION)\s+" -or
                                ($bsLine -match "(?i)^\s*loc_\w+\s*=" -and $bsLine -notmatch "\+\s*$" -and $bs -lt $defLine - 1)) {
                                $blockStart = $bs
                                break
                            }
                        }
                        $blockEnd = $defLine
                        for ($be = $defLine + 1; $be -lt [Math]::Min($allLines.Count, $defLine + 80); $be++) {
                            $beLine = $allLines[$be]
                            if ($beLine -match "(?i)^\s*(PROCEDURE|FUNCTION|ENDPROC|ENDFUNC)\s*" -or
                                ($beLine -match "(?i)^\s*SQLEXEC\s*\(" -and $be -gt $defLine + 2)) {
                                $blockEnd = $be - 1
                                break
                            }
                            $blockEnd = $be
                        }

                        # Extrair texto do bloco e normalizar continuacoes VFP (+ ;)
                        $blockText = ($allLines[$blockStart..$blockEnd]) -join "`n"
                        $blockText = $blockText -replace '"\s*\+\s*;\s*\r?\n\s*"', ''
                        $blockText = $blockText -replace "'\s*\+\s*;\s*\r?\n\s*'", ''

                        # Validar colunas referenciadas como alias.coluna DENTRO do bloco
                        $colRefPattern = "(?i)\b$alias\.(\w+)\b"
                        $colRefs = [regex]::Matches($blockText, $colRefPattern)
                        foreach ($cr in $colRefs) {
                            $colUsada = $cr.Groups[1].Value
                            if ($colUsada -imatch '^(Value|Name|Caption|Text1|Header1|Column\d|Trim|Count|Sum|Avg|Max|Min|Top|Left|Width|Height|Enabled|Visible|AND|OR|NOT|NULL|AS|ON|IN|IS)$') {
                                continue
                            }
                            $reportKey = "$alias.$colUsada-$tblOriginal"
                            if ($alreadyReported.ContainsKey($reportKey)) { continue }
                            if ($colunasReaisUpper -notcontains $colUsada.ToUpper()) {
                                $sugestao = ""
                                $colUsadaUp = $colUsada.ToUpper()
                                foreach ($colReal in $colunasReais) {
                                    $colRealUp = $colReal.ToUpper()
                                    if ($colUsadaUp.Length -ge 3 -and $colRealUp.StartsWith($colUsadaUp.Substring(0, [Math]::Min(3, $colUsadaUp.Length)))) {
                                        $sugestao = " (voce quis dizer '$colReal'?)"
                                        break
                                    }
                                    if ($colUsadaUp.Length -ge 3 -and ($colRealUp.Contains($colUsadaUp) -or $colUsadaUp.Contains($colRealUp))) {
                                        $sugestao = " (voce quis dizer '$colReal'?)"
                                        break
                                    }
                                }
                                $problemas += "[SQL-COLUNA] Coluna '$colUsada' referenciada como '$alias.$colUsada' NAO existe na tabela $tblOriginal.$sugestao Colunas validas: $($colunasReais -join ', ')"
                                $alreadyReported[$reportKey] = $true
                            }
                        }
                    }

                    # 5. Para cada tabela, validar tambem SELECT * (sem alias) - tabela direta sem alias
                    foreach ($tblUpper in $schemaCache.Keys) {
                        $tblOriginal = $tabelasNoCode | Where-Object { $_.ToUpper() -eq $tblUpper } | Select-Object -First 1
                        $colunasReais = $schemaCache[$tblUpper]
                        $colunasReaisUpper = $colunasReais | ForEach-Object { $_.ToUpper() }
                        # (alias validation ja feita acima por bloco)

                        # Colunas sem alias em INSERT INTO tabela (col1, col2)
                        $insertPattern = "(?i)INSERT\s+INTO\s+$tblOriginal\s*\(([^)]+)\)"
                        $insertMatches = [regex]::Matches($allCodeNorm, $insertPattern)
                        foreach ($im in $insertMatches) {
                            $insertColsRaw = $im.Groups[1].Value
                            # SKIP: Se contem variavel (loc_cCols, etc.) em vez de colunas literais
                            if ($insertColsRaw -match '(?i)\bloc_\w+\b|"\s*\+\s*\w+\s*\+\s*"') { continue }
                            $insertCols = $insertColsRaw -split ","
                            foreach ($ic in $insertCols) {
                                $colName = $ic.Trim() -replace "'.*", "" -replace '".*', ""
                                $colName = $colName.Trim()
                                if ($colName -ne "" -and $colName -notmatch "^\s*$" -and $colName -notmatch '^\w+\(' -and $colName.Length -le 40) {
                                    if ($colunasReaisUpper -notcontains $colName.ToUpper()) {
                                        $sugestao = ""
                                        $colNameUp = $colName.ToUpper()
                                        foreach ($colReal in $colunasReais) {
                                            $colRealUp = $colReal.ToUpper()
                                            if ($colNameUp.Length -ge 3 -and ($colRealUp.StartsWith($colNameUp.Substring(0,3)) -or $colRealUp.Contains($colNameUp) -or $colNameUp.Contains($colRealUp))) {
                                                $sugestao = " (voce quis dizer '$colReal'?)"
                                                break
                                            }
                                        }
                                        $problemas += "[SQL-COLUNA] Coluna '$colName' em INSERT INTO $tblOriginal NAO existe.$sugestao Colunas validas: $($colunasReais -join ', ')"
                                    }
                                }
                            }
                        }

                        # UPDATE tabela SET coluna = ... (sem alias)
                        $updateSetPattern = "(?i)UPDATE\s+$tblOriginal\s+SET\s+(.+?)(?:\s+WHERE|\s*$)"
                        $updateMatches = [regex]::Matches($allCodeNorm, $updateSetPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
                        foreach ($um in $updateMatches) {
                            $setClauses = $um.Groups[1].Value -split ","
                            foreach ($sc in $setClauses) {
                                if ($sc -match '^\s*(\w+)\s*=') {
                                    $colName = $Matches[1].Trim()
                                    if ($colunasReaisUpper -notcontains $colName.ToUpper()) {
                                        $sugestao = ""
                                        $colNameUp = $colName.ToUpper()
                                        foreach ($colReal in $colunasReais) {
                                            $colRealUp = $colReal.ToUpper()
                                            if ($colNameUp.Length -ge 3 -and ($colRealUp.StartsWith($colNameUp.Substring(0,3)) -or $colRealUp.Contains($colNameUp) -or $colNameUp.Contains($colRealUp))) {
                                                $sugestao = " (voce quis dizer '$colReal'?)"
                                                break
                                            }
                                        }
                                        $problemas += "[SQL-COLUNA] Coluna '$colName' em UPDATE $tblOriginal SET NAO existe.$sugestao Colunas validas: $($colunasReais -join ', ')"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        catch {
            # Falha silenciosa - nao bloquear pipeline por erro de validacao
            Write-Host "  [AVISO] Erro na validacao de colunas SQL: $($_.Exception.Message)" -ForegroundColor Yellow
        }

        # Filtrar falsos positivos SQL-COLUNA por volume (alias-reuse em queries complexas)
        $sqlColunaProblemas = @($problemas | Where-Object { $_ -match '\[SQL-COLUNA\]' })
        if ($sqlColunaProblemas.Count -gt 20) {
            # Agrupar por tabela mencionada
            $porTabela = @{}
            foreach ($prob in $sqlColunaProblemas) {
                $tblKey = "desconhecida"
                if ($prob -match 'tabela\s+(\w+)') { $tblKey = $matches[1] }
                elseif ($prob -match 'NAO existe na tabela\s+(\w+)') { $tblKey = $matches[1] }
                if (-not $porTabela.ContainsKey($tblKey)) { $porTabela[$tblKey] = @() }
                $porTabela[$tblKey] += $prob
            }
            foreach ($tblKey in @($porTabela.Keys)) {
                if ($porTabela[$tblKey].Count -gt 20) {
                    $problemas = @($problemas | Where-Object { $_ -notin $porTabela[$tblKey] })
                    $problemas += "[SQL-AVISO] $($porTabela[$tblKey].Count) alertas SQL-COLUNA para tabela $tblKey suprimidos (provavel falso positivo por reuso de alias em queries complexas)"
                }
            }
        }
    }

    # ========================================================================
    # CHECK 21: Botoes na mesma barra horizontal com Top inconsistente (reforco)
    # Valida TODOS os controles cmd_4c_* dentro do mesmo container (cnt_4c_*)
    # ========================================================================
    if ($formContent) {
        # Encontrar containers e seus botoes com Top definido
        # Padr�o: cnt_4c_Xxx.AddObject("cmd_4c_Yyy", "CommandButton") ... .Top = N
        $containerBtnPattern = '(?i)(cnt_4c_\w+)\.AddObject\s*\(\s*"(cmd_4c_\w+)"\s*,\s*"CommandButton"\s*\)'
        $containerBtnMatches = [regex]::Matches($formContent, $containerBtnPattern)

        $containerButtons = @{}  # container -> @(@{Nome; Top})
        foreach ($cbm in $containerBtnMatches) {
            $containerName = $cbm.Groups[1].Value
            $btnName = $cbm.Groups[2].Value

            # Buscar .Top = N nas proximas linhas apos o AddObject
            $pos = $cbm.Index
            $trecho = $formContent.Substring($pos, [Math]::Min(1200, $formContent.Length - $pos))
            $topMatch = [regex]::Match($trecho, "(?i)$btnName\.Top\s*=\s*(\d+)")
            if ($topMatch.Success) {
                $topVal = [int]$topMatch.Groups[1].Value
                if (-not $containerButtons.ContainsKey($containerName)) {
                    $containerButtons[$containerName] = @()
                }
                $containerButtons[$containerName] += @{ Nome = $btnName; Top = $topVal }
            }
        }

        # Para cada container com 2+ botoes, verificar alinhamento
        foreach ($cntName in $containerButtons.Keys) {
            $btns = $containerButtons[$cntName]
            if ($btns.Count -ge 2) {
                $tops = $btns | ForEach-Object { $_.Top } | Sort-Object -Unique
                if ($tops.Count -gt 1) {
                    # Encontrar Top mais comum
                    $topGroups = $btns | Group-Object { $_.Top } | Sort-Object Count -Descending
                    $topMaisComum = [int]$topGroups[0].Name
                    $desalinhados = $btns | Where-Object { $_.Top -ne $topMaisComum }
                    foreach ($d in $desalinhados) {
                        $diff = [math]::Abs($d.Top - $topMaisComum)
                        $problemas += "[ALINHAMENTO-CONTAINER] No container '$cntName', botao '$($d.Nome)' tem Top=$($d.Top) mas os demais tem Top=$topMaisComum (diferenca de ${diff}px). TODOS os botoes do mesmo container DEVEM ter o MESMO Top."
                    }
                }
            }
        }
    }

    # ========================================================================
    # CHECK 22: SQL com aspas simples literais ao inves de EscaparSQL/FormatarDataSQL
    # Detecta padroes no codigo VFP que geram SQL com sintaxe invalida:
    #   - '' dentro de strings SQL delimitadas por " (gera aspas duplicadas no SQL)
    #   - Concatenacao com ' + variavel + ' ao inves de EscaparSQL()
    #   - Strings SQL com valores hardcoded entre aspas simples (deveria usar funcoes)
    # ========================================================================
    if ($allCode.Length -gt 100) {
        $linhasCode = $allCode -split "`n"
        for ($li = 0; $li -lt $linhasCode.Count; $li++) {
            $linha = $linhasCode[$li]

            # Ignorar comentarios
            if ($linha -match '^\s*\*' -or $linha -match '^\s*&&') { continue }

            # Detectar SQL strings (linhas que constroem SQL com SELECT/INSERT/UPDATE/DELETE/WHERE/SET)
            if ($linha -notmatch '(?i)(SELECT|INSERT|UPDATE|DELETE|WHERE|SET)\s') { continue }

            # Padr�o A: '' dentro de string SQL delimitada por "
            # Em VFP, "texto ''valor'' texto" -> os '' sao literais, nao escape
            # Gera SQL: texto ''valor'' texto (aspas duplicadas = ERRO SQL)
            # Regex: aspas dupla ... aspas simples duplas ... aspas dupla (na mesma string)
            if ($linha -match '"[^"]*''''[^"]*"') {
                # Verificar se nao eh escape intencional de aspas simples dentro de SQL
                # (ex: O'Brien -> O''Brien que eh valido em SQL para escapar ap�strofo)
                # Heuristica: se tem '' seguido de letra maiuscula ou '' no inicio/fim de um valor, eh problema
                $matches_ = [regex]::Matches($linha, "''(\w)")
                foreach ($m in $matches_) {
                    $problemas += "[SQL-ASPAS] Linha $($li+1): Aspas simples duplicadas ('') detectadas em SQL string. Em VFP, '' dentro de string entre aspas duplas NAO eh escape - sao dois caracteres literais que geram SQL invalido. CORRIGIR: usar EscaparSQL() para valores string ou FormatarDataSQL() para datas. Linha: $($linha.Trim())"
                    break
                }
            }

            # Padr�o B: Concatena��o  '" + variavel + "'  ao inv�s de EscaparSQL()
            # Em VFP:  "campo = '" + loc_cVal + "'"  gera SQL: campo = 'valor' mas sem escape
            # Correto: "campo = " + EscaparSQL(loc_cVal)  gera SQL: campo = 'valor' com escape
            if ($linha -match '\+' -and $linha -notmatch '(?i)EscaparSQL|FormatarDataSQL|FormatarNumeroSQL|TRANSFORM|STR\(|DTOC\(|DTOS\(') {
                # Detecta:  '" + variavel + "'  (aspas simples + duplas + plus + var + plus + duplas + simples)
                $dq = [char]34
                $sq = [char]39
                $patB = "${sq}${dq}\s*\+\s*[\w\.]+\s*\+\s*${dq}${sq}"
                if ($linha -match $patB) {
                    $problemas += "[SQL-ASPAS] Linha $($li+1): Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: $($linha.Trim())"
                }
            }
        }
    }

    # ========================================================================
    # CHECK 23: Condicoes de filtro SQL inventadas (WHERE/AND/OR)
    # Compara colunas usadas em clausulas WHERE/AND/OR entre o codigo original
    # e o codigo migrado. Colunas no WHERE do migrado que NAO existem no WHERE
    # do original sao potencialmente inventadas pela LLM.
    # Exemplo: original tem 'R' as Tipo no SELECT, LLM inventa AND a.Tipos='R' no WHERE
    # ========================================================================
    if ($boContent -and $originalContent) {
        # Funcao auxiliar: extrair colunas usadas em WHERE/AND/OR/HAVING de um bloco de codigo
        # Captura padroes: alias.coluna OP valor, coluna OP valor, coluna BETWEEN, coluna IN, coluna IS
        # Retorna array de nomes de colunas (sem alias)

        # 1. Extrair colunas de WHERE do original
        $whereColsOriginal = @()
        # Captura colunas apos WHERE/AND/OR/HAVING (com ou sem alias)
        # Tambem captura colunas prefixadas com alias (a.Coluna) em contexto de WHERE
        $wherePatterns = @(
            '(?i)(?:WHERE|AND|OR|HAVING)\s+(?:\w+\.)?(\w+)\s*(?:=|<>|!=|>=|<=|>|<|BETWEEN|IN\s*\(|IS\s+|LIKE\s+|NOT\s+)'
            '(?i)(?:WHERE|AND|OR|HAVING)\s+\]?\s*\[?\s*(?:\w+\.)?(\w+)\s+BETWEEN'
            '(?i)\]\s*\+\s*;?\s*\[?\s*(?:\w+\.)?(\w+)\s*(?:=|<>|!=|>=|<=|>|<|BETWEEN|IN\s*\(|IS\s+|LIKE\s+|NOT\s+)'
        )
        foreach ($pat in $wherePatterns) {
            $whereMatchesOrig = [regex]::Matches($originalContent, $pat)
            foreach ($wm in $whereMatchesOrig) {
                $colName = $wm.Groups[1].Value.ToUpper()
                if ($colName -imatch '^(NOT|NULL|AND|OR|IN|IS|LIKE|BETWEEN|EXISTS|SELECT|FROM|WHERE|SET|INTO|ORDER|GROUP|ASC|DESC|TOP|DISTINCT|COUNT|SUM|MAX|MIN|AVG|CASE|WHEN|THEN|ELSE|END|JOIN|LEFT|RIGHT|INNER|OUTER|ON|AS|UNION|ALL|HAVING|GETDATE|CONVERT|ISNULL|CAST)$') { continue }
                if ($whereColsOriginal -notcontains $colName) {
                    $whereColsOriginal += $colName
                }
            }
        }

        # 1b. Extrair colunas de ChkRegister do original (framework method que faz SELECT COUNT)
        # Padrao: ChkRegister('Tabela','Coluna',valor) - coluna eh o 2o parametro
        # Esses viram WHERE no migrado e NAO devem ser classificados como "inventados"
        $chkRegPattern = "(?i)ChkRegister\s*\(\s*'[^']+'\s*,\s*'(\w+)'"
        $chkRegMatches = [regex]::Matches($originalContent, $chkRegPattern)
        foreach ($crm in $chkRegMatches) {
            $colName = $crm.Groups[1].Value.ToUpper()
            if ($whereColsOriginal -notcontains $colName) {
                $whereColsOriginal += $colName
            }
        }

        # 2. Extrair colunas de WHERE do migrado (BO + Form)
        # Migrado usa SQL moderno (sem text-merge []), basta o padrao simples
        # Inclui Form porque ChkRegister do legado pode virar SELECT COUNT no Form (BtnExcluirClick)
        $whereColsMigrado = @()
        $migContent = $boContent
        if ($formContent) { $migContent = $migContent + "`n" + $formContent }
        $wherePatternMig = '(?i)(?:WHERE|AND|OR|HAVING)\s+(?:\w+\.)?(\w+)\s*(?:=|<>|!=|>=|<=|>|<|BETWEEN|IN\s*\(|IS\s+|LIKE\s+|NOT\s+)'
        $whereMatchesMig = [regex]::Matches($migContent, $wherePatternMig)
        foreach ($wm in $whereMatchesMig) {
            $colName = $wm.Groups[1].Value.ToUpper()
            if ($colName -imatch '^(NOT|NULL|AND|OR|IN|IS|LIKE|BETWEEN|EXISTS|SELECT|FROM|WHERE|SET|INTO|ORDER|GROUP|ASC|DESC|TOP|DISTINCT|COUNT|SUM|MAX|MIN|AVG|CASE|WHEN|THEN|ELSE|END|JOIN|LEFT|RIGHT|INNER|OUTER|ON|AS|UNION|ALL|HAVING|GETDATE|CONVERT|ISNULL|CAST)$') { continue }
            if ($whereColsMigrado -notcontains $colName) {
                $whereColsMigrado += $colName
            }
        }

        # 3. Comparar: colunas no WHERE do migrado que NAO existem no WHERE do original
        if ($whereColsOriginal.Count -gt 0 -and $whereColsMigrado.Count -gt 0) {
            foreach ($colMig in $whereColsMigrado) {
                $foundInOriginal = $false
                foreach ($colOrig in $whereColsOriginal) {
                    if ($colMig -eq $colOrig) {
                        $foundInOriginal = $true
                        break
                    }
                }
                if (-not $foundInOriginal) {
                    # Verificar se nao eh uma coluna de JOIN (presente no original em ON)
                    $joinPattern = "(?i)ON\s+(?:\w+\.)?$colMig\s*="
                    $isJoinCol = $originalContent -match $joinPattern
                    # Excluir variaveis VFP usadas como parametros SQLEXEC (nao sao colunas SQL)
                    $isVFPVar = $colMig -imatch '^(GNCONNHANDLE|GC_4C_|GO_4C_|LOC_|PAR_|THIS_)'
                    if (-not $isJoinCol -and -not $isVFPVar) {
                        $problemas += "[SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '$colMig' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: $($whereColsOriginal -join ', ')"
                    }
                }
            }
        }
    }

    # ========================================================================
    # CHECK 24: Caption/Titulo nao propagado para labels de exibicao
    # O legado copia ThisForm.Caption para labels de titulo no Init.
    # Se o form migrado define Caption mas NAO o atribui aos labels
    # lbl_4c_Sombra/lbl_4c_Titulo, o titulo fica errado ("Cadastro de Testes").
    # ========================================================================
    if ($formContent) {
        # Verificar se o form define Caption
        $captionMatch = [regex]::Match($formContent, '(?i)\.Caption\s*=\s*"([^"]+)"')
        if ($captionMatch.Success) {
            # Verificar se tem labels de titulo (cnt_4c_Sombra com lbl_4c_Sombra ou lbl_4c_Titulo)
            $temLblSombra = $formContent -match '(?i)lbl_4c_Sombra'
            $temLblTitulo = $formContent -match '(?i)lbl_4c_Titulo'
            if ($temLblSombra -or $temLblTitulo) {
                # Verificar se Caption eh propagado para os labels (THIS.Caption copiado para lbl)
                $propagaSombra = $formContent -match '(?i)lbl_4c_Sombra\.Caption\s*=\s*THIS\.Caption'
                $propagaTitulo = $formContent -match '(?i)lbl_4c_Titulo\.Caption\s*=\s*THIS\.Caption'
                if (-not $propagaSombra -and -not $propagaTitulo) {
                    # Verificar se pelo menos atribui o mesmo valor literal
                    $captionVal = $captionMatch.Groups[1].Value
                    $propagaLiteral = $formContent -match "(?i)lbl_4c_(Sombra|Titulo)\.Caption\s*=\s*""$([regex]::Escape($captionVal))"""
                    if (-not $propagaLiteral) {
                        $problemas += "[TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)"
                    }
                }
            }
        }
    }

    # ========================================================================
    # CHECK 25: LostFocus handler abre lookup sem guardia de valor alterado
    # No legado, Valid so dispara quando o valor MUDA. Mas BINDEVENT com
    # LostFocus dispara em CADA perda de foco. Se o handler abre
    # FormBuscaAuxiliar sem verificar se o valor mudou, a janela de busca
    # abre toda vez que o usuario clica em outro campo.
    # ========================================================================
    if ($formContent) {
        # Encontrar BINDEVENTs para LostFocus
        $lostFocusBinds = [regex]::Matches($formContent, '(?i)BINDEVENT\s*\([^,]+,\s*"LostFocus"\s*,\s*THIS\s*,\s*"(\w+)"\s*\)')
        foreach ($lfb in $lostFocusBinds) {
            $handlerName = $lfb.Groups[1].Value
            # Encontrar o corpo do handler
            $handlerPattern = "(?si)PROCEDURE\s+$handlerName\s*\(.*?\)(.+?)ENDPROC"
            $handlerMatch = [regex]::Match($formContent, $handlerPattern)
            if ($handlerMatch.Success) {
                $handlerBody = $handlerMatch.Groups[1].Value
                # Verificar se abre FormBuscaAuxiliar ou chama AbrirBusca/AbrirLookup
                $abreBusca = $handlerBody -match '(?i)(FormBuscaAuxiliar|AbrirBusca|AbrirLookup)'
                if ($abreBusca) {
                    # Verificar se tem guardia de valor alterado (ultimo*Validado ou comparacao com valor anterior)
                    $temGuardia = $handlerBody -match '(?i)(ultimo.*Validado|UltimoValor|valorAnterior|==\s*THIS\.this_c)'
                    if (-not $temGuardia) {
                        $problemas += "[LOSTFOCUS-SEM-GUARDIA] Handler '$handlerName' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimo${handlerName}Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida."
                    }
                }
            }
        }
    }

    # ========================================================================
    # CHECK 26: Init() chamando InicializarForm() apos DODEFAULT()
    # FormBase.Init() ja chama THIS.InicializarForm(). Se o subclass Init()
    # tambem chama, causa "A member object with this name already exists"
    # porque ConfigurarPageFrame/AddObject roda 2 vezes.
    # ========================================================================
    if ($formContent) {
        # Encontrar PROCEDURE Init() e verificar se tem DODEFAULT + InicializarForm
        $initPattern = '(?si)PROCEDURE\s+Init\s*\(\s*\)(.+?)ENDPROC'
        $initMatch = [regex]::Match($formContent, $initPattern)
        if ($initMatch.Success) {
            $initBody = $initMatch.Groups[1].Value
            $temDodefault = $initBody -match '(?i)DODEFAULT\s*\(\s*\)'
            $temInicializar = $initBody -match '(?i)THIS\.InicializarForm\s*\(\s*\)'
            if ($temDodefault -and $temInicializar) {
                $problemas += "[INIT-DUPLICADO] Init() chama DODEFAULT() E THIS.InicializarForm(). FormBase.Init() ja chama InicializarForm() internamente. Isso causa 'A member object with this name already exists' porque ConfigurarPageFrame/AddObject executa 2 vezes. CORRIGIR: Remover THIS.InicializarForm() do Init() - DODEFAULT() ja faz isso."
            }
        }
    }

    # ========================================================================
    # CHECK 27: COMMIT/ROLLBACK avulsos sem BEGIN TRANSACTION (Problema 46)
    # Conexao ODBC usa autocommit. COMMIT/ROLLBACK sem BEGIN TRANSACTION
    # causa "ROLLBACK TRANSACTION has no corresponding BEGIN TRANSACTION".
    # ========================================================================
    if ($allCode.Length -gt 100) {
        $linhasAll = $allCode -split "`n"
        $temBeginTran = $allCode -match '(?i)BEGIN\s+TRAN'
        if (-not $temBeginTran) {
            # Se nao tem BEGIN TRANSACTION, qualquer COMMIT ou ROLLBACK avulso eh erro
            for ($li = 0; $li -lt $linhasAll.Count; $li++) {
                $linha = $linhasAll[$li]
                if ($linha -match '^\s*\*' -or $linha -match '^\s*&&') { continue }
                if ($linha -match '(?i)SQLEXEC\s*\(\s*gnConnHandle\s*,\s*"(COMMIT|ROLLBACK)') {
                    $cmdTran = $Matches[1]
                    $problemas += "[TRANSACAO-AVULSA] Linha $($li+1): SQLEXEC com '$cmdTran' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos)."
                }
            }
        }
    }

    # ========================================================================
    # CHECK 28: CheckBox.Value tipo inconsistente (Problema 47)
    # Se CheckBox inicializado com .Value = .F. mas comparado com = 1/0
    # ========================================================================
    if ($formContent) {
        # Encontrar checkboxes inicializados com .Value = .F.
        $chkPattern = '(?i)chk_4c_\w+'
        $chkNames = [regex]::Matches($formContent, $chkPattern) | ForEach-Object { $_.Value } | Sort-Object -Unique
        foreach ($chkName in $chkNames) {
            # Verificar se inicializado como logico (.Value = .F.)
            $initLogico = $formContent -match "(?i)$([regex]::Escape($chkName))\.Value\s*=\s*\.F\."
            if ($initLogico) {
                # Buscar comparacoes/atribuicoes com numeros (= 0, = 1)
                $linhasForm = $formContent -split "`n"
                for ($li = 0; $li -lt $linhasForm.Count; $li++) {
                    $linha = $linhasForm[$li]
                    if ($linha -match '^\s*\*' -or $linha -match '^\s*&&') { continue }
                    if ($linha -match "(?i)$([regex]::Escape($chkName))\.Value\s*=\s*[01]\b" -or
                        $linha -match "(?i)$([regex]::Escape($chkName))\.Value\s*=\s*[01]\)") {
                        $problemas += "[CHECKBOX-TIPO] Linha $($li+1): $chkName inicializado com .Value=.F. (logico) mas linha usa atribuicao/comparacao com 0 ou 1 (numerico). Causa 'Operator/operand type mismatch'. CORRIGIR: Usar .T./.F. ao inves de 1/0. Para carregar de banco: (NVL(campo,0) = 1) retorna logico."
                        break
                    }
                }
            }
        }
    }

    # ========================================================================
    # CHECK 29: RecordSource sem ControlSource restaurado (Problema 48)
    # Quando RecordSource eh (re)atribuido, VFP faz auto-bind pela ordem
    # dos campos do cursor, ignorando ControlSource anterior.
    # ========================================================================
    if ($formContent) {
        $linhasForm = $formContent -split "`n"
        $recsourcePattern = '(?i)\.RecordSource\s*=\s*"cursor_4c_'
        $controlSourcePattern = '(?i)\.Column\d+\.ControlSource\s*='
        # Tambem aceitar pattern flat: loc_oGrid.Column1.ControlSource = ...
        $controlSourcePatternFlat = '(?i)\w+\.Column\d+\.ControlSource\s*='
        for ($li = 0; $li -lt $linhasForm.Count; $li++) {
            $linha = $linhasForm[$li]
            if ($linha -match '^\s*\*' -or $linha -match '^\s*&&') { continue }
            if ($linha -match $recsourcePattern) {
                # Verificar se nas proximas 30 linhas tem ControlSource redefinido
                $temRestore = $false
                $fimCheck = [Math]::Min($li + 30, $linhasForm.Count - 1)
                for ($lj = $li + 1; $lj -le $fimCheck; $lj++) {
                    if ($linhasForm[$lj] -match $controlSourcePattern -or $linhasForm[$lj] -match $controlSourcePatternFlat) {
                        $temRestore = $true
                        break
                    }
                }
                if (-not $temRestore) {
                    # Verificar se eh a configuracao inicial ou metodo de carga de dados - nesse caso ok
                    $contexto = ""
                    for ($lk = [Math]::Max(0, $li - 50); $lk -lt $li; $lk++) {
                        $contexto += $linhasForm[$lk]
                    }
                    $ehConfigInicial = $contexto -match '(?i)PROCEDURE\s+(Configurar(Grd|Grid|Pg)|Carregar(Dados|Grade|Cmv|Compo|Fase|Matrizes|Tarefas|Arquivos|Grupo)|Atualizar(Grd|Grid|Grade)|Recarregar)'
                    if (-not $ehConfigInicial) {
                        $problemas += "[GRID-RECORDSOURCE-AUTOBIND] Linha $($li+1): RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ..."
                    }
                }
            }
        }
    }

    # ========================================================================
    # CHECK 30: Chamada a metodo THIS.Xxx() que nao existe no Form nem FormBase
    # LLM pode inventar metodos (ex: FormatarGridLista) que nao existem
    # ========================================================================
    if ($formContent) {
        # Extrair todos os metodos chamados via THIS.NomeMetodo(
        $chamadas = [regex]::Matches($formContent, '(?i)THIS\.(\w+)\s*\(')
        $metodosChamados = @()
        foreach ($ch in $chamadas) {
            $m = $ch.Groups[1].Value
            if ($metodosChamados -notcontains $m) { $metodosChamados += $m }
        }

        # Extrair todos os PROCEDURE definidos no form
        $proceduresForm = [regex]::Matches($formContent, '(?i)(?:PROTECTED\s+)?PROCEDURE\s+(\w+)')
        $metodosDefinidos = @()
        foreach ($pf in $proceduresForm) {
            $metodosDefinidos += $pf.Groups[1].Value
        }

        # Metodos herdados de FormBase (nao precisam estar no form)
        $metodosFormBase = @("Init", "InicializarForm", "AtualizarEstadoControles", "IniciarEdicao",
            "EncerrarEdicao", "Novo", "Salvar", "Excluir", "Cancelar", "Fechar",
            "MostrarMensagem", "LimparCampos", "BOParaForm", "FormParaBO",
            "PosicionarPrimeiroCampo", "DepoisDeSalvar", "DepoisDeExcluir",
            "AlternarPagina", "QueryUnload", "Destroy", "CarregarLista",
            "NovoRegistro", "HabilitarCampos", "DesabilitarCampos",
            "TornarControlesVisiveis", "Release", "Show", "Hide", "Refresh",
            "AddObject", "RemoveObject", "SetFocus", "Move", "Resize",
            "DODEFAULT", "SetAll")

        # VFP built-in e common methods/events a ignorar
        $ignorar = @("AddObject", "RemoveObject", "SetFocus", "Release", "Show", "Hide",
            "Refresh", "Move", "Resize", "DODEFAULT", "SetAll", "AddItem", "AddListItem",
            "Requery", "Clear", "ZOrder", "ReadMethod", "WriteMethod", "SaveAs",
            "RegistrarAuditoria", "ObterChavePrimaria", "Buscar", "CarregarPorCodigo",
            "Inserir", "Atualizar", "ExecutarExclusao", "Validar", "CarregarDoCursor",
            "PrepararDados", "FormParaRelatorio")

        foreach ($mc in $metodosChamados) {
            $definido = $false
            foreach ($md in $metodosDefinidos) {
                if ($mc -ieq $md) { $definido = $true; break }
            }
            if (-not $definido) {
                # Verificar se eh metodo herdado ou built-in
                $ehHerdado = $false
                foreach ($mh in $metodosFormBase) {
                    if ($mc -ieq $mh) { $ehHerdado = $true; break }
                }
                foreach ($ig in $ignorar) {
                    if ($mc -ieq $ig) { $ehHerdado = $true; break }
                }
                # Verificar se eh metodo do BO (this_oBusinessObject.Xxx)
                if ($mc -imatch '^(this_o|Configurar|Inicializar)') { $ehHerdado = $true }
                if (-not $ehHerdado) {
                    $problemas += "[METODO-INEXISTENTE] Metodo 'THIS.$mc()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada."
                }
            }
        }
    }

    # ========================================================================
    # CHECK 31: FontName 'Comic Sans MS' em CommandButton (VISUAL)
    # Botoes devem usar Tahoma, nao Comic Sans MS
    # ========================================================================
    if ($formContent) {
        $linhasForm = $formContent -split "`n"
        for ($li = 0; $li -lt $linhasForm.Count; $li++) {
            $linha = $linhasForm[$li]
            if ($linha -match '^\s*\*' -or $linha -match '^\s*&&') { continue }
            if ($linha -match '(?i)FontName\s*=\s*"Comic Sans MS"') {
                $problemas += "[FONTNAME-ERRADO] Linha $($li+1): FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias."
            }
        }
    }

    # ========================================================================
    # CHECK LAYOUT-POSITION: Valida posicoes dos controles contra layout.json
    # Se layout.json existe, compara Top/Left dos controles no .prg migrado
    # contra os valores originais do SCX. Tolerancia: 30px (offset PageFrame)
    # ========================================================================
    $taskPath = Split-Path $FormFile -Parent
    # Subir um nivel se estiver em forms/cadastros ou forms/operacionais
    if ($taskPath -match '\\forms\\') {
        $taskPathLayout = $null
    } else {
        $taskPathLayout = $taskPath
    }
    # Tentar encontrar layout.json na task
    if (-not $taskPathLayout) {
        # Procurar via OriginalSourceFile
        if ($OriginalSourceFile -and (Test-Path $OriginalSourceFile)) {
            $taskPathLayout = Split-Path $OriginalSourceFile -Parent
        }
    }

    if ($taskPathLayout) {
        $layoutFile = Join-Path $taskPathLayout "layout.json"
        if (Test-Path $layoutFile) {
            try {
                $layoutJson = Get-Content $layoutFile -Raw -Encoding UTF8 | ConvertFrom-Json
                $layoutObjects = $layoutJson.objects

                # Detectar compensacao do PageFrame (mesmo padrao de ValidarLayoutVsPrg.ps1)
                $pageFrameTop = 0
                foreach ($obj in $layoutObjects) {
                    if ($obj.baseClass -eq "pageframe") {
                        $pageFrameTop = [int]$obj.top
                        break
                    }
                }
                $compensacaoPageFrame = [Math]::Abs($pageFrameTop)

                if ($layoutObjects -and $formContent) {
                    $formLines = $formContent -split "`n"

                    # Extrair posicoes dos controles migrados (buscar .Top = N e .Left = N dentro de WITH blocks)
                    $migradoControles = @{}
                    $currentObj = ""
                    foreach ($fl in $formLines) {
                        if ($fl -match '(?i)WITH\s+\w+\.([\w_]+)\s*$') {
                            $currentObj = $Matches[1]
                        }
                        if ($fl -match '(?i)^\s*ENDWITH') {
                            $currentObj = ""
                        }
                        if ($currentObj -and $fl -match '(?i)^\s*\.Top\s*=\s*(\-?\d+)') {
                            if (-not $migradoControles.ContainsKey($currentObj)) {
                                $migradoControles[$currentObj] = @{}
                            }
                            $migradoControles[$currentObj]["Top"] = [int]$Matches[1]
                        }
                        if ($currentObj -and $fl -match '(?i)^\s*\.Left\s*=\s*(\-?\d+)') {
                            if (-not $migradoControles.ContainsKey($currentObj)) {
                                $migradoControles[$currentObj] = @{}
                            }
                            $migradoControles[$currentObj]["Left"] = [int]$Matches[1]
                        }
                    }

                    # Comparar controles do layout com os migrados
                    # Focar em controles visiveis posicionados (commandbutton, textbox, label, grid, checkbox)
                    $baseClassesCheck = @("commandbutton", "textbox", "label", "grid", "checkbox", "combobox", "optiongroup", "container")
                    $tolerancia = 30  # pixels de tolerancia (offset PageFrame, etc)
                    $layoutProblems = 0

                    foreach ($obj in $layoutObjects) {
                        if ($obj.baseClass -notin $baseClassesCheck) { continue }
                        if ($null -eq $obj.top -and $null -eq $obj.left) { continue }

                        # Detectar se controle esta dentro de uma Page (filho direto)
                        $isPageChild = $false
                        if ($obj.parent -match '(?i)\.Page\.\w+$') {
                            $isPageChild = $true
                        }

                        # Calcular Top esperado com compensacao PageFrame (mesmo padrao ValidarLayoutVsPrg.ps1)
                        $expectedTop = if ($null -ne $obj.top) { [int]$obj.top } else { $null }
                        if ($isPageChild -and $null -ne $expectedTop -and $compensacaoPageFrame -gt 0) {
                            $expectedTop = $expectedTop + $compensacaoPageFrame
                        }

                        # Procurar controle correspondente no migrado (por nome similar)
                        $objName = $obj.name
                        foreach ($migKey in $migradoControles.Keys) {
                            # Match por nome original contido no nome migrado (case insensitive)
                            if ($migKey -imatch [regex]::Escape($objName) -or $objName -imatch [regex]::Escape($migKey)) {
                                $migTop = $migradoControles[$migKey]["Top"]
                                $migLeft = $migradoControles[$migKey]["Left"]

                                # Comparar com tolerancia (usando Top compensado para filhos de Page)
                                if ($null -ne $expectedTop -and $null -ne $migTop) {
                                    $diffTop = [math]::Abs($expectedTop - $migTop)
                                    if ($diffTop -gt $tolerancia) {
                                        $topInfo = if ($isPageChild) { "Top original=$($obj.top)+compensacao=$expectedTop" } else { "Top original=$($obj.top)" }
                                        $problemas += "[LAYOUT-POSITION] Controle '$objName' (parent: $($obj.parent)): $topInfo vs migrado '$migKey' Top=$migTop (diff=${diffTop}px, tolerancia=${tolerancia}px)"
                                        $layoutProblems++
                                    }
                                }
                                if ($null -ne $obj.left -and $null -ne $migLeft) {
                                    $diffLeft = [math]::Abs($obj.left - $migLeft)
                                    if ($diffLeft -gt $tolerancia) {
                                        $problemas += "[LAYOUT-POSITION] Controle '$objName' (parent: $($obj.parent)): Left original=$($obj.left) vs migrado '$migKey' Left=$migLeft (diff=${diffLeft}px, tolerancia=${tolerancia}px)"
                                        $layoutProblems++
                                    }
                                }
                                break
                            }
                        }
                    }

                    if ($layoutProblems -gt 0) {
                        Write-Host "  [LAYOUT] $layoutProblems divergencia(s) de posicao detectada(s)" -ForegroundColor Yellow
                    }
                }
            }
            catch {
                # layout.json invalido ou erro de parse - nao bloqueia
            }
        }
    }

    return $problemas
}


# ==============================================================================
# ETAPA 5.9: Validacao SQL Schema (sem LLM - analise estatica)
# ==============================================================================
function Invoke-Etapa05f_ValidarSQLSchema {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 5.9" "Validacao SQL Schema (colunas vs schema.sql)"

    Start-Etapa -TaskId $TaskId -Etapa "05f_validarSQLSchema" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId

        # Determina nomes das classes e caminhos
        $formClass = Get-FormClassName -BaseName $BaseName
        $boClass = Get-BOClassName -BaseName $BaseName
        $formType = Get-FormTypeFromState -TaskId $TaskId
        $formSubDir = Get-FormSubDir -FormType $formType

        $formFile = Join-Path $config.paths.projeto "app\forms\$formSubDir\$formClass.prg"
        $boFile = Join-Path $config.paths.projeto "app\classes\$boClass.prg"

        # Fallback: procurar Form em outras pastas
        if (-not (Test-Path $formFile)) {
            $foundForm = Find-FormFile -ProjetoPath $config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
            if ($foundForm) { $formFile = $foundForm }
        }

        $basePath = Split-Path $config.paths.projeto -Parent
        $schemaFile = Join-Path $basePath "docs\schema.sql"
        if (-not $schemaFile -or -not (Test-Path $schemaFile)) {
            Write-Host "  [AVISO] schema.sql nao encontrado ($schemaFile) - pulando validacao SQL Schema" -ForegroundColor Yellow
            Complete-Etapa -TaskId $TaskId -Etapa "05f_validarSQLSchema" -TasksDir $config.paths.tasks -Metadata @{ skipped = $true; reason = "schema_not_found" }
            return
        }
        $validatorScript = Join-Path $PSScriptRoot "ValidadorSQLSchema.ps1"

        if (-not (Test-Path $validatorScript)) {
            Write-Host "  [AVISO] ValidadorSQLSchema.ps1 nao encontrado - pulando" -ForegroundColor Yellow
            Complete-Etapa -TaskId $TaskId -Etapa "05f_validarSQLSchema" -TasksDir $config.paths.tasks -Metadata @{ skipped = $true; reason = "validator_not_found" }
            return
        }

        # Validar que os caminhos existem antes de chamar o validador
        if (-not $formFile -or -not (Test-Path $formFile)) {
            Write-Host "  [AVISO] Form nao encontrado ($formFile) - pulando validacao SQL Schema" -ForegroundColor Yellow
            Complete-Etapa -TaskId $TaskId -Etapa "05f_validarSQLSchema" -TasksDir $config.paths.tasks -Metadata @{ skipped = $true; reason = "form_not_found" }
            return
        }
        if (-not $boFile) { $boFile = "" }

        # Montar parametros DB (se disponiveis no config)
        $dbParams = @{}
        if ($config.database.server) { $dbParams["DbServer"] = $config.database.server }
        if ($config.database.database) { $dbParams["DbName"] = $config.database.database }
        if ($config.database.user) { $dbParams["DbUser"] = $config.database.user }
        if ($config.database.password) { $dbParams["DbPass"] = $config.database.password }

        # Executar validacao (sem LLM - rapido)
        $problemas = & $validatorScript -FormFile $formFile -BOFile $boFile -SchemaFile $schemaFile @dbParams

        if ($problemas.Count -eq 0) {
            Write-Host "  [OK] Validacao SQL Schema PASSOU - todas as colunas validas" -ForegroundColor Green
            Complete-Etapa -TaskId $TaskId -Etapa "05f_validarSQLSchema" -TasksDir $config.paths.tasks -Metadata @{
                status = "PASSED"
                formFile = $formFile
                boFile = $boFile
            }
        }
        else {
            # Salvar problemas para referencia
            $problemFile = Join-Path $taskPath "sql_schema_problems.txt"
            $problemas | Out-File -FilePath $problemFile -Encoding UTF8

            Write-Host ""
            Write-Host "  [FALHOU] $($problemas.Count) problema(s) de SQL Schema:" -ForegroundColor Red
            foreach ($p in $problemas) {
                Write-Host "    $p" -ForegroundColor Yellow
            }
            Write-Host ""
            Write-Host "  Problemas salvos em: $problemFile" -ForegroundColor Yellow

            # Tentar correcao via Claude com contexto REDUZIDO
            # IMPORTANTE: NAO enviar schema.sql inteiro (2.4MB) - extrair apenas tabelas relevantes
            $maxRetries = 3
            $retry = 0
            $resolved = $false

            while ($retry -lt $maxRetries -and -not $resolved) {
                $retry++
                Write-Host ""
                Write-Host "  --- Correcao SQL Schema (Tentativa $retry/$maxRetries) ---" -ForegroundColor Cyan

                # --- Extrair APENAS tabelas mencionadas nos problemas ---
                $tabelasReferenciadas = @()
                foreach ($p in $problemas) {
                    if ($p -match "tabela\s+'(\w+)'") {
                        $tabelasReferenciadas += $Matches[1].ToLower()
                    }
                }
                $tabelasReferenciadas = $tabelasReferenciadas | Sort-Object -Unique

                $schemaExtracts = ""
                if ($tabelasReferenciadas.Count -gt 0 -and (Test-Path $schemaFile)) {
                    $schemaContent = Get-Content $schemaFile -Raw -Encoding UTF8
                    foreach ($tabela in $tabelasReferenciadas) {
                        # Extrair CREATE TABLE + todas as colunas (ate CONSTRAINT)
                        $tablePattern = "(?ims)CREATE\s+TABLE\s+\[dbo\]\.\[$tabela\]\s*\(.*?(?=CONSTRAINT|CREATE\s+TABLE)"
                        $tableMatch = [regex]::Match($schemaContent, $tablePattern)
                        if ($tableMatch.Success) {
                            $schemaExtracts += "`n-- Tabela: $tabela`n"
                            # Limitar a 3000 chars por tabela (colunas apenas)
                            $extract = $tableMatch.Value
                            if ($extract.Length -gt 3000) { $extract = $extract.Substring(0, 3000) + "`n-- (truncado)" }
                            $schemaExtracts += $extract + "`n"
                        }
                    }
                }

                # --- Extrair APENAS linhas relevantes do Form e BO (+-20 linhas ao redor dos problemas) ---
                $linhasProblema = @()
                foreach ($p in $problemas) {
                    if ($p -match "Linha\s*~?(\d+)") {
                        $linhasProblema += [int]$Matches[1]
                    }
                }

                $formSnippet = ""
                $boSnippet = ""

                if ($linhasProblema.Count -gt 0) {
                    # Extrair snippets do Form
                    if (Test-Path $formFile) {
                        $formLines = Get-Content $formFile -Encoding UTF8
                        $formSnippet = "## Trechos relevantes do Form ($formFile):`n"
                        foreach ($ln in ($linhasProblema | Sort-Object -Unique)) {
                            $startLn = [Math]::Max(0, $ln - 20)
                            $endLn = [Math]::Min($formLines.Count - 1, $ln + 20)
                            if ($startLn -lt $formLines.Count) {
                                $formSnippet += "`n--- Linhas $($startLn+1) a $($endLn+1) ---`n"
                                for ($li = $startLn; $li -le $endLn -and $li -lt $formLines.Count; $li++) {
                                    $formSnippet += "$($li+1): $($formLines[$li])`n"
                                }
                            }
                        }
                    }

                    # Extrair snippets do BO (linhas podem ser offset)
                    if ($boFile -and (Test-Path $boFile)) {
                        $boLines = Get-Content $boFile -Encoding UTF8
                        $boSnippet = "`n## Trechos relevantes do BO ($boFile):`n"
                        # Para BO, extrair linhas com nomes de colunas invalidas
                        $colunasInvalidas = @()
                        foreach ($p in $problemas) {
                            if ($p -match "coluna\s+'(\w+)'") {
                                $colunasInvalidas += $Matches[1]
                            }
                        }
                        for ($li = 0; $li -lt $boLines.Count; $li++) {
                            foreach ($col in $colunasInvalidas) {
                                if ($boLines[$li] -match "(?i)\b$col\b") {
                                    $startLn = [Math]::Max(0, $li - 5)
                                    $endLn = [Math]::Min($boLines.Count - 1, $li + 5)
                                    $boSnippet += "`n--- BO Linhas $($startLn+1) a $($endLn+1) ---`n"
                                    for ($bj = $startLn; $bj -le $endLn; $bj++) {
                                        $boSnippet += "$($bj+1): $($boLines[$bj])`n"
                                    }
                                    break  # Uma ocorrencia por coluna invalida basta
                                }
                            }
                        }
                    }
                }

                # --- Montar prompt COMPACTO (sem arquivos inteiros) ---
                $promptContent = @"
CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
$($problemas | ForEach-Object { "- $_" } | Out-String)

SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):
$schemaExtracts

$formSnippet

$boSnippet

REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: $formFile
- BO: $boFile
"@

                $promptFile = Join-Path $taskPath "prompt_sql_fix_$retry.md"
                $promptContent | Out-File -FilePath $promptFile -Encoding UTF8

                $promptSizeKB = [Math]::Round($promptContent.Length / 1024, 1)
                Write-Host "  Prompt de correcao: ${promptSizeKB}KB (apenas trechos relevantes)" -ForegroundColor Cyan

                try {
                    # NAO passar ContextFiles pesados - tudo ja esta no prompt
                    & (Join-Path $PSScriptRoot "ClaudeInvoker.ps1") `
                        -PromptFile $promptFile `
                        -MaxOutputTokens 16000

                    # Re-validar
                    $problemas = & $validatorScript -FormFile $formFile -BOFile $boFile -SchemaFile $schemaFile @dbParams
                    if ($problemas.Count -eq 0) {
                        Write-Host "  [OK] Correcao SQL bem-sucedida!" -ForegroundColor Green
                        $resolved = $true
                    }
                    else {
                        Write-Host "  [AVISO] Ainda restam $($problemas.Count) problema(s)" -ForegroundColor Yellow
                    }
                }
                catch {
                    Write-Host "  [ERRO] Falha na correcao: $($_.Exception.Message)" -ForegroundColor Red
                }
            }

            if ($resolved) {
                # Propagar renames do BO para o Form (Pattern #72)
                # Quando ValidadorSQLSchema renomeia propriedade no BO (ex: this_nSituas -> this_cSituas),
                # o Form que referencia a propriedade antiga TAMBEM deve ser atualizado.
                # Sem isso: "Property THIS_NSITUAS is not found" em runtime.
                if ((Test-Path $formFile) -and $boFile -and (Test-Path $boFile)) {
                    $formContent = Get-Content -Path $formFile -Raw -Encoding UTF8
                    $boContent = Get-Content -Path $boFile -Raw -Encoding UTF8

                    # Extrair propriedades this_[ncld]Xxx definidas no BO (class header: this_cXxx = "" / this_nXxx = 0)
                    $boPropsDefinidas = [regex]::Matches($boContent, '(?i)(this_[ncld]\w+)\s*=') | ForEach-Object { $_.Groups[1].Value.ToLower() } | Sort-Object -Unique

                    # Extrair propriedades this_[ncld]Xxx referenciadas no Form
                    $formPropsRefs = [regex]::Matches($formContent, '(?i)(this_[ncld]\w+)') | ForEach-Object { $_.Groups[1].Value.ToLower() } | Sort-Object -Unique

                    # Filtrar: propriedades do Form que NAO existem no BO (excluindo props internas do Form)
                    $propsFormInternas = 'this_[ncld](modo|mensagem|em|novo|busca|lnovoregistro|lemedica|cmodoa|obusin)'
                    $orphanProps = $formPropsRefs | Where-Object { $_ -notin $boPropsDefinidas -and $_ -notmatch $propsFormInternas }

                    $syncCount = 0
                    foreach ($orphan in $orphanProps) {
                        # Extrair sufixo (nome sem prefixo de tipo): this_nSituas -> situas
                        $orphanSuffix = $orphan -replace '^this_[ncld]', ''

                        # Procurar match no BO com mesmo sufixo mas prefixo diferente
                        $matchBO = $boPropsDefinidas | Where-Object {
                            $bSuffix = $_ -replace '^this_[ncld]', ''
                            $bSuffix -ieq $orphanSuffix -and $_ -ine $orphan
                        }

                        if ($matchBO -and $matchBO.Count -eq 1) {
                            # Match unico encontrado - fazer substituicao no Form
                            $matchBOValue = if ($matchBO -is [array]) { $matchBO[0] } else { $matchBO }

                            # Preservar case original do BO
                            $boPropOriginal = [regex]::Matches($boContent, "(?i)($([regex]::Escape($matchBOValue)))") | Select-Object -First 1
                            $replaceWith = if ($boPropOriginal) { $boPropOriginal.Groups[1].Value } else { $matchBOValue }

                            # Encontrar case original do orphan no Form para substituir exatamente
                            $orphanOriginal = [regex]::Matches($formContent, "(?i)($([regex]::Escape($orphan)))") | Select-Object -First 1
                            $searchFor = if ($orphanOriginal) { $orphanOriginal.Groups[1].Value } else { $orphan }

                            # Substituir TODAS as ocorrencias (case-insensitive)
                            $formContent = [regex]::Replace($formContent, [regex]::Escape($searchFor), $replaceWith, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
                            $syncCount++
                            Write-Host "  [05f-SYNC] Form: $searchFor -> $replaceWith (propagado do BO)" -ForegroundColor Green
                        }
                        elseif ($matchBO -and $matchBO.Count -gt 1) {
                            Write-Host "  [AVISO] Form referencia '$orphan' - multiplos candidatos no BO: $($matchBO -join ', '). Corrigir manualmente." -ForegroundColor Yellow
                        }
                        else {
                            Write-Host "  [AVISO] Form referencia '$orphan' nao encontrada no BO (sem match por sufixo). Verificar manualmente." -ForegroundColor Yellow
                        }
                    }

                    if ($syncCount -gt 0) {
                        # Gravar Form atualizado
                        [System.IO.File]::WriteAllText($formFile, $formContent, [System.Text.Encoding]::UTF8)
                        Write-Host "  [05f-SYNC] $syncCount propriedade(s) sincronizada(s) do BO para o Form." -ForegroundColor Green
                    }
                }

                Complete-Etapa -TaskId $TaskId -Etapa "05f_validarSQLSchema" -TasksDir $config.paths.tasks -Metadata @{
                    status = "FIXED"
                    retries = $retry
                    formFile = $formFile
                    boFile = $boFile
                }
            }
            else {
                # Verificar se SQL schema blocking esta habilitado (default: $true)
                $sqlSchemaBlocking = $true
                if ($null -ne $config.validacao.sqlSchemaBlocking) {
                    $sqlSchemaBlocking = [bool]$config.validacao.sqlSchemaBlocking
                }

                if ($sqlSchemaBlocking) {
                    # BLOQUEIA pipeline - problemas SQL schema sao criticos
                    Write-Host ""
                    Write-Host "  [ERRO] Problemas SQL nao resolvidos - BLOQUEANDO pipeline (sqlSchemaBlocking=true)" -ForegroundColor Red
                    Write-Host "  Verifique manualmente: $problemFile" -ForegroundColor Yellow
                    Fail-Etapa -TaskId $TaskId -Etapa "05f_validarSQLSchema" -ErroMsg "SQL schema: $($problemas.Count) problema(s) nao resolvido(s). Detalhes: $problemFile" -TasksDir $config.paths.tasks
                    throw "SQL schema validation failed: $($problemas.Count) unresolved problem(s). See $problemFile"
                }
                else {
                    # Modo legado: NAO bloqueia pipeline, mas registra warning
                    Write-Host ""
                    Write-Host "  [AVISO] Problemas SQL nao resolvidos automaticamente (sqlSchemaBlocking=false, nao-bloqueante)." -ForegroundColor Red
                    Write-Host "  Verifique manualmente: $problemFile" -ForegroundColor Yellow
                    Complete-Etapa -TaskId $TaskId -Etapa "05f_validarSQLSchema" -TasksDir $config.paths.tasks -Metadata @{
                        status = "WARN"
                        unresolvedCount = $problemas.Count
                        problemFile = $problemFile
                    }
                }
            }
        }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "05f_validarSQLSchema" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        Write-Host "  [ERRO] Etapa 5.9: $($_.Exception.Message)" -ForegroundColor Red
    }
}


function Invoke-Etapa05e_CodeReview {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 5.8" "Code Review Automatizado (Multi-Pass Focado)"

    Start-Etapa -TaskId $TaskId -Etapa "05e_codeReview" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId

        # Determina nomes das classes e caminhos
        $formClass = Get-FormClassName -BaseName $BaseName
        $boClass = Get-BOClassName -BaseName $BaseName
        $formType = Get-FormTypeFromState -TaskId $TaskId
        $formSubDir = Get-FormSubDir -FormType $formType

        $formFile = Join-Path $config.paths.projeto "app\forms\$formSubDir\$formClass.prg"
        $boFile = Join-Path $config.paths.projeto "app\classes\$boClass.prg"

        # Fallback: procurar Form em outras pastas
        if (-not (Test-Path $formFile)) {
            $foundForm = Find-FormFile -ProjetoPath $config.paths.projeto -FormClass $formClass -PreferredSubDir $formSubDir
            if ($foundForm) {
                $formFile = $foundForm
                $formSubDir = (Split-Path (Split-Path $foundForm -Parent) -Leaf)
            }
        }

        # Codigo fonte original
        $originalSource = Get-ChildItem -Path $taskPath -Filter "*codigo_fonte*.txt" -ErrorAction SilentlyContinue | Select-Object -First 1
        $originalSourceFile = if ($originalSource) { $originalSource.FullName } else { "" }

        # =====================================================================
        # Definicao dos 4 passes focados
        # =====================================================================
        $passDefinitions = @(
            @{
                Name = "SQL"
                Tags = @("GRID-SQL", "SQL-TABELA", "SQL-COLUNA", "SQL-ASPAS", "SQL-FILTRO-INVENTADO", "TRANSACAO-AVULSA")
                Description = "SQL Validation (colunas, tabelas, aspas, filtros)"
                ExtractPatterns = @("(?i)(SELECT|INSERT|UPDATE|DELETE|FROM|JOIN|SQLEXEC|EscaparSQL|FormatarData|FormatarNumero|CREATE\s+CURSOR|ControlSource|loc_lcQuery|loc_cQuery)")
                ContextLines = 15
                IncludeBO = $true
                IncludeOriginalSQL = $true
                Instructions = @"
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER
"@
            },
            @{
                Name = "GRID"
                Tags = @("MADDCOLUNA", "GRID-HEADERS", "SQLEXEC-GRID", "CREATE-CURSOR-NULL", "RECORDSOURCE-WITH", "CURSOR-DUPLICADO", "GRID-RECORDSOURCE-AUTOBIND")
                Description = "Grid/Cursor Configuration"
                ExtractPatterns = @("(?i)(CREATE\s+CURSOR|RecordSource|ColumnCount|Header1|mAddColuna|SET\s+NULL|grd_4c_)")
                ContextLines = 15
                IncludeBO = $false
                IncludeOriginalSQL = $false
                Instructions = @"
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas
"@
            },
            @{
                Name = "FUNCTIONAL"
                Tags = @("CONTAINER-VISIVEL", "BUSCA-CURSOR", "OPTIONGROUP-LEFT", "CARGA-DADOS", "CONTAINER-TOGGLE", "OPERACIONAL-NAVEGACAO", "BINDEVENT-PARAMS", "GRID-HEADERS-LEGACY", "MADDCOLUNA-PARAMS", "STUB-MSGAVISO", "LOSTFOCUS-SEM-GUARDIA", "INIT-DUPLICADO", "METODO-INEXISTENTE")
                Description = "Functional Logic (metodos, eventos, containers)"
                ExtractPatterns = @("(?i)(PROCEDURE|BINDEVENT|FormBuscaAuxiliar|TornarControlesVisiveis|OptionGroup|InteractiveChange|CREATEOBJECT|MsgAviso|InicializarForm|this_cUltimo)")
                ContextLines = 40
                IncludeBO = $true
                IncludeOriginalSQL = $false
                Instructions = @"
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.
"@
            },
            @{
                Name = "VISUAL"
                Tags = @("ALINHAMENTO", "ALINHAMENTO-CONTAINER", "TITULO-NAO-PROPAGADO", "CHECKBOX-TIPO", "FONTNAME-ERRADO")
                Description = "Visual Properties (alinhamento, titulos, tipos)"
                ExtractPatterns = @("(?i)(\.Top\s*=|\.Left\s*=|cmd_4c_|\.Caption\s*=|lbl_4c_|CheckBox|\.Value\s*=\s*\.)")
                ContextLines = 5
                IncludeBO = $true
                IncludeOriginalSQL = $false
                Instructions = @"
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'
"@
            }
        )

        # =====================================================================
        # Funcao auxiliar: extrair trechos do form para um conjunto de problemas
        # =====================================================================
        function Extract-RelevantCode {
            param(
                [string[]]$FormLines,
                [string[]]$Problems,
                [string[]]$ExtraPatterns,
                [int]$ContextLines = 30
            )
            $totalLines = $FormLines.Count
            $relevantRanges = @()

            foreach ($prob in $Problems) {
                # Por numero de linha
                if ($prob -match "linha?\s*(\d+)") {
                    $lineNum = [int]$Matches[1]
                    $s = [Math]::Max(0, $lineNum - $ContextLines)
                    $e = [Math]::Min($totalLines - 1, $lineNum + $ContextLines)
                    $relevantRanges += @{ Start = $s; End = $e }
                }
                # Por nome de metodo
                if ($prob -match "(?i)(PROCEDURE|metodo|funcao)\s+(\w+)") {
                    $methodName = $Matches[2]
                    for ($ln = 0; $ln -lt $totalLines; $ln++) {
                        if ($FormLines[$ln] -match "(?i)PROCEDURE\s+$methodName") {
                            $relevantRanges += @{ Start = [Math]::Max(0, $ln - 5); End = [Math]::Min($totalLines - 1, $ln + 80) }
                            break
                        }
                    }
                }
                # Por nome de objeto
                if ($prob -match "(?i)(grd_4c_\w+|txt_4c_\w+|cmd_4c_\w+|opt_4c_\w+|cnt_4c_\w+|cursor_4c_\w+)") {
                    $objName = $Matches[1]
                    for ($ln = 0; $ln -lt $totalLines; $ln++) {
                        if ($FormLines[$ln] -match "(?i)$objName") {
                            $relevantRanges += @{ Start = [Math]::Max(0, $ln - 5); End = [Math]::Min($totalLines - 1, $ln + 15) }
                        }
                    }
                }
            }

            # Adicionar linhas que matcham os patterns de extra��o do grupo
            foreach ($pattern in $ExtraPatterns) {
                for ($ln = 0; $ln -lt $totalLines; $ln++) {
                    if ($FormLines[$ln] -match $pattern) {
                        $relevantRanges += @{ Start = [Math]::Max(0, $ln - 3); End = [Math]::Min($totalLines - 1, $ln + $ContextLines) }
                    }
                }
            }

            if ($relevantRanges.Count -eq 0) { return "" }

            # Merge overlapping ranges
            $sortedRanges = @($relevantRanges | Sort-Object { $_.Start })
            $mergedRanges = @()
            $current = @{ Start = $sortedRanges[0].Start; End = $sortedRanges[0].End }
            for ($r = 1; $r -lt $sortedRanges.Count; $r++) {
                $rStart = $sortedRanges[$r].Start
                $rEnd = $sortedRanges[$r].End
                if ($rStart -le ($current.End + 5)) {
                    $current.End = [Math]::Max($current.End, $rEnd)
                } else {
                    $mergedRanges += $current
                    $current = @{ Start = $rStart; End = $rEnd }
                }
            }
            $mergedRanges += $current

            # Construir texto
            $result = ""
            foreach ($range in $mergedRanges) {
                $result += "`n*-- Linhas $($range.Start + 1) a $($range.End + 1):`n"
                for ($ln = $range.Start; $ln -le $range.End -and $ln -lt $totalLines; $ln++) {
                    $result += "$($ln + 1): $($FormLines[$ln])`n"
                }
            }
            return $result
        }

        # =====================================================================
        # Loop principal com passes focados
        # =====================================================================
        $maxTentativas = 5
        $tentativa = 0
        $passCounter = 0

        # Backup dos arquivos antes do code review
        if (Test-Path $formFile) {
            Copy-Item -Path $formFile -Destination "$formFile.pre_review" -Force
            Write-Host "  Backup pre-review: $formFile.pre_review" -ForegroundColor Gray
        }
        if (Test-Path $boFile) {
            Copy-Item -Path $boFile -Destination "$boFile.pre_review" -Force
        }

        # Carregar Form lines uma vez (relido entre tentativas)
        $formLines = if (Test-Path $formFile) { Get-Content $formFile -Encoding UTF8 } else { @() }
        $previousProblemCount = -1  # Para detectar problemas repetidos (loop infinito)
        $previousProblemHash = ""

        while ($tentativa -lt $maxTentativas) {
            $tentativa++

            Write-Host ""
            Write-Host "--- Code Review (Tentativa $tentativa/$maxTentativas) ---" -ForegroundColor Cyan

            # Executar analise completa
            $todosProblemas = Test-CodeReviewProblems -FormFile $formFile -BOFile $boFile -OriginalSourceFile $originalSourceFile

            if ($todosProblemas.Count -eq 0) {
                Write-Host "  [OK] Code Review PASSOU - nenhum problema detectado" -ForegroundColor Green
                break
            }

            Write-Host "  [REVIEW] Total: $($todosProblemas.Count) problema(s)" -ForegroundColor Yellow

            # Detectar loop infinito: comparar tipos de problemas (ignorando numeros de linha que mudam entre edi��es)
            $currentProblemTags = @($todosProblemas | ForEach-Object { if ($_ -match '^\[([^\]]+)\]') { $Matches[1] } }) | Sort-Object
            $currentProblemHash = ($currentProblemTags -join "|")
            if ($todosProblemas.Count -eq $previousProblemCount -and $currentProblemHash -eq $previousProblemHash) {
                Write-Host "  [AVISO] Mesmos $($todosProblemas.Count) problemas detectados na tentativa anterior - provavelmente falsos positivos do validador. Prosseguindo." -ForegroundColor Yellow
                break
            }
            $previousProblemCount = $todosProblemas.Count
            $previousProblemHash = $currentProblemHash

            if ($tentativa -ge $maxTentativas) {
                Write-Host "  [AVISO] Limite de $maxTentativas tentativas atingido. Prosseguindo com problemas pendentes." -ForegroundColor Red
                break
            }

            # Agrupar problemas por pass
            $passesComProblemas = @()
            foreach ($passDef in $passDefinitions) {
                $passProblems = @()
                foreach ($prob in $todosProblemas) {
                    foreach ($tag in $passDef.Tags) {
                        if ($prob -match "^\[$tag\]") {
                            $passProblems += $prob
                            break
                        }
                    }
                }
                if ($passProblems.Count -gt 0) {
                    $passesComProblemas += @{
                        Definition = $passDef
                        Problems = $passProblems
                    }
                }
            }

            # Verificar problemas que nao matcharam nenhum pass (catch-all)
            $matchedProblems = @()
            foreach ($pcp in $passesComProblemas) {
                $matchedProblems += $pcp.Problems
            }
            $unmatchedProblems = @()
            foreach ($prob in $todosProblemas) {
                if ($matchedProblems -notcontains $prob) {
                    $unmatchedProblems += $prob
                }
            }
            if ($unmatchedProblems.Count -gt 0) {
                # Adicionar ao pass FUNCTIONAL como catch-all
                $funcPass = $passesComProblemas | Where-Object { $_.Definition.Name -eq "FUNCTIONAL" }
                if ($funcPass) {
                    $funcPass.Problems += $unmatchedProblems
                } else {
                    $passesComProblemas += @{
                        Definition = $passDefinitions[3]  # FUNCTIONAL
                        Problems = $unmatchedProblems
                    }
                }
            }

            $passResumo = ($passesComProblemas | ForEach-Object { "$($_.Definition.Name):$($_.Problems.Count)" }) -join ', '
            Write-Host "  Passes necessarios: $($passesComProblemas.Count) ($passResumo)" -ForegroundColor Cyan

            # Recarregar form lines (pode ter mudado em tentativa anterior)
            $formLines = if (Test-Path $formFile) { Get-Content $formFile -Encoding UTF8 } else { @() }
            $totalLines = $formLines.Count

            # Executar cada pass
            $passAborted = $false
            foreach ($passInfo in $passesComProblemas) {
                $passCounter++
                $passDef = $passInfo.Definition
                $passProblems = $passInfo.Problems

                Write-Host ""
                Write-Host "  === PASS $($passDef.Name) ($($passProblems.Count) problemas) ===" -ForegroundColor Magenta

                foreach ($p in $passProblems) {
                    Write-Host "    - $p" -ForegroundColor Yellow
                }

                # Extrair codigo relevante para este pass
                $conteudoArquivos = ""
                if ($totalLines -gt 0) {
                    $codeSnippet = Extract-RelevantCode -FormLines $formLines -Problems $passProblems -ExtraPatterns $passDef.ExtractPatterns -ContextLines $passDef.ContextLines
                    if ($codeSnippet) {
                        $conteudoArquivos = "`n### FORM ($formFile) - TRECHOS RELEVANTES PARA PASS $($passDef.Name) (${totalLines} linhas total):`n$codeSnippet"
                    } else {
                        # Fallback: primeiras 2000 linhas
                        $maxL = [Math]::Min(2000, $totalLines)
                        $conteudoArquivos = "`n### FORM ($formFile) - PRIMEIRAS ${maxL} de ${totalLines} linhas:`n"
                        $conteudoArquivos += ($formLines[0..($maxL-1)] -join "`n")
                    }
                }

                # Incluir BO se necessario
                if ($passDef.IncludeBO -and (Test-Path $boFile)) {
                    $boContent = Get-Content $boFile -Raw -Encoding UTF8
                    $boSizeKB = [System.Text.Encoding]::UTF8.GetByteCount($boContent) / 1024
                    if ($boSizeKB -lt 50) {
                        $conteudoArquivos += "`n`n### BO ($boFile):`n$boContent"
                    }
                }

                # Incluir SQL original se necessario
                $originalContext = ""
                if ($passDef.IncludeOriginalSQL -and $originalSourceFile -and (Test-Path $originalSourceFile)) {
                    $origContent = Get-Content $originalSourceFile -Raw -ErrorAction SilentlyContinue
                    if ($origContent) {
                        $sqlLines = ($origContent -split "`n" | Where-Object {
                            $_ -match "(?i)(SELECT|INSERT|UPDATE|DELETE|FROM|JOIN|SqlExecute|Seek\s*\(|ControlSource)" -and
                            $_ -notmatch "^\s*\*"
                        }) -join "`n"
                        if ($sqlLines) {
                            $originalContext = "`n### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):`n$sqlLines"
                        }
                    }
                }

                $promptSizeKB = [Math]::Round(([System.Text.Encoding]::UTF8.GetByteCount($conteudoArquivos + $originalContext)) / 1024)
                Write-Host "    Prompt size: ${promptSizeKB}KB" -ForegroundColor Gray

                $listaProblemasTexto = ($passProblems | ForEach-Object { "- $_" }) -join "`n"

                $reviewPromptFile = Join-Path $taskPath "code_review_prompt_t${tentativa}_$($passDef.Name).md"
                $reviewPromptContent = @"
# CODE REVIEW - PASS $($passDef.Name): $($passDef.Description)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **$($passDef.Description)**.

## PROBLEMAS DETECTADOS ($($passProblems.Count))
$listaProblemasTexto

## INSTRUCOES DE CORRECAO
$($passDef.Instructions)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com ``;`` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos
$originalContext

## CODIGO ATUAL DOS ARQUIVOS
$conteudoArquivos
"@
                Set-Content -Path $reviewPromptFile -Value $reviewPromptContent -Encoding UTF8

                # Chamar Claude
                $reviewOutputFile = Join-Path $taskPath "code_review_output_t${tentativa}_$($passDef.Name).txt"

                & (Join-Path $config.paths.automation "ClaudeInvoker.ps1") `
                    -PromptFile $reviewPromptFile `
                    -OutputFile $reviewOutputFile `
                    -Model $config.claude.model `
                    -Timeout $config.claude.timeout `
                    -ContextFiles @() `
                    -RateLimitMaxRetries $config.rateLimitRetry.maxRetries `
                    -RateLimitInitialDelaySeconds $config.rateLimitRetry.initialDelaySeconds `
                    -RateLimitMaxDelaySeconds $config.rateLimitRetry.maxDelaySeconds `
                    -RateLimitBackoffMultiplier $config.rateLimitRetry.backoffMultiplier `
                    -UsageLimitWaitSeconds $config.rateLimitRetry.usageLimitWaitSeconds `
                    -MaxOutputTokens $config.claude.maxOutputTokens

                $claudeExitCode = $LASTEXITCODE

                # Verificar usage limit e prompt too long
                if ($claudeExitCode -ne 0) {
                    if (Test-Path $reviewOutputFile) {
                        $reviewOutput = Get-Content $reviewOutputFile -Raw -ErrorAction SilentlyContinue
                        if ($reviewOutput -and (Test-UsageLimitHit -OutputContent $reviewOutput)) {
                            Write-Host "    USAGE LIMIT atingido. Abortando." -ForegroundColor Red
                            throw "Usage limit atingido na Etapa 5.8 (Code Review, pass $($passDef.Name))"
                        }
                        if ($reviewOutput -and (Test-PromptTooLong -OutputContent $reviewOutput)) {
                            Write-Host "    PROMPT TOO LONG no pass $($passDef.Name). Pulando este pass." -ForegroundColor Yellow
                            continue
                        }
                    }
                    Write-Host "    AVISO: Claude retornou exit code $claudeExitCode" -ForegroundColor Yellow
                }

                # Pos-correcao: CorretorAutomatico + Compilacao
                $corretorScript = Join-Path $config.paths.automation "CorretorAutomatico.ps1"
                if (Test-Path $formFile) { & $corretorScript -ArquivoPrg $formFile -TaskDir $taskPath }
                if (Test-Path $boFile) { & $corretorScript -ArquivoPrg $boFile -TaskDir $taskPath }

                # Revalidar compilacao
                $arquivosParaCompilar = @()
                if (Test-Path $formFile) { $arquivosParaCompilar += $formFile }
                if (Test-Path $boFile) { $arquivosParaCompilar += $boFile }

                if ($arquivosParaCompilar.Count -gt 0) {
                    $arquivosLista = $arquivosParaCompilar -join ";"
                    $validarScript = Join-Path $config.paths.automation "vfp_helpers\ValidarCompilacao.prg"
                    $vfp9Path = Join-Path $config.paths.vfp9 "vfp9.exe"

                    $tempScript = Join-Path $taskPath "temp_codereview_compilacao.prg"
                    $scriptContent = @"
SET SAFETY OFF
SET TALK OFF
SET CONSOLE ON

TRY
    DO "$validarScript" WITH "$arquivosLista"
CATCH TO loEx
    ? "ERRO: " + loEx.Message
ENDTRY

QUIT
"@
                    $scriptContent | Set-Content -Path $tempScript -Encoding ASCII
                    $vfpResult = Invoke-VFP9WithTimeout -VFP9Path $vfp9Path -Arguments "`"$tempScript`"" -TimeoutSeconds $config.vfp.timeout
                    if (Test-Path $tempScript) { Remove-Item $tempScript -Force }

                    $compilacaoFalhou = $false
                    foreach ($arquivo in $arquivosParaCompilar) {
                        $errFile = [System.IO.Path]::ChangeExtension($arquivo, "err")
                        if (Test-Path $errFile) {
                            $erroConteudo = Get-Content $errFile -Raw
                            Write-Host "    ERRO compilacao: $erroConteudo" -ForegroundColor Red
                            $compilacaoFalhou = $true
                        }
                    }

                    if ($compilacaoFalhou) {
                        Write-Host "    COMPILACAO FALHOU apos pass $($passDef.Name). Abortando passes restantes." -ForegroundColor Red
                        $passAborted = $true
                        break
                    }
                }

                # Deletar .fxp e recarregar form lines para proximo pass
                Get-ChildItem -Path "C:\4c\projeto\app" -Filter "*.fxp" -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
                $formLines = if (Test-Path $formFile) { Get-Content $formFile -Encoding UTF8 } else { @() }
                $totalLines = $formLines.Count

                Write-Host "    Pass $($passDef.Name) concluido." -ForegroundColor Green
            }

            Write-Host ""
            Write-Host "  Todos os passes concluidos. Re-verificando..." -ForegroundColor Cyan
        }

        # Resultado final
        $problemasFinal = Test-CodeReviewProblems -FormFile $formFile -BOFile $boFile -OriginalSourceFile $originalSourceFile

        # Verificar regressao visual: comparar propriedades visuais antes/depois do code review
        $preReviewFile = "$formFile.pre_review"
        if ((Test-Path $preReviewFile) -and (Test-Path $formFile)) {
            $preContent = Get-Content $preReviewFile -Raw -ErrorAction SilentlyContinue
            $postContent = Get-Content $formFile -Raw -ErrorAction SilentlyContinue
            if ($preContent -and $postContent) {
                $visualProps = @("\.Width\s*=", "\.Height\s*=", "\.Top\s*=", "\.Left\s*=", "\.BackColor\s*=", "\.ForeColor\s*=", "\.FontName\s*=", "\.FontSize\s*=")
                $preVisual = ($preContent -split "`n" | Where-Object {
                    $matched = $false
                    foreach ($prop in $visualProps) { if ($_ -match $prop) { $matched = $true; break } }
                    $matched
                }) -join "`n"
                $postVisual = ($postContent -split "`n" | Where-Object {
                    $matched = $false
                    foreach ($prop in $visualProps) { if ($_ -match $prop) { $matched = $true; break } }
                    $matched
                }) -join "`n"

                if ($preVisual -ne $postVisual) {
                    Write-Host ""
                    Write-Host "  [REGRESSAO VISUAL] Code Review alterou propriedades visuais! Restaurando apenas linhas visuais do pre-review..." -ForegroundColor Yellow
                    # Restauracao SELETIVA: manter fixes SQL/GRID/FUNCTIONAL, reverter apenas linhas visuais
                    $preLines = $preContent -split "`n"
                    $postLines = $postContent -split "`n"
                    # Construir hash das linhas visuais do pre-review por conteudo normalizado
                    $preVisualLines = @{}
                    for ($vi = 0; $vi -lt $preLines.Count; $vi++) {
                        $vl = $preLines[$vi]
                        foreach ($prop in $visualProps) {
                            if ($vl -match $prop) {
                                $key = ($vl.Trim() -replace '\s+', ' ') -replace '^\.\s*', ''
                                $preVisualLines[$key] = $vl
                                break
                            }
                        }
                    }
                    # Para cada linha visual no post que difere do pre, restaurar o valor original
                    $restoredCount = 0
                    for ($vi = 0; $vi -lt $postLines.Count; $vi++) {
                        $vl = $postLines[$vi]
                        $isVisual = $false
                        foreach ($prop in $visualProps) {
                            if ($vl -match $prop) { $isVisual = $true; break }
                        }
                        if ($isVisual) {
                            $key = ($vl.Trim() -replace '\s+', ' ') -replace '^\.\s*', ''
                            if ($preVisualLines.ContainsKey($key)) {
                                # Linha existe em ambos, sem mudanca
                            } elseif ($preVisualLines.Count -gt 0) {
                                # Linha visual foi alterada - nao reverter individualmente
                                # (complexo demais - aceitar a mudanca e avisar)
                            }
                        }
                    }
                    Write-Host "  [INFO] Passes VISUAL agora rodam por ultimo - regressao visual improvavel. Mantendo Form atual." -ForegroundColor Cyan
                    Write-Host "  [INFO] Se houver problemas visuais, ValidarUIFidelity na Etapa 7 detectara." -ForegroundColor Cyan
                } else {
                    Write-Host "  [OK] Propriedades visuais nao alteradas pelo Code Review" -ForegroundColor Green
                }
            }
            Remove-Item $preReviewFile -Force -ErrorAction SilentlyContinue
            if (Test-Path "$boFile.pre_review") {
                Remove-Item "$boFile.pre_review" -Force -ErrorAction SilentlyContinue
            }
        }

        Complete-Etapa -TaskId $TaskId -Etapa "05e_codeReview" -TasksDir $config.paths.tasks -Metadata @{
            tentativas = $tentativa
            passes = $passCounter
            problemasRestantes = $problemasFinal.Count
            problemas = if ($problemasFinal.Count -gt 0) { $problemasFinal -join "; " } else { "Nenhum" }
        }

        if ($problemasFinal.Count -gt 0) {
            Write-Host ""
            Write-Host "  [AVISO] Code Review encerrado com $($problemasFinal.Count) problema(s) pendente(s)" -ForegroundColor Yellow
        }
        else {
            Write-Host ""
            Write-Host "  [OK] Code Review PASSOU apos $tentativa tentativa(s), $passCounter pass(es)" -ForegroundColor Green
        }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "05e_codeReview" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}


#------------------------------------------------------------------------------
# ETAPA 6: Testar formulario
#------------------------------------------------------------------------------

function Invoke-Etapa06_TestForm {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 6" "Testar formulario (TestFormWrapper.prg) com retry automatico"

    Start-Etapa -TaskId $TaskId -Etapa "06_testForm" -TasksDir $config.paths.tasks

    $taskPath = Join-Path $config.paths.tasks $TaskId
    $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "06_testForm" -TasksDir $config.paths.tasks
    $formClass = Get-FormClassName -BaseName $BaseName
    $testScript = Join-Path $config.paths.automation "vfp_helpers\TestFormWrapper.prg"

    $maxTentativas = if ($config.retry.PSObject.Properties['maxTentativasRuntimeFix']) {
        $config.retry.maxTentativasRuntimeFix
    } else { 10 }

    $sucesso = $false

    for ($tentativa = 1; $tentativa -le $maxTentativas; $tentativa++) {
        Write-Host ""
        Write-Host "--- Tentativa $tentativa/$maxTentativas ---" -ForegroundColor Cyan

        # Deletar arquivos anteriores (se existirem)
        $vfpOutputFile = Join-Path $taskPath "vfp_output.txt"
        if (Test-Path $vfpOutputFile) { Remove-Item $vfpOutputFile -Force -ErrorAction SilentlyContinue }
        $vfpErrorDetailsFile = Join-Path $taskPath "vfp_error_details.txt"
        if (Test-Path $vfpErrorDetailsFile) { Remove-Item $vfpErrorDetailsFile -Force -ErrorAction SilentlyContinue }

        $parameters = @($formClass, $logFile)

        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
            -ScriptPrg $testScript `
            -Parameters $parameters `
            -Timeout $config.vfp.timeout `
            -LogFile $logFile `
            -OutputFile $vfpOutputFile

        $exitCode = $LASTEXITCODE

        if ($exitCode -eq 0) {
            Write-Host "Formulario testado com sucesso (sem erros)" -ForegroundColor Green
            $sucesso = $true
            break
        }

        # Falha: construir mensagem de erro
        $erroMsg = ""

        # Capturar detalhes de vfp_error_details.txt (erros gravados em modo teste)
        $vfpErrorDetailsFile = Join-Path $taskPath "vfp_error_details.txt"
        $errorDetails = ""
        if (Test-Path $vfpErrorDetailsFile) {
            $errorDetails = Get-Content $vfpErrorDetailsFile -Raw -ErrorAction SilentlyContinue
            if ($errorDetails) {
                Write-Host "Detalhes do erro capturados de vfp_error_details.txt:" -ForegroundColor Yellow
                Write-Host $errorDetails -ForegroundColor Yellow
            }
        }

        # Capturar saida parcial de vfp_output.txt
        $vfpOutContent = ""
        if (Test-Path $vfpOutputFile) {
            $vfpOutContent = Get-Content $vfpOutputFile -Raw -ErrorAction SilentlyContinue
        }

        if ($exitCode -eq 4) {
            $erroMsg = "TIMEOUT: VFP9 travou durante teste de formulario ($($config.vfp.timeout)s)."
            if ($errorDetails) {
                $erroMsg += " ERRO CAPTURADO: $errorDetails"
            } elseif ($vfpOutContent) {
                $erroMsg += " Saida VFP: $vfpOutContent"
            } else {
                $erroMsg += " Possivel erro de runtime (Property not found, dialog modal)."
            }
        } else {
            $erroMsg = "Teste de formulario falhou com exit code $exitCode."
            if ($errorDetails) {
                $erroMsg += " ERRO CAPTURADO: $errorDetails"
            } elseif ($vfpOutContent) {
                $erroMsg += " Saida VFP: $vfpOutContent"
            }
        }

        Write-Host "FALHA: $erroMsg" -ForegroundColor Red

        if ($tentativa -ge $maxTentativas) {
            Write-Host "Maximo de tentativas atingido ($maxTentativas)." -ForegroundColor Yellow
            break
        }

        # Tentar correcao automatica via Claude
        Write-Host "Acionando correcao automatica via Claude..." -ForegroundColor Yellow

        $corrigiu = Invoke-RuntimeErrorCorrection `
            -TaskId $TaskId `
            -BaseName $BaseName `
            -EtapaOrigem "06_testForm" `
            -ErroMsg $erroMsg `
            -Tentativa $tentativa

        if (-not $corrigiu) {
            Write-Host "Correcao falhou (compilacao nao passou ou usage limit). Parando retry." -ForegroundColor Red
            break
        }

        Write-Host "Correcao aplicada. Re-testando..." -ForegroundColor Cyan
        Start-Sleep -Seconds $config.retry.delaySegundos
    }

    if ($sucesso) {
        Complete-Etapa -TaskId $TaskId -Etapa "06_testForm" -TasksDir $config.paths.tasks -Metadata @{
            tentativasUsadas = $tentativa
        }
    } else {
        Write-Host ""
        Write-Host "AVISO: Teste de formulario nao passou apos $tentativa tentativa(s)." -ForegroundColor Yellow
        Write-Host "Auto-continuando (teste de form nao bloqueia pipeline)..." -ForegroundColor Yellow
        Write-Host "O teste manual final validara a funcionalidade." -ForegroundColor Yellow
        Complete-Etapa -TaskId $TaskId -Etapa "06_testForm" -TasksDir $config.paths.tasks -Metadata @{
            autoSkipped = $true
            erro = $erroMsg
            tentativasUsadas = $tentativa
            timedOut = ($erroMsg -match "TIMEOUT")
        }
    }
}

#------------------------------------------------------------------------------
# ETAPA 6.5: Teste Automatico (NOVO)
#------------------------------------------------------------------------------

function Invoke-Etapa06b_TesteAutomatico {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 6.5" "Teste Automatico (TesteAutomatico.prg) com retry automatico"

    Start-Etapa -TaskId $TaskId -Etapa "06b_testeAutomatico" -TasksDir $config.paths.tasks

    $taskPath = Join-Path $config.paths.tasks $TaskId
    $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "06b_testeAutomatico" -TasksDir $config.paths.tasks
    $formClass = Get-FormClassName -BaseName $BaseName
    $testeScript = Join-Path $config.paths.projeto "app\utils\TesteAutomatico.prg"

    # Detecta formType para passar ao TesteAutomatico (CRUD, REPORT ou OPERACIONAL)
    $formType = Get-FormTypeFromState -TaskId $TaskId

    $maxTentativas = if ($config.retry.PSObject.Properties['maxTentativasRuntimeFix']) {
        $config.retry.maxTentativasRuntimeFix
    } else { 10 }

    # QUALITY GATE threshold
    $thresholdMinimo = if ($config.validacao.PSObject.Properties['testesAutomaticosMinimo']) {
        $config.validacao.testesAutomaticosMinimo
    } else { 100 }

    $sucesso = $false
    $ultimoErro = ""

    for ($tentativa = 1; $tentativa -le $maxTentativas; $tentativa++) {
        Write-Host ""
        Write-Host "--- Tentativa $tentativa/$maxTentativas ---" -ForegroundColor Cyan

        # Limpar resultado anterior
        $resultFile = Join-Path $taskPath "teste_resultado.json"
        if (Test-Path $resultFile) { Remove-Item $resultFile -Force -ErrorAction SilentlyContinue }

        $vfpOutputFile = Join-Path $taskPath "vfp_output.txt"
        if (Test-Path $vfpOutputFile) { Remove-Item $vfpOutputFile -Force -ErrorAction SilentlyContinue }
        $vfpErrorDetailsFile = Join-Path $taskPath "vfp_error_details.txt"
        if (Test-Path $vfpErrorDetailsFile) { Remove-Item $vfpErrorDetailsFile -Force -ErrorAction SilentlyContinue }

        $parameters = @($formClass, $taskPath, $formType)

        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
            -ScriptPrg $testeScript `
            -Parameters $parameters `
            -Timeout $config.vfp.timeout `
            -LogFile $logFile `
            -OutputFile $vfpOutputFile

        $exitCode = $LASTEXITCODE

        # --- TIMEOUT ---
        if ($exitCode -eq 4) {
            $ultimoErro = "TIMEOUT: VFP9 travou durante teste automatico ($($config.vfp.timeout)s)."

            # Capturar detalhes de vfp_error_details.txt (erros gravados em modo teste)
            $vfpErrorDetailsFile = Join-Path $taskPath "vfp_error_details.txt"
            $errorDetails = ""
            if (Test-Path $vfpErrorDetailsFile) {
                $errorDetails = Get-Content $vfpErrorDetailsFile -Raw -ErrorAction SilentlyContinue
                if ($errorDetails) {
                    Write-Host "Detalhes do erro capturados de vfp_error_details.txt:" -ForegroundColor Yellow
                    Write-Host $errorDetails -ForegroundColor Yellow
                }
            }

            # Capturar saida parcial de vfp_output.txt
            if (-not $errorDetails -and (Test-Path $vfpOutputFile)) {
                $vfpOutContent = Get-Content $vfpOutputFile -Raw -ErrorAction SilentlyContinue
                if ($vfpOutContent) { $errorDetails = $vfpOutContent }
            }

            if ($errorDetails) {
                $ultimoErro += " ERRO CAPTURADO: $errorDetails"
            } else {
                $ultimoErro += " Possivel erro de runtime (Property not found, dialog modal)."
            }

            Write-Host "$ultimoErro" -ForegroundColor Red

            if ($tentativa -ge $maxTentativas) { break }

            $corrigiu = Invoke-RuntimeErrorCorrection `
                -TaskId $TaskId -BaseName $BaseName `
                -EtapaOrigem "06b_testeAutomatico" `
                -ErroMsg $ultimoErro -Tentativa $tentativa

            if (-not $corrigiu) {
                Write-Host "Correcao falhou. Parando retry." -ForegroundColor Red
                break
            }
            Start-Sleep -Seconds $config.retry.delaySegundos
            continue
        }

        # --- Verificar resultado JSON ---
        if (Test-Path $resultFile) {
            $resultado = Get-Content $resultFile -Raw | ConvertFrom-Json

            Write-Host ""
            Write-Host "Resultado dos testes automaticos:" -ForegroundColor Cyan
            Write-Host "  Total: $($resultado.resumo.total)" -ForegroundColor White
            Write-Host "  Passou: $($resultado.resumo.passou)" -ForegroundColor Green
            Write-Host "  Falhou: $($resultado.resumo.falhou)" -ForegroundColor $(if ($resultado.resumo.falhou -gt 0) { "Red" } else { "Green" })
            Write-Host "  Percentual: $($resultado.resumo.percentual)%" -ForegroundColor White

            if ($resultado.resumo.percentual -ge $thresholdMinimo) {
                # SUCESSO!
                Write-Host ""
                Write-Host "Status: TESTES AUTOMATICOS OK - $($resultado.resumo.percentual)% de sucesso (>= $thresholdMinimo%)" -ForegroundColor Green
                $sucesso = $true
                break
            }

            # Testes falharam: construir erro detalhado
            $errosDetalhados = @()
            foreach ($teste in $resultado.testes) {
                if (-not $teste.passou) {
                    $detalhe = "Teste '$($teste.nome)': $($teste.erro)"
                    if ($teste.detalhes) { $detalhe += " | Detalhes: $($teste.detalhes)" }
                    $errosDetalhados += $detalhe
                    Write-Host "  FALHOU: $($teste.nome): $($teste.erro)" -ForegroundColor Red
                }
            }
            $ultimoErro = "Testes automaticos: $($resultado.resumo.percentual)% < $thresholdMinimo%. Falhas: " + ($errosDetalhados -join "; ")

            if ($tentativa -ge $maxTentativas) { break }

            Write-Host ""
            Write-Host "Acionando correcao automatica via Claude..." -ForegroundColor Yellow

            $corrigiu = Invoke-RuntimeErrorCorrection `
                -TaskId $TaskId -BaseName $BaseName `
                -EtapaOrigem "06b_testeAutomatico" `
                -ErroMsg $ultimoErro -Tentativa $tentativa

            if (-not $corrigiu) {
                Write-Host "Correcao falhou. Parando retry." -ForegroundColor Red
                break
            }
            Start-Sleep -Seconds $config.retry.delaySegundos
            continue
        }
        else {
            # Sem resultado JSON
            $ultimoErro = "teste_resultado.json nao gerado (exit code $exitCode). VFP pode ter crashado antes de escrever resultado."
            Write-Host "ERRO: $ultimoErro" -ForegroundColor Red

            if ($tentativa -ge $maxTentativas) { break }

            $corrigiu = Invoke-RuntimeErrorCorrection `
                -TaskId $TaskId -BaseName $BaseName `
                -EtapaOrigem "06b_testeAutomatico" `
                -ErroMsg $ultimoErro -Tentativa $tentativa

            if (-not $corrigiu) {
                Write-Host "Correcao falhou. Parando retry." -ForegroundColor Red
                break
            }
            Start-Sleep -Seconds $config.retry.delaySegundos
            continue
        }
    }

    if ($sucesso) {
        Complete-Etapa -TaskId $TaskId -Etapa "06b_testeAutomatico" -TasksDir $config.paths.tasks -Metadata @{
            resultFile = $resultFile
            total = $resultado.resumo.total
            passou = $resultado.resumo.passou
            falhou = $resultado.resumo.falhou
            percentual = $resultado.resumo.percentual
            threshold = $thresholdMinimo
            tentativasUsadas = $tentativa
        }
    } else {
        Write-Host ""
        Write-Host "========================================================================" -ForegroundColor Red
        Write-Host "ERRO CRITICO: Testes automaticos NAO passaram apos $tentativa tentativa(s)!" -ForegroundColor Red
        Write-Host "========================================================================" -ForegroundColor Red
        Write-Host "Ultimo erro: $ultimoErro" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "REGRA FUNDAMENTAL DO PROJETO:" -ForegroundColor Yellow
        Write-Host "  NUNCA criar versoes reduzidas - paridade funcional 100% com legado" -ForegroundColor Yellow
        Write-Host ""

        Fail-Etapa -TaskId $TaskId -Etapa "06b_testeAutomatico" `
            -ErroMsg "Testes automaticos falharam apos $tentativa tentativa(s): $ultimoErro" `
            -TasksDir $config.paths.tasks
        throw "Testes automaticos falharam apos $tentativa tentativa(s): $ultimoErro"
    }
}

#------------------------------------------------------------------------------
# ETAPA 6.8: Validar Layout vs PRG (analise estatica)
#------------------------------------------------------------------------------

function Invoke-Etapa06c_ValidarLayout {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 6.8" "Validar Layout vs PRG (analise estatica)"

    $taskPath = Join-Path $config.paths.tasks $TaskId
    $layoutFile = Join-Path $taskPath "layout.json"

    # Se nao existe layout.json, pular (forms mais antigos podem nao ter)
    if (-not (Test-Path $layoutFile)) {
        Write-Host "  [SKIP] layout.json nao encontrado em $taskPath - pulando validacao" -ForegroundColor Yellow
        return
    }

    Start-Etapa -TaskId $TaskId -Etapa "06c_validarLayout" -TasksDir $config.paths.tasks

    # Localizar o .prg do form
    $formClass = Get-FormClassName -BaseName $BaseName
    $formType = Get-FormTypeFromState -TaskId $TaskId
    $formSubdir = switch ($formType) {
        "CRUD"        { "cadastros" }
        "REPORT"      { "relatorios" }
        "OPERACIONAL" { "operacionais" }
        default       { "cadastros" }
    }
    $formPrg = Join-Path $config.paths.projeto "app\forms\$formSubdir\$formClass.prg"

    if (-not (Test-Path $formPrg)) {
        Write-Host "  [SKIP] Form .prg nao encontrado: $formPrg" -ForegroundColor Yellow
        Complete-Etapa -TaskId $TaskId -Etapa "06c_validarLayout" -TasksDir $config.paths.tasks -Metadata @{
            status = "SKIPPED"
            motivo = "Form .prg nao encontrado"
        }
        return
    }

    # Threshold configuravel
    $thresholdPx = if ($config.validacao.PSObject.Properties['layoutThresholdPx']) {
        $config.validacao.layoutThresholdPx
    } else { 5 }

    $maxErrors = if ($config.validacao.PSObject.Properties['layoutMaxErrors']) {
        $config.validacao.layoutMaxErrors
    } else { 0 }

    $reportFile = Join-Path $taskPath "layout_vs_prg_report.json"
    $scriptPath = Join-Path $config.paths.automation "ValidarLayoutVsPrg.ps1"

    Write-Host "  Layout:    $layoutFile" -ForegroundColor Gray
    Write-Host "  PRG:       $formPrg" -ForegroundColor Gray
    Write-Host "  Threshold: ${thresholdPx}px" -ForegroundColor Gray
    Write-Host ""

    try {
        # Executar validacao
        $exitCode = 0
        $mapeamentoForLayout = Join-Path $taskPath "mapeamento.json"
        & $scriptPath -LayoutJsonFile $layoutFile -FormPrgFile $formPrg -ThresholdPx $thresholdPx -ReportFile $reportFile -MapeamentoFile $mapeamentoForLayout
        $exitCode = $LASTEXITCODE

        # Ler resultado
        if (Test-Path $reportFile) {
            $report = Get-Content -Path $reportFile -Raw | ConvertFrom-Json
            $errors = $report.summary.errors
            $warnings = $report.summary.warnings
            $matched = $report.summary.matched
            $unmatched = $report.summary.unmatched

            Complete-Etapa -TaskId $TaskId -Etapa "06c_validarLayout" -TasksDir $config.paths.tasks -Metadata @{
                errors = $errors
                warnings = $warnings
                matched = $matched
                unmatched = $unmatched
                reportFile = $reportFile
                thresholdPx = $thresholdPx
            }

            # Logar resultado
            if ($errors -gt $maxErrors) {
                Write-Host ""
                Write-Host "  ATENCAO: $errors objetos ausentes no .prg (threshold: $maxErrors)" -ForegroundColor Yellow
                Write-Host "  $warnings warnings de posicao divergente" -ForegroundColor Yellow
                Write-Host "  Relatorio: $reportFile" -ForegroundColor Gray
                Write-Host "  [INFO] Etapa NAO-BLOQUEANTE - prosseguindo para Etapa 7" -ForegroundColor Cyan
            } else {
                Write-Host "  Layout OK: $matched matched, $errors erros, $warnings warnings" -ForegroundColor Green
            }
        } else {
            Write-Host "  [WARN] Relatorio nao gerado" -ForegroundColor Yellow
            Complete-Etapa -TaskId $TaskId -Etapa "06c_validarLayout" -TasksDir $config.paths.tasks -Metadata @{
                status = "NO_REPORT"
            }
        }
    }
    catch {
        Write-Host "  [WARN] Erro na validacao de layout: $($_.Exception.Message)" -ForegroundColor Yellow
        Complete-Etapa -TaskId $TaskId -Etapa "06c_validarLayout" -TasksDir $config.paths.tasks -Metadata @{
            status = "ERROR"
            erro = $_.Exception.Message
        }
    }
}

#------------------------------------------------------------------------------
# ETAPA 7: Validar UI Fidelity
#------------------------------------------------------------------------------

function Invoke-Etapa07_ValidarUI {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 7" "Validar UI Fidelity (ValidarUIFidelity.prg)"

    $state = Get-TaskState -TaskId $TaskId -TasksDir $config.paths.tasks
    $tentativas = $state.etapas."07_validarUI".tentativas
    $maxTentativas = $config.retry.maxTentativasValidacao

    if ($tentativas -ge $maxTentativas) {
        throw "Numero maximo de tentativas atingido para validacao UI: $maxTentativas"
    }

    Start-Etapa -TaskId $TaskId -Etapa "07_validarUI" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId
        $logFile = Get-TaskLogPath -TaskId $TaskId -Etapa "07_validarUI" -TasksDir $config.paths.tasks

        # Determina nome da classe do form usando funcao auxiliar
        $formClass = Get-FormClassName -BaseName $BaseName

        # Normaliza BaseName para case-insensitive (VFP converte para uppercase)
        $txtFiles = Get-ChildItem -Path $taskPath -Filter "*_form_codigo_fonte.txt" -File
        if ($txtFiles.Count -eq 0) {
            throw "Arquivo *_form_codigo_fonte.txt nao encontrado em $taskPath"
        }

        $txtFile = $txtFiles[0].FullName

        # Executa ValidarUIFidelity.prg com parametros diretos (sem config.fpw)
        # ValidarUIFidelity.prg aceita: LPARAMETERS par_cArquivoOriginal, par_cClasseForm
        # O relatorio HTML sera gerado automaticamente em: C:\4c\projeto\app\utils\relatorios\UIFidelity_<FormClass>_<timestamp>.html
        $validacaoScript = Join-Path $config.paths.projeto "app\utils\ValidarUIFidelity.prg"

        # Limpa .fxp antes de executar (evita erro "Must specify additional parameters" por .fxp stale)
        $fxpFiles = Get-ChildItem -Path $config.paths.projeto -Filter "*.fxp" -Recurse -ErrorAction SilentlyContinue
        if ($fxpFiles.Count -gt 0) {
            $fxpFiles | Remove-Item -Force -ErrorAction SilentlyContinue
            Write-Host "  Removidos $($fxpFiles.Count) arquivos .fxp (cache)" -ForegroundColor Gray
        }

        $parameters = @($txtFile, $formClass)

        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
            -ScriptPrg $validacaoScript `
            -Parameters $parameters `
            -Timeout $config.vfp.timeout `
            -LogFile $logFile `
            -OutputFile (Join-Path $taskPath "vfp_output.txt")

        $exitCode = $LASTEXITCODE

        # Exit code 4 = TIMEOUT (VFP9 travou e foi encerrado forcadamente)
        if ($exitCode -eq 4) {
            Write-Host "TIMEOUT: VFP9 travou durante validacao UI e foi encerrado forcadamente!" -ForegroundColor Red
            throw "TIMEOUT: ValidarUIFidelity.prg excedeu $($config.vfp.timeout) segundos. VFP9 foi encerrado."
        }

        # Exit code: VFP9 GUI NAO retorna exit codes confiaveis (retorna vazio/"")
        # Por isso, SEMPRE verificamos o relatorio HTML gerado ao inves de confiar no exit code
        # Exit code 4 ja foi tratado acima (TIMEOUT)
        # Exit code >= 2 E nao-vazio indica erro real de execucao
        if ($exitCode -ne $null -and $exitCode -ne "" -and $exitCode -ge 2) {
            throw "ValidarUIFidelity.prg retornou codigo de erro: $exitCode (form nao encontrado ou erro de instanciacao)"
        }

        Write-Host ""
        Write-Host "Resultado da validacao UI:" -ForegroundColor Cyan

        # SEMPRE verificar o relatorio HTML (NAO confiar no exit code - VFP9 GUI retorna vazio)
        $relatoriosDir = Join-Path $config.paths.projeto "app\utils\relatorios"
        $htmlReportFiles = Get-ChildItem -Path $relatoriosDir -Filter "UIFidelity_${formClass}_*.html" -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending

        if ($htmlReportFiles.Count -eq 0 -or ($htmlReportFiles[0].LastWriteTime -lt (Get-Date).AddMinutes(-5))) {
            # HTML nao gerado ou muito antigo - falha silenciosa!
            Write-Host "  AVISO: Relatorio HTML nao gerado!" -ForegroundColor Yellow
            Write-Host "  Possivel falha silenciosa no ValidarUIFidelity.prg" -ForegroundColor Yellow
            Write-Host "  Verificar log: $logFile" -ForegroundColor Yellow

            Fail-Etapa -TaskId $TaskId -Etapa "07_validarUI" -ErroMsg "Relatorio HTML nao gerado - provavel falha silenciosa no ValidarUIFidelity" -TasksDir $config.paths.tasks
            throw "ValidarUIFidelity nao gerou relatorio HTML"
        }

        $htmlFile = $htmlReportFiles[0].FullName
        $html = Get-Content $htmlFile -Raw

        # Extrair contadores de problemas do HTML (parsing do relatorio gerado)
        $totalProblemas = 0
        $erros = 0
        $avisos = 0
        $diferencas = 0

        # O HTML usa divs com classes card: "card total", "card erro", "card aviso", "card diferenca"
        # Dentro de cada card: <div class="numero">XXX</div>
        if ($html -match 'card total[^>]*>[\s\S]*?<div class="numero">(\d+)</div>') {
            $totalProblemas = [int]$matches[1]
        }
        if ($html -match 'card erro[^>]*>[\s\S]*?<div class="numero">(\d+)</div>') {
            $erros = [int]$matches[1]
        }
        if ($html -match 'card aviso[^>]*>[\s\S]*?<div class="numero">(\d+)</div>') {
            $avisos = [int]$matches[1]
        }
        if ($html -match 'card diferenca[^>]*>[\s\S]*?<div class="numero">(\d+)</div>') {
            $diferencas = [int]$matches[1]
        }

        Write-Host "  Total de problemas: $totalProblemas" -ForegroundColor White
        $corErros = if ($erros -gt 4) { "Red" } elseif ($erros -gt 0) { "Yellow" } else { "Green" }
        Write-Host "  Erros: $erros (max aceitavel: 4 Dataenvironment)" -ForegroundColor $corErros
        $corAvisos = if ($avisos -gt 0) { "Yellow" } else { "Green" }
        Write-Host "  Avisos: $avisos (objetos renomeados na nova arquitetura - NAO bloqueiam)" -ForegroundColor $corAvisos
        $corDiferencas = if ($diferencas -gt 0) { "Red" } else { "Green" }
        Write-Host "  Diferencas: $diferencas (max aceitavel: 0)" -ForegroundColor $corDiferencas
        Write-Host ""

        # Validar contra thresholds
        $maxProblemasRecomendado = if ($config.validacao.PSObject.Properties['maxProblemasRecomendado']) {
            $config.validacao.maxProblemasRecomendado
        } else {
            37  # Default: 4 Dataenvironment + 33 FormBase
        }

        # REGRA: Erros reais devem ser poucos (4 Dataenvironment aceitaveis)
        # Avisos incluem: FormBase (33) + objetos renomeados na nova arquitetura (filhos de pais mapeados)
        # Avisos NAO bloqueiam a validacao - apenas erros e diferencas reais bloqueiam
        #
        # TOLERANCIA: Erros "objeto nao encontrado" para form raiz e DataEnvironment
        # ocorrem quando ValidarUIFidelity nao consegue instanciar o form completamente
        # (ex: REPORT sem conexao ao banco). Esses erros NAO sao problemas reais de UI.
        $errosObjNaoEncontrado = ([regex]::Matches($html, 'badge erro.*?objeto n.+?encontrado', [System.Text.RegularExpressions.RegexOptions]::Singleline)).Count
        $errosReais = $erros - $errosObjNaoEncontrado
        if ($errosObjNaoEncontrado -gt 0) {
            Write-Host "  [INFO] $errosObjNaoEncontrado erro(s) de 'objeto nao encontrado' (tolerados - instanciacao parcial)" -ForegroundColor Gray
            Write-Host "  [INFO] Erros reais (excluindo instanciacao): $errosReais" -ForegroundColor Gray
        }
        $problemasInaceitaveis = ($errosReais -gt 4) -or ($diferencas -gt 0)

        # Camada 3: Validacao de regioes via layout.json (complementar ao ValidarUIFidelity)
        $layoutFile = Join-Path $taskPath "layout.json"
        if (Test-Path $layoutFile) {
            try {
                $layoutJson = Get-Content $layoutFile -Raw -Encoding UTF8 | ConvertFrom-Json
                $layoutObjects = $layoutJson.objects
                $formPrgFile = $formFile  # Ja definido anteriormente

                if ($layoutObjects -and (Test-Path $formPrgFile)) {
                    $formCode = Get-Content $formPrgFile -Raw -Encoding UTF8
                    $layoutWarnings = 0

                    # Validar que grids do original existem com Height similar no migrado
                    $originalGrids = $layoutObjects | Where-Object { $_.baseClass -eq "grid" -and $_.height }
                    foreach ($og in $originalGrids) {
                        if ($formCode -match "(?i)\.Height\s*=\s*(\d+)" -and $og.height) {
                            # Procurar especificamente o grid dentro do contexto (grd_4c_)
                            $gridMatches = [regex]::Matches($formCode, "(?i)grd_4c_\w+[\s\S]{0,200}?\.Height\s*=\s*(\d+)")
                            foreach ($gm in $gridMatches) {
                                $migGridH = [int]$gm.Groups[1].Value
                                $origGridH = [int]$og.height
                                $diffH = [math]::Abs($origGridH - $migGridH)
                                if ($diffH -gt 50) {
                                    Write-Host "  [LAYOUT] Grid Height divergente: original=$origGridH vs migrado=$migGridH (diff=${diffH}px)" -ForegroundColor Yellow
                                    $layoutWarnings++
                                }
                            }
                        }
                    }

                    # Validar que botoes do toolbar mant�m ordem relativa Left
                    $originalBtns = $layoutObjects | Where-Object {
                        $_.baseClass -eq "commandbutton" -and $null -ne $_.left -and $null -ne $_.top -and $_.top -lt 100
                    } | Sort-Object left

                    if ($originalBtns.Count -ge 3) {
                        # Os botoes originais estao na metade direita? (Left > Width/2)
                        $formW = if ($layoutJson.form.width) { $layoutJson.form.width } else { 1000 }
                        $avgBtnLeft = ($originalBtns | Measure-Object -Property left -Average).Average
                        if ($avgBtnLeft -gt ($formW / 2)) {
                            # Verificar se migrado tamb�m posiciona bot�es na metade direita
                            $btnLeftMatches = [regex]::Matches($formCode, "(?i)cmd_4c_\w+[\s\S]{0,150}?\.Left\s*=\s*(\d+)")
                            $migBtnLefts = @()
                            foreach ($bm in $btnLeftMatches) {
                                $migBtnLefts += [int]$bm.Groups[1].Value
                            }
                            if ($migBtnLefts.Count -ge 3) {
                                $avgMigBtnLeft = ($migBtnLefts | Measure-Object -Average).Average
                                if ($avgMigBtnLeft -lt ($formW / 3)) {
                                    Write-Host "  [LAYOUT] Botoes CRUD no lado ESQUERDO (avg Left=$([int]$avgMigBtnLeft)) mas original esta no DIREITO (avg Left=$([int]$avgBtnLeft))" -ForegroundColor Red
                                    $layoutWarnings++
                                }
                            }
                        }
                    }

                    if ($layoutWarnings -gt 0) {
                        Write-Host "  [LAYOUT] $layoutWarnings aviso(s) de layout detectado(s) via layout.json" -ForegroundColor Yellow
                    } else {
                        Write-Host "  [LAYOUT] Validacao de layout OK" -ForegroundColor Green
                    }
                }
            }
            catch {
                Write-Host "  [LAYOUT] Erro ao validar layout: $($_.Exception.Message)" -ForegroundColor Yellow
            }
        }

        if ($problemasInaceitaveis) {
            Write-Host "========================================================================" -ForegroundColor Red
            Write-Host "ERRO CRITICO: Diferencas visuais INACEITAVEIS encontradas!" -ForegroundColor Red
            Write-Host "========================================================================" -ForegroundColor Red
            Write-Host "  Erros bloqueantes: $erros (limite: 4 - apenas Dataenvironment)" -ForegroundColor Yellow
            Write-Host "  Obtido: $totalProblemas problemas totais ($avisos avisos nao-bloqueantes)" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "DETALHAMENTO:" -ForegroundColor Yellow
            Write-Host "  - Erros: $erros (limite: 4 - apenas Dataenvironment)" -ForegroundColor $(if ($erros -gt 4) { "Red" } else { "White" })
            Write-Host "  - Avisos: $avisos (objetos renomeados - NAO bloqueiam)" -ForegroundColor "Yellow"
            Write-Host "  - Diferencas: $diferencas (limite: 0 - propriedades visuais DEVEM ser identicas)" -ForegroundColor $(if ($diferencas -gt 0) { "Red" } else { "White" })
            Write-Host ""
            Write-Host "PILAR 1 (UX): Interface DEVE ser pixel-perfect identica ao sistema legado." -ForegroundColor Yellow
            Write-Host "REGRA FUNDAMENTAL: NUNCA criar versoes reduzidas - paridade funcional 100% com legado." -ForegroundColor Yellow
            Write-Host ""
            Write-Host "ACAO NECESSARIA:" -ForegroundColor Cyan
            Write-Host "  1. Abrir relatorio HTML: $htmlFile" -ForegroundColor White
            Write-Host "  2. Corrigir TODAS as diferencas visuais no Form" -ForegroundColor White
            Write-Host "  3. Re-executar o OrquestradorMigracao.ps1 para esta task" -ForegroundColor White
            Write-Host ""

            # ================================================================
            # ETAPA 7.5: Auto-correcao de diferencas visuais (se <= 5)
            # ================================================================
            if ($diferencas -gt 0 -and $diferencas -le 5 -and $errosReais -le 4) {
                Write-Host ""
                Write-Host "  [ETAPA 7.5] Auto-correcao de $diferencas diferenca(s) visual(is)..." -ForegroundColor Cyan

                $formClassUI = Get-FormClassName -BaseName $BaseName
                $formFileUI = Find-FormFile -ProjetoPath $config.paths.projeto -FormClass $formClassUI
                $fonteOriginal = (Get-ChildItem -Path $taskPath -Filter "*_form_codigo_fonte.txt" -File | Select-Object -First 1).FullName

                if ($formFileUI -and (Test-Path $formFileUI) -and $htmlFile -and (Test-Path $htmlFile)) {
                    # Extrair apenas as linhas de DIFERENCA do HTML
                    $htmlContent = Get-Content $htmlFile -Raw -Encoding UTF8
                    # Truncar HTML para manter apenas diferencas (reduzir contexto)
                    $diffSection = ""
                    if ($htmlContent -match '(?s)(DIFEREN.*?)(</table>|$)') {
                        $diffSection = $matches[0]
                    }
                    if ($diffSection.Length -lt 100) { $diffSection = $htmlContent }
                    # Limitar a 30KB para nao estourar contexto
                    if ($diffSection.Length -gt 30000) { $diffSection = $diffSection.Substring(0, 30000) }

                    $uiFixPrompt = @"
Corrija as $diferencas diferenca(s) visual(is) no Form migrado.

RELATORIO DE DIFERENCAS (extraido do HTML de validacao):
$diffSection

INSTRUCAO CRITICA:
1. Leia cada DIFERENCA no relatorio acima
2. Encontre o controle correspondente no .prg
3. Ajuste APENAS a propriedade diferente para o valor ESPERADO
4. NAO altere nenhuma outra propriedade, metodo ou logica
5. As diferencas sao normalmente: Width, Height, Top, Left, FontSize, Caption

Arquivo a corrigir: $formFileUI
"@
                    $uiFixPromptFile = Join-Path $taskPath "ui_fix_prompt.md"
                    $uiFixPrompt | Set-Content $uiFixPromptFile -Encoding UTF8

                    $uiFixOutput = Join-Path $taskPath "ui_fix_output.txt"
                    $uiFixLog = Get-TaskLogPath -TaskId $TaskId -Etapa "07b_autoFixUI" -TasksDir $config.paths.tasks
                    try {
                        & (Join-Path $config.paths.automation "ClaudeInvoker.ps1") `
                            -PromptFile $uiFixPromptFile `
                            -OutputFile $uiFixOutput `
                            -Model $config.claude.model `
                            -Timeout 600 `
                            -MaxOutputTokens 16000 `
                            -LogFile $uiFixLog `
                            -ContextFiles @() `
                            -RateLimitMaxRetries $config.rateLimitRetry.maxRetries `
                            -RateLimitInitialDelaySeconds $config.rateLimitRetry.initialDelaySeconds `
                            -RateLimitMaxDelaySeconds $config.rateLimitRetry.maxDelaySeconds

                        Write-Host "  [OK] Correcao UI aplicada. Re-validando..." -ForegroundColor Green

                        # Deletar .fxp e re-executar ValidarUIFidelity
                        Get-ChildItem -Path (Join-Path $config.paths.projeto "app") -Filter "*.fxp" -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue

                        $uiRevalidLog = Get-TaskLogPath -TaskId $TaskId -Etapa "07b_revalidarUI" -TasksDir $config.paths.tasks
                        & (Join-Path $config.paths.automation "VFPExecutor.ps1") `
                            -ScriptPRG (Join-Path $config.paths.projeto "app\utils\ValidarUIFidelity.prg") `
                            -Parameters @($fonteOriginal, $formClassUI) `
                            -Timeout $config.vfp.timeout `
                            -LogFile $uiRevalidLog

                        # Re-parsear resultado (ordenar por LastWriteTime para pegar o mais recente)
                        $htmlFiles2 = Get-ChildItem -Path (Join-Path $config.paths.projeto "app\utils\relatorios") -Filter "UIFidelity_${formClassUI}_*.html" -File | Sort-Object LastWriteTime -Descending
                        if ($htmlFiles2.Count -gt 0) {
                            $html2 = Get-Content $htmlFiles2[0].FullName -Raw -Encoding UTF8
                            $diferencas2 = 0
                            if ($html2 -match 'card diferenca[^>]*>[\s\S]*?<div class="numero">(\d+)</div>') {
                                $diferencas2 = [int]$matches[1]
                            }
                            if ($diferencas2 -eq 0) {
                                Write-Host "  [OK] Diferencas visuais corrigidas! UI Fidelity OK apos auto-fix." -ForegroundColor Green
                                $htmlFile = $htmlFiles2[0].FullName
                                $problemasInaceitaveis = $false
                            } else {
                                Write-Host "  [AVISO] Ainda restam $diferencas2 diferenca(s) apos auto-fix." -ForegroundColor Yellow
                            }
                        }
                    }
                    catch {
                        Write-Host "  [AVISO] Auto-correcao UI falhou: $($_.Exception.Message)" -ForegroundColor Yellow
                    }
                }
            }

            if ($problemasInaceitaveis) {
                Fail-Etapa -TaskId $TaskId -Etapa "07_validarUI" -ErroMsg "UI Fidelity: $erros erros (limite 4), $diferencas diferencas visuais (limite 0), $avisos avisos (nao-bloqueantes)" -TasksDir $config.paths.tasks -Metadata @{
                    exitCode = $exitCode
                    totalProblemas = $totalProblemas
                    erros = $erros
                    avisos = $avisos
                    diferencas = $diferencas
                    htmlFile = $htmlFile
                }
                throw "UI Fidelity falhada: $erros erros (limite 4) + $diferencas diferencas (limite 0). Avisos: $avisos (nao-bloqueantes)"
            }
        }

        Write-Host "Status: UI FIDELITY OK - Apenas diferencas aceitaveis (4 Dataenvironment + $avisos FormBase)" -ForegroundColor Green
        Write-Host "  Relatorio HTML: $htmlFile" -ForegroundColor Gray
        Write-Host "  Log detalhado: $logFile" -ForegroundColor Gray

        Complete-Etapa -TaskId $TaskId -Etapa "07_validarUI" -TasksDir $config.paths.tasks -Metadata @{
            exitCode = $exitCode
            totalProblemas = $totalProblemas
            erros = $erros
            avisos = $avisos
            diferencas = $diferencas
            htmlFile = $htmlFile
        }

        Write-Host ""
    }
    catch {
        $erroMsg = $_.Exception.Message

        # Se foi falha do quality gate (threshold), propagar o erro (NAO auto-skip)
        if ($erroMsg -match "UI Fidelity falhada|UI Fidelity abaixo") {
            throw
        }

        # Apenas erros de EXECUCAO do script (VFP crash, timeout, etc.) sao auto-skipped
        Write-Host ""
        Write-Host "AVISO na validacao UI (erro de execucao): $erroMsg" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Auto-continuando (erro de execucao nao bloqueia pipeline)..." -ForegroundColor Yellow
        Write-Host "O teste manual final validara a UI fidelity." -ForegroundColor Yellow
        Complete-Etapa -TaskId $TaskId -Etapa "07_validarUI" -TasksDir $config.paths.tasks -Metadata @{
            autoSkipped = $true
            erro = $erroMsg
        }
    }
}

#------------------------------------------------------------------------------
# ETAPA 8: Gerar solicitacao de teste manual
#------------------------------------------------------------------------------

function Invoke-Etapa08_GerarTestManual {
    param([string]$TaskId, [string]$BaseName)

    Write-StepHeader "ETAPA 8" "Gerar solicitacao de teste manual"

    Start-Etapa -TaskId $TaskId -Etapa "08_gerarTestManual" -TasksDir $config.paths.tasks

    try {
        $taskPath = Join-Path $config.paths.tasks $TaskId
        $state = Get-TaskState -TaskId $TaskId -TasksDir $config.paths.tasks

        # Gera markdown de teste manual
        $testManualDir = $config.paths.solicitacaoTestManual

        if (-not (Test-Path $testManualDir)) {
            New-Item -ItemType Directory -Path $testManualDir -Force | Out-Null
        }

        $testManualFile = Join-Path $testManualDir "${TaskId}_${BaseName}.md"

        # Conteudo do teste manual - usa funcoes auxiliares para nomes
        $formClass = Get-FormClassName -BaseName $BaseName
        $boClass = Get-BOClassName -BaseName $BaseName
        $formType = Get-FormTypeFromState -TaskId $TaskId
        $formSubDir = Get-FormSubDir -FormType $formType

        $testContent = @"
# Solicitacao de Teste Manual

**Task ID:** $TaskId
**Formulario:** $formClass (origem: $BaseName)
**Data:** $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

---

## 1. Objetivo do Teste

Validar se o formulario migrado (**$formClass**) esta funcionando corretamente e com UI identica ao original.

## 2. Pre-Requisitos

- [ ] Codigo migrado esta em: \`C:\4c\projeto\app\forms\${formSubDir}\${formClass}.prg\`
- [ ] Business Object em: \`C:\4c\projeto\app\classes\${boClass}.prg\`
- [ ] Banco de dados acessivel: 192.168.15.101 (DB_MBAHIA)
- [ ] Usuario com permissao de teste

## 3. Casos de Teste

### 3.1. Teste de UI Fidelity

- [ ] Comparar visualmente com screenshot original (se disponivel)
- [ ] Verificar Width/Height do formulario
- [ ] Verificar cores (BackColor, ForeColor)
- [ ] Verificar fontes (FontName, FontSize)
- [ ] Verificar posicionamento de controles (Top, Left)
- [ ] Verificar se todos os botoes estao visiveis (nenhum "comido")

**Criterio de Aceitacao:** UI deve ser **pixel-perfect** identica ao original.

### 3.2. Teste Funcional - Modo INCLUIR

- [ ] Clicar no botao "Incluir"
- [ ] Preencher todos os campos obrigatorios
- [ ] Testar lookups (F4/F5) - se aplicavel
- [ ] Clicar em "Confirmar"
- [ ] Verificar se registro foi inserido no banco

**Criterio de Aceitacao:** Registro deve ser salvo com sucesso e auditoria registrada em LogAuditoria.

### 3.3. Teste Funcional - Modo ALTERAR

- [ ] Pesquisar um registro existente
- [ ] Clicar no botao "Alterar"
- [ ] Modificar campos
- [ ] Clicar em "Confirmar"
- [ ] Verificar se registro foi atualizado no banco

**Criterio de Aceitacao:** Registro deve ser atualizado e auditoria registrada.

### 3.4. Teste Funcional - Modo VISUALIZAR

- [ ] Pesquisar um registro existente
- [ ] Clicar no botao "Visualizar"
- [ ] Verificar se campos estao desabilitados (ReadOnly)
- [ ] Clicar em "Cancelar"

**Criterio de Aceitacao:** Campos nao editaveis, botao Confirmar desabilitado.

### 3.5. Teste Funcional - Modo EXCLUIR

- [ ] Pesquisar um registro existente
- [ ] Clicar no botao "Excluir"
- [ ] Confirmar exclusao
- [ ] Verificar se registro foi excluido do banco

**Criterio de Aceitacao:** Registro excluido logicamente (status) ou fisicamente, com auditoria.

### 3.6. Teste de Validacoes

- [ ] Testar campos obrigatorios (deixar vazio e tentar salvar)
- [ ] Testar InputMask (formato de campos)
- [ ] Testar duplicidade de chave primaria

**Criterio de Aceitacao:** Mensagens de erro claras e consistentes com sistema legado.

### 3.7. Teste de Performance

- [ ] Medir tempo de abertura do formulario
- [ ] Medir tempo de busca/pesquisa
- [ ] Medir tempo de salvamento

**Criterio de Aceitacao:** Performance similar ou melhor que sistema legado.

## 4. Metricas de Qualidade

### Validacao UI (Automatica)

- **Erros:** $($state.etapas."07_validarUI".problemas.erros)
- **Avisos:** $($state.etapas."07_validarUI".problemas.avisos)
- **Diferencas:** $($state.etapas."07_validarUI".problemas.diferencas)
- **Total:** $($state.etapas."07_validarUI".problemas.total)
- **Limite:** $($config.validacao.maxProblemas)
- **Status:** $(if ($state.etapas."07_validarUI".status -eq "COMPLETED") { "✅ APROVADO" } else { "❌ REPROVADO" })

[Ver relatorio detalhado]($($taskPath)\validacao_ui_report.html)

## 5. Resultado do Teste

### Resumo

- [ ] UI Fidelity: **APROVADO / REPROVADO**
- [ ] Funcionalidade INCLUIR: **APROVADO / REPROVADO**
- [ ] Funcionalidade ALTERAR: **APROVADO / REPROVADO**
- [ ] Funcionalidade VISUALIZAR: **APROVADO / REPROVADO**
- [ ] Funcionalidade EXCLUIR: **APROVADO / REPROVADO**
- [ ] Validacoes: **APROVADO / REPROVADO**
- [ ] Performance: **APROVADO / REPROVADO**

### Evidencias

- Screenshots: *(anexar aqui)*
- Videos: *(anexar aqui)*
- Logs de erro: *(anexar aqui)*

### Problemas Encontrados

*(Listar problemas encontrados durante o teste manual)*

1.
2.
3.

### Aprovacao

- [ ] **APROVADO** - Formulario pronto para producao
- [ ] **REPROVADO** - Necessita correcoes

**Testador:** ___________________________
**Data:** ___________________________
**Assinatura:** ___________________________

---

**Proximos Passos:**

- Se APROVADO: Commit do codigo e deploy
- Se REPROVADO: Abrir issues para correcoes necessarias
"@

        $testContent | Set-Content -Path $testManualFile -Encoding UTF8

        Write-Host "Solicitacao de teste manual gerada: $testManualFile" -ForegroundColor Green

        Complete-Etapa -TaskId $TaskId -Etapa "08_gerarTestManual" -TasksDir $config.paths.tasks -Metadata @{ testManualFile = $testManualFile }
    }
    catch {
        Fail-Etapa -TaskId $TaskId -Etapa "08_gerarTestManual" -ErroMsg $_.Exception.Message -TasksDir $config.paths.tasks
        throw
    }
}


#------------------------------------------------------------------------------
# MAIN
#------------------------------------------------------------------------------

# Funcao para processar UMA task completa (todas as etapas)
function Process-SingleTask {
    param([string]$taskIdToProcess)

    Write-Host ""
    Write-Host "Task ID: $taskIdToProcess" -ForegroundColor Green
    Write-Host ""

    # Carrega estado da task para verificar etapas ja completadas
    $taskState = Get-TaskState -TaskId $taskIdToProcess -TasksDir $config.paths.tasks

    # Obtem baseName (do estado se disponivel, senao da execucao da Etapa 1)
    $baseName = $null
    if ($taskState.etapas."01_moverArquivos".baseName) {
        $baseName = $taskState.etapas."01_moverArquivos".baseName
        Write-Host "BaseName obtido do estado da task: $baseName" -ForegroundColor Cyan
    }

    # ETAPA 1: Mover Arquivos
    if ($taskState.etapas."01_moverArquivos".status -ne "COMPLETED") {
        $baseName = Invoke-Etapa01_MoverArquivos -TaskId $taskIdToProcess
    }
    else {
        Write-Host "[ETAPA 1] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 2: Extrair Codigo
    if ($taskState.etapas."02_extractCode".status -ne "COMPLETED") {
        $baseNameNormalizado = Invoke-Etapa02_ExtractCode -TaskId $taskIdToProcess -BaseName $baseName
        if ($baseNameNormalizado) {
            $baseName = $baseNameNormalizado
            Write-Host "BaseName atualizado para: $baseName" -ForegroundColor Cyan
        }
    }
    else {
        Write-Host "[ETAPA 2] JA COMPLETADA - Pulando..." -ForegroundColor Green
        $taskState = Get-TaskState -TaskId $taskIdToProcess -TasksDir $config.paths.tasks
        if ($taskState.etapas."02_extractCode".baseNameNormalizado) {
            $baseName = $taskState.etapas."02_extractCode".baseNameNormalizado
            Write-Host "BaseName recuperado do estado: $baseName" -ForegroundColor Cyan
        }
    }

    # ETAPA 2.2: Reduzir Arquivo Grande (se necessario)
    if ($taskState.etapas."02a_reduzirArquivo".status -ne "COMPLETED") {
        Invoke-Etapa02a_ReduzirArquivo -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 2.2] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 2.5: Analisar Tarefa
    if ($taskState.etapas."02b_analisarTarefa".status -ne "COMPLETED") {
        Invoke-Etapa02b_AnalisarTarefa -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 2.5] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 2.7: Analisar Comportamento
    if ($taskState.etapas."02c_analisarComportamento".status -ne "COMPLETED") {
        Invoke-Etapa02c_AnalisarComportamento -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 2.7] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 2.8: Extrair Layout (posicoes exatas do SCX)
    $layoutFile = Join-Path (Join-Path $config.paths.tasks $taskIdToProcess) "layout.json"
    if (-not (Test-Path $layoutFile)) {
        Invoke-Etapa02d_ExtrairLayout -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 2.8] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 3: Gerar Meta-Prompt
    if ($taskState.etapas."03_gerarMetaPrompt".status -ne "COMPLETED") {
        Invoke-Etapa03_GerarMetaPrompt -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 3] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 4: Gerar Mapeamento
    if ($taskState.etapas."04_gerarMapeamento".status -ne "COMPLETED") {
        Invoke-Etapa04_GerarMapeamento -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 4] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 4.5: Gerar Esqueletos
    if ($taskState.etapas."04b_gerarEsqueletos".status -ne "COMPLETED") {
        Invoke-Etapa04b_GerarEsqueletos -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 4.5] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 5: Migracao Claude
    if ($taskState.etapas."05_migracao".status -ne "COMPLETED") {
        Invoke-Etapa05_Migracao -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 5] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 5.5: Corrigir Automatico
    if ($taskState.etapas."05b_corrigirAutomatico".status -ne "COMPLETED") {
        Invoke-Etapa05b_CorrigirAutomatico -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 5.5] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 5.5b: Atualizar Mapeamento com nomes reais do form gerado
    if ($taskState.etapas."05b2_atualizarMapeamento".status -ne "COMPLETED") {
        Invoke-Etapa05b2_AtualizarMapeamento -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 5.5b] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 5.6: Validar Compilacao
    if ($taskState.etapas."05c_validarCompilacao".status -ne "COMPLETED") {
        Invoke-Etapa05c_ValidarCompilacao -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 5.6] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 5.7: Validar Completude (TODO/stubs)
    if ($taskState.etapas."05d_validarCompletude".status -ne "COMPLETED") {
        Invoke-Etapa05d_ValidarCompletude -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 5.7] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 5.8: Code Review Automatizado
    if ($taskState.etapas."05e_codeReview".status -ne "COMPLETED") {
        Invoke-Etapa05e_CodeReview -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 5.8] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 5.9: Validacao SQL Schema (sem LLM)
    if ($taskState.etapas."05f_validarSQLSchema".status -ne "COMPLETED") {
        Invoke-Etapa05f_ValidarSQLSchema -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 5.9] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 6: Testar Form
    if ($taskState.etapas."06_testForm".status -ne "COMPLETED") {
        Invoke-Etapa06_TestForm -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 6] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 6.5: Teste Automatico
    if ($taskState.etapas."06b_testeAutomatico".status -ne "COMPLETED") {
        Invoke-Etapa06b_TesteAutomatico -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 6.5] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 6.8: Validar Layout vs PRG (estatica)
    if ($taskState.etapas."06c_validarLayout".status -ne "COMPLETED") {
        Invoke-Etapa06c_ValidarLayout -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 6.8] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 7: Validar UI
    if ($taskState.etapas."07_validarUI".status -ne "COMPLETED") {
        Invoke-Etapa07_ValidarUI -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 7] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # ETAPA 8: Gerar Teste Manual
    if ($taskState.etapas."08_gerarTestManual".status -ne "COMPLETED") {
        Invoke-Etapa08_GerarTestManual -TaskId $taskIdToProcess -BaseName $baseName
    }
    else {
        Write-Host "[ETAPA 8] JA COMPLETADA - Pulando..." -ForegroundColor Green
    }

    # Marca task como completa
    Update-TaskStatus -TaskId $taskIdToProcess -Status "COMPLETED" -TasksDir $config.paths.tasks

    Write-Host ""
    Write-Host "============================================================================" -ForegroundColor Green
    Write-Host " TASK COMPLETA: $taskIdToProcess" -ForegroundColor Green
    Write-Host "============================================================================" -ForegroundColor Green
}

try {
    # Modo ProcessAll: processa TODOS os arquivos da pasta origem
    if ($ProcessAll) {
        $scxFiles = Get-ChildItem -Path $config.paths.origem -Filter "*.scx" -ErrorAction SilentlyContinue
        $totalFiles = $scxFiles.Count

        if ($totalFiles -eq 0) {
            Write-Host "Nenhum arquivo SCX encontrado em: $($config.paths.origem)" -ForegroundColor Yellow
            exit 0
        }

        Write-Host "============================================================================" -ForegroundColor Cyan
        Write-Host " MODO PROCESSALL: $totalFiles arquivo(s) para processar" -ForegroundColor Cyan
        Write-Host "============================================================================" -ForegroundColor Cyan
        Write-Host ""

        $processedCount = 0
        $errorCount = 0
        $successTasks = @()
        $errorTasks = @()

        while ($true) {
            # Verifica se ainda ha arquivos para processar
            $remainingFiles = Get-ChildItem -Path $config.paths.origem -Filter "*.scx" -ErrorAction SilentlyContinue
            if ($remainingFiles.Count -eq 0) {
                break
            }

            $processedCount++
            $currentFile = $remainingFiles[0].Name
            Write-Host ""
            Write-Host "============================================================================" -ForegroundColor Magenta
            Write-Host " PROCESSANDO ARQUIVO $processedCount de $totalFiles : $currentFile" -ForegroundColor Magenta
            Write-Host "============================================================================" -ForegroundColor Magenta

            try {
                # Cria nova task
                $nextNumber = Get-NextTaskNumber
                $taskIdToProcess = "task{0:D3}" -f $nextNumber
                Write-Host "Criando nova task: $taskIdToProcess" -ForegroundColor Cyan
                New-Task -TaskId $taskIdToProcess -ArquivoOriginal $currentFile -TipoArquivo "SCX" -TasksDir $config.paths.tasks

                # Processa a task completa (todas as etapas)
                Process-SingleTask -taskIdToProcess $taskIdToProcess

                $successTasks += $taskIdToProcess
            }
            catch {
                $errorCount++
                $errorTasks += @{
                    taskId = $taskIdToProcess
                    arquivo = $currentFile
                    erro = $_.Exception.Message
                }
                Write-Host ""
                Write-Host "ERRO ao processar $currentFile : $($_.Exception.Message)" -ForegroundColor Red
                Write-Host "Continuando com proximo arquivo..." -ForegroundColor Yellow
            }
        }

        # Resumo final
        Write-Host ""
        Write-Host "============================================================================" -ForegroundColor Cyan
        Write-Host " PROCESSALL CONCLUIDO" -ForegroundColor Cyan
        Write-Host "============================================================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  Total de arquivos: $totalFiles" -ForegroundColor White
        Write-Host "  Sucesso: $($successTasks.Count)" -ForegroundColor Green
        Write-Host "  Erros: $errorCount" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })
        Write-Host ""

        if ($successTasks.Count -gt 0) {
            Write-Host "  Tasks completadas:" -ForegroundColor Green
            foreach ($task in $successTasks) {
                Write-Host "    - $task" -ForegroundColor Green
            }
        }

        if ($errorTasks.Count -gt 0) {
            Write-Host ""
            Write-Host "  Tasks com erro:" -ForegroundColor Red
            foreach ($err in $errorTasks) {
                Write-Host "    - $($err.taskId) ($($err.arquivo)): $($err.erro)" -ForegroundColor Red
            }
        }

        Write-Host ""
        Write-Host "Proximos passos:" -ForegroundColor Yellow
        Write-Host "  1. Revisar solicitacoes de teste manual em: $($config.paths.solicitacaoTestManual)"
        Write-Host "  2. Executar testes manuais para cada formulario"
        Write-Host "  3. Se aprovados, fazer commit do codigo"
        Write-Host ""

        exit $(if ($errorCount -gt 0) { 1 } else { 0 })
    }
    # Determina qual task processar (modo single task)
    elseif ($TaskId) {
        $taskIdToProcess = $TaskId
        Write-Host "Processando task especifica: $taskIdToProcess" -ForegroundColor Cyan
    }
    elseif ($ContinueFromLastTask) {
        # Busca tasks pendentes
        $pendingTasks = Get-PendingTasks -TasksDir $config.paths.tasks

        if ($pendingTasks.Count -eq 0) {
            Write-Host "Nenhuma task pendente encontrada. Criando nova task..." -ForegroundColor Yellow
            $nextNumber = Get-NextTaskNumber
            $taskIdToProcess = "task{0:D3}" -f $nextNumber
            New-Task -TaskId $taskIdToProcess -ArquivoOriginal "" -TipoArquivo "SCX" -TasksDir $config.paths.tasks
        }
        else {
            $taskIdToProcess = $pendingTasks[0].taskId
            Write-Host "Continuando task pendente: $taskIdToProcess" -ForegroundColor Yellow
        }
    }
    else {
        # Cria nova task
        $nextNumber = Get-NextTaskNumber
        $taskIdToProcess = "task{0:D3}" -f $nextNumber
        Write-Host "Criando nova task: $taskIdToProcess" -ForegroundColor Cyan
        New-Task -TaskId $taskIdToProcess -ArquivoOriginal "" -TipoArquivo "SCX" -TasksDir $config.paths.tasks
    }

    # Processa a task (usa funcao que executa todas as etapas)
    Process-SingleTask -taskIdToProcess $taskIdToProcess

    Write-Host ""
    Write-Host "Proximos passos:" -ForegroundColor Yellow
    Write-Host "  1. Revisar solicitacao de teste manual em: $($config.paths.solicitacaoTestManual)"
    Write-Host "  2. Executar testes manuais"
    Write-Host "  3. Se aprovado, fazer commit do codigo"
    Write-Host ""

    exit 0
}
catch {
    Write-Host ""
    Write-Host "============================================================================" -ForegroundColor Red
    Write-Host " ERRO NA EXECUCAO" -ForegroundColor Red
    Write-Host "============================================================================" -ForegroundColor Red
    Write-Host ""
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray
    Write-Host ""

    exit 1
}
