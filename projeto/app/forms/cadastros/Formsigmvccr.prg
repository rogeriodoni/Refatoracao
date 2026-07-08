*==============================================================================
* Formsigmvccr.prg - Formulario de Conta Corrente Geral
* Fase 8/8 - COMPLETO: LimparCampos, AjustarBotoesPorModo, consolidacao final
* Data: 2026-04-11
* Legado: SIGMVCCR (frmcadastro)
* Tabela: SigMvCcr
*==============================================================================

DEFINE CLASS Formsigmvccr AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX Fidelity)
    *--------------------------------------------------------------------------
    Height      = 600
    Width       = 1000
    Caption     = "Conta Corrente Geral"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *--------------------------------------------------------------------------
    * Propriedades do form
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"    && LISTA | INCLUIR | ALTERAR | VISUALIZAR

    *==========================================================================
    * INICIALIZACAO
    *==========================================================================

    *--------------------------------------------------------------------------
    * Init - apenas delega ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial (chamado pelo FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigmvccrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigmvccrBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propagar Caption para labels do cabecalho
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra, "Caption", 5)
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo, "Caption", 5)
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                ENDIF

                *-- Inicializar filtro de datas com data de hoje (igual ao legado Init)
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value = DATE()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value   = DATE()

                *-- Carregar lista inicial (pular se validando UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .PageCount  = 2
                .Top        = -29
                .Left       = 0
                .Width      = THIS.Width
                .Height     = THIS.Height + 29
                .Tabs       = .F.
                .Visible    = .T.
                .Page1.Caption   = "Lista"
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Caption   = "Dados"
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page1.BackColor = RGB(240, 240, 240)
                .Page2.BackColor = RGB(240, 240, 240)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PAGE1 - LISTA COM GRID E BOTOES CRUD
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1: grid, botoes, filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *--------------------------------------------------------------------
            * Container cabecalho (titulo do form) - Top=2+29=31
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Top       = 15
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .Caption   = "Conta Corrente Geral"
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .Caption   = "Conta Corrente Geral"
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * Container botoes CRUD (lado direito, Top=0+29=29)
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top         = 29
                .Left        = 542
                .Width       = 390
                .Height      = 85
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                *-- cmd_4c_Incluir
                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Caption         = "Incluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontSize        = 8
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                *-- cmd_4c_Visualizar
                .AddObject("cmd_4c_Visualizar", "CommandButton")
                WITH .cmd_4c_Visualizar
                    .Caption         = "Visualizar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontSize        = 8
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                *-- cmd_4c_Alterar
                .AddObject("cmd_4c_Alterar", "CommandButton")
                WITH .cmd_4c_Alterar
                    .Caption         = "Alterar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontSize        = 8
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                *-- cmd_4c_Excluir
                .AddObject("cmd_4c_Excluir", "CommandButton")
                WITH .cmd_4c_Excluir
                    .Caption         = "Excluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontSize        = 8
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                *-- cmd_4c_Buscar
                .AddObject("cmd_4c_Buscar", "CommandButton")
                WITH .cmd_4c_Buscar
                    .Caption         = "Buscar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontSize        = 8
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * Container saida - Encerrar (Top=0+29=29, Left=937)
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPagina.cnt_4c_Saida
                .Top         = 29
                .Left        = 917
                .Width       = 90
                .Height      = 85
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Encerrar", "CommandButton")
                WITH .cmd_4c_Encerrar
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 917
                    .Width           = 90
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontSize        = 8
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * Botao Movimento (Anexa) - Top=4+29=33, Left=847
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("cmd_4c_Movimento", "CommandButton")
            WITH loc_oPagina.cmd_4c_Movimento
                .Caption         = "Movimento"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 33
                .Left            = 847
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Container filtro periodo (Top=114, abaixo do cabecalho+botoes)
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
            WITH loc_oPagina.cnt_4c_Filtros
                .Top         = 114
                .Left        = 0
                .Width       = 400
                .Height      = 36
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Periodo", "Label")
                WITH .lbl_4c_Periodo
                    .Caption   = "Per" + CHR(237) + "odo : "
                    .Top       = 10
                    .Left      = 17
                    .Width     = 54
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_DtInicial", "TextBox")
                WITH .txt_4c_DtInicial
                    .Top      = 6
                    .Left     = 73
                    .Width    = 80
                    .Height   = 21
                    .Value    = {}
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Format   = "D"
                    .Visible  = .T.
                ENDWITH

                .AddObject("lbl_4c_Ate", "Label")
                WITH .lbl_4c_Ate
                    .Caption   = "at" + CHR(233)
                    .Top       = 10
                    .Left      = 158
                    .Width     = 20
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_DtFinal", "TextBox")
                WITH .txt_4c_DtFinal
                    .Top      = 6
                    .Left     = 184
                    .Width    = 80
                    .Height   = 21
                    .Value    = {}
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Format   = "D"
                    .Visible  = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * Cursor placeholder para o Grid (preserva colunas durante reloads)
            * O grid usa cursor_4c_Dados; os dados vem via ZAP+APPEND em CarregarLista()
            *--------------------------------------------------------------------
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ( ;
                Datas      T, ;
                Opers      C(1), ;
                Contas     C(10), ;
                Scontas    C(10), ;
                Hists      C(60), ;
                Valors     N(11,2), ;
                Svalors    N(11,2), ;
                Concs      L, ;
                Autos      L, ;
                Nfs        C(10), ;
                Docus      C(10), ;
                Nopers     N(7,0), ;
                Cidchaves  C(20) ;
            )
            SET NULL OFF

            *--------------------------------------------------------------------
            * Grid de dados (11 colunas, ordem visual identica ao legado)
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = loc_oPagina.grd_4c_Dados

            loc_oGrid.Top              = 150
            loc_oGrid.Left             = 5
            loc_oGrid.Width            = 986
            loc_oGrid.Height           = 472
            loc_oGrid.FontName         = "Verdana"
            loc_oGrid.FontSize         = 8
            loc_oGrid.ForeColor        = RGB(90, 90, 90)
            loc_oGrid.BackColor        = RGB(255, 255, 255)
            loc_oGrid.GridLineColor    = RGB(238, 238, 238)
            loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
            loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
            loc_oGrid.HighlightStyle   = 2
            loc_oGrid.DeleteMark       = .F.
            loc_oGrid.RecordMark       = .F.
            loc_oGrid.RowHeight        = 16
            loc_oGrid.ScrollBars       = 2
            loc_oGrid.GridLines        = 3
            loc_oGrid.Visible          = .T.

            *-- ColumnCount e RecordSource FORA de WITH (evita "Unknown member COLUMN1")
            loc_oGrid.ColumnCount  = 11
            loc_oGrid.RecordSource = "cursor_4c_Dados"

            *-- ControlSource APOS RecordSource (evita auto-bind por posicao)
            loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.Datas"
            loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.Opers"
            loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.Contas"
            loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.Scontas"
            loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.Hists"
            loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.Valors"
            loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.Svalors"
            loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.Concs"
            loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.Autos"
            loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.Nfs"
            loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.Docus"

            *-- Larguras das colunas
            loc_oGrid.Column1.Width  = 65     && Data
            loc_oGrid.Column2.Width  = 20     && O (D/C)
            loc_oGrid.Column3.Width  = 80     && Conta
            loc_oGrid.Column4.Width  = 80     && Contrapartida
            loc_oGrid.Column5.Width  = 225    && Historico
            loc_oGrid.Column6.Width  = 100    && Debito
            loc_oGrid.Column7.Width  = 100    && Credito
            loc_oGrid.Column8.Width  = 20     && [blank/Concs]
            loc_oGrid.Column9.Width  = 20     && [space/Autos]
            loc_oGrid.Column10.Width = 80     && NF
            loc_oGrid.Column11.Width = 80     && Documento

            *-- Alinhamento
            loc_oGrid.Column6.Alignment = 1   && Right para Debito
            loc_oGrid.Column7.Alignment = 1   && Right para Credito

            *-- Headers (APOS RecordSource e ControlSource - OBRIGATORIO)
            loc_oGrid.Column1.Header1.Caption  = "Data"
            loc_oGrid.Column2.Header1.Caption  = "O"
            loc_oGrid.Column3.Header1.Caption  = "Conta"
            loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
            loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
            loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
            loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
            loc_oGrid.Column8.Header1.Caption  = ""
            loc_oGrid.Column9.Header1.Caption  = ""
            loc_oGrid.Column10.Header1.Caption = "NF"
            loc_oGrid.Column11.Header1.Caption = "Documento"

            *--------------------------------------------------------------------
            * BINDEVENTs para botoes
            *--------------------------------------------------------------------
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
            BINDEVENT(loc_oPagina.cmd_4c_Movimento,                 "Click", THIS, "BtnMovimentoClick")

            *-- BINDEVENTs para filtro de periodo
            BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtInicial, "KeyPress", THIS, "FiltroDataInicialLostFocus")
            BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtFinal,   "KeyPress", THIS, "FiltroDataFinalLostFocus")

            *-- Duplo clique no grid = Visualizar
            BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PAGE2 - DADOS/EDICAO
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 com todos os campos do legado
    * Posicoes da layout.json + 29 (compensacao PageFrame Top=-29, Tabs=.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *--------------------------------------------------------------------
            * Container botoes Confirmar/Cancelar (cabecalho direito - Top=29)
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 29
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Confirmar", "CommandButton")
                WITH .cmd_4c_Confirmar
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
                    .FontSize        = 8
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Cancelar", "CommandButton")
                WITH .cmd_4c_Cancelar
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
                    .FontSize        = 8
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * Shapes - separadores visuais (top legado + 29)
            * Shape1: Painel superior dados (top=153+29=182)
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPagina.shp_4c_Shape1
                .Top          = 182
                .Left         = 9
                .Width        = 980
                .Height       = 64
                .BackStyle    = 1
                .BackColor    = RGB(220, 220, 220)
                .FillStyle    = 0
                .FillColor    = RGB(220, 220, 220)
                .BorderStyle  = 1
                .SpecialEffect = 0
                .Visible      = .T.
            ENDWITH

            *-- Shape3: Painel movimento esquerdo (top=224+29=253)
            loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
            WITH loc_oPagina.shp_4c_Shape3
                .Top          = 253
                .Left         = 9
                .Width        = 485
                .Height       = 117
                .BackStyle    = 1
                .BackColor    = RGB(220, 220, 220)
                .FillStyle    = 0
                .FillColor    = RGB(220, 220, 220)
                .BorderStyle  = 1
                .SpecialEffect = 0
                .Visible      = .T.
            ENDWITH

            *-- Shape2: Painel movimento direito (top=224+29=253)
            loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
            WITH loc_oPagina.shp_4c_Shape2
                .Top          = 253
                .Left         = 504
                .Width        = 485
                .Height       = 117
                .BackStyle    = 1
                .BackColor    = RGB(220, 220, 220)
                .FillStyle    = 0
                .FillColor    = RGB(220, 220, 220)
                .BorderStyle  = 1
                .SpecialEffect = 0
                .Visible      = .T.
            ENDWITH

            *-- Shape6: Painel historico (top=350+29=379)
            loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
            WITH loc_oPagina.shp_4c_Shape6
                .Top          = 379
                .Left         = 9
                .Width        = 980
                .Height       = 39
                .BackStyle    = 1
                .BackColor    = RGB(220, 220, 220)
                .FillStyle    = 0
                .FillColor    = RGB(220, 220, 220)
                .BorderStyle  = 1
                .SpecialEffect = 0
                .Visible      = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Labels - Say objects (top legado + 29)
            *--------------------------------------------------------------------
            *-- Say1 "Lancamento :" (top=165+29=194, left=43)
            loc_oPagina.AddObject("lbl_4c_Lancamento", "Label")
            WITH loc_oPagina.lbl_4c_Lancamento
                .Caption  = "Lan" + CHR(231) + "amento :"
                .Top      = 194
                .Left     = 43
                .Width    = 75
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say10 "Vencimento :" (top=165+29=194, left=234)
            loc_oPagina.AddObject("lbl_4c_Vencimento", "Label")
            WITH loc_oPagina.lbl_4c_Vencimento
                .Caption  = "Vencimento :"
                .Top      = 194
                .Left     = 234
                .Width    = 70
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say15 "Emissao :" (top=165+29=194, left=435)
            loc_oPagina.AddObject("lbl_4c_Emissao", "Label")
            WITH loc_oPagina.lbl_4c_Emissao
                .Caption  = "Emiss" + CHR(227) + "o :"
                .Top      = 194
                .Left     = 435
                .Width    = 55
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say7 "Nota Fiscal :" (top=165+29=194, left=615)
            loc_oPagina.AddObject("lbl_4c_NotaFiscal", "Label")
            WITH loc_oPagina.lbl_4c_NotaFiscal
                .Caption  = "Nota Fiscal :"
                .Top      = 194
                .Left     = 615
                .Width    = 70
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say6 "Usuario :" (top=165+29=194, left=818)
            loc_oPagina.AddObject("lbl_4c_Usuario", "Label")
            WITH loc_oPagina.lbl_4c_Usuario
                .Caption  = "Usu" + CHR(225) + "rio :"
                .Top      = 194
                .Left     = 818
                .Width    = 55
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say17 "Job :" (top=191+29=220, left=84)
            loc_oPagina.AddObject("lbl_4c_Job", "Label")
            WITH loc_oPagina.lbl_4c_Job
                .Caption  = "Job :"
                .Top      = 220
                .Left     = 84
                .Width    = 30
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say2 "Documento :" (top=191+29=220, left=613)
            loc_oPagina.AddObject("lbl_4c_Documento", "Label")
            WITH loc_oPagina.lbl_4c_Documento
                .Caption  = "Documento :"
                .Top      = 220
                .Left     = 613
                .Width    = 65
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say3 "Movimento :" Esquerdo (top=235+29=264, left=49)
            loc_oPagina.AddObject("lbl_4c_MovEsq", "Label")
            WITH loc_oPagina.lbl_4c_MovEsq
                .Caption  = "Movimento :"
                .Top      = 264
                .Left     = 49
                .Width    = 70
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say18 "[D/C]" Esquerdo (top=235+29=264, left=130)
            loc_oPagina.AddObject("lbl_4c_DcEsq", "Label")
            WITH loc_oPagina.lbl_4c_DcEsq
                .Caption  = "[D/C]"
                .Top      = 264
                .Left     = 130
                .Width    = 30
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say11 "Movimento :" Direito (top=235+29=264, left=544)
            loc_oPagina.AddObject("lbl_4c_MovDir", "Label")
            WITH loc_oPagina.lbl_4c_MovDir
                .Caption  = "Movimento :"
                .Top      = 264
                .Left     = 544
                .Width    = 70
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say14 "[D/C]" Direito (top=235+29=264, left=626)
            loc_oPagina.AddObject("lbl_4c_DcDir", "Label")
            WITH loc_oPagina.lbl_4c_DcDir
                .Caption  = "[D/C]"
                .Top      = 264
                .Left     = 626
                .Width    = 30
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say4 "Grupo :" Esquerdo (top=261+29=290, left=72)
            loc_oPagina.AddObject("lbl_4c_GrupoEsq", "Label")
            WITH loc_oPagina.lbl_4c_GrupoEsq
                .Caption  = "Grupo :"
                .Top      = 290
                .Left     = 72
                .Width    = 40
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say12 "Grupo :" Direito (top=261+29=290, left=567)
            loc_oPagina.AddObject("lbl_4c_GrupoDir", "Label")
            WITH loc_oPagina.lbl_4c_GrupoDir
                .Caption  = "Grupo :"
                .Top      = 290
                .Left     = 567
                .Width    = 40
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say5 "Conta :" Esquerdo (top=287+29=316, left=72)
            loc_oPagina.AddObject("lbl_4c_ContaEsq", "Label")
            WITH loc_oPagina.lbl_4c_ContaEsq
                .Caption  = "Conta :"
                .Top      = 316
                .Left     = 72
                .Width    = 40
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say13 "Conta :" Direito (top=287+29=316, left=567)
            loc_oPagina.AddObject("lbl_4c_ContaDir", "Label")
            WITH loc_oPagina.lbl_4c_ContaDir
                .Caption  = "Conta :"
                .Top      = 316
                .Left     = 567
                .Width    = 40
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say8 "Valor :" Esquerdo (top=313+29=342, left=77)
            loc_oPagina.AddObject("lbl_4c_ValorEsq", "Label")
            WITH loc_oPagina.lbl_4c_ValorEsq
                .Caption  = "Valor :"
                .Top      = 342
                .Left     = 77
                .Width    = 35
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say16 "Valor :" Direito (top=313+29=342, left=572)
            loc_oPagina.AddObject("lbl_4c_ValorDir", "Label")
            WITH loc_oPagina.lbl_4c_ValorDir
                .Caption  = "Valor :"
                .Top      = 342
                .Left     = 572
                .Width    = 35
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say_Cotacao "Cambio :" Esquerdo (top=313+29=342, left=303)
            loc_oPagina.AddObject("lbl_4c_CotacaoEsq", "Label")
            WITH loc_oPagina.lbl_4c_CotacaoEsq
                .Caption  = "C" + CHR(226) + "mbio :"
                .Top      = 342
                .Left     = 303
                .Width    = 50
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say_sCotacao "Cambio :" Direito (top=313+29=342, left=797)
            loc_oPagina.AddObject("lbl_4c_CotacaoDir", "Label")
            WITH loc_oPagina.lbl_4c_CotacaoDir
                .Caption  = "C" + CHR(226) + "mbio :"
                .Top      = 342
                .Left     = 797
                .Width    = 50
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say9 "Historico :" (top=362+29=391, left=60)
            loc_oPagina.AddObject("lbl_4c_Historico", "Label")
            WITH loc_oPagina.lbl_4c_Historico
                .Caption  = "Hist" + CHR(243) + "rico :"
                .Top      = 391
                .Left     = 60
                .Width    = 55
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say19 "Lancar Contas :" (top=362+29=391, left=758)
            loc_oPagina.AddObject("lbl_4c_LancarContas", "Label")
            WITH loc_oPagina.lbl_4c_LancarContas
                .Caption  = "Lan" + CHR(231) + "ar Contas :"
                .Top      = 391
                .Left     = 758
                .Width    = 85
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Campos de data (top legado + 29)
            *--------------------------------------------------------------------
            *-- fweditdata_DATA "Lancamento" (top=161+29=190, left=112, width=80)
            loc_oPagina.AddObject("txt_4c_Data", "TextBox")
            WITH loc_oPagina.txt_4c_Data
                .Top      = 190
                .Left     = 112
                .Width    = 80
                .Height   = 21
                .Value    = {}
                .Format   = "D"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- fweditdata_VENC "Vencimento" (top=161+29=190, left=300, width=80)
            loc_oPagina.AddObject("txt_4c_Venc", "TextBox")
            WITH loc_oPagina.txt_4c_Venc
                .Top      = 190
                .Left     = 300
                .Width    = 80
                .Height   = 21
                .Value    = {}
                .Format   = "D"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- getDtEmis "Emissao" (top=161+29=190, left=484, width=80)
            loc_oPagina.AddObject("txt_4c_Emis", "TextBox")
            WITH loc_oPagina.txt_4c_Emis
                .Top      = 190
                .Left     = 484
                .Width    = 80
                .Height   = 21
                .Value    = {}
                .Format   = "D"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Campos textuais (top legado + 29)
            *--------------------------------------------------------------------
            *-- Get_Nota "Nota Fiscal" (top=161+29=190, left=678, width=80)
            loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
            WITH loc_oPagina.txt_4c_Nota
                .Top      = 190
                .Left     = 678
                .Width    = 80
                .Height   = 21
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- get_Usuario "Usuario" (top=161+29=190, left=865, width=80) - somente leitura
            loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
            WITH loc_oPagina.txt_4c_Usuario
                .Top      = 190
                .Left     = 865
                .Width    = 80
                .Height   = 21
                .Value    = SPACE(10)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- getJob "Job" (top=187+29=216, left=112, width=80)
            loc_oPagina.AddObject("txt_4c_Job", "TextBox")
            WITH loc_oPagina.txt_4c_Job
                .Top      = 216
                .Left     = 112
                .Width    = 80
                .Height   = 23
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- getDJob "Descricao Job" (top=187+29=216, left=195, width=290) - somente leitura
            loc_oPagina.AddObject("txt_4c_DJob", "TextBox")
            WITH loc_oPagina.txt_4c_DJob
                .Top      = 216
                .Left     = 195
                .Width    = 290
                .Height   = 23
                .Value    = SPACE(40)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_DOCU "Documento" (top=187+29=216, left=678, width=80)
            loc_oPagina.AddObject("txt_4c_Docu", "TextBox")
            WITH loc_oPagina.txt_4c_Docu
                .Top      = 216
                .Left     = 678
                .Width    = 80
                .Height   = 21
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Painel esquerdo (Movimento Debito)
            *--------------------------------------------------------------------
            *-- Get_OPER D/C esquerdo (top=231+29=260, left=112, width=15)
            loc_oPagina.AddObject("txt_4c_Oper", "TextBox")
            WITH loc_oPagina.txt_4c_Oper
                .Top      = 260
                .Left     = 112
                .Width    = 15
                .Height   = 21
                .Value    = SPACE(1)
                .MaxLength = 1
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_grupo esquerdo (top=257+29=286, left=112, width=80)
            loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
            WITH loc_oPagina.txt_4c_Grupo
                .Top      = 286
                .Left     = 112
                .Width    = 80
                .Height   = 23
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_dgrupo desc. Grupo esquerdo (top=257+29=286, left=195, width=290) - RO
            loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
            WITH loc_oPagina.txt_4c_DGrupo
                .Top      = 286
                .Left     = 195
                .Width    = 290
                .Height   = 23
                .Value    = SPACE(40)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_conta esquerdo (top=283+29=312, left=112, width=80)
            loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
            WITH loc_oPagina.txt_4c_Conta
                .Top      = 312
                .Left     = 112
                .Width    = 80
                .Height   = 21
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_dconta desc. Conta esquerdo (top=283+29=312, left=195, width=290) - RO
            loc_oPagina.AddObject("txt_4c_DcConta", "TextBox")
            WITH loc_oPagina.txt_4c_DcConta
                .Top      = 312
                .Left     = 195
                .Width    = 290
                .Height   = 21
                .Value    = SPACE(40)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_VALOR esquerdo (top=309+29=338, left=112, width=128)
            loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
            WITH loc_oPagina.txt_4c_Valor
                .Top      = 338
                .Left     = 112
                .Width    = 128
                .Height   = 23
                .Value    = 0.00
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_MOEDA esquerdo (top=309+29=338, left=243, width=31)
            loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
            WITH loc_oPagina.txt_4c_Moeda
                .Top      = 338
                .Left     = 243
                .Width    = 31
                .Height   = 21
                .Value    = SPACE(3)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_COTACAO esquerdo (top=309+29=338, left=349, width=108)
            loc_oPagina.AddObject("txt_4c_Cotacao", "TextBox")
            WITH loc_oPagina.txt_4c_Cotacao
                .Top      = 338
                .Left     = 349
                .Width    = 108
                .Height   = 21
                .Value    = 0.0000000
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- alteracotacao "$" esquerdo (top=309+29=338, left=461, width=24)
            loc_oPagina.AddObject("cmd_4c_AlteraCotacao", "CommandButton")
            WITH loc_oPagina.cmd_4c_AlteraCotacao
                .Caption       = "$"
                .Top           = 338
                .Left          = 461
                .Width         = 24
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(192, 192, 192)
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Painel direito (Movimento Credito)
            *--------------------------------------------------------------------
            *-- Get_SOPER D/C direito (top=231+29=260, left=607, width=15)
            loc_oPagina.AddObject("txt_4c_SOper", "TextBox")
            WITH loc_oPagina.txt_4c_SOper
                .Top      = 260
                .Left     = 607
                .Width    = 15
                .Height   = 21
                .Value    = SPACE(1)
                .MaxLength = 1
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_SGRUPO direito (top=257+29=286, left=607, width=80)
            loc_oPagina.AddObject("txt_4c_SGrupo", "TextBox")
            WITH loc_oPagina.txt_4c_SGrupo
                .Top      = 286
                .Left     = 607
                .Width    = 80
                .Height   = 23
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_sdgrupo desc. Grupo direito (top=257+29=286, left=689, width=290) - RO
            loc_oPagina.AddObject("txt_4c_SDGrupo", "TextBox")
            WITH loc_oPagina.txt_4c_SDGrupo
                .Top      = 286
                .Left     = 689
                .Width    = 290
                .Height   = 23
                .Value    = SPACE(40)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_SCONTA direito (top=283+29=312, left=607, width=80)
            loc_oPagina.AddObject("txt_4c_SConta", "TextBox")
            WITH loc_oPagina.txt_4c_SConta
                .Top      = 312
                .Left     = 607
                .Width    = 80
                .Height   = 21
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_SDCONTA desc. Conta direito (top=283+29=312, left=689, width=290) - RO
            loc_oPagina.AddObject("txt_4c_SDcConta", "TextBox")
            WITH loc_oPagina.txt_4c_SDcConta
                .Top      = 312
                .Left     = 689
                .Width    = 290
                .Height   = 21
                .Value    = SPACE(40)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_SVALOR direito (top=309+29=338, left=607, width=128)
            loc_oPagina.AddObject("txt_4c_SValor", "TextBox")
            WITH loc_oPagina.txt_4c_SValor
                .Top      = 338
                .Left     = 607
                .Width    = 128
                .Height   = 23
                .Value    = 0.00
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_smoeda direito (top=309+29=338, left=737, width=31)
            loc_oPagina.AddObject("txt_4c_SMoeda", "TextBox")
            WITH loc_oPagina.txt_4c_SMoeda
                .Top      = 338
                .Left     = 737
                .Width    = 31
                .Height   = 21
                .Value    = SPACE(3)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_SCOTACAO direito (top=309+29=338, left=843, width=108)
            loc_oPagina.AddObject("txt_4c_SCotacao", "TextBox")
            WITH loc_oPagina.txt_4c_SCotacao
                .Top      = 338
                .Left     = 843
                .Width    = 108
                .Height   = 21
                .Value    = 0.0000000
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- alterascotacao "$" direito (top=309+29=338, left=955, width=24)
            loc_oPagina.AddObject("cmd_4c_AlteraSCotacao", "CommandButton")
            WITH loc_oPagina.cmd_4c_AlteraSCotacao
                .Caption       = "$"
                .Top           = 338
                .Left          = 955
                .Width         = 24
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(192, 192, 192)
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Historico e Opcao
            *--------------------------------------------------------------------
            *-- Get_HIST "Historico" (top=358+29=387, left=112, width=300)
            loc_oPagina.AddObject("txt_4c_Hist", "TextBox")
            WITH loc_oPagina.txt_4c_Hist
                .Top      = 387
                .Left     = 112
                .Width    = 300
                .Height   = 21
                .Value    = SPACE(60)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_Hist2 "Historico 2" (top=358+29=387, left=415, width=300)
            loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
            WITH loc_oPagina.txt_4c_Hist2
                .Top      = 387
                .Left     = 415
                .Width    = 300
                .Height   = 21
                .Value    = SPACE(60)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Opcao_conta "Lancar Contas" (top=356+29=385, left=844, width=99, height=27)
            loc_oPagina.AddObject("opt_4c_OpcaoConta", "OptionGroup")
            WITH loc_oPagina.opt_4c_OpcaoConta
                .Top         = 385
                .Left        = 844
                .Width       = 99
                .Height      = 27
                .ButtonCount = 2
                .BorderStyle = 0
                .Themes      = .F.
                .Value       = 1
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Left      = 2
                    .Top       = 3
                    .Width     = 47
                    .Height    = 21
                    .AutoSize  = .F.
                    .ForeColor = RGB(0, 0, 0)
                    .Themes    = .F.
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Left      = 51
                    .Top       = 3
                    .Width     = 46
                    .Height    = 21
                    .AutoSize  = .F.
                    .ForeColor = RGB(0, 0, 0)
                    .Themes    = .F.
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * BINDEVENTs Page2
            *--------------------------------------------------------------------
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
            BINDEVENT(loc_oPagina.cmd_4c_AlteraCotacao,                "Click", THIS, "BtnAlteraCotacaoClick")
            BINDEVENT(loc_oPagina.cmd_4c_AlteraSCotacao,               "Click", THIS, "BtnAlteraSCotacaoClick")

            *-- Lookups LostFocus (valida codigo ao sair do campo)
            BINDEVENT(loc_oPagina.txt_4c_Grupo,   "KeyPress", THIS, "GrupoLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_Conta,   "KeyPress", THIS, "ContaLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_Moeda,   "KeyPress", THIS, "MoedaLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_SGrupo,  "KeyPress", THIS, "SGrupoLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_SConta,  "KeyPress", THIS, "SContaLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_SMoeda,  "KeyPress", THIS, "SMoedaLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_Valor,   "KeyPress", THIS, "ValorLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_Cotacao, "KeyPress", THIS, "CotacaoLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_SValor,  "KeyPress", THIS, "SValorLostFocus")

            *-- Job LostFocus + KeyPress
            BINDEVENT(loc_oPagina.txt_4c_Job,    "KeyPress", THIS, "JobLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_Job,    "KeyPress",  THIS, "JobKeyPress")

            *-- F4 KeyPress para abrir lookup (handler com LPARAMETERS obrigatorio)
            BINDEVENT(loc_oPagina.txt_4c_Grupo,  "KeyPress", THIS, "GrupoKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_Conta,  "KeyPress", THIS, "ContaKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_Moeda,  "KeyPress", THIS, "MoedaKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_SGrupo, "KeyPress", THIS, "SGrupoKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_SConta, "KeyPress", THIS, "SContaKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_SMoeda, "KeyPress", THIS, "SMoedaKeyPress")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CARGA DE DADOS E NAVEGACAO
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega movimentos no grid via cursor_4c_Dados (ZAP+APPEND)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_dInicio, loc_dFim
        LOCAL loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_dInicio = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value
                loc_dFim    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value

                *-- Datas obrigatorias: se vazias, limpa grid e sai (igual ao legado)
                IF EMPTY(loc_dInicio) OR EMPTY(loc_dFim)
                    ZAP IN cursor_4c_Dados
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ELSE
                    loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                        " AND a.Datas >= " + FormatarDataSQL(loc_dInicio) + ;
                        " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(loc_dFim) + ")"

                    loc_cSQL = "SELECT a.Datas, a.Opers, a.Contas, a.Scontas," + ;
                               " a.Hists, a.Valors, a.Svalors, a.Concs, a.Autos," + ;
                               " a.Nfs, a.Docus, a.Nopers, a.Cidchaves" + ;
                               " FROM SigMvCcr a" + ;
                               loc_cWhere + ;
                               " ORDER BY a.Datas, a.Nopers"

                    IF USED("cursor_4c_DadosTemp")
                        USE IN cursor_4c_DadosTemp
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

                    IF loc_nResult < 0
                        MsgErro("Erro ao carregar movimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        *-- ZAP + APPEND: preserva colunas do grid (nao destroi cursor_4c_Dados)
                        ZAP IN cursor_4c_Dados
                        SELECT cursor_4c_Dados
                        APPEND FROM DBF("cursor_4c_DadosTemp")
                        USE IN cursor_4c_DadosTemp

                        IF USED("cursor_4c_Dados")
                            GO TOP IN cursor_4c_Dados
                        ENDIF

                        *-- Reconfigurar headers (seguranca apos operacoes no cursor)
                        loc_oGrid.Column1.Header1.Caption  = "Data"
                        loc_oGrid.Column2.Header1.Caption  = "O"
                        loc_oGrid.Column3.Header1.Caption  = "Conta"
                        loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
                        loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
                        loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
                        loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
                        loc_oGrid.Column8.Header1.Caption  = ""
                        loc_oGrid.Column9.Header1.Caption  = ""
                        loc_oGrid.Column10.Header1.Caption = "NF"
                        loc_oGrid.Column11.Header1.Caption = "Documento"

                        THIS.FormatarGridLista(loc_oGrid)
                        loc_oGrid.Refresh()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgErro("Pagina invalida: " + TRANSFORM(par_nPagina), "AlternarPagina")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BOTOES PAGE1 - CRUD
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cChave = ALLTRIM(cursor_4c_Dados.Cidchaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                ELSE
                    MsgErro("Registro nao encontrado.", "Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Alterar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cChave = ALLTRIM(cursor_4c_Dados.Cidchaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                ELSE
                    MsgErro("Registro nao encontrado.", "Alterar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_lConfirmou
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Excluir")
            ELSE
                SELECT cursor_4c_Dados
                loc_cChave = ALLTRIM(cursor_4c_Dados.Cidchaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    loc_lConfirmou = MsgConfirma( ;
                        "Confirma a exclus" + CHR(227) + "o do movimento " + loc_cChave + "?", ;
                        "Excluir")

                    IF loc_lConfirmou
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgSucesso("Movimento exclu" + CHR(237) + "do com sucesso!")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ELSE
                    MsgErro("Registro nao encontrado.", "Excluir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarregar lista com filtro atual
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMovimentoClick - Abrir detalhe de movimento do registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnMovimentoClick()
        LOCAL loc_cChave
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para ver o movimento.", "Movimento")
            ELSE
                SELECT cursor_4c_Dados
                loc_cChave = ALLTRIM(cursor_4c_Dados.Cidchaves)

                IF EMPTY(loc_cChave)
                    MsgAviso("Registro sem chave de opera" + CHR(231) + CHR(227) + "o.", "Movimento")
                ELSE
                    THIS.this_cModoAtual = "VISUALIZAR"
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                        THIS.BOParaForm()
                        THIS.pgf_4c_Paginas.ActivePage = 2
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnMovimentoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOTOES PAGE2 - SALVAR / CANCELAR
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirmar inclusao ou alteracao
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSalvou, loc_oPagina
        loc_lSalvou = .F.
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Validacoes antes de salvar (equivalente ao legado Salva.Click)
            IF EMPTY(loc_oPagina.txt_4c_Data.Value)
                MsgAviso("Data inv" + CHR(225) + "lida.", "Salvar")
                loc_oPagina.txt_4c_Data.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_Oper.Value) OR ;
               !INLIST(UPPER(ALLTRIM(loc_oPagina.txt_4c_Oper.Value)), "D", "C")
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida! Use D ou C.", "Salvar")
                loc_oPagina.txt_4c_Oper.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_Grupo.Value)
                MsgAviso("Grupo inv" + CHR(225) + "lido.", "Salvar")
                loc_oPagina.txt_4c_Grupo.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_Conta.Value)
                MsgAviso("Conta inv" + CHR(225) + "lida.", "Salvar")
                loc_oPagina.txt_4c_Conta.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_Moeda.Value)
                MsgAviso("Moeda inv" + CHR(225) + "lida.", "Salvar")
                loc_oPagina.txt_4c_Moeda.SetFocus
                RETURN
            ENDIF

            IF loc_oPagina.txt_4c_Valor.Value = 0
                MsgAviso("Valor inv" + CHR(225) + "lido.", "Salvar")
                loc_oPagina.txt_4c_Valor.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_SOper.Value) OR ;
               !INLIST(UPPER(ALLTRIM(loc_oPagina.txt_4c_SOper.Value)), "D", "C")
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o de contrapartida inv" + CHR(225) + "lida! Use D ou C.", "Salvar")
                loc_oPagina.txt_4c_SOper.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_SGrupo.Value)
                MsgAviso("Grupo de contrapartida inv" + CHR(225) + "lido.", "Salvar")
                loc_oPagina.txt_4c_SGrupo.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_SConta.Value)
                MsgAviso("Conta de contrapartida inv" + CHR(225) + "lida.", "Salvar")
                loc_oPagina.txt_4c_SConta.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_SMoeda.Value)
                MsgAviso("Moeda de contrapartida inv" + CHR(225) + "lida.", "Salvar")
                loc_oPagina.txt_4c_SMoeda.SetFocus
                RETURN
            ENDIF

            IF loc_oPagina.txt_4c_SValor.Value = 0
                MsgAviso("Valor de contrapartida inv" + CHR(225) + "lido.", "Salvar")
                loc_oPagina.txt_4c_SValor.SetFocus
                RETURN
            ENDIF

            *-- Vencimento obrigatorio se Contapgs = Sim (Value = 1)
            IF loc_oPagina.opt_4c_OpcaoConta.Value = 1
                IF EMPTY(loc_oPagina.txt_4c_Venc.Value)
                    MsgAviso("Vencimento obrigat" + CHR(243) + "rio para contas a pagar.", "Salvar")
                    loc_oPagina.txt_4c_Venc.SetFocus
                    RETURN
                ENDIF
                IF loc_oPagina.txt_4c_Venc.Value < loc_oPagina.txt_4c_Data.Value
                    MsgAviso("Vencimento n" + CHR(227) + "o pode ser menor que a data de lan" + CHR(231) + "amento.", "Salvar")
                    loc_oPagina.txt_4c_Venc.SetFocus
                    RETURN
                ENDIF
            ENDIF

            *-- Mesma moeda: cotacoes devem ser iguais
            IF ALLTRIM(loc_oPagina.txt_4c_Moeda.Value) = ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)
                IF loc_oPagina.txt_4c_Cotacao.Value <> loc_oPagina.txt_4c_SCotacao.Value
                    MsgAviso("Cota" + CHR(231) + CHR(227) + "o inconsistente para mesma moeda!", "Salvar")
                    loc_oPagina.txt_4c_Moeda.SetFocus
                    RETURN
                ENDIF
            ENDIF

            *-- Lancamento para a mesma conta e grupo: invalido
            IF ALLTRIM(loc_oPagina.txt_4c_Grupo.Value) + ALLTRIM(loc_oPagina.txt_4c_Conta.Value) + ;
               ALLTRIM(loc_oPagina.txt_4c_Moeda.Value) = ;
               ALLTRIM(loc_oPagina.txt_4c_SGrupo.Value) + ALLTRIM(loc_oPagina.txt_4c_SConta.Value) + ;
               ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)
                MsgAviso("Lan" + CHR(231) + "amento inconsistente! Grupos+Contas+Moedas iguais.", "Salvar")
                loc_oPagina.txt_4c_Moeda.SetFocus
                RETURN
            ENDIF

            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    loc_lSalvou = .T.
                    MsgSucesso("Registro salvo com sucesso!")
                    THIS.AlternarPagina(1)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar edicao e retornar a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_oBusinessObject.CancelarEdicao()
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DADOS - FormParaBO / BOParaForm
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Le campos da Page2 e preenche propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oPagina, loc_oBO
        loc_lSucesso = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oBO     = THIS.this_oBusinessObject

            loc_oBO.this_dDatas     = loc_oPagina.txt_4c_Data.Value
            loc_oBO.this_dVencs     = loc_oPagina.txt_4c_Venc.Value
            loc_oBO.this_dDtemis    = loc_oPagina.txt_4c_Emis.Value
            loc_oBO.this_cNfs       = ALLTRIM(loc_oPagina.txt_4c_Nota.Value)
            loc_oBO.this_cDocus     = ALLTRIM(loc_oPagina.txt_4c_Docu.Value)
            loc_oBO.this_cJobs      = ALLTRIM(loc_oPagina.txt_4c_Job.Value)
            loc_oBO.this_cOpers     = ALLTRIM(loc_oPagina.txt_4c_Oper.Value)
            loc_oBO.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            loc_oBO.this_cContas    = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            loc_oBO.this_cMoedas    = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
            loc_oBO.this_nValors    = loc_oPagina.txt_4c_Valor.Value
            loc_oBO.this_nCotacaos  = loc_oPagina.txt_4c_Cotacao.Value
            loc_oBO.this_cSopers    = ALLTRIM(loc_oPagina.txt_4c_SOper.Value)
            loc_oBO.this_cSgrupos   = ALLTRIM(loc_oPagina.txt_4c_SGrupo.Value)
            loc_oBO.this_cScontas   = ALLTRIM(loc_oPagina.txt_4c_SConta.Value)
            loc_oBO.this_cSmoedas   = ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)
            loc_oBO.this_nSvalors   = loc_oPagina.txt_4c_SValor.Value
            loc_oBO.this_nScotacaos = loc_oPagina.txt_4c_SCotacao.Value
            loc_oBO.this_cHists     = ALLTRIM(loc_oPagina.txt_4c_Hist.Value)
            loc_oBO.this_cHist2s    = ALLTRIM(loc_oPagina.txt_4c_Hist2.Value)

            *-- OptionGroup: Value 1=Sim(contapgs=1), Value 2=Nao(contapgs=0)
            loc_oBO.this_nContapgs = IIF(loc_oPagina.opt_4c_OpcaoConta.Value = 1, 1, 0)

            *-- Empresa e usuario logado
            loc_oBO.this_cEmps    = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_oBO.this_cUsualts = ALLTRIM(gc_4c_UsuarioLogado)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Preenche campos da Page2 com propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oPagina, loc_oBO
        loc_lSucesso = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oBO     = THIS.this_oBusinessObject

            loc_oPagina.txt_4c_Data.Value    = loc_oBO.this_dDatas
            loc_oPagina.txt_4c_Venc.Value    = loc_oBO.this_dVencs
            loc_oPagina.txt_4c_Emis.Value    = loc_oBO.this_dDtemis
            loc_oPagina.txt_4c_Nota.Value    = PADR(ALLTRIM(loc_oBO.this_cNfs), 10)
            loc_oPagina.txt_4c_Docu.Value    = PADR(ALLTRIM(loc_oBO.this_cDocus), 10)
            loc_oPagina.txt_4c_Job.Value     = PADR(ALLTRIM(loc_oBO.this_cJobs), 10)
            loc_oPagina.txt_4c_Oper.Value    = PADR(ALLTRIM(loc_oBO.this_cOpers), 1)
            loc_oPagina.txt_4c_Grupo.Value   = PADR(ALLTRIM(loc_oBO.this_cGrupos), 10)
            loc_oPagina.txt_4c_Conta.Value   = PADR(ALLTRIM(loc_oBO.this_cContas), 10)
            loc_oPagina.txt_4c_Moeda.Value   = PADR(ALLTRIM(loc_oBO.this_cMoedas), 3)
            loc_oPagina.txt_4c_Valor.Value   = loc_oBO.this_nValors
            loc_oPagina.txt_4c_Cotacao.Value = loc_oBO.this_nCotacaos
            loc_oPagina.txt_4c_SOper.Value   = PADR(ALLTRIM(loc_oBO.this_cSopers), 1)
            loc_oPagina.txt_4c_SGrupo.Value  = PADR(ALLTRIM(loc_oBO.this_cSgrupos), 10)
            loc_oPagina.txt_4c_SConta.Value  = PADR(ALLTRIM(loc_oBO.this_cScontas), 10)
            loc_oPagina.txt_4c_SMoeda.Value  = PADR(ALLTRIM(loc_oBO.this_cSmoedas), 3)
            loc_oPagina.txt_4c_SValor.Value  = loc_oBO.this_nSvalors
            loc_oPagina.txt_4c_SCotacao.Value = loc_oBO.this_nScotacaos
            loc_oPagina.txt_4c_Hist.Value    = PADR(ALLTRIM(loc_oBO.this_cHists), 60)
            loc_oPagina.txt_4c_Hist2.Value   = PADR(ALLTRIM(loc_oBO.this_cHist2s), 60)
            loc_oPagina.txt_4c_Usuario.Value = PADR(ALLTRIM(loc_oBO.this_cUsualts), 10)

            *-- OptionGroup: contapgs >= 1 = Sim, 0 = Nao
            loc_oPagina.opt_4c_OpcaoConta.Value = IIF(loc_oBO.this_nContapgs >= 1, 1, 2)

            *-- Carregar descricoes dos codigos (grupo, conta)
            THIS.CarregarDescricoesGruposConta(loc_oBO)

            *-- Habilitar/desabilitar campos conforme modo
            THIS.HabilitarCamposDados(THIS.this_cModoAtual != "VISUALIZAR")

            *-- Ajustar botoes conforme modo
            THIS.AjustarBotoesPorModo()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricoesGruposConta - Busca descricoes de codigos no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescricoesGruposConta(par_oBO)
        LOCAL loc_oPagina, loc_nRes, loc_cCod

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Descricao Grupo esquerdo (SigCdGcr.codigos/descrs)
            loc_cCod = ALLTRIM(par_oBO.this_cGrupos)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpDesc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
                    SELECT cursor_4c_TmpDesc
                    loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
                ENDIF
                IF USED("cursor_4c_TmpDesc")
                    USE IN cursor_4c_TmpDesc
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
            ENDIF

            *-- Descricao Conta esquerdo (SigCdCli: Iclis=codigo, Rclis=nome)
            loc_cCod = ALLTRIM(par_oBO.this_cContas)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpDesc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
                    SELECT cursor_4c_TmpDesc
                    loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
                ENDIF
                IF USED("cursor_4c_TmpDesc")
                    USE IN cursor_4c_TmpDesc
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
            ENDIF

            *-- Descricao Grupo direito
            loc_cCod = ALLTRIM(par_oBO.this_cSgrupos)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpDesc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
                    SELECT cursor_4c_TmpDesc
                    loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
                ENDIF
                IF USED("cursor_4c_TmpDesc")
                    USE IN cursor_4c_TmpDesc
                ENDIF
            ELSE
                loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
            ENDIF

            *-- Descricao Conta direito (SigCdCli: Iclis=codigo, Rclis=nome)
            loc_cCod = ALLTRIM(par_oBO.this_cScontas)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpDesc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
                    SELECT cursor_4c_TmpDesc
                    loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
                ENDIF
                IF USED("cursor_4c_TmpDesc")
                    USE IN cursor_4c_TmpDesc
                ENDIF
            ELSE
                loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
            ENDIF

            *-- Descricao Job (SigCdCli: Iclis=codigo, Rclis=nome - mesmo que Conta)
            loc_cCod = ALLTRIM(par_oBO.this_cJobs)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpDesc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
                    SELECT cursor_4c_TmpDesc
                    loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DJob.Value = SPACE(40)
                ENDIF
                IF USED("cursor_4c_TmpDesc")
                    USE IN cursor_4c_TmpDesc
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DJob.Value = SPACE(40)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarDescricoesGruposConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCamposDados - Habilita ou desabilita campos de edicao da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCamposDados(par_lHabilitar)
        LOCAL loc_oPagina, loc_lRO

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_lRO     = !par_lHabilitar

            loc_oPagina.txt_4c_Data.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Venc.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Emis.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Nota.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Docu.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Job.ReadOnly      = loc_lRO
            loc_oPagina.txt_4c_Oper.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Grupo.ReadOnly    = loc_lRO
            loc_oPagina.txt_4c_Conta.ReadOnly    = loc_lRO
            loc_oPagina.txt_4c_Moeda.ReadOnly    = loc_lRO
            loc_oPagina.txt_4c_Valor.ReadOnly    = loc_lRO
            loc_oPagina.txt_4c_Cotacao.ReadOnly  = loc_lRO
            loc_oPagina.txt_4c_SOper.ReadOnly    = loc_lRO
            loc_oPagina.txt_4c_SGrupo.ReadOnly   = loc_lRO
            loc_oPagina.txt_4c_SConta.ReadOnly   = loc_lRO
            loc_oPagina.txt_4c_SMoeda.ReadOnly   = loc_lRO
            loc_oPagina.txt_4c_SValor.ReadOnly   = loc_lRO
            loc_oPagina.txt_4c_SCotacao.ReadOnly = loc_lRO
            loc_oPagina.txt_4c_Hist.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Hist2.ReadOnly    = loc_lRO

            loc_oPagina.opt_4c_OpcaoConta.Enabled      = par_lHabilitar
            loc_oPagina.cmd_4c_AlteraCotacao.Enabled   = par_lHabilitar
            loc_oPagina.cmd_4c_AlteraSCotacao.Enabled  = par_lHabilitar
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCamposDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera todos os campos de edicao da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            loc_oPagina.txt_4c_Data.Value    = {}
            loc_oPagina.txt_4c_Venc.Value    = {}
            loc_oPagina.txt_4c_Emis.Value    = {}
            loc_oPagina.txt_4c_Nota.Value    = SPACE(10)
            loc_oPagina.txt_4c_Docu.Value    = SPACE(10)
            loc_oPagina.txt_4c_Job.Value     = SPACE(10)
            loc_oPagina.txt_4c_DJob.Value    = SPACE(40)
            loc_oPagina.txt_4c_Oper.Value    = SPACE(1)
            loc_oPagina.txt_4c_Grupo.Value   = SPACE(10)
            loc_oPagina.txt_4c_DGrupo.Value  = SPACE(40)
            loc_oPagina.txt_4c_Conta.Value   = SPACE(10)
            loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
            loc_oPagina.txt_4c_Moeda.Value   = SPACE(3)
            loc_oPagina.txt_4c_Valor.Value   = 0
            loc_oPagina.txt_4c_Cotacao.Value = 0
            loc_oPagina.txt_4c_SOper.Value   = SPACE(1)
            loc_oPagina.txt_4c_SGrupo.Value  = SPACE(10)
            loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
            loc_oPagina.txt_4c_SConta.Value  = SPACE(10)
            loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
            loc_oPagina.txt_4c_SMoeda.Value  = SPACE(3)
            loc_oPagina.txt_4c_SValor.Value  = 0
            loc_oPagina.txt_4c_SCotacao.Value = 0
            loc_oPagina.txt_4c_Hist.Value    = SPACE(60)
            loc_oPagina.txt_4c_Hist2.Value   = SPACE(60)
            loc_oPagina.txt_4c_Usuario.Value = SPACE(10)
            loc_oPagina.opt_4c_OpcaoConta.Value = 2  && Nao (default)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    * Modos: INCLUIR (campos editaveis), ALTERAR (campos editaveis),
    *        VISUALIZAR (somente leitura), LISTA (na Page1)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEdicao, loc_oPagina
        TRY
            loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Confirmar: habilitado somente em INCLUIR ou ALTERAR
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao

            *-- Cancelar: sempre habilitado quando na Page2
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.

            *-- Botoes de cotacao: somente em edicao
            IF PEMSTATUS(loc_oPagina, "cmd_4c_AlteraCotacao", 5)
                loc_oPagina.cmd_4c_AlteraCotacao.Enabled  = loc_lEdicao
                loc_oPagina.cmd_4c_AlteraSCotacao.Enabled = loc_lEdicao
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LOOKUPS - GRUPO / CONTA / MOEDA (esquerdo e direito)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Busca de Grupo financeiro em SigCdGcr (lado esquerdo)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Busca", "codigos", loc_cValor, ;
                "Busca de Grupo Financeiro")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_Grupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
                        loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_Grupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
                            loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSGrupo - Busca de Grupo financeiro em SigCdGcr (lado direito)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSGrupo()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_SGrupo.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Busca", "codigos", loc_cValor, ;
                "Busca de Grupo Financeiro")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_SGrupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
                        loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_SGrupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
                            loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupSGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - Busca de Conta em SigCdCli (lado esquerdo)
    * Legado usa fAcessoContas que busca em SigCdCli (Iclis=PK, Rclis=nome)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConta()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_Busca", "Iclis", loc_cValor, ;
                "Busca de Conta")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_Conta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                        loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_Conta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                            loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSConta - Busca de Conta em SigCdCli (lado direito)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSConta()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_SConta.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_Busca", "Iclis", loc_cValor, ;
                "Busca de Conta")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_SConta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                        loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_SConta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                            loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupSConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda - Busca de Moeda em SigCdMoe (lado esquerdo)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Busca", "cmoes", loc_cValor, ;
                "Busca de Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_Moeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_Moeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSMoeda - Busca de Moeda em SigCdMoe (lado direito)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSMoeda()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Busca", "cmoes", loc_cValor, ;
                "Busca de Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_SMoeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_SMoeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupSMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupJob - Busca de Job/Projeto em SigCdCli (Iclis/Rclis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupJob()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Job.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_Busca", "Iclis", loc_cValor, ;
                "Busca de Job/Projeto")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_Job.Value  = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                        loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_Job.Value  = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                            loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupJob")
        ENDTRY
    ENDPROC

    *==========================================================================
    * EVENT HANDLERS - LOOKUP (LostFocus e KeyPress)
    * DEVEM SER PUBLIC (BINDEVENT exige metodos publicos)
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrupoLostFocus - Valida e carrega descricao do Grupo esquerdo
    *--------------------------------------------------------------------------
    PROCEDURE GrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpGrupo")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpGrupo") > 0
                    SELECT cursor_4c_TmpGrupo
                    loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
                    MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCod, "Grupo")
                    loc_oPagina.txt_4c_Grupo.Value = SPACE(10)
                ENDIF
                IF USED("cursor_4c_TmpGrupo")
                    USE IN cursor_4c_TmpGrupo
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GrupoLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoKeyPress - F4 abre lookup de Grupo esquerdo
    *--------------------------------------------------------------------------
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaLostFocus - Valida e carrega descricao da Conta esquerda (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE ContaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpConta")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpConta") > 0
                    SELECT cursor_4c_TmpConta
                    loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
                    MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cCod, "Conta")
                    loc_oPagina.txt_4c_Conta.Value = SPACE(10)
                ENDIF
                IF USED("cursor_4c_TmpConta")
                    USE IN cursor_4c_TmpConta
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ContaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaKeyPress - F4 abre lookup de Conta esquerda
    *--------------------------------------------------------------------------
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaLostFocus - Valida Moeda esquerda em SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE MoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpMoeda")
                IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_TmpMoeda") = 0
                    MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Moeda")
                    loc_oPagina.txt_4c_Moeda.Value = SPACE(3)
                ENDIF
                IF USED("cursor_4c_TmpMoeda")
                    USE IN cursor_4c_TmpMoeda
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MoedaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaKeyPress - F4 abre lookup de Moeda esquerda
    *--------------------------------------------------------------------------
    PROCEDURE MoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SGrupoLostFocus - Valida e carrega descricao do Grupo direito
    *--------------------------------------------------------------------------
    PROCEDURE SGrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SGrupo.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpSGrupo")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpSGrupo") > 0
                    SELECT cursor_4c_TmpSGrupo
                    loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
                    MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCod, "Grupo")
                    loc_oPagina.txt_4c_SGrupo.Value = SPACE(10)
                ENDIF
                IF USED("cursor_4c_TmpSGrupo")
                    USE IN cursor_4c_TmpSGrupo
                ENDIF
            ELSE
                loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SGrupoLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SGrupoKeyPress - F4 abre lookup de Grupo direito
    *--------------------------------------------------------------------------
    PROCEDURE SGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupSGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SContaLostFocus - Valida e carrega descricao da Conta direita (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE SContaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SConta.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpSConta")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpSConta") > 0
                    SELECT cursor_4c_TmpSConta
                    loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
                    MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cCod, "Conta")
                    loc_oPagina.txt_4c_SConta.Value = SPACE(10)
                ENDIF
                IF USED("cursor_4c_TmpSConta")
                    USE IN cursor_4c_TmpSConta
                ENDIF
            ELSE
                loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SContaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SContaKeyPress - F4 abre lookup de Conta direita
    *--------------------------------------------------------------------------
    PROCEDURE SContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupSConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SMoedaLostFocus - Valida Moeda direita em SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE SMoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpSMoeda")
                IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_TmpSMoeda") = 0
                    MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Moeda")
                    loc_oPagina.txt_4c_SMoeda.Value = SPACE(3)
                ENDIF
                IF USED("cursor_4c_TmpSMoeda")
                    USE IN cursor_4c_TmpSMoeda
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SMoedaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SMoedaKeyPress - F4 abre lookup de Moeda direita
    *--------------------------------------------------------------------------
    PROCEDURE SMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupSMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * JobLostFocus - Valida Job e carrega descricao (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE JobLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Job.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpJob")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpJob") > 0
                    SELECT cursor_4c_TmpJob
                    loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DJob.Value = SPACE(40)
                    MsgAviso("Job n" + CHR(227) + "o encontrado: " + loc_cCod, "Job")
                    loc_oPagina.txt_4c_Job.Value = SPACE(10)
                ENDIF
                IF USED("cursor_4c_TmpJob")
                    USE IN cursor_4c_TmpJob
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DJob.Value = SPACE(40)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "JobLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * JobKeyPress - F4 abre lookup de Job
    *--------------------------------------------------------------------------
    PROCEDURE JobKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupJob()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValorLostFocus - Ao sair de Valor, calcula Svalors se moeda for R (Real)
    * Legado: get_conta.Valid busca saldo em SigMvSlc e propoe complemento
    *--------------------------------------------------------------------------
    PROCEDURE ValorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_nValor, loc_cOper
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_nValor  = loc_oPagina.txt_4c_Valor.Value
            loc_cOper   = ALLTRIM(loc_oPagina.txt_4c_Oper.Value)

            *-- Propor operacao inversa no lado direito se SOper vazio
            IF !EMPTY(loc_cOper) AND EMPTY(ALLTRIM(loc_oPagina.txt_4c_SOper.Value))
                loc_oPagina.txt_4c_SOper.Value  = IIF(UPPER(loc_cOper) = "D", "C", "D")
                loc_oPagina.txt_4c_SValor.Value = loc_nValor
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValorLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CotacaoLostFocus - Recalcula Svalors baseado na cotacao do Real
    *--------------------------------------------------------------------------
    PROCEDURE CotacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_nValor, loc_nCotacao
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_nValor   = loc_oPagina.txt_4c_Valor.Value
            loc_nCotacao = loc_oPagina.txt_4c_Cotacao.Value

            IF loc_nCotacao > 0
                loc_oPagina.txt_4c_SValor.Value = ROUND(loc_nValor * loc_nCotacao, 2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CotacaoLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SValorLostFocus - Recalcula SCotacao baseado nos valores
    *--------------------------------------------------------------------------
    PROCEDURE SValorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_nValor, loc_nSValor
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_nValor  = loc_oPagina.txt_4c_Valor.Value
            loc_nSValor = loc_oPagina.txt_4c_SValor.Value

            IF loc_nValor > 0 AND loc_nSValor > 0
                loc_oPagina.txt_4c_SCotacao.Value = ROUND(loc_nSValor / loc_nValor, 7)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SValorLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraCotacaoClick - Alterar cotacao/moeda (painel esquerdo)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraCotacaoClick()
        TRY
            THIS.AbrirLookupMoeda()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlteraCotacaoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraSCotacaoClick - Alterar cotacao/moeda (painel direito)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraSCotacaoClick()
        TRY
            THIS.AbrirLookupSMoeda()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlteraSCotacaoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FILTRO DE PERIODO
    *==========================================================================

    *--------------------------------------------------------------------------
    * FiltroDataInicialLostFocus - Sincroniza datas: se inicial > final, ajusta final
    *--------------------------------------------------------------------------
    PROCEDURE FiltroDataInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_dInicio, loc_dFim, loc_oFiltro
        TRY
            loc_oFiltro = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
            loc_dInicio = loc_oFiltro.txt_4c_DtInicial.Value
            loc_dFim    = loc_oFiltro.txt_4c_DtFinal.Value

            IF !EMPTY(loc_dInicio) AND !EMPTY(loc_dFim)
                IF loc_dInicio > loc_dFim
                    loc_oFiltro.txt_4c_DtFinal.Value = loc_dInicio
                    loc_oFiltro.txt_4c_DtFinal.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FiltroDataInicialLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroDataFinalLostFocus - Sincroniza datas e recarrega grid
    *--------------------------------------------------------------------------
    PROCEDURE FiltroDataFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_dInicio, loc_dFim, loc_oFiltro
        TRY
            loc_oFiltro = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
            loc_dInicio = loc_oFiltro.txt_4c_DtInicial.Value
            loc_dFim    = loc_oFiltro.txt_4c_DtFinal.Value

            IF !EMPTY(loc_dFim) AND !EMPTY(loc_dInicio)
                IF loc_dFim < loc_dInicio
                    loc_oFiltro.txt_4c_DtInicial.Value = loc_dFim
                    loc_oFiltro.txt_4c_DtInicial.Refresh()
                ENDIF
            ENDIF

            IF THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FiltroDataFinalLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AUXILIARES
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Verdana"
                .FontSize = 8
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormatarGridLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Filtra por nome (_4c_) para nao afetar containers flutuantes (Visible=.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = LOWER(loc_oObjeto.Name)
                IF "_4c_" $ loc_cNome OR "lbl_" $ loc_cNome OR "shp_" $ loc_cNome
                    IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                        loc_oObjeto.Visible = .T.
                    ENDIF
                ENDIF
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
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
        IF USED("cursor_4c_DadosTemp")
            USE IN cursor_4c_DadosTemp
        ENDIF
        IF USED("cursor_4c_TmpDesc")
            USE IN cursor_4c_TmpDesc
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
