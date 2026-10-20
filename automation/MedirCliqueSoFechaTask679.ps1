# MedirCliqueSoFechaTask679.ps1
#
# Mede o ALCANCE da tolerancia acrescentada em Test-LegadoCliqueSoFecha na
# task679 (RELEASE WINDOWS + limpar o proprio <controle>.Value antes de
# fechar): compara o helper das DUAS versoes do orquestrador em TODOS os
# dumps de tasks\ e lista os que mudam de veredito. O veredito FINAL da fase
# se mede com VerificarGateFase8Task679.ps1 -Orquestrador <versao>, porque
# sweep que so reproduz as provas do predicado SUPERESTIMA (os ramos exigem
# "-not" de todos os anteriores).
param(
    [string]$Antes  = 'C:\4c\automation\_Orq_antes_task679.ps1',
    [string]$Depois = 'C:\4c\automation\OrquestradorMigracao.ps1'
)

$ErrorActionPreference = 'Stop'

$srcAntes  = ([System.Management.Automation.Language.Parser]::ParseFile($Antes,  [ref]$null, [ref]$null)).FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -eq 'Test-LegadoCliqueSoFecha' }, $false)[0].Extent.Text
$srcDepois = ([System.Management.Automation.Language.Parser]::ParseFile($Depois, [ref]$null, [ref]$null)).FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -eq 'Test-LegadoCliqueSoFecha' }, $false)[0].Extent.Text

. ([scriptblock]::Create(($srcAntes  -replace '^function\s+Test-LegadoCliqueSoFecha', 'function Test-CliqueAntes')))
. ([scriptblock]::Create(($srcDepois -replace '^function\s+Test-LegadoCliqueSoFecha', 'function Test-CliqueDepois')))

$dumps = Get-ChildItem 'C:\4c\tasks' -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue
"dumps analisados = {0}" -f $dumps.Count

$mudam = @()
foreach ($d in $dumps) {
    $t = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $t) { continue }
    $a = "$(Test-CliqueAntes  -TextoDump $t)"
    $b = "$(Test-CliqueDepois -TextoDump $t)"
    if ($a -ne $b) {
        $mudam += [pscustomobject]@{
            Task   = Split-Path (Split-Path $d.FullName -Parent) -Leaf
            Base   = ($d.Name -replace '_form_codigo_fonte\.txt$','')
            Antes  = $a
            Depois = $b
        }
    }
}
"helper muda de veredito em {0} dump(s)" -f $mudam.Count
$mudam | Sort-Object Base, Task | ForEach-Object { "  {0,-14} {1,-12} {2} -> {3}" -f $_.Base, $_.Task, $_.Antes, $_.Depois }
"BaseName distintos = {0}" -f (($mudam | Select-Object -ExpandProperty Base -Unique | Sort-Object) -join ', ')
