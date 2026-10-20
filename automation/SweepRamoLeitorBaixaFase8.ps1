# Mede quantos forms o ramo LEITOR-BAIXA alcanca em TODO o acervo de tasks\,
# e em quantos deles ele de fato ATUA (predicado verdadeiro E o .prg gerado
# realmente sem o nome de carga da lista). AST-only: nao executa o orquestrador.
$src   = 'C:\4c\automation\OrquestradorMigracao.ps1'
$ast   = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
$funcs = $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)
foreach ($f in $funcs) { . ([scriptblock]::Create($f.Extent.Text)) }

$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'
$formDirs = @('C:\4c\projeto\app\forms\operacionais','C:\4c\projeto\app\forms\cadastros','C:\4c\projeto\app\forms\relatorios','C:\4c\projeto\app\forms')

$alcance = @(); $atua = @()

foreach ($dump in Get-ChildItem 'C:\4c\tasks' -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue) {
    $txt = Get-Content $dump.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $txt) { continue }

    $semCrud   = -not (@('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click') | Where-Object { $txt -match $_ })
    if (-not $semCrud) { continue }
    $semSalvar = -not (@('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados') | Where-Object { $txt -match $_ })
    if (-not $semSalvar) { continue }
    $temCampos = ($txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
    if (-not $temCampos) { continue }
    $semGrade = -not (($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                      (Test-LegadoListBoxLigaLista -TextoDump $txt) -or
                      ($txt -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                      (Test-LegadoAddCursorLigaGrade -TextoDump $txt) -or
                      (Test-LegadoControlSourceLigaLista -TextoDump $txt))
    if (-not $semGrade) { continue }
    if (Test-LegadoSomenteLeitura -TextoDump $txt) { continue }
    if (Test-LegadoEscritaSoEmCursorLocal -TextoDump $txt) { continue }

    $base = $dump.Name -replace '_form_codigo_fonte\.txt$',''
    $prg  = $null
    foreach ($d in $formDirs) {
        $c = Get-ChildItem $d -Filter "*$base*.prg" -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($c) { $prg = $c.FullName; break }
    }
    if (-not $prg) {
        $c = Get-ChildItem 'C:\4c\projeto\app\forms' -Recurse -Filter "*$base*.prg" -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($c) { $prg = $c.FullName }
    }
    if (-not $prg) { $alcance += "$base (sem .prg localizado)"; continue }

    $conteudo = Get-Content $prg -Raw -ErrorAction SilentlyContinue
    if (-not $conteudo) { continue }

    $temSuperficie = ($conteudo -match $padraoAcaoGravar) -and
                     ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                     ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b')
    if (-not $temSuperficie) { $alcance += "$base (predicado do legado OK, superficie do migrado NAO - ramo nao dispensa)"; continue }

    $alcance += "$base -> $(Split-Path $prg -Leaf)"
    if ($conteudo -notmatch 'CarregarLista') { $atua += "$base -> $(Split-Path $prg -Leaf)" }
}

"=== ALCANCE (predicado do legado + 6a prova avaliada): $($alcance.Count) ==="
$alcance | Sort-Object | ForEach-Object { "  $_" }
""
"=== ATUA DE FATO (dispensa CarregarLista ausente do .prg): $($atua.Count) ==="
$atua | Sort-Object | ForEach-Object { "  $_" }
