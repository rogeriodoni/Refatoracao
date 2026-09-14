#==============================================================================
# VFPExecutor.ps1
#
# PROPOSITO: Executa scripts Visual FoxPro 9 com config.fpw customizado
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-01-22
# VERSAO: 2.0 - Refatorado para usar sintaxe direta de parametros
#==============================================================================

param(
    [Parameter(Mandatory=$false)]
    [string]$ConfigFpw,

    [Parameter(Mandatory=$true)]
    [string]$ScriptPrg,

    [Parameter(Mandatory=$false)]
    [array]$Parameters = @(),

    [Parameter(Mandatory=$false)]
    [hashtable]$Variables,

    [Parameter(Mandatory=$false)]
    [int]$Timeout = 120,

    [Parameter(Mandatory=$false)]
    [string]$LogFile,

    [Parameter(Mandatory=$false)]
    [string]$OutputFile
)

$ErrorActionPreference = "Stop"

#------------------------------------------------------------------------------
# Configuracao
#------------------------------------------------------------------------------

$VFP9_PATH = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\VFP9.EXE"

# IMPORTANTE: GetTempFileName() cria um arquivo .tmp vazio que conflita com VFP
# Usamos nomes aleatorios sem criar arquivo .tmp intermediario
$tempDir = [System.IO.Path]::GetTempPath()
$randomId = [System.IO.Path]::GetRandomFileName() -replace '\..*$', ''
$TEMP_CONFIG_FPW = Join-Path $tempDir "vfp_config_$randomId.fpw"
$TEMP_WRAPPER_PRG = Join-Path $tempDir "vfp_wrapper_$randomId.prg"

#------------------------------------------------------------------------------
# Funcoes auxiliares
#------------------------------------------------------------------------------

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"

    Write-Host $logMessage

    if ($LogFile) {
        Add-Content -Path $LogFile -Value $logMessage -ErrorAction SilentlyContinue
    }
}

function New-TempConfigFpw {
    param([string]$BaseConfig)

    # Le config base (simplificado - apenas configuracoes VFP)
    $content = Get-Content -Path $BaseConfig -Raw

    # Salva config temporario
    $content | Set-Content -Path $TEMP_CONFIG_FPW -Encoding ASCII

    Write-Log "Config.fpw temporario criado: $TEMP_CONFIG_FPW"
}

function ConvertTo-VFPParameter {
    param([object]$Value)

    if ($null -eq $Value) {
        return ".NULL."
    }
    elseif ($Value -is [string]) {
        # Escapa aspas simples (duplica elas no VFP)
        $escaped = $Value -replace "'", "''"
        return "'$escaped'"
    }
    elseif ($Value -is [int] -or $Value -is [double]) {
        return $Value.ToString()
    }
    elseif ($Value -is [bool]) {
        return if ($Value) { ".T." } else { ".F." }
    }
    else {
        # Para outros tipos, converte para string
        $escaped = $Value.ToString() -replace "'", "''"
        return "'$escaped'"
    }
}

function New-WrapperPRG {
    param([string]$ScriptToRun, [hashtable]$Vars)

    if (-not $Vars -or $Vars.Count -eq 0) {
        return $null
    }

    # Cria script wrapper que define variáveis PUBLIC e executa o script original
    $wrapperContent = "* Auto-generated wrapper script`r`n"
    $wrapperContent += "* Defines PUBLIC variables and executes: $ScriptToRun`r`n`r`n"
    $wrapperContent += "* Anti-dialog protections for unattended execution`r`n"
    $wrapperContent += "SET SAFETY OFF`r`n"
    $wrapperContent += "SET RESOURCE OFF`r`n"
    $wrapperContent += "SET TALK OFF`r`n"
    $wrapperContent += "SET NOTIFY OFF`r`n"
    $wrapperContent += "SYS(2335, 0)`r`n"
    $wrapperContent += "`r`n"

    # Adiciona declarações de variáveis PUBLIC
    foreach ($key in $Vars.Keys) {
        $value = $Vars[$key]
        # Escapa aspas duplas (duplica elas)
        $value = $value -replace '"', '""'
        $wrapperContent += "PUBLIC _$key`r`n"
        $wrapperContent += "_$key = `"$value`"`r`n"
    }

    $wrapperContent += "`r`n"
    $wrapperContent += "DO $ScriptToRun`r`n"
    $wrapperContent += "RETURN`r`n"

    # Salva wrapper
    $wrapperContent | Set-Content -Path $TEMP_WRAPPER_PRG -Encoding ASCII

    Write-Log "Wrapper PRG criado: $TEMP_WRAPPER_PRG"
    return $TEMP_WRAPPER_PRG
}

function Build-VFPCommandString {
    param(
        [string]$ScriptPath,
        [array]$Params,
        [hashtable]$Vars
    )

    # Remove extensao .prg do caminho (VFP nao quer extensao na linha de comando)
    $scriptPathSemExtensao = $ScriptPath
    if ($ScriptPath -match "\.prg$") {
        $scriptPathSemExtensao = $ScriptPath -replace "\.prg$", ""
    }

    # Inicia com o caminho do script (sem extensao)
    $command = $scriptPathSemExtensao

    # Se houver parametros, criar wrapper PRG (VFP9.EXE nao suporta sintaxe funcao())
    # Prioriza array de parametros (ordem explicitamente controlada)
    if ($Params -and $Params.Count -gt 0) {
        $paramStrings = @()

        foreach ($value in $Params) {
            $vfpParam = ConvertTo-VFPParameter -Value $value
            $paramStrings += $vfpParam
        }

        # Monta a lista de parametros para DO ... WITH
        $paramsJoined = $paramStrings -join ", "

        # Cria wrapper temporario que executa o script com parametros
        $wrapperContent = "* Auto-generated wrapper for parameters`r`n"
        $wrapperContent += "* Script: $ScriptPath`r`n"
        $wrapperContent += "* Parameters: $paramsJoined`r`n`r`n"
        $wrapperContent += "* Anti-dialog protections for unattended execution`r`n"
        $wrapperContent += "SET SAFETY OFF`r`n"
        $wrapperContent += "SET RESOURCE OFF`r`n"
        $wrapperContent += "SET TALK OFF`r`n"
        $wrapperContent += "SET NOTIFY OFF`r`n"
        $wrapperContent += "SYS(2335, 0)`r`n"
        $wrapperContent += "`r`n"
        $wrapperContent += "DO `"$scriptPathSemExtensao`" WITH $paramsJoined`r`n"
        $wrapperContent += "QUIT`r`n"

        # Salva wrapper
        $wrapperContent | Set-Content -Path $script:TEMP_WRAPPER_PRG -Encoding ASCII

        Write-Log "Wrapper PRG criado para parametros: $script:TEMP_WRAPPER_PRG"
        Write-Log "Conteudo do wrapper:"
        Write-Log $wrapperContent

        # Retorna o wrapper COM extensao .prg (VFP9.EXE aceita path completo)
        $command = $script:TEMP_WRAPPER_PRG
    }
    # Fallback: Se nao houver array, usa hashtable (ordem alfabetica por chave)
    elseif ($Vars -and $Vars.Count -gt 0) {
        $paramStrings = @()

        # Ordena as chaves para garantir ordem consistente
        $sortedKeys = $Vars.Keys | Sort-Object

        foreach ($key in $sortedKeys) {
            $value = $Vars[$key]
            $vfpParam = ConvertTo-VFPParameter -Value $value
            $paramStrings += $vfpParam
        }

        # Monta a lista de parametros para DO ... WITH
        $paramsJoined = $paramStrings -join ", "

        # Cria wrapper temporario que executa o script com parametros
        $wrapperContent = "* Auto-generated wrapper for parameters`r`n"
        $wrapperContent += "* Script: $ScriptPath`r`n"
        $wrapperContent += "* Parameters: $paramsJoined`r`n`r`n"
        $wrapperContent += "* Anti-dialog protections for unattended execution`r`n"
        $wrapperContent += "SET SAFETY OFF`r`n"
        $wrapperContent += "SET RESOURCE OFF`r`n"
        $wrapperContent += "SET TALK OFF`r`n"
        $wrapperContent += "SET NOTIFY OFF`r`n"
        $wrapperContent += "SYS(2335, 0)`r`n"
        $wrapperContent += "`r`n"
        $wrapperContent += "DO `"$scriptPathSemExtensao`" WITH $paramsJoined`r`n"
        $wrapperContent += "QUIT`r`n"

        # Salva wrapper
        $wrapperContent | Set-Content -Path $script:TEMP_WRAPPER_PRG -Encoding ASCII

        Write-Log "Wrapper PRG criado para parametros (hashtable): $script:TEMP_WRAPPER_PRG"

        # Retorna o wrapper COM extensao .prg (VFP9.EXE aceita path completo)
        $command = $script:TEMP_WRAPPER_PRG
    }

    return $command
}

#------------------------------------------------------------------------------
# Validacoes
#------------------------------------------------------------------------------

Write-Log "=== VFP EXECUTOR v2.0 ===" "INFO"
Write-Log "Config FPW: $(if ($ConfigFpw) { $ConfigFpw } else { '(nao fornecido)' })"
Write-Log "Script PRG: $ScriptPrg"
Write-Log "Timeout: $Timeout segundos"

if (-not (Test-Path $VFP9_PATH)) {
    Write-Log "ERRO: Visual FoxPro 9 nao encontrado em: $VFP9_PATH" "ERROR"
    exit 1
}

if ($ConfigFpw -and -not (Test-Path $ConfigFpw)) {
    Write-Log "ERRO: Config.fpw nao encontrado: $ConfigFpw" "ERROR"
    exit 2
}

if (-not (Test-Path $ScriptPrg)) {
    Write-Log "ERRO: Script PRG nao encontrado: $ScriptPrg" "ERROR"
    exit 3
}

#------------------------------------------------------------------------------
# Prepara execucao
#------------------------------------------------------------------------------

try {
    # Determina modo de execucao:
    # 1. Com Parameters (array): Cria wrapper.prg com DO ... WITH
    # 2. Com Variables (hashtable): Cria wrapper.prg com variaveis PUBLIC
    # 3. Sem parametros: Executa script diretamente

    $usarWrapperVariables = ($Variables -and $Variables.Count -gt 0)
    $usarWrapperParams = ($Parameters -and $Parameters.Count -gt 0)
    $usarWrapper = $usarWrapperVariables -or $usarWrapperParams
    $scriptParaExecutar = $ScriptPrg

    if ($usarWrapperVariables) {
        # Modo com Variables: cria config.fpw e wrapper.prg com variaveis PUBLIC
        if ($ConfigFpw) {
            New-TempConfigFpw -BaseConfig $ConfigFpw
        }

        $wrapperPath = New-WrapperPRG -ScriptToRun $ScriptPrg -Vars $Variables
        if ($wrapperPath) {
            $scriptParaExecutar = $wrapperPath
        }

        # Usa path completo COM extensao .prg (VFP9.EXE aceita)
        $vfpCommand = $scriptParaExecutar
    }
    else {
        # Modo com Parameters ou sem parametros: Build-VFPCommandString cria wrapper se necessario
        # Cria config.fpw temporario se fornecido (necessario para -C flag)
        if ($usarWrapperParams -and $ConfigFpw) {
            New-TempConfigFpw -BaseConfig $ConfigFpw
        }
        $vfpCommand = Build-VFPCommandString -ScriptPath $ScriptPrg -Params $Parameters -Vars $null
    }

    Write-Log "Comando VFP: $vfpCommand"

    #--------------------------------------------------------------------------
    # Determina arquivo de output do VFP
    #--------------------------------------------------------------------------

    # Prioriza OutputFile se fornecido, senao usa TASK_DIR do Variables, senao usa TEMP
    if ($OutputFile) {
        $vfpOutputFile = $OutputFile
    }
    elseif ($Variables -and $Variables.ContainsKey("TASK_DIR")) {
        $vfpOutputFile = Join-Path $Variables["TASK_DIR"] "vfp_output.txt"
    } else {
        $vfpOutputFile = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "vfp_output.txt")
    }

    # Remove arquivo de output anterior se existir
    if (Test-Path $vfpOutputFile) {
        Remove-Item $vfpOutputFile -Force -ErrorAction SilentlyContinue
    }

    Write-Log "VFP output esperado em: $vfpOutputFile"

    #--------------------------------------------------------------------------
    # Executa VFP9
    #--------------------------------------------------------------------------

    Write-Log "Executando Visual FoxPro 9..."

    $startTime = Get-Date

    # Monta argumentos do processo
    $processArgs = @()

    # -T: Suppresses VFP startup config dialog (resource file, config.fpw not found, etc.)
    #     Prevents modal dialogs that block unattended execution
    $processArgs += "-T"

    # Adiciona -C config.fpw se estiver usando wrapper (modo Variables)
    if ($usarWrapper -and $ConfigFpw) {
        $processArgs += "-C"
        $processArgs += $TEMP_CONFIG_FPW
    }

    # Adiciona comando VFP (script ou script+parametros)
    $processArgs += $vfpCommand

    Write-Log "Comando completo: VFP9.EXE $($processArgs -join ' ')"

    # Usa Start-Process com timeout para evitar travamento indefinido
    $exitCode = 0
    try {
        $argsString = $processArgs -join ' '
        Write-Log "Executando: VFP9.EXE $argsString"
        Write-Log "Timeout configurado: $Timeout segundos"

        # Start-Process com -PassThru para controlar o processo
        $process = Start-Process -FilePath $VFP9_PATH -ArgumentList $argsString -PassThru -NoNewWindow

        # Aguarda com timeout
        $timeoutMs = $Timeout * 1000
        $exited = $process.WaitForExit($timeoutMs)

        if (-not $exited) {
            # TIMEOUT: VFP9 nao finalizou no tempo esperado
            Write-Log "TIMEOUT: VFP9 nao finalizou em $Timeout segundos. Encerrando processo (PID: $($process.Id))..." "ERROR"

            # Mata o processo principal
            try {
                $process | Stop-Process -Force -ErrorAction SilentlyContinue
            } catch {
                Write-Log "Aviso: Erro ao matar processo principal: $($_.Exception.Message)" "WARN"
            }

            # Aguarda um pouco e mata qualquer VFP9 residual (processos filhos)
            Start-Sleep -Seconds 2
            $residualProcesses = Get-Process -Name "vfp9" -ErrorAction SilentlyContinue
            if ($residualProcesses) {
                Write-Log "Encerrando $($residualProcesses.Count) processo(s) VFP9 residual(is)..." "WARN"
                $residualProcesses | Stop-Process -Force -ErrorAction SilentlyContinue
                Start-Sleep -Seconds 1
            }

            $exitCode = 4  # Exit code 4 = TIMEOUT
        }
        else {
            $exitCode = $process.ExitCode
            Write-Log "VFP9 finalizou normalmente com exit code: $exitCode"
        }
    }
    catch {
        Write-Log "Excecao durante execucao do VFP: $($_.Exception.Message)" "ERROR"
        # Em caso de excecao, garantir que nao ha VFP9 travado
        Get-Process -Name "vfp9" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
        $exitCode = 99
    }

    $endTime = Get-Date
    $duration = ($endTime - $startTime).TotalSeconds

    Write-Log "VFP9 finalizado em $duration segundos"
    Write-Log "Exit Code: $exitCode"
    Write-Log ""

    #--------------------------------------------------------------------------
    # Captura output do VFP
    #--------------------------------------------------------------------------

    # Output do script (via SET ALTERNATE ou ? commands)
    if (Test-Path $vfpOutputFile) {
        Write-Log "=== Output do VFP (capturado via SET ALTERNATE) ==="
        Get-Content $vfpOutputFile | ForEach-Object { Write-Log $_ }
        Write-Log "=== Fim do Output do VFP ==="
        Write-Log ""
    }

    # Output capturado do console
    if (Test-Path "$env:TEMP\vfp_combined_output.txt") {
        $combinedOutput = Get-Content "$env:TEMP\vfp_combined_output.txt" -Raw
        if ($combinedOutput -and $combinedOutput.Trim()) {
            Write-Log "=== Output Capturado do Console ==="
            Write-Log $combinedOutput
            Write-Log "=== Fim Output Console ==="
        }
    }

    Write-Log "Arquivos temporarios preservados para inspecao:"
    if ($ConfigFpw -and (Test-Path $TEMP_CONFIG_FPW)) {
        Write-Log "  Config.fpw: $TEMP_CONFIG_FPW"
    }
    if ($usarWrapper -and (Test-Path $TEMP_WRAPPER_PRG)) {
        Write-Log "  Wrapper.prg: $TEMP_WRAPPER_PRG"
    }
    if (Test-Path $vfpOutputFile) {
        Write-Log "  VFP Output: $vfpOutputFile"
    }
    Write-Log ""

    #--------------------------------------------------------------------------
    # DEBUG: Log conteudo dos arquivos temporarios
    #--------------------------------------------------------------------------

    if ($ConfigFpw -and (Test-Path $TEMP_CONFIG_FPW)) {
        Write-Log "=== Conteudo do Config.fpw temporario ==="
        Get-Content $TEMP_CONFIG_FPW | ForEach-Object { Write-Log $_ }
        Write-Log "=== Fim do Config.fpw ==="
    }

    if ($usarWrapper -and (Test-Path $TEMP_WRAPPER_PRG)) {
        Write-Log "=== Conteudo do Wrapper.prg temporario ==="
        Get-Content $TEMP_WRAPPER_PRG | ForEach-Object { Write-Log $_ }
        Write-Log "=== Fim do Wrapper.prg ==="
    }

    #--------------------------------------------------------------------------
    # Cleanup (COMENTADO para debug - deletar depois)
    #--------------------------------------------------------------------------

    # NOTA: Arquivos temporarios NAO serao deletados para permitir inspecao manual
    # Localizacao: $TEMP_CONFIG_FPW, $TEMP_WRAPPER_PRG (se usados)

    # if ($ConfigFpw -and (Test-Path $TEMP_CONFIG_FPW)) {
    #     Remove-Item $TEMP_CONFIG_FPW -Force -ErrorAction SilentlyContinue
    # }
    # if ($usarWrapper -and (Test-Path $TEMP_WRAPPER_PRG)) {
    #     Remove-Item $TEMP_WRAPPER_PRG -Force -ErrorAction SilentlyContinue
    # }

    #--------------------------------------------------------------------------
    # Resultado
    #--------------------------------------------------------------------------

    if ($exitCode -eq 0) {
        Write-Log "SUCESSO: Script VFP executado com sucesso" "INFO"
    }
    elseif ($exitCode -eq 4) {
        Write-Log "TIMEOUT: VFP9 excedeu o tempo limite de $Timeout segundos e foi encerrado forcadamente" "ERROR"
    }
    else {
        # VFP9.EXE (app GUI legado) frequentemente retorna exit code 1 mesmo quando
        # o script executa com sucesso. O orquestrador valida pelo arquivo de saida,
        # nao pelo exit code. Log como WARN para nao alarmar desnecessariamente.
        Write-Log "AVISO: VFP9 retornou exit code $exitCode (normal para VFP9 GUI - validar pelo arquivo de saida)" "WARN"
    }

    exit $exitCode
}
catch {
    Write-Log "ERRO: Excecao ao executar VFP: $($_.Exception.Message)" "ERROR"
    Write-Log "Stack Trace: $($_.ScriptStackTrace)" "ERROR"

    # Cleanup em caso de erro
    if ($ConfigFpw -and (Test-Path $TEMP_CONFIG_FPW)) {
        Remove-Item $TEMP_CONFIG_FPW -Force -ErrorAction SilentlyContinue
    }
    if (Test-Path $TEMP_WRAPPER_PRG) {
        Remove-Item $TEMP_WRAPPER_PRG -Force -ErrorAction SilentlyContinue
    }

    exit 99
}
