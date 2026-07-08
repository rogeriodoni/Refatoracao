*==============================================================================
* FORMSIGREDOC.PRG
* Impress" + CHR(227) + "o de Documento - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREDOC.SCX (frmrelatorio)
*
* Filtros:
*   - GrdEmp     : grid de selecao de empresas (cursor_4c_Emps)
*   - Operacao   : txt_4c_Dopes (c=20, uppercase, valida via ValidarOperacao)
*   - Periodo    : txt_4c_DtInicial / txt_4c_DtFinal (mutuamente exclusivos com Numeros)
*   - Numero     : txt_4c_NumeroI / txt_4c_NumeroF  (mutuamente exclusivos com Datas)
*   - Reimp      : chk_4c_Reimp (habilitado/desabilitado por ValidarOperacao)
*   - Imagem     : chk_4c_Imagem
*   - FiltroAbto : chk_4c_Itens (itens sem baixa)
*   - Agrupar    : opt_4c_Agrupa (2 opcoes, padrao=Nenhum)
*
* Form: Width=800, Height=500
* Cabecalho: Top=0, Height=80
* PageFrame: Top=85, Height=415, Width=802
* Page1 controles: Top_page1 = Top_original - 85
*==============================================================================

DEFINE CLASS Formsigredoc AS FormBase

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

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual e instancia BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Impress" + CHR(227) + "o de Documento"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoBase") = "U"
                gc_4c_CaminhoBase = ""
            ENDIF

            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigredocBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigredocBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.CarregarEmpresas()
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
    * ConfigurarCabecalho - Container cinza com titulo e botoes de acao
    *   cmg_4c_Botoes: Visualizar / Imprimir / Doc.Excel / Sair
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
                .Caption   = "Impress" + CHR(227) + "o de Documento"
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
                .Caption   = "Impress" + CHR(227) + "o de Documento"
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
                    .Caption         = "Visualizar"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .Top             = 5
                    .Left            = 5
                    .Width           = THIS.Width
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
                ENDWITH

                WITH .Buttons(2)
                    .Caption         = "Imprimir"
                    .Top             = 5
                    .Left            = 71
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                    .PicturePosition = 13
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Caption         = "Doc. Excel"
                    .WordWrap        = .T.
                    .Top             = 5
                    .Left            = 137
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                    .PicturePosition = 13
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(4)
                    .Caption         = "Sair"
                    .WordWrap        = .T.
                    .Top             = 5
                    .Left            = 203
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                    .PicturePosition = 13
                    .Cancel          = .T.
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
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
    *   Form Height=500; Cabecalho Height=80; PageFrame Top=85, Height=415
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
    * ConfigurarPaginaLista - Todos os controles de filtro na Page1 (REPORT form)
    *   Em forms REPORT, a "pagina lista" eh a pagina unica com filtros + grid
    *   de empresas; o nome ConfigurarPaginaLista mantem compatibilidade com o
    *   pipeline multi-fase (validacao Fase 4) e com forms similares (FormSIGREDIR).
    *   Posicoes: Top_page1 = Top_original - 85
    *   (Form original Top max ~420; PageFrame.Top=85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrd
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Label "Empresas :" (top_orig=104, left=217 -> page1 top=19)
        loc_oPagina.AddObject("lbl_4c_LblEmpresas", "Label")
        WITH loc_oPagina.lbl_4c_LblEmpresas
            .Top       = 19
            .Left      = 217
            .Width     = 63
            .Height    = 15
            .Caption   = "Empresas :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid de empresas (top_orig=120, left=216 -> page1 top=35)
        *   Column1: CheckBox Marca (w=15)
        *   Column2: cEmps Cod. (w=33, ReadOnly)
        *   Column3: Razas Nome (w=245, ReadOnly)
        loc_oPagina.AddObject("grd_4c_Emps", "Grid")
        loc_oGrd = loc_oPagina.grd_4c_Emps
        loc_oGrd.ColumnCount  = 3
        loc_oGrd.RecordSource = ""
        WITH loc_oGrd
            .Top              = 35
            .Left             = 216
            .Width            = 327
            .Height           = 164
            .FontName         = "Tahoma"
            .FontSize         = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing   = .F.
            .DeleteMark       = .F.
            .HeaderHeight     = 16
            .RowHeight        = 16
            .ScrollBars       = 2
            .GridLineColor    = RGB(238, 238, 238)
            .Themes           = .F.
            .Visible          = .T.

            *-- Column1: CheckBox para Marca
            WITH .Column1
                .Width     = 15
                .Movable   = .F.
                .Resizable = .F.
                .Sparse    = .F.
                .Header1.Caption   = ""
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(90, 90, 90)
                .AddObject("chk_4c_Marca", "CheckBox")
                .CurrentControl = "chk_4c_Marca"
                WITH .chk_4c_Marca
                    .Caption   = ""
                    .Alignment = 2
                    .Width     = 14
                    .Height    = 14
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                ENDWITH
            ENDWITH

            *-- Column2: Codigo empresa (ReadOnly)
            WITH .Column2
                .Width          = 33
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .T.
                .CurrentControl = "Text1"
                .Header1.Caption   = "C" + CHR(243) + "d."
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(90, 90, 90)
                .Header1.Alignment = 2
                WITH .Text1
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column3: Razao social (ReadOnly)
            WITH .Column3
                .Width          = 245
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .T.
                .CurrentControl = "Text1"
                .Header1.Caption   = "Nome da Empresa"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.ForeColor = RGB(90, 90, 90)
                .Header1.Alignment = 2
                WITH .Text1
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH
        ENDWITH

        *-- Botao Selecionar Todas (cmdSelemp, top_orig=164, left=547 -> top=79)
        loc_oPagina.AddObject("cmd_4c_SelecionarTodas", "CommandButton")
        WITH loc_oPagina.cmd_4c_SelecionarTodas
            .Top          = 79
            .Left         = 547
            .Width        = 40
            .Height       = 40
            .Caption      = ""
            .Picture      = gc_4c_CaminhoBase + "vbmp\a_save1.bmp"
            .FontName     = "Verdana"
            .FontSize     = 8
            .WordWrap     = .T.
            .ToolTipText  = "Selecionar"
            .TabStop      = .F.
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            .Visible      = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_SelecionarTodas, "Click", THIS, "CmdSelecionarTodasClick")

        *-- Botao Desmarcar Todas (CmdApgEmp, top_orig=204, left=547 -> top=119)
        loc_oPagina.AddObject("cmd_4c_DesmarcarTodas", "CommandButton")
        WITH loc_oPagina.cmd_4c_DesmarcarTodas
            .Top          = 119
            .Left         = 547
            .Width        = 40
            .Height       = 40
            .Caption      = ""
            .Picture      = gc_4c_CaminhoBase + "vbmp\cancelab.bmp"
            .FontName     = "Verdana"
            .FontSize     = 8
            .WordWrap     = .T.
            .ToolTipText  = "Desmarcar"
            .TabStop      = .F.
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            .Visible      = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_DesmarcarTodas, "Click", THIS, "CmdDesmarcarTodasClick")

        *-- Label "Opera" + CHR(231) + CHR(227) + "o :" (top_orig=293, left=225 -> top=208)
        loc_oPagina.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oPagina.lbl_4c_Operacao
            .Top       = 208
            .Left      = 225
            .Width     = 59
            .Height    = 18
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Campo Operacao get_dopes (top_orig=289, left=288 -> top=204)
        loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPagina.txt_4c_Dopes
            .Top           = 204
            .Left          = 288
            .Width         = 150
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 9
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Format        = "K!"
            .MaxLength     = 20
            .SpecialEffect = 0
            .BorderStyle   = 1
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dopes, "KeyPress", THIS, "TeclaDopes")

        *-- Label "Periodo :" (top_orig=318, left=236 -> top=233)
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 233
            .Left      = 236
            .Width     = 48
            .Height    = 18
            .Caption   = "Periodo : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Data Inicial (top_orig=314, left=288 -> top=229)
        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .Top           = 229
            .Left          = 288
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K"
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDtInicial")
        BINDEVENT(loc_oPagina.txt_4c_DtInicial, "LostFocus", THIS, "AtualizarEstadoFiltros")

        *-- Separador "a" entre datas (top_orig=319, left=371 -> top=234)
        loc_oPagina.AddObject("lbl_4c_SepData", "Label")
        WITH loc_oPagina.lbl_4c_SepData
            .Top       = 234
            .Left      = 371
            .Width     = 8
            .Height    = 18
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data Final (top_orig=314, left=382 -> top=229)
        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .Top           = 229
            .Left          = 382
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K"
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDtFinal")
        BINDEVENT(loc_oPagina.txt_4c_DtFinal, "LostFocus", THIS, "AtualizarEstadoFiltros")

        *-- Label "N" + CHR(250) + "mero :" (top_orig=341, left=235 -> top=256)
        loc_oPagina.AddObject("lbl_4c_Numero", "Label")
        WITH loc_oPagina.lbl_4c_Numero
            .Top       = 256
            .Left      = 235
            .Width     = 49
            .Height    = 18
            .Caption   = "N" + CHR(250) + "mero : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Numero Inicial Get_Opera??oi (top_orig=339, left=288 -> top=254)
        loc_oPagina.AddObject("txt_4c_NumeroI", "TextBox")
        WITH loc_oPagina.txt_4c_NumeroI
            .Top           = 254
            .Left          = 288
            .Width         = 55
            .Height        = 23
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K"
            .InputMask     = "999999"
            .MaxLength     = 6
            .Alignment     = 3
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_NumeroI, "KeyPress", THIS, "TeclaNumeroI")
        BINDEVENT(loc_oPagina.txt_4c_NumeroI, "LostFocus", THIS, "AtualizarEstadoFiltros")

        *-- Separador "a" entre numeros (top_orig=344, left=349 -> top=259)
        loc_oPagina.AddObject("lbl_4c_SepNumero", "Label")
        WITH loc_oPagina.lbl_4c_SepNumero
            .Top       = 259
            .Left      = 349
            .Width     = 8
            .Height    = 15
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Numero Final Get_Opera??of (top_orig=339, left=363 -> top=254)
        loc_oPagina.AddObject("txt_4c_NumeroF", "TextBox")
        WITH loc_oPagina.txt_4c_NumeroF
            .Top           = 254
            .Left          = 363
            .Width         = 55
            .Height        = 23
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K"
            .InputMask     = "999999"
            .MaxLength     = 6
            .Alignment     = 3
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_NumeroF, "KeyPress", THIS, "TeclaNumeroF")
        BINDEVENT(loc_oPagina.txt_4c_NumeroF, "LostFocus", THIS, "AtualizarEstadoFiltros")

        *-- Checkbox Imprimir Imagem (top_orig=368, left=288 -> top=283)
        loc_oPagina.AddObject("chk_4c_Imagem", "CheckBox")
        WITH loc_oPagina.chk_4c_Imagem
            .Top       = 283
            .Left      = 288
            .Width     = 100
            .Height    = 15
            .Caption   = "Imprimir Imagem"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox Imprimir Apenas Itens em Aberto (top_orig=384, left=288 -> top=299)
        loc_oPagina.AddObject("chk_4c_ItensPendentes", "CheckBox")
        WITH loc_oPagina.chk_4c_ItensPendentes
            .Top       = 299
            .Left      = 288
            .Width     = 170
            .Height    = 15
            .Caption   = "Imprimir Apenas Itens Pendentes"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox Reimpressao (top_orig=400, left=288 -> top=315)
        loc_oPagina.AddObject("chk_4c_Reimp", "CheckBox")
        WITH loc_oPagina.chk_4c_Reimp
            .Top           = 315
            .Left          = 288
            .Width         = 79
            .Height        = 15
            .Caption       = "Reimpress" + CHR(227) + "o"
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .F.
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 0
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label "Agrupar por: " (top_orig=420, left=217 -> top=335)
        loc_oPagina.AddObject("lbl_4c_AgruparPor", "Label")
        WITH loc_oPagina.lbl_4c_AgruparPor
            .Top       = 335
            .Left      = 217
            .Width     = 67
            .Height    = 18
            .Caption   = "Agrupar por: "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- OptAgrupa (top_orig=416, left=283 -> top=331)
        *   Value=2 = Nenhum (padrao)
        *   Button1: "Produto, Cor, Valor Unit" + CHR(225) + "rio" (Value=1)
        *   Button2: "Nenhum" (Value=1 dentro do botao, mas grupo Value=2)
        loc_oPagina.AddObject("opt_4c_Agrupa", "OptionGroup")
        WITH loc_oPagina.opt_4c_Agrupa
            .Top         = 331
            .Left        = 283
            .Width       = 267
            .Height      = 27
            .ButtonCount = 2
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Produto, Cor, Valor Unit" + CHR(225) + "rio"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 5
                .Left      = 5
                .Width     = 151
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Nenhum"
                .Top       = 5
                .Left      = 193
                .Width     = 69
                .Height    = 17
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_Agrupa, "InteractiveChange", THIS, "OptAgrupaInteractiveChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Form REPORT: todos os controles estao em
    *   ConfigurarPaginaLista() (Page1 = Filtros). Nao ha Page2 de edicao.
    *   O original SIGREDOC.SCX (frmrelatorio) tem layout plano sem PageFrame
    *   de edicao; todos os 20 controles migrados estao na Page1/Filtros:
    *     grd_4c_Emps (3 colunas), txt_4c_Dopes, txt_4c_DtInicial,
    *     txt_4c_DtFinal, txt_4c_NumeroI, txt_4c_NumeroF, chk_4c_Imagem,
    *     chk_4c_Reimp, opt_4c_Agrupa (2 botoes), checkboxes de filtro,
    *     cmd_4c_SelecionarTodas, cmd_4c_DesmarcarTodas + 6 labels.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro, loc_lOk
        loc_lOk = .F.
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            *-- Verificar que os controles essenciais existem
            loc_lOk = PEMSTATUS(loc_oPagina, "txt_4c_Dopes",    5) AND ;
                      PEMSTATUS(loc_oPagina, "grd_4c_Emps",     5) AND ;
                      PEMSTATUS(loc_oPagina, "chk_4c_Reimp",    5) AND ;
                      PEMSTATUS(loc_oPagina, "opt_4c_Agrupa",   5)
            IF !loc_lOk
                THIS.this_cMensagemErro = "Controles de filtro n" + CHR(227) + "o encontrados na Page1"
                MsgErro(THIS.this_cMensagemErro, "ConfigurarPaginaDados")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaDados")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega cursor de empresas e vincula ao grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas()
        LOCAL loc_oCursor, loc_oGrd, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF THIS.this_oRelatorio.CarregarEmpresas()
                    loc_oCursor = THIS.this_oRelatorio.this_cCursorEmpresas
                    loc_oGrd    = THIS.pgf_4c_Paginas.Page1.grd_4c_Emps

                    loc_oGrd.RecordSource = loc_oCursor
                    WITH loc_oGrd
                        .Column1.ControlSource    = loc_oCursor + ".Marca"
                        .Column2.ControlSource    = loc_oCursor + ".cEmps"
                        .Column3.ControlSource    = loc_oCursor + ".Razas"
                        .Refresh()
                    ENDWITH
                ELSE
                    MsgErro("Falha ao carregar lista de empresas.", "CarregarEmpresas")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarEmpresas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa filtros com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            WITH loc_oPagina
                .txt_4c_Dopes.Value          = ""
                .txt_4c_DtInicial.Value      = {}
                .txt_4c_DtFinal.Value        = {}
                .txt_4c_NumeroI.Value        = 0
                .txt_4c_NumeroF.Value        = 0
                .chk_4c_Imagem.Value         = 0
                .chk_4c_ItensPendentes.Value = 0
                .chk_4c_Reimp.Value          = 0
                .chk_4c_Reimp.Enabled        = .T.
                .opt_4c_Agrupa.Value         = 2
            ENDWITH

            THIS.AtualizarEstadoFiltros()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa pagina (forms REPORT tem so Page1)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro, loc_oPagina
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPagina, "txt_4c_Dopes", 5)
                loc_oPagina.txt_4c_Dopes.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores do form para o BO antes de processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cDopes          = ALLTRIM(loc_oPagina.txt_4c_Dopes.Value)
            .this_dDtInicial      = loc_oPagina.txt_4c_DtInicial.Value
            .this_dDtFinal        = loc_oPagina.txt_4c_DtFinal.Value
            .this_nOperacaoI      = loc_oPagina.txt_4c_NumeroI.Value
            .this_nOperacaoF      = loc_oPagina.txt_4c_NumeroF.Value
            .this_nReimp          = loc_oPagina.chk_4c_Reimp.Value
            .this_nAgrupa         = loc_oPagina.opt_4c_Agrupa.Value
            .this_lImagem         = (loc_oPagina.chk_4c_Imagem.Value = 1)
            .this_lItensPendentes = (loc_oPagina.chk_4c_ItensPendentes.Value = 1)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOperacao - Valida codigo de operacao e atualiza estado chk_4c_Reimp
    *   Equivalente ao get_dopes.Valid do legado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOperacao()
        LOCAL loc_cDopes, loc_oPagina, loc_oErro, loc_lEnabled, loc_nNdopes
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cDopes  = ALLTRIM(loc_oPagina.txt_4c_Dopes.Value)

        TRY
            IF !EMPTY(loc_cDopes)
                fAcessoMovmto(gc_4c_UsuarioLogado, loc_cDopes, loc_oPagina.txt_4c_Dopes)
            ENDIF

            IF !EMPTY(loc_cDopes)
                IF VARTYPE(THIS.this_oRelatorio) = "O"
                    THIS.this_oRelatorio.ValidarOperacao(loc_cDopes)
                    IF THIS.this_oRelatorio.this_nChkImpDoc = 1
                        loc_nNdopes  = THIS.this_oRelatorio.this_nNdopes
                        loc_lEnabled = fChecaAcesso( ;
                            PADL(ALLTRIM(STR(loc_nNdopes)), 8, "0"), "REIMPDOC")
                        loc_oPagina.chk_4c_Reimp.Enabled = loc_lEnabled
                        IF !loc_lEnabled
                            loc_oPagina.chk_4c_Reimp.Value = 0
                        ENDIF
                    ELSE
                        loc_oPagina.chk_4c_Reimp.Enabled = .T.
                    ENDIF
                ENDIF
            ELSE
                loc_oPagina.chk_4c_Reimp.Enabled = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarOpera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoFiltros - Controla exclusao mutua entre datas e numeros
    *   Datas preenchidas -> numeros desabilitados (e vice-versa)
    *   Replicando comportamento dos When events do legado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoFiltros()
        LOCAL loc_oPagina, loc_lDatasVazias, loc_lNumerosZero, loc_nIni, loc_nFim, loc_oErro
        TRY
            loc_oPagina      = THIS.pgf_4c_Paginas.Page1
            loc_lDatasVazias = EMPTY(loc_oPagina.txt_4c_DtInicial.Value) AND ;
                               EMPTY(loc_oPagina.txt_4c_DtFinal.Value)
            loc_nIni         = loc_oPagina.txt_4c_NumeroI.Value
            loc_nFim         = loc_oPagina.txt_4c_NumeroF.Value
            loc_lNumerosZero = (loc_nIni = 0) AND (loc_nFim = 0)

            *-- Sync: se NumeroI preenchido e NumeroF=0, copiar valor
            IF loc_nIni > 0 AND loc_nFim = 0 AND loc_lDatasVazias
                loc_oPagina.txt_4c_NumeroF.Value = loc_nIni
                loc_oPagina.txt_4c_NumeroF.Refresh()
                loc_lNumerosZero = .F.
            ENDIF

            *-- Numeros habilitados somente quando datas vazias
            loc_oPagina.txt_4c_NumeroI.Enabled = loc_lDatasVazias
            loc_oPagina.txt_4c_NumeroF.Enabled = loc_lDatasVazias

            *-- Datas habilitadas somente quando numeros zero
            loc_oPagina.txt_4c_DtInicial.Enabled = loc_lNumerosZero
            loc_oPagina.txt_4c_DtFinal.Enabled   = loc_lNumerosZero

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AtualizarEstadoFiltros")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OptAgrupaInteractiveChange - InteractiveChange de opt_4c_Agrupa
    *--------------------------------------------------------------------------
    PROCEDURE OptAgrupaInteractiveChange()
        THIS.AtualizarEstadoFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDopes - KeyPress em txt_4c_Dopes; dispara ValidarOperacao ao ENTER/TAB
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDopes(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarOperacao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDtInicial / TeclaDtFinal - KeyPress em campos de data (sem acao especial)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDtInicial(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaDtFinal(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaNumeroI / TeclaNumeroF - KeyPress em campos de numero (sem acao especial)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaNumeroI(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaNumeroF(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelecionarTodasClick - Marca todas as empresas (Marca=1)
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelecionarTodasClick()
        LOCAL loc_oCursor, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oCursor = THIS.this_oRelatorio.this_cCursorEmpresas
                IF USED(loc_oCursor)
                    SELECT (loc_oCursor)
                    REPLACE ALL Marca WITH 1
                    GO TOP
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CmdSelecionarTodas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdDesmarcarTodasClick - Desmarca todas as empresas (Marca=0)
    *--------------------------------------------------------------------------
    PROCEDURE CmdDesmarcarTodasClick()
        LOCAL loc_oCursor, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oCursor = THIS.this_oRelatorio.this_cCursorEmpresas
                IF USED(loc_oCursor)
                    SELECT (loc_oCursor)
                    REPLACE ALL Marca WITH 0
                    GO TOP
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CmdDesmarcarTodas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_lContinuar, loc_cDopes
        loc_lContinuar = .T.
        TRY
            loc_cDopes = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Dopes.Value)
            IF EMPTY(loc_cDopes)
                MsgAviso("Informe o c" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro, loc_lContinuar, loc_cDopes
        loc_lContinuar = .T.
        TRY
            loc_cDopes = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Dopes.Value)
            IF EMPTY(loc_cDopes)
                MsgAviso("Informe o c" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.ImprimirComDialog()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGerarExcelClick - Doc. Excel (impressao direta sem dialogo)
    *--------------------------------------------------------------------------
    PROCEDURE BtnGerarExcelClick()
        LOCAL loc_oErro, loc_lContinuar, loc_cDopes
        loc_lContinuar = .T.
        TRY
            loc_cDopes = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Dopes.Value)
            IF EMPTY(loc_cDopes)
                MsgAviso("Informe o c" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO e cursor de empresas
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            LOCAL loc_oCursor
            loc_oCursor = THIS.this_oRelatorio.this_cCursorEmpresas
            IF USED(loc_oCursor)
                USE IN (loc_oCursor)
            ENDIF
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Forms REPORT nao tem grid CRUD
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em forms REPORT todos os botoes ficam habilitados
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCmg, loc_oErro, loc_nI
        TRY
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
                loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
                FOR loc_nI = 1 TO loc_oCmg.ButtonCount
                    loc_oCmg.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Aliases de interface CRUD exigidos pelo pipeline multi-fase
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnConsultarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO / BOParaForm - Aliases para a interface generica FormBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                WITH THIS.this_oRelatorio
                    loc_oPg.txt_4c_Dopes.Value          = .this_cDopes
                    IF !EMPTY(.this_dDtInicial)
                        loc_oPg.txt_4c_DtInicial.Value  = .this_dDtInicial
                    ENDIF
                    IF !EMPTY(.this_dDtFinal)
                        loc_oPg.txt_4c_DtFinal.Value    = .this_dDtFinal
                    ENDIF
                    loc_oPg.txt_4c_NumeroI.Value        = .this_nOperacaoI
                    loc_oPg.txt_4c_NumeroF.Value        = .this_nOperacaoF
                    loc_oPg.chk_4c_Reimp.Value          = .this_nReimp
                    loc_oPg.opt_4c_Agrupa.Value         = .this_nAgrupa
                    loc_oPg.chk_4c_Imagem.Value         = IIF(.this_lImagem, 1, 0)
                    loc_oPg.chk_4c_ItensPendentes.Value = IIF(.this_lItensPendentes, 1, 0)
                ENDWITH
                THIS.AtualizarEstadoFiltros()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os campos de filtro
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_Dopes", 5)
                    loc_oPg.txt_4c_Dopes.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    loc_oPg.txt_4c_DtInicial.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                    loc_oPg.txt_4c_DtFinal.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_NumeroI", 5)
                    loc_oPg.txt_4c_NumeroI.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_NumeroF", 5)
                    loc_oPg.txt_4c_NumeroF.ReadOnly = !loc_lHab
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

ENDDEFINE
