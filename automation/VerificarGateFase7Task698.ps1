# VerificarGateFase7Task698.ps1
#
# Reproduz o bloco `case 7` REAL do OrquestradorMigracao.ps1 (recortado por
# numero de linha e executado via switch), sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real (move .SCX de origem\ e
# sobrescreve BO existente).
#
# Alvo: SIGOPCHI -> FormSigOpChi (task698), "Historico de Cheques": 1000x600,
# Class/BaseClass form PURO, consultor somente-leitura do historico de UM
# cheque - 3 grades (Cheque/Movimenta/Prorrog), 2 paineis de filtro de conta
# (Origem na Pagina.Filtro, Emitente na Pagina.Historico) e 11 botoes: os 8 do
# CommandGroup Grupo_op (Relatorio, FollowUpChq, Documento, Procurar,
# Prorroga, FollowUp, Protocolo, Carteira), o 1 do Grupo_Saida e os 2
# CommandButton soltos da Pagina.Filtro (Ok "Processar" e cancelar
# "Encerrar").
#
# O dump NAO tem frmcadastro, NAO tem pcEscolha, NAO tem nome
# btn|cmd(Incluir|Alterar|Visualizar|Excluir) e NAO tem "<Verbo>.Click": a
# UNICA evidencia de CRUD eh o NOME do CommandGroup 'Grupo_op' - que aqui eh
# do PROPRIO form (todas as 16 citacoes sao
# "ThisForm.Pagina.Historico.Grupo_op...") e cujos 8 botoes nao tem UM UNICO
# verbo CRUD: sao acoes de dominio sobre o cheque corrente.
#
# Ramo esperado: DECIMA-PRIMEIRA excecao da familia, e a SEGUNDA que olha a
# evidencia ESTRUTURAL 'Grupo_Op' (a decima, Test-BarraCrudEhDoFormPai, tratou
# 'Grupo_Op' do form PAI e nao alcanca este caso, porque aqui o grupo eh
# mesmo deste form).
#
# Sem a dispensa, a fase exige os quatro BtnXxxClick - insatisfazivel sem
# INVENTAR botao (viola o PILAR 1) ou criar metodo vazio (proibido pela regra
# de completude).
#
# Uso:
#   & C:\4c\automation\VerificarGateFase7Task698.ps1
#   & ... -Orquestrador <caminho>   (para comparar com um backup/PRE)
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathArg  = 'C:\4c\tasks\task698',
    [string]$BaseNameArg  = 'SigOpChi',
    [string]$FormFileArg  = 'C:\4c\projeto\app\forms\operacionais\FormSigOpChi.prg'
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
