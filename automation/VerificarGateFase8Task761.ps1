# VerificarGateFase8Task761.ps1
#
# Mede, SEM executar o orquestrador, o veredito REAL da Fase 8 para
# SIGOPLIM -> FormSigOpLim (task761), rodando o PROPRIO bloco `case 8` do
# OrquestradorMigracao.ps1 extraido por linha (mesmo padrao de
# VerificarGateFase8Task757.ps1).

param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [int]$LinhaInicio = 10828,
    [int]$LinhaFim    = 13303
)

$ErrorActionPreference = 'Stop'

$erros = $null
[System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$erros) | Out-Null
if ($erros -and $erros.Count -gt 0) {
    "SINTAXE=FALHA ({0} erro(s)) - primeiro: {1}" -f $erros.Count, $erros[0].Message
    exit 1
}
"SINTAXE=OK  ({0})" -f $Orquestrador

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
$nFuncs = 0
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
    $nFuncs++
}
"FUNCOES CARREGADAS={0}" -f $nFuncs

# --- contexto da task761 ---
$TaskPath  = 'C:\4c\tasks\task761'
$BaseName  = 'SigOpLim'
$FormType  = 'OPERACIONAL'
$formClass = 'FormSigOpLim'
$boClass   = 'SigOpLimBO'
$formFile  = 'C:\4c\projeto\app\forms\operacionais\FormSigOpLim.prg'
$validado  = $false

if (-not (Test-Path $formFile)) { "FORM AUSENTE: $formFile"; exit 1 }

$dump = Join-Path $TaskPath "$($BaseName)_form_codigo_fonte.txt"
"DUMP={0} existe={1}" -f $dump, (Test-Path $dump)
""

# --- extrai o bloco `case 8` e remove so a casca do switch ---
$linhas = Get-Content $Orquestrador
$bloco  = $linhas[($LinhaInicio - 1)..($LinhaFim - 1)]
if ($bloco[0] -notmatch '^\s*8\s*\{\s*$') {
    "ANCORA ERRADA na linha {0}: [{1}]" -f $LinhaInicio, $bloco[0]
    exit 1
}
if ($bloco[-1] -notmatch '^\s*\}\s*$') {
    "ANCORA ERRADA na linha {0}: [{1}]" -f $LinhaFim, $bloco[-1]
    exit 1
}
$corpo = ($bloco[1..($bloco.Count - 2)] -join "`r`n")

$e2 = $null
[System.Management.Automation.Language.Parser]::ParseInput($corpo, [ref]$null, [ref]$e2) | Out-Null
if ($e2 -and $e2.Count -gt 0) {
    "RECORTE INVALIDO ({0} erro(s)) - primeiro: {1}" -f $e2.Count, $e2[0].Message
    exit 1
}
"RECORTE=OK ({0} linhas)" -f ($bloco.Count - 2)
""

"--- SAIDA DO GATE REAL (case 8) ---"
. ([scriptblock]::Create($corpo))
""
"VALIDADO            = {0}" -f $validado
"metodosFaltantes    = [{0}]" -f ($metodosFaltantes -join ', ')
""
"--- RAMOS DE EXCECAO ---"
foreach ($v in @('legadoDespachanteF8','legadoExibicaoF8','legadoVisualizadorF8','legadoFluxoUnicoF8',
                 'legadoArvoreF8','legadoLinhaImediataF8','legadoCalculadoraF8','legadoProtocoloF8',
                 'legadoFiltroDespachoF8','legadoUtilitarioArquivoF8','legadoGraficoF8',
                 'legadoLeitorBaixaF8','legadoEntradaSemBotaoF8','legadoRetornoAoPaiF8',
                 'legadoCopiadorFilhoF8','legadoEscolhaAoPaiF8',
                 'legadoNavegadorPaiF8','legadoImpressaoFilhoF8')) {
    $val = Get-Variable -Name $v -ValueOnly -ErrorAction SilentlyContinue
    "{0,-28} = {1}" -f $v, $(if ($null -eq $val) { '<nao avaliado>' } else { $val })
}
""
"--- PREDICADOS BASE ---"
foreach ($v in @('temListaLegadoF8','temCamposLegadoF8','semCrudLegadoF8','semCrudRealF8',
                 'legadoSemSalvar','semGradeGraficoF8','soApagaLinhaGradeF8','soRelatorioF8',
                 'grupoOpNaoProvaCrudF8','temSuperficieEscolhaF8',
                 'semAcaoNemCancelarCalcF8','cliqueSoFechaCalcF8','nBotoesCalcF8','temSuperficieCalcF8','legadoSemAcao','nBotoesLegadoF8')) {
    $val = Get-Variable -Name $v -ValueOnly -ErrorAction SilentlyContinue
    "{0,-28} = {1}" -f $v, $(if ($null -eq $val) { '<nao avaliado>' } else { $val })
}
""
"VEREDITO = {0}" -f $(if ($validado) { 'PASSA' } else { 'REPROVA' })
exit 0
