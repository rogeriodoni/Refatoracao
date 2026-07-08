*==============================================================================
* FORMSIGPRDSC.PRG - Formulario Operacional: Montagem de Descricao de Produtos
* Tipo: OPERACIONAL (flat - sem PageFrame)
* Migrado de SIGPRDSC.SCX
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado (800px -> 1000px escalonado)
*   BD   -> SigCdPro / SigCdDic / SigCdGrp / SigCdCor / SigPrPrt
*   CODE -> arquitetura em camadas (FormBase / SigPrDscBO)
*==============================================================================

DEFINE CLASS FormSigPrDsc AS FormBase

    *-- Propriedades visuais do form
    *-- Caption definido via CHR() em InicializarForm (acentos proibidos em .prg)
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    KeyPreview  = .T.
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1

    *-- Propriedades customizadas
    this_cMensagemErro = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Fix DataSession=2: datasession privada reseta SET DATE/CENTURY para defaults VFP
            SET DATE TO BRITISH
            SET CENTURY ON

            *-- Caption com acentos via CHR() (literal acentuado proibido em .prg)
            THIS.Caption = "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos"

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrDscBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrDscBO", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Guard para validacao UI sem conexao SQL
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ENDIF

            *-- Carregar dicionario de traducao ingles (SigCdDic) em cursor_4c_Dicionario
            IF !THIS.this_oBusinessObject.CarregarDicionario()
                MsgErro("Falha ao carregar dicion" + CHR(225) + "rio: " + ;
                        THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor placeholder de produtos (sera populado pelo BtnSelecionarClick)
            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos ;
                (CPros C(14) NULL, Portugues C(254) NULL, Traduzido C(254) NULL, ;
                 DscCompras M(4) NULL, ObsCompras M(4) NULL)
            SET NULL OFF

            *-- Configuracao base do form (Picture, dimensoes, Caption reforcados)
            *-- Nome ConfigurarPageFrame mantido por convencao do pipeline mesmo
            *-- nao havendo PageFrame neste form OPERACIONAL (layout flat).
            THIS.ConfigurarPageFrame()

            *-- Configurar controles visuais
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.VincularEventos()

            THIS.TornarControlesVisiveis()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigPrDsc: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *  Configuracao base do form OPERACIONAL (layout flat, sem PageFrame).
    *  Ajusta Picture, Caption e dimensoes. Mantem o nome ConfigurarPageFrame
    *  por convencao do pipeline de migracao.
    *==========================================================================
        LOCAL loc_cImgFundo

        *-- Titulo do form (para telemetria/tracing; TitleBar=0 nao mostra)
        THIS.Caption = "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos"

        *-- Imagem de fundo do framework (new_background.jpg)
        loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF

        *-- Reforca dimensoes canonicas (escala 1.25x do legado 800x600)
        THIS.Width      = 1000
        THIS.Height     = 600
        THIS.AutoCenter = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *  Wrapper canonico do pipeline para "Page1 / Lista".
    *  Form OPERACIONAL nao tem PageFrame; agrupa botoes de acao (Selecionar
    *  / Atualizar / Encerrar), filtros (CProsI / CProsF / CGrus) e grid de
    *  produtos, que juntos formam a visao equivalente a Page1 no legado.
    *==========================================================================
        THIS.ConfigurarBotoes()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarGrade()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        LOCAL loc_cCaption
        loc_cCaption = "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos"

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .Visible     = .T.
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = loc_cCaption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
                .Visible       = .T.
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = loc_cCaption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255,255,255)
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
    *==========================================================================
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        *-- Inicia desabilitado; habilitado apos usuario Selecionar produtos
        THIS.AddObject("cmd_4c_BtnAtualizar", "CommandButton")
        WITH THIS.cmd_4c_BtnAtualizar
            .Top             = 3
            .Left            = 650
            .Height          = 75
            .Width           = 75
            .Picture         = loc_cIcones + "geral_relogio_60.jpg"
            .DisabledPicture = loc_cIcones + "geral_relogio_60.jpg"
            .Caption         = "\<Atualizar"
            .Themes          = .T.
            .Enabled         = .F.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        *-- Botao Encerrar (Cancel=.T. mapeia tecla ESC)
        THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
        WITH THIS.cmd_4c_BtnSair
            .Top             = 3
            .Left            = 725
            .Height          = 75
            .Width           = 75
            .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .Themes          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        *-- Icone-only (Caption=""): Themes=.T. obrigatorio para renderizar Picture
        THIS.AddObject("cmd_4c_BtnSelecionar", "CommandButton")
        WITH THIS.cmd_4c_BtnSelecionar
            .Top             = 116
            .Left            = 744
            .Height          = 40
            .Width           = 75
            .Picture         = loc_cIcones + "geral_procura_60.jpg"
            .DisabledPicture = loc_cIcones + "geral_procura_60.jpg"
            .Caption         = ""
            .ToolTipText     = "Selecionar"
            .Themes          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oObjeto, loc_oConteiner

        IF VARTYPE(par_oContainer) = "O"
            loc_oConteiner = par_oContainer
        ELSE
            loc_oConteiner = THIS
        ENDIF

        FOR loc_nI = 1 TO loc_oConteiner.ControlCount
            loc_oObjeto = loc_oConteiner.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_Dicionario")
            USE IN cursor_4c_Dicionario
        ENDIF
        IF USED("cursor_4c_PrdTraduz")
            USE IN cursor_4c_PrdTraduz
        ENDIF
        IF USED("cursor_4c_LocalPro")
            USE IN cursor_4c_LocalPro
        ENDIF
        IF USED("cursor_4c_BuscaProDbl")
            USE IN cursor_4c_BuscaProDbl
        ENDIF
        IF USED("cursor_4c_BuscaGruDbl")
            USE IN cursor_4c_BuscaGruDbl
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros()
    *==========================================================================
        *-- Label "Produtos de :" - original Left=155, Top=138, escala 1.25
        THIS.AddObject("lbl_4c_ProdutosDe", "Label")
        WITH THIS.lbl_4c_ProdutosDe
            .AutoSize  = .F.
            .Width     = 90
            .Height    = 20
            .Left      = 194
            .Top       = 140
            .Caption   = "Produtos de :"
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox CProsI - original Left=233, Width=108
        THIS.AddObject("txt_4c_CProsI", "TextBox")
        WITH THIS.txt_4c_CProsI
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Left          = 291
            .Top           = 135
            .Width         = 135
            .Height        = 24
            .MaxLength     = 14
            .Value         = ""
            .SelectOnEntry = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label "ate" - original Left=345, Top=138
        THIS.AddObject("lbl_4c_Ate", "Label")
        WITH THIS.lbl_4c_Ate
            .AutoSize  = .F.
            .Width     = 30
            .Height    = 20
            .Left      = 431
            .Top       = 140
            .Caption   = "at" + CHR(233)
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox CProsF - original Left=370, Width=108
        THIS.AddObject("txt_4c_CProsF", "TextBox")
        WITH THIS.txt_4c_CProsF
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Left          = 463
            .Top           = 135
            .Width         = 135
            .Height        = 24
            .MaxLength     = 14
            .Value         = ""
            .SelectOnEntry = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label "Grupo de Produto :" - original Left=505, Top=138
        THIS.AddObject("lbl_4c_Grupo", "Label")
        WITH THIS.lbl_4c_Grupo
            .AutoSize  = .F.
            .Width     = 130
            .Height    = 20
            .Left      = 631
            .Top       = 140
            .Caption   = "Grupo de Produto :"
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox CGrus - original Left=614, Width=31
        THIS.AddObject("txt_4c_CGrus", "TextBox")
        WITH THIS.txt_4c_CGrus
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Left          = 768
            .Top           = 135
            .Width         = 39
            .Height        = 24
            .MaxLength     = 3
            .Value         = ""
            .SelectOnEntry = .T.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
    *==========================================================================
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top                = 164
            .Left               = 19
            .Width              = 961
            .Height             = 343
            .FontSize           = 8
            .FontName           = "Verdana"
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .HeaderHeight       = 17
            .RowHeight          = 17
            .ScrollBars         = 2
            .ReadOnly           = .T.
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255,255,255)
            .HighlightForeColor = RGB(15,41,104)
            .GridLineColor      = RGB(238,238,238)
            .Visible            = .T.
        ENDWITH

        THIS.grd_4c_Dados.ColumnCount = 3
        THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
        THIS.grd_4c_Dados.ColumnCount  = 3

        WITH THIS.grd_4c_Dados.Column1
            .Width         = 135
            .FontSize      = 8
            .ControlSource = "cursor_4c_Produtos.CPros"
            .ReadOnly      = .T.
            WITH .Header1
                .Caption   = "C" + CHR(243) + "digo"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
            ENDWITH
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2
            .Width         = 363
            .FontSize      = 8
            .ControlSource = "cursor_4c_Produtos.Portugues"
            .ReadOnly      = .T.
            WITH .Header1
                .Caption   = "Portugu" + CHR(234) + "s"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
            ENDWITH
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3
            .Width         = 427
            .FontSize      = 8
            .ControlSource = "cursor_4c_Produtos.Traduzido"
            .ReadOnly      = .T.
            WITH .Header1
                .Caption   = "Traduzido"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 2
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE VincularEventos()
    *==========================================================================
        BINDEVENT(THIS.txt_4c_CProsI,        "KeyPress", THIS, "TxtCProsIKeyPress")
        BINDEVENT(THIS.txt_4c_CProsI,        "DblClick", THIS, "TxtCProsIDblClick")
        BINDEVENT(THIS.txt_4c_CProsF,        "KeyPress", THIS, "TxtCProsFKeyPress")
        BINDEVENT(THIS.txt_4c_CProsF,        "DblClick", THIS, "TxtCProsFDblClick")
        BINDEVENT(THIS.txt_4c_CGrus,         "KeyPress", THIS, "TxtCGrusKeyPress")
        BINDEVENT(THIS.txt_4c_CGrus,         "DblClick", THIS, "TxtCGrusDblClick")
        BINDEVENT(THIS.cmd_4c_BtnSelecionar, "Click",    THIS, "BtnSelecionarClick")
        BINDEVENT(THIS.cmd_4c_BtnAtualizar,  "Click",    THIS, "BtnAtualizarClick")
        BINDEVENT(THIS.cmd_4c_BtnSair,       "Click",    THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    PROCEDURE TxtCProsIKeyPress
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaProduto("CProsI")
    ENDPROC

    *==========================================================================
    PROCEDURE TxtCProsFKeyPress
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaProduto("CProsF")
    ENDPROC

    *==========================================================================
    PROCEDURE TxtCGrusKeyPress
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaGrupo()
    ENDPROC

    *==========================================================================
    PROCEDURE TxtCProsIDblClick()
    *==========================================================================
        IF THIS.txt_4c_CProsI.Enabled
            THIS.AbrirPickerProduto("CProsI")
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE TxtCProsFDblClick()
    *==========================================================================
        IF THIS.txt_4c_CProsF.Enabled
            THIS.AbrirPickerProduto("CProsF")
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE TxtCGrusDblClick()
    *==========================================================================
        IF THIS.txt_4c_CGrus.Enabled
            THIS.AbrirPickerGrupo()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaProduto(par_cCampo)
    *==========================================================================
        LOCAL loc_cVal, loc_cSQL, loc_lEncontrou, loc_cCodigo
        LOCAL loc_oBusca, loc_oErro
        loc_lEncontrou = .F.
        loc_cCodigo    = ""

        DO CASE
            CASE par_cCampo = "CProsI"
                loc_cVal = ALLTRIM(THIS.txt_4c_CProsI.Value)
            CASE par_cCampo = "CProsF"
                loc_cVal = ALLTRIM(THIS.txt_4c_CProsF.Value)
            OTHERWISE
                loc_cVal = ""
        ENDCASE

        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        *-- Tenta match exato primeiro
        loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE RTRIM(CPros) = " + ;
                   EscaparSQL(loc_cVal)
        IF USED("cursor_4c_BuscaProTmp")
            USE IN cursor_4c_BuscaProTmp
        ENDIF
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProTmp") > 0 AND ;
           !EOF("cursor_4c_BuscaProTmp")
            SELECT cursor_4c_BuscaProTmp
            loc_cCodigo    = ALLTRIM(CPros)
            loc_lEncontrou = .T.
        ENDIF
        IF USED("cursor_4c_BuscaProTmp")
            USE IN cursor_4c_BuscaProTmp
        ENDIF

        IF !loc_lEncontrou
            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cVal, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CGrus", "", "Grupo")
                    loc_oBusca.Show()
                    IF USED("cursor_4c_BuscaPro") AND loc_oBusca.this_lSelecionou
                        SELECT cursor_4c_BuscaPro
                        loc_cCodigo    = ALLTRIM(CPros)
                        loc_lEncontrou = .T.
                    ENDIF
                    IF USED("cursor_4c_BuscaPro")
                        USE IN cursor_4c_BuscaPro
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro na busca de produto: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        IF loc_lEncontrou
            DO CASE
                CASE par_cCampo = "CProsI"
                    THIS.txt_4c_CProsI.Value = loc_cCodigo
                    THIS.txt_4c_CProsI.Refresh
                    IF EMPTY(THIS.txt_4c_CProsF.Value)
                        THIS.txt_4c_CProsF.Value = loc_cCodigo
                        THIS.txt_4c_CProsF.Refresh
                    ENDIF
                    THIS.txt_4c_CGrus.Value = ""
                    THIS.txt_4c_CGrus.Refresh
                CASE par_cCampo = "CProsF"
                    THIS.txt_4c_CProsF.Value = loc_cCodigo
                    THIS.txt_4c_CProsF.Refresh
                    IF EMPTY(THIS.txt_4c_CProsI.Value)
                        THIS.txt_4c_CProsI.Value = loc_cCodigo
                        THIS.txt_4c_CProsI.Refresh
                    ENDIF
                    THIS.txt_4c_CGrus.Value = ""
                    THIS.txt_4c_CGrus.Refresh
            ENDCASE
        ENDIF

        THIS.AtualizarEstadoFiltros()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaGrupo()
    *==========================================================================
        LOCAL loc_cVal, loc_cSQL, loc_lEncontrou, loc_cCodigo
        LOCAL loc_oBusca, loc_oErro
        loc_lEncontrou = .F.
        loc_cCodigo    = ""

        loc_cVal = ALLTRIM(THIS.txt_4c_CGrus.Value)
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF

        *-- Tenta match exato primeiro
        loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdGrp WHERE RTRIM(CGrus) = " + ;
                   EscaparSQL(loc_cVal)
        IF USED("cursor_4c_BuscaGruTmp")
            USE IN cursor_4c_BuscaGruTmp
        ENDIF
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGruTmp") > 0 AND ;
           !EOF("cursor_4c_BuscaGruTmp")
            SELECT cursor_4c_BuscaGruTmp
            loc_cCodigo    = ALLTRIM(CGrus)
            loc_lEncontrou = .T.
        ENDIF
        IF USED("cursor_4c_BuscaGruTmp")
            USE IN cursor_4c_BuscaGruTmp
        ENDIF

        IF !loc_lEncontrou
            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGrp", "cursor_4c_BuscaGru", "CGrus", loc_cVal, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Grupo", .T., .T., "")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF USED("cursor_4c_BuscaGru") AND loc_oBusca.this_lSelecionou
                        SELECT cursor_4c_BuscaGru
                        loc_cCodigo    = ALLTRIM(CGrus)
                        loc_lEncontrou = .T.
                    ENDIF
                    IF USED("cursor_4c_BuscaGru")
                        USE IN cursor_4c_BuscaGru
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro na busca de grupo: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        IF loc_lEncontrou
            THIS.txt_4c_CGrus.Value = loc_cCodigo
            THIS.txt_4c_CGrus.Refresh
            THIS.txt_4c_CProsI.Value = ""
            THIS.txt_4c_CProsI.Refresh
            THIS.txt_4c_CProsF.Value = ""
            THIS.txt_4c_CProsF.Refresh
        ENDIF

        THIS.AtualizarEstadoFiltros()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirPickerProduto(par_cCampo)
    *  Abre FormBuscaAuxiliar para SigCdPro diretamente (para DblClick).
    *  Nao tenta match exato - exibe o picker com o valor atual como prefixo.
    *==========================================================================
        LOCAL loc_cVal, loc_cCodigo, loc_oBusca, loc_oErro
        loc_cCodigo = ""

        DO CASE
            CASE par_cCampo = "CProsI"
                loc_cVal = ALLTRIM(THIS.txt_4c_CProsI.Value)
            CASE par_cCampo = "CProsF"
                loc_cVal = ALLTRIM(THIS.txt_4c_CProsF.Value)
            OTHERWISE
                loc_cVal = ""
        ENDCASE

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProDbl", "CPros", loc_cVal, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("CGrus", "", "Grupo")
                loc_oBusca.Show()
                IF USED("cursor_4c_BuscaProDbl") AND loc_oBusca.this_lSelecionou
                    SELECT cursor_4c_BuscaProDbl
                    loc_cCodigo = ALLTRIM(CPros)
                    DO CASE
                        CASE par_cCampo = "CProsI"
                            THIS.txt_4c_CProsI.Value = loc_cCodigo
                            THIS.txt_4c_CProsI.Refresh
                            IF EMPTY(THIS.txt_4c_CProsF.Value)
                                THIS.txt_4c_CProsF.Value = loc_cCodigo
                                THIS.txt_4c_CProsF.Refresh
                            ENDIF
                            THIS.txt_4c_CGrus.Value = ""
                            THIS.txt_4c_CGrus.Refresh
                        CASE par_cCampo = "CProsF"
                            THIS.txt_4c_CProsF.Value = loc_cCodigo
                            THIS.txt_4c_CProsF.Refresh
                            IF EMPTY(THIS.txt_4c_CProsI.Value)
                                THIS.txt_4c_CProsI.Value = loc_cCodigo
                                THIS.txt_4c_CProsI.Refresh
                            ENDIF
                            THIS.txt_4c_CGrus.Value = ""
                            THIS.txt_4c_CGrus.Refresh
                    ENDCASE
                ENDIF
                IF USED("cursor_4c_BuscaProDbl")
                    USE IN cursor_4c_BuscaProDbl
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de produto: " + loc_oErro.Message, "Erro")
        ENDTRY

        THIS.AtualizarEstadoFiltros()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirPickerGrupo()
    *  Abre FormBuscaAuxiliar para SigCdGrp diretamente (para DblClick).
    *==========================================================================
        LOCAL loc_cVal, loc_cCodigo, loc_oBusca, loc_oErro
        loc_cVal    = ALLTRIM(THIS.txt_4c_CGrus.Value)
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGruDbl", "CGrus", loc_cVal, ;
                "Sele" + CHR(231) + CHR(227) + "o de Grupo", .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF USED("cursor_4c_BuscaGruDbl") AND loc_oBusca.this_lSelecionou
                    SELECT cursor_4c_BuscaGruDbl
                    loc_cCodigo = ALLTRIM(CGrus)
                    THIS.txt_4c_CGrus.Value = loc_cCodigo
                    THIS.txt_4c_CGrus.Refresh
                    THIS.txt_4c_CProsI.Value = ""
                    THIS.txt_4c_CProsI.Refresh
                    THIS.txt_4c_CProsF.Value = ""
                    THIS.txt_4c_CProsF.Refresh
                ENDIF
                IF USED("cursor_4c_BuscaGruDbl")
                    USE IN cursor_4c_BuscaGruDbl
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro na busca de grupo: " + loc_oErro.Message, "Erro")
        ENDTRY

        THIS.AtualizarEstadoFiltros()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSelecionarClick()
    *==========================================================================
        THIS.cmd_4c_BtnAtualizar.Enabled = .F.

        IF EMPTY(THIS.txt_4c_CProsI.Value) AND ;
           EMPTY(THIS.txt_4c_CProsF.Value) AND ;
           EMPTY(THIS.txt_4c_CGrus.Value)
            MsgAviso("Nenhum filtro foi informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_CProsI.SetFocus
            RETURN
        ENDIF

        IF !EMPTY(THIS.txt_4c_CProsI.Value) AND EMPTY(THIS.txt_4c_CProsF.Value)
            THIS.txt_4c_CProsF.Value = THIS.txt_4c_CProsI.Value
            THIS.txt_4c_CProsF.Refresh
        ENDIF

        IF EMPTY(THIS.txt_4c_CProsI.Value) AND !EMPTY(THIS.txt_4c_CProsF.Value)
            THIS.txt_4c_CProsI.Value = THIS.txt_4c_CProsF.Value
            THIS.txt_4c_CProsI.Refresh
        ENDIF

        THIS.AtualizarEstadoFiltros()
        THIS.Processamento()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAtualizarClick()
    *==========================================================================
        THIS.Gravacao()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSairClick()
    *==========================================================================
        THIS.Release
    ENDPROC

    *==========================================================================
    * Eventos CRUD ??? Compatibilidade de API (form OPERACIONAL de processamento
    * em lote de descricoes de produtos). SigPrDsc nao tem CRUD tradicional:
    * o fluxo eh Selecionar (filtrar) -> editar descricoes na grade -> Atualizar
    * (gravar). Estes metodos redirecionam para as operacoes equivalentes.
    *==========================================================================

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *  OPERACIONAL: nao ha "incluir registro". Prepara nova selecao limpando
    *  filtros e cursor para o proximo ciclo de trabalho.
    *==========================================================================
        THIS.txt_4c_CProsI.Value = ""
        THIS.txt_4c_CProsF.Value = ""
        THIS.txt_4c_CGrus.Value = ""
        THIS.txt_4c_CProsI.Refresh
        THIS.txt_4c_CProsF.Refresh
        THIS.txt_4c_CGrus.Refresh

        IF USED("cursor_4c_Produtos")
            ZAP IN cursor_4c_Produtos
        ENDIF

        THIS.AtualizarEstadoFiltros()
        THIS.cmd_4c_BtnAtualizar.Enabled = .F.
        THIS.txt_4c_CProsI.SetFocus
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *  OPERACIONAL: a "alteracao" das descricoes eh persistida via Atualizar
    *  (Gravacao). Delega para o botao Atualizar quando ha dados carregados.
    *==========================================================================
        IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
            MsgAviso("Selecione produtos com o bot" + CHR(227) + "o Selecionar " + ;
                     "antes de alterar as descri" + CHR(231) + CHR(245) + "es.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        THIS.BtnAtualizarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *  OPERACIONAL: a "visualizacao" corresponde a rodar o filtro para carregar
    *  a grade com os produtos e suas descricoes atuais. Delega para Selecionar.
    *==========================================================================
        THIS.BtnSelecionarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *  OPERACIONAL: nao ha "exclusao de registro" (nao remove produto do banco).
    *  Limpa o cursor de produtos descartando edicoes nao gravadas.
    *==========================================================================
        IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " produtos carregados para descartar.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF MsgConfirma("Descartar as altera" + CHR(231) + CHR(245) + "es pendentes " + ;
                       "e limpar a lista de produtos?", ;
                       "Confirma" + CHR(231) + CHR(227) + "o")
            ZAP IN cursor_4c_Produtos
            THIS.grd_4c_Dados.Refresh
            THIS.cmd_4c_BtnAtualizar.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    *  Compatibilidade de API: form OPERACIONAL usa layout flat (sem PageFrame)
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *  Compatibilidade de API: delega para BtnSelecionarClick (selecionar produtos)
    *==========================================================================
        THIS.BtnSelecionarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *  Compatibilidade de API: delega para BtnSairClick (encerrar form)
    *==========================================================================
        THIS.BtnSairClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick()
    *  Compatibilidade de API: delega para BtnAtualizarClick (gravar descricoes)
    *==========================================================================
        THIS.BtnAtualizarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *  Compatibilidade de API: aborta operacao em curso, limpa cursor e campos
    *==========================================================================
        IF USED("cursor_4c_Produtos")
            ZAP IN cursor_4c_Produtos
        ENDIF
        THIS.LimparCampos()
        THIS.cmd_4c_BtnAtualizar.Enabled = .F.
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE FormParaBO()
    *  Transfere valores dos campos de filtro para as propriedades do BO
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.this_oBusinessObject.this_cCProsI = ALLTRIM(THIS.txt_4c_CProsI.Value)
        THIS.this_oBusinessObject.this_cCProsF = ALLTRIM(THIS.txt_4c_CProsF.Value)
        THIS.this_oBusinessObject.this_cCGrus  = ALLTRIM(THIS.txt_4c_CGrus.Value)
    ENDPROC

    *==========================================================================
    PROCEDURE BOParaForm()
    *  Recarrega campos de filtro a partir das propriedades do BO
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.txt_4c_CProsI.Value = THIS.this_oBusinessObject.this_cCProsI
        THIS.txt_4c_CProsF.Value = THIS.this_oBusinessObject.this_cCProsF
        THIS.txt_4c_CGrus.Value  = THIS.this_oBusinessObject.this_cCGrus
        THIS.txt_4c_CProsI.Refresh
        THIS.txt_4c_CProsF.Refresh
        THIS.txt_4c_CGrus.Refresh
        THIS.AtualizarEstadoFiltros()
    ENDPROC

    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
    *  Habilita ou desabilita os campos de filtro.
    *  Quando par_lHabilitar=.F. (modo visualizacao), bloqueia edicao.
    *  Quando .T., restaura exclusividade mutua via AtualizarEstadoFiltros.
    *==========================================================================
        IF par_lHabilitar
            THIS.AtualizarEstadoFiltros()
        ELSE
            THIS.txt_4c_CProsI.Enabled = .F.
            THIS.txt_4c_CProsF.Enabled = .F.
            THIS.txt_4c_CGrus.Enabled  = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE LimparCampos()
    *  Limpa todos os campos de filtro e redefine estado dos controles
    *==========================================================================
        THIS.txt_4c_CProsI.Value = ""
        THIS.txt_4c_CProsF.Value = ""
        THIS.txt_4c_CGrus.Value  = ""
        THIS.txt_4c_CProsI.Refresh
        THIS.txt_4c_CProsF.Refresh
        THIS.txt_4c_CGrus.Refresh
        THIS.AtualizarEstadoFiltros()
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *  Compatibilidade de API: para OPERACIONAL o carregamento e disparado
    *  manualmente via BtnSelecionarClick. Este metodo apenas atualiza o grid.
    *==========================================================================
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
    *  Compatibilidade de API: gerencia estado dos botoes conforme dados carregados.
    *  Atualizar fica habilitado somente quando ha produtos processados no cursor.
    *==========================================================================
        LOCAL loc_lTemProdutos
        loc_lTemProdutos = USED("cursor_4c_Produtos") AND ;
                           RECCOUNT("cursor_4c_Produtos") > 0

        THIS.cmd_4c_BtnAtualizar.Enabled = loc_lTemProdutos
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Processamento()
    *  Monta descricoes de produtos usando SigCdGrp + SigCdCor e traduz com SigCdDic
    *==========================================================================
        LOCAL loc_cSQL, loc_cGru, loc_cPrI, loc_cPrF
        LOCAL loc_cPro, loc_cDes, loc_cIng, loc_cIni, loc_nGrD
        LOCAL loc_oProg, loc_nRecs, loc_oErro

        ZAP IN cursor_4c_Produtos

        loc_cGru = ALLTRIM(THIS.txt_4c_CGrus.Value)
        loc_cPrI = PADR(ALLTRIM(THIS.txt_4c_CProsI.Value), 14)
        loc_cPrF = PADR(ALLTRIM(THIS.txt_4c_CProsF.Value), 14)

        IF !EMPTY(loc_cGru)
            loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                       "WHERE CGrus = " + EscaparSQL(PADR(loc_cGru, 3)) + ;
                       " ORDER BY CPros"
        ELSE
            loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                       "WHERE CPros BETWEEN " + EscaparSQL(loc_cPrI) + ;
                       " AND " + EscaparSQL(loc_cPrF) + ;
                       " ORDER BY CPros"
        ENDIF

        IF USED("cursor_4c_PrdTraduz")
            USE IN cursor_4c_PrdTraduz
        ENDIF

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrdTraduz") < 1
            MsgErro("Falha ao carregar produtos.", "Erro")
            RETURN
        ENDIF

        loc_nRecs = RECCOUNT("cursor_4c_PrdTraduz")
        IF loc_nRecs = 0
            MsgAviso("Nenhum produto encontrado com os filtros informados.", "Aviso")
            USE IN cursor_4c_PrdTraduz
            RETURN
        ENDIF

        loc_oProg = .NULL.
        TRY
            loc_oProg = CREATEOBJECT("fwprogressbar", ;
                "Processando Tradu" + CHR(231) + CHR(245) + "es...", loc_nRecs)
            IF VARTYPE(loc_oProg) = "O"
                loc_oProg.Show
            ENDIF
        CATCH TO loc_oErro
            loc_oProg = .NULL.
        ENDTRY

        SELECT cursor_4c_PrdTraduz
        GO TOP
        SCAN
            loc_cPro = ALLTRIM(cursor_4c_PrdTraduz.CPros)
            loc_cDes = ""
            loc_cIni = ""
            loc_nGrD = 0

            IF VARTYPE(loc_oProg) = "O"
                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)
            ENDIF

            IF !EMPTY(loc_cPro)
                *-- Busca descricao do grupo e cor do produto
                loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, b.DGrus, " + ;
                           "b.Mercs, b.MontaGrDs, c.Descs " + ;
                           "FROM SigCdPro a " + ;
                           "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
                           "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
                           "WHERE a.CPros = " + EscaparSQL(loc_cPro)

                IF USED("cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") > 0 AND ;
                   !EOF("cursor_4c_LocalPro")
                    SELECT cursor_4c_LocalPro
                    loc_cIni = ALLTRIM(NVL(DGrus, "")) + " " + ALLTRIM(NVL(Descs, ""))
                    loc_cIni = ALLTRIM(loc_cIni)
                    loc_nGrD = NVL(MontaGrDs, 0)
                ENDIF

                IF USED("cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF

                *-- Usa descricao montada quando MontaGrDs=1 (flag de montagem)
                IF loc_nGrD != 0 AND !EMPTY(loc_cIni)
                    loc_cDes = loc_cIni
                ENDIF

                IF !EMPTY(loc_cDes)
                    *-- Traduz para ingles usando SigCdDic (ordenado por expressao mais longa)
                    loc_cIng = loc_cDes

                    IF USED("cursor_4c_Dicionario")
                        SELECT cursor_4c_Dicionario
                        GO TOP
                        SCAN
                            loc_cIng = STRTRAN(loc_cIng, ;
                                ALLTRIM(cursor_4c_Dicionario.Expressao), ;
                                ALLTRIM(cursor_4c_Dicionario.Traducao))
                        ENDSCAN
                    ENDIF

                    *-- Remove aspas simples/duplas para evitar problemas no SQL futuro
                    loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
                    loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")

                    *-- Insere no cursor (APPEND BLANK seguro para campos memo)
                    SELECT cursor_4c_Produtos
                    APPEND BLANK
                    REPLACE cursor_4c_Produtos.CPros      WITH loc_cPro, ;
                            cursor_4c_Produtos.Portugues  WITH loc_cDes, ;
                            cursor_4c_Produtos.Traduzido  WITH loc_cIng, ;
                            cursor_4c_Produtos.DscCompras WITH loc_cIng, ;
                            cursor_4c_Produtos.ObsCompras WITH loc_cDes
                ENDIF
            ENDIF

            *-- Restaura contexto do SCAN externo
            SELECT cursor_4c_PrdTraduz
            THIS.grd_4c_Dados.Refresh
        ENDSCAN

        IF USED("cursor_4c_PrdTraduz")
            USE IN cursor_4c_PrdTraduz
        ENDIF

        IF VARTYPE(loc_oProg) = "O"
            loc_oProg.Complete
        ENDIF

        SELECT cursor_4c_Produtos
        GO TOP
        IF !EOF("cursor_4c_Produtos")
            THIS.cmd_4c_BtnAtualizar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Gravacao()
    *  Grava descricoes: UPDATE SigCdPro + DELETE SigPrPrt por produto
    *==========================================================================
        LOCAL loc_lOk, loc_cPro, loc_cSQL, loc_oProg, loc_nRecs
        LOCAL loc_nResult, loc_oErro
        loc_lOk = .T.

        SELECT cursor_4c_Produtos
        loc_nRecs = RECCOUNT("cursor_4c_Produtos")

        IF loc_nRecs = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                     " produtos para gravar.", "Aviso")
            RETURN
        ENDIF

        loc_oProg = .NULL.
        TRY
            loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nRecs)
            IF VARTYPE(loc_oProg) = "O"
                loc_oProg.Show
            ENDIF
        CATCH TO loc_oErro
            loc_oProg = .NULL.
        ENDTRY

        SELECT cursor_4c_Produtos
        GO TOP
        SCAN WHILE loc_lOk
            loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)

            IF VARTYPE(loc_oProg) = "O"
                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)
            ENDIF

            *-- UPDATE SigCdPro: DscCompras, ObsCompras, DPros
            loc_cSQL = "UPDATE SigCdPro " + ;
                       "SET DscCompras = " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Produtos.DscCompras)) + ", " + ;
                       "ObsCompras = " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Produtos.ObsCompras)) + ", " + ;
                       "DPros = " + ;
                           EscaparSQL(PADR(ALLTRIM(cursor_4c_Produtos.Portugues), 40)) + ;
                       " WHERE CPros = " + EscaparSQL(loc_cPro)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 1
                MsgErro("Falha ao gravar produto " + loc_cPro + " em SigCdPro.", "Erro")
                loc_lOk = .F.
                LOOP
            ENDIF

            *-- DELETE FROM SigPrPrt (remove produto da fila de processamento)
            loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cPro)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 1
                MsgErro("Falha ao remover produto " + loc_cPro + " de SigPrPrt.", "Erro")
                loc_lOk = .F.
            ENDIF
        ENDSCAN

        IF VARTYPE(loc_oProg) = "O"
            loc_oProg.Complete
        ENDIF

        IF loc_lOk
            MsgInfo("Foram gravados " + ALLTRIM(STR(loc_nRecs)) + " produtos!", ;
                    "Processamento Conclu" + CHR(237) + "do!")
        ELSE
            MsgAviso("Ocorreu um erro com a grava" + CHR(231) + CHR(227) + ;
                     "o dos produtos.", "Processamento Cancelado!")
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *  Fase 5/8: Configura o estado inicial de habilitacao dos campos de filtro.
    *  Replica o comportamento "When" do legado que controlava exclusividade mutua:
    *    - getCProsI/getCProsF: When = Empty(getCGrus.Value)
    *    - getCGrus: When = Empty(getCProsI.Value) And Empty(getCProsF.Value)
    *  Estado inicial: todos habilitados (form recem-aberto, sem valores preenchidos).
    *==========================================================================
        THIS.txt_4c_CProsI.Enabled = .T.
        THIS.txt_4c_CProsF.Enabled = .T.
        THIS.txt_4c_CGrus.Enabled  = .T.
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarEstadoFiltros()
    *  Aplica exclusividade mutua entre grupos de filtro apos qualquer mudanca:
    *    - Se CGrus tem valor: desabilita CProsI e CProsF
    *    - Se CProsI ou CProsF tem valor: desabilita CGrus
    *    - Se todos vazios: habilita todos
    *  Chamado apos AbrirBuscaProduto, AbrirBuscaGrupo e BtnSelecionarClick.
    *==========================================================================
        LOCAL loc_lTemCGrus, loc_lTemCPros
        loc_lTemCGrus = !EMPTY(ALLTRIM(THIS.txt_4c_CGrus.Value))
        loc_lTemCPros = !EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value)) OR ;
                        !EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))

        THIS.txt_4c_CProsI.Enabled = !loc_lTemCGrus
        THIS.txt_4c_CProsF.Enabled = !loc_lTemCGrus
        THIS.txt_4c_CGrus.Enabled  = !loc_lTemCPros
    ENDPROC

ENDDEFINE
