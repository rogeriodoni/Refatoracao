*==============================================================================
* FORMSIGREDTV.PRG
* Formulario de Relatorio - Demonstrativo de Conta Corrente (SigReDtv)
*
* Migrado de: SIGREDTV.SCX (frmrelatorio)
* Layout   : FLAT - controles direto no form, sem PageFrame
* Herda de : FormBase
* Tipos    : 1=Demonstrativo (SigReDtvP)  2=Mapa de Contas (SigReDtvM)
*==============================================================================

DEFINE CLASS Formsigredtv AS FormBase

    *-- Tipo de relatorio: 1=Demonstrativo, 2=Mapa de Contas
    this_nTipo         = 1

    *-- BO de relatorio
    this_oRelatorio    = .NULL.

    *-- Mensagem de erro interna
    this_cMensagemErro = ""

    *-- Propriedades visuais
    DataSession  = 2
    Height       = 600
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = "Demonstrativo"
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    Themes       = .F.
    WindowType   = 1
    BackColor    = RGB(192, 192, 192)
    ShowWindow   = 1

    *--------------------------------------------------------------------------
    * Init - Define tipo antes de DODEFAULT() acionar InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nTipo)
        IF TYPE("par_nTipo") = "N"
            THIS.this_nTipo = IIF(par_nTipo = 2, 2, 1)
        ELSE
            THIS.this_nTipo = 1
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle < 0
                    MsgErro("Erro de conex" + CHR(227) + "o com banco de dados.", "Erro")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

            IF loc_lSucesso
                THIS.this_oRelatorio = CREATEOBJECT("sigredtvBO")
                THIS.this_oRelatorio.ConfigurarTipo(THIS.this_nTipo)
                THIS.Caption = THIS.this_oRelatorio.ObterCaptionForm()

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCampos()

                THIS.this_oRelatorio.InicializarDados()

                THIS.ConfigurarGridEmpresas()
                THIS.this_oRelatorio.DisponibilizarOrcamentos()
                THIS.ConfigurarGridOrcamentos()

                THIS.ConfigurarBINDEVENTs()

                THIS.AtualizarEstadoMoedaDesc()
                THIS.AtualizarEstadoComparativo()
                THIS.AtualizarEstadoOrcamentos()

                THIS.Visible = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- REPORT forms nao usam PageFrame lista/dados (stubs no-op para FormBase)
    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 25
            .Left      = 20
            .AutoSize  = .F.
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
        THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible = .T.
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Visualizar / Imprimir / Documento / Encerrar
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
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_imprimir_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Documento"
            .WordWrap        = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excel_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")

        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .WordWrap        = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        THIS.cmg_4c_Botoes.Buttons(4).Cancel = .T.
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Todos os campos de filtro (layout FLAT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()

        *-- === DEMONSTRATIVO Top=120/123 ===
        THIS.AddObject("lbl_4c_LblDemonstrativo", "Label")
        WITH THIS.lbl_4c_LblDemonstrativo
            .Top       = 123
            .Left      = 121
            .AutoSize  = .T.
            .Caption   = "Demonstrativo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Demons", "TextBox")
        WITH THIS.txt_4c_Demons
            .Top           = 120
            .Left          = 204
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === PERIODO Top=145/148 ===
        THIS.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH THIS.lbl_4c_LblPeriodo
            .Top       = 148
            .Left      = 155
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtInicial", "TextBox")
        WITH THIS.txt_4c_DtInicial
            .Top           = 145
            .Left          = 204
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_LblPeriodoA", "Label")
        WITH THIS.lbl_4c_LblPeriodoA
            .Top       = 148
            .Left      = 288
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Top           = 145
            .Left          = 300
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- === TIPO DE DATAS (5 opcoes) Top=138 ===
        THIS.AddObject("obj_4c_OptTpDatas", "OptionGroup")
        WITH THIS.obj_4c_OptTpDatas
            .ButtonCount = 5
            .Top         = 138
            .Left        = 381
            .Width       = 176
            .Height      = 59
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Option1.Caption   = "Emiss" + CHR(227) + "o"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 56
            .Option1.Height    = 15
            .Option2.Caption   = "Lan" + CHR(231) + "amento"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 95
            .Option2.Width     = 76
            .Option2.Height    = 15
            .Option3.Caption   = "Vencimento"
            .Option3.FontName  = "Tahoma"
            .Option3.FontSize  = 8
            .Option3.BackStyle = 0
            .Option3.ForeColor = RGB(90, 90, 90)
            .Option3.Top       = 22
            .Option3.Left      = 5
            .Option3.Width     = 73
            .Option3.Height    = 15
            .Option4.Caption   = "Baixa"
            .Option4.FontName  = "Tahoma"
            .Option4.FontSize  = 8
            .Option4.BackStyle = 0
            .Option4.ForeColor = RGB(90, 90, 90)
            .Option4.Top       = 22
            .Option4.Left      = 95
            .Option4.Width     = 44
            .Option4.Height    = 15
            .Option5.Caption   = "Configura" + CHR(231) + CHR(227) + "o"
            .Option5.FontName  = "Tahoma"
            .Option5.FontSize  = 8
            .Option5.BackStyle = 0
            .Option5.ForeColor = RGB(90, 90, 90)
            .Option5.Top       = 39
            .Option5.Left      = 5
            .Option5.Width     = 82
            .Option5.Height    = 15
            .Visible           = .T.
        ENDWITH

        *-- === MOEDA Top=170/173 ===
        THIS.AddObject("lbl_4c_LblMoeda", "Label")
        WITH THIS.lbl_4c_LblMoeda
            .Top       = 173
            .Left      = 159
            .AutoSize  = .T.
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CodMoeda", "TextBox")
        WITH THIS.txt_4c_CodMoeda
            .Top           = 170
            .Left          = 204
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 3
            .Alignment     = 0
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DesMoeda", "TextBox")
        WITH THIS.txt_4c_DesMoeda
            .Top           = 170
            .Left          = 237
            .Width         = 142
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 15
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === COTACAO Top=196/200 ===
        THIS.AddObject("lbl_4c_LblCotacao", "Label")
        WITH THIS.lbl_4c_LblCotacao
            .Top       = 200
            .Left      = 151
            .AutoSize  = .T.
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptCotacao", "OptionGroup")
        WITH THIS.obj_4c_OptCotacao
            .ButtonCount = 2
            .Top         = 196
            .Left        = 198
            .Width       = 210
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Option1.Caption   = "\<Fechamento"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 89
            .Option1.Height    = 17
            .Option2.Caption   = "\<Movimenta" + CHR(231) + CHR(227) + "o"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 100
            .Option2.Width     = 98
            .Option2.Height    = 17
            .Visible           = .T.
        ENDWITH

        *-- === COMPARATIVO Top=218/223 ===
        THIS.AddObject("lbl_4c_LblComparativo", "Label")
        WITH THIS.lbl_4c_LblComparativo
            .Top       = 223
            .Left      = 130
            .AutoSize  = .T.
            .Caption   = "Comparativo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptCompara", "OptionGroup")
        WITH THIS.obj_4c_OptCompara
            .ButtonCount = 3
            .Top         = 218
            .Left        = 198
            .Width       = 317
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Option1.Caption   = "N" + CHR(227) + "o"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 53
            .Option1.Height    = 17
            .Option2.Caption   = "M" + CHR(234) + "s Anterior"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 100
            .Option2.Width     = 90
            .Option2.Height    = 17
            .Option3.Caption   = "Ano Anterior"
            .Option3.FontName  = "Tahoma"
            .Option3.FontSize  = 8
            .Option3.BackStyle = 0
            .Option3.ForeColor = RGB(90, 90, 90)
            .Option3.Top       = 5
            .Option3.Left      = 217
            .Option3.Width     = 79
            .Option3.Height    = 15
            .Visible           = .T.
        ENDWITH

        *-- Campos de periodo comparativo (inicialmente ocultos, somente leitura)
        THIS.AddObject("txt_4c_Comp1", "TextBox")
        WITH THIS.txt_4c_Comp1
            .Top           = 219
            .Left          = 517
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .Value         = DATE()
            .Visible       = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_LblCompA", "Label")
        WITH THIS.lbl_4c_LblCompA
            .Top       = 223
            .Left      = 601
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        THIS.AddObject("txt_4c_Comp2", "TextBox")
        WITH THIS.txt_4c_Comp2
            .Top           = 219
            .Left          = 613
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .Value         = DATE()
            .Visible       = .F.
        ENDWITH

        *-- === NOTA FISCAL / SINTETICO Top=238/243 ===
        THIS.AddObject("lbl_4c_LblTipo", "Label")
        WITH THIS.lbl_4c_LblTipo
            .Top       = 243
            .Left      = 165
            .AutoSize  = .T.
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptSnt", "OptionGroup")
        WITH THIS.obj_4c_OptSnt
            .ButtonCount = 3
            .Top         = 238
            .Left        = 198
            .Width       = 274
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3
            .Option1.Caption   = "Sim"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 53
            .Option1.Height    = 17
            .Option2.Caption   = "N" + CHR(227) + "o"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 100
            .Option2.Width     = 53
            .Option2.Height    = 17
            .Option3.Caption   = "Todos"
            .Option3.FontName  = "Tahoma"
            .Option3.FontSize  = 8
            .Option3.BackStyle = 0
            .Option3.ForeColor = RGB(90, 90, 90)
            .Option3.Top       = 5
            .Option3.Left      = 216
            .Option3.Width     = 53
            .Option3.Height    = 17
            .Visible           = .T.
        ENDWITH

        *-- === CONTRAPARTIDA Top=259/263 ===
        THIS.AddObject("lbl_4c_LblContrapartida", "Label")
        WITH THIS.lbl_4c_LblContrapartida
            .Top       = 263
            .Left      = 124
            .AutoSize  = .T.
            .Caption   = "Contrapartida :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptContras", "OptionGroup")
        WITH THIS.obj_4c_OptContras
            .ButtonCount = 2
            .Top         = 259
            .Left        = 198
            .Width       = 210
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Option1.Caption   = "Ocultar"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 89
            .Option1.Height    = 17
            .Option2.Caption   = "Desmembrar"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 100
            .Option2.Width     = 98
            .Option2.Height    = 17
            .Visible           = .T.
        ENDWITH

        *-- === EMPRESAS Top=287 ===
        THIS.AddObject("lbl_4c_LblEmpresas", "Label")
        WITH THIS.lbl_4c_LblEmpresas
            .Top       = 287
            .Left      = 145
            .AutoSize  = .T.
            .Caption   = "Empresas :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox "marcar tudo" flutuante sobre header Column1 do grid
        THIS.AddObject("chk_4c_MarcaEmp", "CheckBox")
        WITH THIS.chk_4c_MarcaEmp
            .Top       = 288
            .Left      = 206
            .Width     = 13
            .Height    = 16
            .Caption   = ""
            .Value     = 1
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid de empresas (sem RecordSource ainda - configurado apos InicializarDados)
        THIS.AddObject("grd_4c_Emps", "Grid")
        WITH THIS.grd_4c_Emps
            .Top               = 287
            .Left              = 205
            .Width             = 279
            .Height            = 123
            .HeaderHeight       = 0
            .ColumnCount       = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.
        ENDWITH
        WITH THIS.grd_4c_Emps.Column1
            .Width     = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
            .Sparse    = .F.
        ENDWITH
        THIS.grd_4c_Emps.Column1.AddObject("Check1", "CheckBox")
        WITH THIS.grd_4c_Emps.Column1.Check1
            .Caption  = ""
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH
        THIS.grd_4c_Emps.Column1.CurrentControl = "Check1"
        THIS.grd_4c_Emps.Column1.Header1.Caption   = ""
        THIS.grd_4c_Emps.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH THIS.grd_4c_Emps.Column2
            .Width     = 27
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Emps.Column2.Header1.Caption    = "Emp."
        THIS.grd_4c_Emps.Column2.Header1.Alignment  = 2
        THIS.grd_4c_Emps.Column2.Header1.ForeColor  = RGB(90, 90, 90)
        WITH THIS.grd_4c_Emps.Column3
            .Width     = 215
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Emps.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        THIS.grd_4c_Emps.Column3.Header1.Alignment = 2
        THIS.grd_4c_Emps.Column3.Header1.ForeColor = RGB(90, 90, 90)

        *-- === ORCAMENTOS Top=415/416 ===
        THIS.AddObject("lbl_4c_LblOrcamentos", "Label")
        WITH THIS.lbl_4c_LblOrcamentos
            .Top       = 415
            .Left      = 133
            .AutoSize  = .T.
            .Caption   = "Or" + CHR(231) + "amentos :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox "marcar tudo" flutuante sobre header Column1 do grid de orcamentos
        THIS.AddObject("chk_4c_MarcaOrcs", "CheckBox")
        WITH THIS.chk_4c_MarcaOrcs
            .Top       = 417
            .Left      = 206
            .Width     = 13
            .Height    = 16
            .Caption   = ""
            .Value     = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid de orcamentos (sem RecordSource ainda - configurado apos DisponibilizarOrcamentos)
        THIS.AddObject("grd_4c_Orcs", "Grid")
        WITH THIS.grd_4c_Orcs
            .Top               = 416
            .Left              = 205
            .Width             = 438
            .Height            = 122
            .HeaderHeight       = 0
            .ColumnCount       = 5
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.
        ENDWITH
        WITH THIS.grd_4c_Orcs.Column1
            .Width     = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .F.
            .Sparse    = .F.
        ENDWITH
        THIS.grd_4c_Orcs.Column1.AddObject("check12", "CheckBox")
        WITH THIS.grd_4c_Orcs.Column1.check12
            .Caption  = ""
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH
        THIS.grd_4c_Orcs.Column1.AddObject("check13", "CheckBox")
        THIS.grd_4c_Orcs.Column1.check13.Caption = ""
        THIS.grd_4c_Orcs.Column1.CurrentControl = "check13"
        THIS.grd_4c_Orcs.Column1.Header1.Caption   = ""
        THIS.grd_4c_Orcs.Column1.Header1.ForeColor = RGB(90, 90, 90)
        WITH THIS.grd_4c_Orcs.Column2
            .Width     = 300
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Orcs.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        THIS.grd_4c_Orcs.Column2.Header1.Alignment = 2
        THIS.grd_4c_Orcs.Column2.Header1.ForeColor = RGB(90, 90, 90)
        WITH THIS.grd_4c_Orcs.Column3
            .Width     = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Orcs.Column3.Header1.Caption   = "M" + CHR(234) + "s"
        THIS.grd_4c_Orcs.Column3.Header1.Alignment = 2
        THIS.grd_4c_Orcs.Column3.Header1.ForeColor = RGB(90, 90, 90)
        WITH THIS.grd_4c_Orcs.Column4
            .Width     = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Orcs.Column4.Header1.Caption   = "Ano"
        THIS.grd_4c_Orcs.Column4.Header1.Alignment = 2
        THIS.grd_4c_Orcs.Column4.Header1.ForeColor = RGB(90, 90, 90)
        WITH THIS.grd_4c_Orcs.Column5
            .Width     = 32
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        THIS.grd_4c_Orcs.Column5.Header1.Caption   = "Moeda"
        THIS.grd_4c_Orcs.Column5.Header1.Alignment = 2
        THIS.grd_4c_Orcs.Column5.Header1.ForeColor = RGB(90, 90, 90)

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridEmpresas - Vincula RecordSource apos csSigCdEmp disponivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridEmpresas()
        IF NOT USED("csSigCdEmp")
            RETURN
        ENDIF
        THIS.grd_4c_Emps.RecordSource = "csSigCdEmp"
        WITH THIS.grd_4c_Emps
            .Column1.ControlSource = "csSigCdEmp.Imps"
            .Column2.ControlSource = "csSigCdEmp.CEmps"
            .Column3.ControlSource = "csSigCdEmp.Razas"
        ENDWITH
        THIS.grd_4c_Emps.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridOrcamentos - Vincula RecordSource apos crSigCdMrp disponivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridOrcamentos()
        IF NOT USED("crSigCdMrp")
            RETURN
        ENDIF
        THIS.grd_4c_Orcs.RecordSource = "crSigCdMrp"
        WITH THIS.grd_4c_Orcs
            .Column1.ControlSource = "crSigCdMrp.Imps"
            .Column2.ControlSource = "crSigCdMrp.cTitulo"
            .Column3.ControlSource = "crSigCdMrp.cMes"
            .Column4.ControlSource = "crSigCdMrp.cAno"
            .Column5.ControlSource = "crSigCdMrp.Moeda"
        ENDWITH
        THIS.grd_4c_Orcs.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs - Vincula eventos a metodos do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        *-- Campos de data
        BINDEVENT(THIS.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
        BINDEVENT(THIS.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")

        *-- Moeda
        BINDEVENT(THIS.txt_4c_CodMoeda, "KeyPress", THIS, "TeclaLookupMoedaCod")
        BINDEVENT(THIS.txt_4c_DesMoeda, "KeyPress", THIS, "TeclaLookupMoedaDesc")
        BINDEVENT(THIS.txt_4c_CodMoeda, "DblClick", THIS, "AbrirBuscaMoedaCod")
        BINDEVENT(THIS.txt_4c_DesMoeda, "DblClick", THIS, "AbrirBuscaMoedaDesc")

        *-- Demonstrativo
        BINDEVENT(THIS.txt_4c_Demons, "KeyPress", THIS, "TeclaLookupDemonstrativo")
        BINDEVENT(THIS.txt_4c_Demons, "DblClick", THIS, "AbrirBuscaDemonstrativo")

        *-- Comparativo OptionGroup
        BINDEVENT(THIS.obj_4c_OptCompara, "InteractiveChange", THIS, "OptComparaChange")

        *-- Checkboxes de selecionar tudo
        BINDEVENT(THIS.chk_4c_MarcaEmp,  "Click", THIS, "MarcaEmpClick")
        BINDEVENT(THIS.chk_4c_MarcaOrcs, "Click", THIS, "MarcaOrcsClick")

        *-- Grid Empresas - checkbox Column1
        BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "KeyPress",  THIS, "EmpCheckKeyPress")
        BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "MouseUp",   THIS, "EmpCheckMouseUp")
        BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "MouseDown", THIS, "EmpCheckMouseDown")
        BINDEVENT(THIS.grd_4c_Emps.Column1.Check1, "Click",     THIS, "EmpCheckClick")

        *-- Grid Orcamentos - checkbox Column1
        BINDEVENT(THIS.grd_4c_Orcs.Column1.check13, "KeyPress",  THIS, "OrcCheckKeyPress")
        BINDEVENT(THIS.grd_4c_Orcs.Column1.check13, "MouseUp",   THIS, "OrcCheckMouseUp")
        BINDEVENT(THIS.grd_4c_Orcs.Column1.check13, "MouseDown", THIS, "OrcCheckMouseDown")
        BINDEVENT(THIS.grd_4c_Orcs.Column1.check13, "Click",     THIS, "OrcCheckClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        THIS.this_oRelatorio.this_dDtInicial     = THIS.txt_4c_DtInicial.Value
        THIS.this_oRelatorio.this_dDtFinal       = THIS.txt_4c_DtFinal.Value
        THIS.this_oRelatorio.this_cCodMoeda      = ALLTRIM(THIS.txt_4c_CodMoeda.Value)
        THIS.this_oRelatorio.this_cDesMoeda      = ALLTRIM(THIS.txt_4c_DesMoeda.Value)
        THIS.this_oRelatorio.this_cDemonstrativo = ALLTRIM(THIS.txt_4c_Demons.Value)
        THIS.this_oRelatorio.this_nTipoDatas     = THIS.obj_4c_OptTpDatas.Value
        THIS.this_oRelatorio.this_nCotacao       = THIS.obj_4c_OptCotacao.Value
        THIS.this_oRelatorio.this_nComparativo   = THIS.obj_4c_OptCompara.Value
        THIS.this_oRelatorio.this_dCompInicial   = THIS.txt_4c_Comp1.Value
        THIS.this_oRelatorio.this_dCompFinal     = THIS.txt_4c_Comp2.Value
        THIS.this_oRelatorio.this_nSnt           = THIS.obj_4c_OptSnt.Value
        THIS.this_oRelatorio.this_nContrapartida = THIS.obj_4c_OptContras.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.txt_4c_DtInicial.Value)
            MsgAviso("Data inicial " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Filtro")
            THIS.txt_4c_DtInicial.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.txt_4c_DtFinal.Value)
            MsgAviso("Data final " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Filtro")
            THIS.txt_4c_DtFinal.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.txt_4c_CodMoeda.Value)) AND ;
                           EMPTY(ALLTRIM(THIS.txt_4c_DesMoeda.Value))
            MsgAviso("Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Filtro")
            THIS.txt_4c_CodMoeda.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.txt_4c_Demons.Value))
            MsgAviso("Demonstrativo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Filtro")
            THIS.txt_4c_Demons.SetFocus()
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BOTOES - Eventos principais do form de relat" + CHR(243) + "rio
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera preview do relatorio na tela
    * Equivalente ao "PROCEDURE visualizacao" do sistema legado (linha 21)
    * Logica do legado:
    *   IF Previsao        -> Report Form SigReDt1 Preview NoConsole
    *   ELSEIF Comparativo -> Report Form SigReDt2 Preview NoConsole
    *   ELSEIF ContraPartida -> Report Form SigReDt3 Preview NoConsole
    *   ELSE               -> Report Form SigReDt4 Preview NoConsole
    * A selecao do FRX e feita internamente pelo BO via ObterNomeFRX()
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_lOk, loc_lSeguir
        loc_lSeguir = .T.
        loc_lOk     = .F.

        TRY
            *-- 1. Valida filtros obrigatorios (datas, moeda, demonstrativo)
            IF !THIS.ValidarFiltros()
                loc_lSeguir = .F.
            ENDIF

            IF loc_lSeguir
                *-- 2. Limpa cursores residuais de execucoes anteriores
                THIS.LimparCursoresRelatorio()

                *-- 3. Transfere filtros do form para o BO
                THIS.FormParaRelatorio()

                *-- 4. Aciona o BO para preparar dados + REPORT FORM PREVIEW
                loc_lOk = THIS.this_oRelatorio.Visualizar()

                IF !loc_lOk AND !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao visualizar relat" + CHR(243) + "rio")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao gerar preview:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure + CHR(13) + ;
                    loc_oErro.Message, ;
                    "BtnVisualizarClick")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de impressora
    * Equivalente ao "PROCEDURE impressao" do sistema legado (linha 21)
    * Logica do legado:
    *   IF Previsao        -> Report Form SigReDt1 To Printer Prompt NoConsole
    *   ELSEIF Comparativo -> Report Form SigReDt2 To Printer Prompt NoConsole
    *   ELSEIF ContraPartida -> Report Form SigReDt3 To Printer Prompt NoConsole
    *   ELSE               -> Report Form SigReDt4 To Printer Prompt NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro, loc_lOk, loc_lSeguir
        loc_lSeguir = .T.
        loc_lOk     = .F.

        TRY
            *-- 1. Valida filtros obrigatorios
            IF !THIS.ValidarFiltros()
                loc_lSeguir = .F.
            ENDIF

            *-- 2. Confirma impressao com o usuario
            IF loc_lSeguir
                IF !MsgConfirma("Deseja imprimir o relat" + CHR(243) + "rio agora?", ;
                                "Confirma" + CHR(231) + CHR(227) + "o de Impress" + CHR(227) + "o")
                    loc_lSeguir = .F.
                ENDIF
            ENDIF

            IF loc_lSeguir
                *-- 3. Limpa cursores residuais
                THIS.LimparCursoresRelatorio()

                *-- 4. Transfere filtros do form para o BO
                THIS.FormParaRelatorio()

                *-- 5. Aciona o BO para preparar dados + REPORT FORM TO PRINTER PROMPT
                loc_lOk = THIS.this_oRelatorio.Imprimir()

                IF !loc_lOk AND !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao imprimir relat" + CHR(243) + "rio")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao imprimir:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure + CHR(13) + ;
                    loc_oErro.Message, ;
                    "BtnImprimirClick")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Imprime sem dialogo (direto na impressora padrao)
    * Equivalente ao "PROCEDURE documento" do sistema legado (linha 19)
    * Usado para gerar documento direto, sem prompt de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_oErro, loc_lOk, loc_lSeguir
        loc_lSeguir = .T.
        loc_lOk     = .F.

        TRY
            *-- 1. Valida filtros obrigatorios
            IF !THIS.ValidarFiltros()
                loc_lSeguir = .F.
            ENDIF

            *-- 2. Confirma geracao do documento
            IF loc_lSeguir
                IF !MsgConfirma("Gerar documento e enviar para impressora padr" + CHR(227) + "o?", ;
                                "Gerar Documento")
                    loc_lSeguir = .F.
                ENDIF
            ENDIF

            IF loc_lSeguir
                *-- 3. Limpa cursores residuais
                THIS.LimparCursoresRelatorio()

                *-- 4. Transfere filtros do form para o BO
                THIS.FormParaRelatorio()

                *-- 5. Aciona o BO para preparar dados + REPORT FORM TO PRINTER NOCONSOLE
                loc_lOk = THIS.this_oRelatorio.ImprimirDocumento()

                IF loc_lOk
                    MsgInfo("Documento enviado para a impressora.", "Gerar Documento")
                ELSE
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                                "Erro ao gerar documento")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao gerar documento:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure + CHR(13) + ;
                    loc_oErro.Message, ;
                    "BtnDocumentoClick")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario de relatorio
    * Libera cursores e o BO antes de release
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        LOCAL loc_oErro

        TRY
            THIS.LimparCursoresRelatorio()
        CATCH TO loc_oErro
            *-- ignorar erros na limpeza, prosseguir com release
        ENDTRY

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresRelatorio - Fecha cursores temporarios usados pelo BO
    * Evita "Alias already in use" em execucoes consecutivas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursoresRelatorio()
        LOCAL ARRAY loc_aCursores[8]
        LOCAL loc_nI

        loc_aCursores[1] = "cursor_4c_RelDados"
        loc_aCursores[2] = "cursor_4c_RelComp"
        loc_aCursores[3] = "cursor_4c_RelTmp"
        loc_aCursores[4] = "cursor_4c_RelMov"
        loc_aCursores[5] = "cursor_4c_RelCtas"
        loc_aCursores[6] = "cursor_4c_RelOrcs"
        loc_aCursores[7] = "crTmpMccr"
        loc_aCursores[8] = "Tempo"

        FOR loc_nI = 1 TO ALEN(loc_aCursores, 1)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA por codigo (SigCdMoe.CMoes)
    *==========================================================================

    PROCEDURE TeclaLookupMoedaCod(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaCod()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaCod()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoedaCod()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c_CodMoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_CodMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                THIS.txt_4c_DesMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        THIS.txt_4c_CodMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        THIS.txt_4c_DesMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarMoedaCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c_CodMoeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_DesMoeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeVal
            IF !EOF()
                THIS.txt_4c_DesMoeda.Value = ALLTRIM(DMoes)
            ELSE
                THIS.txt_4c_DesMoeda.Value = ""
                THIS.AbrirBuscaMoedaCod()
            ENDIF
        ELSE
            THIS.txt_4c_DesMoeda.Value = ""
            THIS.AbrirBuscaMoedaCod()
        ENDIF
        IF USED("cursor_4c_MoeVal")
            USE IN cursor_4c_MoeVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA por descricao (SigCdMoe.DMoes)
    *==========================================================================

    PROCEDURE TeclaLookupMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c_DesMoeda.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaDesc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoedaDesc()
        IF THIS.txt_4c_DesMoeda.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c_DesMoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeD", "DMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_CodMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                THIS.txt_4c_DesMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeD")
                        THIS.txt_4c_CodMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                        THIS.txt_4c_DesMoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoeD")
            USE IN cursor_4c_BuscaMoeD
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarMoedaDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c_DesMoeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_CodMoeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE DMoes LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeDescVal
            IF !EOF()
                THIS.txt_4c_CodMoeda.Value = ALLTRIM(CMoes)
                THIS.txt_4c_DesMoeda.Value = ALLTRIM(DMoes)
            ELSE
                THIS.AbrirBuscaMoedaDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
        IF USED("cursor_4c_MoeDescVal")
            USE IN cursor_4c_MoeDescVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - DEMONSTRATIVO (SigCdMrr.Balancos)
    *==========================================================================

    PROCEDURE TeclaLookupDemonstrativo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDemonstrativo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDemonstrativo()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaDemonstrativo()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor  = ALLTRIM(THIS.txt_4c_Demons.Value)
        loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMrr", "cursor_4c_BuscaDem", "Balancos", loc_cValor, ;
            "Demonstrativos", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_Demons.Value = ALLTRIM(cursor_4c_BuscaDem.Balancos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Balancos", "", "Demonstrativo")
                    loc_oBusca.mAddColuna("Titulos",  "", "T" + CHR(237) + "tulo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDem")
                        THIS.txt_4c_Demons.Value = ALLTRIM(cursor_4c_BuscaDem.Balancos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaDem")
            USE IN cursor_4c_BuscaDem
        ENDIF
        THIS.txt_4c_Demons.Refresh()
    ENDPROC

    PROTECTED PROCEDURE ValidarDemonstrativo()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor  = ALLTRIM(THIS.txt_4c_Demons.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Balancos FROM SigCdMrr WHERE Balancos = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DemVal")
        IF loc_nResult > 0
            SELECT cursor_4c_DemVal
            IF !EOF()
                THIS.txt_4c_Demons.Value = ALLTRIM(Balancos)
            ELSE
                THIS.AbrirBuscaDemonstrativo()
            ENDIF
        ELSE
            THIS.AbrirBuscaDemonstrativo()
        ENDIF
        IF USED("cursor_4c_DemVal")
            USE IN cursor_4c_DemVal
        ENDIF
        THIS.txt_4c_Demons.Refresh()
    ENDPROC

    *==========================================================================
    * CAMPOS DE DATA
    *==========================================================================

    PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF !EMPTY(THIS.txt_4c_DtInicial.Value) AND !EMPTY(THIS.txt_4c_DtFinal.Value)
                IF THIS.txt_4c_DtInicial.Value > THIS.txt_4c_DtFinal.Value
                    THIS.txt_4c_DtFinal.Value = THIS.txt_4c_DtInicial.Value
                    THIS.txt_4c_DtFinal.Refresh()
                ENDIF
            ENDIF
            THIS.OptComparaChange()
        ENDIF
    ENDPROC

    PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.OptComparaChange()
        ENDIF
    ENDPROC

    *==========================================================================
    * COMPARATIVO - Auto-calculo de datas e visibilidade
    *==========================================================================

    PROCEDURE OptComparaChange()
        LOCAL loc_nVal, loc_lAtivo, loc_lnMeses, loc_ldIni, loc_ldFim, loc_leExpr
        loc_nVal   = THIS.obj_4c_OptCompara.Value
        loc_lAtivo = (loc_nVal > 1)

        THIS.grd_4c_Orcs.Enabled       = !loc_lAtivo
        THIS.chk_4c_MarcaOrcs.Enabled  = !loc_lAtivo
        THIS.txt_4c_Comp1.Visible      = loc_lAtivo
        THIS.txt_4c_Comp2.Visible      = loc_lAtivo
        THIS.lbl_4c_LblCompA.Visible   = loc_lAtivo

        IF loc_lAtivo
            DO CASE
                CASE loc_nVal = 2
                    loc_lnMeses = -1
                CASE loc_nVal = 3
                    loc_lnMeses = -12
                OTHERWISE
                    loc_lnMeses = 0
            ENDCASE

            loc_ldIni = THIS.txt_4c_DtInicial.Value
            loc_ldFim = THIS.txt_4c_DtFinal.Value

            IF !EMPTY(loc_ldIni)
                loc_leExpr = loc_ldIni
                IF BETWEEN(DAY(loc_leExpr), 28, 31) AND DAY(loc_leExpr + 1) = 1
                    loc_leExpr = GOMONTH(loc_leExpr, loc_lnMeses)
                    loc_leExpr = GOMONTH(CTOD("01" + SUBSTR(DTOC(loc_leExpr), 3)), 1) - 1
                ELSE
                    loc_leExpr = GOMONTH(loc_leExpr, loc_lnMeses)
                ENDIF
                THIS.txt_4c_Comp1.Value = loc_leExpr
            ENDIF

            IF !EMPTY(loc_ldFim)
                loc_leExpr = loc_ldFim
                IF BETWEEN(DAY(loc_leExpr), 28, 31) AND DAY(loc_leExpr + 1) = 1
                    loc_leExpr = GOMONTH(loc_leExpr, loc_lnMeses)
                    loc_leExpr = GOMONTH(CTOD("01" + SUBSTR(DTOC(loc_leExpr), 3)), 1) - 1
                ELSE
                    loc_leExpr = GOMONTH(loc_leExpr, loc_lnMeses)
                ENDIF
                THIS.txt_4c_Comp2.Value = loc_leExpr
            ENDIF
        ENDIF

        THIS.txt_4c_Comp1.Refresh()
        THIS.txt_4c_Comp2.Refresh()
    ENDPROC

    *==========================================================================
    * CHECKBOXES "MARCAR TUDO"
    *==========================================================================

    PROCEDURE MarcaEmpClick()
        IF THIS.chk_4c_MarcaEmp.Value = 1
            REPLACE ALL Imps WITH 1 IN csSigCdEmp
        ELSE
            REPLACE ALL Imps WITH 0 IN csSigCdEmp
        ENDIF
        THIS.grd_4c_Emps.Refresh()
        THIS.this_oRelatorio.DisponibilizarOrcamentos()
        THIS.ConfigurarGridOrcamentos()
        THIS.grd_4c_Orcs.Refresh()
    ENDPROC

    PROCEDURE MarcaOrcsClick()
        IF THIS.chk_4c_MarcaOrcs.Value = 1
            REPLACE ALL Imps WITH 1 IN crSigCdMrp
        ELSE
            REPLACE ALL Imps WITH 0 IN crSigCdMrp
        ENDIF
        THIS.grd_4c_Orcs.Refresh()
    ENDPROC

    *==========================================================================
    * GRID EMPRESAS - checkbox Column1
    *==========================================================================

    PROCEDURE EmpCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            REPLACE csSigCdEmp.Imps WITH IIF(csSigCdEmp.Imps = 0, 1, 0)
            THIS.grd_4c_Emps.Refresh()
            THIS.this_oRelatorio.DisponibilizarOrcamentos()
            THIS.ConfigurarGridOrcamentos()
            THIS.grd_4c_Orcs.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE EmpCheckMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.EmpCheckKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE EmpCheckMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE EmpCheckClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * GRID ORCAMENTOS - checkbox Column1
    *==========================================================================

    PROCEDURE OrcCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            REPLACE crSigCdMrp.Imps WITH IIF(crSigCdMrp.Imps = 0, 1, 0)
            THIS.grd_4c_Orcs.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE OrcCheckMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.OrcCheckKeyPress(13, 0)
        NODEFAULT
    ENDPROC

    PROCEDURE OrcCheckMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE OrcCheckClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * ESTADO DOS CONTROLES
    *==========================================================================

    PROTECTED PROCEDURE AtualizarEstadoMoedaDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c_CodMoeda.Value))
            THIS.txt_4c_DesMoeda.ReadOnly  = .F.
            THIS.txt_4c_DesMoeda.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c_DesMoeda.ReadOnly  = .T.
            THIS.txt_4c_DesMoeda.BackColor = RGB(240, 240, 240)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoComparativo()
        THIS.OptComparaChange()
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoOrcamentos()
        LOCAL loc_lMostrar
        loc_lMostrar = (THIS.this_nTipo = 1)
        THIS.lbl_4c_LblOrcamentos.Visible = loc_lMostrar
        THIS.chk_4c_MarcaOrcs.Visible     = loc_lMostrar
        THIS.grd_4c_Orcs.Visible          = loc_lMostrar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta todos os campos de filtro para valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.txt_4c_Demons.Value      = ""
        THIS.txt_4c_DtInicial.Value   = DATE()
        THIS.txt_4c_DtFinal.Value     = DATE()
        THIS.txt_4c_CodMoeda.Value    = ""
        THIS.txt_4c_DesMoeda.Value    = ""
        THIS.obj_4c_OptTpDatas.Value  = 2
        THIS.obj_4c_OptCotacao.Value  = 2
        THIS.obj_4c_OptCompara.Value  = 1
        THIS.obj_4c_OptSnt.Value      = 3
        THIS.obj_4c_OptContras.Value  = 1
        THIS.txt_4c_Comp1.Visible     = .F.
        THIS.txt_4c_Comp2.Visible     = .F.
        THIS.lbl_4c_LblCompA.Visible  = .F.
        THIS.AtualizarEstadoMoedaDesc()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE COM CONTRATO FORMBASE/CRUD
    * Este form e REPORT (frmrelatorio - layout FLAT), nao CRUD. Os metodos
    * abaixo expoem nomes do contrato CRUD delegando para os equivalentes
    * REPORT, garantindo paridade funcional e integracao com FormBase.
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Equivalente CRUD; delega para FormParaRelatorio
    * No contexto REPORT, "salvar no BO" significa transferir filtros do form
    * para as propriedades this_ do BO antes de PrepararDados().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Equivalente CRUD; carrega estado do BO para o form
    * No contexto REPORT, restaura nos controles os valores das propriedades
    * this_ do BO (uteil para reabrir form preservando filtros do BO).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oRelatorio
            THIS.txt_4c_DtInicial.Value     = .this_dDtInicial
            THIS.txt_4c_DtFinal.Value       = .this_dDtFinal
            THIS.txt_4c_CodMoeda.Value      = .this_cCodMoeda
            THIS.txt_4c_DesMoeda.Value      = .this_cDesMoeda
            THIS.txt_4c_Demons.Value        = .this_cDemonstrativo
            THIS.obj_4c_OptTpDatas.Value    = IIF(BETWEEN(.this_nTipoDatas, 1, 5), .this_nTipoDatas, 2)
            THIS.obj_4c_OptCotacao.Value    = IIF(BETWEEN(.this_nCotacao, 1, 2), .this_nCotacao, 2)
            THIS.obj_4c_OptCompara.Value    = IIF(BETWEEN(.this_nComparativo, 1, 3), .this_nComparativo, 1)
            THIS.txt_4c_Comp1.Value         = .this_dCompInicial
            THIS.txt_4c_Comp2.Value         = .this_dCompFinal
            THIS.obj_4c_OptSnt.Value        = IIF(BETWEEN(.this_nSnt, 1, 3), .this_nSnt, 3)
            THIS.obj_4c_OptContras.Value    = IIF(BETWEEN(.this_nContrapartida, 1, 2), .this_nContrapartida, 1)
        ENDWITH

        THIS.AtualizarEstadoMoedaDesc()
        THIS.AtualizarEstadoComparativo()
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Equivalente CRUD; reconstroi grids de empresas/orcamentos
    * No contexto REPORT, "lista" sao os grids de selecao multipla (empresas
    * marcadas para impressao + orcamentos disponiveis para o tipo Demonstrativo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        THIS.this_oRelatorio.InicializarDados()
        THIS.ConfigurarGridEmpresas()
        THIS.this_oRelatorio.DisponibilizarOrcamentos()
        THIS.ConfigurarGridOrcamentos()
        THIS.grd_4c_Emps.Refresh()
        THIS.grd_4c_Orcs.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Equivalente CRUD; delega para BtnImprimirClick
    * No contexto REPORT, a acao "principal" do form e gerar o relatorio.
    * Imprimir e a operacao definitiva (analoga a Salvar de um cadastro).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Equivalente CRUD; delega para BtnSairClick
    * No contexto REPORT, cancelar = fechar o form de filtros.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
