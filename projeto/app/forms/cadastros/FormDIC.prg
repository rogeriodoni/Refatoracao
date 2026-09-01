*==============================================================================
* FormDIC.prg - Cadastro de Idioma/Dicionario
* Herda de: FormBase (app/classes/formbase.prg)
* Tabela: SigCdDic
* BO: DICBO
*
* FASE 3/8 - Estrutura base: PageFrame + Containers principais
*==============================================================================

DEFINE CLASS FormDIC AS FormBase

    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Idioma"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    BackColor   = RGB(100, 100, 100)
    FontName    = "Tahoma"
    FontSize    = 8

    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DICBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar DICBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

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
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(100, 100, 100)
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(100, 100, 100)
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra no legado: Top=1, compensacao +29 = 30)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 11
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

        *-- Container botoes CRUD (Grupo_op no legado: Top=-1, compensacao +29 = 28 -> canonico 29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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
        ENDWITH

        *-- Container saida - padrao canonico (PREVALECE sobre PILAR 1)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 917
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Grid de listagem (grade no legado: Top=88, compensacao +29 = 117)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .Top                = 117
            .Left               = 0
            .Width              = 910
            .Height             = 455
            .ColumnCount        = 3
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

        *-- BINDEVENT: vincular botoes
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Grupo_Salva: Top=4+29=33, Left=842, Width=160)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
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
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Idioma (Say1 + GetIdioma)
        *-- Legado: Say1.Top=144->173, Say1.Left=63 | GetIdioma.Top=139->168, Left=116, Width=87
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Idioma :"
            .Top       = 173
            .Left      = 63
            .Width     = 51
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Idioma", "TextBox")
        WITH loc_oPagina.txt_4c_Idioma
            .Value       = ""
            .Top         = 168
            .Left        = 116
            .Width       = 87
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .MaxLength   = 20
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        *-- Expressao (Say2 + GetExpressao)
        *-- Legado: Say2.Top=183->212, Say2.Left=42 | GetExpressao.Top=179->208, Left=116, Width=525
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Express" + CHR(227) + "o :"
            .Top       = 212
            .Left      = 42
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Expressao", "TextBox")
        WITH loc_oPagina.txt_4c_Expressao
            .Value       = ""
            .Top         = 208
            .Left        = 116
            .Width       = 525
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .MaxLength   = 200
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        *-- Traducao (Say3 + GetTraducao)
        *-- Legado: Say3.Top=226->255, Say3.Left=49 | GetTraducao.Top=222->251, Left=117, Width=525
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Tradu" + CHR(231) + CHR(227) + "o :"
            .Top       = 255
            .Left      = 49
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Traducao", "TextBox")
        WITH loc_oPagina.txt_4c_Traducao
            .Value       = ""
            .Top         = 251
            .Left        = 117
            .Width       = 525
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .MaxLength   = 60
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (Idioma C(10), Expressao C(60), Traducao C(60))
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 3

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Idioma"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Expressao"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Traducao"

                    loc_oGrid.Column1.Width = 70
                    loc_oGrid.Column2.Width = 280
                    loc_oGrid.Column3.Width = 280

                    loc_oGrid.Column1.Header1.Caption = "Idioma"
                    loc_oGrid.Column2.Header1.Caption = "Express" + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Tradu" + CHR(231) + CHR(227) + "o"

                    loc_oGrid.Refresh()
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

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
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
            loc_oPagina.txt_4c_Idioma.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
            loc_oPagina.txt_4c_Expressao.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
            loc_oPagina.txt_4c_Traducao.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    *-- HabilitarCampos: replica comportamento dos When events do legado:
    *-- GetIdioma.When:    .T. apenas em INCLUIR
    *-- GetExpressao.When: .T. em INCLUIR e BUSCAR
    *-- GetTraducao.When:  .T. em INCLUIR e ALTERAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lIdioma, loc_lExpressao, loc_lTraducao
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        DO CASE
            CASE THIS.this_cModoAtual = "INCLUIR"
                loc_lIdioma    = .T.
                loc_lExpressao = .T.
                loc_lTraducao  = .T.
            CASE THIS.this_cModoAtual = "ALTERAR"
                loc_lIdioma    = .F.
                loc_lExpressao = .F.
                loc_lTraducao  = .T.
            CASE THIS.this_cModoAtual = "BUSCAR"
                loc_lIdioma    = .F.
                loc_lExpressao = .T.
                loc_lTraducao  = .F.
            OTHERWISE
                loc_lIdioma    = .F.
                loc_lExpressao = .F.
                loc_lTraducao  = .F.
        ENDCASE

        IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
            loc_oPagina.txt_4c_Idioma.Enabled = loc_lIdioma AND par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
            loc_oPagina.txt_4c_Expressao.Enabled = loc_lExpressao AND par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
            loc_oPagina.txt_4c_Traducao.Enabled = loc_lTraducao AND par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lConfirmar
        loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
        loc_lConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")

        IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
            loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lConfirmar
        ENDIF
        IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
            loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
            loc_oPagina.txt_4c_Idioma.Value = ALLTRIM(THIS.this_oBusinessObject.this_cIdioma)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
            loc_oPagina.txt_4c_Expressao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cExpressao)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
            loc_oPagina.txt_4c_Traducao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cTraducao)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
            THIS.this_oBusinessObject.this_cIdioma = ALLTRIM(loc_oPagina.txt_4c_Idioma.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
            THIS.this_oBusinessObject.this_cExpressao = ALLTRIM(loc_oPagina.txt_4c_Expressao.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
            THIS.this_oBusinessObject.this_cTraducao = ALLTRIM(loc_oPagina.txt_4c_Traducao.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cIdioma, loc_cExpressao, loc_cTraducao
        LOCAL loc_cSQL, loc_nResult
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_cIdioma    = ""
        loc_cExpressao = ""
        loc_cTraducao  = ""

        *-- Em modo BUSCAR: localiza registro pela expressao e retorna para lista
        IF THIS.this_cModoAtual = "BUSCAR"
            IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
                loc_cExpressao = ALLTRIM(loc_oPagina.txt_4c_Expressao.Value)
            ENDIF
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            IF !EMPTY(loc_cExpressao) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(cursor_4c_Dados.Expressao) = loc_cExpressao
                IF !EOF("cursor_4c_Dados")
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
            RETURN
        ENDIF

        *-- Obter valores para validacao
        IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
            loc_cExpressao = ALLTRIM(loc_oPagina.txt_4c_Expressao.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
            loc_cIdioma = ALLTRIM(loc_oPagina.txt_4c_Idioma.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
            loc_cTraducao = ALLTRIM(loc_oPagina.txt_4c_Traducao.Value)
        ENDIF

        *-- Validacoes obrigatorias (INCLUIR e ALTERAR)
        IF EMPTY(loc_cExpressao)
            MsgAviso("Express" + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Salvar")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
                loc_oPagina.txt_4c_Expressao.SetFocus()
            ENDIF
            RETURN
        ENDIF
        IF EMPTY(loc_cIdioma)
            MsgAviso("Idioma Inv" + CHR(225) + "lido !!", "Salvar")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
                loc_oPagina.txt_4c_Idioma.SetFocus()
            ENDIF
            RETURN
        ENDIF
        IF EMPTY(loc_cTraducao)
            MsgAviso("Tradu" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Salvar")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
                loc_oPagina.txt_4c_Traducao.SetFocus()
            ENDIF
            RETURN
        ENDIF

        *-- Em modo INCLUIR: verificar duplicidade por Expressao + Idioma
        IF THIS.this_cModoAtual = "INCLUIR"
            loc_cSQL = "SELECT 1 AS chk FROM SigCdDic WHERE Expressao = " + EscaparSQL(loc_cExpressao) + ;
                       " AND Idioma = " + EscaparSQL(loc_cIdioma)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
            IF USED("cursor_4c_DupCheck")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
                    USE IN cursor_4c_DupCheck
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado !!", "Salvar")
                    IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
                        loc_oPagina.txt_4c_Expressao.SetFocus()
                    ENDIF
                    RETURN
                ENDIF
                USE IN cursor_4c_DupCheck
            ENDIF
        ENDIF

        *-- Transferir Form -> BO e salvar
        THIS.FormParaBO()
        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Salvar")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cExpressao, loc_cIdioma

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cExpressao = ALLTRIM(cursor_4c_Dados.Expressao)
        loc_cIdioma    = ALLTRIM(cursor_4c_Dados.Idioma)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cExpressao, loc_cIdioma)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cExpressao, loc_cIdioma

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cExpressao = ALLTRIM(cursor_4c_Dados.Expressao)
        loc_cIdioma    = ALLTRIM(cursor_4c_Dados.Idioma)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cExpressao, loc_cIdioma)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cExpressao, loc_cIdioma

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Excluir")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cExpressao = ALLTRIM(cursor_4c_Dados.Expressao)
        loc_cIdioma    = ALLTRIM(cursor_4c_Dados.Idioma)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cExpressao, loc_cIdioma)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "BUSCAR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

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
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
