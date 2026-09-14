#==============================================================================
# processar_lote_com_revisao.ps1
#
# PROPOSITO: Processa multiplos formularios com pausa para revisao entre cada
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-01-22
#==============================================================================

param(
    [Parameter(Mandatory=$false)]
    [int]$Quantidade = 999  # Processar ate acabar arquivos em origem
)

$ErrorActionPreference = "Continue"

Write-Host @"

╔══════════════════════════════════════════════════════════════════════╗
║                                                                      ║
║     PROCESSAMENTO EM LOTE COM REVISÃO                                ║
║                                                                      ║
╚══════════════════════════════════════════════════════════════════════╝

Este script processa multiplos formularios, mas PAUSA entre cada um
para voce revisar o resultado antes de continuar.

Quantidade maxima: $Quantidade

"@ -ForegroundColor Cyan

$processados = 0
$sucessos = 0
$falhas = 0

for ($i = 1; $i -le $Quantidade; $i++) {
    # Verifica se ainda ha arquivos na origem
    $arquivosRestantes = @(Get-ChildItem -Path "C:\4c\origem" -Filter "*.scx" -ErrorAction SilentlyContinue)

    if ($arquivosRestantes.Count -eq 0) {
        Write-Host ""
        Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
        Write-Host " Nenhum arquivo restante em C:\4c\origem\" -ForegroundColor Yellow
        Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow
        break
    }

    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host " Processando formulario $i de $Quantidade" -ForegroundColor Cyan
    Write-Host " Arquivos restantes: $($arquivosRestantes.Count)" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""

    # Executa migracao
    & "$PSScriptRoot\OrquestradorMigracao.ps1"

    $exitCode = $LASTEXITCODE
    $processados++

    if ($exitCode -eq 0) {
        $sucessos++
        Write-Host ""
        Write-Host "✅ Formulario $i COMPLETO!" -ForegroundColor Green
    } else {
        $falhas++
        Write-Host ""
        Write-Host "❌ Formulario $i FALHOU (exit code: $exitCode)" -ForegroundColor Red
    }

    # Identifica qual task foi criada (ultima task)
    $ultimaTask = Get-ChildItem -Path "C:\4c\tasks" -Directory |
                  Sort-Object CreationTime -Descending |
                  Select-Object -First 1

    if ($ultimaTask) {
        Write-Host ""
        Write-Host "Task criada: $($ultimaTask.Name)" -ForegroundColor Cyan

        # Mostra resumo da task
        $stateFile = Join-Path $ultimaTask.FullName "task_state.json"
        if (Test-Path $stateFile) {
            $state = Get-Content $stateFile -Raw | ConvertFrom-Json

            Write-Host "  Arquivo: $($state.arquivoOriginal)" -ForegroundColor Gray
            Write-Host "  Status: $($state.status)" -ForegroundColor $(
                if ($state.status -eq "COMPLETED") { "Green" } else { "Red" }
            )

            # Se validacao UI executada, mostra resultado
            if ($state.etapas."07_validarUI".status -eq "COMPLETED") {
                $problemas = $state.etapas."07_validarUI".problemas
                Write-Host "  Validacao UI:" -ForegroundColor Gray
                Write-Host "    Erros: $($problemas.erros)" -ForegroundColor $(
                    if ($problemas.erros -eq 0) { "Green" } else { "Red" }
                )
                Write-Host "    Avisos: $($problemas.avisos)" -ForegroundColor Yellow
                Write-Host "    Total: $($problemas.total)" -ForegroundColor Gray
            }
        }

        Write-Host ""
        Write-Host "REVISAR AGORA:" -ForegroundColor Yellow
        Write-Host "  1. Estado: cat C:\4c\tasks\$($ultimaTask.Name)\task_state.json" -ForegroundColor Gray
        Write-Host "  2. Validacao UI: start C:\4c\tasks\$($ultimaTask.Name)\validacao_ui_report.html" -ForegroundColor Gray
        Write-Host "  3. Teste manual: Abrir formulario no VFP" -ForegroundColor Gray
    }

    # Pausa para revisao (exceto no ultimo)
    if ($i -lt $Quantidade -and $arquivosRestantes.Count -gt 1) {
        Write-Host ""
        Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Yellow

        $resposta = Read-Host "Pressione ENTER para proximo, ou 'S' para SAIR"

        if ($resposta -eq "S" -or $resposta -eq "s") {
            Write-Host "Processamento interrompido pelo usuario." -ForegroundColor Yellow
            break
        }
    }
}

# Resumo final
Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host " RESUMO DO LOTE" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "Total processados: $processados" -ForegroundColor White
Write-Host "  Sucessos: $sucessos" -ForegroundColor Green
Write-Host "  Falhas: $falhas" -ForegroundColor Red
Write-Host ""

if ($sucessos -gt 0) {
    $taxaSucesso = [math]::Round(($sucessos / $processados) * 100, 1)
    Write-Host "Taxa de sucesso: $taxaSucesso%" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Proximos passos:" -ForegroundColor Yellow
Write-Host "  1. Revisar solicitacoes de teste manual" -ForegroundColor Gray
Write-Host "  2. Executar testes manuais" -ForegroundColor Gray
Write-Host "  3. Commit codigo aprovado" -ForegroundColor Gray
Write-Host ""
