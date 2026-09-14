#==============================================================================
# exemplo_uso.ps1
#
# PROPOSITO: Script de exemplo mostrando como usar o sistema de migracao
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-01-22
#==============================================================================

Write-Host @"

╔══════════════════════════════════════════════════════════════════════╗
║                                                                      ║
║     SISTEMA DE MIGRACAO AUTOMATIZADA - EXEMPLO DE USO               ║
║                                                                      ║
╚══════════════════════════════════════════════════════════════════════╝

Este script demonstra os principais usos do sistema.

"@ -ForegroundColor Cyan

#------------------------------------------------------------------------------
# Exemplo 1: Processar Nova Task
#------------------------------------------------------------------------------

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host " EXEMPLO 1: Processar Nova Task" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

Write-Host "Comando:" -ForegroundColor Cyan
Write-Host "  .\OrquestradorMigracao.ps1" -ForegroundColor White
Write-Host ""
Write-Host "O que faz:" -ForegroundColor Cyan
Write-Host "  1. Busca proximo arquivo em C:\4c\origem\" -ForegroundColor Gray
Write-Host "  2. Cria nova task (ex: task001)" -ForegroundColor Gray
Write-Host "  3. Executa todas as 8 etapas" -ForegroundColor Gray
Write-Host "  4. Gera relatorios e solicitacao de teste manual" -ForegroundColor Gray
Write-Host ""

$resposta = Read-Host "Deseja executar? (s/N)"
if ($resposta -eq "s") {
    Write-Host "Executando..." -ForegroundColor Green
    .\OrquestradorMigracao.ps1
}

#------------------------------------------------------------------------------
# Exemplo 2: Continuar Task Pendente
#------------------------------------------------------------------------------

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host " EXEMPLO 2: Continuar Task Pendente" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

Write-Host "Comando:" -ForegroundColor Cyan
Write-Host "  .\OrquestradorMigracao.ps1 -ContinueFromLastTask" -ForegroundColor White
Write-Host ""
Write-Host "O que faz:" -ForegroundColor Cyan
Write-Host "  1. Busca tasks com status PENDING ou IN_PROGRESS" -ForegroundColor Gray
Write-Host "  2. Continua a partir da ultima etapa pendente" -ForegroundColor Gray
Write-Host "  3. Util quando task falhou e foi corrigida manualmente" -ForegroundColor Gray
Write-Host ""

$resposta = Read-Host "Deseja executar? (s/N)"
if ($resposta -eq "s") {
    Write-Host "Executando..." -ForegroundColor Green
    .\OrquestradorMigracao.ps1 -ContinueFromLastTask
}

#------------------------------------------------------------------------------
# Exemplo 3: Processar Task Especifica
#------------------------------------------------------------------------------

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host " EXEMPLO 3: Processar Task Especifica" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

Write-Host "Comando:" -ForegroundColor Cyan
Write-Host "  .\OrquestradorMigracao.ps1 -TaskId 'task005'" -ForegroundColor White
Write-Host ""
Write-Host "O que faz:" -ForegroundColor Cyan
Write-Host "  1. Processa task especifica (ex: task005)" -ForegroundColor Gray
Write-Host "  2. Util para reprocessar task que falhou" -ForegroundColor Gray
Write-Host "  3. Ou para processar task fora de ordem" -ForegroundColor Gray
Write-Host ""

Write-Host "Exemplo pratico:" -ForegroundColor Cyan
Write-Host "  # Task003 falhou na validacao UI" -ForegroundColor Gray
Write-Host "  # Corrigi o codigo manualmente" -ForegroundColor Gray
Write-Host "  # Reprocesso apenas task003:" -ForegroundColor Gray
Write-Host "  .\OrquestradorMigracao.ps1 -TaskId 'task003'" -ForegroundColor Gray
Write-Host ""

$resposta = Read-Host "Deseja executar? Digite ID da task (ou ENTER para pular)"
if ($resposta) {
    Write-Host "Executando task: $resposta" -ForegroundColor Green
    .\OrquestradorMigracao.ps1 -TaskId $resposta
}

#------------------------------------------------------------------------------
# Exemplo 4: Ver Estado de Uma Task
#------------------------------------------------------------------------------

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host " EXEMPLO 4: Ver Estado de Uma Task" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

Write-Host "Comando:" -ForegroundColor Cyan
Write-Host "  cat C:\4c\tasks\task001\task_state.json | ConvertFrom-Json | ConvertTo-Json -Depth 10" -ForegroundColor White
Write-Host ""
Write-Host "Ou usar TaskManager:" -ForegroundColor Cyan
Write-Host "  . .\TaskManager.ps1" -ForegroundColor White
Write-Host "  Get-TaskState -TaskId 'task001' -TasksDir 'C:\4c\tasks'" -ForegroundColor White
Write-Host ""

$resposta = Read-Host "Deseja ver tasks disponiveis? (s/N)"
if ($resposta -eq "s") {
    Write-Host ""
    Write-Host "Tasks disponiveis:" -ForegroundColor Green
    Get-ChildItem -Path "C:\4c\tasks" -Directory | ForEach-Object {
        $stateFile = Join-Path $_.FullName "task_state.json"
        if (Test-Path $stateFile) {
            $state = Get-Content $stateFile -Raw | ConvertFrom-Json
            Write-Host "  $($_.Name): $($state.status) - $($state.arquivoOriginal)" -ForegroundColor $(
                switch ($state.status) {
                    "COMPLETED" { "Green" }
                    "FAILED" { "Red" }
                    "IN_PROGRESS" { "Yellow" }
                    default { "Gray" }
                }
            )
        }
    }
}

#------------------------------------------------------------------------------
# Exemplo 5: Ver Logs de Uma Etapa
#------------------------------------------------------------------------------

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host " EXEMPLO 5: Ver Logs de Uma Etapa" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

Write-Host "Comando:" -ForegroundColor Cyan
Write-Host "  cat C:\4c\tasks\task001\logs\05_migracao.log" -ForegroundColor White
Write-Host ""
Write-Host "Logs disponiveis por etapa:" -ForegroundColor Cyan
Write-Host "  01_moverArquivos.log" -ForegroundColor Gray
Write-Host "  02_extractCode.log" -ForegroundColor Gray
Write-Host "  03_gerarMetaPrompt.log" -ForegroundColor Gray
Write-Host "  04_gerarMapeamento.log" -ForegroundColor Gray
Write-Host "  05_migracao.log" -ForegroundColor Gray
Write-Host "  06_testForm.log" -ForegroundColor Gray
Write-Host "  07_validarUI.log" -ForegroundColor Gray
Write-Host "  08_gerarTestManual.log" -ForegroundColor Gray
Write-Host ""

$resposta = Read-Host "Deseja ver logs de alguma task? Digite ID (ou ENTER para pular)"
if ($resposta) {
    $logsPath = "C:\4c\tasks\$resposta\logs"
    if (Test-Path $logsPath) {
        Write-Host ""
        Write-Host "Logs disponiveis para $resposta:" -ForegroundColor Green
        Get-ChildItem -Path $logsPath -Filter "*.log" | ForEach-Object {
            Write-Host "  $($_.Name)" -ForegroundColor Gray
        }

        $etapa = Read-Host "Digite nome do log para visualizar (ex: 05_migracao.log)"
        if ($etapa) {
            $logFile = Join-Path $logsPath $etapa
            if (Test-Path $logFile) {
                Write-Host ""
                Write-Host "Conteudo de $etapa:" -ForegroundColor Cyan
                Get-Content $logFile
            }
        }
    } else {
        Write-Host "Task nao encontrada: $resposta" -ForegroundColor Red
    }
}

#------------------------------------------------------------------------------
# Exemplo 6: Ver Relatorio de Validacao UI
#------------------------------------------------------------------------------

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host " EXEMPLO 6: Ver Relatorio de Validacao UI" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

Write-Host "Comando:" -ForegroundColor Cyan
Write-Host "  start C:\4c\tasks\task001\validacao_ui_report.html" -ForegroundColor White
Write-Host ""
Write-Host "Ou ver JSON:" -ForegroundColor Cyan
Write-Host "  cat C:\4c\tasks\task001\validacao_ui_report.json | ConvertFrom-Json" -ForegroundColor White
Write-Host ""

$resposta = Read-Host "Deseja abrir relatorio de alguma task? Digite ID (ou ENTER para pular)"
if ($resposta) {
    $htmlFile = "C:\4c\tasks\$resposta\validacao_ui_report.html"
    if (Test-Path $htmlFile) {
        Write-Host "Abrindo relatorio HTML..." -ForegroundColor Green
        Start-Process $htmlFile
    } else {
        Write-Host "Relatorio nao encontrado para task: $resposta" -ForegroundColor Red
    }
}

#------------------------------------------------------------------------------
# Exemplo 7: Processar Lote de Formularios
#------------------------------------------------------------------------------

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host " EXEMPLO 7: Processar Lote de Formularios" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""

Write-Host "Script de exemplo:" -ForegroundColor Cyan
Write-Host @"
  # Processar 5 formularios com pausa para revisao
  for (`$i=1; `$i -le 5; `$i++) {
      Write-Host "Processando formulario `$i de 5..." -ForegroundColor Cyan
      .\OrquestradorMigracao.ps1

      Write-Host "Formulario `$i concluido. Revise antes de continuar." -ForegroundColor Yellow
      Read-Host "Pressione ENTER para proximo formulario"
  }
"@ -ForegroundColor White
Write-Host ""

$resposta = Read-Host "Deseja processar um lote? Digite quantidade (ou ENTER para pular)"
if ($resposta -and $resposta -gt 0) {
    $quantidade = [int]$resposta

    Write-Host ""
    Write-Host "Processando $quantidade formularios..." -ForegroundColor Green
    Write-Host "AVISO: Revise cada task antes de continuar para proxima!" -ForegroundColor Yellow
    Write-Host ""

    for ($i=1; $i -le $quantidade; $i++) {
        Write-Host ""
        Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
        Write-Host " Processando formulario $i de $quantidade" -ForegroundColor Cyan
        Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
        Write-Host ""

        .\OrquestradorMigracao.ps1

        if ($i -lt $quantidade) {
            Write-Host ""
            Write-Host "Formulario $i concluido!" -ForegroundColor Green
            Write-Host "Revise antes de continuar:" -ForegroundColor Yellow
            Write-Host "  - Ver task_state.json" -ForegroundColor Gray
            Write-Host "  - Ver validacao_ui_report.html" -ForegroundColor Gray
            Write-Host "  - Testar formulario manualmente" -ForegroundColor Gray
            Write-Host ""
            Read-Host "Pressione ENTER para proximo formulario"
        }
    }

    Write-Host ""
    Write-Host "═══════════════════════════════════════" -ForegroundColor Green
    Write-Host " LOTE CONCLUIDO!" -ForegroundColor Green
    Write-Host "═══════════════════════════════════════" -ForegroundColor Green
    Write-Host ""
    Write-Host "Processados: $quantidade formularios" -ForegroundColor Green
    Write-Host "Proximos passos:" -ForegroundColor Cyan
    Write-Host "  1. Revisar solicitacoes de teste manual" -ForegroundColor Gray
    Write-Host "  2. Executar testes manuais" -ForegroundColor Gray
    Write-Host "  3. Commit codigo aprovado" -ForegroundColor Gray
}

#------------------------------------------------------------------------------
# Resumo Final
#------------------------------------------------------------------------------

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host " RESUMO DE COMANDOS UTEIS" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

Write-Host "Processar nova task:" -ForegroundColor Yellow
Write-Host "  .\OrquestradorMigracao.ps1" -ForegroundColor White
Write-Host ""

Write-Host "Continuar task pendente:" -ForegroundColor Yellow
Write-Host "  .\OrquestradorMigracao.ps1 -ContinueFromLastTask" -ForegroundColor White
Write-Host ""

Write-Host "Processar task especifica:" -ForegroundColor Yellow
Write-Host "  .\OrquestradorMigracao.ps1 -TaskId 'taskXXX'" -ForegroundColor White
Write-Host ""

Write-Host "Ver estado de task:" -ForegroundColor Yellow
Write-Host "  cat C:\4c\tasks\taskXXX\task_state.json | ConvertFrom-Json | Format-List" -ForegroundColor White
Write-Host ""

Write-Host "Ver logs:" -ForegroundColor Yellow
Write-Host "  cat C:\4c\tasks\taskXXX\logs\*.log" -ForegroundColor White
Write-Host ""

Write-Host "Abrir relatorio UI:" -ForegroundColor Yellow
Write-Host "  start C:\4c\tasks\taskXXX\validacao_ui_report.html" -ForegroundColor White
Write-Host ""

Write-Host "Para mais informacoes, consulte:" -ForegroundColor Cyan
Write-Host "  README.md" -ForegroundColor White
Write-Host "  INDEX.md" -ForegroundColor White
Write-Host ""

Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
