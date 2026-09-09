#==============================================================================
# DiagnosticoCabecalhoPaginas.ps1
#
# Diz, por form CRUD, se cada pagina (Lista e Dados) tem a faixa cinza do
# cabecalho exigida pela regra #11 do CLAUDE.md.
#
# A deteccao NAO usa o nome do container: 8 forms chamam a faixa de
# cnt_4c_Sombra e o Formpgr usa cnt_4c_Cabecalho para um container de CAMPOS.
# O criterio eh BackColor RGB(100,100,100) + Height >= 60.
#
# Toda a analise (variavel, Pages(N), pagina recebida por parametro, .Top com
# expressao) vive em LibCabecalhoPaginas.ps1, compartilhada com o
# AplicarCabecalhoComDeslocamento.ps1 - as duas ferramentas enxergam os forms
# exatamente do mesmo jeito.
#
# USO:
#   .\DiagnosticoCabecalhoPaginas.ps1              # relatorio completo
#   .\DiagnosticoCabecalhoPaginas.ps1 -SoFaltantes # so o que falta
#==============================================================================
param(
    [switch]$SoFaltantes,
    [string]$Pasta = 'C:\4c\projeto\app\forms\cadastros'
)
$ErrorActionPreference = 'Stop'

. (Join-Path $PSScriptRoot 'LibCabecalhoPaginas.ps1')

$ok = New-Object System.Collections.ArrayList
$faltam = New-Object System.Collections.ArrayList
$semDados = New-Object System.Collections.ArrayList

foreach ($arq in (Get-ChildItem $Pasta -Filter 'Form*.prg' -File | Where-Object { $_.Name -notlike '*.bak' } | Sort-Object Name)) {
    $linhas = New-Object System.Collections.Generic.List[string]
    $linhas.AddRange([string[]]([System.IO.File]::ReadAllText($arq.FullName) -split "`r?`n"))

    $p1 = Test-PaginaTemFaixa $linhas 1
    $p2 = Test-PaginaTemFaixa $linhas 2

    # form sem pagina de dados de verdade (OPERACIONAL com PageFrame stub, ou
    # Page2 declarada "reservada"): a regra #11 nao se aplica
    $filhos2 = Get-FilhosDiretos $linhas 2
    if (-not $p2 -and $filhos2.Count -eq 0) {
        [void]$semDados.Add(("{0,-24} Page1={1}" -f $arq.Name, $(if ($p1) { 'faixa OK' } else { '(nenhuma)' })))
        continue
    }

    if ($p2) { [void]$ok.Add(("{0,-24} Page1={1} Page2=faixa OK" -f $arq.Name, $(if ($p1) { 'faixa OK' } else { '(nenhuma)' }))) }
    else     { [void]$faltam.Add(("{0,-24} Page1={1} Page2=(nenhuma) - {2} controles diretos" -f $arq.Name, $(if ($p1) { 'faixa OK' } else { '(nenhuma)' }), $filhos2.Count)) }
}

Write-Host ""
Write-Host "Page2 COM faixa:            $($ok.Count)"       -ForegroundColor Green
Write-Host "Page2 SEM faixa:            $($faltam.Count)"    -ForegroundColor Yellow
Write-Host "sem pagina de dados (N/A):  $($semDados.Count)"  -ForegroundColor Gray

if ($faltam.Count -gt 0) {
    Write-Host ""
    Write-Host "--- FALTANDO:" -ForegroundColor Yellow
    foreach ($x in $faltam) { Write-Host "  $x" }
}
if ($semDados.Count -gt 0) {
    Write-Host ""
    Write-Host "--- SEM PAGINA DE DADOS (regra #11 nao se aplica):" -ForegroundColor Gray
    foreach ($x in $semDados) { Write-Host "  $x" }
}
if (-not $SoFaltantes -and $ok.Count -gt 0) {
    Write-Host ""
    Write-Host "--- OK:" -ForegroundColor Green
    foreach ($x in $ok) { Write-Host "  $x" }
}
