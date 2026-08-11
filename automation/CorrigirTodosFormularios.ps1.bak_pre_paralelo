#==============================================================================
# CorrigirTodosFormularios.ps1
#
# PROPOSITO: Executa CorretorAutomatico.ps1 em TODOS os formularios e BOs
#            existentes no projeto. Util quando novos patterns sao adicionados
#            ao CorretorAutomatico e precisam ser aplicados retroativamente.
#
# USO:
#   .\CorrigirTodosFormularios.ps1
#   .\CorrigirTodosFormularios.ps1 -ApenasListar
#
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-02-05
#==============================================================================

param(
    [switch]$ApenasListar
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CORRIGIR TODOS OS FORMULARIOS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$basePath = "C:\4c\projeto\app"
$corretorScript = "C:\4c\automation\CorretorAutomatico.ps1"

# Pattern #116: valida integridade do stub fwprogressbar antes do sweep.
# O stub em classes/fwprogressbar.prg DEVE expor todos os membros da interface
# do framework legado (Titulo/SubTitulo/Rodape/lblPercentage). Se algum estiver
# ausente, forms migrados que acessam esses membros estouram "Unknown member"
# em runtime. Origem: Erro26 (2026-07-07, Formsigrepes.prg linha 4562).
Write-Host "Pre-sweep: validando stub fwprogressbar.prg..." -ForegroundColor Yellow
. $corretorScript
Corrigir-FwProgressBarStubMembros | Out-Null
Write-Host ""

# Encontra todos os forms
$formFiles = Get-ChildItem -Path "$basePath\forms" -Recurse -Filter "*.prg" -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -notmatch "\.bak$|\.BAK$" }

# Encontra todos os BOs
$boFiles = Get-ChildItem -Path "$basePath\classes" -Recurse -Filter "*BO.prg" -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -notmatch "\.bak$|\.BAK$" }

$totalFiles = @()
$totalFiles += $formFiles
$totalFiles += $boFiles

Write-Host "Arquivos encontrados:" -ForegroundColor Yellow
Write-Host "  Forms: $($formFiles.Count)" -ForegroundColor White
Write-Host "  BOs:   $($boFiles.Count)" -ForegroundColor White
Write-Host "  Total: $($totalFiles.Count)" -ForegroundColor White
Write-Host ""

if ($ApenasListar) {
    Write-Host "=== LISTA DE ARQUIVOS ===" -ForegroundColor Cyan
    foreach ($file in $totalFiles) {
        Write-Host "  $($file.FullName)" -ForegroundColor Gray
    }
    exit 0
}

# Executa corretor em cada arquivo
$corrigidos = 0
$semCorrecao = 0
$erros = 0

foreach ($file in $totalFiles) {
    Write-Host "Processando: $($file.Name)" -ForegroundColor Cyan

    try {
        $output = & $corretorScript -ArquivoPrg $file.FullName 2>&1
        $outputText = $output | Out-String

        if ($outputText -match "(\d+) correcao\(oes\) aplicada") {
            $numCorrecoes = [int]$Matches[1]
            if ($numCorrecoes -gt 0) {
                Write-Host "  -> $numCorrecoes correcao(oes) aplicada(s)" -ForegroundColor Green
                $corrigidos++
            } else {
                Write-Host "  -> Sem correcoes necessarias" -ForegroundColor Gray
                $semCorrecao++
            }
        } elseif ($outputText -match "Nenhuma correcao necessaria") {
            Write-Host "  -> Sem correcoes necessarias" -ForegroundColor Gray
            $semCorrecao++
        } else {
            Write-Host "  -> Processado" -ForegroundColor Gray
            $semCorrecao++
        }
    }
    catch {
        Write-Host "  -> ERRO: $($_.Exception.Message)" -ForegroundColor Red
        $erros++
    }
}

# Resumo
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  RESUMO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Arquivos com correcoes: $corrigidos" -ForegroundColor Green
Write-Host "  Arquivos sem correcoes: $semCorrecao" -ForegroundColor Gray
Write-Host "  Erros:                  $erros" -ForegroundColor $(if ($erros -gt 0) { "Red" } else { "Gray" })
Write-Host ""

# Limpa FXP
Write-Host "Limpando arquivos .FXP..." -ForegroundColor Yellow
Get-ChildItem -Path $basePath -Recurse -Filter "*.fxp" -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem -Path $basePath -Recurse -Filter "*.FXP" -ErrorAction SilentlyContinue | Remove-Item -Force
Write-Host "FXP limpos!" -ForegroundColor Green
Write-Host ""

Write-Host "Concluido!" -ForegroundColor Green
