*==============================================================================
* Formsigprcom.prg - Formulario de Estoque Maximo por Produto/Empresa/Tamanho/Cor
* Migrado de: SIGPRCOM.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS Formsigprcom AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 675
    Width       = 1000
    Caption     = "Estoque M" + CHR(225) + "ximo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject      = .NULL.
    this_cModoAtual           = "LISTA"

    *-- Propriedades de estado do Produto/Grupo selecionado (Page2)
    *-- Legado: ThisForm.nTipoEstos / ThisForm.lTemCor / ThisForm.lTemTam (SigCdGrp.tipoestos/cores/tams)
    this_nTipoEstos           = 0
    this_lTemCor              = .F.
    this_lTemTam              = .F.
    this_cUltimoProdutoValid  = ""
    this_cUltimoDescProdValid = ""

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
            THIS.this_oBusinessObject = CREATEOBJECT("sigprcomBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar sigprcomBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigprcom.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                *-- Legado: o Init monta CrProdutos e liga na Grade da Lista, ou
                *-- seja a tela ABRE com a lista preenchida. CarregarLista ja tem
                *-- a guarda de gb_4c_ValidandoUI (sem conexao SQL).
                THIS.CarregarLista()
                THIS.AjustarBotoesPorModo()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formsigprcom:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formsigprcom.InicializarForm")
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
    * ConfigurarPaginaLista - Page1 (Lista): estrutura base
    * Fase 3: containers vazios (cabecalho + botoes)
    * Fase 4: Grid e botoes CRUD serao adicionados dentro destes containers
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCnt, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original: Top=1. Com compensacao +29: Top=31
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

        *-- Container Botoes CRUD (Grupo_Op no legado)
        *-- Legado: Inserir/Consultar/Alterar/Excluir/Procurar (Left 5/80/155/230/305)
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
        loc_oCnt = loc_oPagina.cnt_4c_Botoes

        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida (canonico: Left=917, Width=90) - flutuante/transparente
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
            .FontName        = "Comic Sans MS"
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
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de Lista (Grade no legado) - lista de Produtos com registro em SigCdMax
        *-- Legado: AddCursor('SigCdMax','cpros','CrProdutos',...) + pColuna(cpros/dpros/ifors/reffs/sgrus)
        *-- Top compensado: 102+29=131
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top                = 131
        loc_oGrid.Left               = 14
        loc_oGrid.Width              = 971
        loc_oGrid.Height             = 553
        loc_oGrid.ColumnCount        = 5
        loc_oGrid.FontName           = "Tahoma"
        loc_oGrid.FontSize           = 8
        loc_oGrid.ForeColor          = RGB(90, 90, 90)
        loc_oGrid.BackColor          = RGB(255, 255, 255)
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        loc_oGrid.DeleteMark         = .F.
        loc_oGrid.RecordMark         = .F.
        loc_oGrid.RowHeight          = 16
        loc_oGrid.ScrollBars         = 2
        loc_oGrid.GridLines          = 3
        loc_oGrid.ReadOnly           = .T.
        WITH loc_oGrid
            .Column1.Width = 108
            .Column2.Width = 285
            .Column3.Width = 75
            .Column4.Width = 150
            .Column5.Width = 45
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2 (Dados): estrutura base
    * Fase 3: containers vazios (cabecalho + botoes de acao)
    * Fases 5-6: campos de dados serao adicionados (get_produto, getDpro, getCgru,
    * getDgru, getIfor, getDfor, getRefs, Opc_situacao, gradei, btnExcluir)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oGridItens, loc_oCntAcao
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

        *-- Container BotoesAcao (Grupo_Salva no legado - vazio nesta fase)
        *-- Botoes Confirmar/Cancelar na Fase 4
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Campos principais (FASE 5 - Parte 1): Produto / Grupo / Situacao
        *-- Legado (SIGPRCOM.SCX): tops crus 75-105, compensados +29 (PageFrame.Top=-29)
        *-- + 11px de re-layout (regra CLAUDE.md #11) para nao colidir com cnt_4c_Cabecalho
        *-- (Top=29, Height=80, ocupa ate 109) -> shift total de 40

        *-- Say1 "Produto :"
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Produto :"
            .Top       = 119
            .Left      = 260
            .Width     = 47
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_produto - Codigo do Produto (SigCdPro.cpros char(14))
        loc_oPagina.AddObject("txt_4c__Produto", "TextBox")
        WITH loc_oPagina.txt_4c__Produto
            .Top               = 115
            .Left              = 309
            .Width             = 108
            .Height            = 23
            .MaxLength         = 14
            .Value             = ""
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Visible           = .T.
        ENDWITH

        *-- getDpro - Descricao do Produto (SigCdPro.dpros char(65))
        loc_oPagina.AddObject("txt_4c_Dpro", "TextBox")
        WITH loc_oPagina.txt_4c_Dpro
            .Top           = 115
            .Left          = 419
            .Width         = 360
            .Height        = 23
            .MaxLength     = 65
            .Value         = ""
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        *-- Say8 "Grupo :"
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Grupo :"
            .Top       = 145
            .Left      = 269
            .Width     = 38
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCgru - Codigo do Grupo (SigCdGrp.cgrus char(3)) - preenchido automaticamente
        *-- pelo Produto selecionado; legado retorna .F. no When (nunca recebe foco direto)
        loc_oPagina.AddObject("txt_4c_Cgru", "TextBox")
        WITH loc_oPagina.txt_4c_Cgru
            .Top               = 141
            .Left              = 309
            .Width             = 31
            .Height            = 23
            .MaxLength         = 3
            .Value             = ""
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 220)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Visible           = .T.
        ENDWITH

        *-- getDgru - Descricao do Grupo (SigCdGrp.dgrus char(20)) - mesma regra de getCgru
        loc_oPagina.AddObject("txt_4c_Dgru", "TextBox")
        WITH loc_oPagina.txt_4c_Dgru
            .Top               = 141
            .Left              = 343
            .Width             = 150
            .Height            = 23
            .MaxLength         = 20
            .Value             = ""
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 220)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .Visible           = .T.
        ENDWITH

        *-- Say19 "Situacao : " (espaco antes do OptionGroup eh de apenas 50px - label estreita)
        loc_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPagina.lbl_4c_Label19
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o : "
            .Top       = 145
            .Left      = 505
            .Width     = 50
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Opc_situacao - OptionGroup (SigCdPro.situas numeric(1,0): 1=Ativo, 2=Inativo)
        loc_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_situacao
            .Top         = 140
            .Left        = 555
            .Width       = 127
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_situacao.Buttons(1)
            .Caption   = "Ativo"
            .BackStyle = 0
            .Left      = 2
            .Top       = 2
            .Width     = 55
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_situacao.Buttons(2)
            .Caption   = "Inativo"
            .BackStyle = 0
            .Left      = 59
            .Top       = 2
            .Width     = 58
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- BINDEVENT lookup Produto (codigo <-> descricao) - legado: get_produto.Valid / getDpro.Valid
        BINDEVENT(loc_oPagina.txt_4c__Produto, "KeyPress", THIS, "ProdutoLostFocus")
        BINDEVENT(loc_oPagina.txt_4c__Produto, "DblClick", THIS, "ProdutoDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Dpro, "KeyPress", THIS, "DescricaoProdutoLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Dpro, "DblClick", THIS, "DescricaoProdutoDblClick")

        *-- Say11 "Fornecedor :"
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "Fornecedor :"
            .Top       = 170
            .Left      = 243
            .Width     = 64
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getIfor - Codigo do Fornecedor (SigCdCli.iclis char(10)) - preenchido automaticamente
        *-- pelo Produto selecionado (legado: Enabled=.F., plprocurar=.T. - so digitavel em modo PROCURAR)
        loc_oPagina.AddObject("txt_4c_Ifor", "TextBox")
        WITH loc_oPagina.txt_4c_Ifor
            .Top               = 167
            .Left              = 309
            .Width             = 80
            .Height            = 23
            .MaxLength         = 10
            .Value             = ""
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 220)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 220)
            .Visible           = .T.
        ENDWITH

        *-- getDfor - Descricao/Razao do Fornecedor (SigCdCli.rclis) - sempre readonly (legado: When retorna .F.)
        loc_oPagina.AddObject("txt_4c_Dfor", "TextBox")
        WITH loc_oPagina.txt_4c_Dfor
            .Top               = 167
            .Left              = 392
            .Width             = 220
            .Height            = 23
            .MaxLength         = 50
            .Value             = ""
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 220)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 220)
            .Visible           = .T.
        ENDWITH

        *-- Say12 "Ref. Fornecedor :"
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Ref. Fornecedor :"
            .Top       = 196
            .Left      = 219
            .Width     = 88
            .Height    = 15
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getRefs - Referencia do Produto (SigCdPro.reffs char(40), MaxLength legado=20)
        *-- Preenchido automaticamente pelo Produto selecionado (legado: Enabled=.F., plprocurar=.T.)
        loc_oPagina.AddObject("txt_4c_Refs", "TextBox")
        WITH loc_oPagina.txt_4c_Refs
            .Top               = 193
            .Left              = 309
            .Width             = 150
            .Height            = 23
            .MaxLength         = 20
            .Value             = ""
            .ReadOnly          = .T.
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 220)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 220)
            .Visible           = .T.
        ENDWITH

        *-- btnExcluir - Exclui (da lista local) todos os itens da Empresa da linha corrente
        loc_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnExcluir
            .Top             = 425
            .Left            = 700
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText     = "Exclui os itens da Empresa selecionada"
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirItemClick")

        *-- Cursor placeholder da grade de itens (deve existir ANTES do Grid.Init - regra #41)
        *-- cidchaves NAO tem coluna na grade: carrega a PK da linha JA gravada em
        *-- SigCdMax, para o Confirmar saber se cada linha eh INSERT (chave vazia)
        *-- ou UPDATE (chave preenchida). Sem isso, ALTERAR reinseria tudo.
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Itens ;
            (cidchaves C(20), cpros C(14), emps C(3), qmaxs N(7,2), codtams C(4), codcores C(4), deptos C(10))
        SET NULL OFF

        *-- gradei - Grade de Itens (Empresa/Qtde.Maxima/Tamanho/Cor/Departamento) do Produto selecionado
        loc_oPagina.AddObject("grd_4c_Itens", "Grid")
        loc_oGridItens                    = loc_oPagina.grd_4c_Itens
        loc_oGridItens.Top                = 221
        loc_oGridItens.Left               = 309
        loc_oGridItens.Width              = 387
        loc_oGridItens.Height             = 472
        loc_oGridItens.ColumnCount = 5
        loc_oGridItens.RecordSource       = "cursor_4c_Itens"
        loc_oGridItens.ColumnCount        = 5
        loc_oGridItens.Column1.ControlSource = "cursor_4c_Itens.emps"
        loc_oGridItens.Column2.ControlSource = "cursor_4c_Itens.qmaxs"
        loc_oGridItens.Column3.ControlSource = "cursor_4c_Itens.codtams"
        loc_oGridItens.Column4.ControlSource = "cursor_4c_Itens.codcores"
        loc_oGridItens.Column5.ControlSource = "cursor_4c_Itens.deptos"
        loc_oGridItens.Column1.Width       = 50
        loc_oGridItens.Column2.Width       = 100
        loc_oGridItens.Column3.Width       = 90
        loc_oGridItens.Column4.Width       = 90
        loc_oGridItens.Column5.Width       = 57
        loc_oGridItens.Column1.Header1.Caption = "Emp"
        loc_oGridItens.Column2.Header1.Caption = "Qtde. M" + CHR(225) + "xima"
        loc_oGridItens.Column3.Header1.Caption = "Tamanho"
        loc_oGridItens.Column4.Header1.Caption = "Cor"
        loc_oGridItens.Column5.Header1.Caption = "Departamento"
        loc_oGridItens.Column1.Text1.MaxLength = 3
        loc_oGridItens.Column1.Text1.Format    = "!"
        loc_oGridItens.Column2.Text1.InputMask = "99999.99"
        loc_oGridItens.Column3.Text1.MaxLength = 4
        loc_oGridItens.Column3.Text1.Format    = "!"
        loc_oGridItens.Column4.Text1.MaxLength = 4
        loc_oGridItens.Column4.Text1.Format    = "!"
        loc_oGridItens.Column5.Text1.MaxLength = 10
        loc_oGridItens.Column5.Text1.Format    = "!"
        loc_oGridItens.FontName            = "Tahoma"
        loc_oGridItens.FontSize            = 8
        loc_oGridItens.ForeColor           = RGB(0, 0, 0)
        loc_oGridItens.BackColor           = RGB(255, 255, 255)
        loc_oGridItens.GridLineColor       = RGB(238, 238, 238)
        loc_oGridItens.DeleteMark          = .F.
        loc_oGridItens.ScrollBars          = 2
        loc_oGridItens.GridLines           = 3
        BINDEVENT(loc_oGridItens, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
        BINDEVENT(loc_oGridItens.Column1.Text1, "KeyPress", THIS, "GradeItensEmpresaLostFocus")
        BINDEVENT(loc_oGridItens.Column3.Text1, "KeyPress", THIS, "GradeItensTamanhoLostFocus")
        BINDEVENT(loc_oGridItens.Column4.Text1, "KeyPress", THIS, "GradeItensCorLostFocus")
        BINDEVENT(loc_oGridItens.Column5.Text1, "KeyPress", THIS, "GradeItensDepartamentoLostFocus")

        *-- Container BotoesAcao (Grupo_Salva no legado) - Confirmar/Cancelar
        loc_oCntAcao = loc_oPagina.cnt_4c_BotoesAcao
        loc_oCntAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oCntAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        ENDWITH
        BINDEVENT(loc_oCntAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        loc_oCntAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oCntAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        ENDWITH
        BINDEVENT(loc_oCntAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega na grade os Produtos com registro em SigCdMax
    * Legado: AddCursor('SigCdMax','cpros','CrProdutos',...) + pColuna
    *   (cpros=Produto, dpros=Descricao, ifors=Fornecedor, reffs=Referencia, sgrus=Sub Grp)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF USED("cursor_4c_Lista")
                USE IN cursor_4c_Lista
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Lista ;
                (cpros C(14), dpros C(40), ifors C(10), reffs C(20), sgrus C(6))
            SET NULL OFF
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid.ColumnCount            = 5
                loc_oGrid.RecordSource            = "cursor_4c_Lista"
                loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.cpros"
                loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.dpros"
                loc_oGrid.Column3.ControlSource   = "cursor_4c_Lista.ifors"
                loc_oGrid.Column4.ControlSource   = "cursor_4c_Lista.reffs"
                loc_oGrid.Column5.ControlSource   = "cursor_4c_Lista.sgrus"

                *-- Reconfigurar cabecalhos APOS RecordSource (obrigatorio)
                loc_oGrid.Column1.Header1.Caption = "Produto"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Fornecedor"
                loc_oGrid.Column4.Header1.Caption = "Refer" + CHR(234) + "ncia"
                loc_oGrid.Column5.Header1.Caption = "Sub Grp"

                loc_oGrid.Column1.Width = 108
                loc_oGrid.Column2.Width = 285
                loc_oGrid.Column3.Width = 75
                loc_oGrid.Column4.Width = 150
                loc_oGrid.Column5.Width = 45

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgErro("Parametro inv" + CHR(225) + "lido em AlternarPagina: " + TRANSFORM(par_nPagina), "Erro")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF
                *-- Quem DESABILITA botao tem de REABILITAR no funil de volta:
                *-- Confirmar/Cancelar chamam AlternarPagina(1), e eh aqui - com o
                *-- modo JA normalizado para "LISTA" acima - que os botoes CRUD
                *-- voltam a ficar clicaveis (CLAUDE.md regra #40)
                THIS.AjustarBotoesPorModo()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara a Page2 para cadastrar um NOVO Produto no
    * Estoque Maximo (o codigo eh escolhido pelo usuario via lookup de Produto)
    * Legado: Grupo_Op.Click(1) + DoDefault() (framework) limpa a ficha e navega
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparDadosProduto()
        THIS.this_cModoAtual = "INCLUIR"

        THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.ReadOnly = .F.
        THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.ReadOnly     = .F.
        THIS.HabilitarCampos(.T.)

        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.SetFocus()
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega o Produto selecionado na Lista (Page1) com os
    * itens JA GRAVADOS em SigCdMax para edicao na grade (Page2)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
            MsgAviso("Selecione um Produto na lista !!!")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Lista.cpros)

        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparDadosProduto()
        THIS.this_cModoAtual = "ALTERAR"

        IF THIS.CarregarItensExistentesProduto(loc_cCodigo)
            THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.ReadOnly = .T.
            THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.ReadOnly     = .T.
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ELSE
            THIS.this_cModoAtual = "LISTA"
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Mesma carga do Alterar, porem SOMENTE LEITURA
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
            MsgAviso("Selecione um Produto na lista !!!")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Lista.cpros)

        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparDadosProduto()
        THIS.this_cModoAtual = "VISUALIZAR"

        IF THIS.CarregarItensExistentesProduto(loc_cCodigo)
            THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.ReadOnly = .T.
            THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.ReadOnly     = .T.
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ELSE
            THIS.this_cModoAtual = "LISTA"
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui de SigCdMax TODOS os registros do Produto
    * selecionado na Lista (Page1). Legado: btnExcluir(Grupo_Op, Opcao=Excluir)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDescricao, loc_cSQL, loc_nResultado, loc_lConfirmou

        IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
            MsgAviso("Selecione um Produto na lista !!!")
            RETURN
        ENDIF

        loc_cCodigo    = ALLTRIM(cursor_4c_Lista.cpros)
        loc_cDescricao = ALLTRIM(TratarNulo(cursor_4c_Lista.dpros, ""))

        loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o do Estoque M" + CHR(225) + "ximo do Produto " + ;
            loc_cCodigo + " - " + loc_cDescricao + " ?", "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirmou
            TRY
                loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(loc_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
                    THIS.CarregarLista()
                ELSE
                    MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "BtnExcluirClick")
            ENDTRY
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Coloca o form em modo BUSCAR (busca por exemplo).
    * Legado: msv_procurar - NAO abre picker; limpa a ficha, habilita SO os
    * campos plprocurar (Produto/Descricao/Fornecedor/Referencia), navega
    * para a Pagina de Dados e quem executa a consulta eh o Confirmar.
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.LimparDadosProduto()
        THIS.this_cModoAtual = "BUSCAR"

        loc_oPagina.txt_4c__Produto.ReadOnly = .F.
        loc_oPagina.txt_4c_Dpro.ReadOnly     = .F.
        loc_oPagina.txt_4c_Ifor.ReadOnly     = .F.
        loc_oPagina.txt_4c_Refs.ReadOnly     = .F.

        *-- NAO usar HabilitarCampos(.F.) aqui: ele tambem desabilita o
        *-- Confirmar, que EH o botao que dispara a busca (ExecutarBusca)
        loc_oPagina.grd_4c_Itens.ReadOnly      = .T.
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.

        THIS.AlternarPagina(2)
        loc_oPagina.txt_4c__Produto.SetFocus()
    ENDPROC

    *===========================================================================
    * ExecutarBusca - Busca por exemplo em SigCdPro (Produto/Descricao/
    * Fornecedor/Referencia, nesta ordem) e carrega os itens existentes do
    * Produto encontrado. Legado: msv_procurar (Do Case cpros/dpros/ifors/reffs)
    *===========================================================================
    PROCEDURE ExecutarBusca()
        LOCAL loc_oPagina, loc_cCodigo, loc_cDescricao, loc_cFornecedor, loc_cReferencia
        LOCAL loc_cSQL, loc_nResultado, loc_cCodigoEncontrado
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_cCodigo           = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)
        loc_cDescricao        = ALLTRIM(loc_oPagina.txt_4c_Dpro.Value)
        loc_cFornecedor       = ALLTRIM(loc_oPagina.txt_4c_Ifor.Value)
        loc_cReferencia       = ALLTRIM(loc_oPagina.txt_4c_Refs.Value)
        loc_cCodigoEncontrado = ""

        TRY
            DO CASE
                CASE !EMPTY(loc_cCodigo)
                    loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodigo)
                CASE !EMPTY(loc_cDescricao)
                    loc_cSQL = "SELECT cpros FROM SigCdPro WHERE dpros = " + EscaparSQL(loc_cDescricao)
                CASE !EMPTY(loc_cFornecedor)
                    loc_cSQL = "SELECT cpros FROM SigCdPro WHERE ifors = " + EscaparSQL(loc_cFornecedor)
                CASE !EMPTY(loc_cReferencia)
                    loc_cSQL = "SELECT cpros FROM SigCdPro WHERE reffs = " + EscaparSQL(loc_cReferencia)
                OTHERWISE
                    loc_cSQL = ""
            ENDCASE

            IF EMPTY(loc_cSQL)
                MsgAviso("Informe ao menos um crit" + CHR(233) + "rio de busca !!!")
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaExemplo")
                IF loc_nResultado > 0 AND USED("cursor_4c_BuscaExemplo") AND !EOF("cursor_4c_BuscaExemplo")
                    loc_cCodigoEncontrado = ALLTRIM(cursor_4c_BuscaExemplo.cpros)
                ELSE
                    MsgAviso("Produto n" + CHR(227) + "o encontrado !!!")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ExecutarBusca")
        ENDTRY

        IF USED("cursor_4c_BuscaExemplo")
            USE IN cursor_4c_BuscaExemplo
        ENDIF

        IF !EMPTY(loc_cCodigoEncontrado)
            IF THIS.CarregarItensExistentesProduto(loc_cCodigoEncontrado)
                THIS.this_cModoAtual = "ALTERAR"
                loc_oPagina.txt_4c__Produto.ReadOnly = .T.
                loc_oPagina.txt_4c_Dpro.ReadOnly     = .T.
                loc_oPagina.txt_4c_Ifor.ReadOnly     = .T.
                loc_oPagina.txt_4c_Refs.ReadOnly     = .T.
                THIS.HabilitarCampos(.T.)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita a grade de itens e os botoes de
    * gravacao/remocao de linha da Page2, conforme o modo (INCLUIR/ALTERAR x
    * VISUALIZAR). O codigo/descricao do Produto sao travados por fora
    * (BtnIncluirClick libera, BtnAlterarClick/BtnVisualizarClick travam)
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.grd_4c_Itens.ReadOnly     = !par_lHabilitar
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta os botoes CRUD da Pagina Lista conforme o
    * modo corrente. Legado: Grupo_Op.Enabled / Inserir|Consultar|Alterar|
    * Excluir|Procurar.Enabled (btnCopiar.Click e cntCopia.cmdSair.Click
    * desligam e religam o grupo inteiro).
    *
    * NAO mexe em cmd_4c_Confirmar: ele eh governado por HabilitarCampos(),
    * que precisa deixa-lo LIGADO no modo BUSCAR (eh o Confirmar que dispara
    * a busca por exemplo) e DESLIGADO no modo VISUALIZAR.
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lNaLista
        loc_lNaLista = (THIS.this_cModoAtual == "LISTA")
        loc_oCnt     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes

        loc_oCnt.cmd_4c_Incluir.Enabled    = loc_lNaLista
        loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lNaLista
        loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lNaLista
        loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lNaLista
        loc_oCnt.cmd_4c_Buscar.Enabled     = loc_lNaLista
        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Enabled = loc_lNaLista

        *-- Cancelar so faz sentido quando existe edicao/busca em andamento
        THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = !loc_lNaLista
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere a LINHA CORRENTE da grade de itens (mais o Produto
    * do cabecalho da Pagina Dados) para as propriedades do Business Object.
    *
    * Em SigCdMax cada registro eh UMA linha da grade (Produto + Empresa +
    * Tamanho + Cor + Departamento + Qtde. Maxima), por isso o mapeamento le o
    * registro corrente de cursor_4c_Itens - o Confirmar chama este metodo uma
    * vez por linha, dentro do SCAN que posiciona o cursor.
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_cProduto, loc_oBO

        IF !USED("cursor_4c_Itens") OR VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_oBO     = THIS.this_oBusinessObject
        loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)

        SELECT cursor_4c_Itens

        *-- cidchaves vazio = linha nova (o Inserir do BO gera a PK com fUniqueIds)
        loc_oBO.this_cCidChaves = ALLTRIM(NVL(cursor_4c_Itens.cidchaves, ""))

        *-- A linha pode ter sido criada em branco por AdicionarNovaLinhaItem
        *-- antes do Produto estar escolhido: o cabecalho eh a fonte de verdade
        loc_oBO.this_cCPros     = IIF(EMPTY(loc_cProduto), ;
                                      ALLTRIM(NVL(cursor_4c_Itens.cpros, "")), loc_cProduto)
        loc_oBO.this_cEmps      = ALLTRIM(NVL(cursor_4c_Itens.emps, ""))
        loc_oBO.this_cCodTams   = ALLTRIM(NVL(cursor_4c_Itens.codtams, ""))
        loc_oBO.this_cCodCores  = ALLTRIM(NVL(cursor_4c_Itens.codcores, ""))
        loc_oBO.this_cDeptos    = ALLTRIM(NVL(cursor_4c_Itens.deptos, ""))
        loc_oBO.this_nQMaxs     = NVL(cursor_4c_Itens.qmaxs, 0)

        *-- ordems eh char(1) NOT NULL sem campo na tela (o legado grava o
        *-- registro em branco do cursor); manter "1" para nao violar o NOT NULL
        loc_oBO.this_cOrdems    = "1"

        RETURN .T.
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere as propriedades do Business Object de volta para a
    * LINHA CORRENTE da grade de itens e para o Produto do cabecalho.
    *
    * Chamado depois de cada gravacao: eh assim que a PK gerada pelo Inserir
    * (fUniqueIds) volta para a linha - sem isso, um segundo Confirmar sobre a
    * mesma grade trataria as linhas ja gravadas como novas e duplicaria tudo.
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_oBO     = THIS.this_oBusinessObject
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPagina.txt_4c__Produto.Value)) AND !EMPTY(loc_oBO.this_cCPros)
            loc_oPagina.txt_4c__Produto.Value = ALLTRIM(loc_oBO.this_cCPros)
        ENDIF

        IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            REPLACE cidchaves WITH loc_oBO.this_cCidChaves, ;
                    cpros     WITH loc_oBO.this_cCPros, ;
                    emps      WITH loc_oBO.this_cEmps, ;
                    codtams   WITH loc_oBO.this_cCodTams, ;
                    codcores  WITH loc_oBO.this_cCodCores, ;
                    deptos    WITH loc_oBO.this_cDeptos, ;
                    qmaxs     WITH loc_oBO.this_nQMaxs ;
                IN cursor_4c_Itens
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * LimparCampos - Hook do FormBase: limpa a ficha do Produto e a grade de
    * itens e abandona a edicao em andamento no Business Object.
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.LimparDadosProduto()

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.CancelarEdicao()
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * CarregarItensExistentesProduto - Carrega cabecalho do Produto (mesma
    * consulta de CarregarProdutoSelecionado) e os itens JA GRAVADOS em
    * SigCdMax, para os fluxos ALTERAR/VISUALIZAR (NAO bloqueia por
    * ExistemItensParaProduto - ao contrario do fluxo INCLUIR, aqui os itens
    * EXISTENTES sao o que se quer carregar)
    *===========================================================================
    PROCEDURE CarregarItensExistentesProduto(par_cCodigo)
        LOCAL loc_oPagina, loc_cSQL, loc_nResultado, loc_lSucesso
        loc_oPagina  = THIS.pgf_4c_Paginas.Page2
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
                " c.rclis, g.dgrus, g.tipoestos, g.cores, g.tams" + ;
                " FROM SigCdPro a" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
                " WHERE a.cpros = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoInfo")

            IF loc_nResultado < 1 OR !USED("cursor_4c_ProdutoInfo") OR EOF("cursor_4c_ProdutoInfo")
                MsgErro("Produto n" + CHR(227) + "o encontrado.", "Erro")
            ELSE
                SELECT cursor_4c_ProdutoInfo

                loc_oPagina.txt_4c__Produto.Value     = TratarNulo(cpros, "")
                loc_oPagina.txt_4c_Dpro.Value          = TratarNulo(dpros, "")
                loc_oPagina.txt_4c_Cgru.Value          = TratarNulo(cgrus, "")
                loc_oPagina.txt_4c_Dgru.Value          = TratarNulo(dgrus, "")
                loc_oPagina.txt_4c_Ifor.Value           = TratarNulo(ifors, "")
                loc_oPagina.txt_4c_Dfor.Value           = TratarNulo(rclis, "")
                loc_oPagina.txt_4c_Refs.Value           = TratarNulo(reffs, "")
                loc_oPagina.obj_4c_Opc_situacao.Value  = IIF(NVL(situas, 1) = 2, 2, 1)

                THIS.this_nTipoEstos = TratarNulo(tipoestos, 0)
                THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR TratarNulo(cores, 0) = 1
                THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR TratarNulo(tams, 0) = 1

                IF THIS.CarregarItensGravados(par_cCodigo)
                    loc_oPagina.grd_4c_Itens.Column3.Enabled = THIS.this_lTemTam
                    loc_oPagina.grd_4c_Itens.Column4.Enabled = THIS.this_lTemCor
                    loc_oPagina.grd_4c_Itens.Refresh()
                    loc_oPagina.cmd_4c_BtnExcluir.Visible = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarItensExistentesProduto")
        ENDTRY

        IF USED("cursor_4c_ProdutoInfo")
            USE IN cursor_4c_ProdutoInfo
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * CarregarItensGravados - Popula cursor_4c_Itens com os registros JA
    * gravados em SigCdMax para o Produto informado. Usa cursor TEMPORARIO +
    * ZAP/APPEND para preservar as colunas do Grid (regra CLAUDE.md #34)
    *===========================================================================
    PROCEDURE CarregarItensGravados(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos" + ;
                " FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCodigo) + ;
                " ORDER BY emps, codtams, codcores"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTemp")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                ZAP

                IF USED("cursor_4c_ItensTemp")
                    SELECT cursor_4c_ItensTemp
                    SCAN
                        INSERT INTO cursor_4c_Itens (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos) ;
                            VALUES (cursor_4c_ItensTemp.cidchaves, cursor_4c_ItensTemp.cpros, ;
                                    cursor_4c_ItensTemp.emps, cursor_4c_ItensTemp.qmaxs, ;
                                    cursor_4c_ItensTemp.codtams, cursor_4c_ItensTemp.codcores, ;
                                    cursor_4c_ItensTemp.deptos)
                    ENDSCAN
                ENDIF

                SELECT cursor_4c_Itens
                IF RECCOUNT("cursor_4c_Itens") = 0
                    INSERT INTO cursor_4c_Itens (cpros) VALUES (par_cCodigo)
                ENDIF
                GO TOP IN cursor_4c_Itens
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarItensGravados")
        ENDTRY

        IF USED("cursor_4c_ItensTemp")
            USE IN cursor_4c_ItensTemp
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * Lookup Produto (codigo) - legado: get_produto.Valid (fwbuscaext SigCdPro/cpros)
    * BINDEVENT em LostFocus (Valid nao dispara de forma confiavel via BINDEVENT)
    *===========================================================================
    PROCEDURE ProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.AbrirLookupProduto()
    ENDPROC

    PROCEDURE ProdutoDblClick()
        THIS.AbrirLookupProduto()
    ENDPROC

    PROCEDURE AbrirLookupProduto()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_cCodigo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Legado: get_produto.Valid so dispara o lookup quando pcEscolha = 'INSERIR'
        IF THIS.this_cModoAtual != "INCLUIR"
            RETURN
        ENDIF

        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)

        IF loc_cValor == THIS.this_cUltimoProdutoValid
            RETURN
        ENDIF
        THIS.this_cUltimoProdutoValid = loc_cValor

        IF EMPTY(loc_cValor)
            THIS.LimparDadosProduto()
            RETURN
        ENDIF

        loc_cCodigo = ""
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaProduto", "cpros", loc_cValor, "Produtos")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                loc_cCodigo = ALLTRIM(cursor_4c_BuscaProduto.cpros)
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF

        IF EMPTY(loc_cCodigo)
            THIS.LimparDadosProduto()
        ELSE
            THIS.this_cUltimoProdutoValid = loc_cCodigo
            THIS.CarregarProdutoSelecionado(loc_cCodigo)
        ENDIF
    ENDPROC

    *===========================================================================
    * Lookup Produto (descricao) - legado: getDpro.Valid (fwbuscaext SigCdPro/dpros)
    *===========================================================================
    PROCEDURE DescricaoProdutoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.AbrirLookupProdutoPorDescricao()
    ENDPROC

    PROCEDURE DescricaoProdutoDblClick()
        THIS.AbrirLookupProdutoPorDescricao()
    ENDPROC

    PROCEDURE AbrirLookupProdutoPorDescricao()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_cCodigo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Legado: getDpro.Valid so dispara o lookup quando pcEscolha = 'INSERIR'
        IF THIS.this_cModoAtual != "INCLUIR"
            RETURN
        ENDIF

        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Dpro.Value)

        IF loc_cValor == THIS.this_cUltimoDescProdValid
            RETURN
        ENDIF
        THIS.this_cUltimoDescProdValid = loc_cValor

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cCodigo = ""
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaProduto", "dpros", loc_cValor, "Produtos")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()
            ENDIF
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                loc_cCodigo = ALLTRIM(cursor_4c_BuscaProduto.cpros)
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF

        IF !EMPTY(loc_cCodigo)
            THIS.this_cUltimoProdutoValid = loc_cCodigo
            THIS.CarregarProdutoSelecionado(loc_cCodigo)
        ENDIF
    ENDPROC

    *===========================================================================
    * CarregarProdutoSelecionado - Carrega dados do Produto (join Grupo/Fornecedor),
    * valida situacao/duplicidade e prepara a grade de itens para inclusao
    * Legado: get_produto.Valid + ThisForm.AcertaGrade() + ThisForm.MRefreshGet()
    *===========================================================================
    PROCEDURE CarregarProdutoSelecionado(par_cCodigo)
        LOCAL loc_oPagina, loc_cSQL, loc_nResultado, loc_lInativo

        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
                " c.rclis, g.dgrus, g.tipoestos, g.cores, g.tams" + ;
                " FROM SigCdPro a" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
                " WHERE a.cpros = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoInfo")

            IF loc_nResultado < 1 OR !USED("cursor_4c_ProdutoInfo") OR EOF("cursor_4c_ProdutoInfo")
                MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
                THIS.LimparDadosProduto()
            ELSE
                SELECT cursor_4c_ProdutoInfo

                *-- Verifica se produto esta inativo (bloqueia se parametro gesind=1)
                loc_lInativo = .F.
                IF NVL(situas, 0) = 2
                    IF THIS.ParametroGestaoIndireta()
                        loc_lInativo = .T.
                    ENDIF
                ENDIF

                IF loc_lInativo
                    MsgAviso("Produto Inativo !!!")
                    THIS.LimparDadosProduto()
                ELSE
                    IF THIS.this_oBusinessObject.ExistemItensParaProduto(par_cCodigo)
                        MsgAviso("Produto j" + CHR(225) + " cadastrado !!!")
                        THIS.LimparDadosProduto()
                    ELSE
                        loc_oPagina.txt_4c__Produto.Value = TratarNulo(cpros, "")
                        loc_oPagina.txt_4c_Dpro.Value      = TratarNulo(dpros, "")
                        loc_oPagina.txt_4c_Cgru.Value      = TratarNulo(cgrus, "")
                        loc_oPagina.txt_4c_Dgru.Value      = TratarNulo(dgrus, "")
                        loc_oPagina.txt_4c_Ifor.Value       = TratarNulo(ifors, "")
                        loc_oPagina.txt_4c_Dfor.Value       = TratarNulo(rclis, "")
                        loc_oPagina.txt_4c_Refs.Value       = TratarNulo(reffs, "")
                        loc_oPagina.obj_4c_Opc_situacao.Value = IIF(NVL(situas, 1) = 2, 2, 1)

                        THIS.this_nTipoEstos = TratarNulo(tipoestos, 0)
                        THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR TratarNulo(cores, 0) = 1
                        THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR TratarNulo(tams, 0) = 1

                        *-- Prepara a grade com UMA linha em branco para o usuario preencher
                        IF USED("cursor_4c_Itens")
                            ZAP IN cursor_4c_Itens
                            INSERT INTO cursor_4c_Itens (cpros) VALUES (par_cCodigo)
                        ENDIF

                        loc_oPagina.grd_4c_Itens.Column3.Enabled = THIS.this_lTemTam
                        loc_oPagina.grd_4c_Itens.Column4.Enabled = THIS.this_lTemCor
                        loc_oPagina.grd_4c_Itens.Refresh()

                        loc_oPagina.cmd_4c_BtnExcluir.Visible = .T.
                        THIS.this_cModoAtual = "INCLUIR"
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarProdutoSelecionado")
            THIS.LimparDadosProduto()
        ENDTRY

        IF USED("cursor_4c_ProdutoInfo")
            USE IN cursor_4c_ProdutoInfo
        ENDIF
    ENDPROC

    *===========================================================================
    * ParametroGestaoIndireta - Le SigCdPam.gesind (parametro de gestao indireta)
    *===========================================================================
    PROCEDURE ParametroGestaoIndireta()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF SQLEXEC(gnConnHandle, "SELECT gesind FROM SigCdPam", "cursor_4c_Param") > 0
                IF USED("cursor_4c_Param") AND !EOF("cursor_4c_Param")
                    loc_lResultado = (TratarNulo(cursor_4c_Param.gesind, 0) = 1)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_Param")
            USE IN cursor_4c_Param
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * LimparDadosProduto - Limpa cabecalho do Produto e a grade de itens
    *===========================================================================
    PROCEDURE LimparDadosProduto()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c__Produto.Value      = ""
        loc_oPagina.txt_4c_Dpro.Value          = ""
        loc_oPagina.txt_4c_Cgru.Value          = ""
        loc_oPagina.txt_4c_Dgru.Value          = ""
        loc_oPagina.txt_4c_Ifor.Value          = ""
        loc_oPagina.txt_4c_Dfor.Value          = ""
        loc_oPagina.txt_4c_Refs.Value          = ""
        loc_oPagina.obj_4c_Opc_situacao.Value  = 1
        loc_oPagina.cmd_4c_BtnExcluir.Visible  = .F.

        *-- Ifor/Refs so ficam editaveis durante o modo BUSCAR (BtnBuscarClick
        *-- reabre depois desta chamada) - fora dele, permanecem travados
        loc_oPagina.txt_4c_Ifor.ReadOnly       = .T.
        loc_oPagina.txt_4c_Refs.ReadOnly       = .T.

        THIS.this_nTipoEstos = 0
        THIS.this_lTemCor    = .F.
        THIS.this_lTemTam    = .F.
        THIS.this_cUltimoProdutoValid  = ""
        THIS.this_cUltimoDescProdValid = ""

        IF USED("cursor_4c_Itens")
            ZAP IN cursor_4c_Itens
        ENDIF
        loc_oPagina.grd_4c_Itens.Refresh()
    ENDPROC

    *===========================================================================
    * GradeItensAfterRowColChange - Habilita Tamanho/Cor conforme o Grupo do Produto
    * Legado: gradei.AfterRowColChange
    *===========================================================================
    PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
        LOCAL loc_oGrid
        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens

        loc_oGrid.Column3.Enabled = THIS.this_lTemTam
        loc_oGrid.Column4.Enabled = THIS.this_lTemCor
        loc_oGrid.Refresh()
    ENDPROC

    *===========================================================================
    * GradeItensEmpresaLostFocus - Valida acesso a Empresa digitada na grade
    * Legado: gradei.Column1.text1.Valid (fAcessoEmpresa)
    *===========================================================================
    PROCEDURE GradeItensEmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oText, loc_cValor
        loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column1.Text1
        loc_cValor = ALLTRIM(loc_oText.Value)

        IF !EMPTY(loc_cValor)
            IF !VerificarAcessoEmpresa(gc_4c_UsuarioLogado, loc_cValor)
                MsgAviso("Empresa sem acesso ou inv" + CHR(225) + "lida !!!")
                loc_oText.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * GradeItensTamanhoLostFocus - Lookup de Tamanho (SigCdTam) na grade
    * Legado: gradei.Column3.Text1.Valid (fwbuscaext)
    *===========================================================================
    PROCEDURE GradeItensTamanhoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oText, loc_cValor, loc_oBusca, loc_cCodigo
        loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column3.Text1
        loc_cValor = ALLTRIM(loc_oText.Value)

        IF !EMPTY(loc_cValor)
            loc_cCodigo = ""
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "cursor_4c_BuscaTamanho", "cods", loc_cValor, "Tamanhos")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "d")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTamanho")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaTamanho.cods)
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaTamanho")
                USE IN cursor_4c_BuscaTamanho
            ENDIF
            loc_oText.Value = loc_cCodigo
        ENDIF

        IF THIS.this_nTipoEstos = 3 AND EMPTY(ALLTRIM(loc_oText.Value))
            MsgAviso("Obrigat" + CHR(243) + "rio informar Tamanho !!!")
        ENDIF
    ENDPROC

    *===========================================================================
    * GradeItensCorLostFocus - Lookup de Cor (SigCdCor) na grade
    * Legado: gradei.Column4.Text1.Valid (fwbuscaext)
    *===========================================================================
    PROCEDURE GradeItensCorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oText, loc_cValor, loc_oBusca, loc_cCodigo
        loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column4.Text1
        loc_cValor = ALLTRIM(loc_oText.Value)

        IF !EMPTY(loc_cValor)
            loc_cCodigo = ""
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValor, "Cores")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "d")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCor.cods)
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaCor")
                USE IN cursor_4c_BuscaCor
            ENDIF
            loc_oText.Value = loc_cCodigo
        ENDIF

        IF THIS.this_nTipoEstos = 2 AND EMPTY(ALLTRIM(loc_oText.Value))
            MsgAviso("Obrigat" + CHR(243) + "rio informar C" + CHR(243) + "digo da Cor !!!")
        ENDIF
    ENDPROC

    *===========================================================================
    * GradeItensDepartamentoLostFocus - Lookup de Departamento (SigCdDpt) na grade
    * Legado: gradei.Column5.Text1.Valid (fwbuscaext) + mNovaLinha (nova linha em branco)
    *===========================================================================
    PROCEDURE GradeItensDepartamentoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oText, loc_cValor, loc_oBusca, loc_cCodigo
        loc_oText  = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens.Column5.Text1
        loc_cValor = ALLTRIM(loc_oText.Value)

        IF !EMPTY(loc_cValor)
            loc_cCodigo = ""
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdDpt", "cursor_4c_BuscaDepto", "codigos", loc_cValor, "Departamentos")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDepto")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaDepto.codigos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaDepto")
                USE IN cursor_4c_BuscaDepto
            ENDIF
            loc_oText.Value = loc_cCodigo
        ENDIF

        THIS.AdicionarNovaLinhaItem()
    ENDPROC

    *===========================================================================
    * AdicionarNovaLinhaItem - Acrescenta uma linha em branco na grade de itens
    * Legado: mNovaLinha
    *===========================================================================
    PROCEDURE AdicionarNovaLinhaItem()
        LOCAL loc_oGrid, loc_cProduto

        IF !USED("cursor_4c_Itens")
            RETURN
        ENDIF

        loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
        loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)

        SELECT cursor_4c_Itens
        LOCATE FOR EMPTY(emps)
        IF !FOUND()
            INSERT INTO cursor_4c_Itens (cpros) VALUES (loc_cProduto)
        ENDIF

        loc_oGrid.Refresh()
    ENDPROC

    *===========================================================================
    * BtnExcluirItemClick - Remove da grade local os itens da Empresa corrente
    * Legado: btnExcluir.Click
    *===========================================================================
    PROCEDURE BtnExcluirItemClick()
        LOCAL loc_cEmps, loc_cProduto, loc_oGrid

        IF !USED("cursor_4c_Itens")
            RETURN
        ENDIF

        loc_oGrid    = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens
        loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)
        loc_cEmps    = ""

        SELECT cursor_4c_Itens
        IF !EOF() AND !EMPTY(emps)
            loc_cEmps = emps
        ENDIF

        IF !EMPTY(loc_cEmps)
            DELETE FROM cursor_4c_Itens WHERE emps == loc_cEmps
            SELECT cursor_4c_Itens
            PACK
        ENDIF

        SELECT cursor_4c_Itens
        LOCATE
        IF EOF()
            INSERT INTO cursor_4c_Itens (cpros) VALUES (loc_cProduto)
        ENDIF

        loc_oGrid.Refresh()
    ENDPROC

    *===========================================================================
    * BtnConfirmarClick - Grava na tabela SigCdMax cada linha valida da grade
    * Legado: btnConfirma equivalente (TableUpdate do cursor CrSigCdMax)
    *===========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lSucesso, loc_nLinhasGravadas, loc_cProduto, loc_cChavesMantidas
        LOCAL loc_lLinhaNova, loc_lEraAlteracao

        *-- Em modo BUSCAR, Confirmar executa a busca por exemplo (legado: msv_procurar)
        IF THIS.this_cModoAtual == "BUSCAR"
            THIS.ExecutarBusca()
            RETURN
        ENDIF

        *-- VISUALIZAR nao grava (HabilitarCampos(.F.) ja desliga o botao; esta
        *-- guarda cobre a chamada por teclado/atalho)
        IF THIS.this_cModoAtual == "VISUALIZAR" OR !USED("cursor_4c_Itens")
            RETURN
        ENDIF

        loc_cProduto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.Value)

        *-- Legado: cmdConfirma recusa Produto vazio no INSERIR e devolve o foco
        IF EMPTY(loc_cProduto)
            MsgAviso("Produto inv" + CHR(225) + "lido !!!")
            THIS.pgf_4c_Paginas.Page2.txt_4c__Produto.SetFocus()
            RETURN
        ENDIF

        loc_lSucesso        = .T.
        loc_nLinhasGravadas = 0
        loc_cChavesMantidas = ""
        loc_lEraAlteracao   = (THIS.this_cModoAtual == "ALTERAR")

        SELECT cursor_4c_Itens
        SCAN FOR !EMPTY(emps)
            IF THIS.this_lTemTam AND EMPTY(codtams)
                MsgAviso("Obrigat" + CHR(243) + "rio informar Tamanho !!!")
                loc_lSucesso = .F.
                EXIT
            ENDIF
            IF THIS.this_lTemCor AND EMPTY(codcores)
                MsgAviso("Obrigat" + CHR(243) + "rio informar C" + CHR(243) + "digo da Cor !!!")
                loc_lSucesso = .F.
                EXIT
            ENDIF

            *-- Linha SEM cidchaves eh nova (INSERT); com chave, eh uma linha ja
            *-- gravada em SigCdMax e o que se quer eh UPDATE. Sem esta distincao
            *-- o ALTERAR reinseria todas as linhas do Produto.
            loc_lLinhaNova = EMPTY(NVL(cursor_4c_Itens.cidchaves, ""))

            IF loc_lLinhaNova
                THIS.this_oBusinessObject.NovoRegistro()
            ELSE
                *-- CancelarEdicao zera this_lNovoRegistro (que BtnAlterarClick
                *-- deixou ligado); sem isso EditarRegistro recusa e o Salvar
                *-- cairia no Inserir, duplicando o registro
                THIS.this_oBusinessObject.CancelarEdicao()
                THIS.this_oBusinessObject.EditarRegistro()
            ENDIF

            *-- FormParaBO depois de NovoRegistro/EditarRegistro: NovoRegistro
            *-- chama LimparDados e apagaria o que fosse mapeado antes
            THIS.FormParaBO()

            IF !THIS.this_oBusinessObject.Salvar()
                loc_lSucesso = .F.
                EXIT
            ENDIF

            *-- Devolve para a linha a PK gerada no Inserir (e os valores como
            *-- ficaram gravados), para um 2o Confirmar nao reinserir a linha
            THIS.BOParaForm()

            loc_cChavesMantidas = loc_cChavesMantidas + ;
                IIF(EMPTY(loc_cChavesMantidas), "", ",") + ;
                ALLTRIM(THIS.this_oBusinessObject.this_cCidChaves)
            loc_nLinhasGravadas = loc_nLinhasGravadas + 1
        ENDSCAN

        *-- Linhas que o usuario removeu da grade com btnExcluir precisam sair do
        *-- banco: no legado o cursor era uma view atualizavel e o Delete local
        *-- ia junto no Update/Commit; aqui a grade eh um cursor local.
        IF loc_lSucesso AND loc_lEraAlteracao
            loc_lSucesso = THIS.this_oBusinessObject.ExcluirItensRemovidos(loc_cProduto, loc_cChavesMantidas)
        ENDIF

        IF loc_lSucesso
            IF loc_nLinhasGravadas = 0 AND !loc_lEraAlteracao
                MsgAviso("Nenhum item informado para grava" + CHR(231) + CHR(227) + "o.")
            ELSE
                MsgInfo("Registro salvo com sucesso!", "Confirmar")
                THIS.LimparCampos()
                THIS.AlternarPagina(1)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela a inclusao e retorna para a Lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        *-- LimparCampos (e nao LimparDadosProduto) para tambem abandonar a
        *-- edicao no BO: sem isso o BO fica com this_lEmEdicao ligado depois de
        *-- um Incluir cancelado e o Fechar passa a perguntar por alteracoes
        *-- que nao existem mais
        THIS.LimparCampos()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Deve iterar Pages E Controls para PageFrames
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
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE
