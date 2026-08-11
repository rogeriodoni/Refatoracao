*=============================================================================*
* FormSigPrGlx.prg - Previa da Globalizacao
*=============================================================================*
* Herda de: FormBase
* BO: SigPrGlxBO
* Tipo: OPERACIONAL (filho - chamado por FormSigPrGlo)
* Descricao: Exibe e processa a previa da globalizacao de producao.
*            Recebe cursores do form pai (TmpFinalg, TmpFinal, TmpSaldG,
*            TmpFabr, CrSigCdPac, CrSigCdPam) via DataSession compartilhada.
*=============================================================================*

DEFINE CLASS FormSigPrGlx AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    ClipControls = .F.
    WindowType   = 1
    DataSession  = 2

    *--------------------------------------------------------------------------
    * Estado e referencias
    *--------------------------------------------------------------------------
    this_oParentForm  = .NULL.
    this_lProcessando = .F.
    this_nOldValue    = 0
    this_lLiberado    = .F.

    *--------------------------------------------------------------------------
    * INIT - Inicializa form filho com parametros do form pai
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_dData, par_lReservaAuto, ;
                   par_nGerEmphPdr, par_lAutom, par_nNumeroOp, par_lPorDestino)

        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            *-- Compartilha datasession com form pai ANTES do DODEFAULT
            IF VARTYPE(par_oParentForm) = "O"
                THIS.DataSessionId   = par_oParentForm.DataSessionId
                THIS.this_oParentForm = par_oParentForm
            ENDIF

            *-- Cria e configura o BO antes do DODEFAULT (InicializarForm precisa dele)
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlxBO")

            THIS.this_oBusinessObject.this_dData       = IIF(TYPE("par_dData")         = "D", par_dData, DATE())
            THIS.this_oBusinessObject.this_lReserva    = IIF(TYPE("par_lReservaAuto")  = "L", par_lReservaAuto, .F.)
            THIS.this_oBusinessObject.this_nEmphPdr    = IIF(TYPE("par_nGerEmphPdr")   = "N", par_nGerEmphPdr, 0)
            THIS.this_oBusinessObject.this_lAutomatico = IIF(TYPE("par_lAutom")        = "L", par_lAutom, .F.)
            THIS.this_oBusinessObject.this_nNumerodaop = IIF(TYPE("par_nNumeroOp")     = "N", par_nNumeroOp, 0)
            THIS.this_oBusinessObject.this_lPorDestino = IIF(TYPE("par_lPorDestino")   = "L", par_lPorDestino, .F.)

            DODEFAULT()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Pr" + CHR(233) + "via da Globaliza" + ;
                CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura controles e estado inicial
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()

        LOCAL loc_cCaption, loc_lPedrasVis

        TRY
            THIS.ConfigurarPageFrame()

            *-- Torna controles visiveis (cnt_4c_Aguarde fica oculto por design)
            THIS.TornarControlesVisiveis(THIS)
            THIS.AjustarVisibilidadeBotoes()

            *-- Exibe e ativa primeira pagina
            THIS.pgf_4c_1.Visible    = .T.
            THIS.pgf_4c_1.ActivePage = 1

            *-- Caption baseado no modo de operacao
            loc_cCaption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
            IF THIS.this_oBusinessObject.this_lReserva
                loc_cCaption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
            ENDIF
            THIS.Caption = loc_cCaption

            *-- Atualiza labels do cabecalho
            THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
            THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption

            *-- Obtem SigKey do cursor CrSigCdPac (passado pelo form pai)
            IF USED("CrSigCdPac") AND RECCOUNT("CrSigCdPac") > 0 AND !EOF("CrSigCdPac")
                THIS.this_oBusinessObject.this_cSigKey = ALLTRIM(CrSigCdPac.sigKeys)
            ENDIF

            *-- Visibilidade do botao Pedras (requisicao de material)
            *-- Botao adicionado na Fase 4; estado armazenado no BO para uso posterior
            loc_lPedrasVis = .F.
            IF USED("CrSigCdPam")
                IF !EMPTY(CrSigCdPam.DopEmphs) AND !EMPTY(CrSigCdPam.DopReqcs) AND ;
                   !EMPTY(CrSigCdPam.DopPedcs) AND !EMPTY(CrSigCdPam.DopComps) AND ;
                   !THIS.this_oBusinessObject.this_lReserva
                    loc_lPedrasVis = .T.
                ENDIF
            ENDIF
            THIS.this_oBusinessObject.this_lPedrasVisiveis = loc_lPedrasVis

            *-- Permissao de prioridade (fChecaAcesso nao portado - concede por padrao)
            THIS.this_oBusinessObject.this_lPermitePrioridade    = .T.
            THIS.this_oBusinessObject.this_lSelEstoqueVisivel    = .T.

            *-- Cria cursor auxiliar de saldo unitario por produto/cor/tamanho
            IF USED("TmpSaldU")
                USE IN TmpSaldU
            ENDIF
            CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L, KeySelmp L)
            INDEX ON Cpros TAG Cpros

            *-- Carrega totais iniciais do BO
            THIS.AtualizarTotaisPage1()

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar form: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 6 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()

        LOCAL loc_cBg

        TRY
            loc_cBg = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.AddObject("pgf_4c_1", "PageFrame")

            WITH THIS.pgf_4c_1
                .Top       = -27
                .Left      = -1
                .Width     = 1004
                .Height    = 629
                .PageCount = 6
                .Tabs      = .F.
                .Visible   = .F.

                WITH .Page1
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 128, 192)
                    .Caption   = "Dados"
                    .Picture   = loc_cBg
                ENDWITH

                WITH .Page2
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 128, 192)
                    .Caption   = "Opera" + CHR(231) + CHR(245) + "es Detalhadas"
                    .Picture   = loc_cBg
                ENDWITH

                WITH .Page3
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 128, 192)
                    .Caption   = "Totais por Linha"
                    .Picture   = loc_cBg
                    .Enabled   = .F.
                ENDWITH

                WITH .Page4
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .ForeColor  = RGB(0, 128, 192)
                    .Caption    = "Selecionar Estoque"
                    .Picture    = loc_cBg
                    .Enabled    = .F.
                ENDWITH

                WITH .Page5
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 128, 192)
                    .Caption   = "Disponivel/Tamanho"
                    .Picture   = loc_cBg
                    .Enabled   = .F.
                ENDWITH

                WITH .Page6
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 128, 192)
                    .Caption   = "Requisi" + CHR(231) + CHR(227) + "o"
                    .Picture   = loc_cBg
                    .Enabled   = .F.
                ENDWITH
            ENDWITH

            THIS.ConfigurarPagina1()
            THIS.ConfigurarPaginaDados()
            THIS.ConfigurarPagina3()
            THIS.ConfigurarPagina4()
            THIS.ConfigurarPagina5()
            THIS.ConfigurarPagina6()
            THIS.ConfigurarContainerAguarde()

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar PageFrame: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (grade de operacoes selecionadas)
    *--------------------------------------------------------------------------
    * Em form OPERACIONAL de globalizacao, Page2 concentra o grid principal de
    * dados editaveis (TmpFinal) + totais + observacoes + foto. Delega para
    * ConfigurarPagina2 para preservar o layout multi-fase existente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarPagina2()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPagina1 - Cabecalho e containers da pagina principal (Fase 3)
    *--------------------------------------------------------------------------
    * Grids e botoes sao adicionados nas Fases 4-5.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPagina1()

        LOCAL loc_oPage

        TRY
            loc_oPage = THIS.pgf_4c_1.Page1

            *-- Cabecalho cinza com labels sobrepostas (efeito sombra)
            loc_oPage.AddObject("cnt_4c_Sombra", "Container")
            WITH loc_oPage.cnt_4c_Sombra
                .Top        = -1
                .Left       = 0
                .Width      = THIS.Width
                .Height     = 80
                .BorderWidth = 0
                .BackColor  = RGB(100, 100, 100)
                .BackStyle  = 1
                .Visible    = .F.

                .AddObject("lbl_4c_LblSombra", "Label")
                WITH .lbl_4c_LblSombra
                    .FontBold      = .T.
                    .FontName      = "Tahoma"
                    .FontSize      = 18
                    .FontUnderline = .F.
                    .WordWrap      = .T.
                    .Alignment     = 0
                    .BackStyle     = 0
                    .Top           = 18
                    .Left          = 13
                    .Width         = THIS.Width
                    .Height        = 40
                    .ForeColor     = RGB(0, 0, 0)
                    .AutoSize      = .F.
                    .Caption       = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
                ENDWITH

                .AddObject("lbl_4c_LblTitulo", "Label")
                WITH .lbl_4c_LblTitulo
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .WordWrap  = .T.
                    .Alignment = 0
                    .BackStyle = 0
                    .Top       = 17
                    .Left      = 13
                    .Width     = THIS.Width
                    .Height    = 46
                    .ForeColor = RGB(255, 255, 255)
                    .AutoSize  = .F.
                    .Caption   = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
                ENDWITH
            ENDWITH

            *-- Container barra info (Container5) - campos adicionados na Fase 5
            loc_oPage.AddObject("cnt_4c_Container5", "Container")
            WITH loc_oPage.cnt_4c_Container5
                .Top       = 129
                .Left      = 45
                .Width     = 909
                .Height    = 40
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            *-- Container estoque disponivel (Container3) - grid adicionado na Fase 4
            loc_oPage.AddObject("cnt_4c_Container3", "Container")
            WITH loc_oPage.cnt_4c_Container3
                .Top           = 371
                .Left          = 63
                .Width         = 454
                .Height        = 186
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .BackStyle     = 1
                .Visible       = .F.
            ENDWITH

            *-- Container estoque em producao (Container1) - grid adicionado na Fase 4
            loc_oPage.AddObject("cnt_4c_Container1", "Container")
            WITH loc_oPage.cnt_4c_Container1
                .Top           = 371
                .Left          = 418
                .Width         = 385
                .Height        = 136
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .BackStyle     = 1
                .Visible       = .F.
            ENDWITH

            THIS.ConfigurarPaginaLista()

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar P" + CHR(225) + "gina 1: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPagina2 - Operacoes Detalhadas (TmpFinal)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPagina2()

        LOCAL loc_oPage, loc_oGrid

        TRY
            loc_oPage = THIS.pgf_4c_1.Page2

            loc_oPage.AddObject("grd_4c_GradeItens2", "Grid")
            loc_oPage.grd_4c_GradeItens2.ColumnCount  = 10
            loc_oPage.grd_4c_GradeItens2.RecordSource = IIF(USED("TmpFinal"), "TmpFinal", "")
            WITH loc_oPage.grd_4c_GradeItens2
                .Top          = 181
                .Left         = 53
                .Width        = 703
                .Height       = 189
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .Visible      = .F.

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .ControlSource   = "TmpFinal.Cpros"
                    .Width           = 90
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Cor"
                    .ControlSource   = "TmpFinal.CodCors"
                    .Width           = 35
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                    .ControlSource   = "TmpFinal.Dopes"
                    .Width           = 60
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "N" + CHR(250) + "mero"
                    .ControlSource   = "TmpFinal.Nops"
                    .Width           = 50
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Quantidade"
                    .ControlSource   = "TmpFinal.Saldo"
                    .Width           = 62
                    .ReadOnly        = .T.
                    .Text1.Alignment = 1
                ENDWITH
                WITH .Column6
                    .Header1.Caption = "Produzir"
                    .ControlSource   = "TmpFinal.Produzir"
                    .Width           = 57
                    .ReadOnly        = .T.
                    .Text1.Alignment = 1
                ENDWITH
                WITH .Column7
                    .Header1.Caption = "Estoque"
                    .ControlSource   = "TmpFinal.Estoque"
                    .Width           = 62
                    .ReadOnly        = .F.
                    .Text1.Alignment = 1
                ENDWITH
                WITH .Column8
                    .Header1.Caption = "Obs"
                    .ControlSource   = "TmpFinal.CodObs"
                    .Width           = 60
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column9
                    .Header1.Caption = "Tam"
                    .ControlSource   = "TmpFinal.CodTams"
                    .Width           = 33
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column10
                    .Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
                    .ControlSource   = "TmpFinal.Fabrs"
                    .Width           = 62
                    .ReadOnly        = .F.
                    .Text1.Alignment = 1
                ENDWITH
            ENDWITH
            THIS.FormatarGrid(loc_oPage.grd_4c_GradeItens2)

            loc_oPage.AddObject("lbl_4c_LblTotais", "Label")
            WITH loc_oPage.lbl_4c_LblTotais
                .Top       = 372
                .Left      = 403
                .Width     = 42
                .Height    = 17
                .Caption   = "Totais :"
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Tot_Qtd", "TextBox")
            WITH loc_oPage.txt_4c_Tot_Qtd
                .Top       = 370
                .Left      = 449
                .Width     = 68
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Tot_Est", "TextBox")
            WITH loc_oPage.txt_4c_Tot_Est
                .Top       = 370
                .Left      = 516
                .Width     = 67
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Tot_prc", "TextBox")
            WITH loc_oPage.txt_4c_Tot_prc
                .Top       = 370
                .Left      = 581
                .Width     = 67
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Tot_Prz", "TextBox")
            WITH loc_oPage.txt_4c_Tot_Prz
                .Top       = 370
                .Left      = 648
                .Width     = 67
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("img_4c_ImgFigJpg", "Image")
            WITH loc_oPage.img_4c_ImgFigJpg
                .Top     = 394
                .Left    = 73
                .Width   = 135
                .Height  = 92
                .Stretch = 2
                .Visible = .F.
            ENDWITH

            loc_oPage.AddObject("edt_4c_ObsItens", "EditBox")
            WITH loc_oPage.edt_4c_ObsItens
                .Top           = 415
                .Left          = 221
                .Width         = 396
                .Height        = 69
                .ControlSource = IIF(USED("TmpFinal"), "TmpFinal.CodObs", "")
                .ReadOnly      = .T.
                .Visible       = .F.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_Txt_ObsItens", "Label")
            WITH loc_oPage.lbl_4c_Txt_ObsItens
                .Top       = 400
                .Left      = 221
                .Width     = 119
                .Height    = 17
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_LblQtdSel", "Label")
            WITH loc_oPage.lbl_4c_LblQtdSel
                .Top       = 164
                .Left      = 383
                .Width     = 119
                .Height    = 15
                .Caption   = "Qtd Selecionada : "
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Tot_sEst", "TextBox")
            WITH loc_oPage.txt_4c_Tot_sEst
                .Top       = 162
                .Left      = 501
                .Width     = 67
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Tot_sPrc", "TextBox")
            WITH loc_oPage.txt_4c_Tot_sPrc
                .Top       = 162
                .Left      = 567
                .Width     = 67
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
            WITH loc_oPage.cmd_4c_Voltar
                .Top         = 2
                .Left        = 704
                .Width       = 75
                .Height      = 75
                .Caption     = "Voltar"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Voltar"
            ENDWITH

            loc_oGrid = loc_oPage.grd_4c_GradeItens2
            BINDEVENT(loc_oGrid,                "AfterRowColChange", THIS, "P2GradeAfterRowColChange")
            BINDEVENT(loc_oGrid.Column1.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
            BINDEVENT(loc_oGrid.Column2.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
            BINDEVENT(loc_oGrid.Column3.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
            BINDEVENT(loc_oGrid.Column4.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
            BINDEVENT(loc_oGrid.Column5.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
            BINDEVENT(loc_oGrid.Column6.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
            BINDEVENT(loc_oGrid.Column8.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
            BINDEVENT(loc_oGrid.Column9.Text1,  "GotFocus",          THIS, "P2ColGotFocusToCol7")
            BINDEVENT(loc_oGrid.Column7.Text1,  "When",              THIS, "P2ColC7When")
            BINDEVENT(loc_oGrid.Column7.Text1,  "Valid",             THIS, "P2ColC7Valid")
            BINDEVENT(loc_oGrid.Column7.Text1,  "KeyPress",         THIS, "P2ColC7LostFocus")
            BINDEVENT(loc_oGrid.Column10.Text1, "When",              THIS, "P2ColC10When")
            BINDEVENT(loc_oGrid.Column10.Text1, "Valid",             THIS, "P2ColC10Valid")
            BINDEVENT(loc_oGrid.Column10.Text1, "KeyPress",         THIS, "P2ColC10LostFocus")
            BINDEVENT(loc_oPage.cmd_4c_Voltar,  "Click",             THIS, "BtnVoltarPage2Click")
            BINDEVENT(loc_oPage,                "Activate",          THIS, "Pagina2Activate")

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar P" + CHR(225) + "gina 2: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPagina3 - Totais por Linha (TmpLinha)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPagina3()

        LOCAL loc_oPage

        TRY
            loc_oPage = THIS.pgf_4c_1.Page3

            loc_oPage.AddObject("shp_4c_Shape4", "Shape")
            WITH loc_oPage.shp_4c_Shape4
                .Top     = 169
                .Left    = 168
                .Width   = 437
                .Height  = 2
                .Visible = .F.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPage.lbl_4c_Label2
                .Top       = 147
                .Left      = 173
                .Width     = 157
                .Height    = 25
                .Caption   = "Totais por Linha"
                .BackStyle = 0
                .FontBold  = .T.
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("grd_4c_GradeLinhas", "Grid")
            loc_oPage.grd_4c_GradeLinhas.ColumnCount  = 5
            loc_oPage.grd_4c_GradeLinhas.RecordSource = IIF(USED("TmpLinha"), "TmpLinha", "")
            WITH loc_oPage.grd_4c_GradeLinhas
                .Top          = 181
                .Left         = 167
                .Width        = 438
                .Height       = 292
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .ReadOnly     = .T.
                .Visible      = .F.

                WITH .Column1
                    .Header1.Caption = "Linha"
                    .ControlSource   = "TmpLinha.Linhas"
                    .Width           = 80
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Quantidade"
                    .ControlSource   = "TmpLinha.Saldo"
                    .Width           = 74
                    .Text1.Alignment = 1
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Estoque"
                    .ControlSource   = "TmpLinha.Estoque"
                    .Width           = 74
                    .Text1.Alignment = 1
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Produ" + CHR(231) + CHR(227) + "o"
                    .ControlSource   = "TmpLinha.Fabrs"
                    .Width           = 74
                    .Text1.Alignment = 1
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Produzir"
                    .ControlSource   = "TmpLinha.Produzir"
                    .Width           = 74
                    .Text1.Alignment = 1
                ENDWITH
            ENDWITH
            THIS.FormatarGrid(loc_oPage.grd_4c_GradeLinhas)

            loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
            WITH loc_oPage.cmd_4c_Voltar
                .Top         = 2
                .Left        = 704
                .Width       = 75
                .Height      = 75
                .Caption     = "Voltar"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Voltar"
            ENDWITH

            BINDEVENT(loc_oPage.cmd_4c_Voltar, "Click", THIS, "BtnVoltarPage3Click")

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar P" + CHR(225) + "gina 3: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPagina4 - Selecionar Estoque por Grupo/Conta (TmpDisp)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPagina4()

        LOCAL loc_oPage, loc_oGrid

        TRY
            loc_oPage = THIS.pgf_4c_1.Page4

            loc_oPage.AddObject("shp_4c_Shape4", "Shape")
            WITH loc_oPage.shp_4c_Shape4
                .Top     = 159
                .Left    = 191
                .Width   = 370
                .Height  = 2
                .Visible = .F.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPage.lbl_4c_Label1
                .Top       = 138
                .Left      = 197
                .Width     = 184
                .Height    = 25
                .Caption   = "Selecionar Estoque"
                .BackStyle = 0
                .FontBold  = .T.
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Cpros", "TextBox")
            WITH loc_oPage.txt_4c_Cpros
                .Top      = 138
                .Left     = 479
                .Width    = 80
                .Height   = 19
                .ReadOnly = .T.
                .Visible  = .F.
            ENDWITH

            loc_oPage.AddObject("grd_4c_GradeDisp", "Grid")
            loc_oPage.grd_4c_GradeDisp.ColumnCount  = 5
            loc_oPage.grd_4c_GradeDisp.RecordSource = IIF(USED("TmpDisp"), "TmpDisp", "")
            WITH loc_oPage.grd_4c_GradeDisp
                .Top          = 169
                .Left         = 191
                .Width        = 370
                .Height       = 244
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .Visible      = .F.

                WITH .Column1
                    .Header1.Caption = "Grupo"
                    .ControlSource   = "TmpDisp.Grupos"
                    .Width           = 60
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Conta"
                    .ControlSource   = "TmpDisp.Estos"
                    .Width           = 60
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Prior"
                    .ControlSource   = "TmpDisp.Priors"
                    .Width           = 55
                    .ReadOnly        = .T.
                    .Text1.Alignment = 1
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Dispon" + CHR(237) + "vel"
                    .ControlSource   = "TmpDisp.Disps"
                    .Width           = 65
                    .ReadOnly        = .T.
                    .Text1.Alignment = 1
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Utilizar"
                    .ControlSource   = "TmpDisp.Utilizar"
                    .Width           = 65
                    .ReadOnly        = .F.
                    .Text1.Alignment = 1
                ENDWITH
            ENDWITH
            THIS.FormatarGrid(loc_oPage.grd_4c_GradeDisp)

            loc_oPage.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPage.lbl_4c_Label2
                .Top       = 418
                .Left      = 220
                .Width     = 82
                .Height    = 16
                .Caption   = "Qtde Pedida : "
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPage.lbl_4c_Label3
                .Top       = 437
                .Left      = 192
                .Width     = 110
                .Height    = 16
                .Caption   = "Qtde Selecionada : "
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Qt_pedida", "TextBox")
            WITH loc_oPage.txt_4c_Qt_pedida
                .Top       = 413
                .Left      = 312
                .Width     = 67
                .Height    = 23
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Qt_Selec", "TextBox")
            WITH loc_oPage.txt_4c_Qt_Selec
                .Top       = 436
                .Left      = 312
                .Width     = 67
                .Height    = 23
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
            WITH loc_oPage.cmd_4c_Voltar
                .Top         = 2
                .Left        = 704
                .Width       = 75
                .Height      = 75
                .Caption     = "Voltar"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Voltar"
            ENDWITH

            loc_oGrid = loc_oPage.grd_4c_GradeDisp
            BINDEVENT(loc_oGrid.Column1.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
            BINDEVENT(loc_oGrid.Column2.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
            BINDEVENT(loc_oGrid.Column3.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
            BINDEVENT(loc_oGrid.Column4.Text1,    "When",      THIS, "P4ColReadOnlyWhen")
            BINDEVENT(loc_oGrid.Column5.Text1,    "Valid",     THIS, "P4ColC5Valid")
            BINDEVENT(loc_oGrid.Column5.Text1,    "KeyPress", THIS, "P4ColC5LostFocus")
            BINDEVENT(loc_oPage.txt_4c_Qt_pedida, "When",      THIS, "P4ColReadOnlyWhen")
            BINDEVENT(loc_oPage.txt_4c_Qt_Selec,  "When",      THIS, "P4ColReadOnlyWhen")
            BINDEVENT(loc_oPage.cmd_4c_Voltar,    "Click",     THIS, "BtnVoltarPage4Click")

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar P" + CHR(225) + "gina 4: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPagina5 - Disponivel por Tamanho (TmpDisp por CodTams)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPagina5()

        LOCAL loc_oPage, loc_oGrid

        TRY
            loc_oPage = THIS.pgf_4c_1.Page5

            loc_oPage.AddObject("shp_4c_Shape4", "Shape")
            WITH loc_oPage.shp_4c_Shape4
                .Top     = 171
                .Left    = 240
                .Width   = 328
                .Height  = 2
                .Visible = .F.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPage.lbl_4c_Label1
                .Top       = 150
                .Left      = 246
                .Width     = 205
                .Height    = 25
                .Caption   = "Selecionar Tamanhos"
                .BackStyle = 0
                .FontBold  = .T.
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Cpros", "TextBox")
            WITH loc_oPage.txt_4c_Cpros
                .Top      = 151
                .Left     = 486
                .Width    = 80
                .Height   = 19
                .ReadOnly = .T.
                .Visible  = .F.
            ENDWITH

            loc_oPage.AddObject("grd_4c_GradeDisp", "Grid")
            loc_oPage.grd_4c_GradeDisp.ColumnCount  = 5
            loc_oPage.grd_4c_GradeDisp.RecordSource = IIF(USED("TmpDisp"), "TmpDisp", "")
            WITH loc_oPage.grd_4c_GradeDisp
                .Top          = 181
                .Left         = 239
                .Width        = 327
                .Height       = 228
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .Visible      = .F.

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .ControlSource   = "TmpDisp.Cpros"
                    .Width           = 55
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Cor"
                    .ControlSource   = "TmpDisp.CodCors"
                    .Width           = 40
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Tam"
                    .ControlSource   = "TmpDisp.CodTams"
                    .Width           = 40
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Dispon" + CHR(237) + "vel"
                    .ControlSource   = "TmpDisp.Disps"
                    .Width           = 65
                    .ReadOnly        = .T.
                    .Text1.Alignment = 1
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Utilizar"
                    .ControlSource   = "TmpDisp.Utilizar"
                    .Width           = 65
                    .ReadOnly        = .F.
                    .Text1.Alignment = 1
                ENDWITH
            ENDWITH
            THIS.FormatarGrid(loc_oPage.grd_4c_GradeDisp)

            loc_oPage.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPage.lbl_4c_Label2
                .Top       = 415
                .Left      = 289
                .Width     = 82
                .Height    = 16
                .Caption   = "Qtde Pedida : "
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPage.lbl_4c_Label3
                .Top       = 434
                .Left      = 261
                .Width     = 110
                .Height    = 16
                .Caption   = "Qtde Selecionada : "
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Qt_pedida", "TextBox")
            WITH loc_oPage.txt_4c_Qt_pedida
                .Top       = 410
                .Left      = 379
                .Width     = 67
                .Height    = 23
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Qt_Selec", "TextBox")
            WITH loc_oPage.txt_4c_Qt_Selec
                .Top       = 433
                .Left      = 379
                .Width     = 67
                .Height    = 23
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
            WITH loc_oPage.cmd_4c_Voltar
                .Top         = 2
                .Left        = 704
                .Width       = 75
                .Height      = 75
                .Caption     = "Voltar"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Voltar"
            ENDWITH

            loc_oGrid = loc_oPage.grd_4c_GradeDisp
            BINDEVENT(loc_oGrid.Column1.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
            BINDEVENT(loc_oGrid.Column2.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
            BINDEVENT(loc_oGrid.Column3.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
            BINDEVENT(loc_oGrid.Column4.Text1,    "GotFocus", THIS, "P5ColGotFocusToCol5")
            BINDEVENT(loc_oGrid.Column5.Text1,    "Valid",    THIS, "P5ColC5Valid")
            BINDEVENT(loc_oPage.txt_4c_Qt_pedida, "When",    THIS, "P4ColReadOnlyWhen")
            BINDEVENT(loc_oPage.txt_4c_Qt_Selec,  "When",    THIS, "P4ColReadOnlyWhen")
            BINDEVENT(loc_oPage.cmd_4c_Voltar,    "Click",   THIS, "BtnVoltarPage5Click")

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar P" + CHR(225) + "gina 5: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPagina6 - Requisicao Manual de Material (SelPedra)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPagina6()

        LOCAL loc_oPage, loc_oGrid

        TRY
            loc_oPage = THIS.pgf_4c_1.Page6

            loc_oPage.AddObject("shp_4c_Shape4", "Shape")
            WITH loc_oPage.shp_4c_Shape4
                .Top     = 189
                .Left    = 119
                .Width   = 500
                .Height  = 2
                .Visible = .F.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPage.lbl_4c_Label1
                .Top       = 168
                .Left      = 132
                .Width     = 294
                .Height    = 25
                .Caption   = "Requisi" + CHR(231) + CHR(227) + "o Manual de Material"
                .BackStyle = 0
                .FontBold  = .T.
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Cpros", "TextBox")
            WITH loc_oPage.txt_4c_Cpros
                .Top      = 169
                .Left     = 487
                .Width    = 80
                .Height   = 19
                .ReadOnly = .T.
                .Visible  = .F.
            ENDWITH

            loc_oPage.AddObject("grd_4c_GradePedra", "Grid")
            loc_oPage.grd_4c_GradePedra.ColumnCount  = 5
            loc_oPage.grd_4c_GradePedra.RecordSource = IIF(USED("SelPedra"), "SelPedra", "")
            WITH loc_oPage.grd_4c_GradePedra
                .Top          = 197
                .Left         = 119
                .Width        = 500
                .Height       = 261
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .Visible      = .F.

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .ControlSource   = "SelPedra.Cpros"
                    .Width           = 90
                    .ReadOnly        = .F.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    .ControlSource   = "SelPedra.Dpros"
                    .Width           = 150
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Uni"
                    .ControlSource   = "SelPedra.Cunis"
                    .Width           = 40
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Qtde"
                    .ControlSource   = "SelPedra.Qtdes"
                    .Width           = 75
                    .ReadOnly        = .F.
                    .Text1.Alignment = 1
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Produto"
                    .ControlSource   = "SelPedra.Cpro2s"
                    .Width           = 90
                    .ReadOnly        = .F.
                ENDWITH
            ENDWITH
            THIS.FormatarGrid(loc_oPage.grd_4c_GradePedra)

            loc_oPage.AddObject("cmd_4c_Voltar", "CommandButton")
            WITH loc_oPage.cmd_4c_Voltar
                .Top         = 2
                .Left        = 704
                .Width       = 75
                .Height      = 75
                .Caption     = "Voltar"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Voltar"
            ENDWITH

            loc_oGrid = loc_oPage.grd_4c_GradePedra
            BINDEVENT(loc_oGrid.Column1.Text1, "Valid",     THIS, "P6ColC1Valid")
            BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress",  THIS, "P6ColC1KeyPress")
            BINDEVENT(loc_oGrid.Column2.Text1, "When",      THIS, "P6ColC2When")
            BINDEVENT(loc_oGrid.Column3.Text1, "When",      THIS, "P6ColC3When")
            BINDEVENT(loc_oGrid.Column4.Text1, "When",      THIS, "P6ColC4When")
            BINDEVENT(loc_oGrid.Column5.Text1, "When",      THIS, "P6ColC5When")
            BINDEVENT(loc_oGrid.Column5.Text1, "Valid",     THIS, "P6ColC5Valid")
            BINDEVENT(loc_oGrid.Column5.Text1, "KeyPress", THIS, "P6ColC5LostFocus")
            BINDEVENT(loc_oGrid.Column5.Text1, "KeyPress",  THIS, "P6ColC5KeyPress")
            BINDEVENT(loc_oPage.cmd_4c_Voltar, "Click",     THIS, "BtnVoltarPage6Click")

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar P" + CHR(225) + "gina 6: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerAguarde - Overlay de espera (nivel do form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerAguarde()

        TRY
            THIS.AddObject("cnt_4c_Aguarde", "Container")
            WITH THIS.cnt_4c_Aguarde
                .Top           = 251
                .Left          = 142
                .Width         = 645
                .Height        = 98
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .BackStyle     = 1
                .Visible       = .F.
                .ZOrderSet     = 1

                .AddObject("lbl_4c_AguardeMsg", "Label")
                WITH .lbl_4c_AguardeMsg
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 14
                    .BackStyle = 0
                    .Caption   = "Aguarde..."
                    .Height    = 29
                    .Left      = 208
                    .Top       = 18
                    .Width     = 131
                    .ForeColor = RGB(255, 0, 0)
                    .AutoSize  = .F.
                ENDWITH

                .AddObject("lbl_4c_AguardeProc", "Label")
                WITH .lbl_4c_AguardeProc
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 14
                    .BackStyle = 0
                    .Caption   = "Processando Dados ......"
                    .Height    = 27
                    .Left      = 137
                    .Top       = 52
                    .Width     = 303
                    .ForeColor = RGB(90, 90, 90)
                    .AutoSize  = .F.
                ENDWITH

                .AddObject("lbl_4c_AguardeDet", "Label")
                WITH .lbl_4c_AguardeDet
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .FontSize  = 14
                    .Alignment = 2
                    .BackStyle = 0
                    .Caption   = ""
                    .Height    = 25
                    .Left      = 164
                    .Top       = 93
                    .Width     = 291
                    .ForeColor = RGB(0, 0, 160)
                    .AutoSize  = .F.
                ENDWITH
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro ao configurar container Aguarde: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    * cnt_4c_Aguarde: o container permanece oculto (overlay de processamento),
    * mas seus filhos recebem Visible=.T. para que aparecam quando ativado.
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)

        LOCAL loc_i, loc_oCtrl, loc_cNome, loc_p

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            loc_cNome = UPPER(ALLTRIM(loc_oCtrl.Name))

            IF INLIST(loc_cNome, "CNT_4C_AGUARDE", "CNT_4C_SOMBRA", ;
                "CNT_4C_CONTAINER5", "CNT_4C_CONTAINER3", "CNT_4C_CONTAINER1")
                *-- Containers ocultos por design: torna filhos visiveis mas mantem container oculto
                THIS.TornarControlesVisiveis(loc_oCtrl)
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF

            IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
                FOR loc_p = 1 TO loc_oCtrl.PageCount
                    THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_p))
                ENDFOR
            ELSE
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
                IF loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGrid - Configura aparencia visual padrao de um grid
    *--------------------------------------------------------------------------
    PROCEDURE FormatarGrid(par_oGrid)

        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName   = "Verdana"
            .FontSize   = 8
            .RecordMark = .F.
            .DeleteMark = .F.
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona grade de itens e controles na Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()

        LOCAL loc_oPage, loc_oGrid

        TRY
            loc_oPage = THIS.pgf_4c_1.Page1

            *-- Shapes decorativos
            loc_oPage.AddObject("shp_4c_Shape2", "Shape")
            WITH loc_oPage.shp_4c_Shape2
                .Top     = 12
                .Left    = 10
                .Width   = 342
                .Height  = 110
                .Visible = .F.
            ENDWITH

            loc_oPage.AddObject("shp_4c_Shape3", "Shape")
            WITH loc_oPage.shp_4c_Shape3
                .Top     = 9
                .Left    = 605
                .Width   = 173
                .Height  = 38
                .Visible = .F.
            ENDWITH

            *-- Imagem do produto
            loc_oPage.AddObject("img_4c_ImgFigJpg", "Image")
            WITH loc_oPage.img_4c_ImgFigJpg
                .Top     = 255
                .Left    = 646
                .Width   = 122
                .Height  = 89
                .Stretch = 2
                .Visible = .F.
            ENDWITH

            *-- Grade principal de itens
            loc_oPage.AddObject("grd_4c_GradeItens", "Grid")
            loc_oPage.grd_4c_GradeItens.ColumnCount  = 10
            loc_oPage.grd_4c_GradeItens.RecordSource = IIF(USED("TmpFinalg"), "TmpFinalg", "")
            WITH loc_oPage.grd_4c_GradeItens
                .Top          = 173
                .Left         = 52
                .Width        = 586
                .Height       = 173
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .Visible      = .F.

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .ControlSource   = "TmpFinalg.Cpros"
                    .Width           = 90
                    .ReadOnly        = .T.
                ENDWITH

                WITH .Column2
                    .Header1.Caption = "Cor"
                    .ControlSource   = "TmpFinalg.CodCors"
                    .Width           = 35
                    .ReadOnly        = .T.
                ENDWITH

                WITH .Column3
                    .Header1.Caption = ""
                    .ControlSource   = "TmpFinalg.Linhas"
                    .Width           = 20
                    .ReadOnly        = .T.
                ENDWITH

                WITH .Column4
                    .Header1.Caption = "N" + CHR(250) + "mero"
                    .ControlSource   = "TmpFinalg.Nops"
                    .Width           = 48
                    .ReadOnly        = .T.
                ENDWITH

                WITH .Column5
                    .Header1.Caption = "Qtde Pedido"
                    .ControlSource   = "TmpFinalg.Saldo"
                    .Width           = 62
                    .ReadOnly        = .T.
                    .Text1.Alignment = 1
                ENDWITH

                WITH .Column6
                    .Header1.Caption = "Produzir"
                    .ControlSource   = "TmpFinalg.Produzir"
                    .Width           = 57
                    .ReadOnly        = .T.
                    .Text1.Alignment = 1
                ENDWITH

                WITH .Column7
                    .Header1.Caption = "Qtd Produ" + CHR(231) + CHR(227) + "o"
                    .ControlSource   = "TmpFinalg.Fabrs"
                    .Width           = 62
                    .ReadOnly        = .F.
                    .Text1.Alignment = 1
                ENDWITH

                WITH .Column8
                    .Header1.Caption = "Produzir Estq"
                    .ControlSource   = "TmpFinalg.Produzir2"
                    .Width           = 62
                    .ReadOnly        = .F.
                    .Text1.Alignment = 1
                ENDWITH

                WITH .Column9
                    .Header1.Caption = "Tam"
                    .ControlSource   = "TmpFinalg.CodTams"
                    .Width           = 33
                    .ReadOnly        = .T.
                ENDWITH

                WITH .Column10
                    .Header1.Caption = "Qtd Estoque"
                    .ControlSource   = "TmpFinalg.Estoque"
                    .Width           = 62
                    .ReadOnly        = .F.
                    .Text1.Alignment = 1
                ENDWITH
            ENDWITH

            THIS.FormatarGrid(loc_oPage.grd_4c_GradeItens)

            *-- Label e textboxes de totais da grade
            loc_oPage.AddObject("lbl_4c_LblTotais", "Label")
            WITH loc_oPage.lbl_4c_LblTotais
                .Top       = 348
                .Left      = 224
                .Width     = 42
                .Height    = 17
                .Caption   = "Totais :"
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Tot_Qtd", "TextBox")
            WITH loc_oPage.txt_4c_Tot_Qtd
                .Top       = 346
                .Left      = 271
                .Width     = 67
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Tot_prdc", "TextBox")
            WITH loc_oPage.txt_4c_Tot_prdc
                .Top       = 346
                .Left      = 339
                .Width     = 67
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Tot_Est", "TextBox")
            WITH loc_oPage.txt_4c_Tot_Est
                .Top       = 346
                .Left      = 407
                .Width     = 68
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Tot_Prz", "TextBox")
            WITH loc_oPage.txt_4c_Tot_Prz
                .Top       = 346
                .Left      = 476
                .Width     = 67
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Tot_prze", "TextBox")
            WITH loc_oPage.txt_4c_Tot_prze
                .Top       = 346
                .Left      = 543
                .Width     = 75
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            *-- Popula containers e adiciona botoes
            THIS.ConfigurarContainer5()
            THIS.ConfigurarGradeContainer3()
            THIS.ConfigurarGradeContainer1()
            THIS.ConfigurarBotoesPage1()

            *-- BINDEVENTs da grade principal
            loc_oGrid = loc_oPage.grd_4c_GradeItens
            BINDEVENT(loc_oGrid,                "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
            BINDEVENT(loc_oGrid.Column3.Text1,  "Click",             THIS, "ColC3Click")
            BINDEVENT(loc_oGrid.Column7.Text1,  "When",              THIS, "ColC7When")
            BINDEVENT(loc_oGrid.Column7.Text1,  "Valid",             THIS, "ColC7Valid")
            BINDEVENT(loc_oGrid.Column7.Text1,  "KeyPress",         THIS, "ColC7LostFocus")
            BINDEVENT(loc_oGrid.Column8.Text1,  "When",              THIS, "ColC8When")
            BINDEVENT(loc_oGrid.Column8.Text1,  "KeyPress",         THIS, "ColC8LostFocus")
            BINDEVENT(loc_oGrid.Column10.Text1, "When",              THIS, "ColC10When")
            BINDEVENT(loc_oGrid.Column10.Text1, "Valid",             THIS, "ColC10Valid")
            BINDEVENT(loc_oGrid.Column10.Text1, "KeyPress",         THIS, "ColC10LostFocus")
            BINDEVENT(loc_oPage.img_4c_ImgFigJpg, "Click",          THIS, "ImgFigJpgClick")

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar lista: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainer5 - Controles de info do produto (barra superior)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer5()

        LOCAL loc_oCnt

        TRY
            loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container5

            loc_oCnt.AddObject("lbl_4c_Lab_periodo", "Label")
            WITH loc_oCnt.lbl_4c_Lab_periodo
                .Top       = 2
                .Left      = 8
                .Width     = 105
                .Height    = 15
                .Caption   = "Per" + CHR(237) + "odo: xx meses"
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Lab_produto", "Label")
            WITH loc_oCnt.lbl_4c_Lab_produto
                .Top       = 18
                .Left      = 8
                .Width     = 127
                .Height    = 15
                .Caption   = "Referencia Analisada :"
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_Cpros", "TextBox")
            WITH loc_oCnt.txt_4c_Cpros
                .Top      = 16
                .Left     = 141
                .Width    = 108
                .Height   = 19
                .ReadOnly = .T.
                .Visible  = .F.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblQtdVenda", "Label")
            WITH loc_oCnt.lbl_4c_LblQtdVenda
                .Top       = 18
                .Left      = 269
                .Width     = 83
                .Height    = 15
                .Caption   = "Qtde Vendida :"
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_Tot_Venda", "TextBox")
            WITH loc_oCnt.txt_4c_Tot_Venda
                .Top       = 17
                .Left      = 349
                .Width     = 80
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblQtdMin", "Label")
            WITH loc_oCnt.lbl_4c_LblQtdMin
                .Top       = 18
                .Left      = 448
                .Width     = 164
                .Height    = 15
                .Caption   = "Qtde M" + CHR(237) + "nima Para Produ" + CHR(231) + CHR(227) + "o :"
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_Minima", "TextBox")
            WITH loc_oCnt.txt_4c_Minima
                .Top       = 17
                .Left      = 623
                .Width     = 80
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar Container5: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeContainer3 - Grade de estoque disponivel por grupo/conta
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeContainer3()

        LOCAL loc_oCnt, loc_oGrid

        TRY
            loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container3

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .Top       = 1
                .Left      = 0
                .Width     = 363
                .Height    = 16
                .Caption   = "Estoque Dispon" + CHR(237) + "vel"
                .BackStyle = 0
                .FontBold  = .T.
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_EstDisp", "Grid")
            loc_oCnt.grd_4c_EstDisp.ColumnCount  = 6
            loc_oCnt.grd_4c_EstDisp.RecordSource = IIF(USED("TmpSaldG"), "TmpSaldG", "")
            WITH loc_oCnt.grd_4c_EstDisp
                .Top          = 15
                .Left         = 3
                .Width        = 358
                .Height       = 147
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .ReadOnly     = .F.
                .Visible      = .F.

                WITH .Column1
                    .Header1.Caption = "Grupo"
                    .ControlSource   = "TmpSaldG.Grupos"
                    .Width           = 50
                    .ReadOnly        = .T.
                ENDWITH

                WITH .Column2
                    .Header1.Caption = "Conta"
                    .ControlSource   = "TmpSaldG.Estos"
                    .Width           = 50
                    .ReadOnly        = .T.
                ENDWITH

                WITH .Column3
                    .Header1.Caption = "Atual"
                    .ControlSource   = "TmpSaldG.Saldo"
                    .Width           = 60
                    .ReadOnly        = .T.
                    .Text1.Alignment = 1
                ENDWITH

                WITH .Column4
                    .Header1.Caption = "Utilizado"
                    .ControlSource   = "TmpSaldG.Disps"
                    .Width           = 60
                    .ReadOnly        = .T.
                    .Text1.Alignment = 1
                ENDWITH

                WITH .Column5
                    .Header1.Caption = "Dispon" + CHR(237) + "vel"
                    .ControlSource   = "TmpSaldG.Disps"
                    .Width           = 60
                    .ReadOnly        = .T.
                    .Text1.Alignment = 1
                ENDWITH

                WITH .Column6
                    .Header1.Caption = "Prior"
                    .ControlSource   = "TmpSaldG.Priors"
                    .Width           = 50
                    .ReadOnly        = .T.
                    .Text1.Alignment = 1
                ENDWITH
            ENDWITH

            THIS.FormatarGrid(loc_oCnt.grd_4c_EstDisp)

            loc_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oCnt.lbl_4c_Label2
                .Top       = 163
                .Left      = 128
                .Width     = 42
                .Height    = 17
                .Caption   = "Totais :"
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
            WITH loc_oCnt.txt_4c_Tot_Qtd
                .Top       = 161
                .Left      = 174
                .Width     = 58
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
            WITH loc_oCnt.txt_4c_Tot_Est
                .Top       = 161
                .Left      = 234
                .Width     = 58
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_Tot_Prz", "TextBox")
            WITH loc_oCnt.txt_4c_Tot_Prz
                .Top       = 161
                .Left      = 292
                .Width     = 58
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            *-- BINDEVENTs: coluna Prior editavel somente quando producao plena
            loc_oGrid = loc_oCnt.grd_4c_EstDisp
            BINDEVENT(loc_oGrid.Column6.Text1, "When",      THIS, "EstDispC6When")
            BINDEVENT(loc_oGrid.Column6.Text1, "KeyPress", THIS, "EstDispC6LostFocus")

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar Container3: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeContainer1 - Grade de estoque em producao por fase/OP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeContainer1()

        LOCAL loc_oCnt

        TRY
            loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Container1

            loc_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCnt.lbl_4c_Label1
                .Top       = 1
                .Left      = 1
                .Width     = 305
                .Height    = 16
                .Caption   = "Estoque Em Produ" + CHR(231) + CHR(227) + "o"
                .BackStyle = 0
                .FontBold  = .T.
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("grd_4c_EstProd", "Grid")
            loc_oCnt.grd_4c_EstProd.ColumnCount  = 5
            loc_oCnt.grd_4c_EstProd.RecordSource = IIF(USED("TmpFinal"), "TmpFinal", "")
            WITH loc_oCnt.grd_4c_EstProd
                .Top          = 15
                .Left         = 2
                .Width        = 303
                .Height       = 99
                .RecordMark   = .F.
                .DeleteMark   = .F.
                .ReadOnly     = .T.
                .Visible      = .F.

                WITH .Column1
                    .Header1.Caption = "Fase"
                    .ControlSource   = "TmpFinal.Dopes"
                    .Width           = 55
                ENDWITH

                WITH .Column2
                    .Header1.Caption = "Disponivel"
                    .ControlSource   = "TmpFinal.Saldo"
                    .Width           = 62
                    .Text1.Alignment = 1
                ENDWITH

                WITH .Column3
                    .Header1.Caption = "Utilizado"
                    .ControlSource   = "TmpFinal.Estoque"
                    .Width           = 62
                    .Text1.Alignment = 1
                ENDWITH

                WITH .Column4
                    .Header1.Caption = "Nop"
                    .ControlSource   = "TmpFinal.Produzir"
                    .Width           = 62
                    .Text1.Alignment = 1
                ENDWITH

                WITH .Column5
                    .Header1.Caption = "Prior"
                    .ControlSource   = "TmpFinal.Fabrs"
                    .Width           = 55
                    .Text1.Alignment = 1
                ENDWITH
            ENDWITH

            THIS.FormatarGrid(loc_oCnt.grd_4c_EstProd)

            loc_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oCnt.lbl_4c_Label2
                .Top       = 115
                .Left      = 102
                .Width     = 42
                .Height    = 17
                .Caption   = "Totais :"
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_Tot_Qtd", "TextBox")
            WITH loc_oCnt.txt_4c_Tot_Qtd
                .Top       = 113
                .Left      = 145
                .Width     = 61
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_Tot_Est", "TextBox")
            WITH loc_oCnt.txt_4c_Tot_Est
                .Top       = 113
                .Left      = 207
                .Width     = 61
                .Height    = 19
                .ReadOnly  = .T.
                .Alignment = 1
                .Visible   = .F.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar Container1: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesPage1 - Adiciona botoes de acao na Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesPage1()

        LOCAL loc_oPage

        TRY
            loc_oPage = THIS.pgf_4c_1.Page1

            loc_oPage.AddObject("cmd_4c_Pedras", "CommandButton")
            WITH loc_oPage.cmd_4c_Pedras
                .Top         = 2
                .Left        = 348
                .Width       = 75
                .Height      = 75
                .Caption     = "Requisi" + CHR(231) + CHR(245) + "es"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Requisi" + CHR(231) + CHR(245) + "es de Material"
            ENDWITH

            loc_oPage.AddObject("cmd_4c_SelEstoque", "CommandButton")
            WITH loc_oPage.cmd_4c_SelEstoque
                .Top         = 2
                .Left        = 423
                .Width       = 75
                .Height      = 75
                .Caption     = "Estoques"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Selecionar Estoque"
            ENDWITH

            loc_oPage.AddObject("cmd_4c_Disponivel", "CommandButton")
            WITH loc_oPage.cmd_4c_Disponivel
                .Top         = 2
                .Left        = 498
                .Width       = 75
                .Height      = 75
                .Caption     = "Dispon" + CHR(237) + "veis"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Dispon" + CHR(237) + "vel por Tamanho"
            ENDWITH

            loc_oPage.AddObject("cmd_4c_TotLinha", "CommandButton")
            WITH loc_oPage.cmd_4c_TotLinha
                .Top         = 2
                .Left        = 573
                .Width       = 75
                .Height      = 75
                .Caption     = "Total/Linhas"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Totais por Linha"
            ENDWITH

            loc_oPage.AddObject("cmd_4c_Processar", "CommandButton")
            WITH loc_oPage.cmd_4c_Processar
                .Top         = 2
                .Left        = 648
                .Width       = 75
                .Height      = 75
                .Caption     = "Processar"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Processar Globaliza" + CHR(231) + CHR(227) + "o"
            ENDWITH

            loc_oPage.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH loc_oPage.cmd_4c_Encerrar
                .Top         = 2
                .Left        = 723
                .Width       = 75
                .Height      = 75
                .Caption     = "Encerrar"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Encerrar"
            ENDWITH

            loc_oPage.AddObject("cmd_4c_Alteraqtd", "CommandButton")
            WITH loc_oPage.cmd_4c_Alteraqtd
                .Top         = 189
                .Left        = 687
                .Width       = 40
                .Height      = 40
                .Caption     = "Alt"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Themes      = .T.
                .Visible     = .F.
                .ToolTipText = "Autorizar edi" + CHR(231) + CHR(227) + "o de quantidade"
            ENDWITH

            *-- BINDEVENTs
            BINDEVENT(loc_oPage.cmd_4c_Pedras,     "Click", THIS, "BtnPedrasClick")
            BINDEVENT(loc_oPage.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
            BINDEVENT(loc_oPage.cmd_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")
            BINDEVENT(loc_oPage.cmd_4c_TotLinha,   "Click", THIS, "BtnTotLinhaClick")
            BINDEVENT(loc_oPage.cmd_4c_Processar,  "Click", THIS, "BtnProcessarClick")
            BINDEVENT(loc_oPage.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
            BINDEVENT(loc_oPage.cmd_4c_Alteraqtd,  "Click", THIS, "BtnAlteraqtdClick")

        CATCH TO loc_oErro
            MsgErro("Erro ao configurar bot" + CHR(245) + "es: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarVisibilidadeBotoes - Reaplica visibilidade apos TornarControlesVisiveis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarVisibilidadeBotoes()

        LOCAL loc_oPage

        TRY
            loc_oPage = THIS.pgf_4c_1.Page1
            IF PEMSTATUS(loc_oPage, "cmd_4c_Disponivel", 5)
                loc_oPage.cmd_4c_Disponivel.Visible = .F.
            ENDIF
            IF PEMSTATUS(loc_oPage, "cmd_4c_SelEstoque", 5) AND ;
               VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oPage.cmd_4c_SelEstoque.Visible = THIS.this_oBusinessObject.this_lSelEstoqueVisivel
            ENDIF
            IF PEMSTATUS(loc_oPage, "cmd_4c_Pedras", 5) AND ;
               VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oPage.cmd_4c_Pedras.Visible = THIS.this_oBusinessObject.this_lPedrasVisiveis
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao ajustar visibilidade: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa pagina e gerencia estado das demais
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)

        LOCAL loc_oPgf

        TRY
            loc_oPgf = THIS.pgf_4c_1

            DO CASE
            CASE par_nPagina <= 2
                loc_oPgf.Page1.Enabled = .T.
                loc_oPgf.Page2.Enabled = .T.
                loc_oPgf.Page3.Enabled = .F.
                loc_oPgf.Page4.Enabled = .F.
                loc_oPgf.Page5.Enabled = .F.
                loc_oPgf.Page6.Enabled = .F.
            CASE par_nPagina = 3
                loc_oPgf.Page3.Enabled = .T.
                loc_oPgf.Page4.Enabled = .F.
                loc_oPgf.Page5.Enabled = .F.
                loc_oPgf.Page6.Enabled = .F.
            CASE par_nPagina = 4
                loc_oPgf.Page3.Enabled = .F.
                loc_oPgf.Page4.Enabled = .T.
                loc_oPgf.Page5.Enabled = .F.
                loc_oPgf.Page6.Enabled = .F.
            CASE par_nPagina = 5
                loc_oPgf.Page3.Enabled = .F.
                loc_oPgf.Page4.Enabled = .F.
                loc_oPgf.Page5.Enabled = .T.
                loc_oPgf.Page6.Enabled = .F.
            CASE par_nPagina = 6
                loc_oPgf.Page3.Enabled = .F.
                loc_oPgf.Page4.Enabled = .F.
                loc_oPgf.Page5.Enabled = .F.
                loc_oPgf.Page6.Enabled = .T.
            ENDCASE

            loc_oPgf.ActivePage = par_nPagina

        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensAfterRowColChange - Atualiza painel ao mudar linha (BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensAfterRowColChange
        LPARAMETERS par_nColIndex

        LOCAL loc_oPage, loc_oCnt3, loc_oCnt5, loc_cCapCor, loc_cCapTam

        loc_cCapCor = ""
        loc_cCapTam = ""

        IF !USED("TmpFinalg") OR BOF("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        TRY
            loc_oPage = THIS.pgf_4c_1.Page1

            *-- Filtra TmpSaldG pelo item atual
            IF USED("TmpSaldG")
                SELECT TmpSaldG
                SET ORDER TO Cpros
                SET KEY TO ALLTRIM(TmpFinalg.Cpros) + ALLTRIM(TmpFinalg.CodCors) + ;
                    ALLTRIM(TmpFinalg.CodTams)
                GO TOP
            ENDIF

            *-- Filtra TmpFinal pelo item atual (Container1)
            IF USED("TmpFinal")
                SELECT TmpFinal
                SET ORDER TO Cpros
                SET KEY TO ALLTRIM(TmpFinalg.Cpros) + ALLTRIM(TmpFinalg.CodCors) + ;
                    ALLTRIM(TmpFinalg.CodTams)
                GO TOP
            ENDIF

            *-- Totais de Container3 via TmpSaldo (registro unico por produto/cor/tam)
            IF USED("TmpSaldo") AND SEEK(ALLTRIM(TmpFinalg.Cpros) + ;
               ALLTRIM(TmpFinalg.CodCors) + ALLTRIM(TmpFinalg.CodTams), "TmpSaldo")

                loc_oCnt3 = loc_oPage.cnt_4c_Container3
                IF PEMSTATUS(loc_oCnt3, "txt_4c_Tot_Qtd", 5)
                    loc_oCnt3.txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
                    loc_oCnt3.txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
                    loc_oCnt3.txt_4c_Tot_Prz.Value = TmpSaldo.Disps
                ENDIF

                loc_cCapCor = IIF(!EMPTY(ALLTRIM(TmpFinalg.CodCors)), ;
                    " Cor:" + ALLTRIM(TmpFinalg.CodCors), "")
                loc_cCapTam = IIF(!EMPTY(ALLTRIM(TmpFinalg.CodTams)), ;
                    " Tam:" + ALLTRIM(TmpFinalg.CodTams), "")
                IF PEMSTATUS(loc_oCnt3, "lbl_4c_Label1", 5)
                    loc_oCnt3.lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + ;
                        "vel " + ALLTRIM(TmpFinalg.Cpros) + loc_cCapCor + loc_cCapTam
                ENDIF

                IF PEMSTATUS(loc_oCnt3, "grd_4c_EstDisp", 5)
                    loc_oCnt3.grd_4c_EstDisp.Refresh
                ENDIF
            ENDIF

            *-- Atualiza Container1 (TmpFinal ja filtrado)
            IF PEMSTATUS(loc_oPage.cnt_4c_Container1, "grd_4c_EstProd", 5)
                loc_oPage.cnt_4c_Container1.grd_4c_EstProd.Refresh
            ENDIF

            *-- Atualiza Container5 com produto/cor/tam
            loc_oCnt5 = loc_oPage.cnt_4c_Container5
            IF PEMSTATUS(loc_oCnt5, "txt_4c_Cpros", 5)
                loc_oCnt5.txt_4c_Cpros.Value = ALLTRIM(TmpFinalg.Cpros) + ;
                    loc_cCapCor + loc_cCapTam
            ENDIF
            IF PEMSTATUS(loc_oCnt5, "txt_4c_Minima", 5)
                loc_oCnt5.txt_4c_Minima.Value = TmpFinalg.QtdMins
            ENDIF

            *-- Carrega foto
            THIS.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros))

        CATCH TO loc_oErro
            MsgErro("Erro em AfterRowColChange: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFotoProduto - Carrega imagem JPG do produto via SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarFotoProduto(par_cCpros)

        LOCAL loc_cArquivo, loc_cSql, loc_cFoto, loc_oImg

        loc_cArquivo = ""
        loc_cFoto    = ""

        TRY
            loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
            loc_cSql     = "SELECT a.cpros, a.FigJpgs FROM SigCdPro a " + ;
                "WHERE a.cpros = " + EscaparSQL(par_cCpros)

            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FotoPro") > 0 AND ;
               USED("cursor_4c_FotoPro") AND RECCOUNT("cursor_4c_FotoPro") > 0
                SELECT cursor_4c_FotoPro
                IF !EMPTY(cursor_4c_FotoPro.FigJpgs) AND !ISNULL(cursor_4c_FotoPro.FigJpgs)
                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FotoPro.FigJpgs, ;
                        "data:image/png;base64,",  ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,",  ""), 14)
                    =STRTOFILE(loc_cFoto, loc_cArquivo)
                    loc_oImg = THIS.pgf_4c_1.Page1.img_4c_ImgFigJpg
                    IF FILE(loc_cArquivo) AND PEMSTATUS(loc_oImg, "Picture", 5)
                        loc_oImg.Picture = loc_cArquivo
                        loc_oImg.Visible = .T.
                    ENDIF
                ELSE
                    THIS.pgf_4c_1.Page1.img_4c_ImgFigJpg.Visible = .F.
                ENDIF
                USE IN cursor_4c_FotoPro
            ELSE
                IF PEMSTATUS(THIS.pgf_4c_1.Page1, "img_4c_ImgFigJpg", 5)
                    THIS.pgf_4c_1.Page1.img_4c_ImgFigJpg.Visible = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar foto: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotaisPage1 - Calcula e exibe totais da grade de itens
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTotaisPage1()

        LOCAL loc_oPage, loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs
        LOCAL loc_nProduzir2, loc_nRecno

        IF !USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
            RETURN
        ENDIF

        TRY
            loc_oPage = THIS.pgf_4c_1.Page1
            IF PEMSTATUS(loc_oPage, "txt_4c_Tot_Qtd", 5)

                loc_nSaldo     = 0
                loc_nEstoque   = 0
                loc_nProduzir  = 0
                loc_nFabrs     = 0
                loc_nProduzir2 = 0
                loc_nRecno     = IIF(!BOF("TmpFinalg") AND !EOF("TmpFinalg"), ;
                    RECNO("TmpFinalg"), 0)

                SELECT TmpFinalg
                SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
                    TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs, loc_nProduzir2

                IF loc_nRecno > 0 AND RECCOUNT("TmpFinalg") >= loc_nRecno
                    GO loc_nRecno IN TmpFinalg
                ENDIF

                WITH loc_oPage
                    .txt_4c_Tot_Qtd.Value  = loc_nSaldo
                    .txt_4c_Tot_Est.Value  = loc_nEstoque
                    .txt_4c_Tot_Prz.Value  = loc_nProduzir
                    .txt_4c_Tot_prdc.Value = loc_nFabrs
                    .txt_4c_Tot_prze.Value = loc_nProduzir2
                    .txt_4c_Tot_Qtd.Refresh
                    .txt_4c_Tot_Est.Refresh
                    .txt_4c_Tot_Prz.Refresh
                    .txt_4c_Tot_prdc.Refresh
                    .txt_4c_Tot_prze.Refresh
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar totais: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ColC7When - Handler When da coluna 7 (Fabrs) - salva valor anterior
    *--------------------------------------------------------------------------
    PROCEDURE ColC7When

        LOCAL loc_lResultado

        loc_lResultado = .T.
        TRY
            IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                THIS.this_nOldValue = TmpFinalg.Fabrs
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ColC7When: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ColC7Valid - Handler Valid da coluna 7 (Fabrs) - valida quantidade
    *--------------------------------------------------------------------------
    PROCEDURE ColC7Valid

        LOCAL loc_lResultado, loc_nNewVal, loc_oGrid, loc_nOld

        loc_lResultado = 1

        TRY
            loc_oGrid   = THIS.pgf_4c_1.Page1.grd_4c_GradeItens
            loc_nNewVal = loc_oGrid.Column7.Text1.Value
            loc_nOld    = THIS.this_nOldValue

            IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND USED("TmpSaldU")
                IF !SEEK(ALLTRIM(TmpFinalg.Cpros), "TmpSaldU", "Cpros")
                    INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
                ENDIF

                IF loc_nNewVal <> loc_nOld AND TmpSaldU.KeySelmp
                    IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + ;
                        "o Manual de OP." + CHR(13) + ;
                        "O sistema ir" + CHR(225) + " acionar o modo autom" + ;
                        CHR(225) + "tico. Deseja Continuar?")
                        loc_oGrid.Column7.Text1.Value = loc_nOld
                        loc_lResultado = 0
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lResultado = 1 AND USED("TmpFinalg") AND !EOF("TmpFinalg")
                DO CASE
                CASE loc_nNewVal = loc_nOld
                    *-- Sem mudanca
                CASE loc_nNewVal < 0
                    MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo!!!")
                    loc_oGrid.Column7.Text1.Value = loc_nOld
                    loc_lResultado = 0
                CASE loc_nNewVal > TmpFinalg.Saldo
                    MsgAviso("A Quantidade n" + CHR(227) + "o pode ser maior que a do Pedido!!!")
                    loc_oGrid.Column7.Text1.Value = loc_nOld
                    loc_lResultado = 0
                OTHERWISE
                    SELECT TmpFinalg
                    REPLACE Fabrs WITH loc_nNewVal
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o da coluna 7: " + ;
                loc_oErro.Message, "Erro")
            loc_lResultado = 0
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ColC7LostFocus - Handler LostFocus da coluna 7 - atualiza totais
    *--------------------------------------------------------------------------
    PROCEDURE ColC7LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        THIS.AtualizarTotaisPage1()
    ENDPROC

    *--------------------------------------------------------------------------
    * ColC8When - Handler When da coluna 8 (Produzir2) - verifica liberacao
    *--------------------------------------------------------------------------
    PROCEDURE ColC8When

        LOCAL loc_lResultado

        loc_lResultado = IIF(THIS.this_lLiberado, 1, 0)
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ColC8LostFocus - Handler LostFocus da coluna 8 - reseta liberacao
    *--------------------------------------------------------------------------
    PROCEDURE ColC8LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        THIS.this_lLiberado = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ColC10When - Handler When da coluna 10 (Estoque) - salva e checa disponivel
    *--------------------------------------------------------------------------
    PROCEDURE ColC10When

        LOCAL loc_lResultado, loc_cSql, loc_lMostraDisp

        loc_lResultado  = .T.
        loc_lMostraDisp = .F.

        TRY
            IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                THIS.this_nOldValue = TmpFinalg.Estoque
            ENDIF

            IF PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Disponivel", 5)
                THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .F.
            ENDIF

            *-- Em modo reserva com estoque zero, verifica tipo do grupo
            IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND ;
               VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.this_lReserva AND TmpFinalg.Estoque = 0
                    loc_cSql = "SELECT a.CGrus, b.TipoEstos " + ;
                        "FROM SigCdPro a INNER JOIN SigCdGrp b ON a.CGrus = b.CGrus " + ;
                        "WHERE a.CPros = " + EscaparSQL(ALLTRIM(TmpFinalg.Cpros))
                    IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpTipo") > 0 AND ;
                       USED("cursor_4c_GrpTipo") AND RECCOUNT("cursor_4c_GrpTipo") > 0
                        SELECT cursor_4c_GrpTipo
                        loc_lMostraDisp = INLIST(cursor_4c_GrpTipo.TipoEstos, 3, 4)
                        USE IN cursor_4c_GrpTipo
                        IF loc_lMostraDisp AND ;
                           PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Disponivel", 5)
                            THIS.pgf_4c_1.Page1.cmd_4c_Disponivel.Visible = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ColC10When: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ColC10Valid - Handler Valid da coluna 10 (Estoque) - valida quantidade
    *--------------------------------------------------------------------------
    PROCEDURE ColC10Valid

        LOCAL loc_lResultado, loc_nNewVal, loc_oGrid, loc_nOld

        loc_lResultado = 1

        TRY
            loc_oGrid   = THIS.pgf_4c_1.Page1.grd_4c_GradeItens
            loc_nNewVal = loc_oGrid.Column10.Text1.Value
            loc_nOld    = THIS.this_nOldValue

            IF USED("TmpFinalg") AND !EOF("TmpFinalg") AND USED("TmpSaldU")
                IF !SEEK(ALLTRIM(TmpFinalg.Cpros), "TmpSaldU", "Cpros")
                    INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
                ENDIF

                IF loc_nNewVal <> loc_nOld AND TmpSaldU.KeySelm
                    IF !MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + ;
                        "o Manual de estoque." + CHR(13) + ;
                        "O sistema ir" + CHR(225) + " acionar o modo autom" + ;
                        CHR(225) + "tico. Deseja Continuar?")
                        loc_oGrid.Column10.Text1.Value = loc_nOld
                        loc_lResultado = 0
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lResultado = 1 AND USED("TmpFinalg") AND !EOF("TmpFinalg")
                DO CASE
                CASE loc_nNewVal = loc_nOld
                    *-- Sem mudanca
                CASE loc_nNewVal < 0
                    MsgAviso("A quantidade n" + CHR(227) + "o pode ser um valor negativo!!!")
                    loc_oGrid.Column10.Text1.Value = loc_nOld
                    loc_lResultado = 0
                OTHERWISE
                    SELECT TmpFinalg
                    REPLACE Estoque WITH loc_nNewVal
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o da coluna 10: " + ;
                loc_oErro.Message, "Erro")
            loc_lResultado = 0
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ColC10LostFocus - Handler LostFocus da coluna 10 - atualiza totais
    *--------------------------------------------------------------------------
    PROCEDURE ColC10LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        THIS.AtualizarTotaisPage1()
    ENDPROC

    *--------------------------------------------------------------------------
    * EstDispC6When - Handler When da coluna Prior do grd_4c_EstDisp
    *--------------------------------------------------------------------------
    PROCEDURE EstDispC6When

        LOCAL loc_lResultado

        loc_lResultado = 0
        TRY
            IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                loc_lResultado = IIF(TmpFinalg.Produzir + TmpFinalg.Fabrs = TmpFinalg.Saldo, 1, 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em EstDispC6When: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * EstDispC6LostFocus - Handler LostFocus da coluna Prior do grd_4c_EstDisp
    *--------------------------------------------------------------------------
    PROCEDURE EstDispC6LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        TRY
            IF USED("TmpSaldG") AND RECCOUNT("TmpSaldG") > 0
                SELECT TmpSaldG
                SKIP
                SKIP -1
                IF PEMSTATUS(THIS.pgf_4c_1.Page1.cnt_4c_Container3, "grd_4c_EstDisp", 5)
                    THIS.pgf_4c_1.Page1.cnt_4c_Container3.grd_4c_EstDisp.Refresh
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em EstDispC6LostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ColC3Click - Handler Click na coluna 3 - navega para Page2 (detalhes)
    *--------------------------------------------------------------------------
    PROCEDURE ColC3Click

        TRY
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro("Erro ao navegar para Page2: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgClick - Handler Click na imagem do produto
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgClick

        TRY
            IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                THIS.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros))
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar foto: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnPedrasClick - Abre Page6 com requisicoes de material
    *--------------------------------------------------------------------------
    PROCEDURE BtnPedrasClick

        LOCAL loc_lResultado, loc_cCpro

        loc_lResultado = .F.
        TRY
            IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                loc_cCpro = ALLTRIM(TmpFinalg.Cpros)

                IF USED("SelPedra")
                    IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
                        THIS.pgf_4c_1.Page6.grd_4c_GradePedra.RecordSource = ""
                    ENDIF
                    USE IN SelPedra
                ENDIF

                IF USED("CrSigCdPac")
                    SELECT Cpros, Dpros, Cunis, Qtdes, CodPros, ;
                        SPACE(14) AS Cpro2s ;
                        FROM CrSigCdPac ;
                        INTO CURSOR SelPedra ORDER BY Cpros READWRITE

                    IF RECCOUNT("SelPedra") > 0
                        IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
                            THIS.pgf_4c_1.Page6.grd_4c_GradePedra.RecordSource = "SelPedra"
                        ENDIF
                        IF PEMSTATUS(THIS.pgf_4c_1.Page6, "txt_4c_Cpros", 5)
                            THIS.pgf_4c_1.Page6.txt_4c_Cpros.Value = loc_cCpro
                        ENDIF
                        THIS.AlternarPagina(6)
                        loc_lResultado = .T.
                    ELSE
                        MsgAviso("Nenhuma requisi" + CHR(231) + CHR(227) + ;
                            "o de material para este produto.")
                        IF USED("SelPedra")
                            USE IN SelPedra
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao exibir requisi" + CHR(231) + CHR(245) + "es: " + ;
                loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelEstoqueClick - Abre Page4 com selecao de estoque disponivel
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelEstoqueClick

        LOCAL loc_lResultado, loc_cCpro, loc_cCor, loc_cTam

        loc_lResultado = .F.
        TRY
            IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                loc_cCpro = ALLTRIM(TmpFinalg.Cpros)
                loc_cCor  = ALLTRIM(TmpFinalg.CodCors)
                loc_cTam  = ALLTRIM(TmpFinalg.CodTams)

                IF USED("TmpDisp")
                    IF PEMSTATUS(THIS.pgf_4c_1.Page4, "grd_4c_GradeDisp", 5)
                        THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.RecordSource = ""
                    ENDIF
                    USE IN TmpDisp
                ENDIF

                SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
                    0.000 AS Utilizar ;
                    FROM TmpSaldG ;
                    WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND ;
                    CodTams = m.loc_cTam AND Disps > 0 ;
                    INTO CURSOR TmpDisp ORDER BY Priors, Grupos, Estos, Cpros READWRITE

                IF RECCOUNT("TmpDisp") > 0
                    IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Cpros", 5)
                        THIS.pgf_4c_1.Page4.txt_4c_Cpros.Value = loc_cCpro + ;
                            IIF(!EMPTY(loc_cCor), " Cor:" + loc_cCor, "") + ;
                            IIF(!EMPTY(loc_cTam), " Tam:" + loc_cTam, "")
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_pedida", 5)
                        THIS.pgf_4c_1.Page4.txt_4c_Qt_pedida.Value = TmpFinalg.Saldo
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_Selec", 5)
                        THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = 0
                    ENDIF
                    THIS.AlternarPagina(4)
                    loc_lResultado = .T.
                ELSE
                    MsgAviso("Nenhum estoque dispon" + CHR(237) + "vel para este item.")
                    IF USED("TmpDisp")
                        USE IN TmpDisp
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao selecionar estoque: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDisponivelClick - Abre Page5 com disponivel por tamanho
    *--------------------------------------------------------------------------
    PROCEDURE BtnDisponivelClick

        LOCAL loc_lResultado, loc_cCpro, loc_cCor

        loc_lResultado = .F.
        TRY
            IF !USED("TmpFinalg") OR EOF("TmpFinalg")
                *-- sem dados
            ELSE
                IF TmpFinalg.Estoque <> 0 OR TmpFinalg.Fabrs <> 0
                MsgAviso("Quantidade de Estoque e Produ" + CHR(231) + CHR(227) + ;
                    "o tem estar Zero antes deste Processo!!!")
                IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                    THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
                ENDIF
            ELSE
                loc_cCpro = ALLTRIM(TmpFinalg.Cpros)
                loc_cCor  = ALLTRIM(TmpFinalg.CodCors)

                IF USED("TmpDisp")
                    IF PEMSTATUS(THIS.pgf_4c_1.Page5, "grd_4c_GradeDisp", 5)
                        THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.RecordSource = ""
                    ENDIF
                    USE IN TmpDisp
                ENDIF

                SELECT Cpros, CodCors, CodTams, Disps, 0.000 AS Utilizar ;
                    FROM TmpSaldo ;
                    WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
                    INTO CURSOR TmpDisp ORDER BY CodTams READWRITE

                IF RECCOUNT("TmpDisp") > 0
                    IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Cpros", 5)
                        THIS.pgf_4c_1.Page5.txt_4c_Cpros.Value = loc_cCpro + ;
                            IIF(!EMPTY(loc_cCor), " Cor:" + loc_cCor, "")
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_pedida", 5)
                        THIS.pgf_4c_1.Page5.txt_4c_Qt_pedida.Value = TmpFinalg.Saldo
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_Selec", 5)
                        THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = 0
                    ENDIF
                    THIS.AlternarPagina(5)
                    loc_lResultado = .T.
                ELSE
                    MsgAviso("Nenhum disponivel para este item.")
                    IF USED("TmpDisp")
                        USE IN TmpDisp
                    ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao exibir dispon" + CHR(237) + "veis: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnTotLinhaClick - Agrupa totais por linha e exibe na Page3
    *--------------------------------------------------------------------------
    PROCEDURE BtnTotLinhaClick

        LOCAL loc_lResultado

        loc_lResultado = .F.
        TRY
            IF !USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para totalizar.")
            ELSE
                IF USED("TmpLinha")
                    IF PEMSTATUS(THIS.pgf_4c_1.Page3, "grd_4c_GradeLinhas", 5)
                        THIS.pgf_4c_1.Page3.grd_4c_GradeLinhas.RecordSource = ""
                    ENDIF
                ENDIF

                SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, ;
                    SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
                    FROM TmpFinalg GROUP BY 1 ;
                    UNION ALL ;
                    SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, ;
                    SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, ;
                    SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
                    FROM TmpFinalg GROUP BY 1 ;
                    INTO CURSOR TmpLinha ORDER BY 2, 1

                THIS.AlternarPagina(3)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao calcular totais por linha: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Processa globalizacao via BO
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick

        LOCAL loc_lResultado

        loc_lResultado = .F.
        THIS.MostrarAguarde("Processando Globaliza" + CHR(231) + CHR(227) + "o...")
        TRY
            IF THIS.this_oBusinessObject.ProcessarGlobalizacao()
                THIS.AtualizarTotaisPage1()
                IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                    THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao processar: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.OcultarAguarde()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o form filho e reativa o form pai
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick

        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao encerrar: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraqtdClick - Autoriza edicao de quantidade para estoque (senha)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraqtdClick

        LOCAL loc_lResultado, loc_cString, loc_cRetorno, loc_lOk

        loc_lResultado = .F.
        loc_cRetorno   = ""
        loc_lOk        = .F.

        TRY
            IF !USED("TmpFinalg") OR EOF("TmpFinalg")
                *-- sem acao
            ELSE
                IF TmpFinalg.Produzir2 = 0
                MsgAviso("Referencia Sem Quantidade a Produzir para Estoque!!!")
                IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                    THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
                ENDIF
            ELSE
                loc_cString = ALLTRIM(TmpFinalg.Cpros) + " Qt.Min:" + ;
                    ALLTRIM(TRANSFORM(TmpFinalg.QtdMins, "@Z 99999.999")) + " " + ;
                    "Qt.Est:" + ALLTRIM(TRANSFORM(TmpFinalg.Produzir2, "@Z 99999.999"))

                DO FORM SigOpSen WITH "PRDZRISCO", loc_cString, "" TO loc_cRetorno

                CLEAR TYPEAHEAD
                loc_lOk = (LEFT(loc_cRetorno, 1) = "*")

                IF loc_lOk
                    THIS.this_lLiberado = .T.
                    IF PEMSTATUS(THIS.pgf_4c_1.Page1.grd_4c_GradeItens, "Column8", 5)
                        THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Column8.SetFocus
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    MsgAviso("Altera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                        "o autorizada!!!")
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Alteraqtd: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Pagina2Activate - Inicializa selecao de estoque/producao ao entrar na Page2
    *--------------------------------------------------------------------------
    PROCEDURE Pagina2Activate()
        LOCAL loc_cCpros, loc_nOldRecno

        TRY
            IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                loc_cCpros = ALLTRIM(TmpFinalg.Cpros)

                THIS.this_nTotSEst = TmpFinalg.Estoque
                THIS.this_nTotSPrc = TmpFinalg.Fabrs

                IF USED("TmpFinal")
                    loc_nOldRecno = IIF(RECCOUNT("TmpFinal") > 0, RECNO("TmpFinal"), 0)
                    SELECT TmpFinal
                    SET KEY TO (m.loc_cCpros)
                    THIS.AtualizarTotaisPage2()
                    IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
                        GO loc_nOldRecno IN TmpFinal
                    ENDIF
                ENDIF

                IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_sEst", 5)
                    THIS.pgf_4c_1.Page2.txt_4c_Tot_sEst.Value = THIS.this_nTotSEst
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_sPrc", 5)
                    THIS.pgf_4c_1.Page2.txt_4c_Tot_sPrc.Value = THIS.this_nTotSPrc
                ENDIF

                IF PEMSTATUS(THIS.pgf_4c_1.Page2, "edt_4c_ObsItens", 5) AND USED("TmpFinal") AND !EOF("TmpFinal")
                    THIS.pgf_4c_1.Page2.edt_4c_ObsItens.Value = ALLTRIM(TmpFinal.CodObs)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Pagina2Activate: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotaisPage2 - Recalcula totais do grid de Page2
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTotaisPage2()
        LOCAL loc_nOldRecno, loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs

        TRY
            IF USED("TmpFinal") AND RECCOUNT("TmpFinal") > 0
                loc_nOldRecno = RECNO("TmpFinal")
                SELECT TmpFinal
                loc_nSaldo    = 0
                loc_nEstoque  = 0
                loc_nProduzir = 0
                loc_nFabrs    = 0
                SUM Saldo, Estoque, Produzir, Fabrs ;
                    TO loc_nSaldo, loc_nEstoque, loc_nProduzir, loc_nFabrs
                IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
                    GO loc_nOldRecno
                ENDIF

                IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_Qtd", 5)
                    THIS.pgf_4c_1.Page2.txt_4c_Tot_Qtd.Value = loc_nSaldo
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_Est", 5)
                    THIS.pgf_4c_1.Page2.txt_4c_Tot_Est.Value = loc_nEstoque
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_Prz", 5)
                    THIS.pgf_4c_1.Page2.txt_4c_Tot_Prz.Value = loc_nProduzir
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_prc", 5)
                    THIS.pgf_4c_1.Page2.txt_4c_Tot_prc.Value = loc_nFabrs
                ENDIF

                THIS.this_oBusinessObject.this_nTotQtdP2  = loc_nSaldo
                THIS.this_oBusinessObject.this_nTotEstP2  = loc_nEstoque
                THIS.this_oBusinessObject.this_nTotPrzP2  = loc_nProduzir
                THIS.this_oBusinessObject.this_nTotPrcP2  = loc_nFabrs
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AtualizarTotaisPage2: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * P2GradeAfterRowColChange - Atualiza obs/foto ao mudar linha no grid P2
    *--------------------------------------------------------------------------
    PROCEDURE P2GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_cCpros, loc_oRS, loc_nRes, loc_cSQL

        TRY
            IF USED("TmpFinal") AND !EOF("TmpFinal")
                loc_cCpros = ALLTRIM(TmpFinal.Cpros)

                IF PEMSTATUS(THIS.pgf_4c_1.Page2, "edt_4c_ObsItens", 5)
                    THIS.pgf_4c_1.Page2.edt_4c_ObsItens.Value = ALLTRIM(TmpFinal.CodObs)
                ENDIF

                IF PEMSTATUS(THIS.pgf_4c_1.Page2, "lbl_4c_Txt_ObsItens", 5)
                    THIS.pgf_4c_1.Page2.lbl_4c_Txt_ObsItens.Caption = ALLTRIM(TmpFinal.Cpros)
                ENDIF

                IF !EMPTY(loc_cCpros) AND gnConnHandle > 0
                    loc_cSQL = "SELECT TOP 1 Fotos FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoP2")
                    IF loc_nRes > 0 AND USED("cursor_4c_FotoP2") AND !EOF("cursor_4c_FotoP2")
                        IF !EMPTY(cursor_4c_FotoP2.Fotos) AND PEMSTATUS(THIS.pgf_4c_1.Page2, "img_4c_ImgFigJpg", 5)
                            THIS.pgf_4c_1.Page2.img_4c_ImgFigJpg.PictureVal = STRCONV(cursor_4c_FotoP2.Fotos, 14)
                        ENDIF
                        USE IN cursor_4c_FotoP2
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P2GradeAfterRowColChange: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * P2ColGotFocusToCol7 - Redireciona foco para coluna Estoque (Col7)
    *--------------------------------------------------------------------------
    PROCEDURE P2ColGotFocusToCol7()
        TRY
            IF PEMSTATUS(THIS.pgf_4c_1.Page2, "grd_4c_GradeItens2", 5)
                THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P2ColGotFocusToCol7: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * P2ColC7When - Salva valor anterior da coluna Estoque antes de editar
    *--------------------------------------------------------------------------
    FUNCTION P2ColC7When()
        LOCAL loc_lResultado

        loc_lResultado = .T.

        TRY
            IF USED("TmpFinal") AND !EOF("TmpFinal")
                THIS.this_oBusinessObject.this_nOldValue = TmpFinal.Estoque
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P2ColC7When: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * P2ColC7Valid - Valida e aplica edicao de Estoque no grid Page2
    *--------------------------------------------------------------------------
    FUNCTION P2ColC7Valid()
        LOCAL loc_lResultado, loc_nNovo, loc_nTotSEst

        loc_lResultado = .T.

        TRY
            IF USED("TmpFinal") AND !EOF("TmpFinal")
                loc_nNovo    = THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value
                loc_nTotSEst = THIS.this_oBusinessObject.this_nTotSEst

                IF loc_nNovo < 0
                    MsgAviso("Estoque n" + CHR(227) + "o pode ser negativo.")
                    THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
                    loc_lResultado = .F.
                ELSE
                    IF loc_nNovo > TmpFinal.Saldo
                        MsgAviso("Estoque n" + CHR(227) + "o pode ser maior que o Saldo.")
                        THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
                        loc_lResultado = .F.
                    ELSE
                        LOCAL loc_nDif
                        loc_nDif = loc_nNovo - THIS.this_oBusinessObject.this_nOldValue
                        IF (THIS.this_oBusinessObject.this_nTotQtdP2 + loc_nDif) > loc_nTotSEst
                            MsgAviso("Total de estoque selecionado excede o dispon?vel.")
                            THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column7.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
                            loc_lResultado = .F.
                        ELSE
                            REPLACE TmpFinal.Estoque WITH loc_nNovo
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P2ColC7Valid: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * P2ColC7LostFocus - Atualiza totais apos sair da coluna Estoque
    *--------------------------------------------------------------------------
    PROCEDURE P2ColC7LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            THIS.AtualizarTotaisPage2()
        CATCH TO loc_oErro
            MsgErro("Erro em P2ColC7LostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * P2ColC10When - Salva valor anterior da coluna Fabrs antes de editar
    *--------------------------------------------------------------------------
    FUNCTION P2ColC10When()
        LOCAL loc_lResultado

        loc_lResultado = .T.

        TRY
            IF USED("TmpFinal") AND !EOF("TmpFinal")
                THIS.this_oBusinessObject.this_nOldValue = TmpFinal.Fabrs
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P2ColC10When: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * P2ColC10Valid - Valida e aplica edicao de Fabrs no grid Page2
    *--------------------------------------------------------------------------
    FUNCTION P2ColC10Valid()
        LOCAL loc_lResultado, loc_nNovo, loc_nTotSPrc

        loc_lResultado = .T.

        TRY
            IF USED("TmpFinal") AND !EOF("TmpFinal")
                loc_nNovo    = THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value
                loc_nTotSPrc = THIS.this_oBusinessObject.this_nTotSPrc

                IF loc_nNovo < 0
                    MsgAviso("Fabrica" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser negativa.")
                    THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
                    loc_lResultado = .F.
                ELSE
                    IF loc_nNovo > TmpFinal.Saldo
                        MsgAviso("Fabrica" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser maior que o Saldo.")
                        THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
                        loc_lResultado = .F.
                    ELSE
                        LOCAL loc_nDifF
                        loc_nDifF = loc_nNovo - THIS.this_oBusinessObject.this_nOldValue
                        IF (THIS.this_oBusinessObject.this_nTotPrcP2 + loc_nDifF) > loc_nTotSPrc
                            MsgAviso("Total de produ" + CHR(231) + CHR(227) + "o excede o dispon?vel.")
                            THIS.pgf_4c_1.Page2.grd_4c_GradeItens2.Column10.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
                            loc_lResultado = .F.
                        ELSE
                            REPLACE TmpFinal.Fabrs WITH loc_nNovo
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P2ColC10Valid: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * P2ColC10LostFocus - Atualiza totais apos sair da coluna Fabrs
    *--------------------------------------------------------------------------
    PROCEDURE P2ColC10LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            THIS.AtualizarTotaisPage2()
        CATCH TO loc_oErro
            MsgErro("Erro em P2ColC10LostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage2Click - Valida totais e retorna para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage2Click()
        LOCAL loc_nOldRecno, loc_nSumEst, loc_nSumFabrs

        TRY
            IF USED("TmpFinal") AND USED("TmpFinalg") AND !EOF("TmpFinalg")
                loc_nOldRecno = IIF(RECCOUNT("TmpFinal") > 0, RECNO("TmpFinal"), 0)
                SELECT TmpFinal
                loc_nSumEst   = 0
                loc_nSumFabrs = 0
                SUM Estoque, Fabrs TO loc_nSumEst, loc_nSumFabrs
                IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpFinal")
                    GO loc_nOldRecno IN TmpFinal
                ENDIF

                IF loc_nSumEst != TmpFinalg.Estoque OR loc_nSumFabrs != TmpFinalg.Fabrs
                    MsgAviso("Os totais de estoque/produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o conferem com o item selecionado.")
                    RETURN
                ENDIF
            ENDIF

            THIS.AlternarPagina(1)
            THIS.AtualizarTotaisPage1()

            IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVoltarPage2Click: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage3Click - Retorna para Page1 a partir de Page3
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage3Click()
        TRY
            THIS.AlternarPagina(1)
            IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVoltarPage3Click: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * P4ColReadOnlyWhen - Bloqueia edicao em colunas somente-leitura
    *--------------------------------------------------------------------------
    FUNCTION P4ColReadOnlyWhen()
        RETURN 0
    ENDFUNC

    *--------------------------------------------------------------------------
    * P4ColC5Valid - Valida quantidade Utilizar na selecao de estoque (Page4)
    *--------------------------------------------------------------------------
    FUNCTION P4ColC5Valid()
        LOCAL loc_lResultado, loc_nUtil, loc_nSumUtil, loc_nOldRecno
        LOCAL loc_nPSaldo

        loc_lResultado = .T.

        TRY
            IF USED("TmpDisp") AND !EOF("TmpDisp") AND USED("TmpFinalg") AND !EOF("TmpFinalg")
                loc_nUtil  = THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value

                IF loc_nUtil < 0
                    MsgAviso("Quantidade n" + CHR(227) + "o pode ser negativa.")
                    THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value = 0
                    loc_lResultado = .F.
                ELSE
                    IF loc_nUtil > TmpDisp.Disps
                        MsgAviso("Quantidade excede o dispon?vel.")
                        THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value = TmpDisp.Disps
                        loc_lResultado = .F.
                    ELSE
                        loc_nPSaldo = TmpFinalg.Saldo - TmpFinalg.Estoque - TmpFinalg.Fabrs

                        loc_nOldRecno = IIF(RECCOUNT("TmpDisp") > 0, RECNO("TmpDisp"), 0)
                        SELECT TmpDisp
                        loc_nSumUtil = 0
                        SUM Utilizar TO loc_nSumUtil
                        IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpDisp")
                            GO loc_nOldRecno
                        ENDIF

                        loc_nSumUtil = loc_nSumUtil - TmpDisp.Utilizar + loc_nUtil

                        IF loc_nSumUtil > loc_nPSaldo
                            MsgAviso("Total selecionado excede o saldo a produzir.")
                            THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Value = 0
                            loc_lResultado = .F.
                        ELSE
                            REPLACE TmpDisp.Utilizar WITH loc_nUtil
                            IF PEMSTATUS(THIS.pgf_4c_1.Page4, "txt_4c_Qt_Selec", 5)
                                THIS.pgf_4c_1.Page4.txt_4c_Qt_Selec.Value = loc_nSumUtil
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P4ColC5Valid: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * P4ColC5LostFocus - Avanca para proxima linha apos Enter em Col5 Page4
    *--------------------------------------------------------------------------
    PROCEDURE P4ColC5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF LASTKEY() = 13
                KEYBOARD CHR(24)
            ENDIF
            IF PEMSTATUS(THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5, "Text1", 5)
                THIS.pgf_4c_1.Page4.grd_4c_GradeDisp.Column5.Text1.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P4ColC5LostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage4Click - Processa selecao de estoque e retorna para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage4Click()
        LOCAL loc_cCpros, loc_nUtil, loc_nQtdMin

        TRY
            IF USED("TmpDisp")
                loc_cCpros = ""
                IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                    loc_cCpros = ALLTRIM(TmpFinalg.Cpros)
                ENDIF

                SELECT TmpDisp
                SCAN
                    loc_nUtil   = TmpDisp.Utilizar
                    loc_cCpros  = ALLTRIM(TmpDisp.Grupos)

                    IF USED("TmpFinalg")
                        SELECT TmpFinalg
                        LOCATE FOR ALLTRIM(TmpFinalg.Cpros) = m.loc_cCpros
                        IF FOUND()
                            REPLACE TmpFinalg.Produzir   WITH TmpFinalg.Produzir - loc_nUtil
                            REPLACE TmpFinalg.Estoque    WITH TmpFinalg.Estoque  + loc_nUtil

                            loc_nQtdMin = 0
                            IF TYPE("TmpFinalg.QtdMins") != "U"
                                loc_nQtdMin = TmpFinalg.QtdMins
                            ENDIF
                            IF loc_nQtdMin > 0
                                REPLACE TmpFinalg.Produzir2 WITH IIF(TmpFinalg.Produzir >= loc_nQtdMin, ;
                                    TmpFinalg.Produzir, 0)
                            ELSE
                                REPLACE TmpFinalg.Produzir2 WITH TmpFinalg.Produzir
                            ENDIF
                        ENDIF
                    ENDIF

                    IF USED("TmpSaldo")
                        SELECT TmpSaldo
                        LOCATE FOR ALLTRIM(TmpSaldo.Grupos) = m.loc_cCpros
                        IF FOUND()
                            REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nUtil
                        ENDIF
                    ENDIF

                    IF USED("TmpSaldG")
                        SELECT TmpSaldG
                        LOCATE FOR ALLTRIM(TmpSaldG.Grupos) = m.loc_cCpros
                        IF FOUND()
                            REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nUtil
                        ENDIF
                    ENDIF

                    IF USED("TmpSaldU")
                        SELECT TmpSaldU
                        LOCATE FOR ALLTRIM(TmpSaldU.Cpros) = m.loc_cCpros
                        IF FOUND()
                            REPLACE TmpSaldU.KeySelm WITH .T.
                        ENDIF
                    ENDIF
                ENDSCAN

                USE IN TmpDisp
            ENDIF

            THIS.AlternarPagina(1)
            THIS.AtualizarTotaisPage1()

            IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVoltarPage4Click: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * P5ColGotFocusToCol5 - Redireciona foco para coluna Utilizar (Col5) Page5
    *--------------------------------------------------------------------------
    PROCEDURE P5ColGotFocusToCol5()
        TRY
            IF PEMSTATUS(THIS.pgf_4c_1.Page5, "grd_4c_GradeDisp", 5)
                THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P5ColGotFocusToCol5: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * P5ColC5Valid - Valida quantidade Utilizar na selecao por tamanho (Page5)
    *--------------------------------------------------------------------------
    FUNCTION P5ColC5Valid()
        LOCAL loc_lResultado, loc_nUtil, loc_nSumUtil, loc_nOldRecno
        LOCAL loc_nPSaldo

        loc_lResultado = .T.

        TRY
            IF USED("TmpDisp") AND !EOF("TmpDisp")
                loc_nUtil = THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value

                IF loc_nUtil < 0
                    MsgAviso("Quantidade n" + CHR(227) + "o pode ser negativa.")
                    THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
                    loc_lResultado = .F.
                ELSE
                    IF loc_nUtil > TmpDisp.Disps
                        MsgAviso("Quantidade excede o dispon?vel.")
                        THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value = TmpDisp.Disps
                        loc_lResultado = .F.
                    ELSE
                        loc_nPSaldo = 0
                        IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_pedida", 5)
                            loc_nPSaldo = THIS.pgf_4c_1.Page5.txt_4c_Qt_pedida.Value
                        ENDIF

                        loc_nOldRecno = IIF(RECCOUNT("TmpDisp") > 0, RECNO("TmpDisp"), 0)
                        SELECT TmpDisp
                        loc_nSumUtil = 0
                        SUM Utilizar TO loc_nSumUtil
                        IF loc_nOldRecno > 0 AND loc_nOldRecno <= RECCOUNT("TmpDisp")
                            GO loc_nOldRecno
                        ENDIF

                        loc_nSumUtil = loc_nSumUtil - TmpDisp.Utilizar + loc_nUtil

                        IF loc_nSumUtil > loc_nPSaldo
                            MsgAviso("Total selecionado excede o pedido.")
                            THIS.pgf_4c_1.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
                            loc_lResultado = .F.
                        ELSE
                            REPLACE TmpDisp.Utilizar WITH loc_nUtil
                            IF PEMSTATUS(THIS.pgf_4c_1.Page5, "txt_4c_Qt_Selec", 5)
                                THIS.pgf_4c_1.Page5.txt_4c_Qt_Selec.Value = loc_nSumUtil
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P5ColC5Valid: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnVoltarPage5Click - Processa selecao por tamanho e retorna para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage5Click()
        LOCAL loc_cGrupo, loc_nUtil

        TRY
            IF USED("TmpDisp")
                SELECT TmpDisp
                SCAN
                    loc_nUtil  = TmpDisp.Utilizar
                    loc_cGrupo = ALLTRIM(TmpDisp.Cpros)

                    IF USED("TmpFinalg")
                        SELECT TmpFinalg
                        LOCATE FOR ALLTRIM(TmpFinalg.Cpros) = m.loc_cGrupo
                        IF FOUND()
                            REPLACE TmpFinalg.Produzir WITH TmpFinalg.Produzir - loc_nUtil
                            REPLACE TmpFinalg.Estoque  WITH TmpFinalg.Estoque  + loc_nUtil
                        ENDIF
                    ENDIF

                    IF USED("TmpSaldo")
                        SELECT TmpSaldo
                        LOCATE FOR ALLTRIM(TmpSaldo.Grupos) = m.loc_cGrupo
                        IF FOUND()
                            REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nUtil
                        ENDIF
                    ENDIF
                ENDSCAN

                USE IN TmpDisp
            ENDIF

            THIS.AlternarPagina(1)
            THIS.AtualizarTotaisPage1()

            IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVoltarPage5Click: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * P6ColC1Valid - Lookup de produto para coluna Cpros do grid Page6
    *--------------------------------------------------------------------------
    FUNCTION P6ColC1Valid()
        LOCAL loc_lResultado, loc_cCpros, loc_nRes, loc_cSQL

        loc_lResultado = .T.

        TRY
            IF USED("SelPedra") AND !EOF("SelPedra")
                loc_cCpros = ALLTRIM(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column1.Text1.Value)

                IF !EMPTY(loc_cCpros)
                    loc_cSQL = "SELECT TOP 1 Dpros, Cunis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProP6")

                    IF loc_nRes > 0 AND USED("cursor_4c_ProP6") AND !EOF("cursor_4c_ProP6")
                        REPLACE SelPedra.Cpros WITH loc_cCpros
                        REPLACE SelPedra.Dpros WITH ALLTRIM(cursor_4c_ProP6.Dpros)
                        REPLACE SelPedra.Cunis WITH ALLTRIM(cursor_4c_ProP6.Cunis)
                        USE IN cursor_4c_ProP6
                    ELSE
                        IF USED("cursor_4c_ProP6")
                            USE IN cursor_4c_ProP6
                        ENDIF
                        THIS.AbrirLookupProdutoP6Col1(loc_cCpros)
                        loc_lResultado = USED("SelPedra") AND !EOF("SelPedra") AND !EMPTY(ALLTRIM(SelPedra.Cpros))
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P6ColC1Valid: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * P6ColC2When - Bloqueia edicao na coluna Dpros (descricao) Page6
    *--------------------------------------------------------------------------
    FUNCTION P6ColC2When()
        RETURN 0
    ENDFUNC

    *--------------------------------------------------------------------------
    * P6ColC3When - Bloqueia edicao na coluna Cunis (unidade) Page6
    *--------------------------------------------------------------------------
    FUNCTION P6ColC3When()
        RETURN 0
    ENDFUNC

    *--------------------------------------------------------------------------
    * P6ColC4When - Libera edicao de Qtdes somente se Cpros preenchido
    *--------------------------------------------------------------------------
    FUNCTION P6ColC4When()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        TRY
            IF USED("SelPedra") AND !EOF("SelPedra")
                loc_lResultado = !EMPTY(ALLTRIM(SelPedra.Cpros))
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P6ColC4When: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN IIF(loc_lResultado, 1, 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    * P6ColC5When - Libera edicao de Cpro2s somente se Cpros preenchido
    *--------------------------------------------------------------------------
    FUNCTION P6ColC5When()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        TRY
            IF USED("SelPedra") AND !EOF("SelPedra")
                loc_lResultado = !EMPTY(ALLTRIM(SelPedra.Cpros))
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P6ColC5When: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN IIF(loc_lResultado, 1, 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    * P6ColC5Valid - Lookup de produto substituto para coluna Cpro2s Page6
    *--------------------------------------------------------------------------
    FUNCTION P6ColC5Valid()
        LOCAL loc_lResultado, loc_cCpro2, loc_nRes, loc_cSQL

        loc_lResultado = .T.

        TRY
            IF USED("SelPedra") AND !EOF("SelPedra")
                loc_cCpro2 = ALLTRIM(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column5.Text1.Value)

                IF !EMPTY(loc_cCpro2)
                    loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpro2)
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pro2P6")

                    IF loc_nRes > 0 AND USED("cursor_4c_Pro2P6") AND !EOF("cursor_4c_Pro2P6")
                        REPLACE SelPedra.Cpro2s WITH loc_cCpro2
                        USE IN cursor_4c_Pro2P6
                    ELSE
                        IF USED("cursor_4c_Pro2P6")
                            USE IN cursor_4c_Pro2P6
                        ENDIF
                        THIS.AbrirLookupProdutoP6Col5(loc_cCpro2)
                        loc_lResultado = USED("SelPedra") AND !EOF("SelPedra") AND !EMPTY(ALLTRIM(SelPedra.Cpro2s))
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P6ColC5Valid: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * P6ColC5LostFocus - Avanca para proxima linha apos Enter em Col5 Page6
    *--------------------------------------------------------------------------
    PROCEDURE P6ColC5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF LASTKEY() = 13
                KEYBOARD CHR(24)
            ENDIF
            IF PEMSTATUS(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column5, "Text1", 5)
                THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column5.Text1.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em P6ColC5LostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * P6ColC1KeyPress - F4 abre picker de produto (Col1 Cpros Page6)
    *--------------------------------------------------------------------------
    FUNCTION P6ColC1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cFiltro

        IF par_nKeyCode = 115  && F4
            loc_cFiltro = ""
            IF PEMSTATUS(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column1.Text1, "Value", 5)
                loc_cFiltro = ALLTRIM(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column1.Text1.Value)
            ENDIF
            THIS.AbrirLookupProdutoP6Col1(loc_cFiltro)
            RETURN 0
        ENDIF

        RETURN par_nKeyCode
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirLookupProdutoP6Col1 - Picker FormBuscaAuxiliar para Cpros (Page6)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupProdutoP6Col1(par_cFiltro)
        LOCAL loc_cFiltro, loc_cCpros, loc_nRes, loc_cSQL

        loc_cFiltro = IIF(TYPE("par_cFiltro") = "C", ALLTRIM(par_cFiltro), "")

        TRY
            DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crLkpPro6C1", "CPros", ;
                loc_cFiltro, "Produto", 900, "CPros", "DPros"

            IF USED("crLkpPro6C1") AND RECCOUNT("crLkpPro6C1") > 0
                loc_cCpros = ALLTRIM(crLkpPro6C1.CPros)
                USE IN crLkpPro6C1

                IF USED("SelPedra") AND !EOF("SelPedra") AND !EMPTY(loc_cCpros)
                    loc_cSQL = "SELECT TOP 1 DPros, Cunis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "crLkpPro6C1Det")

                    IF loc_nRes > 0 AND USED("crLkpPro6C1Det") AND !EOF("crLkpPro6C1Det")
                        REPLACE SelPedra.Cpros WITH loc_cCpros
                        REPLACE SelPedra.Dpros WITH ALLTRIM(crLkpPro6C1Det.DPros)
                        REPLACE SelPedra.Cunis WITH ALLTRIM(crLkpPro6C1Det.Cunis)
                        USE IN crLkpPro6C1Det
                    ELSE
                        IF USED("crLkpPro6C1Det")
                            USE IN crLkpPro6C1Det
                        ENDIF
                    ENDIF

                    IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
                        THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Refresh()
                    ENDIF
                ENDIF
            ELSE
                IF USED("crLkpPro6C1")
                    USE IN crLkpPro6C1
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir lookup de produto: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * P6ColC5KeyPress - F4 abre picker de produto substituto (Col5 Cpro2s Page6)
    *--------------------------------------------------------------------------
    FUNCTION P6ColC5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cFiltro

        IF par_nKeyCode = 115  && F4
            loc_cFiltro = ""
            IF PEMSTATUS(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column5.Text1, "Value", 5)
                loc_cFiltro = ALLTRIM(THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Column5.Text1.Value)
            ENDIF
            THIS.AbrirLookupProdutoP6Col5(loc_cFiltro)
            RETURN 0
        ENDIF

        RETURN par_nKeyCode
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirLookupProdutoP6Col5 - Picker FormBuscaAuxiliar para Cpro2s (Page6)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupProdutoP6Col5(par_cFiltro)
        LOCAL loc_cFiltro, loc_cCpro2

        loc_cFiltro = IIF(TYPE("par_cFiltro") = "C", ALLTRIM(par_cFiltro), "")

        TRY
            DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crLkpPro6C5", "CPros", ;
                loc_cFiltro, "Produto Substituto", 900, "CPros", "DPros"

            IF USED("crLkpPro6C5") AND RECCOUNT("crLkpPro6C5") > 0
                loc_cCpro2 = ALLTRIM(crLkpPro6C5.CPros)
                USE IN crLkpPro6C5

                IF USED("SelPedra") AND !EOF("SelPedra") AND !EMPTY(loc_cCpro2)
                    REPLACE SelPedra.Cpro2s WITH loc_cCpro2

                    IF PEMSTATUS(THIS.pgf_4c_1.Page6, "grd_4c_GradePedra", 5)
                        THIS.pgf_4c_1.Page6.grd_4c_GradePedra.Refresh()
                    ENDIF
                ENDIF
            ELSE
                IF USED("crLkpPro6C5")
                    USE IN crLkpPro6C5
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir lookup de produto substituto: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage6Click - Retorna de Page6 (requisicao manual) para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage6Click()
        TRY
            THIS.AlternarPagina(1)
            IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVoltarPage6Click: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MostrarAguarde - Exibe overlay de processamento com mensagem
    *--------------------------------------------------------------------------
    PROCEDURE MostrarAguarde(par_cMensagem)

        IF PEMSTATUS(THIS, "cnt_4c_Aguarde", 5)
            IF TYPE("par_cMensagem") = "C" AND !EMPTY(par_cMensagem)
                THIS.cnt_4c_Aguarde.lbl_4c_AguardeDet.Caption = par_cMensagem
            ENDIF
            THIS.cnt_4c_Aguarde.Visible = .T.
            THIS.cnt_4c_Aguarde.ZOrder(0)
        ENDIF
        THIS.this_lProcessando = .T.
        DOEVENTS
    ENDPROC

    *--------------------------------------------------------------------------
    * OcultarAguarde - Oculta overlay de processamento
    *--------------------------------------------------------------------------
    PROCEDURE OcultarAguarde()

        IF PEMSTATUS(THIS, "cnt_4c_Aguarde", 5)
            THIS.cnt_4c_Aguarde.lbl_4c_AguardeDet.Caption = ""
            THIS.cnt_4c_Aguarde.Visible = .F.
        ENDIF
        THIS.this_lProcessando = .F.
        DOEVENTS
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Form OPERACIONAL: incluir requisicao manual de material
    * (equivalente ao botao Pedras do legado, que abre Page6 para adicionar
    *  itens da requisicao vinculados ao produto corrente da grade)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()

        TRY
            IF !USED("TmpFinalg") OR EOF("TmpFinalg")
                MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de incluir requisi" + ;
                    CHR(231) + CHR(245) + "es de material.")
                IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                    THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
                ENDIF
            ELSE
                THIS.BtnPedrasClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao incluir requisi" + CHR(231) + CHR(227) + "o: " + ;
                loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Form OPERACIONAL: alterar quantidade a produzir para
    * estoque do item selecionado (exige autorizacao por senha, replica o
    * comportamento do botao Alteraqtd do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()

        TRY
            IF !USED("TmpFinalg") OR EOF("TmpFinalg")
                MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de alterar quantidade.")
                IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                    THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
                ENDIF
            ELSE
                THIS.BtnAlteraqtdClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar quantidade: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Form OPERACIONAL: exibir foto do produto corrente
    * (equivalente ao clique na Image ImgFigJpg do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()

        TRY
            IF !USED("TmpFinalg") OR EOF("TmpFinalg")
                MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de visualizar a foto.")
                IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                    THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
                ENDIF
            ELSE
                THIS.CarregarFotoProduto(ALLTRIM(TmpFinalg.Cpros))
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao visualizar foto: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Form OPERACIONAL: zerar a selecao de producao/estoque
    * do item corrente da grade (reverte producao para o saldo total, limpa
    * marcacoes de estoque/producao selecionadas). Espelha o rollback feito
    * pelo botao Cancelar da Page2 do legado quando aplicado ao registro atual.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()

        LOCAL loc_nSaldoTotal, loc_cCpro, loc_cCor, loc_cTam

        TRY
            IF !USED("TmpFinalg") OR EOF("TmpFinalg")
                MsgAviso("Selecione uma refer" + CHR(234) + "ncia na grade antes de zerar a sele" + ;
                    CHR(231) + CHR(227) + "o.")
                IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                    THIS.pgf_4c_1.Page1.grd_4c_GradeItens.SetFocus
                ENDIF
            ELSE
                IF !MsgConfirma("Zerar sele" + CHR(231) + CHR(227) + "o de estoque/produ" + ;
                    CHR(231) + CHR(227) + "o da refer" + CHR(234) + "ncia corrente?")
                    RETURN
                ENDIF

                loc_cCpro     = ALLTRIM(TmpFinalg.Cpros)
                loc_cCor      = ALLTRIM(TmpFinalg.CodCors)
                loc_cTam      = ALLTRIM(TmpFinalg.CodTams)
                loc_nSaldoTotal = TmpFinalg.Saldo

                SELECT TmpFinalg
                REPLACE Estoque WITH 0, Fabrs WITH 0, Produzir WITH loc_nSaldoTotal, ;
                    Produzir2 WITH 0, UsuLibs WITH " " IN TmpFinalg

                IF USED("TmpSaldo")
                    IF SEEK(loc_cCpro + loc_cCor + loc_cTam, "TmpSaldo")
                        REPLACE TmpSaldo.Disps WITH TmpSaldo.Saldo IN TmpSaldo
                    ENDIF
                ENDIF

                THIS.AtualizarTotaisPage1()
                IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                    THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao zerar sele" + CHR(231) + CHR(227) + "o: " + ;
                loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Vincula GradeItens da Page1 ao cursor TmpFinalg
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        TRY
            IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5) AND USED("TmpFinalg")
                WITH THIS.pgf_4c_1.Page1.grd_4c_GradeItens
                    .ColumnCount  = 10
                    .RecordSource = "TmpFinalg"
                ENDWITH
            ENDIF
            THIS.AtualizarTotaisPage1()
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Delega para AjustarVisibilidadeBotoes
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.AjustarVisibilidadeBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza totais dos cursores de producao para o BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
        LOCAL loc_nSal2, loc_nEst2, loc_nPrz2, loc_nPrc2
        LOCAL loc_nRecno

        TRY
            IF USED("TmpFinalg") AND RECCOUNT("TmpFinalg") > 0
                loc_nRecno = IIF(!BOF("TmpFinalg") AND !EOF("TmpFinalg"), RECNO("TmpFinalg"), 0)

                loc_nSal   = 0
                loc_nEst   = 0
                loc_nPrz   = 0
                loc_nPrc   = 0
                loc_nPrze  = 0

                SELECT TmpFinalg
                SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
                    TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze

                IF loc_nRecno > 0 AND RECCOUNT("TmpFinalg") >= loc_nRecno
                    GO loc_nRecno IN TmpFinalg
                ENDIF

                THIS.this_oBusinessObject.this_nTotQtd  = loc_nSal
                THIS.this_oBusinessObject.this_nTotEst  = loc_nEst
                THIS.this_oBusinessObject.this_nTotPrz  = loc_nPrz
                THIS.this_oBusinessObject.this_nTotPrdc = loc_nPrc
                THIS.this_oBusinessObject.this_nTotPrze = loc_nPrze
            ENDIF

            IF USED("TmpFinal") AND RECCOUNT("TmpFinal") > 0
                loc_nRecno = IIF(!BOF("TmpFinal") AND !EOF("TmpFinal"), RECNO("TmpFinal"), 0)

                loc_nSal2  = 0
                loc_nEst2  = 0
                loc_nPrz2  = 0
                loc_nPrc2  = 0

                SELECT TmpFinal
                SUM Saldo, Estoque, Produzir, Fabrs ;
                    TO loc_nSal2, loc_nEst2, loc_nPrz2, loc_nPrc2

                IF loc_nRecno > 0 AND RECCOUNT("TmpFinal") >= loc_nRecno
                    GO loc_nRecno IN TmpFinal
                ENDIF

                THIS.this_oBusinessObject.this_nTotQtdP2 = loc_nSal2
                THIS.this_oBusinessObject.this_nTotEstP2 = loc_nEst2
                THIS.this_oBusinessObject.this_nTotPrzP2 = loc_nPrz2
                THIS.this_oBusinessObject.this_nTotPrcP2 = loc_nPrc2
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza totais da UI a partir do estado do BO/cursores
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        TRY
            THIS.AtualizarTotaisPage1()
            THIS.AtualizarTotaisPage2()
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita colunas editaveis conforme estado
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_lBloquear

        TRY
            loc_lBloquear = THIS.this_lProcessando

            IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                WITH THIS.pgf_4c_1.Page1.grd_4c_GradeItens
                    IF PEMSTATUS(.Column7, "ReadOnly", 5)
                        .Column7.ReadOnly = loc_lBloquear
                    ENDIF
                    IF PEMSTATUS(.Column8, "ReadOnly", 5)
                        .Column8.ReadOnly = loc_lBloquear
                    ENDIF
                    IF PEMSTATUS(.Column10, "ReadOnly", 5)
                        .Column10.ReadOnly = loc_lBloquear
                    ENDIF
                ENDWITH
            ENDIF

            IF PEMSTATUS(THIS.pgf_4c_1.Page1, "cmd_4c_Processar", 5)
                THIS.pgf_4c_1.Page1.cmd_4c_Processar.Enabled = !loc_lBloquear
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera os campos de totalizacao das paginas 1 e 2
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        TRY
            IF PEMSTATUS(THIS.pgf_4c_1.Page1, "txt_4c_Tot_Qtd", 5)
                WITH THIS.pgf_4c_1.Page1
                    .txt_4c_Tot_Qtd.Value  = 0
                    .txt_4c_Tot_Est.Value  = 0
                    .txt_4c_Tot_Prz.Value  = 0
                    .txt_4c_Tot_prdc.Value = 0
                    .txt_4c_Tot_prze.Value = 0
                ENDWITH
            ENDIF

            IF PEMSTATUS(THIS.pgf_4c_1.Page2, "txt_4c_Tot_Qtd", 5)
                WITH THIS.pgf_4c_1.Page2
                    .txt_4c_Tot_Qtd.Value = 0
                    .txt_4c_Tot_Est.Value = 0
                    .txt_4c_Tot_Prz.Value = 0
                    .txt_4c_Tot_prc.Value = 0
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Atualiza a exibicao da previa (recarrega grade e totais)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
            IF PEMSTATUS(THIS.pgf_4c_1.Page1, "grd_4c_GradeItens", 5)
                THIS.pgf_4c_1.Page1.grd_4c_GradeItens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar visualiza" + CHR(231) + CHR(227) + "o: " + ;
                loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirma e processa a globalizacao (alias de Processar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Encerra sem processar (alias de Encerrar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()

        TRY
            *-- Fecha cursor auxiliar criado em InicializarForm
            IF USED("TmpSaldU")
                USE IN TmpSaldU
            ENDIF

            *-- Reabilita form pai (foi desabilitado ao abrir este form filho)
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF

            *-- Libera referencias
            THIS.this_oParentForm = .NULL.
        CATCH TO loc_oErro
            MsgErro("Erro ao encerrar FormSigPrGlx: " + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
