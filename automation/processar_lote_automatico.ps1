#==============================================================================
# processar_lote_automatico.ps1
#
# PROPOSITO: Processa multiplos formularios SEM PAUSA (totalmente automatico)
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-01-22
#
# ⚠️ AVISO: Use apenas apos validar processo com 5-10 formularios primeiro!
#==============================================================================

param(
    [Parameter(Mandatory=$false)]
    [int]$MaxTasks = 999,  # Maximo de tasks a processar

    [Parameter(Mandatory=$false)]
    [switch]$IgnoreErrors  # Continuar mesmo se task falhar
)

$ErrorActionPreference = "Continue"

Write-Host @"

╔══════════════════════════════════════════════════════════════════════╗
║                                                                      ║
║     PROCESSAMENTO EM LOTE AUTOMÁTICO (SEM PAUSA)                    ║
║                                                                      ║
╚══════════════════════════════════════════════════════════════════════╝

⚠️  AVISO: Este script processa TODOS os arquivos automaticamente,
    SEM PAUSA para revisao entre cada um.

    Use apenas se voce ja testou o processo com 5-10 formularios
    e esta confiante na qualidade da migracao!

"@ -ForegroundColor Yellow

$resposta = Read-Host "Deseja continuar? (digite 'SIM' para confirmar)"

if ($resposta -ne "SIM") {
    Write-Host "Operacao cancelada." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "Iniciando processamento automatico..." -ForegroundColor Green
Write-Host "Max tasks: $MaxTasks" -ForegroundColor Gray
Write-Host "Ignorar erros: $IgnoreErrors" -ForegroundColor Gray
Write-Host ""

$processados = 0
$sucessos = 0
$falhas = 0
$tasksComProblemas = @()

$inicioGeral = Get-Date

while ($processados -lt $MaxTasks) {
    # Verifica se ainda ha arquivos na origem
    $arquivosRestantes = @(Get-ChildItem -Path "C:\4c\origem" -Filter "*.scx" -ErrorAction SilentlyContinue)

    if ($arquivosRestantes.Count -eq 0) {
        Write-Host ""
        Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
        Write-Host " Todos os arquivos foram processados!" -ForegroundColor Yellow
        Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
        break
    }

    $processados++

    Write-Host ""
    Write-Host "[$processados/$MaxTasks] Processando... (restantes: $($arquivosRestantes.Count))" -ForegroundColor Cyan

    $inicioTask = Get-Date

    # Executa migracao
    & "$PSScriptRoot\OrquestradorMigracao.ps1" *> $null  # Redireciona output para nao poluir

    $exitCode = $LASTEXITCODE
    $fimTask = Get-Date
    $duracaoTask = ($fimTask - $inicioTask).TotalMinutes

    # Identifica ultima task criada
    $ultimaTask = Get-ChildItem -Path "C:\4c\tasks" -Directory |
                  Sort-Object CreationTime -Descending |
                  Select-Object -First 1

    if ($exitCode -eq 0) {
        $sucessos++
        Write-Host "  ✅ SUCESSO - $($ultimaTask.Name) (${duracaoTask:N1} min)" -ForegroundColor Green
    } else {
        $falhas++
        Write-Host "  ❌ FALHA - $($ultimaTask.Name) (exit: $exitCode)" -ForegroundColor Red

        if ($ultimaTask) {
            $tasksComProblemas += $ultimaTask.Name
        }

        # Se nao esta ignorando erros, para
        if (-not $IgnoreErrors) {
            Write-Host ""
            Write-Host "ERRO ENCONTRADO. Parando processamento." -ForegroundColor Red
            Write-Host "Use -IgnoreErrors para continuar mesmo com erros." -ForegroundColor Yellow
            break
        }
    }

    # Mostra progresso a cada 5 tasks
    if ($processados % 5 -eq 0) {
        Write-Host ""
        Write-Host "  Progresso: $processados tasks | $sucessos sucessos | $falhas falhas" -ForegroundColor Cyan
    }
}

$fimGeral = Get-Date
$duracaoTotal = ($fimGeral - $inicioGeral).TotalMinutes

# Resumo final detalhado
Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host " RESUMO DO LOTE AUTOMÁTICO" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "Total processados: $processados" -ForegroundColor White
Write-Host "  Sucessos: $sucessos" -ForegroundColor Green
Write-Host "  Falhas: $falhas" -ForegroundColor Red
Write-Host ""

if ($processados -gt 0) {
    $taxaSucesso = [math]::Round(($sucessos / $processados) * 100, 1)
    $tempoMedio = [math]::Round($duracaoTotal / $processados, 1)

    Write-Host "Taxa de sucesso: $taxaSucesso%" -ForegroundColor Cyan
    Write-Host "Tempo total: ${duracaoTotal:N1} minutos" -ForegroundColor Gray
    Write-Host "Tempo medio por task: $tempoMedio minutos" -ForegroundColor Gray
}

if ($tasksComProblemas.Count -gt 0) {
    Write-Host ""
    Write-Host "Tasks com problemas (revisar):" -ForegroundColor Yellow
    foreach ($task in $tasksComProblemas) {
        Write-Host "  - $task" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Proximos passos:" -ForegroundColor Yellow
Write-Host "  1. Revisar tasks com problemas (se houver)" -ForegroundColor Gray
Write-Host "  2. Gerar dashboard de todas as tasks:" -ForegroundColor Gray
Write-Host "     Get-ChildItem C:\4c\tasks | ForEach { cat `$_.FullName\task_state.json }" -ForegroundColor DarkGray
Write-Host "  3. Revisar relatorios de validacao UI" -ForegroundColor Gray
Write-Host "  4. Executar testes manuais (amostragem)" -ForegroundColor Gray
Write-Host "  5. Commit em lote do codigo aprovado" -ForegroundColor Gray
Write-Host ""

# Salva resumo em arquivo
$resumoFile = "C:\4c\automation\resumo_lote_" + (Get-Date -Format "yyyyMMdd_HHmmss") + ".txt"

$resumoContent = @"
RESUMO DO LOTE AUTOMATICO
==========================

Data/Hora: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
Total processados: $processados
Sucessos: $sucessos
Falhas: $falhas
Taxa de sucesso: $taxaSucesso%
Tempo total: ${duracaoTotal:N1} minutos
Tempo medio: $tempoMedio minutos/task

Tasks com problemas:
$($tasksComProblemas -join "`n")
"@

$resumoContent | Set-Content -Path $resumoFile -Encoding UTF8

Write-Host "Resumo salvo em: $resumoFile" -ForegroundColor Cyan
Write-Host ""
