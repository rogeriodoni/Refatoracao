# Mede o DELTA do 9o ramo da Fase 8 (UTILITARIO-ARQUIVO) sobre TODOS os dumps.
#
# ATENCAO: NAO dot-source o OrquestradorMigracao.ps1. Ele tem corpo principal e
# dot-source DISPARA UMA MIGRACAO DE VERDADE (cria tasks\taskNNN, move o .SCX de
# origem\ e sobrescreve o BO). Aqui so as DEFINICOES DE FUNCAO sao extraidas via
# AST e avaliadas - nenhuma instrucao de nivel superior roda.
#
# Aplica a CADEIA DE EXCLUSAO INTEIRA e filtra por "o .prg HOJE falha a
# exigencia" - sem isso a contagem infla e a sobreposicao com ramo existente
# passa despercebida.

$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
$funcs = $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)
foreach ($f in $funcs) { . ([scriptblock]::Create($f.Extent.Text)) }
"funcoes carregadas (sem executar o corpo do script): $($funcs.Count)"

$tasksDir  = 'C:\4c\tasks'
$projeto   = 'C:\4c\projeto'
$casamDump = @()
$deltaReal = @()

$dumps = @(Get-ChildItem -Path $tasksDir -Filter '*_form_codigo_fonte.txt' -Recurse -ErrorAction SilentlyContinue)

foreach ($d in $dumps) {
    $txt = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $txt) { continue }
    $baseName = $d.BaseName -replace '_form_codigo_fonte$',''

    # --- predicados do case 8 (copia fiel) ---
    $temListaLegadoF8 = ($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                        ($txt -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
    $temCamposLegadoF8 = ($txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
    $padroesCrud = @('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click')
    $semCrudLegadoF8 = -not ($padroesCrud | Where-Object { $txt -match $_ })
    if ($semCrudLegadoF8) {
        $nTot = ([regex]::Matches($txt,'(?i)pcEscolha')).Count
        $nPai = ([regex]::Matches($txt,'(?i)(ParentForm|pForm|oForm|oFormulario|par_oForm)\s*\.\s*pcEscolha')).Count
        if (($nTot - $nPai) -gt 0) {
            if (-not (Test-ModoRecebidoDoChamador -TextoDump $txt)) { $semCrudLegadoF8 = $false }
        }
    }
    $padroesSalvar = @('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados')
    $legadoSemSalvar = -not ($padroesSalvar | Where-Object { $txt -match $_ })

    # prova ESTRITA de "sem grade" (a mesma do ramo PROTOCOLO)
    $semGradeEstrita = -not (($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe|listbox)\s*$') -or
                             (Test-LegadoAddCursorLigaGrade -TextoDump $txt) -or
                             (Test-LegadoControlSourceLigaLista -TextoDump $txt))

    # --- predicado do ramo NOVO (lado-dump) ---
    $soOpcao = ($txt -match '(?im)^\s*BaseClass:\s*(checkbox|optiongroup|optionbutton)\s*$') -and
               (-not ($txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|spinner)\s*$'))
    $criaTabelaLocal = $txt -match '(?i)\bCreate\s+Table\s+[A-Za-z_]\w*\s+Free\b'
    $varreDiretorio  = ($txt -match '(?i)\bADir\s*\(') -and ($txt -match '(?i)\bSet\s+Default\s+To\b')
    $escritaSoLocal  = Test-LegadoEscritaSoEmTabelaLocalFree -TextoDump $txt

    $ladoDump = $semCrudLegadoF8 -and $semGradeEstrita -and $soOpcao -and
                $legadoSemSalvar -and $criaTabelaLocal -and $varreDiretorio -and $escritaSoLocal
    if (-not $ladoDump) { continue }

    # --- cadeia de exclusao: os 8 ramos anteriores ---
    $exibicao     = (-not $temListaLegadoF8) -and $semCrudLegadoF8 -and (Test-LegadoDialogoExibicao -TextoDump $txt)
    $visualizador = $semCrudLegadoF8 -and $legadoSemSalvar -and (Test-LegadoSomenteLeitura -TextoDump $txt)
    $despachante  = (-not $temListaLegadoF8) -and (-not $temCamposLegadoF8) -and $semCrudLegadoF8
    $fluxoUnico   = $semCrudLegadoF8 -and $temListaLegadoF8 -and $temCamposLegadoF8
    $protocolo    = $txt -match '(?im)^\s*DECLARE\b.*\bIN\s+["'']?[\w\.\\]+\.(DLL|OCX|EXE)'
    $filtro       = $txt -match '(?im)^\s*Do\s+Form\s+\w+'
    $cliqueSoFecha = Test-LegadoCliqueSoFecha -TextoDump $txt
    $nBotoes       = Get-ContagemBotoesLegado -TextoDump $txt
    $calculadora  = ($cliqueSoFecha -eq $true) -and ($nBotoes -eq 1)

    $coberto = $despachante -or $exibicao -or $visualizador -or $fluxoUnico -or
               $protocolo -or $filtro -or $calculadora

    # --- lado .prg ---
    $formClass = Get-FormClassName -BaseName $baseName
    $formFile  = Find-FormFile -ProjetoPath $projeto -FormClass $formClass -PreferredSubDir 'operacionais'
    $prgFalha      = $null
    $temSuperficie = $null
    if ($formFile -and (Test-Path $formFile)) {
        $c = Get-Content $formFile -Raw
        $faltam = @(@("BtnCancelarClick","CarregarLista") | Where-Object { $c -notmatch $_ })
        $prgFalha = ($faltam.Count -gt 0)
        $temSuperficie = ($c -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                         ($c -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b') -and
                         ($c -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn\w*Click\b')
    }

    $row = [pscustomobject]@{
        Task       = Split-Path (Split-Path $d.FullName -Parent) -Leaf
        Base       = $baseName
        FormClass  = $formClass
        Coberto    = $coberto
        Superficie = $temSuperficie
        PrgFalha   = $prgFalha
    }
    $casamDump += $row
    if ((-not $coberto) -and ($temSuperficie -eq $true) -and ($prgFalha -eq $true)) { $deltaReal += $row }
}

""
"dumps varridos                   : $($dumps.Count)"
"A) casam o predicado (lado-dump) : $($casamDump.Count)"
$casamDump | Format-Table -AutoSize | Out-String -Width 200
"B) DELTA REAL (muda o veredicto) : $($deltaReal.Count)"
"C) forms DISTINTOS afetados      : $(@($deltaReal | Select-Object -ExpandProperty FormClass -Unique).Count)"
$deltaReal | Select-Object Task,Base,FormClass | Format-Table -AutoSize | Out-String -Width 200
