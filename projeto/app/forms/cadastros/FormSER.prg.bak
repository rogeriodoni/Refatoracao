*==============================================================================
* FormSER.prg - Cadastro de Servicos dos Produtos
* Herda de FormBase
* Tabela: SigPrSer | BO: SERBO
*==============================================================================

DEFINE CLASS FormSER AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    *-- Caption sem acento aqui; definido com CHR() em InicializarForm
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Servicos dos Produtos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de controle
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - Inicializa o formulario (DODEFAULT chama InicializarForm via FormBase)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configuracao completa (chamado por FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Caption com acento correto (CHR nao permitido em DEFINE CLASS)
            THIS.Caption = "Cadastro de Servi" + CHR(231) + "os dos Produtos"

            THIS.this_oBusinessObject = CREATEOBJECT("SERBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SERBO", "FormSER")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria o PageFrame principal com 2 paginas
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
            .Page1.Caption = "Lista"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption = "Dados"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD e grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container Cabecalho (cntSombra no legado)
        * Original: Top=1, Left=-1, Width=1008, Height=80 -> canonico: Top=31
        *----------------------------------------------------------------------
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
            .Caption   = "Cadastro de Servi" + CHR(231) + "os dos Produtos"
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Servi" + CHR(231) + "os dos Produtos"
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Container Botoes CRUD (Grupo_op no legado)
        * Original: Left=544, Top=-1, Width=385, Height=85
        * -> canonico: Left=542, Top=29 (+29 compensacao)
        *----------------------------------------------------------------------
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

        *-- Incluir (Inserir no legado)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Visualizar (Consultar no legado)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Buscar (Procurar no legado)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *----------------------------------------------------------------------
        * Container Saida (Grupo_Saida no legado) - PADRAO CANONICO (CLAUDE.md #10)
        * Original: Left=919, Top=-1 -> canonico PREVALECE: Left=917, Top=29
        *----------------------------------------------------------------------
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * Grid de lista (Grade no legado)
        * Original: Top=121, Left=12, Width=940, Height=470 -> Top=150 (+29)
        * ColumnCount=2 para mostrar apenas Cods e Descs (cIdChaves fica no cursor)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")

        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top         = 150
        loc_oGrid.Left        = 12
        loc_oGrid.Width       = 940
        loc_oGrid.Height      = 470
        loc_oGrid.ColumnCount = 2
        loc_oGrid.RecordSource = ""

        WITH loc_oGrid
            .FontName           = "Tahoma"
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

        WITH loc_oGrid.Column1
            .Width     = 80
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"

        WITH loc_oGrid.Column2
            .Width     = 200
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: campos de edicao e botoes de acao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container Botoes Acao (Grupo_Salva no legado)
        * Original: Left=817, Top=11 -> Top=40 (+29 compensacao)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 40
            .Left        = 817
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Confirmar (Salva no legado)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * Label Codigo (Say1 no legado)
        * Original: Top=141, Left=358 -> Top=170 (+29)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 170
            .Left      = 358
            .Width     = 46
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label Descricao (Say2 no legado)
        * Original: Top=167, Left=345 -> Top=196 (+29)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 196
            .Left      = 345
            .Width     = 59
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label QtDias (Say3 no legado)
        * Original: Top=194, Left=305 -> Top=223 (+29)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_QtDias", "Label")
        WITH loc_oPagina.lbl_4c_QtDias
            .Caption   = "Dias para entrega :"
            .Top       = 223
            .Left      = 305
            .Width     = 99
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Codigo (getCods no legado)
        * Original: Top=137, Left=405, Width=41, Height=24 -> Top=166 (+29)
        * MaxLength=3, Format="K!" -> Format="!" (uppercase; K nao suportado)
        * Habilitado apenas em INCLUIR (getCods.When = InList(pcEscolha,[INSERIR],[PROCURAR]))
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 166
            .Left          = 405
            .Width         = 41
            .Height        = 24
            .MaxLength     = 3
            .Format        = "!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Descricao (getDescs no legado)
        * Original: Top=163, Left=405, Width=282, Height=24 -> Top=192 (+29)
        * MaxLength=30, Format="K!" -> Format="!" (uppercase)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 192
            .Left          = 405
            .Width         = 282
            .Height        = 24
            .MaxLength     = 30
            .Format        = "!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox QtDias (getQtDias no legado)
        * Original: Top=190, Left=405, Width=41, Height=24 -> Top=219 (+29)
        * InputMask="999" (numerico 3 digitos), campo numeric
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_QtDias", "TextBox")
        WITH loc_oPagina.txt_4c_QtDias
            .Value         = 0
            .Top           = 219
            .Left          = 405
            .Width         = 41
            .Height        = 24
            .MaxLength     = 3
            .InputMask     = "999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Quantidade de dias para entrega do servi" + CHR(231) + "o."
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1 a partir do BO
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (cIdChaves C(20), Cods C(3), Descs C(30), qtDias N(3,0))
                    APPEND BLANK
                ENDIF
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    *-- RecordSource ANTES de ControlSource (Problem #48)
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descs"
                    *-- Width e Headers APOS ControlSource (Problem #32)
                    loc_oGrid.Column1.Width = 80
                    loc_oGrid.Column2.Width = 200
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do Form para o BO antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_nQtDias    = loc_oPagina.txt_4c_QtDias.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para o Form apos carregar
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        loc_oPagina.txt_4c_QtDias.Value    = THIS.this_oBusinessObject.this_nQtDias
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ""
        loc_oPagina.txt_4c_Descricao.Value = ""
        loc_oPagina.txt_4c_QtDias.Value    = 0
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao
    * getCods.When = InList(pcEscolha,[INSERIR],[PROCURAR])
    * -> txt_4c_Codigo habilitado apenas em INCLUIR
    * Confirmar.Enabled usa padrao Erro140 (EXCLUIR tambem precisa confirmar)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lConfirmar
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Codigo habilitado apenas em INCLUIR (When do getCods no legado)
        loc_oPagina.txt_4c_Codigo.Enabled    = par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR"
        loc_oPagina.txt_4c_Descricao.Enabled = par_lHabilitar
        loc_oPagina.txt_4c_QtDias.Enabled    = par_lHabilitar

        *-- Confirmar: habilitado em edicao OU em EXCLUIR (nao usar = 6, retorna LOGICAL)
        loc_lConfirmar = par_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lConfirmar
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Estado dos botoes conforme this_cModoAtual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_cModoAtual = "VISUALIZAR"
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ELSE
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCampos - Valida campos obrigatorios antes de salvar
    * Replica validacoes de Salva.Click do legado (Codigo e Descricao obrigatorios)
    *==========================================================================
    PROTECTED PROCEDURE ValidarCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Codigo.Value))
                MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_oPagina.txt_4c_Codigo.SetFocus()
                RETURN .F.
            ENDIF

            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Descricao.Value))
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_oPagina.txt_4c_Descricao.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Click no botao Incluir
    * Modo: INCLUIR, foco em txt_4c_Codigo (getCods.SetFocus no legado)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Click no botao Visualizar
    * Modo: VISUALIZAR, foco em cmd_4c_Confirmar (Grupo_Salva.Salva.SetFocus)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.Cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Click no botao Alterar
    * Modo: ALTERAR, foco em txt_4c_Descricao (getDescs.SetFocus no legado)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.Cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Click no botao Excluir
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.Cods)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                THIS.CarregarLista()
            ELSE
                MsgErro("Erro ao excluir o registro.", "Excluir")
            ENDIF
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Excluir")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Click no botao Buscar
    * Equivalente ao msv_procurar do legado: recarrega lista
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Click no botao Encerrar
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Click no botao Confirmar
    * Replica Salva.Click do legado: valida, salva via BO, volta para lista
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- Validacoes FORA do TRY (CLAUDE.md Regra Critica)
        IF !THIS.ValidarCampos()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Salvar")
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao salvar o registro.", "Salvar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Click no botao Cancelar
    * Replica Cancelar.Click: se plCancelar -> mAtivaPagina1 (retorna para lista)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Itera Pages de PageFrames E Controls de Containers
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
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
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
