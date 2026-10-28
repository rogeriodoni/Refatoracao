# VerificarGateFase7Task689.ps1
#
# Reproduz o bloco `case 7` REAL do OrquestradorMigracao.ps1 (recortado por
# numero de linha e executado via switch), sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real (move .SCX de origem\ e
# sobrescreve BO existente).
#
# Alvo: SIGOPCGB -> Formsigopcgb (task689), "Pesquisa Global de Codigo de
# Barras": 1000x600, Class/BaseClass form PURO, consultor somente-leitura de
# um codigo de barras - 4 grades (Historico/Movimento/Devolucao/Cotacoes),
# um painel flutuante de Etiquetas e 8 botoes (cmdBtnForm, btnImprimir,
# btnLocal, btnVisualizar, btnDocumento, Bot_Rastro, Botao_de_Correcao e o
# cmdBtnForm do Cnt_Correcao), mais o checkbox Bot_Cotacoes.
#
# O dump NAO tem frmcadastro, Grupo_Op, pcEscolha nem "<X>.Click": a UNICA
# evidencia de CRUD eh o NOME 'btnVisualizar' - que aqui eh o par do
# btnImprimir na impressao da etiqueta. Os dois Click sao
# "ThisForm.Imagem('V')" e "ThisForm.Imagem('I')", e o metodo 'imagem' termina
# em "If lcTip = 'I' / Report Form SIGOPCGB To Print Prompt NoConsole / Else /
# Report Form SIGOPCGB Preview NoConsole / EndIf".
#
# Ramo esperado: SETIMA excecao da familia "evidencia de NOME"
# (Test-VerbosCrudSaoTodosDeRelatorio), que desempata 'Visualizar' pelo que o
# botao FAZ. Ela precisou de duas correcoes para alcancar este caso:
#   1. passou a tomar o corpo do Click de Get-CorpoClickDoObjetoLegado, que
#      cobre as DUAS formas do extrator - o regex proprio que ela usava cobria
#      so a QUALIFICADA ("PROCEDURE btnX.Click") e nunca encontrava o Click de
#      CommandButton SOLTO, que sai na forma BARE ("* OBJETO: ..." +
#      "PROCEDURE Click"). Num gate fail-closed isso virava "ausencia de prova"
#      e a dispensa jamais acontecia para botao solto, sem erro e sem aviso;
#   2. passou a seguir UM nivel de indirecao - Click que so delega para um
#      METODO DO FORM cujo corpo tem REPORT FORM (Get-CorpoMetodoDoFormLegado).
#
# Sem a dispensa, a fase exigia os quatro BtnXxxClick - insatisfazivel sem
# INVENTAR botao (viola o PILAR 1) ou criar metodo vazio (proibido pela regra
# de completude), mesmo com os 10 handlers reais dos 9 botoes/checkbox.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase7Task689.ps1
#   ... -Orquestrador <caminho>   (para comparar com um backup/HEAD)
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task689',
    [string]$BaseNameArg  = 'sigopcgb',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\Formsigopcgb.prg'
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

# Recorta o bloco `case 7` pelo PROPRIO texto do arquivo (nao por copia
# manual): a copia envelheceria em silencio na proxima excecao nova.
$linhas = Get-Content $Orquestrador
$ini = -1; $fim = -1
for ($i = 0; $i -lt $linhas.Count; $i++) {
    if ($ini -lt 0 -and $linhas[$i] -match '^\s{8}7\s\{\s*$') { $ini = $i; continue }
    if ($ini -ge 0 -and $linhas[$i] -match '^\s{8}\}\s*$')    { $fim = $i; break }
}
if ($ini -lt 0 -or $fim -lt 0) { "RECORTE=FALHA (case 7 nao localizado)"; exit 2 }
"RECORTE=OK  (linhas {0}..{1})" -f ($ini + 1), ($fim + 1)

$corpo = ($linhas[$ini..$fim] -join "`r`n")

# Variaveis que o bloco consome do escopo de Invoke-MigracaoFase
$formFile = $FormFileArg
$TaskPath = $TaskPathArg
$BaseName = $BaseNameArg
$FormType = 'OPERACIONAL'
$validado = $false

Invoke-Expression "switch (7) {`r`n$corpo`r`n}"

if ($validado) { "VEREDITO=PASSA"; exit 0 }
"VEREDITO=REPROVA"
exit 1
