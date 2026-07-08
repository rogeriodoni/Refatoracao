*==============================================================================
* FORMSIGREINR.PRG
* Relatorio de Inventario - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREINR.SCX (frmrelatorio)
*
* Filtros:
*   - TipoRelatorio: 8 opcoes (Resumido/Analitico/Etiqueta/Ocorrencia/etc.)
*   - TipoAnalitico: Produto/Local/Etiqueta (apenas TipoRel=2)
*   - TipoDiferenca: Todos/Com Diferenca (apenas TipoRel=1)
*   - TipoLeitura: Leitura/Releitura (apenas TipoRel=2)
*   - txt_4c_CodProduto / txt_4c_DsProduto : Busca F4 em SigCdPro
*   - txt_4c_CodLocal / txt_4c_DsLocal     : Busca F4 em SigPrLcl
*   - txt_4c_Barra                         : Codigo de barras (TipoAnal=3)
*   - grd_4c_Operacaos                     : Grid de ocorrencias (TipoRel=4)
*
* Chamado com parametro:
*   DO FORM SIGREINR WITH lnNumBal
*
* Posicoes originais: Width=800, Height=461
* PageFrame.Top=85; posicao em Page1 = Top_original - 85
*==============================================================================

DEFINE CLASS Formsigreinr AS FormBase

    Height      = 461
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
    this_nNumBal       = 0

    *--------------------------------------------------------------------------
    * Init - Armazena parametro, inicializa form via FormBase.Init()
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nNumBal)
        THIS.this_nNumBal = IIF(VARTYPE(par_nNumBal) = "N", par_nNumBal, 0)
        IF !DODEFAULT()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual e carrega dados iniciais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = " Invent" + CHR(225) + "rio n" + CHR(186) + ;
                " " + ALLTRIM(STR(THIS.this_nNumBal))

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigreinrBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreinrBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oRelatorio.InicializarDadosBasicos(THIS.this_nNumBal)
                    THIS.this_cMensagemErro = THIS.this_oRelatorio.ObterMensagemErro()
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
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
    * ConfigurarCabecalho - Container escuro superior com titulo e botoes
    *   cnt_4c_Cabecalho: Top=0, Left=0, Width=800, Height=80
    *   cmg_4c_Botoes: Left=529, Width=271, 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
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

            .AddObject("cmg_4c_Botoes", "CommandGroup")
            WITH .cmg_4c_Botoes
                .Top           = 0
                .Left          = 529
                .Width         = THIS.Width
                .Height        = 80
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderColor   = RGB(136, 189, 188)
                .SpecialEffect = 1
                .Themes        = .F.
                .Visible       = .T.

                WITH .Buttons(1)
                    .Top             = 5
                    .Left            = 5
                    .Width           = THIS.Width
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
                    .Width           = THIS.Width
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
                    .Width           = THIS.Width
                    .Height          = 70
                    .Caption         = "Doc. Excel"
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
                    .ToolTipText     = "Gerar documento para Excel"
                    .Themes          = .F.
                    .Visible         = .T.
                ENDWITH

                WITH .Buttons(4)
                    .Top             = 5
                    .Left            = 203
                    .Width           = THIS.Width
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
        ENDWITH

        loc_oCmg = loc_oCab.cmg_4c_Botoes
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
        BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Form: Width=800, Height=461
    *   Cabecalho Height=80; PageFrame.Top=85, Height=461-85=376, Width=802
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1
        loc_oPgf.Top       = 85
        loc_oPgf.Left      = -1
        loc_oPgf.Width     = THIS.Width + 2
        loc_oPgf.Height    = THIS.Height - 85
        loc_oPgf.Tabs      = .F.

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
    * ConfigurarPaginaLista - Todos os controles de filtro na Page1
    *   Posicoes em Page1 = Top_original - 85 (altura do cabecalho)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrd
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Rotulo "Relatorio :" (Say1: Top=86 -> Page1: 1)
        loc_oPagina.AddObject("lbl_4c_TipoRel", "Label")
        WITH loc_oPagina.lbl_4c_TipoRel
            .Top       = 1
            .Left      = 77
            .Width     = 55
            .Height    = 15
            .Caption   = "Relat" + CHR(243) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoRelatorio (TipoRelat?rio: Top=82 -> Page1: 0)
        *   8 opcoes: Resumido/Analitico/Etiqueta/Ocorrencia/ConsultaEtiqueta/RelacaoComBarra/EstoqueXLeitura/EtiquetaPorEstoque
        loc_oPagina.AddObject("optg_4c_TipoRel", "OptionGroup")
        WITH loc_oPagina.optg_4c_TipoRel
            .AutoSize      = .F.
            .ButtonCount   = 8
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 62
            .Left          = 131
            .SpecialEffect = 1
            .Top           = 0
            .Width         = 370
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "Resumido"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 64
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Anal" + CHR(237) + "tico"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 99
                .Top       = 5
                .Width     = 58
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Etiqueta"
                .WordWrap        = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 224
                .Top       = 5
                .Width     = 58
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Ocorr" + CHR(234) + "ncia"
                .WordWrap        = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 22
                .Width     = 70
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "Consulta Etiqueta"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 99
                .Top       = 22
                .Width     = 103
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(6)
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o c/Barra"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 224
                .Top       = 22
                .Width     = 94
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(7)
                .Caption   = "Estoque x Leitura"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 39
                .Width     = 102
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(8)
                .Caption   = "Etiqueta por Estoque"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 224
                .Top       = 38
                .Width     = 119
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.optg_4c_TipoRel, "InteractiveChange", THIS, "MudouTipoRelatorio")

        *-- Rotulo "Tipo :" (Say4: Top=140 -> Page1: 55)
        loc_oPagina.AddObject("lbl_4c_TipoAnal", "Label")
        WITH loc_oPagina.lbl_4c_TipoAnal
            .Top       = 55
            .Left      = 100
            .Width     = 32
            .Height    = 15
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoAnalitico (Top=135 -> Page1: 50)
        loc_oPagina.AddObject("optg_4c_TipoAnal", "OptionGroup")
        WITH loc_oPagina.optg_4c_TipoAnal
            .AutoSize      = .T.
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 25
            .Left          = 131
            .SpecialEffect = 1
            .Top           = 50
            .Width         = 287
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "Produto"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 56
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Local"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 99
                .Top       = 5
                .Width     = 42
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Etiqueta"
                .WordWrap        = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 224
                .Top       = 5
                .Width     = 58
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.optg_4c_TipoAnal, "InteractiveChange", THIS, "MudouTipoAnalitico")

        *-- Rotulo "Produto :" (lbl_codigo: Top=168 -> Page1: 83)
        loc_oPagina.AddObject("lbl_4c_Produto", "Label")
        WITH loc_oPagina.lbl_4c_Produto
            .Top       = 83
            .Left      = 82
            .Width     = 50
            .Height    = 15
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Produto (get_cd_codigo: Top=163 -> Page1: 78)
        loc_oPagina.AddObject("txt_4c_CodProduto", "TextBox")
        WITH loc_oPagina.txt_4c_CodProduto
            .Top                = 78
            .Left               = 137
            .Width              = 108
            .Height             = 25
            .Value              = ""
            .MaxLength          = 14
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Format             = "!"
            .SpecialEffect      = 1
            .BorderStyle        = 1
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .Enabled            = .F.
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress",  THIS, "TeclaCodProduto")
        BINDEVENT(loc_oPagina.txt_4c_CodProduto, "DblClick",  THIS, "AbrirBuscaCodProduto")
        BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress", THIS, "ValidarCodProduto")

        *-- TextBox Descricao Produto (get_ds_codigo: Top=163 -> Page1: 78)
        loc_oPagina.AddObject("txt_4c_DsProduto", "TextBox")
        WITH loc_oPagina.txt_4c_DsProduto
            .Top                = 78
            .Left               = 247
            .Width              = 290
            .Height             = 25
            .Value              = ""
            .MaxLength          = 40
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Format             = "!"
            .SpecialEffect      = 1
            .BorderStyle        = 1
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .Enabled            = .F.
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsProduto, "KeyPress",  THIS, "TeclaDsProduto")
        BINDEVENT(loc_oPagina.txt_4c_DsProduto, "DblClick",  THIS, "AbrirBuscaDsProduto")
        BINDEVENT(loc_oPagina.txt_4c_DsProduto, "KeyPress", THIS, "ValidarDsProduto")

        *-- Rotulo "Local :" (Say5: Top=195 -> Page1: 110)
        loc_oPagina.AddObject("lbl_4c_Local", "Label")
        WITH loc_oPagina.lbl_4c_Local
            .Top       = 110
            .Left      = 96
            .Width     = 36
            .Height    = 15
            .Caption   = "Local :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Local (Get_Local: Top=190 -> Page1: 105)
        loc_oPagina.AddObject("txt_4c_CodLocal", "TextBox")
        WITH loc_oPagina.txt_4c_CodLocal
            .Top                = 105
            .Left               = 137
            .Width              = 108
            .Height             = 25
            .Value              = ""
            .MaxLength          = 10
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Alignment          = 3
            .SpecialEffect      = 1
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .Enabled            = .F.
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CodLocal, "KeyPress",  THIS, "TeclaCodLocal")
        BINDEVENT(loc_oPagina.txt_4c_CodLocal, "DblClick",  THIS, "AbrirBuscaCodLocal")
        BINDEVENT(loc_oPagina.txt_4c_CodLocal, "KeyPress", THIS, "ValidarCodLocal")

        *-- TextBox Descricao Local (get_Dlocal: Top=190 -> Page1: 105)
        loc_oPagina.AddObject("txt_4c_DsLocal", "TextBox")
        WITH loc_oPagina.txt_4c_DsLocal
            .Top                = 105
            .Left               = 247
            .Width              = 290
            .Height             = 25
            .Value              = ""
            .MaxLength          = 20
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Alignment          = 3
            .SpecialEffect      = 1
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .Enabled            = .F.
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsLocal, "KeyPress",  THIS, "TeclaDsLocal")
        BINDEVENT(loc_oPagina.txt_4c_DsLocal, "DblClick",  THIS, "AbrirBuscaDsLocal")
        BINDEVENT(loc_oPagina.txt_4c_DsLocal, "KeyPress", THIS, "ValidarDsLocal")

        *-- Rotulo "Etiqueta :" (Say8: Top=222 -> Page1: 137)
        loc_oPagina.AddObject("lbl_4c_Etiqueta", "Label")
        WITH loc_oPagina.lbl_4c_Etiqueta
            .Top       = 137
            .Left      = 80
            .Width     = 52
            .Height    = 15
            .Caption   = "Etiqueta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Barra (Get_Barra: Top=217 -> Page1: 132)
        loc_oPagina.AddObject("txt_4c_Barra", "TextBox")
        WITH loc_oPagina.txt_4c_Barra
            .Top                = 132
            .Left               = 137
            .Width              = 108
            .Height             = 25
            .Value              = 0
            .InputMask          = "99999999999999"
            .Format             = "!"
            .FontName           = "Tahoma"
            .FontSize           = 8
            .BorderStyle        = 1
            .SpecialEffect      = 1
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .Enabled            = .F.
            .Visible            = .T.
        ENDWITH

        *-- Rotulo "Itens :" (Say2: Top=249 -> Page1: 164)
        loc_oPagina.AddObject("lbl_4c_Itens", "Label")
        WITH loc_oPagina.lbl_4c_Itens
            .Top       = 164
            .Left      = 95
            .Width     = 37
            .Height    = 15
            .Caption   = "Itens :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoDiferenca (TipoDiferen?a: Top=244 -> Page1: 159)
        loc_oPagina.AddObject("optg_4c_TipoDif", "OptionGroup")
        WITH loc_oPagina.optg_4c_TipoDif
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 25
            .Left          = 131
            .SpecialEffect = 1
            .Top           = 159
            .Width         = 168
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "Todos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 47
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Com Diferen" + CHR(231) + "a"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 75
                .Top       = 5
                .Width     = 88
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Leitura :" (Say3: Top=271 -> Page1: 186)
        loc_oPagina.AddObject("lbl_4c_Leitura", "Label")
        WITH loc_oPagina.lbl_4c_Leitura
            .Top       = 186
            .Left      = 87
            .Width     = 45
            .Height    = 15
            .Caption   = "Leitura :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoLeitura (Top=266 -> Page1: 181)
        loc_oPagina.AddObject("optg_4c_TipoLeitura", "OptionGroup")
        WITH loc_oPagina.optg_4c_TipoLeitura
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 25
            .Left          = 131
            .SpecialEffect = 1
            .Top           = 181
            .Width         = 141
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "Leitura"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 51
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Releitura"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 75
                .Top       = 5
                .Width     = 61
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Preco Custo :" (Say6: Top=294 -> Page1: 209)
        loc_oPagina.AddObject("lbl_4c_TpCusto", "Label")
        WITH loc_oPagina.lbl_4c_TpCusto
            .Top       = 209
            .Left      = 62
            .Width     = 70
            .Height    = 15
            .Caption   = "Pre" + CHR(231) + "o Custo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        *-- OptionGroup TipoCusto (optgTpCusto: Top=288 -> Page1: 203)
        loc_oPagina.AddObject("optg_4c_TpCusto", "OptionGroup")
        WITH loc_oPagina.optg_4c_TpCusto
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 131
            .Top           = 203
            .Width         = 121
            .Visible       = .F.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Preco Venda :" (Say7: Top=319 -> Page1: 234)
        loc_oPagina.AddObject("lbl_4c_TpVenda", "Label")
        WITH loc_oPagina.lbl_4c_TpVenda
            .Top       = 234
            .Left      = 60
            .Width     = 72
            .Height    = 15
            .Caption   = "Pre" + CHR(231) + "o Venda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoVenda (optgTpVenda: Top=313 -> Page1: 228)
        loc_oPagina.AddObject("optg_4c_TpVenda", "OptionGroup")
        WITH loc_oPagina.optg_4c_TpVenda
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 27
            .Left          = 131
            .Top           = 228
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Foto :" (Say9: Top=343 -> Page1: 258)
        loc_oPagina.AddObject("lbl_4c_Foto", "Label")
        WITH loc_oPagina.lbl_4c_Foto
            .Top       = 258
            .Left      = 98
            .Width     = 34
            .Height    = 15
            .Caption   = "Foto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Foto (OptFoto: Top=337 -> Page1: 252)
        loc_oPagina.AddObject("optg_4c_Foto", "OptionGroup")
        WITH loc_oPagina.optg_4c_Foto
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 131
            .Top           = 252
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Etiquetas Faltando :" (Say10: Top=367 -> Page1: 282)
        loc_oPagina.AddObject("lbl_4c_Etiq", "Label")
        WITH loc_oPagina.lbl_4c_Etiq
            .Top       = 282
            .Left      = 30
            .Width     = 102
            .Height    = 15
            .Caption   = "Etiquetas Faltando :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Etiquetas (OptEtiq: Top=361 -> Page1: 276)
        loc_oPagina.AddObject("optg_4c_Etiq", "OptionGroup")
        WITH loc_oPagina.optg_4c_Etiq
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 131
            .Top           = 276
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Mostrar Observacao :" (lblObs: Top=390 -> Page1: 305)
        loc_oPagina.AddObject("lbl_4c_Obs", "Label")
        WITH loc_oPagina.lbl_4c_Obs
            .Top       = 305
            .Left      = 22
            .Width     = 110
            .Height    = 15
            .Caption   = "Mostrar Observa" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Observacao (OptObs: Top=384 -> Page1: 299)
        loc_oPagina.AddObject("optg_4c_Obs", "OptionGroup")
        WITH loc_oPagina.optg_4c_Obs
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 131
            .Top           = 299
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Mostrar Colecao :" (Say12: Top=411 -> Page1: 326)
        loc_oPagina.AddObject("lbl_4c_Colecao", "Label")
        WITH loc_oPagina.lbl_4c_Colecao
            .Top       = 326
            .Left      = 42
            .Width     = 90
            .Height    = 15
            .Caption   = "Mostrar Cole" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Colecao (OptCtg: Top=405 -> Page1: 320)
        loc_oPagina.AddObject("optg_4c_Ctg", "OptionGroup")
        WITH loc_oPagina.optg_4c_Ctg
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 130
            .Top           = 320
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Mostrar Categoria :" (Say13: Top=433 -> Page1: 348)
        loc_oPagina.AddObject("lbl_4c_Ctg", "Label")
        WITH loc_oPagina.lbl_4c_Ctg
            .Top       = 348
            .Left      = 33
            .Width     = 99
            .Height    = 15
            .Caption   = "Mostrar Categoria :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Categoria (OptCol: Top=427 -> Page1: 342)
        loc_oPagina.AddObject("optg_4c_Col", "OptionGroup")
        WITH loc_oPagina.optg_4c_Col
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 130
            .Top           = 342
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Ocorrencias" (Say11: Top=227 -> Page1: 142, Left=348)
        loc_oPagina.AddObject("lbl_4c_Ocorrencias", "Label")
        WITH loc_oPagina.lbl_4c_Ocorrencias
            .Top       = 142
            .Left      = 348
            .Width     = 72
            .Height    = 15
            .Caption   = "Ocorr" + CHR(234) + "ncias"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        *-- Grid Operacoes (grdOperacaos: Top=242 -> Page1: 157, Left=348)
        *   ColumnCount e RecordSource definidos ANTES do WITH para que colunas existam
        loc_oPagina.AddObject("grd_4c_Operacaos", "Grid")
        loc_oPagina.grd_4c_Operacaos.ColumnCount  = 3
        loc_oPagina.grd_4c_Operacaos.RecordSource = "CsOperacaos"
        WITH loc_oPagina.grd_4c_Operacaos
            .Top               = 157
            .Left              = 348
            .Width             = 340
            .Height            = 201
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .HeaderHeight      = 0
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .FontName          = "Tahoma"
            .Visible           = .F.
        ENDWITH

        loc_oPagina.grd_4c_Operacaos.Column1.Width         = 15
        loc_oPagina.grd_4c_Operacaos.Column1.Movable       = .F.
        loc_oPagina.grd_4c_Operacaos.Column1.Resizable     = .F.
        loc_oPagina.grd_4c_Operacaos.Column1.Sparse        = .F.

        loc_oPagina.grd_4c_Operacaos.Column2.Width         = 80
        loc_oPagina.grd_4c_Operacaos.Column2.Movable       = .F.
        loc_oPagina.grd_4c_Operacaos.Column2.Resizable     = .F.
        loc_oPagina.grd_4c_Operacaos.Column2.ReadOnly      = .T.
        loc_oPagina.grd_4c_Operacaos.Column2.ControlSource = "CsOperacaos.Codigos"

        loc_oPagina.grd_4c_Operacaos.Column3.Width         = 220
        loc_oPagina.grd_4c_Operacaos.Column3.Movable       = .F.
        loc_oPagina.grd_4c_Operacaos.Column3.Resizable     = .F.
        loc_oPagina.grd_4c_Operacaos.Column3.ReadOnly      = .T.
        loc_oPagina.grd_4c_Operacaos.Column3.ControlSource = "CsOperacaos.Descrs"

        *-- Adiciona CheckBox na Column1 para marcar ocorrencias
        loc_oPagina.grd_4c_Operacaos.Column1.AddObject("chk_4c_Marca", "CheckBox")
        WITH loc_oPagina.grd_4c_Operacaos.Column1.chk_4c_Marca
            .AutoSize      = .T.
            .Alignment     = 0
            .Caption       = ""
            .BackStyle     = 0
            .Visible       = .T.
        ENDWITH
        loc_oPagina.grd_4c_Operacaos.Column1.CurrentControl  = "chk_4c_Marca"
        loc_oPagina.grd_4c_Operacaos.Column1.ControlSource   = "CsOperacaos.Marcas"
        BINDEVENT(loc_oPagina.grd_4c_Operacaos.Column1.chk_4c_Marca, ;
            "Click", THIS, "CliqueCheckOperacao")

        *-- Botao Selecionar Tudo (SelTudo: Top=279 -> Page1: 194, Left=696)
        loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH loc_oPagina.cmd_4c_SelTudo
            .Top          = 194
            .Left         = 696
            .Width        = 40
            .Height       = 40
            .Caption      = ""
            .FontName     = "Verdana"
            .FontSize     = 8
            .WordWrap     = .T.
            .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .TabStop      = .F.
            .ToolTipText  = "Seleciona Tudo"
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            .Visible      = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_SelTudo, "Click", THIS, "CliqueSelTudo")

        *-- Botao Cancela Tudo (apaga: Top=320 -> Page1: 235, Left=696)
        loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH loc_oPagina.cmd_4c_Apaga
            .Top          = 235
            .Left         = 696
            .Width        = 40
            .Height       = 40
            .Caption      = ""
            .FontName     = "Verdana"
            .FontSize     = 8
            .WordWrap     = .T.
            .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .TabStop      = .F.
            .ToolTipText  = "Cancela Tudo"
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            .Visible      = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Apaga, "Click", THIS, "CliqueApaga")

        *-- Controle de acesso via fChecaAcesso
        THIS.AplicarAcessoControles()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Nao aplicavel para form de relatorio (stub)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarAcessoControles - Controla visibilidade conforme perfil do usuario
    *   fChecaAcesso("SIGREINR", "CUSTO") -> mostra/oculta optg_4c_TpCusto
    *   fChecaAcesso("SIGREINR", "RELATORIO") -> controla opcoes do TipoRel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarAcessoControles()
        LOCAL loc_oPg, loc_lCusto, loc_lRelatorio, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_lCusto     = fChecaAcesso("SIGREINR", "CUSTO")
            loc_lRelatorio = fChecaAcesso("SIGREINR", "RELATORIO")
        CATCH TO loc_oErro
            loc_lCusto     = .F.
            loc_lRelatorio = .T.
        ENDTRY

        *-- Custo: visivel apenas se tem acesso
        loc_oPg.lbl_4c_TpCusto.Visible    = loc_lCusto
        loc_oPg.optg_4c_TpCusto.Visible   = loc_lCusto
        IF !loc_lCusto
            loc_oPg.optg_4c_TpCusto.Value = 2
        ENDIF
        THIS.this_oRelatorio.this_lPermissaoCusto = loc_lCusto

        *-- Relatorio completo: oculta opcoes restrictas se sem acesso
        IF !loc_lRelatorio
            loc_oPg.optg_4c_TipoRel.Buttons(2).Visible = .F.
            loc_oPg.optg_4c_TipoRel.Buttons(4).Visible = .F.
            loc_oPg.optg_4c_TipoRel.Buttons(5).Visible = .F.
            loc_oPg.optg_4c_TipoRel.Buttons(6).Visible = .F.
            loc_oPg.optg_4c_TipoRel.Buttons(7).Visible = .F.
        ENDIF
        THIS.this_oRelatorio.this_lPermissaoRelatorio = loc_lRelatorio
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        TRY
            WITH THIS.this_oRelatorio
                .this_nTipoRel    = loc_oPg.optg_4c_TipoRel.Value
                .this_nTipoDif    = loc_oPg.optg_4c_TipoDif.Value
                .this_nTipoLeitura = loc_oPg.optg_4c_TipoLeitura.Value
                .this_nTipoAnal   = loc_oPg.optg_4c_TipoAnal.Value
                .this_cProduto    = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)
                .this_cDsProduto  = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
                .this_cLocal      = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)
                .this_cDsLocal    = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)
                .this_nBarra      = TRANSFORM(loc_oPg.txt_4c_Barra.Value)
                .this_nOptTpCusto = loc_oPg.optg_4c_TpCusto.Value
                .this_nOptTpVenda = loc_oPg.optg_4c_TpVenda.Value
                .this_nOptFoto    = loc_oPg.optg_4c_Foto.Value
                .this_nOptEtiq    = loc_oPg.optg_4c_Etiq.Value
                .this_nOptObs     = loc_oPg.optg_4c_Obs.Value
                .this_nOptCtg     = loc_oPg.optg_4c_Ctg.Value
                .this_nOptCol     = loc_oPg.optg_4c_Col.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaRelatorio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Delega validacao ao BO (apos FormParaRelatorio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        RETURN THIS.this_oRelatorio.ValidarFiltros()
    ENDPROC

    *==========================================================================
    * CONTROLE DE ESTADO - INTERACTIVIDADE DOS FILTROS
    *==========================================================================

    *--------------------------------------------------------------------------
    * MudouTipoRelatorio - Atualiza estado dos controles conforme TipoRel
    *   Espelha TipoRelat?rio.InteractiveChange do legado
    *--------------------------------------------------------------------------
    PROCEDURE MudouTipoRelatorio()
        LOCAL loc_nTipo, loc_oPg, loc_lPermCusto
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_nTipo = loc_oPg.optg_4c_TipoRel.Value

        *-- TipoDiferenca: apenas TipoRel=1
        loc_oPg.optg_4c_TipoDif.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")

        *-- TipoLeitura e TipoAnalitico: apenas TipoRel=2
        loc_oPg.optg_4c_TipoLeitura.SetAll("Enabled", (loc_nTipo = 2), "OptionButton")
        loc_oPg.optg_4c_TipoAnal.SetAll("Enabled", (loc_nTipo = 2), "OptionButton")

        *-- TpCusto e TpVenda: apenas TipoRel=1, e se tem permissao
        loc_lPermCusto = THIS.this_oRelatorio.this_lPermissaoCusto
        loc_oPg.optg_4c_TpCusto.SetAll("Enabled", (loc_nTipo = 1 AND loc_lPermCusto), "OptionButton")
        loc_oPg.optg_4c_TpVenda.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")

        *-- Foto e Etiq: apenas TipoRel=1
        loc_oPg.optg_4c_Foto.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")
        loc_oPg.optg_4c_Etiq.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")

        *-- Campos Produto/Local/Barra: apenas TipoRel=2
        loc_oPg.txt_4c_CodProduto.Enabled = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 1)
        loc_oPg.txt_4c_DsProduto.Enabled  = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 1)
        loc_oPg.txt_4c_CodLocal.Enabled   = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 2)
        loc_oPg.txt_4c_DsLocal.Enabled    = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 2)
        loc_oPg.txt_4c_Barra.Enabled      = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 3)

        *-- Grid de ocorrencias: apenas TipoRel=4
        loc_oPg.grd_4c_Operacaos.Visible   = (loc_nTipo = 4)
        loc_oPg.cmd_4c_Apaga.Visible       = (loc_nTipo = 4)
        loc_oPg.cmd_4c_SelTudo.Visible     = (loc_nTipo = 4)
        loc_oPg.lbl_4c_Ocorrencias.Visible = (loc_nTipo = 4)

        *-- Obs/Colecao/Categoria: apenas TipoRel=1 ou 3
        loc_oPg.lbl_4c_Obs.Visible      = INLIST(loc_nTipo, 1, 3)
        loc_oPg.optg_4c_Obs.Visible     = INLIST(loc_nTipo, 1, 3)
        loc_oPg.lbl_4c_Colecao.Visible  = INLIST(loc_nTipo, 1, 3)
        loc_oPg.optg_4c_Ctg.Visible     = INLIST(loc_nTipo, 1, 3)
        loc_oPg.lbl_4c_Ctg.Visible      = INLIST(loc_nTipo, 1, 3)
        loc_oPg.optg_4c_Col.Visible     = INLIST(loc_nTipo, 1, 3)

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * MudouTipoAnalitico - Atualiza campos de filtro conforme TipoAnal
    *   Espelha TipoAnal?tico.InteractiveChange do legado
    *--------------------------------------------------------------------------
    PROCEDURE MudouTipoAnalitico()
        LOCAL loc_nAnal, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_nAnal = loc_oPg.optg_4c_TipoAnal.Value

        loc_oPg.txt_4c_CodProduto.Enabled = (loc_nAnal = 1)
        loc_oPg.txt_4c_DsProduto.Enabled  = (loc_nAnal = 1)
        loc_oPg.txt_4c_CodLocal.Enabled   = (loc_nAnal = 2)
        loc_oPg.txt_4c_DsLocal.Enabled    = (loc_nAnal = 2)
        loc_oPg.txt_4c_Barra.Enabled      = (loc_nAnal = 3)

        DO CASE
            CASE loc_nAnal = 1
                loc_oPg.txt_4c_CodProduto.SetFocus()
            CASE loc_nAnal = 2
                loc_oPg.txt_4c_CodLocal.SetFocus()
            OTHERWISE
                loc_oPg.txt_4c_Barra.SetFocus()
        ENDCASE
    ENDPROC

    *==========================================================================
    * LOOKUPS - PRODUTO
    *==========================================================================

    PROCEDURE TeclaCodProduto(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCodProduto()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsProduto(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaDsProduto()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCodProduto()
        LOCAL loc_oPg, loc_cValor, loc_oForm, loc_nResult, loc_nBarra
        LOCAL lnbarra_val, lcpros_val
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)

        *-- Se valor e numerico, pode ser codigo de barras -> busca em SigOpEtq
        loc_nBarra = VAL(loc_cValor)
        IF loc_nBarra > 0
            lnbarra_val = loc_nBarra
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "Select CPros From SigOpEtq Where CBars = ?lnbarra_val", ;
                "cursor_4c_EtqLkp")
            IF loc_nResult > 0
                SELECT cursor_4c_EtqLkp
                GO TOP
                IF !EOF()
                    loc_cValor = ALLTRIM(cursor_4c_EtqLkp.CPros)
                ENDIF
                USE IN cursor_4c_EtqLkp
            ENDIF
        ENDIF

        *-- Busca direta por codigo na SigCdPro
        lcpros_val  = loc_cValor
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "Select cpros,dpros From SigCdPro Where cpros = ?lcpros_val", ;
            "cursor_4c_ProLkp")
        IF loc_nResult > 0
            SELECT cursor_4c_ProLkp
            GO TOP
            IF !EOF()
                loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProLkp.cpros)
                loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProLkp.dpros)
                USE IN cursor_4c_ProLkp
                RETURN
            ENDIF
            USE IN cursor_4c_ProLkp
        ENDIF

        *-- Nao encontrado: abre FormBuscaAuxiliar
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_ProBusca", "cpros", loc_cValor, "Produtos")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ProBusca")
            loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProBusca.cpros)
            loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProBusca.dpros)
        ELSE
            loc_oPg.txt_4c_CodProduto.Value = ""
            loc_oPg.txt_4c_DsProduto.Value  = ""
        ENDIF
        IF USED("cursor_4c_ProBusca")
            USE IN cursor_4c_ProBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE AbrirBuscaDsProduto()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_ProBusca", "dpros", loc_cValor, "Produtos")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ProBusca")
            loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProBusca.cpros)
            loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProBusca.dpros)
        ELSE
            loc_oPg.txt_4c_CodProduto.Value = ""
            loc_oPg.txt_4c_DsProduto.Value  = ""
        ENDIF
        IF USED("cursor_4c_ProBusca")
            USE IN cursor_4c_ProBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE ValidarCodProduto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor, lcpros_val, loc_nResult
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsProduto.Value = ""
            RETURN
        ENDIF
        lcpros_val  = loc_cValor
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "Select cpros,dpros From SigCdPro Where cpros = ?lcpros_val", ;
            "cursor_4c_ProVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ProVal
            GO TOP
            IF !EOF()
                loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProVal.cpros)
                loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProVal.dpros)
            ELSE
                THIS.AbrirBuscaCodProduto()
            ENDIF
            USE IN cursor_4c_ProVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsProduto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CodProduto.Value = ""
            loc_oPg.txt_4c_DsProduto.Value  = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsProduto()
    ENDPROC

    *==========================================================================
    * LOOKUPS - LOCAL
    *==========================================================================

    PROCEDURE TeclaCodLocal(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCodLocal()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsLocal(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaDsLocal()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCodLocal()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrLcl", "cursor_4c_LclBusca", "codigos", loc_cValor, "Locais")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LclBusca")
            loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclBusca.codigos)
            loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclBusca.descricaos)
        ELSE
            loc_oPg.txt_4c_CodLocal.Value = ""
            loc_oPg.txt_4c_DsLocal.Value  = ""
        ENDIF
        IF USED("cursor_4c_LclBusca")
            USE IN cursor_4c_LclBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE AbrirBuscaDsLocal()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrLcl", "cursor_4c_LclBusca", "descricaos", loc_cValor, "Locais")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LclBusca")
            loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclBusca.codigos)
            loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclBusca.descricaos)
        ELSE
            loc_oPg.txt_4c_CodLocal.Value = ""
            loc_oPg.txt_4c_DsLocal.Value  = ""
        ENDIF
        IF USED("cursor_4c_LclBusca")
            USE IN cursor_4c_LclBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE ValidarCodLocal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor, lcodigos_val, loc_nResult
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsLocal.Value = ""
            RETURN
        ENDIF
        lcodigos_val = loc_cValor
        loc_nResult  = SQLEXEC(gnConnHandle, ;
            "Select codigos,descricaos From SigPrLcl Where codigos = ?lcodigos_val", ;
            "cursor_4c_LclVal")
        IF loc_nResult > 0
            SELECT cursor_4c_LclVal
            GO TOP
            IF !EOF()
                loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclVal.codigos)
                loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclVal.descricaos)
            ELSE
                THIS.AbrirBuscaCodLocal()
            ENDIF
            USE IN cursor_4c_LclVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsLocal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CodLocal.Value = ""
            loc_oPg.txt_4c_DsLocal.Value  = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsLocal()
    ENDPROC

    *==========================================================================
    * GRID OCORRENCIAS
    *==========================================================================

    PROCEDURE CliqueCheckOperacao()
        IF USED("CsOperacaos")
            SELECT CsOperacaos
            REPLACE Marcas WITH IIF(CsOperacaos.Marcas = 0, 1, 0) IN CsOperacaos
            THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE CliqueSelTudo()
        IF USED("CsOperacaos")
            SELECT CsOperacaos
            UPDATE CsOperacaos SET Marcas = 1
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
            THIS.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE CliqueApaga()
        IF USED("CsOperacaos")
            SELECT CsOperacaos
            UPDATE CsOperacaos SET Marcas = 0
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
            THIS.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.ValidarFiltros()
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Campo Obrigat" + CHR(243) + "rio")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro na Visualiza" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.ValidarFiltros()
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Campo Obrigat" + CHR(243) + "rio")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.Imprimir(.T.)
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro na Impress" + CHR(227) + "o")
            ELSE
                THIS.this_oRelatorio.RegistrarAuditoria("IMPRIMIR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnGerarExcelClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.ValidarFiltros()
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Campo Obrigat" + CHR(243) + "rio")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.Imprimir(.F.)
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Gerar Documento")
            ELSE
                THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT (aliases para compatibilidade com pipeline)
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
            CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir.", "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        RETURN .T.
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura valores padrao dos controles
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_CodProduto.Value    = ""
            loc_oPg.txt_4c_DsProduto.Value     = ""
            loc_oPg.txt_4c_CodLocal.Value      = ""
            loc_oPg.txt_4c_DsLocal.Value       = ""
            loc_oPg.txt_4c_Barra.Value         = 0
            loc_oPg.optg_4c_TipoRel.Value      = 1
            loc_oPg.optg_4c_TipoDif.Value      = 2
            loc_oPg.optg_4c_TipoLeitura.Value  = 1
            loc_oPg.optg_4c_TipoAnal.Value     = 1
            loc_oPg.optg_4c_TpCusto.Value      = 2
            loc_oPg.optg_4c_TpVenda.Value      = 1
            loc_oPg.optg_4c_Foto.Value         = 2
            loc_oPg.optg_4c_Etiq.Value         = 2
            loc_oPg.optg_4c_Obs.Value          = 2
            loc_oPg.optg_4c_Ctg.Value          = 2
            loc_oPg.optg_4c_Col.Value          = 2
            THIS.MudouTipoRelatorio()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
                IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
                    THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                    THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                    THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                    THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(4).Enabled = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (Custom nao tem Release, usar .NULL.)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
