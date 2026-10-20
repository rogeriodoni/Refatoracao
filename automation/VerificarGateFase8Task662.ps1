# VerificarGateFase8Task662.ps1
#
# Prova, SEM executar o orquestrador, que a Fase 8 de SIGPROER ->
# Formsigproer passa pelo motivo ESTRUTURAL certo e nao por acaso:
#   1) o OrquestradorMigracao.ps1 continua sintaticamente valido;
#   2) dos 4 nomes CRUD-canonicos, os que faltam sao exatamente os que o
#      ramo PROTOCOLO dispensa (BtnCancelarClick ja existe; CarregarLista
#      nao tem referente - nao ha grade nem cursor de listagem);
#   3) o legado cai no ramo PROTOCOLO (7o) e em NENHUM dos seis anteriores,
#      que sao avaliados aqui um a um;
#   4) a dispensa so vale porque o MIGRADO entregou a superficie real -
#      FormParaBO + BOParaForm + o handler do unico botao do legado
#      (temSuperficieProtF8), com regex ancorada em inicio de linha;
#   5) a acao de gravar NAO eh exigida, porque $legadoSemAcao recebe
#      $legadoProtocoloF8 no bloco de $padraoAcaoGravar.
#
# SIGPROER eh irmao do SIGPRDFT (task599), o caso de origem do ramo: mesmo
# dialogo modal de conversa com o PIN-pad SiTef, mesmas 3 funcoes da
# CliSiTef32I.DLL declaradas no Load do SCX, mesmo CommandGroup
# SAIDA/CANCELA de ButtonCount = 1 com ControlSource = "OPSENHA".
#
# AST-only de proposito: dot-source do orquestrador DISPARA uma migracao
# real (move .SCX de origem\ e sobrescreve BO existente).

$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$erros = $null
[System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$erros) | Out-Null
if ($erros -and $erros.Count -gt 0) {
    "SINTAXE=FALHA ({0} erro(s))" -f $erros.Count
    $erros | Select-Object -First 5 | ForEach-Object { "  L{0}: {1}" -f $_.Extent.StartLineNumber, $_.Message }
    exit 1
}
"SINTAXE=OK"

$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$txt      = Get-Content 'C:\4c\tasks\task662\sigproer_form_codigo_fonte.txt' -Raw
$conteudo = Get-Content 'C:\4c\projeto\app\forms\operacionais\Formsigproer.prg' -Raw
$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'

# ---- (2) os 4 nomes CRUD-canonicos ----------------------------------------
$metodosFinals = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
$faltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
"metodosFaltantes(4 nomes)   = [{0}]" -f ($faltantes -join ', ')

# ---- superficie do LEGADO -------------------------------------------------
$padroesSalvarLegado = @('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados')
$legadoSemSalvar = -not ($padroesSalvarLegado | Where-Object { $txt -match $_ })

$temListaLegadoF8  = ($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                     ($txt -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
$temCamposLegadoF8 = ($txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
$padroesCrudLegadoF8 = @('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click')
$semCrudLegadoF8 = -not ($padroesCrudLegadoF8 | Where-Object { $txt -match $_ })

"legadoSemSalvar             = {0}" -f $legadoSemSalvar
"semCrudLegadoF8             = {0}" -f $semCrudLegadoF8
"temCamposLegadoF8           = {0}" -f $temCamposLegadoF8
"temListaLegadoF8 (LARGO)    = {0}   <- falso positivo: AddCursor de 6 args + ControlSource de CommandGroup" -f $temListaLegadoF8
"nBotoesLegado               = {0}" -f (Get-ContagemBotoesLegado -TextoDump $txt)

# ---- (3) os SEIS ramos anteriores NAO alcancam ----------------------------
# Reproduzidos com os mesmos predicados do orquestrador; cada um e' barrado
# por uma prova diferente, o que e' o que mantem o ramo PROTOCOLO estreito.
$temEstruturaSemPageFrameF8   = $conteudo -match 'ConfigurarCabecalho|ConfigurarCampos'
$temSuperficieDespachanteF8   = ($conteudo -match "InicializarForm") -and
                                (($conteudo -match "ConfigurarPageFrame") -or $temEstruturaSemPageFrameF8)
$legadoDespachanteF8  = ((-not $temListaLegadoF8) -and (-not $temCamposLegadoF8) -and
                         $semCrudLegadoF8 -and $temSuperficieDespachanteF8)
$legadoExibicaoF8     = ((-not $temListaLegadoF8) -and $semCrudLegadoF8 -and
                         (Test-LegadoDialogoExibicao -TextoDump $txt) -and
                         $temSuperficieDespachanteF8 -and
                         ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"(EditBox|TextBox)"'))
$legadoVisualizadorF8 = ($semCrudLegadoF8 -and $legadoSemSalvar -and
                         (Test-LegadoSomenteLeitura -TextoDump $txt) -and
                         $temSuperficieDespachanteF8 -and
                         ($conteudo -match '(?im)^\s*\.ReadOnly\s*=\s*\.T\.'))
$legadoFluxoUnicoF8   = ($semCrudLegadoF8 -and (-not $legadoDespachanteF8) -and
                         (-not $legadoExibicaoF8) -and (-not $legadoVisualizadorF8) -and
                         $temListaLegadoF8 -and $temCamposLegadoF8 -and
                         ($conteudo -match 'PROCEDURE\s+Carregar\w*'))
$legadoArvoreF8       = ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"OLEControl"')
$temBotoesLinhaF8     = ($txt -match '(?i)(btn|cmd|Command)Inserir') -and ($txt -match '(?i)(btn|cmd|Command)Excluir')
$legadoLinhaImediataF8 = ($temListaLegadoF8 -and $temBotoesLinhaF8)
$cliqueSoFechaF8      = Test-LegadoCliqueSoFecha -TextoDump $txt
$legadoCalculadoraF8  = ($semCrudLegadoF8 -and (-not $temListaLegadoF8) -and $temCamposLegadoF8 -and
                         $legadoSemSalvar -and ($cliqueSoFechaF8 -eq $true) -and
                         ((Get-ContagemBotoesLegado -TextoDump $txt) -eq 1))

"  despachante   = {0}   <- barrado por TER campos" -f $legadoDespachanteF8
"  exibicao      = {0}   <- barrado: campo editavel (SENHA)" -f $legadoExibicaoF8
"  visualizador  = {0}   <- barrado: campo editavel (SENHA)" -f $legadoVisualizadorF8
"  fluxo-unico   = {0}   <- barrado: migrado nao tem PROCEDURE Carregar*" -f $legadoFluxoUnicoF8
"  arvore        = {0}   <- barrado: sem OLEControl" -f $legadoArvoreF8
"  linha-imediata= {0}   <- barrado: sem botoes Inserir/Excluir de linha" -f $legadoLinhaImediataF8
"  calculadora   = {0}   <- barrado: o Click TRABALHA antes de fechar (RetornoFalha)" -f $legadoCalculadoraF8

# ---- (3b) o ramo PROTOCOLO -------------------------------------------------
$semGradeProtocoloF8 = -not (($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                             (Test-LegadoListBoxLigaLista -TextoDump $txt) -or
                             ($txt -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                             (Test-LegadoAddCursorLigaGrade -TextoDump $txt) -or
                             (Test-LegadoControlSourceLigaLista -TextoDump $txt))
$temDllExternaF8     = $txt -match '(?im)^\s*DECLARE\s+.*\bIN\s+"[^"]+\.(DLL|OCX|EXE)"'
$semAcaoNemCancelarProtF8 = -not ($txt -match '(?i)(btn|cmd|Command)(Cancel|Confirm|Salva|Grava|Aplica|Executa|Process)')
$nBotoesProtF8       = Get-ContagemBotoesLegado -TextoDump $txt
$temSuperficieProtF8 = ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                       ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b') -and
                       ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn\w*Click\b')

"semGradeProtocoloF8 (ESTRITO) = {0}   <- descontados os dois falsos positivos" -f $semGradeProtocoloF8
"temDllExternaF8               = {0}   <- Load declara 3 funcoes da CliSiTef32I.DLL" -f $temDllExternaF8
"semAcaoNemCancelarProtF8      = {0}" -f $semAcaoNemCancelarProtF8
"temSuperficieProtF8           = {0}   <- FormParaBO + BOParaForm + Btn*Click no MIGRADO" -f $temSuperficieProtF8

$legadoProtocoloF8 = ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                      (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                      (-not $legadoArvoreF8) -and
                      (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                      $semCrudLegadoF8 -and $semGradeProtocoloF8 -and
                      $temCamposLegadoF8 -and $temDllExternaF8 -and
                      $legadoSemSalvar -and $semAcaoNemCancelarProtF8 -and
                      ($nBotoesProtF8 -eq 1) -and $temSuperficieProtF8)
"legadoProtocoloF8             = {0}" -f $legadoProtocoloF8

# ---- dispensa PARCIAL do ramo PROTOCOLO -----------------------------------
if ($legadoProtocoloF8) {
    $dispensaProtocoloF8 = @("BtnCancelarClick", "CarregarLista")
    $faltantes = @($faltantes | Where-Object { $dispensaProtocoloF8 -notcontains $_ })
}
"metodosFaltantes apos ramo    = [{0}]" -f ($faltantes -join ', ')

# ---- (5) bloco do botao de acao -------------------------------------------
$legadoSemAcao = $false
if ($legadoSemSalvar) {
    $legadoSemAcao = (($cliqueSoFechaF8 -eq $true) -and ($nBotoesProtF8 -eq 1))
    if (-not $legadoSemAcao) { $legadoSemAcao = $legadoProtocoloF8 }
}
$bloqueiaAcao = (-not ($conteudo -match $padraoAcaoGravar)) -and (-not $legadoSemAcao)
"padraoAcaoGravar no migrado   = {0}   <- o legado nao tem botao de gravar" -f ($conteudo -match $padraoAcaoGravar)
"legadoSemAcao                 = {0}   <- recebe legadoProtocoloF8" -f $legadoSemAcao
"bloqueio por botao de acao    = {0}" -f $bloqueiaAcao

# ---- veredito -------------------------------------------------------------
if ($legadoProtocoloF8 -and $faltantes.Count -eq 0 -and -not $bloqueiaAcao) {
    "VEREDITO=PASSA (ramo PROTOCOLO, metodosFaltantes vazio)"
    exit 0
}
"VEREDITO=REPROVA"
exit 1
