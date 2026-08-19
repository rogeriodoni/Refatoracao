*==============================================================================
* Formmpp.prg - Formulario Cadastro de Complementos de Caracteristicas
* Tabela   : SigPrCpP
* BO       : mppBO
* Tipo     : 0=Produtos  1=Contas  2=Movimentacoes
*             (par_cTipo: 'C'=Contas, outro char=Movimentacoes, vazio=Produtos)
*==============================================================================

DEFINE CLASS Formmpp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Complementos de Caracteristicas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Tipo de complemento: 0=Produtos  1=Contas  2=Movimentacoes
    this_nTipo = 0

    *--------------------------------------------------------------------------
    * Init - Recebe par_cTipo ('C'=Contas, outro char=Movimentacoes, vazio=Produtos)
    *        Define this_nTipo e Caption ANTES de DODEFAULT (que chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_cTipo

        IF VARTYPE(par_cTipo) = "C"
            DO CASE
            CASE par_cTipo == "C"
                THIS.this_nTipo = 1
            CASE !EMPTY(ALLTRIM(par_cTipo))
                THIS.this_nTipo = 2
            OTHERWISE
                THIS.this_nTipo = 0
            ENDCASE
        ELSE
            IF VARTYPE(par_cTipo) = "N"
            THIS.this_nTipo = INT(par_cTipo)
        ELSE
            THIS.this_nTipo = 0
            ENDIF
        ENDIF

        DO CASE
        CASE THIS.this_nTipo = 1
            THIS.Caption = "Complementos de Caracter" + CHR(237) + "sticas de Contas"
        CASE THIS.this_nTipo = 2
            THIS.Caption = "Complementos de Caracter" + CHR(237) + ;
                "sticas de Movimenta" + CHR(231) + CHR(245) + "es"
        OTHERWISE
            THIS.Caption = "Cadastro de Complementos de Caracteristicas de Produtos"
        ENDCASE

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e estrutura visual completa do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("mppBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar mppBO", "Erro")
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
            MsgErro("Erro em Formmpp.InicializarForm:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPf, loc_oPg1, loc_oPg2

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPf = THIS.pgf_4c_Paginas

        loc_oPf.Top       = -29
        loc_oPf.Left      = 0
        loc_oPf.Height    = 629
        loc_oPf.Width     = THIS.Width
        loc_oPf.PageCount = 2
        loc_oPf.Tabs      = .F.
        loc_oPf.TabStop   = .F.

        loc_oPg1 = loc_oPf.Page1
        loc_oPg1.Caption   = "Lista"
        loc_oPg1.BackColor = RGB(255, 255, 255)
        loc_oPg1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPg2 = loc_oPf.Page2
        loc_oPg2.Caption   = "Dados"
        loc_oPg2.BackColor = RGB(255, 255, 255)
        loc_oPg2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPf.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid de lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBtns, loc_oSaida, loc_oGrid

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho escuro com titulo do form
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 31
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
        ENDWITH
        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 10
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH
        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 10
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH
        loc_oCab.Visible = .T.

        *-- Container de botoes CRUD (Incluir, Visualizar, Alterar, Excluir, Buscar)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBtns = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBtns
            .Top           = 29
            .Left          = 542
            .Width         = 375
            .Height        = 85
            .BackStyle     = 1
            .BackColor     = RGB(53, 53, 53)
            .BorderWidth   = 0
            .SpecialEffect = 0
        ENDWITH

        loc_oBtns.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBtns.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBtns.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oBtns.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBtns.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBtns.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oBtns.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBtns.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBtns.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oBtns.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBtns.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBtns.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oBtns.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBtns.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBtns.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
        loc_oBtns.Visible = .T.

        *-- Container de saida com botao Encerrar (canonico left=917)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top           = 29
            .Left          = 917
            .Width         = 90
            .Height        = 85
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
        ENDWITH
        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
        loc_oSaida.Visible = .T.

        *-- Grid de lista (Codigos + Descrs)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        loc_oGrid.Top             = 117
        loc_oGrid.Left            = 26
        loc_oGrid.Width           = 890
        loc_oGrid.Height          = 498
        loc_oGrid.ColumnCount     = 2
        WITH loc_oGrid
            .FontName             = "Verdana"
            .FontSize             = 8
            .ForeColor            = RGB(90, 90, 90)
            .BackColor            = RGB(255, 255, 255)
            .GridLineColor        = RGB(238, 238, 238)
            .HighlightBackColor   = RGB(255, 255, 255)
            .HighlightForeColor   = RGB(15, 41, 104)
            .HighlightStyle       = 2
            .DeleteMark           = .F.
            .RecordMark           = .F.
            .RowHeight            = 16
            .ScrollBars           = 2
            .GridLines            = 3
            .ReadOnly             = .T.
            .Column1.Width        = 120
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Width        = 400
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Visible              = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar e campos (Parte 1)
    *   Campos: lbl_4c_Label1 (Codigo) + txt_4c_Codigos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oSalva

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container Confirmar/Cancelar (canonico: Top=33, Left=842, Width=160, Height=85)
        loc_oPg2.AddObject("cnt_4c_Salva", "Container")
        loc_oSalva = loc_oPg2.cnt_4c_Salva
        WITH loc_oSalva
            .Top           = 33
            .Left          = 842
            .Width         = 160
            .Height        = 85
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
        ENDWITH

        loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
        loc_oSalva.Visible = .T.

        *-- Label "Código :" (Say1 - top=187+29=216, left=339)
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 216
            .Left      = 339
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigos (getCodigos - top=184+29=213, left=383, width=150)
        loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPg2.txt_4c_Codigos
            .Value         = ""
            .Top           = 213
            .Left          = 383
            .Width         = 150
            .Height        = 23
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label "Descrição :" (Say2 - top=212+29=241, left=326)
        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 241
            .Left      = 326
            .Width     = 65
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descrs (getDescrs - top=209+29=238, left=383, width=290)
        loc_oPg2.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPg2.txt_4c_Descrs
            .Value         = ""
            .Top           = 238
            .Left          = 383
            .Width         = 290
            .Height        = 23
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega cursor_4c_Dados no grid filtrando por tipo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (CidChaves C(20), Codigos C(20), Descrs C(40), nTipos N(1))
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF !THIS.this_oBusinessObject.Buscar("", THIS.this_nTipo)
                loc_lResultado = .F.
            ELSE
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                THIS.FormatarGridLista(loc_oGrid)
                THIS.AjustarBotoesPorModo()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formmpp.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual padrao no grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigos
        loc_cCodigos = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)

        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigosETipo(loc_cCodigos, THIS.this_nTipo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar registro selecionado.", "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Altera registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigos
        loc_cCodigos = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)

        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigosETipo(loc_cCodigos, THIS.this_nTipo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar registro para edi" + CHR(231) + CHR(227) + "o.", "Alterar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *   Valida uso em SigClCrc (tipo=1) e SigCdFtc antes de excluir (legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cDescrs, loc_cCodigos, loc_lConfirma
        loc_cDescrs   = ""
        loc_cCodigos  = ""
        loc_lConfirma = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cDescrs  = ALLTRIM(cursor_4c_Dados.Descrs)
        loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)

        IF EMPTY(loc_cCodigos)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Excluir o complemento:" + CHR(13) + ;
            CHR(13) + loc_cDescrs + CHR(13) + CHR(13) + "Confirma?", "Excluir")

        IF !loc_lConfirma
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigosETipo(loc_cCodigos, THIS.this_nTipo)
            MsgErro("Erro ao localizar registro para exclus" + CHR(227) + "o.", "Excluir")
            RETURN
        ENDIF

        *-- Verificar uso em Caracteristicas de Contas (apenas para tipo=1)
        IF THIS.this_nTipo = 1
            IF THIS.this_oBusinessObject.VerificarUsoEmCaracteristicasContas(loc_cDescrs)
                MsgErro("Complemento de Caracter" + CHR(237) + "stica Sendo Utilizada!!!", "Excluir")
                RETURN
            ENDIF
        ENDIF

        *-- Verificar uso como titulo em Fichas Tecnicas
        IF THIS.this_oBusinessObject.VerificarUsoEmFichasTecnicas(loc_cCodigos, THIS.this_nTipo)
            MsgErro("Complemento Sendo Utilizado Como T" + CHR(237) + "tulo de Fichas T" + CHR(233) + "cnicas!!!", "Excluir")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Excluir()
            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre busca por codigo/descricao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cFiltro
        loc_cFiltro = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrCpP", "cursor_4c_BuscaMpp", "Codigos", "", ;
                "Buscar Complemento", .F., .T., ;
                "nTipos = " + ALLTRIM(STR(THIS.this_nTipo, 1)))

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMpp")
                    SELECT cursor_4c_BuscaMpp
                    loc_cFiltro = "Codigos = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaMpp.Codigos))
                    THIS.this_oBusinessObject.Buscar(loc_cFiltro, THIS.this_nTipo)

                    LOCAL loc_oGrid
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formmpp.BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaMpp")
            USE IN cursor_4c_BuscaMpp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva (INCLUIR ou ALTERAR)
    *   Logica do legado Salva.Click: valida Codigos (INCLUIR), duplicata, Descrs
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cCodigos, loc_cDescrs
        loc_cCodigos = ""
        loc_cDescrs  = ""

        IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
            RETURN
        ENDIF

        loc_cCodigos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.Value)
        loc_cDescrs  = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.Value)

        *-- Em INCLUIR: Codigos obrigatorio e nao pode ser duplicado
        IF THIS.this_cModoAtual = "INCLUIR"
            IF EMPTY(loc_cCodigos)
                MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", "Salvar")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
                RETURN
            ENDIF
            IF THIS.this_oBusinessObject.VerificarCodigoDuplicado(loc_cCodigos, THIS.this_nTipo)
                MsgAviso("Complemento de Caracter" + CHR(237) + "stica J" + ;
                    CHR(225) + " Cadastrado!!!", "Salvar")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
                RETURN
            ENDIF
        ENDIF

        *-- Descricao obrigatoria
        IF EMPTY(loc_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Salvar")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso.", "Salvar")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e retorna para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere campos do formulario para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_cCodigos = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
            .this_cDescrs  = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
            .this_nTipos   = THIS.this_nTipo
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO para os campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
            loc_oPg2.txt_4c_Descrs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo atual
    *   Codigos: habilitado apenas em INCLUIR (readonly em ALTERAR, como no legado)
    *   Descrs: segue par_lHabilitar
    *   Botao Confirmar: desabilitado em VISUALIZAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
            loc_oPg2.txt_4c_Descrs.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
                (par_lHabilitar AND THIS.this_cModoAtual != "VISUALIZAR")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
            loc_oPg2.txt_4c_Descrs.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes Page1 conforme registros
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemRegistros, loc_oBtns, loc_oErro
        loc_lTemRegistros = USED("cursor_4c_Dados") AND ;
            !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

        TRY
            loc_oBtns = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            IF PEMSTATUS(loc_oBtns, "cmd_4c_Visualizar", 5)
                loc_oBtns.cmd_4c_Visualizar.Enabled = loc_lTemRegistros
            ENDIF
            IF PEMSTATUS(loc_oBtns, "cmd_4c_Alterar", 5)
                loc_oBtns.cmd_4c_Alterar.Enabled = loc_lTemRegistros
            ENDIF
            IF PEMSTATUS(loc_oBtns, "cmd_4c_Excluir", 5)
                loc_oBtns.cmd_4c_Excluir.Enabled = loc_lTemRegistros
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formmpp.AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
