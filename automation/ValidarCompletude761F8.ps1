# Roda a Test-CompletudeCodigo REAL do orquestrador (etapa 05d_validarCompletude)
# sobre o Form e o BO da task761, sem executar o orquestrador.
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1'
)
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}
$okForm = Test-CompletudeCodigo -FilePath 'C:\4c\projeto\app\forms\operacionais\FormSigOpLim.prg' -Descricao 'Form (FormSigOpLim)'
$okBO   = Test-CompletudeCodigo -FilePath 'C:\4c\projeto\app\classes\SigOpLimBO.prg'              -Descricao 'BO (SigOpLimBO)'
"FORM={0}  BO={1}" -f $okForm, $okBO
if ($okForm -and $okBO) { exit 0 }
exit 1
