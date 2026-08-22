*==========================================================================
* FormOpt.prg - Movimentacoes de Cheques (SIGCDOPT)
* Migrado de: SIGCDOPT (frmcadastro)
* Tabela: SigCdOpt | BO: OptBO | Task: task488
* Fase 4/8: Grid e Botoes CRUD (Page1)
*==========================================================================

DEFINE CLASS FormOpt AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY - SIGCDOPT Width=1000, Height=600)
    Height      = 600
    Width       = 1000
    Caption     = "Movimenta" + CHR(231) + CHR(245) + "es de Cheques"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    MaxButton   = .F.
    Closable    = .F.
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() chama InicializarForm() automaticamente
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, configura PageFrame e define modo inicial
    * Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("OptBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar OptBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormOpt.InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormOpt:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormOpt.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame com 2 paginas (Lista e Dados)
    * Top=-29 oculta as abas; controles compensam +29 no Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount       = 2
            .Top             = -29
            .Left            = 0
            .Width           = THIS.Width
            .Height          = THIS.Height + 29
            .Tabs            = .F.
            .Visible         = .T.
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

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid
    * Colunas do grid: Operacaos/Tipos/OpAnts/GrupoOs conforme legado Init
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado: top=2+29=31)
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
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es de Cheques"
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
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
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es de Cheques"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op: top=0+29=29, left=542)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 385
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

        *-- Container Saida (padrao canonico: Left=917, Width=90, cmd Width=75)
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

        *-- Grid da lista (colunas do legado: Movimento/Tipo/Mv.Anterior/Grupo-Ori)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista

        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 4

        WITH loc_oGrid
            .Top                = 117
            .Left               = 4
            .Width              = 992
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Header1.Caption = "Movimento"
            .Width           = 140
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column2
            .Header1.Caption = "Tipo"
            .Width           = 60
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column3
            .Header1.Caption = "Mv. Anterior"
            .Width           = 140
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column4
            .Header1.Caption = "Grupo/Ori"
            .Width           = 80
            .ReadOnly        = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: todos os campos SIGCDOPT
    * Fase 5/8: BotoesAcao + campos top<=248 (ate Line2) + BINDEVENTs
    * Todos os Tops recebem +29 (compensacao PageFrame.Top=-29)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao (Grupo_Salva: top=4+29=33, left=842)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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

        *-- CheckBox: Inativa (fwcheckbox1 - top=15+29=44, left=299)
        loc_oPagina.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox1
            .Caption   = "Inativa"
            .Top       = 44
            .Left      = 299
            .Width     = 60
            .Height    = 20
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Linha 1: Codigo / Descricao / Tipo (top original=12-16; comp.=41-45)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 45
            .Left      = 100
            .Width     = 43
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 41
            .Left      = 146
            .Width     = 150
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 45
            .Left      = 395
            .Width     = 56
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value     = ""
            .Top       = 41
            .Left      = 454
            .Width     = 150
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Tipo :"
            .Top       = 45
            .Left      = 679
            .Width     = 34
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tipo", "TextBox")
        WITH loc_oPagina.txt_4c_Tipo
            .Value     = ""
            .Top       = 41
            .Left      = 712
            .Width     = 24
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "(CR/DB)"
            .Top       = 45
            .Left      = 745
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Linha 2: Mov.Anterior / Mov.Titulos / Ordem (top orig=37-41; comp.=66-70)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Movimento Anterior :"
            .Top       = 70
            .Left      = 39
            .Width     = 103
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OpAnts", "TextBox")
        WITH loc_oPagina.txt_4c_OpAnts
            .Value     = ""
            .Top       = 66
            .Left      = 146
            .Width     = 150
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_OpAnts, "KeyPress", THIS, "ValidarOpAnts")

        loc_oPagina.AddObject("lbl_4c_Label35", "Label")
        WITH loc_oPagina.lbl_4c_Label35
            .Caption   = "Movimento de T" + CHR(237) + "tulos :"
            .Top       = 70
            .Left      = 340
            .Width     = 110
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OpContas", "TextBox")
        WITH loc_oPagina.txt_4c_OpContas
            .Value     = ""
            .Top       = 66
            .Left      = 454
            .Width     = 150
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_OpContas, "KeyPress", THIS, "ValidarOpContas")

        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Ordem :"
            .Top       = 70
            .Left      = 667
            .Width     = 41
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
        WITH loc_oPagina.txt_4c_Ordem
            .Value     = 0
            .Top       = 66
            .Left      = 712
            .Width     = 50
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Linha 3: Mov.Entrada / Mov.Automatico / Opc_TipoData (top orig=62-66; comp.=91-95)
        loc_oPagina.AddObject("lbl_4c_Label67", "Label")
        WITH loc_oPagina.lbl_4c_Label67
            .Caption   = "Movimento de Entrada :"
            .Top       = 95
            .Left      = 25
            .Width     = 117
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OpEntrada", "TextBox")
        WITH loc_oPagina.txt_4c_OpEntrada
            .Value     = ""
            .Top       = 91
            .Left      = 146
            .Width     = 150
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_OpEntrada, "KeyPress", THIS, "ValidarOpEntrada")

        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Movimento Autom" + CHR(225) + "tico :"
            .Top       = 95
            .Left      = 332
            .Width     = 120
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OpAut", "TextBox")
        WITH loc_oPagina.txt_4c_OpAut
            .Value     = ""
            .Top       = 91
            .Left      = 454
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_OpAut, "InteractiveChange", THIS, "AtualizarEstadoTipoData")

        *-- OptionGroup: Opc_TipoData (4 botoes; top=62+29=91, left=471, w=340)
        loc_oPagina.AddObject("obj_4c_Opc_TipoData", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_TipoData
            .ButtonCount = 4
            .Top         = 91
            .Left        = 471
            .Width       = 340
            .Height      = 22
            .BackStyle   = 0
            .BorderStyle = 0
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_TipoData.Buttons(1)
            .Caption   = "Emiss" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 3
            .Top       = 2
            .Width     = 70
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_TipoData.Buttons(2)
            .Caption   = "Vencimento"
            .BackStyle = 0
            .Left      = 80
            .Top       = 2
            .Width     = 75
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_TipoData.Buttons(3)
            .Caption   = "Transa" + CHR(231) + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 162
            .Top       = 2
            .Width     = 80
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_TipoData.Buttons(4)
            .Caption   = "Nenhum"
            .BackStyle = 0
            .Left      = 250
            .Top       = 2
            .Width     = 70
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Linha 4: Cond.Pagto / Historico Padrao / OpTpHists (top orig=86-91; comp.=115-120)
        loc_oPagina.AddObject("lbl_4c_Label65", "Label")
        WITH loc_oPagina.lbl_4c_Label65
            .Caption   = "Condi" + CHR(231) + CHR(227) + "o de Pagto :"
            .Top       = 120
            .Left      = 43
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fpg", "TextBox")
        WITH loc_oPagina.txt_4c_Fpg
            .Value     = ""
            .Top       = 116
            .Left      = 146
            .Width     = 94
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Fpg, "KeyPress", THIS, "ValidarFpg")

        loc_oPagina.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oPagina.lbl_4c_Label28
            .Caption   = "Hist" + CHR(243) + "rico Padr" + CHR(227) + "o :"
            .Top       = 120
            .Left      = 363
            .Width     = 85
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Hists", "TextBox")
        WITH loc_oPagina.txt_4c_Hists
            .Value     = ""
            .Top       = 116
            .Left      = 454
            .Width     = 220
            .Height    = 23
            .MaxLength = 100
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup: OpTpHists (2 botoes; top=86+29=115, left=670, w=145)
        loc_oPagina.AddObject("obj_4c_OpTpHists", "OptionGroup")
        WITH loc_oPagina.obj_4c_OpTpHists
            .ButtonCount = 2
            .Top         = 115
            .Left        = 670
            .Width       = 145
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OpTpHists.Buttons(1)
            .Caption   = "Padr" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 60
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_OpTpHists.Buttons(2)
            .Caption   = "Livre"
            .BackStyle = 0
            .Left      = 72
            .Top       = 3
            .Width     = 50
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Linha 5: Grupo Emissor / Tipo Emissor (top orig=112-116; comp.=141-145)
        loc_oPagina.AddObject("lbl_4c_Label49", "Label")
        WITH loc_oPagina.lbl_4c_Label49
            .Caption   = "Grupo Emissor Default :"
            .Top       = 145
            .Left      = 27
            .Width     = 115
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Hispad", "TextBox")
        WITH loc_oPagina.txt_4c_Hispad
            .Value     = ""
            .Top       = 141
            .Left      = 146
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Hispad, "KeyPress", THIS, "ValidarHispad")

        loc_oPagina.AddObject("lbl_4c_Label61", "Label")
        WITH loc_oPagina.lbl_4c_Label61
            .Caption   = "Tipo do Emissor :"
            .Top       = 145
            .Left      = 367
            .Width     = 83
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup: Opc_tpemissor (2 botoes; top=112+29=141, left=447, w=151)
        loc_oPagina.AddObject("obj_4c_Opc_tpemissor", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_tpemissor
            .ButtonCount = 2
            .Top         = 141
            .Left        = 447
            .Width       = 151
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_tpemissor.Buttons(1)
            .Caption   = "Normal"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 60
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_tpemissor.Buttons(2)
            .Caption   = "Terceiro"
            .BackStyle = 0
            .Left      = 72
            .Top       = 3
            .Width     = 65
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Linha 6: Situacao / Responsavel / Central de Credito (top orig=137-141; comp.=166-170)
        loc_oPagina.AddObject("lbl_4c_Label60", "Label")
        WITH loc_oPagina.lbl_4c_Label60
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o do Cliente :"
            .Top       = 170
            .Left      = 41
            .Width     = 101
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Situa", "TextBox")
        WITH loc_oPagina.txt_4c_Situa
            .Value     = ""
            .Top       = 166
            .Left      = 146
            .Width     = 31
            .Height    = 23
            .MaxLength = 5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Situa, "KeyPress", THIS, "ValidarSituacao")

        loc_oPagina.AddObject("lbl_4c_Label47", "Label")
        WITH loc_oPagina.lbl_4c_Label47
            .Caption   = "Respons" + CHR(225) + "vel :"
            .Top       = 170
            .Left      = 380
            .Width     = 70
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Respons", "TextBox")
        WITH loc_oPagina.txt_4c_Respons
            .Value     = ""
            .Top       = 166
            .Left      = 454
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Respons, "KeyPress", THIS, "ValidarResponsavel")

        loc_oPagina.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPagina.lbl_4c_Label21
            .Caption   = "Central de Cr" + CHR(233) + "dito :"
            .Top       = 170
            .Left      = 611
            .Width     = 97
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Central", "TextBox")
        WITH loc_oPagina.txt_4c_Central
            .Value     = ""
            .Top       = 166
            .Left      = 712
            .Width     = 24
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Central, "KeyPress", THIS, "ValidarCentral")

        loc_oPagina.AddObject("txt_4c_DCentral", "TextBox")
        WITH loc_oPagina.txt_4c_DCentral
            .Value     = ""
            .Top       = 166
            .Left      = 738
            .Width     = 194
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DCentral, "KeyPress", THIS, "ValidarDescCentral")

        *-- Linha separadora Line1 (original top=166; comp.=195)
        loc_oPagina.AddObject("lin_4c_Line1", "Shape")
        WITH loc_oPagina.lin_4c_Line1
            .Top         = 195
            .Left        = 7
            .Width       = 984
            .Height      = 2
            .BackColor   = RGB(180, 180, 180)
            .BackStyle   = 1
            .BorderStyle = 0
            .Curvature   = 0
            .Visible     = .T.
        ENDWITH

        *-- Secao Origem/Destino (original top=168-173; comp.=197-202)
        *-- OptionGroup: op_origem (2 botoes; top=168+29=197, left=140, w=95)
        loc_oPagina.AddObject("obj_4c_Op_origem", "OptionGroup")
        WITH loc_oPagina.obj_4c_Op_origem
            .ButtonCount = 2
            .Top         = 197
            .Left        = 140
            .Width       = 95
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Op_origem.Buttons(1)
            .Caption   = "CR"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 35
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Op_origem.Buttons(2)
            .Caption   = "DB"
            .BackStyle = 0
            .Left      = 48
            .Top       = 3
            .Width     = 35
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label43", "Label")
        WITH loc_oPagina.lbl_4c_Label43
            .Caption   = "Origem :"
            .Top       = 202
            .Left      = 99
            .Width     = 43
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup: op_destino (3 botoes; top=168+29=197, left=619, w=169)
        loc_oPagina.AddObject("obj_4c_Op_destino", "OptionGroup")
        WITH loc_oPagina.obj_4c_Op_destino
            .ButtonCount = 3
            .Top         = 197
            .Left        = 619
            .Width       = 169
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Op_destino.Buttons(1)
            .Caption   = "Nenhum"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 55
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Op_destino.Buttons(2)
            .Caption   = "CR"
            .BackStyle = 0
            .Left      = 68
            .Top       = 3
            .Width     = 35
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Op_destino.Buttons(3)
            .Caption   = "DB"
            .BackStyle = 0
            .Left      = 110
            .Top       = 3
            .Width     = 35
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPagina.lbl_4c_Label25
            .Caption   = "Destino :"
            .Top       = 202
            .Left      = 574
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- GrupoOs/DGrupoOs - Origem (top orig=192-195; comp.=221-224)
        loc_oPagina.AddObject("lbl_4c_Label41", "Label")
        WITH loc_oPagina.lbl_4c_Label41
            .Caption   = "Grupo/Origem :"
            .Top       = 224
            .Left      = 66
            .Width     = 75
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_GrupoOs", "TextBox")
        WITH loc_oPagina.txt_4c_GrupoOs
            .Value     = ""
            .Top       = 221
            .Left      = 146
            .Width     = 79
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrupoOs, "KeyPress", THIS, "ValidarGrupoOrig")

        loc_oPagina.AddObject("txt_4c_DGrupoOs", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupoOs
            .Value     = ""
            .Top       = 221
            .Left      = 227
            .Width     = 290
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DGrupoOs, "KeyPress", THIS, "ValidarDescGrupoOrig")

        *-- Grupo/Destino (top orig=193-197; comp.=222-226)
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Grupo/Destino :"
            .Top       = 226
            .Left      = 541
            .Width     = 78
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value     = ""
            .Top       = 222
            .Left      = 621
            .Width     = 79
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoDest")

        loc_oPagina.AddObject("txt_4c__ds_grupo", "TextBox")
        WITH loc_oPagina.txt_4c__ds_grupo
            .Value     = ""
            .Top       = 222
            .Left      = 701
            .Width     = 290
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c__ds_grupo, "KeyPress", THIS, "ValidarDescGrupoDest")

        *-- ContaOs/DContaOs - Origem (top orig=217-220; comp.=246-249)
        loc_oPagina.AddObject("lbl_4c_Label42", "Label")
        WITH loc_oPagina.lbl_4c_Label42
            .Caption   = "Conta/Origem :"
            .Top       = 249
            .Left      = 66
            .Width     = 72
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ContaOs", "TextBox")
        WITH loc_oPagina.txt_4c_ContaOs
            .Value     = ""
            .Top       = 246
            .Left      = 146
            .Width     = 79
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_ContaOs, "KeyPress", THIS, "ValidarContaOrig")

        loc_oPagina.AddObject("txt_4c_DContaOs", "TextBox")
        WITH loc_oPagina.txt_4c_DContaOs
            .Value     = ""
            .Top       = 246
            .Left      = 227
            .Width     = 290
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DContaOs, "KeyPress", THIS, "ValidarDescContaOrig")

        *-- Conta/Destino (top orig=218-222; comp.=247-251)
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "Conta/Destino :"
            .Top       = 251
            .Left      = 541
            .Width     = 78
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Value     = ""
            .Top       = 247
            .Left      = 621
            .Width     = 79
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarContaDest")

        loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPagina.txt_4c_DConta
            .Value     = ""
            .Top       = 247
            .Left      = 701
            .Width     = 290
            .Height    = 23
            .MaxLength = 60
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DConta, "KeyPress", THIS, "ValidarDescContaDest")

        *-- Linha separadora Line2 (original top=248; comp.=277)
        loc_oPagina.AddObject("lin_4c_Line2", "Shape")
        WITH loc_oPagina.lin_4c_Line2
            .Top         = 277
            .Left        = 7
            .Width       = 984
            .Height      = 2
            .BackColor   = RGB(180, 180, 180)
            .BackStyle   = 1
            .BorderStyle = 0
            .Curvature   = 0
            .Visible     = .T.
        ENDWITH

        *-- ===================================================================
        *-- SECAO 2: Controles abaixo da linha divisoria (original top > 248)
        *-- Todos os tops: legado + 29
        *-- ===================================================================

        *-- Coluna esquerda (left~194): flags S/N financeiros
        loc_oPagina.AddObject("lbl_4c_LblValPend", "Label")
        WITH loc_oPagina.lbl_4c_LblValPend
            .Caption   = "Valor Pendente (Emissor) :"
            .Top       = 288
            .Left      = 63
            .Width     = 129
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ValPend", "TextBox")
        WITH loc_oPagina.txt_4c_ValPend
            .Value     = ""
            .Top       = 284
            .Left      = 194
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSN1", "Label")
        WITH loc_oPagina.lbl_4c_LblSN1
            .Caption   = "[S/N]"
            .Top       = 288
            .Left      = 215
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblValPend2", "Label")
        WITH loc_oPagina.lbl_4c_LblValPend2
            .Caption   = "Valor Pendente (Dep" + CHR(243) + "sito) :"
            .Top       = 313
            .Left      = 57
            .Width     = 135
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ValPend2", "TextBox")
        WITH loc_oPagina.txt_4c_ValPend2
            .Value     = ""
            .Top       = 309
            .Left      = 194
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSN2", "Label")
        WITH loc_oPagina.lbl_4c_LblSN2
            .Caption   = "[S/N]"
            .Top       = 313
            .Left      = 215
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblFazCont", "Label")
        WITH loc_oPagina.lbl_4c_LblFazCont
            .Caption   = "Lan" + CHR(231) + "a Conta Corrente :"
            .Top       = 338
            .Left      = 77
            .Width     = 115
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_FazContas", "TextBox")
        WITH loc_oPagina.txt_4c_FazContas
            .Value     = ""
            .Top       = 334
            .Left      = 194
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSN3", "Label")
        WITH loc_oPagina.lbl_4c_LblSN3
            .Caption   = "[S/N]"
            .Top       = 338
            .Left      = 215
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblBxPend", "Label")
        WITH loc_oPagina.lbl_4c_LblBxPend
            .Caption   = "Baixa Pend" + CHR(234) + "ncias :"
            .Top       = 363
            .Left      = 100
            .Width     = 92
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_BxPend", "TextBox")
        WITH loc_oPagina.txt_4c_BxPend
            .Value     = ""
            .Top       = 359
            .Left      = 194
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSN4", "Label")
        WITH loc_oPagina.lbl_4c_LblSN4
            .Caption   = "[S/N]"
            .Top       = 363
            .Left      = 215
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblVVecto", "Label")
        WITH loc_oPagina.lbl_4c_LblVVecto
            .Caption   = "Verifica Vencimento :"
            .Top       = 388
            .Left      = 90
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_VVecto", "TextBox")
        WITH loc_oPagina.txt_4c_VVecto
            .Value     = ""
            .Top       = 384
            .Left      = 194
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSN5", "Label")
        WITH loc_oPagina.lbl_4c_LblSN5
            .Caption   = "[S/N]"
            .Top       = 388
            .Left      = 215
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblHistClis", "Label")
        WITH loc_oPagina.lbl_4c_LblHistClis
            .Caption   = "Lan" + CHR(231) + "a Hist" + CHR(243) + "rico do Cliente :"
            .Top       = 413
            .Left      = 60
            .Width     = 132
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_HistClis", "TextBox")
        WITH loc_oPagina.txt_4c_HistClis
            .Value     = ""
            .Top       = 409
            .Left      = 194
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSN6", "Label")
        WITH loc_oPagina.lbl_4c_LblSN6
            .Caption   = "[S/N]"
            .Top       = 413
            .Left      = 215
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblCongvs", "Label")
        WITH loc_oPagina.lbl_4c_LblCongvs
            .Caption   = "Cons. Global de Vendas :"
            .Top       = 438
            .Left      = 70
            .Width     = 122
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Congvs", "TextBox")
        WITH loc_oPagina.txt_4c_Congvs
            .Value     = ""
            .Top       = 434
            .Left      = 194
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSN7", "Label")
        WITH loc_oPagina.lbl_4c_LblSN7
            .Caption   = "[S/N]"
            .Top       = 438
            .Left      = 215
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblParcelas", "Label")
        WITH loc_oPagina.lbl_4c_LblParcelas
            .Caption   = "Parcelas :"
            .Top       = 463
            .Left      = 143
            .Width     = 49
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Parcelas", "TextBox")
        WITH loc_oPagina.txt_4c_Parcelas
            .Value     = ""
            .Top       = 459
            .Left      = 194
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSN8", "Label")
        WITH loc_oPagina.lbl_4c_LblSN8
            .Caption   = "[S/N]"
            .Top       = 463
            .Left      = 215
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroups coluna esquerda-baixo (left=190)
        loc_oPagina.AddObject("lbl_4c_LblLeProts", "Label")
        WITH loc_oPagina.lbl_4c_LblLeProts
            .Caption   = "Leitura Cheque pelo Protocolo :"
            .Top       = 488
            .Left      = 39
            .Width     = 153
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opt_LeProts", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opt_LeProts
            .ButtonCount = 2
            .Top         = 484
            .Left        = 190
            .Width       = 127
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_LeProts.Buttons(1)
            .Caption   = "Sim"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_LeProts.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Top       = 5
            .Left      = 85
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblTpLeit", "Label")
        WITH loc_oPagina.lbl_4c_LblTpLeit
            .Caption   = "Tipo de Leitura de Cheque :"
            .Top       = 514
            .Left      = 57
            .Width     = 135
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptTpLeit", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptTpLeit
            .ButtonCount = 2
            .Top         = 510
            .Left        = 190
            .Width       = 136
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTpLeit.Buttons(1)
            .Caption   = "Digita" + CHR(231) + CHR(227) + "o"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTpLeit.Buttons(2)
            .Caption   = "CMC7"
            .Top       = 5
            .Left      = 85
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblGerarq", "Label")
        WITH loc_oPagina.lbl_4c_LblGerarq
            .Caption   = "Gera n" + CHR(186) + " Arquivo :"
            .Top       = 539
            .Left      = 106
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_Gerarq", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_Gerarq
            .ButtonCount = 2
            .Top         = 535
            .Left        = 190
            .Width       = 127
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Gerarq.Buttons(1)
            .Caption   = "Sim"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Gerarq.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Top       = 5
            .Left      = 85
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblAnaSit", "Label")
        WITH loc_oPagina.lbl_4c_LblAnaSit
            .Caption   = "Cons. Global de Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 565
            .Left      = 64
            .Width     = 128
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_gensit", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_gensit
            .ButtonCount = 2
            .Top         = 561
            .Left        = 190
            .Width       = 127
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_gensit.Buttons(1)
            .Caption   = "Sim"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_gensit.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Top       = 5
            .Left      = 85
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblAltDados", "Label")
        WITH loc_oPagina.lbl_4c_LblAltDados
            .Caption   = "Altera Dados :"
            .Top       = 590
            .Left      = 121
            .Width     = 71
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_AltDados", "OptionGroup")
        WITH loc_oPagina.obj_4c_AltDados
            .ButtonCount = 2
            .Top         = 586
            .Left        = 190
            .Width       = 127
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_AltDados.Buttons(1)
            .Caption   = "Sim"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_AltDados.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Top       = 5
            .Left      = 85
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Coluna central (left~512): flags S/N emissao
        loc_oPagina.AddObject("lbl_4c_LblEmiInd", "Label")
        WITH loc_oPagina.lbl_4c_LblEmiInd
            .Caption   = "Emissor Individual :"
            .Top       = 288
            .Left      = 415
            .Width     = 93
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_EmiInd", "TextBox")
        WITH loc_oPagina.txt_4c_EmiInd
            .Value     = ""
            .Top       = 284
            .Left      = 512
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSNM1", "Label")
        WITH loc_oPagina.lbl_4c_LblSNM1
            .Caption   = "[S/N]"
            .Top       = 288
            .Left      = 533
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblCademis", "Label")
        WITH loc_oPagina.lbl_4c_LblCademis
            .Caption   = "Cadastra Emissor :"
            .Top       = 313
            .Left      = 417
            .Width     = 91
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cademis", "TextBox")
        WITH loc_oPagina.txt_4c_Cademis
            .Value     = ""
            .Top       = 309
            .Left      = 512
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSNM2", "Label")
        WITH loc_oPagina.lbl_4c_LblSNM2
            .Caption   = "[S/N]"
            .Top       = 313
            .Left      = 533
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblEmpInd", "Label")
        WITH loc_oPagina.lbl_4c_LblEmpInd
            .Caption   = "Empresa Individual :"
            .Top       = 338
            .Left      = 410
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_EmpInd", "TextBox")
        WITH loc_oPagina.txt_4c_EmpInd
            .Value     = ""
            .Top       = 334
            .Left      = 512
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSNM3", "Label")
        WITH loc_oPagina.lbl_4c_LblSNM3
            .Caption   = "[S/N]"
            .Top       = 338
            .Left      = 533
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblEmiProts", "Label")
        WITH loc_oPagina.lbl_4c_LblEmiProts
            .Caption   = "Emite Protocolo :"
            .Top       = 363
            .Left      = 426
            .Width     = 83
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_EmiProts", "TextBox")
        WITH loc_oPagina.txt_4c_EmiProts
            .Value     = ""
            .Top       = 359
            .Left      = 512
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSNM4", "Label")
        WITH loc_oPagina.lbl_4c_LblSNM4
            .Caption   = "[S/N]"
            .Top       = 363
            .Left      = 533
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblDevolvido", "Label")
        WITH loc_oPagina.lbl_4c_LblDevolvido
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Devolvido :"
            .Top       = 388
            .Left      = 388
            .Width     = 121
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Devolvido", "TextBox")
        WITH loc_oPagina.txt_4c_Devolvido
            .Value     = ""
            .Top       = 384
            .Left      = 512
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSNM5", "Label")
        WITH loc_oPagina.lbl_4c_LblSNM5
            .Caption   = "[S/N]"
            .Top       = 388
            .Left      = 533
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblAlinea", "Label")
        WITH loc_oPagina.lbl_4c_LblAlinea
            .Caption   = "Tem Alinea :"
            .Top       = 413
            .Left      = 448
            .Width     = 61
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Alinea", "TextBox")
        WITH loc_oPagina.txt_4c_Alinea
            .Value     = ""
            .Top       = 409
            .Left      = 512
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSNM6", "Label")
        WITH loc_oPagina.lbl_4c_LblSNM6
            .Caption   = "[S/N]"
            .Top       = 413
            .Left      = 533
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblEmiCarta", "Label")
        WITH loc_oPagina.lbl_4c_LblEmiCarta
            .Caption   = "Emite Carta :"
            .Top       = 438
            .Left      = 444
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_EmiCarta", "TextBox")
        WITH loc_oPagina.txt_4c_EmiCarta
            .Value     = ""
            .Top       = 434
            .Left      = 512
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSNM7", "Label")
        WITH loc_oPagina.lbl_4c_LblSNM7
            .Caption   = "[S/N]"
            .Top       = 438
            .Left      = 533
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblConsolida", "Label")
        WITH loc_oPagina.lbl_4c_LblConsolida
            .Caption   = "Consolida Lan" + CHR(231) + "amentos :"
            .Top       = 463
            .Left      = 388
            .Width     = 121
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Consolida", "TextBox")
        WITH loc_oPagina.txt_4c_Consolida
            .Value     = ""
            .Top       = 459
            .Left      = 512
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSNM8", "Label")
        WITH loc_oPagina.lbl_4c_LblSNM8
            .Caption   = "[S/N]"
            .Top       = 463
            .Left      = 533
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblObs", "Label")
        WITH loc_oPagina.lbl_4c_LblObs
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 488
            .Left      = 442
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Obs", "TextBox")
        WITH loc_oPagina.txt_4c_Obs
            .Value     = ""
            .Top       = 484
            .Left      = 512
            .Width     = 18
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblSNC", "Label")
        WITH loc_oPagina.lbl_4c_LblSNC
            .Caption   = "[S/N/C]"
            .Top       = 488
            .Left      = 533
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroups coluna central-baixo (left=506)
        loc_oPagina.AddObject("lbl_4c_LblProrroga", "Label")
        WITH loc_oPagina.lbl_4c_LblProrroga
            .Caption   = "Prorrogar Tipo (CR) :"
            .Top       = 514
            .Left      = 406
            .Width     = 103
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Prorroga", "OptionGroup")
        WITH loc_oPagina.obj_4c_Prorroga
            .ButtonCount = 2
            .Top         = 510
            .Left        = 506
            .Width       = 127
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Prorroga.Buttons(1)
            .Caption   = "Sim"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Prorroga.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Top       = 5
            .Left      = 85
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblCarteira", "Label")
        WITH loc_oPagina.lbl_4c_LblCarteira
            .Caption   = "Permitir Carteira Tipo (CR) :"
            .Top       = 539
            .Left      = 374
            .Width     = 135
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Carteira", "OptionGroup")
        WITH loc_oPagina.obj_4c_Carteira
            .ButtonCount = 2
            .Top         = 535
            .Left        = 506
            .Width       = 127
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Carteira.Buttons(1)
            .Caption   = "Sim"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Carteira.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Top       = 5
            .Left      = 85
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblVencUtil", "Label")
        WITH loc_oPagina.lbl_4c_LblVencUtil
            .Caption   = "Vencimento dia " + CHR(250) + "til :"
            .Top       = 561
            .Left      = 411
            .Width     = 98
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_VencUtil", "OptionGroup")
        WITH loc_oPagina.obj_4c_VencUtil
            .ButtonCount = 2
            .Top         = 557
            .Left        = 506
            .Width       = 127
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_VencUtil.Buttons(1)
            .Caption   = "Sim"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_VencUtil.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Top       = 5
            .Left      = 85
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Area direita (left=764): Data emissao, Pend.Fin., Comissao, Moeda
        loc_oPagina.AddObject("lbl_4c_LblDtEmiss", "Label")
        WITH loc_oPagina.lbl_4c_LblDtEmiss
            .Caption   = "Data de Emiss" + CHR(227) + "o Padr" + CHR(227) + "o :"
            .Top       = 286
            .Left      = 641
            .Width     = 125
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opt_DtEmiss", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opt_DtEmiss
            .ButtonCount = 3
            .Top         = 281
            .Left        = 764
            .Width       = 124
            .Height      = 66
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_DtEmiss.Buttons(1)
            .Caption   = "Data de Entrada"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_DtEmiss.Buttons(2)
            .Caption   = "Data de Vencimento"
            .Top       = 25
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_DtEmiss.Buttons(3)
            .Caption   = "Nenhum"
            .Top       = 44
            .Left      = 5
            .AutoSize  = .F.
            .Width     = 66
            .Height    = 17
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblPenFin", "Label")
        WITH loc_oPagina.lbl_4c_LblPenFin
            .Caption   = "Pend" + CHR(234) + "ncias Financeiras :"
            .Top       = 352
            .Left      = 646
            .Width     = 120
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_penfin", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_penfin
            .ButtonCount = 3
            .Top         = 348
            .Left        = 764
            .Width       = 218
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_penfin.Buttons(1)
            .Caption   = "Incluir"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_penfin.Buttons(2)
            .Caption   = "Excluir"
            .Top       = 5
            .Left      = 74
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_penfin.Buttons(3)
            .Caption   = "Nenhuma"
            .Top       = 5
            .Left      = 150
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblComiss", "Label")
        WITH loc_oPagina.lbl_4c_LblComiss
            .Caption   = "C" + CHR(225) + "lculo de Comiss" + CHR(227) + "o :"
            .Top       = 377
            .Left      = 660
            .Width     = 106
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OpComiss", "OptionGroup")
        WITH loc_oPagina.obj_4c_OpComiss
            .ButtonCount = 3
            .Top         = 373
            .Left        = 764
            .Width       = 219
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OpComiss.Buttons(1)
            .Caption   = "Nenhum"
            .Top       = 5
            .Left      = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OpComiss.Buttons(2)
            .Caption   = "Desconta"
            .Top       = 5
            .Left      = 74
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OpComiss.Buttons(3)
            .Caption   = "Recupera"
            .Top       = 5
            .Left      = 148
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblDesconto", "Label")
        WITH loc_oPagina.lbl_4c_LblDesconto
            .Caption   = "Percentual Comiss" + CHR(227) + "o :"
            .Top       = 401
            .Left      = 658
            .Width     = 111
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Desconto", "TextBox")
        WITH loc_oPagina.txt_4c_Desconto
            .Value     = 0
            .Top       = 397
            .Left      = 771
            .Width     = 52
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblMoeda", "Label")
        WITH loc_oPagina.lbl_4c_LblMoeda
            .Caption   = "Moeda :"
            .Top       = 427
            .Left      = 725
            .Width     = 44
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPagina.txt_4c_Moeda
            .Value     = ""
            .Top       = 422
            .Left      = 771
            .Width     = 32
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Grupo Terceiro (fundo da pagina)
        loc_oPagina.AddObject("lbl_4c_LblGrupoT", "Label")
        WITH loc_oPagina.lbl_4c_LblGrupoT
            .Caption   = "Grupo Terceiro :"
            .Top       = 608
            .Left      = 524
            .Width     = 94
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_GrupoT", "TextBox")
        WITH loc_oPagina.txt_4c_GrupoT
            .Value     = ""
            .Top       = 604
            .Left      = 621
            .Width     = 79
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DGrupoT", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupoT
            .Value     = ""
            .Top       = 604
            .Left      = 701
            .Width     = 290
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .Visible   = .T.
        ENDWITH

        *-- BtnCarta: Botao para acessar SigOpCoc (left=569, top=434)
        loc_oPagina.AddObject("cmd_4c_BtnCarta", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnCarta
            .Caption     = "..."
            .Top         = 434
            .Left        = 569
            .Width       = 23
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .Themes      = .F.
            .SpecialEffect = 0
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BtnCarta, "Click", THIS, "BtnCartaClick")

        *-- BINDEVENTs para controles da secao 2
        BINDEVENT(loc_oPagina.txt_4c_EmiCarta, "InteractiveChange", THIS, "AtualizarEstadoCarta")
        BINDEVENT(loc_oPagina.txt_4c_Moeda,    "KeyPress",         THIS, "ValidarMoedas")
        BINDEVENT(loc_oPagina.txt_4c_GrupoT,   "KeyPress",         THIS, "ValidarGrupoT")
        BINDEVENT(loc_oPagina.txt_4c_DGrupoT,  "KeyPress",         THIS, "ValidarDescGrupoT")

        *-- Linha separadora Line3 (fundo direito)
        loc_oPagina.AddObject("lin_4c_Line3", "Shape")
        WITH loc_oPagina.lin_4c_Line3
            .Top         = 594
            .Left        = 527
            .Width       = 466
            .Height      = 2
            .BackColor   = RGB(90, 90, 90)
            .BackStyle   = 1
            .BorderStyle = 0
            .Curvature   = 0
            .Visible     = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * SELECT conforme colunas do legado: Operacaos, Tipos, OpAnts, GrupoOs
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource          = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Operacaos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Tipos"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.OpAnts"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.GrupoOs"

                *-- Reconfigurar cabecalhos apos RecordSource (VFP reseta Headers)
                loc_oGrid.Column1.Header1.Caption = "Movimento"
                loc_oGrid.Column2.Header1.Caption = "Tipo"
                loc_oGrid.Column3.Header1.Caption = "Mv. Anterior"
                loc_oGrid.Column4.Header1.Caption = "Grupo/Ori"

                loc_oGrid.Column1.Width = 140
                loc_oGrid.Column2.Width = 60
                loc_oGrid.Column3.Width = 140
                loc_oGrid.Column4.Width = 80

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormOpt.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1 recarrega o grid automaticamente
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, ;
                "FormOpt.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre Page2 para inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.pgf_4c_Paginas.ActivePage = 2
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao incluir:" + CHR(13) + loc_oErro.Message, ;
                "FormOpt.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para visualizar.", "")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.Operacaos)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao carregar registro para visualizar.", ;
                        "FormOpt.BtnVisualizarClick")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao visualizar:" + CHR(13) + loc_oErro.Message, ;
                "FormOpt.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre Page2 para alteracao do registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para alterar.", "")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.Operacaos)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao carregar registro para alterar.", ;
                        "FormOpt.BtnAlterarClick")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar:" + CHR(13) + loc_oErro.Message, ;
                "FormOpt.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cCodigo, loc_lConfirmou
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para excluir.", "")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.Operacaos)

                loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + ;
                    "o do registro '" + loc_cCodigo + "'?", ;
                    "Confirmar Exclus" + CHR(227) + CHR(227) + "o")

                IF loc_lConfirmou
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
                                "Sucesso")
                            THIS.CarregarLista()
                        ELSE
                            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                                "vel excluir o registro.", "FormOpt.BtnExcluirClick")
                        ENDIF
                    ENDIF
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, ;
                "FormOpt.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar e posiciona no registro encontrado
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado, loc_oBusca, loc_cCodigo
        loc_lResultado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpt", "cursor_4c_BuscaOpt", "Operacaos", "", ;
                "Buscar Movimenta" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Operacaos", "", "Movimento")
                loc_oBusca.mAddColuna("Tipos", "", "Tipo")
                loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaOpt.Operacaos)
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(Operacaos) == loc_cCodigo
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaOpt")
                USE IN cursor_4c_BuscaOpt
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, ;
                "FormOpt.BtnBuscarClick")

            IF USED("cursor_4c_BuscaOpt")
                USE IN cursor_4c_BuscaOpt
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva o registro via BO (Page2 - Confirmar)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao salvar o registro.", "FormOpt.BtnSalvarClick")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, ;
                "FormOpt.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa os campos da Page2 (Fase 5)
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 4)
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
        ENDIF
        IF PEMSTATUS(loc_oPg2, "chk_4c_Fwcheckbox1", 4)
            loc_oPg2.chk_4c_Fwcheckbox1.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4)
            loc_oPg2.txt_4c_Codigo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 4)
            loc_oPg2.txt_4c_Descr.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tipo", 4)
            loc_oPg2.txt_4c_Tipo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_OpAnts", 4)
            loc_oPg2.txt_4c_OpAnts.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_OpContas", 4)
            loc_oPg2.txt_4c_OpContas.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 4)
            loc_oPg2.txt_4c_Ordem.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_OpEntrada", 4)
            loc_oPg2.txt_4c_OpEntrada.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)
            loc_oPg2.txt_4c_OpAut.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_TipoData", 4)
            loc_oPg2.obj_4c_Opc_TipoData.Value   = 1
            loc_oPg2.obj_4c_Opc_TipoData.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Fpg", 4)
            loc_oPg2.txt_4c_Fpg.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 4)
            loc_oPg2.txt_4c_Hists.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OpTpHists", 4)
            loc_oPg2.obj_4c_OpTpHists.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Hispad", 4)
            loc_oPg2.txt_4c_Hispad.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_tpemissor", 4)
            loc_oPg2.obj_4c_Opc_tpemissor.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Situa", 4)
            loc_oPg2.txt_4c_Situa.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Respons", 4)
            loc_oPg2.txt_4c_Respons.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Central", 4)
            loc_oPg2.txt_4c_Central.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DCentral", 4)
            loc_oPg2.txt_4c_DCentral.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Op_origem", 4)
            loc_oPg2.obj_4c_Op_origem.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Op_destino", 4)
            loc_oPg2.obj_4c_Op_destino.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoOs", 4)
            loc_oPg2.txt_4c_GrupoOs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupoOs", 4)
            loc_oPg2.txt_4c_DGrupoOs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 4)
            loc_oPg2.txt_4c_Grupo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c__ds_grupo", 4)
            loc_oPg2.txt_4c__ds_grupo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_ContaOs", 4)
            loc_oPg2.txt_4c_ContaOs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DContaOs", 4)
            loc_oPg2.txt_4c_DContaOs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 4)
            loc_oPg2.txt_4c_Conta.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 4)
            loc_oPg2.txt_4c_DConta.Value = ""
        ENDIF
        *-- Secao 2: campos abaixo de Line2
        IF PEMSTATUS(loc_oPg2, "txt_4c_ValPend", 4)
            loc_oPg2.txt_4c_ValPend.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_ValPend2", 4)
            loc_oPg2.txt_4c_ValPend2.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_FazContas", 4)
            loc_oPg2.txt_4c_FazContas.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_BxPend", 4)
            loc_oPg2.txt_4c_BxPend.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_VVecto", 4)
            loc_oPg2.txt_4c_VVecto.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_HistClis", 4)
            loc_oPg2.txt_4c_HistClis.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Congvs", 4)
            loc_oPg2.txt_4c_Congvs.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Parcelas", 4)
            loc_oPg2.txt_4c_Parcelas.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Consolida", 4)
            loc_oPg2.txt_4c_Consolida.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Obs", 4)
            loc_oPg2.txt_4c_Obs.Value        = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_EmiCarta", 4)
            loc_oPg2.txt_4c_EmiCarta.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_EmiProts", 4)
            loc_oPg2.txt_4c_EmiProts.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Alinea", 4)
            loc_oPg2.txt_4c_Alinea.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_EmpInd", 4)
            loc_oPg2.txt_4c_EmpInd.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_EmiInd", 4)
            loc_oPg2.txt_4c_EmiInd.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Cademis", 4)
            loc_oPg2.txt_4c_Cademis.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Devolvido", 4)
            loc_oPg2.txt_4c_Devolvido.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Desconto", 4)
            loc_oPg2.txt_4c_Desconto.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 4)
            loc_oPg2.txt_4c_Moeda.Value      = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_DtEmiss", 4)
            loc_oPg2.obj_4c_Opt_DtEmiss.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_penfin", 4)
            loc_oPg2.obj_4c_Opc_penfin.Value  = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OpComiss", 4)
            loc_oPg2.obj_4c_OpComiss.Value    = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_LeProts", 4)
            loc_oPg2.obj_4c_Opt_LeProts.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Prorroga", 4)
            loc_oPg2.obj_4c_Prorroga.Value    = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptTpLeit", 4)
            loc_oPg2.obj_4c_OptTpLeit.Value   = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Gerarq", 4)
            loc_oPg2.obj_4c_Opc_Gerarq.Value  = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Carteira", 4)
            loc_oPg2.obj_4c_Carteira.Value    = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_gensit", 4)
            loc_oPg2.obj_4c_Opc_gensit.Value  = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_VencUtil", 4)
            loc_oPg2.obj_4c_VencUtil.Value    = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_AltDados", 4)
            loc_oPg2.obj_4c_AltDados.Value    = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoT", 4)
            loc_oPg2.txt_4c_GrupoT.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupoT", 4)
            loc_oPg2.txt_4c_DGrupoT.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarta", 4)
            loc_oPg2.cmd_4c_BtnCarta.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos por modo (Fase 5)
    * par_lHabilitar: .T. = INCLUIR/ALTERAR, .F. = VISUALIZAR
    * txt_4c_Codigo: ReadOnly em modo ALTERAR (legado: Get_codigo.When)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 4)
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "chk_4c_Fwcheckbox1", 4)
            loc_oPg2.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4)
            loc_oPg2.txt_4c_Codigo.Enabled  = par_lHabilitar
            loc_oPg2.txt_4c_Codigo.ReadOnly = (THIS.this_cModoAtual = "ALTERAR")
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 4)
            loc_oPg2.txt_4c_Descr.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tipo", 4)
            loc_oPg2.txt_4c_Tipo.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_OpAnts", 4)
            loc_oPg2.txt_4c_OpAnts.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_OpContas", 4)
            loc_oPg2.txt_4c_OpContas.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 4)
            loc_oPg2.txt_4c_Ordem.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_OpEntrada", 4)
            loc_oPg2.txt_4c_OpEntrada.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)
            loc_oPg2.txt_4c_OpAut.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_TipoData", 4) AND ;
                PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)
            loc_oPg2.obj_4c_Opc_TipoData.Enabled = par_lHabilitar AND ;
                (UPPER(ALLTRIM(loc_oPg2.txt_4c_OpAut.Value)) = "S")
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Fpg", 4)
            loc_oPg2.txt_4c_Fpg.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 4)
            loc_oPg2.txt_4c_Hists.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OpTpHists", 4)
            loc_oPg2.obj_4c_OpTpHists.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Hispad", 4)
            loc_oPg2.txt_4c_Hispad.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_tpemissor", 4)
            loc_oPg2.obj_4c_Opc_tpemissor.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Situa", 4)
            loc_oPg2.txt_4c_Situa.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Respons", 4)
            loc_oPg2.txt_4c_Respons.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Central", 4)
            loc_oPg2.txt_4c_Central.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DCentral", 4)
            loc_oPg2.txt_4c_DCentral.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Op_origem", 4)
            loc_oPg2.obj_4c_Op_origem.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Op_destino", 4)
            loc_oPg2.obj_4c_Op_destino.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoOs", 4)
            loc_oPg2.txt_4c_GrupoOs.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupoOs", 4)
            loc_oPg2.txt_4c_DGrupoOs.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 4)
            loc_oPg2.txt_4c_Grupo.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c__ds_grupo", 4)
            loc_oPg2.txt_4c__ds_grupo.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_ContaOs", 4)
            loc_oPg2.txt_4c_ContaOs.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DContaOs", 4)
            loc_oPg2.txt_4c_DContaOs.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 4)
            loc_oPg2.txt_4c_Conta.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 4)
            loc_oPg2.txt_4c_DConta.Enabled = par_lHabilitar
        ENDIF
        *-- Secao 2: campos abaixo de Line2
        IF PEMSTATUS(loc_oPg2, "txt_4c_ValPend", 4)
            loc_oPg2.txt_4c_ValPend.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_ValPend2", 4)
            loc_oPg2.txt_4c_ValPend2.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_FazContas", 4)
            loc_oPg2.txt_4c_FazContas.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_BxPend", 4)
            loc_oPg2.txt_4c_BxPend.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_VVecto", 4)
            loc_oPg2.txt_4c_VVecto.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_HistClis", 4)
            loc_oPg2.txt_4c_HistClis.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Congvs", 4)
            loc_oPg2.txt_4c_Congvs.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Parcelas", 4)
            loc_oPg2.txt_4c_Parcelas.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Consolida", 4)
            loc_oPg2.txt_4c_Consolida.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Obs", 4)
            loc_oPg2.txt_4c_Obs.Enabled        = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_EmiCarta", 4)
            loc_oPg2.txt_4c_EmiCarta.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_EmiProts", 4)
            loc_oPg2.txt_4c_EmiProts.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Alinea", 4)
            loc_oPg2.txt_4c_Alinea.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_EmpInd", 4)
            loc_oPg2.txt_4c_EmpInd.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_EmiInd", 4)
            loc_oPg2.txt_4c_EmiInd.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Cademis", 4)
            loc_oPg2.txt_4c_Cademis.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Devolvido", 4)
            loc_oPg2.txt_4c_Devolvido.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Desconto", 4)
            loc_oPg2.txt_4c_Desconto.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 4)
            loc_oPg2.txt_4c_Moeda.Enabled      = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_DtEmiss", 4)
            loc_oPg2.obj_4c_Opt_DtEmiss.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_penfin", 4)
            loc_oPg2.obj_4c_Opc_penfin.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OpComiss", 4)
            loc_oPg2.obj_4c_OpComiss.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_LeProts", 4)
            loc_oPg2.obj_4c_Opt_LeProts.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Prorroga", 4)
            loc_oPg2.obj_4c_Prorroga.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_OptTpLeit", 4)
            loc_oPg2.obj_4c_OptTpLeit.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Gerarq", 4)
            loc_oPg2.obj_4c_Opc_Gerarq.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Carteira", 4)
            loc_oPg2.obj_4c_Carteira.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_gensit", 4)
            loc_oPg2.obj_4c_Opc_gensit.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_VencUtil", 4)
            loc_oPg2.obj_4c_VencUtil.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_AltDados", 4)
            loc_oPg2.obj_4c_AltDados.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoT", 4)
            loc_oPg2.txt_4c_GrupoT.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarta", 4)
            IF par_lHabilitar
                loc_oPg2.cmd_4c_BtnCarta.Enabled = ;
                    (UPPER(ALLTRIM(loc_oPg2.txt_4c_EmiCarta.Value)) = "S")
            ELSE
                loc_oPg2.cmd_4c_BtnCarta.Enabled = .F.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta botoes por modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 4)
            WITH loc_oPg2.cnt_4c_BotoesAcao
                .cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual = "INCLUIR" OR ;
                    THIS.this_cModoAtual = "ALTERAR")
                .cmd_4c_Cancelar.Enabled  = .T.
                .Visible     = .T.
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do Form para o BO
    * Campos obrigatorios: Codigo (PK), Descricao, Tipo
    * OptionGroups: .Value direto (1..N) = valor numerico no banco
    * Checkbox Inativa: .Value=.T. -> 1 / .F. -> 0
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4)
                .this_cOperacaos  = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 4)
                .this_cDescrs     = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Tipo", 4)
                .this_cTipos      = UPPER(ALLTRIM(loc_oPg2.txt_4c_Tipo.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_OpAnts", 4)
                .this_cOpAnts     = ALLTRIM(loc_oPg2.txt_4c_OpAnts.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_OpContas", 4)
                .this_cDopcs      = ALLTRIM(loc_oPg2.txt_4c_OpContas.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 4)
                .this_nOrdens     = loc_oPg2.txt_4c_Ordem.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_OpEntrada", 4)
                .this_cOpEntradas = ALLTRIM(loc_oPg2.txt_4c_OpEntrada.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)
                .this_cOpAuts     = UPPER(ALLTRIM(loc_oPg2.txt_4c_OpAut.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_TipoData", 4)
                .this_nTpDatas    = loc_oPg2.obj_4c_Opc_TipoData.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Fpg", 4)
                .this_cFPags      = ALLTRIM(loc_oPg2.txt_4c_Fpg.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 4)
                .this_cHists      = ALLTRIM(loc_oPg2.txt_4c_Hists.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OpTpHists", 4)
                .this_nTpHists    = loc_oPg2.obj_4c_OpTpHists.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hispad", 4)
                .this_cGruEmis    = ALLTRIM(loc_oPg2.txt_4c_Hispad.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_tpemissor", 4)
                .this_nTpEmiss    = loc_oPg2.obj_4c_Opc_tpemissor.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Situa", 4)
                .this_cSituas     = ALLTRIM(loc_oPg2.txt_4c_Situa.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Respons", 4)
                .this_cRespons    = ALLTRIM(loc_oPg2.txt_4c_Respons.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Central", 4)
                .this_cCCentrals  = ALLTRIM(loc_oPg2.txt_4c_Central.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Op_origem", 4)
                .this_nOrigems    = loc_oPg2.obj_4c_Op_origem.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Op_destino", 4)
                .this_nDestinos   = loc_oPg2.obj_4c_Op_destino.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoOs", 4)
                .this_cGrupoOs    = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 4)
                .this_cGruDeps    = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_ContaOs", 4)
                .this_cContaOs    = ALLTRIM(loc_oPg2.txt_4c_ContaOs.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 4)
                .this_cConDeps    = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Fwcheckbox1", 4)
                .this_nInativas   = IIF(loc_oPg2.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
            ENDIF
            *-- Secao 2: campos abaixo de Line2
            IF PEMSTATUS(loc_oPg2, "txt_4c_ValPend", 4)
                .this_cValPends   = UPPER(ALLTRIM(loc_oPg2.txt_4c_ValPend.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_ValPend2", 4)
                .this_cValPend2s  = UPPER(ALLTRIM(loc_oPg2.txt_4c_ValPend2.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_FazContas", 4)
                .this_cFazContas  = UPPER(ALLTRIM(loc_oPg2.txt_4c_FazContas.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_BxPend", 4)
                .this_cBxPends    = UPPER(ALLTRIM(loc_oPg2.txt_4c_BxPend.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_VVecto", 4)
                .this_cVVectos    = UPPER(ALLTRIM(loc_oPg2.txt_4c_VVecto.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_HistClis", 4)
                .this_cHistClis   = UPPER(ALLTRIM(loc_oPg2.txt_4c_HistClis.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Congvs", 4)
                .this_cCongvs     = UPPER(ALLTRIM(loc_oPg2.txt_4c_Congvs.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Parcelas", 4)
                .this_cParcelas   = UPPER(ALLTRIM(loc_oPg2.txt_4c_Parcelas.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Consolida", 4)
                .this_cConsolidas = UPPER(ALLTRIM(loc_oPg2.txt_4c_Consolida.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Obs", 4)
                .this_cObs        = UPPER(ALLTRIM(loc_oPg2.txt_4c_Obs.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_EmiCarta", 4)
                .this_cEmiCarts   = UPPER(ALLTRIM(loc_oPg2.txt_4c_EmiCarta.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_EmiProts", 4)
                .this_cEmiProts   = UPPER(ALLTRIM(loc_oPg2.txt_4c_EmiProts.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Alinea", 4)
                .this_cAlineas    = UPPER(ALLTRIM(loc_oPg2.txt_4c_Alinea.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_EmpInd", 4)
                .this_cEmpInds    = UPPER(ALLTRIM(loc_oPg2.txt_4c_EmpInd.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_EmiInd", 4)
                .this_cEmiInds    = UPPER(ALLTRIM(loc_oPg2.txt_4c_EmiInd.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Cademis", 4)
                .this_cCademis    = UPPER(ALLTRIM(loc_oPg2.txt_4c_Cademis.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Devolvido", 4)
                .this_cDevolvidos = UPPER(ALLTRIM(loc_oPg2.txt_4c_Devolvido.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Desconto", 4)
                .this_nDescontos  = loc_oPg2.txt_4c_Desconto.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 4)
                .this_cMoedas     = UPPER(ALLTRIM(loc_oPg2.txt_4c_Moeda.Value))
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_DtEmiss", 4)
                .this_nNdtEmiss   = loc_oPg2.obj_4c_Opt_DtEmiss.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_penfin", 4)
                .this_nPeFins     = loc_oPg2.obj_4c_Opc_penfin.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OpComiss", 4)
                .this_nComiss     = loc_oPg2.obj_4c_OpComiss.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_LeProts", 4)
                .this_nLeProts    = loc_oPg2.obj_4c_Opt_LeProts.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Prorroga", 4)
                .this_nProrrogas  = loc_oPg2.obj_4c_Prorroga.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptTpLeit", 4)
                .this_nTpLeituras = loc_oPg2.obj_4c_OptTpLeit.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Gerarq", 4)
                .this_nGeranarqs  = loc_oPg2.obj_4c_Opc_Gerarq.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Carteira", 4)
                .this_nCartDbs    = loc_oPg2.obj_4c_Carteira.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_gensit", 4)
                .this_nAnaSits    = loc_oPg2.obj_4c_Opc_gensit.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_VencUtil", 4)
                .this_nVencUtil   = loc_oPg2.obj_4c_VencUtil.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_AltDados", 4)
                .this_nAltDados   = loc_oPg2.obj_4c_AltDados.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoT", 4)
                .this_cGrupoT     = ALLTRIM(loc_oPg2.txt_4c_GrupoT.Value)
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para o Form
    * Chamado em Alterar e Visualizar apos CarregarPorCodigo()
    * Campos descricao (DCentral, DGrupoOs, ds_grupo, DContaOs, DConta)
    *   serao preenchidos pelos BINDEVENTs de LostFocus quando aplicavel
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4)
                loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(.this_cOperacaos)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 4)
                loc_oPg2.txt_4c_Descr.Value     = ALLTRIM(.this_cDescrs)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Tipo", 4)
                loc_oPg2.txt_4c_Tipo.Value      = ALLTRIM(.this_cTipos)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_OpAnts", 4)
                loc_oPg2.txt_4c_OpAnts.Value    = ALLTRIM(.this_cOpAnts)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_OpContas", 4)
                loc_oPg2.txt_4c_OpContas.Value  = ALLTRIM(.this_cDopcs)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Ordem", 4)
                loc_oPg2.txt_4c_Ordem.Value     = .this_nOrdens
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_OpEntrada", 4)
                loc_oPg2.txt_4c_OpEntrada.Value = ALLTRIM(.this_cOpEntradas)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)
                loc_oPg2.txt_4c_OpAut.Value     = ALLTRIM(.this_cOpAuts)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_TipoData", 4)
                loc_oPg2.obj_4c_Opc_TipoData.Value = IIF(.this_nTpDatas >= 1 AND ;
                    .this_nTpDatas <= 4, .this_nTpDatas, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Fpg", 4)
                loc_oPg2.txt_4c_Fpg.Value       = ALLTRIM(.this_cFPags)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 4)
                loc_oPg2.txt_4c_Hists.Value     = ALLTRIM(.this_cHists)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OpTpHists", 4)
                loc_oPg2.obj_4c_OpTpHists.Value = IIF(.this_nTpHists >= 1 AND ;
                    .this_nTpHists <= 2, .this_nTpHists, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hispad", 4)
                loc_oPg2.txt_4c_Hispad.Value    = ALLTRIM(.this_cGruEmis)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_tpemissor", 4)
                loc_oPg2.obj_4c_Opc_tpemissor.Value = IIF(.this_nTpEmiss >= 1 AND ;
                    .this_nTpEmiss <= 2, .this_nTpEmiss, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Situa", 4)
                loc_oPg2.txt_4c_Situa.Value     = ALLTRIM(.this_cSituas)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Respons", 4)
                loc_oPg2.txt_4c_Respons.Value   = ALLTRIM(.this_cRespons)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Central", 4)
                loc_oPg2.txt_4c_Central.Value   = ALLTRIM(.this_cCCentrals)
                loc_oPg2.txt_4c_DCentral.Value  = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Op_origem", 4)
                loc_oPg2.obj_4c_Op_origem.Value = IIF(.this_nOrigems >= 1 AND ;
                    .this_nOrigems <= 3, .this_nOrigems, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Op_destino", 4)
                loc_oPg2.obj_4c_Op_destino.Value = IIF(.this_nDestinos >= 1 AND ;
                    .this_nDestinos <= 3, .this_nDestinos, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoOs", 4)
                loc_oPg2.txt_4c_GrupoOs.Value   = ALLTRIM(.this_cGrupoOs)
                loc_oPg2.txt_4c_DGrupoOs.Value  = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 4)
                loc_oPg2.txt_4c_Grupo.Value     = ALLTRIM(.this_cGruDeps)
                loc_oPg2.txt_4c__ds_grupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_ContaOs", 4)
                loc_oPg2.txt_4c_ContaOs.Value   = ALLTRIM(.this_cContaOs)
                loc_oPg2.txt_4c_DContaOs.Value  = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 4)
                loc_oPg2.txt_4c_Conta.Value     = ALLTRIM(.this_cConDeps)
                loc_oPg2.txt_4c_DConta.Value    = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Fwcheckbox1", 4)
                loc_oPg2.chk_4c_Fwcheckbox1.Value = IIF(.this_nInativas = 1, 1, 0)
            ENDIF
            *-- Secao 2: campos abaixo de Line2
            IF PEMSTATUS(loc_oPg2, "txt_4c_ValPend", 4)
                loc_oPg2.txt_4c_ValPend.Value    = ALLTRIM(.this_cValPends)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_ValPend2", 4)
                loc_oPg2.txt_4c_ValPend2.Value   = ALLTRIM(.this_cValPend2s)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_FazContas", 4)
                loc_oPg2.txt_4c_FazContas.Value  = ALLTRIM(.this_cFazContas)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_BxPend", 4)
                loc_oPg2.txt_4c_BxPend.Value     = ALLTRIM(.this_cBxPends)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_VVecto", 4)
                loc_oPg2.txt_4c_VVecto.Value     = ALLTRIM(.this_cVVectos)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_HistClis", 4)
                loc_oPg2.txt_4c_HistClis.Value   = ALLTRIM(.this_cHistClis)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Congvs", 4)
                loc_oPg2.txt_4c_Congvs.Value     = ALLTRIM(.this_cCongvs)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Parcelas", 4)
                loc_oPg2.txt_4c_Parcelas.Value   = ALLTRIM(.this_cParcelas)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Consolida", 4)
                loc_oPg2.txt_4c_Consolida.Value  = ALLTRIM(.this_cConsolidas)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Obs", 4)
                loc_oPg2.txt_4c_Obs.Value        = ALLTRIM(.this_cObs)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_EmiCarta", 4)
                loc_oPg2.txt_4c_EmiCarta.Value   = ALLTRIM(.this_cEmiCarts)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_EmiProts", 4)
                loc_oPg2.txt_4c_EmiProts.Value   = ALLTRIM(.this_cEmiProts)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Alinea", 4)
                loc_oPg2.txt_4c_Alinea.Value     = ALLTRIM(.this_cAlineas)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_EmpInd", 4)
                loc_oPg2.txt_4c_EmpInd.Value     = ALLTRIM(.this_cEmpInds)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_EmiInd", 4)
                loc_oPg2.txt_4c_EmiInd.Value     = ALLTRIM(.this_cEmiInds)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Cademis", 4)
                loc_oPg2.txt_4c_Cademis.Value    = ALLTRIM(.this_cCademis)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Devolvido", 4)
                loc_oPg2.txt_4c_Devolvido.Value  = ALLTRIM(.this_cDevolvidos)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Desconto", 4)
                loc_oPg2.txt_4c_Desconto.Value   = .this_nDescontos
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 4)
                loc_oPg2.txt_4c_Moeda.Value      = ALLTRIM(.this_cMoedas)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_DtEmiss", 4)
                loc_oPg2.obj_4c_Opt_DtEmiss.Value = IIF(.this_nNdtEmiss >= 1 AND ;
                    .this_nNdtEmiss <= 3, .this_nNdtEmiss, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_penfin", 4)
                loc_oPg2.obj_4c_Opc_penfin.Value = IIF(.this_nPeFins >= 1 AND ;
                    .this_nPeFins <= 3, .this_nPeFins, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OpComiss", 4)
                loc_oPg2.obj_4c_OpComiss.Value   = IIF(.this_nComiss >= 1 AND ;
                    .this_nComiss <= 3, .this_nComiss, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_LeProts", 4)
                loc_oPg2.obj_4c_Opt_LeProts.Value = IIF(.this_nLeProts >= 1 AND ;
                    .this_nLeProts <= 2, .this_nLeProts, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Prorroga", 4)
                loc_oPg2.obj_4c_Prorroga.Value   = IIF(.this_nProrrogas >= 1 AND ;
                    .this_nProrrogas <= 2, .this_nProrrogas, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_OptTpLeit", 4)
                loc_oPg2.obj_4c_OptTpLeit.Value  = IIF(.this_nTpLeituras >= 1 AND ;
                    .this_nTpLeituras <= 2, .this_nTpLeituras, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Gerarq", 4)
                loc_oPg2.obj_4c_Opc_Gerarq.Value = IIF(.this_nGeranarqs >= 1 AND ;
                    .this_nGeranarqs <= 2, .this_nGeranarqs, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Carteira", 4)
                loc_oPg2.obj_4c_Carteira.Value   = IIF(.this_nCartDbs >= 1 AND ;
                    .this_nCartDbs <= 2, .this_nCartDbs, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_gensit", 4)
                loc_oPg2.obj_4c_Opc_gensit.Value = IIF(.this_nAnaSits >= 1 AND ;
                    .this_nAnaSits <= 2, .this_nAnaSits, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_VencUtil", 4)
                loc_oPg2.obj_4c_VencUtil.Value   = IIF(.this_nVencUtil >= 1 AND ;
                    .this_nVencUtil <= 2, .this_nVencUtil, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_AltDados", 4)
                loc_oPg2.obj_4c_AltDados.Value   = IIF(.this_nAltDados >= 1 AND ;
                    .this_nAltDados <= 2, .this_nAltDados, 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoT", 4)
                loc_oPg2.txt_4c_GrupoT.Value     = ALLTRIM(.this_cGrupoT)
                loc_oPg2.txt_4c_DGrupoT.Value    = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarta", 4)
                loc_oPg2.cmd_4c_BtnCarta.Enabled = ;
                    (UPPER(ALLTRIM(.this_cEmiCarts)) = "S")
            ENDIF
        ENDWITH

        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Necessario pois AddObject() cria controles com Visible=.F. por padrao
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

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
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_BuscaOpt")
            USE IN cursor_4c_BuscaOpt
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * AtualizarEstadoTipoData - InteractiveChange de txt_4c_OpAut
    * Habilita Opc_TipoData somente quando OpAut = "S"
    *==========================================================================
    PROCEDURE AtualizarEstadoTipoData()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_TipoData", 4) AND ;
                PEMSTATUS(loc_oPg2, "txt_4c_OpAut", 4)
            loc_oPg2.obj_4c_Opc_TipoData.Enabled = ;
                (UPPER(ALLTRIM(loc_oPg2.txt_4c_OpAut.Value)) = "S")
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarOpAnts - LostFocus: Movimento Anterior (lookup SigCdOpt)
    *==========================================================================
    PROCEDURE ValidarOpAnts(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_OpAnts", 4)
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPg2.txt_4c_OpAnts.Value)

        IF !EMPTY(loc_cVal)
            THIS.AbrirLookupCanonico("SigCdOpt", "Operacaos", "Descrs", ;
                "Movimento Anterior", loc_cVal, ;
                loc_oPg2.txt_4c_OpAnts, .NULL., "")
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarOpContas - LostFocus: Movimento de Titulos (lookup SIGOPOPE)
    *==========================================================================
    PROCEDURE ValidarOpContas(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_OpContas", 4)
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPg2.txt_4c_OpContas.Value)

        IF !EMPTY(loc_cVal)
            THIS.AbrirLookupCanonico("SIGOPOPE", "Dopes", "Dopes", ;
                "Oper. de T" + CHR(237) + "tulos", loc_cVal, ;
                loc_oPg2.txt_4c_OpContas, .NULL., "Congvs = 1")
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarOpEntrada - LostFocus: Movimento de Entrada (lookup SigCdOpt)
    * Exclui o proprio registro corrente do lookup
    *==========================================================================
    PROCEDURE ValidarOpEntrada(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal, loc_cFiltro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_OpEntrada", 4)
            RETURN
        ENDIF

        loc_cVal    = ALLTRIM(loc_oPg2.txt_4c_OpEntrada.Value)
        loc_cFiltro = ""

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 4) AND ;
                !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
            loc_cFiltro = "Operacaos <> '" + ;
                STRTRAN(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value), "'", "''") + "'"
        ENDIF

        IF !EMPTY(loc_cVal)
            THIS.AbrirLookupCanonico("SigCdOpt", "Operacaos", "Descrs", ;
                "Oper. de Entrada", loc_cVal, ;
                loc_oPg2.txt_4c_OpEntrada, .NULL., loc_cFiltro)
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarFpg - LostFocus: Condicao de Pagamento (lookup SigOpFp)
    *==========================================================================
    PROCEDURE ValidarFpg(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Fpg", 4)
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Fpg.Value)

        IF !EMPTY(loc_cVal)
            THIS.AbrirLookupCanonico("SigOpFp", "fpags", "fpags", ;
                "Condi" + CHR(231) + CHR(227) + "o Pagto", loc_cVal, ;
                loc_oPg2.txt_4c_Fpg, .NULL., "Infos = 'C' AND EmiChqs <> 1")
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarSituacao - LostFocus: Situacao do Cliente (lookup SigCdCst)
    *==========================================================================
    PROCEDURE ValidarSituacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Situa", 4)
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Situa.Value)

        IF !EMPTY(loc_cVal)
            THIS.AbrirLookupCanonico("SigCdCst", "codigos", "descrs", ;
                "Situa" + CHR(231) + CHR(245) + "es", loc_cVal, ;
                loc_oPg2.txt_4c_Situa, .NULL., "Priors BETWEEN 1 AND 998")
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarHispad - LostFocus: Grupo Emissor Default (fAcessoContab)
    *==========================================================================
    PROCEDURE ValidarHispad(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Hispad", 4)
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Hispad.Value)

        TRY
            IF !EMPTY(loc_cVal)
                fAcessoContab(Usuar, "C", loc_cVal, loc_oPg2.txt_4c_Hispad)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar Grupo Emissor:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarHispad")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarResponsavel - LostFocus: Responsavel (fAcessoContab)
    *==========================================================================
    PROCEDURE ValidarResponsavel(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Respons", 4)
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Respons.Value)

        TRY
            IF !EMPTY(loc_cVal)
                fAcessoContab(Usuar, "C", loc_cVal, loc_oPg2.txt_4c_Respons)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar Respons" + CHR(225) + "vel:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarResponsavel")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarCentral - LostFocus: Central de Credito por codigo (lookup SIGCCCCO)
    *==========================================================================
    PROCEDURE ValidarCentral(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Central", 4)
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Central.Value)

        IF !EMPTY(loc_cVal)
            THIS.AbrirLookupCanonico("SIGCCCCO", "Cods", "Descs", ;
                "Central de Cr" + CHR(233) + "dito", loc_cVal, ;
                loc_oPg2.txt_4c_Central, loc_oPg2.txt_4c_DCentral, "")
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDescCentral - LostFocus: Central de Credito por descricao
    *==========================================================================
    PROCEDURE ValidarDescCentral(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cDesc
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_DCentral", 4)
            RETURN
        ENDIF

        loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DCentral.Value)

        IF !EMPTY(loc_cDesc)
            THIS.AbrirLookupCanonico("SIGCCCCO", "Descs", "Cods", ;
                "Central de Cr" + CHR(233) + "dito", loc_cDesc, ;
                loc_oPg2.txt_4c_DCentral, loc_oPg2.txt_4c_Central, "")
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarGrupoOrig - LostFocus: Grupo de Origem por codigo (fAcessoContab)
    *==========================================================================
    PROCEDURE ValidarGrupoOrig(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_GrupoOs", 4)
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)

        TRY
            IF !EMPTY(loc_cVal)
                fAcessoContab(Usuar, "C", loc_cVal, ;
                    loc_oPg2.txt_4c_GrupoOs, loc_oPg2.txt_4c_DGrupoOs)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar Grupo/Origem:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarGrupoOrig")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDescGrupoOrig - LostFocus: Grupo de Origem por descricao (fAcessoContab 'D')
    *==========================================================================
    PROCEDURE ValidarDescGrupoOrig(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cDesc, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_DGrupoOs", 4)
            RETURN
        ENDIF

        loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DGrupoOs.Value)

        TRY
            IF !EMPTY(loc_cDesc)
                fAcessoContab(Usuar, "D", loc_cDesc, ;
                    loc_oPg2.txt_4c_GrupoOs, loc_oPg2.txt_4c_DGrupoOs)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar desc. Grupo/Origem:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarDescGrupoOrig")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarGrupoDest - LostFocus: Grupo de Destino por codigo (fAcessoContab)
    *==========================================================================
    PROCEDURE ValidarGrupoDest(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 4)
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)

        TRY
            IF !EMPTY(loc_cVal)
                fAcessoContab(Usuar, "C", loc_cVal, ;
                    loc_oPg2.txt_4c_Grupo, loc_oPg2.txt_4c__ds_grupo)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar Grupo/Destino:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarGrupoDest")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDescGrupoDest - LostFocus: Grupo de Destino por descricao (fAcessoContab 'D')
    *==========================================================================
    PROCEDURE ValidarDescGrupoDest(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cDesc, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c__ds_grupo", 4)
            RETURN
        ENDIF

        loc_cDesc = ALLTRIM(loc_oPg2.txt_4c__ds_grupo.Value)

        TRY
            IF !EMPTY(loc_cDesc)
                fAcessoContab(Usuar, "D", loc_cDesc, ;
                    loc_oPg2.txt_4c_Grupo, loc_oPg2.txt_4c__ds_grupo)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar desc. Grupo/Destino:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarDescGrupoDest")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarContaOrig - LostFocus: Conta de Origem por codigo (fAcessoContas)
    *==========================================================================
    PROCEDURE ValidarContaOrig(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal, loc_cGrupoOs, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_ContaOs", 4)
            RETURN
        ENDIF

        loc_cVal     = ALLTRIM(loc_oPg2.txt_4c_ContaOs.Value)
        loc_cGrupoOs = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoOs", 4)
            loc_cGrupoOs = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)
        ENDIF

        TRY
            IF !EMPTY(loc_cVal)
                fAcessoContas(Usuar, loc_cGrupoOs, "C", loc_cVal, ;
                    loc_oPg2.txt_4c_ContaOs, loc_oPg2.txt_4c_DContaOs)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar Conta/Origem:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarContaOrig")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDescContaOrig - LostFocus: Conta de Origem por descricao (fAcessoContas 'D')
    *==========================================================================
    PROCEDURE ValidarDescContaOrig(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cDesc, loc_cGrupoOs, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_DContaOs", 4)
            RETURN
        ENDIF

        loc_cDesc    = ALLTRIM(loc_oPg2.txt_4c_DContaOs.Value)
        loc_cGrupoOs = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoOs", 4)
            loc_cGrupoOs = ALLTRIM(loc_oPg2.txt_4c_GrupoOs.Value)
        ENDIF

        TRY
            IF !EMPTY(loc_cDesc)
                fAcessoContas(Usuar, loc_cGrupoOs, "D", loc_cDesc, ;
                    loc_oPg2.txt_4c_ContaOs, loc_oPg2.txt_4c_DContaOs)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar desc. Conta/Origem:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarDescContaOrig")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarContaDest - LostFocus: Conta de Destino por codigo (fAcessoContas)
    *==========================================================================
    PROCEDURE ValidarContaDest(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal, loc_cGrupo, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Conta", 4)
            RETURN
        ENDIF

        loc_cVal   = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
        loc_cGrupo = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 4)
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
        ENDIF

        TRY
            IF !EMPTY(loc_cVal)
                fAcessoContas(Usuar, loc_cGrupo, "C", loc_cVal, ;
                    loc_oPg2.txt_4c_Conta, loc_oPg2.txt_4c_DConta)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar Conta/Destino:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarContaDest")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDescContaDest - LostFocus: Conta de Destino por descricao (fAcessoContas 'D')
    *==========================================================================
    PROCEDURE ValidarDescContaDest(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cDesc, loc_cGrupo, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_DConta", 4)
            RETURN
        ENDIF

        loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c_DConta.Value)
        loc_cGrupo = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 4)
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
        ENDIF

        TRY
            IF !EMPTY(loc_cDesc)
                fAcessoContas(Usuar, loc_cGrupo, "D", loc_cDesc, ;
                    loc_oPg2.txt_4c_Conta, loc_oPg2.txt_4c_DConta)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar desc. Conta/Destino:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarDescContaDest")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarGrupoT - LostFocus: Grupo Terceiro por codigo (fAcessoContab)
    *==========================================================================
    PROCEDURE ValidarGrupoT(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_GrupoT", 4)
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPg2.txt_4c_GrupoT.Value)

        TRY
            IF !EMPTY(loc_cVal)
                fAcessoContab(Usuar, "C", loc_cVal, ;
                    loc_oPg2.txt_4c_GrupoT, loc_oPg2.txt_4c_DGrupoT)
            ELSE
                IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupoT", 4)
                    loc_oPg2.txt_4c_DGrupoT.Value = ""
                ENDIF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar Grupo Terceiro:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarGrupoT")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDescGrupoT - LostFocus: Grupo Terceiro por descricao (fAcessoContab 'D')
    *==========================================================================
    PROCEDURE ValidarDescGrupoT(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cDesc, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_DGrupoT", 4)
            RETURN
        ENDIF

        loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DGrupoT.Value)

        TRY
            IF !EMPTY(loc_cDesc)
                fAcessoContab(Usuar, "D", loc_cDesc, ;
                    loc_oPg2.txt_4c_GrupoT, loc_oPg2.txt_4c_DGrupoT)
            ELSE
                IF PEMSTATUS(loc_oPg2, "txt_4c_GrupoT", 4)
                    loc_oPg2.txt_4c_GrupoT.Value = ""
                ENDIF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao validar desc. Grupo Terceiro:" + CHR(13) + ;
                loc_oErro.Message, "FormOpt.ValidarDescGrupoT")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarMoedas - LostFocus: Moeda (lookup SigCdMoe)
    *==========================================================================
    PROCEDURE ValidarMoedas(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cVal
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O" OR !PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 4)
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)

        IF !EMPTY(loc_cVal)
            THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", ;
                "Moeda", loc_cVal, ;
                loc_oPg2.txt_4c_Moeda, .NULL., "")
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarEstadoCarta - InteractiveChange de txt_4c_EmiCarta
    * Habilita cmd_4c_BtnCarta somente quando EmiCarta = "S"
    *==========================================================================
    PROCEDURE AtualizarEstadoCarta()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarta", 4) AND ;
                PEMSTATUS(loc_oPg2, "txt_4c_EmiCarta", 4)
            loc_oPg2.cmd_4c_BtnCarta.Enabled = ;
                (UPPER(ALLTRIM(loc_oPg2.txt_4c_EmiCarta.Value)) = "S")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCartaClick - Abre formulario SigOpCoc (configuracao de carta)
    *==========================================================================
    PROCEDURE BtnCartaClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            MsgAviso("Funcionalidade SigOpCoc n" + CHR(227) + "o migrada ainda.", ;
                "FormOpt")
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir carta:" + CHR(13) + loc_oErro.Message, ;
                "FormOpt.BtnCartaClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AbrirLookupCanonico - Helper para lookup via FormBuscaAuxiliar (Pattern A)
    * SQL no caller -> CREATEOBJECT sem params -> DefinirCursor -> Mostrar
    * -> ler .cCodigoSelecionado/.cDescricaoSelecionada (nao cursor)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
            par_cTitulo, par_cValor, par_oCtrlCod, par_oCtrlDesc, par_cFiltro)
        LOCAL loc_oBusca, loc_cCursorBusca, loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
        loc_lResultado   = .F.
        loc_cCursorBusca = "cursor_4c_LkpCanon"

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cWhere = " AND (" + par_cFiltro + ")"
            ENDIF

            *-- Passo 1: busca exata via SQL no caller (DataSession=2)
            loc_cSQL = "SELECT " + par_cCampoCod
            IF !EMPTY(par_cCampoDesc) AND par_cCampoDesc != par_cCampoCod
                loc_cSQL = loc_cSQL + ", " + par_cCampoDesc
            ENDIF
            loc_cSQL = loc_cSQL + " FROM " + par_cTabela + ;
                " WHERE CAST(" + par_cCampoCod + " AS VARCHAR(50)) = " + ;
                EscaparSQL(UPPER(ALLTRIM(par_cValor))) + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorBusca)

            IF loc_nResult > 0 AND USED(loc_cCursorBusca) AND RECCOUNT(loc_cCursorBusca) = 1
                *-- Exato encontrado: popula controles diretamente
                SELECT (loc_cCursorBusca)
                IF VARTYPE(par_oCtrlCod) = "O"
                    par_oCtrlCod.Value = ALLTRIM(&par_cCampoCod)
                ENDIF
                IF VARTYPE(par_oCtrlDesc) = "O" AND !EMPTY(par_cCampoDesc) ;
                        AND par_cCampoDesc != par_cCampoCod
                    par_oCtrlDesc.Value = ALLTRIM(&par_cCampoDesc)
                ENDIF
                loc_lResultado = .T.
            ELSE
                *-- Nao encontrou exato: busca parcial para picker
                IF USED(loc_cCursorBusca)
                    USE IN (loc_cCursorBusca)
                ENDIF

                loc_cSQL = "SELECT " + par_cCampoCod
                IF !EMPTY(par_cCampoDesc) AND par_cCampoDesc != par_cCampoCod
                    loc_cSQL = loc_cSQL + ", " + par_cCampoDesc
                ENDIF
                loc_cSQL = loc_cSQL + " FROM " + par_cTabela + ;
                    " WHERE CAST(" + par_cCampoCod + " AS VARCHAR(50)) LIKE " + ;
                    EscaparSQL(UPPER(ALLTRIM(par_cValor)) + "%") + loc_cWhere + ;
                    " ORDER BY " + par_cCampoCod
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorBusca)

                IF loc_nResult <= 0 OR !USED(loc_cCursorBusca) OR ;
                        RECCOUNT(loc_cCursorBusca) = 0
                    *-- Fallback show-all (sem filtro de valor, respeita par_cFiltro)
                    IF USED(loc_cCursorBusca)
                        USE IN (loc_cCursorBusca)
                    ENDIF
                    loc_cSQL = "SELECT " + par_cCampoCod
                    IF !EMPTY(par_cCampoDesc) AND par_cCampoDesc != par_cCampoCod
                        loc_cSQL = loc_cSQL + ", " + par_cCampoDesc
                    ENDIF
                    loc_cSQL = loc_cSQL + " FROM " + par_cTabela
                    IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                        loc_cSQL = loc_cSQL + " WHERE (" + par_cFiltro + ")"
                    ENDIF
                    loc_cSQL = loc_cSQL + " ORDER BY " + par_cCampoCod
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorBusca)
                ENDIF

                IF loc_nResult > 0 AND USED(loc_cCursorBusca) AND ;
                        RECCOUNT(loc_cCursorBusca) > 0
                    *-- Abre picker sem params (Pattern A canonico)
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.DefinirCursor(loc_cCursorBusca, par_cCampoCod, ;
                            IIF(!EMPTY(par_cCampoDesc), par_cCampoDesc, par_cCampoCod), ;
                            par_cTitulo)
                        loc_oBusca.this_cCursorDestino = loc_cCursorBusca
                        loc_oBusca.Mostrar()
                        IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                            IF VARTYPE(par_oCtrlCod) = "O"
                                par_oCtrlCod.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                            ENDIF
                            IF VARTYPE(par_oCtrlDesc) = "O" AND !EMPTY(par_cCampoDesc) ;
                                    AND par_cCampoDesc != par_cCampoCod
                                par_oCtrlDesc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                            ENDIF
                            loc_lResultado = .T.
                        ENDIF
                        loc_oBusca.Release()
                        loc_oBusca = .NULL.
                    ENDIF
                ELSE
                    MsgAviso("Nenhum registro encontrado em " + par_cTabela + ".", par_cTitulo)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro no lookup " + par_cTitulo + ":" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "AbrirLookupCanonico")
        ENDTRY

        IF USED(loc_cCursorBusca)
            USE IN (loc_cCursorBusca)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
