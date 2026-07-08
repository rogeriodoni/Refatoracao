*==============================================================================
* Formsigprcpd.prg - Capacidade Produtiva (OPERACIONAL)
* Data: 2026-07-02
* Funcao: Consulta somente-leitura de capacidade produtiva por fase/data/OP
*
* Filosofia 3 Pilares:
*   UX     -> layout do SCX legado preservado (cabecalho + Fase/Data + Grade + Cap/Utz/Sld + foto)
*   BANCO  -> SigCdPcz, SigCdPcP, SigCdPcg, SigCdPco, SigCdCli, SigCdPro (schema identico)
*   CODE   -> arquitetura em camadas (FormBase / sigprcpdBO), sufixo _4c_
*==============================================================================

DEFINE CLASS Formsigprcpd AS FormBase

    *-- Dimensoes e propriedades visuais (copiadas do SCX legado, form escalado para 1000px)
    Width        = 1000
    Height       = 600
    Caption      = "Capacidade Produtiva"
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    BorderStyle  = 2
    WindowType   = 1

    *-- Parametros de entrada (armazenados em Init antes do DODEFAULT)
    this_cFase              = ""
    this_cUnidade           = ""
    this_dData              = {}
    this_nCodigo            = 0

    *-- Business Object
    this_oBusinessObject    = .NULL.

    *==========================================================================
    * Init - Recebe parametros do chamador (fase, unidade, data, codigo processo)
    * Armazena ANTES de DODEFAULT para que InicializarForm os encontre prontos
    *==========================================================================
    PROCEDURE Init(par_cFase, par_cUnidade, par_dData, par_nCodigo)
        THIS.this_cFase    = IIF(VARTYPE(par_cFase)    = "C", ALLTRIM(par_cFase),    "")
        THIS.this_cUnidade = IIF(VARTYPE(par_cUnidade) = "C", ALLTRIM(par_cUnidade), "")
        THIS.this_dData    = IIF(VARTYPE(par_dData)    = "D", par_dData,             DATE())
        THIS.this_nCodigo  = IIF(VARTYPE(par_nCodigo)  = "N", par_nCodigo,           0)
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    * Cria BO, monta cabecalho + PageFrame de conteudo e carrega dados iniciais
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("sigprcpdBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigprcpdBO", "Erro")
            ELSE
                THIS.LockScreen = .T.
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carrega dados antes de configurar Page1 (cria cursor_4c_Dados)
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarDados()
                ENDIF

                *-- Popula Page1 com grid e controles (usa cursor_4c_Dados se disponivel)
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.LockScreen = .F.

                *-- Torna controles visiveis (filtra imagem/shape da foto do produto)
                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro no topo com titulo do form
    * Cria cnt_4c_Cabecalho (equivalente ao cntSombra do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize      = .F.
                .Top           = 18
                .Left          = 10
                .Width         = loc_oCab.Width
                .Height        = 40
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = "Capacidade Produtiva"
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 17
                .Left      = 10
                .Width     = loc_oCab.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Capacidade Produtiva"
                .ForeColor = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        loc_oCab.Visible = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi pgf_4c_Paginas hospedeiro do conteudo
    * OPERACIONAL: usa 2 paginas com Tabs=.F. como containers da area util.
    *   Page1 -> visao principal (grid + filtros + produto/qtde/cliente)
    *   Page2 -> reservada para expansao futura (foto ampliada, historico, etc)
    * Fases seguintes populam as pages com grid, containers e campos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = 80
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height - 80
            .TabIndex  = 1
            .Tabs      = .F.
            .BorderWidth = 0

            .Page1.Caption = "Principal"
            .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            .Page2.Caption = "Detalhes"
            .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            .Visible    = .T.
            .ActivePage = 1
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarDados - Delega ao BO o carregamento de todos os cursores
    * Chamado em InicializarForm e pode ser chamado novamente para refresh
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso
        loc_lSucesso = THIS.this_oBusinessObject.CarregarDados( ;
            THIS.this_nCodigo, ;
            THIS.this_cFase, ;
            THIS.this_cUnidade, ;
            THIS.this_dData)
        IF !loc_lSucesso
            MsgErro("Falha ao carregar dados de capacidade produtiva.", "Erro")
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Filtra imagem/shape da foto (img_4c_FigJpg/shp_4c_Shape4) que sao toggled
    * pelo AfterRowColChange do grid conforme registro selecionado tem FigJpgs.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_cName
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) != "O"
                LOOP
            ENDIF

            loc_cName = UPPER(loc_oControl.Name)

            *-- Controles com visibilidade gerenciada pelo form: recursar filhos mas NAO tornar visiveis
            IF INLIST(loc_cName, "IMG_4C_FIGJPG", "SHP_4C_SHAPE4", "CNT_4C_CABECALHO", "CNT_4C_INFOPROD", "CNT_4C_DETALHELINHA") ;
                OR INLIST(loc_cName, "SHP_4C_SHAPE2", "IMG_4C_FIGJPG2")
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            *-- PageFrame: recursar em Pages (nao em Controls direto)
            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                LOCAL loc_p
                FOR loc_p = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                ENDFOR
                LOOP
            ENDIF

            *-- Container generico: recursar em Controls
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Popula Page1 com todos os controles:
    *   botao Encerrar, filtros (Fase/Data), metricas (Cap/Utz/Sld),
    *   grid de 8 colunas, campos informativos abaixo do grid e foto do produto.
    * Chamado APOS CarregarDados para que cursor_4c_Dados ja exista.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg, loc_oCnt1, loc_oCnt2, loc_oGrid

        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Botao Encerrar (topo direito da area de conteudo)
        loc_oPg.AddObject("cmd_4c_Sair", "CommandButton")
        WITH loc_oPg.cmd_4c_Sair
            .Top             = 5
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_Sair, "Click", THIS, "CmdSairClick")

        *-- Container1: parametros de consulta (Fase e Data)
        loc_oPg.AddObject("cnt_4c_Container1", "Container")
        loc_oCnt1 = loc_oPg.cnt_4c_Container1
        WITH loc_oCnt1
            .Top         = 24
            .Left        = 10
            .Width       = 347
            .Height      = 36
            .BackStyle   = 0
            .BorderWidth = 0

            .AddObject("lbl_4c_LblFase", "Label")
            WITH .lbl_4c_LblFase
                .Top       = 8
                .Left      = 2
                .Width     = 50
                .Height    = 17
                .Caption   = "Fase :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Fase", "TextBox")
            WITH .txt_4c_Fase
                .Top       = 5
                .Left      = 55
                .Width     = 125
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 198, 140)
                .Value     = ""
                .ReadOnly  = .T.
            ENDWITH

            .AddObject("lbl_4c_LblData", "Label")
            WITH .lbl_4c_LblData
                .Top       = 9
                .Left      = 185
                .Width     = 50
                .Height    = 17
                .Caption   = "Data :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Data", "TextBox")
            WITH .txt_4c_Data
                .Top       = 5
                .Left      = 236
                .Width     = 90
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 198, 140)
                .Value     = ""
                .ReadOnly  = .T.
            ENDWITH
        ENDWITH

        *-- Container2: metricas de capacidade (Capacidade / Utilizado / Saldo)
        loc_oPg.AddObject("cnt_4c_Container2", "Container")
        loc_oCnt2 = loc_oPg.cnt_4c_Container2
        WITH loc_oCnt2
            .Top         = 24
            .Left        = 368
            .Width       = 540
            .Height      = 36
            .BackStyle   = 0
            .BorderWidth = 0

            .AddObject("lbl_4c_LblCap", "Label")
            WITH .lbl_4c_LblCap
                .Top       = 10
                .Left      = 9
                .Width     = 87
                .Height    = 15
                .Caption   = "Capacidade:"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Cap", "TextBox")
            WITH .txt_4c_Cap
                .Top       = 5
                .Left      = 100
                .Width     = 79
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 216, 176)
                .InputMask = "99999"
                .Value     = 0
                .ReadOnly  = .T.
                .Alignment = 2
            ENDWITH

            .AddObject("lbl_4c_LblMin1", "Label")
            WITH .lbl_4c_LblMin1
                .Top       = 10
                .Left      = 184
                .Width     = 28
                .Height    = 15
                .Caption   = "Min"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("lbl_4c_LblUtz", "Label")
            WITH .lbl_4c_LblUtz
                .Top       = 10
                .Left      = 220
                .Width     = 68
                .Height    = 15
                .Caption   = "Utilizado:"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Utz", "TextBox")
            WITH .txt_4c_Utz
                .Top       = 5
                .Left      = 290
                .Width     = 79
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 216, 176)
                .InputMask = "99999"
                .Value     = 0
                .ReadOnly  = .T.
                .Alignment = 2
            ENDWITH

            .AddObject("lbl_4c_LblMin2", "Label")
            WITH .lbl_4c_LblMin2
                .Top       = 10
                .Left      = 374
                .Width     = 28
                .Height    = 15
                .Caption   = "Min"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("lbl_4c_LblSld", "Label")
            WITH .lbl_4c_LblSld
                .Top       = 10
                .Left      = 410
                .Width     = 52
                .Height    = 15
                .Caption   = "Saldo : "
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Sld", "TextBox")
            WITH .txt_4c_Sld
                .Top       = 5
                .Left      = 468
                .Width     = 79
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 216, 176)
                .InputMask = "99999"
                .Value     = 0
                .ReadOnly  = .T.
                .Alignment = 2
            ENDWITH

            .AddObject("lbl_4c_LblMin3", "Label")
            WITH .lbl_4c_LblMin3
                .Top       = 10
                .Left      = 552
                .Width     = 28
                .Height    = 15
                .Caption   = "Min"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Grid de capacidade produtiva (8 colunas, read-only)
        loc_oPg.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPg.grd_4c_Dados
        WITH loc_oGrid
            .Top                = 59
            .Left               = 0
            .Width              = 1000
            .Height             = 310
            .ColumnCount        = 8
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .ReadOnly           = .T.

            WITH .Column1
                .Width               = 70
                .Alignment           = 2
                .Header1.Caption     = "Envelope"
                .Text1.FontName      = "Verdana"
                .Text1.FontSize      = 8
                .Text1.Alignment     = 2
            ENDWITH

            WITH .Column2
                .Width               = 120
                .Header1.Caption     = "O.P."
                .Text1.FontName      = "Verdana"
                .Text1.FontSize      = 8
            ENDWITH

            WITH .Column3
                .Width               = 40
                .Alignment           = 2
                .Header1.Caption     = "Seq"
                .Text1.FontName      = "Verdana"
                .Text1.FontSize      = 8
                .Text1.Alignment     = 2
            ENDWITH

            WITH .Column4
                .Width               = 65
                .Alignment           = 2
                .Header1.Caption     = "Minutos"
                .Text1.FontName      = "Verdana"
                .Text1.FontSize      = 8
                .Text1.Alignment     = 2
            ENDWITH

            WITH .Column5
                .Width               = 100
                .Header1.Caption     = "Produto"
                .Text1.FontName      = "Verdana"
                .Text1.FontSize      = 8
            ENDWITH

            WITH .Column6
                .Width               = 160
                .Header1.Caption     = "Opera" + CHR(231) + CHR(227) + "o"
                .Text1.FontName      = "Verdana"
                .Text1.FontSize      = 8
            ENDWITH

            WITH .Column7
                .Width               = 265
                .Header1.Caption     = "Cliente"
                .Text1.FontName      = "Verdana"
                .Text1.FontSize      = 8
            ENDWITH

            WITH .Column8
                .Width               = 180
                .Header1.Caption     = "Unidade Prod."
                .Text1.FontName      = "Verdana"
                .Text1.FontSize      = 8
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(loc_oGrid, "DblClick", THIS, "GrdDadosDblClick")

        *-- Labels e campos informativos abaixo do grid
        loc_oPg.AddObject("lbl_4c_LblQtde", "Label")
        WITH loc_oPg.lbl_4c_LblQtde
            .Top       = 378
            .Left      = 11
            .Width     = 80
            .Height    = 15
            .Caption   = "Quantidade"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Qtde", "TextBox")
        WITH loc_oPg.txt_4c_Qtde
            .Top       = 391
            .Left      = 9
            .Width     = 92
            .Height    = 23
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 198)
            .InputMask = "99999.999"
            .Value     = 0
            .ReadOnly  = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblDescr", "Label")
        WITH loc_oPg.lbl_4c_LblDescr
            .Top       = 378
            .Left      = 112
            .Width     = 180
            .Height    = 15
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPg.txt_4c_Descr
            .Top       = 391
            .Left      = 112
            .Width     = 431
            .Height    = 23
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 198)
            .Value     = ""
            .ReadOnly  = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblPrioridade", "Label")
        WITH loc_oPg.lbl_4c_LblPrioridade
            .Top       = 378
            .Left      = 716
            .Width     = 200
            .Height    = 15
            .Caption   = "[ Opera" + CHR(231) + CHR(227) + "o com Prioridade ]"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Imagem do produto (Visible=.F. - gerenciada por AfterRowColChange)
        loc_oPg.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPg.shp_4c_Shape4
            .Top           = 376
            .Left          = 567
            .Width         = 148
            .Height        = 109
            .Visible       = .F.
            .BackStyle     = 0
            .BorderColor   = RGB(90, 90, 90)
            .SpecialEffect = 0
        ENDWITH

        loc_oPg.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oPg.img_4c_FigJpg
            .Top     = 378
            .Left    = 570
            .Width   = 143
            .Height  = 105
            .Visible = .F.
            .Stretch = 2
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblCliente", "Label")
        WITH loc_oPg.lbl_4c_LblCliente
            .Top       = 419
            .Left      = 11
            .Width     = 50
            .Height    = 15
            .Caption   = "Cliente"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cliente", "TextBox")
        WITH loc_oPg.txt_4c_Cliente
            .Top       = 432
            .Left      = 9
            .Width     = 531
            .Height    = 23
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 221)
            .Value     = ""
            .ReadOnly  = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblTEnv", "Label")
        WITH loc_oPg.lbl_4c_LblTEnv
            .Top       = 457
            .Left      = 11
            .Width     = 160
            .Height    = 15
            .Caption   = "Tempo Total do Envelope"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPg.AddObject("txt_4c_TEnv", "TextBox")
        WITH loc_oPg.txt_4c_TEnv
            .Top       = 470
            .Left      = 9
            .Width     = 92
            .Height    = 23
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 198)
            .InputMask = "99999"
            .Value     = 0
            .ReadOnly  = .T.
        ENDWITH

        *-- Vincula grid e popula campos (apenas se dados ja foram carregados)
        IF USED("cursor_4c_Dados")
            THIS.AtualizarGrid()
        ENDIF

        *-- Preenche parametros de consulta (sempre disponiveis via this_cFase/this_dData)
        loc_oCnt1.txt_4c_Fase.Value = ALLTRIM(THIS.this_cFase)
        loc_oCnt1.txt_4c_Data.Value = DTOC(THIS.this_dData)
    ENDPROC

    *==========================================================================
    * AtualizarGrid - Vincula grd_4c_Dados ao cursor_4c_Dados e atualiza metricas
    * Chamado apos CarregarDados. Pode ser chamado novamente para refresh.
    *==========================================================================
    PROCEDURE AtualizarGrid()
        LOCAL loc_oGrid, loc_oPg, loc_oCnt2
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_oGrid = loc_oPg.grd_4c_Dados
        loc_oCnt2 = loc_oPg.cnt_4c_Container2

        IF !USED("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_oGrid.ColumnCount  = 8
        loc_oGrid.RecordSource = "cursor_4c_Dados"
        WITH loc_oGrid
            .Column1.ControlSource = "cursor_4c_Dados.Nenvs"
            .Column2.ControlSource = "cursor_4c_Dados.Nops"
            .Column3.ControlSource = "cursor_4c_Dados.Ordems"
            .Column4.ControlSource = "cursor_4c_Dados.TempoReal"
            .Column5.ControlSource = "cursor_4c_Dados.Cpros"
            .Column6.ControlSource = "cursor_4c_Dados.Pedido"
            .Column7.ControlSource = "cursor_4c_Dados.cliente"
            .Column8.ControlSource = "cursor_4c_Dados.UniPrdts"

            *-- Redefine cabecalhos (RecordSource reseta headers)
            .Column1.Header1.Caption = "Envelope"
            .Column2.Header1.Caption = "O.P."
            .Column3.Header1.Caption = "Seq"
            .Column4.Header1.Caption = "Minutos"
            .Column5.Header1.Caption = "Produto"
            .Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Column7.Header1.Caption = "Cliente"
            .Column8.Header1.Caption = "Unidade Prod."

            *-- Ordem visual: Column8=UniPrdts na 1a posicao (conforme SCX original)
            .Column1.ColumnOrder = 2
            .Column2.ColumnOrder = 3
            .Column3.ColumnOrder = 4
            .Column4.ColumnOrder = 5
            .Column5.ColumnOrder = 6
            .Column6.ColumnOrder = 7
            .Column7.ColumnOrder = 8
            .Column8.ColumnOrder = 1

            *-- Destaque azul para registros com prioridade definida (Priors < 999990)
            .SetAll("DynamicForeColor", "IIF(cursor_4c_Dados.Priors<999990,RGB(0,0,255),RGB(0,0,0))", "Column")
        ENDWITH

        THIS.FormatarGridLista(loc_oGrid)

        *-- Atualiza metricas de capacidade vindas do BO
        WITH loc_oCnt2
            .txt_4c_Cap.Value = THIS.this_oBusinessObject.this_nCapacidade
            .txt_4c_Utz.Value = THIS.this_oBusinessObject.this_nUtilizado
            .txt_4c_Sld.Value = THIS.this_oBusinessObject.this_nSaldo
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual padrao ao grid
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Atualiza campos informativos ao navegar no grid
    * Exibe foto do produto, descricao, quantidade, cliente e tempo do envelope
    *   par_nColIndex - Indice da coluna (requerido pelo BINDEVENT AfterRowColChange)
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_lTemFoto, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.img_4c_FigJpg.Visible = .F.
        loc_oPg.shp_4c_Shape4.Visible = .F.
        loc_oPg.img_4c_FigJpg.Picture = ""

        IF !THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
            loc_oPg.txt_4c_Descr.Value   = ""
            loc_oPg.txt_4c_Qtde.Value    = 0
            loc_oPg.txt_4c_Cliente.Value = ""
            loc_oPg.txt_4c_TEnv.Value    = 0
            IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_InfoProd") = "O"
                WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_InfoProd
                    .txt_4c_Prod2.Value     = ""
                    .txt_4c_Descr2.Value    = ""
                    .img_4c_FigJpg2.Visible = .F.
                    .shp_4c_Shape2.Visible  = .F.
                    .img_4c_FigJpg2.Picture = ""
                ENDWITH
            ENDIF
            IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha") = "O"
                WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha
                    .txt_4c_Nenvs2.Value = 0
                    .txt_4c_Nops2.Value  = 0
                    .txt_4c_Seqs2.Value  = 0
                    .txt_4c_TReal2.Value = 0
                    .txt_4c_Dopes2.Value = ""
                    .txt_4c_UniP2.Value  = ""
                    .txt_4c_Rclis2.Value = ""
                    .Visible     = .T.
                ENDWITH
            ENDIF
            RETURN
        ENDIF

        loc_oPg.txt_4c_Qtde.Value    = THIS.this_oBusinessObject.this_nQuantidade
        loc_oPg.txt_4c_Cliente.Value = THIS.this_oBusinessObject.this_cCliente
        loc_oPg.txt_4c_TEnv.Value    = THIS.this_oBusinessObject.this_nTempoEnvelope

        loc_lTemFoto = THIS.this_oBusinessObject.ObterDetalheProduto( ;
            THIS.this_oBusinessObject.this_cProduto)

        loc_oPg.txt_4c_Descr.Value = THIS.this_oBusinessObject.this_cDescricaoProduto

        IF loc_lTemFoto AND !EMPTY(THIS.this_oBusinessObject.this_cCaminhoFoto)
            loc_oPg.img_4c_FigJpg.Picture = THIS.this_oBusinessObject.this_cCaminhoFoto
            loc_oPg.img_4c_FigJpg.Visible = .T.
            loc_oPg.shp_4c_Shape4.Visible = .T.
        ENDIF

        *-- Atualiza detalhe da linha no container de Page2
        IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha") = "O" AND USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            IF !EOF()
                WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_DetalheLinha
                    .txt_4c_Nenvs2.Value = NVL(cursor_4c_Dados.Nenvs,    0)
                    .txt_4c_Nops2.Value  = NVL(cursor_4c_Dados.Nops,     0)
                    .txt_4c_Seqs2.Value  = NVL(cursor_4c_Dados.Seqs,     0)
                    .txt_4c_TReal2.Value = NVL(cursor_4c_Dados.TempoReal, 0)
                    .txt_4c_Dopes2.Value = ALLTRIM(NVL(cursor_4c_Dados.Dopes,    ""))
                    .txt_4c_UniP2.Value  = ALLTRIM(NVL(cursor_4c_Dados.UniPrdts, ""))
                    .txt_4c_Rclis2.Value = ALLTRIM(NVL(cursor_4c_Dados.Rclis,    ""))
                    .Visible     = .T.
                ENDWITH
            ENDIF
        ENDIF

        *-- Atualiza campos de Page2 (configurada em ConfigurarPaginaDados - Fase 5)
        IF TYPE("THIS.pgf_4c_Paginas.Page2.cnt_4c_InfoProd") = "O"
            WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_InfoProd
                .txt_4c_Prod2.Value     = THIS.this_oBusinessObject.this_cProduto
                .txt_4c_Descr2.Value    = THIS.this_oBusinessObject.this_cDescricaoProduto
                .img_4c_FigJpg2.Visible = .F.
                .shp_4c_Shape2.Visible  = .F.
                .img_4c_FigJpg2.Picture = ""
                IF loc_lTemFoto AND !EMPTY(THIS.this_oBusinessObject.this_cCaminhoFoto)
                    .img_4c_FigJpg2.Picture = THIS.this_oBusinessObject.this_cCaminhoFoto
                    .img_4c_FigJpg2.Visible = .T.
                    .shp_4c_Shape2.Visible  = .T.
                ENDIF
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdSairClick - Fecha o formulario
    *==========================================================================
    PROCEDURE CmdSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre as paginas do PageFrame de conteudo
    *   par_nPagina - Numero da pagina (1=Principal, 2=Detalhes)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Popula Page2 com visao detalhada do registro selecionado
    * FASE 5/8 - Primeira metade: codigo/descricao do produto e foto ampliada
    * Acessada via duplo-clique no grid (GrdDadosDblClick)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oCnt

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Botao Voltar (retorna a Page1)
        loc_oPg2.AddObject("cmd_4c_Voltar", "CommandButton")
        WITH loc_oPg2.cmd_4c_Voltar
            .Top             = 5
            .Left            = 916
            .Width           = 75
            .Height          = 75
            .Caption         = "Voltar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_Voltar, "Click", THIS, "CmdVoltarClick")

        *-- Container de informacoes do produto (primeira metade dos campos de Page2)
        loc_oPg2.AddObject("cnt_4c_InfoProd", "Container")
        loc_oCnt = loc_oPg2.cnt_4c_InfoProd
        WITH loc_oCnt
            .Top         = 10
            .Left        = 10
            .Width       = 500
            .Height      = 490
            .BackStyle   = 0
            .BorderWidth = 0

            .AddObject("lbl_4c_LblProd2", "Label")
            WITH .lbl_4c_LblProd2
                .Top       = 10
                .Left      = 5
                .Width     = 150
                .Height    = 17
                .Caption   = "C" + CHR(243) + "d. Produto:"
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Prod2", "TextBox")
            WITH .txt_4c_Prod2
                .Top       = 30
                .Left      = 5
                .Width     = 200
                .Height    = 23
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Value     = ""
                .ReadOnly  = .T.
                .BackColor = RGB(255, 255, 198)
            ENDWITH

            .AddObject("lbl_4c_LblDescr2", "Label")
            WITH .lbl_4c_LblDescr2
                .Top       = 65
                .Left      = 5
                .Width     = 300
                .Height    = 17
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto:"
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Descr2", "TextBox")
            WITH .txt_4c_Descr2
                .Top       = 85
                .Left      = 5
                .Width     = 490
                .Height    = 23
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .FontSize  = 8
                .Value     = ""
                .ReadOnly  = .T.
                .BackColor = RGB(255, 255, 198)
            ENDWITH

            *-- Foto do produto ampliada (inicialmente oculta ate selecionar registro com foto)
            .AddObject("shp_4c_Shape2", "Shape")
            WITH .shp_4c_Shape2
                .Top           = 120
                .Left          = 5
                .Width         = 240
                .Height        = 240
                .Visible       = .F.
                .BackStyle     = 0
                .BorderColor   = RGB(90, 90, 90)
                .SpecialEffect = 0
            ENDWITH

            .AddObject("img_4c_FigJpg2", "Image")
            WITH .img_4c_FigJpg2
                .Top     = 122
                .Left    = 7
                .Width   = 236
                .Height  = 236
                .Visible = .F.
                .Stretch = 2
            ENDWITH
        ENDWITH

        *-- Container com detalhe da linha selecionada no grid (envelope, OP, seq, tempo, operacao, cliente, unidade)
        loc_oPg2.AddObject("cnt_4c_DetalheLinha", "Container")
        WITH loc_oPg2.cnt_4c_DetalheLinha
            .Top         = 10
            .Left        = 520
            .Width       = 460
            .Height      = 280
            .BackStyle   = 0
            .BorderWidth = 0

            .AddObject("lbl_4c_LblEnvDet", "Label")
            WITH .lbl_4c_LblEnvDet
                .Top       = 5
                .Left      = 5
                .Width     = 100
                .Height    = 17
                .Caption   = "Envelope:"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Nenvs2", "TextBox")
            WITH .txt_4c_Nenvs2
                .Top       = 22
                .Left      = 5
                .Width     = 100
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 255, 198)
                .Value     = 0
                .ReadOnly  = .T.
                .Alignment = 2
            ENDWITH

            .AddObject("lbl_4c_LblOpsDet", "Label")
            WITH .lbl_4c_LblOpsDet
                .Top       = 5
                .Left      = 120
                .Width     = 80
                .Height    = 17
                .Caption   = "O.P.:"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Nops2", "TextBox")
            WITH .txt_4c_Nops2
                .Top       = 22
                .Left      = 120
                .Width     = 100
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 255, 198)
                .Value     = 0
                .ReadOnly  = .T.
                .Alignment = 2
            ENDWITH

            .AddObject("lbl_4c_LblSeqDet", "Label")
            WITH .lbl_4c_LblSeqDet
                .Top       = 5
                .Left      = 240
                .Width     = 50
                .Height    = 17
                .Caption   = "Seq:"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Seqs2", "TextBox")
            WITH .txt_4c_Seqs2
                .Top       = 22
                .Left      = 240
                .Width     = 70
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 255, 198)
                .Value     = 0
                .ReadOnly  = .T.
                .Alignment = 2
            ENDWITH

            .AddObject("lbl_4c_LblTRealDet", "Label")
            WITH .lbl_4c_LblTRealDet
                .Top       = 5
                .Left      = 330
                .Width     = 100
                .Height    = 17
                .Caption   = "Minutos:"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_TReal2", "TextBox")
            WITH .txt_4c_TReal2
                .Top       = 22
                .Left      = 330
                .Width     = 100
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 255, 198)
                .InputMask = "99999"
                .Value     = 0
                .ReadOnly  = .T.
                .Alignment = 2
            ENDWITH

            .AddObject("lbl_4c_LblDopesDet", "Label")
            WITH .lbl_4c_LblDopesDet
                .Top       = 60
                .Left      = 5
                .Width     = 200
                .Height    = 17
                .Caption   = "Opera" + CHR(231) + CHR(227) + "o:"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Dopes2", "TextBox")
            WITH .txt_4c_Dopes2
                .Top       = 77
                .Left      = 5
                .Width     = 450
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 255, 198)
                .Value     = ""
                .ReadOnly  = .T.
            ENDWITH

            .AddObject("lbl_4c_LblUniPDet", "Label")
            WITH .lbl_4c_LblUniPDet
                .Top       = 115
                .Left      = 5
                .Width     = 160
                .Height    = 17
                .Caption   = "Unidade Produtiva:"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_UniP2", "TextBox")
            WITH .txt_4c_UniP2
                .Top       = 132
                .Left      = 5
                .Width     = 220
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 255, 198)
                .Value     = ""
                .ReadOnly  = .T.
            ENDWITH

            .AddObject("lbl_4c_LblRclisDet", "Label")
            WITH .lbl_4c_LblRclisDet
                .Top       = 170
                .Left      = 5
                .Width     = 60
                .Height    = 17
                .Caption   = "Cliente:"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Rclis2", "TextBox")
            WITH .txt_4c_Rclis2
                .Top       = 187
                .Left      = 5
                .Width     = 450
                .Height    = 23
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackColor = RGB(255, 255, 221)
                .Value     = ""
                .ReadOnly  = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * GrdDadosDblClick - Navega para Page2 (detalhe do produto) ao dar duplo-clique
    *==========================================================================
    PROCEDURE GrdDadosDblClick()
        IF USED("cursor_4c_Dados")
            THIS.GrdDadosAfterRowColChange(0)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdVoltarClick - Retorna a Page1 (visao principal do grid)
    *==========================================================================
    PROCEDURE CmdVoltarClick()
        THIS.pgf_4c_Paginas.Visible = .T.
        THIS.pgf_4c_Paginas.ActivePage = 1
        IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Recarrega a consulta com os parametros atuais
    * OPERACIONAL read-only: "Incluir" mapeia para refresh dos dados de capacidade
    * (equivalente a reprocessar a consulta parametrizada apos alteracao externa)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.LockScreen = .T.
            IF THIS.CarregarDados()
                IF USED("cursor_4c_Dados")
                    THIS.AtualizarGrid()
                    SELECT cursor_4c_Dados
                    GO TOP
                    THIS.GrdDadosAfterRowColChange(0)
                    IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
            ENDIF
            THIS.LockScreen = .F.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterna para Page2 com o detalhe do registro selecionado
    * OPERACIONAL read-only: "Alterar" mapeia para navegar ao detalhe (edicao
    * nao existe no fluxo original; SigCdPcz eh calculado, nao editavel)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Nenhum registro de capacidade produtiva disponivel.", "Aviso")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                SELECT cursor_4c_Dados
                IF EOF() OR RECCOUNT() = 0
                    MsgAviso("Selecione um registro do grid.", "Aviso")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF
            IF loc_lContinuar
                *-- Garante que campos de detalhe estao populados com a linha corrente
                THIS.GrdDadosAfterRowColChange(0)
                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Alterna para Page2 (detalhe do registro selecionado)
    * OPERACIONAL read-only: equivalente ao DblClick no grid (GrdDadosDblClick)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Nenhum registro de capacidade produtiva disponivel.", "Aviso")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                SELECT cursor_4c_Dados
                IF EOF() OR RECCOUNT() = 0
                    MsgAviso("Selecione um registro do grid.", "Aviso")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF
            IF loc_lContinuar
                *-- Popula Page2 com o registro corrente e navega
                THIS.GrdDadosAfterRowColChange(0)
                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Encerra a consulta e fecha o formulario
    * OPERACIONAL read-only: "Excluir" mapeia para encerrar a sessao de consulta
    * (equivalente ao botao Encerrar / CmdSairClick do form original)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja encerrar a consulta de capacidade produtiva?", "Confirma" + CHR(231) + CHR(227) + "o")
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Refresh completo: recarrega dados e atualiza grid
    * OPERACIONAL: equivalente a re-executar a consulta parametrizada
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = THIS.CarregarDados()
        IF loc_lSucesso AND USED("cursor_4c_Dados")
            THIS.AtualizarGrid()
            SELECT cursor_4c_Dados
            GO TOP
            THIS.GrdDadosAfterRowColChange(0)
            IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere parametros do form para o BO antes de consultar
    *==========================================================================
    PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_nCodigo  = THIS.this_nCodigo
            .this_cFase    = THIS.this_cFase
            .this_cUnidade = THIS.this_cUnidade
            .this_dData    = THIS.this_dData
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos do form com resultados calculados pelo BO
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oErro
        IF TYPE("THIS.pgf_4c_Paginas") != "O"
            RETURN
        ENDIF
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH loc_oPg.cnt_4c_Container1
                .txt_4c_Fase.Value = ALLTRIM(THIS.this_oBusinessObject.this_cFase)
                .txt_4c_Data.Value = DTOC(THIS.this_oBusinessObject.this_dData)
                .Visible     = .T.
            ENDWITH
            WITH loc_oPg.cnt_4c_Container2
                .txt_4c_Cap.Value = THIS.this_oBusinessObject.this_nCapacidade
                .txt_4c_Utz.Value = THIS.this_oBusinessObject.this_nUtilizado
                .txt_4c_Sld.Value = THIS.this_oBusinessObject.this_nSaldo
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Form OPERACIONAL somente-leitura: todos campos fixos
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        IF TYPE("THIS.pgf_4c_Paginas") != "O"
            RETURN
        ENDIF
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF TYPE("loc_oPg.cnt_4c_Container1") = "O"
            loc_oPg.cnt_4c_Container1.txt_4c_Fase.ReadOnly = .T.
            loc_oPg.cnt_4c_Container1.txt_4c_Data.ReadOnly = .T.
        ENDIF
        IF TYPE("loc_oPg.cnt_4c_Container2") = "O"
            loc_oPg.cnt_4c_Container2.txt_4c_Cap.ReadOnly = .T.
            loc_oPg.cnt_4c_Container2.txt_4c_Utz.ReadOnly = .T.
            loc_oPg.cnt_4c_Container2.txt_4c_Sld.ReadOnly = .T.
        ENDIF
        IF TYPE("loc_oPg.txt_4c_Descr") = "O"
            loc_oPg.txt_4c_Descr.ReadOnly   = .T.
            loc_oPg.txt_4c_Qtde.ReadOnly    = .T.
            loc_oPg.txt_4c_Cliente.ReadOnly = .T.
            loc_oPg.txt_4c_TEnv.ReadOnly    = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa campos informativos abaixo do grid
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_oErro
        IF TYPE("THIS.pgf_4c_Paginas") != "O"
            RETURN
        ENDIF
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Descr.Value    = ""
            loc_oPg.txt_4c_Qtde.Value     = 0
            loc_oPg.txt_4c_Cliente.Value  = ""
            loc_oPg.txt_4c_TEnv.Value     = 0
            loc_oPg.img_4c_FigJpg.Visible = .F.
            loc_oPg.img_4c_FigJpg.Picture = ""
            loc_oPg.shp_4c_Shape4.Visible = .F.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - OPERACIONAL sem modos CRUD: botoes fixos
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg
        IF TYPE("THIS.pgf_4c_Paginas") != "O"
            RETURN
        ENDIF
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF TYPE("loc_oPg.cmd_4c_Sair") = "O"
            loc_oPg.cmd_4c_Sair.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega consulta com parametros atuais (equivale a refresh)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.LockScreen = .T.
            IF THIS.CarregarDados()
                IF USED("cursor_4c_Dados")
                    THIS.AtualizarGrid()
                    SELECT cursor_4c_Dados
                    GO TOP
                    THIS.GrdDadosAfterRowColChange(0)
                    IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
            ENDIF
            THIS.LockScreen = .F.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Nao aplicavel em form OPERACIONAL somente-leitura
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + ;
            " de consulta somente leitura. " + ;
            "Opera" + CHR(231) + CHR(227) + "o de salvamento n" + ;
            CHR(227) + "o " + CHR(233) + " suportada.", ;
            "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Retorna a Page1 (visao principal do grid)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.pgf_4c_Paginas.Visible = .T.
        THIS.pgf_4c_Paginas.ActivePage = 1
        IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Dados") = "O"
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera BO e delega restante ao FormBase
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
