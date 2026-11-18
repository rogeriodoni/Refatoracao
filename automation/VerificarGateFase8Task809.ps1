# VerificarGateFase8Task809.ps1
#
# Reproduz o bloco `case 8` REAL do OrquestradorMigracao.ps1 (recortado por
# texto do proprio arquivo, nao por copia manual) sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real.
#
# Alvo: SIGOPTEF -> Formsigoptef (task809), dialogo de TEF/cartao que conversa
# com o terminal SiTef pela CliSiTef32I.DLL declarada no SCX (Load com quatro
# DECLARE ... IN "CliSiTef32I.DLL"), 500x370, campos digitaveis (4 ultimos
# digitos, resp. parcelamento, numero do cartao, cod. de seguranca, numero de
# parcelas) e UM unico botao - o SAIDA/CANCELA.
#
# Ramo que o libera: PROTOCOLO BRUTO ($legadoProtocoloBrutoF8, criado na
# task683) - ele dispensa a exigencia de botao de ACAO, mas EXIGE em troca
# $temSuperficieProtF8, isto eh FormParaBO + BOParaForm + Btn*Click ANCORADOS
# em inicio de linha no migrado. A reprovacao de 2026-11-18 06:19 foi por UM
# unico predicado: o form tinha BOParaForm e BtnCancelarClick, mas nenhum
# FormParaBO (nem em comentario). Os quatro nomes canonicos ja vinham
# dispensados pelo ramo FLUXO-UNICO, avaliado antes.
#
# Uso (PRE x POS):
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase8Task809.ps1
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase8Task809.ps1 -Orquestrador <bak>
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task809',
    [string]$BaseNameArg  = 'sigoptef',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\Formsigoptef.prg'
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

# Diagnostico independente do bloco
$dump = Get-Content (Join-Path $TaskPathArg "$($BaseNameArg)_form_codigo_fonte.txt") -Raw
"frmcadastro          = {0}" -f ($dump -match 'frmcadastro')
"temListaLegado       = {0}" -f (($dump -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or ($dump -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)'))
"temCamposLegado      = {0}" -f ($dump -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
"nBotoesLegado        = {0}" -f (Get-ContagemBotoesLegado -TextoDump $dump)
"SemBotaoAlgum        = {0}" -f (Test-LegadoSemBotaoAlgum -TextoDump $dump)
"CliqueSoFecha        = {0}" -f (Test-LegadoCliqueSoFecha -TextoDump $dump)
"SomenteLeitura       = {0}" -f (Test-LegadoSomenteLeitura -TextoDump $dump)
if (Get-Command Test-LegadoDialogoExibicao -ErrorAction SilentlyContinue) {
    "DialogoExibicao      = {0}" -f (Test-LegadoDialogoExibicao -TextoDump $dump)
}
if (Get-Command Test-LegadoSoDialogoExibicao -ErrorAction SilentlyContinue) {
    "SoDialogoExibicao    = {0}" -f (Test-LegadoSoDialogoExibicao -TextoDump $dump)
}
if (Get-Command Test-LegadoRetornoAoPai -ErrorAction SilentlyContinue) {
    "RetornoAoPai         = {0}" -f (Test-LegadoRetornoAoPai -TextoDump $dump)
}
$prg = Get-Content $FormFileArg -Raw
"nHandlers(Cmd/Btn)   = {0}" -f ([regex]::Matches($prg, 'PROCEDURE\s+(Cmd|Btn)\w*Click')).Count
"acaoTemHandler       = {0}" -f ($prg -match 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click')
foreach ($n in @("BtnCancelarClick","FormParaBO","BOParaForm","CarregarLista","BtnSalvarClick","HabilitarCampos","LimparCampos","AjustarBotoesPorModo","BtnBuscarClick","BtnEncerrarClick")) {
    "  token {0,-22} presente={1}" -f $n, ($prg -match $n)
}

Invoke-Expression "switch (8) {`r`n$corpo`r`n}"

"FALTANTES={0}" -f ($metodosFaltantes -join ' | ')
if ($validado) { "VEREDITO=PASSA"; exit 0 }
"VEREDITO=REPROVA"
exit 1
