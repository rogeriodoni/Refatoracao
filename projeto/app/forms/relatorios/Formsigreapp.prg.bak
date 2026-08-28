*==============================================================================
* FORMSIGREAPP.PRG
* Formulario de Relatorio de Analise a Pagar / Receber
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREAPP.SCX (frmrelatorio)
*
* Dimensoes: Width=1300, Height=700
* Cabecalho: cnt_4c_Cabecalho Top=0, Height=80, BackColor=RGB(100,100,100)
* Filtros: pgf_4c_Paginas.Page1 (Top=85, Height=615, Tabs=.F.)
* Coordenadas de controles em Page1 = Top_original - 85
*
* BO: sigreappBO (herda RelatorioBase)
* Cursores: cursor_4c_SigCdEmp, cursor_4c_SigOpOpe, cursor_4c_SigCdClc,
*           cursor_4c_SigCdCot (carregados em CarregarCursores)
*==============================================================================

DEFINE CLASS Formsigreapp AS FormBase

    Height      = 700
    Width       = 1300
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

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise a Pagar / Receber"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigreappBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreappBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarFiltros()
                IF !THIS.CarregarCursores()
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarGrids()
                THIS.LimparCampos()
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
    * ConfigurarCabecalho - Container cinza superior com titulo e 4 botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab, loc_oCmg
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho

        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Labels e CommandGroup: adicionar via caminho explicito (loc_oCab.AddObject)
        *-- e configurar via WITH loc_oCab.<filho> (evita WITH aninhado que causa
        *-- falha de resolucao de propriedades - Erro47/Erro49 pattern).
        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top       = 22
            .Left      = 22
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = ""
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top       = 20
            .Left      = 20
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = ""
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- CommandGroup com 4 botoes (framework frmrelatorio)
        *   Geometria: Top=0, Left=1026, Width=273, Height=80
        *   Buttons Width=65, Height=70, Lefts=5/71/137/203 (incremento 66)
        loc_oCab.AddObject("cmg_4c_Botoes", "CommandGroup")
        loc_oCmg = loc_oCab.cmg_4c_Botoes
        WITH loc_oCmg
            .Top           = 0
            .Left          = 1026
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption         = "Imprimir"
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Caption         = "Sair"
                .WordWrap        = .T.
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
        BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame plano (sem abas) com 1 pagina de filtros
    * Top=85, Height=615 (700-85), Width=1302
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount   = 1
        loc_oPgf.Top         = 85
        loc_oPgf.Left        = -1
        loc_oPgf.Width       = THIS.Width + 2
        loc_oPgf.Height      = THIS.Height - 85
        loc_oPgf.Tabs        = .F.

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
    * ConfigurarFiltros - Adiciona todos os controles de filtro em Page1
    * Coordenadas: Top_page1 = Top_original - 85
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Tipo de relatorio (Analitico/Sintetico/Fluxo de Caixa)
        loc_oPg1.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg1.lbl_4c_Label2
            .Top       = 20
            .Left      = 64
            .Width     = 35
            .Height    = 15
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("obj_4c_Opt_AnaSi", "OptionGroup")
        WITH loc_oPg1.obj_4c_Opt_AnaSi
            .Top         = 13
            .Left        = 92
            .Width       = 265
            .Height      = 29
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Anal" + CHR(237) + "tico"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Value     = 1
                .Top       = 6
                .Left      = 5
                .Width     = 58
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Sint" + CHR(233) + "tico"
                .Value     = 0
                .Top       = 6
                .Left      = 76
                .Width     = 59
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Fluxo de Caixa"
                .WordWrap        = .T.
                .Top       = 6
                .Left      = 151
                .Width     = 89
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Periodo (DtInicial / DtFinal)
        loc_oPg1.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPg1.lbl_4c_LblPeriodo
            .Top       = 44
            .Left      = 29
            .Width     = 80
            .Height    = 15
            .Caption   = "Vencimento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg1.txt_4c_DtInicial
            .Top           = 40
            .Left          = 98
            .Width         = 80
            .Height        = 24
            .Value         = {}
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg1.lbl_4c_Label3
            .Top       = 45
            .Left      = 183
            .Width     = 18
            .Height    = 15
            .Caption   = "at" + CHR(233)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg1.txt_4c_DtFinal
            .Top           = 40
            .Left          = 208
            .Width         = 80
            .Height        = 24
            .Value         = {}
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Tipo de data (Vencimento/Emissao/Lancamento)
        loc_oPg1.AddObject("obj_4c_OptDatas", "OptionGroup")
        WITH loc_oPg1.obj_4c_OptDatas
            .Top         = 39
            .Left        = 287
            .Width       = 265
            .Height      = 29
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Vencimento"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Value     = 1
                .Top       = 6
                .Left      = 5
                .Width     = 73
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Emiss" + CHR(227) + "o"
                .Value     = 0
                .Top       = 6
                .Left      = 91
                .Width     = 56
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Lan" + CHR(231) + "amento"
                .WordWrap        = .T.
                .Top       = 6
                .Left      = 159
                .Width     = 76
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Saldo Inicial
        loc_oPg1.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPg1.lbl_4c_Label10
            .Top       = 44
            .Left      = 584
            .Width     = 80
            .Height    = 15
            .Caption   = "Saldo Inicial :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Saldo", "TextBox")
        WITH loc_oPg1.txt_4c_Saldo
            .Top           = 40
            .Left          = 652
            .Width         = 148
            .Height        = 24
            .Value         = 0
            .Alignment     = 1
            .Format        = "K"
            .InputMask     = "999999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Saldos (Informado/Data Inicial/Data Atual)
        loc_oPg1.AddObject("obj_4c_OptSaldos", "OptionGroup")
        WITH loc_oPg1.obj_4c_OptSaldos
            .Top         = 40
            .Left        = 798
            .Width       = 265
            .Height      = 29
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Informado"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Value     = 1
                .Top       = 6
                .Left      = 5
                .Width     = 68
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Data Inicial"
                .Value     = 0
                .Top       = 6
                .Left      = 87
                .Width     = 71
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Data Atual"
                .WordWrap        = .T.
                .Top       = 6
                .Left      = 176
                .Width     = 69
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Grupo contabil
        loc_oPg1.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg1.lbl_4c_Label5
            .Top       = 72
            .Left      = 55
            .Width     = 40
            .Height    = 15
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg1.txt_4c_Grupo
            .Top           = 67
            .Left          = 98
            .Width         = 80
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 9
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoKeyPress")

        loc_oPg1.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPg1.txt_4c_DGrupo
            .Top           = 67
            .Left          = 181
            .Width         = 301
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_DGrupo, "When",  THIS, "DGrupoWhen")
        BINDEVENT(loc_oPg1.txt_4c_DGrupo, "KeyPress", THIS, "TxtDGrupoKeyPress")

        *-- Juros
        loc_oPg1.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg1.lbl_4c_Label6
            .Top       = 71
            .Left      = 614
            .Width     = 40
            .Height    = 15
            .Caption   = "Juros :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("obj_4c_Opt_Juros", "OptionGroup")
        WITH loc_oPg1.obj_4c_Opt_Juros
            .Top         = 68
            .Left        = 646
            .Width       = 91
            .Height      = 23
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Value     = 0
                .Top       = 5
                .Left      = 5
                .Width     = 38
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Value     = 1
                .Top       = 5
                .Left      = 48
                .Width     = 38
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPg1.obj_4c_Opt_Juros, "Click", THIS, "JurosOptClick")

        loc_oPg1.AddObject("txt_4c__Juros", "TextBox")
        WITH loc_oPg1.txt_4c__Juros
            .Top           = 67
            .Left          = 749
            .Width         = 51
            .Height        = 24
            .Value         = 0
            .Alignment     = 1
            .Format        = "K"
            .InputMask     = "99.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c__Juros, "When", THIS, "JurosWhen")

        loc_oPg1.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg1.lbl_4c_Label7
            .Top       = 72
            .Left      = 802
            .Width     = 40
            .Height    = 15
            .Caption   = "% m" + CHR(234) + "s"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Pagamentos / Recebimentos
        loc_oPg1.AddObject("chk_4c_Ck_Pagamentos", "CheckBox")
        WITH loc_oPg1.chk_4c_Ck_Pagamentos
            .Top       = 74
            .Left      = 889
            .Width     = 90
            .Height    = 15
            .Caption   = "Pagamentos"
            .Value     = 0
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.chk_4c_Ck_Pagamentos, "InteractiveChange", THIS, "PagamentosChange")

        loc_oPg1.AddObject("chk_4c_Ck_Recebimentos", "CheckBox")
        WITH loc_oPg1.chk_4c_Ck_Recebimentos
            .Top       = 97
            .Left      = 889
            .Width     = 100
            .Height    = 15
            .Caption   = "Recebimentos"
            .Value     = 0
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.chk_4c_Ck_Recebimentos, "InteractiveChange", THIS, "RecebimentosChange")

        *-- Conta contabil
        loc_oPg1.AddObject("lbl_4c_Lbl_estoque", "Label")
        WITH loc_oPg1.lbl_4c_Lbl_estoque
            .Top       = 99
            .Left      = 55
            .Width     = 40
            .Height    = 15
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg1.txt_4c_Conta
            .Top           = 94
            .Left          = 98
            .Width         = 80
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 9
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Conta, "KeyPress", THIS, "TxtContaKeyPress")

        loc_oPg1.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPg1.txt_4c_DConta
            .Top           = 94
            .Left          = 181
            .Width         = 301
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_DConta, "When",  THIS, "DContaWhen")
        BINDEVENT(loc_oPg1.txt_4c_DConta, "KeyPress", THIS, "TxtDContaKeyPress")

        *-- Moeda
        loc_oPg1.AddObject("lbl_4c_Lbl_fator", "Label")
        WITH loc_oPg1.lbl_4c_Lbl_fator
            .Top       = 98
            .Left      = 608
            .Width     = 50
            .Height    = 15
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH loc_oPg1.txt_4c__cd_moeda
            .Top           = 94
            .Left          = 652
            .Width         = 31
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 9
            .ForeColor     = RGB(0, 0, 0)
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c__cd_moeda, "KeyPress",   THIS, "TxtMoedaCdKeyPress")

        loc_oPg1.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH loc_oPg1.txt_4c__ds_moeda
            .Top           = 94
            .Left          = 685
            .Width         = 115
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c__ds_moeda, "When",      THIS, "MoedaDsWhen")
        BINDEVENT(loc_oPg1.txt_4c__ds_moeda, "KeyPress",   THIS, "TxtMoedaDsKeyPress")

        *-- Job (centro de custo)
        loc_oPg1.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPg1.lbl_4c_Label11
            .Top       = 125
            .Left      = 67
            .Width     = 30
            .Height    = 15
            .Caption   = "Job :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c__Jobs", "TextBox")
        WITH loc_oPg1.txt_4c__Jobs
            .Top           = 120
            .Left          = 98
            .Width         = 80
            .Height        = 24
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Margin        = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c__Jobs, "KeyPress", THIS, "TxtJobsKeyPress")

        loc_oPg1.AddObject("txt_4c_DJobs", "TextBox")
        WITH loc_oPg1.txt_4c_DJobs
            .Top           = 120
            .Left          = 181
            .Width         = 301
            .Height        = 24
            .Value         = ""
            .MaxLength     = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Margin        = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_DJobs, "When",  THIS, "DJobsWhen")
        BINDEVENT(loc_oPg1.txt_4c_DJobs, "KeyPress", THIS, "TxtDJobsKeyPress")

        *-- Numero da operacao
        loc_oPg1.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPg1.lbl_4c_Label9
            .Top       = 125
            .Left      = 607
            .Width     = 50
            .Height    = 15
            .Caption   = "C" + CHR(243) + "digo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c__Numes", "TextBox")
        WITH loc_oPg1.txt_4c__Numes
            .Top           = 121
            .Left          = 653
            .Width         = 80
            .Height        = 24
            .Value         = 0
            .Format        = "K"
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Autorizados
        loc_oPg1.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPg1.lbl_4c_Label12
            .Top       = 150
            .Left      = 27
            .Width     = 70
            .Height    = 15
            .Caption   = "Autoriza" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("obj_4c_OptAutorizados", "OptionGroup")
        WITH loc_oPg1.obj_4c_OptAutorizados
            .Top         = 145
            .Left        = 92
            .Width       = 310
            .Height      = 27
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Todos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 5
                .Left      = 5
                .Width     = 56
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Autorizados"
                .Top       = 6
                .Left      = 63
                .Width     = 75
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "N" + CHR(227) + "o Autorizados"
                .WordWrap        = .T.
                .Top       = 6
                .Left      = 154
                .Width     = 97
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursores - Carrega cursores SQL necessarios para grids e BO
    * Deve ser chamado ANTES de ConfigurarGrids (grids referenciam cursores)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCursores()
        LOCAL loc_nRes, loc_lSucesso, loc_lContinuar, loc_cMoeda, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            CREATE CURSOR cursor_4c_SigCdCot (CMoes c(3), Datas d, Valos n(15,6))
            CREATE CURSOR cursor_4c_SigCdMoe (CMoes c(3), DMoes c(40))
            INDEX ON CMoes TAG CMoes
            CREATE CURSOR cursor_4c_SigCdEmp (Imps n(1), cEmps c(3), Razas c(80))
            INDEX ON cEmps TAG cEmps
            CREATE CURSOR cursor_4c_SigOpOpe (Imps n(1), Dopes c(20), Opers c(2), RealPrevs n(2))
            INDEX ON Dopes TAG Dopes
            CREATE CURSOR cursor_4c_SigCdClc (Imps n(1), Codigos c(10), Descs c(60))
            RETURN .T.
        ENDIF

        TRY
            *-- Cotacoes de moeda (indexado para BuscarCambio no BO)
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT CMoes, Datas, Valos FROM SigCdCot ORDER BY CMoes, Datas", ;
                    "cursor_4c_SigCdCot")
                IF loc_nRes > 0
                    SELECT cursor_4c_SigCdCot
                    INDEX ON CMoes + DTOS(Datas) TAG CMoeData
                ENDIF
            ENDIF

            *-- Moedas (indexado para lookup de descricao)
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
                    "cursor_4c_SigCdMoe")
                IF loc_nRes > 0
                    SELECT cursor_4c_SigCdMoe
                    INDEX ON CMoes TAG CMoes
                ENDIF
            ENDIF

            *-- Empresas
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT 1 as Imps, cEmps, Razas FROM SigCdEmp ORDER BY cEmps", ;
                    "cursor_4c_SigCdEmp")
                IF loc_nRes < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdEmp)", "Erro")
                    loc_lContinuar = .F.
                ELSE
                    SELECT cursor_4c_SigCdEmp
                    INDEX ON cEmps TAG cEmps
                ENDIF
            ENDIF

            *-- Operacoes de Titulo (inclui linha em branco para exibir opcao "nenhuma")
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT 1 as Imps, Dopes, Opers, RealPrevs FROM SigOpOpe ORDER BY Dopes", ;
                    "cursor_4c_SigOpOpe")
                IF loc_nRes < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigOpOpe)", "Erro")
                    loc_lContinuar = .F.
                ELSE
                    INSERT INTO cursor_4c_SigOpOpe (Imps, Dopes, Opers) ;
                        VALUES (0, SPACE(20), "C")
                    GO TOP IN cursor_4c_SigOpOpe
                    SELECT cursor_4c_SigOpOpe
                    INDEX ON Dopes TAG Dopes
                ENDIF
            ENDIF

            *-- Classificacoes (SigCdClc, inclui linha EM BRANCO marcada)
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT 1 as Imps, Codigos, Descs FROM SigCdClc ORDER BY Codigos", ;
                    "cursor_4c_SigCdClc")
                IF loc_nRes < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdClc)", "Erro")
                    loc_lContinuar = .F.
                ELSE
                    INSERT INTO cursor_4c_SigCdClc (Imps, Codigos, Descs) ;
                        VALUES (1, SPACE(10), "EM BRANCO")
                    GO TOP IN cursor_4c_SigCdClc
                ENDIF
            ENDIF

            *-- Moeda padrao (SigCdPam)
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, "SELECT Moedaps FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF loc_nRes > 0 AND !EOF("cursor_4c_SigCdPam") AND ;
                   !EMPTY(cursor_4c_SigCdPam.Moedaps)
                    loc_cMoeda = ALLTRIM(cursor_4c_SigCdPam.Moedaps)
                    THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = loc_cMoeda
                    IF SEEK(loc_cMoeda, "cursor_4c_SigCdMoe", "CMoes")
                        THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ;
                            ALLTRIM(cursor_4c_SigCdMoe.DMoes)
                    ENDIF
                    IF VARTYPE(THIS.this_oRelatorio) = "O"
                        LOCAL loc_nCotacao
                        loc_nCotacao = THIS.this_oRelatorio.BuscarCambio(loc_cMoeda)
                        THIS.this_oRelatorio.this_nVlCotacao = ;
                            IIF(loc_nCotacao = 0, 1, loc_nCotacao)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
            ENDIF

            IF loc_lContinuar
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao Carregar Dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarGrids - Cria os tres grids apos cursores ja carregados
    * grd_4c_Emps (Empresas), grd_4c_Tipo (Operacoes), grd_4c_Cla (Classificacoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrids()
        LOCAL loc_oPg1, loc_oGrd
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *======================================================================
        *-- GRID EMPRESAS
        *======================================================================
        loc_oPg1.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg1.lbl_4c_Label1
            .Top       = 181
            .Left      = 24
            .Width     = 60
            .Height    = 15
            .Caption   = "Empresas"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("chk_4c_Ck_MarcaEmp", "CheckBox")
        WITH loc_oPg1.chk_4c_Ck_MarcaEmp
            .Top       = 198
            .Left      = 25
            .Width     = 13
            .Height    = 16
            .Caption   = ""
            .Value     = 1
            .Alignment = 0
            .Centered  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaEmp, "Click", THIS, "MarcaEmpClick")

        loc_oPg1.AddObject("grd_4c_Emps", "Grid")
        loc_oGrd = loc_oPg1.grd_4c_Emps
        WITH loc_oGrd
            .Top               = 197
            .Left              = 24
            .Width             = 331
            .Height            = 394
            .ColumnCount       = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = .F.
            .RecordSource      = "cursor_4c_SigCdEmp"
            .Visible           = .T.
        ENDWITH
        loc_oGrd.Column1.ControlSource = "cursor_4c_SigCdEmp.Imps"
        loc_oGrd.Column2.ControlSource = "cursor_4c_SigCdEmp.cEmps"
        loc_oGrd.Column3.ControlSource = "cursor_4c_SigCdEmp.Razas"

        WITH loc_oGrd.Column1
            .Width         = 17
            .ControlSource = "cursor_4c_SigCdEmp.Imps"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .F.
            .Sparse        = .F.
        ENDWITH
        loc_oGrd.Column1.Header1.Caption  = ""
        loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column1.AddObject("Check1", "CheckBox")
        WITH loc_oGrd.Column1.Check1
            .Alignment = 0
            .Caption   = ""
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "Check1"
        BINDEVENT(loc_oGrd.Column1.Check1, "MouseDown", THIS, "EmpCheckMouseDown")
        BINDEVENT(loc_oGrd.Column1.Check1, "MouseUp",   THIS, "EmpCheckMouseUp")
        BINDEVENT(loc_oGrd.Column1.Check1, "Click",     THIS, "EmpCheckClick")
        BINDEVENT(loc_oGrd.Column1.Check1, "KeyPress",  THIS, "EmpCheckKeyPress")

        WITH loc_oGrd.Column2
            .Width         = 27
            .ControlSource = "cursor_4c_SigCdEmp.cEmps"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
        ENDWITH
        loc_oGrd.Column2.Header1.Caption   = "Emp."
        loc_oGrd.Column2.Header1.Alignment = 2
        loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)

        WITH loc_oGrd.Column3
            .Width         = 263
            .ControlSource = "cursor_4c_SigCdEmp.Razas"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
        ENDWITH
        loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column3.Header1.Alignment = 2
        loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)

        *======================================================================
        *-- GRID OPERACOES DE TITULO
        *======================================================================
        loc_oPg1.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg1.lbl_4c_Label4
            .Top       = 181
            .Left      = 369
            .Width     = 120
            .Height    = 15
            .Caption   = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulo"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("chk_4c_Ck_MarcaOpe", "CheckBox")
        WITH loc_oPg1.chk_4c_Ck_MarcaOpe
            .Top       = 198
            .Left      = 371
            .Width     = 13
            .Height    = 16
            .Caption   = ""
            .Value     = 1
            .Alignment = 0
            .Centered  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaOpe, "Click", THIS, "MarcaOpeClick")

        loc_oPg1.AddObject("grd_4c_Tipo", "Grid")
        loc_oGrd = loc_oPg1.grd_4c_Tipo
        WITH loc_oGrd
            .Top               = 197
            .Left              = 369
            .Width             = 323
            .Height            = 394
            .ColumnCount       = 2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 17
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = .F.
            .RecordSource      = "cursor_4c_SigOpOpe"
            .Visible           = .T.
        ENDWITH
        loc_oGrd.Column1.ControlSource = "cursor_4c_SigOpOpe.Imps"
        loc_oGrd.Column2.ControlSource = "cursor_4c_SigOpOpe.Dopes"

        WITH loc_oGrd.Column1
            .Width         = 17
            .ControlSource = "cursor_4c_SigOpOpe.Imps"
            .Alignment     = 0
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .F.
            .Sparse        = .F.
            .Enabled       = .T.
        ENDWITH
        loc_oGrd.Column1.Header1.Caption  = ""
        loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column1.AddObject("check12", "CheckBox")
        WITH loc_oGrd.Column1.check12
            .Alignment = 0
            .Caption   = ""
            .AutoSize  = .T.
            .BackStyle = 0
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "check12"
        BINDEVENT(loc_oGrd.Column1.check12, "MouseDown", THIS, "TipoCheckMouseDown")
        BINDEVENT(loc_oGrd.Column1.check12, "MouseUp",   THIS, "TipoCheckMouseUp")
        BINDEVENT(loc_oGrd.Column1.check12, "Click",     THIS, "TipoCheckClick")
        BINDEVENT(loc_oGrd.Column1.check12, "KeyPress",  THIS, "TipoCheckKeyPress")

        WITH loc_oGrd.Column2
            .Width         = 283
            .ControlSource = "cursor_4c_SigOpOpe.Dopes"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
            .Enabled       = .T.
        ENDWITH
        loc_oGrd.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column2.Header1.Alignment = 2
        loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
        loc_oGrd.Column2.Text1.BackColor   = RGB(255, 255, 255)
        loc_oGrd.Column2.Text1.ReadOnly    = .T.

        *======================================================================
        *-- GRID CLASSIFICACOES
        *======================================================================
        loc_oPg1.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPg1.lbl_4c_Label8
            .Top       = 180
            .Left      = 706
            .Width     = 95
            .Height    = 15
            .Caption   = "Classifica" + CHR(231) + CHR(245) + "es"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("chk_4c_Ck_MarcaCla", "CheckBox")
        WITH loc_oPg1.chk_4c_Ck_MarcaCla
            .Top       = 198
            .Left      = 708
            .Width     = 13
            .Height    = 16
            .Caption   = ""
            .Value     = 1
            .Alignment = 0
            .Centered  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaCla, "Click", THIS, "MarcaClaClick")

        loc_oPg1.AddObject("grd_4c_Cla", "Grid")
        loc_oGrd = loc_oPg1.grd_4c_Cla
        WITH loc_oGrd
            .Top               = 197
            .Left              = 706
            .Width             = 574
            .Height            = 394
            .ColumnCount       = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = .F.
            .RecordSource      = "cursor_4c_SigCdClc"
            .Visible           = .T.
        ENDWITH
        loc_oGrd.Column1.ControlSource = "cursor_4c_SigCdClc.Imps"
        loc_oGrd.Column2.ControlSource = "cursor_4c_SigCdClc.Codigos"
        loc_oGrd.Column3.ControlSource = "cursor_4c_SigCdClc.Descs"

        WITH loc_oGrd.Column1
            .Width         = 19
            .ControlSource = "cursor_4c_SigCdClc.Imps"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .F.
            .Sparse        = .F.
        ENDWITH
        loc_oGrd.Column1.Header1.Caption  = ""
        loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column1.AddObject("check13", "CheckBox")
        WITH loc_oGrd.Column1.check13
            .Alignment = 0
            .Caption   = ""
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "check13"
        BINDEVENT(loc_oGrd.Column1.check13, "MouseDown", THIS, "ClaCheckMouseDown")
        BINDEVENT(loc_oGrd.Column1.check13, "MouseUp",   THIS, "ClaCheckMouseUp")
        BINDEVENT(loc_oGrd.Column1.check13, "Click",     THIS, "ClaCheckClick")
        BINDEVENT(loc_oGrd.Column1.check13, "KeyPress",  THIS, "ClaCheckKeyPress")

        WITH loc_oGrd.Column2
            .Width         = 80
            .ControlSource = "cursor_4c_SigCdClc.Codigos"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
        ENDWITH
        loc_oGrd.Column2.Header1.Caption   = "C" + CHR(243) + "digo"
        loc_oGrd.Column2.Header1.Alignment = 2
        loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
        loc_oGrd.Column2.Text1.ReadOnly    = .F.

        WITH loc_oGrd.Column3
            .Width         = 452
            .ControlSource = "cursor_4c_SigCdClc.Descs"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
        ENDWITH
        loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column3.Header1.Alignment = 2
        loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
        loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)
        loc_oGrd.Column3.Text1.ReadOnly    = .T.

    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Report form: sem estado CRUD, ajusta botoes
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta todos os filtros para valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg1.txt_4c_DtInicial.Value          = DATE()
        loc_oPg1.txt_4c_DtFinal.Value            = DATE()
        loc_oPg1.txt_4c__Numes.Value             = 0
        loc_oPg1.txt_4c_Saldo.Value              = 0
        loc_oPg1.txt_4c__Juros.Value             = 0
        loc_oPg1.txt_4c_Grupo.Value              = ""
        loc_oPg1.txt_4c_DGrupo.Value             = ""
        loc_oPg1.txt_4c_Conta.Value              = ""
        loc_oPg1.txt_4c_DConta.Value             = ""
        loc_oPg1.txt_4c__Jobs.Value              = ""
        loc_oPg1.txt_4c_DJobs.Value              = ""
        loc_oPg1.obj_4c_Opt_AnaSi.Value          = 1
        loc_oPg1.obj_4c_OptDatas.Value           = 1
        loc_oPg1.obj_4c_OptSaldos.Value          = 1
        loc_oPg1.obj_4c_OptAutorizados.Value     = 1
        loc_oPg1.obj_4c_Opt_Juros.Value          = 2
        loc_oPg1.chk_4c_Ck_Pagamentos.Value     = 0
        loc_oPg1.chk_4c_Ck_Recebimentos.Value   = 0
        THIS.HabObjs(.F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabObjs - Habilita/desabilita controles conforme modo PagRec
    * par_lPagRec: .T. = modo pagamento/recebimento, .F. = modo normal
    *--------------------------------------------------------------------------
    PROCEDURE HabObjs(par_lPagRec)
        LOCAL loc_oPg1, loc_cLabel
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cLabel = IIF(loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1, ;
            "Pagamento:", "Recebimento:")
        loc_oPg1.txt_4c__Numes.Enabled     = par_lPagRec
        loc_oPg1.obj_4c_Opt_AnaSi.Enabled  = !par_lPagRec
        loc_oPg1.lbl_4c_LblPeriodo.Caption = IIF(par_lPagRec, loc_cLabel, "Vencimento :")
        loc_oPg1.obj_4c_Opt_Juros.Enabled  = !par_lPagRec
        loc_oPg1.txt_4c__Juros.Enabled     = !par_lPagRec
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores do formulario para o BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg1, loc_oBO
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oBO  = THIS.this_oRelatorio

        loc_oBO.this_dDtInicial      = loc_oPg1.txt_4c_DtInicial.Value
        loc_oBO.this_dDtFinal        = loc_oPg1.txt_4c_DtFinal.Value
        loc_oBO.this_nOptAnaSi       = loc_oPg1.obj_4c_Opt_AnaSi.Value
        loc_oBO.this_nOptDatas       = loc_oPg1.obj_4c_OptDatas.Value
        loc_oBO.this_nOptSaldos      = loc_oPg1.obj_4c_OptSaldos.Value
        loc_oBO.this_nOptAutorizados = loc_oPg1.obj_4c_OptAutorizados.Value
        loc_oBO.this_nOptJuros       = loc_oPg1.obj_4c_Opt_Juros.Value
        loc_oBO.this_nJuros          = loc_oPg1.txt_4c__Juros.Value
        loc_oBO.this_nSaldo          = loc_oPg1.txt_4c_Saldo.Value
        loc_oBO.this_cGrupo          = PADR(ALLTRIM(loc_oPg1.txt_4c_Grupo.Value), 10)
        loc_oBO.this_cDGrupo         = ALLTRIM(loc_oPg1.txt_4c_DGrupo.Value)
        loc_oBO.this_cConta          = PADR(ALLTRIM(loc_oPg1.txt_4c_Conta.Value), 10)
        loc_oBO.this_cDConta         = ALLTRIM(loc_oPg1.txt_4c_DConta.Value)
        loc_oBO.this_cCdMoeda        = ALLTRIM(loc_oPg1.txt_4c__cd_moeda.Value)
        loc_oBO.this_cDsMoeda        = ALLTRIM(loc_oPg1.txt_4c__ds_moeda.Value)
        loc_oBO.this_cJobs           = PADR(ALLTRIM(loc_oPg1.txt_4c__Jobs.Value), 10)
        loc_oBO.this_cDJobs          = ALLTRIM(loc_oPg1.txt_4c_DJobs.Value)
        loc_oBO.this_nNumes          = loc_oPg1.txt_4c__Numes.Value
        loc_oBO.this_nPagamentos     = loc_oPg1.chk_4c_Ck_Pagamentos.Value
        loc_oBO.this_nRecebimentos   = loc_oPg1.chk_4c_Ck_Recebimentos.Value
    ENDPROC

    *==========================================================================
    * HANDLERS DE BOTOES
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Visualizar()
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Imprimir()
    ENDPROC

    PROCEDURE BtnGerarExcelClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.ExportarExcel()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS CRUD (form REPORT - delegam para acoes equivalentes do relatorio)
    *==========================================================================

    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Imprimir()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
        THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.SetFocus()
    ENDPROC

    *==========================================================================
    * HANDLERS MARCAR/DESMARCAR TODOS (checkboxes acima de cada grid)
    *==========================================================================

    PROCEDURE MarcaEmpClick()
        LOCAL loc_nImps
        loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaEmp.Value = 1, 1, 0)
        REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigCdEmp
        THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
    ENDPROC

    PROCEDURE MarcaOpeClick()
        LOCAL loc_nImps
        loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaOpe.Value = 1, 1, 0)
        REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigOpOpe
        THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
    ENDPROC

    PROCEDURE MarcaClaClick()
        LOCAL loc_nImps
        loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaCla.Value = 1, 1, 0)
        REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigCdClc
        THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
    ENDPROC

    *==========================================================================
    * HANDLERS CHECKBOX DO GRID EMPRESAS
    *==========================================================================

    PROCEDURE EmpCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        LOCAL loc_nImps
        loc_nImps = IIF(cursor_4c_SigCdEmp.Imps = 0, 1, 0)
        REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdEmp
        THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
        NODEFAULT
    ENDPROC

    PROCEDURE EmpCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC

    PROCEDURE EmpCheckClick()
        NODEFAULT
    ENDPROC

    PROCEDURE EmpCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            LOCAL loc_nImps
            loc_nImps = IIF(cursor_4c_SigCdEmp.Imps = 1, 0, 1)
            REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdEmp
            THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS CHECKBOX DO GRID TIPO (OPERACOES)
    *==========================================================================

    PROCEDURE TipoCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        LOCAL loc_nImps
        loc_nImps = IIF(cursor_4c_SigOpOpe.Imps = 0, 1, 0)
        REPLACE Imps WITH loc_nImps IN cursor_4c_SigOpOpe
        THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
        NODEFAULT
    ENDPROC

    PROCEDURE TipoCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC

    PROCEDURE TipoCheckClick()
        NODEFAULT
    ENDPROC

    PROCEDURE TipoCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            LOCAL loc_nImps
            loc_nImps = IIF(cursor_4c_SigOpOpe.Imps = 1, 0, 1)
            REPLACE Imps WITH loc_nImps IN cursor_4c_SigOpOpe
            THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS CHECKBOX DO GRID CLASSIFICACOES
    *==========================================================================

    PROCEDURE ClaCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        LOCAL loc_nImps
        loc_nImps = IIF(cursor_4c_SigCdClc.Imps = 0, 1, 0)
        REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdClc
        THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
        NODEFAULT
    ENDPROC

    PROCEDURE ClaCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC

    PROCEDURE ClaCheckClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ClaCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            LOCAL loc_nImps
            loc_nImps = IIF(cursor_4c_SigCdClc.Imps = 1, 0, 1)
            REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdClc
            THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS MODO PAGREC E JUROS
    *==========================================================================

    PROCEDURE PagamentosChange()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1
            loc_oPg1.chk_4c_Ck_Recebimentos.Value = 0
        ENDIF
        THIS.HabObjs((loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
            (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1))
    ENDPROC

    PROCEDURE RecebimentosChange()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1
            loc_oPg1.chk_4c_Ck_Pagamentos.Value = 0
        ENDIF
        THIS.HabObjs((loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
            (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1))
    ENDPROC

    PROCEDURE JurosOptClick()
        IF THIS.pgf_4c_Paginas.Page1.obj_4c_Opt_Juros.Value = 2
            THIS.pgf_4c_Paginas.Page1.txt_4c__Juros.Value = 0
        ENDIF
    ENDPROC

    FUNCTION JurosWhen()
        RETURN (THIS.pgf_4c_Paginas.Page1.obj_4c_Opt_Juros.Value = 1)
    ENDFUNC

    *==========================================================================
    * LOOKUP MOEDA
    *==========================================================================

    PROCEDURE TxtMoedaCdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor, loc_nRes, loc_nCotacao
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
                THIS.this_oRelatorio.this_nVlCotacao = 1
            ELSE
                IF SEEK(loc_cValor, "cursor_4c_SigCdMoe", "CMoes")
                    THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_SigCdMoe.CMoes)
                    THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_SigCdMoe.DMoes)
                    loc_nCotacao = THIS.this_oRelatorio.BuscarCambio(loc_cValor)
                    THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
                ELSE
                    THIS.AbrirBuscaMoeda()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    FUNCTION MoedaDsWhen()
        RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
    ENDFUNC

    PROCEDURE TxtMoedaDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_oForm, loc_cValor, loc_cMoedaSel, loc_nCotacao
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value)
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", loc_cValor, ;
            "Busca de Moeda")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
            THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
            loc_cMoedaSel = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
            loc_nCotacao  = THIS.this_oRelatorio.BuscarCambio(loc_cMoedaSel)
            THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
                loc_cMoedaSel = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                loc_nCotacao  = THIS.this_oRelatorio.BuscarCambio(loc_cMoedaSel)
                THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
                THIS.this_oRelatorio.this_nVlCotacao = 1
            ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * LOOKUP GRUPO / DGRUPO
    *==========================================================================

    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor, loc_nRes
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
            ELSE
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_ValidaGrupo")
                IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaGrupo")
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_ValidaGrupo.Codigos)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ValidaGrupo.Descrs)
                ELSE
                    THIS.AbrirBuscaGrupo()
                ENDIF
                IF USED("cursor_4c_ValidaGrupo")
                    USE IN cursor_4c_ValidaGrupo
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    FUNCTION DGrupoWhen()
        RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
    ENDFUNC

    PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value = ""
            ELSE
                THIS.AbrirBuscaGrupo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oForm, loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cValor, ;
            "Busca de Grupo Cont" + CHR(225) + "bil")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
            ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * LOOKUP CONTA / DCONTA
    *==========================================================================

    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor, loc_cGrupo, loc_nRes, loc_cSQL
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ""
            ELSE
                loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
                loc_cSQL   = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                    EscaparSQL(PADR(loc_cValor, 10))
                IF !EMPTY(loc_cGrupo)
                    loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaConta")
                IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaConta")
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ValidaConta.IClis)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValidaConta.RClis)
                ELSE
                    THIS.AbrirBuscaConta()
                ENDIF
                IF USED("cursor_4c_ValidaConta")
                    USE IN cursor_4c_ValidaConta
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    FUNCTION DContaWhen()
        RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)
    ENDFUNC

    PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value = ""
            ELSE
                THIS.AbrirBuscaConta()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaConta()
        LOCAL loc_oForm, loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaConta", "IClis", loc_cValor, ;
            "Busca de Conta")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("RClis", "", "Nome")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ""
            ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * LOOKUP JOBS / DJOBS
    *==========================================================================

    PROCEDURE TxtJobsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor, loc_nRes
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ""
            ELSE
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                    EscaparSQL(PADR(loc_cValor, 10)), ;
                    "cursor_4c_ValidaJobs")
                IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaJobs")
                    THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_ValidaJobs.IClis)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_ValidaJobs.RClis)
                ELSE
                    THIS.AbrirBuscaJobs()
                ENDIF
                IF USED("cursor_4c_ValidaJobs")
                    USE IN cursor_4c_ValidaJobs
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    FUNCTION DJobsWhen()
        RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)
    ENDFUNC

    PROCEDURE TxtDJobsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ""
            ELSE
                THIS.AbrirBuscaJobs()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaJobs()
        LOCAL loc_oForm, loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaJobs", "IClis", loc_cValor, ;
            "Busca de Job")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_BuscaJobs.IClis)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_BuscaJobs.RClis)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("RClis", "", "Nome")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_BuscaJobs.IClis)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_BuscaJobs.RClis)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ""
            ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaJobs")
            USE IN cursor_4c_BuscaJobs
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura conteudo de Page1 (grids de selecao)
    * Em forms REPORT, Page1 hospeda os filtros e os 3 grids de selecao
    * (Empresas, Operacoes, Classificacoes). Esta procedure encapsula a
    * configuracao desses grids, delegando para ConfigurarGrids().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        THIS.ConfigurarGrids()
        loc_oPg1.grd_4c_Emps.Visible    = .T.
        loc_oPg1.grd_4c_Tipo.Visible    = .T.
        loc_oPg1.grd_4c_Cla.Visible     = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura conteudo de pagina de dados
    * Em forms REPORT (frmrelatorio) NAO existe Page2 (Dados): todos os
    * filtros estao em Page1 e ja foram configurados por ConfigurarFiltros().
    * Este metodo existe para manter compatibilidade com a API de forms CRUD
    * e satisfaz validacoes do pipeline de migracao multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Form REPORT usa layout FLAT com apenas Page1 contendo todos os filtros.
        *-- Os campos de filtro sao adicionados em ConfigurarFiltros() que ja foi
        *-- chamado durante InicializarForm(). Portanto nao ha controles adicionais
        *-- a configurar nesta pagina.
        IF THIS.pgf_4c_Paginas.PageCount >= 1
            THIS.pgf_4c_Paginas.Page1.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Define a pagina ativa do PageFrame
    * Em forms REPORT este form usa uma unica pagina (Page1) que contem
    * todos os filtros e grids. Mantido por compatibilidade com a API de
    * forms de cadastro.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
        IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
            loc_nPagina = 1
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
        THIS.pgf_4c_Paginas.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Para forms REPORT: equivale a Visualizar (preview)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Visualizar()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Para forms REPORT: equivale a Imprimir
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Imprimir()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Para forms REPORT: delega para FormParaRelatorio
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Para forms REPORT: grids ja carregados em CarregarCursores
    * Filtros de tela nao precisam ser recarregados a partir do BO.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita todos os filtros; aplica regra PagRec via HabObjs
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_oPg1, loc_lPagRec
        loc_oPg1    = THIS.pgf_4c_Paginas.Page1
        loc_lPagRec = (loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
                      (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1)
        loc_oPg1.txt_4c_DtInicial.Enabled         = .T.
        loc_oPg1.txt_4c_DtFinal.Enabled           = .T.
        loc_oPg1.txt_4c_Saldo.Enabled             = .T.
        loc_oPg1.txt_4c_Grupo.Enabled             = .T.
        loc_oPg1.txt_4c_DGrupo.Enabled            = .T.
        loc_oPg1.txt_4c_Conta.Enabled             = .T.
        loc_oPg1.txt_4c_DConta.Enabled            = .T.
        loc_oPg1.txt_4c__cd_moeda.Enabled         = .T.
        loc_oPg1.txt_4c__ds_moeda.Enabled         = .T.
        loc_oPg1.txt_4c__Jobs.Enabled             = .T.
        loc_oPg1.txt_4c_DJobs.Enabled             = .T.
        loc_oPg1.obj_4c_OptDatas.Enabled          = .T.
        loc_oPg1.obj_4c_OptSaldos.Enabled         = .T.
        loc_oPg1.obj_4c_OptAutorizados.Enabled    = .T.
        loc_oPg1.chk_4c_Ck_Pagamentos.Enabled    = .T.
        loc_oPg1.chk_4c_Ck_Recebimentos.Enabled  = .T.
        THIS.HabObjs(loc_lPagRec)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Para forms REPORT: cursores ja carregados em CarregarCursores
    * Retorna .T. para compatibilidade com o ciclo de vida do FormBase
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Para forms REPORT: botoes sempre habilitados
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
            WITH THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = .T.
                .Buttons(3).Enabled = .T.
                .Buttons(4).Enabled = .T.
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO e cursores da sessao privada
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
