*==============================================================================
* FORMSIGRECPM.PRG
* Relat" + CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o por OP (SIGRECPM)
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECPM.SCX (frmrelatorio)
*
* Estrutura:
*   - Cabecalho escuro (cnt_4c_Cabecalho)
*   - CommandGroup botoes (cmg_4c_Botoes): Visualizar/Imprimir/Excel/Encerrar
*   - PageFrame (pgf_4c_Paginas): 1 pagina de filtros
*
* Tabelas: SigCdNei, SigCdNec, SigCdPro, SigOpPic, SigPdMvf, SigCdEmp
* FRX Analitico: SigReCPM.frx
* FRX Sintetico: SigReC2P.frx
*==============================================================================

DEFINE CLASS FormSIGRECPM AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=350)
    Height      = 350
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
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria SIGRECPMBO e valida instancia
    *   3. Monta cabecalho escuro + botoes + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGRECPMBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGRECPMBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaDados()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

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
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Width = THIS.Width para cobrir toda a faixa superior (nunca THIS.Width-60).
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
                .Caption   = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP"
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
                .Caption   = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP"
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
    * ConfigurarBotoes - CommandGroup de botoes de relatorio (btnReport area)
    *   Geometria EXATA do framework frmrelatorio:
    *     cmg_4c_Botoes: Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *   Lefts dos botoes: Buttons(1)=5, (2)=71, (3)=137, (4)=203
    *   Eventos Click vinculados nas fases seguintes (Fase 7).
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

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Posicionado logo abaixo do cabecalho (top=85) ate o limite inferior.
    *   Controles de filtro sao adicionados em ConfigurarPaginaLista (Fase 5).
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
    * ConfigurarPaginaDados - Adiciona controles de filtro na Page1
    *   Em forms REPORT (frmrelatorio) o layout e flat: nao ha Page de Lista
    *   nem Page de Dados separadas. Todos os filtros ficam em uma unica Page1.
    *   O nome ConfigurarPaginaDados segue a conv. do pipeline de migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            *-- Linha 1: Periodo
            loc_oPag.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPag.lbl_4c_Label1
                .Top       = 12
                .Left      = 219
                .Width     = 50
                .Height    = 18
                .Caption   = "Per" + CHR(237) + "odo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DtInicial", "TextBox")
            WITH loc_oPag.txt_4c_DtInicial
                .Top           = 8
                .Left          = 267
                .Width         = 80
                .Height        = 25
                .Value         = {}
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPag.lbl_4c_Label6
                .Top       = 13
                .Left      = 355
                .Width     = 20
                .Height    = 18
                .Caption   = "at" + CHR(233)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DtFinal", "TextBox")
            WITH loc_oPag.txt_4c_DtFinal
                .Top           = 8
                .Left          = 381
                .Width         = 80
                .Height        = 25
                .Value         = {}
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 2: Empresa
            loc_oPag.AddObject("lbl_4c_Lbl_empresa", "Label")
            WITH loc_oPag.lbl_4c_Lbl_empresa
                .Top       = 39
                .Left      = 214
                .Width     = 50
                .Height    = 18
                .Caption   = "Empresa :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Empresa", "TextBox")
            WITH loc_oPag.txt_4c_Empresa
                .Top           = 35
                .Left          = 267
                .Width         = 31
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DEmpresa", "TextBox")
            WITH loc_oPag.txt_4c_DEmpresa
                .Top           = 35
                .Left          = 300
                .Width         = 339
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 3: Movimentacao / Faixa de numeros
            loc_oPag.AddObject("lbl_4c_Lbl_dopes", "Label")
            WITH loc_oPag.lbl_4c_Lbl_dopes
                .Top       = 66
                .Left      = 186
                .Width     = 78
                .Height    = 18
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_Operacao", "TextBox")
            WITH loc_oPag.txt_4c_Operacao
                .Top           = 62
                .Left          = 267
                .Width         = 184
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_LblDe", "Label")
            WITH loc_oPag.lbl_4c_LblDe
                .Top       = 67
                .Left      = 475
                .Width     = 21
                .Height    = 15
                .Caption   = "de :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_OperacaoI", "TextBox")
            WITH loc_oPag.txt_4c_OperacaoI
                .Top           = 62
                .Left          = 500
                .Width         = 55
                .Height        = 25
                .Value         = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPag.lbl_4c_Label9
                .Top       = 67
                .Left      = 561
                .Width     = 18
                .Height    = 15
                .Caption   = "at" + CHR(233)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_OperacaoF", "TextBox")
            WITH loc_oPag.txt_4c_OperacaoF
                .Top           = 62
                .Left          = 584
                .Width         = 55
                .Height        = 25
                .Value         = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 4: Grupo Origem
            loc_oPag.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPag.lbl_4c_Label5
                .Top       = 93
                .Left      = 189
                .Width     = 75
                .Height    = 18
                .Caption   = "Grupo Origem :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_GrOrigem", "TextBox")
            WITH loc_oPag.txt_4c_GrOrigem
                .Top           = 89
                .Left          = 267
                .Width         = 80
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DsGrOrigem", "TextBox")
            WITH loc_oPag.txt_4c_DsGrOrigem
                .Top           = 89
                .Left          = 350
                .Width         = 312
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 5: Conta Origem
            loc_oPag.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPag.lbl_4c_Label2
                .Top       = 120
                .Left      = 189
                .Width     = 75
                .Height    = 18
                .Caption   = "Conta Origem :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_ContaO", "TextBox")
            WITH loc_oPag.txt_4c_ContaO
                .Top           = 116
                .Left          = 267
                .Width         = 80
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DContaO", "TextBox")
            WITH loc_oPag.txt_4c_DContaO
                .Top           = 116
                .Left          = 350
                .Width         = 312
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 6: Grupo Destino
            loc_oPag.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPag.lbl_4c_Label7
                .Top       = 147
                .Left      = 187
                .Width     = 77
                .Height    = 18
                .Caption   = "Grupo Destino :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_GrDestino", "TextBox")
            WITH loc_oPag.txt_4c_GrDestino
                .Top           = 143
                .Left          = 267
                .Width         = 80
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DsGrDestino", "TextBox")
            WITH loc_oPag.txt_4c_DsGrDestino
                .Top           = 143
                .Left          = 350
                .Width         = 312
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 7: Conta Destino
            loc_oPag.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPag.lbl_4c_Label4
                .Top       = 174
                .Left      = 187
                .Width     = 77
                .Height    = 18
                .Caption   = "Conta Destino :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_ContaD", "TextBox")
            WITH loc_oPag.txt_4c_ContaD
                .Top           = 170
                .Left          = 267
                .Width         = 80
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_DContaD", "TextBox")
            WITH loc_oPag.txt_4c_DContaD
                .Top           = 170
                .Left          = 350
                .Width         = 312
                .Height        = 25
                .Value         = ""
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 8: O.P.
            loc_oPag.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPag.lbl_4c_Label3
                .Top       = 201
                .Left      = 233
                .Width     = 31
                .Height    = 15
                .Caption   = "O.P. :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("txt_4c_OP", "TextBox")
            WITH loc_oPag.txt_4c_OP
                .Top           = 197
                .Left          = 267
                .Width         = 86
                .Height        = 25
                .Value         = 0
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(0, 0, 128)
                .Visible       = .T.
            ENDWITH

            *-- Linha 9: Tipo de relatorio
            loc_oPag.AddObject("lbl_4c_LblTipo", "Label")
            WITH loc_oPag.lbl_4c_LblTipo
                .Top       = 226
                .Left      = 235
                .Width     = 29
                .Height    = 15
                .Caption   = "Tipo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
            WITH loc_oPag.obj_4c_Opt_Tipo
                .Top         = 223
                .Left        = 262
                .Width       = 175
                .Height      = 25
                .ButtonCount = 2
                .Value       = 1
                .BackStyle   = 0
                .BorderStyle = 0
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "Anal" + CHR(237) + "tico"
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .Left    = 0
                    .Top     = 0
                    .Width   = 80
                    .Height  = 25
                ENDWITH
                WITH .Buttons(2)
                    .Caption  = "Sint" + CHR(233) + "tico"
                    .Left     = 90
                    .Top      = 0
                    .Width    = 80
                    .Height   = 25
                    .FontName = "Comic Sans MS"
                    .FontSize = 8
                    .Visible  = .T.
                ENDWITH
            ENDWITH

            *-- Container Aguarde (oculto ate o processamento)
            loc_oPag.AddObject("cnt_4c_Aguarde", "Container")
            WITH loc_oPag.cnt_4c_Aguarde
                .Top         = 83
                .Left        = 312
                .Width       = 207
                .Height      = 49
                .BackStyle   = 1
                .BackColor   = RGB(255, 255, 200)
                .BorderWidth = 1
                .Visible     = .F.

                .AddObject("lbl_4c_Label1", "Label")
                WITH .lbl_4c_Label1
                    .Top       = 7
                    .Left      = 69
                    .Width     = 68
                    .Height    = 18
                    .Caption   = "Aguarde..."
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Label2", "Label")
                WITH .lbl_4c_Label2
                    .Top       = 24
                    .Left      = 24
                    .Width     = 141
                    .Height    = 18
                    .Caption   = "Processando Dados..."
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .F.
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- BINDEVENTs para campos com lookup
            BINDEVENT(loc_oPag.txt_4c_Empresa,     "KeyPress", THIS, "TeclaEmpresa")
            BINDEVENT(loc_oPag.txt_4c_Empresa,     "DblClick", THIS, "AbrirBuscaEmpresa")
            BINDEVENT(loc_oPag.txt_4c_DEmpresa,    "KeyPress", THIS, "TeclaDEmpresa")
            BINDEVENT(loc_oPag.txt_4c_Operacao,    "KeyPress", THIS, "TeclaOperacao")
            BINDEVENT(loc_oPag.txt_4c_Operacao,    "DblClick", THIS, "AbrirBuscaOperacao")
            BINDEVENT(loc_oPag.txt_4c_OperacaoI,   "KeyPress", THIS, "TeclaOperacaoI")
            BINDEVENT(loc_oPag.txt_4c_GrOrigem,    "KeyPress", THIS, "TeclaGrOrigem")
            BINDEVENT(loc_oPag.txt_4c_GrOrigem,    "DblClick", THIS, "AbrirBuscaGrOrigem")
            BINDEVENT(loc_oPag.txt_4c_DsGrOrigem,  "KeyPress", THIS, "TeclaDsGrOrigem")
            BINDEVENT(loc_oPag.txt_4c_ContaO,      "KeyPress", THIS, "TeclaContaO")
            BINDEVENT(loc_oPag.txt_4c_ContaO,      "DblClick", THIS, "AbrirBuscaContaO")
            BINDEVENT(loc_oPag.txt_4c_DContaO,     "KeyPress", THIS, "TeclaDContaO")
            BINDEVENT(loc_oPag.txt_4c_GrDestino,   "KeyPress", THIS, "TeclaGrDestino")
            BINDEVENT(loc_oPag.txt_4c_GrDestino,   "DblClick", THIS, "AbrirBuscaGrDestino")
            BINDEVENT(loc_oPag.txt_4c_DsGrDestino, "KeyPress", THIS, "TeclaDsGrDestino")
            BINDEVENT(loc_oPag.txt_4c_ContaD,      "KeyPress", THIS, "TeclaContaD")
            BINDEVENT(loc_oPag.txt_4c_ContaD,      "DblClick", THIS, "AbrirBuscaContaD")
            BINDEVENT(loc_oPag.txt_4c_DContaD,     "KeyPress", THIS, "TeclaDContaD")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores iniciais
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DtInicial.Value   = THIS.this_oRelatorio.this_dDtInicial
        loc_oPag.txt_4c_DtFinal.Value     = THIS.this_oRelatorio.this_dDtFinal
        loc_oPag.txt_4c_Empresa.Value     = ""
        loc_oPag.txt_4c_DEmpresa.Value    = ""
        loc_oPag.txt_4c_Operacao.Value    = ""
        loc_oPag.txt_4c_OperacaoI.Value   = 0
        loc_oPag.txt_4c_OperacaoF.Value   = 0
        loc_oPag.txt_4c_GrOrigem.Value    = ""
        loc_oPag.txt_4c_DsGrOrigem.Value  = ""
        loc_oPag.txt_4c_ContaO.Value      = ""
        loc_oPag.txt_4c_DContaO.Value     = ""
        loc_oPag.txt_4c_GrDestino.Value   = ""
        loc_oPag.txt_4c_DsGrDestino.Value = ""
        loc_oPag.txt_4c_ContaD.Value      = ""
        loc_oPag.txt_4c_DContaD.Value     = ""
        loc_oPag.txt_4c_OP.Value          = 0
        loc_oPag.obj_4c_Opt_Tipo.Value    = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere campos do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial   = loc_oPag.txt_4c_DtInicial.Value
            .this_dDtFinal     = loc_oPag.txt_4c_DtFinal.Value
            .this_cEmpresa     = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)
            .this_cDEmpresa    = ALLTRIM(loc_oPag.txt_4c_DEmpresa.Value)
            .this_cOperacao    = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)
            .this_nOperacaoI   = loc_oPag.txt_4c_OperacaoI.Value
            .this_nOperacaoF   = loc_oPag.txt_4c_OperacaoF.Value
            .this_cGrOrigem    = ALLTRIM(loc_oPag.txt_4c_GrOrigem.Value)
            .this_cDsGrOrigem  = ALLTRIM(loc_oPag.txt_4c_DsGrOrigem.Value)
            .this_cContaO      = ALLTRIM(loc_oPag.txt_4c_ContaO.Value)
            .this_cDContaO     = ALLTRIM(loc_oPag.txt_4c_DContaO.Value)
            .this_cGrDestino   = ALLTRIM(loc_oPag.txt_4c_GrDestino.Value)
            .this_cDsGrDestino = ALLTRIM(loc_oPag.txt_4c_DsGrDestino.Value)
            .this_cContaD      = ALLTRIM(loc_oPag.txt_4c_ContaD.Value)
            .this_cDContaD     = ALLTRIM(loc_oPag.txt_4c_DContaD.Value)
            .this_nOP          = loc_oPag.txt_4c_OP.Value
            .this_nTipo        = loc_oPag.obj_4c_Opt_Tipo.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - REPORT forms usam layout flat (1 pagina)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
           par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES (PUBLIC - obrigatorio para BINDEVENT)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - "Limpar filtros" em form de relatorio
    *   Em CRUD: prepara form para inclusao de novo registro.
    *   Em REPORT: restaura campos de filtro para os valores iniciais.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - "Visualizar" em form de relatorio
    *   Em CRUD: prepara form para alteracao do registro selecionado.
    *   Em REPORT: delega para BtnVisualizarClick (gera preview com filtros).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Operacao invalida em form de relatorio
    *   Em CRUD: exclui registro selecionado.
    *   Em REPORT: exibe aviso (relatorios nao permitem exclusao).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel neste relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPag
        THIS.FormParaRelatorio()
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.cnt_4c_Aguarde.Visible = .T.
        THIS.Refresh
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
        ENDIF
        loc_oPag.cnt_4c_Aguarde.Visible = .F.
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_oPag
        THIS.FormParaRelatorio()
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.cnt_4c_Aguarde.Visible = .T.
        THIS.Refresh
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
        ENDIF
        loc_oPag.cnt_4c_Aguarde.Visible = .F.
    ENDPROC

    PROCEDURE BtnExcelClick()
        MsgAviso("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + ;
            "o implementada neste relat" + CHR(243) + "rio.", "Excel")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * LOOKUPS DE EMPRESA (SigCdEmp: cemps / razas)
    *==========================================================================

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
            IF loc_nRes > 0
                SELECT cursor_4c_EmpVal
                IF !EOF()
                    loc_oPag.txt_4c_DEmpresa.Value = ALLTRIM(razas)
                    USE IN cursor_4c_EmpVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_EmpBusca", "cemps", loc_cValor, "Empresa")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_EmpBusca
            loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cemps)
            loc_oPag.txt_4c_DEmpresa.Value = ALLTRIM(razas)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("razas", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_EmpBusca
                loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cemps)
                loc_oPag.txt_4c_DEmpresa.Value = ALLTRIM(razas)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_EmpBusca")
            USE IN cursor_4c_EmpBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaDEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Empresa.Value))
                THIS.AbrirBuscaEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS DE OPERACAO (SigCdOpd: dopps)
    *==========================================================================

    PROCEDURE TeclaOperacao(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaOperacao()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaOperacao()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT dopps FROM SigCdOpd WHERE dopps = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpdVal")
            IF loc_nRes > 0
                SELECT cursor_4c_OpdVal
                IF !EOF()
                    USE IN cursor_4c_OpdVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_OpdVal")
                USE IN cursor_4c_OpdVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpd", "cursor_4c_OpdBusca", "dopps", loc_cValor, ;
            "Movimenta" + CHR(231) + CHR(227) + "o")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_OpdBusca
            loc_oPag.txt_4c_Operacao.Value = ALLTRIM(dopps)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("dopps", "", "Movimenta" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_OpdBusca
                loc_oPag.txt_4c_Operacao.Value = ALLTRIM(dopps)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_OpdBusca")
            USE IN cursor_4c_OpdBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaOperacaoI(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF loc_oPag.txt_4c_OperacaoI.Value <> 0 AND ;
               loc_oPag.txt_4c_OperacaoF.Value = 0
                loc_oPag.txt_4c_OperacaoF.Value = loc_oPag.txt_4c_OperacaoI.Value
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS DE GRUPO ORIGEM (SigCdGcr: codigos / descrs)
    *==========================================================================

    PROCEDURE TeclaGrOrigem(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaGrOrigem()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaGrOrigem()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_GrOrigem.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
            IF loc_nRes > 0
                SELECT cursor_4c_GcrVal
                IF !EOF()
                    loc_oPag.txt_4c_DsGrOrigem.Value = ALLTRIM(descrs)
                    USE IN cursor_4c_GcrVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_GcrVal")
                USE IN cursor_4c_GcrVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_GcrBuscaO", "codigos", loc_cValor, "Grupo")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_GcrBuscaO
            loc_oPag.txt_4c_GrOrigem.Value   = ALLTRIM(codigos)
            loc_oPag.txt_4c_DsGrOrigem.Value = ALLTRIM(descrs)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_GcrBuscaO
                loc_oPag.txt_4c_GrOrigem.Value   = ALLTRIM(codigos)
                loc_oPag.txt_4c_DsGrOrigem.Value = ALLTRIM(descrs)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_GcrBuscaO")
            USE IN cursor_4c_GcrBuscaO
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaDsGrOrigem(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_GrOrigem.Value))
                THIS.AbrirBuscaGrOrigem()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS DE CONTA ORIGEM (SigCdCli: IClis / Rclis)
    *==========================================================================

    PROCEDURE TeclaContaO(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaContaO()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaContaO()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_ContaO.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT IClis, Rclis FROM SigCdCli WHERE IClis = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaOVal")
            IF loc_nRes > 0
                SELECT cursor_4c_ContaOVal
                IF !EOF()
                    loc_oPag.txt_4c_DContaO.Value = ALLTRIM(Rclis)
                    USE IN cursor_4c_ContaOVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_ContaOVal")
                USE IN cursor_4c_ContaOVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_ContaOBusca", "IClis", loc_cValor, ;
            "Conta Origem")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_ContaOBusca
            loc_oPag.txt_4c_ContaO.Value  = ALLTRIM(IClis)
            loc_oPag.txt_4c_DContaO.Value = ALLTRIM(Rclis)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_ContaOBusca
                loc_oPag.txt_4c_ContaO.Value  = ALLTRIM(IClis)
                loc_oPag.txt_4c_DContaO.Value = ALLTRIM(Rclis)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_ContaOBusca")
            USE IN cursor_4c_ContaOBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaDContaO(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_ContaO.Value))
                THIS.AbrirBuscaContaO()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS DE GRUPO DESTINO (SigCdGcr: codigos / descrs)
    *==========================================================================

    PROCEDURE TeclaGrDestino(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaGrDestino()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaGrDestino()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_GrDestino.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrDVal")
            IF loc_nRes > 0
                SELECT cursor_4c_GcrDVal
                IF !EOF()
                    loc_oPag.txt_4c_DsGrDestino.Value = ALLTRIM(descrs)
                    USE IN cursor_4c_GcrDVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_GcrDVal")
                USE IN cursor_4c_GcrDVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_GcrBuscaD", "codigos", loc_cValor, "Grupo")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_GcrBuscaD
            loc_oPag.txt_4c_GrDestino.Value   = ALLTRIM(codigos)
            loc_oPag.txt_4c_DsGrDestino.Value = ALLTRIM(descrs)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_GcrBuscaD
                loc_oPag.txt_4c_GrDestino.Value   = ALLTRIM(codigos)
                loc_oPag.txt_4c_DsGrDestino.Value = ALLTRIM(descrs)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_GcrBuscaD")
            USE IN cursor_4c_GcrBuscaD
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaDsGrDestino(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_GrDestino.Value))
                THIS.AbrirBuscaGrDestino()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS DE CONTA DESTINO (SigCdCli: IClis / Rclis)
    *==========================================================================

    PROCEDURE TeclaContaD(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaContaD()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaContaD()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_ContaD.Value)

        IF !EMPTY(loc_cValor)
            loc_cSQL = "SELECT IClis, Rclis FROM SigCdCli WHERE IClis = " + ;
                       EscaparSQL(loc_cValor)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDVal")
            IF loc_nRes > 0
                SELECT cursor_4c_ContaDVal
                IF !EOF()
                    loc_oPag.txt_4c_DContaD.Value = ALLTRIM(Rclis)
                    USE IN cursor_4c_ContaDVal
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_ContaDVal")
                USE IN cursor_4c_ContaDVal
            ENDIF
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_ContaDBusca", "IClis", loc_cValor, ;
            "Conta Destino")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            SELECT cursor_4c_ContaDBusca
            loc_oPag.txt_4c_ContaD.Value  = ALLTRIM(IClis)
            loc_oPag.txt_4c_DContaD.Value = ALLTRIM(Rclis)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                SELECT cursor_4c_ContaDBusca
                loc_oPag.txt_4c_ContaD.Value  = ALLTRIM(IClis)
                loc_oPag.txt_4c_DContaD.Value = ALLTRIM(Rclis)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_ContaDBusca")
            USE IN cursor_4c_ContaDBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaDContaD(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 13, 9, 115)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_ContaD.Value))
                THIS.AbrirBuscaContaD()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT: executa preview (equivale a Visualizar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Nao aplicavel em REPORT (sem operacoes CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel neste relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Compatibilidade com contrato FormBase; delega a FormParaRelatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Compatibilidade com contrato FormBase
    *   Em REPORT nao ha dados de registro para trazer de volta ao form.
    *   Restaura apenas as datas iniciais do BO caso ainda estejam em branco.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF EMPTY(loc_oPag.txt_4c_DtInicial.Value)
                    loc_oPag.txt_4c_DtInicial.Value = THIS.this_oRelatorio.this_dDtInicial
                ENDIF
                IF EMPTY(loc_oPag.txt_4c_DtFinal.Value)
                    loc_oPag.txt_4c_DtFinal.Value = THIS.this_oRelatorio.this_dDtFinal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em REPORT todos os campos sao sempre editaveis
    *   (nao ha modos INCLUIR/ALTERAR/VISUALIZAR como em CRUD)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DtInicial.Enabled   = .T.
        loc_oPag.txt_4c_DtFinal.Enabled     = .T.
        loc_oPag.txt_4c_Empresa.Enabled     = .T.
        loc_oPag.txt_4c_DEmpresa.Enabled    = .T.
        loc_oPag.txt_4c_Operacao.Enabled    = .T.
        loc_oPag.txt_4c_OperacaoI.Enabled   = .T.
        loc_oPag.txt_4c_OperacaoF.Enabled   = .T.
        loc_oPag.txt_4c_GrOrigem.Enabled    = .T.
        loc_oPag.txt_4c_DsGrOrigem.Enabled  = .T.
        loc_oPag.txt_4c_ContaO.Enabled      = .T.
        loc_oPag.txt_4c_DContaO.Enabled     = .T.
        loc_oPag.txt_4c_GrDestino.Enabled   = .T.
        loc_oPag.txt_4c_DsGrDestino.Enabled = .T.
        loc_oPag.txt_4c_ContaD.Enabled      = .T.
        loc_oPag.txt_4c_DContaD.Enabled     = .T.
        loc_oPag.txt_4c_OP.Enabled          = .T.
        loc_oPag.obj_4c_Opt_Tipo.Enabled    = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel em REPORT (sem grid de lista)
    *   Retorna .T. para compatibilidade com FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel em REPORT (sem modos CRUD)
    *   Garante que os botoes do CommandGroup permanecem sempre habilitados.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
