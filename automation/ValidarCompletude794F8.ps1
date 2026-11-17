# ValidarCompletude794F8.ps1
# Roda a PROPRIA Test-CompletudeCodigo do OrquestradorMigracao.ps1 (extraida por
# AST, sem dot-source do script inteiro) contra os dois arquivos da task794.
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1'
)
$ErrorActionPreference = 'Stop'

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    if ($f.Name -eq 'Test-CompletudeCodigo') { . ([scriptblock]::Create($f.Extent.Text)) }
}

$form = 'C:\4c\projeto\app\forms\operacionais\FormSigOpRef.prg'
$bo   = 'C:\4c\projeto\app\classes\SigOpRefBO.prg'

"FORM = {0}" -f (Test-CompletudeCodigo -FilePath $form -Descricao 'FormSigOpRef.prg')
"BO   = {0}" -f (Test-CompletudeCodigo -FilePath $bo   -Descricao 'SigOpRefBO.prg')

