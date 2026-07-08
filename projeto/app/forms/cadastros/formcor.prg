*==============================================================================
* FormCor.prg - Formulario de Cadastro de Cores
* Data: 2026-03-22
* Tabela: SigCdCor | PK: cods
* Legado: SIGCDCOR.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormCor AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Cores"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject         = .NULL.
    this_cMensagemErro           = ""    && OBRIGATORIO - nao herdado de FormBase
    this_cUltimoTanqueValidado   = ""    && Guardia LostFocus: evita revalidar mesmo valor

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar instancia do Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("CorBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object CorBO", "Erro Cr" + CHR(237) + "tico")
                loc_lSucesso = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Se falhar ao carregar, nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormCor:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal
    * Legado: Pagina Width=1003, PageFrame.Top=-29 (oculta abas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            *-- Page1 - Lista
            .Page1.Caption = "Lista"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            *-- Page2 - Dados
            .Page2.Caption = "Dados"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao +29 aplicada: Top original 0 -> 29, Top 2 -> 31
    * Grid mantem Top=121 (ja posicionado corretamente apos compensacao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (cntSombra: Top=2 -> 31, Width=1020, Height=80)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackColor = RGB(192, 192, 192)
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

*!*			 *-- Container de sombra/titulo (herdado de frmrelatorio)
*!*	        THIS.AddObject("cnt_4c_Cabecalho", "Container")
*!*	        WITH THIS.cnt_4c_Cabecalho
*!*	            .Top = 0
*!*	            .Left = 0
*!*	            .Width = THIS.Width
*!*	            .Height = 80
*!*	            .BackColor = RGB(100, 100, 100)
*!*	            .BorderWidth = 0
*!*	        ENDWITH
        *-- Label titulo no cabecalho
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Cores"
            .Top       = 20
            .Left      = 20
            .Width     = 300
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_op: Left=542, Top=0 -> 29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 400
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Inserir: Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Consultar: Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (procurar: Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida (Grupo_Saida: Left=917, Top=0 -> 29)
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

        *-- Botao Encerrar (SAIR: Left=5)
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container de filtros (cntFiltros - vazio no legado)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 29
            .Left        = 5
            .Width       = 530
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Grid de lista (Grade: Top=121, Left=12, Width=940, Height=470)
        *-- 4 colunas: cods(75), descs(301), varias(100), Pesos(100)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top               = 121
            .Left              = 12
            .Width             = 940
            .Height            = 470
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .GridLines         = 3
            .ColumnCount       = 4
            .AllowHeaderSizing = .T.
            .Visible           = .T.
        ENDWITH

        *-- Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Compensacao +29 em TODOS os controles (Top_original + 29)
    * Legado: todos os controles em SIGCDCOR.Pagina.Dados.*
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de botoes de acao (Grupo_Salva: Left=819, Top=9 -> 38)
        loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oPagina.cnt_4c_BotoesDados
            .Top         = 38
            .Left        = 819
            .Width       = 165
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar (Salva: Left=7, Top=5)
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 7
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Cancelar: Left=83, Top=5)
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 83
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *-- CAMPO: Codigo (Say1 + Getcods)
        *-- Say1:    Left=335, Top=131 -> 160
        *-- Getcods: Left=386, Top=127 -> 156, Width=41, H=24
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Left      = 335
            .Top       = 160
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Left          = 386
            .Top           = 156
            .Width         = 41
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "txt_4c_Codigo_KeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Codigo, "DblClick", THIS, "txt_4c_Codigo_DblClick")

        *----------------------------------------------------------------------
        *-- CAMPO: Descricao (Say2 + Getdescs)
        *-- Say2:     Left=322, Top=158 -> 187
        *-- Getdescs: Left=386, Top=154 -> 183, Width=290, H=24
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Left      = 322
            .Top       = 187
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Left          = 386
            .Top           = 183
            .Width         = 290
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CAMPO: Variacao de Preco (Say3 + Getvarias)
        *-- Say3:     Left=282, Top=185 -> 214
        *-- Getvarias: Left=386, Top=181 -> 210, Width=60, InputMask="9999.99"
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "o :"
            .Left      = 282
            .Top       = 214
            .Width     = 103
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_VariacaoPreco", "TextBox")
        WITH loc_oPagina.txt_4c_VariacaoPreco
            .Value         = 0
            .Left          = 386
            .Top           = 210
            .Width         = 60
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "9999.99"
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CAMPO: Grupo (Say4 + Get_Grupo)
        *-- Say4:     Left=339, Top=212 -> 241
        *-- Get_Grupo: Left=386, Top=208 -> 237, Width=80, InputMask="!!!!!!!!!!"
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Grupo :"
            .Left      = 339
            .Top       = 241
            .Width     = 46
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value         = ""
            .Left          = 386
            .Top           = 237
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "!!!!!!!!!!"
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CAMPO: Variacao de Peso (Say5 + Get_Peso)
        *-- Say5:    Left=286, Top=239 -> 268
        *-- Get_Peso: Left=386, Top=235 -> 264, Width=70, InputMask="9999.99"
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o de Peso :"
            .Left      = 286
            .Top       = 268
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Peso", "TextBox")
        WITH loc_oPagina.txt_4c_Peso
            .Value         = 0
            .Left          = 386
            .Top           = 264
            .Width         = 70
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "9999.99"
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CAMPO: Tipo de Cor (Say7 + Get_TpCor + Say9)
        *-- Say7:    Left=313, Top=266 -> 295
        *-- Get_TpCor: Left=386, Top=262 -> 291, Width=17
        *-- Say9:    "(S/N)" Left=413, Top=266 -> 295
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Tipo de Cor :"
            .Left      = 313
            .Top       = 295
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_TipoCor", "TextBox")
        WITH loc_oPagina.txt_4c_TipoCor
            .Value         = ""
            .Left          = 386
            .Top           = 291
            .Width         = 17
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_TipoCor, "KeyPress", THIS, "ValidarTipoCor")

        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "(S/N)"
            .Left      = 413
            .Top       = 295
            .Width     = 35
            .Height    = 15
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CAMPO: Adicionar na Entrega - Dias (Say6 + getDiasEnts + Say8)
        *-- Say6:      Left=271, Top=293 -> 322
        *-- getDiasEnts: Left=386, Top=289 -> 318, Width=31, InputMask="999"
        *-- Say8:      "Dias" Left=422, Top=293 -> 322
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Adicionar na Entrega :"
            .Left      = 271
            .Top       = 322
            .Width     = 114
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DiasEntrega", "TextBox")
        WITH loc_oPagina.txt_4c_DiasEntrega
            .Value         = 0
            .Left          = 386
            .Top           = 318
            .Width         = 31
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999"
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Dias"
            .Left      = 422
            .Top       = 322
            .Width     = 30
            .Height    = 15
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CAMPO: Tanque (Say10 + getTanque)
        *-- Say10:   Left=332, Top=320 -> 349
        *-- getTanque: Left=386, Top=316 -> 345, Width=80, InputMask="!!!!!!!!!!"
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "Tanque :"
            .Left      = 332
            .Top       = 349
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tanque", "TextBox")
        WITH loc_oPagina.txt_4c_Tanque
            .Value         = ""
            .Left          = 386
            .Top           = 345
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "!!!!!!!!!!"
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Tanque, "KeyPress", THIS, "ValidarTanque")

        *-- Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros no grid
    * Colunas: cods(75), descs(301), varias(100), Pesos(100)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            *-- 1. Buscar dados
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                *-- 2. Definir RecordSource (ISSO RESETA AS COLUNAS)
                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.varias"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Pesos"

                *-- 3. RECONFIGURAR larguras e cabecalhos APOS RecordSource (OBRIGATORIO)
                loc_oGrid.Column1.Width = 75
                loc_oGrid.Column2.Width = 301
                loc_oGrid.Column3.Width = 100
                loc_oGrid.Column4.Width = 100
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o Pre" + CHR(231) + "o"
                loc_oGrid.Column4.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o Peso"

                *-- 4. Aplicar formatacao visual
                THIS.FormatarGridLista(loc_oGrid)

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do formulario para o Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cCodigo        = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
            .this_cDescricao     = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.Value)
            .this_nVariacaoPreco = THIS.pgf_4c_Paginas.Page2.txt_4c_VariacaoPreco.Value
            .this_cGrupo         = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
            .this_nPeso          = THIS.pgf_4c_Paginas.Page2.txt_4c_Peso.Value
            .this_cTipoCor       = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_TipoCor.Value)
            .this_nDiasEntrega   = THIS.pgf_4c_Paginas.Page2.txt_4c_DiasEntrega.Value
            .this_cTanque        = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Tanque.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object para o formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_Codigo.Value        = THIS.this_oBusinessObject.this_cCodigo
            .txt_4c_Descricao.Value     = THIS.this_oBusinessObject.this_cDescricao
            .txt_4c_VariacaoPreco.Value = THIS.this_oBusinessObject.this_nVariacaoPreco
            .txt_4c_Grupo.Value         = THIS.this_oBusinessObject.this_cGrupo
            .txt_4c_Peso.Value          = THIS.this_oBusinessObject.this_nPeso
            .txt_4c_TipoCor.Value       = THIS.this_oBusinessObject.this_cTipoCor
            .txt_4c_DiasEntrega.Value   = THIS.this_oBusinessObject.this_nDiasEntrega
            .txt_4c_Tanque.Value        = THIS.this_oBusinessObject.this_cTanque
        ENDWITH
        *-- Sincronizar guardia com valor carregado (evita falso disparo de lookup)
        THIS.this_cUltimoTanqueValidado = ALLTRIM(THIS.this_oBusinessObject.this_cTanque)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_Codigo.Value        = ""
            .txt_4c_Descricao.Value     = ""
            .txt_4c_VariacaoPreco.Value = 0
            .txt_4c_Grupo.Value         = ""
            .txt_4c_Peso.Value          = 0
            .txt_4c_TipoCor.Value       = ""
            .txt_4c_DiasEntrega.Value   = 0
            .txt_4c_Tanque.Value        = ""
        ENDWITH
        THIS.this_cUltimoTanqueValidado = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    * Codigo: habilitado apenas no modo INCLUIR
    * Demais: habilitados em INCLUIR e ALTERAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        WITH THIS.pgf_4c_Paginas.Page2
            IF THIS.this_cModoAtual = "INCLUIR"
                .txt_4c_Codigo.Enabled = .T.
            ELSE
                .txt_4c_Codigo.Enabled = .F.
            ENDIF

            .txt_4c_Descricao.Enabled     = par_lHabilitar
            .txt_4c_VariacaoPreco.Enabled = par_lHabilitar
            .txt_4c_Grupo.Enabled         = par_lHabilitar
            .txt_4c_Peso.Enabled          = par_lHabilitar
            .txt_4c_TipoCor.Enabled       = par_lHabilitar
            .txt_4c_DiasEntrega.Enabled   = par_lHabilitar
            .txt_4c_Tanque.Enabled        = par_lHabilitar
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado (Consultar no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    * Legado: verifica se cor e usada em SigPrPrr (fichas tecnicas)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResultado

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)

            *-- Verificar uso em fichas tecnicas (SigPrPrr)
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT COUNT(*) AS nNreg1s
                FROM SigPrPrr a
                INNER JOIN SigCdPro b ON b.cPros = a.cPros
                WHERE a.CodCors = <<EscaparSQL(loc_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaCor")

            IF loc_nResultado < 0
                MsgErro("Falha na conex" + CHR(227) + "o ao verificar uso da cor!")
                IF USED("cursor_4c_VerificaCor")
                    USE IN cursor_4c_VerificaCor
                ENDIF
                RETURN
            ENDIF

            IF NVL(cursor_4c_VerificaCor.nNreg1s, 0) > 0
                MsgAviso("Cor sendo utilizada em fichas t" + CHR(233) + "cnicas!")
                IF USED("cursor_4c_VerificaCor")
                    USE IN cursor_4c_VerificaCor
                ENDIF
                RETURN
            ENDIF

            IF USED("cursor_4c_VerificaCor")
                USE IN cursor_4c_VerificaCor
            ENDIF

            IF MsgConfirma("Confirma exclus" + CHR(227) + "o da cor '" + loc_cCodigo + "'?")
                IF THIS.this_oBusinessObject.Excluir()
                    MsgSucesso("Cor exclu" + CHR(237) + "da com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre busca auxiliar (msv_procurar no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_Busca", "cods", "", "Buscar Cor")

            loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    LOCAL loc_cCodigo
                    loc_cCodigo = ALLTRIM(cursor_4c_Busca.cods)

                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        THIS.BOParaForm()
                        THIS.this_cModoAtual = "VISUALIZAR"
                        THIS.HabilitarCampos(.F.)
                        THIS.AlternarPagina(2)
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar registro
    * Legado: valida codigo vazio, duplicidade e referencia em SigPrPrr
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        *-- Validacao: codigo obrigatorio
        IF EMPTY(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
            RETURN
        ENDIF

        *-- Validacao: codigo duplicado (apenas no modo INCLUIR)
        IF THIS.this_cModoAtual = "INCLUIR"
            LOCAL loc_cCodNovo, loc_cSQLDup, loc_nDup
            loc_cCodNovo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)

            TEXT TO loc_cSQLDup TEXTMERGE NOSHOW
                SELECT COUNT(*) AS nExiste FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCodNovo)>>
            ENDTEXT

            loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupCor")

            IF loc_nDup >= 0 AND NVL(cursor_4c_DupCor.nExiste, 0) > 0
                IF USED("cursor_4c_DupCor")
                    USE IN cursor_4c_DupCor
                ENDIF
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
                RETURN
            ENDIF

            IF USED("cursor_4c_DupCor")
                USE IN cursor_4c_DupCor
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * txt_4c_Codigo_KeyPress - Lookup F4 no campo Codigo
    *--------------------------------------------------------------------------
    PROCEDURE txt_4c_Codigo_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupCodigo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * txt_4c_Codigo_DblClick - Lookup duplo clique no campo Codigo
    *--------------------------------------------------------------------------
    PROCEDURE txt_4c_Codigo_DblClick()
        THIS.AbrirLookupCodigo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCodigo - Abre lookup de Cores para campo Codigo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupCodigo()
        LOCAL loc_oBusca, loc_cValor

        IF THIS.this_cModoAtual != "INCLUIR"
            RETURN
        ENDIF

        TRY
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_Busca", "cods", loc_cValor, "Buscar Cor")
            loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value  = ALLTRIM(cursor_4c_Busca.cods)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.Value = ALLTRIM(cursor_4c_Busca.descs)
                ENDIF
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro no lookup:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTipoCor - Valida campo Tipo de Cor (LostFocus)
    * Legado Get_TpCor.Valid: Return Inlist(This.Value,"S","N"," ")
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTipoCor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cTipo
        loc_cTipo = ALLTRIM(UPPER(THIS.pgf_4c_Paginas.Page2.txt_4c_TipoCor.Value))

        IF !EMPTY(loc_cTipo) AND !INLIST(loc_cTipo, "S", "N")
            MsgAviso("Tipo de Cor inv" + CHR(225) + "lido! Use S ou N.")
            THIS.pgf_4c_Paginas.Page2.txt_4c_TipoCor.Value = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_TipoCor.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTanque - Lookup de Tanque via SigCdTqe (LostFocus)
    * Legado getTanque.Valid: fwbuscaext em SigCdTqe coluna 'codigos'/'descrs'
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTanque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cTanque, loc_oBusca, loc_cSQL, loc_nRes

        loc_cTanque = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Tanque.Value)

        *-- Guardia LostFocus: evitar revalidar o mesmo valor (LostFocus dispara sempre)
        IF loc_cTanque = THIS.this_cUltimoTanqueValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cTanque)
            THIS.this_cUltimoTanqueValidado = ""
            RETURN
        ENDIF

        TRY
            *-- Verificar se codigo de tanque existe em SigCdTqe
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT COUNT(*) AS nExiste FROM SigCdTqe WHERE codigos = <<EscaparSQL(loc_cTanque)>>
            ENDTEXT

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerTqe")

            IF loc_nRes >= 0
                IF NVL(cursor_4c_VerTqe.nExiste, 0) > 0
                    *-- Codigo valido: atualizar guardia
                    THIS.this_cUltimoTanqueValidado = loc_cTanque
                ELSE
                    *-- Codigo nao encontrado: abrir lookup
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTqe", "cursor_4c_Tqe", "codigos", loc_cTanque, "Sele" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou
                        IF USED("cursor_4c_Tqe")
                            THIS.pgf_4c_Paginas.Page2.txt_4c_Tanque.Value = ALLTRIM(cursor_4c_Tqe.codigos)
                            THIS.this_cUltimoTanqueValidado = ALLTRIM(cursor_4c_Tqe.codigos)
                        ENDIF
                    ELSE
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Tanque.Value = ""
                        THIS.this_cUltimoTanqueValidado = ""
                    ENDIF

                    IF USED("cursor_4c_Tqe")
                        USE IN cursor_4c_Tqe
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF

            IF USED("cursor_4c_VerTqe")
                USE IN cursor_4c_VerTqe
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar tanque:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            IF .ColumnCount > 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Trata containers com ControlCount
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE
