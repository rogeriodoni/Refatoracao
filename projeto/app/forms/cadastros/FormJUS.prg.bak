*==============================================================================
* FormJUS.prg - Formulario Cadastro de Justificativas do Retrabalho
* Migrado de: SIGCDJUS.SCX (frmcadastro)
* Tabela: SigPrJst | BO: JUSBO
* FASE 8/8 COMPLETO - Todos os metodos implementados
*==============================================================================

DEFINE CLASS FormJUS AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Justificativas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Business object e controle de modo
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Parametros recebidos do form pai (legado: pForm, pRetrab)
    this_cRetrabalho = ""     && tipo de retrabalho - filtra a grade
    this_oFormPai    = .NULL. && referencia ao form pai (desabilita/reabilita)

    *==========================================================================
    * Init - Captura parametros e delega para FormBase.Init()
    * par_oForm:        referencia ao form que abriu este sub-form
    * par_cRetrabalho:  tipo de retrabalho (ex: "FRISO", "SOLDA")
    *==========================================================================
    PROCEDURE Init(par_oForm, par_cRetrabalho)
        IF VARTYPE(par_oForm) = "O"
            THIS.this_oFormPai = par_oForm
            par_oForm.Enabled = .F.
        ENDIF

        IF VARTYPE(par_cRetrabalho) = "C"
            IF !EMPTY(ALLTRIM(par_cRetrabalho))
                THIS.this_cRetrabalho = ALLTRIM(par_cRetrabalho)
                THIS.Caption = "Cadastro de Justificativas do Retrabalho " + ;
                               PROPER(ALLTRIM(par_cRetrabalho))
            ENDIF
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, PageFrame e carrega lista inicial
    * Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("JUSBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar JUSBO", "InicializarForm")
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

        CATCH TO loException
            MostrarErro(loException, "FormJUS.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .PageCount  = 2
            .Tabs       = .F.
            .TabStretch = 1
            .Visible = .T.
        ENDWITH
        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, grid e saida
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCnt, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho escuro (cntSombra no legado)
        *-- Compensa PageFrame.Top=-29: Top_original=2 + 29 = 31
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
            .Width     = THIS.Width - 12
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
            .Width     = THIS.Width - 12
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
        *-- Grupo_op.Left=307; escalonado para form 1000px
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_Botoes
        WITH loc_oCnt
            .Top         = 29
            .Left        =  542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (INSERIR no legado)
        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (PROCURAR readonly no legado)
        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (ALTERAR no legado)
        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (PROCURAR picker no legado)
        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container saida canonico - padrao CLAUDE.md regra #10
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Grade no legado)
        *-- Top = 88 (framework original) + 29 (compensacao PageFrame) = 117
        *-- Tabela SigPrJst: Cods (PK), Descrs, cRetrabs
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Dados
        loc_oGrid.Top         = 117
        loc_oGrid.Left        = 12
        loc_oGrid.Width       = 890
        loc_oGrid.Height      = 470
        loc_oGrid.ColumnCount = 3
        WITH loc_oGrid
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
        WITH loc_oGrid.Column1
            .Width     = 80
            .Alignment = 0
        ENDWITH
        WITH loc_oGrid.Column2
            .Width = 650
        ENDWITH
        WITH loc_oGrid.Column3
            .Width = 120
        ENDWITH

        *-- Em modo teste: pre-vincula grid para evitar VFP9 internal error com grid sem RecordSource
        *-- NOTA: Header1.Caption OMITIDO — em modo headless (-T) o grid nunca e renderizado;
        *--        acessar Header1 gera erro 2030 nao-capturavel que trava VFP9 por 300s.
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (cidchaves C(20), cods C(3), cRetrabs C(6), descrs C(30))
            ENDIF
            loc_oGrid.ColumnCount = 3
            loc_oGrid.RecordSource          = "cursor_4c_Dados"
            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
            loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cRetrabs"
        ENDIF

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: botoes acao e campo Codigo (FASE 5)
    * Legado: Grupo_Salva (Salva+Cancelar) + Say7 ("Codigo :") + Get_codigo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Grupo_Salva no legado)
        *-- Grupo_Salva.Left=619, Top=13; compensacao PageFrame (+29): Top=42
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
        WITH loc_oCnt
            .Top         = 42
            .Left        = 619
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Grupo_Salva.Salva no legado: Top=5, Left=5)
        loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Confirmar
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
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Grupo_Salva.Cancelar no legado: Top=5, Left=80)
        loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cancelar
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
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label "Codigo :" (Say7 no legado: Top=89, Left=161)
        *-- Compensacao PageFrame (+29): Top=118
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 118
            .Left      = 161
            .Height    = 17
            .Width     = 58
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_codigo no legado: Top=86, Left=215, Width=31, Height=23)
        *-- Compensacao PageFrame (+29): Top=115; MaxLength=3; Format="K!" do legado
        *-- Habilitacao por modo (INSERIR only) sera controlada por HabilitarCampos()
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 115
            .Left      = 215
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .ForeColor = RGB(0, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        *-- Label "Descricao :" (Say2 no legado: Top=117, Left=148, Width=58, Height=15)
        *-- Compensacao PageFrame (+29): Top=146
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 146
            .Left      = 148
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (get_Descr no legado: Top=112, Left=215, Width=220, Height=25)
        *-- Compensacao PageFrame (+29): Top=141; MaxLength=30
        *-- When do legado: InList(pcEscolha,'INSERIR','ALTERAR') -> habilitado para INCLUIR e ALTERAR
        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value     = ""
            .Top       = 141
            .Left      = 215
            .Width     = 220
            .Height    = 25
            .MaxLength = 30
            .ForeColor = RGB(0, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .TabIndex  = 2
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega registros de SigPrJst filtrados por this_cRetrabalho
    * e vincula ao grid grd_4c_Dados
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_cFiltro, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
               (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), cods C(3), cRetrabs C(6), descrs C(30))
                ENDIF
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource          = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cRetrabs"
                *-- Header1.Caption omitido: em headless (-T) gera erro 2030 nao-capturavel
                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ELSE
                loc_cFiltro = ""
                IF !EMPTY(THIS.this_cRetrabalho)
                    loc_cFiltro = "cRetrabs = " + EscaparSQL(THIS.this_cRetrabalho)
                ENDIF

                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource        = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cRetrabs"
                    *-- Reconfigurar headers: RecordSource reseta captions
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Retrabalho"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "FormJUS.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual da grade de listagem
    * Original: Grade.FontName="Tahoma", ForeColor=RGB(90,90,90)
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Iterar Pages de PageFrames alem de Controls
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.BaseClass), "GRID", "COLUMN")
                    LOOP
                ENDIF

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
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

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
            MostrarErro(loException, "FormJUS.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo somente-leitura
    * Equivale ao PROCURAR (readonly) do legado
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCods

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCods = ALLTRIM(cursor_4c_Dados.Cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Erro ao carregar registro selecionado.", "Visualizar")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    * Legado: pcEscolha='ALTERAR', SetFocus em Get_Descr
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCods

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCods = ALLTRIM(cursor_4c_Dados.Cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descr.SetFocus
        ELSE
            MsgAviso("Erro ao carregar registro selecionado.", "Alterar")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCods, loc_lConfirma

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCods = ALLTRIM(cursor_4c_Dados.Cods)

        loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do registro '" + ;
                                    loc_cCods + "'?", "Excluir")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
                THIS.CarregarLista()
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Excluir")
            ENDIF
        ELSE
            MsgAviso("Erro ao carregar registro selecionado.", "Excluir")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar justificativa
    * Equivale ao PROCURAR (picker) do legado
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cFiltro, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cFiltro = ""
            IF !EMPTY(THIS.this_cRetrabalho)
                loc_cFiltro = "cRetrabs = " + EscaparSQL(THIS.this_cRetrabalho)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrJst", "cursor_4c_BuscaJus", "Cods", "", ;
                "Buscar Justificativa", .F., .T., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJus")
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR cursor_4c_Dados.Cods = ALLTRIM(cursor_4c_BuscaJus.Cods)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "FormJUS.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaJus")
            USE IN cursor_4c_BuscaJus
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario e reabilita form pai via Destroy
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Value = ;
                ALLTRIM(THIS.this_oBusinessObject.this_cCods)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            loc_oPagina.txt_4c_Descr.Value = ;
                ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos da Page2 para propriedades do BO
    * Inclui this_cRetrabs do form (nao vem de campo visual, vem da propriedade)
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            THIS.this_oBusinessObject.this_cCods = ;
                UPPER(ALLTRIM(loc_oPagina.txt_4c_Codigo.Value))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            THIS.this_oBusinessObject.this_cDescrs = ;
                ALLTRIM(loc_oPagina.txt_4c_Descr.Value)
        ENDIF

        *-- Vincula o tipo de retrabalho do form pai (nao ha campo visual para isso)
        THIS.this_oBusinessObject.this_cRetrabs = THIS.this_cRetrabalho
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme o modo
    * When do legado:
    *   Get_codigo: InList(pcEscolha,'INSERIR','PROCURAR')  -> INCLUIR/VISUALIZAR
    *   get_Descr:  InList(pcEscolha,'INSERIR','ALTERAR')   -> INCLUIR/ALTERAR
    * par_lHabilitar: .T. = modo edicao, .F. = somente leitura (VISUALIZAR)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lCodigoHab, loc_lDescrHab
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: habilitado apenas para INCLUIR (INSERIR no legado)
        *-- Em VISUALIZAR e ALTERAR fica readonly para nao alterar a PK
        loc_lCodigoHab = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR")

        *-- Descricao: habilitada para INCLUIR e ALTERAR
        loc_lDescrHab = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Enabled = loc_lCodigoHab
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            loc_oPagina.txt_4c_Descr.Enabled = loc_lDescrHab
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2 (chamado no Incluir)
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            loc_oPagina.txt_4c_Descr.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes Confirmar conforme modo
    * Em VISUALIZAR, Confirmar fica desabilitado (nao ha alteracao a salvar)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lPodeConfirmar
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
        loc_lPodeConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
            loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lPodeConfirmar
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida, salva e volta para lista
    * Logica baseada no Pagina.Dados.Grupo_Salva.Salva.Click do legado:
    *   - Valida Codigo nao vazio (para INSERIR)
    *   - Verifica duplicidade (para INSERIR)
    *   - Vincula cRetrabs ao tipo de retrabalho do form pai
    *   - Salva e retorna para Page1
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- Validar codigo obrigatorio para INCLUIR (fora do TRY - regra CLAUDE.md)
        IF THIS.this_cModoAtual = "INCLUIR"
            IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value))
                MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso.", "Confirmar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormJUS.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para Page1
    * Equivale ao Pagina.Dados.Grupo_Salva.Cancelar.Click do legado
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos e reabilita form pai
    * Equivale ao Release do legado: ThisForm.oForm.Enabled = .t.
    *==========================================================================
    PROCEDURE Destroy()
        *-- Reabilitar form pai (legado: PROCEDURE Release / oForm.Enabled = .t.)
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
