*==============================================================================
* FormOCS.prg - Cadastro de Ocasi??o
* Tabela: SigCdOcs
* Migrado de: SIGCDOCS.SCX
*==============================================================================

DEFINE CLASS FormOCS AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de controle
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - Inicializa o formulario via FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao estrutural chamada pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Cadastro de Ocasi" + CHR(227) + "o"

            THIS.this_oBusinessObject = CREATEOBJECT("OCSBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar OCSBO", "FormOCS.InicializarForm")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormOCS.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
    *--------------------------------------------------------------------------
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
            .Page1.Caption = "Lista"
            .Page2.Caption = "Dados"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e botoes CRUD
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho com titulo do formulario
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 31
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 15
            .Left      = 12
            .Width     = THIS.Width - 31
            .Height    = 40
            .Caption   = "Cadastro de Ocasi" + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 31
            .Height    = 46
            .Caption   = "Cadastro de Ocasi" + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (lado direito, sobre o cabecalho)
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

        *-- Botao Visualizar
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

        *-- Botao Alterar
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

        *-- Container Encerrar (canto direito, transparente, flutuante)
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

        *-- Grid de listagem
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 2

        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 450
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

        WITH loc_oGrid.Column1
            .Width           = 90
            .Alignment       = 0
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH

        WITH loc_oGrid.Column2
            .Width           = 337
            .Alignment       = 0
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- BINDEVENTs para botoes CRUD
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados): botoes + campos Parte 1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (original: Grupo_Salva top=4, left=842)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
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

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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

        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label Codigo (Say1: original top=124, left=215; compensado +29)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 153
            .Left      = 215
            .Width     = 48
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_codigo: original top=121, left=263, w=72, h=23; compensado +29)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top           = 150
            .Left          = 263
            .Width         = 72
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 0
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Descricao (Say2: original top=149, left=202; compensado +29)
        loc_oPagina.AddObject("lbl_4c_Desc", "Label")
        WITH loc_oPagina.lbl_4c_Desc
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 178
            .Left      = 202
            .Width     = 61
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (Get_desc: original top=146, left=263, w=240, h=23; compensado +29)
        loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPagina.txt_4c_Desc
            .Top           = 175
            .Left          = 263
            .Width         = 240
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .MaxLength     = 40
            .SpecialEffect = 0
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oObjeto

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

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formatacao visual do grid de lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (cods C(10), descs C(40))
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource            = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.cods"
                loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descs"
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column1.Width           = 90
                loc_oGrid.Column2.Width           = 337
                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormOCS.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inclui novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ELSE
            MsgErro("Erro ao carregar registro.", "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Altera registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.ReadOnly = .T.
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.txt_4c_Desc.SetFocus
        ELSE
            MsgErro("Erro ao carregar registro.", "Alterar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo   = ""
        loc_lConfirma = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        loc_lConfirma = MsgConfirma("Confirmar exclus" + CHR(227) + "o do registro" + ;
            " '" + loc_cCodigo + "'?", "Excluir")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
                THIS.CarregarLista()
            ELSE
                MsgErro("Erro ao excluir registro.", "Excluir")
            ENDIF
        ELSE
            MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", "Excluir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Busca registro via FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo, loc_lSelecionou
        loc_lSelecionou = .F.
        loc_cCodigo     = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOcs", "cursor_4c_Busca", "cods", "", ;
                "Buscar Ocasi" + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                loc_lSelecionou = loc_oBusca.this_lSelecionou
                IF loc_lSelecionou AND USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    loc_cCodigo = ALLTRIM(cursor_4c_Busca.cods)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormOCS.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF

        IF loc_lSelecionou AND !EMPTY(loc_cCodigo)
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos da Page2 para nova inclusao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_Codigo.Value = ""
            .txt_4c_Desc.Value   = ""
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos da Page2 conforme o modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lCodigoEditavel
        loc_lCodigoEditavel = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_Codigo.ReadOnly = !loc_lCodigoEditavel
            .txt_4c_Desc.ReadOnly   = !par_lHabilitar
        ENDWITH

        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme o modo
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        DO CASE
        CASE THIS.this_cModoAtual = "VISUALIZAR"
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
            loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
        CASE THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .T.
            loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
        OTHERWISE
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
            loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega dados do BO nos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
            .txt_4c_Desc.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados dos campos da Page2 para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.pgf_4c_Paginas.Page2
            THIS.this_oBusinessObject.this_cCods  = ALLTRIM(.txt_4c_Codigo.Value)
            THIS.this_oBusinessObject.this_cDescs = ALLTRIM(.txt_4c_Desc.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva o registro (Inserir ou Atualizar via BO)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        *-- Validacoes fora do TRY (REGRA CRITICA)
        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio.", "Confirmar")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
            RETURN
        ENDIF

        THIS.FormParaBO()

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.Salvar()
            IF loc_lSucesso
                MsgInfo("Registro salvo com sucesso.", "Confirmar")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormOCS.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
