*==============================================================================
* FormCst.prg - Formulario de Cadastro de Constantes
* Migrado de: SigCdCst.SCX (frmcadastro)
* Tabela: SigCdCnt | Cursor grid: crSigCdCnt
*==============================================================================

DEFINE CLASS FormCst AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: valores EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Constantes"
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
            THIS.this_oBusinessObject = CREATEOBJECT("CstBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar CstBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormCst.InicializarForm")
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
            MostrarErro("Erro ao inicializar FormCst:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormCst.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1: Cabecalho, Botoes CRUD e Grid
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Container Cabecalho (cntSombra do legado)
            *-- Top=31: compensa PageFrame.Top=-29
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = -1
                .Width       = THIS.Width + 8
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
                    .AutoSize  = .F.
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
                    .AutoSize  = .F.
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- Container Botoes CRUD (Grupo_op do legado)
            *-- Left=543 (do original), Top=29 (0+29 compensacao)
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top       = 29
                .Left      =  542
                .Width     = 385
                .Height    = 85
                .BackStyle = 1
                .BackColor = RGB(53, 53, 53)
                .BorderWidth = 0
                .Visible   = .T.

                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Caption         = "Incluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left = 5
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH

                .AddObject("cmd_4c_Visualizar", "CommandButton")
                WITH .cmd_4c_Visualizar
                    .Caption         = "Visualizar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left = 80
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
                ENDWITH

                .AddObject("cmd_4c_Alterar", "CommandButton")
                WITH .cmd_4c_Alterar
                    .Caption         = "Alterar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left = 155
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
                ENDWITH

                .AddObject("cmd_4c_Excluir", "CommandButton")
                WITH .cmd_4c_Excluir
                    .Caption         = "Excluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left = 230
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
                ENDWITH

                .AddObject("cmd_4c_Buscar", "CommandButton")
                WITH .cmd_4c_Buscar
                    .Caption         = "Buscar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left = 305
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
                ENDWITH
            ENDWITH

            *-- Container Saida (padrao canonico: Left=917, Width=90)
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
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left = 5
                    .Width           = 90
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH
            ENDWITH

            *-- Grid de Lista (Grade do legado)
            *-- Top=150: original top=121 + compensacao PageFrame (+29)
            *-- ColumnCount setado FORA do WITH (regra critica #36)
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oPagina.grd_4c_Lista.ColumnCount = 4

            WITH loc_oPagina.grd_4c_Lista
                .Top                = 150
                .Left               = 12
                .Width              = 890
                .Height             = 460
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

            *-- BINDEVENT para botoes CRUD (metodos PUBLIC obrigatorios)
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar Page1:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormCst.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2: Botoes de Acao + campos Parte 1
    * FASE 5/8: cnt_4c_BotoesAcao (Salvar+Cancelar), Label1+txt_4c_Codigo,
    *           Label2+txt_4c_Descricao, Label3+txt_4c_Constante
    * Top += 29 em todos os controles (compensacao PageFrame.Top=-29)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Container Botoes de Acao (Grupo_Salva do legado)
            *-- Original: Left=820, Top=8 -> Migrado: Top=37 (8+29)
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 37
                .Left        = 820
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Salvar", "CommandButton")
                WITH .cmd_4c_Salvar
                    .Caption         = "Salvar"
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
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH

                .AddObject("cmd_4c_Cancelar", "CommandButton")
                WITH .cmd_4c_Cancelar
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
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            *-- Label1 + txt_4c_Codigo (Get_Codigo do legado)
            *-- Original: Label1.Top=126, Get_Codigo.Top=122 -> Migrado: +29
            loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
            WITH loc_oPagina.lbl_4c_Codigo
                .Caption   = "C" + CHR(243) + "digo : "
                .Top       = 155
                .Left      = 281
                .Width     = 45
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPagina.txt_4c_Codigo
                .Value         = ""
                .Top           = 151
                .Left          = 330
                .Width         = 34
                .Height        = 23
                .InputMask     = "!!!"
                .MaxLength     = 3
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .TabIndex      = 2
                .Visible       = .T.
            ENDWITH

            *-- Label2 + txt_4c_Descricao (Get_Descricao do legado)
            *-- Original: Label2.Top=152, Get_Descricao.Top=148 -> Migrado: +29
            loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
            WITH loc_oPagina.lbl_4c_Descricao
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
                .Top       = 181
                .Left      = 268
                .Width     = 58
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
            WITH loc_oPagina.txt_4c_Descricao
                .Value         = ""
                .Top           = 177
                .Left          = 330
                .Width         = 290
                .Height        = 23
                .MaxLength     = 40
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .TabIndex      = 4
                .Visible       = .T.
            ENDWITH

            *-- Label3 + txt_4c_Constante (Get_Constante do legado)
            *-- Original: Label3.Top=178, Get_Constante.Top=174 -> Migrado: +29
            loc_oPagina.AddObject("lbl_4c_Constante", "Label")
            WITH loc_oPagina.lbl_4c_Constante
                .Caption   = "Valor da Constante : "
                .Top       = 207
                .Left      = 222
                .Width     = 104
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Constante", "TextBox")
            WITH loc_oPagina.txt_4c_Constante
                .Value         = 0
                .Top           = 203
                .Left          = 330
                .Width         = 150
                .Height        = 23
                .InputMask     = "9,999,999.999999"
                .Alignment     = 3
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .TabIndex      = 6
                .Visible       = .T.
            ENDWITH

            *-- Label4 + txt_4c_CodMoeda (get_cd_moeda) + txt_4c_DescMoeda (get_ds_moeda)
            *-- Original: Label4.Top=204, get_cd_moeda.Top=200, get_ds_moeda.Top=200 -> Migrado: +29
            loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
            WITH loc_oPagina.lbl_4c_Moeda
                .Caption   = "Moeda : "
                .Top       = 233
                .Left      = 282
                .Width     = 44
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_CodMoeda", "TextBox")
            WITH loc_oPagina.txt_4c_CodMoeda
                .Value         = ""
                .Top           = 229
                .Left          = 330
                .Width         = 32
                .Height        = 23
                .InputMask     = "!!!"
                .MaxLength     = 3
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .TabIndex      = 8
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_DescMoeda", "TextBox")
            WITH loc_oPagina.txt_4c_DescMoeda
                .Value         = ""
                .Top           = 229
                .Left          = 365
                .Width         = 115
                .Height        = 23
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .TabIndex      = 9
                .Visible       = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_CodMoeda,  "KeyPress", THIS, "CodMoedaLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_DescMoeda, "KeyPress", THIS, "DescMoedaLostFocus")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar Page2:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormCst.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    * REGRA: RecordSource setado APOS Buscar(); Headers redefinidos apos RecordSource
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oErro, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Lista")
                    CREATE CURSOR cursor_4c_Lista (codigos C(3), descricaos C(40), consts N(13,6), moedas C(3))
                ENDIF
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    *-- RecordSource FORA do WITH (regra critica #36/#48)
                    loc_oGrid.RecordSource = "crSigCdCnt"

                    *-- ControlSource e Headers APOS RecordSource (regra #32)
                    WITH loc_oGrid
                        .Column1.ControlSource   = "crSigCdCnt.codigos"
                        .Column1.Width           = 60
                        .Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        .Column1.Alignment       = 0

                        .Column2.ControlSource   = "crSigCdCnt.descricaos"
                        .Column2.Width           = 267
                        .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        .Column2.Alignment       = 0

                        .Column3.ControlSource   = "crSigCdCnt.consts"
                        .Column3.Width           = 177
                        .Column3.Header1.Caption = "Valor"
                        .Column3.Alignment       = 1

                        .Column4.ControlSource   = "crSigCdCnt.moedas"
                        .Column4.Width           = 42
                        .Column4.Header1.Caption = "Moeda"
                        .Column4.Alignment       = 0
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormCst.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Se voltar para Page1, recarrega a lista automaticamente
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN loc_lResultado
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("crSigCdCnt")
                USE IN crSigCdCnt
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao destruir FormCst:" + CHR(13) + ;
                loc_oErro.Message, ;
                "FormCst.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Deve iterar Pages E Controls para PageFrames
    * SEMPRE chamar COM parametro: THIS.TornarControlesVisiveis(loc_oPagina)
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
    * FormatarGridLista - Formata visual do grid da lista
    * SEMPRE chamar APOS carregar dados: THIS.FormatarGridLista(loc_oGrid)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos do Form para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_nConstante = loc_oPagina.txt_4c_Constante.Value
        THIS.this_oBusinessObject.this_cMoeda     = ALLTRIM(loc_oPagina.txt_4c_CodMoeda.Value)
        THIS.this_oBusinessObject.this_cDescMoeda = ALLTRIM(loc_oPagina.txt_4c_DescMoeda.Value)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BO para os campos do Form
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        loc_oPagina.txt_4c_Constante.Value = THIS.this_oBusinessObject.this_nConstante
        loc_oPagina.txt_4c_CodMoeda.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cMoeda)
        loc_oPagina.txt_4c_DescMoeda.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescMoeda)
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ""
        loc_oPagina.txt_4c_Descricao.Value = ""
        loc_oPagina.txt_4c_Constante.Value = 0
        loc_oPagina.txt_4c_CodMoeda.Value  = ""
        loc_oPagina.txt_4c_DescMoeda.Value = ""
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo atual
    * Codigo: habilitado SOMENTE no INCLUIR (PK nao editavel em UPDATE)
    * DescMoeda: habilitada apenas quando CodMoeda esta vazio (busca por descricao)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lCodEnabled
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_lCodEnabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

        loc_oPagina.txt_4c_Codigo.Enabled    = loc_lCodEnabled
        loc_oPagina.txt_4c_Descricao.Enabled = par_lHabilitar
        loc_oPagina.txt_4c_Constante.Enabled = par_lHabilitar
        loc_oPagina.txt_4c_CodMoeda.Enabled  = par_lHabilitar
        loc_oPagina.txt_4c_DescMoeda.Enabled = par_lHabilitar AND ;
            EMPTY(ALLTRIM(loc_oPagina.txt_4c_CodMoeda.Value))
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        DO CASE
        CASE THIS.this_cModoAtual = "VISUALIZAR"
            loc_oCnt.cmd_4c_Salvar.Enabled   = .F.
            loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
        OTHERWISE
            loc_oCnt.cmd_4c_Salvar.Enabled   = .T.
            loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
        ENDCASE
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara formulario para inclusao de nova constante
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre registro selecionado em modo somente-leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        IF !USED("crSigCdCnt") OR EOF("crSigCdCnt")
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        SELECT crSigCdCnt
        loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre registro selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        IF !USED("crSigCdCnt") OR EOF("crSigCdCnt")
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        SELECT crSigCdCnt
        loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o registro selecionado apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma, loc_lExcluido

        IF !USED("crSigCdCnt") OR EOF("crSigCdCnt")
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        SELECT crSigCdCnt
        loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Deseja excluir a constante [" + loc_cCodigo + ;
            "] - " + ALLTRIM(THIS.this_oBusinessObject.this_cDescricao) + "?", ;
            "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirma
            loc_lExcluido = THIS.this_oBusinessObject.Excluir()
            IF loc_lExcluido
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Filtra lista de constantes por codigo ou descricao
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca, loc_cFiltro, loc_oGrid, loc_lResultado

        loc_cBusca = ALLTRIM(INPUTBOX("Pesquisar por c" + CHR(243) + ;
            "digo ou descri" + CHR(231) + CHR(227) + "o:", ;
            "Buscar Constantes", ""))

        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

        IF EMPTY(loc_cBusca)
            loc_lResultado = THIS.this_oBusinessObject.Buscar("")
        ELSE
            loc_cFiltro = "a.codigos LIKE " + EscaparSQL("%" + loc_cBusca + "%")
            loc_lResultado = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
        ENDIF

        IF loc_lResultado
            loc_oGrid.RecordSource = "crSigCdCnt"
            WITH loc_oGrid
                .Column1.ControlSource   = "crSigCdCnt.codigos"
                .Column1.Width           = 60
                .Column1.Header1.Caption = "C" + CHR(243) + "digo"
                .Column2.ControlSource   = "crSigCdCnt.descricaos"
                .Column2.Width           = 267
                .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                .Column3.ControlSource   = "crSigCdCnt.consts"
                .Column3.Width           = 177
                .Column3.Header1.Caption = "Valor"
                .Column4.ControlSource   = "crSigCdCnt.moedas"
                .Column4.Width           = 42
                .Column4.Header1.Caption = "Moeda"
            ENDWITH
            THIS.FormatarGridLista(loc_oGrid)
            loc_oGrid.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva os dados (Inserir ou Atualizar)
    * Validacoes obrigatorias FORA do TRY (regra critica #16)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSalvo

        IF THIS.this_cModoAtual = "INCLUIR" AND ;
                EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value))
            MsgAviso("C" + CHR(243) + "digo " + CHR(233) + " obrigat" + CHR(243) + "rio!")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CodMoeda.Value))
            MsgAviso("Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria!")
            THIS.pgf_4c_Paginas.Page2.txt_4c_CodMoeda.SetFocus
            RETURN
        ENDIF

        THIS.FormParaBO()

        loc_lSalvo = THIS.this_oBusinessObject.Salvar()

        IF loc_lSalvo
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para a lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * CodMoedaLostFocus - Handler LostFocus de txt_4c_CodMoeda
    * Busca descricao da moeda pelo codigo digitado
    *===========================================================================
    PROCEDURE CodMoedaLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cCodigo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CodMoeda.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_DescMoeda.Value   = ""
            loc_oPagina.txt_4c_DescMoeda.Enabled = .T.
            RETURN
        ENDIF

        THIS.AbrirLookupMoedaCodigo(loc_cCodigo)
    ENDPROC

    *===========================================================================
    * DescMoedaLostFocus - Handler LostFocus de txt_4c_DescMoeda
    * Busca moeda pela descricao digitada
    *===========================================================================
    PROCEDURE DescMoedaLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cDescricao
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_DescMoeda.Value)

        IF EMPTY(loc_cDescricao)
            RETURN
        ENDIF

        THIS.AbrirLookupMoedaDescricao(loc_cDescricao)
    ENDPROC

    *===========================================================================
    * AbrirLookupMoedaCodigo - Picker de Moeda por codigo (cmoes)
    * Tabela: SigCdMoe | Pesquisa: cmoes | Preenche: CodMoeda + DescMoeda
    *===========================================================================
    PROCEDURE AbrirLookupMoedaCodigo(par_cValor)
        LOCAL loc_oBusca, loc_oPagina, loc_lResultado, loc_oErro
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_lResultado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", ;
                "cursor_4c_BuscaMoe", ;
                "cmoes", ;
                par_cValor, ;
                "Buscar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "Moeda")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    loc_oPagina.txt_4c_CodMoeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                    loc_oPagina.txt_4c_DescMoeda.Value   = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
                    loc_oPagina.txt_4c_DescMoeda.Enabled = .F.
                    loc_lResultado = .T.
                ELSE
                    loc_oPagina.txt_4c_CodMoeda.Value    = ""
                    loc_oPagina.txt_4c_DescMoeda.Value   = ""
                    loc_oPagina.txt_4c_DescMoeda.Enabled = .T.
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar moeda:" + CHR(13) + ;
                loc_oErro.Message, "FormCst.AbrirLookupMoedaCodigo")
        ENDTRY

        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AbrirLookupMoedaDescricao - Picker de Moeda por descricao (dmoes)
    * Tabela: SigCdMoe | Pesquisa: dmoes | Preenche: CodMoeda + DescMoeda
    *===========================================================================
    PROCEDURE AbrirLookupMoedaDescricao(par_cValor)
        LOCAL loc_oBusca, loc_oPagina, loc_lResultado, loc_oErro
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_lResultado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", ;
                "cursor_4c_BuscaMoeDesc", ;
                "dmoes", ;
                par_cValor, ;
                "Buscar Moeda por Descri" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cmoes", "", "Moeda")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeDesc")
                    SELECT cursor_4c_BuscaMoeDesc
                    loc_oPagina.txt_4c_CodMoeda.Value    = ALLTRIM(cursor_4c_BuscaMoeDesc.cmoes)
                    loc_oPagina.txt_4c_DescMoeda.Value   = ALLTRIM(cursor_4c_BuscaMoeDesc.dmoes)
                    loc_oPagina.txt_4c_DescMoeda.Enabled = .F.
                    loc_lResultado = .T.
                ELSE
                    loc_oPagina.txt_4c_CodMoeda.Value  = ""
                    loc_oPagina.txt_4c_DescMoeda.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message, "FormCst.AbrirLookupMoedaDescricao")
        ENDTRY

        IF USED("cursor_4c_BuscaMoeDesc")
            USE IN cursor_4c_BuscaMoeDesc
        ENDIF

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
