*==============================================================================
* FormTfi.prg - Formulario de Cadastro de Tipos (Tipos de Fatura)
* Migrado de: SigCdTfi.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormTfi AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastros de Tipos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject       = .NULL.
    this_cModoAtual            = "LISTA"
    this_lComposicaoHabilitada = .F.

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
            THIS.this_oBusinessObject = CREATEOBJECT("TfiBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar TfiBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormTfi.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                    THIS.ConfigurarHabilitacaoComposicao()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormTfi:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTfi.InicializarForm")
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

        *-- Shape1 (legado: parent = SIGCDTFI raiz do form, NAO dentro de Pagina.Dados)
        *-- Fica atras do PageFrame (que cobre o form inteiro) - artefato do legado,
        *-- mantido apenas por fidelidade estrutural (mapeamento.json)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 120
            .Left        = 624
            .Width       = 100
            .Height      = 17
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Page1 completa (FASE 4/8)
    * cnt_4c_Cabecalho (faixa + labels), cnt_4c_Botoes (5 botoes CRUD),
    * cnt_4c_Saida (Encerrar - padrao canonico CLAUDE.md #10) e grd_4c_Lista.
    * BINDEVENT dos botoes e implementacao dos Btn*Click ficam para Fase 7/8.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (PRIMEIRO AddObject da pagina - CLAUDE.md regra #11)
        *-- Original: cntSombra.Top=2. Com compensacao +29: Top=31
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=538, Top=-1, Width=389, Height=85)
        *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
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

        *-- Botao Buscar (Left=305)
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

        *-- BINDEVENT dos botoes CRUD (Problema 17: metodos Btn*Click devem ser PUBLIC)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado per CLAUDE.md regra #10)
        *-- Legado: Grupo_Saida.Left=918/935, Top=-1. Canonico: Left=917, Top=29, Width=90
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

        *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
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

        *-- Grid de listagem de Tipos (Grade legado: Top=88, Left=12, Width=971, Height=470)
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 4
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
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
        *-- DblClick equivale ao duplo-clique do legado (mAtivaPagina1/Grade Column KeyPress)
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2 (FASE 5/8: primeira metade dos campos)
    * cnt_4c_Cabecalho (faixa + labels, identica a Page1 - Erro152) e
    * cnt_4c_BotoesAcao (vazio - botoes Confirmar/Cancelar entram na Fase 7).
    * Campos: Codigo, Descricao, %Qtde, %Valor, Adendo a Descricao,
    * Adendo ao Codigo, Opcao S/N/Ambos (primeira metade - ver Fase 6 p/ resto).
    * Compensacao PageFrame +29 aplicada a todos os Tops do original.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (faixa nas DUAS paginas - CLAUDE.md regra #11)
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

        *-- Container BotoesAcao (Grupo_Salva legado: Left=837, Top=-4, Width=161, Height=85)
        *-- Com compensacao PageFrame +29: Top=25 (-4+29), Left=837
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 25
            .Left        = 837
            .Width       = 161
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva legado: Left=5, Top=5)
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

        *-- Botao Cancelar (Cancelar legado: Left=81, Top=5)
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

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Campos principais - Page2 (FASE 5/8 - primeira metade)
        *-- Original: SIGCDTFI.Pagina.Dados.* -- Tops compensados +29 (PageFrame.Top=-29)

        *-- Codigo (PK - crSigCdTif.codigos - char(3) - InputMask "!!!" forca maiusculas)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 104
            .Left      = 233
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top           = 100
            .Left          = 278
            .Width         = 31
            .Height        = 25
            .MaxLength     = 3
            .InputMask     = "!!!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Descricao (crSigCdTif.descricaos - char(40))
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 132
            .Left      = 220
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Top           = 128
            .Left          = 278
            .Width         = 290
            .Height        = 25
            .MaxLength     = 40
            .InputMask     = REPLICATE("X", 40)
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- % Qtde (crSigCdTif.pqtdes - numeric(9,2))
        loc_oPagina.AddObject("lbl_4c_PQtde", "Label")
        WITH loc_oPagina.lbl_4c_PQtde
            .Caption   = "% Qtde :"
            .Top       = 160
            .Left      = 228
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_PQtde", "TextBox")
        WITH loc_oPagina.txt_4c_PQtde
            .Top           = 156
            .Left          = 278
            .Width         = 52
            .Height        = 25
            .MaxLength     = 5
            .InputMask     = "999.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- % Valor (crSigCdTif.pvalors - numeric(9,2))
        loc_oPagina.AddObject("lbl_4c_PValor", "Label")
        WITH loc_oPagina.lbl_4c_PValor
            .Caption   = "% Valor :"
            .Top       = 188
            .Left      = 228
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_PValor", "TextBox")
        WITH loc_oPagina.txt_4c_PValor
            .Top           = 184
            .Left          = 278
            .Width         = 52
            .Height        = 25
            .MaxLength     = 5
            .InputMask     = "999.99"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Adendo a Descricao (crSigCdTif.adendos - char(10))
        loc_oPagina.AddObject("lbl_4c_AdendoDesc", "Label")
        WITH loc_oPagina.lbl_4c_AdendoDesc
            .Caption   = "Adendo " + CHR(224) + " Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 216
            .Left      = 171
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Adendo", "TextBox")
        WITH loc_oPagina.txt_4c_Adendo
            .Top           = 212
            .Left          = 278
            .Width         = 81
            .Height        = 25
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Adendo ao Codigo (crSigCdTif.adendocs - char(2))
        loc_oPagina.AddObject("lbl_4c_ACodigo", "Label")
        WITH loc_oPagina.lbl_4c_ACodigo
            .Caption   = "Adendo ao C" + CHR(243) + "digo :"
            .Top       = 244
            .Left      = 178
            .Width     = 97
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ACodigo", "TextBox")
        WITH loc_oPagina.txt_4c_ACodigo
            .Top           = 240
            .Left          = 278
            .Width         = 26
            .Height        = 25
            .MaxLength     = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Opcao S/N/Ambos (crSigCdTif.opcsnas - numeric(1,0)) - OptionGroup 3 botoes
        *-- Original: Value=3 (Ambos selecionado por padrao)
        loc_oPagina.AddObject("obj_4c_OpcaoSNA", "OptionGroup")
        WITH loc_oPagina.obj_4c_OpcaoSNA
            .ButtonCount = 3
            .Top         = 186
            .Left        = 334
            .Width       = 159
            .Height      = 20
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OpcaoSNA.Buttons(1)
            .Caption   = "Sim"
            .Left      = 4
            .Top       = 2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_OpcaoSNA.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 51
            .Top       = 2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_OpcaoSNA.Buttons(3)
            .Caption   = "Ambos"
            .Left      = 99
            .Top       = 3
            .Width     = 50
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- NOTA SOBRE LOOKUPS (Fase 6): o codigo fonte original (SigCdTfi_form_codigo_fonte.txt)
        *-- NAO contem nenhum padrao de lookup (fwbuscaext/fwBuscaSel/sigacess/CreateObject de busca).
        *-- Os campos Get_OOrig/Get_OAdendo/Get_OCor/Get_OEmb/Get_OTam/Get_TamDesc sao TextBox
        *-- numericos simples (InputMask "99"), sem F4/DblClick no legado - NAO inventar lookup.

        *-- Linha separadora (Line1 legado: Top=247, Left=9, Width=980)
        loc_oPagina.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.lin_4c_Line1
            .Top         = 276
            .Left        = 9
            .Width       = 980
            .Height      = 0
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        *-- Titulo da secao (Label25 legado: Top=255, Left=57, FontBold=.T.)
        loc_oPagina.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPagina.lbl_4c_Label25
            .Caption   = " Configura" + CHR(231) + CHR(227) + "o da Descri" + CHR(231) + CHR(227) + "o do Produto "
            .Top       = 284
            .Left      = 57
            .Width     = 222
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Qtde Maxima Caracteres (crSigCdTif.tamdesc - numeric(2,0) - Label4/Get_TamDesc)
        loc_oPagina.AddObject("lbl_4c_TamDesc", "Label")
        WITH loc_oPagina.lbl_4c_TamDesc
            .Caption   = "Qtde.M" + CHR(225) + "xima Caracteres :"
            .Top       = 305
            .Left      = 144
            .Width     = 129
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_TamDesc", "TextBox")
        WITH loc_oPagina.txt_4c_TamDesc
            .Top           = 301
            .Left          = 278
            .Width         = 30
            .Height        = 25
            .InputMask     = "99"
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Descricao Original (crSigCdTif.oorig - numeric(2,0) - Label26/Get_OOrig)
        loc_oPagina.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oPagina.lbl_4c_Label26
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Original :"
            .Top       = 333
            .Left      = 179
            .Width     = 94
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OOrig", "TextBox")
        WITH loc_oPagina.txt_4c_OOrig
            .Top           = 329
            .Left          = 278
            .Width         = 30
            .Height        = 25
            .InputMask     = "99"
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Adendo Tipo Fatura (crSigCdTif.oaden - numeric(2,0) - Label27/Get_OAdendo)
        loc_oPagina.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oPagina.lbl_4c_Label27
            .Caption   = "Adendo Tipo Fatura :"
            .Top       = 361
            .Left      = 169
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OAdendo", "TextBox")
        WITH loc_oPagina.txt_4c_OAdendo
            .Top           = 357
            .Left          = 278
            .Width         = 30
            .Height        = 25
            .InputMask     = "99"
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Cor (crSigCdTif.ocor - numeric(2,0) - Label28/Get_OCor)
        loc_oPagina.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oPagina.lbl_4c_Label28
            .Caption   = "Cor :"
            .Top       = 305
            .Left      = 396
            .Width     = 26
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OCor", "TextBox")
        WITH loc_oPagina.txt_4c_OCor
            .Top           = 301
            .Left          = 426
            .Width         = 30
            .Height        = 25
            .InputMask     = "99"
            .Format        = "K"
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Embalagem (crSigCdTif.oemb - numeric(2,0) - Label29/Get_OEmb)
        loc_oPagina.AddObject("lbl_4c_Label29", "Label")
        WITH loc_oPagina.lbl_4c_Label29
            .Caption   = "Embalagem :"
            .Top       = 333
            .Left      = 359
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OEmb", "TextBox")
        WITH loc_oPagina.txt_4c_OEmb
            .Top           = 329
            .Left          = 426
            .Width         = 30
            .Height        = 25
            .InputMask     = "99"
            .Format        = "K"
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Tamanho (crSigCdTif.otam - numeric(2,0) - Label30/Get_OTam)
        loc_oPagina.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oPagina.lbl_4c_Label30
            .Caption   = "Tamanho :"
            .Top       = 361
            .Left      = 369
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OTam", "TextBox")
        WITH loc_oPagina.txt_4c_OTam
            .Top           = 357
            .Left          = 426
            .Width         = 30
            .Height        = 25
            .InputMask     = "99"
            .Format        = "K"
            .FontName      = "Tahoma"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Tipo da Descricao do Produto (crSigCdTif.tpdescs - numeric(1,0) - Label1/OptTipoDesc)
        *-- Original: Value=1 (Normal selecionado por padrao)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = " Tipo da Descri" + CHR(231) + CHR(227) + "o do Produto :"
            .Top       = 390
            .Left      = 121
            .Width     = 152
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptTipoDesc", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptTipoDesc
            .ButtonCount = 4
            .Top         = 385
            .Left        = 272
            .Width       = 92
            .Height      = 71
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTipoDesc.Buttons(1)
            .Caption   = "Normal"
            .Left      = 8
            .Top       = 3
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTipoDesc.Buttons(2)
            .Caption   = "Fiscal"
            .Left      = 8
            .Top       = 18
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTipoDesc.Buttons(3)
            .Caption   = "Digitada"
            .Left      = 8
            .Top       = 34
            .Width     = 57
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTipoDesc.Buttons(4)
            .Caption   = "Autom" + CHR(225) + "tica"
            .Left      = 8
            .Top       = 50
            .Width     = 72
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarHabilitacaoComposicao - Habilita/desabilita Cor/Embalagem/Tamanho
    * conforme SigCdPam.tipoestos (espelha Init() legado: InList(TipoEstos,2,3,4))
    * Le SigCdPam (parametros do sistema - registro unico) e ajusta os 3 campos
    * de composicao da descricao do produto.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarHabilitacaoComposicao()
        LOCAL loc_cSQL, loc_nResultado, loc_lHabilitado, loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            loc_cSQL = "SELECT tipoestos FROM SigCdPam"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Param") AND !EOF("cursor_4c_Param")
                SELECT cursor_4c_Param
                GO TOP
                loc_lHabilitado = INLIST(NVL(tipoestos, 0), 2, 3, 4)
                THIS.this_lComposicaoHabilitada = loc_lHabilitado

                loc_oPagina.txt_4c_OCor.Value   = 0
                loc_oPagina.txt_4c_OEmb.Value   = 0
                loc_oPagina.txt_4c_OTam.Value   = 0
                loc_oPagina.txt_4c_OCor.Enabled = loc_lHabilitado
                loc_oPagina.txt_4c_OEmb.Enabled = loc_lHabilitado
                loc_oPagina.txt_4c_OTam.Enabled = loc_lHabilitado
            ELSE
                MsgErro("Falha ao ler par" + CHR(226) + "metros do sistema (SigCdPam):" + CHR(13) + ;
                    CapturarErroSQL(), "Erro")
            ENDIF

            IF USED("cursor_4c_Param")
                USE IN cursor_4c_Param
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao configurar habilita" + CHR(231) + CHR(227) + "o de composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormTfi.ConfigurarHabilitacaoComposicao")
        ENDTRY
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
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
    * CarregarLista - Carrega dados no grid da Page1
    * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
    * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
    * Colunas espelham o fCarregaGrade legado: Codigos, Descricaos, PQtdes, PValors
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.pqtdes"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.pvalors"

                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 320
                loc_oGrid.Column3.Width = 80
                loc_oGrid.Column4.Width = 80

                *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "% Qtde"
                loc_oGrid.Column4.Header1.Caption = "% Valor"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTfi.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista (Tahoma 8, sem
    * DynamicBackColor - fundo branco padrao do fwgrade legado)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "FormTfi.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara BO/Form para incluir novo registro e abre Page2
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
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
    * BtnVisualizarClick - Carrega registro selecionado na grade e abre Page2
    * em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado na grade, prepara BO para
    * atualizacao (EditarRegistro) e abre Page2 em modo edicao
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado na grade, com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do tipo [" + loc_cCodigo + "]?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar um Tipo (SigCdTif)
    * e posiciona a grade da lista no registro selecionado
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTif", "cursor_4c_BuscaTfi", "codigos", "", ;
                "Buscar Tipo")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTfi")
                    SELECT cursor_4c_BuscaTfi
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaTfi.codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTfi")
                USE IN cursor_4c_BuscaTfi
            ENDIF

            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(codigos) == loc_cCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar tipo:" + CHR(13) + loException.Message, ;
                "FormTfi.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario (padrao canonico CLAUDE.md #10)
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma inclusao/alteracao: transfere Form->BO e salva
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao/visualizacao e volta para a lista
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados do Form (Page2) para o BO antes de salvar
    * Campos: Codigo, Descricao, Adendo, PQtde, PValor, ACodigo, OpcaoSNA,
    * OOrig, OAdendo, OCor, OEmb, OTam, TamDesc, TipoDesc (todos)
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo       = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao    = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_cAdendo       = ALLTRIM(loc_oPagina.txt_4c_Adendo.Value)
        THIS.this_oBusinessObject.this_nPQtde        = loc_oPagina.txt_4c_PQtde.Value
        THIS.this_oBusinessObject.this_nPValor       = loc_oPagina.txt_4c_PValor.Value
        THIS.this_oBusinessObject.this_cAdendoCodigo = ALLTRIM(loc_oPagina.txt_4c_ACodigo.Value)
        THIS.this_oBusinessObject.this_nOpcaoSNA     = loc_oPagina.obj_4c_OpcaoSNA.Value
        THIS.this_oBusinessObject.this_nOOrig        = loc_oPagina.txt_4c_OOrig.Value
        THIS.this_oBusinessObject.this_nOAdendo      = loc_oPagina.txt_4c_OAdendo.Value
        THIS.this_oBusinessObject.this_nOCor         = loc_oPagina.txt_4c_OCor.Value
        THIS.this_oBusinessObject.this_nOEmb         = loc_oPagina.txt_4c_OEmb.Value
        THIS.this_oBusinessObject.this_nOTam         = loc_oPagina.txt_4c_OTam.Value
        THIS.this_oBusinessObject.this_nTamDesc      = loc_oPagina.txt_4c_TamDesc.Value
        THIS.this_oBusinessObject.this_nTipoDesc     = loc_oPagina.obj_4c_OptTipoDesc.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BO para o Form (Page2) apos carregar
    * Campos: Codigo, Descricao, Adendo, PQtde, PValor, ACodigo, OpcaoSNA,
    * OOrig, OAdendo, OCor, OEmb, OTam, TamDesc, TipoDesc (todos)
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value      = THIS.this_oBusinessObject.this_cCodigo
        loc_oPagina.txt_4c_Descricao.Value   = THIS.this_oBusinessObject.this_cDescricao
        loc_oPagina.txt_4c_Adendo.Value      = THIS.this_oBusinessObject.this_cAdendo
        loc_oPagina.txt_4c_PQtde.Value       = THIS.this_oBusinessObject.this_nPQtde
        loc_oPagina.txt_4c_PValor.Value      = THIS.this_oBusinessObject.this_nPValor
        loc_oPagina.txt_4c_ACodigo.Value     = THIS.this_oBusinessObject.this_cAdendoCodigo
        loc_oPagina.obj_4c_OpcaoSNA.Value    = THIS.this_oBusinessObject.this_nOpcaoSNA
        loc_oPagina.txt_4c_OOrig.Value       = THIS.this_oBusinessObject.this_nOOrig
        loc_oPagina.txt_4c_OAdendo.Value     = THIS.this_oBusinessObject.this_nOAdendo
        loc_oPagina.txt_4c_OCor.Value        = THIS.this_oBusinessObject.this_nOCor
        loc_oPagina.txt_4c_OEmb.Value        = THIS.this_oBusinessObject.this_nOEmb
        loc_oPagina.txt_4c_OTam.Value        = THIS.this_oBusinessObject.this_nOTam
        loc_oPagina.txt_4c_TamDesc.Value     = THIS.this_oBusinessObject.this_nTamDesc
        loc_oPagina.obj_4c_OptTipoDesc.Value = THIS.this_oBusinessObject.this_nTipoDesc
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
    * Codigo somente editavel no modo INCLUIR (PK - When do GetCodigo no legado)
    * OCor/OEmb/OTam respeitam adicionalmente this_lComposicaoHabilitada
    * (SigCdPam.tipoestos - ver ConfigurarHabilitacaoComposicao)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lCodEditavel, loc_lComposicao
        loc_oPagina      = THIS.pgf_4c_Paginas.Page2
        loc_lCodEditavel = (THIS.this_cModoAtual == "INCLUIR")
        loc_lComposicao  = par_lHabilitar AND THIS.this_lComposicaoHabilitada

        loc_oPagina.txt_4c_Codigo.Enabled      = par_lHabilitar AND loc_lCodEditavel
        loc_oPagina.txt_4c_Descricao.Enabled   = par_lHabilitar
        loc_oPagina.txt_4c_PQtde.Enabled       = par_lHabilitar
        loc_oPagina.txt_4c_PValor.Enabled      = par_lHabilitar
        loc_oPagina.txt_4c_Adendo.Enabled      = par_lHabilitar
        loc_oPagina.txt_4c_ACodigo.Enabled     = par_lHabilitar
        loc_oPagina.obj_4c_OpcaoSNA.Enabled    = par_lHabilitar
        loc_oPagina.txt_4c_TamDesc.Enabled     = par_lHabilitar
        loc_oPagina.obj_4c_OptTipoDesc.Enabled = par_lHabilitar
        loc_oPagina.txt_4c_OOrig.Enabled       = par_lHabilitar
        loc_oPagina.txt_4c_OAdendo.Enabled     = par_lHabilitar
        loc_oPagina.txt_4c_OCor.Enabled        = loc_lComposicao
        loc_oPagina.txt_4c_OEmb.Enabled        = loc_lComposicao
        loc_oPagina.txt_4c_OTam.Enabled        = loc_lComposicao
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2 para novo registro
    * Valores default espelham o legado: OpcaoSNA=3 (Ambos), TipoDesc=1 (Normal)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value      = ""
        loc_oPagina.txt_4c_Descricao.Value   = ""
        loc_oPagina.txt_4c_Adendo.Value      = ""
        loc_oPagina.txt_4c_PQtde.Value       = 0
        loc_oPagina.txt_4c_PValor.Value      = 0
        loc_oPagina.txt_4c_ACodigo.Value     = ""
        loc_oPagina.obj_4c_OpcaoSNA.Value    = 3
        loc_oPagina.txt_4c_OOrig.Value       = 0
        loc_oPagina.txt_4c_OAdendo.Value     = 0
        loc_oPagina.txt_4c_OCor.Value        = 0
        loc_oPagina.txt_4c_OEmb.Value        = 0
        loc_oPagina.txt_4c_OTam.Value        = 0
        loc_oPagina.txt_4c_TamDesc.Value     = 0
        loc_oPagina.obj_4c_OptTipoDesc.Value = 1
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de acao da Page2 conforme modo
    * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditando
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
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

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
                "FormTfi.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
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
