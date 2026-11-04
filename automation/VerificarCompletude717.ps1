# VerificarCompletude717.ps1
# Roda Test-CompletudeCodigo (do OrquestradorMigracao.ps1) contra o form e o BO
# da task717. AST-only: dot-source do orquestrador DISPARA uma migracao real
# (feedback_dot_source_orquestrador_dispara_migracao).

param(
    [string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1'
)

$ErrorActionPreference = 'Stop'

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
$n = 0
foreach ($f in $ast.FindAll({ param($x) $x -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
    $n++
}
"FUNCOES CARREGADAS=$n"

if (-not (Get-Command Test-CompletudeCodigo -ErrorAction SilentlyContinue)) {
    "Test-CompletudeCodigo NAO EXISTE no orquestrador - nada medido"
    exit 1
}

foreach ($alvo in @('C:\4c\projeto\app\forms\operacionais\FormSigOpCts.prg',
                    'C:\4c\projeto\app\classes\SigOpCtsBO.prg')) {
    ""
    "=== $alvo ==="
    $r = Test-CompletudeCodigo -FilePath $alvo -Descricao $alvo
    $r | Format-List | Out-String | Write-Output
}
