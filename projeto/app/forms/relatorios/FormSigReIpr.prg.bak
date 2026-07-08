*==============================================================================
* FORMSIGREIPR.PRG
* Relat" + CHR(243) + "rio de Mailing
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREIPR.SCX (frmrelatorio)
* Tarefa: task129
*
* Filtros:
*   - Sele" + CHR(231) + CHR(227) + "o de Mailing (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigMlItn)
*   - Incluir Campos: Endere" + CHR(231) + "os, Telefones, Datas Comemorativas,
*                     Classifica" + CHR(231) + CHR(227) + "o, Representante
*   - Ordem de Impress" + CHR(227) + "o (Alfab" + CHR(233) + "tica/CEP/Nascimento/Casamento/NascConj/Comem)
*   - Dire" + CHR(231) + CHR(227) + "o da Ordem (Descendente/Ascendente)
*==============================================================================

DEFINE CLASS FormSigReIpr AS FormBase

    Height      = 300
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

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Mailing"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SigReIprBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReIprBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
            ELSE
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

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
                .Caption   = "Relat" + CHR(243) + "rio de Mailing"
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
                .Caption   = "Relat" + CHR(243) + "rio de Mailing"
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
    * ConfigurarBotoes - CommandGroup com 4 botoes do relatorio
    *   Original: btnReport.Top=-2, Left=287, Width=313, Height=85
    *   Botoes: Visualiza(5), Imprime(81), DocExcel(157), Sair(233) - W=75 cada
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

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   Form de RELATORIO usa layout FLAT: 1 pagina de filtros, sem CRUD.
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
    * ConfigurarPaginaLista - Adiciona campos de filtro na Page1
    *   Posicoes originais SIGREIPR (596x292px) adaptadas para PageFrame:
    *     top original - 85 (offset do PageFrame) = top na Page
    *     Selecao:  top=35 | Incluir Campos: top=63,83 | Ordem: top=105
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Sele??o :"
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Top       = 38
            .Left      = 94
            .Width     = 52
            .Height    = 15
            .Caption   = "Sele" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox c?digo do mailing (Get_codigo -> txt_4c_Codigo)
        loc_oPg.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPg.txt_4c_Codigo
            .Top           = 35
            .Left          = 152
            .Width         = 77
            .Height        = 23
            .Value         = ""
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(36, 84, 155)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- TextBox descri??o do mailing (Get_desc -> txt_4c_Desc)
        loc_oPg.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPg.txt_4c_Desc
            .Top           = 35
            .Left          = 231
            .Width         = 316
            .Height        = 23
            .Value         = ""
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(36, 84, 155)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label "Incluir Campos :"
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Top       = 63
            .Left      = 61
            .Width     = 82
            .Height    = 15
            .Caption   = "Incluir Campos :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- CheckBox Endere?os
        loc_oPg.AddObject("chk_4c_ChkEnderecos", "CheckBox")
        WITH loc_oPg.chk_4c_ChkEnderecos
            .Top           = 148
            .Left          = 154
            .Width         = 80
            .Height        = 15
            .Caption       = "Endere" + CHR(231) + "os"
            .Value         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Telefones
        loc_oPg.AddObject("chk_4c_ChkTelefones", "CheckBox")
        WITH loc_oPg.chk_4c_ChkTelefones
            .Top           = 148
            .Left          = 261
            .Width         = 80
            .Height        = 15
            .Caption       = "Telefones"
            .Value         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Datas Comemorativas
        loc_oPg.AddObject("chk_4c_ChkDtCom", "CheckBox")
        WITH loc_oPg.chk_4c_ChkDtCom
            .Top           = 148
            .Left          = 365
            .Width         = 130
            .Height        = 15
            .Caption       = "Datas Comemorativas"
            .Value         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Classifica??o
        loc_oPg.AddObject("chk_4c_ChkClassif", "CheckBox")
        WITH loc_oPg.chk_4c_ChkClassif
            .Top           = 168
            .Left          = 154
            .Width         = 90
            .Height        = 15
            .Caption       = "Classifica" + CHR(231) + CHR(227) + "o"
            .Value         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- CheckBox Representante
        loc_oPg.AddObject("chk_4c_ChkRepres", "CheckBox")
        WITH loc_oPg.chk_4c_ChkRepres
            .Top           = 168
            .Left          = 261
            .Width         = 100
            .Height        = 15
            .Caption       = "Representante"
            .Value         = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona OptionGroups e BINDEVENTs na Page1
    *   Em forms CRUD seria a Page2 de edicao. Aqui contem as opcoes de
    *   ordenacao e os BINDEVENTs dos campos de lookup.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Ordem da Impress?o :"
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Top       = 105
            .Left      = 31
            .Width     = 115
            .Height    = 15
            .Caption   = "Ordem da Impress" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Ordem de Impress?o (6 op??es)
        *   Original: Option.Top=190, Left=154, Width=283, Height=58, Value=2(CEP)
        loc_oPg.AddObject("opt_4c_Option", "OptionGroup")
        loc_oPg.opt_4c_Option.ButtonCount = 6
        WITH loc_oPg.opt_4c_Option
            .Top           = 190
            .Left          = 154
            .Width         = 283
            .Height        = 58
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_Option.Buttons(1)
            .Caption   = "Alfab" + CHR(233) + "tica"
            .Left      = 5
            .Top       = 21
            .Width     = 66
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Option.Buttons(2)
            .Caption   = "CEP"
            .Left      = 5
            .Top       = 4
            .Width     = 37
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Option.Buttons(3)
            .Caption   = "Data de Nascimento"
            .WordWrap        = .T.
            .Left      = 5
            .Top       = 40
            .Width     = 114
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Option.Buttons(4)
            .Caption   = "Data de Casamento"
            .WordWrap        = .T.
            .Left      = 143
            .Top       = 4
            .Width     = 113
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Option.Buttons(5)
            .Caption   = "Nascimento C" + CHR(244) + "njuge"
            .Left      = 143
            .Top       = 21
            .Width     = 116
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Option.Buttons(6)
            .Caption   = "Data Comemorativa"
            .Left      = 143
            .Top       = 40
            .Width     = 113
            .Height    = 15
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_Option.Value = 2

        *-- OptionGroup Dire??o da Ordem (Descendente / Ascendente)
        *   Original: OpOrdem.Top=190, Left=445, Width=102, Height=58, Value=2(Asc)
        loc_oPg.AddObject("opt_4c_OpOrdem", "OptionGroup")
        loc_oPg.opt_4c_OpOrdem.ButtonCount = 2
        WITH loc_oPg.opt_4c_OpOrdem
            .Top           = 190
            .Left          = 445
            .Width         = 106
            .Height        = 58
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_OpOrdem.Buttons(1)
            .Caption   = "Descendente"
            .Left      = 5
            .Top       = 10
            .Width     = 91
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_OpOrdem.Buttons(2)
            .Caption   = "Ascendente"
            .Left      = 5
            .Top       = 32
            .Width     = 91
            .Height    = 17
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_OpOrdem.Value = 2

        *-- Vincular KeyPress nos campos com lookup (F4=115, ENTER=13, TAB=9)
        BINDEVENT(loc_oPg.txt_4c_Codigo, "KeyPress", THIS, "TeclaCodigo")
        BINDEVENT(loc_oPg.txt_4c_Desc,   "KeyPress", THIS, "TeclaDesc")

        *-- DblClick tamb?m abre lookup
        BINDEVENT(loc_oPg.txt_4c_Codigo, "DblClick", THIS, "AbrirBuscaCodigo")
        BINDEVENT(loc_oPg.txt_4c_Desc,   "DblClick", THIS, "AbrirBuscaDesc")

        THIS.AtualizarEstadoDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padr?o
    *   Sele??o em branco, todos os campos incluidos, ordem por CEP Ascendente
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Codigo.Value          = ""
            loc_oPg.txt_4c_Desc.Value            = ""
            loc_oPg.chk_4c_ChkEnderecos.Value    = 1
            loc_oPg.chk_4c_ChkTelefones.Value    = 1
            loc_oPg.chk_4c_ChkDtCom.Value        = 1
            loc_oPg.chk_4c_ChkClassif.Value      = 1
            loc_oPg.chk_4c_ChkRepres.Value       = 1
            loc_oPg.opt_4c_Option.Value          = 2
            loc_oPg.opt_4c_OpOrdem.Value         = 2
            THIS.AtualizarEstadoDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoDescricao - Simula o "When" original de Get_desc
    *   Get_desc.When: Return Empty(ThisForm.Get_codigo.Value)
    *   Campo de descri??o s? ? edit?vel quando c?digo est? vazio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoDescricao()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Desc.ReadOnly = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Codigo.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cCodigos        = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
            .this_cDescs          = ALLTRIM(loc_oPg.txt_4c_Desc.Value)
            .this_nImpEnderecos   = loc_oPg.chk_4c_ChkEnderecos.Value
            .this_nImpTelefones   = loc_oPg.chk_4c_ChkTelefones.Value
            .this_nImpDtCom       = loc_oPg.chk_4c_ChkDtCom.Value
            .this_nImpClassif     = loc_oPg.chk_4c_ChkClassif.Value
            .this_nImpRepres      = loc_oPg.chk_4c_ChkRepres.Value
            .this_nOrdemImpressao = loc_oPg.opt_4c_Option.Value
            .this_nOrdemDirecao   = loc_oPg.opt_4c_OpOrdem.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Reposiciona foco no campo de c?digo
    *   Form de relatorio tem s? 1 p?gina; alterna foco para o primeiro filtro.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oPgf, loc_oPg
        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) != "O"
                RETURN
            ENDIF
            loc_oPgf.ActivePage = 1
            loc_oPg = loc_oPgf.Pages(1)
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
                loc_oPg.txt_4c_Codigo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela
    *   Original: visualizacao() -> Report Form SigMlda Preview NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lPode
        loc_lPode = .F.
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.PrepararDados()
                loc_lPode = .T.
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
            IF loc_lPode
                REPORT FORM (THIS.this_oRelatorio.this_cCaminhoFRX) PREVIEW NOCONSOLE
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio na impressora com di?logo
    *   Original: impressao() -> Report Form SigMlda To Printer Prompt NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lPode
        loc_lPode = .F.
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.PrepararDados()
                loc_lPode = .T.
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
            IF loc_lPode
                REPORT FORM (THIS.this_oRelatorio.this_cCaminhoFRX) TO PRINTER PROMPT NOCONSOLE
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do cursor Relacao para arquivo XLS
    *   Original: documento() -> Report Form SigMlda To Printer (sem di?logo)
    *   Novo sistema: exporta para Excel (melhora sobre o original)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_lPode
        loc_cArquivo = ""
        loc_lPode    = .F.
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.PrepararDados()
                IF USED("Relacao") AND RECCOUNT("Relacao") > 0
                    loc_cArquivo = PUTFILE("Salvar como...", "SigReIpr", "XLS")
                    IF !EMPTY(loc_cArquivo)
                        SELECT Relacao
                        COPY TO (loc_cArquivo) TYPE XLS
                        MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
                            loc_cArquivo, "Excel")
                    ENDIF
                ELSE
                    MsgAviso("Nenhum dado encontrado para exportar.", "Excel")
                ENDIF
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - BINDEVENT KeyPress
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    PROCEDURE TeclaCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDesc()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - MAILING (SigMlItn, campos Codigos e Descs)
    * Original: fwbuscaext em Get_codigo.Valid e Get_desc.Valid
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaCodigo - Lookup de mailing pelo c?digo (Codigos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCodigo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigMlItn", "cursor_4c_BuscaMaling", "Codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaMaling.Codigos)
                loc_oPg.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaMaling.Descs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMaling")
                        loc_oPg.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaMaling.Codigos)
                        loc_oPg.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaMaling.Descs)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMaling")
            USE IN cursor_4c_BuscaMaling
        ENDIF
        THIS.AtualizarEstadoDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDesc - Lookup de mailing pela descri??o (Descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDesc()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Desc.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigMlItn", "cursor_4c_BuscaMaling", "Descs", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaMaling.Descs)
                loc_oPg.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaMaling.Codigos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMaling")
                        loc_oPg.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaMaling.Descs)
                        loc_oPg.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaMaling.Codigos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMaling")
            USE IN cursor_4c_BuscaMaling
        ENDIF
        THIS.AtualizarEstadoDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Valida c?digo digitado manualmente e preenche descri??o
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCodigo()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_Desc.Value = ""
            THIS.AtualizarEstadoDescricao()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Codigos, Descs FROM SigMlItn" + ;
                   " WHERE Codigos = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MalVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MalVal
            IF !EOF()
                loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_MalVal.Descs)
            ELSE
                loc_oPg.txt_4c_Desc.Value = ""
                THIS.AbrirBuscaCodigo()
            ENDIF
        ELSE
            loc_oPg.txt_4c_Desc.Value = ""
            THIS.AbrirBuscaCodigo()
        ENDIF
        IF USED("cursor_4c_MalVal")
            USE IN cursor_4c_MalVal
        ENDIF
        THIS.AtualizarEstadoDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDesc - Valida descri??o digitada manualmente e preenche c?digo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDesc()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Desc.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_Codigo.Value = ""
            THIS.AtualizarEstadoDescricao()
            RETURN
        ENDIF
        THIS.AbrirBuscaDesc()
        THIS.AtualizarEstadoDescricao()
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE COM FORMBASE (CRUD -> RELATORIO)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Override: relatorio nao usa operacoes CRUD
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Repositiciona foco no campo de c?digo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
                loc_oPg.txt_4c_Codigo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio para compatibilidade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Restaura filtros a partir das propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_Codigo.Value          = .this_cCodigos
                loc_oPg.txt_4c_Desc.Value            = .this_cDescs
                loc_oPg.chk_4c_ChkEnderecos.Value    = .this_nImpEnderecos
                loc_oPg.chk_4c_ChkTelefones.Value    = .this_nImpTelefones
                loc_oPg.chk_4c_ChkDtCom.Value        = .this_nImpDtCom
                loc_oPg.chk_4c_ChkClassif.Value      = .this_nImpClassif
                loc_oPg.chk_4c_ChkRepres.Value       = .this_nImpRepres
                loc_oPg.opt_4c_Option.Value          = .this_nOrdemImpressao
                loc_oPg.opt_4c_OpOrdem.Value         = .this_nOrdemDirecao
            ENDWITH
            THIS.AtualizarEstadoDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de filtro
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab
        TRY
            IF PCOUNT() = 0
                loc_lHab = .T.
            ELSE
                loc_lHab = par_lHabilitar
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Codigo.Enabled       = loc_lHab
            loc_oPg.chk_4c_ChkEnderecos.Enabled = loc_lHab
            loc_oPg.chk_4c_ChkTelefones.Enabled = loc_lHab
            loc_oPg.chk_4c_ChkDtCom.Enabled     = loc_lHab
            loc_oPg.chk_4c_ChkClassif.Enabled   = loc_lHab
            loc_oPg.chk_4c_ChkRepres.Enabled    = loc_lHab
            loc_oPg.opt_4c_Option.Enabled        = loc_lHab
            loc_oPg.opt_4c_OpOrdem.Enabled       = loc_lHab
            IF loc_lHab
                THIS.AtualizarEstadoDescricao()
            ELSE
                loc_oPg.txt_4c_Desc.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Todos os bot?es sempre habilitados em relatorio
    *--------------------------------------------------------------------------
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
        LOCAL loc_oPg
        TRY
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
                loc_oPg.txt_4c_Codigo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera refer?ncia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
