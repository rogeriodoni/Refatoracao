*==============================================================================
* Formsigprite.prg - Form Operacional: Itens de Ordem de Producao
* Herda de: FormBase
* Migrado de: SIGPRITE.SCX
* Tipo: OPERACIONAL - visualizacao somente-leitura de itens de OP
* Recebe parametros via Init: pEmp, pDop, pNum, pDis, pCnx (compatibilidade legado)
* O gnConnHandle global e usado diretamente (pCnx legado ignorado no novo sistema)
*==============================================================================

DEFINE CLASS Formsigprite AS FormBase

    *-- Propriedades visuais do form (copiadas do SCX original)
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .F.
    Caption     = "Itens"
    FontName    = "Verdana"
    FontSize    = 8
    ForeColor   = RGB(36, 84, 155)
    Themes      = .F.
    DataSession = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Parametros recebidos na abertura (armazenados para uso interno)
    this_cEmp        = ""     && Empresa (3 chars)
    this_cDop        = ""     && Codigo da operacao (20 chars)
    this_nNum        = 0      && Numero da OP
    this_lChecaDisps = .F.    && Verificar disponibilidade do produto

    *-- Arquivo temporario para imagem do produto
    this_cArquivoTemp = ""

    *-- Mensagem de erro para InicializarForm
    this_cMensagemErro = ""

    *==========================================================================
    PROCEDURE Init(par_cEmp, par_cDop, par_nNum, par_lDis, par_cCnx)
    *==========================================================================
        IF PCOUNT() >= 4
            THIS.this_cEmp        = IIF(VARTYPE(par_cEmp) = "C", ALLTRIM(par_cEmp), "")
            THIS.this_cDop        = IIF(VARTYPE(par_cDop) = "C", ALLTRIM(par_cDop), "")
            THIS.this_nNum        = IIF(VARTYPE(par_nNum)  = "N", par_nNum, 0)
            THIS.this_lChecaDisps = IIF(VARTYPE(par_lDis)  = "L", par_lDis, .F.)
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigpriteBO")

            *-- Aplicar background do form (equivalente ao Page.Picture do CRUD)
            THIS.ConfigurarPageFrame()

            *-- Verificar conexao antes de prosseguir
            IF gnConnHandle <= 0
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + CHR(227) + "o " + ;
                            "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Passar parametros para o BO
            THIS.this_oBusinessObject.this_cEmp        = THIS.this_cEmp
            THIS.this_oBusinessObject.this_cDop        = THIS.this_cDop
            THIS.this_oBusinessObject.this_nNum        = THIS.this_nNum
            THIS.this_oBusinessObject.this_lChecaDisps = THIS.this_lChecaDisps
            THIS.this_oBusinessObject.this_cEmpDopNum  = PADR(THIS.this_cEmp, 3) + ;
                                                         PADR(THIS.this_cDop, 20) + ;
                                                         STR(THIS.this_nNum, 6)

            *-- Arquivo temporario para imagem do produto
            THIS.this_cArquivoTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"

            *-- Titulo do form: "Empresa - Operacao - Numero - Itens"
            THIS.Caption = THIS.this_cEmp + " - " + THIS.this_cDop + " - " + ;
                           ALLTRIM(STR(THIS.this_nNum, 6)) + " - Itens"

            *-- Inicializar cursores no BO
            THIS.this_oBusinessObject.InicializarCursores()

            *-- Carregar info da operacao (Imagems)
            IF gnConnHandle > 0
                THIS.this_oBusinessObject.CarregarInfoOperacao(THIS.this_cDop)
            ENDIF

            *-- Construir interface visual
            THIS.LockScreen = .T.

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoesAcao()
            THIS.ConfigurarShapes()
            THIS.ConfigurarPaginaLista()
            THIS.TornarControlesVisiveis()
            THIS.ConfigurarBINDEVENTs()

            *-- Carregar dados (pular em modo de validacao de UI)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF gnConnHandle > 0
                    THIS.CarregarItens()
                ENDIF
            ENDIF

            THIS.LockScreen = .F.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Aplica background do form
    * Forms OPERACIONAIS nao usam PageFrame (layout customizado direto no Form),
    * mas o metodo eh mantido para compatibilidade com o padrao FormBase.
    * Aqui apenas define a imagem de fundo equivalente ao Page.Picture do CRUD.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImgFundo
        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza superior com titulo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top           = 18
                .Left          = 10
                .AutoSize      = .F.
                .Width         = THIS.Width
                .Height        = 40
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .BackStyle     = 0
                .WordWrap      = .T.
                .Alignment     = 0
                .ForeColor     = RGB(0, 0, 0)
                .Caption       = THIS.Caption
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top           = 17
                .Left          = 10
                .AutoSize      = .F.
                .Width         = THIS.Width
                .Height        = 46
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .BackStyle     = 0
                .WordWrap      = .T.
                .Alignment     = 0
                .ForeColor     = RGB(255, 255, 255)
                .Caption       = THIS.Caption
                .ToolTipText   = "T" + CHR(237) + "tulo do Formul" + CHR(225) + "rio"
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Botoes de acao: Encerrar, Subniveis, Entrega
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        *-- Botao Encerrar (cmdsair original - Top=3, Left=725 no legado 800px)
        *-- Proporcional para 1000px: Left = 917 (padrao canonico)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top            = 3
            .Left           = 917
            .Width          = 75
            .Height         = 75
            .Caption        = "Encerrar"
            .Cancel         = .T.
            .ToolTipText    = "[Esc] Encerrar"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .AutoSize       = .F.
            .Visible        = .T.
        ENDWITH

        *-- Botao Subniveis (Top=460, Left=691 no legado 800px)
        *-- Proporcional para 1000px: Left = 691 + 200 = 891 -> usar 691 (sem pgf, form nao tem pgf)
        *-- Legado original Left=691 em form 800px - manter proporcao em 1000px: Left=891-200=691
        *-- Na verdade o form nao tem pageframe entao manteremos os valores originais
        *-- O form operacional nao usa PageFrame, entao nao ha compensacao de Top
        THIS.AddObject("cmd_4c_Subniveis", "CommandButton")
        WITH THIS.cmd_4c_Subniveis
            .Top            = 460
            .Left           = 691
            .Width          = 75
            .Height         = 75
            .Caption        = "\<Subniveis"
            .Picture        = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .AutoSize       = .F.
            .Visible        = .T.
        ENDWITH

        *-- Botao Entrega (Top=460, Left=616 no legado)
        THIS.AddObject("cmd_4c_Entrega", "CommandButton")
        WITH THIS.cmd_4c_Entrega
            .Top            = 460
            .Left           = 616
            .Width          = 75
            .Height         = 75
            .Caption        = "\<Entrega"
            .Picture        = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .AutoSize       = .F.
            .Visible        = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarShapes - Shapes decorativos do layout original
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarShapes()
        *-- shpProdutos: borda ao redor da area de grids (Top=113, Left=21)
        THIS.AddObject("shp_4c_Produtos", "Shape")
        WITH THIS.shp_4c_Produtos
            .Top         = 113
            .Left        = 21
            .Height      = 320
            .Width       = 757
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Shape5: borda ao redor da area de descricao/observacao (Top=438)
        THIS.AddObject("shp_4c_Descricao", "Shape")
        WITH THIS.shp_4c_Descricao
            .Top         = 438
            .Left        = 21
            .Height      = 121
            .Width       = 584
            .BackStyle   = 0
            .Curvature   = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Shape1: borda ao redor do botao Encerrar
        THIS.AddObject("shp_4c_CmdSair", "Shape")
        WITH THIS.shp_4c_CmdSair
            .Top         = 7
            .Left        = 917
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- shpDisps: indicador visual de disponibilidade (pequeno quadrado)
        THIS.AddObject("shp_4c_Disps", "Shape")
        WITH THIS.shp_4c_Disps
            .Top          = 441
            .Left         = 254
            .Height       = 14
            .Width        = 14
            .BackStyle    = 1
            .SpecialEffect = 0
            .BackColor    = RGB(255, 255, 187)
            .Visible      = THIS.this_lChecaDisps
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrdCabec - Grid de cabecalho (informacoes da OP, 4 colunas)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdCabec()
        THIS.AddObject("grd_4c_Cabec", "Grid")
        WITH THIS.grd_4c_Cabec
            .Top              = 118
            .Left             = 26
            .Width            = 731
            .Height           = 35
            .ColumnCount      = 4
            .FontName         = "Arial"
            .AllowHeaderSizing = .F.
            .AllowRowSizing   = .F.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .ReadOnly         = .T.
            .ScrollBars       = 0
            .HeaderHeight     = 17
            .Panel            = 1
            .RecordSource     = "cursor_4c_Itens"
            .Visible          = .T.

            *-- Coluna 1: Produto (codigo)
            WITH .Column1
                .FontName       = "Arial"
                .Width          = 226
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.CPros"
                WITH .Header1
                    .FontBold   = .T.
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Produto"
                ENDWITH
                WITH .Text1
                    .FontName   = "Arial"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ReadOnly   = .T.
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Coluna 2: (vazia - separador visual no legado)
            WITH .Column2
                .FontName       = "Arial"
                .Width          = 20
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.Opers"
                WITH .Header1
                    .FontBold   = .T.
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                ENDWITH
                WITH .Text1
                    .FontName   = "Arial"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ReadOnly   = .T.
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Coluna 3: Quantidade
            WITH .Column3
                .FontName       = "Arial"
                .Width          = 242
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.QtdOs"
                WITH .Header1
                    .FontBold   = .T.
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Quantidade"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Coluna 4: Valor
            WITH .Column4
                .FontName       = "Arial"
                .Width          = 238
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.Totas"
                WITH .Header1
                    .FontBold   = .T.
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Valor"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Impedir redimensionamento e movimentacao de colunas
            .SetAll("Movable",    .F., "Column")
            .SetAll("Resizable",  .F., "Column")
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrdItens - Grid principal de itens (11 colunas)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdItens()
        THIS.AddObject("grd_4c_Itens", "Grid")
        WITH THIS.grd_4c_Itens
            .Top              = 135
            .Left             = 26
            .Width            = 750
            .Height           = 275
            .ColumnCount      = 11
            .FontName         = "Arial"
            .AllowHeaderSizing = .F.
            .AllowRowSizing   = .F.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .ReadOnly         = .T.
            .ScrollBars       = 2
            .HeaderHeight     = 17
            .RecordSource     = "cursor_4c_Itens"
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle   = 2
            .Visible          = .T.

            *-- Col 1: CItens (sequencial do item - sem header)
            WITH .Column1
                .FontName       = "Courier New"
                .Width          = 31
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.CItens"
                .InputMask      = "999999"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ReadOnly   = .T.
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Col 2: CPros (codigo produto - clickavel para abrir SIGOPCGP)
            WITH .Column2
                .FontName       = "Courier New"
                .Width          = 108
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.CPros"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Produto"
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .MousePointer = 99
                    .ReadOnly   = .T.
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Col 3: CUnis (unidade)
            WITH .Column3
                .FontName       = "Courier New"
                .Width          = 42
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.CUnis"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Unidade"
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Col 4: Volumes
            WITH .Column4
                .FontName       = "Courier New"
                .Width          = 42
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.Volumes"
                .InputMask      = "999"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Volume"
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Col 5: Opers (tipo operacao - bold, centralizado)
            WITH .Column5
                .FontBold       = .T.
                .FontName       = "Courier New"
                .Alignment      = 2
                .Width          = 20
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.Opers"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "O"
                ENDWITH
                WITH .Text1
                    .FontBold   = .T.
                    .Alignment  = 2
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Col 6: QtdOs (quantidade original)
            WITH .Column6
                .FontName       = "Courier New"
                .Width          = 80
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.QtdOs"
                .InputMask      = "9999999.99"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Original"
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Col 7: QtdBs (quantidade baixada)
            WITH .Column7
                .FontName       = "Courier New"
                .Width          = 80
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.QtdBs"
                .InputMask      = "9999999.99"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Baixada"
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Col 8: QtdSs (saldo = original - baixada)
            WITH .Column8
                .FontName       = "Courier New"
                .Width          = 80
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.QtdSs"
                .InputMask      = "9999999.99"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Saldo"
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Col 9: Units (preco unitario)
            WITH .Column9
                .FontName       = "Courier New"
                .Width          = 100
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.Units"
                .InputMask      = "999999999.99"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Unit" + CHR(225) + "rio"
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Col 10: CMoes (codigo da moeda)
            WITH .Column10
                .FontName       = "Courier New"
                .Width          = 36
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.CMoes"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Moeda"
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Col 11: Totas (valor total)
            WITH .Column11
                .FontName       = "Courier New"
                .Width          = 100
                .ReadOnly       = .T.
                .ControlSource  = "cursor_4c_Itens.Totas"
                .InputMask      = "999999999.99"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = "Valor Total"
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Impedir redimensionamento e movimentacao de colunas
            .SetAll("Movable",    .F., "Column")
            .SetAll("Resizable",  .F., "Column")
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Area inferior "Dados": descricao, observacao,
    * imagem e indicador de disponibilidade do produto selecionado no grid.
    * Para forms OPERACIONAIS (sem PageFrame), este metodo agrupa os campos
    * de detalhe do item corrente, equivalente a Page2/Dados de CRUD.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Label "Descricao Produto"
        THIS.AddObject("lbl_4c_DescricaoPro", "Label")
        WITH THIS.lbl_4c_DescricaoPro
            .Top        = 440
            .Left       = 30
            .FontSize   = 8
            .Caption    = "Descri" + CHR(231) + CHR(227) + "o Produto"
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        *-- TextBox somente-leitura para descricao do produto (Get_descr original)
        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .Top                  = 456
            .Left                 = 30
            .Width                = 396
            .Height               = 23
            .FontName             = "Tahoma"
            .FontSize             = 8
            .ControlSource        = "cursor_4c_Itens.DPros"
            .ReadOnly             = .T.
            .ForeColor            = RGB(0, 0, 0)
            .BackColor            = RGB(255, 255, 255)
            .DisabledBackColor    = RGB(255, 255, 255)
            .DisabledForeColor    = RGB(192, 192, 192)
            .BorderColor          = RGB(100, 100, 100)
            .Visible              = .T.
        ENDWITH

        *-- Label "Observacao Produto"
        THIS.AddObject("lbl_4c_ObsPro", "Label")
        WITH THIS.lbl_4c_ObsPro
            .Top        = 481
            .Left       = 30
            .FontSize   = 8
            .Caption    = "Observa" + CHR(231) + CHR(227) + "o Produto"
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        *-- EditBox somente-leitura para observacao (Get_obs original)
        THIS.AddObject("txt_4c_Obs", "EditBox")
        WITH THIS.txt_4c_Obs
            .Top           = 496
            .Left          = 30
            .Width         = 396
            .Height        = 57
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ControlSource = "cursor_4c_Itens.Obs"
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .NullDisplay   = " "
            .Visible       = .T.
        ENDWITH

        *-- Label de disponibilidade do produto (so visivel se pDis=.T.)
        THIS.AddObject("lbl_4c_Disps", "Label")
        WITH THIS.lbl_4c_Disps
            .Top        = 441
            .Left       = 270
            .FontSize   = 8
            .Caption    = "Disponibilidade do Produto"
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = THIS.this_lChecaDisps
        ENDWITH

        *-- Imagem do produto (inicialmente oculta, exibida por AfterRowColChange)
        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Stretch    = 1
            .Top        = 443
            .Left       = 433
            .Width      = 166
            .Height     = 111
            .Visible    = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrdRodape - Grid de rodape com totais por moeda (11 colunas)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdRodape()
        THIS.AddObject("grd_4c_Rodape", "Grid")
        WITH THIS.grd_4c_Rodape
            .Top              = 404
            .Left             = 26
            .Width            = 749
            .Height           = 25
            .ColumnCount      = 11
            .FontName         = "Arial"
            .AllowHeaderSizing = .F.
            .AllowRowSizing   = .F.
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .ReadOnly         = .T.
            .ScrollBars       = 2
            .HeaderHeight     = 4
            .RecordSource     = "cursor_4c_Rodape"
            .Visible          = .T.

            *-- As colunas do rodape espelham as do grdItens em largura
            *-- mas exibem os totais acumulados por moeda (sem header caption)
            *-- Col 1: vazia (alinha com CItens do grdItens)
            WITH .Column1
                .FontName       = "Courier New"
                .Width          = 31
                .ReadOnly       = .T.
                .BackColor      = RGB(255, 255, 223)
                .ControlSource  = "cursor_4c_Rodape.CPros"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                    .BackColor  = RGB(255, 255, 0)
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ReadOnly   = .T.
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 223)
                ENDWITH
            ENDWITH

            *-- Col 2: vazia (alinha com CPros)
            WITH .Column2
                .FontName       = "Courier New"
                .Width          = 108
                .ReadOnly       = .T.
                .BackColor      = RGB(255, 255, 223)
                .ControlSource  = "cursor_4c_Rodape.CPros"
                WITH .Header1
                    .FontName   = "Arial"
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                    .BackColor  = RGB(255, 255, 0)
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ReadOnly   = .T.
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 223)
                ENDWITH
            ENDWITH

            *-- Col 3: vazia (alinha com CUnis)
            WITH .Column3
                .FontName       = "Courier New"
                .Width          = 42
                .ReadOnly       = .T.
                .BackColor      = RGB(255, 255, 223)
                .ControlSource  = "cursor_4c_Rodape.CPros"
                WITH .Header1
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                    .BackColor  = RGB(255, 255, 0)
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 223)
                ENDWITH
            ENDWITH

            *-- Col 4: Volumes total
            WITH .Column4
                .FontName       = "Courier New"
                .Width          = 42
                .ReadOnly       = .T.
                .BackColor      = RGB(255, 255, 223)
                .ControlSource  = "cursor_4c_Rodape.Volumes"
                .InputMask      = "999"
                WITH .Header1
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                    .BackColor  = RGB(255, 255, 0)
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 223)
                ENDWITH
            ENDWITH

            *-- Col 5: vazia (alinha com Opers)
            WITH .Column5
                .FontName       = "Courier New"
                .Width          = 20
                .ReadOnly       = .T.
                .BackColor      = RGB(255, 255, 223)
                .ControlSource  = "cursor_4c_Rodape.CPros"
                WITH .Header1
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                    .BackColor  = RGB(255, 255, 0)
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 223)
                ENDWITH
            ENDWITH

            *-- Col 6: QtdOs total
            WITH .Column6
                .FontName       = "Courier New"
                .Width          = 80
                .ReadOnly       = .T.
                .BackColor      = RGB(255, 255, 223)
                .ControlSource  = "cursor_4c_Rodape.QtdOs"
                .InputMask      = "9999999.99"
                WITH .Header1
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                    .BackColor  = RGB(255, 255, 0)
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 223)
                ENDWITH
            ENDWITH

            *-- Col 7: QtdBs total
            WITH .Column7
                .FontName       = "Courier New"
                .Width          = 80
                .ReadOnly       = .T.
                .BackColor      = RGB(255, 255, 223)
                .ControlSource  = "cursor_4c_Rodape.QtdBs"
                .InputMask      = "9999999.99"
                WITH .Header1
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                    .BackColor  = RGB(255, 255, 0)
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 223)
                ENDWITH
            ENDWITH

            *-- Col 8: QtdSs total
            WITH .Column8
                .FontName       = "Courier New"
                .Width          = 80
                .ReadOnly       = .T.
                .BackColor      = RGB(255, 255, 223)
                .ControlSource  = "cursor_4c_Rodape.QtdSs"
                .InputMask      = "9999999.99"
                WITH .Header1
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                    .BackColor  = RGB(255, 255, 0)
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 223)
                ENDWITH
            ENDWITH

            *-- Col 9: vazia (alinha com Units)
            WITH .Column9
                .FontName       = "Courier New"
                .Width          = 100
                .ReadOnly       = .T.
                .BackColor      = RGB(255, 255, 223)
                .ControlSource  = "cursor_4c_Rodape.CPros"
                WITH .Header1
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                    .BackColor  = RGB(255, 255, 0)
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 223)
                ENDWITH
            ENDWITH

            *-- Col 10: CMoes (moeda)
            WITH .Column10
                .FontName       = "Courier New"
                .Width          = 36
                .ReadOnly       = .T.
                .BackColor      = RGB(255, 255, 223)
                .ControlSource  = "cursor_4c_Rodape.CMoes"
                WITH .Header1
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                    .BackColor  = RGB(255, 255, 0)
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 223)
                ENDWITH
            ENDWITH

            *-- Col 11: Totas total
            WITH .Column11
                .FontName       = "Courier New"
                .Width          = 100
                .ReadOnly       = .T.
                .BackColor      = RGB(255, 255, 223)
                .ControlSource  = "cursor_4c_Rodape.Totas"
                .InputMask      = "999999999.99"
                WITH .Header1
                    .FontSize   = 8
                    .Alignment  = 2
                    .Caption    = ""
                    .BackColor  = RGB(255, 255, 0)
                ENDWITH
                WITH .Text1
                    .FontName   = "Courier New"
                    .BorderStyle = 0
                    .Margin     = 0
                    .ForeColor  = RGB(0, 0, 0)
                    .BackColor  = RGB(255, 255, 223)
                ENDWITH
            ENDWITH

            *-- Impedir redimensionamento e movimentacao de colunas
            .SetAll("Movable",    .F., "Column")
            .SetAll("Resizable",  .F., "Column")
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Organiza a configuracao da visualizacao principal
    * Para este form OPERACIONAL (sem PageFrame), agrupa a configuracao dos
    * grids de cabecalho, itens, area de descricao/imagem e rodape de totais.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGrdCabec()
        THIS.ConfigurarGrdItens()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarGrdRodape()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Atualiza a exibicao dos grids apos recarregar dados.
    * Para este form OPERACIONAL sem PageFrame, nao ha alternancia de paginas:
    * o metodo sincroniza os tres grids e forca refresh visual sem flickering.
    *==========================================================================
    PROCEDURE AlternarPagina()
        THIS.LockScreen = .T.
        IF USED("cursor_4c_Itens")
            THIS.grd_4c_Cabec.Refresh
            THIS.grd_4c_Itens.Refresh
            THIS.grd_4c_Rodape.Refresh
        ENDIF
        THIS.Refresh
        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_oCtrl, loc_j, loc_oFilho
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                *-- img_4c_FigJpg inicia oculta (gerenciada por AfterRowColChange)
                *-- shp_4c_Disps e lbl_4c_Disps dependem de this_lChecaDisps
                IF UPPER(loc_oCtrl.Name) = "IMG_4C_FIGJPG"
                    LOOP
                ENDIF
                IF UPPER(loc_oCtrl.Name) = "SHP_4C_DISPS" OR ;
                   UPPER(loc_oCtrl.Name) = "LBL_4C_DISPS"
                    loc_oCtrl.Visible = THIS.this_lChecaDisps
                    LOOP
                ENDIF
                IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_SOMBRA")
                    IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                        FOR loc_j = 1 TO loc_oCtrl.ControlCount
                            loc_oFilho = loc_oCtrl.Controls(loc_j)
                            IF VARTYPE(loc_oFilho) = "O"
                                loc_oFilho.Visible = .T.
                            ENDIF
                        ENDFOR
                    ENDIF
                    LOOP
                ENDIF
                loc_oCtrl.Visible = .T.
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    FOR loc_j = 1 TO loc_oCtrl.ControlCount
                        loc_oFilho = loc_oCtrl.Controls(loc_j)
                        IF VARTYPE(loc_oFilho) = "O"
                            loc_oFilho.Visible = .T.
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincula eventos de interface
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        *-- Encerrar
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")

        *-- Subniveis
        BINDEVENT(THIS.cmd_4c_Subniveis, "Click", THIS, "CmdSubniveisClick")

        *-- Entrega
        BINDEVENT(THIS.cmd_4c_Entrega, "Click", THIS, "CmdEntregaClick")

        *-- Grid itens: mudar linha atualiza imagem e descricao
        BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", THIS, "GrdItensAfterRowColChange")

        *-- Duplo clique no produto abre consulta de produto
        BINDEVENT(THIS.grd_4c_Itens.Column2.Text1, "DblClick", THIS, "GrdItensProdutoDblClick")

        *-- GrdCabec: evitar foco no cabecalho (redirecionar para grdItens)
        BINDEVENT(THIS.grd_4c_Cabec.Column1.Text1, "GotFocus", THIS, "GrdCabecGotFocus")

        *-- GrdRodape: evitar foco no rodape (redirecionar para grdItens)
        BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", THIS, "GrdRodapeGotFocus")

        *-- Column2 de grdCabec: armazenar/restaurar valor (estabilidade visual)
        BINDEVENT(THIS.grd_4c_Cabec.Column2.Text1,  "GotFocus",  THIS, "GrdCabecCol2GotFocus")
        BINDEVENT(THIS.grd_4c_Cabec.Column2.Text1,  "KeyPress", THIS, "GrdCabecCol2LostFocus")

        *-- Column2 de grdRodape: armazenar/restaurar valor (estabilidade visual)
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus",  THIS, "GrdRodapeCol2GotFocus")
        BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "KeyPress", THIS, "GrdRodapeCol2LostFocus")
    ENDPROC

    *==========================================================================
    * CarregarItens - Executa a consulta SQL e popula os grids
    *==========================================================================
    PROCEDURE CarregarItens()
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN
        ENDIF
        IF gnConnHandle <= 0
            RETURN
        ENDIF
        LOCAL loc_lResultado
        loc_lResultado = THIS.this_oBusinessObject.BuscarItens()

        IF loc_lResultado
            *-- DynamicForeColor: QtdSs=0 em azul, >0 em preto
            THIS.grd_4c_Itens.SetAll("DynamicForeColor", ;
                "IIF(EMPTY(cursor_4c_Itens.QtdSs), RGB(0,0,255), RGB(0,0,0))", "Column")

            *-- DynamicBackColor para disponibilidade (so quando pDis=.T.)
            IF THIS.this_lChecaDisps
                THIS.grd_4c_Itens.SetAll("DynamicBackColor", ;
                    "IIF(cursor_4c_Itens.Disps < cursor_4c_Itens.QtdSs, " + ;
                    "RGB(255,255,255), RGB(255,255,223))", "Column")
            ENDIF

            IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
                THIS.grd_4c_Itens.Refresh
                THIS.grd_4c_Rodape.Refresh
                THIS.grd_4c_Itens.Column1.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdItensAfterRowColChange - Ao mudar linha: atualiza imagem do produto
    *==========================================================================
    PROCEDURE GrdItensAfterRowColChange(par_nColIndex)
        THIS.LockScreen = .T.

        THIS.img_4c_FigJpg.Visible  = .F.
        THIS.img_4c_FigJpg.Picture  = ""

        IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
            *-- Verificar se operacao tem imagem habilitada (Imagems=1)
            IF THIS.this_oBusinessObject.this_nImagems = 1 AND ;
               !EMPTY(cursor_4c_Itens.CPros)
                *-- Carregar imagem do produto
                IF THIS.this_oBusinessObject.CarregarImagemProduto( ;
                        ALLTRIM(cursor_4c_Itens.CPros), THIS.this_cArquivoTemp)
                    IF !EMPTY(THIS.this_oBusinessObject.this_cArquivo)
                        THIS.img_4c_FigJpg.Picture = THIS.this_oBusinessObject.this_cArquivo
                        THIS.img_4c_FigJpg.Visible = .T.
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        THIS.grd_4c_Itens.Refresh
        THIS.Refresh
        THIS.txt_4c_Obs.Refresh

        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * GrdItensProdutoDblClick - Duplo clique no codigo produto: abre SIGOPCGP
    *==========================================================================
    PROCEDURE GrdItensProdutoDblClick()
        LOCAL loc_cCPros
        IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
            loc_cCPros = ALLTRIM(cursor_4c_Itens.CPros)
            IF !EMPTY(loc_cCPros)
                *-- Abrir form de consulta de produto (Formsigprccp ou equivalente)
                *-- O legado abria SIGOPCGP.SCX - no novo sistema usar equivalente migrado
                TRY
                    IF VARTYPE(gobjExt1_sigprite) != "O" OR ISNULL(gobjExt1_sigprite)
                        PUBLIC gobjExt1_sigprite
                        gobjExt1_sigprite = CREATEOBJECT("Formsigprccp")
                        IF VARTYPE(gobjExt1_sigprite) = "O"
                            gobjExt1_sigprite.Show()
                        ENDIF
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                            "Erro ao abrir Consulta de Produto")
                ENDTRY
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdCabecGotFocus - Redireciona foco do cabecalho para grdItens
    *==========================================================================
    PROCEDURE GrdCabecGotFocus()
        IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
            THIS.grd_4c_Itens.Column1.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdRodapeGotFocus - Redireciona foco do rodape para grdItens
    *==========================================================================
    PROCEDURE GrdRodapeGotFocus()
        IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
            THIS.grd_4c_Itens.Column1.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdEncerrarClick - Fecha o form
    *==========================================================================
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * CmdSubniveisClick - Abre form de subniveis (SigMvMvt migrado)
    *==========================================================================
    PROCEDURE CmdSubniveisClick()
        LOCAL loc_cEmp, loc_cDop, loc_nNum
        loc_cEmp = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 1, 3)
        loc_cDop = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 4, 20)
        loc_nNum = INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 24, 6)))

        TRY
            LOCAL loc_oFrmSub
            loc_oFrmSub = CREATEOBJECT("FormSigMvMvt", .F., ;
                          ALLTRIM(loc_cEmp), ALLTRIM(loc_cDop), loc_nNum)
            IF VARTYPE(loc_oFrmSub) = "O"
                loc_oFrmSub.Show()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir Subniveis")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdEntregaClick - Abre form de entrega (SigOpDen migrado)
    *==========================================================================
    PROCEDURE CmdEntregaClick()
        LOCAL loc_cEmp, loc_cDop, loc_nNum
        loc_cEmp = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 1, 3)
        loc_cDop = SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 4, 20)
        loc_nNum = INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cEmpDopNum, 24, 6)))

        TRY
            LOCAL loc_oFrmEnt
            loc_oFrmEnt = CREATEOBJECT("FormSigOpDen", ;
                          ALLTRIM(loc_cEmp), ALLTRIM(loc_cDop), loc_nNum)
            IF VARTYPE(loc_oFrmEnt) = "O"
                loc_oFrmEnt.Show()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir Entrega")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdCabecCol2GotFocus / GrdCabecCol2LostFocus
    * Armazena valor corrente em Tag e restaura ao perder foco (estabilidade
    * visual da coluna separadora do grid de cabecalho - comportamento original)
    *==========================================================================
    PROCEDURE GrdCabecCol2GotFocus()
        THIS.grd_4c_Cabec.Column2.Text1.Tag = TRANSFORM(THIS.grd_4c_Cabec.Column2.Text1.Value)
    ENDPROC

    PROCEDURE GrdCabecCol2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF !EMPTY(THIS.grd_4c_Cabec.Column2.Text1.Tag)
            THIS.grd_4c_Cabec.Column2.Text1.Value = THIS.grd_4c_Cabec.Column2.Text1.Tag
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdRodapeCol2GotFocus / GrdRodapeCol2LostFocus
    * Idem para o grid de rodape (coluna 2 eh a descricao do produto - exibida
    * em branco no rodape mas precisa preservar o valor entre focos)
    *==========================================================================
    PROCEDURE GrdRodapeCol2GotFocus()
        THIS.grd_4c_Rodape.Column2.Text1.Tag = TRANSFORM(THIS.grd_4c_Rodape.Column2.Text1.Value)
    ENDPROC

    PROCEDURE GrdRodapeCol2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF !EMPTY(THIS.grd_4c_Rodape.Column2.Text1.Tag)
            THIS.grd_4c_Rodape.Column2.Text1.Value = THIS.grd_4c_Rodape.Column2.Text1.Tag
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Recarrega os itens da OP do banco (refresh do grid)
    * Este form OPERACIONAL eh um viewer read-only. "Visualizar" equivale a
    * recarregar do banco para refletir alteracoes feitas nas telas filhas
    * (Subniveis, Entrega) que podem alterar quantidades baixadas/saldos.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF gnConnHandle <= 0
            MsgErro("Sem conex" + CHR(227) + "o com o servidor de banco de dados.", ;
                    "Conex" + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.LockScreen = .T.
        THIS.this_oBusinessObject.CarregarInfoOperacao(THIS.this_cDop)
        THIS.CarregarItens()
        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre o form de Subniveis (SigMvMvt)
    * Este form OPERACIONAL nao insere itens diretamente (paridade com legado
    * SIGPRITE.SCX). A inclusao de subniveis eh feita no form dedicado aberto
    * via btnSubniveis. Este metodo redireciona para essa funcionalidade.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.CmdSubniveisClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre o form de Entrega (SigOpDen)
    * A alteracao das quantidades baixadas/entregues eh feita no form dedicado
    * aberto via btnEntrega (paridade com legado). Este metodo redireciona.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.CmdEntregaClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Encerra o form (equivalente ao cmdsair)
    * Este form OPERACIONAL nao suporta exclusao de itens (paridade com legado
    * SIGPRITE.SCX, que eh viewer read-only). A operacao encerra a janela.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o form (alias canonico para CmdEncerrarClick)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega itens do banco (alias para BtnVisualizarClick)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Form OPERACIONAL viewer nao tem edicao: encerra
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Form OPERACIONAL viewer nao tem edicao: encerra
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * CarregarLista - Alias canonico para CarregarItens
    *==========================================================================
    PROCEDURE CarregarLista()
        THIS.CarregarItens()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Form viewer nao tem modos CRUD; sem alteracao
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmd_4c_Subniveis) = "O"
            THIS.cmd_4c_Subniveis.Enabled = .T.
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Entrega) = "O"
            THIS.cmd_4c_Entrega.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Todos os controles sao somente-leitura neste viewer
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lAtivo
        loc_lAtivo = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF VARTYPE(THIS.cmd_4c_Subniveis) = "O"
            THIS.cmd_4c_Subniveis.Enabled = loc_lAtivo
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Entrega) = "O"
            THIS.cmd_4c_Entrega.Enabled = loc_lAtivo
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa os cursores e reseta a exibicao visual
    *==========================================================================
    PROCEDURE LimparCampos()
        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            ZAP
        ENDIF
        IF USED("cursor_4c_Rodape")
            SELECT cursor_4c_Rodape
            ZAP
        ENDIF
        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""
        IF VARTYPE(THIS.grd_4c_Itens) = "O"
            THIS.grd_4c_Itens.Refresh
        ENDIF
        IF VARTYPE(THIS.grd_4c_Rodape) = "O"
            THIS.grd_4c_Rodape.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Form OPERACIONAL viewer: nao ha campos editaveis.
    * Apenas atualiza os parametros de contexto no BO caso o chamador
    * precise repassar novos valores de Emp/Dop/Num antes de recarregar.
    *==========================================================================
    PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cEmp        = THIS.this_cEmp
        THIS.this_oBusinessObject.this_cDop        = THIS.this_cDop
        THIS.this_oBusinessObject.this_nNum        = THIS.this_nNum
        THIS.this_oBusinessObject.this_lChecaDisps = THIS.this_lChecaDisps
        THIS.this_oBusinessObject.this_cEmpDopNum  = PADR(THIS.this_cEmp, 3) + ;
                                                     PADR(THIS.this_cDop, 20) + ;
                                                     STR(THIS.this_nNum, 6)
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza o titulo do form com base nos parametros correntes
    * do BO. Os grids sao bound ao cursor via ControlSource; o refresh visual
    * eh feito diretamente em CarregarItens/AlternarPagina.
    *==========================================================================
    PROCEDURE BOParaForm()
        THIS.Caption = THIS.this_oBusinessObject.this_cEmp + " - " + ;
                       THIS.this_oBusinessObject.this_cDop + " - " + ;
                       ALLTRIM(STR(THIS.this_oBusinessObject.this_nNum, 6)) + " - Itens"
        IF VARTYPE(THIS.cnt_4c_Sombra) = "O"
            THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_oErro
        *-- Limpar arquivo temporario de imagem
        IF !EMPTY(THIS.this_cArquivoTemp) AND FILE(THIS.this_cArquivoTemp)
            TRY
                ERASE (THIS.this_cArquivoTemp)
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao remover imagem tempor" + CHR(225) + "ria")
            ENDTRY
        ENDIF

        *-- Liberar cursores do BO
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF
        IF USED("cursor_4c_Rodape")
            USE IN cursor_4c_Rodape
        ENDIF

        *-- Liberar BO
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
