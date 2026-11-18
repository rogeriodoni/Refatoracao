# VerificarGateFase7Task806.ps1
#
# Reproduz o bloco `case 7` REAL do OrquestradorMigracao.ps1 (recortado por
# texto do proprio arquivo, nao por copia manual) sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real.
#
# Alvo: SIGOPSQN -> FormSigOpSqn (task806), "Sequencia de Operacoes do Caixa":
# DIALOGO FILHO aberto pela Lista do Cadastro de Operacoes do Caixa ("Do Form
# SigOpSqn With ThisForm, ThisForm.DataSessionId" -> "LParameters poForm,
# pnDataSes" + "Set DataSession to pnDataSes" + ".ParentForm = poForm").
#
# O dump nao tem frmcadastro; o "Grupo_Op" que ele cita e a barra do form PAI
# ("With Thisform.ParentForm.Pagina.Lista" + ".Grupo_Op.Buttons(lnI).Enabled =",
# no mCtrlBotoes), ja dispensada por Test-BarraCrudEhDoFormPai; e os nomes dos
# botoes sao cmdInserir/cmdExcluir (toolbar de LINHA da grade) e cmdSair,
# nenhum deles casando (btn|cmd|Command)(Incluir|Alterar|Visualizar).
#
# Sobrava UMA evidencia: a contagem viva de pcEscolha = 8, que sao os QUATRO
# pares "Iif( Type( [Thisform.PcEscolha] ) # [C], .T., InList( Thisform.
# PcEscolha, [INSERIR], [ALTERAR] ) )" do Init - o legado TESTA se a property
# existe e libera os botoes quando ela nao existe. O form nunca atribui
# pcEscolha, pcEscolha nao e parametro de metodo nenhum e a unica outra citacao
# e o inventario do ClassInfo: property VESTIGIAL.
#
# Marcado como CRUD, a fase exigia os quatro BtnIncluirClick/BtnAlterarClick/
# BtnVisualizarClick/BtnExcluirClick - insatisfazivel sem INVENTAR botao (viola
# o PILAR 1) ou criar metodo vazio (proibido pela regra de completude), mesmo
# com os 3 handlers reais dos 3 botoes do legado (CmdInserirClick/
# CmdExcluirClick/BtnSairClick).
#
# Dispensa: Test-PcEscolhaSoEmTesteDeExistencia (terceira forma de "pcEscolha
# que NAO prova CRUD", irma de Test-ModoRecebidoDoChamador e dos descontos de
# Get-ContagemPcEscolhaViva), consultada nos call sites da Fase 7 E da Fase 8.
#
# Uso (PRE x POS):
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase7Task806.ps1
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase7Task806.ps1 -Orquestrador C:\tmp\orq_pre_806.ps1
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task806',
    [string]$BaseNameArg  = 'SigOpSqn',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\FormSigOpSqn.prg'
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
