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
                else {
                    Write-Host "  [AVISO] analise.json nao traz form.formType - usando default CRUD" -ForegroundColor Yellow
                }
            }
            catch {
                # NUNCA silenciar: este catch fazia um analise.json INVALIDO virar
                # "formType = CRUD" sem uma linha de log, e esse CRUD e' PERSISTIDO
                # em task_state.json (03_gerarMetaPrompt.formType), de onde todas as
                # fases seguintes o leem. Em task597 o AnalisadorTarefa emitiu uma
                # EXPRESSAO VFP crua no lugar do "grid.top" (raspada de uma linha
                # MORTA do Init legado), o JSON ficou invalido, um form OPERACIONAL
                # foi rotulado CRUD e a Fase 4 reprovou - sem nenhum log apontando a
                # causa. Barulho aqui e' o que faltava.
                Write-Host "  [ERRO] analise.json ILEGIVEL: $($_.Exception.Message)" -ForegroundColor Red
                Write-Host "  [ERRO] formType cai no default CRUD - form OPERACIONAL/REPORT sera tratado como CRUD e os gates das Fases 3-8 vao exigir estrutura que o legado nao tem." -ForegroundColor Red
                Write-Host "  [ERRO] Corrigir $analiseFile (ou projeto\app\utils\AnalisadorTarefa.prg) ANTES de seguir." -ForegroundColor Red
            }
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

### O caso MAIS COMUM e o `RETURN` BARE de guarda (sem valor) - mesmo erro

Vale para RETURN BARE e com valor, no bloco TRY, no CATCH e no FINALLY (medido no VFP9).
`EXIT` e `LOOP` dentro do TRY sao SEGUROS. Guarda de early-exit so quebra quando a condicao
e atingida (validacao falha, campo vazio, SQLEXEC falha) - por isso o caminho feliz passa no
teste e o usuario descobre ao errar um campo. NAO basta trocar o RETURN por atribuicao:
sem envolver o resto do bloco, o codigo segue executando e grava errado EM SILENCIO.

```foxpro
*-- ERRADO - guarda com RETURN bare dentro do TRY:
PROCEDURE ValidarEstadosLista()
    TRY
        IF EMPTY(loc_cEstado)
            RETURN          && ERRO CRITICO - dispara em runtime
        ENDIF
        THIS.CarregarLista()
    CATCH TO loc_oErro
        MsgErro(loc_oErro.Message, "X")
    ENDTRY
ENDPROC

*-- CORRETO - flag + IF aninhado; nenhum RETURN dentro do TRY:
PROCEDURE ValidarEstadosLista()
    LOCAL loc_lProsseguir
    loc_lProsseguir = .T.

    TRY
        IF EMPTY(loc_cEstado)
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            THIS.CarregarLista()
        ENDIF
    CATCH TO loc_oErro
        MsgErro(loc_oErro.Message, "X")
    ENDTRY
ENDPROC
```

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
    LOCAL loForm, loException, lcMensagem

    loForm = .NULL.

    *-- O TRY cobre SO a CRIACAO. O Show() fica FORA - ver explicacao abaixo.
    TRY
        loForm = CREATEOBJECT("${formClass}")
    CATCH TO loException
        lcMensagem = "Erro ao abrir formulario ${formClass}:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
        loForm = .NULL.
    ENDTRY

    IF VARTYPE(loForm) = "O"                  && VARTYPE, NAO ISNULL
        loForm.Show()                         && FORA do TRY, SEM parametro
        *-- NAO chamar loForm.Release() - FormBase cuida disso
    ENDIF
ENDPROC
```
**POR QUE o Show() NAO pode ficar dentro do TRY** (Erro163_Aba1_2): form modal (`WindowType = 1`) faz o `Show()` BLOQUEAR - a tela inteira, cada Valid e cada Click, vive dentro da chamada. Em VFP9 o **TRY/CATCH tem PRECEDENCIA sobre ON ERROR em qualquer ponto da pilha** (medido: com 3 niveis de chamada entre o TRY e o erro, o ON ERROR NAO dispara e o CATCH do chamador pega). Entao qualquer erro durante o uso da tela salta para o CATCH, abandona o TRY, o `loForm` LOCAL perde a referencia e o form eh DESTRUIDO - `Destroy` sem `QueryUnload`. Para o usuario: "a tela fecha sozinha e o menu continua". Com o `Show()` fora, o erro cai no `ON ERROR` (quando o form instala um) e a tela SOBREVIVE.

**NUNCA usar**:
- `loForm.Show()` DENTRO do TRY (fecha a tela a cada erro de runtime)
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
- [ ] **BtnBuscarClick**: SEGUIR O LEGADO. Se o dump tem `PROCEDURE msv_procurar` (ou campos com `plProcurar = .T.`), o Buscar eh BUSCA POR EXEMPLO e NAO abre picker: poe o form em modo "BUSCAR", limpa a ficha, habilita SO os campos `plProcurar`, vai para a pagina de Dados, e quem executa a consulta eh o Confirmar (transcrever o `msv_procurar`, inclusive o `Do Case` e a ordem dos campos). Erro167/Erro177: esta linha ja mandou inventar picker em 73 forms cujo legado tem `msv_procurar`. `FormBuscaAuxiliar` eh legitimo para LOOKUP DE CAMPO (F4 num campo de codigo) - ali sim: `mAddColuna()`, `this_lAchouRegistro` ANTES do `Show()`, `this_lSelecionou` antes de atribuir o valor, e o 1o argumento do Init eh `gnConnHandle` (NAO tem ObterCodigoSelecionado)
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
- **Form WRAPPER de VCX: copiar TAMBEM o Left/Top dos filhos DIRETOS do container, nao so os das paginas**: controle que fica FORA da area do pai eh RECORTADO pelo Container - some da tela **sem erro, sem log e SEM APARECER EM SCREENSHOT**, entao nenhuma validacao visual do pipeline enxerga. No FormCliente os tres CommandGroup que trocam de aba (`cmdGCarac`/`cmdGFtec`/`cmdgpessoal`) ficaram no Left/Top da CLASSE do VCX (891..957, Top 540) porque o migrador so copiou os overrides do SCX dos controles das PAGINAS; como o `cnt_4c_Conta` tem `Width = 768` / `Height = 450` (fiel ao legado), os tres cairam fora e sumiram - o usuario entrava na aba de endereco e **nao tinha como voltar para a aba 1**, so restava Salvar. O SCX declarava `633,397` / `672,397` / `711,397`. Ao migrar wrapper, varrer no dump do SCX as linhas de UM ponto so (`^  nome.Left` / `^  nome.Top` - filho direto do container) e aplicar TODAS; as de varios pontos sao das paginas. Conferir `Left + Width <= pai.Width` e `Top + Height <= pai.Height`. Ignorar nome generico (`Command1`, `Option2`, `Text1`...): sao membros internos de CommandGroup/OptionGroup, posicionados pelo VFP
- **SCX que desloca um controle e NAO desloca o label vizinho: sobreposicao HERDADA, que comparar migrado x legado nunca pega**: quando o SCX sobrepoe o Left de um campo mas deixa o label/campo ao lado no Left da CLASSE, os dois se cruzam na tela. No FormCliente o SCX move getUFIBGE de 471 para 508 e nao move o label "Contato :" (518), que entra 15px DENTRO da caixa: a tela mostra "35ontato :". Copiar o SCX fielmente REPRODUZ o defeito, e toda validacao migrado-x-legado aprova, porque os dois concordam. Ao transcrever `.Left`, somar `Left + Width` do controle e conferir contra o `Left` do vizinho da MESMA linha (mesmo Top, +-6px) DENTRO DO MESMO CONTAINER - Left/Top sao relativos ao pai, comparar entre containers nao significa nada. Havendo cruzamento, preferir os valores da CLASSE (framework.vcx), que sao coerentes entre si, a inventar posicao nova; e registrar o desvio em comentario. Caso especial: controle que cabe INTEIRO dentro de outro fica inalcancavel ao clique (Get_Regiao 596..676 dentro de Get_Contato 565..717) - no legado esse campo costuma estar aposentado (linhas de Visible/obrigatoriedade COMENTADAS no VCX); esconder eh melhor que deixar soterrado. Label sem `.Width` eh AutoSize (classe say): a faixa real dele eh a do TEXTO, nao a da caixa (#23)
- **Metodo de VCX legado que o SCX sobrescreve SO para consertar layout: reaplicar no FUNIL de chamadas, nunca so no Init**: o p-code do VCX refaz o layout dele a CADA chamada. O mLeDados do clsconta termina com `.Top = Iif(.Tabs, 0, ThisForm.Height - This.PgframeDados.PageHeight)` e re-ancora os tres CommandGroup de navegacao com `.Top = (This.Height - .Height - 4)`. Medido: clsconta.pgframeDados.Height = 802 contra Form.Height = 600, entao com pcTpCadCli='1' o Top vira -198, a pagina 1 SOBE 195px e o container RECORTA o topo dela - o usuario clica Incluir e cai direto no bloco de endereco/contato (GetCEP.Top = 200 no SCX), sem Codigo/Nome/CPF na tela, sem erro, sem log e SEM APARECER EM SCREENSHOT. O SCX legado conserta com um override do PROPRIO metodo, que roda DEPOIS do DoDefault (DoDefault(...) seguido de thisform.cntConta.pgframeDados.Top = 0). Como o migrado instancia o VCX por AddObject e nao tem subclasse onde por o override, esse ajuste tem de rodar no FUNIL de chamadas do metodo (o wrapper Chamar<Metodo>Seguro) e tambem nos CATCH que engolem excecao - aplicar so no InicializarForm NAO adianta, porque o metodo roda de novo em TODO Incluir/Alterar/Visualizar. Ao migrar wrapper, procurar no dump do SCX uma PROCEDURE homonima de metodo do VCX: ela existe justamente para corrigir o que o p-code faz
- **PageFrame.ActivePage eh o PageOrder, NAO a ordem de declaracao das Pages**: no clsconta, pgframeDados1 (Cadastro) tem PageOrder=1, pgframeDados2 (Pessoal) tem PageOrder=**3** e pgframeDados7 (Complemento) tem PageOrder=**2**. O migrado fazia `ActivePage = 2` achando que ia para Pessoal e caia em Complemento; pior, o `cmdPessoal.Click` do VCX so age com ActivePage 1 ou 3 (`Case ActivePage==1 -> ActivePage = 3` / `Case ActivePage==3 -> ActivePage = 1`), entao depois disso ele ficava MORTO e o F5 nao fazia mais nada. Compila limpo, so aparece na tela. Nunca derivar ActivePage do sufixo do nome da Page - ler o PageOrder da CLASSE. E quando o legado navega chamando o Click de um botao (o KeyPress do SCX chama `cmdGPessoal.cmdPessoal.Click()` e MAIS NADA), TRANSCREVER isso: nao pre-setar ActivePage antes de delegar, senao o toggle do VCX perde a referencia e vira no-op
- **Membro INTERNO de CommandGroup/OptionGroup com NOME PROPRIO: aplicar os overrides do SCX (excecao da regra do nome generico)**: ignorar `Command1`/`Option2`/`Text1` continua certo, mas quando o membro tem nome proprio e o SCX declara geometria para ele (`cmdGCarac.cmdCarac.Top/Left/Height/Width/Picture/...`), esses overrides sao OBRIGATORIOS - o grupo eh AutoSize=.T. e eh a geometria do botao INTERNO que DEFINE a altura do grupo. Medido no VFP9: inner 32x32 em 5,5 (classe) da grupo de 42; inner 40x40 em 5,5 (SCX) da grupo de 50 - e so com 50 o `.Top = (Height - .Height - 4)` do mLeDados cai em 396, que eh o mesmo 397 que o SCX declara no grupo. Copiar so o Left/Top do GRUPO deixa os tres botoes menores e fora da linha desenhada pelo legado. Para ler as propriedades REAIS de uma classe de VCX (o .VCT eh p-code e grep devolve lixo), abrir a .vcx como DBF no proprio VFP9 e ler a coluna Properties: USE framework\classresp.vcx + SCAN por ObjName/Class
- **Wrapper de funcao global do legado tem de reproduzir o CONTRATO, nao so o nome**: redirecionar para a primitiva VFP de nome parecido NAO basta. `IsEmpty` do Fortyus nao eh `EMPTY` do VFP - medido: `EMPTY(.NULL.)` devolve `.F.`, isto eh, "nao esta vazio", enquanto o `IsEmpty` do legado trata NULL como vazio. O wrapper `utils\isempty.prg` fazia so `RETURN EMPTY(par_uValor)` e divergia exatamente no caso NULL, em 142 call sites do p-code. O sintoma aparece LONGE da causa e sem erro nenhum: o `mRetiraNull` do clsconta limpa nulos com `Update crSigCdCli Set Obs = "" Where IsEmpty(Obs)`, o WHERE nao casava, a linha nunca era limpa e o campo Obs. do Cadastro de Cliente exibia `.NULL.` na tela. Conserto: guarda de NULL ANTES de delegar, com IF separado e nao `ISNULL(x) OR EMPTY(x)` - VFP9 nao faz short-circuit em OR. Ao escrever ou revisar wrapper em `utils\`, testar explicitamente NULL, vazio, zero, `.F.` e argumento AUSENTE, e conferir contra o que os call sites do p-code esperam; vale para qualquer coluna que venha do SQL Server permitindo NULL. Delegacao com guarda de tipo eh o padrao certo (ver fvalidarcpf.prg / fvalidarcnpj.prg, que checam VARTYPE antes de delegar)
- **Form WRAPPER de VCX: auditar as properties de ThisForm que o p-code toca, e separar as que o VCX cria sozinho das que nao**: o p-code chama ThisForm.<x> em dezenas de pontos, e para a maioria ele mesmo se vira, com o par guarda + `AddProperty` (If Type('ThisForm.OldEmpresa') == 'U' -> ThisForm.AddProperty('OldEmpresa', ...)). Essas NUNCA dao erro e nao precisam ser declaradas no form. As que aparecem CRUAS, sem esse par, sao exatamente as que estouram em runtime: no `clsconta` sao 18 properties customizadas, 17 auto-criadas e UMA nao - `AlterouLgpd`, que fazia gravar uma ALTERACAO no Cadastro de Cliente estourar "Erro 1734: Property ALTEROULGPD is not found" dentro do mGravaDados. Varrer assim: abrir a .vcx como DBF no VFP9 e dumpar a coluna `Methods` SO dos registros cujo Parent+ObjName contem o nome da classe (grepar o .VCT inteiro mistura TODAS as classes do arquivo e traz lixo do p-code), extrair ThisForm.<x> desse dump, descontar as nativas de Form (Name, LockScreen, Height, BackColor, DataSessionId, Refresh, AddProperty) e cruzar com o que o .prg migrado ja declara. Property de OBJETO do legado que o migrado nao tem (ThisForm.Pagina, o PageFrame do frmcadastro) so eh segura se TODO uso estiver dentro de If Type('...')=='O' - conferir, nao presumir. Antes de declarar, conferir tambem que os CURSORES do bloco recem-habilitado existem, senao troca-se um erro por outro. E declarar NAO basta quando o ciclo de vida difere: o legado eh modal e vive UM registro, o migrado nao fecha entre um e outro, entao flag de sessao tem de ser RESETADO no funil de chamadas - sem isso o primeiro registro em que alguem tocar no consentimento deixa `AlterouLgpd` ligado para sempre e todo ALTERAR seguinte grava historico de LGPD FALSO. Auditoria: automation\VerificarPropsThisFormVCX.ps1
- **Funcao GLOBAL do legado Fortyus chamada pelo p-code do VCX: criar WRAPPER em utils\, NUNCA deixar faltando**: os VCX (framework.vcx / classobj.vcx / classresp.vcx) chamam funcoes da aplicacao legado (sig.prg / SIGFUNCS.PRG) que NAO vieram no acervo - fSQLExec, fChkCpoVlc, fChkCntVlc, fGravarLog, fValidarCpf, fValidarCNPJ, fAbrirTabs, fVerificaPasta, fMensagemFixa, fInibirBtn, fGerPDFCreator, fConfigGeral. O p-code esta COMPILADO e nao da para editar: o VFP procura <nome>.prg no PATH e so estoura em RUNTIME, dentro de Init/Valid/Click FORA de qualquer TRY/CATCH -> o form FECHA (Erro163_Aba1: digitar a UF no Cadastro de Cliente fechava a tela porque GetEstado.Valid faz CreateObject('fwBuscaExt',...) SEM o guard Type()=='O' que o GetCEP tem, e o Init do fwBuscaExt chama fSQLExec). O wrapper vai em projeto\app\utils\<nome minusculo>.prg no padrao de isempty.prg: LPARAMETERS + RETURN, SEM cabecalho FUNCTION - o arquivo eh resolvido pelo NOME. Auditar com automation\VerificarFuncoesLegadoVCX.ps1. NUNCA criar stub que devolve VALOR DE CALCULO (fCalcularST / fCalcularIPI): devolver 0 grava imposto errado em silencio (regra #17) - ausente eh mais seguro, porque o erro aparece alto. Vale igual para OBJETO global: goSistema.ObjectConn (cOpenConn, classes\sigclcnx.PRG) tem de existir, senao CreateObject('fSqlConector','cep') devolve pnIdConn = -1 e o VCX exibe "Impossivel Efetuar Conexao Com o Servidor de Banco de Dados..."
- **SET PATH TO com varias expressoes entre parenteses honra SO a PRIMEIRA**: SET PATH TO (a), (b), (c) faz o VFP9 usar so (a) e descartar o resto EM SILENCIO - sem erro de compilacao nem de runtime. Concatenar numa string unica: SET PATH TO (a + "," + b + "," + c). Eh especifico do SET PATH - SET PROCEDURE e SET CLASSLIB com varias expressoes entre parenteses funcionam normalmente. Sintoma tipico e distante da causa: .prg que EXISTE aparecendo como "File does not exist" (foi assim que isempty.prg dos VCX legado ficou inalcancavel); diante disso, medir SET("PATH") ANTES de mexer no arquivo
- **Propriedade que a CLASSE NAO TEM compila limpo e a TELA NAO ABRE**: atribuir .Prop a controle cuja classe base nao tem Prop nao eh erro de compilacao - estoura no Init, dentro do TRY, com "Property FORECOLOR is not found", e o usuario clica no menu e nada abre. Medido no VFP9: OptionGroup e CommandGroup NAO tem ForeColor (so BackColor); PageFrame nao tem ForeColor, BackColor nem BackStyle; ListBox nao tem ForeColor/BackColor (sao ItemForeColor/ItemBackColor); Shape nao tem ForeColor (sao BorderColor/FillColor) nem ShapeType (isso eh VB; no VFP eh Curvature); ZOrderSet nao existe em runtime em classe nenhuma (eh bookkeeping do Form Designer, gravado no SCX - remover, pois o equivalente eh o METODO ZOrder()). A cor de grupo mora nos MEMBROS e o SCX legado JA declara assim (Option1.ForeColor = 255,0,0) - transcrever o dump, e conferir se os OUTROS botoes do form nao perderam o ForeColor que o legado declara. Cuidado tambem com WITH aninhado, que sequestra o escopo e da o mesmo erro: dentro de WITH THIS.this_oBusinessObject, um WITH THIS.cnt_X faz .this_nProp (property do BO) resolver contra o Container. Auditoria: automation\VerificarPropriedadesInexistentes.ps1
- **`Controls` eh indexado por NUMERO - passar o NOME faz a tela nao abrir**: `Controls` eh array, nao colecao por chave. Medido no VFP9: `Controls("nome")` em expressao estoura "Invalid subscript reference" e, dentro de `WITH`, "CONTROLS is not an object" - compila limpo e so quebra no Init. O `PEMSTATUS(obj, "nome", 5)` que costuma cercar esses blocos devolve .T. e NAO protege (mesma armadilha da regra do BINDEVENT/metodo PROTECTED). Para alcancar membro por NOME: `EVALUATE("obj." + nome + ".Prop")` na LEITURA e `STORE valor TO ("obj." + nome + ".Prop")` na ATRIBUICAO; `WITH EVALUATE("obj." + nome)` tambem funciona. Se o que se quer eh o INDICE, escrever helper nome->indice varrendo ControlCount. `Controls(N)` numerico continua certo e eh o uso majoritario
- **A pagina LISTA segue o `Init` legado, nao o SCX desenhado**: (a) o filtro eh aplicado SEMPRE, inclusive VAZIO - o legado liga a grade a `Select * From X Where Col = ?m.pcVar` com a variavel vazia no Init, entao a Lista abre VAZIA de proposito; `IF !EMPTY(filtro)` caindo em `Buscar("")` traz a TABELA INTEIRA. (b) a grade espelha o `pColuna` do `AddCursor` (nome, caption e largura de cada coluna), NAO os headers desenhados no SCX - no Formgpd o SCX tinha 3 colunas e o pColuna tem 4, e a coluna que faltava tambem faltava no SELECT do BO. (c) `Column.Width` vai por ULTIMO: mexer em RecordSource/ControlSource e na fonte do Grid faz o VFP recalcular tudo para o default 90
- **Campo de filtro da Lista tem os DOIS eventos do legado**: tipicamente `Valid` (se o codigo digitado nao existe, abre o picker; ESC limpa o campo) e `LostFocus` (recarrega a grade ao SAIR do campo, nao so no Enter). Migrar so o KeyPress com Enter faz o campo "nao trazer nada". Como BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox, implementar as duas coisas no handler de LostFocus
- **`FormBuscaAuxiliar`: o 1o argumento eh o HANDLE da conexao**: a assinatura eh Init(par_nConn, par_cTabela, par_cCursor, par_cCampo, par_cValor, par_cTitulo, par_lBuscaExata, par_lMostraGrid, par_cFiltro) e o Init faz `SQLEXEC(par_nConn, ...)`. Passar a tabela (ou um cursor, ou um SELECT) no lugar de gnConnHandle desloca TODOS os argumentos e a consulta nunca acontece - o picker abre VAZIO, sem erro nenhum, porque o Init tem `IF VARTYPE(par_cTabela) != "C" / RETURN .T.`. Auditoria: automation\VerificarFormBuscaAuxiliar.ps1
- **`FormBuscaAuxiliar` tem CONTRATO - `this_lAchouRegistro` antes do `Show()`**: o Init ja tenta o match EXATO e, achando 1 registro, marca this_lAchouRegistro e this_lSelecionou - o valor esta resolvido e o picker NAO deve ser mostrado. Padrao canonico (137 arquivos): `IF !loc_oBusca.this_lAchouRegistro` envolvendo mAddColuna+Show, e a atribuicao SO dentro de `IF loc_oBusca.this_lSelecionou AND USED(<cursor>)`. Os dois erros andam juntos: Show desguardado abre o dialogo por cima da tela ja preenchida; atribuir o valor FORA da guarda (tipico `<controle>.Value = loc_cCodigo` no FIM do metodo) ZERA o campo quando nada foi escolhido, e o filtro/grade que dependia dele esvazia. NAO duplicar a checagem de existencia com um SQLEXEC proprio antes do picker: o Init ja faz isso
- **`.Self` NAO existe em VFP9 - dentro de `WITH`, repetir a expressao**: `Self` eh de Delphi/Object Pascal; o objeto VFP nao tem essa propriedade e dentro de um bloco WITH nao ha como referenciar o proprio objeto com ponto. Medido: `WITH obj` + `PEMSTATUS(.Self, "x", 5)` estoura **"Property SELF is not found"**, e `PEMSTATUS(obj, "Self", 5)` devolve .F. O correto eh repetir a expressao do WITH: `PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)`. COMPILA LIMPO e so quebra em RUNTIME
- **Pagina preenchida por DOIS metodos: se um esquecer o +29, a aba fica com texto sobre texto**: quando `ConfigurarAba<X>` e `ConfigurarPgpg<X>` preenchem a MESMA `pgf_4c_Divisoes.PageN`, basta um deles transcrever o Top CRU do SCX (sem a compensacao do `pgf_4c_Paginas.Top = -29`) para os controles dele cairem ~29px acima e pousarem sobre o que o outro ja desenhou. NAO ha erro nem log - so a aba desformatada. Medido no Formgpd: o ConfigurarPgpgConfig tinha 67 dos 83 controles com o Top cru. Ao escrever QUALQUER metodo Configurar*, conferir que TODO Top recebeu o +29, e que o comentario de origem cita o controle certo do dump
- **Migrador lendo o controle ERRADO no dump**: tres defeitos da mesma origem no Erro175 - (a) `Tptribs` recebeu o Top do `Get_CodServs` (409) em vez do `Get_TpTrib` (385), e as duas linhas viraram uma so; (b) `Obrigfiscs` foi para Left=440 quando o legado tem Left=176, parando do outro lado da tela sobre outro bloco; (c) label DUPLICADO - o ConfigurarAba* inventou um label ("Obrig. Fiscal :") para uma linha cujo label o ConfigurarPgpg* ja criava a partir do legado ("Class. Fiscal Obrigatoria :"). Ao achar dois labels na mesma linha, conferir qual existe no SCX: o legado tem UM
- **NAO existe deteccao automatica de offset/sobreposicao comparando com o legado**: tentado duas vezes e medido - varrendo o projeto contra o layout.json inteiro deu 4220 achados em ~230 forms (quase tudo falso positivo, inclusive num form ja corrigido); a versao dirigida por metodo+pagina acusou 49 num metodo recem-corrigido e 18 num que estava certo. A raiz eh a mesma do detector de "controle fora da area do pai": o PILAR 3 manda RENOMEAR os objetos, entao casar migrado com legado so resta por geometria, e sempre aparece um sosia. Serve para diagnosticar UM caso conhecido, nao para validar em massa nem para confirmar o conserto - o conserto se confere instanciando e olhando a tela
- **`Program Error` CRU do VFP em vez do dialogo do projeto = metodo SEM TRY/CATCH**: quando o erro aparece na janelinha "Program Error" do proprio VFP (Cancel/Suspend/Ignore/Help) e nao no MostrarErro/FormErro do sistema, o metodo que estourou nao tem TRY/CATCH. Usar isso para localizar: procurar o metodo sem TRY/CATCH no caminho do botao que o usuario acionou (no Erro174 era BtnIncluirClick -> AjustarBotoesPorModo)
- **Abrir form MODAL de dentro de `LostFocus` pede guarda de reentrancia**: o Show() bloqueia, o foco sai e volta, e o proprio LostFocus pode disparar de novo, empilhando um segundo picker. Usar property booleana no form, setada na entrada e limpa DEPOIS do ENDTRY (para valer tambem quando o CATCH dispara). Diagnostico barato: num teste headless, Show() de form modal TRAVA a execucao - se o script termina dentro do timeout, o picker nao abriu
- **Init de form grande falha em CADEIA - "a tela abre" so se prova INSTANCIANDO**: cada defeito no Init esconde o proximo. Antes de dar por pronto, instanciar de verdade (CREATEOBJECT com gb_4c_ModoTeste/gb_4c_ValidandoUI) e repetir ate passar. Tres defeitos tipicos, cada um so visivel depois do anterior: (a) `Controls(<nome>)`; (b) `.ColumnN.Check1.<prop>` sem `AddObject`+`CurrentControl` -> "Unknown member CHECK1", porque a Column nasce so com Header1/Text1; (c) metodo CHAMADO mas nunca GERADO -> "Property X is not found", que pode significar uma ABA INTEIRA perdida (no Formgpd eram 71 controles). Auditar todo `THIS.<membro>` contra o proprio form E a heranca de FormBase/BusinessBase/GridBase. Ao reconectar aba perdida, conferir o TIPO da property no BO: coluna `numeric(1,0)` MULTI-VALOR achatada em LOGICO com `(col = 1)` faz valores 2..7 lerem .F. e regravarem 0 - converter para numerico ANTES de mapear
- **Icone: TRANSCREVER o Picture do legado, NUNCA inventar o nome do arquivo**: o VFP9 aceita .Picture/.Icon apontando para arquivo inexistente SEM erro nenhum (nem compilacao, nem runtime, nem log) - o controle so nao desenha icone. Copiar o Picture do controle correspondente no dump do legado e conferir que o arquivo existe em vbmp\. NAO escolher icone por semelhanca semantica: no FormBAL o botao "Fecha" usa cadastro_salvar_60.jpg (fechar a contagem = gravar) e no FormSigPrGlp "Disponiveis" usa geral_palete_60.jpg, nao uma lupa. Atencao: o arquivo real eh cadastro_vizualizar_60.jpg (com Z) e o sufixo _26/_60 NAO eh o tamanho (todos os icones sao 32x32)
- **Format contendo "M" = multiple choice, e o InputMask eh a LISTA de valores validos**: se o SCX legado declara Format = "M" ou "KM", o InputMask NAO eh mascara de digitacao e sim a lista separada por virgula (",T,S,I,N,F", "S,N", "A,B", "0,1", "S,N, "). TRANSCREVER o par LITERALMENTE do dump - trocar o M por "!" ou descartar o InputMask compila limpo e faz o campo aceitar QUALQUER caractere. Lista SEM item vazio coage branco para o 1o item (e o comportamento do legado)
- NUNCA usar literais acentuados - usar CHR(): a=225, c=231, ao=227, e=233, etc.
- NUNCA RETURN dentro de TRY/CATCH - inclui o RETURN BARE de guarda (sem valor), e vale no bloco TRY, no CATCH e no FINALLY. Fix: flag `loc_lProsseguir = .F.` no lugar do RETURN + envolver o resto do bloco em `IF loc_lProsseguir ... ENDIF` + RETURN unico DEPOIS do ENDTRY. So trocar o RETURN por atribuicao SEM envolver o resto descarta o early-exit e grava errado em silencio. `EXIT`/`LOOP` dentro do TRY sao seguros
- NUNCA usar .Release() em objetos Custom/BO - apenas em objetos Form
- BINDEVENT funciona apenas com metodos PUBLIC (sem PROTECTED)
- **TesteAutomatico.prg chama metodos direto no oForm (nao so BINDEVENT)**: CarregarLista/AlternarPagina/AjustarBotoesPorModo/BtnIncluirClick/BtnCancelarClick sao chamados como `THIS.oForm.Metodo()` de FORA da classe. PEMSTATUS(oForm,"Metodo",5) retorna .T. mesmo se o metodo for PROTECTED (so verifica existencia, nao escopo) - o teste entra no branch e a chamada real falha com "Property METODO is not found." em runtime. Esses metodos DEVEM ser PUBLIC (sem PROTECTED).
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
- **Comentario de design decision NUNCA leva a frase "nao implementado"**: ao documentar por que um BO somente-leitura (form de CONSULTA sem INSERT/UPDATE/DELETE no legado) nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao(), NAO escrever "nao implementado"/"nao implementada" dentro de linha de comentario `*` - o validador 05d_validarCompletude tem regex que casa "nao implement" em QUALQUER comentario (nao so em TODO real) e rejeita a fase por falso positivo. Preferir frase como "o comportamento padrao herdado de BusinessBase ja eh o correto".
- **Label de dados: NUNCA inventar ``.Width`` + ``.Alignment = 1``**: a classe ``say`` do Framework legado eh ``AutoSize = .T.`` / ``Alignment = 0`` â€” o ``Say`` do SCX declara so ``Caption``/``Left``/``Top``, e esse ``Left`` ja foi calculado para o texto terminar poucos pixels antes do campo (FormCES: 411/415/415/418 com os TextBox em 455, textos terminando em 451). Inventar ``.Width = 60`` + ``.Alignment = 1`` encosta o texto na borda DIREITA da caixa, que cai DENTRO do TextBox; como o label eh criado antes, o controle desenha por cima e a legenda sai cortada ("Codigo :" vira "Codi") â€” compila limpo, so aparece na tela. Copiar ``Alignment``/``Width`` do dump: se o ``Say`` nao declara nenhum dos dois, usar ``.Alignment = 0`` com ``.Width`` que caiba o texto. ``AutoSize = .T.`` NAO resolve: eh no-op em Label criado por ``AddObject`` (a Width fica nos 100 do default). Auto-fix: CorretorAutomatico #202.
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
- **CheckBox.Value NUNCA atribuir DIRETO a prop LOGICAL do BO (dispara "Data type mismatch" no AND)**: Em `FormParaBO`/`FormParaRelatorio`, SEMPRE converter numerico para logico ao atribuir chk.Value em property declarada `.F.`/`.T.`: `.this_lXXX = (loc_oCnt.chk_4c_XXX.Value = 1)` — NUNCA `.this_lXXX = loc_oCnt.chk_4c_XXX.Value`. Sem conversao, a property vira NUMERICA (0/1) e a proxima expressao `<logical> AND <this_lXXX>` no BO dispara **erro 9 "Data type mismatch"** (nao 1817 "Operator/operand type mismatch" como esperado — VFP9 mascara). Reciproca em BO: em condicoes AND, NUNCA escrever `AND <numeric_field>` — sempre `AND <numeric_field> <> 0`. Ex: `IF SEEK(x) AND crSigCdMoe.Cotas <> 0` (NAO `AND crSigCdMoe.Cotas`); `IF !EMPTY(Nops) AND THIS.this_lProdutos` FALHA se this_lProdutos veio numerico do chk. Regra critica correlata: CATCH em `PrepararDados`/`Processar`/`BtnVisualizarClick` SEMPRE incluir `loc_oErro.LineNo` + `loc_oErro.Procedure` na msg (`MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em <PROC>")`) para localizar erros VFP mascarados. Auto-fix: CorretorAutomatico #150. Bug em FormSigReAtm/FormBlq/Formsigregli/FormSIGRECTL (2026-07-28, Erro65).
- **fCarregarCambio() NAO PORTADA - usar THIS.CarregarCambio() local**: Funcao legada `fCarregarCambio(pMoe, pDia)` do framework Fortyus (SIGFUNCS.PRG:5156) NUNCA foi portada para `projeto/app/utils/functions.prg`. Todo BO que converta moeda DEVE implementar `PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_xData)` local usando cursores `crSigCdCot` + `crSigCdMoe` (ou `cursor_4c_SigCdCot`/`cursor_4c_SigCdMoe` conforme naming do proprio BO — confirmar em `InicializarDados`/`InicializarCursores`). Chamar via `THIS.CarregarCambio(...)`. Se BO ja tem `THIS.ObterCotacao` (padrao sigprilaBO), reusar em vez de duplicar. Template canonico do metodo em `SigReAtmBO.prg:857` ou `SigReInvBO.prg:205`. Chamada direta a `fCarregarCambio(...)` quebra em runtime — mas o erro NAO eh "File not found" como esperado: VFP9 mascara e dispara "Data type mismatch" via CATCH de PrepararDados. Auto-fix: CorretorAutomatico #151. Bug em SigReAtmBO/sigprccpBO/sigreeqeBO/sigprilaBO (2026-07-28, Erro65).
- **`VAL(SET("Decimals"))` PROIBIDO - `SET("Decimals")` ja retorna NUMERIC em VFP9**: A funcao `SET()` retorna tipos DIFERENTES conforme a opcao: `SET("Escape")`/`SET("Fixed")`/`SET("Century")`/`SET("Talk")`/`SET("Date")`/`SET("Path")`/`SET("Point")`/`SET("Separator")` retornam **CHARACTER** ("ON"/"OFF"/valor); mas `SET("Decimals")` e `SET("REPORTBEHAVIOR")` retornam **NUMERIC**. Envolver retorno numerico com `VAL()` dispara **VFP9 erro 11 "Function argument value, type, or count is invalid."** imediatamente. Bug tipico: migrador copia o padrao de salvar/restaurar contexto de outros SETs e por reflexo escreve `loc_nDec = VAL(SET("Decimals"))`. **CORRETO**: `loc_nDec = SET("Decimals")` (sem VAL); `loc_nBhv = SET("REPORTBEHAVIOR")` (sem VAL). Restaurar: `SET DECIMALS TO loc_nDec` / `SET REPORTBEHAVIOR loc_nBhv`. Auto-fix: CorretorAutomatico #152. Bug em sigrebalBO (2026-07-28, Erro66) — quebrava PrepararDados imediatamente ao clicar Visualizar.
- **REPORT `Visualizar`/`Imprimir` — `IF !PrepararDados() / flag=.F. / ENDIF / REPORT FORM` fall-through PROIBIDO**: quando `PrepararDados()` retorna `.F.` (cursor vazio, filtros sem match, erro SQL), o bloco `IF ! ... ENDIF` seta a flag mas NAO interrompe o fluxo — cai direto em `REPORT FORM` que roda com cursor vazio/erro. Sintomas: preview em branco, "File does not exist", ou pior — NENHUMA mensagem para o usuario (que espera "Nenhum registro encontrado..."). **VARIANTE DOUBLE-IF (Erro110)**: mesma armadilha com 2+ IFs consecutivas — `IF !PrepararDados() / flag=.F. / ENDIF / IF !MontarCabecalho() / flag=.F. / ENDIF / REPORT FORM` — ambos IFs fall-through, REPORT FORM sempre roda. **FIX MINIMO (auto)**: adicionar `RETURN loc_l<Flag>` dentro do ULTIMO IF antes do ENDIF (early exit). **FIX IDEAL (manual)**: refatorar para fluxo positivo com AND encadeado `IF THIS.PrepararDados() AND THIS.MontarCabecalho() / loc_lSucesso = THIS.ExecutarReportForm("<Base>", "PREVIEW"\|"PRINTER_PROMPT"\|"PRINTER", THIS.this_cCursorDados) / THIS.LimparCursores() / ELSE / IF !EMPTY(THIS.this_cMensagemErro) / MsgErro(THIS.this_cMensagemErro, "Erro") / ENDIF / ENDIF` — helper canonico traz cursor-empty guard (MsgAviso automatico "Nenhum registro encontrado com os filtros informados."), FRX-existence check, locale isolation e menu restore. Template do helper em SigReAtmBO.prg:857 ou SigReCgcBO.prg (pos-Erro68) ou sigrecprBO.prg (pos-Erro110). Auto-fix: CorretorAutomatico #153 (minimo, agora cobre variante double-IF) + WARNING para refactor completo. Bug em sigrecheBO/sigredcoBO/SIGREDIRBO/SigReFtpBO (2026-07-28, Erro68); sigrecprBO/sigrechpBO (2026-08-12, Erro110 double-IF).
- **REPORT `PrepararDados` — `loc_lSucesso = .T.` INCONDICIONAL apos IF de erro PROIBIDO**: NUNCA escrever `IF loc_nResult < 0 / loc_lSucesso = .F. / ENDIF / SELECT (cursor) / GO TOP / loc_lSucesso = .T.` — a atribuicao final SOBRESCREVE o `.F.` setado no error branch. PrepararDados sempre retorna `.T.` mesmo com SQL error, e Visualizar/Imprimir chegam ao REPORT FORM com cursor invalido. **FIX**: envolver o success-path em ELSE explicito: `IF loc_nResult < 0 / loc_lSucesso = .F. / ELSE / SELECT (cursor) / GO TOP / loc_lSucesso = .T. / ENDIF`. Pattern correlato do fall-through Erro68/Erro110: garante que `PrepararDados` retorne `.F.` quando devido. Auto-fix: CorretorAutomatico #164 (WARNING-only — refactor exige contexto). Bug em sigreifxBO/SigReInfBO/SIGREIPSBO (2026-08-12, Erro110).
- **`IF !FILE(loc_cFrx)` bloco morto em REPORT `Visualizar`/`Imprimir` PROIBIDO**: template legado deixava `IF !FILE(loc_cFrx) / MsgErro/MsgAviso / loc_lXxx = .F. / ENDIF` DEPOIS do `IF !PrepararDados()` e ANTES de `THIS.ExecutarReportForm(...)`, com `loc_cFrx` declarado `LOCAL` mas NUNCA atribuido. VFP inicializa LOCAL como `.F.` (logical), logo `FILE(.F.)` dispara **VFP9 erro 11 "Function argument value, type, or count is invalid."** ao clicar Visualizar. NUNCA gerar esse bloco — o helper `THIS.ExecutarReportForm(...)` (Pattern #117) ja faz `FULLPATH + FILE + MostrarErro` descritivo. Template correto (fluxo positivo): `IF THIS.PrepararDados() / loc_lSucesso = THIS.ExecutarReportForm("<Base>", "PREVIEW"\|"PRINTER_PROMPT"\|"PRINTER", "<cursor>") / ENDIF` — sem qualquer referencia a `loc_cFrx`. Auto-fix: CorretorAutomatico #157 remove bloco morto quando (a) BO herda RelatorioBase, (b) `loc_cFrx` nunca eh atribuido, (c) bloco eh seguido de `ExecutarReportForm` em ate 5 linhas; Shape B (IF-ELSE) emite `WARN-157-IF-ELSE` (manual). Bug em Formsigrecmm sigrecmmBO + sweep afetou sigreimcBO/sigrehtcBO/SigReInvBO/sigrecgrBO (2026-08-05, Erro89).
- **REPORT `ConfigurarPaginaLista` — SEMPRE subtrair `PageFrame.Top` dos Tops absolutos legado**: Forms REPORT embrulham controles de filtro em `pgf_4c_Paginas.Page1`, com `PageFrame.Top = 85` (logo abaixo do cabecalho cinza). Controles adicionados via `loc_oPag.AddObject(...)` na Page usam coordenadas **RELATIVAS a Page1** — portanto os Tops legado (absolutos no form original) DEVEM ser subtraidos pelo `PageFrame.Top` na fase 4. Formula: `control.Top = layout.originalTop - PageFrame.Top`. **REGRA**: apos ler o Top do layout.json, aplicar a subtracao antes de gravar em `.Top =`. Excecoes que NAO subtraem: (a) `Buttons(N)` INTERNOS a OptionGroup/CommandGroup (relativos ao grupo, nao ao Page); (b) proprio Top do PageFrame em `ConfigurarPageFrame`. Sim subtraem: labels, textboxes, containers, o proprio Top do OptionGroup/CommandGroup. Sintomas de nao subtrair: layout inteiro empurrado N pixels pra baixo; ultimos controles (ex: OptionGroups no fim) ficam alem de `form.Height` e sao cortados; labels/textboxes desalinhados por rebordo do form. Referencia canonica CORRETA: `Formsigrecrf.prg` (task066) — comentario `"Posicoes top = original - 85 (PageFrame.Top=85)"` + valores subtraidos. Auto-fix: CorretorAutomatico #165 WARNING-only (parse regex nao distingue nesting Buttons(N) sem AST — refactor manual). Bug em Formsigrecnt (2026-08-13, Erro113): 23 controles com Top absoluto legado apesar de PageFrame.Top=85; OptLocal.Top=265 e OptOrdem.Top=289 saltaram alem de form.Height=350 e ficaram cortados. Meta-licao: o proprio codigo do bug tinha o comentario `"Posicoes: layout.json original top - 85 (offset do PageFrame)"` MAS valores nao subtraidos — comentario correto, codigo errado.
- **FormBuscaAuxiliar Pattern B (Init com params) PROIBIDO — usar helper `THIS.AbrirLookupCanonico(...)` OU Pattern A manual**: `CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "Tabela", "cursor", "campo", valor, "titulo")` + `mAddColuna` + `Show()` (Pattern B — 2+ args no CREATEOBJECT) tem **3 defeitos**: (1) Init interno faz `WHERE campo='X'` + `LIKE 'X%'` — se AMBOS retornam 0 rows, FECHA o cursor e picker abre vazio; (2) FormBuscaAuxiliar herda `DataSession=1` (shared) — se form pai eh `DataSession=2` (private), USED() pos-Show retorna .F. no caller e selecao perde; (3) cursor scope isolado entre sessoes. **PREFERIDO**: usar helper `THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, par_cValorFiltro, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)` em FormBase.prg (encapsula Pattern A completo em 1 chamada). **FALLBACK MANUAL (Pattern A)**: (1) SQL no CALLER com `LIKE 'valor%'` em cod OR desc + fallback SHOW-ALL se 0 rows; (2) `CREATEOBJECT("FormBuscaAuxiliar")` SEM parametros; (3) `.DefinirCursor(cursor, "Cods", "Descs", "titulo")` com aliases `AS Cods`/`AS Descs` no SELECT; (4) `IF .Mostrar()` — ler `.cCodigoSelecionado` / `.cDescricaoSelecionada` (nao SELECT cursor); (5) `USE IN SELECT(cursor)` no final. Reciproca em `Validar<Campo>`: quando busca exata falha, NUNCA `MsgAviso("nao encontrado")+limpar campo` — chamar `THIS.AbrirBusca<X>()` direto (picker abre filtrado pelo prefixo tipado). Ref canonico: `Formsigrecrf.prg` (task066) — Pattern A original; `Formsigrecog.prg` (task059, pos-Erro114) — Pattern A recem-convertido; `FormBase.prg:AbrirLookupCanonico` (helper novo, 2026-08-13). Auto-fix: CorretorAutomatico #166 WARNING-only (nao muta — cada call tem tabela/campos/titulo especificos exigindo contexto). Bug em Formsigrecog (2026-08-13, Erro114): usuario digita "M" em vendedor+Enter, picker abre vazio pois `WHERE codigos='M'` e `LIKE 'M%'` ambos 0 rows. Sweep pendente: ~209 forms com ~500 chamadas Pattern B, incremental form-a-form conforme testado.
- **`STR(<coluna_char>, N)` PROIBIDO — dispara VFP9 erro 11**: colunas CHAR de tabelas Sig* (ex: `SigCdGpr.codigos` char(3), `SigCdGcr.codigos` char(10), `SigMvCab.Emps` char(3), `SigCdCli.iclis` char(10), `SigCdGrp.cgrus` char(3)) NUNCA devem ser envolvidas com `STR()`. VFP9 `STR()` exige NUMERIC first arg — passar char dispara **erro 11 "Function argument value, type, or count is invalid."** em runtime (LOCATE, INSERT, Value assignment). ERRADO: `ALLTRIM(STR(cursor_4c_X.codigos, 2))` / `LOCATE FOR ALLTRIM(STR(codigos, 5)) = ALLTRIM(loc_cCod)`. CORRETO: `ALLTRIM(cursor_4c_X.codigos)` / `LOCATE FOR ALLTRIM(codigos) == ALLTRIM(loc_cCod)`. **REGRA GENERICA**: SEMPRE consultar schema.sql antes de escrever `STR(<coluna>)` — se a coluna eh char, remover o STR. Colunas char comuns: `codigos`, `cgrus`, `cemps`, `iclis`, `cpros`, `cunis`, `dopes`, `grupos`, `classes`, `emps`, `razas`, `descs`, `descrs`, `rclis`. Auto-fix: CorretorAutomatico #158 (whitelist de colunas char via schema; regex `STR\(\s*(cursor\.)?<col>\s*,\s*\d+\s*\)` -> `<col>`; skip strings SQL detectadas por aspas/colchetes). Bug em FormSigReCmp ValidarGrdGrupoCod/AbrirBuscaGrdGrupo/ValidarGrdGrupoDesc — 6 sites (2026-08-05, Erro90-a).
- **`.InputMask = "##..#"` em TextBox `.Value = ""` (CHAR) PROIBIDO — bloqueia letras**: em VFP9, `#` no `InputMask` aceita APENAS digitos/espacos/sinais. Se a coluna do banco eh `char(N)` (que pode conter letras — ex: `SigCdGpr.codigos = 'A01'`), o usuario nao consegue digitar letras. Migrador copia InputMask numerico do legado sem checar tipo. **REGRA**: se `.Value = ""` (indica char), NUNCA usar `.InputMask = "#+"` — usar `.MaxLength = N` (limita tamanho sem restringir tipo). Se `.Value = 0` (indica numeric), manter `.InputMask = "###..."` OK. ERRADO: `WITH txt / .Value = "" / .InputMask = "##" / ENDWITH` sobre coluna char(3). CORRETO: `WITH txt / .Value = "" / .MaxLength = 3 / ENDWITH`. Auto-fix: CorretorAutomatico #159 detecta `.InputMask = "#+"` numa janela WITH com `.Value = ""` e substitui por `.MaxLength = <count-hashes>`; se .Value = 0 mantem; se ambiguo emite `WARN-159-INPUTMASK-AMBIGUO`. Bug em FormSigReCmp Grande Grupo txt_4c__cd_ggrupo (2026-08-05, Erro90-b).
- **`<Cursor>.<Coluna>` DEVE bater com SELECT list — nao prefixar por convencao**: BO faz `SELECT a.Emps FROM SigMvCab a INTO CURSOR CrSigMvCab`; depois referenciar `CrSigMvCab.Cemps` (com prefixo `C` invento por convencao Sig*Cd*) dispara **"Variable 'CEMPS' is not found."** ao runtime. VFP9 alias.coluna EXIGE que a coluna esteja no SELECT list literal — nao ha auto-prefixamento nem alias implicito. **REGRA**: apos escrever SELECT list, listar as colunas selecionadas e SEMPRE usar EXATAMENTE esses nomes ao referenciar `<Cursor>.<Col>`. Nunca "corrigir" o nome por padrao (Emps eh Emps, mesmo em tabela Sig*). Auto-fix: CorretorAutomatico #160 mapa cursores + colunas referenciadas + emite WARNING (nao muta — parse SQL fragil). Bug em SigReCmpBO.prg linhas 675 e 707: `CrSigMvCab.Cemps` vs SELECT `a.Emps` (2026-08-05, Erro91).
- **`SigMv*.emps` vs `SigCd*.cemps` — nomes DIFERENTES entre MOVIMENTO e MESTRE**: Coluna de empresa tem naming irregular entre tabelas. Tabelas MOVIMENTO (`SigMvCab`, `SigMvItn`, `SigMvNfi`, `SigMvPar`, `SigMvCcr`) usam `emps` (SEM prefixo C). Tabela MESTRE `SigCdEmp` usa `cemps` (COM prefixo C). JOIN CORRETO: `INNER JOIN SigCdEmp e ON e.cemps = a.emps` (onde `a` = SigMv*). Escrever `a.cemps` quando `a` = SigMv* dispara SQL Server **"Nome de coluna 'cemps' invalido"** ao clicar Visualizar/Imprimir. **REGRA**: SEMPRE consultar `docs/schema.sql` antes — nunca deduzir por convencao. IRREGULARIDADES conhecidas: `SIGFICHC` usa `emps` (apesar de prefixo Fi de master); `SIGFITEF` usa `cemps` (apesar de prefixo Fi de master). Colunas confirmadas: `SigMvCab.emps` linha 13180, `SigMvNfi.emps` linha 14464, `SigFiChc.emps` linha 11229, `SigCdEmp.cemps` linha 3111, `SigFiTef.cemps` linha 12098. Complementa Erro91 (invented C prefix em cursor) e Erro106 (WHERE `Emps` em SigCdPam single-row). Auto-fix: CorretorAutomatico #161 WARNING-only (parse fragil — muitos falsos positivos quando `a` = SigCdEmp legitimo). Bug em sigrecogBO.prg:211 + sweep sigrecsmBO/SIGREDIRBO/CecBO (2026-08-12, Erro108).
- **FRXs legados DEVEM ser copiados ao gerar BO REPORT**: BO REPORT que referencia FRX via `THIS.ExecutarReportForm("SigReXxx", ...)` ou `THIS.ObterNomeFRX()` retornando `"SigReXxx"` SOMENTE funciona se `SigReXxx.frx`+`.frt` existirem em `C:\4c\projeto\app\reports\`. Se ausentes, helper Pattern #117 exibe **"Arquivo de relatorio nao encontrado: C:\4C\PROJETO\APP\START\..\reports\SigReXxx.frx"** ao clicar Visualizar (path esta correto — o problema eh arquivo faltante). **REGRA**: apos gerar BO REPORT, extrair TODOS os nomes FRX referenciados (do `ExecutarReportForm` + todas as branches de `ObterNomeFRX`) e copiar `<Nome>.frx`+`<Nome>.frt` de `C:\4install\FortyusMC\Fortyus\` para `C:\4c\projeto\app\reports\` preservando o nome-case do BO (Windows FS eh case-insensitive). Ferramenta: `powershell -ExecutionPolicy Bypass -File C:\4c\automation\CopiarFRXsAusentes.ps1` (dry-run + auto-copia; retorna exit code 2 se algum FRX nao existe no legado). Bug em FormSigReCmp — SigReCp2.frx + SigReCp3.frx nunca portados (2026-08-05, Erro92).
- **IF THEN inline PROIBIDO**: VFP9 NAO suporta `IF cond THEN cmd` numa unica linha. Gera "Command contains unrecognized phrase/keyword." SEMPRE expandir para multi-linha: `IF cond` / `  cmd` / `ENDIF`.
- **COUNT TO var IN alias PROIBIDO**: VFP9 COUNT nao tem clausula IN. Gera "Command contains unrecognized phrase/keyword." Usar: `SELECT alias` + `COUNT TO var`.
- **APPEND FROM requer SELECT cursor antes**: `ZAP IN cursor_name` NAO muda a work area corrente. `APPEND FROM DBF("tmp")` vai para a work area CORRENTE. SEMPRE fazer `SELECT cursor_destino` antes de `APPEND FROM`. Sem isso, dados vao para o cursor errado e o grid fica vazio.
- **CommandGroup.FontName NAO EXISTE**: CommandGroup (como OptionGroup) NAO tem FontName/FontSize. Definir em cada `.Buttons(N).FontName`. Tentar no grupo causa "Property FONTNAME is not found" que cascateia e impede toda configuracao dos botoes.
- **AlternarPagina eh o FUNIL de volta - repor o MODO e reabilitar os botoes (Erro176)**: em forms CRUD, `AlternarPagina(1)` tem de fazer as DUAS coisas - `THIS.this_cModoAtual = "LISTA"` DENTRO do `IF par_nPagina = 1` e `THIS.AjustarBotoesPorModo()` no FIM do metodo. Quem so chama `AjustarBotoesPorModo` nos `Btn*Click` de ENTRADA (Incluir/Alterar/Visualizar) deixa os 5 botoes da Lista cinza depois de GRAVAR e depois de CANCELAR: nao estoura, nao entra em log, nao quebra compilacao (eh estado que ninguem restaura) e a tela fica inutilizavel ate ser fechada. Medido no VFP9 em 2026-09-24: so a chamada, sem repor o modo, NAO resolve (Formemp/Formsigpdmp7/FormSRV/FormDpi continuaram em `.F.`), porque a reabilitacao passa a depender de cada caller trocar o modo antes. Forma canonica: `THIS.pgf_4c_Paginas.ActivePage = par_nPagina` / `IF par_nPagina = 1` / `THIS.this_cModoAtual = "LISTA"` / `THIS.CarregarLista()` / `ENDIF` / `THIS.AjustarBotoesPorModo()`. Referencia: Formcfi, Formcnl, FormFNF, FormOcc. Gate: CorretorAutomatico pattern #210
- **Chave POSICIONAL concatenada: NUNCA ALLTRIM nas partes (Erro177)**: chave montada concatenando colunas ``char`` de largura fixa eh POSICIONAL - o padding FAZ PARTE da chave. O legado do SIGMVSBN monta ``lcEmpDopNums = TmpSubN.Emps + TmpSubN.Dopes + Str(TmpSubN.Numes, 6)`` SEM ALLTRIM, porque ``Emps`` eh ``char(3)`` e ``Dopes`` eh ``char(20)``: 3 + 20 + 6 = **29**, que eh exatamente ``EmpDopNums char(29)``. Escrever ``ALLTRIM(par_cEmps) + ALLTRIM(par_cDopes) + STR(par_nNumes, 6)`` da 15 caracteres (``001MALOTE     3``) e **nunca casa** com o valor gravado (``001MALOTE                   3``): o SELECT roda SEM ERRO e devolve ZERO linhas - sem exception, sem log, so a tela vazia (no FormSigMvSbn isso deixava a grade de itens, a descricao e a imagem do produto permanentemente vazias, e os handlers de AfterRowColChange/DblClick viravam codigo morto). Usar ``PADR(parte, <largura da coluna no schema>)`` EXPLICITO - nao confiar no padding que o cursor por acaso traz, porque ``ObterChavePrimaria()`` chama o mesmo montador com as properties do BO, que o ``Init`` do Form guarda JA com ALLTRIM. **A largura do ``char(N)`` destino eh a conferencia**: se a soma das partes nao da N, a montagem esta errada. ATENCAO a distincao ao varrer: ALLTRIM nas partes INTERIORES quebra, mas ALLTRIM na chave INTEIRA (no fim) eh inofensivo - ``char`` no SQL Server compara com blank-padding ANSI - e esse caso inofensivo eh o MAJORITARIO, entao tratar os dois igual produz WARNING massivo. **Instanciar o form NAO pega este defeito**: ``InicializarForm`` pula ``CarregarLista`` em ``gb_4c_ModoTeste`` e o TestFormWrapper passa com SUCESSO; num visualizador, o equivalente a "testar gravando" eh provar que a consulta devolve LINHA (conferir RECCOUNT, nao o retorno ``.T.``)

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
- **Left RELATIVO em botoes de container (Erro143)**: Dentro de `WITH .cmd_4c_Incluir/Visualizar/Alterar/Excluir/Buscar` (filhos de cnt_4c_Botoes), usar `.Left` RELATIVO ao container: Incluir=5, Visualizar=80, Alterar=155, Excluir=230, Buscar=305. NUNCA copiar o Left absoluto do container pai (542) para os botoes filhos — isso posiciona o botao em 542+542=1084, fora do form (Width=1000), INVISIVEL. Dentro de `WITH .cmd_4c_Encerrar` (filho de cnt_4c_Saida), usar `.Left=5` NUNCA `.Left=917`. Auto-fix: CorretorAutomatico #182.
- **Grid.ColumnCount NUNCA reatribuir em Carregar* (Erro144)**: Em VFP9, qualquer atribuicao a ColumnCount recria TODOS os objetos de coluna, destruindo controles AddObject (CheckBox/ComboBox). Definir ColumnCount APENAS em ConfigurarAba*/ConfigurarGrid* na inicializacao. Nos metodos Carregar*Aba/CarregarLista NAO reatribuir ColumnCount. Protecao: PEMSTATUS(grid.ColumnN, "controle", 5) antes de acessar controle AddObject'd. Warning: CorretorAutomatico #183.
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
- **REPORT FORM SEMPRE via helper canonico THIS.ExecutarReportForm — NUNCA REPORT FORM (loc_cVar) direto**: BOs REPORT DEVEM chamar `THIS.ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)` em Visualizar/Imprimir/Documento, NUNCA emitir `REPORT FORM (loc_cVar) MODO NOCONSOLE` direto (mesmo com variavel intermediaria atribuida via IIF ou multi-linha). Sem o helper: (a) FRX ausente estoura "File does not exist." sem indicar path; (b) FRXs Fortyus legados renderizam asteriscos em campos numericos por conflito de locale (VFP9 default REPORTBEHAVIOR 90 + POINT="," vs FRX desenhado em modo 80 + POINT="." — modo 90 remede fontes em runtime); (c) cursor vazio abre preview em branco silencioso; (d) apos fechar o preview, popups do _MSYSMENU (Cadastros/Movimentos/Relatorios) renderizam encolhidos (`_MREPORT` toolbar do preview corrompe cache visual do `_MSYSMENU` — mesmo bug do Erro58 mas via path preview em vez de form.Destroy). Template canonico do helper (SIGREAEGBO.prg:1192-1235 + sigreappBO.prg pos-Erro63): (1) `loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")` + `IF NOT FILE(loc_cFRX) MostrarErro("Arquivo de relatorio nao encontrado: " + loc_cFRX + ...) RETURN .F. ENDIF`; (2) guard cursor vazio `IF VARTYPE(par_cCursorDados)=="C" AND !EMPTY(par_cCursorDados) IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados)=0 MsgAviso("Nenhum registro encontrado...") RETURN .F. ENDIF ENDIF`; (3) isolamento locale `loc_cPointOrig=SET("POINT") / SET POINT TO "." / SET SEPARATOR TO "," / SET REPORTBEHAVIOR 80 / DO CASE par_cModo PREVIEW|PRINTER_PROMPT|PRINTER / restaurar SETs`; (4) **Erro63 (2026-07-24)** restaurar menu ao final `TRY / SET SYSMENU TO DEFAULT / RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda / CriarMenuPrincipal() / CATCH / ENDTRY / RETURN .T.` — bloco DEPOIS dos SET restore e ANTES do RETURN. **CRITICO**: `SET SYSMENU TO DEFAULT` DEVE vir ANTES de RELEASE POPUP + CriarMenuPrincipal. Sem isso, `CriarMenuPrincipal` recria apenas os 6 pads da app; os 7 pads default do VFP (Edit/View/Format/Tools/Program/Window/Help) que `_MREPORT` do preview removeu ficam perdidos — sintoma user-visible "menu com menos telas". Padrao proven: `Formsigtosen.prg:1074`. Callers Visualizar/Imprimir/Documento: apenas montar `loc_cRelatorio = IIF(cond, "BaseA", "BaseB")` + `loc_cCursor = IIF(cond, "CursorA", "CursorB")` + `THIS.ExecutarReportForm(loc_cRelatorio, "PREVIEW"|"PRINTER_PROMPT"|"PRINTER", loc_cCursor)`. Nota: o 3o arg `par_cCursorDados` deve ser o cursor que o FRX consome (consultar PrepararDados e o legado), nao necessariamente `THIS.this_cCursorDados` — em SIGREAUPBO por exemplo, `this_cCursorDados` guarda `cursor_4c_SigOpInc` (dados brutos) mas o FRX consome `Selecao` (listagem) ou `TmpInc` (percentual). Auto-fix: CorretorAutomatico Pattern #117/#123 (helper + refactor auto de formas simples) + Pattern #144 WARNING para forma IIF/multi-linha (blind spot dos auto-fixes). Padroes canonicos: SIGREAEGBO/SIGREADSBO. FRX legado deve ser copiado de `C:\4install\FortyusMC\Fortyus\<base>.frx` (+ `.frt`) para `C:\4c\projeto\app\reports\` preservando o nome original. Origem: Erro54 (2026-07-21, SIGREAUPBO).
- **PROCEDURE Destroy DEVE chamar DODEFAULT() como ULTIMA linha — sem isso o menu do sistema encolhe visualmente**: Todo form que herda de `FormBase` e sobrescreve `PROCEDURE Destroy` DEVE terminar com `DODEFAULT()` antes do `ENDPROC`. `FormBase.Destroy` contem o fix `RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda / CriarMenuPrincipal()` que rebuilda os popups do menu principal (`_MSYSMENU`) apos qualquer form modal fechar. Sem DODEFAULT(), a cadeia de heranca eh quebrada, `FormBase.Destroy` nao roda, e VFP9 mantem cache visual STALE dos popups — resultado: `popMovimentos` que tem 105 bars definidas (CNTBAR=105) renderiza visualmente apenas os primeiros ~40 items com line-height maior, popups aparecem encolhidos com items sumidos. CORRETO: `PROCEDURE Destroy() / IF USED("cursor_X") / USE IN cursor_X / ENDIF / DODEFAULT() / ENDPROC`. Forms que NAO herdam FormBase (ex: `FormRelPlanoContas` que herda `Form` direto) devem inserir INLINE no proprio Destroy o mesmo `TRY / RELEASE POPUP ... / CriarMenuPrincipal() / CATCH / ENDTRY`. Auto-fix: CorretorAutomatico Pattern #145 (`Corrigir-DestroySemDodefault`) injeta DODEFAULT() em forms `AS FormBase` que omitem, idempotente. Origem: Erro58 (2026-07-21, bug visual em popups apos form.Destroy).
- **REPORT FORM BARE (sem path, sem parenteses, sem macro) tambem PROIBIDO — mesma regra do helper**: A forma `REPORT FORM SigReAp4 PREVIEW NOCONSOLE` (base identifier nu, sem `.frx`, sem `(...)`, sem `&<var>.`, sem `gc_4c_CaminhoReports`) eh MAIS COMUM no legado do que a forma com macro, e igualmente PROIBIDA no sistema migrado. VFP9 busca o FRX no CWD do processo (normalmente `projeto/app/start`) via `SET PATH`, mas os FRXs vivem em `projeto/app/reports/` — sem path explicito falha "File does not exist" e o CATCH silencioso de Visualizar/Imprimir nem sequer registra qual arquivo faltou. Refatorar SEMPRE para `THIS.ExecutarReportForm("<BaseSemFrx>", "PREVIEW"|"PRINTER_PROMPT"|"PRINTER")` (Pattern #117/#147). ADICIONALMENTE: refatorar `Visualizar`/`Imprimir`/`ImprimirSemDialogo` para usar guard POSITIVO `IF THIS.PrepararDados() / <helper> / RegistrarAuditoria / loc_lSucesso = .T. / ENDIF` — NUNCA `IF !THIS.PrepararDados() / loc_lSucesso = .F. / ENDIF / <REPORT FORM>` (fall-through silencioso: PrepararDados falha e o REPORT FORM roda mesmo assim, gerando erro secundario mascarando o primario). Auto-fix: CorretorAutomatico Pattern #147 (`Corrigir-ReportFormBareSemPath`) detecta a forma bare e substitui pelo helper canonico (mesmo helper do Pattern #117); helper eh injetado se ausente. Skip: linhas com `&<var>.` (macro embutida na clausula, como `REPORT FORM SigReIiv TO PRINTER &loc_lcPmt. NOCONSOLE`) e continuacoes `;` sao deixadas para revisao manual. Origem: Erro62 (2026-07-24, FormSigReApp/sigreappBO Visualizar — "SQL: Column 'CEMPS' is not found" + File does not exist).
- **REPORT BO DEVE popular cursor `crCabecalho` quando FRX legado referencia-o no Dataenvironment**: FRXs Fortyus legados frequentemente tem `crCabecalho` (ou aliases similares como `crCabec`, `crHeader`) no Dataenvironment como cursor auxiliar para renderizar titulo/subtitulo/empresa/periodo no header do relatorio. Se o BO migrado nao popular esse cursor antes de `REPORT FORM`, VFP9 dispara `Alias 'CRCABECALHO' is not found.` ao clicar Visualizar/Imprimir (o cursor de dados principal `crImpressao`/`this_cCursorDados` NAO substitui — sao aliases independentes). Estrutura canonica preservada do legado (`sigreato.PRG:101`): `CREATE CURSOR crCabecalho (Titulo c(200), SubTit c(200), Empresa c(80), MoeCusFs m, CustoFs m, CustoPends m)` + `INSERT INTO crCabecalho (Titulo, SubTit, Empresa) VALUES (<titulo>, <subtit>, <empresa>)`. Titulo/SubTit sao construidos a partir dos filtros do form (periodo, grupo, produto, etc.) com CHR() para acentos; Empresa vem de `SELECT Razas FROM SigCdEmp WHERE Cemps = <codemp>`. Regra: sempre implementar `PROTECTED PROCEDURE CriarCabecalho()` no BO e chamar `THIS.CriarCabecalho()` como PRIMEIRA linha dentro do TRY de `PrepararDados` (antes de qualquer outra query), e adicionar `crCabecalho` ao Destroy() para liberacao. Verificar quais aliases o FRX espera: `grep -a -i "cr[A-Z][a-z]*" projeto/app/reports/<Base>.frt`. Padrao canonico: `sigreatoBO.prg:CriarCabecalho` pos-Erro64 + `SIGREEVVBO.prg:127-130` + `sigreimpBO.prg:347-361` (variante via `THIS.this_cCursorCabecalho`). Auto-fix: CorretorAutomatico Pattern #149 emite WARNING amarelo quando detecta BO REPORT com FRX que referencia `crCabecalho` no FRT e BO nao cria o cursor (nao muta — cabecalho requer filtros especificos do form). Origem: Erro64 (2026-07-28, sigreatoBO Visualizar — "Alias 'CRCABECALHO' is not found.").
- **FormBuscaAuxiliar par_cTabela = NOME PURO de tabela — NUNCA concatenar `" WHERE ..."`**: O 2o parametro do `CREATEOBJECT("FormBuscaAuxiliar", nConn, par_cTabela, ...)` deve ser apenas o nome da tabela (ex: `"SigCdCli"`). Concatenar `"SigCdCli" + " WHERE grupos = 'X'"` gera SQL final `SELECT * FROM SigCdCli WHERE grupos = 'X' WHERE CAST(Iclis...) = '1'` (duplo WHERE) → SQL Server retorna `Sintaxe incorreta proxima a palavra-chave 'WHERE'`. CORRETO: passar tabela pura no 2o param + condicao SEM prefixo WHERE no 9o param `par_cFiltro`: `CREATEOBJECT("FormBuscaAuxiliar", nConn, "SigCdCli", cursor, campo, valor, titulo, .F., .T., "grupos = " + EscaparSQL(loc_cGrupo))`. Helper interno concatena ` AND (par_cFiltro)` automaticamente. Auto-fix: CorretorAutomatico Pattern #154 (WARNING-only — refactor requer adicionar 3 params extras). Bug em Formsigrechp AbrirLookupDesConta/EmiConta (2026-08-04, Erro87).
- **SigCdCli NAO TEM coluna `grclis` — coluna de grupo eh `grupos` (char 10)**: A tabela `SigCdCli` (cadastro de clientes/contas) tem `grupos`, `grupocobs`, `grupomats`, `grupovens`, `grupocents`, `gruprods`, `grufals` — TODAS ausentes de `grclis`. `grclis` pertence a `SigChe`/`SigCqChm` (grupo do emitente do cheque). Bug tipico: gerador copia filtro de report legado (`AND b.grclis = ?` onde `b`=SigChe) para lookup de SigCdCli (`SELECT rClis FROM SigCdCli WHERE Iclis = ? AND grclis = ?`) — SQL Server retorna "Invalid column name 'grclis'" mascarado em CATCH silencioso. CORRETO: usar `grupos` em queries sobre SigCdCli. Reciproca: em SigChe/SigCqChm com alias, `grclis` (grupo emissor) e `grupos` (grupo destino) COEXISTEM e tem semanticas opostas — nao trocar. Regra generica: SEMPRE consultar `docs/schema.sql` (UTF-16 — usar `Get-Content -Encoding Unicode`) antes de escrever coluna de tabela Sig*. Auto-fix: CorretorAutomatico Pattern #155 (WARNING-only). Bug em Formsigrechp (2026-08-04, Erro87, 6 sites).
- **Icones `cadastro_imprimir_60.jpg` e `cadastro_excel_60.jpg` NAO EXISTEM em vbmp/**: Adicionar a blocklist de nomes inventados por gerador (complementa `geral_visualizar_60.jpg`/`geral_imprimir_60.jpg`/`geral_fechar_60.jpg` ja proibidos). Substituicao canonica: `cadastro_imprimir_60.jpg` → `relatorio_impressora_26.jpg` (botao 2 Imprimir); `cadastro_excel_60.jpg` → `geral_envelope_32.jpg` (se botao 3 for "Arquivos Email", padrao canonico) OU `geral_excel_60.jpg` (se botao 3 for "Documento"/export). Ambos existem. Auto-fix: CorretorAutomatico Pattern #96 (blocklist atualizada). Bug em Formsigrechp+Formsigredtv+Formsigrehpr (2026-08-04, Erro87).
- **Path do FRX: SEMPRE `gc_4c_CaminhoReports + "<Base>.frx"` — NUNCA `gc_4c_CaminhoBase + "reports\..."`**: `gc_4c_CaminhoBase = JUSTPATH(SYS(16))` retorna `C:\4c\projeto\app\start` **sem trailing backslash**. Concatenar `"reports\..."` produz `startreports\...` (path corrompido, FRX nao encontrado). `gc_4c_CaminhoReports` (config.prg:68) ja resolve `ADDBS(gc_4c_CaminhoBase) + "..\reports\"` corretamente — usar SEMPRE essa variavel. Mesma regra para arquivos gerados em reports/ (`gc_4c_CaminhoReports + "SigReXxx_YYYYMMDD.xls"`). Alias proibido: `ADDBS(gc_4c_CaminhoBase) + "reports\"` (falta navegacao `..\` — gera `start\reports\` inexistente). Regra generica: usar sempre as variaveis publicas ja resolvidas (`gc_4c_CaminhoReports`, `gc_4c_CaminhoClasses`, `gc_4c_CaminhoUtils`, `gc_4c_CaminhoForms`, `gc_4c_CaminhoIcones`), NUNCA reconstruir a partir de `gc_4c_CaminhoBase`. Auto-fix: CorretorAutomatico Pattern #156 (regex-based auto-mutate). Se FRX legitimamente ausente em `projeto/app/reports/`, copiar `<Base>.frx` + `<Base>.frt` de `C:\4install\FortyusMC\Fortyus\` preservando o nome. Bug em sigrecmmBO/sigrehtcBO/SIGREFXVBO/FormSIGREFXV (2026-08-04, Erro88, 5 sites).
- **`ALLTRIM(<cursor>.<coluna_numeric>)` dispara VFP9 erro 11 — consultar schema.sql para tipo antes de remover `STR()`**: `ALLTRIM`/`EscaparSQL` exigem char first arg; concat direto `<numeric> + "string"` estora "Operator/operand type mismatch". Pattern #158 (auto-fix) remove `STR()` de `ALLTRIM(STR(<col>, N))` APENAS quando coluna eh CHAR (whitelist via `docs/schema.sql`); replicacao manual OU migracao de novo cursor DEVE consultar schema.sql antes. Exemplos criticos: `SigCdGpr.codigos = char(3)` (REMOVE STR) mas `SigCdTom.codigos = numeric(2,0)` (MANTEM STR — se remover, `ALLTRIM(numeric)` estora "Function argument value, type, or count is invalid." no `Init/InicializarDados` e o form NAO ABRE). Padrao CORRETO: `INSERT INTO cur (Descri) VALUES (ALLTRIM(STR(<cursor>.Codigos, 2)) + "-" + ALLTRIM(<cursor>.Descrs))`. Regra: se em duvida sobre tipo, MANTER STR — custo negligenciavel, sempre funciona. NAO automavel (WARNING-only — Pattern #158 whitelist ja cobre o caso comum; adicionar auto-fix reverso repete o proprio bug). Bug em SigReCmpBO.prg:124 (2026-08-06, Erro93) — commit "chore mudanca manual pos-sweep" replicou Pattern #158 sem checar schema.sql; sweep retroativo Erro93 corrigiu +3 BOs (`sigrefcxBO:230` concat direto numeric, `SIGREADSBO:174 e 371`, `sigreatoBO:238`). Meta-licao: commits "chore mudanca manual pos-sweep" que replicam auto-fix sem consultar schema.sql sao a fonte #1 de regressao.
- **Form REPORT NAO deve setar `BackColor` no DEFINE CLASS — usar `THIS.Picture = "fundo_cad_1003.jpg"`**: Form REPORT canonico (`Formsigrecrf.prg:48-55`) NAO declara `BackColor` no bloco `DEFINE CLASS Form<X> AS FormBase` — herda default do FormBase (branco/neutro). O fundo texturizado vem de `THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"` injetado no `InicializarForm()` ANTES de qualquer `AddObject`. Erro tipico do migrador: coloca `BackColor = RGB(192, 192, 192)` no DEFINE CLASS (cinza escuro flat) E omite `THIS.Picture` — resultado visual: form abre com fundo cinza escuro uniforme (parece componente Windows desabilitado), sem a textura clara canonica, e o cabecalho `cnt_4c_Cabecalho` com `BackColor=RGB(100,100,100)` parece destoar por falta de contraste com fundo texturizado. **FIX**: (a) REMOVER a linha `BackColor = RGB(192, 192, 192)` (ou similar) do bloco de propriedades da classe; (b) INJETAR no `InicializarForm()` — dentro do TRY, ANTES do primeiro `THIS.AddObject`/`ConfigurarCabecalho`/`CREATEOBJECT("<Base>BO")` — o bloco `IF TYPE("gc_4c_CaminhoIcones") = "U" / gc_4c_CaminhoIcones = "" / ENDIF / THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"`. **NAO confundir com `.DisabledBackColor`** (property de TextBox em ReadOnly, dentro de WITH block — legitima). Skip: BackColor de Container/Label/Grid dentro de WITH block (indent >= 8, precedido por `.` ou dentro de contexto WITH). Auto-fix: CorretorAutomatico #168 remove `BackColor = RGB(192, 192, 192)` em nivel de classe (antes da primeira PROCEDURE) + WARNING se `fundo_cad_1003.jpg` ausente (injecao exige contexto de InicializarForm variavel). Bug em Formsigredtv (Erro117 2026-08-18 "Demonstrativo") + sweep achou +4 forms afetados (FormSIGREAUP, Formsigrebal, FormSigRePlc, Formsigrecsm — todos corrigidos manualmente).
- **TextBox S/N (Sim/Nao) `Format="M"` + `InputMask="S,N, "` OBRIGATORIOS — sem eles TextBox aceita qualquer char**: TextBox com `MaxLength=1` cuja label vizinha eh `(S/N)` (representa coluna char(1) semantica Sim/Nao) DEVE ter `Format = "M"` + `InputMask = "S,N, "` (lista fixa canonica VFP9). Sem esse par, campo aceita qualquer caractere (X/A/7/etc) e usuario grava valor invalido. `Format="M"` transforma TextBox em "multiple choice" que aceita apenas chars que iniciam algum item do InputMask csv-list — `S`/`N`/space passam, resto eh silenciosamente descartado. Legado sempre gera esse par (ex `sigcdcar_form_codigo_fonte.txt` `Get_senha`: `Format="M"` + `InputMask="S,N, "`). Migrador tende a gerar apenas `MaxLength=1` (limita tamanho, nao tipo). Auto-fix: CorretorAutomatico #175 detecta bloco `WITH ... TextBox / .MaxLength=1 / ... / ENDWITH` cuja Label irma seguinte tem `.Caption = "(S/N)"`, injeta `.Format = "M"` + `.InputMask = "S,N, "` antes do ENDWITH. Bug em FormCargo (Erro137 2026-09-01, task354 SigCdCar): 12 TextBoxes S/N aceitavam qualquer char (txt_4c_Nivels/Altcots/Limites/Cancitens/Libfpags/Libsdins/Libfpgs/Libopes/Libexprd/Fcomis/Libvmovdup/ConsSubn).
- **BO CRUD `Buscar()` — NUNCA `ZAP + APPEND FROM DBF()` em `cursor_4c_Dados` compartilhado — SEMPRE `USE IN + SQLEXEC direto`**: `cursor_4c_Dados` eh o cursor de listagem padrao COMPARTILHADO por 163+ BOs CRUD (todos que herdam de BusinessBase e populam Page1.Grid). Anti-padrao gerado pelo migrador: `IF USED("cursor_4c_Dados") / SQLEXEC(...,"cursor_4c_DadosTmp") / SELECT cursor_4c_Dados / ZAP / APPEND FROM DBF("cursor_4c_DadosTmp") / USE IN cursor_4c_DadosTmp / ELSE / SQLEXEC(...,"cursor_4c_Dados") / ENDIF` — `ZAP` apaga registros mas PRESERVA a estrutura (colunas + constraints NOT NULL) que outro BO deixou no cursor. **Sequencia toxica**: user abre FormCargo (`CargoBO.Buscar` cria `cursor_4c_Dados` com estrutura `ccargs char(10) NOT NULL, dcargs char(20)` — herda NOT NULL da PK de SigCdCrg) -> user abre FormCor (`CorBO.Buscar` faz SELECT `cods, descs, varias, Pesos` que NAO tem coluna `ccargs`) -> APPEND tenta inserir com `ccargs=NULL` -> SQL Server erro **"Field CCARGS does not accept null values"** no CATCH de `Buscar()`. Qualquer par de forms CRUD com esquemas PK diferentes eh vulneravel. **FIX CANONICO** (`CargoBO.Buscar:89`): substituir bloco todo por `IF USED("cursor_4c_Dados") / USE IN cursor_4c_Dados / ENDIF / loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") / IF loc_nResultado >= 0 / loc_lSucesso = .T. / ELSE / MostrarErro("Erro ao buscar..." + CHR(13) + CapturarErroSQL(), "Erro SQL") / ENDIF`. Form CRUD ja rebinda `Grid.RecordSource = "cursor_4c_Dados"` + `Column.ControlSource` + `Header.Caption` em `CarregarLista()` APOS `Buscar()` (padrao Problema 48) — nao ha regressao de UX. **NAO usar ZAP+APPEND** achando que preserva binding do Grid — SQLEXEC "cursor_4c_Dados" tambem recria e re-binda transparentemente quando CarregarLista roda logo depois. Auto-fix: CorretorAutomatico #176 detecta bloco IF-ELSE-ZAP-APPEND canonico e substitui por USE IN+SQLEXEC direto. Bug em CorBO.Buscar (Erro138 2026-09-01, ao abrir FormCor apos FormCargo). Escopo: 163+ BOs CRUD afetados — sweep retroativo aplicado.
- **BO property name DEVE bater EXATAMENTE com uso no Form (`FormParaBO`/`BOParaForm`) — naming mismatch causa `Property THIS_<X> is not found` + GRAVACAO SILENCIOSAMENTE ERRADA**: Migrador as vezes nomeia property do BO com naming SEMANTICO (`this_nSubclaEncerr` — significado do campo) enquanto o Form referencia com naming DB (`this_nChkSubs` — espelho da coluna `nchksubs`). Ao clicar Salvar/Alterar em form CRUD: `FormParaBO` executa `THIS.this_oBusinessObject.this_nChkSubs = IIF(opt.Value = 1, 1, 0)` → VFP9 estora **"Property THIS_NCHKSUBS is not found"** em MessageBox → user clica OK/Continuar → **CATCH nao interrompe o fluxo**, INSERT/UPDATE roda com property DEFAULT (`this_nSubclaEncerr = 0` nunca atribuida) → banco recebe SEMPRE 0/valor inicial. Sintoma pior que o erro visivel: user pensa "erro mas gravou", nao percebe que campos S/N/OptionGroup gravaram VALOR ERRADO permanentemente. **REGRA UNIVERSAL**: nomes de property no BO DEVEM ser IDENTICOS aos nomes usados em `FormParaBO`/`BOParaForm`/`CarregarDoCursor`/`Validar<X>` do Form. **PREFERIR NOME DB** (espelhar coluna `nchksubs` -> `this_nChkSubs`; `iclis` -> `this_cIclis`) para eliminar essa classe de mismatches — regra secundaria de CLAUDE.md Property Naming Sufixo 's'. Se herdar codigo com naming semantico, refactor SEMPRE em pares (form + BO simultaneos) via `replace_all` no PS/VSCode do nome antigo pro novo. Auto-fix: CorretorAutomatico #177 WARNING-only — grep no `Form*.prg` por `THIS\.this_oBusinessObject\.this_(\w+)` extrai nomes; grep no BO correspondente + heranca (BusinessBase/RelatorioBase) por `^\s*this_\1\s*=` declaracao (fora de PROC/FUNC — depth counter); se ausente, emite `WARN-177-BO-PROP-NAO-DECLARADA` com linha+nome+BO. Nao muta pois renomear demanda contexto (decisao DB-vs-semantico + refactor em ambos arquivos). Bug em `FormDepartamento` -> `DepartamentoBO` (Erro139 2026-09-01, Salvar cadastro de departamento — property `this_nChkSubs` usada no form mas BO declarava `this_nSubclaEncerr`; MessageBox aparecia mas save prosseguia gravando 0). Escopo: qualquer BO CRUD com mapeamento OptionGroup/CheckBox/TextBox custom — sweep detecta.
- **`cmd_4c_Confirmar.Enabled = loc_lEdit*` em `HabilitarCampos(par_lHabilitar)` DESABILITA Confirmar em modo EXCLUIR — SEMPRE adicionar `OR (THIS.this_cModoAtual = "EXCLUIR")`**: Em Form CRUD, `BtnExcluirClick` chama `HabilitarCampos(.F.)` para tornar campos READONLY (user apenas VE o registro antes de confirmar exclusao). Mas o mesmo metodo tambem faz `cmd_4c_Confirmar.Enabled = loc_lEdit` (ou variantes `loc_lEditar`/`loc_lEditando`/`loc_lEdita`) — quando `par_lHabilitar=.F.`, `loc_lEdit*=.F.` e **Confirmar fica DISABLED**. User ve a tela de exclusao com registro carregado, botao Confirmar CINZA sem imagem (icone `cadastro_confirmar_60.jpg` nao renderiza em `.Enabled=.F.`), IMPOSSIVEL confirmar a exclusao. Semantica correta: em EXCLUIR, campos ficam readonly (loc_lEdit=.F.) MAS Confirmar precisa estar habilitado (user tem que clicar para confirmar a acao). **FIX CANONICO**: `cmd_4c_Confirmar.Enabled = loc_lEdit OR (THIS.this_cModoAtual = "EXCLUIR")` — Confirmar habilitado em INCLUIR/ALTERAR (loc_lEdit=.T.) E em EXCLUIR (loc_lEdit=.F. mas THIS.this_cModoAtual="EXCLUIR"). Regra vale para TODAS as variantes de flag: `loc_lEdit`/`loc_lEditar`/`loc_lEditando`/`loc_lEdita` — auto-fix Pattern #178 detecta regex `cmd_4c_Confirmar\.Enabled\s*=\s*loc_lEdit\w*\s*$` e injeta o OR. Idempotente (skip se linha ja contem "EXCLUIR"). Bug em FormDepartamento (Erro140 2026-09-01, clicar Excluir apos selecionar registro no grid — tela abre com dados carregados mas Confirmar disabled). Escopo: ~34 forms CRUD com o mesmo padrao — sweep retroativo aplicado.
- **Form CRUD `Width < 1000` com `cnt_4c_Saida.Left=917` TRUNCA botoes Encerrar/ultimos**: Padrao canonico CLAUDE.md #10 fixa `cnt_4c_Saida.Left=917 + Width=90` (Encerrar termina em 1007). Se `Form.Width < 1000`, o container Saida transborda e Encerrar fica INVISIVEL; alem disso, `cnt_4c_Botoes.Left=542 + Width=385` termina em 927, ultimos botoes (Excluir Left=230/absoluto 772, Buscar Left=305/absoluto 847) tambem podem ser cortados se Width menor. **REGRA UNIVERSAL**: Form CRUD (`AS FormBase`) DEVE ter `Width = 1000` — canonico universal. Se SCX legado tinha Width menor (ex: 812), IGNORAR e usar 1000. Auto-fix: CorretorAutomatico #179 WARNING-only (nao muta pois alguns forms pequenos podem ter layout intencional — decisao humana caso a caso). Detector: guard `DEFINE CLASS \w+ AS FormBase` + presenca de `\.Left = 917` (assinatura do cnt_4c_Saida canonico) + `Width = N` no bloco de propriedades da classe com N<1000. Sweep 2026-09-01: 6 candidatos (FormCCJ/FormCrt/FormGcp/FormMoe/FormRop/FormSigPrCtc). Bug em FormSrv Width=812 (Erro141 2026-09-01, botoes Excluir e Encerrar cortados no menu Cadastros->Servicos).
- **Grid `RecordSource=""+re-set` em `CarregarLista` RESETA `Column.Width` e `Header1.Caption` — SEMPRE re-configurar APOS ControlSource (Problema 48 CLAUDE.md)**: Em Form CRUD, `CarregarLista` faz `Grid.RecordSource="" / ColumnCount=N / RecordSource="cursor_x" / Column1.ControlSource="..." / Column2.ControlSource="..."` para trocar cursor. Esse padrao RESETA silenciosamente `Column.Width` (volta para default ~64) e `Header1.Caption` (volta para "Header1"). Se `ConfigurarPaginaLista` (setup inicial) definiu Width/Caption dessas colunas, elas SE PERDEM ao chamar `CarregarLista` — grid aparece com colunas "Header1"/"Header1" com widths quadrados. **FIX CANONICO**: apos o ultimo `ControlSource=`, adicionar re-configuracao explicita `Grid.ColumnN.Width = <valor_original>` e `Grid.ColumnN.Header1.Caption = "<caption_original>"` para cada coluna. Valores originais estao no bloco `ConfigurarPaginaLista` (mesmo grid path). Auto-fix: CorretorAutomatico #180 auto-mutate — extrai valores originais do bloco de configuracao inicial e injeta apos ControlSource. Fallback WARNING se valores originais nao localizados. Idempotente (skip se ja tem `Column.Width=` ou `Header1.Caption=` no mesmo bloco). Bug em FormSrv 2 grids (Erro141 2026-09-01, cadastro Servicos + grid interno Produtos mostrando "Header1"). Complementa Problema 48 canonico ja documentado.
- **`pgf_4c_Paginas.Width` hardcoded < `Form.Width` TRUNCA botoes na Page1 mesmo com Form.Width canonico**: PageFrame `pgf_4c_Paginas` (root do layout Page1/Page2) DEVE ter Width IGUAL ao `Form.Width` para exibir toda a area util. Se `PageFrame.Width = 815` mas `Form.Width = 1000`, o PageFrame ocupa apenas 815px — botoes/containers com Left > 815 (ex: `cnt_4c_Saida.Left=917`) ficam CORTADOS pela borda do PageFrame, mesmo estando dentro dos 1000px do Form. Fix `Form.Width=1000` (Pattern #179) sozinho NAO resolve — precisa tambem ajustar PageFrame.Width. **FIX CANONICO**: `THIS.pgf_4c_Paginas.Width = THIS.Width` (dinamico, sempre segue Form.Width) — mais robusto que hardcoded. Alternativa: valor literal >=1000 (canonico CRUD). NUNCA hardcoded < 1000 quando Form.Width=1000. Auto-fix: CorretorAutomatico #181 detecta bloco `WITH THIS.pgf_4c_Paginas` (ou variantes com var local) + `.Width = N` onde N eh literal numerico < 1000, substitui por `.Width = THIS.Width`. Guard: apenas em Form CRUD (`AS FormBase`). Idempotente (skip `.Width = THIS.Width`; skip se N >= 1000). Bug em FormSrv (Erro142 2026-09-01, PageFrame.Width=815 truncava botoes apos fix inicial Form.Width=812->1000 nao resolver). Meta-licao: quando Form.Width eh alterado, TAMBEM ajustar PageFrame.Width simultaneamente — ambos formam um par sincronizado.
- **REPORT BO `Visualizar`/`Imprimir`/`GerarExcel` OBRIGATORIOS — `RelatorioBase` NAO provem esses metodos**: Forms REPORT (frmrelatorio) tem `BtnVisualizarClick`/`BtnImprimirClick`/`BtnExcelClick` que chamam `THIS.this_oRelatorio.Visualizar()`/`Imprimir()`/`GerarExcel()`. `RelatorioBase` (classe pai em `classes/relatoriobase.prg`) tem APENAS `Init`/`PrepararDados` (stub)/`ObterChavePrimaria`/`RegistrarAuditoria`/`Destroy` — NAO tem o TRIO. Sem os 3 metodos publicos no BO concreto, runtime dispara **"Property VISUALIZAR is not found"** ao clicar Visualizar (idem "IMPRIMIR"/"GERAREXCEL") no BtnXxxClick do form. Template canonico (`sigrecrfBO.prg:366-423`): `PROCEDURE Visualizar() / LOCAL loc_lSucesso, loc_oErro / loc_lSucesso = .F. / TRY / IF THIS.PrepararDados() / IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0 / SELECT (THIS.this_cCursorDados) / GO TOP / REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) PREVIEW NOCONSOLE / loc_lSucesso = .T. / ELSE / THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados." / ENDIF / ENDIF / CATCH TO loc_oErro / MsgErro(loc_oErro.Message, "Visualizar") / THIS.this_cMensagemErro = loc_oErro.Message / ENDTRY / RETURN loc_lSucesso / ENDPROC`. `Imprimir()` idem trocando `PREVIEW` por `TO PRINTER PROMPT`. `GerarExcel()` idem com `TO FILE &loc_cArquivo NOCONSOLE ASCII` onde `loc_cArquivo = SYS(5) + CURDIR() + "<Base>_" + STRTRAN(DTOC(DATE()),"/","") + ".xls"` + `MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")`. **Correlato — `this_cArquivoRelatorio` DEVE ser NOME-BASE canonico do FRX legado**: `= "SigReCtc"` (PascalCase, sem path prefix `gc_4c_CaminhoReports + ...`, sem extensao `.frx`). O REPORT FORM concatena `gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio` DENTRO do metodo. ERRADO: `THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "relsigrectc.frx"`. CORRETO: `THIS.this_cArquivoRelatorio = "SigReCtc"`. Ref canonicos: `sigrecrfBO.prg` (trio simples single-FRX), `sigrefcxBO.prg:2666-2900` (trio complexo 40col/80col dual-FRX). Auto-fix: CorretorAutomatico #167 injeta stubs canonicos para cada metodo ausente antes do ENDDEFINE quando BO herda de RelatorioBase; e normaliza `this_cArquivoRelatorio` para nome-base. FRX legado DEVE ser copiado de `C:\4install\FortyusMC\Fortyus\<Base>.frx` (+ `.frt`) para `C:\4c\projeto\app\reports\` — ferramenta `CopiarFRXsAusentes.ps1`. Bug em sigrectcBO (2026-08-18, Erro116, FormSigReCtc "Movimentacao de Cartoes" — clicar Visualizar disparou "Property VISUALIZAR is not found" em linha 958 do form).
- **Grid com coluna EDITAVEL (CheckBox/ComboBox) exige cursor READWRITE - `SQLEXEC()` cria cursor SOMENTE-LEITURA**: cursor de SQL pass-through nasce read-only no VFP; uma coluna com `AddObject("chk_4c_X", "CheckBox")` + `CurrentControl` + `Sparse=.F.` RENDERIZA o controle em TODAS as linhas mas a celula NUNCA entra em edicao - clicar no CheckBox nao faz nada, e o sintoma parece bug de `Enabled`/`ReadOnly` (que estao corretos), fazendo perder horas no lugar errado. SEMPRE que o Grid tiver coluna editavel, no BO usar alias TEMPORARIO + conversao: `SQLEXEC(gnConnHandle, loc_cSQL, "<alias>Tmp")` + `IF USED("<alias>") / USE IN <alias> / ENDIF` + `SELECT * FROM <alias>Tmp INTO CURSOR <alias> READWRITE` + `IF USED("<alias>Tmp") / USE IN <alias>Tmp / ENDIF` (template canonico `CCJBO.prg:214`). COROLARIO: como o cursor passa a ser fechado/recriado, o Grid perde o binding e reatribuir `RecordSource` reseta tambem `Column.Sparse`/`Column.CurrentControl`/`Column.ReadOnly` (alem de `Column.Width`/`Header1.Caption` - Problema 48), entao nos metodos `Carregar*` restaurar `.Sparse = .F.` + `.CurrentControl = "<controle>"` APOS o rebind (restauracao dentro do `IF !PEMSTATUS(...)` defensivo NAO basta - so roda quando o controle foi destruido), e chamar `Habilitar*Grid(<modo editavel>)` DEPOIS de todas as cargas (`HabilitarCampos(.T.)` em `BtnIncluirClick` roda ANTES do rebind e eh descartado). Ref: Erro145-v2 (2026-09-04, Formacg/acgBO) - Pattern #184 WARNING-only
- **CheckBox em coluna de Grid NAO alterna pelo binding nativo - exige os 4 handlers Click/MouseDown/MouseUp/KeyPress com NODEFAULT**: `Column.AddObject("chk_4c_X","CheckBox")` + `CurrentControl` + `ControlSource` + `Sparse=.F.` fazem o CheckBox RENDERIZAR em todas as linhas e ate RECEBER FOCO, mas clicar ou teclar Espaco/Enter NAO muda o valor - e o sintoma parece bug de `Enabled`/`Column.ReadOnly` (que estao corretos). Os forms legado Fortyus SUPRIMEM o toggle padrao e alternam o valor por codigo; migrar so o `When` (o gate de modo) deixa o checkbox inerte. Template canonico obrigatorio, um bloco por checkbox de grid: `PROCEDURE Chk<X>KeyPress(par_nKeyCode, par_nShiftAltCtrl) / IF INLIST(par_nKeyCode, 13, 32) AND INLIST(THIS.this_cModoAtual,"INCLUIR","ALTERAR") AND USED("<cursor>") AND !EOF("<cursor>") / REPLACE <cursor>.<campo> WITH IIF(<cursor>.<campo> = 0, 1, 0) / THIS.<path>.<grid>.Refresh() / NODEFAULT / ENDIF / ENDPROC` mais `Chk<X>MouseUp` (`THIS.Chk<X>KeyPress(13, 0)` + `NODEFAULT`), `Chk<X>MouseDown` (`NODEFAULT`) e `Chk<X>Click` (`NODEFAULT`) - os dois ultimos existem para SUPRIMIR o toggle nativo e evitar alternancia dupla. Registrar os 4 com `BINDEVENT(<chk>, "KeyPress"|"MouseUp"|"MouseDown"|"Click", THIS, "<handler>")` em TODO ponto que cria o controle (o `ConfigurarAba*` E o bloco defensivo `IF !PEMSTATUS(...)` dos `Carregar*`). O gate de modo vai DENTRO do KeyPress, nao so no `When`: BINDEVENT descarta o retorno do delegate, entao um `When` ligado por BINDEVENT nao bloqueia edicao. PRE-REQUISITO: o cursor precisa ser READWRITE, senao o `REPLACE` estoura (ver regra do cursor de SQLEXEC). Ref canonico: `Formsigredtv.prg:963-1585` (grd_4c_Emps) e `Formacg.prg` pos-Erro146; ref legado: `SIGCDACG.Pagina.Dados.Pagina.Acesso.grdAcesso.Column3.Check1` (Click=NoDefault, MouseDown=NoDefault, MouseUp=This.KeyPress(13,0)+NoDefault, KeyPress=Replace+Refresh+NoDefault). Ref: Erro146 (2026-09-04, Formacg) - Pattern #185 WARNING-only
- **`AddObject` e `BINDEVENT` em coluna de Grid: nome do controle tem de bater com o alvo REAL — tres defeitos que quebram o Init**: (A) **NUNCA dois `AddObject("<X>", ...)` com o MESMO nome no MESMO alvo** — VFP dispara `Object <X> is already defined` e o `Init` do form morre; se duas copias configuram propriedades diferentes, consolidar num bloco so (achado: `grd_4c_Fases.Column4` com dois `AddObject("Check1","CheckBox")` identicos dentro do mesmo `WITH`). (B) **NUNCA deixar controle adicionado e nao usado** — se a coluna faz `AddObject("check12")` + `AddObject("check13")` e o `CurrentControl` eh `"check13"`, o `check12` eh objeto morto: remover, ou corrigir o `CurrentControl` se a intencao era ele. (C) **`BINDEVENT(<grid>.ColumnN.<M>, ...)` so vale se `<M>` for `Text1`/`Header1` (nativos da Column) ou tiver sido `AddObject`'d NAQUELA coluna** — referencia de objeto invalida estoura no `Init` E deixa o controle sem handler nenhum; a causa tipica eh copiar o bloco de `BINDEVENT` de outro grid sem trocar o nome do controle (achado: os 4 `BINDEVENT` de `grd_4c_Emps.Column1` apontavam para `Check1`, que so existe em `grd_4c_Opers.Column1` — o CheckBox de Empresas ficou sem toggle e ninguem percebeu porque o erro some no CATCH do `InicializarForm`). REGRA PRATICA: ao copiar um bloco de configuracao de grid, trocar TRES coisas juntas — o caminho do grid, o nome do controle no `AddObject`/`CurrentControl` e o alvo de cada `BINDEVENT`. Excecao legitima: o re-`AddObject` dentro de `IF !PEMSTATUS(...)` nos `Carregar*` eh defensivo (Pattern #183) e NAO conta como duplicata. Ref: Erro146 / sweep Pattern #185 (2026-09-04, FormLin/FormMda/Formpgr/Formsigredtv) - Pattern #186 WARNING-only

- **IIF() exige condicao LOGICA - IIF(chk.Value, 1, 0) dispara erro 11**: CheckBox.Value eh NUMERICO (0/1) nos forms gerados, e IIF() so aceita LOGICO no 1o argumento. Passar numero estoura "Function argument value, type, or count is invalid." (VFP9 erro 11) - e em FormParaBO o erro cai no CATCH, aborta o metodo no meio e o Salvar segue gravando registro PARCIAL (bug silencioso, pior que a caixa de erro). SEMPRE comparar explicitamente: IIF(chk_4c_X.Value = 1, 1, 0). Vale para qualquer expressao numerica usada como condicao (IIF/IF/DO WHILE). Corolario: FormParaBO deve ser FUNCTION retornando .T./.F. e BtnSalvarClick deve ABORTAR a gravacao quando ela falhar. Auto-fix: CorretorAutomatico #187. Bug observado em Formcfo.prg (2026-09-08, Erro147).
- **ControlSource NUMERICO no SCX = indice 1-based (NUNCA booleano 0/1)**: ComboBox/OptionGroup do legado com ControlSource apontando para coluna NUMERICA grava o INDICE do item selecionado (1 = 1o item, 2 = 2o item, 0 = nada selecionado), NUNCA 0/1. Migrar como BO.this_nX = cbo.ListIndex / BO.this_nX = opt.Value, e o inverso cbo.ListIndex = IIF(BETWEEN(val,1,N), val, 0) / opt.Value = IIF(BETWEEN(val,1,N), val, 0). PROIBIDO inventar RowSource placeholder ("0,1") - copiar a lista EXATA do SCX ("Sim,Nao", "Nao,Base,Preco", ...). ComboBox com ColumnCount=2 + BoundColumn=2 grava a 2a coluna do RowSource (copiar ColumnCount/ColumnWidths/BoundColumn). ComboBox com ControlSource CHAR grava a INICIAL da opcao: LEFT(UPPER(ALLTRIM(cbo.Value)), 1), igual ao "Replace campo with padr(upper(alltrim(cbo.value)),1)" do legado. Conferir a distribuicao REAL da coluna no banco antes de assumir 0/1. WARNING: CorretorAutomatico #188. Bug observado em Formcfo.prg (2026-09-08, Erro147): 7 combos e 12 OptionGroups gravavam valores errados silenciosamente.
- **NUNCA reportar sucesso quando nao houve o que gravar**: metodo de gravacao que percorre um cursor de detalhe (grade de itens/ocorrencias/parcelas) e nao encontra nenhuma linha valida NAO pode retornar .T. em modo de INCLUSAO, e o form NAO pode exibir MsgInfo("... salvo com sucesso") nesse caso â€” o usuario ve a mensagem, volta para a lista e o registro nao existe (bug pior que erro visivel). No form, ANTES de chamar o BO: contar as linhas do cursor com a coluna-chave preenchida e, se zero em modo INSERIR/INCLUIR, MsgAviso("Informe ao menos um(a) <item> antes de gravar.") + SetFocus na grade + RETURN. Em ALTERAR a lista vazia continua valida quando o legado apaga-e-reinsere (significa remover todos os itens). Mesma familia do Erro147 (metodo de transferencia que falha e deixa o Salvar seguir). WARNING: CorretorAutomatico #189. Bug observado em FormSIGPRLNC.prg (2026-09-08, Erro148).
- **Grid da lista (Page1) tem de espelhar as colunas do legado, nao a grade de detalhe**: no SCX/Init legado as colunas da lista vem de `.AddCursor(...)` + `.pfSqlTabela(1).pColuna(<campo>, ..., <header>, <largura>, ...)` â€” copiar campo, caption e largura EXATOS de cada pColuna. Erro tipico: o migrador copia os captions da grade de detalhe da Page2 (ex.: "Ocorrencia"/"Descricao") para a lista de registros e ainda perde colunas. PROIBIDO tambem trocar a granularidade da lista: se o legado faz `Select * From <tabela>` (uma linha por registro), NAO usar `SELECT DISTINCT` de um subconjunto â€” alem de esconder colunas, isso muda a semantica de Alterar/Excluir (a linha selecionada deixa de ter chave primaria e o Excluir vira exclusao em massa por chave secundaria, apagando o que o usuario nao pediu). Levar a PK (ex.: cidchaves) para o cursor da lista e excluir por ela. Bug observado em FormSIGPRLNC.prg (2026-09-08, Erro148).
- **INSERT do BO tem de cobrir TODAS as colunas NOT NULL sem DEFAULT**: o legado grava o registro inteiro (AddCursor sem query = SELECT * + TABLEUPDATE), entao colunas que nao aparecem na tela continuam sendo gravadas com o valor do registro em branco. Se o INSERT do BO omitir uma coluna NOT NULL, o SQL Server recusa a inclusao inteira com "Nao eh possivel inserir o valor NULL na coluna <col> ... a coluna nao permite nulos. Falha em INSERT." e o cadastro fica sem conseguir incluir. Regras de preenchimento: (a) `cidchaves`/`pkchaves` (chave unica do Fortyus) = `EscaparSQL(fUniqueIds())` â€” NUNCA string vazia, senao o segundo registro colide no indice unico; (b) coluna com property no BO = usar a property; (c) sem property = default do tipo (`EscaparSQL("")` para char, `FormatarNumeroSQL(0, <decimais>)` para numeric, `0` para bit, data sentinela para datetime NOT NULL); (d) `usuars`/`usualts` = `gc_4c_UsuarioLogado`. ATENCAO a colunas GEMEAS de nome parecido, que existem juntas e sao ambas NOT NULL: `tipo`+`tipos` (SigCdRom), `prioridade`+`prioridades` (SigCdClc), `imprs`+`iimprs` (SigOpPic), `cidatrabs`+`cidtrabs` (SigCdCli) â€” incluir a que falta, nao trocar a existente. MAS ANTES DE INCLUIR, CONFERIR se a grafia que JA esta no INSERT existe na tabela: se NAO existe, nao sao gemeas - a migracao ERROU A GRAFIA e o conserto eh RENOMEAR, nao acrescentar. Suspeitar de metatese (`ems`/`ens`, `oas`/`aos`, `tipo`/`tip`): gemeas de verdade diferem por um sufixo inteiro, nao por letras trocadas de lugar. Erro de grafia nunca fica so no INSERT - esta tambem no UPDATE e na leitura do cursor em `CarregarDoCursor`; como `CarregarPorCodigo` usa `SELECT *`, o cursor traz a grafia REAL e a leitura estoura em RUNTIME com `Variable X is not found` (compila limpo, quebra Alterar/Visualizar). Renomear no arquivo INTEIRO, case-sensitive e com limite de palavra, preservando os nomes das properties. Observado em gpdBO/SigCdGrp, onde os SEIS nomes estavam errados (2026-09-14, Erro159). Conferencia em lote: `automation\VerificarInsertNotNull.ps1` (cruza os INSERT dos BOs com INFORMATION_SCHEMA). COMO GARANTIR (a regra sozinha JA FALHOU uma vez): antes de escrever o INSERT, extrair do schema a lista de colunas NOT NULL sem DEFAULT da tabela destino e conferir UMA A UMA contra a lista do INSERT. NAO basta ler o dump do legado - as colunas que o legado nunca cita (existiam so no registro em branco do AddCursor) sao invisiveis la e sao justamente as que faltam: em SigFiChc foram `nsenha` e `versao`, alem da PK `cidchaves`. Conferencia automatica na etapa 05f (`Validate-InsertNotNull` do ValidadorSQLSchema.ps1), que BLOQUEIA a migracao se faltar coluna. Bug observado em AliBO/SigCdAli.reincids (2026-09-08, Erro151) e em mais 20 sites no sweep; reincidiu em CecBO/SigFiChc (2026-09-14, Erro159).
- **Label/CheckBox/OptionButton de DADOS nunca leva ForeColor branco - o canonico eh RGB(90, 90, 90)**: as Pages do PageFrame recebem `.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"` (textura CLARA) que cobre o `.BackColor = RGB(100,100,100)`, entao qualquer `.ForeColor = RGB(255, 255, 255)` em controle criado DIRETO na pagina (ou dentro de container com `BackStyle = 0`, que eh transparente, ou com BackColor claro) fica INVISIVEL - o usuario clica em Incluir, abre a aba Dados e ve as caixas de texto sem nenhuma legenda. Quando o objeto do SCX legado NAO declara ForeColor (classe `say` do Framework), usar RGB(90, 90, 90); quando declara, copiar o valor EXATO (36,84,155 nos titulos de secao em Verdana, 255,0,0 nas notas de rodape). Ao procurar o objeto no dump do legado, conferir os DOIS nomes: `Say<N>` do legado costuma virar `lbl_4c_Label<N>` no migrado. EXCECOES legitimas, que continuam brancas: `lbl_4c_Titulo`/`lbl_4c_LblTitulo` da faixa do cabecalho, label dentro de container OPACO escuro (`BackStyle = 1` + BackColor RGB(100,100,100)/RGB(90,90,90)) e as propriedades `HighlightForeColor`/`SelectedForeColor`/`SelectedItemForeColor` (texto da linha selecionada, que fica sobre realce escuro). WARNING: CorretorAutomatico #191. Bug observado em FormARV.prg (2026-09-09, Erro153) e em mais 22 forms no sweep (217 sites).
- **NUNCA chamar helper que voce nao definiu - em VFP9 o erro so aparece em RUNTIME**: chamada "nua" a um nome que nao existe como funcao global compila sem reclamar; o VFP resolve nome desconhecido procurando `<nome>.prg` em disco e, quando o usuario aciona o botao, estoura `File 'nomedafuncao.prg' does not exist.` Antes de usar um helper, conferir que ele EXISTE em `projeto\app\utils\functions.prg` (`TratarNulo`, `EscaparSQL`, `FormatarNumeroSQL`, `FormatarDataSQL`, `ConverterParaLogico`, `MsgErro`, `MsgAviso`, `MsgInfo`, `MsgConfirma`, ...). Precisando de um helper novo, DEFINIR em functions.prg no mesmo padrao - PROIBIDO so chamar e seguir em frente. Corolario (CLAUDE.md regra #8): metodo da propria classe SEMPRE com `THIS.` - sem o prefixo cai no mesmo erro de arquivo inexistente. ATENCAO ao helper que le coluna do banco: coluna `bit` do SQL Server chega ao VFP ora como Logico (.T./.F.) ora como Numerico (0/1) conforme o driver, e coluna `numeric(1,0)` sempre como Numerico - testar `VARTYPE` antes de comparar, porque comparar Logico com 1 estoura "Operator/operand type mismatch". Auditoria: `automation\VerificarFuncoesNaoDefinidas.ps1`. WARNING: CorretorAutomatico #192. Bug observado em BchBO/BlqBO/DCCBO/OETBO/sigpdmp6BO/sigpres2BO (2026-09-09, Erro154): `ConverterParaLogico` foi inventado pelo migrador e chamado em 17 sites sem existir em lugar nenhum.
- **`docs\schema.sql` eh UTF-16LE - grep/awk/findstr devolvem ZERO SILENCIOSAMENTE**: essas ferramentas tratam o arquivo como binario e nao acham nada, fazendo tabela e coluna EXISTENTES parecerem inexistentes. A "correcao" natural a partir desse diagnostico falso - apontar o BO para outra tabela - grava dado no lugar errado e viola o PILAR 2. Ler sempre com `Get-Content -Raw` (PowerShell respeita o BOM) ou usar `automation\VerificarTabelasInexistentes.ps1`, que ja trata o encoding e ainda aborta se ler menos de 100 tabelas (piso de sanidade contra leitura falha). Tambem NAO usar `tasks\<task>\schema_ascii.sql` como fonte de verdade: eh snapshot congelado na epoca daquela task (task351 tem 674 tabelas contra 682 do canonico) e faz tabela nova parecer ausente. Corolario para o erro de runtime `Nome de objeto 'SigCdXxx' invalido` (vem do SQL Server, nao do VFP, e nao quebra a compilacao): (1) conferir a tabela no schema canonico com o encoding correto; (2) conferir o nome no CODIGO LEGADO em `tasks\<task>\*_form_codigo_fonte.txt`. Se o legado usa o MESMO nome e a tabela esta no schema, o codigo migrado esta FIEL e a divergencia eh de BANCO/ambiente (a base conectada nao bate com o dump) - NAO eh bug de migracao e NAO se conserta no codigo. WARNING: CorretorAutomatico #193. Bug observado em FormBlq/SigCdBlq (2026-09-09, Erro155).
- **`EVALUATE()` NAO atribui - ele avalia e devolve o valor**: `EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = ''")` NAO limpa nada. O VFP monta a string, enxerga uma COMPARACAO (`obj.prop.Value = ''`), avalia como `.T.`/`.F.` e joga o resultado fora - sem erro, sem aviso, o campo simplesmente nunca muda. Comprovado no VFP9: valor antes `[ABC]`, depois do EVALUATE `[ABC]`, depois do STORE `[]`. Para atribuir a um nome montado em tempo de execucao, usar `STORE <valor> TO (<expressao que resulta no nome>)`: `STORE "" TO ("loc_oCnt." + par_cTxtDesc + ".Value")`. `EVALUATE` continua CERTO para LEITURA (`loc_c = EVALUATE("loc_oCnt." + par_cTxtCon + ".Value")`, `IF EVALUATE("VARTYPE(loc_oCnt." + par_cX + ")") = "O"`) - o defeito eh so quando o sinal de igual esta DENTRO da string montada, que eh o unico caso em que a intencao era atribuir. Auto-fix: CorretorAutomatico #194 (forma segura: valor vazio ou identificador simples; valor com concatenacao/funcao vira WARNING). Bug observado em Formlch.prg (2026-09-09, Erro155): 4 sites, e o pior calava a descricao do GRUPO nos 7 containers do form desde a migracao, sem ninguem perceber.
- **A faixa do cabecalho tem de ser o PRIMEIRO `AddObject` da pagina Dados - senao ela COBRE os botoes**: os containers de botao (`cnt_4c_Salva`/`cnt_4c_BotoesAcao`/`cnt_4c_Saida`) ficam em `Top = 29..33`, ou seja DENTRO da area da faixa (`Top = 29..31`, `Height = 80`), e so aparecem se forem criados DEPOIS dela. Com a ordem invertida o usuario abre a aba Dados e ve o cabecalho comendo Confirmar/Encerrar - sobra so a lasca dos ~10px que passam da altura da faixa. Vale so para a pagina Dados: na Lista o migrador costuma acertar a ordem. EXCECAO: pagina com PageFrame/Container interno que cobre tudo (`Formgpd.pgf_4c_Divisoes`) - ali a faixa vem DEPOIS de proposito e a barra de botoes eh trazida para frente com `ZOrder(0)`; a presenca do `ZOrder(0)` eh o que distingue esse caso de um bug. CORRELATO: conferir que os labels da faixa nao ficaram PELADOS - `.AddObject("lbl_4c_Sombra", "Label")` sem nenhuma propriedade em seguida faz o titulo sair como label default minusculo, preto sobre cinza, mesmo com o `Caption` setado no `Init` (injecao do Erro152 que ficou pela metade no FormCat). Auto-fix: CorretorAutomatico #195. Bug observado em FormCAD e FormCat (2026-09-09, Erro156).
- **TTOD() so aceita DATETIME - passar um DATE dispara erro 11 em RUNTIME**: "Function argument value, type, or count is invalid." O .prg compila limpo e o usuario so descobre ao acionar o botao. A armadilha eh que o MESMO campo chega com tipos DIFERENTES conforme o caminho: TextBox criado com .Value = {} guarda DATE (modo INCLUIR), coluna datetime do SQL Server via SQLEXEC chega como DATETIME (modo ALTERAR) e cursor VFP com coluna declarada D guarda DATE - por isso o codigo funciona em ALTERAR e explode em INCLUIR. Para qualquer valor que passou por form, propriedade de BO, parametro ou variavel local, usar ConverterParaData(x) de utils\functions.prg, que normaliza DATE/DATETIME/CHAR para DATE (com DATETIME o resultado eh identico ao TTOD). TTOD() direto so em coluna de cursor vinda de SQLEXEC, onde o tipo eh garantidamente datetime. Auto-fix: CorretorAutomatico #197. Bug observado em FormCCJ/CCJBO "Calculo de Juros" (2026-09-10, Erro157): o legado fazia Ttod(Get_DataBase.Value) e funcionava porque la o TextBox tinha ControlSource = crSigCdCcj.data_base (datetime); no migrado o TextBox nasce com {} e a tela nao gravava nada, so o messagebox de erro.
- **PROIBIDO reescrever a formula de calculo do legado - transcrever LITERALMENTE**: a expressao aritmetica, a ordem dos operadores, o SINAL, os divisores, o ROUND e os guards fazem parte da regra de negocio e nao se "simplificam". No Erro157 o legado calculava Round(lnValor - (lnValor*((lnDias/30)*(lnFator/100))),2) - juros DESCONTADOS, taxa MENSAL prorrateada - e o migrado escreveu loc_nValor + loc_nValor*(loc_nFator/100)*loc_nDias, juros SOMADOS com taxa DIARIA: a tela gravava valor errado sem exibir erro nenhum. Junto com a formula vao tres coisas que o migrador costuma jogar fora e que TAMBEM sao regra: (1) SINAL - o legado NAO zera diferenca de datas negativa, data anterior a base gera dias negativos de proposito; (2) GUARDS - Abs(lnDias)>999 avisa, limpa o campo e ABORTA, porque a coluna destino eh numeric(3,0) e nao cabe mais que isso, e sem o guard a gravacao estoura no SQL Server; (3) CRITERIO DOS TOTAIS - Count/Sum/Avg com Where Not Empty(Dias) exclui as linhas com zero, resultado diferente de somar tudo dentro do SCAN. Ao migrar metodo de calculo, transcrever a formula do dump legado linha a linha e so depois trocar os nomes das variaveis.
- **Column.AddObject NAO faz o controle aparecer - falta o Column.CurrentControl**: adicionar um OptionGroup/CheckBox/ComboBox/Spinner a uma Column de Grid cria o objeto, mas a coluna continua desenhando o Text1 dela. O controle existe, responde a PEMSTATUS e nunca aparece na tela: o usuario ve o valor cru numa caixa de texto e nao tem como marcar nada. Quem escolhe o controle que a coluna desenha eh `Column.CurrentControl` (default "Text1"), e ele tem de receber o NOME exato passado ao AddObject, logo depois de configurar o controle: `.Column3.CurrentControl = "opt_4c_Tipos"`. Vem sempre acompanhado de `.Column3.Sparse = .F.` (sem isso o controle so aparece na linha ativa) e de `.Column3.ReadOnly = .F.` quando o usuario precisa editar - lembrando que o ReadOnly da COLUNA tem de ser definido DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve. Auto-fix: CorretorAutomatico #198. Bug observado em FormCco.prg (2026-09-10, Erro158): o OptionGroup Inserir/Excluir/Nenhum da coluna Tipo foi criado na migracao e nunca apareceu, entao nao havia como cadastrar o motivo.
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
- **Form WRAPPER de VCX: copiar TAMBEM o Left/Top dos filhos DIRETOS do container, nao so os das paginas**: controle que fica FORA da area do pai eh RECORTADO pelo Container - some da tela **sem erro, sem log e SEM APARECER EM SCREENSHOT**, entao nenhuma validacao visual do pipeline enxerga. No FormCliente os tres CommandGroup que trocam de aba (`cmdGCarac`/`cmdGFtec`/`cmdgpessoal`) ficaram no Left/Top da CLASSE do VCX (891..957, Top 540) porque o migrador so copiou os overrides do SCX dos controles das PAGINAS; como o `cnt_4c_Conta` tem `Width = 768` / `Height = 450` (fiel ao legado), os tres cairam fora e sumiram - o usuario entrava na aba de endereco e **nao tinha como voltar para a aba 1**, so restava Salvar. O SCX declarava `633,397` / `672,397` / `711,397`. Ao migrar wrapper, varrer no dump do SCX as linhas de UM ponto so (`^  nome.Left` / `^  nome.Top` - filho direto do container) e aplicar TODAS; as de varios pontos sao das paginas. Conferir `Left + Width <= pai.Width` e `Top + Height <= pai.Height`. Ignorar nome generico (`Command1`, `Option2`, `Text1`...): sao membros internos de CommandGroup/OptionGroup, posicionados pelo VFP
- **SCX que desloca um controle e NAO desloca o label vizinho: sobreposicao HERDADA, que comparar migrado x legado nunca pega**: quando o SCX sobrepoe o Left de um campo mas deixa o label/campo ao lado no Left da CLASSE, os dois se cruzam na tela. No FormCliente o SCX move getUFIBGE de 471 para 508 e nao move o label "Contato :" (518), que entra 15px DENTRO da caixa: a tela mostra "35ontato :". Copiar o SCX fielmente REPRODUZ o defeito, e toda validacao migrado-x-legado aprova, porque os dois concordam. Ao transcrever `.Left`, somar `Left + Width` do controle e conferir contra o `Left` do vizinho da MESMA linha (mesmo Top, +-6px) DENTRO DO MESMO CONTAINER - Left/Top sao relativos ao pai, comparar entre containers nao significa nada. Havendo cruzamento, preferir os valores da CLASSE (framework.vcx), que sao coerentes entre si, a inventar posicao nova; e registrar o desvio em comentario. Caso especial: controle que cabe INTEIRO dentro de outro fica inalcancavel ao clique (Get_Regiao 596..676 dentro de Get_Contato 565..717) - no legado esse campo costuma estar aposentado (linhas de Visible/obrigatoriedade COMENTADAS no VCX); esconder eh melhor que deixar soterrado. Label sem `.Width` eh AutoSize (classe say): a faixa real dele eh a do TEXTO, nao a da caixa (#23)
- **Metodo de VCX legado que o SCX sobrescreve SO para consertar layout: reaplicar no FUNIL de chamadas, nunca so no Init**: o p-code do VCX refaz o layout dele a CADA chamada. O mLeDados do clsconta termina com `.Top = Iif(.Tabs, 0, ThisForm.Height - This.PgframeDados.PageHeight)` e re-ancora os tres CommandGroup de navegacao com `.Top = (This.Height - .Height - 4)`. Medido: clsconta.pgframeDados.Height = 802 contra Form.Height = 600, entao com pcTpCadCli='1' o Top vira -198, a pagina 1 SOBE 195px e o container RECORTA o topo dela - o usuario clica Incluir e cai direto no bloco de endereco/contato (GetCEP.Top = 200 no SCX), sem Codigo/Nome/CPF na tela, sem erro, sem log e SEM APARECER EM SCREENSHOT. O SCX legado conserta com um override do PROPRIO metodo, que roda DEPOIS do DoDefault (DoDefault(...) seguido de thisform.cntConta.pgframeDados.Top = 0). Como o migrado instancia o VCX por AddObject e nao tem subclasse onde por o override, esse ajuste tem de rodar no FUNIL de chamadas do metodo (o wrapper Chamar<Metodo>Seguro) e tambem nos CATCH que engolem excecao - aplicar so no InicializarForm NAO adianta, porque o metodo roda de novo em TODO Incluir/Alterar/Visualizar. Ao migrar wrapper, procurar no dump do SCX uma PROCEDURE homonima de metodo do VCX: ela existe justamente para corrigir o que o p-code faz
- **PageFrame.ActivePage eh o PageOrder, NAO a ordem de declaracao das Pages**: no clsconta, pgframeDados1 (Cadastro) tem PageOrder=1, pgframeDados2 (Pessoal) tem PageOrder=**3** e pgframeDados7 (Complemento) tem PageOrder=**2**. O migrado fazia `ActivePage = 2` achando que ia para Pessoal e caia em Complemento; pior, o `cmdPessoal.Click` do VCX so age com ActivePage 1 ou 3 (`Case ActivePage==1 -> ActivePage = 3` / `Case ActivePage==3 -> ActivePage = 1`), entao depois disso ele ficava MORTO e o F5 nao fazia mais nada. Compila limpo, so aparece na tela. Nunca derivar ActivePage do sufixo do nome da Page - ler o PageOrder da CLASSE. E quando o legado navega chamando o Click de um botao (o KeyPress do SCX chama `cmdGPessoal.cmdPessoal.Click()` e MAIS NADA), TRANSCREVER isso: nao pre-setar ActivePage antes de delegar, senao o toggle do VCX perde a referencia e vira no-op
- **Membro INTERNO de CommandGroup/OptionGroup com NOME PROPRIO: aplicar os overrides do SCX (excecao da regra do nome generico)**: ignorar `Command1`/`Option2`/`Text1` continua certo, mas quando o membro tem nome proprio e o SCX declara geometria para ele (`cmdGCarac.cmdCarac.Top/Left/Height/Width/Picture/...`), esses overrides sao OBRIGATORIOS - o grupo eh AutoSize=.T. e eh a geometria do botao INTERNO que DEFINE a altura do grupo. Medido no VFP9: inner 32x32 em 5,5 (classe) da grupo de 42; inner 40x40 em 5,5 (SCX) da grupo de 50 - e so com 50 o `.Top = (Height - .Height - 4)` do mLeDados cai em 396, que eh o mesmo 397 que o SCX declara no grupo. Copiar so o Left/Top do GRUPO deixa os tres botoes menores e fora da linha desenhada pelo legado. Para ler as propriedades REAIS de uma classe de VCX (o .VCT eh p-code e grep devolve lixo), abrir a .vcx como DBF no proprio VFP9 e ler a coluna Properties: USE framework\classresp.vcx + SCAN por ObjName/Class
- **Wrapper de funcao global do legado tem de reproduzir o CONTRATO, nao so o nome**: redirecionar para a primitiva VFP de nome parecido NAO basta. `IsEmpty` do Fortyus nao eh `EMPTY` do VFP - medido: `EMPTY(.NULL.)` devolve `.F.`, isto eh, "nao esta vazio", enquanto o `IsEmpty` do legado trata NULL como vazio. O wrapper `utils\isempty.prg` fazia so `RETURN EMPTY(par_uValor)` e divergia exatamente no caso NULL, em 142 call sites do p-code. O sintoma aparece LONGE da causa e sem erro nenhum: o `mRetiraNull` do clsconta limpa nulos com `Update crSigCdCli Set Obs = "" Where IsEmpty(Obs)`, o WHERE nao casava, a linha nunca era limpa e o campo Obs. do Cadastro de Cliente exibia `.NULL.` na tela. Conserto: guarda de NULL ANTES de delegar, com IF separado e nao `ISNULL(x) OR EMPTY(x)` - VFP9 nao faz short-circuit em OR. Ao escrever ou revisar wrapper em `utils\`, testar explicitamente NULL, vazio, zero, `.F.` e argumento AUSENTE, e conferir contra o que os call sites do p-code esperam; vale para qualquer coluna que venha do SQL Server permitindo NULL. Delegacao com guarda de tipo eh o padrao certo (ver fvalidarcpf.prg / fvalidarcnpj.prg, que checam VARTYPE antes de delegar)
- **Form WRAPPER de VCX: auditar as properties de ThisForm que o p-code toca, e separar as que o VCX cria sozinho das que nao**: o p-code chama ThisForm.<x> em dezenas de pontos, e para a maioria ele mesmo se vira, com o par guarda + `AddProperty` (If Type('ThisForm.OldEmpresa') == 'U' -> ThisForm.AddProperty('OldEmpresa', ...)). Essas NUNCA dao erro e nao precisam ser declaradas no form. As que aparecem CRUAS, sem esse par, sao exatamente as que estouram em runtime: no `clsconta` sao 18 properties customizadas, 17 auto-criadas e UMA nao - `AlterouLgpd`, que fazia gravar uma ALTERACAO no Cadastro de Cliente estourar "Erro 1734: Property ALTEROULGPD is not found" dentro do mGravaDados. Varrer assim: abrir a .vcx como DBF no VFP9 e dumpar a coluna `Methods` SO dos registros cujo Parent+ObjName contem o nome da classe (grepar o .VCT inteiro mistura TODAS as classes do arquivo e traz lixo do p-code), extrair ThisForm.<x> desse dump, descontar as nativas de Form (Name, LockScreen, Height, BackColor, DataSessionId, Refresh, AddProperty) e cruzar com o que o .prg migrado ja declara. Property de OBJETO do legado que o migrado nao tem (ThisForm.Pagina, o PageFrame do frmcadastro) so eh segura se TODO uso estiver dentro de If Type('...')=='O' - conferir, nao presumir. Antes de declarar, conferir tambem que os CURSORES do bloco recem-habilitado existem, senao troca-se um erro por outro. E declarar NAO basta quando o ciclo de vida difere: o legado eh modal e vive UM registro, o migrado nao fecha entre um e outro, entao flag de sessao tem de ser RESETADO no funil de chamadas - sem isso o primeiro registro em que alguem tocar no consentimento deixa `AlterouLgpd` ligado para sempre e todo ALTERAR seguinte grava historico de LGPD FALSO. Auditoria: automation\VerificarPropsThisFormVCX.ps1
- **Funcao GLOBAL do legado Fortyus chamada pelo p-code do VCX: criar WRAPPER em utils\, NUNCA deixar faltando**: os VCX (framework.vcx / classobj.vcx / classresp.vcx) chamam funcoes da aplicacao legado (sig.prg / SIGFUNCS.PRG) que NAO vieram no acervo - fSQLExec, fChkCpoVlc, fChkCntVlc, fGravarLog, fValidarCpf, fValidarCNPJ, fAbrirTabs, fVerificaPasta, fMensagemFixa, fInibirBtn, fGerPDFCreator, fConfigGeral. O p-code esta COMPILADO e nao da para editar: o VFP procura <nome>.prg no PATH e so estoura em RUNTIME, dentro de Init/Valid/Click FORA de qualquer TRY/CATCH -> o form FECHA (Erro163_Aba1: digitar a UF no Cadastro de Cliente fechava a tela porque GetEstado.Valid faz CreateObject('fwBuscaExt',...) SEM o guard Type()=='O' que o GetCEP tem, e o Init do fwBuscaExt chama fSQLExec). O wrapper vai em projeto\app\utils\<nome minusculo>.prg no padrao de isempty.prg: LPARAMETERS + RETURN, SEM cabecalho FUNCTION - o arquivo eh resolvido pelo NOME. Auditar com automation\VerificarFuncoesLegadoVCX.ps1. NUNCA criar stub que devolve VALOR DE CALCULO (fCalcularST / fCalcularIPI): devolver 0 grava imposto errado em silencio (regra #17) - ausente eh mais seguro, porque o erro aparece alto. Vale igual para OBJETO global: goSistema.ObjectConn (cOpenConn, classes\sigclcnx.PRG) tem de existir, senao CreateObject('fSqlConector','cep') devolve pnIdConn = -1 e o VCX exibe "Impossivel Efetuar Conexao Com o Servidor de Banco de Dados..."
- **SET PATH TO com varias expressoes entre parenteses honra SO a PRIMEIRA**: SET PATH TO (a), (b), (c) faz o VFP9 usar so (a) e descartar o resto EM SILENCIO - sem erro de compilacao nem de runtime. Concatenar numa string unica: SET PATH TO (a + "," + b + "," + c). Eh especifico do SET PATH - SET PROCEDURE e SET CLASSLIB com varias expressoes entre parenteses funcionam normalmente. Sintoma tipico e distante da causa: .prg que EXISTE aparecendo como "File does not exist" (foi assim que isempty.prg dos VCX legado ficou inalcancavel); diante disso, medir SET("PATH") ANTES de mexer no arquivo
- **Propriedade que a CLASSE NAO TEM compila limpo e a TELA NAO ABRE**: atribuir .Prop a controle cuja classe base nao tem Prop nao eh erro de compilacao - estoura no Init, dentro do TRY, com "Property FORECOLOR is not found", e o usuario clica no menu e nada abre. Medido no VFP9: OptionGroup e CommandGroup NAO tem ForeColor (so BackColor); PageFrame nao tem ForeColor, BackColor nem BackStyle; ListBox nao tem ForeColor/BackColor (sao ItemForeColor/ItemBackColor); Shape nao tem ForeColor (sao BorderColor/FillColor) nem ShapeType (isso eh VB; no VFP eh Curvature); ZOrderSet nao existe em runtime em classe nenhuma (eh bookkeeping do Form Designer, gravado no SCX - remover, pois o equivalente eh o METODO ZOrder()). A cor de grupo mora nos MEMBROS e o SCX legado JA declara assim (Option1.ForeColor = 255,0,0) - transcrever o dump, e conferir se os OUTROS botoes do form nao perderam o ForeColor que o legado declara. Cuidado tambem com WITH aninhado, que sequestra o escopo e da o mesmo erro: dentro de WITH THIS.this_oBusinessObject, um WITH THIS.cnt_X faz .this_nProp (property do BO) resolver contra o Container. Auditoria: automation\VerificarPropriedadesInexistentes.ps1
- **`Controls` eh indexado por NUMERO - passar o NOME faz a tela nao abrir**: `Controls` eh array, nao colecao por chave. Medido no VFP9: `Controls("nome")` em expressao estoura "Invalid subscript reference" e, dentro de `WITH`, "CONTROLS is not an object" - compila limpo e so quebra no Init. O `PEMSTATUS(obj, "nome", 5)` que costuma cercar esses blocos devolve .T. e NAO protege (mesma armadilha da regra do BINDEVENT/metodo PROTECTED). Para alcancar membro por NOME: `EVALUATE("obj." + nome + ".Prop")` na LEITURA e `STORE valor TO ("obj." + nome + ".Prop")` na ATRIBUICAO; `WITH EVALUATE("obj." + nome)` tambem funciona. Se o que se quer eh o INDICE, escrever helper nome->indice varrendo ControlCount. `Controls(N)` numerico continua certo e eh o uso majoritario
- **A pagina LISTA segue o `Init` legado, nao o SCX desenhado**: (a) o filtro eh aplicado SEMPRE, inclusive VAZIO - o legado liga a grade a `Select * From X Where Col = ?m.pcVar` com a variavel vazia no Init, entao a Lista abre VAZIA de proposito; `IF !EMPTY(filtro)` caindo em `Buscar("")` traz a TABELA INTEIRA. (b) a grade espelha o `pColuna` do `AddCursor` (nome, caption e largura de cada coluna), NAO os headers desenhados no SCX - no Formgpd o SCX tinha 3 colunas e o pColuna tem 4, e a coluna que faltava tambem faltava no SELECT do BO. (c) `Column.Width` vai por ULTIMO: mexer em RecordSource/ControlSource e na fonte do Grid faz o VFP recalcular tudo para o default 90
- **Campo de filtro da Lista tem os DOIS eventos do legado**: tipicamente `Valid` (se o codigo digitado nao existe, abre o picker; ESC limpa o campo) e `LostFocus` (recarrega a grade ao SAIR do campo, nao so no Enter). Migrar so o KeyPress com Enter faz o campo "nao trazer nada". Como BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox, implementar as duas coisas no handler de LostFocus
- **`FormBuscaAuxiliar`: o 1o argumento eh o HANDLE da conexao**: a assinatura eh Init(par_nConn, par_cTabela, par_cCursor, par_cCampo, par_cValor, par_cTitulo, par_lBuscaExata, par_lMostraGrid, par_cFiltro) e o Init faz `SQLEXEC(par_nConn, ...)`. Passar a tabela (ou um cursor, ou um SELECT) no lugar de gnConnHandle desloca TODOS os argumentos e a consulta nunca acontece - o picker abre VAZIO, sem erro nenhum, porque o Init tem `IF VARTYPE(par_cTabela) != "C" / RETURN .T.`. Auditoria: automation\VerificarFormBuscaAuxiliar.ps1
- **`FormBuscaAuxiliar` tem CONTRATO - `this_lAchouRegistro` antes do `Show()`**: o Init ja tenta o match EXATO e, achando 1 registro, marca this_lAchouRegistro e this_lSelecionou - o valor esta resolvido e o picker NAO deve ser mostrado. Padrao canonico (137 arquivos): `IF !loc_oBusca.this_lAchouRegistro` envolvendo mAddColuna+Show, e a atribuicao SO dentro de `IF loc_oBusca.this_lSelecionou AND USED(<cursor>)`. Os dois erros andam juntos: Show desguardado abre o dialogo por cima da tela ja preenchida; atribuir o valor FORA da guarda (tipico `<controle>.Value = loc_cCodigo` no FIM do metodo) ZERA o campo quando nada foi escolhido, e o filtro/grade que dependia dele esvazia. NAO duplicar a checagem de existencia com um SQLEXEC proprio antes do picker: o Init ja faz isso
- **`.Self` NAO existe em VFP9 - dentro de `WITH`, repetir a expressao**: `Self` eh de Delphi/Object Pascal; o objeto VFP nao tem essa propriedade e dentro de um bloco WITH nao ha como referenciar o proprio objeto com ponto. Medido: `WITH obj` + `PEMSTATUS(.Self, "x", 5)` estoura **"Property SELF is not found"**, e `PEMSTATUS(obj, "Self", 5)` devolve .F. O correto eh repetir a expressao do WITH: `PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)`. COMPILA LIMPO e so quebra em RUNTIME
- **Pagina preenchida por DOIS metodos: se um esquecer o +29, a aba fica com texto sobre texto**: quando `ConfigurarAba<X>` e `ConfigurarPgpg<X>` preenchem a MESMA `pgf_4c_Divisoes.PageN`, basta um deles transcrever o Top CRU do SCX (sem a compensacao do `pgf_4c_Paginas.Top = -29`) para os controles dele cairem ~29px acima e pousarem sobre o que o outro ja desenhou. NAO ha erro nem log - so a aba desformatada. Medido no Formgpd: o ConfigurarPgpgConfig tinha 67 dos 83 controles com o Top cru. Ao escrever QUALQUER metodo Configurar*, conferir que TODO Top recebeu o +29, e que o comentario de origem cita o controle certo do dump
- **Migrador lendo o controle ERRADO no dump**: tres defeitos da mesma origem no Erro175 - (a) `Tptribs` recebeu o Top do `Get_CodServs` (409) em vez do `Get_TpTrib` (385), e as duas linhas viraram uma so; (b) `Obrigfiscs` foi para Left=440 quando o legado tem Left=176, parando do outro lado da tela sobre outro bloco; (c) label DUPLICADO - o ConfigurarAba* inventou um label ("Obrig. Fiscal :") para uma linha cujo label o ConfigurarPgpg* ja criava a partir do legado ("Class. Fiscal Obrigatoria :"). Ao achar dois labels na mesma linha, conferir qual existe no SCX: o legado tem UM
- **NAO existe deteccao automatica de offset/sobreposicao comparando com o legado**: tentado duas vezes e medido - varrendo o projeto contra o layout.json inteiro deu 4220 achados em ~230 forms (quase tudo falso positivo, inclusive num form ja corrigido); a versao dirigida por metodo+pagina acusou 49 num metodo recem-corrigido e 18 num que estava certo. A raiz eh a mesma do detector de "controle fora da area do pai": o PILAR 3 manda RENOMEAR os objetos, entao casar migrado com legado so resta por geometria, e sempre aparece um sosia. Serve para diagnosticar UM caso conhecido, nao para validar em massa nem para confirmar o conserto - o conserto se confere instanciando e olhando a tela
- **`Program Error` CRU do VFP em vez do dialogo do projeto = metodo SEM TRY/CATCH**: quando o erro aparece na janelinha "Program Error" do proprio VFP (Cancel/Suspend/Ignore/Help) e nao no MostrarErro/FormErro do sistema, o metodo que estourou nao tem TRY/CATCH. Usar isso para localizar: procurar o metodo sem TRY/CATCH no caminho do botao que o usuario acionou (no Erro174 era BtnIncluirClick -> AjustarBotoesPorModo)
- **Abrir form MODAL de dentro de `LostFocus` pede guarda de reentrancia**: o Show() bloqueia, o foco sai e volta, e o proprio LostFocus pode disparar de novo, empilhando um segundo picker. Usar property booleana no form, setada na entrada e limpa DEPOIS do ENDTRY (para valer tambem quando o CATCH dispara). Diagnostico barato: num teste headless, Show() de form modal TRAVA a execucao - se o script termina dentro do timeout, o picker nao abriu
- **Init de form grande falha em CADEIA - "a tela abre" so se prova INSTANCIANDO**: cada defeito no Init esconde o proximo. Antes de dar por pronto, instanciar de verdade (CREATEOBJECT com gb_4c_ModoTeste/gb_4c_ValidandoUI) e repetir ate passar. Tres defeitos tipicos, cada um so visivel depois do anterior: (a) `Controls(<nome>)`; (b) `.ColumnN.Check1.<prop>` sem `AddObject`+`CurrentControl` -> "Unknown member CHECK1", porque a Column nasce so com Header1/Text1; (c) metodo CHAMADO mas nunca GERADO -> "Property X is not found", que pode significar uma ABA INTEIRA perdida (no Formgpd eram 71 controles). Auditar todo `THIS.<membro>` contra o proprio form E a heranca de FormBase/BusinessBase/GridBase. Ao reconectar aba perdida, conferir o TIPO da property no BO: coluna `numeric(1,0)` MULTI-VALOR achatada em LOGICO com `(col = 1)` faz valores 2..7 lerem .F. e regravarem 0 - converter para numerico ANTES de mapear
- **Icone: TRANSCREVER o Picture do legado, NUNCA inventar o nome do arquivo**: o VFP9 aceita .Picture/.Icon apontando para arquivo inexistente SEM erro nenhum (nem compilacao, nem runtime, nem log) - o controle so nao desenha icone. Copiar o Picture do controle correspondente no dump do legado e conferir que o arquivo existe em vbmp\. NAO escolher icone por semelhanca semantica: no FormBAL o botao "Fecha" usa cadastro_salvar_60.jpg (fechar a contagem = gravar) e no FormSigPrGlp "Disponiveis" usa geral_palete_60.jpg, nao uma lupa. Atencao: o arquivo real eh cadastro_vizualizar_60.jpg (com Z) e o sufixo _26/_60 NAO eh o tamanho (todos os icones sao 32x32)
- **Format contendo "M" = multiple choice, e o InputMask eh a LISTA de valores validos**: se o SCX legado declara Format = "M" ou "KM", o InputMask NAO eh mascara de digitacao e sim a lista separada por virgula (",T,S,I,N,F", "S,N", "A,B", "0,1", "S,N, "). TRANSCREVER o par LITERALMENTE do dump - trocar o M por "!" ou descartar o InputMask compila limpo e faz o campo aceitar QUALQUER caractere. Lista SEM item vazio coage branco para o 1o item (e o comportamento do legado)
- NUNCA usar literais acentuados - usar CHR(): a=225, c=231, ao=227, e=233, etc.
- NUNCA RETURN dentro de TRY/CATCH - inclui o RETURN BARE de guarda (sem valor), e vale no bloco TRY, no CATCH e no FINALLY. Fix: flag `loc_lProsseguir = .F.` no lugar do RETURN + envolver o resto do bloco em `IF loc_lProsseguir ... ENDIF` + RETURN unico DEPOIS do ENDTRY. So trocar o RETURN por atribuicao SEM envolver o resto descarta o early-exit e grava errado em silencio. `EXIT`/`LOOP` dentro do TRY sao seguros
- BINDEVENT funciona apenas com metodos PUBLIC (sem PROTECTED)
- **TesteAutomatico.prg chama metodos direto no oForm (nao so BINDEVENT)**: CarregarLista/AlternarPagina/AjustarBotoesPorModo/BtnIncluirClick/BtnCancelarClick sao chamados como `THIS.oForm.Metodo()` de FORA da classe. PEMSTATUS(oForm,"Metodo",5) retorna .T. mesmo se o metodo for PROTECTED (so verifica existencia, nao escopo) - o teste entra no branch e a chamada real falha com "Property METODO is not found." em runtime. Esses metodos DEVEM ser PUBLIC (sem PROTECTED).
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
- **Comentario de design decision NUNCA leva a frase "nao implementado"**: ao documentar por que um BO somente-leitura (form de CONSULTA sem INSERT/UPDATE/DELETE no legado) nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao(), NAO escrever "nao implementado"/"nao implementada" dentro de linha de comentario `*` - o validador 05d_validarCompletude tem regex que casa "nao implement" em QUALQUER comentario (nao so em TODO real) e rejeita a fase por falso positivo. Preferir frase como "o comportamento padrao herdado de BusinessBase ja eh o correto".
- **Label de dados: NUNCA inventar ``.Width`` + ``.Alignment = 1``**: a classe ``say`` do Framework legado eh ``AutoSize = .T.`` / ``Alignment = 0`` â€” o ``Say`` do SCX declara so ``Caption``/``Left``/``Top``, e esse ``Left`` ja foi calculado para o texto terminar poucos pixels antes do campo (FormCES: 411/415/415/418 com os TextBox em 455, textos terminando em 451). Inventar ``.Width = 60`` + ``.Alignment = 1`` encosta o texto na borda DIREITA da caixa, que cai DENTRO do TextBox; como o label eh criado antes, o controle desenha por cima e a legenda sai cortada ("Codigo :" vira "Codi") â€” compila limpo, so aparece na tela. Copiar ``Alignment``/``Width`` do dump: se o ``Say`` nao declara nenhum dos dois, usar ``.Alignment = 0`` com ``.Width`` que caiba o texto. ``AutoSize = .T.`` NAO resolve: eh no-op em Label criado por ``AddObject`` (a Width fica nos 100 do default). Auto-fix: CorretorAutomatico #202.
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
- **CheckBox.Value NUNCA atribuir DIRETO a prop LOGICAL do BO (dispara "Data type mismatch" no AND)**: Em `FormParaBO`/`FormParaRelatorio`, SEMPRE converter numerico para logico ao atribuir chk.Value em property declarada `.F.`/`.T.`: `.this_lXXX = (loc_oCnt.chk_4c_XXX.Value = 1)` — NUNCA `.this_lXXX = loc_oCnt.chk_4c_XXX.Value`. Sem conversao, a property vira NUMERICA (0/1) e a proxima expressao `<logical> AND <this_lXXX>` no BO dispara **erro 9 "Data type mismatch"** (nao 1817 "Operator/operand type mismatch" como esperado — VFP9 mascara). Reciproca em BO: em condicoes AND, NUNCA escrever `AND <numeric_field>` — sempre `AND <numeric_field> <> 0`. Ex: `IF SEEK(x) AND crSigCdMoe.Cotas <> 0` (NAO `AND crSigCdMoe.Cotas`); `IF !EMPTY(Nops) AND THIS.this_lProdutos` FALHA se this_lProdutos veio numerico do chk. Regra critica correlata: CATCH em `PrepararDados`/`Processar`/`BtnVisualizarClick` SEMPRE incluir `loc_oErro.LineNo` + `loc_oErro.Procedure` na msg (`MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em <PROC>")`) para localizar erros VFP mascarados. Auto-fix: CorretorAutomatico #150. Bug em FormSigReAtm/FormBlq/Formsigregli/FormSIGRECTL (2026-07-28, Erro65).
- **fCarregarCambio() NAO PORTADA - usar THIS.CarregarCambio() local**: Funcao legada `fCarregarCambio(pMoe, pDia)` do framework Fortyus (SIGFUNCS.PRG:5156) NUNCA foi portada para `projeto/app/utils/functions.prg`. Todo BO que converta moeda DEVE implementar `PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_xData)` local usando cursores `crSigCdCot` + `crSigCdMoe` (ou `cursor_4c_SigCdCot`/`cursor_4c_SigCdMoe` conforme naming do proprio BO — confirmar em `InicializarDados`/`InicializarCursores`). Chamar via `THIS.CarregarCambio(...)`. Se BO ja tem `THIS.ObterCotacao` (padrao sigprilaBO), reusar em vez de duplicar. Template canonico do metodo em `SigReAtmBO.prg:857` ou `SigReInvBO.prg:205`. Chamada direta a `fCarregarCambio(...)` quebra em runtime — mas o erro NAO eh "File not found" como esperado: VFP9 mascara e dispara "Data type mismatch" via CATCH de PrepararDados. Auto-fix: CorretorAutomatico #151. Bug em SigReAtmBO/sigprccpBO/sigreeqeBO/sigprilaBO (2026-07-28, Erro65).
- **`VAL(SET("Decimals"))` PROIBIDO - `SET("Decimals")` ja retorna NUMERIC em VFP9**: A funcao `SET()` retorna tipos DIFERENTES conforme a opcao: `SET("Escape")`/`SET("Fixed")`/`SET("Century")`/`SET("Talk")`/`SET("Date")`/`SET("Path")`/`SET("Point")`/`SET("Separator")` retornam **CHARACTER** ("ON"/"OFF"/valor); mas `SET("Decimals")` e `SET("REPORTBEHAVIOR")` retornam **NUMERIC**. Envolver retorno numerico com `VAL()` dispara **VFP9 erro 11 "Function argument value, type, or count is invalid."** imediatamente. Bug tipico: migrador copia o padrao de salvar/restaurar contexto de outros SETs e por reflexo escreve `loc_nDec = VAL(SET("Decimals"))`. **CORRETO**: `loc_nDec = SET("Decimals")` (sem VAL); `loc_nBhv = SET("REPORTBEHAVIOR")` (sem VAL). Restaurar: `SET DECIMALS TO loc_nDec` / `SET REPORTBEHAVIOR loc_nBhv`. Auto-fix: CorretorAutomatico #152. Bug em sigrebalBO (2026-07-28, Erro66) — quebrava PrepararDados imediatamente ao clicar Visualizar.
- **REPORT `Visualizar`/`Imprimir` — `IF !PrepararDados() / flag=.F. / ENDIF / REPORT FORM` fall-through PROIBIDO**: quando `PrepararDados()` retorna `.F.` (cursor vazio, filtros sem match, erro SQL), o bloco `IF ! ... ENDIF` seta a flag mas NAO interrompe o fluxo — cai direto em `REPORT FORM` que roda com cursor vazio/erro. Sintomas: preview em branco, "File does not exist", ou pior — NENHUMA mensagem para o usuario (que espera "Nenhum registro encontrado..."). **VARIANTE DOUBLE-IF (Erro110)**: mesma armadilha com 2+ IFs consecutivas — `IF !PrepararDados() / flag=.F. / ENDIF / IF !MontarCabecalho() / flag=.F. / ENDIF / REPORT FORM` — ambos IFs fall-through, REPORT FORM sempre roda. **FIX MINIMO (auto)**: adicionar `RETURN loc_l<Flag>` dentro do ULTIMO IF antes do ENDIF (early exit). **FIX IDEAL (manual)**: refatorar para fluxo positivo com AND encadeado `IF THIS.PrepararDados() AND THIS.MontarCabecalho() / loc_lSucesso = THIS.ExecutarReportForm("<Base>", "PREVIEW"\|"PRINTER_PROMPT"\|"PRINTER", THIS.this_cCursorDados) / THIS.LimparCursores() / ELSE / IF !EMPTY(THIS.this_cMensagemErro) / MsgErro(THIS.this_cMensagemErro, "Erro") / ENDIF / ENDIF` — helper canonico traz cursor-empty guard (MsgAviso automatico "Nenhum registro encontrado com os filtros informados."), FRX-existence check, locale isolation e menu restore. Template do helper em SigReAtmBO.prg:857 ou SigReCgcBO.prg (pos-Erro68) ou sigrecprBO.prg (pos-Erro110). Auto-fix: CorretorAutomatico #153 (minimo, agora cobre variante double-IF) + WARNING para refactor completo. Bug em sigrecheBO/sigredcoBO/SIGREDIRBO/SigReFtpBO (2026-07-28, Erro68); sigrecprBO/sigrechpBO (2026-08-12, Erro110 double-IF).
- **REPORT `PrepararDados` — `loc_lSucesso = .T.` INCONDICIONAL apos IF de erro PROIBIDO**: NUNCA escrever `IF loc_nResult < 0 / loc_lSucesso = .F. / ENDIF / SELECT (cursor) / GO TOP / loc_lSucesso = .T.` — a atribuicao final SOBRESCREVE o `.F.` setado no error branch. PrepararDados sempre retorna `.T.` mesmo com SQL error, e Visualizar/Imprimir chegam ao REPORT FORM com cursor invalido. **FIX**: envolver o success-path em ELSE explicito: `IF loc_nResult < 0 / loc_lSucesso = .F. / ELSE / SELECT (cursor) / GO TOP / loc_lSucesso = .T. / ENDIF`. Pattern correlato do fall-through Erro68/Erro110: garante que `PrepararDados` retorne `.F.` quando devido. Auto-fix: CorretorAutomatico #164 (WARNING-only — refactor exige contexto). Bug em sigreifxBO/SigReInfBO/SIGREIPSBO (2026-08-12, Erro110).
- **`IF !FILE(loc_cFrx)` bloco morto em REPORT `Visualizar`/`Imprimir` PROIBIDO**: template legado deixava `IF !FILE(loc_cFrx) / MsgErro/MsgAviso / loc_lXxx = .F. / ENDIF` DEPOIS do `IF !PrepararDados()` e ANTES de `THIS.ExecutarReportForm(...)`, com `loc_cFrx` declarado `LOCAL` mas NUNCA atribuido. VFP inicializa LOCAL como `.F.` (logical), logo `FILE(.F.)` dispara **VFP9 erro 11 "Function argument value, type, or count is invalid."** ao clicar Visualizar. NUNCA gerar esse bloco — o helper `THIS.ExecutarReportForm(...)` (Pattern #117) ja faz `FULLPATH + FILE + MostrarErro` descritivo. Template correto (fluxo positivo): `IF THIS.PrepararDados() / loc_lSucesso = THIS.ExecutarReportForm("<Base>", "PREVIEW"\|"PRINTER_PROMPT"\|"PRINTER", "<cursor>") / ENDIF` — sem qualquer referencia a `loc_cFrx`. Auto-fix: CorretorAutomatico #157 remove bloco morto quando (a) BO herda RelatorioBase, (b) `loc_cFrx` nunca eh atribuido, (c) bloco eh seguido de `ExecutarReportForm` em ate 5 linhas; Shape B (IF-ELSE) emite `WARN-157-IF-ELSE` (manual). Bug em Formsigrecmm sigrecmmBO + sweep afetou sigreimcBO/sigrehtcBO/SigReInvBO/sigrecgrBO (2026-08-05, Erro89).
- **REPORT `ConfigurarPaginaLista` — SEMPRE subtrair `PageFrame.Top` dos Tops absolutos legado**: Forms REPORT embrulham controles de filtro em `pgf_4c_Paginas.Page1`, com `PageFrame.Top = 85` (logo abaixo do cabecalho cinza). Controles adicionados via `loc_oPag.AddObject(...)` na Page usam coordenadas **RELATIVAS a Page1** — portanto os Tops legado (absolutos no form original) DEVEM ser subtraidos pelo `PageFrame.Top` na fase 4. Formula: `control.Top = layout.originalTop - PageFrame.Top`. **REGRA**: apos ler o Top do layout.json, aplicar a subtracao antes de gravar em `.Top =`. Excecoes que NAO subtraem: (a) `Buttons(N)` INTERNOS a OptionGroup/CommandGroup (relativos ao grupo, nao ao Page); (b) proprio Top do PageFrame em `ConfigurarPageFrame`. Sim subtraem: labels, textboxes, containers, o proprio Top do OptionGroup/CommandGroup. Sintomas de nao subtrair: layout inteiro empurrado N pixels pra baixo; ultimos controles (ex: OptionGroups no fim) ficam alem de `form.Height` e sao cortados; labels/textboxes desalinhados por rebordo do form. Referencia canonica CORRETA: `Formsigrecrf.prg` (task066) — comentario `"Posicoes top = original - 85 (PageFrame.Top=85)"` + valores subtraidos. Auto-fix: CorretorAutomatico #165 WARNING-only (parse regex nao distingue nesting Buttons(N) sem AST — refactor manual). Bug em Formsigrecnt (2026-08-13, Erro113): 23 controles com Top absoluto legado apesar de PageFrame.Top=85; OptLocal.Top=265 e OptOrdem.Top=289 saltaram alem de form.Height=350 e ficaram cortados. Meta-licao: o proprio codigo do bug tinha o comentario `"Posicoes: layout.json original top - 85 (offset do PageFrame)"` MAS valores nao subtraidos — comentario correto, codigo errado.
- **FormBuscaAuxiliar Pattern B (Init com params) PROIBIDO — usar helper `THIS.AbrirLookupCanonico(...)` OU Pattern A manual**: `CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "Tabela", "cursor", "campo", valor, "titulo")` + `mAddColuna` + `Show()` (Pattern B — 2+ args no CREATEOBJECT) tem **3 defeitos**: (1) Init interno faz `WHERE campo='X'` + `LIKE 'X%'` — se AMBOS retornam 0 rows, FECHA o cursor e picker abre vazio; (2) FormBuscaAuxiliar herda `DataSession=1` (shared) — se form pai eh `DataSession=2` (private), USED() pos-Show retorna .F. no caller e selecao perde; (3) cursor scope isolado entre sessoes. **PREFERIDO**: usar helper `THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, par_cValorFiltro, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)` em FormBase.prg (encapsula Pattern A completo em 1 chamada). **FALLBACK MANUAL (Pattern A)**: (1) SQL no CALLER com `LIKE 'valor%'` em cod OR desc + fallback SHOW-ALL se 0 rows; (2) `CREATEOBJECT("FormBuscaAuxiliar")` SEM parametros; (3) `.DefinirCursor(cursor, "Cods", "Descs", "titulo")` com aliases `AS Cods`/`AS Descs` no SELECT; (4) `IF .Mostrar()` — ler `.cCodigoSelecionado` / `.cDescricaoSelecionada` (nao SELECT cursor); (5) `USE IN SELECT(cursor)` no final. Reciproca em `Validar<Campo>`: quando busca exata falha, NUNCA `MsgAviso("nao encontrado")+limpar campo` — chamar `THIS.AbrirBusca<X>()` direto (picker abre filtrado pelo prefixo tipado). Ref canonico: `Formsigrecrf.prg` (task066) — Pattern A original; `Formsigrecog.prg` (task059, pos-Erro114) — Pattern A recem-convertido; `FormBase.prg:AbrirLookupCanonico` (helper novo, 2026-08-13). Auto-fix: CorretorAutomatico #166 WARNING-only (nao muta — cada call tem tabela/campos/titulo especificos exigindo contexto). Bug em Formsigrecog (2026-08-13, Erro114): usuario digita "M" em vendedor+Enter, picker abre vazio pois `WHERE codigos='M'` e `LIKE 'M%'` ambos 0 rows. Sweep pendente: ~209 forms com ~500 chamadas Pattern B, incremental form-a-form conforme testado.
- **`STR(<coluna_char>, N)` PROIBIDO — dispara VFP9 erro 11**: colunas CHAR de tabelas Sig* (ex: `SigCdGpr.codigos` char(3), `SigCdGcr.codigos` char(10), `SigMvCab.Emps` char(3), `SigCdCli.iclis` char(10), `SigCdGrp.cgrus` char(3)) NUNCA devem ser envolvidas com `STR()`. VFP9 `STR()` exige NUMERIC first arg — passar char dispara **erro 11 "Function argument value, type, or count is invalid."** em runtime (LOCATE, INSERT, Value assignment). ERRADO: `ALLTRIM(STR(cursor_4c_X.codigos, 2))` / `LOCATE FOR ALLTRIM(STR(codigos, 5)) = ALLTRIM(loc_cCod)`. CORRETO: `ALLTRIM(cursor_4c_X.codigos)` / `LOCATE FOR ALLTRIM(codigos) == ALLTRIM(loc_cCod)`. **REGRA GENERICA**: SEMPRE consultar schema.sql antes de escrever `STR(<coluna>)` — se a coluna eh char, remover o STR. Colunas char comuns: `codigos`, `cgrus`, `cemps`, `iclis`, `cpros`, `cunis`, `dopes`, `grupos`, `classes`, `emps`, `razas`, `descs`, `descrs`, `rclis`. Auto-fix: CorretorAutomatico #158 (whitelist de colunas char via schema; regex `STR\(\s*(cursor\.)?<col>\s*,\s*\d+\s*\)` -> `<col>`; skip strings SQL detectadas por aspas/colchetes). Bug em FormSigReCmp ValidarGrdGrupoCod/AbrirBuscaGrdGrupo/ValidarGrdGrupoDesc — 6 sites (2026-08-05, Erro90-a).
- **`.InputMask = "##..#"` em TextBox `.Value = ""` (CHAR) PROIBIDO — bloqueia letras**: em VFP9, `#` no `InputMask` aceita APENAS digitos/espacos/sinais. Se a coluna do banco eh `char(N)` (que pode conter letras — ex: `SigCdGpr.codigos = 'A01'`), o usuario nao consegue digitar letras. Migrador copia InputMask numerico do legado sem checar tipo. **REGRA**: se `.Value = ""` (indica char), NUNCA usar `.InputMask = "#+"` — usar `.MaxLength = N` (limita tamanho sem restringir tipo). Se `.Value = 0` (indica numeric), manter `.InputMask = "###..."` OK. ERRADO: `WITH txt / .Value = "" / .InputMask = "##" / ENDWITH` sobre coluna char(3). CORRETO: `WITH txt / .Value = "" / .MaxLength = 3 / ENDWITH`. Auto-fix: CorretorAutomatico #159 detecta `.InputMask = "#+"` numa janela WITH com `.Value = ""` e substitui por `.MaxLength = <count-hashes>`; se .Value = 0 mantem; se ambiguo emite `WARN-159-INPUTMASK-AMBIGUO`. Bug em FormSigReCmp Grande Grupo txt_4c__cd_ggrupo (2026-08-05, Erro90-b).
- **`<Cursor>.<Coluna>` DEVE bater com SELECT list — nao prefixar por convencao**: BO faz `SELECT a.Emps FROM SigMvCab a INTO CURSOR CrSigMvCab`; depois referenciar `CrSigMvCab.Cemps` (com prefixo `C` invento por convencao Sig*Cd*) dispara **"Variable 'CEMPS' is not found."** ao runtime. VFP9 alias.coluna EXIGE que a coluna esteja no SELECT list literal — nao ha auto-prefixamento nem alias implicito. **REGRA**: apos escrever SELECT list, listar as colunas selecionadas e SEMPRE usar EXATAMENTE esses nomes ao referenciar `<Cursor>.<Col>`. Nunca "corrigir" o nome por padrao (Emps eh Emps, mesmo em tabela Sig*). Auto-fix: CorretorAutomatico #160 mapa cursores + colunas referenciadas + emite WARNING (nao muta — parse SQL fragil). Bug em SigReCmpBO.prg linhas 675 e 707: `CrSigMvCab.Cemps` vs SELECT `a.Emps` (2026-08-05, Erro91).
- **`SigMv*.emps` vs `SigCd*.cemps` — nomes DIFERENTES entre MOVIMENTO e MESTRE**: Coluna de empresa tem naming irregular entre tabelas. Tabelas MOVIMENTO (`SigMvCab`, `SigMvItn`, `SigMvNfi`, `SigMvPar`, `SigMvCcr`) usam `emps` (SEM prefixo C). Tabela MESTRE `SigCdEmp` usa `cemps` (COM prefixo C). JOIN CORRETO: `INNER JOIN SigCdEmp e ON e.cemps = a.emps` (onde `a` = SigMv*). Escrever `a.cemps` quando `a` = SigMv* dispara SQL Server **"Nome de coluna 'cemps' invalido"** ao clicar Visualizar/Imprimir. **REGRA**: SEMPRE consultar `docs/schema.sql` antes — nunca deduzir por convencao. IRREGULARIDADES conhecidas: `SIGFICHC` usa `emps` (apesar de prefixo Fi de master); `SIGFITEF` usa `cemps` (apesar de prefixo Fi de master). Colunas confirmadas: `SigMvCab.emps` linha 13180, `SigMvNfi.emps` linha 14464, `SigFiChc.emps` linha 11229, `SigCdEmp.cemps` linha 3111, `SigFiTef.cemps` linha 12098. Complementa Erro91 (invented C prefix em cursor) e Erro106 (WHERE `Emps` em SigCdPam single-row). Auto-fix: CorretorAutomatico #161 WARNING-only (parse fragil — muitos falsos positivos quando `a` = SigCdEmp legitimo). Bug em sigrecogBO.prg:211 + sweep sigrecsmBO/SIGREDIRBO/CecBO (2026-08-12, Erro108).
- **FRXs legados DEVEM ser copiados ao gerar BO REPORT**: BO REPORT que referencia FRX via `THIS.ExecutarReportForm("SigReXxx", ...)` ou `THIS.ObterNomeFRX()` retornando `"SigReXxx"` SOMENTE funciona se `SigReXxx.frx`+`.frt` existirem em `C:\4c\projeto\app\reports\`. Se ausentes, helper Pattern #117 exibe **"Arquivo de relatorio nao encontrado: C:\4C\PROJETO\APP\START\..\reports\SigReXxx.frx"** ao clicar Visualizar (path esta correto — o problema eh arquivo faltante). **REGRA**: apos gerar BO REPORT, extrair TODOS os nomes FRX referenciados (do `ExecutarReportForm` + todas as branches de `ObterNomeFRX`) e copiar `<Nome>.frx`+`<Nome>.frt` de `C:\4install\FortyusMC\Fortyus\` para `C:\4c\projeto\app\reports\` preservando o nome-case do BO (Windows FS eh case-insensitive). Ferramenta: `powershell -ExecutionPolicy Bypass -File C:\4c\automation\CopiarFRXsAusentes.ps1` (dry-run + auto-copia; retorna exit code 2 se algum FRX nao existe no legado). Bug em FormSigReCmp — SigReCp2.frx + SigReCp3.frx nunca portados (2026-08-05, Erro92).
- **IF THEN inline PROIBIDO**: VFP9 NAO suporta `IF cond THEN cmd` numa unica linha. Gera "Command contains unrecognized phrase/keyword." SEMPRE expandir para multi-linha: `IF cond` / `  cmd` / `ENDIF`.
- **COUNT TO var IN alias PROIBIDO**: VFP9 COUNT nao tem clausula IN. Gera "Command contains unrecognized phrase/keyword." Usar: `SELECT alias` + `COUNT TO var`.
- **APPEND FROM requer SELECT cursor antes**: `ZAP IN cursor_name` NAO muda a work area corrente. `APPEND FROM DBF("tmp")` vai para a work area CORRENTE. SEMPRE fazer `SELECT cursor_destino` antes de `APPEND FROM`. Sem isso, dados vao para o cursor errado e o grid fica vazio.
- **CommandGroup.FontName NAO EXISTE**: CommandGroup (como OptionGroup) NAO tem FontName/FontSize. Definir em cada `.Buttons(N).FontName`. Tentar no grupo causa "Property FONTNAME is not found" que cascateia e impede toda configuracao dos botoes.
- **AlternarPagina eh o FUNIL de volta - repor o MODO e reabilitar os botoes (Erro176)**: em forms CRUD, `AlternarPagina(1)` tem de fazer as DUAS coisas - `THIS.this_cModoAtual = "LISTA"` DENTRO do `IF par_nPagina = 1` e `THIS.AjustarBotoesPorModo()` no FIM do metodo. Quem so chama `AjustarBotoesPorModo` nos `Btn*Click` de ENTRADA (Incluir/Alterar/Visualizar) deixa os 5 botoes da Lista cinza depois de GRAVAR e depois de CANCELAR: nao estoura, nao entra em log, nao quebra compilacao (eh estado que ninguem restaura) e a tela fica inutilizavel ate ser fechada. Medido no VFP9 em 2026-09-24: so a chamada, sem repor o modo, NAO resolve (Formemp/Formsigpdmp7/FormSRV/FormDpi continuaram em `.F.`), porque a reabilitacao passa a depender de cada caller trocar o modo antes. Forma canonica: `THIS.pgf_4c_Paginas.ActivePage = par_nPagina` / `IF par_nPagina = 1` / `THIS.this_cModoAtual = "LISTA"` / `THIS.CarregarLista()` / `ENDIF` / `THIS.AjustarBotoesPorModo()`. Referencia: Formcfi, Formcnl, FormFNF, FormOcc. Gate: CorretorAutomatico pattern #210
- **Chave POSICIONAL concatenada: NUNCA ALLTRIM nas partes (Erro177)**: chave montada concatenando colunas ``char`` de largura fixa eh POSICIONAL - o padding FAZ PARTE da chave. O legado do SIGMVSBN monta ``lcEmpDopNums = TmpSubN.Emps + TmpSubN.Dopes + Str(TmpSubN.Numes, 6)`` SEM ALLTRIM, porque ``Emps`` eh ``char(3)`` e ``Dopes`` eh ``char(20)``: 3 + 20 + 6 = **29**, que eh exatamente ``EmpDopNums char(29)``. Escrever ``ALLTRIM(par_cEmps) + ALLTRIM(par_cDopes) + STR(par_nNumes, 6)`` da 15 caracteres (``001MALOTE     3``) e **nunca casa** com o valor gravado (``001MALOTE                   3``): o SELECT roda SEM ERRO e devolve ZERO linhas - sem exception, sem log, so a tela vazia (no FormSigMvSbn isso deixava a grade de itens, a descricao e a imagem do produto permanentemente vazias, e os handlers de AfterRowColChange/DblClick viravam codigo morto). Usar ``PADR(parte, <largura da coluna no schema>)`` EXPLICITO - nao confiar no padding que o cursor por acaso traz, porque ``ObterChavePrimaria()`` chama o mesmo montador com as properties do BO, que o ``Init`` do Form guarda JA com ALLTRIM. **A largura do ``char(N)`` destino eh a conferencia**: se a soma das partes nao da N, a montagem esta errada. ATENCAO a distincao ao varrer: ALLTRIM nas partes INTERIORES quebra, mas ALLTRIM na chave INTEIRA (no fim) eh inofensivo - ``char`` no SQL Server compara com blank-padding ANSI - e esse caso inofensivo eh o MAJORITARIO, entao tratar os dois igual produz WARNING massivo. **Instanciar o form NAO pega este defeito**: ``InicializarForm`` pula ``CarregarLista`` em ``gb_4c_ModoTeste`` e o TestFormWrapper passa com SUCESSO; num visualizador, o equivalente a "testar gravando" eh provar que a consulta devolve LINHA (conferir RECCOUNT, nao o retorno ``.T.``)

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
- **Left RELATIVO em botoes de container (Erro143)**: Dentro de `WITH .cmd_4c_Incluir/Visualizar/Alterar/Excluir/Buscar` (filhos de cnt_4c_Botoes), usar `.Left` RELATIVO ao container: Incluir=5, Visualizar=80, Alterar=155, Excluir=230, Buscar=305. NUNCA copiar o Left absoluto do container pai (542) para os botoes filhos — isso posiciona o botao em 542+542=1084, fora do form (Width=1000), INVISIVEL. Dentro de `WITH .cmd_4c_Encerrar` (filho de cnt_4c_Saida), usar `.Left=5` NUNCA `.Left=917`. Auto-fix: CorretorAutomatico #182.
- **Grid.ColumnCount NUNCA reatribuir em Carregar* (Erro144)**: Em VFP9, qualquer atribuicao a ColumnCount recria TODOS os objetos de coluna, destruindo controles AddObject (CheckBox/ComboBox). Definir ColumnCount APENAS em ConfigurarAba*/ConfigurarGrid* na inicializacao. Nos metodos Carregar*Aba/CarregarLista NAO reatribuir ColumnCount. Protecao: PEMSTATUS(grid.ColumnN, "controle", 5) antes de acessar controle AddObject'd. Warning: CorretorAutomatico #183.
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
- **REPORT FORM &var. (macro) OU REPORT FORM (var) (parenteses) OU REPORT FORM &lt;base&gt; BARE SEM guard IF FILE() + isolamento locale PROIBIDO — usar helper THIS.ExecutarReportForm()**: TODO `REPORT FORM` em form OPERACIONAL que emite relatorio (impressao de comanda/etiqueta/documento) DEVE passar por helper `PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)` que combina: guard `IF NOT FILE(FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx"))` + isolamento `SET POINT TO "." / SET SEPARATOR TO "," / SET REPORTBEHAVIOR 80` (salvar antes, restaurar depois). Modos: `"PREVIEW"`, `"PRINTER_PROMPT"`, `"PRINTER"`. TRES formas cobertas: (a) macro `REPORT FORM &<var>. PREVIEW NOCONSOLE`; (b) parenteses `REPORT FORM (<var>) PREVIEW NOCONSOLE`; (c) **BARE** `REPORT FORM <BaseName> PREVIEW NOCONSOLE` (sem path/parens/macro — MAIS COMUM no legado; VFP9 procura no CWD ao inves de `gc_4c_CaminhoReports`). Sem guard: FRX ausente estoura sem indicar arquivo. Sem isolamento: FRXs Fortyus legados renderizam campos numericos como `*******` (asteriscos) em VFP9 default (REPORTBEHAVIOR 90 + POINT="," BR conflitam com PICTUREs `9,999.999`). Auto-fix: Pattern #117 (`Corrigir-ReportFormSemGuard`, macro/parens) + Pattern #147 (`Corrigir-ReportFormBareSemPath`, forma bare). Ambos injetam o helper canonico se ausente. **Erro63 (2026-07-24)**: o helper DEVE terminar com `TRY / SET SYSMENU TO DEFAULT / RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda / CriarMenuPrincipal() / CATCH / ENDTRY` — `_MREPORT` do preview corrompe `_MSYSMENU`; sem `SET SYSMENU TO DEFAULT` os 7 pads default do VFP ficam perdidos e menu fica "com menos telas". Bugs: Formsigrepes (Erro27/28, macro) + FormSIGREVIS (Erro29/30, parenteses + cursor vazio) + sigreappBO (Erro62 2026-07-24, bare) + FormSIGREAPR (Erro63 2026-07-24, menu shrinks).
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
- **FormBuscaAuxiliar par_cTabela = NOME PURO de tabela — NUNCA concatenar `" WHERE ..."`**: O 2o parametro do `CREATEOBJECT("FormBuscaAuxiliar", nConn, par_cTabela, ...)` deve ser apenas o nome da tabela (ex: `"SigCdCli"`). Concatenar `"SigCdCli" + " WHERE grupos = 'X'"` gera SQL final `SELECT * FROM SigCdCli WHERE grupos = 'X' WHERE CAST(Iclis...) = '1'` (duplo WHERE) → SQL Server retorna `Sintaxe incorreta proxima a palavra-chave 'WHERE'`. CORRETO: passar tabela pura no 2o param + condicao SEM prefixo WHERE no 9o param `par_cFiltro`: `CREATEOBJECT("FormBuscaAuxiliar", nConn, "SigCdCli", cursor, campo, valor, titulo, .F., .T., "grupos = " + EscaparSQL(loc_cGrupo))`. Helper interno concatena ` AND (par_cFiltro)` automaticamente. Auto-fix: CorretorAutomatico Pattern #154 (WARNING-only — refactor requer adicionar 3 params extras). Bug em Formsigrechp AbrirLookupDesConta/EmiConta (2026-08-04, Erro87).
- **SigCdCli NAO TEM coluna `grclis` — coluna de grupo eh `grupos` (char 10)**: A tabela `SigCdCli` (cadastro de clientes/contas) tem `grupos`, `grupocobs`, `grupomats`, `grupovens`, `grupocents`, `gruprods`, `grufals` — TODAS ausentes de `grclis`. `grclis` pertence a `SigChe`/`SigCqChm` (grupo do emitente do cheque). Bug tipico: gerador copia filtro de report legado (`AND b.grclis = ?` onde `b`=SigChe) para lookup de SigCdCli (`SELECT rClis FROM SigCdCli WHERE Iclis = ? AND grclis = ?`) — SQL Server retorna "Invalid column name 'grclis'" mascarado em CATCH silencioso. CORRETO: usar `grupos` em queries sobre SigCdCli. Reciproca: em SigChe/SigCqChm com alias, `grclis` (grupo emissor) e `grupos` (grupo destino) COEXISTEM e tem semanticas opostas — nao trocar. Regra generica: SEMPRE consultar `docs/schema.sql` (UTF-16 — usar `Get-Content -Encoding Unicode`) antes de escrever coluna de tabela Sig*. Auto-fix: CorretorAutomatico Pattern #155 (WARNING-only). Bug em Formsigrechp (2026-08-04, Erro87, 6 sites).
- **Path do FRX/reports: SEMPRE `gc_4c_CaminhoReports + "<Base>.frx"` — NUNCA `gc_4c_CaminhoBase + "reports\..."`**: `gc_4c_CaminhoBase = JUSTPATH(SYS(16))` retorna `C:\4c\projeto\app\start` **sem trailing backslash**. Concatenar `"reports\..."` produz `startreports\...` (path corrompido, FRX nao encontrado). `gc_4c_CaminhoReports` ja resolve `..\reports\` corretamente — usar SEMPRE essa variavel. Analogo para XLS: `gc_4c_CaminhoReports + "SigReXxx_YYYYMMDD.xls"`. Alias tambem proibido: `ADDBS(gc_4c_CaminhoBase) + "reports\"` (falta navegacao `..\`). Regra generica: usar sempre `gc_4c_CaminhoReports`/`gc_4c_CaminhoClasses`/`gc_4c_CaminhoUtils`/`gc_4c_CaminhoForms`/`gc_4c_CaminhoIcones` — NUNCA reconstruir a partir de `gc_4c_CaminhoBase`. Auto-fix: CorretorAutomatico Pattern #156. Bug em sigrecmmBO/sigrehtcBO/SIGREFXVBO/FormSIGREFXV (2026-08-04, Erro88, 5 sites).
- **`ALLTRIM(<cursor>.<coluna_numeric>)` dispara VFP9 erro 11 — consultar schema.sql para tipo antes de remover `STR()`**: `ALLTRIM`/`EscaparSQL` exigem char first arg; concat direto `<numeric> + "string"` estora "Operator/operand type mismatch". Pattern #158 (auto-fix) remove `STR()` de `ALLTRIM(STR(<col>, N))` APENAS quando coluna eh CHAR (whitelist via `docs/schema.sql`); replicacao manual OU migracao de novo cursor DEVE consultar schema.sql antes. Exemplos criticos: `SigCdGpr.codigos = char(3)` (REMOVE STR) mas `SigCdTom.codigos = numeric(2,0)` (MANTEM STR — se remover, `ALLTRIM(numeric)` estora "Function argument value, type, or count is invalid." no `Init/InicializarDados` e o form NAO ABRE). Padrao CORRETO: `INSERT INTO cur (Descri) VALUES (ALLTRIM(STR(<cursor>.Codigos, 2)) + "-" + ALLTRIM(<cursor>.Descrs))`. Regra: se em duvida sobre tipo, MANTER STR — custo negligenciavel, sempre funciona. NAO automavel (WARNING-only — Pattern #158 whitelist ja cobre o caso comum; adicionar auto-fix reverso repete o proprio bug). Bug em SigReCmpBO.prg:124 (2026-08-06, Erro93) — commit "chore mudanca manual pos-sweep" replicou Pattern #158 sem checar schema.sql; sweep retroativo Erro93 corrigiu +3 BOs (`sigrefcxBO:230` concat direto numeric, `SIGREADSBO:174 e 371`, `sigreatoBO:238`). Meta-licao: commits "chore mudanca manual pos-sweep" que replicam auto-fix sem consultar schema.sql sao a fonte #1 de regressao.
- **PUBLIC vars legado Fortyus (`Usuar`, `Comando`, `gcTipoUsuario`) DEVEM ser aliased em `config.prg` — nao so `goSistema`/`_EMPR`**: Alem do `sigacess.PRG` (Erro120/Pattern #171), config.prg precisa declarar as 5 PUBLICs canonicas do padrao Fortyus (`sig.PRG:3` declara `Public Usuar, Comando, gcLogoRel, gcCabRel, _Empr`) + `goSistema` + `gcTipoUsuario`. Dump binario dos VCTs mostra `goSistema` 49x, `_EMPR` 10x, `Usuar` 2x. As funcoes de `sigacess.PRG` usam `Usuar` como FALLBACK: `pUsu = Upper(Iif(Type([pUsu]) = [C], pUsu, Usuar))`. Se `Usuar` nao existe como PUBLIC, VFP9 dispara "Variable USUAR is not found" que cascateia como "Error instantiating the object GET_GRUPOVEN" — MESMA mensagem do Erro120 mas causa diferente. Fix em `config.prg` apos os aliases existentes (`gcUsuarioLogado`/`gcLogoRel`/`goSistema`/`_EMPR`): `PUBLIC Usuar, Comando, gcTipoUsuario / Usuar = gc_4c_UsuarioLogado / Comando = "" / gcTipoUsuario = ""`. Usuar recebe o codigo do usuario logado (nao um bool/string vazio); Comando e gcTipoUsuario podem ser vazios (usados pelas funcoes que checam TYPE()). Ordem: PUBLIC blocks DEVEM vir ANTES de `CarregarSeExistir(gc_4c_CaminhoFramework + "sigacess.PRG")` — vars precisam existir quando sigacess carrega. Auto-fix: CorretorAutomatico #172 WARNING-only (detecta config.prg com sigacess.PRG carregado + missing PUBLIC Usuar/Comando). Complementa Erro120/Pattern #171. Bug em FormCliente (Erro121 2026-08-19, mesma msg do Erro120 apos fix Erro120 nao resolver).
- **Framework legado Fortyus — funcoes de acesso em `sigacess.PRG` DEVEM ser carregadas no startup (`config.prg`)**: Forms wrapper de VCXs legado (`clsconta`/`clstitulo`/`clsproduto`/`clsplano`/similar em `framework.vcx`/`classresp.vcx`/`classobj.vcx`) instanciam controles como `GET_GRUPOVEN`/`GET_CONTA`/`GET_GRUPOMAT` que herdam de `fwget` (framework.vcx) e cujo `Init()` chama funcoes globais legado: `fAcessoCampos`, `fAcessoContab`, `fAcessoContas`, `fAcessoEmpresa`, `fAcessoGrupos`, `fAcessoMovInd`, `fAcessoMovmto`, `fAcessoProduto`, `fAcessoTitulo`, `fChecaAcesso`, `fChecaAcessoJOB`, `fRestritos` (12 funcoes em `C:\4c\Framework\sigacess.PRG`). Sem essas funcoes em memoria, VFP9 falha silenciosamente ao instanciar o controle e estora **"Error instantiating the object GET_GRUPOVEN"** (ou similar) em runtime — o erro nao aponta pra funcao ausente, aponta pra `AddObject` do wrapper. Fix sistemico em `config.prg` (uma unica linha, apos carregar `functions.prg`/`messages.prg`/`validators.prg`): `CarregarSeExistir(gc_4c_CaminhoFramework + "sigacess.PRG")`. `gc_4c_CaminhoFramework` (variavel do Erro119) resolve para `C:\4c\Framework\sigacess.PRG`. **REGRA GENERICA**: sempre que um form usar `AddObject(nome, "clsconta")` (ou clstitulo/clsproduto/clsplano/etc), config.prg DEVE carregar sigacess.PRG. Se no futuro outros PRGs legado forem necessarios (`SIGFUNCS.PRG`, `SIGOPE.PRG`, etc.), adicionar mesmo padrao. Auto-fix: CorretorAutomatico #171 WARNING-only (detecta form com `AddObject(_,"cls*")` de VCX legado + config.prg sem sigacess.PRG). Complementa Erro119 (path Framework via `gc_4c_CaminhoFramework`). Bug em FormCliente (Erro120 2026-08-19, "Error instantiating the object GET_GRUPOVEN. Linha: 240. Procedure: configurarcontacls" apos fix Erro119 permitir SET CLASSLIB funcionar).
- **Paths para Framework legado Fortyus (VCXs, imagens) — SEMPRE `gc_4c_CaminhoFramework + "<X>"`, NUNCA `gc_4c_CaminhoBase + "Framework\\<X>"`**: A pasta legado `C:\4c\Framework\` (com VCXs `framework.vcx`/`classresp.vcx`/`classobj.vcx` e subpastas como `imagens\`) fica **3 niveis acima** de `gc_4c_CaminhoBase` (`C:\4c\projeto\app\start\`). Concatenar `gc_4c_CaminhoBase + "Framework\\..."` resolve para `C:\4c\projeto\app\start\Framework\...` (inexistente) — SET CLASSLIB falha silenciosamente sob `IF FILE(...)` guard, e depois `THIS.AddObject(nome, "clsconta")` estora **"Class definition CLSCONTA is not found"** em runtime. Idem para imagens: `THIS.Picture = gc_4c_CaminhoBase + "Framework\\imagens\\new_background.jpg"` nao carrega. Fix sistemico em `config.prg`: variavel global `PUBLIC gc_4c_CaminhoFramework / gc_4c_CaminhoFramework = ADDBS(gc_4c_CaminhoBase) + "..\\..\\..\\Framework\\"` — mesmo padrao de `gc_4c_CaminhoIcones` (que ja usa `"..\\..\\..\\vbmp\\"`). Substituicao canonica: `gc_4c_CaminhoBase + "Framework\\<X>"` → `gc_4c_CaminhoFramework + "<X>"`. Cobre VCXs (`SET CLASSLIB TO (gc_4c_CaminhoFramework + "framework.vcx") ADDITIVE`) E imagens (`THIS.Picture = gc_4c_CaminhoFramework + "imagens\\new_background.jpg"`). Regra generica: usar SEMPRE as variaveis publicas ja resolvidas (`gc_4c_CaminhoFramework`/`gc_4c_CaminhoReports`/`gc_4c_CaminhoClasses`/`gc_4c_CaminhoUtils`/`gc_4c_CaminhoForms`/`gc_4c_CaminhoIcones`), NUNCA reconstruir de `gc_4c_CaminhoBase`. Analogo ao Pattern #156 (`gc_4c_CaminhoBase + "reports\\..."` → `gc_4c_CaminhoReports`). Auto-fix: CorretorAutomatico Pattern #170 (regex-based, sem falso positivo — `gc_4c_CaminhoBase + "Framework\\..."` NUNCA eh valido). Bug em FormCliente 2 sites (linha 82 fundo tela + linhas 219-221 VCX libs) — 17+ arquivos afetados pelo sweep 2026-08-19. Origem: Erro119 (2026-08-19, FormCliente linha 237 "Class definition CLSCONTA is not found. Procedure: configurarcontacls").
- **Cursores globais Fortyus (`crSigCdPam`, `crSigCdSer`, etc.) DEVEM ser populados no BO.Init() — NAO existem no startup do sistema novo**: Sistema legado Fortyus pre-carregava cursores globais como `crSigCdPam` (parametros system-wide com `GrPadClis`/`GrPadVens`/`GrPadCfos`) durante o startup (login). Sistema novo NAO faz esse pre-load — cada BO responsavel por form que depende do cursor DEVE popula-lo em `Init()` apos `DODEFAULT()`. Sem isso, `USED("crSigCdPam")` retorna `.F.` e a checagem downstream falha SILENCIOSAMENTE — form abre EM BRANCO com apenas MsgAviso ("Grupo Padrao Nao Configurado"), pois o path de erro seta `loc_lSucesso = .T.` mas pula `ConfigurarCabecalho`/`ConfigurarContaCls`/`AddObject` (defensivo demais). **REGRA**: qualquer BO cujo form referencia `USED("crSigCdPam")` OU `crSigCdPam.<coluna>` DEVE injetar em `Init()` o bloco canonico (`Formsigatcrp.prg:1253-1281`): `TRY / IF USED("crSigCdPam") / USE IN crSigCdPam / ENDIF / IF TYPE("gnConnHandle")="N" AND gnConnHandle>0 / loc_nResult = SQLEXEC(gnConnHandle, "SELECT GrPadClis FROM SigCdPam", "cursor_4c_Pam_Temp") / IF loc_nResult > 0 / SELECT * FROM cursor_4c_Pam_Temp INTO CURSOR crSigCdPam READWRITE / IF USED("cursor_4c_Pam_Temp") / USE IN cursor_4c_Pam_Temp / ENDIF / IF RECCOUNT("crSigCdPam") > 0 / SELECT crSigCdPam / GO TOP / ENDIF / ELSE / CREATE CURSOR crSigCdPam (GrPadClis C(10)) / APPEND BLANK / ENDIF / ELSE / CREATE CURSOR crSigCdPam (GrPadClis C(10)) / APPEND BLANK / ENDIF / CATCH TO loc_oErro / IF !USED("crSigCdPam") / CREATE CURSOR crSigCdPam (GrPadClis C(10)) / APPEND BLANK / ENDIF / ENDTRY`. Fallback `CREATE CURSOR + APPEND BLANK` cobre modo teste (`gb_4c_ValidandoUI = .T.`, sem `gnConnHandle`) E SQL fail. Ajustar colunas conforme cursor (crSigCdPam pode ter `GrPadVens`/`GrPadCfos`/etc — checar quais colunas o form/BO ACESSA e adicionar ao SELECT). **REGRA SECUNDARIA (defensiva no form)**: no lugar de `MsgAviso("Grupo Padrao Nao Configurado") / loc_lSucesso = .T.` (que abre form em branco), preferir `MsgErro("Configurar Grupo Padrao em SigCdPam antes de abrir cadastro de clientes.") / loc_lSucesso = .F.` (que impede abertura) — mas o fix primario eh popular o cursor no BO. Auto-fix: CorretorAutomatico Pattern #169 WARNING-only (detecta form referenciando crSigCdPam mas BO nao cria — nao muta pois refactor cirurgico varia por caso). Bug em ClienteBO/FormCliente (Erro118 2026-08-19, "Grupo Padrao Nao Configurado" + form em branco).
- **Forms wrapper (`clsconta`/`clstitulo`/`clsproduto`/etc) — botoes CRUD topo-direita (`BtnIncluirClick`/`BtnAlterarClick`/`BtnVisualizarClick`/`BtnExcluirClick`) DEVEM re-executar as validacoes portadas do Init legado ANTES de `IrParaDados()`/`IrParaXxx()`**: Init do form wrapper roda 1x na abertura; se um botao CRUD chama `IrParaDados()` sem re-validar, mudancas de estado (Grupo do filtro alterado apos a abertura, cursores globais `crSigCdPam`/`crSigCdGcr` esvaziados) causam salto silencioso para a aba Dados em branco (usuario reporta "sem selecionar Grupo o form vai pra Dados"). **REGRA**: extrair helper `PROTECTED FUNCTION ValidarPreAcao(par_cAcao)` que replica as checagens do Init legado — resolve Grupo (filtro `txt_4c_FiltroGrupo` -> `this_cGrupo` -> `crSigCdPam.GrPad<X>s`), valida `crSigCdPam`/`crSigCdGcr` populados, Grupo != vazio, `LOCATE FOR Codigos == Grupo` em `crSigCdGcr`, e `fChecaAcesso("<PGM>","ALTERAR")` (skip para VISUALIZAR). Retorna `.T.` se OK, `.F.` se falhou (ja exibiu MsgAviso). Chamar `IF !THIS.ValidarPreAcao("<ACAO>") / RETURN / ENDIF` ANTES do TRY em CADA botao CRUD. Mensagens iguais ao legado via `CHR()` (Grupo Padrao Nao Configurado / Nenhum Grupo de Conta Cadastrado / Configuracao de Parametros do Sistema Nao Encontrado / Usuario Nao Possui Acesso). Todos os `RETURN` ficam ANTES do `TRY` (respeita CLAUDE.md #1). Ref canonico: `FormCliente.prg:1985-2050` (helper) + `FormCliente.prg:2364-2410` (uso nos 4 botoes). Auto-fix: CorretorAutomatico Pattern #173 WARNING-only (detecta `PROCEDURE Btn(Incluir|Alterar|Visualizar|Excluir)Click` chamando `THIS.IrPara*` sem chamada previa a `THIS.ValidarPreAcao`). Bug em FormCliente 2026-08-21 (Erro132) — botoes CRUD chamavam IrParaDados() sem re-validar Grupo.
- **ValidarPreAcao — textbox de filtro (`txt_4c_FiltroGrupo`/`txt_4c_FiltroX`) eh FONTE UNICA quando visivel na tela; NUNCA fallback silencioso para property `THIS.this_cX`**: Complemento critico do Pattern #173. Quando o filtro esta visivel (form em Lista ou aberto pelo menu com filtros CRUD), ler o textbox diretamente SEM fallback para propriedade guardada de estado anterior. Se textbox vazio → `MsgAviso("Grupo Obrigat" + CHR(243) + "rio. Preencha o Grupo de Contas antes de prosseguir.", "Aten" + CHR(231) + CHR(227) + "o")` + `<oFiltros>.<txt_filtro>.SetFocus()` + `RETURN .F.`. Se textbox tem valor mas nao existe no cursor de referencia (`crSigCdGcr`/`crSigCdCli`/etc): `MsgAviso("Grupo Inv" + CHR(225) + "lido: [" + loc_cGrupo + "] n" + CHR(227) + "o cadastrado.", ...)` + SetFocus + RETURN .F. Fallback para `THIS.this_cGrupo` → `crSigCdPam.GrPadClis` SO permitido quando textbox NAO existe (form aberto por programa via Init com `par_cGrupo`, sem UI de filtro). Bug: fallback silencioso para `this_cGrupo` mascarava intencao do usuario ao limpar o campo (Botao Incluir prosseguia sem validacao, gravando registros no grupo antigo em memoria). Regra correlata: wrapper `PROTECTED FUNCTION ChamarMLeDadosSeguro(par_cGrupo, par_cCli, par_cTpCadCli, par_cTpBloqCar, par_cMudaCpfCgc)` para TODAS chamadas a `THIS.cnt_4c_Conta.mLeDados(...)` — se `EMPTY(par_cGrupo) AND EMPTY(par_cCli)`, salva `THIS.pcEscolha` em local, seta `THIS.pcEscolha = "PROCURAR"` (ativa gate silencioso do clsconta.mLeDados linha 895: `If Empty(lcGrupo) And (ThisForm.pcEscolha <> 'PROCURAR') / = MessageBox('Grupo Invalido.', 0+48, 'Atencao!!!') / Return .f. / EndIf`), chama mLeDados, restaura pcEscolha. Ref canonico: `FormCliente.prg:1993-2054` (ValidarPreAcao com textbox como fonte unica) + `FormCliente.prg:2054-2088` (ChamarMLeDadosSeguro wrapper). Aplica-se a TODOS forms com filtros obrigatorios (Cadastros CRUD + Operacionais wrapper clsconta/similar). Auto-fix: CorretorAutomatico Pattern #174 WARNING-only (detecta `ValidarPreAcao` com bloco `IF EMPTY(loc_c<X>) / loc_c<X> = ALLTRIM(THIS.this_c<X>) / ENDIF` fallback silencioso; e chamada `THIS.cnt_4c_Conta.mLeDados(...)` fora de `ChamarMLeDadosSeguro`). Complementa Pattern #173. Bug em FormCliente 2026-08-25 (Erro136) — user limpa Grupo, clica Incluir, form prossegue sem msg gravando registro no grupo antigo em memoria.
- **TextBox S/N (Sim/Nao) `Format="M"` + `InputMask="S,N, "` OBRIGATORIOS — sem eles TextBox aceita qualquer char**: TextBox com `MaxLength=1` cuja label vizinha eh `(S/N)` (representa coluna char(1) semantica Sim/Nao) DEVE ter `Format = "M"` + `InputMask = "S,N, "` (lista fixa canonica VFP9). Sem esse par, campo aceita qualquer caractere (X/A/7/etc) e usuario grava valor invalido. `Format="M"` transforma TextBox em "multiple choice" que aceita apenas chars que iniciam algum item do InputMask csv-list — `S`/`N`/space passam, resto eh silenciosamente descartado. Legado sempre gera esse par (ex `sigcdcar_form_codigo_fonte.txt` `Get_senha`: `Format="M"` + `InputMask="S,N, "`). Migrador tende a gerar apenas `MaxLength=1` (limita tamanho, nao tipo). Auto-fix: CorretorAutomatico #175 detecta bloco `WITH ... TextBox / .MaxLength=1 / ... / ENDWITH` cuja Label irma seguinte tem `.Caption = "(S/N)"`, injeta `.Format = "M"` + `.InputMask = "S,N, "` antes do ENDWITH. Bug em FormCargo (Erro137 2026-09-01, task354 SigCdCar): 12 TextBoxes S/N aceitavam qualquer char (txt_4c_Nivels/Altcots/Limites/Cancitens/Libfpags/Libsdins/Libfpgs/Libopes/Libexprd/Fcomis/Libvmovdup/ConsSubn).
- **BO CRUD `Buscar()` — NUNCA `ZAP + APPEND FROM DBF()` em `cursor_4c_Dados` compartilhado — SEMPRE `USE IN + SQLEXEC direto`**: `cursor_4c_Dados` eh o cursor de listagem padrao COMPARTILHADO por 163+ BOs CRUD (todos que herdam de BusinessBase e populam Page1.Grid). Anti-padrao gerado pelo migrador: `IF USED("cursor_4c_Dados") / SQLEXEC(...,"cursor_4c_DadosTmp") / SELECT cursor_4c_Dados / ZAP / APPEND FROM DBF("cursor_4c_DadosTmp") / USE IN cursor_4c_DadosTmp / ELSE / SQLEXEC(...,"cursor_4c_Dados") / ENDIF` — `ZAP` apaga registros mas PRESERVA a estrutura (colunas + constraints NOT NULL) que outro BO deixou no cursor. **Sequencia toxica**: user abre FormCargo (`CargoBO.Buscar` cria `cursor_4c_Dados` com estrutura `ccargs char(10) NOT NULL, dcargs char(20)` — herda NOT NULL da PK de SigCdCrg) -> user abre FormCor (`CorBO.Buscar` faz SELECT `cods, descs, varias, Pesos` que NAO tem coluna `ccargs`) -> APPEND tenta inserir com `ccargs=NULL` -> SQL Server erro **"Field CCARGS does not accept null values"** no CATCH de `Buscar()`. Qualquer par de forms CRUD com esquemas PK diferentes eh vulneravel. **FIX CANONICO** (`CargoBO.Buscar:89`): substituir bloco todo por `IF USED("cursor_4c_Dados") / USE IN cursor_4c_Dados / ENDIF / loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") / IF loc_nResultado >= 0 / loc_lSucesso = .T. / ELSE / MostrarErro("Erro ao buscar..." + CHR(13) + CapturarErroSQL(), "Erro SQL") / ENDIF`. Form CRUD ja rebinda `Grid.RecordSource = "cursor_4c_Dados"` + `Column.ControlSource` + `Header.Caption` em `CarregarLista()` APOS `Buscar()` (padrao Problema 48) — nao ha regressao de UX. **NAO usar ZAP+APPEND** achando que preserva binding do Grid — SQLEXEC "cursor_4c_Dados" tambem recria e re-binda transparentemente quando CarregarLista roda logo depois. Auto-fix: CorretorAutomatico #176 detecta bloco IF-ELSE-ZAP-APPEND canonico e substitui por USE IN+SQLEXEC direto. Bug em CorBO.Buscar (Erro138 2026-09-01, ao abrir FormCor apos FormCargo). Escopo: 163+ BOs CRUD afetados — sweep retroativo aplicado.
- **BO property name DEVE bater EXATAMENTE com uso no Form (`FormParaBO`/`BOParaForm`) — naming mismatch causa `Property THIS_<X> is not found` + GRAVACAO SILENCIOSAMENTE ERRADA**: Migrador as vezes nomeia property do BO com naming SEMANTICO (`this_nSubclaEncerr` — significado do campo) enquanto o Form referencia com naming DB (`this_nChkSubs` — espelho da coluna `nchksubs`). Ao clicar Salvar/Alterar em form CRUD: `FormParaBO` executa `THIS.this_oBusinessObject.this_nChkSubs = IIF(opt.Value = 1, 1, 0)` → VFP9 estora **"Property THIS_NCHKSUBS is not found"** em MessageBox → user clica OK/Continuar → **CATCH nao interrompe o fluxo**, INSERT/UPDATE roda com property DEFAULT (`this_nSubclaEncerr = 0` nunca atribuida) → banco recebe SEMPRE 0/valor inicial. Sintoma pior que o erro visivel: user pensa "erro mas gravou", nao percebe que campos S/N/OptionGroup gravaram VALOR ERRADO permanentemente. **REGRA UNIVERSAL**: nomes de property no BO DEVEM ser IDENTICOS aos nomes usados em `FormParaBO`/`BOParaForm`/`CarregarDoCursor`/`Validar<X>` do Form. **PREFERIR NOME DB** (espelhar coluna `nchksubs` -> `this_nChkSubs`; `iclis` -> `this_cIclis`) para eliminar essa classe de mismatches — regra secundaria de CLAUDE.md Property Naming Sufixo 's'. Se herdar codigo com naming semantico, refactor SEMPRE em pares (form + BO simultaneos) via `replace_all` no PS/VSCode do nome antigo pro novo. Auto-fix: CorretorAutomatico #177 WARNING-only — grep no `Form*.prg` por `THIS\.this_oBusinessObject\.this_(\w+)` extrai nomes; grep no BO correspondente + heranca (BusinessBase/RelatorioBase) por `^\s*this_\1\s*=` declaracao (fora de PROC/FUNC — depth counter); se ausente, emite `WARN-177-BO-PROP-NAO-DECLARADA` com linha+nome+BO. Nao muta pois renomear demanda contexto (decisao DB-vs-semantico + refactor em ambos arquivos). Bug em `FormDepartamento` -> `DepartamentoBO` (Erro139 2026-09-01, Salvar cadastro de departamento — property `this_nChkSubs` usada no form mas BO declarava `this_nSubclaEncerr`; MessageBox aparecia mas save prosseguia gravando 0). Escopo: qualquer BO CRUD com mapeamento OptionGroup/CheckBox/TextBox custom — sweep detecta.
- **`cmd_4c_Confirmar.Enabled = loc_lEdit*` em `HabilitarCampos(par_lHabilitar)` DESABILITA Confirmar em modo EXCLUIR — SEMPRE adicionar `OR (THIS.this_cModoAtual = "EXCLUIR")`**: Em Form CRUD, `BtnExcluirClick` chama `HabilitarCampos(.F.)` para tornar campos READONLY (user apenas VE o registro antes de confirmar exclusao). Mas o mesmo metodo tambem faz `cmd_4c_Confirmar.Enabled = loc_lEdit` (ou variantes `loc_lEditar`/`loc_lEditando`/`loc_lEdita`) — quando `par_lHabilitar=.F.`, `loc_lEdit*=.F.` e **Confirmar fica DISABLED**. User ve a tela de exclusao com registro carregado, botao Confirmar CINZA sem imagem (icone `cadastro_confirmar_60.jpg` nao renderiza em `.Enabled=.F.`), IMPOSSIVEL confirmar a exclusao. Semantica correta: em EXCLUIR, campos ficam readonly (loc_lEdit=.F.) MAS Confirmar precisa estar habilitado (user tem que clicar para confirmar a acao). **FIX CANONICO**: `cmd_4c_Confirmar.Enabled = loc_lEdit OR (THIS.this_cModoAtual = "EXCLUIR")` — Confirmar habilitado em INCLUIR/ALTERAR (loc_lEdit=.T.) E em EXCLUIR (loc_lEdit=.F. mas THIS.this_cModoAtual="EXCLUIR"). Regra vale para TODAS as variantes de flag: `loc_lEdit`/`loc_lEditar`/`loc_lEditando`/`loc_lEdita` — auto-fix Pattern #178 detecta regex `cmd_4c_Confirmar\.Enabled\s*=\s*loc_lEdit\w*\s*$` e injeta o OR. Idempotente (skip se linha ja contem "EXCLUIR"). Bug em FormDepartamento (Erro140 2026-09-01, clicar Excluir apos selecionar registro no grid — tela abre com dados carregados mas Confirmar disabled). Escopo: ~34 forms CRUD com o mesmo padrao — sweep retroativo aplicado.
- **Form CRUD `Width < 1000` com `cnt_4c_Saida.Left=917` TRUNCA botoes Encerrar/ultimos**: Padrao canonico CLAUDE.md #10 fixa `cnt_4c_Saida.Left=917 + Width=90` (Encerrar termina em 1007). Se `Form.Width < 1000`, o container Saida transborda e Encerrar fica INVISIVEL; alem disso, `cnt_4c_Botoes.Left=542 + Width=385` termina em 927, ultimos botoes (Excluir Left=230/absoluto 772, Buscar Left=305/absoluto 847) tambem podem ser cortados se Width menor. **REGRA UNIVERSAL**: Form CRUD (`AS FormBase`) DEVE ter `Width = 1000` — canonico universal. Se SCX legado tinha Width menor (ex: 812), IGNORAR e usar 1000. Auto-fix: CorretorAutomatico #179 WARNING-only (nao muta pois alguns forms pequenos podem ter layout intencional — decisao humana caso a caso). Detector: guard `DEFINE CLASS \w+ AS FormBase` + presenca de `\.Left = 917` (assinatura do cnt_4c_Saida canonico) + `Width = N` no bloco de propriedades da classe com N<1000. Sweep 2026-09-01: 6 candidatos (FormCCJ/FormCrt/FormGcp/FormMoe/FormRop/FormSigPrCtc). Bug em FormSrv Width=812 (Erro141 2026-09-01, botoes Excluir e Encerrar cortados no menu Cadastros->Servicos).
- **Grid `RecordSource=""+re-set` em `CarregarLista` RESETA `Column.Width` e `Header1.Caption` — SEMPRE re-configurar APOS ControlSource (Problema 48 CLAUDE.md)**: Em Form CRUD, `CarregarLista` faz `Grid.RecordSource="" / ColumnCount=N / RecordSource="cursor_x" / Column1.ControlSource="..." / Column2.ControlSource="..."` para trocar cursor. Esse padrao RESETA silenciosamente `Column.Width` (volta para default ~64) e `Header1.Caption` (volta para "Header1"). Se `ConfigurarPaginaLista` (setup inicial) definiu Width/Caption dessas colunas, elas SE PERDEM ao chamar `CarregarLista` — grid aparece com colunas "Header1"/"Header1" com widths quadrados. **FIX CANONICO**: apos o ultimo `ControlSource=`, adicionar re-configuracao explicita `Grid.ColumnN.Width = <valor_original>` e `Grid.ColumnN.Header1.Caption = "<caption_original>"` para cada coluna. Valores originais estao no bloco `ConfigurarPaginaLista` (mesmo grid path). Auto-fix: CorretorAutomatico #180 auto-mutate — extrai valores originais do bloco de configuracao inicial e injeta apos ControlSource. Fallback WARNING se valores originais nao localizados. Idempotente (skip se ja tem `Column.Width=` ou `Header1.Caption=` no mesmo bloco). Bug em FormSrv 2 grids (Erro141 2026-09-01, cadastro Servicos + grid interno Produtos mostrando "Header1"). Complementa Problema 48 canonico ja documentado.
- **`pgf_4c_Paginas.Width` hardcoded < `Form.Width` TRUNCA botoes na Page1 mesmo com Form.Width canonico**: PageFrame `pgf_4c_Paginas` (root do layout Page1/Page2) DEVE ter Width IGUAL ao `Form.Width` para exibir toda a area util. Se `PageFrame.Width = 815` mas `Form.Width = 1000`, o PageFrame ocupa apenas 815px — botoes/containers com Left > 815 (ex: `cnt_4c_Saida.Left=917`) ficam CORTADOS pela borda do PageFrame, mesmo estando dentro dos 1000px do Form. Fix `Form.Width=1000` (Pattern #179) sozinho NAO resolve — precisa tambem ajustar PageFrame.Width. **FIX CANONICO**: `THIS.pgf_4c_Paginas.Width = THIS.Width` (dinamico, sempre segue Form.Width) — mais robusto que hardcoded. Alternativa: valor literal >=1000 (canonico CRUD). NUNCA hardcoded < 1000 quando Form.Width=1000. Auto-fix: CorretorAutomatico #181 detecta bloco `WITH THIS.pgf_4c_Paginas` (ou variantes com var local) + `.Width = N` onde N eh literal numerico < 1000, substitui por `.Width = THIS.Width`. Guard: apenas em Form CRUD (`AS FormBase`). Idempotente (skip `.Width = THIS.Width`; skip se N >= 1000). Bug em FormSrv (Erro142 2026-09-01, PageFrame.Width=815 truncava botoes apos fix inicial Form.Width=812->1000 nao resolver). Meta-licao: quando Form.Width eh alterado, TAMBEM ajustar PageFrame.Width simultaneamente — ambos formam um par sincronizado.
- **Grid com coluna EDITAVEL (CheckBox/ComboBox) exige cursor READWRITE - `SQLEXEC()` cria cursor SOMENTE-LEITURA**: cursor de SQL pass-through nasce read-only no VFP; uma coluna com `AddObject("chk_4c_X", "CheckBox")` + `CurrentControl` + `Sparse=.F.` RENDERIZA o controle em TODAS as linhas mas a celula NUNCA entra em edicao - clicar no CheckBox nao faz nada, e o sintoma parece bug de `Enabled`/`ReadOnly` (que estao corretos), fazendo perder horas no lugar errado. SEMPRE que o Grid tiver coluna editavel, no BO usar alias TEMPORARIO + conversao: `SQLEXEC(gnConnHandle, loc_cSQL, "<alias>Tmp")` + `IF USED("<alias>") / USE IN <alias> / ENDIF` + `SELECT * FROM <alias>Tmp INTO CURSOR <alias> READWRITE` + `IF USED("<alias>Tmp") / USE IN <alias>Tmp / ENDIF` (template canonico `CCJBO.prg:214`). COROLARIO: como o cursor passa a ser fechado/recriado, o Grid perde o binding e reatribuir `RecordSource` reseta tambem `Column.Sparse`/`Column.CurrentControl`/`Column.ReadOnly` (alem de `Column.Width`/`Header1.Caption` - Problema 48), entao nos metodos `Carregar*` restaurar `.Sparse = .F.` + `.CurrentControl = "<controle>"` APOS o rebind (restauracao dentro do `IF !PEMSTATUS(...)` defensivo NAO basta - so roda quando o controle foi destruido), e chamar `Habilitar*Grid(<modo editavel>)` DEPOIS de todas as cargas (`HabilitarCampos(.T.)` em `BtnIncluirClick` roda ANTES do rebind e eh descartado). Ref: Erro145-v2 (2026-09-04, Formacg/acgBO) - Pattern #184 WARNING-only
- **CheckBox em coluna de Grid NAO alterna pelo binding nativo - exige os 4 handlers Click/MouseDown/MouseUp/KeyPress com NODEFAULT**: `Column.AddObject("chk_4c_X","CheckBox")` + `CurrentControl` + `ControlSource` + `Sparse=.F.` fazem o CheckBox RENDERIZAR em todas as linhas e ate RECEBER FOCO, mas clicar ou teclar Espaco/Enter NAO muda o valor - e o sintoma parece bug de `Enabled`/`Column.ReadOnly` (que estao corretos). Os forms legado Fortyus SUPRIMEM o toggle padrao e alternam o valor por codigo; migrar so o `When` (o gate de modo) deixa o checkbox inerte. Template canonico obrigatorio, um bloco por checkbox de grid: `PROCEDURE Chk<X>KeyPress(par_nKeyCode, par_nShiftAltCtrl) / IF INLIST(par_nKeyCode, 13, 32) AND INLIST(THIS.this_cModoAtual,"INCLUIR","ALTERAR") AND USED("<cursor>") AND !EOF("<cursor>") / REPLACE <cursor>.<campo> WITH IIF(<cursor>.<campo> = 0, 1, 0) / THIS.<path>.<grid>.Refresh() / NODEFAULT / ENDIF / ENDPROC` mais `Chk<X>MouseUp` (`THIS.Chk<X>KeyPress(13, 0)` + `NODEFAULT`), `Chk<X>MouseDown` (`NODEFAULT`) e `Chk<X>Click` (`NODEFAULT`) - os dois ultimos existem para SUPRIMIR o toggle nativo e evitar alternancia dupla. Registrar os 4 com `BINDEVENT(<chk>, "KeyPress"|"MouseUp"|"MouseDown"|"Click", THIS, "<handler>")` em TODO ponto que cria o controle (o `ConfigurarAba*` E o bloco defensivo `IF !PEMSTATUS(...)` dos `Carregar*`). O gate de modo vai DENTRO do KeyPress, nao so no `When`: BINDEVENT descarta o retorno do delegate, entao um `When` ligado por BINDEVENT nao bloqueia edicao. PRE-REQUISITO: o cursor precisa ser READWRITE, senao o `REPLACE` estoura (ver regra do cursor de SQLEXEC). Ref canonico: `Formsigredtv.prg:963-1585` (grd_4c_Emps) e `Formacg.prg` pos-Erro146; ref legado: `SIGCDACG.Pagina.Dados.Pagina.Acesso.grdAcesso.Column3.Check1` (Click=NoDefault, MouseDown=NoDefault, MouseUp=This.KeyPress(13,0)+NoDefault, KeyPress=Replace+Refresh+NoDefault). Ref: Erro146 (2026-09-04, Formacg) - Pattern #185 WARNING-only
- **`AddObject` e `BINDEVENT` em coluna de Grid: nome do controle tem de bater com o alvo REAL — tres defeitos que quebram o Init**: (A) **NUNCA dois `AddObject("<X>", ...)` com o MESMO nome no MESMO alvo** — VFP dispara `Object <X> is already defined` e o `Init` do form morre; se duas copias configuram propriedades diferentes, consolidar num bloco so (achado: `grd_4c_Fases.Column4` com dois `AddObject("Check1","CheckBox")` identicos dentro do mesmo `WITH`). (B) **NUNCA deixar controle adicionado e nao usado** — se a coluna faz `AddObject("check12")` + `AddObject("check13")` e o `CurrentControl` eh `"check13"`, o `check12` eh objeto morto: remover, ou corrigir o `CurrentControl` se a intencao era ele. (C) **`BINDEVENT(<grid>.ColumnN.<M>, ...)` so vale se `<M>` for `Text1`/`Header1` (nativos da Column) ou tiver sido `AddObject`'d NAQUELA coluna** — referencia de objeto invalida estoura no `Init` E deixa o controle sem handler nenhum; a causa tipica eh copiar o bloco de `BINDEVENT` de outro grid sem trocar o nome do controle (achado: os 4 `BINDEVENT` de `grd_4c_Emps.Column1` apontavam para `Check1`, que so existe em `grd_4c_Opers.Column1` — o CheckBox de Empresas ficou sem toggle e ninguem percebeu porque o erro some no CATCH do `InicializarForm`). REGRA PRATICA: ao copiar um bloco de configuracao de grid, trocar TRES coisas juntas — o caminho do grid, o nome do controle no `AddObject`/`CurrentControl` e o alvo de cada `BINDEVENT`. Excecao legitima: o re-`AddObject` dentro de `IF !PEMSTATUS(...)` nos `Carregar*` eh defensivo (Pattern #183) e NAO conta como duplicata. Ref: Erro146 / sweep Pattern #185 (2026-09-04, FormLin/FormMda/Formpgr/Formsigredtv) - Pattern #186 WARNING-only

- **IIF() exige condicao LOGICA - IIF(chk.Value, 1, 0) dispara erro 11**: CheckBox.Value eh NUMERICO (0/1) nos forms gerados, e IIF() so aceita LOGICO no 1o argumento. Passar numero estoura "Function argument value, type, or count is invalid." (VFP9 erro 11) - e em FormParaBO o erro cai no CATCH, aborta o metodo no meio e o Salvar segue gravando registro PARCIAL (bug silencioso, pior que a caixa de erro). SEMPRE comparar explicitamente: IIF(chk_4c_X.Value = 1, 1, 0). Vale para qualquer expressao numerica usada como condicao (IIF/IF/DO WHILE). Corolario: FormParaBO deve ser FUNCTION retornando .T./.F. e BtnSalvarClick deve ABORTAR a gravacao quando ela falhar. Auto-fix: CorretorAutomatico #187. Bug observado em Formcfo.prg (2026-09-08, Erro147).
- **ControlSource NUMERICO no SCX = indice 1-based (NUNCA booleano 0/1)**: ComboBox/OptionGroup do legado com ControlSource apontando para coluna NUMERICA grava o INDICE do item selecionado (1 = 1o item, 2 = 2o item, 0 = nada selecionado), NUNCA 0/1. Migrar como BO.this_nX = cbo.ListIndex / BO.this_nX = opt.Value, e o inverso cbo.ListIndex = IIF(BETWEEN(val,1,N), val, 0) / opt.Value = IIF(BETWEEN(val,1,N), val, 0). PROIBIDO inventar RowSource placeholder ("0,1") - copiar a lista EXATA do SCX ("Sim,Nao", "Nao,Base,Preco", ...). ComboBox com ColumnCount=2 + BoundColumn=2 grava a 2a coluna do RowSource (copiar ColumnCount/ColumnWidths/BoundColumn). ComboBox com ControlSource CHAR grava a INICIAL da opcao: LEFT(UPPER(ALLTRIM(cbo.Value)), 1), igual ao "Replace campo with padr(upper(alltrim(cbo.value)),1)" do legado. Conferir a distribuicao REAL da coluna no banco antes de assumir 0/1. WARNING: CorretorAutomatico #188. Bug observado em Formcfo.prg (2026-09-08, Erro147): 7 combos e 12 OptionGroups gravavam valores errados silenciosamente.
- **NUNCA reportar sucesso quando nao houve o que gravar**: metodo de gravacao que percorre um cursor de detalhe (grade de itens/ocorrencias/parcelas) e nao encontra nenhuma linha valida NAO pode retornar .T. em modo de INCLUSAO, e o form NAO pode exibir MsgInfo("... salvo com sucesso") nesse caso â€” o usuario ve a mensagem, volta para a lista e o registro nao existe (bug pior que erro visivel). No form, ANTES de chamar o BO: contar as linhas do cursor com a coluna-chave preenchida e, se zero em modo INSERIR/INCLUIR, MsgAviso("Informe ao menos um(a) <item> antes de gravar.") + SetFocus na grade + RETURN. Em ALTERAR a lista vazia continua valida quando o legado apaga-e-reinsere (significa remover todos os itens). Mesma familia do Erro147 (metodo de transferencia que falha e deixa o Salvar seguir). WARNING: CorretorAutomatico #189. Bug observado em FormSIGPRLNC.prg (2026-09-08, Erro148).
- **Grid da lista (Page1) tem de espelhar as colunas do legado, nao a grade de detalhe**: no SCX/Init legado as colunas da lista vem de `.AddCursor(...)` + `.pfSqlTabela(1).pColuna(<campo>, ..., <header>, <largura>, ...)` â€” copiar campo, caption e largura EXATOS de cada pColuna. Erro tipico: o migrador copia os captions da grade de detalhe da Page2 (ex.: "Ocorrencia"/"Descricao") para a lista de registros e ainda perde colunas. PROIBIDO tambem trocar a granularidade da lista: se o legado faz `Select * From <tabela>` (uma linha por registro), NAO usar `SELECT DISTINCT` de um subconjunto â€” alem de esconder colunas, isso muda a semantica de Alterar/Excluir (a linha selecionada deixa de ter chave primaria e o Excluir vira exclusao em massa por chave secundaria, apagando o que o usuario nao pediu). Levar a PK (ex.: cidchaves) para o cursor da lista e excluir por ela. Bug observado em FormSIGPRLNC.prg (2026-09-08, Erro148).
- **INSERT do BO tem de cobrir TODAS as colunas NOT NULL sem DEFAULT**: o legado grava o registro inteiro (AddCursor sem query = SELECT * + TABLEUPDATE), entao colunas que nao aparecem na tela continuam sendo gravadas com o valor do registro em branco. Se o INSERT do BO omitir uma coluna NOT NULL, o SQL Server recusa a inclusao inteira com "Nao eh possivel inserir o valor NULL na coluna <col> ... a coluna nao permite nulos. Falha em INSERT." e o cadastro fica sem conseguir incluir. Regras de preenchimento: (a) `cidchaves`/`pkchaves` (chave unica do Fortyus) = `EscaparSQL(fUniqueIds())` â€” NUNCA string vazia, senao o segundo registro colide no indice unico; (b) coluna com property no BO = usar a property; (c) sem property = default do tipo (`EscaparSQL("")` para char, `FormatarNumeroSQL(0, <decimais>)` para numeric, `0` para bit, data sentinela para datetime NOT NULL); (d) `usuars`/`usualts` = `gc_4c_UsuarioLogado`. ATENCAO a colunas GEMEAS de nome parecido, que existem juntas e sao ambas NOT NULL: `tipo`+`tipos` (SigCdRom), `prioridade`+`prioridades` (SigCdClc), `imprs`+`iimprs` (SigOpPic), `cidatrabs`+`cidtrabs` (SigCdCli) â€” incluir a que falta, nao trocar a existente. MAS ANTES DE INCLUIR, CONFERIR se a grafia que JA esta no INSERT existe na tabela: se NAO existe, nao sao gemeas - a migracao ERROU A GRAFIA e o conserto eh RENOMEAR, nao acrescentar. Suspeitar de metatese (`ems`/`ens`, `oas`/`aos`, `tipo`/`tip`): gemeas de verdade diferem por um sufixo inteiro, nao por letras trocadas de lugar. Erro de grafia nunca fica so no INSERT - esta tambem no UPDATE e na leitura do cursor em `CarregarDoCursor`; como `CarregarPorCodigo` usa `SELECT *`, o cursor traz a grafia REAL e a leitura estoura em RUNTIME com `Variable X is not found` (compila limpo, quebra Alterar/Visualizar). Renomear no arquivo INTEIRO, case-sensitive e com limite de palavra, preservando os nomes das properties. Observado em gpdBO/SigCdGrp, onde os SEIS nomes estavam errados (2026-09-14, Erro159). Conferencia em lote: `automation\VerificarInsertNotNull.ps1` (cruza os INSERT dos BOs com INFORMATION_SCHEMA). COMO GARANTIR (a regra sozinha JA FALHOU uma vez): antes de escrever o INSERT, extrair do schema a lista de colunas NOT NULL sem DEFAULT da tabela destino e conferir UMA A UMA contra a lista do INSERT. NAO basta ler o dump do legado - as colunas que o legado nunca cita (existiam so no registro em branco do AddCursor) sao invisiveis la e sao justamente as que faltam: em SigFiChc foram `nsenha` e `versao`, alem da PK `cidchaves`. Conferencia automatica na etapa 05f (`Validate-InsertNotNull` do ValidadorSQLSchema.ps1), que BLOQUEIA a migracao se faltar coluna. Bug observado em AliBO/SigCdAli.reincids (2026-09-08, Erro151) e em mais 20 sites no sweep; reincidiu em CecBO/SigFiChc (2026-09-14, Erro159).
- **Label/CheckBox/OptionButton de DADOS nunca leva ForeColor branco - o canonico eh RGB(90, 90, 90)**: as Pages do PageFrame recebem `.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"` (textura CLARA) que cobre o `.BackColor = RGB(100,100,100)`, entao qualquer `.ForeColor = RGB(255, 255, 255)` em controle criado DIRETO na pagina (ou dentro de container com `BackStyle = 0`, que eh transparente, ou com BackColor claro) fica INVISIVEL - o usuario clica em Incluir, abre a aba Dados e ve as caixas de texto sem nenhuma legenda. Quando o objeto do SCX legado NAO declara ForeColor (classe `say` do Framework), usar RGB(90, 90, 90); quando declara, copiar o valor EXATO (36,84,155 nos titulos de secao em Verdana, 255,0,0 nas notas de rodape). Ao procurar o objeto no dump do legado, conferir os DOIS nomes: `Say<N>` do legado costuma virar `lbl_4c_Label<N>` no migrado. EXCECOES legitimas, que continuam brancas: `lbl_4c_Titulo`/`lbl_4c_LblTitulo` da faixa do cabecalho, label dentro de container OPACO escuro (`BackStyle = 1` + BackColor RGB(100,100,100)/RGB(90,90,90)) e as propriedades `HighlightForeColor`/`SelectedForeColor`/`SelectedItemForeColor` (texto da linha selecionada, que fica sobre realce escuro). WARNING: CorretorAutomatico #191. Bug observado em FormARV.prg (2026-09-09, Erro153) e em mais 22 forms no sweep (217 sites).
- **NUNCA chamar helper que voce nao definiu - em VFP9 o erro so aparece em RUNTIME**: chamada "nua" a um nome que nao existe como funcao global compila sem reclamar; o VFP resolve nome desconhecido procurando `<nome>.prg` em disco e, quando o usuario aciona o botao, estoura `File 'nomedafuncao.prg' does not exist.` Antes de usar um helper, conferir que ele EXISTE em `projeto\app\utils\functions.prg` (`TratarNulo`, `EscaparSQL`, `FormatarNumeroSQL`, `FormatarDataSQL`, `ConverterParaLogico`, `MsgErro`, `MsgAviso`, `MsgInfo`, `MsgConfirma`, ...). Precisando de um helper novo, DEFINIR em functions.prg no mesmo padrao - PROIBIDO so chamar e seguir em frente. Corolario (CLAUDE.md regra #8): metodo da propria classe SEMPRE com `THIS.` - sem o prefixo cai no mesmo erro de arquivo inexistente. ATENCAO ao helper que le coluna do banco: coluna `bit` do SQL Server chega ao VFP ora como Logico (.T./.F.) ora como Numerico (0/1) conforme o driver, e coluna `numeric(1,0)` sempre como Numerico - testar `VARTYPE` antes de comparar, porque comparar Logico com 1 estoura "Operator/operand type mismatch". Auditoria: `automation\VerificarFuncoesNaoDefinidas.ps1`. WARNING: CorretorAutomatico #192. Bug observado em BchBO/BlqBO/DCCBO/OETBO/sigpdmp6BO/sigpres2BO (2026-09-09, Erro154): `ConverterParaLogico` foi inventado pelo migrador e chamado em 17 sites sem existir em lugar nenhum.
- **`docs\schema.sql` eh UTF-16LE - grep/awk/findstr devolvem ZERO SILENCIOSAMENTE**: essas ferramentas tratam o arquivo como binario e nao acham nada, fazendo tabela e coluna EXISTENTES parecerem inexistentes. A "correcao" natural a partir desse diagnostico falso - apontar o BO para outra tabela - grava dado no lugar errado e viola o PILAR 2. Ler sempre com `Get-Content -Raw` (PowerShell respeita o BOM) ou usar `automation\VerificarTabelasInexistentes.ps1`, que ja trata o encoding e ainda aborta se ler menos de 100 tabelas (piso de sanidade contra leitura falha). Tambem NAO usar `tasks\<task>\schema_ascii.sql` como fonte de verdade: eh snapshot congelado na epoca daquela task (task351 tem 674 tabelas contra 682 do canonico) e faz tabela nova parecer ausente. Corolario para o erro de runtime `Nome de objeto 'SigCdXxx' invalido` (vem do SQL Server, nao do VFP, e nao quebra a compilacao): (1) conferir a tabela no schema canonico com o encoding correto; (2) conferir o nome no CODIGO LEGADO em `tasks\<task>\*_form_codigo_fonte.txt`. Se o legado usa o MESMO nome e a tabela esta no schema, o codigo migrado esta FIEL e a divergencia eh de BANCO/ambiente (a base conectada nao bate com o dump) - NAO eh bug de migracao e NAO se conserta no codigo. WARNING: CorretorAutomatico #193. Bug observado em FormBlq/SigCdBlq (2026-09-09, Erro155).
- **`EVALUATE()` NAO atribui - ele avalia e devolve o valor**: `EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = ''")` NAO limpa nada. O VFP monta a string, enxerga uma COMPARACAO (`obj.prop.Value = ''`), avalia como `.T.`/`.F.` e joga o resultado fora - sem erro, sem aviso, o campo simplesmente nunca muda. Comprovado no VFP9: valor antes `[ABC]`, depois do EVALUATE `[ABC]`, depois do STORE `[]`. Para atribuir a um nome montado em tempo de execucao, usar `STORE <valor> TO (<expressao que resulta no nome>)`: `STORE "" TO ("loc_oCnt." + par_cTxtDesc + ".Value")`. `EVALUATE` continua CERTO para LEITURA (`loc_c = EVALUATE("loc_oCnt." + par_cTxtCon + ".Value")`, `IF EVALUATE("VARTYPE(loc_oCnt." + par_cX + ")") = "O"`) - o defeito eh so quando o sinal de igual esta DENTRO da string montada, que eh o unico caso em que a intencao era atribuir. Auto-fix: CorretorAutomatico #194 (forma segura: valor vazio ou identificador simples; valor com concatenacao/funcao vira WARNING). Bug observado em Formlch.prg (2026-09-09, Erro155): 4 sites, e o pior calava a descricao do GRUPO nos 7 containers do form desde a migracao, sem ninguem perceber.
- **A faixa do cabecalho tem de ser o PRIMEIRO `AddObject` da pagina Dados - senao ela COBRE os botoes**: os containers de botao (`cnt_4c_Salva`/`cnt_4c_BotoesAcao`/`cnt_4c_Saida`) ficam em `Top = 29..33`, ou seja DENTRO da area da faixa (`Top = 29..31`, `Height = 80`), e so aparecem se forem criados DEPOIS dela. Com a ordem invertida o usuario abre a aba Dados e ve o cabecalho comendo Confirmar/Encerrar - sobra so a lasca dos ~10px que passam da altura da faixa. Vale so para a pagina Dados: na Lista o migrador costuma acertar a ordem. EXCECAO: pagina com PageFrame/Container interno que cobre tudo (`Formgpd.pgf_4c_Divisoes`) - ali a faixa vem DEPOIS de proposito e a barra de botoes eh trazida para frente com `ZOrder(0)`; a presenca do `ZOrder(0)` eh o que distingue esse caso de um bug. CORRELATO: conferir que os labels da faixa nao ficaram PELADOS - `.AddObject("lbl_4c_Sombra", "Label")` sem nenhuma propriedade em seguida faz o titulo sair como label default minusculo, preto sobre cinza, mesmo com o `Caption` setado no `Init` (injecao do Erro152 que ficou pela metade no FormCat). Auto-fix: CorretorAutomatico #195. Bug observado em FormCAD e FormCat (2026-09-09, Erro156).
- **A faixa cinza do cabecalho vai nas DUAS paginas (Lista E Dados)**: o SCX legado (frmcadastro) tem o cntSombra so em Pagina.Lista, mas o padrao adotado no sistema novo eh repetir a faixa na pagina Dados - decisao do time (Erro152), que PREVALECE sobre o PILAR 1 neste ponto. Bloco canonico em Formcfo.prg ConfigurarPaginaDados: `cnt_4c_Cabecalho` Container com Top=29, Left=0, Width=THIS.Width, Height=80, BackColor=RGB(100,100,100), BorderWidth=0, SpecialEffect=0, contendo `lbl_4c_Sombra` (Top=15, ForeColor preto) e `lbl_4c_Titulo` (Top=18, ForeColor branco), ambos Tahoma 16 bold, BackStyle=0, Caption=THIS.Caption. O cabecalho tem de ser o PRIMEIRO AddObject da pagina: assim os containers de botao (cnt_4c_Salva/cnt_4c_BotoesAcao/cnt_4c_Saida, que ficam em Top=29..33) sao criados depois e desenham POR CIMA da faixa, como no Formcfo. Consequencia de layout: nenhum controle de DADOS pode ficar com Top < 109 (29+80) na pagina Dados - ao converter os Tops do SCX, empurrar o conteudo para baixo da faixa. Conferencia: `automation\DiagnosticoCabecalhoPaginas.ps1`. WARNING: CorretorAutomatico #190.
- **Cabecalho: detectar por BackColor+altura, NUNCA pelo nome do container**: o mesmo cabecalho aparece como `cnt_4c_Cabecalho` na maioria dos forms e como `cnt_4c_Sombra` (nome do legado, cntSombra) em outros - procurar so pelo nome faz o form parecer "sem cabecalho" e leva a injetar uma faixa DUPLICADA por cima da existente (aconteceu em FormFte/FormUfs/Formpgr no sweep do Erro152). Identificar o container pelo par BackColor=RGB(100,100,100) + Height>=60 criado direto na pagina.
- **TTOD() so aceita DATETIME - passar um DATE dispara erro 11 em RUNTIME**: "Function argument value, type, or count is invalid." O .prg compila limpo e o usuario so descobre ao acionar o botao. A armadilha eh que o MESMO campo chega com tipos DIFERENTES conforme o caminho: TextBox criado com .Value = {} guarda DATE (modo INCLUIR), coluna datetime do SQL Server via SQLEXEC chega como DATETIME (modo ALTERAR) e cursor VFP com coluna declarada D guarda DATE - por isso o codigo funciona em ALTERAR e explode em INCLUIR. Para qualquer valor que passou por form, propriedade de BO, parametro ou variavel local, usar ConverterParaData(x) de utils\functions.prg, que normaliza DATE/DATETIME/CHAR para DATE (com DATETIME o resultado eh identico ao TTOD). TTOD() direto so em coluna de cursor vinda de SQLEXEC, onde o tipo eh garantidamente datetime. Auto-fix: CorretorAutomatico #197. Bug observado em FormCCJ/CCJBO "Calculo de Juros" (2026-09-10, Erro157): o legado fazia Ttod(Get_DataBase.Value) e funcionava porque la o TextBox tinha ControlSource = crSigCdCcj.data_base (datetime); no migrado o TextBox nasce com {} e a tela nao gravava nada, so o messagebox de erro.
- **PROIBIDO reescrever a formula de calculo do legado - transcrever LITERALMENTE**: a expressao aritmetica, a ordem dos operadores, o SINAL, os divisores, o ROUND e os guards fazem parte da regra de negocio e nao se "simplificam". No Erro157 o legado calculava Round(lnValor - (lnValor*((lnDias/30)*(lnFator/100))),2) - juros DESCONTADOS, taxa MENSAL prorrateada - e o migrado escreveu loc_nValor + loc_nValor*(loc_nFator/100)*loc_nDias, juros SOMADOS com taxa DIARIA: a tela gravava valor errado sem exibir erro nenhum. Junto com a formula vao tres coisas que o migrador costuma jogar fora e que TAMBEM sao regra: (1) SINAL - o legado NAO zera diferenca de datas negativa, data anterior a base gera dias negativos de proposito; (2) GUARDS - Abs(lnDias)>999 avisa, limpa o campo e ABORTA, porque a coluna destino eh numeric(3,0) e nao cabe mais que isso, e sem o guard a gravacao estoura no SQL Server; (3) CRITERIO DOS TOTAIS - Count/Sum/Avg com Where Not Empty(Dias) exclui as linhas com zero, resultado diferente de somar tudo dentro do SCAN. Ao migrar metodo de calculo, transcrever a formula do dump legado linha a linha e so depois trocar os nomes das variaveis.
- **Column.AddObject NAO faz o controle aparecer - falta o Column.CurrentControl**: adicionar um OptionGroup/CheckBox/ComboBox/Spinner a uma Column de Grid cria o objeto, mas a coluna continua desenhando o Text1 dela. O controle existe, responde a PEMSTATUS e nunca aparece na tela: o usuario ve o valor cru numa caixa de texto e nao tem como marcar nada. Quem escolhe o controle que a coluna desenha eh `Column.CurrentControl` (default "Text1"), e ele tem de receber o NOME exato passado ao AddObject, logo depois de configurar o controle: `.Column3.CurrentControl = "opt_4c_Tipos"`. Vem sempre acompanhado de `.Column3.Sparse = .F.` (sem isso o controle so aparece na linha ativa) e de `.Column3.ReadOnly = .F.` quando o usuario precisa editar - lembrando que o ReadOnly da COLUNA tem de ser definido DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve. Auto-fix: CorretorAutomatico #198. Bug observado em FormCco.prg (2026-09-10, Erro158): o OptionGroup Inserir/Excluir/Nenhum da coluna Tipo foi criado na migracao e nunca apareceu, entao nao havia como cadastrar o motivo.
- **MaxLength do TextBox vem da LARGURA DA COLUNA no schema, NUNCA do Width em pixels**: o migrador tende a copiar o Width do controle para o MaxLength, o que produz numeros absurdos e silenciosos - em FormCco o campo Codigo ficou `.Width = 80` / `.MaxLength = 80` e a Descricao `.Width = 220` / `.MaxLength = 220`, quando as duas colunas sao `char(30)`. O usuario digita mais do que cabe, o SQL Server recusa o INSERT com "String or binary data would be truncated" e a tela nao grava. Conferir cada TextBox contra `docs\schema.sql` (lendo com `Get-Content -Raw`, que eh UTF-16) e usar a largura da coluna; o LEFT() do INSERT/UPDATE no BO tem de usar o MESMO numero. Sinal de alerta imediato: `MaxLength` igual ao `Width`. WARNING: CorretorAutomatico #199. Bug observado em FormCco.prg (2026-09-10, Erro158).
- **Gravacao que falha em SILENCIO ja esta resolvida no BusinessBase - NAO duplicar**: `BusinessBase.Salvar()`/`Excluir()` exibem a falha sozinhos (via `ExibirFalha()`) em todo caminho de validacao que antes devolvia `.F.` calado, e marcam `this_lErroExibido`. Portanto **o form NAO precisa de ELSE** em `IF <bo>.Salvar()`. Se voce escrever um ELSE assim mesmo, guarde com `IF !<bo>.this_lErroExibido` para a mensagem nao sair duas vezes. E a regra para as subclasses: `Inserir`/`Atualizar`/`ExecutarExclusao` continuam exibindo o proprio `MsgErro` com o texto do SQL Server - a base detecta isso e nao repete. Origem: Erro158 (2026-09-10) - o defeito estava em 249 sites de 107 forms, e foi corrigido num arquivo so.
- **Popular cursor de grade NAO repinta a grade, e as guardas de validacao do legado nao se descartam**: (1) depois de encher o cursor por SQL, repetir o que o legado faz - `GO TOP IN <cursor>` + `<grid>.Refresh()`; sem isso a grade fica visualmente vazia mesmo com o cursor cheio, e a tela parece nao ter dados. (2) As condicoes que envolvem a validacao no legado FAZEM PARTE da regra: em FormCco o legado so dispara a consulta de sobreposicao de faixa quando `(FaixaI + FaixaF) <> 0` - sem esse guard, faixa 0 a 0 casa com qualquer registro cujo intervalo contenha zero e a gravacao eh bloqueada indevidamente; o migrado tambem tinha perdido a checagem `FaixaI > FaixaF` inteira e rodava a validacao so no INCLUIR, quando o legado roda em INCLUIR **e** ALTERAR (`If pcEscolha = 'ALTERAR' Or pcEscolha = 'INSERIR'`). Transcrever a validacao do dump legado com as condicoes que a cercam, nao so o corpo. Bug observado em FormCco.prg (2026-09-10, Erro158).
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
- **Form WRAPPER de VCX: copiar TAMBEM o Left/Top dos filhos DIRETOS do container, nao so os das paginas**: controle que fica FORA da area do pai eh RECORTADO pelo Container - some da tela **sem erro, sem log e SEM APARECER EM SCREENSHOT**, entao nenhuma validacao visual do pipeline enxerga. No FormCliente os tres CommandGroup que trocam de aba (`cmdGCarac`/`cmdGFtec`/`cmdgpessoal`) ficaram no Left/Top da CLASSE do VCX (891..957, Top 540) porque o migrador so copiou os overrides do SCX dos controles das PAGINAS; como o `cnt_4c_Conta` tem `Width = 768` / `Height = 450` (fiel ao legado), os tres cairam fora e sumiram - o usuario entrava na aba de endereco e **nao tinha como voltar para a aba 1**, so restava Salvar. O SCX declarava `633,397` / `672,397` / `711,397`. Ao migrar wrapper, varrer no dump do SCX as linhas de UM ponto so (`^  nome.Left` / `^  nome.Top` - filho direto do container) e aplicar TODAS; as de varios pontos sao das paginas. Conferir `Left + Width <= pai.Width` e `Top + Height <= pai.Height`. Ignorar nome generico (`Command1`, `Option2`, `Text1`...): sao membros internos de CommandGroup/OptionGroup, posicionados pelo VFP
- **SCX que desloca um controle e NAO desloca o label vizinho: sobreposicao HERDADA, que comparar migrado x legado nunca pega**: quando o SCX sobrepoe o Left de um campo mas deixa o label/campo ao lado no Left da CLASSE, os dois se cruzam na tela. No FormCliente o SCX move getUFIBGE de 471 para 508 e nao move o label "Contato :" (518), que entra 15px DENTRO da caixa: a tela mostra "35ontato :". Copiar o SCX fielmente REPRODUZ o defeito, e toda validacao migrado-x-legado aprova, porque os dois concordam. Ao transcrever `.Left`, somar `Left + Width` do controle e conferir contra o `Left` do vizinho da MESMA linha (mesmo Top, +-6px) DENTRO DO MESMO CONTAINER - Left/Top sao relativos ao pai, comparar entre containers nao significa nada. Havendo cruzamento, preferir os valores da CLASSE (framework.vcx), que sao coerentes entre si, a inventar posicao nova; e registrar o desvio em comentario. Caso especial: controle que cabe INTEIRO dentro de outro fica inalcancavel ao clique (Get_Regiao 596..676 dentro de Get_Contato 565..717) - no legado esse campo costuma estar aposentado (linhas de Visible/obrigatoriedade COMENTADAS no VCX); esconder eh melhor que deixar soterrado. Label sem `.Width` eh AutoSize (classe say): a faixa real dele eh a do TEXTO, nao a da caixa (#23)
- **Metodo de VCX legado que o SCX sobrescreve SO para consertar layout: reaplicar no FUNIL de chamadas, nunca so no Init**: o p-code do VCX refaz o layout dele a CADA chamada. O mLeDados do clsconta termina com `.Top = Iif(.Tabs, 0, ThisForm.Height - This.PgframeDados.PageHeight)` e re-ancora os tres CommandGroup de navegacao com `.Top = (This.Height - .Height - 4)`. Medido: clsconta.pgframeDados.Height = 802 contra Form.Height = 600, entao com pcTpCadCli='1' o Top vira -198, a pagina 1 SOBE 195px e o container RECORTA o topo dela - o usuario clica Incluir e cai direto no bloco de endereco/contato (GetCEP.Top = 200 no SCX), sem Codigo/Nome/CPF na tela, sem erro, sem log e SEM APARECER EM SCREENSHOT. O SCX legado conserta com um override do PROPRIO metodo, que roda DEPOIS do DoDefault (DoDefault(...) seguido de thisform.cntConta.pgframeDados.Top = 0). Como o migrado instancia o VCX por AddObject e nao tem subclasse onde por o override, esse ajuste tem de rodar no FUNIL de chamadas do metodo (o wrapper Chamar<Metodo>Seguro) e tambem nos CATCH que engolem excecao - aplicar so no InicializarForm NAO adianta, porque o metodo roda de novo em TODO Incluir/Alterar/Visualizar. Ao migrar wrapper, procurar no dump do SCX uma PROCEDURE homonima de metodo do VCX: ela existe justamente para corrigir o que o p-code faz
- **PageFrame.ActivePage eh o PageOrder, NAO a ordem de declaracao das Pages**: no clsconta, pgframeDados1 (Cadastro) tem PageOrder=1, pgframeDados2 (Pessoal) tem PageOrder=**3** e pgframeDados7 (Complemento) tem PageOrder=**2**. O migrado fazia `ActivePage = 2` achando que ia para Pessoal e caia em Complemento; pior, o `cmdPessoal.Click` do VCX so age com ActivePage 1 ou 3 (`Case ActivePage==1 -> ActivePage = 3` / `Case ActivePage==3 -> ActivePage = 1`), entao depois disso ele ficava MORTO e o F5 nao fazia mais nada. Compila limpo, so aparece na tela. Nunca derivar ActivePage do sufixo do nome da Page - ler o PageOrder da CLASSE. E quando o legado navega chamando o Click de um botao (o KeyPress do SCX chama `cmdGPessoal.cmdPessoal.Click()` e MAIS NADA), TRANSCREVER isso: nao pre-setar ActivePage antes de delegar, senao o toggle do VCX perde a referencia e vira no-op
- **Membro INTERNO de CommandGroup/OptionGroup com NOME PROPRIO: aplicar os overrides do SCX (excecao da regra do nome generico)**: ignorar `Command1`/`Option2`/`Text1` continua certo, mas quando o membro tem nome proprio e o SCX declara geometria para ele (`cmdGCarac.cmdCarac.Top/Left/Height/Width/Picture/...`), esses overrides sao OBRIGATORIOS - o grupo eh AutoSize=.T. e eh a geometria do botao INTERNO que DEFINE a altura do grupo. Medido no VFP9: inner 32x32 em 5,5 (classe) da grupo de 42; inner 40x40 em 5,5 (SCX) da grupo de 50 - e so com 50 o `.Top = (Height - .Height - 4)` do mLeDados cai em 396, que eh o mesmo 397 que o SCX declara no grupo. Copiar so o Left/Top do GRUPO deixa os tres botoes menores e fora da linha desenhada pelo legado. Para ler as propriedades REAIS de uma classe de VCX (o .VCT eh p-code e grep devolve lixo), abrir a .vcx como DBF no proprio VFP9 e ler a coluna Properties: USE framework\classresp.vcx + SCAN por ObjName/Class
- **Wrapper de funcao global do legado tem de reproduzir o CONTRATO, nao so o nome**: redirecionar para a primitiva VFP de nome parecido NAO basta. `IsEmpty` do Fortyus nao eh `EMPTY` do VFP - medido: `EMPTY(.NULL.)` devolve `.F.`, isto eh, "nao esta vazio", enquanto o `IsEmpty` do legado trata NULL como vazio. O wrapper `utils\isempty.prg` fazia so `RETURN EMPTY(par_uValor)` e divergia exatamente no caso NULL, em 142 call sites do p-code. O sintoma aparece LONGE da causa e sem erro nenhum: o `mRetiraNull` do clsconta limpa nulos com `Update crSigCdCli Set Obs = "" Where IsEmpty(Obs)`, o WHERE nao casava, a linha nunca era limpa e o campo Obs. do Cadastro de Cliente exibia `.NULL.` na tela. Conserto: guarda de NULL ANTES de delegar, com IF separado e nao `ISNULL(x) OR EMPTY(x)` - VFP9 nao faz short-circuit em OR. Ao escrever ou revisar wrapper em `utils\`, testar explicitamente NULL, vazio, zero, `.F.` e argumento AUSENTE, e conferir contra o que os call sites do p-code esperam; vale para qualquer coluna que venha do SQL Server permitindo NULL. Delegacao com guarda de tipo eh o padrao certo (ver fvalidarcpf.prg / fvalidarcnpj.prg, que checam VARTYPE antes de delegar)
- **Form WRAPPER de VCX: auditar as properties de ThisForm que o p-code toca, e separar as que o VCX cria sozinho das que nao**: o p-code chama ThisForm.<x> em dezenas de pontos, e para a maioria ele mesmo se vira, com o par guarda + `AddProperty` (If Type('ThisForm.OldEmpresa') == 'U' -> ThisForm.AddProperty('OldEmpresa', ...)). Essas NUNCA dao erro e nao precisam ser declaradas no form. As que aparecem CRUAS, sem esse par, sao exatamente as que estouram em runtime: no `clsconta` sao 18 properties customizadas, 17 auto-criadas e UMA nao - `AlterouLgpd`, que fazia gravar uma ALTERACAO no Cadastro de Cliente estourar "Erro 1734: Property ALTEROULGPD is not found" dentro do mGravaDados. Varrer assim: abrir a .vcx como DBF no VFP9 e dumpar a coluna `Methods` SO dos registros cujo Parent+ObjName contem o nome da classe (grepar o .VCT inteiro mistura TODAS as classes do arquivo e traz lixo do p-code), extrair ThisForm.<x> desse dump, descontar as nativas de Form (Name, LockScreen, Height, BackColor, DataSessionId, Refresh, AddProperty) e cruzar com o que o .prg migrado ja declara. Property de OBJETO do legado que o migrado nao tem (ThisForm.Pagina, o PageFrame do frmcadastro) so eh segura se TODO uso estiver dentro de If Type('...')=='O' - conferir, nao presumir. Antes de declarar, conferir tambem que os CURSORES do bloco recem-habilitado existem, senao troca-se um erro por outro. E declarar NAO basta quando o ciclo de vida difere: o legado eh modal e vive UM registro, o migrado nao fecha entre um e outro, entao flag de sessao tem de ser RESETADO no funil de chamadas - sem isso o primeiro registro em que alguem tocar no consentimento deixa `AlterouLgpd` ligado para sempre e todo ALTERAR seguinte grava historico de LGPD FALSO. Auditoria: automation\VerificarPropsThisFormVCX.ps1
- **Funcao GLOBAL do legado Fortyus chamada pelo p-code do VCX: criar WRAPPER em utils\, NUNCA deixar faltando**: os VCX (framework.vcx / classobj.vcx / classresp.vcx) chamam funcoes da aplicacao legado (sig.prg / SIGFUNCS.PRG) que NAO vieram no acervo - fSQLExec, fChkCpoVlc, fChkCntVlc, fGravarLog, fValidarCpf, fValidarCNPJ, fAbrirTabs, fVerificaPasta, fMensagemFixa, fInibirBtn, fGerPDFCreator, fConfigGeral. O p-code esta COMPILADO e nao da para editar: o VFP procura <nome>.prg no PATH e so estoura em RUNTIME, dentro de Init/Valid/Click FORA de qualquer TRY/CATCH -> o form FECHA (Erro163_Aba1: digitar a UF no Cadastro de Cliente fechava a tela porque GetEstado.Valid faz CreateObject('fwBuscaExt',...) SEM o guard Type()=='O' que o GetCEP tem, e o Init do fwBuscaExt chama fSQLExec). O wrapper vai em projeto\app\utils\<nome minusculo>.prg no padrao de isempty.prg: LPARAMETERS + RETURN, SEM cabecalho FUNCTION - o arquivo eh resolvido pelo NOME. Auditar com automation\VerificarFuncoesLegadoVCX.ps1. NUNCA criar stub que devolve VALOR DE CALCULO (fCalcularST / fCalcularIPI): devolver 0 grava imposto errado em silencio (regra #17) - ausente eh mais seguro, porque o erro aparece alto. Vale igual para OBJETO global: goSistema.ObjectConn (cOpenConn, classes\sigclcnx.PRG) tem de existir, senao CreateObject('fSqlConector','cep') devolve pnIdConn = -1 e o VCX exibe "Impossivel Efetuar Conexao Com o Servidor de Banco de Dados..."
- **SET PATH TO com varias expressoes entre parenteses honra SO a PRIMEIRA**: SET PATH TO (a), (b), (c) faz o VFP9 usar so (a) e descartar o resto EM SILENCIO - sem erro de compilacao nem de runtime. Concatenar numa string unica: SET PATH TO (a + "," + b + "," + c). Eh especifico do SET PATH - SET PROCEDURE e SET CLASSLIB com varias expressoes entre parenteses funcionam normalmente. Sintoma tipico e distante da causa: .prg que EXISTE aparecendo como "File does not exist" (foi assim que isempty.prg dos VCX legado ficou inalcancavel); diante disso, medir SET("PATH") ANTES de mexer no arquivo
- **Propriedade que a CLASSE NAO TEM compila limpo e a TELA NAO ABRE**: atribuir .Prop a controle cuja classe base nao tem Prop nao eh erro de compilacao - estoura no Init, dentro do TRY, com "Property FORECOLOR is not found", e o usuario clica no menu e nada abre. Medido no VFP9: OptionGroup e CommandGroup NAO tem ForeColor (so BackColor); PageFrame nao tem ForeColor, BackColor nem BackStyle; ListBox nao tem ForeColor/BackColor (sao ItemForeColor/ItemBackColor); Shape nao tem ForeColor (sao BorderColor/FillColor) nem ShapeType (isso eh VB; no VFP eh Curvature); ZOrderSet nao existe em runtime em classe nenhuma (eh bookkeeping do Form Designer, gravado no SCX - remover, pois o equivalente eh o METODO ZOrder()). A cor de grupo mora nos MEMBROS e o SCX legado JA declara assim (Option1.ForeColor = 255,0,0) - transcrever o dump, e conferir se os OUTROS botoes do form nao perderam o ForeColor que o legado declara. Cuidado tambem com WITH aninhado, que sequestra o escopo e da o mesmo erro: dentro de WITH THIS.this_oBusinessObject, um WITH THIS.cnt_X faz .this_nProp (property do BO) resolver contra o Container. Auditoria: automation\VerificarPropriedadesInexistentes.ps1
- **`Controls` eh indexado por NUMERO - passar o NOME faz a tela nao abrir**: `Controls` eh array, nao colecao por chave. Medido no VFP9: `Controls("nome")` em expressao estoura "Invalid subscript reference" e, dentro de `WITH`, "CONTROLS is not an object" - compila limpo e so quebra no Init. O `PEMSTATUS(obj, "nome", 5)` que costuma cercar esses blocos devolve .T. e NAO protege (mesma armadilha da regra do BINDEVENT/metodo PROTECTED). Para alcancar membro por NOME: `EVALUATE("obj." + nome + ".Prop")` na LEITURA e `STORE valor TO ("obj." + nome + ".Prop")` na ATRIBUICAO; `WITH EVALUATE("obj." + nome)` tambem funciona. Se o que se quer eh o INDICE, escrever helper nome->indice varrendo ControlCount. `Controls(N)` numerico continua certo e eh o uso majoritario
- **A pagina LISTA segue o `Init` legado, nao o SCX desenhado**: (a) o filtro eh aplicado SEMPRE, inclusive VAZIO - o legado liga a grade a `Select * From X Where Col = ?m.pcVar` com a variavel vazia no Init, entao a Lista abre VAZIA de proposito; `IF !EMPTY(filtro)` caindo em `Buscar("")` traz a TABELA INTEIRA. (b) a grade espelha o `pColuna` do `AddCursor` (nome, caption e largura de cada coluna), NAO os headers desenhados no SCX - no Formgpd o SCX tinha 3 colunas e o pColuna tem 4, e a coluna que faltava tambem faltava no SELECT do BO. (c) `Column.Width` vai por ULTIMO: mexer em RecordSource/ControlSource e na fonte do Grid faz o VFP recalcular tudo para o default 90
- **Campo de filtro da Lista tem os DOIS eventos do legado**: tipicamente `Valid` (se o codigo digitado nao existe, abre o picker; ESC limpa o campo) e `LostFocus` (recarrega a grade ao SAIR do campo, nao so no Enter). Migrar so o KeyPress com Enter faz o campo "nao trazer nada". Como BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox, implementar as duas coisas no handler de LostFocus
- **`FormBuscaAuxiliar`: o 1o argumento eh o HANDLE da conexao**: a assinatura eh Init(par_nConn, par_cTabela, par_cCursor, par_cCampo, par_cValor, par_cTitulo, par_lBuscaExata, par_lMostraGrid, par_cFiltro) e o Init faz `SQLEXEC(par_nConn, ...)`. Passar a tabela (ou um cursor, ou um SELECT) no lugar de gnConnHandle desloca TODOS os argumentos e a consulta nunca acontece - o picker abre VAZIO, sem erro nenhum, porque o Init tem `IF VARTYPE(par_cTabela) != "C" / RETURN .T.`. Auditoria: automation\VerificarFormBuscaAuxiliar.ps1
- **`FormBuscaAuxiliar` tem CONTRATO - `this_lAchouRegistro` antes do `Show()`**: o Init ja tenta o match EXATO e, achando 1 registro, marca this_lAchouRegistro e this_lSelecionou - o valor esta resolvido e o picker NAO deve ser mostrado. Padrao canonico (137 arquivos): `IF !loc_oBusca.this_lAchouRegistro` envolvendo mAddColuna+Show, e a atribuicao SO dentro de `IF loc_oBusca.this_lSelecionou AND USED(<cursor>)`. Os dois erros andam juntos: Show desguardado abre o dialogo por cima da tela ja preenchida; atribuir o valor FORA da guarda (tipico `<controle>.Value = loc_cCodigo` no FIM do metodo) ZERA o campo quando nada foi escolhido, e o filtro/grade que dependia dele esvazia. NAO duplicar a checagem de existencia com um SQLEXEC proprio antes do picker: o Init ja faz isso
- **`.Self` NAO existe em VFP9 - dentro de `WITH`, repetir a expressao**: `Self` eh de Delphi/Object Pascal; o objeto VFP nao tem essa propriedade e dentro de um bloco WITH nao ha como referenciar o proprio objeto com ponto. Medido: `WITH obj` + `PEMSTATUS(.Self, "x", 5)` estoura **"Property SELF is not found"**, e `PEMSTATUS(obj, "Self", 5)` devolve .F. O correto eh repetir a expressao do WITH: `PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)`. COMPILA LIMPO e so quebra em RUNTIME
- **Pagina preenchida por DOIS metodos: se um esquecer o +29, a aba fica com texto sobre texto**: quando `ConfigurarAba<X>` e `ConfigurarPgpg<X>` preenchem a MESMA `pgf_4c_Divisoes.PageN`, basta um deles transcrever o Top CRU do SCX (sem a compensacao do `pgf_4c_Paginas.Top = -29`) para os controles dele cairem ~29px acima e pousarem sobre o que o outro ja desenhou. NAO ha erro nem log - so a aba desformatada. Medido no Formgpd: o ConfigurarPgpgConfig tinha 67 dos 83 controles com o Top cru. Ao escrever QUALQUER metodo Configurar*, conferir que TODO Top recebeu o +29, e que o comentario de origem cita o controle certo do dump
- **Migrador lendo o controle ERRADO no dump**: tres defeitos da mesma origem no Erro175 - (a) `Tptribs` recebeu o Top do `Get_CodServs` (409) em vez do `Get_TpTrib` (385), e as duas linhas viraram uma so; (b) `Obrigfiscs` foi para Left=440 quando o legado tem Left=176, parando do outro lado da tela sobre outro bloco; (c) label DUPLICADO - o ConfigurarAba* inventou um label ("Obrig. Fiscal :") para uma linha cujo label o ConfigurarPgpg* ja criava a partir do legado ("Class. Fiscal Obrigatoria :"). Ao achar dois labels na mesma linha, conferir qual existe no SCX: o legado tem UM
- **NAO existe deteccao automatica de offset/sobreposicao comparando com o legado**: tentado duas vezes e medido - varrendo o projeto contra o layout.json inteiro deu 4220 achados em ~230 forms (quase tudo falso positivo, inclusive num form ja corrigido); a versao dirigida por metodo+pagina acusou 49 num metodo recem-corrigido e 18 num que estava certo. A raiz eh a mesma do detector de "controle fora da area do pai": o PILAR 3 manda RENOMEAR os objetos, entao casar migrado com legado so resta por geometria, e sempre aparece um sosia. Serve para diagnosticar UM caso conhecido, nao para validar em massa nem para confirmar o conserto - o conserto se confere instanciando e olhando a tela
- **`Program Error` CRU do VFP em vez do dialogo do projeto = metodo SEM TRY/CATCH**: quando o erro aparece na janelinha "Program Error" do proprio VFP (Cancel/Suspend/Ignore/Help) e nao no MostrarErro/FormErro do sistema, o metodo que estourou nao tem TRY/CATCH. Usar isso para localizar: procurar o metodo sem TRY/CATCH no caminho do botao que o usuario acionou (no Erro174 era BtnIncluirClick -> AjustarBotoesPorModo)
- **Abrir form MODAL de dentro de `LostFocus` pede guarda de reentrancia**: o Show() bloqueia, o foco sai e volta, e o proprio LostFocus pode disparar de novo, empilhando um segundo picker. Usar property booleana no form, setada na entrada e limpa DEPOIS do ENDTRY (para valer tambem quando o CATCH dispara). Diagnostico barato: num teste headless, Show() de form modal TRAVA a execucao - se o script termina dentro do timeout, o picker nao abriu
- **Init de form grande falha em CADEIA - "a tela abre" so se prova INSTANCIANDO**: cada defeito no Init esconde o proximo. Antes de dar por pronto, instanciar de verdade (CREATEOBJECT com gb_4c_ModoTeste/gb_4c_ValidandoUI) e repetir ate passar. Tres defeitos tipicos, cada um so visivel depois do anterior: (a) `Controls(<nome>)`; (b) `.ColumnN.Check1.<prop>` sem `AddObject`+`CurrentControl` -> "Unknown member CHECK1", porque a Column nasce so com Header1/Text1; (c) metodo CHAMADO mas nunca GERADO -> "Property X is not found", que pode significar uma ABA INTEIRA perdida (no Formgpd eram 71 controles). Auditar todo `THIS.<membro>` contra o proprio form E a heranca de FormBase/BusinessBase/GridBase. Ao reconectar aba perdida, conferir o TIPO da property no BO: coluna `numeric(1,0)` MULTI-VALOR achatada em LOGICO com `(col = 1)` faz valores 2..7 lerem .F. e regravarem 0 - converter para numerico ANTES de mapear
- **Icone: TRANSCREVER o Picture do legado, NUNCA inventar o nome do arquivo**: o VFP9 aceita .Picture/.Icon apontando para arquivo inexistente SEM erro nenhum (nem compilacao, nem runtime, nem log) - o controle so nao desenha icone. Copiar o Picture do controle correspondente no dump do legado e conferir que o arquivo existe em vbmp\. NAO escolher icone por semelhanca semantica: no FormBAL o botao "Fecha" usa cadastro_salvar_60.jpg (fechar a contagem = gravar) e no FormSigPrGlp "Disponiveis" usa geral_palete_60.jpg, nao uma lupa. Atencao: o arquivo real eh cadastro_vizualizar_60.jpg (com Z) e o sufixo _26/_60 NAO eh o tamanho (todos os icones sao 32x32)
- **Format contendo "M" = multiple choice, e o InputMask eh a LISTA de valores validos**: se o SCX legado declara Format = "M" ou "KM", o InputMask NAO eh mascara de digitacao e sim a lista separada por virgula (",T,S,I,N,F", "S,N", "A,B", "0,1", "S,N, "). TRANSCREVER o par LITERALMENTE do dump - trocar o M por "!" ou descartar o InputMask compila limpo e faz o campo aceitar QUALQUER caractere. Lista SEM item vazio coage branco para o 1o item (e o comportamento do legado)
- CHR() para acentos (a=225, c=231, ao=227, e=233, i=237, o=243)
- NUNCA RETURN dentro de TRY/CATCH - inclui o RETURN BARE de guarda (sem valor), e vale no bloco TRY, no CATCH e no FINALLY. Fix: flag `loc_lProsseguir = .F.` no lugar do RETURN + envolver o resto do bloco em `IF loc_lProsseguir ... ENDIF` + RETURN unico DEPOIS do ENDTRY. So trocar o RETURN por atribuicao SEM envolver o resto descarta o early-exit e grava errado em silencio. `EXIT`/`LOOP` dentro do TRY sao seguros
- BINDEVENT metodos PUBLIC (sem PROTECTED)
- **TesteAutomatico.prg chama CarregarLista/AlternarPagina/AjustarBotoesPorModo/BtnIncluirClick/BtnCancelarClick direto no oForm (nao so BINDEVENT)**: esses metodos DEVEM ser PUBLIC - PEMSTATUS retorna .T. mesmo se PROTECTED (so verifica existencia), a chamada real falha com "Property METODO is not found."
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
- **Comentario de design decision NUNCA leva a frase "nao implementado"**: ao documentar por que um BO somente-leitura (form de CONSULTA sem INSERT/UPDATE/DELETE no legado) nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao(), NAO escrever "nao implementado"/"nao implementada" dentro de linha de comentario `*` - o validador 05d_validarCompletude tem regex que casa "nao implement" em QUALQUER comentario (nao so em TODO real) e rejeita a fase por falso positivo. Preferir frase como "o comportamento padrao herdado de BusinessBase ja eh o correto".
- **Label de dados: NUNCA inventar ``.Width`` + ``.Alignment = 1``**: a classe ``say`` do Framework legado eh ``AutoSize = .T.`` / ``Alignment = 0`` â€” o ``Say`` do SCX declara so ``Caption``/``Left``/``Top``, e esse ``Left`` ja foi calculado para o texto terminar poucos pixels antes do campo (FormCES: 411/415/415/418 com os TextBox em 455, textos terminando em 451). Inventar ``.Width = 60`` + ``.Alignment = 1`` encosta o texto na borda DIREITA da caixa, que cai DENTRO do TextBox; como o label eh criado antes, o controle desenha por cima e a legenda sai cortada ("Codigo :" vira "Codi") â€” compila limpo, so aparece na tela. Copiar ``Alignment``/``Width`` do dump: se o ``Say`` nao declara nenhum dos dois, usar ``.Alignment = 0`` com ``.Width`` que caiba o texto. ``AutoSize = .T.`` NAO resolve: eh no-op em Label criado por ``AddObject`` (a Width fica nos 100 do default). Auto-fix: CorretorAutomatico #202.
- **fAcessoEmpresa() NAO EXISTE (nao portada)**: A funcao global `fAcessoEmpresa()` do Framework legado (sigacess.PRG) NAO foi portada para a nova arquitetura. Chamadas diretas quebram em runtime com "File 'facessoempresa.prg' does not exist" (VFP9 procura .prg externo quando o nome nao eh THIS.metodo nem funcao definida). Substituicao canonica: MODO CHECK (3 args, retorna boolean) `fAcessoEmpresa(usu,"C",cod)` -> `VerificarAcessoEmpresa(usu, cod)` (helper em utils/functions.prg). MODO LOOKUP (5 args, popula 2 textboxes) `fAcessoEmpresa(usu, "C"|"D", val, oCod, oDsc)` -> bloco FormBuscaAuxiliar apontando SigCdEmp com chave Cemps (modo C) ou Razas (modo D), retornando ambas colunas. Titulo: "Sele" + CHR(231) + CHR(227) + "o de Empresa". Auto-fix: CorretorAutomatico #110. Padrao canonico: Formsigatcrp.prg:2278-2378 (KeyPress) e Formsigrepes.prg:6501-6540 (LostFocus). Bug observado em Formsigatcrp.prg + Formsigrepes.prg (2026-07-02, Erro14).
- **fAcessoContas() NAO USAR para lookup UX (auto-load do primeiro registro)**: A funcao `fAcessoContas()` (utils/functions.prg:719) EH portada, mas seu fluxo interno (`LIKE '%valor%'` + `LOCATE` + FormBuscaSimples) auto-popula o textbox com o PRIMEIRO registro que contem o valor digitado — mesmo sem selecao explicita do usuario no picker. Resultado tipico: user digita "11" no campo Gerente/Vendedor e o form carrega "GAVETA - LOJA 001..." (primeiro match parcial). PROIBIDO usar `fAcessoContas(usu, grp, "C"|"D", val, txtCod, txtNom)` como handler de Valid/KeyPress em textbox de lookup. Substituicao canonica: mesmo padrao de fAcessoEmpresa lookup (Formsigatcrp.prg:2612-2790 apos Erro16 fix). Enter/Tab -> `SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = valor` exato (hit -> auto-preenche, miss -> `THIS.AbrirBusca<X>()`). AbrirBusca<X> -> SQL proprio com `LIKE 'valor%' OR RTRIM(RClis) LIKE 'valor%'` (starts-with, NAO contem) + fallback lista completa + `CREATEOBJECT("FormBuscaAuxiliar")` sem SQL automatica + mAddColuna("IClis"/"RClis") + `.Show()` respeitando `this_lSelecionou`. `fAcessoContas()` continua valida para contexto backend (SCAN loop de acesso, validacao sem UI). Bug observado em Formsigatcrp.prg ValidarCodGer/ValidarNomGer/ValidarCodVen/ValidarNomVen (2026-07-02, Erro16).
- **.RecordMark/.DeleteMark SO em Grid — NUNCA em CommandButton/Label/Container/TextBox/ComboBox/etc**: As propriedades `.RecordMark` e `.DeleteMark` sao EXCLUSIVAS de Grid (barras laterais de marcacao/exclusao de registro). Gerador frequentemente copia esse par de `WITH grd_4c_Xxx` e cola em WITH de CommandButton adjacente (ex: `cmd_4c_SelXxx`/`cmd_4c_DslXxx` ao lado de grids de selecao multipla em REPORT). VFP9 trava com "Property RECORDMARK is not found" ao instanciar o form. PIOR: o erro eh silenciosamente engolido pelo TRY/CATCH de `InicializarForm` (apenas seta `loc_lSucesso=.F.` sem MsgErro), resultando em `CREATEOBJECT("FormXxx")` retornar `.F.` sem exception aparente e "VARTYPE retornou: L" no dialog. PROIBIDO gerar `.RecordMark = .F.` ou `.DeleteMark = .F.` em WITH cujo AddObject NAO seja `"Grid"`. Recomendacao complementar: no CATCH de `InicializarForm`, chamar `MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)` ANTES de setar `loc_lSucesso=.F.` — expoe o erro para debug em vez de engolir silenciosamente. Auto-fix: CorretorAutomatico #111. Bug observado em Formsigrepes.prg (2026-07-02, Erro17): 9 CommandButtons corrompidos (`cmd_4c_SelOrigMerc`, `cmd_4c_SelTipoInvs`, `cmd_4c_SelLinha`, etc).
- **CheckBox em Grid Column (Error 1767)**: Para grids com CheckBox, a UNICA definicao de ControlSource deve ser `Column1.ControlSource = "cursor.campo"` DEPOIS de `CurrentControl = "Check1"`. NUNCA definir `Check1.ControlSource` (conflita com Column) E NUNCA definir `Column1.ControlSource` ANTES de AddObject("Check1").
- **AddObject sintaxe CORRETA**: `parent.AddObject("nome", "Classe")` - ambos strings. NUNCA `parent.AddObject(loc_oObj, "nome")` (objeto como parametro causa "Function argument invalid"). Padrao: `parent.AddObject("cmd_4c_X", "CommandButton")` + `WITH parent.cmd_4c_X` para configurar.
- **Grid Column CurrentControl="Check1" EXIGE AddObject**: ANTES de `.Column1.CurrentControl = "Check1"`, OBRIGATORIO: `.Column1.AddObject("Check1", "CheckBox")` + `.Column1.Check1.Caption = ""`. Sem isso, erro "Unknown member CHECK1" cascateia e destroi toda inicializacao.
- **CheckBox .Value SEMPRE NUMERICO**: Inicializar CheckBox com `.Value = 1` (marcado) ou `.Value = 0` (desmarcado). NUNCA usar `.T.`/`.F.` (logico). Comparar com `= 1`/`= 0`, IIF com `IIF(chk.Value = 1, ...)`. Misturar tipos causa "Operator/operand type mismatch".
- **CheckBox.Value NUNCA atribuir DIRETO a prop LOGICAL do BO (dispara "Data type mismatch" no AND)**: Em `FormParaBO`/`FormParaRelatorio`, SEMPRE converter numerico para logico ao atribuir chk.Value em property declarada `.F.`/`.T.`: `.this_lXXX = (loc_oCnt.chk_4c_XXX.Value = 1)` — NUNCA `.this_lXXX = loc_oCnt.chk_4c_XXX.Value`. Sem conversao, a property vira NUMERICA (0/1) e a proxima expressao `<logical> AND <this_lXXX>` no BO dispara **erro 9 "Data type mismatch"** (nao 1817 "Operator/operand type mismatch" como esperado — VFP9 mascara). Reciproca em BO: em condicoes AND, NUNCA escrever `AND <numeric_field>` — sempre `AND <numeric_field> <> 0`. Ex: `IF SEEK(x) AND crSigCdMoe.Cotas <> 0` (NAO `AND crSigCdMoe.Cotas`); `IF !EMPTY(Nops) AND THIS.this_lProdutos` FALHA se this_lProdutos veio numerico do chk. Regra critica correlata: CATCH em `PrepararDados`/`Processar`/`BtnVisualizarClick` SEMPRE incluir `loc_oErro.LineNo` + `loc_oErro.Procedure` na msg (`MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em <PROC>")`) para localizar erros VFP mascarados. Auto-fix: CorretorAutomatico #150. Bug em FormSigReAtm/FormBlq/Formsigregli/FormSIGRECTL (2026-07-28, Erro65).
- **fCarregarCambio() NAO PORTADA - usar THIS.CarregarCambio() local**: Funcao legada `fCarregarCambio(pMoe, pDia)` do framework Fortyus (SIGFUNCS.PRG:5156) NUNCA foi portada para `projeto/app/utils/functions.prg`. Todo BO que converta moeda DEVE implementar `PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_xData)` local usando cursores `crSigCdCot` + `crSigCdMoe` (ou `cursor_4c_SigCdCot`/`cursor_4c_SigCdMoe` conforme naming do proprio BO — confirmar em `InicializarDados`/`InicializarCursores`). Chamar via `THIS.CarregarCambio(...)`. Se BO ja tem `THIS.ObterCotacao` (padrao sigprilaBO), reusar em vez de duplicar. Template canonico do metodo em `SigReAtmBO.prg:857` ou `SigReInvBO.prg:205`. Chamada direta a `fCarregarCambio(...)` quebra em runtime — mas o erro NAO eh "File not found" como esperado: VFP9 mascara e dispara "Data type mismatch" via CATCH de PrepararDados. Auto-fix: CorretorAutomatico #151. Bug em SigReAtmBO/sigprccpBO/sigreeqeBO/sigprilaBO (2026-07-28, Erro65).
- **`VAL(SET("Decimals"))` PROIBIDO - `SET("Decimals")` ja retorna NUMERIC em VFP9**: A funcao `SET()` retorna tipos DIFERENTES conforme a opcao: `SET("Escape")`/`SET("Fixed")`/`SET("Century")`/`SET("Talk")`/`SET("Date")`/`SET("Path")`/`SET("Point")`/`SET("Separator")` retornam **CHARACTER** ("ON"/"OFF"/valor); mas `SET("Decimals")` e `SET("REPORTBEHAVIOR")` retornam **NUMERIC**. Envolver retorno numerico com `VAL()` dispara **VFP9 erro 11 "Function argument value, type, or count is invalid."** imediatamente. Bug tipico: migrador copia o padrao de salvar/restaurar contexto de outros SETs e por reflexo escreve `loc_nDec = VAL(SET("Decimals"))`. **CORRETO**: `loc_nDec = SET("Decimals")` (sem VAL); `loc_nBhv = SET("REPORTBEHAVIOR")` (sem VAL). Restaurar: `SET DECIMALS TO loc_nDec` / `SET REPORTBEHAVIOR loc_nBhv`. Auto-fix: CorretorAutomatico #152. Bug em sigrebalBO (2026-07-28, Erro66) — quebrava PrepararDados imediatamente ao clicar Visualizar.
- **REPORT `Visualizar`/`Imprimir` — `IF !PrepararDados() / flag=.F. / ENDIF / REPORT FORM` fall-through PROIBIDO**: quando `PrepararDados()` retorna `.F.` (cursor vazio, filtros sem match, erro SQL), o bloco `IF ! ... ENDIF` seta a flag mas NAO interrompe o fluxo — cai direto em `REPORT FORM` que roda com cursor vazio/erro. Sintomas: preview em branco, "File does not exist", ou pior — NENHUMA mensagem para o usuario (que espera "Nenhum registro encontrado..."). **VARIANTE DOUBLE-IF (Erro110)**: mesma armadilha com 2+ IFs consecutivas — `IF !PrepararDados() / flag=.F. / ENDIF / IF !MontarCabecalho() / flag=.F. / ENDIF / REPORT FORM` — ambos IFs fall-through, REPORT FORM sempre roda. **FIX MINIMO (auto)**: adicionar `RETURN loc_l<Flag>` dentro do ULTIMO IF antes do ENDIF (early exit). **FIX IDEAL (manual)**: refatorar para fluxo positivo com AND encadeado `IF THIS.PrepararDados() AND THIS.MontarCabecalho() / loc_lSucesso = THIS.ExecutarReportForm("<Base>", "PREVIEW"\|"PRINTER_PROMPT"\|"PRINTER", THIS.this_cCursorDados) / THIS.LimparCursores() / ELSE / IF !EMPTY(THIS.this_cMensagemErro) / MsgErro(THIS.this_cMensagemErro, "Erro") / ENDIF / ENDIF` — helper canonico traz cursor-empty guard (MsgAviso automatico "Nenhum registro encontrado com os filtros informados."), FRX-existence check, locale isolation e menu restore. Template do helper em SigReAtmBO.prg:857 ou SigReCgcBO.prg (pos-Erro68) ou sigrecprBO.prg (pos-Erro110). Auto-fix: CorretorAutomatico #153 (minimo, agora cobre variante double-IF) + WARNING para refactor completo. Bug em sigrecheBO/sigredcoBO/SIGREDIRBO/SigReFtpBO (2026-07-28, Erro68); sigrecprBO/sigrechpBO (2026-08-12, Erro110 double-IF).
- **REPORT `PrepararDados` — `loc_lSucesso = .T.` INCONDICIONAL apos IF de erro PROIBIDO**: NUNCA escrever `IF loc_nResult < 0 / loc_lSucesso = .F. / ENDIF / SELECT (cursor) / GO TOP / loc_lSucesso = .T.` — a atribuicao final SOBRESCREVE o `.F.` setado no error branch. PrepararDados sempre retorna `.T.` mesmo com SQL error, e Visualizar/Imprimir chegam ao REPORT FORM com cursor invalido. **FIX**: envolver o success-path em ELSE explicito: `IF loc_nResult < 0 / loc_lSucesso = .F. / ELSE / SELECT (cursor) / GO TOP / loc_lSucesso = .T. / ENDIF`. Pattern correlato do fall-through Erro68/Erro110: garante que `PrepararDados` retorne `.F.` quando devido. Auto-fix: CorretorAutomatico #164 (WARNING-only — refactor exige contexto). Bug em sigreifxBO/SigReInfBO/SIGREIPSBO (2026-08-12, Erro110).
- **`IF !FILE(loc_cFrx)` bloco morto em REPORT `Visualizar`/`Imprimir` PROIBIDO**: template legado deixava `IF !FILE(loc_cFrx) / MsgErro/MsgAviso / loc_lXxx = .F. / ENDIF` DEPOIS do `IF !PrepararDados()` e ANTES de `THIS.ExecutarReportForm(...)`, com `loc_cFrx` declarado `LOCAL` mas NUNCA atribuido. VFP inicializa LOCAL como `.F.` (logical), logo `FILE(.F.)` dispara **VFP9 erro 11 "Function argument value, type, or count is invalid."** ao clicar Visualizar. NUNCA gerar esse bloco — o helper `THIS.ExecutarReportForm(...)` (Pattern #117) ja faz `FULLPATH + FILE + MostrarErro` descritivo. Template correto (fluxo positivo): `IF THIS.PrepararDados() / loc_lSucesso = THIS.ExecutarReportForm("<Base>", "PREVIEW"\|"PRINTER_PROMPT"\|"PRINTER", "<cursor>") / ENDIF` — sem qualquer referencia a `loc_cFrx`. Auto-fix: CorretorAutomatico #157 remove bloco morto quando (a) BO herda RelatorioBase, (b) `loc_cFrx` nunca eh atribuido, (c) bloco eh seguido de `ExecutarReportForm` em ate 5 linhas; Shape B (IF-ELSE) emite `WARN-157-IF-ELSE` (manual). Bug em Formsigrecmm sigrecmmBO + sweep afetou sigreimcBO/sigrehtcBO/SigReInvBO/sigrecgrBO (2026-08-05, Erro89).
- **REPORT `ConfigurarPaginaLista` — SEMPRE subtrair `PageFrame.Top` dos Tops absolutos legado**: Forms REPORT embrulham controles de filtro em `pgf_4c_Paginas.Page1`, com `PageFrame.Top = 85` (logo abaixo do cabecalho cinza). Controles adicionados via `loc_oPag.AddObject(...)` na Page usam coordenadas **RELATIVAS a Page1** — portanto os Tops legado (absolutos no form original) DEVEM ser subtraidos pelo `PageFrame.Top` na fase 4. Formula: `control.Top = layout.originalTop - PageFrame.Top`. **REGRA**: apos ler o Top do layout.json, aplicar a subtracao antes de gravar em `.Top =`. Excecoes que NAO subtraem: (a) `Buttons(N)` INTERNOS a OptionGroup/CommandGroup (relativos ao grupo, nao ao Page); (b) proprio Top do PageFrame em `ConfigurarPageFrame`. Sim subtraem: labels, textboxes, containers, o proprio Top do OptionGroup/CommandGroup. Sintomas de nao subtrair: layout inteiro empurrado N pixels pra baixo; ultimos controles (ex: OptionGroups no fim) ficam alem de `form.Height` e sao cortados; labels/textboxes desalinhados por rebordo do form. Referencia canonica CORRETA: `Formsigrecrf.prg` (task066) — comentario `"Posicoes top = original - 85 (PageFrame.Top=85)"` + valores subtraidos. Auto-fix: CorretorAutomatico #165 WARNING-only (parse regex nao distingue nesting Buttons(N) sem AST — refactor manual). Bug em Formsigrecnt (2026-08-13, Erro113): 23 controles com Top absoluto legado apesar de PageFrame.Top=85; OptLocal.Top=265 e OptOrdem.Top=289 saltaram alem de form.Height=350 e ficaram cortados. Meta-licao: o proprio codigo do bug tinha o comentario `"Posicoes: layout.json original top - 85 (offset do PageFrame)"` MAS valores nao subtraidos — comentario correto, codigo errado.
- **FormBuscaAuxiliar Pattern B (Init com params) PROIBIDO — usar helper `THIS.AbrirLookupCanonico(...)` OU Pattern A manual**: `CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "Tabela", "cursor", "campo", valor, "titulo")` + `mAddColuna` + `Show()` (Pattern B — 2+ args no CREATEOBJECT) tem **3 defeitos**: (1) Init interno faz `WHERE campo='X'` + `LIKE 'X%'` — se AMBOS retornam 0 rows, FECHA o cursor e picker abre vazio; (2) FormBuscaAuxiliar herda `DataSession=1` (shared) — se form pai eh `DataSession=2` (private), USED() pos-Show retorna .F. no caller e selecao perde; (3) cursor scope isolado entre sessoes. **PREFERIDO**: usar helper `THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, par_cValorFiltro, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)` em FormBase.prg (encapsula Pattern A completo em 1 chamada). **FALLBACK MANUAL (Pattern A)**: (1) SQL no CALLER com `LIKE 'valor%'` em cod OR desc + fallback SHOW-ALL se 0 rows; (2) `CREATEOBJECT("FormBuscaAuxiliar")` SEM parametros; (3) `.DefinirCursor(cursor, "Cods", "Descs", "titulo")` com aliases `AS Cods`/`AS Descs` no SELECT; (4) `IF .Mostrar()` — ler `.cCodigoSelecionado` / `.cDescricaoSelecionada` (nao SELECT cursor); (5) `USE IN SELECT(cursor)` no final. Reciproca em `Validar<Campo>`: quando busca exata falha, NUNCA `MsgAviso("nao encontrado")+limpar campo` — chamar `THIS.AbrirBusca<X>()` direto (picker abre filtrado pelo prefixo tipado). Ref canonico: `Formsigrecrf.prg` (task066) — Pattern A original; `Formsigrecog.prg` (task059, pos-Erro114) — Pattern A recem-convertido; `FormBase.prg:AbrirLookupCanonico` (helper novo, 2026-08-13). Auto-fix: CorretorAutomatico #166 WARNING-only (nao muta — cada call tem tabela/campos/titulo especificos exigindo contexto). Bug em Formsigrecog (2026-08-13, Erro114): usuario digita "M" em vendedor+Enter, picker abre vazio pois `WHERE codigos='M'` e `LIKE 'M%'` ambos 0 rows. Sweep pendente: ~209 forms com ~500 chamadas Pattern B, incremental form-a-form conforme testado.
- **`STR(<coluna_char>, N)` PROIBIDO — dispara VFP9 erro 11**: colunas CHAR de tabelas Sig* (ex: `SigCdGpr.codigos` char(3), `SigCdGcr.codigos` char(10), `SigMvCab.Emps` char(3), `SigCdCli.iclis` char(10), `SigCdGrp.cgrus` char(3)) NUNCA devem ser envolvidas com `STR()`. VFP9 `STR()` exige NUMERIC first arg — passar char dispara **erro 11 "Function argument value, type, or count is invalid."** em runtime (LOCATE, INSERT, Value assignment). ERRADO: `ALLTRIM(STR(cursor_4c_X.codigos, 2))` / `LOCATE FOR ALLTRIM(STR(codigos, 5)) = ALLTRIM(loc_cCod)`. CORRETO: `ALLTRIM(cursor_4c_X.codigos)` / `LOCATE FOR ALLTRIM(codigos) == ALLTRIM(loc_cCod)`. **REGRA GENERICA**: SEMPRE consultar schema.sql antes de escrever `STR(<coluna>)` — se a coluna eh char, remover o STR. Colunas char comuns: `codigos`, `cgrus`, `cemps`, `iclis`, `cpros`, `cunis`, `dopes`, `grupos`, `classes`, `emps`, `razas`, `descs`, `descrs`, `rclis`. Auto-fix: CorretorAutomatico #158 (whitelist de colunas char via schema; regex `STR\(\s*(cursor\.)?<col>\s*,\s*\d+\s*\)` -> `<col>`; skip strings SQL detectadas por aspas/colchetes). Bug em FormSigReCmp ValidarGrdGrupoCod/AbrirBuscaGrdGrupo/ValidarGrdGrupoDesc — 6 sites (2026-08-05, Erro90-a).
- **`.InputMask = "##..#"` em TextBox `.Value = ""` (CHAR) PROIBIDO — bloqueia letras**: em VFP9, `#` no `InputMask` aceita APENAS digitos/espacos/sinais. Se a coluna do banco eh `char(N)` (que pode conter letras — ex: `SigCdGpr.codigos = 'A01'`), o usuario nao consegue digitar letras. Migrador copia InputMask numerico do legado sem checar tipo. **REGRA**: se `.Value = ""` (indica char), NUNCA usar `.InputMask = "#+"` — usar `.MaxLength = N` (limita tamanho sem restringir tipo). Se `.Value = 0` (indica numeric), manter `.InputMask = "###..."` OK. ERRADO: `WITH txt / .Value = "" / .InputMask = "##" / ENDWITH` sobre coluna char(3). CORRETO: `WITH txt / .Value = "" / .MaxLength = 3 / ENDWITH`. Auto-fix: CorretorAutomatico #159 detecta `.InputMask = "#+"` numa janela WITH com `.Value = ""` e substitui por `.MaxLength = <count-hashes>`; se .Value = 0 mantem; se ambiguo emite `WARN-159-INPUTMASK-AMBIGUO`. Bug em FormSigReCmp Grande Grupo txt_4c__cd_ggrupo (2026-08-05, Erro90-b).
- **`<Cursor>.<Coluna>` DEVE bater com SELECT list — nao prefixar por convencao**: BO faz `SELECT a.Emps FROM SigMvCab a INTO CURSOR CrSigMvCab`; depois referenciar `CrSigMvCab.Cemps` (com prefixo `C` invento por convencao Sig*Cd*) dispara **"Variable 'CEMPS' is not found."** ao runtime. VFP9 alias.coluna EXIGE que a coluna esteja no SELECT list literal — nao ha auto-prefixamento nem alias implicito. **REGRA**: apos escrever SELECT list, listar as colunas selecionadas e SEMPRE usar EXATAMENTE esses nomes ao referenciar `<Cursor>.<Col>`. Nunca "corrigir" o nome por padrao (Emps eh Emps, mesmo em tabela Sig*). Auto-fix: CorretorAutomatico #160 mapa cursores + colunas referenciadas + emite WARNING (nao muta — parse SQL fragil). Bug em SigReCmpBO.prg linhas 675 e 707: `CrSigMvCab.Cemps` vs SELECT `a.Emps` (2026-08-05, Erro91).
- **`SigMv*.emps` vs `SigCd*.cemps` — nomes DIFERENTES entre MOVIMENTO e MESTRE**: Coluna de empresa tem naming irregular entre tabelas. Tabelas MOVIMENTO (`SigMvCab`, `SigMvItn`, `SigMvNfi`, `SigMvPar`, `SigMvCcr`) usam `emps` (SEM prefixo C). Tabela MESTRE `SigCdEmp` usa `cemps` (COM prefixo C). JOIN CORRETO: `INNER JOIN SigCdEmp e ON e.cemps = a.emps` (onde `a` = SigMv*). Escrever `a.cemps` quando `a` = SigMv* dispara SQL Server **"Nome de coluna 'cemps' invalido"** ao clicar Visualizar/Imprimir. **REGRA**: SEMPRE consultar `docs/schema.sql` antes — nunca deduzir por convencao. IRREGULARIDADES conhecidas: `SIGFICHC` usa `emps` (apesar de prefixo Fi de master); `SIGFITEF` usa `cemps` (apesar de prefixo Fi de master). Colunas confirmadas: `SigMvCab.emps` linha 13180, `SigMvNfi.emps` linha 14464, `SigFiChc.emps` linha 11229, `SigCdEmp.cemps` linha 3111, `SigFiTef.cemps` linha 12098. Complementa Erro91 (invented C prefix em cursor) e Erro106 (WHERE `Emps` em SigCdPam single-row). Auto-fix: CorretorAutomatico #161 WARNING-only (parse fragil — muitos falsos positivos quando `a` = SigCdEmp legitimo). Bug em sigrecogBO.prg:211 + sweep sigrecsmBO/SIGREDIRBO/CecBO (2026-08-12, Erro108).
- **FRXs legados DEVEM ser copiados ao gerar BO REPORT**: BO REPORT que referencia FRX via `THIS.ExecutarReportForm("SigReXxx", ...)` ou `THIS.ObterNomeFRX()` retornando `"SigReXxx"` SOMENTE funciona se `SigReXxx.frx`+`.frt` existirem em `C:\4c\projeto\app\reports\`. Se ausentes, helper Pattern #117 exibe **"Arquivo de relatorio nao encontrado: C:\4C\PROJETO\APP\START\..\reports\SigReXxx.frx"** ao clicar Visualizar (path esta correto — o problema eh arquivo faltante). **REGRA**: apos gerar BO REPORT, extrair TODOS os nomes FRX referenciados (do `ExecutarReportForm` + todas as branches de `ObterNomeFRX`) e copiar `<Nome>.frx`+`<Nome>.frt` de `C:\4install\FortyusMC\Fortyus\` para `C:\4c\projeto\app\reports\` preservando o nome-case do BO (Windows FS eh case-insensitive). Ferramenta: `powershell -ExecutionPolicy Bypass -File C:\4c\automation\CopiarFRXsAusentes.ps1` (dry-run + auto-copia; retorna exit code 2 se algum FRX nao existe no legado). Bug em FormSigReCmp — SigReCp2.frx + SigReCp3.frx nunca portados (2026-08-05, Erro92).
- **IF THEN inline PROIBIDO**: VFP9 NAO suporta `IF cond THEN cmd` numa unica linha. Gera "Command contains unrecognized phrase/keyword." SEMPRE expandir para multi-linha: `IF cond` / `  cmd` / `ENDIF`.
- **COUNT TO var IN alias PROIBIDO**: VFP9 COUNT nao tem clausula IN. Gera "Command contains unrecognized phrase/keyword." Usar: `SELECT alias` + `COUNT TO var`.
- **APPEND FROM requer SELECT cursor antes**: `ZAP IN cursor_name` NAO muda a work area corrente. `APPEND FROM DBF("tmp")` vai para a work area CORRENTE. SEMPRE fazer `SELECT cursor_destino` antes de `APPEND FROM`. Sem isso, dados vao para o cursor errado e o grid fica vazio.
- **CommandGroup.FontName NAO EXISTE**: CommandGroup (como OptionGroup) NAO tem FontName/FontSize. Definir em cada `.Buttons(N).FontName`. Tentar no grupo causa "Property FONTNAME is not found" que cascateia e impede toda configuracao dos botoes.
- **AlternarPagina eh o FUNIL de volta - repor o MODO e reabilitar os botoes (Erro176)**: em forms CRUD, `AlternarPagina(1)` tem de fazer as DUAS coisas - `THIS.this_cModoAtual = "LISTA"` DENTRO do `IF par_nPagina = 1` e `THIS.AjustarBotoesPorModo()` no FIM do metodo. Quem so chama `AjustarBotoesPorModo` nos `Btn*Click` de ENTRADA (Incluir/Alterar/Visualizar) deixa os 5 botoes da Lista cinza depois de GRAVAR e depois de CANCELAR: nao estoura, nao entra em log, nao quebra compilacao (eh estado que ninguem restaura) e a tela fica inutilizavel ate ser fechada. Medido no VFP9 em 2026-09-24: so a chamada, sem repor o modo, NAO resolve (Formemp/Formsigpdmp7/FormSRV/FormDpi continuaram em `.F.`), porque a reabilitacao passa a depender de cada caller trocar o modo antes. Forma canonica: `THIS.pgf_4c_Paginas.ActivePage = par_nPagina` / `IF par_nPagina = 1` / `THIS.this_cModoAtual = "LISTA"` / `THIS.CarregarLista()` / `ENDIF` / `THIS.AjustarBotoesPorModo()`. Referencia: Formcfi, Formcnl, FormFNF, FormOcc. Gate: CorretorAutomatico pattern #210
- **Chave POSICIONAL concatenada: NUNCA ALLTRIM nas partes (Erro177)**: chave montada concatenando colunas ``char`` de largura fixa eh POSICIONAL - o padding FAZ PARTE da chave. O legado do SIGMVSBN monta ``lcEmpDopNums = TmpSubN.Emps + TmpSubN.Dopes + Str(TmpSubN.Numes, 6)`` SEM ALLTRIM, porque ``Emps`` eh ``char(3)`` e ``Dopes`` eh ``char(20)``: 3 + 20 + 6 = **29**, que eh exatamente ``EmpDopNums char(29)``. Escrever ``ALLTRIM(par_cEmps) + ALLTRIM(par_cDopes) + STR(par_nNumes, 6)`` da 15 caracteres (``001MALOTE     3``) e **nunca casa** com o valor gravado (``001MALOTE                   3``): o SELECT roda SEM ERRO e devolve ZERO linhas - sem exception, sem log, so a tela vazia (no FormSigMvSbn isso deixava a grade de itens, a descricao e a imagem do produto permanentemente vazias, e os handlers de AfterRowColChange/DblClick viravam codigo morto). Usar ``PADR(parte, <largura da coluna no schema>)`` EXPLICITO - nao confiar no padding que o cursor por acaso traz, porque ``ObterChavePrimaria()`` chama o mesmo montador com as properties do BO, que o ``Init`` do Form guarda JA com ALLTRIM. **A largura do ``char(N)`` destino eh a conferencia**: se a soma das partes nao da N, a montagem esta errada. ATENCAO a distincao ao varrer: ALLTRIM nas partes INTERIORES quebra, mas ALLTRIM na chave INTEIRA (no fim) eh inofensivo - ``char`` no SQL Server compara com blank-padding ANSI - e esse caso inofensivo eh o MAJORITARIO, entao tratar os dois igual produz WARNING massivo. **Instanciar o form NAO pega este defeito**: ``InicializarForm`` pula ``CarregarLista`` em ``gb_4c_ModoTeste`` e o TestFormWrapper passa com SUCESSO; num visualizador, o equivalente a "testar gravando" eh provar que a consulta devolve LINHA (conferir RECCOUNT, nao o retorno ``.T.``)

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
- **Left RELATIVO em botoes de container (Erro143)**: Dentro de `WITH .cmd_4c_Incluir/Visualizar/Alterar/Excluir/Buscar` (filhos de cnt_4c_Botoes), usar `.Left` RELATIVO ao container: Incluir=5, Visualizar=80, Alterar=155, Excluir=230, Buscar=305. NUNCA copiar o Left absoluto do container pai (542) para os botoes filhos — isso posiciona o botao em 542+542=1084, fora do form (Width=1000), INVISIVEL. Dentro de `WITH .cmd_4c_Encerrar` (filho de cnt_4c_Saida), usar `.Left=5` NUNCA `.Left=917`. Auto-fix: CorretorAutomatico #182.
- **Grid.ColumnCount NUNCA reatribuir em Carregar* (Erro144)**: Em VFP9, qualquer atribuicao a ColumnCount recria TODOS os objetos de coluna, destruindo controles AddObject (CheckBox/ComboBox). Definir ColumnCount APENAS em ConfigurarAba*/ConfigurarGrid* na inicializacao. Nos metodos Carregar*Aba/CarregarLista NAO reatribuir ColumnCount. Protecao: PEMSTATUS(grid.ColumnN, "controle", 5) antes de acessar controle AddObject'd. Warning: CorretorAutomatico #183.
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
- **`ALLTRIM(<cursor>.<coluna_numeric>)` dispara VFP9 erro 11 — consultar schema.sql para tipo antes de remover `STR()`**: `ALLTRIM`/`EscaparSQL` exigem char first arg; concat direto `<numeric> + "string"` estora "Operator/operand type mismatch". Pattern #158 (auto-fix) remove `STR()` de `ALLTRIM(STR(<col>, N))` APENAS quando coluna eh CHAR (whitelist via `docs/schema.sql`); replicacao manual OU migracao de novo cursor DEVE consultar schema.sql antes. Exemplos criticos: `SigCdGpr.codigos = char(3)` (REMOVE STR) mas `SigCdTom.codigos = numeric(2,0)` (MANTEM STR — se remover, `ALLTRIM(numeric)` estora "Function argument value, type, or count is invalid." no `Init/InicializarDados` e o form NAO ABRE). Padrao CORRETO: `INSERT INTO cur (Descri) VALUES (ALLTRIM(STR(<cursor>.Codigos, 2)) + "-" + ALLTRIM(<cursor>.Descrs))`. Regra: se em duvida sobre tipo, MANTER STR — custo negligenciavel, sempre funciona. NAO automavel (WARNING-only — Pattern #158 whitelist ja cobre o caso comum; adicionar auto-fix reverso repete o proprio bug). Bug em SigReCmpBO.prg:124 (2026-08-06, Erro93) — commit "chore mudanca manual pos-sweep" replicou Pattern #158 sem checar schema.sql; sweep retroativo Erro93 corrigiu +3 BOs (`sigrefcxBO:230` concat direto numeric, `SIGREADSBO:174 e 371`, `sigreatoBO:238`). Meta-licao: commits "chore mudanca manual pos-sweep" que replicam auto-fix sem consultar schema.sql sao a fonte #1 de regressao.

**EXECUCAO UNATTENDED**: Se criar scripts .prg auxiliares (compilacao, testes), SEMPRE incluir `SET SAFETY OFF` e `SET RESOURCE OFF` no inicio. O pipeline roda sem supervisao - dialogos modais travam a execucao.

**PROCEDURE Destroy DEVE chamar DODEFAULT()**: Se o form migrado precisar sobrescrever `PROCEDURE Destroy` (ex: fechar cursores custom), a ULTIMA linha antes de `ENDPROC` DEVE ser `DODEFAULT()`. `FormBase.Destroy` contem o fix menu-shrinks (`RELEASE POPUP + CriarMenuPrincipal`) que roda apos qualquer form modal fechar. Sem DODEFAULT() a cadeia de heranca quebra e os popups do menu principal (Cadastros/Movimentos/Relatorios/etc) aparecem visualmente truncados na proxima abertura. Auto-fix Pattern #145 injeta se ausente, mas melhor evitar. Origem: Erro58 (2026-07-21).

**Grid Column CheckBox EXIGE 7 props explicitas — sem elas, cliques nao mudam estado**: Ao criar CheckBox dentro de Grid Column, alem de `.Sparse = .F.` (Pattern #121), DEVE definir explicitamente: `.Check1.Alignment = 0`, `.Check1.ReadOnly = .F.`, `.Check1.Visible = .T.`, `.Check1.Top = 9`, `.Check1.Left = 2`, `.Check1.Height = 17`, `.Check1.Width = 22`. Sem essas props, VFP9 renderiza CheckBox visualmente correto (mostra checked/unchecked conforme cursor) mas NAO responde a cliques (Column.ReadOnly=.F. nao basta; VFP em contexto Grid usa defaults ambiguos para o CheckBox filho). Padrao canonico: `WITH loc_oGrd.Column1 / .Width=15 / .Alignment=0 / .Enabled=.T. / .Sparse=.F. / .AddObject("Check1","CheckBox") / .Check1.Caption="" / .Check1.Alignment=0 / .Check1.ReadOnly=.F. / .Check1.Visible=.T. / .Check1.Top=9 / .Check1.Left=2 / .Check1.Height=17 / .Check1.Width=22 / .CurrentControl="Check1" / .ControlSource="<cursor>.<campo>" / ENDWITH`. Auto-fix Pattern #146 injeta as props ausentes se `.Check1.Caption` estiver presente. Sweep 2026-07-21 corrigiu 16 blocos em 12 forms. Origem: Erro59 (2026-07-21, Formsigreato — user "checkbox desabilitado, nao consigo marcar/desmarcar" apesar de renderizacao visualmente OK).

**Icones `cadastro_imprimir_60.jpg` e `cadastro_excel_60.jpg` NAO EXISTEM em vbmp/**: Adicionar a blocklist de nomes inventados por gerador (complementa `geral_visualizar_60.jpg`/`geral_imprimir_60.jpg`/`geral_fechar_60.jpg` ja proibidos). Substituicao canonica: `cadastro_imprimir_60.jpg` → `relatorio_impressora_26.jpg` (botao 2 Imprimir); `cadastro_excel_60.jpg` → `geral_envelope_32.jpg` (se botao 3 for "Arquivos Email", padrao canonico) OU `geral_excel_60.jpg` (se botao 3 for "Documento"/export). Ambos icones canonicos existem em vbmp/. Auto-fix: CorretorAutomatico Pattern #96 (blocklist atualizada). Bug em Formsigrechp+Formsigredtv+Formsigrehpr (2026-08-04, Erro87).

**TextBox S/N (Sim/Nao) `Format="M"` + `InputMask="S,N, "` OBRIGATORIOS — sem eles TextBox aceita qualquer char**: TextBox com `MaxLength=1` cuja label vizinha eh `(S/N)` (representa coluna char(1) semantica Sim/Nao) DEVE ter `Format = "M"` + `InputMask = "S,N, "` (lista fixa canonica VFP9). Sem esse par, campo aceita qualquer caractere (X/A/7/etc) e usuario grava valor invalido. `Format="M"` transforma TextBox em "multiple choice" que aceita apenas chars que iniciam algum item do InputMask csv-list — `S`/`N`/space passam, resto eh silenciosamente descartado. Legado sempre gera esse par (ex `sigcdcar_form_codigo_fonte.txt` `Get_senha`: `Format="M"` + `InputMask="S,N, "`). Migrador tende a gerar apenas `MaxLength=1` (limita tamanho, nao tipo). Auto-fix: CorretorAutomatico #175 detecta bloco `WITH ... TextBox / .MaxLength=1 / ... / ENDWITH` cuja Label irma seguinte tem `.Caption = "(S/N)"`, injeta `.Format = "M"` + `.InputMask = "S,N, "` antes do ENDWITH. Bug em FormCargo (Erro137 2026-09-01, task354 SigCdCar): 12 TextBoxes S/N aceitavam qualquer char (txt_4c_Nivels/Altcots/Limites/Cancitens/Libfpags/Libsdins/Libfpgs/Libopes/Libexprd/Fcomis/Libvmovdup/ConsSubn).

**BO CRUD `Buscar()` — NUNCA `ZAP + APPEND FROM DBF()` em `cursor_4c_Dados` compartilhado — SEMPRE `USE IN + SQLEXEC direto`**: `cursor_4c_Dados` eh o cursor de listagem padrao COMPARTILHADO por 163+ BOs CRUD (todos que herdam de BusinessBase e populam Page1.Grid). Anti-padrao gerado pelo migrador: `IF USED("cursor_4c_Dados") / SQLEXEC(...,"cursor_4c_DadosTmp") / SELECT cursor_4c_Dados / ZAP / APPEND FROM DBF("cursor_4c_DadosTmp") / USE IN cursor_4c_DadosTmp / ELSE / SQLEXEC(...,"cursor_4c_Dados") / ENDIF` — `ZAP` apaga registros mas PRESERVA a estrutura (colunas + constraints NOT NULL) que outro BO deixou no cursor. **Sequencia toxica**: user abre FormCargo (`CargoBO.Buscar` cria `cursor_4c_Dados` com estrutura `ccargs char(10) NOT NULL, dcargs char(20)` — herda NOT NULL da PK de SigCdCrg) -> user abre FormCor (`CorBO.Buscar` faz SELECT `cods, descs, varias, Pesos` que NAO tem coluna `ccargs`) -> APPEND tenta inserir com `ccargs=NULL` -> SQL Server erro **"Field CCARGS does not accept null values"** no CATCH de `Buscar()`. Qualquer par de forms CRUD com esquemas PK diferentes eh vulneravel. **FIX CANONICO** (`CargoBO.Buscar:89`): substituir bloco todo por `IF USED("cursor_4c_Dados") / USE IN cursor_4c_Dados / ENDIF / loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") / IF loc_nResultado >= 0 / loc_lSucesso = .T. / ELSE / MostrarErro("Erro ao buscar..." + CHR(13) + CapturarErroSQL(), "Erro SQL") / ENDIF`. Form CRUD ja rebinda `Grid.RecordSource = "cursor_4c_Dados"` + `Column.ControlSource` + `Header.Caption` em `CarregarLista()` APOS `Buscar()` (padrao Problema 48) — nao ha regressao de UX. **NAO usar ZAP+APPEND** achando que preserva binding do Grid — SQLEXEC "cursor_4c_Dados" tambem recria e re-binda transparentemente quando CarregarLista roda logo depois. Auto-fix: CorretorAutomatico #176 detecta bloco IF-ELSE-ZAP-APPEND canonico e substitui por USE IN+SQLEXEC direto. Bug em CorBO.Buscar (Erro138 2026-09-01, ao abrir FormCor apos FormCargo). Escopo: 163+ BOs CRUD afetados — sweep retroativo aplicado.

**BO property name DEVE bater EXATAMENTE com uso no Form (`FormParaBO`/`BOParaForm`) — naming mismatch causa `Property THIS_<X> is not found` + GRAVACAO SILENCIOSAMENTE ERRADA**: Migrador as vezes nomeia property do BO com naming SEMANTICO (`this_nSubclaEncerr` — significado do campo) enquanto o Form referencia com naming DB (`this_nChkSubs` — espelho da coluna `nchksubs`). Ao clicar Salvar/Alterar em form CRUD: `FormParaBO` executa `THIS.this_oBusinessObject.this_nChkSubs = IIF(opt.Value = 1, 1, 0)` → VFP9 estora **"Property THIS_NCHKSUBS is not found"** em MessageBox → user clica OK/Continuar → **CATCH nao interrompe o fluxo**, INSERT/UPDATE roda com property DEFAULT (`this_nSubclaEncerr = 0` nunca atribuida) → banco recebe SEMPRE 0/valor inicial. Sintoma pior que o erro visivel: user pensa "erro mas gravou", nao percebe que campos S/N/OptionGroup gravaram VALOR ERRADO permanentemente. **REGRA UNIVERSAL**: nomes de property no BO DEVEM ser IDENTICOS aos nomes usados em `FormParaBO`/`BOParaForm`/`CarregarDoCursor`/`Validar<X>` do Form. **PREFERIR NOME DB** (espelhar coluna `nchksubs` -> `this_nChkSubs`; `iclis` -> `this_cIclis`) para eliminar essa classe de mismatches — regra secundaria de CLAUDE.md Property Naming Sufixo 's'. Se herdar codigo com naming semantico, refactor SEMPRE em pares (form + BO simultaneos) via `replace_all` no PS/VSCode do nome antigo pro novo. Auto-fix: CorretorAutomatico #177 WARNING-only — grep no `Form*.prg` por `THIS\.this_oBusinessObject\.this_(\w+)` extrai nomes; grep no BO correspondente + heranca (BusinessBase/RelatorioBase) por `^\s*this_\1\s*=` declaracao (fora de PROC/FUNC — depth counter); se ausente, emite `WARN-177-BO-PROP-NAO-DECLARADA` com linha+nome+BO. Nao muta pois renomear demanda contexto (decisao DB-vs-semantico + refactor em ambos arquivos). Bug em `FormDepartamento` -> `DepartamentoBO` (Erro139 2026-09-01, Salvar cadastro de departamento — property `this_nChkSubs` usada no form mas BO declarava `this_nSubclaEncerr`; MessageBox aparecia mas save prosseguia gravando 0). Escopo: qualquer BO CRUD com mapeamento OptionGroup/CheckBox/TextBox custom — sweep detecta.

**`cmd_4c_Confirmar.Enabled = loc_lEdit*` em `HabilitarCampos(par_lHabilitar)` DESABILITA Confirmar em modo EXCLUIR — SEMPRE adicionar `OR (THIS.this_cModoAtual = "EXCLUIR")`**: Em Form CRUD, `BtnExcluirClick` chama `HabilitarCampos(.F.)` para tornar campos READONLY (user apenas VE o registro antes de confirmar exclusao). Mas o mesmo metodo tambem faz `cmd_4c_Confirmar.Enabled = loc_lEdit` (ou variantes `loc_lEditar`/`loc_lEditando`/`loc_lEdita`) — quando `par_lHabilitar=.F.`, `loc_lEdit*=.F.` e **Confirmar fica DISABLED**. User ve a tela de exclusao com registro carregado, botao Confirmar CINZA sem imagem (icone `cadastro_confirmar_60.jpg` nao renderiza em `.Enabled=.F.`), IMPOSSIVEL confirmar a exclusao. Semantica correta: em EXCLUIR, campos ficam readonly (loc_lEdit=.F.) MAS Confirmar precisa estar habilitado (user tem que clicar para confirmar a acao). **FIX CANONICO**: `cmd_4c_Confirmar.Enabled = loc_lEdit OR (THIS.this_cModoAtual = "EXCLUIR")` — Confirmar habilitado em INCLUIR/ALTERAR (loc_lEdit=.T.) E em EXCLUIR (loc_lEdit=.F. mas THIS.this_cModoAtual="EXCLUIR"). Regra vale para TODAS as variantes de flag: `loc_lEdit`/`loc_lEditar`/`loc_lEditando`/`loc_lEdita` — auto-fix Pattern #178 detecta regex `cmd_4c_Confirmar\.Enabled\s*=\s*loc_lEdit\w*\s*$` e injeta o OR. Idempotente (skip se linha ja contem "EXCLUIR"). Bug em FormDepartamento (Erro140 2026-09-01, clicar Excluir apos selecionar registro no grid — tela abre com dados carregados mas Confirmar disabled). Escopo: ~34 forms CRUD com o mesmo padrao — sweep retroativo aplicado.

**Form CRUD `Width < 1000` com `cnt_4c_Saida.Left=917` TRUNCA botoes Encerrar/ultimos**: Padrao canonico CLAUDE.md #10 fixa `cnt_4c_Saida.Left=917 + Width=90` (Encerrar termina em 1007). Se `Form.Width < 1000`, o container Saida transborda e Encerrar fica INVISIVEL; alem disso, `cnt_4c_Botoes.Left=542 + Width=385` termina em 927, ultimos botoes (Excluir Left=230/absoluto 772, Buscar Left=305/absoluto 847) tambem podem ser cortados se Width menor. **REGRA UNIVERSAL**: Form CRUD (`AS FormBase`) DEVE ter `Width = 1000` — canonico universal. Se SCX legado tinha Width menor (ex: 812), IGNORAR e usar 1000. Auto-fix: CorretorAutomatico #179 WARNING-only (nao muta pois alguns forms pequenos podem ter layout intencional — decisao humana caso a caso). Detector: guard `DEFINE CLASS \w+ AS FormBase` + presenca de `\.Left = 917` (assinatura do cnt_4c_Saida canonico) + `Width = N` no bloco de propriedades da classe com N<1000. Sweep 2026-09-01: 6 candidatos (FormCCJ/FormCrt/FormGcp/FormMoe/FormRop/FormSigPrCtc). Bug em FormSrv Width=812 (Erro141 2026-09-01, botoes Excluir e Encerrar cortados no menu Cadastros->Servicos).

**Grid `RecordSource=""+re-set` em `CarregarLista` RESETA `Column.Width` e `Header1.Caption` — SEMPRE re-configurar APOS ControlSource (Problema 48 CLAUDE.md)**: Em Form CRUD, `CarregarLista` faz `Grid.RecordSource="" / ColumnCount=N / RecordSource="cursor_x" / Column1.ControlSource="..." / Column2.ControlSource="..."` para trocar cursor. Esse padrao RESETA silenciosamente `Column.Width` (volta para default ~64) e `Header1.Caption` (volta para "Header1"). Se `ConfigurarPaginaLista` (setup inicial) definiu Width/Caption dessas colunas, elas SE PERDEM ao chamar `CarregarLista` — grid aparece com colunas "Header1"/"Header1" com widths quadrados. **FIX CANONICO**: apos o ultimo `ControlSource=`, adicionar re-configuracao explicita `Grid.ColumnN.Width = <valor_original>` e `Grid.ColumnN.Header1.Caption = "<caption_original>"` para cada coluna. Valores originais estao no bloco `ConfigurarPaginaLista` (mesmo grid path). Auto-fix: CorretorAutomatico #180 auto-mutate — extrai valores originais do bloco de configuracao inicial e injeta apos ControlSource. Fallback WARNING se valores originais nao localizados. Idempotente (skip se ja tem `Column.Width=` ou `Header1.Caption=` no mesmo bloco). Bug em FormSrv 2 grids (Erro141 2026-09-01, cadastro Servicos + grid interno Produtos mostrando "Header1"). Complementa Problema 48 canonico ja documentado.

**`pgf_4c_Paginas.Width` hardcoded < `Form.Width` TRUNCA botoes na Page1 mesmo com Form.Width canonico**: PageFrame `pgf_4c_Paginas` (root do layout Page1/Page2) DEVE ter Width IGUAL ao `Form.Width` para exibir toda a area util. Se `PageFrame.Width = 815` mas `Form.Width = 1000`, o PageFrame ocupa apenas 815px — botoes/containers com Left > 815 (ex: `cnt_4c_Saida.Left=917`) ficam CORTADOS pela borda do PageFrame, mesmo estando dentro dos 1000px do Form. Fix `Form.Width=1000` (Pattern #179) sozinho NAO resolve — precisa tambem ajustar PageFrame.Width. **FIX CANONICO**: `THIS.pgf_4c_Paginas.Width = THIS.Width` (dinamico, sempre segue Form.Width) — mais robusto que hardcoded. Alternativa: valor literal >=1000 (canonico CRUD). NUNCA hardcoded < 1000 quando Form.Width=1000. Auto-fix: CorretorAutomatico #181 detecta bloco `WITH THIS.pgf_4c_Paginas` (ou variantes com var local) + `.Width = N` onde N eh literal numerico < 1000, substitui por `.Width = THIS.Width`. Guard: apenas em Form CRUD (`AS FormBase`). Idempotente (skip `.Width = THIS.Width`; skip se N >= 1000). Bug em FormSrv (Erro142 2026-09-01, PageFrame.Width=815 truncava botoes apos fix inicial Form.Width=812->1000 nao resolver). Meta-licao: quando Form.Width eh alterado, TAMBEM ajustar PageFrame.Width simultaneamente — ambos formam um par sincronizado.

**Grid com coluna EDITAVEL (CheckBox/ComboBox) exige cursor READWRITE - `SQLEXEC()` cria cursor SOMENTE-LEITURA**: cursor de SQL pass-through nasce read-only no VFP; uma coluna com `AddObject("chk_4c_X", "CheckBox")` + `CurrentControl` + `Sparse=.F.` RENDERIZA o controle em TODAS as linhas mas a celula NUNCA entra em edicao - clicar no CheckBox nao faz nada, e o sintoma parece bug de `Enabled`/`ReadOnly` (que estao corretos), fazendo perder horas no lugar errado. SEMPRE que o Grid tiver coluna editavel, no BO usar alias TEMPORARIO + conversao: `SQLEXEC(gnConnHandle, loc_cSQL, "<alias>Tmp")` + `IF USED("<alias>") / USE IN <alias> / ENDIF` + `SELECT * FROM <alias>Tmp INTO CURSOR <alias> READWRITE` + `IF USED("<alias>Tmp") / USE IN <alias>Tmp / ENDIF` (template canonico `CCJBO.prg:214`). COROLARIO: como o cursor passa a ser fechado/recriado, o Grid perde o binding e reatribuir `RecordSource` reseta tambem `Column.Sparse`/`Column.CurrentControl`/`Column.ReadOnly` (alem de `Column.Width`/`Header1.Caption` - Problema 48), entao nos metodos `Carregar*` restaurar `.Sparse = .F.` + `.CurrentControl = "<controle>"` APOS o rebind (restauracao dentro do `IF !PEMSTATUS(...)` defensivo NAO basta - so roda quando o controle foi destruido), e chamar `Habilitar*Grid(<modo editavel>)` DEPOIS de todas as cargas (`HabilitarCampos(.T.)` em `BtnIncluirClick` roda ANTES do rebind e eh descartado). Ref: Erro145-v2 (2026-09-04, Formacg/acgBO) - Pattern #184 WARNING-only

**`AddObject` e `BINDEVENT` em coluna de Grid: nome do controle tem de bater com o alvo REAL — tres defeitos que quebram o Init**: (A) **NUNCA dois `AddObject("<X>", ...)` com o MESMO nome no MESMO alvo** — VFP dispara `Object <X> is already defined` e o `Init` do form morre; se duas copias configuram propriedades diferentes, consolidar num bloco so (achado: `grd_4c_Fases.Column4` com dois `AddObject("Check1","CheckBox")` identicos dentro do mesmo `WITH`). (B) **NUNCA deixar controle adicionado e nao usado** — se a coluna faz `AddObject("check12")` + `AddObject("check13")` e o `CurrentControl` eh `"check13"`, o `check12` eh objeto morto: remover, ou corrigir o `CurrentControl` se a intencao era ele. (C) **`BINDEVENT(<grid>.ColumnN.<M>, ...)` so vale se `<M>` for `Text1`/`Header1` (nativos da Column) ou tiver sido `AddObject`'d NAQUELA coluna** — referencia de objeto invalida estoura no `Init` E deixa o controle sem handler nenhum; a causa tipica eh copiar o bloco de `BINDEVENT` de outro grid sem trocar o nome do controle (achado: os 4 `BINDEVENT` de `grd_4c_Emps.Column1` apontavam para `Check1`, que so existe em `grd_4c_Opers.Column1` — o CheckBox de Empresas ficou sem toggle e ninguem percebeu porque o erro some no CATCH do `InicializarForm`). REGRA PRATICA: ao copiar um bloco de configuracao de grid, trocar TRES coisas juntas — o caminho do grid, o nome do controle no `AddObject`/`CurrentControl` e o alvo de cada `BINDEVENT`. Excecao legitima: o re-`AddObject` dentro de `IF !PEMSTATUS(...)` nos `Carregar*` eh defensivo (Pattern #183) e NAO conta como duplicata. Ref: Erro146 / sweep Pattern #185 (2026-09-04, FormLin/FormMda/Formpgr/Formsigredtv) - Pattern #186 WARNING-only

**CheckBox em coluna de Grid NAO alterna pelo binding nativo - exige os 4 handlers Click/MouseDown/MouseUp/KeyPress com NODEFAULT**: `Column.AddObject("chk_4c_X","CheckBox")` + `CurrentControl` + `ControlSource` + `Sparse=.F.` fazem o CheckBox RENDERIZAR em todas as linhas e ate RECEBER FOCO, mas clicar ou teclar Espaco/Enter NAO muda o valor - e o sintoma parece bug de `Enabled`/`Column.ReadOnly` (que estao corretos). Os forms legado Fortyus SUPRIMEM o toggle padrao e alternam o valor por codigo; migrar so o `When` (o gate de modo) deixa o checkbox inerte. Template canonico obrigatorio, um bloco por checkbox de grid: `PROCEDURE Chk<X>KeyPress(par_nKeyCode, par_nShiftAltCtrl) / IF INLIST(par_nKeyCode, 13, 32) AND INLIST(THIS.this_cModoAtual,"INCLUIR","ALTERAR") AND USED("<cursor>") AND !EOF("<cursor>") / REPLACE <cursor>.<campo> WITH IIF(<cursor>.<campo> = 0, 1, 0) / THIS.<path>.<grid>.Refresh() / NODEFAULT / ENDIF / ENDPROC` mais `Chk<X>MouseUp` (`THIS.Chk<X>KeyPress(13, 0)` + `NODEFAULT`), `Chk<X>MouseDown` (`NODEFAULT`) e `Chk<X>Click` (`NODEFAULT`) - os dois ultimos existem para SUPRIMIR o toggle nativo e evitar alternancia dupla. Registrar os 4 com `BINDEVENT(<chk>, "KeyPress"|"MouseUp"|"MouseDown"|"Click", THIS, "<handler>")` em TODO ponto que cria o controle (o `ConfigurarAba*` E o bloco defensivo `IF !PEMSTATUS(...)` dos `Carregar*`). O gate de modo vai DENTRO do KeyPress, nao so no `When`: BINDEVENT descarta o retorno do delegate, entao um `When` ligado por BINDEVENT nao bloqueia edicao. PRE-REQUISITO: o cursor precisa ser READWRITE, senao o `REPLACE` estoura (ver regra do cursor de SQLEXEC). Ref canonico: `Formsigredtv.prg:963-1585` (grd_4c_Emps) e `Formacg.prg` pos-Erro146; ref legado: `SIGCDACG.Pagina.Dados.Pagina.Acesso.grdAcesso.Column3.Check1` (Click=NoDefault, MouseDown=NoDefault, MouseUp=This.KeyPress(13,0)+NoDefault, KeyPress=Replace+Refresh+NoDefault). Ref: Erro146 (2026-09-04, Formacg) - Pattern #185 WARNING-only
- **IIF() exige condicao LOGICA - IIF(chk.Value, 1, 0) dispara erro 11**: CheckBox.Value eh NUMERICO (0/1) nos forms gerados, e IIF() so aceita LOGICO no 1o argumento. Passar numero estoura "Function argument value, type, or count is invalid." (VFP9 erro 11) - e em FormParaBO o erro cai no CATCH, aborta o metodo no meio e o Salvar segue gravando registro PARCIAL (bug silencioso, pior que a caixa de erro). SEMPRE comparar explicitamente: IIF(chk_4c_X.Value = 1, 1, 0). Vale para qualquer expressao numerica usada como condicao (IIF/IF/DO WHILE). Corolario: FormParaBO deve ser FUNCTION retornando .T./.F. e BtnSalvarClick deve ABORTAR a gravacao quando ela falhar. Auto-fix: CorretorAutomatico #187. Bug observado em Formcfo.prg (2026-09-08, Erro147).
- **ControlSource NUMERICO no SCX = indice 1-based (NUNCA booleano 0/1)**: ComboBox/OptionGroup do legado com ControlSource apontando para coluna NUMERICA grava o INDICE do item selecionado (1 = 1o item, 2 = 2o item, 0 = nada selecionado), NUNCA 0/1. Migrar como BO.this_nX = cbo.ListIndex / BO.this_nX = opt.Value, e o inverso cbo.ListIndex = IIF(BETWEEN(val,1,N), val, 0) / opt.Value = IIF(BETWEEN(val,1,N), val, 0). PROIBIDO inventar RowSource placeholder ("0,1") - copiar a lista EXATA do SCX ("Sim,Nao", "Nao,Base,Preco", ...). ComboBox com ColumnCount=2 + BoundColumn=2 grava a 2a coluna do RowSource (copiar ColumnCount/ColumnWidths/BoundColumn). ComboBox com ControlSource CHAR grava a INICIAL da opcao: LEFT(UPPER(ALLTRIM(cbo.Value)), 1), igual ao "Replace campo with padr(upper(alltrim(cbo.value)),1)" do legado. Conferir a distribuicao REAL da coluna no banco antes de assumir 0/1. WARNING: CorretorAutomatico #188. Bug observado em Formcfo.prg (2026-09-08, Erro147): 7 combos e 12 OptionGroups gravavam valores errados silenciosamente.
- **NUNCA reportar sucesso quando nao houve o que gravar**: metodo de gravacao que percorre um cursor de detalhe (grade de itens/ocorrencias/parcelas) e nao encontra nenhuma linha valida NAO pode retornar .T. em modo de INCLUSAO, e o form NAO pode exibir MsgInfo("... salvo com sucesso") nesse caso â€” o usuario ve a mensagem, volta para a lista e o registro nao existe (bug pior que erro visivel). No form, ANTES de chamar o BO: contar as linhas do cursor com a coluna-chave preenchida e, se zero em modo INSERIR/INCLUIR, MsgAviso("Informe ao menos um(a) <item> antes de gravar.") + SetFocus na grade + RETURN. Em ALTERAR a lista vazia continua valida quando o legado apaga-e-reinsere (significa remover todos os itens). Mesma familia do Erro147 (metodo de transferencia que falha e deixa o Salvar seguir). WARNING: CorretorAutomatico #189. Bug observado em FormSIGPRLNC.prg (2026-09-08, Erro148).
- **Grid da lista (Page1) tem de espelhar as colunas do legado, nao a grade de detalhe**: no SCX/Init legado as colunas da lista vem de `.AddCursor(...)` + `.pfSqlTabela(1).pColuna(<campo>, ..., <header>, <largura>, ...)` â€” copiar campo, caption e largura EXATOS de cada pColuna. Erro tipico: o migrador copia os captions da grade de detalhe da Page2 (ex.: "Ocorrencia"/"Descricao") para a lista de registros e ainda perde colunas. PROIBIDO tambem trocar a granularidade da lista: se o legado faz `Select * From <tabela>` (uma linha por registro), NAO usar `SELECT DISTINCT` de um subconjunto â€” alem de esconder colunas, isso muda a semantica de Alterar/Excluir (a linha selecionada deixa de ter chave primaria e o Excluir vira exclusao em massa por chave secundaria, apagando o que o usuario nao pediu). Levar a PK (ex.: cidchaves) para o cursor da lista e excluir por ela. Bug observado em FormSIGPRLNC.prg (2026-09-08, Erro148).
- **INSERT do BO tem de cobrir TODAS as colunas NOT NULL sem DEFAULT**: o legado grava o registro inteiro (AddCursor sem query = SELECT * + TABLEUPDATE), entao colunas que nao aparecem na tela continuam sendo gravadas com o valor do registro em branco. Se o INSERT do BO omitir uma coluna NOT NULL, o SQL Server recusa a inclusao inteira com "Nao eh possivel inserir o valor NULL na coluna <col> ... a coluna nao permite nulos. Falha em INSERT." e o cadastro fica sem conseguir incluir. Regras de preenchimento: (a) `cidchaves`/`pkchaves` (chave unica do Fortyus) = `EscaparSQL(fUniqueIds())` â€” NUNCA string vazia, senao o segundo registro colide no indice unico; (b) coluna com property no BO = usar a property; (c) sem property = default do tipo (`EscaparSQL("")` para char, `FormatarNumeroSQL(0, <decimais>)` para numeric, `0` para bit, data sentinela para datetime NOT NULL); (d) `usuars`/`usualts` = `gc_4c_UsuarioLogado`. ATENCAO a colunas GEMEAS de nome parecido, que existem juntas e sao ambas NOT NULL: `tipo`+`tipos` (SigCdRom), `prioridade`+`prioridades` (SigCdClc), `imprs`+`iimprs` (SigOpPic), `cidatrabs`+`cidtrabs` (SigCdCli) â€” incluir a que falta, nao trocar a existente. MAS ANTES DE INCLUIR, CONFERIR se a grafia que JA esta no INSERT existe na tabela: se NAO existe, nao sao gemeas - a migracao ERROU A GRAFIA e o conserto eh RENOMEAR, nao acrescentar. Suspeitar de metatese (`ems`/`ens`, `oas`/`aos`, `tipo`/`tip`): gemeas de verdade diferem por um sufixo inteiro, nao por letras trocadas de lugar. Erro de grafia nunca fica so no INSERT - esta tambem no UPDATE e na leitura do cursor em `CarregarDoCursor`; como `CarregarPorCodigo` usa `SELECT *`, o cursor traz a grafia REAL e a leitura estoura em RUNTIME com `Variable X is not found` (compila limpo, quebra Alterar/Visualizar). Renomear no arquivo INTEIRO, case-sensitive e com limite de palavra, preservando os nomes das properties. Observado em gpdBO/SigCdGrp, onde os SEIS nomes estavam errados (2026-09-14, Erro159). Conferencia em lote: `automation\VerificarInsertNotNull.ps1` (cruza os INSERT dos BOs com INFORMATION_SCHEMA). COMO GARANTIR (a regra sozinha JA FALHOU uma vez): antes de escrever o INSERT, extrair do schema a lista de colunas NOT NULL sem DEFAULT da tabela destino e conferir UMA A UMA contra a lista do INSERT. NAO basta ler o dump do legado - as colunas que o legado nunca cita (existiam so no registro em branco do AddCursor) sao invisiveis la e sao justamente as que faltam: em SigFiChc foram `nsenha` e `versao`, alem da PK `cidchaves`. Conferencia automatica na etapa 05f (`Validate-InsertNotNull` do ValidadorSQLSchema.ps1), que BLOQUEIA a migracao se faltar coluna. Bug observado em AliBO/SigCdAli.reincids (2026-09-08, Erro151) e em mais 20 sites no sweep; reincidiu em CecBO/SigFiChc (2026-09-14, Erro159).
- **Label/CheckBox/OptionButton de DADOS nunca leva ForeColor branco - o canonico eh RGB(90, 90, 90)**: as Pages do PageFrame recebem `.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"` (textura CLARA) que cobre o `.BackColor = RGB(100,100,100)`, entao qualquer `.ForeColor = RGB(255, 255, 255)` em controle criado DIRETO na pagina (ou dentro de container com `BackStyle = 0`, que eh transparente, ou com BackColor claro) fica INVISIVEL - o usuario clica em Incluir, abre a aba Dados e ve as caixas de texto sem nenhuma legenda. Quando o objeto do SCX legado NAO declara ForeColor (classe `say` do Framework), usar RGB(90, 90, 90); quando declara, copiar o valor EXATO (36,84,155 nos titulos de secao em Verdana, 255,0,0 nas notas de rodape). Ao procurar o objeto no dump do legado, conferir os DOIS nomes: `Say<N>` do legado costuma virar `lbl_4c_Label<N>` no migrado. EXCECOES legitimas, que continuam brancas: `lbl_4c_Titulo`/`lbl_4c_LblTitulo` da faixa do cabecalho, label dentro de container OPACO escuro (`BackStyle = 1` + BackColor RGB(100,100,100)/RGB(90,90,90)) e as propriedades `HighlightForeColor`/`SelectedForeColor`/`SelectedItemForeColor` (texto da linha selecionada, que fica sobre realce escuro). WARNING: CorretorAutomatico #191. Bug observado em FormARV.prg (2026-09-09, Erro153) e em mais 22 forms no sweep (217 sites).
- **NUNCA chamar helper que voce nao definiu - em VFP9 o erro so aparece em RUNTIME**: chamada "nua" a um nome que nao existe como funcao global compila sem reclamar; o VFP resolve nome desconhecido procurando `<nome>.prg` em disco e, quando o usuario aciona o botao, estoura `File 'nomedafuncao.prg' does not exist.` Antes de usar um helper, conferir que ele EXISTE em `projeto\app\utils\functions.prg` (`TratarNulo`, `EscaparSQL`, `FormatarNumeroSQL`, `FormatarDataSQL`, `ConverterParaLogico`, `MsgErro`, `MsgAviso`, `MsgInfo`, `MsgConfirma`, ...). Precisando de um helper novo, DEFINIR em functions.prg no mesmo padrao - PROIBIDO so chamar e seguir em frente. Corolario (CLAUDE.md regra #8): metodo da propria classe SEMPRE com `THIS.` - sem o prefixo cai no mesmo erro de arquivo inexistente. ATENCAO ao helper que le coluna do banco: coluna `bit` do SQL Server chega ao VFP ora como Logico (.T./.F.) ora como Numerico (0/1) conforme o driver, e coluna `numeric(1,0)` sempre como Numerico - testar `VARTYPE` antes de comparar, porque comparar Logico com 1 estoura "Operator/operand type mismatch". Auditoria: `automation\VerificarFuncoesNaoDefinidas.ps1`. WARNING: CorretorAutomatico #192. Bug observado em BchBO/BlqBO/DCCBO/OETBO/sigpdmp6BO/sigpres2BO (2026-09-09, Erro154): `ConverterParaLogico` foi inventado pelo migrador e chamado em 17 sites sem existir em lugar nenhum.
- **`docs\schema.sql` eh UTF-16LE - grep/awk/findstr devolvem ZERO SILENCIOSAMENTE**: essas ferramentas tratam o arquivo como binario e nao acham nada, fazendo tabela e coluna EXISTENTES parecerem inexistentes. A "correcao" natural a partir desse diagnostico falso - apontar o BO para outra tabela - grava dado no lugar errado e viola o PILAR 2. Ler sempre com `Get-Content -Raw` (PowerShell respeita o BOM) ou usar `automation\VerificarTabelasInexistentes.ps1`, que ja trata o encoding e ainda aborta se ler menos de 100 tabelas (piso de sanidade contra leitura falha). Tambem NAO usar `tasks\<task>\schema_ascii.sql` como fonte de verdade: eh snapshot congelado na epoca daquela task (task351 tem 674 tabelas contra 682 do canonico) e faz tabela nova parecer ausente. Corolario para o erro de runtime `Nome de objeto 'SigCdXxx' invalido` (vem do SQL Server, nao do VFP, e nao quebra a compilacao): (1) conferir a tabela no schema canonico com o encoding correto; (2) conferir o nome no CODIGO LEGADO em `tasks\<task>\*_form_codigo_fonte.txt`. Se o legado usa o MESMO nome e a tabela esta no schema, o codigo migrado esta FIEL e a divergencia eh de BANCO/ambiente (a base conectada nao bate com o dump) - NAO eh bug de migracao e NAO se conserta no codigo. WARNING: CorretorAutomatico #193. Bug observado em FormBlq/SigCdBlq (2026-09-09, Erro155).
- **`EVALUATE()` NAO atribui - ele avalia e devolve o valor**: `EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = ''")` NAO limpa nada. O VFP monta a string, enxerga uma COMPARACAO (`obj.prop.Value = ''`), avalia como `.T.`/`.F.` e joga o resultado fora - sem erro, sem aviso, o campo simplesmente nunca muda. Comprovado no VFP9: valor antes `[ABC]`, depois do EVALUATE `[ABC]`, depois do STORE `[]`. Para atribuir a um nome montado em tempo de execucao, usar `STORE <valor> TO (<expressao que resulta no nome>)`: `STORE "" TO ("loc_oCnt." + par_cTxtDesc + ".Value")`. `EVALUATE` continua CERTO para LEITURA (`loc_c = EVALUATE("loc_oCnt." + par_cTxtCon + ".Value")`, `IF EVALUATE("VARTYPE(loc_oCnt." + par_cX + ")") = "O"`) - o defeito eh so quando o sinal de igual esta DENTRO da string montada, que eh o unico caso em que a intencao era atribuir. Auto-fix: CorretorAutomatico #194 (forma segura: valor vazio ou identificador simples; valor com concatenacao/funcao vira WARNING). Bug observado em Formlch.prg (2026-09-09, Erro155): 4 sites, e o pior calava a descricao do GRUPO nos 7 containers do form desde a migracao, sem ninguem perceber.
- **A faixa do cabecalho tem de ser o PRIMEIRO `AddObject` da pagina Dados - senao ela COBRE os botoes**: os containers de botao (`cnt_4c_Salva`/`cnt_4c_BotoesAcao`/`cnt_4c_Saida`) ficam em `Top = 29..33`, ou seja DENTRO da area da faixa (`Top = 29..31`, `Height = 80`), e so aparecem se forem criados DEPOIS dela. Com a ordem invertida o usuario abre a aba Dados e ve o cabecalho comendo Confirmar/Encerrar - sobra so a lasca dos ~10px que passam da altura da faixa. Vale so para a pagina Dados: na Lista o migrador costuma acertar a ordem. EXCECAO: pagina com PageFrame/Container interno que cobre tudo (`Formgpd.pgf_4c_Divisoes`) - ali a faixa vem DEPOIS de proposito e a barra de botoes eh trazida para frente com `ZOrder(0)`; a presenca do `ZOrder(0)` eh o que distingue esse caso de um bug. CORRELATO: conferir que os labels da faixa nao ficaram PELADOS - `.AddObject("lbl_4c_Sombra", "Label")` sem nenhuma propriedade em seguida faz o titulo sair como label default minusculo, preto sobre cinza, mesmo com o `Caption` setado no `Init` (injecao do Erro152 que ficou pela metade no FormCat). Auto-fix: CorretorAutomatico #195. Bug observado em FormCAD e FormCat (2026-09-09, Erro156).
- **A faixa cinza do cabecalho vai nas DUAS paginas (Lista E Dados)**: o SCX legado (frmcadastro) tem o cntSombra so em Pagina.Lista, mas o padrao adotado no sistema novo eh repetir a faixa na pagina Dados - decisao do time (Erro152), que PREVALECE sobre o PILAR 1 neste ponto. Bloco canonico em Formcfo.prg ConfigurarPaginaDados: `cnt_4c_Cabecalho` Container com Top=29, Left=0, Width=THIS.Width, Height=80, BackColor=RGB(100,100,100), BorderWidth=0, SpecialEffect=0, contendo `lbl_4c_Sombra` (Top=15, ForeColor preto) e `lbl_4c_Titulo` (Top=18, ForeColor branco), ambos Tahoma 16 bold, BackStyle=0, Caption=THIS.Caption. O cabecalho tem de ser o PRIMEIRO AddObject da pagina: assim os containers de botao (cnt_4c_Salva/cnt_4c_BotoesAcao/cnt_4c_Saida, que ficam em Top=29..33) sao criados depois e desenham POR CIMA da faixa, como no Formcfo. Consequencia de layout: nenhum controle de DADOS pode ficar com Top < 109 (29+80) na pagina Dados - ao converter os Tops do SCX, empurrar o conteudo para baixo da faixa. Conferencia: `automation\DiagnosticoCabecalhoPaginas.ps1`. WARNING: CorretorAutomatico #190.
- **Cabecalho: detectar por BackColor+altura, NUNCA pelo nome do container**: o mesmo cabecalho aparece como `cnt_4c_Cabecalho` na maioria dos forms e como `cnt_4c_Sombra` (nome do legado, cntSombra) em outros - procurar so pelo nome faz o form parecer "sem cabecalho" e leva a injetar uma faixa DUPLICADA por cima da existente (aconteceu em FormFte/FormUfs/Formpgr no sweep do Erro152). Identificar o container pelo par BackColor=RGB(100,100,100) + Height>=60 criado direto na pagina.
- **Column.AddObject NAO faz o controle aparecer - falta o Column.CurrentControl**: adicionar um OptionGroup/CheckBox/ComboBox/Spinner a uma Column de Grid cria o objeto, mas a coluna continua desenhando o Text1 dela. O controle existe, responde a PEMSTATUS e nunca aparece na tela: o usuario ve o valor cru numa caixa de texto e nao tem como marcar nada. Quem escolhe o controle que a coluna desenha eh `Column.CurrentControl` (default "Text1"), e ele tem de receber o NOME exato passado ao AddObject, logo depois de configurar o controle: `.Column3.CurrentControl = "opt_4c_Tipos"`. Vem sempre acompanhado de `.Column3.Sparse = .F.` (sem isso o controle so aparece na linha ativa) e de `.Column3.ReadOnly = .F.` quando o usuario precisa editar - lembrando que o ReadOnly da COLUNA tem de ser definido DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve. Auto-fix: CorretorAutomatico #198. Bug observado em FormCco.prg (2026-09-10, Erro158): o OptionGroup Inserir/Excluir/Nenhum da coluna Tipo foi criado na migracao e nunca apareceu, entao nao havia como cadastrar o motivo.
- **MaxLength do TextBox vem da LARGURA DA COLUNA no schema, NUNCA do Width em pixels**: o migrador tende a copiar o Width do controle para o MaxLength, o que produz numeros absurdos e silenciosos - em FormCco o campo Codigo ficou `.Width = 80` / `.MaxLength = 80` e a Descricao `.Width = 220` / `.MaxLength = 220`, quando as duas colunas sao `char(30)`. O usuario digita mais do que cabe, o SQL Server recusa o INSERT com "String or binary data would be truncated" e a tela nao grava. Conferir cada TextBox contra `docs\schema.sql` (lendo com `Get-Content -Raw`, que eh UTF-16) e usar a largura da coluna; o LEFT() do INSERT/UPDATE no BO tem de usar o MESMO numero. Sinal de alerta imediato: `MaxLength` igual ao `Width`. WARNING: CorretorAutomatico #199. Bug observado em FormCco.prg (2026-09-10, Erro158).
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
- **Form WRAPPER de VCX: copiar TAMBEM o Left/Top dos filhos DIRETOS do container, nao so os das paginas**: controle que fica FORA da area do pai eh RECORTADO pelo Container - some da tela **sem erro, sem log e SEM APARECER EM SCREENSHOT**, entao nenhuma validacao visual do pipeline enxerga. No FormCliente os tres CommandGroup que trocam de aba (`cmdGCarac`/`cmdGFtec`/`cmdgpessoal`) ficaram no Left/Top da CLASSE do VCX (891..957, Top 540) porque o migrador so copiou os overrides do SCX dos controles das PAGINAS; como o `cnt_4c_Conta` tem `Width = 768` / `Height = 450` (fiel ao legado), os tres cairam fora e sumiram - o usuario entrava na aba de endereco e **nao tinha como voltar para a aba 1**, so restava Salvar. O SCX declarava `633,397` / `672,397` / `711,397`. Ao migrar wrapper, varrer no dump do SCX as linhas de UM ponto so (`^  nome.Left` / `^  nome.Top` - filho direto do container) e aplicar TODAS; as de varios pontos sao das paginas. Conferir `Left + Width <= pai.Width` e `Top + Height <= pai.Height`. Ignorar nome generico (`Command1`, `Option2`, `Text1`...): sao membros internos de CommandGroup/OptionGroup, posicionados pelo VFP
- **SCX que desloca um controle e NAO desloca o label vizinho: sobreposicao HERDADA, que comparar migrado x legado nunca pega**: quando o SCX sobrepoe o Left de um campo mas deixa o label/campo ao lado no Left da CLASSE, os dois se cruzam na tela. No FormCliente o SCX move getUFIBGE de 471 para 508 e nao move o label "Contato :" (518), que entra 15px DENTRO da caixa: a tela mostra "35ontato :". Copiar o SCX fielmente REPRODUZ o defeito, e toda validacao migrado-x-legado aprova, porque os dois concordam. Ao transcrever `.Left`, somar `Left + Width` do controle e conferir contra o `Left` do vizinho da MESMA linha (mesmo Top, +-6px) DENTRO DO MESMO CONTAINER - Left/Top sao relativos ao pai, comparar entre containers nao significa nada. Havendo cruzamento, preferir os valores da CLASSE (framework.vcx), que sao coerentes entre si, a inventar posicao nova; e registrar o desvio em comentario. Caso especial: controle que cabe INTEIRO dentro de outro fica inalcancavel ao clique (Get_Regiao 596..676 dentro de Get_Contato 565..717) - no legado esse campo costuma estar aposentado (linhas de Visible/obrigatoriedade COMENTADAS no VCX); esconder eh melhor que deixar soterrado. Label sem `.Width` eh AutoSize (classe say): a faixa real dele eh a do TEXTO, nao a da caixa (#23)
- **Metodo de VCX legado que o SCX sobrescreve SO para consertar layout: reaplicar no FUNIL de chamadas, nunca so no Init**: o p-code do VCX refaz o layout dele a CADA chamada. O mLeDados do clsconta termina com `.Top = Iif(.Tabs, 0, ThisForm.Height - This.PgframeDados.PageHeight)` e re-ancora os tres CommandGroup de navegacao com `.Top = (This.Height - .Height - 4)`. Medido: clsconta.pgframeDados.Height = 802 contra Form.Height = 600, entao com pcTpCadCli='1' o Top vira -198, a pagina 1 SOBE 195px e o container RECORTA o topo dela - o usuario clica Incluir e cai direto no bloco de endereco/contato (GetCEP.Top = 200 no SCX), sem Codigo/Nome/CPF na tela, sem erro, sem log e SEM APARECER EM SCREENSHOT. O SCX legado conserta com um override do PROPRIO metodo, que roda DEPOIS do DoDefault (DoDefault(...) seguido de thisform.cntConta.pgframeDados.Top = 0). Como o migrado instancia o VCX por AddObject e nao tem subclasse onde por o override, esse ajuste tem de rodar no FUNIL de chamadas do metodo (o wrapper Chamar<Metodo>Seguro) e tambem nos CATCH que engolem excecao - aplicar so no InicializarForm NAO adianta, porque o metodo roda de novo em TODO Incluir/Alterar/Visualizar. Ao migrar wrapper, procurar no dump do SCX uma PROCEDURE homonima de metodo do VCX: ela existe justamente para corrigir o que o p-code faz
- **PageFrame.ActivePage eh o PageOrder, NAO a ordem de declaracao das Pages**: no clsconta, pgframeDados1 (Cadastro) tem PageOrder=1, pgframeDados2 (Pessoal) tem PageOrder=**3** e pgframeDados7 (Complemento) tem PageOrder=**2**. O migrado fazia `ActivePage = 2` achando que ia para Pessoal e caia em Complemento; pior, o `cmdPessoal.Click` do VCX so age com ActivePage 1 ou 3 (`Case ActivePage==1 -> ActivePage = 3` / `Case ActivePage==3 -> ActivePage = 1`), entao depois disso ele ficava MORTO e o F5 nao fazia mais nada. Compila limpo, so aparece na tela. Nunca derivar ActivePage do sufixo do nome da Page - ler o PageOrder da CLASSE. E quando o legado navega chamando o Click de um botao (o KeyPress do SCX chama `cmdGPessoal.cmdPessoal.Click()` e MAIS NADA), TRANSCREVER isso: nao pre-setar ActivePage antes de delegar, senao o toggle do VCX perde a referencia e vira no-op
- **Membro INTERNO de CommandGroup/OptionGroup com NOME PROPRIO: aplicar os overrides do SCX (excecao da regra do nome generico)**: ignorar `Command1`/`Option2`/`Text1` continua certo, mas quando o membro tem nome proprio e o SCX declara geometria para ele (`cmdGCarac.cmdCarac.Top/Left/Height/Width/Picture/...`), esses overrides sao OBRIGATORIOS - o grupo eh AutoSize=.T. e eh a geometria do botao INTERNO que DEFINE a altura do grupo. Medido no VFP9: inner 32x32 em 5,5 (classe) da grupo de 42; inner 40x40 em 5,5 (SCX) da grupo de 50 - e so com 50 o `.Top = (Height - .Height - 4)` do mLeDados cai em 396, que eh o mesmo 397 que o SCX declara no grupo. Copiar so o Left/Top do GRUPO deixa os tres botoes menores e fora da linha desenhada pelo legado. Para ler as propriedades REAIS de uma classe de VCX (o .VCT eh p-code e grep devolve lixo), abrir a .vcx como DBF no proprio VFP9 e ler a coluna Properties: USE framework\classresp.vcx + SCAN por ObjName/Class
- **Wrapper de funcao global do legado tem de reproduzir o CONTRATO, nao so o nome**: redirecionar para a primitiva VFP de nome parecido NAO basta. `IsEmpty` do Fortyus nao eh `EMPTY` do VFP - medido: `EMPTY(.NULL.)` devolve `.F.`, isto eh, "nao esta vazio", enquanto o `IsEmpty` do legado trata NULL como vazio. O wrapper `utils\isempty.prg` fazia so `RETURN EMPTY(par_uValor)` e divergia exatamente no caso NULL, em 142 call sites do p-code. O sintoma aparece LONGE da causa e sem erro nenhum: o `mRetiraNull` do clsconta limpa nulos com `Update crSigCdCli Set Obs = "" Where IsEmpty(Obs)`, o WHERE nao casava, a linha nunca era limpa e o campo Obs. do Cadastro de Cliente exibia `.NULL.` na tela. Conserto: guarda de NULL ANTES de delegar, com IF separado e nao `ISNULL(x) OR EMPTY(x)` - VFP9 nao faz short-circuit em OR. Ao escrever ou revisar wrapper em `utils\`, testar explicitamente NULL, vazio, zero, `.F.` e argumento AUSENTE, e conferir contra o que os call sites do p-code esperam; vale para qualquer coluna que venha do SQL Server permitindo NULL. Delegacao com guarda de tipo eh o padrao certo (ver fvalidarcpf.prg / fvalidarcnpj.prg, que checam VARTYPE antes de delegar)
- **Form WRAPPER de VCX: auditar as properties de ThisForm que o p-code toca, e separar as que o VCX cria sozinho das que nao**: o p-code chama ThisForm.<x> em dezenas de pontos, e para a maioria ele mesmo se vira, com o par guarda + `AddProperty` (If Type('ThisForm.OldEmpresa') == 'U' -> ThisForm.AddProperty('OldEmpresa', ...)). Essas NUNCA dao erro e nao precisam ser declaradas no form. As que aparecem CRUAS, sem esse par, sao exatamente as que estouram em runtime: no `clsconta` sao 18 properties customizadas, 17 auto-criadas e UMA nao - `AlterouLgpd`, que fazia gravar uma ALTERACAO no Cadastro de Cliente estourar "Erro 1734: Property ALTEROULGPD is not found" dentro do mGravaDados. Varrer assim: abrir a .vcx como DBF no VFP9 e dumpar a coluna `Methods` SO dos registros cujo Parent+ObjName contem o nome da classe (grepar o .VCT inteiro mistura TODAS as classes do arquivo e traz lixo do p-code), extrair ThisForm.<x> desse dump, descontar as nativas de Form (Name, LockScreen, Height, BackColor, DataSessionId, Refresh, AddProperty) e cruzar com o que o .prg migrado ja declara. Property de OBJETO do legado que o migrado nao tem (ThisForm.Pagina, o PageFrame do frmcadastro) so eh segura se TODO uso estiver dentro de If Type('...')=='O' - conferir, nao presumir. Antes de declarar, conferir tambem que os CURSORES do bloco recem-habilitado existem, senao troca-se um erro por outro. E declarar NAO basta quando o ciclo de vida difere: o legado eh modal e vive UM registro, o migrado nao fecha entre um e outro, entao flag de sessao tem de ser RESETADO no funil de chamadas - sem isso o primeiro registro em que alguem tocar no consentimento deixa `AlterouLgpd` ligado para sempre e todo ALTERAR seguinte grava historico de LGPD FALSO. Auditoria: automation\VerificarPropsThisFormVCX.ps1
- **Funcao GLOBAL do legado Fortyus chamada pelo p-code do VCX: criar WRAPPER em utils\, NUNCA deixar faltando**: os VCX (framework.vcx / classobj.vcx / classresp.vcx) chamam funcoes da aplicacao legado (sig.prg / SIGFUNCS.PRG) que NAO vieram no acervo - fSQLExec, fChkCpoVlc, fChkCntVlc, fGravarLog, fValidarCpf, fValidarCNPJ, fAbrirTabs, fVerificaPasta, fMensagemFixa, fInibirBtn, fGerPDFCreator, fConfigGeral. O p-code esta COMPILADO e nao da para editar: o VFP procura <nome>.prg no PATH e so estoura em RUNTIME, dentro de Init/Valid/Click FORA de qualquer TRY/CATCH -> o form FECHA (Erro163_Aba1: digitar a UF no Cadastro de Cliente fechava a tela porque GetEstado.Valid faz CreateObject('fwBuscaExt',...) SEM o guard Type()=='O' que o GetCEP tem, e o Init do fwBuscaExt chama fSQLExec). O wrapper vai em projeto\app\utils\<nome minusculo>.prg no padrao de isempty.prg: LPARAMETERS + RETURN, SEM cabecalho FUNCTION - o arquivo eh resolvido pelo NOME. Auditar com automation\VerificarFuncoesLegadoVCX.ps1. NUNCA criar stub que devolve VALOR DE CALCULO (fCalcularST / fCalcularIPI): devolver 0 grava imposto errado em silencio (regra #17) - ausente eh mais seguro, porque o erro aparece alto. Vale igual para OBJETO global: goSistema.ObjectConn (cOpenConn, classes\sigclcnx.PRG) tem de existir, senao CreateObject('fSqlConector','cep') devolve pnIdConn = -1 e o VCX exibe "Impossivel Efetuar Conexao Com o Servidor de Banco de Dados..."
- **SET PATH TO com varias expressoes entre parenteses honra SO a PRIMEIRA**: SET PATH TO (a), (b), (c) faz o VFP9 usar so (a) e descartar o resto EM SILENCIO - sem erro de compilacao nem de runtime. Concatenar numa string unica: SET PATH TO (a + "," + b + "," + c). Eh especifico do SET PATH - SET PROCEDURE e SET CLASSLIB com varias expressoes entre parenteses funcionam normalmente. Sintoma tipico e distante da causa: .prg que EXISTE aparecendo como "File does not exist" (foi assim que isempty.prg dos VCX legado ficou inalcancavel); diante disso, medir SET("PATH") ANTES de mexer no arquivo
- **Propriedade que a CLASSE NAO TEM compila limpo e a TELA NAO ABRE**: atribuir .Prop a controle cuja classe base nao tem Prop nao eh erro de compilacao - estoura no Init, dentro do TRY, com "Property FORECOLOR is not found", e o usuario clica no menu e nada abre. Medido no VFP9: OptionGroup e CommandGroup NAO tem ForeColor (so BackColor); PageFrame nao tem ForeColor, BackColor nem BackStyle; ListBox nao tem ForeColor/BackColor (sao ItemForeColor/ItemBackColor); Shape nao tem ForeColor (sao BorderColor/FillColor) nem ShapeType (isso eh VB; no VFP eh Curvature); ZOrderSet nao existe em runtime em classe nenhuma (eh bookkeeping do Form Designer, gravado no SCX - remover, pois o equivalente eh o METODO ZOrder()). A cor de grupo mora nos MEMBROS e o SCX legado JA declara assim (Option1.ForeColor = 255,0,0) - transcrever o dump, e conferir se os OUTROS botoes do form nao perderam o ForeColor que o legado declara. Cuidado tambem com WITH aninhado, que sequestra o escopo e da o mesmo erro: dentro de WITH THIS.this_oBusinessObject, um WITH THIS.cnt_X faz .this_nProp (property do BO) resolver contra o Container. Auditoria: automation\VerificarPropriedadesInexistentes.ps1
- **`Controls` eh indexado por NUMERO - passar o NOME faz a tela nao abrir**: `Controls` eh array, nao colecao por chave. Medido no VFP9: `Controls("nome")` em expressao estoura "Invalid subscript reference" e, dentro de `WITH`, "CONTROLS is not an object" - compila limpo e so quebra no Init. O `PEMSTATUS(obj, "nome", 5)` que costuma cercar esses blocos devolve .T. e NAO protege (mesma armadilha da regra do BINDEVENT/metodo PROTECTED). Para alcancar membro por NOME: `EVALUATE("obj." + nome + ".Prop")` na LEITURA e `STORE valor TO ("obj." + nome + ".Prop")` na ATRIBUICAO; `WITH EVALUATE("obj." + nome)` tambem funciona. Se o que se quer eh o INDICE, escrever helper nome->indice varrendo ControlCount. `Controls(N)` numerico continua certo e eh o uso majoritario
- **A pagina LISTA segue o `Init` legado, nao o SCX desenhado**: (a) o filtro eh aplicado SEMPRE, inclusive VAZIO - o legado liga a grade a `Select * From X Where Col = ?m.pcVar` com a variavel vazia no Init, entao a Lista abre VAZIA de proposito; `IF !EMPTY(filtro)` caindo em `Buscar("")` traz a TABELA INTEIRA. (b) a grade espelha o `pColuna` do `AddCursor` (nome, caption e largura de cada coluna), NAO os headers desenhados no SCX - no Formgpd o SCX tinha 3 colunas e o pColuna tem 4, e a coluna que faltava tambem faltava no SELECT do BO. (c) `Column.Width` vai por ULTIMO: mexer em RecordSource/ControlSource e na fonte do Grid faz o VFP recalcular tudo para o default 90
- **Campo de filtro da Lista tem os DOIS eventos do legado**: tipicamente `Valid` (se o codigo digitado nao existe, abre o picker; ESC limpa o campo) e `LostFocus` (recarrega a grade ao SAIR do campo, nao so no Enter). Migrar so o KeyPress com Enter faz o campo "nao trazer nada". Como BINDEVENT em "Valid" nao dispara de forma confiavel em TextBox, implementar as duas coisas no handler de LostFocus
- **`FormBuscaAuxiliar`: o 1o argumento eh o HANDLE da conexao**: a assinatura eh Init(par_nConn, par_cTabela, par_cCursor, par_cCampo, par_cValor, par_cTitulo, par_lBuscaExata, par_lMostraGrid, par_cFiltro) e o Init faz `SQLEXEC(par_nConn, ...)`. Passar a tabela (ou um cursor, ou um SELECT) no lugar de gnConnHandle desloca TODOS os argumentos e a consulta nunca acontece - o picker abre VAZIO, sem erro nenhum, porque o Init tem `IF VARTYPE(par_cTabela) != "C" / RETURN .T.`. Auditoria: automation\VerificarFormBuscaAuxiliar.ps1
- **`FormBuscaAuxiliar` tem CONTRATO - `this_lAchouRegistro` antes do `Show()`**: o Init ja tenta o match EXATO e, achando 1 registro, marca this_lAchouRegistro e this_lSelecionou - o valor esta resolvido e o picker NAO deve ser mostrado. Padrao canonico (137 arquivos): `IF !loc_oBusca.this_lAchouRegistro` envolvendo mAddColuna+Show, e a atribuicao SO dentro de `IF loc_oBusca.this_lSelecionou AND USED(<cursor>)`. Os dois erros andam juntos: Show desguardado abre o dialogo por cima da tela ja preenchida; atribuir o valor FORA da guarda (tipico `<controle>.Value = loc_cCodigo` no FIM do metodo) ZERA o campo quando nada foi escolhido, e o filtro/grade que dependia dele esvazia. NAO duplicar a checagem de existencia com um SQLEXEC proprio antes do picker: o Init ja faz isso
- **`.Self` NAO existe em VFP9 - dentro de `WITH`, repetir a expressao**: `Self` eh de Delphi/Object Pascal; o objeto VFP nao tem essa propriedade e dentro de um bloco WITH nao ha como referenciar o proprio objeto com ponto. Medido: `WITH obj` + `PEMSTATUS(.Self, "x", 5)` estoura **"Property SELF is not found"**, e `PEMSTATUS(obj, "Self", 5)` devolve .F. O correto eh repetir a expressao do WITH: `PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)`. COMPILA LIMPO e so quebra em RUNTIME
- **Pagina preenchida por DOIS metodos: se um esquecer o +29, a aba fica com texto sobre texto**: quando `ConfigurarAba<X>` e `ConfigurarPgpg<X>` preenchem a MESMA `pgf_4c_Divisoes.PageN`, basta um deles transcrever o Top CRU do SCX (sem a compensacao do `pgf_4c_Paginas.Top = -29`) para os controles dele cairem ~29px acima e pousarem sobre o que o outro ja desenhou. NAO ha erro nem log - so a aba desformatada. Medido no Formgpd: o ConfigurarPgpgConfig tinha 67 dos 83 controles com o Top cru. Ao escrever QUALQUER metodo Configurar*, conferir que TODO Top recebeu o +29, e que o comentario de origem cita o controle certo do dump
- **Migrador lendo o controle ERRADO no dump**: tres defeitos da mesma origem no Erro175 - (a) `Tptribs` recebeu o Top do `Get_CodServs` (409) em vez do `Get_TpTrib` (385), e as duas linhas viraram uma so; (b) `Obrigfiscs` foi para Left=440 quando o legado tem Left=176, parando do outro lado da tela sobre outro bloco; (c) label DUPLICADO - o ConfigurarAba* inventou um label ("Obrig. Fiscal :") para uma linha cujo label o ConfigurarPgpg* ja criava a partir do legado ("Class. Fiscal Obrigatoria :"). Ao achar dois labels na mesma linha, conferir qual existe no SCX: o legado tem UM
- **NAO existe deteccao automatica de offset/sobreposicao comparando com o legado**: tentado duas vezes e medido - varrendo o projeto contra o layout.json inteiro deu 4220 achados em ~230 forms (quase tudo falso positivo, inclusive num form ja corrigido); a versao dirigida por metodo+pagina acusou 49 num metodo recem-corrigido e 18 num que estava certo. A raiz eh a mesma do detector de "controle fora da area do pai": o PILAR 3 manda RENOMEAR os objetos, entao casar migrado com legado so resta por geometria, e sempre aparece um sosia. Serve para diagnosticar UM caso conhecido, nao para validar em massa nem para confirmar o conserto - o conserto se confere instanciando e olhando a tela
- **`Program Error` CRU do VFP em vez do dialogo do projeto = metodo SEM TRY/CATCH**: quando o erro aparece na janelinha "Program Error" do proprio VFP (Cancel/Suspend/Ignore/Help) e nao no MostrarErro/FormErro do sistema, o metodo que estourou nao tem TRY/CATCH. Usar isso para localizar: procurar o metodo sem TRY/CATCH no caminho do botao que o usuario acionou (no Erro174 era BtnIncluirClick -> AjustarBotoesPorModo)
- **Abrir form MODAL de dentro de `LostFocus` pede guarda de reentrancia**: o Show() bloqueia, o foco sai e volta, e o proprio LostFocus pode disparar de novo, empilhando um segundo picker. Usar property booleana no form, setada na entrada e limpa DEPOIS do ENDTRY (para valer tambem quando o CATCH dispara). Diagnostico barato: num teste headless, Show() de form modal TRAVA a execucao - se o script termina dentro do timeout, o picker nao abriu
- **Init de form grande falha em CADEIA - "a tela abre" so se prova INSTANCIANDO**: cada defeito no Init esconde o proximo. Antes de dar por pronto, instanciar de verdade (CREATEOBJECT com gb_4c_ModoTeste/gb_4c_ValidandoUI) e repetir ate passar. Tres defeitos tipicos, cada um so visivel depois do anterior: (a) `Controls(<nome>)`; (b) `.ColumnN.Check1.<prop>` sem `AddObject`+`CurrentControl` -> "Unknown member CHECK1", porque a Column nasce so com Header1/Text1; (c) metodo CHAMADO mas nunca GERADO -> "Property X is not found", que pode significar uma ABA INTEIRA perdida (no Formgpd eram 71 controles). Auditar todo `THIS.<membro>` contra o proprio form E a heranca de FormBase/BusinessBase/GridBase. Ao reconectar aba perdida, conferir o TIPO da property no BO: coluna `numeric(1,0)` MULTI-VALOR achatada em LOGICO com `(col = 1)` faz valores 2..7 lerem .F. e regravarem 0 - converter para numerico ANTES de mapear
- **Icone: TRANSCREVER o Picture do legado, NUNCA inventar o nome do arquivo**: o VFP9 aceita .Picture/.Icon apontando para arquivo inexistente SEM erro nenhum (nem compilacao, nem runtime, nem log) - o controle so nao desenha icone. Copiar o Picture do controle correspondente no dump do legado e conferir que o arquivo existe em vbmp\. NAO escolher icone por semelhanca semantica: no FormBAL o botao "Fecha" usa cadastro_salvar_60.jpg (fechar a contagem = gravar) e no FormSigPrGlp "Disponiveis" usa geral_palete_60.jpg, nao uma lupa. Atencao: o arquivo real eh cadastro_vizualizar_60.jpg (com Z) e o sufixo _26/_60 NAO eh o tamanho (todos os icones sao 32x32)
- **Format contendo "M" = multiple choice, e o InputMask eh a LISTA de valores validos**: se o SCX legado declara Format = "M" ou "KM", o InputMask NAO eh mascara de digitacao e sim a lista separada por virgula (",T,S,I,N,F", "S,N", "A,B", "0,1", "S,N, "). TRANSCREVER o par LITERALMENTE do dump - trocar o M por "!" ou descartar o InputMask compila limpo e faz o campo aceitar QUALQUER caractere. Lista SEM item vazio coage branco para o 1o item (e o comportamento do legado)
- NUNCA RETURN dentro de TRY/CATCH - inclui o RETURN BARE de guarda (sem valor), e vale no bloco TRY, no CATCH e no FINALLY. Fix: flag `loc_lProsseguir = .F.` no lugar do RETURN + envolver o resto do bloco em `IF loc_lProsseguir ... ENDIF` + RETURN unico DEPOIS do ENDTRY. So trocar o RETURN por atribuicao SEM envolver o resto descarta o early-exit e grava errado em silencio. `EXIT`/`LOOP` dentro do TRY sao seguros
- **TesteAutomatico.prg chama metodos direto no oForm (nao so BINDEVENT)**: CarregarLista/AlternarPagina/AjustarBotoesPorModo/BtnIncluirClick/BtnCancelarClick sao PUBLIC obrigatorio - PEMSTATUS retorna .T. mesmo se PROTECTED (so verifica existencia), a chamada real de fora da classe falha com "Property METODO is not found."
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
- **Comentario de design decision NUNCA leva a frase "nao implementado"**: ao documentar por que um BO somente-leitura (form de CONSULTA sem INSERT/UPDATE/DELETE no legado) nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao(), NAO escrever "nao implementado"/"nao implementada" dentro de linha de comentario `*` - o validador 05d_validarCompletude tem regex que casa "nao implement" em QUALQUER comentario (nao so em TODO real) e rejeita a fase por falso positivo. Preferir frase como "o comportamento padrao herdado de BusinessBase ja eh o correto".
- **Label de dados: NUNCA inventar ``.Width`` + ``.Alignment = 1``**: a classe ``say`` do Framework legado eh ``AutoSize = .T.`` / ``Alignment = 0`` â€” o ``Say`` do SCX declara so ``Caption``/``Left``/``Top``, e esse ``Left`` ja foi calculado para o texto terminar poucos pixels antes do campo (FormCES: 411/415/415/418 com os TextBox em 455, textos terminando em 451). Inventar ``.Width = 60`` + ``.Alignment = 1`` encosta o texto na borda DIREITA da caixa, que cai DENTRO do TextBox; como o label eh criado antes, o controle desenha por cima e a legenda sai cortada ("Codigo :" vira "Codi") â€” compila limpo, so aparece na tela. Copiar ``Alignment``/``Width`` do dump: se o ``Say`` nao declara nenhum dos dois, usar ``.Alignment = 0`` com ``.Width`` que caiba o texto. ``AutoSize = .T.`` NAO resolve: eh no-op em Label criado por ``AddObject`` (a Width fica nos 100 do default). Auto-fix: CorretorAutomatico #202.
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
- **CheckBox.Value NUNCA atribuir DIRETO a prop LOGICAL do BO (dispara "Data type mismatch" no AND)**: Em `FormParaBO`/`FormParaRelatorio`, SEMPRE converter numerico para logico ao atribuir chk.Value em property declarada `.F.`/`.T.`: `.this_lXXX = (loc_oCnt.chk_4c_XXX.Value = 1)` — NUNCA `.this_lXXX = loc_oCnt.chk_4c_XXX.Value`. Sem conversao, a property vira NUMERICA (0/1) e a proxima expressao `<logical> AND <this_lXXX>` no BO dispara **erro 9 "Data type mismatch"** (nao 1817 "Operator/operand type mismatch" como esperado — VFP9 mascara). Reciproca em BO: em condicoes AND, NUNCA escrever `AND <numeric_field>` — sempre `AND <numeric_field> <> 0`. Ex: `IF SEEK(x) AND crSigCdMoe.Cotas <> 0` (NAO `AND crSigCdMoe.Cotas`); `IF !EMPTY(Nops) AND THIS.this_lProdutos` FALHA se this_lProdutos veio numerico do chk. Regra critica correlata: CATCH em `PrepararDados`/`Processar`/`BtnVisualizarClick` SEMPRE incluir `loc_oErro.LineNo` + `loc_oErro.Procedure` na msg (`MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em <PROC>")`) para localizar erros VFP mascarados. Auto-fix: CorretorAutomatico #150. Bug em FormSigReAtm/FormBlq/Formsigregli/FormSIGRECTL (2026-07-28, Erro65).
- **fCarregarCambio() NAO PORTADA - usar THIS.CarregarCambio() local**: Funcao legada `fCarregarCambio(pMoe, pDia)` do framework Fortyus (SIGFUNCS.PRG:5156) NUNCA foi portada para `projeto/app/utils/functions.prg`. Todo BO que converta moeda DEVE implementar `PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_xData)` local usando cursores `crSigCdCot` + `crSigCdMoe` (ou `cursor_4c_SigCdCot`/`cursor_4c_SigCdMoe` conforme naming do proprio BO — confirmar em `InicializarDados`/`InicializarCursores`). Chamar via `THIS.CarregarCambio(...)`. Se BO ja tem `THIS.ObterCotacao` (padrao sigprilaBO), reusar em vez de duplicar. Template canonico do metodo em `SigReAtmBO.prg:857` ou `SigReInvBO.prg:205`. Chamada direta a `fCarregarCambio(...)` quebra em runtime — mas o erro NAO eh "File not found" como esperado: VFP9 mascara e dispara "Data type mismatch" via CATCH de PrepararDados. Auto-fix: CorretorAutomatico #151. Bug em SigReAtmBO/sigprccpBO/sigreeqeBO/sigprilaBO (2026-07-28, Erro65).
- **`VAL(SET("Decimals"))` PROIBIDO - `SET("Decimals")` ja retorna NUMERIC em VFP9**: A funcao `SET()` retorna tipos DIFERENTES conforme a opcao: `SET("Escape")`/`SET("Fixed")`/`SET("Century")`/`SET("Talk")`/`SET("Date")`/`SET("Path")`/`SET("Point")`/`SET("Separator")` retornam **CHARACTER** ("ON"/"OFF"/valor); mas `SET("Decimals")` e `SET("REPORTBEHAVIOR")` retornam **NUMERIC**. Envolver retorno numerico com `VAL()` dispara **VFP9 erro 11 "Function argument value, type, or count is invalid."** imediatamente. Bug tipico: migrador copia o padrao de salvar/restaurar contexto de outros SETs e por reflexo escreve `loc_nDec = VAL(SET("Decimals"))`. **CORRETO**: `loc_nDec = SET("Decimals")` (sem VAL); `loc_nBhv = SET("REPORTBEHAVIOR")` (sem VAL). Restaurar: `SET DECIMALS TO loc_nDec` / `SET REPORTBEHAVIOR loc_nBhv`. Auto-fix: CorretorAutomatico #152. Bug em sigrebalBO (2026-07-28, Erro66) — quebrava PrepararDados imediatamente ao clicar Visualizar.
- **REPORT `Visualizar`/`Imprimir` — `IF !PrepararDados() / flag=.F. / ENDIF / REPORT FORM` fall-through PROIBIDO**: quando `PrepararDados()` retorna `.F.` (cursor vazio, filtros sem match, erro SQL), o bloco `IF ! ... ENDIF` seta a flag mas NAO interrompe o fluxo — cai direto em `REPORT FORM` que roda com cursor vazio/erro. Sintomas: preview em branco, "File does not exist", ou pior — NENHUMA mensagem para o usuario (que espera "Nenhum registro encontrado..."). **VARIANTE DOUBLE-IF (Erro110)**: mesma armadilha com 2+ IFs consecutivas — `IF !PrepararDados() / flag=.F. / ENDIF / IF !MontarCabecalho() / flag=.F. / ENDIF / REPORT FORM` — ambos IFs fall-through, REPORT FORM sempre roda. **FIX MINIMO (auto)**: adicionar `RETURN loc_l<Flag>` dentro do ULTIMO IF antes do ENDIF (early exit). **FIX IDEAL (manual)**: refatorar para fluxo positivo com AND encadeado `IF THIS.PrepararDados() AND THIS.MontarCabecalho() / loc_lSucesso = THIS.ExecutarReportForm("<Base>", "PREVIEW"\|"PRINTER_PROMPT"\|"PRINTER", THIS.this_cCursorDados) / THIS.LimparCursores() / ELSE / IF !EMPTY(THIS.this_cMensagemErro) / MsgErro(THIS.this_cMensagemErro, "Erro") / ENDIF / ENDIF` — helper canonico traz cursor-empty guard (MsgAviso automatico "Nenhum registro encontrado com os filtros informados."), FRX-existence check, locale isolation e menu restore. Template do helper em SigReAtmBO.prg:857 ou SigReCgcBO.prg (pos-Erro68) ou sigrecprBO.prg (pos-Erro110). Auto-fix: CorretorAutomatico #153 (minimo, agora cobre variante double-IF) + WARNING para refactor completo. Bug em sigrecheBO/sigredcoBO/SIGREDIRBO/SigReFtpBO (2026-07-28, Erro68); sigrecprBO/sigrechpBO (2026-08-12, Erro110 double-IF).
- **REPORT `PrepararDados` — `loc_lSucesso = .T.` INCONDICIONAL apos IF de erro PROIBIDO**: NUNCA escrever `IF loc_nResult < 0 / loc_lSucesso = .F. / ENDIF / SELECT (cursor) / GO TOP / loc_lSucesso = .T.` — a atribuicao final SOBRESCREVE o `.F.` setado no error branch. PrepararDados sempre retorna `.T.` mesmo com SQL error, e Visualizar/Imprimir chegam ao REPORT FORM com cursor invalido. **FIX**: envolver o success-path em ELSE explicito: `IF loc_nResult < 0 / loc_lSucesso = .F. / ELSE / SELECT (cursor) / GO TOP / loc_lSucesso = .T. / ENDIF`. Pattern correlato do fall-through Erro68/Erro110: garante que `PrepararDados` retorne `.F.` quando devido. Auto-fix: CorretorAutomatico #164 (WARNING-only — refactor exige contexto). Bug em sigreifxBO/SigReInfBO/SIGREIPSBO (2026-08-12, Erro110).
- **`IF !FILE(loc_cFrx)` bloco morto em REPORT `Visualizar`/`Imprimir` PROIBIDO**: template legado deixava `IF !FILE(loc_cFrx) / MsgErro/MsgAviso / loc_lXxx = .F. / ENDIF` DEPOIS do `IF !PrepararDados()` e ANTES de `THIS.ExecutarReportForm(...)`, com `loc_cFrx` declarado `LOCAL` mas NUNCA atribuido. VFP inicializa LOCAL como `.F.` (logical), logo `FILE(.F.)` dispara **VFP9 erro 11 "Function argument value, type, or count is invalid."** ao clicar Visualizar. NUNCA gerar esse bloco — o helper `THIS.ExecutarReportForm(...)` (Pattern #117) ja faz `FULLPATH + FILE + MostrarErro` descritivo. Template correto (fluxo positivo): `IF THIS.PrepararDados() / loc_lSucesso = THIS.ExecutarReportForm("<Base>", "PREVIEW"\|"PRINTER_PROMPT"\|"PRINTER", "<cursor>") / ENDIF` — sem qualquer referencia a `loc_cFrx`. Auto-fix: CorretorAutomatico #157 remove bloco morto quando (a) BO herda RelatorioBase, (b) `loc_cFrx` nunca eh atribuido, (c) bloco eh seguido de `ExecutarReportForm` em ate 5 linhas; Shape B (IF-ELSE) emite `WARN-157-IF-ELSE` (manual). Bug em Formsigrecmm sigrecmmBO + sweep afetou sigreimcBO/sigrehtcBO/SigReInvBO/sigrecgrBO (2026-08-05, Erro89).
- **REPORT `ConfigurarPaginaLista` — SEMPRE subtrair `PageFrame.Top` dos Tops absolutos legado**: Forms REPORT embrulham controles de filtro em `pgf_4c_Paginas.Page1`, com `PageFrame.Top = 85` (logo abaixo do cabecalho cinza). Controles adicionados via `loc_oPag.AddObject(...)` na Page usam coordenadas **RELATIVAS a Page1** — portanto os Tops legado (absolutos no form original) DEVEM ser subtraidos pelo `PageFrame.Top` na fase 4. Formula: `control.Top = layout.originalTop - PageFrame.Top`. **REGRA**: apos ler o Top do layout.json, aplicar a subtracao antes de gravar em `.Top =`. Excecoes que NAO subtraem: (a) `Buttons(N)` INTERNOS a OptionGroup/CommandGroup (relativos ao grupo, nao ao Page); (b) proprio Top do PageFrame em `ConfigurarPageFrame`. Sim subtraem: labels, textboxes, containers, o proprio Top do OptionGroup/CommandGroup. Sintomas de nao subtrair: layout inteiro empurrado N pixels pra baixo; ultimos controles (ex: OptionGroups no fim) ficam alem de `form.Height` e sao cortados; labels/textboxes desalinhados por rebordo do form. Referencia canonica CORRETA: `Formsigrecrf.prg` (task066) — comentario `"Posicoes top = original - 85 (PageFrame.Top=85)"` + valores subtraidos. Auto-fix: CorretorAutomatico #165 WARNING-only (parse regex nao distingue nesting Buttons(N) sem AST — refactor manual). Bug em Formsigrecnt (2026-08-13, Erro113): 23 controles com Top absoluto legado apesar de PageFrame.Top=85; OptLocal.Top=265 e OptOrdem.Top=289 saltaram alem de form.Height=350 e ficaram cortados. Meta-licao: o proprio codigo do bug tinha o comentario `"Posicoes: layout.json original top - 85 (offset do PageFrame)"` MAS valores nao subtraidos — comentario correto, codigo errado.
- **FormBuscaAuxiliar Pattern B (Init com params) PROIBIDO — usar helper `THIS.AbrirLookupCanonico(...)` OU Pattern A manual**: `CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "Tabela", "cursor", "campo", valor, "titulo")` + `mAddColuna` + `Show()` (Pattern B — 2+ args no CREATEOBJECT) tem **3 defeitos**: (1) Init interno faz `WHERE campo='X'` + `LIKE 'X%'` — se AMBOS retornam 0 rows, FECHA o cursor e picker abre vazio; (2) FormBuscaAuxiliar herda `DataSession=1` (shared) — se form pai eh `DataSession=2` (private), USED() pos-Show retorna .F. no caller e selecao perde; (3) cursor scope isolado entre sessoes. **PREFERIDO**: usar helper `THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, par_cValorFiltro, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)` em FormBase.prg (encapsula Pattern A completo em 1 chamada). **FALLBACK MANUAL (Pattern A)**: (1) SQL no CALLER com `LIKE 'valor%'` em cod OR desc + fallback SHOW-ALL se 0 rows; (2) `CREATEOBJECT("FormBuscaAuxiliar")` SEM parametros; (3) `.DefinirCursor(cursor, "Cods", "Descs", "titulo")` com aliases `AS Cods`/`AS Descs` no SELECT; (4) `IF .Mostrar()` — ler `.cCodigoSelecionado` / `.cDescricaoSelecionada` (nao SELECT cursor); (5) `USE IN SELECT(cursor)` no final. Reciproca em `Validar<Campo>`: quando busca exata falha, NUNCA `MsgAviso("nao encontrado")+limpar campo` — chamar `THIS.AbrirBusca<X>()` direto (picker abre filtrado pelo prefixo tipado). Ref canonico: `Formsigrecrf.prg` (task066) — Pattern A original; `Formsigrecog.prg` (task059, pos-Erro114) — Pattern A recem-convertido; `FormBase.prg:AbrirLookupCanonico` (helper novo, 2026-08-13). Auto-fix: CorretorAutomatico #166 WARNING-only (nao muta — cada call tem tabela/campos/titulo especificos exigindo contexto). Bug em Formsigrecog (2026-08-13, Erro114): usuario digita "M" em vendedor+Enter, picker abre vazio pois `WHERE codigos='M'` e `LIKE 'M%'` ambos 0 rows. Sweep pendente: ~209 forms com ~500 chamadas Pattern B, incremental form-a-form conforme testado.
- **`STR(<coluna_char>, N)` PROIBIDO — dispara VFP9 erro 11**: colunas CHAR de tabelas Sig* (ex: `SigCdGpr.codigos` char(3), `SigCdGcr.codigos` char(10), `SigMvCab.Emps` char(3), `SigCdCli.iclis` char(10), `SigCdGrp.cgrus` char(3)) NUNCA devem ser envolvidas com `STR()`. VFP9 `STR()` exige NUMERIC first arg — passar char dispara **erro 11 "Function argument value, type, or count is invalid."** em runtime (LOCATE, INSERT, Value assignment). ERRADO: `ALLTRIM(STR(cursor_4c_X.codigos, 2))` / `LOCATE FOR ALLTRIM(STR(codigos, 5)) = ALLTRIM(loc_cCod)`. CORRETO: `ALLTRIM(cursor_4c_X.codigos)` / `LOCATE FOR ALLTRIM(codigos) == ALLTRIM(loc_cCod)`. **REGRA GENERICA**: SEMPRE consultar schema.sql antes de escrever `STR(<coluna>)` — se a coluna eh char, remover o STR. Colunas char comuns: `codigos`, `cgrus`, `cemps`, `iclis`, `cpros`, `cunis`, `dopes`, `grupos`, `classes`, `emps`, `razas`, `descs`, `descrs`, `rclis`. Auto-fix: CorretorAutomatico #158 (whitelist de colunas char via schema; regex `STR\(\s*(cursor\.)?<col>\s*,\s*\d+\s*\)` -> `<col>`; skip strings SQL detectadas por aspas/colchetes). Bug em FormSigReCmp ValidarGrdGrupoCod/AbrirBuscaGrdGrupo/ValidarGrdGrupoDesc — 6 sites (2026-08-05, Erro90-a).
- **`.InputMask = "##..#"` em TextBox `.Value = ""` (CHAR) PROIBIDO — bloqueia letras**: em VFP9, `#` no `InputMask` aceita APENAS digitos/espacos/sinais. Se a coluna do banco eh `char(N)` (que pode conter letras — ex: `SigCdGpr.codigos = 'A01'`), o usuario nao consegue digitar letras. Migrador copia InputMask numerico do legado sem checar tipo. **REGRA**: se `.Value = ""` (indica char), NUNCA usar `.InputMask = "#+"` — usar `.MaxLength = N` (limita tamanho sem restringir tipo). Se `.Value = 0` (indica numeric), manter `.InputMask = "###..."` OK. ERRADO: `WITH txt / .Value = "" / .InputMask = "##" / ENDWITH` sobre coluna char(3). CORRETO: `WITH txt / .Value = "" / .MaxLength = 3 / ENDWITH`. Auto-fix: CorretorAutomatico #159 detecta `.InputMask = "#+"` numa janela WITH com `.Value = ""` e substitui por `.MaxLength = <count-hashes>`; se .Value = 0 mantem; se ambiguo emite `WARN-159-INPUTMASK-AMBIGUO`. Bug em FormSigReCmp Grande Grupo txt_4c__cd_ggrupo (2026-08-05, Erro90-b).
- **`<Cursor>.<Coluna>` DEVE bater com SELECT list — nao prefixar por convencao**: BO faz `SELECT a.Emps FROM SigMvCab a INTO CURSOR CrSigMvCab`; depois referenciar `CrSigMvCab.Cemps` (com prefixo `C` invento por convencao Sig*Cd*) dispara **"Variable 'CEMPS' is not found."** ao runtime. VFP9 alias.coluna EXIGE que a coluna esteja no SELECT list literal — nao ha auto-prefixamento nem alias implicito. **REGRA**: apos escrever SELECT list, listar as colunas selecionadas e SEMPRE usar EXATAMENTE esses nomes ao referenciar `<Cursor>.<Col>`. Nunca "corrigir" o nome por padrao (Emps eh Emps, mesmo em tabela Sig*). Auto-fix: CorretorAutomatico #160 mapa cursores + colunas referenciadas + emite WARNING (nao muta — parse SQL fragil). Bug em SigReCmpBO.prg linhas 675 e 707: `CrSigMvCab.Cemps` vs SELECT `a.Emps` (2026-08-05, Erro91).
- **`SigMv*.emps` vs `SigCd*.cemps` — nomes DIFERENTES entre MOVIMENTO e MESTRE**: Coluna de empresa tem naming irregular entre tabelas. Tabelas MOVIMENTO (`SigMvCab`, `SigMvItn`, `SigMvNfi`, `SigMvPar`, `SigMvCcr`) usam `emps` (SEM prefixo C). Tabela MESTRE `SigCdEmp` usa `cemps` (COM prefixo C). JOIN CORRETO: `INNER JOIN SigCdEmp e ON e.cemps = a.emps` (onde `a` = SigMv*). Escrever `a.cemps` quando `a` = SigMv* dispara SQL Server **"Nome de coluna 'cemps' invalido"** ao clicar Visualizar/Imprimir. **REGRA**: SEMPRE consultar `docs/schema.sql` antes — nunca deduzir por convencao. IRREGULARIDADES conhecidas: `SIGFICHC` usa `emps` (apesar de prefixo Fi de master); `SIGFITEF` usa `cemps` (apesar de prefixo Fi de master). Colunas confirmadas: `SigMvCab.emps` linha 13180, `SigMvNfi.emps` linha 14464, `SigFiChc.emps` linha 11229, `SigCdEmp.cemps` linha 3111, `SigFiTef.cemps` linha 12098. Complementa Erro91 (invented C prefix em cursor) e Erro106 (WHERE `Emps` em SigCdPam single-row). Auto-fix: CorretorAutomatico #161 WARNING-only (parse fragil — muitos falsos positivos quando `a` = SigCdEmp legitimo). Bug em sigrecogBO.prg:211 + sweep sigrecsmBO/SIGREDIRBO/CecBO (2026-08-12, Erro108).
- **FRXs legados DEVEM ser copiados ao gerar BO REPORT**: BO REPORT que referencia FRX via `THIS.ExecutarReportForm("SigReXxx", ...)` ou `THIS.ObterNomeFRX()` retornando `"SigReXxx"` SOMENTE funciona se `SigReXxx.frx`+`.frt` existirem em `C:\4c\projeto\app\reports\`. Se ausentes, helper Pattern #117 exibe **"Arquivo de relatorio nao encontrado: C:\4C\PROJETO\APP\START\..\reports\SigReXxx.frx"** ao clicar Visualizar (path esta correto — o problema eh arquivo faltante). **REGRA**: apos gerar BO REPORT, extrair TODOS os nomes FRX referenciados (do `ExecutarReportForm` + todas as branches de `ObterNomeFRX`) e copiar `<Nome>.frx`+`<Nome>.frt` de `C:\4install\FortyusMC\Fortyus\` para `C:\4c\projeto\app\reports\` preservando o nome-case do BO (Windows FS eh case-insensitive). Ferramenta: `powershell -ExecutionPolicy Bypass -File C:\4c\automation\CopiarFRXsAusentes.ps1` (dry-run + auto-copia; retorna exit code 2 se algum FRX nao existe no legado). Bug em FormSigReCmp — SigReCp2.frx + SigReCp3.frx nunca portados (2026-08-05, Erro92).
- **IF THEN inline PROIBIDO**: VFP9 NAO suporta `IF cond THEN cmd` numa unica linha. Gera "Command contains unrecognized phrase/keyword." SEMPRE expandir para multi-linha: `IF cond` / `  cmd` / `ENDIF`.
- **COUNT TO var IN alias PROIBIDO**: VFP9 COUNT nao tem clausula IN. Gera "Command contains unrecognized phrase/keyword." Usar: `SELECT alias` + `COUNT TO var`.
- **APPEND FROM requer SELECT cursor antes**: `ZAP IN cursor_name` NAO muda a work area corrente. `APPEND FROM DBF("tmp")` vai para a work area CORRENTE. SEMPRE fazer `SELECT cursor_destino` antes de `APPEND FROM`. Sem isso, dados vao para o cursor errado e o grid fica vazio.
- **CommandGroup.FontName NAO EXISTE**: CommandGroup (como OptionGroup) NAO tem FontName/FontSize. Definir em cada `.Buttons(N).FontName`. Tentar no grupo causa "Property FONTNAME is not found" que cascateia e impede toda configuracao dos botoes.
- **AlternarPagina eh o FUNIL de volta - repor o MODO e reabilitar os botoes (Erro176)**: em forms CRUD, `AlternarPagina(1)` tem de fazer as DUAS coisas - `THIS.this_cModoAtual = "LISTA"` DENTRO do `IF par_nPagina = 1` e `THIS.AjustarBotoesPorModo()` no FIM do metodo. Quem so chama `AjustarBotoesPorModo` nos `Btn*Click` de ENTRADA (Incluir/Alterar/Visualizar) deixa os 5 botoes da Lista cinza depois de GRAVAR e depois de CANCELAR: nao estoura, nao entra em log, nao quebra compilacao (eh estado que ninguem restaura) e a tela fica inutilizavel ate ser fechada. Medido no VFP9 em 2026-09-24: so a chamada, sem repor o modo, NAO resolve (Formemp/Formsigpdmp7/FormSRV/FormDpi continuaram em `.F.`), porque a reabilitacao passa a depender de cada caller trocar o modo antes. Forma canonica: `THIS.pgf_4c_Paginas.ActivePage = par_nPagina` / `IF par_nPagina = 1` / `THIS.this_cModoAtual = "LISTA"` / `THIS.CarregarLista()` / `ENDIF` / `THIS.AjustarBotoesPorModo()`. Referencia: Formcfi, Formcnl, FormFNF, FormOcc. Gate: CorretorAutomatico pattern #210
- **Chave POSICIONAL concatenada: NUNCA ALLTRIM nas partes (Erro177)**: chave montada concatenando colunas ``char`` de largura fixa eh POSICIONAL - o padding FAZ PARTE da chave. O legado do SIGMVSBN monta ``lcEmpDopNums = TmpSubN.Emps + TmpSubN.Dopes + Str(TmpSubN.Numes, 6)`` SEM ALLTRIM, porque ``Emps`` eh ``char(3)`` e ``Dopes`` eh ``char(20)``: 3 + 20 + 6 = **29**, que eh exatamente ``EmpDopNums char(29)``. Escrever ``ALLTRIM(par_cEmps) + ALLTRIM(par_cDopes) + STR(par_nNumes, 6)`` da 15 caracteres (``001MALOTE     3``) e **nunca casa** com o valor gravado (``001MALOTE                   3``): o SELECT roda SEM ERRO e devolve ZERO linhas - sem exception, sem log, so a tela vazia (no FormSigMvSbn isso deixava a grade de itens, a descricao e a imagem do produto permanentemente vazias, e os handlers de AfterRowColChange/DblClick viravam codigo morto). Usar ``PADR(parte, <largura da coluna no schema>)`` EXPLICITO - nao confiar no padding que o cursor por acaso traz, porque ``ObterChavePrimaria()`` chama o mesmo montador com as properties do BO, que o ``Init`` do Form guarda JA com ALLTRIM. **A largura do ``char(N)`` destino eh a conferencia**: se a soma das partes nao da N, a montagem esta errada. ATENCAO a distincao ao varrer: ALLTRIM nas partes INTERIORES quebra, mas ALLTRIM na chave INTEIRA (no fim) eh inofensivo - ``char`` no SQL Server compara com blank-padding ANSI - e esse caso inofensivo eh o MAJORITARIO, entao tratar os dois igual produz WARNING massivo. **Instanciar o form NAO pega este defeito**: ``InicializarForm`` pula ``CarregarLista`` em ``gb_4c_ModoTeste`` e o TestFormWrapper passa com SUCESSO; num visualizador, o equivalente a "testar gravando" eh provar que a consulta devolve LINHA (conferir RECCOUNT, nao o retorno ``.T.``)

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
- **Left RELATIVO em botoes de container (Erro143)**: Dentro de `WITH .cmd_4c_Incluir/Visualizar/Alterar/Excluir/Buscar` (filhos de cnt_4c_Botoes), usar `.Left` RELATIVO ao container: Incluir=5, Visualizar=80, Alterar=155, Excluir=230, Buscar=305. NUNCA copiar o Left absoluto do container pai (542) para os botoes filhos — isso posiciona o botao em 542+542=1084, fora do form (Width=1000), INVISIVEL. Dentro de `WITH .cmd_4c_Encerrar` (filho de cnt_4c_Saida), usar `.Left=5` NUNCA `.Left=917`. Auto-fix: CorretorAutomatico #182.
- **Grid.ColumnCount NUNCA reatribuir em Carregar* (Erro144)**: Em VFP9, qualquer atribuicao a ColumnCount recria TODOS os objetos de coluna, destruindo controles AddObject (CheckBox/ComboBox). Definir ColumnCount APENAS em ConfigurarAba*/ConfigurarGrid* na inicializacao. Nos metodos Carregar*Aba/CarregarLista NAO reatribuir ColumnCount. Protecao: PEMSTATUS(grid.ColumnN, "controle", 5) antes de acessar controle AddObject'd. Warning: CorretorAutomatico #183.
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
- **FormBuscaAuxiliar par_cTabela = NOME PURO de tabela — NUNCA concatenar `" WHERE ..."`**: O 2o parametro do `CREATEOBJECT("FormBuscaAuxiliar", nConn, par_cTabela, ...)` deve ser apenas o nome da tabela (ex: `"SigCdCli"`). Concatenar `"SigCdCli" + " WHERE grupos = 'X'"` gera SQL final `SELECT * FROM SigCdCli WHERE grupos = 'X' WHERE CAST(Iclis...) = '1'` (duplo WHERE) → SQL Server retorna `Sintaxe incorreta proxima a palavra-chave 'WHERE'`. CORRETO: passar tabela pura no 2o param + condicao SEM prefixo WHERE no 9o param `par_cFiltro`: `CREATEOBJECT("FormBuscaAuxiliar", nConn, "SigCdCli", cursor, campo, valor, titulo, .F., .T., "grupos = " + EscaparSQL(loc_cGrupo))`. Helper interno concatena ` AND (par_cFiltro)` automaticamente. Auto-fix: CorretorAutomatico Pattern #154 (WARNING-only — refactor requer adicionar 3 params extras). Bug em Formsigrechp AbrirLookupDesConta/EmiConta (2026-08-04, Erro87).
- **SigCdCli NAO TEM coluna `grclis` — coluna de grupo eh `grupos` (char 10)**: A tabela `SigCdCli` (cadastro de clientes/contas) tem `grupos`, `grupocobs`, `grupomats`, `grupovens`, `grupocents`, `gruprods`, `grufals` — TODAS ausentes de `grclis`. `grclis` pertence a `SigChe`/`SigCqChm` (grupo do emitente do cheque). Bug tipico: gerador copia filtro de report legado (`AND b.grclis = ?` onde `b`=SigChe) para lookup de SigCdCli (`SELECT rClis FROM SigCdCli WHERE Iclis = ? AND grclis = ?`) — SQL Server retorna "Invalid column name 'grclis'" mascarado em CATCH silencioso. CORRETO: usar `grupos` em queries sobre SigCdCli. Reciproca: em SigChe/SigCqChm com alias, `grclis` (grupo emissor) e `grupos` (grupo destino) COEXISTEM e tem semanticas opostas — nao trocar. Regra generica: SEMPRE consultar `docs/schema.sql` (UTF-16 — usar `Get-Content -Encoding Unicode`) antes de escrever coluna de tabela Sig*. Auto-fix: CorretorAutomatico Pattern #155 (WARNING-only). Bug em Formsigrechp (2026-08-04, Erro87, 6 sites).
- **Path do FRX/reports: SEMPRE `gc_4c_CaminhoReports + "<Base>.frx"` — NUNCA `gc_4c_CaminhoBase + "reports\..."`**: `gc_4c_CaminhoBase = JUSTPATH(SYS(16))` retorna `C:\4c\projeto\app\start` **sem trailing backslash**. Concatenar `"reports\..."` produz `startreports\...` (path corrompido, FRX nao encontrado). `gc_4c_CaminhoReports` (config.prg:68) ja resolve `ADDBS(gc_4c_CaminhoBase) + "..\reports\"` — usar SEMPRE essa variavel. Analogo para XLS/PDF gerados em reports/: `gc_4c_CaminhoReports + "SigReXxx_" + DTOS(DATE()) + ".xls"`. Alias tambem proibido: `ADDBS(gc_4c_CaminhoBase) + "reports\"` (falta navegacao `..\` — gera `start\reports\` inexistente). Regra generica: usar sempre `gc_4c_CaminhoReports`/`gc_4c_CaminhoClasses`/`gc_4c_CaminhoUtils`/`gc_4c_CaminhoForms`/`gc_4c_CaminhoIcones` — NUNCA reconstruir a partir de `gc_4c_CaminhoBase`. Auto-fix: CorretorAutomatico Pattern #156 (auto-mutate regex-based). Se FRX legitimamente ausente em `projeto/app/reports/`, copiar `<Base>.frx` + `<Base>.frt` de `C:\4install\FortyusMC\Fortyus\` preservando o nome case original. Bug em sigrecmmBO/sigrehtcBO/SIGREFXVBO/FormSIGREFXV (2026-08-04, Erro88, 5 sites).
- **`ALLTRIM(<cursor>.<coluna_numeric>)` dispara VFP9 erro 11 — consultar schema.sql para tipo antes de remover `STR()`**: `ALLTRIM`/`EscaparSQL` exigem char first arg; concat direto `<numeric> + "string"` estora "Operator/operand type mismatch". Pattern #158 (auto-fix) remove `STR()` de `ALLTRIM(STR(<col>, N))` APENAS quando coluna eh CHAR (whitelist via `docs/schema.sql`); replicacao manual OU migracao de novo cursor DEVE consultar schema.sql antes. Exemplos criticos: `SigCdGpr.codigos = char(3)` (REMOVE STR) mas `SigCdTom.codigos = numeric(2,0)` (MANTEM STR — se remover, `ALLTRIM(numeric)` estora "Function argument value, type, or count is invalid." no `Init/InicializarDados` e o form NAO ABRE). Padrao CORRETO: `INSERT INTO cur (Descri) VALUES (ALLTRIM(STR(<cursor>.Codigos, 2)) + "-" + ALLTRIM(<cursor>.Descrs))`. Regra: se em duvida sobre tipo, MANTER STR — custo negligenciavel, sempre funciona. NAO automavel (WARNING-only — Pattern #158 whitelist ja cobre o caso comum; adicionar auto-fix reverso repete o proprio bug). Bug em SigReCmpBO.prg:124 (2026-08-06, Erro93) — commit "chore mudanca manual pos-sweep" replicou Pattern #158 sem checar schema.sql; sweep retroativo Erro93 corrigiu +3 BOs (`sigrefcxBO:230` concat direto numeric, `SIGREADSBO:174 e 371`, `sigreatoBO:238`). Meta-licao: commits "chore mudanca manual pos-sweep" que replicam auto-fix sem consultar schema.sql sao a fonte #1 de regressao.
- **ValidarPreAcao — textbox de filtro (`txt_4c_FiltroGrupo`/`txt_4c_FiltroX`) eh FONTE UNICA quando visivel na tela; NUNCA fallback silencioso para property `THIS.this_cX`**: Complemento critico do Pattern #173. Quando o filtro esta visivel (form em Lista ou aberto pelo menu com filtros CRUD), ler o textbox diretamente SEM fallback para propriedade guardada de estado anterior. Se textbox vazio → `MsgAviso("Grupo Obrigat" + CHR(243) + "rio. Preencha o Grupo de Contas antes de prosseguir.", "Aten" + CHR(231) + CHR(227) + "o")` + `<oFiltros>.<txt_filtro>.SetFocus()` + `RETURN .F.`. Se textbox tem valor mas nao existe no cursor de referencia (`crSigCdGcr`/`crSigCdCli`/etc): `MsgAviso("Grupo Inv" + CHR(225) + "lido: [" + loc_cGrupo + "] n" + CHR(227) + "o cadastrado.", ...)` + SetFocus + RETURN .F. Fallback para `THIS.this_cGrupo` → `crSigCdPam.GrPadClis` SO permitido quando textbox NAO existe (form aberto por programa via Init com `par_cGrupo`, sem UI de filtro). Bug: fallback silencioso para `this_cGrupo` mascarava intencao do usuario ao limpar o campo (Botao Incluir prosseguia sem validacao, gravando registros no grupo antigo em memoria). Regra correlata: wrapper `PROTECTED FUNCTION ChamarMLeDadosSeguro(par_cGrupo, par_cCli, par_cTpCadCli, par_cTpBloqCar, par_cMudaCpfCgc)` para TODAS chamadas a `THIS.cnt_4c_Conta.mLeDados(...)` — se `EMPTY(par_cGrupo) AND EMPTY(par_cCli)`, salva `THIS.pcEscolha` em local, seta `THIS.pcEscolha = "PROCURAR"` (ativa gate silencioso do clsconta.mLeDados linha 895: `If Empty(lcGrupo) And (ThisForm.pcEscolha <> 'PROCURAR') / = MessageBox('Grupo Invalido.', 0+48, 'Atencao!!!') / Return .f. / EndIf`), chama mLeDados, restaura pcEscolha. Ref canonico: `FormCliente.prg:1993-2054` (ValidarPreAcao com textbox como fonte unica) + `FormCliente.prg:2054-2088` (ChamarMLeDadosSeguro wrapper). Aplica-se a TODOS forms com filtros obrigatorios (Cadastros CRUD + Operacionais wrapper clsconta/similar). Auto-fix: CorretorAutomatico Pattern #174 WARNING-only (detecta `ValidarPreAcao` com bloco `IF EMPTY(loc_c<X>) / loc_c<X> = ALLTRIM(THIS.this_c<X>) / ENDIF` fallback silencioso; e chamada `THIS.cnt_4c_Conta.mLeDados(...)` fora de `ChamarMLeDadosSeguro`). Complementa Pattern #173. Bug em FormCliente 2026-08-25 (Erro136) — user limpa Grupo, clica Incluir, form prossegue sem msg gravando registro no grupo antigo em memoria.
- **TextBox S/N (Sim/Nao) `Format="M"` + `InputMask="S,N, "` OBRIGATORIOS — sem eles TextBox aceita qualquer char**: TextBox com `MaxLength=1` cuja label vizinha eh `(S/N)` (representa coluna char(1) semantica Sim/Nao) DEVE ter `Format = "M"` + `InputMask = "S,N, "` (lista fixa canonica VFP9). Sem esse par, campo aceita qualquer caractere (X/A/7/etc) e usuario grava valor invalido. `Format="M"` transforma TextBox em "multiple choice" que aceita apenas chars que iniciam algum item do InputMask csv-list — `S`/`N`/space passam, resto eh silenciosamente descartado. Legado sempre gera esse par (ex `sigcdcar_form_codigo_fonte.txt` `Get_senha`: `Format="M"` + `InputMask="S,N, "`). Migrador tende a gerar apenas `MaxLength=1` (limita tamanho, nao tipo). Auto-fix: CorretorAutomatico #175 detecta bloco `WITH ... TextBox / .MaxLength=1 / ... / ENDWITH` cuja Label irma seguinte tem `.Caption = "(S/N)"`, injeta `.Format = "M"` + `.InputMask = "S,N, "` antes do ENDWITH. Bug em FormCargo (Erro137 2026-09-01, task354 SigCdCar): 12 TextBoxes S/N aceitavam qualquer char (txt_4c_Nivels/Altcots/Limites/Cancitens/Libfpags/Libsdins/Libfpgs/Libopes/Libexprd/Fcomis/Libvmovdup/ConsSubn).
- **BO CRUD `Buscar()` — NUNCA `ZAP + APPEND FROM DBF()` em `cursor_4c_Dados` compartilhado — SEMPRE `USE IN + SQLEXEC direto`**: `cursor_4c_Dados` eh o cursor de listagem padrao COMPARTILHADO por 163+ BOs CRUD (todos que herdam de BusinessBase e populam Page1.Grid). Anti-padrao gerado pelo migrador: `IF USED("cursor_4c_Dados") / SQLEXEC(...,"cursor_4c_DadosTmp") / SELECT cursor_4c_Dados / ZAP / APPEND FROM DBF("cursor_4c_DadosTmp") / USE IN cursor_4c_DadosTmp / ELSE / SQLEXEC(...,"cursor_4c_Dados") / ENDIF` — `ZAP` apaga registros mas PRESERVA a estrutura (colunas + constraints NOT NULL) que outro BO deixou no cursor. **Sequencia toxica**: user abre FormCargo (`CargoBO.Buscar` cria `cursor_4c_Dados` com estrutura `ccargs char(10) NOT NULL, dcargs char(20)` — herda NOT NULL da PK de SigCdCrg) -> user abre FormCor (`CorBO.Buscar` faz SELECT `cods, descs, varias, Pesos` que NAO tem coluna `ccargs`) -> APPEND tenta inserir com `ccargs=NULL` -> SQL Server erro **"Field CCARGS does not accept null values"** no CATCH de `Buscar()`. Qualquer par de forms CRUD com esquemas PK diferentes eh vulneravel. **FIX CANONICO** (`CargoBO.Buscar:89`): substituir bloco todo por `IF USED("cursor_4c_Dados") / USE IN cursor_4c_Dados / ENDIF / loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") / IF loc_nResultado >= 0 / loc_lSucesso = .T. / ELSE / MostrarErro("Erro ao buscar..." + CHR(13) + CapturarErroSQL(), "Erro SQL") / ENDIF`. Form CRUD ja rebinda `Grid.RecordSource = "cursor_4c_Dados"` + `Column.ControlSource` + `Header.Caption` em `CarregarLista()` APOS `Buscar()` (padrao Problema 48) — nao ha regressao de UX. **NAO usar ZAP+APPEND** achando que preserva binding do Grid — SQLEXEC "cursor_4c_Dados" tambem recria e re-binda transparentemente quando CarregarLista roda logo depois. Auto-fix: CorretorAutomatico #176 detecta bloco IF-ELSE-ZAP-APPEND canonico e substitui por USE IN+SQLEXEC direto. Bug em CorBO.Buscar (Erro138 2026-09-01, ao abrir FormCor apos FormCargo). Escopo: 163+ BOs CRUD afetados — sweep retroativo aplicado.
- **BO property name DEVE bater EXATAMENTE com uso no Form (`FormParaBO`/`BOParaForm`) — naming mismatch causa `Property THIS_<X> is not found` + GRAVACAO SILENCIOSAMENTE ERRADA**: Migrador as vezes nomeia property do BO com naming SEMANTICO (`this_nSubclaEncerr` — significado do campo) enquanto o Form referencia com naming DB (`this_nChkSubs` — espelho da coluna `nchksubs`). Ao clicar Salvar/Alterar em form CRUD: `FormParaBO` executa `THIS.this_oBusinessObject.this_nChkSubs = IIF(opt.Value = 1, 1, 0)` → VFP9 estora **"Property THIS_NCHKSUBS is not found"** em MessageBox → user clica OK/Continuar → **CATCH nao interrompe o fluxo**, INSERT/UPDATE roda com property DEFAULT (`this_nSubclaEncerr = 0` nunca atribuida) → banco recebe SEMPRE 0/valor inicial. Sintoma pior que o erro visivel: user pensa "erro mas gravou", nao percebe que campos S/N/OptionGroup gravaram VALOR ERRADO permanentemente. **REGRA UNIVERSAL**: nomes de property no BO DEVEM ser IDENTICOS aos nomes usados em `FormParaBO`/`BOParaForm`/`CarregarDoCursor`/`Validar<X>` do Form. **PREFERIR NOME DB** (espelhar coluna `nchksubs` -> `this_nChkSubs`; `iclis` -> `this_cIclis`) para eliminar essa classe de mismatches — regra secundaria de CLAUDE.md Property Naming Sufixo 's'. Se herdar codigo com naming semantico, refactor SEMPRE em pares (form + BO simultaneos) via `replace_all` no PS/VSCode do nome antigo pro novo. Auto-fix: CorretorAutomatico #177 WARNING-only — grep no `Form*.prg` por `THIS\.this_oBusinessObject\.this_(\w+)` extrai nomes; grep no BO correspondente + heranca (BusinessBase/RelatorioBase) por `^\s*this_\1\s*=` declaracao (fora de PROC/FUNC — depth counter); se ausente, emite `WARN-177-BO-PROP-NAO-DECLARADA` com linha+nome+BO. Nao muta pois renomear demanda contexto (decisao DB-vs-semantico + refactor em ambos arquivos). Bug em `FormDepartamento` -> `DepartamentoBO` (Erro139 2026-09-01, Salvar cadastro de departamento — property `this_nChkSubs` usada no form mas BO declarava `this_nSubclaEncerr`; MessageBox aparecia mas save prosseguia gravando 0). Escopo: qualquer BO CRUD com mapeamento OptionGroup/CheckBox/TextBox custom — sweep detecta.
- **`cmd_4c_Confirmar.Enabled = loc_lEdit*` em `HabilitarCampos(par_lHabilitar)` DESABILITA Confirmar em modo EXCLUIR — SEMPRE adicionar `OR (THIS.this_cModoAtual = "EXCLUIR")`**: Em Form CRUD, `BtnExcluirClick` chama `HabilitarCampos(.F.)` para tornar campos READONLY (user apenas VE o registro antes de confirmar exclusao). Mas o mesmo metodo tambem faz `cmd_4c_Confirmar.Enabled = loc_lEdit` (ou variantes `loc_lEditar`/`loc_lEditando`/`loc_lEdita`) — quando `par_lHabilitar=.F.`, `loc_lEdit*=.F.` e **Confirmar fica DISABLED**. User ve a tela de exclusao com registro carregado, botao Confirmar CINZA sem imagem (icone `cadastro_confirmar_60.jpg` nao renderiza em `.Enabled=.F.`), IMPOSSIVEL confirmar a exclusao. Semantica correta: em EXCLUIR, campos ficam readonly (loc_lEdit=.F.) MAS Confirmar precisa estar habilitado (user tem que clicar para confirmar a acao). **FIX CANONICO**: `cmd_4c_Confirmar.Enabled = loc_lEdit OR (THIS.this_cModoAtual = "EXCLUIR")` — Confirmar habilitado em INCLUIR/ALTERAR (loc_lEdit=.T.) E em EXCLUIR (loc_lEdit=.F. mas THIS.this_cModoAtual="EXCLUIR"). Regra vale para TODAS as variantes de flag: `loc_lEdit`/`loc_lEditar`/`loc_lEditando`/`loc_lEdita` — auto-fix Pattern #178 detecta regex `cmd_4c_Confirmar\.Enabled\s*=\s*loc_lEdit\w*\s*$` e injeta o OR. Idempotente (skip se linha ja contem "EXCLUIR"). Bug em FormDepartamento (Erro140 2026-09-01, clicar Excluir apos selecionar registro no grid — tela abre com dados carregados mas Confirmar disabled). Escopo: ~34 forms CRUD com o mesmo padrao — sweep retroativo aplicado.
- **Form CRUD `Width < 1000` com `cnt_4c_Saida.Left=917` TRUNCA botoes Encerrar/ultimos**: Padrao canonico CLAUDE.md #10 fixa `cnt_4c_Saida.Left=917 + Width=90` (Encerrar termina em 1007). Se `Form.Width < 1000`, o container Saida transborda e Encerrar fica INVISIVEL; alem disso, `cnt_4c_Botoes.Left=542 + Width=385` termina em 927, ultimos botoes (Excluir Left=230/absoluto 772, Buscar Left=305/absoluto 847) tambem podem ser cortados se Width menor. **REGRA UNIVERSAL**: Form CRUD (`AS FormBase`) DEVE ter `Width = 1000` — canonico universal. Se SCX legado tinha Width menor (ex: 812), IGNORAR e usar 1000. Auto-fix: CorretorAutomatico #179 WARNING-only (nao muta pois alguns forms pequenos podem ter layout intencional — decisao humana caso a caso). Detector: guard `DEFINE CLASS \w+ AS FormBase` + presenca de `\.Left = 917` (assinatura do cnt_4c_Saida canonico) + `Width = N` no bloco de propriedades da classe com N<1000. Sweep 2026-09-01: 6 candidatos (FormCCJ/FormCrt/FormGcp/FormMoe/FormRop/FormSigPrCtc). Bug em FormSrv Width=812 (Erro141 2026-09-01, botoes Excluir e Encerrar cortados no menu Cadastros->Servicos).
- **Grid `RecordSource=""+re-set` em `CarregarLista` RESETA `Column.Width` e `Header1.Caption` — SEMPRE re-configurar APOS ControlSource (Problema 48 CLAUDE.md)**: Em Form CRUD, `CarregarLista` faz `Grid.RecordSource="" / ColumnCount=N / RecordSource="cursor_x" / Column1.ControlSource="..." / Column2.ControlSource="..."` para trocar cursor. Esse padrao RESETA silenciosamente `Column.Width` (volta para default ~64) e `Header1.Caption` (volta para "Header1"). Se `ConfigurarPaginaLista` (setup inicial) definiu Width/Caption dessas colunas, elas SE PERDEM ao chamar `CarregarLista` — grid aparece com colunas "Header1"/"Header1" com widths quadrados. **FIX CANONICO**: apos o ultimo `ControlSource=`, adicionar re-configuracao explicita `Grid.ColumnN.Width = <valor_original>` e `Grid.ColumnN.Header1.Caption = "<caption_original>"` para cada coluna. Valores originais estao no bloco `ConfigurarPaginaLista` (mesmo grid path). Auto-fix: CorretorAutomatico #180 auto-mutate — extrai valores originais do bloco de configuracao inicial e injeta apos ControlSource. Fallback WARNING se valores originais nao localizados. Idempotente (skip se ja tem `Column.Width=` ou `Header1.Caption=` no mesmo bloco). Bug em FormSrv 2 grids (Erro141 2026-09-01, cadastro Servicos + grid interno Produtos mostrando "Header1"). Complementa Problema 48 canonico ja documentado.
- **`pgf_4c_Paginas.Width` hardcoded < `Form.Width` TRUNCA botoes na Page1 mesmo com Form.Width canonico**: PageFrame `pgf_4c_Paginas` (root do layout Page1/Page2) DEVE ter Width IGUAL ao `Form.Width` para exibir toda a area util. Se `PageFrame.Width = 815` mas `Form.Width = 1000`, o PageFrame ocupa apenas 815px — botoes/containers com Left > 815 (ex: `cnt_4c_Saida.Left=917`) ficam CORTADOS pela borda do PageFrame, mesmo estando dentro dos 1000px do Form. Fix `Form.Width=1000` (Pattern #179) sozinho NAO resolve — precisa tambem ajustar PageFrame.Width. **FIX CANONICO**: `THIS.pgf_4c_Paginas.Width = THIS.Width` (dinamico, sempre segue Form.Width) — mais robusto que hardcoded. Alternativa: valor literal >=1000 (canonico CRUD). NUNCA hardcoded < 1000 quando Form.Width=1000. Auto-fix: CorretorAutomatico #181 detecta bloco `WITH THIS.pgf_4c_Paginas` (ou variantes com var local) + `.Width = N` onde N eh literal numerico < 1000, substitui por `.Width = THIS.Width`. Guard: apenas em Form CRUD (`AS FormBase`). Idempotente (skip `.Width = THIS.Width`; skip se N >= 1000). Bug em FormSrv (Erro142 2026-09-01, PageFrame.Width=815 truncava botoes apos fix inicial Form.Width=812->1000 nao resolver). Meta-licao: quando Form.Width eh alterado, TAMBEM ajustar PageFrame.Width simultaneamente — ambos formam um par sincronizado.
- **Grid com coluna EDITAVEL (CheckBox/ComboBox) exige cursor READWRITE - `SQLEXEC()` cria cursor SOMENTE-LEITURA**: cursor de SQL pass-through nasce read-only no VFP; uma coluna com `AddObject("chk_4c_X", "CheckBox")` + `CurrentControl` + `Sparse=.F.` RENDERIZA o controle em TODAS as linhas mas a celula NUNCA entra em edicao - clicar no CheckBox nao faz nada, e o sintoma parece bug de `Enabled`/`ReadOnly` (que estao corretos), fazendo perder horas no lugar errado. SEMPRE que o Grid tiver coluna editavel, no BO usar alias TEMPORARIO + conversao: `SQLEXEC(gnConnHandle, loc_cSQL, "<alias>Tmp")` + `IF USED("<alias>") / USE IN <alias> / ENDIF` + `SELECT * FROM <alias>Tmp INTO CURSOR <alias> READWRITE` + `IF USED("<alias>Tmp") / USE IN <alias>Tmp / ENDIF` (template canonico `CCJBO.prg:214`). COROLARIO: como o cursor passa a ser fechado/recriado, o Grid perde o binding e reatribuir `RecordSource` reseta tambem `Column.Sparse`/`Column.CurrentControl`/`Column.ReadOnly` (alem de `Column.Width`/`Header1.Caption` - Problema 48), entao nos metodos `Carregar*` restaurar `.Sparse = .F.` + `.CurrentControl = "<controle>"` APOS o rebind (restauracao dentro do `IF !PEMSTATUS(...)` defensivo NAO basta - so roda quando o controle foi destruido), e chamar `Habilitar*Grid(<modo editavel>)` DEPOIS de todas as cargas (`HabilitarCampos(.T.)` em `BtnIncluirClick` roda ANTES do rebind e eh descartado). Ref: Erro145-v2 (2026-09-04, Formacg/acgBO) - Pattern #184 WARNING-only
- **CheckBox em coluna de Grid NAO alterna pelo binding nativo - exige os 4 handlers Click/MouseDown/MouseUp/KeyPress com NODEFAULT**: `Column.AddObject("chk_4c_X","CheckBox")` + `CurrentControl` + `ControlSource` + `Sparse=.F.` fazem o CheckBox RENDERIZAR em todas as linhas e ate RECEBER FOCO, mas clicar ou teclar Espaco/Enter NAO muda o valor - e o sintoma parece bug de `Enabled`/`Column.ReadOnly` (que estao corretos). Os forms legado Fortyus SUPRIMEM o toggle padrao e alternam o valor por codigo; migrar so o `When` (o gate de modo) deixa o checkbox inerte. Template canonico obrigatorio, um bloco por checkbox de grid: `PROCEDURE Chk<X>KeyPress(par_nKeyCode, par_nShiftAltCtrl) / IF INLIST(par_nKeyCode, 13, 32) AND INLIST(THIS.this_cModoAtual,"INCLUIR","ALTERAR") AND USED("<cursor>") AND !EOF("<cursor>") / REPLACE <cursor>.<campo> WITH IIF(<cursor>.<campo> = 0, 1, 0) / THIS.<path>.<grid>.Refresh() / NODEFAULT / ENDIF / ENDPROC` mais `Chk<X>MouseUp` (`THIS.Chk<X>KeyPress(13, 0)` + `NODEFAULT`), `Chk<X>MouseDown` (`NODEFAULT`) e `Chk<X>Click` (`NODEFAULT`) - os dois ultimos existem para SUPRIMIR o toggle nativo e evitar alternancia dupla. Registrar os 4 com `BINDEVENT(<chk>, "KeyPress"|"MouseUp"|"MouseDown"|"Click", THIS, "<handler>")` em TODO ponto que cria o controle (o `ConfigurarAba*` E o bloco defensivo `IF !PEMSTATUS(...)` dos `Carregar*`). O gate de modo vai DENTRO do KeyPress, nao so no `When`: BINDEVENT descarta o retorno do delegate, entao um `When` ligado por BINDEVENT nao bloqueia edicao. PRE-REQUISITO: o cursor precisa ser READWRITE, senao o `REPLACE` estoura (ver regra do cursor de SQLEXEC). Ref canonico: `Formsigredtv.prg:963-1585` (grd_4c_Emps) e `Formacg.prg` pos-Erro146; ref legado: `SIGCDACG.Pagina.Dados.Pagina.Acesso.grdAcesso.Column3.Check1` (Click=NoDefault, MouseDown=NoDefault, MouseUp=This.KeyPress(13,0)+NoDefault, KeyPress=Replace+Refresh+NoDefault). Ref: Erro146 (2026-09-04, Formacg) - Pattern #185 WARNING-only
- **`AddObject` e `BINDEVENT` em coluna de Grid: nome do controle tem de bater com o alvo REAL — tres defeitos que quebram o Init**: (A) **NUNCA dois `AddObject("<X>", ...)` com o MESMO nome no MESMO alvo** — VFP dispara `Object <X> is already defined` e o `Init` do form morre; se duas copias configuram propriedades diferentes, consolidar num bloco so (achado: `grd_4c_Fases.Column4` com dois `AddObject("Check1","CheckBox")` identicos dentro do mesmo `WITH`). (B) **NUNCA deixar controle adicionado e nao usado** — se a coluna faz `AddObject("check12")` + `AddObject("check13")` e o `CurrentControl` eh `"check13"`, o `check12` eh objeto morto: remover, ou corrigir o `CurrentControl` se a intencao era ele. (C) **`BINDEVENT(<grid>.ColumnN.<M>, ...)` so vale se `<M>` for `Text1`/`Header1` (nativos da Column) ou tiver sido `AddObject`'d NAQUELA coluna** — referencia de objeto invalida estoura no `Init` E deixa o controle sem handler nenhum; a causa tipica eh copiar o bloco de `BINDEVENT` de outro grid sem trocar o nome do controle (achado: os 4 `BINDEVENT` de `grd_4c_Emps.Column1` apontavam para `Check1`, que so existe em `grd_4c_Opers.Column1` — o CheckBox de Empresas ficou sem toggle e ninguem percebeu porque o erro some no CATCH do `InicializarForm`). REGRA PRATICA: ao copiar um bloco de configuracao de grid, trocar TRES coisas juntas — o caminho do grid, o nome do controle no `AddObject`/`CurrentControl` e o alvo de cada `BINDEVENT`. Excecao legitima: o re-`AddObject` dentro de `IF !PEMSTATUS(...)` nos `Carregar*` eh defensivo (Pattern #183) e NAO conta como duplicata. Ref: Erro146 / sweep Pattern #185 (2026-09-04, FormLin/FormMda/Formpgr/Formsigredtv) - Pattern #186 WARNING-only

- **IIF() exige condicao LOGICA - IIF(chk.Value, 1, 0) dispara erro 11**: CheckBox.Value eh NUMERICO (0/1) nos forms gerados, e IIF() so aceita LOGICO no 1o argumento. Passar numero estoura "Function argument value, type, or count is invalid." (VFP9 erro 11) - e em FormParaBO o erro cai no CATCH, aborta o metodo no meio e o Salvar segue gravando registro PARCIAL (bug silencioso, pior que a caixa de erro). SEMPRE comparar explicitamente: IIF(chk_4c_X.Value = 1, 1, 0). Vale para qualquer expressao numerica usada como condicao (IIF/IF/DO WHILE). Corolario: FormParaBO deve ser FUNCTION retornando .T./.F. e BtnSalvarClick deve ABORTAR a gravacao quando ela falhar. Auto-fix: CorretorAutomatico #187. Bug observado em Formcfo.prg (2026-09-08, Erro147).
- **ControlSource NUMERICO no SCX = indice 1-based (NUNCA booleano 0/1)**: ComboBox/OptionGroup do legado com ControlSource apontando para coluna NUMERICA grava o INDICE do item selecionado (1 = 1o item, 2 = 2o item, 0 = nada selecionado), NUNCA 0/1. Migrar como BO.this_nX = cbo.ListIndex / BO.this_nX = opt.Value, e o inverso cbo.ListIndex = IIF(BETWEEN(val,1,N), val, 0) / opt.Value = IIF(BETWEEN(val,1,N), val, 0). PROIBIDO inventar RowSource placeholder ("0,1") - copiar a lista EXATA do SCX ("Sim,Nao", "Nao,Base,Preco", ...). ComboBox com ColumnCount=2 + BoundColumn=2 grava a 2a coluna do RowSource (copiar ColumnCount/ColumnWidths/BoundColumn). ComboBox com ControlSource CHAR grava a INICIAL da opcao: LEFT(UPPER(ALLTRIM(cbo.Value)), 1), igual ao "Replace campo with padr(upper(alltrim(cbo.value)),1)" do legado. Conferir a distribuicao REAL da coluna no banco antes de assumir 0/1. WARNING: CorretorAutomatico #188. Bug observado em Formcfo.prg (2026-09-08, Erro147): 7 combos e 12 OptionGroups gravavam valores errados silenciosamente.
- **NUNCA reportar sucesso quando nao houve o que gravar**: metodo de gravacao que percorre um cursor de detalhe (grade de itens/ocorrencias/parcelas) e nao encontra nenhuma linha valida NAO pode retornar .T. em modo de INCLUSAO, e o form NAO pode exibir MsgInfo("... salvo com sucesso") nesse caso â€” o usuario ve a mensagem, volta para a lista e o registro nao existe (bug pior que erro visivel). No form, ANTES de chamar o BO: contar as linhas do cursor com a coluna-chave preenchida e, se zero em modo INSERIR/INCLUIR, MsgAviso("Informe ao menos um(a) <item> antes de gravar.") + SetFocus na grade + RETURN. Em ALTERAR a lista vazia continua valida quando o legado apaga-e-reinsere (significa remover todos os itens). Mesma familia do Erro147 (metodo de transferencia que falha e deixa o Salvar seguir). WARNING: CorretorAutomatico #189. Bug observado em FormSIGPRLNC.prg (2026-09-08, Erro148).
- **Grid da lista (Page1) tem de espelhar as colunas do legado, nao a grade de detalhe**: no SCX/Init legado as colunas da lista vem de `.AddCursor(...)` + `.pfSqlTabela(1).pColuna(<campo>, ..., <header>, <largura>, ...)` â€” copiar campo, caption e largura EXATOS de cada pColuna. Erro tipico: o migrador copia os captions da grade de detalhe da Page2 (ex.: "Ocorrencia"/"Descricao") para a lista de registros e ainda perde colunas. PROIBIDO tambem trocar a granularidade da lista: se o legado faz `Select * From <tabela>` (uma linha por registro), NAO usar `SELECT DISTINCT` de um subconjunto â€” alem de esconder colunas, isso muda a semantica de Alterar/Excluir (a linha selecionada deixa de ter chave primaria e o Excluir vira exclusao em massa por chave secundaria, apagando o que o usuario nao pediu). Levar a PK (ex.: cidchaves) para o cursor da lista e excluir por ela. Bug observado em FormSIGPRLNC.prg (2026-09-08, Erro148).
- **INSERT do BO tem de cobrir TODAS as colunas NOT NULL sem DEFAULT**: o legado grava o registro inteiro (AddCursor sem query = SELECT * + TABLEUPDATE), entao colunas que nao aparecem na tela continuam sendo gravadas com o valor do registro em branco. Se o INSERT do BO omitir uma coluna NOT NULL, o SQL Server recusa a inclusao inteira com "Nao eh possivel inserir o valor NULL na coluna <col> ... a coluna nao permite nulos. Falha em INSERT." e o cadastro fica sem conseguir incluir. Regras de preenchimento: (a) `cidchaves`/`pkchaves` (chave unica do Fortyus) = `EscaparSQL(fUniqueIds())` â€” NUNCA string vazia, senao o segundo registro colide no indice unico; (b) coluna com property no BO = usar a property; (c) sem property = default do tipo (`EscaparSQL("")` para char, `FormatarNumeroSQL(0, <decimais>)` para numeric, `0` para bit, data sentinela para datetime NOT NULL); (d) `usuars`/`usualts` = `gc_4c_UsuarioLogado`. ATENCAO a colunas GEMEAS de nome parecido, que existem juntas e sao ambas NOT NULL: `tipo`+`tipos` (SigCdRom), `prioridade`+`prioridades` (SigCdClc), `imprs`+`iimprs` (SigOpPic), `cidatrabs`+`cidtrabs` (SigCdCli) â€” incluir a que falta, nao trocar a existente. MAS ANTES DE INCLUIR, CONFERIR se a grafia que JA esta no INSERT existe na tabela: se NAO existe, nao sao gemeas - a migracao ERROU A GRAFIA e o conserto eh RENOMEAR, nao acrescentar. Suspeitar de metatese (`ems`/`ens`, `oas`/`aos`, `tipo`/`tip`): gemeas de verdade diferem por um sufixo inteiro, nao por letras trocadas de lugar. Erro de grafia nunca fica so no INSERT - esta tambem no UPDATE e na leitura do cursor em `CarregarDoCursor`; como `CarregarPorCodigo` usa `SELECT *`, o cursor traz a grafia REAL e a leitura estoura em RUNTIME com `Variable X is not found` (compila limpo, quebra Alterar/Visualizar). Renomear no arquivo INTEIRO, case-sensitive e com limite de palavra, preservando os nomes das properties. Observado em gpdBO/SigCdGrp, onde os SEIS nomes estavam errados (2026-09-14, Erro159). Conferencia em lote: `automation\VerificarInsertNotNull.ps1` (cruza os INSERT dos BOs com INFORMATION_SCHEMA). COMO GARANTIR (a regra sozinha JA FALHOU uma vez): antes de escrever o INSERT, extrair do schema a lista de colunas NOT NULL sem DEFAULT da tabela destino e conferir UMA A UMA contra a lista do INSERT. NAO basta ler o dump do legado - as colunas que o legado nunca cita (existiam so no registro em branco do AddCursor) sao invisiveis la e sao justamente as que faltam: em SigFiChc foram `nsenha` e `versao`, alem da PK `cidchaves`. Conferencia automatica na etapa 05f (`Validate-InsertNotNull` do ValidadorSQLSchema.ps1), que BLOQUEIA a migracao se faltar coluna. Bug observado em AliBO/SigCdAli.reincids (2026-09-08, Erro151) e em mais 20 sites no sweep; reincidiu em CecBO/SigFiChc (2026-09-14, Erro159).
- **Label/CheckBox/OptionButton de DADOS nunca leva ForeColor branco - o canonico eh RGB(90, 90, 90)**: as Pages do PageFrame recebem `.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"` (textura CLARA) que cobre o `.BackColor = RGB(100,100,100)`, entao qualquer `.ForeColor = RGB(255, 255, 255)` em controle criado DIRETO na pagina (ou dentro de container com `BackStyle = 0`, que eh transparente, ou com BackColor claro) fica INVISIVEL - o usuario clica em Incluir, abre a aba Dados e ve as caixas de texto sem nenhuma legenda. Quando o objeto do SCX legado NAO declara ForeColor (classe `say` do Framework), usar RGB(90, 90, 90); quando declara, copiar o valor EXATO (36,84,155 nos titulos de secao em Verdana, 255,0,0 nas notas de rodape). Ao procurar o objeto no dump do legado, conferir os DOIS nomes: `Say<N>` do legado costuma virar `lbl_4c_Label<N>` no migrado. EXCECOES legitimas, que continuam brancas: `lbl_4c_Titulo`/`lbl_4c_LblTitulo` da faixa do cabecalho, label dentro de container OPACO escuro (`BackStyle = 1` + BackColor RGB(100,100,100)/RGB(90,90,90)) e as propriedades `HighlightForeColor`/`SelectedForeColor`/`SelectedItemForeColor` (texto da linha selecionada, que fica sobre realce escuro). WARNING: CorretorAutomatico #191. Bug observado em FormARV.prg (2026-09-09, Erro153) e em mais 22 forms no sweep (217 sites).
- **NUNCA chamar helper que voce nao definiu - em VFP9 o erro so aparece em RUNTIME**: chamada "nua" a um nome que nao existe como funcao global compila sem reclamar; o VFP resolve nome desconhecido procurando `<nome>.prg` em disco e, quando o usuario aciona o botao, estoura `File 'nomedafuncao.prg' does not exist.` Antes de usar um helper, conferir que ele EXISTE em `projeto\app\utils\functions.prg` (`TratarNulo`, `EscaparSQL`, `FormatarNumeroSQL`, `FormatarDataSQL`, `ConverterParaLogico`, `MsgErro`, `MsgAviso`, `MsgInfo`, `MsgConfirma`, ...). Precisando de um helper novo, DEFINIR em functions.prg no mesmo padrao - PROIBIDO so chamar e seguir em frente. Corolario (CLAUDE.md regra #8): metodo da propria classe SEMPRE com `THIS.` - sem o prefixo cai no mesmo erro de arquivo inexistente. ATENCAO ao helper que le coluna do banco: coluna `bit` do SQL Server chega ao VFP ora como Logico (.T./.F.) ora como Numerico (0/1) conforme o driver, e coluna `numeric(1,0)` sempre como Numerico - testar `VARTYPE` antes de comparar, porque comparar Logico com 1 estoura "Operator/operand type mismatch". Auditoria: `automation\VerificarFuncoesNaoDefinidas.ps1`. WARNING: CorretorAutomatico #192. Bug observado em BchBO/BlqBO/DCCBO/OETBO/sigpdmp6BO/sigpres2BO (2026-09-09, Erro154): `ConverterParaLogico` foi inventado pelo migrador e chamado em 17 sites sem existir em lugar nenhum.
- **`docs\schema.sql` eh UTF-16LE - grep/awk/findstr devolvem ZERO SILENCIOSAMENTE**: essas ferramentas tratam o arquivo como binario e nao acham nada, fazendo tabela e coluna EXISTENTES parecerem inexistentes. A "correcao" natural a partir desse diagnostico falso - apontar o BO para outra tabela - grava dado no lugar errado e viola o PILAR 2. Ler sempre com `Get-Content -Raw` (PowerShell respeita o BOM) ou usar `automation\VerificarTabelasInexistentes.ps1`, que ja trata o encoding e ainda aborta se ler menos de 100 tabelas (piso de sanidade contra leitura falha). Tambem NAO usar `tasks\<task>\schema_ascii.sql` como fonte de verdade: eh snapshot congelado na epoca daquela task (task351 tem 674 tabelas contra 682 do canonico) e faz tabela nova parecer ausente. Corolario para o erro de runtime `Nome de objeto 'SigCdXxx' invalido` (vem do SQL Server, nao do VFP, e nao quebra a compilacao): (1) conferir a tabela no schema canonico com o encoding correto; (2) conferir o nome no CODIGO LEGADO em `tasks\<task>\*_form_codigo_fonte.txt`. Se o legado usa o MESMO nome e a tabela esta no schema, o codigo migrado esta FIEL e a divergencia eh de BANCO/ambiente (a base conectada nao bate com o dump) - NAO eh bug de migracao e NAO se conserta no codigo. WARNING: CorretorAutomatico #193. Bug observado em FormBlq/SigCdBlq (2026-09-09, Erro155).
- **`EVALUATE()` NAO atribui - ele avalia e devolve o valor**: `EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = ''")` NAO limpa nada. O VFP monta a string, enxerga uma COMPARACAO (`obj.prop.Value = ''`), avalia como `.T.`/`.F.` e joga o resultado fora - sem erro, sem aviso, o campo simplesmente nunca muda. Comprovado no VFP9: valor antes `[ABC]`, depois do EVALUATE `[ABC]`, depois do STORE `[]`. Para atribuir a um nome montado em tempo de execucao, usar `STORE <valor> TO (<expressao que resulta no nome>)`: `STORE "" TO ("loc_oCnt." + par_cTxtDesc + ".Value")`. `EVALUATE` continua CERTO para LEITURA (`loc_c = EVALUATE("loc_oCnt." + par_cTxtCon + ".Value")`, `IF EVALUATE("VARTYPE(loc_oCnt." + par_cX + ")") = "O"`) - o defeito eh so quando o sinal de igual esta DENTRO da string montada, que eh o unico caso em que a intencao era atribuir. Auto-fix: CorretorAutomatico #194 (forma segura: valor vazio ou identificador simples; valor com concatenacao/funcao vira WARNING). Bug observado em Formlch.prg (2026-09-09, Erro155): 4 sites, e o pior calava a descricao do GRUPO nos 7 containers do form desde a migracao, sem ninguem perceber.
- **A faixa do cabecalho tem de ser o PRIMEIRO `AddObject` da pagina Dados - senao ela COBRE os botoes**: os containers de botao (`cnt_4c_Salva`/`cnt_4c_BotoesAcao`/`cnt_4c_Saida`) ficam em `Top = 29..33`, ou seja DENTRO da area da faixa (`Top = 29..31`, `Height = 80`), e so aparecem se forem criados DEPOIS dela. Com a ordem invertida o usuario abre a aba Dados e ve o cabecalho comendo Confirmar/Encerrar - sobra so a lasca dos ~10px que passam da altura da faixa. Vale so para a pagina Dados: na Lista o migrador costuma acertar a ordem. EXCECAO: pagina com PageFrame/Container interno que cobre tudo (`Formgpd.pgf_4c_Divisoes`) - ali a faixa vem DEPOIS de proposito e a barra de botoes eh trazida para frente com `ZOrder(0)`; a presenca do `ZOrder(0)` eh o que distingue esse caso de um bug. CORRELATO: conferir que os labels da faixa nao ficaram PELADOS - `.AddObject("lbl_4c_Sombra", "Label")` sem nenhuma propriedade em seguida faz o titulo sair como label default minusculo, preto sobre cinza, mesmo com o `Caption` setado no `Init` (injecao do Erro152 que ficou pela metade no FormCat). Auto-fix: CorretorAutomatico #195. Bug observado em FormCAD e FormCat (2026-09-09, Erro156).
- **A faixa cinza do cabecalho vai nas DUAS paginas (Lista E Dados)**: o SCX legado (frmcadastro) tem o cntSombra so em Pagina.Lista, mas o padrao adotado no sistema novo eh repetir a faixa na pagina Dados - decisao do time (Erro152), que PREVALECE sobre o PILAR 1 neste ponto. Bloco canonico em Formcfo.prg ConfigurarPaginaDados: `cnt_4c_Cabecalho` Container com Top=29, Left=0, Width=THIS.Width, Height=80, BackColor=RGB(100,100,100), BorderWidth=0, SpecialEffect=0, contendo `lbl_4c_Sombra` (Top=15, ForeColor preto) e `lbl_4c_Titulo` (Top=18, ForeColor branco), ambos Tahoma 16 bold, BackStyle=0, Caption=THIS.Caption. O cabecalho tem de ser o PRIMEIRO AddObject da pagina: assim os containers de botao (cnt_4c_Salva/cnt_4c_BotoesAcao/cnt_4c_Saida, que ficam em Top=29..33) sao criados depois e desenham POR CIMA da faixa, como no Formcfo. Consequencia de layout: nenhum controle de DADOS pode ficar com Top < 109 (29+80) na pagina Dados - ao converter os Tops do SCX, empurrar o conteudo para baixo da faixa. Conferencia: `automation\DiagnosticoCabecalhoPaginas.ps1`. WARNING: CorretorAutomatico #190.
- **Cabecalho: detectar por BackColor+altura, NUNCA pelo nome do container**: o mesmo cabecalho aparece como `cnt_4c_Cabecalho` na maioria dos forms e como `cnt_4c_Sombra` (nome do legado, cntSombra) em outros - procurar so pelo nome faz o form parecer "sem cabecalho" e leva a injetar uma faixa DUPLICADA por cima da existente (aconteceu em FormFte/FormUfs/Formpgr no sweep do Erro152). Identificar o container pelo par BackColor=RGB(100,100,100) + Height>=60 criado direto na pagina.
- **TTOD() so aceita DATETIME - passar um DATE dispara erro 11 em RUNTIME**: "Function argument value, type, or count is invalid." O .prg compila limpo e o usuario so descobre ao acionar o botao. A armadilha eh que o MESMO campo chega com tipos DIFERENTES conforme o caminho: TextBox criado com .Value = {} guarda DATE (modo INCLUIR), coluna datetime do SQL Server via SQLEXEC chega como DATETIME (modo ALTERAR) e cursor VFP com coluna declarada D guarda DATE - por isso o codigo funciona em ALTERAR e explode em INCLUIR. Para qualquer valor que passou por form, propriedade de BO, parametro ou variavel local, usar ConverterParaData(x) de utils\functions.prg, que normaliza DATE/DATETIME/CHAR para DATE (com DATETIME o resultado eh identico ao TTOD). TTOD() direto so em coluna de cursor vinda de SQLEXEC, onde o tipo eh garantidamente datetime. Auto-fix: CorretorAutomatico #197. Bug observado em FormCCJ/CCJBO "Calculo de Juros" (2026-09-10, Erro157): o legado fazia Ttod(Get_DataBase.Value) e funcionava porque la o TextBox tinha ControlSource = crSigCdCcj.data_base (datetime); no migrado o TextBox nasce com {} e a tela nao gravava nada, so o messagebox de erro.
- **PROIBIDO reescrever a formula de calculo do legado - transcrever LITERALMENTE**: a expressao aritmetica, a ordem dos operadores, o SINAL, os divisores, o ROUND e os guards fazem parte da regra de negocio e nao se "simplificam". No Erro157 o legado calculava Round(lnValor - (lnValor*((lnDias/30)*(lnFator/100))),2) - juros DESCONTADOS, taxa MENSAL prorrateada - e o migrado escreveu loc_nValor + loc_nValor*(loc_nFator/100)*loc_nDias, juros SOMADOS com taxa DIARIA: a tela gravava valor errado sem exibir erro nenhum. Junto com a formula vao tres coisas que o migrador costuma jogar fora e que TAMBEM sao regra: (1) SINAL - o legado NAO zera diferenca de datas negativa, data anterior a base gera dias negativos de proposito; (2) GUARDS - Abs(lnDias)>999 avisa, limpa o campo e ABORTA, porque a coluna destino eh numeric(3,0) e nao cabe mais que isso, e sem o guard a gravacao estoura no SQL Server; (3) CRITERIO DOS TOTAIS - Count/Sum/Avg com Where Not Empty(Dias) exclui as linhas com zero, resultado diferente de somar tudo dentro do SCAN. Ao migrar metodo de calculo, transcrever a formula do dump legado linha a linha e so depois trocar os nomes das variaveis.
- **Column.AddObject NAO faz o controle aparecer - falta o Column.CurrentControl**: adicionar um OptionGroup/CheckBox/ComboBox/Spinner a uma Column de Grid cria o objeto, mas a coluna continua desenhando o Text1 dela. O controle existe, responde a PEMSTATUS e nunca aparece na tela: o usuario ve o valor cru numa caixa de texto e nao tem como marcar nada. Quem escolhe o controle que a coluna desenha eh `Column.CurrentControl` (default "Text1"), e ele tem de receber o NOME exato passado ao AddObject, logo depois de configurar o controle: `.Column3.CurrentControl = "opt_4c_Tipos"`. Vem sempre acompanhado de `.Column3.Sparse = .F.` (sem isso o controle so aparece na linha ativa) e de `.Column3.ReadOnly = .F.` quando o usuario precisa editar - lembrando que o ReadOnly da COLUNA tem de ser definido DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve. Auto-fix: CorretorAutomatico #198. Bug observado em FormCco.prg (2026-09-10, Erro158): o OptionGroup Inserir/Excluir/Nenhum da coluna Tipo foi criado na migracao e nunca apareceu, entao nao havia como cadastrar o motivo.
- **MaxLength do TextBox vem da LARGURA DA COLUNA no schema, NUNCA do Width em pixels**: o migrador tende a copiar o Width do controle para o MaxLength, o que produz numeros absurdos e silenciosos - em FormCco o campo Codigo ficou `.Width = 80` / `.MaxLength = 80` e a Descricao `.Width = 220` / `.MaxLength = 220`, quando as duas colunas sao `char(30)`. O usuario digita mais do que cabe, o SQL Server recusa o INSERT com "String or binary data would be truncated" e a tela nao grava. Conferir cada TextBox contra `docs\schema.sql` (lendo com `Get-Content -Raw`, que eh UTF-16) e usar a largura da coluna; o LEFT() do INSERT/UPDATE no BO tem de usar o MESMO numero. Sinal de alerta imediato: `MaxLength` igual ao `Width`. WARNING: CorretorAutomatico #199. Bug observado em FormCco.prg (2026-09-10, Erro158).
- **Gravacao que falha em SILENCIO ja esta resolvida no BusinessBase - NAO duplicar**: `BusinessBase.Salvar()`/`Excluir()` exibem a falha sozinhos (via `ExibirFalha()`) em todo caminho de validacao que antes devolvia `.F.` calado, e marcam `this_lErroExibido`. Portanto **o form NAO precisa de ELSE** em `IF <bo>.Salvar()`. Se voce escrever um ELSE assim mesmo, guarde com `IF !<bo>.this_lErroExibido` para a mensagem nao sair duas vezes. E a regra para as subclasses: `Inserir`/`Atualizar`/`ExecutarExclusao` continuam exibindo o proprio `MsgErro` com o texto do SQL Server - a base detecta isso e nao repete. Origem: Erro158 (2026-09-10) - o defeito estava em 249 sites de 107 forms, e foi corrigido num arquivo so.
- **Popular cursor de grade NAO repinta a grade, e as guardas de validacao do legado nao se descartam**: (1) depois de encher o cursor por SQL, repetir o que o legado faz - `GO TOP IN <cursor>` + `<grid>.Refresh()`; sem isso a grade fica visualmente vazia mesmo com o cursor cheio, e a tela parece nao ter dados. (2) As condicoes que envolvem a validacao no legado FAZEM PARTE da regra: em FormCco o legado so dispara a consulta de sobreposicao de faixa quando `(FaixaI + FaixaF) <> 0` - sem esse guard, faixa 0 a 0 casa com qualquer registro cujo intervalo contenha zero e a gravacao eh bloqueada indevidamente; o migrado tambem tinha perdido a checagem `FaixaI > FaixaF` inteira e rodava a validacao so no INCLUIR, quando o legado roda em INCLUIR **e** ALTERAR (`If pcEscolha = 'ALTERAR' Or pcEscolha = 'INSERIR'`). Transcrever a validacao do dump legado com as condicoes que a cercam, nao so o corpo. Bug observado em FormCco.prg (2026-09-10, Erro158).
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

**BO somente-leitura (form de CONSULTA/visualizador sem INSERT/UPDATE/DELETE no legado)**: NAO
sobrescrever Inserir()/Atualizar()/ExecutarExclusao() so para preencher metodo - o comportamento
herdado de BusinessBase (recusar a operacao) ja eh o correto. Ao comentar essa decisao no
cabecalho do BO, EVITAR a frase literal "nao implementado"/"nao implementada" dentro de linha de
comentario ``*`` - o validador de completude (05d_validarCompletude) tem regex que casa "nao
implement" em QUALQUER comentario, sem diferenciar TODO real de documentacao de design, e rejeita
a fase por falso positivo. Preferir "o comportamento padrao herdado de BusinessBase ja eh o
correto" ou equivalente.

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
    Conta a superficie de BOTAO que o dump do SCX legado PROVA existir
.DESCRIPTION
    Usado pelos gates das Fases 7 e 8 para nao exigir do form migrado um botao
    que o legado nao tem (que so seria atendido INVENTANDO botao - viola o
    PILAR 1 - ou criando handler vazio - proibido pela regra de completude).

    Conta:
      - objeto com "BaseClass: commandbutton" (botao solto)
      - ButtonCount de cada objeto cuja BaseClass eh "commandgroup"

    NAO conta ButtonCount de OptionGroup: radio nao eh botao de acao e nao
    precisa de handler.

    ATENCAO ao resultado 0: form REPORT herda os 4 botoes do frmrelatorio e o
    SCX nao os declara, entao zero eh AUSENCIA DE PROVA, nao prova de ausencia.
    Quem chama deve tratar 0 como "nao sei" e manter a exigencia original.

    Medido em 2026-09-24 nos dumps de tasks\: 18 forms legado nao-CRUD tem
    exatamente 1 botao, 152 tem 0 (os REPORT) e 95 tem 2 ou mais.
#>
<#
.SYNOPSIS
    .T. quando o dump PROVA que o form legado eh um DIALOGO FILHO, aberto por
    outro form, e nao uma tela de topo chamada pelo menu.

.DESCRIPTION
    A prova usada eh o form ADOTAR a data session do chamador que recebeu por
    parametro:

        PROCEDURE Init
        LParameters poForm
        Set DataSession to poForm.DataSessionId

    Form CRUD de topo nunca faz isso - nao ha chamador de quem herdar a sessao.
    Serve para desempatar a evidencia FRACA de CRUD que eh o NOME do objeto
    ('cmdExcluir'), que num dialogo filho eh o botao que apaga a LINHA corrente
    da grade e nao um REGISTRO - a mesma armadilha ja tratada no gate para
    'X.Click' dentro de container de grade e para o icone
    'cadastro_excluir_26.jpg'.

    FAIL-CLOSED em duas camadas: exige (1) a adocao da data session do chamador
    e (2) que esse nome seja um parametro formal declarado no PROPRIO dump
    (LParameters/Parameters). Variavel global ou objeto de outra origem nao
    conta.

    Medido em 2026-09-26 nos dumps de tasks\: 10 forms tem a assinatura e so UM
    deles (SigPrCar) tambem casa o padrao de nome CRUD - isto eh, o veredicto
    muda para exatamente 1 form. Os outros 9 ja eram nao-CRUD por nao terem
    nome CRUD algum. Nenhum ganha passe livre: o piso
    'nHandlers >= minHandlersF7' continua valendo.
#>
function Test-DialogoFilhoDoChamador {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $m = [regex]::Match($TextoDump, '(?im)^\s*Set\s+DataSession\s+to\s+([A-Za-z_][A-Za-z0-9_]*)\s*\.\s*DataSessionId\s*$')
    if (-not $m.Success) { return $false }

    $nomeParam = [regex]::Escape($m.Groups[1].Value)

    # Prova positiva: o nome adotado eh parametro formal declarado no dump.
    return [bool]($TextoDump -match "(?im)^\s*(LParameters|Parameters)\b[^\r\n]*\b$nomeParam\b")
}

function Get-ContagemBotoesLegado {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return 0 }

    $nBotoes = ([regex]::Matches($TextoDump, '(?im)^\s*BaseClass:\s*commandbutton\s*$')).Count

    # 1a passada: quais objetos sao CommandGroup (a BaseClass aparece na secao
    # "Objeto:", a ButtonCount aparece na secao "PROPRIEDADES DE:")
    $grupos   = @{}
    $objAtual = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') {
            $objAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(\w+)\s*$') {
            if ($matches[1] -ieq 'commandgroup' -and $objAtual) {
                $grupos[$objAtual.ToUpper()] = $true
            }
        }
    }

    # 2a passada: soma a ButtonCount SO dos objetos identificados como grupo
    $objProp = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') {
            $partes  = $matches[1] -split '\.'
            $objProp = $partes[$partes.Count - 1]
        } elseif ($linha -match '^\s*ButtonCount\s*=\s*(\d+)\s*$') {
            if ($objProp -and $grupos.ContainsKey($objProp.ToUpper())) {
                $nBotoes += [int]$matches[1]
            }
        }
    }

    return $nBotoes
}

<#
.SYNOPSIS
    Devolve os NOMES dos objetos CommandButton declarados no dump legado.
.DESCRIPTION
    Irmao de Get-ContagemBotoesLegado (que devolve a CONTAGEM): reusa a mesma
    1a passada - "Objeto: <nome>" seguido de "BaseClass: <classe>" - para
    coletar os nomes dos botoes DECLARADOS, ja sem o caminho do pai
    ("SIGPRCOT.inserir" -> "inserir").

    Existe para que um gate possa perguntar "o legado tem um botao chamado
    Inserir e outro chamado Excluir?" SEM cair em substring no dump inteiro.
    A diferenca importa: o dump do SIGPRCOT contem a string "Delete From
    SigCdCot" (o SQL do delete.Click), entao procurar "delete" no texto cru
    casaria com CODIGO, nao com BOTAO. Olhando so as declaracoes, o mesmo
    dump devolve exatamente @('inserir','delete','sair').

    Tambem cobre o legado que nomeia o botao SEM o prefixo btn/cmd/Command -
    e o caso do SIGPRCOT, cujos tres botoes sao 'inserir', 'delete' e 'sair'
    (o SIGPRCAR, para comparar, usa cmdInserir/cmdExcluir/cmdSair).

    NAO soma os membros internos de CommandGroup: aqui interessa o botao com
    NOME PROPRIO declarado no SCX, nao o Command1/Command2 que o VFP cria
    dentro de um grupo.
#>
function Get-NomesBotoesLegado {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return @() }

    $nomes    = New-Object System.Collections.Generic.List[string]
    $objAtual = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') {
            $objAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(\w+)\s*$') {
            if ($matches[1] -ieq 'commandbutton' -and $objAtual) {
                $partes = $objAtual -split '\.'
                $nomes.Add($partes[$partes.Count - 1])
            }
        }
    }

    return $nomes.ToArray()
}

<#
.SYNOPSIS
    Decide se o modo CRUD ('pcEscolha') do dump legado eh RECEBIDO do chamador
    em vez de decidido pelo proprio form.
.DESCRIPTION
    'pcEscolha' eh a variavel de MODO do frmcadastro, mas um dialogo FILHO de
    uma tela de movimentacao recebe o modo e so o LE, sem ter CRUD nenhum. A
    forma ja tratada no gate eh a leitura direta do pai ("pForm.pcEscolha");
    esta funcao cobre a outra: o modo chega como PARAMETRO do Init
    ("LParameters pArq, pEsc, pObj" -> ".pcEscolha = pEsc").

    FAIL-CLOSED em duas camadas:
      (a) atribuicao de LITERAL a pcEscolha ancorada em inicio de linha
          ("ThisForm.pcEscolha = [INSERIR]") prova que o form DECIDE o proprio
          modo - devolve $false na hora, sem olhar mais nada. A ancora de
          inicio de linha eh o que separa COMANDO de COMPARACAO: o
          "If ThisForm.pcEscolha = 'INSERIR'" dos forms CRUD tem texto antes do
          nome na mesma linha e nao casa.
      (b) so devolve $true com a prova positiva de que alguma atribuicao a
          pcEscolha recebe um PARAMETRO FORMAL declarado no proprio dump.

    Medido em 2026-09-25 nos 579 dumps de tasks\: 29 forms tem 'pcEscolha' como
    unica evidencia de CRUD e apenas 4 mudam de veredicto por esta funcao -
    SigMvAte, SigMvChv, SigPrEml e SigMvTta, todos dialogos filhos ('Class:
    form', sem frmcadastro/Grupo_Op/botao CRUD) que recebem o modo por
    parametro. Os outros 25 seguem exigindo os quatro BtnXxxClick.
#>
function Test-ModoRecebidoDoChamador {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    # (a) O form decide o proprio modo? Entao NAO eh recebido.
    if ([regex]::IsMatch($TextoDump, '(?im)^\s*(ThisForm\.|This\.|\.)?pcEscolha\s*=\s*[\["'']')) {
        return $false
    }

    # (b) Parametros formais declarados no dump.
    $parametros = @{}
    foreach ($m in [regex]::Matches($TextoDump, '(?im)^\s*(?:LParameters|LParameter|Parameters)\s+(.+)$')) {
        foreach ($p in ($m.Groups[1].Value -split ',')) {
            $p = $p.Trim()
            if ($p -match '^[A-Za-z_][A-Za-z0-9_]*$') { $parametros[$p.ToUpper()] = $true }
        }
    }
    if ($parametros.Count -eq 0) { return $false }

    # (c) Alguma atribuicao a pcEscolha cujo valor eh um desses parametros?
    foreach ($m in [regex]::Matches($TextoDump, '(?im)^\s*(?:ThisForm\.|This\.|\.)?pcEscolha\s*=\s*([A-Za-z_][A-Za-z0-9_]*)\s*$')) {
        if ($parametros.ContainsKey($m.Groups[1].Value.ToUpper())) { return $true }
    }

    # (d) Terceira forma de RECEBER: a atribuicao LE o modo do form PAI dentro
    #     de uma expressao, com literal so como fallback -
    #       .pcEscolha = Iif(Type([ThisForm.ParentForm.pcEscolha])=[C], ;
    #                        .ParentForm.pcEscolha, [CONSULTAR])
    #     Quem decide o valor continua sendo o PAI; o literal eh o default de
    #     quando nao ha pai. As formas (c) e (d) diferem so no transporte
    #     (parametro formal x propriedade do pai).
    #     Continua FAIL-CLOSED: o guard (a) ja devolveu $false se em algum
    #     ponto o form atribui um LITERAL direto a pcEscolha, e aqui exige-se a
    #     referencia explicita ao pai do lado direito.
    foreach ($m in [regex]::Matches($TextoDump, '(?im)^\s*(?:ThisForm\.|This\.|\.)?pcEscolha\s*=\s*(.+)$')) {
        if ($m.Groups[1].Value -match '(?i)(ParentForm|pForm|poForm|oForm|oFormulario|par_oForm)\s*\.\s*pcEscolha') {
            return $true
        }
    }

    return $false
}

<#
.SYNOPSIS
    Detecta no dump do legado o padrao "dialogo de EXIBICAO": a tela TEM
    controle de entrada, mas TODOS eles sao somente-leitura (ReadOnly = .T.).

.DESCRIPTION
    Irmao de Get-ContagemBotoesLegado, usado pelas excecoes de gate das fases
    que pedem "lista"/"campos". Um dialogo de exibicao (ex.: SIGPDMEN, o popup
    "Mensagem da Movimentacao") tem UM EditBox ReadOnly onde o texto e' apenas
    mostrado: nao ha o que listar nem o que digitar. Para esse legado, exigir
    grade + botoes CRUD obrigaria a INVENTAR superficie que o legado nao tem
    (viola o PILAR 1) ou a escrever metodos-adaptador vazios (proibido pela
    regra de completude).

    FAIL-CLOSED por construcao: exige >= 1 controle de entrada E que TODOS
    declarem ReadOnly = .T.. Um unico campo editavel derruba a deteccao, que
    e' o caso da esmagadora maioria dos OPERACIONAL sem grade.

    Medido em 2026-09-25 nos 572 dumps de tasks\: 67 nao tem superficie de
    lista; destes, 24 tambem nao tem campo nenhum (criterio DESPACHANTE ja
    existente) e apenas 2 caem neste criterio - task573/SigMvMen e
    task140/SigPdMen, que sao o MESMO dialogo legado (SIGPDMEN).

.PARAMETER TextoDump
    Conteudo do arquivo <Base>_form_codigo_fonte.txt.
#>
<#
.SYNOPSIS
    Diz se algum .AddCursor(...) do legado realmente LIGA UMA GRADE
.DESCRIPTION
    Irma de Test-LegadoDialogoExibicao. O 5o argumento de AddCursor e' o GRID:

        .AddCursor('SigCdGrp','cgrus','CrSigCdGrp','', ThisForm.Pagina.Lista.Grade, lcQryGru)
                    tabela     chave   cursor       ''  <-- GRADE                   query

    Quando esse 5o argumento e' '' / "" / .f. / vazio, a chamada apenas REGISTRA
    um cursor no data manager (tipicamente para uma query de processamento em
    lote) e NAO existe grade nenhuma. A forma de 3 argumentos
    (.AddCursor('SigOpClU','CidChaves','CrSigOpClU')) sequer chega a posicao do
    grid.

    Medido em 2026-09-26 nos 585 dumps de tasks\: 1240 chamadas AddCursor, das
    quais 92 tem 3 argumentos e 355+742 tem 5 ou 6 - e em boa parte destas o 5o
    argumento e' '' ou .f., isto e', sem grade. Tratar "existe AddCursor" como
    "existe lista" e' portanto falso positivo, do mesmo tipo que o
    'ControlSource = ""' (string vazia) que ja motivou o teste ESTRITO do ramo
    CAPTURA.

    Usada SO pelo teste estrito da Fase 4/5 (ramo CAPTURA). O regex largo
    $temListaLegado dos ramos DESPACHANTE/EXIBICAO fica intocado, para nao
    mexer em comportamento ja validado.
.PARAMETER TextoDump
    Conteudo do dump <BaseName>_form_codigo_fonte.txt
#>
function Test-LegadoAddCursorLigaGrade {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    foreach ($m in [regex]::Matches($TextoDump, '(?i)\.AddCursor\s*\(([^\r\n]*)')) {
        $partes = $m.Groups[1].Value -split ','
        if ($partes.Count -lt 5) { continue }

        $arg5 = $partes[4].Trim()
        if ([string]::IsNullOrWhiteSpace($arg5)) { continue }
        if ($arg5 -match "^('\s*'|`"\s*`"|\.[fF]\.)$") { continue }

        return $true
    }

    return $false
}
<#
.SYNOPSIS
    Diz se algum RecordSource/ControlSource do SCX legado liga de fato uma LISTA
.DESCRIPTION
    Irma de Test-LegadoAddCursorLigaGrade, para o outro falso positivo do teste
    ESTRITO do ramo CAPTURA. Aquele trata AddCursor; este trata a linha
    'ControlSource = "..."' com valor NAO vazio.

    RecordSource e' propriedade de GRADE: valor nao vazio ali e' prova de lista.
    ControlSource, nao - ele liga UM valor a UM controle, e em CommandGroup/
    OptionGroup (grupo de botoes) e' so o Value do grupo. No SIGPRDFT a UNICA
    ocorrencia do dump e' 'ControlSource = "OPSENHA"' no bloco do CommandGroup
    SAIDA (ButtonCount = 1, o botao Cancelar) - vestigio herdado da classe
    Grupo_Saida do Framework Fortyus, que nao tem nada a ver com lista. Isso
    sozinho reprovava a Fase 4 de um dialogo modal de captura de pagamento
    SiTef que nao tem grade nenhuma (zero BaseClass grid/pageframe/listbox,
    zero pColuna, zero AddCursor), e a unica saida que sobrava era INVENTAR um
    Grid ou um PageFrame Lista/Dados - viola o PILAR 1 e a regra "NUNCA
    inventar" - ou escrever metodos-adaptador vazios, que e' o "stub
    disfarcado" proibido pela regra de completude.

    Medido em 2026-09-27 nos dumps de tasks\ (250 OPERACIONAL com dump +
    analise.json): ignorar ControlSource de CommandGroup/OptionGroup leva o
    ramo CAPTURA de 55 para 69 tasks, que sao apenas 5 forms legado distintos -
    sigprdft, sigproer, SIGPRSTF, SIGPRTFH e sigtosen. Conferidos um a um: os 5
    tem ZERO 'BaseClass: grid', ZERO 'BaseClass: pageframe', ZERO
    'BaseClass: listbox' e ZERO pColuna, e nos 5 a unica ocorrencia nao vazia
    e' o MESMO 'ControlSource = "OPSENHA"' no grupo SAIDA. Nao ha lista
    escondida em nenhum deles.

    Deliberadamente NAO se removeu ControlSource do teste: isso levaria a 75
    tasks, liberando tambem SigCdFis, SigPrSdd, SigPrTar e SigReEch, onde o
    ControlSource esta em controle de DADOS e pode ser vinculo a cursor de
    verdade. A correcao e' cirurgica, so no caso provado.

    FAIL-CLOSED: dono desconhecido (objeto que nao aparece na arvore da SECAO 1)
    conta como lista, e RecordSource conta sempre. Usada SO pelo teste estrito
    do ramo CAPTURA; o regex largo $temListaLegado dos ramos DESPACHANTE/
    EXIBICAO fica intocado.
.PARAMETER TextoDump
    Conteudo do dump <BaseName>_form_codigo_fonte.txt
#>
function Test-LegadoControlSourceLigaLista {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $linhas = $TextoDump -split "`r?`n"

    # 1a passada (SECAO 1 - arvore de objetos): BaseClass de cada objeto.
    $baseClass = @{}
    $objAtual  = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') {
            $objAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(\S+)\s*$') {
            if ($objAtual) { $baseClass[$objAtual.ToUpper()] = $matches[1].ToLower() }
        }
    }

    # 2a passada (SECAO 2 - propriedades): de quem e' cada RecordSource/
    # ControlSource. O cabecalho traz o caminho completo; a chave e' a ultima
    # parte, igual ao que Test-LegadoDialogoExibicao ja faz para ReadOnly.
    $objProp = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') {
            $partes  = $matches[1] -split '\.'
            $objProp = $partes[$partes.Count - 1].ToUpper()
        } elseif ($linha -match '^\s*(RecordSource|ControlSource)\s*=\s*"[^"]+"\s*$') {
            # RecordSource e' propriedade de grade: prova de lista, sempre.
            if ($matches[1] -ieq 'RecordSource') { return $true }

            # ControlSource: so NAO e' lista quando o dono e' grupo de botoes.
            if (-not $objProp) { return $true }
            if (-not $baseClass.ContainsKey($objProp)) { return $true }
            if ($baseClass[$objProp] -notin @('commandgroup', 'optiongroup')) { return $true }
        }
    }

    return $false
}
function Test-LegadoDialogoExibicao {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    # 1a passada (SECAO 1 - arvore de objetos): quais objetos sao controle de
    # entrada de dados. Label/Image/Shape/Container NAO contam - sao decoracao.
    $campos   = @{}
    $objAtual = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') {
            $objAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$') {
            if ($objAtual) { $campos[$objAtual.ToUpper()] = $false }
        }
    }

    if ($campos.Count -eq 0) { return $false }

    # 2a passada (SECAO 2 - propriedades): quais desses objetos declaram
    # ReadOnly = .T.. O cabecalho traz o caminho completo; a chave e' a ultima
    # parte, igual ao que Get-ContagemBotoesLegado ja faz para ButtonCount.
    $objProp = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') {
            $partes  = $matches[1] -split '\.'
            $objProp = $partes[$partes.Count - 1].ToUpper()
        } elseif ($linha -match '^\s*ReadOnly\s*=\s*\.T\.\s*$') {
            if ($objProp -and $campos.ContainsKey($objProp)) { $campos[$objProp] = $true }
        }
    }

    foreach ($v in $campos.Values) {
        if (-not $v) { return $false }
    }

    return $true
}
<#
.SYNOPSIS
    Diz se o SCX legado nao tem NENHUM campo digitavel (visualizador puro)
.DESCRIPTION
    Irma de Test-LegadoDialogoExibicao, para o caso que ela nao cobre. Aquela
    exige que o legado nao tenha LISTA e so reconhece ReadOnly = .T. declarado
    no proprio controle. Esta prova a mesma coisa - "nenhum campo do legado
    aceita digitacao" - aceitando as DUAS formas canonicas do Framework
    Fortyus e a heranca de container:

      a) ReadOnly = .T. no proprio controle (SECAO 2);
      b) ReadOnly = .T. num ANCESTRAL - Grid/Column propagam aos filhos, e o
         SCX costuma declarar so 'ReadOnly = .T.' + 'ColumnN.ReadOnly = .T.'
         no bloco do Grid, sem repetir em cada Text1;
      c) PROCEDURE When devolvendo .F. INCONDICIONALMENTE (SECAO 3) - o jeito
         mais comum de tornar um fwget nao-digitavel. Medido no dump do
         SIGMVSBN: Get_items/Get_descr/Get_valo NAO declaram ReadOnly, a
         tela inteira e' somente-leitura apenas por causa do When.

    Retorna $true so quando EXISTE campo e TODO campo esta provado
    somente-leitura. Zero campo devolve $false de proposito: isso e'
    despachante/splash, coberto por outro ramo.

    Por que importa: campo somente-leitura nao recebe lookup nem validacao de
    digitacao - nao ha onde o usuario digitar codigo para o picker resolver.
    Exigir AbrirLookup*/Validar* de um visualizador obrigaria a INVENTAR
    comportamento que o legado nao tem (viola o PILAR 1 e a regra "NUNCA
    inventar tabelas de lookup que nao existem no original") ou a criar metodo
    vazio (proibido pela regra de completude).

    Medido em 2026-09-25 nos 576 dumps de tasks\: 29 dumps sao somente-leitura,
    26 deles sem lookup, e 24 nao eram cobertos pelo ramo EXIBICAO - todos
    visualizadores de verdade (conferidos SIGCDICN, sigmvpen, SigMvSbn). Nao e'
    atalho largo: 4% dos dumps, e com tasks repetidas o total de forms
    distintos e' menor ainda.
#>
function Test-LegadoSomenteLeitura {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $linhas = $TextoDump -split "`r?`n"

    # 1a passada (SECAO 1 - arvore de objetos): caminho COMPLETO de cada
    # controle de ENTRADA de dados. Label/Image/Shape/Container NAO contam.
    # O caminho completo (Parent + "." + Objeto) e' necessario porque a
    # heranca de ReadOnly vem do ancestral - nome curto nao permite subir.
    $campos   = @{}
    $objAtual = ""
    $paiAtual = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\s*Objeto:') {
            # Zera SEMPRE: "Objeto:" sem nome (ha entradas vazias no dump) nao
            # pode herdar o nome do objeto anterior.
            $objAtual = ""
            $paiAtual = ""
            if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') { $objAtual = $matches[1] }
        } elseif ($linha -match '^\s*Parent:\s*(\S+)\s*$') {
            $paiAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$') {
            if ($objAtual) {
                $caminho = if ($paiAtual -and $paiAtual -ne '(raiz)') { "$paiAtual.$objAtual" } else { $objAtual }
                $campos[$caminho.ToUpper()] = $false
            }
        }
    }

    if ($campos.Count -eq 0) { return $false }

    # 2a passada (SECAO 2 - propriedades): ReadOnly = .T., do proprio objeto do
    # bloco ou de um descendente declarado por caminho RELATIVO dentro dele
    # (Column3.ReadOnly = .T. / Column3.Text1.ReadOnly = .T. no bloco do Grid).
    $somenteLeitura = @{}
    $objProp = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:') {
            $objProp = ""
            if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') { $objProp = $matches[1].ToUpper() }
        } elseif ($objProp -and $linha -match '^\s*ReadOnly\s*=\s*\.T\.\s*$') {
            $somenteLeitura[$objProp] = $true
        } elseif ($objProp -and $linha -match '^\s*([\w\.]+)\.ReadOnly\s*=\s*\.T\.\s*$') {
            $somenteLeitura["$objProp.$($matches[1].ToUpper())"] = $true
        }
    }

    # 3a passada (SECAO 3 - metodos): PROCEDURE When que devolve .F. sem
    # condicao nenhuma. Aceita "Return .f.", "Return (.F.)" e "Return(.f.)" -
    # as tres grafias aparecem no MESMO dump do SIGMVSBN. When com qualquer
    # outra linha util NAO conta: pode devolver .T. em algum caminho.
    $objMet = ""
    $emWhen = $false
    $corpo  = @()
    foreach ($linha in $linhas) {
        if ($linha -match '^\*\s*OBJETO:\s*(\S+)\s*$') {
            $objMet = $matches[1].ToUpper()
            continue
        }
        if (-not $emWhen) {
            if ($linha -match '^\s*PROCEDURE\s+When\s*$') {
                $emWhen = $true
                $corpo  = @()
            }
            continue
        }
        if ($linha -match '^\s*ENDPROC\s*$') {
            $emWhen = $false
            # @(...) obrigatorio: com UMA linha util o pipeline devolve String,
            # e $uteis[0] numa String da o primeiro CARACTERE, nao a linha.
            $uteis = @($corpo | ForEach-Object { $_.Trim() } |
                       Where-Object { $_ -ne '' -and $_ -notmatch '^\*' -and $_ -notmatch '^&&' })
            if ($objMet -and $uteis.Count -eq 1 -and
                $uteis[0] -match '(?i)^Return\s*\(?\s*\.F\.\s*\)?\s*$') {
                $somenteLeitura[$objMet] = $true
            }
        } else {
            $corpo += $linha
        }
    }

    # Veredito: UM campo digitavel derruba a excecao.
    foreach ($caminho in @($campos.Keys)) {
        if ($somenteLeitura[$caminho]) { continue }

        # Sobe a hierarquia: Grid/Column com ReadOnly = .T. propaga aos filhos.
        $herdou = $false
        $partes = $caminho -split '\.'
        for ($i = $partes.Count - 2; $i -ge 0; $i--) {
            if ($somenteLeitura[(($partes[0..$i]) -join '.')]) { $herdou = $true; break }
        }
        if (-not $herdou) { return $false }
    }

    return $true
}


<#
.SYNOPSIS
    Diz se TODO evento Click do SCX legado apenas FECHA o form
.DESCRIPTION
    Prova de que o legado nao tem botao de ACAO nenhum: o unico comportamento
    de clique da tela eh "ThisForm.Release". Usado pelo gate da Fase 8 para nao
    exigir handler de gravar/processar de um visualizador somente-leitura.

    Retorna:
      $true  - existe pelo menos um PROCEDURE *Click e TODOS eles so fecham
      $false - existe Click que faz outra coisa (ha botao de acao)
      $null  - o dump nao tem Click nenhum => NAO SEI (quem chama mantem a
               exigencia; form REPORT herda o Click dos botoes do frmrelatorio
               e o SCX nao os declara)

    Por que nao basta olhar o NOME do botao: medido em 2026-09-24 nos 565 dumps
    de tasks\, "legado com UM botao so" sozinho da 58 forms, e entre eles ha
    botao de acao de verdade com nome que nenhuma lista de palavras pega -
    btnCopiar (SigCdOrc), btnCargas (SigCdUpd), btnApagar (SIGCDSET),
    cmdLimSenha (SigCdUsu), "Carrega ibpt" (SIGCDIBP), "Gera Inventario TXT"
    (SigReInv). Olhando o CORPO do Click sobram 8 forms, e so 7 com 1 botao.
#>
function Test-LegadoCliqueSoFecha {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $null }

    # [^\S\r\n] = espaco/tab SEM quebra de linha: impede o \s* de atravessar
    # linhas e casar um ENDPROC de outro metodo.
    $blocos = [regex]::Matches($TextoDump, '(?ims)^PROCEDURE[^\S\r\n]+[\w\.]*Click[^\S\r\n]*\r?$(.*?)^ENDPROC[^\S\r\n]*\r?$')
    if ($blocos.Count -eq 0) { return $null }

    foreach ($bloco in $blocos) {
        $linhas = ($bloco.Groups[1].Value -split "`r?`n") |
                  ForEach-Object { $_.Trim() } |
                  Where-Object { $_ -ne '' -and $_ -notmatch '^\*' -and $_ -notmatch '^&&' }

        foreach ($linha in $linhas) {
            # Aceita ThisForm.Release / Form.Release / =ThisForm.Release() /
            # Release Thisform. Qualquer outra instrucao = botao de acao.
            if ($linha -notmatch '(?i)^(=\s*)?(This)?Form\.Release(\s*\(\s*\))?$' -and
                $linha -notmatch '(?i)^Release[^\S\r\n]+Thisform$') {
                return $false
            }
        }
    }

    return $true
}

<#
.SYNOPSIS
    Executa uma fase espec�fica da migra��o
.DESCRIPTION
    Invoca Claude CLI com prompt focado em uma parte do formul�rio
#>
