*==============================================================================
* FORMSIGREIR1.PRG
* Relat" + CHR(243) + "rio de Balan" + CHR(231) + "o (Invent" + CHR(225) + "rio)
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREIR1.SCX (frmrelatorio)
* Tarefa: task131
*
* Filtros:
*   - Tipo de Relat" + CHR(243) + "rio (5 op" + CHR(231) + CHR(245) + "es):
*       1=Resumo p/Produto, 2=Resumo Geral, 3=Anal" + CHR(237) + "tico,
*       4=Etiqueta, 5=Estoque x Leitura
*   - Tipo Anal" + CHR(237) + "tico (Produto / Local) - ativo apenas quando tipo=3
*   - Produto (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdPro) - modo Produto
*   - Local   (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigPrLcl) - modo Local
*   - Tipo Diferen" + CHR(231) + "a (Todos / Com Diferen" + CHR(231) + "a) - ativo apenas tipo=1
*   - Tipo Leitura (Leitura / Releitura) - ativo apenas tipo=3
*   - Ordem (Produto / Grupo) - ativo apenas tipo=1
*   - Pre" + CHR(231) + "o Custo / Pre" + CHR(231) + "o Venda (Sim/N" + CHR(227) + "o)
*   - Descri" + CHR(231) + CHR(227) + "o do Produto / C" + CHR(243) + "digo de Barras / Localiza" + CHR(231) + CHR(227) + "o
*   - Imprimir Imagem - ativo apenas tipo=4 ou 5
*==============================================================================

DEFINE CLASS FormSigReIr1 AS FormBase

    Height      = 600
    Width       = 1000
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""
    this_nNumBalanco   = 0

    *--------------------------------------------------------------------------
    * Init - Aceita NumBalanco e delega para FormBase.Init() -> InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nNumBalanco)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF PCOUNT() >= 1 AND VARTYPE(par_nNumBalanco) = "N"
            THIS.this_nNumBalanco = par_nNumBalanco
        ENDIF
        loc_lSucesso = DODEFAULT()
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.Caption = "Invent" + CHR(225) + "rio n" + CHR(186) + " " + TRANSFORM(THIS.this_nNumBalanco)

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SigReIr1BO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReIr1BO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
            ELSE
                THIS.this_oRelatorio.this_nNumBalanco = THIS.this_nNumBalanco

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.this_oRelatorio.InicializarDados()
                THIS.AplicarRegraGesInd()
                THIS.AtualizarEstadoControles()
                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = THIS.Caption
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = THIS.Caption
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es do relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 727
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Visualizar Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Imprimir Relat" + CHR(243) + "rio"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .WordWrap        = .T.
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina (Filtros)
    *   Form REPORT usa layout FLAT: sem page de lista + page de dados CRUD.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas
        loc_oPgf.PageCount = 1
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona controles de filtro na Page1
    *   Posi" + CHR(231) + CHR(245) + "es originais SIGREIR1 (800x347) adaptadas:
    *   Top na Page = Top original (coordenadas do SCX original)
    *   Esquerda mantida (form 800->1000 adiciona margem direita)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Relat" + CHR(243) + "rio :"
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Top       = 88
            .Left      = 89
            .Width     = 58
            .Height    = 15
            .Caption   = "Relat" + CHR(243) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoRelatorio (5 op" + CHR(231) + CHR(245) + "es)
        *   Original: top=84, left=140, width=245, height=62
        loc_oPg.AddObject("obj_4c_TipoRelatorio", "OptionGroup")
        loc_oPg.obj_4c_TipoRelatorio.ButtonCount = 5
        WITH loc_oPg.obj_4c_TipoRelatorio
            .Top           = 84
            .Left          = 140
            .Width         = 280
            .Height        = 62
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(1)
            .Caption   = "Resumo p/ Produto"
            .Left      = 5
            .Top       = 5
            .Width     = 115
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(2)
            .Caption   = "Resumo Geral"
            .Left      = 156
            .Top       = 5
            .Width     = 100
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(3)
            .Caption   = "Anal" + CHR(237) + "tico"
            .WordWrap        = .T.
            .Left      = 5
            .Top       = 24
            .Width     = 65
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(4)
            .Caption   = "Etiqueta"
            .WordWrap        = .T.
            .Left      = 156
            .Top       = 24
            .Width     = 65
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(5)
            .Caption   = "Estoque x Leitura"
            .Left      = 5
            .Top       = 43
            .Width     = 110
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Linha separadora (Shape3: top=150)
        loc_oPg.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPg.shp_4c_Shape3
            .Top       = 150
            .Left      = 13
            .Height    = 2
            .Width     = 620
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Tipo :" (para TipoAnalitico) (top=162)
        loc_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg.lbl_4c_Label4
            .Top       = 162
            .Left      = 112
            .Width     = 35
            .Height    = 15
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoAnalitico (2 op" + CHR(231) + CHR(245) + "es: Produto, Local)
        *   Original: top=157, left=141, width=133, height=25
        loc_oPg.AddObject("obj_4c_TipoAnalitico", "OptionGroup")
        loc_oPg.obj_4c_TipoAnalitico.ButtonCount = 2
        WITH loc_oPg.obj_4c_TipoAnalitico
            .Top           = 157
            .Left          = 141
            .Width         = 146
            .Height        = 25
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_TipoAnalitico.Buttons(1)
            .Caption   = "Produto"
            .Left      = 5
            .Top       = 5
            .Width     = 62
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoAnalitico.Buttons(2)
            .Caption   = "Local"
            .Left      = 86
            .Top       = 5
            .Width     = 50
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- CheckBox "Imprimir Imagem" (top=160, left=295)
        loc_oPg.AddObject("chk_4c_ChkImpImg", "CheckBox")
        WITH loc_oPg.chk_4c_ChkImpImg
            .Top           = 160
            .Left          = 295
            .Width         = 110
            .Height        = 15
            .Caption       = "Imprimir Imagem"
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label "Produto :" (top=186, left=94)
        loc_oPg.AddObject("lbl_4c_Lbl_codigo", "Label")
        WITH loc_oPg.lbl_4c_Lbl_codigo
            .Top       = 186
            .Left      = 94
            .Width     = 50
            .Height    = 15
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox c" + CHR(243) + "digo produto (get_cd_codigo -> txt_4c__cd_codigo)
        *   Original: top=181, left=147, width=108, MaxLength=14
        loc_oPg.AddObject("txt_4c__cd_codigo", "TextBox")
        WITH loc_oPg.txt_4c__cd_codigo
            .Top               = 181
            .Left              = 147
            .Width             = 108
            .Height            = 24
            .Value             = ""
            .MaxLength         = 14
            .Format            = "!"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .BackColor         = RGB(255, 255, 255)
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(36, 84, 155)
            .SpecialEffect     = 1
            .Enabled           = .F.
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- TextBox descri" + CHR(231) + CHR(227) + "o produto (get_ds_codigo -> txt_4c__ds_codigo)
        *   Original: top=181, left=257, width=237, MaxLength=40
        loc_oPg.AddObject("txt_4c__ds_codigo", "TextBox")
        WITH loc_oPg.txt_4c__ds_codigo
            .Top               = 181
            .Left              = 257
            .Width             = 237
            .Height            = 24
            .Value             = ""
            .MaxLength         = 40
            .Format            = "!"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .BackColor         = RGB(255, 255, 255)
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(36, 84, 155)
            .SpecialEffect     = 1
            .Enabled           = .F.
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- Label "Local :" (top=212, left=108)
        loc_oPg.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg.lbl_4c_Label5
            .Top       = 212
            .Left      = 108
            .Width     = 38
            .Height    = 15
            .Caption   = "Local :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox c" + CHR(243) + "digo local (Get_Local -> txt_4c_Local)
        *   Original: top=207, left=147, width=80, MaxLength=10
        loc_oPg.AddObject("txt_4c_Local", "TextBox")
        WITH loc_oPg.txt_4c_Local
            .Top               = 207
            .Left              = 147
            .Width             = 80
            .Height            = 24
            .Value             = ""
            .MaxLength         = 10
            .FontName          = "Tahoma"
            .FontSize          = 8
            .BackColor         = RGB(255, 255, 255)
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(36, 84, 155)
            .SpecialEffect     = 1
            .Enabled           = .F.
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- TextBox descri" + CHR(231) + CHR(227) + "o local (get_Dlocal -> txt_4c__Dlocal)
        *   Original: top=207, left=229, width=237, MaxLength=20
        loc_oPg.AddObject("txt_4c__Dlocal", "TextBox")
        WITH loc_oPg.txt_4c__Dlocal
            .Top               = 207
            .Left              = 229
            .Width             = 237
            .Height            = 24
            .Value             = ""
            .MaxLength         = 20
            .FontName          = "Tahoma"
            .FontSize          = 8
            .BackColor         = RGB(255, 255, 255)
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(36, 84, 155)
            .SpecialEffect     = 1
            .Enabled           = .F.
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- Label "Itens :" (top=242, left=107)
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Top       = 242
            .Left      = 107
            .Width     = 38
            .Height    = 15
            .Caption   = "Itens :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoDiferenca (Todos / Com Diferen" + CHR(231) + "a) - default=2
        *   Original: top=237, left=141, width=178, height=25; Init set value=2
        loc_oPg.AddObject("obj_4c_TipoDiferenca", "OptionGroup")
        loc_oPg.obj_4c_TipoDiferenca.ButtonCount = 2
        WITH loc_oPg.obj_4c_TipoDiferenca
            .Top           = 237
            .Left          = 141
            .Width         = 190
            .Height        = 25
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 2
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_TipoDiferenca.Buttons(1)
            .Caption   = "Todos"
            .Left      = 5
            .Top       = 5
            .Width     = 55
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoDiferenca.Buttons(2)
            .Caption   = "Com Diferen" + CHR(231) + "a"
            .Left      = 85
            .Top       = 5
            .Width     = 95
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Ordem :" (top=242, left=422)
        loc_oPg.AddObject("lbl_4c_LblOrdem", "Label")
        WITH loc_oPg.lbl_4c_LblOrdem
            .Top       = 242
            .Left      = 422
            .Width     = 48
            .Height    = 15
            .Caption   = "Ordem :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoOrdem (Produto / Grupo)
        *   Original: top=236, left=471, width=137, height=27
        loc_oPg.AddObject("obj_4c_TipoOrdem", "OptionGroup")
        loc_oPg.obj_4c_TipoOrdem.ButtonCount = 2
        WITH loc_oPg.obj_4c_TipoOrdem
            .Top           = 236
            .Left          = 471
            .Width         = 147
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_TipoOrdem.Buttons(1)
            .Caption   = "Produto"
            .Left      = 5
            .Top       = 5
            .Width     = 62
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoOrdem.Buttons(2)
            .Caption   = "Grupo"
            .Left      = 85
            .Top       = 5
            .Width     = 52
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Leitura :" (top=266, left=99)
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Top       = 266
            .Left      = 99
            .Width     = 46
            .Height    = 15
            .Caption   = "Leitura :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoLeitura (Leitura / Releitura)
        *   Original: top=261, left=141, width=151, height=25
        loc_oPg.AddObject("obj_4c_TipoLeitura", "OptionGroup")
        loc_oPg.obj_4c_TipoLeitura.ButtonCount = 2
        WITH loc_oPg.obj_4c_TipoLeitura
            .Top           = 261
            .Left          = 141
            .Width         = 165
            .Height        = 25
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_TipoLeitura.Buttons(1)
            .Caption   = "Leitura"
            .Left      = 5
            .Top       = 5
            .Width     = 55
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoLeitura.Buttons(2)
            .Caption   = "Releitura"
            .Left      = 85
            .Top       = 5
            .Width     = 70
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "C" + CHR(243) + "digo de Barras :" (top=266, left=372)
        loc_oPg.AddObject("lbl_4c_LblBarras", "Label")
        WITH loc_oPg.lbl_4c_LblBarras
            .Top       = 266
            .Left      = 372
            .Width     = 97
            .Height    = 15
            .Caption   = "C" + CHR(243) + "digo de Barras :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup optgBarras (Sim / N" + CHR(227) + "o) - default=1 (Sim)
        *   Original: top=260, left=471, width=131, height=27
        loc_oPg.AddObject("obj_4c_OptgBarras", "OptionGroup")
        loc_oPg.obj_4c_OptgBarras.ButtonCount = 2
        WITH loc_oPg.obj_4c_OptgBarras
            .Top           = 260
            .Left          = 471
            .Width         = 145
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_OptgBarras.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_OptgBarras.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 85
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Pre" + CHR(231) + "o Custo :" (top=290, left=74)
        loc_oPg.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg.lbl_4c_Label6
            .Top       = 290
            .Left      = 74
            .Width     = 72
            .Height    = 15
            .Caption   = "Pre" + CHR(231) + "o Custo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup optgTpCusto (Sim / N" + CHR(227) + "o) - default=1 (Sim)
        *   Original: top=284, left=141, width=131, height=27
        loc_oPg.AddObject("obj_4c_OptgTpCusto", "OptionGroup")
        loc_oPg.obj_4c_OptgTpCusto.ButtonCount = 2
        WITH loc_oPg.obj_4c_OptgTpCusto
            .Top           = 284
            .Left          = 141
            .Width         = 145
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_OptgTpCusto.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_OptgTpCusto.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 85
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Pre" + CHR(231) + "o Venda :" (top=290, left=394)
        loc_oPg.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg.lbl_4c_Label7
            .Top       = 290
            .Left      = 394
            .Width     = 74
            .Height    = 15
            .Caption   = "Pre" + CHR(231) + "o Venda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup optgTpVenda (Sim / N" + CHR(227) + "o) - default=1 (Sim)
        *   Original: top=284, left=471, width=131, height=27
        loc_oPg.AddObject("obj_4c_OptgTpVenda", "OptionGroup")
        loc_oPg.obj_4c_OptgTpVenda.ButtonCount = 2
        WITH loc_oPg.obj_4c_OptgTpVenda
            .Top           = 284
            .Left          = 471
            .Width         = 145
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_OptgTpVenda.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_OptgTpVenda.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 85
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Descri" + CHR(231) + CHR(227) + "o do Produto :" (top=314, left=30)
        loc_oPg.AddObject("lbl_4c_LblDescricao", "Label")
        WITH loc_oPg.lbl_4c_LblDescricao
            .Top       = 314
            .Left      = 30
            .Width     = 115
            .Height    = 15
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup optgDescricao (Sim / N" + CHR(227) + "o) - default=2 (N" + CHR(227) + "o)
        *   Original: top=308, left=141, width=131, height=27, Value=2
        loc_oPg.AddObject("obj_4c_OptgDescricao", "OptionGroup")
        loc_oPg.obj_4c_OptgDescricao.ButtonCount = 2
        WITH loc_oPg.obj_4c_OptgDescricao
            .Top           = 308
            .Left          = 141
            .Width         = 145
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 2
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_OptgDescricao.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_OptgDescricao.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 85
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Localiza" + CHR(231) + CHR(227) + "o :" (top=314, left=400)
        loc_oPg.AddObject("lbl_4c_LblLocalizacao", "Label")
        WITH loc_oPg.lbl_4c_LblLocalizacao
            .Top       = 314
            .Left      = 400
            .Width     = 72
            .Height    = 15
            .Caption   = "Localiza" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup optgLocalizacao (Sim / N" + CHR(227) + "o) - default=2 (N" + CHR(227) + "o)
        *   Original: top=308, left=471, width=131, height=27, Value=2
        loc_oPg.AddObject("obj_4c_OptgLocalizacao", "OptionGroup")
        loc_oPg.obj_4c_OptgLocalizacao.ButtonCount = 2
        WITH loc_oPg.obj_4c_OptgLocalizacao
            .Top           = 308
            .Left          = 471
            .Width         = 145
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 2
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_OptgLocalizacao.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_OptgLocalizacao.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 85
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - BINDEVENTs dos controles interativos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- TipoRelatorio e TipoAnalitico disparam atualiza" + CHR(231) + CHR(227) + "o de estado
        BINDEVENT(loc_oPg.obj_4c_TipoRelatorio, "InteractiveChange", THIS, "TipoRelatorioChange")
        BINDEVENT(loc_oPg.obj_4c_TipoAnalitico, "InteractiveChange", THIS, "TipoAnaliticoChange")

        *-- F4=115, ENTER=13, TAB=9
        BINDEVENT(loc_oPg.txt_4c__cd_codigo, "KeyPress", THIS, "TeclaCdCodigo")
        BINDEVENT(loc_oPg.txt_4c__ds_codigo, "KeyPress", THIS, "TeclaDsCodigo")
        BINDEVENT(loc_oPg.txt_4c_Local,      "KeyPress", THIS, "TeclaLocal")
        BINDEVENT(loc_oPg.txt_4c__Dlocal,    "KeyPress", THIS, "TeclaDLocal")

        BINDEVENT(loc_oPg.txt_4c__cd_codigo, "DblClick", THIS, "AbrirBuscaCdCodigo")
        BINDEVENT(loc_oPg.txt_4c__ds_codigo, "DblClick", THIS, "AbrirBuscaDsCodigo")
        BINDEVENT(loc_oPg.txt_4c_Local,      "DblClick", THIS, "AbrirBuscaLocal")
        BINDEVENT(loc_oPg.txt_4c__Dlocal,    "DblClick", THIS, "AbrirBuscaDLocal")
    ENDPROC

    *==========================================================================
    * ATUALIZA" + CHR(199) + CHR(195) + "O DE ESTADO DOS CONTROLES
    *==========================================================================

    *--------------------------------------------------------------------------
    * TipoRelatorioChange - Habilita/desabilita controles por tipo de relat" + CHR(243) + "rio
    *   Original: TipoRelatorio.InteractiveChange
    *--------------------------------------------------------------------------
    PROCEDURE TipoRelatorioChange()
        LOCAL loc_oPg, loc_nTp, loc_nTpAnal
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_nTp    = loc_oPg.obj_4c_TipoRelatorio.Value
            loc_nTpAnal = loc_oPg.obj_4c_TipoAnalitico.Value

            *-- TipoDiferenca: apenas Resumo por Produto (1)
            loc_oPg.obj_4c_TipoDiferenca.SetAll("Enabled", (loc_nTp = 1), "OptionButton")

            *-- TipoLeitura e TipoAnalitico: apenas Anal" + CHR(237) + "tico (3)
            loc_oPg.obj_4c_TipoLeitura.SetAll("Enabled",   (loc_nTp = 3), "OptionButton")
            loc_oPg.obj_4c_TipoAnalitico.SetAll("Enabled", (loc_nTp = 3), "OptionButton")

            *-- TipoOrdem: apenas Resumo por Produto (1)
            loc_oPg.obj_4c_TipoOrdem.SetAll("Enabled",     (loc_nTp = 1), "OptionButton")

            *-- OptgTpCusto: Resumo por Produto (1) ou Estoque x Leitura (5)
            loc_oPg.obj_4c_OptgTpCusto.SetAll("Enabled",    INLIST(loc_nTp, 1, 5), "OptionButton")

            *-- OptgTpVenda: apenas Resumo por Produto (1)
            loc_oPg.obj_4c_OptgTpVenda.SetAll("Enabled",    (loc_nTp = 1), "OptionButton")

            *-- OptgDescricao: Resumo por Produto (1) ou Etiqueta (4)
            loc_oPg.obj_4c_OptgDescricao.SetAll("Enabled",  INLIST(loc_nTp, 1, 4), "OptionButton")

            *-- OptgBarras: apenas Resumo por Produto (1)
            loc_oPg.obj_4c_OptgBarras.SetAll("Enabled",     (loc_nTp = 1), "OptionButton")

            *-- OptgLocalizacao: apenas Resumo por Produto (1)
            loc_oPg.obj_4c_OptgLocalizacao.SetAll("Enabled", (loc_nTp = 1), "OptionButton")

            *-- Campos produto: apenas Anal" + CHR(237) + "tico (3) + modo Produto (1)
            loc_oPg.txt_4c__cd_codigo.Enabled = (loc_nTp = 3 AND loc_nTpAnal = 1)
            loc_oPg.txt_4c__ds_codigo.Enabled = (loc_nTp = 3 AND loc_nTpAnal = 1)

            *-- Campos local: apenas Anal" + CHR(237) + "tico (3) + modo Local (2)
            loc_oPg.txt_4c_Local.Enabled   = (loc_nTp = 3 AND loc_nTpAnal = 2)
            loc_oPg.txt_4c__Dlocal.Enabled = (loc_nTp = 3 AND loc_nTpAnal = 2)

            *-- chkImpImg: apenas Etiqueta (4) ou Estoque x Leitura (5)
            IF !INLIST(loc_nTp, 4, 5)
                loc_oPg.chk_4c_ChkImpImg.Value = 0
            ENDIF
            loc_oPg.chk_4c_ChkImpImg.Enabled = INLIST(loc_nTp, 4, 5)

            THIS.AtualizarReadOnly()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TipoRelatorioChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TipoAnaliticoChange - Atualiza campos de c" + CHR(243) + "digo/local por modo anal" + CHR(237) + "tico
    *   Original: TipoAnalitico.InteractiveChange (impl" + CHR(237) + "cito no legado)
    *--------------------------------------------------------------------------
    PROCEDURE TipoAnaliticoChange()
        LOCAL loc_oPg, loc_nTp, loc_nTpAnal
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_nTp    = loc_oPg.obj_4c_TipoRelatorio.Value
            loc_nTpAnal = loc_oPg.obj_4c_TipoAnalitico.Value

            loc_oPg.txt_4c__cd_codigo.Enabled = (loc_nTp = 3 AND loc_nTpAnal = 1)
            loc_oPg.txt_4c__ds_codigo.Enabled = (loc_nTp = 3 AND loc_nTpAnal = 1)
            loc_oPg.txt_4c_Local.Enabled      = (loc_nTp = 3 AND loc_nTpAnal = 2)
            loc_oPg.txt_4c__Dlocal.Enabled    = (loc_nTp = 3 AND loc_nTpAnal = 2)

            THIS.AtualizarReadOnly()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TipoAnaliticoChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarReadOnly - L" + CHR(243) + "gica When original dos campos de descri" + CHR(231) + CHR(227) + "o
    *   get_ds_codigo.When: Return(Empty(Get_Cd_Codigo.Value))
    *   get_Dlocal.When:    Return(Empty(Get_Local.Value))
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarReadOnly()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c__ds_codigo.ReadOnly = !EMPTY(ALLTRIM(loc_oPg.txt_4c__cd_codigo.Value))
            loc_oPg.txt_4c__Dlocal.ReadOnly    = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Local.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AtualizarReadOnly")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarRegraGesInd - Oculta controles extras quando GesInd = 1
    *   Original: If CsSigCdPam.GesInd = 1 -> ocultar TipoOrdem/Descricao/Barras/Localiz
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarRegraGesInd()
        LOCAL loc_oPg
        TRY
            IF !USED("CsSigCdPam")
                RETURN
            ENDIF
            SELECT CsSigCdPam
            GO TOP
            IF !EOF() AND CsSigCdPam.GesInd = 1
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                loc_oPg.obj_4c_TipoOrdem.Visible       = .F.
                loc_oPg.obj_4c_OptgDescricao.Visible   = .F.
                loc_oPg.obj_4c_OptgBarras.Visible      = .F.
                loc_oPg.obj_4c_OptgLocalizacao.Visible = .F.
                loc_oPg.lbl_4c_LblOrdem.Visible        = .F.
                loc_oPg.lbl_4c_LblDescricao.Visible    = .F.
                loc_oPg.lbl_4c_LblBarras.Visible       = .F.
                loc_oPg.lbl_4c_LblLocalizacao.Visible  = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AplicarRegraGesInd")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_nTipoRelatorio  = loc_oPg.obj_4c_TipoRelatorio.Value
                .this_nTipoAnalitico  = loc_oPg.obj_4c_TipoAnalitico.Value
                .this_nTipoDiferenca  = loc_oPg.obj_4c_TipoDiferenca.Value
                .this_nTipoLeitura    = loc_oPg.obj_4c_TipoLeitura.Value
                .this_nTipoOrdem      = loc_oPg.obj_4c_TipoOrdem.Value
                .this_cCodProduto     = ALLTRIM(loc_oPg.txt_4c__cd_codigo.Value)
                .this_cDesProduto     = ALLTRIM(loc_oPg.txt_4c__ds_codigo.Value)
                .this_cLocal          = ALLTRIM(loc_oPg.txt_4c_Local.Value)
                .this_cDesLocal       = ALLTRIM(loc_oPg.txt_4c__Dlocal.Value)
                .this_nTpCusto        = loc_oPg.obj_4c_OptgTpCusto.Value
                .this_nTpVenda        = loc_oPg.obj_4c_OptgTpVenda.Value
                .this_nDescricao      = loc_oPg.obj_4c_OptgDescricao.Value
                .this_nBarras         = loc_oPg.obj_4c_OptgBarras.Value
                .this_nLocalizacao    = loc_oPg.obj_4c_OptgLocalizacao.Value
                .this_lImprimirImagem = (loc_oPg.chk_4c_ChkImpImg.Value = 1)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaRelatorio")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOT" + CHR(213) + "ES DE A" + CHR(199) + CHR(195) + "O
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relat" + CHR(243) + "rio em preview
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relat" + CHR(243) + "rio com di" + CHR(225) + "logo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Imprimir()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Excel n" + CHR(227) + "o dispon" + CHR(237) + "vel (relat" + CHR(243) + "rio de balan" + CHR(231) + "o usa FRX pr" + CHR(243) + "prio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        MsgAviso("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel neste relat" + CHR(243) + "rio." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Excel")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formul" + CHR(225) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - KeyPress via BINDEVENT
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    PROCEDURE TeclaCdCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaLocal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaLocal()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarLocal()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDLocal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDLocal()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDLocal()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - PRODUTO (SigCdPro, campos CPros e DPros)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaCdCodigo - Lookup de produto pelo c" + CHR(243) + "digo (CPros)
    *   Original: get_cd_codigo.Valid -> fwbuscaext SigCdPro CPros
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdCodigo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__cd_codigo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValor, ;
            "Produtos", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c__cd_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
                loc_oPg.txt_4c__ds_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                        loc_oPg.txt_4c__cd_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
                        loc_oPg.txt_4c__ds_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDsCodigo - Lookup de produto pela descri" + CHR(231) + CHR(227) + "o (DPros)
    *   Original: get_ds_codigo.Valid -> fwbuscaext SigCdPro DPros
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDsCodigo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__ds_codigo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaPro", "DPros", loc_cValor, ;
            "Produtos", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c__ds_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                loc_oPg.txt_4c__cd_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                        loc_oPg.txt_4c__ds_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                        loc_oPg.txt_4c__cd_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdCodigo - Valida c" + CHR(243) + "digo digitado e preenche descri" + CHR(231) + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdCodigo()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__cd_codigo.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c__ds_codigo.Value = ""
            THIS.AtualizarReadOnly()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ProVal
            IF !EOF()
                loc_oPg.txt_4c__ds_codigo.Value = ALLTRIM(cursor_4c_ProVal.DPros)
            ELSE
                loc_oPg.txt_4c__ds_codigo.Value = ""
                THIS.AbrirBuscaCdCodigo()
            ENDIF
        ELSE
            loc_oPg.txt_4c__ds_codigo.Value = ""
            THIS.AbrirBuscaCdCodigo()
        ENDIF
        IF USED("cursor_4c_ProVal")
            USE IN cursor_4c_ProVal
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsCodigo - Valida descri" + CHR(231) + CHR(227) + "o digitada e preenche c" + CHR(243) + "digo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDsCodigo()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__ds_codigo.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c__cd_codigo.Value = ""
            THIS.AtualizarReadOnly()
            RETURN
        ENDIF
        THIS.AbrirBuscaDsCodigo()
        THIS.AtualizarReadOnly()
    ENDPROC

    *==========================================================================
    * LOOKUPS - LOCAL (SigPrLcl, campos codigos e descricaos)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaLocal - Lookup de local pelo c" + CHR(243) + "digo (codigos)
    *   Original: Get_Local.Valid -> fwbuscaext SigPrLcl codigos
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaLocal()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Local.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", loc_cValor, ;
            "Locais", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Local.Value   = ALLTRIM(cursor_4c_BuscaLocal.codigos)
                loc_oPg.txt_4c__Dlocal.Value = ALLTRIM(cursor_4c_BuscaLocal.descricaos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
                        loc_oPg.txt_4c_Local.Value   = ALLTRIM(cursor_4c_BuscaLocal.codigos)
                        loc_oPg.txt_4c__Dlocal.Value = ALLTRIM(cursor_4c_BuscaLocal.descricaos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaLocal")
            USE IN cursor_4c_BuscaLocal
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDLocal - Lookup de local pela descri" + CHR(231) + CHR(227) + "o (descricaos)
    *   Original: get_Dlocal.Valid -> fwbuscaext SigPrLcl descricaos
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDLocal()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__Dlocal.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrLcl", "cursor_4c_BuscaLocal", "descricaos", loc_cValor, ;
            "Locais", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c__Dlocal.Value = ALLTRIM(cursor_4c_BuscaLocal.descricaos)
                loc_oPg.txt_4c_Local.Value   = ALLTRIM(cursor_4c_BuscaLocal.codigos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
                        loc_oPg.txt_4c__Dlocal.Value = ALLTRIM(cursor_4c_BuscaLocal.descricaos)
                        loc_oPg.txt_4c_Local.Value   = ALLTRIM(cursor_4c_BuscaLocal.codigos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaLocal")
            USE IN cursor_4c_BuscaLocal
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLocal - Valida c" + CHR(243) + "digo de local digitado e preenche descri" + CHR(231) + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarLocal()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Local.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c__Dlocal.Value = ""
            THIS.AtualizarReadOnly()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT codigos, descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LclVal")
        IF loc_nResult > 0
            SELECT cursor_4c_LclVal
            IF !EOF()
                loc_oPg.txt_4c__Dlocal.Value = ALLTRIM(cursor_4c_LclVal.descricaos)
            ELSE
                loc_oPg.txt_4c__Dlocal.Value = ""
                THIS.AbrirBuscaLocal()
            ENDIF
        ELSE
            loc_oPg.txt_4c__Dlocal.Value = ""
            THIS.AbrirBuscaLocal()
        ENDIF
        IF USED("cursor_4c_LclVal")
            USE IN cursor_4c_LclVal
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDLocal - Valida descri" + CHR(231) + CHR(227) + "o de local digitada e preenche c" + CHR(243) + "digo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDLocal()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__Dlocal.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_Local.Value = ""
            THIS.AtualizarReadOnly()
            RETURN
        ENDIF
        THIS.AbrirBuscaDLocal()
        THIS.AtualizarReadOnly()
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE COM FORMBASE
    *==========================================================================

    PROCEDURE AtualizarEstadoControles()
        THIS.TipoRelatorioChange()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao (chamado por FormBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.obj_4c_TipoRelatorio.Value   = 1
            loc_oPg.obj_4c_TipoAnalitico.Value   = 1
            loc_oPg.obj_4c_TipoDiferenca.Value   = 2
            loc_oPg.obj_4c_TipoLeitura.Value     = 1
            loc_oPg.obj_4c_TipoOrdem.Value       = 1
            loc_oPg.obj_4c_OptgTpCusto.Value     = 1
            loc_oPg.obj_4c_OptgTpVenda.Value     = 1
            loc_oPg.obj_4c_OptgDescricao.Value   = 2
            loc_oPg.obj_4c_OptgBarras.Value      = 1
            loc_oPg.obj_4c_OptgLocalizacao.Value = 2
            loc_oPg.chk_4c_ChkImpImg.Value       = 0
            loc_oPg.txt_4c__cd_codigo.Value      = ""
            loc_oPg.txt_4c__ds_codigo.Value      = ""
            loc_oPg.txt_4c_Local.Value           = ""
            loc_oPg.txt_4c__Dlocal.Value         = ""
            THIS.TipoRelatorioChange()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita controles de filtro conforme estado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        TRY
            THIS.TipoRelatorioChange()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    PROCEDURE CarregarLista()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c__cd_codigo", 5)
                loc_oPg.txt_4c__cd_codigo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oPgf, loc_oPg
        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) != "O"
                RETURN
            ENDIF
            loc_oPgf.ActivePage = 1
            loc_oPg = loc_oPgf.Pages(1)
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c__cd_codigo", 5)
                loc_oPg.txt_4c__cd_codigo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.obj_4c_TipoRelatorio.Value   = .this_nTipoRelatorio
                loc_oPg.obj_4c_TipoAnalitico.Value   = .this_nTipoAnalitico
                loc_oPg.obj_4c_TipoDiferenca.Value   = .this_nTipoDiferenca
                loc_oPg.obj_4c_TipoLeitura.Value     = .this_nTipoLeitura
                loc_oPg.obj_4c_TipoOrdem.Value       = .this_nTipoOrdem
                loc_oPg.txt_4c__cd_codigo.Value      = .this_cCodProduto
                loc_oPg.txt_4c__ds_codigo.Value      = .this_cDesProduto
                loc_oPg.txt_4c_Local.Value           = .this_cLocal
                loc_oPg.txt_4c__Dlocal.Value         = .this_cDesLocal
                loc_oPg.obj_4c_OptgTpCusto.Value     = .this_nTpCusto
                loc_oPg.obj_4c_OptgTpVenda.Value     = .this_nTpVenda
                loc_oPg.obj_4c_OptgDescricao.Value   = .this_nDescricao
                loc_oPg.obj_4c_OptgBarras.Value      = .this_nBarras
                loc_oPg.obj_4c_OptgLocalizacao.Value = .this_nLocalizacao
                loc_oPg.chk_4c_ChkImpImg.Value       = .this_lImprimirImagem
            ENDWITH
            THIS.TipoRelatorioChange()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera refer" + CHR(234) + "ncia ao BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
