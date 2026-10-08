#
# Delta do ramo novo "dialogo-entrada" da Fase 8 (SIGPRIFF -> FormSIGPRIFF,
# task626). Mede, em TODOS os dumps de tasks\, quantos passam na metade
# LEGADO da prova FAIL-CLOSED:
#   dump presente + Test-LegadoSemBotaoAlgum + sem lista + COM campo +
#   sem CRUD + sem botao de gravar
# A metade MIGRADO ($temSuperficieEntradaF8) nao entra aqui: ela so pode
# APERTAR o resultado, nunca alargar.
#
. "C:\4c\tasks\task626\_helpers_gate.ps1"

$dumps = Get-ChildItem 'C:\4c\tasks' -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue
$lib = New-Object System.Collections.Generic.List[object]
$ref = @('SIGCDCOR','sigcdcli','SigCdPro','SIGCDCAR','SigCdMoe','SIGCDSET','SigCdTam',
         'SigPrCtr','SIGPRETQ','SIGMVCTH','SIGPRGST','SIGCDGPD','SigCdGrp','SIGCDACG',
         'SIGMVEXP','SIGPDMEN','SIGPRCAR','SIGPRDFT','SIGPRES1','SIGPRGMI','SIGPREST',
         'SIGPRICO','SIGPRALE')
$refHits = New-Object System.Collections.Generic.List[string]

foreach ($d in $dumps) {
    $t = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $t) { continue }

    $temLista = ($t -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                ($t -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
    $temCampos = ($t -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
    $padroesCrud = @('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click')
    $semCrud = -not ($padroesCrud | Where-Object { $t -match $_ })
    $padroesSalvar = @('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados')
    $semSalvar = -not ($padroesSalvar | Where-Object { $t -match $_ })
    $semBotao = Test-LegadoSemBotaoAlgum -TextoDump $t

    $hit = ($semBotao -and (-not $temLista) -and $temCampos -and $semCrud -and $semSalvar)

    $base = $d.Name -replace '_form_codigo_fonte\.txt$',''
    if ($hit) {
        $lib.Add([pscustomobject]@{ Task = $d.Directory.Name; Base = $base })
        if ($ref -contains $base) { $refHits.Add("$($d.Directory.Name)/$base") }
    }
}

Write-Host "dumps varridos         : $($dumps.Count)"
Write-Host "dumps liberados (metade legado): $($lib.Count)"
Write-Host "forms legado DISTINTOS : $(($lib.Base | Sort-Object -Unique).Count)"
Write-Host ""
Write-Host "--- forms distintos liberados ---"
$lib | Group-Object Base | Sort-Object Name | ForEach-Object {
    Write-Host ("  {0,-16} tasks: {1}" -f $_.Name, (($_.Group.Task | Sort-Object -Unique) -join ', '))
}
Write-Host ""
if ($refHits.Count -gt 0) {
    Write-Host "!! REGRESSAO em form de referencia: $($refHits -join ', ')" -ForegroundColor Red
} else {
    Write-Host "OK - nenhum form de referencia (CRUD/grade/botao) liberado pelo ramo novo" -ForegroundColor Green
}
