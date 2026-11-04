# VerificarGateFase8Task716.ps1
#
# Mede, SEM executar o orquestrador, o veredito REAL da Fase 8 para
# SIGOPCTF -> FormSigOpCtf (task716), rodando o PROPRIO bloco `case 8` do
# OrquestradorMigracao.ps1 extraido por linha, nao uma reimplementacao
# (reimplementar faria as duas copias divergirem em silencio - CLAUDE.md #44,
# item 6).
#
# AST-only para os helpers: dot-source do orquestrador DISPARA uma migracao
# real (feedback_dot_source_orquestrador_dispara_migracao).
#
# -Orquestrador permite medir uma copia BASELINE (controle negativo).
# -SemCitacao mede contra uma COPIA do .prg com as CITACOES dos nomes
#  dispensados removidas dos comentarios. Isto eh o que prova que quem aprova a
#  fase eh o RAMO de excecao e nao a coincidencia de o cabecalho do form
#  explicar por que BtnCancelarClick/CarregarLista nao se aplicam (o gate usa
#  -notmatch SOLTO, que casa comentario - feedback_comentario_citando_nome_satisfaz_gate).

param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [int]$LinhaInicio = 10011,
    [int]$LinhaFim    = 12190,
    [switch]$SemCitacao
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

# --- contexto da task716 ---
$TaskPath  = 'C:\4c\tasks\task716'
$BaseName  = 'SigOpCtf'
$FormType  = 'OPERACIONAL'
$formClass = 'FormSigOpCtf'
$boClass   = 'SigOpCtfBO'
$formFile  = 'C:\4c\projeto\app\forms\operacionais\FormSigOpCtf.prg'
$validado  = $false

if (-not (Test-Path $formFile)) { "FORM AUSENTE: $formFile"; exit 1 }

if ($SemCitacao) {
    # Apaga SO as linhas de COMENTARIO que citam os dois nomes dispensados. As
    # linhas de CODIGO ficam intactas - nao ha nenhuma com esses nomes, e eh
    # justamente isso que se quer provar.
    $copia = Join-Path $env:TEMP 'FormSigOpCtf_semcitacao.prg'
    $enc   = [System.Text.Encoding]::GetEncoding(28591)
    $linhasPrg = [System.IO.File]::ReadAllLines($formFile, $enc)
    $filtradas = @($linhasPrg | Where-Object {
        -not ($_ -match '^\s*\*' -and $_ -match '(?i)(BtnCancelarClick|CarregarLista)')
    })
    [System.IO.File]::WriteAllLines($copia, $filtradas, $enc)
    $nRemovidas = $linhasPrg.Count - $filtradas.Count
    "MODO=SEM-CITACAO ({0} linha(s) de comentario removida(s) na copia)" -f $nRemovidas
    if ($nRemovidas -eq 0) { "AVISO: nada removido - o teste nao prova nada"; exit 1 }
    $formFile = $copia
}

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

# ABORTAR se o recorte nao for sintaticamente valido - sem isso "passou" fica
# indistinguivel de harness que nao mediu nada
# (feedback_harness_de_auditoria_mede_errado).
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
                 'legadoEntradaSemBotaoF8','legadoRetornoAoPaiF8','legadoCopiadorFilhoF8',
                 'legadoEscolhaAoPaiF8',
                 'legadoNavegadorPaiF8')) {
    $val = Get-Variable -Name $v -ValueOnly -ErrorAction SilentlyContinue
    "{0,-28} = {1}" -f $v, $(if ($null -eq $val) { '<nao avaliado>' } else { $val })
}
""
"--- PREDICADOS BASE ---"
foreach ($v in @('temListaLegadoF8','temCamposLegadoF8','semCrudLegadoF8','semCrudRealF8',
                 'legadoSemSalvar','semGradeGraficoF8','temSuperficieEscolhaF8')) {
    $val = Get-Variable -Name $v -ValueOnly -ErrorAction SilentlyContinue
    "{0,-28} = {1}" -f $v, $(if ($null -eq $val) { '<nao avaliado>' } else { $val })
}
""
"VEREDITO = {0}" -f $(if ($validado) { 'PASSA' } else { 'REPROVA' })
exit 0
