*==============================================================================
* FormSigOpIgm.prg - Impressao Global de Movimentacoes
*==============================================================================
* Herda de: FormBase
* BO: SigOpIgmBO
* Legado: SigOpIgm.SCX (tasks/task747/SigOpIgm_form_codigo_fonte.txt)
* Tipo: OPERACIONAL (form PLANO, sem PageFrame - no dump todos os objetos sao
*       filhos diretos de SIGOPIGM ou de cntSombra: a arvore de objetos tem
*       "Class: form / BaseClass: form" na raiz e NENHUM "BaseClass: pageframe".
*       Por isso NAO existe pgf_4c_* neste form: inventar um PageFrame que o
*       legado nao tem violaria o PILAR 1 e a regra "NUNCA inventar".)
*
* Dialogo MODAL (WindowType = 1) aberto a partir de uma tela de movimentacao
* para imprimir, em lote, os documentos/boletos das movimentacoes ligadas a
* uma mesma origem. Equivale ao "Parameters poform, _pEmps, _pDopes, _pNumes,
* _pChkImpDoc, _pBol" do Init legado:
*   poform      -> par_oFormPai     (ThisForm.Parentform do legado)
*   _pEmps      -> par_cEmps        (empresa, SigMvCab.Emps char(3))
*   _pDopes     -> par_cDopes       (operacao; o legado guarda em
*                                    ThisForm.Movimentacao)
*   _pNumes     -> par_nNumes       (numero da movimentacao de origem)
*   _pChkImpDoc -> par_lChkImpDoc   (repassado a SigPrIdc/SigReIfx)
*   _pBol       -> par_nBol         (Boleto > 0 troca o Caption do form)
* A ordem dos parametros e a MESMA do legado, para os chamadores nao mudarem.
*
* O legado tambem guarda ThisForm.oModem = ThisForm.Parentform.oModemEest -
* aqui this_oModem, lido do form pai sob guarda de PEMSTATUS (o harness de
* teste instancia o dialogo sem form pai nenhum).
*
* DataSession = 1 (compartilhada, igual ao default da classe base Form): o
* dump legado nao declara DataSession, e o cursor da grade e criado pelo BO
* na sessao corrente. Sem datasession privada nao se aplica o fix
* SET DATE/CENTURY da regra CLAUDE.md #9.4.
*
* Montagem (migracao multi-fase):
*   Fase 1-2        - SigOpIgmBO.prg (propriedades, DefinirParametros,
*                     CriarCursorMovimentacoes, CarregarMovimentacoes,
*                     CarregarConfiguracaoOperacao, DeveExibirBotaoBoleto,
*                     ResolverTipoBoleto, ImprimirDocumentoDaLinha,
*                     MarcarLinhaComoImpressa, ContarMarcadas, ValidarDados).
*   Fase 3          - DEFINE CLASS, propriedades visuais e de estado,
*                     Init/Destroy/InicializarForm, o orquestrador de
*                     montagem ConfigurarPageFrame(), o cabecalho
*                     cnt_4c_Sombra (cntSombra do legado, com lbl_4c_LblSombra
*                     e lbl_4c_LblTitulo) e TornarControlesVisiveis().
*                     O cursor da grade tambem nasce aqui, via
*                     SigOpIgmBO.CriarCursorMovimentacoes() - equivalente ao
*                     "Create Cursor csPgto" do PROCEDURE Load legado, que
*                     roda ANTES de qualquer controle existir e precisa estar
*                     aberto para a grade da Fase 4 poder se ligar a ele.
*   Fase 4 (esta)   - grd_4c_Dados (Grd do legado: 3 colunas - CheckBox de
*                     marcacao, Movimentacoes e Valor), a carga da grade
*                     (CarregarLista(), que chama SigOpIgmBO.Buscar() e
*                     repinta a grade) e os QUATRO botoes de acao que o
*                     legado tem como filhos diretos do form, via
*                     ConfigurarBotoes(): cmd_4c_BtnBoleto / cmd_4c_Imprimir /
*                     cmd_4c_Grade / cmd_4c_Sair. A visibilidade condicional
*                     do Boleto (AjustarVisibilidadeBoleto) tambem entra aqui,
*                     porque depende do botao ja existir.
*   Fase 5-6        - campos e eventos de celula da grade.
*   Fase 7          - os Click dos quatro botoes e o respectivo BINDEVENT de
*                     cada um (BINDEVENT valida o delegate NA HORA DO BIND,
*                     entao o bind vai junto com o handler, nunca adiantado),
*                     mais o KeyPress do form (KeyPreview = .T.: F2 aciona
*                     Imprimir e F3 aciona Grade, conforme o PROCEDURE
*                     KeyPress legado).
*   Fase 8 (esta)   - os eventos AUXILIARES que faltavam e a consolidacao
*                     final (detalhado abaixo).
*
* --- O QUE A FASE 8/8 ENTREGA -------------------------------------------
*
* 1. O ULTIMO evento com codigo que restava no dump legado: o Click do
*    checkbox da coluna 1 da grade (SIGOPIGM.Grd.Column1.Check1.Click,
*    "if !(csPgto.printed) / This.value = .t."). Entra como o quarteto
*    canonico Click/MouseDown/MouseUp/KeyPress com NODEFAULT
*    (ChkMarca*), porque CheckBox posto em Column por AddObject NAO
*    alterna pelo binding nativo. Com isto NAO sobra metodo do legado sem
*    migrar: Load -> SigOpIgmBO.CriarCursorMovimentacoes, Init ->
*    Init/InicializarForm/FormParaBO/CarregarLista/BOParaForm, KeyPress ->
*    KeyPress, Check1.Click -> ChkMarca*, Column2/Column3.Text1.When
*    ("Return .f.") -> Column.ReadOnly = .T. em ConfigurarGrid,
*    Sair.Click -> BtnSairClick, Grade.Click -> BtnGradeClick,
*    Imprimir.Click -> BtnImprimirClick, btnBoleto.Click ->
*    BtnBoletoClick.
*
* 2. FormParaBO() / BOParaForm(), o par de espelhamento tela<->BO que o
*    template da Fase 8 pede - aqui como FUNIL dos dois sentidos que este
*    dialogo de fato tem, NAO como metodo novo sem uso:
*      FormParaBO  - empurra para o BO os cinco dados que o Init legado
*                    recebe por parametro (Emps/Dopes/Numes/pChkImpDoc/
*                    Boleto); era a chamada solta a DefinirParametros()
*                    dentro de InicializarForm.
*      BOParaForm  - traz do BO o que a tela EXIBE depois da carga: a
*                    visibilidade do botao Boleto (a ultima linha do Init
*                    legado), o estado dos botoes de acao e o repintar da
*                    grade; era a chamada solta a AjustarVisibilidadeBoleto().
*    Nao ha campo digitavel FORA da grade neste dialogo (o dump tem
*    cntSombra + grade + 4 botoes, e nada mais): as tres colunas se ligam
*    ao cursor por ControlSource, entao o "campo a campo" do par CRUD
*    nao tem outro referente aqui.
*
* 3. AjustarBotoesPorModo() / HabilitarCampos(), cumprindo o que o
*    cabecalho de ConfigurarBotoes() promete desde a Fase 7 (os botoes
*    nascem com Themes = .T. + DisabledPicture justamente para poderem
*    ficar Enabled = .F. sem perder o icone): refletem na tela a guarda
*    this_lProcessandoLote que BtnImprimirClick/BtnBoletoClick/
*    BtnSairClick ja consultavam. Nao e comportamento novo - e a mesma
*    decisao, visivel.
*
* 4. ValidarLoteImpressao(), que consolida numa FONTE UNICA o aviso de
*    grade vazia ("Nao existem observacoes a serem auteticadas", grafia
*    do legado) - o mesmo texto estava LITERAL nos dois handlers e ainda
*    em SigOpIgmBO.ValidarDados, que ninguem chamava. Agora os dois
*    handlers chamam o BO.
*
* --- NOMES DO TEMPLATE CRUD QUE NAO SE APLICAM --------------------------
*
* BtnSalvarClick / BtnCancelarClick / BtnBuscarClick / BtnEncerrarClick /
* LimparCampos nao tem referente neste legado, pelo mesmo motivo das
* Fases 4 a 7 (e igual ao irmao FormSigOpIbo):
*   - o dialogo nao grava registro nenhum (nao tem tabela propria, nem
*     chave primaria, nem cursor de edicao - ver o cabecalho de
*     SigOpIgmBO.prg): nao ha o que SALVAR nem o que CANCELAR;
*   - nao ha PageFrame, nem Page1 (Lista)/Page2 (Dados), nem modo de
*     edicao - o dump nao tem "BaseClass: pageframe";
*   - a saida da tela e o botao Sair do legado (Cancel = .T., Click =
*     "ThisForm.Release"), entregue como BtnSairClick; renomea-lo para
*     Cancelar/Encerrar faria o nome MENTIR sobre o que o metodo faz;
*   - nao ha filtro nem campo de busca a BUSCAR: a consulta e UMA so,
*     pela chave posicional que o chamador passa por parametro;
*   - nao ha campo a LIMPAR fora da grade, e a grade e recarregada por
*     CarregarLista (ZAP + INSERT no BO), nunca "limpa" campo a campo.
* Fabrica-los produziria metodo vazio (proibido pela regra de completude)
* ou inventaria superficie que o legado nao tem (viola o PILAR 1).
*
* Nomes de objeto conforme tasks/task747/mapeamento.json.
*==============================================================================

DEFINE CLASS FormSigOpIgm AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - transcritas do dump legado (SECAO 2,
    * "PROPRIEDADES DE: SIGOPIGM"): BorderStyle=2, Height=304, Width=800,
    * ShowTips=.T., AutoCenter=.T., ControlBox=.F., Movable=.F.,
    * KeyPreview=.T., TitleBar=0, WindowType=1.
    *
    * Closable, MaxButton e MinButton NAO constam do dump - nao inventar
    * (inventar Closable retiraria a unica saida da tela). Como TitleBar = 0
    * e ControlBox = .F., quem fecha o dialogo e o botao Sair da Fase 8
    * (Cancel = .T. no legado, ou seja ESC tambem fecha).
    *
    * A Picture do form (..\framework\imagens\new_background.jpg no dump) e
    * resolvida em InicializarForm() via gc_4c_CaminhoFramework, com guarda
    * de FILE(): .Picture apontando para arquivo inexistente falha em
    * SILENCIO (regra CLAUDE.md #25), e aqui o caminho depende de variavel
    * global que so existe depois do config.prg.
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width       = 800
    Height      = 304
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    ShowWindow = 1
    ControlBox  = .F.
    Movable     = .F.
    KeyPreview  = .T.
    TitleBar    = 0
    WindowType  = 1
    FontName    = "Tahoma"
    FontSize    = 8

    Caption = "Impress" + CHR(227) + "o Global de Movimenta" + CHR(231) + CHR(245) + "es"

    *--------------------------------------------------------------------------
    * Propriedades de estado - equivalem as cinco propriedades customizadas
    * que o dump legado declara em RESERVED3/ClassInfo (boleto, omodem,
    * parentform, pchkimpdoc, movimentacao), renomeadas conforme o PILAR 3.
    *--------------------------------------------------------------------------

    *-- ThisForm.Parentform do legado (1o parametro do Init). Usado para ler
    *-- oModemEest e para devolver o foco ao fechar.
    this_oFormPai = .NULL.

    *-- ThisForm.oModem = ThisForm.Parentform.oModemEest do legado. Fica
    *-- .NULL. quando o form pai nao expoe oModemEest (ou quando nao ha form
    *-- pai, como no harness de teste).
    this_oModem = .NULL.

    *-- ThisForm.Movimentacao = _pDopes do legado. char(20) em SigMvCab.Dopes,
    *-- guardado com o padding da coluna porque entra na chave POSICIONAL
    *-- EmpDnCrds (3 + 20 + 6 = 29) montada pelo BO (regra CLAUDE.md #42).
    this_cMovimentacao = SPACE(20)

    *-- Empresa e numero da movimentacao de origem (_pEmps / _pNumes), as
    *-- outras duas partes da mesma chave posicional.
    this_cEmps = SPACE(3)
    this_nNumes = 0

    *-- ThisForm.pChkImpDoc do legado: repassado, sem interpretacao, a
    *-- SigPrIdc e a SigReIfx no Click de Imprimir (Fase 8).
    this_lChkImpDoc = .F.

    *-- ThisForm.Boleto do legado. O legado declara "boleto = .F." no SCX mas
    *-- o Init o normaliza para NUMERO - Iif(Type([_pBol])=[N], _pBol, 0) -,
    *-- e so compara com zero (If ThisForm.Boleto > 0). Por isso a property
    *-- aqui e NUMERICA desde a declaracao: manter o .F. do SCX faria
    *-- "> 0" comparar Logico com Numero e estourar type mismatch.
    this_nBoleto = 0

    *-- Guarda de reentrancia do lote de impressao (NAO existe no legado).
    *-- BtnImprimirClick e BtnBoletoClick varrem a grade abrindo dialogos
    *-- MODAIS (Formsigreifx / FormSigOpIbo) linha a linha: o Show() bloqueia,
    *-- mas o KeyPress do form (KeyPreview = .T.) continua chegando e um F2/F3
    *-- durante o lote reentraria no proprio SCAN, reprocessando as linhas que
    *-- ainda nao foram marcadas como impressas. No legado isso nao aparece
    *-- porque o Do Form dele e o laco inteiro vivem na mesma pilha bloqueada
    *-- do SCX modal; aqui a guarda e explicita.
    *--
    *-- Liberada DEPOIS do ENDTRY nos dois handlers (regra CLAUDE.md #47): com
    *-- o clear dentro do TRY, um erro no meio do lote deixaria a flag ligada
    *-- e MATARIA os dois botoes pelo resto da vida do dialogo.
    this_lProcessandoLote = .F.

    *--------------------------------------------------------------------------
    * Init - recebe os seis parametros do Init legado, NA MESMA ORDEM, cria o
    * Business Object e ajusta o Caption ANTES do DODEFAULT().
    *
    * A ordem importa duas vezes:
    *   - o BO precisa existir antes do DODEFAULT(), porque FormBase.Init()
    *     usa o BO;
    *   - o Caption precisa estar definido antes do DODEFAULT(), porque
    *     ConfigurarCabecalho() monta os dois labels da faixa a partir de
    *     THIS.Caption - exatamente o que o legado faz com
    *     "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption".
    *
    * Bypass em modo teste/validacao de UI: o harness (TestFormWrapper, etapa
    * 06_testForm) faz CREATEOBJECT(par_cFormClass) SEM argumento nenhum. Sem
    * o bypass, a validacao de parametro obrigatorio dispararia MsgErro,
    * Init() devolveria .F. e CREATEOBJECT devolveria .F. logico, reprovando
    * o form sempre - mesmo estando 100% fiel ao legado. A validacao continua
    * valendo em producao.
    *
    * NAO ha RETURN dentro do TRY/CATCH (regra CLAUDE.md #1): o fluxo e
    * controlado pelas flags loc_lParametrosOk / loc_lSucesso e ha um unico
    * RETURN, depois do ENDTRY.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oFormPai, par_cEmps, par_cDopes, par_nNumes, ;
            par_lChkImpDoc, par_nBol

        LOCAL loc_lSucesso, loc_lParametrosOk, loc_lBypassParametros, loc_oErro

        loc_lSucesso = .F.
        loc_lParametrosOk = .T.

        loc_lBypassParametros = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
            (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

        TRY
            IF !loc_lBypassParametros
                IF PCOUNT() < 1 OR VARTYPE(par_oFormPai) != "O"
                    MsgErro("Formul" + CHR(225) + "rio chamador n" + CHR(227) + ;
                        "o informado (par_oFormPai).", "Parametros Invalidos")
                    loc_lParametrosOk = .F.
                ENDIF

                IF loc_lParametrosOk AND ;
                        (PCOUNT() < 3 OR VARTYPE(par_cDopes) != "C" OR EMPTY(par_cDopes))
                    MsgErro("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                        "o informada (par_cDopes).", "Parametros Invalidos")
                    loc_lParametrosOk = .F.
                ENDIF
            ENDIF

            IF loc_lParametrosOk
                *-- Atribuicao sempre sob guarda de VARTYPE: em bypass o
                *-- parametro pode nao ter sido passado e chega como .F.
                *-- logico, nao como string vazia.
                THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)

                IF VARTYPE(par_cEmps) = "C"
                    THIS.this_cEmps = PADR(ALLTRIM(par_cEmps), 3)
                ENDIF

                IF VARTYPE(par_cDopes) = "C"
                    THIS.this_cMovimentacao = PADR(ALLTRIM(par_cDopes), 20)
                ENDIF

                THIS.this_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)
                THIS.this_lChkImpDoc = IIF(VARTYPE(par_lChkImpDoc) = "L", par_lChkImpDoc, .F.)

                *-- Legado: ThisForm.Boleto = Iif(Type([_pBol])=[N], _pBol, 0)
                THIS.this_nBoleto = IIF(VARTYPE(par_nBol) = "N", par_nBol, 0)

                *-- Legado: Thisform.oModem = ThisForm.Parentform.oModemEest
                IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
                        PEMSTATUS(THIS.this_oFormPai, "oModemEest", 5)
                    THIS.this_oModem = THIS.this_oFormPai.oModemEest
                ENDIF

                *-- Legado: If (ThisForm.Boleto > 0) / ThisForm.Caption =
                *--         [Impressao Global de Boletos] / EndIf
                IF THIS.this_nBoleto > 0
                    THIS.Caption = "Impress" + CHR(227) + "o Global de Boletos"
                ENDIF

                THIS.this_oBusinessObject = CREATEOBJECT("SigOpIgmBO")

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    loc_lSucesso = DODEFAULT()
                ELSE
                    MsgErro("Falha ao criar SigOpIgmBO.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Impress" + CHR(227) + "o Global de Movimenta" + ;
                CHR(231) + CHR(245) + "es: " + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a tela. O BO e verificado primeiro: sem ele nao
    * ha cursor de grade nem dados, e deixar seguir produziria uma tela vazia
    * sem explicacao.
    *
    * A ordem reproduz o legado: o "Create Cursor csPgto" do PROCEDURE Load
    * roda ANTES de tudo (aqui, CriarCursorMovimentacoes no BO), e os dados
    * da movimentacao de origem sao repassados ao BO para que ele monte a
    * chave posicional EmpDnCrds usada na carga da Fase 4.
    *
    * TornarControlesVisiveis() vem por ULTIMO porque AddObject cria todo
    * controle com Visible = .F.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_cPicture, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("SigOpIgmBO n" + CHR(227) + "o foi inicializado.", "Erro")
            ELSE
                *-- Legado: Picture = ..\framework\imagens\new_background.jpg
                IF TYPE("gc_4c_CaminhoFramework") = "C"
                    loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
                    IF FILE(loc_cPicture)
                        THIS.Picture = loc_cPicture
                    ENDIF
                ENDIF

                *-- Repassa ao BO os parametros de dados recebidos no Init
                *-- (poform fica no Form). FUNIL unico Tela -> BO, ver
                *-- FormParaBO() abaixo.
                THIS.FormParaBO()

                *-- Equivalente ao PROCEDURE Load legado (Create Cursor csPgto)
                IF !THIS.this_oBusinessObject.CriarCursorMovimentacoes()
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel criar o cursor das movimenta" + CHR(231) + CHR(245) + ;
                        "es.", "Erro")
                ELSE
                    THIS.ConfigurarPageFrame()

                    IF !THIS.CarregarLista()
                        *-- Legado (Init): "If Reccount()=0 / ThisForm.Release /
                        *-- Return .F." - sem nenhuma movimentacao a autenticar o
                        *-- dialogo nao abre, em SILENCIO (CarregarLista/o BO ja
                        *-- guardaram o motivo em this_cMensagemErro, sem
                        *-- MsgErro). loc_lSucesso continua .F. e CREATEOBJECT
                        *-- reprova a instanciacao - mesmo efeito pratico do
                        *-- Release do legado.
                        loc_lSucesso = .F.
                    ELSE
                        THIS.TornarControlesVisiveis(THIS)

                        *-- FUNIL unico BO -> Tela. Contem a ULTIMA linha do
                        *-- Init legado (btnBoleto.Visible =
                        *-- Inlist(crSigOpCdc.VenBols, 1, 3)) e por isso roda
                        *-- DEPOIS da varredura acima, que forca Visible = .T.
                        *-- em TODO controle e apagaria a decisao.
                        THIS.BOParaForm()

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpIgm.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestrador da montagem visual.
    *
    * SIGOPIGM nao tem PageFrame no legado (layout plano: cntSombra + grid +
    * quatro botoes direto no form). O nome do metodo e mantido apenas como
    * ponto de entrada arquitetural padrao do projeto, mesmo papel que tem em
    * Formsigopfin/FormSigPrIbb/FormSigPrGst - ele NAO cria PageFrame.
    *
    * Fase 3          - ConfigurarCabecalho() (cnt_4c_Sombra).
    * Fase 4 (esta)   - ConfigurarGrid() (grd_4c_Dados, 3 colunas).
    * Fase 7-8        - ConfigurarBotoes() (cmd_4c_BtnBoleto / cmd_4c_Imprimir /
    *                   cmd_4c_Grade / cmd_4c_Sair) e os eventos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrid()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - faixa cinza com o titulo, equivalente ao
    * cntSombra do legado (dump: Top=0, Left=0, Width=800, Height=80,
    * BorderWidth=0, BackColor=100,100,100).
    *
    * Os dois labels sao transcritos do dump (lblSombra: Tahoma 18 bold,
    * Top=18, Left=10, Width=769, Height=40, ForeColor=0,0,0; lblTitulo:
    * mesmos fonte/posicao com Top=17, Height=46, ForeColor=255,255,255) -
    * sao duas copias do mesmo texto, a de baixo em preto fazendo sombra da
    * de cima em branco. O branco aqui e correto porque o container e OPACO e
    * escuro (BackColor 100,100,100), que e justamente a excecao prevista na
    * regra CLAUDE.md #12.
    *
    * Caption vem de THIS.Caption nos dois, reproduzindo o
    * "lblSombra.Caption = ThisForm.Caption" do Init legado - por isso o Init
    * ajusta o Caption (modo Boleto) ANTES do DODEFAULT().
    *
    * AutoSize = .F. explicito com Width/Height do dump: AutoSize e no-op em
    * Label criado por AddObject e, com WordWrap = .T., descarta a Height e
    * corta a segunda linha (regra CLAUDE.md #23).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.cnt_4c_Sombra
            WITH loc_oCnt
                .Top           = 0
                .Left          = 0
                .Width         = THIS.Width
                .Height        = 80
                .BorderWidth   = 0
                .BackStyle     = 1
                .BackColor     = RGB(100, 100, 100)
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Top           = 18
                .Left          = 10
                .Width         = 769
                .Height        = 40
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .AutoSize    = .F.
                .Caption     = THIS.Caption
                .Top         = 17
                .Left        = 10
                .Width       = 769
                .Height      = 46
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpIgm.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - grd_4c_Dados: a "Grd" do legado (dump, SECAO 1 -
    * Top=85, Left=12, Width=346, Height=212, ColumnCount=3), ligada ao
    * cursor criado por CriarCursorMovimentacoes() (this_cCursorGrade =
    * "cursor_4c_Pgto"), vazio nesta altura e populado so depois por
    * CarregarLista().
    *
    * ColumnCount/RecordSource ficam FORA do WITH (regra CLAUDE.md #41): com
    * os dois dentro do mesmo WITH que acessa .ColumnN, o VFP9 ainda nao
    * recriou as colunas no instante em que .Column1 e referenciado, e
    * estoura "Unknown member COLUMN1".
    *
    * Tres colunas, nomes e headers do dump (mapeamento.json):
    *   Column1 - Check1 (csPgto.Marca, L) - sem header (dump:
    *             Header1.Caption = "")
    *   Column2 - csPgto.Obs (dump: Header1.Caption = "Movimenta" + CHR(231) +
    *             CHR(245) + "es")
    *   Column3 - csPgto.Valos (dump: Header1.Caption = "Valor")
    *
    * Column1 recebe so a ESTRUTURA nesta fase (AddObject + CurrentControl +
    * Sparse - regra CLAUDE.md #18, sem a qual o checkbox so aparece na
    * linha ativa). O comportamento "if !(csPgto.printed) / This.value = .t."
    * do Click legado e o quarteto ChkMarca* da Fase 8, ligado por BINDEVENT
    * no FIM deste metodo: CheckBox posto em Column por AddObject NAO alterna
    * pelo binding nativo, entao sem esses handlers a celula renderiza o
    * quadradinho e o clique nao faz nada.
    *
    * Marca (L) liga direto ao CheckBox: csPgto nasce de CREATE CURSOR
    * (READWRITE, Buffering = 1), e por isso o REPLACE que o Click legado
    * faz em outras linhas (MarcarLinhaComoImpressa no BO) funciona - cursor
    * de SQLEXEC direto seria somente-leitura.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

        THIS.AddObject("grd_4c_Dados", "Grid")

        THIS.grd_4c_Dados.ColumnCount  = 3
        THIS.grd_4c_Dados.RecordSource = loc_cCursor

        WITH THIS.grd_4c_Dados
            .Top           = 85
            .Left          = 12
            .Width         = 346
            .Height        = 212
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)

            .Column1.AddObject("Check1", "CheckBox")
            .Column1.Check1.Caption  = ""
            .Column1.Check1.Value    = 0
            .Column1.CurrentControl  = "Check1"
            .Column1.Sparse          = .F.
            .Column1.ReadOnly        = .F.
            .Column1.Width           = 40
            .Column1.ControlSource   = loc_cCursor + ".Marca"
            .Column1.Header1.Caption = ""

            .Column2.ControlSource     = loc_cCursor + ".Obs"
            .Column2.Width             = 206
            .Column2.ReadOnly          = .T.
            .Column2.Header1.Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"

            .Column3.ControlSource     = loc_cCursor + ".Valos"
            .Column3.Width             = 100
            .Column3.ReadOnly          = .T.
            .Column3.Alignment         = 3
            .Column3.Text1.InputMask   = "999,999,999.99"
            .Column3.Header1.Caption   = "Valor"
            .Column3.Header1.Alignment = 2

            .Visible = .T.
        ENDWITH

        *-- Click do checkbox da coluna 1 (SIGOPIGM.Grd.Column1.Check1.Click
        *-- do legado). Os quatro eventos sao obrigatorios: MouseDown e Click
        *-- existem para SUPRIMIR o toggle nativo (NODEFAULT) e evitar
        *-- alternancia dupla, MouseUp redireciona para o KeyPress e o
        *-- KeyPress e quem de fato altera o cursor. Ligados DEPOIS do
        *-- AddObject do Check1 - BINDEVENT valida o alvo e o delegate NA HORA
        *-- DO BIND. Os quatro delegates sao PUBLIC (metodo PROTECTED falha em
        *-- SILENCIO no BINDEVENT - regra CLAUDE.md #3).
        BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "KeyPress",  THIS, "ChkMarcaKeyPress")
        BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "MouseUp",   THIS, "ChkMarcaMouseUp")
        BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "MouseDown", THIS, "ChkMarcaMouseDown")
        BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "Click",     THIS, "ChkMarcaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - os QUATRO CommandButton que o legado tem como filhos
    * DIRETOS do form (dump, SECAO 1: "Parent: SIGOPIGM / Class: fwbtng /
    * BaseClass: commandbutton"). Nao ha CommandGroup no legado - sao quatro
    * botoes avulsos, e agrupa-los num cmg_4c_* inventaria estrutura que o
    * SCX nao tem (PILAR 1).
    *
    * Geometria, Caption, Picture, TabIndex e ToolTipText TRANSCRITOS do dump
    * (SECAO 2), um bloco por botao - todos Top=3, Height=75, Width=75,
    * encostados a direita em passo de 75px:
    *
    *   objeto legado | Left | Caption      | Picture                        | TabIndex
    *   btnBoleto     |  499 | "\<Boleto"   | geral_boleto_60.jpg            |    2
    *   Imprimir      |  574 | "\<Imprimir" | geral_impressora_normal_60.jpg |    2
    *   Grade         |  649 | "\<Grade"    | geral_selecionar_60.jpg        |    3
    *   Sair          |  724 | "Sair"       | cadastro_sair_60.jpg           |    4
    *
    * O "\<" dos tres primeiros Caption e o marcador de tecla de acesso do
    * VFP (ALT+B / ALT+I / ALT+G): preservado LITERALMENTE, porque remove-lo
    * tiraria o atalho de teclado que o usuario do legado tem (PILAR 1).
    *
    * Picture copiada do dump, NUNCA escolhida por semelhanca semantica
    * (regra CLAUDE.md #25): "Grade" usa geral_selecionar_60.jpg e nao uma
    * grade/lupa, e "Imprimir" usa geral_impressora_normal_60.jpg e nao
    * relatorio_impressora_26.jpg. Os quatro arquivos foram conferidos em
    * vbmp\ - .Picture apontando para arquivo inexistente falha em SILENCIO.
    *
    * Themes = .T. + DisabledPicture: standalone CommandButton COM Picture
    * nao desenha o icone com Themes = .F. quando fica Enabled = .F.
    * (CorretorAutomatico #99) - e estes tres botoes de acao sao desabilitados
    * durante a impressao em lote (Fase 8). O resto do visual e o canonico da
    * classe fwbtng do framework.vcx (FontName "Comic Sans MS", FontBold e
    * FontItalic .T., FontSize 8, ForeColor 90,90,90, BackColor 255,255,255,
    * MousePointer 15, WordWrap .T.) + PicturePosition 13 e SpecialEffect 0.
    *
    * Cancel = .T. em Sair vem do dump e e o que faz ESC fechar o dialogo -
    * sem ele a tela nao tem saida pelo teclado, porque TitleBar = 0 e
    * ControlBox = .F.
    *
    * Os quatro BINDEVENT ficam no FIM deste metodo, depois de todos os
    * AddObject: BINDEVENT valida o delegate NA HORA DO BIND e estoura
    * "Property <handler> is not found" se o metodo nao existir, derrubando o
    * InicializarForm inteiro - os quatro handlers (BtnBoletoClick,
    * BtnImprimirClick, BtnGradeClick, BtnSairClick) estao definidos nesta
    * mesma classe, logo abaixo. O KeyPress do form NAO usa BINDEVENT: e
    * evento nativo de Form e esta sobrescrito como metodo (o legado chama
    * Imprimir.Click/Grade.Click em F2/F3).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            *-- btnBoleto: Visible e decidido por AjustarVisibilidadeBoleto(),
            *-- que roda DEPOIS de TornarControlesVisiveis()
            THIS.AddObject("cmd_4c_BtnBoleto", "CommandButton")
            WITH THIS.cmd_4c_BtnBoleto
                .Top             = 3
                .Left            = 499
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Boleto"
                .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
                .Themes          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .TabIndex        = 2
                .ToolTipText     = "[F2] Imprimir"
            ENDWITH

            THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
            WITH THIS.cmd_4c_Imprimir
                .Top             = 3
                .Left            = 574
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Imprimir"
                .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .Themes          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .TabIndex        = 2
                .ToolTipText     = "[F2] Imprimir"
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Grade", "CommandButton")
            WITH THIS.cmd_4c_Grade
                .Top             = 3
                .Left            = 649
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Grade"
                .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_selecionar_60.jpg"
                .Themes          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .TabIndex        = 3
                .ToolTipText     = "[F3] Grade"
                .Visible         = .T.
            ENDWITH

            *-- Cancel = .T. (do dump): com TitleBar = 0 e ControlBox = .F.,
            *-- este botao e o ESC sao a UNICA saida do dialogo
            THIS.AddObject("cmd_4c_Sair", "CommandButton")
            WITH THIS.cmd_4c_Sair
                .Top             = 3
                .Left            = 724
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Themes          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .TabIndex        = 4
                .Cancel          = .T.
                .ToolTipText     = "[ESC] Sair"
                .Visible         = .T.
            ENDWITH

            *-- Um BINDEVENT por botao do legado, na ordem do dump. Todos os
            *-- quatro delegates sao PUBLIC (sem PROTECTED): metodo PROTECTED
            *-- falha em SILENCIO no BINDEVENT (regra CLAUDE.md #3).
            BINDEVENT(THIS.cmd_4c_BtnBoleto, "Click", THIS, "BtnBoletoClick")
            BINDEVENT(THIS.cmd_4c_Imprimir,  "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmd_4c_Grade,     "Click", THIS, "BtnGradeClick")
            BINDEVENT(THIS.cmd_4c_Sair,      "Click", THIS, "BtnSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpIgm.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarVisibilidadeBoleto - a ULTIMA linha do Init legado:
    *
    *   ThisForm.btnBoleto.Visible = Inlist(crSigOpCdc.VenBols, 1, 3)
    *
    * O criterio mora no BO (DeveExibirBotaoBoleto, que le this_nVenBols
    * alimentado por CarregarConfiguracaoOperacao) - aqui o form apenas
    * espelha a decisao no controle.
    *
    * Roda DEPOIS de TornarControlesVisiveis(), senao o Visible = .T. que
    * aquela varredura forca em TODO controle apagaria esta decisao - e o
    * botao Boleto apareceria em Operacao que nao emite boleto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarVisibilidadeBoleto()
        IF PEMSTATUS(THIS, "cmd_4c_BtnBoleto", 5)
            THIS.cmd_4c_BtnBoleto.Visible = ;
                THIS.this_oBusinessObject.DeveExibirBotaoBoleto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Form wrapper de SigOpIgmBO.Buscar(), que encadeia
    * CarregarMovimentacoes() (Select + Scan/Insert do Init legado) e
    * CarregarConfiguracaoOperacao() (os CursorQuery de SigOpCdc/SigCdOpe/
    * SigOpCdd). Devolve .F. quando nao ha nenhuma movimentacao a autenticar
    * - o legado fecha o dialogo nesse caso ("If Reccount()=0 /
    * ThisForm.Release / Return .F." do Init) sem exibir mensagem nenhuma;
    * quem decide fechar aqui e o chamador (InicializarForm), que usa este
    * retorno para reprovar a propria instanciacao - mesmo efeito pratico.
    *
    * Bypass por gb_4c_ModoTeste/gb_4c_ValidandoUI no mesmo espirito de
    * FormSigOpIbo.CarregarImpressoras: o harness (TesteAutomatico.prg, o
    * TestFormWrapper da etapa 06_testForm) instancia o form sem conexao SQL
    * alcancavel - sem o bypass, SQLEXEC (dentro do BO) falha, este metodo
    * devolveria .F. e InicializarForm reprovaria o form por falta de
    * conexao, nao por defeito de migracao.
    *
    * GO TOP + grd_4c_Dados.Refresh() ao final: popular o cursor NAO repinta
    * a grade sozinha (regra CLAUDE.md #21/#21a). Nao ha RecordSource/
    * ControlSource para repetir aqui - CarregarMovimentacoes() do BO
    * esvazia o cursor com ZAP (nunca fecha/recria o alias), entao o bind da
    * Column1.Check1 posto por ConfigurarGrid() sobrevive (regra #41).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cCursor

        DO CASE
            CASE TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
                *-- Harness: sem conexao, sem SQL. O cursor ja existe (vazio),
                *-- criado por CriarCursorMovimentacoes() em InicializarForm.
                loc_lSucesso = .T.

            CASE TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.

            OTHERWISE
                loc_lSucesso = THIS.this_oBusinessObject.Buscar()
        ENDCASE

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria todo controle com
    * Visible = .F.; este metodo percorre a arvore e os torna visiveis.
    *
    * Nao ha lista de excecao aqui: o unico controle de visibilidade
    * condicional do legado e o botao Boleto
    * (ThisForm.btnBoleto.Visible = Inlist(crSigOpCdc.VenBols, 1, 3), no fim
    * do Init), que nasce na Fase 8. O ajuste dele roda DEPOIS desta varredura
    * - chamado ao final de InicializarForm -, senao o Visible = .T. forcado
    * aqui apagaria a decisao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - PROCEDURE KeyPress do form legado, transcrito:
    *
    *   LPARAMETERS nKeyCode, nShiftAltCtrl
    *   Do Case
    *       Case nKeyCode = -1 && F2
    *           NoDefault
    *           ThisForm.Imprimir.Click()
    *       Case nKeyCode = -2 && F3
    *           NoDefault
    *           ThisForm.Grade.Click()
    *   EndCase
    *
    * Os codigos -1 (F2) e -2 (F3) sao TRANSCRITOS do dump, nao convertidos:
    * sao os codigos que o VFP9 entrega em KeyPress para teclas de funcao, e
    * sao os mesmos que os ToolTipText dos botoes anunciam ("[F2] Imprimir",
    * "[F3] Grade"). NAO sao os 115/116 da regra CLAUDE.md para F4/F5 em
    * TextBox - aqui e o KeyPress do FORM. Mesmo par ja migrado em
    * FormSigOpAut.KeyPress, irmao direto deste dialogo.
    *
    * KeyPreview = .T. (propriedade da classe, vinda do dump) e o que faz a
    * tecla chegar aqui ANTES de qualquer controle filho - sem ela a grade
    * consumiria F2/F3 e este metodo nunca rodaria.
    *
    * NODEFAULT antes da chamada, como no legado: impede o VFP de repassar a
    * tecla ao controle que tem o foco depois de a acao ter sido disparada.
    *
    * Nao ha DODEFAULT(): FormBase nao define KeyPress, logo nao ha
    * comportamento herdado a encadear (conferido em classes\formbase.prg).
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        DO CASE
            CASE par_nKeyCode = -1 && F2
                NODEFAULT
                THIS.BtnImprimirClick()

            CASE par_nKeyCode = -2 && F3
                NODEFAULT
                THIS.BtnGradeClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGradeClick - cmd_4c_Grade.Click. Legado (Grade.Click), uma linha:
    *
    *   Thisform.Grd.Column1.Setfocus
    *
    * Leva o foco para a coluna do checkbox, que e o que o usuario precisa
    * para marcar/desmarcar movimentacoes pelo teclado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnGradeClick()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Column1.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - cmd_4c_Sair.Click. Legado (Sair.Click), uma linha:
    *
    *   ThisForm.Release
    *
    * O legado NAO exige nada antes de sair (ao contrario do irmao SigOpAut,
    * que bloqueia a saida enquanto ha linha nao autenticada): aqui a
    * impressao e opcional e o dialogo fecha a qualquer momento. Nao inventar
    * validacao de saida que o legado nao tem.
    *
    * O botao tem Cancel = .T. (do dump), entao o ESC cai neste mesmo
    * handler - e, com TitleBar = 0 e ControlBox = .F., este e o UNICO
    * caminho de saida da tela.
    *
    * Guarda de lote: sair no meio da varredura deixaria dialogos filhos
    * orfaos e o cursor da grade a meio caminho - o aviso explica em vez de
    * ignorar o clique em silencio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        IF THIS.this_lProcessandoLote
            MsgAviso("Aguarde o t" + CHR(233) + "rmino da impress" + CHR(227) + ;
                "o em andamento.", "Aten" + CHR(231) + CHR(227) + "o")
        ELSE
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - cmd_4c_Imprimir.Click. Legado (Imprimir.Click):
    *
    *   Local lOk / lOk = .f.
    *   If Reccount("csPgto") <=0
    *       MessageBox("Nao existem observacoes a serem auteticadas",16,"")
    *       ThisForm.Sair.Setfocus
    *   EndIf
    *   Select csPgto
    *   Scan
    *       If csPgto.marca
    *           If (CsPgto.docus = 1)
    *               =...cursorquery('SigCdOpe','CrSigCdOpe','dopes',TprMvCab.Dopes)
    *               =...CursorQuery('SigOpCdc','CrSigOpCdc','Dopes',TprMvCab.Dopes)
    *               DO SigPrIdc with CsPgto.Emps, CsPgto.Dopes, CsPgto.Numes,
    *                   CsPgto.valdevs, crSigOpCdc.QtdDocs, .F., .F., .F., .F.,
    *                   crSigOpCdc.TpImpDocs, .F., Thisform, ThisForm.pChkImpDoc
    *           EndIf
    *           If InList(CsPgto.Docus, 3, 4)
    *               Do Form SigReIfx With CsPgto.Emps, CsPgto.Dopes,
    *                   CsPgto.Numes, CrSigOpCdc.TpImpDocs, ThisForm.pChkImpDoc
    *           EndIf
    *           Select csPgto
    *           Replace csPgto.marca with .f., csPgto.Printed with .t.
    *       EndIf
    *   EndScan
    *
    * Quatro pontos em que esta versao NAO e copia literal, cada um medido:
    *
    * 1. O "lOk" do legado e declarado, zerado e NUNCA LIDO neste Click (so
    *    no irmao SigOpAut ele recebe o retorno de Autentica()). Nao se
    *    transcreve variavel morta - seria codigo sem efeito.
    *
    * 2. O aviso de cursor vazio NAO interrompe o fluxo, igual ao legado: o
    *    If nao tem Return, so mostra a mensagem e tenta focar o Sair; o
    *    laco seguinte nao itera nada num cursor vazio. MESSAGEBOX(...,16,...)
    *    -> MsgAviso (MESSAGEBOX e proibido no projeto, e 16 era so o icone).
    *
    * 3. SCAN trocado por laco explicito por NUMERO DE REGISTRO. O SCAN depende
    *    da area de trabalho CORRENTE continuar sendo o cursor da grade de uma
    *    iteracao para a outra, e aqui cada iteracao abre um dialogo filho:
    *    FormSigOpIbo tem DataSession = 2 mas ENTRA na datasession do chamador
    *    de proposito (EntrarDataSessionChamador/RestaurarDataSession) para ler
    *    o cursor dele, ou seja PODE deixar outra area selecionada. Com SELECT
    *    + GO explicitos a varredura fica imune a isso. O cursor nasce de
    *    CREATE CURSOR alimentado por ZAP + INSERT, sem DELETE nenhum, entao
    *    RECCOUNT e a contagem real e GO <n> alcanca toda linha (regra
    *    CLAUDE.md "RECCOUNT conta registro excluido" nao morde aqui).
    *
    * 4. O "TprMvCab.Dopes" dos dois cursorquery do legado e um ALIAS QUE NAO
    *    EXISTE (o cursor da consulta do Init chama-se CrTprMvCab) - a
    *    divergencia deliberada e o filtro pelo Dopes da LINHA corrente, e
    *    esta documentada em SigOpIgmBO.ImprimirDocumentoDaLinha, que e quem
    *    faz essa recarga. Pela mesma razao o ramo Docus in (3,4) tambem le o
    *    TpImpDocs recarregado para o Dopes DA LINHA, em vez de depender do
    *    que sobrou em crSigOpCdc de uma iteracao anterior (no legado o valor
    *    lido ali varia com a ORDEM das linhas, o que e artefato de cursor
    *    estagnado, nao regra de negocio).
    *
    * Nao ha TRY em volta do laco, de proposito: cada linha e despachada por
    * ImprimirLinhaCorrente(), que abre dialogo MODAL - Show() de form modal
    * com um CATCH em QUALQUER ponto da pilha faz o erro de runtime do filho
    * saltar para esse CATCH e FECHAR a tela filha (regra CLAUDE.md #29). Os
    * erros continuam reportados: os metodos do BO (ImprimirDocumentoDaLinha,
    * MarcarLinhaComoImpressa) tem TRY/CATCH com MsgErro proprios, e a
    * criacao do dialogo filho e protegida dentro de ImprimirLinhaCorrente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oBO, loc_cCursor, loc_nTotal, loc_nRec

        *-- RETURN de guarda ANTES de qualquer TRY (regra CLAUDE.md #1)
        IF THIS.this_lProcessandoLote
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("SigOpIgmBO n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
                CHR(237) + "vel.", "Erro")
            RETURN
        ENDIF

        loc_oBO     = THIS.this_oBusinessObject
        loc_cCursor = loc_oBO.this_cCursorGrade

        *-- Legado: If Reccount("csPgto") <= 0 -> aviso + foco no Sair, SEM
        *-- interromper (o laco abaixo simplesmente nao itera). O retorno e
        *-- deliberadamente IGNORADO aqui, igual ao legado
        THIS.ValidarLoteImpressao("Impress" + CHR(227) + "o")

        IF USED(loc_cCursor)
            THIS.this_lProcessandoLote = .T.
            THIS.AjustarBotoesPorModo()

            loc_nTotal = RECCOUNT(loc_cCursor)

            FOR loc_nRec = 1 TO loc_nTotal
                *-- Reposiciona a CADA volta: o dialogo filho da iteracao
                *-- anterior pode ter trocado a area de trabalho corrente
                SELECT (loc_cCursor)
                GO loc_nRec

                *-- Legado: "If csPgto.marca" - so a linha MARCADA imprime.
                *-- CarregarDoCursor NAO move o ponteiro (so SELECT + leitura
                *-- dos campos), por isso pode ser chamado dentro do laco.
                IF loc_oBO.CarregarDoCursor(loc_cCursor) AND loc_oBO.this_lLinhaMarca
                    THIS.ImprimirLinhaCorrente()
                ENDIF
            ENDFOR

            THIS.this_lProcessandoLote = .F.
            THIS.AjustarBotoesPorModo()

            *-- Popular/alterar o cursor NAO repinta a grade (regra CLAUDE.md
            *-- #21): sem isto as linhas seguem exibidas como marcadas
            SELECT (loc_cCursor)
            GO TOP
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirLinhaCorrente - corpo do "If csPgto.marca" do Imprimir.Click
    * legado, para UMA linha ja posicionada e ja lida para o BO.
    *
    * Esta separado de BtnImprimirClick por causa da regra CLAUDE.md #29: o
    * ramo Docus in (3,4) abre um dialogo MODAL, e o Show() dele nao pode
    * ter CATCH algum na pilha. Aqui o TRY cobre SO o CREATEOBJECT e o
    * Show() fica FORA dele - padrao canonico de Formepd.BtnOperacaoClick.
    *
    * Os dois ramos do legado NAO sao exclusivos por construcao, sao
    * exclusivos pelos DADOS: a consulta do Init filtra "b.Docus in(1,3,4)",
    * e Docus e uma coluna so. Por isso ficam como dois IF independentes,
    * como no legado, e nao como DO CASE.
    *
    * Docus = 1  -> documento de caixa (DO SigPrIdc), no BO
    * Docus 3/4  -> Formsigreifx (o "Do Form SigReIfx" legado)
    *
    * O Replace final do legado ("csPgto.marca with .f., csPgto.Printed with
    * .t.") roda SEMPRE que a linha estava marcada, inclusive quando nenhum
    * dos dois ramos imprimiu - e MarcarLinhaComoImpressa() que o reproduz,
    * fazendo o SELECT do cursor antes do REPLACE, exatamente como o
    * "Select csPgto" que o legado tem ali.
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirLinhaCorrente()
        LOCAL loc_oBO, loc_oFormIfx, loc_oErro

        loc_oBO      = THIS.this_oBusinessObject
        loc_oFormIfx = .NULL.

        *-- Legado: If (CsPgto.docus = 1) -> DO SigPrIdc with ...
        *-- O BO recarrega SigCdOpe/SigOpCdc pelo Dopes desta linha (os dois
        *-- cursorquery do legado) e tem TRY/CATCH + MsgErro proprios.
        IF loc_oBO.this_nLinhaDocus = 1
            loc_oBO.ImprimirDocumentoDaLinha(THIS)
        ENDIF

        *-- Legado: If InList(CsPgto.Docus, 3, 4) -> Do Form SigReIfx With ...
        IF INLIST(loc_oBO.this_nLinhaDocus, 3, 4)
            *-- crSigOpCdc.TpImpDocs do legado: recarregado para o Dopes DESTA
            *-- linha (ver ponto 4 do cabecalho de BtnImprimirClick)
            loc_oBO.CarregarConfiguracaoOperacao(loc_oBO.this_cLinhaDopes)

            *-- CREATEOBJECT, NUNCA "DO FORM": no projeto novo os forms sao
            *-- DEFINE CLASS em .prg e nao existe SigReIfx.scx - o DO FORM
            *-- transcrito do legado estouraria "File 'sigreifx.scx' does not
            *-- exist" e o dialogo nunca abriria. Os cinco argumentos estao na
            *-- MESMA ordem do Init de Formsigreifx
            *-- (par_cEmp, par_cDop, par_nNum, par_nImp, par_lChkImpDoc).
            TRY
                loc_oFormIfx = CREATEOBJECT("Formsigreifx", ;
                    loc_oBO.this_cLinhaEmps, ;
                    loc_oBO.this_cLinhaDopes, ;
                    loc_oBO.this_nLinhaNumes, ;
                    loc_oBO.this_nTpImpDocs, ;
                    THIS.this_lChkImpDoc)
            CATCH TO loc_oErro
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a impress" + ;
                    CHR(227) + "o fiscal da movimenta" + CHR(231) + CHR(227) + "o " + ;
                    ALLTRIM(loc_oBO.this_cLinhaObs) + ":" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Imprimir")
                loc_oFormIfx = .NULL.
            ENDTRY

            *-- Show() FORA do TRY (regra CLAUDE.md #29). VARTYPE tambem cobre
            *-- o caso legitimo em que Formsigreifx se auto-executa e o Init
            *-- devolve .F. de proposito (o relatorio ja saiu, nao ha tela)
            IF VARTYPE(loc_oFormIfx) = "O"
                loc_oFormIfx.Show()
            ENDIF
        ENDIF

        *-- Legado: Select csPgto / Replace csPgto.marca with .f.,
        *--         csPgto.Printed with .t.
        loc_oBO.MarcarLinhaComoImpressa()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBoletoClick - cmd_4c_BtnBoleto.Click. Legado (btnBoleto.Click):
    *
    *   Local lOk, lnTpB / lOk = .f.
    *   If Reccount("csPgto") <=0
    *       MessageBox("Nao existem observacoes a serem auteticadas",16,"")
    *       ThisForm.Sair.Setfocus
    *   EndIf
    *   Select csPgto
    *   Scan
    *       lnTpB = 0
    *       =...CursorQuery('SigOpCdc','crSigOpCdc','Dopes',ThisForm.Movimentacao)
    *       Do Case ... EndCase            && resolve lnTpB
    *       If (lnTpB > 0)
    *           Do Form SigOpIbo With Thisform.Parentform, lnTpB,, csPgto.Emps,
    *               csPgto.Dopes, csPgto.Numes, 0, crSigOpCdc.qvias,
    *               crSigOpCdc.qtdbols
    *       EndIf
    *   EndScan
    *
    * Tres diferencas em relacao ao Imprimir, TODAS fieis ao legado e todas
    * faceis de "corrigir" por engano:
    *
    * 1. NAO ha "If csPgto.marca": o laco do boleto percorre TODAS as linhas,
    *    marcadas ou nao. Acrescentar o filtro mudaria o que o usuario
    *    recebe.
    * 2. NAO ha Replace no fim: nenhuma linha e marcada como impressa, logo
    *    clicar Boleto duas vezes emite duas vezes - e o comportamento do
    *    legado.
    * 3. O CursorQuery usa ThisForm.Movimentacao (a operacao de ORIGEM do
    *    dialogo), NAO o Dopes da linha. Transcrito literalmente: aqui o
    *    legado e deliberado, e so o Imprimir filtra por linha.
    *
    * O Do Case que resolve lnTpB foi transcrito integralmente para
    * SigOpIgmBO.ResolverTipoBoleto (os valores 11/13/14/17/16/18/3 sao os
    * tipos que FormSigOpIbo espera e nao se renumeram), e a guarda
    * "If (lnTpB > 0)" continua aqui.
    *
    * Laco por numero de registro e ausencia de TRY em volta dele: mesmos
    * motivos dos pontos 3 e 4 do cabecalho de BtnImprimirClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBoletoClick()
        LOCAL loc_oBO, loc_cCursor, loc_nTotal, loc_nRec

        *-- RETURN de guarda ANTES de qualquer TRY (regra CLAUDE.md #1)
        IF THIS.this_lProcessandoLote
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("SigOpIgmBO n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
                CHR(237) + "vel.", "Erro")
            RETURN
        ENDIF

        loc_oBO     = THIS.this_oBusinessObject
        loc_cCursor = loc_oBO.this_cCursorGrade

        *-- Legado: mesmo aviso do Imprimir, tambem SEM interromper o fluxo
        THIS.ValidarLoteImpressao("Boleto")

        IF USED(loc_cCursor)
            THIS.this_lProcessandoLote = .T.
            THIS.AjustarBotoesPorModo()

            loc_nTotal = RECCOUNT(loc_cCursor)

            FOR loc_nRec = 1 TO loc_nTotal
                SELECT (loc_cCursor)
                GO loc_nRec

                *-- Sem "If csPgto.marca" (ponto 1 do cabecalho)
                IF loc_oBO.CarregarDoCursor(loc_cCursor)
                    THIS.EmitirBoletoLinhaCorrente()
                ENDIF
            ENDFOR

            THIS.this_lProcessandoLote = .F.
            THIS.AjustarBotoesPorModo()

            SELECT (loc_cCursor)
            GO TOP
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EmitirBoletoLinhaCorrente - corpo do Scan do btnBoleto.Click legado,
    * para UMA linha ja posicionada e ja lida para o BO.
    *
    * Separado de BtnBoletoClick pelo mesmo motivo de
    * ImprimirLinhaCorrente: FormSigOpIbo e MODAL, e o Show() de form modal
    * nao pode ter CATCH na pilha (regra CLAUDE.md #29). TRY cobre so o
    * CREATEOBJECT.
    *
    * Argumentos, na ordem do Init de FormSigOpIbo (par_oFormChamador,
    * par_nTpBol, par_cTitEnvelope, par_cEmp, par_cDope, par_nNum, par_nDev,
    * par_nVias, par_nQBols, par_cCursor):
    *
    *   legado                      | aqui
    *   Thisform.Parentform         | THIS.this_oFormPai
    *   lnTpB                       | loc_nTpBol (ResolverTipoBoleto no BO)
    *   <omitido>                   | "" - SigOpIboBO.DefinirTipoBoleto faz
    *                                 IIF(VARTYPE(x) = "C", x, ""), logo ""
    *                                 e EXATAMENTE o que o parametro ausente
    *                                 produz; "" evita depender de omissao
    *                                 posicional em CREATEOBJECT
    *   csPgto.Emps/.Dopes/.Numes   | this_cLinhaEmps/.._cLinhaDopes/.._nLinhaNumes
    *   0                           | 0 (pnDev)
    *   crSigOpCdc.qvias/.qtdbols   | this_nQvias / this_nQtdBols
    *   <nao passado: pCursor>      | nao passado (o legado para no 9o)
    *
    * this_oFormPai pode ser .NULL. (dialogo instanciado sem form pai): o
    * Init de FormSigOpIbo ja guarda com PCOUNT() + VARTYPE(...) = "O" e
    * ignora, sem erro.
    *--------------------------------------------------------------------------
    PROCEDURE EmitirBoletoLinhaCorrente()
        LOCAL loc_oBO, loc_nTpBol, loc_oFormIbo, loc_oErro

        loc_oBO      = THIS.this_oBusinessObject
        loc_oFormIbo = .NULL.

        *-- Legado, dentro do Scan: lnTpB = 0 + CursorQuery('SigOpCdc', ...,
        *-- ThisForm.Movimentacao) - a operacao de ORIGEM, nao a da linha
        *-- (ponto 3 do cabecalho de BtnBoletoClick)
        loc_oBO.CarregarConfiguracaoOperacao(THIS.this_cMovimentacao)

        *-- Do Case INTEIRO do legado, transcrito no BO
        loc_nTpBol = loc_oBO.ResolverTipoBoleto()

        *-- Legado: If (lnTpB > 0)
        IF loc_nTpBol > 0
            TRY
                loc_oFormIbo = CREATEOBJECT("FormSigOpIbo", ;
                    THIS.this_oFormPai, ;
                    loc_nTpBol, ;
                    "", ;
                    loc_oBO.this_cLinhaEmps, ;
                    loc_oBO.this_cLinhaDopes, ;
                    loc_oBO.this_nLinhaNumes, ;
                    0, ;
                    loc_oBO.this_nQvias, ;
                    loc_oBO.this_nQtdBols)
            CATCH TO loc_oErro
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir o boleto da movimenta" + ;
                    CHR(231) + CHR(227) + "o " + ALLTRIM(loc_oBO.this_cLinhaObs) + ":" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Emitir Boleto")
                loc_oFormIbo = .NULL.
            ENDTRY

            *-- Show() FORA do TRY (regra CLAUDE.md #29)
            IF VARTYPE(loc_oFormIbo) = "O"
                loc_oFormIbo.Show()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - FUNIL unico Tela -> Business Object.
    *
    * Este dialogo NAO tem campo digitavel fora da grade: o dump legado tem
    * cntSombra (dois labels), a grade e quatro botoes, e nada mais. O que a
    * tela tem para entregar ao BO sao os CINCO dados que o Init legado
    * recebe por parametro e guarda em properties do form:
    *
    *   legado                  | aqui                | vai para o BO como
    *   _pEmps                  | this_cEmps          | this_cEmps
    *   _pDopes (Movimentacao)  | this_cMovimentacao  | this_cDopes
    *   _pNumes                 | this_nNumes         | this_nNumes
    *   _pChkImpDoc             | this_lChkImpDoc     | this_lChkImpDoc
    *   _pBol (Boleto)          | this_nBoleto        | this_nBoleto
    *
    * O BO monta internamente lcEDN = Emps + Dopes + Str(Numes, 6), a chave
    * POSICIONAL de 29 chars (3 + 20 + 6) usada no WHERE da carga - por isso
    * os valores seguem com o padding da coluna, sem ALLTRIM (regra
    * CLAUDE.md #42).
    *
    * poform NAO vai para o BO: fica no form (this_oFormPai), que e quem
    * abre os dialogos filhos e devolve o foco no Destroy.
    *
    * As tres colunas da grade NAO passam por aqui - elas se ligam ao cursor
    * por ControlSource, e a leitura da LINHA corrente para o BO e
    * SigOpIgmBO.CarregarDoCursor(), chamado dentro dos lacos de
    * BtnImprimirClick/BtnBoletoClick a cada volta.
    *
    * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE FormParaBO"
    * e o VFP9 NAO deixa a subclasse ALARGAR o escopo herdado - escrever
    * "PROCEDURE FormParaBO" aqui deixaria o metodo protegido do mesmo jeito
    * e mentiria para quem le.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lOk, loc_oBO, loc_oErro
        loc_lOk = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                loc_oBO.DefinirParametros( ;
                    THIS.this_cEmps, ;
                    THIS.this_cMovimentacao, ;
                    THIS.this_nNumes, ;
                    THIS.this_lChkImpDoc, ;
                    THIS.this_nBoleto)

                loc_lOk = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpIgm.FormParaBO")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - FUNIL unico Business Object -> Tela, sentido inverso.
    *
    * Reune o que a tela EXIBE a partir de decisao do BO:
    *
    *   1. Visibilidade do botao Boleto - a ULTIMA linha do Init legado
    *      (ThisForm.btnBoleto.Visible = Inlist(crSigOpCdc.VenBols, 1, 3)),
    *      delegada a AjustarVisibilidadeBoleto()/DeveExibirBotaoBoleto().
    *   2. Estado dos botoes de acao (AjustarBotoesPorModo).
    *   3. Repintar a grade: popular/alterar cursor NAO repinta sozinho
    *      (regra CLAUDE.md #21).
    *
    * As linhas da grade NAO sao reescritas a partir das properties
    * this_*Linha* do BO: elas sao uma FOTO da linha corrente (leitura), e
    * quem desenha as linhas e o ControlSource de cada Column ligado ao
    * proprio cursor. Reescrever o cursor a partir da foto sobrescreveria
    * as outras linhas com a corrente.
    *
    * Tem de rodar DEPOIS de TornarControlesVisiveis() - a varredura forca
    * Visible = .T. em TODO controle e apagaria o item 1.
    *
    * PROTECTED EXPLICITO pela mesma razao de FormParaBO acima.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lOk, loc_oBO, loc_cCursor, loc_oErro
        loc_lOk = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                THIS.AjustarVisibilidadeBoleto()
                THIS.AjustarBotoesPorModo()

                loc_cCursor = loc_oBO.this_cCursorGrade
                IF USED(loc_cCursor) AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    SELECT (loc_cCursor)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF

                loc_lOk = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpIgm.BOParaForm")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - reflete na tela a guarda this_lProcessandoLote.
    *
    * Este dialogo NAO tem modo de edicao (nao ha INCLUIR/ALTERAR/
    * VISUALIZAR/EXCLUIR: nao grava registro nenhum, nao tem Page2 de Dados
    * e nao tem botao CRUD). O unico "modo" que existe e o que o legado
    * tambem tem na pratica: lote de impressao em andamento ou nao.
    *
    * No legado o laco e os dialogos filhos vivem na mesma pilha BLOQUEADA
    * do SCX modal, entao nao ha como clicar nada durante o lote. Aqui a
    * guarda this_lProcessandoLote (ver a declaracao dela) ja impedia a
    * reentrancia por F2/F3; este metodo so a torna VISIVEL, desabilitando
    * os tres botoes de acao - nao e comportamento novo, e a mesma decisao.
    *
    * Os tres botoes nascem com Themes = .T. + DisabledPicture apontando
    * para a MESMA imagem (ver ConfigurarBotoes): standalone CommandButton
    * com Picture nao desenha o icone com Themes = .F. quando fica
    * Enabled = .F. Nenhum deles e icone-only (todos tem Caption), que e o
    * caso em que Enabled = .F. apagaria o icone de qualquer jeito.
    *
    * Sair fica SEMPRE habilitado: com TitleBar = 0 e ControlBox = .F. ele e
    * a UNICA saida da tela, e quem recusa a saida no meio do lote e o
    * proprio BtnSairClick, com aviso - desabilitar o botao deixaria o
    * usuario sem explicacao nenhuma.
    *
    * Visible NAO e tocado aqui: a do botao Boleto e decidida por
    * AjustarVisibilidadeBoleto() a partir do VenBols da Operacao.
    *
    * PUBLIC (sem PROTECTED) porque o harness de teste automatizado chama
    * AjustarBotoesPorModo direto no objeto do form, de FORA da classe -
    * PEMSTATUS(oForm, "Metodo", 5) responde "existe?", nao "da para chamar
    * daqui?", entao PROTECTED falharia em runtime (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lLiberado

        loc_lLiberado = !THIS.this_lProcessandoLote

        IF PEMSTATUS(THIS, "cmd_4c_BtnBoleto", 5)
            THIS.cmd_4c_BtnBoleto.Enabled = loc_lLiberado
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Imprimir", 5)
            THIS.cmd_4c_Imprimir.Enabled = loc_lLiberado
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Grade", 5)
            THIS.cmd_4c_Grade.Enabled = loc_lLiberado
        ENDIF

        *-- Sair permanece habilitado de proposito (ver cabecalho)
        THIS.HabilitarCampos(loc_lLiberado)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - o unico "campo" editavel deste dialogo e a coluna 1
    * da grade (o checkbox de marcacao); as colunas 2 e 3 nascem
    * ReadOnly = .T., reproduzindo o "Return .f." do When dos dois Text1 do
    * legado, e nao ha controle de entrada fora da grade.
    *
    * Com o lote em andamento a coluna e travada: marcar/desmarcar linha no
    * meio da varredura mudaria, por baixo do laco, o que ainda falta
    * imprimir.
    *
    * Column.ReadOnly e definido DEPOIS de Grid.ReadOnly (que este form nunca
    * altera, ficando no default .F.) - a ordem inversa faria o valor do
    * grid propagar e sobrescrever o da coluna.
    *
    * PUBLIC pelo mesmo motivo de AjustarBotoesPorModo.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lHabilitar
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLoteImpressao - FONTE UNICA do aviso de grade vazia.
    *
    * Legado, as duas primeiras linhas de Imprimir.Click E de
    * btnBoleto.Click (texto identico nos dois):
    *
    *   If Reccount("csPgto") <=0
    *       MessageBox("Nao existem observacoes a serem auteticadas",16,"")
    *       ThisForm.Sair.Setfocus
    *   EndIf
    *
    * O criterio e a mensagem moram em SigOpIgmBO.ValidarDados (inclusive a
    * grafia "auteticadas", que e a do original - trocar texto de mensagem
    * seria desvio do PILAR 1); aqui fica o que e de TELA: exibir o aviso e
    * mover o foco para o botao Sair.
    *
    * O legado NAO interrompe o fluxo neste If - nao ha Return - e os dois
    * handlers continuam ignorando este retorno de proposito: num cursor
    * vazio o laco seguinte simplesmente nao itera. O retorno existe para
    * quem precise da resposta sem o efeito colateral de ja ter comecado o
    * lote.
    *
    * MsgAviso no lugar do MESSAGEBOX(..., 16, ...): MESSAGEBOX e proibido no
    * projeto e o 16 era so o icone.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarLoteImpressao(par_cTitulo)
        LOCAL loc_lValido, loc_cTitulo, loc_cMensagem

        loc_lValido = .F.
        loc_cTitulo = IIF(VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo), ;
            par_cTitulo, "Impress" + CHR(227) + "o")

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lValido = THIS.this_oBusinessObject.ValidarDados()

            IF !loc_lValido
                loc_cMensagem = THIS.this_oBusinessObject.this_cMensagemErro

                IF VARTYPE(loc_cMensagem) != "C" OR EMPTY(loc_cMensagem)
                    loc_cMensagem = "N" + CHR(227) + "o existem observa" + CHR(231) + ;
                        CHR(245) + "es a serem auteticadas"
                ENDIF

                MsgAviso(loc_cMensagem, loc_cTitulo)

                *-- Legado: ThisForm.Sair.Setfocus
                IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
                    THIS.cmd_4c_Sair.SetFocus()
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaKeyPress - o Click do checkbox da coluna 1, transcrito:
    *
    *   PROCEDURE Click            && SIGOPIGM.Grd.Column1.Check1
    *   if !(csPgto.printed)
    *       This.value = .t.
    *   endif
    *
    * Semantica do legado, lida com o toggle NATIVO que roda ANTES do Click:
    *   linha NAO impressa -> qualquer clique resulta em MARCADA (o force
    *                         .t. desfaz o desmarcar);
    *   linha JA impressa   -> alterna normalmente, e e assim que o usuario
    *                         reimprime uma movimentacao (MarcarLinhaComoImpressa
    *                         deixa Marca = .F. e Printed = .T.).
    * Daqui a expressao IIF(!Printed, .T., !Marca), que produz exatamente a
    * mesma tabela sem depender do toggle nativo.
    *
    * CheckBox posto em Column por AddObject NAO alterna pelo binding
    * nativo: a celula renderiza o quadradinho, recebe foco e o clique nao
    * muda nada. Por isso o quarteto canonico - MouseDown/Click suprimem o
    * toggle padrao (NODEFAULT, evitando alternancia DUPLA), MouseUp
    * redireciona para ca e este metodo e o unico que escreve no cursor.
    *
    * Marca e LOGICA (csPgto.Marca L no Create Cursor legado), nao numerica:
    * por isso !Marca e nao IIF(Marca = 0, 1, 0).
    *
    * O REPLACE funciona porque o cursor nasce de CREATE CURSOR (READWRITE);
    * cursor de SQLEXEC direto seria somente-leitura e a celula nunca
    * entraria em edicao.
    *
    * Guarda de lote: durante a varredura a marcacao fica travada tambem por
    * HabilitarCampos(.F.) - esta checagem cobre o caminho do TECLADO, que o
    * ReadOnly da coluna nao impede quando a celula ja esta com o foco.
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor

        IF INLIST(par_nKeyCode, 13, 32)
            IF !THIS.this_lProcessandoLote AND VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade

                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)

                    IF RECCOUNT() > 0 AND !EOF()
                        REPLACE Marca WITH IIF(!Printed, .T., !Marca)
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDIF

            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaMouseUp - converte o clique do mouse na mesma acao do teclado,
    * para haver UM so lugar que escreve no cursor. NODEFAULT suprime o
    * toggle nativo que viria depois.
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ChkMarcaKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaMouseDown - existe SO para suprimir o toggle nativo; sem ele o
    * valor alternaria duas vezes (uma pelo VFP, outra pelo MouseUp acima) e
    * a marcacao pareceria nao responder ao clique.
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaClick - mesma funcao do MouseDown acima: suprimir o toggle
    * padrao. A acao do legado esta em ChkMarcaKeyPress, chamado pelo
    * MouseUp.
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaClick()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - devolve o foco ao form chamador e encadeia para
    * FormBase.Destroy(), que libera this_oBusinessObject (e e o BO quem
    * fecha os cursores que abriu) e restaura o menu principal.
    *
    * this_oFormPai e this_oModem NAO sao liberados aqui: pertencem a quem os
    * criou. Apenas as referencias deste form sao soltas.
    *
    * DODEFAULT() na ULTIMA linha e obrigatorio - sem ele FormBase.Destroy()
    * nao roda e os popups do menu principal ficam com o cache visual velho.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar FormSigOpIgm")
        ENDTRY

        THIS.this_oModem = .NULL.
        THIS.this_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
