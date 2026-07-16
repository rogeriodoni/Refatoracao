*==============================================================================
* Formpgr.prg - Formulario de Lancamentos e Pagamentos
* Data: 2026-03-22
* Tabela: SigPrCsh | PK: empdopnums
* Legado: SIGCDPGR.SCX (frmcadastro)
* Fase 3/8: Estrutura Base (PageFrame + Containers)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS Formpgr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    DataSession = 2
    ShowTips    = .T.
    Caption     = ""
    WindowState = 0
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

    *-- Propriedades herdadas / Business Object
    this_oBusinessObject    = .NULL.
    this_cMensagemErro      = ""        && OBRIGATORIO - nao herdado de FormBase

    *-- Propriedades customizadas do SIGCDPGR
    moedamaior      = " "
    novolacto       = 0
    cotusu          = " "
    matriz          = .F.
    grupooper       = .F.
    cnab            = .F.
    baixapend       = .F.
    buscanfs        = .F.
    bloqdatas       = .F.
    historicocliente = " "
    identtef        = .F.
    transtef        = .F.
    numeratitulo    = .F.
    acerto          = .F.
    alteroucotacao  = .F.
    placalterar     = .T.
    placexcluir     = .T.
    placinserir     = .T.
    plautoinclusao  = .T.

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
            THIS.this_oBusinessObject = CREATEOBJECT("pgrBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object pgrBO", "Erro Cr" + CHR(237) + "tico")
                loc_lSucesso = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Titulo no cabecalho da lista
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

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
            MostrarErro("Erro ao inicializar Formpgr:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal
    * Legado: Pagina Top=-28, Width=1003, Height=635, PageCount=2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -28
            .Left      = 0
            .Width     = 1003
            .Height    = 635
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            *-- Page1 - Lista
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.ForeColor = RGB(90, 90, 90)

            *-- Page2 - Dados
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao +28 aplicada a todos os controles (Top_original + 28)
    * Legado: SIGCDPGR.Pagina.Lista.*
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        *-- Container cabecalho com sombra
        *-- Legado: cntSombra Top=0 -> +28=28, Left=0, Width=1006, Height=80
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
        WITH loc_oPagina.cnt_4c_Sombra
            .Top         = 28
            .Left        = 0
            .Width       = 1006
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label sombra (fundo decorativo)
        loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
            .Caption   = ""
            .Top       = 0
            .Left      = 0
            .Width     = 1006
            .Height    = 80
            .BackStyle = 1
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- Label titulo
        *-- Legado: lblTitulo Top=18, Left=10, Width=925, Height=46
        loc_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
            .Caption   = "Lan" + CHR(231) + "amentos e Pagamentos"
            .Top       = 18
            .Left      = 10
            .Width     = 925
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container de botoes CRUD
        *-- Legado: Grupo_op Left=543, Top=-2 -> +28=26, Height=85
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 26
            .Left        =  542
            .Width       = 400
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Botao Incluir (Legado: Inserir Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
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

        *-- Botao Visualizar / Consultar (Legado: Consultar Left=80)
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

        *-- Botao Alterar (Legado: Alterar Left=155)
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

        *-- Botao Excluir (Legado: Excluir Left=230)
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

        *-- Botao Buscar / Procurar (Legado: Procurar Left=305)
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

        *----------------------------------------------------------------------
        *-- Container de saida
        *-- Legado: Grupo_Saida Left=918, Top=-2 -> +28=26
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 26
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Botao Encerrar (Legado: Sair Left=5)
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

        *----------------------------------------------------------------------
        *-- Container de filtros
        *-- Legado: cntFiltros Top=81 -> +28=109, Left=12, Width=552, Height=79
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 109
            .Left        = 12
            .Width       = 552
            .Height      = 79
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *----------------------------------------------------------------------
        *-- Sub-container de periodo de datas
        *-- Legado: cntFiltros.Cnt_periodo Top=0, Left=2, Width=285, Height=36
        *----------------------------------------------------------------------
        loc_oPagina.cnt_4c_Filtros.AddObject("cnt_4c_Periodo", "Container")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo
            .Top         = 0
            .Left        = 2
            .Width       = 285
            .Height      = 36
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Label "Periodo :" (Legado: Label1 Left=9, Top=10)
        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo : "
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 9
            .Top       = 10
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- TextBox data inicial (Legado: Dt_inicial Left=55, Top=6, Width=80)
        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtInicial
            .Format        = "D"
            .Height        = 23
            .Left          = 55
            .Top           = 6
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        *-- Label separador (Legado: Say2 "a" Left=139, Top=10) CHR(224)=a-grave
        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.lbl_4c_Sep
            .Caption   = CHR(224)
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 139
            .Top       = 10
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- TextBox data final (Legado: Dt_final Left=151, Top=6, Width=80)
        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_DtFinal
            .Format        = "D"
            .Height        = 23
            .Left          = 151
            .Top           = 6
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Controles adicionais na pagina Lista (fora do cntFiltros)
        *-- Legado: Label1 "Usuario :" Left=249, Top=91 -> +28=119
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_UsuarioFiltro", "Label")
        WITH loc_oPagina.lbl_4c_UsuarioFiltro
            .Caption   = "Usu" + CHR(225) + "rio :"
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 249
            .Top       = 119
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- TextBox usuario filtro (Legado: Usuario Left=302, Top=87 -> +28=115)
        loc_oPagina.AddObject("txt_4c_UsuarioFiltro", "TextBox")
        WITH loc_oPagina.txt_4c_UsuarioFiltro
            .Height        = 23
            .Left          = 302
            .Top           = 115
            .Width         = 100
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BackColor     = RGB(251, 254, 205)
            .Visible       = .T.
        ENDWITH
        *-- Label "Situacao :" (Legado: Label2 Left=18, Top=117 -> +28=145)
        loc_oPagina.AddObject("lbl_4c_Situacao", "Label")
        WITH loc_oPagina.lbl_4c_Situacao
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 18
            .Top       = 145
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- CheckBox Autorizados (Legado: chkAutorizados Left=302, Top=115 -> +28=143)
        loc_oPagina.AddObject("chk_4c_Autorizados", "CheckBox")
        WITH loc_oPagina.chk_4c_Autorizados
            .Caption       = "Autorizados"
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Left          = 302
            .Top           = 143
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        *-- ComboBox conciliacao (Legado: Cmb_Concilia Left=69, Top=112 -> +28=140)
        loc_oPagina.AddObject("cmb_4c_Conciliacao", "ComboBox")
        WITH loc_oPagina.cmb_4c_Conciliacao
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Todos Lotes,Lotes Conciliados,Lotes n" + CHR(227) + "o Conciliados"
            .Value         = 1
            .Height        = 24
            .Left          = 69
            .SpecialEffect = 1
            .Style         = 2
            .Top           = 140
            .Width         = 176
            .Visible       = .T.
        ENDWITH
        *-- Botao Conciliacao (Legado: Conciliacao Left=409, Top=83 -> +28=111)
        loc_oPagina.AddObject("cmd_4c_Conciliacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Conciliacao
            .Caption         = "Concilia" + CHR(231) + CHR(227) + "o"
            .Picture         = gc_4c_CaminhoIcones + "geral_login_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 409
            .Top             = 111
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Conciliacao, "Click", THIS, "BtnConciliacaoClick")
        *-- CheckBox Exibir Todos (Legado: TodosLanc Left=484, Top=83 -> +28=111, Style=1)
        loc_oPagina.AddObject("chk_4c_TodosLanc", "CheckBox")
        WITH loc_oPagina.chk_4c_TodosLanc
            .Caption         = "Exibir Todos"
            .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
            .Width           = 75
            .Height          = 75
            .Left            = 484
            .Top             = 111
            .Style           = 1
            .Alignment       = 0
            .Value           = 0
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.chk_4c_TodosLanc, "Click", THIS, "ChkTodosLancClick")

        *-- Grid de lista (Grade: Top=161+28=189, Left=12, Height=439, Width=937)
        *-- 6 colunas (ordem visual): Codigo(58), Data(75), Grupo(100), Conta(100),
        *--                           Descricao/fpags(477), Usuario/nopers(100)
        *-- Legado: Column5.ColumnOrder=6, Column6.ColumnOrder=5 -> aqui sem ColumnOrder
        loc_oPagina.AddObject("grd_4c_Grade", "Grid")
        WITH loc_oPagina.grd_4c_Grade
            .Top               = 189
            .Left              = 12
            .Height            = 439
            .Width             = 937
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .GridLines         = 3
            .AllowHeaderSizing = .T.
            .Visible           = .T.
        ENDWITH
        loc_oPagina.grd_4c_Grade.ColumnCount = 6
        *-- Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Compensacao +28 aplicada a todos os controles (Top_original + 28)
    * Legado: SIGCDPGR.Pagina.Dados.*
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        *-- Container de botoes de acao (Salvar/Cancelar)
        *-- Legado: Grupo_Salva Left=841, Top=15 -> +28=43
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 43
            .Left        = 841
            .Width       = 165
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        *-- Botao Salvar (Legado: Salva Left=5, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Legado: Cancelar Left=80, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *-- Container cabecalho (campos de data/conta/numero)
        *-- Legado: cntCadastro Top=26 -> +28=54, Left=9, Width=798, Height=51
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 54
            .Left        = 9
            .Width       = THIS.Width
            .Height      = 51
            .BackStyle   = 0
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH
        *----------------------------------------------------------------------
        *-- Controles do container cabecalho (cntCadastro)
        *-- Legado: coordenadas relativas ao container (Top=26+28=54 do container)
        *----------------------------------------------------------------------
        *-- Label "Codigo :" (Legado: Say2 FontBold Left=26, Top=23)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_LblCodigo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_LblCodigo
            .Caption   = "C" + CHR(243) + "digo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 26
            .Top       = 23
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- TextBox numero lancamento (Legado: Get_Numes Left=78, Top=19, Width=68 -> MascNum)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("txt_4c_NumLancamento", "TextBox")
        WITH loc_oPagina.cnt_4c_Cabecalho.txt_4c_NumLancamento
            .Height        = 25
            .Left          = 78
            .Top           = 19
            .Width         = 68
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Label "Conta :" (Legado: Say3 FontBold Left=160, Top=23, Visible=.F.)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_LblConta", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_LblConta
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 160
            .Top       = 23
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH
        *-- TextBox conta (Legado: Get_Conta Left=205, Top=19, Width=80, Visible=.F.)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("txt_4c_ContaHeader", "TextBox")
        WITH loc_oPagina.cnt_4c_Cabecalho.txt_4c_ContaHeader
            .Height        = 25
            .Left          = 205
            .Top           = 19
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Cabecalho.txt_4c_ContaHeader, "KeyPress", THIS, "ValidarConta")
        *-- Label "Datas :" (Legado: Say1 FontBold Left=306, Top=24)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_LblDatas", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_LblDatas
            .Caption   = "Datas :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 306
            .Top       = 24
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Label "Lancamento" (Legado: Say9 Left=350, Top=7)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_LblLancamento", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_LblLancamento
            .Caption   = "Lan" + CHR(231) + "amento"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 350
            .Top       = 7
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- TextBox data lancamento (Legado: Get_Data Left=350, Top=20, Width=80 -> datarcs)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("txt_4c_DataLancamento", "TextBox")
        WITH loc_oPagina.cnt_4c_Cabecalho.txt_4c_DataLancamento
            .Format        = "D"
            .Height        = 23
            .Left          = 350
            .Top           = 20
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Label "Inicial" (Legado: Say5 Left=440, Top=7)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_LblInicial", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_LblInicial
            .Caption   = "Inicial"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 440
            .Top       = 7
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- TextBox data inicial (Legado: Get_Inicial Left=440, Top=20, Width=80)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("txt_4c_DataInicial", "TextBox")
        WITH loc_oPagina.cnt_4c_Cabecalho.txt_4c_DataInicial
            .Format        = "D"
            .Height        = 23
            .Left          = 440
            .Top           = 20
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Label "Limite" (Legado: Say4 Left=529, Top=7)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_LblLimite", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_LblLimite
            .Caption   = "Limite"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 529
            .Top       = 7
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- TextBox data limite (Legado: Get_Limite Left=529, Top=20, Width=80 -> datalims)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("txt_4c_DataLimite", "TextBox")
        WITH loc_oPagina.cnt_4c_Cabecalho.txt_4c_DataLimite
            .Format        = "D"
            .Height        = 23
            .Left          = 529
            .Top           = 20
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- PageFrame interno com 3 sub-paginas
        *-- Legado: Dados.Pagina Top=95 -> +28=123, Left=1, Width=999, Height=507
        *-- PageCount=3, Page1=Pendencias(Order2), Page2=Pagamento(Order3), Page3=Cadastro(Order1)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("pgf_4c_SubPaginas", "PageFrame")
        WITH loc_oPagina.pgf_4c_SubPaginas
            .Top       = 123
            .Left      = 1
            .Width     = 999
            .Height    = 507
            .PageCount = 3
            .Visible   = .T.

            *-- Page1: Sub-pagina de titulos em aberto (PageOrder=2, Enabled=.F.) - CHR(237)=i-acute
            .Page1.Caption   = "T" + CHR(237) + "tulos Pendentes"
            .Page1.PageOrder = 2
            .Page1.Enabled   = .F.
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.ForeColor = RGB(90, 90, 90)
            .Page1.FontName  = "Tahoma"
            .Page1.FontSize  = 8

            *-- Page2: Informacoes Financeiras (PageOrder=3, Enabled=.F.) - CHR(231)=c-cedilla, CHR(245)=o-tilde
            .Page2.Caption   = "Informa" + CHR(231) + CHR(245) + "es Financeiras"
            .Page2.PageOrder = 3
            .Page2.Enabled   = .F.
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.ForeColor = RGB(90, 90, 90)
            .Page2.FontName  = "Tahoma"
            .Page2.FontSize  = 8

            *-- Page3: Lancamentos (PageOrder=1, Enabled=.T. - pagina inicial) - CHR(231)=c-cedilla
            .Page3.Caption   = "Lan" + CHR(231) + "amentos"
            .Page3.PageOrder = 1
            .Page3.Enabled   = .T.
            .Page3.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page3.BackColor = RGB(255, 255, 255)
            .Page3.ForeColor = RGB(90, 90, 90)
            .Page3.FontName  = "Tahoma"
            .Page3.FontSize  = 8
        ENDWITH

        *-- Configurar sub-paginas internas
        THIS.ConfigurarSubPaginaLancamentos()
        THIS.ConfigurarSubPaginaPendencias()
        THIS.ConfigurarSubPaginaPagamento()

        *-- Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Ocultar controles condicionais (devem permanecer ocultos ate ativacao)
        WITH THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3
            .cmd_4c_Reprocessar.Visible = .F.
            .cmd_4c_Boleto.Visible      = .F.
            .cmd_4c_Documento.Visible   = .F.
            .cmd_4c_Recibo.Visible      = .F.
        ENDWITH
        *-- Ocultar campos de conta do cabecalho (mostrados apenas em contexto especifico)
        WITH loc_oPagina.cnt_4c_Cabecalho
            .lbl_4c_LblConta.Visible    = .F.
            .txt_4c_ContaHeader.Visible = .F.
        ENDWITH
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
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Excecao: cnt_4c_NovaPendencia e cnt_4c_Pagamento sao containers flutuantes
    *          que devem permanecer ocultos (Visible=.F.) ate ativacao pelo usuario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- Excluir containers flutuantes que devem permanecer ocultos
                loc_cNome = UPPER(loc_oObjeto.Name)
                IF loc_cNome = "CNT_4C_NOVAPENDENCIA" OR loc_cNome = "CNT_4C_PAGAMENTO"
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
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

    *--------------------------------------------------------------------------
    * Destroy - Liberacao de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros no grid da lista
    * Colunas visuais: Codigo(58), Data(75), Grupo(100), Conta(100),
    *                  Descricao/fpags(477), Usuario/nopers(100)
    * CRITICO: RecordSource e ControlSource FORA do WITH block
    * CRITICO: ControlSource, Width e Headers SEMPRE apos RecordSource
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Grade

            *-- 1. Buscar dados via BO
            IF !THIS.this_oBusinessObject.Buscar("")
                MostrarErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                loc_lResultado = .F.
            ELSE
                *-- 2. RecordSource FORA do WITH (CRITICO - reseta colunas)
                loc_oGrid.ColumnCount = 6
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- 3. ControlSource OBRIGATORIO APOS RecordSource
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.empdopnums"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.grupocash"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.contacsh"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.fpags"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.nopers"

                *-- 4. Larguras APOS RecordSource
                loc_oGrid.Column1.Width = 58
                loc_oGrid.Column2.Width = 75
                loc_oGrid.Column3.Width = 100
                loc_oGrid.Column4.Width = 100
                loc_oGrid.Column5.Width = 477
                loc_oGrid.Column6.Width = 100

                *-- 5. FontName por coluna (Legado: Courier New)
                loc_oGrid.Column1.FontName = "Courier New"
                loc_oGrid.Column2.FontName = "Courier New"
                loc_oGrid.Column3.FontName = "Courier New"
                loc_oGrid.Column4.FontName = "Courier New"
                loc_oGrid.Column5.FontName = "Courier New"
                loc_oGrid.Column6.FontName = "Courier New"

                *-- 6. Cabecalhos APOS RecordSource
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Data"
                loc_oGrid.Column3.Header1.Caption = "Grupo"
                loc_oGrid.Column4.Header1.Caption = "Conta"
                loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"

                *-- 7. Colunas imutaveis (Legado: Movable=.F., Resizable=.F.)
                loc_oGrid.Column1.Movable   = .F.
                loc_oGrid.Column2.Movable   = .F.
                loc_oGrid.Column3.Movable   = .F.
                loc_oGrid.Column4.Movable   = .F.
                loc_oGrid.Column5.Movable   = .F.
                loc_oGrid.Column6.Movable   = .F.
                loc_oGrid.Column1.Resizable = .F.
                loc_oGrid.Column2.Resizable = .F.
                loc_oGrid.Column3.Resizable = .F.
                loc_oGrid.Column4.Resizable = .F.
                loc_oGrid.Column5.Resizable = .F.
                loc_oGrid.Column6.Resizable = .F.

                *-- 8. Formatacao visual
                THIS.FormatarGridLista(loc_oGrid)

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo lancamento
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo("INCLUIR")
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar lancamento selecionado (Consultar no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.empdopnums)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo("VISUALIZAR")
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar lancamento selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.empdopnums)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo("ALTERAR")
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir lancamento selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.empdopnums)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            IF MsgConfirma("Confirma exclus" + CHR(227) + "o do lan" + CHR(231) + ;
                    "amento '" + loc_cChave + "'?")
                IF THIS.this_oBusinessObject.ExecutarExclusao()
                    MsgSucesso("Lan" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Procurar lancamento (Legado: Procurar/msv_procurar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrCsh", "cursor_4c_Busca", "empdopnums", "", ;
                "Buscar Lan" + CHR(231) + "amento")

            loc_oBusca.mAddColuna("empdopnums", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("datas",      "", "Data")
            loc_oBusca.mAddColuna("fpags",      "", "Descri" + CHR(231) + CHR(227) + "o")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    LOCAL loc_cChave
                    loc_cChave = ALLTRIM(cursor_4c_Busca.empdopnums)

                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                        THIS.BOParaForm()
                        THIS.this_cModoAtual = "VISUALIZAR"
                        THIS.HabilitarCampos(.F.)
                        THIS.AjustarBotoesPorModo("VISUALIZAR")
                        THIS.AlternarPagina(2)
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar lancamento
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Registro salvo com sucesso!")
            THIS.this_cModoAtual = "LISTA"
            THIS.AjustarBotoesPorModo("LISTA")
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AjustarBotoesPorModo("LISTA")
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do formulario para o Business Object
    * Campos do cabecalho (datas, conta, numero) adicionados na Fase 5
    * Campos das sub-paginas adicionados nas Fases 6, 7 e 8
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oCab, loc_oPag3, loc_oBO
        loc_oBO   = THIS.this_oBusinessObject
        loc_oCab  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho
        loc_oPag3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3

        *-- Cabecalho
        loc_oBO.this_cMascNum  = ALLTRIM(loc_oCab.txt_4c_NumLancamento.Value)
        loc_oBO.this_dDataRcs  = loc_oCab.txt_4c_DataLancamento.Value
        loc_oBO.this_dDataLims = loc_oCab.txt_4c_DataLimite.Value
        loc_oBO.this_cContas   = ALLTRIM(loc_oCab.txt_4c_ContaHeader.Value)

        *-- Page3 Lancamentos: campos de observacao
        loc_oBO.this_cObs      = ALLTRIM(loc_oPag3.edt_4c_Observacao.Value)

        *-- Page1 Pendencias: campos de filtro e moeda
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_oBO.this_cGrupos   = ALLTRIM(loc_oPag1.txt_4c_GrupoPend.Value)
        loc_oBO.this_cMoedas   = ALLTRIM(loc_oPag1.txt_4c_MoedaPend.Value)

        *-- Page2 Pagamento: forma de pagamento
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
        loc_oBO.this_cFpags    = ALLTRIM(loc_oPag2.txt_4c_Fpg.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object para o formulario
    * Campos do cabecalho (datas, conta, numero) adicionados na Fase 5
    * Campos das sub-paginas adicionados nas Fases 6, 7 e 8
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oCab, loc_oPag3, loc_oBO
        loc_oBO   = THIS.this_oBusinessObject
        loc_oCab  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho
        loc_oPag3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3

        *-- Cabecalho
        loc_oCab.txt_4c_NumLancamento.Value  = ALLTRIM(loc_oBO.this_cMascNum)
        loc_oCab.txt_4c_DataLancamento.Value = loc_oBO.this_dDataRcs
        loc_oCab.txt_4c_DataLimite.Value     = loc_oBO.this_dDataLims
        loc_oCab.txt_4c_ContaHeader.Value    = ALLTRIM(loc_oBO.this_cContas)

        *-- Page3 Lancamentos: campos de observacao
        loc_oPag3.edt_4c_Observacao.Value    = ALLTRIM(loc_oBO.this_cObs)

        *-- Page1 Pendencias: campos de filtro e moeda
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_oPag1.txt_4c_GrupoPend.Value     = ALLTRIM(loc_oBO.this_cGrupos)
        loc_oPag1.txt_4c_MoedaPend.Value     = ALLTRIM(loc_oBO.this_cMoedas)

        *-- Page2 Pagamento: forma de pagamento
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
        loc_oPag2.txt_4c_Fpg.Value           = ALLTRIM(loc_oBO.this_cFpags)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    * Campos adicionados nas Fases 5, 6, 7 e 8
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oCab, loc_oPag3
        loc_oCab  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho
        loc_oPag3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3

        *-- Cabecalho: habilitar/desabilitar campos de data e numero
        loc_oCab.txt_4c_NumLancamento.Enabled  = par_lHabilitar
        loc_oCab.txt_4c_DataLancamento.Enabled = par_lHabilitar
        loc_oCab.txt_4c_DataInicial.Enabled    = par_lHabilitar
        loc_oCab.txt_4c_DataLimite.Enabled     = par_lHabilitar

        *-- Page3 Lancamentos
        loc_oPag3.txt_4c_GrEstoque.Enabled  = par_lHabilitar
        loc_oPag3.txt_4c_CdEstoque.Enabled  = par_lHabilitar
        loc_oPag3.txt_4c_FilEmps.Enabled    = par_lHabilitar
        loc_oPag3.txt_4c_CPF.Enabled        = par_lHabilitar
        loc_oPag3.edt_4c_Observacao.Enabled = par_lHabilitar

        *-- Page1 Pendencias: campos editaveis de filtro e baixa
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_oPag1.txt_4c_GrupoPend.Enabled      = par_lHabilitar
        loc_oPag1.txt_4c_ContaPend.Enabled      = par_lHabilitar
        loc_oPag1.txt_4c_HistoricoPend.Enabled  = par_lHabilitar
        loc_oPag1.txt_4c_HistTit.Enabled        = par_lHabilitar
        loc_oPag1.txt_4c_NotaPend.Enabled       = par_lHabilitar
        loc_oPag1.txt_4c_MoedaPend.Enabled      = par_lHabilitar
        loc_oPag1.txt_4c_CotacaoPend.Enabled    = par_lHabilitar
        loc_oPag1.chk_4c_BaixaAut.Enabled       = par_lHabilitar
        loc_oPag1.txt_4c_CtaCob.Enabled         = par_lHabilitar
        loc_oPag1.txt_4c_NomCob.Enabled         = par_lHabilitar
        loc_oPag1.txt_4c_DadosPg.Enabled        = par_lHabilitar

        *-- Page2 Pagamento: campos editaveis de forma de pagamento
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
        loc_oPag2.txt_4c_Fpg.Enabled            = par_lHabilitar
        loc_oPag2.txt_4c_NPar.Enabled           = par_lHabilitar
        loc_oPag2.txt_4c_VPar.Enabled           = par_lHabilitar
        loc_oPag2.txt_4c_Venc.Enabled           = par_lHabilitar
        loc_oPag2.txt_4c_CotacaoPag.Enabled     = par_lHabilitar
        loc_oPag2.edt_4c_ObsPagamento.Enabled   = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oCab, loc_oPag3
        loc_oCab  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho
        loc_oPag3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3

        *-- Cabecalho
        loc_oCab.txt_4c_NumLancamento.Value  = ""
        loc_oCab.txt_4c_DataLancamento.Value = {}
        loc_oCab.txt_4c_DataInicial.Value    = {}
        loc_oCab.txt_4c_DataLimite.Value     = {}
        loc_oCab.txt_4c_ContaHeader.Value    = ""

        *-- Page3 Lancamentos
        loc_oPag3.txt_4c_GrEstoque.Value  = ""
        loc_oPag3.txt_4c_CdEstoque.Value  = ""
        loc_oPag3.txt_4c_DsEstoque.Value  = ""
        loc_oPag3.txt_4c_FilEmps.Value    = ""
        loc_oPag3.txt_4c_CPF.Value        = ""
        loc_oPag3.edt_4c_Observacao.Value = ""

        *-- Page1 Pendencias: limpar campos editaveis
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_oPag1.txt_4c_GrupoPend.Value      = ""
        loc_oPag1.txt_4c_NomeGrupoPend.Value  = ""
        loc_oPag1.txt_4c_ContaPend.Value      = ""
        loc_oPag1.txt_4c_NomeContaPend.Value  = ""
        loc_oPag1.txt_4c_ValorPend.Value      = 0
        loc_oPag1.txt_4c_HistoricoPend.Value  = ""
        loc_oPag1.txt_4c_HistTit.Value        = ""
        loc_oPag1.txt_4c_NotaPend.Value       = ""
        loc_oPag1.txt_4c_MoedaPend.Value      = ""
        loc_oPag1.txt_4c_CotacaoPend.Value    = 0
        loc_oPag1.txt_4c_ValConvPend.Value    = 0
        loc_oPag1.chk_4c_BaixaAut.Value       = 0
        loc_oPag1.txt_4c_CtaCob.Value         = ""
        loc_oPag1.txt_4c_NomCob.Value         = ""
        loc_oPag1.txt_4c_DadosPg.Value        = ""
        IF USED("cursor_4c_Pendencias")
            ZAP IN cursor_4c_Pendencias
        ENDIF
        IF USED("cursor_4c_Total")
            ZAP IN cursor_4c_Total
        ENDIF
        IF USED("cursor_4c_SaldoPend")
            ZAP IN cursor_4c_SaldoPend
        ENDIF

        *-- Page2 Pagamento: limpar campos editaveis
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
        loc_oPag2.txt_4c_Fpg.Value            = ""
        loc_oPag2.txt_4c_NPar.Value           = ""
        loc_oPag2.txt_4c_VPar.Value           = 0
        loc_oPag2.txt_4c_Venc.Value           = {}
        loc_oPag2.txt_4c_CotacaoPag.Value     = 0
        loc_oPag2.edt_4c_ObsPagamento.Value   = ""
        IF USED("cursor_4c_Parcelas")
            ZAP IN cursor_4c_Parcelas
        ENDIF
        IF USED("cursor_4c_TotalPag")
            ZAP IN cursor_4c_TotalPag
        ENDIF
        IF USED("cursor_4c_CashPag")
            ZAP IN cursor_4c_CashPag
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSubPaginaLancamentos - Configura Page3 do PageFrame interno
    * Legado: SIGCDPGR.Pagina.Dados.Pagina.Cadastro (PageOrder=1 - pagina inicial)
    * Sem compensacao +28 (coordenadas relativas a sub-pagina)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSubPaginaLancamentos()
        LOCAL loc_oPag3
        loc_oPag3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3

        *----------------------------------------------------------------------
        *-- Labels de cabecalho da grade de responsaveis
        *----------------------------------------------------------------------
        *-- Label "Responsavel" (Legado: Say8 FontBold Left=12, Top=3)
        loc_oPag3.AddObject("lbl_4c_Responsavel", "Label")
        WITH loc_oPag3.lbl_4c_Responsavel
            .Caption   = "Respons" + CHR(225) + "vel"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 12
            .Top       = 3
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Grupo" (Legado: Say11 Left=12, Top=19)
        loc_oPag3.AddObject("lbl_4c_GrupoCol", "Label")
        WITH loc_oPag3.lbl_4c_GrupoCol
            .Caption   = "Grupo"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 12
            .Top       = 19
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Conta" (Legado: Say10 Left=94, Top=19)
        loc_oPag3.AddObject("lbl_4c_ContaCol", "Label")
        WITH loc_oPag3.lbl_4c_ContaCol
            .Caption   = "Conta"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 94
            .Top       = 19
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Descricao" (Legado: Say6 Left=176, Top=19)
        loc_oPag3.AddObject("lbl_4c_DescricaoCol", "Label")
        WITH loc_oPag3.lbl_4c_DescricaoCol
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 176
            .Top       = 19
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- TextBoxes de identificacao do responsavel
        *----------------------------------------------------------------------
        *-- TextBox grupo estoque (Legado: get_Cd_GrEstoque Left=12, Top=33, Width=80)
        loc_oPag3.AddObject("txt_4c_GrEstoque", "TextBox")
        WITH loc_oPag3.txt_4c_GrEstoque
            .Height        = 25
            .Left          = 12
            .Top           = 33
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag3.txt_4c_GrEstoque, "KeyPress", THIS, "ValidarGrEstoque")
        BINDEVENT(loc_oPag3.txt_4c_GrEstoque, "KeyPress",  THIS, "TeclaGrEstoque")

        *-- TextBox codigo estoque (Legado: get_cd_estoque Left=94, Top=33, Width=80)
        loc_oPag3.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH loc_oPag3.txt_4c_CdEstoque
            .Height        = 25
            .Left          = 94
            .Top           = 33
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag3.txt_4c_CdEstoque, "KeyPress", THIS, "ValidarCdEstoque")
        BINDEVENT(loc_oPag3.txt_4c_CdEstoque, "KeyPress",  THIS, "TeclaCdEstoque")

        *-- TextBox descricao estoque (Legado: get_ds_estoque Left=176, Top=33, Width=328)
        loc_oPag3.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH loc_oPag3.txt_4c_DsEstoque
            .Height        = 25
            .Left          = 176
            .Top           = 33
            .Width         = 328
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label "Empresa :" (Legado: Say14 Left=548, Top=38)
        loc_oPag3.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPag3.lbl_4c_Empresa
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 548
            .Top       = 38
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox empresa filial (Legado: getFilEmps Left=600, Top=33, Width=31)
        loc_oPag3.AddObject("txt_4c_FilEmps", "TextBox")
        WITH loc_oPag3.txt_4c_FilEmps
            .Height        = 25
            .Left          = 600
            .Top           = 33
            .Width         = 31
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag3.txt_4c_FilEmps, "KeyPress", THIS, "ValidarFilEmps")
        BINDEVENT(loc_oPag3.txt_4c_FilEmps, "KeyPress",  THIS, "TeclaFilEmps")

        *----------------------------------------------------------------------
        *-- Busca por CPF/CNPJ
        *----------------------------------------------------------------------
        *-- Label "CPF / CNPJ [Busca]" (Legado: Say1 Left=12, Top=69)
        loc_oPag3.AddObject("lbl_4c_CPFBusca", "Label")
        WITH loc_oPag3.lbl_4c_CPFBusca
            .Caption   = "CPF / CNPJ [Busca]"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 12
            .Top       = 69
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox CPF/CNPJ busca (Legado: Get_cpf Left=12, Top=84, Width=150)
        loc_oPag3.AddObject("txt_4c_CPF", "TextBox")
        WITH loc_oPag3.txt_4c_CPF
            .Height        = 25
            .Left          = 12
            .Top           = 84
            .Width         = 150
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag3.txt_4c_CPF, "KeyPress", THIS, "ValidarCPFBusca")

        *-- Botao carregar dados por CPF (Legado: btnCarregar Left=165, Top=69)
        loc_oPag3.AddObject("cmd_4c_CarregarCliente", "CommandButton")
        WITH loc_oPag3.cmd_4c_CarregarCliente
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
            .PicturePosition = 2
            .Width           = 20
            .Height          = 20
            .Left            = 165
            .Top             = 69
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag3.cmd_4c_CarregarCliente, "Click", THIS, "BtnCarregarClienteClick")

        *----------------------------------------------------------------------
        *-- Separador visual (Legado: Shape1 Top=62, Left=4, Width=984, Height=2)
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("shp_4c_Sep1", "Shape")
        WITH loc_oPag3.shp_4c_Sep1
            .Top           = 62
            .Left          = 4
            .Height        = 2
            .Width         = 984
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- OptionGroup NF (optSNA) - 3 botoes: Sim/Nao/Ambos
        *-- Legado: optSNA Left=824, Top=1, Width=157, Height=27, ButtonCount=3, Value=3
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("opt_4c_NF", "OptionGroup")
        WITH loc_oPag3.opt_4c_NF
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3
            .Height      = 27
            .Left        = 824
            .Top         = 1
            .Width       = 166
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag3.opt_4c_NF.Buttons(1)
            .Caption   = "Sim"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Height    = 15
            .Left      = 2
            .Style     = 0
            .Top       = 5
            .Width     = 34
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag3.opt_4c_NF.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Height    = 15
            .Left      = 52
            .Style     = 0
            .Top       = 5
            .Width     = 37
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag3.opt_4c_NF.Buttons(3)
            .Caption   = "Ambos"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Height    = 17
            .Left      = 99
            .Style     = 0
            .Top       = 5
            .Width     = 57
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPag3.opt_4c_NF, "InteractiveChange", THIS, "OptNFChange")

        *----------------------------------------------------------------------
        *-- Label "Ocorrencias :" (Legado: Say12 Left=806, Top=24)
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("lbl_4c_Ocorrencias", "Label")
        WITH loc_oPag3.lbl_4c_Ocorrencias
            .Caption   = "Ocorr" + CHR(234) + "ncias :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 806
            .Top       = 24
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- OptionGroup Ocorrencias - 2 botoes: Sim/Nao
        *-- Legado: optOcorrencias Left=871, Top=19, Width=94, Height=25, Value=2
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("opt_4c_Ocorrencias", "OptionGroup")
        WITH loc_oPag3.opt_4c_Ocorrencias
            .ButtonCount = 2
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Height      = 25
            .Left        = 871
            .Top         = 19
            .Width       = 99
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag3.opt_4c_Ocorrencias.Buttons(1)
            .Caption   = "Sim"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Height    = 15
            .Left      = 5
            .Style     = 0
            .Top       = 5
            .Width     = 34
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag3.opt_4c_Ocorrencias.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Height    = 15
            .Left      = 52
            .Style     = 0
            .Top       = 5
            .Width     = 37
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPag3.opt_4c_Ocorrencias, "InteractiveChange", THIS, "OptOcorrenciasChange")

        *----------------------------------------------------------------------
        *-- Label "Operadora :" (Legado: Say13 Left=811, Top=43)
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("lbl_4c_Operadora", "Label")
        WITH loc_oPag3.lbl_4c_Operadora
            .Caption   = "Operadora :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 811
            .Top       = 43
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- OptionGroup Operadora - 2 botoes: Sim/Nao
        *-- Legado: optOperadora Left=871, Top=38, Width=94, Height=25, Value=2
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("opt_4c_Operadora", "OptionGroup")
        WITH loc_oPag3.opt_4c_Operadora
            .ButtonCount = 2
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Height      = 25
            .Left        = 871
            .Top         = 38
            .Width       = 99
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag3.opt_4c_Operadora.Buttons(1)
            .Caption   = "Sim"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Height    = 15
            .Left      = 5
            .Style     = 0
            .Top       = 5
            .Width     = 34
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag3.opt_4c_Operadora.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Height    = 15
            .Left      = 52
            .Style     = 0
            .Top       = 5
            .Width     = 37
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPag3.opt_4c_Operadora, "InteractiveChange", THIS, "OptOperadoraChange")

        *----------------------------------------------------------------------
        *-- Grid de clientes / responsaveis
        *-- Legado: Grd_Clientes Top=111, Left=12, Width=801, Height=274
        *-- 5 colunas (ordem visual): Grupo(80), NomeGrupo(183), Conta(80),
        *--                            Nome/Descricao(357), Antecipacao(75)
        *-- CRITICO: RecordSource e ControlSource configurados em CarregarGradeClientes()
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("grd_4c_Clientes", "Grid")
        WITH loc_oPag3.grd_4c_Clientes
            .Top               = 111
            .Left              = 12
            .Height            = 274
            .Width             = 801
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLines         = 3
            .GridLineColor     = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH
        loc_oPag3.grd_4c_Clientes.ColumnCount = 5

        *----------------------------------------------------------------------
        *-- ComboBox CNAB (Legado: cmbCnab Left=818, Top=113, Width=162)
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("cmb_4c_CNAB", "ComboBox")
        WITH loc_oPag3.cmb_4c_CNAB
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Bradesco,Ita" + CHR(250) + ",Banco do Brasil,Santander"
            .Height        = 24
            .Left          = 818
            .SpecialEffect = 1
            .Top           = 113
            .Width         = 162
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Botao CNAB (Legado: btnCNAB Left=819, Top=144, Width=75, Height=75)
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("cmd_4c_CNAB", "CommandButton")
        WITH loc_oPag3.cmd_4c_CNAB
            .Caption         = "CNAB"
            .Picture         = gc_4c_CaminhoIcones + "importar_72.png"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 819
            .Top             = 144
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag3.cmd_4c_CNAB, "Click", THIS, "BtnCNABClick")

        *----------------------------------------------------------------------
        *-- Botao Processar (Legado: Processa Left=819, Top=219, Width=75, Height=75)
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oPag3.cmd_4c_Processar
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 819
            .Top             = 219
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag3.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *----------------------------------------------------------------------
        *-- Botao Reprocessar (Legado: Reprocessa Left=819, Top=295, Visible=.F.)
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("cmd_4c_Reprocessar", "CommandButton")
        WITH loc_oPag3.cmd_4c_Reprocessar
            .Caption         = "Reprocessar"
            .Picture         = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 819
            .Top             = 295
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.   && sera oculto apos TornarControlesVisiveis
        ENDWITH
        BINDEVENT(loc_oPag3.cmd_4c_Reprocessar, "Click", THIS, "BtnReprocessarClick")

        *----------------------------------------------------------------------
        *-- Label "Observacao :" (Legado: Say7 FontBold Left=13, Top=384)
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("lbl_4c_Observacao", "Label")
        WITH loc_oPag3.lbl_4c_Observacao
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 13
            .Top       = 384
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Memo de observacao (Legado: fwmemo1 Left=12, Top=397, Width=551, H=83)
        *-- BaseClass EditBox equivale ao fwmemo do Framework
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("edt_4c_Observacao", "EditBox")
        WITH loc_oPag3.edt_4c_Observacao
            .Height        = 83
            .Left          = 12
            .Top           = 397
            .Width         = 551
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Botao Boleto (Legado: Boleto Left=570, Top=401, Width=75, Visible=.F.)
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("cmd_4c_Boleto", "CommandButton")
        WITH loc_oPag3.cmd_4c_Boleto
            .Caption         = "Boleto"
            .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 570
            .Top             = 401
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.   && sera oculto apos TornarControlesVisiveis
        ENDWITH
        BINDEVENT(loc_oPag3.cmd_4c_Boleto, "Click", THIS, "BtnBoletoClick")

        *----------------------------------------------------------------------
        *-- Botao Documento (Legado: Documento Left=645, Top=401, Visible=.F.)
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("cmd_4c_Documento", "CommandButton")
        WITH loc_oPag3.cmd_4c_Documento
            .Caption         = "Documento"
            .Picture         = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 645
            .Top             = 401
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.   && sera oculto apos TornarControlesVisiveis
        ENDWITH
        BINDEVENT(loc_oPag3.cmd_4c_Documento, "Click", THIS, "BtnDocumentoClick")

        *----------------------------------------------------------------------
        *-- Botao Recibo (Legado: Recibo Left=720, Top=401, Visible=.F.)
        *----------------------------------------------------------------------
        loc_oPag3.AddObject("cmd_4c_Recibo", "CommandButton")
        WITH loc_oPag3.cmd_4c_Recibo
            .Caption         = "Recibo"
            .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 720
            .Top             = 401
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.   && sera oculto apos TornarControlesVisiveis
        ENDWITH
        BINDEVENT(loc_oPag3.cmd_4c_Recibo, "Click", THIS, "BtnReciboClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeClientes - Carrega dados no grd_4c_Clientes
    * CRITICO: RecordSource e ControlSource SEMPRE fora do WITH block
    * CRITICO: Headers SEMPRE apos RecordSource
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradeClientes()
        LOCAL loc_oGrid, loc_lResultado
        loc_lResultado = .F.
        loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3.grd_4c_Clientes

        TRY
            *-- 1. RecordSource FORA do WITH (CRITICO - reseta colunas)
            loc_oGrid.ColumnCount = 5
            loc_oGrid.RecordSource = "cursor_4c_Clientes"

            *-- 2. ControlSource OBRIGATORIO APOS RecordSource
            *-- Ordem visual: Grupo(1), NomeGrupo(2), Conta(3), Nome(4), Antecipacao(5)
            loc_oGrid.Column1.ControlSource = "cursor_4c_Clientes.grupo"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Clientes.nomgrupo"
            loc_oGrid.Column3.ControlSource = "cursor_4c_Clientes.conta"
            loc_oGrid.Column4.ControlSource = "cursor_4c_Clientes.nome"
            loc_oGrid.Column5.ControlSource = "cursor_4c_Clientes.nfechas"

            *-- 3. Larguras APOS RecordSource
            loc_oGrid.Column1.Width = 80
            loc_oGrid.Column2.Width = 183
            loc_oGrid.Column3.Width = 80
            loc_oGrid.Column4.Width = 357
            loc_oGrid.Column5.Width = 75

            *-- 4. Cabecalhos APOS RecordSource
            loc_oGrid.Column1.Header1.Caption = "Grupo"
            loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oGrid.Column3.Header1.Caption = "Conta"
            loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oGrid.Column5.Header1.Caption = "Antecipa" + CHR(231) + CHR(227) + "o"

            *-- 5. Movable/Resizable APOS RecordSource
            loc_oGrid.Column1.Movable   = .F.
            loc_oGrid.Column2.Movable   = .F.
            loc_oGrid.Column3.Movable   = .F.
            loc_oGrid.Column4.Movable   = .F.
            loc_oGrid.Column5.Movable   = .F.
            loc_oGrid.Column1.Resizable = .F.
            loc_oGrid.Column2.Resizable = .F.
            loc_oGrid.Column3.Resizable = .F.
            loc_oGrid.Column4.Resizable = .F.
            loc_oGrid.Column5.Resizable = .F.

            loc_lResultado = .T.

        CATCH TO loException
            MostrarErro("Erro ao carregar grade de clientes:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSubPaginaPendencias - Configura Page1 do PageFrame interno
    * Legado: SIGCDPGR.Pagina.Dados.Pagina.Pendencias (PageOrder=2, Enabled=.F.)
    * Sem compensacao +28 (coordenadas relativas a sub-pagina)
    * CRITICO: ContaCorrente tem CheckBox em Column1 - cursor placeholder L obrigatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSubPaginaPendencias()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1

        *-- CRITICO: Cursor placeholder com campo L ANTES do grid com CheckBox
        .AddObject("Check1", "CheckBox")
        .Check1.Caption = ""
        *-- Sem isso: "Data type mismatch" ao definir Column1.CurrentControl="Check1"
        SET NULL ON
        CREATE CURSOR cursor_4c_Pendencias ;
            (Flag L, Emps C(3), Datas D, Vencs D, ;
             Valos N(13,2), Acerto N(13,2), Moedas C(3), ;
             Nomes C(100), OrdCopChS N(4))
        SET NULL OFF

        *----------------------------------------------------------------------
        *-- Grid ContaCorrente - grade principal de titulos em aberto
        *-- Legado: Top=11, Left=8, Height=309, Width=982, ColumnCount=10
        *-- Visual order (ColumnOrder): Flag(1), Emps(2), Datas(3), Vencs(4),
        *--   Debito(5), Credito(6), Acerto(7), Moedas(8), Historico(9), Ordem(10)
        *-- CRITICO: ColumnCount e RecordSource FORA do WITH block
        *----------------------------------------------------------------------
        loc_oPag1.AddObject("grd_4c_ContaCorrente", "Grid")
        WITH loc_oPag1.grd_4c_ContaCorrente
            .Top               = 11
            .Left              = 8
            .Height            = 309
            .Width             = 982
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLines         = 3
            .GridLineColor     = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight         = 16
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.ColumnCount   = 10
        loc_oPag1.grd_4c_ContaCorrente.RecordSource  = "cursor_4c_Pendencias"

        *-- CRITICO: ControlSource OBRIGATORIO APOS RecordSource (auto-bind por ordem do cursor)
        *-- Column1.ControlSource permanece apos AddObject+CurrentControl (exigencia do CheckBox)
        loc_oPag1.grd_4c_ContaCorrente.Column2.ControlSource  = "cursor_4c_Pendencias.Emps"
        loc_oPag1.grd_4c_ContaCorrente.Column3.ControlSource  = "cursor_4c_Pendencias.Datas"
        loc_oPag1.grd_4c_ContaCorrente.Column4.ControlSource  = "cursor_4c_Pendencias.Vencs"
        loc_oPag1.grd_4c_ContaCorrente.Column5.ControlSource  = "cursor_4c_Pendencias.Valos"
        loc_oPag1.grd_4c_ContaCorrente.Column6.ControlSource  = "cursor_4c_Pendencias.Valos"
        loc_oPag1.grd_4c_ContaCorrente.Column7.ControlSource  = "cursor_4c_Pendencias.Acerto"
        loc_oPag1.grd_4c_ContaCorrente.Column8.ControlSource  = "cursor_4c_Pendencias.Moedas"
        loc_oPag1.grd_4c_ContaCorrente.Column9.ControlSource  = "cursor_4c_Pendencias.Nomes"
        loc_oPag1.grd_4c_ContaCorrente.Column10.ControlSource = "cursor_4c_Pendencias.OrdCopChS"

        *-- Column1: Flag/Marca (CheckBox) - Width=15
        *-- CRITICO: AddObject("Check1","CheckBox") ANTES de CurrentControl
        *-- CRITICO: Column1.ControlSource APOS CurrentControl, NUNCA Check1.ControlSource
        WITH loc_oPag1.grd_4c_ContaCorrente.Column1
            .Width     = 15
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "X"
            .Header1.FontBold  = .T.
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.Column1.AddObject("Check1", "CheckBox")
        WITH loc_oPag1.grd_4c_ContaCorrente.Column1.Check1
            .Caption   = ""
            .BackStyle = 0
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.Column1.AddObject("check12", "CheckBox")
        loc_oPag1.grd_4c_ContaCorrente.Column1.check12.Caption = ""
        loc_oPag1.grd_4c_ContaCorrente.Column1.CurrentControl = "check12"
        loc_oPag1.grd_4c_ContaCorrente.Column1.ControlSource  = "cursor_4c_Pendencias.Flag"

        *-- Column2: Emps (Emp) - Width=36, ColumnOrder=2
        WITH loc_oPag1.grd_4c_ContaCorrente.Column2
            .Width     = 36
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Emp"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.Column2.ControlSource = "cursor_4c_Pendencias.Emps"

        *-- Column3: Datas (Data) - Width=70, ColumnOrder=3
        WITH loc_oPag1.grd_4c_ContaCorrente.Column3
            .Width     = 70
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Data"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.Column3.ControlSource = "cursor_4c_Pendencias.Datas"

        *-- Column4: Vencs (Vencimento) - Width=70, ColumnOrder=4
        WITH loc_oPag1.grd_4c_ContaCorrente.Column4
            .Width     = 70
            .Movable   = .F.
            .Resizable = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Vencimento"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.Column4.ControlSource = "cursor_4c_Pendencias.Vencs"

        *-- Column5: Valos/Debito - Width=80, ColumnOrder=5
        WITH loc_oPag1.grd_4c_ContaCorrente.Column5
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .InputMask = "999,999,999.99"
            .Format    = "Z"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "D" + CHR(233) + "bito"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.Column5.ControlSource = "cursor_4c_Pendencias.Valos"

        *-- Column6: Valos/Credito - Width=80, ColumnOrder=6
        WITH loc_oPag1.grd_4c_ContaCorrente.Column6
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .InputMask = "999,999,999.99"
            .Format    = "Z"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Cr" + CHR(233) + "dito"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.Column6.ControlSource = "cursor_4c_Pendencias.Valos"

        *-- Column7: Acerto - Width=80, ColumnOrder=7
        WITH loc_oPag1.grd_4c_ContaCorrente.Column7
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "999,999,999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Acerto"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.Column7.ControlSource = "cursor_4c_Pendencias.Acerto"

        *-- Column8: Moedas - Width=32, ColumnOrder=8
        WITH loc_oPag1.grd_4c_ContaCorrente.Column8
            .Width     = 32
            .Movable   = .F.
            .Resizable = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Moe"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.Column8.ControlSource = "cursor_4c_Pendencias.Moedas"

        *-- Column9: Nomes/Historico - Width=437, ColumnOrder=9
        WITH loc_oPag1.grd_4c_ContaCorrente.Column9
            .Width     = 437
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Hist" + CHR(243) + "rico"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.Column9.ControlSource = "cursor_4c_Pendencias.Nomes"

        *-- Column10: OrdCopChS/Ordem - Width=40
        WITH loc_oPag1.grd_4c_ContaCorrente.Column10
            .Width     = 40
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Header1.Caption   = "Ordem"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH
        loc_oPag1.grd_4c_ContaCorrente.Column10.ControlSource = "cursor_4c_Pendencias.OrdCopChS"

        BINDEVENT(loc_oPag1.grd_4c_ContaCorrente, "AfterRowColChange", THIS, "GradeContaCorrenteChange")

        *----------------------------------------------------------------------
        *-- Labels de cabecalho e campos abaixo do grid
        *-- Legado: Label4="Grupo", Label5="Conta" - acima dos campos
        *----------------------------------------------------------------------
        loc_oPag1.AddObject("lbl_4c_GrupoPend", "Label")
        WITH loc_oPag1.lbl_4c_GrupoPend
            .Caption   = "Grupo"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 12
            .Top       = 325
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag1.AddObject("lbl_4c_ContaPend", "Label")
        WITH loc_oPag1.lbl_4c_ContaPend
            .Caption   = "Conta"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 89
            .Top       = 325
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Grupo (Left=12, Top=338, Width=75)
        loc_oPag1.AddObject("txt_4c_GrupoPend", "TextBox")
        WITH loc_oPag1.txt_4c_GrupoPend
            .Height        = 25
            .Left          = 12
            .Top           = 338
            .Width         = 75
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.txt_4c_GrupoPend, "KeyPress", THIS, "ValidarGrupoPend")
        BINDEVENT(loc_oPag1.txt_4c_GrupoPend, "KeyPress",  THIS, "TeclaGrupoPend")

        *-- Get_NomeGrupo (Left=89, Top=338, Width=183 - descricao do grupo)
        loc_oPag1.AddObject("txt_4c_NomeGrupoPend", "TextBox")
        WITH loc_oPag1.txt_4c_NomeGrupoPend
            .Height        = 25
            .Left          = 89
            .Top           = 338
            .Width         = 183
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Get_Conta (Left=277, Top=338, Width=80)
        loc_oPag1.AddObject("txt_4c_ContaPend", "TextBox")
        WITH loc_oPag1.txt_4c_ContaPend
            .Height        = 25
            .Left          = 277
            .Top           = 338
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.txt_4c_ContaPend, "KeyPress", THIS, "ValidarContaPend")
        BINDEVENT(loc_oPag1.txt_4c_ContaPend, "KeyPress",  THIS, "TeclaContaPend")

        *-- Get_NomeConta (Left=360, Top=338, Width=183 - descricao da conta)
        loc_oPag1.AddObject("txt_4c_NomeContaPend", "TextBox")
        WITH loc_oPag1.txt_4c_NomeContaPend
            .Height        = 25
            .Left          = 360
            .Top           = 338
            .Width         = 183
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Campos de rodape (Valor, Historico, Nota, Moeda, Cotacao, ValConv)
        *-- Legado: Get_Valor Left=63 Top=328, Get_Historico Left=166 Top=393
        *----------------------------------------------------------------------
        *-- Get_Valor (Left=63, Top=396, Width=90)
        loc_oPag1.AddObject("txt_4c_ValorPend", "TextBox")
        WITH loc_oPag1.txt_4c_ValorPend
            .Height        = 20
            .Left          = 63
            .Top           = 396
            .Width         = 90
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        loc_oPag1.AddObject("lbl_4c_ValorPend", "Label")
        WITH loc_oPag1.lbl_4c_ValorPend
            .Caption   = "Valor"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 25
            .Top       = 399
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Historico (Left=166, Top=393, Width=270)
        loc_oPag1.AddObject("txt_4c_HistoricoPend", "TextBox")
        WITH loc_oPag1.txt_4c_HistoricoPend
            .Height        = 25
            .Left          = 166
            .Top           = 393
            .Width         = 270
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Get_HistTit (Left=166, Top=420, Width=270)
        loc_oPag1.AddObject("txt_4c_HistTit", "TextBox")
        WITH loc_oPag1.txt_4c_HistTit
            .Height        = 25
            .Left          = 166
            .Top           = 420
            .Width         = 270
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label "Say1" (legado: "Hist" label)
        loc_oPag1.AddObject("lbl_4c_HistPend", "Label")
        WITH loc_oPag1.lbl_4c_HistPend
            .Caption   = "Hist"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 155
            .Top       = 397
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Nota (Left=545, Top=393, Width=80)
        loc_oPag1.AddObject("txt_4c_NotaPend", "TextBox")
        WITH loc_oPag1.txt_4c_NotaPend
            .Height        = 25
            .Left          = 545
            .Top           = 393
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Get_moeda (Left=545, Top=420, Width=32)
        loc_oPag1.AddObject("txt_4c_MoedaPend", "TextBox")
        WITH loc_oPag1.txt_4c_MoedaPend
            .Height        = 25
            .Left          = 545
            .Top           = 420
            .Width         = 32
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.txt_4c_MoedaPend, "KeyPress", THIS, "ValidarMoedaPend")
        BINDEVENT(loc_oPag1.txt_4c_MoedaPend, "KeyPress",  THIS, "TeclaMoedaPend")

        *-- Get_Cotacao (Left=620, Top=393, Width=90)
        loc_oPag1.AddObject("txt_4c_CotacaoPend", "TextBox")
        WITH loc_oPag1.txt_4c_CotacaoPend
            .Height        = 25
            .Left          = 620
            .Top           = 393
            .Width         = 90
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .Visible       = .T.
        ENDWITH

        *-- Get_ValConv (Left=620, Top=420, Width=90, ReadOnly)
        loc_oPag1.AddObject("txt_4c_ValConvPend", "TextBox")
        WITH loc_oPag1.txt_4c_ValConvPend
            .Height        = 25
            .Left          = 620
            .Top           = 420
            .Width         = 90
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Alignment     = 3
            .Visible       = .T.
        ENDWITH

        *-- Label Say_Cotacao
        loc_oPag1.AddObject("lbl_4c_SayCotacao", "Label")
        WITH loc_oPag1.lbl_4c_SayCotacao
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 580
            .Top       = 397
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label Say_ValConv
        loc_oPag1.AddObject("lbl_4c_SayValConv", "Label")
        WITH loc_oPag1.lbl_4c_SayValConv
            .Caption   = "Convertido"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 580
            .Top       = 424
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- CheckBox BaixaAut (Legado: Left=160, Top=393)
        loc_oPag1.AddObject("chk_4c_BaixaAut", "CheckBox")
        WITH loc_oPag1.chk_4c_BaixaAut
            .Caption       = "Baixa Autom" + CHR(225) + "tica"
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Left          = 160
            .Top           = 393
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grid Total (totais de debito/credito)
        *-- Legado: Total Left=8, Top=324, Height=50, Width=145, ColumnCount=2
        *----------------------------------------------------------------------
        SET NULL ON
        CREATE CURSOR cursor_4c_Total (Moeda C(3), ValorPend N(13,2), ValorAce N(13,2))
        SET NULL OFF

        loc_oPag1.AddObject("grd_4c_Total", "Grid")
        WITH loc_oPag1.grd_4c_Total
            .Top               = 324
            .Left              = 8
            .Height            = 50
            .Width             = 145
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLines         = 3
            .GridLineColor     = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH
        loc_oPag1.grd_4c_Total.ColumnCount              = 2
        loc_oPag1.grd_4c_Total.RecordSource             = "cursor_4c_Total"
        loc_oPag1.grd_4c_Total.Column1.ControlSource    = "cursor_4c_Total.Moeda"
        loc_oPag1.grd_4c_Total.Column2.ControlSource    = "cursor_4c_Total.ValorPend"
        loc_oPag1.grd_4c_Total.Column1.Width            = 50
        loc_oPag1.grd_4c_Total.Column2.Width            = 90
        loc_oPag1.grd_4c_Total.Column1.Header1.Caption  = "Moeda"
        loc_oPag1.grd_4c_Total.Column2.Header1.Caption  = "Pendente"
        loc_oPag1.grd_4c_Total.Column1.Movable          = .F.
        loc_oPag1.grd_4c_Total.Column2.Movable          = .F.

        *----------------------------------------------------------------------
        *-- Grid Grd_Saldo (saldos de conta corrente)
        *-- Legado: Grd_Saldo Left=161, Top=324, Height=50, Width=272, ColumnCount=4
        *----------------------------------------------------------------------
        SET NULL ON
        CREATE CURSOR cursor_4c_SaldoPend ;
            (Banco C(5), Saldo N(13,2), Pendente N(13,2), Disponivel N(13,2))
        SET NULL OFF

        loc_oPag1.AddObject("grd_4c_Saldos", "Grid")
        WITH loc_oPag1.grd_4c_Saldos
            .Top               = 324
            .Left              = 161
            .Height            = 50
            .Width             = 272
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLines         = 3
            .GridLineColor     = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH
        loc_oPag1.grd_4c_Saldos.ColumnCount              = 4
        loc_oPag1.grd_4c_Saldos.RecordSource             = "cursor_4c_SaldoPend"
        loc_oPag1.grd_4c_Saldos.Column1.ControlSource    = "cursor_4c_SaldoPend.Banco"
        loc_oPag1.grd_4c_Saldos.Column2.ControlSource    = "cursor_4c_SaldoPend.Saldo"
        loc_oPag1.grd_4c_Saldos.Column3.ControlSource    = "cursor_4c_SaldoPend.Pendente"
        loc_oPag1.grd_4c_Saldos.Column4.ControlSource    = "cursor_4c_SaldoPend.Disponivel"
        loc_oPag1.grd_4c_Saldos.Column1.Width            = 50
        loc_oPag1.grd_4c_Saldos.Column2.Width            = 72
        loc_oPag1.grd_4c_Saldos.Column3.Width            = 72
        loc_oPag1.grd_4c_Saldos.Column4.Width            = 72
        loc_oPag1.grd_4c_Saldos.Column1.Header1.Caption  = "Moe"
        loc_oPag1.grd_4c_Saldos.Column2.Header1.Caption  = "Valor"
        loc_oPag1.grd_4c_Saldos.Column3.Header1.Caption  = "Pendente"
        loc_oPag1.grd_4c_Saldos.Column4.Header1.Caption  = "Header1"
        loc_oPag1.grd_4c_Saldos.Column1.Movable          = .F.
        loc_oPag1.grd_4c_Saldos.Column2.Movable          = .F.
        loc_oPag1.grd_4c_Saldos.Column3.Movable          = .F.
        loc_oPag1.grd_4c_Saldos.Column4.Movable          = .F.

        *-- Label Lbl_Saldo
        loc_oPag1.AddObject("lbl_4c_Saldo", "Label")
        WITH loc_oPag1.lbl_4c_Saldo
            .Caption   = "Saldo"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 161
            .Top       = 312
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- OptionGroup OptOpcao (D/C/Todos)
        *-- Legado: OptOpcao Left=746, Top=325, Width=240, ButtonCount=3, Value=3
        *----------------------------------------------------------------------
        loc_oPag1.AddObject("opt_4c_Opcao", "OptionGroup")
        WITH loc_oPag1.opt_4c_Opcao
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3
            .Height      = 25
            .Left        = 746
            .Top         = 325
            .Width       = 240
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag1.opt_4c_Opcao.Buttons(1)
            .Caption   = "D" + CHR(233) + "bito"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Height    = 15
            .Left      = 2
            .Style     = 0
            .Top       = 5
            .Width     = 48
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag1.opt_4c_Opcao.Buttons(2)
            .Caption   = "Cr" + CHR(233) + "dito"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Height    = 15
            .Left      = 70
            .Style     = 0
            .Top       = 5
            .Width     = 50
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag1.opt_4c_Opcao.Buttons(3)
            .Caption   = "Todos"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Height    = 15
            .Left      = 140
            .Style     = 0
            .Top       = 5
            .Width     = 50
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPag1.opt_4c_Opcao, "InteractiveChange", THIS, "OptOpcaoChange")

        *----------------------------------------------------------------------
        *-- cntMulta - Container de multa/juros
        *-- Legado: cntMulta Left=740, Top=390, Width=200, Height=60
        *----------------------------------------------------------------------
        loc_oPag1.AddObject("cnt_4c_Multa", "Container")
        WITH loc_oPag1.cnt_4c_Multa
            .Top         = 390
            .Left        = 740
            .Width       = 200
            .Height      = 60
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oPag1.cnt_4c_Multa.AddObject("lbl_4c_Juros", "Label")
        WITH loc_oPag1.cnt_4c_Multa.lbl_4c_Juros
            .Caption   = "Juros"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPag1.cnt_4c_Multa.AddObject("txt_4c_Juros", "TextBox")
        WITH loc_oPag1.cnt_4c_Multa.txt_4c_Juros
            .Height        = 20
            .Left          = 45
            .Top           = 3
            .Width         = 90
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .Visible       = .T.
        ENDWITH
        loc_oPag1.cnt_4c_Multa.AddObject("lbl_4c_Multa", "Label")
        WITH loc_oPag1.cnt_4c_Multa.lbl_4c_Multa
            .Caption   = "Multa"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 33
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPag1.cnt_4c_Multa.AddObject("txt_4c_MultaVal", "TextBox")
        WITH loc_oPag1.cnt_4c_Multa.txt_4c_MultaVal
            .Height        = 20
            .Left          = 45
            .Top           = 31
            .Width         = 90
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Botoes de acao
        *----------------------------------------------------------------------
        *-- Botao NovoLacto (Legado: NovoLancto Left=486, Top=422)
        loc_oPag1.AddObject("cmd_4c_NovoLacto", "CommandButton")
        WITH loc_oPag1.cmd_4c_NovoLacto
            .Caption         = "Novo"
            .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_32.jpg"
            .PicturePosition = 13
            .Width           = 45
            .Height          = 38
            .Left            = 486
            .Top             = 422
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_NovoLacto, "Click", THIS, "BtnNovoLactoClick")

        *-- Botao PagamentoUnico (Legado: PagamentoUnico Left=535, Top=422)
        loc_oPag1.AddObject("cmd_4c_PagUnico", "CommandButton")
        WITH loc_oPag1.cmd_4c_PagUnico
            .Caption         = "Pag. " + CHR(218) + "nico"
            .Picture         = gc_4c_CaminhoIcones + "geral_boleto_32.jpg"
            .PicturePosition = 13
            .Width           = 60
            .Height          = 38
            .Left            = 535
            .Top             = 422
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_PagUnico, "Click", THIS, "BtnPagUnicoClick")

        *-- Botao Anexa (Legado: Anexa Left=436, Top=422)
        loc_oPag1.AddObject("cmd_4c_Anexa", "CommandButton")
        WITH loc_oPag1.cmd_4c_Anexa
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_pastas_32.jpg"
            .PicturePosition = 2
            .Width           = 45
            .Height          = 38
            .Left            = 436
            .Top             = 422
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Anexa, "Click", THIS, "BtnAnexaClick")

        *-- Botao AltCotacao (Legado: AltCotacao Left=716, Top=393)
        loc_oPag1.AddObject("cmd_4c_AltCotacao", "CommandButton")
        WITH loc_oPag1.cmd_4c_AltCotacao
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_coleta_20.jpg"
            .PicturePosition = 2
            .Width           = 20
            .Height          = 20
            .Left            = 716
            .Top             = 393
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_AltCotacao, "Click", THIS, "BtnAltCotacaoClick")

        *-- Botao cmdMarcar (Legado: cmdMarcar Left=750, Top=422)
        loc_oPag1.AddObject("cmd_4c_Marcar", "CommandButton")
        WITH loc_oPag1.cmd_4c_Marcar
            .Caption       = "Marcar Todos"
            .Width         = 90
            .Height        = 25
            .Left          = 750
            .Top           = 422
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 1
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Marcar, "Click", THIS, "BtnMarcarClick")

        *-- Botao btnBusNFs (Legado: btnBusNFs Left=436, Top=460)
        loc_oPag1.AddObject("cmd_4c_BusNFs", "CommandButton")
        WITH loc_oPag1.cmd_4c_BusNFs
            .Caption         = "  Busca NF"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_seta_esquerda_20.jpg"
            .PicturePosition = 0
            .Width           = 103
            .Height          = 20
            .Left            = 436
            .Top             = 460
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_BusNFs, "Click", THIS, "BtnBusNFsClick")

        *-- Botao btnCadastros (Legado: btnCadastros Left=850, Top=422)
        loc_oPag1.AddObject("cmd_4c_Cadastros", "CommandButton")
        WITH loc_oPag1.cmd_4c_Cadastros
            .Caption       = "Cadastros"
            .Width         = 75
            .Height        = 25
            .Left          = 850
            .Top           = 422
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 1
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cmd_4c_Cadastros, "Click", THIS, "BtnCadastrosClick")

        *----------------------------------------------------------------------
        *-- Dados de cobranca (getNomCob, getCtaCob, Get_DadosPg)
        *----------------------------------------------------------------------
        loc_oPag1.AddObject("lbl_4c_Cobrador", "Label")
        WITH loc_oPag1.lbl_4c_Cobrador
            .Caption   = "Cobrador"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 600
            .Top       = 449
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPag1.AddObject("txt_4c_CtaCob", "TextBox")
        WITH loc_oPag1.txt_4c_CtaCob
            .Height        = 20
            .Left          = 655
            .Top           = 448
            .Width         = 60
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        loc_oPag1.AddObject("txt_4c_NomCob", "TextBox")
        WITH loc_oPag1.txt_4c_NomCob
            .Height        = 20
            .Left          = 720
            .Top           = 448
            .Width         = 120
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        loc_oPag1.AddObject("txt_4c_DadosPg", "TextBox")
        WITH loc_oPag1.txt_4c_DadosPg
            .Height        = 20
            .Left          = 850
            .Top           = 448
            .Width         = 120
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container cnt_4c_NovaPendencia (FLOATING - permanece oculto)
        *-- Legado: NovaPendencia Top=28, Left=222, Width=550, Height=289, Visible=.F.
        *-- TornarControlesVisiveis ja exclui CNT_4C_NOVAPENDENCIA por nome
        *----------------------------------------------------------------------
        loc_oPag1.AddObject("cnt_4c_NovaPendencia", "Container")
        WITH loc_oPag1.cnt_4c_NovaPendencia
            .Top           = 28
            .Left          = 222
            .Width         = 550
            .Height        = 289
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 255)
            .BorderWidth   = 2
            .BorderColor   = RGB(36, 84, 155)
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH
        *-- Titulo "Novo Lancamento" (Label8)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_TituloNP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_TituloNP
            .Caption   = "Novo Lan" + CHR(231) + "amento"
            .FontName  = "Tahoma"
            .FontSize  = 15
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 6
            .Top       = 2
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Titulo1 " Lancamento :"
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_TituloLanc", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_TituloLanc
            .Caption   = " Lan" + CHR(231) + "amento : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 2
            .Top       = 23
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Titulo2 " Contra-Partida :"
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_TituloCP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_TituloCP
            .Caption   = " Contra-Partida : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 7
            .Top       = 126
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Label "Grupo" (Label1, Left=45, Top=46)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_GrupoNP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_GrupoNP
            .Caption   = "Grupo : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 45
            .Top       = 46
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_Grupo (Left=88, Top=41, Width=80)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_GrupoNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_GrupoNP
            .Height        = 25
            .Left          = 88
            .Top           = 41
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.txt_4c_GrupoNP, "KeyPress", THIS, "ValidarGrupoNP")
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.txt_4c_GrupoNP, "KeyPress",  THIS, "TeclaGrupoNP")
        *-- Get_NGrupo (Left=170, Top=41, Width=150)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_NGrupoNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_NGrupoNP
            .Height        = 25
            .Left          = 170
            .Top           = 41
            .Width         = 150
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        *-- Label "Conta" (Label2, Left=45, Top=72)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_ContaNP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_ContaNP
            .Caption   = "Conta : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 45
            .Top       = 72
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_Conta (Left=88, Top=68, Width=80)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_ContaNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_ContaNP
            .Height        = 25
            .Left          = 88
            .Top           = 68
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.txt_4c_ContaNP, "KeyPress", THIS, "ValidarContaNP")
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.txt_4c_ContaNP, "KeyPress",  THIS, "TeclaContaNP")
        *-- Get_NConta (Left=170, Top=68, Width=360)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_NContaNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_NContaNP
            .Height        = 25
            .Left          = 170
            .Top           = 68
            .Width         = 360
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        *-- Label "Valor" (Label5, Left=50, Top=100)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_ValorNP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_ValorNP
            .Caption   = "Valor : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 50
            .Top       = 100
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_Valor (Left=88, Top=95, Width=120)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_ValorNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_ValorNP
            .Height        = 25
            .Left          = 88
            .Top           = 95
            .Width         = 120
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999,999,999.99"
            .Visible       = .T.
        ENDWITH
        *-- Get_moeda (Left=210, Top=95, Width=32)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_MoedaNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_MoedaNP
            .Height        = 25
            .Left          = 210
            .Top           = 95
            .Width         = 32
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.txt_4c_MoedaNP, "KeyPress", THIS, "ValidarMoedaNP")
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.txt_4c_MoedaNP, "KeyPress",  THIS, "TeclaMoedaNP")
        *-- Label "Operacao" (Say3, Left=252, Top=100)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_OperNP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_OperNP
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 252
            .Top       = 100
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_OPER (Left=316, Top=96, Width=15)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_OperNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_OperNP
            .Height        = 25
            .Left          = 316
            .Top           = 96
            .Width         = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "!"
            .Visible       = .T.
        ENDWITH
        *-- Label "Grupo CP" (Label6, Left=45, Top=149)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_GrupoCNP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_GrupoCNP
            .Caption   = "Grupo : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 45
            .Top       = 149
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_GrupoC (Left=88, Top=144, Width=80)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_GrupoCNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_GrupoCNP
            .Height        = 25
            .Left          = 88
            .Top           = 144
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.txt_4c_GrupoCNP, "KeyPress", THIS, "ValidarGrupoCNP")
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.txt_4c_GrupoCNP, "KeyPress",  THIS, "TeclaGrupoCNP")
        *-- Get_NGrupoC (Left=170, Top=144, Width=150)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_NGrupoCNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_NGrupoCNP
            .Height        = 25
            .Left          = 170
            .Top           = 144
            .Width         = 150
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        *-- Label "Conta CP" (Label7, Left=45, Top=175)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_ContaCNP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_ContaCNP
            .Caption   = "Conta : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 45
            .Top       = 175
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_ContaC (Left=88, Top=171, Width=80)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_ContaCNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_ContaCNP
            .Height        = 25
            .Left          = 88
            .Top           = 171
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.txt_4c_ContaCNP, "KeyPress", THIS, "ValidarContaCNP")
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.txt_4c_ContaCNP, "KeyPress",  THIS, "TeclaContaCNP")
        *-- Get_NContaC (Left=170, Top=171, Width=360)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_NContaCNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_NContaCNP
            .Height        = 25
            .Left          = 170
            .Top           = 171
            .Width         = 360
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        *-- Label "Valor CP" (Label4, Left=50, Top=203)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_ValorCNP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_ValorCNP
            .Caption   = "Valor : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 50
            .Top       = 203
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_ValorC (Left=88, Top=198, Width=120, ReadOnly)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_ValorCNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_ValorCNP
            .Height        = 25
            .Left          = 88
            .Top           = 198
            .Width         = 120
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999,999,999.99"
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
        *-- Get_moedaC (Left=210, Top=198, Width=32)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_MoedaCNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_MoedaCNP
            .Height        = 25
            .Left          = 210
            .Top           = 198
            .Width         = 32
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Label "Operacao CP" (Say11, Left=252, Top=203)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_OperCNP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_OperCNP
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 252
            .Top       = 203
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_SOPER (Left=316, Top=199, Width=15)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_SOperCNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_SOperCNP
            .Height        = 25
            .Left          = 316
            .Top           = 199
            .Width         = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Label "Historico" (Label3, Left=33, Top=229)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_HistNP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_HistNP
            .Caption   = "Hist" + CHR(243) + "rico : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 33
            .Top       = 229
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_Hist (Left=88, Top=225, Width=370)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_HistNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_HistNP
            .Height        = 25
            .Left          = 88
            .Top           = 225
            .Width         = 370
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Label "Nota Fiscal" (Say7, Left=25, Top=256)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_NF_NP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_NF_NP
            .Caption   = "Nota Fiscal :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 25
            .Top       = 256
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_Nota (Left=88, Top=252, Width=91)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_NotaNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_NotaNP
            .Height        = 25
            .Left          = 88
            .Top           = 252
            .Width         = 91
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Label "Documento" (Say2, Left=205, Top=256)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("lbl_4c_Doc_NP", "Label")
        WITH loc_oPag1.cnt_4c_NovaPendencia.lbl_4c_Doc_NP
            .Caption   = "Documento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 205
            .Top       = 256
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_DOCU (Left=281, Top=252, Width=91)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("txt_4c_DocNP", "TextBox")
        WITH loc_oPag1.cnt_4c_NovaPendencia.txt_4c_DocNP
            .Height        = 25
            .Left          = 281
            .Top           = 252
            .Width         = 91
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Botao Confirma NP (Left=463, Top=233)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("cmd_4c_ConfirmaNP", "CommandButton")
        WITH loc_oPag1.cnt_4c_NovaPendencia.cmd_4c_ConfirmaNP
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_escudo_ok_32.jpg"
            .PicturePosition = 2
            .Width           = 40
            .Height          = 40
            .Left            = 463
            .Top             = 233
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.cmd_4c_ConfirmaNP, "Click", THIS, "BtnConfirmaNPClick")
        *-- Botao Cancelar NP (Left=502, Top=233)
        loc_oPag1.cnt_4c_NovaPendencia.AddObject("cmd_4c_CancelarNP", "CommandButton")
        WITH loc_oPag1.cnt_4c_NovaPendencia.cmd_4c_CancelarNP
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
            .PicturePosition = 2
            .Width           = 40
            .Height          = 40
            .Left            = 502
            .Top             = 233
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cnt_4c_NovaPendencia.cmd_4c_CancelarNP, "Click", THIS, "BtnCancelarNPClick")

        *----------------------------------------------------------------------
        *-- Container cnt_4c_Pagamento (FLOATING - permanece oculto)
        *-- Legado: Pagamento Top=28, Left=315, Width=365, Height=162, Visible=.F.
        *-- TornarControlesVisiveis ja exclui CNT_4C_PAGAMENTO por nome
        *----------------------------------------------------------------------
        loc_oPag1.AddObject("cnt_4c_Pagamento", "Container")
        WITH loc_oPag1.cnt_4c_Pagamento
            .Top           = 28
            .Left          = 315
            .Width         = 365
            .Height        = 162
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 255)
            .BorderWidth   = 2
            .BorderColor   = RGB(36, 84, 155)
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH
        loc_oPag1.cnt_4c_Pagamento.AddObject("lbl_4c_TituloPag", "Label")
        WITH loc_oPag1.cnt_4c_Pagamento.lbl_4c_TituloPag
            .Caption   = "Pagamento"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 6
            .Top       = 3
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Label "% para Baixa" (SayValor, Left=38, Top=26)
        loc_oPag1.cnt_4c_Pagamento.AddObject("lbl_4c_PercBaixa", "Label")
        WITH loc_oPag1.cnt_4c_Pagamento.lbl_4c_PercBaixa
            .Caption   = "% para Baixa : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 38
            .Top       = 26
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_Perc (Left=116, Top=24, Width=58)
        loc_oPag1.cnt_4c_Pagamento.AddObject("txt_4c_PercBaixa", "TextBox")
        WITH loc_oPag1.cnt_4c_Pagamento.txt_4c_PercBaixa
            .Height        = 20
            .Left          = 116
            .Top           = 24
            .Width         = 58
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999.99%"
            .Visible       = .T.
        ENDWITH
        *-- Label "Saldo Baixado" (Say1, Left=36, Top=46)
        loc_oPag1.cnt_4c_Pagamento.AddObject("lbl_4c_SaldoBaixado", "Label")
        WITH loc_oPag1.cnt_4c_Pagamento.lbl_4c_SaldoBaixado
            .Caption   = "Saldo Baixado : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 36
            .Top       = 46
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- GetValor (Left=116, Top=44, Width=103)
        loc_oPag1.cnt_4c_Pagamento.AddObject("txt_4c_ValorBaixado", "TextBox")
        WITH loc_oPag1.cnt_4c_Pagamento.txt_4c_ValorBaixado
            .Height        = 20
            .Left          = 116
            .Top           = 44
            .Width         = 103
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999,999,999.99"
            .Visible       = .T.
        ENDWITH
        *-- Grid formas de pagamento (Left=15, Top=64, Height=90, Width=204, ColumnCount=2)
        SET NULL ON
        CREATE CURSOR cursor_4c_FormasPag (FPags C(10), Valors N(13,2))
        SET NULL OFF
        loc_oPag1.cnt_4c_Pagamento.AddObject("grd_4c_FormasPag", "Grid")
        WITH loc_oPag1.cnt_4c_Pagamento.grd_4c_FormasPag
            .Top               = 64
            .Left              = 15
            .Height            = 90
            .Width             = 204
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLines         = 3
            .GridLineColor     = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight         = 17
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH
        loc_oPag1.cnt_4c_Pagamento.grd_4c_FormasPag.ColumnCount              = 2
        loc_oPag1.cnt_4c_Pagamento.grd_4c_FormasPag.RecordSource             = "cursor_4c_FormasPag"
        loc_oPag1.cnt_4c_Pagamento.grd_4c_FormasPag.Column1.ControlSource    = "cursor_4c_FormasPag.FPags"
        loc_oPag1.cnt_4c_Pagamento.grd_4c_FormasPag.Column2.ControlSource    = "cursor_4c_FormasPag.Valors"
        loc_oPag1.cnt_4c_Pagamento.grd_4c_FormasPag.Column1.Width            = 84
        loc_oPag1.cnt_4c_Pagamento.grd_4c_FormasPag.Column2.Width            = 87
        loc_oPag1.cnt_4c_Pagamento.grd_4c_FormasPag.Column1.Header1.Caption  = "Forma Pagto"
        loc_oPag1.cnt_4c_Pagamento.grd_4c_FormasPag.Column2.Header1.Caption  = "Valor"
        loc_oPag1.cnt_4c_Pagamento.grd_4c_FormasPag.Column1.Movable          = .F.
        loc_oPag1.cnt_4c_Pagamento.grd_4c_FormasPag.Column2.Movable          = .F.
        *-- Botao Confirma Pagamento (Left=274, Top=111)
        loc_oPag1.cnt_4c_Pagamento.AddObject("cmd_4c_ConfirmaPag", "CommandButton")
        WITH loc_oPag1.cnt_4c_Pagamento.cmd_4c_ConfirmaPag
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_escudo_ok_32.jpg"
            .PicturePosition = 2
            .Width           = 40
            .Height          = 40
            .Left            = 274
            .Top             = 111
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cnt_4c_Pagamento.cmd_4c_ConfirmaPag, "Click", THIS, "BtnConfirmaPagClick")
        *-- Botao Cancelar Pagamento (Left=314, Top=111)
        loc_oPag1.cnt_4c_Pagamento.AddObject("cmd_4c_CancelarPag", "CommandButton")
        WITH loc_oPag1.cnt_4c_Pagamento.cmd_4c_CancelarPag
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
            .PicturePosition = 2
            .Width           = 40
            .Height          = 40
            .Left            = 314
            .Top             = 111
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag1.cnt_4c_Pagamento.cmd_4c_CancelarPag, "Click", THIS, "BtnCancelarPagClick")

        *-- Tornar controles visiveis (containers flutuantes excluidos por TornarControlesVisiveis)
        THIS.TornarControlesVisiveis(loc_oPag1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSubPaginaPagamento - Configura Page2 do PageFrame interno
    * Legado: SIGCDPGR.Pagina.Dados.Pagina.Pagamento (PageOrder=3, Enabled=.F.)
    * Sem compensacao +28 (coordenadas relativas a sub-pagina)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSubPaginaPagamento()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2

        *----------------------------------------------------------------------
        *-- Campos principais da pagina Pagamento
        *-- Legado: Get_fpg (forma pgto), Get_npar (n.parcelas),
        *--   Get_vpar (valor parcela), fweditdata_venc (vencimento)
        *----------------------------------------------------------------------
        *-- Label "Forma" (SayForma)
        loc_oPag2.AddObject("lbl_4c_Forma", "Label")
        WITH loc_oPag2.lbl_4c_Forma
            .Caption   = "Forma"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 20
            .Top       = 12
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_fpg (forma de pagamento, Left=63, Top=9, Width=40)
        loc_oPag2.AddObject("txt_4c_Fpg", "TextBox")
        WITH loc_oPag2.txt_4c_Fpg
            .Height        = 25
            .Left          = 63
            .Top           = 9
            .Width         = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag2.txt_4c_Fpg, "KeyPress", THIS, "ValidarFpg")
        BINDEVENT(loc_oPag2.txt_4c_Fpg, "KeyPress",  THIS, "TeclaFpg")

        *-- Label "Parcelas" (SayParcs)
        loc_oPag2.AddObject("lbl_4c_Parcelas", "Label")
        WITH loc_oPag2.lbl_4c_Parcelas
            .Caption   = "Parcelas"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 110
            .Top       = 12
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_npar (num. parcelas, Left=163, Top=9, Width=30)
        loc_oPag2.AddObject("txt_4c_NPar", "TextBox")
        WITH loc_oPag2.txt_4c_NPar
            .Height        = 25
            .Left          = 163
            .Top           = 9
            .Width         = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .Visible       = .T.
        ENDWITH

        *-- Label "Valor" (SayValor)
        loc_oPag2.AddObject("lbl_4c_ValorPag", "Label")
        WITH loc_oPag2.lbl_4c_ValorPag
            .Caption   = "Valor"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 200
            .Top       = 12
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_vpar (valor por parcela, Left=235, Top=9, Width=100)
        loc_oPag2.AddObject("txt_4c_VPar", "TextBox")
        WITH loc_oPag2.txt_4c_VPar
            .Height        = 25
            .Left          = 235
            .Top           = 9
            .Width         = 100
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .InputMask     = "999,999,999.99"
            .Visible       = .T.
        ENDWITH

        *-- Label "Vecto" (SayVecto)
        loc_oPag2.AddObject("lbl_4c_Vecto", "Label")
        WITH loc_oPag2.lbl_4c_Vecto
            .Caption   = "Vecto"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 345
            .Top       = 12
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- fweditdata_venc (data vencimento, Left=378, Top=9, Width=80)
        loc_oPag2.AddObject("txt_4c_Venc", "TextBox")
        WITH loc_oPag2.txt_4c_Venc
            .Format        = "D"
            .Height        = 25
            .Left          = 378
            .Top           = 9
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label "Cotacao" (Say_Cotacao)
        loc_oPag2.AddObject("lbl_4c_CotacaoPag", "Label")
        WITH loc_oPag2.lbl_4c_CotacaoPag
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 470
            .Top       = 12
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_COTACAO (Left=510, Top=9, Width=80)
        loc_oPag2.AddObject("txt_4c_CotacaoPag", "TextBox")
        WITH loc_oPag2.txt_4c_CotacaoPag
            .Height        = 25
            .Left          = 510
            .Top           = 9
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Alignment     = 3
            .Visible       = .T.
        ENDWITH

        *-- Botao AltCotacao pagamento (Left=595, Top=9)
        loc_oPag2.AddObject("cmd_4c_AltCotacaoPag", "CommandButton")
        WITH loc_oPag2.cmd_4c_AltCotacaoPag
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_coleta_20.jpg"
            .PicturePosition = 2
            .Width           = 20
            .Height          = 20
            .Left            = 595
            .Top             = 9
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag2.cmd_4c_AltCotacaoPag, "Click", THIS, "BtnAltCotacaoPagClick")

        *----------------------------------------------------------------------
        *-- Grade principal de parcelas
        *-- Legado: Grade Top=38, Left=9, Height=220, Width=560, ColumnCount=4
        *-- Colunas: fpagto(140), valor(100), venc(100), moeda(32)
        *----------------------------------------------------------------------
        SET NULL ON
        CREATE CURSOR cursor_4c_Parcelas ;
            (fpagto C(10), valor N(13,2), venc D, moeda C(3))
        SET NULL OFF

        loc_oPag2.AddObject("grd_4c_Parcelas", "Grid")
        WITH loc_oPag2.grd_4c_Parcelas
            .Top               = 38
            .Left              = 9
            .Height            = 220
            .Width             = 560
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLines         = 3
            .GridLineColor     = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight         = 17
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH
        loc_oPag2.grd_4c_Parcelas.ColumnCount              = 4
        loc_oPag2.grd_4c_Parcelas.RecordSource             = "cursor_4c_Parcelas"
        loc_oPag2.grd_4c_Parcelas.Column1.ControlSource    = "cursor_4c_Parcelas.fpagto"
        loc_oPag2.grd_4c_Parcelas.Column2.ControlSource    = "cursor_4c_Parcelas.valor"
        loc_oPag2.grd_4c_Parcelas.Column3.ControlSource    = "cursor_4c_Parcelas.venc"
        loc_oPag2.grd_4c_Parcelas.Column4.ControlSource    = "cursor_4c_Parcelas.moeda"
        loc_oPag2.grd_4c_Parcelas.Column1.Width            = 140
        loc_oPag2.grd_4c_Parcelas.Column2.Width            = 100
        loc_oPag2.grd_4c_Parcelas.Column3.Width            = 100
        loc_oPag2.grd_4c_Parcelas.Column4.Width            = 32
        loc_oPag2.grd_4c_Parcelas.Column1.Header1.Caption  = "Forma Pagto"
        loc_oPag2.grd_4c_Parcelas.Column2.Header1.Caption  = "Valor"
        loc_oPag2.grd_4c_Parcelas.Column3.Header1.Caption  = "Vencimento"
        loc_oPag2.grd_4c_Parcelas.Column4.Header1.Caption  = "Moe"
        loc_oPag2.grd_4c_Parcelas.Column1.Movable          = .F.
        loc_oPag2.grd_4c_Parcelas.Column2.Movable          = .F.
        loc_oPag2.grd_4c_Parcelas.Column3.Movable          = .F.
        loc_oPag2.grd_4c_Parcelas.Column4.Movable          = .F.

        *----------------------------------------------------------------------
        *-- Grade Total da pagina Pagamento
        *-- Legado: Total Left=9, Top=262, Height=50, Width=560, ColumnCount=4
        *----------------------------------------------------------------------
        SET NULL ON
        CREATE CURSOR cursor_4c_TotalPag ;
            (Moeda C(3), ValPag N(13,2), ValPend N(13,2), ValDif N(13,2))
        SET NULL OFF

        loc_oPag2.AddObject("grd_4c_TotalPag", "Grid")
        WITH loc_oPag2.grd_4c_TotalPag
            .Top               = 262
            .Left              = 9
            .Height            = 50
            .Width             = 560
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLines         = 3
            .GridLineColor     = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH
        loc_oPag2.grd_4c_TotalPag.ColumnCount              = 4
        loc_oPag2.grd_4c_TotalPag.RecordSource             = "cursor_4c_TotalPag"
        loc_oPag2.grd_4c_TotalPag.Column1.ControlSource    = "cursor_4c_TotalPag.Moeda"
        loc_oPag2.grd_4c_TotalPag.Column2.ControlSource    = "cursor_4c_TotalPag.ValPag"
        loc_oPag2.grd_4c_TotalPag.Column3.ControlSource    = "cursor_4c_TotalPag.ValPend"
        loc_oPag2.grd_4c_TotalPag.Column4.ControlSource    = "cursor_4c_TotalPag.ValDif"
        loc_oPag2.grd_4c_TotalPag.Column1.Width            = 50
        loc_oPag2.grd_4c_TotalPag.Column2.Width            = 120
        loc_oPag2.grd_4c_TotalPag.Column3.Width            = 120
        loc_oPag2.grd_4c_TotalPag.Column4.Width            = 120
        loc_oPag2.grd_4c_TotalPag.Column1.Header1.Caption  = "Moeda"
        loc_oPag2.grd_4c_TotalPag.Column2.Header1.Caption  = "Acertado"
        loc_oPag2.grd_4c_TotalPag.Column3.Header1.Caption  = "Pendente"
        loc_oPag2.grd_4c_TotalPag.Column4.Header1.Caption  = "Diferen" + CHR(231) + "a"
        loc_oPag2.grd_4c_TotalPag.Column1.Movable          = .F.
        loc_oPag2.grd_4c_TotalPag.Column2.Movable          = .F.
        loc_oPag2.grd_4c_TotalPag.Column3.Movable          = .F.
        loc_oPag2.grd_4c_TotalPag.Column4.Movable          = .F.

        *----------------------------------------------------------------------
        *-- Label "Label3" (etiqueta acima do total)
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("lbl_4c_TotalPag", "Label")
        WITH loc_oPag2.lbl_4c_TotalPag
            .Caption   = "Totais"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 9
            .Top       = 250
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container Cheque (Legado: Left=579, Top=9, Width=175, Height=95)
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("cnt_4c_Cheque", "Container")
        WITH loc_oPag2.cnt_4c_Cheque
            .Top         = 9
            .Left        = 579
            .Width       = 175
            .Height      = 95
            .BackStyle   = 0
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH
        *-- Labels Banco, Agencia, Numero, Conta
        loc_oPag2.cnt_4c_Cheque.AddObject("lbl_4c_BcoChe", "Label")
        WITH loc_oPag2.cnt_4c_Cheque.lbl_4c_BcoChe
            .Caption   = "Banco"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_bco (Left=48, Top=3, Width=40)
        loc_oPag2.cnt_4c_Cheque.AddObject("txt_4c_BcoChe", "TextBox")
        WITH loc_oPag2.cnt_4c_Cheque.txt_4c_BcoChe
            .Height        = 22
            .Left          = 48
            .Top           = 3
            .Width         = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        loc_oPag2.cnt_4c_Cheque.AddObject("lbl_4c_AgeChe", "Label")
        WITH loc_oPag2.cnt_4c_Cheque.lbl_4c_AgeChe
            .Caption   = "Ag" + CHR(234) + "ncia"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 30
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_age (Left=58, Top=28, Width=50)
        loc_oPag2.cnt_4c_Cheque.AddObject("txt_4c_AgeChe", "TextBox")
        WITH loc_oPag2.cnt_4c_Cheque.txt_4c_AgeChe
            .Height        = 22
            .Left          = 58
            .Top           = 28
            .Width         = 50
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        loc_oPag2.cnt_4c_Cheque.AddObject("lbl_4c_NumChe", "Label")
        WITH loc_oPag2.cnt_4c_Cheque.lbl_4c_NumChe
            .Caption   = "N" + CHR(250) + "mero"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 55
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_num (Left=58, Top=53, Width=70)
        loc_oPag2.cnt_4c_Cheque.AddObject("txt_4c_NumChe", "TextBox")
        WITH loc_oPag2.cnt_4c_Cheque.txt_4c_NumChe
            .Height        = 22
            .Left          = 58
            .Top           = 53
            .Width         = 70
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        loc_oPag2.cnt_4c_Cheque.AddObject("lbl_4c_CtaChe", "Label")
        WITH loc_oPag2.cnt_4c_Cheque.lbl_4c_CtaChe
            .Caption   = "Conta"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 90
            .Top       = 30
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_conta (Left=128, Top=28, Width=42)
        loc_oPag2.cnt_4c_Cheque.AddObject("txt_4c_CtaChe", "TextBox")
        WITH loc_oPag2.cnt_4c_Cheque.txt_4c_CtaChe
            .Height        = 22
            .Left          = 128
            .Top           = 28
            .Width         = 42
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Get_Cheque (Left=128, Top=53, Width=42)
        loc_oPag2.cnt_4c_Cheque.AddObject("txt_4c_CmcChe", "TextBox")
        WITH loc_oPag2.cnt_4c_Cheque.txt_4c_CmcChe
            .Height        = 22
            .Left          = 128
            .Top           = 53
            .Width         = 42
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container Cartao (Legado: Left=579, Top=108, Width=175, Height=55)
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("cnt_4c_Cartao", "Container")
        WITH loc_oPag2.cnt_4c_Cartao
            .Top         = 108
            .Left        = 579
            .Width       = 175
            .Height      = 55
            .BackStyle   = 0
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH
        loc_oPag2.cnt_4c_Cartao.AddObject("lbl_4c_CredCar", "Label")
        WITH loc_oPag2.cnt_4c_Cartao.lbl_4c_CredCar
            .Caption   = "Credenciadora"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_cred (Left=88, Top=3, Width=82)
        loc_oPag2.cnt_4c_Cartao.AddObject("txt_4c_CredCar", "TextBox")
        WITH loc_oPag2.cnt_4c_Cartao.txt_4c_CredCar
            .Height        = 22
            .Left          = 88
            .Top           = 3
            .Width         = 82
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        loc_oPag2.cnt_4c_Cartao.AddObject("lbl_4c_CartaoNum", "Label")
        WITH loc_oPag2.cnt_4c_Cartao.lbl_4c_CartaoNum
            .Caption   = "Cartao"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 32
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_cartao (Left=88, Top=30, Width=82)
        loc_oPag2.cnt_4c_Cartao.AddObject("txt_4c_CartaoNum", "TextBox")
        WITH loc_oPag2.cnt_4c_Cartao.txt_4c_CartaoNum
            .Height        = 22
            .Left          = 88
            .Top           = 30
            .Width         = 82
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container Carne (Legado: Left=579, Top=167, Width=175, Height=30)
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("cnt_4c_Carne", "Container")
        WITH loc_oPag2.cnt_4c_Carne
            .Top         = 167
            .Left        = 579
            .Width       = 175
            .Height      = 30
            .BackStyle   = 0
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH
        loc_oPag2.cnt_4c_Carne.AddObject("lbl_4c_CodCarne", "Label")
        WITH loc_oPag2.cnt_4c_Carne.lbl_4c_CodCarne
            .Caption   = "Carn" + CHR(234)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 7
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_carne (Left=50, Top=5, Width=100)
        loc_oPag2.cnt_4c_Carne.AddObject("txt_4c_Carne", "TextBox")
        WITH loc_oPag2.cnt_4c_Carne.txt_4c_Carne
            .Height        = 22
            .Left          = 50
            .Top           = 5
            .Width         = 100
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container CntFollowUp (Legado: Left=579, Top=200, Height=60)
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("cnt_4c_FollowUp", "Container")
        WITH loc_oPag2.cnt_4c_FollowUp
            .Top         = 200
            .Left        = 579
            .Width       = 175
            .Height      = 60
            .BackStyle   = 0
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH
        loc_oPag2.cnt_4c_FollowUp.AddObject("lbl_4c_ObsPag", "Label")
        WITH loc_oPag2.cnt_4c_FollowUp.lbl_4c_ObsPag
            .Caption   = "Obs"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- Get_Obs (Left=30, Top=3, Width=140, Height=50)
        loc_oPag2.cnt_4c_FollowUp.AddObject("txt_4c_ObsPag", "TextBox")
        WITH loc_oPag2.cnt_4c_FollowUp.txt_4c_ObsPag
            .Height        = 50
            .Left          = 30
            .Top           = 3
            .Width         = 140
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container cntApanhaChq (captura de cheque por leitora)
        *-- Legado: Left=579, Top=265, Width=175, Height=100
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("cnt_4c_ApanhaChq", "Container")
        WITH loc_oPag2.cnt_4c_ApanhaChq
            .Top         = 265
            .Left        = 579
            .Width       = 175
            .Height      = 100
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH
        loc_oPag2.cnt_4c_ApanhaChq.AddObject("lbl_4c_BancoApanha", "Label")
        WITH loc_oPag2.cnt_4c_ApanhaChq.lbl_4c_BancoApanha
            .Caption   = "Banco"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- getBanco (Left=48, Top=3, Width=40)
        loc_oPag2.cnt_4c_ApanhaChq.AddObject("txt_4c_BancoApanha", "TextBox")
        WITH loc_oPag2.cnt_4c_ApanhaChq.txt_4c_BancoApanha
            .Height        = 22
            .Left          = 48
            .Top           = 3
            .Width         = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        loc_oPag2.cnt_4c_ApanhaChq.AddObject("lbl_4c_AgeApanha", "Label")
        WITH loc_oPag2.cnt_4c_ApanhaChq.lbl_4c_AgeApanha
            .Caption   = "Ag" + CHR(234) + "ncia"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 30
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- getAgencia (Left=58, Top=28, Width=50)
        loc_oPag2.cnt_4c_ApanhaChq.AddObject("txt_4c_AgeApanha", "TextBox")
        WITH loc_oPag2.cnt_4c_ApanhaChq.txt_4c_AgeApanha
            .Height        = 22
            .Left          = 58
            .Top           = 28
            .Width         = 50
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        loc_oPag2.cnt_4c_ApanhaChq.AddObject("lbl_4c_NumApanha", "Label")
        WITH loc_oPag2.cnt_4c_ApanhaChq.lbl_4c_NumApanha
            .Caption   = "N" + CHR(250) + "mero"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 55
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- getNumero (Left=58, Top=53, Width=70)
        loc_oPag2.cnt_4c_ApanhaChq.AddObject("txt_4c_NumApanha", "TextBox")
        WITH loc_oPag2.cnt_4c_ApanhaChq.txt_4c_NumApanha
            .Height        = 22
            .Left          = 58
            .Top           = 53
            .Width         = 70
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        loc_oPag2.cnt_4c_ApanhaChq.AddObject("lbl_4c_CtaApanha", "Label")
        WITH loc_oPag2.cnt_4c_ApanhaChq.lbl_4c_CtaApanha
            .Caption   = "Conta"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 90
            .Top       = 30
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        *-- getConta (Left=128, Top=28, Width=42)
        loc_oPag2.cnt_4c_ApanhaChq.AddObject("txt_4c_CtaApanha", "TextBox")
        WITH loc_oPag2.cnt_4c_ApanhaChq.txt_4c_CtaApanha
            .Height        = 22
            .Left          = 128
            .Top           = 28
            .Width         = 42
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- btnOK
        loc_oPag2.cnt_4c_ApanhaChq.AddObject("cmd_4c_OkApanha", "CommandButton")
        WITH loc_oPag2.cnt_4c_ApanhaChq.cmd_4c_OkApanha
            .Caption       = "OK"
            .Width         = 40
            .Height        = 22
            .Left          = 128
            .Top           = 53
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 1
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag2.cnt_4c_ApanhaChq.cmd_4c_OkApanha, "Click", THIS, "BtnOkApanhaClick")

        *----------------------------------------------------------------------
        *-- Grid grdCash (caixa/cash)
        *-- Legado: grdCash Left=579, Top=370, Height=80, Width=175, ColumnCount=2
        *----------------------------------------------------------------------
        SET NULL ON
        CREATE CURSOR cursor_4c_CashPag (Banco C(10), Valor N(13,2))
        SET NULL OFF

        loc_oPag2.AddObject("grd_4c_CashPag", "Grid")
        WITH loc_oPag2.grd_4c_CashPag
            .Top               = 370
            .Left              = 579
            .Height            = 80
            .Width             = 175
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLines         = 3
            .GridLineColor     = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH
        loc_oPag2.grd_4c_CashPag.ColumnCount              = 2
        loc_oPag2.grd_4c_CashPag.RecordSource             = "cursor_4c_CashPag"
        loc_oPag2.grd_4c_CashPag.Column1.ControlSource    = "cursor_4c_CashPag.Banco"
        loc_oPag2.grd_4c_CashPag.Column2.ControlSource    = "cursor_4c_CashPag.Valor"
        loc_oPag2.grd_4c_CashPag.Column1.Width            = 90
        loc_oPag2.grd_4c_CashPag.Column2.Width            = 80
        loc_oPag2.grd_4c_CashPag.Column1.Header1.Caption  = "Moe"
        loc_oPag2.grd_4c_CashPag.Column2.Header1.Caption  = "Valor"
        loc_oPag2.grd_4c_CashPag.Column1.Movable          = .F.
        loc_oPag2.grd_4c_CashPag.Column2.Movable          = .F.

        *-- Label lblCsh (acima grdCash)
        loc_oPag2.AddObject("lbl_4c_CashPag", "Label")
        WITH loc_oPag2.lbl_4c_CashPag
            .Caption   = "Caixa"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 579
            .Top       = 358
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Botoes de acao da pagina Pagamento
        *----------------------------------------------------------------------
        *-- Botao ImprimeCheque (Legado: Left=579, Top=319)
        loc_oPag2.AddObject("cmd_4c_ImprimeCheque", "CommandButton")
        WITH loc_oPag2.cmd_4c_ImprimeCheque
            .Caption         = "Imprimir Cheque"
            .Width           = 100
            .Height          = 35
            .Left            = 579
            .Top             = 319
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 1
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag2.cmd_4c_ImprimeCheque, "Click", THIS, "BtnImprimeChequeClick")

        *-- Botao LerCheques (Legado: Left=684, Top=319)
        loc_oPag2.AddObject("cmd_4c_LerCheques", "CommandButton")
        WITH loc_oPag2.cmd_4c_LerCheques
            .Caption         = "Ler Cheques"
            .Width           = 75
            .Height          = 35
            .Left            = 684
            .Top             = 319
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 1
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag2.cmd_4c_LerCheques, "Click", THIS, "BtnLerChequesClick")

        *-- Botao BaixaPend (baixar pendencia, Legado: Left=9, Top=316)
        loc_oPag2.AddObject("cmd_4c_BaixaPend", "CommandButton")
        WITH loc_oPag2.cmd_4c_BaixaPend
            .Caption         = "Baixar Pend"
            .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 9
            .Top             = 316
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag2.cmd_4c_BaixaPend, "Click", THIS, "BtnBaixaPendClick")

        *-- Botao Apaga (estornar, Legado: Left=84, Top=316)
        loc_oPag2.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH loc_oPag2.cmd_4c_Apaga
            .Caption         = "Apagar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 84
            .Top             = 316
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag2.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")

        *-- Botao btnAcerto (acerto de valores, Legado: Left=159, Top=316)
        loc_oPag2.AddObject("cmd_4c_Acerto", "CommandButton")
        WITH loc_oPag2.cmd_4c_Acerto
            .Caption         = "Acerto"
            .Picture         = gc_4c_CaminhoIcones + "geral_coleta_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 159
            .Top             = 316
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag2.cmd_4c_Acerto, "Click", THIS, "BtnAcertoClick")

        *-- Botao Command1 (gerar parcelas, Legado: Left=234, Top=316)
        loc_oPag2.AddObject("cmd_4c_GerarParcelas", "CommandButton")
        WITH loc_oPag2.cmd_4c_GerarParcelas
            .Caption         = "Gerar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 234
            .Top             = 316
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPag2.cmd_4c_GerarParcelas, "Click", THIS, "BtnGerarParcelasClick")

        *-- EditBox (fwmemo1 - observacao do pagamento)
        loc_oPag2.AddObject("edt_4c_ObsPagamento", "EditBox")
        WITH loc_oPag2.edt_4c_ObsPagamento
            .Height        = 60
            .Left          = 9
            .Top           = 395
            .Width         = 560
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label "Observacao" acima editbox
        loc_oPag2.AddObject("lbl_4c_ObsPagamento", "Label")
        WITH loc_oPag2.lbl_4c_ObsPagamento
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .Left      = 9
            .Top       = 383
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPag2)
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeContaCorrenteChange - AfterRowColChange do grd_4c_ContaCorrente
    * LPARAMETERS obrigatorio para AfterRowColChange
    *--------------------------------------------------------------------------
    PROCEDURE GradeContaCorrenteChange(par_nColIndex)
        *-- Atualiza campos abaixo da grade com dados da linha selecionada
        IF USED("cursor_4c_Pendencias") AND !EOF("cursor_4c_Pendencias")
            LOCAL loc_oPag1
            loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            loc_oPag1.txt_4c_ValorPend.Value    = cursor_4c_Pendencias.Valos
            loc_oPag1.txt_4c_CotacaoPend.Value  = 1
            loc_oPag1.txt_4c_ValConvPend.Value  = cursor_4c_Pendencias.Valos
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradePendencias - Carrega dados no grd_4c_ContaCorrente
    * CRITICO: RecordSource e ControlSource FORA do WITH (reseta colunas)
    * CRITICO: Re-definir ControlSource E Headers APOS cada RecordSource
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradePendencias()
        LOCAL loc_oGrid, loc_lResultado, loc_oGrade
        loc_lResultado = .F.
        loc_oGrade = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1

        TRY
            loc_oGrid = loc_oGrade.grd_4c_ContaCorrente

            IF NOT THIS.this_oBusinessObject.CarregarPendencias()
                MostrarErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ELSE
                *-- CRITICO: RecordSource FORA do WITH (reseta colunas)
                loc_oGrid.ColumnCount = 10
                loc_oGrid.RecordSource = "cursor_4c_Pendencias"

                *-- CRITICO: ControlSource SEMPRE apos RecordSource
                loc_oGrid.Column1.ControlSource  = "cursor_4c_Pendencias.Flag"
                loc_oGrid.Column2.ControlSource  = "cursor_4c_Pendencias.Emps"
                loc_oGrid.Column3.ControlSource  = "cursor_4c_Pendencias.Datas"
                loc_oGrid.Column4.ControlSource  = "cursor_4c_Pendencias.Vencs"
                loc_oGrid.Column5.ControlSource  = "cursor_4c_Pendencias.Valos"
                loc_oGrid.Column6.ControlSource  = "cursor_4c_Pendencias.Valos"
                loc_oGrid.Column7.ControlSource  = "cursor_4c_Pendencias.Acerto"
                loc_oGrid.Column8.ControlSource  = "cursor_4c_Pendencias.Moedas"
                loc_oGrid.Column9.ControlSource  = "cursor_4c_Pendencias.Nomes"
                loc_oGrid.Column10.ControlSource = "cursor_4c_Pendencias.OrdCopChS"

                *-- CRITICO: Headers SEMPRE apos RecordSource
                loc_oGrid.Column1.Header1.Caption  = "X"
                loc_oGrid.Column2.Header1.Caption  = "Emp"
                loc_oGrid.Column3.Header1.Caption  = "Data"
                loc_oGrid.Column4.Header1.Caption  = "Vencimento"
                loc_oGrid.Column5.Header1.Caption  = "D" + CHR(233) + "bito"
                loc_oGrid.Column6.Header1.Caption  = "Cr" + CHR(233) + "dito"
                loc_oGrid.Column7.Header1.Caption  = "Acerto"
                loc_oGrid.Column8.Header1.Caption  = "Moe"
                loc_oGrid.Column9.Header1.Caption  = "Hist" + CHR(243) + "rico"
                loc_oGrid.Column10.Header1.Caption = "Ordem"

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar grade pendencias:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LOOKUPS - ValidarXxx: LostFocus handlers com busca/validacao
    * TeclaXxx: KeyPress handlers para F4 (codigo=115)
    * AbrirLookupXxx: FormBuscaAuxiliar completo
    *--------------------------------------------------------------------------

    *-- ValidarGrEstoque - valida grupo de conta corrente (SigCdGcr)
    PROCEDURE ValidarGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cSQL, loc_lOk
        loc_oPag3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3
        loc_cGrupo = ALLTRIM(loc_oPag3.txt_4c_GrEstoque.Value)

        IF EMPTY(loc_cGrupo)
            loc_oPag3.txt_4c_DsEstoque.Value = ""
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr " + ;
                       "WHERE Codigos = " + EscaparSQL(loc_cGrupo)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrEstLookup") > 0
                IF !EOF("cursor_4c_GrEstLookup") AND RECCOUNT("cursor_4c_GrEstLookup") > 0
                    loc_oPag3.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_GrEstLookup.Descrs)
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_GrEstLookup")
                    USE IN cursor_4c_GrEstLookup
                ENDIF
            ENDIF
        CATCH TO loEx
            MostrarErro("Erro ao validar grupo: " + loEx.Message, "Erro")
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cGrupo)
            MsgAviso("Grupo '" + loc_cGrupo + "' n" + CHR(227) + "o encontrado. Use F4 para pesquisar.")
            loc_oPag3.txt_4c_GrEstoque.Value = ""
            loc_oPag3.txt_4c_DsEstoque.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaGrEstoque - F4 abre lookup de grupos de conta corrente
    PROCEDURE TeclaGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupGrEstoque()
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *-- AbrirLookupGrEstoque - FormBuscaAuxiliar em SigCdGcr
    PROCEDURE AbrirLookupGrEstoque()
        LOCAL loc_oBusca, loc_oPag3
        loc_oPag3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrEst", "cgrus", "", ;
                "Buscar Grupo")

            loc_oBusca.mAddColuna("cgrus",  "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dgrus",  "", "Descri" + CHR(231) + CHR(227) + "o")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaGrEst")
                    loc_oPag3.txt_4c_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.cgrus)
                    loc_oPag3.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.dgrus)
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaGrEst")
                USE IN cursor_4c_BuscaGrEst
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro ao buscar grupo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- ValidarCdEstoque - valida codigo de conta corrente
    PROCEDURE ValidarCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cConta, loc_cSQL, loc_lOk, loc_oPag3
        loc_oPag3  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3
        loc_cGrupo = ALLTRIM(loc_oPag3.txt_4c_GrEstoque.Value)
        loc_cConta = ALLTRIM(loc_oPag3.txt_4c_CdEstoque.Value)

        IF EMPTY(loc_cConta)
            loc_oPag3.txt_4c_DsEstoque.Value = ""
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT c.cgrus, c.Codigos AS conta, c.Descrs AS descr " + ;
                       "FROM SigCdGcr g " + ;
                       "INNER JOIN SigCdCcr c ON c.cgrus = g.Codigos " + ;
                       "WHERE c.Codigos = " + EscaparSQL(loc_cConta)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND c.cgrus = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CdEstLookup") > 0
                IF !EOF("cursor_4c_CdEstLookup") AND RECCOUNT("cursor_4c_CdEstLookup") > 0
                    loc_oPag3.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_CdEstLookup.descr)
                    IF EMPTY(loc_cGrupo)
                        loc_oPag3.txt_4c_GrEstoque.Value = ALLTRIM(cursor_4c_CdEstLookup.cgrus)
                    ENDIF
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_CdEstLookup")
                    USE IN cursor_4c_CdEstLookup
                ENDIF
            ENDIF
        CATCH TO loEx
            MostrarErro("Erro ao validar conta: " + loEx.Message, "Erro")
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cConta)
            MsgAviso("Conta '" + loc_cConta + "' n" + CHR(227) + "o encontrada. Use F4 para pesquisar.")
            loc_oPag3.txt_4c_CdEstoque.Value = ""
            loc_oPag3.txt_4c_DsEstoque.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaCdEstoque - F4 abre lookup de contas correntes
    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupCdEstoque()
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *-- AbrirLookupCdEstoque - FormBuscaAuxiliar em SigCdCcr
    PROCEDURE AbrirLookupCdEstoque()
        LOCAL loc_oBusca, loc_oPag3, loc_cGrupo, loc_cFiltro
        loc_oPag3  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3
        loc_cGrupo = ALLTRIM(loc_oPag3.txt_4c_GrEstoque.Value)

        TRY
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "cgrus = " + EscaparSQL(loc_cGrupo)
            ELSE
                loc_cFiltro = ""
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCcr", "cursor_4c_BuscaCdEst", "Codigos", loc_cFiltro, ;
                "Buscar Conta Corrente")

            loc_oBusca.mAddColuna("cgrus",   "", "Grupo")
            loc_oBusca.mAddColuna("Codigos", "", "Conta")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaCdEst")
                    loc_oPag3.txt_4c_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaCdEst.cgrus)
                    loc_oPag3.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaCdEst.Codigos)
                    loc_oPag3.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaCdEst.Descrs)
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaCdEst")
                USE IN cursor_4c_BuscaCdEst
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro ao buscar conta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- ValidarFilEmps - valida codigo de empresa/filial
    PROCEDURE ValidarFilEmps(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cFilial, loc_cSQL, loc_lOk, loc_oPag3
        loc_oPag3  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3
        loc_cFilial = ALLTRIM(loc_oPag3.txt_4c_FilEmps.Value)

        IF EMPTY(loc_cFilial)
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT cemps, razas FROM SigCdEmp " + ;
                       "WHERE cemps = " + EscaparSQL(loc_cFilial)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FilEmpLookup") > 0
                IF !EOF("cursor_4c_FilEmpLookup") AND RECCOUNT("cursor_4c_FilEmpLookup") > 0
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_FilEmpLookup")
                    USE IN cursor_4c_FilEmpLookup
                ENDIF
            ENDIF
        CATCH TO loEx
            MostrarErro("Erro ao validar filial: " + loEx.Message, "Erro")
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cFilial)
            MsgAviso("Filial '" + loc_cFilial + "' n" + CHR(227) + "o encontrada. Use F4 para pesquisar.")
            loc_oPag3.txt_4c_FilEmps.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaFilEmps - F4 abre lookup de empresas
    PROCEDURE TeclaFilEmps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupFilEmp()
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *-- AbrirLookupFilEmp - FormBuscaAuxiliar em SigCdEmp
    PROCEDURE AbrirLookupFilEmp()
        LOCAL loc_oBusca, loc_oPag3
        loc_oPag3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaFilEmp", "cemps", "", ;
                "Buscar Empresa/Filial")

            loc_oBusca.mAddColuna("cemps",  "XXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("razas",  "", "Empresa")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaFilEmp")
                    loc_oPag3.txt_4c_FilEmps.Value = ALLTRIM(cursor_4c_BuscaFilEmp.cemps)
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaFilEmp")
                USE IN cursor_4c_BuscaFilEmp
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro ao buscar empresa:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- ValidarConta - LostFocus no txt_4c_ContaHeader (campo conta do cabecalho)
    PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cConta, loc_cSQL, loc_lOk, loc_oCab
        loc_oCab   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho
        loc_cConta = ALLTRIM(loc_oCab.txt_4c_ContaHeader.Value)

        IF EMPTY(loc_cConta)
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdCcr " + ;
                       "WHERE Codigos = " + EscaparSQL(loc_cConta)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaLookup") > 0
                IF !EOF("cursor_4c_ContaLookup") AND RECCOUNT("cursor_4c_ContaLookup") > 0
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_ContaLookup")
                    USE IN cursor_4c_ContaLookup
                ENDIF
            ENDIF
        CATCH TO loEx
            MostrarErro("Erro ao validar conta: " + loEx.Message, "Erro")
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cConta)
            MsgAviso("Conta '" + loc_cConta + "' n" + CHR(227) + "o encontrada.")
            loc_oCab.txt_4c_ContaHeader.Value = ""
        ENDIF
    ENDPROC

    *-- ValidarCPFBusca - LostFocus no txt_4c_CPF (busca por CPF/CNPJ)
    PROCEDURE ValidarCPFBusca(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCPF, loc_oPag3
        loc_oPag3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3
        loc_cCPF  = ALLTRIM(loc_oPag3.txt_4c_CPF.Value)

        IF EMPTY(loc_cCPF)
            RETURN
        ENDIF

        *-- Valida formato CPF (11 digitos) ou CNPJ (14 digitos)
        LOCAL loc_cApenasNum
        loc_cApenasNum = STRTRAN(STRTRAN(STRTRAN(loc_cCPF, ".", ""), "-", ""), "/", "")

        IF LEN(ALLTRIM(loc_cApenasNum)) = 11
            *-- CPF: aceitar formato valido
        ELSE
            IF LEN(ALLTRIM(loc_cApenasNum)) = 14
                *-- CNPJ: aceitar formato valido
            ELSE
                MsgAviso("CPF/CNPJ inv" + CHR(225) + "lido. Informe 11 d" + ;
                    CHR(237) + "gitos (CPF) ou 14 d" + CHR(237) + "gitos (CNPJ).")
                loc_oPag3.txt_4c_CPF.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *-- BtnCarregarClienteClick - Carrega clientes pelo CPF/CNPJ informado
    PROCEDURE BtnCarregarClienteClick()
        LOCAL loc_cCPF, loc_cSQL, loc_oPag3, loc_lResultado
        loc_oPag3      = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3
        loc_cCPF       = ALLTRIM(loc_oPag3.txt_4c_CPF.Value)
        loc_lResultado = .F.

        IF EMPTY(loc_cCPF)
            MsgAviso("Informe o CPF/CNPJ para buscar.")
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT p.EmpDopNums AS empdopnums, " + ;
                       "  p.Grupos AS grupo, g.Descrs AS nomgrupo, " + ;
                       "  p.Contas AS conta, " + ;
                       "  ISNULL(c.Descrs,'') AS nome, " + ;
                       "  p.nFechas " + ;
                       "FROM SigCdPgc p " + ;
                       "LEFT JOIN SigCdGcr g ON g.Codigos = p.Grupos " + ;
                       "LEFT JOIN SigCdCcr c ON c.Codigos = p.Contas AND c.cgrus = p.Grupos " + ;
                       "LEFT JOIN SigCdCli cli ON cli.Iclis = p.Contas " + ;
                       "WHERE (cli.cpfs = " + EscaparSQL(loc_cCPF) + " " + ;
                       "  OR cli.cpfs = " + EscaparSQL(STRTRAN(STRTRAN(STRTRAN(loc_cCPF,".",""),"-",""),"/","")) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClientesTemp") > 0
                IF USED("cursor_4c_Clientes")
                    SELECT cursor_4c_Clientes
                    ZAP
                    APPEND FROM DBF("cursor_4c_ClientesTemp")
                ELSE
                    SELECT * FROM cursor_4c_ClientesTemp INTO CURSOR cursor_4c_Clientes READWRITE
                ENDIF
                IF USED("cursor_4c_ClientesTemp")
                    USE IN cursor_4c_ClientesTemp
                ENDIF
                THIS.CarregarGradeClientes()
                loc_lResultado = .T.
            ELSE
                MsgAviso("Nenhum cliente encontrado com esse CPF/CNPJ.")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar clientes:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN
    ENDPROC

    *-- ValidarFpg - LostFocus no txt_4c_Fpg (forma de pagamento)
    PROCEDURE ValidarFpg(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cFpg, loc_cSQL, loc_lOk, loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
        loc_cFpg  = ALLTRIM(loc_oPag2.txt_4c_Fpg.Value)

        IF EMPTY(loc_cFpg)
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT Fpags, Hists FROM SigOpFp " + ;
                       "WHERE Fpags = " + EscaparSQL(loc_cFpg)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpgLookup") > 0
                IF !EOF("cursor_4c_FpgLookup") AND RECCOUNT("cursor_4c_FpgLookup") > 0
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_FpgLookup")
                    USE IN cursor_4c_FpgLookup
                ENDIF
            ENDIF
        CATCH TO loEx
            MostrarErro("Erro ao validar forma pagto: " + loEx.Message, "Erro")
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cFpg)
            MsgAviso("Forma de pagamento '" + loc_cFpg + "' n" + CHR(227) + "o encontrada. Use F4.")
            loc_oPag2.txt_4c_Fpg.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaFpg - F4 abre lookup de formas de pagamento
    PROCEDURE TeclaFpg(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupFpg()
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *-- AbrirLookupFpg - FormBuscaAuxiliar em SigOpFp
    PROCEDURE AbrirLookupFpg()
        LOCAL loc_oBusca, loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpFp", "cursor_4c_BuscaFpg", "Fpags", "", ;
                "Buscar Forma de Pagamento")

            loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Hists", "", "Descri" + CHR(231) + CHR(227) + "o")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaFpg")
                    loc_oPag2.txt_4c_Fpg.Value = ALLTRIM(cursor_4c_BuscaFpg.Fpags)
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaFpg")
                USE IN cursor_4c_BuscaFpg
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro ao buscar forma pagto:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- ValidarGrupoPend - LostFocus no txt_4c_GrupoPend
    PROCEDURE ValidarGrupoPend(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cSQL, loc_lOk, loc_oPag1
        loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_cGrupo = ALLTRIM(loc_oPag1.txt_4c_GrupoPend.Value)

        IF EMPTY(loc_cGrupo)
            loc_oPag1.txt_4c_NomeGrupoPend.Value = ""
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrPendLookup") > 0
                IF !EOF("cursor_4c_GrPendLookup") AND RECCOUNT("cursor_4c_GrPendLookup") > 0
                    loc_oPag1.txt_4c_NomeGrupoPend.Value = ALLTRIM(cursor_4c_GrPendLookup.Descrs)
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_GrPendLookup")
                    USE IN cursor_4c_GrPendLookup
                ENDIF
            ENDIF
        CATCH TO loEx
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cGrupo)
            MsgAviso("Grupo n" + CHR(227) + "o encontrado.")
            loc_oPag1.txt_4c_GrupoPend.Value = ""
            loc_oPag1.txt_4c_NomeGrupoPend.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaGrupoPend - F4 abre lookup de grupos
    PROCEDURE TeclaGrupoPend(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oBusca, loc_oPag1
            loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGrPend", "cgrus", "", ;
                    "Buscar Grupo")
                loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrPend")
                    loc_oPag1.txt_4c_GrupoPend.Value     = ALLTRIM(cursor_4c_BuscaGrPend.cgrus)
                    loc_oPag1.txt_4c_NomeGrupoPend.Value = ALLTRIM(cursor_4c_BuscaGrPend.dgrus)
                ENDIF
                IF USED("cursor_4c_BuscaGrPend")
                    USE IN cursor_4c_BuscaGrPend
                ENDIF
                loc_oBusca.Release()
            CATCH TO loEx
                MostrarErro("Erro ao buscar grupo: " + loEx.Message, "Erro")
            ENDTRY
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *-- ValidarContaPend - LostFocus no txt_4c_ContaPend
    PROCEDURE ValidarContaPend(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cConta, loc_cSQL, loc_lOk, loc_oPag1
        loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_cGrupo = ALLTRIM(loc_oPag1.txt_4c_GrupoPend.Value)
        loc_cConta = ALLTRIM(loc_oPag1.txt_4c_ContaPend.Value)

        IF EMPTY(loc_cConta)
            loc_oPag1.txt_4c_NomeContaPend.Value = ""
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdCcr WHERE Codigos = " + EscaparSQL(loc_cConta)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND cgrus = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtPendLookup") > 0
                IF !EOF("cursor_4c_CtPendLookup") AND RECCOUNT("cursor_4c_CtPendLookup") > 0
                    loc_oPag1.txt_4c_NomeContaPend.Value = ALLTRIM(cursor_4c_CtPendLookup.Descrs)
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_CtPendLookup")
                    USE IN cursor_4c_CtPendLookup
                ENDIF
            ENDIF
        CATCH TO loEx
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cConta)
            MsgAviso("Conta n" + CHR(227) + "o encontrada.")
            loc_oPag1.txt_4c_ContaPend.Value = ""
            loc_oPag1.txt_4c_NomeContaPend.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaContaPend - F4 abre lookup de contas
    PROCEDURE TeclaContaPend(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oBusca, loc_oPag1, loc_cGrupo, loc_cFiltro
            loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            loc_cGrupo = ALLTRIM(loc_oPag1.txt_4c_GrupoPend.Value)
            loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "cgrus=" + EscaparSQL(loc_cGrupo), "")
            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCcr", "cursor_4c_BuscaCtPend", "Codigos", loc_cFiltro, ;
                    "Buscar Conta")
                loc_oBusca.mAddColuna("cgrus",   "", "Grupo")
                loc_oBusca.mAddColuna("Codigos", "", "Conta")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtPend")
                    loc_oPag1.txt_4c_GrupoPend.Value      = ALLTRIM(cursor_4c_BuscaCtPend.cgrus)
                    loc_oPag1.txt_4c_ContaPend.Value      = ALLTRIM(cursor_4c_BuscaCtPend.Codigos)
                    loc_oPag1.txt_4c_NomeContaPend.Value  = ALLTRIM(cursor_4c_BuscaCtPend.Descrs)
                ENDIF
                IF USED("cursor_4c_BuscaCtPend")
                    USE IN cursor_4c_BuscaCtPend
                ENDIF
                loc_oBusca.Release()
            CATCH TO loEx
                MostrarErro("Erro ao buscar conta: " + loEx.Message, "Erro")
            ENDTRY
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *-- ValidarMoedaPend - LostFocus no txt_4c_MoedaPend
    PROCEDURE ValidarMoedaPend(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cMoeda, loc_cSQL, loc_lOk, loc_oPag1
        loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_cMoeda = ALLTRIM(loc_oPag1.txt_4c_MoedaPend.Value)

        IF EMPTY(loc_cMoeda)
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE cmoes = " + EscaparSQL(loc_cMoeda)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoePendLookup") > 0
                IF !EOF("cursor_4c_MoePendLookup") AND RECCOUNT("cursor_4c_MoePendLookup") > 0
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_MoePendLookup")
                    USE IN cursor_4c_MoePendLookup
                ENDIF
            ENDIF
        CATCH TO loEx
            MostrarErro("Erro ao validar moeda: " + loEx.Message, "Erro")
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cMoeda)
            MsgAviso("Moeda '" + loc_cMoeda + ;
                "' n" + CHR(227) + "o encontrada. Use F4 para pesquisar.")
            loc_oPag1.txt_4c_MoedaPend.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaMoedaPend - F4 abre lookup de moedas
    PROCEDURE TeclaMoedaPend(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oBusca, loc_oPag1
            loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", "", ;
                    "Buscar Moeda")
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Moeda")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                    loc_oPag1.txt_4c_MoedaPend.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                ENDIF
                IF USED("cursor_4c_BuscaMoeda")
                    USE IN cursor_4c_BuscaMoeda
                ENDIF
                loc_oBusca.Release()
            CATCH TO loEx
                MostrarErro("Erro ao buscar moeda: " + loEx.Message, "Erro")
            ENDTRY
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *-- ValidarGrupoNP - LostFocus no txt_4c_GrupoNP (NovaPendencia)
    PROCEDURE ValidarGrupoNP(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cSQL, loc_lOk, loc_oCnt
        loc_oCnt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.cnt_4c_NovaPendencia
        loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_GrupoNP.Value)

        IF EMPTY(loc_cGrupo)
            loc_oCnt.txt_4c_NGrupoNP.Value = ""
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrNPLookup") > 0
                IF !EOF("cursor_4c_GrNPLookup") AND RECCOUNT("cursor_4c_GrNPLookup") > 0
                    loc_oCnt.txt_4c_NGrupoNP.Value = ALLTRIM(cursor_4c_GrNPLookup.Descrs)
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_GrNPLookup")
                    USE IN cursor_4c_GrNPLookup
                ENDIF
            ENDIF
        CATCH TO loEx
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cGrupo)
            MsgAviso("Grupo n" + CHR(227) + "o encontrado.")
            loc_oCnt.txt_4c_GrupoNP.Value  = ""
            loc_oCnt.txt_4c_NGrupoNP.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaGrupoNP - F4 abre lookup para grupo em NovaPendencia
    PROCEDURE TeclaGrupoNP(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oBusca, loc_oCnt
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.cnt_4c_NovaPendencia
            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGrNP", "cgrus", "", "Buscar Grupo")
                loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrNP")
                    loc_oCnt.txt_4c_GrupoNP.Value  = ALLTRIM(cursor_4c_BuscaGrNP.cgrus)
                    loc_oCnt.txt_4c_NGrupoNP.Value = ALLTRIM(cursor_4c_BuscaGrNP.dgrus)
                ENDIF
                IF USED("cursor_4c_BuscaGrNP")
                    USE IN cursor_4c_BuscaGrNP
                ENDIF
                loc_oBusca.Release()
            CATCH TO loEx
                MostrarErro("Erro ao buscar grupo: " + loEx.Message, "Erro")
            ENDTRY
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *-- ValidarContaNP - LostFocus no txt_4c_ContaNP (NovaPendencia)
    PROCEDURE ValidarContaNP(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cConta, loc_cSQL, loc_lOk, loc_oCnt
        loc_oCnt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.cnt_4c_NovaPendencia
        loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_GrupoNP.Value)
        loc_cConta = ALLTRIM(loc_oCnt.txt_4c_ContaNP.Value)

        IF EMPTY(loc_cConta)
            loc_oCnt.txt_4c_NContaNP.Value = ""
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdCcr WHERE Codigos = " + EscaparSQL(loc_cConta)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND cgrus = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtNPLookup") > 0
                IF !EOF("cursor_4c_CtNPLookup") AND RECCOUNT("cursor_4c_CtNPLookup") > 0
                    loc_oCnt.txt_4c_NContaNP.Value = ALLTRIM(cursor_4c_CtNPLookup.Descrs)
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_CtNPLookup")
                    USE IN cursor_4c_CtNPLookup
                ENDIF
            ENDIF
        CATCH TO loEx
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cConta)
            MsgAviso("Conta n" + CHR(227) + "o encontrada.")
            loc_oCnt.txt_4c_ContaNP.Value  = ""
            loc_oCnt.txt_4c_NContaNP.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaContaNP - F4 abre lookup de contas para NovaPendencia
    PROCEDURE TeclaContaNP(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oBusca, loc_oCnt, loc_cGrupo, loc_cFiltro
            loc_oCnt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.cnt_4c_NovaPendencia
            loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_GrupoNP.Value)
            loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "cgrus=" + EscaparSQL(loc_cGrupo), "")
            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCcr", "cursor_4c_BuscaCtNP", "Codigos", loc_cFiltro, "Buscar Conta")
                loc_oBusca.mAddColuna("cgrus",   "", "Grupo")
                loc_oBusca.mAddColuna("Codigos", "", "Conta")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtNP")
                    loc_oCnt.txt_4c_GrupoNP.Value  = ALLTRIM(cursor_4c_BuscaCtNP.cgrus)
                    loc_oCnt.txt_4c_ContaNP.Value  = ALLTRIM(cursor_4c_BuscaCtNP.Codigos)
                    loc_oCnt.txt_4c_NContaNP.Value = ALLTRIM(cursor_4c_BuscaCtNP.Descrs)
                ENDIF
                IF USED("cursor_4c_BuscaCtNP")
                    USE IN cursor_4c_BuscaCtNP
                ENDIF
                loc_oBusca.Release()
            CATCH TO loEx
                MostrarErro("Erro ao buscar conta: " + loEx.Message, "Erro")
            ENDTRY
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *-- ValidarGrupoCNP - LostFocus no txt_4c_GrupoCNP (Contra-Partida)
    PROCEDURE ValidarGrupoCNP(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cSQL, loc_lOk, loc_oCnt
        loc_oCnt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.cnt_4c_NovaPendencia
        loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_GrupoCNP.Value)

        IF EMPTY(loc_cGrupo)
            loc_oCnt.txt_4c_NGrupoCNP.Value = ""
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrCNPLookup") > 0
                IF !EOF("cursor_4c_GrCNPLookup") AND RECCOUNT("cursor_4c_GrCNPLookup") > 0
                    loc_oCnt.txt_4c_NGrupoCNP.Value = ALLTRIM(cursor_4c_GrCNPLookup.Descrs)
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_GrCNPLookup")
                    USE IN cursor_4c_GrCNPLookup
                ENDIF
            ENDIF
        CATCH TO loEx
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cGrupo)
            MsgAviso("Grupo n" + CHR(227) + "o encontrado.")
            loc_oCnt.txt_4c_GrupoCNP.Value  = ""
            loc_oCnt.txt_4c_NGrupoCNP.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaGrupoCNP - F4 abre lookup de grupos para Contra-Partida
    PROCEDURE TeclaGrupoCNP(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oBusca, loc_oCnt
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.cnt_4c_NovaPendencia
            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGrCNP", "cgrus", "", "Buscar Grupo")
                loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrCNP")
                    loc_oCnt.txt_4c_GrupoCNP.Value  = ALLTRIM(cursor_4c_BuscaGrCNP.cgrus)
                    loc_oCnt.txt_4c_NGrupoCNP.Value = ALLTRIM(cursor_4c_BuscaGrCNP.dgrus)
                ENDIF
                IF USED("cursor_4c_BuscaGrCNP")
                    USE IN cursor_4c_BuscaGrCNP
                ENDIF
                loc_oBusca.Release()
            CATCH TO loEx
                MostrarErro("Erro ao buscar grupo: " + loEx.Message, "Erro")
            ENDTRY
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *-- ValidarContaCNP - LostFocus no txt_4c_ContaCNP (Contra-Partida)
    PROCEDURE ValidarContaCNP(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_cConta, loc_cSQL, loc_lOk, loc_oCnt
        loc_oCnt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.cnt_4c_NovaPendencia
        loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_GrupoCNP.Value)
        loc_cConta = ALLTRIM(loc_oCnt.txt_4c_ContaCNP.Value)

        IF EMPTY(loc_cConta)
            loc_oCnt.txt_4c_NContaCNP.Value = ""
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdCcr WHERE Codigos = " + EscaparSQL(loc_cConta)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND cgrus = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtCNPLookup") > 0
                IF !EOF("cursor_4c_CtCNPLookup") AND RECCOUNT("cursor_4c_CtCNPLookup") > 0
                    loc_oCnt.txt_4c_NContaCNP.Value = ALLTRIM(cursor_4c_CtCNPLookup.Descrs)
                    loc_lOk = .T.
                ENDIF
                IF USED("cursor_4c_CtCNPLookup")
                    USE IN cursor_4c_CtCNPLookup
                ENDIF
            ENDIF
        CATCH TO loEx
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cConta)
            MsgAviso("Conta n" + CHR(227) + "o encontrada.")
            loc_oCnt.txt_4c_ContaCNP.Value  = ""
            loc_oCnt.txt_4c_NContaCNP.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaContaCNP - F4 abre lookup de contas para Contra-Partida
    PROCEDURE TeclaContaCNP(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oBusca, loc_oCnt, loc_cGrupo, loc_cFiltro
            loc_oCnt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.cnt_4c_NovaPendencia
            loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_GrupoCNP.Value)
            loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "cgrus=" + EscaparSQL(loc_cGrupo), "")
            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCcr", "cursor_4c_BuscaCtCNP", "Codigos", loc_cFiltro, "Buscar Conta")
                loc_oBusca.mAddColuna("cgrus",   "", "Grupo")
                loc_oBusca.mAddColuna("Codigos", "", "Conta")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtCNP")
                    loc_oCnt.txt_4c_GrupoCNP.Value  = ALLTRIM(cursor_4c_BuscaCtCNP.cgrus)
                    loc_oCnt.txt_4c_ContaCNP.Value  = ALLTRIM(cursor_4c_BuscaCtCNP.Codigos)
                    loc_oCnt.txt_4c_NContaCNP.Value = ALLTRIM(cursor_4c_BuscaCtCNP.Descrs)
                ENDIF
                IF USED("cursor_4c_BuscaCtCNP")
                    USE IN cursor_4c_BuscaCtCNP
                ENDIF
                loc_oBusca.Release()
            CATCH TO loEx
                MostrarErro("Erro ao buscar conta: " + loEx.Message, "Erro")
            ENDTRY
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *-- ValidarMoedaNP - LostFocus no txt_4c_MoedaNP
    PROCEDURE ValidarMoedaNP(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cMoeda, loc_cSQL, loc_lOk, loc_oCnt
        loc_oCnt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.cnt_4c_NovaPendencia
        loc_cMoeda = ALLTRIM(loc_oCnt.txt_4c_MoedaNP.Value)

        IF EMPTY(loc_cMoeda)
            RETURN
        ENDIF

        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE cmoes = " + EscaparSQL(loc_cMoeda)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeNPLookup") > 0
                IF !EOF("cursor_4c_MoeNPLookup") AND RECCOUNT("cursor_4c_MoeNPLookup") > 0
                    loc_lOk = .T.
                    *-- Replica moeda para contra-partida e atualiza valor convertido
                    loc_oCnt.txt_4c_MoedaCNP.Value  = loc_cMoeda
                    loc_oCnt.txt_4c_ValorCNP.Value  = loc_oCnt.txt_4c_ValorNP.Value
                ENDIF
                IF USED("cursor_4c_MoeNPLookup")
                    USE IN cursor_4c_MoeNPLookup
                ENDIF
            ENDIF
        CATCH TO loEx
            MostrarErro("Erro ao validar moeda: " + loEx.Message, "Erro")
        ENDTRY

        IF !loc_lOk AND !EMPTY(loc_cMoeda)
            MsgAviso("Moeda '" + loc_cMoeda + ;
                "' n" + CHR(227) + "o encontrada. Use F4 para pesquisar.")
            loc_oCnt.txt_4c_MoedaNP.Value = ""
        ENDIF
    ENDPROC

    *-- TeclaMoedaNP - F4 abre lookup de moedas para NovaPendencia
    PROCEDURE TeclaMoedaNP(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oBusca, loc_oCnt
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.cnt_4c_NovaPendencia
            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdMoe", "cursor_4c_BuscaMoedaNP", "cmoes", "", "Buscar Moeda")
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Moeda")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedaNP")
                    loc_oCnt.txt_4c_MoedaNP.Value = ALLTRIM(cursor_4c_BuscaMoedaNP.cmoes)
                ENDIF
                IF USED("cursor_4c_BuscaMoedaNP")
                    USE IN cursor_4c_BuscaMoedaNP
                ENDIF
                loc_oBusca.Release()
            CATCH TO loEx
                MostrarErro("Erro ao buscar moeda: " + loEx.Message, "Erro")
            ENDTRY
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Handlers de botoes e eventos
    *--------------------------------------------------------------------------
    PROCEDURE BtnConciliacaoClick()
        LOCAL loc_oPag1, loc_nOpcao, loc_cSQL
        loc_oPag1  = THIS.pgf_4c_Paginas.Page1
        loc_nOpcao = loc_oPag1.cmb_4c_Conciliacao.Value

        IF loc_nOpcao = 2
            MsgAviso("Lotes j" + CHR(225) + " conciliados n" + ;
                CHR(227) + "o requerem nova concilia" + CHR(231) + CHR(227) + "o.")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma a concilia" + CHR(231) + CHR(227) + ;
                "o dos lan" + CHR(231) + "amentos filtrados?")
            TRY
                loc_cSQL = "UPDATE SigCdPgr SET Concs = 1 WHERE Concs = 0"
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    MsgSucesso("Concilia" + CHR(231) + CHR(227) + "o realizada!")
                    THIS.CarregarLista()
                ELSE
                    MsgAviso("Nenhum lan" + CHR(231) + "amento conciliado.")
                ENDIF
            CATCH TO loEx
                MostrarErro("Erro na concilia" + CHR(231) + CHR(227) + "o: " + ;
                    loEx.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    PROCEDURE ChkTodosLancClick()
        THIS.CarregarLista()
    ENDPROC

    PROCEDURE OptNFChange()
        *-- Recarregar grade de clientes filtrando por NF (Sim/Nao/Ambos)
        IF USED("cursor_4c_Clientes") AND RECCOUNT("cursor_4c_Clientes") > 0
            THIS.CarregarGradeClientes()
        ENDIF
    ENDPROC

    PROCEDURE OptOcorrenciasChange()
        *-- Recarregar grade de clientes filtrando por ocorrencias
        IF USED("cursor_4c_Clientes") AND RECCOUNT("cursor_4c_Clientes") > 0
            THIS.CarregarGradeClientes()
        ENDIF
    ENDPROC

    PROCEDURE OptOperadoraChange()
        *-- Recarregar grade de clientes filtrando por operadora
        IF USED("cursor_4c_Clientes") AND RECCOUNT("cursor_4c_Clientes") > 0
            THIS.CarregarGradeClientes()
        ENDIF
    ENDPROC

    PROCEDURE BtnCNABClick()
        LOCAL loc_oPag3, loc_cBanco
        loc_oPag3  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3
        loc_cBanco = ALLTRIM(loc_oPag3.cmb_4c_CNAB.Value)

        IF EMPTY(loc_cBanco)
            MsgAviso("Selecione o banco para gerar o arquivo CNAB.")
            RETURN
        ENDIF

        MsgInfo("Gera" + CHR(231) + CHR(227) + "o CNAB - Banco: " + loc_cBanco)
    ENDPROC

    PROCEDURE BtnProcessarClick()
        LOCAL loc_oPag3
        loc_oPag3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3

        IF !USED("cursor_4c_Clientes") OR RECCOUNT("cursor_4c_Clientes") = 0
            MsgAviso("Carregue os dados do respons" + CHR(225) + ;
                "vel antes de processar.")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma o processamento do lan" + CHR(231) + "amento?")
            TRY
                *-- Habilitar sub-paginas de titulos e pagamento
                WITH THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas
                    .Page1.Enabled = .T.
                    .Page2.Enabled = .T.
                ENDWITH

                *-- Exibir botao Reprocessar
                loc_oPag3.cmd_4c_Reprocessar.Visible = .T.

                *-- Carregar grade com itens do lancamento
                THIS.CarregarGradePendencias()

                MsgSucesso("Lan" + CHR(231) + "amento processado com sucesso!")

            CATCH TO loEx
                MostrarErro("Erro no processamento: " + loEx.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    PROCEDURE BtnReprocessarClick()
        IF MsgConfirma("Confirma o reprocessamento do lan" + CHR(231) + "amento?")
            TRY
                THIS.CarregarGradePendencias()
                MsgSucesso("Reprocessamento conclu" + CHR(237) + "do.")
            CATCH TO loEx
                MostrarErro("Erro no reprocessamento: " + loEx.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    PROCEDURE BtnBoletoClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum lan" + CHR(231) + "amento selecionado.")
            RETURN
        ENDIF
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(cursor_4c_Dados.empdopnums)
        MsgInfo("Gera" + CHR(231) + CHR(227) + "o de boleto - Lan" + ;
            CHR(231) + "amento: " + loc_cChave)
    ENDPROC

    PROCEDURE BtnDocumentoClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum lan" + CHR(231) + "amento selecionado.")
            RETURN
        ENDIF
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(cursor_4c_Dados.empdopnums)
        MsgInfo("Impress" + CHR(227) + "o de documento - Lan" + ;
            CHR(231) + "amento: " + loc_cChave)
    ENDPROC

    PROCEDURE BtnReciboClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum lan" + CHR(231) + "amento selecionado.")
            RETURN
        ENDIF
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(cursor_4c_Dados.empdopnums)
        MsgInfo("Impress" + CHR(227) + "o de recibo - Lan" + ;
            CHR(231) + "amento: " + loc_cChave)
    ENDPROC

    PROCEDURE OptOpcaoChange()
        THIS.CarregarGradePendencias()
    ENDPROC

    PROCEDURE BtnNovoLactoClick()
        *-- Exibir container flutuante NovaPendencia
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_oPag1.cnt_4c_NovaPendencia.Visible = .T.
    ENDPROC

    PROCEDURE BtnPagUnicoClick()
        *-- Exibir container flutuante Pagamento
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_oPag1.cnt_4c_Pagamento.Visible = .T.
    ENDPROC

    PROCEDURE BtnConfirmaNPClick()
        *-- Confirmar novo lancamento e ocultar container
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_oPag1.cnt_4c_NovaPendencia.Visible = .F.
        THIS.CarregarGradePendencias()
    ENDPROC

    PROCEDURE BtnCancelarNPClick()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_oPag1.cnt_4c_NovaPendencia.Visible = .F.
    ENDPROC

    PROCEDURE BtnConfirmaPagClick()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_oPag1.cnt_4c_Pagamento.Visible = .F.
        THIS.CarregarGradePendencias()
    ENDPROC

    PROCEDURE BtnCancelarPagClick()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_oPag1.cnt_4c_Pagamento.Visible = .F.
    ENDPROC

    PROCEDURE BtnAnexaClick()
        IF !USED("cursor_4c_Pendencias") OR RECCOUNT("cursor_4c_Pendencias") = 0
            MsgAviso("Selecione um t" + CHR(237) + "tulo para anexar arquivos.")
            RETURN
        ENDIF
        MsgInfo("Funcionalidade de anexo de arquivos.")
    ENDPROC

    PROCEDURE BtnBusNFsClick()
        *-- Filtrar exibindo apenas itens com NF (opt_4c_NF = Sim)
        LOCAL loc_oPag3
        loc_oPag3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page3
        loc_oPag3.opt_4c_NF.Value = 1
        IF USED("cursor_4c_Clientes") AND RECCOUNT("cursor_4c_Clientes") > 0
            THIS.CarregarGradeClientes()
        ENDIF
    ENDPROC

    PROCEDURE BtnMarcarClick()
        *-- Marca/desmarca todos os titulos no grid ContaCorrente
        IF USED("cursor_4c_Pendencias") AND RECCOUNT("cursor_4c_Pendencias") > 0
            LOCAL loc_lMarcar
            GO TOP IN cursor_4c_Pendencias
            loc_lMarcar = !cursor_4c_Pendencias.Flag
            REPLACE ALL Flag WITH loc_lMarcar IN cursor_4c_Pendencias
        ENDIF
    ENDPROC

    PROCEDURE BtnCadastrosClick()
        MsgInfo("Acesso a cadastros auxiliares de lan" + CHR(231) + "amentos.")
    ENDPROC

    PROCEDURE BtnAltCotacaoClick()
        LOCAL loc_oPag1, loc_nCotacao, loc_nValor
        loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_nCotacao = loc_oPag1.txt_4c_CotacaoPend.Value

        IF loc_nCotacao <= 0
            MsgAviso("Informe uma cota" + CHR(231) + CHR(227) + ;
                "o v" + CHR(225) + "lida.")
            RETURN
        ENDIF

        *-- Recalcula valor convertido com nova cotacao
        loc_nValor = loc_oPag1.txt_4c_ValorPend.Value
        loc_oPag1.txt_4c_ValConvPend.Value = loc_nValor * loc_nCotacao
    ENDPROC

    PROCEDURE BtnAltCotacaoPagClick()
        LOCAL loc_oPag2, loc_nCotacao
        loc_oPag2    = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
        loc_nCotacao = loc_oPag2.txt_4c_CotacaoPag.Value

        IF loc_nCotacao <= 0
            MsgAviso("Informe uma cota" + CHR(231) + CHR(227) + ;
                "o v" + CHR(225) + "lida.")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_cMoedas = ;
            ALLTRIM(THIS.this_oBusinessObject.this_cMoedas)
        MsgInfo("Cota" + CHR(231) + CHR(227) + "o atualizada: " + ;
            TRANSFORM(loc_nCotacao))
    ENDPROC

    PROCEDURE BtnBaixaPendClick()
        LOCAL loc_nMarcados, loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1

        IF !USED("cursor_4c_Pendencias") OR RECCOUNT("cursor_4c_Pendencias") = 0
            MsgAviso("Nenhum t" + CHR(237) + "tulo dispon" + CHR(237) + "vel para baixar.")
            RETURN
        ENDIF

        loc_nMarcados = 0
        GO TOP IN cursor_4c_Pendencias
        DO WHILE !EOF("cursor_4c_Pendencias")
            IF cursor_4c_Pendencias.Flag
                loc_nMarcados = loc_nMarcados + 1
            ENDIF
            SKIP IN cursor_4c_Pendencias
        ENDDO

        IF loc_nMarcados = 0
            MsgAviso("Marque pelo menos um t" + CHR(237) + "tulo para baixar.")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma baixa de " + TRANSFORM(loc_nMarcados) + ;
                " t" + CHR(237) + "tulo(s) selecionado(s)?")
            loc_oPag1.cnt_4c_Pagamento.Visible = .T.
        ENDIF
    ENDPROC

    PROCEDURE BtnApagaClick()
        IF !USED("cursor_4c_Parcelas") OR RECCOUNT("cursor_4c_Parcelas") = 0
            MsgAviso("Nenhum pagamento para apagar.")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma o estorno do pagamento?")
            TRY
                LOCAL loc_cSQL
                loc_cSQL = "DELETE FROM SigMvCcr " + ;
                           "WHERE EmpDopNcs = " + ;
                           EscaparSQL(THIS.this_oBusinessObject.this_cEmpdopnums)

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    IF USED("cursor_4c_Parcelas")
                        ZAP IN cursor_4c_Parcelas
                    ENDIF
                    IF USED("cursor_4c_TotalPag")
                        ZAP IN cursor_4c_TotalPag
                    ENDIF
                    MsgSucesso("Pagamento estornado com sucesso!")
                    THIS.CarregarGradePendencias()
                ELSE
                    MsgAviso("Nenhum pagamento encontrado para estornar.")
                ENDIF
            CATCH TO loEx
                MostrarErro("Erro ao estornar: " + loEx.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    PROCEDURE BtnAcertoClick()
        LOCAL loc_nMarcados, loc_nValAcerto, loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1

        IF !USED("cursor_4c_Pendencias") OR RECCOUNT("cursor_4c_Pendencias") = 0
            MsgAviso("Nenhum t" + CHR(237) + "tulo para ajustar.")
            RETURN
        ENDIF

        loc_nMarcados = 0
        GO TOP IN cursor_4c_Pendencias
        DO WHILE !EOF("cursor_4c_Pendencias")
            IF cursor_4c_Pendencias.Flag
                loc_nMarcados = loc_nMarcados + 1
            ENDIF
            SKIP IN cursor_4c_Pendencias
        ENDDO

        IF loc_nMarcados = 0
            MsgAviso("Marque pelo menos um t" + CHR(237) + "tulo para ajustar.")
            RETURN
        ENDIF

        loc_nValAcerto = loc_oPag1.txt_4c_ValorPend.Value
        GO TOP IN cursor_4c_Pendencias
        DO WHILE !EOF("cursor_4c_Pendencias")
            IF cursor_4c_Pendencias.Flag
                REPLACE cursor_4c_Pendencias.Acerto WITH loc_nValAcerto
            ENDIF
            SKIP IN cursor_4c_Pendencias
        ENDDO

        MsgSucesso("Acerto aplicado em " + TRANSFORM(loc_nMarcados) + ;
            " t" + CHR(237) + "tulo(s).")
    ENDPROC

    PROCEDURE BtnGerarParcelasClick()
        LOCAL loc_oPag2, loc_cFpg, loc_nNPar, loc_nVPar, loc_dVenc, loc_cMoeda
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2

        loc_cFpg  = ALLTRIM(loc_oPag2.txt_4c_Fpg.Value)
        loc_nNPar = loc_oPag2.txt_4c_NPar.Value
        loc_nVPar = loc_oPag2.txt_4c_VPar.Value
        loc_dVenc = loc_oPag2.txt_4c_Venc.Value

        IF EMPTY(loc_cFpg)
            MsgAviso("Informe a forma de pagamento.")
            RETURN
        ENDIF

        IF loc_nNPar <= 0
            MsgAviso("Informe o n" + CHR(250) + "mero de parcelas.")
            RETURN
        ENDIF

        IF loc_nVPar <= 0
            MsgAviso("Informe o valor da parcela.")
            RETURN
        ENDIF

        IF EMPTY(loc_dVenc)
            MsgAviso("Informe a data de vencimento.")
            RETURN
        ENDIF

        *-- Limpar e gerar parcelas
        IF USED("cursor_4c_Parcelas")
            ZAP IN cursor_4c_Parcelas
        ENDIF

        loc_cMoeda = ALLTRIM(THIS.this_oBusinessObject.this_cMoedas)
        IF EMPTY(loc_cMoeda)
            loc_cMoeda = "BRL"
        ENDIF

        LOCAL loc_nI, loc_dVencParcela
        loc_dVencParcela = loc_dVenc

        FOR loc_nI = 1 TO loc_nNPar
            INSERT INTO cursor_4c_Parcelas (fpagto, valor, venc, moeda) ;
            VALUES (loc_cFpg, loc_nVPar, loc_dVencParcela, loc_cMoeda)
            loc_dVencParcela = GOMONTH(loc_dVencParcela, 1)
        ENDFOR

        IF USED("cursor_4c_TotalPag")
            ZAP IN cursor_4c_TotalPag
            INSERT INTO cursor_4c_TotalPag (Moeda, ValPag, ValPend, ValDif) ;
            VALUES (loc_cMoeda, loc_nNPar * loc_nVPar, 0, -(loc_nNPar * loc_nVPar))
        ENDIF

        MsgSucesso(TRANSFORM(INT(loc_nNPar)) + " parcela(s) gerada(s).")
    ENDPROC

    PROCEDURE BtnImprimeChequeClick()
        LOCAL loc_oPag2, loc_cNumero
        loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
        loc_cNumero = ALLTRIM(loc_oPag2.cnt_4c_Cheque.txt_4c_NumChe.Value)

        IF EMPTY(loc_cNumero)
            MsgAviso("Informe o n" + CHR(250) + ;
                "mero do cheque para imprimir.")
            RETURN
        ENDIF

        MsgInfo("Impress" + CHR(227) + "o de cheque n" + CHR(250) + ;
            " " + loc_cNumero + ".")
    ENDPROC

    PROCEDURE BtnLerChequesClick()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
        loc_oPag2.cnt_4c_ApanhaChq.Visible = .T.
    ENDPROC

    PROCEDURE BtnOkApanhaClick()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2

        WITH loc_oPag2
            .cnt_4c_Cheque.txt_4c_BcoChe.Value = ;
                ALLTRIM(.cnt_4c_ApanhaChq.txt_4c_BancoApanha.Value)
            .cnt_4c_Cheque.txt_4c_AgeChe.Value = ;
                ALLTRIM(.cnt_4c_ApanhaChq.txt_4c_AgeApanha.Value)
            .cnt_4c_Cheque.txt_4c_NumChe.Value = ;
                ALLTRIM(.cnt_4c_ApanhaChq.txt_4c_NumApanha.Value)
            .cnt_4c_Cheque.txt_4c_CtaChe.Value = ;
                ALLTRIM(.cnt_4c_ApanhaChq.txt_4c_CtaApanha.Value)
            .cnt_4c_ApanhaChq.Visible = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre paginas do PageFrame principal
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta visibilidade/habilitacao dos botoes
    * conforme modo atual: LISTA, INCLUIR, ALTERAR, VISUALIZAR
    * Legado: msv_ajstBotoes (ajusta Salva/Cancelar na Page2 e CRUD na Page1)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_lEdicao, loc_lLista
        loc_lEdicao = (par_cModo = "INCLUIR" OR par_cModo = "ALTERAR")
        loc_lLista  = (par_cModo = "LISTA")

        *-- Botoes Salvar/Cancelar na Page2 (visivel apenas em edicao)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
                .cmd_4c_Salvar.Enabled  = loc_lEdicao
                .cmd_4c_Cancelar.Enabled = .T.
                .Visible     = .T.
            ENDWITH

            *-- Botoes CRUD na Page1 (habilitados apenas na lista)
            WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
                .cmd_4c_Incluir.Enabled    = THIS.placinserir
                .cmd_4c_Visualizar.Enabled = .T.
                .cmd_4c_Alterar.Enabled    = THIS.placalterar
                .cmd_4c_Excluir.Enabled    = THIS.placexcluir
                .cmd_4c_Buscar.Enabled     = .T.
                .cmd_4c_Encerrar.Enabled   = .T.
                .Visible     = .T.
            ENDWITH
        ENDIF
    ENDPROC

ENDDEFINE
