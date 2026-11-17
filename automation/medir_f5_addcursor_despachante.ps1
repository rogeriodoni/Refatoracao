$ErrorActionPreference = 'Stop'
$orq = 'C:\4c\automation\OrquestradorMigracao.ps1'

# Extrai SO as FunctionDefinitionAst dos helpers (nao executa o orquestrador)
$tokens = $null; $errs = $null
$ast = [Management.Automation.Language.Parser]::ParseFile($orq, [ref]$tokens, [ref]$errs)
if ($errs.Count) { throw "Orquestrador nao parseia: $($errs[0].Message)" }

$querHelpers = @('Test-LegadoAddCursorLigaGrade','Test-DumpTemAgrupadorVcx')
$fns = $ast.FindAll({ $args[0] -is [Management.Automation.Language.FunctionDefinitionAst] }, $true) |
       Where-Object { $querHelpers -contains $_.Name }
foreach ($f in $fns) { Invoke-Expression $f.Extent.Text }
Write-Host "Helpers carregados: $(($fns | ForEach-Object Name) -join ', ')"

$rxWide   = '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)'
$rxNoCur  = '(?i)(pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)'
$rxGridPg = '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$'
$rxCampos = '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$'

$flips = @()
$dumps = Get-ChildItem 'C:\4c\tasks' -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue
foreach ($d in $dumps) {
    $t = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $t) { continue }
    if (([regex]::Matches($t, '(?im)^\s*BaseClass:\s*(\S+)\s*$')).Count -lt 1) { continue }

    $listaAntes  = ($t -match $rxGridPg) -or ($t -match $rxWide)
    $listaDepois = ($t -match $rxGridPg) -or ($t -match $rxNoCur) -or (Test-LegadoAddCursorLigaGrade -TextoDump $t)
    if ($listaAntes -eq $listaDepois) { continue }

    $flips += [pscustomobject]@{
        Task      = $d.Directory.Name
        Dump      = $d.Name
        TemCampos = [bool]($t -match $rxCampos)
        TemGridPg = [bool]($t -match $rxGridPg)
        TemVcx    = [bool](Test-DumpTemAgrupadorVcx -TextoDump $t)
        nAddCur   = ([regex]::Matches($t, '(?i)AddCursor')).Count
    }
}

Write-Host ""
Write-Host "Dumps varridos ........... $($dumps.Count)"
Write-Host "Dumps que FLIPAM lista ... $($flips.Count)"
Write-Host "  dos quais COM campos ... $(($flips | Where-Object TemCampos).Count)"
Write-Host "  dos quais COM grid/pgf . $(($flips | Where-Object TemGridPg).Count)"
Write-Host "  dos quais COM VCX ...... $(($flips | Where-Object TemVcx).Count)"
Write-Host ""
Write-Host "=== DELTA EFETIVO: flips SEM campos, SEM grid/pgf e SEM VCX (entram em DESPACHANTE) ==="
$flips | Where-Object { -not $_.TemCampos -and -not $_.TemGridPg -and -not $_.TemVcx } |
    Sort-Object Dump | Format-Table Task, Dump, nAddCur -AutoSize
