*==============================================================================
* FORMSIGREINV.PRG
* Relatorio de Inventario de Estoque
* Tipo: REPORT com filtros (herda FormBase, BO herda RelatorioBase)
* Migrado de: SigReInv.SCX (frmrelatorio)
*
* Layout FLAT: Sem PageFrame. Controles criados diretamente no form.
* Dimensoes originais: Width=800, Height=600
* Botoes: Visualizar / Imprimir / DocExcel (Excel) / Encerrar
* Filtros: Empresa, Tipo Inventario, Saldo, Tipo Valor, Moeda, ICMS, Posicao, Data
* Botao extra: "Gera Inventario TXT" (Command1 do legado)
*==============================================================================

DEFINE CLASS FormSigReInv AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=600)
    Height      = 600
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura visual: cabecalho + botoes + filtros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio de Estoque"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SigReInvBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReInvBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Carrega cursores base (empresas, moedas, cotacoes etc.)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !THIS.this_oRelatorio.CarregarDadosIniciais()
                        IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                        ENDIF
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarFiltros()

                *-- Vincular eventos dos botoes (BINDEVENT exige metodos PUBLIC)
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnGerarTxtClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

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
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
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
                .Caption   = "Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio de Estoque"
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
                .Caption   = "Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio de Estoque"
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
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Posicao equivalente ao btnReport do legado: Left=524, Top=7
    *   Botao 3 = "Gera TXT" (no lugar do DocExcel do padrao, habilitado aqui)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
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
                .ToolTipText     = "Visualizar Relat" + CHR(243) + "rio"
                .Themes          = .F.
                .Enabled         = .T.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Imprimir Relat" + CHR(243) + "rio"
                .Themes          = .F.
                .Enabled         = .T.
                .Visible         = .T.
            ENDWITH

            *-- Botao 3: Gera Inventario TXT (equivalente ao Command1 do legado)
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Gera TXT"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gera Invent" + CHR(225) + "rio TXT (Modelo P7)"
                .Themes          = .F.
                .Enabled         = .T.
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
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
    * ConfigurarFiltros - Cria todos os controles de filtro do form
    *   Posicoes e dimensoes extraidas diretamente do SCX legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_lMedioVisivel, loc_lVendaVisivel
        loc_lMedioVisivel = .T.
        loc_lVendaVisivel = .T.

        *-- Label Empresa
        THIS.AddObject("lbl_4c_Empresa", "Label")
        WITH THIS.lbl_4c_Empresa
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Left      = 164
            .Top       = 160
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo da empresa (Get_Cd_Empresa)
        THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH THIS.txt_4c_CdEmpresa
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Format        = "K!"
            .Height        = 25
            .InputMask     = "XXX"
            .Left          = 219
            .MaxLength     = 3
            .SpecialEffect = 1
            .TabIndex      = 1
            .Top           = 156
            .Width         = 31
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaCdEmpresa")
        BINDEVENT(THIS.txt_4c_CdEmpresa, "DblClick", THIS, "EmpresaDblClick")

        *-- Descricao da empresa (Get_Ds_Empresa)
        THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH THIS.txt_4c_DsEmpresa
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 25
            .Left          = 252
            .MaxLength     = 40
            .SpecialEffect = 1
            .TabIndex      = 2
            .Top           = 156
            .Width         = 290
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_DsEmpresa, "When", THIS, "WhenDsEmpresa")

        *-- Label Inventario
        THIS.AddObject("lbl_4c_Inventario", "Label")
        WITH THIS.lbl_4c_Inventario
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Invent" + CHR(225) + "rio :"
            .Left      = 155
            .Top       = 185
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Shape agrupador de Inventario
        THIS.AddObject("shp_4c_Inv", "Shape")
        WITH THIS.shp_4c_Inv
            .Top           = 185
            .Left          = 219
            .Height        = 58
            .Width         = 243
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- ChkInv1: Proprio (Value=1)
        THIS.AddObject("chk_4c_Inv1", "CheckBox")
        WITH THIS.chk_4c_Inv1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Pr" + CHR(243) + "prio"
            .Value     = 1
            .Left      = 223
            .Top       = 189
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 3
            .Visible   = .T.
        ENDWITH

        *-- ChkInv2: Produto proprio em poder de terceiros
        THIS.AddObject("chk_4c_Inv2", "CheckBox")
        WITH THIS.chk_4c_Inv2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Produto pr" + CHR(243) + "prio em poder de 3" + CHR(176) + "s"
            .Value     = 0
            .Left      = 223
            .Top       = 206
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 4
            .Visible   = .T.
        ENDWITH

        *-- ChkInv3: Produto de terceiros em nosso poder
        THIS.AddObject("chk_4c_Inv3", "CheckBox")
        WITH THIS.chk_4c_Inv3
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Produto de 3" + CHR(176) + "s em nosso poder"
            .Value     = 0
            .Left      = 223
            .Top       = 223
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 5
            .Visible   = .T.
        ENDWITH

        *-- Label Saldo
        THIS.AddObject("lbl_4c_Saldo", "Label")
        WITH THIS.lbl_4c_Saldo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Saldo :"
            .Left      = 179
            .Top       = 243
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Shape agrupador de Saldo
        THIS.AddObject("shp_4c_Saldo", "Shape")
        WITH THIS.shp_4c_Saldo
            .Top           = 248
            .Left          = 219
            .Height        = 42
            .Width         = 243
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- ChkSaldo1: Positivo (Value=1, Enabled=.F. - habilitado por tipo de valor)
        THIS.AddObject("chk_4c_Saldo1", "CheckBox")
        WITH THIS.chk_4c_Saldo1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Positivo"
            .Value     = 1
            .Enabled   = .F.
            .Left      = 223
            .Top       = 252
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 6
            .Visible   = .T.
        ENDWITH

        *-- ChkSaldo2: Negativo (Enabled=.F.)
        THIS.AddObject("chk_4c_Saldo2", "CheckBox")
        WITH THIS.chk_4c_Saldo2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Negativo"
            .Value     = 0
            .Enabled   = .F.
            .Left      = 223
            .Top       = 269
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 7
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_Saldo1, "Valid", THIS, "ValidSaldo1")
        BINDEVENT(THIS.chk_4c_Saldo2, "Valid", THIS, "ValidSaldo2")

        *-- Label Valor
        THIS.AddObject("lbl_4c_Valor", "Label")
        WITH THIS.lbl_4c_Valor
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Valor :"
            .Left      = 181
            .Top       = 285
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Shape agrupador de Valor
        THIS.AddObject("shp_4c_Valor", "Shape")
        WITH THIS.shp_4c_Valor
            .Top           = 295
            .Left          = 219
            .Height        = 94
            .Width         = 243
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- ChkValor1: UEPS
        THIS.AddObject("chk_4c_Valor1", "CheckBox")
        WITH THIS.chk_4c_Valor1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "UEPS"
            .Value     = 0
            .Left      = 223
            .Top       = 301
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_Valor1, "Valid", THIS, "ValidValor1")

        *-- ChkValor2: PEPS (Value=1 = default)
        THIS.AddObject("chk_4c_Valor2", "CheckBox")
        WITH THIS.chk_4c_Valor2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "PEPS"
            .Value     = 1
            .Left      = 223
            .Top       = 318
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 9
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_Valor2, "Valid", THIS, "ValidValor2")

        *-- ChkValor3: Custo
        THIS.AddObject("chk_4c_Valor3", "CheckBox")
        WITH THIS.chk_4c_Valor3
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Custo"
            .Value     = 0
            .Left      = 223
            .Top       = 335
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 10
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_Valor3, "Valid", THIS, "ValidValor3")

        *-- ChkValor4: Custo Medio (visibilidade por acesso)
        THIS.AddObject("chk_4c_Valor4", "CheckBox")
        WITH THIS.chk_4c_Valor4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Custo M" + CHR(233) + "dio"
            .Value     = 0
            .Left      = 223
            .Top       = 352
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 11
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_Valor4, "Valid", THIS, "ValidValor4")

        *-- ChkValor5: Venda (visibilidade por acesso)
        THIS.AddObject("chk_4c_Valor5", "CheckBox")
        WITH THIS.chk_4c_Valor5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Venda"
            .Value     = 0
            .Left      = 223
            .Top       = 369
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 12
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_Valor5, "Valid", THIS, "ValidValor5")

        *-- Label Fator (Get_MoeFator)
        THIS.AddObject("lbl_4c_Fator", "Label")
        WITH THIS.lbl_4c_Fator
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Fator :"
            .Left      = 179
            .Top       = 396
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Moeda Fator (Get_MoeFator) - codigo de moeda para fator manual
        THIS.AddObject("txt_4c_MoeFator", "TextBox")
        WITH THIS.txt_4c_MoeFator
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Format        = "K!"
            .Height        = 25
            .Left          = 219
            .MaxLength     = 3
            .SpecialEffect = 1
            .TabIndex      = 13
            .Top           = 392
            .Width         = 37
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoeFator, "KeyPress", THIS, "TeclaMoeFator")
        BINDEVENT(THIS.txt_4c_MoeFator, "DblClick", THIS, "MoeFatorDblClick")

        *-- Valor Fator (Get_ValFator) - somente leitura, calculado
        THIS.AddObject("txt_4c_ValFator", "TextBox")
        WITH THIS.txt_4c_ValFator
            .FontName             = "Tahoma"
            .Alignment            = 1
            .BorderStyle          = 1
            .Value                = 0
            .Height               = 25
            .InputMask            = "999999.999"
            .Left                 = 258
            .MaxLength            = 10
            .SpecialEffect        = 1
            .TabIndex             = 14
            .Top                  = 392
            .Width                = 95
            .ForeColor            = RGB(0, 0, 0)
            .DisabledBackColor    = RGB(192, 192, 192)
            .DisabledForeColor    = RGB(192, 192, 192)
            .Enabled              = .F.
            .Visible              = .T.
        ENDWITH

        *-- Label Moeda de Conversao
        THIS.AddObject("lbl_4c_Moeda", "Label")
        WITH THIS.lbl_4c_Moeda
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Moeda de Convers" + CHR(227) + "o :"
            .Height    = 15
            .Left      = 103
            .Top       = 424
            .Width     = 111
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Moeda de conversao - codigo (get_moeda)
        THIS.AddObject("txt_4c_Moeda", "TextBox")
        WITH THIS.txt_4c_Moeda
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "!"
            .Height        = 25
            .Left          = 219
            .MaxLength     = 3
            .SpecialEffect = 1
            .TabIndex      = 15
            .ToolTipText   = "Converte os valores para esta moeda. Este par" + CHR(226) + "metro tem prioridade sobre o fator."
            .Top           = 419
            .Width         = 37
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_Moeda, "KeyPress", THIS, "TeclaMoeda")
        BINDEVENT(THIS.txt_4c_Moeda, "DblClick", THIS, "MoedaDblClick")

        *-- Moeda de conversao - descricao (get_moeda_desc)
        THIS.AddObject("txt_4c_MoedaDesc", "TextBox")
        WITH THIS.txt_4c_MoedaDesc
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "!"
            .Height        = 25
            .Left          = 258
            .MaxLength     = 15
            .SpecialEffect = 1
            .TabIndex      = 16
            .Top           = 419
            .Width         = 95
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoedaDesc, "When", THIS, "WhenMoedaDesc")
        BINDEVENT(THIS.txt_4c_MoedaDesc, "KeyPress", THIS, "TeclaMoedaDesc")
        BINDEVENT(THIS.txt_4c_MoedaDesc, "DblClick", THIS, "MoedaDescDblClick")

        *-- Label Retira ICMS
        THIS.AddObject("lbl_4c_ICMS", "Label")
        WITH THIS.lbl_4c_ICMS
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Retira ICMS :"
            .Height    = 15
            .Left      = 148
            .Top       = 452
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup ICMS (Opt_ICMS): Value=2=Nao por default
        THIS.AddObject("opt_4c_ICMS", "OptionGroup")
        WITH THIS.opt_4c_ICMS
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 25
            .Left          = 216
            .SpecialEffect = 0
            .Top           = 448
            .Width         = 133
            .TabIndex      = 17
            .Visible       = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Value     = 0
                .Height    = 15
                .Left      = 4
                .Top       = 4
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Value     = 1
                .Height    = 15
                .Left      = 56
                .Top       = 4
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.opt_4c_ICMS, "InteractiveChange", THIS, "IcmsInteractiveChange")

        *-- Label Posicao
        THIS.AddObject("lbl_4c_Posicao", "Label")
        WITH THIS.lbl_4c_Posicao
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Posi" + CHR(231) + CHR(227) + "o :"
            .Left      = 169
            .Top       = 476
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Posicao (OptPosicao): 1=Atual 2=Retroativa
        THIS.AddObject("opt_4c_Posicao", "OptionGroup")
        WITH THIS.opt_4c_Posicao
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 25
            .Left          = 216
            .SpecialEffect = 0
            .Top           = 472
            .Width         = 138
            .TabIndex      = 18
            .Value         = 1
            .Visible       = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "Atual"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left      = 5
                .Top       = 5
                .Width     = 43
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Retroativa :"
                .Left      = 57
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.opt_4c_Posicao, "InteractiveChange", THIS, "PosicaoInteractiveChange")

        *-- Data do saldo retroativo (GetDataSaldo)
        THIS.AddObject("txt_4c_DataSaldo", "TextBox")
        WITH THIS.txt_4c_DataSaldo
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Height        = 23
            .Left          = 360
            .MaxLength     = 10
            .SpecialEffect = 1
            .TabIndex      = 19
            .Top           = 474
            .Width         = 79
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa valores dos filtros conforme valores default do legado
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_cRazas, loc_cEmpAtual
        TRY
            loc_cEmpAtual = go_4c_Sistema.cCodEmpresa
            loc_cRazas    = ""

            IF USED("CrSigCdEmp")
                IF SEEK(loc_cEmpAtual, "CrSigCdEmp", "CEmps")
                    loc_cRazas = CrSigCdEmp.Razas
                ENDIF
            ENDIF

            THIS.txt_4c_CdEmpresa.Value  = loc_cEmpAtual
            THIS.txt_4c_DsEmpresa.Value  = loc_cRazas
            THIS.txt_4c_MoeFator.Value   = ""
            THIS.txt_4c_ValFator.Value   = 0
            THIS.txt_4c_Moeda.Value      = ""
            THIS.txt_4c_MoedaDesc.Value  = ""
            THIS.opt_4c_ICMS.Value       = 2
            THIS.opt_4c_Posicao.Value    = 1
            THIS.txt_4c_DataSaldo.Value  = DATE()
            THIS.txt_4c_DataSaldo.Enabled = .F.
            THIS.chk_4c_Inv1.Value       = 1
            THIS.chk_4c_Inv2.Value       = 0
            THIS.chk_4c_Inv3.Value       = 0
            THIS.chk_4c_Saldo1.Value     = 1
            THIS.chk_4c_Saldo2.Value     = 0
            THIS.chk_4c_Saldo1.Enabled   = .F.
            THIS.chk_4c_Saldo2.Enabled   = .F.
            THIS.chk_4c_Valor1.Value     = 0
            THIS.chk_4c_Valor2.Value     = 1
            THIS.chk_4c_Valor3.Value     = 0
            THIS.chk_4c_Valor4.Value     = 0
            THIS.chk_4c_Valor5.Value     = 0

            THIS.txt_4c_CdEmpresa.SetFocus

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidacaoEntrada - Valida campos obrigatorios antes de processar
    * Retorna .T. se ok, .F. se ha erro (posiciona foco no campo errado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidacaoEntrada()
        LOCAL loc_lOk
        loc_lOk = .T.
        TRY
            IF EMPTY(THIS.txt_4c_CdEmpresa.Value)
                MsgAviso("Empresa Inv" + CHR(225) + "lida !!!", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_CdEmpresa.SetFocus
                loc_lOk = .F.
            ENDIF

            IF loc_lOk AND THIS.opt_4c_Posicao.Value = 2 AND EMPTY(THIS.txt_4c_DataSaldo.Value)
                MsgAviso("Data de Refer" + CHR(234) + "ncia de Estoque Inv" + CHR(225) + "lida !!!", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_DataSaldo.SetFocus
                loc_lOk = .F.
            ENDIF

            IF loc_lOk
                IF THIS.chk_4c_Inv1.Value = 0 AND THIS.chk_4c_Inv2.Value = 0 AND THIS.chk_4c_Inv3.Value = 0
                    MsgAviso("Nenhum Tipo de Invent" + CHR(225) + "rio Selecionado !!!", "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
                    THIS.chk_4c_Inv1.SetFocus
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF loc_lOk
                IF THIS.chk_4c_Valor1.Value = 0 AND THIS.chk_4c_Valor2.Value = 0 AND ;
                   THIS.chk_4c_Valor3.Value = 0 AND THIS.chk_4c_Valor4.Value = 0 AND ;
                   THIS.chk_4c_Valor5.Value = 0
                    MsgAviso("Nenhum Tipo de Valor Selecionado !!!", "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
                    THIS.chk_4c_Valor1.SetFocus
                    loc_lOk = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores do form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaRelatorio()
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.this_cCdEmpresa  = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
                THIS.this_oRelatorio.this_cDsEmpresa  = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
                THIS.this_oRelatorio.this_nChkInv1    = THIS.chk_4c_Inv1.Value
                THIS.this_oRelatorio.this_nChkInv2    = THIS.chk_4c_Inv2.Value
                THIS.this_oRelatorio.this_nChkInv3    = THIS.chk_4c_Inv3.Value
                THIS.this_oRelatorio.this_nChkSaldo1  = THIS.chk_4c_Saldo1.Value
                THIS.this_oRelatorio.this_nChkSaldo2  = THIS.chk_4c_Saldo2.Value
                THIS.this_oRelatorio.this_nChkValor1  = THIS.chk_4c_Valor1.Value
                THIS.this_oRelatorio.this_nChkValor2  = THIS.chk_4c_Valor2.Value
                THIS.this_oRelatorio.this_nChkValor3  = THIS.chk_4c_Valor3.Value
                THIS.this_oRelatorio.this_nChkValor4  = THIS.chk_4c_Valor4.Value
                THIS.this_oRelatorio.this_nChkValor5  = THIS.chk_4c_Valor5.Value
                THIS.this_oRelatorio.this_cMoeFator   = ALLTRIM(THIS.txt_4c_MoeFator.Value)
                THIS.this_oRelatorio.this_nValFator   = THIS.txt_4c_ValFator.Value
                THIS.this_oRelatorio.this_cMoeda      = ALLTRIM(THIS.txt_4c_Moeda.Value)
                THIS.this_oRelatorio.this_cMoedaDesc  = ALLTRIM(THIS.txt_4c_MoedaDesc.Value)
                THIS.this_oRelatorio.this_nOptIcms    = THIS.opt_4c_ICMS.Value
                THIS.this_oRelatorio.this_lImpIcms    = (THIS.opt_4c_ICMS.Value = 1)
                THIS.this_oRelatorio.this_nOptPosicao = THIS.opt_4c_Posicao.Value
                THIS.this_oRelatorio.this_dDataSaldo  = THIS.txt_4c_DataSaldo.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Valida, transfere filtros ao BO e chama Visualizar
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            IF THIS.ValidacaoEntrada()
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        IF VARTYPE(THIS) = "O"
            THIS.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Valida, transfere filtros ao BO e chama Imprimir
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            IF THIS.ValidacaoEntrada()
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        IF VARTYPE(THIS) = "O"
            THIS.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGerarTxtClick - Valida, transfere filtros ao BO e gera TXT de inventario
    *   Equivalente ao Command1.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnGerarTxtClick()
        TRY
            IF THIS.ValidacaoEntrada()
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.GerarArquivoTXT(THIS.txt_4c_DataSaldo.Value)
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        IF VARTYPE(THIS) = "O"
            THIS.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * EVENTOS DOS CONTROLES
    *==========================================================================

    *-- Valid de CdEmpresa: valida empresa digitada e preenche descricao
    PROCEDURE ValidCdEmpresa()
        LOCAL loc_lOk, loc_cCod
        loc_lOk  = .T.
        loc_cCod = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
        TRY
            IF !EMPTY(loc_cCod)
                IF USED("CrSigCdEmp") AND SEEK(loc_cCod, "CrSigCdEmp", "CEmps")
                    THIS.txt_4c_DsEmpresa.Value = CrSigCdEmp.Razas
                    THIS.txt_4c_DsEmpresa.Refresh()
                ELSE
                    THIS.txt_4c_DsEmpresa.Value = ""
                    THIS.txt_4c_DsEmpresa.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *-- When de DsEmpresa: editavel apenas quando CdEmpresa estiver vazio
    PROCEDURE WhenDsEmpresa()
        RETURN EMPTY(THIS.txt_4c_CdEmpresa.Value)
    ENDPROC

    *-- Valid de MoeFator: busca cotacao da moeda digitada
    PROCEDURE ValidMoeFator()
        LOCAL loc_lOk, loc_dData, loc_nValFat
        loc_lOk    = .T.
        loc_nValFat = 0
        TRY
            IF EMPTY(THIS.txt_4c_MoeFator.Value)
                THIS.txt_4c_ValFator.Value = 0
                THIS.txt_4c_ValFator.Refresh()
            ELSE
                loc_dData = IIF(THIS.opt_4c_Posicao.Value = 1, DATE(), THIS.txt_4c_DataSaldo.Value)

                IF VARTYPE(THIS.this_oRelatorio) = "O"
                    loc_nValFat = THIS.this_oRelatorio.CarregarCambio(ALLTRIM(THIS.txt_4c_MoeFator.Value), loc_dData)
                ENDIF

                IF loc_nValFat = 0
                    MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "Aviso")
                    THIS.txt_4c_MoeFator.Value = ""
                    THIS.txt_4c_ValFator.Value = 0
                ELSE
                    THIS.txt_4c_ValFator.Value = loc_nValFat
                ENDIF
                THIS.txt_4c_ValFator.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *-- Valid de Moeda: busca moeda no TmpMoe (tem CMoes e DMoes indexados) e preenche descricao
    PROCEDURE ValidMoeda()
        LOCAL loc_lOk, loc_cMoe
        loc_lOk  = .T.
        loc_cMoe = ALLTRIM(THIS.txt_4c_Moeda.Value)
        TRY
            IF EMPTY(loc_cMoe)
                THIS.txt_4c_Moeda.Value     = ""
                THIS.txt_4c_MoedaDesc.Value = ""
            ELSE
                IF USED("TmpMoe") AND SEEK(loc_cMoe, "TmpMoe", "CMoes")
                    THIS.txt_4c_Moeda.Value     = TmpMoe.CMoes
                    THIS.txt_4c_MoedaDesc.Value = TmpMoe.DMoes
                ELSE
                    MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "Aviso")
                    THIS.txt_4c_Moeda.Value     = ""
                    THIS.txt_4c_MoedaDesc.Value = ""
                ENDIF
            ENDIF
            THIS.txt_4c_Moeda.Refresh()
            THIS.txt_4c_MoedaDesc.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *-- When de MoedaDesc: editavel apenas quando Moeda estiver vazio
    PROCEDURE WhenMoedaDesc()
        RETURN EMPTY(THIS.txt_4c_Moeda.Value)
    ENDPROC

    *-- Valid de MoedaDesc: busca moeda pela descricao no TmpMoe (tem index DMoes)
    PROCEDURE ValidMoedaDesc()
        LOCAL loc_lOk, loc_cDesc
        loc_lOk   = .T.
        loc_cDesc = ALLTRIM(THIS.txt_4c_MoedaDesc.Value)
        TRY
            IF EMPTY(loc_cDesc)
                THIS.txt_4c_Moeda.Value     = ""
                THIS.txt_4c_MoedaDesc.Value = ""
            ELSE
                IF USED("TmpMoe") AND SEEK(loc_cDesc, "TmpMoe", "DMoes")
                    THIS.txt_4c_Moeda.Value     = TmpMoe.CMoes
                    THIS.txt_4c_MoedaDesc.Value = TmpMoe.DMoes
                ELSE
                    MsgAviso("Descri" + CHR(231) + CHR(227) + "o de moeda n" + CHR(227) + "o encontrada.", "Aviso")
                    THIS.txt_4c_Moeda.Value     = ""
                    THIS.txt_4c_MoedaDesc.Value = ""
                ENDIF
            ENDIF
            THIS.txt_4c_Moeda.Refresh()
            THIS.txt_4c_MoedaDesc.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *-- InteractiveChange de ICMS: atualiza flag lImpICMS no BO
    PROCEDURE IcmsInteractiveChange()
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.this_lImpIcms = (THIS.opt_4c_ICMS.Value = 1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- InteractiveChange de OptPosicao: habilita/desabilita campo de data
    PROCEDURE PosicaoInteractiveChange()
        TRY
            IF THIS.opt_4c_Posicao.Value = 1
                THIS.txt_4c_DataSaldo.Value   = DATE()
                THIS.txt_4c_DataSaldo.Enabled = .F.
            ELSE
                IF EMPTY(THIS.txt_4c_DataSaldo.Value)
                    THIS.txt_4c_DataSaldo.Value = DATE()
                ENDIF
                THIS.txt_4c_DataSaldo.Enabled = .T.
            ENDIF
            THIS.txt_4c_DataSaldo.Refresh()
            THIS.txt_4c_DataSaldo.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- Valid ChkSaldo1: mutuamente exclusivo com ChkSaldo2
    PROCEDURE ValidSaldo1()
        TRY
            IF THIS.chk_4c_Saldo1.Value = 1
                THIS.chk_4c_Saldo2.Value = 0
                THIS.chk_4c_Saldo2.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    *-- Valid ChkSaldo2: mutuamente exclusivo com ChkSaldo1
    PROCEDURE ValidSaldo2()
        TRY
            IF THIS.chk_4c_Saldo2.Value = 1
                THIS.chk_4c_Saldo1.Value = 0
                THIS.chk_4c_Saldo1.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    *-- Valid ChkValor1 (UEPS): exclusivo; desabilita opcoes de saldo
    PROCEDURE ValidValor1()
        TRY
            IF THIS.chk_4c_Valor1.Value = 1
                THIS.chk_4c_Valor2.Value = 0
                THIS.chk_4c_Valor3.Value = 0
                THIS.chk_4c_Valor4.Value = 0
                THIS.chk_4c_Valor5.Value = 0
                THIS.chk_4c_Valor2.Refresh()
                THIS.chk_4c_Valor3.Refresh()
                THIS.chk_4c_Valor4.Refresh()
                THIS.chk_4c_Valor5.Refresh()
                THIS.chk_4c_Saldo1.Value   = 1
                THIS.chk_4c_Saldo2.Value   = 0
                THIS.chk_4c_Saldo1.Enabled = .F.
                THIS.chk_4c_Saldo2.Enabled = .F.
                THIS.chk_4c_Saldo1.Refresh()
                THIS.chk_4c_Saldo2.Refresh()
            ELSE
                THIS.chk_4c_Valor1.Value = 1
                THIS.chk_4c_Valor1.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    *-- Valid ChkValor2 (PEPS): exclusivo; desabilita opcoes de saldo
    PROCEDURE ValidValor2()
        TRY
            IF THIS.chk_4c_Valor2.Value = 1
                THIS.chk_4c_Valor1.Value = 0
                THIS.chk_4c_Valor3.Value = 0
                THIS.chk_4c_Valor4.Value = 0
                THIS.chk_4c_Valor5.Value = 0
                THIS.chk_4c_Valor1.Refresh()
                THIS.chk_4c_Valor3.Refresh()
                THIS.chk_4c_Valor4.Refresh()
                THIS.chk_4c_Valor5.Refresh()
                THIS.chk_4c_Saldo1.Value   = 1
                THIS.chk_4c_Saldo2.Value   = 0
                THIS.chk_4c_Saldo1.Enabled = .F.
                THIS.chk_4c_Saldo2.Enabled = .F.
                THIS.chk_4c_Saldo1.Refresh()
                THIS.chk_4c_Saldo2.Refresh()
            ELSE
                THIS.chk_4c_Valor2.Value = 1
                THIS.chk_4c_Valor2.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    *-- Valid ChkValor3 (Custo): exclusivo; habilita opcoes de saldo
    PROCEDURE ValidValor3()
        TRY
            IF THIS.chk_4c_Valor3.Value = 1
                THIS.chk_4c_Valor1.Value = 0
                THIS.chk_4c_Valor2.Value = 0
                THIS.chk_4c_Valor4.Value = 0
                THIS.chk_4c_Valor5.Value = 0
                THIS.chk_4c_Valor1.Refresh()
                THIS.chk_4c_Valor2.Refresh()
                THIS.chk_4c_Valor4.Refresh()
                THIS.chk_4c_Valor5.Refresh()
                THIS.chk_4c_Saldo1.Enabled = .T.
                THIS.chk_4c_Saldo2.Enabled = .T.
                THIS.chk_4c_Saldo1.Refresh()
                THIS.chk_4c_Saldo2.Refresh()
            ELSE
                THIS.chk_4c_Valor3.Value = 1
                THIS.chk_4c_Valor3.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    *-- Valid ChkValor4 (Custo Medio): exclusivo; habilita opcoes de saldo
    PROCEDURE ValidValor4()
        TRY
            IF THIS.chk_4c_Valor4.Value = 1
                THIS.chk_4c_Valor1.Value = 0
                THIS.chk_4c_Valor2.Value = 0
                THIS.chk_4c_Valor3.Value = 0
                THIS.chk_4c_Valor5.Value = 0
                THIS.chk_4c_Valor1.Refresh()
                THIS.chk_4c_Valor2.Refresh()
                THIS.chk_4c_Valor3.Refresh()
                THIS.chk_4c_Valor5.Refresh()
                THIS.chk_4c_Saldo1.Enabled = .T.
                THIS.chk_4c_Saldo2.Enabled = .T.
                THIS.chk_4c_Saldo1.Refresh()
                THIS.chk_4c_Saldo2.Refresh()
            ELSE
                THIS.chk_4c_Valor4.Value = 1
                THIS.chk_4c_Valor4.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    *-- Valid ChkValor5 (Venda): exclusivo; habilita opcoes de saldo
    PROCEDURE ValidValor5()
        TRY
            IF THIS.chk_4c_Valor5.Value = 1
                THIS.chk_4c_Valor1.Value = 0
                THIS.chk_4c_Valor2.Value = 0
                THIS.chk_4c_Valor3.Value = 0
                THIS.chk_4c_Valor4.Value = 0
                THIS.chk_4c_Valor1.Refresh()
                THIS.chk_4c_Valor2.Refresh()
                THIS.chk_4c_Valor3.Refresh()
                THIS.chk_4c_Valor4.Refresh()
                THIS.chk_4c_Saldo1.Enabled = .T.
                THIS.chk_4c_Saldo2.Enabled = .T.
                THIS.chk_4c_Saldo1.Refresh()
                THIS.chk_4c_Saldo2.Refresh()
            ELSE
                THIS.chk_4c_Valor5.Value = 1
                THIS.chk_4c_Valor5.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    *-- KeyPress de CdEmpresa: F4=abre lookup, ENTER/TAB=valida
    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidCdEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *-- KeyPress de MoeFator: F4=abre lookup, ENTER/TAB=valida
    PROCEDURE TeclaMoeFator(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeFator()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidMoeFator()
            ENDIF
        ENDIF
    ENDPROC

    *-- KeyPress de Moeda: F4=abre lookup, ENTER/TAB=valida
    PROCEDURE TeclaMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidMoeda()
            ENDIF
        ENDIF
    ENDPROC

    *-- KeyPress de MoedaDesc: F4=abre lookup, ENTER/TAB=valida
    PROCEDURE TeclaMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoedaDesc()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidMoedaDesc()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DblClick - DELEGAM PARA AbrirLookup*
    *==========================================================================

    PROCEDURE EmpresaDblClick()
        THIS.AbrirLookupEmpresa()
    ENDPROC

    PROCEDURE MoedaDblClick()
        THIS.AbrirLookupMoeda()
    ENDPROC

    PROCEDURE MoedaDescDblClick()
        THIS.AbrirLookupMoedaDesc()
    ENDPROC

    PROCEDURE MoeFatorDblClick()
        THIS.AbrirLookupMoeFator()
    ENDPROC

    *==========================================================================
    * METODOS DE LOOKUP (FormBuscaAuxiliar)
    *==========================================================================

    *-- AbrirLookupEmpresa - Abre busca de empresas (SigCdEmp) via FormBuscaAuxiliar
    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmpresa", ;
                "CEmps", ;
                ALLTRIM(THIS.txt_4c_CdEmpresa.Value), ;
                "Buscar Empresa")

            loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaEmpresa")
                    SELECT cursor_4c_BuscaEmpresa
                    loc_cCodigo    = ALLTRIM(CEmps)
                    loc_cDescricao = ALLTRIM(Razas)
                    THIS.txt_4c_CdEmpresa.Value = loc_cCodigo
                    THIS.txt_4c_DsEmpresa.Value = loc_cDescricao
                    THIS.txt_4c_CdEmpresa.Refresh()
                    THIS.txt_4c_DsEmpresa.Refresh()
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaEmpresa")
                USE IN cursor_4c_BuscaEmpresa
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- AbrirLookupMoeda - Abre busca de moedas por codigo (SigCdMoe)
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", ;
                "cursor_4c_BuscaMoeda", ;
                "CMoes", ;
                ALLTRIM(THIS.txt_4c_Moeda.Value), ;
                "Buscar Moeda")

            loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeda")
                    SELECT cursor_4c_BuscaMoeda
                    loc_cCodigo    = ALLTRIM(CMoes)
                    loc_cDescricao = ALLTRIM(DMoes)
                    THIS.txt_4c_Moeda.Value     = loc_cCodigo
                    THIS.txt_4c_MoedaDesc.Value = loc_cDescricao
                    THIS.txt_4c_Moeda.Refresh()
                    THIS.txt_4c_MoedaDesc.Refresh()
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- AbrirLookupMoedaDesc - Abre busca de moedas por descricao (SigCdMoe)
    PROCEDURE AbrirLookupMoedaDesc()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", ;
                "cursor_4c_BuscaMoeDesc", ;
                "DMoes", ;
                ALLTRIM(THIS.txt_4c_MoedaDesc.Value), ;
                "Buscar Moeda")

            loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeDesc")
                    SELECT cursor_4c_BuscaMoeDesc
                    loc_cCodigo    = ALLTRIM(CMoes)
                    loc_cDescricao = ALLTRIM(DMoes)
                    THIS.txt_4c_Moeda.Value     = loc_cCodigo
                    THIS.txt_4c_MoedaDesc.Value = loc_cDescricao
                    THIS.txt_4c_Moeda.Refresh()
                    THIS.txt_4c_MoedaDesc.Refresh()
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaMoeDesc")
                USE IN cursor_4c_BuscaMoeDesc
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- AbrirLookupMoeFator - Abre busca de moedas para fator de conversao (SigCdMoe)
    *   Apos selecao, carrega cotacao via CarregarCambio() do BO
    PROCEDURE AbrirLookupMoeFator()
        LOCAL loc_oBusca, loc_cCodigo, loc_nValFat, loc_dData
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", ;
                "cursor_4c_BuscaMoeFat", ;
                "CMoes", ;
                ALLTRIM(THIS.txt_4c_MoeFator.Value), ;
                "Selecionar Moeda Fator")

            loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeFat")
                    SELECT cursor_4c_BuscaMoeFat
                    loc_cCodigo = ALLTRIM(CMoes)
                    THIS.txt_4c_MoeFator.Value = loc_cCodigo
                    THIS.txt_4c_MoeFator.Refresh()

                    loc_dData = IIF(THIS.opt_4c_Posicao.Value = 1, DATE(), THIS.txt_4c_DataSaldo.Value)
                    IF VARTYPE(THIS.this_oRelatorio) = "O"
                        loc_nValFat = THIS.this_oRelatorio.CarregarCambio(loc_cCodigo, loc_dData)
                        THIS.txt_4c_ValFator.Value = loc_nValFat
                        THIS.txt_4c_ValFator.Refresh()
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaMoeFat")
                USE IN cursor_4c_BuscaMoeFat
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * STUBS DE COMPATIBILIDADE COM PIPELINE FORMBASE
    *==========================================================================

    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    PROCEDURE BtnIncluirClick()
        RETURN
    ENDPROC

    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE AjustarBotoesPorModo(par_cModo)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
