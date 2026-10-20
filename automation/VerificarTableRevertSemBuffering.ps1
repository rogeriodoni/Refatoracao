#==============================================================================
# VerificarTableRevertSemBuffering.ps1
#
# PROPOSITO: auditar TABLEREVERT()/TABLEUPDATE() chamados SEM guard de buffering.
#
# POR QUE: TABLEREVERT/TABLEUPDATE EXIGEM buffering ligado. Medido no VFP9
# (2026-10-20):
#
#   CREATE CURSOR x (a C(3))                 -> CURSORGETPROP("Buffering") = 1
#   SELECT * FROM y INTO CURSOR x READWRITE  -> CURSORGETPROP("Buffering") = 1
#   TABLEREVERT(.T., "x")  com Buffering = 1 -> ERRO 1586
#           "Function requires row or table buffering mode."
#   USE IN x   com Buffering = 5 e alteracoes PENDENTES -> OK
#
# Ou seja: TABLEREVERT antes de USE IN nunca foi necessario, e no caso comum
# (cursor sem buffering) ele ERRA. Dentro de TRY vira MsgErro e aborta o metodo;
# fora de TRY congela o VFP num Program Error que ninguem ve.
#
# Origem: Erro230 (FormDup/DupBO - a tela de Series de Duplicatas nao abria,
# porque o placeholder do grid eh CREATE CURSOR e o guard injetado pelo
# CorretorAutomatico #91 estourava no primeiro Buscar()).
#
# Regra #52 do CLAUDE.md | Skill: secao 247 | Auto-fix: CorretorAutomatico #219
#
# USO:
#   .\VerificarTableRevertSemBuffering.ps1
#   .\VerificarTableRevertSemBuffering.ps1 -Caminho C:\4c\projeto\app\classes
#   .\VerificarTableRevertSemBuffering.ps1 -Detalhar
#
# EXIT CODE: 0 = sem pendencia | 1 = ha TABLEREVERT/TABLEUPDATE sem guard
#==============================================================================
param(
    [Parameter(Mandatory=$false)]
    [string]$Caminho = "C:\4c\projeto\app",

    [Parameter(Mandatory=$false)]
    [switch]$Detalhar
)

$ErrorActionPreference = "Stop"

Write-Host "=== VERIFICAR TABLEREVERT/TABLEUPDATE SEM GUARD DE BUFFERING ===" -ForegroundColor Cyan
Write-Host "Caminho: $Caminho"
Write-Host ""

if (-not (Test-Path $Caminho)) {
    Write-Host "Caminho nao encontrado: $Caminho" -ForegroundColor Red
    exit 1
}

$arquivos = Get-ChildItem -Path $Caminho -Filter "*.prg" -Recurse -File |
            Where-Object { $_.Name -notlike "*.bak" }

$achados   = @()
$revisar   = @()
$guardados = 0

foreach ($arq in $arquivos) {
    $linhas = Get-Content -Path $arq.FullName

    # O arquivo administra buffering por conta propria? (sigclcnx.PRG faz
    # CursorSetProp('Buffering',5,...) nos cursores do AddCursor legado). Nesse
    # caso TABLEUPDATE sem guard eh o uso CORRETO, nao defeito - sai como
    # REVISAR, nunca como pendencia. Sem esta premissa a auditoria vira WARNING
    # massivo e perde o sinal.
    $arqGerenciaBuffering = ($linhas -join "`n") -match "(?i)CursorSetProp\s*\(\s*'Buffering'\s*,\s*[2-9]"

    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $linha = $linhas[$i]

        # Comentario nao conta
        if ($linha -match '(?i)^\s*(\*|&&)') { continue }

        # TABLEREVERT(<escopo>, <alias>) / TABLEUPDATE(<escopo>, ..., <alias>)
        if ($linha -notmatch '(?i)\b(TABLEREVERT|TABLEUPDATE)\s*\(') { continue }

        # Extrair o alias: ultimo argumento literal ("x") ou variavel
        $alias = $null
        if ($linha -match '(?i)\b(?:TABLEREVERT|TABLEUPDATE)\s*\(.*?,\s*("(?:[^"]+)"|[A-Za-z_]\w*)\s*\)\s*$') {
            $alias = $Matches[1]
        }

        # Guard valido: IF CURSORGETPROP("Buffering", <mesmo alias>) > 1 na linha
        # anterior nao-vazia. Guard de OUTRO alias nao protege.
        $temGuard = $false
        for ($j = $i - 1; $j -ge 0; $j--) {
            if ([string]::IsNullOrWhiteSpace($linhas[$j])) { continue }
            if ($linhas[$j] -match '(?i)IF\s+CURSORGETPROP\s*\(\s*"Buffering"\s*,\s*("(?:[^"]+)"|[A-Za-z_]\w*)\s*\)\s*>\s*1') {
                if ($null -eq $alias -or $Matches[1] -eq $alias) { $temGuard = $true }
            }
            break
        }

        if ($temGuard) {
            $guardados++
            continue
        }

        $item = [PSCustomObject]@{
            Arquivo = $arq.FullName.Replace("C:\4c\", "")
            Linha   = $i + 1
            Alias   = if ($alias) { $alias } else { "(nao resolvido)" }
            Codigo  = $linha.Trim()
        }

        # TABLEUPDATE em alias do AddCursor legado (convencao Cr<Tabela>) ou em
        # arquivo que liga buffering sozinho: uso legitimo, so REVISAR.
        $ehLegado = ($alias -match '(?i)^"?Cr[A-Z]') -or $arqGerenciaBuffering
        if ($ehLegado -and $linha -match '(?i)\bTABLEUPDATE\s*\(') {
            $revisar += $item
        } else {
            $achados += $item
        }
    }
}

Write-Host "Arquivos varridos : $($arquivos.Count)"
Write-Host "Sites COM guard   : $guardados" -ForegroundColor Green
Write-Host "Sites SEM guard   : $($achados.Count)" -ForegroundColor $(if ($achados.Count -gt 0) { "Red" } else { "Green" })
Write-Host "Sites a REVISAR   : $($revisar.Count) (TABLEUPDATE em cursor de buffering administrado)" -ForegroundColor Gray
Write-Host ""

if ($revisar.Count -gt 0 -and $Detalhar) {
    Write-Host "REVISAR (nao falha a auditoria - TABLEUPDATE legitimo sobre cursor buferizado):" -ForegroundColor Gray
    foreach ($r in $revisar) {
        Write-Host ("  {0}:{1}  alias={2}" -f $r.Arquivo, $r.Linha, $r.Alias) -ForegroundColor DarkGray
    }
    Write-Host ""
}

if ($achados.Count -eq 0) {
    Write-Host "OK - nenhum TABLEREVERT/TABLEUPDATE sem guard de buffering." -ForegroundColor Green
    exit 0
}

Write-Host "PENDENCIAS (Erro 1586 em runtime - a tela nao abre / nao fecha):" -ForegroundColor Red
Write-Host ""

if ($Detalhar) {
    foreach ($a in $achados) {
        Write-Host ("  {0}:{1}  alias={2}" -f $a.Arquivo, $a.Linha, $a.Alias) -ForegroundColor Yellow
        Write-Host ("      {0}" -f $a.Codigo) -ForegroundColor Gray
    }
} else {
    $achados | Group-Object Arquivo | Sort-Object Count -Descending | ForEach-Object {
        Write-Host ("  {0,-70} {1} site(s)" -f $_.Name, $_.Count) -ForegroundColor Yellow
    }
    Write-Host ""
    Write-Host "  (use -Detalhar para ver linha a linha)" -ForegroundColor Gray
}

Write-Host ""
Write-Host "CORRECAO (regra #52 do CLAUDE.md):" -ForegroundColor Cyan
Write-Host '    IF USED("cursor_4c_X")'
Write-Host '        IF CURSORGETPROP("Buffering", "cursor_4c_X") > 1'
Write-Host '            TABLEREVERT(.T., "cursor_4c_X")'
Write-Host '        ENDIF'
Write-Host '        USE IN cursor_4c_X'
Write-Host '    ENDIF'
Write-Host ""
Write-Host "  Para cursor que vai ser DESCARTADO, USE IN sozinho basta." -ForegroundColor Gray
Write-Host "  Auto-fix: automation\CorretorAutomatico.ps1 (pattern #219)." -ForegroundColor Gray

exit 1
