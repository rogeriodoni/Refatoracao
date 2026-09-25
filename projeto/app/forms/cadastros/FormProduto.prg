*==============================================================================
* FormProduto.prg - Formulario de Cadastro de Produtos
* Migrado de: sigcdpro.SCX (frmcadastro)
*
* ESTRUTURA DE NAVEGACAO (transcrita do legado - Erro178):
*   pgf_4c_Paginas  (externo)  Page1 = Lista / Page2 = Dados
*   pgf_4c_Divisoes (interno, dentro da Page2) 8 abas SEM barra de abas
*   opt_4c_Navegacao (OptionGroup de 8 botoes graficos) e quem troca de aba
*
* O legado esconde as abas do PageFrame interno empurrando-o para cima
* (pgframeDados.Top = -58, altura da barra de 2 linhas de abas = 58). Aqui a
* barra e desligada (Tabs = .F.) e o Top compensa os mesmos 58 pixels, de forma
* que os controles das abas usam as coordenadas do layout.json SEM deslocamento.
*==============================================================================

DEFINE CLASS FormProduto AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: valores EXATOS do SCX legado)
    Height      = 600
    Width       = 1010
    Caption     = "Cadastro de Produtos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- DataSession = 2 (sessao privada, igual ao legado). FormBase.Init()
    *-- reaplica SET DATE BRITISH / SET CENTURY ON, que a sessao privada reseta.
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject      = .NULL.
    this_cModoAtual           = "LISTA"
    this_nDivisaoAtual        = 1        && Aba ativa do pgf_4c_Divisoes (1..8)
    this_cUltimoGrupoValidado = ""       && Guarda de reentrancia do filtro de grupo (regra #45)

    *-- ThisForm.Tipo2 do legado: quando .T. a tela opera sobre SigCdPrc
    *-- (produtos de custo) em vez de SigCdPro. O legado recebe isso pelo 3o
    *-- parametro do Init (prTp2); o form migrado abre sempre pelo menu, logo
    *-- .F. - a property existe para o Do Case da busca por exemplo continuar
    *-- com a MESMA estrutura do msv_procurar.
    this_lTipo2               = .F.

    *===========================================================================
    * Init - Inicializa o formulario
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Cria o Business Object e monta a estrutura visual
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loException
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar ProdutoBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormProduto.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1

                THIS.this_cModoAtual    = "LISTA"
                THIS.this_nDivisaoAtual = 1

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormProduto.InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - PageFrame externo: Page1 (Lista) e Page2 (Dados)
    * Legado: Pagina.Top = -24 / Height = 635 / Width = 1013 (abas escondidas)
    * Canonico do projeto: Top = -29 e Tabs = .F.; controles das Pages compensam
    * +29 no Top (o resultado absoluto e identico ao do legado).
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
    * ConfigurarPaginaLista - Page1: cabecalho, containers de botoes, filtros e
    * a grade de produtos.
    * Geometria legada (Pagina.Lista, +29 de compensacao do PageFrame externo):
    *   cntSombra   Top=1   Left=-1  Width=1012 Height=80
    *   Grupo_op    Top=-1  Left=552 Width=385  Height=85
    *   Grupo_Saida Top=-1  Left=927 (padrao canonico prevalece - CLAUDE.md #10)
    *   cntFiltros  Top=93  Left=31  Width=388  Height=63
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Faixa cinza do cabecalho: PRIMEIRO AddObject da pagina (CLAUDE.md #11)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 30
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

        *-- Container dos botoes CRUD (Grupo_op legado). Left canonico 542:
        *-- os 5 botoes (5/80/155/230/305 x 75) terminam em 922, exatamente
        *-- onde comeca o botao Encerrar do cnt_4c_Saida (917 + 5).
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top           = 29
            .Left          = 542
            .Width         = 390
            .Height        = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305). NAO abre picker (Erro167/Erro177): o legado
        *-- (PROCEDURE msv_procurar) faz busca POR EXEMPLO na propria pagina de
        *-- Dados, com os campos plProcurar editaveis - ver ADENDO de Erro178.
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida - padrao canonico (CLAUDE.md #10) prevalece
        *-- sobre o SCX legado (Grupo_Saida.Left = 927).
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top           = 29
            .Left          = 917
            .Width         = 90
            .Height        = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Botao Encerrar - padrao canonico (Caption="Encerrar", 75x75)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container dos filtros da lista (cntFiltros legado: grupo de produto,
        *-- faixa de datas de ultima alteracao e situacao Geral/Ativos/Inativos).
        *-- Regra #35 do CLAUDE.md: o filtro eh aplicado SEMPRE - com o grupo
        *-- vazio a lista abre vazia de proposito, esperando o usuario escolher.
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top           = 122
            .Left          = 31
            .Width         = 388
            .Height        = 63
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Grupo", "Label")
            WITH .lbl_4c_Grupo
                .Caption   = "Grupo de Produto :"
                .Top       = 10
                .Left      = 19
                .Width     = 94
                .Height    = 15
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Cgru", "TextBox")
            WITH .txt_4c_Cgru
                .Top       = 6
                .Left      = 116
                .Width     = 31
                .Height    = 23
                .MaxLength = 3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
            BINDEVENT(.txt_4c_Cgru, "KeyPress", THIS, "ValidarGrupoFiltro")

            .AddObject("txt_4c_Dgru", "TextBox")
            WITH .txt_4c_Dgru
                .Top       = 6
                .Left      = 149
                .Width     = 156
                .Height    = 23
                .MaxLength = 20
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
            BINDEVENT(.txt_4c_Dgru, "KeyPress", THIS, "ValidarGrupoPorDescricao")

            .AddObject("lbl_4c_UltimaAlteracao", "Label")
            WITH .lbl_4c_UltimaAlteracao
                .Caption   = "" + CHR(218) + "ltima Altera" + CHR(231) + CHR(227) + "o :"
                .Top       = 35
                .Left      = 26
                .Width     = 87
                .Height    = 15
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_DtIni", "TextBox")
            WITH .txt_4c_DtIni
                .Top      = 31
                .Left     = 116
                .Width    = 78
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Value    = {^1900-01-01}
                .Visible  = .T.
            ENDWITH
            BINDEVENT(.txt_4c_DtIni, "LostFocus", THIS, "RecarregarListaFiltrada")

            .AddObject("lbl_4c_Ate", "Label")
            WITH .lbl_4c_Ate
                .Caption   = "at" + CHR(233)
                .Top       = 35
                .Left      = 202
                .Width     = 18
                .Height    = 15
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_DtFim", "TextBox")
            WITH .txt_4c_DtFim
                .Top      = 31
                .Left     = 225
                .Width    = 78
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Value    = {^2900-12-31}
                .Visible  = .T.
            ENDWITH
            BINDEVENT(.txt_4c_DtFim, "LostFocus", THIS, "RecarregarListaFiltrada")

            .AddObject("opt_4c_FilSituas", "OptionGroup")
            WITH .opt_4c_FilSituas
                .ButtonCount = 3
                .Top         = 6
                .Left        = 308
                .Width       = 78
                .Height      = 46
                .BackStyle   = 0
                .Value       = 1
                .Visible     = .T.
            ENDWITH
            WITH .opt_4c_FilSituas.Buttons(1)
                .Caption   = "Geral"
                .Top       = 2
                .Left      = 2
                .Width     = 70
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH .opt_4c_FilSituas.Buttons(2)
                .Caption   = "Ativos"
                .Top       = 17
                .Left      = 2
                .Width     = 70
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH .opt_4c_FilSituas.Buttons(3)
                .Caption   = "Inativos"
                .Top       = 32
                .Left      = 2
                .Width     = 70
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            BINDEVENT(.opt_4c_FilSituas, "InteractiveChange", THIS, "RecarregarListaFiltrada")
        ENDWITH

        *-- Grade de produtos (Grade legada). Left=26/Width=860 nao sobrepoe o
        *-- cnt_4c_Saida (Left=917). Colunas conforme pColuna do legado
        *-- (regra #35 do CLAUDE.md - o header vem do runtime, nao do SCX).
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas)
        loc_oPagina.grd_4c_Dados.ColumnCount = 7
        WITH loc_oPagina.grd_4c_Dados
            .Top                = 195
            .Left               = 26
            .Width              = 860
            .Height             = 400
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
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .Visible            = .T.
        ENDWITH

        *-- Coluna 7 (checkbox "I" = Inativo): AddObject + CurrentControl
        *-- obrigatorios para o controle aparecer (regra #18 do CLAUDE.md).
        loc_oPagina.grd_4c_Dados.Column7.AddObject("chk_4c_Inativo", "CheckBox")
        WITH loc_oPagina.grd_4c_Dados.Column7
            .CurrentControl = "chk_4c_Inativo"
            .Sparse         = .F.
            .ReadOnly       = .T.
            .chk_4c_Inativo.Enabled = .F.
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GridDadosAfterRowColChange")

        *-- Rodape: contador de produtos selecionados/listados (lblProdutos legado)
        loc_oPagina.AddObject("lbl_4c_Produtos", "Label")
        WITH loc_oPagina.lbl_4c_Produtos
            .Caption   = "Produtos Selecionados : 0"
            .Top       = 600
            .Left      = 35
            .Width     = 250
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Consulta a grade de produtos com os filtros atuais
    * Regra #2 (docs/FORMCOR_LICOES_APRENDIDAS.md): headers SEMPRE redefinidos
    * DEPOIS do RecordSource, que os reseta.
    *===========================================================================
    *-- PUBLIC: o TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA
    *-- da classe. PEMSTATUS(...,5) devolve .T. mesmo para PROTECTED, entao o
    *-- harness entraria no branch e a chamada estouraria em runtime
    *-- ("Property CARREGARLISTA is not found") - CLAUDE.md regra #3.
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_oFiltros, loc_cGrupo, loc_dDtIni, ;
            loc_dDtFim, loc_nSituacao, loException
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oFiltros  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
                loc_cGrupo    = ALLTRIM(loc_oFiltros.txt_4c_Cgru.Value)
                loc_dDtIni    = loc_oFiltros.txt_4c_DtIni.Value
                loc_dDtFim    = loc_oFiltros.txt_4c_DtFim.Value
                loc_nSituacao = loc_oFiltros.opt_4c_FilSituas.Value

                IF !THIS.this_oBusinessObject.BuscarLista(loc_cGrupo, loc_dDtIni, loc_dDtFim, loc_nSituacao)
                    loc_lResultado = .F.
                ELSE
                    *-- Bind, larguras e headers ficam em VincularGradeLista
                    *-- (o mesmo bloco eh usado pela busca por exemplo, que
                    *-- popula cursor_4c_Dados por outro caminho).
                    THIS.VincularGradeLista()

                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista de produtos:" + CHR(13) + ;
                loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormProduto.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AtualizarContadorProdutos - Atualiza o rotulo "Produtos Selecionados"
    *===========================================================================
    PROTECTED PROCEDURE AtualizarContadorProdutos()
        LOCAL loc_nTotal
        loc_nTotal = 0

        IF USED("cursor_4c_Dados")
            loc_nTotal = RECCOUNT("cursor_4c_Dados")
        ENDIF

        THIS.pgf_4c_Paginas.Page1.lbl_4c_Produtos.Caption = ;
            "Produtos Selecionados : " + TRANSFORM(loc_nTotal)
    ENDPROC

    *===========================================================================
    * GridDadosAfterRowColChange - Handler de BINDEVENT (regra #38 - precisa
    * declarar o parametro do evento, senao "No PARAMETER statement is found")
    *===========================================================================
    PROCEDURE GridDadosAfterRowColChange(par_nColIndex)
        THIS.AtualizarContadorProdutos()
    ENDPROC

    *===========================================================================
    * RecarregarListaFiltrada - Handler de LostFocus/InteractiveChange dos
    * campos de filtro (data inicial/final, situacao) - regra #31 do CLAUDE.md
    *===========================================================================
    PROCEDURE RecarregarListaFiltrada()
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * ValidarGrupoFiltro - LostFocus de txt_4c_Cgru (filtro de grupo por codigo)
    * Transcricao do getCgru.Valid do legado: busca exata em SigCdGrp; se nao
    * achar, abre o picker (FormBuscaAuxiliar Modo 1) para o usuario escolher.
    * Regra #45: so revalida se o valor realmente mudou.
    *===========================================================================
    PROCEDURE ValidarGrupoFiltro(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oFiltros, loc_cValor, loc_oBusca, loException
        loc_oFiltros = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
        loc_cValor   = PADR(ALLTRIM(loc_oFiltros.txt_4c_Cgru.Value), 3)

        IF loc_cValor == THIS.this_cUltimoGrupoValidado
            RETURN
        ENDIF
        THIS.this_cUltimoGrupoValidado = loc_cValor

        IF EMPTY(loc_cValor)
            loc_oFiltros.txt_4c_Dgru.Value = ""
            THIS.CarregarLista()
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrpFiltro", "cgrus", loc_cValor, ;
                "Grupo de Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFiltro")
                    SELECT cursor_4c_BuscaGrpFiltro
                    loc_oFiltros.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus)
                    loc_oFiltros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.dgrus)
                    THIS.this_cUltimoGrupoValidado = PADR(ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus), 3)
                ELSE
                    loc_oFiltros.txt_4c_Cgru.Value = ""
                    loc_oFiltros.txt_4c_Dgru.Value = ""
                    THIS.this_cUltimoGrupoValidado = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrpFiltro")
                USE IN cursor_4c_BuscaGrpFiltro
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar o grupo de produto:" + CHR(13) + ;
                loException.Message, "FormProduto.ValidarGrupoFiltro")
        ENDTRY

        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * ValidarGrupoPorDescricao - LostFocus de txt_4c_Dgru (filtro de grupo por
    * descricao) - mesmo padrao de ValidarGrupoFiltro, buscando por dgrus.
    *===========================================================================
    PROCEDURE ValidarGrupoPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oFiltros, loc_cValor, loc_oBusca, loException
        loc_oFiltros = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
        loc_cValor   = ALLTRIM(loc_oFiltros.txt_4c_Dgru.Value)

        IF EMPTY(loc_cValor) OR !EMPTY(ALLTRIM(loc_oFiltros.txt_4c_Cgru.Value))
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrpFiltro", "dgrus", loc_cValor, ;
                "Grupo de Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFiltro")
                    SELECT cursor_4c_BuscaGrpFiltro
                    loc_oFiltros.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus)
                    loc_oFiltros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_BuscaGrpFiltro.dgrus)
                    THIS.this_cUltimoGrupoValidado = PADR(ALLTRIM(cursor_4c_BuscaGrpFiltro.cgrus), 3)
                ELSE
                    loc_oFiltros.txt_4c_Dgru.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrpFiltro")
                USE IN cursor_4c_BuscaGrpFiltro
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar o grupo de produto:" + CHR(13) + ;
                loException.Message, "FormProduto.ValidarGrupoPorDescricao")
        ENDTRY

        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para a Lista, repoe o modo e recarrega a grade (regra #40 do
    * CLAUDE.md - sem isso os botoes/estado ficam desatualizados).
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado, loException
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                *-- Regra #40 (Erro176): quem desabilita os botoes CRUD ao
                *-- entrar em edicao TEM de reabilita-los no funil de volta.
                *-- Fica aqui, no funil, e nao em cada caller.
                THIS.AjustarBotoesPorModo()

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "FormProduto.AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara o BO para um novo produto e abre a pagina Dados
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()

        *-- Modo ANTES de HabilitarCampos (Problema 19): o metodo decide a
        *-- edicao do codigo/chave a partir de this_cModoAtual.
        THIS.this_cModoAtual = "INCLUIR"

        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.IrParaDivisao(1)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre o produto selecionado na grade em modo leitura
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um produto para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                THIS.IrParaDivisao(1)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre o produto selecionado na grade em modo alteracao
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um produto para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                THIS.IrParaDivisao(1)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o produto selecionado na grade, com confirmacao
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um produto para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto [" + ;
                        loc_cCodigo + "]?", "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Produto exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Busca POR EXEMPLO (NAO eh picker - Erro167/Erro177).
    * O legado (PROCEDURE msv_procurar) abre a propria pagina de Dados com os
    * campos plProcurar editaveis (getCpro, getDpro, getDpro2s, getRefs,
    * Getifor, getCbar, getconjunto) e o Confirmar executa o Do Case do
    * msv_procurar. Os campos da pgDados e o Confirmar entram numa fase
    * posterior (Pagina Dados Principais) - aqui o form entra no modo BUSCAR
    * e abre a pagina de Dados em branco, pronta para o usuario digitar.
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.this_oBusinessObject.NovoRegistro()

        *-- Modo ANTES de HabilitarCampos: em PROCURAR so os 7 campos
        *-- plProcurar do legado ficam editaveis (ver HabilitarCampos).
        THIS.this_cModoAtual = "BUSCAR"

        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.IrParaDivisao(1)

        MsgInfo("Informe um ou mais campos e clique em Confirmar para procurar." + ;
            CHR(13) + "Campos de procura: Produto, Descri" + CHR(231) + CHR(227) + "o, " + ;
            "Descritivo, Ref. Fornecedor," + CHR(13) + "Fornecedor, Barra e Cod. Pai.", ;
            "Procurar Produto")
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2: faixa, PageFrame interno de 8 abas,
    * barra de navegacao (OptionGroup) e container Confirmar/Cancelar
    *
    * Ordem dos AddObject (importa para o Z-ORDER):
    *   1) cnt_4c_Cabecalho  - faixa cinza, primeiro objeto da pagina (#11/#195)
    *   2) pgf_4c_Divisoes   - cobre a pagina inteira e pinta sobre a faixa,
    *                          reproduzindo o visual do legado (que nao tem faixa
    *                          nesta pagina) sem esconder os botoes que as abas
    *                          possuem no topo (cmdProduto/cmdArquivos, Top=38)
    *   3) opt_4c_Navegacao  - barra de abas grafica, POR CIMA do PageFrame
    *   4) cnt_4c_BotoesAcao - Confirmar / Cancelar, POR CIMA do PageFrame
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Faixa cinza do cabecalho (CLAUDE.md #11 - nas DUAS paginas)
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

        *-- PageFrame interno de 8 abas (pgframeDados legado)
        *-- Legado: Top=-58, Left=3, Width=1009, Height=656, com as abas em
        *-- 2 linhas de 29 px empurradas para fora da area util.
        *-- Aqui: Tabs = .F. e Top = -58 + 58 (barra) + 29 (PageFrame externo),
        *-- Height = 656 - 58. A origem do conteudo cai no mesmo pixel do legado,
        *-- por isso os controles das abas usam o Top do layout.json direto.
        loc_oPagina.AddObject("pgf_4c_Divisoes", "PageFrame")
        WITH loc_oPagina.pgf_4c_Divisoes
            .PageCount = 8
            .Top       = 29
            .Left      = 3
            .Width     = 1009
            .Height    = 598
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        WITH loc_oPagina.pgf_4c_Divisoes
            *-- Captions transcritos do SCX (PageOrder 1..8 = ordem declarada).
            *-- Com Tabs = .F. eles nao aparecem; ficam fieis ao legado.
            .Page1.Caption   = "Dados Principais"      && pgDados
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.ForeColor = RGB(36, 84, 155)
            .Page1.FontBold  = .T.

            .Page2.Caption   = "Custos"                && pgComposicao
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.BackColor = RGB(240, 240, 240)
            .Page2.ForeColor = RGB(36, 84, 155)
            .Page2.FontName  = "Verdana"
            .Page2.FontSize  = 8
            .Page2.FontBold  = .T.

            .Page3.Caption   = "Dados Fiscais"         && pgDadosFiscais
            .Page3.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page3.BackColor = RGB(255, 255, 255)
            .Page3.ForeColor = RGB(36, 84, 155)
            .Page3.FontName  = "Verdana"
            .Page3.FontSize  = 8
            .Page3.FontBold  = .T.

            .Page4.Caption   = "Processos"             && PgDadosFaseP
            .Page4.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page4.BackColor = RGB(255, 255, 255)
            .Page4.ForeColor = RGB(36, 84, 155)
            .Page4.FontName  = "Verdana"
            .Page4.FontSize  = 8
            .Page4.FontBold  = .T.

            .Page5.Caption   = "Consumo"               && PgDadosConsP
            .Page5.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page5.BackColor = RGB(255, 255, 255)
            .Page5.ForeColor = RGB(36, 84, 155)
            .Page5.FontName  = "Verdana"
            .Page5.FontSize  = 8
            .Page5.FontBold  = .T.

            .Page6.Caption   = "Composi" + CHR(231) + CHR(227) + "o"   && pgCusto
            .Page6.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page6.BackColor = RGB(255, 255, 255)
            .Page6.ForeColor = RGB(36, 84, 155)
            .Page6.FontName  = "Verdana"
            .Page6.FontSize  = 8
            .Page6.FontBold  = .T.

            *-- Caption "Page1" e o texto original do SCX nesta aba (Designer)
            .Page7.Caption   = "Page1"                 && pgDesigner
            .Page7.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page7.BackColor = RGB(255, 255, 255)

            .Page8.Caption   = "Servi" + CHR(231) + "os"               && pgServico
            .Page8.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page8.BackColor = RGB(255, 255, 255)

            .ActivePage = 1
        ENDWITH

        *-- Campos da aba "Dados Principais" (pgDados legado - 176 controles).
        *-- FASE 5/8: primeira metade (identificacao, grupo/subgrupo/linha/
        *-- colecao, unidade, EAN/GTIN, fornecedor, modelo, moedas). A segunda
        *-- metade (memos, dimensoes, site/segmento, lancamento) entra na Fase 6.
        THIS.ConfigurarAbaDadosPrincipais(loc_oPagina.pgf_4c_Divisoes.Page1)

        *-- Campos da aba "Componente" (pgComposicao legado - grades de
        *-- materiais/subcomponentes e blocos de calculo de preco - FASE 9)
        THIS.ConfigurarPgpgComposicao()

        *-- Campos da aba "Composicao" (pgCusto legado - visao por Tipo da
        *-- mesma grade de componentes + resumo por grupo - FASE 10)
        THIS.ConfigurarPgpgCusto()

        *-- Campos da aba "Dados Fiscais" (pgDadosFiscais legado -
        *-- classificacao fiscal, ICMS/IPI, conta contabil, CMV - FASE 13)
        THIS.ConfigurarPgpgDadosFiscais()

        *-- Campos da aba "Processos" (PgDadosFaseP legado - grade de fases
        *-- do processo + grade de matrizes + campos de acabamento/cor/
        *-- tamanho/peso/garantia/ultima compra - FASE 12)
        THIS.ConfigurarPgPgDadosFaseP()

        *-- Campos da aba "Consumo" (PgDadosConsP legado - grade de consumo
        *-- dos componentes + tempo de producao por agrupamento - FASE 11)
        THIS.ConfigurarPgPgDadosConsP()

        *-- Campos da aba "Designer" (pgDesigner legado - grade de tarefas,
        *-- grade de arquivos anexados, inspiracao e dados do lancamento -
        *-- FASE 14)
        THIS.ConfigurarPgpgDesigner()

        *-- Campos da aba "Servicos" (pgServico legado - grade de servicos
        *-- vinculados ao produto com checkbox de marcacao - FASE 15)
        THIS.ConfigurarPgpgServico()

        THIS.ConfigurarNavegacaoDivisoes(loc_oPagina)

        *-- Container Confirmar / Cancelar (Grupo_Salva legado: Top=2, Left=848,
        *-- Height=85, com Salva em Left=5 e Cancelar em Left=80)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top           = 31
            .Left          = 848
            .Width         = 160
            .Height        = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Botao Confirmar (Salva legado: Left=5 dentro do Grupo_Salva)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Cancelar legado: Left=80 dentro do Grupo_Salva)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Z-ORDER: navegacao e botoes de acao sempre na frente do PageFrame
        loc_oPagina.opt_4c_Navegacao.ZOrder(0)
        loc_oPagina.cnt_4c_BotoesAcao.ZOrder(0)

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarAbaDadosPrincipais - Campos da aba "Principal" (pgDados legado)
    * dentro de pgf_4c_Divisoes.Page1. Posicoes/Top/Left saem DIRETO do
    * layout.json (sem compensacao adicional - ver comentario em
    * ConfigurarPaginaDados sobre o calculo do PageFrame interno).
    *
    * FASE 5/8 - primeira metade dos 176 controles do legado (identificacao
    * do produto, grupo/subgrupo/linha/colecao, unidade, EAN/GTIN, fornecedor,
    * modelo, moedas de custo/venda, auditoria de inclusao/alteracao).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarAbaDadosPrincipais(par_oPagina)
        *-- Imagem principal do produto (shpFig / ImgFigJpg)
        par_oPagina.AddObject("shp_4c_ShpFig", "Shape")
        WITH par_oPagina.shp_4c_ShpFig
            .Top     = 505
            .Left    = 600
            .Width   = 174
            .Height  = 114
            .Visible = .T.
        ENDWITH

        par_oPagina.AddObject("img_4c_ImgFigJpg", "Image")
        WITH par_oPagina.img_4c_ImgFigJpg
            .Top      = 506
            .Left     = 601
            .Width    = 172
            .Height   = 112
            .Stretch  = 2
            .Visible  = .T.
        ENDWITH

        *-- Produto :  (Label2 - colide com Say2 "Equivalente :" no mapeamento
        *-- original; renomeado para lbl_4c_LblProduto - fix no mapeamento.json)
        par_oPagina.AddObject("lbl_4c_LblProduto", "Label")
        WITH par_oPagina.lbl_4c_LblProduto
            .Caption   = "Produto :"
            .Top       = 121
            .Left      = 47
            .Width     = 53
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Cpro", "TextBox")
        WITH par_oPagina.txt_4c_Cpro
            .Top       = 117
            .Left      = 102
            .Width     = 108
            .Height    = 22
            .MaxLength = 14
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Cpro, "KeyPress", THIS, "ValidarCodigoProdutoDados")

        par_oPagina.AddObject("txt_4c_Dpro", "TextBox")
        WITH par_oPagina.txt_4c_Dpro
            .Top       = 117
            .Left      = 211
            .Width     = 290
            .Height    = 22
            .MaxLength = 65
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Descritivo :  (getDPro2s)
        par_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH par_oPagina.lbl_4c_Label10
            .Caption   = "Descritivo :"
            .Top       = 144
            .Left      = 44
            .Width     = 56
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DPro2s", "TextBox")
        WITH par_oPagina.txt_4c_DPro2s
            .Top       = 140
            .Left      = 102
            .Width     = 399
            .Height    = 22
            .MaxLength = 45
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Barra :  (getCbar) + EAN13 (getEAN13) + Equivalente (Get_CProEq)
        par_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH par_oPagina.lbl_4c_Label15
            .Caption   = "Barra :"
            .Top       = 143
            .Left      = 595
            .Width     = 35
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Cbar", "TextBox")
        WITH par_oPagina.txt_4c_Cbar
            .Top       = 139
            .Left      = 633
            .Width     = 108
            .Height    = 23
            .InputMask = "99999999999999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPagina.lbl_4c_Label1
            .Caption   = "EAN13 :"
            .Top       = 167
            .Left      = 589
            .Width     = 41
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_EAN13", "TextBox")
        WITH par_oPagina.txt_4c_EAN13
            .Top       = 163
            .Left      = 633
            .Width     = 108
            .Height    = 23
            .InputMask = "9999999999999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH par_oPagina.lbl_4c_Label2
            .Caption   = "Equivalente :"
            .Top       = 120
            .Left      = 565
            .Width     = 65
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_CProEq", "TextBox")
        WITH par_oPagina.txt_4c_CProEq
            .Top       = 115
            .Left      = 633
            .Width     = 108
            .Height    = 23
            .MaxLength = 14
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_CProEq, "KeyPress", THIS, "ValidarProdutoEquivalente")

        *-- Grupo / Subgrupo / Linha / Colecao / Grupo de Venda (Mercs)
        par_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH par_oPagina.lbl_4c_Label8
            .Caption   = "Grupo :"
            .Top       = 190
            .Left      = 62
            .Width     = 38
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Cgru", "TextBox")
        WITH par_oPagina.txt_4c_Cgru
            .Top       = 186
            .Left      = 102
            .Width     = 31
            .Height    = 22
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Cgru, "KeyPress", THIS, "ValidarGrupoDadosPorCodigo")

        par_oPagina.AddObject("txt_4c_Dgru", "TextBox")
        WITH par_oPagina.txt_4c_Dgru
            .Top       = 186
            .Left      = 134
            .Width     = 171
            .Height    = 22
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Dgru, "KeyPress", THIS, "ValidarGrupoDadosPorDescricao")

        par_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH par_oPagina.lbl_4c_Label9
            .Caption   = "Subgrupo :"
            .Top       = 213
            .Left      = 45
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_CSGru", "TextBox")
        WITH par_oPagina.txt_4c_CSGru
            .Top       = 209
            .Left      = 102
            .Width     = 52
            .Height    = 22
            .MaxLength = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_CSGru, "KeyPress", THIS, "ValidarSubgrupoDadosPorCodigo")

        par_oPagina.AddObject("txt_4c_DsGru", "TextBox")
        WITH par_oPagina.txt_4c_DsGru
            .Top       = 209
            .Left      = 155
            .Width     = 150
            .Height    = 22
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_DsGru, "KeyPress", THIS, "ValidarSubgrupoDadosPorDescricao")

        par_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH par_oPagina.lbl_4c_Label16
            .Caption   = "Linha :"
            .Top       = 236
            .Left      = 66
            .Width     = 34
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Lin", "TextBox")
        WITH par_oPagina.txt_4c_Lin
            .Top       = 232
            .Left      = 102
            .Width     = 80
            .Height    = 22
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Lin, "KeyPress", THIS, "ValidarLinhaDadosPorCodigo")

        par_oPagina.AddObject("txt_4c_DLin", "TextBox")
        WITH par_oPagina.txt_4c_DLin
            .Top       = 232
            .Left      = 183
            .Width     = 196
            .Height    = 22
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_DLin, "KeyPress", THIS, "ValidarLinhaDadosPorDescricao")

        par_oPagina.AddObject("lbl_4c_Label17", "Label")
        WITH par_oPagina.lbl_4c_Label17
            .Caption   = "Grupo de Venda :"
            .Top       = 258
            .Left      = 14
            .Width     = 86
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Col", "TextBox")
        WITH par_oPagina.txt_4c_Col
            .Top       = 255
            .Left      = 102
            .Width     = 80
            .Height    = 22
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Col, "KeyPress", THIS, "ValidarColecaoDadosPorCodigo")

        par_oPagina.AddObject("txt_4c_DCol", "TextBox")
        WITH par_oPagina.txt_4c_DCol
            .Top       = 255
            .Left      = 183
            .Width     = 318
            .Height    = 22
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_DCol, "KeyPress", THIS, "ValidarColecaoDadosPorDescricao")

        *-- Grande Grupo (Mercs) - preenchido automaticamente pelo grupo
        par_oPagina.AddObject("txt_4c_Merc", "TextBox")
        WITH par_oPagina.txt_4c_Merc
            .Top       = 186
            .Left      = 307
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Classificacao (Get_Class) + Identificador (getIdeCPros)
        par_oPagina.AddObject("lbl_4c_LblClassificacao", "Label")
        WITH par_oPagina.lbl_4c_LblClassificacao
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
            .Top       = 397
            .Left      = -4
            .Width     = 104
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Class", "TextBox")
        WITH par_oPagina.txt_4c_Class
            .Top       = 393
            .Left      = 102
            .Width     = 31
            .Height    = 22
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Class, "KeyPress", THIS, "ValidarClassificacaoDados")

        par_oPagina.AddObject("lbl_4c_Label23", "Label")
        WITH par_oPagina.lbl_4c_Label23
            .Caption   = "Identificador :"
            .Top       = 213
            .Left      = 397
            .Width     = 70
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_IdeCPros", "TextBox")
        WITH par_oPagina.txt_4c_IdeCPros
            .Top       = 209
            .Left      = 470
            .Width     = 31
            .Height    = 22
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Fornecedor / Ref. Fornecedor
        par_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH par_oPagina.lbl_4c_Label11
            .Caption   = "Fornecedor :"
            .Top       = 305
            .Left      = 36
            .Width     = 64
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Ifor", "TextBox")
        WITH par_oPagina.txt_4c_Ifor
            .Top       = 301
            .Left      = 102
            .Width     = 80
            .Height    = 22
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Ifor, "KeyPress", THIS, "ValidarFornecedorDadosPorCodigo")

        par_oPagina.AddObject("txt_4c_Dfor", "TextBox")
        WITH par_oPagina.txt_4c_Dfor
            .Top       = 301
            .Left      = 183
            .Width     = 318
            .Height    = 22
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Dfor, "KeyPress", THIS, "ValidarFornecedorDadosPorDescricao")

        par_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH par_oPagina.lbl_4c_Label12
            .Caption   = "Ref. Fornecedor :"
            .Top       = 327
            .Left      = 12
            .Width     = 88
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Refs", "TextBox")
        WITH par_oPagina.txt_4c_Refs
            .Top       = 324
            .Left      = 102
            .Width     = 221
            .Height    = 22
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Bot_Fornecedor", "CommandGroup")
        WITH par_oPagina.obj_4c_Bot_Fornecedor
            .ButtonCount = 1
            .Top         = 323
            .Left        = 323
            .Width       = 27
            .Height      = 24
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Bot_Fornecedor.Buttons(1)
            .Caption = "..."
            .Top     = 0
            .Left    = 0
            .Width   = 27
            .Height  = 24
        ENDWITH

        *-- Modelo (getCodFinP / getDesFinP)
        par_oPagina.AddObject("lbl_4c_LblModelo", "Label")
        WITH par_oPagina.lbl_4c_LblModelo
            .Caption   = "Modelo :"
            .Top       = 351
            .Left      = -4
            .Width     = 104
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_CodFinP", "TextBox")
        WITH par_oPagina.txt_4c_CodFinP
            .Top       = 347
            .Left      = 102
            .Width     = 31
            .Height    = 22
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_CodFinP, "KeyPress", THIS, "ValidarModeloDadosPorCodigo")

        par_oPagina.AddObject("txt_4c_DesFinP", "TextBox")
        WITH par_oPagina.txt_4c_DesFinP
            .Top       = 347
            .Left      = 134
            .Width     = 150
            .Height    = 22
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_DesFinP, "KeyPress", THIS, "ValidarModeloDadosPorDescricao")

        *-- Unidade (1) / Unidade (2) - Get_Cuni/Get_Duni e Get_cunip/get_dunip
        par_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH par_oPagina.lbl_4c_Label14
            .Caption   = "Unidades (1) :"
            .Top       = 420
            .Left      = 30
            .Width     = 70
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Cuni", "TextBox")
        WITH par_oPagina.txt_4c_Cuni
            .Top       = 416
            .Left      = 102
            .Width     = 31
            .Height    = 22
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Cuni, "KeyPress", THIS, "ValidarUnidadeDadosPorCodigo")

        par_oPagina.AddObject("txt_4c_Duni", "TextBox")
        WITH par_oPagina.txt_4c_Duni
            .Top       = 416
            .Left      = 134
            .Width     = 150
            .Height    = 22
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Duni, "KeyPress", THIS, "ValidarUnidadeDadosPorDescricao")

        par_oPagina.AddObject("lbl_4c_Label18", "Label")
        WITH par_oPagina.lbl_4c_Label18
            .Caption   = "(2) :"
            .Top       = 420
            .Left      = 290
            .Width     = 23
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Cunip", "TextBox")
        WITH par_oPagina.txt_4c_Cunip
            .Top       = 416
            .Left      = 319
            .Width     = 31
            .Height    = 22
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Cunip, "KeyPress", THIS, "ValidarUnidadePedidoDadosPorCodigo")

        par_oPagina.AddObject("txt_4c__dunip", "TextBox")
        WITH par_oPagina.txt_4c__dunip
            .Top       = 416
            .Left      = 351
            .Width     = 150
            .Height    = 22
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c__dunip, "KeyPress", THIS, "ValidarUnidadePedidoDadosPorDescricao")

        *-- Local (Get_Local)
        par_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH par_oPagina.lbl_4c_Label5
            .Caption   = "Local :"
            .Top       = 397
            .Left      = 354
            .Width     = 33
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Local", "TextBox")
        WITH par_oPagina.txt_4c_Local
            .Top       = 393
            .Left      = 390
            .Width     = 111
            .Height    = 22
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Local, "KeyPress", THIS, "ValidarLocalDados")

        *-- Situacao (opc_situacao) - Ativo/Inativo (situas)
        par_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
        WITH par_oPagina.obj_4c_Opc_situacao
            .ButtonCount = 2
            .Top         = 114
            .Left        = 758
            .Width       = 160
            .Height      = 25
            .BackStyle   = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Opc_situacao.Buttons(1)
            .Caption   = "Ativo"
            .BackStyle = 0
            .Top       = 3
            .Left      = 2
            .Width     = 70
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH par_oPagina.obj_4c_Opc_situacao.Buttons(2)
            .Caption   = "Inativo"
            .BackStyle = 0
            .Top       = 3
            .Left      = 80
            .Width     = 70
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Observacoes livres (getObs1/getObs2/GetObs3)
        par_oPagina.AddObject("txt_4c_Obs1", "TextBox")
        WITH par_oPagina.txt_4c_Obs1
            .Top       = 235
            .Left      = 633
            .Width     = 159
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Obs2", "TextBox")
        WITH par_oPagina.txt_4c_Obs2
            .Top       = 259
            .Left      = 633
            .Width     = 159
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Obs3", "TextBox")
        WITH par_oPagina.txt_4c_Obs3
            .Top       = 211
            .Left      = 633
            .Width     = 80
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Valores/moedas de custo total, venda e fator de venda (calculados -
        *-- comportamento.json: When Return .f. em getCtotal/getPvenda/getFvenda)
        par_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH par_oPagina.lbl_4c_Label3
            .Caption   = "Valor de Custo :"
            .Top       = 311
            .Left      = 551
            .Width     = 79
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Ctotal", "TextBox")
        WITH par_oPagina.txt_4c_Ctotal
            .Top       = 307
            .Left      = 633
            .Width     = 127
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Mctotal", "TextBox")
        WITH par_oPagina.txt_4c_Mctotal
            .Top       = 307
            .Left      = 761
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Mctotal, "KeyPress", THIS, "ValidarMoedaCustoTotalDados")

        par_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH par_oPagina.lbl_4c_Label4
            .Caption   = "Valor de Venda :"
            .Top       = 335
            .Left      = 510
            .Width     = 120
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Pvenda", "TextBox")
        WITH par_oPagina.txt_4c_Pvenda
            .Top       = 331
            .Left      = 633
            .Width     = 127
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Mpvenda", "TextBox")
        WITH par_oPagina.txt_4c_Mpvenda
            .Top       = 331
            .Left      = 761
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Mpvenda, "KeyPress", THIS, "ValidarMoedaValorVendaDados")

        par_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH par_oPagina.lbl_4c_Label6
            .Caption   = "Fator  de Venda :"
            .Top       = 359
            .Left      = 544
            .Width     = 86
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Fvenda", "TextBox")
        WITH par_oPagina.txt_4c_Fvenda
            .Top       = 355
            .Left      = 633
            .Width     = 127
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Mfvenda", "TextBox")
        WITH par_oPagina.txt_4c_Mfvenda
            .Top       = 355
            .Left      = 761
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Mfvenda, "KeyPress", THIS, "ValidarMoedaFatorVendaDados")

        *-- Estoque (calculado - somente leitura)
        par_oPagina.AddObject("lbl_4c_Label28", "Label")
        WITH par_oPagina.lbl_4c_Label28
            .Caption   = "Estoque :"
            .Top       = 287
            .Left      = 582
            .Width     = 48
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Estoques", "TextBox")
        WITH par_oPagina.txt_4c_Estoques
            .Top       = 283
            .Left      = 633
            .Width     = 79
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_QtdEsts", "TextBox")
        WITH par_oPagina.txt_4c_QtdEsts
            .Top       = 283
            .Left      = 713
            .Width     = 79
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Origem :  (Say19 - label sem width no legado, "classe say" pura)
        par_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH par_oPagina.lbl_4c_Label19
            .Caption   = "Origem :"
            .Top       = 287
            .Left      = 798
            .Width     = 60
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Auditoria de Inclusao / Alteracao (somente leitura)
        par_oPagina.AddObject("lbl_4c_Label20", "Label")
        WITH par_oPagina.lbl_4c_Label20
            .Caption   = "Data / Usu" + CHR(225) + "rio"
            .Top       = 535
            .Left      = 827
            .Width     = 84
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH par_oPagina.shp_4c_Shape3
            .Top     = 550
            .Left    = 827
            .Width   = 161
            .Height  = 2
            .Visible = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label24", "Label")
        WITH par_oPagina.lbl_4c_Label24
            .Caption   = "Inclus" + CHR(227) + "o"
            .Top       = 554
            .Left      = 827
            .Width     = 42
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DtIncs", "TextBox")
        WITH par_oPagina.txt_4c_DtIncs
            .Top      = 569
            .Left     = 827
            .Width    = 79
            .Height   = 23
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Usuario", "TextBox")
        WITH par_oPagina.txt_4c_Usuario
            .Top      = 594
            .Left     = 827
            .Width    = 79
            .Height   = 23
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label25", "Label")
        WITH par_oPagina.lbl_4c_Label25
            .Caption   = "Altera" + CHR(231) + CHR(227) + "o"
            .Top       = 554
            .Left      = 907
            .Width     = 48
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DataAlts", "TextBox")
        WITH par_oPagina.txt_4c_DataAlts
            .Top      = 569
            .Left     = 907
            .Width    = 79
            .Height   = 23
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_UsuaAlts", "TextBox")
        WITH par_oPagina.txt_4c_UsuaAlts
            .Top      = 594
            .Left     = 907
            .Width    = 79
            .Height   = 23
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Complemento :  (Say30 - label do bloco de memos, continua na Fase 6)
        par_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH par_oPagina.lbl_4c_Label7
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 239
            .Left      = 563
            .Width     = 67
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label30", "Label")
        WITH par_oPagina.lbl_4c_Label30
            .Caption   = "Complemento :"
            .Top       = 263
            .Left      = 556
            .Width     = 74
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Botoes de figura/etiqueta/zoom/consulta produto - estruturais nesta
        *-- fase (Picture + posicao); acao de Click entra quando os subsistemas
        *-- de imagem/etiqueta forem migrados (fora do escopo desta Fase 5/8).
        par_oPagina.AddObject("obj_4c_CmdgFigura", "CommandGroup")
        WITH par_oPagina.obj_4c_CmdgFigura
            .ButtonCount = 1
            .Top         = 580
            .Left        = 775
            .Width       = 42
            .Height      = 41
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgFigura.Buttons(1)
            .Picture = gc_4c_CaminhoIcones + "geral_arquivo_26.jpg"
            .Top     = 0
            .Left    = 0
            .Width   = 42
            .Height  = 41
        ENDWITH

        par_oPagina.AddObject("obj_4c_CmdEtiquetas", "CommandGroup")
        WITH par_oPagina.obj_4c_CmdEtiquetas
            .ButtonCount = 1
            .Top         = 146
            .Left        = 744
            .Width       = 40
            .Height      = 40
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_CmdEtiquetas.Buttons(1)
            .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .Top     = 0
            .Left    = 0
            .Width   = 40
            .Height  = 40
        ENDWITH

        par_oPagina.AddObject("obj_4c_CmdZoom", "CommandGroup")
        WITH par_oPagina.obj_4c_CmdZoom
            .ButtonCount = 1
            .Top         = 543
            .Left        = 774
            .Width       = 42
            .Height      = 41
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_CmdZoom.Buttons(1)
            .Picture = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
            .Top     = 0
            .Left    = 0
            .Width   = 42
            .Height  = 41
        ENDWITH

        par_oPagina.AddObject("obj_4c_CmdProduto", "CommandGroup")
        WITH par_oPagina.obj_4c_CmdProduto
            .ButtonCount = 1
            .Top         = 38
            .Left        = 604
            .Width       = 80
            .Height      = 76
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_CmdProduto.Buttons(1)
            .Caption = "Consulta"
            .Top     = 0
            .Left    = 0
            .Width   = 80
            .Height  = 76
        ENDWITH

        *-- Cod. Pai / Conjunto (Say37 + getConjunto + cmdConjunto + cmdLocConj)
        *-- getConjunto eh o SETIMO campo plProcurar do legado e entra no
        *-- Do Case de msv_procurar (ver ExecutarBuscaPorExemplo).
        par_oPagina.AddObject("lbl_4c_Label37", "Label")
        WITH par_oPagina.lbl_4c_Label37
            .Caption   = "Cod. Pai :"
            .Top       = 190
            .Left      = 398
            .Width     = 49
            .Height    = 15
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Conjunto", "TextBox")
        WITH par_oPagina.txt_4c_Conjunto
            .Top           = 186
            .Left          = 449
            .Width         = 52
            .Height        = 22
            .MaxLength     = 6
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Conjunto, "KeyPress", THIS, "ValidarConjuntoDados")

        *-- cmdConjunto: gera um Cod. Pai novo (legado usa fGerUniqueKey)
        par_oPagina.AddObject("obj_4c_CmdConjunto", "CommandGroup")
        WITH par_oPagina.obj_4c_CmdConjunto
            .ButtonCount = 1
            .Top         = 186
            .Left        = 502
            .Width       = 27
            .Height      = 24
            .BackStyle   = 0
            .BorderStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .AutoSize    = .F.
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_CmdConjunto.Buttons(1)
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .ToolTipText   = "Gerar Cod. Pai"
            .Top           = -1
            .Left          = -1
            .Width         = 29
            .Height        = 26
            .FontName      = "Small Fonts"
            .FontSize      = 7
            .SpecialEffect = 0
            .BackColor     = RGB(162, 214, 242)
        ENDWITH
        BINDEVENT(par_oPagina.obj_4c_CmdConjunto, "Click", THIS, "BtnGerarConjuntoClick")

        *-- cmdLocConj: localiza um Cod. Pai ja existente
        par_oPagina.AddObject("obj_4c_CmdLocConj", "CommandGroup")
        WITH par_oPagina.obj_4c_CmdLocConj
            .ButtonCount = 1
            .Top         = 186
            .Left        = 529
            .Width       = 27
            .Height      = 24
            .BackStyle   = 0
            .BorderStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .AutoSize    = .F.
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_CmdLocConj.Buttons(1)
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "geral_lupa_16.jpg"
            .ToolTipText   = "Localizar Cod. Pai."
            .Top           = -1
            .Left          = -1
            .Width         = 29
            .Height        = 26
            .FontName      = "Small Fonts"
            .FontSize      = 7
            .SpecialEffect = 0
            .BackColor     = RGB(240, 240, 240)
        ENDWITH
        BINDEVENT(par_oPagina.obj_4c_CmdLocConj, "Click", THIS, "BtnLocalizarConjuntoClick")

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPgpgComposicao - Campos da aba "Componente" (pgComposicao
    * legado) dentro de pgf_4c_Divisoes.Page2. Posicoes saem DIRETO do
    * layout.json (mesmo calculo do PageFrame interno usado em
    * ConfigurarAbaDadosPrincipais - ver comentario em ConfigurarPaginaDados).
    *
    * FASE 9 - so a camada VISUAL (controles + lookups de codigo isolado).
    * As grades de dados (grd_4c_Compo/SubCp/GradeGrupo/Relogios) ficam SEM
    * RecordSource/ControlSource nesta fase (regra #41 do CLAUDE.md: ligar
    * Column.ControlSource antes do cursor existir derruba o Init) e os
    * botoes cmdgCompo/cmdgSubCp/cmdCalcVals ficam SEM Click - a logica de
    * negocio (FiltrarCompo, CalcPreco, AtuaPreco, CalcFornec, TotalGrupo)
    * e as 4 grades legadas de composicao entram em fase propria.
    *
    * DESVIO DE NOME (mapeamento.json): o gerador colidiu "grd_4c_Dados" nas
    * QUATRO grades desta mesma pagina (grdCompo/GradeGRUPO/grdsubcp/
    * grdRelogios sao todas filhas diretas de pgComposicao) - AddObject
    * duplicado no mesmo container. Renomeado para grd_4c_Compo/GradeGrupo/
    * SubCp/Relogios; mapeamento.json atualizado para registrar a correcao.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgComposicao()
        LOCAL par_oPagina
        par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2

        *-- Grade principal de componentes (grdCompo legado, 14 colunas)
        par_oPagina.AddObject("grd_4c_Compo", "Grid")
        par_oPagina.grd_4c_Compo.ColumnCount = 14
        WITH par_oPagina.grd_4c_Compo
            .Top                = 117
            .Left               = 6
            .Width              = 943
            .Height             = 147
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
            .ReadOnly           = .F.
            .Visible            = .T.

            .Column1.Width  = 85
            .Column1.Header1.Caption = "Material"
            .Column2.Width  = 224
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Width  = 30
            .Column3.Header1.Caption = "Un"
            .Column4.Width  = 65
            .Column4.Header1.Caption = "Valor"
            .Column5.Width  = 55
            .Column5.Header1.Caption = "Qtde."
            .Column6.Width  = 65
            .Column6.Header1.Caption = "Total"
            .Column7.Width  = 32
            .Column7.Header1.Caption = "Moe"
            .Column8.Width  = 120
            .Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
            .Column9.Width  = 24
            .Column9.Header1.Caption = "E"
            .Column10.Width = 55
            .Column10.Header1.Caption = "Consumo"
            .Column11.Width = 45
            .Column11.Header1.Caption = "Qtde."
            .Column12.Width = 30
            .Column12.Header1.Caption = "Un"
            .Column13.Width = 28
            .Column13.Header1.Caption = "Ord"
            .Column14.Width = 85
            .Column14.Header1.Caption = "Material"
        ENDWITH

        *-- Coluna 9 ("E" = Etiq/Instalas): AddObject + CurrentControl
        *-- obrigatorios para o checkbox aparecer (regra #18 do CLAUDE.md).
        par_oPagina.grd_4c_Compo.Column9.AddObject("chk_4c_Etiqueta", "CheckBox")
        WITH par_oPagina.grd_4c_Compo.Column9
            .CurrentControl = "chk_4c_Etiqueta"
            .Sparse         = .F.
        ENDWITH

        *-- CommandGroup lateral do grdCompo (Inserir/Excluir/Atualizar/
        *-- Recalcular/Pesos - 5 handlers de Click distintos no legado)
        par_oPagina.AddObject("obj_4c_CmdgCompo", "CommandGroup")
        WITH par_oPagina.obj_4c_CmdgCompo
            .ButtonCount = 5
            .Top         = 114
            .Left        = 947
            .Width       = 50
            .Height      = 210
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgCompo.Buttons(1)
            .Caption = "Inserir"
            .Top     = 1
            .Left    = 1
            .Width   = 46
            .Height  = 40
            .FontName = "Tahoma"
            .FontSize = 7
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgCompo.Buttons(2)
            .Caption = "Excluir"
            .Top     = 43
            .Left    = 1
            .Width   = 46
            .Height  = 40
            .FontName = "Tahoma"
            .FontSize = 7
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgCompo.Buttons(3)
            .Caption = "Atualizar"
            .Top     = 85
            .Left    = 1
            .Width   = 46
            .Height  = 40
            .FontName = "Tahoma"
            .FontSize = 7
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgCompo.Buttons(4)
            .Caption = "Recalcular"
            .Top     = 127
            .Left    = 1
            .Width   = 46
            .Height  = 40
            .FontName = "Tahoma"
            .FontSize = 7
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgCompo.Buttons(5)
            .Caption = "Pesos"
            .Top     = 169
            .Left    = 1
            .Width   = 46
            .Height  = 40
            .FontName = "Tahoma"
            .FontSize = 7
        ENDWITH

        *-- MKP Aplicado (getMarkupA)
        par_oPagina.AddObject("txt_4c_MarkupA", "TextBox")
        WITH par_oPagina.txt_4c_MarkupA
            .Top      = 568
            .Left     = 383
            .Width    = 62
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Container "Materia Prima" (cntMtPrima - config de montagem/casas)
        par_oPagina.AddObject("cnt_4c_MtPrima", "Container")
        WITH par_oPagina.cnt_4c_MtPrima
            .Top           = 471
            .Left          = 785
            .Width         = 211
            .Height        = 124
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_LblCompos", "Label")
            WITH .lbl_4c_LblCompos
                .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
                .Top       = 6
                .Left      = 6
                .Width     = 66
                .Height    = 15
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Compos", "TextBox")
            WITH .txt_4c_Compos
                .Top       = 20
                .Left      = 6
                .Width     = 202
                .Height    = 23
                .MaxLength = 14
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblMontaDescs", "Label")
            WITH .lbl_4c_LblMontaDescs
                .Caption   = "Montagem :"
                .Top       = 43
                .Left      = 6
                .Width     = 59
                .Height    = 15
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            .AddObject("cbo_4c_CmbMontaDescs", "ComboBox")
            WITH .cbo_4c_CmbMontaDescs
                .Top      = 57
                .Left     = 6
                .Width    = 202
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            .AddObject("lbl_4c_LblDigiMaxs", "Label")
            WITH .lbl_4c_LblDigiMaxs
                .Caption   = "Digitos :"
                .Top       = 80
                .Left      = 6
                .Width     = 41
                .Height    = 15
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_DigiMaxs", "TextBox")
            WITH .txt_4c_DigiMaxs
                .Top      = 95
                .Left     = 6
                .Width    = 25
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            .AddObject("lbl_4c_LblOrdCompos", "Label")
            WITH .lbl_4c_LblOrdCompos
                .Caption   = "Ordem :"
                .Top       = 80
                .Left      = 85
                .Width     = 41
                .Height    = 15
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_OrdCompos", "TextBox")
            WITH .txt_4c_OrdCompos
                .Top      = 95
                .Left     = 85
                .Width    = 25
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            .AddObject("lbl_4c_LblCasas", "Label")
            WITH .lbl_4c_LblCasas
                .Caption   = "Casas :"
                .Top       = 80
                .Left      = 165
                .Width     = 38
                .Height    = 15
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Casas", "TextBox")
            WITH .txt_4c_Casas
                .Top      = 95
                .Left     = 165
                .Width    = 25
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
        ENDWITH

        *-- Bloco "Custo" (esquerda) - Preco de Custo / Fator de Custo
        par_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPagina.lbl_4c_Label1
            .Caption   = " Custo "
            .Top       = 442
            .Left      = 45
            .Width     = 46
            .Height    = 16
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("chk_4c_ChkLiberaCusto", "CheckBox")
        WITH par_oPagina.chk_4c_ChkLiberaCusto
            .Caption = ""
            .Top     = 431
            .Left    = 7
            .Width   = 35
            .Height  = 35
            .Value   = 0
            .Visible = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_LblCompra", "Label")
        WITH par_oPagina.lbl_4c_LblCompra
            .Caption   = "Pre" + CHR(231) + "o de Custo (Moeda 1)"
            .Top       = 474
            .Left      = 7
            .Width     = 127
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Pcus", "TextBox")
        WITH par_oPagina.txt_4c_Pcus
            .Top      = 489
            .Left     = 7
            .Width    = 115
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Moec", "TextBox")
        WITH par_oPagina.txt_4c_Moec
            .Top       = 489
            .Left      = 125
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Moec, "KeyPress", THIS, "ValidarMoedaCustoComposicao")

        par_oPagina.AddObject("lbl_4c_Label22", "Label")
        WITH par_oPagina.lbl_4c_Label22
            .Caption   = "MKP"
            .Top       = 514
            .Left      = 7
            .Width     = 22
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Cmkpc", "TextBox")
        WITH par_oPagina.txt_4c_Cmkpc
            .Top       = 529
            .Left      = 7
            .Width     = 24
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Cmkpc, "KeyPress", THIS, "ValidarFeitioCustoComposicao")

        par_oPagina.AddObject("lbl_4c_LblValAdics", "Label")
        WITH par_oPagina.lbl_4c_LblValAdics
            .Caption   = "Valor Adicional"
            .Top       = 514
            .Left      = 62
            .Width     = 71
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__pftioc", "TextBox")
        WITH par_oPagina.txt_4c__pftioc
            .Top      = 529
            .Left     = 62
            .Width    = 94
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("chk_4c_ChkPlanCus", "CheckBox")
        WITH par_oPagina.chk_4c_ChkPlanCus
            .Caption = ""
            .Top     = 528
            .Left    = 34
            .Width   = 25
            .Height  = 25
            .Value   = 0
            .Visible = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH par_oPagina.lbl_4c_Label6
            .Caption   = "Peso M" + CHR(233) + "dio"
            .Top       = 553
            .Left      = 8
            .Width     = 56
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Peso", "TextBox")
        WITH par_oPagina.txt_4c_Peso
            .Top      = 568
            .Left     = 8
            .Width    = 79
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH par_oPagina.lbl_4c_Label10
            .Caption   = "Var. Peso %"
            .Top       = 553
            .Left      = 88
            .Width     = 62
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_VarPesoMs", "TextBox")
        WITH par_oPagina.txt_4c_VarPesoMs
            .Top      = 568
            .Left     = 92
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_LblCuVda", "Label")
        WITH par_oPagina.lbl_4c_LblCuVda
            .Caption   = "Fator de Custo (Moeda 2)"
            .Top       = 474
            .Left      = 158
            .Width     = 126
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Fcusto", "TextBox")
        WITH par_oPagina.txt_4c_Fcusto
            .Top      = 489
            .Left     = 159
            .Width    = 109
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH par_oPagina.lbl_4c_Label8
            .Caption   = "Total "
            .Top       = 514
            .Left      = 158
            .Width     = 29
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Custof", "TextBox")
        WITH par_oPagina.txt_4c_Custof
            .Top      = 529
            .Left     = 159
            .Width    = 109
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Moepc", "TextBox")
        WITH par_oPagina.txt_4c_Moepc
            .Top       = 489
            .Left      = 270
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Moepc, "KeyPress", THIS, "ValidarMoedaCustoPComposicao")

        par_oPagina.AddObject("txt_4c_Moecusf", "TextBox")
        WITH par_oPagina.txt_4c_Moecusf
            .Top       = 529
            .Left      = 270
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Moecusf, "KeyPress", THIS, "ValidarMoedaCustoFComposicao")

        par_oPagina.AddObject("shp_4c_Shape6", "Shape")
        WITH par_oPagina.shp_4c_Shape6
            .Top     = 468
            .Left    = 7
            .Width   = 369
            .Height  = 2
            .Visible = .T.
        ENDWITH

        *-- Bloco "Venda" (direita) - Preco Ideal / Preco Atual
        par_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH par_oPagina.lbl_4c_Label2
            .Caption   = " Venda "
            .Top       = 442
            .Left      = 421
            .Width     = 48
            .Height    = 16
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
        WITH par_oPagina.chk_4c_ChkLiberaVenda
            .Caption = ""
            .Top     = 431
            .Left    = 383
            .Width   = 35
            .Height  = 35
            .Value   = 0
            .Visible = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Margem", "TextBox")
        WITH par_oPagina.txt_4c_Margem
            .Top      = 489
            .Left     = 383
            .Width    = 89
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_LblMkpVenda", "Label")
        WITH par_oPagina.lbl_4c_LblMkpVenda
            .Caption   = "MKP Ideal"
            .Top       = 476
            .Left      = 384
            .Width     = 49
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label24", "Label")
        WITH par_oPagina.lbl_4c_Label24
            .Caption   = "Sts"
            .Top       = 514
            .Left      = 384
            .Width     = 17
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Status", "TextBox")
        WITH par_oPagina.txt_4c_Status
            .Top       = 529
            .Left      = 384
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Status, "KeyPress", THIS, "ValidarStatusComposicao")

        par_oPagina.AddObject("lbl_4c_LblMkpApl", "Label")
        WITH par_oPagina.lbl_4c_LblMkpApl
            .Caption   = "MKP Aplic."
            .Top       = 553
            .Left      = 384
            .Width     = 51
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("chk_4c_ChkPlanVen", "CheckBox")
        WITH par_oPagina.chk_4c_ChkPlanVen
            .Caption = ""
            .Top     = 528
            .Left    = 447
            .Width   = 25
            .Height  = 25
            .Value   = 0
            .Visible = .T.
        ENDWITH

        par_oPagina.AddObject("shp_4c_Shape4", "Shape")
        WITH par_oPagina.shp_4c_Shape4
            .Top     = 468
            .Left    = 383
            .Width   = 350
            .Height  = 2
            .Visible = .T.
        ENDWITH

        par_oPagina.AddObject("chk_4c_Chk_Pvenda", "CheckBox")
        WITH par_oPagina.chk_4c_Chk_Pvenda
            .Caption = ""
            .Top     = 567
            .Left    = 447
            .Width   = 25
            .Height  = 25
            .Visible = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Pven", "TextBox")
        WITH par_oPagina.txt_4c_Pven
            .Top      = 568
            .Left     = 476
            .Width    = 105
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_LblVenda", "Label")
        WITH par_oPagina.lbl_4c_LblVenda
            .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
            .Top       = 553
            .Left      = 476
            .Width     = 115
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Pvideal", "TextBox")
        WITH par_oPagina.txt_4c_Pvideal
            .Top      = 489
            .Left     = 476
            .Width    = 105
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_LblIdeal", "Label")
        WITH par_oPagina.lbl_4c_LblIdeal
            .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
            .Top       = 475
            .Left      = 476
            .Width     = 111
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH par_oPagina.lbl_4c_Label13
            .Caption   = "Valor Adicional"
            .Top       = 514
            .Left      = 476
            .Width     = 71
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Pftio", "TextBox")
        WITH par_oPagina.txt_4c_Pftio
            .Top      = 529
            .Left     = 476
            .Width    = 105
            .Height   = 23
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH par_oPagina.lbl_4c_Label7
            .Caption   = "Pre" + CHR(231) + "o De"
            .Top       = 555
            .Left      = 272
            .Width     = 45
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_PrecoDe", "TextBox")
        WITH par_oPagina.txt_4c_PrecoDe
            .Top      = 568
            .Left     = 272
            .Width    = 105
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH par_oPagina.lbl_4c_Label9
            .Caption   = "Custo MP Propria"
            .Top       = 555
            .Left      = 158
            .Width     = 98
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_CustoCp", "TextBox")
        WITH par_oPagina.txt_4c_CustoCp
            .Top      = 568
            .Left     = 158
            .Width    = 105
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH par_oPagina.lbl_4c_Label12
            .Caption   = "Fator"
            .Top       = 514
            .Left      = 618
            .Width     = 28
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_FIdeals", "TextBox")
        WITH par_oPagina.txt_4c_FIdeals
            .Top      = 489
            .Left     = 618
            .Width    = 105
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_LblFIdeals", "Label")
        WITH par_oPagina.lbl_4c_LblFIdeals
            .Caption   = "Fator Ideal"
            .Top       = 475
            .Left      = 618
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Fvenda", "TextBox")
        WITH par_oPagina.txt_4c_Fvenda
            .Top      = 529
            .Left     = 618
            .Width    = 105
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_FAtuals", "TextBox")
        WITH par_oPagina.txt_4c_FAtuals
            .Top      = 568
            .Left     = 618
            .Width    = 105
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_LblFAtuals", "Label")
        WITH par_oPagina.lbl_4c_LblFAtuals
            .Caption   = "Fator Atual"
            .Top       = 553
            .Left      = 618
            .Width     = 56
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH par_oPagina.lbl_4c_Label14
            .Caption   = "MKP"
            .Top       = 514
            .Left      = 420
            .Width     = 22
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Ftio", "TextBox")
        WITH par_oPagina.txt_4c_Ftio
            .Top       = 529
            .Left      = 420
            .Width     = 24
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Ftio, "KeyPress", THIS, "ValidarFeitioVendaComposicao")

        par_oPagina.AddObject("txt_4c_Mftio", "TextBox")
        WITH par_oPagina.txt_4c_Mftio
            .Top       = 529
            .Left      = 584
            .Width     = 31
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Moeda", "TextBox")
        WITH par_oPagina.txt_4c_Moeda
            .Top       = 489
            .Left      = 584
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoedaVendaComposicao")

        par_oPagina.AddObject("txt_4c_Moev", "TextBox")
        WITH par_oPagina.txt_4c_Moev
            .Top       = 568
            .Left      = 584
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Moev, "KeyPress", THIS, "ValidarMoedaVendaVComposicao")

        par_oPagina.AddObject("txt_4c_Moepv", "TextBox")
        WITH par_oPagina.txt_4c_Moepv
            .Top       = 529
            .Left      = 726
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Moepv, "KeyPress", THIS, "ValidarMoedaVendaPVComposicao")

        par_oPagina.AddObject("lbl_4c_Label25", "Label")
        WITH par_oPagina.lbl_4c_Label25
            .Caption   = "Financeiro"
            .Top       = 553
            .Left      = 727
            .Width     = 51
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Encarg", "TextBox")
        WITH par_oPagina.txt_4c_Encarg
            .Top      = 567
            .Left     = 727
            .Width    = 62
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Botao "Calcular" (cmdCalcVals legado - icone-only sem evidencia
        *-- de Picture no dump; regra #25 do CLAUDE.md - usar texto em vez
        *-- de inventar icone)
        par_oPagina.AddObject("cmd_4c_CalcVals", "CommandButton")
        WITH par_oPagina.cmd_4c_CalcVals
            .Caption  = "Calc"
            .Top      = 479
            .Left     = 727
            .Width    = 40
            .Height   = 40
            .FontName = "Tahoma"
            .FontSize = 7
            .Visible  = .T.
        ENDWITH

        *-- Material Principal / Descricao (Get_MatP / Get_Desc)
        par_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH par_oPagina.lbl_4c_Label16
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 293
            .Left      = 40
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Desc", "TextBox")
        WITH par_oPagina.txt_4c_Desc
            .Top       = 290
            .Left      = 99
            .Width     = 298
            .Height    = 21
            .MaxLength = 40
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH par_oPagina.lbl_4c_Label15
            .Caption   = "Material Principal :"
            .Top       = 293
            .Left      = 418
            .Width     = 89
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_MatP", "TextBox")
        WITH par_oPagina.txt_4c_MatP
            .Top       = 290
            .Left      = 517
            .Width     = 108
            .Height    = 21
            .MaxLength = 14
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_MatP, "KeyPress", THIS, "ValidarMaterialPrincipalComposicao")

        *-- Observacao da OF (getObsOFs - obsofs char(120))
        par_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH par_oPagina.lbl_4c_Label4
            .Caption   = "Obs. da OF :"
            .Top       = 269
            .Left      = 33
            .Width     = 64
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_ObsOFs", "TextBox")
        WITH par_oPagina.txt_4c_ObsOFs
            .Top       = 266
            .Left      = 99
            .Width     = 850
            .Height    = 21
            .MaxLength = 120
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Resumo por grupo (GradeGRUPO legado - 3 colunas, so leitura)
        par_oPagina.AddObject("grd_4c_GradeGrupo", "Grid")
        par_oPagina.grd_4c_GradeGrupo.ColumnCount = 3
        WITH par_oPagina.grd_4c_GradeGrupo
            .Top                = 41
            .Left               = 619
            .Width              = 215
            .Height             = 68
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
            .ScrollBars         = 0
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.

            .Column1.Width = 60
            .Column1.Header1.Caption = "Grupo"
            .Column2.Width = 95
            .Column2.Header1.Caption = "Total"
            .Column3.Width = 60
            .Column3.Header1.Caption = "Moeda"
        ENDWITH

        *-- Grade de subcomponentes (grdsubcp legado, 15 colunas)
        par_oPagina.AddObject("grd_4c_SubCp", "Grid")
        par_oPagina.grd_4c_SubCp.ColumnCount = 15
        WITH par_oPagina.grd_4c_SubCp
            .Top                = 317
            .Left               = 6
            .Width              = 943
            .Height             = 83
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
            .ReadOnly           = .F.
            .Visible            = .T.

            .Column1.Width  = 78
            .Column1.Header1.Caption = "Material"
            .Column2.Width  = 248
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Width  = 28
            .Column3.Header1.Caption = "Un"
            .Column4.Width  = 60
            .Column4.Header1.Caption = "Valor"
            .Column5.Width  = 50
            .Column5.Header1.Caption = "Qtde."
            .Column6.Width  = 60
            .Column6.Header1.Caption = "Total"
            .Column7.Width  = 30
            .Column7.Header1.Caption = "Moe"
            .Column8.Width  = 105
            .Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
            .Column9.Width  = 22
            .Column9.Header1.Caption = "E"
            .Column10.Width = 50
            .Column10.Header1.Caption = "Consumo"
            .Column11.Width = 40
            .Column11.Header1.Caption = "Qtde."
            .Column12.Width = 28
            .Column12.Header1.Caption = "Un"
            .Column13.Width = 26
            .Column13.Header1.Caption = "Ord"
            .Column14.Width = 78
            .Column14.Header1.Caption = "Material"
            .Column15.Width = 40
            .Column15.Header1.Caption = "Tam"
        ENDWITH

        par_oPagina.grd_4c_SubCp.Column9.AddObject("chk_4c_EtiquetaSubCp", "CheckBox")
        WITH par_oPagina.grd_4c_SubCp.Column9
            .CurrentControl = "chk_4c_EtiquetaSubCp"
            .Sparse         = .F.
        ENDWITH

        *-- CommandGroup lateral do grdsubcp (Inserir/Excluir)
        par_oPagina.AddObject("obj_4c_CmdgSubCp", "CommandGroup")
        WITH par_oPagina.obj_4c_CmdgSubCp
            .ButtonCount = 2
            .Top         = 314
            .Left        = 947
            .Width       = 50
            .Height      = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgSubCp.Buttons(1)
            .Caption  = "Inserir"
            .Top      = 1
            .Left     = 1
            .Width    = 46
            .Height   = 42
            .FontName = "Tahoma"
            .FontSize = 7
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgSubCp.Buttons(2)
            .Caption  = "Excluir"
            .Top      = 45
            .Left     = 1
            .Width    = 46
            .Height   = 42
            .FontName = "Tahoma"
            .FontSize = 7
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH par_oPagina.lbl_4c_Label3
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 404
            .Left      = 40
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__desccp", "TextBox")
        WITH par_oPagina.txt_4c__desccp
            .Top       = 401
            .Left      = 99
            .Width     = 298
            .Height    = 21
            .MaxLength = 40
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH par_oPagina.lbl_4c_Label5
            .Caption   = "Substitui :"
            .Top       = 404
            .Left      = 466
            .Width     = 50
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__matsub", "TextBox")
        WITH par_oPagina.txt_4c__matsub
            .Top       = 401
            .Left      = 517
            .Width     = 108
            .Height    = 21
            .MaxLength = 14
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Grade alternativa "Relogios" (grdRelogios legado). No mesmo Top/
        *-- Left/Width/Height do grd_4c_Compo - so uma das duas aparece por
        *-- vez conforme ThisForm.Relogios no legado. A logica de alternancia
        *-- fica para fase posterior (aqui so a camada visual): a grade fica
        *-- OCULTA por padrao (produto normal), via excecao em TornarControlesVisiveis.
        par_oPagina.AddObject("grd_4c_Relogios", "Grid")
        par_oPagina.grd_4c_Relogios.ColumnCount = 4
        WITH par_oPagina.grd_4c_Relogios
            .Top                = 117
            .Left               = 6
            .Width              = 943
            .Height             = 307
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
            .Visible            = .F.

            .Column1.Width = 60
            .Column1.Header1.Caption = "Grp"
            .Column2.Width = 350
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Width = 150
            .Column3.Header1.Caption = "Produto"
            .Column4.Width = 383
            .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPgpgCusto - Campos da aba "Composicao" (pgCusto legado) dentro
    * de pgf_4c_Divisoes.Page6. Posicoes saem DIRETO do layout.json, mesmo
    * calculo das demais sub-paginas (sem offset adicional).
    *
    * FASE 10 - so a camada VISUAL. pgCusto eh uma visao ALTERNATIVA da mesma
    * grade de composicao (crSigPrCpo) ja tratada em ConfigurarPgpgComposicao,
    * agrupada por Tipo (cmbTipos). Por isso:
    *   - grd_4c_Compo fica SEM RecordSource/ControlSource (regra #41 do
    *     CLAUDE.md: ligar antes do cursor existir derruba o Init);
    *   - obj_4c_CmdgCompo (Inserir/Excluir) fica SEM Click - mesma logica de
    *     negocio (FiltrarCompo) ja fora de escopo na pagina irma;
    *   - cmbTipos.Valid dispara FiltrarCompo(2) no legado - fora de escopo;
    *   - grdCompo.Procedure (AfterRowColChange) atualiza getDGruCompos via
    *     SQL na linha selecionada - depende de cursor populado, fora de
    *     escopo por ser reacao a dado, nao layout.
    *
    * Coluna 9 ("Etiq"): mesma cursor/tabela (crSigPrCpo) e mesma posicao
    * relativa da coluna "E" (chk_4c_Etiqueta) ja criada em
    * ConfigurarPgpgComposicao - reproduzida aqui como checkbox pela regra
    * #18 (AddObject + CurrentControl + Sparse = .F.).
    *
    * grd_4c_Compo/grd_4c_GradeGrupo2 (DESVIO DE NOME, mapeamento.json): o
    * gerador colidiu "grd_4c_Dados" nas DUAS grades desta pagina (ambas
    * filhas diretas de pgCusto) - renomeado para grd_4c_Compo/GradeGrupo2,
    * mesmo padrao ja usado em pgComposicao; mapeamento.json atualizado.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgCusto()
        LOCAL par_oPagina
        par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6

        *-- Grade de composicao por tipo (grdCompo legado, 12 colunas)
        par_oPagina.AddObject("grd_4c_Compo", "Grid")
        par_oPagina.grd_4c_Compo.ColumnCount = 12
        WITH par_oPagina.grd_4c_Compo
            .Top                = 178
            .Left               = 34
            .Width              = 813
            .Height             = 230
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
            .ReadOnly           = .F.
            .Visible            = .T.

            .Column1.Width  = 45
            .Column1.Header1.Caption = "Item"
            .Column2.Width  = 215
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Width  = 32
            .Column3.Header1.Caption = "Un"
            .Column4.Width  = 68
            .Column4.Header1.Caption = "Valor"
            .Column5.Width  = 50
            .Column5.Header1.Caption = "Qtd"
            .Column6.Width  = 68
            .Column6.Header1.Caption = "Total"
            .Column7.Width  = 35
            .Column7.Header1.Caption = "Moe"
            .Column8.Width  = 145
            .Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
            .Column9.Width  = 40
            .Column9.Header1.Caption = "Etiq"
            .Column10.Width = 55
            .Column10.Header1.Caption = "Consumo"
            .Column11.Width = 45
            .Column11.Header1.Caption = "Qtd"
            .Column12.Width = 32
            .Column12.Header1.Caption = "Un"
        ENDWITH

        *-- Coluna 9 ("Etiq"): AddObject + CurrentControl obrigatorios para o
        *-- checkbox aparecer (regra #18 do CLAUDE.md).
        par_oPagina.grd_4c_Compo.Column9.AddObject("chk_4c_Etiqueta", "CheckBox")
        WITH par_oPagina.grd_4c_Compo.Column9
            .CurrentControl = "chk_4c_Etiqueta"
            .Sparse         = .F.
        ENDWITH

        *-- CommandGroup lateral do grdCompo (Inserir/Excluir - 2 handlers de
        *-- Click distintos no legado)
        par_oPagina.AddObject("obj_4c_CmdgCompo", "CommandGroup")
        WITH par_oPagina.obj_4c_CmdgCompo
            .ButtonCount = 2
            .Top         = 240
            .Left        = 851
            .Width       = 50
            .Height      = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgCompo.Buttons(1)
            .Caption  = "Inserir"
            .Top      = 1
            .Left     = 1
            .Width    = 46
            .Height   = 42
            .FontName = "Tahoma"
            .FontSize = 7
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgCompo.Buttons(2)
            .Caption  = "Excluir"
            .Top      = 45
            .Left     = 1
            .Width    = 46
            .Height   = 42
            .FontName = "Tahoma"
            .FontSize = 7
        ENDWITH

        *-- Tipo (cmbTipos legado - RowSource de tipos de composicao)
        par_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPagina.lbl_4c_Label1
            .Caption   = "Tipo :"
            .Top       = 159
            .Left      = 107
            .Width     = 29
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("cbo_4c_CmbTipos", "ComboBox")
        WITH par_oPagina.cbo_4c_CmbTipos
            .Top      = 154
            .Left     = 143
            .Width    = 187
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Descricao do produto (Get_Desc legado - so leitura, espelha
        *-- crSigCdPro.Dpros, MaxLength 40 = SigCdPro.dpros no schema)
        par_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH par_oPagina.lbl_4c_Label16
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 415
            .Left      = 53
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Desc", "TextBox")
        WITH par_oPagina.txt_4c_Desc
            .Top       = 412
            .Left      = 116
            .Width     = 304
            .Height    = 21
            .MaxLength = 40
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Grupo do componente selecionado (getDGruCompos legado - so
        *-- leitura, espelha SigCdGrp.dgrus, MaxLength 30 conforme schema)
        par_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH par_oPagina.lbl_4c_Label2
            .Caption   = "Grupo :"
            .Top       = 415
            .Left      = 480
            .Width     = 38
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DGruCompos", "TextBox")
        WITH par_oPagina.txt_4c_DGruCompos
            .Top       = 412
            .Left      = 522
            .Width     = 304
            .Height    = 21
            .MaxLength = 30
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Resumo por grupo (GradeGRUPO2 legado - 3 colunas, so leitura)
        par_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH par_oPagina.lbl_4c_Label3
            .Caption   = "Resumo por Grupo"
            .Top       = 445
            .Left      = 35
            .Width     = 107
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH par_oPagina.shp_4c_Shape2
            .Top     = 460
            .Left    = 35
            .Width   = 158
            .Height  = 2
            .Visible = .T.
        ENDWITH

        par_oPagina.AddObject("grd_4c_GradeGrupo2", "Grid")
        par_oPagina.grd_4c_GradeGrupo2.ColumnCount = 3
        WITH par_oPagina.grd_4c_GradeGrupo2
            .Top                = 468
            .Left               = 35
            .Width              = 195
            .Height             = 141
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
            .ScrollBars         = 0
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.

            .Column1.Width = 55
            .Column1.Header1.Caption = "Grp"
            .Column2.Width = 100
            .Column2.Header1.Caption = "Total"
            .Column3.Width = 38
            .Column3.Header1.Caption = "Moe"
        ENDWITH

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPgPgDadosFaseP - Aba "Processos" (PgDadosFaseP legado - Page4)
    *
    * FASE 12 - camada VISUAL completa (70 objetos do layout.json/dump).
    * GradFase (5 colunas) e grdMatrizes (3 colunas) espelham os cursores
    * crSigCdPrf/crSigPrMtz do legado - NAO existem nesta fase (regra #41 do
    * CLAUDE.md: ligar Column.ControlSource antes do cursor existir derruba o
    * Init), por isso ficam SEM RecordSource/ControlSource, e os botoes
    * inserir/excluir/Alternativa/CmdFicha/btnInsereMtx/btnExcluiMtz (que
    * operam sobre essas grades) ficam SEM Click - mesmo padrao de deferimento
    * usado em ConfigurarPgpgComposicao/ConfigurarPgpgCusto/ConfigurarPgPgDadosConsP.
    * Get_Desc/Get_Obs (ControlSource crSigCdGcr.descrs / crSigCdPrf.Obs) pela
    * mesma razao ficam sem ControlSource.
    *
    * Os QUATRO campos de codigo isolado (Acabamento/Cor/Tamanho/Conquilha)
    * SAO lookups simples contra tabela mestre (sem dependencia de cursor de
    * grade) e por isso recebem BINDEVENT + ExecutarLookupGenerico, igual aos
    * demais campos de codigo isolado da aba "Dados Principais".
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP()
        LOCAL par_oPagina
        par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4

        *-- Imagem do processo/fase (shpFig / ImgFigJpg - espelha crSigCdPrf.FigProcs)
        par_oPagina.AddObject("shp_4c_ShpFig", "Shape")
        WITH par_oPagina.shp_4c_ShpFig
            .Top     = 129
            .Left    = 231
            .Width   = 244
            .Height  = 148
            .Visible = .T.
        ENDWITH

        par_oPagina.AddObject("img_4c_ImgFigJpg", "Image")
        WITH par_oPagina.img_4c_ImgFigJpg
            .Top     = 130
            .Left    = 232
            .Width   = 241
            .Height  = 146
            .Stretch = 2
            .Visible = .T.
        ENDWITH

        *-- Botoes de captura de imagem (arquivo / webcam) - estruturais nesta
        *-- fase (Picture + posicao); Click entra quando o subsistema de
        *-- imagem for migrado (mesmo padrao de ConfigurarAbaDadosPrincipais).
        par_oPagina.AddObject("obj_4c_CmdgFigura", "CommandGroup")
        WITH par_oPagina.obj_4c_CmdgFigura
            .ButtonCount = 1
            .Top         = 169
            .Left        = 482
            .Width       = 40
            .Height      = 40
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgFigura.Buttons(1)
            .Picture     = gc_4c_CaminhoIcones + "geral_picture_26.jpg"
            .ToolTipText = "Capturar Imagem do Produto"
            .Top         = 0
            .Left        = 0
            .Width       = 40
            .Height      = 40
        ENDWITH

        par_oPagina.AddObject("obj_4c_CmdgFigCam", "CommandGroup")
        WITH par_oPagina.obj_4c_CmdgFigCam
            .ButtonCount = 1
            .Top         = 209
            .Left        = 482
            .Width       = 40
            .Height      = 40
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_CmdgFigCam.Buttons(1)
            .Picture     = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
            .ToolTipText = "Capturar Imagem do Produto - WebCam"
            .Top         = 0
            .Left        = 0
            .Width       = 40
            .Height      = 40
        ENDWITH

        *-- Ficha Tecnica (CmdFicha legado) - standalone, Click (relatorio)
        *-- entra quando o subsistema de impressao de ficha for migrado.
        par_oPagina.AddObject("cmd_4c_CmdFicha", "CommandButton")
        WITH par_oPagina.cmd_4c_CmdFicha
            .Top             = 129
            .Left            = 482
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
            .ToolTipText     = "Ficha " + CHR(84) + CHR(233) + "cnica"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        *-- Qtd. Minima de Producao (getQmin legado)
        par_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH par_oPagina.lbl_4c_Label13
            .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
            .Top       = 133
            .Left      = 32
            .Width     = 102
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Qmin", "TextBox")
        WITH par_oPagina.txt_4c_Qmin
            .Top       = 129
            .Left      = 137
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .InputMask = "999,999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Garra (getCodGarras legado - char sem lookup no legado)
        par_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH par_oPagina.lbl_4c_Label5
            .Caption   = "Garra :"
            .Top       = 158
            .Left      = 98
            .Width     = 36
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_CodGarras", "TextBox")
        WITH par_oPagina.txt_4c_CodGarras
            .Top       = 154
            .Left      = 137
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Conquilha (getConquilha legado - lookup SigCdCnq)
        par_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH par_oPagina.lbl_4c_Label4
            .Caption   = "Conquilha :"
            .Top       = 183
            .Left      = 78
            .Width     = 59
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Conquilha", "TextBox")
        WITH par_oPagina.txt_4c_Conquilha
            .Top       = 179
            .Left      = 137
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .Alignment = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Conquilha, "KeyPress", THIS, "ValidarConquilhaDados")

        *-- Peso Brilhante / Peso Metal / Peso Pedra (getPesoBris/getPesoMetal/getPesoPdrs)
        par_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH par_oPagina.lbl_4c_Label9
            .Caption   = "Peso Brilhante :"
            .Top       = 208
            .Left      = 57
            .Width     = 77
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_PesoBris", "TextBox")
        WITH par_oPagina.txt_4c_PesoBris
            .Top       = 204
            .Left      = 137
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .InputMask = "99,999.999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH par_oPagina.lbl_4c_Label10
            .Caption   = "Peso Metal :"
            .Top       = 233
            .Left      = 73
            .Width     = 61
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_PesoMetal", "TextBox")
        WITH par_oPagina.txt_4c_PesoMetal
            .Top       = 229
            .Left      = 137
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .InputMask = "99,999.999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH par_oPagina.lbl_4c_Label8
            .Caption   = "Peso Pedra :"
            .Top       = 258
            .Left      = 71
            .Width     = 63
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_PesoPdrs", "TextBox")
        WITH par_oPagina.txt_4c_PesoPdrs
            .Top       = 254
            .Left      = 137
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .InputMask = "99,999.999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Cor Padrao / Tamanho Padrao (getCor/getTam - lookup SigCdCor/SigCdTam)
        par_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH par_oPagina.lbl_4c_Label7
            .Caption   = "Cor Padr" + CHR(227) + "o :"
            .Top       = 283
            .Left      = 71
            .Width     = 63
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Cor", "TextBox")
        WITH par_oPagina.txt_4c_Cor
            .Top       = 279
            .Left      = 137
            .Width     = 38
            .Height    = 23
            .MaxLength = 4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Cor, "KeyPress", THIS, "ValidarCorPadraoDados")

        *-- Peso Variavel (fwoption1 legado - checkbox, ControlSource Varias)
        par_oPagina.AddObject("chk_4c_Fwoption1", "CheckBox")
        WITH par_oPagina.chk_4c_Fwoption1
            .Caption   = "Peso Vari" + CHR(225) + "vel"
            .Top       = 308
            .Left      = 180
            .Width     = 90
            .Height    = 15
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH par_oPagina.lbl_4c_Label2
            .Caption   = "Tamanho Padr" + CHR(227) + "o :"
            .Top       = 308
            .Left      = 44
            .Width     = 90
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Tam", "TextBox")
        WITH par_oPagina.txt_4c_Tam
            .Top       = 304
            .Left      = 137
            .Width     = 38
            .Height    = 23
            .MaxLength = 4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Tam, "KeyPress", THIS, "ValidarTamanhoPadraoDados")

        *-- Acabamento (get_codacb/get_Dacb - lookup SigCdAca)
        par_oPagina.AddObject("lbl_4c_LblAcabamento", "Label")
        WITH par_oPagina.lbl_4c_LblAcabamento
            .Caption   = "Acabamento :"
            .Top       = 333
            .Left      = 15
            .Width     = 119
            .Height    = 15
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_CodAcb", "TextBox")
        WITH par_oPagina.txt_4c_CodAcb
            .Top       = 329
            .Left      = 137
            .Width     = 38
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_CodAcb, "KeyPress", THIS, "ValidarAcabamentoDadosPorCodigo")

        par_oPagina.AddObject("txt_4c_DescAcb", "TextBox")
        WITH par_oPagina.txt_4c_DescAcb
            .Top       = 329
            .Left      = 177
            .Width     = 207
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_DescAcb, "KeyPress", THIS, "ValidarAcabamentoDadosPorDescricao")

        *-- Cravacao em Cera (opc_CravCera legado - checkbox, ControlSource CravCers)
        par_oPagina.AddObject("chk_4c_OpcCravCera", "CheckBox")
        WITH par_oPagina.chk_4c_OpcCravCera
            .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera"
            .Top       = 283
            .Left      = 180
            .Width     = 100
            .Height    = 15
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Garantia + Dias (Say46/Say47/getDiasGar)
        par_oPagina.AddObject("lbl_4c_Label46", "Label")
        WITH par_oPagina.lbl_4c_Label46
            .Caption   = "Garantia :"
            .Top       = 384
            .Left      = 84
            .Width     = 50
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DiasGar", "TextBox")
        WITH par_oPagina.txt_4c_DiasGar
            .Top       = 380
            .Left      = 137
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .InputMask = "999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label47", "Label")
        WITH par_oPagina.lbl_4c_Label47
            .Caption   = "Dias"
            .Top       = 384
            .Left      = 170
            .Width     = 22
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Entrega + Dias (Label9/Label10/getTEnts)
        par_oPagina.AddObject("lbl_4c_LblEntrega", "Label")
        WITH par_oPagina.lbl_4c_LblEntrega
            .Caption   = "Entrega :"
            .Top       = 359
            .Left      = 87
            .Width     = 47
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_TEnts", "TextBox")
        WITH par_oPagina.txt_4c_TEnts
            .Top       = 355
            .Left      = 137
            .Width     = 31
            .Height    = 23
            .MaxLength = 10
            .InputMask = "999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label10b", "Label")
        WITH par_oPagina.lbl_4c_Label10b
            .Caption   = "Dias"
            .Top       = 359
            .Left      = 170
            .Width     = 22
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Volumes (Say26/fwget3)
        par_oPagina.AddObject("lbl_4c_Label26", "Label")
        WITH par_oPagina.lbl_4c_Label26
            .Caption   = "Volumes :"
            .Top       = 409
            .Left      = 86
            .Width     = 48
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Volumes", "TextBox")
        WITH par_oPagina.txt_4c_Volumes
            .Top       = 405
            .Left      = 137
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Lote Minimo (Say21/getLtMinsV)
        par_oPagina.AddObject("lbl_4c_Label21", "Label")
        WITH par_oPagina.lbl_4c_Label21
            .Caption   = "Lote M" + CHR(237) + "nimo :"
            .Top       = 434
            .Left      = 69
            .Width     = 65
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_LtMinsV", "TextBox")
        WITH par_oPagina.txt_4c_LtMinsV
            .Top       = 430
            .Left      = 137
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .InputMask = "999,999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Ult. Compra (get_Dtucp/Get_vucp/Get_mucp - somente leitura, auto-
        *-- calculado pelo subsistema de compras)
        par_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH par_oPagina.lbl_4c_Label19
            .Caption   = CHR(218) + "lt.Compra :"
            .Top       = 459
            .Left      = 71
            .Width     = 63
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DtUcp", "TextBox")
        WITH par_oPagina.txt_4c_DtUcp
            .Top       = 455
            .Left      = 137
            .Width     = 79
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Vucp", "TextBox")
        WITH par_oPagina.txt_4c_Vucp
            .Top       = 455
            .Left      = 217
            .Width     = 97
            .Height    = 23
            .InputMask = "99,999.99999"
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Mucp", "TextBox")
        WITH par_oPagina.txt_4c_Mucp
            .Top       = 455
            .Left      = 315
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Variacao (Say36/Fwoption2 - OptionGroup Sim/Nao, ControlSource prodvars)
        par_oPagina.AddObject("lbl_4c_Label36", "Label")
        WITH par_oPagina.lbl_4c_Label36
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o :"
            .Top       = 481
            .Left      = 84
            .Width     = 50
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Fwoption2", "OptionGroup")
        WITH par_oPagina.obj_4c_Fwoption2
            .ButtonCount = 2
            .Top         = 482
            .Left        = 132
            .Width       = 93
            .Height      = 15
            .BackStyle   = 0
            .Value       = 1
            .ToolTipText = "Setar se exporta varia" + CHR(231) + CHR(227) + "o para e-commerce"
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption2.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Top       = 0
            .Left      = 5
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption2.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Top       = 0
            .Left      = 47
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Descricao do grupo/fase selecionada (Get_Desc - espelha
        *-- crSigCdGcr.descrs; sem ControlSource nesta fase - regra #41)
        par_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPagina.lbl_4c_Label1
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 508
            .Left      = 527
            .Width     = 67
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Desc", "TextBox")
        WITH par_oPagina.txt_4c_Desc
            .Top       = 505
            .Left      = 595
            .Width     = 395
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Grade de Fases do Processo (GradFase legado, 5 colunas) - espelha
        *-- crSigCdPrf; SEM RecordSource/ControlSource nesta fase (regra #41)
        par_oPagina.AddObject("grd_4c_Dados", "Grid")
        par_oPagina.grd_4c_Dados.ColumnCount = 5
        WITH par_oPagina.grd_4c_Dados
            .Top                = 129
            .Left               = 527
            .Width              = 420
            .Height             = 168
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
            .RowHeight          = 17
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .F.
            .Visible            = .T.

            .Column1.Width           = 45
            .Column1.Header1.Caption = "Ordem"
            .Column2.Width           = 80
            .Column2.Header1.Caption = "Fase"
            .Column3.Width           = 70
            .Column3.Movable         = .F.
            .Column3.Resizable       = .F.
            .Column3.InputMask       = "99,999.9"
            .Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
            .Column4.Width           = 84
            .Column4.Movable         = .F.
            .Column4.Resizable       = .F.
            .Column4.Header1.Caption = "Uni. Produtiva"
            .Column5.Width           = 115
            .Column5.Header1.Caption = "Material"
        ENDWITH

        *-- Botoes de CRUD da grade de Fases (inserir/excluir/Alternativa
        *-- legados) - standalone, Click entra quando crSigCdPrf for migrado
        par_oPagina.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH par_oPagina.cmd_4c_Incluir
            .Top             = 129
            .Left = 5
            .Width           = 39
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ToolTipText     = "Incluir"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        par_oPagina.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH par_oPagina.cmd_4c_Excluir
            .Top             = 169
            .Left = 230
            .Width           = 39
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText     = "Excluir"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        par_oPagina.AddObject("cmd_4c_Alternativa", "CommandButton")
        WITH par_oPagina.cmd_4c_Alternativa
            .Top             = 209
            .Left            = 950
            .Width           = 39
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_pn_cfg_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pn_cfg_26.jpg"
            .ToolTipText     = "Alternativa"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        *-- Observacao da Fase (Get_Obs - espelha crSigCdPrf.Obs; sem
        *-- ControlSource nesta fase - regra #41)
        par_oPagina.AddObject("obj_4c_GetObs", "EditBox")
        WITH par_oPagina.obj_4c_GetObs
            .Top     = 531
            .Left    = 527
            .Width   = 463
            .Height  = 92
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        *-- Grade de Matrizes (grdMatrizes legado, 3 colunas) - espelha
        *-- crSigPrMtz; SEM RecordSource/ControlSource nesta fase (regra #41).
        *-- ColumnOrder replicado do dump: pos1=Matriz, pos2=Qtde, pos3=Local.
        par_oPagina.AddObject("grd_4c_Matrizes", "Grid")
        par_oPagina.grd_4c_Matrizes.ColumnCount = 3
        WITH par_oPagina.grd_4c_Matrizes
            .Top                = 305
            .Left               = 527
            .Width              = 245
            .Height             = 192
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
            .RowHeight          = 17
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .F.
            .Visible            = .T.

            .Column1.Width           = 108
            .Column1.Header1.Caption = "Matriz"
            .Column2.Width           = 80
            .Column2.ColumnOrder     = 3
            .Column2.Movable         = .F.
            .Column2.Resizable       = .F.
            .Column2.Header1.Caption = "Local"
            .Column3.Width           = 34
            .Column3.ColumnOrder     = 2
            .Column3.InputMask       = "9999"
            .Column3.Header1.Caption = "Qtde"
        ENDWITH

        *-- Botoes de CRUD da grade de Matrizes (btnInsereMtx/btnExcluiMtz
        *-- legados) - standalone, Click entra quando crSigPrMtz for migrado
        par_oPagina.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
        WITH par_oPagina.cmd_4c_BtnInsereMtx
            .Top             = 302
            .Left            = 778
            .Width           = 39
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        par_oPagina.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
        WITH par_oPagina.cmd_4c_BtnExcluiMtz
            .Top             = 342
            .Left            = 778
            .Width           = 39
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText     = "Excluir"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        *-- Imagem da Matriz/Borracha selecionada (shpBorracha/ImgBorracha)
        par_oPagina.AddObject("shp_4c_ShpBorracha", "Shape")
        WITH par_oPagina.shp_4c_ShpBorracha
            .Top           = 387
            .Left          = 779
            .Width         = 210
            .Height        = 112
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        par_oPagina.AddObject("img_4c_ImgBorracha", "Image")
        WITH par_oPagina.img_4c_ImgBorracha
            .Top     = 388
            .Left    = 780
            .Width   = 208
            .Height  = 110
            .Stretch = 1
            .Enabled = .F.
            .Visible = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPgPgDadosConsP - Aba "Consumo" (PgDadosConsP legado - Page5)
    *
    * GrdCons (9 colunas) espelha o MESMO cursor crSigPrCpo do grdCompo/
    * grdSubCp (pgComposicao/pgCusto), mostrando as colunas de consumo do
    * componente (Fase/Grupo, Descricao do grupo, Ordem, Qtde. de Consumo,
    * Categoria). O legado reordena a exibicao via .ColumnOrder - a ordem
    * declarada (Column1..9) NAO e a ordem visual; replicada abaixo:
    * Componente(1), Descricao(9), Qtde.(2), Uni(3), Fase(4), Descricao(5),
    * Ord.(6), Consumo(7), Cat.(8) - conferido contra sigcdpro_06.png.
    *
    * grDTEMP (2 colunas, Agrupamento/Tempo %) recebe nome interno distinto
    * (grd_4c_Tempos) para nao colidir com "grd_4c_Dados" - o mapeamento.json
    * mapeia as DUAS grades desta pagina para "grd_4c_Dados" (colisao de
    * geracao automatica; nomes internos resolvidos aqui, nao no JSON).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgPgDadosConsP()
        LOCAL par_oPagina
        par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5

        *-- Qtde. Componentes (Getqtcpnt legado - espelha crSigCdPro.qtdcpnts)
        par_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH par_oPagina.lbl_4c_Label7
            .Caption   = "Qtde Componentes : "
            .Top       = 505
            .Left      = 23
            .Width     = 105
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Qtcpnt", "TextBox")
        WITH par_oPagina.txt_4c_Qtcpnt
            .Top       = 500
            .Left      = 132
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .InputMask = "999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Nao Checar Cadastro de Fundicao (chkFund legado - espelha
        *-- crSigCdPro.chkFunds)
        par_oPagina.AddObject("chk_4c_ChkFund", "CheckBox")
        WITH par_oPagina.chk_4c_ChkFund
            .Caption   = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
            .Top       = 525
            .Left      = 11
            .Width     = 182
            .Height    = 15
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Grade de consumo dos componentes (GrdCons legado, 9 colunas)
        par_oPagina.AddObject("grd_4c_Dados", "Grid")
        par_oPagina.grd_4c_Dados.ColumnCount = 9
        WITH par_oPagina.grd_4c_Dados
            .Top                = 149
            .Left               = 6
            .Width              = 987
            .Height             = 347
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .T.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 17
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .F.
            .Visible            = .T.

            .Column1.ColumnOrder     = 1
            .Column1.Width           = 108
            .Column1.ReadOnly        = .T.
            .Column1.Header1.Caption = "Componente"

            .Column9.ColumnOrder     = 2
            .Column9.Width           = 223
            .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            .Column2.ColumnOrder     = 3
            .Column2.Width           = 60
            .Column2.ReadOnly        = .T.
            .Column2.Header1.Caption = "Qtde."

            .Column3.ColumnOrder     = 4
            .Column3.Width           = 25
            .Column3.ReadOnly        = .T.
            .Column3.Header1.Caption = "Uni"

            .Column4.ColumnOrder     = 5
            .Column4.Width           = 105
            .Column4.Movable         = .F.
            .Column4.Resizable       = .F.
            .Column4.Sparse          = .F.
            .Column4.Header1.Caption = "Fase"

            .Column5.ColumnOrder     = 6
            .Column5.Width           = 290
            .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            .Column6.ColumnOrder     = 7
            .Column6.Width           = 35
            .Column6.ReadOnly        = .T.
            .Column6.Header1.Caption = "Ord."

            .Column7.ColumnOrder     = 8
            .Column7.Width           = 60
            .Column7.Header1.Caption = "Consumo"

            .Column8.ColumnOrder     = 9
            .Column8.Width           = 52
            .Column8.Header1.Caption = "Cat."
        ENDWITH

        *-- Tempo de Producao por Agrupamento (grDTEMP legado, 2 colunas)
        par_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPagina.lbl_4c_Label1
            .Caption   = "Tempo Produ" + CHR(231) + CHR(227) + "o por Agrupamento :"
            .Top       = 501
            .Left      = 643
            .Width     = 176
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("grd_4c_Tempos", "Grid")
        par_oPagina.grd_4c_Tempos.ColumnCount = 2
        WITH par_oPagina.grd_4c_Tempos
            .Top                = 500
            .Left               = 821
            .Width              = 172
            .Height             = 107
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .T.
            .RowHeight          = 17
            .ScrollBars         = 0
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.

            .Column1.Width = 80
            .Column1.Header1.Caption = "Agrupamento"
            .Column2.Width = 60
            .Column2.Header1.Caption = "Tempo %"
        ENDWITH

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPgpgDadosFiscais - Campos da aba "Dados Fiscais" (pgDadosFiscais
    * legado - classificacao fiscal, ICMS/IPI, conta contabil e grade de CMV -
    * FASE 13). Alvo real eh pgf_4c_Divisoes.Page3 (Page3.Caption = "Dados
    * Fiscais" em ConfigurarPaginaDados / PageOrder 3 em AlternarDivisao); o
    * "Page6" citado no prompt generico desta fase pertence a pgCusto
    * (ConfigurarPgpgCusto), que ja ocupa esse slot.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais()
        LOCAL par_oPagina
        par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3

        *-- Configuracao (Fwoption1 legado - sem Valid/Click no dump, so
        *-- estrutura visual: ButtonCount=2, sem captions capturadas)
        par_oPagina.AddObject("lbl_4c_Label29", "Label")
        WITH par_oPagina.lbl_4c_Label29
            .Caption   = "Configura" + CHR(231) + CHR(227) + "o :"
            .Top       = 128
            .Left      = 129
            .Width     = 73
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH par_oPagina.obj_4c_Fwoption1
            .ButtonCount = 2
            .Top         = 123
            .Left        = 204
            .Width       = 151
            .Height      = 24
            .Visible     = .T.
        ENDWITH

        *-- Codigo Importado / Codigo Nacional / Codigo DCR (get_CodImpPro,
        *-- get_codnacpro, get_coddcr legado - sem Valid/Click no dump e sem
        *-- coluna correspondente em SigCdPro/docs/schema.sql; mantidos como
        *-- campo simples, sem persistencia (regra #17 - nao inventar coluna)
        par_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH par_oPagina.lbl_4c_Label14
            .Caption   = "C" + CHR(243) + "digo Importado :"
            .Top       = 154
            .Left      = 107
            .Width     = 95
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__CodImpPro", "TextBox")
        WITH par_oPagina.txt_4c__CodImpPro
            .Top       = 150
            .Left      = 206
            .Width     = 80
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__DCodImpPro", "TextBox")
        WITH par_oPagina.txt_4c__DCodImpPro
            .Top       = 150
            .Left      = 288
            .Width     = 318
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH par_oPagina.lbl_4c_Label19
            .Caption   = "C" + CHR(243) + "digo Nacional :"
            .Top       = 178
            .Left      = 117
            .Width     = 85
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__codnacpro", "TextBox")
        WITH par_oPagina.txt_4c__codnacpro
            .Top       = 175
            .Left      = 206
            .Width     = 80
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__dcodnacpro", "TextBox")
        WITH par_oPagina.txt_4c__dcodnacpro
            .Top       = 175
            .Left      = 288
            .Width     = 318
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label20", "Label")
        WITH par_oPagina.lbl_4c_Label20
            .Caption   = "C" + CHR(243) + "digo DCR :"
            .Top       = 203
            .Left      = 136
            .Width     = 66
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__coddcr", "TextBox")
        WITH par_oPagina.txt_4c__coddcr
            .Top       = 200
            .Left      = 206
            .Width     = 80
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Grupo / Conta Contabil (get_gruccus/get_contaccus legado - o dump
        *-- usa fAcessoContab/fAcessoContas, funcao global do Framework legado
        *-- com filtro de grupo dinamico via parametro (memoria
        *-- feedback_facessocontas_lookup_ux.md); sem a tabela de referencia
        *-- exata confirmada no schema atual, os campos ficam como entrada
        *-- simples, sem picker (regra #17 - nao inventar tabela/consulta)
        par_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH par_oPagina.lbl_4c_Label16
            .Caption   = "Grupo C.C. :"
            .Top       = 229
            .Left      = 139
            .Width     = 63
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__gruccus", "TextBox")
        WITH par_oPagina.txt_4c__gruccus
            .Top       = 225
            .Left      = 206
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__dgruccus", "TextBox")
        WITH par_oPagina.txt_4c__dgruccus
            .Top       = 225
            .Left      = 288
            .Width     = 318
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Label17", "Label")
        WITH par_oPagina.lbl_4c_Label17
            .Caption   = "Conta C.C. :"
            .Top       = 253
            .Left      = 139
            .Width     = 63
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__contaccus", "TextBox")
        WITH par_oPagina.txt_4c__contaccus
            .Top       = 250
            .Left      = 206
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c__dcontaccus", "TextBox")
        WITH par_oPagina.txt_4c__dcontaccus
            .Top       = 250
            .Left      = 288
            .Width     = 318
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Classificacao Fiscal (getClfiscal/getDclfiscal legado - SigCdClf)
        par_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPagina.lbl_4c_Label1
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
            .Top       = 280
            .Left      = 103
            .Width     = 99
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Clfiscal", "TextBox")
        WITH par_oPagina.txt_4c_Clfiscal
            .Top       = 275
            .Left      = 206
            .Width     = 94
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Clfiscal, "KeyPress", THIS, "ValidarClassificacaoFiscalPorCodigo")

        par_oPagina.AddObject("txt_4c_Dclfiscal", "TextBox")
        WITH par_oPagina.txt_4c_Dclfiscal
            .Top       = 275
            .Left      = 303
            .Width     = 303
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Dclfiscal, "KeyPress", THIS, "ValidarClassificacaoFiscalPorDescricao")

        *-- Origem da Mercadoria (getOrigmerc/getDorigmerc legado - SigCdOrg)
        par_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH par_oPagina.lbl_4c_Label2
            .Caption   = "Origem da Mercadoria :"
            .Top       = 305
            .Left      = 88
            .Width     = 114
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Origmerc", "TextBox")
        WITH par_oPagina.txt_4c_Origmerc
            .Top       = 300
            .Left      = 206
            .Width     = 17
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Origmerc, "KeyPress", THIS, "ValidarOrigemMercadoriaPorCodigo")

        par_oPagina.AddObject("txt_4c_Dorigmerc", "TextBox")
        WITH par_oPagina.txt_4c_Dorigmerc
            .Top       = 300
            .Left      = 226
            .Width     = 380
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Dorigmerc, "KeyPress", THIS, "ValidarOrigemMercadoriaPorDescricao")

        *-- Situacao Tributaria ICMS (getSittricm/getDsittricm/Get_CodServs
        *-- legado - SigCdIcm; Get_CodServs eh o codigo de servico que
        *-- resolve a mesma situacao tributaria e grava o resultado em
        *-- getSittricm/getDsittricm, exatamente como no Valid original)
        par_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH par_oPagina.lbl_4c_Label3
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
            .Top       = 330
            .Left      = 75
            .Width     = 127
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Sittricm", "TextBox")
        WITH par_oPagina.txt_4c_Sittricm
            .Top       = 325
            .Left      = 206
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Sittricm, "KeyPress", THIS, "ValidarSituacaoTributariaPorCodigo")

        par_oPagina.AddObject("txt_4c_Dsittricm", "TextBox")
        WITH par_oPagina.txt_4c_Dsittricm
            .Top       = 325
            .Left      = 240
            .Width     = 366
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Dsittricm, "KeyPress", THIS, "ValidarSituacaoTributariaPorDescricao")

        *-- Codigo de Servicos para ICMS (Get_CodServs legado)
        par_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH par_oPagina.lbl_4c_Label6
            .Caption   = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
            .Top       = 355
            .Left      = 49
            .Width     = 153
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH par_oPagina.txt_4c_Codigo
            .Top       = 350
            .Left      = 206
            .Width     = 38
            .Height    = 23
            .MaxLength = 4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarCodigoServicoIcmsDadosFiscais")

        *-- Aliquota ICMS (getIcms legado - icms numeric(5,2))
        par_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH par_oPagina.lbl_4c_Label8
            .Caption   = "Al" + CHR(237) + "quota ICMS :"
            .Top       = 355
            .Left      = 263
            .Width     = 76
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Icms", "TextBox")
        WITH par_oPagina.txt_4c_Icms
            .Top       = 350
            .Left      = 342
            .Width     = 45
            .Height    = 23
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Tipo de Tributacao (Get_TpTrib legado - SigPrTri)
        par_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH par_oPagina.lbl_4c_Label4
            .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
            .Top       = 355
            .Left      = 411
            .Width     = 98
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_TpTrib", "TextBox")
        WITH par_oPagina.txt_4c_TpTrib
            .Top       = 350
            .Left      = 513
            .Width     = 38
            .Height    = 23
            .MaxLength = 4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_TpTrib, "KeyPress", THIS, "ValidarTipoTributacaoDadosFiscais")

        *-- IAT - Indicador de Arredondamento/Truncamento (getiat legado -
        *-- aceita so A, T ou espaco)
        par_oPagina.AddObject("lbl_4c_Label41", "Label")
        WITH par_oPagina.lbl_4c_Label41
            .Caption   = "IAT :"
            .Top       = 354
            .Left      = 558
            .Width     = 26
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Iat", "TextBox")
        WITH par_oPagina.txt_4c_Iat
            .Top       = 350
            .Left      = 589
            .Width     = 17
            .Height    = 23
            .MaxLength = 1
            .Format    = "!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Iat, "KeyPress", THIS, "ValidarIatDadosFiscais")

        par_oPagina.AddObject("lbl_4c_Label42", "Label")
        WITH par_oPagina.lbl_4c_Label42
            .Caption   = "[A]rredondamento [T]runcamento"
            .Top       = 354
            .Left      = 609
            .Width     = 165
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Situacao Tributaria IPI - Combo (cmbIpi legado - ipis char(1))
        par_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH par_oPagina.lbl_4c_Label5
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
            .Top       = 380
            .Left      = 86
            .Width     = 116
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("cbo_4c_CmbIpi", "ComboBox")
        WITH par_oPagina.cbo_4c_CmbIpi
            .Top       = 375
            .Left      = 206
            .Width     = 108
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Aliquota de IPI (Get_AliqIPI legado - aliqipis numeric(5,2);
        *-- Valid compara com a aliquota da Classificacao Fiscal e avisa
        *-- quando ficam identicas - transcrito do dump)
        par_oPagina.AddObject("lbl_4c__AliqIPI", "Label")
        WITH par_oPagina.lbl_4c__AliqIPI
            .Caption   = "Al" + CHR(237) + "quota de IPI :"
            .Top       = 380
            .Left      = 340
            .Width     = 80
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_AliqIPI", "TextBox")
        WITH par_oPagina.txt_4c_AliqIPI
            .Top       = 375
            .Left      = 425
            .Width     = 45
            .Height    = 25
            .InputMask = "999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_AliqIPI, "KeyPress", THIS, "ValidarAliquotaIpiDadosFiscais")

        *-- Excecao da TIPI (getextipi legado - extipi char(3). O legado
        *-- habilita o campo so quando SigCdClf.IpiProds = 'S' (When
        *-- dinamico); nao reproduzido aqui por depender de refresh a cada
        *-- foco - o campo fica sempre habilitado, regra #17)
        par_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH par_oPagina.lbl_4c_Label13
            .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
            .Top       = 380
            .Left      = 511
            .Width     = 87
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Extipi", "TextBox")
        WITH par_oPagina.txt_4c_Extipi
            .Top       = 375
            .Left      = 601
            .Width     = 35
            .Height    = 25
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Valor do Grama Produzido - grade de CMV por periodo (grdCmv
        *-- legado, 3 colunas)
        par_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH par_oPagina.lbl_4c_Label9
            .Caption   = "Valor do Grama Produzido"
            .Top       = 384
            .Left      = 756
            .Width     = 125
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("grd_4c_Dados", "Grid")
        par_oPagina.grd_4c_Dados.ColumnCount = 3
        WITH par_oPagina.grd_4c_Dados
            .Top                = 402
            .Left               = 754
            .Width              = 223
            .Height             = 141
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
            .ScrollBars         = 3
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.

            .Column1.Width = 70
            .Column1.Header1.Caption = "Per" + CHR(237) + "odo"
            .Column2.Width = 90
            .Column2.Header1.Caption = "Valor Custo GR"
            .Column3.Width = 40
            .Column3.Header1.Caption = "Moe"
        ENDWITH

        *-- Descricao Fiscal (mgetdescfi legado - descfis memo) e botao de
        *-- geracao automatica (btnDescFis - fGerDescFis, funcao global do
        *-- legado sem porte ainda; botao fica estrutural, sem Click)
        par_oPagina.AddObject("lbl_4c_Label18", "Label")
        WITH par_oPagina.lbl_4c_Label18
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
            .Top       = 405
            .Left      = 118
            .Width     = 84
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Mgetdescfi", "EditBox")
        WITH par_oPagina.obj_4c_Mgetdescfi
            .Top       = 402
            .Left      = 206
            .Width     = 509
            .Height    = 89
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("cmd_4c_BtnDescFis", "CommandButton")
        WITH par_oPagina.cmd_4c_BtnDescFis
            .Top             = 423
            .Left            = 162
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_documento_26.jpg"
            .ToolTipText     = "Gerar Descri" + CHR(231) + CHR(227) + "o Fiscal"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        *-- Metal / Teor (Get_metal/Get_DesTeor/Get_teor/Get_DesMetal legado -
        *-- cursores locais TmpMTal/TmpTeor criados vazios no Init (Codigos
        *-- c(2), Descs c(20)) e populados por rotina fora do dump capturado;
        *-- sem a fonte dos dados, os campos ficam como entrada simples, sem
        *-- picker (regra #17 - nao inventar conteudo do cursor local)
        par_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH par_oPagina.lbl_4c_Label11
            .Caption   = "Metal :"
            .Top       = 497
            .Left      = 498
            .Width     = 35
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Metal", "TextBox")
        WITH par_oPagina.txt_4c_Metal
            .Top       = 493
            .Left      = 537
            .Width     = 24
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DesMetal", "TextBox")
        WITH par_oPagina.txt_4c_DesMetal
            .Top       = 493
            .Left      = 564
            .Width     = 150
            .Height    = 23
            .MaxLength = 20
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Descricao ECF (getDescEcfs legado - descecfs char(29))
        par_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH par_oPagina.lbl_4c_Label12
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
            .Top       = 497
            .Left      = 125
            .Width     = 77
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DescEcfs", "TextBox")
        WITH par_oPagina.txt_4c_DescEcfs
            .Top       = 493
            .Left      = 206
            .Width     = 213
            .Height    = 23
            .MaxLength = 29
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Teor (Get_teor/Get_DesTeor legado - mesmo cursor local sem fonte
        *-- capturada, ver comentario acima do bloco Metal)
        par_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH par_oPagina.lbl_4c_Label15
            .Caption   = "Teor :"
            .Top       = 522
            .Left      = 502
            .Width     = 31
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Teor", "TextBox")
        WITH par_oPagina.txt_4c_Teor
            .Top       = 518
            .Left      = 537
            .Width     = 24
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DesTeor", "TextBox")
        WITH par_oPagina.txt_4c_DesTeor
            .Top       = 518
            .Left      = 564
            .Width     = 150
            .Height    = 23
            .MaxLength = 20
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Valor Estimado + Moeda (getValor/GetMvalor legado - getValor sem
        *-- coluna correspondente em SigCdPro/docs/schema.sql; GetMvalor eh
        *-- lookup de moeda real (SigCdMoe) e tambem dispara
        *-- ThisForm.TotalGrupo() no legado - efeito nao reproduzido aqui por
        *-- pertencer a aba Componente, fora do escopo desta pagina)
        par_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH par_oPagina.lbl_4c_Label7
            .Caption   = "Valor Estimado :"
            .Top       = 522
            .Left      = 123
            .Width     = 79
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Valor", "TextBox")
        WITH par_oPagina.txt_4c_Valor
            .Top       = 518
            .Left      = 206
            .Width     = 108
            .Height    = 23
            .InputMask = "999,999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Mvalor", "TextBox")
        WITH par_oPagina.txt_4c_Mvalor
            .Top       = 518
            .Left      = 317
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Mvalor, "KeyPress", THIS, "ValidarMoedaValorEstimadoDadosFiscais")

        *-- IPPT/CST (getIPPTCST legado - When retorna .F. sempre, ou seja o
        *-- campo nunca recebe foco no legado; sem coluna correspondente em
        *-- SigCdPro. Mantido desabilitado, fiel ao comportamento original)
        par_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH par_oPagina.lbl_4c_Label10
            .Caption   = "IPPT/CST :"
            .Top       = 547
            .Left      = 148
            .Width     = 54
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_IPPTCST", "TextBox")
        WITH par_oPagina.txt_4c_IPPTCST
            .Top       = 543
            .Left      = 206
            .Width     = 108
            .Height    = 23
            .Enabled   = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPgpgDesigner - Aba "Designer" (pgDesigner legado - Page7,
    * caption "Page1" no proprio SCX). 21 objetos: grade de tarefas do
    * designer (crSigPrTar) + observacao da tarefa, grade de arquivos
    * anexados (crSigPrArq) + preview de imagem, campo de inspiracao
    * (crSigCdPro.ObsInsp), bloco "Dados do Lancamento" (Desenvolvido por /
    * Criado por - lookup SigCdUsu / Data Apr. Amostra).
    *
    * grd_4c_Dados (grdDesigner) e grd_4c_Arquivos (grdArquivos) ficam SEM
    * RecordSource/ControlSource nesta fase (regra #41 do CLAUDE.md:
    * crSigPrTar/crSigPrArq ainda nao existem - nenhum BO deste projeto os
    * popula). Pelo mesmo motivo os botoes que operam sobre essas grades
    * (Iniciar/Encerrar Tarefa, Inserir/Abrir/Excluir Arquivo) e o
    * AfterRowColChange/DblClick que atualizam a preview de imagem ficam SEM
    * Click/evento - mesmo padrao de deferimento de ConfigurarPgPgDadosFaseP/
    * ConfigurarPgPgDadosConsP (GradFase/grdMatrizes/inserir/excluir/...).
    * Nomes internos das grades distintos de proposito (nao ambos
    * "grd_4c_Dados") para nao colidir - o mapeamento.json mapeia as DUAS
    * grades desta pagina para "grd_4c_Dados" (mesma colisao ja documentada
    * em ConfigurarPgPgDadosConsP/grd_4c_Tempos).
    *
    * getObsTarefas (ControlSource legado crSigPrTar.ObsTars) e getObsInsp
    * (ControlSource legado crSigCdPro.ObsInsp) ficam so estruturais - esta
    * arquitetura nao usa TextBox.ControlSource (FormParaBO/BOParaForm fazem
    * o bind manual) e getObsTarefas depende do cursor de tarefas acima.
    *
    * GetDesLacto/GetCriaLacto SAO lookups reais contra SigCdUsu, filtrados
    * por "Not cAtivos='N' and deptos in (select codigos from sigcddpt where
    * UtiLacto = 1)" (transcrito do Valid legado), e recebem BINDEVENT +
    * ExecutarLookupGenerico, igual aos demais campos de codigo isolado do
    * form.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgDesigner()
        LOCAL par_oPagina
        par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7

        *-- Moldura decorativa ao redor do bloco Inspiracao/Observacao (Shape1)
        par_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH par_oPagina.shp_4c_Shape1
            .Top           = 400
            .Left          = 584
            .Width         = 407
            .Height        = 202
            .BackStyle     = 0
            .BorderWidth   = 1
            .BorderColor   = RGB(231, 254, 253)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Grade de tarefas do designer (grdDesigner legado, 4 colunas) -
        *-- espelha crSigPrTar; SEM RecordSource/ControlSource nesta fase
        *-- (regra #41)
        par_oPagina.AddObject("grd_4c_Dados", "Grid")
        par_oPagina.grd_4c_Dados.ColumnCount = 4
        WITH par_oPagina.grd_4c_Dados
            .Top                = 145
            .Left               = 10
            .Width              = 495
            .Height             = 180
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .AllowHeaderSizing  = .F.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.

            .Column1.Width           = 140
            .Column1.Movable         = .F.
            .Column1.Resizable       = .F.
            .Column1.ReadOnly        = .T.
            .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"

            .Column2.Width           = 140
            .Column2.Movable         = .F.
            .Column2.Resizable       = .F.
            .Column2.ReadOnly        = .T.
            .Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"

            .Column3.Width           = 90
            .Column3.Movable         = .F.
            .Column3.Resizable       = .F.
            .Column3.ReadOnly        = .T.
            .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"

            .Column4.Width           = 90
            .Column4.Movable         = .F.
            .Column4.Resizable       = .F.
            .Column4.ReadOnly        = .F.
            .Column4.Header1.Caption = "Tarefa"
        ENDWITH

        *-- Observacao da Tarefa (Say31 + getObsTarefas legados)
        par_oPagina.AddObject("lbl_4c_Label31", "Label")
        WITH par_oPagina.lbl_4c_Label31
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
            .Top       = 129
            .Left      = 583
            .Width     = 126
            .Height    = 15
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_GetObsTarefas", "EditBox")
        WITH par_oPagina.obj_4c_GetObsTarefas
            .Top           = 145
            .Left          = 584
            .Width         = 407
            .Height        = 113
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Botoes Iniciar / Encerrar Tarefa (btnIniTarefa/btnFimTarefa
        *-- legados) - Click depende de crSigPrTar (regra #41)
        par_oPagina.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
        WITH par_oPagina.cmd_4c_BtnIniTarefa
            .Top             = 146
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .ToolTipText     = "Iniciar Nova Tarefa"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        par_oPagina.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
        WITH par_oPagina.cmd_4c_BtnFimTarefa
            .Top             = 188
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_datas_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_26.jpg"
            .ToolTipText     = "Encerrar Tarefa"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        *-- Grade de arquivos anexados (grdArquivos legado, 1 coluna) -
        *-- espelha crSigPrArq; SEM RecordSource/ControlSource nesta fase
        *-- (regra #41)
        par_oPagina.AddObject("grd_4c_Arquivos", "Grid")
        par_oPagina.grd_4c_Arquivos.ColumnCount = 1
        WITH par_oPagina.grd_4c_Arquivos
            .Top                = 334
            .Left               = 10
            .Width              = 495
            .Height             = 164
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .AllowHeaderSizing  = .F.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.

            .Column1.Width           = 464
            .Column1.Movable         = .F.
            .Column1.Resizable       = .F.
            .Column1.ReadOnly        = .T.
            .Column1.Header1.Caption = "Arquivos Para Designer"
        ENDWITH

        *-- Botoes Inserir / Abrir / Excluir Arquivo (btnInsArqs/btnOpnArqs/
        *-- btnExcArqs legados) - Click depende de crSigPrArq (regra #41)
        par_oPagina.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
        WITH par_oPagina.cmd_4c_BtnInsArqs
            .Top             = 335
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_arquivo_26.jpg"
            .ToolTipText     = "Inserir Arquivo"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        par_oPagina.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
        WITH par_oPagina.cmd_4c_BtnOpnArqs
            .Top             = 419
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .ToolTipText     = "Abrir Arquivo"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        par_oPagina.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
        WITH par_oPagina.cmd_4c_BtnExcArqs
            .Top             = 377
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText     = "Excluir Arquivo"
            .Themes          = .T.
            .Enabled         = .T.
            .Visible         = .T.
        ENDWITH

        *-- Preview do arquivo selecionado (imgArqJpg legado) - invisivel ate
        *-- a grade de arquivos ser populada (regra #41); DblClick de zoom
        *-- (Do Form SigOpZom) depende de crSigPrArq
        par_oPagina.AddObject("img_4c_ImgArqJpg", "Image")
        WITH par_oPagina.img_4c_ImgArqJpg
            .Top         = 402
            .Left        = 586
            .Width       = 403
            .Height      = 198
            .Stretch     = 1
            .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
            .Visible     = .F.
        ENDWITH

        *-- Inspiracao (Say1 + getObsInsp legados - crSigCdPro.ObsInsp)
        par_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPagina.lbl_4c_Label1
            .Caption   = "Inspira" + CHR(231) + CHR(227) + "o"
            .Top       = 265
            .Left      = 583
            .Width     = 62
            .Height    = 15
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_GetObsInsp", "EditBox")
        WITH par_oPagina.obj_4c_GetObsInsp
            .Top           = 281
            .Left          = 584
            .Width         = 407
            .Height        = 113
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Bloco "Dados do Lancamento" (Say19 + Line1 legados)
        par_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH par_oPagina.lbl_4c_Label19
            .Caption   = "Dados do Lan" + CHR(231) + "amento"
            .Top       = 504
            .Left      = 18
            .Width     = 127
            .Height    = 15
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lin_4c_Line1", "Line")
        WITH par_oPagina.lin_4c_Line1
            .Top     = 518
            .Left    = 14
            .Width   = 317
            .Height  = 0
            .Visible = .T.
        ENDWITH

        *-- Data Apr. Amostra (Say6 + Get_DtAprAmo legados -
        *-- crSigCdPro.DtAprAmo)
        par_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH par_oPagina.lbl_4c_Label6
            .Caption   = "Data Apr. Amostra :"
            .Top       = 531
            .Left      = 16
            .Width     = 99
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DtAprAmo", "TextBox")
        WITH par_oPagina.txt_4c_DtAprAmo
            .Top           = 527
            .Left          = 118
            .Width         = 80
            .Height        = 23
            .Value         = {^1900-01-01}
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Desenvolvido por / Criado por (Say4/GetDesLacto e Say5/GetCriaLacto
        *-- legados - lookup SigCdUsu filtrado por Deptos.UtiLacto)
        par_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH par_oPagina.lbl_4c_Label4
            .Caption   = "Desenvolvido por :"
            .Top       = 556
            .Left      = 23
            .Width     = 92
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DesLacto", "TextBox")
        WITH par_oPagina.txt_4c_DesLacto
            .Top           = 552
            .Left          = 118
            .Width         = 91
            .Height        = 22
            .MaxLength     = 30
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_DesLacto, "KeyPress", THIS, "ValidarDesenvolvidoPorLacto")

        par_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH par_oPagina.lbl_4c_Label5
            .Caption   = "Criado por :"
            .Top       = 580
            .Left      = 56
            .Width     = 59
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_CriaLacto", "TextBox")
        WITH par_oPagina.txt_4c_CriaLacto
            .Top           = 576
            .Left          = 118
            .Width         = 91
            .Height        = 22
            .MaxLength     = 30
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_CriaLacto, "KeyPress", THIS, "ValidarCriadoPorLacto")

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPgpgServico - Sub-pagina "Servicos" (pgServico legado - Page8):
    * grade de servicos vinculados ao produto (crSigPrSer legado), com colunas
    * Servicos/Codigo e checkbox de marcacao na Coluna3 - FASE 15. SEM
    * RecordSource/ControlSource nesta fase (regra #41 CLAUDE.md - cursor
    * ainda nao populado, mesmo estagio dos demais grids desta pagina).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgServico()
        LOCAL par_oPagina
        par_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8

        *-- Grade de servicos (grdServico legado, 3 colunas)
        par_oPagina.AddObject("grd_4c_Dados", "Grid")
        par_oPagina.grd_4c_Dados.ColumnCount = 3
        WITH par_oPagina.grd_4c_Dados
            .Top                = 171
            .Left               = 339
            .Width              = 320
            .Height             = 387
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
            .ReadOnly           = .F.
            .Visible            = .T.

            .Column1.Width           = 180
            .Column1.Header1.Caption = "Servi" + CHR(231) + "os"

            .Column2.Width           = 90
            .Column2.Header1.Caption = "C" + CHR(243) + "digo"

            .Column3.Width           = 50
            .Column3.Header1.Caption = ""
        ENDWITH

        *-- Coluna 3 (checkbox de marcacao, sem legenda no legado): AddObject +
        *-- CurrentControl obrigatorios para o checkbox aparecer (regra #18
        *-- CLAUDE.md)
        par_oPagina.grd_4c_Dados.Column3.AddObject("chk_4c_Marcado", "CheckBox")
        WITH par_oPagina.grd_4c_Dados.Column3
            .CurrentControl = "chk_4c_Marcado"
            .Sparse         = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *===========================================================================
    * ExecutarLookupGenerico - Motor comum dos lookups FK da aba Dados
    * Principais. Reproduz o padrao ValidarGrupoFiltro/ValidarGrupoPorDescricao
    * ja usado na pagina de Lista, generalizado por parametro (tabela, campos,
    * cursor e - opcionalmente - filtro adicional, ex.: Classificacao por
    * grupo). PUBLIC porque eh chamado por metodo PUBLIC (nao precisa ser
    * PUBLIC ele mesmo, mas mantido PROTECTED por ser chamado so via THIS.).
    *===========================================================================
    PROTECTED PROCEDURE ExecutarLookupGenerico(par_oTxtCod, par_oTxtDesc, ;
            par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, ;
            par_cCursor, par_cCampoBusca, par_cValorBusca, par_cFiltro)
        LOCAL loc_oBusca, loException

        IF EMPTY(par_cValorBusca)
            par_oTxtCod.Value = ""
            IF VARTYPE(par_oTxtDesc) = "O"
                par_oTxtDesc.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    par_cTabela, par_cCursor, par_cCampoBusca, par_cValorBusca, ;
                    par_cTitulo, .T., .T., par_cFiltro)
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    par_cTabela, par_cCursor, par_cCampoBusca, par_cValorBusca, ;
                    par_cTitulo)
            ENDIF

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna(par_cCampoCod, "", "C" + CHR(243) + "digo")
                    IF !EMPTY(par_cCampoDesc)
                        loc_oBusca.mAddColuna(par_cCampoDesc, "", ;
                            "Descri" + CHR(231) + CHR(227) + "o")
                    ENDIF
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED(par_cCursor)
                    SELECT (par_cCursor)
                    par_oTxtCod.Value = ALLTRIM(EVALUATE(par_cCursor + "." + par_cCampoCod))
                    IF VARTYPE(par_oTxtDesc) = "O" AND !EMPTY(par_cCampoDesc)
                        par_oTxtDesc.Value = ALLTRIM(EVALUATE(par_cCursor + "." + par_cCampoDesc))
                    ENDIF
                ELSE
                    par_oTxtCod.Value = ""
                    IF VARTYPE(par_oTxtDesc) = "O"
                        par_oTxtDesc.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar " + par_cTitulo + ":" + CHR(13) + ;
                loException.Message, "FormProduto.ExecutarLookupGenerico")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCodigoProdutoDados - LostFocus de txt_4c_Cpro (aba Dados). Em modo
    * PROCURAR o campo eh o filtro da busca por exemplo (ver BtnBuscarClick);
    * fora dele so normaliza o codigo digitado - o legado (getCpro.When) trata
    * o proprio codigo como chave, sem lookup externo.
    *===========================================================================
    PROCEDURE ValidarCodigoProdutoDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_oPg.txt_4c_Cpro.Value = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)
    ENDPROC

    PROCEDURE ValidarProdutoEquivalente(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_CProEq.Value), 14)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CProEq, .NULL., "SigCdPro", ;
            "CPros", "", "Produto Equivalente", "cursor_4c_BuscaProEqDados", ;
            "CPros", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarGrupoDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Cgru.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cgru, loc_oPg.txt_4c_Dgru, ;
            "SigCdGrp", "cgrus", "dgrus", "Grupo de Produto", ;
            "cursor_4c_BuscaGrpDados", "cgrus", loc_cValor, "")
        *-- txt_4c_Merc (Grande Grupo) eh populado a partir de SigCdGrp.Mercs
        *-- pelo BO ao carregar/gravar o produto - sem evidencia no dump de que
        *-- o legado copia esse valor no proprio Valid do campo Grupo, por isso
        *-- NAO reproduzido aqui (regra #17 do CLAUDE.md: nao inventar formula).
    ENDPROC

    PROCEDURE ValidarGrupoDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dgru.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Cgru.Value))
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cgru, loc_oPg.txt_4c_Dgru, ;
            "SigCdGrp", "cgrus", "dgrus", "Grupo de Produto", ;
            "cursor_4c_BuscaGrpDados", "dgrus", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarSubgrupoDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor, loc_cFiltro
        loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor  = PADR(ALLTRIM(loc_oPg.txt_4c_CSGru.Value), 6)
        loc_cFiltro = "CGrus = " + EscaparSQL(PADR(ALLTRIM(loc_oPg.txt_4c_Cgru.Value), 3))
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CSGru, loc_oPg.txt_4c_DsGru, ;
            "SigCdPsg", "Codigos", "Descricaos", "Subgrupo", ;
            "cursor_4c_BuscaSubGrpDados", "Codigos", loc_cValor, loc_cFiltro)
    ENDPROC

    PROCEDURE ValidarSubgrupoDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor, loc_cFiltro
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsGru.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_CSGru.Value))
            RETURN
        ENDIF
        loc_cFiltro = "CGrus = " + EscaparSQL(PADR(ALLTRIM(loc_oPg.txt_4c_Cgru.Value), 3))
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CSGru, loc_oPg.txt_4c_DsGru, ;
            "SigCdPsg", "Codigos", "Descricaos", "Subgrupo", ;
            "cursor_4c_BuscaSubGrpDados", "Descricaos", loc_cValor, loc_cFiltro)
    ENDPROC

    PROCEDURE ValidarLinhaDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Lin.Value), 10)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Lin, loc_oPg.txt_4c_DLin, ;
            "SigCdLin", "Linhas", "Descs", "Linha", "cursor_4c_BuscaLinDados", ;
            "Linhas", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarLinhaDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DLin.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Lin.Value))
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Lin, loc_oPg.txt_4c_DLin, ;
            "SigCdLin", "Linhas", "Descs", "Linha", "cursor_4c_BuscaLinDados", ;
            "Descs", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarColecaoDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Col.Value), 10)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Col, loc_oPg.txt_4c_DCol, ;
            "SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(227) + "o", ;
            "cursor_4c_BuscaColDados", "Colecoes", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarColecaoDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DCol.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Col.Value))
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Col, loc_oPg.txt_4c_DCol, ;
            "SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(227) + "o", ;
            "cursor_4c_BuscaColDados", "Descs", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarClassificacaoDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor, loc_cFiltro
        loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor  = PADR(ALLTRIM(loc_oPg.txt_4c_Class.Value), 3)
        loc_cFiltro = "CGrus IN (" + EscaparSQL(PADR(ALLTRIM(loc_oPg.txt_4c_Cgru.Value), 3)) + ;
            ", " + EscaparSQL(SPACE(3)) + ")"
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Class, .NULL., "SigCdCls", ;
            "Cods", "", "Classifica" + CHR(231) + CHR(227) + "o", ;
            "cursor_4c_BuscaClsDados", "Cods", loc_cValor, loc_cFiltro)
    ENDPROC

    PROCEDURE ValidarFornecedorDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Ifor.Value), 10)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Ifor, loc_oPg.txt_4c_Dfor, ;
            "SigCdCli", "Iclis", "Rclis", "Fornecedor", ;
            "cursor_4c_BuscaForDados", "Iclis", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarFornecedorDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dfor.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Ifor.Value))
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Ifor, loc_oPg.txt_4c_Dfor, ;
            "SigCdCli", "Iclis", "Rclis", "Fornecedor", ;
            "cursor_4c_BuscaForDados", "Rclis", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarModeloDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_CodFinP.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CodFinP, loc_oPg.txt_4c_DesFinP, ;
            "SigCdFip", "Cods", "Descs", "Modelo", "cursor_4c_BuscaFinPDados", ;
            "Cods", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarModeloDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DesFinP.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_CodFinP.Value))
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CodFinP, loc_oPg.txt_4c_DesFinP, ;
            "SigCdFip", "Cods", "Descs", "Modelo", "cursor_4c_BuscaFinPDados", ;
            "Descs", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarUnidadeDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Cuni.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cuni, loc_oPg.txt_4c_Duni, ;
            "SigCdUni", "CUnis", "DUnis", "Unidade", "cursor_4c_BuscaUniDados", ;
            "CUnis", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarUnidadeDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Duni.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Cuni.Value))
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cuni, loc_oPg.txt_4c_Duni, ;
            "SigCdUni", "CUnis", "DUnis", "Unidade", "cursor_4c_BuscaUniDados", ;
            "DUnis", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarUnidadePedidoDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Cunip.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cunip, loc_oPg.txt_4c__dunip, ;
            "SigCdUni", "CUnis", "DUnis", "Unidade de Pedido", ;
            "cursor_4c_BuscaUniPDados", "CUnis", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarUnidadePedidoDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__dunip.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Cunip.Value))
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cunip, loc_oPg.txt_4c__dunip, ;
            "SigCdUni", "CUnis", "DUnis", "Unidade de Pedido", ;
            "cursor_4c_BuscaUniPDados", "DUnis", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarLocalDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Local.Value), 10)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Local, .NULL., "SigPrLcl", ;
            "Codigos", "", "Localiza" + CHR(231) + CHR(227) + "o", ;
            "cursor_4c_BuscaLocalDados", "Codigos", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarMoedaCustoTotalDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Mctotal.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Mctotal, .NULL., "SigCdMoe", ;
            "CMoes", "", "Moeda", "cursor_4c_BuscaMoeCtotalDados", "CMoes", ;
            loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarMoedaValorVendaDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Mpvenda, .NULL., "SigCdMoe", ;
            "CMoes", "", "Moeda", "cursor_4c_BuscaMoePvendaDados", "CMoes", ;
            loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarMoedaFatorVendaDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Mfvenda, .NULL., "SigCdMoe", ;
            "CMoes", "", "Moeda", "cursor_4c_BuscaMoeFvendaDados", "CMoes", ;
            loc_cValor, "")
    ENDPROC

    *-- Lookups da aba "Processos" (PgDadosFaseP - FASE 12)
    PROCEDURE ValidarCorPadraoDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Cor.Value), 4)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cor, .NULL., "SigCdCor", ;
            "Cods", "", "Cor", "cursor_4c_BuscaCorFaseDados", "Cods", ;
            loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarTamanhoPadraoDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Tam.Value), 4)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Tam, .NULL., "SigCdTam", ;
            "Cods", "", "Tamanho", "cursor_4c_BuscaTamFaseDados", "Cods", ;
            loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarConquilhaDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Conquilha.Value), 10)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Conquilha, .NULL., "SigCdCnq", ;
            "Conquilhas", "", "Conquilha", "cursor_4c_BuscaConquilhaDados", ;
            "Conquilhas", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarAcabamentoDadosPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_CodAcb.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CodAcb, loc_oPg.txt_4c_DescAcb, ;
            "SigCdAca", "Cods", "Descrs", "Acabamento", ;
            "cursor_4c_BuscaAcbDados", "Cods", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarAcabamentoDadosPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DescAcb.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_CodAcb.Value))
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CodAcb, loc_oPg.txt_4c_DescAcb, ;
            "SigCdAca", "Cods", "Descrs", "Acabamento", ;
            "cursor_4c_BuscaAcbDados", "Descrs", loc_cValor, "")
    ENDPROC

    *===========================================================================
    * ObterPaginaComposicao - Atalho para a aba "Componente" (pgComposicao
    * legado), espelhando ObterPaginaDados
    *===========================================================================
    PROTECTED PROCEDURE ObterPaginaComposicao()
        RETURN THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
    ENDPROC

    *===========================================================================
    * Validar*Composicao - Lookups de codigo isolado da aba "Componente"
    * (pgComposicao). Mesmo motor ExecutarLookupGenerico das outras abas.
    *===========================================================================
    PROCEDURE ValidarMoedaCustoComposicao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaComposicao()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moec.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moec, .NULL., "SigCdMoe", ;
            "CMoes", "", "Moeda", "cursor_4c_BuscaMoeCustoComp", "CMoes", ;
            loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarMoedaCustoPComposicao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaComposicao()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moepc.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moepc, .NULL., "SigCdMoe", ;
            "CMoes", "", "Moeda", "cursor_4c_BuscaMoeCustoPComp", "CMoes", ;
            loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarMoedaCustoFComposicao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaComposicao()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moecusf.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moecusf, .NULL., "SigCdMoe", ;
            "CMoes", "", "Moeda", "cursor_4c_BuscaMoeCustoFComp", "CMoes", ;
            loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarMoedaVendaComposicao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaComposicao()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moeda.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moeda, .NULL., "SigCdMoe", ;
            "CMoes", "", "Moeda", "cursor_4c_BuscaMoeVendaComp", "CMoes", ;
            loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarMoedaVendaVComposicao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaComposicao()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moev.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moev, .NULL., "SigCdMoe", ;
            "CMoes", "", "Moeda", "cursor_4c_BuscaMoeVendaVComp", "CMoes", ;
            loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarMoedaVendaPVComposicao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaComposicao()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Moepv.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Moepv, .NULL., "SigCdMoe", ;
            "CMoes", "", "Moeda", "cursor_4c_BuscaMoeVendaPVComp", "CMoes", ;
            loc_cValor, "")
    ENDPROC

    *-- Feitio de Venda (Getftio legado - SigPrFti.Tipos <> 1)
    PROCEDURE ValidarFeitioVendaComposicao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaComposicao()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Ftio.Value), 2)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Ftio, .NULL., "SigPrFti", ;
            "Cods", "Descs", "Feitio", "cursor_4c_BuscaFeitioVendaComp", ;
            "Cods", loc_cValor, "Tipos <> 1")
    ENDPROC

    *-- Feitio de Custo (Get_cmkpc legado - SigPrFti.Tipos = 1)
    PROCEDURE ValidarFeitioCustoComposicao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaComposicao()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value), 2)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Cmkpc, .NULL., "SigPrFti", ;
            "Cods", "Descs", "Feitio", "cursor_4c_BuscaFeitioCustoComp", ;
            "Cods", loc_cValor, "Tipos = 1")
    ENDPROC

    *-- Status do componente (getStatus legado - SigCdPst)
    PROCEDURE ValidarStatusComposicao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaComposicao()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Status.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Status, .NULL., "SigCdPst", ;
            "Cods", "Descs", "Status", "cursor_4c_BuscaStatusComp", "Cods", ;
            loc_cValor, "")
    ENDPROC

    *-- Material Principal (Get_MatP legado - SigCdPro). O legado ainda
    *-- valida CrProds.Varias = 1 (material de peso variavel); a checagem
    *-- de negocio fica para a fase de calculo (CalcPreco/CalcFornec).
    PROCEDURE ValidarMaterialPrincipalComposicao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaComposicao()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_MatP.Value), 14)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_MatP, loc_oPg.txt_4c_Desc, ;
            "SigCdPro", "CPros", "DPros", "Produtos", ;
            "cursor_4c_BuscaMatPrincipalComp", "CPros", loc_cValor, "")
    ENDPROC

    *===========================================================================
    * ObterPaginaDadosFiscais - Atalho para a aba "Dados Fiscais"
    * (pgDadosFiscais legado), espelhando ObterPaginaDados/ObterPaginaComposicao
    *===========================================================================
    PROTECTED PROCEDURE ObterPaginaDadosFiscais()
        RETURN THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3
    ENDPROC

    *===========================================================================
    * Validar*DadosFiscais - Lookups e validacoes da aba "Dados Fiscais"
    * (pgDadosFiscais). Mesmo motor ExecutarLookupGenerico das outras abas.
    *===========================================================================
    PROCEDURE ValidarClassificacaoFiscalPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaDadosFiscais()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), 10)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Clfiscal, loc_oPg.txt_4c_Dclfiscal, ;
            "SigCdClf", "Codigos", "Descricaos", ;
            "Classifica" + CHR(231) + CHR(227) + "o Fiscal", ;
            "cursor_4c_BuscaClfDadosFiscais", "Codigos", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarClassificacaoFiscalPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaDadosFiscais()
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Clfiscal, loc_oPg.txt_4c_Dclfiscal, ;
            "SigCdClf", "Codigos", "Descricaos", ;
            "Classifica" + CHR(231) + CHR(227) + "o Fiscal", ;
            "cursor_4c_BuscaClfDadosFiscais", "Descricaos", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarOrigemMercadoriaPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaDadosFiscais()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value), 1)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Origmerc, loc_oPg.txt_4c_Dorigmerc, ;
            "SigCdOrg", "Codigos", "Descricaos", "Origem da Mercadoria", ;
            "cursor_4c_BuscaOrgDadosFiscais", "Codigos", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarOrigemMercadoriaPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaDadosFiscais()
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value))
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Origmerc, loc_oPg.txt_4c_Dorigmerc, ;
            "SigCdOrg", "Codigos", "Descricaos", "Origem da Mercadoria", ;
            "cursor_4c_BuscaOrgDadosFiscais", "Descricaos", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarSituacaoTributariaPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaDadosFiscais()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Sittricm.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Sittricm, loc_oPg.txt_4c_Dsittricm, ;
            "SigCdIcm", "Codigos", "Descricaos", ;
            "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS", ;
            "cursor_4c_BuscaIcmDadosFiscais", "Codigos", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarSituacaoTributariaPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaDadosFiscais()
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value)
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Sittricm.Value))
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Sittricm, loc_oPg.txt_4c_Dsittricm, ;
            "SigCdIcm", "Codigos", "Descricaos", ;
            "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS", ;
            "cursor_4c_BuscaIcmDadosFiscais", "Descricaos", loc_cValor, "")
    ENDPROC

    *-- Get_CodServs legado: o Valid NAO grava no proprio campo - abre o
    *-- lookup SigCdIcm e grava o resultado em getSittricm/getDsittricm
    *-- (aqui txt_4c_Sittricm/txt_4c_Dsittricm), exatamente como no dump.
    PROCEDURE ValidarCodigoServicoIcmsDadosFiscais(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaDadosFiscais()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Codigo.Value), 4)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Sittricm, loc_oPg.txt_4c_Dsittricm, ;
            "SigCdIcm", "Codigos", "Descricaos", ;
            "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS", ;
            "cursor_4c_BuscaIcmCodServDadosFiscais", "Codigos", loc_cValor, "")
    ENDPROC

    PROCEDURE ValidarTipoTributacaoDadosFiscais(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaDadosFiscais()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_TpTrib.Value), 4)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_TpTrib, .NULL., "SigPrTri", ;
            "Tipos", "Descs", "Tipo", "cursor_4c_BuscaTpTribDadosFiscais", ;
            "Tipos", loc_cValor, "")
    ENDPROC

    *===========================================================================
    * ValidarIatDadosFiscais - LostFocus de txt_4c_Iat (getiat legado). So
    * aceita 'A' (Arredondamento), 'T' (Truncamento) ou vazio - transcrito
    * do Valid original.
    *===========================================================================
    PROCEDURE ValidarIatDadosFiscais(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaDadosFiscais()
        loc_cValor = UPPER(ALLTRIM(loc_oPg.txt_4c_Iat.Value))

        IF !INLIST(loc_cValor, "A", "T", "")
            MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                "lida. Digite [A] Indicador de Arredondamento Ou [T] " + ;
                "Indicador de Truncamento!", "Aviso")
            loc_oPg.txt_4c_Iat.Value = ""
        ELSE
            loc_oPg.txt_4c_Iat.Value = loc_cValor
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarAliquotaIpiDadosFiscais - LostFocus de txt_4c_AliqIPI
    * (Get_AliqIPI legado). Avisa quando a aliquota informada eh IDENTICA a
    * da Classificacao Fiscal (SigCdClf.aipis) - no legado isso bloqueava a
    * saida do campo (Valid Return .F.); em TextBox/LostFocus so o aviso eh
    * reproduzido (docs/vfp9-migration regra sobre LostFocus x Valid de GET).
    *===========================================================================
    PROCEDURE ValidarAliquotaIpiDadosFiscais(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_nValor, loc_cClfiscal, loc_cSQL, loc_nResultado, loException
        loc_oPg       = THIS.ObterPaginaDadosFiscais()
        loc_nValor    = VAL(ALLTRIM(loc_oPg.txt_4c_AliqIPI.Value))
        loc_cClfiscal = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)

        IF EMPTY(loc_cClfiscal) OR loc_nValor = 0
            RETURN
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_AliqClfDadosFiscais")
                USE IN cursor_4c_AliqClfDadosFiscais
            ENDIF

            loc_cSQL = "SELECT aipis FROM SigCdClf WHERE Codigos = " + ;
                EscaparSQL(PADR(loc_cClfiscal, 10))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AliqClfDadosFiscais")

            IF loc_nResultado >= 0 AND USED("cursor_4c_AliqClfDadosFiscais") ;
                    AND RECCOUNT("cursor_4c_AliqClfDadosFiscais") > 0
                IF loc_nValor = cursor_4c_AliqClfDadosFiscais.aipis
                    MsgAviso("Al" + CHR(237) + "quota de IPI informada no " + ;
                        "produto id" + CHR(234) + "ntica " + CHR(224) + ;
                        " classifica" + CHR(231) + CHR(227) + "o fiscal, " + ;
                        "deixe zero e ser" + CHR(225) + " utilizada a " + ;
                        "classifica" + CHR(231) + CHR(227) + "o fiscal!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF

            IF USED("cursor_4c_AliqClfDadosFiscais")
                USE IN cursor_4c_AliqClfDadosFiscais
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar al" + CHR(237) + "quota de IPI:" + ;
                CHR(13) + loException.Message, ;
                "FormProduto.ValidarAliquotaIpiDadosFiscais")
        ENDTRY
    ENDPROC

    *-- GetMvalor legado: lookup de moeda real (SigCdMoe), mesmo padrao das
    *-- demais moedas do form (ValidarMoedaCustoComposicao etc.)
    PROCEDURE ValidarMoedaValorEstimadoDadosFiscais(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaDadosFiscais()
        loc_cValor = PADR(ALLTRIM(loc_oPg.txt_4c_Mvalor.Value), 3)
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_Mvalor, .NULL., "SigCdMoe", ;
            "CMoes", "DMoes", "Moeda", "cursor_4c_BuscaMoedaValorDadosFiscais", ;
            "CMoes", loc_cValor, "")
    ENDPROC

    *-- Desenvolvido por / Criado por (aba Designer) - lookup de usuario
    *-- (SigCdUsu) restrito aos usuarios de departamento com UtiLacto=1,
    *-- filtro transcrito do Valid legado de GetDesLacto/GetCriaLacto
    PROCEDURE ValidarDesenvolvidoPorLacto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor, loc_cFiltro
        loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7
        loc_cValor  = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
        loc_cFiltro = "cAtivos <> " + EscaparSQL("N") + " AND deptos IN " + ;
            "(SELECT codigos FROM sigcddpt WHERE UtiLacto = 1)"
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_DesLacto, .NULL., "SigCdUsu", ;
            "Usuarios", "NComps", "Usu" + CHR(225) + "rio", ;
            "cursor_4c_BuscaDesLactoDesigner", "Usuarios", loc_cValor, loc_cFiltro)
    ENDPROC

    PROCEDURE ValidarCriadoPorLacto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor, loc_cFiltro
        loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7
        loc_cValor  = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
        loc_cFiltro = "cAtivos <> " + EscaparSQL("N") + " AND deptos IN " + ;
            "(SELECT codigos FROM sigcddpt WHERE UtiLacto = 1)"
        THIS.ExecutarLookupGenerico(loc_oPg.txt_4c_CriaLacto, .NULL., "SigCdUsu", ;
            "Usuarios", "NComps", "Usu" + CHR(225) + "rio", ;
            "cursor_4c_BuscaCriaLactoDesigner", "Usuarios", loc_cValor, loc_cFiltro)
    ENDPROC

    *===========================================================================
    * ConfigurarNavegacaoDivisoes - OptionGroup de 8 botoes graficos que faz o
    * papel da barra de abas (Optiongroup1 legado: Top=3, Left=8, 610 x 85)
    *
    * Cada botao mantem o Left, o Picture e a tecla de atalho do SCX. A ordem
    * dos botoes na tela (Left) NAO e a ordem do Value: o Value e o indice da
    * Option, e e ele que o legado usa no DO CASE do InteractiveChange.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarNavegacaoDivisoes(par_oPagina)
        par_oPagina.AddObject("opt_4c_Navegacao", "OptionGroup")

        *-- AutoSize = .F. com Width/Height explicitos (o legado usa AutoSize
        *-- = .T., que resulta nestes mesmos 610 x 85 - aqui fica deterministico)
        WITH par_oPagina.opt_4c_Navegacao
            .ButtonCount   = 8
            .Top           = 32
            .Left          = 8
            .Width         = 615
            .Height        = 85
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .AutoSize      = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH

        *-- Botao 1: Principal -> aba pgDados
        WITH par_oPagina.opt_4c_Navegacao.Buttons(1)
            .Caption       = "\<Principal"
            .BackStyle = 0
            .Picture       = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
            .Top           = 5
            .Left          = 5
            .Width         = 75
            .Height        = 75
            .Style         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .WordWrap      = .F.
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao 2: Componente -> aba pgComposicao
        WITH par_oPagina.opt_4c_Navegacao.Buttons(2)
            .Caption       = "Componen\<te"
            .BackStyle = 0
            .Picture       = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
            .Top           = 5
            .Left          = 80
            .Width         = 75
            .Height        = 75
            .Style         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .WordWrap      = .F.
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao 3: Custo -> aba pgCusto (6a aba; o legado desenha em Left=380)
        WITH par_oPagina.opt_4c_Navegacao.Buttons(3)
            .Caption       = "C\<usto"
            .BackStyle = 0
            .Picture       = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
            .Top           = 5
            .Left          = 380
            .Width         = 75
            .Height        = 75
            .Style         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .WordWrap      = .F.
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao 4: Fiscal -> aba pgDadosFiscais
        WITH par_oPagina.opt_4c_Navegacao.Buttons(4)
            .Caption       = "\<Fiscal"
            .BackStyle = 0
            .Picture       = gc_4c_CaminhoIcones + "geral_nota_60.jpg"
            .Top           = 5
            .Left          = 155
            .Width         = 75
            .Height        = 75
            .Style         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .WordWrap      = .F.
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao 5: Processo -> aba PgDadosFaseP
        WITH par_oPagina.opt_4c_Navegacao.Buttons(5)
            .Caption       = "P\<rocesso"
            .BackStyle = 0
            .Picture       = gc_4c_CaminhoIcones + "geral_cronometro_60.jpg"
            .Top           = 5
            .Left          = 230
            .Width         = 75
            .Height        = 75
            .Style         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .WordWrap      = .F.
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao 6: Consumo -> aba PgDadosConsP
        WITH par_oPagina.opt_4c_Navegacao.Buttons(6)
            .Caption       = "Co\<nsumo"
            .BackStyle = 0
            .Picture       = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
            .Top           = 5
            .Left          = 305
            .Width         = 75
            .Height        = 75
            .Style         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .WordWrap      = .F.
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao 7: Designer -> aba pgDesigner
        WITH par_oPagina.opt_4c_Navegacao.Buttons(7)
            .Caption       = "\<Designer"
            .BackStyle = 0
            .Picture       = gc_4c_CaminhoIcones + "geral_cores_60.jpg"
            .Top           = 5
            .Left          = 455
            .Width         = 75
            .Height        = 75
            .Style         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .WordWrap      = .F.
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao 8: Servico -> aba pgServico
        WITH par_oPagina.opt_4c_Navegacao.Buttons(8)
            .Caption       = "\<Servi" + CHR(231) + "o"
            .BackStyle = 0
            .Picture       = gc_4c_CaminhoIcones + "geral_lapis_60.jpg"
            .Top           = 5
            .Left          = 530
            .Width         = 75
            .Height        = 75
            .Style         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .FontItalic    = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .WordWrap      = .F.
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        BINDEVENT(par_oPagina.opt_4c_Navegacao, "InteractiveChange", ;
            THIS, "AlternarDivisao")
    ENDPROC

    *===========================================================================
    * AlternarDivisao - Troca a aba do pgf_4c_Divisoes conforme o botao marcado
    * Transcricao do DO CASE de Optiongroup1.InteractiveChange do legado:
    *   1 Principal -> pgDados        (PageOrder 1)
    *   2 Componente-> pgComposicao   (PageOrder 2)
    *   3 Custo     -> pgCusto        (PageOrder 6)
    *   4 Fiscal    -> pgDadosFiscais (PageOrder 3)
    *   5 Processo  -> pgDadosFaseP   (PageOrder 4)
    *   6 Consumo   -> pgDadosConsP   (PageOrder 5)
    *   7 Designer  -> pgDesigner     (PageOrder 7)
    *   8 Servico   -> pgServico      (PageOrder 8)
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE AlternarDivisao()
        LOCAL loc_oPagina, loc_nOpcao, loc_nAba, loException

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_nOpcao  = loc_oPagina.opt_4c_Navegacao.Value

            DO CASE
                CASE loc_nOpcao = 1
                    loc_nAba = 1
                CASE loc_nOpcao = 2
                    loc_nAba = 2
                CASE loc_nOpcao = 3
                    loc_nAba = 6
                CASE loc_nOpcao = 4
                    loc_nAba = 3
                CASE loc_nOpcao = 5
                    loc_nAba = 4
                CASE loc_nOpcao = 6
                    loc_nAba = 5
                CASE loc_nOpcao = 7
                    loc_nAba = 7
                CASE loc_nOpcao = 8
                    loc_nAba = 8
                OTHERWISE
                    loc_nAba = 1
            ENDCASE

            loc_oPagina.pgf_4c_Divisoes.ActivePage = loc_nAba
            THIS.this_nDivisaoAtual = loc_nAba

        CATCH TO loException
            MostrarErro("Erro ao alternar a aba de dados:" + CHR(13) + ;
                loException.Message, "FormProduto.AlternarDivisao")
        ENDTRY
    ENDPROC

    *===========================================================================
    * IrParaDivisao - Posiciona o PageFrame interno e a barra de navegacao na
    * aba informada (1..8). O legado sempre volta para "Principal" ao entrar
    * em INSERIR/ALTERAR/CONSULTAR/PROCURAR.
    *
    * O Value do OptionGroup NAO eh o indice da Page: AlternarDivisao traduz
    * (3 Custo -> Page6, 4 Fiscal -> Page3 ...). Aqui fazemos o caminho
    * inverso, para o botao marcado bater com a aba exibida.
    *===========================================================================
    PROCEDURE IrParaDivisao(par_nAba)
        LOCAL loc_oPagina, loc_nAba, loc_nOpcao, loException

        TRY
            loc_nAba = IIF(VARTYPE(par_nAba) = "N" AND BETWEEN(par_nAba, 1, 8), par_nAba, 1)

            DO CASE
                CASE loc_nAba = 1
                    loc_nOpcao = 1
                CASE loc_nAba = 2
                    loc_nOpcao = 2
                CASE loc_nAba = 3
                    loc_nOpcao = 4
                CASE loc_nAba = 4
                    loc_nOpcao = 5
                CASE loc_nAba = 5
                    loc_nOpcao = 6
                CASE loc_nAba = 6
                    loc_nOpcao = 3
                CASE loc_nAba = 7
                    loc_nOpcao = 7
                OTHERWISE
                    loc_nOpcao = 8
            ENDCASE

            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oPagina.pgf_4c_Divisoes.ActivePage = loc_nAba
            loc_oPagina.opt_4c_Navegacao.Value     = loc_nOpcao
            THIS.this_nDivisaoAtual                = loc_nAba

        CATCH TO loException
            MostrarErro("Erro ao posicionar a aba de dados:" + CHR(13) + ;
                loException.Message, "FormProduto.IrParaDivisao")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ObterPaginaDados - Atalho para a aba "Dados Principais" (pgDados legado)
    *===========================================================================
    PROTECTED PROCEDURE ObterPaginaDados()
        RETURN THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere os campos da aba Dados Principais para o BO
    *
    * O mapa campo -> coluna eh a transcricao dos ControlSource do SCX legado
    * (crSigCdPro.<coluna>), coluna por coluna. Campos de DESCRICAO de lookup
    * (Dgru, DsGru, DLin, DCol, Dfor, DesFinP, Duni, _dunip) NAO tem
    * ControlSource no legado: sao so apoio visual e por isso nao entram aqui.
    * Estoques/QtdEsts tambem ficam de fora - o SCX zera o ControlSource deles
    * (sao calculados, nao existem em SigCdPro).
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oPg, loc_oBO, loException
        loc_lResultado = .F.

        TRY
            loc_oPg = THIS.ObterPaginaDados()
            loc_oBO = THIS.this_oBusinessObject

            *-- Identificacao ------------------------------------------------
            loc_oBO.this_cCpros    = ALLTRIM(loc_oPg.txt_4c_Cpro.Value)          && cpros
            loc_oBO.this_cDpros    = ALLTRIM(loc_oPg.txt_4c_Dpro.Value)          && dpros
            loc_oBO.this_cDpro2s   = ALLTRIM(loc_oPg.txt_4c_DPro2s.Value)        && dpro2s
            loc_oBO.this_cCproeqs  = ALLTRIM(loc_oPg.txt_4c_CProEq.Value)        && cproeqs
            loc_oBO.this_nCbars    = ALLTRIM(loc_oPg.txt_4c_Cbar.Value)     && cbars
            loc_oBO.this_nEan13    = ALLTRIM(loc_oPg.txt_4c_EAN13.Value)    && ean13

            *-- Classificacao ------------------------------------------------
            loc_oBO.this_cCgrus    = ALLTRIM(loc_oPg.txt_4c_Cgru.Value)          && cgrus
            loc_oBO.this_cSgrus    = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)         && sgrus
            loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Lin.Value)           && linhas
            loc_oBO.this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Col.Value)           && colecoes
            loc_oBO.this_cMercs    = ALLTRIM(loc_oPg.txt_4c_Merc.Value)          && mercs
            loc_oBO.this_cCclass   = ALLTRIM(loc_oPg.txt_4c_Class.Value)         && cClass
            loc_oBO.this_cIdecpros = ALLTRIM(loc_oPg.txt_4c_IdeCPros.Value)      && IdeCPros
            loc_oBO.this_cConjunts = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)      && Conjunts

            *-- Fornecedor / referencia / modelo ------------------------------
            loc_oBO.this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)          && ifors
            loc_oBO.this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Refs.Value)          && reffs
            loc_oBO.this_cCodfinp  = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)       && CodFinP

            *-- Unidades e localizacao ----------------------------------------
            loc_oBO.this_cCunis    = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)          && cunis
            loc_oBO.this_cCunips   = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)         && cunips
            loc_oBO.this_cLocals   = ALLTRIM(loc_oPg.txt_4c_Local.Value)         && locals

            *-- Situacao (OptionGroup: 1 = Ativo, 2 = Inativo) -----------------
            loc_oBO.this_nSituas   = loc_oPg.obj_4c_Opc_situacao.Value           && situas

            *-- Observacoes livres --------------------------------------------
            loc_oBO.this_cObspes   = ALLTRIM(loc_oPg.txt_4c_Obs1.Value)          && obspes
            loc_oBO.this_cObspeds  = ALLTRIM(loc_oPg.txt_4c_Obs2.Value)          && obspeds
            loc_oBO.this_cObsetqs  = ALLTRIM(loc_oPg.txt_4c_Obs3.Value)          && obsetqs

            *-- Custo / venda e suas moedas -----------------------------------
            loc_oBO.this_nCustofs  = ALLTRIM(loc_oPg.txt_4c_Ctotal.Value)   && custofs
            loc_oBO.this_cMoecusfs = ALLTRIM(loc_oPg.txt_4c_Mctotal.Value)       && moecusfs
            loc_oBO.this_nPvens    = ALLTRIM(loc_oPg.txt_4c_Pvenda.Value)   && pvens
            loc_oBO.this_cMoevs    = ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value)       && moevs
            loc_oBO.this_nFvendas  = ALLTRIM(loc_oPg.txt_4c_Fvenda.Value)   && fvendas
            loc_oBO.this_cMoepvs   = ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value)       && moepvs

            *-- Auditoria: data/usuario de inclusao e de alteracao.
            *-- Os carimbos sao aplicados pelo BO (AplicarCarimboInclusao /
            *-- AplicarCarimboAlteracao); aqui so devolvemos o que ja estava
            *-- gravado, para o UPDATE nao zerar a inclusao original.
            loc_oBO.this_dDtincs   = ConverterParaData(loc_oPg.txt_4c_DtIncs.Value)   && dtincs
            loc_oBO.this_cUsuincs  = ALLTRIM(loc_oPg.txt_4c_Usuario.Value)            && UsuIncs
            loc_oBO.this_dDtalts   = ConverterParaData(loc_oPg.txt_4c_DataAlts.Value) && dtalts
            loc_oBO.this_cUsuaalts = ALLTRIM(loc_oPg.txt_4c_UsuaAlts.Value)           && usuaalts

            loc_oBO.MarcarComoAlterado()
            loc_lResultado = .T.

        CATCH TO loException
            MostrarErro("Erro ao transferir os dados do formul" + CHR(225) + "rio:" + ;
                CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "FormProduto.FormParaBO")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere o BO para os campos da aba Dados Principais
    * Espelho EXATO de FormParaBO (mesma lista de campos, mesma ordem).
    *
    * Os campos de DESCRICAO dos lookups nao existem no BO; sao recarregados
    * por PreencherDescricoesLookup(), que consulta as tabelas de apoio.
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oPg, loc_oBO, loException
        loc_lResultado = .F.

        TRY
            loc_oPg = THIS.ObterPaginaDados()
            loc_oBO = THIS.this_oBusinessObject

            *-- Identificacao ------------------------------------------------
            loc_oPg.txt_4c_Cpro.Value    = ALLTRIM(loc_oBO.this_cCpros)
            loc_oPg.txt_4c_Dpro.Value    = ALLTRIM(loc_oBO.this_cDpros)
            loc_oPg.txt_4c_DPro2s.Value  = ALLTRIM(loc_oBO.this_cDpro2s)
            loc_oPg.txt_4c_CProEq.Value  = ALLTRIM(loc_oBO.this_cCproeqs)
            loc_oPg.txt_4c_Cbar.Value    = THIS.FormatarNumeroTexto(loc_oBO.this_nCbars, 0)
            loc_oPg.txt_4c_EAN13.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nEan13, 0)

            *-- Classificacao ------------------------------------------------
            loc_oPg.txt_4c_Cgru.Value     = ALLTRIM(loc_oBO.this_cCgrus)
            loc_oPg.txt_4c_CSGru.Value    = ALLTRIM(loc_oBO.this_cSgrus)
            loc_oPg.txt_4c_Lin.Value      = ALLTRIM(loc_oBO.this_cLinhas)
            loc_oPg.txt_4c_Col.Value      = ALLTRIM(loc_oBO.this_cColecoes)
            loc_oPg.txt_4c_Merc.Value     = ALLTRIM(loc_oBO.this_cMercs)
            loc_oPg.txt_4c_Class.Value    = ALLTRIM(loc_oBO.this_cCclass)
            loc_oPg.txt_4c_IdeCPros.Value = ALLTRIM(loc_oBO.this_cIdecpros)
            loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(loc_oBO.this_cConjunts)

            *-- Fornecedor / referencia / modelo ------------------------------
            loc_oPg.txt_4c_Ifor.Value    = ALLTRIM(loc_oBO.this_cIfors)
            loc_oPg.txt_4c_Refs.Value    = ALLTRIM(loc_oBO.this_cReffs)
            loc_oPg.txt_4c_CodFinP.Value = ALLTRIM(loc_oBO.this_cCodfinp)

            *-- Unidades e localizacao ----------------------------------------
            loc_oPg.txt_4c_Cuni.Value  = ALLTRIM(loc_oBO.this_cCunis)
            loc_oPg.txt_4c_Cunip.Value = ALLTRIM(loc_oBO.this_cCunips)
            loc_oPg.txt_4c_Local.Value = ALLTRIM(loc_oBO.this_cLocals)

            *-- Situacao: o OptionGroup so aceita 1 ou 2 (Ativo / Inativo)
            loc_oPg.obj_4c_Opc_situacao.Value = IIF(loc_oBO.this_nSituas = 2, 2, 1)

            *-- Observacoes livres --------------------------------------------
            loc_oPg.txt_4c_Obs1.Value = ALLTRIM(loc_oBO.this_cObspes)
            loc_oPg.txt_4c_Obs2.Value = ALLTRIM(loc_oBO.this_cObspeds)
            loc_oPg.txt_4c_Obs3.Value = ALLTRIM(loc_oBO.this_cObsetqs)

            *-- Custo / venda e suas moedas -----------------------------------
            loc_oPg.txt_4c_Ctotal.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nCustofs, 3)
            loc_oPg.txt_4c_Mctotal.Value  = ALLTRIM(loc_oBO.this_cMoecusfs)
            loc_oPg.txt_4c_Pvenda.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nPvens, 5)
            loc_oPg.txt_4c_Mpvenda.Value  = ALLTRIM(loc_oBO.this_cMoevs)
            loc_oPg.txt_4c_Fvenda.Value   = THIS.FormatarNumeroTexto(loc_oBO.this_nFvendas, 3)
            loc_oPg.txt_4c_Mfvenda.Value  = ALLTRIM(loc_oBO.this_cMoepvs)

            *-- Auditoria -----------------------------------------------------
            loc_oPg.txt_4c_DtIncs.Value   = THIS.FormatarDataTexto(loc_oBO.this_dDtincs)
            loc_oPg.txt_4c_Usuario.Value  = ALLTRIM(loc_oBO.this_cUsuincs)
            loc_oPg.txt_4c_DataAlts.Value = THIS.FormatarDataTexto(loc_oBO.this_dDtalts)
            loc_oPg.txt_4c_UsuaAlts.Value = ALLTRIM(loc_oBO.this_cUsuaalts)

            *-- Descricoes dos lookups (nao existem em SigCdPro)
            THIS.PreencherDescricoesLookup()

            loc_lResultado = .T.

        CATCH TO loException
            MostrarErro("Erro ao exibir os dados do produto:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "FormProduto.BOParaForm")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarNumeroTexto - Converte numerico para o texto exibido no TextBox
    * Os TextBox numericos desta aba sao de tipo Caractere (o legado usa
    * ControlSource direto na coluna; aqui o valor entra como texto), entao a
    * conversao passa por aqui em vez de atribuir o numero cru.
    *===========================================================================
    PROTECTED PROCEDURE FormatarNumeroTexto(par_nValor, par_nDecimais)
        LOCAL loc_nValor, loc_nDec, loc_cTexto
        loc_nValor = IIF(VARTYPE(par_nValor) = "N", par_nValor, 0)
        loc_nDec   = IIF(VARTYPE(par_nDecimais) = "N", par_nDecimais, 0)
        loc_cTexto = ""

        IF loc_nValor != 0
            IF loc_nDec > 0
                loc_cTexto = ALLTRIM(STR(loc_nValor, 20, loc_nDec))
            ELSE
                loc_cTexto = ALLTRIM(STR(loc_nValor, 20, 0))
            ENDIF
        ENDIF

        RETURN loc_cTexto
    ENDPROC

    *===========================================================================
    * FormatarDataTexto - Converte DATE/DATETIME para o texto do TextBox
    * Regra #16: NUNCA TTOD() direto - o valor chega como DATE (campo em
    * branco) ou DATETIME (vindo do SQL Server) conforme o caminho.
    *===========================================================================
    PROTECTED PROCEDURE FormatarDataTexto(par_uData)
        LOCAL loc_dData, loc_cTexto
        loc_cTexto = ""
        loc_dData  = ConverterParaData(par_uData)

        IF VARTYPE(loc_dData) = "D" AND !EMPTY(loc_dData)
            loc_cTexto = DTOC(loc_dData)
        ENDIF

        RETURN loc_cTexto
    ENDPROC

    *===========================================================================
    * PreencherDescricoesLookup - Recarrega os campos de descricao dos lookups
    * (Grupo, Subgrupo, Linha, Colecao, Fornecedor, Modelo, Unidades). Eles nao
    * existem em SigCdPro, por isso sao consultados nas tabelas de apoio.
    *===========================================================================
    PROTECTED PROCEDURE PreencherDescricoesLookup()
        LOCAL loc_oPg, loc_cGrupo, loException
        loc_oPg = THIS.ObterPaginaDados()

        TRY
            loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_Cgru.Value)

            loc_oPg.txt_4c_Dgru.Value = THIS.ObterDescricaoTabela("SigCdGrp", ;
                "dgrus", "cgrus", loc_cGrupo, "")

            loc_oPg.txt_4c_DsGru.Value = THIS.ObterDescricaoTabela("SigCdPsg", ;
                "Descricaos", "Codigos", ALLTRIM(loc_oPg.txt_4c_CSGru.Value), ;
                IIF(EMPTY(loc_cGrupo), "", "CGrus = " + EscaparSQL(PADR(loc_cGrupo, 3))))

            loc_oPg.txt_4c_DLin.Value = THIS.ObterDescricaoTabela("SigCdLin", ;
                "Descs", "Linhas", ALLTRIM(loc_oPg.txt_4c_Lin.Value), "")

            loc_oPg.txt_4c_DCol.Value = THIS.ObterDescricaoTabela("SigCdCol", ;
                "Descs", "Colecoes", ALLTRIM(loc_oPg.txt_4c_Col.Value), "")

            loc_oPg.txt_4c_Dfor.Value = THIS.ObterDescricaoTabela("SigCdCli", ;
                "Rclis", "Iclis", ALLTRIM(loc_oPg.txt_4c_Ifor.Value), "")

            loc_oPg.txt_4c_DesFinP.Value = THIS.ObterDescricaoTabela("SigCdFip", ;
                "Descs", "Cods", ALLTRIM(loc_oPg.txt_4c_CodFinP.Value), "")

            loc_oPg.txt_4c_Duni.Value = THIS.ObterDescricaoTabela("SigCdUni", ;
                "DUnis", "CUnis", ALLTRIM(loc_oPg.txt_4c_Cuni.Value), "")

            loc_oPg.txt_4c__dunip.Value = THIS.ObterDescricaoTabela("SigCdUni", ;
                "DUnis", "CUnis", ALLTRIM(loc_oPg.txt_4c_Cunip.Value), "")

        CATCH TO loException
            MostrarErro("Erro ao carregar as descri" + CHR(231) + CHR(245) + "es:" + ;
                CHR(13) + loException.Message, "FormProduto.PreencherDescricoesLookup")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ObterDescricaoTabela - Le UMA descricao de uma tabela de apoio
    * Devolve "" quando o codigo esta vazio ou nao existe (sem mensagem: aqui
    * a ausencia de descricao nao eh erro, eh campo em branco).
    *===========================================================================
    PROTECTED PROCEDURE ObterDescricaoTabela(par_cTabela, par_cCampoDesc, ;
            par_cCampoChave, par_cValor, par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loException
        loc_cDescricao = ""

        IF EMPTY(ALLTRIM(NVL(par_cValor, "")))
            RETURN ""
        ENDIF

        *-- Sem conexao (validacao de UI / teste headless) nao ha o que
        *-- consultar. Sai antes do SQLEXEC: senao cada um dos 8 lookups de
        *-- PreencherDescricoesLookup abriria o seu proprio dialogo de erro.
        *-- O CATCH abaixo continua reportando falha REAL de SQL (regra #9).
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN ""
        ENDIF

        TRY
            IF USED("cursor_4c_DescAux")
                USE IN cursor_4c_DescAux
            ENDIF

            loc_cSQL = "SELECT " + par_cCampoDesc + " FROM " + par_cTabela + ;
                " WHERE " + par_cCampoChave + " = " + EscaparSQL(ALLTRIM(par_cValor))

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescAux")

            IF loc_nResultado >= 0 AND USED("cursor_4c_DescAux")
                IF RECCOUNT("cursor_4c_DescAux") > 0
                    SELECT cursor_4c_DescAux
                    GO TOP
                    loc_cDescricao = ALLTRIM(NVL(EVALUATE("cursor_4c_DescAux." + par_cCampoDesc), ""))
                ENDIF
            ENDIF

            IF USED("cursor_4c_DescAux")
                USE IN cursor_4c_DescAux
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao consultar " + par_cTabela + ":" + CHR(13) + ;
                loException.Message, "FormProduto.ObterDescricaoTabela")
            loc_cDescricao = ""
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

    *===========================================================================
    * LimparCampos - Zera todos os campos da aba Dados Principais
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg, loException

        TRY
            loc_oPg = THIS.ObterPaginaDados()

            STORE "" TO loc_oPg.txt_4c_Cpro.Value,     loc_oPg.txt_4c_Dpro.Value, ;
                        loc_oPg.txt_4c_DPro2s.Value,   loc_oPg.txt_4c_CProEq.Value, ;
                        loc_oPg.txt_4c_Cbar.Value,     loc_oPg.txt_4c_EAN13.Value

            STORE "" TO loc_oPg.txt_4c_Cgru.Value,     loc_oPg.txt_4c_Dgru.Value, ;
                        loc_oPg.txt_4c_CSGru.Value,    loc_oPg.txt_4c_DsGru.Value, ;
                        loc_oPg.txt_4c_Lin.Value,      loc_oPg.txt_4c_DLin.Value, ;
                        loc_oPg.txt_4c_Col.Value,      loc_oPg.txt_4c_DCol.Value

            STORE "" TO loc_oPg.txt_4c_Merc.Value,     loc_oPg.txt_4c_Class.Value, ;
                        loc_oPg.txt_4c_IdeCPros.Value, loc_oPg.txt_4c_Conjunto.Value

            STORE "" TO loc_oPg.txt_4c_Ifor.Value,     loc_oPg.txt_4c_Dfor.Value, ;
                        loc_oPg.txt_4c_Refs.Value,     loc_oPg.txt_4c_CodFinP.Value, ;
                        loc_oPg.txt_4c_DesFinP.Value

            STORE "" TO loc_oPg.txt_4c_Cuni.Value,     loc_oPg.txt_4c_Duni.Value, ;
                        loc_oPg.txt_4c_Cunip.Value,    loc_oPg.txt_4c__dunip.Value, ;
                        loc_oPg.txt_4c_Local.Value

            STORE "" TO loc_oPg.txt_4c_Obs1.Value,     loc_oPg.txt_4c_Obs2.Value, ;
                        loc_oPg.txt_4c_Obs3.Value

            STORE "" TO loc_oPg.txt_4c_Ctotal.Value,   loc_oPg.txt_4c_Mctotal.Value, ;
                        loc_oPg.txt_4c_Pvenda.Value,   loc_oPg.txt_4c_Mpvenda.Value, ;
                        loc_oPg.txt_4c_Fvenda.Value,   loc_oPg.txt_4c_Mfvenda.Value

            STORE "" TO loc_oPg.txt_4c_Estoques.Value, loc_oPg.txt_4c_QtdEsts.Value

            STORE "" TO loc_oPg.txt_4c_DtIncs.Value,   loc_oPg.txt_4c_Usuario.Value, ;
                        loc_oPg.txt_4c_DataAlts.Value, loc_oPg.txt_4c_UsuaAlts.Value

            *-- Situacao volta para Ativo (default do legado ao incluir)
            loc_oPg.obj_4c_Opc_situacao.Value = 1

            *-- Guarda de reentrancia dos lookups (regra #45)
            THIS.this_cUltimoGrupoValidado = ""

        CATCH TO loException
            MostrarErro("Erro ao limpar os campos:" + CHR(13) + ;
                loException.Message, "FormProduto.LimparCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Liga/desliga a edicao dos campos da aba Dados
    *
    * Tres estados, transcritos do legado:
    *   INCLUIR / ALTERAR -> tudo editavel, menos os campos calculados
    *                        (getCtotal/getPvenda/getFvenda/getEstoques/
    *                        getQtdEsts/Get_DtIncs/Get_Usuario/getDataAlts/
    *                        getUsuaAlts, que tem When = .F. no SCX)
    *   BUSCAR            -> SOMENTE os 7 campos plProcurar = .T. do SCX
    *                        (getCpro, getDpro, getDpro2s, getRefs, getIfor,
    *                        getCbar, getConjunto) - msv_procurar so le esses
    *   VISUALIZAR/EXCLUIR-> nada editavel
    *
    * O codigo do produto segue a mesma regra do legado: so eh digitavel
    * enquanto se INCLUI ou se PROCURA - em ALTERAR ele eh a chave.
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lEdita, loc_lProcura, loc_lChave, loException

        TRY
            loc_oPg      = THIS.ObterPaginaDados()
            loc_lProcura = (THIS.this_cModoAtual == "BUSCAR")
            loc_lEdita   = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.) ;
                           AND !loc_lProcura
            loc_lChave   = (loc_lEdita AND THIS.this_cModoAtual == "INCLUIR") OR loc_lProcura

            *-- Campos plProcurar: editaveis em INCLUIR/ALTERAR e em BUSCAR
            loc_oPg.txt_4c_Cpro.Enabled     = loc_lChave
            loc_oPg.txt_4c_Dpro.Enabled     = loc_lEdita OR loc_lProcura
            loc_oPg.txt_4c_DPro2s.Enabled   = loc_lEdita OR loc_lProcura
            loc_oPg.txt_4c_Refs.Enabled     = loc_lEdita OR loc_lProcura
            loc_oPg.txt_4c_Ifor.Enabled     = loc_lEdita OR loc_lProcura
            loc_oPg.txt_4c_Cbar.Enabled     = loc_lEdita OR loc_lProcura
            loc_oPg.txt_4c_Conjunto.Enabled = loc_lEdita OR loc_lProcura

            *-- Demais campos: so em INCLUIR / ALTERAR
            loc_oPg.txt_4c_CProEq.Enabled = loc_lEdita
            loc_oPg.txt_4c_EAN13.Enabled  = loc_lEdita

            loc_oPg.txt_4c_Cgru.Enabled     = loc_lEdita
            loc_oPg.txt_4c_Dgru.Enabled     = loc_lEdita
            loc_oPg.txt_4c_CSGru.Enabled    = loc_lEdita
            loc_oPg.txt_4c_DsGru.Enabled    = loc_lEdita
            loc_oPg.txt_4c_Lin.Enabled      = loc_lEdita
            loc_oPg.txt_4c_DLin.Enabled     = loc_lEdita
            loc_oPg.txt_4c_Col.Enabled      = loc_lEdita
            loc_oPg.txt_4c_DCol.Enabled     = loc_lEdita
            loc_oPg.txt_4c_Class.Enabled    = loc_lEdita
            loc_oPg.txt_4c_IdeCPros.Enabled = loc_lEdita

            loc_oPg.txt_4c_Dfor.Enabled     = loc_lEdita
            loc_oPg.txt_4c_CodFinP.Enabled  = loc_lEdita
            loc_oPg.txt_4c_DesFinP.Enabled  = loc_lEdita

            loc_oPg.txt_4c_Cuni.Enabled     = loc_lEdita
            loc_oPg.txt_4c_Duni.Enabled     = loc_lEdita
            loc_oPg.txt_4c_Cunip.Enabled    = loc_lEdita
            loc_oPg.txt_4c__dunip.Enabled   = loc_lEdita
            loc_oPg.txt_4c_Local.Enabled    = loc_lEdita

            loc_oPg.txt_4c_Obs1.Enabled     = loc_lEdita
            loc_oPg.txt_4c_Obs2.Enabled     = loc_lEdita
            loc_oPg.txt_4c_Obs3.Enabled     = loc_lEdita

            loc_oPg.txt_4c_Mctotal.Enabled  = loc_lEdita
            loc_oPg.txt_4c_Mpvenda.Enabled  = loc_lEdita
            loc_oPg.txt_4c_Mfvenda.Enabled  = loc_lEdita

            loc_oPg.obj_4c_Opc_situacao.Enabled = loc_lEdita

            *-- Botoes de lookup / acao ao lado dos campos (legado usa o mesmo
            *-- InList(pcEscolha,'INSERIR','ALTERAR') no When deles)
            loc_oPg.obj_4c_CmdConjunto.Enabled    = loc_lEdita
            loc_oPg.obj_4c_CmdLocConj.Enabled     = loc_lEdita
            loc_oPg.obj_4c_Bot_Fornecedor.Enabled = loc_lEdita
            loc_oPg.obj_4c_CmdgFigura.Enabled     = loc_lEdita

            *-- Campos calculados: NUNCA editaveis (When = .F. no SCX)
            loc_oPg.txt_4c_Merc.Enabled     = .F.
            loc_oPg.txt_4c_Ctotal.Enabled   = .F.
            loc_oPg.txt_4c_Pvenda.Enabled   = .F.
            loc_oPg.txt_4c_Fvenda.Enabled   = .F.
            loc_oPg.txt_4c_Estoques.Enabled = .F.
            loc_oPg.txt_4c_QtdEsts.Enabled  = .F.
            loc_oPg.txt_4c_DtIncs.Enabled   = .F.
            loc_oPg.txt_4c_Usuario.Enabled  = .F.
            loc_oPg.txt_4c_DataAlts.Enabled = .F.
            loc_oPg.txt_4c_UsuaAlts.Enabled = .F.

        CATCH TO loException
            MostrarErro("Erro ao habilitar os campos:" + CHR(13) + ;
                loException.Message, "FormProduto.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Estado dos botoes conforme o modo atual
    *
    * Regra #40 do CLAUDE.md (Erro176): quem DESABILITA tem de REABILITAR no
    * funil de volta. Por isso AlternarPagina(1) repoe o modo LISTA e chama
    * este metodo - sem depender de cada caller lembrar.
    *
    * Modo EXCLUIR nao existe aqui (a exclusao eh feita direto da Lista), mas
    * o padrao frmcadastro mantem Cancelar SEMPRE habilitado na pagina Dados.
    *
    * PUBLIC: o TesteAutomatico.prg chama THIS.oForm.AjustarBotoesPorModo() de
    * FORA da classe (CLAUDE.md regra #3).
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes, loc_oAcao, loc_lLista, loc_lEdicao, loException

        TRY
            loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_oAcao   = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

            loc_lLista  = (THIS.this_cModoAtual == "LISTA")
            loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")

            *-- Botoes CRUD da pagina Lista
            loc_oBotoes.cmd_4c_Incluir.Enabled    = loc_lLista
            loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lLista
            loc_oBotoes.cmd_4c_Alterar.Enabled    = loc_lLista
            loc_oBotoes.cmd_4c_Excluir.Enabled    = loc_lLista
            loc_oBotoes.cmd_4c_Buscar.Enabled     = loc_lLista

            *-- Confirmar so quando ha algo a confirmar; Cancelar sempre ativo
            loc_oAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
            loc_oAcao.cmd_4c_Cancelar.Enabled  = .T.

            *-- Confirmar muda de rotulo quando esta procurando (o legado troca
            *-- a acao do mesmo botao em msv_procurar)
            loc_oAcao.cmd_4c_Confirmar.Caption = ;
                IIF(THIS.this_cModoAtual == "BUSCAR", "Procurar", "Confirmar")

        CATCH TO loException
            MostrarErro("Erro ao ajustar os bot" + CHR(245) + "es:" + CHR(13) + ;
                loException.Message, "FormProduto.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirmar da pagina Dados
    *
    * Em modo BUSCAR o botao executa a busca POR EXEMPLO do legado
    * (msv_procurar); nos demais modos grava pelo BO.
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oBO, loException

        IF THIS.this_cModoAtual == "BUSCAR"
            THIS.ExecutarBuscaPorExemplo()
            RETURN
        ENDIF

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            MsgAviso("Nada a confirmar neste modo.")
            RETURN
        ENDIF

        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        loc_oBO = THIS.this_oBusinessObject

        TRY
            IF loc_oBO.Salvar()
                MsgInfo("Produto gravado com sucesso!", "Confirmar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ELSE
                *-- Regra #20: o BusinessBase ja reporta a falha. So completamos
                *-- com o foco no campo que a validacao do BO recusou.
                IF !loc_oBO.this_lErroExibido
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel gravar o produto.", "Confirmar")
                ENDIF
                THIS.FocarCampoValidacao()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao gravar o produto:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "FormProduto.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela a edicao/procura e volta para a Lista
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loException

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CancelarEdicao()
            ENDIF

            THIS.LimparCampos()
            THIS.this_cModoAtual = "LISTA"

            *-- AlternarPagina(1) repoe o modo, recarrega a grade e reabilita
            *-- os botoes CRUD (regra #40)
            THIS.AlternarPagina(1)

        CATCH TO loException
            MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * FocarCampoValidacao - Leva o foco para o campo recusado pelo BO
    * O ProdutoBO preenche this_cPaginaFoco / this_cCampoFoco em ValidarDados.
    * Regra #34: alcancar membro por NOME exige EVALUATE, nunca Controls(nome).
    *===========================================================================
    PROTECTED PROCEDURE FocarCampoValidacao()
        LOCAL loc_oPg, loc_oCampo, loc_cCampo, loc_lProsseguir, loException
        loc_lProsseguir = .T.

        TRY
            loc_cCampo = ALLTRIM(THIS.this_oBusinessObject.this_cCampoFoco)

            IF EMPTY(loc_cCampo)
                loc_lProsseguir = .F.
            ENDIF

            *-- So a aba Dados Principais existe neste form; campos das outras
            *-- abas (FISCAL / COMPOSICAO) sao ignorados sem erro.
            IF loc_lProsseguir
                IF !(UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cPaginaFoco)) == "DADOS")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_oPg = THIS.ObterPaginaDados()

                IF PEMSTATUS(loc_oPg, loc_cCampo, 5)
                    THIS.IrParaDivisao(1)

                    *-- Regra #34: membro por NOME so via EVALUATE. E o
                    *-- resultado precisa de uma variavel - VFP9 nao aceita
                    *-- EVALUATE(...).SetFocus() encadeado.
                    loc_oCampo = EVALUATE("loc_oPg." + loc_cCampo)

                    IF VARTYPE(loc_oCampo) = "O" AND loc_oCampo.Enabled
                        loc_oCampo.SetFocus()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            *-- Falhar ao focar NAO pode esconder a mensagem de validacao
            MostrarErro("Erro ao posicionar o foco:" + CHR(13) + ;
                loException.Message, "FormProduto.FocarCampoValidacao")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ExecutarBuscaPorExemplo - Transcricao da PROCEDURE msv_procurar do legado
    *
    *   pGru = Padr(cntFiltros.getCgru.Value, 3)
    *   pPro = Padr(pgDados.getCpro.Value, 14)     pDes = Padr(getDpro.Value, 40)
    *   pD2s = Padr(getDpro2s.Value, 40)           pRff = Padr(getRefs.Value, 15)
    *   pFor = Padr(getIfor.Value, 10)             pBar = getCbar.Value
    *   pCnj = getconjunto.Value
    *   lcBus = Iif(Empty(pGru), [], [CGrus = ?pGru And ])
    *
    *   Do Case  (a ORDEM eh regra de negocio - o primeiro campo preenchido
    *             vence e os demais sao ignorados)
    *     Case Not Empty(pPro) -> CPros  = pPro
    *     Case Not Empty(pDes) -> DPros  = pDes   (fallback Like %pDes%)
    *     Case Not Empty(pD2s) -> DPro2s = pD2s   (fallback Like %pD2s%)
    *     Case Not Empty(pFor) -> Ifors  = pFor
    *     Case Not Empty(pRff) -> Reffs  = pRff   (fallback Like %pRff%)
    *     Case Not Empty(pCnj) -> Conjunts = pCnj
    *     Case Not Empty(pBar) -> CBars  = pBar
    *   EndCase
    *
    * O lcBus (filtro de grupo) entra SO nos casos DPros e DPro2s, como no
    * legado - nao generalizar para os outros.
    * PUBLIC: chamado por BtnSalvarClick (metodo publico).
    *===========================================================================
    PROCEDURE ExecutarBuscaPorExemplo()
        LOCAL loc_oPg, loc_oFiltros, loc_cTabela, loc_cBus, loc_cFiltro
        LOCAL loc_cPro, loc_cDes, loc_cD2s, loc_cRff, loc_cFor, loc_cBar, loc_cCnj
        LOCAL loc_cGru, loc_lTemFiltro, loc_lLike, loc_cMsgParcial, loException

        TRY
            loc_oPg      = THIS.ObterPaginaDados()
            loc_oFiltros = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros

            loc_cGru = PADR(ALLTRIM(loc_oFiltros.txt_4c_Cgru.Value), 3)
            loc_cPro = PADR(ALLTRIM(loc_oPg.txt_4c_Cpro.Value), 14)
            loc_cDes = PADR(ALLTRIM(loc_oPg.txt_4c_Dpro.Value), 40)
            loc_cD2s = PADR(ALLTRIM(loc_oPg.txt_4c_DPro2s.Value), 40)
            loc_cRff = PADR(ALLTRIM(loc_oPg.txt_4c_Refs.Value), 15)
            loc_cFor = PADR(ALLTRIM(loc_oPg.txt_4c_Ifor.Value), 10)
            loc_cBar = ALLTRIM(loc_oPg.txt_4c_Cbar.Value)
            loc_cCnj = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)

            *-- ThisForm.Tipo2 escolhe a tabela (SigCdPrc x SigCdPro)
            loc_cTabela = IIF(THIS.this_lTipo2, "SigCdPrc", "SigCdPro")

            *-- lcBus: so usado nos casos DPros / DPro2s
            loc_cBus = IIF(EMPTY(ALLTRIM(loc_cGru)), "", ;
                "cgrus = " + EscaparSQL(loc_cGru) + " AND ")

            loc_cFiltro    = ""
            loc_cMsgParcial = ""
            loc_lTemFiltro = .T.
            loc_lLike      = .F.

            DO CASE
                CASE !EMPTY(ALLTRIM(loc_cPro))
                    loc_cFiltro = "cpros = " + EscaparSQL(ALLTRIM(loc_cPro))

                CASE !EMPTY(ALLTRIM(loc_cDes))
                    loc_cFiltro     = loc_cBus + "dpros = " + EscaparSQL(ALLTRIM(loc_cDes))
                    loc_lLike       = .T.
                    loc_cMsgParcial = "N" + CHR(227) + "o Foi Encontrada Uma Descri" + ;
                        CHR(231) + CHR(227) + "o Igual a Digitada!!!" + CHR(13) + ;
                        "Deseja Procurar Parte da Descri" + CHR(231) + CHR(227) + "o?"

                CASE !EMPTY(ALLTRIM(loc_cD2s))
                    loc_cFiltro     = loc_cBus + "dpro2s = " + EscaparSQL(ALLTRIM(loc_cD2s))
                    loc_lLike       = .T.
                    loc_cMsgParcial = "N" + CHR(227) + "o Foi Encontrado Um Descritivo Igual " + ;
                        "ao Digitado!!!" + CHR(13) + ;
                        "Deseja Procurar Parte da Descri" + CHR(231) + CHR(227) + "o?"

                CASE !EMPTY(ALLTRIM(loc_cFor))
                    loc_cFiltro = "ifors = " + EscaparSQL(ALLTRIM(loc_cFor))

                CASE !EMPTY(ALLTRIM(loc_cRff))
                    loc_cFiltro     = "reffs = " + EscaparSQL(ALLTRIM(loc_cRff))
                    loc_lLike       = .T.
                    loc_cMsgParcial = "N" + CHR(227) + "o Foi Encontrada Uma Refer" + CHR(234) + ;
                        "ncia Igual a Digitada!!!" + CHR(13) + ;
                        "Deseja Procurar Parte da Refer" + CHR(234) + "ncia?"

                CASE !EMPTY(loc_cCnj)
                    loc_cFiltro = "conjunts = " + EscaparSQL(loc_cCnj)

                CASE !EMPTY(loc_cBar)
                    loc_cFiltro = "cbars = " + FormatarNumeroSQL(VAL(loc_cBar), 0)

                OTHERWISE
                    loc_lTemFiltro = .F.
            ENDCASE

            IF !loc_lTemFiltro
                MsgAviso("Informe ao menos um campo de procura: Produto, " + ;
                    "Descri" + CHR(231) + CHR(227) + "o, Descritivo," + CHR(13) + ;
                    "Ref. Fornecedor, Fornecedor, Barra ou Cod. Pai.", "Procurar")
            ELSE
                THIS.AplicarResultadoBusca(loc_cTabela, loc_cFiltro, loc_lLike, ;
                    loc_cMsgParcial, loc_cBus, loc_cDes, loc_cD2s, loc_cRff)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao procurar o produto:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormProduto.ExecutarBuscaPorExemplo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AplicarResultadoBusca - Executa a consulta da busca por exemplo, aplica o
    * fallback "parte da descricao" do legado e devolve o resultado para a
    * grade da Lista.
    *
    * O legado insere os achados em crProcurar e habilita a navegacao; aqui o
    * equivalente natural eh recarregar cursor_4c_Dados (a propria grade da
    * pagina Lista) e voltar para ela - o usuario ve exatamente os produtos
    * que a procura encontrou.
    *===========================================================================
    PROTECTED PROCEDURE AplicarResultadoBusca(par_cTabela, par_cFiltro, ;
            par_lLike, par_cMsgParcial, par_cBus, par_cDes, par_cD2s, par_cRff)
        LOCAL loc_cSQL, loc_nResultado, loc_nAchados, loc_cFiltro, loException

        loc_cFiltro  = par_cFiltro
        loc_nAchados = 0

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT " + THIS.ObterColunasBusca() + " FROM " + par_cTabela + ;
                " WHERE " + loc_cFiltro + " ORDER BY cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao procurar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_nAchados = RECCOUNT("cursor_4c_Dados")

                *-- Fallback do legado: sem resultado exato, pergunta se quer
                *-- procurar PARTE do texto (Rtrim(<campo>) Like '%valor%')
                IF loc_nAchados < 1 AND par_lLike
                    IF MsgConfirma(par_cMsgParcial, "Procura")
                        loc_cFiltro = THIS.MontarFiltroParcial(par_cFiltro, par_cBus, ;
                            par_cDes, par_cD2s, par_cRff)

                        IF USED("cursor_4c_Dados")
                            USE IN cursor_4c_Dados
                        ENDIF

                        loc_cSQL = "SELECT " + THIS.ObterColunasBusca() + ;
                            " FROM " + par_cTabela + " WHERE " + loc_cFiltro + ;
                            " ORDER BY cpros"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                        IF loc_nResultado < 0
                            MsgErro("Erro ao procurar produtos:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                        ELSE
                            loc_nAchados = RECCOUNT("cursor_4c_Dados")
                        ENDIF
                    ENDIF
                ENDIF

                IF loc_nAchados < 1
                    MsgAviso("Nenhum produto encontrado com os dados informados.", "Procurar")
                ELSE
                    GO TOP IN cursor_4c_Dados

                    *-- Volta para a Lista mostrando o resultado. A grade eh
                    *-- religada aqui porque AlternarPagina(1) recarregaria o
                    *-- cursor pelos filtros da Lista e descartaria a procura.
                    THIS.this_cModoAtual = "LISTA"
                    THIS.LimparCampos()
                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.VincularGradeLista()
                    THIS.AjustarBotoesPorModo()
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao aplicar o resultado da procura:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormProduto.AplicarResultadoBusca")
        ENDTRY
    ENDPROC

    *===========================================================================
    * MontarFiltroParcial - Troca a igualdade pelo Like do legado
    *   Rtrim(DPros)  Like '%<valor>%'
    *   Rtrim(DPro2s) Like '%<valor>%'
    *   Rtrim(Reffs)  Like '%<valor>%'
    * O legado mantem o filtro de grupo (lcBus) em DPros/DPro2s e NAO o aplica
    * em Reffs - reproduzido igual.
    *===========================================================================
    PROTECTED PROCEDURE MontarFiltroParcial(par_cFiltroOriginal, par_cBus, ;
            par_cDes, par_cD2s, par_cRff)
        LOCAL loc_cFiltro
        loc_cFiltro = par_cFiltroOriginal

        DO CASE
            CASE "dpros = " $ LOWER(par_cFiltroOriginal)
                loc_cFiltro = par_cBus + "RTRIM(dpros) LIKE " + ;
                    EscaparSQL("%" + ALLTRIM(par_cDes) + "%")

            CASE "dpro2s = " $ LOWER(par_cFiltroOriginal)
                loc_cFiltro = par_cBus + "RTRIM(dpro2s) LIKE " + ;
                    EscaparSQL("%" + ALLTRIM(par_cD2s) + "%")

            CASE "reffs = " $ LOWER(par_cFiltroOriginal)
                loc_cFiltro = "RTRIM(reffs) LIKE " + ;
                    EscaparSQL("%" + ALLTRIM(par_cRff) + "%")
        ENDCASE

        RETURN loc_cFiltro
    ENDPROC

    *===========================================================================
    * ObterColunasBusca - Colunas do SELECT da procura
    * TEM de coincidir com as colunas que a grade da Lista usa em
    * VincularGradeLista (regra Grid-SQL: ControlSource sem coluna no SELECT
    * estoura "Variable not found").
    *===========================================================================
    PROTECTED PROCEDURE ObterColunasBusca()
        RETURN "cpros, dpros, dpro2s, cgrus, sgrus, reffs, colecoes," + ;
            " impetiqs, situas, encoms, cbars, cproeqs, compos, codcors," + ;
            " usuaalts, dtalts"
    ENDPROC

    *===========================================================================
    * VincularGradeLista - Religa a grade da Lista ao cursor_4c_Dados
    *
    * Extraido de CarregarLista para poder ser reutilizado pela procura, que
    * popula o MESMO cursor por outro caminho. Regra #41 / Problema 48:
    * RecordSource PRIMEIRO, depois ControlSource, Width e Header.
    *===========================================================================
    PROTECTED PROCEDURE VincularGradeLista()
        LOCAL loc_oGrid, loException

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

            loc_oGrid.RecordSource = ""
            loc_oGrid.ColumnCount = 6
            loc_oGrid.RecordSource = "cursor_4c_Dados"

            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
            loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
            loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
            loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
            loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.usuaalts"
            loc_oGrid.Column7.chk_4c_Inativo.ControlSource = "cursor_4c_Dados.situas = 2"

            loc_oGrid.Column1.Width = 90
            loc_oGrid.Column2.Width = 380
            loc_oGrid.Column3.Width = 50
            loc_oGrid.Column4.Width = 70
            loc_oGrid.Column5.Width = 140
            loc_oGrid.Column6.Width = 100
            loc_oGrid.Column7.Width = 30

            loc_oGrid.Column1.Header1.Caption = "Produto"
            loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oGrid.Column3.Header1.Caption = "Grupo"
            loc_oGrid.Column4.Header1.Caption = "Subgrp."
            loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
            loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
            loc_oGrid.Column7.Header1.Caption = "I"

            THIS.FormatarGridLista(loc_oGrid)
            THIS.AtualizarContadorProdutos()

            loc_oGrid.Refresh()

        CATCH TO loException
            MostrarErro("Erro ao vincular a grade:" + CHR(13) + ;
                loException.Message, "FormProduto.VincularGradeLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarConjuntoDados - LostFocus de txt_4c_Conjunto (Cod. Pai)
    * Legado (getConjunto.Valid): procura o conjunto na lista de conjuntos ja
    * cadastrados e, no fim, normaliza para 6 digitos com Padl(...,6,'0').
    *===========================================================================
    PROCEDURE ValidarConjuntoDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.ObterPaginaDados()
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        *-- Padl(this.Value, 6, '0') do legado
        loc_oPg.txt_4c_Conjunto.Value = PADL(loc_cValor, 6, "0")
    ENDPROC

    *===========================================================================
    * BtnGerarConjuntoClick - cmdConjunto: gera um Cod. Pai novo
    * Legado: lcConjunto = Transform(fGerUniqueKey([CONJUNTO]), [@L 999999]),
    * so quando o campo esta vazio. fGerUniqueKey nao foi portada; aqui o
    * proximo numero sai do MAX(Conjunts) ja gravado em SigCdPro, que produz
    * o mesmo efeito (sequencial de 6 digitos) sem inventar tabela nova.
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnGerarConjuntoClick()
        LOCAL loc_oPg, loc_cSQL, loc_nResultado, loc_nProximo, loException
        loc_oPg = THIS.ObterPaginaDados()

        *-- "If Empty(crSigCdPro.Conjunts)" do legado
        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Conjunto.Value))
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_MaxConj")
                USE IN cursor_4c_MaxConj
            ENDIF

            loc_cSQL = "SELECT MAX(CAST(conjunts AS INT)) AS ultimo FROM SigCdPro" + ;
                " WHERE conjunts <> '' AND ISNUMERIC(conjunts) = 1"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxConj")

            IF loc_nResultado < 0
                MsgErro("Erro ao gerar o Cod. Pai:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_nProximo = NVL(cursor_4c_MaxConj.ultimo, 0) + 1
                loc_oPg.txt_4c_Conjunto.Value = PADL(ALLTRIM(STR(loc_nProximo, 10, 0)), 6, "0")
            ENDIF

            IF USED("cursor_4c_MaxConj")
                USE IN cursor_4c_MaxConj
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao gerar o Cod. Pai:" + CHR(13) + ;
                loException.Message, "FormProduto.BtnGerarConjuntoClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnLocalizarConjuntoClick - cmdLocConj: localiza um Cod. Pai existente
    * Legado: Do Form SigOpBus ... To lcProduto + Padl(lcProduto, 6, '0').
    * SigOpBus nao existe no sistema novo; o equivalente eh o picker padrao
    * sobre os conjuntos ja gravados em SigCdPro.
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnLocalizarConjuntoClick()
        LOCAL loc_oPg, loc_oBusca, loc_cValor, loException
        loc_oPg    = THIS.ObterPaginaDados()
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conjunto.Value)

        TRY
            *-- 1o argumento = HANDLE da conexao (regra #36)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaConj", "conjunts", loc_cValor, ;
                "Cod. Pai", .T., .T., "conjunts <> ''")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Regra #37: Show SO quando o Init nao resolveu sozinho
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("conjunts", "", "Cod. Pai")
                    loc_oBusca.mAddColuna("cpros", "", "Produto")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                *-- Regra #37: atribui SO sob a guarda de this_lSelecionou,
                *-- senao o campo seria ZERADO quando o usuario desiste.
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConj")
                    SELECT cursor_4c_BuscaConj
                    loc_oPg.txt_4c_Conjunto.Value = ;
                        PADL(ALLTRIM(NVL(cursor_4c_BuscaConj.conjunts, "")), 6, "0")
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaConj")
                USE IN cursor_4c_BuscaConj
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao localizar o Cod. Pai:" + CHR(13) + ;
                loException.Message, "FormProduto.BtnLocalizarConjuntoClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual de um grid (FontName / FontSize)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        LOCAL loException

        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "FormProduto.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Percorre o container tornando os filhos visiveis
    * AddObject cria os controles com Visible = .F.
    *
    * Os paineis flutuantes do legado (cntMensagem, CntAcabado, CntQtMin e a
    * botoeira lateral Botoes) nascem ocultos e so aparecem por acao do usuario:
    * eles sao pulados aqui, mas a recursao continua nos filhos deles para que os
    * controles internos ja fiquem visiveis quando o painel for exibido.
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                IF loc_cNome == "GRD_4C_RELOGIOS"
                    *-- grade alternativa (produto tipo "relogios") sobreposta
                    *-- ao grd_4c_Compo no mesmo Top/Left - fica oculta por
                    *-- padrao (regra #28/#30 do CLAUDE.md: nunca duas grades
                    *-- sobrepostas visiveis). Grid NAO tem ControlCount (so
                    *-- ColumnCount) - recursar nela estourava "Property
                    *-- CONTROLCOUNT is not found" (Erro178). So pula, sem
                    *-- recursao e sem tocar Visible.
                ELSE
                    IF INLIST(loc_cNome, "CNT_4C_MENSAGEM", "CNT_4C_ACABADO", ;
                            "CNT_4C_QTMIN", "CNT_4C_BOTOESLATERAL")
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ELSE
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
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * Destroy - Libera o Business Object e fecha os cursores do formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_DescAux")
            USE IN cursor_4c_DescAux
        ENDIF

        IF USED("cursor_4c_BuscaConj")
            USE IN cursor_4c_BuscaConj
        ENDIF

        IF USED("cursor_4c_MaxConj")
            USE IN cursor_4c_MaxConj
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
