# =============================================================================
# VerificarGateFase8Task613.ps1
#
# Avalia os predicados do gate da Fase 8 contra os arquivos REAIS de uma task,
# SEM executar o OrquestradorMigracao.ps1. As funcoes sao extraidas do .ps1 via
# AST (ParseFile + FindAll FunctionDefinitionAst) e redefinidas nesta sessao.
#
# POR QUE AST E NAO DOT-SOURCE: dot-source do OrquestradorMigracao.ps1 executa
# o corpo do script e DISPARA UMA MIGRACAO REAL. Extrair so as definicoes de
# funcao eh a unica forma segura de testar os predicados.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File VerificarGateFase8Task613.ps1 `
#       -DumpLegado <repo>\tasks\task613\SigPrGf2_form_codigo_fonte.txt `
#       -FormMigrado <repo>\projeto\app\forms\operacionais\FormSigPrGf2.prg
# =============================================================================
param(
    [string]$Orquestrador = "$(Split-Path -Parent $PSScriptRoot)\automation\OrquestradorMigracao.ps1",
    [Parameter(Mandatory = $true)][string]$DumpLegado,
    [Parameter(Mandatory = $true)][string]$FormMigrado
)

$ErrorActionPreference = "Stop"

# --- Extracao das funcoes via AST -------------------------------------------
$errs = $null; $toks = $null
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$toks, [ref]$errs)
if ($errs.Count -gt 0) {
    Write-Host "ERRO: $Orquestrador nao parseia ($($errs.Count) erros)" -ForegroundColor Red
    exit 1
}

$queremos = @(
    'Test-LegadoDialogoExibicao',
    'Test-LegadoSomenteLeitura',
    'Test-LegadoControlSourceLigaLista',
    'Test-LegadoAddCursorLigaGrade',
    'Test-LegadoCliqueSoFecha',
    'Get-ContagemBotoesLegado',
    'Test-AcaoDoLegadoTemHandler'
)

$funcs = $ast.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)
$definidas = @()
foreach ($nome in $queremos) {
    $f = $funcs | Where-Object { $_.Name -eq $nome } | Select-Object -First 1
    if ($null -eq $f) {
        Write-Host "  [!] funcao nao encontrada no AST: $nome" -ForegroundColor Yellow
        continue
    }
    # Define a funcao nesta sessao a partir do texto exato dela.
    . ([scriptblock]::Create($f.Extent.Text))
    $definidas += $nome
}
Write-Host "Funcoes extraidas via AST: $($definidas.Count)/$($queremos.Count)" -ForegroundColor Cyan
Write-Host ""

$txt      = Get-Content $DumpLegado  -Raw
$conteudo = Get-Content $FormMigrado -Raw

function Mostrar {
    param([string]$Rotulo, $Valor)
    $cor = if ($Valor -eq $true) { "Green" } elseif ($Valor -eq $false) { "Yellow" } else { "DarkGray" }
    Write-Host ("  {0,-42} = {1}" -f $Rotulo, $Valor) -ForegroundColor $cor
}

# --- Predicados do lado do LEGADO (dump) ------------------------------------
Write-Host "=== LADO LEGADO (dump do SCX) ===" -ForegroundColor White

$temListaLegadoF8 = ($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                    ($txt -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
Mostrar 'temListaLegadoF8 (LARGO)' $temListaLegadoF8

$temCamposLegadoF8 = ($txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
Mostrar 'temCamposLegadoF8' $temCamposLegadoF8

$padroesCrudLegadoF8 = @('frmcadastro', 'Grupo_Op',
                         '(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)',
                         '(Incluir|Alterar|Visualizar|Excluir)\.Click')
$semCrudLegadoF8 = -not ($padroesCrudLegadoF8 | Where-Object { $txt -match $_ })
Mostrar 'semCrudLegadoF8' $semCrudLegadoF8

# Lista EXATA do orquestrador (nome de OBJETO/metodo de gravacao no legado).
$padroesSalvarLegado = @('btnSalvar', 'btnGravar',
                         'PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click', 'mGravaDados')
$legadoSemSalvar = -not ($padroesSalvarLegado | Where-Object { $txt -match $_ })
Mostrar 'legadoSemSalvar' $legadoSemSalvar

Mostrar 'Test-LegadoDialogoExibicao' (Test-LegadoDialogoExibicao -TextoDump $txt)
Mostrar 'Test-LegadoSomenteLeitura'  (Test-LegadoSomenteLeitura  -TextoDump $txt)
Mostrar 'Test-LegadoControlSourceLigaLista' (Test-LegadoControlSourceLigaLista -TextoDump $txt)
Mostrar 'Test-LegadoAddCursorLigaGrade'     (Test-LegadoAddCursorLigaGrade     -TextoDump $txt)
Mostrar 'Test-LegadoCliqueSoFecha'    (Test-LegadoCliqueSoFecha    -TextoDump $txt)
Mostrar 'Get-ContagemBotoesLegado'    (Get-ContagemBotoesLegado    -TextoDump $txt)

# Predicado ESTREITO de grade (padrao dos ramos PROTOCOLO/FILTRO-DESPACHO):
# nao consome o $temListaLegadoF8 largo, que casa "ControlSource" de qualquer
# controle de valor unico (neste dump, o do OleBoundControl do grafico).
$semGradeEstreito = -not (($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe|listbox)\s*$') -or
                          ($txt -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                          (Test-LegadoAddCursorLigaGrade     -TextoDump $txt) -or
                          (Test-LegadoControlSourceLigaLista -TextoDump $txt))
Mostrar 'semGrade (ESTREITO)' $semGradeEstreito

$temOleLegado = $txt -match '(?im)^\s*BaseClass:\s*oleboundcontrol\s*$'
Mostrar 'temOleBoundControl no legado' $temOleLegado

# --- Predicados do lado do MIGRADO ------------------------------------------
Write-Host ""
Write-Host "=== LADO MIGRADO (.prg) ===" -ForegroundColor White

$temBarraBotoesF8 = ($conteudo -match 'AddObject\(\s*"(cmg_4c_|cmd_4c_)') -or
                    ($conteudo -match 'AddObject\(\s*"obj_4c_[^"]*"\s*,\s*"Command(Group|Button)"')
Mostrar 'temBarraBotoes (cmg_/cmd_/obj_+Command)' $temBarraBotoesF8
Mostrar 'tem PROCEDURE (Cmd|Btn)*Click' ($conteudo -match 'PROCEDURE\s+(Cmd|Btn)\w*Click')
Mostrar 'temSuperficieDespachanteF8' ($temBarraBotoesF8 -and ($conteudo -match 'PROCEDURE\s+(Cmd|Btn)\w*Click'))
Mostrar 'reproduz campo de entrada' ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"(EditBox|TextBox|ComboBox|ListBox|CheckBox|Spinner|OptionGroup)"')
Mostrar 'reproduz OleBoundControl'  ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"OleBoundControl"')
Mostrar 'tem .ReadOnly = .T.'       ($conteudo -match '(?im)^\s*\.ReadOnly\s*=\s*\.T\.')

Write-Host ""
Write-Host "=== NOMES EXIGIDOS PELA FASE 8 ===" -ForegroundColor White
$metodosFinals = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
foreach ($m in $metodosFinals) { Mostrar $m ($conteudo -match $m) }
$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'
Mostrar 'padraoAcaoGravar' ($conteudo -match $padraoAcaoGravar)

Write-Host ""
Write-Host "=== RAMOS DE EXCECAO ===" -ForegroundColor White
$temSup = $temBarraBotoesF8 -and ($conteudo -match 'PROCEDURE\s+(Cmd|Btn)\w*Click')
$exib = ((-not $temListaLegadoF8) -and $semCrudLegadoF8 -and
         (Test-LegadoDialogoExibicao -TextoDump $txt) -and $temSup -and
         ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"(EditBox|TextBox|ComboBox|ListBox|CheckBox|Spinner|OptionGroup)"'))
Mostrar 'legadoExibicaoF8' $exib

$visu = ($semCrudLegadoF8 -and $legadoSemSalvar -and
         (Test-LegadoSomenteLeitura -TextoDump $txt) -and $temSup -and
         ($conteudo -match '(?im)^\s*\.ReadOnly\s*=\s*\.T\.'))
Mostrar 'legadoVisualizadorF8' $visu

# Ramo GRAFICO exatamente como implementado no orquestrador.
$temSuperficieGrafF8 = ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"OleBoundControl"') -and
                       ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"(ComboBox|ListBox)"') -and
                       ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+(Cmd|Btn)\w*Click\b')
Mostrar 'temSuperficieGrafF8' $temSuperficieGrafF8

$graf = ((-not $exib) -and (-not $visu) -and
         $semCrudLegadoF8 -and $legadoSemSalvar -and
         $semGradeEstreito -and $temOleLegado -and
         (Test-LegadoSomenteLeitura -TextoDump $txt) -and $temSuperficieGrafF8)
Mostrar 'legadoGraficoF8' $graf

Write-Host ""
Write-Host "=== EXIGENCIA DE BOTAO DE ACAO ===" -ForegroundColor White
$acaoComHandler = $null
if (Get-Command Test-AcaoDoLegadoTemHandler -ErrorAction SilentlyContinue) {
    $acaoComHandler = Test-AcaoDoLegadoTemHandler -TextoDump $txt -ConteudoForm $conteudo
}
Mostrar 'Test-AcaoDoLegadoTemHandler' $acaoComHandler
$acaoOk = ($conteudo -match $padraoAcaoGravar) -or $graf -or ($acaoComHandler -eq $true)
Mostrar 'exigencia de acao satisfeita' $acaoOk

Write-Host ""
$faltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
if ($graf) { $faltantes = @() }
if ($faltantes.Count -eq 0 -and $acaoOk) {
    Write-Host "RESULTADO: Fase 8 PASSA (ramo de excecao aplicavel + acao satisfeita)" -ForegroundColor Green
    exit 0
} else {
    Write-Host "RESULTADO: Fase 8 REPROVA. Faltantes: $($faltantes -join ', ') | acaoOk=$acaoOk" -ForegroundColor Red
    exit 1
}
