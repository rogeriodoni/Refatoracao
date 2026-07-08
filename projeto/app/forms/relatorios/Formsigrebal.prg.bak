*==============================================================================
* Formsigrebal.prg
* Formulario de Relatorio de Balanco
*
* Migrado de: SIGREBAL.SCX (frmrelatorio)
* Layout   : FLAT - controles direto no form, sem PageFrame
* Herda de : FormBase
*==============================================================================

DEFINE CLASS Formsigrebal AS FormBase

    *-- Propriedades visuais
    this_cMensagemErro = ""
    Height      = 400
    Width       = 800
    AutoCenter  = .T.
    BorderStyle = 2
    Caption     = "Relat" + CHR(243) + "rio de Balan" + CHR(231) + "o"
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    WindowType  = 1
    BackColor   = RGB(192, 192, 192)
    ShowWindow  = 1

    *-- BO de relatorio
    this_oRelatorio = .NULL.

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init()
    * Cria BO, configura cabecalho, botoes, campos de filtro e BINDEVENTs
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
                THIS.this_oRelatorio = CREATEOBJECT("sigrebalBO")

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCampos()
                THIS.ConfigurarBINDEVENTs()

                THIS.AtualizarEstadoMoedaDesc()
                THIS.AtualizarEstadoDesEmpresa()

                THIS.Visible = .T.

                IF loc_lSucesso AND TYPE("THIS.txt_4c__dt_final") = "O"
                    THIS.txt_4c__dt_final.SetFocus()
                ENDIF
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

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - REPORT form usa layout FLAT (sem Page Lista)
    * Mantido por contrato com a infraestrutura de migracao multi-fase.
    * Para REPORT forms a "lista" sao os controles de filtro configurados em
    * ConfigurarCampos(). Nao ha grid, nao ha registros para listar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - REPORT form nao possui PageFrame Lista/Dados
    * Mantido por contrato com a infraestrutura de migracao multi-fase.
    * O fluxo de REPORT eh sempre: ajustar filtros -> Visualizar/Imprimir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do relatorio
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
            .Caption   = "Relat" + CHR(243) + "rio de Balan" + CHR(231) + "o"
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
    * ConfigurarBotoes - CommandGroup com 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
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
            .Caption         = "\<Arquivos Email"
            .WordWrap        = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excel_60.jpg"
            .PicturePosition = 13
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

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
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        THIS.cmg_4c_Botoes.Buttons(4).Cancel = .T.
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Todos os campos de filtro direto no form (layout FLAT)
    *--------------------------------------------------------------------------
    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Primeira metade dos filtros do relatorio
    * Campos: periodo (data final), moeda (cod/desc), empresa (cod/desc),
    *         opcao conta zerada (Sim/Nao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- === ATE (periodo) top=132/137 ===
        THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH THIS.lbl_4c_Lbl_periodo
            .Top       = 137
            .Left      = 258
            .AutoSize  = .T.
            .Caption   = "At" + CHR(233) + " :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__dt_final", "TextBox")
        WITH THIS.txt_4c__dt_final
            .Top           = 132
            .Left          = 288
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

        *-- === MOEDA top=157/161 ===
        THIS.AddObject("lbl_4c_Lbl_moeda", "Label")
        WITH THIS.lbl_4c_Lbl_moeda
            .Top       = 161
            .Left      = 243
            .AutoSize  = .T.
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH THIS.txt_4c__cd_moeda
            .Top           = 157
            .Left          = 288
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

        THIS.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH THIS.txt_4c__ds_moeda
            .Top           = 157
            .Left          = 320
            .Width         = 115
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

        *-- === EMPRESA top=182/186 ===
        THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH THIS.lbl_4c_Lbl_empresa
            .Top       = 186
            .Left      = 234
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_empresa", "TextBox")
        WITH THIS.txt_4c__cd_empresa
            .Top           = 182
            .Left          = 288
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

        THIS.AddObject("txt_4c__ds_empresa", "TextBox")
        WITH THIS.txt_4c__ds_empresa
            .Top           = 182
            .Left          = 320
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === CONTA ZERADA top=207/211 ===
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 211
            .Left      = 209
            .AutoSize  = .T.
            .Caption   = "Conta Zerada :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptGcontaz", "OptionGroup")
        WITH THIS.obj_4c_OptGcontaz
            .ButtonCount = 2
            .Top         = 207
            .Left        = 283
            .Width       = 109
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            .Option1.Caption   = "\<Sim"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 40
            .Option1.Height    = 17

            .Option2.Caption   = "\<N" + CHR(227) + "o"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 45
            .Option2.Width     = 41
            .Option2.Height    = 17

            .Visible = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Todos os campos de filtro (delega primeira metade a
    *                    ConfigurarPaginaDados e adiciona segunda metade)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()

        THIS.ConfigurarPaginaDados()

        *-- === TIPO top=232/236 ===
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 236
            .Left      = 255
            .AutoSize  = .T.
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptGtprel", "OptionGroup")
        WITH THIS.obj_4c_OptGtprel
            .ButtonCount = 2
            .Top         = 232
            .Left        = 283
            .Width       = 140
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            .Option1.Caption   = "\<Anal" + CHR(237) + "tico"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 64
            .Option1.Height    = 17

            .Option2.Caption   = "S\<int" + CHR(233) + "tico"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 70
            .Option2.Width     = 65
            .Option2.Height    = 17

            .Visible = .T.
        ENDWITH

        *-- === COTACAO top=258/262 ===
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 262
            .Left      = 235
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
            .Top         = 258
            .Left        = 283
            .Width       = 210
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

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

            .Visible = .T.
        ENDWITH

        *-- === CLIENTE top=283/287 ===
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 287
            .Left      = 242
            .AutoSize  = .T.
            .Caption   = "Cliente :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Opt_Cli", "OptionGroup")
        WITH THIS.obj_4c_Opt_Cli
            .ButtonCount = 2
            .Top         = 283
            .Left        = 283
            .Width       = 140
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            .Option1.Caption   = "\<Anal" + CHR(237) + "tico"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 64
            .Option1.Height    = 17

            .Option2.Caption   = "S\<int" + CHR(233) + "tico"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 70
            .Option2.Width     = 65
            .Option2.Height    = 17

            .Visible = .T.
        ENDWITH

        *-- === ANALISE CONSISTENCIA top=305/309 ===
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 309
            .Left      = 190
            .AutoSize  = .T.
            .Caption   = "Anal. Consist" + CHR(234) + "ncia:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OpAnCst", "OptionGroup")
        WITH THIS.obj_4c_OpAnCst
            .ButtonCount = 2
            .Top         = 305
            .Left        = 283
            .Width       = 99
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2

            .Option1.Caption   = "\<Sim"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 42
            .Option1.Height    = 17

            .Option2.Caption   = "\<N" + CHR(227) + "o"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 51
            .Option2.Width     = 43
            .Option2.Height    = 17

            .Visible = .T.
        ENDWITH

        *-- === SALDO CONCILIADO top=324/330 ===
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 330
            .Left      = 176
            .AutoSize  = .T.
            .Caption   = "Para contas concili" + CHR(225) + "veis, utilizar saldo conciliado?"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_Optconcilias", "OptionGroup")
        WITH THIS.obj_4c_Optconcilias
            .ButtonCount = 2
            .Top         = 324
            .Left        = 420
            .Width       = 99
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2

            .Option1.Caption   = "\<Sim"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Width     = 42
            .Option1.Height    = 17

            .Option2.Caption   = "\<N" + CHR(227) + "o"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 51
            .Option2.Width     = 43
            .Option2.Height    = 17

            .Visible = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs - KeyPress (F4=lookup, ENTER/TAB=validar) + DblClick
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.txt_4c__cd_moeda,   "KeyPress", THIS, "TeclaLookupMoedaCod")
        BINDEVENT(THIS.txt_4c__ds_moeda,   "KeyPress", THIS, "TeclaLookupMoedaDesc")
        BINDEVENT(THIS.txt_4c__cd_moeda,   "DblClick", THIS, "AbrirBuscaMoedaCod")
        BINDEVENT(THIS.txt_4c__ds_moeda,   "DblClick", THIS, "AbrirBuscaMoedaDesc")

        BINDEVENT(THIS.txt_4c__cd_empresa, "KeyPress", THIS, "TeclaLookupEmpresaCod")
        BINDEVENT(THIS.txt_4c__ds_empresa, "KeyPress", THIS, "TeclaLookupEmpresaDesc")
        BINDEVENT(THIS.txt_4c__cd_empresa, "DblClick", THIS, "AbrirBuscaEmpresaCod")
        BINDEVENT(THIS.txt_4c__ds_empresa, "DblClick", THIS, "AbrirBuscaEmpresaDesc")
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoMoedaDesc - ds_moeda editavel apenas quando cd_moeda vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoMoedaDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c__cd_moeda.Value))
            THIS.txt_4c__ds_moeda.ReadOnly  = .F.
            THIS.txt_4c__ds_moeda.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c__ds_moeda.ReadOnly  = .T.
            THIS.txt_4c__ds_moeda.BackColor = RGB(240, 240, 240)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoDesEmpresa - ds_empresa editavel apenas quando cd_empresa vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoDesEmpresa()
        IF EMPTY(ALLTRIM(THIS.txt_4c__cd_empresa.Value))
            THIS.txt_4c__ds_empresa.ReadOnly  = .F.
            THIS.txt_4c__ds_empresa.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c__ds_empresa.ReadOnly  = .T.
            THIS.txt_4c__ds_empresa.BackColor = RGB(240, 240, 240)
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA pelo codigo (SigCdMoe.CMoes)
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
        loc_cValor = ALLTRIM(THIS.txt_4c__cd_moeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
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
        loc_cValor  = ALLTRIM(THIS.txt_4c__cd_moeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__ds_moeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeVal
            IF !EOF()
                THIS.txt_4c__ds_moeda.Value = ALLTRIM(DMoes)
            ELSE
                THIS.txt_4c__ds_moeda.Value = ""
                THIS.AbrirBuscaMoedaCod()
            ENDIF
        ELSE
            THIS.txt_4c__ds_moeda.Value = ""
            THIS.AbrirBuscaMoedaCod()
        ENDIF
        IF USED("cursor_4c_MoeVal")
            USE IN cursor_4c_MoeVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA pela descricao (SigCdMoe.DMoes)
    *==========================================================================

    PROCEDURE TeclaLookupMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c__ds_moeda.ReadOnly
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
        IF THIS.txt_4c__ds_moeda.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__ds_moeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeD", "DMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeD")
                        THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                        THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
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
        loc_cValor  = ALLTRIM(THIS.txt_4c__ds_moeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__cd_moeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE DMoes LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeDescVal
            IF !EOF()
                THIS.txt_4c__cd_moeda.Value = ALLTRIM(CMoes)
                THIS.txt_4c__ds_moeda.Value = ALLTRIM(DMoes)
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
    * LOOKUP - EMPRESA pelo codigo (SigCdEmp.Cemps)
    *==========================================================================

    PROCEDURE TeclaLookupEmpresaCod(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresaCod()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaCod()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresaCod()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                THIS.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        THIS.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        THIS.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresaCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor  = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__ds_empresa.Value = ""
            THIS.AtualizarEstadoDesEmpresa()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                THIS.txt_4c__ds_empresa.Value = ALLTRIM(Razas)
            ELSE
                THIS.txt_4c__ds_empresa.Value = ""
                THIS.AbrirBuscaEmpresaCod()
            ENDIF
        ELSE
            THIS.txt_4c__ds_empresa.Value = ""
            THIS.AbrirBuscaEmpresaCod()
        ENDIF
        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pela descricao (SigCdEmp.Razas)
    *==========================================================================

    PROCEDURE TeclaLookupEmpresaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c__ds_empresa.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaDesc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresaDesc()
        IF THIS.txt_4c__ds_empresa.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpD", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                THIS.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpD")
                        THIS.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                        THIS.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmpD")
            USE IN cursor_4c_BuscaEmpD
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresaDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor  = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__cd_empresa.Value = ""
            THIS.AtualizarEstadoDesEmpresa()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpDescVal
            IF !EOF()
                THIS.txt_4c__cd_empresa.Value = ALLTRIM(Cemps)
                THIS.txt_4c__ds_empresa.Value = ALLTRIM(Razas)
            ELSE
                THIS.AbrirBuscaEmpresaDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaEmpresaDesc()
        ENDIF
        IF USED("cursor_4c_EmpDescVal")
            USE IN cursor_4c_EmpDescVal
        ENDIF
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        THIS.this_oRelatorio.this_dDtFinal      = THIS.txt_4c__dt_final.Value
        THIS.this_oRelatorio.this_cCdMoeda      = ALLTRIM(THIS.txt_4c__cd_moeda.Value)
        THIS.this_oRelatorio.this_cDsMoeda      = ALLTRIM(THIS.txt_4c__ds_moeda.Value)
        THIS.this_oRelatorio.this_cCdEmpresa    = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
        THIS.this_oRelatorio.this_cDsEmpresa    = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
        THIS.this_oRelatorio.this_nContaz       = THIS.obj_4c_OptGcontaz.Value
        THIS.this_oRelatorio.this_nTpRel        = THIS.obj_4c_OptGtprel.Value
        THIS.this_oRelatorio.this_nOptCotacao   = THIS.obj_4c_OptCotacao.Value
        THIS.this_oRelatorio.this_nOptCli       = THIS.obj_4c_Opt_Cli.Value
        THIS.this_oRelatorio.this_nOpAnCst      = THIS.obj_4c_OpAnCst.Value
        THIS.this_oRelatorio.this_nOptConcilias = THIS.obj_4c_Optconcilias.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos antes de gerar o relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.txt_4c__dt_final.Value)
            MsgAviso("Data final " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                    "Balan" + CHR(231) + "o")
            THIS.txt_4c__dt_final.SetFocus()
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Impressao com dialogo
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.ImprimirComPrompt()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta cPlConta para planilha XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_oErro
        loc_cArquivo = ""

        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF THIS.this_oRelatorio.PrepararDados()
                    IF USED("cPlConta") AND RECCOUNT("cPlConta") > 0
                        loc_cArquivo = ADDBS(SYS(2023)) + "Balanco_" + DTOS(DATE()) + ;
                                       "_" + STRTRAN(TIME(), ":", "") + ".xls"
                        SELECT cPlConta
                        COPY TO (loc_cArquivo) TYPE XLS

                        IF FILE(loc_cArquivo)
                            DECLARE INTEGER ShellExecute IN shell32.dll ;
                                INTEGER hndWin, STRING cAction, ;
                                STRING cFileName, STRING cParams, ;
                                STRING cDir, INTEGER nShowWin
                            ShellExecute(0, "open", loc_cArquivo, "", "", 1)
                        ELSE
                            MsgErro("Erro ao gerar arquivo Excel.", "Balan" + CHR(231) + "o")
                        ENDIF
                    ELSE
                        MsgAviso("Nenhum dado para exportar.", "Balan" + CHR(231) + "o")
                    ENDIF
                ELSE
                    MsgErro("Erro ao preparar dados.", "Balan" + CHR(231) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrebal.BtnExcelClick")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT: foca o primeiro filtro para edicao manual
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.AtualizarEstadoMoedaDesc()
        THIS.AtualizarEstadoDesEmpresa()
        THIS.Refresh()
        IF TYPE("THIS.txt_4c__dt_final") = "O"
            THIS.txt_4c__dt_final.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT: descarta o cursor de dados gerado (se houver)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF USED("cPlConta")
            USE IN cPlConta
        ENDIF
        IF USED("Consulta")
            USE IN Consulta
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_cMensagemErro = ""
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Redefine todos os filtros para os valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c__dt_final.Value      = DATE()
        THIS.txt_4c__cd_moeda.Value      = ""
        THIS.txt_4c__ds_moeda.Value      = ""
        THIS.txt_4c__cd_empresa.Value    = ""
        THIS.txt_4c__ds_empresa.Value    = ""
        THIS.obj_4c_OptGcontaz.Value     = 1
        THIS.obj_4c_OptGtprel.Value      = 1
        THIS.obj_4c_OptCotacao.Value     = 1
        THIS.obj_4c_Opt_Cli.Value        = 1
        THIS.obj_4c_OpAnCst.Value        = 2
        THIS.obj_4c_Optconcilias.Value   = 2
        THIS.AtualizarEstadoMoedaDesc()
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita campos de filtro para edicao
    * Em REPORT: todos os campos de filtro ficam sempre editaveis.
    * ds_moeda e ds_empresa seguem regra de cd_* vazio (ver AtualizarEstado*).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos()
        THIS.txt_4c__dt_final.ReadOnly   = .F.
        THIS.txt_4c__cd_moeda.ReadOnly   = .F.
        THIS.txt_4c__cd_empresa.ReadOnly = .F.
        THIS.AtualizarEstadoMoedaDesc()
        THIS.AtualizarEstadoDesEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT: nao ha grid de lista; retorna .T. por contrato
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT: botoes permanecem sempre no mesmo estado
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere filtros do form para o BO (delega a FormParaRelatorio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega propriedades do BO de volta para os controles do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.txt_4c__dt_final.Value      = THIS.this_oRelatorio.this_dDtFinal
            THIS.txt_4c__cd_moeda.Value      = THIS.this_oRelatorio.this_cCdMoeda
            THIS.txt_4c__ds_moeda.Value      = THIS.this_oRelatorio.this_cDsMoeda
            THIS.txt_4c__cd_empresa.Value    = THIS.this_oRelatorio.this_cCdEmpresa
            THIS.txt_4c__ds_empresa.Value    = THIS.this_oRelatorio.this_cDsEmpresa
            THIS.obj_4c_OptGcontaz.Value     = THIS.this_oRelatorio.this_nContaz
            THIS.obj_4c_OptGtprel.Value      = THIS.this_oRelatorio.this_nTpRel
            THIS.obj_4c_OptCotacao.Value     = THIS.this_oRelatorio.this_nOptCotacao
            THIS.obj_4c_Opt_Cli.Value        = THIS.this_oRelatorio.this_nOptCli
            THIS.obj_4c_OpAnCst.Value        = THIS.this_oRelatorio.this_nOpAnCst
            THIS.obj_4c_Optconcilias.Value   = THIS.this_oRelatorio.this_nOptConcilias
            THIS.AtualizarEstadoMoedaDesc()
            THIS.AtualizarEstadoDesEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT: executa preview com os filtros atuais
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT: nao se aplica; orientar o usuario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        MsgAviso("Este relat" + CHR(243) + "rio n" + CHR(227) + "o possui " + ;
                 "opera" + CHR(231) + CHR(227) + "o de salvamento." + CHR(13) + ;
                 "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
                 "Balan" + CHR(231) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT: fecha o formulario (equivalente a Encerrar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O" AND NOT ISNULL(THIS.this_oRelatorio)
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
