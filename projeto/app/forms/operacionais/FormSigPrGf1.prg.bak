*==============================================================================
* FormSigPrGf1.prg - Form Operacional: Falha x Recuperacao por Mes
* Herda de: FormBase
* Tipo: OPERACIONAL (layout flat, sem PageFrame)
* Original: SIGPRGF1.SCX (Width=800, Height=158, TitleBar=0)
*==============================================================================

DEFINE CLASS FormSigPrGf1 AS FormBase

    *-- BO
    this_oBusinessObject = .NULL.

    *-- Caption (populado via PROMPT() em InicializarForm)
    this_cCaption = ""

    *-- Referencia ao form pai que abriu este form (opcional)
    *-- Setado externamente quando chamado por outro form (ex: movimentos)
    poForm1 = .NULL.

    *-- Propriedades visuais (PILAR 1: identico ao original SIGPRGF1)
    Width       = 800
    Height      = 158
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    BorderStyle = 2
    DataSession = 2

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ScrollBars = 0
        THIS.ShowTips   = .F.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual (chamado por FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Instanciar BO
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGf1BO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGf1BO.", "Erro")
            ELSE
                THIS.this_oBusinessObject.this_cEmpresa = go_4c_Sistema.cCodEmpresa

                *-- Caption a partir do menu corrente
                THIS.this_cCaption = PROMPT()
                THIS.Caption       = THIS.this_cCaption

                *-- Criar componentes (form OPERACIONAL layout flat sem PageFrame)
                THIS.ConfigurarPaginaLista()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- BINDEVENT: validacao interativa ao sair do campo DtFinal
                *-- (equivale ao getDtFinal.Valid do legado)
                BINDEVENT(THIS.txt_4c_DtFinal, "KeyPress", THIS, "TxtDtFinalKeyPress")

                *-- Tornar controles visiveis (cnt_4c_Aguarde permanece oculto)
                THIS.TornarControlesVisiveis()

                *-- Datas iniciais: primeiro dia do mes atual / ultimo dia do mes
                THIS.txt_4c_DtInicial.Value = CTOD("01/" + PADL(LTRIM(STR(MONTH(DATE()), 2)), 2, "0") + ;
                                                   "/" + LTRIM(STR(YEAR(DATE()), 4)))
                THIS.txt_4c_DtFinal.Value   = GOMONTH(THIS.txt_4c_DtInicial.Value, 1) - 1

                THIS.txt_4c_DtInicial.SetFocus

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Wrapper de montagem da tela unica (OPERACIONAL)
    * Original SIGPRGF1 NAO tem PageFrame nem Grid nem botoes CRUD (Incluir/
    * Alterar/Excluir/Buscar) ??? eh um painel de filtro (periodo) + Processar +
    * Encerrar. Este metodo agrega ConfigurarCabecalho + ConfigurarFiltros +
    * ConfigurarBotoes (CommandGroup Processar/Encerrar) + ConfigurarAguarde
    * mantendo o contrato esperado pela pipeline (PILAR 1: preservar UX legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarAguarde()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navegacao entre paginas
    * Form OPERACIONAL de tela unica (SIGPRGF1 sem PageFrame): unica "pagina"
    * util eh o painel de filtro. Metodo mantido para atender contrato da
    * pipeline (fase 4) e para permitir refoco/reset apos processamento.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
            THIS.txt_4c_DtInicial.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Contrato da pipeline (fase 5/6) para forms CRUD
    * O legado SIGPRGF1.SCX (Width=800, Height=158) NAO tem PageFrame nem
    * Page2 (Dados): eh um form OPERACIONAL flat com apenas painel de filtro
    * de periodo (getDtInicial + getDtFinal), CommandGroup Processar/Encerrar
    * e cntAguarde. Nao ha campos de edicao de registro, nao ha Grid CRUD.
    *
    * Todos os controles do form ja foram criados por ConfigurarPaginaLista()
    * nas fases 3-4 (cnt_4c_Cabecalho + cnt_4c_Aguarde + txt_4c_DtInicial +
    * txt_4c_DtFinal + lbl_4c_Periodo + cmg_4c_Processar). Este metodo eh
    * mantido como no-op documentado para atender o contrato de fases da
    * pipeline (que espera ConfigurarPaginaDados em todos os forms migrados).
    *
    * Se no futuro precisar adicionar campos de "detalhe" (segunda tela), a
    * implementacao seguiria o padrao AddObject aqui e a navegacao entre
    * paineis usaria .Visible = .T./.F. em containers filhos do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- No-op intencional: SIGPRGF1 eh OPERACIONAL flat (ver comentario acima).
        *-- Sem PageFrame => sem Page2 => sem campos de dados adicionais.
        *-- ConfigurarPaginaLista() ja montou 100% dos controles do form legado.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo (equivale ao cntSombra)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BackStyle  = 1
            .BackColor  = RGB(100,100,100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = THIS.this_cCaption
                .ForeColor = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = THIS.this_cCaption
                .ForeColor = RGB(255,255,255)
            ENDWITH

            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltros - Label de periodo + campos de data
    * Original: lbl_periodo (Top=116, Left=41) + getDtinicial (Top=111, Left=98)
    *           + getDtfinal (Top=111, Left=180)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        *-- Label "Periodo :"
        THIS.AddObject("lbl_4c_Periodo", "Label")
        WITH THIS.lbl_4c_Periodo
            .Top      = 116
            .Left     = 41
            .Width    = 50
            .Height   = 15
            .AutoSize = .F.
            .Caption  = "Per" + CHR(237) + "odo :"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Data Inicial (getDtinicial)
        THIS.AddObject("txt_4c_DtInicial", "TextBox")
        WITH THIS.txt_4c_DtInicial
            .Top       = 111
            .Left      = 98
            .Width     = 79
            .Height    = 25
            .Format    = "K"
            .Value     = {}
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 1
        ENDWITH

        *-- Data Final (getDtfinal)
        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Top      = 111
            .Left     = 180
            .Width    = 79
            .Height   = 25
            .Format   = "K"
            .Value    = {}
            .FontName = "Tahoma"
            .FontSize = 8
            .TabIndex = 2
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com Processar + Encerrar
    * Original: cmdGprocessa (Top=-2, Left=643, Width=160, Height=85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Processar", "CommandGroup")
        WITH THIS.cmg_4c_Processar
            .Top         = -2
            .Left        = 643
            .Width       = 160
            .Height      = 85
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 1

            WITH .Buttons(1)
                .Top         = 5
                .Left        = 5
                .Width       = 75
                .Height      = 75
                .Caption     = "Processar"
                .Picture     = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .FontBold    = .T.
                .FontItalic  = .T.
                .WordWrap    = .T.
                .ForeColor   = RGB(90,90,90)
                .BackColor   = RGB(255,255,255)
                .Themes      = .F.
                .PicturePosition = 13
            ENDWITH

            WITH .Buttons(2)
                .Top         = 5
                .Left        = 80
                .Width       = 75
                .Height      = 75
                .Caption     = "Encerrar"
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel      = .T.
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .WordWrap    = .T.
                .ForeColor   = RGB(90,90,90)
                .BackColor   = RGB(255,255,255)
                .Themes      = .F.
                .PicturePosition = 13
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Processar.Buttons(1), "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmg_4c_Processar.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAguarde - Container de indicador de processamento (Visible=.F.)
    * Original: cntAguarde (Top=99, Left=312, Width=207, Height=49)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAguarde()
        THIS.AddObject("cnt_4c_Aguarde", "Container")
        WITH THIS.cnt_4c_Aguarde
            .Top        = 99
            .Left       = 312
            .Width      = 207
            .Height     = 49
            .BackStyle  = 1
            .BackColor  = RGB(255,255,255)
            .BorderWidth = 0
            .SpecialEffect = 0
            .Visible    = .F.

            .AddObject("lbl_4c_Aguarde", "Label")
            WITH .lbl_4c_Aguarde
                .Top       = 7
                .Left      = 69
                .Width     = 78
                .Height    = 18
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Verdana"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Aguarde..."
                .ForeColor = RGB(255,0,0)
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Processando", "Label")
            WITH .lbl_4c_Processando
                .Top       = 24
                .Left      = 34
                .Width     = 141
                .Height    = 18
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Processando Dados..."
                .ForeColor = RGB(90,90,90)
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis
    * cnt_4c_Aguarde permanece oculto (toggled durante processamento)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oControl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_AGUARDE")
                    *-- Recursar filhos antes de LOOP para que fiquem visiveis
                    *-- quando o container for exibido durante o processamento
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarSubControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarSubControlesVisiveis - Recursao para sub-containers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Valida periodo, processa dados, abre FormSigPrGf2
    * Equivalente ao cmdProcessa.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro, loc_oGf2
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Transferir datas para o BO
            THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
            THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value

            *-- Validar periodo
            IF !THIS.this_oBusinessObject.ValidarPeriodo()
                MsgAviso(THIS.this_oBusinessObject.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Exibir indicador de processamento
                THIS.cnt_4c_Aguarde.Visible = .T.
                THIS.LockScreen = .T.
                THIS.Refresh

                *-- Processar dados
                loc_lSucesso = THIS.this_oBusinessObject.ProcessarDados()

                THIS.cnt_4c_Aguarde.Visible = .F.
                THIS.LockScreen = .F.
                THIS.Refresh

                IF loc_lSucesso
                    *-- Desabilitar este form e abrir resultado
                    THIS.Enabled = .F.
                    loc_oGf2 = CREATEOBJECT("FormSigPrGf2", THIS)
                    IF VARTYPE(loc_oGf2) = "O"
                        loc_oGf2.Show()
                    ELSE
                        THIS.Enabled = .T.
                        MsgErro("Erro ao criar FormSigPrGf2." + CHR(13) + ;
                                "VARTYPE retornou: " + VARTYPE(loc_oGf2), "Erro")
                    ENDIF
                ELSE
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagem)
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagem, ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.cnt_4c_Aguarde.Visible = .F.
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnProcessarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o form e reativa o form pai (se existir)
    * Equivalente ao cmdSair.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro

        TRY
            THIS.LockScreen = .T.

            IF USED("crLstMatLote")
                USE IN crLstMatLote
            ENDIF

            IF TYPE("THIS.poForm1") = "O"
                THIS.poForm1.LockScreen = .T.
                THIS.poForm1.Enabled    = .T.
                IF PEMSTATUS(THIS.poForm1, "mAtivaPgMovto1", 5)
                    THIS.poForm1.mAtivaPgMovto1()
                ENDIF
                THIS.poForm1.LockScreen = .F.
            ENDIF

            THIS.Release()

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDtFinalKeyPress - Valida periodo ao sair do campo Data Final
    * Equivalente ao getDtFinal.Valid do legado: bloqueia ENTER/TAB quando
    * DtFinal invalida, DtFinal < DtInicial ou periodo > 12 meses
    *--------------------------------------------------------------------------
    PROCEDURE TxtDtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
        THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value

        IF !THIS.this_oBusinessObject.ValidarPeriodo()
            MsgAviso(THIS.this_oBusinessObject.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
            IF EMPTY(THIS.txt_4c_DtFinal.Value)
                THIS.txt_4c_DtFinal.SetFocus
            ELSE
                THIS.txt_4c_DtInicial.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Reset do filtro para novo processamento (equivalente
    * a "Nova consulta" em OPERACIONAL): restaura periodo padrao (mes corrente)
    * e devolve foco a DtInicial. Nao existe INSERT em SigPrGf1 (nao ha entidade
    * persistida ??? o form apenas processa saldos em memoria via ProcessarDados).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            THIS.txt_4c_DtInicial.Value = CTOD("01/" + PADL(LTRIM(STR(MONTH(DATE()), 2)), 2, "0") + ;
                                               "/" + LTRIM(STR(YEAR(DATE()), 4)))
            THIS.txt_4c_DtFinal.Value   = GOMONTH(THIS.txt_4c_DtInicial.Value, 1) - 1

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
                THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
                THIS.this_oBusinessObject.this_cMensagem  = ""
            ENDIF

            THIS.Refresh
            THIS.txt_4c_DtInicial.SetFocus

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Habilita edicao interativa do filtro de periodo:
    * garante que os campos de data estejam editaveis e devolve foco a
    * DtInicial. Nao ha UPDATE persistente em SigPrGf1 (form OPERACIONAL sem
    * entidade CRUD) ??? este evento existe para atender ao contrato da pipeline
    * e para uso via atalho de teclado equivalente a "editar filtro".
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            THIS.txt_4c_DtInicial.Enabled  = .T.
            THIS.txt_4c_DtInicial.ReadOnly = .F.
            THIS.txt_4c_DtFinal.Enabled    = .T.
            THIS.txt_4c_DtFinal.ReadOnly   = .F.

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cMensagem = ""
            ENDIF

            THIS.Refresh
            THIS.txt_4c_DtInicial.SetFocus

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Executa o processamento e abre o resultado
    * (FormSigPrGf2). Em forms OPERACIONAIS de relatorio/consulta, "Visualizar"
    * corresponde a executar a consulta e exibir o resultado ??? equivale ao
    * BtnProcessarClick. Delegamos para reaproveitar validacao de periodo,
    * indicador cnt_4c_Aguarde e tratamento de erros.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Limpa o filtro de periodo (equivalente a "cancelar
    * consulta"): zera datas, limpa mensagem do BO e devolve foco a DtInicial.
    * Nao existe DELETE em SigPrGf1 (form OPERACIONAL sem entidade persistida)
    * ??? este evento existe para atender ao contrato da pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro

        TRY
            THIS.txt_4c_DtInicial.Value = {}
            THIS.txt_4c_DtFinal.Value   = {}

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_dDtInicial = {}
                THIS.this_oBusinessObject.this_dDtFinal   = {}
                THIS.this_oBusinessObject.this_cMensagem  = ""
            ENDIF

            IF USED("crLstMatLote")
                USE IN crLstMatLote
            ENDIF

            THIS.Refresh
            THIS.txt_4c_DtInicial.SetFocus

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Busca/consulta (OPERACIONAL: delega ao processamento)
    * Original: a acao "Buscar" neste form equivale a executar o processamento
    * com o periodo atual sem resetar os campos de data.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Nao aplicavel (form OPERACIONAL sem entidade persistida)
    * Contrato da pipeline: delega ao BtnProcessarClick para manter coerencia.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela/limpa o filtro de periodo e reseta o form
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
            THIS.txt_4c_DtInicial.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere campos do form para o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
        THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
        THIS.this_oBusinessObject.this_cEmpresa   = go_4c_Sistema.cCodEmpresa

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object de volta para o form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF !EMPTY(THIS.this_oBusinessObject.this_dDtInicial)
            THIS.txt_4c_DtInicial.Value = THIS.this_oBusinessObject.this_dDtInicial
        ENDIF
        IF !EMPTY(THIS.this_oBusinessObject.this_dDtFinal)
            THIS.txt_4c_DtFinal.Value = THIS.this_oBusinessObject.this_dDtFinal
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de edicao conforme modo
    * par_lHabilitar = .T. => campos editaveis | .F. => campos somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
            THIS.txt_4c_DtInicial.Enabled  = loc_lHabilitar
            THIS.txt_4c_DtInicial.ReadOnly = !loc_lHabilitar
        ENDIF
        IF VARTYPE(THIS.txt_4c_DtFinal) = "O"
            THIS.txt_4c_DtFinal.Enabled  = loc_lHabilitar
            THIS.txt_4c_DtFinal.ReadOnly = !loc_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa os campos de filtro de periodo
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
            THIS.txt_4c_DtInicial.Value = {}
        ENDIF
        IF VARTYPE(THIS.txt_4c_DtFinal) = "O"
            THIS.txt_4c_DtFinal.Value = {}
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_dDtInicial = {}
            THIS.this_oBusinessObject.this_dDtFinal   = {}
            THIS.this_oBusinessObject.this_cMensagem  = ""
            THIS.this_oBusinessObject.this_cTitulo1   = ""
            THIS.this_oBusinessObject.this_cTitulo2   = ""
        ENDIF

        IF USED("crLstMatLote")
            USE IN crLstMatLote
        ENDIF
        IF USED("crRel1")
            USE IN crRel1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Sem grid/lista neste form OPERACIONAL (apenas filtro)
    * Contrato da pipeline: restaura o periodo padrao (mes corrente) caso
    * os campos estejam vazios, garantindo estado inicial consistente.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(THIS.txt_4c_DtInicial.Value) AND EMPTY(THIS.txt_4c_DtFinal.Value)
            THIS.txt_4c_DtInicial.Value = CTOD("01/" + PADL(LTRIM(STR(MONTH(DATE()), 2)), 2, "0") + ;
                                               "/" + LTRIM(STR(YEAR(DATE()), 4)))
            THIS.txt_4c_DtFinal.Value   = GOMONTH(THIS.txt_4c_DtInicial.Value, 1) - 1
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Sem modos CRUD neste form OPERACIONAL
    * Contrato da pipeline: mantido como no-op documentado pois SIGPRGF1 tem
    * apenas Processar e Encerrar (sem Incluir/Alterar/Excluir/Buscar/Salvar).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        *-- No-op: SIGPRGF1 e form OPERACIONAL flat sem modos CRUD.
        *-- Os unicos botoes (Processar/Encerrar em cmg_4c_Processar) permanecem
        *-- sempre habilitados enquanto o form estiver ativo.
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
