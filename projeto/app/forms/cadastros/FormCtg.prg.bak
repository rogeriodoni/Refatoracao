*==============================================================================
* FormCtg.prg - Formulario de Cadastro de Categorias
* Migrado de: SigCdCtg.SCX (frmcadastro)
* FASE 7/8: Eventos principais (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick)
*==============================================================================

DEFINE CLASS FormCtg AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Categorias"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CtgBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar CtgBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormCtg.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormCtg:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormCtg.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
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
    * ConfigurarPaginaLista - Configura Page1 com containers base
    * Fase 3: cnt_4c_Cabecalho (completo), cnt_4c_Botoes e cnt_4c_Saida (vazios)
    * Fase 4 adiciona: grd_4c_Lista + botoes CRUD no cnt_4c_Botoes/cnt_4c_Saida
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho cinza (cntSombra no legado)
        *-- Original: Top=1. Com compensacao PageFrame.Top=-29: Top = 1+29 = 30 => usar 31 (padrao)
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

        *-- Container Botoes CRUD - Canonico Left=542, Top=29
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
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

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
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

        *-- Botao Encerrar (padrao canonico)
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

        *-- Grid de listagem (Grade no legado: colunas Cods=80px, Descs=150px)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 12
            .Width              = 890
            .Height             = 488
            .ColumnCount        = 2
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes da Page1
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes + campos da Page2
    * Grupo_Salva original: Left=817, Top=11 -> com +29: Top=40
    * Say1 (Codigo): Top=141, Left=335 -> com +29: Top=170
    * getCods: Top=137, Left=382, Width=60 -> com +29: Top=166
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao - Grupo_Salva no legado (Left=817, Top=11+29=40)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 40
            .Left        = 817
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva no legado: Left=5, Top=5)
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

        *-- Botao Cancelar (Cancelar no legado: Left=80, Top=5)
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

        *-- Label Codigo (Say1 no legado: Top=141, Left=335, ForeColor=90,90,90)
        *-- Com compensacao +29: Top=170
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 170
            .Left      = 335
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (getCods no legado: Top=137, Left=382, Width=60, Height=24)
        *-- Com compensacao +29: Top=166
        *-- Format="K!" = uppercase; campo Cods char(3)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 166
            .Left          = 382
            .Width         = 60
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .InputMask     = "!!!"
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH

        *-- Label Descricao (Say2 no legado: Top=167, Left=322, ForeColor=90,90,90)
        *-- Com compensacao +29: Top=196
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 196
            .Left      = 322
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (getDescs no legado: Top=163, Left=382, Width=300, Height=24)
        *-- Com compensacao +29: Top=192; Format="K!" = uppercase
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 192
            .Left          = 382
            .Width         = 300
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .MaxLength     = 50
            .Visible       = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes da Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no cursor via BO e configura grid
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lSucesso = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"

                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 380

                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista de categorias:" + CHR(13) + ;
                loException.Message, "FormCtg.CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *===========================================================================
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

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "FormCtg.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara form para incluir novo registro
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado para visualizacao
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para visualizar.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.", "Excluir")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da categoria " + ;
            ALLTRIM(loc_cCodigo) + "?", "Excluir")

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Categoria exclu" + CHR(237) + "da com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre busca de categorias via FormBuscaAuxiliar
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCtg", "cursor_4c_BuscaCtg", "cods", loc_cCodigo, ;
                "Buscar Categoria")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtg")
                    SELECT cursor_4c_BuscaCtg
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCtg.cods)
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(cods) == loc_cCodigo
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormCtg.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaCtg")
            USE IN cursor_4c_BuscaCtg
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e salva o registro (Confirmar)
    * Logica do legado: Grupo_Salva.Salva.Click
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cCodigo, loc_cDescricao, loc_nResult
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        *-- Validar Codigo (obrigatorio)
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
                loc_oPagina.txt_4c_Codigo.SetFocus()
            ENDIF
            RETURN
        ENDIF

        *-- Validar Descricao (obrigatorio)
        loc_cDescricao = ""
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        ENDIF

        IF EMPTY(loc_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
                loc_oPagina.txt_4c_Descricao.SetFocus()
            ENDIF
            RETURN
        ENDIF

        *-- INCLUIR: verificar se codigo ja existe (logica do legado)
        IF THIS.this_cModoAtual = "INCLUIR"
            TRY
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cods FROM SigCdCtg WHERE Cods = " + EscaparSQL(loc_cCodigo), ;
                    "cursor_4c_CtgDupChk")
                IF loc_nResult > 0 AND USED("cursor_4c_CtgDupChk")
                    IF RECCOUNT("cursor_4c_CtgDupChk") > 0
                        MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED("cursor_4c_CtgDupChk")
                            USE IN cursor_4c_CtgDupChk
                        ENDIF
                        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
                            loc_oPagina.txt_4c_Codigo.SetFocus()
                        ENDIF
                        RETURN
                    ENDIF
                ENDIF
                IF USED("cursor_4c_CtgDupChk")
                    USE IN cursor_4c_CtgDupChk
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, ;
                    "FormCtg.BtnSalvarClick")
                IF USED("cursor_4c_CtgDupChk")
                    USE IN cursor_4c_CtgDupChk
                ENDIF
                RETURN
            ENDTRY
        ENDIF

        THIS.FormParaBO()

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Categoria salva com sucesso!", "Sucesso")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar categoria:" + CHR(13) + loException.Message, ;
                "FormCtg.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela e volta para lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao na Page2
    * getCods.When = INSERIR only -> txt_4c_Codigo so editavel em INCLUIR
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: apenas editavel em INCLUIR (legado: When = InList(pcEscolha, INSERIR, PROCURAR))
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Enabled = par_lHabilitar AND ;
                (THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        *-- Descricao: editavel em INCLUIR e ALTERAR
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            loc_oPagina.txt_4c_Descricao.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa valores dos campos de edicao na Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            loc_oPagina.txt_4c_Descricao.Value = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BO para os campos do Form
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados dos campos do Form para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            THIS.this_oBusinessObject.this_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    * Legado: INSERIR/PROCURAR->foco em getCods, ALTERAR->foco em getDescs,
    *         VISUALIZAR->Confirmar disabled + foco em Cancelar
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEmEdicao
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_lEmEdicao  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Habilitar/desabilitar Confirmar conforme modo
        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEmEdicao
            ENDIF
        ENDIF

        *-- SetFocus conforme modo (replica logica legado: Click do Grupo_Op)
        DO CASE
            CASE THIS.this_cModoAtual = "INCLUIR"
                IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
                    IF loc_oPagina.txt_4c_Codigo.Enabled
                        loc_oPagina.txt_4c_Codigo.SetFocus()
                    ENDIF
                ENDIF

            CASE THIS.this_cModoAtual = "ALTERAR"
                IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
                    IF loc_oPagina.txt_4c_Descricao.Enabled
                        loc_oPagina.txt_4c_Descricao.SetFocus()
                    ENDIF
                ENDIF

            OTHERWISE
                IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
                    IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
                    ENDIF
                ENDIF
        ENDCASE
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_BuscaCtg")
            USE IN cursor_4c_BuscaCtg
        ENDIF

        IF USED("cursor_4c_CtgDupChk")
            USE IN cursor_4c_CtgDupChk
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
