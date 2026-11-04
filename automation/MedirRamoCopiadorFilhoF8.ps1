# MedirRamoCopiadorFilhoF8.ps1
#
# Sweep de largura do 14o ramo da Fase 8 (COPIADOR-FILHO, Erro/task706).
#
# Mede, em TODOS os dumps de tasks\, quantos passam:
#   (a) as TRES provas de Test-LegadoCopiadorFilho isoladas;
#   (b) o predicado $legadoCopiadorFilhoF8 INTEIRO (lado legado), que e o que
#       de fato concede a dispensa.
#
# A regra de CLAUDE.md #48 exige a varredura RETROATIVA ao adicionar check novo:
# aqui o risco e o OPOSTO (o ramo DISPENSA, nao reprova), entao o que se prova
# e a LARGURA - quantos forms passam a ter os dois nomes dispensados - e que
# nenhum deles e form que hoje passa pelo caminho normal.
#
# AST-only: dot-source do orquestrador DISPARA uma migracao real
# (feedback_dot_source_orquestrador_dispara_migracao).

[CmdletBinding()]
param(
    [string]$TasksDir  = 'C:\4c\tasks',
    [string]$FormsRoot = 'C:\4c\projeto\app\forms'
)

$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$erros = $null
[System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$erros) | Out-Null
if ($erros -and $erros.Count -gt 0) {
    "SINTAXE=FALHA ({0} erro(s))" -f $erros.Count
    exit 1
}
$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$prgs = @{}
foreach ($p in (Get-ChildItem -Path $FormsRoot -Recurse -Filter '*.prg' -ErrorAction SilentlyContinue)) {
    if ($p.Name -like '*.bak') { continue }
    $k = [IO.Path]::GetFileNameWithoutExtension($p.Name).ToUpper()
    if (-not $prgs.ContainsKey($k)) { $prgs[$k] = $p.FullName }
}

$dumps = @(Get-ChildItem -Path $TasksDir -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue)
"dumps encontrados = {0}" -f $dumps.Count

$soHelper = New-Object System.Collections.Generic.List[string]
$predInteiro = New-Object System.Collections.Generic.List[string]

foreach ($d in $dumps) {
    $txt = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($txt)) { continue }

    if (-not (Test-LegadoCopiadorFilho -TextoDump $txt)) { continue }

    $base = $d.Name -replace '_form_codigo_fonte\.txt$', ''
    $soHelper.Add(('{0} [{1}]' -f $base, (Split-Path -Leaf $d.DirectoryName)))

    # ---- lado LEGADO do predicado inteiro (sem o lado do migrado) ----------
    $temCampos = ($txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
    $semCrud   = -not (@('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click') | Where-Object { $txt -match $_ })
    $semSalvar = -not (@('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados') | Where-Object { $txt -match $_ })
    $semGrade  = -not (($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                       (Test-LegadoListBoxLigaLista -TextoDump $txt) -or
                       ($txt -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                       (Test-LegadoAddCursorLigaGrade     -TextoDump $txt) -or
                       (Test-LegadoControlSourceLigaLista -TextoDump $txt))
    $soLeitura = Test-LegadoSomenteLeitura -TextoDump $txt
    $semDoForm = -not ($txt -match '(?im)^\s*Do\s+Form\s+\w+')
    $semPgf    = -not ($txt -match '(?im)^\s*BaseClass:\s*pageframe\s*$')
    $retornoAoPai = Test-LegadoRetornoAoPai -TextoDump $txt
    $escritaLocal = Test-LegadoEscritaSoEmCursorLocal -TextoDump $txt

    $okLegado = $temCampos -and $semCrud -and $semSalvar -and $semGrade -and
                (-not $soLeitura) -and $semDoForm -and $semPgf -and
                (-not ($retornoAoPai -and $escritaLocal))

    if (-not $okLegado) { continue }

    $predInteiro.Add(('{0} [{1}]' -f $base, (Split-Path -Leaf $d.DirectoryName)))
}

""
"--- (a) passam SO as 3 provas do helper: {0} dump(s) ---" -f $soHelper.Count
$soHelper | Sort-Object -Unique | ForEach-Object { "    $_" }
""
"--- (b) passam o predicado INTEIRO (lado legado): {0} dump(s) ---" -f $predInteiro.Count
$predInteiro | Sort-Object -Unique | ForEach-Object { "    $_" }
""
$distintos = @($predInteiro | ForEach-Object { ($_ -split ' \[')[0].ToUpper() } | Sort-Object -Unique)
"forms DISTINTOS alcancados = {0}" -f $distintos.Count
$distintos | ForEach-Object { "    $_" }
