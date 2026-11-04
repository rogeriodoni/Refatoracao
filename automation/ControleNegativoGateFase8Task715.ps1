# Controle negativo do ramo ESCOLHA-AO-PAI (Fase 8, task715).
#
# Prova que $temSuperficieEscolhaF8 eh LOAD-BEARING: um form entregue SEM os
# hooks FormParaBO/BOParaForm nao pode passar pelo ramo. Mede o PROPRIO case 8
# do orquestrador (helpers por AST - nunca dot-source, ver feedback
# "dot_source_orquestrador_dispara_migracao") contra uma COPIA do .prg com:
#   - as DECLARACOES de FormParaBO/BOParaForm comentadas;
#   - as CITACOES dos 4 nomes do gate removidas dos comentarios.
# A segunda mutacao eh obrigatoria porque o gate usa -notmatch SOLTO, que casa
# comentario (feedback "comentario_citando_nome_satisfaz_gate"): sem ela o
# veredito final fica PASSA por coincidencia e o controle nao prova nada.
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [int]$LinhaInicio = 10011,
    [int]$LinhaFim    = 12190
)
$ErrorActionPreference = 'Stop'
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}
$TaskPath = 'C:\4c\tasks\task715'
$BaseName = 'SigOpCtd'
$FormType = 'OPERACIONAL'
$orig     = 'C:\4c\projeto\app\forms\operacionais\FormSigOpCtd.prg'
$enc      = [System.Text.Encoding]::GetEncoding(28591)
$nomes    = 'FormParaBO|BOParaForm|BtnCancelarClick|CarregarLista'

$linhasPrg = [System.IO.File]::ReadAllLines($orig, $enc)
$mut = @(); $nDecl = 0; $nCom = 0
foreach ($l in $linhasPrg) {
    if ($l -match '^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+(FormParaBO|BOParaForm)\b') {
        $mut += '*-- declaracao removida para o controle negativo'; $nDecl++
    } elseif ($l -match '^\s*\*' -and $l -match $nomes) {
        $nCom++   # comentario citando os nomes: some da copia
    } else { $mut += $l }
}
if ($nDecl -eq 0 -or $nCom -eq 0) { "AVISO: mutacao incompleta (decl=$nDecl com=$nCom) - nao prova nada"; exit 1 }
$copia = Join-Path $env:TEMP 'FormSigOpCtd_semhooks.prg'
[System.IO.File]::WriteAllLines($copia, $mut, $enc)
"MUTACAO: {0} declaracao(oes) comentada(s), {1} linha(s) de comentario citando os nomes removida(s)" -f $nDecl, $nCom

$formFile = $copia
$validado = $false
$linhas = Get-Content $Orquestrador
$bloco  = $linhas[($LinhaInicio - 1)..($LinhaFim - 1)]
if ($bloco[0] -notmatch '^\s*8\s*\{\s*$') { "ANCORA ERRADA: [$($bloco[0])]"; exit 1 }
if ($bloco[-1] -notmatch '^\s*\}\s*$')    { "ANCORA ERRADA: [$($bloco[-1])]"; exit 1 }
$corpo = ($bloco[1..($bloco.Count - 2)] -join "`r`n")
. ([scriptblock]::Create($corpo)) | Out-Null
""
"legadoEscolhaAoPaiF8   = {0}   <- tem de ser False (superficie ausente)" -f $legadoEscolhaAoPaiF8
"temSuperficieEscolhaF8 = {0}   <- tem de ser False" -f $temSuperficieEscolhaF8
"metodosFaltantes       = [{0}]" -f ($metodosFaltantes -join ', ')
"VEREDITO               = {0}   <- tem de ser REPROVA" -f $(if ($validado) { 'PASSA' } else { 'REPROVA' })
