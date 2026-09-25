*==============================================================================
* Formsigmvccr.prg - Formulario de Cadastro de Conta Corrente Geral
* Migrado de: SIGMVCCR.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS Formsigmvccr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
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

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Controle de dedup dos handlers de LostFocus (evita reabrir lookup/
    *-- refazer validacao quando o campo perde foco sem o valor ter mudado)
    this_cUltimoGrupoValidado    = ""
    this_cUltimaContaValidada    = ""
    this_cUltimaMoedaValidada    = ""
    this_cUltimoSGrupoValidado   = ""
    this_cUltimaSContaValidada   = ""
    this_cUltimaSMoedaValidada   = ""
    this_cUltimoJobValidado      = ""

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
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
            THIS.this_oBusinessObject = CREATEOBJECT("sigmvccrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar sigmvccrBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigmvccr.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formsigmvccr:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formsigmvccr.InicializarForm")
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
    * ConfigurarPaginaLista - Estrutura completa de Page1 (Lista)
    * Cabecalho, filtro de periodo, grid de lancamentos e botoes CRUD
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCnt, loc_oCntP, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
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

        *-- Container Botoes CRUD (canonico framework: Left=542, Top=29, Width=390, Height=85)
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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de Saida (canonico CLAUDE.md regra #10 - prevalece sobre PILAR 1)
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Filtro de periodo (legado: cntFiltros.Top=83, Cnt_periodo Left=14,Top=-3)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_Filtros
        WITH loc_oCnt
            .Top         = 112
            .Left        = 5
            .Width       = 642
            .Height      = 29
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("cnt_4c__periodo", "Container")
        loc_oCntP = loc_oCnt.cnt_4c__periodo
        WITH loc_oCntP
            .Top         = -3
            .Left        = 14
            .Width       = 271
            .Height      = 36
            .BackStyle   = 0
            .BorderWidth = 0
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        loc_oCntP.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCntP.lbl_4c_Label1
            .Caption   = "Per" + CHR(237) + "odo : "
            .Top       = 10
            .Left      = 17
            .Width     = 54
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCntP.AddObject("txt_4c_Dt_inicial", "TextBox")
        WITH loc_oCntP.txt_4c_Dt_inicial
            .Top       = 6
            .Left      = 73
            .Width     = 80
            .Height    = 21
            .Value     = DATE()
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oCntP.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")

        loc_oCntP.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCntP.lbl_4c_Label2
            .Caption   = "at" + CHR(233)
            .Top       = 10
            .Left      = 158
            .Width     = 20
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCntP.AddObject("txt_4c_Dt_final", "TextBox")
        WITH loc_oCntP.txt_4c_Dt_final
            .Top       = 6
            .Left      = 184
            .Width     = 80
            .Height    = 21
            .Value     = DATE()
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oCntP.txt_4c_Dt_final, "KeyPress", THIS, "ValidarDataFinal")

        *-- Grid de lancamentos (legado: Grade Top=115,Left=23,Width=944,Height=473)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        WITH loc_oGrid
            .Top                = 144
            .Left               = 23
            .Width              = 944
            .Height             = 473
            .ColumnCount        = 11
            .RecordSourceType   = 1
            .ReadOnly           = .T.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 2
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RowHeight          = 16
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Visible            = .T.

            .Column1.Width      = 78
            .Column1.Alignment  = 2
            .Column1.FontSize   = 8
            .Column1.ReadOnly   = .T.
            .Column1.Header1.Caption   = "Data"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(90, 90, 90)

            .Column2.Width      = 83
            .Column2.FontSize   = 8
            .Column2.ReadOnly   = .T.
            .Column2.Header1.Caption   = "Conta"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(90, 90, 90)

            .Column3.Width      = 83
            .Column3.FontSize   = 8
            .Column3.ReadOnly   = .T.
            .Column3.Header1.Caption   = "Contrapartida"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(90, 90, 90)

            .Column4.Width      = 280
            .Column4.FontSize   = 7
            .Column4.ReadOnly   = .T.
            .Column4.Header1.Caption   = "Hist" + CHR(243) + "rico"
            .Column4.Header1.Alignment = 2
            .Column4.Header1.ForeColor = RGB(90, 90, 90)

            .Column5.Width      = 80
            .Column5.FontSize   = 8
            .Column5.ReadOnly   = .T.
            .Column5.InputMask  = "999,999,999.99"
            .Column5.Header1.Caption   = "D" + CHR(233) + "bito"
            .Column5.Header1.Alignment = 2
            .Column5.Header1.ForeColor = RGB(90, 90, 90)

            .Column6.Width      = 80
            .Column6.FontSize   = 8
            .Column6.ReadOnly   = .T.
            .Column6.InputMask  = "999,999,999.99"
            .Column6.Header1.Caption   = "Cr" + CHR(233) + "dito"
            .Column6.Header1.Alignment = 2
            .Column6.Header1.ForeColor = RGB(90, 90, 90)

            .Column7.Width      = 28
            .Column7.FontSize   = 7
            .Column7.ReadOnly   = .T.
            .Column7.Header1.Caption   = ""
            .Column7.Header1.Alignment = 2
            .Column7.Header1.ForeColor = RGB(90, 90, 90)

            .Column8.Width      = 28
            .Column8.FontSize   = 7
            .Column8.ReadOnly   = .T.
            .Column8.Header1.Caption   = " "
            .Column8.Header1.Alignment = 2
            .Column8.Header1.ForeColor = RGB(90, 90, 90)

            .Column9.Width      = 78
            .Column9.FontSize   = 8
            .Column9.ReadOnly   = .T.
            .Column9.Header1.Caption   = "NF"
            .Column9.Header1.Alignment = 2
            .Column9.Header1.ForeColor = RGB(90, 90, 90)

            .Column10.Width      = 78
            .Column10.FontSize   = 8
            .Column10.ReadOnly   = .T.
            .Column10.Header1.Caption   = "Documento"
            .Column10.Header1.Alignment = 2
            .Column10.Header1.ForeColor = RGB(90, 90, 90)

            .Column11.Width      = 17
            .Column11.Alignment  = 2
            .Column11.FontSize   = 8
            .Column11.ReadOnly   = .T.
            .Column11.Header1.Caption   = "O"
            .Column11.Header1.Alignment = 2
            .Column11.Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
    * Campos e botoes de acao serao adicionados nas proximas fases
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - CLAUDE.md regra #11
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container BotoesAcao (Grupo_Salva legado: Left=819, Top=9, Width=160, Height=85)
        *-- Com compensacao PageFrame +29: Top=33 (4+29), Left=842
        *-- Botoes Confirmar/Cancelar serao adicionados nas proximas fases
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top       = 33
            .Left      = 842
            .Width     = 160
            .Height    = 85
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Shape1 (legado Top=153,Left=9,Width=980,Height=64) - moldura da linha superior
        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top    = 182
            .Left   = 9
            .Width  = 980
            .Height = 64
            .Visible = .T.
        ENDWITH

        *-- Shape3 (legado Top=224,Left=9,Width=485,Height=117) - moldura do painel D (lado esquerdo)
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top    = 253
            .Left   = 9
            .Width  = 485
            .Height = 117
            .Visible = .T.
        ENDWITH

        *-- Linha superior: Lancamento / Vencimento / Emissao / Nota Fiscal / Documento / Usuario / Job
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Lan" + CHR(231) + "amento :"
            .Top       = 194
            .Left      = 43
            .Width     = 65
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fweditdata_DATA", "TextBox")
        WITH loc_oPagina.txt_4c_Fweditdata_DATA
            .Top      = 190
            .Left     = 112
            .Width    = 80
            .Height   = 21
            .Value    = {}
            .InputMask = "99/99/9999"
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible  = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "Vencimento :"
            .Top       = 194
            .Left      = 234
            .Width     = 62
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fweditdata_VENC", "TextBox")
        WITH loc_oPagina.txt_4c_Fweditdata_VENC
            .Top      = 190
            .Left     = 300
            .Width    = 80
            .Height   = 21
            .Value    = {}
            .InputMask = "99/99/9999"
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible  = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Caption   = "Emiss" + CHR(227) + "o :"
            .Top       = 194
            .Left      = 435
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtEmis", "TextBox")
        WITH loc_oPagina.txt_4c_DtEmis
            .Top      = 190
            .Left     = 484
            .Width    = 80
            .Height   = 21
            .Value    = {}
            .InputMask = "99/99/9999"
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible  = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Nota Fiscal :"
            .Top       = 194
            .Left      = 615
            .Width     = 59
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
        WITH loc_oPagina.txt_4c_Nota
            .Top       = 190
            .Left      = 678
            .Width     = 80
            .Height    = 21
            .Value     = ""
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Top       = 194
            .Left      = 818
            .Width     = 43
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__Usuario", "TextBox")
        WITH loc_oPagina.txt_4c__Usuario
            .Top       = 190
            .Left      = 865
            .Width     = 80
            .Height    = 21
            .Value     = ""
            .MaxLength = 10
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPagina.lbl_4c_Label17
            .Caption   = "Job :"
            .Top       = 220
            .Left      = 84
            .Width     = 24
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Job", "TextBox")
        WITH loc_oPagina.txt_4c_Job
            .Top       = 216
            .Left      = 112
            .Width     = 80
            .Height    = 23
            .Value     = ""
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DJob", "TextBox")
        WITH loc_oPagina.txt_4c_DJob
            .Top       = 216
            .Left      = 195
            .Width     = 290
            .Height    = 23
            .Value     = ""
            .MaxLength = 60
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Documento :"
            .Top       = 220
            .Left      = 613
            .Width     = 61
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DOCU", "TextBox")
        WITH loc_oPagina.txt_4c_DOCU
            .Top       = 216
            .Left      = 678
            .Width     = 80
            .Height    = 21
            .Value     = ""
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        *-- Painel D (lado esquerdo, dentro de shp_4c_Shape3): Movimento/Grupo/Conta/Valor/Moeda/Cambio
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Movimento :"
            .Top       = 264
            .Left      = 49
            .Width     = 59
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OPER", "TextBox")
        WITH loc_oPagina.txt_4c_OPER
            .Top       = 260
            .Left      = 112
            .Width     = 15
            .Height    = 21
            .Value     = ""
            .MaxLength = 1
            .InputMask = "!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPagina.lbl_4c_Label18
            .Caption   = "[D/C]"
            .Top       = 264
            .Left      = 130
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Grupo :"
            .Top       = 290
            .Left      = 72
            .Width     = 36
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Top       = 286
            .Left      = 112
            .Width     = 80
            .Height    = 23
            .Value     = ""
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dgrupo", "TextBox")
        WITH loc_oPagina.txt_4c_Dgrupo
            .Top       = 286
            .Left      = 195
            .Width     = 290
            .Height    = 21
            .Value     = ""
            .MaxLength = 40
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Conta :"
            .Top       = 316
            .Left      = 72
            .Width     = 36
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Top       = 312
            .Left      = 112
            .Width     = 80
            .Height    = 21
            .Value     = ""
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPagina.txt_4c_Dconta
            .Top       = 312
            .Left      = 195
            .Width     = 290
            .Height    = 21
            .Value     = ""
            .MaxLength = 40
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Valor :"
            .Top       = 342
            .Left      = 77
            .Width     = 31
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_VALOR", "TextBox")
        WITH loc_oPagina.txt_4c_VALOR
            .Top       = 338
            .Left      = 112
            .Width     = 128
            .Height    = 23
            .Value     = 0
            .InputMask = "999,999,999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_MOEDA", "TextBox")
        WITH loc_oPagina.txt_4c_MOEDA
            .Top       = 338
            .Left      = 243
            .Width     = 31
            .Height    = 21
            .Value     = ""
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c__Cotacao", "Label")
        WITH loc_oPagina.lbl_4c__Cotacao
            .Caption   = "C" + CHR(226) + "mbio :"
            .Top       = 342
            .Left      = 303
            .Width     = 42
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_COTACAO", "TextBox")
        WITH loc_oPagina.txt_4c_COTACAO
            .Top       = 338
            .Left      = 349
            .Width     = 108
            .Height    = 21
            .Value     = 0
            .InputMask = "99,999.9999999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Alteracotacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Alteracotacao
            .Caption   = "$"
            .Top       = 338
            .Left      = 461
            .Width     = 24
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Alteracotacao, "Click", THIS, "BtnAlterarCotacaoClick")

        *-- BINDEVENTs dos campos ja criados nesta pagina (Grupo/Conta/Moeda/
        *-- Valor/Cotacao/Job) - LostFocus reproduz o Valid do legado
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
        BINDEVENT(loc_oPagina.txt_4c_Dconta, "KeyPress", THIS, "ValidarDconta")
        BINDEVENT(loc_oPagina.txt_4c_MOEDA, "KeyPress", THIS, "ValidarMoeda")
        BINDEVENT(loc_oPagina.txt_4c_VALOR, "KeyPress", THIS, "ValidarValor")
        BINDEVENT(loc_oPagina.txt_4c_COTACAO, "KeyPress", THIS, "ValidarCotacao")
        BINDEVENT(loc_oPagina.txt_4c_Job, "KeyPress", THIS, "ValidarJob")

        *-- Shape2 (legado Top=224,Left=504,Width=485,Height=117) - moldura do
        *-- painel S (contrapartida)
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top     = 253
            .Left    = 504
            .Width   = 485
            .Height  = 117
            .Visible = .T.
        ENDWITH

        *-- Painel S (lado direito, dentro de shp_4c_Shape2): Movimento/Grupo/
        *-- Conta/Valor/Moeda/Cambio da contrapartida (espelho do painel D)
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "Movimento :"
            .Top       = 264
            .Left      = 544
            .Width     = 59
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_SOPER", "TextBox")
        WITH loc_oPagina.txt_4c_SOPER
            .Top       = 260
            .Left      = 607
            .Width     = 15
            .Height    = 21
            .Value     = ""
            .MaxLength = 1
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = "[D/C]"
            .Top       = 264
            .Left      = 626
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Grupo :"
            .Top       = 290
            .Left      = 567
            .Width     = 36
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_SGRUPO", "TextBox")
        WITH loc_oPagina.txt_4c_SGRUPO
            .Top       = 286
            .Left      = 607
            .Width     = 80
            .Height    = 23
            .Value     = ""
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SGRUPO, "KeyPress", THIS, "ValidarSGrupo")

        loc_oPagina.AddObject("txt_4c_Sdgrupo", "TextBox")
        WITH loc_oPagina.txt_4c_Sdgrupo
            .Top       = 286
            .Left      = 689
            .Width     = 290
            .Height    = 21
            .Value     = ""
            .MaxLength = 40
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Conta :"
            .Top       = 316
            .Left      = 567
            .Width     = 36
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_SCONTA", "TextBox")
        WITH loc_oPagina.txt_4c_SCONTA
            .Top       = 312
            .Left      = 607
            .Width     = 80
            .Height    = 21
            .Value     = ""
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SCONTA, "KeyPress", THIS, "ValidarSConta")

        loc_oPagina.AddObject("txt_4c_SDCONTA", "TextBox")
        WITH loc_oPagina.txt_4c_SDCONTA
            .Top       = 312
            .Left      = 689
            .Width     = 290
            .Height    = 21
            .Value     = ""
            .MaxLength = 50
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SDCONTA, "KeyPress", THIS, "ValidarSDconta")

        loc_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPagina.lbl_4c_Label16
            .Caption   = "Valor :"
            .Top       = 342
            .Left      = 572
            .Width     = 31
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_SVALOR", "TextBox")
        WITH loc_oPagina.txt_4c_SVALOR
            .Top       = 338
            .Left      = 607
            .Width     = 128
            .Height    = 23
            .Value     = 0
            .InputMask = "999,999,999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SVALOR, "KeyPress", THIS, "ValidarSValor")

        loc_oPagina.AddObject("txt_4c_Smoeda", "TextBox")
        WITH loc_oPagina.txt_4c_Smoeda
            .Top       = 338
            .Left      = 737
            .Width     = 31
            .Height    = 21
            .Value     = ""
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Smoeda, "KeyPress", THIS, "ValidarSmoeda")

        loc_oPagina.AddObject("lbl_4c__sCotacao", "Label")
        WITH loc_oPagina.lbl_4c__sCotacao
            .Caption   = "C" + CHR(226) + "mbio :"
            .Top       = 342
            .Left      = 797
            .Width     = 42
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_SCOTACAO", "TextBox")
        WITH loc_oPagina.txt_4c_SCOTACAO
            .Top       = 338
            .Left      = 843
            .Width     = 108
            .Height    = 21
            .Value     = 0
            .InputMask = "99,999.9999999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SCOTACAO, "KeyPress", THIS, "ValidarSCotacao")

        loc_oPagina.AddObject("cmd_4c_Alterascotacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Alterascotacao
            .Caption   = "$"
            .Top       = 338
            .Left      = 955
            .Width     = 24
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Alterascotacao, "Click", THIS, "BtnAlterarSCotacaoClick")

        *-- Shape6 (legado Top=350,Left=9,Width=980,Height=39) - moldura do
        *-- historico (Get_HIST + Get_Hist2 + Lancar Contas)
        loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
        WITH loc_oPagina.shp_4c_Shape6
            .Top     = 379
            .Left    = 9
            .Width   = 980
            .Height  = 39
            .Visible = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Hist" + CHR(243) + "rico :"
            .Top       = 391
            .Left      = 60
            .Width     = 52
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_HIST", "TextBox")
        WITH loc_oPagina.txt_4c_HIST
            .Top       = 387
            .Left      = 112
            .Width     = 300
            .Height    = 21
            .Value     = ""
            .MaxLength = 60
            .Format    = "K!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
        WITH loc_oPagina.txt_4c_Hist2
            .Top       = 387
            .Left      = 415
            .Width     = 300
            .Height    = 21
            .Value     = ""
            .MaxLength = 80
            .Format    = "K!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .SpecialEffect = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPagina.lbl_4c_Label19
            .Caption   = "Lan" + CHR(231) + "ar Contas :"
            .Top       = 391
            .Left      = 758
            .Width     = 76
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Lancar Contas (legado Opcao_conta: Option1="Sim"
        *-- Value=0, Option2="Nao" Value=1 - ControlSource craltcc.contapgs)
        loc_oPagina.AddObject("obj_4c_Opcao_conta", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opcao_conta
            .Top         = 385
            .Left        = 844
            .Width       = 99
            .Height      = 27
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opcao_conta.Buttons(1)
            .Caption   = "Sim"
            .Value     = 0
            .Left      = 5
            .Top       = 5
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opcao_conta.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Value     = 1
            .Left      = 57
            .Top       = 6
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega grade de lancamentos filtrada por periodo
    * Legado (sqldados): filtra SEMPRE por Datas Between Dt_inicial e Dt_final,
    * nunca traz a tabela inteira (CLAUDE.md regra #35a)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_oPeriodo, loc_dDtI, loc_dDtF, loc_tDtF, loc_cFiltro
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                LOCAL loc_nDsAtual
                loc_nDsAtual = THIS.DataSessionID
                SET DATASESSION TO 1
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados ;
                    (cidchaves C(20), datas T, contas C(10), scontas C(10), hists C(60), ;
                     valors N(11,2), svalors N(11,2), smoedas C(3), moedas C(3), ;
                     nfs C(10), docus C(10), opers C(1))
                SET NULL OFF
                SET DATASESSION TO (loc_nDsAtual)
                loc_lResultado = .T.
            ELSE
                loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c__periodo

                loc_dDtI = loc_oPeriodo.txt_4c_Dt_inicial.Value
                loc_dDtF = loc_oPeriodo.txt_4c_Dt_final.Value

                IF EMPTY(loc_dDtI)
                    loc_dDtI = DATE()
                ENDIF
                IF EMPTY(loc_dDtF)
                    loc_dDtF = DATE()
                ENDIF

                loc_tDtF = DATETIME(YEAR(loc_dDtF), MONTH(loc_dDtF), DAY(loc_dDtF), 23, 59, 59)

                loc_cFiltro = "AND a.datas BETWEEN " + FormatarDataSQL(loc_dDtI) + ;
                    " AND " + FormatarDataSQL(loc_tDtF)

                IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    loc_oGrid.Column1.ControlSource  = "TTOD(cursor_4c_Dados.datas)"
                    loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.contas"
                    loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.scontas"
                    loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.hists"
                    loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.valors"
                    loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.svalors"
                    loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.smoedas"
                    loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.moedas"
                    loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.nfs"
                    loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.docus"
                    loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.opers"

                    *-- RecordSource/ControlSource resetam os cabecalhos (CLAUDE.md
                    *-- FORMCOR_LICOES Problema 2) - reconfigurar SEMPRE apos
                    loc_oGrid.Column1.Header1.Caption  = "Data"
                    loc_oGrid.Column2.Header1.Caption  = "Conta"
                    loc_oGrid.Column3.Header1.Caption  = "Contrapartida"
                    loc_oGrid.Column4.Header1.Caption  = "Hist" + CHR(243) + "rico"
                    loc_oGrid.Column5.Header1.Caption  = "D" + CHR(233) + "bito"
                    loc_oGrid.Column6.Header1.Caption  = "Cr" + CHR(233) + "dito"
                    loc_oGrid.Column7.Header1.Caption  = ""
                    loc_oGrid.Column8.Header1.Caption  = " "
                    loc_oGrid.Column9.Header1.Caption  = "NF"
                    loc_oGrid.Column10.Header1.Caption = "Documento"
                    loc_oGrid.Column11.Header1.Caption = "O"

                    IF USED("cursor_4c_Dados")
                        GO TOP IN cursor_4c_Dados
                    ENDIF
                    loc_oGrid.Refresh()

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Formsigmvccr.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            IF .ColumnCount > 0
                .FontName = "Tahoma"
            ENDIF
        ENDWITH
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * ValidarDataInicial - LostFocus do campo Dt_inicial (legado: Dt_inicial.Valid)
    *===========================================================================
    PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPeriodo
        loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c__periodo

        IF !EMPTY(loc_oPeriodo.txt_4c_Dt_inicial.Value) AND !EMPTY(loc_oPeriodo.txt_4c_Dt_final.Value)
            IF loc_oPeriodo.txt_4c_Dt_inicial.Value > loc_oPeriodo.txt_4c_Dt_final.Value
                loc_oPeriodo.txt_4c_Dt_final.Value = loc_oPeriodo.txt_4c_Dt_inicial.Value
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarDataFinal - LostFocus do campo Dt_final (legado: Dt_final.Valid
    * chama ThisForm.SqlDados apos validar o cruzamento das datas)
    *===========================================================================
    PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPeriodo
        loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c__periodo

        IF !EMPTY(loc_oPeriodo.txt_4c_Dt_inicial.Value) AND !EMPTY(loc_oPeriodo.txt_4c_Dt_final.Value)
            IF loc_oPeriodo.txt_4c_Dt_final.Value < loc_oPeriodo.txt_4c_Dt_inicial.Value
                loc_oPeriodo.txt_4c_Dt_inicial.Value = loc_oPeriodo.txt_4c_Dt_final.Value
            ENDIF
        ENDIF

        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * AvisarPrimeiroLancamento - Legado (ChkRegister('SigMvSlc', laCampo))
    * avisa quando Grupo+Conta+Moeda ainda nao tem nenhum lancamento em
    * SigMvSlc. Na arquitetura nova nao existe ThisForm.podatamgr, entao a
    * checagem eh feita direto via SQLEXEC.
    *===========================================================================
    PROTECTED PROCEDURE AvisarPrimeiroLancamento(par_cGrupo, par_cConta, par_cMoeda)
        LOCAL loc_nResult

        IF EMPTY(par_cGrupo) OR EMPTY(par_cConta) OR EMPTY(par_cMoeda)
            RETURN
        ENDIF

        IF USED("cursor_4c_ChkReg")
            USE IN cursor_4c_ChkReg
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, "SELECT TOP 1 Grupos FROM SigMvSlc" + ;
            " WHERE Grupos = " + EscaparSQL(par_cGrupo) + ;
            " AND Contas = " + EscaparSQL(par_cConta) + ;
            " AND Moedas = " + EscaparSQL(par_cMoeda), "cursor_4c_ChkReg")

        IF loc_nResult >= 0 AND (!USED("cursor_4c_ChkReg") OR RECCOUNT("cursor_4c_ChkReg") = 0)
            MsgAviso("Aten" + CHR(231) + CHR(227) + "o !!! Primeiro Lan" + CHR(231) + "amento deste Grupo/Conta/Moeda")
        ENDIF

        IF USED("cursor_4c_ChkReg")
            USE IN cursor_4c_ChkReg
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarGrupo - LostFocus de txt_4c_Grupo (legado: Get_grupo.Valid)
    * Usa fAcessoContab (ja portada em utils/functions.prg) para validar
    * acesso e preencher a descricao; depois confere se o grupo tem Classe
    * cadastrada (sem Classe, o lancamento eh bloqueado no legado).
    *===========================================================================
    PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor

        loc_oPg   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)

        IF loc_cValor == THIS.this_cUltimoGrupoValidado
            RETURN
        ENDIF
        THIS.this_cUltimoGrupoValidado = loc_cValor

        IF !EMPTY(loc_cValor)
            fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, loc_oPg.txt_4c_Grupo, ;
                loc_oPg.txt_4c_Dgrupo, loc_oPg.txt_4c_Conta.Value, loc_oPg.txt_4c_Fweditdata_DATA.Value)
        ELSE
            loc_oPg.txt_4c_Dgrupo.Value = ""
        ENDIF

        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
        IF !EMPTY(loc_cValor)
            IF USED("cursor_4c_ValGrp")
                USE IN cursor_4c_ValGrp
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT Codigos, Classes FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), "cursor_4c_ValGrp")

            IF !USED("cursor_4c_ValGrp") OR RECCOUNT("cursor_4c_ValGrp") = 0 OR EMPTY(NVL(cursor_4c_ValGrp.Classes, ""))
                MsgErro("Imposs" + CHR(237) + "vel Realizar Lan" + CHR(231) + "amento Neste Grupo!!!" + CHR(13) + ;
                    "A Classe do Grupo N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_Grupo.Value = ""
                loc_oPg.txt_4c_Dgrupo.Value = ""
                THIS.this_cUltimoGrupoValidado = ""
            ENDIF

            IF USED("cursor_4c_ValGrp")
                USE IN cursor_4c_ValGrp
            ENDIF
        ENDIF

        THIS.AvisarPrimeiroLancamento(ALLTRIM(loc_oPg.txt_4c_Grupo.Value), ALLTRIM(loc_oPg.txt_4c_Conta.Value), ALLTRIM(loc_oPg.txt_4c_MOEDA.Value))
    ENDPROC

    *===========================================================================
    * ValidarConta - LostFocus de txt_4c_Conta (legado: Get_conta.Valid)
    * fAcessoContas/fChecarInativas ja portadas em utils/functions.prg
    *===========================================================================
    PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor, loc_cGrupo

        loc_oPg   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conta.Value)

        IF loc_cValor == THIS.this_cUltimaContaValidada
            RETURN
        ENDIF
        THIS.this_cUltimaContaValidada = loc_cValor

        loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)

        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_Dconta.Value = ""
            RETURN
        ENDIF

        IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cValor, loc_oPg.txt_4c_Conta, loc_oPg.txt_4c_Dconta)
            MsgErro("Acesso Negado !!", "Aviso")
            loc_oPg.txt_4c_Conta.Value = ""
            loc_oPg.txt_4c_Dconta.Value = ""
            THIS.this_cUltimaContaValidada = ""
            RETURN
        ENDIF

        IF !fChecarInativas(loc_oPg.txt_4c_Conta.Value, gnConnHandle)
            MsgErro("Conta Inativa ...", "Aviso")
            loc_oPg.txt_4c_Conta.Value = ""
            loc_oPg.txt_4c_Dconta.Value = ""
            THIS.this_cUltimaContaValidada = ""
            RETURN
        ENDIF

        THIS.AvisarPrimeiroLancamento(loc_cGrupo, ALLTRIM(loc_oPg.txt_4c_Conta.Value), ALLTRIM(loc_oPg.txt_4c_MOEDA.Value))
    ENDPROC

    *===========================================================================
    * ValidarDconta - LostFocus de txt_4c_Dconta (legado: Get_dconta.Valid)
    * Quando a Conta foi preenchida sem Grupo, resolve o Grupo (e a
    * descricao do Grupo) a partir de SigCdCli/SigCdGcr.
    *===========================================================================
    PROCEDURE ValidarDconta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Conta.Value)) OR !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
            RETURN
        ENDIF

        IF USED("cursor_4c_ResGrp")
            USE IN cursor_4c_ResGrp
        ENDIF
        SQLEXEC(gnConnHandle, "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Conta.Value)), "cursor_4c_ResGrp")
        IF USED("cursor_4c_ResGrp") AND RECCOUNT("cursor_4c_ResGrp") > 0 AND !EMPTY(NVL(cursor_4c_ResGrp.Grupos, ""))
            loc_oPg.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_ResGrp.Grupos)
        ENDIF
        IF USED("cursor_4c_ResGrp")
            USE IN cursor_4c_ResGrp
        ENDIF

        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
            IF USED("cursor_4c_ResGrpD")
                USE IN cursor_4c_ResGrpD
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Grupo.Value)), "cursor_4c_ResGrpD")
            IF USED("cursor_4c_ResGrpD") AND RECCOUNT("cursor_4c_ResGrpD") > 0 AND !EMPTY(NVL(cursor_4c_ResGrpD.Descrs, ""))
                loc_oPg.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_ResGrpD.Descrs)
            ENDIF
            IF USED("cursor_4c_ResGrpD")
                USE IN cursor_4c_ResGrpD
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarSGrupo / ValidarSConta / ValidarSDconta - espelho do painel D
    * para a contrapartida (legado: Get_SGRUPO/Get_SCONTA/Get_SDCONTA.Valid)
    *===========================================================================
    PROCEDURE ValidarSGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor

        loc_oPg   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)

        IF loc_cValor == THIS.this_cUltimoSGrupoValidado
            RETURN
        ENDIF
        THIS.this_cUltimoSGrupoValidado = loc_cValor

        IF !EMPTY(loc_cValor)
            fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, loc_oPg.txt_4c_SGRUPO, ;
                loc_oPg.txt_4c_Sdgrupo, loc_oPg.txt_4c_SCONTA.Value, loc_oPg.txt_4c_Fweditdata_DATA.Value)
        ELSE
            loc_oPg.txt_4c_Sdgrupo.Value = ""
        ENDIF

        loc_cValor = ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)
        IF !EMPTY(loc_cValor)
            IF USED("cursor_4c_ValSGrp")
                USE IN cursor_4c_ValSGrp
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT Codigos, Classes FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), "cursor_4c_ValSGrp")

            IF !USED("cursor_4c_ValSGrp") OR RECCOUNT("cursor_4c_ValSGrp") = 0 OR EMPTY(NVL(cursor_4c_ValSGrp.Classes, ""))
                MsgErro("Imposs" + CHR(237) + "vel Realizar Lan" + CHR(231) + "amento Neste Grupo!!!" + CHR(13) + ;
                    "A Classe do Grupo N" + CHR(227) + "o Foi Informada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_SGRUPO.Value = ""
                loc_oPg.txt_4c_Sdgrupo.Value = ""
                THIS.this_cUltimoSGrupoValidado = ""
            ENDIF

            IF USED("cursor_4c_ValSGrp")
                USE IN cursor_4c_ValSGrp
            ENDIF
        ENDIF

        THIS.AvisarPrimeiroLancamento(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value), ALLTRIM(loc_oPg.txt_4c_SCONTA.Value), ALLTRIM(loc_oPg.txt_4c_Smoeda.Value))
    ENDPROC

    PROCEDURE ValidarSConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor, loc_cGrupo

        loc_oPg   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_SCONTA.Value)

        IF loc_cValor == THIS.this_cUltimaSContaValidada
            RETURN
        ENDIF
        THIS.this_cUltimaSContaValidada = loc_cValor

        loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)

        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_SDCONTA.Value = ""
            RETURN
        ENDIF

        IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cValor, loc_oPg.txt_4c_SCONTA, loc_oPg.txt_4c_SDCONTA)
            MsgErro("Acesso Negado !!", "Aviso")
            loc_oPg.txt_4c_SCONTA.Value = ""
            loc_oPg.txt_4c_SDCONTA.Value = ""
            THIS.this_cUltimaSContaValidada = ""
            RETURN
        ENDIF

        IF !fChecarInativas(loc_oPg.txt_4c_SCONTA.Value, gnConnHandle)
            MsgErro("Conta Inativa ...", "Aviso")
            loc_oPg.txt_4c_SCONTA.Value = ""
            loc_oPg.txt_4c_SDCONTA.Value = ""
            THIS.this_cUltimaSContaValidada = ""
            RETURN
        ENDIF

        THIS.AvisarPrimeiroLancamento(loc_cGrupo, ALLTRIM(loc_oPg.txt_4c_SCONTA.Value), ALLTRIM(loc_oPg.txt_4c_Smoeda.Value))
    ENDPROC

    PROCEDURE ValidarSDconta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_SCONTA.Value)) OR !EMPTY(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value))
            RETURN
        ENDIF

        IF USED("cursor_4c_ResSGrp")
            USE IN cursor_4c_ResSGrp
        ENDIF
        SQLEXEC(gnConnHandle, "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_SCONTA.Value)), "cursor_4c_ResSGrp")
        IF USED("cursor_4c_ResSGrp") AND RECCOUNT("cursor_4c_ResSGrp") > 0 AND !EMPTY(NVL(cursor_4c_ResSGrp.Grupos, ""))
            loc_oPg.txt_4c_SGRUPO.Value = ALLTRIM(cursor_4c_ResSGrp.Grupos)
        ENDIF
        IF USED("cursor_4c_ResSGrp")
            USE IN cursor_4c_ResSGrp
        ENDIF

        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value))
            IF USED("cursor_4c_ResSGrpD")
                USE IN cursor_4c_ResSGrpD
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)), "cursor_4c_ResSGrpD")
            IF USED("cursor_4c_ResSGrpD") AND RECCOUNT("cursor_4c_ResSGrpD") > 0 AND !EMPTY(NVL(cursor_4c_ResSGrpD.Descrs, ""))
                loc_oPg.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_ResSGrpD.Descrs)
            ENDIF
            IF USED("cursor_4c_ResSGrpD")
                USE IN cursor_4c_ResSGrpD
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarJob / (txt_4c_DJob eh so leitura) - legado: getJob.Valid
    * chamada original tem argumentos extras (.f. x7, 10) que a assinatura
    * portada de fAcessoContas nao aceita - usados so os 6 primeiros, que
    * cobrem o essencial (usuario/grupo/tipo/valor/origem/destino)
    *===========================================================================
    PROCEDURE ValidarJob(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor

        loc_oPg   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Job.Value)

        IF loc_cValor == THIS.this_cUltimoJobValidado
            RETURN
        ENDIF
        THIS.this_cUltimoJobValidado = loc_cValor

        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DJob.Value = ""
            RETURN
        ENDIF

        IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cValor, loc_oPg.txt_4c_Job, loc_oPg.txt_4c_DJob)
            MsgErro("Acesso Negado!!!", "Aviso")
            loc_oPg.txt_4c_Job.Value = ""
            loc_oPg.txt_4c_DJob.Value = ""
            THIS.this_cUltimoJobValidado = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * ProcessarMudancaMoeda - nucleo comum de Get_MOEDA.Valid/Get_smoeda.Valid
    * par_cLado: "D" (Moeda/Cotacao) ou "S" (Smoeda/SCotacao)
    * Resolve a cotacao vigente em SigCdCot na data do lancamento, espelha a
    * moeda/cotacao para o outro lado quando ele ainda esta vazio, recalcula
    * o valor convertido e ajusta a visibilidade dos campos de cambio.
    *===========================================================================
    PROTECTED PROCEDURE ProcessarMudancaMoeda(par_cLado)
        LOCAL loc_oPg, loc_cValor, loc_lCotas, loc_dData, loc_nCotacao, loc_lAlterar

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        IF par_cLado == "D"
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_MOEDA.Value)
            IF loc_cValor == THIS.this_cUltimaMoedaValidada
                RETURN
            ENDIF
            THIS.this_cUltimaMoedaValidada = loc_cValor
        ELSE
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Smoeda.Value)
            IF loc_cValor == THIS.this_cUltimaSMoedaValidada
                RETURN
            ENDIF
            THIS.this_cUltimaSMoedaValidada = loc_cValor
        ENDIF

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
        SQLEXEC(gnConnHandle, "SELECT CMoes, Cotas FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor), "cursor_4c_ValMoe")

        IF !USED("cursor_4c_ValMoe") OR RECCOUNT("cursor_4c_ValMoe") = 0
            IF USED("cursor_4c_ValMoe")
                USE IN cursor_4c_ValMoe
            ENDIF
            IF par_cLado == "D"
                THIS.AbrirLookupMoeda()
            ELSE
                THIS.AbrirLookupSMoeda()
            ENDIF
            RETURN
        ENDIF

        loc_lCotas = ConverterParaLogico(cursor_4c_ValMoe.Cotas)
        loc_cValor = ALLTRIM(cursor_4c_ValMoe.CMoes)
        USE IN cursor_4c_ValMoe

        IF par_cLado == "D"
            loc_oPg.txt_4c_MOEDA.Value = loc_cValor
        ELSE
            loc_oPg.txt_4c_Smoeda.Value = loc_cValor
        ENDIF

        loc_dData = loc_oPg.txt_4c_Fweditdata_DATA.Value

        loc_nCotacao = 1
        IF loc_lCotas
            IF USED("cursor_4c_ValCot")
                USE IN cursor_4c_ValCot
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT TOP 1 Valos FROM SigCdCot" + ;
                " WHERE Moedas = " + EscaparSQL(loc_cValor) + ;
                " AND Cotacaos <= " + FormatarDataSQL(loc_dData) + ;
                " ORDER BY Cotacaos DESC", "cursor_4c_ValCot")
            IF USED("cursor_4c_ValCot") AND RECCOUNT("cursor_4c_ValCot") > 0
                loc_nCotacao = cursor_4c_ValCot.Valos
            ENDIF
            IF USED("cursor_4c_ValCot")
                USE IN cursor_4c_ValCot
            ENDIF
        ENDIF

        IF par_cLado == "D"
            loc_oPg.txt_4c_COTACAO.Value = loc_nCotacao
            IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Smoeda.Value))
                loc_oPg.txt_4c_Smoeda.Value   = loc_oPg.txt_4c_MOEDA.Value
                loc_oPg.txt_4c_SCOTACAO.Value = loc_oPg.txt_4c_COTACAO.Value
            ENDIF
        ELSE
            loc_oPg.txt_4c_SCOTACAO.Value = loc_nCotacao
            IF EMPTY(ALLTRIM(loc_oPg.txt_4c_MOEDA.Value))
                loc_oPg.txt_4c_MOEDA.Value   = loc_oPg.txt_4c_Smoeda.Value
                loc_oPg.txt_4c_COTACAO.Value = loc_oPg.txt_4c_SCOTACAO.Value
            ENDIF
        ENDIF

        IF loc_oPg.txt_4c_SCOTACAO.Value != 0
            loc_oPg.txt_4c_SVALOR.Value = loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value / loc_oPg.txt_4c_SCOTACAO.Value
        ENDIF

        *-- Legado condiciona o botao "$" tambem a permissao AltCots do cargo
        *-- do usuario (crSigCdCrg); sem esse cache local, simplifica-se para
        *-- Modo ALTERAR + moeda com cotacao variavel
        loc_lAlterar = (THIS.this_cModoAtual == "ALTERAR" AND loc_lCotas)
        loc_oPg.lbl_4c__Cotacao.Visible       = loc_lCotas
        loc_oPg.txt_4c_COTACAO.Visible        = loc_lCotas
        loc_oPg.lbl_4c__sCotacao.Visible      = loc_lCotas
        loc_oPg.txt_4c_SCOTACAO.Visible       = loc_lCotas
        loc_oPg.cmd_4c_Alteracotacao.Visible  = loc_lAlterar
        loc_oPg.cmd_4c_Alterascotacao.Visible = loc_lAlterar

        IF par_cLado == "D"
            THIS.AvisarPrimeiroLancamento(ALLTRIM(loc_oPg.txt_4c_Grupo.Value), ALLTRIM(loc_oPg.txt_4c_Conta.Value), ALLTRIM(loc_oPg.txt_4c_MOEDA.Value))
        ELSE
            THIS.AvisarPrimeiroLancamento(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value), ALLTRIM(loc_oPg.txt_4c_SCONTA.Value), ALLTRIM(loc_oPg.txt_4c_Smoeda.Value))
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarMudancaMoeda("D")
    ENDPROC

    PROCEDURE ValidarSmoeda(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ProcessarMudancaMoeda("S")
    ENDPROC

    *===========================================================================
    * AbrirLookupMoeda / AbrirLookupSMoeda - legado usa fwbuscasel em
    * crSigCdMoe; no sistema novo, FormBuscaAuxiliar em SigCdMoe (CMoes/DMoes)
    *===========================================================================
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oPg, loc_oBusca

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", ;
            ALLTRIM(loc_oPg.txt_4c_MOEDA.Value), "Moedas")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                loc_oPg.txt_4c_MOEDA.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
            ELSE
                loc_oPg.txt_4c_MOEDA.Value = ""
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF

        *-- sincroniza o dedup com o valor final (permite reabrir o lookup se
        *-- o usuario digitar de novo o mesmo codigo invalido)
        THIS.this_cUltimaMoedaValidada = ALLTRIM(loc_oPg.txt_4c_MOEDA.Value)
    ENDPROC

    PROCEDURE AbrirLookupSMoeda()
        LOCAL loc_oPg, loc_oBusca

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaSMoeda", "CMoes", ;
            ALLTRIM(loc_oPg.txt_4c_Smoeda.Value), "Moedas")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSMoeda")
                loc_oPg.txt_4c_Smoeda.Value = ALLTRIM(cursor_4c_BuscaSMoeda.CMoes)
            ELSE
                loc_oPg.txt_4c_Smoeda.Value = ""
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaSMoeda")
            USE IN cursor_4c_BuscaSMoeda
        ENDIF

        *-- sincroniza o dedup com o valor final (permite reabrir o lookup se
        *-- o usuario digitar de novo o mesmo codigo invalido)
        THIS.this_cUltimaSMoedaValidada = ALLTRIM(loc_oPg.txt_4c_Smoeda.Value)
    ENDPROC

    *===========================================================================
    * ValidarValor - LostFocus de txt_4c_VALOR (legado: Get_VALOR.Valid)
    *===========================================================================
    PROCEDURE ValidarValor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        IF loc_oPg.txt_4c_VALOR.Value < 0
            MsgAviso("Valor Inv" + CHR(225) + "lido...")
            loc_oPg.txt_4c_VALOR.Value = 0
            RETURN
        ENDIF

        IF loc_oPg.txt_4c_SCOTACAO.Value != 0
            loc_oPg.txt_4c_SVALOR.Value = loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value / loc_oPg.txt_4c_SCOTACAO.Value
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarCotacao / ValidarSCotacao - LostFocus de txt_4c_COTACAO e
    * txt_4c_SCOTACAO (legado: Get_COTACAO.Valid / Get_SCOTACAO.Valid)
    * Ambos recalculam o SValor a partir de Valor*Cotacao/SCotacao
    *===========================================================================
    PROCEDURE ValidarCotacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        IF loc_oPg.txt_4c_SCOTACAO.Value != 0
            loc_oPg.txt_4c_SVALOR.Value = loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value / loc_oPg.txt_4c_SCOTACAO.Value
        ENDIF
    ENDPROC

    PROCEDURE ValidarSCotacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        IF loc_oPg.txt_4c_SCOTACAO.Value != 0
            loc_oPg.txt_4c_SVALOR.Value = loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value / loc_oPg.txt_4c_SCOTACAO.Value
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarSValor - LostFocus de txt_4c_SVALOR (legado: Get_SVALOR.Valid)
    * Quando o usuario digita o valor convertido diretamente, a cotacao da
    * contrapartida eh recalculada a partir dele (em vez do caminho normal
    * Cotacao -> SValor)
    *===========================================================================
    PROCEDURE ValidarSValor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        IF loc_oPg.txt_4c_SVALOR.Value != 0
            loc_oPg.txt_4c_SCOTACAO.Value = (loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value) / loc_oPg.txt_4c_SVALOR.Value
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarCotacaoClick / BtnAlterarSCotacaoClick - legado abre
    * "Do Form SigOpAlC" (tela auxiliar nao migrada) para digitar manualmente
    * a cotacao; substituido por INPUTBOX() mantendo o efeito (grava a nova
    * cotacao + usuario que alterou + recalcula o valor convertido)
    *===========================================================================
    PROCEDURE BtnAlterarCotacaoClick()
        LOCAL loc_oPg, loc_cResp, loc_nNovaCotacao

        loc_oPg  = THIS.pgf_4c_Paginas.Page2
        loc_cResp = INPUTBOX("Informe a nova cota" + CHR(231) + CHR(227) + "o para " + ALLTRIM(loc_oPg.txt_4c_MOEDA.Value) + ":", ;
            "Alterar Cota" + CHR(231) + CHR(227) + "o", TRANSFORM(loc_oPg.txt_4c_COTACAO.Value))

        IF !EMPTY(loc_cResp)
            loc_nNovaCotacao = VAL(loc_cResp)
            IF loc_nNovaCotacao > 0
                loc_oPg.txt_4c_COTACAO.Value = loc_nNovaCotacao
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_cCotusus = gc_4c_UsuarioLogado
                ENDIF
                IF loc_oPg.txt_4c_SCOTACAO.Value != 0
                    loc_oPg.txt_4c_SVALOR.Value = loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value / loc_oPg.txt_4c_SCOTACAO.Value
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnAlterarSCotacaoClick()
        LOCAL loc_oPg, loc_cResp, loc_nNovaCotacao

        loc_oPg  = THIS.pgf_4c_Paginas.Page2
        loc_cResp = INPUTBOX("Informe a nova cota" + CHR(231) + CHR(227) + "o para " + ALLTRIM(loc_oPg.txt_4c_Smoeda.Value) + ":", ;
            "Alterar Cota" + CHR(231) + CHR(227) + "o", TRANSFORM(loc_oPg.txt_4c_SCOTACAO.Value))

        IF !EMPTY(loc_cResp)
            loc_nNovaCotacao = VAL(loc_cResp)
            IF loc_nNovaCotacao > 0
                loc_oPg.txt_4c_SCOTACAO.Value = loc_nNovaCotacao
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_cCotusus = gc_4c_UsuarioLogado
                ENDIF
                IF loc_oPg.txt_4c_SCOTACAO.Value != 0
                    loc_oPg.txt_4c_SVALOR.Value = loc_oPg.txt_4c_VALOR.Value * loc_oPg.txt_4c_COTACAO.Value / loc_oPg.txt_4c_SCOTACAO.Value
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Inclusao de novo lancamento
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Visualizacao do lancamento selecionado na grade
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum lan" + CHR(231) + "amento selecionado!")
            RETURN
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Alteracao do lancamento selecionado na grade
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum lan" + CHR(231) + "amento selecionado!")
            RETURN
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclusao do lancamento selecionado na grade
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum lan" + CHR(231) + "amento selecionado!")
            RETURN
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF MsgConfirma("Confirma exclus" + CHR(227) + "o do lan" + CHR(231) + "amento selecionado?", "Confirma" + CHR(231) + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgSucesso("Lan" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega a grade com o periodo informado nos filtros
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma a inclusao/alteracao do lancamento (Confirmar)
    * Salvar() do BusinessBase decide INSERT/UPDATE sozinho (this_lNovoRegistro
    * ja foi setado por NovoRegistro()/EditarRegistro() nos botoes de origem)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Lan" + CHR(231) + "amento salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o lan" + CHR(231) + "amento.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela a inclusao/alteracao/visualizacao e volta
    * para a lista, recarregando a grade (CLAUDE.md/migration_guide Problema 2)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Confirmar fica desabilitado em VISUALIZAR (padrao
    * canonico frmcadastro: Confirmar disabled, Cancelar sempre enabled)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
        loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos editaveis da Page2 (modo INCLUIR)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.txt_4c_Fweditdata_DATA.Value = {}
        loc_oPg.txt_4c_Fweditdata_VENC.Value = {}
        loc_oPg.txt_4c_DtEmis.Value          = {}
        loc_oPg.txt_4c_Nota.Value            = ""
        loc_oPg.txt_4c__Usuario.Value        = gc_4c_UsuarioLogado
        loc_oPg.txt_4c_Job.Value             = ""
        loc_oPg.txt_4c_DJob.Value            = ""
        loc_oPg.txt_4c_DOCU.Value            = ""
        loc_oPg.txt_4c_OPER.Value            = "D"
        loc_oPg.txt_4c_Grupo.Value           = ""
        loc_oPg.txt_4c_Dgrupo.Value          = ""
        loc_oPg.txt_4c_Conta.Value           = ""
        loc_oPg.txt_4c_Dconta.Value          = ""
        loc_oPg.txt_4c_VALOR.Value           = 0
        loc_oPg.txt_4c_MOEDA.Value           = ""
        loc_oPg.txt_4c_COTACAO.Value         = 0
        loc_oPg.txt_4c_SOPER.Value           = "C"
        loc_oPg.txt_4c_SGRUPO.Value          = ""
        loc_oPg.txt_4c_Sdgrupo.Value         = ""
        loc_oPg.txt_4c_SCONTA.Value          = ""
        loc_oPg.txt_4c_SDCONTA.Value         = ""
        loc_oPg.txt_4c_SVALOR.Value          = 0
        loc_oPg.txt_4c_Smoeda.Value          = ""
        loc_oPg.txt_4c_SCOTACAO.Value        = 0
        loc_oPg.txt_4c_HIST.Value            = ""
        loc_oPg.txt_4c_Hist2.Value           = ""
        loc_oPg.obj_4c_Opcao_conta.Value     = 1

        THIS.this_cUltimoGrupoValidado  = ""
        THIS.this_cUltimaContaValidada  = ""
        THIS.this_cUltimaMoedaValidada  = ""
        THIS.this_cUltimoSGrupoValidado = ""
        THIS.this_cUltimaSContaValidada = ""
        THIS.this_cUltimaSMoedaValidada = ""
        THIS.this_cUltimoJobValidado    = ""

        RETURN .T.
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos editaveis da Page2
    * conforme o modo atual (INCLUIR/ALTERAR = .T., VISUALIZAR = .F.)
    * Campos somente-leitura (descricoes de lookup, Usuario, SOPER) permanecem
    * SEMPRE ReadOnly - nao entram nesta lista (regra #19 CLAUDE.md)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.txt_4c_Fweditdata_DATA.Enabled = par_lHabilitar
        loc_oPg.txt_4c_Fweditdata_VENC.Enabled = par_lHabilitar
        loc_oPg.txt_4c_DtEmis.Enabled          = par_lHabilitar
        loc_oPg.txt_4c_Nota.Enabled            = par_lHabilitar
        loc_oPg.txt_4c_Job.Enabled             = par_lHabilitar
        loc_oPg.txt_4c_DOCU.Enabled            = par_lHabilitar
        loc_oPg.txt_4c_OPER.Enabled            = par_lHabilitar
        loc_oPg.txt_4c_Grupo.Enabled           = par_lHabilitar
        loc_oPg.txt_4c_Conta.Enabled           = par_lHabilitar
        loc_oPg.txt_4c_VALOR.Enabled           = par_lHabilitar
        loc_oPg.txt_4c_MOEDA.Enabled           = par_lHabilitar
        loc_oPg.txt_4c_COTACAO.Enabled         = par_lHabilitar
        loc_oPg.txt_4c_SGRUPO.Enabled          = par_lHabilitar
        loc_oPg.txt_4c_SCONTA.Enabled          = par_lHabilitar
        loc_oPg.txt_4c_SVALOR.Enabled          = par_lHabilitar
        loc_oPg.txt_4c_Smoeda.Enabled          = par_lHabilitar
        loc_oPg.txt_4c_SCOTACAO.Enabled        = par_lHabilitar
        loc_oPg.txt_4c_HIST.Enabled            = par_lHabilitar
        loc_oPg.txt_4c_Hist2.Enabled           = par_lHabilitar
        loc_oPg.obj_4c_Opcao_conta.Enabled     = par_lHabilitar
        loc_oPg.cmd_4c_Alteracotacao.Enabled   = par_lHabilitar
        loc_oPg.cmd_4c_Alterascotacao.Enabled  = par_lHabilitar

        RETURN .T.
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere os valores da Page2 para o BusinessObject
    * (chamado antes de Salvar())
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg, loc_oBO
        loc_oPg = THIS.pgf_4c_Paginas.Page2
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_dDatas     = loc_oPg.txt_4c_Fweditdata_DATA.Value
        loc_oBO.this_dVencs     = loc_oPg.txt_4c_Fweditdata_VENC.Value
        loc_oBO.this_dDtemis    = loc_oPg.txt_4c_DtEmis.Value
        loc_oBO.this_cNfs       = ALLTRIM(loc_oPg.txt_4c_Nota.Value)
        loc_oBO.this_cJobs      = ALLTRIM(loc_oPg.txt_4c_Job.Value)
        loc_oBO.this_cDocus     = ALLTRIM(loc_oPg.txt_4c_DOCU.Value)
        loc_oBO.this_cOpers     = ALLTRIM(loc_oPg.txt_4c_OPER.Value)
        loc_oBO.this_cGrupos    = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
        loc_oBO.this_cContas    = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
        loc_oBO.this_nValors    = loc_oPg.txt_4c_VALOR.Value
        loc_oBO.this_cMoedas    = ALLTRIM(loc_oPg.txt_4c_MOEDA.Value)
        loc_oBO.this_nCotacaos  = loc_oPg.txt_4c_COTACAO.Value
        loc_oBO.this_cSopers    = ALLTRIM(loc_oPg.txt_4c_SOPER.Value)
        loc_oBO.this_cSgrupos   = ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)
        loc_oBO.this_cScontas   = ALLTRIM(loc_oPg.txt_4c_SCONTA.Value)
        loc_oBO.this_nSvalors   = loc_oPg.txt_4c_SVALOR.Value
        loc_oBO.this_cSmoedas   = ALLTRIM(loc_oPg.txt_4c_Smoeda.Value)
        loc_oBO.this_nScotacaos = loc_oPg.txt_4c_SCOTACAO.Value
        loc_oBO.this_cHists     = ALLTRIM(loc_oPg.txt_4c_HIST.Value)
        loc_oBO.this_cHist2s    = ALLTRIM(loc_oPg.txt_4c_Hist2.Value)
        loc_oBO.this_nContapgs  = IIF(loc_oPg.obj_4c_Opcao_conta.Value = 1, 0, 1)

        *-- Metadados que nao tem campo proprio na tela (preenchidos apenas
        *-- quando ainda vazios, para nao sobrescrever o registro carregado
        *-- em modo ALTERAR - CarregarPorCodigo ja os trouxe do banco)
        IF EMPTY(ALLTRIM(NVL(loc_oBO.this_cEmps, "")))
            loc_oBO.this_cEmps = go_4c_Sistema.cCodEmpresa
        ENDIF
        loc_oBO.this_cUsualts = gc_4c_UsuarioLogado

        RETURN .T.
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere os valores do BusinessObject para a Page2
    * (chamado apos CarregarPorCodigo(), em Alterar/Visualizar)
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oBO
        loc_oPg = THIS.pgf_4c_Paginas.Page2
        loc_oBO = THIS.this_oBusinessObject

        loc_oPg.txt_4c_Fweditdata_DATA.Value = loc_oBO.this_dDatas
        loc_oPg.txt_4c_Fweditdata_VENC.Value = loc_oBO.this_dVencs
        loc_oPg.txt_4c_DtEmis.Value          = loc_oBO.this_dDtemis
        loc_oPg.txt_4c_Nota.Value            = loc_oBO.this_cNfs
        loc_oPg.txt_4c__Usuario.Value        = loc_oBO.this_cUsualts
        loc_oPg.txt_4c_Job.Value             = loc_oBO.this_cJobs
        loc_oPg.txt_4c_DOCU.Value            = loc_oBO.this_cDocus
        loc_oPg.txt_4c_OPER.Value            = loc_oBO.this_cOpers
        loc_oPg.txt_4c_Grupo.Value           = loc_oBO.this_cGrupos
        loc_oPg.txt_4c_Conta.Value           = loc_oBO.this_cContas
        loc_oPg.txt_4c_VALOR.Value           = loc_oBO.this_nValors
        loc_oPg.txt_4c_MOEDA.Value           = loc_oBO.this_cMoedas
        loc_oPg.txt_4c_COTACAO.Value         = loc_oBO.this_nCotacaos
        loc_oPg.txt_4c_SOPER.Value           = loc_oBO.this_cSopers
        loc_oPg.txt_4c_SGRUPO.Value          = loc_oBO.this_cSgrupos
        loc_oPg.txt_4c_SCONTA.Value          = loc_oBO.this_cScontas
        loc_oPg.txt_4c_SVALOR.Value          = loc_oBO.this_nSvalors
        loc_oPg.txt_4c_Smoeda.Value          = loc_oBO.this_cSmoedas
        loc_oPg.txt_4c_SCOTACAO.Value        = loc_oBO.this_nScotacaos
        loc_oPg.txt_4c_HIST.Value            = loc_oBO.this_cHists
        loc_oPg.txt_4c_Hist2.Value           = loc_oBO.this_cHist2s
        loc_oPg.obj_4c_Opcao_conta.Value     = IIF(loc_oBO.this_nContapgs = 0, 1, 2)

        *-- Descricoes de lookup (nao existem no BO - resolvidas com as
        *-- MESMAS funcoes globais ja portadas usadas em ValidarGrupo/
        *-- ValidarConta/ValidarSGrupo/ValidarSConta/ValidarJob, chamadas
        *-- direto para so preencher a descricao, sem os efeitos colaterais
        *-- de validacao interativa (MsgErro/limpeza de campo/aviso)
        loc_oPg.txt_4c_Dgrupo.Value  = ""
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
            fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(loc_oPg.txt_4c_Grupo.Value), ;
                loc_oPg.txt_4c_Grupo, loc_oPg.txt_4c_Dgrupo, loc_oPg.txt_4c_Conta.Value, loc_oPg.txt_4c_Fweditdata_DATA.Value)
        ENDIF

        loc_oPg.txt_4c_Dconta.Value = ""
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Conta.Value))
            fAcessoContas(gc_4c_UsuarioLogado, ALLTRIM(loc_oPg.txt_4c_Grupo.Value), "C", ;
                ALLTRIM(loc_oPg.txt_4c_Conta.Value), loc_oPg.txt_4c_Conta, loc_oPg.txt_4c_Dconta)
        ENDIF

        loc_oPg.txt_4c_Sdgrupo.Value = ""
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value))
            fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value), ;
                loc_oPg.txt_4c_SGRUPO, loc_oPg.txt_4c_Sdgrupo, loc_oPg.txt_4c_SCONTA.Value, loc_oPg.txt_4c_Fweditdata_DATA.Value)
        ENDIF

        loc_oPg.txt_4c_SDCONTA.Value = ""
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_SCONTA.Value))
            fAcessoContas(gc_4c_UsuarioLogado, ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value), "C", ;
                ALLTRIM(loc_oPg.txt_4c_SCONTA.Value), loc_oPg.txt_4c_SCONTA, loc_oPg.txt_4c_SDCONTA)
        ENDIF

        loc_oPg.txt_4c_DJob.Value = ""
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Job.Value))
            fAcessoContas(gc_4c_UsuarioLogado, "", "C", ALLTRIM(loc_oPg.txt_4c_Job.Value), ;
                loc_oPg.txt_4c_Job, loc_oPg.txt_4c_DJob)
        ENDIF

        THIS.this_cUltimoGrupoValidado   = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
        THIS.this_cUltimaContaValidada   = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
        THIS.this_cUltimaMoedaValidada   = ALLTRIM(loc_oPg.txt_4c_MOEDA.Value)
        THIS.this_cUltimoSGrupoValidado  = ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value)
        THIS.this_cUltimaSContaValidada  = ALLTRIM(loc_oPg.txt_4c_SCONTA.Value)
        THIS.this_cUltimaSMoedaValidada  = ALLTRIM(loc_oPg.txt_4c_Smoeda.Value)
        THIS.this_cUltimoJobValidado     = ALLTRIM(loc_oPg.txt_4c_Job.Value)

        RETURN .T.
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Deve iterar Pages E Controls para PageFrames aninhados
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
    * Destroy - Libera recursos do formulario
    *===========================================================================
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
