# =============================================================================
# VerificarGateFase8Task615.ps1
#
# Avalia os predicados do gate da Fase 8 (case 8 de Invoke-MigracaoFase) contra
# os arquivos REAIS da task615 (SIGPRGLO -> FormSigPrGlo), SEM executar o
# OrquestradorMigracao.ps1. As funcoes sao extraidas do .ps1 via AST
# (ParseFile + FindAll FunctionDefinitionAst) e redefinidas nesta sessao.
#
# POR QUE AST E NAO DOT-SOURCE: dot-source do OrquestradorMigracao.ps1 executa
# o corpo do script e DISPARA UMA MIGRACAO REAL.
#
# Foco: o ramo FILTRO-DESPACHO (8o), que eh o aplicavel a este legado - tela de
# filtro que consulta para cursor local e despacha o resultado ao FormSigPrGl2
# via "Do Form SigPrGl2 With ...".
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File VerificarGateFase8Task615.ps1
# =============================================================================
param(
    [string]$Orquestrador = "C:\4c\automation\OrquestradorMigracao.ps1",
    [string]$DumpLegado   = "C:\4c\tasks\task615\SigPrGlo_form_codigo_fonte.txt",
    [string]$FormMigrado  = "C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg"
)

$ErrorActionPreference = "Stop"

$errs = $null; $toks = $null
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$toks, [ref]$errs)
if ($errs.Count -gt 0) {
    Write-Host "ERRO: $Orquestrador nao parseia ($($errs.Count) erros)" -ForegroundColor Red
    exit 1
}

$queremos = @(
    "Test-LegadoDialogoExibicao",
    "Test-LegadoSomenteLeitura",
    "Test-LegadoControlSourceLigaLista",
    "Test-LegadoAddCursorLigaGrade",
    "Test-LegadoEscritaSoEmCursorLocal",
    "Test-LegadoCliqueSoFecha",
    "Get-ContagemBotoesLegado",
    "Test-CompletudeCodigo"
)

$funcs = $ast.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)
$definidas = @()
foreach ($nome in $queremos) {
    $f = $funcs | Where-Object { $_.Name -eq $nome } | Select-Object -First 1
    if ($null -eq $f) {
        Write-Host "  [!] funcao nao encontrada no AST: $nome" -ForegroundColor Yellow
        continue
    }
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

Write-Host "=== LADO LEGADO (dump do SCX) ===" -ForegroundColor White

$temListaLegadoF8 = ($txt -match "(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$") -or
                    ($txt -match "(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)")
Mostrar "temListaLegadoF8 (LARGO)" $temListaLegadoF8

$temCamposLegadoF8 = ($txt -match "(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$")
Mostrar "temCamposLegadoF8" $temCamposLegadoF8

$padroesCrudLegadoF8 = @("frmcadastro", "Grupo_Op",
                         "(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)",
                         "(Incluir|Alterar|Visualizar|Excluir)\.Click")
$semCrudLegadoF8 = -not ($padroesCrudLegadoF8 | Where-Object { $txt -match $_ })
Mostrar "semCrudLegadoF8" $semCrudLegadoF8

$padroesSalvarLegado = @("btnSalvar", "btnGravar",
                         "PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click", "mGravaDados")
$legadoSemSalvar = -not ($padroesSalvarLegado | Where-Object { $txt -match $_ })
Mostrar "legadoSemSalvar" $legadoSemSalvar

$temDoFormF8 = $txt -match "(?im)^\s*Do\s+Form\s+\w+"
Mostrar "temDoFormF8" $temDoFormF8

Mostrar "Test-LegadoAddCursorLigaGrade"     (Test-LegadoAddCursorLigaGrade     -TextoDump $txt)
Mostrar "Test-LegadoControlSourceLigaLista" (Test-LegadoControlSourceLigaLista -TextoDump $txt)
Mostrar "Test-LegadoEscritaSoEmCursorLocal" (Test-LegadoEscritaSoEmCursorLocal -TextoDump $txt)
Mostrar "Test-LegadoDialogoExibicao"        (Test-LegadoDialogoExibicao        -TextoDump $txt)
Mostrar "Test-LegadoSomenteLeitura"         (Test-LegadoSomenteLeitura         -TextoDump $txt)
Mostrar "Get-ContagemBotoesLegado"          (Get-ContagemBotoesLegado          -TextoDump $txt)

$semGradeEstreito = -not (($txt -match "(?im)^\s*BaseClass:\s*(grid|pageframe|listbox)\s*$") -or
                          ($txt -match "(?i)(pColuna|\bGrade\b|\bgrd)") -or
                          (Test-LegadoAddCursorLigaGrade     -TextoDump $txt) -or
                          (Test-LegadoControlSourceLigaLista -TextoDump $txt))
Mostrar "semGrade (ESTREITO)" $semGradeEstreito

$temDllExternaF8 = $txt -match "(?im)^\s*DECLARE\s+.*\bIN\s+""[^""]+\.(DLL|OCX|EXE)"""
Mostrar "temDllExternaF8" $temDllExternaF8

Write-Host ""
Write-Host "=== LADO MIGRADO (.prg) ===" -ForegroundColor White

$temFormParaBO = $conteudo -match "(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b"
$temBOParaForm = $conteudo -match "(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b"
$temBtnClick   = $conteudo -match "(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn\w*Click\b"
Mostrar "FormParaBO (ANCORADO)" $temFormParaBO
Mostrar "BOParaForm (ANCORADO)" $temBOParaForm
Mostrar "Btn*Click  (ANCORADO)" $temBtnClick
$temSuperficieFiltroF8 = $temFormParaBO -and $temBOParaForm -and $temBtnClick
Mostrar "temSuperficieFiltroF8" $temSuperficieFiltroF8
Mostrar "tem PROCEDURE Carregar* (fluxo-unico)" ($conteudo -match "PROCEDURE\s+Carregar\w*")
Mostrar "tem .ReadOnly = .T. (visualizador)"    ($conteudo -match "(?im)^\s*\.ReadOnly\s*=\s*\.T\.")

Write-Host ""
Write-Host "=== NOMES EXIGIDOS PELA FASE 8 ===" -ForegroundColor White
$metodosFinals = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
foreach ($m in $metodosFinals) { Mostrar $m ($conteudo -match $m) }
$padraoAcaoGravar = "PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click"
$acaoOk = $conteudo -match $padraoAcaoGravar
Mostrar "padraoAcaoGravar" $acaoOk

Write-Host ""
Write-Host "=== RAMOS DE EXCECAO (cadeia de exclusao) ===" -ForegroundColor White
$desp = ((-not $temListaLegadoF8) -and (-not $temCamposLegadoF8))
Mostrar "legadoDespachanteF8 (parcial)" $desp
$exib = ((-not $temListaLegadoF8) -and $semCrudLegadoF8 -and (Test-LegadoDialogoExibicao -TextoDump $txt))
Mostrar "legadoExibicaoF8 (parcial)" $exib
$visu = ($semCrudLegadoF8 -and $legadoSemSalvar -and (Test-LegadoSomenteLeitura -TextoDump $txt) -and
         ($conteudo -match "(?im)^\s*\.ReadOnly\s*=\s*\.T\."))
Mostrar "legadoVisualizadorF8 (parcial)" $visu
$fluxo = ($temListaLegadoF8 -and $temCamposLegadoF8 -and ($conteudo -match "PROCEDURE\s+Carregar\w*"))
Mostrar "legadoFluxoUnicoF8 (parcial)" $fluxo
$calc = ((-not $temListaLegadoF8) -and $temCamposLegadoF8 -and ((Get-ContagemBotoesLegado -TextoDump $txt) -eq 1))
Mostrar "legadoCalculadoraF8 (parcial)" $calc
$prot = ($semGradeEstreito -and $temCamposLegadoF8 -and $temDllExternaF8)
Mostrar "legadoProtocoloF8 (parcial)" $prot

$filtro = ((-not $desp) -and (-not $exib) -and (-not $visu) -and (-not $fluxo) -and
           (-not $calc) -and (-not $prot) -and
           $semCrudLegadoF8 -and $semGradeEstreito -and $temCamposLegadoF8 -and
           $legadoSemSalvar -and $temDoFormF8 -and
           (Test-LegadoEscritaSoEmCursorLocal -TextoDump $txt) -and $temSuperficieFiltroF8)
Mostrar "legadoFiltroDespachoF8" $filtro

Write-Host ""
Write-Host "=== RESULTADO ===" -ForegroundColor White
$faltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
Mostrar "metodosFaltantes (antes da dispensa)" ($faltantes -join ", ")
if ($filtro) {
    $dispensa = @("BtnCancelarClick", "CarregarLista")
    $faltantes = @($faltantes | Where-Object { $dispensa -notcontains $_ })
    Mostrar "metodosFaltantes (pos filtro-despacho)" ($faltantes -join ", ")
}

$completudeOk = $true
if (Get-Command Test-CompletudeCodigo -ErrorAction SilentlyContinue) {
    $completudeOk = (Test-CompletudeCodigo -FilePath $FormMigrado -Descricao "Form (Fase 8)")
}
Mostrar "Test-CompletudeCodigo (Form)" $completudeOk

Write-Host ""
if ($faltantes.Count -eq 0 -and $acaoOk) {
    Write-Host "RESULTADO: Fase 8 PASSA (ramo filtro-despacho + padraoAcaoGravar satisfeito)" -ForegroundColor Green
    exit 0
} else {
    Write-Host "RESULTADO: Fase 8 REPROVA. Faltantes: $($faltantes -join ", ") | acaoOk=$acaoOk" -ForegroundColor Red
    exit 1
}