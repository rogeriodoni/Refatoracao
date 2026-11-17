# VerificarGateFase8Task781.ps1
#
# Roda o bloco `case 8` REAL do OrquestradorMigracao.ps1 (recortado por texto
# do proprio arquivo, nao por copia manual) contra a task781, sem executar o
# orquestrador - dot-source dele DISPARA uma migracao real.
#
# Alvo: SIGOPORC -> Formsigoporc (task781), "Itens" do orcamento - dialogo
# FILHO aberto por "Do Form SigOpOrc With ThisForm, ThisForm.DataSessionId".
#
# Irmao de VerificarGateFase7Task781.ps1 (mesma tecnica de recorte por AST +
# Invoke-Expression no corpo do case).
#
# Uso (PRE x POS):
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase8Task781.ps1
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task781',
    [string]$BaseNameArg  = 'sigoporc',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\Formsigoporc.prg',
    [string]$BoFileArg    = 'C:\4c\projeto\app\classes\sigoporcBO.prg'
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

# Contexto que o bloco le de fora (mesmos nomes do orquestrador)
$formFile  = $FormFileArg
$boFile    = $BoFileArg
$TaskPath  = $TaskPathArg
$BaseName  = $BaseNameArg
$FormType  = 'OPERACIONAL'
$formClass = 'Formsigoporc'
$boClass   = 'sigoporcBO'
$campos    = @()
$temEstruturaSemPageFrameF4 = $false
$legadoListaArvore          = $false
$legadoArvoreSemBindF5      = $false
$validado  = $false

# Diagnostico independente: o que o case 8 exige e o que o .prg tem
$prg  = Get-Content $FormFileArg -Raw
$dump = Get-Content (Join-Path $TaskPathArg "$($BaseNameArg)_form_codigo_fonte.txt") -Raw
"--- tokens exigidos pelo case 8 ---"
foreach ($n in @('BtnCancelarClick','FormParaBO','BOParaForm','CarregarLista')) {
    "  {0,-18} presente={1}" -f $n, ($prg -match $n)
}
"--- botao de acao (BtnSalvarClick e os sinonimos aceitos) ---"
foreach ($n in @('BtnSalvarClick','BtnConfirmarClick','BtnGravarClick','BtnProcessaClick')) {
    "  {0,-20} presente={1}" -f $n, ($prg -match $n)
}
"legado tem btnSalvar/btnGravar/mGravaDados = {0}" -f ($dump -match 'btnSalvar|btnGravar|mGravaDados')

Invoke-Expression "switch (8) {`r`n$corpo`r`n}"

if ($validado) { "VEREDITO=PASSA"; exit 0 }
"VEREDITO=REPROVA"
exit 1
