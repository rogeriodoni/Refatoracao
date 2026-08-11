*------------------------------------------------------------------------------
* Formcmp.prg - Formulario de Cadastro de Compra Para
* Tabela: SigCdCmp | PK: cods
* Fase 3/8: Estrutura Base + Completa
*------------------------------------------------------------------------------

DEFINE CLASS Formcmp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Compra Para"
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

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MostrarErro(loException, "Formcmp.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado pelo FormBase.Init() - NAO chamar diretamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("cmpBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar cmpBO", "Erro")
            ELSE
                *-- Configurar PageFrame com 2 paginas e containers base
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Carregar dados iniciais (pula se validando UI sem conexao SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                *-- Estado inicial
                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * e os containers base de cada pagina
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPg1, loc_oPg2

        TRY
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

            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            WITH loc_oPg1
                .Caption   = "Lista"
                .Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .BackColor = RGB(240, 240, 240)
            ENDWITH

            WITH loc_oPg2
                .Caption   = "Dados"
                .Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .BackColor = RGB(240, 240, 240)
            ENDWITH

            *-- Containers estruturais da Page1
            THIS.ConfigurarContainersPage1(loc_oPg1)

            *-- Containers estruturais da Page2
            THIS.ConfigurarContainersPage2(loc_oPg2)

        CATCH TO loException
            MostrarErro(loException, "Formcmp.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersPage1 - Cria containers base da Page1 (Lista)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersPage1(par_oPagina)

        TRY
            *-- Container cabecalho (cntSombra no legado)
            *-- Top = 2 + 29 (compensacao PageFrame.Top=-29)
            par_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH par_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
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

            par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
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

            *-- Container botoes CRUD (Grupo_op no legado)
            *-- Grupo_op.Left=342 no original, Left=542 canonico para form 1000px
            *-- Top = -1 + 29 (compensacao) = 28, usar canonico 29
            par_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH par_oPagina.cnt_4c_Botoes
                .Top         = 29
                .Left        = 542
                .Width       = 390
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Container saida - PADRAO CANONICO (prevalece sobre PILAR 1)
            *-- Left=917, Width=90 canonico (CLAUDE.md regra #10)
            par_oPagina.AddObject("cnt_4c_Saida", "Container")
            WITH par_oPagina.cnt_4c_Saida
                .Top         = 29
                .Left        = 917
                .Width       = 90
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

        CATCH TO loException
            MostrarErro(loException, "Formcmp.ConfigurarContainersPage1")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersPage2 - Cria containers base da Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersPage2(par_oPagina)

        TRY
            *-- Container botoes salvar/cancelar (Grupo_Salva no legado)
            *-- Grupo_Salva.Top=17 + 29 = 46, Left=611 (original)
            par_oPagina.AddObject("cnt_4c_Salva", "Container")
            WITH par_oPagina.cnt_4c_Salva
                .Top         = 46
                .Left        = 611
                .Width       = 160
                .Height      = 85
                .BackStyle = 1
                .BackColor = RGB(255, 255, 255)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

        CATCH TO loException
            MostrarErro(loException, "Formcmp.ConfigurarContainersPage2")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona botoes CRUD, Encerrar e Grid na Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

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

            *-- Botao Buscar (procurar no legado)
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

            *-- Botao Encerrar (PADRAO CANONICO: cnt_4c_Saida, Width=75, Caption="Encerrar")
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

            *-- Cursor placeholder com mesmos campos de cursor_4c_Dados retornado por Buscar()
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados (cods C(10), descs C(60))
            SET NULL OFF

            *-- Grid de lista
            *-- Top = 117 (canonico: 88+29), Left = 12
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            WITH loc_oPagina.grd_4c_Lista
                .Top                = 117
                .Left               = 12
                .Width              = 937
                .Height             = 470
                .FontName           = "Verdana"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .GridLines          = 3
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .RowHeight          = 16
                .ScrollBars         = 2
                .Visible            = .T.
            ENDWITH

            *-- RecordSource e ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
            loc_oPagina.grd_4c_Lista.ColumnCount  = 2
            loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
            loc_oPagina.grd_4c_Lista.ColumnCount  = 2

            *-- ControlSources APOS RecordSource (evita auto-bind por ordem de campos)
            WITH loc_oPagina.grd_4c_Lista
                .Column1.ControlSource   = "cursor_4c_Dados.cods"
                .Column1.Width           = 90
                .Column1.Header1.Caption = "C" + CHR(243) + "digo"

                .Column2.ControlSource   = "cursor_4c_Dados.descs"
                .Column2.Width           = 337
                .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH

            THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MostrarErro(loException, "Formcmp.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona botoes Confirmar/Cancelar e campos na Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Botao Confirmar (Salvar) em cnt_4c_Salva
            loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
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
            BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

            *-- Botao Cancelar em cnt_4c_Salva
            loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
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
            BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            *-- Campo 1: Codigo (Get_codigo)
            *-- Say1: Top=124+29=153, Left=215, ForeColor=90,90,90
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Caption   = "C" + CHR(243) + "digo :"
                .Top       = 153
                .Left      = 215
                .Height    = 17
                .Width     = 45
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- Get_codigo: Top=121+29=150, Left=263, Width=84, Height=23
            loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPagina.txt_4c_Codigo
                .Value         = ""
                .Top           = 150
                .Left          = 263
                .Width         = 84
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            *-- Campo 2: Descricao (Get_desc)
            *-- Say2: Top=149+29=178, Left=202, ForeColor=90,90,90
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top       = 178
                .Left      = 202
                .Height    = 17
                .Width     = 58
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- Get_desc: Top=146+29=175, Left=263, Width=240, Height=23
            loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
            WITH loc_oPagina.txt_4c_Desc
                .Value         = ""
                .Top           = 175
                .Left          = 263
                .Width         = 240
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MostrarErro(loException, "Formcmp.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no Grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        *-- Pula se validando UI sem conexao SQL (RETURN fora do TRY - Regra 1)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                *-- Reconectar ControlSources apos ZAP+APPEND (evita reset de headers)
                WITH loc_oGrid
                    .Column1.ControlSource   = "cursor_4c_Dados.cods"
                    .Column1.Width           = 90
                    .Column1.Header1.Caption = "C" + CHR(243) + "digo"

                    .Column2.ControlSource   = "cursor_4c_Dados.descs"
                    .Column2.Width           = 337
                    .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                ENDWITH

                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "Formcmp.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- Validacao FORA do TRY (Regra 1: nunca RETURN dentro de TRY/CATCH)
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
            MostrarErro(loException, "Formcmp.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o BO antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o Form apos carregar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value = ""
        loc_oPg2.txt_4c_Desc.Value   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis
    * txt_4c_Codigo: apenas em INCLUIR (no legado Get_codigo.When retorna .F. em ALTERAR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo apenas habilitado em INCLUIR (readonly em ALTERAR/VISUALIZAR)
        loc_oPg2.txt_4c_Codigo.Enabled = par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR"
        loc_oPg2.txt_4c_Desc.Enabled   = par_lHabilitar

        *-- Botoes de acao
        IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lEdicao
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Botoes Page1 desabilitados enquanto estiver em edicao
        IF VARTYPE(loc_oPg1.cnt_4c_Botoes) = "O"
            WITH loc_oPg1.cnt_4c_Botoes
                .cmd_4c_Incluir.Enabled    = !loc_lEdicao
                .cmd_4c_Visualizar.Enabled = !loc_lEdicao
                .cmd_4c_Alterar.Enabled    = !loc_lEdicao
                .cmd_4c_Excluir.Enabled    = !loc_lEdicao
                .cmd_4c_Buscar.Enabled     = !loc_lEdicao
                .Visible     = .T.
            ENDWITH
        ENDIF

        *-- Confirmar habilitado apenas em edicao
        IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EVENTOS CRUD - Page1
    *--------------------------------------------------------------------------

    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            *-- Foco no codigo (INSERIR: Get_Codigo.SetFocus no legado)
            IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo) = "O"
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnIncluirClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        *-- Validacao FORA do TRY (Regra 1: nunca RETURN dentro de TRY/CATCH)
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para visualizar.")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(2)
                *-- Foco no Confirmar (Salva.SetFocus no legado - modo consulta)
                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva) = "O"
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        *-- Validacao FORA do TRY (Regra 1: nunca RETURN dentro de TRY/CATCH)
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para alterar.")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina(2)
                *-- Foco na descricao (ALTERAR: Get_Desc.SetFocus no legado)
                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Desc) = "O"
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Desc.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnAlterarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        *-- Validacoes FORA do TRY (Regra 1: nunca RETURN dentro de TRY/CATCH)
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para excluir.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + loc_cCodigo + "'?", ;
                        "Excluir Compra Para")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnExcluirClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cFiltro
        loc_cFiltro = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCmp", "cursor_4c_BuscaCmp", "cods", "", ;
                "Buscar Compra Para")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCmp")
                    SELECT cursor_4c_BuscaCmp
                    loc_cFiltro = "cods = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaCmp.cods))
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCmp")
                USE IN cursor_4c_BuscaCmp
            ENDIF

            IF !EMPTY(loc_cFiltro)
                THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnBuscarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * EVENTOS Page2
    *--------------------------------------------------------------------------

    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cCodigo, loc_cDescricao

        *-- Validacoes FORA do TRY (evita problema de RETURN dentro de TRY)
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo   = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        loc_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)

        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!")
            loc_oPg2.txt_4c_Codigo.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_oPg2.txt_4c_Desc.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnSalvarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelarClick()
        TRY
            THIS.LimparCampos()
            THIS.AlternarPagina(1)
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
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

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_BuscaCmp")
                USE IN cursor_4c_BuscaCmp
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
