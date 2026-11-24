# =============================================================================
# VerificarGateFase8Task814.ps1
#
# Roda o VEREDITO da Fase 8 do OrquestradorMigracao SOBRE UM CASO SO
# (task814 / SIGOPPEC -> FormSigOpTrf), sem executar o orquestrador: extrai
# as funcoes via AST e recorta o bloco `case 8` por linha
# (dot-source do orquestrador dispararia uma migracao real -
# feedback_dot_source_orquestrador_dispara_migracao).
#
# Mesmo molde de SweepGateFase8ToolTip.ps1 / SweepGateFase8Navegador.ps1
# (fonte unica do harness).
# =============================================================================
param(
    [string]$Orq        = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$TaskPathIn = 'C:\4c\tasks\task814',
    [string]$BaseNameIn = 'SigOpTrf',
    [string]$FormFileIn = 'C:\4c\projeto\app\forms\operacionais\FormSigOpTrf.prg',
    [string]$FormClassIn= 'FormSigOpTrf',
    [string]$BoFileIn   = 'C:\4c\projeto\app\classes\SigOpTrfBO.prg',
    [string]$TipoIn     = 'OPERACIONAL',
    [int]$LinhaInicio   = 12140,
    [int]$LinhaFim      = 14909
)

$ErrorActionPreference = 'Stop'

function Import-Helpers {
    param([string]$Arquivo)
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($Arquivo, [ref]$null, [ref]$null)
    foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
        . ([scriptblock]::Create($f.Extent.Text))
    }
}

function Get-BlocoCase8 {
    param([string]$Arquivo)
    $ls = Get-Content $Arquivo
    $bl = $ls[($LinhaInicio - 1)..($LinhaFim - 1)]
    if ($bl[0] -notmatch '^\s*8\s*\{\s*$') { throw "ancora inicial errada (linha $LinhaInicio)" }
    if ($bl[-1] -notmatch '^\s*\}\s*$')    { throw "ancora final errada (linha $LinhaFim)" }
    $corpo = ($bl[1..($bl.Count - 2)] -join "`r`n")
    $e2 = $null
    [System.Management.Automation.Language.Parser]::ParseInput($corpo, [ref]$null, [ref]$e2) | Out-Null
    if ($e2 -and $e2.Count -gt 0) { throw "recorte invalido ($($e2.Count) erro(s))" }
    return [scriptblock]::Create($corpo)
}

. Import-Helpers -Arquivo $Orq
if (-not (Get-Command Test-AcaoDoLegadoTemHandler -ErrorAction SilentlyContinue)) {
    Write-Host "HELPERS NAO CARREGADOS - medicao invalida" -ForegroundColor Red
    exit 1
}

$sb = Get-BlocoCase8 -Arquivo $Orq

$TaskPath = $TaskPathIn
$BaseName = $BaseNameIn
$formFile = $FormFileIn
$formClass = $FormClassIn
$boFile   = $BoFileIn
$boClass  = "$($BaseNameIn)BO"
$FormType = $TipoIn
$validado = $false
$metodosFaltantes = @()

. $sb

Write-Host ""
Write-Host "=== VEREDITO FASE 8 (task814 / $BaseName) ==="
Write-Host ("validado         = {0}" -f $validado)
Write-Host ("metodosFaltantes = {0}" -f (($metodosFaltantes -join ', ')))
if ($validado) { Write-Host "PASSA" -ForegroundColor Green } else { Write-Host "REPROVA" -ForegroundColor Red }
