*==============================================================================
* FormTpc.prg - Formulario de Cadastro de Tipos de Composicao
* Migrado de: SigCdTpc.SCX (frmcadastro)
*
* FASE 8/8: Eventos auxiliares (Buscar/Encerrar/Salvar/Cancelar) - CONCLUIDA
* Migracao completa (8 fases).
*==============================================================================

DEFINE CLASS FormTpc AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Tipos de Composi" + CHR(231) + CHR(227) + "o"
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
            THIS.this_oBusinessObject = CREATEOBJECT("TpcBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar TpcBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormTpc.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormTpc:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTpc.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1: Cabecalho + Botoes CRUD + Grid
    * cnt_4c_Cabecalho: faixa cinza com titulo (PRIMEIRO AddObject da pagina)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original: Top=2. Com compensacao +29: Top=31
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

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
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

        *-- Container de botoes CRUD (Grupo_op no legado: Left=544, Top=-1, Width=385, Height=85)
        *-- Canonico framework: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (legado: inserir, Left=5)
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (legado: consultar, Left=80)
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (legado: alterar, Left=155)
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (legado: excluir, Left=230)
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (legado: procurar, Left=305)
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida (padrao canonico - CLAUDE.md regra #10, PREVALECE sobre PILAR 1)
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (legado: pagina.lista.grade - Top=100, Left=29, Width=941, Height=484)
        *-- Compensacao PageFrame: Top = 100 + 29 = 129... porem framework canonico usa Top=117 (88+29)
        *-- Colunas do legado (comportamento.json AddCursor): Tipos (150), Descrs (290)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
            .ColumnCount        = 2
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
            .ReadOnly           = .T.
            .Visible            = .T.
            .Column1.Width              = 150
            .Column1.Header1.Caption    = "Tipos"
            .Column2.Width              = 290
            .Column2.Header1.Caption    = "Descrs"
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GridDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * FASE 5/8: cnt_4c_Cabecalho (PRIMEIRO AddObject - CLAUDE.md regra #11) +
    *           primeira metade dos campos (Tipo, Ordem Impressao, Descricao, Calcula Custos)
    * FASE 6/8: completa com os campos restantes (Imprimir, Utiliza Produto Acabado,
    *           Maiusculos), grid de Grupos vinculados e lookups
    *
    * Compensacao de Top nos controles de dados: +29 (PageFrame.Top=-29) + 8 (re-layout
    * obrigatorio pela faixa do cabecalho, que ocupa Top=29..109 - CLAUDE.md regra #11,
    * "nenhum controle de dados pode ter Top < 109"; usamos >=115 como piso seguro)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Faixa do cabecalho (padronizacao das duas paginas - CLAUDE.md regra #11 / Erro152)
        *-- PRIMEIRO AddObject da pagina: os containers de botao (Top=29..33) ficam
        *-- DENTRO da area da faixa (29..109) e precisam ser criados DEPOIS para desenhar por cima.
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
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

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
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

        *-- Container BotoesAcao (Grupo_Salva no legado: Left=843, Top=-4, Width=160, Height=85)
        *-- Canonico framework (padrao FormCor/FormMoe): Top=33, Left=842, Width=160, Height=85
        *-- Criado DEPOIS do cabecalho para ficar POR CIMA da faixa (Top=33 esta dentro de 29..109)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oPagina.cnt_4c_BotoesAcao.ZOrder(0)

        *-- Botao Confirmar (legado: grupo_salva.salva, Left=5)
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (legado: grupo_salva.cancelar, Left=80)
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- ===================================================================
        *-- Campo: Tipo (getTipos -> txt_4c_Tipos) - PK, maiusculas (Format K!)
        *-- Original: Top=79, Left=398, Width=150. Compensado: 79+29+8=116
        *-- ===================================================================
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Caption   = "Tipo :"
            .Top       = 120
            .Left      = 367
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
        WITH loc_oPagina.txt_4c_Tipos
            .Top           = 116
            .Left          = 398
            .Width         = 150
            .Height        = 23
            .MaxLength     = 20
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- Campo: Ordem de Impressao (GetnOrdems -> txt_4c_NOrdems) - numerico 2 digitos
        *-- Original: Top=79, Left=697, Width=32. Compensado: 79+29+8=116
        *-- ===================================================================
        loc_oPagina.AddObject("lbl_4c_OrdemImpressao", "Label")
        WITH loc_oPagina.lbl_4c_OrdemImpressao
            .Caption   = "Ordem de Impress" + CHR(227) + "o :"
            .Top       = 120
            .Left      = 586
            .Width     = 109
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_NOrdems", "TextBox")
        WITH loc_oPagina.txt_4c_NOrdems
            .Top           = 116
            .Left          = 697
            .Width         = 32
            .Height        = 23
            .InputMask     = "99"
            .MaxLength     = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- Campo: Descricao (getDescrs -> txt_4c_Descrs)
        *-- Original: Top=105, Left=398, Width=331. Compensado: 105+29+8=142
        *-- ===================================================================
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 145
            .Left      = 341
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Top           = 142
            .Left          = 398
            .Width         = 331
            .Height        = 23
            .MaxLength     = 40
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- Campo: Calcula Custos (optCustos -> obj_4c_OptCustos) - OptionGroup Sim/Nao
        *-- Original: Top=128, Left=393, Width=93. Compensado: 128+29+8=165
        *-- ===================================================================
        loc_oPagina.AddObject("lbl_4c_CalculaCustos", "Label")
        WITH loc_oPagina.lbl_4c_CalculaCustos
            .Caption   = "Calcula Custos :"
            .Top       = 170
            .Left      = 317
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptCustos", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptCustos
            .Top         = 165
            .Left        = 393
            .Width       = 98
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptCustos.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptCustos.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 51
            .Top       = 5
            .Width     = 37
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- ===================================================================
        *-- Campo: Imprimir (OptImp -> obj_4c_OptImp) - OptionGroup Sim/Nao
        *-- Original: Top=149, Left=393, Width=93. Compensado: 149+29+8=186
        *-- ===================================================================
        loc_oPagina.AddObject("lbl_4c_Imprimir", "Label")
        WITH loc_oPagina.lbl_4c_Imprimir
            .Caption   = "Imprimir :"
            .Top       = 191
            .Left      = 349
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptImp", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptImp
            .Top         = 186
            .Left        = 393
            .Width       = 98
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptImp.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptImp.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 51
            .Top       = 5
            .Width     = 37
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- ===================================================================
        *-- Campo: Utilizar Produto Acabado (optUsarPAs -> obj_4c_OptUsarPAs)
        *-- Original: Top=171, Left=393, Width=93. Compensado: 171+29+8=208
        *-- ===================================================================
        loc_oPagina.AddObject("lbl_4c_UtilizaProdutoAcabado", "Label")
        WITH loc_oPagina.lbl_4c_UtilizaProdutoAcabado
            .Caption   = "Utilizar Produto Acabado :"
            .Top       = 213
            .Left      = 269
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptUsarPAs", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptUsarPAs
            .Top         = 208
            .Left        = 393
            .Width       = 98
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptUsarPAs.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptUsarPAs.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 51
            .Top       = 5
            .Width     = 37
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- ===================================================================
        *-- Campo: Maiusculos (OptMaius -> obj_4c_OptMaius) - OptionGroup Sim/Nao
        *-- Original: Top=193, Left=393, Width=93. Compensado: 193+29+8=230
        *-- ===================================================================
        loc_oPagina.AddObject("lbl_4c_Maiusculos", "Label")
        WITH loc_oPagina.lbl_4c_Maiusculos
            .Caption   = "Mai" + CHR(250) + "sculos :"
            .Top       = 235
            .Left      = 336
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptMaius", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptMaius
            .Top         = 230
            .Left        = 393
            .Width       = 98
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptMaius.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptMaius.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 51
            .Top       = 5
            .Width     = 37
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- ===================================================================
        *-- Grid de Grupos vinculados (grdProdutos -> grd_4c_Dados)
        *-- Detalhe SigCdCom (cgrus + dgrus via JOIN SigCdGrp), cursor local do BO:
        *-- this_oBusinessObject.this_cCursorGrupos ("cursor_4c_Grupos")
        *-- Original: Top=221, Left=400, Width=223, Height=350. Compensado: 221+29+8=258
        *-- RecordSource/ControlSource sao ligados em runtime por CarregarGridGrupos()
        *-- (grid precisa existir antes do cursor_4c_Grupos ser criado - Problema 36)
        *-- ===================================================================
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .Top                = 258
            .Left               = 400
            .Width              = 223
            .Height             = 350
            .ColumnCount        = 2
            .FontName           = "Verdana"
            .FontSize           = 8
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .DeleteMark         = .F.
            .RecordMark         = .T.
            .HeaderHeight       = 16
            .RowHeight          = 15
            .ScrollBars         = 2
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .Visible            = .T.
            .Column1.Width              = 40
            .Column1.Movable            = .F.
            .Column1.Resizable          = .F.
            .Column1.FontName           = "Verdana"
            .Column1.FontSize           = 8
            .Column1.Header1.Caption    = "Grupo"
            .Column1.Header1.Alignment  = 2
            .Column2.Width              = 150
            .Column2.Movable            = .F.
            .Column2.Resizable          = .F.
            .Column2.FontName           = "Verdana"
            .Column2.FontSize           = 8
            .Column2.Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.Alignment  = 2
        ENDWITH

        *-- Lookup na coluna Grupo (F4/DblClick abrem FormBuscaAuxiliar em SigCdGrp)
        BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GridGruposColumn1KeyPress")
        BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "DblClick", THIS, "GridGruposColumn1DblClick")

        *-- Lookup na coluna Descricao (mesmo comportamento do legado - fwBuscaExt tambem
        *-- disparado a partir da coluna de descricao)
        BINDEVENT(loc_oPagina.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "GridGruposColumn2KeyPress")
        BINDEVENT(loc_oPagina.grd_4c_Dados.Column2.Text1, "DblClick", THIS, "GridGruposColumn2DblClick")

        *-- ===================================================================
        *-- Botao Excluir linha da grade (cmdExcluir -> cmd_4c_CmdExcluir)
        *-- Original: Top=373, Left=626, Width=45, Height=46. Compensado: 373+29+8=410
        *-- ===================================================================
        loc_oPagina.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH loc_oPagina.cmd_4c_CmdExcluir
            .Top           = 410
            .Left          = 626
            .Width         = 45
            .Height        = 46
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .FontName      = "Arial"
            .FontSize      = 7
            .FontBold      = .F.
            .FontItalic    = .F.
            .BackColor     = RGB(255, 255, 255)
            .ToolTipText   = "Excluir Item da Grade"
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirLinhaGrupoClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarGridGrupos - Vincula o grid de Grupos (Page2) ao cursor local do BO
    * (this_oBusinessObject.this_cCursorGrupos). Deve ser chamado sempre que o
    * cursor for (re)criado: apos CarregarGrupos() [ALTERAR/VISUALIZAR] ou
    * InicializarCursoresGrid() [INCLUIR].
    * RecordSource/ControlSource sao definidos aqui (nao na criacao do Grid) para
    * nao serem resetados por sucessivas trocas de cursor (Problema 48).
    *===========================================================================
    PROTECTED PROCEDURE CarregarGridGrupos()
        LOCAL loc_oGrid, loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrupos

        IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) != "O" OR !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados

        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 2
        loc_oGrid.RecordSource = loc_cCursor

        loc_oGrid.Column1.ControlSource   = loc_cCursor + ".cgrus"
        loc_oGrid.Column1.CurrentControl  = "Text1"
        loc_oGrid.Column1.Width           = 40
        loc_oGrid.Column1.Header1.Caption = "Grupo"

        loc_oGrid.Column2.ControlSource   = loc_cCursor + ".dgrus"
        loc_oGrid.Column2.CurrentControl  = "Text1"
        loc_oGrid.Column2.Width           = 150
        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

        loc_oGrid.Refresh()

        RETURN .T.
    ENDPROC

    *===========================================================================
    * GridGruposColumn1KeyPress/DblClick - Lookup da coluna Grupo (cgrus)
    * F4 (codigo 28 no VFP9) ou duplo-clique abrem FormBuscaAuxiliar (SigCdGrp)
    *===========================================================================
    PROCEDURE GridGruposColumn1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoGrid()
        ENDIF
    ENDPROC

    PROCEDURE GridGruposColumn1DblClick()
        THIS.AbrirLookupGrupoGrid()
    ENDPROC

    *===========================================================================
    * GridGruposColumn2KeyPress/DblClick - Lookup da coluna Descricao (dgrus)
    * Legado dispara o mesmo fwBuscaExt tambem a partir da coluna de descricao
    *===========================================================================
    PROCEDURE GridGruposColumn2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoGrid()
        ENDIF
    ENDPROC

    PROCEDURE GridGruposColumn2DblClick()
        THIS.AbrirLookupGrupoGrid()
    ENDPROC

    *===========================================================================
    * AbrirLookupGrupoGrid - Abre FormBuscaAuxiliar (SigCdGrp/cgrus/dgrus) e grava
    * o codigo+descricao selecionados na linha ATUAL do cursor de grupos do BO.
    * Ao confirmar a selecao, avanca para a proxima linha (append blank se for a
    * ultima) - equivalente ao legado (Skip/Append Blank apos Enter na Valid
    * original do fwget da grade).
    *===========================================================================
    PROCEDURE AbrirLookupGrupoGrid()
        LOCAL loc_cCursor, loc_oGrid, loc_oBusca, loc_cValorAtual, loc_cCodigo, loc_cDescricao

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrupos

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados

        SELECT (loc_cCursor)
        loc_cValorAtual = ALLTRIM(cgrus)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaGrupo", "cgrus", loc_cValorAtual, "Buscar Grupo")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cgrus", "", "Grupo")
                loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
                loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrupo.dgrus)

                SELECT (loc_cCursor)
                REPLACE cgrus WITH loc_cCodigo, ;
                        dgrus WITH loc_cDescricao IN (loc_cCursor)

                *-- Avanca para a proxima linha, criando uma em branco se necessario
                IF !EOF(loc_cCursor)
                    SKIP IN (loc_cCursor)
                ENDIF
                IF EOF(loc_cCursor)
                    APPEND BLANK IN (loc_cCursor)
                ENDIF
            ELSE
                *-- Nao selecionou: se o codigo ficou vazio, limpa a descricao tambem
                SELECT (loc_cCursor)
                IF EMPTY(ALLTRIM(cgrus))
                    REPLACE dgrus WITH "" IN (loc_cCursor)
                ENDIF
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF

        loc_oGrid.Refresh()
    ENDPROC

    *===========================================================================
    * BtnExcluirLinhaGrupoClick - Remove a linha atual da grade de Grupos
    * Equivalente ao legado (cmdExcluir.Click): Delete In crGrdCdCom + Refresh
    *===========================================================================
    PROCEDURE BtnExcluirLinhaGrupoClick()
        LOCAL loc_cCursor, loc_oGrid

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrupos

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados

        SELECT (loc_cCursor)
        IF !EOF(loc_cCursor)
            DELETE IN (loc_cCursor)
        ENDIF

        loc_oGrid.Refresh()
        THIS.Refresh()

        IF VARTYPE(loc_oGrid.Column1.Text1) = "O"
            loc_oGrid.SetFocus()
            loc_oGrid.Column1.Text1.SetFocus()
        ENDIF
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega registros de SigCdTpc no grid da Page1
    * PUBLIC: chamado externamente por TesteAutomatico.prg (regra CLAUDE.md #3)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (tipos C(20), descrs C(40))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Lista) = "O"
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        loc_oGrid.ColumnCount = 2
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                        loc_oGrid.Column1.Width = 150
                        loc_oGrid.Column2.Width = 290
                        loc_oGrid.Column1.Header1.Caption = "Tipos"
                        loc_oGrid.Column2.Header1.Caption = "Descrs"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTpc.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * PUBLIC: chamado externamente por TesteAutomatico.prg (regra CLAUDE.md #3)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados do Form (Page2) para o Business Object
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_cTipo                = ALLTRIM(loc_oPg2.txt_4c_Tipos.Value)
            .this_cDescricao            = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
            .this_nOrdemImpressao       = loc_oPg2.txt_4c_NOrdems.Value
            .this_nCalculaCustos        = loc_oPg2.obj_4c_OptCustos.Value
            .this_nImprimir             = loc_oPg2.obj_4c_OptImp.Value
            .this_nUtilizaProdutoAcabado = loc_oPg2.obj_4c_OptUsarPAs.Value
            .this_nMaiusculos           = loc_oPg2.obj_4c_OptMaius.Value
        ENDWITH
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do Business Object para o Form (Page2)
    *===========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPg2.txt_4c_Tipos.Value      = .this_cTipo
            loc_oPg2.txt_4c_Descrs.Value     = .this_cDescricao
            loc_oPg2.txt_4c_NOrdems.Value    = .this_nOrdemImpressao
            loc_oPg2.obj_4c_OptCustos.Value  = IIF(.this_nCalculaCustos = 0, 1, .this_nCalculaCustos)
            loc_oPg2.obj_4c_OptImp.Value     = IIF(.this_nImprimir = 0, 1, .this_nImprimir)
            loc_oPg2.obj_4c_OptUsarPAs.Value = IIF(.this_nUtilizaProdutoAcabado = 0, 1, .this_nUtilizaProdutoAcabado)
            loc_oPg2.obj_4c_OptMaius.Value   = IIF(.this_nMaiusculos = 0, 1, .this_nMaiusculos)
        ENDWITH
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme o modo
    * txt_4c_Tipos (PK) so fica editavel em INCLUIR (comportamento.json: getTipos
    * When = InList(pcEscolha,"INSERIR","PROCURAR") - nao editavel em ALTERAR)
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lIncluir
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lIncluir = (THIS.this_cModoAtual == "INCLUIR")

        loc_oPg2.txt_4c_Tipos.Enabled       = par_lHabilitar AND loc_lIncluir
        loc_oPg2.txt_4c_Descrs.Enabled      = par_lHabilitar
        loc_oPg2.txt_4c_NOrdems.Enabled     = par_lHabilitar
        loc_oPg2.obj_4c_OptCustos.Enabled   = par_lHabilitar
        loc_oPg2.obj_4c_OptImp.Enabled      = par_lHabilitar
        loc_oPg2.obj_4c_OptUsarPAs.Enabled  = par_lHabilitar
        loc_oPg2.obj_4c_OptMaius.Enabled    = par_lHabilitar
        loc_oPg2.grd_4c_Dados.Enabled       = par_lHabilitar
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os campos da Page2 (usado antes de Incluir)
    *===========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Tipos.Value      = ""
        loc_oPg2.txt_4c_Descrs.Value     = ""
        loc_oPg2.txt_4c_NOrdems.Value    = 0
        loc_oPg2.obj_4c_OptCustos.Value  = 1
        loc_oPg2.obj_4c_OptImp.Value     = 1
        loc_oPg2.obj_4c_OptUsarPAs.Value = 1
        loc_oPg2.obj_4c_OptMaius.Value   = 1
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta botoes de acao da Page2 conforme o modo
    * cmd_4c_Confirmar fica desabilitado em modo VISUALIZAR (CLAUDE.md #10/#20)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lSoConsulta
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_lSoConsulta = (THIS.this_cModoAtual == "VISUALIZAR")

        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lSoConsulta
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Inicia a inclusao de um novo Tipo de Composicao
    * PUBLIC (metodos chamados via BINDEVENT nao podem ser PROTECTED - regra #3)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_oBusinessObject.InicializarCursoresGrid()

        IF USED(THIS.this_oBusinessObject.this_cCursorGrupos)
            APPEND BLANK IN (THIS.this_oBusinessObject.this_cCursorGrupos)
        ENDIF

        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.CarregarGridGrupos()
        THIS.AlternarPagina(2)

        IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos) = "O"
            THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.SetFocus()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega o registro selecionado na lista para alteracao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cTipo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cTipo = ALLTRIM(cursor_4c_Dados.tipos)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipo)
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro selecionado!", "Erro")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.EditarRegistro()
        THIS.BOParaForm()
        THIS.this_cModoAtual = "ALTERAR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.CarregarGridGrupos()
        THIS.AlternarPagina(2)

        IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs) = "O"
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega o registro selecionado somente para consulta
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cTipo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cTipo = ALLTRIM(cursor_4c_Dados.tipos)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipo)
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro selecionado!", "Erro")
            RETURN
        ENDIF

        THIS.BOParaForm()
        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.HabilitarCampos(.F.)
        THIS.AjustarBotoesPorModo()
        THIS.CarregarGridGrupos()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o registro selecionado na lista (com confirmacao)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cTipo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cTipo = ALLTRIM(cursor_4c_Dados.tipos)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do tipo '" + loc_cTipo + "'?", "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipo)
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro para exclus" + CHR(227) + "o!", "Erro")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Excluir()
            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
            THIS.CarregarLista()
        ELSE
            MsgErro("Erro ao excluir:" + CHR(13) + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
        ENDIF
    ENDPROC

    *===========================================================================
    * GridDblClick - Duplo-clique no grid da lista abre em modo Visualizar
    * (padrao canonico - ver FormBCC/FormDepartamento)
    *===========================================================================
    PROCEDURE GridDblClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Localiza um Tipo de Composicao pelo codigo exato
    * Legado (msv_procurar): Select crSigCdTpc / Locate For Tipos = valor
    * Migrado: reaproveita TpcBO.Buscar(par_cFiltro), que faz filtro EXATO
    * (WHERE RTRIM(tipos) = filtro) e recarrega o grid da Page1 com o resultado
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro

        loc_cFiltro = INPUTBOX("Digite o c" + CHR(243) + "digo do Tipo para localizar:", ;
            "Buscar Tipo de Composi" + CHR(231) + CHR(227) + "o", "")

        IF EMPTY(ALLTRIM(loc_cFiltro))
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum Tipo de Composi" + CHR(231) + CHR(227) + "o encontrado com o c" + CHR(243) + "digo informado.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.CarregarLista()
            ELSE
                IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Lista) = "O"
                    THIS.FormatarGridLista(THIS.pgf_4c_Paginas.Page1.grd_4c_Lista)
                ENDIF
            ENDIF
        ELSE
            MsgErro("Erro ao buscar Tipo de Composi" + CHR(231) + CHR(227) + "o!", "Erro")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma inclusao/alteracao (grupo_salva.salva no legado)
    * Validacoes na ordem do legado:
    *   1. Codigo do Tipo obrigatorio (somente INCLUIR)
    *   2. Codigo duplicado (somente INCLUIR)
    *   3. Descricao obrigatoria (INCLUIR/ALTERAR)
    * TpcBO.Inserir()/Atualizar() ja gravam a grade de Grupos (SalvarGrupos)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cTipo, loc_cDescricao

        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_cTipo      = ALLTRIM(loc_oPg2.txt_4c_Tipos.Value)
        loc_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)

        IF THIS.this_cModoAtual == "INCLUIR"
            IF EMPTY(loc_cTipo)
                MsgAviso("C" + CHR(243) + "digo de Tipo N" + CHR(227) + "o Informado...", "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_oPg2.txt_4c_Tipos.SetFocus()
                RETURN
            ENDIF

            IF THIS.this_oBusinessObject.Buscar(loc_cTipo) AND USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                MsgAviso("C" + CHR(243) + "digo de Tipo J" + CHR(225) + " Cadastrado...", "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_oPg2.txt_4c_Tipos.SetFocus()
                RETURN
            ENDIF
        ENDIF

        IF EMPTY(loc_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oPg2.txt_4c_Descrs.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgSucesso("Tipo de Composi" + CHR(231) + CHR(227) + "o salvo com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ELSE
                MsgErro("Erro ao salvar:" + CHR(13) + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormTpc.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela inclusao/alteracao e volta para a lista
    * (grupo_salva.cancelar no legado: DoDefault() + mAtivaPagina1 se plCancelar)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_oBusinessObject.CancelarEdicao()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario (cnt_4c_Saida.cmd_4c_Encerrar)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Controls E Pages (para PageFrames aninhados)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
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

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista (chamado apos carga)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        par_oGrid.FontName = "Tahoma"
        par_oGrid.FontSize = 8
        par_oGrid.Refresh()
    ENDPROC

    *===========================================================================
    * Destroy - Finalizacao do formulario
    *===========================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
