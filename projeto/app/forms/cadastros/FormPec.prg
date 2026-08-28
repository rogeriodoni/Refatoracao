*==============================================================================
* FormPec.prg - Formulario de Cadastro de Posicao Empresarial
* Herda de: FormBase
* Entidade: Posicao Empresarial
* Tabelas : SigCdPec (mestre) + SigCdPeI (detalhe)
* Task    : task497
*==============================================================================

DEFINE CLASS FormPec AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY - do SCX original Width=1000, Height=600)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Posicao Empresarial"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Business Object e estado interno
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cPkChaveAtual   = ""

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.Init:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado, loc_oCab
        loc_lResultado = .F.

        TRY
            THIS.Caption = "Cadastro de Posi" + CHR(231) + CHR(227) + "o Empresarial"

            THIS.this_oBusinessObject = CREATEOBJECT("PecBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar PecBO!" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                THIS.CriarCursoresAuxiliares()
                THIS.this_oBusinessObject.CarregarGrupos()

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propagar caption para labels de titulo da Page1
                loc_oCab = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
                IF VARTYPE(loc_oCab) = "O"
                    IF VARTYPE(loc_oCab.lbl_4c_Sombra) = "O"
                        loc_oCab.lbl_4c_Sombra.Caption = THIS.Caption
                    ENDIF
                    IF VARTYPE(loc_oCab.lbl_4c_Titulo) = "O"
                        loc_oCab.lbl_4c_Titulo.Caption = THIS.Caption
                    ENDIF
                ENDIF

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.InicializarForm:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria pgf_4c_Paginas com Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Page1.Caption = "Lista"
            .Page2.Caption = "Dados"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: Cabecalho + botoes CRUD + Grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro com titulo (cntSombra do legado - Top=2+29=31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container botoes CRUD (canonico: Left=542, 5 botoes de 75px c/ gap de 5px)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Container Saida canonico (CLAUDE.md regra #10: Left=917, Width=90, cmd Width=75)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 917
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Grid de lista (Top=88+29=117, Width=889 nao sobrepoe cnt_4c_Saida em Left=917)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 3
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 889
            .Height             = 450
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .ReadOnly           = .T.
            .SetAll("Resizable", .F., "Column")
            .SetAll("Movable",   .F., "Column")
            .Column1.Width = 500
            .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column1.Header1.Alignment = 0
            .Column2.Width = 100
            .Column2.Header1.Caption = "Empresa"
            .Column2.Header1.Alignment = 0
            .Column3.Width = 0
            .Column3.Header1.Caption = "PK"
            .Column3.Header1.Alignment = 0
            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GridListaAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: campos + grids
    * Layout: area superior (relatorio/empresa + botoes), area inferior (2 grids)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCntAcao, loc_oCntCompo
        LOCAL loc_oGrdGrupos, loc_oGrdDest, loc_oCol1, loc_oCol5, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Container botoes Confirmar/Cancelar (Grupo_Salva orig Left=839,Top=7+29=36)
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            loc_oCntAcao = loc_oPagina.cnt_4c_BotoesAcao
            WITH loc_oCntAcao
                .Top         = 36
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            loc_oCntAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH loc_oCntAcao.cmd_4c_Confirmar
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            loc_oCntAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oCntAcao.cmd_4c_Cancelar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            BINDEVENT(loc_oCntAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oCntAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            *-- Container Inserir/Excluir item da grade (cmdgCompo orig Left=689, Top=7+29=36)
            loc_oPagina.AddObject("cnt_4c_CmdCompo", "Container")
            loc_oCntCompo = loc_oPagina.cnt_4c_CmdCompo
            WITH loc_oCntCompo
                .Top         = 36
                .Left        = 676
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            loc_oCntCompo.AddObject("cmd_4c_InserirItem", "CommandButton")
            WITH loc_oCntCompo.cmd_4c_InserirItem
                .Caption         = "Inserir Item"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            loc_oCntCompo.AddObject("cmd_4c_ExcluirItem", "CommandButton")
            WITH loc_oCntCompo.cmd_4c_ExcluirItem
                .Caption         = "Excluir Item"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            BINDEVENT(loc_oCntCompo.cmd_4c_InserirItem, "Click", THIS, "CmdGrupoInserirClick")
            BINDEVENT(loc_oCntCompo.cmd_4c_ExcluirItem, "Click", THIS, "CmdGrupoExcluirClick")

            *-- Shape2: retangulo decorativo em torno dos campos Relatorio/Empresa
            *-- (orig Top=13+29=42, Left=8, Width=663, Height=75)
            loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
            WITH loc_oPagina.shp_4c_Shape2
                .Top           = 42
                .Left          = 8
                .Width         = 663
                .Height        = 75
                .BackStyle     = 0
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            *-- Label "Relatorio:" (orig Top=31+29=60, Left=18)
            loc_oPagina.AddObject("lbl_4c_Relatorio", "Label")
            WITH loc_oPagina.lbl_4c_Relatorio
                .Caption   = "Relat" + CHR(243) + "rio : "
                .Top       = 56
                .Left      = 18
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox txt_4c_Relatorio: campo descs
            *-- (orig Top=26+29=55, Left=74, Width=290, Height=23)
            loc_oPagina.AddObject("txt_4c_Relatorio", "TextBox")
            WITH loc_oPagina.txt_4c_Relatorio
                .Top           = 55
                .Left          = 80
                .Width         = 380
                .Height        = 23
                .SpecialEffect = 1
                .MaxLength     = 40
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH

            *-- Label "Empresa:" (orig Top=58+29=87, Left=20)
            loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
            WITH loc_oPagina.lbl_4c_Empresa
                .Caption   = "Empresa : "
                .Top       = 82
                .Left      = 20
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox txt_4c_Empresa: campo emps CHAR(3)
            *-- (orig Top=50+29=79, Left=74, Width=31)
            loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
            WITH loc_oPagina.txt_4c_Empresa
                .Top           = 79
                .Left          = 80
                .Width         = 60
                .Height        = 23
                .SpecialEffect = 1
                .MaxLength     = 3
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "ValidarEmpresa")

            *-- Botoes Mover Cima/Baixo (Up/Down) para reordenar itens
            *-- (orig FwbtnpSobe Top=176+29=205, Left=950)
            loc_oPagina.AddObject("cmd_4c_MoverCima", "CommandButton")
            WITH loc_oPagina.cmd_4c_MoverCima
                .Caption       = ""
                .Picture       = gc_4c_CaminhoIcones + "cadastro_seta_cima_20.jpg"
                .Top           = 205
                .Left          = 950
                .Width         = 40
                .Height        = 40
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_MoverCima, "Click", THIS, "BtnMoverCimaClick")

            *-- (orig FwbtnpDesce Top=217+29=246, Left=950)
            loc_oPagina.AddObject("cmd_4c_MoverBaixo", "CommandButton")
            WITH loc_oPagina.cmd_4c_MoverBaixo
                .Caption       = ""
                .Picture       = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
                .Top           = 246
                .Left          = 950
                .Width         = 40
                .Height        = 40
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_MoverBaixo, "Click", THIS, "BtnMoverBaixoClick")

            *-- Shape1: retangulo em torno da area dos grids
            *-- (orig Top=126+29=155, Left=1, Width=994, Height=470)
            loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPagina.shp_4c_Shape1
                .Top           = 155
                .Left          = 1
                .Width         = 994
                .Height        = 470
                .BackStyle     = 0
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            *-- Botao CmdExpandir: expande grupo selecionado em grdGrupos -> grdDestinos
            *-- (orig Top=128+29=157, Left=3, Width=77, Height=25)
            loc_oPagina.AddObject("cmd_4c_Expandir", "CommandButton")
            WITH loc_oPagina.cmd_4c_Expandir
                .Caption       = "Expandir"
                .Top           = 157
                .Left          = 3
                .Width         = 77
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cmd_4c_Expandir, "Click", THIS, "CmdExpandirClick")

            *-- Label "Grupo:" acima da caixa de pesquisa de grupos
            loc_oPagina.AddObject("lbl_4c_ProcGrupo", "Label")
            WITH loc_oPagina.lbl_4c_ProcGrupo
                .Caption   = "Grupo:"
                .Top       = 160
                .Left      = 85
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox pesquisa por grupo (filtra grdDestinos por Descrs do grupo)
            *-- (orig Txt_Procura_Grupo Top=129+29=158, Left=81, Width=256)
            loc_oPagina.AddObject("txt_4c_ProcuraGrupo", "TextBox")
            WITH loc_oPagina.txt_4c_ProcuraGrupo
                .Top           = 158
                .Left          = 130
                .Width         = 218
                .Height        = 21
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 9
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.txt_4c_ProcuraGrupo, "InteractiveChange", THIS, "TxtProcuraGrupoInteractiveChange")
            BINDEVENT(loc_oPagina.txt_4c_ProcuraGrupo, "KeyPress",          THIS, "TxtProcuraGrupoLostFocus")

            *-- Label "Conta:" acima da caixa de pesquisa de contas
            loc_oPagina.AddObject("lbl_4c_ProcConta", "Label")
            WITH loc_oPagina.lbl_4c_ProcConta
                .Caption   = "Conta:"
                .Top       = 160
                .Left      = 364
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox pesquisa por conta (filtra grdDestinos por DescontaG)
            *-- (orig Txt_Procura_Conta Top=129+29=158, Left=456, Width=256)
            loc_oPagina.AddObject("txt_4c_ProcuraConta", "TextBox")
            WITH loc_oPagina.txt_4c_ProcuraConta
                .Top           = 158
                .Left          = 405
                .Width         = 218
                .Height        = 21
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 9
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.txt_4c_ProcuraConta, "InteractiveChange", THIS, "TxtProcuraContaInteractiveChange")
            BINDEVENT(loc_oPagina.txt_4c_ProcuraConta, "KeyPress",          THIS, "TxtProcuraContaLostFocus")

            *-- grdGrupos: lista de grupos (esquerda)
            *-- (orig Top=152+29=181, Left=4, Width=353, Height=443)
            loc_oPagina.AddObject("grd_4c_Grupos", "Grid")
            loc_oGrdGrupos = loc_oPagina.grd_4c_Grupos
            WITH loc_oGrdGrupos
                .Top                = 181
                .Left               = 4
                .Width              = 353
                .Height             = 443
                .ColumnCount        = 2
                .FontName           = "Tahoma"
                .FontSize           = 8
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .DeleteMark         = .F.
                .HeaderHeight       = 24
                .RecordMark         = .F.
                .RowHeight          = 21
                .ScrollBars         = 2
                .ForeColor          = RGB(0, 0, 0)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(252, 255, 191)
                .HighlightForeColor = RGB(0, 0, 0)
                .HighlightStyle     = 2
                .AllowAutoColumnFit = 0
                .ReadOnly           = .T.
                .Visible            = .T.
            ENDWITH

            WITH loc_oGrdGrupos.Column1
                .Width                = 75
                .Alignment            = 0
                .Header1.Caption      = "Grupo"
                .Header1.Alignment    = 2
                .Resizable            = .F.
                .Movable              = .F.
                .Enabled              = .F.
                .ForeColor            = RGB(0, 0, 0)
                .ControlSource        = "cursor_4c_Grupos.Codigos"
            ENDWITH

            WITH loc_oGrdGrupos.Column2
                .Width             = 256
                .Alignment         = 0
                .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o Grupo"
                .Header1.Alignment = 2
                .ForeColor         = RGB(0, 0, 0)
                .ControlSource     = "cursor_4c_Grupos.Descrs"
            ENDWITH

            IF USED("cursor_4c_Grupos")
                loc_oGrdGrupos.ColumnCount = 3
                loc_oGrdGrupos.RecordSource = "cursor_4c_Grupos"
            ENDIF

            *-- grdDestinos: lista de destinos/contas (direita)
            *-- (orig Top=152+29=181, Left=359, Width=589, Height=443)
            loc_oPagina.AddObject("grd_4c_Destinos", "Grid")
            loc_oGrdDest = loc_oPagina.grd_4c_Destinos
            WITH loc_oGrdDest
                .Top                = 181
                .Left               = 359
                .Width              = 585
                .Height             = 443
                .ColumnCount        = 5
                .FontName           = "Tahoma"
                .FontSize           = 8
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .DeleteMark         = .F.
                .HeaderHeight       = 24
                .RecordMark         = .F.
                .RowHeight          = 21
                .ScrollBars         = 2
                .ForeColor          = RGB(0, 0, 0)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(252, 255, 191)
                .HighlightForeColor = RGB(0, 0, 0)
                .HighlightStyle     = 2
                .AllowAutoColumnFit = 0
                .ReadOnly           = .F.
                .Visible            = .T.
            ENDWITH

            *-- Column1: CheckBox Marcas (selecao)
            loc_oCol1 = loc_oGrdDest.Column1
            WITH loc_oCol1
                .Width          = 20
                .Alignment      = 0
                .Header1.Caption = ""
                .Resizable      = .F.
                .Movable        = .F.
                .Enabled        = .T.
                .Sparse         = .F.
                .ForeColor      = RGB(0, 0, 0)
                .ControlSource  = "csDestinos.Marcas"
            ENDWITH
            loc_oCol1.AddObject("Check1", "CheckBox")
            WITH loc_oCol1.Check1
                .Alignment     = 0
                .Centered      = .T.
                .Caption       = ""
                .ControlSource = "csDestinos.Marcas"
                .Enabled       = .T.
                .ReadOnly      = .F.
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
                .Top           = 9
                .Left          = 2
                .Height        = 17
                .Width         = 22
            ENDWITH
            BINDEVENT(loc_oCol1.Check1, "InteractiveChange", THIS, "CheckMarcasInteractiveChange")

            *-- Column2: ContaG (codigo da conta)
            WITH loc_oGrdDest.Column2
                .Width          = 75
                .Alignment      = 0
                .Header1.Caption = "Conta"
                .Header1.Alignment = 2
                .ForeColor      = RGB(0, 0, 0)
                .BackColor      = RGB(255, 255, 255)
                .ControlSource  = "csDestinos.ContaG"
            ENDWITH

            *-- Column3: DescontaG (descricao da conta)
            WITH loc_oGrdDest.Column3
                .Width          = 254
                .Alignment      = 0
                .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Conta"
                .Header1.Alignment = 2
                .ForeColor      = RGB(0, 0, 0)
                .BackColor      = RGB(255, 255, 255)
                .ControlSource  = "csDestinos.DescontaG"
            ENDWITH

            *-- Column4: Codigos (codigo auxiliar, auto-preenchido ao marcar checkbox)
            WITH loc_oGrdDest.Column4
                .Width          = 115
                .Alignment      = 0
                .Header1.Caption = "Codigo"
                .Header1.Alignment = 2
                .ForeColor      = RGB(0, 0, 0)
                .BackColor      = RGB(255, 255, 255)
                .ControlSource  = "csDestinos.Codigos"
            ENDWITH

            *-- Column5: Opers (operacao: + credito / - debito) via ComboBox
            loc_oCol5 = loc_oGrdDest.Column5
            WITH loc_oCol5
                .Width          = 100
                .Alignment      = 0
                .Header1.Caption = "( + / - )"
                .Header1.Alignment = 2
                .Header1.FontBold = .T.
                .Movable        = .F.
                .Sparse         = .F.
                .ForeColor      = RGB(0, 0, 0)
                .ControlSource  = "csDestinos.Opers"
            ENDWITH
            loc_oCol5.AddObject("Combo1", "ComboBox")
            WITH loc_oCol5.Combo1
                .RowSourceType  = 2
                .RowSource      = "Creditar,+,Debitar,-"
                .BoundColumn    = 2
                .ColumnCount    = 2
                .ColumnWidths   = "70,10"
                .BoundTo        = .T.
                .Style          = 2
                .DisplayCount   = 2
                .ControlSource  = "csDestinos.Opers"
                .FontName       = "Tahoma"
                .ForeColor      = RGB(0, 0, 0)
                .Visible        = .T.
            ENDWITH

            IF USED("csDestinos")
                loc_oGrdDest.RecordSource = "csDestinos"
            ENDIF

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.ConfigurarPaginaDados: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_oErro
        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                    SELECT cursor_4c_Dados
                    GO TOP
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.descs"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.pkchaves"
                    THIS.this_cPkChaveAtual = ALLTRIM(cursor_4c_Dados.pkchaves)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (lista=1) e Page2 (dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva registro (INCLUIR ou ALTERAR)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPag2, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            *-- Validar campos obrigatorios
            IF EMPTY(ALLTRIM(loc_oPag2.txt_4c_Relatorio.Value))
                MsgAviso("O Nome do Relat" + CHR(243) + "rio deve ser preenchido!", "Validar")
                loc_oPag2.txt_4c_Relatorio.SetFocus()
                RETURN
            ENDIF

            IF EMPTY(ALLTRIM(loc_oPag2.txt_4c_Empresa.Value))
                MsgAviso("A Empresa deve ser preenchida!", "Validar")
                loc_oPag2.txt_4c_Empresa.SetFocus()
                RETURN
            ENDIF

            THIS.FormParaBO()

            IF THIS.this_cModoAtual = "INCLUIR"
                loc_lSucesso = THIS.this_oBusinessObject.Salvar()
                IF loc_lSucesso
                    MsgInfo("Registro inclu" + CHR(237) + "do com sucesso!", "Incluir")
                ENDIF
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.Salvar()
                IF loc_lSucesso
                    MsgInfo("Registro atualizado com sucesso!", "Alterar")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.BtnSalvarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF loc_lSucesso
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * GridListaAfterRowColChange - Atualiza this_cPkChaveAtual ao mover no grid
    *==========================================================================
    PROCEDURE GridListaAfterRowColChange(par_nColIndex)
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            THIS.this_cPkChaveAtual = ALLTRIM(cursor_4c_Dados.pkchaves)
        ELSE
            THIS.this_cPkChaveAtual = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara novo registro e navega para Page2
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            IF USED("csDestinos")
                ZAP IN csDestinos
            ENDIF
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.BtnIncluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro na lista.", "Visualizar")
                RETURN
            ENDIF
            SELECT cursor_4c_Dados
            THIS.this_cPkChaveAtual = ALLTRIM(cursor_4c_Dados.pkchaves)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cPkChaveAtual)
                THIS.this_oBusinessObject.CarregarItensParaDestinos(THIS.this_cPkChaveAtual)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.BtnVisualizarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro na lista.", "Alterar")
                RETURN
            ENDIF
            SELECT cursor_4c_Dados
            THIS.this_cPkChaveAtual = ALLTRIM(cursor_4c_Dados.pkchaves)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cPkChaveAtual)
                THIS.this_oBusinessObject.EditarRegistro()
                *-- Sincroniza SigCdPeI com novos grupos/contas antes de carregar
                THIS.this_oBusinessObject.AtualizarGrupos(THIS.this_cPkChaveAtual)
                THIS.this_oBusinessObject.CarregarItensParaDestinos(THIS.this_cPkChaveAtual)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.BtnAlterarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cDescricao
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro na lista.", "Excluir")
                RETURN
            ENDIF
            SELECT cursor_4c_Dados
            THIS.this_cPkChaveAtual = ALLTRIM(cursor_4c_Dados.pkchaves)
            loc_cDescricao = ALLTRIM(cursor_4c_Dados.descs)

            IF MsgConfirma("Confirma exclus" + CHR(227) + "o de:" + CHR(13) + ;
                           loc_cDescricao + "?", "Excluir")
                IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cPkChaveAtual)
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.BtnExcluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para pesquisar SigCdPec
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca
        loc_oBusca = .NULL.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPec", "cursor_4c_BuscaPec", "pkchaves", "", ;
                "Buscar Posi" + CHR(231) + CHR(227) + "o Empresarial")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("emps",  "", "Empresa")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPec")
                    SELECT cursor_4c_BuscaPec
                    THIS.this_cPkChaveAtual = ALLTRIM(cursor_4c_BuscaPec.pkchaves)
                    THIS.CarregarLista()
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(pkchaves) = THIS.this_cPkChaveAtual
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaPec")
            USE IN cursor_4c_BuscaPec
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag2, loc_oErro
        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_oPag2.txt_4c_Relatorio.Value = ""
            loc_oPag2.txt_4c_Empresa.Value   = ""
            loc_oPag2.txt_4c_ProcuraGrupo.Value = ""
            loc_oPag2.txt_4c_ProcuraConta.Value  = ""
            IF USED("csDestinos")
                SELECT csDestinos
                SET ORDER TO Ordems
                GO TOP
                loc_oPag2.grd_4c_Destinos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.LimparCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag2, loc_oErro
        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_oPag2.txt_4c_Relatorio.ReadOnly  = !par_lHabilitar
            loc_oPag2.txt_4c_Empresa.ReadOnly     = !par_lHabilitar
            loc_oPag2.cnt_4c_CmdCompo.Enabled    = par_lHabilitar
            loc_oPag2.cmd_4c_Expandir.Enabled    = par_lHabilitar
            loc_oPag2.grd_4c_Destinos.ReadOnly   = !par_lHabilitar
            loc_oPag2.grd_4c_Destinos.Column5.Combo1.Enabled = par_lHabilitar
            loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.HabilitarCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos do Form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag2, loc_oErro
        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            THIS.this_oBusinessObject.this_cDescs = ALLTRIM(loc_oPag2.txt_4c_Relatorio.Value)
            THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(loc_oPag2.txt_4c_Empresa.Value)
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.FormParaBO: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag2, loc_oGrdGrupos, loc_oGrdDest, loc_oErro
        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_oPag2.txt_4c_Relatorio.Value = THIS.this_oBusinessObject.this_cDescs
            loc_oPag2.txt_4c_Empresa.Value   = THIS.this_oBusinessObject.this_cEmps

            loc_oGrdGrupos = loc_oPag2.grd_4c_Grupos
            IF USED("cursor_4c_Grupos")
                loc_oGrdGrupos.ColumnCount = 3
                loc_oGrdGrupos.RecordSource = "cursor_4c_Grupos"
                loc_oGrdGrupos.Refresh()
            ENDIF

            loc_oGrdDest = loc_oPag2.grd_4c_Destinos
            IF USED("csDestinos")
                SELECT csDestinos
                SET ORDER TO Ordems
                GO TOP
                loc_oGrdDest.RecordSource = "csDestinos"
                loc_oGrdDest.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.BOParaForm: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarEmpresa - Lookup de empresa via FormBuscaAuxiliar
    *==========================================================================
    PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag2, loc_cEmps, loc_oBusca, loc_oErro, loc_lValido
        loc_lValido = .T.
        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_cEmps = ALLTRIM(loc_oPag2.txt_4c_Empresa.Value)

            IF !EMPTY(loc_cEmps)
                IF USED("cursor_4c_ValidaEmp")
                    USE IN cursor_4c_ValidaEmp
                ENDIF
                IF SQLEXEC(gnConnHandle, "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + ;
                        EscaparSQL(loc_cEmps), "cursor_4c_ValidaEmp") > 0
                    IF RECCOUNT("cursor_4c_ValidaEmp") = 0
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                            "SigCdEmp", "cursor_4c_EmpBusca", "Cemps", "", "Buscar Empresa")
                        IF VARTYPE(loc_oBusca) = "O"
                            loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_EmpBusca")
                                SELECT cursor_4c_EmpBusca
                                loc_oPag2.txt_4c_Empresa.Value = ALLTRIM(cursor_4c_EmpBusca.Cemps)
                                USE IN cursor_4c_EmpBusca
                            ELSE
                                loc_oPag2.txt_4c_Empresa.Value = ""
                                loc_lValido = .F.
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_ValidaEmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.ValidarEmpresa: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * CriarCursoresAuxiliares - Cria cursor csDestinos para a grade de destinos
    *==========================================================================
    PROTECTED PROCEDURE CriarCursoresAuxiliares()
        LOCAL loc_oErro
        TRY
            IF USED("csDestinos")
                USE IN csDestinos
            ENDIF
            CREATE CURSOR csDestinos (PkChaves c(20), fkChaves c(20), Marcas n(1), ;
                Grupos c(10), Descrs c(50), ContaG c(10), DescontaG c(50), ;
                Codigos c(50), Opers c(1), Ordems n(4))
            INDEX ON fkChaves  TAG fkChaves
            INDEX ON Descrs    TAG Descrs
            INDEX ON DescontaG TAG DescontaG
            INDEX ON ContaG    TAG ContaG
            INDEX ON Ordems    TAG Ordems
            SET ORDER TO Ordems
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.CriarCursoresAuxiliares: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExpandirClick - Expande grupo selecionado em grdGrupos para grdDestinos
    *==========================================================================
    PROCEDURE CmdExpandirClick()
        LOCAL loc_cGrupo, loc_cContas, loc_cDescConta, loc_cGrupoCod
        LOCAL loc_nProx, loc_oErro

        TRY
            IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
                MsgAviso("Selecione um Grupo na lista.", "Expandir")
                RETURN
            ENDIF

            SELECT cursor_4c_Grupos
            loc_cGrupo = ALLTRIM(cursor_4c_Grupos.Codigos)

            IF EMPTY(loc_cGrupo)
                MsgAviso("Selecione um Grupo na lista.", "Expandir")
                RETURN
            ENDIF

            IF THIS.this_oBusinessObject.BuscarExpansaoGrupo(loc_cGrupo)
                IF USED("cursor_4c_ExpGrupo") AND RECCOUNT("cursor_4c_ExpGrupo") > 0
                    SELECT cursor_4c_ExpGrupo
                    GO TOP
                    SCAN
                        loc_cContas    = ALLTRIM(cursor_4c_ExpGrupo.iclis)
                        loc_cDescConta = ALLTRIM(cursor_4c_ExpGrupo.rclis)
                        loc_cGrupoCod  = ALLTRIM(cursor_4c_ExpGrupo.codigos)

                        SELECT csDestinos
                        LOCATE FOR UPPER(ALLTRIM(ContaG)) = UPPER(loc_cContas)

                        IF !FOUND()
                            SELECT MAX(Ordems) AS nProx FROM csDestinos ;
                                INTO CURSOR crsProxOrd READWRITE
                            loc_nProx = NVL(nProx, 0) + 1
                            IF USED("crsProxOrd")
                                USE IN crsProxOrd
                            ENDIF

                            INSERT INTO csDestinos ;
                                (fkChaves, Marcas, Grupos, Codigos, Opers, Ordems, ContaG, DescontaG) ;
                                VALUES ('', 0, loc_cGrupoCod, '', '+', loc_nProx, ;
                                        loc_cContas, loc_cDescConta)
                        ENDIF

                        SELECT cursor_4c_ExpGrupo
                    ENDSCAN

                    SELECT csDestinos
                    SET ORDER TO Ordems
                    GO TOP

                    THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()

                    IF USED("cursor_4c_ExpGrupo")
                        USE IN cursor_4c_ExpGrupo
                    ENDIF
                ELSE
                    MsgAviso("Nenhuma conta encontrada para o grupo selecionado.", "Expandir")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.CmdExpandirClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdGrupoInserirClick - Insere item em branco na csDestinos
    *==========================================================================
    PROCEDURE CmdGrupoInserirClick()
        LOCAL loc_nProx, loc_oErro
        TRY
            IF USED("csDestinos")
                SELECT MAX(Ordems) AS nProx FROM csDestinos INTO CURSOR crsProxOrd READWRITE
                loc_nProx = NVL(nProx, 0) + 1
                IF USED("crsProxOrd")
                    USE IN crsProxOrd
                ENDIF
                INSERT INTO csDestinos (fkChaves, Marcas, Grupos, Codigos, Opers, Ordems) ;
                    VALUES (SPACE(20), 0, SPACE(10), SPACE(15), '+', loc_nProx)
                SELECT csDestinos
                SET ORDER TO Ordems
                GO BOTTOM
                THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.CmdGrupoInserirClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdGrupoExcluirClick - Remove item corrente da csDestinos
    *==========================================================================
    PROCEDURE CmdGrupoExcluirClick()
        LOCAL loc_oErro
        TRY
            IF USED("csDestinos") AND !EOF("csDestinos")
                IF MsgConfirma("Deseja excluir esta opera" + CHR(231) + CHR(227) + "o?", "Excluir Item")
                    SELECT csDestinos
                    DELETE
                    PACK
                    SET ORDER TO Ordems
                    GO TOP
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.CmdGrupoExcluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnMoverCimaClick - Move item atual uma posicao acima na ordem
    *==========================================================================
    PROCEDURE BtnMoverCimaClick()
        LOCAL loc_nOrdAtual, loc_nOrdAnterior, loc_oErro
        TRY
            IF !USED("csDestinos") OR EOF("csDestinos") OR BOF("csDestinos")
                RETURN
            ENDIF
            SELECT csDestinos
            SET ORDER TO Ordems
            loc_nOrdAtual = csDestinos.Ordems
            SKIP -1
            IF !BOF()
                loc_nOrdAnterior = csDestinos.Ordems
                REPLACE Ordems WITH loc_nOrdAtual
                SKIP 1
                REPLACE Ordems WITH loc_nOrdAnterior
                SET ORDER TO Ordems
                SEEK loc_nOrdAnterior
                THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.BtnMoverCimaClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnMoverBaixoClick - Move item atual uma posicao abaixo na ordem
    *==========================================================================
    PROCEDURE BtnMoverBaixoClick()
        LOCAL loc_nOrdAtual, loc_nOrdProx, loc_oErro
        TRY
            IF !USED("csDestinos") OR EOF("csDestinos")
                RETURN
            ENDIF
            SELECT csDestinos
            SET ORDER TO Ordems
            loc_nOrdAtual = csDestinos.Ordems
            SKIP 1
            IF !EOF()
                loc_nOrdProx = csDestinos.Ordems
                REPLACE Ordems WITH loc_nOrdAtual
                SKIP -1
                REPLACE Ordems WITH loc_nOrdProx
                SET ORDER TO Ordems
                SEEK loc_nOrdProx
                THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.BtnMoverBaixoClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtProcuraGrupoInteractiveChange - Filtra grdDestinos por descricao do grupo
    *==========================================================================
    PROCEDURE TxtProcuraGrupoInteractiveChange()
        LOCAL loc_cBusca, loc_cChave1, loc_cChave2, loc_oErro
        TRY
            IF USED("csDestinos")
                loc_cBusca = ALLTRIM(UPPER(THIS.pgf_4c_Paginas.Page2.txt_4c_ProcuraGrupo.Value))
                SELECT csDestinos
                SET ORDER TO Descrs
                IF !EMPTY(loc_cBusca)
                    SEEK loc_cBusca
                    loc_cChave1 = ALLTRIM(Descrs)
                    loc_cChave2 = loc_cBusca + "z"
                    SET KEY TO RANGE loc_cChave1, loc_cChave2
                ELSE
                    SET KEY TO
                    SET ORDER TO Ordems
                    GO TOP
                ENDIF
                THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.TxtProcuraGrupoInteractiveChange: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtProcuraGrupoLostFocus - Remove filtro ao sair do campo de pesquisa
    *==========================================================================
    PROCEDURE TxtProcuraGrupoLostFocus()
        TRY
            IF USED("csDestinos")
                SELECT csDestinos
                SET KEY TO
                SET ORDER TO Ordems
                GO TOP
                THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.TxtProcuraGrupoLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtProcuraContaInteractiveChange - Filtra grdDestinos por descricao da conta
    *==========================================================================
    PROCEDURE TxtProcuraContaInteractiveChange()
        LOCAL loc_cBusca, loc_cChave1, loc_cChave2, loc_oErro
        TRY
            IF USED("csDestinos")
                loc_cBusca = ALLTRIM(UPPER(THIS.pgf_4c_Paginas.Page2.txt_4c_ProcuraConta.Value))
                SELECT csDestinos
                SET ORDER TO DescontaG
                IF !EMPTY(loc_cBusca)
                    SEEK loc_cBusca
                    loc_cChave1 = ALLTRIM(DescontaG)
                    loc_cChave2 = loc_cBusca + "z"
                    SET KEY TO RANGE loc_cChave1, loc_cChave2
                ELSE
                    SET KEY TO
                    SET ORDER TO Ordems
                    GO TOP
                ENDIF
                THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.TxtProcuraContaInteractiveChange: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtProcuraContaLostFocus - Remove filtro ao sair do campo de pesquisa
    *==========================================================================
    PROCEDURE TxtProcuraContaLostFocus()
        TRY
            IF USED("csDestinos")
                SELECT csDestinos
                SET KEY TO
                SET ORDER TO Ordems
                GO TOP
                THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.TxtProcuraContaLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CheckMarcasInteractiveChange - Ao marcar checkbox preenche campo Codigos
    *==========================================================================
    PROCEDURE CheckMarcasInteractiveChange()
        LOCAL loc_oGrd, loc_oErro
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos
            IF USED("csDestinos") AND !EOF("csDestinos")
                SELECT csDestinos
                IF csDestinos.Marcas > 0
                    REPLACE Codigos WITH SUBSTR(csDestinos.DescontaG, 1, 50)
                ELSE
                    REPLACE Codigos WITH SPACE(50)
                ENDIF
                loc_oGrd.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPec.CheckMarcasInteractiveChange: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Fonte Tahoma 8 nas colunas (padrao framework)
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF

        IF USED("csDestinos")
            USE IN csDestinos
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
