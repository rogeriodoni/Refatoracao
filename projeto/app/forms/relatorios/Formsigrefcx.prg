*==============================================================================
* FORMSIGREFCX.PRG
* Relat" + CHR(243) + "rio Fechamento de Caixa
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREFCX.SCX (frmrelatorio)
*
* Filtros: Empresa, Per" + CHR(237) + "odo, Moeda, Usu" + CHR(225) + "rio, Operador
*          OptQuebra, OptImpNomCli, OpcTipo, OptCol, OptMov, opt_nr_opcao
*          9 combos de resumo, 3 checkboxes, GrdTipo (SigCdTom)
*
* Bot" + CHR(245) + "es: Visualizar / Imprimir / Excel / Encerrar
*==============================================================================

DEFINE CLASS Formsigrefcx AS FormBase

    Height      = 500
    Width       = 800
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

    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Fechamento de Caixa"
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("sigrefcxBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar sigrefcxBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Garante cs_SigCdTom para grid (BO popula com dados reais; placeholder aqui para UI validation)
                IF !USED("cs_SigCdTom")
                    CREATE CURSOR cs_SigCdTom (Marca n(1), Descri c(40), Codigos n(2))
                    INDEX ON Codigos TAG Codigos
                ENDIF

                THIS.ConfigurarPaginaLista()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()
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
                .Caption   = "Fechamento de Caixa"
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
                .Caption   = "Fechamento de Caixa"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

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
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
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

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *======================================================================
        * EMPRESA (original top=96/99 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oPg.lbl_4c_LblEmpresa
            .Top       = 14
            .Left      = 108
            .Width     = 52
            .Height    = 15
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_CdEmpresa
            .Top           = 11
            .Left          = 162
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 3
            .InputMask     = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_DsEmpresa
            .Top           = 11
            .Left          = 195
            .Width         = 289
            .Height        = 23
            .Value         = ""
            .MaxLength     = 40
            .InputMask     = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * PERIODO (original top=121/124 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPg.lbl_4c_LblPeriodo
            .Top       = 39
            .Left      = 113
            .Width     = 48
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top           = 36
            .Left          = 162
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_SepDatas", "Label")
        WITH loc_oPg.lbl_4c_SepDatas
            .Top       = 39
            .Left      = 247
            .Width     = 22
            .Height    = 15
            .Caption   = "at" + CHR(233)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top           = 36
            .Left          = 271
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * MOEDA (original top=146/149 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblMoeda", "Label")
        WITH loc_oPg.lbl_4c_LblMoeda
            .Top       = 64
            .Left      = 117
            .Width     = 44
            .Height    = 15
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oPg.txt_4c_CdMoeda
            .Top           = 61
            .Left          = 162
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 3
            .InputMask     = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPg.txt_4c_DsMoeda
            .Top           = 61
            .Left          = 195
            .Width         = 156
            .Height        = 23
            .Value         = ""
            .MaxLength     = 15
            .InputMask     = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * USUARIO / OPERADOR (original top=171/174 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblUsuario", "Label")
        WITH loc_oPg.lbl_4c_LblUsuario
            .Top       = 89
            .Left      = 113
            .Width     = 47
            .Height    = 15
            .Caption   = "Usu" + CHR(225) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Usuario", "TextBox")
        WITH loc_oPg.txt_4c_Usuario
            .Top           = 86
            .Left          = 162
            .Width         = 82
            .Height        = 23
            .Value         = ""
            .MaxLength     = 10
            .InputMask     = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblOperador", "Label")
        WITH loc_oPg.lbl_4c_LblOperador
            .Top       = 89
            .Left      = 262
            .Width     = 56
            .Height    = 15
            .Caption   = "Operador :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Operador", "TextBox")
        WITH loc_oPg.txt_4c_Operador
            .Top           = 86
            .Left          = 320
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 10
            .InputMask     = "999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * QUEBRA DE IMPRESSAO (original top=198/199 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblQuebra", "Label")
        WITH loc_oPg.lbl_4c_LblQuebra
            .Top       = 114
            .Left      = 45
            .Width     = 110
            .Height    = 15
            .Caption   = "Quebra de Impress" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_OptQuebra", "OptionGroup")
        loc_oPg.opt_4c_OptQuebra.ButtonCount = 2
        WITH loc_oPg.opt_4c_OptQuebra
            .Top         = 198
            .Left        = 155
            .Width       = 232
            .Height      = 20
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_OptQuebra.Buttons(1)
            .Caption   = "Usu" + CHR(225) + "rio"
            .Left      = 5
            .Top       = 2
            .Width     = 54
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_OptQuebra.Buttons(2)
            .Caption   = "Sem Quebra"
            .Left      = 111
            .Top       = 2
            .Width     = 77
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_OptQuebra.Value = 1

        *======================================================================
        * NOME DO CLIENTE (original top=221/222 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblNomeCli", "Label")
        WITH loc_oPg.lbl_4c_LblNomeCli
            .Top       = 137
            .Left      = 71
            .Width     = 82
            .Height    = 15
            .Caption   = "Nome do Cliente :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_ImpNomCli", "OptionGroup")
        loc_oPg.opt_4c_ImpNomCli.ButtonCount = 3
        WITH loc_oPg.opt_4c_ImpNomCli
            .Top         = 136
            .Left        = 155
            .Width       = 232
            .Height      = 36
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_ImpNomCli.Buttons(1)
            .Caption   = "Imprimir"
            .Left      = 5
            .Top       = 2
            .Width     = 56
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_ImpNomCli.Buttons(2)
            .Caption   = "N" + CHR(227) + "o Imprimir"
            .Left      = 111
            .Top       = 2
            .Width     = 78
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_ImpNomCli.Buttons(3)
            .Caption   = "Imprimir Nome OU Observa" + CHR(231) + CHR(227) + "o"
            .WordWrap        = .T.
            .Left      = 5
            .Top       = 19
            .Width     = 165
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *======================================================================
        * TIPO (Opc_Tipo): Agrupado/Individual (original top=259/264 -> -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblTipo", "Label")
        WITH loc_oPg.lbl_4c_LblTipo
            .Top       = 179
            .Left      = 129
            .Width     = 29
            .Height    = 15
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_OpcTipo", "OptionGroup")
        loc_oPg.opt_4c_OpcTipo.ButtonCount = 2
        WITH loc_oPg.opt_4c_OpcTipo
            .Top         = 174
            .Left        = 155
            .Width       = 232
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_OpcTipo.Buttons(1)
            .Caption   = "Agrupado"
            .Left      = 5
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_OpcTipo.Buttons(2)
            .Caption   = "Individual"
            .Left      = 111
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_OpcTipo.Value = 1

        *======================================================================
        * IMPRESSAO EM (OptCol): 40/80 colunas (original top=283/288 -> -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblOptCol", "Label")
        WITH loc_oPg.lbl_4c_LblOptCol
            .Top       = 203
            .Left      = 82
            .Width     = 71
            .Height    = 15
            .Caption   = "Impress" + CHR(227) + "o em :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_OptCol", "OptionGroup")
        loc_oPg.opt_4c_OptCol.ButtonCount = 2
        WITH loc_oPg.opt_4c_OptCol
            .Top         = 283
            .Left        = 155
            .Width       = 232
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_OptCol.Buttons(1)
            .Caption   = "40 Colunas"
            .Left      = 5
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_OptCol.Buttons(2)
            .Caption   = "80 Colunas"
            .Left      = 111
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_OptCol.Value = 2

        *======================================================================
        * OPCAO (opt_nr_opcao): Sim/Nao/Ambos (original top=308/311 -> -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblNrOpcao", "Label")
        WITH loc_oPg.lbl_4c_LblNrOpcao
            .Top       = 226
            .Left      = 118
            .Width     = 35
            .Height    = 15
            .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_NrOpcao", "OptionGroup")
        loc_oPg.opt_4c_NrOpcao.ButtonCount = 3
        WITH loc_oPg.opt_4c_NrOpcao
            .Top         = 223
            .Left        = 155
            .Width       = 232
            .Height      = 23
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_NrOpcao.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 4
            .Width     = 34
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_NrOpcao.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 59
            .Top       = 4
            .Width     = 37
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_NrOpcao.Buttons(3)
            .Caption   = "Ambos"
            .WordWrap        = .T.
            .Left      = 111
            .Top       = 4
            .Width     = 50
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_NrOpcao.Value = 3

        *======================================================================
        * MOVIMENTACOES (OptMov): Sim/Nao (original top=327/332 -> -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblOptMov", "Label")
        WITH loc_oPg.lbl_4c_LblOptMov
            .Top       = 247
            .Left      = 75
            .Width     = 80
            .Height    = 15
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_OptMov", "OptionGroup")
        loc_oPg.opt_4c_OptMov.ButtonCount = 2
        WITH loc_oPg.opt_4c_OptMov
            .Top         = 327
            .Left        = 155
            .Width       = 232
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_OptMov.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_OptMov.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 111
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_OptMov.Value = 1

        *======================================================================
        * TIPO DE MOVIMENTACAO (painel direito) - original top=201/216 -> -85
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblTipoMov", "Label")
        WITH loc_oPg.lbl_4c_LblTipoMov
            .Top       = 116
            .Left      = 403
            .Width     = 172
            .Height    = 17
            .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("grd_4c_GrdTipo", "Grid")
        WITH loc_oPg.grd_4c_GrdTipo
            .Top           = 216
            .Left          = 403
            .Width         = 251
            .Height        = 138
            .RecordSource  = "cs_SigCdTom"
            .ColumnCount   = 2
            .DeleteMark    = .F.
            .HeaderHeight  = 0
            .RecordMark    = .F.
            .RowHeight     = 18
            .ScrollBars    = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .GridLineColor = RGB(238, 238, 238)
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.grd_4c_GrdTipo.Column1
            .Width     = 20
            .Alignment = 0
            .Sparse    = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .T.
            .AddObject("chk_4c_GrdMarca", "CheckBox")
            WITH .chk_4c_GrdMarca
                .Caption   = ""
                .Alignment = 0
                .Width     = 20
                .Height    = 17
                .FontName  = "Tahoma"
            ENDWITH
            .CurrentControl = "chk_4c_GrdMarca"
            .ControlSource  = "cs_SigCdTom.Marca"
        ENDWITH
        WITH loc_oPg.grd_4c_GrdTipo.Column2
            .Width         = 215
            .ControlSource = "cs_SigCdTom.Descri"
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Enabled       = .T.
        ENDWITH

        loc_oPg.AddObject("btn_4c_SelTudo", "CommandButton")
        WITH loc_oPg.btn_4c_SelTudo
            .Top         = 241
            .Left        = 657
            .Width       = 45
            .Height      = 45
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .ToolTipText = "Marcar"
            .TabStop     = .F.
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("btn_4c_Apaga", "CommandButton")
        WITH loc_oPg.btn_4c_Apaga
            .Top         = 286
            .Left        = 657
            .Width       = 45
            .Height      = 45
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Desmarcar"
            .TabStop     = .F.
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH

        *======================================================================
        * SEPARADOR (shp_fechamento original top=366 -> -85)
        *======================================================================
        loc_oPg.AddObject("shp_4c_Separador", "Shape")
        WITH loc_oPg.shp_4c_Separador
            .Top         = 275
            .Left        = 6
            .Width       = 782
            .Height      = 2
            .BackStyle   = 1
            .BorderStyle = 6
            .BorderWidth = 2
            .FillStyle   = 1
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        *======================================================================
        * IMPRESSAO DE RESUMOS - cabecalho (original top=351 -> -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblResumos", "Label")
        WITH loc_oPg.lbl_4c_LblResumos
            .Top       = 266
            .Left      = 6
            .Width     = 135
            .Height    = 15
            .Caption   = "Impress" + CHR(227) + "o de Resumos"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Linha 1: Lancamento | Lancto.xF.Pagto | Conta Corrente
        loc_oPg.AddObject("lbl_4c_LblLanca", "Label")
        WITH loc_oPg.lbl_4c_LblLanca
            .Top       = 292
            .Left      = 32
            .Width     = 70
            .Height    = 15
            .Caption   = "Lan" + CHR(231) + "amento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResLanca", "ComboBox")
        WITH loc_oPg.cmb_4c_ResLanca
            .Top           = 287
            .Left          = 103
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_ChkDetLan", "CheckBox")
        WITH loc_oPg.chk_4c_ChkDetLan
            .Top           = 376
            .Left          = 155
            .Width         = 67
            .Height        = 15
            .Caption       = "Detalhado"
            .Value         = 0
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblLanFor", "Label")
        WITH loc_oPg.lbl_4c_LblLanFor
            .Top       = 292
            .Left      = 322
            .Width     = 100
            .Height    = 15
            .Caption   = "Lan" + CHR(231) + "to. x F. Pagto.:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResLanFor", "ComboBox")
        WITH loc_oPg.cmb_4c_ResLanFor
            .Top           = 287
            .Left          = 424
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblContaC", "Label")
        WITH loc_oPg.lbl_4c_LblContaC
            .Top       = 292
            .Left      = 590
            .Width     = 85
            .Height    = 15
            .Caption   = "Conta Corrente :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResContac", "ComboBox")
        WITH loc_oPg.cmb_4c_ResContac
            .Top           = 287
            .Left          = 678
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Linha 2: Cartao | Forma de Pagamento | Resumo Quantidade
        loc_oPg.AddObject("lbl_4c_LblCartao", "Label")
        WITH loc_oPg.lbl_4c_LblCartao
            .Top       = 318
            .Left      = 57
            .Width     = 44
            .Height    = 15
            .Caption   = "Cart" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResCartao", "ComboBox")
        WITH loc_oPg.cmb_4c_ResCartao
            .Top           = 313
            .Left          = 103
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_CrtDetalhado", "CheckBox")
        WITH loc_oPg.chk_4c_CrtDetalhado
            .Top           = 318
            .Left          = 155
            .Width         = 67
            .Height        = 15
            .Caption       = "Detalhado"
            .Value         = 0
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblForma", "Label")
        WITH loc_oPg.lbl_4c_LblForma
            .Top       = 318
            .Left      = 310
            .Width     = 112
            .Height    = 15
            .Caption   = "Forma de Pagamento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResForma", "ComboBox")
        WITH loc_oPg.cmb_4c_ResForma
            .Top           = 313
            .Left          = 424
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblQtdes", "Label")
        WITH loc_oPg.lbl_4c_LblQtdes
            .Top       = 318
            .Left      = 568
            .Width     = 108
            .Height    = 15
            .Caption   = "Resumo Quantidade :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResQtdes", "ComboBox")
        WITH loc_oPg.cmb_4c_ResQtdes
            .Top           = 313
            .Left          = 678
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Linha 3: Cheques | Vendedor | Vendedor Detalhado
        loc_oPg.AddObject("lbl_4c_LblCheque", "Label")
        WITH loc_oPg.lbl_4c_LblCheque
            .Top       = 344
            .Left      = 48
            .Width     = 53
            .Height    = 15
            .Caption   = "Cheques :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResCheque", "ComboBox")
        WITH loc_oPg.cmb_4c_ResCheque
            .Top           = 339
            .Left          = 103
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_ChqDetalhado", "CheckBox")
        WITH loc_oPg.chk_4c_ChqDetalhado
            .Top           = 344
            .Left          = 155
            .Width         = 67
            .Height        = 15
            .Caption       = "Detalhado"
            .Value         = 0
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblVendedor", "Label")
        WITH loc_oPg.lbl_4c_LblVendedor
            .Top       = 344
            .Left      = 366
            .Width     = 56
            .Height    = 15
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResVende", "ComboBox")
        WITH loc_oPg.cmb_4c_ResVende
            .Top           = 339
            .Left          = 424
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblDetVen", "Label")
        WITH loc_oPg.lbl_4c_LblDetVen
            .Top       = 344
            .Left      = 567
            .Width     = 110
            .Height    = 15
            .Caption   = "Vendedor Detalhado :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResDetVen", "ComboBox")
        WITH loc_oPg.cmb_4c_ResDetVen
            .Top           = 339
            .Left          = 678
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        THIS.ConfigurarPaginaDados()
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaCdEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "KeyPress", THIS, "TeclaDsEmpresa")
        BINDEVENT(loc_oPg.txt_4c_CdMoeda,   "KeyPress", THIS, "TeclaCdMoeda")
        BINDEVENT(loc_oPg.txt_4c_DsMoeda,   "KeyPress", THIS, "TeclaDsMoeda")
        BINDEVENT(loc_oPg.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPg.txt_4c_DtFinal,   "KeyPress", THIS, "TeclaDataFinal")
        BINDEVENT(loc_oPg.txt_4c_Usuario,   "KeyPress", THIS, "TeclaUsuario")
        BINDEVENT(loc_oPg.txt_4c_Operador,  "KeyPress", THIS, "TeclaOperador")

        BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "DblClick", THIS, "AbrirBuscaCdEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "DblClick", THIS, "AbrirBuscaDsEmpresa")
        BINDEVENT(loc_oPg.txt_4c_CdMoeda,   "DblClick", THIS, "AbrirBuscaCdMoeda")
        BINDEVENT(loc_oPg.txt_4c_DsMoeda,   "DblClick", THIS, "AbrirBuscaDsMoeda")
        BINDEVENT(loc_oPg.txt_4c_Usuario,   "DblClick", THIS, "AbrirBuscaUsuario")
        BINDEVENT(loc_oPg.txt_4c_Operador,  "DblClick", THIS, "AbrirBuscaOperador")

        BINDEVENT(loc_oPg.opt_4c_OptCol,   "InteractiveChange", THIS, "OptColMudou")
        BINDEVENT(loc_oPg.btn_4c_SelTudo,  "Click",             THIS, "BtnSelTudoClick")
        BINDEVENT(loc_oPg.btn_4c_Apaga,    "Click",             THIS, "BtnApagaClick")
    ENDPROC

    PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_nOptCol
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(THIS.this_oRelatorio.this_cCdEmpresa)
            loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(THIS.this_oRelatorio.this_cDsEmpresa)
            loc_oPg.txt_4c_DtInicial.Value = THIS.this_oRelatorio.this_dDtInicial
            loc_oPg.txt_4c_DtFinal.Value   = THIS.this_oRelatorio.this_dDtFinal
            loc_oPg.txt_4c_CdMoeda.Value   = ALLTRIM(THIS.this_oRelatorio.this_cCdMoeda)
            loc_oPg.txt_4c_DsMoeda.Value   = ALLTRIM(THIS.this_oRelatorio.this_cDsMoeda)
            loc_oPg.txt_4c_Usuario.Value   = ALLTRIM(THIS.this_oRelatorio.this_cUsuario)
            loc_oPg.txt_4c_Operador.Value  = ALLTRIM(THIS.this_oRelatorio.this_cOperador)

            *-- OptCol a partir de SigCdPam.resimps (default 2 = 80 colunas)
            loc_nOptCol = 2
            IF USED("CrSigCdPam")
                SELECT CrSigCdPam
                GO TOP
                IF !EOF() AND TYPE("CrSigCdPam.resimps") != "U"
                    IF INLIST(NVL(resimps, 0), 1, 2)
                        loc_nOptCol = NVL(resimps, 2)
                    ENDIF
                ENDIF
            ENDIF
            loc_oPg.opt_4c_OptCol.Value = loc_nOptCol

            loc_oPg.opt_4c_OptQuebra.Value = THIS.this_oRelatorio.this_nOptQuebra
            loc_oPg.opt_4c_ImpNomCli.Value = THIS.this_oRelatorio.this_nOptImpNomCli
            loc_oPg.opt_4c_OpcTipo.Value   = THIS.this_oRelatorio.this_nOpcTipo
            loc_oPg.opt_4c_OptMov.Value    = THIS.this_oRelatorio.this_nOptMov
            loc_oPg.opt_4c_NrOpcao.Value   = THIS.this_oRelatorio.this_nOptNrOpcao

            *-- 40 colunas: desabilita e forca ImpNomCli = Nao Imprimir
            loc_oPg.opt_4c_ImpNomCli.Enabled = (loc_nOptCol = 2)
            IF loc_nOptCol = 1
                loc_oPg.opt_4c_ImpNomCli.Value = 2
            ENDIF

            *-- ComboBoxes de resumo (ListIndex: 1=Sim, 2=Nao)
            loc_oPg.cmb_4c_ResLanca.ListIndex  = THIS.this_oRelatorio.this_nResLanca
            loc_oPg.cmb_4c_ResForma.ListIndex  = THIS.this_oRelatorio.this_nResForma
            loc_oPg.cmb_4c_ResCheque.ListIndex = THIS.this_oRelatorio.this_nResCheque
            loc_oPg.cmb_4c_ResCartao.ListIndex = THIS.this_oRelatorio.this_nResCartao
            loc_oPg.cmb_4c_ResVende.ListIndex  = THIS.this_oRelatorio.this_nResVende
            loc_oPg.cmb_4c_ResContac.ListIndex = THIS.this_oRelatorio.this_nResConta
            loc_oPg.cmb_4c_ResLanFor.ListIndex = THIS.this_oRelatorio.this_nResLanFor
            loc_oPg.cmb_4c_ResQtdes.ListIndex  = THIS.this_oRelatorio.this_nResQtdes
            loc_oPg.cmb_4c_ResDetVen.ListIndex = THIS.this_oRelatorio.this_nResVDets

            *-- CheckBoxes
            loc_oPg.chk_4c_CrtDetalhado.Value = THIS.this_oRelatorio.this_nCrtDetalhado
            loc_oPg.chk_4c_ChqDetalhado.Value = THIS.this_oRelatorio.this_nChqDetalhado
            loc_oPg.chk_4c_ChkDetLan.Value    = THIS.this_oRelatorio.this_nChkDetLan

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cCdEmpresa    = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
            .this_cDsEmpresa    = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
            .this_dDtInicial    = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal      = loc_oPg.txt_4c_DtFinal.Value
            .this_cCdMoeda      = ALLTRIM(loc_oPg.txt_4c_CdMoeda.Value)
            .this_cDsMoeda      = ALLTRIM(loc_oPg.txt_4c_DsMoeda.Value)
            .this_cUsuario      = ALLTRIM(loc_oPg.txt_4c_Usuario.Value)
            .this_cOperador     = ALLTRIM(loc_oPg.txt_4c_Operador.Value)
            .this_nOptQuebra    = loc_oPg.opt_4c_OptQuebra.Value
            .this_nOptImpNomCli = loc_oPg.opt_4c_ImpNomCli.Value
            .this_nOpcTipo      = loc_oPg.opt_4c_OpcTipo.Value
            .this_nOptcol       = loc_oPg.opt_4c_OptCol.Value
            .this_nOptNrOpcao   = loc_oPg.opt_4c_NrOpcao.Value
            .this_nOptMov       = loc_oPg.opt_4c_OptMov.Value
            .this_nResLanca  = IIF(loc_oPg.cmb_4c_ResLanca.ListIndex  > 0, loc_oPg.cmb_4c_ResLanca.ListIndex,  1)
            .this_nResForma  = IIF(loc_oPg.cmb_4c_ResForma.ListIndex  > 0, loc_oPg.cmb_4c_ResForma.ListIndex,  1)
            .this_nResCheque = IIF(loc_oPg.cmb_4c_ResCheque.ListIndex > 0, loc_oPg.cmb_4c_ResCheque.ListIndex, 1)
            .this_nResCartao = IIF(loc_oPg.cmb_4c_ResCartao.ListIndex > 0, loc_oPg.cmb_4c_ResCartao.ListIndex, 1)
            .this_nResVende  = IIF(loc_oPg.cmb_4c_ResVende.ListIndex  > 0, loc_oPg.cmb_4c_ResVende.ListIndex,  1)
            .this_nResConta  = IIF(loc_oPg.cmb_4c_ResContac.ListIndex > 0, loc_oPg.cmb_4c_ResContac.ListIndex, 1)
            .this_nResLanFor = IIF(loc_oPg.cmb_4c_ResLanFor.ListIndex > 0, loc_oPg.cmb_4c_ResLanFor.ListIndex, 1)
            .this_nResQtdes  = IIF(loc_oPg.cmb_4c_ResQtdes.ListIndex  > 0, loc_oPg.cmb_4c_ResQtdes.ListIndex,  1)
            .this_nResVDets  = IIF(loc_oPg.cmb_4c_ResDetVen.ListIndex > 0, loc_oPg.cmb_4c_ResDetVen.ListIndex, 1)
            .this_nCrtDetalhado = loc_oPg.chk_4c_CrtDetalhado.Value
            .this_nChqDetalhado = loc_oPg.chk_4c_ChqDetalhado.Value
            .this_nChkDetLan    = loc_oPg.chk_4c_ChkDetLan.Value
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ValidarPeriodo()
        LOCAL loc_oPg, loc_dIni, loc_dFim
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dIni = loc_oPg.txt_4c_DtInicial.Value
        loc_dFim = loc_oPg.txt_4c_DtFinal.Value
        IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
            MsgAviso("Data Final Menor Que a Inicial!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtFinal.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !THIS.ValidarPeriodo()
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar AND VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !THIS.ValidarPeriodo()
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar AND VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcelClick()
        LOCAL loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !THIS.ValidarPeriodo()
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar AND VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.GerarExcel()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *-- OptCol.InteractiveChange: 40 colunas obriga ImpNomCli = Nao Imprimir
    PROCEDURE OptColMudou()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF loc_oPg.opt_4c_OptCol.Value = 1
                loc_oPg.opt_4c_ImpNomCli.Value   = 2
                loc_oPg.opt_4c_ImpNomCli.Enabled = .F.
            ELSE
                loc_oPg.opt_4c_ImpNomCli.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OptColMudou")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSelTudoClick()
        TRY
            IF USED("cs_SigCdTom")
                SELECT cs_SigCdTom
                REPLACE ALL Marca WITH 1
                GO TOP
                THIS.pgf_4c_Paginas.Page1.grd_4c_GrdTipo.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnSelTudoClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnApagaClick()
        TRY
            IF USED("cs_SigCdTom")
                SELECT cs_SigCdTom
                REPLACE ALL Marca WITH 0
                GO TOP
                THIS.pgf_4c_Paginas.Page1.grd_4c_GrdTipo.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnApagaClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (F4=115, ENTER=13, TAB=9)
    *==========================================================================

    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdMoeda()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsMoeda()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_dIni, loc_dFim
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c_DtInicial.Value
            loc_dFim = loc_oPg.txt_4c_DtFinal.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
                loc_oPg.txt_4c_DtFinal.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_dIni, loc_dFim
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c_DtInicial.Value
            loc_dFim = loc_oPg.txt_4c_DtFinal.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dFim < loc_dIni
                MsgAviso("Data Final Menor Que a Inicial!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_DtFinal.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaUsuario(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaUsuario()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarUsuario()
        ENDIF
    ENDPROC

    PROCEDURE TeclaOperador(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaOperador()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarOperador()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA
    *==========================================================================

    PROCEDURE AbrirBuscaCdEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Empresa")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaDsEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Empresa")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsEmpresa.Value = ""
            RETURN
        ENDIF
        IF USED("CrSigCdEmp") AND SEEK(loc_cValor, "CrSigCdEmp", "Cemps")
            loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(CrSigCdEmp.Razas)
        ELSE
            loc_oPg.txt_4c_DsEmpresa.Value = ""
            THIS.AbrirBuscaCdEmpresa()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarDsEmpresa()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdEmpresa.Value = ""
            RETURN
        ENDIF
        IF USED("CrSigCdEmp")
            SELECT CrSigCdEmp
            LOCATE FOR LEFT(UPPER(ALLTRIM(razas)), LEN(UPPER(loc_cValor))) = UPPER(loc_cValor)
            IF !EOF()
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(CrSigCdEmp.Cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(CrSigCdEmp.Razas)
            ELSE
                THIS.AbrirBuscaDsEmpresa()
            ENDIF
        ELSE
            THIS.AbrirBuscaDsEmpresa()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA
    *==========================================================================

    PROCEDURE AbrirBuscaCdMoeda()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdMoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", loc_cValor, ;
            "Moedas", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        loc_oPg.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                        loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
                    ELSE
                        loc_oPg.txt_4c_CdMoeda.Value = ""
                        loc_oPg.txt_4c_DsMoeda.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaDsMoeda()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsMoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "dmoes", loc_cValor, ;
            "Moedas", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        loc_oPg.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                        loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
                    ELSE
                        loc_oPg.txt_4c_DsMoeda.Value = ""
                        loc_oPg.txt_4c_CdMoeda.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarCdMoeda()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdMoeda.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsMoeda.Value = ""
            RETURN
        ENDIF
        IF USED("CrSigCdMoe") AND SEEK(PADR(loc_cValor, 3), "CrSigCdMoe", "cmoes")
            loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(CrSigCdMoe.dmoes)
        ELSE
            loc_oPg.txt_4c_DsMoeda.Value = ""
            THIS.AbrirBuscaCdMoeda()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarDsMoeda()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsMoeda.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdMoeda.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsMoeda()
    ENDPROC

    *==========================================================================
    * LOOKUP - USUARIO
    *==========================================================================

    PROCEDURE AbrirBuscaUsuario()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Usuario.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaUsu", "usuarios", loc_cValor, ;
            "Usu" + CHR(225) + "rios", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Usuario.Value = ALLTRIM(cursor_4c_BuscaUsu.usuarios)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("usuarios", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                        loc_oPg.txt_4c_Usuario.Value = ALLTRIM(cursor_4c_BuscaUsu.usuarios)
                    ELSE
                        loc_oPg.txt_4c_Usuario.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarUsuario()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Usuario.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 usuarios FROM SigCdUsu WHERE usuarios = " + ;
            EscaparSQL(PADR(loc_cValor, 10))
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuVal")
        IF loc_nResult > 0
            SELECT cursor_4c_UsuVal
            IF EOF()
                loc_oPg.txt_4c_Usuario.Value = ""
                THIS.AbrirBuscaUsuario()
            ENDIF
        ELSE
            loc_oPg.txt_4c_Usuario.Value = ""
            THIS.AbrirBuscaUsuario()
        ENDIF
        IF USED("cursor_4c_UsuVal")
            USE IN cursor_4c_UsuVal
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - OPERADOR (lista de usuarios com codigo numerico curto)
    *==========================================================================

    PROCEDURE AbrirBuscaOperador()
        LOCAL loc_cValor, loc_oPg, loc_nResult, loc_oBusca
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Operador.Value)

        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT Usuarios FROM SigCdUsu " + ;
            "WHERE LEN(RTRIM(Usuarios)) < 4 AND ISNUMERIC(Usuarios) = 1", ;
            "cursor_4c_Operadores")
        IF loc_nResult < 1
            MsgErro("Falha ao carregar lista de operadores", "AbrirBuscaOperador")
            RETURN
        ENDIF
        SELECT cursor_4c_Operadores
        INDEX ON Usuarios TAG Usuarios

        IF EMPTY(loc_cValor) OR ;
           !SEEK(PADR(loc_cValor, 10), "cursor_4c_Operadores", "Usuarios")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "cursor_4c_Operadores", "cursor_4c_Operadores", "Usuarios", ;
                loc_cValor, "Operadores", .F., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Usuarios", "", "Operadores")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Operadores")
                    loc_oPg.txt_4c_Operador.Value = ALLTRIM(cursor_4c_Operadores.Usuarios)
                ELSE
                    loc_oPg.txt_4c_Operador.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        ELSE
            loc_oPg.txt_4c_Operador.Value = ALLTRIM(cursor_4c_Operadores.Usuarios)
        ENDIF

        IF USED("cursor_4c_Operadores")
            USE IN cursor_4c_Operadores
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarOperador()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Operador.Value)
        IF !EMPTY(loc_cValor)
            THIS.AbrirBuscaOperador()
        ENDIF
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    *==========================================================================

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

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROCEDURE BOParaForm()
        THIS.LimparCampos()
    ENDPROC

    PROCEDURE CarregarLista()
        THIS.LimparCampos()
        RETURN .T.
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Visible = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                loc_oPg.txt_4c_CdEmpresa.Enabled = par_lHabilitar
                loc_oPg.txt_4c_DsEmpresa.Enabled = par_lHabilitar
                loc_oPg.txt_4c_DtInicial.Enabled = par_lHabilitar
                loc_oPg.txt_4c_DtFinal.Enabled   = par_lHabilitar
                loc_oPg.txt_4c_CdMoeda.Enabled   = par_lHabilitar
                loc_oPg.txt_4c_DsMoeda.Enabled   = par_lHabilitar
                loc_oPg.txt_4c_Usuario.Enabled   = par_lHabilitar
                loc_oPg.txt_4c_Operador.Enabled  = par_lHabilitar
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Page1.txt_4c_CdEmpresa.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oPgf
        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) = "O"
                loc_oPgf.ActivePage = 1
                IF VARTYPE(loc_oPgf.Pages(1)) = "O" AND ;
                   PEMSTATUS(loc_oPgf.Pages(1), "txt_4c_CdEmpresa", 5)
                    loc_oPgf.Pages(1).txt_4c_CdEmpresa.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AlternarPagina")
        ENDTRY
    ENDPROC

    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
