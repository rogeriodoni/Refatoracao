#==============================================================================
# ClaudeInvoker.ps1
#
# PROPOSITO: Wrapper para invocar Claude CLI com retry logic e logging
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-01-22
#==============================================================================

param(
    [Parameter(Mandatory=$true)]
    [string]$PromptFile,

    [Parameter(Mandatory=$false)]
    [string]$OutputFile,

    [Parameter(Mandatory=$false)]
    [string]$Model = "sonnet",

    [Parameter(Mandatory=$false)]
    [int]$Timeout = 600,

    [Parameter(Mandatory=$false)]
    [string]$LogFile,

    [Parameter(Mandatory=$false)]
    [string[]]$ContextFiles = @(),

    # --- Rate Limit Retry ---
    [Parameter(Mandatory=$false)]
    [int]$RateLimitMaxRetries = 6,

    [Parameter(Mandatory=$false)]
    [int]$RateLimitInitialDelaySeconds = 65,

    [Parameter(Mandatory=$false)]
    [int]$RateLimitMaxDelaySeconds = 600,

    [Parameter(Mandatory=$false)]
    [int]$RateLimitBackoffMultiplier = 2,

    # --- Usage Limit Retry ---
    # Fallback usado quando a mensagem de erro nao contem retry-after
    [Parameter(Mandatory=$false)]
    [int]$UsageLimitWaitSeconds = 25200,

    # --- Max Output Tokens ---
    # Controla CLAUDE_CODE_MAX_OUTPUT_TOKENS para evitar truncamento de output
    [Parameter(Mandatory=$false)]
    [int]$MaxOutputTokens = 128000,

    # --- Fail Fast on Usage Limit ---
    # Quando true, detecta usage limit e sai IMEDIATAMENTE (exit 50)
    # sem esperar reset. Usado pelo OrquestradorComplexo.
    [Parameter(Mandatory=$false)]
    [switch]$FailFastOnUsageLimit = $false
)

$ErrorActionPreference = "Stop"

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

function Test-ClaudeCLI {
    try {
        $result = & claude --version 2>&1
        return $?
    }
    catch {
        return $false
    }
}

#------------------------------------------------------------------------------
# Validacoes
#------------------------------------------------------------------------------

Write-Log "=== CLAUDE CLI INVOKER ===" "INFO"
Write-Log "Prompt File: $PromptFile"
Write-Log "Output File: $OutputFile"
Write-Log "Model: $Model"
Write-Log "Timeout: $Timeout segundos"
Write-Log "Max Output Tokens: $MaxOutputTokens"
Write-Log "Context Files: $($ContextFiles.Count) arquivo(s)"

# Verifica se arquivo de prompt existe
if (-not (Test-Path $PromptFile)) {
    Write-Log "ERRO: Arquivo de prompt nao encontrado: $PromptFile" "ERROR"
    exit 1
}

# Verifica se Claude CLI esta instalado
if (-not (Test-ClaudeCLI)) {
    Write-Log "ERRO: Claude CLI nao encontrado. Instale via: npm install -g @anthropic-ai/claude-code" "ERROR"
    exit 2
}

# Cria diretorio de output se necessario
if ($OutputFile) {
    $outputDir = Split-Path -Parent $OutputFile
    if ($outputDir -and -not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
        Write-Log "Diretorio de output criado: $outputDir"
    }
}

#------------------------------------------------------------------------------
# Invoca Claude CLI
#------------------------------------------------------------------------------

Write-Log "Invocando Claude CLI..."

try {
    # Le o conteudo do prompt
    $promptContent = Get-Content -Path $PromptFile -Raw
    Write-Log "Prompt carregado: $($promptContent.Length) caracteres"

    # Adiciona arquivos de contexto ao prompt (se houver)
    $fullPrompt = ""

    if ($ContextFiles.Count -gt 0) {
        Write-Log "Adicionando $($ContextFiles.Count) arquivo(s) de contexto ao prompt..."

        foreach ($file in $ContextFiles) {
            if (Test-Path $file) {
                $fileName = Split-Path -Leaf $file
                $ext = [System.IO.Path]::GetExtension($file).ToLower()

                # Imagens: usar referencia @path (Claude CLI resolve nativamente)
                if ($ext -in @(".png", ".jpg", ".jpeg", ".gif", ".webp")) {
                    $fullPrompt += "## Screenshot de referencia: $fileName`n"
                    $fullPrompt += "@$file`n`n"
                    Write-Log "  - $fileName (imagem via @referencia)"
                }
                else {
                    # Arquivos texto: embutir conteudo no prompt
                    $fileContent = Get-Content -Path $file -Raw -Encoding UTF8

                    $fullPrompt += "## Arquivo: $fileName`n"
                    $fullPrompt += "Caminho: ``$file```n`n"
                    $fullPrompt += "``````n"
                    $fullPrompt += $fileContent
                    $fullPrompt += "`n``````n`n"

                    Write-Log "  - $fileName ($($fileContent.Length) chars)"
                }
            }
            else {
                Write-Log "  AVISO: Arquivo nao encontrado: $file" "WARN"
            }
        }

        $fullPrompt += "`n---`n`n"
    }

    # Adiciona o prompt principal
    $fullPrompt += $promptContent

    # Executa Claude CLI
    # NOTA: Claude CLI le de stdin, entao precisamos passar o prompt via pipeline
    Write-Log "Executando: claude --model $Model --dangerously-skip-permissions --add-dir C:\4c"
    Write-Log "Tamanho total do prompt: $($fullPrompt.Length) caracteres"

    $startTime = Get-Date

    # -------------------------------------------------------------------------
    # Invoca Claude CLI com retry automatico para rate limit
    # -------------------------------------------------------------------------
    $rlRetry       = 0
    $rlDelay       = $RateLimitInitialDelaySeconds
    $exitCode      = -1
    $result        = $null

    while ($true) {
        Write-Log "Invocando Claude CLI (tentativa $($rlRetry + 1)/$($RateLimitMaxRetries + 1))..."

        # Executa com timeout real usando background job
        # CRITICO: Set-Location "C:\4c" dentro do job para que o Claude CLI
        # rode com CWD=C:\4c (sandbox permite acesso ao diretorio de trabalho).
        # Sem isso, o job herda CWD do usuario (ex: Documents) e o sandbox bloqueia C:\4c.
        # NOTA: Passamos model e flags como strings separadas ao inves de array,
        # porque Start-Job -ArgumentList achata arrays em argumentos posicionais.
        $invokeBlock = [scriptblock]::Create('
            param($prompt, $modelName, $maxTokens)
            Set-Location "C:\4c"
            # CRITICO: Remove variavel CLAUDECODE para permitir execucao
            # quando invocado de dentro de outra sessao Claude Code
            Remove-Item Env:CLAUDECODE -ErrorAction SilentlyContinue
            # CRITICO: Define limite maximo de tokens de output para evitar
            # "Claude response exceeded the XXXXX output token maximum"
            $env:CLAUDE_CODE_MAX_OUTPUT_TOKENS = "$maxTokens"
            $out = $prompt | & claude --model $modelName --dangerously-skip-permissions --add-dir "C:\4c" 2>&1
            return @{ ExitCode = $LASTEXITCODE; Output = $out }
        ')
        $job = Start-Job -ScriptBlock $invokeBlock -ArgumentList $fullPrompt, $Model, $MaxOutputTokens
        $completed = $job | Wait-Job -Timeout $Timeout

        if (-not $completed) {
            # Timeout atingido - mata o job e processos claude/node associados
            Stop-Job $job
            Remove-Job $job -Force
            # Mata processos node que possam ser o claude CLI
            Get-Process -Name "node","claude" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
            Write-Log "TIMEOUT: Claude CLI excedeu $Timeout segundos - processo encerrado" "ERROR"
            exit 1
        }

        $jobResult = Receive-Job $job
        Remove-Job $job -Force
        $result   = $jobResult.Output
        $exitCode = $jobResult.ExitCode

        if ($exitCode -eq 0) {
            break   # Sucesso - sai do loop
        }

        # Detecta rate limit / usage limit / overloaded
        $resultStr     = ($result | Out-String)
        $isRateLimit   = $resultStr -match "(?i)(rate.limit|too.many.request|429|overloaded|usage.limit.reach)"
        $isUsageLimit  = $resultStr -match "(?i)(usage.limit|credit|quota.exceed|billing|hit.{0,10}(your|the).{0,10}limit|resets?\s+\d)"

        if ($isUsageLimit -and -not ($resultStr -match "(?i)rate.limit")) {
            # Limite de uso da conta (janela de consumo) - aguardar ate reset da janela
            Write-Log "" "WARN"
            Write-Log "========================================================" "WARN"
            Write-Log " LIMITE DE USO DA CONTA ATINGIDO" "WARN"
            Write-Log "========================================================" "WARN"
            Write-Log "" "WARN"
            Write-Log "Output do erro:" "WARN"
            Write-Log $resultStr "WARN"

            # === FAIL FAST MODE (OrquestradorComplexo) ===
            # Salva output e sai imediatamente com exit code 50
            if ($FailFastOnUsageLimit) {
                Write-Log "FailFastOnUsageLimit ativado. Salvando output e saindo com exit code 50." "WARN"
                if ($OutputFile -and $result) {
                    $result | Set-Content -Path $OutputFile -Encoding UTF8
                    Write-Log "Output salvo em: $OutputFile"
                }
                exit 50
            }

            if ($rlRetry -ge $RateLimitMaxRetries) {
                Write-Log "Numero maximo de tentativas atingido ($RateLimitMaxRetries). Abortando." "ERROR"
                exit $exitCode
            }

            # Tenta extrair retry-after da mensagem de erro
            $waitSeconds = 0
            if ($resultStr -match "(?i)retry.{0,10}after.{0,5}(\d+)\s*s") {
                $waitSeconds = [int]$Matches[1]
                Write-Log " [retry-after] extraido da mensagem: ${waitSeconds}s" "WARN"
            }
            elseif ($resultStr -match "(?i)resets?\s+(\d{1,2})\s*(am|pm)") {
                # Parse "resets 11pm" ou "resets 3am" - calcula segundos ate o horario
                $resetHour = [int]$Matches[1]
                $resetAmPm = $Matches[2].ToLower()
                if ($resetAmPm -eq "pm" -and $resetHour -ne 12) { $resetHour += 12 }
                elseif ($resetAmPm -eq "am" -and $resetHour -eq 12) { $resetHour = 0 }
                $now = Get-Date
                $resetTime = Get-Date -Hour $resetHour -Minute 0 -Second 0
                if ($resetTime -le $now) { $resetTime = $resetTime.AddDays(1) }
                $waitSeconds = [int]($resetTime - $now).TotalSeconds + 120  # +2min margem
                Write-Log " [resets] Detectado reset as ${resetHour}h. Aguardar ${waitSeconds}s (ate $($resetTime.ToString('HH:mm')))" "WARN"
            }
            elseif ($resultStr -match "(?i)(\d+)\s*hour") {
                $waitSeconds = [int]$Matches[1] * 3600
                Write-Log " [retry-after] extraido da mensagem: $([int]$Matches[1]) hora(s) = ${waitSeconds}s" "WARN"
            }
            elseif ($resultStr -match "(?i)(\d+)\s*min") {
                $waitSeconds = [int]$Matches[1] * 60
                Write-Log " [retry-after] extraido da mensagem: $([int]$Matches[1]) minuto(s) = ${waitSeconds}s" "WARN"
            }

            if ($waitSeconds -le 0) {
                $waitSeconds = $UsageLimitWaitSeconds
                Write-Log " [retry-after] nao encontrado na mensagem. Usando padrao: ${waitSeconds}s ($([Math]::Round($waitSeconds / 3600, 1))h)" "WARN"
            }

            $rlRetry++
            $etaTime = (Get-Date).AddSeconds($waitSeconds).ToString("HH:mm:ss")

            Write-Log "" "WARN"
            Write-Log "========================================================" "WARN"
            Write-Log (" Aguardando {0}s ({1:0.#}h). Retomando as {2}..." -f $waitSeconds, ($waitSeconds / 3600), $etaTime) "WARN"
            Write-Log " Pressione Ctrl+C para interromper." "WARN"
            Write-Log "========================================================" "WARN"
            Write-Log "" "WARN"

            # Countdown com intervalos de 5 min (ou 30s para esperas curtas < 5 min)
            $intervalo = if ($waitSeconds -gt 300) { 300 } else { 30 }
            for ($s = $waitSeconds; $s -gt 0; $s -= $intervalo) {
                $horas   = [Math]::Floor($s / 3600)
                $minutos = [Math]::Floor(($s % 3600) / 60)
                $segs    = $s % 60
                Write-Log ("  Retomando em {0:00}h {1:00}m {2:00}s..." -f $horas, $minutos, $segs) "WARN"
                Start-Sleep -Seconds ([Math]::Min($intervalo, $s))
            }

            continue
        }

        if ($isRateLimit) {
            if ($rlRetry -ge $RateLimitMaxRetries) {
                Write-Log "Rate limit persistiu apos $RateLimitMaxRetries tentativas. Abortando." "ERROR"
                Write-Log "Output: $resultStr" "ERROR"
                exit $exitCode
            }

            $rlRetry++
            Write-Log "" "WARN"
            Write-Log "========================================================" "WARN"
            Write-Log " RATE LIMIT DETECTADO (tentativa $rlRetry/$RateLimitMaxRetries)" "WARN"
            Write-Log " Aguardando ${rlDelay}s para reset do limite da API..." "WARN"
            Write-Log "========================================================" "WARN"
            Write-Log "" "WARN"

            # Countdown visivel
            for ($s = $rlDelay; $s -gt 0; $s -= 10) {
                Write-Log "  Retomando em ${s}s..." "WARN"
                Start-Sleep -Seconds ([Math]::Min(10, $s))
            }

            # Backoff exponencial com cap
            $rlDelay = [Math]::Min($rlDelay * $RateLimitBackoffMultiplier, $RateLimitMaxDelaySeconds)
            continue
        }

        # Outro tipo de erro - nao e rate limit, sai imediatamente
        break
    }

    $endTime  = Get-Date
    $duration = ($endTime - $startTime).TotalSeconds

    Write-Log "Claude CLI finalizado em $duration segundos"
    Write-Log "Exit Code: $exitCode"

    # Salva output se especificado
    if ($OutputFile -and $result) {
        $result | Set-Content -Path $OutputFile -Encoding UTF8
        Write-Log "Output salvo em: $OutputFile"
        Write-Log "Output size: $((Get-Item $OutputFile).Length) bytes"
    }

    # Verifica se houve erro
    if ($exitCode -ne 0) {
        Write-Log "ERRO: Claude CLI retornou codigo de erro: $exitCode" "ERROR"
        Write-Log "Output: $result" "ERROR"
        exit $exitCode
    }

    Write-Log "SUCESSO: Claude CLI executado com sucesso" "INFO"

    # Mostra preview do output (primeiras linhas nao-vazias)
    if ($result) {
        $resultStr = ($result | Out-String).Trim()
        $preview = $resultStr.Substring(0, [Math]::Min(500, $resultStr.Length))
        Write-Log "Preview do output:"
        Write-Log $preview
    }

    exit 0
}
catch {
    Write-Log "ERRO: Excecao ao invocar Claude CLI: $($_.Exception.Message)" "ERROR"
    Write-Log "Stack Trace: $($_.ScriptStackTrace)" "ERROR"
    exit 99
}
