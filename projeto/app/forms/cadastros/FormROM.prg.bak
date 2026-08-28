*==============================================================================
* FormROM.prg - Formulario de Romaneio XML
* Migrado de: SIGCDROM.SCX (frmcadastro)
* Tabelas: SigCdRom (cabecalho) + SigCdRoI (chaves NF-e)
* Parametro Init: 'R' = Recebimento, '' ou outro = Romaneio padrao
*==============================================================================

DEFINE CLASS FormROM AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1007
    Caption     = "Romaneio XML"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    MaxButton   = .F.
    Closable    = .F.
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2
    ShowTips    = .T.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cTipoRomaneio   = ""    && 'R'=Recebimento, ''=Romaneio

    *==========================================================================
    * Init - Captura parametro de tipo antes de InicializarForm
    *==========================================================================
    PROCEDURE Init(par_cTipo)
        LOCAL loc_cTipo
        loc_cTipo = ""
        IF PARAMETERS() > 0 AND TYPE("par_cTipo") == "C"
            loc_cTipo = LEFT(ALLTRIM(par_cTipo), 1)
        ENDIF
        THIS.this_cTipoRomaneio = loc_cTipo
        IF loc_cTipo == "R"
            THIS.Caption = "Romaneio Recebimento XML"
        ELSE
            THIS.Caption = "Romaneio XML"
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, cursores, PageFrame e controles
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ROMBO")
            THIS.this_oBusinessObject.this_cTipo = THIS.this_cTipoRomaneio

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar ROMBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormROM.InicializarForm")
            ELSE
                *-- Cursor principal (grid Lista)
                CREATE CURSOR cursor_4c_Dados ;
                    (Codigo C(10), Datas D, Tipo C(1), CodTransp C(20), Razaos C(60), ;
                     Contas C(20), RClis C(60), DepOrig C(20), dDepOrig C(60), ;
                     DepDest C(20), dDepDest C(60), ObsRed C(20), Valor N(15,2), ;
                     Usuarios C(20), DataAct D, nAceite N(1,0), aceite C(1), CidChaves C(20))

                *-- Cursor de chaves NF-e (grid Dados page)
                CREATE CURSOR cursor_4c_Chaves (Codigo C(10), Chave C(44), cIdChaves C(20))

                THIS.ConfigurarPageFrame()

                WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
                    .lbl_4c_Sombra.Caption = THIS.Caption
                    .lbl_4c_Titulo.Caption = THIS.Caption
                    .Visible = .T.
                ENDWITH

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormROM:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormROM.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame com 2 paginas (Lista + Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption  = "Lista"
            .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page2.Caption  = "Dados"
            .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grade
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_nLeft
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top       = 30
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top       = 29
            .Left      = 392
            .Width     = 460
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Botao Aceitar (visivel apenas para Recebimento)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Aceitar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Aceitar
            .Caption         = "Aceite"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 380
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = (THIS.this_cTipoRomaneio == "R")
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Aceitar, "Click", THIS, "BtnAceitarClick")

        *-- Container Saida (Encerrar) - PADRAO CANONICO
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top       = 29
            .Left      = 917
            .Width     = 90
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container de Filtros (periodo)
        loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
        WITH loc_oPagina.cnt_4c_Periodo
            .Top       = 115
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 44
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_LPeriodo", "Label")
        WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_LPeriodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 12
            .Left      = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DataIni", "TextBox")
        WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DataIni
            .Value         = DATE()
            .Top           = 10
            .Left          = 80
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Data inicial do per" + CHR(237) + "odo"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DataIni, "LostFocus", THIS, "DataIniLostFocus")

        loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_LSep", "Label")
        WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_LSep
            .Caption   = CHR(225)
            .Top       = 12
            .Left      = 168
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DataFim", "TextBox")
        WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DataFim
            .Value         = DATE()
            .Top           = 10
            .Left          = 180
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Data final do per" + CHR(237) + "odo"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DataFim, "LostFocus", THIS, "DataFimLostFocus")

        *-- Grid
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .Top             = 160
            .Left            = 5
            .Width           = THIS.Width - 10
            .Height          = 440
            .RecordSource    = "cursor_4c_Dados"
            .ReadOnly        = .T.
            .DeleteMark      = .F.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .ColumnCount     = 0
            .Visible         = .T.
            .RecordMark      = .F.
        ENDWITH

        THIS.ConfigurarColunasGrade()

        BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")
    ENDPROC

    *==========================================================================
    * ConfigurarColunasGrade - Configura colunas do grid conforme tipo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarColunasGrade()
        LOCAL loc_oGrid
        IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
            RETURN
        ENDIF
        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

        IF THIS.this_cTipoRomaneio == "R"
            *-- Modo Recebimento
            loc_oGrid.ColumnCount = 9
            WITH loc_oGrid.Column1
                .ControlSource    = "cursor_4c_Dados.Codigo"
                .Width            = 60
                .Header1.Caption  = "C" + CHR(243) + "digo"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column2
                .ControlSource    = "cursor_4c_Dados.DepOrig"
                .Width            = 80
                .Header1.Caption  = "Origem"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column3
                .ControlSource    = "cursor_4c_Dados.dDepOrig"
                .Width            = 150
                .Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column4
                .ControlSource    = "cursor_4c_Dados.DepDest"
                .Width            = 80
                .Header1.Caption  = "Destino"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column5
                .ControlSource    = "cursor_4c_Dados.dDepDest"
                .Width            = 150
                .Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column6
                .ControlSource    = "cursor_4c_Dados.Datas"
                .Width            = 73
                .Header1.Caption  = "Data"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column7
                .ControlSource    = "cursor_4c_Dados.ObsRed"
                .Width            = 150
                .Header1.Caption  = "Obs"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column8
                .ControlSource    = "cursor_4c_Dados.Contas"
                .Width            = 80
                .Header1.Caption  = "Conta"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column9
                .ControlSource    = "cursor_4c_Dados.aceite"
                .Width            = 60
                .Header1.Caption  = "Aceite"
                .Header1.Alignment = 0
            ENDWITH
            *-- Cor dinamica: azul para aceitos
            loc_oGrid.SetAll("DynamicForeColor", ;
                "IIF(cursor_4c_Dados.nAceite=1,RGB(0,0,255),RGB(0,0,0))", "Column")
        ELSE
            *-- Modo Romaneio
            loc_oGrid.ColumnCount = 8
            WITH loc_oGrid.Column1
                .ControlSource    = "cursor_4c_Dados.Codigo"
                .Width            = 60
                .Header1.Caption  = "C" + CHR(243) + "digo"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column2
                .ControlSource    = "cursor_4c_Dados.CodTransp"
                .Width            = 80
                .Header1.Caption  = "Transportadora"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column3
                .ControlSource    = "cursor_4c_Dados.Razaos"
                .Width            = 150
                .Header1.Caption  = "Nome"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column4
                .ControlSource    = "cursor_4c_Dados.Datas"
                .Width            = 73
                .Header1.Caption  = "Data"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column5
                .ControlSource    = "cursor_4c_Dados.Contas"
                .Width            = 80
                .Header1.Caption  = "Conta"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column6
                .ControlSource    = "cursor_4c_Dados.RClis"
                .Width            = 150
                .Header1.Caption  = "Nome"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column7
                .ControlSource    = "cursor_4c_Dados.Valor"
                .Width            = 80
                .Header1.Caption  = "Valor"
                .Header1.Alignment = 0
            ENDWITH
            WITH loc_oGrid.Column8
                .ControlSource    = "cursor_4c_Dados.Usuarios"
                .Width            = 80
                .Header1.Caption  = "Usu" + CHR(225) + "rio"
                .Header1.Alignment = 0
            ENDWITH
            loc_oGrid.SetAll("DynamicForeColor", ;
                "IIF(cursor_4c_Dados.nAceite=1,RGB(0,0,255),RGB(0,0,0))", "Column")
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: todos os controles de edicao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Botao Video (Preview) - legado top=11, left=566 -> +29=40
        loc_oPagina.AddObject("cmd_4c_Video", "CommandButton")
        WITH loc_oPagina.cmd_4c_Video
            .Caption         = "Video"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_visualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 40
            .Left            = 566
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Video, "Click", THIS, "BtnVideoClick")

        *-- Botao Imprimir - legado top=11, left=641 -> +29=40
        loc_oPagina.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH loc_oPagina.cmd_4c_Imprimir
            .Caption         = "Impress" + CHR(227) + "o"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_imprimir_60.jpg"
            .PicturePosition = 13
            .Top             = 40
            .Left            = 641
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Imprimir, "Click", THIS, "BtnImprimirClick")

        *-- Label Codigo - legado lbl_grupo top=95, left=247 -> +29=124
        loc_oPagina.AddObject("lbl_4c_LCodigo", "Label")
        WITH loc_oPagina.lbl_4c_LCodigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 124
            .Left      = 247
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo - legado getCodigo top=91, left=293, w=85 -> +29=120
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 120
            .Left          = 293
            .Width         = 85
            .Height        = 23
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "C" + CHR(243) + "digo do Romaneio"
            .Visible       = .T.
        ENDWITH

        *-- Checkbox Correios - legado chkTipos top=95, left=381 -> +29=124
        loc_oPagina.AddObject("chk_4c_Correios", "CheckBox")
        WITH loc_oPagina.chk_4c_Correios
            .Caption   = "Correios"
            .Value     = 0
            .Top       = 124
            .Left      = 381
            .Width     = 70
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .ReadOnly  = .T.
            .Visible   = (THIS.this_cTipoRomaneio <> "R")
        ENDWITH

        *-- Label Data - legado Say5 top=95, left=525 -> +29=124
        loc_oPagina.AddObject("lbl_4c_LData", "Label")
        WITH loc_oPagina.lbl_4c_LData
            .Caption   = "Data :"
            .Top       = 124
            .Left      = 463
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data - legado GetDatas top=91, left=561, w=74 -> +29=120
        loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oPagina.txt_4c_Datas
            .Value         = DATE()
            .Top           = 120
            .Left          = 495
            .Width         = 74
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Data do Romaneio"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Datas, "LostFocus", THIS, "DatasLostFocus")

        *-- Container cntRec (Recebimento): Origem, Destino, Obs
        *-- Legado: cntRec top=112, left=185, w=492, h=84 -> +29=141
        loc_oPagina.AddObject("cnt_4c_Rec", "Container")
        WITH loc_oPagina.cnt_4c_Rec
            .Top         = 150
            .Left        = 20
            .Width       = 650
            .Height      = 90
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = (THIS.this_cTipoRomaneio == "R")
        ENDWITH

        loc_oPagina.cnt_4c_Rec.AddObject("lbl_4c_LOrigem", "Label")
        WITH loc_oPagina.cnt_4c_Rec.lbl_4c_LOrigem
            .Caption   = "Origem :"
            .Top       = 8
            .Left      = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Rec.AddObject("txt_4c_DepOrig", "TextBox")
        WITH loc_oPagina.cnt_4c_Rec.txt_4c_DepOrig
            .Value         = ""
            .Top           = 4
            .Left          = 80
            .Width         = 85
            .Height        = 23
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "C" + CHR(243) + "digo Origem"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Rec.txt_4c_DepOrig, "LostFocus", THIS, "ValidarDepOrig")

        loc_oPagina.cnt_4c_Rec.AddObject("txt_4c_DDepOrig", "TextBox")
        WITH loc_oPagina.cnt_4c_Rec.txt_4c_DDepOrig
            .Value         = ""
            .Top           = 4
            .Left          = 170
            .Width         = 255
            .Height        = 23
            .MaxLength     = 60
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o Origem"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Rec.AddObject("lbl_4c_LDestino", "Label")
        WITH loc_oPagina.cnt_4c_Rec.lbl_4c_LDestino
            .Caption   = "Destino :"
            .Top       = 35
            .Left      = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Rec.AddObject("txt_4c_DepDest", "TextBox")
        WITH loc_oPagina.cnt_4c_Rec.txt_4c_DepDest
            .Value         = ""
            .Top           = 29
            .Left          = 80
            .Width         = 85
            .Height        = 23
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "C" + CHR(243) + "digo Destino"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Rec.txt_4c_DepDest, "LostFocus", THIS, "ValidarDepDest")

        loc_oPagina.cnt_4c_Rec.AddObject("txt_4c_DDepDest", "TextBox")
        WITH loc_oPagina.cnt_4c_Rec.txt_4c_DDepDest
            .Value         = ""
            .Top           = 29
            .Left          = 170
            .Width         = 255
            .Height        = 23
            .MaxLength     = 60
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o Destino"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Rec.AddObject("lbl_4c_LObs", "Label")
        WITH loc_oPagina.cnt_4c_Rec.lbl_4c_LObs
            .Caption   = "Obs. :"
            .Top       = 60
            .Left      = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Rec.AddObject("txt_4c_Obs", "TextBox")
        WITH loc_oPagina.cnt_4c_Rec.txt_4c_Obs
            .Value         = ""
            .Top           = 56
            .Left          = 80
            .Width         = 345
            .Height        = 23
            .MaxLength     = 100
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Observa" + CHR(231) + CHR(227) + "o"
            .Visible       = .T.
        ENDWITH

        *-- Container cntRom (Romaneio padrao): Transportadora, Cliente
        *-- Legado: cntRom top=108, left=180 -> +29=137
        loc_oPagina.AddObject("cnt_4c_Rom", "Container")
        WITH loc_oPagina.cnt_4c_Rom
            .Top         = 150
            .Left        = 20
            .Width       = 650
            .Height      = 90
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = (THIS.this_cTipoRomaneio <> "R")
        ENDWITH

        loc_oPagina.cnt_4c_Rom.AddObject("lbl_4c_LTransp", "Label")
        WITH loc_oPagina.cnt_4c_Rom.lbl_4c_LTransp
            .Caption   = "Transportadora :"
            .Top       = 12
            .Left      = 5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Rom.AddObject("txt_4c_CodTransp", "TextBox")
        WITH loc_oPagina.cnt_4c_Rom.txt_4c_CodTransp
            .Value         = ""
            .Top           = 8
            .Left          = 105
            .Width         = 85
            .Height        = 23
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "C" + CHR(243) + "digo da Transportadora"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Rom.txt_4c_CodTransp, "LostFocus", THIS, "ValidarTransportadora")

        loc_oPagina.cnt_4c_Rom.AddObject("txt_4c_DCodTransp", "TextBox")
        WITH loc_oPagina.cnt_4c_Rom.txt_4c_DCodTransp
            .Value         = ""
            .Top           = 8
            .Left          = 192
            .Width         = 255
            .Height        = 23
            .MaxLength     = 60
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Nome da Transportadora"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Rom.AddObject("lbl_4c_LCliente", "Label")
        WITH loc_oPagina.cnt_4c_Rom.lbl_4c_LCliente
            .Caption   = "Cliente :"
            .Top       = 37
            .Left      = 58
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Rom.AddObject("txt_4c_Contas", "TextBox")
        WITH loc_oPagina.cnt_4c_Rom.txt_4c_Contas
            .Value         = ""
            .Top           = 33
            .Left          = 105
            .Width         = 85
            .Height        = 23
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "C" + CHR(243) + "digo do Cliente"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Rom.txt_4c_Contas, "LostFocus", THIS, "ValidarContas")

        loc_oPagina.cnt_4c_Rom.AddObject("txt_4c_DContas", "TextBox")
        WITH loc_oPagina.cnt_4c_Rom.txt_4c_DContas
            .Value         = ""
            .Top           = 33
            .Left          = 192
            .Width         = 255
            .Height        = 23
            .MaxLength     = 60
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Nome do Cliente"
            .Visible       = .T.
        ENDWITH

        *-- Label Valor
        loc_oPagina.AddObject("lbl_4c_LValor", "Label")
        WITH loc_oPagina.lbl_4c_LValor
            .Caption   = "Valor :"
            .Top       = 252
            .Left      = 200
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Valor
        loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oPagina.txt_4c_Valor
            .Value         = 0
            .Top           = 249
            .Left          = 247
            .Width         = 100
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Valor total do Romaneio"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Valor, "LostFocus", THIS, "ValorLostFocus")

        *-- Label Qtde
        loc_oPagina.AddObject("lbl_4c_LQtde", "Label")
        WITH loc_oPagina.lbl_4c_LQtde
            .Caption   = "Qtde :"
            .Top       = 252
            .Left      = 370
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Total (contagem de chaves)
        loc_oPagina.AddObject("txt_4c_Total", "TextBox")
        WITH loc_oPagina.txt_4c_Total
            .Value         = 0
            .Top           = 249
            .Left          = 412
            .Width         = 60
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ReadOnly      = .T.
            .ToolTipText   = "Quantidade de chaves"
            .Visible       = .T.
        ENDWITH

        *-- Label Chaves
        loc_oPagina.AddObject("lbl_4c_LChaves", "Label")
        WITH loc_oPagina.lbl_4c_LChaves
            .Caption   = "Chaves :"
            .Top       = 278
            .Left      = 195
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Grid de Chaves NF-e - legado top=215, left=293, w=342, h=372 -> +29=244
        loc_oPagina.AddObject("grd_4c_Chaves", "Grid")
        WITH loc_oPagina.grd_4c_Chaves
            .Top             = 278
            .Left            = 247
            .Width           = 380
            .Height          = 310
            .RecordSource    = "cursor_4c_Chaves"
            .ReadOnly        = .T.
            .DeleteMark      = .F.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .ColumnCount     = 1
            .Visible         = .T.
            .RecordMark      = .F.
        ENDWITH

        WITH loc_oPagina.grd_4c_Chaves.Column1
            .ControlSource    = "cursor_4c_Chaves.Chave"
            .Width            = 380
            .ReadOnly         = .T.
            .Header1.Caption  = "Chave NF-e (44 d" + CHR(237) + "gitos)"
            .Header1.Alignment = 0
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Chaves, "AfterRowColChange", THIS, "GridChavesAfterRowColChange")

        *-- Botoes Inserir/Excluir chave - legado cmdInsFtc left=636
        loc_oPagina.AddObject("cmd_4c_InsChave", "CommandButton")
        WITH loc_oPagina.cmd_4c_InsChave
            .Caption         = "+"
            .Top             = 278
            .Left            = 640
            .Width           = 40
            .Height          = 30
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontSize        = 12
            .ForeColor       = RGB(0, 128, 0)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_InsChave, "Click", THIS, "BtnInsChaveClick")

        loc_oPagina.AddObject("cmd_4c_DelChave", "CommandButton")
        WITH loc_oPagina.cmd_4c_DelChave
            .Caption         = "-"
            .Top             = 315
            .Left            = 640
            .Width           = 40
            .Height          = 30
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontSize        = 12
            .ForeColor       = RGB(180, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_DelChave, "Click", THIS, "BtnDelChaveClick")

        *-- Botoes Confirmar e Cancelar
        loc_oPagina.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Top             = 540
            .Left            = 247
            .Width           = 100
            .Height          = 27
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        loc_oPagina.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Top             = 540
            .Left            = 357
            .Width           = 100
            .Height          = 27
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca dados com filtro de periodo
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_dIni, loc_dFim, loc_oPg1
        loc_lSucesso = .F.

        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_dIni = DATE()
            loc_dFim = DATE()

            IF PEMSTATUS(loc_oPg1, "cnt_4c_Periodo", 5)
                WITH loc_oPg1.cnt_4c_Periodo
                    IF PEMSTATUS(.Self, "txt_4c_DataIni", 5)
                        loc_dIni = .txt_4c_DataIni.Value
                    ENDIF
                    IF PEMSTATUS(.Self, "txt_4c_DataFim", 5)
                        loc_dFim = .txt_4c_DataFim.Value
                    ENDIF
                ENDWITH
            ENDIF

            loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_dIni, loc_dFim, THIS.this_cTipoRomaneio)

            IF PEMSTATUS(loc_oPg1, "grd_4c_Dados", 5)
                loc_oPg1.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormROM.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * IrParaDados - Muda para pagina de dados e carrega registro
    *==========================================================================
    PROTECTED PROCEDURE IrParaDados(par_cModo)
        LOCAL loc_lSucesso, loc_oPg2, loc_lReadOnly, loc_lNovo
        loc_lSucesso = .F.

        TRY
            THIS.this_cModoAtual = par_cModo
            loc_oPg2      = THIS.pgf_4c_Paginas.Page2
            loc_lReadOnly = (par_cModo == "VISUALIZAR")
            loc_lNovo     = (par_cModo == "INCLUIR")

            IF !loc_lNovo
                IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                    MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
                    RETURN .F.
                ELSE
                    THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
                    *-- Carregar chaves do banco
                    THIS.this_oBusinessObject.CarregarChaves(THIS.this_oBusinessObject.this_cCodigo)
                ENDIF
            ELSE
                *-- Limpar chaves para novo registro
                IF USED("cursor_4c_Chaves")
                    SELECT cursor_4c_Chaves
                    ZAP
                ENDIF
                THIS.this_oBusinessObject.this_dDatas = DATE()
            ENDIF

            THIS.BOParaForm()

            *-- Configurar ReadOnly dos campos
            THIS.AtualizarEstadoCampos(loc_lReadOnly)

            *-- Habilitars botoes de chave para edicao
            WITH loc_oPg2
                IF PEMSTATUS(.Self, "cmd_4c_InsChave", 5)
                    .cmd_4c_InsChave.Enabled = !loc_lReadOnly
                ENDIF
                IF PEMSTATUS(.Self, "cmd_4c_DelChave", 5)
                    .cmd_4c_DelChave.Enabled = !loc_lReadOnly
                ENDIF
                IF PEMSTATUS(.Self, "grd_4c_Chaves", 5)
                    .grd_4c_Chaves.Column1.ReadOnly = loc_lReadOnly
                ENDIF
                IF PEMSTATUS(.Self, "cmd_4c_Confirmar", 5)
                    .cmd_4c_Confirmar.Enabled = !loc_lReadOnly
                ENDIF
                IF PEMSTATUS(.Self, "cmd_4c_Video", 5)
                    .cmd_4c_Video.Enabled = loc_lReadOnly
                ENDIF
                IF PEMSTATUS(.Self, "cmd_4c_Imprimir", 5)
                    .cmd_4c_Imprimir.Enabled = loc_lReadOnly
                ENDIF
            ENDWITH

            THIS.AtualizarTotal()

            THIS.pgf_4c_Paginas.ActivePage = 2
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao ir para dados:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormROM.IrParaDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarEstadoCampos - Habilita/desabilita campos conforme modo
    *==========================================================================
    PROTECTED PROCEDURE AtualizarEstadoCampos(par_lReadOnly)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH loc_oPg2
            IF PEMSTATUS(.Self, "txt_4c_Datas", 5)
                .txt_4c_Datas.ReadOnly = par_lReadOnly
            ENDIF
            IF PEMSTATUS(.Self, "txt_4c_Valor", 5)
                .txt_4c_Valor.ReadOnly = par_lReadOnly
            ENDIF
            *-- Container Rec
            IF PEMSTATUS(.Self, "cnt_4c_Rec", 5)
                IF PEMSTATUS(.cnt_4c_Rec, "txt_4c_DepOrig", 5)
                    .cnt_4c_Rec.txt_4c_DepOrig.ReadOnly = par_lReadOnly
                ENDIF
                IF PEMSTATUS(.cnt_4c_Rec, "txt_4c_DepDest", 5)
                    .cnt_4c_Rec.txt_4c_DepDest.ReadOnly = par_lReadOnly
                ENDIF
                IF PEMSTATUS(.cnt_4c_Rec, "txt_4c_Obs", 5)
                    .cnt_4c_Rec.txt_4c_Obs.ReadOnly = par_lReadOnly
                ENDIF
            ENDIF
            *-- Container Rom
            IF PEMSTATUS(.Self, "cnt_4c_Rom", 5)
                IF PEMSTATUS(.cnt_4c_Rom, "txt_4c_CodTransp", 5)
                    .cnt_4c_Rom.txt_4c_CodTransp.ReadOnly = par_lReadOnly
                ENDIF
                IF PEMSTATUS(.cnt_4c_Rom, "txt_4c_Contas", 5)
                    .cnt_4c_Rom.txt_4c_Contas.ReadOnly = par_lReadOnly
                ENDIF
            ENDIF
            IF PEMSTATUS(.Self, "chk_4c_Correios", 5)
                .chk_4c_Correios.ReadOnly = par_lReadOnly
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * IrParaLista - Volta para pagina de lista
    *==========================================================================
    PROTECTED PROCEDURE IrParaLista()
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
        THIS.pgf_4c_Paginas.ActivePage = 1
    ENDPROC

    *==========================================================================
    * BOParaForm - Escreve propriedades do BO nos controles
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO, loc_cResultado, loc_aPartes[3]
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            WITH loc_oPg2
                IF PEMSTATUS(.Self, "txt_4c_Codigo", 5)
                    .txt_4c_Codigo.Value = loc_oBO.this_cCodigo
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Datas", 5)
                    .txt_4c_Datas.Value = IIF(EMPTY(loc_oBO.this_dDatas), DATE(), loc_oBO.this_dDatas)
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Valor", 5)
                    .txt_4c_Valor.Value = loc_oBO.this_nValor
                ENDIF

                IF THIS.this_cTipoRomaneio == "R"
                    IF PEMSTATUS(.Self, "cnt_4c_Rec", 5)
                        WITH .cnt_4c_Rec
                            IF PEMSTATUS(.Self, "txt_4c_DepOrig", 5)
                                .txt_4c_DepOrig.Value  = loc_oBO.this_cDepOrig
                                .txt_4c_DDepOrig.Value = IIF(!EMPTY(loc_oBO.this_cDepOrig), ;
                                    loc_oBO.BuscarDepartamento(loc_oBO.this_cDepOrig), "")
                            ENDIF
                            IF PEMSTATUS(.Self, "txt_4c_DepDest", 5)
                                .txt_4c_DepDest.Value  = loc_oBO.this_cDepDest
                                .txt_4c_DDepDest.Value = IIF(!EMPTY(loc_oBO.this_cDepDest), ;
                                    loc_oBO.BuscarDepartamento(loc_oBO.this_cDepDest), "")
                            ENDIF
                            IF PEMSTATUS(.Self, "txt_4c_Obs", 5)
                                .txt_4c_Obs.Value = loc_oBO.this_cObs
                            ENDIF
                        ENDWITH
                    ENDIF
                ELSE
                    IF PEMSTATUS(.Self, "cnt_4c_Rom", 5)
                        WITH .cnt_4c_Rom
                            IF PEMSTATUS(.Self, "txt_4c_CodTransp", 5)
                                .txt_4c_CodTransp.Value = loc_oBO.this_cCodTransp
                                IF !EMPTY(loc_oBO.this_cCodTransp)
                                    loc_cResultado = loc_oBO.BuscarTransportadora(loc_oBO.this_cCodTransp)
                                    .txt_4c_DCodTransp.Value = GETWORDNUM(loc_cResultado, 1, CHR(9))
                                    *-- Checa se eh Correios
                                    LOCAL loc_cIdT
                                    loc_cIdT = UPPER(ALLTRIM(GETWORDNUM(loc_cResultado, 2, CHR(9))))
                                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "chk_4c_Correios", 5)
                                        THIS.pgf_4c_Paginas.Page2.chk_4c_Correios.Value = ;
                                            IIF(INLIST(loc_cIdT,"192B31E","15F2739"), 1, 0)
                                    ENDIF
                                ELSE
                                    .txt_4c_DCodTransp.Value = ""
                                ENDIF
                            ENDIF
                            IF PEMSTATUS(.Self, "txt_4c_Contas", 5)
                                .txt_4c_Contas.Value = loc_oBO.this_cContas
                                IF !EMPTY(loc_oBO.this_cContas)
                                    loc_cResultado = loc_oBO.BuscarCliente(loc_oBO.this_cContas)
                                    .txt_4c_DContas.Value = GETWORDNUM(loc_cResultado, 1, CHR(9))
                                ELSE
                                    .txt_4c_DContas.Value = ""
                                ENDIF
                            ENDIF
                        ENDWITH
                    ENDIF
                ENDIF

                IF PEMSTATUS(.Self, "grd_4c_Chaves", 5)
                    .grd_4c_Chaves.Refresh()
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormROM.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Le controles e escreve no BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            WITH loc_oPg2
                IF PEMSTATUS(.Self, "txt_4c_Datas", 5)
                    loc_oBO.this_dDatas = .txt_4c_Datas.Value
                ENDIF
                IF PEMSTATUS(.Self, "txt_4c_Valor", 5)
                    loc_oBO.this_nValor = .txt_4c_Valor.Value
                ENDIF
                loc_oBO.this_cTipo = THIS.this_cTipoRomaneio

                IF THIS.this_cTipoRomaneio == "R"
                    IF PEMSTATUS(.Self, "cnt_4c_Rec", 5)
                        WITH .cnt_4c_Rec
                            IF PEMSTATUS(.Self, "txt_4c_DepOrig", 5)
                                loc_oBO.this_cDepOrig = ALLTRIM(.txt_4c_DepOrig.Value)
                            ENDIF
                            IF PEMSTATUS(.Self, "txt_4c_DepDest", 5)
                                loc_oBO.this_cDepDest = ALLTRIM(.txt_4c_DepDest.Value)
                            ENDIF
                            IF PEMSTATUS(.Self, "txt_4c_Obs", 5)
                                loc_oBO.this_cObs = ALLTRIM(.txt_4c_Obs.Value)
                            ENDIF
                        ENDWITH
                    ENDIF
                    loc_oBO.this_cCodTransp = ""
                    loc_oBO.this_cContas    = ""
                ELSE
                    IF PEMSTATUS(.Self, "cnt_4c_Rom", 5)
                        WITH .cnt_4c_Rom
                            IF PEMSTATUS(.Self, "txt_4c_CodTransp", 5)
                                loc_oBO.this_cCodTransp = ALLTRIM(.txt_4c_CodTransp.Value)
                            ENDIF
                            IF PEMSTATUS(.Self, "txt_4c_Contas", 5)
                                loc_oBO.this_cContas = ALLTRIM(.txt_4c_Contas.Value)
                            ENDIF
                        ENDWITH
                    ENDIF
                    loc_oBO.this_cDepOrig = ""
                    loc_oBO.this_cDepDest = ""
                    loc_oBO.this_cObs     = ""
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormROM.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarTotal - Atualiza contagem de chaves no campo Total
    *==========================================================================
    PROCEDURE AtualizarTotal()
        LOCAL loc_nTotal, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_nTotal = THIS.this_oBusinessObject.ObterTotalChaves()

        IF PEMSTATUS(loc_oPg2, "txt_4c_Total", 5)
            loc_oPg2.txt_4c_Total.Value = loc_nTotal
            loc_oPg2.txt_4c_Total.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_oPg2
        loc_lValido = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCodigo))
                MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF

            IF loc_lValido
                IF EMPTY(THIS.this_oBusinessObject.this_dDatas)
                    MsgAviso("Data obrigat" + CHR(243) + "ria.", "Valida" + CHR(231) + CHR(227) + "o")
                    IF PEMSTATUS(loc_oPg2, "txt_4c_Datas", 5)
                        loc_oPg2.txt_4c_Datas.SetFocus()
                    ENDIF
                    loc_lValido = .F.
                ENDIF
            ENDIF

            IF loc_lValido AND THIS.this_cTipoRomaneio == "R"
                IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cDepOrig))
                    MsgAviso("Origem obrigat" + CHR(243) + "ria.", "Valida" + CHR(231) + CHR(227) + "o")
                    IF PEMSTATUS(loc_oPg2, "cnt_4c_Rec", 5)
                        IF PEMSTATUS(loc_oPg2.cnt_4c_Rec, "txt_4c_DepOrig", 5)
                            loc_oPg2.cnt_4c_Rec.txt_4c_DepOrig.SetFocus()
                        ENDIF
                    ENDIF
                    loc_lValido = .F.
                ENDIF
            ENDIF

            IF loc_lValido AND THIS.this_cTipoRomaneio == "R"
                IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cDepDest))
                    MsgAviso("Destino obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
                    IF PEMSTATUS(loc_oPg2, "cnt_4c_Rec", 5)
                        IF PEMSTATUS(loc_oPg2.cnt_4c_Rec, "txt_4c_DepDest", 5)
                            loc_oPg2.cnt_4c_Rec.txt_4c_DepDest.SetFocus()
                        ENDIF
                    ENDIF
                    loc_lValido = .F.
                ENDIF
            ENDIF

            IF loc_lValido AND THIS.this_cTipoRomaneio <> "R"
                IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCodTransp))
                    MsgAviso("Transportadora obrigat" + CHR(243) + "ria.", "Valida" + CHR(231) + CHR(227) + "o")
                    IF PEMSTATUS(loc_oPg2, "cnt_4c_Rom", 5)
                        IF PEMSTATUS(loc_oPg2.cnt_4c_Rom, "txt_4c_CodTransp", 5)
                            loc_oPg2.cnt_4c_Rom.txt_4c_CodTransp.SetFocus()
                        ENDIF
                    ENDIF
                    loc_lValido = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormROM.ValidarDados")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BtnIncluirClick
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso, loc_lCodigoOk
        loc_lSucesso  = .F.
        loc_lCodigoOk = .F.

        TRY
            IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
                *-- Modo teste: pula GerarCodigo (requer DB)
                THIS.this_oBusinessObject.this_cCodigo    = "TESTE001"
                THIS.this_oBusinessObject.this_lCodigoGerado = .F.
                THIS.this_oBusinessObject.this_dDatas     = DATE()
                THIS.this_oBusinessObject.this_nNAceite   = 0
                THIS.this_oBusinessObject.this_nValor     = 0
                loc_lCodigoOk = .T.
            ELSE
                loc_lCodigoOk = THIS.this_oBusinessObject.GerarCodigo()
            ENDIF

            IF loc_lCodigoOk
                THIS.this_oBusinessObject.this_cTipo     = THIS.this_cTipoRomaneio
                THIS.this_oBusinessObject.this_cCodTransp = ""
                THIS.this_oBusinessObject.this_cContas    = ""
                THIS.this_oBusinessObject.this_cDepOrig   = ""
                THIS.this_oBusinessObject.this_cDepDest   = ""
                THIS.this_oBusinessObject.this_cObs       = ""
                THIS.this_oBusinessObject.this_nNAceite   = 0
                THIS.this_oBusinessObject.this_nValor     = 0
                loc_lSucesso = THIS.IrParaDados("INCLUIR")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormROM.BtnIncluirClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnAlterarClick
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF

            IF cursor_4c_Dados.nAceite = 1
                MsgAviso("Romaneio J" + CHR(225) + " Aceito !!!", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF

            loc_lSucesso = THIS.IrParaDados("ALTERAR")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormROM.BtnAlterarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
            loc_lSucesso = THIS.IrParaDados("VISUALIZAR")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormROM.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnExcluirClick
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF

            IF cursor_4c_Dados.nAceite = 1
                MsgAviso("Romaneio J" + CHR(225) + " Aceito !!!", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF

            THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")

            IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste Romaneio?", "Excluir")
                RETURN .F.
            ENDIF

            loc_lSucesso = THIS.this_oBusinessObject.Excluir()

            IF loc_lSucesso
                MsgInfo("Romaneio exclu" + CHR(237) + "do com sucesso.", "Sucesso")
                THIS.IrParaLista()
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Excluir")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormROM.BtnExcluirClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnAceitarClick - Aceita o romaneio selecionado
    *==========================================================================
    PROCEDURE BtnAceitarClick()
        LOCAL loc_lSucesso, loc_cCodigo
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                RETURN .F.
            ENDIF

            SELECT cursor_4c_Dados

            IF cursor_4c_Dados.nAceite = 1
                MsgAviso("Romaneio J" + CHR(225) + " Aceito !!!", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF

            IF !MsgConfirma("Deseja Aceitar o Romaneio ???", "ATEN" + CHR(199) + CHR(195) + "O !!!")
                RETURN .F.
            ENDIF

            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)
            loc_lSucesso = THIS.this_oBusinessObject.Aceitar(loc_cCodigo)

            IF loc_lSucesso
                THIS.CarregarLista()
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            ELSE
                MsgErro("Erro ao aceitar o Romaneio.", "Aceitar")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormROM.BtnAceitarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnBuscarClick
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Salva o romaneio (cabecalho + chaves)
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lSucesso, loc_oBO, loc_lInserir
        loc_lSucesso = .F.

        TRY
            THIS.FormParaBO()

            IF !THIS.ValidarDados()
                RETURN .F.
            ENDIF

            loc_oBO     = THIS.this_oBusinessObject
            loc_lInserir = (THIS.this_cModoAtual == "INCLUIR")

            *-- Configura estado do BO para BusinessBase.Salvar()
            loc_oBO.this_lEmEdicao    = .T.
            loc_oBO.this_lNovoRegistro = loc_lInserir

            *-- Salvar cabecalho (Inserir ou Atualizar)
            loc_lSucesso = loc_oBO.Salvar()

            IF loc_lSucesso
                *-- Salvar chaves (SigCdRoI)
                IF !loc_oBO.SalvarChaves(loc_oBO.this_cCodigo)
                    MsgErro("Erro ao salvar chaves.", "Confirmar")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                THIS.IrParaLista()
            ELSE
                MsgErro(loc_oBO.this_cMensagemErro, "Erro ao Salvar")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "FormROM.BtnConfirmarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao (libera codigo se INCLUIR)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            IF THIS.this_cModoAtual == "INCLUIR"
                THIS.this_oBusinessObject.CancelarCodigo()
            ENDIF
        CATCH TO loc_oErro
        ENDTRY
        THIS.IrParaLista()
    ENDPROC

    *==========================================================================
    * BtnVideoClick - Preview do relatorio
    *==========================================================================
    PROCEDURE BtnVideoClick()
        LOCAL loc_cCodigo
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)
            loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
            IF !EMPTY(loc_cCodigo)
                THIS.this_oBusinessObject.Imprimir("V", loc_cCodigo)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - Impressao do relatorio
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cCodigo
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)
            loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
            IF !EMPTY(loc_cCodigo)
                THIS.this_oBusinessObject.Imprimir("I", loc_cCodigo)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnInsChaveClick - Adiciona linha em branco ao grid de chaves
    *==========================================================================
    PROCEDURE BtnInsChaveClick()
        IF THIS.this_cModoAtual != "INCLUIR" AND THIS.this_cModoAtual != "ALTERAR"
            RETURN
        ENDIF
        IF USED("cursor_4c_Chaves")
            SELECT cursor_4c_Chaves
            INSERT INTO cursor_4c_Chaves (Codigo, Chave, cIdChaves) ;
                VALUES (THIS.this_oBusinessObject.this_cCodigo, "", ;
                        LEFT(SYS(2015) + SYS(2015), 20))
            THIS.AtualizarTotal()
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Chaves", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Chaves.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnDelChaveClick - Remove linha atual do grid de chaves
    *==========================================================================
    PROCEDURE BtnDelChaveClick()
        IF THIS.this_cModoAtual != "INCLUIR" AND THIS.this_cModoAtual != "ALTERAR"
            RETURN
        ENDIF
        IF USED("cursor_4c_Chaves") AND !EOF("cursor_4c_Chaves")
            SELECT cursor_4c_Chaves
            IF !EOF()
                DELETE
                PACK
            ENDIF
            THIS.AtualizarTotal()
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Chaves", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Chaves.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Handlers de validacao de campos
    *==========================================================================
    PROCEDURE ValidarDepOrig()
        LOCAL loc_cCod, loc_cDesc, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !PEMSTATUS(loc_oPg2, "cnt_4c_Rec", 5)
            RETURN
        ENDIF
        IF !PEMSTATUS(loc_oPg2.cnt_4c_Rec, "txt_4c_DepOrig", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg2.cnt_4c_Rec.txt_4c_DepOrig.Value)
        IF EMPTY(loc_cCod)
            loc_oPg2.cnt_4c_Rec.txt_4c_DDepOrig.Value = ""
            THIS.this_oBusinessObject.this_cDepOrig = ""
            RETURN
        ENDIF
        loc_cDesc = THIS.this_oBusinessObject.BuscarDepartamento(loc_cCod)
        IF EMPTY(loc_cDesc)
            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) == "O"
                LOCAL loc_nResult
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Codigos, Descricaos FROM SigCdDpt " + ;
                    "WHERE Codigos LIKE " + EscaparSQL(loc_cCod + "%") + ;
                    " OR Descricaos LIKE " + EscaparSQL(loc_cCod + "%") + ;
                    " ORDER BY Codigos", "cursor_4c_BuscaDpt")
                IF loc_nResult > 0 AND USED("cursor_4c_BuscaDpt") AND RECCOUNT("cursor_4c_BuscaDpt") > 0
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaDpt", "Codigos", "Descricaos", ;
                        "Selecionar Departamento Origem")
                    loc_oBusca.Mostrar()
                    IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                        loc_cCod  = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                        loc_cDesc = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                        loc_oPg2.cnt_4c_Rec.txt_4c_DepOrig.Value  = loc_cCod
                        loc_oPg2.cnt_4c_Rec.txt_4c_DDepOrig.Value = loc_cDesc
                        THIS.this_oBusinessObject.this_cDepOrig = loc_cCod
                    ELSE
                        loc_oPg2.cnt_4c_Rec.txt_4c_DepOrig.Value  = ""
                        loc_oPg2.cnt_4c_Rec.txt_4c_DDepOrig.Value = ""
                        THIS.this_oBusinessObject.this_cDepOrig = ""
                    ENDIF
                ELSE
                    MsgAviso("Departamento n" + CHR(227) + "o encontrado.", "Origem")
                    loc_oPg2.cnt_4c_Rec.txt_4c_DepOrig.Value  = ""
                    loc_oPg2.cnt_4c_Rec.txt_4c_DDepOrig.Value = ""
                    THIS.this_oBusinessObject.this_cDepOrig = ""
                ENDIF
                IF USED("cursor_4c_BuscaDpt")
                    USE IN cursor_4c_BuscaDpt
                ENDIF
            ENDIF
        ELSE
            loc_oPg2.cnt_4c_Rec.txt_4c_DDepOrig.Value = loc_cDesc
            THIS.this_oBusinessObject.this_cDepOrig = loc_cCod
        ENDIF
    ENDPROC

    PROCEDURE ValidarDepDest()
        LOCAL loc_cCod, loc_cDesc, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !PEMSTATUS(loc_oPg2, "cnt_4c_Rec", 5)
            RETURN
        ENDIF
        IF !PEMSTATUS(loc_oPg2.cnt_4c_Rec, "txt_4c_DepDest", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg2.cnt_4c_Rec.txt_4c_DepDest.Value)
        IF EMPTY(loc_cCod)
            loc_oPg2.cnt_4c_Rec.txt_4c_DDepDest.Value = ""
            THIS.this_oBusinessObject.this_cDepDest = ""
            RETURN
        ENDIF
        loc_cDesc = THIS.this_oBusinessObject.BuscarDepartamento(loc_cCod)
        IF EMPTY(loc_cDesc)
            MsgAviso("Departamento n" + CHR(227) + "o encontrado.", "Destino")
            loc_oPg2.cnt_4c_Rec.txt_4c_DepDest.Value  = ""
            loc_oPg2.cnt_4c_Rec.txt_4c_DDepDest.Value = ""
            THIS.this_oBusinessObject.this_cDepDest = ""
        ELSE
            loc_oPg2.cnt_4c_Rec.txt_4c_DDepDest.Value = loc_cDesc
            THIS.this_oBusinessObject.this_cDepDest = loc_cCod
        ENDIF
    ENDPROC

    PROCEDURE ValidarTransportadora()
        LOCAL loc_cCod, loc_cResultado, loc_cRazao, loc_cIdT, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !PEMSTATUS(loc_oPg2, "cnt_4c_Rom", 5)
            RETURN
        ENDIF
        IF !PEMSTATUS(loc_oPg2.cnt_4c_Rom, "txt_4c_CodTransp", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg2.cnt_4c_Rom.txt_4c_CodTransp.Value)
        IF EMPTY(loc_cCod)
            loc_oPg2.cnt_4c_Rom.txt_4c_DCodTransp.Value = ""
            IF PEMSTATUS(loc_oPg2, "chk_4c_Correios", 5)
                loc_oPg2.chk_4c_Correios.Value = 0
            ENDIF
            THIS.this_oBusinessObject.this_cCodTransp = ""
            RETURN
        ENDIF
        loc_cResultado = THIS.this_oBusinessObject.BuscarTransportadora(loc_cCod)
        loc_cRazao     = GETWORDNUM(loc_cResultado, 1, CHR(9))
        loc_cIdT       = UPPER(ALLTRIM(GETWORDNUM(loc_cResultado, 2, CHR(9))))

        IF EMPTY(loc_cRazao)
            MsgAviso("Transportadora n" + CHR(227) + "o encontrada.", "Transportadora")
            loc_oPg2.cnt_4c_Rom.txt_4c_CodTransp.Value  = ""
            loc_oPg2.cnt_4c_Rom.txt_4c_DCodTransp.Value = ""
            IF PEMSTATUS(loc_oPg2, "chk_4c_Correios", 5)
                loc_oPg2.chk_4c_Correios.Value = 0
            ENDIF
            THIS.this_oBusinessObject.this_cCodTransp = ""
        ELSE
            loc_oPg2.cnt_4c_Rom.txt_4c_DCodTransp.Value = loc_cRazao
            IF PEMSTATUS(loc_oPg2, "chk_4c_Correios", 5)
                loc_oPg2.chk_4c_Correios.Value = IIF(INLIST(loc_cIdT, "192B31E", "15F2739"), 1, 0)
            ENDIF
            THIS.this_oBusinessObject.this_cCodTransp = loc_cCod
        ENDIF
    ENDPROC

    PROCEDURE ValidarContas()
        LOCAL loc_cCod, loc_cResultado, loc_cRClis, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF !PEMSTATUS(loc_oPg2, "cnt_4c_Rom", 5)
            RETURN
        ENDIF
        IF !PEMSTATUS(loc_oPg2.cnt_4c_Rom, "txt_4c_Contas", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg2.cnt_4c_Rom.txt_4c_Contas.Value)
        IF EMPTY(loc_cCod)
            loc_oPg2.cnt_4c_Rom.txt_4c_DContas.Value = ""
            THIS.this_oBusinessObject.this_cContas = ""
            RETURN
        ENDIF
        loc_cResultado = THIS.this_oBusinessObject.BuscarCliente(loc_cCod)
        loc_cRClis     = GETWORDNUM(loc_cResultado, 1, CHR(9))

        IF EMPTY(loc_cRClis)
            MsgAviso("Cliente n" + CHR(227) + "o encontrado.", "Cliente")
            loc_oPg2.cnt_4c_Rom.txt_4c_Contas.Value  = ""
            loc_oPg2.cnt_4c_Rom.txt_4c_DContas.Value = ""
            THIS.this_oBusinessObject.this_cContas = ""
        ELSE
            loc_oPg2.cnt_4c_Rom.txt_4c_DContas.Value = loc_cRClis
            THIS.this_oBusinessObject.this_cContas = loc_cCod
        ENDIF
    ENDPROC

    PROCEDURE DataIniLostFocus()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF PEMSTATUS(loc_oPg1, "cnt_4c_Periodo", 5)
            WITH loc_oPg1.cnt_4c_Periodo
                IF PEMSTATUS(.Self, "txt_4c_DataIni", 5) AND PEMSTATUS(.Self, "txt_4c_DataFim", 5)
                    IF .txt_4c_DataIni.Value > .txt_4c_DataFim.Value
                        .txt_4c_DataFim.Value = .txt_4c_DataIni.Value
                    ENDIF
                ENDIF
            ENDWITH
        ENDIF
    ENDPROC

    PROCEDURE DataFimLostFocus()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF PEMSTATUS(loc_oPg1, "cnt_4c_Periodo", 5)
            WITH loc_oPg1.cnt_4c_Periodo
                IF PEMSTATUS(.Self, "txt_4c_DataIni", 5) AND PEMSTATUS(.Self, "txt_4c_DataFim", 5)
                    IF .txt_4c_DataFim.Value < .txt_4c_DataIni.Value
                        .txt_4c_DataIni.Value = .txt_4c_DataFim.Value
                    ENDIF
                ENDIF
            ENDWITH
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    PROCEDURE DatasLostFocus()
        *-- Nenhuma acao adicional necessaria
    ENDPROC

    PROCEDURE ValorLostFocus()
        *-- Nenhuma acao adicional necessaria
    ENDPROC

    *==========================================================================
    * GridAfterRowColChange - Grid Lista
    *==========================================================================
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        *-- Selecao visual apenas
    ENDPROC

    *==========================================================================
    * GridChavesAfterRowColChange - Grid de Chaves
    *==========================================================================
    PROCEDURE GridChavesAfterRowColChange(par_nColIndex)
        *-- Validacao de chave ocorre no LostFocus/Valid do controle interno
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza ao fechar
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_DadosTemp")
            USE IN cursor_4c_DadosTemp
        ENDIF
        IF USED("cursor_4c_Chaves")
            USE IN cursor_4c_Chaves
        ENDIF
        IF USED("cursor_4c_ChavesTemp")
            USE IN cursor_4c_ChavesTemp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
