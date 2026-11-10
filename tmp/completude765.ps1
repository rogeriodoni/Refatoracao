param([string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1')
$ErrorActionPreference = 'Stop'
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
$txt = ''
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    if ($f.Name -eq 'Test-CompletudeCodigo') { $txt = $f.Extent.Text }
}
. ([scriptblock]::Create($txt))
"FORM = {0}" -f (Test-CompletudeCodigo -FilePath 'C:\4c\projeto\app\forms\operacionais\FormSigOpLrC.prg' -Descricao 'FormSigOpLrC.prg')
"BO   = {0}" -f (Test-CompletudeCodigo -FilePath 'C:\4c\projeto\app\classes\SigOpLrCBO.prg'   -Descricao 'SigOpLrCBO.prg')
