# VerificarGateFase7Task746.ps1
#
# Reproduz o bloco `case 7` REAL do OrquestradorMigracao.ps1 (recortado por
# texto do proprio arquivo, nao por copia manual) sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real.
#
# Alvo: SIGOPIBO -> Formsigoppei (task780), "Impressao de Boleto": dialogo
# filho aberto por telas de movimentacao para IMPRIMIR (nao cadastra nada).
# O SCX tem 19 objetos e ZERO superficie CRUD - sem frmcadastro/frmrelatorio,
# sem Grupo_Op, sem pcEscolha e sem nome btn|cmd<verbo>. Os botoes do legado
# sao EXATAMENTE DOIS: Cmd_Imprimir e Cmd_Sair, membros Command1/Command2 do
# CommandGroup btnReport (ButtonCount = 2). Logo nBotoesLegado = 2, o piso
# $minHandlersF7 fica em 2 (nao cai para 1 nem para 0) e o form tem de provar
# os dois handlers reais - que eh o caso.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase7Task746.ps1
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task780',
    [string]$BaseNameArg  = 'sigoppei',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\Formsigoppei.prg'
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
    if ($ini -lt 0 -and $linhas[$i] -match '^\s{8}7\s\{\s*$') { $ini = $i; continue }
    if ($ini -ge 0 -and $linhas[$i] -match '^\s{8}\}\s*$')    { $fim = $i; break }
}
if ($ini -lt 0 -or $fim -lt 0) { "RECORTE=FALHA (case 7 nao localizado)"; exit 2 }
"RECORTE=OK  (linhas {0}..{1})" -f ($ini + 1), ($fim + 1)

$corpo = ($linhas[$ini..$fim] -join "`r`n")

$formFile = $FormFileArg
$TaskPath = $TaskPathArg
$BaseName = $BaseNameArg
$FormType = 'OPERACIONAL'
$validado = $false

# Diagnostico independente do bloco: os predicados da familia "evidencia de NOME"
$dump = Get-Content (Join-Path $TaskPathArg "$($BaseNameArg)_form_codigo_fonte.txt") -Raw
"nBotoesLegado        = {0}" -f (Get-ContagemBotoesLegado -TextoDump $dump)
"pcEscolhaViva        = {0}" -f (Get-ContagemPcEscolhaViva -TextoDump $dump)
"SemBotaoAlgum        = {0}" -f (Test-LegadoSemBotaoAlgum -TextoDump $dump)
$prg = Get-Content $FormFileArg -Raw
"nHandlers(Cmd/Btn)   = {0}" -f ([regex]::Matches($prg, 'PROCEDURE\s+(Cmd|Btn)\w*Click')).Count
foreach ($n in @("BtnIncluirClick","BtnAlterarClick","BtnVisualizarClick","BtnExcluirClick")) {
    "  token {0,-20} presente={1}" -f $n, ($prg -match $n)
}

Invoke-Expression "switch (7) {`r`n$corpo`r`n}"

if ($validado) { "VEREDITO=PASSA"; exit 0 }
"VEREDITO=REPROVA"
exit 1
