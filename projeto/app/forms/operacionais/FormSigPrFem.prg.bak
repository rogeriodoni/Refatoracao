*==============================================================================
* FormSigPrFem.prg - An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o
* Herda de: FormBase
* Tipo: OPERACIONAL (sem CRUD principal)
* Original: SIGPRFEM.SCX (Width=1000, Height=600, TitleBar=0)
* Layout: cnt_4c_Cabecalho + campos (DataI/DataF/Demonstrativo) + 4 botoes
*          + cnt_4c_Resultado (5 grades de detalhe + Resumo de totalizadores)
*==============================================================================

DEFINE CLASS FormSigPrFem AS FormBase

    *-- Dimensoes exatas do original
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    DataSession  = 2
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.
    Caption      = "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o"

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    * Init - Chama FormBase.Init que invoca InicializarForm
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrFemBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                THIS.cnt_4c_Resultado.Visible                 = .F.
                THIS.cnt_4c_Resultado.cnt_4c_Detalhe.Visible  = .F.
                THIS.cnt_4c_Resultado.cnt_4c_Detalhe2.Visible = .F.
                THIS.cnt_4c_Resultado.cnt_4c_Detalhe3.Visible = .F.
                THIS.cnt_4c_Resultado.cnt_4c_Detalhe4.Visible = .F.
                THIS.cnt_4c_Resultado.cnt_4c_Detalhe5.Visible = .F.

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.this_oBusinessObject.CarregarCursoresReferencia()
                    THIS.this_oBusinessObject.CriarCursoresTrabalho()
                ENDIF

                BINDEVENT(THIS.txt_4c_Demonstrativo, "KeyPress", THIS, "DemonstrativoKeyPress")
                BINDEVENT(THIS.txt_4c_Demonstrativo, "DblClick", THIS, "AbrirLookupDemonstrativo")
                BINDEVENT(THIS.cmd_4c_Processar,     "Click",    THIS, "CmdProcessarClick")
                BINDEVENT(THIS.cmd_4c_Visualizar,    "Click",    THIS, "CmdVisualizarClick")
                BINDEVENT(THIS.cmd_4c_Imprimir,      "Click",    THIS, "CmdImprimirClick")
                BINDEVENT(THIS.cmd_4c_Encerrar,      "Click",    THIS, "CmdEncerrarClick")

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrFemBO.", ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                "] [PROC=" + loc_oErro.Procedure + "]", ;
                "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador do layout
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *-- Compatibilidade com contrato FormBase (OPERACIONAL nao usa PageFrame real)
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Equivalente ao cntSombra do legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o"

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
                .Caption   = loc_cCaption
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
                .Caption   = loc_cCaption
            ENDWITH
            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Campos de entrada e botoes de acao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        *-- Shape2: delimitador visual da area de video/impressao
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top           = 7
            .Left          = 667
            .Height        = 75
            .Width         = 146
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
        ENDWITH

        *-- Shape1: delimitador visual da area de processar/encerrar
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 8
            .Left        = 816
            .Height      = 110
            .Width       = 173
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        *-- Label "Periodo :"
        THIS.AddObject("lbl_4c_Periodo", "Label")
        WITH THIS.lbl_4c_Periodo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 398
            .Top       = 90
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Data Inicial
        THIS.AddObject("txt_4c_DataI", "TextBox")
        WITH THIS.txt_4c_DataI
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 25
            .Left          = 445
            .Top           = 86
            .Width         = 80
            .Format        = "K"
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = {}
            .TabIndex      = 2
        ENDWITH

        *-- Separador entre as datas
        THIS.AddObject("lbl_4c_Separador", "Label")
        WITH THIS.lbl_4c_Separador
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = CHR(224)
            .Left      = 530
            .Top       = 90
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Data Final
        THIS.AddObject("txt_4c_DataF", "TextBox")
        WITH THIS.txt_4c_DataF
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 25
            .Left          = 542
            .Top           = 86
            .Width         = 80
            .Format        = "K"
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = {}
            .TabIndex      = 3
        ENDWITH

        *-- Label "Tipo Analise :"
        THIS.AddObject("lbl_4c_TipoAnalise", "Label")
        WITH THIS.lbl_4c_TipoAnalise
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Tipo An" + CHR(225) + "lise :"
            .Left      = 377
            .Top       = 118
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Demonstrativo (tipo de analise)
        THIS.AddObject("txt_4c_Demonstrativo", "TextBox")
        WITH THIS.txt_4c_Demonstrativo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 25
            .Left          = 445
            .Top           = 113
            .Width         = 154
            .MaxLength     = 20
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .TabIndex      = 5
            .ToolTipText   = "F4 ou duplo-clique para buscar"
        ENDWITH

        *-- Botao Visualizar (Video)
        THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH THIS.cmd_4c_Visualizar
            .Top             = 3
            .Left            = 700
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "   V" + CHR(237) + "deo            "
            .ToolTipText     = "Visualizar"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .Themes           = .T.
            .WordWrap        = .F.
            .TabIndex        = 29
            .Picture         = loc_cIcones + "relatorio_video_26.jpg"
        ENDWITH

        *-- Botao Imprimir
        THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cmd_4c_Imprimir
            .Top             = 3
            .Left            = 775
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = " Impressora    "
            .ToolTipText     = "Imprimir"
            .PicturePosition = 13
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .Themes           = .T.
            .WordWrap        = .F.
            .TabIndex        = 30
            .Picture         = loc_cIcones + "relatorio_impressora_26.jpg"
        ENDWITH

        *-- Botao Processar
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top        = 3
            .Left       = 850
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Caption    = "Processar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .TabIndex   = 7
            .Picture    = loc_cIcones + "geral_processar_60.jpg"
        ENDWITH

        *-- Botao Encerrar
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top        = 3
            .Left       = 925
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Caption    = "Encerrar"
            .Cancel     = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes           = .T.
            .TabIndex   = 8
            .Picture    = loc_cIcones + "cadastro_sair_60.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Container de resultados com grades e totalizadores
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oRes

        THIS.AddObject("cnt_4c_Resultado", "Container")
        WITH THIS.cnt_4c_Resultado
            .Top         = 144
            .Left        = 9
            .Width       = 981
            .Height      = 453
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        loc_oRes = THIS.cnt_4c_Resultado

        *----------------------------------------------------------------------
        * cnt_4c_Detalhe - Saldo com funcionarios antes do periodo (center top)
        *----------------------------------------------------------------------
        loc_oRes.AddObject("cnt_4c_Detalhe", "Container")
        WITH loc_oRes.cnt_4c_Detalhe
            .Top         = 5
            .Left        = 336
            .Width       = 294
            .Height      = 172
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .F.

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Saldo com funcion" + CHR(225) + "rios antes do per" + CHR(237) + "odo"
                .Left      = 9
                .Top       = 4
                .Height    = 15
                .Width     = 275
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            .grd_4c_Dados.ColumnCount = 3
            WITH .grd_4c_Dados
                .Top               = 24
                .Left              = 3
                .Width             = 288
                .Height            = 139
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .Panel             = 1
                .ReadOnly          = .T.
                .RowHeight         = 17
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Column1.Width     = 110
                .Column1.Movable   = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column1.FontName  = "Tahoma"
                .Column1.FontSize  = 8
                .Column2.Width     = 80
                .Column2.Movable   = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column2.FontName  = "Tahoma"
                .Column2.FontSize  = 8
                .Column3.Width     = 40
                .Column3.Movable   = .F.
                .Column3.Resizable = .F.
                .Column3.ReadOnly  = .T.
                .Column3.FontName  = "Tahoma"
                .Column3.FontSize  = 8
                .Column3.Header1.Caption = "Emp"
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Detalhe2 - Entradas no periodo (left top)
        *----------------------------------------------------------------------
        loc_oRes.AddObject("cnt_4c_Detalhe2", "Container")
        WITH loc_oRes.cnt_4c_Detalhe2
            .Top         = 4
            .Left        = 15
            .Width       = 294
            .Height      = 172
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .F.

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Entradas no per" + CHR(237) + "odo"
                .Left      = 9
                .Top       = 4
                .Height    = 15
                .Width     = 200
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            .grd_4c_Dados.ColumnCount = 3
            WITH .grd_4c_Dados
                .Top               = 24
                .Left              = 3
                .Width             = 288
                .Height            = 139
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .Panel             = 1
                .ReadOnly          = .T.
                .RowHeight         = 17
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Column1.Width     = 110
                .Column1.Movable   = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column1.FontName  = "Tahoma"
                .Column1.FontSize  = 8
                .Column2.Width     = 80
                .Column2.Movable   = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column2.FontName  = "Tahoma"
                .Column2.FontSize  = 8
                .Column3.Width     = 40
                .Column3.Movable   = .F.
                .Column3.Resizable = .F.
                .Column3.ReadOnly  = .T.
                .Column3.FontName  = "Tahoma"
                .Column3.FontSize  = 8
                .Column3.Header1.Caption = "Emp"
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Detalhe3 - Saidas no periodo (left bottom)
        *----------------------------------------------------------------------
        loc_oRes.AddObject("cnt_4c_Detalhe3", "Container")
        WITH loc_oRes.cnt_4c_Detalhe3
            .Top         = 184
            .Left        = 15
            .Width       = 294
            .Height      = 172
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .F.

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sa" + CHR(237) + "das no per" + CHR(237) + "odo"
                .Left      = 9
                .Top       = 4
                .Height    = 15
                .Width     = 180
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            .grd_4c_Dados.ColumnCount = 3
            WITH .grd_4c_Dados
                .Top               = 24
                .Left              = 3
                .Width             = 288
                .Height            = 139
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .Panel             = 1
                .ReadOnly          = .T.
                .RowHeight         = 17
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Column1.Width     = 110
                .Column1.Movable   = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column1.FontName  = "Tahoma"
                .Column1.FontSize  = 8
                .Column2.Width     = 80
                .Column2.Movable   = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column2.FontName  = "Tahoma"
                .Column2.FontSize  = 8
                .Column3.Width     = 40
                .Column3.Movable   = .F.
                .Column3.Resizable = .F.
                .Column3.ReadOnly  = .T.
                .Column3.FontName  = "Tahoma"
                .Column3.FontSize  = 8
                .Column3.Header1.Caption = "Emp"
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Detalhe4 - Saldo final com funcionarios (center bottom)
        *----------------------------------------------------------------------
        loc_oRes.AddObject("cnt_4c_Detalhe4", "Container")
        WITH loc_oRes.cnt_4c_Detalhe4
            .Top         = 184
            .Left        = 336
            .Width       = 294
            .Height      = 172
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .F.

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Saldo final com funcion" + CHR(225) + "rios"
                .Left      = 9
                .Top       = 4
                .Height    = 15
                .Width     = 220
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            .grd_4c_Dados.ColumnCount = 3
            WITH .grd_4c_Dados
                .Top               = 24
                .Left              = 3
                .Width             = 288
                .Height            = 139
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .Panel             = 1
                .ReadOnly          = .T.
                .RowHeight         = 17
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Column1.Width     = 110
                .Column1.Movable   = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column1.FontName  = "Tahoma"
                .Column1.FontSize  = 8
                .Column2.Width     = 80
                .Column2.Movable   = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column2.FontName  = "Tahoma"
                .Column2.FontSize  = 8
                .Column3.Width     = 40
                .Column3.Movable   = .F.
                .Column3.Resizable = .F.
                .Column3.ReadOnly  = .T.
                .Column3.FontName  = "Tahoma"
                .Column3.FontSize  = 8
                .Column3.Header1.Caption = "Emp"
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Detalhe5 - Falhas dos funcionarios (right top)
        *----------------------------------------------------------------------
        loc_oRes.AddObject("cnt_4c_Detalhe5", "Container")
        WITH loc_oRes.cnt_4c_Detalhe5
            .Top         = 5
            .Left        = 659
            .Width       = 294
            .Height      = 172
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .F.

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Falhas dos funcion" + CHR(225) + "rios no per" + CHR(237) + "odo"
                .Left      = 9
                .Top       = 4
                .Height    = 15
                .Width     = 270
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            .grd_4c_Dados.ColumnCount = 3
            WITH .grd_4c_Dados
                .Top               = 24
                .Left              = 3
                .Width             = 288
                .Height            = 139
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .Panel             = 1
                .ReadOnly          = .T.
                .RowHeight         = 17
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .Column1.Width     = 110
                .Column1.Movable   = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly  = .T.
                .Column1.FontName  = "Tahoma"
                .Column1.FontSize  = 8
                .Column2.Width     = 80
                .Column2.Movable   = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly  = .T.
                .Column2.FontName  = "Tahoma"
                .Column2.FontSize  = 8
                .Column3.Width     = 40
                .Column3.Movable   = .F.
                .Column3.Resizable = .F.
                .Column3.ReadOnly  = .T.
                .Column3.FontName  = "Tahoma"
                .Column3.FontSize  = 8
                .Column3.Header1.Caption = "Emp"
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        * cnt_4c_Resumo - Totalizadores (right bottom)
        *----------------------------------------------------------------------
        loc_oRes.AddObject("cnt_4c_Resumo", "Container")
        WITH loc_oRes.cnt_4c_Resumo
            .Top         = 184
            .Left        = 659
            .Width       = 294
            .Height      = 264
            .BackStyle   = 0
            .BorderColor = RGB(90, 90, 90)

            .AddObject("lbl_4c_Totalizadores", "Label")
            WITH .lbl_4c_Totalizadores
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Totalizadores"
                .Left      = 7
                .Top       = 4
                .Height    = 15
                .Width     = 120
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("lbl_4c_SaldoIni", "Label")
            WITH .lbl_4c_SaldoIni
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Saldo Inicial :"
                .Left      = 136
                .Top       = 27
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_SaldoIni", "TextBox")
            WITH .txt_4c_SaldoIni
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = 0
                .Height            = 21
                .InputMask         = "999,999.999"
                .Left              = 203
                .Margin            = 1
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .Top               = 25
                .Width             = 86
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            .AddObject("lbl_4c_SaldoAntP", "Label")
            WITH .lbl_4c_SaldoAntP
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Saldo funcion" + CHR(225) + "rios ant./ per" + CHR(237) + "odo :"
                .Left      = 39
                .Top       = 50
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_SaldoAntP", "TextBox")
            WITH .txt_4c_SaldoAntP
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = 0
                .Height            = 21
                .InputMask         = "999,999.999"
                .Left              = 203
                .Margin            = 1
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .Top               = 48
                .Width             = 86
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            .AddObject("lbl_4c_Entradas", "Label")
            WITH .lbl_4c_Entradas
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Entradas no per" + CHR(237) + "odo :"
                .Left      = 95
                .Top       = 73
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Entradas", "TextBox")
            WITH .txt_4c_Entradas
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = 0
                .Height            = 21
                .InputMask         = "999,999.999"
                .Left              = 203
                .Margin            = 1
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .Top               = 71
                .Width             = 86
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            .AddObject("lbl_4c_TotalEntradas", "Label")
            WITH .lbl_4c_TotalEntradas
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sub-Total entradas :"
                .Left      = 100
                .Top       = 96
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_TotalEntradas", "TextBox")
            WITH .txt_4c_TotalEntradas
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = 0
                .Height            = 21
                .InputMask         = "999,999.999"
                .Left              = 203
                .Margin            = 1
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .Top               = 94
                .Width             = 86
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            .AddObject("lbl_4c_Saidas", "Label")
            WITH .lbl_4c_Saidas
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sa" + CHR(237) + "das no per" + CHR(237) + "odo :"
                .Left      = 107
                .Top       = 119
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Saidas", "TextBox")
            WITH .txt_4c_Saidas
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = 0
                .Height            = 21
                .InputMask         = "999,999.999"
                .Left              = 203
                .Margin            = 1
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .Top               = 117
                .Width             = 86
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            .AddObject("lbl_4c_Saldo", "Label")
            WITH .lbl_4c_Saldo
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Saldo :"
                .Left      = 162
                .Top       = 142
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Saldo", "TextBox")
            WITH .txt_4c_Saldo
                .FontBold          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = 0
                .Height            = 21
                .InputMask         = "999,999.999"
                .Left              = 203
                .Margin            = 1
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .Top               = 140
                .Width             = 86
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            .AddObject("lbl_4c_SaldoFunc", "Label")
            WITH .lbl_4c_SaldoFunc
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Saldo final com funcion" + CHR(225) + "rios :"
                .Left      = 60
                .Top       = 165
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_SaldoFunc", "TextBox")
            WITH .txt_4c_SaldoFunc
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = 0
                .Height            = 21
                .InputMask         = "999,999.999"
                .Left              = 203
                .Margin            = 1
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .Top               = 163
                .Width             = 86
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            .AddObject("lbl_4c_Pesagem", "Label")
            WITH .lbl_4c_Pesagem
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Pesagem f" + CHR(237) + "sica :"
                .Left      = 122
                .Top       = 188
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Pesagem", "TextBox")
            WITH .txt_4c_Pesagem
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = 0
                .Height            = 21
                .InputMask         = "999,999.999"
                .Left              = 203
                .Margin            = 1
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .Top               = 186
                .Width             = 86
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            .AddObject("lbl_4c_Total", "Label")
            WITH .lbl_4c_Total
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Total :"
                .Left      = 164
                .Top       = 211
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_Total", "TextBox")
            WITH .txt_4c_Total
                .FontBold          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = 0
                .Height            = 21
                .InputMask         = "999,999.999"
                .Left              = 203
                .Margin            = 1
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .Top               = 209
                .Width             = 86
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            .AddObject("lbl_4c_FalhaFunc", "Label")
            WITH .lbl_4c_FalhaFunc
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Falha funcion" + CHR(225) + "rios no per" + CHR(237) + "odo :"
                .Left      = 51
                .Top       = 234
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            .AddObject("txt_4c_FalhaFunc", "TextBox")
            WITH .txt_4c_FalhaFunc
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = 0
                .Height            = 21
                .InputMask         = "999,999.999"
                .Left              = 203
                .Margin            = 1
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .Top               = 232
                .Width             = 86
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * cnt_4c_Resultado fica oculto (ativado apos Processar)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) != "O"
                LOOP
            ENDIF
            IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_RESULTADO", "CNT_4C_CABECALHO", ;
                    "CNT_4C_DETALHE", "CNT_4C_DETALHE2", "CNT_4C_DETALHE3", "CNT_4C_DETALHE4", ;
                    "CNT_4C_DETALHE5", "CNT_4C_RESUMO")
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * CmdProcessarClick - Equivalente a Processar.Click do legado
    *==========================================================================
    PROCEDURE CmdProcessarClick()
        LOCAL loc_oBO, loc_oErro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            loc_oBO.this_dDatai         = THIS.txt_4c_DataI.Value
            loc_oBO.this_dDataf         = THIS.txt_4c_DataF.Value
            loc_oBO.this_cDemonstrativo = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)

            THIS.cnt_4c_Resultado.Visible = .F.
            THIS.Refresh

            IF loc_oBO.ProcessarAnalise()
                THIS.AtualizarGrades()
                THIS.AtualizarTotalizadores()
                THIS.cnt_4c_Resultado.Visible = .T.
                THIS.Refresh
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
                "Erro ao Processar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarGrades - Vincula RecordSource/ControlSource em cada grade
    *==========================================================================
    PROTECTED PROCEDURE AtualizarGrades()
        LOCAL loc_oRes
        loc_oRes = THIS.cnt_4c_Resultado

        IF USED("SaldoAnt")
            SELECT SaldoAnt
            GO TOP
        ENDIF
        loc_oRes.cnt_4c_Detalhe.Visible = .T.
        loc_oRes.cnt_4c_Detalhe.grd_4c_Dados.ColumnCount  = 3
        loc_oRes.cnt_4c_Detalhe.grd_4c_Dados.RecordSource = "SaldoAnt"
        WITH loc_oRes.cnt_4c_Detalhe.grd_4c_Dados
            .Column1.ControlSource   = "SaldoAnt.Grupos"
            .Column1.Header1.Caption = "Header1"
            .Column2.ControlSource   = "SaldoAnt.Qtde"
            .Column2.Header1.Caption = "Header1"
            .Column3.ControlSource   = "SaldoAnt.Emps"
            .Column3.Header1.Caption = "Emp"
            .Refresh
        ENDWITH

        IF USED("Entradas")
            SELECT Entradas
            GO TOP
        ENDIF
        loc_oRes.cnt_4c_Detalhe2.Visible = .T.
        loc_oRes.cnt_4c_Detalhe2.grd_4c_Dados.ColumnCount  = 3
        loc_oRes.cnt_4c_Detalhe2.grd_4c_Dados.RecordSource = "Entradas"
        WITH loc_oRes.cnt_4c_Detalhe2.grd_4c_Dados
            .Column1.ControlSource   = "Entradas.TpOps"
            .Column1.Header1.Caption = "Header1"
            .Column2.ControlSource   = "Entradas.Qtde"
            .Column2.Header1.Caption = "Header1"
            .Column3.ControlSource   = "Entradas.Emps"
            .Column3.Header1.Caption = "Emp"
            .Refresh
        ENDWITH

        IF USED("Saidas")
            SELECT Saidas
            GO TOP
        ENDIF
        loc_oRes.cnt_4c_Detalhe3.Visible = .T.
        loc_oRes.cnt_4c_Detalhe3.grd_4c_Dados.ColumnCount  = 3
        loc_oRes.cnt_4c_Detalhe3.grd_4c_Dados.RecordSource = "Saidas"
        WITH loc_oRes.cnt_4c_Detalhe3.grd_4c_Dados
            .Column1.ControlSource   = "Saidas.TpOps"
            .Column1.Header1.Caption = "Header1"
            .Column2.ControlSource   = "Saidas.Qtde"
            .Column2.Header1.Caption = "Header1"
            .Column3.ControlSource   = "Saidas.Emps"
            .Column3.Header1.Caption = "Emp"
            .Refresh
        ENDWITH

        IF USED("Saldos")
            SELECT Saldos
            GO TOP
        ENDIF
        loc_oRes.cnt_4c_Detalhe4.Visible = .T.
        loc_oRes.cnt_4c_Detalhe4.grd_4c_Dados.ColumnCount  = 3
        loc_oRes.cnt_4c_Detalhe4.grd_4c_Dados.RecordSource = "Saldos"
        WITH loc_oRes.cnt_4c_Detalhe4.grd_4c_Dados
            .Column1.ControlSource   = "Saldos.Grupos"
            .Column1.Header1.Caption = "Header1"
            .Column2.ControlSource   = "Saldos.Qtde"
            .Column2.Header1.Caption = "Header1"
            .Column3.ControlSource   = "Saldos.Emps"
            .Column3.Header1.Caption = "Emp"
            .Refresh
        ENDWITH

        IF USED("Falhas")
            SELECT Falhas
            GO TOP
        ENDIF
        loc_oRes.cnt_4c_Detalhe5.Visible = .T.
        loc_oRes.cnt_4c_Detalhe5.grd_4c_Dados.ColumnCount  = 3
        loc_oRes.cnt_4c_Detalhe5.grd_4c_Dados.RecordSource = "Falhas"
        WITH loc_oRes.cnt_4c_Detalhe5.grd_4c_Dados
            .Column1.ControlSource   = "Falhas.Grupos"
            .Column1.Header1.Caption = "Header1"
            .Column2.ControlSource   = "Falhas.Qtde"
            .Column2.Header1.Caption = "Header1"
            .Column3.ControlSource   = "Falhas.Emps"
            .Column3.Header1.Caption = "Emp"
            .Refresh
        ENDWITH
    ENDPROC

    *==========================================================================
    * AtualizarTotalizadores - Preenche TextBoxes do Resumo com valores do BO
    *==========================================================================
    PROTECTED PROCEDURE AtualizarTotalizadores()
        LOCAL loc_oBO, loc_oResumo
        loc_oBO     = THIS.this_oBusinessObject
        loc_oResumo = THIS.cnt_4c_Resultado.cnt_4c_Resumo

        WITH loc_oResumo
            .txt_4c_SaldoIni.Value      = loc_oBO.this_nSaldoIni
            .txt_4c_SaldoAntP.Value     = loc_oBO.this_nSaldoaFun
            .txt_4c_Entradas.Value      = loc_oBO.this_nTotalEntra
            .txt_4c_TotalEntradas.Value = loc_oBO.this_nSaldoIni + loc_oBO.this_nTotalEntra + loc_oBO.this_nSaldoaFun
            .txt_4c_Saidas.Value        = loc_oBO.this_nTotalSaida
            .txt_4c_Saldo.Value         = loc_oBO.this_nSaldoIni + loc_oBO.this_nTotalEntra - loc_oBO.this_nTotalSaida + loc_oBO.this_nSaldoaFun
            .txt_4c_SaldoFunc.Value     = loc_oBO.this_nSaldoFunc
            .txt_4c_Pesagem.Value       = loc_oBO.this_nPesagem
            .txt_4c_Total.Value         = loc_oBO.this_nPesagem + loc_oBO.this_nSaldoFunc
            .txt_4c_FalhaFunc.Value     = loc_oBO.this_nFalhaFunc
        ENDWITH
    ENDPROC

    *==========================================================================
    * CmdVisualizarClick - Exibe relatorio em tela (Preview)
    *==========================================================================
    PROCEDURE CmdVisualizarClick()
        LOCAL loc_cRelatorio
        IF THIS.cnt_4c_Resultado.Visible
            IF USED("TmpImp")
                SELECT TmpImp
                GO TOP
                IF !EOF()
                    loc_cRelatorio = gc_4c_CaminhoBase + "reports\RelSigPrFem.frx"
                    IF FILE(loc_cRelatorio)
                        REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
                    ELSE
                        MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado." + CHR(13) + loc_cRelatorio)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdImprimirClick - Envia relatorio para impressora
    *==========================================================================
    PROCEDURE CmdImprimirClick()
        LOCAL loc_cRelatorio
        IF THIS.cnt_4c_Resultado.Visible
            IF USED("TmpImp")
                SELECT TmpImp
                GO TOP
                IF !EOF()
                    loc_cRelatorio = gc_4c_CaminhoBase + "reports\RelSigPrFem.frx"
                    IF FILE(loc_cRelatorio)
                        REPORT FORM (loc_cRelatorio) TO PRINT PROMPT NOCONSOLE
                    ELSE
                        MsgAviso("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado." + CHR(13) + loc_cRelatorio)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * DemonstrativoKeyPress - F4/Enter/Tab disparam validacao ou picker
    * LPARAMETERS obrigatorio como primeira linha (BINDEVENT KeyPress)
    *==========================================================================
    PROCEDURE DemonstrativoKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.AbrirLookupDemonstrativo()
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDemonstrativo()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDemonstrativo - Valida valor digitado contra SigPrDmo
    * Chamado por DemonstrativoKeyPress em Enter/Tab (NAO por LostFocus)
    *==========================================================================
    PROTECTED PROCEDURE ValidarDemonstrativo()
        LOCAL loc_cValor, loc_nRet
        loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        IF USED("cursor_4c_DmoValida")
            USE IN cursor_4c_DmoValida
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 Nome FROM SigPrDmo WHERE Nome = " + EscaparSQL(loc_cValor), ;
            "cursor_4c_DmoValida")
        IF loc_nRet > 0 AND NOT EOF("cursor_4c_DmoValida")
            SELECT cursor_4c_DmoValida
            THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
        ELSE
            THIS.AbrirLookupDemonstrativo()
        ENDIF
        IF USED("cursor_4c_DmoValida")
            USE IN cursor_4c_DmoValida
        ENDIF
        THIS.txt_4c_Demonstrativo.Refresh
    ENDPROC

    *==========================================================================
    * AbrirLookupDemonstrativo - Abre FormBuscaAuxiliar para SigPrDmo
    * Equivalente ao fwBuscaExt do legado (Get_Demonstrativo.Valid)
    *==========================================================================
    PROCEDURE AbrirLookupDemonstrativo()
        LOCAL loc_oForm, loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)

        IF USED("cursor_4c_DmoLista")
            USE IN cursor_4c_DmoLista
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrDmo", "cursor_4c_DmoLista", "Nome", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lAchouRegistro
            IF USED("cursor_4c_DmoLista")
                SELECT cursor_4c_DmoLista
                THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
            ENDIF
        ELSE
            loc_oForm.mAddColuna("Nome", "", "Nome")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_DmoLista")
                SELECT cursor_4c_DmoLista
                THIS.txt_4c_Demonstrativo.Value = ALLTRIM(Nome)
            ENDIF
        ENDIF

        IF USED("cursor_4c_DmoLista")
            USE IN cursor_4c_DmoLista
        ENDIF

        THIS.txt_4c_Demonstrativo.Refresh
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Nova analise: limpa filtros/resultados e foca DataI
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.cnt_4c_Resultado.Visible = .F.

            THIS.txt_4c_DataI.Value         = {}
            THIS.txt_4c_DataF.Value         = DATE()
            THIS.txt_4c_Demonstrativo.Value = ""

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_dDatai         = {}
                THIS.this_oBusinessObject.this_dDataf         = DATE()
                THIS.this_oBusinessObject.this_cDemonstrativo = ""
                THIS.this_oBusinessObject.this_nSaldoIni      = 0
                THIS.this_oBusinessObject.this_nSaldoaFun     = 0
                THIS.this_oBusinessObject.this_nTotalEntra    = 0
                THIS.this_oBusinessObject.this_nTotalSaida    = 0
                THIS.this_oBusinessObject.this_nSaldoFunc     = 0
                THIS.this_oBusinessObject.this_nPesagem       = 0
                THIS.this_oBusinessObject.this_nFalhaFunc     = 0
            ENDIF

            THIS.Refresh
            THIS.txt_4c_DataI.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
                "Erro ao Iniciar Nova An" + CHR(225) + "lise")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Reprocessa a analise com os parametros atuais
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF EMPTY(THIS.txt_4c_DataF.Value)
                MsgAviso("A Data Final deve ser informada.", ;
                    "Reprocessamento")
                THIS.txt_4c_DataF.SetFocus
                RETURN
            ENDIF

            IF EMPTY(THIS.txt_4c_Demonstrativo.Value)
                MsgAviso("A Configura" + CHR(231) + CHR(227) + ;
                    "o do Demonstrativo deve ser informada.", ;
                    "Reprocessamento")
                THIS.txt_4c_Demonstrativo.SetFocus
                RETURN
            ENDIF

            THIS.CmdProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
                "Erro ao Reprocessar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza relatorio (delega para CmdVisualizarClick)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF !THIS.cnt_4c_Resultado.Visible
                MsgAviso("Processe a an" + CHR(225) + "lise antes de visualizar o relat" + ;
                    CHR(243) + "rio.", "Visualizar")
                RETURN
            ENDIF
            THIS.CmdVisualizarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
                "Erro ao Visualizar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Limpa cursores de resultado e oculta painel
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro, loc_lConfirma
        TRY
            IF !THIS.cnt_4c_Resultado.Visible
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Deseja limpar os resultados da an" + ;
                CHR(225) + "lise atual?", "Limpar Resultados")

            IF !loc_lConfirma
                RETURN
            ENDIF

            IF USED("Entradas")
                SELECT Entradas
                ZAP
            ENDIF
            IF USED("Saidas")
                SELECT Saidas
                ZAP
            ENDIF
            IF USED("Saldos")
                SELECT Saldos
                ZAP
            ENDIF
            IF USED("SaldoAnt")
                SELECT SaldoAnt
                ZAP
            ENDIF
            IF USED("Falhas")
                SELECT Falhas
                ZAP
            ENDIF
            IF USED("TmpResumo")
                SELECT TmpResumo
                ZAP
            ENDIF
            IF USED("TmpImp")
                SELECT TmpImp
                ZAP
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_nSaldoIni   = 0
                THIS.this_oBusinessObject.this_nSaldoaFun  = 0
                THIS.this_oBusinessObject.this_nTotalEntra = 0
                THIS.this_oBusinessObject.this_nTotalSaida = 0
                THIS.this_oBusinessObject.this_nSaldoFunc  = 0
                THIS.this_oBusinessObject.this_nPesagem    = 0
                THIS.this_oBusinessObject.this_nFalhaFunc  = 0
            ENDIF

            THIS.cnt_4c_Resultado.Visible = .F.
            THIS.Refresh
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
                "Erro ao Limpar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza de recursos (cursores de referencia e trabalho)
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("crSigCdPam")
            USE IN crSigCdPam
        ENDIF
        IF USED("crSigCdPac")
            USE IN crSigCdPac
        ENDIF
        IF USED("crSigCdOpe")
            USE IN crSigCdOpe
        ENDIF
        IF USED("crSigCdOpd")
            USE IN crSigCdOpd
        ENDIF
        IF USED("crSigCdGcr")
            USE IN crSigCdGcr
        ENDIF
        IF USED("crSigCdUni")
            USE IN crSigCdUni
        ENDIF
        IF USED("LocalGru")
            USE IN LocalGru
        ENDIF
        IF USED("LocalGgrp")
            USE IN LocalGgrp
        ENDIF
        IF USED("Entradas")
            USE IN Entradas
        ENDIF
        IF USED("Saidas")
            USE IN Saidas
        ENDIF
        IF USED("Saldos")
            USE IN Saldos
        ENDIF
        IF USED("SaldoAnt")
            USE IN SaldoAnt
        ENDIF
        IF USED("Falhas")
            USE IN Falhas
        ENDIF
        IF USED("TmpResumo")
            USE IN TmpResumo
        ENDIF
        IF USED("TmpImp")
            USE IN TmpImp
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre lookup do Demonstrativo (F5/Buscar do padrao CRUD)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.AbrirLookupDemonstrativo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
                "Erro ao Buscar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Delega para CmdEncerrarClick (fecha o form)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro
        TRY
            THIS.CmdEncerrarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
                "Erro ao Encerrar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma parametros e dispara processamento
    * (Form OPERACIONAL nao persiste dados; equivalente a "Processar")
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro
        TRY
            IF !THIS.FormParaBO()
                loc_lResultado = .F.
            ENDIF
            THIS.CmdProcessarClick()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
                "Erro ao Processar")
            loc_lResultado = .F.
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela / limpa resultados sem confirmacao
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            THIS.LimparCampos()
            THIS.cnt_4c_Resultado.Visible = .F.
            THIS.Refresh
            IF PEMSTATUS(THIS, "txt_4c_DataI", 5)
                THIS.txt_4c_DataI.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
                "Erro ao Cancelar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza filtros do form -> BO (Datai, Dataf, Demonstrativo)
    * Retorna .T. se todos os campos obrigatorios estao preenchidos.
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_lOK
        loc_lOK = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Business Object nao inicializado.", "Erro")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.txt_4c_DataF.Value)
            MsgAviso("A Data Final deve ser informada.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_DataF.SetFocus
            RETURN .F.
        ENDIF

        IF !EMPTY(THIS.txt_4c_DataI.Value) AND ;
           THIS.txt_4c_DataI.Value > THIS.txt_4c_DataF.Value
            MsgAviso("A Data Final deve ser maior que a Data Inicial.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_DataI.SetFocus
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.txt_4c_Demonstrativo.Value))
            MsgAviso("A Configura" + CHR(231) + CHR(227) + ;
                "o do Demonstrativo deve ser informada.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Demonstrativo.SetFocus
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_dDatai         = THIS.txt_4c_DataI.Value
        THIS.this_oBusinessObject.this_dDataf         = THIS.txt_4c_DataF.Value
        THIS.this_oBusinessObject.this_cDemonstrativo = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)

        loc_lOK = .T.
        RETURN loc_lOK
    ENDPROC

    *==========================================================================
    * BOParaForm - Sincroniza BO -> form (filtros + totalizadores do resumo)
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oBO
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_DataI.Value         = loc_oBO.this_dDatai
        THIS.txt_4c_DataF.Value         = loc_oBO.this_dDataf
        THIS.txt_4c_Demonstrativo.Value = loc_oBO.this_cDemonstrativo

        WITH THIS.cnt_4c_Resultado.cnt_4c_Resumo
            .txt_4c_Saldoi.Value    = loc_oBO.this_nSaldoIni
            .txt_4c_SaldoAnt.Value  = loc_oBO.this_nSaldoaFun
            .txt_4c_Entradas.Value  = loc_oBO.this_nTotalEntra
            .txt_4c_TEntradas.Value = loc_oBO.this_nSaldoIni + loc_oBO.this_nSaldoaFun + loc_oBO.this_nTotalEntra
            .txt_4c_Saidas.Value    = loc_oBO.this_nTotalSaida
            .txt_4c_Saldo.Value     = (loc_oBO.this_nSaldoIni + loc_oBO.this_nSaldoaFun + loc_oBO.this_nTotalEntra) - loc_oBO.this_nTotalSaida
            .txt_4c_SaldoFunc.Value = loc_oBO.this_nSaldoFunc
            .txt_4c_Pesagem.Value   = loc_oBO.this_nPesagem
            .txt_4c_SaldoT.Value    = loc_oBO.this_nSaldoFunc + loc_oBO.this_nPesagem
            .txt_4c_FalhaFunc.Value = loc_oBO.this_nFalhaFunc
            .Visible     = .T.
        ENDWITH

        THIS.Refresh
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita filtros conforme par_lHabilitar
    * (Form OPERACIONAL: filtros sempre editaveis; durante processamento
    *  podem ser desabilitados temporariamente)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(PCOUNT() = 0, .T., par_lHabilitar)

        THIS.txt_4c_DataI.Enabled         = loc_lHab
        THIS.txt_4c_DataF.Enabled         = loc_lHab
        THIS.txt_4c_Demonstrativo.Enabled = loc_lHab
        THIS.cmd_4c_Processar.Enabled     = loc_lHab
        THIS.cmd_4c_Visualizar.Enabled    = loc_lHab AND THIS.cnt_4c_Resultado.Visible
        THIS.cmd_4c_Imprimir.Enabled      = loc_lHab AND THIS.cnt_4c_Resultado.Visible
        THIS.cmd_4c_Encerrar.Enabled      = .T.
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta filtros e propriedades do BO
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.txt_4c_DataI.Value         = {}
        THIS.txt_4c_DataF.Value         = DATE()
        THIS.txt_4c_Demonstrativo.Value = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_dDatai         = {}
            THIS.this_oBusinessObject.this_dDataf         = DATE()
            THIS.this_oBusinessObject.this_cDemonstrativo = ""
            THIS.this_oBusinessObject.this_nSaldoIni      = 0
            THIS.this_oBusinessObject.this_nSaldoaFun     = 0
            THIS.this_oBusinessObject.this_nTotalEntra    = 0
            THIS.this_oBusinessObject.this_nTotalSaida    = 0
            THIS.this_oBusinessObject.this_nSaldoFunc     = 0
            THIS.this_oBusinessObject.this_nPesagem       = 0
            THIS.this_oBusinessObject.this_nFalhaFunc     = 0
        ENDIF

        WITH THIS.cnt_4c_Resultado.cnt_4c_Resumo
            .txt_4c_Saldoi.Value    = 0
            .txt_4c_SaldoAnt.Value  = 0
            .txt_4c_Entradas.Value  = 0
            .txt_4c_TEntradas.Value = 0
            .txt_4c_Saidas.Value    = 0
            .txt_4c_Saldo.Value     = 0
            .txt_4c_SaldoFunc.Value = 0
            .txt_4c_Pesagem.Value   = 0
            .txt_4c_SaldoT.Value    = 0
            .txt_4c_FalhaFunc.Value = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega grades de resultado (delega para AtualizarGrades)
    * (Nome preservado por contrato com FormBase / padrao dos forms migrados)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oErro
        TRY
            IF !THIS.cnt_4c_Resultado.Visible
                loc_lResultado = .F.
            ENDIF
            THIS.AtualizarGrades()
            THIS.AtualizarTotalizadores()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", ;
                "Erro em CarregarLista")
            loc_lResultado = .F.
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Contrato do FormBase; OPERACIONAL nao tem modos CRUD
    * Ajusta apenas Visualizar/Imprimir conforme resultados exibidos.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemResultado
        loc_lTemResultado = THIS.cnt_4c_Resultado.Visible

        THIS.cmd_4c_Processar.Enabled  = .T.
        THIS.cmd_4c_Visualizar.Enabled = loc_lTemResultado
        THIS.cmd_4c_Imprimir.Enabled   = loc_lTemResultado
        THIS.cmd_4c_Encerrar.Enabled   = .T.
    ENDPROC

ENDDEFINE
