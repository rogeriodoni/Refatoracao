# RevisarCodigo768F8.ps1
# Roda Test-CodeReviewProblems do OrquestradorMigracao.ps1 (extraida por AST)
# contra os dois arquivos da task768. O CHECK 17 da funcao usa as variaveis
# de escopo de script $config/$TaskId do Orquestrador - por isso elas sao
# recriadas aqui.
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1'
)
$ErrorActionPreference = 'Stop'

$config = [pscustomobject]@{ paths = [pscustomobject]@{ tasks = 'C:\4c\tasks' } }
$TaskId = 'task768'

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    if ($f.Name -eq 'Test-CodeReviewProblems') { . ([scriptblock]::Create($f.Extent.Text)) }
}

$res = Test-CodeReviewProblems `
    -FormFile 'C:\4c\projeto\app\forms\operacionais\FormSigOpMpd.prg' `
    -BOFile   'C:\4c\projeto\app\classes\SigOpMpdBO.prg' `
    -OriginalSourceFile 'C:\4c\tasks\task768\SigOpMpd_form_codigo_fonte.txt'

if (-not $res -or $res.Count -eq 0) { "SEM PROBLEMAS" } else { $res | ForEach-Object { "- $_" } }
