# VerificarGatesFase3a7Task757.ps1
#
# Regressao: roda os blocos `case 3..7` REAIS do OrquestradorMigracao.ps1
# (extraidos por linha, sem dot-source do orquestrador) sobre o
# FormSigOpLcl/SigOpLclBO ja alterado pela Fase 8, para provar que a
# consolidacao (rename VincularGrade -> CarregarLista + os dois hooks)
# nao derrubou nenhuma fase anterior.

param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1'
)

$ErrorActionPreference = 'Stop'

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

# ancoras obtidas por AST (nao hardcoded a esmo)
$ancoras = @{}
foreach ($s in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.SwitchStatementAst] }, $true)) {
    foreach ($c in $s.Clauses) {
        if ($c.Item2.Extent.StartLineNumber -gt 9000 -and $c.Item1.Extent.Text -match '^[3-7]$') {
            $ancoras[[int]$c.Item1.Extent.Text] = @($c.Item2.Extent.StartLineNumber, $c.Item2.Extent.EndLineNumber)
        }
    }
}

$linhas = Get-Content $Orquestrador

foreach ($fase in 3..7) {
    # contexto da task757, refeito a cada fase (o corpo do case escreve nessas vars)
    $TaskPath  = 'C:\4c\tasks\task757'
    $BaseName  = 'SigOpLcl'
    $FormType  = 'OPERACIONAL'
    $formClass = 'FormSigOpLcl'
    $boClass   = 'SigOpLclBO'
    $formFile  = 'C:\4c\projeto\app\forms\operacionais\FormSigOpLcl.prg'
    $boFile    = 'C:\4c\projeto\app\classes\SigOpLclBO.prg'
    $validado  = $false

    $ini, $fim = $ancoras[$fase]
    $bloco = $linhas[($ini - 1)..($fim - 1)]
    $corpo = ($bloco[1..($bloco.Count - 2)] -join "`r`n")

    $e = $null
    [System.Management.Automation.Language.Parser]::ParseInput($corpo, [ref]$null, [ref]$e) | Out-Null
    if ($e -and $e.Count -gt 0) {
        "FASE {0}: RECORTE INVALIDO - {1}" -f $fase, $e[0].Message
        continue
    }

    "--- FASE $fase (linhas $ini..$fim) ---"
    . ([scriptblock]::Create($corpo))
    "FASE {0} VEREDITO = {1}" -f $fase, $(if ($validado) { 'PASSA' } else { 'REPROVA' })
    ""
}
