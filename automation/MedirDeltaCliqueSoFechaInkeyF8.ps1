# MedirDeltaCliqueSoFechaInkeyF8.ps1
#
# Blast radius da tolerancia a Inkey() com resultado DESCARTADO em
# Test-LegadoCliqueSoFecha (Erro200, task649 / SIGOPBUS).
#
# Compara o veredito do helper na versao do DISCO com a do backup
# OrquestradorMigracao.ps1.bak-erro200-inkey, dump por dump, em tasks\.
# Exige: (a) zero regressao (True -> nao-True, estruturalmente impossivel
# porque o resultado so alimenta dispensas, mas medido de todo jeito) e
# (b) alcance minimo - medido em 2026-10-17: 1 flip em 648 dumps (sigopbus).
#
# AST-only: dot-source do orquestrador DISPARA uma migracao real.
$novo  = 'C:\4c\automation\OrquestradorMigracao.ps1'
$velho = 'C:\4c\automation\OrquestradorMigracao.ps1.bak-erro200-inkey'
foreach ($p in @($novo,$velho)) {
    $e = $null
    [System.Management.Automation.Language.Parser]::ParseFile($p, [ref]$null, [ref]$e) | Out-Null
    if ($e -and $e.Count -gt 0) { "SINTAXE=FALHA em $p"; $e | Select-Object -First 3 | % { $_.Message }; exit 1 }
}
"SINTAXE=OK (disco e backup)"

$corpos = @{}
foreach ($par in @(@($novo,'Novo'), @($velho,'Velho'))) {
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($par[0], [ref]$null, [ref]$null)
    foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
        if ($f.Name -eq 'Test-LegadoCliqueSoFecha') {
            $corpos[$par[1]] = $f.Extent.Text -replace '^function\s+Test-LegadoCliqueSoFecha', ("function Test-CSF" + $par[1])
        }
        if ($par[1] -eq 'Novo' -and $f.Name -eq 'Get-ContagemBotoesLegado') {
            $corpos['Botoes'] = $f.Extent.Text
        }
    }
}
. ([scriptblock]::Create($corpos['Novo']))
. ([scriptblock]::Create($corpos['Velho']))
. ([scriptblock]::Create($corpos['Botoes']))
"helpers carregados: {0}" -f ((Get-Command Test-CSFNovo, Test-CSFVelho, Get-ContagemBotoesLegado).Count)

$dumps = Get-ChildItem 'C:\4c\tasks' -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue
"dumps analisados = $($dumps.Count)"

$flips = @()
foreach ($d in $dumps) {
    $txt = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $txt) { continue }
    $v = Test-CSFVelho -TextoDump $txt
    $n = Test-CSFNovo  -TextoDump $txt
    if ($v -ne $n) {
        $flips += [pscustomobject]@{
            Task    = Split-Path (Split-Path $d.FullName -Parent) -Leaf
            Dump    = $d.Name -replace '_form_codigo_fonte\.txt$',''
            Velho   = $(if ($null -eq $v) {'<nulo>'} else {$v})
            Novo    = $(if ($null -eq $n) {'<nulo>'} else {$n})
            NBotoes = (Get-ContagemBotoesLegado -TextoDump $txt)
        }
    }
}
"flips do helper = $($flips.Count)"
$flips | Sort-Object Dump | Format-Table -AutoSize | Out-String -Width 200 | Write-Host
"regressoes (True -> nao-True) = {0}" -f (@($flips | Where-Object { $_.Velho -eq $true -and $_.Novo -ne $true })).Count
"forms distintos afetados      = {0}" -f (@($flips | Select-Object -ExpandProperty Dump -Unique)).Count
