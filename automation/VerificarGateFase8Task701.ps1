# =============================================================================
# VerificarGateFase8Task701.ps1
#
# Avalia os predicados do gate da Fase 8 contra os arquivos REAIS da task701
# (SIGOPCIM -> Formsigopcim), SEM executar o OrquestradorMigracao.ps1. As
# funcoes sao extraidas do .ps1 via AST (ParseFile + FindAll
# FunctionDefinitionAst) e redefinidas nesta sessao.
#
# POR QUE AST E NAO DOT-SOURCE: dot-source do OrquestradorMigracao.ps1 executa
# o corpo do script e DISPARA UMA MIGRACAO REAL.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File automation\VerificarGateFase8Task701.ps1
# =============================================================================
param(
    [string]$Orquestrador = "C:\4c\automation\OrquestradorMigracao.ps1",
    [string]$DumpLegado   = "C:\4c\tasks\task701\sigopcim_form_codigo_fonte.txt",
    [string]$FormMigrado  = "C:\4c\projeto\app\forms\operacionais\Formsigopcim.prg"
)

$ErrorActionPreference = "Stop"

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
    'Test-AcaoDoLegadoTemHandler',
    'Test-BarraCrudEhDoFormPai',
    'Test-GrupoOpSemVerboCrud',
    'Test-LegadoEscritaSoEmCursorLocal',
    'Test-VerbosCrudSaoTodosDeLinhaDeGrade',
    'Test-ModoRecebidoDoChamador'
)
$funcs = $ast.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)
$definidas = @()
foreach ($nome in $queremos) {
    $f = $funcs | Where-Object { $_.Name -eq $nome } | Select-Object -First 1
    if ($null -eq $f) { Write-Host "  [!] nao encontrada no AST: $nome" -ForegroundColor Yellow; continue }
    . ([scriptblock]::Create($f.Extent.Text))
    $definidas += $nome
}
Write-Host "Funcoes extraidas via AST: $($definidas.Count)/$($queremos.Count)" -ForegroundColor Cyan
Write-Host ""

$txt      = Get-Content $DumpLegado  -Raw
$conteudo = Get-Content $FormMigrado -Raw

function Mostrar { param([string]$R, $V)
    $cor = if ($V -eq $true) { "Green" } elseif ($V -eq $false) { "Yellow" } else { "DarkGray" }
    Write-Host ("  {0,-46} = {1}" -f $R, $V) -ForegroundColor $cor
}

Write-Host "=== LADO LEGADO (dump) ===" -ForegroundColor White
$temListaLegadoF8 = ($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                    ($txt -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
Mostrar 'temListaLegadoF8' $temListaLegadoF8
$temCamposLegadoF8 = ($txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
Mostrar 'temCamposLegadoF8' $temCamposLegadoF8

$grupoOpEhDoPaiF8 = ($txt -notmatch 'frmcadastro') -and (Test-BarraCrudEhDoFormPai -TextoDump $txt)
$grupoOpNaoProvaCrudF8 = $grupoOpEhDoPaiF8 -or (($txt -notmatch 'frmcadastro') -and (Test-GrupoOpSemVerboCrud -TextoDump $txt))
$padroesCrudLegadoF8 = @('frmcadastro')
if (-not $grupoOpNaoProvaCrudF8) { $padroesCrudLegadoF8 += 'Grupo_Op' }
$padroesCrudLegadoF8 += '(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)'
$padroesCrudLegadoF8 += '(Incluir|Alterar|Visualizar|Excluir)\.Click'
$semCrudLegadoF8 = -not ($padroesCrudLegadoF8 | Where-Object { $txt -match $_ })
Mostrar 'semCrudLegadoF8' $semCrudLegadoF8

$padroesSalvarLegado = @('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados')
$legadoSemSalvar = -not ($padroesSalvarLegado | Where-Object { $txt -match $_ })
Mostrar 'legadoSemSalvar' $legadoSemSalvar

Mostrar 'Test-LegadoDialogoExibicao' (Test-LegadoDialogoExibicao -TextoDump $txt)
Mostrar 'Test-LegadoSomenteLeitura'  (Test-LegadoSomenteLeitura  -TextoDump $txt)
Mostrar 'Test-LegadoCliqueSoFecha'   (Test-LegadoCliqueSoFecha   -TextoDump $txt)
Mostrar 'Get-ContagemBotoesLegado'   (Get-ContagemBotoesLegado   -TextoDump $txt)

Write-Host ""
Write-Host "=== LADO MIGRADO ===" -ForegroundColor White
$temBarraBotoesF8 = ($conteudo -match 'AddObject\(\s*"(cmg_4c_|cmd_4c_)') -or
                    ($conteudo -match 'AddObject\(\s*"obj_4c_[^"]*"\s*,\s*"Command(Group|Button)"')
$temSup = $temBarraBotoesF8 -and ($conteudo -match 'PROCEDURE\s+(Cmd|Btn)\w*Click')
Mostrar 'temSuperficieDespachanteF8' $temSup
Mostrar 'tem PROCEDURE Carregar*'  ($conteudo -match 'PROCEDURE\s+Carregar\w*')
Mostrar 'tem .ReadOnly = .T.'      ($conteudo -match '(?im)^\s*\.ReadOnly\s*=\s*\.T\.')

Write-Host ""
Write-Host "=== NOMES EXIGIDOS ===" -ForegroundColor White
$metodosFinals = @("BtnCancelarClick","FormParaBO","BOParaForm","CarregarLista")
foreach ($m in $metodosFinals) { Mostrar $m ($conteudo -match $m) }
$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'
Mostrar 'padraoAcaoGravar' ($conteudo -match $padraoAcaoGravar)

Write-Host ""
Write-Host "=== RAMOS ===" -ForegroundColor White
$exib = ((-not $temListaLegadoF8) -and $semCrudLegadoF8 -and
         (Test-LegadoDialogoExibicao -TextoDump $txt) -and $temSup)
Mostrar 'legadoExibicaoF8' $exib
$visu = ($semCrudLegadoF8 -and $legadoSemSalvar -and
         (Test-LegadoSomenteLeitura -TextoDump $txt) -and $temSup -and
         ($conteudo -match '(?im)^\s*\.ReadOnly\s*=\s*\.T\.'))
Mostrar 'legadoVisualizadorF8' $visu
$fluxo = ($semCrudLegadoF8 -and (-not $exib) -and (-not $visu) -and
          $temListaLegadoF8 -and $temCamposLegadoF8 -and
          ($conteudo -match 'PROCEDURE\s+Carregar\w*'))
Mostrar 'legadoFluxoUnicoF8' $fluxo

Write-Host ""
Write-Host "=== ACAO ===" -ForegroundColor White
$acaoComHandler = Test-AcaoDoLegadoTemHandler -TextoDump $txt -ConteudoForm $conteudo
Mostrar 'Test-AcaoDoLegadoTemHandler' $acaoComHandler
$acaoOk = ($conteudo -match $padraoAcaoGravar) -or ($acaoComHandler -eq $true)
Mostrar 'exigencia de acao satisfeita' $acaoOk

Write-Host ""
$faltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
Write-Host "faltantes ANTES da dispensa: $($faltantes -join ', ')" -ForegroundColor White
if ($fluxo) { $faltantes = @($faltantes | Where-Object { @("BtnCancelarClick","FormParaBO","BOParaForm","CarregarLista") -notcontains $_ }) }
Write-Host "faltantes DEPOIS da dispensa: $($faltantes -join ', ')" -ForegroundColor White
if ($faltantes.Count -eq 0 -and $acaoOk) {
    Write-Host "RESULTADO: Fase 8 PASSA" -ForegroundColor Green; exit 0
} else {
    Write-Host "RESULTADO: Fase 8 REPROVA | acaoOk=$acaoOk" -ForegroundColor Red; exit 1
}
