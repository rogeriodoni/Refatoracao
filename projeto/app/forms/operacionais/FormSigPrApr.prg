*==============================================================================
* FormSigPrApr.prg - Formulario OPERACIONAL: Reajuste de Precifica" + CHR(231) + CHR(227) + "o
* Equivalente ao SIGPRAPR.SCX do legado
* Herda de FormBase
*==============================================================================

DEFINE CLASS FormSigPrApr AS FormBase

    Width         = 1000
    Height        = 600
    Caption       = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
    ShowWindow    = 1
    WindowType    = 1
    TitleBar      = 0
    ControlBox    = .F.
    Closable      = .F.
    MaxButton     = .F.
    MinButton     = .F.
    AutoCenter    = .T.
    BorderStyle   = 2
    Themes        = .F.
    DataSession   = 2

    this_lLibValAtu = .F.
    this_cAntValue  = ""

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
        THIS.ShowTips   = .F.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.ConfigurarPageFrame()

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrAprBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar SigPrAprBO.", "Erro InicializarForm")
            ELSE
                IF !THIS.this_oBusinessObject.CarregarDadosIniciais()
                MsgErro("Falha ao carregar dados iniciais.", "Erro InicializarForm")
            ELSE
            THIS.this_lLibValAtu = THIS.this_oBusinessObject.this_lLibValAtu

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoes()
            THIS.ConfigurarFiltros()
            THIS.ConfigurarGrade()
            THIS.CarregarLista()

            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnProcessarClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnAtualizarClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnEncerrarClick")

            BINDEVENT(THIS.opt_4c_Tipo, "InteractiveChange", THIS, "OptTipoChange")
            BINDEVENT(THIS.chk_4c_Auditado, "Click",         THIS, "ChkAuditadoClick")

            BINDEVENT(THIS.txt_4c_GrupoIni,  "KeyPress", THIS, "TxtGrupoIniKeyPress")
            BINDEVENT(THIS.txt_4c_GrupoFim,  "KeyPress", THIS, "TxtGrupoFimKeyPress")
            BINDEVENT(THIS.txt_4c_Colecao,   "KeyPress", THIS, "TxtColecaoKeyPress")
            BINDEVENT(THIS.txt_4c_Conta,     "KeyPress", THIS, "TxtContaKeyPress")
            BINDEVENT(THIS.txt_4c_DConta,    "KeyPress", THIS, "TxtDContaKeyPress")
            BINDEVENT(THIS.txt_4c_Promo,     "KeyPress", THIS, "TxtPromoKeyPress")
            BINDEVENT(THIS.txt_4c_Moeda,     "KeyPress", THIS, "TxtMoedaKeyPress")
            BINDEVENT(THIS.txt_4c_MoeCs,     "KeyPress", THIS, "TxtMoeCsKeyPress")
            BINDEVENT(THIS.txt_4c_MoeCusFs,  "KeyPress", THIS, "TxtMoeCusFsKeyPress")
            BINDEVENT(THIS.txt_4c_Moedas,    "KeyPress", THIS, "TxtMoedasKeyPress")
            BINDEVENT(THIS.txt_4c_CFtios,    "KeyPress", THIS, "TxtCFtiosKeyPress")
            BINDEVENT(THIS.txt_4c_MoeVs,     "KeyPress", THIS, "TxtMoeVsKeyPress")
            BINDEVENT(THIS.txt_4c_MoeCusto,  "KeyPress", THIS, "TxtMoeCustoKeyPress")

            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdAfterRowColChange")
            BINDEVENT(THIS.grd_4c_Dados.Column1.Header1, "Click", THIS, "GrdHeaderClick")
            BINDEVENT(THIS.grd_4c_Dados, "KeyPress",          THIS, "GrdKeyPress")

            THIS.TornarControlesVisiveis(THIS)

            THIS.opt_4c_Tipo.Value = 1
            THIS.OptTipoChange()

            THIS.AjustarBotoesPorModo()

            THIS.txt_4c_GrupoIni.SetFocus()

            loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm FormSigPrApr")
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
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Top           = 0
            .Left          = 765
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
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Caption    = "Atualizar"
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
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Caption    = "Encerrar"
                .WordWrap        = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros()
    *==========================================================================
        *-- Grupo de Produto (inicio/fim)
        THIS.AddObject("lbl_4c_GrupoP", "Label")
        WITH THIS.lbl_4c_GrupoP
            .Top      = 113
            .Left     = 69
            .Width    = 94
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Grupo de Produto :"
        ENDWITH

        THIS.AddObject("txt_4c_GrupoIni", "TextBox")
        WITH THIS.txt_4c_GrupoIni
            .Top       = 109
            .Left      = 165
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .InputMask = "XXX"
        ENDWITH

        THIS.AddObject("lbl_4c_GrupoAte", "Label")
        WITH THIS.lbl_4c_GrupoAte
            .Top      = 113
            .Left     = 203
            .Width    = 18
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "at" + CHR(233)
        ENDWITH

        THIS.AddObject("txt_4c_GrupoFim", "TextBox")
        WITH THIS.txt_4c_GrupoFim
            .Top       = 109
            .Left      = 228
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .InputMask = "XXX"
        ENDWITH

        *-- CheckBox Ignorar Componentes
        THIS.AddObject("chk_4c_Ignorar", "CheckBox")
        WITH THIS.chk_4c_Ignorar
            .Top      = 112
            .Left     = 609
            .Width    = 123
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Ignorar Componentes"
            .Value    = 0
        ENDWITH

        *-- Reajuste por: (label) + OptionGroup tipo
        THIS.AddObject("lbl_4c_ReajustePor", "Label")
        WITH THIS.lbl_4c_ReajustePor
            .Top      = 139
            .Left     = 92
            .Width    = 71
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Reajuste por :"
        ENDWITH

        THIS.AddObject("opt_4c_Tipo", "OptionGroup")
        WITH THIS.opt_4c_Tipo
            .Top         = 134
            .Left        = 159
            .Width       = 208
            .Height      = 24
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            WITH .Buttons(1)
                .Caption  = "Varia" + CHR(231) + CHR(227) + "o %"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Width    = 68
                .Height   = 18
                .Left     = 2
                .Top      = 2
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "MarkUp"
                .Width    = 62
                .Height   = 18
                .Left     = 72
                .Top      = 2
                .FontName = "Comic Sans MS"
                .FontSize = 8
            ENDWITH
            WITH .Buttons(3)
                .Caption  = "C" + CHR(226) + "mbio"
                .WordWrap        = .T.
                .Width    = 60
                .Height   = 18
                .Left     = 136
                .Top      = 2
                .FontName = "Comic Sans MS"
                .FontSize = 8
            ENDWITH
        ENDWITH

        *-- CheckBox Incluir Custos (tipo 1 apenas)
        THIS.AddObject("chk_4c_IncCusts", "CheckBox")
        WITH THIS.chk_4c_IncCusts
            .Top      = 139
            .Left     = 609
            .Width    = 83
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Incluir Custos"
            .Value    = 0
        ENDWITH

        *-- Grupo de Venda / Colecao
        THIS.AddObject("lbl_4c_GrupoV", "Label")
        WITH THIS.lbl_4c_GrupoV
            .Top      = 113
            .Left     = 399
            .Width    = 86
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Grupo de Venda :"
        ENDWITH

        THIS.AddObject("txt_4c_Colecao", "TextBox")
        WITH THIS.txt_4c_Colecao
            .Top       = 109
            .Left      = 487
            .Width     = 94
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 10
            .InputMask = "XXXXXXXXXX"
        ENDWITH

        *-- Variacao de Preco (tipo 1)
        THIS.AddObject("lbl_4c_Variacao", "Label")
        WITH THIS.lbl_4c_Variacao
            .Top      = 139
            .Left     = 390
            .Width    = 95
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Varia" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "o :"
        ENDWITH

        THIS.AddObject("txt_4c_Variacao", "TextBox")
        WITH THIS.txt_4c_Variacao
            .Top       = 135
            .Left      = 487
            .Width     = 94
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999999.99"
        ENDWITH

        THIS.AddObject("lbl_4c_Pct", "Label")
        WITH THIS.lbl_4c_Pct
            .Top      = 139
            .Left     = 585
            .Width    = 13
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "%"
        ENDWITH

        *-- Moeda (tipo 2)
        THIS.AddObject("lbl_4c_Moeda", "Label")
        WITH THIS.lbl_4c_Moeda
            .Top      = 139
            .Left     = 444
            .Width    = 41
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Moeda :"
        ENDWITH

        THIS.AddObject("txt_4c_Moeda", "TextBox")
        WITH THIS.txt_4c_Moeda
            .Top       = 135
            .Left      = 487
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .InputMask = "XXX"
        ENDWITH

        *-- Fator de Custo
        THIS.AddObject("lbl_4c_FatorCusto", "Label")
        WITH THIS.lbl_4c_FatorCusto
            .Top      = 165
            .Left     = 85
            .Width    = 78
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Fator de Custo:"
        ENDWITH

        THIS.AddObject("txt_4c_Fator", "TextBox")
        WITH THIS.txt_4c_Fator
            .Top       = 161
            .Left      = 165
            .Width     = 73
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99999.999"
        ENDWITH

        THIS.AddObject("txt_4c_MoeCusto", "TextBox")
        WITH THIS.txt_4c_MoeCusto
            .Top       = 161
            .Left      = 241
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .InputMask = "XXX"
        ENDWITH

        *-- MarkUp (tipo 2)
        THIS.AddObject("lbl_4c_MarkUp", "Label")
        WITH THIS.lbl_4c_MarkUp
            .Top      = 165
            .Left     = 440
            .Width    = 45
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "MarkUp :"
        ENDWITH

        THIS.AddObject("txt_4c_MarkUp1", "TextBox")
        WITH THIS.txt_4c_MarkUp1
            .Top       = 161
            .Left      = 487
            .Width     = 52
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "9999.99"
        ENDWITH

        THIS.AddObject("lbl_4c_Para", "Label")
        WITH THIS.lbl_4c_Para
            .Top      = 165
            .Left     = 547
            .Width    = 24
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "para"
        ENDWITH

        THIS.AddObject("txt_4c_MarkUp2", "TextBox")
        WITH THIS.txt_4c_MarkUp2
            .Top       = 161
            .Left      = 580
            .Width     = 52
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "9999.99"
        ENDWITH

        *-- Promocao + Limpar
        THIS.AddObject("lbl_4c_Promo", "Label")
        WITH THIS.lbl_4c_Promo
            .Top      = 191
            .Left     = 107
            .Width    = 56
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Promo" + CHR(231) + CHR(227) + "o :"
        ENDWITH

        THIS.AddObject("txt_4c_Promo", "TextBox")
        WITH THIS.txt_4c_Promo
            .Top       = 187
            .Left      = 165
            .Width     = 185
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 25
        ENDWITH

        THIS.AddObject("chk_4c_Limpar", "CheckBox")
        WITH THIS.chk_4c_Limpar
            .Top      = 191
            .Left     = 362
            .Width    = 157
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
            .Value    = 0
        ENDWITH

        *-- Fornecedor (codigo + descricao)
        THIS.AddObject("lbl_4c_Fornecedor", "Label")
        WITH THIS.lbl_4c_Fornecedor
            .Top      = 216
            .Left     = 99
            .Width    = 64
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Fornecedor :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Top       = 213
            .Left      = 165
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 10
        ENDWITH

        THIS.AddObject("txt_4c_DConta", "TextBox")
        WITH THIS.txt_4c_DConta
            .Top       = 213
            .Left      = 248
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 50
        ENDWITH

        *-- Secao de Moedas auxiliares (tipo 2)
        THIS.AddObject("lbl_4c_Moeda1", "Label")
        WITH THIS.lbl_4c_Moeda1
            .Top      = 244
            .Left     = 51
            .Width    = 112
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Moeda Custo Compo. :"
        ENDWITH

        THIS.AddObject("txt_4c_MoeCs", "TextBox")
        WITH THIS.txt_4c_MoeCs
            .Top       = 240
            .Left      = 165
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .InputMask = "XXX"
        ENDWITH

        THIS.AddObject("lbl_4c_Moeda2", "Label")
        WITH THIS.lbl_4c_Moeda2
            .Top      = 270
            .Left     = 64
            .Width    = 99
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Moeda Custo Total :"
        ENDWITH

        THIS.AddObject("txt_4c_MoeCusFs", "TextBox")
        WITH THIS.txt_4c_MoeCusFs
            .Top       = 266
            .Left      = 165
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .InputMask = "XXX"
        ENDWITH

        THIS.AddObject("lbl_4c_Moeda4", "Label")
        WITH THIS.lbl_4c_Moeda4
            .Top      = 244
            .Left     = 320
            .Width    = 98
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Moeda Pre" + CHR(231) + "o Ideal :"
        ENDWITH

        THIS.AddObject("txt_4c_Moedas", "TextBox")
        WITH THIS.txt_4c_Moedas
            .Top       = 240
            .Left      = 420
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .InputMask = "XXX"
        ENDWITH

        THIS.AddObject("lbl_4c_Moeda3", "Label")
        WITH THIS.lbl_4c_Moeda3
            .Top      = 244
            .Left     = 531
            .Width    = 35
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Feitio :"
        ENDWITH

        THIS.AddObject("txt_4c_CFtios", "TextBox")
        WITH THIS.txt_4c_CFtios
            .Top       = 240
            .Left      = 568
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 2
            .InputMask = "XX"
        ENDWITH

        THIS.AddObject("lbl_4c_Moeda5", "Label")
        WITH THIS.lbl_4c_Moeda5
            .Top      = 270
            .Left     = 319
            .Width    = 99
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Caption  = "Moeda Pre" + CHR(231) + "o Atual :"
        ENDWITH

        THIS.AddObject("txt_4c_MoeVs", "TextBox")
        WITH THIS.txt_4c_MoeVs
            .Top       = 266
            .Left      = 420
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .InputMask = "XXX"
        ENDWITH

        *-- CheckBox Auditado (modo edicao manual no grid)
        THIS.AddObject("chk_4c_Auditado", "CheckBox")
        WITH THIS.chk_4c_Auditado
            .Top        = 307
            .Left       = 763
            .Width      = 75
            .Height     = 75
            .FontName   = "Tahoma"
            .FontBold   = .T.
            .FontItalic = .T.
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Pro\<dutos"
            .Value      = 0
            .Style      = 1
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
        ENDWITH

        *-- Borda/Shape em volta da foto do produto
        THIS.AddObject("shp_4c_Foto", "Shape")
        WITH THIS.shp_4c_Foto
            .Top         = 414
            .Left        = 763
            .Width       = 205
            .Height      = 140
            .BorderColor = RGB(90, 90, 90)
            .BorderWidth = 1
            .FillStyle   = 1
            .BackStyle   = 0
        ENDWITH

        *-- Imagem do produto
        THIS.AddObject("img_4c_Foto", "Image")
        WITH THIS.img_4c_Foto
            .Top     = 415
            .Left    = 764
            .Width   = 203
            .Height  = 138
            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
    *==========================================================================
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top           = 307
            .Left          = 31
            .Width         = 725
            .Height        = 247
            .ColumnCount   = 5
            .FontName      = "Tahoma"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLines     = 3
            .GridLineWidth = 1
            .HeaderHeight  = 17
            .RowHeight     = 17
            .ScrollBars    = 3
            *-- Coluna 1: CheckBox de selecao
            WITH .Column1
                .Width      = 25
                .Movable    = .F.
                .Resizable  = .F.
                .Sparse     = .F.
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Value   = 0
                .CurrentControl = "Check1"
                WITH .Header1
                    .Caption = ""
                    .Tag     = "1"
                ENDWITH
            ENDWITH

            *-- Coluna 2: Codigo do produto
            WITH .Column2
                .Width         = 110
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                WITH .Header1
                    .Caption = "Produto"
                ENDWITH
                WITH .Text1
                    .FontName = "Verdana"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            *-- Coluna 3: Descricao (ReadOnly)
            WITH .Column3
                .Width         = 260
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                WITH .Header1
                    .Caption = "Descri" + CHR(231) + CHR(227) + "o"
                ENDWITH
                WITH .Text1
                    .FontName = "Verdana"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            *-- Coluna 4: Preco Anterior (ReadOnly)
            WITH .Column4
                .Width         = 165
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .Alignment     = 3
                WITH .Header1
                    .Caption = "Pre" + CHR(231) + "o Anterior"
                ENDWITH
                WITH .Text1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .InputMask = "999,999.99"
                ENDWITH
            ENDWITH

            *-- Coluna 5: Preco Atual (editavel se LibValAtu)
            WITH .Column5
                .Width         = 165
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = !THIS.this_lLibValAtu
                .Alignment     = 3
                WITH .Header1
                    .Caption = "Pre" + CHR(231) + "o Atual"
                    IF !THIS.this_lLibValAtu
                        .Picture = gc_4c_CaminhoIcones + "LOCK.BMP"
                    ENDIF
                ENDWITH
                WITH .Text1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .InputMask = "999,999.99"
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_aCursors(16), loc_i
        loc_aCursors(1)  = "cursor_4c_Produtos"
        loc_aCursors(2)  = "cursor_4c_TmpPro"
        loc_aCursors(3)  = "cursor_4c_SigCdGrp"
        loc_aCursors(4)  = "cursor_4c_TmpProSQL"
        loc_aCursors(5)  = "cursor_4c_FigTemp"
        loc_aCursors(6)  = "cursor_4c_BuscaPro"
        loc_aCursors(7)  = "cursor_4c_BuscaProSingle"
        loc_aCursors(8)  = "cursor_4c_BuscaMoe"
        loc_aCursors(9)  = "cursor_4c_BuscaGrp"
        loc_aCursors(10) = "cursor_4c_BuscaCol"
        loc_aCursors(11) = "cursor_4c_BuscaConta"
        loc_aCursors(12) = "cursor_4c_BuscaPromo"
        loc_aCursors(13) = "cursor_4c_BuscaFtio"
        loc_aCursors(14) = "cursor_4c_Selecionados"
        loc_aCursors(15) = "cursor_4c_SigCdPam"
        loc_aCursors(16) = "cursor_4c_SigCdPac"
        FOR loc_i = 1 TO 16
            IF USED(loc_aCursors(loc_i))
                USE IN (loc_aCursors(loc_i))
            ENDIF
        NEXT
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Transferencia Form <-> BO
    *==========================================================================
    PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_nTipo        = THIS.opt_4c_Tipo.Value
            .this_cGrupoInicio = ALLTRIM(THIS.txt_4c_GrupoIni.Value)
            .this_cGrupoFim    = ALLTRIM(THIS.txt_4c_GrupoFim.Value)
            .this_cColecao     = ALLTRIM(THIS.txt_4c_Colecao.Value)
            .this_cConta       = ALLTRIM(THIS.txt_4c_Conta.Value)
            .this_cDConta      = ALLTRIM(THIS.txt_4c_DConta.Value)
            .this_cPromo       = ALLTRIM(THIS.txt_4c_Promo.Value)
            .this_nVariacao    = THIS.txt_4c_Variacao.Value
            .this_cMoeda       = ALLTRIM(THIS.txt_4c_Moeda.Value)
            .this_nMarkUp1     = THIS.txt_4c_MarkUp1.Value
            .this_nMarkUp2     = THIS.txt_4c_MarkUp2.Value
            .this_nFator       = THIS.txt_4c_Fator.Value
            .this_cMoeCusto    = ALLTRIM(THIS.txt_4c_MoeCusto.Value)
            .this_cMoeCs       = ALLTRIM(THIS.txt_4c_MoeCs.Value)
            .this_cMoeCusFs    = ALLTRIM(THIS.txt_4c_MoeCusFs.Value)
            .this_cMoedas      = ALLTRIM(THIS.txt_4c_Moedas.Value)
            .this_cCFtios      = ALLTRIM(THIS.txt_4c_CFtios.Value)
            .this_cMoeVs       = ALLTRIM(THIS.txt_4c_MoeVs.Value)
            .this_nAuditado    = THIS.chk_4c_Auditado.Value
            .this_nLimpar      = THIS.chk_4c_Limpar.Value
            .this_nIncCusts    = THIS.chk_4c_IncCusts.Value
            .this_nIgnorar     = THIS.chk_4c_Ignorar.Value
        ENDWITH
    ENDPROC

    PROCEDURE BOParaForm()
        WITH THIS.this_oBusinessObject
            THIS.opt_4c_Tipo.Value     = .this_nTipo
            THIS.txt_4c_GrupoIni.Value = .this_cGrupoInicio
            THIS.txt_4c_GrupoFim.Value = .this_cGrupoFim
            THIS.txt_4c_Colecao.Value  = .this_cColecao
            THIS.txt_4c_Conta.Value    = .this_cConta
            THIS.txt_4c_DConta.Value   = .this_cDConta
            THIS.txt_4c_Promo.Value    = .this_cPromo
            THIS.txt_4c_Variacao.Value = .this_nVariacao
            THIS.txt_4c_Moeda.Value    = .this_cMoeda
            THIS.txt_4c_MarkUp1.Value  = .this_nMarkUp1
            THIS.txt_4c_MarkUp2.Value  = .this_nMarkUp2
            THIS.txt_4c_Fator.Value    = .this_nFator
            THIS.txt_4c_MoeCusto.Value = .this_cMoeCusto
            THIS.txt_4c_MoeCs.Value    = .this_cMoeCs
            THIS.txt_4c_MoeCusFs.Value = .this_cMoeCusFs
            THIS.txt_4c_Moedas.Value   = .this_cMoedas
            THIS.txt_4c_CFtios.Value   = .this_cCFtios
            THIS.txt_4c_MoeVs.Value    = .this_cMoeVs
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Calcula novos precos e preenche o grid
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.FormParaBO()
            loc_lSucesso = THIS.this_oBusinessObject.ProcessarReajuste()
            IF loc_lSucesso
                THIS.grd_4c_Dados.ColumnCount = 3
                THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
                THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
                THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.CPros"
                THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.DPros"
                THIS.grd_4c_Dados.Refresh()
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Refresh()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAtualizarClick - Grava alteracoes no banco de dados
    *==========================================================================
    PROCEDURE BtnAtualizarClick()
        LOCAL loc_llImpEtiq, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF MsgConfirma("Atualiza" + CHR(63), ;
                "Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")

                THIS.FormParaBO()

                loc_llImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?", "")

                loc_lSucesso = THIS.this_oBusinessObject.AtualizarPrecos(loc_llImpEtiq)

                IF loc_lSucesso
                    THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
                    THIS.cmg_4c_Botoes.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnAtualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Persiste as alteracoes de preco no banco
    * Form OPERACIONAL: delega para BtnAtualizarClick (equivalente ao "sair.Processa")
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnAtualizarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Descarta o pre-processamento e reinicia os filtros
    * Form OPERACIONAL: limpa cursor de produtos, filtros e ajusta botoes
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            THIS.LimparCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Adiciona linha vazia ao grid para entrada manual
    * (equivalente ao modo Auditado do legado - permite user digitar produto)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Produtos")
                SET NULL ON
                CREATE CURSOR cursor_4c_Produtos ( ;
                    lMarca  N(1) NULL, ;
                    CPros   C(14) NULL, ;
                    DPros   C(40) NULL, ;
                    ValAnt  N(14,4) NULL, ;
                    ValAtu  N(14,4) NULL, ;
                    fCustos N(9,4) NULL, ;
                    MoePcs  C(3) NULL, ;
                    CustoFs N(14,4) NULL, ;
                    Manual  N(1) NULL)
                INDEX ON CPros TAG CPros
                SET NULL OFF
            ENDIF

            INSERT INTO cursor_4c_Produtos ;
                (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
                VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)

            SELECT cursor_4c_Produtos
            SET ORDER TO
            GO BOTTOM

            THIS.grd_4c_Dados.ColumnCount = 3
            THIS.grd_4c_Dados.RecordSource            = "cursor_4c_Produtos"
            THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_Produtos.lMarca"
            THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_Produtos.CPros"
            THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_Produtos.DPros"
            THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
            THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.ActivateCell(RECNO("cursor_4c_Produtos"), 2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Recalcula precos (alterar base de calculo)
    * Delega para BtnProcessarClick que executa o processamento principal
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            THIS.BtnProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe foto e detalhes do produto selecionado
    * Refresca a linha atual do grid disparando a mesma logica de AfterRowColChange
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
                MsgAviso("Nenhum produto no grid para visualiza" + CHR(231) + CHR(227) + "o.", ;
                        "Visualizar")
            ELSE
                SELECT cursor_4c_Produtos
                IF EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
                    MsgAviso("Selecione um produto v" + CHR(225) + "lido no grid.", ;
                            "Visualizar")
                ELSE
                    THIS.GrdAfterRowColChange(2)
                    THIS.grd_4c_Dados.Refresh()
                    IF PEMSTATUS(THIS, "img_4c_Foto", 5)
                        THIS.img_4c_Foto.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove produtos marcados/selecionados do grid
    * (nao exclui do banco - apenas remove do cursor de pre-processamento)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nRemovidos, loc_oErro
        loc_nRemovidos = 0

        TRY
            IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
                MsgAviso("Nenhum produto no grid para exclus" + CHR(227) + "o.", "Excluir")
            ELSE
                SELECT cursor_4c_Produtos
                COUNT FOR NVL(lMarca, 0) = 1 TO loc_nRemovidos

                IF loc_nRemovidos = 0
                    IF MsgConfirma("Nenhum produto marcado. Remover o produto atual do grid?", ;
                            "Excluir")
                        IF !EOF("cursor_4c_Produtos")
                            DELETE
                            PACK MEMO
                            loc_nRemovidos = 1
                        ENDIF
                    ENDIF
                ELSE
                    IF MsgConfirma("Remover " + TRANSFORM(loc_nRemovidos) + ;
                            " produto(s) marcado(s) do grid?", "Excluir")
                        DELETE FOR NVL(lMarca, 0) = 1
                        PACK MEMO
                    ELSE
                        loc_nRemovidos = 0
                    ENDIF
                ENDIF

                IF loc_nRemovidos > 0
                    SELECT cursor_4c_Produtos
                    GO TOP
                    THIS.grd_4c_Dados.Refresh()
                    THIS.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * OptTipoChange - Controla visibilidade de campos por tipo de reajuste
    *==========================================================================
    PROCEDURE OptTipoChange()
        LOCAL loc_nTipo
        loc_nTipo = THIS.opt_4c_Tipo.Value

        DO CASE
        CASE loc_nTipo = 1
            THIS.lbl_4c_Variacao.Visible  = .T.
            THIS.txt_4c_Variacao.Visible  = .T.
            THIS.lbl_4c_Pct.Visible       = .T.
            THIS.chk_4c_IncCusts.Visible  = .T.
            THIS.lbl_4c_Moeda.Visible     = .F.
            THIS.txt_4c_Moeda.Visible     = .F.
            THIS.lbl_4c_MarkUp.Visible    = .F.
            THIS.txt_4c_MarkUp1.Visible   = .F.
            THIS.lbl_4c_Para.Visible      = .F.
            THIS.txt_4c_MarkUp2.Visible   = .F.
            THIS.lbl_4c_FatorCusto.Visible = .F.
            THIS.txt_4c_Fator.Visible     = .F.
            THIS.txt_4c_MoeCusto.Visible  = .F.
            THIS.lbl_4c_Moeda1.Visible    = .F.
            THIS.txt_4c_MoeCs.Visible     = .F.
            THIS.lbl_4c_Moeda2.Visible    = .F.
            THIS.txt_4c_MoeCusFs.Visible  = .F.
            THIS.lbl_4c_Moeda4.Visible    = .F.
            THIS.txt_4c_Moedas.Visible    = .F.
            THIS.lbl_4c_Moeda3.Visible    = .F.
            THIS.txt_4c_CFtios.Visible    = .F.
            THIS.lbl_4c_Moeda5.Visible    = .F.
            THIS.txt_4c_MoeVs.Visible     = .F.

        CASE loc_nTipo = 2
            THIS.lbl_4c_Variacao.Visible  = .F.
            THIS.txt_4c_Variacao.Visible  = .F.
            THIS.lbl_4c_Pct.Visible       = .F.
            THIS.chk_4c_IncCusts.Visible  = .F.
            THIS.lbl_4c_Moeda.Visible     = .T.
            THIS.txt_4c_Moeda.Visible     = .T.
            THIS.lbl_4c_MarkUp.Visible    = .T.
            THIS.txt_4c_MarkUp1.Visible   = .T.
            THIS.lbl_4c_Para.Visible      = .T.
            THIS.txt_4c_MarkUp2.Visible   = .T.
            THIS.lbl_4c_FatorCusto.Visible = .T.
            THIS.txt_4c_Fator.Visible     = .T.
            THIS.txt_4c_MoeCusto.Visible  = .T.
            THIS.lbl_4c_Moeda1.Visible    = .T.
            THIS.txt_4c_MoeCs.Visible     = .T.
            THIS.lbl_4c_Moeda2.Visible    = .T.
            THIS.txt_4c_MoeCusFs.Visible  = .T.
            THIS.lbl_4c_Moeda4.Visible    = .T.
            THIS.txt_4c_Moedas.Visible    = .T.
            THIS.lbl_4c_Moeda3.Visible    = .T.
            THIS.txt_4c_CFtios.Visible    = .T.
            THIS.lbl_4c_Moeda5.Visible    = .T.
            THIS.txt_4c_MoeVs.Visible     = .T.

        CASE loc_nTipo = 3
            THIS.lbl_4c_Variacao.Visible  = .F.
            THIS.txt_4c_Variacao.Visible  = .F.
            THIS.lbl_4c_Pct.Visible       = .F.
            THIS.chk_4c_IncCusts.Visible  = .F.
            THIS.lbl_4c_Moeda.Visible     = .F.
            THIS.txt_4c_Moeda.Visible     = .F.
            THIS.lbl_4c_MarkUp.Visible    = .F.
            THIS.txt_4c_MarkUp1.Visible   = .F.
            THIS.lbl_4c_Para.Visible      = .F.
            THIS.txt_4c_MarkUp2.Visible   = .F.
            THIS.lbl_4c_FatorCusto.Visible = .F.
            THIS.txt_4c_Fator.Visible     = .F.
            THIS.txt_4c_MoeCusto.Visible  = .F.
            THIS.lbl_4c_Moeda1.Visible    = .F.
            THIS.txt_4c_MoeCs.Visible     = .F.
            THIS.lbl_4c_Moeda2.Visible    = .F.
            THIS.txt_4c_MoeCusFs.Visible  = .F.
            THIS.lbl_4c_Moeda4.Visible    = .F.
            THIS.txt_4c_Moedas.Visible    = .F.
            THIS.lbl_4c_Moeda3.Visible    = .F.
            THIS.txt_4c_CFtios.Visible    = .F.
            THIS.lbl_4c_Moeda5.Visible    = .F.
            THIS.txt_4c_MoeVs.Visible     = .F.
        ENDCASE

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * ChkAuditadoClick - Modo de edicao manual no grid
    *==========================================================================
    PROCEDURE ChkAuditadoClick()
        IF THIS.chk_4c_Auditado.Value = 1
            *-- Modo Auditado ON: adicionar linha vazia para entrada manual
            IF USED("cursor_4c_Produtos")
                INSERT INTO cursor_4c_Produtos ;
                    (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
                    VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
                SELECT cursor_4c_Produtos
                SET ORDER TO
                GO TOP
            ENDIF
            THIS.txt_4c_GrupoIni.Enabled              = .F.
            THIS.txt_4c_GrupoFim.Enabled              = .F.
            THIS.txt_4c_Colecao.Enabled               = .F.
            THIS.txt_4c_Moeda.Enabled                 = .F.
            THIS.txt_4c_MarkUp1.Enabled               = .F.
            THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .F.
            THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
            THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
            THIS.grd_4c_Dados.Refresh()
        ELSE
            *-- Modo Auditado OFF: limpar grid e restaurar filtros
            IF USED("cursor_4c_Produtos")
                DELETE FROM cursor_4c_Produtos
                SELECT cursor_4c_Produtos
                SET ORDER TO CPros
                GO TOP
            ENDIF
            THIS.txt_4c_GrupoIni.Enabled              = .T.
            THIS.txt_4c_GrupoFim.Enabled              = .T.
            THIS.txt_4c_Colecao.Enabled               = .T.
            THIS.txt_4c_Moeda.Enabled                 = .T.
            THIS.txt_4c_MarkUp1.Enabled               = .T.
            THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .T.
            THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .F.
            THIS.grd_4c_Dados.Column2.ReadOnly        = .T.
            THIS.grd_4c_Dados.Refresh()
            THIS.txt_4c_GrupoIni.SetFocus()
        ENDIF
        THIS.cmg_4c_Botoes.Refresh()
    ENDPROC

    *==========================================================================
    * GrdAfterRowColChange - foto do produto + rastrear edicao manual do preco
    *==========================================================================
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
        LOCAL loc_cArqFig, loc_cSQL, loc_cFoto, loc_oErro

        TRY
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                IF EOF("cursor_4c_Produtos")
                    THIS.img_4c_Foto.Visible = .F.
                    THIS.img_4c_Foto.Picture = ""
                ELSE
                    *-- Rastrear edicao manual do preco (Column5)
                    IF par_nColIndex = 5
                        THIS.this_cAntValue = TRANSFORM(cursor_4c_Produtos.ValAtu)
                    ELSE
                        IF THIS.this_lLibValAtu AND !EMPTY(THIS.this_cAntValue)
                        IF THIS.this_cAntValue != TRANSFORM(cursor_4c_Produtos.ValAtu)
                            REPLACE Manual WITH 1 IN cursor_4c_Produtos
                        ENDIF
                        THIS.this_cAntValue = ""
                        ENDIF
                    ENDIF

                    *-- Exibir foto do produto
                    IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
                        loc_cArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
                        loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Produtos.CPros))
                        IF USED("cursor_4c_FigTemp")
                            USE IN cursor_4c_FigTemp
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigTemp") >= 1
                            SELECT cursor_4c_FigTemp
                            THIS.img_4c_Foto.Visible = .F.
                            THIS.img_4c_Foto.Picture = ""
                            IF !ISNULL(cursor_4c_FigTemp.FigJpgs) AND !EMPTY(cursor_4c_FigTemp.FigJpgs)
                                CLEAR RESOURCES
                                loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigTemp.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                                STRTOFILE(loc_cFoto, loc_cArqFig)
                                THIS.img_4c_Foto.Picture = loc_cArqFig
                                THIS.img_4c_Foto.Visible = .T.
                            ENDIF
                            USE IN cursor_4c_FigTemp
                            SELECT cursor_4c_Produtos
                        ELSE
                            THIS.img_4c_Foto.Visible = .F.
                            THIS.img_4c_Foto.Picture = ""
                        ENDIF
                    ELSE
                        THIS.img_4c_Foto.Visible = .F.
                        THIS.img_4c_Foto.Picture = ""
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_FigTemp")
                USE IN cursor_4c_FigTemp
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro GrdAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdHeaderClick - clicar no header da Column1 marca/desmarca todos
    *==========================================================================
    PROCEDURE GrdHeaderClick()
        IF !USED("cursor_4c_Produtos")
            RETURN
        ENDIF
        IF THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
            UPDATE cursor_4c_Produtos SET lMarca = 1
            THIS.grd_4c_Dados.Column1.Header1.Tag = "1"
        ELSE
            UPDATE cursor_4c_Produtos SET lMarca = 0
            THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
        ENDIF
        THIS.grd_4c_Dados.Refresh()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * GrdKeyPress - Em modo Auditado, dispara lookup de produto ao Enter/Tab/F4
    *==========================================================================
    PROCEDURE GrdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF THIS.chk_4c_Auditado.Value != 1
            RETURN
        ENDIF
        IF THIS.grd_4c_Dados.ActiveColumn != 2
            RETURN
        ENDIF
        LOCAL loc_cVal
        loc_cVal = ALLTRIM(NVL(THIS.grd_4c_Dados.Column2.Text1.Value, ""))
        IF !EMPTY(loc_cVal)
            THIS.AtualizarLinhaGrid(loc_cVal)
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarLinhaGrid - Calcula preco para produto e preenche linha do grid
    * Chamado no modo Auditado quando usuario digita codigo de produto
    *==========================================================================
    PROTECTED PROCEDURE AtualizarLinhaGrid(par_cCPros)
        LOCAL loc_oBO, loc_nTipo, loc_nVariacao, loc_nMarkUp2
        LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPven
        LOCAL loc_cMoePcs, loc_nFCustos, loc_nCustoFs, loc_oErro

        TRY
            loc_oBO       = THIS.this_oBusinessObject
            loc_nTipo     = THIS.opt_4c_Tipo.Value
            loc_nVariacao = THIS.txt_4c_Variacao.Value
            loc_nMarkUp2  = THIS.txt_4c_MarkUp2.Value

            *-- Buscar produto no banco
            IF USED("cursor_4c_BuscaProSingle")
                USE IN cursor_4c_BuscaProSingle
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(par_cCPros), ;
                "cursor_4c_BuscaProSingle") >= 1 ;
               AND RECCOUNT("cursor_4c_BuscaProSingle") > 0

                *-- Inserir no buffer TmpPro se nao existir (para CalcPreco poder ler)
                IF !SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
                    SELECT cursor_4c_BuscaProSingle
                    GO TOP
                    SCATTER MEMVAR MEMO
                    SELECT cursor_4c_TmpPro
                    INSERT INTO cursor_4c_TmpPro FROM MEMVAR
                    INDEX ON CPros TAG CPros
                ENDIF

                *-- Posicionar TmpPro no produto e calcular preco
                IF SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
                SELECT cursor_4c_TmpPro

            *-- Calcular novo preco
            DO CASE
            CASE loc_nTipo = 1
                loc_nValAtu = cursor_4c_TmpPro.PVens + ;
                    ((cursor_4c_TmpPro.PVens * loc_nVariacao) / 100)
            CASE loc_nTipo = 2
                loc_nValAtu = loc_oBO.CalcPreco(loc_nMarkUp2)
            CASE loc_nTipo = 3
                loc_nCotId  = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moedas), ;
                    DATETIME(), gnConnHandle)
                loc_nCotVd  = fBuscarCotacao(ALLTRIM(cursor_4c_TmpPro.moevs), ;
                    DATETIME(), gnConnHandle)
                loc_nPven   = cursor_4c_TmpPro.Pvideals * loc_nCotId / ;
                    IIF(loc_nCotVd = 0, 1, loc_nCotVd)
                loc_nValAtu = loc_nPven / ;
                    IIF(cursor_4c_TmpPro.Encargos <> 0, cursor_4c_TmpPro.Encargos, 1)
            OTHERWISE
                loc_nValAtu = cursor_4c_TmpPro.PVens
            ENDCASE

            loc_cMoePcs  = IIF(EMPTY(ALLTRIM(THIS.txt_4c_MoeCusto.Value)), ;
                ALLTRIM(cursor_4c_TmpPro.MoePcs), ALLTRIM(THIS.txt_4c_MoeCusto.Value))
            loc_nFCustos = IIF(THIS.txt_4c_Fator.Value > 0 AND !EMPTY(loc_cMoePcs), ;
                THIS.txt_4c_Fator.Value, cursor_4c_TmpPro.fCustos)
            loc_nCustoFs = cursor_4c_TmpPro.CustoFs

            *-- Atualizar linha corrente no grid
            SELECT cursor_4c_Produtos
            REPLACE lMarca   WITH 1,                              ;
                    CPros    WITH par_cCPros,                     ;
                    DPros    WITH ALLTRIM(cursor_4c_TmpPro.DPros), ;
                    ValAnt   WITH cursor_4c_TmpPro.PVens,          ;
                    ValAtu   WITH loc_nValAtu,                     ;
                    fCustos  WITH loc_nFCustos,                   ;
                    MoePcs   WITH loc_cMoePcs,                    ;
                    CustoFs  WITH loc_nCustoFs,                   ;
                    Manual   WITH 0

            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Refresh()

            *-- Adicionar linha vazia para o proximo produto
            SELECT cursor_4c_Produtos
            SET ORDER TO
            GO BOTTOM
            IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
                INSERT INTO cursor_4c_Produtos ;
                    (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
                    VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
            ENDIF
            SELECT cursor_4c_Produtos
            THIS.grd_4c_Dados.Refresh()
            KEYBOARD "{DNARROW}"

                    IF USED("cursor_4c_BuscaProSingle")
                        USE IN cursor_4c_BuscaProSingle
                    ENDIF
                ELSE
                    IF USED("cursor_4c_BuscaProSingle")
                        USE IN cursor_4c_BuscaProSingle
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Produto n" + CHR(227) + "o encontrado: " + par_cCPros, "Produto")
                IF USED("cursor_4c_BuscaProSingle")
                    USE IN cursor_4c_BuscaProSingle
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaProSingle")
                USE IN cursor_4c_BuscaProSingle
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro AtualizarLinhaGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Lookup handlers - Grupo
    *==========================================================================
    PROCEDURE TxtGrupoIniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaGrupo(THIS.txt_4c_GrupoIni, THIS.txt_4c_GrupoFim)
    ENDPROC

    PROCEDURE TxtGrupoFimKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaGrupo(THIS.txt_4c_GrupoFim, .NULL.)
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrupo(par_oTxtAlvo, par_oTxtFim)
        LOCAL loc_cVal, loc_oBA, loc_oErro
        loc_cVal = ALLTRIM(par_oTxtAlvo.Value)
        IF !EMPTY(loc_cVal)
            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
                EscaparSQL(loc_cVal), "cursor_4c_BuscaGrp") > 0
                SELECT cursor_4c_BuscaGrp
                GO TOP
                IF !EOF("cursor_4c_BuscaGrp")
                    par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                    IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
                        par_oTxtFim.Value = par_oTxtAlvo.Value
                    ENDIF
                    USE IN cursor_4c_BuscaGrp
                    RETURN
                ENDIF
                USE IN cursor_4c_BuscaGrp
            ENDIF
        ENDIF
        TRY
            loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
                "cursor_4c_BuscaGrp", "CGrus", loc_cVal, ;
                "Grupos de Produto", .T., .T., "")
            IF VARTYPE(loc_oBA) = "O"
                loc_oBA.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                loc_oBA.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBA.Show()
                IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                    SELECT cursor_4c_BuscaGrp
                    GO TOP
                    par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                    IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
                        par_oTxtFim.Value = par_oTxtAlvo.Value
                    ENDIF
                ELSE
                    par_oTxtAlvo.Value = ""
                ENDIF
                IF USED("cursor_4c_BuscaGrp")
                    USE IN cursor_4c_BuscaGrp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Lookup Colecao
    *==========================================================================
    PROCEDURE TxtColecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cVal, loc_oBA, loc_oErro
        loc_cVal = ALLTRIM(THIS.txt_4c_Colecao.Value)
        IF !EMPTY(loc_cVal)
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
                EscaparSQL(loc_cVal), "cursor_4c_BuscaCol") > 0
                SELECT cursor_4c_BuscaCol
                GO TOP
                IF !EOF("cursor_4c_BuscaCol")
                    THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
                    USE IN cursor_4c_BuscaCol
                    RETURN
                ENDIF
                USE IN cursor_4c_BuscaCol
            ENDIF
        ENDIF
        TRY
            loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", ;
                "cursor_4c_BuscaCol", "Colecoes", loc_cVal, ;
                "Cole" + CHR(231) + CHR(245) + "es", .T., .T., "")
            IF VARTYPE(loc_oBA) = "O"
                loc_oBA.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
                loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBA.Show()
                IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaCol")
                    SELECT cursor_4c_BuscaCol
                    GO TOP
                    THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
                ELSE
                    THIS.txt_4c_Colecao.Value = ""
                ENDIF
                IF USED("cursor_4c_BuscaCol")
                    USE IN cursor_4c_BuscaCol
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro TxtColecaoKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Lookup Fornecedor por codigo
    *==========================================================================
    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cVal, loc_cGrupo, loc_cFiltro, loc_oBA, loc_oErro
        loc_cVal   = ALLTRIM(THIS.txt_4c_Conta.Value)
        loc_cGrupo = THIS.this_oBusinessObject.this_cGrPadFors
        loc_cFiltro = IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), "")

        IF !EMPTY(loc_cVal)
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                EscaparSQL(loc_cVal) + loc_cFiltro, "cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                GO TOP
                IF !EOF("cursor_4c_BuscaConta")
                    THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                    THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                    USE IN cursor_4c_BuscaConta
                    RETURN
                ENDIF
                USE IN cursor_4c_BuscaConta
            ENDIF
        ENDIF
        TRY
            LOCAL loc_cFiltroBA
            loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
            loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
                "cursor_4c_BuscaConta", "IClis", loc_cVal, ;
                "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
            IF VARTYPE(loc_oBA) = "O"
                loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBA.mAddColuna("RClis", "", "Nome")
                loc_oBA.Show()
                IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    GO TOP
                    THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                    THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                ELSE
                    THIS.txt_4c_Conta.Value  = ""
                    THIS.txt_4c_DConta.Value = ""
                ENDIF
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro TxtContaKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Lookup Fornecedor por nome (somente quando Conta vazio)
    *==========================================================================
    PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
            RETURN
        ENDIF
        LOCAL loc_cVal, loc_cGrupo, loc_cFiltroBA, loc_oBA, loc_oErro
        loc_cVal    = ALLTRIM(THIS.txt_4c_DConta.Value)
        loc_cGrupo  = THIS.this_oBusinessObject.this_cGrPadFors
        loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")

        IF !EMPTY(loc_cVal)
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
                EscaparSQL(loc_cVal + "%") + ;
                IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), ""), ;
                "cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                GO TOP
                IF !EOF("cursor_4c_BuscaConta")
                    THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                    THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                    USE IN cursor_4c_BuscaConta
                    RETURN
                ENDIF
                USE IN cursor_4c_BuscaConta
            ENDIF
        ENDIF
        TRY
            loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
                "cursor_4c_BuscaConta", "RClis", loc_cVal, ;
                "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
            IF VARTYPE(loc_oBA) = "O"
                loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBA.mAddColuna("RClis", "", "Nome")
                loc_oBA.Show()
                IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    GO TOP
                    THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                    THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                ELSE
                    THIS.txt_4c_DConta.Value = ""
                ENDIF
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro TxtDContaKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Lookup Promocao
    *==========================================================================
    PROCEDURE TxtPromoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cVal, loc_oBA, loc_oErro
        loc_cVal = ALLTRIM(THIS.txt_4c_Promo.Value)
        IF !EMPTY(loc_cVal)
            IF USED("cursor_4c_BuscaPromo")
                USE IN cursor_4c_BuscaPromo
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Promos FROM SigPrPmc WHERE Promos = " + ;
                EscaparSQL(loc_cVal), "cursor_4c_BuscaPromo") > 0
                SELECT cursor_4c_BuscaPromo
                GO TOP
                IF !EOF("cursor_4c_BuscaPromo")
                    THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
                    USE IN cursor_4c_BuscaPromo
                    RETURN
                ENDIF
                USE IN cursor_4c_BuscaPromo
            ENDIF
        ENDIF
        TRY
            loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrPmc", ;
                "cursor_4c_BuscaPromo", "Promos", loc_cVal, ;
                "Promo" + CHR(231) + CHR(227) + "o", .T., .T., "")
            IF VARTYPE(loc_oBA) = "O"
                loc_oBA.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
                loc_oBA.Show()
                IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaPromo")
                    SELECT cursor_4c_BuscaPromo
                    GO TOP
                    THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
                ELSE
                    THIS.txt_4c_Promo.Value = ""
                ENDIF
                IF USED("cursor_4c_BuscaPromo")
                    USE IN cursor_4c_BuscaPromo
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro TxtPromoKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Lookup generico de Moeda (reutilizado por varios campos)
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaMoeda(par_oTxt)
        LOCAL loc_cVal, loc_oBA, loc_oErro
        loc_cVal = ALLTRIM(par_oTxt.Value)
        IF !EMPTY(loc_cVal)
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
                EscaparSQL(loc_cVal), "cursor_4c_BuscaMoe") > 0
                SELECT cursor_4c_BuscaMoe
                GO TOP
                IF !EOF("cursor_4c_BuscaMoe")
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                    USE IN cursor_4c_BuscaMoe
                    RETURN
                ENDIF
                USE IN cursor_4c_BuscaMoe
            ENDIF
        ENDIF
        TRY
            loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
                "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas", .T., .T., "")
            IF VARTYPE(loc_oBA) = "O"
                loc_oBA.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oBA.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBA.Show()
                IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    GO TOP
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                ELSE
                    par_oTxt.Value = ""
                ENDIF
                IF USED("cursor_4c_BuscaMoe")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaMoeda")
        ENDTRY
    ENDPROC

    PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaMoeda(THIS.txt_4c_Moeda)
    ENDPROC

    PROCEDURE TxtMoeCsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCs)
    ENDPROC

    PROCEDURE TxtMoeCusFsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCusFs)
    ENDPROC

    PROCEDURE TxtMoedasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaMoeda(THIS.txt_4c_Moedas)
    ENDPROC

    PROCEDURE TxtMoeVsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeVs)
    ENDPROC

    PROCEDURE TxtMoeCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCusto)
    ENDPROC

    *==========================================================================
    * Lookup Feitio
    *==========================================================================
    PROCEDURE TxtCFtiosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cVal, loc_oBA, loc_oErro
        loc_cVal = ALLTRIM(THIS.txt_4c_CFtios.Value)
        IF !EMPTY(loc_cVal)
            IF USED("cursor_4c_BuscaFtio")
                USE IN cursor_4c_BuscaFtio
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
                EscaparSQL(loc_cVal), "cursor_4c_BuscaFtio") > 0
                SELECT cursor_4c_BuscaFtio
                GO TOP
                IF !EOF("cursor_4c_BuscaFtio")
                    THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
                    USE IN cursor_4c_BuscaFtio
                    RETURN
                ENDIF
                USE IN cursor_4c_BuscaFtio
            ENDIF
        ENDIF
        TRY
            loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrFti", ;
                "cursor_4c_BuscaFtio", "Cods", loc_cVal, "Feitio", .T., .T., "")
            IF VARTYPE(loc_oBA) = "O"
                loc_oBA.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBA.Show()
                IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
                    SELECT cursor_4c_BuscaFtio
                    GO TOP
                    THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
                ELSE
                    THIS.txt_4c_CFtios.Value = ""
                ENDIF
                IF USED("cursor_4c_BuscaFtio")
                    USE IN cursor_4c_BuscaFtio
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro TxtCFtiosKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles do container visiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        IF VARTYPE(par_oContainer) # "O"
            RETURN
        ENDIF
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
            IF INLIST(LOWER(loc_oControl.Name), "cnt_4c_cabecalho")
                LOOP
            ENDIF
            loc_oControl.Visible = .T.
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Form OPERACIONAL: consolida cabecalho, botoes,
    * filtros e grade num unico layout (equivalente da "Page1 - Lista" dos CRUD)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_lJaConfigurado

        loc_lJaConfigurado = PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5) ;
                         AND PEMSTATUS(THIS, "cmg_4c_Botoes", 5) ;
                         AND PEMSTATUS(THIS, "grd_4c_Dados", 5)

        IF !loc_lJaConfigurado
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoes()
            THIS.ConfigurarFiltros()
            THIS.ConfigurarGrade()
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
            SELECT cursor_4c_Produtos
            GO TOP
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL nao usa PageFrame com Page1/Page2.
    * Todos os controles (filtros + grade + botoes) convivem no mesmo layout.
    * O metodo mantem a assinatura padrao do pipeline reposicionando o foco
    * no primeiro controle relevante (filtro ou grade) conforme par_nPagina.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina

        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)

        DO CASE
        CASE loc_nPagina = 1
            IF PEMSTATUS(THIS, "txt_4c_GrupoIni", 5) AND THIS.txt_4c_GrupoIni.Enabled
                THIS.txt_4c_GrupoIni.SetFocus()
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                GO TOP
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CASE loc_nPagina = 2
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Enabled
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        ENDCASE

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarLista - Inicializa o cursor do grid com estrutura vazia
    * Form OPERACIONAL: dados sao populados via BtnProcessarClick, nao aqui.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            SET NULL ON
            IF USED("cursor_4c_Produtos")
                IF TABLEREVERT(.T., "cursor_4c_Produtos")
                ENDIF
                USE IN cursor_4c_Produtos
            ENDIF

            CREATE CURSOR cursor_4c_Produtos ( ;
                lMarca  N(1) NULL, ;
                CPros   C(14) NULL, ;
                DPros   C(40) NULL, ;
                ValAnt  N(14,4) NULL, ;
                ValAtu  N(14,4) NULL, ;
                fCustos N(9,4) NULL, ;
                MoePcs  C(3) NULL, ;
                CustoFs N(14,4) NULL, ;
                Manual  N(1) NULL)
            INDEX ON CPros TAG CPros
            SET NULL OFF

            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.ColumnCount = 5
                THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
                THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
                THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.CPros"
                THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.DPros"
                THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
                THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            THIS.AjustarBotoesPorModo()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            SET NULL OFF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarLista FormSigPrApr")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta todos os campos de filtro e esvazia o grid
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.txt_4c_GrupoIni.Value  = ""
        THIS.txt_4c_GrupoFim.Value  = ""
        THIS.txt_4c_Colecao.Value   = ""
        THIS.txt_4c_Conta.Value     = ""
        THIS.txt_4c_DConta.Value    = ""
        THIS.txt_4c_Promo.Value     = ""
        THIS.txt_4c_Variacao.Value  = 0
        THIS.txt_4c_Moeda.Value     = ""
        THIS.txt_4c_MarkUp1.Value   = 0
        THIS.txt_4c_MarkUp2.Value   = 0
        THIS.txt_4c_Fator.Value     = 0
        THIS.txt_4c_MoeCusto.Value  = ""
        THIS.txt_4c_MoeCs.Value     = ""
        THIS.txt_4c_MoeCusFs.Value  = ""
        THIS.txt_4c_Moedas.Value    = ""
        THIS.txt_4c_CFtios.Value    = ""
        THIS.txt_4c_MoeVs.Value     = ""
        THIS.chk_4c_IncCusts.Value  = 0
        THIS.chk_4c_Limpar.Value    = 0
        THIS.chk_4c_Ignorar.Value   = 0
        THIS.chk_4c_Auditado.Value  = 0

        THIS.opt_4c_Tipo.Value = 1
        THIS.OptTipoChange()

        IF PEMSTATUS(THIS, "img_4c_Foto", 5)
            THIS.img_4c_Foto.Visible = .F.
            THIS.img_4c_Foto.Picture = ""
        ENDIF

        THIS.CarregarLista()

        THIS.txt_4c_GrupoIni.SetFocus()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de filtro
    * par_lHabilitar: .T. = habilitar filtros (estado inicial / pos-Atualizar)
    *                 .F. = desabilitar filtros (durante modo Auditado)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        THIS.txt_4c_GrupoIni.Enabled = loc_lHab
        THIS.txt_4c_GrupoFim.Enabled = loc_lHab
        THIS.txt_4c_Colecao.Enabled  = loc_lHab
        THIS.txt_4c_Moeda.Enabled    = loc_lHab
        THIS.txt_4c_MarkUp1.Enabled  = loc_lHab
        THIS.opt_4c_Tipo.Enabled     = loc_lHab

        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab
        ENDIF

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Controla estados dos botoes baseado no grid
    * Processar: sempre habilitado (a menos que em modo Auditado)
    * Atualizar: habilitado somente quando ha produtos processados no grid
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemProdutos, loc_lModoAuditado

        loc_lTemProdutos  = USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
        loc_lModoAuditado = PEMSTATUS(THIS, "chk_4c_Auditado", 5) ;
                        AND THIS.chk_4c_Auditado.Value = 1

        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = !loc_lModoAuditado
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lTemProdutos
            THIS.cmg_4c_Botoes.Refresh()
        ENDIF
    ENDPROC

ENDDEFINE
