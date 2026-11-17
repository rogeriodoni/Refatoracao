$ErrorActionPreference='Stop'
$orq='C:\4c\automation\OrquestradorMigracao.ps1'
$tk=$null;$er=$null
$ast=[Management.Automation.Language.Parser]::ParseFile($orq,[ref]$tk,[ref]$er)
if($er.Count){throw "parse: $($er[0].Message)"}
$want=@('Test-LegadoAddCursorLigaGrade','Test-DumpTemAgrupadorVcx','Test-LegadoSemCampoNemLista','Test-LegadoSemCamposSoltos')
$ast.FindAll({$args[0] -is [Management.Automation.Language.FunctionDefinitionAst]},$true)|
  Where-Object{$want -contains $_.Name}|ForEach-Object{Invoke-Expression $_.Extent.Text}

$rxGridPg='(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$'
$rxCampos='(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$'

# (A) o dump do task793 passa pelo predicado REAL ja patcheado?
$t=Get-Content 'C:\4c\tasks\task793\sigoprbt_form_codigo_fonte.txt' -Raw
Write-Host ("(A) Test-LegadoSemCampoNemLista(sigoprbt) = {0}  <-- precisa ser True" -f (Test-LegadoSemCampoNemLista -TextoDump $t))

# (B) regressao: nenhum dump com grid/pageframe pode passar o predicado
$violacoes=@(); $passam=@()
foreach($d in (Get-ChildItem 'C:\4c\tasks' -Recurse -Filter '*_form_codigo_fonte.txt')){
    $x=Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if(-not $x){continue}
    if(Test-LegadoSemCampoNemLista -TextoDump $x){
        $passam += $d.Name
        if(($x -match $rxGridPg) -or ($x -match $rxCampos) -or (Test-DumpTemAgrupadorVcx -TextoDump $x)){
            $violacoes += $d.FullName
        }
    }
}
Write-Host ("(B) dumps que passam o predicado .......... {0} ({1} forms distintos)" -f $passam.Count, ($passam|Sort-Object -Unique).Count)
Write-Host ("(B) VIOLACOES (com grid/campo/VCX) ........ {0}  <-- precisa ser 0" -f $violacoes.Count)
if($violacoes.Count){$violacoes|ForEach-Object{Write-Host "    !! $_" -ForegroundColor Red}}
Write-Host ""
Write-Host "Forms distintos que o predicado libera:"
$passam|Sort-Object -Unique|ForEach-Object{Write-Host "  - $_"}
