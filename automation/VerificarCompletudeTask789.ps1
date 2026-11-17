# Roda Test-CompletudeCodigo (etapa 05d) sem executar o orquestrador -
# dot-source dele DISPARA uma migracao real.
param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string[]]$Arquivos = @(
        'C:\4c\projeto\app\classes\SIGOPPRMBO.prg',
        'C:\4c\projeto\app\forms\operacionais\FormSIGOPPRM.prg'
    )
)
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    if ($f.Name -eq 'Test-CompletudeCodigo') { . ([scriptblock]::Create($f.Extent.Text)) }
}
$ok = $true
foreach ($a in $Arquivos) {
    if (-not (Test-CompletudeCodigo -FilePath $a -Descricao (Split-Path $a -Leaf))) { $ok = $false }
}
if ($ok) { 'COMPLETUDE=OK'; exit 0 }
'COMPLETUDE=FALHA'; exit 1
