# Mede a largura do Test-LegadoComplementoFilho REAL (extraido do
# OrquestradorMigracao.ps1 por AST, nunca dot-source do arquivo inteiro -
# dot-source dispara migracao) sobre TODOS os dumps de tasks\.
param([string]$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1',
      [string]$RaizTasks    = 'C:\4c\tasks')
$ErrorActionPreference = 'Stop'

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
$n = 0
foreach ($f in $ast.FindAll({ param($x) $x -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    if ($f.Name -in @('Test-LegadoComplementoFilho','Get-ContagemBotoesLegado')) {
        . ([scriptblock]::Create($f.Extent.Text)); $n++
    }
}
"FUNCOES CARREGADAS DO ORQUESTRADOR = $n"
if (-not (Get-Command Test-LegadoComplementoFilho -ErrorAction SilentlyContinue)) {
    "FALHA: Test-LegadoComplementoFilho nao encontrada no orquestrador"; exit 1
}

$dumps = Get-ChildItem -Path $RaizTasks -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue
"DUMPS ANALISADOS = {0}" -f $dumps.Count
$casa = @()
foreach ($d in $dumps) {
    $t = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if (Test-LegadoComplementoFilho -TextoDump $t) { $casa += $d }
}
""
"CASAM O PREDICADO (lado-dump) = {0}" -f $casa.Count
$casa | ForEach-Object { "   {0}  ({1})" -f $_.Name, $_.Directory.Name }
"FORMS DISTINTOS = {0}" -f (@($casa | ForEach-Object { $_.Name } | Select-Object -Unique).Count)
