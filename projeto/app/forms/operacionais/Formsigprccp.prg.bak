*==============================================================================
* Formsigprccp.prg - Formulario OPERACIONAL: Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os
* Equivalente ao sigprccp.SCX do legado
* Herda de FormBase
*==============================================================================

DEFINE CLASS Formsigprccp AS FormBase

    Width       = 1000
    Height      = 600
    Caption     = "Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os"
    ShowWindow  = 1
    WindowType  = 1
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    AutoCenter  = .T.
    BorderStyle = 2
    Themes      = .F.
    DataSession = 2

    this_lAutomatico = .F.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.Picture    = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.ConfigurarPageFrame()

            THIS.this_oBusinessObject = CREATEOBJECT("sigprccpBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar sigprccpBO.", "Erro InicializarForm")
            ELSE
                IF !THIS.this_oBusinessObject.InicializarCursores()
                    MsgErro("Falha ao inicializar cursores.", "Erro InicializarForm")
                ELSE
                    THIS.ConfigurarCabecalho()
                    THIS.ConfigurarBotoes()
                    THIS.ConfigurarFiltros()
                    THIS.ConfigurarDados()
                    THIS.ConfigurarGrade()

                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                    BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnProcessarClick")
                    BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnAtualizarClick")
                    BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnEncerrarClick")
                    BINDEVENT(THIS.cmd_4c_Imprimir,          "Click", THIS, "BtnImprimirClick")
                    BINDEVENT(THIS.cmd_4c_SelTudo,           "Click", THIS, "BtnSelTudoClick")
                    BINDEVENT(THIS.cmd_4c_Desmarcar,         "Click", THIS, "BtnDesmarcarClick")

                    BINDEVENT(THIS.opt_4c_Recalc, "InteractiveChange", THIS, "OptRecalcChange")

                    BINDEVENT(THIS.txt_4c_CFornecs, "KeyPress", THIS, "TxtCFornecKeyPress")
                    BINDEVENT(THIS.txt_4c_MercI,   "KeyPress", THIS, "TxtMercIKeyPress")
                    BINDEVENT(THIS.txt_4c_MercF,   "KeyPress", THIS, "TxtMercFKeyPress")
                    BINDEVENT(THIS.txt_4c_CGrui,   "KeyPress", THIS, "TxtCGruiKeyPress")
                    BINDEVENT(THIS.txt_4c_CGruf,   "KeyPress", THIS, "TxtCGrufKeyPress")
                    BINDEVENT(THIS.txt_4c_SgruI,   "KeyPress", THIS, "TxtSgruIKeyPress")
                    BINDEVENT(THIS.txt_4c_SgruF,   "KeyPress", THIS, "TxtSgruFKeyPress")
                    BINDEVENT(THIS.txt_4c_CUnii,   "KeyPress", THIS, "TxtCUniiKeyPress")
                    BINDEVENT(THIS.txt_4c_CUnif,   "KeyPress", THIS, "TxtCUnifKeyPress")
                    BINDEVENT(THIS.txt_4c_Lini,    "KeyPress", THIS, "TxtLiniKeyPress")
                    BINDEVENT(THIS.txt_4c_Linf,    "KeyPress", THIS, "TxtLinfKeyPress")
                    BINDEVENT(THIS.txt_4c_Coli,    "KeyPress", THIS, "TxtColiKeyPress")
                    BINDEVENT(THIS.txt_4c_Colf,    "KeyPress", THIS, "TxtColfKeyPress")
                    BINDEVENT(THIS.txt_4c_Moedai,  "KeyPress", THIS, "TxtMoedaiKeyPress")
                    BINDEVENT(THIS.txt_4c_Moedaf,  "KeyPress", THIS, "TxtMoedafKeyPress")
                    BINDEVENT(THIS.txt_4c_Feitio,  "KeyPress", THIS, "TxtFeitioKeyPress")
                    BINDEVENT(THIS.txt_4c_NewMkp,  "KeyPress", THIS, "TxtNewMkpKeyPress")
                    BINDEVENT(THIS.txt_4c_Reajuste,"KeyPress", THIS, "TxtReajusteKeyPress")
                    BINDEVENT(THIS.txt_4c_NMrk,    "KeyPress", THIS, "TxtNMrkKeyPress")
                    BINDEVENT(THIS.txt_4c_Encargo, "KeyPress", THIS, "TxtEncargoKeyPress")

                    BINDEVENT(THIS.grd_4c_Produto, "AfterRowColChange", THIS, "GrdAfterRowColChange")

                    THIS.TornarControlesVisiveis(THIS)

                    THIS.opt_4c_Compra.Value   = 3
                    THIS.opt_4c_Pven.Value     = 2

                    THIS.OptRecalcChange()

                    THIS.txt_4c_CFornecs.SetFocus()

                    IF THIS.this_lAutomatico
                        THIS.this_oBusinessObject.ProcessaAutomatico()
                        THIS.Release()
                        loc_lSucesso = .T.
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm Formsigprccp")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
    *==========================================================================
        *-- CommandGroup: Processar / Atualizar / Encerrar
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Top           = 0
            .Left          = 770
            .Width         = 235
            .Height        = 85

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .Caption    = "Processar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Caption    = "Atualizar"
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Enabled    = .F.
            ENDWITH

            WITH .Buttons(3)
                .Top        = 5
                .Left       = 155
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Caption    = "Encerrar"
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
            ENDWITH
        ENDWITH

        *-- Botao Imprimir (standalone, inicia desabilitado)
        THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cmd_4c_Imprimir
            .Top         = 3
            .Left        = 700
            .Width       = 65
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Caption     = "Imprimir"
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .Enabled     = .F.
        ENDWITH

        *-- Botoes de selecao ao lado do grid
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 433
            .Left        = 955
            .Width       = 26
            .Height      = 26
            .Caption     = ""
            .Themes      = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .ToolTipText = "Selecionar Tudo"
            .TabStop     = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_Desmarcar", "CommandButton")
        WITH THIS.cmd_4c_Desmarcar
            .Top         = 473
            .Left        = 955
            .Width       = 26
            .Height      = 26
            .Caption     = ""
            .Themes      = .T.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Desmarcar Tudo"
            .TabStop     = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros()
    *==========================================================================
        *-- Label secao Filtros
        THIS.AddObject("lbl_4c_SecFiltros", "Label")
        WITH THIS.lbl_4c_SecFiltros
            .Top       = 94
            .Left      = 11
            .Width     = 53
            .Height    = 21
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .BackStyle = 0
            .Caption   = "Filtros"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Linha separadora abaixo dos filtros
        THIS.AddObject("lne_4c_Sep", "Line")
        WITH THIS.lne_4c_Sep
            .Top    = 258
            .Left   = 13
            .Height = 0
            .Width  = 738
        ENDWITH

        *-- Fornecedor
        THIS.AddObject("lbl_4c_Fornecedor", "Label")
        WITH THIS.lbl_4c_Fornecedor
            .Top       = 92
            .Left      = 79
            .Width     = 64
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Fornecedor :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CFornecs", "TextBox")
        WITH THIS.txt_4c_CFornecs
            .Top           = 88
            .Left          = 145
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .Format        = "K!"
            .Value         = ""
        ENDWITH

        THIS.AddObject("txt_4c_DFornecs", "TextBox")
        WITH THIS.txt_4c_DFornecs
            .Top           = 88
            .Left          = 228
            .Width         = 197
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 40
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Value         = ""
        ENDWITH

        *-- Linha (direita)
        THIS.AddObject("lbl_4c_Linha", "Label")
        WITH THIS.lbl_4c_Linha
            .Top       = 92
            .Left      = 503
            .Width     = 34
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Linha :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Lini", "TextBox")
        WITH THIS.txt_4c_Lini
            .Top           = 88
            .Left          = 539
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .Format        = "K"
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_LinhaAte", "Label")
        WITH THIS.lbl_4c_LinhaAte
            .Top       = 92
            .Left      = 627
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Linf", "TextBox")
        WITH THIS.txt_4c_Linf
            .Top           = 88
            .Left          = 649
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .Format        = "K"
            .Value         = ""
        ENDWITH

        *-- Grande Grupo (esquerda)
        THIS.AddObject("lbl_4c_GrGrupo", "Label")
        WITH THIS.lbl_4c_GrGrupo
            .Top       = 117
            .Left      = 67
            .Width     = 76
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grande Grupo :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_MercI", "TextBox")
        WITH THIS.txt_4c_MercI
            .Top           = 113
            .Left          = 145
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_GrGrupoAte", "Label")
        WITH THIS.lbl_4c_GrGrupoAte
            .Top       = 117
            .Left      = 179
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_MercF", "TextBox")
        WITH THIS.txt_4c_MercF
            .Top           = 113
            .Left          = 198
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Grupo Venda/Colecao (direita)
        THIS.AddObject("lbl_4c_GrupoVenda", "Label")
        WITH THIS.lbl_4c_GrupoVenda
            .Top       = 117
            .Left      = 466
            .Width     = 71
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo Venda :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Coli", "TextBox")
        WITH THIS.txt_4c_Coli
            .Top           = 113
            .Left          = 539
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .Format        = "K"
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_ColiAte", "Label")
        WITH THIS.lbl_4c_ColiAte
            .Top       = 117
            .Left      = 627
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Colf", "TextBox")
        WITH THIS.txt_4c_Colf
            .Top           = 113
            .Left          = 649
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .Format        = "K"
            .Value         = ""
        ENDWITH

        *-- Grupo (esquerda)
        THIS.AddObject("lbl_4c_Grupo", "Label")
        WITH THIS.lbl_4c_Grupo
            .Top       = 142
            .Left      = 105
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CGrui", "TextBox")
        WITH THIS.txt_4c_CGrui
            .Top           = 138
            .Left          = 145
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_GrupoAte", "Label")
        WITH THIS.lbl_4c_GrupoAte
            .Top       = 142
            .Left      = 179
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CGruf", "TextBox")
        WITH THIS.txt_4c_CGruf
            .Top           = 138
            .Left          = 198
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Markup (direita)
        THIS.AddObject("lbl_4c_Markup", "Label")
        WITH THIS.lbl_4c_Markup
            .Top       = 142
            .Left      = 493
            .Width     = 44
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Markup :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Mrki", "TextBox")
        WITH THIS.txt_4c_Mrki
            .Top           = 138
            .Left          = 539
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        THIS.AddObject("lbl_4c_MarkupAte", "Label")
        WITH THIS.lbl_4c_MarkupAte
            .Top       = 142
            .Left      = 627
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Mrkf", "TextBox")
        WITH THIS.txt_4c_Mrkf
            .Top           = 138
            .Left          = 649
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        *-- Subgrupo (esquerda)
        THIS.AddObject("lbl_4c_Subgrupo", "Label")
        WITH THIS.lbl_4c_Subgrupo
            .Top       = 167
            .Left      = 88
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Subgrupo :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_SgruI", "TextBox")
        WITH THIS.txt_4c_SgruI
            .Top           = 163
            .Left          = 145
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_SubgrupoAte", "Label")
        WITH THIS.lbl_4c_SubgrupoAte
            .Top       = 167
            .Left      = 201
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_SgruF", "TextBox")
        WITH THIS.txt_4c_SgruF
            .Top           = 163
            .Left          = 220
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Encargo (direita)
        THIS.AddObject("lbl_4c_EncFiltro", "Label")
        WITH THIS.lbl_4c_EncFiltro
            .Top       = 167
            .Left      = 486
            .Width     = 51
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Encargo :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_EncI", "TextBox")
        WITH THIS.txt_4c_EncI
            .Top           = 163
            .Left          = 539
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        THIS.AddObject("lbl_4c_EncAte", "Label")
        WITH THIS.lbl_4c_EncAte
            .Top       = 167
            .Left      = 627
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_EncF", "TextBox")
        WITH THIS.txt_4c_EncF
            .Top           = 163
            .Left          = 649
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        *-- Unidade (esquerda)
        THIS.AddObject("lbl_4c_Unidade", "Label")
        WITH THIS.lbl_4c_Unidade
            .Top       = 193
            .Left      = 95
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Unidade :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CUnii", "TextBox")
        WITH THIS.txt_4c_CUnii
            .Top           = 189
            .Left          = 145
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_UnidadeAte", "Label")
        WITH THIS.lbl_4c_UnidadeAte
            .Top       = 193
            .Left      = 179
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CUnif", "TextBox")
        WITH THIS.txt_4c_CUnif
            .Top           = 189
            .Left          = 198
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Variacao e Feitio (direita)
        THIS.AddObject("lbl_4c_Variacao", "Label")
        WITH THIS.lbl_4c_Variacao
            .Top       = 193
            .Left      = 456
            .Width     = 81
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o ( % ) : "
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Variacao", "TextBox")
        WITH THIS.txt_4c_Variacao
            .Top           = 189
            .Left          = 539
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        THIS.AddObject("lbl_4c_CodMKP", "Label")
        WITH THIS.lbl_4c_CodMKP
            .Top       = 193
            .Left      = 639
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "C" + CHR(243) + "digo MKP : "
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Feitio", "TextBox")
        WITH THIS.txt_4c_Feitio
            .Top           = 189
            .Left          = 709
            .Width         = 24
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 2
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Tipo Moeda (centro)
        THIS.AddObject("opt_4c_TipoMoeda", "OptionGroup")
        WITH THIS.opt_4c_TipoMoeda
            .Top         = 211
            .Left        = 234
            .Width       = 106
            .Height      = 26
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            WITH .Buttons(1)
                .Caption  = "Ideal"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left     = 5
                .Top      = 5
                .AutoSize = .T.
                .Themes   = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "Venda"
                .FontName        = "Comic Sans MS"
                .Left     = 53
                .Top      = 6
                .AutoSize = .T.
                .FontSize = 8
                .Themes   = .F.
            ENDWITH
        ENDWITH

        *-- Moeda (esquerda)
        THIS.AddObject("lbl_4c_Moeda", "Label")
        WITH THIS.lbl_4c_Moeda
            .Top       = 217
            .Left      = 102
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Moeda :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Moedai", "TextBox")
        WITH THIS.txt_4c_Moedai
            .Top           = 213
            .Left          = 145
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_MoedaAte", "Label")
        WITH THIS.lbl_4c_MoedaAte
            .Top       = 217
            .Left      = 179
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Moedaf", "TextBox")
        WITH THIS.txt_4c_Moedaf
            .Top           = 213
            .Left          = 198
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Situacao (direita)
        THIS.AddObject("lbl_4c_Situacao", "Label")
        WITH THIS.lbl_4c_Situacao
            .Top       = 217
            .Left      = 486
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("opt_4c_Situacao", "OptionGroup")
        WITH THIS.opt_4c_Situacao
            .Top         = 214
            .Left        = 536
            .Width       = 189
            .Height      = 21
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            WITH .Buttons(1)
                .Caption       = "Ativos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left          = 5
                .Top           = 3
                .AutoSize      = .T.
                .SpecialEffect = 0
                .Themes        = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption       = "Inativos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left          = 59
                .Top           = 2
                .AutoSize      = .F.
                .SpecialEffect = 0
                .Themes        = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption       = "Todos"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left          = 125
                .Top           = 2
                .Width         = 61
                .Height        = 17
                .AutoSize      = .F.
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .Themes        = .F.
            ENDWITH
        ENDWITH

        *-- Compra (direita)
        THIS.AddObject("lbl_4c_Compra", "Label")
        WITH THIS.lbl_4c_Compra
            .Top       = 237
            .Left      = 490
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Compra :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("opt_4c_Compra", "OptionGroup")
        WITH THIS.opt_4c_Compra
            .Top         = 234
            .Left        = 536
            .Width       = 204
            .Height      = 21
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3

            WITH .Buttons(1)
                .Caption  = "Comprar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left     = 5
                .Top      = 3
                .AutoSize = .T.
                .Themes   = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "N" + CHR(227) + "o Comprar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left     = 67
                .Top      = 3
                .AutoSize = .T.
                .Themes   = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Todos"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left      = 152
                .Top       = 2
                .Width     = 61
                .Height    = 17
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDados()
    *==========================================================================
        *-- Label secao Dados
        THIS.AddObject("lbl_4c_SecDados", "Label")
        WITH THIS.lbl_4c_SecDados
            .Top       = 270
            .Left      = 12
            .Width     = 52
            .Height    = 21
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .BackStyle = 0
            .Caption   = "Dados"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Recalcula (8 opcoes em 2 linhas)
        THIS.AddObject("lbl_4c_Recalcula", "Label")
        WITH THIS.lbl_4c_Recalcula
            .Top       = 263
            .Left      = 89
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Recalcula :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("opt_4c_Recalc", "OptionGroup")
        WITH THIS.opt_4c_Recalc
            .Top         = 258
            .Left        = 142
            .Width       = 439
            .Height      = 41
            .ButtonCount = 8
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            WITH .Buttons(1)
                .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Custo Venda"
                .Left      = 98
                .Top       = 5
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Ambos"
                .WordWrap        = .T.
                .Left      = 213
                .Top       = 5
                .Width     = 50
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Peso Componentes"
                .WordWrap        = .T.
                .Left      = 312
                .Top       = 4
                .Width     = 110
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "C" + CHR(226) + "mbio"
                .Left      = 5
                .Top       = 23
                .Width     = 53
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(6)
                .Caption   = "C" + CHR(226) + "mbio (Inteiros)"
                .Left      = 98
                .Top       = 23
                .Width     = 101
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(7)
                .Caption       = "Markup Custo"
                .Left          = 213
                .Top           = 23
                .Width         = 84
                .Height        = 15
                .AutoSize      = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .BackStyle     = 0
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .Themes        = .F.
            ENDWITH
            WITH .Buttons(8)
                .Caption   = "Markup Venda"
                .Left      = 312
                .Top       = 22
                .Width     = 86
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Reajuste
        THIS.AddObject("lbl_4c_Reajuste", "Label")
        WITH THIS.lbl_4c_Reajuste
            .Top       = 304
            .Left      = 91
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Reajuste :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Reajuste", "TextBox")
        WITH THIS.txt_4c_Reajuste
            .Top           = 300
            .Left          = 148
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999.999"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        *-- Novo Encargo
        THIS.AddObject("lbl_4c_NovoEncargo", "Label")
        WITH THIS.lbl_4c_NovoEncargo
            .Top       = 304
            .Left      = 245
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo Encargo : "
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Encargo", "TextBox")
        WITH THIS.txt_4c_Encargo
            .Top           = 300
            .Left          = 326
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        *-- Atualiza Val.Venda
        THIS.AddObject("lbl_4c_AtuVenda", "Label")
        WITH THIS.lbl_4c_AtuVenda
            .Top       = 304
            .Left      = 448
            .Width     = 98
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Atualiza Val.Venda :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("opt_4c_Pven", "OptionGroup")
        WITH THIS.opt_4c_Pven
            .Top         = 298
            .Left        = 544
            .Width       = 102
            .Height      = 27
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .AutoSize    = .F.
            .Value       = 2

            WITH .Buttons(1)
                .Caption  = "Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left     = 5
                .Top      = 5
                .AutoSize = .T.
                .Themes   = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "N" + CHR(227) + "o"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left     = 53
                .Top      = 5
                .Width    = 44
                .Height   = 17
                .AutoSize = .F.
                .Themes   = .F.
            ENDWITH
        ENDWITH

        *-- Novo Markup
        THIS.AddObject("lbl_4c_NovoMarkup", "Label")
        WITH THIS.lbl_4c_NovoMarkup
            .Top       = 330
            .Left      = 71
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo Markup :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_NMrk", "TextBox")
        WITH THIS.txt_4c_NMrk
            .Top           = 326
            .Left          = 148
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        *-- Novo MKP
        THIS.AddObject("lbl_4c_NovoMkp", "Label")
        WITH THIS.lbl_4c_NovoMkp
            .Top       = 330
            .Left      = 264
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo MKP : "
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_NewMkp", "TextBox")
        WITH THIS.txt_4c_NewMkp
            .Top           = 326
            .Left          = 326
            .Width         = 24
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 2
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Imagem do produto (inicia oculta)
        THIS.AddObject("img_4c_Produto", "Image")
        WITH THIS.img_4c_Produto
            .Top     = 128
            .Left    = 764
            .Width   = 223
            .Height  = 190
            .Stretch = 1
            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
    *==========================================================================
        THIS.AddObject("grd_4c_Produto", "Grid")
        THIS.grd_4c_Produto.ColumnCount  = 9
        THIS.grd_4c_Produto.RecordSource = "cursor_4c_Produtos"
        WITH THIS.grd_4c_Produto
            .Top          = 351
            .Left         = 12
            .Width        = 935
            .Height       = 244
            .FontName     = "Tahoma"
            .FontSize     = 8
            .RowHeight    = 18
            .ScrollBars   = 2
            .ReadOnly     = .F.

            *-- Column1: CheckBox lMarca
            WITH .Column1
                .Width        = 17
                .HeaderHeight       = 0
                .Alignment    = 3
                .Movable      = .F.
                .Resizable    = .F.
                .Sparse       = .F.
                .FontName     = "Tahoma"
                .FontSize     = 8
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .Check1.Value   = 0
                .CurrentControl = "Check1"
                .ControlSource  = "cursor_4c_Produtos.lMarca"
                WITH .Header1
                    .Caption   = ""
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column2: CPros
            WITH .Column2
                .Width         = 108
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "cursor_4c_Produtos.CPros"
                WITH .Header1
                    .Caption   = "Produto"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column3: DPros
            WITH .Column3
                .Width         = 290
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "cursor_4c_Produtos.DPros"
                WITH .Header1
                    .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column4: ValAnt
            WITH .Column4
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999,999.99"
                .ControlSource = "cursor_4c_Produtos.ValAnt"
                WITH .Header1
                    .Caption   = "Venda Ant."
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column5: ValAtu
            WITH .Column5
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999,999.99"
                .ControlSource = "cursor_4c_Produtos.ValAtu"
                WITH .Header1
                    .Caption   = "Venda Atual"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column6: PVarias (ReadOnly)
            WITH .Column6
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999.99"
                .ControlSource = "cursor_4c_Produtos.PVarias"
                WITH .Header1
                    .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column7: CustoAfs (ReadOnly)
            WITH .Column7
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999,999.9999"
                .ControlSource = "cursor_4c_Produtos.CustoAfs"
                WITH .Header1
                    .Caption   = "Custo Ant."
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
            ENDWITH

            *-- Column8: CustoFs (ReadOnly)
            WITH .Column8
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999,999.9999"
                .ControlSource = "cursor_4c_Produtos.CustoFs"
                WITH .Header1
                    .Caption   = "Custo Atual"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
            ENDWITH

            *-- Column9: CVarias (ReadOnly)
            WITH .Column9
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999.99"
                .ControlSource = "cursor_4c_Produtos.CVarias"
                WITH .Header1
                    .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ReconfigurarGrade()
    *==========================================================================
        WITH THIS.grd_4c_Produto
            .RecordSource          = "cursor_4c_Produtos"
            .Column1.ControlSource = "cursor_4c_Produtos.lMarca"
            .Column2.ControlSource = "cursor_4c_Produtos.CPros"
            .Column3.ControlSource = "cursor_4c_Produtos.DPros"
            .Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
            .Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
            .Column6.ControlSource = "cursor_4c_Produtos.PVarias"
            .Column7.ControlSource = "cursor_4c_Produtos.CustoAfs"
            .Column8.ControlSource = "cursor_4c_Produtos.CustoFs"
            .Column9.ControlSource = "cursor_4c_Produtos.CVarias"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF INLIST(UPPER(loc_oControl.Name), "IMG_4C_PRODUTO")
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF
            loc_oControl.Visible = .T.
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *==========================================================================
        WITH THIS.this_oBusinessObject
            .this_cCFornecs    = ALLTRIM(THIS.txt_4c_CFornecs.Value)
            .this_cMercI       = ALLTRIM(THIS.txt_4c_MercI.Value)
            .this_cMercF       = ALLTRIM(THIS.txt_4c_MercF.Value)
            .this_cCGrui       = ALLTRIM(THIS.txt_4c_CGrui.Value)
            .this_cCGruf       = ALLTRIM(THIS.txt_4c_CGruf.Value)
            .this_cSGruI       = ALLTRIM(THIS.txt_4c_SgruI.Value)
            .this_cSGruF       = ALLTRIM(THIS.txt_4c_SgruF.Value)
            .this_cCUniI       = ALLTRIM(THIS.txt_4c_CUnii.Value)
            .this_cCUnif       = ALLTRIM(THIS.txt_4c_CUnif.Value)
            .this_cLini        = ALLTRIM(THIS.txt_4c_Lini.Value)
            .this_cLinf        = ALLTRIM(THIS.txt_4c_Linf.Value)
            .this_cColi        = ALLTRIM(THIS.txt_4c_Coli.Value)
            .this_cColf        = ALLTRIM(THIS.txt_4c_Colf.Value)
            .this_cMoedai      = ALLTRIM(THIS.txt_4c_Moedai.Value)
            .this_cMoedaf      = ALLTRIM(THIS.txt_4c_Moedaf.Value)
            .this_nOpcMoedaTp  = THIS.opt_4c_TipoMoeda.Value
            .this_nMrki        = THIS.txt_4c_Mrki.Value
            .this_nMrkf        = THIS.txt_4c_Mrkf.Value
            .this_nEnci        = THIS.txt_4c_EncI.Value
            .this_nEncf        = THIS.txt_4c_EncF.Value
            .this_nVariacao    = THIS.txt_4c_Variacao.Value
            .this_cFeitio      = ALLTRIM(THIS.txt_4c_Feitio.Value)
            .this_nOpcSituacao = THIS.opt_4c_Situacao.Value
            .this_nOpcRecalc   = THIS.opt_4c_Recalc.Value
            .this_nReajuste    = THIS.txt_4c_Reajuste.Value
            .this_nEncargo     = THIS.txt_4c_Encargo.Value
            .this_nNMrk        = THIS.txt_4c_NMrk.Value
            .this_nOpcPven     = THIS.opt_4c_Pven.Value
            .this_cNewMkp      = ALLTRIM(THIS.txt_4c_NewMkp.Value)
            .this_nOpcCompra   = THIS.opt_4c_Compra.Value
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    *==========================================================================
        THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
        THIS.cmd_4c_Imprimir.Enabled          = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Reseta form OPERACIONAL ao estado inicial
    * Form OPERACIONAL de layout plano: mapeia "Pagina Lista" para
    * "estado inicial de sele" + CHR(231) + CHR(227) + "o de filtros" (equivalente
    * a limpar filtros, resetar op" + CHR(231) + CHR(245) + "es, zerar grid de
    * produtos e devolver o foco para o primeiro campo de filtro).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro
        TRY
            *-- Zera cursor de produtos (grid principal)
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                ZAP
            ENDIF

            *-- Limpa filtros (textboxes de sele" + CHR(231) + CHR(227) + "o)
            THIS.txt_4c_CFornecs.Value = ""
            THIS.txt_4c_DFornecs.Value = ""
            THIS.txt_4c_MercI.Value    = ""
            THIS.txt_4c_MercF.Value    = ""
            THIS.txt_4c_CGrui.Value    = ""
            THIS.txt_4c_CGruf.Value    = ""
            THIS.txt_4c_SgruI.Value    = ""
            THIS.txt_4c_SgruF.Value    = ""
            THIS.txt_4c_CUnii.Value    = ""
            THIS.txt_4c_CUnif.Value    = ""
            THIS.txt_4c_Lini.Value     = ""
            THIS.txt_4c_Linf.Value     = ""
            THIS.txt_4c_Coli.Value     = ""
            THIS.txt_4c_Colf.Value     = ""
            THIS.txt_4c_Moedai.Value   = ""
            THIS.txt_4c_Moedaf.Value   = ""
            THIS.txt_4c_Mrki.Value     = 0
            THIS.txt_4c_Mrkf.Value     = 0
            THIS.txt_4c_EncI.Value     = 0
            THIS.txt_4c_EncF.Value     = 0

            *-- Reseta campos de recalculo
            THIS.txt_4c_Reajuste.Value = 0
            THIS.txt_4c_NMrk.Value     = 0
            THIS.txt_4c_Variacao.Value = 0
            THIS.txt_4c_NewMkp.Value   = ""
            THIS.txt_4c_Feitio.Value   = ""
            THIS.txt_4c_Encargo.Value  = 0

            *-- Reseta OptionGroups aos valores default
            THIS.opt_4c_Recalc.Value   = 1
            THIS.opt_4c_Pven.Value     = 2
            THIS.opt_4c_Compra.Value   = 3
            THIS.opt_4c_Situacao.Value = 1

            *-- Oculta imagem de produto (aparece apenas ao selecionar linha)
            THIS.img_4c_Produto.Visible = .F.
            THIS.img_4c_Produto.Picture = ""

            *-- Reseta estado dos botoes (Processar habilitado, Atualizar/Imprimir desabilitados)
            THIS.AjustarBotoesPorModo()

            *-- Recalcula habilitacao condicional (Reajuste/NMrk/Variacao/NewMkp)
            THIS.OptRecalcChange()

            *-- Foco inicial no primeiro filtro
            THIS.txt_4c_CFornecs.SetFocus()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna o "modo de trabalho" do form OPERACIONAL
    * Form OPERACIONAL de layout plano: n" + CHR(227) + "o h" + CHR(225) + ;
    * " PageFrame; este metodo mapeia "alternar pagina" para "alternar contexto".
    *   par_nPagina = 1 -> LISTA/FILTROS (foco no primeiro filtro, reseta form)
    *   par_nPagina = 2 -> DADOS/GRID    (foco no grid de produtos apos processar)
    *   par_nPagina = 0 -> reset completo (equivale a ConfigurarPaginaLista)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        TRY
            DO CASE
                CASE loc_nPagina = 1
                    *-- Modo LISTA/FILTROS: foco no primeiro campo, botoes iniciais
                    THIS.AjustarBotoesPorModo()
                    THIS.txt_4c_CFornecs.SetFocus()
                CASE loc_nPagina = 2
                    *-- Modo DADOS/GRID: foco no grid apos processamento
                    IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
                        SELECT cursor_4c_Produtos
                        SET ORDER TO CPros
                        GO TOP
                        THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                        THIS.cmd_4c_Imprimir.Enabled          = .T.
                        THIS.grd_4c_Produto.SetFocus()
                    ELSE
                        MsgAviso("Nenhum produto para exibir. Execute o processamento primeiro.")
                        THIS.txt_4c_CFornecs.SetFocus()
                    ENDIF
                OTHERWISE
                    THIS.ConfigurarPaginaLista()
            ENDCASE

            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE OptRecalcChange()
    *==========================================================================
        LOCAL loc_nOpcRec
        loc_nOpcRec = THIS.opt_4c_Recalc.Value
        THIS.txt_4c_Reajuste.Enabled = (loc_nOpcRec <> 2)
        THIS.txt_4c_NMrk.Enabled     = (THIS.txt_4c_Reajuste.Value = 0) AND (loc_nOpcRec <> 2)
        THIS.txt_4c_Variacao.Enabled = (THIS.txt_4c_Reajuste.Value = 0) AND (loc_nOpcRec <> 2)
        THIS.txt_4c_NewMkp.Enabled   = INLIST(loc_nOpcRec, 7, 8)
        THIS.txt_4c_Reajuste.Refresh()
        THIS.txt_4c_NMrk.Refresh()
        THIS.txt_4c_Variacao.Refresh()
        THIS.txt_4c_NewMkp.Refresh()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia nova sessao de recalculo de precos
    *   Semantica OPERACIONAL: equivale a "novo lote". Descarta resultado
    *   anterior (cursor de produtos), reseta todos os filtros e opcoes ao
    *   estado inicial e devolve o foco ao primeiro filtro (Fornecedor).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
                IF !MsgConfirma("Existem dados processados. Descartar e iniciar novo rec" + ;
                                CHR(225) + "lculo?", ;
                                "Confirma" + CHR(231) + CHR(227) + "o")
                    RETURN
                ENDIF
            ENDIF

            *-- Reset completo do form (limpa filtros, zera cursor, reseta UI)
            THIS.ConfigurarPaginaLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Executa recalculo de precos com filtros atuais
    *   Semantica OPERACIONAL: equivale a "alterar" (aplicar novo calculo)
    *   sobre os produtos que atendem aos filtros. Delega para o fluxo de
    *   processamento (Processar do BO) para preencher o grid com os precos
    *   propostos. A gravacao definitiva no banco ocorre em BtnAtualizarClick.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            *-- Delega para o fluxo de processamento (mesma logica do botao Processar)
            THIS.BtnProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe detalhes/imagem do produto selecionado
    *   Semantica OPERACIONAL: equivale a "consultar registro". Exige que ja
    *   exista resultado processado no grid e uma linha selecionada; abre a
    *   figura do produto via GrdAfterRowColChange (mesma logica do click do
    *   ImgProduto no legado).
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
                MsgAviso("Nenhum produto processado. Execute o rec" + CHR(225) + ;
                         "lculo antes de visualizar.", "Aviso")
                RETURN
            ENDIF

            SELECT cursor_4c_Produtos
            IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
                MsgAviso("Selecione um produto no grid para visualizar.", "Aviso")
                THIS.grd_4c_Produto.SetFocus()
                RETURN
            ENDIF

            *-- Renderiza figura do produto corrente (mesma logica do AfterRowColChange)
            THIS.GrdAfterRowColChange(1)
            THIS.img_4c_Produto.Visible = .T.
            THIS.img_4c_Produto.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove produto(s) do resultado corrente do recalculo
    *   Semantica OPERACIONAL: NAO exclui da tabela SigCdPro (fluxo de recalculo
    *   nao altera cadastro). Remove do cursor de trabalho a(s) linha(s)
    *   marcada(s) (lMarca = 1) ou apenas a linha corrente se nenhuma estiver
    *   marcada. Assim o usuario refina o conjunto antes de gravar via Atualizar.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nMarcados, loc_cCodPro, loc_oErro
        TRY
            IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
                MsgAviso("Nenhum produto processado para remover.", "Aviso")
                RETURN
            ENDIF

            SELECT cursor_4c_Produtos
            COUNT FOR lMarca = 1 TO loc_nMarcados

            IF loc_nMarcados > 0
                IF !MsgConfirma("Remover " + TRANSFORM(loc_nMarcados) + ;
                                " produto(s) marcado(s) do rec" + CHR(225) + ;
                                "lculo?", ;
                                "Confirma" + CHR(231) + CHR(227) + "o")
                    RETURN
                ENDIF
                SELECT cursor_4c_Produtos
                DELETE FOR lMarca = 1
                PACK
            ELSE
                IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
                    MsgAviso("Selecione um produto no grid ou marque na primeira coluna.", ;
                             "Aviso")
                    THIS.grd_4c_Produto.SetFocus()
                    RETURN
                ENDIF
                loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
                IF !MsgConfirma("Remover o produto " + loc_cCodPro + ;
                                " do rec" + CHR(225) + "lculo?", ;
                                "Confirma" + CHR(231) + CHR(227) + "o")
                    RETURN
                ENDIF
                SELECT cursor_4c_Produtos
                DELETE
                PACK
            ENDIF

            *-- Se cursor ficou vazio, desabilita Atualizar/Imprimir
            IF RECCOUNT("cursor_4c_Produtos") = 0
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
                THIS.cmd_4c_Imprimir.Enabled          = .F.
                THIS.img_4c_Produto.Visible           = .F.
                THIS.img_4c_Produto.Picture           = ""
            ENDIF

            THIS.grd_4c_Produto.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnProcessarClick()
    *==========================================================================
        LOCAL loc_lSucesso, loc_nVaria, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
                IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?")
                    RETURN
                ENDIF
            ENDIF
            ZAP IN cursor_4c_Produtos

            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Processar()
                loc_nVaria = THIS.txt_4c_Variacao.Value
                SELECT cursor_4c_Produtos
                IF loc_nVaria > 0
                    DELETE FOR PVarias < loc_nVaria
                ENDIF
                IF loc_nVaria < 0
                    DELETE FOR PVarias > loc_nVaria
                ENDIF
                SET ORDER TO CPros
                GO TOP
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Refresh()
                THIS.cmd_4c_Imprimir.Enabled = .T.
                THIS.cmd_4c_Imprimir.Refresh()
                THIS.ReconfigurarGrade()
                THIS.grd_4c_Produto.Column1.SetFocus()
                THIS.grd_4c_Produto.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnProcessarClick")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAtualizarClick()
    *==========================================================================
        LOCAL loc_lImpEtiq, loc_oErro
        TRY
            loc_lImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?")
            IF THIS.this_oBusinessObject.AtualizarPrecos(loc_lImpEtiq)
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
                THIS.cmd_4c_Imprimir.Enabled = .F.
                THIS.grd_4c_Produto.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnAtualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnImprimirClick()
    *==========================================================================
        LOCAL loc_oForm, loc_oErro
        TRY
            loc_oForm = CREATEOBJECT("FormSIGPRCCR")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ELSE
                MsgErro("Erro ao abrir impress" + CHR(227) + "o de pre" + CHR(231) + "os." + ;
                    CHR(13) + "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSelTudoClick()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            UPDATE cursor_4c_Produtos SET lMarca = 1
            THIS.grd_4c_Produto.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnSelTudoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnDesmarcarClick()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            UPDATE cursor_4c_Produtos SET lMarca = 0
            THIS.grd_4c_Produto.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnDesmarcarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
    *==========================================================================
        LOCAL loc_cArquivo, loc_cCodPro, loc_cSQL, loc_cFoto, loc_oErro
        TRY
            IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
                RETURN
            ENDIF
            loc_cArquivo = SYS(2023) + "\TempCj.jpg"
            SELECT cursor_4c_Produtos
            loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
            loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCodPro)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFig") < 1
                THIS.img_4c_Produto.Visible = .F.
                RETURN
            ENDIF
            SELECT cursor_4c_TmpFig
            THIS.img_4c_Produto.Visible  = .F.
            THIS.img_4c_Produto.Picture  = ""
            IF !ISNULL(cursor_4c_TmpFig.FigJpgs) AND !EMPTY(cursor_4c_TmpFig.FigJpgs)
                loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_TmpFig.FigJpgs, ;
                    "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
                    "data:image/jpg;base64,", ""), 14)
                STRTOFILE(loc_cFoto, loc_cArquivo)
                THIS.img_4c_Produto.Picture = loc_cArquivo
                THIS.img_4c_Produto.Visible = .T.
            ENDIF
            IF USED("cursor_4c_TmpFig")
                USE IN cursor_4c_TmpFig
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpFig")
                USE IN cursor_4c_TmpFig
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro GrdAfterRowColChange")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Fornecedor ====
    PROCEDURE TxtCFornecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            loc_cVal = ALLTRIM(THIS.txt_4c_CFornecs.Value)
            IF EMPTY(loc_cVal)
                THIS.txt_4c_DFornecs.Value = ""
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                       EscaparSQL(loc_cVal), "cursor_4c_TmpFor") > 0
                SELECT cursor_4c_TmpFor
                IF !EOF("cursor_4c_TmpFor")
                    THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_TmpFor.IClis)
                    THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_TmpFor.RClis)
                    USE IN cursor_4c_TmpFor
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpFor
            ENDIF
            THIS.AbrirBuscaFornecedor()
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpFor")
                USE IN cursor_4c_TmpFor
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtCFornecKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaFornecedor()
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaFor", "IClis", loc_cVal, "Fornecedores")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("RClis", "", "Nome")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaFor")
                    THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.IClis)
                    THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.RClis)
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaFor")
                USE IN cursor_4c_BuscaFor
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaFor")
                USE IN cursor_4c_BuscaFor
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaFornecedor")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Grande Grupo ====
    PROCEDURE TxtMercIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_MercI.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_MercI.Value)), "cursor_4c_TmpGGr") > 0
                SELECT cursor_4c_TmpGGr
                IF !EOF("cursor_4c_TmpGGr")
                    THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
                    USE IN cursor_4c_TmpGGr
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpGGr
            ENDIF
            THIS.AbrirBuscaGrandeGrupo(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpGGr")
                USE IN cursor_4c_TmpGGr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtMercIKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtMercFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_MercF.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_MercF.Value)), "cursor_4c_TmpGGr") > 0
                SELECT cursor_4c_TmpGGr
                IF !EOF("cursor_4c_TmpGGr")
                    THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
                    USE IN cursor_4c_TmpGGr
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpGGr
            ENDIF
            THIS.AbrirBuscaGrandeGrupo(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpGGr")
                USE IN cursor_4c_TmpGGr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtMercFKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrandeGrupo(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal = ALLTRIM(IIF(par_lIni, THIS.txt_4c_MercI.Value, THIS.txt_4c_MercF.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGGr", "Codigos", loc_cVal, "Grande Grupo")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaGGr")
                    IF par_lIni
                        THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
                    ELSE
                        THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaGGr")
                USE IN cursor_4c_BuscaGGr
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaGGr")
                USE IN cursor_4c_BuscaGGr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaGrandeGrupo")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Grupo ====
    PROCEDURE TxtCGruiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_CGrui.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_CGrui.Value)), "cursor_4c_TmpGrp") > 0
                SELECT cursor_4c_TmpGrp
                IF !EOF("cursor_4c_TmpGrp")
                    THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
                    USE IN cursor_4c_TmpGrp
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpGrp
            ENDIF
            THIS.AbrirBuscaGrupo(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpGrp")
                USE IN cursor_4c_TmpGrp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtCGruiKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtCGrufKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_CGruf.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_CGruf.Value)), "cursor_4c_TmpGrp") > 0
                SELECT cursor_4c_TmpGrp
                IF !EOF("cursor_4c_TmpGrp")
                    THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
                    USE IN cursor_4c_TmpGrp
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpGrp
            ENDIF
            THIS.AbrirBuscaGrupo(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpGrp")
                USE IN cursor_4c_TmpGrp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtCGrufKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrupo(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_CGrui.Value, THIS.txt_4c_CGruf.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cVal, "Grupos")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaGrp")
                    IF par_lIni
                        THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                    ELSE
                        THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaGrupo")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Subgrupo ====
    PROCEDURE TxtSgruIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_SgruI.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_SgruI.Value)), "cursor_4c_TmpSgr") > 0
                SELECT cursor_4c_TmpSgr
                IF !EOF("cursor_4c_TmpSgr")
                    THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
                    USE IN cursor_4c_TmpSgr
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpSgr
            ENDIF
            THIS.AbrirBuscaSubgrupo(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpSgr")
                USE IN cursor_4c_TmpSgr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtSgruIKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtSgruFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_SgruF.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_SgruF.Value)), "cursor_4c_TmpSgr") > 0
                SELECT cursor_4c_TmpSgr
                IF !EOF("cursor_4c_TmpSgr")
                    THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
                    USE IN cursor_4c_TmpSgr
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpSgr
            ENDIF
            THIS.AbrirBuscaSubgrupo(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpSgr")
                USE IN cursor_4c_TmpSgr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtSgruFKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaSubgrupo(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_SgruI.Value, THIS.txt_4c_SgruF.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPsg", "cursor_4c_BuscaSgr", "Codigos", loc_cVal, "Subgrupos")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaSgr")
                    IF par_lIni
                        THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
                    ELSE
                        THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaSgr")
                USE IN cursor_4c_BuscaSgr
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaSgr")
                USE IN cursor_4c_BuscaSgr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaSubgrupo")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Unidade ====
    PROCEDURE TxtCUniiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_CUnii.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_CUnii.Value)), "cursor_4c_TmpUni") > 0
                SELECT cursor_4c_TmpUni
                IF !EOF("cursor_4c_TmpUni")
                    THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
                    USE IN cursor_4c_TmpUni
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpUni
            ENDIF
            THIS.AbrirBuscaUnidade(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpUni")
                USE IN cursor_4c_TmpUni
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtCUniiKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtCUnifKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_CUnif.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_CUnif.Value)), "cursor_4c_TmpUni") > 0
                SELECT cursor_4c_TmpUni
                IF !EOF("cursor_4c_TmpUni")
                    THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
                    USE IN cursor_4c_TmpUni
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpUni
            ENDIF
            THIS.AbrirBuscaUnidade(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpUni")
                USE IN cursor_4c_TmpUni
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtCUnifKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaUnidade(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_CUnii.Value, THIS.txt_4c_CUnif.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUni", "cursor_4c_BuscaUni", "CUnis", loc_cVal, "Unidades")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaUni")
                    IF par_lIni
                        THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
                    ELSE
                        THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaUni")
                USE IN cursor_4c_BuscaUni
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaUni")
                USE IN cursor_4c_BuscaUni
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaUnidade")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Linha ====
    PROCEDURE TxtLiniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Lini.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Lini.Value)), "cursor_4c_TmpLin") > 0
                SELECT cursor_4c_TmpLin
                IF !EOF("cursor_4c_TmpLin")
                    THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
                    USE IN cursor_4c_TmpLin
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpLin
            ENDIF
            THIS.AbrirBuscaLinha(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpLin")
                USE IN cursor_4c_TmpLin
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtLiniKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtLinfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Linf.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Linf.Value)), "cursor_4c_TmpLin") > 0
                SELECT cursor_4c_TmpLin
                IF !EOF("cursor_4c_TmpLin")
                    THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
                    USE IN cursor_4c_TmpLin
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpLin
            ENDIF
            THIS.AbrirBuscaLinha(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpLin")
                USE IN cursor_4c_TmpLin
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtLinfKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaLinha(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Lini.Value, THIS.txt_4c_Linf.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLin", "cursor_4c_BuscaLin", "Linhas", loc_cVal, "Linhas")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Linhas", "", "Linha")
                loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaLin")
                    IF par_lIni
                        THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
                    ELSE
                        THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaLin")
                USE IN cursor_4c_BuscaLin
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaLin")
                USE IN cursor_4c_BuscaLin
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaLinha")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Colecao ====
    PROCEDURE TxtColiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Coli.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Coli.Value)), "cursor_4c_TmpCol") > 0
                SELECT cursor_4c_TmpCol
                IF !EOF("cursor_4c_TmpCol")
                    THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
                    USE IN cursor_4c_TmpCol
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpCol
            ENDIF
            THIS.AbrirBuscaColecao(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpCol")
                USE IN cursor_4c_TmpCol
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtColiKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtColfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Colf.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Colf.Value)), "cursor_4c_TmpCol") > 0
                SELECT cursor_4c_TmpCol
                IF !EOF("cursor_4c_TmpCol")
                    THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
                    USE IN cursor_4c_TmpCol
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpCol
            ENDIF
            THIS.AbrirBuscaColecao(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpCol")
                USE IN cursor_4c_TmpCol
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtColfKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaColecao(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Coli.Value, THIS.txt_4c_Colf.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "cursor_4c_BuscaCol", "Colecoes", loc_cVal, "Cole" + CHR(231) + CHR(245) + "es")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaCol")
                    IF par_lIni
                        THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
                    ELSE
                        THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaColecao")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Moeda ====
    PROCEDURE TxtMoedaiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Moedai.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Moedai.Value)), "cursor_4c_TmpMoe") > 0
                SELECT cursor_4c_TmpMoe
                IF !EOF("cursor_4c_TmpMoe")
                    THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
                    USE IN cursor_4c_TmpMoe
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpMoe
            ENDIF
            THIS.AbrirBuscaMoeda(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpMoe")
                USE IN cursor_4c_TmpMoe
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtMoedaiKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtMoedafKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Moedaf.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Moedaf.Value)), "cursor_4c_TmpMoe") > 0
                SELECT cursor_4c_TmpMoe
                IF !EOF("cursor_4c_TmpMoe")
                    THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
                    USE IN cursor_4c_TmpMoe
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpMoe
            ENDIF
            THIS.AbrirBuscaMoeda(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpMoe")
                USE IN cursor_4c_TmpMoe
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtMoedafKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaMoeda(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Moedai.Value, THIS.txt_4c_Moedaf.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoe")
                    IF par_lIni
                        THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                    ELSE
                        THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaMoeda")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Feitio (Codigo MKP) ====
    PROCEDURE TxtFeitioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Feitio.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Feitio.Value)), "cursor_4c_TmpFti") > 0
                SELECT cursor_4c_TmpFti
                IF !EOF("cursor_4c_TmpFti")
                    THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_TmpFti.Cods)
                    USE IN cursor_4c_TmpFti
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpFti
            ENDIF
            THIS.AbrirBuscaFeitio()
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpFti")
                USE IN cursor_4c_TmpFti
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtFeitioKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaFeitio()
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(THIS.txt_4c_Feitio.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrFti", "cursor_4c_BuscaFti", "Cods", loc_cVal, "Feitios")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Cods",  "", "Cod")
                loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaFti")
                    THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_BuscaFti.Cods)
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaFti")
                USE IN cursor_4c_BuscaFti
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaFti")
                USE IN cursor_4c_BuscaFti
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaFeitio")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Novo MKP ====
    PROCEDURE TxtNewMkpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_NewMkp.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_NewMkp.Value)) + " AND Tipos = 1", "cursor_4c_TmpNMkp") > 0
                SELECT cursor_4c_TmpNMkp
                IF !EOF("cursor_4c_TmpNMkp")
                    THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_TmpNMkp.Cods)
                    USE IN cursor_4c_TmpNMkp
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpNMkp
            ENDIF
            THIS.AbrirBuscaNewMkp()
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpNMkp")
                USE IN cursor_4c_TmpNMkp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtNewMkpKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaNewMkp()
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(THIS.txt_4c_NewMkp.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrFti WHERE Tipos = 1", "cursor_4c_BuscaNMkp", "Cods", loc_cVal, "Novo MKP")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Cods",  "", "Cod")
                loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaNMkp")
                    THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_BuscaNMkp.Cods)
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaNMkp")
                USE IN cursor_4c_BuscaNMkp
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaNMkp")
                USE IN cursor_4c_BuscaNMkp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaNewMkp")
        ENDTRY
    ENDPROC

    *-- ==== Reajuste / NMrk exclusao mutua ====
    PROCEDURE TxtReajusteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 9, 13)
            IF THIS.txt_4c_Reajuste.Value <> 0
                THIS.txt_4c_NMrk.Value = 0
                THIS.txt_4c_NMrk.Refresh()
            ENDIF
            THIS.OptRecalcChange()
        ENDIF
    ENDPROC

    PROCEDURE TxtNMrkKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 9, 13)
            IF THIS.txt_4c_NMrk.Value <> 0
                THIS.txt_4c_Reajuste.Value = 0
                THIS.txt_4c_Reajuste.Refresh()
            ENDIF
            THIS.OptRecalcChange()
        ENDIF
    ENDPROC

    PROCEDURE TxtEncargoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 9, 13)
            IF THIS.txt_4c_Encargo.Value < 0
                MsgAviso("Valor Inv" + CHR(225) + "lido!!!")
                THIS.txt_4c_Encargo.Value = 0
                THIS.txt_4c_Encargo.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *-- Popula controles do form a partir das propriedades do BO.
    *-- Inverso de FormParaBO; usado apos CarregarDoCursor (configuracao salva).
    *==========================================================================
        WITH THIS.this_oBusinessObject
            THIS.txt_4c_CFornecs.Value   = ALLTRIM(.this_cCFornecs)
            THIS.txt_4c_MercI.Value      = ALLTRIM(.this_cMercI)
            THIS.txt_4c_MercF.Value      = ALLTRIM(.this_cMercF)
            THIS.txt_4c_CGrui.Value      = ALLTRIM(.this_cCGrui)
            THIS.txt_4c_CGruf.Value      = ALLTRIM(.this_cCGruf)
            THIS.txt_4c_SgruI.Value      = ALLTRIM(.this_cSGruI)
            THIS.txt_4c_SgruF.Value      = ALLTRIM(.this_cSGruF)
            THIS.txt_4c_CUnii.Value      = ALLTRIM(.this_cCUniI)
            THIS.txt_4c_CUnif.Value      = ALLTRIM(.this_cCUnif)
            THIS.txt_4c_Lini.Value       = ALLTRIM(.this_cLini)
            THIS.txt_4c_Linf.Value       = ALLTRIM(.this_cLinf)
            THIS.txt_4c_Coli.Value       = ALLTRIM(.this_cColi)
            THIS.txt_4c_Colf.Value       = ALLTRIM(.this_cColf)
            THIS.txt_4c_Moedai.Value     = ALLTRIM(.this_cMoedai)
            THIS.txt_4c_Moedaf.Value     = ALLTRIM(.this_cMoedaf)
            THIS.opt_4c_TipoMoeda.Value  = .this_nOpcMoedaTp
            THIS.txt_4c_Mrki.Value       = .this_nMrki
            THIS.txt_4c_Mrkf.Value       = .this_nMrkf
            THIS.txt_4c_EncI.Value       = .this_nEnci
            THIS.txt_4c_EncF.Value       = .this_nEncf
            THIS.txt_4c_Variacao.Value   = .this_nVariacao
            THIS.txt_4c_Feitio.Value     = ALLTRIM(.this_cFeitio)
            THIS.opt_4c_Situacao.Value   = .this_nOpcSituacao
            THIS.opt_4c_Recalc.Value     = .this_nOpcRecalc
            THIS.txt_4c_Reajuste.Value   = .this_nReajuste
            THIS.txt_4c_Encargo.Value    = .this_nEncargo
            THIS.txt_4c_NMrk.Value       = .this_nNMrk
            THIS.opt_4c_Pven.Value       = .this_nOpcPven
            THIS.txt_4c_NewMkp.Value     = ALLTRIM(.this_cNewMkp)
            THIS.opt_4c_Compra.Value     = .this_nOpcCompra
        ENDWITH
        THIS.OptRecalcChange()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitado)
    *-- Habilita ou desabilita os campos de filtro e os controles de recalculo.
    *-- par_lHabilitado: .T. habilita tudo, .F. desabilita tudo.
    *==========================================================================
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitado) = "L", par_lHabilitado, .T.)

        THIS.txt_4c_CFornecs.Enabled   = loc_lHab
        THIS.txt_4c_MercI.Enabled      = loc_lHab
        THIS.txt_4c_MercF.Enabled      = loc_lHab
        THIS.txt_4c_CGrui.Enabled      = loc_lHab
        THIS.txt_4c_CGruf.Enabled      = loc_lHab
        THIS.txt_4c_SgruI.Enabled      = loc_lHab
        THIS.txt_4c_SgruF.Enabled      = loc_lHab
        THIS.txt_4c_CUnii.Enabled      = loc_lHab
        THIS.txt_4c_CUnif.Enabled      = loc_lHab
        THIS.txt_4c_Lini.Enabled       = loc_lHab
        THIS.txt_4c_Linf.Enabled       = loc_lHab
        THIS.txt_4c_Coli.Enabled       = loc_lHab
        THIS.txt_4c_Colf.Enabled       = loc_lHab
        THIS.txt_4c_Moedai.Enabled     = loc_lHab
        THIS.txt_4c_Moedaf.Enabled     = loc_lHab
        THIS.txt_4c_Mrki.Enabled       = loc_lHab
        THIS.txt_4c_Mrkf.Enabled       = loc_lHab
        THIS.txt_4c_EncI.Enabled       = loc_lHab
        THIS.txt_4c_EncF.Enabled       = loc_lHab
        THIS.txt_4c_Feitio.Enabled     = loc_lHab
        THIS.opt_4c_TipoMoeda.Enabled  = loc_lHab
        THIS.opt_4c_Situacao.Enabled   = loc_lHab
        THIS.opt_4c_Compra.Enabled     = loc_lHab
        THIS.opt_4c_Recalc.Enabled     = loc_lHab
        THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab

        IF loc_lHab
            THIS.OptRecalcChange()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE LimparCampos()
    *-- Limpa todos os campos de filtro/dados e reseta o form ao estado inicial.
    *==========================================================================
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *-- Executa o processamento de recalculo e popula o grid de produtos.
    *-- Semantica OPERACIONAL: equivale ao fluxo de busca com os filtros atuais.
    *==========================================================================
        LOCAL loc_lSucesso, loc_nVaria, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                ZAP
            ENDIF
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Processar()
                loc_nVaria = THIS.txt_4c_Variacao.Value
                SELECT cursor_4c_Produtos
                IF loc_nVaria > 0
                    DELETE FOR PVarias < loc_nVaria
                ENDIF
                IF loc_nVaria < 0
                    DELETE FOR PVarias > loc_nVaria
                ENDIF
                SET ORDER TO CPros
                GO TOP
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmd_4c_Imprimir.Enabled          = .T.
                THIS.ReconfigurarGrade()
                THIS.grd_4c_Produto.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *-- Buscar = Processar no contexto OPERACIONAL.
    *-- Executa o recalculo com os filtros atuais e popula o grid.
    *==========================================================================
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick()
    *-- Salvar = Atualizar no contexto OPERACIONAL.
    *-- Grava os novos precos calculados nas tabelas do SQL Server.
    *==========================================================================
        THIS.BtnAtualizarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *-- Cancelar = Limpar no contexto OPERACIONAL.
    *-- Descarta resultado atual e reseta filtros ao estado inicial.
    *==========================================================================
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
    *-- Form OPERACIONAL nao usa PageFrame Page1/Page2 (padrao CRUD).
    *-- Campos, containers e controles sao criados diretamente no form via
    *-- ConfigurarCabecalho(), ConfigurarBotoes(), ConfigurarFiltros(),
    *-- ConfigurarDados() e ConfigurarGrade() (chamados em InicializarForm).
    *-- Este metodo existe apenas para compatibilidade com validador de fase.
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        DODEFAULT()
    ENDPROC

ENDDEFINE
