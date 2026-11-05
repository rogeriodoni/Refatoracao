# VerificarGateFase8Task737.ps1
#
# Reproduz o bloco `case 8` REAL do OrquestradorMigracao.ps1 (recortado por
# texto do proprio arquivo, nao por copia manual) sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real.
#
# Alvo: SIGOPFTC -> Formsigopftc (task737), "Ficha de Complementos da
# Movimentacao": dialogo filho MODAL aberto por uma tela de movimentacao para
# coletar as respostas da ficha tecnica. O SCX tem 4 objetos visuais
# (cntSombra + 2 Label + cntBotoes com Confirmar/Cancelar) e ZERO superficie
# CRUD.
#
# A Fase 8 NAO precisou de ramo de excecao aqui: os quatro nomes exigidos
# (BtnCancelarClick/FormParaBO/BOParaForm/CarregarLista) foram IMPLEMENTADOS de
# verdade, porque todos tem conteudo real neste legado -
#   - BtnCancelarClick : o btnSair do SCX tem Caption "\<Cancelar" e Cancel=.T.
#   - FormParaBO       : o "lcVal = loObjForm1.&lcObj..Value" + os campos do
#                        Insert de gravafichatecnica
#   - BOParaForm       : o corpo de carregafichatecnica
#   - CarregarLista    : o bloco de carga de checarfichatecnica (query + Go Top
#                        + MontaFichaTecnica)
# e BtnSalvarClick eh dispensado por $legadoSemSalvar (o botao de gravar deste
# legado chama-se "Confirmar" -> BtnConfirmarClick, que satisfaz
# $padraoAcaoGravar). Este script existe para PROVAR isso em vez de presumir.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase8Task737.ps1
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task737',
    [string]$BaseNameArg  = 'sigopftc',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\Formsigopftc.prg'
)

$erros = $null
[System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$erros) | Out-Null
if ($erros -and $erros.Count -gt 0) {
    "SINTAXE=FALHA ({0} erro(s))" -f $erros.Count
    exit 2
}
"SINTAXE=OK  ({0})" -f $Orquestrador

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$linhas = Get-Content $Orquestrador
$ini = -1; $fim = -1
for ($i = 0; $i -lt $linhas.Count; $i++) {
    if ($ini -lt 0 -and $linhas[$i] -match '^\s{8}8\s\{\s*$') { $ini = $i; continue }
    if ($ini -ge 0 -and $linhas[$i] -match '^\s{8}\}\s*$')    { $fim = $i; break }
}
if ($ini -lt 0 -or $fim -lt 0) { "RECORTE=FALHA (case 8 nao localizado)"; exit 2 }
"RECORTE=OK  (linhas {0}..{1})" -f ($ini + 1), ($fim + 1)

$corpo = ($linhas[$ini..$fim] -join "`r`n")

$formFile = $FormFileArg
$TaskPath = $TaskPathArg
$BaseName = $BaseNameArg
$FormType = 'OPERACIONAL'
$validado = $false

# Diagnostico independente do bloco, para o veredito nao ser uma caixa preta.
# Os quatro nomes sao conferidos DUAS vezes: pelo criterio literal do gate
# (substring no arquivo inteiro) e por declaracao REAL ancorada em inicio de
# linha - um nome citado so em comentario satisfaz o gate e NAO entrega
# funcionalidade (feedback_comentario_citando_nome_satisfaz_gate).
$prg  = Get-Content $FormFileArg -Raw
$dump = Get-Content (Join-Path $TaskPathArg "$($BaseNameArg)_form_codigo_fonte.txt") -Raw

"nBotoesLegado        = {0}" -f (Get-ContagemBotoesLegado -TextoDump $dump)
"CliqueSoFecha        = {0}" -f (Test-LegadoCliqueSoFecha -TextoDump $dump)
$padroesSalvarLegado = @('btnSalvar', 'btnGravar', 'PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click', 'mGravaDados')
$achouSalvar = @($padroesSalvarLegado | Where-Object { $dump -match $_ })
"legadoSemSalvar      = {0}  (padroes casados: {1})" -f ($achouSalvar.Count -eq 0), $(if ($achouSalvar.Count) { $achouSalvar -join ', ' } else { 'nenhum' })
"padraoAcaoGravar     = {0}" -f ($prg -match 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click')

foreach ($n in @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")) {
    $re = "(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+$n\s*\("
    "  token {0,-18} substring={1,-5} declarado={2}" -f $n, ($prg -match $n), ($prg -match $re)
}

Invoke-Expression "switch (8) {`r`n$corpo`r`n}"

if ($validado) { "VEREDITO=PASSA"; exit 0 }
"VEREDITO=REPROVA"
exit 1
