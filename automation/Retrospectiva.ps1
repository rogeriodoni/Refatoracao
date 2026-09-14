<#
.SYNOPSIS
    Retrospectiva automatica pos-rodada do RunLoop.
    Analisa resultados, identifica padroes de falha, e propoe/aplica melhorias.

.DESCRIPTION
    Fase 1: Gera relatorio markdown com analise de falhas e sugestoes
    Fase 2: Aplica patterns seguros automaticamente (CorretorAutomatico em forms falhados)
    Fase 3: Recovery - tenta recuperar tasks falhadas com Claude CLI + re-teste

.PARAMETER TasksDir
    Diretorio das tasks (default: C:\4c\tasks)
.PARAMETER OutputDir
    Diretorio para salvar relatorios (default: C:\4c\automation\retrospectivas)
#>
param(
    [string]$TasksDir = "C:\4c\tasks",
    [string]$OutputDir = "C:\4c\automation\retrospectivas",
    [string]$AutomationDir = "C:\4c\automation",
    [int]$UltimasNTasks = 20
)

# ============================================================================
# Configuracao
# ============================================================================
$configFile = Join-Path $AutomationDir "config.json"
$config = $null
if (Test-Path $configFile) {
    $config = Get-Content $configFile -Raw | ConvertFrom-Json
}

if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

$timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$reportFile = Join-Path $OutputDir "retrospectiva_$timestamp.md"

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " RETROSPECTIVA AUTOMATICA" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

# ============================================================================
# FASE 1: Coletar e analisar resultados
# ============================================================================
Write-Host ""
Write-Host "[FASE 1] Coletando resultados das tasks..." -ForegroundColor Yellow

# Encontrar as ultimas N tasks (por data de criacao)
$taskDirs = Get-ChildItem -Path $TasksDir -Directory -Filter "task*" |
    Where-Object { Test-Path (Join-Path $_.FullName "task_state.json") } |
    Sort-Object {
        $state = Get-Content (Join-Path $_.FullName "task_state.json") -Raw | ConvertFrom-Json
        $state.criadoEm
    } -Descending |
    Select-Object -First $UltimasNTasks

Write-Host "  Tasks encontradas: $($taskDirs.Count)"

$resultados = @()
foreach ($td in $taskDirs) {
    $stateFile = Join-Path $td.FullName "task_state.json"
    $state = Get-Content $stateFile -Raw | ConvertFrom-Json

    $etapaFalha = $null
    $erroMsg = $null
    $statusFinal = "COMPLETED"
    $tentativasTotal = 0

    foreach ($prop in $state.etapas.PSObject.Properties) {
        $etapa = $prop.Value
        $tentativasTotal += [int]$etapa.tentativas
        if ($etapa.status -eq "FAILED") {
            $etapaFalha = $prop.Name
            $erroMsg = $etapa.erro
            $statusFinal = "FAILED"
        }
    }

    # Determinar se completou (tem etapa 08 completa)
    if ($state.etapas."08_gerarTestManual" -and $state.etapas."08_gerarTestManual".status -eq "COMPLETED") {
        $statusFinal = "COMPLETED"
    }

    $resultados += [PSCustomObject]@{
        TaskId = $td.Name
        BaseName = if ($state.etapas."01_moverArquivos".baseName) { $state.etapas."01_moverArquivos".baseName } else { "?" }
        FormType = if ($state.etapas."03_gerarMetaPrompt".formType) { $state.etapas."03_gerarMetaPrompt".formType } else { "?" }
        Status = $statusFinal
        EtapaFalha = $etapaFalha
        ErroMsg = $erroMsg
        TentativasTotal = $tentativasTotal
        CriadoEm = $state.criadoEm
        AtualizadoEm = $state.atualizadoEm
        TestesPct = if ($state.etapas."06b_testeAutomatico".percentual) { $state.etapas."06b_testeAutomatico".percentual } else { 0 }
        UIErros = if ($state.etapas."07_validarUI".erros) { [int]$state.etapas."07_validarUI".erros } else { 0 }
        UIDiffs = if ($state.etapas."07_validarUI".diferencas) { [int]$state.etapas."07_validarUI".diferencas } else { 0 }
        Complexidade = if ($state.etapas."05_migracao".complexidade) { $state.etapas."05_migracao".complexidade } else { "?" }
    }
}

$completed = @($resultados | Where-Object { $_.Status -eq "COMPLETED" })
$failed = @($resultados | Where-Object { $_.Status -eq "FAILED" })
$taxa = if ($resultados.Count -gt 0) { [math]::Round(($completed.Count / $resultados.Count) * 100, 1) } else { 0 }

Write-Host "  Completadas: $($completed.Count) | Falhadas: $($failed.Count) | Taxa: $taxa%"

# ============================================================================
# Classificar falhas por tipo
# ============================================================================
Write-Host ""
Write-Host "[FASE 1] Classificando falhas por tipo..." -ForegroundColor Yellow

$falhasPorEtapa = @{}
$falhasPorTipo = @{
    "COMPILACAO" = @()
    "TESTE_AUTO" = @()
    "UI_FIDELITY" = @()
    "CODE_REVIEW" = @()
    "COMPLETUDE" = @()
    "OUTRO" = @()
}

foreach ($f in $failed) {
    # Contagem por etapa
    if (-not $falhasPorEtapa.ContainsKey($f.EtapaFalha)) {
        $falhasPorEtapa[$f.EtapaFalha] = @()
    }
    $falhasPorEtapa[$f.EtapaFalha] += $f

    # Classificacao por tipo
    switch -Wildcard ($f.EtapaFalha) {
        "05c*" { $falhasPorTipo["COMPILACAO"] += $f }
        "06b*" { $falhasPorTipo["TESTE_AUTO"] += $f }
        "07*"  { $falhasPorTipo["UI_FIDELITY"] += $f }
        "05e*" { $falhasPorTipo["CODE_REVIEW"] += $f }
        "05d*" { $falhasPorTipo["COMPLETUDE"] += $f }
        default { $falhasPorTipo["OUTRO"] += $f }
    }
}

# ============================================================================
# Identificar padroes recorrentes nas mensagens de erro
# ============================================================================
Write-Host "[FASE 1] Identificando padroes de erro..." -ForegroundColor Yellow

$padroes = @{}
foreach ($f in $failed) {
    if ($f.ErroMsg) {
        # Extrair keywords do erro
        $keywords = @()
        if ($f.ErroMsg -match "CREATEOBJECT") { $keywords += "CREATEOBJECT_FALHA" }
        if ($f.ErroMsg -match "Property.*not found") { $keywords += "PROPERTY_NOT_FOUND" }
        if ($f.ErroMsg -match "nesting.*exceeded") { $keywords += "NESTING_EXCEEDED" }
        if ($f.ErroMsg -match "UI Fidelity") { $keywords += "UI_FIDELITY" }
        if ($f.ErroMsg -match "Syntax error") { $keywords += "SYNTAX_ERROR" }
        if ($f.ErroMsg -match "Variable.*not found") { $keywords += "VARIABLE_NOT_FOUND" }
        if ($f.ErroMsg -match "Prompt is too long") { $keywords += "PROMPT_TOO_LONG" }
        if ($f.ErroMsg -match "diferencas visuais") { $keywords += "UI_DIFFS" }
        if ($f.ErroMsg -match "Unknown member") { $keywords += "UNKNOWN_MEMBER" }

        if ($keywords.Count -eq 0) { $keywords += "OUTRO" }

        foreach ($kw in $keywords) {
            if (-not $padroes.ContainsKey($kw)) { $padroes[$kw] = @() }
            $padroes[$kw] += $f.TaskId
        }
    }
}

# ============================================================================
# Gerar relatorio markdown (FASE 1 output)
# ============================================================================
Write-Host ""
Write-Host "[FASE 1] Gerando relatorio..." -ForegroundColor Yellow

$report = @"
# Retrospectiva Automatica - $(Get-Date -Format 'yyyy-MM-dd HH:mm')

## Resumo

| Metrica | Valor |
|---------|-------|
| Tasks analisadas | $($resultados.Count) |
| Completadas | $($completed.Count) ($taxa%) |
| Falhadas | $($failed.Count) |

## Tasks Completadas

| Task | Form | Tipo | Testes |
|------|------|------|--------|
$(foreach ($c in $completed) { "| $($c.TaskId) | $($c.BaseName) | $($c.FormType) | $($c.TestesPct)% |`n" })

## Tasks Falhadas

| Task | Form | Tipo | Etapa Falha | Erro |
|------|------|------|-------------|------|
$(foreach ($f in $failed) { "| $($f.TaskId) | $($f.BaseName) | $($f.FormType) | $($f.EtapaFalha) | $($f.ErroMsg.Substring(0, [Math]::Min(80, $f.ErroMsg.Length)))... |`n" })

## Falhas por Etapa

$(foreach ($key in ($falhasPorEtapa.Keys | Sort-Object)) {
    $tasks = $falhasPorEtapa[$key]
    "- **$key**: $($tasks.Count) task(s) - $($tasks.BaseName -join ', ')`n"
})

## Padroes de Erro Recorrentes

$(foreach ($key in ($padroes.Keys | Sort-Object)) {
    $tasks = $padroes[$key]
    "- **$key** ($($tasks.Count)x): $($tasks -join ', ')`n"
})

## UI Fidelity - Detalhes

| Task | Form | Erros | Diffs | Avisos |
|------|------|-------|-------|--------|
$(foreach ($r in ($resultados | Where-Object { $_.UIErros -gt 0 -or $_.UIDiffs -gt 0 })) { "| $($r.TaskId) | $($r.BaseName) | $($r.UIErros) | $($r.UIDiffs) | |`n" })
"@

$report | Set-Content $reportFile -Encoding UTF8
Write-Host "  Relatorio salvo: $reportFile" -ForegroundColor Green

# ============================================================================
# FASE 2: Aplicar correcoes automaticas seguras
# ============================================================================
Write-Host ""
Write-Host "[FASE 2] Aplicando correcoes automaticas seguras..." -ForegroundColor Yellow

$correcoesFase2 = 0

# 2.1 - Rodar CorretorAutomatico nos forms que falharam em compilacao ou teste
$formsParaCorrigir = @()
foreach ($f in $failed) {
    if ($f.EtapaFalha -match "05c|06|06b") {
        $taskPath = Join-Path $TasksDir $f.TaskId
        $stateFile = Join-Path $taskPath "task_state.json"
        $state = Get-Content $stateFile -Raw | ConvertFrom-Json

        $formFile = $state.etapas."05_migracao".formFile
        $boFile = $state.etapas."05_migracao".boFile

        if ($formFile -and (Test-Path $formFile)) {
            $formsParaCorrigir += @{ Form = $formFile; BO = $boFile; TaskId = $f.TaskId; BaseName = $f.BaseName }
        }
    }
}

if ($formsParaCorrigir.Count -gt 0) {
    Write-Host "  Rodando CorretorAutomatico em $($formsParaCorrigir.Count) form(s)..." -ForegroundColor Cyan
    foreach ($item in $formsParaCorrigir) {
        Write-Host "    - $($item.BaseName)..." -NoNewline
        try {
            $corretorOutput = & (Join-Path $AutomationDir "CorretorAutomatico.ps1") -ArquivoPRG $item.Form 2>&1
            $nCorrecoes = ($corretorOutput | Select-String "correcao\(oes\) aplicada").Count
            if ($nCorrecoes -gt 0) {
                Write-Host " $nCorrecoes correcao(oes)" -ForegroundColor Green
                $correcoesFase2 += $nCorrecoes
            } else {
                Write-Host " sem correcoes" -ForegroundColor Gray
            }

            if ($item.BO -and (Test-Path $item.BO)) {
                $corretorOutputBO = & (Join-Path $AutomationDir "CorretorAutomatico.ps1") -ArquivoPRG $item.BO 2>&1
            }
        }
        catch {
            Write-Host " ERRO: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

# 2.2 - Verificar PageFrame.Visible ausente em TODOS os forms
Write-Host ""
Write-Host "  Verificando PageFrame.Visible em todos os forms..." -ForegroundColor Cyan
$allForms = Get-ChildItem -Path (Join-Path $config.paths.projeto "app\forms") -Filter "Form*.prg" -Recurse -ErrorAction SilentlyContinue
$visibleFixes = 0
foreach ($f in $allForms) {
    $lines = Get-Content $f.FullName
    $content = $lines -join "`n"
    $hasPageFrame = $content -match 'pgf_4c_Paginas'
    $hasVisible = $content -match 'pgf_4c_Paginas\.Visible\s*=\s*\.T\.'
    if ($hasPageFrame -and -not $hasVisible) {
        $newLines = @()
        $added = $false
        foreach ($line in $lines) {
            if (-not $added -and $line -match 'pgf_4c_Paginas\.ActivePage\s*=\s*1') {
                $indent = ''
                if ($line -match '^(\s+)') { $indent = $matches[1] }
                $newLines += $indent + 'THIS.pgf_4c_Paginas.Visible = .T.'
                $added = $true
            }
            $newLines += $line
        }
        if ($added) {
            Set-Content $f.FullName $newLines
            $visibleFixes++
            Write-Host "    CORRIGIDO PageFrame.Visible: $($f.Name)" -ForegroundColor Green
        }
    }
}
if ($visibleFixes -eq 0) {
    Write-Host "    Todos os forms ja tem PageFrame.Visible" -ForegroundColor Gray
}

# 2.3 - Limpar .fxp
Write-Host ""
Write-Host "  Limpando cache .fxp..." -ForegroundColor Cyan
$fxpCount = (Get-ChildItem -Path (Join-Path $config.paths.projeto "app") -Filter "*.fxp" -Recurse -ErrorAction SilentlyContinue).Count
Get-ChildItem -Path (Join-Path $config.paths.projeto "app") -Filter "*.fxp" -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
Write-Host "    $fxpCount arquivos .fxp removidos" -ForegroundColor Gray

# ============================================================================
# Adicionar resumo da Fase 2 ao relatorio
# ============================================================================
$fase2Report = @"

## Fase 2 - Correcoes Automaticas Aplicadas

- **CorretorAutomatico**: $correcoesFase2 correcao(oes) em $($formsParaCorrigir.Count) form(s)
- **PageFrame.Visible**: $visibleFixes form(s) corrigido(s)
- **Cache .fxp**: $fxpCount arquivo(s) removido(s)
"@

Add-Content $reportFile $fase2Report -Encoding UTF8

# ============================================================================
# FASE 3: Recovery - Tentar recuperar tasks falhadas
# ============================================================================
$recoveredTasks = @()
$recoveryMaxAttempts = 3

if ($failed.Count -gt 0 -and $config) {
    Write-Host ""
    Write-Host "[FASE 3] Tentando recuperar $($failed.Count) task(s) falhada(s)..." -ForegroundColor Yellow

    foreach ($f in $failed) {
        $taskPath = Join-Path $TasksDir $f.TaskId
        $stateFile = Join-Path $taskPath "task_state.json"
        $state = Get-Content $stateFile -Raw | ConvertFrom-Json

        # Obter caminhos dos arquivos gerados
        $formFile = $null
        $boFile = $null
        $formClass = $null
        $formType = $null

        if ($state.etapas."05_migracao") {
            $formFile = $state.etapas."05_migracao".formFile
            $boFile = $state.etapas."05_migracao".boFile
        }

        # Tentar inferir formClass do nome do arquivo
        if ($formFile -and (Test-Path $formFile)) {
            $formClass = [System.IO.Path]::GetFileNameWithoutExtension($formFile)
        }

        $formType = $f.FormType
        if ([string]::IsNullOrEmpty($formType) -or $formType -eq "?") { $formType = "CRUD" }

        if (-not $formFile -or -not (Test-Path $formFile)) {
            Write-Host "  [$($f.TaskId)] Sem arquivo de form - pulando" -ForegroundColor Gray
            continue
        }

        Write-Host ""
        Write-Host "  [$($f.TaskId)] $($f.BaseName) - Erro: $($f.EtapaFalha)" -ForegroundColor Cyan
        Write-Host "    $($f.ErroMsg.Substring(0, [Math]::Min(120, $f.ErroMsg.Length)))" -ForegroundColor DarkGray

        $recovered = $false

        for ($attempt = 1; $attempt -le $recoveryMaxAttempts; $attempt++) {
            Write-Host "    --- Tentativa $attempt/$recoveryMaxAttempts ---" -ForegroundColor White

            # 3.1 - Chamar Claude CLI para diagnosticar e corrigir
            $fixPrompt = @"
Voce e o corretor de bugs VFP9. Corrija o erro abaixo no codigo migrado.

## ERRO
Etapa: $($f.EtapaFalha)
Mensagem: $($f.ErroMsg)

## REGRAS CRITICAS VFP9
- NUNCA usar propriedades inexistentes: AllowAddNew, AllowDelete, AllowEdit, GridColor
- Metodos chamados via BINDEVENT ou TesteAutomatico DEVEM ser PUBLIC (nao PROTECTED)
- AlternarPagina, AjustarBotoesPorModo, CarregarLista devem ser PUBLIC
- NVL(campo,0)=1 para campos BIT: usar IIF(VARTYPE(campo)="L", campo, (NVL(campo,0)=1))
- NUNCA IIF aninhado do mesmo pattern (loop de correcao)
- USE IN SELECT("cursor") IN 0 -> IF USED("cursor") / USE IN cursor / ENDIF
- FormBuscaAuxiliar.Show() sem parametros (nao Show(1))
- PROTECTED methods nao podem ser chamados externamente

## INSTRUCOES
1. Leia o arquivo do form: $formFile
$(if ($boFile -and (Test-Path $boFile)) { "2. Leia o arquivo do BO: $boFile" })
3. Identifique a causa raiz do erro
4. Aplique a correcao minima necessaria (NAO refatore codigo funcional)
5. Salve os arquivos corrigidos

IMPORTANTE: Faca APENAS a correcao necessaria para resolver o erro especifico.
"@

            $fixPromptFile = Join-Path $taskPath "recovery_prompt_t${attempt}.md"
            $fixOutputFile = Join-Path $taskPath "recovery_output_t${attempt}.txt"
            $fixPrompt | Set-Content $fixPromptFile -Encoding UTF8

            try {
                Write-Host "    [Claude] Diagnosticando..." -NoNewline
                & (Join-Path $AutomationDir "ClaudeInvoker.ps1") `
                    -PromptFile $fixPromptFile `
                    -OutputFile $fixOutputFile `
                    -Model "sonnet" `
                    -Timeout 600 `
                    -MaxOutputTokens 32000 `
                    -ContextFiles @() `
                    -RateLimitMaxRetries 3 `
                    -RateLimitInitialDelaySeconds 65 `
                    -RateLimitMaxDelaySeconds 300

                if (Test-Path $fixOutputFile) {
                    $fixOutput = Get-Content $fixOutputFile -Raw
                    Write-Host " OK ($([Math]::Round((Get-Item $fixOutputFile).Length/1024, 1))KB)" -ForegroundColor Green
                } else {
                    Write-Host " sem output" -ForegroundColor Yellow
                }
            }
            catch {
                Write-Host " ERRO: $($_.Exception.Message)" -ForegroundColor Red
                continue
            }

            # 3.2 - Rodar CorretorAutomatico
            Write-Host "    [Corretor] Aplicando patterns..." -NoNewline
            try {
                $null = & (Join-Path $AutomationDir "CorretorAutomatico.ps1") -ArquivoPrg $formFile -TaskDir $taskPath 2>&1
                if ($boFile -and (Test-Path $boFile)) {
                    $null = & (Join-Path $AutomationDir "CorretorAutomatico.ps1") -ArquivoPrg $boFile -TaskDir $taskPath 2>&1
                }
                Write-Host " OK" -ForegroundColor Green
            }
            catch {
                Write-Host " ERRO" -ForegroundColor Red
            }

            # 3.3 - Limpar .fxp
            Get-ChildItem -Path (Join-Path $config.paths.projeto "app") -Filter "*.fxp" -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue

            # 3.4 - Re-rodar TesteAutomatico
            Write-Host "    [Teste] Executando TesteAutomatico..." -NoNewline
            try {
                $null = & (Join-Path $AutomationDir "VFPExecutor.ps1") `
                    -ScriptPrg (Join-Path $config.paths.projeto "app\utils\TesteAutomatico.prg") `
                    -Parameters @($formClass, $taskPath, $formType) `
                    -Timeout 120 2>&1

                $resultFile = Join-Path $taskPath "teste_resultado.json"
                if (Test-Path $resultFile) {
                    $resultado = Get-Content $resultFile -Raw | ConvertFrom-Json
                    $pct = $resultado.resumo.percentual

                    if ($pct -ge 100) {
                        Write-Host " $($resultado.resumo.passou)/$($resultado.resumo.total) (${pct}%) - RECUPERADO!" -ForegroundColor Green
                        $recovered = $true

                        # Atualizar task_state.json
                        $state = Get-Content $stateFile -Raw | ConvertFrom-Json
                        $state.status = "COMPLETED"
                        $state.statusComentario = "RECOVERED pela Retrospectiva Fase 3 (tentativa $attempt)"
                        $state.atualizadoEm = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ss")

                        # Marcar etapa falhada como recuperada
                        $etapaObj = $state.etapas.PSObject.Properties[$f.EtapaFalha]
                        if ($etapaObj) {
                            $etapaObj.Value | Add-Member -NotePropertyName "recoveredAt" -NotePropertyValue (Get-Date).ToString("yyyy-MM-ddTHH:mm:ss") -Force
                            $etapaObj.Value | Add-Member -NotePropertyName "recoveredBy" -NotePropertyValue "Retrospectiva_Fase3" -Force
                            $etapaObj.Value.status = "RECOVERED"
                        }

                        # Adicionar metricas do teste
                        if (-not $state.etapas."06b_testeAutomatico") {
                            $state.etapas | Add-Member -NotePropertyName "06b_testeAutomatico" -NotePropertyValue ([PSCustomObject]@{}) -Force
                        }
                        $state.etapas."06b_testeAutomatico" | Add-Member -NotePropertyName "status" -NotePropertyValue "RECOVERED" -Force
                        $state.etapas."06b_testeAutomatico" | Add-Member -NotePropertyName "percentual" -NotePropertyValue $pct -Force
                        $state.etapas."06b_testeAutomatico" | Add-Member -NotePropertyName "total" -NotePropertyValue $resultado.resumo.total -Force
                        $state.etapas."06b_testeAutomatico" | Add-Member -NotePropertyName "passou" -NotePropertyValue $resultado.resumo.passou -Force

                        $state | ConvertTo-Json -Depth 10 | Set-Content $stateFile -Encoding UTF8
                        $recoveredTasks += $f

                        break  # Sair do loop de tentativas
                    } else {
                        $falhas = ($resultado.testes | Where-Object { -not $_.passou } | ForEach-Object { $_.erro }) -join " | "
                        Write-Host " $($resultado.resumo.passou)/$($resultado.resumo.total) (${pct}%)" -ForegroundColor Yellow
                        Write-Host "      Falhas: $($falhas.Substring(0, [Math]::Min(100, $falhas.Length)))" -ForegroundColor DarkYellow

                        # Atualizar erroMsg para proxima tentativa usar erro atual
                        $f.ErroMsg = "Testes: ${pct}%. Falhas: $falhas"
                    }
                } else {
                    Write-Host " sem resultado" -ForegroundColor Yellow
                }
            }
            catch {
                Write-Host " ERRO: $($_.Exception.Message)" -ForegroundColor Red
            }
        }

        if (-not $recovered) {
            Write-Host "    [$($f.TaskId)] NAO recuperada apos $recoveryMaxAttempts tentativa(s)" -ForegroundColor Red
        }
    }
}

# Adicionar resumo da Fase 3 ao relatorio
$fase3Report = @"

## Fase 3 - Recovery

- **Tasks falhadas**: $($failed.Count)
- **Recuperadas**: $($recoveredTasks.Count)
$(if ($recoveredTasks.Count -gt 0) {
    "- **Detalhes**: $(($recoveredTasks | ForEach-Object { "$($_.TaskId) ($($_.BaseName))" }) -join ', ')"
})
$(if ($failed.Count -gt $recoveredTasks.Count) {
    $naoRecuperadas = $failed | Where-Object { $_.TaskId -notin $recoveredTasks.TaskId }
    "- **Nao recuperadas**: $(($naoRecuperadas | ForEach-Object { "$($_.TaskId) ($($_.BaseName))" }) -join ', ')"
})
"@

Add-Content $reportFile $fase3Report -Encoding UTF8

# Atualizar contadores para relatorio final
$completedFinal = $completed.Count + $recoveredTasks.Count
$failedFinal = $failed.Count - $recoveredTasks.Count
$taxaFinal = if ($resultados.Count -gt 0) { [math]::Round(($completedFinal / $resultados.Count) * 100, 1) } else { 0 }

# ============================================================================
# FASE 2.5: Persistir aprendizados via Claude (analise + atualizacao de artefatos)
# ============================================================================
# Fase 2.5 roda apenas para tasks que NAO foram recuperadas na Fase 3
$stillFailed = @($failed | Where-Object { $_.TaskId -notin $recoveredTasks.TaskId })

if ($stillFailed.Count -ge 1 -and $config) {
    Write-Host ""
    Write-Host "[FASE 2.5] Persistindo aprendizados de $($stillFailed.Count) falha(s) nao-recuperada(s)..." -ForegroundColor Yellow

    # Ler artefatos atuais para contexto
    $skillPatterns = ""
    $skillPatternsFile = "C:\4c\.claude\skills\vfp9-migration\migration-patterns.md"
    if (Test-Path $skillPatternsFile) {
        $skillPatterns = Get-Content $skillPatternsFile -Raw -Encoding UTF8
        # Truncar para nao estourar contexto
        if ($skillPatterns.Length -gt 10000) { $skillPatterns = $skillPatterns.Substring(0, 10000) + "`n... (truncado)" }
    }

    $corretorPatterns = ""
    $corretorPatternsFile = "C:\4c\.claude\skills\vfp9-migration\corretor-patterns.md"
    if (Test-Path $corretorPatternsFile) {
        $corretorPatterns = Get-Content $corretorPatternsFile -Raw -Encoding UTF8
        if ($corretorPatterns.Length -gt 5000) { $corretorPatterns = $corretorPatterns.Substring(0, 5000) + "`n... (truncado)" }
    }

    $analysisPrompt = @"
Voce e o analisador de retrospectiva do pipeline de migracao VFP9.

## RESULTADOS DESTA RODADA
- $($completed.Count) completadas, $($failed.Count) falhadas (taxa: $taxa%)

## FALHAS DETALHADAS
$(foreach ($f in $failed) { "- **$($f.TaskId)** ($($f.BaseName), $($f.FormType)): Etapa ``$($f.EtapaFalha)`` - $($f.ErroMsg)`n" })

## PADROES DETECTADOS
$(foreach ($key in $padroes.Keys) { "- **$key** ($($padroes[$key].Count)x): $($padroes[$key] -join ', ')`n" })

## PATTERNS JA EXISTENTES NA SKILL (NAO REPETIR)
$skillPatterns

## PATTERNS JA EXISTENTES NO CORRETOR (NAO REPETIR)
$corretorPatterns

## TAREFA

Analise as falhas e faca EXATAMENTE estas acoes:

### 1. IDENTIFICAR licoes novas (que NAO estao nos patterns existentes)
Para cada licao nova, descreva:
- Qual erro ocorreu
- Causa raiz
- Regra para prevenir

### 2. ATUALIZAR migration-patterns.md
Adicione novas secoes numeradas (continuar a numeracao existente) com codigo ERRADO vs CORRETO.
Arquivo: $skillPatternsFile

### 3. ATUALIZAR corretor-patterns.md
Se a licao e automatizavel por regex, adicione na tabela de patterns.
Arquivo: $corretorPatternsFile

### 4. GERAR resumo para MEMORY.md
Uma linha por licao, formato: ``- **#N descricao**: explicacao concisa``

IMPORTANTE:
- NAO repita patterns que ja existem
- Se nao ha licoes NOVAS, diga "Nenhuma licao nova identificada" e NAO altere arquivos
- Foque apenas em erros que se repetiram (>1 task) ou que sao sistemicos
- Use claude code tools (Read, Edit, Write) para atualizar os arquivos diretamente
"@

    $analysisPromptFile = Join-Path $OutputDir "lessons_prompt_$timestamp.md"
    $analysisOutputFile = Join-Path $OutputDir "lessons_output_$timestamp.md"
    $analysisPrompt | Set-Content $analysisPromptFile -Encoding UTF8

    try {
        & (Join-Path $AutomationDir "ClaudeInvoker.ps1") `
            -PromptFile $analysisPromptFile `
            -OutputFile $analysisOutputFile `
            -Model "sonnet" `
            -Timeout 600 `
            -MaxOutputTokens 8000 `
            -ContextFiles @() `
            -RateLimitMaxRetries 3 `
            -RateLimitInitialDelaySeconds 65 `
            -RateLimitMaxDelaySeconds 300

        if (Test-Path $analysisOutputFile) {
            $analysisContent = Get-Content $analysisOutputFile -Raw
            Add-Content $reportFile "`n## Analise e Aprendizados (Claude)`n`n$analysisContent" -Encoding UTF8
            Write-Host "  Analise e aprendizados persistidos" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "  [AVISO] Analise Claude falhou: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# ============================================================================
# Resumo final
# ============================================================================
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " RETROSPECTIVA CONCLUIDA" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Relatorio: $reportFile" -ForegroundColor White
Write-Host "  Correcoes Fase 2: $correcoesFase2 + $visibleFixes fixes" -ForegroundColor White
if ($recoveredTasks.Count -gt 0) {
    Write-Host "  Recovery Fase 3: $($recoveredTasks.Count) task(s) recuperada(s)" -ForegroundColor Green
    Write-Host "  Taxa de sucesso: $taxa% -> $taxaFinal% ($completedFinal/$($resultados.Count))" -ForegroundColor $(if ($taxaFinal -ge 70) { "Green" } elseif ($taxaFinal -ge 40) { "Yellow" } else { "Red" })
} else {
    Write-Host "  Taxa de sucesso: $taxa% ($($completed.Count)/$($resultados.Count))" -ForegroundColor $(if ($taxa -ge 70) { "Green" } elseif ($taxa -ge 40) { "Yellow" } else { "Red" })
}
Write-Host ""
