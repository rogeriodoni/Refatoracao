# MedirRamoRetornoAoPaiF8.ps1
#
# Mede a largura do ramo RETORNO-AO-PAI da Fase 8 nos dumps de tasks\:
#   coluna A = quantos dumps passam as 3 provas de Test-LegadoRetornoAoPai;
#   coluna B = quantos desses TAMBEM satisfazem o lado LEGADO do ramo
#              (sem CRUD, sem grade estrita, com campo editavel, sem botao de
#              gravar, sem persistencia em tabela, sem PageFrame, sem Do Form).
# AST-only: dot-source do orquestrador DISPARA migracao real.
$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}
$dumps = Get-ChildItem 'C:\4c\tasks' -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue
"dumps encontrados = $($dumps.Count)"
$passaHelper = @(); $passaLegado = @()
foreach ($d in $dumps) {
    $t = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $t) { continue }
    if (-not (Test-LegadoRetornoAoPai -TextoDump $t)) { continue }
    $passaHelper += $d.FullName

    $semCrud = -not (@('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click') | Where-Object { $t -match $_ })
    $semSalvar = -not (@('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados') | Where-Object { $t -match $_ })
    $semGrade = -not (($t -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                      (Test-LegadoListBoxLigaLista -TextoDump $t) -or
                      ($t -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                      (Test-LegadoAddCursorLigaGrade -TextoDump $t) -or
                      (Test-LegadoControlSourceLigaLista -TextoDump $t))
    $temCampos = $t -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$'
    $editavel  = -not (Test-LegadoSomenteLeitura -TextoDump $t)
    $soCursor  = Test-LegadoEscritaSoEmCursorLocal -TextoDump $t
    $semPgf    = -not ($t -match '(?im)^\s*BaseClass:\s*pageframe\s*$')
    $semDoForm = -not ($t -match '(?im)^\s*Do\s+Form\s+\w+')
    if ($semCrud -and $semSalvar -and $semGrade -and $temCampos -and $editavel -and $soCursor -and $semPgf -and $semDoForm) {
        $passaLegado += $d.FullName
    }
}
"`n(A) passam as 3 provas do helper = $($passaHelper.Count)"
$passaHelper | ForEach-Object { "    " + $_ }
"`n(B) passam o lado LEGADO inteiro = $($passaLegado.Count)"
$passaLegado | ForEach-Object { "    " + $_ }
"`n(B) forms distintos:"
$passaLegado | ForEach-Object { [regex]::Match((Split-Path $_ -Leaf), '^(.*)_form_codigo_fonte\.txt$').Groups[1].Value } |
    Sort-Object -Unique | ForEach-Object { "    " + $_ }
