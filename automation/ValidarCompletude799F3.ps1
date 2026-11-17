param([string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1')
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}
$okForm = Test-CompletudeCodigo -FilePath 'C:\4c\projeto\app\forms\operacionais\Formsigopsen.prg' -Descricao 'Form (Formsigopsen)'
"Form={0}" -f $okForm
if ($okForm) { exit 0 }
exit 1
