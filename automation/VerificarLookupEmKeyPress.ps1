# =============================================================================
# VerificarLookupEmKeyPress.ps1
#
# Erro195 (2026-10-08): handler ligado a BINDEVENT "KeyPress" que abre o picker
# (FormBuscaAuxiliar / AbrirBusca* / AbrirLookup*) SEM testar par_nKeyCode faz o
# dialogo subir a CADA TECLA - o usuario nao consegue terminar de digitar o
# codigo. O legado valida no `Valid` do campo, ou seja ao SAIR dele: o evento
# certo eh "LostFocus".
#
# Criterio (deterministico, sem heuristica de nome):
#   BINDEVENT(<ctl>, "KeyPress", THIS, "<H>")  E  <H> abre picker
#   E  <H> NUNCA testa par_nKeyCode / nKeyCode / LASTKEY()
#
# A assinatura NAO conta como teste: `PROCEDURE X(par_nKeyCode, ...)` declara o
# parametro sem olhar para ele (foi o que fez a 1a versao deste detector dar
# ZERO achado num projeto cheio deles).
#
# Severidade:
#   [ERRO]  handler batizado <X>LostFocus ligado a "KeyPress" - inequivoco
#   [AVISO] demais (Validar*, etc.) - conferir o dump do legado antes de trocar
#
# SEM auto-fix de proposito: trocar o evento automaticamente foi exatamente o
# que o CorretorAutomatico #74 fazia, e foi ele quem CRIOU este defeito
# (rebaixado a WARNING em 2026-10-06). O evento certo e a existencia de um F3
# vem do dump do legado.
# =============================================================================
param(
    [string]$Caminho = "C:\4c\projeto\app\forms",
    [switch]$SomenteErros
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $Caminho)) {
    Write-Host "[LOOKUP-KEYPRESS] Caminho nao encontrado: $Caminho" -ForegroundColor Red
    exit 2
}

$arquivos = Get-ChildItem -Path $Caminho -Filter "*.prg" -Recurse -File
$nErro  = 0
$nAviso = 0

foreach ($arq in $arquivos) {
    $linhas = Get-Content -LiteralPath $arq.FullName

    # ---- mapear, por PROCEDURE: abre picker? testa tecla? ----
    $abrePicker = @{}
    $testaTecla = @{}
    $proc = $null
    foreach ($l in $linhas) {
        if ($l -match '^\s*(?:PROTECTED\s+|HIDDEN\s+)?PROCEDURE\s+(\w+)') {
            $proc = $Matches[1].ToUpper()
            continue        # a assinatura NAO conta como teste de tecla
        }
        if (-not $proc) { continue }
        if ($l -match '^\s*(\*|&&)') { continue }
        if ($l -match '^\s*L?PARAMETERS\b') { continue }

        if ($l -match '\bINLIST\s*\(\s*par_nKeyCode' -or
            $l -match '\b(?:par_n)?[Kk]ey[Cc]ode\s*(?:==|=|<|>|!=|<>|#)' -or
            $l -match '\bLASTKEY\s*\(') {
            $testaTecla[$proc] = $true
        }
        if ($l -match '(?i)CREATEOBJECT\s*\(\s*"FormBuscaAuxiliar"' -or
            $l -match '(?i)THIS\.(?:Abrir\w*|\w*Lookup\w*|\w*Busca\w*)\s*\(') {
            $abrePicker[$proc] = $true
        }
    }

    # ---- achar os BINDEVENT "KeyPress" para esses handlers ----
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $l = $linhas[$i]
        if ($l -match '^\s*(\*|&&)') { continue }
        if ($l -notmatch 'BINDEVENT\s*\([^,]+,\s*"KeyPress"\s*,\s*[^,]+,\s*"(\w+)"') { continue }

        $h = $Matches[1]
        $k = $h.ToUpper()
        if (-not $abrePicker[$k]) { continue }
        if ($testaTecla[$k])      { continue }

        $rel = $arq.FullName.Replace("C:\4c\", "")
        if ($h -match '(?i)LostFocus$') {
            Write-Host "[ERRO]  $rel`:$($i + 1) - '$h' abre picker em KeyPress (handler batizado LostFocus). Trocar o BINDEVENT para `"LostFocus`", tirar (par_nKeyCode, par_nShiftAltCtrl) da assinatura e por guarda this_lEmLookup (regra #37). Erro195" -ForegroundColor Red
            $nErro++
        } else {
            Write-Host "[AVISO] $rel`:$($i + 1) - '$h' abre picker em KeyPress sem testar tecla: dispara a cada caractere. Conferir o dump do legado (Valid -> LostFocus; F3 -> manter KeyPress com IF par_nKeyCode). Erro195" -ForegroundColor Yellow
            $nAviso++
        }
    }
}

Write-Host ""
Write-Host "[LOOKUP-KEYPRESS] $($arquivos.Count) arquivos. ERRO=$nErro AVISO=$nAviso" -ForegroundColor Cyan

if ($nErro -gt 0) { exit 1 }
if ($nAviso -gt 0 -and -not $SomenteErros) { exit 0 }
exit 0
