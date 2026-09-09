*==============================================================================
* FormTbv.prg - Formulario de Cadastro de Tabelas de Desconto
* Tabela: SigOpTdz | PK: codigos
* Legado: SIGCDTBV.SCX (frmcadastro)
*
* FASE 10 - Sub-pagina "Descontos / Comissoes" (pgDesconto) completa:
* grd_4c_Gradei (composicao/formula), grd_4c_Gradec (comissoes),
* cnt_4c_Formula1/2, Desconto Maximo, Combo_Comis, DescFats/FatorPads,
* Ignora Cotacao. Ver tambem ConfigurarPgPgConfDesconto ("Configuracao
* de Desconto") e TbvBO (Carregar/SalvarComposicaoDesconto,
* Carregar/SalvarComissoesDesconto, Carregar/SalvarFaixasDesconto).
*==============================================================================

DEFINE CLASS FormTbv AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Tabelas de Descontos"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8
    ForeColor    = RGB(90, 90, 90)

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("TbvBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object TbvBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao inicializar FormTbv:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura PageFrame principal
    * Legado: pagina.Width=1000, PageFrame.Top=-29 (oculta abas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1000
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao +29: PageFrame.Top=-29 desloca conteudo 29px para cima
    * cnt_4c_Cabecalho: Top=2+29=31 | cnt_4c_Botoes: Top=0+29=29, Left=542
    * cnt_4c_Saida (canonico CLAUDE.md #10): Top=29, Left=917, Width=90
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (cntSombra: Top=2 -> 31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1000
            .Height      = 80
            .BackStyle   = 1
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
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
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
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (grupo_op: Left=542, Top=0 -> 29, Width=390, Height=85)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPagina.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
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
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
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
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
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
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
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
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
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
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico CLAUDE.md #10: Left=917, Width=90)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPagina.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
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
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (Top = 88 + 29 = 117, compensacao PageFrame.Top=-29)
        *-- RecordSource/ColumnCount definidos aqui (fora de WITH) para evitar
        *-- "Unknown member COLUMN1" - colunas configuradas de fato em CarregarLista()
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 4
        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .RowHeight          = 16
            .ScrollBars         = 2
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega tabelas de desconto e configura o grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                *-- DataSession=2: criar cursor em session 1 para o TesteAutomatico enxergar
                LOCAL loc_nDsAtual
                loc_nDsAtual = THIS.DataSessionID
                SET DATASESSION TO 1
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (codigos C(10), descrs C(30), moerefs C(3), descos N(5,2))
                INSERT INTO cursor_4c_Dados VALUES ("0000000001", "Tabela Teste", "REA", 0)
                SET NULL OFF
                SET DATASESSION TO (loc_nDsAtual)
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount   = 4
                    loc_oGrid.RecordSource  = "cursor_4c_Dados"

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.moerefs"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.descos"

                    loc_oGrid.Column1.Width         = 110
                    loc_oGrid.Column2.Width         = 480
                    loc_oGrid.Column3.Width         = 100
                    loc_oGrid.Column4.Width         = 130

                    loc_oGrid.Column1.ReadOnly      = .T.
                    loc_oGrid.Column2.ReadOnly      = .T.
                    loc_oGrid.Column3.ReadOnly      = .T.
                    loc_oGrid.Column4.ReadOnly      = .T.

                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Moeda Ref" + CHR(234) + "ncia"
                    loc_oGrid.Column4.Header1.Caption = "Desconto (%)"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTbv.CarregarLista")
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
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTbv.AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * cnt_4c_BotoesAcao: Top=4+29=33, Left=834, Width=160, Height=85
    *
    * Campos principais (aba interna legado "pgDados"): a aba ficava dentro de
    * um PageFrame interno (Pagina.Dados.Page1, Top=122) que por sua vez estava
    * dentro do PageFrame externo (Top=-29). Compensacao total = 122 + 29 = 151.
    * FASE 5/8: primeiros 50% dos campos (Codigo/Descricao/MoedaRef/Desconto/
    * Observacao/ValidoAte/Parcelas/Ajuste/Fator/MoedaFator).
    * FASE 6/8 completa os campos restantes (OptionGroups, ComboBox, grid empresas).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - CLAUDE.md #11 / Erro152
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


        *-- cursor_4c_Tdt (SigOpTdt) so e populado de verdade em
        *-- CarregarComposicaoDesconto() (chamado por BOParaForm), mas os
        *-- controles de cnt_4c_Formula1/2, cbo_4c_ComboComis, txt_4c_DescFats,
        *-- txt_4c_FatorPads e chk_4c_IgnoraCotacao (ConfigurarPgPgDesconto)
        *-- recebem ControlSource apontando para ele AGORA, no Init do form -
        *-- diferente de coluna de Grid, TextBox/ComboBox/CheckBox resolvem o
        *-- alias imediatamente na atribuicao de .ControlSource, disparando
        *-- "Alias 'CURSOR_4C_TDT' is not found." se o cursor ainda nao existe
        THIS.CriarCursorTdtVazio()

        *-- Container de botoes de acao (Grupo_Salva: Left=834, Top=4 -> 33)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 834
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

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

        *----------------------------------------------------------------------
        * Codigo (PK) - this_cCodigo / codigos char(10)
        * Legado: pgDados.get_codigos (top=23,left=264) + lbl_codigos (top=30,left=218)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_codigos", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_codigos
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 181
            .Left      = 218
            .Width     = 42
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__codigos", "TextBox")
        WITH loc_oPagina.txt_4c__codigos
            .Top       = 174
            .Left      = 264
            .Width     = 80
            .Height    = 18
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Descricao - this_cDescricao / descrs char(30)
        * Legado: get_descrs (top=49,left=264,width=220) + lbl_descrs (top=56,left=205)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_descrs", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_descrs
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 207
            .Left      = 205
            .Width     = 55
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__descrs", "TextBox")
        WITH loc_oPagina.txt_4c__descrs
            .Top       = 200
            .Left      = 264
            .Width     = 220
            .Height    = 18
            .MaxLength = 30
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Moeda de Referencia - this_cMoeRef / moerefs char(3) + descricao (lookup)
        * Legado: get_moerefs (top=75,left=264,width=31) +
        *         get_moerefs_desc (top=75,left=298,width=115) + lbl_moerefs (top=81,left=195)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_moerefs", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_moerefs
            .Caption   = "Moeda Ref. :"
            .Top       = 232
            .Left      = 195
            .Width     = 65
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__moerefs", "TextBox")
        WITH loc_oPagina.txt_4c__moerefs
            .Top       = 226
            .Left      = 264
            .Width     = 31
            .Height    = 18
            .MaxLength = 3
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c__moerefs, "KeyPress", THIS, "MoedaRefLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c__moerefs, "DblClick", THIS, "MoedaRefLookupDblClick")

        loc_oPagina.AddObject("txt_4c__moerefs_desc", "TextBox")
        WITH loc_oPagina.txt_4c__moerefs_desc
            .Top       = 226
            .Left      = 298
            .Width     = 115
            .Height    = 18
            .MaxLength = 20
            .Value     = ""
            .ReadOnly  = .T.
            .TabStop   = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Desconto (%) - this_nDesconto / descos numeric(5,2)
        * Legado: get_descos (top=101,left=264,width=66) + lbl_descos (top=107,left=206)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_descos", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_descos
            .Caption   = "Desconto :"
            .Top       = 258
            .Left      = 206
            .Width     = 54
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__descos", "TextBox")
        WITH loc_oPagina.txt_4c__descos
            .Top       = 252
            .Left      = 264
            .Width     = 66
            .Height    = 18
            .InputMask = "999.99"
            .Alignment = 1
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Observacao - this_cObservacao / obss char(30)
        * Legado: get_obss (top=127,left=264,width=220) + lbl_obss (top=133,left=193)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_obss", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_obss
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 284
            .Left      = 193
            .Width     = 67
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__obss", "TextBox")
        WITH loc_oPagina.txt_4c__obss
            .Top       = 278
            .Left      = 264
            .Width     = 220
            .Height    = 18
            .MaxLength = 30
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Valido Ate - this_dDataTermino / dtterms date
        * Legado: Get_dtval (top=153,left=264,width=80) + Say1 (top=159,left=204)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "V" + CHR(225) + "lido at" + CHR(233) + " :"
            .Top       = 310
            .Left      = 204
            .Width     = 56
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dtval", "TextBox")
        WITH loc_oPagina.txt_4c_Dtval
            .Top       = 304
            .Left      = 264
            .Width     = 80
            .Height    = 18
            .Value     = {}
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Parcelas / Parcelas Ate - this_nParcelas + this_nParcelas2 / nparcs, nparc2s numeric(3,0)
        * Legado: Get_nParcs (top=179,left=264,width=31) + Say5 (top=183,left=211)
        *         Get_nParc2s (top=179,left=324,width=31) + Say10 (top=183,left=299,"Ate")
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Parcelas :"
            .Top       = 334
            .Left      = 211
            .Width     = 49
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_NParcs", "TextBox")
        WITH loc_oPagina.txt_4c_NParcs
            .Top       = 330
            .Left      = 264
            .Width     = 31
            .Height    = 18
            .InputMask = "999"
            .Alignment = 1
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "At" + CHR(233)
            .Top       = 334
            .Left      = 299
            .Width     = 19
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_NParc2s", "TextBox")
        WITH loc_oPagina.txt_4c_NParc2s
            .Top       = 330
            .Left      = 324
            .Width     = 31
            .Height    = 18
            .InputMask = "999"
            .Alignment = 1
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Valor Ajuste - this_nAjuste / ajustes numeric(8,6)
        * Legado: Get_Ajuste (top=205,left=264,width=73) + Say7 (top=209,left=193)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Valor Ajuste :"
            .Top       = 360
            .Left      = 193
            .Width     = 67
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ajuste", "TextBox")
        WITH loc_oPagina.txt_4c_Ajuste
            .Top       = 356
            .Left      = 264
            .Width     = 73
            .Height    = 18
            .InputMask = "99.999999"
            .Alignment = 1
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Fator / Moeda Fator - this_nFator + this_cMoedaFator / fators numeric(4,2), moefats char(3)
        * Legado: Get_Fator (top=231,left=264,width=45) + Say8 (top=234,left=225)
        *         Get_MoeFat (top=257,left=264,width=31) + Say9 (top=260,left=190)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Fator :"
            .Top       = 385
            .Left      = 225
            .Width     = 35
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fator", "TextBox")
        WITH loc_oPagina.txt_4c_Fator
            .Top       = 382
            .Left      = 264
            .Width     = 45
            .Height    = 18
            .InputMask = "99.99"
            .Alignment = 1
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Moeda Fator :"
            .Top       = 411
            .Left      = 190
            .Width     = 70
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_MoeFat", "TextBox")
        WITH loc_oPagina.txt_4c_MoeFat
            .Top       = 408
            .Left      = 264
            .Width     = 31
            .Height    = 18
            .MaxLength = 3
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_MoeFat, "KeyPress", THIS, "MoedaFatorLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_MoeFat, "DblClick", THIS, "MoedaFatorLookupDblClick")

        *----------------------------------------------------------------------
        * Prazo Medio - this_nPrazoMedio / prazoms numeric(3,0) - "sem uso" no legado
        * Legado: Get_PrazoMs (top=419,left=527,width=31,Visible=.F.) + Say2 (top=425,left=466,Visible=.F.)
        * Mantido oculto para paridade de schema/BO (campo existe na tabela mas nao e usado)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "sem uso :"
            .Top       = 576
            .Left      = 466
            .Width     = 59
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(255, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .F.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_PrazoMs", "TextBox")
        WITH loc_oPagina.txt_4c_PrazoMs
            .Top       = 570
            .Left      = 527
            .Width     = 31
            .Height    = 18
            .InputMask = "999"
            .Alignment = 1
            .Value     = 0
            .FontName  = "Courier New"
            .FontSize  = 8
            .Visible   = .F.
        ENDWITH

        *----------------------------------------------------------------------
        * Imprime no Rel. Tab.Desconto - this_nRelDesconto / rel_descs numeric(1,0)
        * Legado: opt_rel_descs (top=305,left=261,width=86,height=23) + lbl_imprime (top=309,left=106)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_imprime", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_imprime
            .Caption   = "Imprime no Rel. Tab.Desconto :"
            .Top       = 460
            .Left      = 106
            .Width     = 154
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opt_rel_descs", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opt_rel_descs
            .Top         = 456
            .Left        = 261
            .Width       = 91
            .Height      = 23
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_rel_descs.Buttons(1)
            .Caption   = "Sim"
            .Left      = 2
            .Top       = 4
            .Width     = 34
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_rel_descs.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 44
            .Top       = 4
            .Width     = 37
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        *----------------------------------------------------------------------
        * Checar Acesso - this_nChkAcesso / chkactb numeric(1,0)
        * Legado: Chk_Acesso (top=282,left=261,width=86,height=23) + Say4 (top=286,left=180)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Checar Acesso :"
            .Top       = 437
            .Left      = 180
            .Width     = 80
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Chk_Acesso", "OptionGroup")
        WITH loc_oPagina.obj_4c_Chk_Acesso
            .Top         = 433
            .Left        = 261
            .Width       = 91
            .Height      = 23
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Chk_Acesso.Buttons(1)
            .Caption   = "Sim"
            .Left      = 2
            .Top       = 4
            .Width     = 34
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Chk_Acesso.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 44
            .Top       = 4
            .Width     = 37
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        *----------------------------------------------------------------------
        * Aplicado Na Quantidade de Produtos - this_nChkRetorno / chkrets numeric(1,0)
        * Legado: chkAplicado (top=235,left=314,width=194,height=15)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("chk_4c_ChkAplicado", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkAplicado
            .Caption   = "Aplicado Na Quantidade de Produtos"
            .Top       = 386
            .Left      = 314
            .Width     = 194
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Abater Custo de Produto da Comissao - this_nAbateCusto / abatecus numeric(1,0)
        * Legado: optAbateCus (top=329,left=261,width=86,height=23) + Say3 (top=333,left=68)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Abater Custo de Produto da Comiss" + CHR(227) + "o :"
            .Top       = 484
            .Left      = 68
            .Width     = 192
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptAbateCus", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptAbateCus
            .Top         = 480
            .Left        = 261
            .Width       = 91
            .Height      = 23
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptAbateCus.Buttons(1)
            .Caption   = "Sim"
            .Left      = 2
            .Top       = 4
            .Width     = 34
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptAbateCus.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 44
            .Top       = 4
            .Width     = 37
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        *----------------------------------------------------------------------
        * Agrupar Comissao por - this_nAgrupaComissao / agrucoms numeric(1,0)
        * Legado: opt_agrucoms (top=351,left=258,width=164,height=25) + Say6 (top=355,left=145)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Agrupar Comiss" + CHR(227) + "o por :"
            .Top       = 506
            .Left      = 145
            .Width     = 115
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opt_agrucoms", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opt_agrucoms
            .Top         = 502
            .Left        = 258
            .Width       = 169
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_agrucoms.Buttons(1)
            .Caption   = "Linha"
            .Left      = 5
            .Top       = 5
            .Width     = 43
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_agrucoms.Buttons(2)
            .Caption   = "Grupo de Vendas"
            .Left      = 59
            .Top       = 5
            .Width     = 100
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        *----------------------------------------------------------------------
        * Tipo de desconto progressivo - this_nTipoDesconto / tpdesc numeric(2,0)
        * Legado: cmbTpDesc (RowSource=crTpDesc, top=378,left=264,width=221,height=21) + Say11 (top=381,left=107)
        *----------------------------------------------------------------------
        THIS.CriarCursorTipoDesconto()

        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "Tipo de  desconto progressivo :"
            .Top       = 532
            .Left      = 107
            .Width     = 153
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("cbo_4c_CmbTpDesc", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbTpDesc
            .Top            = 529
            .Left           = 264
            .Width          = 221
            .Height         = 21
            .Style          = 2
            .RowSourceType  = 6
            .RowSource      = "cursor_4c_TipoDesconto.Descrs,Ordem"
            .ColumnCount    = 2
            .ColumnWidths   = "205,0"
            .BoundColumn    = 2
            .Value          = 0
            .ToolTipText    = "Usado Para diversas tabelas para um mesmo item"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Visible        = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cbo_4c_CmbTpDesc, "InteractiveChange", THIS, "TipoDescontoInteractiveChange")

        *----------------------------------------------------------------------
        * Container1 / GrdEmp - Lista de empresas para tipo de desconto 11
        * (Desconto Gerente-Extra/loja) - this_cListaEmpresas / listaemp memo
        * Legado: Container1 (top=354,left=608,width=289,height=97), visivel apenas
        * quando cmbTpDesc = 11 (ThisForm...container1.visible = tpdesc=11)
        *----------------------------------------------------------------------
        LOCAL loc_oGridEmp

        loc_oPagina.AddObject("cnt_4c_Container1", "Container")
        WITH loc_oPagina.cnt_4c_Container1
            .Top       = 505
            .Left      = 608
            .Width     = 289
            .Height    = 97
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        loc_oPagina.cnt_4c_Container1.AddObject("grd_4c_Empresas", "Grid")
        loc_oGridEmp = loc_oPagina.cnt_4c_Container1.grd_4c_Empresas
        loc_oGridEmp.RecordSource = ""
        loc_oGridEmp.ColumnCount  = 2
        WITH loc_oGridEmp
            .Top          = 3
            .Left         = 6
            .Width        = 228
            .Height       = 90
            .FontName     = "Verdana"
            .FontSize     = 8
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .GridLines    = 3
            .HeaderHeight = 0
            .RowHeight    = 18
            .ScrollBars   = 2
            .Visible      = .T.
        ENDWITH

        WITH loc_oGridEmp.Column1
            .Width    = 30
            .Sparse   = .F.
            .ReadOnly = .F.
        ENDWITH
        loc_oGridEmp.Column1.Header1.Caption = ""
        loc_oGridEmp.Column1.AddObject("chk_4c_Marca", "CheckBox")
        WITH loc_oGridEmp.Column1.chk_4c_Marca
            .Caption   = ""
            .Alignment = 0
            .Visible   = .T.
            .Top       = 2
            .Left      = 6
            .Height    = 17
            .Width     = 18
        ENDWITH
        loc_oGridEmp.Column1.CurrentControl = "chk_4c_Marca"

        WITH loc_oGridEmp.Column2
            .Width    = 190
            .ReadOnly = .T.
        ENDWITH
        loc_oGridEmp.Column2.Header1.Caption = "Empresa"

        BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "MouseDown", THIS, "EmpresaCheckboxMouseDown")
        BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "MouseUp",   THIS, "EmpresaCheckboxMouseUp")
        BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "Click",     THIS, "EmpresaCheckboxClick")
        BINDEVENT(loc_oGridEmp.Column1.chk_4c_Marca, "KeyPress",  THIS, "EmpresaCheckboxKeyPress")

        loc_oPagina.cnt_4c_Container1.AddObject("cmd_4c_Command1", "CommandButton")
        WITH loc_oPagina.cnt_4c_Container1.cmd_4c_Command1
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Desmarcar"
            .Top         = 48
            .Left        = 239
            .Width       = 45
            .Height      = 45
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(36, 84, 155)
            .FontName    = "Verdana"
            .FontSize    = 8
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Container1.cmd_4c_Command1, "Click", THIS, "BtnEmpresasDesmarcarClick")

        loc_oPagina.cnt_4c_Container1.AddObject("cmd_4c_Command2", "CommandButton")
        WITH loc_oPagina.cnt_4c_Container1.cmd_4c_Command2
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .ToolTipText = "Selecionar"
            .Top         = 4
            .Left        = 239
            .Width       = 45
            .Height      = 45
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(36, 84, 155)
            .FontName    = "Verdana"
            .FontSize    = 8
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Container1.cmd_4c_Command2, "Click", THIS, "BtnEmpresasMarcarClick")

        *----------------------------------------------------------------------
        * pgDesconto / PgConfDesconto (2a/3a sub-paginas do PageFrame interno
        * do legado) - migradas como containers flutuantes sobre a mesma
        * Page2 (mesmo padrao de cnt_4c_Container1), pois pgDados ja ocupa a
        * Page2 sem PageFrame interno. Ocultas por padrao ate existir
        * alternancia de sub-abas (nao ha selecao de sub-pagina no legado -
        * as 3 ficam sempre visiveis simultaneamente dentro do PageFrame
        * interno "Page1"; aqui mantemos apenas pgDados visivel de inicio
        * e as demais ocultas ate um mecanismo de troca ser adicionado).
        *----------------------------------------------------------------------
        THIS.ConfigurarPgPgDesconto()
        THIS.ConfigurarPgPgConfDesconto()

        THIS.TornarControlesVisiveis(loc_oPagina)
        loc_oPagina.cnt_4c_Container1.Visible = .F.
        loc_oPagina.cnt_4c_PgDesconto.Visible = .F.
        loc_oPagina.cnt_4c_PgConfDesconto.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgPgConfDesconto - Controles da 3a sub-pagina do legado
    * ("Configuracao de Desconto" - SIGCDTBV.Pagina.Dados.Page1.PgConfDesconto)
    *
    * Grade mestre (grd_4c_GradeI) espelha as linhas de SigOpTdt (tipo/codigo/
    * tipo de desconto progressivo) cadastradas via grd_4c_Gradei da aba
    * "Descontos / Comissoes" (ConfigurarPgPgDesconto - MESMA cursor_4c_Tdt).
    * Colunas Tipo/Codigo sao SOMENTE LEITURA aqui (legado: Column1/2.When
    * sempre Return(.f.)); apenas a coluna "Tipos Desconto" e editavel.
    *
    * Grade de detalhe (grd_4c_GradeD) mostra/edita as faixas (SigOpTds) da
    * combinacao tipo+codigo+tipoDesconto selecionada na grade mestre,
    * reconfigurando colunas conforme MontarConfiguracaoDesconto() (equiva-
    * lente ao "MontaTbDes" do legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgPgConfDesconto()
        LOCAL loc_oPg, loc_oGradei, loc_oGradeD

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        *-- Registros excluidos da grade de faixas (BtnExcluirFaixaDescontoClick)
        *-- nao devem reaparecer - DataSession=2 (privado) isola este SET do
        *-- resto do sistema (CLAUDE.md #9.4)
        SET DELETED ON

        THIS.CriarCursorDiaSemana()

        *-- grd_4c_GradeD.Column3/4/5/6 (abaixo) recebem .ControlSource
        *-- apontando para cursor_4c_Tds AGORA, no Init do form - igual ao
        *-- caso de cursor_4c_Tdt (ver CriarCursorTdtVazio): coluna de Grid
        *-- resolve o alias do ControlSource na hora da atribuicao, nao so
        *-- quando o Grid.RecordSource e setado. Sem o cursor existir aqui,
        *-- estora "Alias 'CURSOR_4C_TDS' is not found." Populado de verdade
        *-- em TbvBO.CarregarFaixasDesconto() (via CarregarConfiguracaoDesconto),
        *-- que fecha e recria este cursor com os dados reais (mesmo alias).
        THIS.CriarCursorTdsVazio()

        loc_oPg.AddObject("cnt_4c_PgConfDesconto", "Container")
        WITH loc_oPg.cnt_4c_PgConfDesconto
            .Top       = 151
            .Left      = -1
            .Width     = 1004
            .Height    = 482
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Rotulos de cabecalho das colunas (Label1/Label2/lb_desconto)
        *----------------------------------------------------------------------
        loc_oPg.cnt_4c_PgConfDesconto.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.cnt_4c_PgConfDesconto.lbl_4c_Label1
            .Caption    = "Hor" + CHR(225) + "rio"
            .Top        = 11
            .Left       = 622
            .Width      = 83
            .Height     = 16
            .Alignment  = 2
            .BackStyle  = 1
            .BorderStyle = 1
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(240, 240, 240)
            .Visible    = .T.
        ENDWITH

        loc_oPg.cnt_4c_PgConfDesconto.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.cnt_4c_PgConfDesconto.lbl_4c_Label2
            .Caption    = "Desconto"
            .Top        = 11
            .Left       = 704
            .Width      = 98
            .Height     = 16
            .Alignment  = 2
            .BackStyle  = 1
            .BorderStyle = 1
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(240, 240, 240)
            .Visible    = .T.
        ENDWITH

        loc_oPg.cnt_4c_PgConfDesconto.AddObject("lbl_4c_Lb_desconto", "Label")
        WITH loc_oPg.cnt_4c_PgConfDesconto.lbl_4c_Lb_desconto
            .Caption    = "Tipo de Desconto"
            .Top        = 11
            .Left       = 462
            .Width      = 161
            .Height     = 16
            .Alignment  = 2
            .BackStyle  = 1
            .BorderStyle = 1
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(240, 240, 240)
            .Visible    = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * grd_4c_GradeI - grade mestre (espelha SigOpTdt), Tipo/Codigo
        * somente leitura, Tipos Desconto editavel (dispara reconfiguracao
        * da grade de faixas)
        *----------------------------------------------------------------------
        loc_oPg.cnt_4c_PgConfDesconto.AddObject("grd_4c_GradeI", "Grid")
        loc_oGradei = loc_oPg.cnt_4c_PgConfDesconto.grd_4c_GradeI
        loc_oGradei.RecordSource = ""
        loc_oGradei.ColumnCount  = 3
        WITH loc_oGradei
            .Top       = 10
            .Left      = 122
            .Width     = 314
            .Height    = 439
            .FontName  = "Verdana"
            .FontSize  = 8
            .RowHeight = 20
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        WITH loc_oGradei.Column1
            .Width              = 80
            .Header1.Caption    = "Tipo"
            .Header1.Alignment  = 2
            .Header1.FontName   = "Verdana"
            .Header1.FontSize   = 8
            .ReadOnly           = .T.
        ENDWITH
        loc_oGradei.Column1.AddObject("cbo_4c_GiTipo", "ComboBox")
        WITH loc_oGradei.Column1.cbo_4c_GiTipo
            .Top             = 27
            .Left            = 4
            .SpecialEffect   = 1
            .RowSourceType   = 1
            .RowSource       = "Grupo,Linha,Gr Venda,Produto,Moeda,Unidade,Feitio,SubGrupo,Finalidade"
            .Style           = 2
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .ItemBackColor   = RGB(255, 255, 128)
        ENDWITH
        loc_oGradei.Column1.CurrentControl = "cbo_4c_GiTipo"

        WITH loc_oGradei.Column2
            .Width              = 80
            .Header1.Caption    = "C" + CHR(243) + "digo "
            .Header1.Alignment  = 2
            .Header1.FontName   = "Verdana"
            .Header1.FontSize   = 8
            .Text1.BorderStyle  = 0
            .Text1.Margin       = 2
            .Text1.ForeColor    = RGB(36, 84, 155)
            .Text1.BackColor    = RGB(255, 255, 255)
            .ReadOnly           = .T.
        ENDWITH

        WITH loc_oGradei.Column3
            .Width              = 121
            .Header1.Caption    = "Tipos Desconto"
            .Header1.Alignment  = 2
            .Header1.FontName   = "Verdana"
            .Header1.FontSize   = 8
        ENDWITH
        loc_oGradei.Column3.AddObject("cbo_4c_GiTipoDs", "ComboBox")
        WITH loc_oGradei.Column3.cbo_4c_GiTipoDs
            .Top             = 30
            .Left            = 15
            .SpecialEffect   = 1
            .RowSourceType   = 1
            .RowSource       = "Nenhum,Dia da Semana,Dia do Mes,Hor" + CHR(225) + "rio,Data"
            .Style           = 2
            .ForeColor       = RGB(36, 84, 155)
            .ItemBackColor   = RGB(255, 255, 128)
        ENDWITH
        loc_oGradei.Column3.CurrentControl = "cbo_4c_GiTipoDs"

        BINDEVENT(loc_oGradei, "AfterRowColChange", THIS, "GradeiConfAfterRowColChange")
        BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "When", THIS, "GradeiConfColumn3When")
        BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "LostFocus", THIS, "GradeiConfColumn3Valid")
        BINDEVENT(loc_oGradei.Column3.cbo_4c_GiTipoDs, "KeyPress", THIS, "GradeiConfColumn3LostFocus")

        *----------------------------------------------------------------------
        * grd_4c_GradeD - grade de detalhe (espelha SigOpTds da combinacao
        * selecionada em grd_4c_GradeI). Colunas 1/2 (Inicial/Final) tem
        * ControlSource/InputMask reconfigurados dinamicamente por
        * MontarConfiguracaoDesconto() conforme o Tipo de Desconto (dia da
        * semana/dia do mes/horario/data). Colunas 3/4 sao a faixa de
        * horario dentro do dia (sempre Campo2is/Campo2fs); 5/6 sao
        * Preco/Fator.
        *----------------------------------------------------------------------
        loc_oPg.cnt_4c_PgConfDesconto.AddObject("grd_4c_GradeD", "Grid")
        loc_oGradeD = loc_oPg.cnt_4c_PgConfDesconto.grd_4c_GradeD
        loc_oGradeD.RecordSource = ""
        loc_oGradeD.ColumnCount  = 6
        WITH loc_oGradeD
            .Top        = 26
            .Left       = 462
            .Width      = 358
            .Height     = 419
            .FontName   = "Verdana"
            .FontSize   = 8
            .RowHeight  = 20
            .RecordMark = .F.
            .ForeColor  = RGB(36, 84, 155)
            .Enabled    = .F.
            .Visible    = .T.
        ENDWITH

        WITH loc_oGradeD.Column1
            .Width             = 79
            .Header1.Caption   = "Inicial"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Text1.Top         = 32
            .Text1.Height      = 23
            .Text1.Margin      = 2
            .Text1.ForeColor   = RGB(36, 84, 155)
        ENDWITH
        BINDEVENT(loc_oGradeD.Column1.Text1, "When", THIS, "GradeDColumn1When")
        BINDEVENT(loc_oGradeD.Column1.Text1, "Valid", THIS, "GradeDColumn1Valid")

        WITH loc_oGradeD.Column2
            .Width             = 79
            .Header1.Caption   = "Final"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 2
            .Text1.ForeColor   = RGB(36, 84, 155)
        ENDWITH
        BINDEVENT(loc_oGradeD.Column2.Text1, "When", THIS, "GradeDColumn2When")
        BINDEVENT(loc_oGradeD.Column2.Text1, "Valid", THIS, "GradeDColumn2Valid")

        WITH loc_oGradeD.Column3
            .Width             = 40
            .Header1.Caption   = "Inicial"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .ControlSource     = "cursor_4c_Tds.Campo2is"
            .Format            = "R"
            .InputMask         = "99:99"
            .Text1.InputMask   = "99:99"
        ENDWITH
        BINDEVENT(loc_oGradeD.Column3.Text1, "When", THIS, "GradeDColumn3When")
        BINDEVENT(loc_oGradeD.Column3.Text1, "Valid", THIS, "GradeDColumn3Valid")

        WITH loc_oGradeD.Column4
            .Width             = 40
            .Header1.Caption   = "Final"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .ControlSource     = "cursor_4c_Tds.Campo2fs"
            .Format            = "R"
            .InputMask         = "99:99"
            .Text1.InputMask   = "99:99"
        ENDWITH
        BINDEVENT(loc_oGradeD.Column4.Text1, "When", THIS, "GradeDColumn4When")
        BINDEVENT(loc_oGradeD.Column4.Text1, "Valid", THIS, "GradeDColumn4Valid")

        WITH loc_oGradeD.Column5
            .Width             = 48
            .Header1.Caption   = "Pre" + CHR(231) + "o"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .ControlSource     = "cursor_4c_Tds.descos"
            .InputMask         = "999.99"
            .Text1.InputMask   = "999.99"
        ENDWITH
        BINDEVENT(loc_oGradeD.Column5.Text1, "When", THIS, "GradeDColumn5When")

        WITH loc_oGradeD.Column6
            .Width             = 46
            .Header1.Caption   = "Fator"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .ControlSource     = "cursor_4c_Tds.dfators"
            .InputMask         = "999.99"
            .Text1.InputMask   = "999.99"
        ENDWITH
        BINDEVENT(loc_oGradeD.Column6.Text1, "When", THIS, "GradeDColumn5When")
        BINDEVENT(loc_oGradeD.Column6.Text1, "Valid", THIS, "GradeDColumn6Valid")

        *----------------------------------------------------------------------
        * cmdExcluir - remove a faixa corrente de grd_4c_GradeD
        *----------------------------------------------------------------------
        loc_oPg.cnt_4c_PgConfDesconto.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH loc_oPg.cnt_4c_PgConfDesconto.cmd_4c_CmdExcluir
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText     = "Excluir"
            .PicturePosition = 1
            .Top             = 203
            .Left            = 832
            .Width           = 45
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .FontName        = "Verdana"
            .FontSize        = 8
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_PgConfDesconto.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirFaixaDescontoClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgPgDesconto - Controles da 2a sub-pagina do legado
    * ("Descontos / Comissoes" - SIGCDTBV.Pagina.Dados.Page1.pgDesconto)
    *
    * grd_4c_Gradei (8 colunas) e a grade MESTRE editavel de composicao/
    * formula (SigOpTdt via cursor_4c_Tdt) - inclui/altera/exclui linhas
    * (Tipo/Codigo/Valor/Fator/Exclui/Faixa/Inicial/Final). E a MESMA
    * cursor_4c_Tdt usada (somente leitura) por grd_4c_GradeI da pagina
    * "Configuracao de Desconto" (ConfigurarPgPgConfDesconto).
    *
    * grd_4c_Gradec (6 colunas) mostra as comissoes por grupo/conta
    * (SigOpTdi via cursor_4c_Tdi) da linha corrente de grd_4c_Gradei
    * (filtro local via MontarComissoesDesconto - equivalente ao
    * "MontaTbCom" do legado).
    *
    * cnt_4c_Formula1/cnt_4c_Formula2 mostram a 1a/2a formula de calculo
    * (Campo/Operador/Constante/Moeda) da linha corrente de grd_4c_Gradei,
    * bindados diretamente via ControlSource a cursor_4c_Tdt (mesmo padrao
    * usado pelas colunas de grd_4c_GradeD em ConfigurarPgPgConfDesconto).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgPgDesconto()
        LOCAL loc_oPg, loc_oCnt, loc_oGradei, loc_oGradec, loc_oF1, loc_oF2

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.AddObject("cnt_4c_PgDesconto", "Container")
        loc_oCnt = loc_oPg.cnt_4c_PgDesconto
        WITH loc_oCnt
            .Top       = 151
            .Left      = -1
            .Width     = 1004
            .Height    = 482
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label2 - cabecalho "Descontos" (acima de grd_4c_Gradei)
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Descontos", "Label")
        WITH loc_oCnt.lbl_4c_Descontos
            .Caption   = "Descontos"
            .Top       = 2
            .Left      = 4
            .Width     = 59
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .WordWrap  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * grd_4c_Gradei - grade MESTRE editavel de composicao (cursor_4c_Tdt)
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("grd_4c_Gradei", "Grid")
        loc_oGradei = loc_oCnt.grd_4c_Gradei
        loc_oGradei.RecordSource = ""
        loc_oGradei.ColumnCount  = 8
        WITH loc_oGradei
            .Top       = 16
            .Left      = 4
            .Width     = 568
            .Height    = 279
            .FontName  = "Verdana"
            .FontSize  = 8
            .RowHeight = 20
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        WITH loc_oGradei.Column1
            .Width              = 130
            .Header1.Caption    = "Tipo"
            .Header1.Alignment  = 2
            .Header1.FontName   = "Verdana"
            .Header1.FontSize   = 8
        ENDWITH
        loc_oGradei.Column1.AddObject("cbo_4c_GiTipo", "ComboBox")
        WITH loc_oGradei.Column1.cbo_4c_GiTipo
            .Top             = 27
            .Left            = 4
            .SpecialEffect   = 1
            .RowSourceType   = 1
            .RowSource       = "Grupo,Linha,Gr Venda,Produto,Moeda,Unidade,Feitio,SubGrupo,Finalidade"
            .Style           = 2
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
        ENDWITH
        loc_oGradei.Column1.CurrentControl = "cbo_4c_GiTipo"
        BINDEVENT(loc_oGradei.Column1.cbo_4c_GiTipo, "When", THIS, "GradeiDescColunaEditavelWhen")

        WITH loc_oGradei.Column2
            .Width             = 100
            .Header1.Caption   = "C" + CHR(243) + "digo "
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 2
            .Text1.ForeColor   = RGB(36, 84, 155)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(loc_oGradei.Column2.Text1, "When",     THIS, "GradeiDescColunaEditavelWhen")
        BINDEVENT(loc_oGradei.Column2.Text1, "KeyPress",  THIS, "GradeiDescCodigoKeyPress")
        BINDEVENT(loc_oGradei.Column2.Text1, "DblClick",  THIS, "GradeiDescCodigoDblClick")

        WITH loc_oGradei.Column3
            .Width             = 55
            .Header1.Caption   = "Valor"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .InputMask         = "9999.99"
            .Text1.InputMask   = "9999.99"
            .Text1.ForeColor   = RGB(36, 84, 155)
        ENDWITH
        BINDEVENT(loc_oGradei.Column3.Text1, "When", THIS, "GradeiDescColunaEditavelWhen")

        WITH loc_oGradei.Column4
            .Width             = 55
            .Header1.Caption   = "Fator"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .InputMask         = "9999.99"
            .Text1.InputMask   = "9999.99"
            .Text1.ForeColor   = RGB(36, 84, 155)
        ENDWITH
        BINDEVENT(loc_oGradei.Column4.Text1, "When", THIS, "GradeiDescColunaEditavelWhen")

        WITH loc_oGradei.Column5
            .Width             = 17
            .Header1.Caption   = "E"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Header1.ToolTipText = "Exclui - N" + CHR(227) + "o calcula desconto"
            .Text1.ForeColor   = RGB(36, 84, 155)
            .Text1.MaxLength   = 1
        ENDWITH
        BINDEVENT(loc_oGradei.Column5.Text1, "When",  THIS, "GradeiDescColunaEditavelWhen")
        BINDEVENT(loc_oGradei.Column5.Text1, "Valid", THIS, "GradeiDescColumn5Valid")

        WITH loc_oGradei.Column6
            .Width             = 66
            .Header1.Caption   = "Faixa"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
        ENDWITH
        loc_oGradei.Column6.AddObject("cbo_4c_GiFaixa", "ComboBox")
        WITH loc_oGradei.Column6.cbo_4c_GiFaixa
            .Top             = 18
            .Left            = 28
            .SpecialEffect   = 1
            .RowSourceType   = 1
            .RowSource       = "Nenhuma,Qtde,Peso,Tot.Peso"
            .Style           = 2
            .ForeColor       = RGB(36, 84, 155)
        ENDWITH
        loc_oGradei.Column6.CurrentControl = "cbo_4c_GiFaixa"

        WITH loc_oGradei.Column7
            .Width             = 38
            .Header1.Caption   = "Inicial"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Text1.ForeColor   = RGB(0, 0, 0)
        ENDWITH

        WITH loc_oGradei.Column8
            .Width             = 38
            .Header1.Caption   = "Final"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Text1.ForeColor   = RGB(0, 0, 0)
        ENDWITH

        BINDEVENT(loc_oGradei, "AfterRowColChange", THIS, "GradeiDescAfterRowColChange")

        *----------------------------------------------------------------------
        * inserir/excluir - incluem/removem linhas de composicao (cursor_4c_Tdt)
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("cmd_4c_InserirComposicao", "CommandButton")
        WITH loc_oCnt.cmd_4c_InserirComposicao
            .Caption   = ""
            .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .Top       = 296
            .Left      = 5
            .Width     = 40
            .Height    = 40
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(36, 84, 155)
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_InserirComposicao, "Click", THIS, "BtnInserirComposicaoClick")

        loc_oCnt.AddObject("cmd_4c_ExcluirComposicao", "CommandButton")
        WITH loc_oCnt.cmd_4c_ExcluirComposicao
            .Caption   = ""
            .Picture   = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Top       = 296
            .Left      = 45
            .Width     = 40
            .Height    = 40
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(36, 84, 155)
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_ExcluirComposicao, "Click", THIS, "BtnExcluirComposicaoClick")

        *----------------------------------------------------------------------
        * cnt_4c_Formula1 / cnt_4c_Formula2 - 1a/2a formula de calculo
        * (Campo/Operador/Constante/Moeda), bindadas a cursor_4c_Tdt.*t1s/*t2s
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("cnt_4c_Formula1", "Container")
        loc_oF1 = loc_oCnt.cnt_4c_Formula1
        WITH loc_oF1
            .Top         = 365
            .Left        = 27
            .Width       = 945
            .Height      = 37
            .BackStyle   = 0
            .SpecialEffect = 2
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH
        THIS.ConfigurarFormulaDesconto(loc_oF1, "t1s", "Primeira F" + CHR(243) + "rmula :")

        loc_oCnt.AddObject("cnt_4c_Formula2", "Container")
        loc_oF2 = loc_oCnt.cnt_4c_Formula2
        WITH loc_oF2
            .Top         = 415
            .Left        = 27
            .Width       = 945
            .Height      = 37
            .BackStyle   = 0
            .SpecialEffect = 2
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH
        THIS.ConfigurarFormulaDesconto(loc_oF2, "t2s", "Segunda F" + CHR(243) + "rmula :")

        *----------------------------------------------------------------------
        * Desconto Maximo (crSigOpTdz.descmxs - registro principal, NAO a
        * linha corrente de composicao) - this_nDescontoMaximo no BO
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_DescontoMaximo", "Label")
        WITH loc_oCnt.lbl_4c_DescontoMaximo
            .Caption   = "Desconto M" + CHR(225) + "ximo :"
            .Top       = 343
            .Left      = 800
            .Width     = 109
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DescontoMaximo", "TextBox")
        WITH loc_oCnt.txt_4c_DescontoMaximo
            .Top       = 339
            .Left      = 910
            .Width     = 66
            .Height    = 18
            .InputMask = "9999.99"
            .Alignment = 1
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Percentual", "Label")
        WITH loc_oCnt.lbl_4c_Percentual
            .Caption   = "%"
            .Top       = 343
            .Left      = 981
            .Width     = 15
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * lbl_4c_Comissoes - cabecalho "Comissoes" (acima de grd_4c_Gradec)
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Comissoes", "Label")
        WITH loc_oCnt.lbl_4c_Comissoes
            .Caption   = "Comiss" + CHR(245) + "es"
            .Top       = 2
            .Left      = 575
            .Width     = 60
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * grd_4c_Gradec - comissoes por grupo/conta da linha corrente de
        * grd_4c_Gradei (cursor_4c_Tdi filtrado localmente)
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("grd_4c_Gradec", "Grid")
        loc_oGradec = loc_oCnt.grd_4c_Gradec
        loc_oGradec.RecordSource = ""
        loc_oGradec.ColumnCount  = 6
        WITH loc_oGradec
            .Top       = 16
            .Left      = 575
            .Width     = 422
            .Height    = 279
            .FontName  = "Verdana"
            .FontSize  = 8
            .RowHeight = 20
            .RecordMark = .F.
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        WITH loc_oGradec.Column1
            .Width             = 100
            .Header1.Caption   = "Grupo"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Text1.ForeColor   = RGB(0, 0, 0)
        ENDWITH
        BINDEVENT(loc_oGradec.Column1.Text1, "Valid", THIS, "GradecColumn1Valid")

        WITH loc_oGradec.Column2
            .Width             = 100
            .Header1.Caption   = "Conta"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .InputMask         = "XXXXXXXXXX"
            .Text1.InputMask   = "XXXXXXXXXX"
            .Text1.ForeColor   = RGB(0, 0, 0)
        ENDWITH
        BINDEVENT(loc_oGradec.Column2.Text1, "Valid", THIS, "GradecColumn2Valid")

        WITH loc_oGradec.Column3
            .Width             = 55
            .Header1.Caption   = "Integral"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .InputMask         = "999.99"
            .Text1.InputMask   = "999.99"
            .Text1.ForeColor   = RGB(0, 0, 0)
        ENDWITH

        WITH loc_oGradec.Column4
            .Width             = 55
            .Header1.Caption   = "Dividida"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .InputMask         = "999.99"
            .Text1.InputMask   = "999.99"
            .Text1.ForeColor   = RGB(0, 0, 0)
        ENDWITH

        WITH loc_oGradec.Column5
            .Width             = 55
            .Header1.Caption   = "Atendim"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .InputMask         = "999.99"
            .Text1.InputMask   = "999.99"
            .Text1.ForeColor   = RGB(0, 0, 0)
        ENDWITH

        WITH loc_oGradec.Column6
            .Width             = 30
            .Header1.Caption   = "Moe"
            .Header1.Alignment = 2
            .Header1.FontName  = "Verdana"
            .Header1.FontSize  = 8
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *----------------------------------------------------------------------
        * Inscomis/exccomis - incluem/removem comissoes (cursor_4c_Tdi)
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("cmd_4c_InserirComissao", "CommandButton")
        WITH loc_oCnt.cmd_4c_InserirComissao
            .Caption   = ""
            .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .Top       = 296
            .Left      = 577
            .Width     = 40
            .Height    = 40
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(36, 84, 155)
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_InserirComissao, "Click", THIS, "BtnInserirComissaoClick")

        loc_oCnt.AddObject("cmd_4c_ExcluirComissao", "CommandButton")
        WITH loc_oCnt.cmd_4c_ExcluirComissao
            .Caption   = ""
            .Picture   = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Top       = 296
            .Left      = 617
            .Width     = 40
            .Height    = 40
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(36, 84, 155)
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_ExcluirComissao, "Click", THIS, "BtnExcluirComissaoClick")

        *----------------------------------------------------------------------
        * Combo_Comis / getDescFats / getFatorPads / chkAplicado(Ignora
        * cotacao) - bindados a cursor_4c_Tdt.* (linha corrente de composicao)
        *----------------------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Comissao", "Label")
        WITH loc_oCnt.lbl_4c_Comissao
            .Caption   = "Comiss" + CHR(227) + "o:"
            .Top       = 342
            .Left      = 555
            .Width     = 59
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("cbo_4c_ComboComis", "ComboBox")
        WITH loc_oCnt.cbo_4c_ComboComis
            .Top            = 338
            .Left           = 617
            .Width          = 161
            .Height         = 23
            .Style          = 2
            .RowSourceType  = 1
            .RowSource      = "Normal,Pelo Custo,Pelo Feitio"
            .ControlSource  = "cursor_4c_Tdt.tpcomis"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Visible        = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_DescritivoFator", "Label")
        WITH loc_oCnt.lbl_4c_DescritivoFator
            .Caption   = "Descritivo de Fator :"
            .Top       = 342
            .Left      = 20
            .Width     = 115
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DescFats", "TextBox")
        WITH loc_oCnt.txt_4c_DescFats
            .Top           = 338
            .Left          = 145
            .Width         = 80
            .Height        = 18
            .MaxLength     = 10
            .ControlSource = "cursor_4c_Tdt.descfats"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_FatorPadrao", "Label")
        WITH loc_oCnt.lbl_4c_FatorPadrao
            .Caption   = "Fator Padr" + CHR(227) + "o :"
            .Top       = 341
            .Left      = 270
            .Width     = 81
            .Height    = 15
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_FatorPads", "TextBox")
        WITH loc_oCnt.txt_4c_FatorPads
            .Top           = 338
            .Left          = 352
            .Width         = 66
            .Height        = 23
            .InputMask     = "9999.999"
            .Alignment     = 1
            .ControlSource = "cursor_4c_Tdt.fatorpads"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_IgnoraCotacao", "CheckBox")
        WITH loc_oCnt.chk_4c_IgnoraCotacao
            .Caption       = "Ignora cota" + CHR(231) + CHR(227) + "o"
            .Top           = 401
            .Left          = 836
            .Width         = 105
            .Height        = 15
            .Alignment     = 0
            .BackStyle     = 0
            .ControlSource = "cursor_4c_Tdt.chkcots"
            .ToolTipText   = "Faz os c" + CHR(225) + "lculos sem usar a cota" + CHR(231) + CHR(227) + "o da moeda"
            .FontName      = "Verdana"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oCnt)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFormulaDesconto - Cria os controles de uma formula (1a/2a)
    * dentro do container informado, bindados a cursor_4c_Tdt.*<sufixo>
    * (sufixo "t1s" ou "t2s"). Espelha o container F?rmula1/F?rmula2 do
    * legado: Campo1/Oper1/Campo2/Oper2/Campo3/Const1/Const2/Const3/Moeda.
    * Visible dos campos 2/3 (encadeados) e recalculado dinamicamente pelo
    * legado via Refresh(); aqui simplificado para SEMPRE visivel (o
    * usuario ve os 3 campos da formula e preenche os que precisar).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFormulaDesconto(par_oCnt, par_cSufixo, par_cLabel)
        WITH par_oCnt
            .AddObject("lbl_4c_TituloFormula", "Label")
            WITH .lbl_4c_TituloFormula
                .Caption   = par_cLabel
                .Top       = 12
                .Left      = 14
                .Width     = 106
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            .AddObject("cbo_4c_Campo1", "ComboBox")
            WITH .cbo_4c_Campo1
                .Top           = 7
                .Left          = 145
                .Width         = 127
                .Height        = 24
                .Style         = 2
                .SpecialEffect = 1
                .RowSourceType = 1
                .RowSource     = "Nenhum,Peso,Fator,Pre" + CHR(231) + "o,Constante,Quantidade,Comprimento"
                .ControlSource = "cursor_4c_Tdt.campo1" + par_cSufixo
                .BackColor     = RGB(220, 211, 194)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Visible       = .T.
            ENDWITH

            .AddObject("cbo_4c_Oper1", "ComboBox")
            WITH .cbo_4c_Oper1
                .Top           = 7
                .Left          = 283
                .Width         = 39
                .Height        = 24
                .Style         = 2
                .SpecialEffect = 1
                .RowSourceType = 1
                .RowSource     = ",+,-," + CHR(215) + "," + CHR(247)
                .ControlSource = "cursor_4c_Tdt.oper1" + par_cSufixo
                .BackColor     = RGB(253, 250, 185)
                .FontName      = "Tahoma"
                .FontSize      = 12
                .FontBold      = .T.
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Const1", "TextBox")
            WITH .txt_4c_Const1
                .Top           = 7
                .Left          = 236
                .Width         = 36
                .Height        = 24
                .MaxLength     = 3
                .ControlSource = "cursor_4c_Tdt.const1" + par_cSufixo
                .BackColor     = RGB(202, 255, 224)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Visible       = .T.
            ENDWITH

            .AddObject("cbo_4c_Campo2", "ComboBox")
            WITH .cbo_4c_Campo2
                .Top           = 7
                .Left          = 330
                .Width         = 127
                .Height        = 24
                .Style         = 2
                .SpecialEffect = 1
                .RowSourceType = 1
                .RowSource     = "Nenhum,Peso,Fator,Pre" + CHR(231) + "o,Constante,Quantidade,Comprimento"
                .ControlSource = "cursor_4c_Tdt.campo2" + par_cSufixo
                .BackColor     = RGB(220, 211, 194)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Visible       = .T.
            ENDWITH

            .AddObject("cbo_4c_Oper2", "ComboBox")
            WITH .cbo_4c_Oper2
                .Top           = 7
                .Left          = 468
                .Width         = 39
                .Height        = 24
                .Style         = 2
                .SpecialEffect = 1
                .RowSourceType = 1
                .RowSource     = ",+,-," + CHR(215) + "," + CHR(247)
                .ControlSource = "cursor_4c_Tdt.oper2" + par_cSufixo
                .BackColor     = RGB(253, 250, 185)
                .FontName      = "Tahoma"
                .FontSize      = 12
                .FontBold      = .T.
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Const2", "TextBox")
            WITH .txt_4c_Const2
                .Top           = 7
                .Left          = 421
                .Width         = 36
                .Height        = 24
                .MaxLength     = 3
                .ControlSource = "cursor_4c_Tdt.const2" + par_cSufixo
                .BackColor     = RGB(202, 255, 224)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Visible       = .T.
            ENDWITH

            .AddObject("cbo_4c_Campo3", "ComboBox")
            WITH .cbo_4c_Campo3
                .Top           = 7
                .Left          = 517
                .Width         = 127
                .Height        = 24
                .Style         = 2
                .SpecialEffect = 1
                .RowSourceType = 1
                .RowSource     = "Nenhum,Peso,Fator,Pre" + CHR(231) + "o,Constante,Quantidade,Comprimento"
                .ControlSource = "cursor_4c_Tdt.campo3" + par_cSufixo
                .BackColor     = RGB(220, 211, 194)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Visible       = .T.
            ENDWITH

            .AddObject("txt_4c_Const3", "TextBox")
            WITH .txt_4c_Const3
                .Top           = 7
                .Left          = 608
                .Width         = 36
                .Height        = 24
                .MaxLength     = 3
                .ControlSource = "cursor_4c_Tdt.const3" + par_cSufixo
                .BackColor     = RGB(202, 255, 224)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_MoedaConversao", "Label")
            WITH .lbl_4c_MoedaConversao
                .Caption   = "Moeda de Convers" + CHR(227) + "o :"
                .Top       = 12
                .Left      = 662
                .Width     = 126
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Moeda", "TextBox")
            WITH .txt_4c_Moeda
                .Top           = 7
                .Left          = 809
                .Width         = 40
                .Height        = 24
                .MaxLength     = 3
                .ControlSource = "cursor_4c_Tdt.moeda" + IIF(par_cSufixo = "t1s", "1s", "2s")
                .BackColor     = RGB(207, 241, 241)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do Form para Business Object
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oPg

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_cCodigo         = ALLTRIM(loc_oPg.txt_4c__codigos.Value)
            .this_cDescricao      = ALLTRIM(loc_oPg.txt_4c__descrs.Value)
            .this_cMoeRef         = ALLTRIM(loc_oPg.txt_4c__moerefs.Value)
            .this_nDesconto       = loc_oPg.txt_4c__descos.Value
            .this_cObservacao     = ALLTRIM(loc_oPg.txt_4c__obss.Value)
            .this_nRelDesconto    = loc_oPg.obj_4c_Opt_rel_descs.Value
            .this_dDataTermino    = loc_oPg.txt_4c_Dtval.Value
            .this_nPrazoMedio     = loc_oPg.txt_4c_PrazoMs.Value
            .this_nChkAcesso      = loc_oPg.obj_4c_Chk_Acesso.Value
            .this_nChkRetorno     = IIF(loc_oPg.chk_4c_ChkAplicado.Value = 1, 1, 0)
            .this_nAjuste         = loc_oPg.txt_4c_Ajuste.Value
            .this_nFator          = loc_oPg.txt_4c_Fator.Value
            .this_cMoedaFator     = ALLTRIM(loc_oPg.txt_4c_MoeFat.Value)
            .this_nAbateCusto     = loc_oPg.obj_4c_OptAbateCus.Value
            .this_nAgrupaComissao = loc_oPg.obj_4c_Opt_agrucoms.Value
            .this_nParcelas       = loc_oPg.txt_4c_NParcs.Value
            .this_nParcelas2      = loc_oPg.txt_4c_NParc2s.Value
            .this_nTipoDesconto   = loc_oPg.cbo_4c_CmbTpDesc.Value
            .this_cListaEmpresas  = THIS.MontarListaEmpresas()
            .this_nDescontoMaximo = loc_oPg.cnt_4c_PgDesconto.txt_4c_DescontoMaximo.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object para Form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPg

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPg.txt_4c__codigos.Value       = .this_cCodigo
            loc_oPg.txt_4c__descrs.Value        = .this_cDescricao
            loc_oPg.txt_4c__moerefs.Value       = .this_cMoeRef
            loc_oPg.txt_4c__moerefs_desc.Value  = THIS.this_oBusinessObject.ObterDescricaoMoeda(.this_cMoeRef)
            loc_oPg.txt_4c__descos.Value        = .this_nDesconto
            loc_oPg.txt_4c__obss.Value          = .this_cObservacao
            *-- Legado forca Rel_Descs=2 (Nao) em registro novo (INSERIR/PROCURAR)
            loc_oPg.obj_4c_Opt_rel_descs.Value  = IIF(.this_nRelDesconto = 0, 2, .this_nRelDesconto)
            loc_oPg.txt_4c_Dtval.Value          = .this_dDataTermino
            loc_oPg.txt_4c_PrazoMs.Value        = .this_nPrazoMedio
            loc_oPg.obj_4c_Chk_Acesso.Value     = .this_nChkAcesso
            loc_oPg.chk_4c_ChkAplicado.Value    = (.this_nChkRetorno .Value    = IIF(.this_nChkRetorno = 1, 1, 0))
            loc_oPg.txt_4c_Ajuste.Value         = .this_nAjuste
            loc_oPg.txt_4c_Fator.Value          = .this_nFator
            loc_oPg.txt_4c_MoeFat.Value         = .this_cMoedaFator
            loc_oPg.obj_4c_OptAbateCus.Value    = IIF(.this_nAbateCusto = 0, 2, .this_nAbateCusto)
            loc_oPg.obj_4c_Opt_agrucoms.Value   = IIF(.this_nAgrupaComissao = 0, 1, .this_nAgrupaComissao)
            loc_oPg.txt_4c_NParcs.Value         = .this_nParcelas
            loc_oPg.txt_4c_NParc2s.Value        = .this_nParcelas2
            loc_oPg.cbo_4c_CmbTpDesc.Value      = .this_nTipoDesconto
            loc_oPg.cnt_4c_PgDesconto.txt_4c_DescontoMaximo.Value = .this_nDescontoMaximo
        ENDWITH

        THIS.CarregarGradeEmpresas()

        *-- Container de empresas so aparece para o tipo de desconto 11
        *-- (Desconto Gerente-Extra/loja), igual ao legado
        loc_oPg.cnt_4c_Container1.Visible = (loc_oPg.cbo_4c_CmbTpDesc.Value = 11)

        *-- Pagina "Configuracao de Desconto" (grades de composicao/faixas)
        THIS.CarregarConfiguracaoDesconto()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2 para novo registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c__codigos.Value      = ""
            loc_oPg2.txt_4c__descrs.Value       = ""
            loc_oPg2.txt_4c__moerefs.Value      = ""
            loc_oPg2.txt_4c__moerefs_desc.Value = ""
            loc_oPg2.txt_4c__descos.Value       = 0
            loc_oPg2.txt_4c__obss.Value         = ""
            *-- Legado forca Rel_Descs=2 (Nao) em registro novo (INSERIR/PROCURAR)
            loc_oPg2.obj_4c_Opt_rel_descs.Value = 2
            loc_oPg2.txt_4c_Dtval.Value         = {}
            loc_oPg2.txt_4c_PrazoMs.Value       = 0
            loc_oPg2.obj_4c_Chk_Acesso.Value    = 1
            loc_oPg2.chk_4c_ChkAplicado.Value   = 0
            loc_oPg2.txt_4c_Ajuste.Value        = 0
            loc_oPg2.txt_4c_Fator.Value         = 0
            loc_oPg2.txt_4c_MoeFat.Value        = ""
            loc_oPg2.obj_4c_OptAbateCus.Value   = 2
            loc_oPg2.obj_4c_Opt_agrucoms.Value  = 1
            loc_oPg2.txt_4c_NParcs.Value        = 0
            loc_oPg2.txt_4c_NParc2s.Value       = 0
            loc_oPg2.cbo_4c_CmbTpDesc.Value     = 0
            loc_oPg2.cnt_4c_PgDesconto.txt_4c_DescontoMaximo.Value = 0

            *-- Container de empresas: comeca oculto ate o usuario escolher tipo 11
            loc_oPg2.cnt_4c_Container1.Visible  = .F.
            IF USED("cursor_4c_Empresas")
                SELECT cursor_4c_Empresas
                REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
                GO TOP IN cursor_4c_Empresas
            ENDIF

            *-- Registro novo (INCLUIR) ainda nao tem composicao/comissoes/
            *-- faixas de desconto cadastradas. cursor_4c_Tdt NAO pode ser
            *-- fechado (USE IN) aqui: cnt_4c_Formula1/2, cbo_4c_ComboComis,
            *-- txt_4c_DescFats, txt_4c_FatorPads e chk_4c_IgnoraCotacao ficam
            *-- com ControlSource apontando pra ele - fechar o alias quebraria
            *-- esses controles (mesma causa do Erro corrigido em
            *-- CriarCursorTdtVazio). Apenas ZAP para esvaziar mantendo o
            *-- cursor aberto e a estrutura intacta.
            IF USED("cursor_4c_Tdt")
                SELECT cursor_4c_Tdt
                ZAP
            ENDIF
            IF USED("cursor_4c_Tdi")
                USE IN cursor_4c_Tdi
            ENDIF
            IF USED("cursor_4c_Tds")
                USE IN cursor_4c_Tds
            ENDIF
            THIS.CarregarConfiguracaoDesconto()
        CATCH TO loException
            MostrarErro(loException, "FormTbv.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lCodHabilitar
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Codigo (PK): editavel apenas em INCLUIR ou BUSCAR
            loc_lCodHabilitar = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
            loc_oPg2.txt_4c__codigos.Enabled = loc_lCodHabilitar

            loc_oPg2.txt_4c__descrs.Enabled       = par_lHabilitar
            loc_oPg2.txt_4c__moerefs.Enabled      = par_lHabilitar
            loc_oPg2.txt_4c__descos.Enabled       = par_lHabilitar
            loc_oPg2.txt_4c__obss.Enabled         = par_lHabilitar
            loc_oPg2.obj_4c_Opt_rel_descs.Enabled = par_lHabilitar
            loc_oPg2.txt_4c_Dtval.Enabled         = par_lHabilitar
            loc_oPg2.obj_4c_Chk_Acesso.Enabled    = par_lHabilitar
            loc_oPg2.chk_4c_ChkAplicado.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_Ajuste.Enabled        = par_lHabilitar
            loc_oPg2.txt_4c_Fator.Enabled         = par_lHabilitar
            loc_oPg2.txt_4c_MoeFat.Enabled        = par_lHabilitar
            loc_oPg2.obj_4c_OptAbateCus.Enabled   = par_lHabilitar
            loc_oPg2.obj_4c_Opt_agrucoms.Enabled  = par_lHabilitar
            loc_oPg2.txt_4c_NParcs.Enabled        = par_lHabilitar
            loc_oPg2.txt_4c_NParc2s.Enabled       = par_lHabilitar
            loc_oPg2.cbo_4c_CmbTpDesc.Enabled     = par_lHabilitar

            *-- Grade de empresas (tipo de desconto 11): ReadOnly nos modos nao-edicao
            loc_oPg2.cnt_4c_Container1.grd_4c_Empresas.ReadOnly = !par_lHabilitar

            *-- Pagina "Descontos / Comissoes"
            WITH loc_oPg2.cnt_4c_PgDesconto
                .txt_4c_DescontoMaximo.Enabled  = par_lHabilitar
                .grd_4c_Gradei.ReadOnly         = !par_lHabilitar
                .grd_4c_Gradec.ReadOnly         = !par_lHabilitar
                .cmd_4c_InserirComposicao.Enabled = par_lHabilitar
                .cmd_4c_ExcluirComposicao.Enabled = par_lHabilitar
                .cmd_4c_InserirComissao.Enabled   = par_lHabilitar
                .cmd_4c_ExcluirComissao.Enabled   = par_lHabilitar
                .cbo_4c_ComboComis.Enabled      = par_lHabilitar
                .txt_4c_DescFats.Enabled        = par_lHabilitar
                .txt_4c_FatorPads.Enabled       = par_lHabilitar
                .chk_4c_IgnoraCotacao.Enabled   = par_lHabilitar
                .cnt_4c_Formula1.cbo_4c_Campo1.Enabled = par_lHabilitar
                .cnt_4c_Formula1.cbo_4c_Oper1.Enabled  = par_lHabilitar
                .cnt_4c_Formula1.txt_4c_Const1.Enabled = par_lHabilitar
                .cnt_4c_Formula1.cbo_4c_Campo2.Enabled = par_lHabilitar
                .cnt_4c_Formula1.cbo_4c_Oper2.Enabled  = par_lHabilitar
                .cnt_4c_Formula1.txt_4c_Const2.Enabled = par_lHabilitar
                .cnt_4c_Formula1.cbo_4c_Campo3.Enabled = par_lHabilitar
                .cnt_4c_Formula1.txt_4c_Const3.Enabled = par_lHabilitar
                .cnt_4c_Formula1.txt_4c_Moeda.Enabled  = par_lHabilitar
                .cnt_4c_Formula2.cbo_4c_Campo1.Enabled = par_lHabilitar
                .cnt_4c_Formula2.cbo_4c_Oper1.Enabled  = par_lHabilitar
                .cnt_4c_Formula2.txt_4c_Const1.Enabled = par_lHabilitar
                .cnt_4c_Formula2.cbo_4c_Campo2.Enabled = par_lHabilitar
                .cnt_4c_Formula2.cbo_4c_Oper2.Enabled  = par_lHabilitar
                .cnt_4c_Formula2.txt_4c_Const2.Enabled = par_lHabilitar
                .cnt_4c_Formula2.cbo_4c_Campo3.Enabled = par_lHabilitar
                .cnt_4c_Formula2.txt_4c_Const3.Enabled = par_lHabilitar
                .cnt_4c_Formula2.txt_4c_Moeda.Enabled  = par_lHabilitar
                .Visible     = .T.
            ENDWITH
        CATCH TO loException
            MostrarErro(loException, "FormTbv.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
    * PUBLIC: chamado a partir dos eventos Btn*Click
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        TRY
            loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loException
            MostrarErro(loException, "FormTbv.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara Page2 para inclusao de nova tabela de desconto
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.CarregarGradeEmpresas()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro(loException, "FormTbv.BtnIncluirClick")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre a tabela de desconto selecionada em modo
    * somente leitura
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN loc_lResultado
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTbv.BtnVisualizarClick")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre a tabela de desconto selecionada para edicao
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN loc_lResultado
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTbv.BtnAlterarClick")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui a tabela de desconto selecionada apos
    * confirmacao (remove tambem SigOpTdt/SigOpTdi/SigOpTds relacionadas)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN loc_lResultado
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            RETURN loc_lResultado
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da tabela de desconto " + loc_cCodigo + "?", "Excluir")
            RETURN loc_lResultado
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Tabela de desconto exclu" + CHR(237) + "da com sucesso!")
                THIS.CarregarLista()
                loc_lResultado = .T.
            ELSE
                MsgErro(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro ao Excluir")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTbv.BtnExcluirClick")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Prepara Page2 em modo BUSCAR (localizar registro ja
    * carregado na lista por codigo ou descricao), reproduzindo o Busca=1/
    * Busca=2 do legado (Select CrSigOpTdz / Seek por Codigos ou Descrs)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "BUSCAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro(loException, "FormTbv.BtnBuscarClick")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Modo BUSCAR: localiza o registro na lista pelo
    * codigo ou pela descricao informados. Modo INCLUIR/ALTERAR: valida
    * codigo/descricao obrigatorios (legado: "Codigo Invalido !!!" /
    * descricao obrigatoria), checa duplicidade de codigo em INCLUIR
    * (legado: "Codigo ja cadastrado !!!") e grava via Salvar()
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oPg2, loc_cCodBusca, loc_cDescBusca, loc_lResultado
        loc_lResultado = .F.

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes antes do TRY (RETURN valido fora de TRY/CATCH)
        IF THIS.this_cModoAtual != "BUSCAR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido !!!", "")
            loc_oPg2.txt_4c__codigos.SetFocus
            RETURN .F.
        ENDIF

        IF THIS.this_cModoAtual != "BUSCAR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c__descrs.Value))
            MsgAviso("A descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria.", "")
            loc_oPg2.txt_4c__descrs.SetFocus
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_cModoAtual = "BUSCAR"
                loc_cCodBusca  = ALLTRIM(loc_oPg2.txt_4c__codigos.Value)
                loc_cDescBusca = ALLTRIM(loc_oPg2.txt_4c__descrs.Value)
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    IF !EMPTY(loc_cCodBusca)
                        LOCATE FOR ALLTRIM(cursor_4c_Dados.codigos) = loc_cCodBusca
                    ELSE
                        IF !EMPTY(loc_cDescBusca)
                            LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descrs)) = UPPER(loc_cDescBusca)
                        ENDIF
                    ENDIF
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                    IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
                        MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado !!!", "")
                        THIS.this_oBusinessObject.NovoRegistro()
                        loc_oPg2.txt_4c__codigos.SetFocus
                    ELSE
                        THIS.FormParaBO()
                        IF THIS.this_oBusinessObject.Salvar()
                            *-- Composicao/comissoes/faixas de desconto (paginas
                            *-- "Descontos / Comissoes" e "Configuracao de
                            *-- Desconto") nao fazem parte do FormParaBO/Salvar
                            *-- padrao (SigOpTdt/SigOpTdi/SigOpTds sao sub-tabelas)
                            IF !THIS.this_oBusinessObject.SalvarComposicaoDesconto(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
                                MsgErro("Tabela de desconto salva, mas houve falha ao gravar a composi" + CHR(231) + CHR(227) + "o de desconto.", "Erro ao Salvar")
                            ENDIF
                            IF !THIS.this_oBusinessObject.SalvarComissoesDesconto(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
                                MsgErro("Tabela de desconto salva, mas houve falha ao gravar as comiss" + CHR(245) + "es de desconto.", "Erro ao Salvar")
                            ENDIF
                            IF !THIS.this_oBusinessObject.SalvarFaixasDesconto(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
                                MsgErro("Tabela de desconto salva, mas houve falha ao gravar as faixas de desconto.", "Erro ao Salvar")
                            ENDIF
                            MsgInfo("Tabela de desconto salva com sucesso!")
                            THIS.this_cModoAtual = "LISTA"
                            THIS.AlternarPagina(1)
                            loc_lResultado = .T.
                        ELSE
                            MsgErro(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro ao Salvar")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTbv.BtnConfirmarClick")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias canonico para BtnConfirmarClick
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN THIS.BtnConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela (BUSCAR/INCLUIR/ALTERAR) e volta para a lista
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loException
            MostrarErro(loException, "FormTbv.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorTdtVazio - Cria cursor_4c_Tdt (estrutura de SigOpTdt) vazio
    * no Init do form, ANTES dos controles de ConfigurarPgPgDesconto (formulas
    * 1a/2a, Combo_Comis, DescFats, FatorPads, Ignora Cotacao) receberem seus
    * ControlSource. Diferente de Column de Grid (binding adiado pelo
    * RecordSource do Grid), TextBox/ComboBox/CheckBox resolvem o alias na
    * hora que .ControlSource e atribuido - sem o cursor existir, a atribuicao
    * estora "Alias 'CURSOR_4C_TDT' is not found.". Populado de verdade em
    * TbvBO.CarregarComposicaoDesconto() (via CarregarConfiguracaoDesconto),
    * que fecha e recria este cursor com os dados reais (mesmo alias).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorTdtVazio()
        IF USED("cursor_4c_Tdt")
            RETURN
        ENDIF

        CREATE CURSOR cursor_4c_Tdt (regs N(1), cidchaves C(20), codigos C(10), ;
            tipos N(1, 0), codtips C(14), tipods N(1, 0), descos N(6, 2), dfators N(6, 2), ;
            texclus C(1), faixas N(1, 0), finicias N(4, 0), ffinals N(4, 0), ;
            campo1t1s N(1, 0), campo2t1s N(1, 0), campo3t1s N(1, 0), oper1t1s N(1, 0), oper2t1s N(1, 0), ;
            const1t1s C(3), const2t1s C(3), const3t1s C(3), moeda1s C(3), ;
            campo1t2s N(1, 0), campo2t2s N(1, 0), campo3t2s N(1, 0), oper1t2s N(1, 0), oper2t2s N(1, 0), ;
            const1t2s C(3), const2t2s C(3), const3t2s C(3), moeda2s C(3), moeda3s C(3), ;
            tpcomis N(1, 0), descfats C(10), fatorpads N(7, 3), chkcots N(1, 0), ;
            tpunidade N(1, 0), chkmultcot N(1, 0))
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorTdsVazio - Cria cursor_4c_Tds (estrutura de SigOpTds) vazio
    * no Init do form, ANTES dos controles de grd_4c_GradeD (Column3/4/5/6 em
    * ConfigurarPgPgConfDesconto - horario dentro do dia/Preco/Fator) receberem
    * seus ControlSource. Igual ao caso de cursor_4c_Tdt (ver CriarCursorTdtVazio):
    * Column.ControlSource resolve o alias na hora da atribuicao - sem o cursor
    * existir, estora "Alias 'CURSOR_4C_TDS' is not found.". Populado de
    * verdade em TbvBO.CarregarFaixasDesconto() (via CarregarConfiguracaoDesconto),
    * que fecha e recria este cursor com os dados reais (mesmo alias).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorTdsVazio()
        IF USED("cursor_4c_Tds")
            RETURN
        ENDIF

        CREATE CURSOR cursor_4c_Tds (cidchaves C(20), codigos C(10), ;
            tipos N(1, 0), codtips C(10), tipods N(1, 0), ;
            campo1is C(10), campo1fs C(10), campo2is C(10), campo2fs C(10), ;
            campo3is T, campo3fs T, campo4is C(10), campo4fs C(10), ;
            descos N(6, 2), dfators N(6, 2), nchvtbds N(6, 0))
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorTipoDesconto - Cria cursor local (lista fixa) para cbo_4c_CmbTpDesc
    * Legado: Create Cursor crTpDesc (Descrs c(40), ordem N(2,0)) no Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorTipoDesconto()
        IF USED("cursor_4c_TipoDesconto")
            RETURN
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_TipoDesconto (Descrs C(40), Ordem N(2, 0))
        SET NULL OFF
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("1-Anivers" + CHR(225) + "rio", 1)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("2-Desconto Vendedor", 2)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("3-Desconto Gerente-Grupo", 3)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("4-Desconto Gerente-Lancamento", 4)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("5-Desconto Gerente-qq pe" + CHR(231) + "a", 5)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("6-Troca Zerada", 6)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("7-Troca Upgrade", 7)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("8-Desconto Supervisor", 8)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("9-Desconto Diretoria", 9)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("10-Troca Up Alianca", 10)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("11-Desconto Gerente-Extra/loja", 11)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("12-Desconto Gerente-Brinde", 12)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("13-Desconto Gerente-Troca de pre" + CHR(231) + "o", 13)
        INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES (SPACE(40), 0)
        GO TOP IN cursor_4c_TipoDesconto
    ENDPROC

    *--------------------------------------------------------------------------
    * TipoDescontoInteractiveChange - Mostra/oculta a lista de empresas conforme
    * o tipo de desconto selecionado (11 = Desconto Gerente-Extra/loja)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE TipoDescontoInteractiveChange()
        LOCAL loc_oPg, loc_lMostrarEmpresas

        loc_oPg = THIS.pgf_4c_Paginas.Page2
        loc_lMostrarEmpresas = (loc_oPg.cbo_4c_CmbTpDesc.Value = 11)

        loc_oPg.cnt_4c_Container1.Visible = loc_lMostrarEmpresas

        IF !loc_lMostrarEmpresas AND USED("cursor_4c_Empresas")
            SELECT cursor_4c_Empresas
            REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
            GO TOP IN cursor_4c_Empresas
            IF PEMSTATUS(loc_oPg.cnt_4c_Container1, "grd_4c_Empresas", 5)
                loc_oPg.cnt_4c_Container1.grd_4c_Empresas.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeEmpresas - Carrega grade de empresas (SigCdEmp) e marca as
    * empresas presentes em this_cListaEmpresas (formato ";EMP1;EMP2;...")
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradeEmpresas()
        LOCAL loc_lResultado, loc_oGrid, loc_cListaEmpresas

        loc_lResultado = .F.

        TRY
            IF THIS.this_oBusinessObject.CarregarEmpresas()
                loc_cListaEmpresas = THIS.this_oBusinessObject.this_cListaEmpresas

                SELECT cursor_4c_Empresas
                SCAN
                    IF !EMPTY(ALLTRIM(cursor_4c_Empresas.cemps)) AND ALLTRIM(cursor_4c_Empresas.cemps) $ loc_cListaEmpresas
                        REPLACE nMarca WITH 1 IN cursor_4c_Empresas
                    ELSE
                        REPLACE nMarca WITH 0 IN cursor_4c_Empresas
                    ENDIF
                ENDSCAN
                GO TOP IN cursor_4c_Empresas

                *-- NAO reatribuir ColumnCount aqui: destruiria o chk_4c_Marca
                *-- (AddObject em Column1) criado em ConfigurarPaginaDados (Pattern #183)
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas
                loc_oGrid.RecordSource = "cursor_4c_Empresas"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Empresas.nMarca"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Empresas.cemps"
                loc_oGrid.Column1.Header1.Caption = ""
                loc_oGrid.Column2.Header1.Caption = "Empresa"
                loc_oGrid.Column1.Width  = 30
                loc_oGrid.Column2.Width  = 190
                loc_oGrid.Column1.CurrentControl = "chk_4c_Marca"
                loc_oGrid.Column2.ReadOnly = .T.
                loc_oGrid.Refresh()

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTbv.CarregarGradeEmpresas")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarListaEmpresas - Le as empresas marcadas na grade e monta a string
    * ";EMP1;EMP2;..." gravada em this_cListaEmpresas (listaemp)
    *--------------------------------------------------------------------------
    PROCEDURE MontarListaEmpresas()
        LOCAL loc_cLista

        loc_cLista = ""

        IF USED("cursor_4c_Empresas")
            SELECT cursor_4c_Empresas
            GO TOP
            SCAN
                IF cursor_4c_Empresas.nMarca = 1
                    loc_cLista = loc_cLista + ";" + ALLTRIM(cursor_4c_Empresas.cemps)
                ENDIF
            ENDSCAN
        ENDIF

        RETURN loc_cLista
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEmpresasDesmarcarClick - Desmarca todas as empresas da grade
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnEmpresasDesmarcarClick()
        IF USED("cursor_4c_Empresas")
            SELECT cursor_4c_Empresas
            REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
            GO TOP IN cursor_4c_Empresas
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEmpresasMarcarClick - Marca todas as empresas da grade
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnEmpresasMarcarClick()
        IF USED("cursor_4c_Empresas")
            SELECT cursor_4c_Empresas
            REPLACE ALL nMarca WITH 1 IN cursor_4c_Empresas
            GO TOP IN cursor_4c_Empresas
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpresaCheckboxMouseDown - Toggle nMarca em cursor_4c_Empresas via mouse
    * Grid nao alterna CheckBox pelo binding nativo (campo numerico) - alterna
    * manualmente e suprime o toggle padrao com NODEFAULT
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE EmpresaCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
            SELECT cursor_4c_Empresas
            REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
            ENDIF
        ENDIF
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpresaCheckboxMouseUp - Suprime comportamento padrao
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE EmpresaCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpresaCheckboxClick - Suprime toggle automatico (MouseDown ja atualizou)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE EmpresaCheckboxClick()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpresaCheckboxKeyPress - Toggle nMarca em cursor_4c_Empresas via teclado
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE EmpresaCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
                SELECT cursor_4c_Empresas
                REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaRefLookupKeyPress / MoedaRefLookupDblClick - F4/DblClick para
    * lookup de Moeda de Referencia (SigCdMoe) em txt_4c__moerefs
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE MoedaRefLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupMoedaRef()
        ENDIF
    ENDPROC

    PROCEDURE MoedaRefLookupDblClick()
        THIS.AbrirLookupMoedaRef()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoedaRef - Busca SigCdMoe por codigo (cmoes) e preenche
    * codigo + descricao da Moeda de Referencia
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoedaRef()
        LOCAL loc_oPg, loc_cValor, loc_oBusca

        loc_oPg    = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__moerefs.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", loc_cValor, ;
                "Buscar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                    SELECT cursor_4c_BuscaMoeda
                    loc_oPg.txt_4c__moerefs.Value      = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                    loc_oPg.txt_4c__moerefs_desc.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTbv.AbrirLookupMoedaRef")
        ENDTRY

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaFatorLookupKeyPress / MoedaFatorLookupDblClick - F4/DblClick para
    * lookup de Moeda do Fator (SigCdMoe) em txt_4c_MoeFat
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE MoedaFatorLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupMoedaFator()
        ENDIF
    ENDPROC

    PROCEDURE MoedaFatorLookupDblClick()
        THIS.AbrirLookupMoedaFator()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoedaFator - Busca SigCdMoe por codigo (cmoes) e preenche
    * a Moeda do Fator
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoedaFator()
        LOCAL loc_oPg, loc_cValor, loc_oBusca

        loc_oPg    = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_MoeFat.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoedaFator", "cmoes", loc_cValor, ;
                "Buscar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedaFator")
                    SELECT cursor_4c_BuscaMoedaFator
                    loc_oPg.txt_4c_MoeFat.Value = ALLTRIM(cursor_4c_BuscaMoedaFator.cmoes)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTbv.AbrirLookupMoedaFator")
        ENDTRY

        IF USED("cursor_4c_BuscaMoedaFator")
            USE IN cursor_4c_BuscaMoedaFator
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorDiaSemana - Cria cursor local (lista fixa) com os 7 dias da
    * semana, usado na validacao de faixas de desconto por Dia da Semana
    * Legado: Create Cursor DiaSemana (ndias n(1), Descrs c(7)) no Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorDiaSemana()
        IF USED("cursor_4c_DiaSemana")
            RETURN
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_DiaSemana (nDias N(1), Descrs C(7))
        SET NULL OFF
        INDEX ON Descrs TAG Descrs
        INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (1, "DOMINGO")
        INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (2, "SEGUNDA")
        INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (3, "TERCA  ")
        INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (4, "QUARTA ")
        INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (5, "QUINTA ")
        INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (6, "SEXTA  ")
        INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (7, "SABADO ")
        GO TOP IN cursor_4c_DiaSemana
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracaoDesconto - Carrega grd_4c_GradeI (SigOpTdt) e
    * grd_4c_GradeD (SigOpTds) do codigo corrente. Chamado por BOParaForm()
    * ao entrar em ALTERAR/VISUALIZAR/EXCLUIR e por LimparCampos() (INCLUIR).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracaoDesconto()
        LOCAL loc_oPgConf, loc_oPgDesc, loc_oGradei, loc_oGradeiDesc, loc_oGradec, loc_cCodigo

        TRY
            loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
            loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
            loc_oGradei     = loc_oPgConf.grd_4c_GradeI
            loc_oGradeiDesc = loc_oPgDesc.grd_4c_Gradei
            loc_oGradec     = loc_oPgDesc.grd_4c_Gradec
            loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)

            IF EMPTY(loc_cCodigo)
                loc_oGradei.RecordSource        = ""
                loc_oPgConf.grd_4c_GradeD.RecordSource = ""
                loc_oPgConf.grd_4c_GradeD.Enabled      = .F.
                loc_oPgConf.lbl_4c_Lb_desconto.Caption = "Tipo de Desconto"
                loc_oGradeiDesc.RecordSource    = ""
                loc_oGradec.RecordSource        = ""
                RETURN
            ENDIF

            THIS.this_oBusinessObject.CarregarComposicaoDesconto(loc_cCodigo)
            THIS.this_oBusinessObject.CarregarComissoesDesconto(loc_cCodigo)
            THIS.this_oBusinessObject.CarregarFaixasDesconto(loc_cCodigo)

            loc_oGradei.RecordSource        = "cursor_4c_Tdt"
            loc_oGradei.Column1.ControlSource = "cursor_4c_Tdt.tipos"
            loc_oGradei.Column2.ControlSource = "cursor_4c_Tdt.codtips"
            loc_oGradei.Column3.ControlSource = "cursor_4c_Tdt.tipods"
            loc_oGradei.SetAll("DynamicBackColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(128,128,128), RGB(255,255,255))", "Column")
            loc_oGradei.SetAll("DynamicForeColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(255,255,255), RGB(0,0,0))", "Column")
            loc_oGradei.Refresh()

            *-- grd_4c_Gradei (pgDesconto) - MESMA cursor_4c_Tdt, colunas
            *-- adicionais de valor/fator/exclui/faixa/inicial/final
            loc_oGradeiDesc.RecordSource        = "cursor_4c_Tdt"
            loc_oGradeiDesc.Column1.ControlSource = "cursor_4c_Tdt.tipos"
            loc_oGradeiDesc.Column2.ControlSource = "cursor_4c_Tdt.codtips"
            loc_oGradeiDesc.Column3.ControlSource = "cursor_4c_Tdt.descos"
            loc_oGradeiDesc.Column4.ControlSource = "cursor_4c_Tdt.dfators"
            loc_oGradeiDesc.Column5.ControlSource = "cursor_4c_Tdt.texclus"
            loc_oGradeiDesc.Column6.ControlSource = "cursor_4c_Tdt.faixas"
            loc_oGradeiDesc.Column7.ControlSource = "cursor_4c_Tdt.finicias"
            loc_oGradeiDesc.Column8.ControlSource = "cursor_4c_Tdt.ffinals"
            loc_oGradeiDesc.SetAll("DynamicBackColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(128,128,128), RGB(255,255,255))", "Column")
            loc_oGradeiDesc.SetAll("DynamicForeColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(255,255,255), RGB(0,0,0))", "Column")
            *-- Reaplica cabecalhos apos RecordSource (Problema 48/Pattern #180 -
            *-- VFP pode resetar Header1.Caption ao reatribuir RecordSource)
            loc_oGradeiDesc.Column1.Header1.Caption = "Tipo"
            loc_oGradeiDesc.Column2.Header1.Caption = "C" + CHR(243) + "digo "
            loc_oGradeiDesc.Column3.Header1.Caption = "Valor"
            loc_oGradeiDesc.Column4.Header1.Caption = "Fator"
            loc_oGradeiDesc.Column5.Header1.Caption = "E"
            loc_oGradeiDesc.Column6.Header1.Caption = "Faixa"
            loc_oGradeiDesc.Column7.Header1.Caption = "Inicial"
            loc_oGradeiDesc.Column8.Header1.Caption = "Final"
            loc_oGradeiDesc.Refresh()

            IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
                SELECT cursor_4c_Tdt
                REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
                REPLACE regs WITH 1 IN cursor_4c_Tdt
                GO TOP IN cursor_4c_Tdt
            ENDIF

            *-- grd_4c_Gradec (comissoes) - filtrado pela linha corrente de
            *-- cursor_4c_Tdt via MontarComissoesDesconto()
            loc_oGradec.ColumnCount = 6
            loc_oGradec.RecordSource        = "cursor_4c_Tdi"
            loc_oGradec.Column1.ControlSource = "cursor_4c_Tdi.grupos"
            loc_oGradec.Column2.ControlSource = "cursor_4c_Tdi.contas"
            loc_oGradec.Column3.ControlSource = "cursor_4c_Tdi.pintegrals"
            loc_oGradec.Column4.ControlSource = "cursor_4c_Tdi.pdivididas"
            loc_oGradec.Column5.ControlSource = "cursor_4c_Tdi.patendes"
            loc_oGradec.Column6.ControlSource = "cursor_4c_Tdi.moedas"
            *-- Reaplica cabecalhos apos RecordSource (Problema 48/Pattern #180)
            loc_oGradec.Column1.Header1.Caption = "Grupo"
            loc_oGradec.Column2.Header1.Caption = "Conta"
            loc_oGradec.Column3.Header1.Caption = "Integral"
            loc_oGradec.Column4.Header1.Caption = "Dividida"
            loc_oGradec.Column5.Header1.Caption = "Atendim"
            loc_oGradec.Column6.Header1.Caption = "Moe"

            THIS.MontarConfiguracaoDesconto()
            THIS.MontarComissoesDesconto()
        CATCH TO loException
            MostrarErro(loException, "FormTbv.CarregarConfiguracaoDesconto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeiConfAfterRowColChange - troca de linha em grd_4c_GradeI: marca a
    * linha corrente (flag "regs", equivalente ao legado) e reconfigura a
    * grade de faixas (grd_4c_GradeD) para a nova combinacao Tipo/Codigo
    * PUBLIC: BINDEVENT requer metodo publico + parametro do evento
    *--------------------------------------------------------------------------
    PROCEDURE GradeiConfAfterRowColChange(par_nColIndex)
        IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
            RETURN
        ENDIF

        SELECT cursor_4c_Tdt
        REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
        REPLACE regs WITH 1 IN cursor_4c_Tdt

        THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
        THIS.MontarConfiguracaoDesconto()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeiConfColumn3When - habilita edicao da coluna "Tipos Desconto"
    * apenas em INCLUIR/ALTERAR (equivalente ao When original)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE GradeiConfColumn3When()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeiConfColumn3Valid / GradeiConfColumn3LostFocus - reconfigura a
    * grade de faixas ao mudar o tipo de desconto progressivo da linha
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE GradeiConfColumn3Valid()
        THIS.MontarConfiguracaoDesconto()
    ENDPROC

    PROCEDURE GradeiConfColumn3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.MontarConfiguracaoDesconto()
        IF LASTKEY() = 9
            THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD.Column1.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarConfiguracaoDesconto - Equivalente ao "MontaTbDes" do legado.
    * Filtra cursor_4c_Tds pela combinacao Tipo+Codigo+TipoDesconto da linha
    * corrente de grd_4c_GradeI, cria a faixa inicial (00:00-23:59) quando
    * ainda nao existe nenhuma, e reconfigura grd_4c_GradeD (ControlSource/
    * InputMask das colunas Inicial/Final) conforme o Tipo de Desconto:
    * 2=Dia da Semana, 3=Dia do Mes, 4=Horario, 5=Data
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarConfiguracaoDesconto()
        LOCAL loc_oGD, loc_oPgConf, loc_cCodigo, loc_nTipos, loc_cCodTips, ;
              loc_nTipoDs, loc_cTitulo

        loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
        loc_oGD     = loc_oPgConf.grd_4c_GradeD

        IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
            loc_oGD.RecordSource = ""
            loc_oGD.Enabled      = .F.
            loc_oPgConf.lbl_4c_Lb_desconto.Caption = "Tipo de Desconto"
            RETURN
        ENDIF

        loc_cCodigo  = ALLTRIM(cursor_4c_Tdt.codigos)
        loc_nTipos   = cursor_4c_Tdt.tipos
        loc_cCodTips = ALLTRIM(cursor_4c_Tdt.codtips)
        loc_nTipoDs  = cursor_4c_Tdt.tipods

        DO CASE
            CASE loc_nTipoDs = 2
                loc_cTitulo = "Dia da Semana"
            CASE loc_nTipoDs = 3
                loc_cTitulo = "Dia do Mes"
            CASE loc_nTipoDs = 4
                loc_cTitulo = "Horario"
            OTHERWISE
                loc_cTitulo = "Data"
        ENDCASE
        loc_oPgConf.lbl_4c_Lb_desconto.Caption = loc_cTitulo

        IF USED("cursor_4c_Tds")
            SELECT cursor_4c_Tds
            SET FILTER TO ALLTRIM(codigos) == loc_cCodigo AND tipos = loc_nTipos ;
                AND ALLTRIM(codtips) == loc_cCodTips AND tipods = loc_nTipoDs
            GO TOP
            IF EOF()
                APPEND BLANK
                REPLACE cidchaves WITH fUniqueIds(), ;
                        codigos   WITH loc_cCodigo, ;
                        tipos     WITH loc_nTipos, ;
                        codtips   WITH loc_cCodTips, ;
                        tipods    WITH loc_nTipoDs, ;
                        campo2is  WITH "00:00", ;
                        campo2fs  WITH "23:59" IN cursor_4c_Tds
                GO TOP
            ENDIF
        ENDIF

        *-- RecordSource DEVE ser atribuido FORA do WITH que acessa .Column -
        *-- dentro do mesmo WITH as colunas ainda nao existem no momento da
        *-- reatribuicao, gerando "Unknown member COLUMN1" (Pattern GRID-WITH)
        loc_oGD.RecordSource = ""
        loc_oGD.ColumnCount = 3
        loc_oGD.RecordSource = "cursor_4c_Tds"

        WITH loc_oGD
            *-- Redefinir ControlSource de TODAS as colunas apos reatribuir
            *-- RecordSource - VFP faz auto-bind pela ordem dos campos do
            *-- cursor, ignorando qualquer ControlSource setado antes (Pattern
            *-- GRID-RECORDSOURCE-AUTOBIND)
            DO CASE
                CASE loc_nTipoDs = 5
                    .Column1.ControlSource = "cursor_4c_Tds.Campo3is"
                    .Column2.ControlSource = "cursor_4c_Tds.Campo3fs"
                OTHERWISE
                    .Column1.ControlSource = "cursor_4c_Tds.Campo1is"
                    .Column2.ControlSource = "cursor_4c_Tds.Campo1fs"
            ENDCASE
            .Column3.ControlSource = "cursor_4c_Tds.Campo2is"
            .Column4.ControlSource = "cursor_4c_Tds.Campo2fs"
            .Column5.ControlSource = "cursor_4c_Tds.descos"
            .Column6.ControlSource = "cursor_4c_Tds.dfators"

            DO CASE
                CASE loc_nTipoDs = 2
                    .Column1.Text1.InputMask = "XXXXXXX"
                    .Column1.Text1.MaxLength = 7
                    .Column2.Text1.InputMask = "XXXXXXX"
                    .Column2.Text1.MaxLength = 7
                CASE loc_nTipoDs = 3
                    .Column1.Text1.InputMask = "99"
                    .Column1.Text1.MaxLength = 2
                    .Column2.Text1.InputMask = "99"
                    .Column2.Text1.MaxLength = 2
                CASE loc_nTipoDs = 4
                    .Column1.Text1.InputMask = "99:99"
                    .Column1.Text1.MaxLength = 5
                    .Column2.Text1.InputMask = "99:99"
                    .Column2.Text1.MaxLength = 5
                OTHERWISE
                    .Column1.Text1.InputMask = ""
                    .Column1.Text1.MaxLength = 10
                    .Column2.Text1.InputMask = ""
                    .Column2.Text1.MaxLength = 10
            ENDCASE

            *-- Horario dentro do dia (Column3/Column4) so se aplica quando o
            *-- Tipo de Desconto NAO for ele mesmo "Horario" (Column1/2 ja
            *-- cobrem o horario nesse caso) - equivalente ao When original
            .Column3.ReadOnly = (loc_nTipoDs = 4)
            .Column4.ReadOnly = (loc_nTipoDs = 4)

            .Enabled = INLIST(loc_nTipoDs, 2, 3, 4, 5)
            .Refresh()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarHorarioValidado - Valida um horario digitado (HH:MM, 00:00 a
    * 23:59) e retorna a versao formatada, ou "" se invalido (mostrando
    * aviso). Compartilhado pelas colunas de horario de grd_4c_GradeD.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormatarHorarioValidado(par_cValor)
        LOCAL loc_cValor, loc_nHora, loc_nMin

        loc_cValor = TRANSFORM(par_cValor, "@L 99:99")
        loc_nHora  = VAL(SUBSTR(loc_cValor, 1, 2))
        loc_nMin   = VAL(SUBSTR(loc_cValor, 4, 2))

        IF !BETWEEN(loc_nHora, 0, 23)
            MsgAviso("Horas s" + CHR(243) + " pode ser entre 00:00 e 23:59", "")
            RETURN ""
        ENDIF
        IF !BETWEEN(loc_nMin, 0, 59)
            MsgAviso("Minutos s" + CHR(243) + " pode ser entre 00 e 59", "")
            RETURN ""
        ENDIF

        RETURN TRANSFORM(loc_nHora, "@L 99") + ":" + TRANSFORM(loc_nMin, "@L 99")
    ENDFUNC

    *--------------------------------------------------------------------------
    * FaixaTemInicial - Indica se a faixa (linha corrente de cursor_4c_Tds)
    * ja tem o valor Inicial preenchido, condicao para habilitar as demais
    * colunas de grd_4c_GradeD (equivalente ao "Left(Campo1is,2)" do legado).
    * Quando o Tipo de Desconto e "Data" (5), o Inicial fica em Campo3is
    * (nao em Campo1is - ver MontarConfiguracaoDesconto)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FaixaTemInicial()
        LOCAL loc_nTipoDs

        IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
            RETURN .F.
        ENDIF

        loc_nTipoDs = 0
        IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
            loc_nTipoDs = cursor_4c_Tdt.tipods
        ENDIF

        IF loc_nTipoDs = 5
            RETURN !EMPTY(cursor_4c_Tds.Campo3is)
        ENDIF

        RETURN !EMPTY(LEFT(NVL(cursor_4c_Tds.Campo1is, ""), 2))
    ENDFUNC

    *--------------------------------------------------------------------------
    * GradeD Column1/Column2 (Inicial/Final) - When/Valid
    * Equivalente ao "PgConfDesconto.GradeD.Column1/2.Text1" do legado:
    * validacao/formatacao depende do Tipo de Desconto (tipods) da linha
    * corrente de grd_4c_GradeI (cursor_4c_Tdt)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE GradeDColumn1When()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    PROCEDURE GradeDColumn1Valid()
        LOCAL loc_oGD, loc_cValor, loc_cFormatado

        IF !USED("cursor_4c_Tdt") OR !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tdt") OR EOF("cursor_4c_Tds")
            RETURN
        ENDIF

        loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
        loc_cValor = ALLTRIM(loc_oGD.Column1.Text1.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        DO CASE
            CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
                IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
                    MsgAviso("Dia da semana inv" + CHR(225) + "lido. Informe Domingo, Segunda, Terca, Quarta, Quinta, Sexta ou Sabado.", "")
                    REPLACE Campo1is WITH "" IN cursor_4c_Tds
                ELSE
                    REPLACE Campo1is WITH ALLTRIM(cursor_4c_DiaSemana.Descrs) IN cursor_4c_Tds
                    IF EMPTY(ALLTRIM(cursor_4c_Tds.Campo1fs))
                        REPLACE Campo1fs WITH cursor_4c_Tds.Campo1is IN cursor_4c_Tds
                    ENDIF
                ENDIF

            CASE cursor_4c_Tdt.tipods = 3  && Dia do Mes
                IF !BETWEEN(VAL(loc_cValor), 1, 31)
                    MsgAviso("Dia do m" + CHR(234) + "s deve ser entre 1 e 31 !!!", "")
                    REPLACE Campo1is WITH "" IN cursor_4c_Tds
                ELSE
                    REPLACE Campo1is WITH PADL(TRANSFORM(INT(VAL(loc_cValor))), 2, "0") IN cursor_4c_Tds
                    IF VAL(cursor_4c_Tds.Campo1fs) = 0 OR VAL(cursor_4c_Tds.Campo1is) > VAL(cursor_4c_Tds.Campo1fs)
                        REPLACE Campo1fs WITH cursor_4c_Tds.Campo1is IN cursor_4c_Tds
                    ENDIF
                ENDIF

            CASE cursor_4c_Tdt.tipods = 4  && Horario
                loc_cFormatado = THIS.FormatarHorarioValidado(loc_cValor)
                IF EMPTY(loc_cFormatado)
                    REPLACE Campo1is WITH "" IN cursor_4c_Tds
                ELSE
                    REPLACE Campo1is WITH loc_cFormatado IN cursor_4c_Tds
                    IF EMPTY(cursor_4c_Tds.Campo1fs) OR VAL(STRTRAN(loc_cFormatado, ":", "")) > VAL(STRTRAN(cursor_4c_Tds.Campo1fs, ":", ""))
                        REPLACE Campo1fs WITH loc_cFormatado IN cursor_4c_Tds
                    ENDIF
                ENDIF

            OTHERWISE  && 5 = Data (Campo3is/Campo3fs, DATETIME - VFP valida o tipo na propria coluna)
                IF !EMPTY(cursor_4c_Tds.Campo3fs) AND cursor_4c_Tds.Campo3is > cursor_4c_Tds.Campo3fs
                    REPLACE Campo3fs WITH cursor_4c_Tds.Campo3is IN cursor_4c_Tds
                ENDIF
        ENDCASE

        loc_oGD.Refresh()
    ENDPROC

    PROCEDURE GradeDColumn2When()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial()
    ENDPROC

    PROCEDURE GradeDColumn2Valid()
        LOCAL loc_oGD, loc_cValor, loc_nDiaIni, loc_cFormatado

        IF !USED("cursor_4c_Tdt") OR !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tdt") OR EOF("cursor_4c_Tds")
            RETURN
        ENDIF

        loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
        loc_cValor = ALLTRIM(loc_oGD.Column2.Text1.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        DO CASE
            CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
                IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
                    MsgAviso("Dia da semana inv" + CHR(225) + "lido.", "")
                    RETURN
                ENDIF
                IF SEEK(PADR(UPPER(ALLTRIM(cursor_4c_Tds.Campo1is)), 7), "cursor_4c_DiaSemana", "Descrs")
                    loc_nDiaIni = cursor_4c_DiaSemana.nDias
                    IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs") OR cursor_4c_DiaSemana.nDias < loc_nDiaIni
                        MsgAviso("Dia final n" + CHR(227) + "o pode ser anterior ao dia inicial !!!", "")
                        RETURN
                    ENDIF
                ENDIF
                =SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
                REPLACE Campo1fs WITH ALLTRIM(cursor_4c_DiaSemana.Descrs) IN cursor_4c_Tds

            CASE cursor_4c_Tdt.tipods = 3  && Dia do Mes
                IF !BETWEEN(VAL(loc_cValor), 1, 31)
                    MsgAviso("Dia do m" + CHR(234) + "s deve ser entre 1 e 31 !!!", "")
                    RETURN
                ENDIF
                IF VAL(loc_cValor) < VAL(cursor_4c_Tds.Campo1is)
                    MsgAviso("Intervalo de dias inv" + CHR(225) + "lido. O dia final " + CHR(233) + " menor que o inicial.", "")
                    RETURN
                ENDIF
                REPLACE Campo1fs WITH PADL(TRANSFORM(INT(VAL(loc_cValor))), 2, "0") IN cursor_4c_Tds

            CASE cursor_4c_Tdt.tipods = 4  && Horario
                loc_cFormatado = THIS.FormatarHorarioValidado(loc_cValor)
                IF EMPTY(loc_cFormatado)
                    RETURN
                ENDIF
                IF VAL(STRTRAN(loc_cFormatado, ":", "")) < VAL(STRTRAN(cursor_4c_Tds.Campo1is, ":", ""))
                    MsgAviso("Intervalo de hor" + CHR(225) + "rio inv" + CHR(225) + "lido. A hora final " + CHR(233) + " menor que a inicial.", "")
                    RETURN
                ENDIF
                REPLACE Campo1fs WITH loc_cFormatado IN cursor_4c_Tds

            OTHERWISE  && 5 = Data
                IF cursor_4c_Tds.Campo3fs < cursor_4c_Tds.Campo3is
                    MsgAviso("Data final n" + CHR(227) + "o pode ser menor que a inicial !!!", "")
                ENDIF
        ENDCASE

        loc_oGD.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeD Column3/Column4 - faixa de horario dentro do dia (Campo2is/fs).
    * Nao se aplica quando o Tipo de Desconto ja e "Horario" (Column1/2)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE GradeDColumn3When()
        LOCAL loc_nTipoDs
        loc_nTipoDs = 0
        IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
            loc_nTipoDs = cursor_4c_Tdt.tipods
        ENDIF
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial() AND loc_nTipoDs != 4
    ENDPROC

    PROCEDURE GradeDColumn3Valid()
        LOCAL loc_oGD, loc_cFormatado

        IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
            RETURN
        ENDIF

        loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
        loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column3.Text1.Value))
        IF EMPTY(loc_cFormatado)
            RETURN
        ENDIF

        REPLACE Campo2is WITH loc_cFormatado IN cursor_4c_Tds
        IF EMPTY(cursor_4c_Tds.Campo2fs) OR VAL(STRTRAN(loc_cFormatado, ":", "")) > VAL(STRTRAN(cursor_4c_Tds.Campo2fs, ":", ""))
            REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
        ENDIF

        loc_oGD.Refresh()
    ENDPROC

    PROCEDURE GradeDColumn4When()
        RETURN THIS.GradeDColumn3When()
    ENDPROC

    PROCEDURE GradeDColumn4Valid()
        LOCAL loc_oGD, loc_cFormatado

        IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
            RETURN
        ENDIF

        loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
        loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column4.Text1.Value))
        IF EMPTY(loc_cFormatado)
            RETURN
        ENDIF

        IF VAL(STRTRAN(loc_cFormatado, ":", "")) < VAL(STRTRAN(cursor_4c_Tds.Campo2is, ":", ""))
            MsgAviso("Intervalo de horas inv" + CHR(225) + "lido. A hora final " + CHR(233) + " menor que a inicial.", "")
            RETURN
        ENDIF

        REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
        loc_oGD.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeD Column5/Column6 - Preco/Fator da faixa. Column6 (Fator), ao
    * confirmar com ENTER, cria automaticamente uma nova faixa em branco
    * (equivalente ao legado)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE GradeDColumn5When()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial()
    ENDPROC

    PROCEDURE GradeDColumn6Valid()
        LOCAL loc_oGD

        IF LASTKEY() != 13 OR !USED("cursor_4c_Tds") OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
            RETURN
        ENDIF

        loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD

        SELECT cursor_4c_Tds
        SKIP
        IF EOF()
            APPEND BLANK
            REPLACE cidchaves WITH fUniqueIds(), ;
                    codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
                    tipos     WITH cursor_4c_Tdt.tipos, ;
                    codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
                    tipods    WITH cursor_4c_Tdt.tipods, ;
                    campo2is  WITH "00:00", ;
                    campo2fs  WITH "23:59" IN cursor_4c_Tds
            GO BOTTOM IN cursor_4c_Tds
        ENDIF

        loc_oGD.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirFaixaDescontoClick - remove a faixa corrente de grd_4c_GradeD;
    * garante que sempre reste ao menos uma faixa (equivalente ao legado)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirFaixaDescontoClick()
        LOCAL loc_oGD, loc_nRegistros

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tds") ;
                OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
            RETURN
        ENDIF

        loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD

        SELECT cursor_4c_Tds
        IF !EOF()
            DELETE
        ENDIF

        COUNT FOR !DELETED() TO loc_nRegistros
        IF loc_nRegistros = 0
            APPEND BLANK
            REPLACE cidchaves WITH fUniqueIds(), ;
                    codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
                    tipos     WITH cursor_4c_Tdt.tipos, ;
                    codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
                    tipods    WITH cursor_4c_Tdt.tipods, ;
                    campo2is  WITH "00:00", ;
                    campo2fs  WITH "23:59" IN cursor_4c_Tds
        ENDIF

        GO TOP IN cursor_4c_Tds
        loc_oGD.Refresh()
        loc_oGD.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarComissoesDesconto - Equivalente ao "MontaTbCom" do legado.
    * Filtra localmente cursor_4c_Tdi pela combinacao Tipo+Codigo da linha
    * corrente de grd_4c_Gradei (cursor_4c_Tdt) e atualiza grd_4c_Gradec.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarComissoesDesconto()
        LOCAL loc_oGradec, loc_nTipos, loc_cCodTips

        loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec

        IF !USED("cursor_4c_Tdi")
            RETURN
        ENDIF

        IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
            SELECT cursor_4c_Tdi
            SET FILTER TO .F.
            loc_oGradec.Refresh()
            RETURN
        ENDIF

        loc_nTipos   = cursor_4c_Tdt.tipos
        loc_cCodTips = ALLTRIM(cursor_4c_Tdt.codtips)

        SELECT cursor_4c_Tdi
        SET FILTER TO tipos = loc_nTipos AND ALLTRIM(codtips) = loc_cCodTips
        GO TOP IN cursor_4c_Tdi
        loc_oGradec.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeiDescAfterRowColChange - troca de linha em grd_4c_Gradei (pagina
    * "Descontos / Comissoes"): marca a linha corrente (flag "regs",
    * compartilhada com grd_4c_GradeI de PgConfDesconto), refresca os
    * controles bindados a cursor_4c_Tdt (formulas 1a/2a, comissao, fator/
    * descritivo, ignora cotacao) e reconfigura grd_4c_Gradec (comissoes)
    * PUBLIC: BINDEVENT requer metodo publico + parametro do evento
    *--------------------------------------------------------------------------
    PROCEDURE GradeiDescAfterRowColChange(par_nColIndex)
        LOCAL loc_oCnt

        IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
            RETURN
        ENDIF

        SELECT cursor_4c_Tdt
        REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
        REPLACE regs WITH 1 IN cursor_4c_Tdt

        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
        loc_oCnt.grd_4c_Gradei.Refresh()
        loc_oCnt.cnt_4c_Formula1.Refresh()
        loc_oCnt.cnt_4c_Formula2.Refresh()
        loc_oCnt.cbo_4c_ComboComis.Refresh()
        loc_oCnt.txt_4c_DescFats.Refresh()
        loc_oCnt.txt_4c_FatorPads.Refresh()
        loc_oCnt.chk_4c_IgnoraCotacao.Refresh()

        *-- grd_4c_GradeI de PgConfDesconto compartilha a mesma cursor_4c_Tdt
        THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()

        THIS.MontarComissoesDesconto()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeiDescColunaEditavelWhen - habilita edicao das colunas de
    * grd_4c_Gradei (Tipo/Codigo/Valor/Fator/Exclui) apenas em INCLUIR/
    * ALTERAR (equivalente ao When original de cada coluna)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE GradeiDescColunaEditavelWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeiDescColumn5Valid - valida coluna "E" (texclus): apenas S, N ou
    * vazio (equivalente ao legado)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE GradeiDescColumn5Valid()
        LOCAL loc_oText, loc_cValor

        loc_oText = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradei.Column5.Text1
        loc_cValor = UPPER(ALLTRIM(loc_oText.Value))

        IF !INLIST(loc_cValor, "S", "N", "")
            MsgAviso("Dados Inv" + CHR(225) + "lidos. Informe [S/N/ ]", "")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeiDescCodigoKeyPress / GradeiDescCodigoDblClick - F4/DblClick para
    * lookup do codigo da linha de composicao (Column2), conforme o Tipo
    * (Column1) selecionado na mesma linha
    * PUBLIC: BINDEVENT requer metodo publico + parametros do evento
    *--------------------------------------------------------------------------
    PROCEDURE GradeiDescCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupCodigoComposicao()
        ENDIF
    ENDPROC

    PROCEDURE GradeiDescCodigoDblClick()
        THIS.AbrirLookupCodigoComposicao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCodigoComposicao - Busca o codigo da linha corrente de
    * grd_4c_Gradei (cursor_4c_Tdt.codtips) na tabela correspondente ao
    * Tipo (cursor_4c_Tdt.tipos), igual ao Do Case do legado:
    * 1=Grupo(SigCdGrp/cgrus) 2=Linha(SigCdLin/linhas) 3=Gr.Venda(SigCdCol/
    * colecoes) 4=Produto(SigCdPro/cpros) 5=Moeda(SigCdMoe/cmoes)
    * 6=Unidade(SigCdUni/cunis) 7=Feitio(SigPrFti/cods) 8=SubGrupo(SigCdPsg/
    * codigos) 9=Finalidade(SigCdFip/cods)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCodigoComposicao()
        LOCAL loc_oGradei, loc_nTipos, loc_cTabela, loc_cCampo, loc_cDescCampo, ;
              loc_cTitulo, loc_cValor, loc_oBusca

        IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
            RETURN
        ENDIF

        loc_oGradei = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradei
        loc_nTipos  = cursor_4c_Tdt.tipos
        loc_cValor  = ALLTRIM(cursor_4c_Tdt.codtips)

        DO CASE
            CASE loc_nTipos = 1
                loc_cTabela = "SigCdGrp"  && Grupo
                loc_cCampo = "cgrus"
                loc_cDescCampo = "dgrus"
                loc_cTitulo = "Grupos"
            CASE loc_nTipos = 2
                loc_cTabela = "SigCdLin"  && Linha
                loc_cCampo = "linhas"
                loc_cDescCampo = "descs"
                loc_cTitulo = "Linhas"
            CASE loc_nTipos = 3
                loc_cTabela = "SigCdCol"  && Gr. Venda
                loc_cCampo = "colecoes"
                loc_cDescCampo = "descs"
                loc_cTitulo = "Grupos de Venda"
            CASE loc_nTipos = 4
                loc_cTabela = "SigCdPro"  && Produto
                loc_cCampo = "cpros"
                loc_cDescCampo = "dpros"
                loc_cTitulo = "Produtos"
            CASE loc_nTipos = 5
                loc_cTabela = "SigCdMoe"  && Moeda
                loc_cCampo = "cmoes"
                loc_cDescCampo = "dmoes"
                loc_cTitulo = "Moedas"
            CASE loc_nTipos = 6
                loc_cTabela = "SigCdUni"  && Unidade
                loc_cCampo = "cunis"
                loc_cDescCampo = "dunis"
                loc_cTitulo = "Unidade"
            CASE loc_nTipos = 7
                loc_cTabela = "SigPrFti"  && Feitio
                loc_cCampo = "cods"
                loc_cDescCampo = "descs"
                loc_cTitulo = "Feitio"
            CASE loc_nTipos = 8
                loc_cTabela = "SigCdPsg"  && SubGrupo
                loc_cCampo = "codigos"
                loc_cDescCampo = "descricaos"
                loc_cTitulo = "Sub-Grupos"
            CASE loc_nTipos = 9
                loc_cTabela = "SigCdFip"  && Finalidade
                loc_cCampo = "cods"
                loc_cDescCampo = "descs"
                loc_cTitulo = "Finalidade"
            OTHERWISE
                MsgAviso("Selecione o Tipo antes de buscar o C" + CHR(243) + "digo.", "")
                RETURN
        ENDCASE

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                loc_cTabela, "cursor_4c_BuscaComposicao", loc_cCampo, loc_cValor, ;
                loc_cTitulo)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna(loc_cCampo, "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna(loc_cDescCampo, "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaComposicao")
                    SELECT cursor_4c_BuscaComposicao
                    REPLACE codtips WITH ALLTRIM(EVALUATE("cursor_4c_BuscaComposicao." + loc_cCampo)) IN cursor_4c_Tdt
                    loc_oGradei.Refresh()
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTbv.AbrirLookupCodigoComposicao")
        ENDTRY

        IF USED("cursor_4c_BuscaComposicao")
            USE IN cursor_4c_BuscaComposicao
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirComposicaoClick - Inclui uma nova linha de composicao
    * (cursor_4c_Tdt) para o codigo corrente
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirComposicaoClick()
        LOCAL loc_oPgDesc

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt")
            RETURN
        ENDIF

        loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto

        INSERT INTO cursor_4c_Tdt (codigos) VALUES (ALLTRIM(THIS.this_oBusinessObject.this_cCodigo))
        REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
        REPLACE regs WITH 1 IN cursor_4c_Tdt

        loc_oPgDesc.grd_4c_Gradei.Refresh()
        THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
        loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
        THIS.MontarComissoesDesconto()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirComposicaoClick - Remove a linha corrente de composicao
    * (cursor_4c_Tdt); bloqueia se ainda houver comissoes vinculadas
    * (equivalente ao legado - "Exclua primeiro as comissoes...")
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirComposicaoClick()
        LOCAL loc_oPgDesc

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
            RETURN
        ENDIF

        THIS.MontarComissoesDesconto()
        IF USED("cursor_4c_Tdi") AND !EOF("cursor_4c_Tdi")
            MsgAviso("Imposs" + CHR(237) + "vel excluir!!! Exclua primeiro as comiss" + CHR(245) + "es...", "")
            RETURN
        ENDIF

        loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto

        SELECT cursor_4c_Tdt
        DELETE
        GO BOTTOM IN cursor_4c_Tdt
        IF !EOF("cursor_4c_Tdt")
            REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
            REPLACE regs WITH 1 IN cursor_4c_Tdt
        ENDIF

        loc_oPgDesc.grd_4c_Gradei.Refresh()
        THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
        loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
        THIS.MontarComissoesDesconto()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirComissaoClick - Inclui uma nova comissao (cursor_4c_Tdi)
    * para a linha corrente de composicao (Tipo/Codigo)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirComissaoClick()
        LOCAL loc_oPgDesc

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") ;
                OR EOF("cursor_4c_Tdt") OR !USED("cursor_4c_Tdi")
            RETURN
        ENDIF

        loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto

        INSERT INTO cursor_4c_Tdi (codigos, tipos, codtips) VALUES ;
            (ALLTRIM(THIS.this_oBusinessObject.this_cCodigo), cursor_4c_Tdt.tipos, ALLTRIM(cursor_4c_Tdt.codtips))

        THIS.MontarComissoesDesconto()
        loc_oPgDesc.grd_4c_Gradec.Column1.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirComissaoClick - Remove a comissao corrente (cursor_4c_Tdi)
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirComissaoClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
            RETURN
        ENDIF

        SELECT cursor_4c_Tdi
        DELETE
        GO BOTTOM IN cursor_4c_Tdi

        THIS.MontarComissoesDesconto()
        THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec.Column1.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * GradecColumn1Valid / GradecColumn2Valid - Grupo/Conta da comissao.
    * Simplificado em relacao ao legado: NAO reproduz as checagens de
    * acesso contabil (fAcessoContab/fAcessoContas do Framework legado -
    * fora do escopo desta migracao). Column2 (Conta) valida contra
    * SigCdCli e preenche automaticamente o Grupo quando vazio.
    * PUBLIC: BINDEVENT requer metodo publico
    *--------------------------------------------------------------------------
    PROCEDURE GradecColumn1Valid()
        RETURN .T.
    ENDPROC

    PROCEDURE GradecColumn2Valid()
        LOCAL loc_oGradec, loc_cConta, loc_cSQL

        IF !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
            RETURN .T.
        ENDIF

        loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec
        loc_cConta  = ALLTRIM(loc_oGradec.Column2.Text1.Value)

        IF EMPTY(loc_cConta)
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "SELECT iclis, grupos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") < 1 OR !USED("cursor_4c_BuscaConta") OR EOF("cursor_4c_BuscaConta")
                MsgAviso("Conta Inv" + CHR(225) + "lida !!!", "Acesso Negado")
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
                loc_lResultado = .F.
            ENDIF

            REPLACE contas WITH loc_cConta IN cursor_4c_Tdi
            IF EMPTY(ALLTRIM(cursor_4c_Tdi.grupos))
                REPLACE grupos WITH ALLTRIM(TratarNulo(cursor_4c_BuscaConta.grupos, "C")) IN cursor_4c_Tdi
            ENDIF
            loc_oGradec.Refresh()
        CATCH TO loException
            MostrarErro(loException, "FormTbv.GradecColumn2Valid")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles do container visiveis (recursivo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            *-- Containers com visibilidade condicional (controlada por
            *-- outra logica do form - ex: tipo de desconto 11 mostra
            *-- cnt_4c_Container1, PgDesconto/PgConfDesconto so aparecem
            *-- nas abas de composicao/configuracao) NAO podem ser
            *-- forcados a Visible=.T. aqui
            IF PEMSTATUS(loc_oControl, "Visible", 5) ;
                    AND !INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO", "CNT_4C_CONTAINER1", "CNT_4C_PGDESCONTO", "CNT_4C_PGCONFDESCONTO")
                loc_oControl.Visible = .T.
            ENDIF

            *-- Trata PageFrame - itera Pages
            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                LOCAL loc_nP
                FOR loc_nP = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                ENDFOR
            ENDIF

            *-- Trata containers com ControlCount
            IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberacao de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_TipoDesconto")
                USE IN cursor_4c_TipoDesconto
            ENDIF
            IF USED("cursor_4c_Empresas")
                USE IN cursor_4c_Empresas
            ENDIF
            IF USED("cursor_4c_Tdt")
                USE IN cursor_4c_Tdt
            ENDIF
            IF USED("cursor_4c_Tdi")
                USE IN cursor_4c_Tdi
            ENDIF
            IF USED("cursor_4c_Tds")
                USE IN cursor_4c_Tds
            ENDIF
            IF USED("cursor_4c_DiaSemana")
                USE IN cursor_4c_DiaSemana
            ENDIF
        CATCH TO loException
            *-- Ignorar erros na destruicao
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE

