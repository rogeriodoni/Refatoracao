*------------------------------------------------------------------------------
* FormCol.prg - Formulario de Cadastro de Grupo de Venda
* Tabela: SigCdCol
* Fase 3/8: Estrutura Base do Form
*------------------------------------------------------------------------------

DEFINE CLASS FormCol AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Grupo de Venda"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject          = .NULL.
    this_cModoAtual               = "LISTA"
    this_cUltimoUsuarsValidado    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MostrarErro(loException, "FormCol.Init")
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
            THIS.this_oBusinessObject = CREATEOBJECT("ColBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar ColBO", "Erro")
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
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormCol.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * e os containers base de cada pagina
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPg1, loc_oPg2, loc_nFormWidth, loc_nFormHeight

        TRY
            loc_nFormWidth  = THIS.Width
            loc_nFormHeight = THIS.Height

            THIS.AddObject("pgf_4c_Paginas", "PageFrame")

            WITH THIS.pgf_4c_Paginas
                .PageCount = 2
                .Top       = -29
                .Left      = 0
                .Width     = loc_nFormWidth
                .Height    = loc_nFormHeight + 29
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

            *-- Containers da Page1
            THIS.ConfigurarContainersPage1(loc_oPg1)

            *-- Containers da Page2
            THIS.ConfigurarContainersPage2(loc_oPg2)

        CATCH TO loException
            MostrarErro(loException, "FormCol.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersPage1 - Cria containers base da Page1 (Lista)
    * Fase 3: apenas containers estruturais (sem botoes nem grid)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersPage1(par_oPagina)
        LOCAL loc_nFormWidth

        TRY
            loc_nFormWidth = THIS.Width

            *-- Container cabecalho (cntSombra no legado)
            *-- Top = 2 + 29 (compensacao PageFrame.Top=-29)
            par_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH par_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = 0
                .Width       = loc_nFormWidth
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
                .Visible   = .T.
            ENDWITH

            *-- Container botoes CRUD (Grupo_op no legado)
            *-- Top = 0 + 29 (compensacao), Left = 543 (Grupo_op.Left do legado)
            par_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH par_oPagina.cnt_4c_Botoes
                .Top         = 29
                .Left        =  542
                .Width       = 390
                .Height      = 85
                .BackStyle = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Container saida - PADRAO CANONICO (prevalece sobre PILAR 1)
            *-- Left=917, Width=90 (canonico) mesmo que legado tenha Left=918
            *-- Top = 0 + 29 (compensacao)
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
            MostrarErro(loException, "FormCol.ConfigurarContainersPage1")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersPage2 - Cria containers base da Page2 (Dados)
    * Fase 3: apenas container de botoes salvar/cancelar (sem campos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersPage2(par_oPagina)

        TRY
            *-- Container botoes salvar/cancelar (Grupo_Salva no legado)
            *-- Top = 8 + 29 (compensacao), Left = 820 (Grupo_Salva.Left do legado)
            par_oPagina.AddObject("cnt_4c_Salva", "Container")
            WITH par_oPagina.cnt_4c_Salva
                .Top         = 37
                .Left        = 820
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

        CATCH TO loException
            MostrarErro(loException, "FormCol.ConfigurarContainersPage2")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona botoes CRUD, Encerrar e grid na Page1
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

            *-- Cursor placeholder com mesmos campos do cursor_4c_Dados retornado por Buscar()
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ( ;
                colecoes C(10), ;
                descs    C(40), ;
                codcols  C(1),  ;
                repoauts N(5,0), ;
                conprods N(5,0), ;
                altprods N(5,0), ;
                dtincs   T,     ;
                usuars   C(10), ;
                agrupas  C(10)  ;
            )
            SET NULL OFF

            *-- Grid de lista
            *-- Top = 121 + 29 (compensacao PageFrame.Top=-29), Left = 12 do original
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            WITH loc_oPagina.grd_4c_Lista
                .Top                = 150
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
            loc_oPagina.grd_4c_Lista.ColumnCount = 3
            loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
            loc_oPagina.grd_4c_Lista.ColumnCount  = 3

            *-- ControlSources APOS RecordSource (evita auto-bind por ordem de campos)
            WITH loc_oPagina.grd_4c_Lista
                .Column1.ControlSource   = "cursor_4c_Dados.colecoes"
                .Column1.Width           = 79
                .Column1.Header1.Caption = "Grupo"

                .Column2.ControlSource   = "cursor_4c_Dados.descs"
                .Column2.Width           = 290
                .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                .Column3.ControlSource   = "cursor_4c_Dados.codcols"
                .Column3.Width           = 75
                .Column3.Header1.Caption = "Cod. Coletor"
            ENDWITH

            THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MostrarErro(loException, "FormCol.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona botoes Confirmar/Cancelar e
    * primeiros 50% dos campos na Page2 (Dados)
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

            *-- ========================================================
            *-- PRIMEIRA METADE DOS CAMPOS (50%) - campos 1 a 4 de 7
            *-- Todos os Top originais + 29 (compensacao PageFrame.Top=-29)
            *-- ========================================================

            *-- Campo 1: Grupo (getColecoes)
            *-- Say1: Top=127+29=156, Left=325, Width=38, Alignment=1(Right)
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Caption   = "Grupo :"
                .Top       = 156
                .Left      = 325
                .Width     = 38
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- getColecoes: Top=123+29=152, Left=366, Width=79, MaxLength=10
            loc_oPagina.AddObject("txt_4c_Colecoes", "TextBox")
            WITH loc_oPagina.txt_4c_Colecoes
                .Value     = ""
                .Top       = 152
                .Left      = 366
                .Width     = 79
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .BackColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH

            *-- Campo 2: Descricao (getDescs)
            *-- Say2: Top=155+29=184, Left=308, Width=55, Alignment=1(Right)
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top       = 184
                .Left      = 308
                .Width     = 55
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- getDescs: Top=151+29=180, Left=366, Width=289, MaxLength=40
            loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
            WITH loc_oPagina.txt_4c_Descricao
                .Value     = ""
                .Top       = 180
                .Left      = 366
                .Width     = 289
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 40
                .BackColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH

            *-- Campo 3: Usuario (getUsuars)
            *-- Say7: Top=183+29=212, Left=318, Width=45, Alignment=1(Right)
            loc_oPagina.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPagina.lbl_4c_Label7
                .Caption   = "Usu" + CHR(225) + "rio :"
                .Top       = 212
                .Left      = 318
                .Width     = 45
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- getUsuars: Top=179+29=208, Left=366, Width=80, MaxLength=10
            loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
            WITH loc_oPagina.txt_4c_Usuars
                .Value     = ""
                .Top       = 208
                .Left      = 366
                .Width     = 80
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .BackColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH

            *-- Campo 4: Data de Inicio (getDtInicial -> coluna dtincs)
            *-- Say8: Top=211+29=240, Left=288, Width=75, Alignment=1(Right)
            loc_oPagina.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oPagina.lbl_4c_Label8
                .Caption   = "Data de In" + CHR(237) + "cio :"
                .Top       = 240
                .Left      = 288
                .Width     = 75
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- getDtInicial: Top=207+29=236, Left=366, Width=80
            loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
            WITH loc_oPagina.txt_4c_DtInicial
                .Value      = {}
                .Top        = 236
                .Left       = 366
                .Width      = 80
                .Height     = 25
                .FontName   = "Tahoma"
                .FontSize   = 8
                .InputMask  = "99/99/9999"
                .BackColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH

            *-- Campo 5: Consulta de Produtos (optConProds)
            *-- Say5: Top=238+29=267, Left=251, Width=112
            loc_oPagina.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPagina.lbl_4c_Label5
                .Caption   = "Consulta de Produtos :"
                .Top       = 267
                .Left      = 251
                .Width     = 112
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- optConProds: Top=235+29=264, Left=362, Width=95, Height=25
            loc_oPagina.AddObject("opt_4c_ConProds", "OptionGroup")
            WITH loc_oPagina.opt_4c_ConProds
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Top         = 264
                .Left        = 362
                .Width       = 100
                .Height      = 25
                .Visible     = .T.
            ENDWITH
            WITH loc_oPagina.opt_4c_ConProds.Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .Value     = 1
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oPagina.opt_4c_ConProds.Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 53
                .Top       = 5
                .Width     = 37
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            *-- Campo 6: Alertar ao Alterar Produtos (optAltProds)
            *-- Say6: Top=260+29=289, Left=224, Width=139
            loc_oPagina.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPagina.lbl_4c_Label6
                .Caption   = "Alertar ao Alterar Produtos :"
                .Top       = 289
                .Left      = 224
                .Width     = 139
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- optAltProds: Top=255+29=284, Left=362, Width=95, Height=25
            loc_oPagina.AddObject("opt_4c_AltProds", "OptionGroup")
            WITH loc_oPagina.opt_4c_AltProds
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Top         = 284
                .Left        = 362
                .Width       = 100
                .Height      = 25
                .Visible     = .T.
            ENDWITH
            WITH loc_oPagina.opt_4c_AltProds.Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .Value     = 1
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oPagina.opt_4c_AltProds.Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 53
                .Top       = 5
                .Width     = 37
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            *-- Campo 7: Agrupamento (getAgrupa)
            *-- Say9: Top=285+29=314, Left=289, Width=74
            loc_oPagina.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPagina.lbl_4c_Label9
                .Caption   = "Agrupamento :"
                .Top       = 314
                .Left      = 289
                .Width     = 74
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- getAgrupa: Top=281+29=310, Left=367, Width=79, MaxLength=10
            loc_oPagina.AddObject("txt_4c_Agrupa", "TextBox")
            WITH loc_oPagina.txt_4c_Agrupa
                .Value     = ""
                .Top       = 310
                .Left      = 367
                .Width     = 79
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .InputMask = "XXXXXXXXXX"
                .BackColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH

            *-- Campos ocultos (sem uso - mantidos para compatibilidade)
            *-- Say3: Top=521+29=550, Left=410, Width=59, ForeColor vermelho, Visible=.F.
            loc_oPagina.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPagina.lbl_4c_Label3
                .Caption   = "sem uso :"
                .Top       = 550
                .Left      = 410
                .Width     = 59
                .Height    = 15
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(255, 0, 0)
                .Visible   = .F.
            ENDWITH

            *-- Get1: Top=517+29=546, Left=491, Width=20, MaxLength=1, Visible=.F.
            loc_oPagina.AddObject("txt_4c_1", "TextBox")
            WITH loc_oPagina.txt_4c_1
                .Value     = ""
                .Top       = 546
                .Left      = 491
                .Width     = 20
                .Height    = 25
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 1
                .BackColor = RGB(255, 255, 255)
                .Visible   = .F.
            ENDWITH

            *-- Say4: Top=546+29=575, Left=410, Width=59, ForeColor vermelho, Visible=.F.
            loc_oPagina.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPagina.lbl_4c_Label4
                .Caption   = "sem uso :"
                .Top       = 575
                .Left      = 410
                .Width     = 59
                .Height    = 15
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(255, 0, 0)
                .Visible   = .F.
            ENDWITH

            *-- Optiongroup1: Top=541+29=570, Left=491, Width=99, Visible=.F. (repoauts - sem uso)
            loc_oPagina.AddObject("obj_4c_Optiongroup1", "OptionGroup")
            WITH loc_oPagina.obj_4c_Optiongroup1
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Top         = 570
                .Left        = 491
                .Width       = 104
                .Height      = 25
                .Visible     = .F.
            ENDWITH
            WITH loc_oPagina.obj_4c_Optiongroup1.Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 41
                .Height    = 15
                .Value     = 1
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
                .Themes    = .F.
            ENDWITH
            WITH loc_oPagina.obj_4c_Optiongroup1.Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 53
                .Top       = 5
                .Width     = 41
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
                .Themes    = .F.
            ENDWITH

            *-- BINDEVENT para lookup de usuario (Valid no legado via fwBuscaExt)
            BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress", THIS, "UsuarsLostFocus")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MostrarErro(loException, "FormCol.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MostrarErro("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina), "Erro")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormCol.AlternarPagina")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid da Page1 via Buscar() do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_lValidandoUI, loc_oGrid
        loc_lSucesso    = .F.
        loc_lValidandoUI = TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI

        IF !loc_lValidandoUI
            TRY
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lSucesso = .F.
                ELSE
                    *-- RecordSource e ColumnCount FORA do WITH
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 3

                    *-- ControlSources e Headers APOS RecordSource
                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.colecoes"
                        .Column1.Width           = 79
                        .Column1.Header1.Caption = "Grupo"

                        .Column2.ControlSource   = "cursor_4c_Dados.descs"
                        .Column2.Width           = 290
                        .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                        .Column3.ControlSource   = "cursor_4c_Dados.codcols"
                        .Column3.Width           = 75
                        .Column3.Header1.Caption = "Cod. Coletor"
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loException
                MostrarErro(loException, "FormCol.CarregarLista")
                loc_lSucesso = .F.
            ENDTRY
        ELSE
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro(loException, "FormCol.FormatarGridLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "OBJ_4C_OPTIONGROUP1", "LBL_4C_LABEL3", "TXT_4C_1", "LBL_4C_LABEL4")
                        loc_oObjeto.Visible = .T.
                    ENDIF
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ELSE
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)

        *-- Auto-preencher usuario logado e data de inicio (comportamento do legado)
        IF TYPE("gc_4c_UsuarioLogado") = "C" AND !EMPTY(gc_4c_UsuarioLogado)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Usuars.Value = ALLTRIM(gc_4c_UsuarioLogado)
        ENDIF
        THIS.pgf_4c_Paginas.Page2.txt_4c_DtInicial.Value = DATE()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Inicia edicao do registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cMsg

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.colecoes)

        loc_cMsg = "Confirma a exclus" + CHR(227) + "o do registro '" + loc_cCodigo + "'?"
        IF MsgConfirma(loc_cMsg, "Excluir")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgSucesso("Registro exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega a lista de registros
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva o registro (Page2 Confirmar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_lOk, loc_nExiste, loc_nRes

        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lOk     = .T.
        loc_nExiste = 0

        *-- Validacoes obrigatorias FORA do TRY (RETURN permitido aqui)
        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Colecoes.Value))
            MsgAviso("Grupo de Venda Inv" + CHR(225) + "lido.", "")
            loc_oPg2.txt_4c_Colecoes.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descricao.Value))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida.", "")
            loc_oPg2.txt_4c_Descricao.SetFocus()
            RETURN
        ENDIF

        *-- Validar duplicidade de Cod. Coletor se preenchido
        IF !EMPTY(ALLTRIM(loc_oPg2.txt_4c_1.Value)) AND loc_lOk
            loc_nExiste = 0
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nExiste FROM SigCdCol" + ;
                " WHERE codcols = " + EscaparSQL(ALLTRIM(loc_oPg2.txt_4c_1.Value)) + ;
                " AND colecoes <> " + EscaparSQL(ALLTRIM(loc_oPg2.txt_4c_Colecoes.Value)), ;
                "cursor_4c_ChkCodcols")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ChkCodcols") > 0
                SELECT cursor_4c_ChkCodcols
                loc_nExiste = cursor_4c_ChkCodcols.nExiste
            ENDIF
            IF USED("cursor_4c_ChkCodcols")
                USE IN cursor_4c_ChkCodcols
            ENDIF
            IF loc_nExiste > 0
                MsgAviso("C" + CHR(243) + "digo do Coletor j" + CHR(225) + " Existe", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_1.SetFocus()
                loc_lOk = .F.
            ENDIF
        ENDIF

        *-- Validar duplicidade de Grupo de Venda na inclusao
        IF THIS.this_cModoAtual == "INCLUIR" AND loc_lOk
            loc_nExiste = 0
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nExiste FROM SigCdCol" + ;
                " WHERE colecoes = " + EscaparSQL(ALLTRIM(loc_oPg2.txt_4c_Colecoes.Value)), ;
                "cursor_4c_ChkColecoes")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ChkColecoes") > 0
                SELECT cursor_4c_ChkColecoes
                loc_nExiste = cursor_4c_ChkColecoes.nExiste
            ENDIF
            IF USED("cursor_4c_ChkColecoes")
                USE IN cursor_4c_ChkColecoes
            ENDIF
            IF loc_nExiste > 0
                MsgAviso("Grupo de Venda J" + CHR(225) + " Cadastrada.", "")
                loc_oPg2.txt_4c_Colecoes.SetFocus()
                loc_lOk = .F.
            ENDIF
        ENDIF

        IF loc_lOk
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgSucesso("Registro salvo com sucesso!")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg2.txt_4c_Colecoes.Value         = ""
            loc_oPg2.txt_4c_Descricao.Value        = ""
            loc_oPg2.txt_4c_Usuars.Value           = ""
            loc_oPg2.txt_4c_DtInicial.Value        = {}
            loc_oPg2.opt_4c_ConProds.Value         = 1
            loc_oPg2.opt_4c_AltProds.Value         = 1
            loc_oPg2.txt_4c_Agrupa.Value           = ""
            loc_oPg2.txt_4c_1.Value                = ""
            loc_oPg2.obj_4c_Optiongroup1.Value     = 1
            THIS.this_cUltimoUsuarsValidado        = ""
        CATCH TO loException
            MostrarErro(loException, "FormCol.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    * par_lHabilitar: .T. = editavel, .F. = somente leitura
    * Regra: txt_4c_Colecoes somente editavel em modo INCLUIR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            *-- Codigo (Grupo) somente editavel em INCLUIR
            loc_oPg2.txt_4c_Colecoes.Enabled         = (THIS.this_cModoAtual == "INCLUIR")
            loc_oPg2.txt_4c_Descricao.Enabled        = par_lHabilitar
            loc_oPg2.txt_4c_Usuars.Enabled           = par_lHabilitar
            loc_oPg2.txt_4c_DtInicial.Enabled        = par_lHabilitar
            loc_oPg2.opt_4c_ConProds.Enabled         = par_lHabilitar
            loc_oPg2.opt_4c_AltProds.Enabled         = par_lHabilitar
            loc_oPg2.txt_4c_Agrupa.Enabled           = par_lHabilitar
            loc_oPg2.txt_4c_1.Enabled                = par_lHabilitar
            loc_oPg2.obj_4c_Optiongroup1.Enabled     = par_lHabilitar

        CATCH TO loException
            MostrarErro(loException, "FormCol.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores da Page2 para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_dData

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            THIS.this_oBusinessObject.this_cColecoes = ALLTRIM(loc_oPg2.txt_4c_Colecoes.Value)
            THIS.this_oBusinessObject.this_cDescs    = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
            THIS.this_oBusinessObject.this_cUsuars   = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)

            *-- Converter date para datetime (TextBox armazena D, BO precisa T)
            loc_dData = loc_oPg2.txt_4c_DtInicial.Value
            IF !EMPTY(loc_dData) AND VARTYPE(loc_dData) = "D"
                THIS.this_oBusinessObject.this_dDtincs = CTOT(DTOC(loc_dData) + " 00:00:00")
            ELSE
                IF !EMPTY(loc_dData) AND VARTYPE(loc_dData) = "T"
                THIS.this_oBusinessObject.this_dDtincs = loc_dData
            ELSE
                THIS.this_oBusinessObject.this_dDtincs = {}
                ENDIF
            ENDIF

            THIS.this_oBusinessObject.this_nConprods = loc_oPg2.opt_4c_ConProds.Value
            THIS.this_oBusinessObject.this_nAltprods = loc_oPg2.opt_4c_AltProds.Value
            THIS.this_oBusinessObject.this_cAgrupas  = ALLTRIM(loc_oPg2.txt_4c_Agrupa.Value)
            THIS.this_oBusinessObject.this_cCodcols  = ALLTRIM(loc_oPg2.txt_4c_1.Value)
            THIS.this_oBusinessObject.this_nRepoauts = loc_oPg2.obj_4c_Optiongroup1.Value

        CATCH TO loException
            MostrarErro(loException, "FormCol.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO para os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_nConPrd, loc_nAltPrd

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Colecoes.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cColecoes)
            loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
            loc_oPg2.txt_4c_Usuars.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cUsuars)

            *-- Converter datetime para date para exibicao no TextBox
            IF !EMPTY(THIS.this_oBusinessObject.this_dDtincs)
                loc_oPg2.txt_4c_DtInicial.Value = TTOD(THIS.this_oBusinessObject.this_dDtincs)
            ELSE
                loc_oPg2.txt_4c_DtInicial.Value = {}
            ENDIF

            *-- OptionGroups: Value deve ser 1 ou 2; se 0, default para 1 (Sim)
            loc_nConPrd = THIS.this_oBusinessObject.this_nConprods
            loc_nAltPrd = THIS.this_oBusinessObject.this_nAltprods
            loc_oPg2.opt_4c_ConProds.Value         = IIF(loc_nConPrd >= 1 AND loc_nConPrd <= 2, loc_nConPrd, 1)
            loc_oPg2.opt_4c_AltProds.Value         = IIF(loc_nAltPrd >= 1 AND loc_nAltPrd <= 2, loc_nAltPrd, 1)
            loc_oPg2.txt_4c_Agrupa.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cAgrupas)
            loc_oPg2.txt_4c_1.Value                = ALLTRIM(THIS.this_oBusinessObject.this_cCodcols)
            loc_oPg2.obj_4c_Optiongroup1.Value     = IIF(THIS.this_oBusinessObject.this_nRepoauts >= 1 AND THIS.this_oBusinessObject.this_nRepoauts <= 2, THIS.this_oBusinessObject.this_nRepoauts, 1)

        CATCH TO loException
            MostrarErro(loException, "FormCol.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarsLostFocus - Handler de LostFocus para campo de Usuario
    * Replica comportamento do Valid/fwBuscaExt do legado (SigCdUsu)
    *--------------------------------------------------------------------------
    PROCEDURE UsuarsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)

        IF !loc_oPg2.txt_4c_Usuars.Enabled
            RETURN
        ENDIF

        IF loc_cValor == THIS.this_cUltimoUsuarsValidado
            RETURN
        ENDIF

        IF !EMPTY(loc_cValor)
            THIS.AbrirLookupUsuars()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUsuars - Lookup de usuario em SigCdUsu (fwBuscaExt no legado)
    * Filtro: cAtivos <> 'N' (somente usuarios ativos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupUsuars()
        LOCAL loc_oBusca, loc_oPg2, loc_cValor, loc_cUsuario

        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", ;
                "cursor_4c_BuscaUsuario", ;
                "Usuarios", ;
                loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", ;
                .T., .F., "cAtivos <> 'N'")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsuario")
                    SELECT cursor_4c_BuscaUsuario
                    loc_cUsuario = ALLTRIM(cursor_4c_BuscaUsuario.Usuarios)
                    loc_oPg2.txt_4c_Usuars.Value = loc_cUsuario
                    THIS.this_cUltimoUsuarsValidado = loc_cUsuario

                    *-- Auto-preencher Data de Inicio se vazia (comportamento do legado)
                    IF EMPTY(loc_oPg2.txt_4c_DtInicial.Value)
                        loc_oPg2.txt_4c_DtInicial.Value = DATE()
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lSelecionou
                    *-- Usuario cancelou selecao: limpar campo
                    loc_oPg2.txt_4c_Usuars.Value = ""
                    THIS.this_cUltimoUsuarsValidado = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "FormCol.AbrirLookupUsuars")
        ENDTRY

        IF USED("cursor_4c_BuscaUsuario")
            USE IN cursor_4c_BuscaUsuario
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    * Replica comportamento do legado: em INSERIR mostra campo codcols (Get1)
    * Confirmar habilitado em INCLUIR/ALTERAR; desabilitado em VISUALIZAR
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditando, loc_lIncluindo

        TRY
            loc_oPg2      = THIS.pgf_4c_Paginas.Page2
            loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_lIncluindo = (THIS.this_cModoAtual == "INCLUIR")

            *-- Botao Confirmar: habilitado apenas em edicao
            IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditando
            ENDIF

            *-- Botao Cancelar: sempre habilitado na Page2
            IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar) = "O"
                loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
            ENDIF

            *-- Campo codcols (Get1/txt_4c_1) e label "sem uso" visivel apenas em INSERIR
            *-- (replica comportamento do legado: Say3.Visible=.T., Get1.Visible=.T. em INSERIR)
            IF VARTYPE(loc_oPg2.txt_4c_1) = "O"
                loc_oPg2.txt_4c_1.Visible            = loc_lIncluindo
                loc_oPg2.lbl_4c_Label3.Visible       = loc_lIncluindo
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "FormCol.AjustarBotoesPorModo")
        ENDTRY
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
