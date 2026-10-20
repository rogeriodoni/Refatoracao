# MedirRamoEntradaSemBotaoF8.ps1
#
# Mede o ALCANCE do ramo ENTRADA-SEM-BOTAO da Fase 8 em TODOS os dumps de
# tasks\, para provar que ele DISCRIMINA e nao eh escape geral.
#
# Mede so o lado LEGADO do predicado (as provas que vem do dump). A exigencia
# de superficie no MIGRADO ($temSuperficieEntradaF8) so ESTREITA mais, entao
# este numero eh o teto do alcance.
#
# AST-only de proposito: dot-source do orquestrador DISPARA migracao real.

$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$dumps = Get-ChildItem 'C:\4c\tasks' -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue
"dumps analisados = $($dumps.Count)"

$liberados = New-Object System.Collections.Generic.List[object]
$semBotaoAlgum = 0

foreach ($d in $dumps) {
    $txt = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($txt)) { continue }

    if (-not (Test-LegadoSemBotaoAlgum -TextoDump $txt)) { continue }
    $semBotaoAlgum++

    $semCrud = -not (@('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click' ) | Where-Object { $txt -match $_ })
    if (-not $semCrud) { continue }

    $semSalvar = -not (@('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados') | Where-Object { $txt -match $_ })
    if (-not $semSalvar) { continue }

    $temCampos = ($txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
    if (-not $temCampos) { continue }

    $semGrade = -not (($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                      (Test-LegadoListBoxLigaLista -TextoDump $txt) -or
                      ($txt -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                      (Test-LegadoAddCursorLigaGrade     -TextoDump $txt) -or
                      (Test-LegadoControlSourceLigaLista -TextoDump $txt))
    if (-not $semGrade) { continue }

    if (Test-LegadoSomenteLeitura -TextoDump $txt) { continue }

    $base = $d.Name -replace '_form_codigo_fonte\.txt$', ''
    $liberados.Add([pscustomobject]@{ Task = $d.Directory.Name; Base = $base })
}

""
"passam Test-LegadoSemBotaoAlgum (3 provas) = $semBotaoAlgum"
"LIBERADOS pelo lado LEGADO do ramo         = $($liberados.Count) dump(s)"
$distintos = $liberados | Select-Object -ExpandProperty Base -Unique
"forms legado DISTINTOS                     = $($distintos.Count)"
""
$liberados | Sort-Object Base, Task | Format-Table -AutoSize | Out-String -Width 200
