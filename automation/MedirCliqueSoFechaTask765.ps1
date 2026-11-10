# Mede, nos dumps de tasks\, (a) o delta de Test-LegadoCliqueSoFecha causado
# pelas 3 tolerancias novas em Test-LinhaDeFechamentoLegado e (b) o alcance do
# predicado novo Test-LegadoBotaoUnicoSoFecha.
param(
    [string]$Pre = 'C:\4c\automation\_Orq_antes_task765.ps1',
    [string]$Pos = 'C:\4c\automation\OrquestradorMigracao.ps1'
)
$ErrorActionPreference = 'Stop'

function Get-TextoFuncoes {
    param([string]$Caminho, [string[]]$Nomes, [string]$Sufixo)
    $out = New-Object System.Collections.Generic.List[string]
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($Caminho, [ref]$null, [ref]$null)
    foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
        if ($Nomes -contains $f.Name) {
            $txt = $f.Extent.Text
            if ($Sufixo) {
                foreach ($n in $Nomes) { $txt = $txt.Replace($n, ($n + $Sufixo)) }
            }
            $out.Add($txt)
        }
    }
    return ($out -join "`n")
}

$compart = @('Get-ContagemBotoesLegado','Get-NomesBotoesLegado','Get-CorpoClickDoObjetoLegado')
. ([scriptblock]::Create((Get-TextoFuncoes -Caminho $Pos -Nomes $compart -Sufixo '')))
. ([scriptblock]::Create((Get-TextoFuncoes -Caminho $Pre -Nomes @('Test-LegadoCliqueSoFecha') -Sufixo 'PRE')))
. ([scriptblock]::Create((Get-TextoFuncoes -Caminho $Pos -Nomes @('Test-LegadoCliqueSoFecha','Test-LinhaDeFechamentoLegado','Test-LegadoBotaoUnicoSoFecha') -Sufixo 'POS')))

$dumps = Get-ChildItem 'C:\4c\tasks' -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue
"dumps = $($dumps.Count)"

$flipsFecha = New-Object System.Collections.Generic.List[string]
$botaoUnico = New-Object System.Collections.Generic.List[string]
foreach ($d in $dumps) {
    $t = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $t) { continue }
    $a = Test-LegadoCliqueSoFechaPRE -TextoDump $t
    $b = Test-LegadoCliqueSoFechaPOS -TextoDump $t
    if ("$a" -ne "$b") { $flipsFecha.Add("$($d.Directory.Name)/$($d.Name)  PRE=$a POS=$b") }
    if (Test-LegadoBotaoUnicoSoFechaPOS -TextoDump $t) {
        $botaoUnico.Add("$($d.Directory.Name)/$($d.Name)  cliqueSoFechaPRE=$a")
    }
}
""
"(a) Test-LegadoCliqueSoFecha - flips = $($flipsFecha.Count)"
$flipsFecha | Sort-Object | ForEach-Object { "    $_" }
""
"(b) Test-LegadoBotaoUnicoSoFecha = TRUE em $($botaoUnico.Count) dump(s)"
$botaoUnico | Sort-Object | ForEach-Object { "    $_" }
