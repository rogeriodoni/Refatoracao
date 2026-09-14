*==============================================================================
* FormSigReGla.prg
* Formulario operacional - SigReGla
* Herda de: FormBase
* Fase 8/8: COMPLETO - todos os metodos implementados
*==============================================================================

DEFINE CLASS FormSigReGla AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades
    *--------------------------------------------------------------------------
    this_cTituloForm = ""
    this_cModoAtual  = "LISTA"

    *-- Configuracoes visuais (copiadas do original)
    Top          = 0
    Left         = 0
    Width        = 375
    Height       = 250
    TitleBar     = 0
    AutoCenter   = .F.
    Caption      = "Form1"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Inicializa BO, PageFrame e containers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Instancia Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigReGlaBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Configura PageFrame, Page1 e Page2
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarContaineresPage2()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Torna controles visiveis
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1

                THIS.TornarControlesVisiveis(THIS.pgf_4c_Paginas.Page1)
                THIS.TornarControlesVisiveis(THIS.pgf_4c_Paginas.Page2)

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.AjustarBotoesPorModo()
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigReGlaBO.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 e Page2
    *--------------------------------------------------------------------------
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
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1 com Grid e botoes CRUD
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPage

        loc_oPage = THIS.pgf_4c_Paginas.Page1
        loc_oPage.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho escuro (cntSombra do framework)
        loc_oPage.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPage.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 54
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 16
            .Left      = 11
            .Width     = THIS.Width - 22
            .Height    = 26
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Caption   = "Form1"
            .Visible   = .T.
        ENDWITH

        loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 14
            .Left      = 10
            .Width     = THIS.Width - 22
            .Height    = 26
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Caption   = "Form1"
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (canonico: Left=542, Width=390, lado direito)
        loc_oPage.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPage.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Incluir
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Visualizar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Alterar
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Excluir
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPage.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPage.cnt_4c_Botoes.cmd_4c_Buscar
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Container Encerrar (canonico: Left=917, Width=90)
        loc_oPage.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPage.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPage.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPage.cnt_4c_Saida.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid de lista (RecordSource sera definido em CarregarLista)
        loc_oPage.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPage.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 443
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- BINDEVENTs (somente metodos PUBLIC)
        BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPage.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPage.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPage.grd_4c_Lista,                    "DblClick", THIS, "GrdListaDblClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContaineresPage2 - Containers basicos da pagina Dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContaineresPage2()
        LOCAL loc_oPage
        loc_oPage = THIS.pgf_4c_Paginas.Page2

        *-- Container de botoes de acao em Page2
        loc_oPage.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPage.cnt_4c_BotoesAcao
            .Top        = 33
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 com cabecalho (primeira metade)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPage
        loc_oPage = THIS.pgf_4c_Paginas.Page2
        loc_oPage.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho escuro (identico ao de Page1)
        loc_oPage.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPage.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 54
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 16
            .Left      = 11
            .Width     = THIS.Width - 22
            .Height    = 26
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Caption   = "Form1"
            .Visible   = .T.
        ENDWITH

        loc_oPage.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPage.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 14
            .Left      = 10
            .Width     = THIS.Width - 22
            .Height    = 26
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Caption   = "Form1"
            .Visible   = .T.
        ENDWITH

        *-- Botao Confirmar
        loc_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar
        loc_oPage.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENTs
        BINDEVENT(loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPage.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles de container visiveis
    * Iteracao recursiva sobre Controls e Pages
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.AjustarBotoesPorModo()
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Dados (cCodigo C(20) NULL)
            SET NULL OFF

            loc_oGrid.ColumnCount    = 1
            loc_oGrid.RecordSource   = "cursor_4c_Dados"
            loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.cCodigo"
            loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"

            THIS.FormatarGridLista(loc_oGrid)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lTemRegistro

        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

        WITH loc_oCnt
            .cmd_4c_Incluir.Enabled    = .T.
            .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
            .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
            .cmd_4c_Buscar.Enabled     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Navega para Page2 em modo INCLUIR
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.BOParaForm()
        THIS.CarregarDados()
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Navega para Page2 em modo VISUALIZAR
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para visualizar.", "Aviso")
            RETURN
        ENDIF

        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
        THIS.BOParaForm()
        THIS.CarregarDados()
        THIS.HabilitarCampos(.F.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Navega para Page2 em modo ALTERAR
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para alterar.", "Aviso")
            RETURN
        ENDIF

        THIS.this_cModoAtual = "ALTERAR"
        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
        THIS.BOParaForm()
        THIS.CarregarDados()
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lSucesso

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para excluir.", "Aviso")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", "Excluir")
            RETURN
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.Excluir()

        IF loc_lSucesso
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista (filtragem basica)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdListaDblClick - Duplo clique na grade: visualiza registro
    *--------------------------------------------------------------------------
    PROCEDURE GrdListaDblClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do form para o BO
    * Form operacional sem campos CRUD - sem transferencia de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Preenche campos do form com dados do BO
    * Form operacional sem campos CRUD - sem campos a preencher
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario
    * Form operacional sem campos CRUD - nenhum campo a limpar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega dados complementares para exibicao na Page2
    * Form operacional sem dados complementares - implementacao vazia
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos conforme modo
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lEditar)
        LOCAL loc_oCnt

        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
            loc_oCnt.cmd_4c_Confirmar.Enabled = par_lEditar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva o registro (Inserir ou Atualizar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.FormParaBO()

            IF THIS.this_cModoAtual = "INCLUIR"
                loc_lSucesso = THIS.this_oBusinessObject.Inserir()
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
            ENDIF

            IF loc_lSucesso
                THIS.AlternarPagina(1)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberacao de recursos
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
