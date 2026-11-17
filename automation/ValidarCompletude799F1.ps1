param([string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1')
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}
$okBO = Test-CompletudeCodigo -FilePath 'C:\4c\projeto\app\classes\sigopsenBO.prg' -Descricao 'BO (sigopsenBO)'
"BO={0}" -f $okBO
if ($okBO) { exit 0 }
exit 1
