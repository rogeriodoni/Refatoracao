# VerificarGateFase8Task724.ps1
#
# Reproduz o bloco `case 8` REAL do OrquestradorMigracao.ps1 (recortado por
# numero de linha e executado via switch), sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real (move .SCX de origem\ e
# sobrescreve BO existente).
#
# Alvo: SigOpDpe -> FormSigOpDpe (task724), dialogo FILHO modal "Tabela de
# Depreciacao da Operacao": 600x349, Class/BaseClass form puro, TitleBar=0,
# ControlBox=.F., BorderStyle=2, DataSession=2; UMA grade propria de 3
# colunas (GradeSubN -> crSigOpDup: Qtddis / Qtddfs / Percs) e DOIS
# CommandButton soltos - cmdExcluir (Delete na linha do cursor) e cmdSair
# ("Encerrar", Cancel=.T., que grava o lote e fecha). NAO ha botao de
# INSERIR: a linha nova entra pelo metodo inserelinha, chamado dos dois
# LostFocus de celula - por isso o ramo LINHA-IMEDIATA (que exige botao
# Inserir E botao Excluir declarados) NAO alcanca esta tela.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase8Task724.ps1
#   ... -Orquestrador <caminho>   (para comparar com um backup/HEAD)
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task724',
    [string]$BaseNameArg  = 'SigOpDpe',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\FormSigOpDpe.prg'
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
