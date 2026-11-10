# MedirGateFase4PaginadoNaoCrud.ps1
#
# Blast radius do ramo PAGINADO NAO-CRUD acrescentado ao `case 4` do
# OrquestradorMigracao.ps1 (task742 / SIGOPFIS -> Formsigopfis).
#
# Mede em DOIS niveis, como manda o procedimento:
#   (a) PREDICADO - quantos dumps de tasks\ satisfazem $legadoPaginadoSemDadosF4
#   (b) VEREDITO  - roda o `case 4` RECORTADO das versoes PRE e POS contra
#                   TODOS os forms com dump + .prg + analise.json, e lista
#                   cada mudanca de veredito nas DUAS direcoes.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File automation\MedirGateFase4PaginadoNaoCrud.ps1
param(
    [string]$OrqPos = 'C:\4c\automation\OrquestradorMigracao.ps1',
    [string]$OrqPre = 'C:\4c\automation\_Orq_antes_task742.ps1',
    [string]$TasksDir = 'C:\4c\tasks',
    [string]$ProjetoDir = 'C:\4c\projeto'
)

$ErrorActionPreference = 'Stop'

function Get-CaseBlock([string]$arquivo, [int]$numero) {
    $linhas = Get-Content $arquivo
    $ini = -1; $fim = -1
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        if ($ini -lt 0 -and $linhas[$i] -match ('^\s{8}' + $numero + '\s\{\s*$')) { $ini = $i; continue }
        if ($ini -ge 0 -and $linhas[$i] -match '^\s{8}\}\s*$') { $fim = $i; break }
    }
    if ($ini -lt 0 -or $fim -lt 0) { throw "case $numero nao localizado em $arquivo" }
    return ($linhas[$ini..$fim] -join "`r`n")
}

# helpers vem SEMPRE da versao POS (o PRE nao tem o ramo novo, mas os helpers
# que ele usa sao os mesmos - Test-LegadoPaginadoSemPaginaDados ja existia)
$ast = [System.Management.Automation.Language.Parser]::ParseFile($OrqPos, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$corpoPre = Get-CaseBlock $OrqPre 4
$corpoPos = Get-CaseBlock $OrqPos 4

$res = New-Object System.Collections.ArrayList

Get-ChildItem $TasksDir -Directory | ForEach-Object {
    $taskDir = $_.FullName
    $task    = $_.Name

    $aj = Join-Path $taskDir 'analise.json'
    if (-not (Test-Path $aj)) { return }
    $ft = 'CRUD'; $fc = ''; $bc = ''
    try {
        $o = (Get-Content $aj -Raw | ConvertFrom-Json)
        if ($o.form.formType)  { $ft = $o.form.formType }
        if ($o.form.formClass) { $fc = $o.form.formClass }
        if ($o.form.boClass)   { $bc = $o.form.boClass }
    } catch { return }

    $dump = Get-ChildItem $taskDir -Filter '*_form_codigo_fonte.txt' -File -EA SilentlyContinue | Select-Object -First 1
    if (-not $dump) { return }
    $base = $dump.BaseName -replace '_form_codigo_fonte$', ''

    if (-not $fc) { $fc = Get-FormClassName -BaseName $base }
    if (-not $bc) { $bc = Get-BOClassName   -BaseName $base }

    $sub = Get-FormSubDir -FormType $ft
    $ff  = Join-Path $ProjetoDir "app\forms\$sub\$fc.prg"
    if (-not (Test-Path $ff)) {
        $alt = Find-FormFile -ProjetoPath $ProjetoDir -FormClass $fc -PreferredSubDir $sub
        if ($alt) { $ff = $alt }
    }
    if (-not (Test-Path $ff)) { return }

    # --- predicado isolado ---
    $txt = Get-Content $dump.FullName -Raw -EA SilentlyContinue
    $predicado = $false
    if ($txt -and $ft -eq 'OPERACIONAL') {
        $outra = ($txt -match '(?im)^\s*BaseClass:\s*grid\s*$') -or
                 (Test-LegadoListBoxLigaLista       -TextoDump $txt) -or
                 (Test-LegadoTokenGradeProprioForm  -TextoDump $txt) -or
                 (Test-LegadoAddCursorLigaGrade     -TextoDump $txt) -or
                 (Test-LegadoControlSourceLigaLista -TextoDump $txt)
        $predicado = (Test-LegadoPaginadoSemPaginaDados -TextoDump $txt) -and (-not $outra)
    }

    # --- veredito PRE / POS ---
    $vereditos = @{}
    foreach ($par in @(@('PRE', $corpoPre), @('POS', $corpoPos))) {
        $formFile  = $ff
        $TaskPath  = $taskDir
        $BaseName  = $base
        $FormType  = $ft
        $formClass = $fc
        $boClass   = $bc
        $validado  = $false
        try {
            Invoke-Expression "switch (4) {`r`n$($par[1])`r`n}" 6>$null | Out-Null
        } catch {
            $validado = $null
        }
        $vereditos[$par[0]] = $validado
    }

    [void]$res.Add([pscustomobject]@{
        Task = $task; Base = $base; FT = $ft; Form = $fc
        Predicado = $predicado
        PRE = $vereditos['PRE']; POS = $vereditos['POS']
    })
}

"=== UNIVERSO ==="
"forms medidos (dump + analise.json + .prg)       : {0}" -f $res.Count
"  OPERACIONAL                                    : {0}" -f @($res | Where-Object { $_.FT -eq 'OPERACIONAL' }).Count
""
"=== (a) PREDICADO legadoPaginadoSemDadosF4 ==="
$pred = @($res | Where-Object { $_.Predicado })
"tasks que satisfazem o predicado                 : {0}" -f $pred.Count
"forms distintos                                  : {0}" -f @($pred | Select-Object -ExpandProperty Base -Unique).Count
$pred | Sort-Object Base, Task | Format-Table Task, Base, Form, PRE, POS -AutoSize
""
"=== (b) VEREDITO: mudancas ==="
$flipUp   = @($res | Where-Object { $_.PRE -eq $false -and $_.POS -eq $true })
$flipDown = @($res | Where-Object { $_.PRE -eq $true  -and $_.POS -eq $false })
$erro     = @($res | Where-Object { $null -eq $_.PRE -or $null -eq $_.POS })
"REPROVA -> PASSA                                 : {0}" -f $flipUp.Count
$flipUp | Sort-Object Base | Format-Table Task, Base, Form, Predicado -AutoSize
"PASSA -> REPROVA (regressao)                     : {0}" -f $flipDown.Count
$flipDown | Sort-Object Base | Format-Table Task, Base, Form, Predicado -AutoSize
"nao medidos (excecao no bloco)                   : {0}" -f $erro.Count
$erro | Sort-Object Base | Format-Table Task, Base, Form, PRE, POS -AutoSize
