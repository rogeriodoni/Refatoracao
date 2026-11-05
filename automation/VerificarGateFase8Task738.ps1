# VerificarGateFase8Task738.ps1
#
# Reproduz o bloco `case 8` REAL do OrquestradorMigracao.ps1 (recortado por
# texto do proprio arquivo, nao por copia manual) sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real.
#
# Alvo: SIGOPGAR -> Formsigopgar (task738), "Gera Arquivo": dialogo filho MODAL
# aberto por uma tela de consulta/selecao de produtos, que grava o resultado em
# ARQUIVO (TXT ou XML), nunca em tabela. O SCX tem 19 objetos visuais e ZERO
# superficie CRUD (sem Grid, sem pColuna, sem AddCursor, sem frmcadastro).
#
# A Fase 8 NAO precisou de ramo de excecao: os quatro nomes exigidos foram
# IMPLEMENTADOS de verdade, porque todos tem conteudo real neste legado -
#   - FormParaBO    : os cinco controles de entrada que GerarArquivo() consome
#   - BOParaForm    : o caminho inverso (modo + "Exportar Imagens" + 3 caminhos)
#   - CarregarLista : o funil do Init legado (limpa os 3 campos, assenta o modo
#                     e o painel) - esta tela nao tem grade, e o estado inicial
#                     dela sao os campos
#   - o handler do botao de fechar : o objeto do legado chama-se "Cancela" e
#                     declara Cancel = .T., entao o handler leva o nome do
#                     OBJETO (como em outros oito sites do projeto que ligam um
#                     cmd_4c_Cancela), nao o do Caption
# e o nome canonico de GRAVAR eh dispensado por $legadoSemSalvar - a acao desta
# tela chama-se "Processar" (BtnProcessarClick), que satisfaz $padraoAcaoGravar.
#
# Este script existe para PROVAR isso em vez de presumir - e, em especial, para
# provar que a aprovacao NAO vem de nome citado em comentario: cada um dos
# quatro eh conferido DUAS vezes, pelo criterio literal do gate (substring) e
# por declaracao REAL ancorada em inicio de linha.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase8Task738.ps1
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task738',
    [string]$BaseNameArg  = 'sigopgar',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\Formsigopgar.prg'
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

$prg  = Get-Content $FormFileArg -Raw
$dump = Get-Content (Join-Path $TaskPathArg "$($BaseNameArg)_form_codigo_fonte.txt") -Raw

"nBotoesLegado        = {0}" -f (Get-ContagemBotoesLegado -TextoDump $dump)
"CliqueSoFecha        = {0}" -f (Test-LegadoCliqueSoFecha -TextoDump $dump)
$padroesSalvarLegado = @('btnSalvar', 'btnGravar', 'PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click', 'mGravaDados')
$achouSalvar = @($padroesSalvarLegado | Where-Object { $dump -match $_ })
"legadoSemSalvar      = {0}  (padroes casados: {1})" -f ($achouSalvar.Count -eq 0), $(if ($achouSalvar.Count) { $achouSalvar -join ', ' } else { 'nenhum' })
"padraoAcaoGravar     = {0}" -f ($prg -match 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click')

# Os quatro nomes, conferidos DUAS vezes: substring (o criterio do gate) e
# declaracao REAL ancorada em inicio de linha. "declarado=False" com
# "substring=True" eh o sintoma de aprovacao por comentario
# (feedback_comentario_citando_nome_satisfaz_gate).
foreach ($n in @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")) {
    $re = "(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+$n\s*\("
    "  token {0,-18} substring={1,-5} declarado={2}" -f $n, ($prg -match $n), ($prg -match $re)
}

Invoke-Expression "switch (8) {`r`n$corpo`r`n}"

if ($validado) { "VEREDITO=PASSA"; exit 0 }
"VEREDITO=REPROVA"
exit 1
