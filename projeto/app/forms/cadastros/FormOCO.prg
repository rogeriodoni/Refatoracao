*==============================================================================
* FormOCO.prg - Cadastro de Ocorr" + CHR(234) + "ncias
* Herda de FormBase (app/classes/formbase.prg)
* Tabela: SigCcCCo | Fase 6/8: Form - Campos Restantes e Lookups (completo)
*==============================================================================

DEFINE CLASS FormOCO AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Ocorrencias"
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
    * Init - Inicializa o formulario (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MostrarErro(loException, "FormOCO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao completa do formulario (chamado pelo FormBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Caption com acento (CHR(234)=e-circumflexo em "Ocorrencias")
            THIS.Caption = "Cadastro de Ocorr" + CHR(234) + "ncias"

            *-- Criar instancia do BO
            THIS.this_oBusinessObject = CREATEOBJECT("OCOBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao instanciar OCOBO", "FormOCO.InicializarForm")
                loc_lSucesso = .F.
            ELSE
                *-- Configurar estrutura visual
                THIS.ConfigurarPageFrame()

                *-- Propagar Caption para labels do cabecalho
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    IF VARTYPE(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho) = "O"
                        THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                        THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                *-- Carregar dados na lista (pula se validando UI sem conexao SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOCO.InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            *-- PageFrame externo com Top=-29 para ocultar abas
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .Top       = -29
                .Left      = 0
                .Width     = 1000
                .Height    = 629
                .PageCount = 2
                .Tabs      = .F.
                .Visible   = .T.

                *-- Fundo das paginas
                .Page1.BackColor = RGB(100, 100, 100)
                .Page2.BackColor = RGB(100, 100, 100)
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page1.Caption   = "Lista"
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Caption   = "Dados"
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            ENDWITH

            *-- Configurar conteudo das paginas
            THIS.ConfigurarPaginaListaBase()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDadosBase()
            THIS.ConfigurarPaginaDados()

        CATCH TO loException
            MostrarErro(loException, "FormOCO.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaListaBase - Estrutura base da Page1 (Lista)
    * Container cabecalho e container botoes (sem grid/botoes CRUD - Fase 4)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaListaBase()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Container Cabecalho (compensacao PageFrame.Top: +29)
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 2 + 29
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Top       = 15
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .Caption   = THIS.Caption
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
                    .Caption   = THIS.Caption
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- Container Botoes CRUD (compensacao PageFrame.Top: +29)
            *-- Conteudo dos botoes sera adicionado na Fase 4
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top         = 0 + 29
                .Left        = 542
                .Width       = 390
                .Height      = 85
                .BackColor   = RGB(53, 53, 53)
                .BackStyle   = 1
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Container Saida - padrao canonico (prevalece sobre PILAR 1)
            *-- cnt_4c_Saida eh flutuante/transparente, Left=917, Width=90
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
                    .Left            = 917
                    .Top             = 5
                    .Width           = 90
                    .Height          = 75
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
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

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MostrarErro(loException, "FormOCO.ConfigurarPaginaListaBase")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDadosBase - Estrutura base da Page2 (Dados)
    * Container botoes acao (sem campos TextBox - Fases 5-6)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDadosBase()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Container Botoes Acao (Salvar/Cancelar) - compensacao +29
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 4 + 29
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Confirmar", "CommandButton")
                WITH .cmd_4c_Confirmar
                    .Left            = 5
                    .Top             = 5
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Confirmar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .PicturePosition = 13
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
                    .Enabled         = .T.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Cancelar", "CommandButton")
                WITH .cmd_4c_Cancelar
                    .Left            = 80
                    .Top             = 5
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .PicturePosition = 13
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
                    .Enabled         = .T.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MostrarErro(loException, "FormOCO.ConfigurarPaginaDadosBase")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona botoes CRUD e grid na Page1
    * Chamado apos ConfigurarPaginaListaBase (que criou containers base)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Botoes CRUD no cnt_4c_Botoes (ja criado em ConfigurarPaginaListaBase)
            WITH loc_oPagina.cnt_4c_Botoes
                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Caption         = "Incluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                    .PicturePosition = 13
                    .Left            = 5
                    .Top             = 5
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
                    .Left            = 80
                    .Top             = 5
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
                    .Left            = 155
                    .Top             = 5
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
                    .Left            = 230
                    .Top             = 5
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
                    .Left            = 305
                    .Top             = 5
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

            *-- BINDEVENT botoes CRUD (metodos PUBLIC, sem PROTECTED)
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

            *-- Grid de listagem (Top = original 101 + compensacao PageFrame 29 = 130)
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oGrid = loc_oPagina.grd_4c_Lista
            loc_oGrid.Top  = 130
            loc_oGrid.Left = 29
            WITH loc_oGrid
                .Width              = 890
                .Height             = 451
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

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MostrarErro(loException, "FormOCO.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona campos TextBox e labels na Page2
    * Chamado apos ConfigurarPaginaDadosBase (que criou botoes Confirmar/Cancelar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Label "Codigo : " - top original 209 + compensacao 29 = 238
            *-- Original: Say1.Left=372, ForeColor=90,90,90; textbox at Left=419 (gap 47px)
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Caption   = "C" + CHR(243) + "digo : "
                .Top       = 238
                .Left      = 372
                .Width     = 45
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- TextBox Codigo - top original 206 + compensacao 29 = 235
            *-- Original: Get_Cods.Width=24 (codigo curto)
            loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPagina.txt_4c_Codigo
                .Value         = ""
                .Top           = 235
                .Left          = 419
                .Width         = 24
                .Height        = 22
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 20
                .SpecialEffect = 0
                .BorderStyle   = 1
                .Enabled       = .T.
                .Visible       = .T.
            ENDWITH

            *-- Label "Descricao : " - top original 235 + compensacao 29 = 264
            *-- Original: Say2.Left=359, ForeColor=90,90,90; textbox at Left=419 (gap 60px)
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
                .Top       = 264
                .Left      = 359
                .Width     = 60
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- TextBox Descricao - top original 232 + compensacao 29 = 261
            *-- Original: Get_Descs.Width=220
            loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
            WITH loc_oPagina.txt_4c_Descricao
                .Value         = ""
                .Top           = 261
                .Left          = 419
                .Width         = 220
                .Height        = 22
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 100
                .SpecialEffect = 0
                .BorderStyle   = 1
                .Enabled       = .T.
                .Visible       = .T.
            ENDWITH

            *-- BINDEVENT botoes Page2
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MostrarErro(loException, "FormOCO.ConfigurarPaginaDados")
        ENDTRY
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
    * CarregarLista - Carrega registros no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- Vincular grid ao cursor e configurar colunas
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 2
                    *-- Reconfigurar colunas apos RecordSource (VFP reseta headers)
                    loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.cods"
                    loc_oGrid.Column1.Width           = 150
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
                    loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descs"
                    loc_oGrid.Column2.Width           = 220
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOCO.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgErro("N" + CHR(250) + "mero de p" + CHR(225) + "gina inv" + CHR(225) + "lido: " + TRANSFORM(par_nPagina), "AlternarPagina")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOCO.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do formulario para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
        CATCH TO loException
            MostrarErro(loException, "FormOCO.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
            loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        CATCH TO loException
            MostrarErro(loException, "FormOCO.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos na Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Codigo.Value    = ""
            loc_oPg2.txt_4c_Descricao.Value = ""
        CATCH TO loException
            MostrarErro(loException, "FormOCO.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos na Page2
    * Regra original (Get_Cods.When / Get_Descs.When):
    *   Codigo: habilitado SOMENTE em modo INCLUIR (PK nao muda em ALTERAR)
    *   Descricao: habilitada em INCLUIR e ALTERAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lIncluir, loc_lAlterar
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_lIncluir = (THIS.this_cModoAtual = "INCLUIR")
        loc_lAlterar = (THIS.this_cModoAtual = "ALTERAR")

        TRY
            loc_oPg2.txt_4c_Codigo.Enabled    = loc_lIncluir AND par_lHabilitar
            loc_oPg2.txt_4c_Descricao.Enabled = (loc_lIncluir OR loc_lAlterar) AND par_lHabilitar
        CATCH TO loException
            MostrarErro(loException, "FormOCO.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lNaLista
        loc_oPg1     = THIS.pgf_4c_Paginas.Page1
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_lNaLista = (THIS.this_cModoAtual = "LISTA")

        TRY
            IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir) = "O"
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lNaLista
            ENDIF

            IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar) = "O"
                *-- Confirmar: habilitado somente em INCLUIR/ALTERAR
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
                    INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                *-- Cancelar: sempre habilitado quando em Page2
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOCO.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Novo registro (INSERIR no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
        CATCH TO loException
            MostrarErro(loException, "FormOCO.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Consultar registro (CONSULTAR no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
                ELSE
                    MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOCO.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Editar registro (ALTERAR no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
                ELSE
                    MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOCO.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
                IF MsgConfirma("Confirma exclus" + CHR(227) + "o da ocorr" + CHR(234) + "ncia '" + loc_cCodigo + "'?", "Excluir")
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Ocorr" + CHR(234) + "ncia exclu" + CHR(237) + "da com sucesso.", "Sucesso")
                            THIS.CarregarLista()
                        ELSE
                            MsgErro("Erro ao excluir o registro.", "Erro")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOCO.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarregar lista (PROCURAR no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loException
            MostrarErro(loException, "FormOCO.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar registro (Confirmar na Page2)
    * Validacoes replicadas do original (Salva.Click em SIGCDOCO):
    *   1. Codigo obrigatorio (INSERIR)
    *   2. Descricao nao pode estar vazia (INSERIR e ALTERAR)
    * Verificacao de codigo duplicado: delegada ao OCOBO.ValidarDados() via Salvar()
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_cModoAtual = "INCLUIR" AND ;
                EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo.")
            loc_oPg2.txt_4c_Codigo.SetFocus()
            RETURN
        ENDIF

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
                EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descricao.Value))
            MsgAviso("A descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode estar vazia.")
            loc_oPg2.txt_4c_Descricao.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Sucesso")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    IF loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
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
        DODEFAULT()
    ENDPROC

ENDDEFINE
