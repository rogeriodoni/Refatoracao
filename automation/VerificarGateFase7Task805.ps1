# VerificarGateFase7Task796.ps1
#
# Reproduz o bloco `case 7` REAL do OrquestradorMigracao.ps1 (recortado por
# texto do proprio arquivo, nao por copia manual) sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real.
#
# Alvo: SIGOPSPR -> FormSigOpSpr (task805), dialogo de EXIBICAO de texto
# somente-leitura (titulo + EditBox ReadOnly + Encerrar), 800x430, TitleBar = 0
# e ControlBox = .F., aberto pelo form PAI com "Do Form SigOpSpr With
# [<titulo>], <texto>, ThisForm".
#
# O dump nao tem frmcadastro, nao tem Grupo_Op e nao tem nome de botao CRUD
# algum: a arvore inteira sao 7 objetos (dataenvironment, form, container, 2
# label, 1 editbox e 1 commandgroup de ButtonCount = 1) e os unicos dois
# metodos com codigo sao o Init e o "CmdSair.Click". Exigir os quatro
# BtnXxxClick aqui eh insatisfazivel sem INVENTAR botao (viola o PILAR 1) ou
# criar metodo vazio (proibido pela regra de completude).
#
# Dispensa esperada: ramo "legado sem CRUD" com o piso de handlers BAIXADO para
# 1 por Get-ContagemBotoesLegado = 1 (o UNICO botao do SCX), satisfeito pelo
# handler do Encerrar que o form ja tem.
#
# Uso (PRE x POS):
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase7Task796.ps1
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase7Task796.ps1 -Orquestrador C:\tmp\OrquestradorMigracao.ps1.bak
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task805',
    [string]$BaseNameArg  = 'SigOpSpr',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\FormSigOpSpr.prg'
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

# Diagnostico independente do bloco: os predicados da familia "evidencia de CRUD"
$dump = Get-Content (Join-Path $TaskPathArg "$($BaseNameArg)_form_codigo_fonte.txt") -Raw
"frmcadastro          = {0}" -f ($dump -match 'frmcadastro')
"Grupo_Op             = {0}" -f ($dump -match 'Grupo_Op')
"nomeCRUD(btn|cmd)    = {0}" -f ($dump -match '(btn|cmd|Command)(Incluir|Alterar|Visualizar)(?![A-Za-z0-9_])')
"DialogoFilho(irma)   = {0}" -f (Test-DialogoFilhoDoChamador -TextoDump $dump)
if (Get-Command Test-DialogoFilhoComSessaoPorId -ErrorAction SilentlyContinue) {
    "DialogoFilhoPorId    = {0}" -f (Test-DialogoFilhoComSessaoPorId -TextoDump $dump)
} else {
    "DialogoFilhoPorId    = <helper AUSENTE nesta versao do orquestrador>"
}
"SoRelatorio          = {0}" -f (Test-VerbosCrudSaoTodosDeRelatorio -TextoDump $dump)
"SoLinhaDeGrade       = {0}" -f (Test-VerbosCrudSaoTodosDeLinhaDeGrade -TextoDump $dump)
"SoPainelDeLinha      = {0}" -f (Test-VerbosCrudSaoTodosDePainelDeLinha -TextoDump $dump)
"SoGravarEFechar      = {0}" -f (Test-VerbosCrudSaoTodosDeGravarEFechar -TextoDump $dump)
"pcEscolhaViva        = {0}" -f (Get-ContagemPcEscolhaViva -TextoDump $dump)
"nBotoesLegado        = {0}" -f (Get-ContagemBotoesLegado -TextoDump $dump)
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
