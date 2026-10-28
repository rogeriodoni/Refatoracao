# VerificarGateFase8Task689.ps1
#
# Reproduz o bloco `case 8` REAL do OrquestradorMigracao.ps1 (recortado por
# numero de linha e executado via switch), sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real (move .SCX de origem\ e
# sobrescreve BO existente).
#
# Alvo: SIGOPCGB -> Formsigopcgb (task697), "Pesquisa Global de Codigo de
# Barras": 1000x600, Class/BaseClass form PURO, consultor de um codigo de
# barras - 4 grades somente-leitura (Historico/Movimento/Devolucao/Cotacoes),
# um painel flutuante de Etiquetas, 8 botoes e o checkbox Bot_Cotacoes.
#
# DEFEITO GEMEO do que a Fase 7 consertou em 2026-10-15 na mesma familia
# "evidencia de NOME", e que ficou PENDENTE na Fase 8: cada `case` tem seu
# PROPRIO bloco de predicados, entao a correcao de um nao vale para o outro.
#
# O dump nao tem frmcadastro, Grupo_Op, pcEscolha nem "<X>.Click": a UNICA
# evidencia de CRUD eh o NOME 'btnVisualizar' - que aqui eh o par do
# btnImprimir na impressao da etiqueta (Click = "ThisForm.Imagem('V')" /
# "('I')", e o metodo 'imagem' termina em REPORT FORM). Com isso
# $semCrudLegadoF8 virava $false; e como 'Visualizar' tampouco eh verbo de
# LINHA DE GRADE, o bloco de $soApagaLinhaGradeF8 nao desempatava - o form
# caia no VAO entre os dois e $semCrudRealF8 ficava $false, pondo os TREZE
# ramos de excecao fora de alcance DE UMA VEZ. A fase passava a exigir
# BtnCancelarClick/FormParaBO/BOParaForm/CarregarLista de um legado que nao
# tem Page2, nem modo de edicao, nem botao de Cancelar - insatisfazivel sem
# INVENTAR superficie (viola o PILAR 1) ou criar quatro metodos vazios
# (proibido pela regra de completude).
#
# Conserto: $semCrudRealF8 passa a consultar tambem
# Test-VerbosCrudSaoTodosDeRelatorio - o MESMO helper que a Fase 7 usa (fonte
# unica; duas copias divergiriam em silencio no primeiro caso novo, CLAUDE.md
# #44 item 6). Com isso o ramo FLUXO-UNICO alcanca o form: ele tem lista real
# (4 Grid) E campo digitavel real (getBarras, o unico sem "When -> Return .f."),
# e eh esse campo que DISPARA a consulta que popula as grades - exatamente a
# descricao do ramo. O ramo VISUALIZADOR nao se aplica aqui de proposito
# (Test-LegadoSomenteLeitura = $false, porque getBarras eh digitavel).
#
# Medicao (2026-10-24, todos os dumps de tasks\): o predicado $semCrudRealF8
# muda em UM dump (sigopcgb) e o VEREDITO em UM harness (este). Os 11 outros
# VerificarGateFase8*.ps1 dao saida IDENTICA antes e depois do patch.
#
# Uso:

#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase8Task689.ps1
#   ... -Orquestrador <caminho>   (para comparar com um backup/HEAD)
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task697',
    [string]$BaseNameArg  = 'SigOpChc',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\FormSigOpChc.prg'
)

$erros = $null
[System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$erros) | Out-Null
if ($erros -and $erros.Count -gt 0) {
    "SINTAXE=FALHA ({0} erro(s))" -f $erros.Count
    $erros | Select-Object -First 5 | ForEach-Object { "  L{0}: {1}" -f $_.Extent.StartLineNumber, $_.Message }
    exit 2
}
"SINTAXE=OK  ({0})" -f $Orquestrador

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

# Recorta o bloco `case 8` pelo PROPRIO texto do arquivo (nao por copia
# manual): a copia envelheceria em silencio na proxima excecao nova.
$linhas = Get-Content $Orquestrador
$ini = -1; $fim = -1
for ($i = 0; $i -lt $linhas.Count; $i++) {
    if ($ini -lt 0 -and $linhas[$i] -match '^\s{8}8\s\{\s*$') { $ini = $i; continue }
    if ($ini -ge 0 -and $linhas[$i] -match '^\s{8}\}\s*$')    { $fim = $i; break }
}
if ($ini -lt 0 -or $fim -lt 0) { "RECORTE=FALHA (case 8 nao localizado)"; exit 2 }
"RECORTE=OK  (linhas {0}..{1})" -f ($ini + 1), ($fim + 1)

$corpo = ($linhas[$ini..$fim] -join "`r`n")

# Variaveis que o bloco consome do escopo de Invoke-MigracaoFase
$formFile = $FormFileArg
$TaskPath = $TaskPathArg
$BaseName = $BaseNameArg
$FormType = 'OPERACIONAL'
$validado = $false

Invoke-Expression "switch (8) {`r`n$corpo`r`n}"

if ($validado) { "VEREDITO=PASSA"; exit 0 }
"VEREDITO=REPROVA"
exit 1


