# VerificarGateFase8Task680.ps1
#
# Reproduz o bloco `case 8` REAL do OrquestradorMigracao.ps1 (recortado por
# numero de linha e executado via switch), sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real (move .SCX de origem\ e
# sobrescreve BO existente).
#
# Alvo: SIGPRTAM -> Formsigprtam (task680), dialogo filho "Peso medio por
# tamanho" do Cadastro de Produtos: 638x540, Class/BaseClass form puro,
# TitleBar=0, ControlBox=.F., WindowType=1, SEM PageFrame; uma Grade de 6
# colunas (Tam./Descricao/Peso Medio/Percentual/Valor/Entrega) ligada a
# crSigPrTam e TRES botoes fwbtng - cmdInserir (acrescenta linha em branco),
# cmdExcluir ("Delete / Skip / Skip -1") e cmdSair (Cancel=.T., valida que
# toda linha tem Tamanho e fecha).
#
# Ramo esperado: LINHA-IMEDIATA (o 5o do case 8, estreado por SIGPRCAR e
# reusado por SIGPRCOT) - grade com Inserir/Excluir de LINHA, sem botao de
# gravar e sem Cancelar, porque a gravacao do legado eh o Replace na linha
# disparado pela escolha no lookup da celula. A dispensa desse ramo retira
# BtnCancelarClick da lista de metodos exigidos e a exigencia de botao de
# acao ($padraoAcaoGravar); FormParaBO/BOParaForm/CarregarLista continuam
# sendo cobrados e o migrado os entrega.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase8Task680.ps1
#   ... -Orquestrador <caminho>   (para comparar com um backup/HEAD)
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task680',
    [string]$BaseNameArg  = 'sigprtam',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\Formsigprtam.prg'
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
# manual): a copia envelheceria em silencio no proximo ramo novo.
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
