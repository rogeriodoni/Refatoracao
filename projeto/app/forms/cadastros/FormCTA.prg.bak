*==============================================================================
* FormCTA.prg - Formulario de Cadastro de Contas (SigCdCli)
* Migrado de: SIGCDCTA.SCX (frmcadastro / clsconta 12 sub-paginas)
*==============================================================================

DEFINE CLASS FormCTA AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Contas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    DataSession = 2
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_nSubPagina      = 1
    this_cMensagemErro   = ""

    *===========================================================================
    * Init - APENAS DODEFAULT (FormBase chama InicializarForm)
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CTABO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar CTABO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormCTA.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormCTA:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormCTA.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame principal
    *===========================================================================
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

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Page1: grade + filtros + botoes CRUD
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (cntSombra legado Top=1 -> +29 = 30)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
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
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Botoes CRUD (Grupo_op Top=-1 -> +29 = 28; Left=543 canonico)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 385
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Incluir (Left=5)
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

        *-- Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir (Left=230)
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

        *-- Procurar/Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Procurar"
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

        *-- Container Saida (canonico: Left=917, Width=90)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container de Filtros (cntFiltros: Top=85+29=114, Left=30, W=599, H=49)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 114
            .Left        = 30
            .Width       = 599
            .Height      = 49
            .BackStyle   = 0
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        *-- Label Grupo de Contas
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_Label2
            .Caption   = "\<Grupo de Contas"
            .Top       = 4
            .Left      = 7
            .Width     = 95
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Grupo (codigo) - txt_4c_Grupo: Top=19, Left=7, Width=81
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Grupo
            .Top           = 19
            .Left          = 7
            .Width         = 81
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoFiltroKeyPress")

        *-- Descricao Grupo - txt_4c_DGrupo: Top=19, Left=91, Width=290
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DGrupo
            .Top           = 19
            .Left          = 91
            .Width         = 290
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DGrupo, "KeyPress", THIS, "TxtDGrupoFiltroKeyPress")

        *-- Label Alterados entre
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_Label3
            .Caption   = "Alterados entre"
            .Top       = 3
            .Left      = 402
            .Width     = 91
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- DtIni: Top=19, Left=402, Width=80
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni
            .Top           = 19
            .Left          = 402
            .Width         = 80
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE() - 365
            .InputMask     = "99/99/9999"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni, "KeyPress", THIS, "TxtDtIniKeyPress")

        *-- Label ate
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_Label4
            .Caption   = "at" + CHR(233)
            .Top       = 23
            .Left      = 486
            .Width     = 21
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- DtFim: Top=19, Left=512, Width=80
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtFim", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtFim
            .Top           = 19
            .Left          = 512
            .Width         = 80
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .InputMask     = "99/99/9999"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtFim, "KeyPress", THIS, "TxtDtFimKeyPress")

        *-- Grid de lista (Grade: Top=137+29=166, Left=30, Width=939, Height=454)
        *-- ColumnCount ANTES do WITH (VFP9 regra)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 5
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 166
            .Left               = 30
            .Width              = 939
            .Height             = 454
            .FontName           = "Courier New"
            .FontSize           = 9
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
            .GridLines          = 3
            .Visible            = .T.

            *-- Coluna 1: Codigo (IClis) Width=100
            .Column1.Width      = 100
            .Column1.Movable    = .F.
            .Column1.Resizable  = .F.
            .Column1.ReadOnly   = .T.
            .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2

            *-- Coluna 2: Nome (Rclis) Width=514
            .Column2.Width      = 514
            .Column2.ColumnOrder = 2
            .Column2.Movable    = .F.
            .Column2.Resizable  = .F.
            .Column2.ReadOnly   = .T.
            .Column2.Header1.Caption   = "Nome"
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2

            *-- Coluna 3: CPF/CNPJ (Cpfs) Width=150
            .Column3.Width      = 150
            .Column3.ColumnOrder = 3
            .Column3.Movable    = .F.
            .Column3.Resizable  = .F.
            .Column3.ReadOnly   = .T.
            .Column3.Header1.Caption   = "CPF / CNPJ"
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.Alignment = 2

            *-- Coluna 4: Ult.Compra (Ultcomps) Width=75
            .Column4.Width      = 75
            .Column4.Movable    = .F.
            .Column4.Resizable  = .F.
            .Column4.ReadOnly   = .T.
            .Column4.Header1.Caption   = CHR(218) + "lt.Compra"
            .Column4.Header1.FontName  = "Tahoma"
            .Column4.Header1.FontSize  = 8
            .Column4.Header1.Alignment = 2

            *-- Coluna 5: Alterado em (DtAlts) Width=75
            .Column5.Width      = 75
            .Column5.Movable    = .F.
            .Column5.Resizable  = .F.
            .Column5.ReadOnly   = .T.
            .Column5.Header1.Caption   = "Alterado em"
            .Column5.Header1.FontName  = "Tahoma"
            .Column5.Header1.FontSize  = 8
            .Column5.Header1.Alignment = 2
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2: nav + sub-paginas
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Botoes Salvar/Cancelar (Grupo_Salva: Top=-7+29=22, Left=842)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 22
            .Left        = 842
            .Width       = 163
            .Height      = 85
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 6
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 81
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- OptionGroup para navegar entre 12 sub-paginas
        *-- (fwSelPagina1 Top=3+29=32, Left=1, Width=817, Height=75)
        loc_oPagina.AddObject("obj_4c_NavPaginas", "OptionGroup")
        loc_oPagina.obj_4c_NavPaginas.ButtonCount = 12
        WITH loc_oPagina.obj_4c_NavPaginas
            .Top         = 32
            .Left        = 1
            .Width       = 817
            .Height      = 75
            .Value       = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 0
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Principal"
                .Top       = 0
                .Left      = 0
                .Width     = 65
                .Height    = 75
                .BackStyle = 0
                .Value     = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Comercial"
                .Top       = 0
                .Left      = 65
                .Width     = 65
                .Height    = 75
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Value     = 0
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Banc" + CHR(225) + "rios"
                .Top       = 0
                .Left      = 130
                .Width     = 65
                .Height    = 75
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Value     = 0
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Follow-up"
                .Top       = 0
                .Left      = 195
                .Width     = 65
                .Height    = 75
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Value     = 0
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "Cta Corrente"
                .Top       = 0
                .Left      = 260
                .Width     = 65
                .Height    = 75
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Value     = 0
            ENDWITH
            WITH .Buttons(6)
                .Caption   = "Fiscais"
                .Top       = 0
                .Left      = 325
                .Width     = 65
                .Height    = 75
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Value     = 0
            ENDWITH
            WITH .Buttons(7)
                .Caption   = "Complemento"
                .Top       = 0
                .Left      = 390
                .Width     = 65
                .Height    = 75
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Value     = 0
            ENDWITH
            WITH .Buttons(8)
                .Caption   = "Empresa"
                .Top       = 0
                .Left      = 455
                .Width     = 65
                .Height    = 75
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Value     = 0
            ENDWITH
            WITH .Buttons(9)
                .Caption   = "Cont" + CHR(225) + "beis"
                .Top       = 0
                .Left      = 520
                .Width     = 65
                .Height    = 75
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Value     = 0
            ENDWITH
            WITH .Buttons(10)
                .Caption   = "Cadastrais"
                .Top       = 0
                .Left      = 585
                .Width     = 65
                .Height    = 75
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Value     = 0
            ENDWITH
            WITH .Buttons(11)
                .Caption   = "Caracter" + CHR(237) + "sticas"
                .Top       = 0
                .Left      = 650
                .Width     = 65
                .Height    = 75
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Value     = 0
            ENDWITH
            WITH .Buttons(12)
                .Caption   = "Perfil"
                .Top       = 0
                .Left      = 715
                .Width     = 65
                .Height    = 75
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Value     = 0
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.obj_4c_NavPaginas, "Click", THIS, "NavPaginasClick")

        *-- Configurar pgframeDados (12 sub-paginas internas)
        THIS.ConfigurarPgpgframeDados(loc_oPagina)

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Mostrar apenas sub-pagina 1 inicialmente
        THIS.MostrarSubPagina(1)
    ENDPROC

    *===========================================================================
    * ConfigurarPgpgframeDados - Configura as 12 sub-paginas de dados internos
    * Equivalente ao pgframeDados do cntConta.clsconta legado (12 pages)
    * par_oPagina = THIS.pgf_4c_Paginas.Page2
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgframeDados(par_oPagina)
        THIS.ConfigurarSubPagina1(par_oPagina)
        THIS.ConfigurarSubPagina2(par_oPagina)
        THIS.ConfigurarSubPagina3(par_oPagina)
        THIS.ConfigurarSubPagina4(par_oPagina)
        THIS.ConfigurarSubPagina5(par_oPagina)
        THIS.ConfigurarSubPagina6(par_oPagina)
        THIS.ConfigurarSubPagina7(par_oPagina)
        THIS.ConfigurarSubPagina8(par_oPagina)
        THIS.ConfigurarSubPagina9(par_oPagina)
        THIS.ConfigurarSubPagina10(par_oPagina)
        THIS.ConfigurarSubPagina11(par_oPagina)
        THIS.ConfigurarSubPagina12(par_oPagina)
    ENDPROC

    *===========================================================================
    * Sub-pagina 1: Principal (identificacao, endere~o, telefone)
    * Baseado em pgframeDados1 do cntConta.clsconta
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarSubPagina1(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg1", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg1
        WITH loc_oCnt
            .Top         = 107
            .Left        = 0
            .Width       = 1000
            .Height      = 493
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Linha 1: Grupo + Codigo + InsMuns + Emissor
        loc_oCnt.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oCnt.lbl_4c_LblGrupo
            .Caption = "Grupo"
            .Top = 84
            .Left = 16
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Grupos", "TextBox")
        WITH loc_oCnt.txt_4c_Grupos
            .Top = 99
            .Left = 16
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Grupos, "KeyPress", THIS, "TxtGruposKeyPress")

        loc_oCnt.AddObject("lbl_4c_LblCodigo", "Label")
        WITH loc_oCnt.lbl_4c_LblCodigo
            .Caption = "C" + CHR(243) + "digo"
            .Top = 84
            .Left = 100
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_IClis", "TextBox")
        WITH loc_oCnt.txt_4c_IClis
            .Top = 99
            .Left = 100
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- InsMuns
        loc_oCnt.AddObject("lbl_4c_LblInsMuns", "Label")
        WITH loc_oCnt.lbl_4c_LblInsMuns
            .Caption = "Ins.Municipal"
            .Top = 84
            .Left = 184
            .Width = 100
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Inscmuns", "TextBox")
        WITH loc_oCnt.txt_4c_Inscmuns
            .Top = 99
            .Left = 184
            .Width = 140
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Situacao
        loc_oCnt.AddObject("lbl_4c_LblSituas", "Label")
        WITH loc_oCnt.lbl_4c_LblSituas
            .Caption = "Situa" + CHR(231) + CHR(227) + "o"
            .Top = 84
            .Left = 328
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Situas", "TextBox")
        WITH loc_oCnt.txt_4c_Situas
            .Top = 99
            .Left = 328
            .Width = 50
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- CPF/CNPJ (Cpfs)
        loc_oCnt.AddObject("lbl_4c_LblCpfs", "Label")
        WITH loc_oCnt.lbl_4c_LblCpfs
            .Caption = "CPF/CNPJ"
            .Top = 84
            .Left = 382
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cpfs", "TextBox")
        WITH loc_oCnt.txt_4c_Cpfs
            .Top = 99
            .Left = 382
            .Width = 145
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- RG (Rgs)
        loc_oCnt.AddObject("lbl_4c_LblRgs", "Label")
        WITH loc_oCnt.lbl_4c_LblRgs
            .Caption = "RG/IE"
            .Top = 84
            .Left = 531
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Rgs", "TextBox")
        WITH loc_oCnt.txt_4c_Rgs
            .Top = 99
            .Left = 531
            .Width = 140
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Conta Inativa (CHKINATIVA)
        loc_oCnt.AddObject("chk_4c_Inativas", "CheckBox")
        WITH loc_oCnt.chk_4c_Inativas
            .Caption = "Conta Inativa"
            .Top = 88
            .Left = 795
            .Height = 23
            .Width = 120
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH

        *-- Ultima Compra (GetUltCom Top=109, Left=898, W=88)
        loc_oCnt.AddObject("lbl_4c_LblUltcom", "Label")
        WITH loc_oCnt.lbl_4c_LblUltcom
            .Caption = CHR(218) + "lt.Compra"
            .Top = 94
            .Left = 898
            .Width = 88
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Ultcomps", "TextBox")
        WITH loc_oCnt.txt_4c_Ultcomps
            .Top = 109
            .Left = 898
            .Width = 88
            .Height = 23
            .FontName = "Tahoma"
            .FontBold = .T.
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = {}
            .Enabled = .F.
            .DisabledBackColor = RGB(253, 250, 185)
            .DisabledForeColor = RGB(36, 84, 155)
            .Visible = .T.
        ENDWITH

        *-- Data Validade (getDtVals Top=136, Left=898)
        loc_oCnt.AddObject("lbl_4c_LblDtvals", "Label")
        WITH loc_oCnt.lbl_4c_LblDtvals
            .Caption = "Dt.Val"
            .Top = 121
            .Left = 898
            .Width = 50
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Dtvals", "TextBox")
        WITH loc_oCnt.txt_4c_Dtvals
            .Top = 136
            .Left = 898
            .Width = 88
            .Height = 23
            .FontName = "Tahoma"
            .FontBold = .T.
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = {}
            .Visible = .T.
        ENDWITH

        *-- Nome (GetNome Top=138, Left=16, Width=368)
        loc_oCnt.AddObject("lbl_4c_LblNome", "Label")
        WITH loc_oCnt.lbl_4c_LblNome
            .Caption = "Nome / Raz" + CHR(227) + "o Social"
            .Top = 123
            .Left = 16
            .Width = 150
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Rclis", "TextBox")
        WITH loc_oCnt.txt_4c_Rclis
            .Top = 138
            .Left = 16
            .Width = 368
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Razao (GetRazao Top=138, Left=393, Width=368)
        loc_oCnt.AddObject("lbl_4c_LblRazaos", "Label")
        WITH loc_oCnt.lbl_4c_LblRazaos
            .Caption = "Raz" + CHR(227) + "o / Fantasia"
            .Top = 123
            .Left = 393
            .Width = 150
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Razaos", "TextBox")
        WITH loc_oCnt.txt_4c_Razaos
            .Top = 138
            .Left = 393
            .Width = 368
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Fun~ao/Cargo (GetCodFun Top=177, Left=16 / GetDesFun Left=49, Width=229)
        loc_oCnt.AddObject("lbl_4c_LblFuncao", "Label")
        WITH loc_oCnt.lbl_4c_LblFuncao
            .Caption = "Fun" + CHR(231) + CHR(227) + "o"
            .Top = 162
            .Left = 16
            .Width = 60
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oCnt.txt_4c_Codigos
            .Top = 177
            .Left = 16
            .Width = 30
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Fpags", "TextBox")
        WITH loc_oCnt.txt_4c_Fpags
            .Top = 177
            .Left = 49
            .Width = 229
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .ReadOnly = .T.
            .Visible = .T.
        ENDWITH

        *-- Grupo Vendedor (Get_grupoven Top=177, Left=287)
        loc_oCnt.AddObject("lbl_4c_LblGrupoven", "Label")
        WITH loc_oCnt.lbl_4c_LblGrupoven
            .Caption = "Gr.Vendedor"
            .Top = 162
            .Left = 287
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Grupovens", "TextBox")
        WITH loc_oCnt.txt_4c_Grupovens
            .Top = 177
            .Left = 287
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Separador linha (Shape2 Top=283)
        *-- (shapes nao criados, apenas campos funcionais)

        *-- Nascimento/Sexo/Nacionalidade (Top=216 area)
        loc_oCnt.AddObject("lbl_4c_LblNascs", "Label")
        WITH loc_oCnt.lbl_4c_LblNascs
            .Caption = "Nascimento"
            .Top = 201
            .Left = 16
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Nascs", "TextBox")
        WITH loc_oCnt.txt_4c_Nascs
            .Top = 216
            .Left = 16
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = {}
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblNacionals", "Label")
        WITH loc_oCnt.lbl_4c_LblNacionals
            .Caption = "Nacionalidade"
            .Top = 201
            .Left = 100
            .Width = 90
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Nacionals", "TextBox")
        WITH loc_oCnt.txt_4c_Nacionals
            .Top = 216
            .Left = 100
            .Width = 183
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Sexo
        loc_oCnt.AddObject("lbl_4c_LblSexos", "Label")
        WITH loc_oCnt.lbl_4c_LblSexos
            .Caption = "Sexo"
            .Top = 201
            .Left = 287
            .Width = 40
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Sexos", "TextBox")
        WITH loc_oCnt.txt_4c_Sexos
            .Top = 216
            .Left = 287
            .Width = 40
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Estado Civil (cmbEstcivils Top=216, Left=413, Width=166)
        loc_oCnt.AddObject("lbl_4c_LblEstcivils", "Label")
        WITH loc_oCnt.lbl_4c_LblEstcivils
            .Caption = "Estado Civil"
            .Top = 201
            .Left = 413
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("cmb_4c_Estcivils", "ComboBox")
        WITH loc_oCnt.cmb_4c_Estcivils
            .Top = 216
            .Left = 413
            .Width = 166
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .RowSourceType = 1
            .RowSource = "Solteiro,Casado,Vi" + CHR(250) + "vo,Divorciado,Uni" + ;
                CHR(227) + "o Est" + CHR(225) + "vel,Separado"
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Conjuge (Top=241)
        loc_oCnt.AddObject("lbl_4c_LblConjuges", "Label")
        WITH loc_oCnt.lbl_4c_LblConjuges
            .Caption = "Nome / C" + CHR(244) + "njuge"
            .Top = 241
            .Left = 16
            .Width = 100
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Conjuges", "TextBox")
        WITH loc_oCnt.txt_4c_Conjuges
            .Top = 256
            .Left = 16
            .Width = 393
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- CPF Conjuge (getCpf2 Top=256, Left=413)
        loc_oCnt.AddObject("txt_4c_Cpfcs", "TextBox")
        WITH loc_oCnt.txt_4c_Cpfcs
            .Top = 256
            .Left = 413
            .Width = 142
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- RG Conjuge (getRG2 Top=256, Left=563)
        loc_oCnt.AddObject("txt_4c_Rgconjuges", "TextBox")
        WITH loc_oCnt.txt_4c_Rgconjuges
            .Top = 256
            .Left = 563
            .Width = 151
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- ID conta (Get_Idconta Top=256, Left=723)
        loc_oCnt.AddObject("txt_4c_Idcontas", "TextBox")
        WITH loc_oCnt.txt_4c_Idcontas
            .Top = 256
            .Left = 723
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .Enabled = .F.
            .Visible = .T.
        ENDWITH

        *-- CEP + Pais + Regiao (Top=302)
        loc_oCnt.AddObject("lbl_4c_LblCeps", "Label")
        WITH loc_oCnt.lbl_4c_LblCeps
            .Caption = "CEP"
            .Top = 287
            .Left = 16
            .Width = 40
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Ceps", "TextBox")
        WITH loc_oCnt.txt_4c_Ceps
            .Top = 302
            .Left = 16
            .Width = 85
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblPaises", "Label")
        WITH loc_oCnt.lbl_4c_LblPaises
            .Caption = "Pa" + CHR(237) + "s"
            .Top = 287
            .Left = 105
            .Width = 40
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Paises", "TextBox")
        WITH loc_oCnt.txt_4c_Paises
            .Top = 302
            .Left = 105
            .Width = 186
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblRegiaos", "Label")
        WITH loc_oCnt.lbl_4c_LblRegiaos
            .Caption = "Regi" + CHR(227) + "o"
            .Top = 287
            .Left = 299
            .Width = 50
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Regiaos", "TextBox")
        WITH loc_oCnt.txt_4c_Regiaos
            .Top = 302
            .Left = 299
            .Width = 85
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Endereco (Top=341)
        loc_oCnt.AddObject("lbl_4c_LblEndes", "Label")
        WITH loc_oCnt.lbl_4c_LblEndes
            .Caption = "Endere" + CHR(231) + "o"
            .Top = 326
            .Left = 16
            .Width = 60
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Endes", "TextBox")
        WITH loc_oCnt.txt_4c_Endes
            .Top = 341
            .Left = 16
            .Width = 368
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblNums", "Label")
        WITH loc_oCnt.lbl_4c_LblNums
            .Caption = "Num"
            .Top = 326
            .Left = 387
            .Width = 30
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Nums", "TextBox")
        WITH loc_oCnt.txt_4c_Nums
            .Top = 341
            .Left = 387
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblCompls", "Label")
        WITH loc_oCnt.lbl_4c_LblCompls
            .Caption = "Complemento"
            .Top = 326
            .Left = 470
            .Width = 90
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Compls", "TextBox")
        WITH loc_oCnt.txt_4c_Compls
            .Top = 341
            .Left = 470
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Bairro / Cidade / Estado (Top=380)
        loc_oCnt.AddObject("lbl_4c_LblBairs", "Label")
        WITH loc_oCnt.lbl_4c_LblBairs
            .Caption = "Bairro"
            .Top = 365
            .Left = 16
            .Width = 50
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Bairs", "TextBox")
        WITH loc_oCnt.txt_4c_Bairs
            .Top = 380
            .Left = 16
            .Width = 276
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblCidas", "Label")
        WITH loc_oCnt.lbl_4c_LblCidas
            .Caption = "Cidade"
            .Top = 365
            .Left = 299
            .Width = 50
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cidas", "TextBox")
        WITH loc_oCnt.txt_4c_Cidas
            .Top = 380
            .Left = 299
            .Width = 306
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblEstas", "Label")
        WITH loc_oCnt.lbl_4c_LblEstas
            .Caption = "UF"
            .Top = 365
            .Left = 675
            .Width = 30
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Estas", "TextBox")
        WITH loc_oCnt.txt_4c_Estas
            .Top = 380
            .Left = 675
            .Width = 25
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .MaxLength = 2
            .Visible = .T.
        ENDWITH

        *-- Telefones (getDdds, GetTel1, GetTel2, GetFax Top=419)
        loc_oCnt.AddObject("lbl_4c_LblTel", "Label")
        WITH loc_oCnt.lbl_4c_LblTel
            .Caption = "Tel/Fone"
            .Top = 404
            .Left = 16
            .Width = 60
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Ddds", "TextBox")
        WITH loc_oCnt.txt_4c_Ddds
            .Top = 419
            .Left = 16
            .Width = 35
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tel1s", "TextBox")
        WITH loc_oCnt.txt_4c_Tel1s
            .Top = 419
            .Left = 55
            .Width = 139
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tel2s", "TextBox")
        WITH loc_oCnt.txt_4c_Tel2s
            .Top = 419
            .Left = 270
            .Width = 138
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Faxs", "TextBox")
        WITH loc_oCnt.txt_4c_Faxs
            .Top = 419
            .Left = 409
            .Width = 102
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Segmento / Profissao (Top=419)
        loc_oCnt.AddObject("lbl_4c_LblProfiss", "Label")
        WITH loc_oCnt.lbl_4c_LblProfiss
            .Caption = "Profiss" + CHR(227) + "o"
            .Top = 404
            .Left = 513
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Profiss", "TextBox")
        WITH loc_oCnt.txt_4c_Profiss
            .Top = 419
            .Left = 513
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Email (Top=460)
        loc_oCnt.AddObject("lbl_4c_LblEmails", "Label")
        WITH loc_oCnt.lbl_4c_LblEmails
            .Caption = "E-mail"
            .Top = 445
            .Left = 16
            .Width = 50
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Emails", "TextBox")
        WITH loc_oCnt.txt_4c_Emails
            .Top = 460
            .Left = 16
            .Width = 368
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Contato (Get_Contato Top=460, Left=471)
        loc_oCnt.AddObject("lbl_4c_LblContato", "Label")
        WITH loc_oCnt.lbl_4c_LblContato
            .Caption = "Contato"
            .Top = 445
            .Left = 471
            .Width = 60
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Contato", "TextBox")
        WITH loc_oCnt.txt_4c_Contato
            .Top = 460
            .Left = 471
            .Width = 290
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Memo Obs (MemoFun Top=487, Left=16, Width=745, Height=71)
        loc_oCnt.AddObject("lbl_4c_LblObs", "Label")
        WITH loc_oCnt.lbl_4c_LblObs
            .Caption = "Observa" + CHR(231) + CHR(245) + "es"
            .Top = 472
            .Left = 16
            .Width = 90
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("edt_4c_Obs", "EditBox")
        WITH loc_oCnt.edt_4c_Obs
            .Top = 487
            .Left = 16
            .Width = 745
            .Height = 71
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Datas (data_ent Top=527, Data_alt Top=567)
        loc_oCnt.AddObject("lbl_4c_LblDataincs", "Label")
        WITH loc_oCnt.lbl_4c_LblDataincs
            .Caption = "Inclus" + CHR(227) + "o"
            .Top = 512
            .Left = 898
            .Width = 88
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Dataincs", "TextBox")
        WITH loc_oCnt.txt_4c_Dataincs
            .Top = 527
            .Left = 897
            .Width = 70
            .Height = 20
            .FontName = "Tahoma"
            .FontBold = .T.
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .BackColor = RGB(253, 250, 185)
            .DisabledBackColor = RGB(253, 250, 185)
            .DisabledForeColor = RGB(36, 84, 155)
            .Value = {}
            .Enabled = .F.
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblDtalts", "Label")
        WITH loc_oCnt.lbl_4c_LblDtalts
            .Caption = "Altera" + CHR(231) + CHR(227) + "o"
            .Top = 552
            .Left = 898
            .Width = 88
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Dtalts", "TextBox")
        WITH loc_oCnt.txt_4c_Dtalts
            .Top = 567
            .Left = 897
            .Width = 70
            .Height = 20
            .FontName = "Tahoma"
            .FontBold = .T.
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .BackColor = RGB(253, 250, 185)
            .DisabledBackColor = RGB(253, 250, 185)
            .DisabledForeColor = RGB(36, 84, 155)
            .Value = {}
            .Enabled = .F.
            .Visible = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * Sub-pagina 2: Comercial (Tabela preco, Forma pgto, Limite)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarSubPagina2(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg2", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg2
        WITH loc_oCnt
            .Top = 107
            .Left = 0
            .Width = 1000
            .Height = 493
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .F.
        ENDWITH

        *-- Tipo Cadastro
        loc_oCnt.AddObject("lbl_4c_LblTpcads", "Label")
        WITH loc_oCnt.lbl_4c_LblTpcads
            .Caption = "Tipo Cadastro"
            .Top = 30
            .Left = 16
            .Width = 100
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tpcads", "TextBox")
        WITH loc_oCnt.txt_4c_Tpcads
            .Top = 45
            .Left = 16
            .Width = 30
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .Visible = .T.
        ENDWITH

        *-- Tipo Cliente
        loc_oCnt.AddObject("lbl_4c_LblTpclis", "Label")
        WITH loc_oCnt.lbl_4c_LblTpclis
            .Caption = "Tipo Cliente"
            .Top = 30
            .Left = 50
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tpclis", "TextBox")
        WITH loc_oCnt.txt_4c_Tpclis
            .Top = 45
            .Left = 50
            .Width = 30
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .Visible = .T.
        ENDWITH

        *-- Tabela de Preco (Tabds)
        loc_oCnt.AddObject("lbl_4c_LblTabds", "Label")
        WITH loc_oCnt.lbl_4c_LblTabds
            .Caption = "Tabela Pre" + CHR(231) + "o"
            .Top = 30
            .Left = 100
            .Width = 100
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tabds", "TextBox")
        WITH loc_oCnt.txt_4c_Tabds
            .Top = 45
            .Left = 100
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Tabela Alternativa (Tabd2s)
        loc_oCnt.AddObject("lbl_4c_LblTabd2s", "Label")
        WITH loc_oCnt.lbl_4c_LblTabd2s
            .Caption = "Tab.Alternativa"
            .Top = 30
            .Left = 185
            .Width = 100
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tabd2s", "TextBox")
        WITH loc_oCnt.txt_4c_Tabd2s
            .Top = 45
            .Left = 185
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Lista Preco (Lprecos)
        loc_oCnt.AddObject("lbl_4c_LblLprecos", "Label")
        WITH loc_oCnt.lbl_4c_LblLprecos
            .Caption = "Lista Pre" + CHR(231) + "o"
            .Top = 30
            .Left = 270
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Lprecos", "TextBox")
        WITH loc_oCnt.txt_4c_Lprecos
            .Top = 45
            .Left = 270
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Forma Pgto (Fpags)
        loc_oCnt.AddObject("lbl_4c_LblFpags", "Label")
        WITH loc_oCnt.lbl_4c_LblFpags
            .Caption = "Forma Pgto"
            .Top = 30
            .Left = 355
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Fpags2", "TextBox")
        WITH loc_oCnt.txt_4c_Fpags2
            .Top = 45
            .Left = 355
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Prazo Entrega
        loc_oCnt.AddObject("lbl_4c_LblPrazoents", "Label")
        WITH loc_oCnt.lbl_4c_LblPrazoents
            .Caption = "Prazo Entrega"
            .Top = 30
            .Left = 440
            .Width = 90
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Prazoents", "TextBox")
        WITH loc_oCnt.txt_4c_Prazoents
            .Top = 45
            .Left = 440
            .Width = 50
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .Visible = .T.
        ENDWITH

        *-- Codsegs
        loc_oCnt.AddObject("lbl_4c_LblCodsegs", "Label")
        WITH loc_oCnt.lbl_4c_LblCodsegs
            .Caption = "Cod.Seguro"
            .Top = 30
            .Left = 495
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Codsegs", "TextBox")
        WITH loc_oCnt.txt_4c_Codsegs
            .Top = 45
            .Left = 495
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Limite Credito
        loc_oCnt.AddObject("lbl_4c_LblLimcres", "Label")
        WITH loc_oCnt.lbl_4c_LblLimcres
            .Caption = "Limite Cr" + CHR(233) + "dito"
            .Top = 80
            .Left = 16
            .Width = 90
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Limcres", "TextBox")
        WITH loc_oCnt.txt_4c_Limcres
            .Top = 95
            .Left = 16
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .InputMask = "9999999.99"
            .Visible = .T.
        ENDWITH

        *-- Juros
        loc_oCnt.AddObject("lbl_4c_LblJuros", "Label")
        WITH loc_oCnt.lbl_4c_LblJuros
            .Caption = "Juros %"
            .Top = 80
            .Left = 125
            .Width = 60
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Juros", "TextBox")
        WITH loc_oCnt.txt_4c_Juros
            .Top = 95
            .Left = 125
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .InputMask = "999.99"
            .Visible = .T.
        ENDWITH

        *-- Desconto
        loc_oCnt.AddObject("lbl_4c_LblPercdescli", "Label")
        WITH loc_oCnt.lbl_4c_LblPercdescli
            .Caption = "Desc %"
            .Top = 80
            .Left = 190
            .Width = 60
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Percdescli", "TextBox")
        WITH loc_oCnt.txt_4c_Percdescli
            .Top = 95
            .Left = 190
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .InputMask = "999.99"
            .Visible = .T.
        ENDWITH

        *-- Comissao
        loc_oCnt.AddObject("lbl_4c_LblComis", "Label")
        WITH loc_oCnt.lbl_4c_LblComis
            .Caption = "Comiss" + CHR(227) + "o %"
            .Top = 80
            .Left = 255
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Comis", "TextBox")
        WITH loc_oCnt.txt_4c_Comis
            .Top = 95
            .Left = 255
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .InputMask = "999.99"
            .Visible = .T.
        ENDWITH

        *-- Grupos de conta
        loc_oCnt.AddObject("lbl_4c_LblGrupocobs", "Label")
        WITH loc_oCnt.lbl_4c_LblGrupocobs
            .Caption = "Gr.Cobran" + CHR(231) + "a"
            .Top = 140
            .Left = 16
            .Width = 90
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Grupocobs", "TextBox")
        WITH loc_oCnt.txt_4c_Grupocobs
            .Top = 155
            .Left = 16
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblGruprods", "Label")
        WITH loc_oCnt.lbl_4c_LblGruprods
            .Caption = "Gr.Produto"
            .Top = 140
            .Left = 100
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Gruprods", "TextBox")
        WITH loc_oCnt.txt_4c_Gruprods
            .Top = 155
            .Left = 100
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblGrupocents", "Label")
        WITH loc_oCnt.lbl_4c_LblGrupocents
            .Caption = "Gr.Custo"
            .Top = 140
            .Left = 185
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Grupocents", "TextBox")
        WITH loc_oCnt.txt_4c_Grupocents
            .Top = 155
            .Left = 185
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblGrupomats", "Label")
        WITH loc_oCnt.lbl_4c_LblGrupomats
            .Caption = "Gr.Material"
            .Top = 140
            .Left = 270
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Grupomats", "TextBox")
        WITH loc_oCnt.txt_4c_Grupomats
            .Top = 155
            .Left = 270
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Contas contabeis (Contacobs, Contamats, Contavens, Contaven2s, Contacents, Conprods)
        loc_oCnt.AddObject("lbl_4c_LblContacobs", "Label")
        WITH loc_oCnt.lbl_4c_LblContacobs
            .Caption = "Cta.Cobran" + CHR(231) + "a"
            .Top = 200
            .Left = 16
            .Width = 90
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Contacobs", "TextBox")
        WITH loc_oCnt.txt_4c_Contacobs
            .Top = 215
            .Left = 16
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Contamats", "TextBox")
        WITH loc_oCnt.txt_4c_Contamats
            .Top = 215
            .Left = 120
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Contavens", "TextBox")
        WITH loc_oCnt.txt_4c_Contavens
            .Top = 215
            .Left = 224
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Contaven2s", "TextBox")
        WITH loc_oCnt.txt_4c_Contaven2s
            .Top = 215
            .Left = 328
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Contacents", "TextBox")
        WITH loc_oCnt.txt_4c_Contacents
            .Top = 215
            .Left = 432
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Conprods", "TextBox")
        WITH loc_oCnt.txt_4c_Conprods
            .Top = 215
            .Left = 536
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Contab conta
        loc_oCnt.AddObject("lbl_4c_LblCcontabs", "Label")
        WITH loc_oCnt.lbl_4c_LblCcontabs
            .Caption = "Cta.Contabil"
            .Top = 260
            .Left = 16
            .Width = 90
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Ccontabs", "TextBox")
        WITH loc_oCnt.txt_4c_Ccontabs
            .Top = 275
            .Left = 16
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * Sub-paginas 3-12: containers com campos chave para BOParaForm
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarSubPagina3(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg3", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg3
        WITH loc_oCnt
            .Top = 107
            .Left = 0
            .Width = 1000
            .Height = 493
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .F.
        ENDWITH
        *-- Dados Bancarios
        loc_oCnt.AddObject("lbl_4c_TituloP3", "Label")
        WITH loc_oCnt.lbl_4c_TituloP3
            .Caption = "Dados Banc" + CHR(225) + "rios"
            .Top = 80
            .Left = 40
            .Width = 120
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        *-- Campos de Endcob (usado em alguns formularios de banco)
        loc_oCnt.AddObject("lbl_4c_LblEndcobs", "Label")
        WITH loc_oCnt.lbl_4c_LblEndcobs
            .Caption = "End.Cobran" + CHR(231) + "a"
            .Top = 110
            .Left = 16
            .Width = 100
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Endcobs", "TextBox")
        WITH loc_oCnt.txt_4c_Endcobs
            .Top = 125
            .Left = 16
            .Width = 300
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cepcobs", "TextBox")
        WITH loc_oCnt.txt_4c_Cepcobs
            .Top = 125
            .Left = 320
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cidcobs", "TextBox")
        WITH loc_oCnt.txt_4c_Cidcobs
            .Top = 125
            .Left = 405
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Estcobs", "TextBox")
        WITH loc_oCnt.txt_4c_Estcobs
            .Top = 125
            .Left = 609
            .Width = 25
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Baicobs", "TextBox")
        WITH loc_oCnt.txt_4c_Baicobs
            .Top = 125
            .Left = 638
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Paicobs", "TextBox")
        WITH loc_oCnt.txt_4c_Paicobs
            .Top = 165
            .Left = 16
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ConfigurarSubPagina4(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg4", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg4
        WITH loc_oCnt
            .Top = 107
            .Left = 0
            .Width = 1000
            .Height = 493
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .F.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_TituloP4", "Label")
        WITH loc_oCnt.lbl_4c_TituloP4
            .Caption = "Follow-up"
            .Top = 80
            .Left = 40
            .Width = 100
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        *-- Endereco trabalho
        loc_oCnt.AddObject("lbl_4c_LblEndtrabs", "Label")
        WITH loc_oCnt.lbl_4c_LblEndtrabs
            .Caption = "End. Trabalho"
            .Top = 110
            .Left = 16
            .Width = 100
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Endtrabs", "TextBox")
        WITH loc_oCnt.txt_4c_Endtrabs
            .Top = 125
            .Left = 16
            .Width = 300
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Ceptrabs", "TextBox")
        WITH loc_oCnt.txt_4c_Ceptrabs
            .Top = 125
            .Left = 320
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cidtrabs", "TextBox")
        WITH loc_oCnt.txt_4c_Cidtrabs
            .Top = 125
            .Left = 405
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Esttrabs", "TextBox")
        WITH loc_oCnt.txt_4c_Esttrabs
            .Top = 125
            .Left = 609
            .Width = 25
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Bairtrabs", "TextBox")
        WITH loc_oCnt.txt_4c_Bairtrabs
            .Top = 125
            .Left = 638
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Numtrabs", "TextBox")
        WITH loc_oCnt.txt_4c_Numtrabs
            .Top = 165
            .Left = 16
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Compltrabs", "TextBox")
        WITH loc_oCnt.txt_4c_Compltrabs
            .Top = 165
            .Left = 100
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Emptrabs", "TextBox")
        WITH loc_oCnt.txt_4c_Emptrabs
            .Top = 205
            .Left = 16
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cnpjtrabs", "TextBox")
        WITH loc_oCnt.txt_4c_Cnpjtrabs
            .Top = 205
            .Left = 220
            .Width = 150
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Teltrabs", "TextBox")
        WITH loc_oCnt.txt_4c_Teltrabs
            .Top = 205
            .Left = 374
            .Width = 120
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Paitrabs", "TextBox")
        WITH loc_oCnt.txt_4c_Paitrabs
            .Top = 205
            .Left = 498
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ConfigurarSubPagina5(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg5", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg5
        WITH loc_oCnt
            .Top = 107
            .Left = 0
            .Width = 1000
            .Height = 493
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .F.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_TituloP5", "Label")
        WITH loc_oCnt.lbl_4c_TituloP5
            .Caption = "Conta Corrente"
            .Top = 80
            .Left = 40
            .Width = 130
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        *-- Endereco entrega (cos)
        loc_oCnt.AddObject("lbl_4c_LblEndcos", "Label")
        WITH loc_oCnt.lbl_4c_LblEndcos
            .Caption = "End. Entrega"
            .Top = 110
            .Left = 16
            .Width = 100
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Endcos", "TextBox")
        WITH loc_oCnt.txt_4c_Endcos
            .Top = 125
            .Left = 16
            .Width = 300
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cepcos", "TextBox")
        WITH loc_oCnt.txt_4c_Cepcos
            .Top = 125
            .Left = 320
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cidcos", "TextBox")
        WITH loc_oCnt.txt_4c_Cidcos
            .Top = 125
            .Left = 405
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Estcos", "TextBox")
        WITH loc_oCnt.txt_4c_Estcos
            .Top = 125
            .Left = 609
            .Width = 25
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Baicos", "TextBox")
        WITH loc_oCnt.txt_4c_Baicos
            .Top = 125
            .Left = 638
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Nomecos", "TextBox")
        WITH loc_oCnt.txt_4c_Nomecos
            .Top = 165
            .Left = 16
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Complcos", "TextBox")
        WITH loc_oCnt.txt_4c_Complcos
            .Top = 165
            .Left = 220
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Numcos", "TextBox")
        WITH loc_oCnt.txt_4c_Numcos
            .Top = 165
            .Left = 424
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Paicobs2", "TextBox")
        WITH loc_oCnt.txt_4c_Paicobs2
            .Top = 165
            .Left = 488
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ConfigurarSubPagina6(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg6", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg6
        WITH loc_oCnt
            .Top = 107
            .Left = 0
            .Width = 1000
            .Height = 493
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .F.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_TituloP6", "Label")
        WITH loc_oCnt.lbl_4c_TituloP6
            .Caption = "Dados Fiscais"
            .Top = 80
            .Left = 40
            .Width = 120
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        *-- Dados fiscais: Fpubls, Cfos, Codtifs, Tpcps, Rgcs, Pis, Microemps, Optsimples
        loc_oCnt.AddObject("lbl_4c_LblFpubls", "Label")
        WITH loc_oCnt.lbl_4c_LblFpubls
            .Caption = "Finalidade"
            .Top = 110
            .Left = 16
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Fpubls", "TextBox")
        WITH loc_oCnt.txt_4c_Fpubls
            .Top = 125
            .Left = 16
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cfos", "TextBox")
        WITH loc_oCnt.txt_4c_Cfos
            .Top = 125
            .Left = 80
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Codtifs", "TextBox")
        WITH loc_oCnt.txt_4c_Codtifs
            .Top = 125
            .Left = 144
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Tpcps", "TextBox")
        WITH loc_oCnt.txt_4c_Tpcps
            .Top = 125
            .Left = 208
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Rgcs", "TextBox")
        WITH loc_oCnt.txt_4c_Rgcs
            .Top = 125
            .Left = 272
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Pis", "TextBox")
        WITH loc_oCnt.txt_4c_Pis
            .Top = 125
            .Left = 376
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Microemps", "CheckBox")
        WITH loc_oCnt.chk_4c_Microemps
            .Caption = "Microempresa"
            .Top = 155
            .Left = 16
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Optsimples", "CheckBox")
        WITH loc_oCnt.chk_4c_Optsimples
            .Caption = "Opt.Simples"
            .Top = 155
            .Left = 120
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        *-- Inscricao Municipal
        loc_oCnt.AddObject("txt_4c_Suframas", "TextBox")
        WITH loc_oCnt.txt_4c_Suframas
            .Top = 190
            .Left = 16
            .Width = 150
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ConfigurarSubPagina7(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg7", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg7
        WITH loc_oCnt
            .Top = 107
            .Left = 0
            .Width = 1000
            .Height = 493
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .F.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_TituloP7", "Label")
        WITH loc_oCnt.lbl_4c_TituloP7
            .Caption = "Complemento"
            .Top = 80
            .Left = 40
            .Width = 120
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        *-- Campos misc: Contats, Ctelems, Rg2 (Cpfcs), Emissors, Nomearts
        loc_oCnt.AddObject("lbl_4c_LblContats", "Label")
        WITH loc_oCnt.lbl_4c_LblContats
            .Caption = "Contatos adicionais"
            .Top = 110
            .Left = 16
            .Width = 130
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Contats", "TextBox")
        WITH loc_oCnt.txt_4c_Contats
            .Top = 125
            .Left = 16
            .Width = 250
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Ctelems", "TextBox")
        WITH loc_oCnt.txt_4c_Ctelems
            .Top = 125
            .Left = 270
            .Width = 120
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Nomearts", "TextBox")
        WITH loc_oCnt.txt_4c_Nomearts
            .Top = 125
            .Left = 394
            .Width = 250
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Emissors", "TextBox")
        WITH loc_oCnt.txt_4c_Emissors
            .Top = 165
            .Left = 16
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Senhas", "TextBox")
        WITH loc_oCnt.txt_4c_Senhas
            .Top = 165
            .Left = 120
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .PasswordChar = "*"
            .Visible = .T.
        ENDWITH
        *-- Coletores/Consig
        loc_oCnt.AddObject("lbl_4c_LblColetors", "Label")
        WITH loc_oCnt.lbl_4c_LblColetors
            .Caption = "Coletor"
            .Top = 200
            .Left = 16
            .Width = 60
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Coletors", "TextBox")
        WITH loc_oCnt.txt_4c_Coletors
            .Top = 215
            .Left = 16
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Consignas", "TextBox")
        WITH loc_oCnt.txt_4c_Consignas
            .Top = 215
            .Left = 80
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Masters", "TextBox")
        WITH loc_oCnt.txt_4c_Masters
            .Top = 215
            .Left = 144
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Intconts", "TextBox")
        WITH loc_oCnt.txt_4c_Intconts
            .Top = 215
            .Left = 208
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .Visible = .T.
        ENDWITH
        *-- Obs pagamento e Praca
        loc_oCnt.AddObject("txt_4c_Obspagto", "TextBox")
        WITH loc_oCnt.txt_4c_Obspagto
            .Top = 260
            .Left = 16
            .Width = 400
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Pracas", "TextBox")
        WITH loc_oCnt.txt_4c_Pracas
            .Top = 260
            .Left = 420
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ConfigurarSubPagina8(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg8", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg8
        WITH loc_oCnt
            .Top = 107
            .Left = 0
            .Width = 1000
            .Height = 493
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .F.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_TituloP8", "Label")
        WITH loc_oCnt.lbl_4c_TituloP8
            .Caption = "Empresa"
            .Top = 80
            .Left = 40
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        *-- Empresa / usuario
        loc_oCnt.AddObject("lbl_4c_LblEmps", "Label")
        WITH loc_oCnt.lbl_4c_LblEmps
            .Caption = "Empresa"
            .Top = 110
            .Left = 16
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oCnt.txt_4c_Emps
            .Top = 125
            .Left = 16
            .Width = 33
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .MaxLength = 3
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Usualts", "TextBox")
        WITH loc_oCnt.txt_4c_Usualts
            .Top = 125
            .Left = 53
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Enabled = .F.
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Usuars", "TextBox")
        WITH loc_oCnt.txt_4c_Usuars
            .Top = 125
            .Left = 157
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Enabled = .F.
            .Visible = .T.
        ENDWITH
        *-- Gr.Produtos/Mats/Vends
        loc_oCnt.AddObject("txt_4c_Gruprods2", "TextBox")
        WITH loc_oCnt.txt_4c_Gruprods2
            .Top = 165
            .Left = 16
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Grupovens2", "TextBox")
        WITH loc_oCnt.txt_4c_Grupovens2
            .Top = 165
            .Left = 100
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ConfigurarSubPagina9(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg9", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg9
        WITH loc_oCnt
            .Top = 107
            .Left = 0
            .Width = 1000
            .Height = 493
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_TituloP9", "Label")
        WITH loc_oCnt.lbl_4c_TituloP9
            .Caption = "Dados Cont" + CHR(225) + "beis"
            .Top = 5
            .Left = 16
            .Width = 200
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- Cabecalho das colunas
        LOCAL loc_aHdr[7,2]
        loc_aHdr[1,1] = "Gr.Cont" + CHR(225) + "bil"   && header caption
        loc_aHdr[1,2] = 65                              && Left
        loc_aHdr[2,1] = "Conta"
        loc_aHdr[2,2] = 150
        loc_aHdr[3,1] = "Descri" + CHR(231) + CHR(227) + "o"
        loc_aHdr[3,2] = 235
        loc_aHdr[4,1] = "Al" + CHR(237) + "quota%"
        loc_aHdr[4,2] = 438
        loc_aHdr[5,1] = "Receita"
        loc_aHdr[5,2] = 500
        loc_aHdr[6,1] = "Tipo"
        loc_aHdr[6,2] = 552
        loc_aHdr[7,1] = "NF"
        loc_aHdr[7,2] = 618

        LOCAL loc_i
        FOR loc_i = 1 TO 7
            loc_oCnt.AddObject("lbl_4c_Hdr" + ALLTRIM(STR(loc_i)), "Label")
            WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
                .Caption   = loc_aHdr[loc_i,1]
                .Top       = 22
                .Left      = loc_aHdr[loc_i,2]
                .Width     = 80
                .Height    = 14
                .FontName  = "Tahoma"
                .FontSize  = 7
                .FontBold  = .T.
                .ForeColor = RGB(60, 60, 120)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDFOR

        *-- 9 linhas: ICMS, IPI, II, ISS, IRRF, INSS, PIS, CSSL, COFINS
        *-- Sufixo 2 letras: IC IP II IS IR IN PI CS CO
        *-- String CfgFisXXs: PADR(Gru,10)+PADR(Cd,10)+PADR(Ds,10)+TRANSFORM(Pct,"99.9")+Rec+Tip+Fin = 37 chars
        LOCAL ARRAY loc_aTax[9,2]
        loc_aTax[1,1] = "ICMS"
        loc_aTax[1,2] = "IC"
        loc_aTax[2,1] = "IPI"
        loc_aTax[2,2] = "IP"
        loc_aTax[3,1] = "II"
        loc_aTax[3,2] = "II"
        loc_aTax[4,1] = "ISS"
        loc_aTax[4,2] = "IS"
        loc_aTax[5,1] = "IRRF"
        loc_aTax[5,2] = "IR"
        loc_aTax[6,1] = "INSS"
        loc_aTax[6,2] = "IN"
        loc_aTax[7,1] = "PIS"
        loc_aTax[7,2] = "PI"
        loc_aTax[8,1] = "CSSL"
        loc_aTax[8,2] = "CS"
        loc_aTax[9,1] = "COFINS"
        loc_aTax[9,2] = "CO"

        LOCAL loc_nTop, loc_nTax, loc_cSfx, loc_cNome
        loc_nTop = 38

        FOR loc_nTax = 1 TO 9
            loc_cNome = loc_aTax[loc_nTax, 1]
            loc_cSfx  = loc_aTax[loc_nTax, 2]

            *-- Label tributo
            loc_oCnt.AddObject("lbl_4c_Tax" + loc_cSfx, "Label")
            WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
                .Caption   = loc_cNome
                .Top       = loc_nTop + 4
                .Left      = 16
                .Width     = 46
                .Height    = 14
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 128)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- getCdGrupos: grupo contabil (F4=lookup SigCdGcr)
            loc_oCnt.AddObject("txt_4c_Gru" + loc_cSfx, "TextBox")
            WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
                .Top           = loc_nTop
                .Left          = 65
                .Width         = 80
                .Height        = 20
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .MaxLength     = 10
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- getCdContas: codigo conta (F4=lookup SigCdCli filtrado por grupo)
            loc_oCnt.AddObject("txt_4c_Cd" + loc_cSfx, "TextBox")
            WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
                .Top           = loc_nTop
                .Left          = 150
                .Width         = 80
                .Height        = 20
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .MaxLength     = 10
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- getDsContas: descricao conta (ReadOnly, preenchido pelo lookup de conta)
            loc_oCnt.AddObject("txt_4c_Ds" + loc_cSfx, "TextBox")
            WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
                .Top              = loc_nTop
                .Left             = 235
                .Width            = 200
                .Height           = 20
                .FontName         = "Tahoma"
                .FontSize         = 8
                .SpecialEffect    = 1
                .ForeColor        = RGB(0, 0, 0)
                .BorderColor      = RGB(100, 100, 100)
                .ReadOnly         = .T.
                .DisabledBackColor = RGB(240, 240, 240)
                .Value            = ""
                .Visible          = .T.
            ENDWITH

            *-- getPctAliqs: aliquota %
            loc_oCnt.AddObject("txt_4c_Pct" + loc_cSfx, "TextBox")
            WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
                .Top           = loc_nTop
                .Left          = 438
                .Width         = 58
                .Height        = 20
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Value         = 0
                .InputMask     = "99.9"
                .Visible       = .T.
            ENDWITH

            *-- getReceitas: codigo de receita (1 char)
            loc_oCnt.AddObject("txt_4c_Rec" + loc_cSfx, "TextBox")
            WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
                .Top           = loc_nTop
                .Left          = 500
                .Width         = 48
                .Height        = 20
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .MaxLength     = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- optSelTipos: Normal (0) / Reduzido (1)
            loc_oCnt.AddObject("chk_4c_Tip" + loc_cSfx, "CheckBox")
            WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
                .Caption       = "Reduzido"
                .Top           = loc_nTop + 1
                .Left          = 552
                .Width         = 62
                .Height        = 18
                .FontName      = "Tahoma"
                .FontSize      = 7
                .Alignment     = 0
                .SpecialEffect = 1
                .Value         = 0
                .ForeColor     = RGB(60, 60, 60)
                .Visible       = .T.
            ENDWITH

            *-- OptSelFI: flag nota fiscal
            loc_oCnt.AddObject("chk_4c_Fin" + loc_cSfx, "CheckBox")
            WITH loc_oCnt.Controls(loc_oCnt.ControlCount)
                .Caption       = "NF"
                .Top           = loc_nTop + 1
                .Left          = 618
                .Width         = 40
                .Height        = 18
                .FontName      = "Tahoma"
                .FontSize      = 7
                .Alignment     = 0
                .SpecialEffect = 1
                .Value         = 0
                .ForeColor     = RGB(60, 60, 60)
                .Visible       = .T.
            ENDWITH

            *-- BINDEVENT para lookups: F4 abre picker
            LOCAL loc_oGruRef, loc_oCdRef, loc_oDsRef
            loc_oGruRef = THIS.LocalizarControle(loc_oCnt, "txt_4c_Gru" + loc_cSfx)
            loc_oCdRef  = THIS.LocalizarControle(loc_oCnt, "txt_4c_Cd"  + loc_cSfx)
            loc_oDsRef  = THIS.LocalizarControle(loc_oCnt, "txt_4c_Ds"  + loc_cSfx)
            IF VARTYPE(loc_oGruRef) = "O"
                BINDEVENT(loc_oGruRef, "KeyPress", THIS, "TxtGru" + loc_cSfx + "KeyPress")
            ENDIF
            IF VARTYPE(loc_oCdRef) = "O"
                BINDEVENT(loc_oCdRef, "KeyPress", THIS, "TxtCd" + loc_cSfx + "KeyPress")
            ENDIF
            IF VARTYPE(loc_oDsRef) = "O"
                BINDEVENT(loc_oDsRef, "KeyPress", THIS, "TxtDs" + loc_cSfx + "KeyPress")
            ENDIF

            loc_nTop = loc_nTop + 26
        ENDFOR
    ENDPROC

    PROTECTED PROCEDURE ConfigurarSubPagina10(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg10", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg10
        WITH loc_oCnt
            .Top = 107
            .Left = 0
            .Width = 1000
            .Height = 493
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .F.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_TituloP10", "Label")
        WITH loc_oCnt.lbl_4c_TituloP10
            .Caption = "Informa" + CHR(231) + CHR(245) + "es Cadastrais"
            .Top = 80
            .Left = 40
            .Width = 170
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        *-- LGPD / Consentimentos
        loc_oCnt.AddObject("chk_4c_Autdados", "CheckBox")
        WITH loc_oCnt.chk_4c_Autdados
            .Caption = "Autoriza dados"
            .Top = 110
            .Left = 16
            .Width = 120
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Autemail", "CheckBox")
        WITH loc_oCnt.chk_4c_Autemail
            .Caption = "Autoriza e-mail"
            .Top = 110
            .Left = 140
            .Width = 120
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Autsms", "CheckBox")
        WITH loc_oCnt.chk_4c_Autsms
            .Caption = "Autoriza SMS"
            .Top = 110
            .Left = 264
            .Width = 110
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Autwhats", "CheckBox")
        WITH loc_oCnt.chk_4c_Autwhats
            .Caption = "Autoriza Whats"
            .Top = 110
            .Left = 378
            .Width = 120
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Autteleg", "CheckBox")
        WITH loc_oCnt.chk_4c_Autteleg
            .Caption = "Autoriza Telegram"
            .Top = 110
            .Left = 502
            .Width = 130
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        *-- Obs e Cobs
        loc_oCnt.AddObject("lbl_4c_LblCobs", "Label")
        WITH loc_oCnt.lbl_4c_LblCobs
            .Caption = "Observa" + CHR(231) + CHR(245) + "es Cobran" + CHR(231) + "a"
            .Top = 150
            .Left = 16
            .Width = 170
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Cobs", "TextBox")
        WITH loc_oCnt.txt_4c_Cobs
            .Top = 165
            .Left = 16
            .Width = 600
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        *-- Datas especiais
        loc_oCnt.AddObject("txt_4c_Dtcasas", "TextBox")
        WITH loc_oCnt.txt_4c_Dtcasas
            .Top = 210
            .Left = 16
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = {}
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Dtncons", "TextBox")
        WITH loc_oCnt.txt_4c_Dtncons
            .Top = 210
            .Left = 100
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = {}
            .Visible = .T.
        ENDWITH
        *-- Maes/Pais/GrauParentesco
        loc_oCnt.AddObject("txt_4c_Maes", "TextBox")
        WITH loc_oCnt.txt_4c_Maes
            .Top = 250
            .Left = 16
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Pais2", "TextBox")
        WITH loc_oCnt.txt_4c_Pais2
            .Top = 250
            .Left = 220
            .Width = 200
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Graupares", "TextBox")
        WITH loc_oCnt.txt_4c_Graupares
            .Top = 250
            .Left = 424
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ConfigurarSubPagina11(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg11", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg11
        WITH loc_oCnt
            .Top = 107
            .Left = 0
            .Width = 1000
            .Height = 493
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .F.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_TituloP11", "Label")
        WITH loc_oCnt.lbl_4c_TituloP11
            .Caption = "Caracter" + CHR(237) + "sticas"
            .Top = 80
            .Left = 40
            .Width = 120
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        *-- Flags numericos
        loc_oCnt.AddObject("chk_4c_Gerbals", "CheckBox")
        WITH loc_oCnt.chk_4c_Gerbals
            .Caption = "Geracao Boleto"
            .Top = 110
            .Left = 16
            .Width = 120
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Pagfals", "CheckBox")
        WITH loc_oCnt.chk_4c_Pagfals
            .Caption = "Pag.Falso"
            .Top = 110
            .Left = 140
            .Width = 90
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Recfals", "CheckBox")
        WITH loc_oCnt.chk_4c_Recfals
            .Caption = "Rec.Falso"
            .Top = 110
            .Left = 234
            .Width = 90
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Valemail", "CheckBox")
        WITH loc_oCnt.chk_4c_Valemail
            .Caption = "Valida Email"
            .Top = 140
            .Left = 16
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Invisivel", "CheckBox")
        WITH loc_oCnt.chk_4c_Invisivel
            .Caption = "Invisivel"
            .Top = 140
            .Left = 120
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Aptos", "CheckBox")
        WITH loc_oCnt.chk_4c_Aptos
            .Caption = "Apto"
            .Top = 140
            .Left = 204
            .Width = 60
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Patrietqs", "CheckBox")
        WITH loc_oCnt.chk_4c_Patrietqs
            .Caption = "Patrim.Eq"
            .Top = 170
            .Left = 16
            .Width = 90
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Restfors", "CheckBox")
        WITH loc_oCnt.chk_4c_Restfors
            .Caption = "Rest.Formas"
            .Top = 170
            .Left = 110
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("chk_4c_Consigs", "CheckBox")
        WITH loc_oCnt.chk_4c_Consigs
            .Caption = "Consigna" + CHR(231) + CHR(227) + "o"
            .Top = 170
            .Left = 214
            .Width = 110
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .SpecialEffect = 1
            .Value = 0
            .Visible = .T.
        ENDWITH
        *-- EAN
        loc_oCnt.AddObject("lbl_4c_LblEan13ents", "Label")
        WITH loc_oCnt.lbl_4c_LblEan13ents
            .Caption = "EAN13 Entrada"
            .Top = 210
            .Left = 16
            .Width = 100
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Ean13ents", "TextBox")
        WITH loc_oCnt.txt_4c_Ean13ents
            .Top = 225
            .Left = 16
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Ean13cobs", "TextBox")
        WITH loc_oCnt.txt_4c_Ean13cobs
            .Top = 225
            .Left = 100
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = 0
            .Visible = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ConfigurarSubPagina12(par_oPagina)
        LOCAL loc_oCnt
        par_oPagina.AddObject("cnt_4c_Pg12", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Pg12
        WITH loc_oCnt
            .Top = 107
            .Left = 0
            .Width = 1000
            .Height = 493
            .BackStyle = 0
            .BorderWidth = 0
            .Visible = .F.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_TituloP12", "Label")
        WITH loc_oCnt.lbl_4c_TituloP12
            .Caption = "Perfil"
            .Top = 80
            .Left = 40
            .Width = 80
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        *-- Perfil (memo)
        loc_oCnt.AddObject("lbl_4c_LblPerfil", "Label")
        WITH loc_oCnt.lbl_4c_LblPerfil
            .Caption = "Perfil do Cliente"
            .Top = 110
            .Left = 16
            .Width = 120
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("edt_4c_Perfils", "EditBox")
        WITH loc_oCnt.edt_4c_Perfils
            .Top = 125
            .Left = 16
            .Width = 745
            .Height = 300
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
        *-- Pastas
        loc_oCnt.AddObject("lbl_4c_LblPastas", "Label")
        WITH loc_oCnt.lbl_4c_LblPastas
            .Caption = "Pastas"
            .Top = 435
            .Left = 16
            .Width = 60
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_Pastas", "TextBox")
        WITH loc_oCnt.txt_4c_Pastas
            .Top = 450
            .Left = 16
            .Width = 300
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ForeColor = RGB(0, 0, 0)
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * MostrarSubPagina - Exibe a sub-pagina indicada, oculta as demais
    *===========================================================================
    PROCEDURE MostrarSubPagina(par_nPagina)
        LOCAL loc_oPagina, loc_nIdx
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        LOCAL ARRAY loc_aNomes[12]
        loc_aNomes[1] = "cnt_4c_Pg1"
        loc_aNomes[2] = "cnt_4c_Pg2"
        loc_aNomes[3] = "cnt_4c_Pg3"
        loc_aNomes[4] = "cnt_4c_Pg4"
        loc_aNomes[5] = "cnt_4c_Pg5"
        loc_aNomes[6] = "cnt_4c_Pg6"
        loc_aNomes[7] = "cnt_4c_Pg7"
        loc_aNomes[8] = "cnt_4c_Pg8"
        loc_aNomes[9] = "cnt_4c_Pg9"
        loc_aNomes[10] = "cnt_4c_Pg10"
        loc_aNomes[11] = "cnt_4c_Pg11"
        loc_aNomes[12] = "cnt_4c_Pg12"

        FOR loc_nIdx = 1 TO 12
            IF PEMSTATUS(loc_oPagina, loc_aNomes[loc_nIdx], 5)
                loc_oPagina.(loc_aNomes[loc_nIdx]).Visible = (loc_nIdx = par_nPagina)
            ENDIF
        ENDFOR

        THIS.this_nSubPagina = par_nPagina
        IF PEMSTATUS(loc_oPagina, "obj_4c_NavPaginas", 5)
            loc_oPagina.obj_4c_NavPaginas.Value = par_nPagina
        ENDIF
    ENDPROC

    *===========================================================================
    * NavPaginasClick - Handler do OptionGroup de navegacao
    *===========================================================================
    PROCEDURE NavPaginasClick()
        LOCAL loc_nSel
        loc_nSel = THIS.pgf_4c_Paginas.Page2.obj_4c_NavPaginas.Value
        IF loc_nSel >= 1 AND loc_nSel <= 12
            THIS.MostrarSubPagina(loc_nSel)
        ENDIF
    ENDPROC

    *===========================================================================
    * CarregarLista - Popula grid com contas do filtro atual
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oPg1, loc_cFiltro, loc_cGrupo, loc_dDtIni, loc_dDtFim

        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_cGrupo = ""
            loc_dDtIni = DATE() - 365
            loc_dDtFim = DATE()

            IF PEMSTATUS(loc_oPg1, "cnt_4c_Filtros", 5)
                IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_Grupo", 5)
                    loc_cGrupo = ALLTRIM(NVL(loc_oPg1.cnt_4c_Filtros.txt_4c_Grupo.Value, ""))
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_DtIni", 5)
                    IF VARTYPE(loc_oPg1.cnt_4c_Filtros.txt_4c_DtIni.Value) = "D"
                        loc_dDtIni = loc_oPg1.cnt_4c_Filtros.txt_4c_DtIni.Value
                    ENDIF
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_DtFim", 5)
                    IF VARTYPE(loc_oPg1.cnt_4c_Filtros.txt_4c_DtFim.Value) = "D"
                        loc_dDtFim = loc_oPg1.cnt_4c_Filtros.txt_4c_DtFim.Value
                    ENDIF
                ENDIF
            ENDIF

            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "a.Grupos = " + EscaparSQL(PADR(loc_cGrupo, 10)) + ;
                    " AND a.DtAlts BETWEEN " + FormatarDataSQL(loc_dDtIni) + ;
                    " AND " + FormatarDataSQL(loc_dDtFim)
                THIS.this_oBusinessObject.BuscarComFiltro(loc_cGrupo, loc_dDtIni, loc_dDtFim)
            ELSE
                loc_cFiltro = "a.DtAlts BETWEEN " + FormatarDataSQL(loc_dDtIni) + ;
                    " AND " + FormatarDataSQL(loc_dDtFim)
                THIS.this_oBusinessObject.Buscar(loc_cFiltro)
            ENDIF

            IF USED("cursor_4c_Dados")
                loc_oPg1.grd_4c_Lista.ColumnCount = 5
                loc_oPg1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                WITH loc_oPg1.grd_4c_Lista
                    .Column1.ControlSource   = "cursor_4c_Dados.IClis"
                    .Column2.ControlSource   = "cursor_4c_Dados.Rclis"
                    .Column3.ControlSource   = "cursor_4c_Dados.Cpfs"
                    .Column4.ControlSource   = "cursor_4c_Dados.Ultcomps"
                    .Column5.ControlSource   = "cursor_4c_Dados.DtAlts"
                    .Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    .Column2.Header1.Caption = "Nome"
                    .Column3.Header1.Caption = "CPF / CNPJ"
                    .Column4.Header1.Caption = CHR(218) + "lt.Compra"
                    .Column5.Header1.Caption = "Alterado em"
                    .Refresh()
                ENDWITH
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (LISTA) e Page2 (DADOS)
    *===========================================================================
    PROCEDURE AlternarPagina(par_cModo)
        THIS.this_cModoAtual = par_cModo

        IF par_cModo = "DADOS"
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.MostrarSubPagina(1)
        ELSE
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.AjustarBotoesPorModo()
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme registros
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemRegistro, loc_oBotoes
        loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
        loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes

        IF PEMSTATUS(loc_oBotoes, "cmd_4c_Visualizar", 5)
            loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
        ENDIF
        IF PEMSTATUS(loc_oBotoes, "cmd_4c_Alterar", 5)
            loc_oBotoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
        ENDIF
        IF PEMSTATUS(loc_oBotoes, "cmd_4c_Excluir", 5)
            loc_oBotoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados dos controles para o BO
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg1, loc_oPg2, loc_oP
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            *-- Sub-pagina 1: Principal
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg1", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg1
                .this_cGrupos   = IIF(PEMSTATUS(loc_oP,"txt_4c_Grupos",5), ALLTRIM(NVL(loc_oP.txt_4c_Grupos.Value,"")), "")
                .this_cIClis    = IIF(PEMSTATUS(loc_oP,"txt_4c_IClis",5), ALLTRIM(NVL(loc_oP.txt_4c_IClis.Value,"")), "")
                .this_cRclis    = IIF(PEMSTATUS(loc_oP,"txt_4c_Rclis",5), ALLTRIM(NVL(loc_oP.txt_4c_Rclis.Value,"")), "")
                .this_cRazaos   = IIF(PEMSTATUS(loc_oP,"txt_4c_Razaos",5), ALLTRIM(NVL(loc_oP.txt_4c_Razaos.Value,"")), "")
                .this_cCpfs     = IIF(PEMSTATUS(loc_oP,"txt_4c_Cpfs",5), ALLTRIM(NVL(loc_oP.txt_4c_Cpfs.Value,"")), "")
                .this_cRgs      = IIF(PEMSTATUS(loc_oP,"txt_4c_Rgs",5), ALLTRIM(NVL(loc_oP.txt_4c_Rgs.Value,"")), "")
                .this_cSituas   = IIF(PEMSTATUS(loc_oP,"txt_4c_Situas",5), ALLTRIM(NVL(loc_oP.txt_4c_Situas.Value,"")), "")
                .this_cInscmuns = IIF(PEMSTATUS(loc_oP,"txt_4c_Inscmuns",5), ALLTRIM(NVL(loc_oP.txt_4c_Inscmuns.Value,"")), "")
                .this_nInativas = IIF(PEMSTATUS(loc_oP,"chk_4c_Inativas",5), IIF(loc_oP.chk_4c_Inativas.Value=1,1,0), 0)
                .this_cCodigos  = IIF(PEMSTATUS(loc_oP,"txt_4c_Codigos",5), ALLTRIM(NVL(loc_oP.txt_4c_Codigos.Value,"")), "")
                .this_cFpags    = IIF(PEMSTATUS(loc_oP,"txt_4c_Fpags",5), ALLTRIM(NVL(loc_oP.txt_4c_Fpags.Value,"")), "")
                .this_cGrupovens = IIF(PEMSTATUS(loc_oP,"txt_4c_Grupovens",5), ALLTRIM(NVL(loc_oP.txt_4c_Grupovens.Value,"")), "")
                .this_dNascs    = IIF(PEMSTATUS(loc_oP,"txt_4c_Nascs",5), NVL(loc_oP.txt_4c_Nascs.Value,{}), {})
                .this_cNacionals = IIF(PEMSTATUS(loc_oP,"txt_4c_Nacionals",5), ALLTRIM(NVL(loc_oP.txt_4c_Nacionals.Value,"")), "")
                .this_cSexos    = IIF(PEMSTATUS(loc_oP,"txt_4c_Sexos",5), ALLTRIM(NVL(loc_oP.txt_4c_Sexos.Value,"")), "")
                .this_cEstcivils = IIF(PEMSTATUS(loc_oP,"cmb_4c_Estcivils",5), ALLTRIM(NVL(loc_oP.cmb_4c_Estcivils.Value,"")), "")
                .this_cConjuges  = IIF(PEMSTATUS(loc_oP,"txt_4c_Conjuges",5), ALLTRIM(NVL(loc_oP.txt_4c_Conjuges.Value,"")), "")
                .this_cCpfcs    = IIF(PEMSTATUS(loc_oP,"txt_4c_Cpfcs",5), ALLTRIM(NVL(loc_oP.txt_4c_Cpfcs.Value,"")), "")
                .this_cRgconjuges = IIF(PEMSTATUS(loc_oP,"txt_4c_Rgconjuges",5), ALLTRIM(NVL(loc_oP.txt_4c_Rgconjuges.Value,"")), "")
                .this_nIdcontas  = IIF(PEMSTATUS(loc_oP,"txt_4c_Idcontas",5), NVL(loc_oP.txt_4c_Idcontas.Value,0), 0)
                .this_cCeps     = IIF(PEMSTATUS(loc_oP,"txt_4c_Ceps",5), ALLTRIM(NVL(loc_oP.txt_4c_Ceps.Value,"")), "")
                .this_cPaises   = IIF(PEMSTATUS(loc_oP,"txt_4c_Paises",5), ALLTRIM(NVL(loc_oP.txt_4c_Paises.Value,"")), "")
                .this_cRegiaos  = IIF(PEMSTATUS(loc_oP,"txt_4c_Regiaos",5), ALLTRIM(NVL(loc_oP.txt_4c_Regiaos.Value,"")), "")
                .this_cEndes    = IIF(PEMSTATUS(loc_oP,"txt_4c_Endes",5), ALLTRIM(NVL(loc_oP.txt_4c_Endes.Value,"")), "")
                .this_cNums     = IIF(PEMSTATUS(loc_oP,"txt_4c_Nums",5), ALLTRIM(NVL(loc_oP.txt_4c_Nums.Value,"")), "")
                .this_cCompls   = IIF(PEMSTATUS(loc_oP,"txt_4c_Compls",5), ALLTRIM(NVL(loc_oP.txt_4c_Compls.Value,"")), "")
                .this_cBairs    = IIF(PEMSTATUS(loc_oP,"txt_4c_Bairs",5), ALLTRIM(NVL(loc_oP.txt_4c_Bairs.Value,"")), "")
                .this_cCidas    = IIF(PEMSTATUS(loc_oP,"txt_4c_Cidas",5), ALLTRIM(NVL(loc_oP.txt_4c_Cidas.Value,"")), "")
                .this_cEstas    = IIF(PEMSTATUS(loc_oP,"txt_4c_Estas",5), ALLTRIM(NVL(loc_oP.txt_4c_Estas.Value,"")), "")
                .this_cDdds     = IIF(PEMSTATUS(loc_oP,"txt_4c_Ddds",5), ALLTRIM(NVL(loc_oP.txt_4c_Ddds.Value,"")), "")
                .this_cTel1s    = IIF(PEMSTATUS(loc_oP,"txt_4c_Tel1s",5), ALLTRIM(NVL(loc_oP.txt_4c_Tel1s.Value,"")), "")
                .this_cTel2s    = IIF(PEMSTATUS(loc_oP,"txt_4c_Tel2s",5), ALLTRIM(NVL(loc_oP.txt_4c_Tel2s.Value,"")), "")
                .this_cFaxs     = IIF(PEMSTATUS(loc_oP,"txt_4c_Faxs",5), ALLTRIM(NVL(loc_oP.txt_4c_Faxs.Value,"")), "")
                .this_cProfiss  = IIF(PEMSTATUS(loc_oP,"txt_4c_Profiss",5), ALLTRIM(NVL(loc_oP.txt_4c_Profiss.Value,"")), "")
                .this_cEmails   = IIF(PEMSTATUS(loc_oP,"txt_4c_Emails",5), ALLTRIM(NVL(loc_oP.txt_4c_Emails.Value,"")), "")
                .this_cContato  = IIF(PEMSTATUS(loc_oP,"txt_4c_Contato",5), ALLTRIM(NVL(loc_oP.txt_4c_Contato.Value,"")), "")
                .this_mObs      = IIF(PEMSTATUS(loc_oP,"edt_4c_Obs",5), NVL(loc_oP.edt_4c_Obs.Value,""), "")
                .this_dDtvals   = IIF(PEMSTATUS(loc_oP,"txt_4c_Dtvals",5), NVL(loc_oP.txt_4c_Dtvals.Value,{}), {})
            ENDIF

            *-- Sub-pagina 2: Comercial
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg2", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg2
                .this_nTpcads   = IIF(PEMSTATUS(loc_oP,"txt_4c_Tpcads",5), NVL(loc_oP.txt_4c_Tpcads.Value,0), 0)
                .this_nTpclis   = IIF(PEMSTATUS(loc_oP,"txt_4c_Tpclis",5), NVL(loc_oP.txt_4c_Tpclis.Value,0), 0)
                .this_cTabds    = IIF(PEMSTATUS(loc_oP,"txt_4c_Tabds",5), ALLTRIM(NVL(loc_oP.txt_4c_Tabds.Value,"")), "")
                .this_cTabd2s   = IIF(PEMSTATUS(loc_oP,"txt_4c_Tabd2s",5), ALLTRIM(NVL(loc_oP.txt_4c_Tabd2s.Value,"")), "")
                .this_cLprecos  = IIF(PEMSTATUS(loc_oP,"txt_4c_Lprecos",5), ALLTRIM(NVL(loc_oP.txt_4c_Lprecos.Value,"")), "")
                .this_nPrazoents = IIF(PEMSTATUS(loc_oP,"txt_4c_Prazoents",5), NVL(loc_oP.txt_4c_Prazoents.Value,0), 0)
                .this_cCodsegs  = IIF(PEMSTATUS(loc_oP,"txt_4c_Codsegs",5), ALLTRIM(NVL(loc_oP.txt_4c_Codsegs.Value,"")), "")
                .this_nLimcres  = IIF(PEMSTATUS(loc_oP,"txt_4c_Limcres",5), NVL(loc_oP.txt_4c_Limcres.Value,0), 0)
                .this_nJuros    = IIF(PEMSTATUS(loc_oP,"txt_4c_Juros",5), NVL(loc_oP.txt_4c_Juros.Value,0), 0)
                .this_nPercdescli = IIF(PEMSTATUS(loc_oP,"txt_4c_Percdescli",5), NVL(loc_oP.txt_4c_Percdescli.Value,0), 0)
                .this_nComis    = IIF(PEMSTATUS(loc_oP,"txt_4c_Comis",5), NVL(loc_oP.txt_4c_Comis.Value,0), 0)
                .this_cGrupocobs = IIF(PEMSTATUS(loc_oP,"txt_4c_Grupocobs",5), ALLTRIM(NVL(loc_oP.txt_4c_Grupocobs.Value,"")), "")
                .this_cGruprods = IIF(PEMSTATUS(loc_oP,"txt_4c_Gruprods",5), ALLTRIM(NVL(loc_oP.txt_4c_Gruprods.Value,"")), "")
                .this_cGrupocents = IIF(PEMSTATUS(loc_oP,"txt_4c_Grupocents",5), ALLTRIM(NVL(loc_oP.txt_4c_Grupocents.Value,"")), "")
                .this_cGrupomats = IIF(PEMSTATUS(loc_oP,"txt_4c_Grupomats",5), ALLTRIM(NVL(loc_oP.txt_4c_Grupomats.Value,"")), "")
                .this_cContacobs = IIF(PEMSTATUS(loc_oP,"txt_4c_Contacobs",5), ALLTRIM(NVL(loc_oP.txt_4c_Contacobs.Value,"")), "")
                .this_cContamats = IIF(PEMSTATUS(loc_oP,"txt_4c_Contamats",5), ALLTRIM(NVL(loc_oP.txt_4c_Contamats.Value,"")), "")
                .this_cContavens = IIF(PEMSTATUS(loc_oP,"txt_4c_Contavens",5), ALLTRIM(NVL(loc_oP.txt_4c_Contavens.Value,"")), "")
                .this_cContaven2s = IIF(PEMSTATUS(loc_oP,"txt_4c_Contaven2s",5), ALLTRIM(NVL(loc_oP.txt_4c_Contaven2s.Value,"")), "")
                .this_cContacents = IIF(PEMSTATUS(loc_oP,"txt_4c_Contacents",5), ALLTRIM(NVL(loc_oP.txt_4c_Contacents.Value,"")), "")
                .this_cConprods = IIF(PEMSTATUS(loc_oP,"txt_4c_Conprods",5), ALLTRIM(NVL(loc_oP.txt_4c_Conprods.Value,"")), "")
                .this_cCcontabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Ccontabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Ccontabs.Value,"")), "")
            ENDIF

            *-- Sub-pagina 3: Bancarios (endcob)
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg3", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg3
                .this_cEndcobs  = IIF(PEMSTATUS(loc_oP,"txt_4c_Endcobs",5), ALLTRIM(NVL(loc_oP.txt_4c_Endcobs.Value,"")), "")
                .this_cCepcobs  = IIF(PEMSTATUS(loc_oP,"txt_4c_Cepcobs",5), ALLTRIM(NVL(loc_oP.txt_4c_Cepcobs.Value,"")), "")
                .this_cCidcobs  = IIF(PEMSTATUS(loc_oP,"txt_4c_Cidcobs",5), ALLTRIM(NVL(loc_oP.txt_4c_Cidcobs.Value,"")), "")
                .this_cEstcobs  = IIF(PEMSTATUS(loc_oP,"txt_4c_Estcobs",5), ALLTRIM(NVL(loc_oP.txt_4c_Estcobs.Value,"")), "")
                .this_cBaicobs  = IIF(PEMSTATUS(loc_oP,"txt_4c_Baicobs",5), ALLTRIM(NVL(loc_oP.txt_4c_Baicobs.Value,"")), "")
                .this_cPaicobs  = IIF(PEMSTATUS(loc_oP,"txt_4c_Paicobs",5), ALLTRIM(NVL(loc_oP.txt_4c_Paicobs.Value,"")), "")
            ENDIF

            *-- Sub-pagina 4: Follow-up (endtrab)
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg4", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg4
                .this_cEndtrabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Endtrabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Endtrabs.Value,"")), "")
                .this_cCeptrabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Ceptrabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Ceptrabs.Value,"")), "")
                .this_cCidtrabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Cidtrabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Cidtrabs.Value,"")), "")
                .this_cEsttrabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Esttrabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Esttrabs.Value,"")), "")
                .this_cBairtrabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Bairtrabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Bairtrabs.Value,"")), "")
                .this_cNumtrabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Numtrabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Numtrabs.Value,"")), "")
                .this_cCompltrabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Compltrabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Compltrabs.Value,"")), "")
                .this_cEmptrabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Emptrabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Emptrabs.Value,"")), "")
                .this_cCnpjtrabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Cnpjtrabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Cnpjtrabs.Value,"")), "")
                .this_cTeltrabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Teltrabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Teltrabs.Value,"")), "")
                .this_cPaitrabs = IIF(PEMSTATUS(loc_oP,"txt_4c_Paitrabs",5), ALLTRIM(NVL(loc_oP.txt_4c_Paitrabs.Value,"")), "")
            ENDIF

            *-- Sub-pagina 5: Conta Corrente (endcos)
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg5", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg5
                .this_cEndcos   = IIF(PEMSTATUS(loc_oP,"txt_4c_Endcos",5), ALLTRIM(NVL(loc_oP.txt_4c_Endcos.Value,"")), "")
                .this_cCepcos   = IIF(PEMSTATUS(loc_oP,"txt_4c_Cepcos",5), ALLTRIM(NVL(loc_oP.txt_4c_Cepcos.Value,"")), "")
                .this_cCidcos   = IIF(PEMSTATUS(loc_oP,"txt_4c_Cidcos",5), ALLTRIM(NVL(loc_oP.txt_4c_Cidcos.Value,"")), "")
                .this_cEstcos   = IIF(PEMSTATUS(loc_oP,"txt_4c_Estcos",5), ALLTRIM(NVL(loc_oP.txt_4c_Estcos.Value,"")), "")
                .this_cBaicos   = IIF(PEMSTATUS(loc_oP,"txt_4c_Baicos",5), ALLTRIM(NVL(loc_oP.txt_4c_Baicos.Value,"")), "")
                .this_cNomecos  = IIF(PEMSTATUS(loc_oP,"txt_4c_Nomecos",5), ALLTRIM(NVL(loc_oP.txt_4c_Nomecos.Value,"")), "")
                .this_cComplcos = IIF(PEMSTATUS(loc_oP,"txt_4c_Complcos",5), ALLTRIM(NVL(loc_oP.txt_4c_Complcos.Value,"")), "")
                .this_nNumcos   = IIF(PEMSTATUS(loc_oP,"txt_4c_Numcos",5), NVL(loc_oP.txt_4c_Numcos.Value,0), 0)
            ENDIF

            *-- Sub-pagina 6: Fiscais
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg6", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg6
                .this_cFpubls   = IIF(PEMSTATUS(loc_oP,"txt_4c_Fpubls",5), ALLTRIM(NVL(loc_oP.txt_4c_Fpubls.Value,"")), "")
                .this_cCfos     = IIF(PEMSTATUS(loc_oP,"txt_4c_Cfos",5), ALLTRIM(NVL(loc_oP.txt_4c_Cfos.Value,"")), "")
                .this_cCodtifs  = IIF(PEMSTATUS(loc_oP,"txt_4c_Codtifs",5), ALLTRIM(NVL(loc_oP.txt_4c_Codtifs.Value,"")), "")
                .this_cTpcps    = IIF(PEMSTATUS(loc_oP,"txt_4c_Tpcps",5), ALLTRIM(NVL(loc_oP.txt_4c_Tpcps.Value,"")), "")
                .this_cRgcs     = IIF(PEMSTATUS(loc_oP,"txt_4c_Rgcs",5), ALLTRIM(NVL(loc_oP.txt_4c_Rgcs.Value,"")), "")
                .this_cPis      = IIF(PEMSTATUS(loc_oP,"txt_4c_Pis",5), ALLTRIM(NVL(loc_oP.txt_4c_Pis.Value,"")), "")
                .this_cMicroemps = IIF(PEMSTATUS(loc_oP,"chk_4c_Microemps",5), IIF(loc_oP.chk_4c_Microemps.Value=1,"S","N"), "N")
                .this_cOptsimples = IIF(PEMSTATUS(loc_oP,"chk_4c_Optsimples",5), IIF(loc_oP.chk_4c_Optsimples.Value=1,"S","N"), "N")
                .this_cSuframas = IIF(PEMSTATUS(loc_oP,"txt_4c_Suframas",5), ALLTRIM(NVL(loc_oP.txt_4c_Suframas.Value,"")), "")
            ENDIF

            *-- Sub-pagina 7: Complemento
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg7", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg7
                .this_cContats  = IIF(PEMSTATUS(loc_oP,"txt_4c_Contats",5), ALLTRIM(NVL(loc_oP.txt_4c_Contats.Value,"")), "")
                .this_cCtelems  = IIF(PEMSTATUS(loc_oP,"txt_4c_Ctelems",5), ALLTRIM(NVL(loc_oP.txt_4c_Ctelems.Value,"")), "")
                .this_cNomearts = IIF(PEMSTATUS(loc_oP,"txt_4c_Nomearts",5), ALLTRIM(NVL(loc_oP.txt_4c_Nomearts.Value,"")), "")
                .this_cEmissors = IIF(PEMSTATUS(loc_oP,"txt_4c_Emissors",5), ALLTRIM(NVL(loc_oP.txt_4c_Emissors.Value,"")), "")
                .this_cSenhas   = IIF(PEMSTATUS(loc_oP,"txt_4c_Senhas",5), ALLTRIM(NVL(loc_oP.txt_4c_Senhas.Value,"")), "")
                .this_nColetors = IIF(PEMSTATUS(loc_oP,"txt_4c_Coletors",5), NVL(loc_oP.txt_4c_Coletors.Value,0), 0)
                .this_nConsignas = IIF(PEMSTATUS(loc_oP,"txt_4c_Consignas",5), NVL(loc_oP.txt_4c_Consignas.Value,0), 0)
                .this_nMasters  = IIF(PEMSTATUS(loc_oP,"txt_4c_Masters",5), NVL(loc_oP.txt_4c_Masters.Value,0), 0)
                .this_nIntconts = IIF(PEMSTATUS(loc_oP,"txt_4c_Intconts",5), NVL(loc_oP.txt_4c_Intconts.Value,0), 0)
                .this_cObspagto = IIF(PEMSTATUS(loc_oP,"txt_4c_Obspagto",5), ALLTRIM(NVL(loc_oP.txt_4c_Obspagto.Value,"")), "")
                .this_cPracas   = IIF(PEMSTATUS(loc_oP,"txt_4c_Pracas",5), ALLTRIM(NVL(loc_oP.txt_4c_Pracas.Value,"")), "")
            ENDIF

            *-- Sub-pagina 8: Empresa
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg8", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg8
                .this_cEmps     = IIF(PEMSTATUS(loc_oP,"txt_4c_Emps",5), ALLTRIM(NVL(loc_oP.txt_4c_Emps.Value,"")), "")
            ENDIF

            *-- Sub-pagina 9: Configuracoes Fiscais (individual por tributo)
            *-- String CfgFisXXs: PADR(Gru,10)+PADR(Cd,10)+PADR(Ds,10)+TRANSFORM(Pct,"99.9")+Rec+Tip+Fin = 37 chars
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg9", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg9
                .this_cCfgFisICs = THIS.MontarCfgFis(loc_oP, "IC")
                .this_cCfgFisIPs = THIS.MontarCfgFis(loc_oP, "IP")
                .this_cCfgFisIIs = THIS.MontarCfgFis(loc_oP, "II")
                .this_cCfgFisISs = THIS.MontarCfgFis(loc_oP, "IS")
                .this_cCfgFisIRs = THIS.MontarCfgFis(loc_oP, "IR")
                .this_cCfgFisINs = THIS.MontarCfgFis(loc_oP, "IN")
                .this_cCfgFisPIs = THIS.MontarCfgFis(loc_oP, "PI")
                .this_cCfgFisCSs = THIS.MontarCfgFis(loc_oP, "CS")
                .this_cCfgFisCOs = THIS.MontarCfgFis(loc_oP, "CO")
            ENDIF

            *-- Sub-pagina 10: Cadastrais (LGPD)
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg10", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg10
                .this_nAutdados = IIF(PEMSTATUS(loc_oP,"chk_4c_Autdados",5), IIF(loc_oP.chk_4c_Autdados.Value=1,1,0), 0)
                .this_nAutemail = IIF(PEMSTATUS(loc_oP,"chk_4c_Autemail",5), IIF(loc_oP.chk_4c_Autemail.Value=1,1,0), 0)
                .this_nAutsms   = IIF(PEMSTATUS(loc_oP,"chk_4c_Autsms",5), IIF(loc_oP.chk_4c_Autsms.Value=1,1,0), 0)
                .this_nAutwhats = IIF(PEMSTATUS(loc_oP,"chk_4c_Autwhats",5), IIF(loc_oP.chk_4c_Autwhats.Value=1,1,0), 0)
                .this_nAutteleg = IIF(PEMSTATUS(loc_oP,"chk_4c_Autteleg",5), IIF(loc_oP.chk_4c_Autteleg.Value=1,1,0), 0)
                .this_cCobs     = IIF(PEMSTATUS(loc_oP,"txt_4c_Cobs",5), ALLTRIM(NVL(loc_oP.txt_4c_Cobs.Value,"")), "")
                .this_dDtcasas  = IIF(PEMSTATUS(loc_oP,"txt_4c_Dtcasas",5), NVL(loc_oP.txt_4c_Dtcasas.Value,{}), {})
                .this_dDtncons  = IIF(PEMSTATUS(loc_oP,"txt_4c_Dtncons",5), NVL(loc_oP.txt_4c_Dtncons.Value,{}), {})
                .this_cMaes     = IIF(PEMSTATUS(loc_oP,"txt_4c_Maes",5), ALLTRIM(NVL(loc_oP.txt_4c_Maes.Value,"")), "")
                .this_cPais     = IIF(PEMSTATUS(loc_oP,"txt_4c_Pais2",5), ALLTRIM(NVL(loc_oP.txt_4c_Pais2.Value,"")), "")
                .this_cGraupares = IIF(PEMSTATUS(loc_oP,"txt_4c_Graupares",5), ALLTRIM(NVL(loc_oP.txt_4c_Graupares.Value,"")), "")
            ENDIF

            *-- Sub-pagina 11: Caracteristicas
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg11", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg11
                .this_nGerbals  = IIF(PEMSTATUS(loc_oP,"chk_4c_Gerbals",5), IIF(loc_oP.chk_4c_Gerbals.Value=1,1,0), 0)
                .this_nPagfals  = IIF(PEMSTATUS(loc_oP,"chk_4c_Pagfals",5), IIF(loc_oP.chk_4c_Pagfals.Value=1,1,0), 0)
                .this_nRecfals  = IIF(PEMSTATUS(loc_oP,"chk_4c_Recfals",5), IIF(loc_oP.chk_4c_Recfals.Value=1,1,0), 0)
                .this_nValemail = IIF(PEMSTATUS(loc_oP,"chk_4c_Valemail",5), IIF(loc_oP.chk_4c_Valemail.Value=1,1,0), 0)
                .this_nInvisivel = IIF(PEMSTATUS(loc_oP,"chk_4c_Invisivel",5), IIF(loc_oP.chk_4c_Invisivel.Value=1,1,0), 0)
                .this_nAptos    = IIF(PEMSTATUS(loc_oP,"chk_4c_Aptos",5), IIF(loc_oP.chk_4c_Aptos.Value=1,1,0), 0)
                .this_nPatrietqs = IIF(PEMSTATUS(loc_oP,"chk_4c_Patrietqs",5), IIF(loc_oP.chk_4c_Patrietqs.Value=1,1,0), 0)
                .this_nRestfors = IIF(PEMSTATUS(loc_oP,"chk_4c_Restfors",5), IIF(loc_oP.chk_4c_Restfors.Value=1,1,0), 0)
                .this_nConsigs  = IIF(PEMSTATUS(loc_oP,"chk_4c_Consigs",5), IIF(loc_oP.chk_4c_Consigs.Value=1,1,0), 0)
                .this_nEan13ents = IIF(PEMSTATUS(loc_oP,"txt_4c_Ean13ents",5), NVL(loc_oP.txt_4c_Ean13ents.Value,0), 0)
                .this_nEan13cobs = IIF(PEMSTATUS(loc_oP,"txt_4c_Ean13cobs",5), NVL(loc_oP.txt_4c_Ean13cobs.Value,0), 0)
            ENDIF

            *-- Sub-pagina 12: Perfil
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg12", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg12
                .this_mPerfils  = IIF(PEMSTATUS(loc_oP,"edt_4c_Perfils",5), NVL(loc_oP.edt_4c_Perfils.Value,""), "")
                .this_mPastas   = IIF(PEMSTATUS(loc_oP,"txt_4c_Pastas",5), ALLTRIM(NVL(loc_oP.txt_4c_Pastas.Value,"")), "")
            ENDIF

            *-- Empresa corrente
            .this_cEmps     = go_4c_Sistema.cCodEmpresa
            .this_cUsualts  = gc_4c_UsuarioLogado
        ENDWITH
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BO para os controles
    *===========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oP
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            *-- Sub-pagina 1
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg1", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg1
                IF PEMSTATUS(loc_oP,"txt_4c_Grupos",5)
                    loc_oP.txt_4c_Grupos.Value = .this_cGrupos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_IClis",5)
                    loc_oP.txt_4c_IClis.Value = .this_cIClis
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Rclis",5)
                    loc_oP.txt_4c_Rclis.Value = .this_cRclis
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Razaos",5)
                    loc_oP.txt_4c_Razaos.Value = .this_cRazaos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Cpfs",5)
                    loc_oP.txt_4c_Cpfs.Value = .this_cCpfs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Rgs",5)
                    loc_oP.txt_4c_Rgs.Value = .this_cRgs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Situas",5)
                    loc_oP.txt_4c_Situas.Value = .this_cSituas
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Inscmuns",5)
                    loc_oP.txt_4c_Inscmuns.Value = .this_cInscmuns
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Inativas",5)
                    loc_oP.chk_4c_Inativas.Value = IIF(.this_nInativas=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Codigos",5)
                    loc_oP.txt_4c_Codigos.Value = .this_cCodigos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Grupovens",5)
                    loc_oP.txt_4c_Grupovens.Value = .this_cGrupovens
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Nascs",5)
                    loc_oP.txt_4c_Nascs.Value = .this_dNascs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Nacionals",5)
                    loc_oP.txt_4c_Nacionals.Value = .this_cNacionals
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Sexos",5)
                    loc_oP.txt_4c_Sexos.Value = .this_cSexos
                ENDIF
                IF PEMSTATUS(loc_oP,"cmb_4c_Estcivils",5)
                    loc_oP.cmb_4c_Estcivils.Value = .this_cEstcivils
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Conjuges",5)
                    loc_oP.txt_4c_Conjuges.Value = .this_cConjuges
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Cpfcs",5)
                    loc_oP.txt_4c_Cpfcs.Value = .this_cCpfcs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Rgconjuges",5)
                    loc_oP.txt_4c_Rgconjuges.Value = .this_cRgconjuges
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Idcontas",5)
                    loc_oP.txt_4c_Idcontas.Value = .this_nIdcontas
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Ceps",5)
                    loc_oP.txt_4c_Ceps.Value = .this_cCeps
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Paises",5)
                    loc_oP.txt_4c_Paises.Value = .this_cPaises
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Regiaos",5)
                    loc_oP.txt_4c_Regiaos.Value = .this_cRegiaos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Endes",5)
                    loc_oP.txt_4c_Endes.Value = .this_cEndes
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Nums",5)
                    loc_oP.txt_4c_Nums.Value = .this_cNums
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Compls",5)
                    loc_oP.txt_4c_Compls.Value = .this_cCompls
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Bairs",5)
                    loc_oP.txt_4c_Bairs.Value = .this_cBairs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Cidas",5)
                    loc_oP.txt_4c_Cidas.Value = .this_cCidas
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Estas",5)
                    loc_oP.txt_4c_Estas.Value = .this_cEstas
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Ddds",5)
                    loc_oP.txt_4c_Ddds.Value = .this_cDdds
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Tel1s",5)
                    loc_oP.txt_4c_Tel1s.Value = .this_cTel1s
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Tel2s",5)
                    loc_oP.txt_4c_Tel2s.Value = .this_cTel2s
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Faxs",5)
                    loc_oP.txt_4c_Faxs.Value = .this_cFaxs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Profiss",5)
                    loc_oP.txt_4c_Profiss.Value = .this_cProfiss
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Emails",5)
                    loc_oP.txt_4c_Emails.Value = .this_cEmails
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Contato",5)
                    loc_oP.txt_4c_Contato.Value = .this_cContato
                ENDIF
                IF PEMSTATUS(loc_oP,"edt_4c_Obs",5)
                    loc_oP.edt_4c_Obs.Value = .this_mObs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Ultcomps",5)
                    loc_oP.txt_4c_Ultcomps.Value = .this_dUltcomps
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Dtvals",5)
                    loc_oP.txt_4c_Dtvals.Value = .this_dDtvals
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Dataincs",5)
                    loc_oP.txt_4c_Dataincs.Value = .this_dDataincs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Dtalts",5)
                    loc_oP.txt_4c_Dtalts.Value = .this_dDtalts
                ENDIF
            ENDIF

            *-- Sub-pagina 2
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg2", 5)
                loc_oP = loc_oPg2.cnt_4c_Pg2
                IF PEMSTATUS(loc_oP,"txt_4c_Tpcads",5)
                    loc_oP.txt_4c_Tpcads.Value = .this_nTpcads
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Tpclis",5)
                    loc_oP.txt_4c_Tpclis.Value = .this_nTpclis
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Tabds",5)
                    loc_oP.txt_4c_Tabds.Value = .this_cTabds
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Tabd2s",5)
                    loc_oP.txt_4c_Tabd2s.Value = .this_cTabd2s
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Lprecos",5)
                    loc_oP.txt_4c_Lprecos.Value = .this_cLprecos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Prazoents",5)
                    loc_oP.txt_4c_Prazoents.Value = .this_nPrazoents
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Codsegs",5)
                    loc_oP.txt_4c_Codsegs.Value = .this_cCodsegs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Limcres",5)
                    loc_oP.txt_4c_Limcres.Value = .this_nLimcres
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Juros",5)
                    loc_oP.txt_4c_Juros.Value = .this_nJuros
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Percdescli",5)
                    loc_oP.txt_4c_Percdescli.Value = .this_nPercdescli
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Comis",5)
                    loc_oP.txt_4c_Comis.Value = .this_nComis
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Grupocobs",5)
                    loc_oP.txt_4c_Grupocobs.Value = .this_cGrupocobs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Gruprods",5)
                    loc_oP.txt_4c_Gruprods.Value = .this_cGruprods
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Grupocents",5)
                    loc_oP.txt_4c_Grupocents.Value = .this_cGrupocents
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Grupomats",5)
                    loc_oP.txt_4c_Grupomats.Value = .this_cGrupomats
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Contacobs",5)
                    loc_oP.txt_4c_Contacobs.Value = .this_cContacobs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Contamats",5)
                    loc_oP.txt_4c_Contamats.Value = .this_cContamats
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Contavens",5)
                    loc_oP.txt_4c_Contavens.Value = .this_cContavens
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Contaven2s",5)
                    loc_oP.txt_4c_Contaven2s.Value = .this_cContaven2s
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Contacents",5)
                    loc_oP.txt_4c_Contacents.Value = .this_cContacents
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Conprods",5)
                    loc_oP.txt_4c_Conprods.Value = .this_cConprods
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Ccontabs",5)
                    loc_oP.txt_4c_Ccontabs.Value = .this_cCcontabs
                ENDIF
            ENDIF

            *-- Sub-paginas 3-12 (mapeamento simplificado)
            IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg3",5)
                loc_oP = loc_oPg2.cnt_4c_Pg3
                IF PEMSTATUS(loc_oP,"txt_4c_Endcobs",5)
                    loc_oP.txt_4c_Endcobs.Value = .this_cEndcobs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Cepcobs",5)
                    loc_oP.txt_4c_Cepcobs.Value = .this_cCepcobs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Cidcobs",5)
                    loc_oP.txt_4c_Cidcobs.Value = .this_cCidcobs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Estcobs",5)
                    loc_oP.txt_4c_Estcobs.Value = .this_cEstcobs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Baicobs",5)
                    loc_oP.txt_4c_Baicobs.Value = .this_cBaicobs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Paicobs",5)
                    loc_oP.txt_4c_Paicobs.Value = .this_cPaicobs
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg4",5)
                loc_oP = loc_oPg2.cnt_4c_Pg4
                IF PEMSTATUS(loc_oP,"txt_4c_Endtrabs",5)
                    loc_oP.txt_4c_Endtrabs.Value = .this_cEndtrabs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Ceptrabs",5)
                    loc_oP.txt_4c_Ceptrabs.Value = .this_cCeptrabs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Cidtrabs",5)
                    loc_oP.txt_4c_Cidtrabs.Value = .this_cCidtrabs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Esttrabs",5)
                    loc_oP.txt_4c_Esttrabs.Value = .this_cEsttrabs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Bairtrabs",5)
                    loc_oP.txt_4c_Bairtrabs.Value = .this_cBairtrabs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Numtrabs",5)
                    loc_oP.txt_4c_Numtrabs.Value = .this_cNumtrabs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Compltrabs",5)
                    loc_oP.txt_4c_Compltrabs.Value = .this_cCompltrabs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Emptrabs",5)
                    loc_oP.txt_4c_Emptrabs.Value = .this_cEmptrabs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Cnpjtrabs",5)
                    loc_oP.txt_4c_Cnpjtrabs.Value = .this_cCnpjtrabs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Teltrabs",5)
                    loc_oP.txt_4c_Teltrabs.Value = .this_cTeltrabs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Paitrabs",5)
                    loc_oP.txt_4c_Paitrabs.Value = .this_cPaitrabs
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg5",5)
                loc_oP = loc_oPg2.cnt_4c_Pg5
                IF PEMSTATUS(loc_oP,"txt_4c_Endcos",5)
                    loc_oP.txt_4c_Endcos.Value = .this_cEndcos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Cepcos",5)
                    loc_oP.txt_4c_Cepcos.Value = .this_cCepcos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Cidcos",5)
                    loc_oP.txt_4c_Cidcos.Value = .this_cCidcos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Estcos",5)
                    loc_oP.txt_4c_Estcos.Value = .this_cEstcos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Baicos",5)
                    loc_oP.txt_4c_Baicos.Value = .this_cBaicos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Nomecos",5)
                    loc_oP.txt_4c_Nomecos.Value = .this_cNomecos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Complcos",5)
                    loc_oP.txt_4c_Complcos.Value = .this_cComplcos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Numcos",5)
                    loc_oP.txt_4c_Numcos.Value = .this_nNumcos
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg6",5)
                loc_oP = loc_oPg2.cnt_4c_Pg6
                IF PEMSTATUS(loc_oP,"txt_4c_Fpubls",5)
                    loc_oP.txt_4c_Fpubls.Value = .this_cFpubls
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Cfos",5)
                    loc_oP.txt_4c_Cfos.Value = .this_cCfos
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Codtifs",5)
                    loc_oP.txt_4c_Codtifs.Value = .this_cCodtifs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Tpcps",5)
                    loc_oP.txt_4c_Tpcps.Value = .this_cTpcps
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Rgcs",5)
                    loc_oP.txt_4c_Rgcs.Value = .this_cRgcs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Pis",5)
                    loc_oP.txt_4c_Pis.Value = .this_cPis
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Microemps",5)
                    loc_oP.chk_4c_Microemps.Value = IIF(ALLTRIM(.this_cMicroemps)="S",1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Optsimples",5)
                    loc_oP.chk_4c_Optsimples.Value = IIF(ALLTRIM(.this_cOptsimples)="S",1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Suframas",5)
                    loc_oP.txt_4c_Suframas.Value = .this_cSuframas
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg7",5)
                loc_oP = loc_oPg2.cnt_4c_Pg7
                IF PEMSTATUS(loc_oP,"txt_4c_Contats",5)
                    loc_oP.txt_4c_Contats.Value = .this_cContats
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Ctelems",5)
                    loc_oP.txt_4c_Ctelems.Value = .this_cCtelems
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Nomearts",5)
                    loc_oP.txt_4c_Nomearts.Value = .this_cNomearts
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Emissors",5)
                    loc_oP.txt_4c_Emissors.Value = .this_cEmissors
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Coletors",5)
                    loc_oP.txt_4c_Coletors.Value = .this_nColetors
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Consignas",5)
                    loc_oP.txt_4c_Consignas.Value = .this_nConsignas
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Masters",5)
                    loc_oP.txt_4c_Masters.Value = .this_nMasters
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Intconts",5)
                    loc_oP.txt_4c_Intconts.Value = .this_nIntconts
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Obspagto",5)
                    loc_oP.txt_4c_Obspagto.Value = .this_cObspagto
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Pracas",5)
                    loc_oP.txt_4c_Pracas.Value = .this_cPracas
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg8",5)
                loc_oP = loc_oPg2.cnt_4c_Pg8
                IF PEMSTATUS(loc_oP,"txt_4c_Emps",5)
                    loc_oP.txt_4c_Emps.Value = .this_cEmps
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Usualts",5)
                    loc_oP.txt_4c_Usualts.Value = .this_cUsualts
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Usuars",5)
                    loc_oP.txt_4c_Usuars.Value = .this_cUsuars
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg9",5)
                loc_oP = loc_oPg2.cnt_4c_Pg9
                THIS.ParsearCfgFis(loc_oP, "IC", .this_cCfgFisICs)
                THIS.ParsearCfgFis(loc_oP, "IP", .this_cCfgFisIPs)
                THIS.ParsearCfgFis(loc_oP, "II", .this_cCfgFisIIs)
                THIS.ParsearCfgFis(loc_oP, "IS", .this_cCfgFisISs)
                THIS.ParsearCfgFis(loc_oP, "IR", .this_cCfgFisIRs)
                THIS.ParsearCfgFis(loc_oP, "IN", .this_cCfgFisINs)
                THIS.ParsearCfgFis(loc_oP, "PI", .this_cCfgFisPIs)
                THIS.ParsearCfgFis(loc_oP, "CS", .this_cCfgFisCSs)
                THIS.ParsearCfgFis(loc_oP, "CO", .this_cCfgFisCOs)
            ENDIF
            IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg10",5)
                loc_oP = loc_oPg2.cnt_4c_Pg10
                IF PEMSTATUS(loc_oP,"chk_4c_Autdados",5)
                    loc_oP.chk_4c_Autdados.Value = IIF(.this_nAutdados=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Autemail",5)
                    loc_oP.chk_4c_Autemail.Value = IIF(.this_nAutemail=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Autsms",5)
                    loc_oP.chk_4c_Autsms.Value = IIF(.this_nAutsms=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Autwhats",5)
                    loc_oP.chk_4c_Autwhats.Value = IIF(.this_nAutwhats=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Autteleg",5)
                    loc_oP.chk_4c_Autteleg.Value = IIF(.this_nAutteleg=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Cobs",5)
                    loc_oP.txt_4c_Cobs.Value = .this_cCobs
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Dtcasas",5)
                    loc_oP.txt_4c_Dtcasas.Value = .this_dDtcasas
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Dtncons",5)
                    loc_oP.txt_4c_Dtncons.Value = .this_dDtncons
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Maes",5)
                    loc_oP.txt_4c_Maes.Value = .this_cMaes
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Pais2",5)
                    loc_oP.txt_4c_Pais2.Value = .this_cPais
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Graupares",5)
                    loc_oP.txt_4c_Graupares.Value = .this_cGraupares
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg11",5)
                loc_oP = loc_oPg2.cnt_4c_Pg11
                IF PEMSTATUS(loc_oP,"chk_4c_Gerbals",5)
                    loc_oP.chk_4c_Gerbals.Value = IIF(.this_nGerbals=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Pagfals",5)
                    loc_oP.chk_4c_Pagfals.Value = IIF(.this_nPagfals=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Recfals",5)
                    loc_oP.chk_4c_Recfals.Value = IIF(.this_nRecfals=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Valemail",5)
                    loc_oP.chk_4c_Valemail.Value = IIF(.this_nValemail=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Invisivel",5)
                    loc_oP.chk_4c_Invisivel.Value = IIF(.this_nInvisivel=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Aptos",5)
                    loc_oP.chk_4c_Aptos.Value = IIF(.this_nAptos=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Patrietqs",5)
                    loc_oP.chk_4c_Patrietqs.Value = IIF(.this_nPatrietqs=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Restfors",5)
                    loc_oP.chk_4c_Restfors.Value = IIF(.this_nRestfors=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"chk_4c_Consigs",5)
                    loc_oP.chk_4c_Consigs.Value = IIF(.this_nConsigs=1,1,0)
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Ean13ents",5)
                    loc_oP.txt_4c_Ean13ents.Value = .this_nEan13ents
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Ean13cobs",5)
                    loc_oP.txt_4c_Ean13cobs.Value = .this_nEan13cobs
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2,"cnt_4c_Pg12",5)
                loc_oP = loc_oPg2.cnt_4c_Pg12
                IF PEMSTATUS(loc_oP,"edt_4c_Perfils",5)
                    loc_oP.edt_4c_Perfils.Value = .this_mPerfils
                ENDIF
                IF PEMSTATUS(loc_oP,"txt_4c_Pastas",5)
                    loc_oP.txt_4c_Pastas.Value = .this_mPastas
                ENDIF
            ENDIF
        ENDWITH
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os controles de entrada
    *===========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPg2, loc_oP
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        *-- Sub-pagina 1
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg1", 5)
            loc_oP = loc_oPg2.cnt_4c_Pg1
            IF PEMSTATUS(loc_oP,"txt_4c_Grupos",5)
                loc_oP.txt_4c_Grupos.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_IClis",5)
                loc_oP.txt_4c_IClis.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Rclis",5)
                loc_oP.txt_4c_Rclis.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Razaos",5)
                loc_oP.txt_4c_Razaos.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Cpfs",5)
                loc_oP.txt_4c_Cpfs.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Rgs",5)
                loc_oP.txt_4c_Rgs.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Situas",5)
                loc_oP.txt_4c_Situas.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"chk_4c_Inativas",5)
                loc_oP.chk_4c_Inativas.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Endes",5)
                loc_oP.txt_4c_Endes.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Ceps",5)
                loc_oP.txt_4c_Ceps.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Cidas",5)
                loc_oP.txt_4c_Cidas.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Estas",5)
                loc_oP.txt_4c_Estas.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Tel1s",5)
                loc_oP.txt_4c_Tel1s.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Emails",5)
                loc_oP.txt_4c_Emails.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"edt_4c_Obs",5)
                loc_oP.edt_4c_Obs.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Dataincs",5)
                loc_oP.txt_4c_Dataincs.Value = {}
            ENDIF
            IF PEMSTATUS(loc_oP,"txt_4c_Dtalts",5)
                loc_oP.txt_4c_Dtalts.Value = {}
            ENDIF
        ENDIF
        *-- Sub-pagina 9: configuracoes fiscais por tributo
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Pg9", 5)
            loc_oP = loc_oPg2.cnt_4c_Pg9
            LOCAL loc_cSfx9, loc_nSfx9, loc_oCtrl9
            LOCAL ARRAY loc_aSfx9[9]
            loc_aSfx9[1] = "IC"
            loc_aSfx9[2] = "IP"
            loc_aSfx9[3] = "II"
            loc_aSfx9[4] = "IS"
            loc_aSfx9[5] = "IR"
            loc_aSfx9[6] = "IN"
            loc_aSfx9[7] = "PI"
            loc_aSfx9[8] = "CS"
            loc_aSfx9[9] = "CO"
            FOR loc_nSfx9 = 1 TO 9
                loc_cSfx9 = loc_aSfx9[loc_nSfx9]
                loc_oCtrl9 = THIS.LocalizarControle(loc_oP, "txt_4c_Gru" + loc_cSfx9)
                IF VARTYPE(loc_oCtrl9) = "O"
                    loc_oCtrl9.Value = ""
                ENDIF
                loc_oCtrl9 = THIS.LocalizarControle(loc_oP, "txt_4c_Cd" + loc_cSfx9)
                IF VARTYPE(loc_oCtrl9) = "O"
                    loc_oCtrl9.Value = ""
                ENDIF
                loc_oCtrl9 = THIS.LocalizarControle(loc_oP, "txt_4c_Ds" + loc_cSfx9)
                IF VARTYPE(loc_oCtrl9) = "O"
                    loc_oCtrl9.Value = ""
                ENDIF
                loc_oCtrl9 = THIS.LocalizarControle(loc_oP, "txt_4c_Pct" + loc_cSfx9)
                IF VARTYPE(loc_oCtrl9) = "O"
                    loc_oCtrl9.Value = 0
                ENDIF
                loc_oCtrl9 = THIS.LocalizarControle(loc_oP, "txt_4c_Rec" + loc_cSfx9)
                IF VARTYPE(loc_oCtrl9) = "O"
                    loc_oCtrl9.Value = ""
                ENDIF
                loc_oCtrl9 = THIS.LocalizarControle(loc_oP, "chk_4c_Tip" + loc_cSfx9)
                IF VARTYPE(loc_oCtrl9) = "O"
                    loc_oCtrl9.Value = 0
                ENDIF
                loc_oCtrl9 = THIS.LocalizarControle(loc_oP, "chk_4c_Fin" + loc_cSfx9)
                IF VARTYPE(loc_oCtrl9) = "O"
                    loc_oCtrl9.Value = 0
                ENDIF
            ENDFOR
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme modo
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_oP, loc_i
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        LOCAL ARRAY loc_aSubPags[12]
        loc_aSubPags[1] = "cnt_4c_Pg1"
        loc_aSubPags[2] = "cnt_4c_Pg2"
        loc_aSubPags[3] = "cnt_4c_Pg3"
        loc_aSubPags[4] = "cnt_4c_Pg4"
        loc_aSubPags[5] = "cnt_4c_Pg5"
        loc_aSubPags[6] = "cnt_4c_Pg6"
        loc_aSubPags[7] = "cnt_4c_Pg7"
        loc_aSubPags[8] = "cnt_4c_Pg8"
        loc_aSubPags[9] = "cnt_4c_Pg9"
        loc_aSubPags[10] = "cnt_4c_Pg10"
        loc_aSubPags[11] = "cnt_4c_Pg11"
        loc_aSubPags[12] = "cnt_4c_Pg12"

        FOR loc_i = 1 TO 12
            IF PEMSTATUS(loc_oPg2, loc_aSubPags[loc_i], 5)
                loc_oP = loc_oPg2.(loc_aSubPags[loc_i])
                LOCAL loc_j
                FOR loc_j = 1 TO loc_oP.ControlCount
                    LOCAL loc_oCtrl
                    loc_oCtrl = loc_oP.Controls(loc_j)
                    IF VARTYPE(loc_oCtrl) = "O" AND ;
                        (PEMSTATUS(loc_oCtrl, "ReadOnly", 5) OR PEMSTATUS(loc_oCtrl, "Value", 5))
                        IF !INLIST(UPPER(loc_oCtrl.Name), ;
                            "TXT_4C_DATAINCS", "TXT_4C_DTALTS", "TXT_4C_ULTCOMPS", ;
                            "TXT_4C_IDCONTAS", "TXT_4C_USUALTS", "TXT_4C_USUARS")
                            IF PEMSTATUS(loc_oCtrl, "Enabled", 5)
                                loc_oCtrl.Enabled = par_lHabilitar
                            ENDIF
                        ENDIF
                    ENDIF
                ENDFOR
            ENDIF
        ENDFOR

        *-- Botoes Salvar/Cancelar sempre habilitados em modo dados
        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            WITH loc_oPg2.cnt_4c_BotoesAcao
                IF PEMSTATUS(.cmd_4c_Confirmar, "Enabled", 5)
                    .cmd_4c_Confirmar.Enabled = .T.
                ENDIF
                IF PEMSTATUS(.cmd_4c_Cancelar, "Enabled", 5)
                    .cmd_4c_Cancelar.Enabled = .T.
                ENDIF
                .Visible     = .T.
            ENDWITH
        ENDIF
    ENDPROC

    *===========================================================================
    * Eventos CRUD - Page 1
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina("DADOS")
        THIS.MostrarSubPagina(1)

        *-- Auto-preenche empresa
        LOCAL loc_oP
        loc_oP = THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg8
        IF PEMSTATUS(loc_oP, "txt_4c_Emps", 5)
            loc_oP.txt_4c_Emps.Value = go_4c_Sistema.cCodEmpresa
        ENDIF
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para visualizar.", "Visualizar")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        LOCAL loc_cCodigo
        loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para visualizar.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina("DADOS")
            THIS.MostrarSubPagina(1)
        ELSE
            MsgAviso("Erro ao carregar conta selecionada.", "Visualizar")
        ENDIF
    ENDPROC

    PROCEDURE BtnAlterarClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para alterar.", "Alterar")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        LOCAL loc_cCodigo
        loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina("DADOS")
            THIS.MostrarSubPagina(1)
        ELSE
            MsgAviso("Erro ao carregar conta para edi" + CHR(231) + CHR(227) + "o.", "Alterar")
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para excluir.", "Excluir")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        LOCAL loc_cCodigo, loc_cNome, loc_lConfirma
        loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
        loc_cNome   = ALLTRIM(NVL(cursor_4c_Dados.Rclis, ""))
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da conta:" + CHR(13) + ;
            loc_cNome + " [" + loc_cCodigo + "] ?", "Excluir Conta")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Conta exclu" + CHR(237) + "da com sucesso.", "Excluir")
                THIS.CarregarLista()
            ELSE
                MsgErro("Erro ao excluir conta:" + CHR(13) + ;
                    THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        ELSE
            MsgErro("Erro ao carregar conta para exclus" + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oPg1, loc_cTerm, loc_oBusca
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Busca por nome/codigo via lookup
        loc_cTerm = ""
        IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_Grupo", 5)
            loc_cTerm = ALLTRIM(NVL(loc_oPg1.cnt_4c_Filtros.txt_4c_Grupo.Value, ""))
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_Busca", "IClis", loc_cTerm, ;
                "Busca de Contas", .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Rclis", "", "Nome")
                loc_oBusca.mAddColuna("Cpfs", "", "CPF/CNPJ")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        LOCAL loc_cSel
                        loc_cSel = ALLTRIM(NVL(cursor_4c_Busca.IClis, ""))
                        USE IN cursor_4c_Busca
                        IF !EMPTY(loc_cSel) AND PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_Grupo", 5)
                            loc_oPg1.cnt_4c_Filtros.txt_4c_Grupo.Value = loc_cSel
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro na busca:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * Eventos CRUD - Page 2
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()
        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Conta salva com sucesso.", "Confirmar")
            THIS.AlternarPagina("LISTA")
        ELSE
            LOCAL loc_cMsg
            loc_cMsg = THIS.this_oBusinessObject.this_cMensagemErro
            IF EMPTY(loc_cMsg)
                loc_cMsg = "Verifique os campos obrigat" + CHR(243) + "rios."
            ENDIF
            MsgAviso(loc_cMsg, "N" + CHR(227) + "o foi poss" + CHR(237) + "vel salvar")
        ENDIF
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina("LISTA")
    ENDPROC

    *===========================================================================
    * KeyPress handlers - Filtros
    *===========================================================================
    PROCEDURE TxtGrupoFiltroKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoFiltro(.F.)
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    PROCEDURE TxtDtIniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    PROCEDURE TxtDtFimKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    PROCEDURE TxtGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoConta()
            RETURN
        ENDIF
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        LOCAL loc_cGrupo, loc_nRet
        loc_cGrupo = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg1.txt_4c_Grupos.Value, ""))
        IF EMPTY(loc_cGrupo)
            RETURN
        ENDIF
        *-- Validar grupo via lookup SigCdGrc
        LOCAL loc_nRet2
        loc_nRet2 = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 codigos, descrs FROM SigCdGrc WHERE codigos = " + ;
            EscaparSQL(PADR(loc_cGrupo, 10)), ;
            "cursor_4c_GrupoValida")
        IF loc_nRet2 > 0 AND RECCOUNT("cursor_4c_GrupoValida") > 0
            SELECT cursor_4c_GrupoValida
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg1.txt_4c_Grupos.Value = ALLTRIM(codigos)
            USE IN cursor_4c_GrupoValida
        ELSE
            IF USED("cursor_4c_GrupoValida")
                USE IN cursor_4c_GrupoValida
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * TxtDGrupoFiltroKeyPress - KeyPress no campo descricao do grupo filtro
    *===========================================================================
    PROCEDURE TxtDGrupoFiltroKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoFiltro(.T.)
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirLookupGrupoFiltro - Abre picker SigCdGcr para filtros (codigo ou descr)
    *===========================================================================
    PROCEDURE AbrirLookupGrupoFiltro(par_lPorDescr)
        LOCAL loc_oFiltros, loc_oLookup, loc_cValorAtual
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oFiltros = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros

            IF par_lPorDescr
                loc_cValorAtual = ALLTRIM(NVL(loc_oFiltros.txt_4c_DGrupo.Value, ""))
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_GrupoFiltro", "Descrs", loc_cValorAtual, ;
                    "Grupo de Contas", .F., .T., "")
            ELSE
                loc_cValorAtual = ALLTRIM(NVL(loc_oFiltros.txt_4c_Grupo.Value, ""))
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_GrupoFiltro", "Codigos", loc_cValorAtual, ;
                    "Grupo de Contas", .F., .T., "")
            ENDIF

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoFiltro")
                    SELECT cursor_4c_GrupoFiltro
                    loc_oFiltros.txt_4c_Grupo.Value  = ALLTRIM(NVL(cursor_4c_GrupoFiltro.Codigos, ""))
                    loc_oFiltros.txt_4c_DGrupo.Value = ALLTRIM(NVL(cursor_4c_GrupoFiltro.Descrs, ""))
                    USE IN cursor_4c_GrupoFiltro
                    THIS.CarregarLista()
                    loc_lResultado = .T.
                ELSE
                    IF USED("cursor_4c_GrupoFiltro")
                        USE IN cursor_4c_GrupoFiltro
                    ENDIF
                ENDIF
                loc_oLookup.Release()
                loc_oLookup = .NULL.
            ENDIF

        CATCH TO loErr
            IF USED("cursor_4c_GrupoFiltro")
                USE IN cursor_4c_GrupoFiltro
            ENDIF
            MsgErro("Erro no lookup de Grupo:" + CHR(13) + loErr.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AbrirLookupGrupoConta - Abre picker SigCdGcr p/ campo Grupos da sub-pag1
    *===========================================================================
    PROCEDURE AbrirLookupGrupoConta()
        LOCAL loc_oPg1Cnt, loc_oLookup, loc_cValorAtual
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPg1Cnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg1
            loc_cValorAtual = ALLTRIM(NVL(loc_oPg1Cnt.txt_4c_Grupos.Value, ""))

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_GrupoContaLkp", "Codigos", loc_cValorAtual, ;
                "Grupo de Contas", .F., .T., "")

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoContaLkp")
                    SELECT cursor_4c_GrupoContaLkp
                    loc_oPg1Cnt.txt_4c_Grupos.Value = ALLTRIM(NVL(cursor_4c_GrupoContaLkp.Codigos, ""))
                    USE IN cursor_4c_GrupoContaLkp
                    loc_lResultado = .T.
                ELSE
                    IF USED("cursor_4c_GrupoContaLkp")
                        USE IN cursor_4c_GrupoContaLkp
                    ENDIF
                ENDIF
                loc_oLookup.Release()
                loc_oLookup = .NULL.
            ENDIF

        CATCH TO loErr
            IF USED("cursor_4c_GrupoContaLkp")
                USE IN cursor_4c_GrupoContaLkp
            ENDIF
            MsgErro("Erro no lookup de Grupo:" + CHR(13) + loErr.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * LookupTaxGrupo - Abre picker SigCdGcr para getCdGrupos das celulas fiscais
    * par_cTrib = sufixo 2 letras (IC, IP, II, IS, IR, IN, PI, CS, CO)
    *===========================================================================
    PROCEDURE LookupTaxGrupo(par_cTrib)
        LOCAL loc_oPg9, loc_oGru, loc_oCd, loc_oDs, loc_oLookup, loc_i
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPg9 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg9
            loc_oGru = .NULL.
            loc_oCd  = .NULL.
            loc_oDs  = .NULL.

            FOR loc_i = 1 TO loc_oPg9.ControlCount
                LOCAL loc_oC
                loc_oC = loc_oPg9.Controls(loc_i)
                DO CASE
                CASE UPPER(loc_oC.Name) = UPPER("txt_4c_Gru" + par_cTrib)
                    loc_oGru = loc_oC
                CASE UPPER(loc_oC.Name) = UPPER("txt_4c_Cd" + par_cTrib)
                    loc_oCd = loc_oC
                CASE UPPER(loc_oC.Name) = UPPER("txt_4c_Ds" + par_cTrib)
                    loc_oDs = loc_oC
                ENDCASE
            ENDFOR

            IF VARTYPE(loc_oGru) != "O"
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_cValor
            loc_cValor = ALLTRIM(NVL(loc_oGru.Value, ""))

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_TaxGruLkp", "Codigos", loc_cValor, ;
                "Grupo Cont" + CHR(225) + "bil - " + par_cTrib, .F., .T., "")

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_TaxGruLkp")
                    SELECT cursor_4c_TaxGruLkp
                    LOCAL loc_cGruSel
                    loc_cGruSel = ALLTRIM(NVL(cursor_4c_TaxGruLkp.Codigos, ""))
                    USE IN cursor_4c_TaxGruLkp
                    loc_oGru.Value = loc_cGruSel
                    IF VARTYPE(loc_oCd) = "O"
                        loc_oCd.Value = ""
                    ENDIF
                    IF VARTYPE(loc_oDs) = "O"
                        loc_oDs.Value = ""
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    IF USED("cursor_4c_TaxGruLkp")
                        USE IN cursor_4c_TaxGruLkp
                    ENDIF
                ENDIF
                loc_oLookup.Release()
                loc_oLookup = .NULL.
            ENDIF

        CATCH TO loErr
            IF USED("cursor_4c_TaxGruLkp")
                USE IN cursor_4c_TaxGruLkp
            ENDIF
            MsgErro("Erro no lookup de Grupo Cont" + CHR(225) + "bil:" + CHR(13) + ;
                loErr.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * LookupTaxConta - Abre picker SigCdCli (filtrado por grupo) para contas fiscais
    * par_lPorDescr: .F.=busca por codigo, .T.=busca por descricao
    *===========================================================================
    PROCEDURE LookupTaxConta(par_cTrib, par_lPorDescr)
        LOCAL loc_oPg9, loc_oGru, loc_oCd, loc_oDs, loc_oLookup, loc_i
        LOCAL loc_lResultado, loc_cSQL, loc_cGrupo, loc_cValor, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_oPg9 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg9
            loc_oGru = .NULL.
            loc_oCd  = .NULL.
            loc_oDs  = .NULL.

            FOR loc_i = 1 TO loc_oPg9.ControlCount
                LOCAL loc_oC2
                loc_oC2 = loc_oPg9.Controls(loc_i)
                DO CASE
                CASE UPPER(loc_oC2.Name) = UPPER("txt_4c_Gru" + par_cTrib)
                    loc_oGru = loc_oC2
                CASE UPPER(loc_oC2.Name) = UPPER("txt_4c_Cd" + par_cTrib)
                    loc_oCd = loc_oC2
                CASE UPPER(loc_oC2.Name) = UPPER("txt_4c_Ds" + par_cTrib)
                    loc_oDs = loc_oC2
                ENDCASE
            ENDFOR

            IF VARTYPE(loc_oGru) != "O" OR VARTYPE(loc_oCd) != "O"
                loc_lResultado = .F.
            ENDIF

            loc_cGrupo = ALLTRIM(NVL(loc_oGru.Value, ""))
            IF EMPTY(loc_cGrupo)
                MsgAviso("Informe primeiro o Grupo Cont" + CHR(225) + "bil.", "Conta")
                loc_lResultado = .F.
            ENDIF

            IF par_lPorDescr
                loc_cValor = ALLTRIM(NVL(loc_oDs.Value, ""))
            ELSE
                loc_cValor = ALLTRIM(NVL(loc_oCd.Value, ""))
            ENDIF

            LOCAL loc_cFiltroGrupo
            loc_cFiltroGrupo = "Grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_TaxContaLkp", "IClis", loc_cValor, ;
                "Conta - " + par_cTrib + " (Grupo: " + ALLTRIM(loc_cGrupo) + ")", ;
                .F., .T., loc_cFiltroGrupo)

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Rclis",  "", "Nome")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_TaxContaLkp")
                    SELECT cursor_4c_TaxContaLkp
                    loc_oCd.Value = ALLTRIM(NVL(cursor_4c_TaxContaLkp.IClis, ""))
                    IF VARTYPE(loc_oDs) = "O"
                        loc_oDs.Value = ALLTRIM(NVL(cursor_4c_TaxContaLkp.Rclis, ""))
                    ENDIF
                    USE IN cursor_4c_TaxContaLkp
                    loc_lResultado = .T.
                ELSE
                    IF USED("cursor_4c_TaxContaLkp")
                        USE IN cursor_4c_TaxContaLkp
                    ENDIF
                ENDIF
                loc_oLookup.Release()
                loc_oLookup = .NULL.
            ENDIF

        CATCH TO loErr
            IF USED("cursor_4c_TaxContaLkp")
                USE IN cursor_4c_TaxContaLkp
            ENDIF
            IF USED("cursor_4c_TaxContaLkp2")
                USE IN cursor_4c_TaxContaLkp2
            ENDIF
            MsgErro("Erro no lookup de Conta:" + CHR(13) + loErr.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * MontarCfgFis - Monta a string composta CfgFisXXs a partir de campos individuais
    * Formato: PADR(Gru,10)+PADR(Cd,10)+PADR(Ds,10)+TRANSFORM(Pct,"99.9")+Rec+Tip+Fin
    *===========================================================================
    PROTECTED PROCEDURE MontarCfgFis(par_oPg9, par_cSfx)
        LOCAL loc_cGru, loc_cCd, loc_cDs, loc_nPct, loc_cRec, loc_nTip, loc_nFin
        loc_cGru = ""
        loc_cCd  = ""
        loc_cDs  = ""
        loc_nPct = 0
        loc_cRec = ""
        loc_nTip = 0
        loc_nFin = 0

        LOCAL loc_oGru2, loc_oCd2, loc_oDs2, loc_oPct2, loc_oRec2, loc_oTip2, loc_oFin2
        loc_oGru2 = THIS.LocalizarControle(par_oPg9, "txt_4c_Gru" + par_cSfx)
        IF VARTYPE(loc_oGru2) = "O"
            loc_cGru = ALLTRIM(NVL(loc_oGru2.Value, ""))
        ENDIF
        loc_oCd2  = THIS.LocalizarControle(par_oPg9, "txt_4c_Cd"  + par_cSfx)
        loc_oDs2  = THIS.LocalizarControle(par_oPg9, "txt_4c_Ds"  + par_cSfx)
        loc_oPct2 = THIS.LocalizarControle(par_oPg9, "txt_4c_Pct" + par_cSfx)
        loc_oRec2 = THIS.LocalizarControle(par_oPg9, "txt_4c_Rec" + par_cSfx)
        loc_oTip2 = THIS.LocalizarControle(par_oPg9, "chk_4c_Tip" + par_cSfx)
        loc_oFin2 = THIS.LocalizarControle(par_oPg9, "chk_4c_Fin" + par_cSfx)

        IF VARTYPE(loc_oCd2)  = "O"
            loc_cCd  = ALLTRIM(NVL(loc_oCd2.Value, ""))
        ENDIF
        IF VARTYPE(loc_oDs2)  = "O"
            loc_cDs  = ALLTRIM(NVL(loc_oDs2.Value, ""))
        ENDIF
        IF VARTYPE(loc_oPct2) = "O"
            loc_nPct = NVL(loc_oPct2.Value, 0)
        ENDIF
        IF VARTYPE(loc_oRec2) = "O"
            loc_cRec = ALLTRIM(NVL(loc_oRec2.Value, ""))
        ENDIF
        IF VARTYPE(loc_oTip2) = "O"
            loc_nTip = IIF(loc_oTip2.Value = 1, 1, 0)
        ENDIF
        IF VARTYPE(loc_oFin2) = "O"
            loc_nFin = IIF(loc_oFin2.Value = 1, 1, 0)
        ENDIF

        RETURN PADR(loc_cGru, 10) + PADR(loc_cCd, 10) + PADR(loc_cDs, 10) + ;
               TRANSFORM(loc_nPct, "99.9") + ;
               LEFT(loc_cRec + " ", 1) + ;
               TRANSFORM(loc_nTip) + TRANSFORM(loc_nFin)
    ENDPROC

    *===========================================================================
    * ParsearCfgFis - Parseia a string CfgFisXXs e preenche os campos individuais
    *===========================================================================
    PROTECTED PROCEDURE ParsearCfgFis(par_oPg9, par_cSfx, par_cStr)
        LOCAL loc_cStr, loc_cGru, loc_cCd, loc_cDs, loc_nPct, loc_cRec, loc_nTip, loc_nFin
        loc_cStr = NVL(par_cStr, "")
        loc_cGru = ALLTRIM(SUBSTR(loc_cStr + SPACE(37), 1,  10))
        loc_cCd  = ALLTRIM(SUBSTR(loc_cStr + SPACE(37), 11, 10))
        loc_cDs  = ALLTRIM(SUBSTR(loc_cStr + SPACE(37), 21, 10))
        loc_nPct = VAL(SUBSTR(loc_cStr + SPACE(37), 31,  4))
        loc_cRec = SUBSTR(loc_cStr + SPACE(37), 36, 1)
        loc_nTip = VAL(SUBSTR(loc_cStr + SPACE(37), 37, 1))

        LOCAL loc_cExtended, loc_nFin2
        loc_cExtended = loc_cStr + SPACE(38)
        loc_nFin2 = VAL(SUBSTR(loc_cExtended, 38, 1))

        LOCAL loc_oGru, loc_oCd, loc_oDs, loc_oPct, loc_oRec, loc_oTip, loc_oFin
        loc_oGru = THIS.LocalizarControle(par_oPg9, "txt_4c_Gru" + par_cSfx)
        loc_oCd  = THIS.LocalizarControle(par_oPg9, "txt_4c_Cd"  + par_cSfx)
        loc_oDs  = THIS.LocalizarControle(par_oPg9, "txt_4c_Ds"  + par_cSfx)
        loc_oPct = THIS.LocalizarControle(par_oPg9, "txt_4c_Pct" + par_cSfx)
        loc_oRec = THIS.LocalizarControle(par_oPg9, "txt_4c_Rec" + par_cSfx)
        loc_oTip = THIS.LocalizarControle(par_oPg9, "chk_4c_Tip" + par_cSfx)
        loc_oFin = THIS.LocalizarControle(par_oPg9, "chk_4c_Fin" + par_cSfx)

        IF VARTYPE(loc_oGru) = "O"
            loc_oGru.Value = loc_cGru
        ENDIF
        IF VARTYPE(loc_oCd)  = "O"
            loc_oCd.Value  = loc_cCd
        ENDIF
        IF VARTYPE(loc_oDs)  = "O"
            loc_oDs.Value  = loc_cDs
        ENDIF
        IF VARTYPE(loc_oPct) = "O"
            loc_oPct.Value = loc_nPct
        ENDIF
        IF VARTYPE(loc_oRec) = "O"
            loc_oRec.Value = loc_cRec
        ENDIF
        IF VARTYPE(loc_oTip) = "O"
            loc_oTip.Value = loc_nTip
        ENDIF
        IF VARTYPE(loc_oFin) = "O"
            loc_oFin.Value = loc_nFin2
        ENDIF
    ENDPROC

    *===========================================================================
    * LocalizarControle - Localiza controle por nome em um container
    *===========================================================================
    PROTECTED PROCEDURE LocalizarControle(par_oContainer, par_cNome)
        LOCAL loc_i, loc_oCtrl
        IF VARTYPE(par_oContainer) != "O"
            RETURN .NULL.
        ENDIF
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF UPPER(loc_oCtrl.Name) = UPPER(par_cNome)
                RETURN loc_oCtrl
            ENDIF
        ENDFOR
        RETURN .NULL.
    ENDPROC

    *===========================================================================
    * KeyPress handlers para campos getCdGrupos dos 9 tributos fiscais
    *===========================================================================
    PROCEDURE TxtGruICKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxGrupo("IC")
        ENDIF
    ENDPROC

    PROCEDURE TxtGruIPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxGrupo("IP")
        ENDIF
    ENDPROC

    PROCEDURE TxtGruIIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxGrupo("II")
        ENDIF
    ENDPROC

    PROCEDURE TxtGruISKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxGrupo("IS")
        ENDIF
    ENDPROC

    PROCEDURE TxtGruIRKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxGrupo("IR")
        ENDIF
    ENDPROC

    PROCEDURE TxtGruINKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxGrupo("IN")
        ENDIF
    ENDPROC

    PROCEDURE TxtGruPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxGrupo("PI")
        ENDIF
    ENDPROC

    PROCEDURE TxtGruCSKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxGrupo("CS")
        ENDIF
    ENDPROC

    PROCEDURE TxtGruCOKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxGrupo("CO")
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPress handlers para campos getCdContas dos 9 tributos fiscais
    *===========================================================================
    PROCEDURE TxtCdICKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("IC", .F.)
        ENDIF
    ENDPROC

    PROCEDURE TxtCdIPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("IP", .F.)
        ENDIF
    ENDPROC

    PROCEDURE TxtCdIIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("II", .F.)
        ENDIF
    ENDPROC

    PROCEDURE TxtCdISKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("IS", .F.)
        ENDIF
    ENDPROC

    PROCEDURE TxtCdIRKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("IR", .F.)
        ENDIF
    ENDPROC

    PROCEDURE TxtCdINKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("IN", .F.)
        ENDIF
    ENDPROC

    PROCEDURE TxtCdPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("PI", .F.)
        ENDIF
    ENDPROC

    PROCEDURE TxtCdCSKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("CS", .F.)
        ENDIF
    ENDPROC

    PROCEDURE TxtCdCOKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("CO", .F.)
        ENDIF
    ENDPROC

    *===========================================================================
    * KeyPress handlers para campos getDsContas dos 9 tributos fiscais
    *===========================================================================
    PROCEDURE TxtDsICKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("IC", .T.)
        ENDIF
    ENDPROC

    PROCEDURE TxtDsIPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("IP", .T.)
        ENDIF
    ENDPROC

    PROCEDURE TxtDsIIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("II", .T.)
        ENDIF
    ENDPROC

    PROCEDURE TxtDsISKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("IS", .T.)
        ENDIF
    ENDPROC

    PROCEDURE TxtDsIRKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("IR", .T.)
        ENDIF
    ENDPROC

    PROCEDURE TxtDsINKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("IN", .T.)
        ENDIF
    ENDPROC

    PROCEDURE TxtDsPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("PI", .T.)
        ENDIF
    ENDPROC

    PROCEDURE TxtDsCSKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("CS", .T.)
        ENDIF
    ENDPROC

    PROCEDURE TxtDsCOKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.LookupTaxConta("CO", .T.)
        ENDIF
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna controles do container visiveis
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF INLIST(UPPER(loc_oControl.Name), ;
                "CNT_4C_CABECALHO", "CNT_4C_PG2", "CNT_4C_PG3", "CNT_4C_PG4", ;
                "CNT_4C_PG5", "CNT_4C_PG6", "CNT_4C_PG7", "CNT_4C_PG8", ;
                "CNT_4C_PG9", "CNT_4C_PG10", "CNT_4C_PG11", "CNT_4C_PG12")
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF
            loc_oControl.Visible = .T.
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos
    *===========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
        IF USED("cursor_4c_GrupoValida")
            USE IN cursor_4c_GrupoValida
        ENDIF
        IF USED("cursor_4c_GrupoFiltro")
            USE IN cursor_4c_GrupoFiltro
        ENDIF
        IF USED("cursor_4c_GrupoContaLkp")
            USE IN cursor_4c_GrupoContaLkp
        ENDIF
        IF USED("cursor_4c_TaxGruLkp")
            USE IN cursor_4c_TaxGruLkp
        ENDIF
        IF USED("cursor_4c_TaxContaLkp")
            USE IN cursor_4c_TaxContaLkp
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
