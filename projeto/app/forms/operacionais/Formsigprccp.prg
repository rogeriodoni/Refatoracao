*=============================================================================
* Formsigprccp.prg
* Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os (SIGPRCCP)
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRCCP.SCX
*=============================================================================

DEFINE CLASS Formsigprccp AS FormBase

    *-- Propriedades visuais
    Height      = 600
    Width       = 1000
    Caption     = "Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os"
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    ShowTips    = .T.
    KeyPreview  = .T.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_lAutomatico     = .F.

    *==========================================================================
    PROCEDURE Init(par_lAutomatico)
    *==========================================================================
        IF PCOUNT() > 0
            THIS.this_lAutomatico = par_lAutomatico
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprccpBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigprccp.", "Erro")
            ELSE
                *-- Configurar base visual do form (equivalente ao PageFrame em CRUD)
                THIS.ConfigurarPageFrame()

                *-- Inicializar cursores do BO
                THIS.this_oBusinessObject.CarregarDadosAuxiliares()
                THIS.this_oBusinessObject.CriarCursorDados()

                *-- Construir interface
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarFiltros()
                THIS.ConfigurarOpcoes()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarBotoes()
                THIS.TornarControlesVisiveis()
                THIS.ConfigurarBINDEVENTs()
                THIS.InicializarValores()

                *-- Modo automatico
                IF THIS.this_lAutomatico
                    THIS.this_oBusinessObject.this_lAutomatico = .T.
                    THIS.this_oBusinessObject.ProcessaAutomatico()
                    THIS.grd_4c_Produto.Refresh
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Configura a base visual do form
    * Form OPERACIONAL: layout FLAT (sem PageFrame). Este metodo configura
    * as propriedades base do form (Picture, BackColor, ClipControls) que em
    * um form CRUD estariam num PageFrame com Page1/Page2.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.Picture     = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
        THIS.BackColor   = RGB(255, 255, 255)
        THIS.ClipControls = .F.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BorderWidth= 0
            .BackColor  = RGB(100,100,100)
            .Visible    = .T.
            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .AutoSize      = .F.
                .BackStyle     = 0
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
                .Visible       = .T.
            ENDWITH
            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .AutoSize   = .F.
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255,255,255)
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros
    *==========================================================================
        LOCAL loc_o

        *-- Label "Filtros" (titulo secao)
        THIS.AddObject("lbl_4c_SecFiltros", "Label")
        WITH THIS.lbl_4c_SecFiltros
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .BackStyle = 0
            .Caption   = "Filtros"
            .Height    = 21
            .Left      = 11
            .Top       = 94
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 1: Fornecedor (Top=88)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_Fornecedor", "Label")
        WITH THIS.lbl_4c_Fornecedor
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Fornecedor :"
            .Height    = 15
            .Left      = 79
            .Top       = 92
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CFornecs", "TextBox")
        WITH THIS.txt_4c_CFornecs
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .Format        = "K!"
            .Height        = 23
            .Left          = 145
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 88
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DFornecs", "TextBox")
        WITH THIS.txt_4c_DFornecs
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 228
            .MaxLength     = 40
            .SpecialEffect = 1
            .Top           = 88
            .Width         = 197
            .ReadOnly      = .T.
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 2: Grande Grupo (Top=113)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_MercI", "Label")
        WITH THIS.lbl_4c_MercI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grande Grupo :"
            .Height    = 15
            .Left      = 67
            .Top       = 117
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MercI", "TextBox")
        WITH THIS.txt_4c_MercI
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 145
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 113
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteMercI", "Label")
        WITH THIS.lbl_4c_AteMercI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 179
            .Top       = 117
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MercF", "TextBox")
        WITH THIS.txt_4c_MercF
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 198
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 113
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 3: Grupo (Top=138)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_CGrui", "Label")
        WITH THIS.lbl_4c_CGrui
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo :"
            .Height    = 15
            .Left      = 105
            .Top       = 142
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CGrui", "TextBox")
        WITH THIS.txt_4c_CGrui
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 145
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 138
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteCGrui", "Label")
        WITH THIS.lbl_4c_AteCGrui
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 179
            .Top       = 142
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CGruf", "TextBox")
        WITH THIS.txt_4c_CGruf
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 198
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 138
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 4: Subgrupo (Top=163)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_SGruI", "Label")
        WITH THIS.lbl_4c_SGruI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Subgrupo :"
            .Height    = 15
            .Left      = 88
            .Top       = 167
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_SGruI", "TextBox")
        WITH THIS.txt_4c_SGruI
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 145
            .MaxLength     = 6
            .SpecialEffect = 1
            .Top           = 163
            .Width         = 52
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteSGruI", "Label")
        WITH THIS.lbl_4c_AteSGruI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 201
            .Top       = 167
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_SGruF", "TextBox")
        WITH THIS.txt_4c_SGruF
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 220
            .MaxLength     = 6
            .SpecialEffect = 1
            .Top           = 163
            .Width         = 52
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 5: Unidade (Top=189)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_CUniI", "Label")
        WITH THIS.lbl_4c_CUniI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Unidade :"
            .Height    = 15
            .Left      = 95
            .Top       = 193
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CUniI", "TextBox")
        WITH THIS.txt_4c_CUniI
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 145
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 189
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteCUniI", "Label")
        WITH THIS.lbl_4c_AteCUniI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 179
            .Top       = 193
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CUnif", "TextBox")
        WITH THIS.txt_4c_CUnif
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 198
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 189
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- ROW 6: Moeda (Top=213)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_MoeI", "Label")
        WITH THIS.lbl_4c_MoeI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Moeda :"
            .Height    = 15
            .Left      = 102
            .Top       = 217
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MoeI", "TextBox")
        WITH THIS.txt_4c_MoeI
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 145
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 213
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteMoeI", "Label")
        WITH THIS.lbl_4c_AteMoeI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 179
            .Top       = 217
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MoeF", "TextBox")
        WITH THIS.txt_4c_MoeF
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 198
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 213
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- ----------------------------------------------------------------
        *-- RIGHT COLUMN: Linha (Top=88)
        *-- ----------------------------------------------------------------
        THIS.AddObject("lbl_4c_LinhI", "Label")
        WITH THIS.lbl_4c_LinhI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Linha :"
            .Height    = 15
            .Left      = 503
            .Top       = 92
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_LinhI", "TextBox")
        WITH THIS.txt_4c_LinhI
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 539
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 88
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteLinhI", "Label")
        WITH THIS.lbl_4c_AteLinhI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 627
            .Top       = 92
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_LinhF", "TextBox")
        WITH THIS.txt_4c_LinhF
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 649
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 88
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- RIGHT COLUMN: Grupo Venda/Colecao (Top=113)
        THIS.AddObject("lbl_4c_ColI", "Label")
        WITH THIS.lbl_4c_ColI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo Venda :"
            .Height    = 15
            .Left      = 466
            .Top       = 117
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_ColI", "TextBox")
        WITH THIS.txt_4c_ColI
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 539
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 113
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteColI", "Label")
        WITH THIS.lbl_4c_AteColI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 627
            .Top       = 117
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_ColF", "TextBox")
        WITH THIS.txt_4c_ColF
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 23
            .Left          = 649
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 113
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- RIGHT COLUMN: Markup (Top=138)
        THIS.AddObject("lbl_4c_MrkI", "Label")
        WITH THIS.lbl_4c_MrkI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Markup :"
            .Height    = 15
            .Left      = 493
            .Top       = 142
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MrkI", "TextBox")
        WITH THIS.txt_4c_MrkI
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999.99"
            .Left          = 539
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 138
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteMrkI", "Label")
        WITH THIS.lbl_4c_AteMrkI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 627
            .Top       = 142
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_MrkF", "TextBox")
        WITH THIS.txt_4c_MrkF
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999.99"
            .Left          = 649
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 138
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- RIGHT COLUMN: Encargo (Top=163)
        THIS.AddObject("lbl_4c_EncI", "Label")
        WITH THIS.lbl_4c_EncI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Encargo :"
            .Height    = 15
            .Left      = 486
            .Top       = 167
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_EncI", "TextBox")
        WITH THIS.txt_4c_EncI
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999.99"
            .Left          = 539
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 163
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_AteEncI", "Label")
        WITH THIS.lbl_4c_AteEncI
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .Left      = 627
            .Top       = 167
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_EncF", "TextBox")
        WITH THIS.txt_4c_EncF
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999.99"
            .Left          = 649
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 163
            .Width         = 84
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- RIGHT COLUMN: Variacao % + Feitio (Top=189)
        THIS.AddObject("lbl_4c_Variacao", "Label")
        WITH THIS.lbl_4c_Variacao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o ( % ) : "
            .Height    = 15
            .Left      = 456
            .Top       = 193
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Variacao", "TextBox")
        WITH THIS.txt_4c_Variacao
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999.99"
            .Left          = 539
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 189
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Feitio", "Label")
        WITH THIS.lbl_4c_Feitio
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "C" + CHR(243) + "digo MKP : "
            .Height    = 15
            .Left      = 639
            .Top       = 193
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Feitio", "TextBox")
        WITH THIS.txt_4c_Feitio
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 709
            .MaxLength     = 2
            .SpecialEffect = 1
            .Top           = 189
            .Width         = 24
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOpcoes
    *==========================================================================
        *-- OptionGroup Ideal/Venda (fwoption1) em (Left=234, Top=211)
        THIS.AddObject("opg_4c_OpcaoM", "OptionGroup")
        WITH THIS.opg_4c_OpcaoM
            .ButtonCount = 2
            .Value       = 1
            .Height      = 26
            .Left        = 234
            .Top         = 211
            .Width       = 106
            .BackStyle   = 0
            .Visible     = .T.
            .Buttons(1).Caption     = "\<Ideal"
            .Buttons(1).Left        = 5
            .Buttons(1).Top         = 5
            .Buttons(1).AutoSize    = .T.
            .Buttons(1).Themes      = .F.
            .Buttons(2).Caption     = "\<Venda"
            .Buttons(2).Left        = 53
            .Buttons(2).Top         = 6
            .Buttons(2).AutoSize    = .T.
            .Buttons(2).Themes      = .F.
        ENDWITH

        *-- OptionGroup Situacao (Left=536, Top=214)
        THIS.AddObject("lbl_4c_Situacao", "Label")
        WITH THIS.lbl_4c_Situacao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Left      = 486
            .Top       = 217
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opg_4c_Situacao", "OptionGroup")
        WITH THIS.opg_4c_Situacao
            .ButtonCount = 3
            .Value       = 3
            .Height      = 21
            .Left        = 536
            .Top         = 214
            .Width       = 189
            .BackStyle   = 0
            .Visible     = .T.
            .Buttons(1).Caption     = "\<Ativos"
            .Buttons(1).Left        = 5
            .Buttons(1).Top         = 3
            .Buttons(1).AutoSize    = .T.
            .Buttons(1).Themes      = .F.
            .Buttons(2).Caption     = "\<Inativos"
            .Buttons(2).Left        = 59
            .Buttons(2).Top         = 2
            .Buttons(2).AutoSize    = .F.
            .Buttons(2).Themes      = .F.
            .Buttons(3).FontName    = "Tahoma"
            .Buttons(3).FontSize    = 8
            .Buttons(3).Caption     = "\<Todos"
            .Buttons(3).Height      = 17
            .Buttons(3).Left        = 125
            .Buttons(3).Top         = 2
            .Buttons(3).Width       = 61
            .Buttons(3).AutoSize    = .F.
            .Buttons(3).ForeColor   = RGB(90,90,90)
            .Buttons(3).Themes      = .F.
        ENDWITH

        *-- OptionGroup Compra (Left=536, Top=234)
        THIS.AddObject("lbl_4c_Compra", "Label")
        WITH THIS.lbl_4c_Compra
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Compra :"
            .Left      = 490
            .Top       = 237
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opg_4c_Compra", "OptionGroup")
        WITH THIS.opg_4c_Compra
            .ButtonCount = 3
            .Value       = 3
            .Height      = 21
            .Left        = 536
            .Top         = 234
            .Width       = 204
            .BackStyle   = 0
            .Visible     = .T.
            .Buttons(1).Caption     = "\<Comprar"
            .Buttons(1).Left        = 5
            .Buttons(1).Top         = 3
            .Buttons(1).AutoSize    = .T.
            .Buttons(1).Themes      = .F.
            .Buttons(2).Caption     = "\<N" + CHR(227) + "o Comprar"
            .Buttons(2).Left        = 67
            .Buttons(2).Top         = 3
            .Buttons(2).AutoSize    = .T.
            .Buttons(2).Themes      = .F.
            .Buttons(3).FontName    = "Tahoma"
            .Buttons(3).FontSize    = 8
            .Buttons(3).Caption     = "\<Todos"
            .Buttons(3).Height      = 17
            .Buttons(3).Left        = 152
            .Buttons(3).Top         = 2
            .Buttons(3).Width       = 61
            .Buttons(3).ForeColor   = RGB(90,90,90)
            .Buttons(3).AutoSize    = .F.
            .Buttons(3).Themes      = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
    *==========================================================================
        *-- Linha separadora
        THIS.AddObject("lin_4c_Sep", "Line")
        WITH THIS.lin_4c_Sep
            .Height = 0
            .Left   = 13
            .Top    = 258
            .Width  = 738
            .Visible= .T.
        ENDWITH

        *-- Label "Dados" (titulo secao)
        THIS.AddObject("lbl_4c_SecDados", "Label")
        WITH THIS.lbl_4c_SecDados
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .BackStyle = 0
            .Caption   = "Dados"
            .Height    = 21
            .Left      = 12
            .Top       = 270
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Recalcula :" e OptionGroup Recalc (8 opcoes)
        THIS.AddObject("lbl_4c_Recalcula", "Label")
        WITH THIS.lbl_4c_Recalcula
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Recalcula :"
            .Left      = 89
            .Top       = 263
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opg_4c_Recalc", "OptionGroup")
        WITH THIS.opg_4c_Recalc
            .ButtonCount = 8
            .Value       = 1
            .Height      = 41
            .Left        = 142
            .Top         = 258
            .Width       = 439
            .BackStyle   = 0
            .Visible     = .T.
            *-- Row 1: Composicao, Custo Venda, Ambos, Peso Componentes
            .Buttons(1).FontName    = "Tahoma"
            .Buttons(1).FontSize    = 8
            .Buttons(1).Caption     = "\<Composi" + CHR(231) + CHR(227) + "o"
            .Buttons(1).Left        = 5
            .Buttons(1).Top         = 5
            .Buttons(1).AutoSize    = .T.
            .Buttons(1).ForeColor   = RGB(90,90,90)
            .Buttons(1).Themes      = .F.
            .Buttons(2).FontName    = "Tahoma"
            .Buttons(2).FontSize    = 8
            .Buttons(2).Caption     = "Custo \<Venda"
            .Buttons(2).Left        = 98
            .Buttons(2).Top         = 5
            .Buttons(2).AutoSize    = .T.
            .Buttons(2).ForeColor   = RGB(90,90,90)
            .Buttons(2).Themes      = .F.
            .Buttons(3).FontName    = "Tahoma"
            .Buttons(3).FontSize    = 8
            .Buttons(3).Caption     = "\<Ambos"
            .Buttons(3).Height      = 15
            .Buttons(3).Left        = 213
            .Buttons(3).Top         = 5
            .Buttons(3).Width       = 50
            .Buttons(3).AutoSize    = .T.
            .Buttons(3).ForeColor   = RGB(90,90,90)
            .Buttons(3).Themes      = .F.
            .Buttons(4).FontName    = "Tahoma"
            .Buttons(4).FontSize    = 8
            .Buttons(4).Caption     = "Peso Componentes"
            .Buttons(4).Height      = 15
            .Buttons(4).Left        = 312
            .Buttons(4).Top         = 4
            .Buttons(4).Width       = 110
            .Buttons(4).AutoSize    = .T.
            .Buttons(4).ForeColor   = RGB(90,90,90)
            .Buttons(4).Themes      = .F.
            *-- Row 2: Cambio, Cambio Inteiros, Markup Custo, Markup Venda
            .Buttons(5).FontName    = "Tahoma"
            .Buttons(5).FontSize    = 8
            .Buttons(5).Caption     = "C" + CHR(226) + "m\<bio"
            .Buttons(5).Height      = 15
            .Buttons(5).Left        = 5
            .Buttons(5).Top         = 23
            .Buttons(5).Width       = 53
            .Buttons(5).AutoSize    = .T.
            .Buttons(5).ForeColor   = RGB(90,90,90)
            .Buttons(5).Themes      = .F.
            .Buttons(6).FontName    = "Tahoma"
            .Buttons(6).FontSize    = 8
            .Buttons(6).Caption     = "C" + CHR(226) + "mbio (Inteiros)"
            .Buttons(6).Height      = 15
            .Buttons(6).Left        = 98
            .Buttons(6).Top         = 23
            .Buttons(6).Width       = 101
            .Buttons(6).AutoSize    = .T.
            .Buttons(6).ForeColor   = RGB(90,90,90)
            .Buttons(6).Themes      = .F.
            .Buttons(7).FontName    = "Tahoma"
            .Buttons(7).FontSize    = 8
            .Buttons(7).Caption     = "Markup Custo"
            .Buttons(7).Height      = 15
            .Buttons(7).Left        = 213
            .Buttons(7).Top         = 23
            .Buttons(7).Width       = 84
            .Buttons(7).AutoSize    = .T.
            .Buttons(7).ForeColor   = RGB(90,90,90)
            .Buttons(7).Themes      = .F.
            .Buttons(8).FontName    = "Tahoma"
            .Buttons(8).FontSize    = 8
            .Buttons(8).Caption     = "Markup Venda"
            .Buttons(8).Height      = 15
            .Buttons(8).Left        = 312
            .Buttons(8).Top         = 22
            .Buttons(8).Width       = 86
            .Buttons(8).AutoSize    = .T.
            .Buttons(8).ForeColor   = RGB(90,90,90)
            .Buttons(8).Themes      = .F.
        ENDWITH

        *-- Reajuste (Left=148, Top=300)
        THIS.AddObject("lbl_4c_Reajuste", "Label")
        WITH THIS.lbl_4c_Reajuste
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Reajuste :"
            .Height    = 15
            .Left      = 91
            .Top       = 304
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Reajuste", "TextBox")
        WITH THIS.txt_4c_Reajuste
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999,999.999"
            .Left          = 148
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 300
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Novo Markup % (Left=148, Top=326)
        THIS.AddObject("lbl_4c_NMrk", "Label")
        WITH THIS.lbl_4c_NMrk
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo Markup :"
            .Height    = 15
            .Left      = 71
            .Top       = 330
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_NMrk", "TextBox")
        WITH THIS.txt_4c_NMrk
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999,999.99"
            .Left          = 148
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 326
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Novo Encargo (Left=326, Top=300)
        THIS.AddObject("lbl_4c_Encargo", "Label")
        WITH THIS.lbl_4c_Encargo
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo Encargo : "
            .Height    = 15
            .Left      = 245
            .Top       = 304
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Encargo", "TextBox")
        WITH THIS.txt_4c_Encargo
            .Alignment     = 3
            .BorderStyle   = 1
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999,999.99"
            .Left          = 326
            .MaxLength     = 0
            .SpecialEffect = 1
            .Top           = 300
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Atualiza Val.Venda (Left=544, Top=298)
        THIS.AddObject("lbl_4c_PVen", "Label")
        WITH THIS.lbl_4c_PVen
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Atualiza Val.Venda :"
            .Height    = 15
            .Left      = 448
            .Top       = 304
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opg_4c_PVen", "OptionGroup")
        WITH THIS.opg_4c_PVen
            .ButtonCount = 2
            .Value       = 2
            .Height      = 27
            .Left        = 544
            .Top         = 298
            .Width       = 102
            .BackStyle   = 0
            .Visible     = .T.
            .Buttons(1).Caption     = "\<Sim"
            .Buttons(1).Left        = 5
            .Buttons(1).Top         = 5
            .Buttons(1).AutoSize    = .T.
            .Buttons(1).Themes      = .F.
            .Buttons(2).Caption     = "\<N" + CHR(227) + "o"
            .Buttons(2).Height      = 17
            .Buttons(2).Left        = 53
            .Buttons(2).Top         = 5
            .Buttons(2).Width       = 44
            .Buttons(2).AutoSize    = .F.
            .Buttons(2).Themes      = .F.
        ENDWITH

        *-- Novo MKP code (Left=326, Top=326)
        THIS.AddObject("lbl_4c_NewMkp", "Label")
        WITH THIS.lbl_4c_NewMkp
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo MKP : "
            .Height    = 15
            .Left      = 264
            .Top       = 330
            .AutoSize  = .T.
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_NewMkp", "TextBox")
        WITH THIS.txt_4c_NewMkp
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 326
            .MaxLength     = 2
            .SpecialEffect = 1
            .Top           = 326
            .Width         = 24
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Layout operacional (substitui Page1 do CRUD)
    * Form OPERACIONAL flat: grid de resultados + imagem de produto
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        THIS.ConfigurarGrid()
        THIS.ConfigurarImagem()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid
    *==========================================================================
        LOCAL loc_oGrd
        THIS.AddObject("grd_4c_Produto", "Grid")
        loc_oGrd = THIS.grd_4c_Produto
        loc_oGrd.ColumnCount  = 9
        loc_oGrd.RecordSource = "cursor_4c_Dados"
        WITH loc_oGrd
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 244
            .Left          = 12
            .RowHeight     = 16
            .ScrollBars    = 2
            .Top           = 351
            .Width         = 935
            .RecordMark    = .F.
            .DeleteMark    = .F.
            .Visible       = .T.

            *-- Column1: Checkbox (lMarca)
            .Column1.Alignment     = 3
            .Column1.Width         = 17
            .Column1.Movable       = .F.
            .Column1.Resizable     = .F.
            .Column1.Sparse        = .F.
            .Column1.Header1.Caption   = ""
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(36,84,155)
            .Column1.RemoveObject("Text1")
            .Column1.AddObject("chk_4c_Marca", "CheckBox")
            WITH .Column1.chk_4c_Marca
                .Caption = ""
                .Width   = 17
                .Height  = 17
                .Value   = 0
                .Visible = .T.
            ENDWITH
            .Column1.CurrentControl = "chk_4c_Marca"
            .Column1.ControlSource  = "cursor_4c_Dados.lMarca"

            *-- Column2: CPros (Produto)
            .Column2.FontName      = "Tahoma"
            .Column2.FontSize      = 8
            .Column2.Width         = 108
            .Column2.Movable       = .F.
            .Column2.Resizable     = .F.
            .Column2.ControlSource = "cursor_4c_Dados.CPros"
            .Column2.Header1.Caption   = "Produto"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(36,84,155)
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .T.

            *-- Column3: DPros (Descricao)
            .Column3.FontName      = "Tahoma"
            .Column3.FontSize      = 8
            .Column3.Width         = 290
            .Column3.Movable       = .F.
            .Column3.Resizable     = .F.
            .Column3.ControlSource = "cursor_4c_Dados.DPros"
            .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(36,84,155)
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ReadOnly    = .T.

            *-- Column4: ValAnt (Venda Ant.)
            .Column4.FontName      = "Tahoma"
            .Column4.FontSize      = 8
            .Column4.Width         = 80
            .Column4.Movable       = .F.
            .Column4.Resizable     = .F.
            .Column4.ControlSource = "cursor_4c_Dados.ValAnt"
            .Column4.Header1.Caption   = "Venda Ant."
            .Column4.Header1.Alignment = 2
            .Column4.Header1.ForeColor = RGB(36,84,155)
            WITH .Column4.Text1
                .InputMask  = "999,999,999.99"
                .Margin     = 0
                .ReadOnly   = .T.
            ENDWITH

            *-- Column5: ValAtu (Venda Atual)
            .Column5.FontName      = "Tahoma"
            .Column5.FontSize      = 8
            .Column5.Width         = 80
            .Column5.Movable       = .F.
            .Column5.Resizable     = .F.
            .Column5.ControlSource = "cursor_4c_Dados.ValAtu"
            .Column5.Header1.Caption   = "Venda Atual"
            .Column5.Header1.Alignment = 2
            .Column5.Header1.ForeColor = RGB(36,84,155)
            WITH .Column5.Text1
                .InputMask  = "999,999,999.99"
                .Margin     = 0
                .ReadOnly   = .T.
            ENDWITH

            *-- Column6: PVarias (Variacao %)
            .Column6.FontName      = "Tahoma"
            .Column6.FontSize      = 8
            .Column6.Width         = 80
            .Column6.Movable       = .F.
            .Column6.Resizable     = .F.
            .Column6.ReadOnly      = .T.
            .Column6.ControlSource = "cursor_4c_Dados.PVarias"
            .Column6.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
            .Column6.Header1.Alignment = 2
            .Column6.Header1.ForeColor = RGB(36,84,155)
            WITH .Column6.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .InputMask   = "999,999.99"
                .ForeColor   = RGB(0,0,0)
                .BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column7: CustoAfs (Custo Ant.)
            .Column7.FontName      = "Tahoma"
            .Column7.FontSize      = 8
            .Column7.Width         = 80
            .Column7.Movable       = .F.
            .Column7.Resizable     = .F.
            .Column7.ReadOnly      = .T.
            .Column7.ControlSource = "cursor_4c_Dados.CustoAfs"
            .Column7.Header1.Caption   = "Custo Ant."
            .Column7.Header1.Alignment = 2
            WITH .Column7.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .InputMask   = "999,999,999.9999"
                .ForeColor   = RGB(0,0,0)
                .BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column8: CustoFs (Custo Atual)
            .Column8.FontName      = "Tahoma"
            .Column8.FontSize      = 8
            .Column8.Width         = 80
            .Column8.Movable       = .F.
            .Column8.Resizable     = .F.
            .Column8.ReadOnly      = .T.
            .Column8.ControlSource = "cursor_4c_Dados.CustoFs"
            .Column8.Header1.Caption   = "Custo Atual"
            .Column8.Header1.Alignment = 2
            WITH .Column8.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .InputMask   = "999,999,999.9999"
                .ForeColor   = RGB(0,0,0)
                .BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Column9: CVarias (Variacao Custo %)
            .Column9.FontName      = "Tahoma"
            .Column9.FontSize      = 8
            .Column9.Width         = 80
            .Column9.Movable       = .F.
            .Column9.Resizable     = .F.
            .Column9.ReadOnly      = .T.
            .Column9.ControlSource = "cursor_4c_Dados.CVarias"
            .Column9.Header1.Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
            .Column9.Header1.Alignment = 2
            WITH .Column9.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .InputMask   = "999,999.99"
                .ForeColor   = RGB(0,0,0)
                .BackColor   = RGB(255,255,255)
            ENDWITH

            .Refresh
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarImagem
    *==========================================================================
        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Stretch = 1
            .Height  = 190
            .Left    = 764
            .Top     = 128
            .Width   = 223
            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
    *==========================================================================
        LOCAL loc_cIco

        loc_cIco = gc_4c_CaminhoIcones

        *-- Botao Imprimir (Left=700, Top=5)
        THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cmd_4c_Imprimir
            .Top        = 5
            .Left       = 700
            .Height     = 75
            .Width      = 60
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = loc_cIco + "geral_impressora_normal_60.jpg"
            .Caption    = "\<Imprimir"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .T.
            .Enabled    = .F.
            .Visible    = fChecaAcesso("SigPrCcp", "IMPRIMIR")
        ENDWITH

        *-- Botao Processar (Left=767, Top=5)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top        = 5
            .Left       = 767
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = loc_cIco + "geral_processar_60.jpg"
            .Caption    = "\<Processar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .T.
            .Visible    = .T.
        ENDWITH

        *-- Botao Atualizar (Left=843, Top=5)
        THIS.AddObject("cmd_4c_Atualizar", "CommandButton")
        WITH THIS.cmd_4c_Atualizar
            .Top        = 5
            .Left       = 843
            .Height     = 75
            .Width      = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .WordWrap   = .T.
            .Picture    = loc_cIco + "cadastro_salvar_60.jpg"
            .Caption    = "\<Atualizar"
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .T.
            .Enabled    = .F.
            .Visible    = .T.
        ENDWITH

        *-- Container Encerrar canonico (Left=917)
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top        = 0
            .Left       = 917
            .Height     = 85
            .Width      = 90
            .BackStyle  = 0
            .BorderWidth= 0
            .Visible    = .T.
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top        = 5
                .Left       = 917
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = loc_cIco + "cadastro_sair_60.jpg"
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90,90,90)
                .BackColor  = RGB(255,255,255)
                .Cancel     = .T.
                .Visible    = .T.
            ENDWITH
        ENDWITH

        *-- Botao Selecionar Tudo (Left=955, Top=433)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top      = 433
            .Left     = 955
            .Height   = 26
            .Width    = 26
            .Picture  = loc_cIco + "geral_marcar_26.jpg"
            .Caption  = ""
            .TabStop  = .F.
            .ToolTipText = "Selecionar Tudo"
            .Themes   = .T.
            .Visible  = .T.
        ENDWITH

        *-- Botao Desmarcar Tudo (Left=955, Top=473)
        THIS.AddObject("cmd_4c_Desmarcar", "CommandButton")
        WITH THIS.cmd_4c_Desmarcar
            .Top      = 473
            .Left     = 955
            .Height   = 26
            .Width    = 26
            .Picture  = loc_cIco + "cadastro_excluir_26.jpg"
            .Caption  = ""
            .TabStop  = .F.
            .ToolTipText = "Desmarcar Tudo"
            .Themes   = .T.
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O" AND PEMSTATUS(loc_oCtrl, "Visible", 5)
                IF !INLIST(UPPER(loc_oCtrl.Name), "IMG_4C_FIGJPG", "CNT_4C_SOMBRA", "CNT_4C_SAIDA")
                    loc_oCtrl.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
    *==========================================================================
        *-- Botoes de acao
        BINDEVENT(THIS.cmd_4c_Processar, "Click",  THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Atualizar, "Click",  THIS, "BtnAtualizarClick")
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.cmd_4c_Imprimir,  "Click",  THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmd_4c_SelTudo,   "Click",  THIS, "BtnSelTudoClick")
        BINDEVENT(THIS.cmd_4c_Desmarcar, "Click",  THIS, "BtnDesmarcarClick")

        *-- Grid
        BINDEVENT(THIS.grd_4c_Produto, "AfterRowColChange", THIS, "GrdAfterRowColChange")

        *-- Imagem
        BINDEVENT(THIS.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgDblClick")

        *-- Opc Recalc (para atualizar estado dos campos)
        BINDEVENT(THIS.opg_4c_Recalc, "InteractiveChange", THIS, "OpcRecalcMudou")

        *-- Fornecedor lookup
        BINDEVENT(THIS.txt_4c_CFornecs, "DblClick",   THIS, "AbrirBuscaFornecedor")
        BINDEVENT(THIS.txt_4c_CFornecs, "KeyPress",   THIS, "TeclaFornecedor")
        BINDEVENT(THIS.txt_4c_CFornecs, "KeyPress",  THIS, "ValidarFornecedor")

        *-- Grande Grupo lookup
        BINDEVENT(THIS.txt_4c_MercI, "DblClick",  THIS, "AbrirBuscaMercI")
        BINDEVENT(THIS.txt_4c_MercI, "KeyPress",  THIS, "TeclaMercI")
        BINDEVENT(THIS.txt_4c_MercF, "DblClick",  THIS, "AbrirBuscaMercF")
        BINDEVENT(THIS.txt_4c_MercF, "KeyPress",  THIS, "TeclaMercF")

        *-- Grupo lookup
        BINDEVENT(THIS.txt_4c_CGrui, "DblClick",  THIS, "AbrirBuscaCGrui")
        BINDEVENT(THIS.txt_4c_CGrui, "KeyPress",  THIS, "TeclaCGrui")
        BINDEVENT(THIS.txt_4c_CGruf, "DblClick",  THIS, "AbrirBuscaCGruf")
        BINDEVENT(THIS.txt_4c_CGruf, "KeyPress",  THIS, "TeclaCGruf")

        *-- Subgrupo lookup
        BINDEVENT(THIS.txt_4c_SGruI, "DblClick",  THIS, "AbrirBuscaSGruI")
        BINDEVENT(THIS.txt_4c_SGruI, "KeyPress",  THIS, "TeclaSGruI")
        BINDEVENT(THIS.txt_4c_SGruF, "DblClick",  THIS, "AbrirBuscaSGruF")
        BINDEVENT(THIS.txt_4c_SGruF, "KeyPress",  THIS, "TeclaSGruF")

        *-- Unidade lookup
        BINDEVENT(THIS.txt_4c_CUniI, "DblClick",  THIS, "AbrirBuscaCUniI")
        BINDEVENT(THIS.txt_4c_CUniI, "KeyPress",  THIS, "TeclaCUniI")
        BINDEVENT(THIS.txt_4c_CUnif, "DblClick",  THIS, "AbrirBuscaCUnif")
        BINDEVENT(THIS.txt_4c_CUnif, "KeyPress",  THIS, "TeclaCUnif")

        *-- Moeda lookup
        BINDEVENT(THIS.txt_4c_MoeI, "DblClick",  THIS, "AbrirBuscaMoeI")
        BINDEVENT(THIS.txt_4c_MoeI, "KeyPress",  THIS, "TeclaMoeI")
        BINDEVENT(THIS.txt_4c_MoeF, "DblClick",  THIS, "AbrirBuscaMoeF")
        BINDEVENT(THIS.txt_4c_MoeF, "KeyPress",  THIS, "TeclaMoeF")

        *-- Linha lookup
        BINDEVENT(THIS.txt_4c_LinhI, "DblClick",  THIS, "AbrirBuscaLinhI")
        BINDEVENT(THIS.txt_4c_LinhI, "KeyPress",  THIS, "TeclaLinhI")
        BINDEVENT(THIS.txt_4c_LinhF, "DblClick",  THIS, "AbrirBuscaLinhF")
        BINDEVENT(THIS.txt_4c_LinhF, "KeyPress",  THIS, "TeclaLinhF")

        *-- Colecao lookup
        BINDEVENT(THIS.txt_4c_ColI, "DblClick",  THIS, "AbrirBuscaColI")
        BINDEVENT(THIS.txt_4c_ColI, "KeyPress",  THIS, "TeclaColI")
        BINDEVENT(THIS.txt_4c_ColF, "DblClick",  THIS, "AbrirBuscaColF")
        BINDEVENT(THIS.txt_4c_ColF, "KeyPress",  THIS, "TeclaColF")

        *-- Feitio lookup
        BINDEVENT(THIS.txt_4c_Feitio,  "DblClick",  THIS, "AbrirBuscaFeitio")
        BINDEVENT(THIS.txt_4c_Feitio,  "KeyPress",  THIS, "TeclaFeitio")
        BINDEVENT(THIS.txt_4c_NewMkp,  "DblClick",  THIS, "AbrirBuscaNewMkp")
        BINDEVENT(THIS.txt_4c_NewMkp,  "KeyPress",  THIS, "TeclaNewMkp")

        *-- Validacoes mutuas Reajuste/NMrk/Variacao
        BINDEVENT(THIS.txt_4c_Reajuste, "KeyPress", THIS, "ValidarReajuste")
        BINDEVENT(THIS.txt_4c_NMrk,     "KeyPress", THIS, "ValidarNMrk")
        BINDEVENT(THIS.txt_4c_Variacao,  "KeyPress", THIS, "ValidarVariacao")
        BINDEVENT(THIS.txt_4c_Encargo,   "KeyPress", THIS, "ValidarEncargo")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarValores
    *==========================================================================
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * Atualiza Enabled dos campos conforme estado atual
    *==========================================================================
    PROCEDURE AtualizarEstadoCampos
        LOCAL loc_lRecalc2, loc_lReajZero
        loc_lRecalc2  = (THIS.opg_4c_Recalc.Value = 2)
        loc_lReajZero = (THIS.txt_4c_Reajuste.Value = 0)

        THIS.txt_4c_Reajuste.Enabled = !loc_lRecalc2
        THIS.txt_4c_NMrk.Enabled    = (!loc_lRecalc2) AND loc_lReajZero
        THIS.txt_4c_Variacao.Enabled = (!loc_lRecalc2) AND loc_lReajZero
        THIS.txt_4c_NewMkp.Enabled   = INLIST(THIS.opg_4c_Recalc.Value, 7, 8)
    ENDPROC

    *==========================================================================
    * HANDLERS - Botoes
    *==========================================================================
    PROCEDURE BtnProcessarClick
        LOCAL loc_lSucesso, loc_nVaria, loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        *-- Verificar reprocessamento
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?")
                RETURN
            ENDIF
        ENDIF

        *-- Limpar dados anteriores
        IF USED("cursor_4c_Dados")
            ZAP IN cursor_4c_Dados
        ENDIF

        *-- Validar NewMkp para opcoes 7 e 8
        IF INLIST(THIS.opg_4c_Recalc.Value, 7, 8) AND EMPTY(ALLTRIM(THIS.txt_4c_NewMkp.Value))
            MsgAviso("Favor Informar o Novo C" + CHR(243) + "digo do MKP!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_NewMkp.SetFocus()
            RETURN
        ENDIF

        *-- Copiar valores do form para o BO
        loc_oBO.this_cFornecs  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
        loc_oBO.this_cMercI    = ALLTRIM(THIS.txt_4c_MercI.Value)
        loc_oBO.this_cMercF    = ALLTRIM(THIS.txt_4c_MercF.Value)
        loc_oBO.this_cGruI     = ALLTRIM(THIS.txt_4c_CGrui.Value)
        loc_oBO.this_cGruF     = ALLTRIM(THIS.txt_4c_CGruf.Value)
        loc_oBO.this_cSGruI    = ALLTRIM(THIS.txt_4c_SGruI.Value)
        loc_oBO.this_cSGruF    = ALLTRIM(THIS.txt_4c_SGruF.Value)
        loc_oBO.this_cCuniI    = ALLTRIM(THIS.txt_4c_CUniI.Value)
        loc_oBO.this_cCuniF    = ALLTRIM(THIS.txt_4c_CUnif.Value)
        loc_oBO.this_cLinI     = ALLTRIM(THIS.txt_4c_LinhI.Value)
        loc_oBO.this_cLinF     = ALLTRIM(THIS.txt_4c_LinhF.Value)
        loc_oBO.this_cColI     = ALLTRIM(THIS.txt_4c_ColI.Value)
        loc_oBO.this_cColF     = ALLTRIM(THIS.txt_4c_ColF.Value)
        loc_oBO.this_cMoeI     = ALLTRIM(THIS.txt_4c_MoeI.Value)
        loc_oBO.this_cMoeF     = ALLTRIM(THIS.txt_4c_MoeF.Value)
        loc_oBO.this_nMrkI     = THIS.txt_4c_MrkI.Value
        loc_oBO.this_nMrkF     = THIS.txt_4c_MrkF.Value
        loc_oBO.this_nEncI     = THIS.txt_4c_EncI.Value
        loc_oBO.this_nEncF     = THIS.txt_4c_EncF.Value
        loc_oBO.this_cFeitio   = ALLTRIM(THIS.txt_4c_Feitio.Value)
        loc_oBO.this_nSituacao = THIS.opg_4c_Situacao.Value
        loc_oBO.this_nCompra   = THIS.opg_4c_Compra.Value
        loc_oBO.this_nFoption1 = THIS.opg_4c_OpcaoM.Value
        loc_oBO.this_nRecalc   = THIS.opg_4c_Recalc.Value
        loc_oBO.this_nReajuste = THIS.txt_4c_Reajuste.Value
        loc_oBO.this_nNMrk     = THIS.txt_4c_NMrk.Value
        loc_oBO.this_nEncargo  = THIS.txt_4c_Encargo.Value
        loc_oBO.this_nPven     = THIS.opg_4c_PVen.Value
        loc_oBO.this_cNewMkp   = ALLTRIM(THIS.txt_4c_NewMkp.Value)

        *-- Processar
        IF loc_oBO.Processar()
            *-- Filtrar por variacao
            loc_nVaria = THIS.txt_4c_Variacao.Value
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                IF loc_nVaria > 0
                    DELETE FOR PVarias < loc_nVaria
                ENDIF
                IF loc_nVaria < 0
                    DELETE FOR PVarias > loc_nVaria
                ENDIF
                SET ORDER TO CPros
                GO TOP
            ENDIF
            THIS.cmd_4c_Atualizar.Enabled = .T.
            THIS.cmd_4c_Imprimir.Enabled  = .T.
            THIS.grd_4c_Produto.Refresh
        ENDIF
    ENDPROC

    PROCEDURE BtnAtualizarClick
        THIS.this_oBusinessObject.AtualizarPrecos(.F.)
    ENDPROC

    PROCEDURE BtnEncerrarClick
        THIS.Release()
    ENDPROC

    PROCEDURE BtnImprimirClick
        DO FORM SigPrCcr
    ENDPROC

    PROCEDURE BtnSelTudoClick
        IF USED("cursor_4c_Dados")
            UPDATE cursor_4c_Dados SET lMarca = 1
            THIS.grd_4c_Produto.Refresh
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarClick
        IF USED("cursor_4c_Dados")
            UPDATE cursor_4c_Dados SET lMarca = 0
            THIS.grd_4c_Produto.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLER - OpcRecalc mudou
    *==========================================================================
    PROCEDURE OpcRecalcMudou
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * HANDLER - Grid AfterRowColChange
    *==========================================================================
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
        LOCAL loc_cCodPro, loc_cSql, loc_cArq, loc_cFoto
        loc_cCodPro = ""

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodPro = ALLTRIM(NVL(cursor_4c_Dados.CPros, ""))
        ENDIF

        THIS.img_4c_FigJpg.Visible  = .F.
        THIS.img_4c_FigJpg.Picture  = ""

        IF !EMPTY(loc_cCodPro) AND gnConnHandle > 0
            loc_cSql = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCodPro)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FigTemp") >= 1
                IF RECCOUNT("cursor_4c_FigTemp") > 0
                    SELECT cursor_4c_FigTemp
                    GO TOP
                    IF !ISNULL(cursor_4c_FigTemp.FigJpgs) AND !EMPTY(cursor_4c_FigTemp.FigJpgs)
                        loc_cArq  = SYS(2023) + "\TempCj.jpg"
                        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigTemp.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                        STRTOFILE(loc_cFoto, loc_cArq, 0)
                        THIS.img_4c_FigJpg.Picture = loc_cArq
                        THIS.img_4c_FigJpg.Visible = .T.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_FigTemp")
                    USE IN cursor_4c_FigTemp
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLER - Imagem DblClick (zoom)
    *==========================================================================
    PROCEDURE ImgFigJpgDblClick
        LOCAL loc_cArq, loc_cCodPro, loc_cSql, loc_cFoto
        loc_cArq    = SYS(2023) + "\" + SYS(2015) + ".Jpg"
        loc_cCodPro = ""

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodPro = ALLTRIM(NVL(cursor_4c_Dados.CPros, ""))
        ENDIF

        IF !EMPTY(loc_cCodPro) AND gnConnHandle > 0
            loc_cSql = "SELECT cpros, FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodPro)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FigZoom") >= 1
                IF RECCOUNT("cursor_4c_FigZoom") > 0
                    SELECT cursor_4c_FigZoom
                    GO TOP
                    IF !EMPTY(cursor_4c_FigZoom.FigJpgs) AND !ISNULL(cursor_4c_FigZoom.FigJpgs)
                        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigZoom.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                        STRTOFILE(loc_cFoto, loc_cArq, 0)
                        IF FILE(loc_cArq)
                            DO FORM SigOpZom WITH loc_cArq, ;
                                "Produto : " + loc_cCodPro + " - " + ALLTRIM(NVL(cursor_4c_FigZoom.cpros, "")), ;
                                " "
                            DELETE FILE (loc_cArq)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_FigZoom")
                    USE IN cursor_4c_FigZoom
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDADORES
    *==========================================================================
    PROCEDURE ValidarReajuste
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF THIS.txt_4c_Reajuste.Value > 0
            THIS.txt_4c_NMrk.Value = 0
            THIS.txt_4c_NMrk.Refresh
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarNMrk
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF THIS.txt_4c_NMrk.Value > 0
            THIS.txt_4c_Reajuste.Value = 0
            THIS.txt_4c_Reajuste.Refresh
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarVariacao
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF THIS.txt_4c_Variacao.Value > 0
            THIS.txt_4c_Reajuste.Value = 0
            THIS.txt_4c_Reajuste.Refresh
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarEncargo
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF THIS.txt_4c_Encargo.Value < 0
            MsgAviso("Valor Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Encargo.Value = 0
            THIS.txt_4c_Encargo.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE ValidarFornecedor
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cCod, loc_cDesc, loc_cSql
        loc_cCod  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
        loc_cDesc = ""

        IF !EMPTY(loc_cCod)
            IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cCod, .NULL., .NULL.)
                MsgAviso("Acesso Negado...", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_CFornecs.Value = ""
                THIS.txt_4c_DFornecs.Value = ""
                RETURN
            ENDIF
            *-- Buscar descricao
            IF gnConnHandle > 0
                loc_cSql = "SELECT rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod)
                IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FornTmp") >= 1
                    IF RECCOUNT("cursor_4c_FornTmp") > 0
                        SELECT cursor_4c_FornTmp
                        GO TOP
                        loc_cDesc = ALLTRIM(NVL(cursor_4c_FornTmp.rclis, ""))
                    ENDIF
                    IF USED("cursor_4c_FornTmp")
                        USE IN cursor_4c_FornTmp
                    ENDIF
                ENDIF
            ENDIF
            THIS.txt_4c_DFornecs.Value = loc_cDesc
        ELSE
            THIS.txt_4c_CFornecs.Value = ""
            THIS.txt_4c_DFornecs.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Metodos helper interno
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaGenerica(par_cTabela, par_cAlias, par_cChave, par_cValor, par_cTitulo, par_oCampo)
        LOCAL loc_oForm, loc_cDesc
        loc_cDesc = ""

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            par_cTabela, par_cAlias, par_cChave, par_cValor, par_cTitulo)

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            IF USED(par_cAlias)
                par_oCampo.Value = ALLTRIM(EVALUATE(par_cAlias + "." + par_cChave))
            ENDIF
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna(par_cChave, "", "C" + CHR(243) + "digo")
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                IF FCOUNT() > 1
                    loc_oForm.mAddColuna(FIELD(2), "", "Descri" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED(par_cAlias)
                par_oCampo.Value = ALLTRIM(EVALUATE(par_cAlias + "." + par_cChave))
            ENDIF
            ENDIF
        ENDIF

        IF USED(par_cAlias)
            USE IN (par_cAlias)
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * LOOKUPS - Fornecedor
    *==========================================================================
    PROCEDURE AbrirBuscaFornecedor
        LOCAL loc_cVal
        loc_cVal = ALLTRIM(THIS.txt_4c_CFornecs.Value)
        THIS.AbrirBuscaGenerica("SigCdCli", "cursor_4c_FornBus", "Iclis", loc_cVal, ;
            "Fornecedor", THIS.txt_4c_CFornecs)
        THIS.ValidarFornecedor()
    ENDPROC

    PROCEDURE TeclaFornecedor(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaFornecedor()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Grande Grupo
    *==========================================================================
    PROCEDURE AbrirBuscaMercI
        THIS.AbrirBuscaGenerica("SigCdGpr", "cursor_4c_MercBus", "Codigos", ;
            ALLTRIM(THIS.txt_4c_MercI.Value), "Grande Grupo", THIS.txt_4c_MercI)
    ENDPROC

    PROCEDURE TeclaMercI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMercI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMercF
        THIS.AbrirBuscaGenerica("SigCdGpr", "cursor_4c_MercBus", "Codigos", ;
            ALLTRIM(THIS.txt_4c_MercF.Value), "Grande Grupo", THIS.txt_4c_MercF)
    ENDPROC

    PROCEDURE TeclaMercF(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMercF()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Grupo
    *==========================================================================
    PROCEDURE AbrirBuscaCGrui
        THIS.AbrirBuscaGenerica("SigCdGrp", "cursor_4c_GrpBus", "CGrus", ;
            ALLTRIM(THIS.txt_4c_CGrui.Value), "Grupo", THIS.txt_4c_CGrui)
    ENDPROC

    PROCEDURE TeclaCGrui(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCGrui()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCGruf
        THIS.AbrirBuscaGenerica("SigCdGrp", "cursor_4c_GrpBus", "CGrus", ;
            ALLTRIM(THIS.txt_4c_CGruf.Value), "Grupo", THIS.txt_4c_CGruf)
    ENDPROC

    PROCEDURE TeclaCGruf(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCGruf()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Subgrupo
    *==========================================================================
    PROCEDURE AbrirBuscaSGruI
        THIS.AbrirBuscaGenerica("SigCdPsg", "cursor_4c_SgrBus", "Codigos", ;
            ALLTRIM(THIS.txt_4c_SGruI.Value), "Subgrupo", THIS.txt_4c_SGruI)
    ENDPROC

    PROCEDURE TeclaSGruI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaSGruI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaSGruF
        THIS.AbrirBuscaGenerica("SigCdPsg", "cursor_4c_SgrBus", "Codigos", ;
            ALLTRIM(THIS.txt_4c_SGruF.Value), "Subgrupo", THIS.txt_4c_SGruF)
    ENDPROC

    PROCEDURE TeclaSGruF(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaSGruF()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Unidade
    *==========================================================================
    PROCEDURE AbrirBuscaCUniI
        THIS.AbrirBuscaGenerica("SigCdUni", "cursor_4c_UniBus", "CUnis", ;
            ALLTRIM(THIS.txt_4c_CUniI.Value), "Unidade", THIS.txt_4c_CUniI)
    ENDPROC

    PROCEDURE TeclaCUniI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCUniI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCUnif
        THIS.AbrirBuscaGenerica("SigCdUni", "cursor_4c_UniBus", "CUnis", ;
            ALLTRIM(THIS.txt_4c_CUnif.Value), "Unidade", THIS.txt_4c_CUnif)
    ENDPROC

    PROCEDURE TeclaCUnif(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCUnif()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Linha
    *==========================================================================
    PROCEDURE AbrirBuscaLinhI
        THIS.AbrirBuscaGenerica("SigCdLin", "cursor_4c_LinBus", "Linhas", ;
            ALLTRIM(THIS.txt_4c_LinhI.Value), "Linha", THIS.txt_4c_LinhI)
    ENDPROC

    PROCEDURE TeclaLinhI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaLinhI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaLinhF
        THIS.AbrirBuscaGenerica("SigCdLin", "cursor_4c_LinBus", "Linhas", ;
            ALLTRIM(THIS.txt_4c_LinhF.Value), "Linha", THIS.txt_4c_LinhF)
    ENDPROC

    PROCEDURE TeclaLinhF(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaLinhF()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Colecao
    *==========================================================================
    PROCEDURE AbrirBuscaColI
        THIS.AbrirBuscaGenerica("SigCdCol", "cursor_4c_ColBus", "Colecoes", ;
            ALLTRIM(THIS.txt_4c_ColI.Value), "Cole" + CHR(231) + CHR(227) + "o", THIS.txt_4c_ColI)
    ENDPROC

    PROCEDURE TeclaColI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaColI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaColF
        THIS.AbrirBuscaGenerica("SigCdCol", "cursor_4c_ColBus", "Colecoes", ;
            ALLTRIM(THIS.txt_4c_ColF.Value), "Cole" + CHR(231) + CHR(227) + "o", THIS.txt_4c_ColF)
    ENDPROC

    PROCEDURE TeclaColF(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaColF()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Moeda
    *==========================================================================
    PROCEDURE AbrirBuscaMoeI
        THIS.AbrirBuscaGenerica("SigCdMoe", "cursor_4c_MoeBus", "CMoes", ;
            ALLTRIM(THIS.txt_4c_MoeI.Value), "Moeda", THIS.txt_4c_MoeI)
    ENDPROC

    PROCEDURE TeclaMoeI(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeI()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoeF
        THIS.AbrirBuscaGenerica("SigCdMoe", "cursor_4c_MoeBus", "CMoes", ;
            ALLTRIM(THIS.txt_4c_MoeF.Value), "Moeda", THIS.txt_4c_MoeF)
    ENDPROC

    PROCEDURE TeclaMoeF(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeF()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Feitio (MKP atual)
    *==========================================================================
    PROCEDURE AbrirBuscaFeitio
        LOCAL loc_oForm, loc_cVal, loc_cSql
        loc_cVal = ALLTRIM(THIS.txt_4c_Feitio.Value)

        IF gnConnHandle > 0
            loc_cSql = "SELECT Cods, Descs, Moedas, Acrescs FROM SigPrFti"
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FtiBus") >= 1
                IF !USED("cursor_4c_FtiBus")
                    RETURN
                ENDIF
                SELECT cursor_4c_FtiBus
                INDEX ON Cods TAG Cods ADDITIVE

                IF !SEEK(loc_cVal, "cursor_4c_FtiBus", "Cods")
                    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigPrFti", "cursor_4c_FtiBus2", "Cods", loc_cVal, "Feitios")
                    IF !ISNULL(loc_oForm)
                        loc_oForm.mAddColuna("Cods",  "", "Cod")
                        loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oForm.Show()
                        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_FtiBus2")
                            THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_FtiBus2.Cods)
                        ENDIF
                        IF USED("cursor_4c_FtiBus2")
                            USE IN cursor_4c_FtiBus2
                        ENDIF
                        loc_oForm.Release()
                    ENDIF
                ELSE
                    THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_FtiBus.Cods)
                ENDIF

                IF USED("cursor_4c_FtiBus")
                    USE IN cursor_4c_FtiBus
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaFeitio(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaFeitio()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - Novo MKP (opcoes 7 e 8)
    *==========================================================================
    PROCEDURE AbrirBuscaNewMkp
        LOCAL loc_oForm, loc_cVal, loc_cSql
        loc_cVal = ALLTRIM(THIS.txt_4c_NewMkp.Value)

        IF gnConnHandle > 0
            loc_cSql = "SELECT Cods, Descs, Moedas, Acrescs FROM SigPrFti WHERE Tipos = 1"
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_MkpBus") >= 1
                IF !USED("cursor_4c_MkpBus")
                    RETURN
                ENDIF
                SELECT cursor_4c_MkpBus
                INDEX ON Cods TAG Cods ADDITIVE

                IF !SEEK(loc_cVal, "cursor_4c_MkpBus", "Cods")
                    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigPrFti", "cursor_4c_MkpBus2", "Cods", loc_cVal, "Feitios")
                    IF !ISNULL(loc_oForm)
                        loc_oForm.mAddColuna("Cods",  "", "Cod")
                        loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oForm.Show()
                        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_MkpBus2")
                            THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_MkpBus2.Cods)
                        ENDIF
                        IF USED("cursor_4c_MkpBus2")
                            USE IN cursor_4c_MkpBus2
                        ENDIF
                        loc_oForm.Release()
                    ENDIF
                ELSE
                    THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_MkpBus.Cods)
                ENDIF

                IF USED("cursor_4c_MkpBus")
                    USE IN cursor_4c_MkpBus
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaNewMkp(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaNewMkp()
        ENDIF
    ENDPROC

    *==========================================================================
    * Overrides de FormBase: CRUD nao se aplica a este form OPERACIONAL.
    * Estes metodos existem para evitar "file not found" se FormBase os
    * chamar via KeyPreview (F2/F3/F4/F5).
    *==========================================================================
    PROCEDURE BtnIncluirClick
        RETURN
    ENDPROC

    PROCEDURE BtnAlterarClick
        RETURN
    ENDPROC

    PROCEDURE BtnVisualizarClick
        RETURN
    ENDPROC

    PROCEDURE BtnExcluirClick
        RETURN
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL com layout flat, sem paginacao
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Override de FormBase (form OPERACIONAL nao tem Buscar)
    *==========================================================================
    PROCEDURE BtnBuscarClick
        RETURN
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Override de FormBase. Em OPERACIONAL o "salvar" equivale
    * a aplicar as alteracoes de preco calculadas (AtualizarPrecos).
    *==========================================================================
    PROCEDURE BtnSalvarClick
        THIS.this_oBusinessObject.AtualizarPrecos(.F.)
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Override de FormBase. Cancela: limpa cursor, zera
    * campos calculados e volta ao estado inicial de captura.
    *==========================================================================
    PROCEDURE BtnCancelarClick
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            ZAP
            THIS.grd_4c_Produto.Refresh
        ENDIF
        THIS.this_oBusinessObject.this_lProcessado = .F.
        THIS.cmd_4c_Atualizar.Enabled = .F.
        THIS.cmd_4c_Imprimir.Enabled  = .F.
    ENDPROC

    *==========================================================================
    * CarregarLista - Override de FormBase (form OPERACIONAL nao tem lista CRUD)
    *==========================================================================
    PROCEDURE CarregarLista
        RETURN
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Override de FormBase. Em OPERACIONAL o controle
    * de estado dos botoes eh feito por AtualizarEstadoCampos() em funcao do
    * flag this_lProcessado do BO.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita TODOS os campos de captura em
    * funcao do estado do processamento. Enquanto lProcessado = .F., filtros
    * e opcoes ficam habilitados para permitir configurar antes de "Processar".
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lEnabled

        IF PCOUNT() < 1
            loc_lEnabled = .T.
        ELSE
            loc_lEnabled = par_lHabilitar
        ENDIF

        *-- Fornecedor
        THIS.txt_4c_CFornecs.Enabled = loc_lEnabled
        THIS.txt_4c_DFornecs.Enabled = .F.  && sempre readonly (descricao)

        *-- Grande Grupo (MercI/MercF)
        THIS.txt_4c_MercI.Enabled = loc_lEnabled
        THIS.txt_4c_MercF.Enabled = loc_lEnabled

        *-- Grupo
        THIS.txt_4c_CGrui.Enabled = loc_lEnabled
        THIS.txt_4c_CGruf.Enabled = loc_lEnabled

        *-- Subgrupo
        THIS.txt_4c_SGruI.Enabled = loc_lEnabled
        THIS.txt_4c_SGruF.Enabled = loc_lEnabled

        *-- Unidade
        THIS.txt_4c_CUniI.Enabled = loc_lEnabled
        THIS.txt_4c_CUnif.Enabled = loc_lEnabled

        *-- Linha
        THIS.txt_4c_LinhI.Enabled = loc_lEnabled
        THIS.txt_4c_LinhF.Enabled = loc_lEnabled

        *-- Colecao
        THIS.txt_4c_ColI.Enabled = loc_lEnabled
        THIS.txt_4c_ColF.Enabled = loc_lEnabled

        *-- Moeda
        THIS.txt_4c_MoeI.Enabled = loc_lEnabled
        THIS.txt_4c_MoeF.Enabled = loc_lEnabled

        *-- Markup
        THIS.txt_4c_MrkI.Enabled = loc_lEnabled
        THIS.txt_4c_MrkF.Enabled = loc_lEnabled

        *-- Encargo (filtro)
        THIS.txt_4c_EncI.Enabled = loc_lEnabled
        THIS.txt_4c_EncF.Enabled = loc_lEnabled

        *-- Variacao (filtro pos-processamento)
        THIS.txt_4c_Variacao.Enabled = loc_lEnabled

        *-- Feitio (Codigo MKP atual)
        THIS.txt_4c_Feitio.Enabled = loc_lEnabled

        *-- Situacao / Compra / OpcaoM (opcoes gerais)
        THIS.opg_4c_Situacao.Enabled = loc_lEnabled
        THIS.opg_4c_Compra.Enabled   = loc_lEnabled
        THIS.opg_4c_OpcaoM.Enabled   = loc_lEnabled

        *-- Recalcula
        THIS.opg_4c_Recalc.Enabled = loc_lEnabled

        *-- Atualiza Val.Venda
        THIS.opg_4c_PVen.Enabled = loc_lEnabled

        *-- Reajuste/NMrk/Encargo/NewMkp: estado controlado por AtualizarEstadoCampos
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera todos os campos de captura e o cursor de resultados.
    *==========================================================================
    PROCEDURE LimparCampos
        *-- Fornecedor
        THIS.txt_4c_CFornecs.Value = ""
        THIS.txt_4c_DFornecs.Value = ""

        *-- Grande Grupo
        THIS.txt_4c_MercI.Value = ""
        THIS.txt_4c_MercF.Value = ""

        *-- Grupo
        THIS.txt_4c_CGrui.Value = ""
        THIS.txt_4c_CGruf.Value = ""

        *-- Subgrupo
        THIS.txt_4c_SGruI.Value = ""
        THIS.txt_4c_SGruF.Value = ""

        *-- Unidade
        THIS.txt_4c_CUniI.Value = ""
        THIS.txt_4c_CUnif.Value = ""

        *-- Linha
        THIS.txt_4c_LinhI.Value = ""
        THIS.txt_4c_LinhF.Value = ""

        *-- Colecao
        THIS.txt_4c_ColI.Value = ""
        THIS.txt_4c_ColF.Value = ""

        *-- Moeda
        THIS.txt_4c_MoeI.Value = ""
        THIS.txt_4c_MoeF.Value = ""

        *-- Markup
        THIS.txt_4c_MrkI.Value = 0
        THIS.txt_4c_MrkF.Value = 0

        *-- Encargo (filtro)
        THIS.txt_4c_EncI.Value = 0
        THIS.txt_4c_EncF.Value = 0

        *-- Variacao
        THIS.txt_4c_Variacao.Value = 0

        *-- Feitio / NewMkp
        THIS.txt_4c_Feitio.Value = ""
        THIS.txt_4c_NewMkp.Value = ""

        *-- Novos parametros de recalculo
        THIS.txt_4c_Reajuste.Value = 0
        THIS.txt_4c_NMrk.Value     = 0
        THIS.txt_4c_Encargo.Value  = 0

        *-- Opcoes: valores default do legado
        THIS.opg_4c_Situacao.Value = 1  && 1 = Ativos
        THIS.opg_4c_Compra.Value   = 3  && 3 = Todos
        THIS.opg_4c_OpcaoM.Value   = 1
        THIS.opg_4c_Recalc.Value   = 1  && 1 = Reajuste
        THIS.opg_4c_PVen.Value     = 2  && 2 = Nao

        *-- Cursor de resultados
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            ZAP
            THIS.grd_4c_Produto.Refresh
        ENDIF

        *-- Imagem
        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""

        *-- Reset do estado de processamento
        THIS.this_oBusinessObject.this_lProcessado = .F.
        THIS.cmd_4c_Atualizar.Enabled = .F.
        THIS.cmd_4c_Imprimir.Enabled  = .F.

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia TODOS os valores dos controles do form para o BO
    * antes de qualquer operacao (Processar, AtualizarPrecos).
    *==========================================================================
    PROCEDURE FormParaBO
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        *-- Fornecedor
        loc_oBO.this_cFornecs  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
        loc_oBO.this_cDFornecs = ALLTRIM(THIS.txt_4c_DFornecs.Value)

        *-- Grande Grupo (MercI/MercF)
        loc_oBO.this_cMercI = ALLTRIM(THIS.txt_4c_MercI.Value)
        loc_oBO.this_cMercF = ALLTRIM(THIS.txt_4c_MercF.Value)

        *-- Grupo
        loc_oBO.this_cGruI = ALLTRIM(THIS.txt_4c_CGrui.Value)
        loc_oBO.this_cGruF = ALLTRIM(THIS.txt_4c_CGruf.Value)

        *-- Subgrupo
        loc_oBO.this_cSGruI = ALLTRIM(THIS.txt_4c_SGruI.Value)
        loc_oBO.this_cSGruF = ALLTRIM(THIS.txt_4c_SGruF.Value)

        *-- Unidade
        loc_oBO.this_cCuniI = ALLTRIM(THIS.txt_4c_CUniI.Value)
        loc_oBO.this_cCuniF = ALLTRIM(THIS.txt_4c_CUnif.Value)

        *-- Linha
        loc_oBO.this_cLinI = ALLTRIM(THIS.txt_4c_LinhI.Value)
        loc_oBO.this_cLinF = ALLTRIM(THIS.txt_4c_LinhF.Value)

        *-- Colecao
        loc_oBO.this_cColI = ALLTRIM(THIS.txt_4c_ColI.Value)
        loc_oBO.this_cColF = ALLTRIM(THIS.txt_4c_ColF.Value)

        *-- Moeda
        loc_oBO.this_cMoeI = ALLTRIM(THIS.txt_4c_MoeI.Value)
        loc_oBO.this_cMoeF = ALLTRIM(THIS.txt_4c_MoeF.Value)

        *-- Markup
        loc_oBO.this_nMrkI = THIS.txt_4c_MrkI.Value
        loc_oBO.this_nMrkF = THIS.txt_4c_MrkF.Value

        *-- Encargo (filtro)
        loc_oBO.this_nEncI = THIS.txt_4c_EncI.Value
        loc_oBO.this_nEncF = THIS.txt_4c_EncF.Value

        *-- Variacao (filtro pos-processamento)
        loc_oBO.this_nVariacao = THIS.txt_4c_Variacao.Value

        *-- Codigo MKP atual / novo
        loc_oBO.this_cFeitio = ALLTRIM(THIS.txt_4c_Feitio.Value)
        loc_oBO.this_cNewMkp = ALLTRIM(THIS.txt_4c_NewMkp.Value)

        *-- Parametros de recalculo
        loc_oBO.this_nReajuste = THIS.txt_4c_Reajuste.Value
        loc_oBO.this_nNMrk     = THIS.txt_4c_NMrk.Value
        loc_oBO.this_nEncargo  = THIS.txt_4c_Encargo.Value

        *-- Opcoes
        loc_oBO.this_nSituacao = THIS.opg_4c_Situacao.Value
        loc_oBO.this_nCompra   = THIS.opg_4c_Compra.Value
        loc_oBO.this_nFoption1 = THIS.opg_4c_OpcaoM.Value
        loc_oBO.this_nRecalc   = THIS.opg_4c_Recalc.Value
        loc_oBO.this_nPven     = THIS.opg_4c_PVen.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Reflete TODAS as propriedades do BO nos controles do form.
    * Usado apos carga de configuracao inicial (crSigCdCcp do legado).
    *==========================================================================
    PROCEDURE BOParaForm
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        *-- Fornecedor
        THIS.txt_4c_CFornecs.Value = loc_oBO.this_cFornecs
        THIS.txt_4c_DFornecs.Value = loc_oBO.this_cDFornecs

        *-- Grande Grupo
        THIS.txt_4c_MercI.Value = loc_oBO.this_cMercI
        THIS.txt_4c_MercF.Value = loc_oBO.this_cMercF

        *-- Grupo
        THIS.txt_4c_CGrui.Value = loc_oBO.this_cGruI
        THIS.txt_4c_CGruf.Value = loc_oBO.this_cGruF

        *-- Subgrupo
        THIS.txt_4c_SGruI.Value = loc_oBO.this_cSGruI
        THIS.txt_4c_SGruF.Value = loc_oBO.this_cSGruF

        *-- Unidade
        THIS.txt_4c_CUniI.Value = loc_oBO.this_cCuniI
        THIS.txt_4c_CUnif.Value = loc_oBO.this_cCuniF

        *-- Linha
        THIS.txt_4c_LinhI.Value = loc_oBO.this_cLinI
        THIS.txt_4c_LinhF.Value = loc_oBO.this_cLinF

        *-- Colecao
        THIS.txt_4c_ColI.Value = loc_oBO.this_cColI
        THIS.txt_4c_ColF.Value = loc_oBO.this_cColF

        *-- Moeda
        THIS.txt_4c_MoeI.Value = loc_oBO.this_cMoeI
        THIS.txt_4c_MoeF.Value = loc_oBO.this_cMoeF

        *-- Markup
        THIS.txt_4c_MrkI.Value = loc_oBO.this_nMrkI
        THIS.txt_4c_MrkF.Value = loc_oBO.this_nMrkF

        *-- Encargo (filtro)
        THIS.txt_4c_EncI.Value = loc_oBO.this_nEncI
        THIS.txt_4c_EncF.Value = loc_oBO.this_nEncF

        *-- Variacao
        THIS.txt_4c_Variacao.Value = loc_oBO.this_nVariacao

        *-- Codigo MKP atual / novo
        THIS.txt_4c_Feitio.Value = loc_oBO.this_cFeitio
        THIS.txt_4c_NewMkp.Value = loc_oBO.this_cNewMkp

        *-- Parametros de recalculo
        THIS.txt_4c_Reajuste.Value = loc_oBO.this_nReajuste
        THIS.txt_4c_NMrk.Value     = loc_oBO.this_nNMrk
        THIS.txt_4c_Encargo.Value  = loc_oBO.this_nEncargo

        *-- Opcoes
        THIS.opg_4c_Situacao.Value = loc_oBO.this_nSituacao
        THIS.opg_4c_Compra.Value   = loc_oBO.this_nCompra
        THIS.opg_4c_OpcaoM.Value   = loc_oBO.this_nFoption1
        THIS.opg_4c_Recalc.Value   = loc_oBO.this_nRecalc
        THIS.opg_4c_PVen.Value     = loc_oBO.this_nPven

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        DODEFAULT()
    ENDPROC

ENDDEFINE
