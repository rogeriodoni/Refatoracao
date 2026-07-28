*==============================================================================
* FormCES.prg - Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Estoque
* Tabela: SigCdCle | PK: cidchaves | Busca: clacods
* Fase 8/8 - COMPLETO
*==============================================================================

DEFINE CLASS FormCES AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Estoque"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formul?rio
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loException
            MsgErro("Erro em FormCES.Init:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CESBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar CESBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCES.InicializarForm:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 p&#225;ginas
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
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabe&#231;alho + containers de bot&#245;es
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabe&#231;alho cinza escuro (cntSombra do legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Estoque"
            .Top       = 15
            .Left      = 12
            .Width     = THIS.Width
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
            .Caption   = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Estoque"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container de bot&#245;es CRUD (lado direito) - bot&#245;es adicionados na Fase 4
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Container Encerrar (can&#244;nico - posi&#231;&#227;o fixa Left=917)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Grid de listagem: clacods, clagrupos, clacontas, setors
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 127
            .Left               = 30
            .Width              = 939
            .Height             = 487
            .ColumnCount        = 4
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
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: container Salvar/Cancelar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salvar/Cancelar (Grupo_Salva do legado)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label: C&#243;digo (Say2 do legado - Top=190+29=219, Left=411)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 219
            .Left      = 411
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox: C&#243;digo (Get_codigo do legado - Top=186+29=215, Left=455, Width=132, Height=23)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 215
            .Left          = 455
            .Width         = 132
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .MaxLength     = 20
            .Visible       = .T.
        ENDWITH

        *-- Label: Grupo (Say1 do legado - Top=215+29=244, Left=415)
        loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPagina.lbl_4c_Grupo
            .Caption   = "Grupo :"
            .Top       = 244
            .Left      = 415
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Grupo (Get_Grupo do legado - Top=211+29=240, Left=455, Width=80)
        *-- Lookup em SigCdGcr (codigos) via LostFocus
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value         = ""
            .Top           = 240
            .Left          = 455
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .MaxLength     = 15
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "GrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick",  THIS, "GrupoDblClick")

        *-- Label: Conta (Say3 do legado - Top=241+29=270, Left=415)
        loc_oPagina.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPagina.lbl_4c_Conta
            .Caption   = "Conta :"
            .Top       = 270
            .Left      = 415
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Conta (get_Conta do legado - Top=236+29=265, Left=455, Width=80)
        *-- Lookup em SigCdCli (iclis) via LostFocus/F4/DblClick
        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Value         = ""
            .Top           = 265
            .Left          = 455
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .MaxLength     = 15
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress",  THIS, "ContaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Conta, "DblClick",  THIS, "ContaDblClick")

        *-- Label: Setor (Say4 do legado - Top=265+29=294, Left=418)
        loc_oPagina.AddObject("lbl_4c_Setor", "Label")
        WITH loc_oPagina.lbl_4c_Setor
            .Caption   = "Setor :"
            .Top       = 294
            .Left      = 418
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Setor (Get_Setor do legado - Top=261+29=290, Left=455, Width=80)
        *-- Lookup em SigCdGcr (Codigos) via LostFocus/F4/DblClick
        loc_oPagina.AddObject("txt_4c_Setor", "TextBox")
        WITH loc_oPagina.txt_4c_Setor
            .Value         = ""
            .Top           = 290
            .Left          = 455
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .MaxLength     = 15
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_Setor, "KeyPress", THIS, "ValidarSetor")
        BINDEVENT(loc_oPagina.txt_4c_Setor, "KeyPress",  THIS, "SetorKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Setor, "DblClick",  THIS, "SetorDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid (grid conectado na Fase 4)
    *==========================================================================
    PROCEDURE CarregarLista(par_cFiltro)
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                CREATE CURSOR cursor_4c_Dados (cidchaves C(20), clacods C(15), clagrupos C(10), clacontas C(10), setors C(10))
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar(par_cFiltro)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 4
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 4

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.clacods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.clagrupos"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.clacontas"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.setors"

                    loc_oGrid.Column1.Width = 80
                    loc_oGrid.Column2.Width = 80
                    loc_oGrid.Column3.Width = 80
                    loc_oGrid.Column4.Width = 80

                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Grupo"
                    loc_oGrid.Column3.Header1.Caption = "Conta"
                    loc_oGrid.Column4.Header1.Caption = "Setor"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCES.CarregarLista:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (1) e Page2 (2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FormCES.AlternarPagina:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Descarta edi&#231;&#227;o e volta para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Percorre controles recursivamente
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
    * FormatarGridLista - Fonte padr&#227;o Tahoma/8 para o grid
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara modo INCLUIR e navega para Page2
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo somente-leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado e habilita edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Confirma e exclui o registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar e filtra a lista pelo codigo
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cFiltro, loc_cCodigo
        loc_cFiltro = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCle", "cursor_4c_BuscaCes", "clacods", "", ;
                "Buscar Classifica" + CHR(231) + CHR(227) + "o de Estoque")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("clacods",   "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("clagrupos", "", "Grupo")
                    loc_oBusca.mAddColuna("clacontas", "", "Conta")
                    loc_oBusca.mAddColuna("setors",    "", "Setor")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCes")
                    SELECT cursor_4c_BuscaCes
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCes.clacods)
                    IF !EMPTY(loc_cCodigo)
                        loc_cFiltro = "clacods = " + EscaparSQL(loc_cCodigo)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCes")
                USE IN cursor_4c_BuscaCes
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCES.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        THIS.CarregarLista(loc_cFiltro)
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva o registro (botao Confirmar da Page2)
    * Valida&#231;&#227;o: Grupo n&#227;o pode ficar em branco (regra do legado)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPagina.txt_4c_Grupo.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()
        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Sucesso")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos da Page2 para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        THIS.this_oBusinessObject.this_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cConta  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
        THIS.this_oBusinessObject.this_cSetor  = ALLTRIM(loc_oPagina.txt_4c_Setor.Value)
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cGrupo)
        loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cConta)
        loc_oPagina.txt_4c_Setor.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cSetor)
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oPagina.txt_4c_Codigo.Value = ""
        loc_oPagina.txt_4c_Grupo.Value  = ""
        loc_oPagina.txt_4c_Conta.Value  = ""
        loc_oPagina.txt_4c_Setor.Value  = ""
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme o modo atual
    * INCLUIR  -> Codigo, Grupo, Conta, Setor: editaveis
    * ALTERAR  -> Conta, Setor: editaveis; Codigo, Grupo: somente-leitura
    * VISUALIZAR/EXCLUIR -> todos somente-leitura
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEditarCodGrp, loc_lEditarContaSeto
        loc_oPagina          = THIS.pgf_4c_Paginas.Page2
        loc_lEditarCodGrp    = (THIS.this_cModoAtual = "INCLUIR")
        loc_lEditarContaSeto = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND par_lHabilitar

        loc_oPagina.txt_4c_Codigo.ReadOnly = !loc_lEditarCodGrp
        loc_oPagina.txt_4c_Grupo.ReadOnly  = !loc_lEditarCodGrp
        loc_oPagina.txt_4c_Conta.ReadOnly  = !loc_lEditarContaSeto
        loc_oPagina.txt_4c_Setor.ReadOnly  = !loc_lEditarContaSeto

        loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditarContaSeto OR loc_lEditarCodGrp
        loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *==========================================================================
    * ValidarGrupo - Lookup em SigCdGcr (LostFocus de txt_4c_Grupo)
    * Original: Get_Grupo.Valid com fwBuscaExt em SigCdGcr/Codigos
    *==========================================================================
    PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cGrupo, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        IF EMPTY(loc_cGrupo)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
                "Grupos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                    SELECT cursor_4c_BuscaGrupo
                    loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCES.ValidarGrupo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrupoKeyPress / GrupoDblClick / AbrirLookupGrupo
    * Lookup em SigCdGcr via F4 e DblClick
    *==========================================================================
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    PROCEDURE GrupoDblClick()
        THIS.AbrirLookupGrupo()
    ENDPROC

    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oPagina, loc_cGrupo, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        IF loc_oPagina.txt_4c_Grupo.ReadOnly
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
                "Grupos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                    SELECT cursor_4c_BuscaGrupo
                    loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCES.AbrirLookupGrupo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarConta - LostFocus: lookup em SigCdCli (iclis/rclis/grupos)
    * Original: get_Conta.Valid com fwBuscaExt em SigCdCli/iclis
    *==========================================================================
    PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cConta, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)

        IF EMPTY(loc_cConta)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "iclis", loc_cConta, ;
                "Contas")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("grupos", "", "Grupo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCES.ValidarConta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ContaKeyPress / ContaDblClick / AbrirLookupConta
    * Lookup em SigCdCli via F4 e DblClick
    *==========================================================================
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    PROCEDURE ContaDblClick()
        THIS.AbrirLookupConta()
    ENDPROC

    PROCEDURE AbrirLookupConta()
        LOCAL loc_oPagina, loc_cConta, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)

        IF loc_oPagina.txt_4c_Conta.ReadOnly
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "iclis", loc_cConta, ;
                "Contas")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("grupos", "", "Grupo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCES.AbrirLookupConta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarSetor - LostFocus: lookup em SigCdGcr (Codigos/Descrs)
    * Original: Get_Setor.Valid com fwBuscaExt em SigCdGcr/Codigos
    *==========================================================================
    PROCEDURE ValidarSetor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cSetor, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cSetor  = ALLTRIM(loc_oPagina.txt_4c_Setor.Value)

        IF EMPTY(loc_cSetor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaSetor", "Codigos", loc_cSetor, ;
                "Grupos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSetor")
                    SELECT cursor_4c_BuscaSetor
                    loc_oPagina.txt_4c_Setor.Value = ALLTRIM(cursor_4c_BuscaSetor.Codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaSetor")
                USE IN cursor_4c_BuscaSetor
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCES.ValidarSetor:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SetorKeyPress / SetorDblClick / AbrirLookupSetor
    * Lookup em SigCdGcr via F4 e DblClick
    *==========================================================================
    PROCEDURE SetorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupSetor()
        ENDIF
    ENDPROC

    PROCEDURE SetorDblClick()
        THIS.AbrirLookupSetor()
    ENDPROC

    PROCEDURE AbrirLookupSetor()
        LOCAL loc_oPagina, loc_cSetor, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cSetor  = ALLTRIM(loc_oPagina.txt_4c_Setor.Value)

        IF loc_oPagina.txt_4c_Setor.ReadOnly
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaSetor", "Codigos", loc_cSetor, ;
                "Grupos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSetor")
                    SELECT cursor_4c_BuscaSetor
                    loc_oPagina.txt_4c_Setor.Value = ALLTRIM(cursor_4c_BuscaSetor.Codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaSetor")
                USE IN cursor_4c_BuscaSetor
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormCES.AbrirLookupSetor:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes de Page2 conforme modo
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oSalva
        loc_oSalva = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva

        TRY
            loc_oSalva.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oSalva.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loException
            MsgErro("Erro em FormCES.AjustarBotoesPorModo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
