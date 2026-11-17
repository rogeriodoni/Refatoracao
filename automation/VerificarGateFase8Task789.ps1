<#
.SYNOPSIS
    Replica os predicados do gate da Fase 8 (case 8 de Invoke-MigracaoFase) para
    a task789 (SIGOPPRM -> FormSIGOPPRM), sem dot-sourcear o OrquestradorMigracao
    inteiro (dot-source dispara migracao real - Invoke-MigracaoFase chama
    ClaudeInvoker.ps1 incondicionalmente).
.DESCRIPTION
    Extrai via AST SO as funcoes puras (Test-*/Get-*, sem efeito colateral) que
    o case 8 consulta, e reproduz a cadeia de variaveis desse case NA MESMA
    ORDEM, usando as funcoes REAIS do orquestrador (nao reescritas a mao) para
    cada predicado. SIGOPPRM eh um dialogo FILHO flat (sem PageFrame, sem
    frmcadastro) com grade de marcacao (GridEmps) e acao real de GRAVACAO
    (RetirarPromocao faz DELETE FROM SigPrPmi) cujo botao se chama "Retirar"
    (fora da lista canonica Btn(Salvar|Confirmar|Gravar|Processa|...)Click) -
    o perfil que o ramo FLUXO-UNICO (dispensa os 4 nomes canonicos) e
    Test-AcaoDoLegadoTemHandler (aceita o verbo do botao do legado) cobrem.
#>

$ErrorActionPreference = 'Stop'

$raiz        = 'C:\4c'
$orquestrador = Join-Path $raiz 'automation\OrquestradorMigracao.ps1'
$formFile    = Join-Path $raiz 'projeto\app\forms\operacionais\FormSIGOPPRM.prg'
$boFile      = Join-Path $raiz 'projeto\app\classes\SIGOPPRMBO.prg'
$dumpFile    = Join-Path $raiz 'tasks\task789\SIGOPPRM_form_codigo_fonte.txt'

foreach ($p in @($formFile, $boFile, $dumpFile, $orquestrador)) {
    if (-not (Test-Path $p)) { Write-Host "[ERRO] arquivo ausente: $p" -ForegroundColor Red; exit 1 }
}

# ---- Extracao via AST das funcoes PURAS consultadas pelo case 8 -----------
$funcoesNecessarias = @(
    'Get-ContagemBotoesLegado', 'Get-ContagemPcEscolhaViva',
    'Test-ModoRecebidoDoChamador', 'Test-LegadoDialogoExibicao',
    'Test-LegadoSomenteLeitura', 'Test-LegadoCliqueSoFecha',
    'Test-LegadoBotaoUnicoSoFecha', 'Test-AcaoDoLegadoTemHandler',
    'Test-VerbosCrudSaoTodosDeLinhaDeGrade', 'Test-VerbosCrudSaoTodosDeRelatorio',
    'Get-CorpoClickDoObjetoLegado', 'Get-NomeBotaoUnicoDeGrupoLegado',
    'Get-NomesBotoesLegado', 'Test-LinhaDeFechamentoLegado',
    'Get-CorpoMetodoDoFormLegado'
)
$ast = [System.Management.Automation.Language.Parser]::ParseFile($orquestrador, [ref]$null, [ref]$null)
$encontradas = @{}
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    if ($funcoesNecessarias -contains $f.Name) {
        . ([scriptblock]::Create($f.Extent.Text))
        $encontradas[$f.Name] = $true
    }
}
foreach ($fn in $funcoesNecessarias) {
    if (-not $encontradas.ContainsKey($fn)) {
        Write-Host "[ERRO] funcao nao encontrada no orquestrador: $fn" -ForegroundColor Red
        exit 1
    }
}
Write-Host "[OK] $($funcoesNecessarias.Count) funcoes puras extraidas via AST (sem dot-source do script inteiro)" -ForegroundColor Green

$conteudo    = Get-Content $formFile -Raw
$txtLegadoF8 = Get-Content $dumpFile -Raw

# ---- Reproducao da cadeia do case 8, na mesma ordem do orquestrador -------

$temListaLegadoF8  = ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                      ($txtLegadoF8 -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
$temCamposLegadoF8 = ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')

$padroesCrudLegadoF8 = @('frmcadastro', 'Grupo_Op', '(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)', '(Incluir|Alterar|Visualizar|Excluir)\.Click')
$semCrudLegadoF8     = -not ($padroesCrudLegadoF8 | Where-Object { $txtLegadoF8 -match $_ })

$padroesSalvarLegado = @('btnSalvar', 'btnGravar', 'PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click', 'mGravaDados')
$legadoSemSalvar     = -not ($padroesSalvarLegado | Where-Object { $txtLegadoF8 -match $_ })

Write-Host ""
Write-Host "temListaLegadoF8        = $temListaLegadoF8"
Write-Host "temCamposLegadoF8       = $temCamposLegadoF8"
Write-Host "semCrudLegadoF8         = $semCrudLegadoF8"
Write-Host "legadoSemSalvar         = $legadoSemSalvar"

# $soApagaLinhaGradeF8/$soRelatorioF8 so entram em jogo quando $semCrudLegadoF8
# jah eh falso (sao OR adicionais) - aqui jah eh .T., nao precisam ser medidos.
$semCrudRealF8 = $semCrudLegadoF8

# pcEscolha com olhar de DONO: so derruba semCrud* se houver ocorrencia VIVA
# (nao-comentada, nao-leitura-do-pai) E Test-ModoRecebidoDoChamador falhar.
$nPcEscolhaVivaF8 = Get-ContagemPcEscolhaViva -TextoDump $txtLegadoF8
Write-Host "nPcEscolhaVivaF8        = $nPcEscolhaVivaF8  (0 = todas as 3 citacoes de pcEscolha sao leitura do PAI/comentario, descontadas)"
if ($nPcEscolhaVivaF8 -gt 0) {
    $modoRecebido = Test-ModoRecebidoDoChamador -TextoDump $txtLegadoF8
    Write-Host "Test-ModoRecebidoDoChamador = $modoRecebido"
    if (-not $modoRecebido) {
        $semCrudLegadoF8 = $false
        $semCrudRealF8   = $false
        Write-Host "  [!] pcEscolha viva sem prova de modo recebido - semCrudLegadoF8/semCrudRealF8 => FALSE"
    }
}

$legadoDespachanteF8 = ((-not $temListaLegadoF8) -and (-not $temCamposLegadoF8) -and $semCrudLegadoF8)
$legadoExibicaoF8 = ((-not $temListaLegadoF8) -and $semCrudLegadoF8 -and
                     ((Test-LegadoDialogoExibicao -TextoDump $txtLegadoF8) -or
                      (Test-LegadoSomenteLeitura  -TextoDump $txtLegadoF8)))
$legadoVisualizadorF8 = ($semCrudLegadoF8 -and $legadoSemSalvar -and
                         (Test-LegadoSomenteLeitura -TextoDump $txtLegadoF8))

Write-Host "legadoDespachanteF8     = $legadoDespachanteF8"
Write-Host "legadoExibicaoF8        = $legadoExibicaoF8"
Write-Host "Test-LegadoSomenteLeitura = $(Test-LegadoSomenteLeitura -TextoDump $txtLegadoF8)"
Write-Host "legadoVisualizadorF8    = $legadoVisualizadorF8"

$temCarregarF8 = ($conteudo -match 'PROCEDURE\s+Carregar\w*')
$legadoFluxoUnicoF8 = ($semCrudRealF8 -and (-not $legadoDespachanteF8) -and
                       (-not $legadoExibicaoF8) -and (-not $legadoVisualizadorF8) -and
                       $temListaLegadoF8 -and $temCamposLegadoF8 -and $temCarregarF8)
Write-Host "migrado tem PROCEDURE Carregar* = $temCarregarF8"
Write-Host "=> legadoFluxoUnicoF8   = $legadoFluxoUnicoF8  (dispensa BtnCancelarClick/FormParaBO/BOParaForm/CarregarLista)"

# ---- Os 4 nomes canonicos + dispensa FLUXO-UNICO ---------------------------
$metodosFinals    = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
$metodosFaltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
Write-Host ""
Write-Host "nomes canonicos ausentes no arquivo (antes de qualquer dispensa) = $($metodosFaltantes -join ', ')"

if ($legadoFluxoUnicoF8 -and $metodosFaltantes.Count -gt 0) {
    $dispensaFluxoUnicoF8 = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
    $dispensados = @($metodosFaltantes | Where-Object { $dispensaFluxoUnicoF8 -contains $_ })
    if ($dispensados.Count -gt 0) {
        Write-Host "  [i] Fase 8 (layout fluxo-unico): $($dispensados -join ', ') nao se aplicam - validado por CarregarPromocoes" -ForegroundColor Cyan
        $metodosFaltantes = @($metodosFaltantes | Where-Object { $dispensaFluxoUnicoF8 -notcontains $_ })
    }
}

# ---- Exigencia de botao de ACAO (quando nao ha match do nome canonico) ----
$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'
if ((-not $legadoDespachanteF8) -and ($conteudo -notmatch $padraoAcaoGravar)) {
    $legadoSemAcao = $false
    if ($txtLegadoF8 -and $legadoSemSalvar) {
        $cliqueSoFechaF8 = Test-LegadoCliqueSoFecha -TextoDump $txtLegadoF8
        $nBotoesLegadoF8 = Get-ContagemBotoesLegado -TextoDump $txtLegadoF8
        Write-Host ""
        Write-Host "Test-LegadoCliqueSoFecha = $cliqueSoFechaF8"
        Write-Host "nBotoesLegadoF8          = $nBotoesLegadoF8"
        $legadoSemAcao = (($cliqueSoFechaF8 -eq $true) -and ($nBotoesLegadoF8 -eq 1))
        if (-not $legadoSemAcao) { $legadoSemAcao = $legadoVisualizadorF8 }
        if (-not $legadoSemAcao) {
            $botaoUnicoSoFechaF8 = Test-LegadoBotaoUnicoSoFecha -TextoDump $txtLegadoF8
            Write-Host "Test-LegadoBotaoUnicoSoFecha = $botaoUnicoSoFechaF8"
            $legadoSemAcao = $botaoUnicoSoFechaF8
        }
        if (-not $legadoSemAcao) {
            $acaoLegadoComHandlerF8 = Test-AcaoDoLegadoTemHandler -TextoDump $txtLegadoF8 -ConteudoForm $conteudo
            Write-Host "Test-AcaoDoLegadoTemHandler = $acaoLegadoComHandlerF8"
            $legadoSemAcao = $acaoLegadoComHandlerF8
        }
    }
    Write-Host "=> legadoSemAcao (exigencia de botao de GRAVAR dispensada) = $legadoSemAcao"
    if (-not $legadoSemAcao) {
        $metodosFaltantes += "BtnSalvarClick (ou BtnConfirmarClick/BtnGravarClick/BtnProcessaClick)"
    }
}

if ((-not $legadoDespachanteF8) -and ($conteudo -notmatch "BtnSalvarClick")) {
    if ($legadoSemSalvar) {
        Write-Host "  [i] Fase 8: legado sem botao de gravar - validado pelo botao de acao que o legado realmente tem" -ForegroundColor Cyan
    } else {
        $metodosFaltantes += "BtnSalvarClick (legado TEM botao de gravar, ou dump ausente)"
    }
}

Write-Host ""
if ($metodosFaltantes.Count -eq 0) {
    Write-Host "[GATE-F8-TASK789] PASSA - nenhum metodo canonico faltante" -ForegroundColor Green
    exit 0
}
Write-Host "[GATE-F8-TASK789] REPROVA: $($metodosFaltantes -join ' | ')" -ForegroundColor Red
exit 1
