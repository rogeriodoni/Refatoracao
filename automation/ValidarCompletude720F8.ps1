param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$Arquivo      = 'C:\4c\projeto\app\forms\operacionais\FormSigOpDet.prg'
)
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}
if (-not (Get-Command Test-CompletudeCodigo -ErrorAction SilentlyContinue)) {
    'Test-CompletudeCodigo NAO EXISTE no orquestrador'; exit 2
}
$r = Test-CompletudeCodigo -FilePath $Arquivo
$r | Format-List *
