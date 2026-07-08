*==============================================================================
* Formcfo.prg - Formulario de Cadastro de CFOP
* Tabela: SigCdCfo | PK: codigos
* Data: 2026-04-11
* Fase 5/8 - Form - Campos Principais (Page2 - Parte 1)
*==============================================================================

DEFINE CLASS Formcfo AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de CFOP"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Guardias LostFocus: evita revalidar quando valor nao mudou
    this_cUltimoValidarCfoST60Validado  = ""
    this_cUltimoValidarCfoSTValidado    = ""
    this_cUltimoValidarCfdestValidado   = ""
    this_cUltimoValidarSittricmValidado = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o formulario via FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("cfoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar cfoBO", "InicializarForm")
            ELSE
                *-- Configurar PageFrame externo (Lista/Dados)
                THIS.ConfigurarPageFrame()

                *-- Propagar titulo para labels do cabecalho
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar lista inicial (pula se validando UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame externo com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = 1000
            .Height     = 629
            .Tabs       = .F.
            .Visible    = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)

        *-- Configurar Page1 e Page2
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()

        THIS.pgf_4c_Paginas.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, grid, botoes XML
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (titulo do formulario - lado esquerdo)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label sombra (efeito de sombra no titulo)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Cadastro de CFOP"
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

        *-- Label titulo (branco - sobre a sombra)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de CFOP"
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

        *-- Container botoes CRUD (lado direito - a partir de Left=542)
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

        *-- Container botao Encerrar (extrema direita)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Encerrar
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

        *-- Botoes XML (abaixo da barra de cabecalho, compensados +29)
        *-- Original: btnExpXML top=85, left=3 -> compensado: 85+29=114
        loc_oPagina.AddObject("cmd_4c_ExpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExpXML
            .Caption       = "  Exporta XML"
            .Top           = 114
            .Left          = 3
            .Width         = 120
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(240, 240, 240)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_ImpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_ImpXML
            .Caption       = "  Importa XML"
            .Top           = 114
            .Left          = 127
            .Width         = 120
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(240, 240, 240)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Grid de lista (abaixo dos botoes XML)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 157
            .Left               = 0
            .Width              = 995
            .Height             = 438
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

        *-- BINDEVENT para botoes (PUBLIC para funcionar com BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_ExpXML,                   "Click", THIS, "BtnExpXMLClick")
        BINDEVENT(loc_oPagina.cmd_4c_ImpXML,                   "Click", THIS, "BtnImpXMLClick")
        BINDEVENT(loc_oPagina.grd_4c_Lista,                    "DblClick", THIS, "GrdListaDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar e inner PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (canto superior direito, +29 compensado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
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

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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

        *-- PageFrame interno: Page1=Dados Principais, Page2=Integracao Contabil/Fiscal
        *-- Compensacao +29 aplicada ao top original (120 + 29 = 149)
        loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
        WITH loc_oPagina.pgf_4c_PagDados
            .PageCount  = 2
            .Top        = 149
            .Left       = -1
            .Width      = 998
            .Height     = 476
            .Tabs       = .T.
            .Visible    = .T.
        ENDWITH

        WITH loc_oPagina.pgf_4c_PagDados.Page1
            .Caption    = "Dados Principais"
            .BackColor  = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oPagina.pgf_4c_PagDados.Page2
            .Caption    = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil / Fiscal"
            .BackColor  = RGB(255, 255, 255)
        ENDWITH

        *-- Campos Page1 - primeira metade (top < 236)
        THIS.ConfigurarPaginaDadosParte1()

        *-- Campos Page1 - segunda metade (top >= 236)
        THIS.ConfigurarPaginaDadosParte2()

        *-- Campos Page2 - Integracao Contabil/Fiscal
        THIS.ConfigurarPaginaDadosPage2()

        *-- BINDEVENT para botoes de acao
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        *-- Verificar modo de validacao de UI (sem conexao SQL)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas N(1,0))
                SET NULL OFF
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF THIS.this_oBusinessObject.Buscar("")
                *-- RecordSource e ColumnCount FORA de WITH para garantir criacao das colunas
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 2

                *-- Configurar colunas APOS RecordSource (redefine headers resetados pelo auto-bind)
                loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.codigos"
                loc_oGrid.Column1.Width            = 80
                loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
                loc_oGrid.Column1.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"

                loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descricaos"
                loc_oGrid.Column2.Width            = 400
                loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column2.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Obs: Percorre Pages de PageFrames e Controls de Containers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cBaseClass

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cBaseClass = UPPER(loc_oObjeto.BaseClass)

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    *-- Preservar containers com Visible=.F. ou excluidos por nome (ocultos intencionalmente)
                    IF loc_cBaseClass = "CONTAINER" AND ;
                       (!loc_oObjeto.Visible OR INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO"))
                        *-- Nao alterar: container oculto intencional ou gerenciado externamente
                    ELSE
                        loc_oObjeto.Visible = .T.
                    ENDIF
                ENDIF

                *-- Trata PageFrame: itera Pages
                IF loc_cBaseClass = "PAGEFRAME"
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
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                    THIS.AjustarBotoesPorModo()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Abre Page2 para inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Codigo.SetFocus()
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.pgf_4c_Paginas.ActivePage = 2
            ELSE
                MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.pgf_4c_Paginas.ActivePage = 2
                THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Descricao.SetFocus()
            ELSE
                MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui o registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo  = ""
        loc_lConfirma = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do CFOP '" + ;
            loc_cCodigo + "'?", "Excluir")

        IF loc_lConfirma
            TRY
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgSucesso("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MostrarErro(loc_oErro, "Formcfo.BtnExcluirClick")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre busca auxiliar para localizar CFOP
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca
        loc_oBusca = .NULL.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCFO", "codigos", "", ;
                "Buscar CFOP")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCFO")
                    SELECT cursor_4c_BuscaCFO
                    GO TOP
                ENDIF
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaCFO")
            USE IN cursor_4c_BuscaCFO
        ENDIF

        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExpXMLClick - Exporta CFOP selecionado para XML (via SigOpXml)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExpXMLClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para exportar.", "Exporta XML")
            RETURN
        ENDIF

        TRY
            DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "CFOP", 10
            THIS.CarregarLista()
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.BtnExpXMLClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImpXMLClick - Importa CFOP de arquivo XML (via SigOpXml)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImpXMLClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        TRY
            DO FORM SigOpXml WITH THIS, loc_cCodigo, "I", "CFOP", 10
            THIS.CarregarLista()
            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.BtnImpXMLClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdListaDblClick - DblClick na lista abre visualizacao do registro
    *--------------------------------------------------------------------------
    PROCEDURE GrdListaDblClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDadosParte1 - Page1 do PagDados: primeira metade (top < 236)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDadosParte1()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1

        *----------------------------------------------------------------------
        *-- Grupo 1: Cabecalho (top 0-90)
        *----------------------------------------------------------------------

        *-- Label Codigo
        loc_oPag1.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag1.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 11
            .Left      = 91
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Codigo CFOP
        loc_oPag1.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPag1.txt_4c_Codigo
            .Top           = 7
            .Left          = 136
            .Width         = 91
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Situacao (Ativo/Inativo)
        loc_oPag1.AddObject("obj_4c_Opc_situacao", "OptionGroup")
        WITH loc_oPag1.obj_4c_Opc_situacao
            .ButtonCount = 2
            .Top         = 11
            .Left        = 243
            .Width       = 137
            .Height      = 17
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag1.obj_4c_Opc_situacao.Buttons(1)
            .Caption   = "Ativo"
            .BackStyle = 0
            .Left      = 0
            .Top       = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag1.obj_4c_Opc_situacao.Buttons(2)
            .Caption   = "Inativo"
            .BackStyle = 0
            .Left      = 60
            .Top       = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Operacao
        loc_oPag1.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag1.lbl_4c_Label3
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 11
            .Left      = 393
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Operacao (E=Entrada, S=Saida)
        loc_oPag1.AddObject("cbo_4c_CmbOperacao", "ComboBox")
        WITH loc_oPag1.cbo_4c_CmbOperacao
            .Top           = 7
            .Left          = 459
            .Width         = 107
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Entrada;Sa" + CHR(237) + "da"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Tipo
        loc_oPag1.AddObject("lbl_4c_Label37", "Label")
        WITH loc_oPag1.lbl_4c_Label37
            .Caption   = "Tipo :"
            .Top       = 12
            .Left      = 616
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Tipo (1=Compras,2=Dev.Compras,3=Vendas,4=Dev.Vendas,5=Servicos)
        loc_oPag1.AddObject("cbo_4c_Cmbtipo", "ComboBox")
        WITH loc_oPag1.cbo_4c_Cmbtipo
            .Top           = 7
            .Left          = 653
            .Width         = 151
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .ColumnCount   = 2
            .BoundColumn   = 2
            .ColumnWidths  = "189;0"
            .RowSource     = "Compras,1,Devolu" + CHR(231) + CHR(227) + "o Compras,2,Vendas,3,Devolu" + CHR(231) + CHR(227) + "o Vendas,4,Servi" + CHR(231) + "os prestados,5"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Digitos Para NF
        loc_oPag1.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPag1.lbl_4c_Label24
            .Caption   = "D" + CHR(237) + "gitos Para NF :"
            .Top       = 12
            .Left      = 848
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Spinner Digitos Para NF (0-6)
        loc_oPag1.AddObject("obj_4c_Ndigito", "Spinner")
        WITH loc_oPag1.obj_4c_Ndigito
            .Top                = 7
            .Left               = 947
            .Width              = 40
            .Height             = 24
            .FontName           = "Tahoma"
            .FontSize           = 8
            .SpinnerHighValue   = 6
            .SpinnerLowValue    = 0
            .KeyboardHighValue  = 6
            .KeyboardLowValue   = 0
            .Increment          = 1
            .SpecialEffect      = 1
            .ForeColor          = RGB(90, 90, 90)
            .BorderColor        = RGB(100, 100, 100)
            .Visible            = .T.
        ENDWITH

        *-- Label Descricao Nota Fiscal
        loc_oPag1.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag1.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Nota Fiscal :"
            .Top       = 38
            .Left      = 23
            .Width     = 110
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao NF
        loc_oPag1.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPag1.txt_4c_Descricao
            .Top           = 34
            .Left          = 136
            .Width         = 430
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 60
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Descricao Consulta
        loc_oPag1.AddObject("lbl_4c_Label29", "Label")
        WITH loc_oPag1.lbl_4c_Label29
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Consulta :"
            .Top       = 65
            .Left      = 33
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao Consulta
        loc_oPag1.AddObject("txt_4c_Desc2s", "TextBox")
        WITH loc_oPag1.txt_4c_Desc2s
            .Top           = 61
            .Left          = 136
            .Width         = 430
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 60
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Linha separadora horizontal (shp01)
        loc_oPag1.AddObject("shp_4c_Shp01", "Shape")
        WITH loc_oPag1.shp_4c_Shp01
            .Top         = 92
            .Left        = 3
            .Width       = 984
            .Height      = 1
            .BackStyle   = 1
            .BackColor   = RGB(180, 180, 180)
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grupo 2: Secao ICMS (top 95-235)
        *----------------------------------------------------------------------

        *-- Label ICMS
        loc_oPag1.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPag1.lbl_4c_Label4
            .Caption   = "I C M S :"
            .Top       = 105
            .Left      = 90
            .Width     = 43
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo ICMS (T=Tributado, I=Isento, O=Outros, N=N.Tributa)
        loc_oPag1.AddObject("cbo_4c_CmbIcms", "ComboBox")
        WITH loc_oPag1.cbo_4c_CmbIcms
            .Top           = 101
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Tributado;Isento;Outros;N Tributa"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Incluir ICMS
        loc_oPag1.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oPag1.lbl_4c_Label26
            .Caption   = "Incluir ICMS :"
            .Top       = 105
            .Left      = 311
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Incluir ICMS (1=Nao, 2=Base, 3=Preco)
        loc_oPag1.AddObject("cbo_4c_Combo3", "ComboBox")
        WITH loc_oPag1.cbo_4c_Combo3
            .Top           = 101
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "N" + CHR(227) + "o,Base,Pre" + CHR(231) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label ICMS Sobre
        loc_oPag1.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPag1.lbl_4c_Label14
            .Caption   = "ICMS Sobre :"
            .Top       = 104
            .Left      = 481
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label CFOP ST60
        loc_oPag1.AddObject("lbl_4c_Label49", "Label")
        WITH loc_oPag1.lbl_4c_Label49
            .Caption   = "CFOP ST60:"
            .Top       = 102
            .Left      = 614
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox CFOP ST60 (lookup SigCdCfo)
        loc_oPag1.AddObject("txt_4c_CfoST60", "TextBox")
        WITH loc_oPag1.txt_4c_CfoST60
            .Top           = 101
            .Left          = 690
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label CFOP Subst.Trib.
        loc_oPag1.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPag1.lbl_4c_Label11
            .Caption   = "CFOP Subst.Trib.:"
            .Top       = 102
            .Left      = 791
            .Width     = 89
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox CFOP Subst.Trib. (lookup SigCdCfo)
        loc_oPag1.AddObject("txt_4c_CfoST", "TextBox")
        WITH loc_oPag1.txt_4c_CfoST
            .Top           = 101
            .Left          = 887
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Frete ICMS
        loc_oPag1.AddObject("chk_4c_ObjFreteICM", "CheckBox")
        WITH loc_oPag1.chk_4c_ObjFreteICM
            .Caption       = "Frete"
            .Top           = 102
            .Left          = 549
            .Width         = 44
            .Height        = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .AutoSize      = .T.
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Seguro ICMS
        loc_oPag1.AddObject("chk_4c_ObjSegIcm", "CheckBox")
        WITH loc_oPag1.chk_4c_ObjSegIcm
            .Caption       = "Seguro"
            .Top           = 117
            .Left          = 549
            .Width         = 52
            .Height        = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .AutoSize      = .T.
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH

        *-- Label Sobre Desconto
        loc_oPag1.AddObject("lbl_4c_Label31", "Label")
        WITH loc_oPag1.lbl_4c_Label31
            .Caption   = "Sobre Desconto :"
            .Top       = 131
            .Left      = 48
            .Width     = 85
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo ICMS Sobre Desconto (1=Sim, 2=Nao)
        loc_oPag1.AddObject("cbo_4c_Combo6", "ComboBox")
        WITH loc_oPag1.cbo_4c_Combo6
            .Top           = 127
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Inclui IPI na Base
        loc_oPag1.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPag1.lbl_4c_Label25
            .Caption   = "Inclui IPI na Base :"
            .Top       = 132
            .Left      = 285
            .Width     = 92
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Inclui IPI na Base ICMS (S=Sim, N=Nao)
        loc_oPag1.AddObject("cbo_4c_Combo4", "ComboBox")
        WITH loc_oPag1.cbo_4c_Combo4
            .Top           = 127
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label CFOP Destino
        loc_oPag1.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPag1.lbl_4c_Label19
            .Caption   = "CFOP Destino :"
            .Top       = 131
            .Left      = 805
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox CFOP Destino (lookup SigCdCfo)
        loc_oPag1.AddObject("txt_4c_Cfdest", "TextBox")
        WITH loc_oPag1.txt_4c_Cfdest
            .Top           = 127
            .Left          = 887
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Despesas Acessorias ICMS
        loc_oPag1.AddObject("chk_4c_ObjDespIcm", "CheckBox")
        WITH loc_oPag1.chk_4c_ObjDespIcm
            .Caption       = "Despesas Acess" + CHR(243) + "rias"
            .Top           = 132
            .Left          = 549
            .Width         = 118
            .Height        = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .AutoSize      = .T.
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Incluir ICMS no Total NF
        loc_oPag1.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
        WITH loc_oPag1.chk_4c_Fwcheckbox1
            .Caption       = "Incluir ICMS no Total da N.F."
            .Top           = 147
            .Left          = 549
            .Width         = 156
            .Height        = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .AutoSize      = .T.
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH

        *-- Label Substituicao Tributaria
        loc_oPag1.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPag1.lbl_4c_Label10
            .Caption   = "Substitui" + CHR(231) + CHR(227) + "o Tribut.:"
            .Top       = 157
            .Left      = 34
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Substituicao Tributaria (S=Sim, N=Nao)
        loc_oPag1.AddObject("cbo_4c_CmbSTRIB", "ComboBox")
        WITH loc_oPag1.cbo_4c_CmbSTRIB
            .Top           = 153
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Base Substituicao
        loc_oPag1.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPag1.lbl_4c_Label12
            .Caption   = "Base Substitui" + CHR(231) + CHR(227) + "o :"
            .Top       = 157
            .Left      = 284
            .Width     = 93
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Base Calculo ST (% pbcsts)
        loc_oPag1.AddObject("txt_4c_Bcst", "TextBox")
        WITH loc_oPag1.txt_4c_Bcst
            .Top           = 153
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label CFOP Transporte
        loc_oPag1.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oPag1.lbl_4c_Label28
            .Caption   = "CFOP Transporte :"
            .Top       = 157
            .Left      = 788
            .Width     = 92
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo CFOP Transporte (1=Sim, 2=Nao)
        loc_oPag1.AddObject("cbo_4c_Combo5", "ComboBox")
        WITH loc_oPag1.cbo_4c_Combo5
            .Top           = 153
            .Left          = 887
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Soma ICMS Frete no Total NF (Visible=.F. por padrao)
        loc_oPag1.AddObject("chk_4c_Fwcheckbox2", "CheckBox")
        WITH loc_oPag1.chk_4c_Fwcheckbox2
            .Caption       = "Soma ICMS frete no Total da N.F."
            .Top           = 163
            .Left          = 549
            .Width         = 180
            .Height        = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .AutoSize      = .T.
            .Alignment     = 0
            .Visible       = .F.
        ENDWITH

        *-- Label Situacao Tributaria ICMS
        loc_oPag1.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oPag1.lbl_4c_Label22
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut.:"
            .Top       = 183
            .Left      = 51
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Situacao Tributaria ICMS (lookup SigCdIcm)
        loc_oPag1.AddObject("txt_4c_Sittricm", "TextBox")
        WITH loc_oPag1.txt_4c_Sittricm
            .Top           = 179
            .Left          = 136
            .Width         = 31
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label ICMS Incluso no Preco
        loc_oPag1.AddObject("lbl_4c_Label36", "Label")
        WITH loc_oPag1.lbl_4c_Label36
            .Caption   = "ICMS Incluso no Pre" + CHR(231) + "o:"
            .Top       = 182
            .Left      = 264
            .Width     = 113
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo ICMS Incluso no Preco (1=Sim, 2=Nao)
        loc_oPag1.AddObject("cbo_4c_Combo10", "ComboBox")
        WITH loc_oPag1.cbo_4c_Combo10
            .Top           = 178
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Contribuinte
        loc_oPag1.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPag1.lbl_4c_Label6
            .Caption   = "Contribuinte :"
            .Top       = 183
            .Left      = 812
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Contribuinte (S=Sim, N=Nao, O=Outros)
        loc_oPag1.AddObject("cbo_4c_CmbContribuinte", "ComboBox")
        WITH loc_oPag1.cbo_4c_CmbContribuinte
            .Top           = 179
            .Left          = 887
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim;N" + CHR(227) + "o;Outros"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Venda Consumidor
        loc_oPag1.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oPag1.lbl_4c_Label23
            .Caption   = "Venda Consumidor :"
            .Top       = 207
            .Left      = 35
            .Width     = 98
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Aliquota Venda Consumidor
        loc_oPag1.AddObject("txt_4c_AliqIVCs", "TextBox")
        WITH loc_oPag1.txt_4c_AliqIVCs
            .Top           = 203
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label % (Venda Consumidor)
        loc_oPag1.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPag1.lbl_4c_Label13
            .Caption   = "%"
            .Top       = 207
            .Left      = 219
            .Width     = 13
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label Mot Desoneracao ICMS
        loc_oPag1.AddObject("lbl_4c_Label50", "Label")
        WITH loc_oPag1.lbl_4c_Label50
            .Caption   = "Mot Desonera" + CHR(231) + CHR(227) + "o ICMS :"
            .Top       = 206
            .Left      = 256
            .Width     = 121
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Motivo Desoneracao ICMS (2 chars numericos)
        loc_oPag1.AddObject("txt_4c_MotDeson", "TextBox")
        WITH loc_oPag1.txt_4c_MotDeson
            .Top           = 203
            .Left          = 381
            .Width         = 26
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99"
            .MaxLength     = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Inibe Valor Unitario
        loc_oPag1.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPag1.lbl_4c_Label21
            .Caption   = "Inibe Valor Unit" + CHR(225) + "rio na NF Importa" + CHR(231) + CHR(227) + "o :"
            .Top       = 210
            .Left      = 652
            .Width     = 228
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Inibe Valor Unitario NF Importacao (S=Sim, N=Nao)
        loc_oPag1.AddObject("cbo_4c_Combo9", "ComboBox")
        WITH loc_oPag1.cbo_4c_Combo9
            .Top           = 206
            .Left          = 887
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- BINDEVENT para lookup fields (LostFocus abre FormBuscaAuxiliar)
        BINDEVENT(loc_oPag1.txt_4c_CfoST60,  "KeyPress", THIS, "ValidarCfoST60")
        BINDEVENT(loc_oPag1.txt_4c_CfoST,    "KeyPress", THIS, "ValidarCfoST")
        BINDEVENT(loc_oPag1.txt_4c_Cfdest,   "KeyPress", THIS, "ValidarCfdest")
        BINDEVENT(loc_oPag1.txt_4c_Sittricm, "KeyPress", THIS, "ValidarSittricm")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDadosParte2 - Page1 do PagDados: segunda metade (top >= 236)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDadosParte2()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1

        *-- Linha separadora shp03 (top=236)
        loc_oPag1.AddObject("shp_4c_Shp03", "Shape")
        WITH loc_oPag1.shp_4c_Shp03
            .Top         = 236
            .Left        = 3
            .Width       = 984
            .Height      = 1
            .BackStyle   = 1
            .BackColor   = RGB(180, 180, 180)
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        *-- Label "Especificacoes Para NF-e" (bold Verdana, top=246)
        loc_oPag1.AddObject("lbl_4c_Label38", "Label")
        WITH loc_oPag1.lbl_4c_Label38
            .Caption   = "Especifica" + CHR(231) + CHR(245) + "es Para NF-e"
            .Top       = 246
            .Left      = 498
            .Width     = 167
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grupo IPI (lado esquerdo, top >= 263)
        *----------------------------------------------------------------------

        *-- Label IPI
        loc_oPag1.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPag1.lbl_4c_Label8
            .Caption   = "I P I :"
            .Top       = 267
            .Left      = 104
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo IPI (T=Tributado, I=Isento, O=Outros)
        loc_oPag1.AddObject("cbo_4c_CmbIpi", "ComboBox")
        WITH loc_oPag1.cbo_4c_CmbIpi
            .Top           = 263
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Tributado;Isento;Outros"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label IPI Importacao
        loc_oPag1.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPag1.lbl_4c_Label7
            .Caption   = "IPI Importa" + CHR(231) + CHR(227) + "o :"
            .Top       = 267
            .Left      = 296
            .Width     = 81
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo IPI Importacao - Retira IPI do $ (ipiimpors: S=Sim/N=Nao)
        loc_oPag1.AddObject("cbo_4c_CmbIpiI", "ComboBox")
        WITH loc_oPag1.cbo_4c_CmbIpiI
            .Top           = 263
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim;N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Destaca ICMS na NF (S/N)
        loc_oPag1.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oPag1.lbl_4c_Label27
            .Caption   = "Destaca ICMS na Nota Fiscal (S/N) :"
            .Top       = 270
            .Left      = 769
            .Width     = 174
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Destaca ICMS na NF (cgergia1s, 1 char S/N)
        loc_oPag1.AddObject("txt_4c_Gergia1", "TextBox")
        WITH loc_oPag1.txt_4c_Gergia1
            .Top           = 265
            .Left          = 948
            .Width         = 20
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Aliquota IPI
        loc_oPag1.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPag1.lbl_4c_Label15
            .Caption   = "Al" + CHR(237) + "quota :"
            .Top       = 293
            .Left      = 85
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Aliquota IPI (aliqipis, 99.99)
        loc_oPag1.AddObject("txt_4c_Aliqs", "TextBox")
        WITH loc_oPag1.txt_4c_Aliqs
            .Top           = 289
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Retira IPI do $
        loc_oPag1.AddObject("lbl_4c_Label32", "Label")
        WITH loc_oPag1.lbl_4c_Label32
            .Caption   = "Retira IPI do $ :"
            .Top       = 293
            .Left      = 298
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Inclui IPI na Base (inclipis, Sim/Nao -> numeric ListIndex)
        loc_oPag1.AddObject("cbo_4c_Combo7", "ComboBox")
        WITH loc_oPag1.cbo_4c_Combo7
            .Top           = 289
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim;N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Nao Creditado
        loc_oPag1.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPag1.lbl_4c_Label20
            .Caption   = "N" + CHR(227) + "o Creditado :"
            .Top       = 319
            .Left      = 55
            .Width     = 78
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Nao Creditado (ipincreds, Sim/Nao -> numeric ListIndex)
        loc_oPag1.AddObject("cbo_4c_Combo1", "ComboBox")
        WITH loc_oPag1.cbo_4c_Combo1
            .Top           = 315
            .Left          = 136
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim;N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Acres/Desc na Base
        loc_oPag1.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPag1.lbl_4c_Label17
            .Caption   = "Acres/Desc na Base :"
            .Top       = 319
            .Left      = 273
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Acres/Desc na Base (acresipis, S=Sim/N=Nao -> char)
        loc_oPag1.AddObject("cbo_4c_Combo2", "ComboBox")
        WITH loc_oPag1.cbo_4c_Combo2
            .Top           = 315
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim;N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Base de Calculo IPI
        loc_oPag1.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag1.lbl_4c_Label5
            .Caption   = "Base de C" + CHR(225) + "lculo :"
            .Top       = 345
            .Left      = 49
            .Width     = 84
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Base Calculo IPI (bcipis -> F/P/B/V/G/M)
        loc_oPag1.AddObject("cbo_4c_CmbBIPI", "ComboBox")
        WITH loc_oPag1.cbo_4c_CmbBIPI
            .Top           = 341
            .Left          = 136
            .Width         = 196
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Fator Markup;Preco Venda;Base C.M" + CHR(233) + "dio;Valor Merc.;Grupo Prod;Movimenta" + CHR(231) + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- TextBox % Base Calculo IPI (pbcipis, 999.99)
        loc_oPag1.AddObject("txt_4c_BcIPI", "TextBox")
        WITH loc_oPag1.txt_4c_BcIPI
            .Top           = 341
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Calcula IPI Importacao Origem Mercadoria=2
        loc_oPag1.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPag1.lbl_4c_Label18
            .Caption   = "Calcula IPI Importa" + CHR(231) + CHR(227) + "o Para Origem Mercadoria=2 :"
            .Top       = 371
            .Left      = 77
            .Width     = 250
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Calcula IPI Importacao Origem=2 (ipiom2s, S/N -> char)
        *-- Habilitado apenas se cmbIpiI = Sim
        loc_oPag1.AddObject("cbo_4c_Combo8", "ComboBox")
        WITH loc_oPag1.cbo_4c_Combo8
            .Top           = 367
            .Left          = 380
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim;N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label IPI Sobre
        loc_oPag1.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPag1.lbl_4c_Label16
            .Caption   = "IPI Sobre :"
            .Top       = 395
            .Left      = 69
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- CheckBox Frete IPI
        loc_oPag1.AddObject("chk_4c_ObjFreteIPI", "CheckBox")
        WITH loc_oPag1.chk_4c_ObjFreteIPI
            .Caption       = "Frete"
            .Top           = 395
            .Left          = 137
            .Width         = 44
            .Height        = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .AutoSize      = .T.
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Seguro IPI
        loc_oPag1.AddObject("chk_4c_ObjSegIPI", "CheckBox")
        WITH loc_oPag1.chk_4c_ObjSegIPI
            .Caption       = "Seguro"
            .Top           = 395
            .Left          = 188
            .Width         = 52
            .Height        = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .AutoSize      = .T.
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Despesas Acessorias IPI
        loc_oPag1.AddObject("chk_4c_ObjDespIPI", "CheckBox")
        WITH loc_oPag1.chk_4c_ObjDespIPI
            .Caption       = "Despesas Acess" + CHR(243) + "rias"
            .Top           = 395
            .Left          = 255
            .Width         = 118
            .Height        = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .AutoSize      = .T.
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grupo NF-e Especificacoes (lado direito, top >= 266)
        *----------------------------------------------------------------------

        *-- Label Codigo IPI Sit. Tributaria
        loc_oPag1.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oPag1.lbl_4c_Label30
            .Caption   = "C" + CHR(243) + "digo IPI Sit. Trib.:"
            .Top       = 269
            .Left      = 589
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo IPI Sit. Tributaria (ipicst, 2 chars)
        loc_oPag1.AddObject("txt_4c_IPICST", "TextBox")
        WITH loc_oPag1.txt_4c_IPICST
            .Top           = 266
            .Left          = 691
            .Width         = 26
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99"
            .MaxLength     = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Codigo PIS Sit. Tributaria
        loc_oPag1.AddObject("lbl_4c_Label33", "Label")
        WITH loc_oPag1.lbl_4c_Label33
            .Caption   = "C" + CHR(243) + "digo PIS Sit. Trib.:"
            .Top       = 295
            .Left      = 587
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo PIS Sit. Tributaria (piscst, 2 chars)
        loc_oPag1.AddObject("txt_4c_PISCST", "TextBox")
        WITH loc_oPag1.txt_4c_PISCST
            .Top           = 291
            .Left          = 691
            .Width         = 26
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99"
            .MaxLength     = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Codigo COFINS Sit. Tributaria
        loc_oPag1.AddObject("lbl_4c_Label34", "Label")
        WITH loc_oPag1.lbl_4c_Label34
            .Caption   = "C" + CHR(243) + "digo COFINS Sit. Trib.:"
            .Top       = 319
            .Left      = 565
            .Width     = 124
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo COFINS Sit. Tributaria (cofcst, 2 chars)
        loc_oPag1.AddObject("txt_4c_COFCST", "TextBox")
        WITH loc_oPag1.txt_4c_COFCST
            .Top           = 315
            .Left          = 691
            .Width         = 26
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99"
            .MaxLength     = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Codigo ISSQN Lista Servicos
        loc_oPag1.AddObject("lbl_4c_Label35", "Label")
        WITH loc_oPag1.lbl_4c_Label35
            .Caption   = "C" + CHR(243) + "digo ISSQN Lista Serv.:"
            .Top       = 343
            .Left      = 562
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo ISSQN Lista Servicos (issqnl, 5 chars)
        loc_oPag1.AddObject("txt_4c_ISSQNL", "TextBox")
        WITH loc_oPag1.txt_4c_ISSQNL
            .Top           = 339
            .Left          = 691
            .Width         = 42
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "XXXXX"
            .MaxLength     = 5
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Codigo Enquadramento IPI
        loc_oPag1.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPag1.lbl_4c_Label9
            .Caption   = "C" + CHR(243) + "digo Enquadramento IPI:"
            .Top       = 366
            .Left      = 554
            .Width     = 135
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Enquadramento IPI (ipienq, 3 chars)
        loc_oPag1.AddObject("txt_4c_IPIEnq", "TextBox")
        WITH loc_oPag1.txt_4c_IPIEnq
            .Top           = 363
            .Left          = 691
            .Width         = 26
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Aliquota do PIS
        loc_oPag1.AddObject("lbl_4c_Label39", "Label")
        WITH loc_oPag1.lbl_4c_Label39
            .Caption   = "Al" + CHR(237) + "quota do PIS :"
            .Top       = 295
            .Left      = 827
            .Width     = 82
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Aliquota do PIS (aliqpis, 999.99)
        loc_oPag1.AddObject("txt_4c_AliqPIS", "TextBox")
        WITH loc_oPag1.txt_4c_AliqPIS
            .Top           = 291
            .Left          = 916
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label % (PIS)
        loc_oPag1.AddObject("lbl_4c_Label40", "Label")
        WITH loc_oPag1.lbl_4c_Label40
            .Caption   = "%"
            .Top       = 295
            .Left      = 971
            .Width     = 14
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(224, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Label Aliquota do COFINS
        loc_oPag1.AddObject("lbl_4c_Label41", "Label")
        WITH loc_oPag1.lbl_4c_Label41
            .Caption   = "Al" + CHR(237) + "quota do COFINS :"
            .Top       = 319
            .Left      = 785
            .Width     = 124
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Aliquota do COFINS (aliqcofins, 999.99)
        loc_oPag1.AddObject("txt_4c_AliqCofins", "TextBox")
        WITH loc_oPag1.txt_4c_AliqCofins
            .Top           = 315
            .Left          = 916
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label % (COFINS)
        loc_oPag1.AddObject("lbl_4c_Label42", "Label")
        WITH loc_oPag1.lbl_4c_Label42
            .Caption   = "%"
            .Top       = 319
            .Left      = 971
            .Width     = 14
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(224, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Label Aliquota do ISSQN
        loc_oPag1.AddObject("lbl_4c_Label44", "Label")
        WITH loc_oPag1.lbl_4c_Label44
            .Caption   = "Al" + CHR(237) + "quota do ISSQN :"
            .Top       = 343
            .Left      = 792
            .Width     = 117
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Aliquota do ISSQN (aliqissqn, 999.99)
        loc_oPag1.AddObject("txt_4c_AliqISSQN", "TextBox")
        WITH loc_oPag1.txt_4c_AliqISSQN
            .Top           = 339
            .Left          = 916
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label % (ISSQN)
        loc_oPag1.AddObject("lbl_4c_Label45", "Label")
        WITH loc_oPag1.lbl_4c_Label45
            .Caption   = "%"
            .Top       = 343
            .Left      = 971
            .Width     = 14
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(224, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Label Codigo de Tributacao do ISSQN
        loc_oPag1.AddObject("lbl_4c_Label43", "Label")
        WITH loc_oPag1.lbl_4c_Label43
            .Caption   = "C" + CHR(243) + "digo de Trib. do ISSQN:"
            .Top       = 390
            .Left      = 561
            .Width     = 128
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Codigo Tributacao ISSQN (ctissqn, 5 botoes: Normal/Retida/Substituta/Isenta/Nao Calcula)
        loc_oPag1.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH loc_oPag1.obj_4c_Fwoption1
            .Top         = 389
            .Left        = 686
            .Width       = 297
            .Height      = 34
            .ButtonCount = 5
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag1.obj_4c_Fwoption1.Buttons(1)
            .Caption   = "Normal"
            .BackStyle = 0
            .Left      = 4
            .Top       = 0
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPag1.obj_4c_Fwoption1.Buttons(2)
            .Caption   = "Retida"
            .BackStyle = 0
            .Left      = 72
            .Top       = 0
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPag1.obj_4c_Fwoption1.Buttons(3)
            .Caption   = "Substituta"
            .BackStyle = 0
            .Left      = 135
            .Top       = 1
            .Width     = 76
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPag1.obj_4c_Fwoption1.Buttons(4)
            .Caption   = "Isenta"
            .BackStyle = 0
            .Left      = 219
            .Top       = 1
            .Width     = 52
            .Height    = 17
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPag1.obj_4c_Fwoption1.Buttons(5)
            .Caption   = "N" + CHR(227) + "o Calcula ISSQN"
            .BackStyle = 0
            .Left      = 4
            .Top       = 17
            .Width     = 129
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label Informa Retencao de Tributacao
        loc_oPag1.AddObject("lbl_4c_Label46", "Label")
        WITH loc_oPag1.lbl_4c_Label46
            .Caption   = "Informa Reten" + CHR(231) + CHR(227) + "o de Trib.:"
            .Top       = 425
            .Left      = 556
            .Width     = 133
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Informa Retencao de Tributacao (rettribs, 2 botoes: Sim/Nao)
        loc_oPag1.AddObject("obj_4c_Fwoption2", "OptionGroup")
        WITH loc_oPag1.obj_4c_Fwoption2
            .Top         = 420
            .Left        = 686
            .Width       = 95
            .Height      = 25
            .ButtonCount = 2
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag1.obj_4c_Fwoption2.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPag1.obj_4c_Fwoption2.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 53
            .Top       = 5
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label Aliquota do II
        loc_oPag1.AddObject("lbl_4c_Label47", "Label")
        WITH loc_oPag1.lbl_4c_Label47
            .Caption   = "Al" + CHR(237) + "quota do II :"
            .Top       = 425
            .Left      = 820
            .Width     = 89
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Aliquota do II (aliqii, 999.99)
        loc_oPag1.AddObject("txt_4c_AliqII", "TextBox")
        WITH loc_oPag1.txt_4c_AliqII
            .Top           = 421
            .Left          = 916
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label % (II)
        loc_oPag1.AddObject("lbl_4c_Label48", "Label")
        WITH loc_oPag1.lbl_4c_Label48
            .Caption   = "%"
            .Top       = 420
            .Left      = 971
            .Width     = 14
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(224, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT: cmbIpiI.InteractiveChange -> habilita/desabilita Combo8
        BINDEVENT(loc_oPag1.cbo_4c_CmbIpiI, "InteractiveChange", THIS, "AtualizarCombo8")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDadosPage2 - Page2 do PagDados: Integracao Contabil/Fiscal
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDadosPage2()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

        *----------------------------------------------------------------------
        *-- Secao: Integracao Contabil (esquerda)
        *----------------------------------------------------------------------

        *-- Label cabecalho secao Integracao Contabil
        loc_oPag2.AddObject("lbl_4c_LblIntCont", "Label")
        WITH loc_oPag2.lbl_4c_LblIntCont
            .Caption   = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
            .Top       = 6
            .Left      = 15
            .Width     = 114
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label Valor Contabil
        loc_oPag2.AddObject("lbl_4c_LblValorCont", "Label")
        WITH loc_oPag2.lbl_4c_LblValorCont
            .Caption   = "Valor Cont" + CHR(225) + "bil :"
            .Top       = 34
            .Left      = 84
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label DB (Valor Contabil)
        loc_oPag2.AddObject("lbl_4c_LblVcDB", "Label")
        WITH loc_oPag2.lbl_4c_LblVcDB
            .Caption   = "DB"
            .Top       = 34
            .Left      = 247
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label CR (Valor Contabil)
        loc_oPag2.AddObject("lbl_4c_LblVcCR", "Label")
        WITH loc_oPag2.lbl_4c_LblVcCR
            .Caption   = "CR"
            .Top       = 34
            .Left      = 344
            .Width     = 16
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Valor Contabil DB (contvcds)
        loc_oPag2.AddObject("txt_4c_Vrcds", "TextBox")
        WITH loc_oPag2.txt_4c_Vrcds
            .Top           = 30
            .Left          = 162
            .Width         = 73
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 9
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- TextBox Valor Contabil CR (contvccs)
        loc_oPag2.AddObject("txt_4c_Vrccs", "TextBox")
        WITH loc_oPag2.txt_4c_Vrccs
            .Top           = 30
            .Left          = 265
            .Width         = 73
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 9
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label IPI
        loc_oPag2.AddObject("lbl_4c_LblIPI", "Label")
        WITH loc_oPag2.lbl_4c_LblIPI
            .Caption   = "IPI :"
            .Top       = 60
            .Left      = 136
            .Width     = 23
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label DB (IPI)
        loc_oPag2.AddObject("lbl_4c_LblIpiDB", "Label")
        WITH loc_oPag2.lbl_4c_LblIpiDB
            .Caption   = "DB"
            .Top       = 60
            .Left      = 247
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label CR (IPI)
        loc_oPag2.AddObject("lbl_4c_LblIpiCR", "Label")
        WITH loc_oPag2.lbl_4c_LblIpiCR
            .Caption   = "CR"
            .Top       = 60
            .Left      = 344
            .Width     = 16
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox IPI DB (contipds)
        loc_oPag2.AddObject("txt_4c_Ipids", "TextBox")
        WITH loc_oPag2.txt_4c_Ipids
            .Top           = 56
            .Left          = 162
            .Width         = 73
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 9
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- TextBox IPI CR (contipcs)
        loc_oPag2.AddObject("txt_4c_Ipics", "TextBox")
        WITH loc_oPag2.txt_4c_Ipics
            .Top           = 56
            .Left          = 265
            .Width         = 73
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 9
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label ICMS
        loc_oPag2.AddObject("lbl_4c_LblICMS", "Label")
        WITH loc_oPag2.lbl_4c_LblICMS
            .Caption   = "ICMS :"
            .Top       = 86
            .Left      = 125
            .Width     = 34
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label DB (ICMS)
        loc_oPag2.AddObject("lbl_4c_LblIcmDB", "Label")
        WITH loc_oPag2.lbl_4c_LblIcmDB
            .Caption   = "DB"
            .Top       = 86
            .Left      = 247
            .Width     = 15
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label CR (ICMS)
        loc_oPag2.AddObject("lbl_4c_LblIcmCR", "Label")
        WITH loc_oPag2.lbl_4c_LblIcmCR
            .Caption   = "CR"
            .Top       = 86
            .Left      = 344
            .Width     = 16
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox ICMS DB (conticds)
        loc_oPag2.AddObject("txt_4c_Icmds", "TextBox")
        WITH loc_oPag2.txt_4c_Icmds
            .Top           = 82
            .Left          = 162
            .Width         = 73
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 9
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- TextBox ICMS CR (conticcs)
        loc_oPag2.AddObject("txt_4c_Icmcs", "TextBox")
        WITH loc_oPag2.txt_4c_Icmcs
            .Top           = 82
            .Left          = 265
            .Width         = 73
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 9
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Conta de Frete
        loc_oPag2.AddObject("lbl_4c_LblContFrt", "Label")
        WITH loc_oPag2.lbl_4c_LblContFrt
            .Caption   = "Conta de Frete :"
            .Top       = 112
            .Left      = 77
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Conta de Frete (contfrt)
        loc_oPag2.AddObject("txt_4c_ContFrt", "TextBox")
        WITH loc_oPag2.txt_4c_ContFrt
            .Top           = 108
            .Left          = 162
            .Width         = 73
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 9
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Conta de Seguro
        loc_oPag2.AddObject("lbl_4c_LblContSeg", "Label")
        WITH loc_oPag2.lbl_4c_LblContSeg
            .Caption   = "Conta de Seguro :"
            .Top       = 138
            .Left      = 69
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Conta de Seguro (contseg)
        loc_oPag2.AddObject("txt_4c_ContSeg", "TextBox")
        WITH loc_oPag2.txt_4c_ContSeg
            .Top           = 134
            .Left          = 162
            .Width         = 73
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 9
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Conta de Despesas
        loc_oPag2.AddObject("lbl_4c_LblContDa", "Label")
        WITH loc_oPag2.lbl_4c_LblContDa
            .Caption   = "Conta de Despesas :"
            .Top       = 164
            .Left      = 57
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Conta de Despesas (contda)
        loc_oPag2.AddObject("txt_4c_ContDa", "TextBox")
        WITH loc_oPag2.txt_4c_ContDa
            .Top           = 160
            .Left          = 162
            .Width         = 73
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 9
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Secao: Opcoes de Integracao (direita)
        *----------------------------------------------------------------------

        *-- Label Descricao na Integracao
        loc_oPag2.AddObject("lbl_4c_LblDescInteg", "Label")
        WITH loc_oPag2.lbl_4c_LblDescInteg
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o na Integra" + CHR(231) + CHR(227) + "o :"
            .Top       = 31
            .Left      = 490
            .Width     = 151
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Descricao na Integracao (pontedescs)
        loc_oPag2.AddObject("cbo_4c_Combo2", "ComboBox")
        WITH loc_oPag2.cbo_4c_Combo2
            .Top           = 27
            .Left          = 642
            .Width         = 199
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim-Descri" + CHR(231) + CHR(227) + "o CFOP,N" + CHR(227) + "o-Nenhuma,Sim-Obs. Opera" + CHR(231) + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Pega Conta Contabil da NF
        loc_oPag2.AddObject("lbl_4c_LblCmbFixa", "Label")
        WITH loc_oPag2.lbl_4c_LblCmbFixa
            .Caption   = "Pega Conta Cont" + CHR(225) + "bil da NF :"
            .Top       = 57
            .Left      = 642
            .Width     = 164
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Combo Pega Conta Contabil da NF (contconts: S=Sim(NF), N=Nao(CFOP), C=C.C.)
        loc_oPag2.AddObject("cbo_4c_CmbFixa", "ComboBox")
        WITH loc_oPag2.cbo_4c_CmbFixa
            .Top           = 53
            .Left          = 642
            .Width         = 132
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Sim (NF),N" + CHR(227) + "o (CFOP),C.C."
            .Style         = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label Agrupa CFO na Integracao
        loc_oPag2.AddObject("lbl_4c_LblAgrupas", "Label")
        WITH loc_oPag2.lbl_4c_LblAgrupas
            .Caption   = "Agrupa CFO na Integra" + CHR(231) + CHR(227) + "o :"
            .Top       = 84
            .Left      = 477
            .Width     = 164
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Agrupa CFO (agrupas: 1=Sim, 2=Nao)
        loc_oPag2.AddObject("obj_4c_OptAgrupas", "OptionGroup")
        WITH loc_oPag2.obj_4c_OptAgrupas
            .ButtonCount = 2
            .Top         = 79
            .Left        = 638
            .Width       = 101
            .Height      = 27
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag2.obj_4c_OptAgrupas.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag2.obj_4c_OptAgrupas.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Integracao Zerada
        loc_oPag2.AddObject("lbl_4c_LblZeradas", "Label")
        WITH loc_oPag2.lbl_4c_LblZeradas
            .Caption   = "Integra" + CHR(231) + CHR(227) + "o Zerada :"
            .Top       = 108
            .Left      = 523
            .Width     = 118
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Integracao Zerada (zeradas: 1=Sim, 2=Nao)
        loc_oPag2.AddObject("obj_4c_OptZeradas", "OptionGroup")
        WITH loc_oPag2.obj_4c_OptZeradas
            .ButtonCount = 2
            .Top         = 103
            .Left        = 638
            .Width       = 101
            .Height      = 27
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag2.obj_4c_OptZeradas.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag2.obj_4c_OptZeradas.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Data Lancamento Contabil
        loc_oPag2.AddObject("lbl_4c_LblDtLanc", "Label")
        WITH loc_oPag2.lbl_4c_LblDtLanc
            .Caption   = "Data Lan" + CHR(231) + "amento Contabil :"
            .Top       = 132
            .Left      = 479
            .Width     = 162
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Data Lancamento Contabil (dtintfis: 1=Data Integracao, 2=Data N.F.)
        loc_oPag2.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH loc_oPag2.obj_4c_Fwoption1
            .ButtonCount = 2
            .Top         = 127
            .Left        = 638
            .Width       = 281
            .Height      = 27
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption1.Buttons(1)
            .Caption   = "Data Integra" + CHR(231) + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 97
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption1.Buttons(2)
            .Caption   = "Data N.F."
            .BackStyle = 0
            .Left      = 122
            .Top       = 7
            .Width     = 65
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Utilizar variacao de CFOP na Integracao
        loc_oPag2.AddObject("lbl_4c_LblUtilvars", "Label")
        WITH loc_oPag2.lbl_4c_LblUtilvars
            .Caption   = "Utilizar a varia" + CHR(231) + CHR(227) + "o de CFOP na Integra" + CHR(231) + CHR(227) + "o :"
            .Top       = 156
            .Left      = 390
            .Width     = 251
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Utilizar variacao CFOP (utilvars: 1=Sim, 2=Nao)
        loc_oPag2.AddObject("obj_4c_Optutilvars", "OptionGroup")
        WITH loc_oPag2.obj_4c_Optutilvars
            .ButtonCount = 2
            .Top         = 150
            .Left        = 638
            .Width       = 101
            .Height      = 27
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag2.obj_4c_Optutilvars.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag2.obj_4c_Optutilvars.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Separador e secao Integracao Fiscal
        *----------------------------------------------------------------------

        *-- Linha separadora horizontal
        loc_oPag2.AddObject("shp_4c_Sep", "Shape")
        WITH loc_oPag2.shp_4c_Sep
            .Top           = 211
            .Left          = 5
            .Width         = 984
            .Height        = 1
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label cabecalho secao Integracao Fiscal
        loc_oPag2.AddObject("lbl_4c_LblIntFisc", "Label")
        WITH loc_oPag2.lbl_4c_LblIntFisc
            .Caption   = "Integra" + CHR(231) + CHR(227) + "o Fiscal"
            .Top       = 217
            .Left      = 18
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label Integrar Valor Contabil
        loc_oPag2.AddObject("lbl_4c_LblIntvlrcont", "Label")
        WITH loc_oPag2.lbl_4c_LblIntvlrcont
            .Caption   = "Integrar Valor Cont" + CHR(225) + "bil :"
            .Top       = 239
            .Left      = 115
            .Width     = 118
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Integrar Valor Contabil (intvlrcont: 1=Sim, 2=Nao)
        loc_oPag2.AddObject("obj_4c_Fwoption2", "OptionGroup")
        WITH loc_oPag2.obj_4c_Fwoption2
            .ButtonCount = 2
            .Top         = 233
            .Left        = 231
            .Width       = 101
            .Height      = 27
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption2.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption2.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Integrar Valores Icms
        loc_oPag2.AddObject("lbl_4c_LblIntvlricms", "Label")
        WITH loc_oPag2.lbl_4c_LblIntvlricms
            .Caption   = "Integrar Valores Icms :"
            .Top       = 259
            .Left      = 121
            .Width     = 112
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Integrar Valores Icms (intvlricms: 1=Sim, 2=Nao)
        loc_oPag2.AddObject("obj_4c_Fwoption3", "OptionGroup")
        WITH loc_oPag2.obj_4c_Fwoption3
            .ButtonCount = 2
            .Top         = 253
            .Left        = 231
            .Width       = 101
            .Height      = 27
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption3.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption3.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Integrar Valores Ipi
        loc_oPag2.AddObject("lbl_4c_LblIntvlripi", "Label")
        WITH loc_oPag2.lbl_4c_LblIntvlripi
            .Caption   = "Integrar Valores Ipi :"
            .Top       = 278
            .Left      = 131
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Integrar Valores Ipi (intvlripi: 1=Sim, 2=Nao)
        loc_oPag2.AddObject("obj_4c_Fwoption4", "OptionGroup")
        WITH loc_oPag2.obj_4c_Fwoption4
            .ButtonCount = 2
            .Top         = 272
            .Left        = 231
            .Width       = 101
            .Height      = 27
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption4.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption4.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Movimentacao Fisica de Estoque
        loc_oPag2.AddObject("lbl_4c_LblIndmov", "Label")
        WITH loc_oPag2.lbl_4c_LblIndmov
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque :"
            .Top       = 298
            .Left      = 69
            .Width     = 164
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Movimentacao Fisica de Estoque (indmov: 1=Sim, 2=Nao)
        loc_oPag2.AddObject("obj_4c_Fwoption5", "OptionGroup")
        WITH loc_oPag2.obj_4c_Fwoption5
            .ButtonCount = 2
            .Top         = 292
            .Left        = 231
            .Width       = 101
            .Height      = 27
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption5.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption5.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Indicacao de Pagamento
        loc_oPag2.AddObject("lbl_4c_LblIndpagto", "Label")
        WITH loc_oPag2.lbl_4c_LblIndpagto
            .Caption   = "Indica" + CHR(231) + CHR(227) + "o de Pagamento :"
            .Top       = 318
            .Left      = 106
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Indicacao de Pagamento (indpagto: 1=Sim, 2=Nao)
        loc_oPag2.AddObject("obj_4c_Fwoption6", "OptionGroup")
        WITH loc_oPag2.obj_4c_Fwoption6
            .ButtonCount = 2
            .Top         = 312
            .Left        = 231
            .Width       = 101
            .Height      = 27
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption6.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPag2.obj_4c_Fwoption6.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- BINDEVENT para validacao de contas contabeis (LostFocus)
        BINDEVENT(loc_oPag2.txt_4c_ContFrt, "KeyPress", THIS, "ValidarContFrt")
        BINDEVENT(loc_oPag2.txt_4c_ContSeg, "KeyPress", THIS, "ValidarContSeg")
        BINDEVENT(loc_oPag2.txt_4c_ContDa,  "KeyPress", THIS, "ValidarContDa")
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCombo8 - Habilita/desabilita Combo8 conforme cmbIpiI (IPI Importacao)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarCombo8()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        TRY
            loc_oPag1.cbo_4c_Combo8.Enabled = ;
                (UPPER(LEFT(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_CmbIpiI.Value) = "C", loc_oPag1.cbo_4c_CmbIpiI.Value, "")), 1)) = "S")
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.AtualizarCombo8")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContFrt - Valida Conta de Frete contra SigCdCli (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContFrt(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag2, loc_cConta, loc_nRows
        IF gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
        loc_cConta = ""
        loc_nRows  = 0
        TRY
            loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContFrt.Value, ""))
            IF NOT EMPTY(loc_cConta)
                loc_nRows = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta), ;
                    "cursor_4c_ContFrt")
                IF loc_nRows > 0 AND RECCOUNT("cursor_4c_ContFrt") = 0
                    MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
                    loc_oPag2.txt_4c_ContFrt.SetFocus()
                ENDIF
                USE IN SELECT("cursor_4c_ContFrt")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.ValidarContFrt")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContSeg - Valida Conta de Seguro contra SigCdCli (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContSeg(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag2, loc_cConta, loc_nRows
        IF gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
        loc_cConta = ""
        loc_nRows  = 0
        TRY
            loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContSeg.Value, ""))
            IF NOT EMPTY(loc_cConta)
                loc_nRows = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta), ;
                    "cursor_4c_ContSeg")
                IF loc_nRows > 0 AND RECCOUNT("cursor_4c_ContSeg") = 0
                    MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
                    loc_oPag2.txt_4c_ContSeg.SetFocus()
                ENDIF
                USE IN SELECT("cursor_4c_ContSeg")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.ValidarContSeg")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContDa - Valida Conta de Despesas contra SigCdCli (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContDa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag2, loc_cConta, loc_nRows
        IF gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
        loc_cConta = ""
        loc_nRows  = 0
        TRY
            loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContDa.Value, ""))
            IF NOT EMPTY(loc_cConta)
                loc_nRows = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta), ;
                    "cursor_4c_ContDa")
                IF loc_nRows > 0 AND RECCOUNT("cursor_4c_ContDa") = 0
                    MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
                    loc_oPag2.txt_4c_ContDa.SetFocus()
                ENDIF
                USE IN SELECT("cursor_4c_ContDa")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.ValidarContDa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirma o registro (Incluir ou Alterar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPag1
        loc_lResultado = .F.
        loc_oPag1      = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1

        *-- Validacoes basicas ANTES do TRY
        IF EMPTY(ALLTRIM(loc_oPag1.txt_4c_Codigo.Value))
            MsgAviso("C" + CHR(243) + "digo em branco.", "Confirmar")
            loc_oPag1.txt_4c_Codigo.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPag1.txt_4c_Descricao.Value))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida.", "Confirmar")
            loc_oPag1.txt_4c_Descricao.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            loc_lResultado = THIS.this_oBusinessObject.Salvar()
            IF loc_lResultado
                MsgSucesso("Registro salvo com sucesso!")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_oBusinessObject.CancelarEdicao()
        CATCH TO loc_oErro
            *-- Ignora erro se CancelarEdicao nao existir no BO base
        ENDTRY
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCfoST60 - Lookup CFOP ST60 via FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCfoST60(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
        loc_oBusca  = .NULL.
        loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST60.Value, ""))

        *-- Guardia: nao revalidar se valor nao mudou desde a ultima validacao
        IF loc_cCodAtual == THIS.this_cUltimoValidarCfoST60Validado
            RETURN
        ENDIF

        IF EMPTY(loc_cCodAtual)
            THIS.this_cUltimoValidarCfoST60Validado = loc_cCodAtual
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfoST60", "codigos", ;
                loc_cCodAtual, ;
                "CFOP ST60")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfoST60")
                    SELECT cursor_4c_BuscaCfoST60
                    loc_oPag1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.codigos)
                ENDIF
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.ValidarCfoST60")
        ENDTRY

        THIS.this_cUltimoValidarCfoST60Validado = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST60.Value, ""))

        IF USED("cursor_4c_BuscaCfoST60")
            USE IN cursor_4c_BuscaCfoST60
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCfoST - Lookup CFOP Subst.Trib. via FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCfoST(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
        loc_oBusca  = .NULL.
        loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST.Value, ""))

        *-- Guardia: nao revalidar se valor nao mudou desde a ultima validacao
        IF loc_cCodAtual == THIS.this_cUltimoValidarCfoSTValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cCodAtual)
            THIS.this_cUltimoValidarCfoSTValidado = loc_cCodAtual
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfoST", "codigos", ;
                loc_cCodAtual, ;
                "CFOP Subst.Trib.")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfoST")
                    SELECT cursor_4c_BuscaCfoST
                    loc_oPag1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.codigos)
                ENDIF
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.ValidarCfoST")
        ENDTRY

        THIS.this_cUltimoValidarCfoSTValidado = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST.Value, ""))

        IF USED("cursor_4c_BuscaCfoST")
            USE IN cursor_4c_BuscaCfoST
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCfdest - Lookup CFOP Destino via FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCfdest(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
        loc_oBusca  = .NULL.
        loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_Cfdest.Value, ""))

        *-- Guardia: nao revalidar se valor nao mudou desde a ultima validacao
        IF loc_cCodAtual == THIS.this_cUltimoValidarCfdestValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cCodAtual)
            THIS.this_cUltimoValidarCfdestValidado = loc_cCodAtual
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfdest", "codigos", ;
                loc_cCodAtual, ;
                "CFOP Destino")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfdest")
                    SELECT cursor_4c_BuscaCfdest
                    loc_oPag1.txt_4c_Cfdest.Value = ALLTRIM(cursor_4c_BuscaCfdest.codigos)
                ENDIF
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.ValidarCfdest")
        ENDTRY

        THIS.this_cUltimoValidarCfdestValidado = ALLTRIM(NVL(loc_oPag1.txt_4c_Cfdest.Value, ""))

        IF USED("cursor_4c_BuscaCfdest")
            USE IN cursor_4c_BuscaCfdest
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSittricm - Lookup Situacao Tributaria ICMS via FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSittricm(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_oPag1, loc_cCodAtual
        loc_oBusca  = .NULL.
        loc_oPag1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        loc_cCodAtual = ALLTRIM(NVL(loc_oPag1.txt_4c_Sittricm.Value, ""))

        *-- Guardia: nao revalidar se valor nao mudou desde a ultima validacao
        IF loc_cCodAtual == THIS.this_cUltimoValidarSittricmValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cCodAtual)
            THIS.this_cUltimoValidarSittricmValidado = loc_cCodAtual
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdIcm", "cursor_4c_BuscaIcm", "codigos", ;
                loc_cCodAtual, ;
                "Tributa" + CHR(231) + CHR(227) + "o ICMS")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
                    SELECT cursor_4c_BuscaIcm
                    loc_oPag1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.codigos)
                ENDIF
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.ValidarSittricm")
        ENDTRY

        THIS.this_cUltimoValidarSittricmValidado = ALLTRIM(NVL(loc_oPag1.txt_4c_Sittricm.Value, ""))

        IF USED("cursor_4c_BuscaIcm")
            USE IN cursor_4c_BuscaIcm
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores da tela para o Business Object (parte 1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag1, loc_oBO
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        loc_oBO   = THIS.this_oBusinessObject

        TRY
            *-- Dados principais
            loc_oBO.this_cCodigos    = ALLTRIM(NVL(loc_oPag1.txt_4c_Codigo.Value, ""))
            loc_oBO.this_cDescricaos = ALLTRIM(NVL(loc_oPag1.txt_4c_Descricao.Value, ""))
            loc_oBO.this_cDesc2s     = ALLTRIM(NVL(loc_oPag1.txt_4c_Desc2s.Value, ""))
            loc_oBO.this_nSituas     = IIF(loc_oPag1.obj_4c_Opc_situacao.Value = 1, 1, 0)
            loc_oBO.this_cOperacaos  = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_CmbOperacao.Value) = "C", loc_oPag1.cbo_4c_CmbOperacao.Value, ""))), 1)
            loc_oBO.this_nTipos      = IIF(VARTYPE(loc_oPag1.cbo_4c_Cmbtipo.Value) = "C", VAL(loc_oPag1.cbo_4c_Cmbtipo.Value), 0)
            loc_oBO.this_nNdigitos   = loc_oPag1.obj_4c_Ndigito.Value

            *-- ICMS
            loc_oBO.this_cIcms       = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_CmbIcms.Value) = "C", loc_oPag1.cbo_4c_CmbIcms.Value, ""))), 1)
            loc_oBO.this_nInclicms   = loc_oPag1.cbo_4c_Combo3.ListIndex
            loc_oBO.this_nIcmsdscs   = loc_oPag1.cbo_4c_Combo6.ListIndex
            loc_oBO.this_cCfost60s   = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST60.Value, ""))
            loc_oBO.this_cCfosts     = ALLTRIM(NVL(loc_oPag1.txt_4c_CfoST.Value, ""))
            loc_oBO.this_cCoddests   = ALLTRIM(NVL(loc_oPag1.txt_4c_Cfdest.Value, ""))
            loc_oBO.this_nFrticms    = IIF(loc_oPag1.chk_4c_ObjFreteICM.Value = 1, 1, 0)
            loc_oBO.this_nSegicms    = IIF(loc_oPag1.chk_4c_ObjSegIcm.Value = 1, 1, 0)
            loc_oBO.this_nDesicms    = IIF(loc_oPag1.chk_4c_ObjDespIcm.Value = 1, 1, 0)
            loc_oBO.this_nIncicmnfs  = IIF(loc_oPag1.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
            loc_oBO.this_nSomaicmfrete = IIF(loc_oPag1.chk_4c_Fwcheckbox2.Value = 1, 1, 0)
            loc_oBO.this_cSubtribs   = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_CmbSTRIB.Value) = "C", loc_oPag1.cbo_4c_CmbSTRIB.Value, ""))), 1)
            loc_oBO.this_nPbcsts     = VAL(NVL(loc_oPag1.txt_4c_Bcst.Value, "0"))
            loc_oBO.this_nTransps    = loc_oPag1.cbo_4c_Combo5.ListIndex
            loc_oBO.this_nIcmsincs   = loc_oPag1.cbo_4c_Combo10.ListIndex
            loc_oBO.this_cSittribs   = ALLTRIM(NVL(loc_oPag1.txt_4c_Sittricm.Value, ""))
            loc_oBO.this_cContribs   = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_CmbContribuinte.Value) = "C", loc_oPag1.cbo_4c_CmbContribuinte.Value, ""))), 1)
            loc_oBO.this_nAliqivcs   = VAL(NVL(loc_oPag1.txt_4c_AliqIVCs.Value, "0"))
            loc_oBO.this_cMotdeson   = ALLTRIM(NVL(loc_oPag1.txt_4c_MotDeson.Value, ""))
            loc_oBO.this_cUnitimps   = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_Combo9.Value) = "C", loc_oPag1.cbo_4c_Combo9.Value, ""))), 1)
            loc_oBO.this_cIpiIcms    = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_Combo4.Value) = "C", loc_oPag1.cbo_4c_Combo4.Value, ""))), 1)

            *-- IPI (Parte 2)
            loc_oBO.this_cIpis       = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_CmbIpi.Value) = "C", loc_oPag1.cbo_4c_CmbIpi.Value, ""))), 1)
            loc_oBO.this_nAliqipis   = VAL(NVL(loc_oPag1.txt_4c_Aliqs.Value, "0"))
            loc_oBO.this_cIpiimpors  = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_CmbIpiI.Value) = "C", loc_oPag1.cbo_4c_CmbIpiI.Value, ""))), 1)
            loc_oBO.this_nInclipis   = loc_oPag1.cbo_4c_Combo7.ListIndex
            loc_oBO.this_nIpincreds  = loc_oPag1.cbo_4c_Combo1.ListIndex
            loc_oBO.this_cAcresipis  = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_Combo2.Value) = "C", loc_oPag1.cbo_4c_Combo2.Value, ""))), 1)
            loc_oBO.this_cBcipis     = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_CmbBIPI.Value) = "C", loc_oPag1.cbo_4c_CmbBIPI.Value, ""))), 1)
            loc_oBO.this_nPbcipis    = VAL(NVL(loc_oPag1.txt_4c_BcIPI.Value, "0"))
            loc_oBO.this_cIpiom2s    = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag1.cbo_4c_Combo8.Value) = "C", loc_oPag1.cbo_4c_Combo8.Value, ""))), 1)
            loc_oBO.this_nFrtipis    = IIF(loc_oPag1.chk_4c_ObjFreteIPI.Value = 1, 1, 0)
            loc_oBO.this_nSegipis    = IIF(loc_oPag1.chk_4c_ObjSegIPI.Value = 1, 1, 0)
            loc_oBO.this_nDesipis    = IIF(loc_oPag1.chk_4c_ObjDespIPI.Value = 1, 1, 0)
            loc_oBO.this_cCgergia1s  = UPPER(LEFT(ALLTRIM(NVL(loc_oPag1.txt_4c_Gergia1.Value, "")), 1))

            *-- NF-e Especificacoes (Parte 2)
            loc_oBO.this_cIpicst     = ALLTRIM(NVL(loc_oPag1.txt_4c_IPICST.Value, ""))
            loc_oBO.this_cPiscst     = ALLTRIM(NVL(loc_oPag1.txt_4c_PISCST.Value, ""))
            loc_oBO.this_cCofcst     = ALLTRIM(NVL(loc_oPag1.txt_4c_COFCST.Value, ""))
            loc_oBO.this_cIssqnl     = ALLTRIM(NVL(loc_oPag1.txt_4c_ISSQNL.Value, ""))
            loc_oBO.this_cIpienq     = ALLTRIM(NVL(loc_oPag1.txt_4c_IPIEnq.Value, ""))
            loc_oBO.this_nAliqpis    = VAL(NVL(loc_oPag1.txt_4c_AliqPIS.Value, "0"))
            loc_oBO.this_nAliqcofins = VAL(NVL(loc_oPag1.txt_4c_AliqCofins.Value, "0"))
            loc_oBO.this_nAliqissqn  = VAL(NVL(loc_oPag1.txt_4c_AliqISSQN.Value, "0"))
            loc_oBO.this_nAliqii     = VAL(NVL(loc_oPag1.txt_4c_AliqII.Value, "0"))
            loc_oBO.this_nCtissqn    = loc_oPag1.obj_4c_Fwoption1.Value
            loc_oBO.this_nRettribs   = loc_oPag1.obj_4c_Fwoption2.Value

            *-- Page2: Integracao Contabil/Fiscal
            LOCAL loc_oPag2
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

            *-- Contas contabeis
            loc_oBO.this_cContvcds   = ALLTRIM(NVL(loc_oPag2.txt_4c_Vrcds.Value, ""))
            loc_oBO.this_cContvccs   = ALLTRIM(NVL(loc_oPag2.txt_4c_Vrccs.Value, ""))
            loc_oBO.this_cContipds   = ALLTRIM(NVL(loc_oPag2.txt_4c_Ipids.Value, ""))
            loc_oBO.this_cContipcs   = ALLTRIM(NVL(loc_oPag2.txt_4c_Ipics.Value, ""))
            loc_oBO.this_cConticds   = ALLTRIM(NVL(loc_oPag2.txt_4c_Icmds.Value, ""))
            loc_oBO.this_cConticcs   = ALLTRIM(NVL(loc_oPag2.txt_4c_Icmcs.Value, ""))
            loc_oBO.this_cContfrt    = ALLTRIM(NVL(loc_oPag2.txt_4c_ContFrt.Value, ""))
            loc_oBO.this_cContseg    = ALLTRIM(NVL(loc_oPag2.txt_4c_ContSeg.Value, ""))
            loc_oBO.this_cContda     = ALLTRIM(NVL(loc_oPag2.txt_4c_ContDa.Value, ""))

            *-- Descricao na Integracao (ListIndex = pontedescs)
            loc_oBO.this_nPontedescs = loc_oPag2.cbo_4c_Combo2.ListIndex

            *-- Pega Conta Contabil da NF (S=Sim NF, N=Nao CFOP, C=C.C.)
            loc_oBO.this_cContconts  = LEFT(UPPER(ALLTRIM(IIF(VARTYPE(loc_oPag2.cbo_4c_CmbFixa.Value) = "C", loc_oPag2.cbo_4c_CmbFixa.Value, ""))), 1)

            *-- Opcoes de integracao
            loc_oBO.this_nAgrupas    = loc_oPag2.obj_4c_OptAgrupas.Value
            loc_oBO.this_nZeradas    = loc_oPag2.obj_4c_OptZeradas.Value
            loc_oBO.this_nDtintfis   = loc_oPag2.obj_4c_Fwoption1.Value
            loc_oBO.this_nUtilvars   = loc_oPag2.obj_4c_Optutilvars.Value
            loc_oBO.this_nIntvlrcont = loc_oPag2.obj_4c_Fwoption2.Value
            loc_oBO.this_nIntvlricms = loc_oPag2.obj_4c_Fwoption3.Value
            loc_oBO.this_nIntvlripi  = loc_oPag2.obj_4c_Fwoption4.Value
            loc_oBO.this_nIndmov     = loc_oPag2.obj_4c_Fwoption5.Value
            loc_oBO.this_nIndpagto   = loc_oPag2.obj_4c_Fwoption6.Value

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do Business Object para a tela (parte 1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag1, loc_oBO
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
        loc_oBO   = THIS.this_oBusinessObject

        TRY
            *-- Dados principais
            loc_oPag1.txt_4c_Codigo.Value    = ALLTRIM(NVL(loc_oBO.this_cCodigos, ""))
            loc_oPag1.txt_4c_Descricao.Value = ALLTRIM(NVL(loc_oBO.this_cDescricaos, ""))
            loc_oPag1.txt_4c_Desc2s.Value    = ALLTRIM(NVL(loc_oBO.this_cDesc2s, ""))
            loc_oPag1.obj_4c_Opc_situacao.Value = IIF(loc_oBO.this_nSituas = 1, 1, 2)
            loc_oPag1.obj_4c_Ndigito.Value      = loc_oBO.this_nNdigitos

            *-- Operacao
            loc_oPag1.cbo_4c_CmbOperacao.Value = IIF(UPPER(ALLTRIM(loc_oBO.this_cOperacaos)) = "E", ;
                "Entrada", "Sa" + CHR(237) + "da")

            *-- Tipo
            loc_oPag1.cbo_4c_Cmbtipo.Value = LTRIM(STR(loc_oBO.this_nTipos))

            *-- ICMS regime
            LOCAL loc_cIcmsDisplay
            DO CASE
                CASE UPPER(ALLTRIM(loc_oBO.this_cIcms)) = "O"
                    loc_cIcmsDisplay = "Outros"
                CASE UPPER(ALLTRIM(loc_oBO.this_cIcms)) = "I"
                    loc_cIcmsDisplay = "Isento"
                CASE UPPER(ALLTRIM(loc_oBO.this_cIcms)) = "N"
                    loc_cIcmsDisplay = "N Tributa"
                OTHERWISE
                    loc_cIcmsDisplay = "Tributado"
            ENDCASE
            loc_oPag1.cbo_4c_CmbIcms.Value = loc_cIcmsDisplay

            *-- Incluir ICMS (ListIndex = valor numerico)
            loc_oPag1.cbo_4c_Combo3.ListIndex  = loc_oBO.this_nInclicms
            loc_oPag1.cbo_4c_Combo6.ListIndex  = loc_oBO.this_nIcmsdscs
            loc_oPag1.cbo_4c_Combo10.ListIndex = loc_oBO.this_nIcmsincs
            loc_oPag1.cbo_4c_Combo5.ListIndex  = loc_oBO.this_nTransps

            *-- CFOP lookups
            loc_oPag1.txt_4c_CfoST60.Value = ALLTRIM(NVL(loc_oBO.this_cCfost60s, ""))
            loc_oPag1.txt_4c_CfoST.Value   = ALLTRIM(NVL(loc_oBO.this_cCfosts,   ""))
            loc_oPag1.txt_4c_Cfdest.Value  = ALLTRIM(NVL(loc_oBO.this_cCoddests, ""))

            *-- Checkboxes ICMS
            loc_oPag1.chk_4c_ObjFreteICM.Value   = IIF(loc_oBO.this_nFrticms = 1, 1, 0)
            loc_oPag1.chk_4c_ObjSegIcm.Value     = IIF(loc_oBO.this_nSegicms = 1, 1, 0)
            loc_oPag1.chk_4c_ObjDespIcm.Value    = IIF(loc_oBO.this_nDesicms = 1, 1, 0)
            loc_oPag1.chk_4c_Fwcheckbox1.Value   = IIF(loc_oBO.this_nIncicmnfs = 1, 1, 0)
            loc_oPag1.chk_4c_Fwcheckbox2.Value   = IIF(loc_oBO.this_nSomaicmfrete = 1, 1, 0)

            *-- Substituicao / Base ST
            loc_oPag1.cbo_4c_CmbSTRIB.Value  = IIF(UPPER(ALLTRIM(loc_oBO.this_cSubtribs)) = "S", ;
                "Sim", "N" + CHR(227) + "o")
            loc_oPag1.txt_4c_Bcst.Value       = ALLTRIM(STR(loc_oBO.this_nPbcsts, 6, 2))

            *-- Situacao Tributaria
            loc_oPag1.txt_4c_Sittricm.Value  = ALLTRIM(NVL(loc_oBO.this_cSittribs, ""))

            *-- Contribuinte
            LOCAL loc_cContribDisplay
            DO CASE
                CASE UPPER(ALLTRIM(loc_oBO.this_cContribs)) = "S"
                    loc_cContribDisplay = "Sim"
                CASE UPPER(ALLTRIM(loc_oBO.this_cContribs)) = "O"
                    loc_cContribDisplay = "Outros"
                OTHERWISE
                    loc_cContribDisplay = "N" + CHR(227) + "o"
            ENDCASE
            loc_oPag1.cbo_4c_CmbContribuinte.Value = loc_cContribDisplay

            *-- Aliquota Venda Consumidor / Mot Desoneracao
            loc_oPag1.txt_4c_AliqIVCs.Value  = ALLTRIM(STR(loc_oBO.this_nAliqivcs, 5, 2))
            loc_oPag1.txt_4c_MotDeson.Value  = ALLTRIM(NVL(loc_oBO.this_cMotdeson, ""))

            *-- Inibe Valor Unitario NF Importacao
            loc_oPag1.cbo_4c_Combo9.Value = IIF(UPPER(ALLTRIM(loc_oBO.this_cUnitimps)) = "S", ;
                "Sim", "N" + CHR(227) + "o")

            *-- Inclui IPI na Base ICMS
            loc_oPag1.cbo_4c_Combo4.Value = IIF(UPPER(ALLTRIM(loc_oBO.this_cIpiIcms)) = "S", ;
                "Sim", "N" + CHR(227) + "o")

            *-- IPI (Parte 2)
            loc_oPag1.cbo_4c_CmbIpi.Value = IIF(UPPER(ALLTRIM(loc_oBO.this_cIpis)) = "O", "Outros", ;
                IIF(UPPER(ALLTRIM(loc_oBO.this_cIpis)) = "I", "Isento", "Tributado"))
            loc_oPag1.txt_4c_Aliqs.Value  = ALLTRIM(STR(loc_oBO.this_nAliqipis, 5, 2))
            loc_oPag1.cbo_4c_CmbIpiI.Value = IIF(UPPER(ALLTRIM(loc_oBO.this_cIpiimpors)) = "S", ;
                "Sim", "N" + CHR(227) + "o")
            loc_oPag1.cbo_4c_Combo7.ListIndex = loc_oBO.this_nInclipis
            loc_oPag1.cbo_4c_Combo1.ListIndex = loc_oBO.this_nIpincreds
            loc_oPag1.cbo_4c_Combo2.Value = IIF(UPPER(ALLTRIM(loc_oBO.this_cAcresipis)) = "S", ;
                "Sim", "N" + CHR(227) + "o")
            LOCAL loc_cBcDisplay
            DO CASE
                CASE UPPER(LEFT(ALLTRIM(loc_oBO.this_cBcipis), 1)) = "F"
                    loc_cBcDisplay = "Fator Markup"
                CASE UPPER(LEFT(ALLTRIM(loc_oBO.this_cBcipis), 1)) = "P"
                    loc_cBcDisplay = "Preco Venda"
                CASE UPPER(LEFT(ALLTRIM(loc_oBO.this_cBcipis), 1)) = "B"
                    loc_cBcDisplay = "Base C.M" + CHR(233) + "dio"
                CASE UPPER(LEFT(ALLTRIM(loc_oBO.this_cBcipis), 1)) = "G"
                    loc_cBcDisplay = "Grupo Prod"
                CASE UPPER(LEFT(ALLTRIM(loc_oBO.this_cBcipis), 1)) = "M"
                    loc_cBcDisplay = "Movimenta" + CHR(231) + CHR(227) + "o"
                OTHERWISE
                    loc_cBcDisplay = "Valor Merc."
            ENDCASE
            loc_oPag1.cbo_4c_CmbBIPI.Value = loc_cBcDisplay
            loc_oPag1.txt_4c_BcIPI.Value   = ALLTRIM(STR(loc_oBO.this_nPbcipis, 6, 2))
            loc_oPag1.cbo_4c_Combo8.Value  = IIF(UPPER(ALLTRIM(loc_oBO.this_cIpiom2s)) = "S", ;
                "Sim", "N" + CHR(227) + "o")
            loc_oPag1.cbo_4c_Combo8.Enabled = (UPPER(ALLTRIM(loc_oBO.this_cIpiimpors)) = "S")
            loc_oPag1.chk_4c_ObjFreteIPI.Value = IIF(loc_oBO.this_nFrtipis = 1, 1, 0)
            loc_oPag1.chk_4c_ObjSegIPI.Value   = IIF(loc_oBO.this_nSegipis = 1, 1, 0)
            loc_oPag1.chk_4c_ObjDespIPI.Value  = IIF(loc_oBO.this_nDesipis = 1, 1, 0)
            loc_oPag1.txt_4c_Gergia1.Value = UPPER(ALLTRIM(NVL(loc_oBO.this_cCgergia1s, "")))

            *-- NF-e Especificacoes (Parte 2)
            loc_oPag1.txt_4c_IPICST.Value     = ALLTRIM(NVL(loc_oBO.this_cIpicst, ""))
            loc_oPag1.txt_4c_PISCST.Value     = ALLTRIM(NVL(loc_oBO.this_cPiscst, ""))
            loc_oPag1.txt_4c_COFCST.Value     = ALLTRIM(NVL(loc_oBO.this_cCofcst, ""))
            loc_oPag1.txt_4c_ISSQNL.Value     = ALLTRIM(NVL(loc_oBO.this_cIssqnl, ""))
            loc_oPag1.txt_4c_IPIEnq.Value     = ALLTRIM(NVL(loc_oBO.this_cIpienq, ""))
            loc_oPag1.txt_4c_AliqPIS.Value    = ALLTRIM(STR(loc_oBO.this_nAliqpis,    6, 2))
            loc_oPag1.txt_4c_AliqCofins.Value = ALLTRIM(STR(loc_oBO.this_nAliqcofins, 6, 2))
            loc_oPag1.txt_4c_AliqISSQN.Value  = ALLTRIM(STR(loc_oBO.this_nAliqissqn,  6, 2))
            loc_oPag1.txt_4c_AliqII.Value     = ALLTRIM(STR(loc_oBO.this_nAliqii,     6, 2))
            loc_oPag1.obj_4c_Fwoption1.Value  = IIF(loc_oBO.this_nCtissqn >= 1 AND ;
                loc_oBO.this_nCtissqn <= 5, loc_oBO.this_nCtissqn, 1)
            loc_oPag1.obj_4c_Fwoption2.Value  = IIF(loc_oBO.this_nRettribs >= 1 AND ;
                loc_oBO.this_nRettribs <= 2, loc_oBO.this_nRettribs, 2)

            *-- Page2: Integracao Contabil/Fiscal
            LOCAL loc_oPag2B
            loc_oPag2B = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

            *-- Contas contabeis
            loc_oPag2B.txt_4c_Vrcds.Value   = ALLTRIM(NVL(loc_oBO.this_cContvcds, ""))
            loc_oPag2B.txt_4c_Vrccs.Value   = ALLTRIM(NVL(loc_oBO.this_cContvccs, ""))
            loc_oPag2B.txt_4c_Ipids.Value   = ALLTRIM(NVL(loc_oBO.this_cContipds, ""))
            loc_oPag2B.txt_4c_Ipics.Value   = ALLTRIM(NVL(loc_oBO.this_cContipcs, ""))
            loc_oPag2B.txt_4c_Icmds.Value   = ALLTRIM(NVL(loc_oBO.this_cConticds, ""))
            loc_oPag2B.txt_4c_Icmcs.Value   = ALLTRIM(NVL(loc_oBO.this_cConticcs, ""))
            loc_oPag2B.txt_4c_ContFrt.Value = ALLTRIM(NVL(loc_oBO.this_cContfrt,  ""))
            loc_oPag2B.txt_4c_ContSeg.Value = ALLTRIM(NVL(loc_oBO.this_cContseg,  ""))
            loc_oPag2B.txt_4c_ContDa.Value  = ALLTRIM(NVL(loc_oBO.this_cContda,   ""))

            *-- Descricao na Integracao
            loc_oPag2B.cbo_4c_Combo2.ListIndex = IIF(loc_oBO.this_nPontedescs >= 1 AND ;
                loc_oBO.this_nPontedescs <= 3, loc_oBO.this_nPontedescs, 2)

            *-- Pega Conta Contabil da NF
            LOCAL loc_cContContsDisp
            DO CASE
                CASE UPPER(ALLTRIM(loc_oBO.this_cContconts)) = "S"
                    loc_cContContsDisp = "Sim (NF)"
                CASE UPPER(ALLTRIM(loc_oBO.this_cContconts)) = "C"
                    loc_cContContsDisp = "C.C."
                OTHERWISE
                    loc_cContContsDisp = "N" + CHR(227) + "o (CFOP)"
            ENDCASE
            loc_oPag2B.cbo_4c_CmbFixa.Value = loc_cContContsDisp

            *-- Opcoes de integracao
            loc_oPag2B.obj_4c_OptAgrupas.Value   = IIF(loc_oBO.this_nAgrupas >= 1 AND ;
                loc_oBO.this_nAgrupas <= 2, loc_oBO.this_nAgrupas, 2)
            loc_oPag2B.obj_4c_OptZeradas.Value   = IIF(loc_oBO.this_nZeradas >= 1 AND ;
                loc_oBO.this_nZeradas <= 2, loc_oBO.this_nZeradas, 2)
            loc_oPag2B.obj_4c_Fwoption1.Value    = IIF(loc_oBO.this_nDtintfis >= 1 AND ;
                loc_oBO.this_nDtintfis <= 2, loc_oBO.this_nDtintfis, 1)
            loc_oPag2B.obj_4c_Optutilvars.Value  = IIF(loc_oBO.this_nUtilvars >= 1 AND ;
                loc_oBO.this_nUtilvars <= 2, loc_oBO.this_nUtilvars, 2)
            loc_oPag2B.obj_4c_Fwoption2.Value    = IIF(loc_oBO.this_nIntvlrcont >= 1 AND ;
                loc_oBO.this_nIntvlrcont <= 2, loc_oBO.this_nIntvlrcont, 2)
            loc_oPag2B.obj_4c_Fwoption3.Value    = IIF(loc_oBO.this_nIntvlricms >= 1 AND ;
                loc_oBO.this_nIntvlricms <= 2, loc_oBO.this_nIntvlricms, 2)
            loc_oPag2B.obj_4c_Fwoption4.Value    = IIF(loc_oBO.this_nIntvlripi >= 1 AND ;
                loc_oBO.this_nIntvlripi <= 2, loc_oBO.this_nIntvlripi, 2)
            loc_oPag2B.obj_4c_Fwoption5.Value    = IIF(loc_oBO.this_nIndmov >= 1 AND ;
                loc_oBO.this_nIndmov <= 2, loc_oBO.this_nIndmov, 2)
            loc_oPag2B.obj_4c_Fwoption6.Value    = IIF(loc_oBO.this_nIndpagto >= 1 AND ;
                loc_oBO.this_nIndpagto <= 2, loc_oBO.this_nIndpagto, 2)

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do Page1 (parte 1) para novo registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1

        TRY
            *-- Dados principais
            loc_oPag1.txt_4c_Codigo.Value    = ""
            loc_oPag1.txt_4c_Descricao.Value = ""
            loc_oPag1.txt_4c_Desc2s.Value    = ""
            loc_oPag1.obj_4c_Opc_situacao.Value  = 1
            loc_oPag1.obj_4c_Ndigito.Value        = 0
            loc_oPag1.cbo_4c_CmbOperacao.ListIndex = 1
            loc_oPag1.cbo_4c_Cmbtipo.ListIndex     = 1

            *-- ICMS
            loc_oPag1.cbo_4c_CmbIcms.ListIndex    = 1
            loc_oPag1.cbo_4c_Combo3.ListIndex      = 1
            loc_oPag1.cbo_4c_Combo6.ListIndex      = 2
            loc_oPag1.cbo_4c_Combo10.ListIndex     = 2
            loc_oPag1.cbo_4c_Combo5.ListIndex      = 2
            loc_oPag1.txt_4c_CfoST60.Value         = ""
            loc_oPag1.txt_4c_CfoST.Value           = ""
            loc_oPag1.txt_4c_Cfdest.Value          = ""
            loc_oPag1.chk_4c_ObjFreteICM.Value     = 0
            loc_oPag1.chk_4c_ObjSegIcm.Value       = 0
            loc_oPag1.chk_4c_ObjDespIcm.Value      = 0
            loc_oPag1.chk_4c_Fwcheckbox1.Value     = 0
            loc_oPag1.chk_4c_Fwcheckbox2.Value     = 0
            loc_oPag1.cbo_4c_CmbSTRIB.ListIndex    = 2
            loc_oPag1.txt_4c_Bcst.Value            = "  0.00"
            loc_oPag1.txt_4c_Sittricm.Value        = ""
            loc_oPag1.cbo_4c_CmbContribuinte.ListIndex = 2
            loc_oPag1.txt_4c_AliqIVCs.Value        = " 0.00"
            loc_oPag1.txt_4c_MotDeson.Value        = ""
            loc_oPag1.cbo_4c_Combo9.ListIndex      = 2
            loc_oPag1.cbo_4c_Combo4.ListIndex      = 2

            *-- IPI / NF-e (Parte 2)
            loc_oPag1.cbo_4c_CmbIpi.ListIndex      = 1   && Tributado
            loc_oPag1.txt_4c_Aliqs.Value           = " 0.00"
            loc_oPag1.cbo_4c_CmbIpiI.ListIndex     = 2   && Nao (ipiimpors)
            loc_oPag1.cbo_4c_Combo7.ListIndex      = 2   && Nao (inclipis)
            loc_oPag1.txt_4c_Gergia1.Value         = ""
            loc_oPag1.cbo_4c_Combo1.ListIndex      = 2   && Nao (ipincreds)
            loc_oPag1.cbo_4c_Combo2.ListIndex      = 2   && Nao (acresipis)
            loc_oPag1.cbo_4c_CmbBIPI.ListIndex     = 4   && Valor Merc. (default)
            loc_oPag1.txt_4c_BcIPI.Value           = "  0.00"
            loc_oPag1.cbo_4c_Combo8.ListIndex      = 2   && Nao (ipiom2s)
            loc_oPag1.cbo_4c_Combo8.Enabled        = .F.
            loc_oPag1.chk_4c_ObjFreteIPI.Value     = 0
            loc_oPag1.chk_4c_ObjSegIPI.Value       = 0
            loc_oPag1.chk_4c_ObjDespIPI.Value      = 0
            loc_oPag1.txt_4c_IPICST.Value          = ""
            loc_oPag1.txt_4c_PISCST.Value          = ""
            loc_oPag1.txt_4c_COFCST.Value          = ""
            loc_oPag1.txt_4c_ISSQNL.Value          = ""
            loc_oPag1.txt_4c_IPIEnq.Value          = ""
            loc_oPag1.txt_4c_AliqPIS.Value         = "  0.00"
            loc_oPag1.txt_4c_AliqCofins.Value      = "  0.00"
            loc_oPag1.txt_4c_AliqISSQN.Value       = "  0.00"
            loc_oPag1.txt_4c_AliqII.Value          = "  0.00"
            loc_oPag1.obj_4c_Fwoption1.Value       = 1   && Normal
            loc_oPag1.obj_4c_Fwoption2.Value       = 2   && Nao

            *-- Page2: Integracao Contabil/Fiscal
            LOCAL loc_oPag2C
            loc_oPag2C = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

            *-- Contas contabeis (limpar)
            loc_oPag2C.txt_4c_Vrcds.Value   = ""
            loc_oPag2C.txt_4c_Vrccs.Value   = ""
            loc_oPag2C.txt_4c_Ipids.Value   = ""
            loc_oPag2C.txt_4c_Ipics.Value   = ""
            loc_oPag2C.txt_4c_Icmds.Value   = ""
            loc_oPag2C.txt_4c_Icmcs.Value   = ""
            loc_oPag2C.txt_4c_ContFrt.Value = ""
            loc_oPag2C.txt_4c_ContSeg.Value = ""
            loc_oPag2C.txt_4c_ContDa.Value  = ""

            *-- Combos (defaults)
            loc_oPag2C.cbo_4c_Combo2.ListIndex = 2   && Nao-Nenhuma
            loc_oPag2C.cbo_4c_CmbFixa.Value    = "N" + CHR(227) + "o (CFOP)"

            *-- OptionGroups (defaults: Nao)
            loc_oPag2C.obj_4c_OptAgrupas.Value  = 2   && Nao
            loc_oPag2C.obj_4c_OptZeradas.Value  = 2   && Nao
            loc_oPag2C.obj_4c_Fwoption1.Value   = 1   && Data Integracao (default)
            loc_oPag2C.obj_4c_Optutilvars.Value = 2   && Nao
            loc_oPag2C.obj_4c_Fwoption2.Value   = 2   && Nao
            loc_oPag2C.obj_4c_Fwoption3.Value   = 2   && Nao
            loc_oPag2C.obj_4c_Fwoption4.Value   = 2   && Nao
            loc_oPag2C.obj_4c_Fwoption5.Value   = 2   && Nao
            loc_oPag2C.obj_4c_Fwoption6.Value   = 2   && Nao

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    * par_lHabilitar = .T. para editar, .F. para somente leitura (VISUALIZAR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag1, loc_oPag2, loc_lHabCodigo

        *-- Codigo editavel apenas em INCLUIR (nunca em ALTERAR)
        loc_lHabCodigo = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1

            *-- Codigo (apenas INCLUIR)
            loc_oPag1.txt_4c_Codigo.Enabled   = loc_lHabCodigo
            *-- Spinner digitos
            loc_oPag1.obj_4c_Ndigito.Enabled  = par_lHabilitar

            *-- Descricoes
            loc_oPag1.txt_4c_Descricao.Enabled   = par_lHabilitar
            loc_oPag1.txt_4c_Desc2s.Enabled      = par_lHabilitar

            *-- Combos / situacao
            loc_oPag1.obj_4c_Opc_situacao.Enabled  = par_lHabilitar
            loc_oPag1.cbo_4c_CmbOperacao.Enabled   = par_lHabilitar
            loc_oPag1.cbo_4c_Cmbtipo.Enabled       = par_lHabilitar

            *-- ICMS
            loc_oPag1.cbo_4c_CmbIcms.Enabled       = par_lHabilitar
            loc_oPag1.cbo_4c_Combo3.Enabled         = par_lHabilitar
            loc_oPag1.cbo_4c_Combo6.Enabled         = par_lHabilitar
            loc_oPag1.cbo_4c_Combo10.Enabled        = par_lHabilitar
            loc_oPag1.cbo_4c_CmbSTRIB.Enabled       = par_lHabilitar
            loc_oPag1.cbo_4c_Combo5.Enabled         = par_lHabilitar
            loc_oPag1.cbo_4c_Combo9.Enabled         = par_lHabilitar
            loc_oPag1.cbo_4c_CmbContribuinte.Enabled = par_lHabilitar
            loc_oPag1.txt_4c_Bcst.Enabled           = par_lHabilitar
            loc_oPag1.txt_4c_CfoST60.Enabled        = par_lHabilitar
            loc_oPag1.txt_4c_CfoST.Enabled          = par_lHabilitar
            loc_oPag1.txt_4c_Cfdest.Enabled         = par_lHabilitar
            loc_oPag1.txt_4c_Sittricm.Enabled       = par_lHabilitar
            loc_oPag1.txt_4c_AliqIVCs.Enabled       = par_lHabilitar
            loc_oPag1.txt_4c_MotDeson.Enabled       = par_lHabilitar
            loc_oPag1.txt_4c_Gergia1.Enabled        = par_lHabilitar
            loc_oPag1.chk_4c_ObjFreteICM.Enabled    = par_lHabilitar
            loc_oPag1.chk_4c_ObjSegIcm.Enabled      = par_lHabilitar
            loc_oPag1.chk_4c_ObjDespIcm.Enabled     = par_lHabilitar
            loc_oPag1.chk_4c_Fwcheckbox1.Enabled    = par_lHabilitar
            loc_oPag1.chk_4c_Fwcheckbox2.Enabled    = par_lHabilitar

            *-- IPI
            loc_oPag1.cbo_4c_CmbIpi.Enabled    = par_lHabilitar
            loc_oPag1.txt_4c_Aliqs.Enabled      = par_lHabilitar
            loc_oPag1.cbo_4c_CmbIpiI.Enabled    = par_lHabilitar
            loc_oPag1.cbo_4c_Combo7.Enabled     = par_lHabilitar
            loc_oPag1.cbo_4c_Combo1.Enabled     = par_lHabilitar
            loc_oPag1.cbo_4c_Combo2.Enabled     = par_lHabilitar
            loc_oPag1.cbo_4c_CmbBIPI.Enabled    = par_lHabilitar
            loc_oPag1.txt_4c_BcIPI.Enabled      = par_lHabilitar
            loc_oPag1.cbo_4c_Combo8.Enabled     = par_lHabilitar
            loc_oPag1.chk_4c_ObjFreteIPI.Enabled = par_lHabilitar
            loc_oPag1.chk_4c_ObjSegIPI.Enabled   = par_lHabilitar
            loc_oPag1.chk_4c_ObjDespIPI.Enabled  = par_lHabilitar
            loc_oPag1.cbo_4c_Combo4.Enabled      = par_lHabilitar

            *-- NF-e
            loc_oPag1.txt_4c_IPICST.Enabled   = par_lHabilitar
            loc_oPag1.txt_4c_PISCST.Enabled   = par_lHabilitar
            loc_oPag1.txt_4c_COFCST.Enabled   = par_lHabilitar
            loc_oPag1.txt_4c_ISSQNL.Enabled   = par_lHabilitar
            loc_oPag1.txt_4c_IPIEnq.Enabled   = par_lHabilitar
            loc_oPag1.txt_4c_AliqPIS.Enabled  = par_lHabilitar
            loc_oPag1.txt_4c_AliqCofins.Enabled = par_lHabilitar
            loc_oPag1.txt_4c_AliqISSQN.Enabled = par_lHabilitar
            loc_oPag1.txt_4c_AliqII.Enabled   = par_lHabilitar
            loc_oPag1.obj_4c_Fwoption1.Enabled = par_lHabilitar
            loc_oPag1.obj_4c_Fwoption2.Enabled = par_lHabilitar

            *-- Page2: Integracao Contabil/Fiscal
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

            loc_oPag2.txt_4c_Vrcds.Enabled    = par_lHabilitar
            loc_oPag2.txt_4c_Vrccs.Enabled    = par_lHabilitar
            loc_oPag2.txt_4c_Ipids.Enabled    = par_lHabilitar
            loc_oPag2.txt_4c_Ipics.Enabled    = par_lHabilitar
            loc_oPag2.txt_4c_Icmds.Enabled    = par_lHabilitar
            loc_oPag2.txt_4c_Icmcs.Enabled    = par_lHabilitar
            loc_oPag2.txt_4c_ContFrt.Enabled  = par_lHabilitar
            loc_oPag2.txt_4c_ContSeg.Enabled  = par_lHabilitar
            loc_oPag2.txt_4c_ContDa.Enabled   = par_lHabilitar
            loc_oPag2.cbo_4c_Combo2.Enabled   = par_lHabilitar
            loc_oPag2.cbo_4c_CmbFixa.Enabled  = par_lHabilitar
            loc_oPag2.obj_4c_OptAgrupas.Enabled  = par_lHabilitar
            loc_oPag2.obj_4c_OptZeradas.Enabled  = par_lHabilitar
            loc_oPag2.obj_4c_Fwoption1.Enabled   = par_lHabilitar
            loc_oPag2.obj_4c_Optutilvars.Enabled  = par_lHabilitar
            loc_oPag2.obj_4c_Fwoption2.Enabled   = par_lHabilitar
            loc_oPag2.obj_4c_Fwoption3.Enabled   = par_lHabilitar
            loc_oPag2.obj_4c_Fwoption4.Enabled   = par_lHabilitar
            loc_oPag2.obj_4c_Fwoption5.Enabled   = par_lHabilitar
            loc_oPag2.obj_4c_Fwoption6.Enabled   = par_lHabilitar

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEmEdicao

        *-- Determina se esta em modo de edicao (INCLUIR ou ALTERAR)
        loc_lEmEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            *-- Botoes da Page2 (Confirmar/Cancelar)
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            *-- Confirmar: habilitado apenas em INCLUIR/ALTERAR
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEmEdicao

            *-- Cancelar: sempre habilitado em Page2
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.

            *-- Botoes da Page1 (CRUD): desabilita Alterar/Excluir quando nao ha registro
            LOCAL loc_oPg1
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            LOCAL loc_lTemRegistro
            loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")

            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "Formcfo.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
