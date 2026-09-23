*==============================================================================
* FormUfd.prg - Formulario de Cadastro de ICMS Interestadual (UF x UF)
* Migrado de: SigCdUfd.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormUfd AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "ICMS Interestadual"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual       = "LISTA"

    *-- Guardas de "valor alterado" para lookups disparados via LostFocus (Problema 45)
    this_cUltOCodigo  = ""
    this_cUltONome    = ""
    this_cUltDCodigo  = ""
    this_cUltDNome    = ""
    this_cUltCfop     = ""

    *-- Resultado temporario do lookup de UF (preenchido por ExecutarBuscaUf)
    this_cUfLookupCodigo    = ""
    this_cUfLookupDescricao = ""

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
            THIS.this_oBusinessObject = CREATEOBJECT("UfdBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar UfdBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormUfd.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormUfd:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormUfd.InicializarForm")
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
    * ConfigurarPaginaLista - Estrutura completa de Page1 (Lista)
    * Cabecalho + Grid de 8 colunas (pColuna do legado) + Botoes CRUD + Saida
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
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

        *-- Container Botoes CRUD (Grupo_op no legado)
        *-- Canonico: Left=542, Top=29, Width=390, Height=85
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
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

        *-- Grid de listagem (Grade no legado - 8 colunas conforme pColuna)
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 8
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
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * par_cFiltro (opcional) - clausula WHERE adicional (usado por BtnBuscarClick)
    * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
    * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
    * Colunas conforme pColuna do legado (comportamento.json / SIGCDUFD.Init)
    *===========================================================================
    PROCEDURE CarregarLista(par_cFiltro)
        LOCAL loc_lResultado, loc_oGrid, loc_cFiltro
        loc_lResultado = .F.
        loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", par_cFiltro, "")

        TRY
            IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
                loc_oGrid.ColumnCount = 8
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.destinos"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aliqs"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.aliqsbs"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.aliqpimps"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.aliqfcp"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.aliqredb"
                loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.iest"

                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 80
                loc_oGrid.Column3.Width = 80
                loc_oGrid.Column4.Width = 80
                loc_oGrid.Column5.Width = 80
                loc_oGrid.Column6.Width = 80
                loc_oGrid.Column7.Width = 80
                loc_oGrid.Column8.Width = 100

                *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                loc_oGrid.Column1.Header1.Caption = "UF Origem"
                loc_oGrid.Column2.Header1.Caption = "UF Destino"
                loc_oGrid.Column3.Header1.Caption = "Aliq. ICMS"
                loc_oGrid.Column4.Header1.Caption = "Aliq.Sub.Trib"
                loc_oGrid.Column5.Header1.Caption = "Aliq.Prod.Importado"
                loc_oGrid.Column6.Header1.Caption = "Aliq.FECP"
                loc_oGrid.Column7.Header1.Caption = "Aliq.Reducao Base"
                loc_oGrid.Column8.Header1.Caption = "IE Subst.Trib.Dest."

                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_oGrid.Refresh()

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormUfd.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
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
                "FormUfd.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "FormUfd.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
    * TextBoxes de campos serao adicionados nas proximas fases
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
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

        *-- Container BotoesAcao (Grupo_Salva legado) - vazio nesta fase
        *-- Canonico: Top=33, Left=842, Width=160, Height=85 (botoes na Fase 4)
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

        *-- Campos principais - PARTE 1 (50%): UF Origem/Destino + Aliquotas basicas
        *-- Compensacao PageFrame.Top=-29: Top_migrado = Top_original + 29
        *-- Fonte: SigCdUfd_form_codigo_fonte.txt (Say1/Say3/Say2/Say5/Say14/Say8 + Get_OCodigo/
        *-- Get_ONome/Get_DCodigo/Get_DNome/getAicms/Getaliqpimps/getAliqFcp/getAliqredb)

        *-- Say1 "U.F. Origem :"
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "U.F. Origem :"
            .Top       = 165
            .Left      = 297
            .Width     = 67
            .Height    = 15
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_OCodigo -> txt_4c_OCodigo (FK SigCdUfs.Estados - UF Origem)
        loc_oPagina.AddObject("txt_4c_OCodigo", "TextBox")
        WITH loc_oPagina.txt_4c_OCodigo
            .Top           = 162
            .Left          = 368
            .Width         = 24
            .Height        = 25
            .Format        = "A"
            .InputMask     = "!!"
            .MaxLength     = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Get_ONome -> txt_4c_ONome (descricao da UF Origem - preenchido via lookup, nao gravado)
        loc_oPagina.AddObject("txt_4c_ONome", "TextBox")
        WITH loc_oPagina.txt_4c_ONome
            .Top           = 162
            .Left          = 395
            .Width         = 276
            .Height        = 25
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say3 "U.F. Destino :"
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "U.F. Destino :"
            .Top       = 193
            .Left      = 295
            .Width     = 69
            .Height    = 15
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_DCodigo -> txt_4c_DCodigo (FK SigCdUfs.Estados - UF Destino)
        loc_oPagina.AddObject("txt_4c_DCodigo", "TextBox")
        WITH loc_oPagina.txt_4c_DCodigo
            .Top           = 190
            .Left          = 368
            .Width         = 24
            .Height        = 25
            .Format        = "A"
            .InputMask     = "!!"
            .MaxLength     = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Get_DNome -> txt_4c_DNome (descricao da UF Destino - preenchido via lookup, nao gravado)
        loc_oPagina.AddObject("txt_4c_DNome", "TextBox")
        WITH loc_oPagina.txt_4c_DNome
            .Top           = 190
            .Left          = 395
            .Width         = 276
            .Height        = 25
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say2 "Aliquota de ICMS :"
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Al" + CHR(237) + "quota de ICMS :"
            .Top       = 221
            .Left      = 273
            .Width     = 91
            .Height    = 15
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getAicms -> txt_4c_Aicms (this_nAliqIcms / coluna aliqs)
        loc_oPagina.AddObject("txt_4c_Aicms", "TextBox")
        WITH loc_oPagina.txt_4c_Aicms
            .Top           = 218
            .Left          = 368
            .Width         = 45
            .Height        = 25
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Say5 "Aliquota de ICMS P.imp :"
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Al" + CHR(237) + "quota de ICMS P.imp :"
            .Top       = 249
            .Left      = 244
            .Width     = 120
            .Height    = 15
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Getaliqpimps -> txt_4c_Aliqpimps (this_nAliqIcmsPImp / coluna aliqpimps)
        loc_oPagina.AddObject("txt_4c_Aliqpimps", "TextBox")
        WITH loc_oPagina.txt_4c_Aliqpimps
            .Top           = 246
            .Left          = 368
            .Width         = 45
            .Height        = 25
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Say14 "Aliquota ICMS para FCP :"
        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = "Al" + CHR(237) + "quota ICMS para FCP :"
            .Top       = 362
            .Left      = 241
            .Width     = 123
            .Height    = 15
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getAliqFcp -> txt_4c_AliqFcp (this_nAliqFcp / coluna aliqfcp)
        loc_oPagina.AddObject("txt_4c_AliqFcp", "TextBox")
        WITH loc_oPagina.txt_4c_AliqFcp
            .Top           = 359
            .Left          = 368
            .Width         = 45
            .Height        = 25
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .ToolTipText   = "Percentual do ICMS relativo ao Fundo de Combate " + CHR(224) + " Pobreza (FCP) na UF de destino"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Say8 "Aliquota de Reducao de Base ICMS :"
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Al" + CHR(237) + "quota de Redu" + CHR(231) + CHR(227) + "o de Base ICMS :"
            .Top       = 418
            .Left      = 187
            .Width     = 177
            .Height    = 15
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getAliqredb -> txt_4c_Aliqredb (this_nAliqRedBase / coluna aliqredb)
        loc_oPagina.AddObject("txt_4c_Aliqredb", "TextBox")
        WITH loc_oPagina.txt_4c_Aliqredb
            .Top           = 415
            .Left          = 368
            .Width         = 45
            .Height        = 25
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .ToolTipText   = "Percentual de reducao da base de calculo do ICMS. Aplicado quando CST = 20"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Say4 "Aliquota Local Subs.Tributaria :"
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Al" + CHR(237) + "quota Local Subs.Tribut" + CHR(225) + "ria :"
            .Top       = 304
            .Left      = 213
            .Width     = 151
            .Height    = 15
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_AliqSB -> txt_4c_AliqSB (this_nAliqSubTrib / coluna aliqsbs)
        loc_oPagina.AddObject("txt_4c_AliqSB", "TextBox")
        WITH loc_oPagina.txt_4c_AliqSB
            .Top           = 302
            .Left          = 368
            .Width         = 45
            .Height        = 25
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Say6 "Aliquota Interestadual :"
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Aliquota Interestadual :"
            .Top       = 333
            .Left      = 248
            .Width     = 116
            .Height    = 15
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- GetaliqInter -> txt_4c_AliqInter (this_nAliqInterestadual / coluna aliqsb2s)
        loc_oPagina.AddObject("txt_4c_AliqInter", "TextBox")
        WITH loc_oPagina.txt_4c_AliqInter
            .Top           = 331
            .Left          = 368
            .Width         = 45
            .Height        = 25
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .ToolTipText   = "- 7% para os Estados de origem do Sul e Sudeste (exceto ES), destinado para os Estados do Norte, Nordeste, Centro-Oeste e Esp" + CHR(237) + "rito Santo; 12% para os demais casos. (A partir de 01/01/2016)"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- lbl_fator "CFOp :" (classe say com Width/Alignment declarados no legado -> preservar)
        loc_oPagina.AddObject("lbl_4c_Lbl_fator", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_fator
            .Caption   = "CFOp :"
            .Top       = 275
            .Left      = 328
            .Width     = 36
            .Height    = 15
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getCFO -> txt_4c_CFO (this_cCfop / coluna cfos char(10)) - LOOKUP SigCdCfo
        loc_oPagina.AddObject("txt_4c_CFO", "TextBox")
        WITH loc_oPagina.txt_4c_CFO
            .Top           = 274
            .Left          = 368
            .Width         = 80
            .Height        = 25
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say7 "IE do substituto tributario do Destino :"
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "IE do substituto tribut" + CHR(225) + "rio do Destino :"
            .Top       = 388
            .Left      = 178
            .Width     = 186
            .Height    = 15
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- GetIest -> txt_4c_Iest (this_cIeSubstituto / coluna iest char(20))
        loc_oPagina.AddObject("txt_4c_Iest", "TextBox")
        WITH loc_oPagina.txt_4c_Iest
            .Top           = 387
            .Left          = 368
            .Width         = 179
            .Height        = 25
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say38 "Base Reduzida :"
        loc_oPagina.AddObject("lbl_4c_Label38", "Label")
        WITH loc_oPagina.lbl_4c_Label38
            .Caption   = "Base Reduzida :"
            .Top       = 445
            .Left      = 285
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OPT_ALTTRANS -> obj_4c_OPT_ALTTRANS (this_nBaseReduzida / coluna nbaseres)
        loc_oPagina.AddObject("obj_4c_OPT_ALTTRANS", "OptionGroup")
        WITH loc_oPagina.obj_4c_OPT_ALTTRANS
            .ButtonCount  = 2
            .Top          = 445
            .Left         = 363
            .Width        = 125
            .Height       = 15
            .BackStyle    = 0
            .BorderStyle  = 0
            .Themes       = .F.
            .Value        = 1
            .Visible      = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OPT_ALTTRANS.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 0
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_OPT_ALTTRANS.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 69
            .Top       = 0
            .Width     = 46
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Say15 "Aliquota Local por Classificacao :" (rotulo da area do grid GradAlo - grid em fase futura)
        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Caption   = "Aliquota Local por Classificacao :"
            .Top       = 223
            .Left      = 489
            .Width     = 158
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say9 "Aliquota FCP por Cfop :" (rotulo da area do grid GradAlocfop - grid em fase futura)
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Aliquota FCP por Cfop :"
            .Top       = 423
            .Left      = 489
            .Width     = 115
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- GradAlo -> grd_4c_GradeAlo (Aliquota Local por Classificacao Fiscal - SigCdAlo)
        *-- Fonte: SigCdUfd_form_codigo_fonte.txt Top=209/Left=490/Width=445/Height=143/HeaderHeight=20
        *-- Compensacao PageFrame.Top=-29: Top_migrado = 209 + 29 = 238
        loc_oPagina.AddObject("grd_4c_GradeAlo", "Grid")
        loc_oPagina.grd_4c_GradeAlo.ColumnCount = 6
        WITH loc_oPagina.grd_4c_GradeAlo
            .Top                = 238
            .Left               = 490
            .Width              = 445
            .Height             = 143
            .HeaderHeight       = 20
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLineWidth      = 1
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH
        loc_oPagina.grd_4c_GradeAlo.Column1.Width = 103
        loc_oPagina.grd_4c_GradeAlo.Column1.Header1.Caption = "Classifica" + CHR(231) + CHR(227) + "o"
        loc_oPagina.grd_4c_GradeAlo.Column2.Width = 65
        loc_oPagina.grd_4c_GradeAlo.Column2.Header1.Caption = "Aliq Local"
        loc_oPagina.grd_4c_GradeAlo.Column3.Width = 65
        loc_oPagina.grd_4c_GradeAlo.Column3.Header1.Caption = "Aliq FCP"
        loc_oPagina.grd_4c_GradeAlo.Column4.Width = 67
        loc_oPagina.grd_4c_GradeAlo.Column4.Header1.Caption = "Aliq Icms"
        loc_oPagina.grd_4c_GradeAlo.Column5.Width = 33
        loc_oPagina.grd_4c_GradeAlo.Column5.Header1.Caption = "CST"
        loc_oPagina.grd_4c_GradeAlo.Column6.Width = 87
        loc_oPagina.grd_4c_GradeAlo.Column6.Header1.Caption = "C Benef"

        *-- GradAlocfop -> grd_4c_GradeAlocfop (Aliquota FCP por CFOP - SigCdAlc)
        *-- Fonte: SigCdUfd_form_codigo_fonte.txt Top=410/Left=490/Width=192/Height=143/HeaderHeight=20
        *-- Compensacao PageFrame.Top=-29: Top_migrado = 410 + 29 = 439
        loc_oPagina.AddObject("grd_4c_GradeAlocfop", "Grid")
        loc_oPagina.grd_4c_GradeAlocfop.ColumnCount = 2
        WITH loc_oPagina.grd_4c_GradeAlocfop
            .Top                = 439
            .Left               = 490
            .Width              = 192
            .Height             = 143
            .HeaderHeight       = 20
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLineWidth      = 1
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH
        loc_oPagina.grd_4c_GradeAlocfop.Column1.Width = 103
        loc_oPagina.grd_4c_GradeAlocfop.Column1.Header1.Caption = "CFOP"
        loc_oPagina.grd_4c_GradeAlocfop.Column2.Width = 65
        loc_oPagina.grd_4c_GradeAlocfop.Column2.Header1.Caption = "Aliq FCP"

        *-- Botoes de Grupo_Salva -> cnt_4c_BotoesAcao (container ja criado acima)
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

        *-- LOOKUPS - BINDEVENT KeyPress(F4)/DblClick/LostFocus (Fase 6 - COMPLETOS)
        *-- UF Origem (SigCdUfs) - Get_OCodigo/Get_ONome do legado
        BINDEVENT(loc_oPagina.txt_4c_OCodigo, "KeyPress", THIS, "OCodigoLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_OCodigo, "DblClick", THIS, "OCodigoLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_OCodigo, "KeyPress", THIS, "OCodigoLostFocus")

        BINDEVENT(loc_oPagina.txt_4c_ONome, "KeyPress", THIS, "ONomeLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_ONome, "DblClick", THIS, "ONomeLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_ONome, "KeyPress", THIS, "ONomeLostFocus")

        *-- UF Destino (SigCdUfs) - Get_DCodigo/Get_DNome do legado
        BINDEVENT(loc_oPagina.txt_4c_DCodigo, "KeyPress", THIS, "DCodigoLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DCodigo, "DblClick", THIS, "DCodigoLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_DCodigo, "KeyPress", THIS, "DCodigoLostFocus")

        BINDEVENT(loc_oPagina.txt_4c_DNome, "KeyPress", THIS, "DNomeLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DNome, "DblClick", THIS, "DNomeLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_DNome, "KeyPress", THIS, "DNomeLostFocus")

        *-- CFO (SigCdCfo) - getCFO do legado
        BINDEVENT(loc_oPagina.txt_4c_CFO, "KeyPress", THIS, "CfoLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CFO, "DblClick", THIS, "CfoLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_CFO, "KeyPress", THIS, "CfoLostFocus")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ExecutarBuscaUf - Executa lookup em SigCdUfs (compartilhado pelos 4 campos
    * de UF Origem/Destino). Preenche this_cUfLookupCodigo/this_cUfLookupDescricao.
    * Retorna .T. se um registro foi selecionado/encontrado, .F. caso contrario.
    *===========================================================================
    PROTECTED FUNCTION ExecutarBuscaUf(par_cCampoBusca, par_cValor)
        LOCAL loc_oBusca, loc_lResultado
        loc_lResultado = .F.
        THIS.this_cUfLookupCodigo    = ""
        THIS.this_cUfLookupDescricao = ""

        IF EMPTY(ALLTRIM(par_cValor))
            RETURN .F.
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUfs", "cursor_4c_BuscaUf", par_cCampoBusca, ALLTRIM(par_cValor), "Estado")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Estados", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
                    SELECT cursor_4c_BuscaUf
                    THIS.this_cUfLookupCodigo    = ALLTRIM(Estados)
                    THIS.this_cUfLookupDescricao = ALLTRIM(Descrs)
                    loc_lResultado = .T.
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar UF:" + CHR(13) + loException.Message, "FormUfd.ExecutarBuscaUf")
        ENDTRY

        IF USED("cursor_4c_BuscaUf")
            USE IN cursor_4c_BuscaUf
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Lookup UF Origem por Codigo (txt_4c_OCodigo) - so preenche a descricao
    * (transcrito do legado: Get_OCodigo.Valid nunca reatribui o proprio codigo)
    *===========================================================================
    PROCEDURE OCodigoLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupUfOrigemPorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE OCodigoLookupDblClick()
        THIS.AbrirLookupUfOrigemPorCodigo()
    ENDPROC

    PROCEDURE OCodigoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_OCodigo.Value)
        IF loc_cValor == THIS.this_cUltOCodigo
            RETURN
        ENDIF
        THIS.this_cUltOCodigo = loc_cValor
        IF !EMPTY(loc_cValor)
            THIS.AbrirLookupUfOrigemPorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupUfOrigemPorCodigo()
        LOCAL loc_oPg2, loc_cValor
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF THIS.ExecutarBuscaUf("estados", loc_cValor)
            loc_oPg2.txt_4c_ONome.Value = THIS.this_cUfLookupDescricao
        ELSE
            loc_oPg2.txt_4c_ONome.Value = ""
        ENDIF
        THIS.this_cUltOCodigo = ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value)
    ENDPROC

    *===========================================================================
    * Lookup UF Origem por Nome (txt_4c_ONome) - preenche codigo E descricao
    *===========================================================================
    PROCEDURE ONomeLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupUfOrigemPorNome()
        ENDIF
    ENDPROC

    PROCEDURE ONomeLookupDblClick()
        THIS.AbrirLookupUfOrigemPorNome()
    ENDPROC

    PROCEDURE ONomeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_ONome.Value)
        IF loc_cValor == THIS.this_cUltONome
            RETURN
        ENDIF
        THIS.this_cUltONome = loc_cValor
        IF !EMPTY(loc_cValor)
            THIS.AbrirLookupUfOrigemPorNome()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupUfOrigemPorNome()
        LOCAL loc_oPg2, loc_cValor
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_ONome.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF THIS.ExecutarBuscaUf("descrs", loc_cValor)
            loc_oPg2.txt_4c_OCodigo.Value = THIS.this_cUfLookupCodigo
            loc_oPg2.txt_4c_ONome.Value   = THIS.this_cUfLookupDescricao
        ELSE
            loc_oPg2.txt_4c_OCodigo.Value = ""
            loc_oPg2.txt_4c_ONome.Value   = ""
        ENDIF
        THIS.this_cUltONome   = ALLTRIM(loc_oPg2.txt_4c_ONome.Value)
        THIS.this_cUltOCodigo = ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value)
    ENDPROC

    *===========================================================================
    * Lookup UF Destino por Codigo (txt_4c_DCodigo) - preenche codigo E descricao
    * (transcrito do legado: Get_DCodigo.Valid reatribui ambos os campos)
    *===========================================================================
    PROCEDURE DCodigoLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupUfDestinoPorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE DCodigoLookupDblClick()
        THIS.AbrirLookupUfDestinoPorCodigo()
    ENDPROC

    PROCEDURE DCodigoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DCodigo.Value)
        IF loc_cValor == THIS.this_cUltDCodigo
            RETURN
        ENDIF
        THIS.this_cUltDCodigo = loc_cValor
        IF !EMPTY(loc_cValor)
            THIS.AbrirLookupUfDestinoPorCodigo()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupUfDestinoPorCodigo()
        LOCAL loc_oPg2, loc_cValor
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF THIS.ExecutarBuscaUf("estados", loc_cValor)
            loc_oPg2.txt_4c_DCodigo.Value = THIS.this_cUfLookupCodigo
            loc_oPg2.txt_4c_DNome.Value   = THIS.this_cUfLookupDescricao
        ELSE
            loc_oPg2.txt_4c_DCodigo.Value = ""
            loc_oPg2.txt_4c_DNome.Value   = ""
        ENDIF
        THIS.this_cUltDCodigo = ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value)
        THIS.this_cUltDNome   = ALLTRIM(loc_oPg2.txt_4c_DNome.Value)
    ENDPROC

    *===========================================================================
    * Lookup UF Destino por Nome (txt_4c_DNome) - preenche codigo E descricao
    *===========================================================================
    PROCEDURE DNomeLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupUfDestinoPorNome()
        ENDIF
    ENDPROC

    PROCEDURE DNomeLookupDblClick()
        THIS.AbrirLookupUfDestinoPorNome()
    ENDPROC

    PROCEDURE DNomeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DNome.Value)
        IF loc_cValor == THIS.this_cUltDNome
            RETURN
        ENDIF
        THIS.this_cUltDNome = loc_cValor
        IF !EMPTY(loc_cValor)
            THIS.AbrirLookupUfDestinoPorNome()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupUfDestinoPorNome()
        LOCAL loc_oPg2, loc_cValor
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_DNome.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF THIS.ExecutarBuscaUf("descrs", loc_cValor)
            loc_oPg2.txt_4c_DCodigo.Value = THIS.this_cUfLookupCodigo
            loc_oPg2.txt_4c_DNome.Value   = THIS.this_cUfLookupDescricao
        ELSE
            loc_oPg2.txt_4c_DCodigo.Value = ""
            loc_oPg2.txt_4c_DNome.Value   = ""
        ENDIF
        THIS.this_cUltDCodigo = ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value)
        THIS.this_cUltDNome   = ALLTRIM(loc_oPg2.txt_4c_DNome.Value)
    ENDPROC

    *===========================================================================
    * Lookup CFO (txt_4c_CFO) - SigCdCfo.Codigos/Descricaos
    * Transcrito do legado: getCFO.Valid remove pontos antes de comparar/buscar
    *===========================================================================
    PROCEDURE CfoLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupCfo()
        ENDIF
    ENDPROC

    PROCEDURE CfoLookupDblClick()
        THIS.AbrirLookupCfo()
    ENDPROC

    PROCEDURE CfoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(STRTRAN(THIS.pgf_4c_Paginas.Page2.txt_4c_CFO.Value, ".", ""))
        IF loc_cValor == THIS.this_cUltCfop
            RETURN
        ENDIF
        THIS.this_cUltCfop = loc_cValor
        IF !EMPTY(loc_cValor)
            THIS.AbrirLookupCfo()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupCfo()
        LOCAL loc_oPg2, loc_cValor, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(STRTRAN(loc_oPg2.txt_4c_CFO.Value, ".", ""))

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfo", "Codigos", loc_cValor, "CFO")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
                    SELECT cursor_4c_BuscaCfo
                    loc_oPg2.txt_4c_CFO.Value = ALLTRIM(Codigos)
                ELSE
                    loc_oPg2.txt_4c_CFO.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar CFO:" + CHR(13) + loException.Message, "FormUfd.AbrirLookupCfo")
        ENDTRY

        IF USED("cursor_4c_BuscaCfo")
            USE IN cursor_4c_BuscaCfo
        ENDIF

        THIS.this_cUltCfop = ALLTRIM(STRTRAN(loc_oPg2.txt_4c_CFO.Value, ".", ""))
    ENDPROC

    *===========================================================================
    * FASE 7/8: FORM - EVENTOS PRINCIPAIS
    * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
    * + helpers de suporte (BOParaForm/HabilitarCampos/LimparCampos/AjustarBotoesPorModo)
    * PUBLIC (sem PROTECTED) - exigido para funcionar com BINDEVENT (regra #3/Problema 17)
    *===========================================================================

    *===========================================================================
    * BOParaForm - Transfere propriedades do BusinessObject para os campos da Page2
    * Descricoes de UF (ONome/DNome) sao repopuladas via ExecutarBuscaUf (nao sao
    * persistidas no BO - mesmo padrao do legado, que so guarda o codigo)
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBo
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBo  = THIS.this_oBusinessObject

        loc_oPg2.txt_4c_OCodigo.Value       = loc_oBo.this_cUfOrigem
        loc_oPg2.txt_4c_DCodigo.Value       = loc_oBo.this_cUfDestino
        loc_oPg2.txt_4c_Aicms.Value         = loc_oBo.this_nAliqIcms
        loc_oPg2.txt_4c_Aliqpimps.Value     = loc_oBo.this_nAliqIcmsPImp
        loc_oPg2.txt_4c_AliqFcp.Value       = loc_oBo.this_nAliqFcp
        loc_oPg2.txt_4c_Aliqredb.Value      = loc_oBo.this_nAliqRedBase
        loc_oPg2.txt_4c_AliqSB.Value        = loc_oBo.this_nAliqSubTrib
        loc_oPg2.txt_4c_AliqInter.Value     = loc_oBo.this_nAliqInterestadual
        loc_oPg2.txt_4c_CFO.Value           = loc_oBo.this_cCfop
        loc_oPg2.txt_4c_Iest.Value          = loc_oBo.this_cIeSubstituto
        loc_oPg2.obj_4c_OPT_ALTTRANS.Value  = IIF(loc_oBo.this_nBaseReduzida = 2, 2, 1)

        IF !EMPTY(ALLTRIM(loc_oBo.this_cUfOrigem)) AND THIS.ExecutarBuscaUf("estados", ALLTRIM(loc_oBo.this_cUfOrigem))
            loc_oPg2.txt_4c_ONome.Value = THIS.this_cUfLookupDescricao
        ELSE
            loc_oPg2.txt_4c_ONome.Value = ""
        ENDIF

        IF !EMPTY(ALLTRIM(loc_oBo.this_cUfDestino)) AND THIS.ExecutarBuscaUf("estados", ALLTRIM(loc_oBo.this_cUfDestino))
            loc_oPg2.txt_4c_DNome.Value = THIS.this_cUfLookupDescricao
        ELSE
            loc_oPg2.txt_4c_DNome.Value = ""
        ENDIF

        *-- Reseta guardas de "valor alterado" dos lookups (Problema 45)
        THIS.this_cUltOCodigo = ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value)
        THIS.this_cUltONome   = ALLTRIM(loc_oPg2.txt_4c_ONome.Value)
        THIS.this_cUltDCodigo = ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value)
        THIS.this_cUltDNome   = ALLTRIM(loc_oPg2.txt_4c_DNome.Value)
        THIS.this_cUltCfop    = ALLTRIM(STRTRAN(loc_oPg2.txt_4c_CFO.Value, ".", ""))
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere os campos da Page2 para o BusinessObject
    * Chamado por BtnSalvarClick() antes de THIS.this_oBusinessObject.Salvar()
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBo
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBo  = THIS.this_oBusinessObject

        loc_oBo.this_cUfOrigem          = ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value)
        loc_oBo.this_cUfDestino         = ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value)
        loc_oBo.this_nAliqIcms          = loc_oPg2.txt_4c_Aicms.Value
        loc_oBo.this_nAliqIcmsPImp      = loc_oPg2.txt_4c_Aliqpimps.Value
        loc_oBo.this_nAliqFcp           = loc_oPg2.txt_4c_AliqFcp.Value
        loc_oBo.this_nAliqRedBase       = loc_oPg2.txt_4c_Aliqredb.Value
        loc_oBo.this_nAliqSubTrib       = loc_oPg2.txt_4c_AliqSB.Value
        loc_oBo.this_nAliqInterestadual = loc_oPg2.txt_4c_AliqInter.Value
        loc_oBo.this_cCfop              = ALLTRIM(loc_oPg2.txt_4c_CFO.Value)
        loc_oBo.this_cIeSubstituto      = ALLTRIM(loc_oPg2.txt_4c_Iest.Value)
        loc_oBo.this_nBaseReduzida      = loc_oPg2.obj_4c_OPT_ALTTRANS.Value
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2 (usado em BtnIncluirClick)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_OCodigo.Value       = ""
        loc_oPg2.txt_4c_ONome.Value         = ""
        loc_oPg2.txt_4c_DCodigo.Value       = ""
        loc_oPg2.txt_4c_DNome.Value         = ""
        loc_oPg2.txt_4c_Aicms.Value         = 0
        loc_oPg2.txt_4c_Aliqpimps.Value     = 0
        loc_oPg2.txt_4c_AliqFcp.Value       = 0
        loc_oPg2.txt_4c_Aliqredb.Value      = 0
        loc_oPg2.txt_4c_AliqSB.Value         = 0
        loc_oPg2.txt_4c_AliqInter.Value     = 0
        loc_oPg2.txt_4c_CFO.Value           = ""
        loc_oPg2.txt_4c_Iest.Value          = ""
        loc_oPg2.obj_4c_OPT_ALTTRANS.Value  = 1

        THIS.this_cUltOCodigo = ""
        THIS.this_cUltONome   = ""
        THIS.this_cUltDCodigo = ""
        THIS.this_cUltDNome   = ""
        THIS.this_cUltCfop    = ""
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita todos os campos editaveis da Page2
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_OCodigo.Enabled      = par_lHabilitar
        loc_oPg2.txt_4c_ONome.Enabled        = par_lHabilitar
        loc_oPg2.txt_4c_DCodigo.Enabled      = par_lHabilitar
        loc_oPg2.txt_4c_DNome.Enabled        = par_lHabilitar
        loc_oPg2.txt_4c_Aicms.Enabled        = par_lHabilitar
        loc_oPg2.txt_4c_Aliqpimps.Enabled    = par_lHabilitar
        loc_oPg2.txt_4c_AliqFcp.Enabled      = par_lHabilitar
        loc_oPg2.txt_4c_Aliqredb.Enabled     = par_lHabilitar
        loc_oPg2.txt_4c_AliqSB.Enabled       = par_lHabilitar
        loc_oPg2.txt_4c_AliqInter.Enabled    = par_lHabilitar
        loc_oPg2.txt_4c_CFO.Enabled          = par_lHabilitar
        loc_oPg2.txt_4c_Iest.Enabled         = par_lHabilitar
        loc_oPg2.obj_4c_OPT_ALTTRANS.Enabled = par_lHabilitar
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Confirmar desabilitado em VISUALIZAR, Cancelar sempre habilitado
    * (padrao frmcadastro - CLAUDE.md / migration_guide.md)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        DO CASE
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
            OTHERWISE
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
        ENDCASE

        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara BO+Form para inclusao de novo registro
    * NovoRegistro() e this_cModoAtual="INCLUIR" ANTES de HabilitarCampos (Problema 18/19)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_OCodigo.SetFocus()

        CATCH TO loException
            MostrarErro("Erro ao incluir registro:" + CHR(13) + loException.Message, ;
                "FormUfd.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado na grade e habilita edicao
    * EditarRegistro() APOS CarregarPorCodigo (Problema 18); modo ANTES de HabilitarCampos (Problema 19)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para alterar!")
            ELSE
                SELECT cursor_4c_Dados
                loc_cChave = ALLTRIM(cidchaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_OCodigo.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao alterar registro:" + CHR(13) + loException.Message, ;
                "FormUfd.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo somente-leitura
    * Tambem vinculado ao DblClick do grid (ConfigurarPaginaLista)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para visualizar!")
            ELSE
                SELECT cursor_4c_Dados
                loc_cChave = ALLTRIM(cidchaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao visualizar registro:" + CHR(13) + loException.Message, ;
                "FormUfd.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado na grade (com confirmacao)
    * MsgConfirma() retorna LOGICAL (regra #7); falha de Excluir() ja eh reportada
    * pelo BusinessBase.ExibirFalha (regra #20) - so avisa se this_lErroExibido = .F.
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_cUfO, loc_cUfD
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para excluir!")
            ELSE
                SELECT cursor_4c_Dados
                loc_cChave = ALLTRIM(cidchaves)
                loc_cUfO   = ALLTRIM(codigos)
                loc_cUfD   = ALLTRIM(destinos)

                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do ICMS Interestadual " + ;
                        loc_cUfO + " -> " + loc_cUfD + "?", "Confirmar Exclus" + CHR(227) + "o")

                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
                            THIS.CarregarLista()
                        ELSE
                            IF !THIS.this_oBusinessObject.this_lErroExibido
                                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Erro")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir registro:" + CHR(13) + loException.Message, ;
                "FormUfd.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Filtra a lista por UF de Origem via FormBuscaAuxiliar
    * (SigCdUfd nao tem cntFiltros no legado; segue o padrao dos demais
    * cadastros: Buscar abre lookup em tabela relacionada e filtra o grid)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUfs", "cursor_4c_BuscaUfLista", "estados", "", "Buscar U.F. Origem")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Estados", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUfLista")
                    SELECT cursor_4c_BuscaUfLista
                    loc_cCodigo = ALLTRIM(Estados)
                    THIS.CarregarLista("codigos = " + EscaparSQL(loc_cCodigo))
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FormUfd.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaUfLista")
            USE IN cursor_4c_BuscaUfLista
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e grava o registro (Confirmar)
    * Validacoes FORA do TRY (transcrito do legado SIGCDUFD.Click: "U.F. Origem
    * Invalido"/"U.F. Destino Invalido"). Salvar() sem parametro (regra CLAUDE.md);
    * falha ja e reportada pelo BusinessBase (regra #20) - so avisa se nao exibido.
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value))
            MsgAviso("U.F. Origem Inv" + CHR(225) + "lido.")
            loc_oPg2.txt_4c_OCodigo.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value))
            MsgAviso("U.F. Destino Inv" + CHR(225) + "lido.")
            loc_oPg2.txt_4c_DCodigo.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista (recarregada)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
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
    * Destroy - Libera recursos do formulario
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
