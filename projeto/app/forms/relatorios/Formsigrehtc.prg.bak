*==============================================================================
* FORMSIGREHTC.PRG
* Relatorio de Cheques Emitidos (SIGREHTC) - Fase 3/8: Form Estrutura Base
*
* Herda de FormBase
* Tipo: REPORT (layout FLAT - sem PageFrame CRUD)
* BO:   sigrehtcBO (herda RelatorioBase)
* Migrado de: sigrehtc.SCX (frmrelatorio)
*
* Filtros:
*   - Grupo de estoque (txt_4c_CdGrEstoque / txt_4c_DsGrEstoque)
*   - Conta (txt_4c_CdContas / txt_4c_DsContas)
*   - Periodo (txt_4c_DtInicial / txt_4c_DtFinal + obj_4c_OptDatas)
*   - Op_Emitido, Op_Cancelado, Op_Ordem, Op_Baixados
*==============================================================================

DEFINE CLASS Formsigrehtc AS FormBase

    *-- Dimensoes EXATAS do original (Height=300, Width=800)
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

    *-- BO e controle de estado
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""
    this_nPaginaAtual  = 1

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * INICIALIZARFORM - Cria estrutura do form de relatorio FLAT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oRelatorio = CREATEOBJECT("sigrehtcBO")

            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar BO do relat" + CHR(243) + ;
                    "rio de Cheques Emitidos", "InicializarForm")
            ELSE
                THIS.this_oRelatorio.BuscarContas()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.LimparCampos()

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGEFRAME - Aplica propriedades de janela do form de relatorio
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Caption     = "Relat" + CHR(243) + "rio de Cheques Emitidos"
        THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
        THIS.AutoCenter  = .T.
        THIS.BorderStyle = 2
        THIS.WindowType  = 1
        THIS.ControlBox  = .F.
        THIS.MaxButton   = .F.
        THIS.MinButton   = .F.
        THIS.TitleBar    = 0
        THIS.Themes      = .F.
        THIS.ShowTips    = .T.
        THIS.BackColor   = RGB(255, 255, 255)
    ENDPROC

    *==========================================================================
    * CONFIGURARCABECALHO - Container escuro com labels titulo/sombra
    * Width = THIS.Width (NUNCA subtrair por causa do Encerrar - nao existe aqui)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top       = 0
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackStyle = 1
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible   = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 12
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINALISTA - Monta a area principal do form REPORT (layout FLAT)
    * Em REPORT nao ha PageFrame/Grid CRUD; a "pagina lista" e o conjunto
    * de filtros + CommandGroup de acoes (Visualizar/Imprimir/Excel/Sair).
    * Encaminha para ConfigurarBotoes() (cmg_4c_Botoes) e ConfigurarPaginaDados()
    * (17 controles: 6 Labels + 6 TextBoxes + 5 OptionGroups), na ordem em que
    * o framework legado renderizava (botoes primeiro, depois filtros).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarPaginaDados()
        THIS.this_nPaginaAtual = 1
    ENDPROC

    *==========================================================================
    * CONFIGURARBOTOES - CommandGroup com 4 botoes (frmrelatorio canonical)
    * Left=529 (original btnReport.Left=530), Width=273, Height=80, Top=0
    * Geometria canonical: ButtonCount=4, BackStyle=0, BorderStyle=0
    * BINDEVENTs adicionados na Fase 7
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

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
                .Picture         = loc_cIcones + "relatorio_video_26.jpg"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .Picture         = loc_cIcones + "relatorio_impressora_26.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .Picture         = loc_cIcones + "geral_envelope_32.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Sair"
                .Picture         = loc_cIcones + "relatorio_sair_60.jpg"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Cancel          = .T.
            ENDWITH
        ENDWITH

        *-- BINDEVENTs para os 4 botoes da CommandGroup
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINADADOS - Cria todos os controles de filtro do relatorio
    * Posicoes EXATAS do original (Width=800, Height=300)
    * Em REPORT FLAT, a "pagina dados" e a area de filtros sobre o form (sem
    * PageFrame CRUD): 6 Labels + 6 TextBoxes + 5 OptionGroups = 17 controles.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- Label: Grupo
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grupo :"
            .Left      = 211
            .Top       = 101
            .Width     = 38
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Conta
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Conta :"
            .Left      = 211
            .Top       = 128
            .Width     = 38
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Periodo
        THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH THIS.lbl_4c_Lbl_periodo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Per" + CHR(237) + "odo  :"
            .Left      = 201
            .Top       = 154
            .Width     = 48
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: separador "a" entre datas (azul)
        THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH THIS.lbl_4c_Lbl_periodo_a
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .Caption   = CHR(224)
            .Left      = 338
            .Top       = 153
            .Width     = 9
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Ordem
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Ordem :"
            .Left      = 208
            .Top       = 177
            .Width     = 41
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Imprime Baixadas
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Imprime Baixadas :"
            .Left      = 156
            .Top       = 245
            .Width     = 93
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Codigo do Grupo de Estoque
        THIS.AddObject("txt_4c_CdGrEstoque", "TextBox")
        WITH THIS.txt_4c_CdGrEstoque
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 25
            .Left          = 254
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 96
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- TextBox: Descricao do Grupo de Estoque
        THIS.AddObject("txt_4c_DsGrEstoque", "TextBox")
        WITH THIS.txt_4c_DsGrEstoque
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 25
            .Left          = 336
            .MaxLength     = 20
            .SpecialEffect = 1
            .Top           = 96
            .Width         = 150
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- TextBox: Codigo da Conta
        THIS.AddObject("txt_4c_CdContas", "TextBox")
        WITH THIS.txt_4c_CdContas
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 25
            .Left          = 254
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 123
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- TextBox: Descricao da Conta
        THIS.AddObject("txt_4c_DsContas", "TextBox")
        WITH THIS.txt_4c_DsContas
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 25
            .Left          = 336
            .MaxLength     = 50
            .SpecialEffect = 1
            .Top           = 123
            .Width         = 345
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- TextBox: Data Inicial
        THIS.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH THIS.txt_4c__dt_inicial
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Height        = 25
            .Left          = 254
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 150
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- TextBox: Data Final
        THIS.AddObject("txt_4c__dt_final", "TextBox")
        WITH THIS.txt_4c__dt_final
            .FontName      = "Tahoma"
            .BorderStyle   = 1
            .Height        = 25
            .Left          = 350
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 150
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- OptionGroup: Tipo de data (Movimentacao / Vencimento)
        THIS.AddObject("obj_4c_OptDatas", "OptionGroup")
        WITH THIS.obj_4c_OptDatas
            .Top           = 149
            .Left          = 430
            .Width         = 189
            .Height        = 25
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .SpecialEffect = 0
            .Visible       = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Height    = 15
                .Left      = 5
                .Style     = 0
                .Top       = 5
                .Width     = 87
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Vencimento"
                .Height    = 15
                .Left      = 111
                .Style     = 0
                .Top       = 5
                .Width     = 73
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- OptionGroup: Op_Emitido (Emitido / Nao Emitido / Todos)
        THIS.AddObject("obj_4c_Op_Emitido", "OptionGroup")
        WITH THIS.obj_4c_Op_Emitido
            .Top           = 197
            .Left          = 248
            .Width         = 262
            .Height        = 24
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .SpecialEffect = 0
            .AutoSize      = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "Emitido"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Height    = 15
                .Left      = 5
                .Style     = 0
                .Top       = 5
                .Width     = 52
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Emitido"
                .Height    = 15
                .Left      = 92
                .Style     = 0
                .Top       = 5
                .Width     = 85
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(3)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Todos"
                .WordWrap        = .T.
                .Height    = 15
                .Left      = 201
                .Style     = 0
                .Top       = 5
                .Width     = 47
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- OptionGroup: Op_Cancelado (Validos / Cancelados / Todos)
        THIS.AddObject("obj_4c_Op_Cancelado", "OptionGroup")
        WITH THIS.obj_4c_Op_Cancelado
            .Top           = 219
            .Left          = 248
            .Width         = 262
            .Height        = 24
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .SpecialEffect = 0
            .AutoSize      = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "V" + CHR(225) + "lidos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Height    = 15
                .Left      = 5
                .Style     = 0
                .Top       = 5
                .Width     = 51
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Cancelados"
                .Height    = 15
                .Left      = 92
                .Style     = 0
                .Top       = 5
                .Width     = 78
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(3)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Todos"
                .WordWrap        = .T.
                .Height    = 15
                .Left      = 201
                .Style     = 0
                .Top       = 5
                .Width     = 47
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- OptionGroup: Op_Ordem (por Copia / por Data / por Conta)
        THIS.AddObject("obj_4c_Op_Ordem", "OptionGroup")
        WITH THIS.obj_4c_Op_Ordem
            .Top           = 172
            .Left          = 248
            .Width         = 280
            .Height        = 27
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .SpecialEffect = 0
            .Visible       = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "por C" + CHR(243) + "pia"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Height    = 17
                .Left      = 5
                .Style     = 0
                .Top       = 5
                .Width     = 72
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "por Data"
                .Height    = 17
                .Left      = 92
                .Style     = 0
                .Top       = 5
                .Width     = 72
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(3)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "por Conta"
                .WordWrap        = .T.
                .Height    = 17
                .Left      = 201
                .Style     = 0
                .Top       = 5
                .Width     = 77
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- OptionGroup: Op_Baixados (Sim / Nao)
        THIS.AddObject("obj_4c_Op_Baixados", "OptionGroup")
        WITH THIS.obj_4c_Op_Baixados
            .Top           = 240
            .Left          = 248
            .Width         = 144
            .Height        = 27
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .SpecialEffect = 0
            .Visible       = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Height    = 17
                .Left      = 5
                .Style     = 0
                .Top       = 5
                .Width     = 40
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Height    = 17
                .Left      = 92
                .Style     = 0
                .Top       = 5
                .Width     = 40
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- BINDEVENTs: Grupo de Estoque - valida ao pressionar ENTER/TAB/F4
        BINDEVENT(THIS.txt_4c_CdGrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
        BINDEVENT(THIS.txt_4c_DsGrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")

        *-- BINDEVENTs: Conta - valida ao pressionar ENTER/TAB/F4
        BINDEVENT(THIS.txt_4c_CdContas, "KeyPress", THIS, "TeclaCdContas")
        BINDEVENT(THIS.txt_4c_DsContas, "KeyPress", THIS, "TeclaDsContas")
    ENDPROC

    *==========================================================================
    * LIMPARCAMPOS - Reseta todos os campos de filtro para valores padrao
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.txt_4c_CdGrEstoque.Value    = ""
        THIS.txt_4c_DsGrEstoque.Value    = ""
        THIS.txt_4c_DsGrEstoque.Enabled  = .T.
        THIS.txt_4c_CdContas.Value       = ""
        THIS.txt_4c_DsContas.Value       = ""
        THIS.txt_4c_DsContas.Enabled     = .T.
        THIS.txt_4c__dt_inicial.Value    = {}
        THIS.txt_4c__dt_final.Value      = {}
        THIS.obj_4c_OptDatas.Value       = 1
        THIS.obj_4c_Op_Emitido.Value     = 1
        THIS.obj_4c_Op_Cancelado.Value   = 1
        THIS.obj_4c_Op_Ordem.Value       = 1
        THIS.obj_4c_Op_Baixados.Value    = 1
    ENDPROC

    *==========================================================================
    * ATUALIZARESTADOCONTROLES - Override: REPORT nao usa modo CRUD
    *==========================================================================
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *==========================================================================
    * ALTERNARPAGINA - REPORT eh FLAT (1 pagina logica permanente)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(PCOUNT() < 1 OR VARTYPE(par_nPagina) != "N", 1, par_nPagina)
        IF loc_nPagina < 1
            loc_nPagina = 1
        ENDIF
        THIS.this_nPaginaAtual = loc_nPagina
    ENDPROC

    *==========================================================================
    * FORMPARARELATORIO - Transfere valores do form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaRelatorio()
        WITH THIS.this_oRelatorio
            .this_dDtInicial = THIS.txt_4c__dt_inicial.Value
            .this_dDtFinal   = THIS.txt_4c__dt_final.Value
            .this_nTpDat     = THIS.obj_4c_OptDatas.Value
            .this_cGrupo     = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            .this_cDsGrupo   = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
            .this_cIclis     = ALLTRIM(THIS.txt_4c_CdContas.Value)
            .this_cDsContas  = ALLTRIM(THIS.txt_4c_DsContas.Value)
            .this_nOpEmitido = THIS.obj_4c_Op_Emitido.Value
            .this_nOpCancela = THIS.obj_4c_Op_Cancelado.Value
            .this_nOpOrdem   = THIS.obj_4c_Op_Ordem.Value
            .this_nOpBaixas  = THIS.obj_4c_Op_Baixados.Value
        ENDWITH
    ENDPROC

    *==========================================================================
    * VALIDARCDGRESTOQUE - Valida codigo do grupo contra SigCdGrp
    * cgrus=code(3), dgrus=desc(20)
    *==========================================================================
    PROCEDURE ValidarCdGrEstoque()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)

        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsGrEstoque.Value   = ""
            THIS.txt_4c_DsGrEstoque.Enabled = .T.
            RETURN
        ENDIF

        loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp"

        IF USED("cursor_4c_GrpVal")
            USE IN cursor_4c_GrpVal
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal")

        IF loc_nResult > 0
            SELECT cursor_4c_GrpVal
            LOCATE FOR ALLTRIM(cgrus) = ALLTRIM(loc_cCodigo)
            IF FOUND()
                THIS.txt_4c_DsGrEstoque.Value   = ALLTRIM(dgrus)
                THIS.txt_4c_DsGrEstoque.Enabled = .F.
                USE IN cursor_4c_GrpVal
                RETURN
            ENDIF
            USE IN cursor_4c_GrpVal
        ENDIF

        MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado: " + loc_cCodigo, "Aviso")
        THIS.txt_4c_CdGrEstoque.Value   = ""
        THIS.txt_4c_DsGrEstoque.Value   = ""
        THIS.txt_4c_DsGrEstoque.Enabled = .T.
        THIS.txt_4c_CdGrEstoque.SetFocus()
    ENDPROC

    *==========================================================================
    * VALIDARDSGRESTOQUE - Valida descricao do grupo contra SigCdGrp
    * Ativo somente quando txt_4c_CdGrEstoque estiver vazio (When original)
    *==========================================================================
    PROCEDURE ValidarDsGrEstoque()
        LOCAL loc_cDesc, loc_cSQL, loc_nResult
        loc_cDesc = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)

        IF !EMPTY(ALLTRIM(THIS.txt_4c_CdGrEstoque.Value))
            RETURN
        ENDIF

        IF EMPTY(loc_cDesc)
            THIS.txt_4c_CdGrEstoque.Value = ""
            RETURN
        ENDIF

        loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp"

        IF USED("cursor_4c_GrpDsVal")
            USE IN cursor_4c_GrpDsVal
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpDsVal")

        IF loc_nResult > 0
            SELECT cursor_4c_GrpDsVal
            LOCATE FOR UPPER(ALLTRIM(dgrus)) = UPPER(loc_cDesc)
            IF FOUND()
                THIS.txt_4c_CdGrEstoque.Value   = ALLTRIM(cgrus)
                THIS.txt_4c_DsGrEstoque.Value   = ALLTRIM(dgrus)
                THIS.txt_4c_DsGrEstoque.Enabled = .F.
                USE IN cursor_4c_GrpDsVal
                RETURN
            ENDIF
            USE IN cursor_4c_GrpDsVal
        ENDIF

        MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado.", "Aviso")
        THIS.txt_4c_CdGrEstoque.Value   = ""
        THIS.txt_4c_DsGrEstoque.Value   = ""
        THIS.txt_4c_DsGrEstoque.Enabled = .T.
        THIS.txt_4c_DsGrEstoque.SetFocus()
    ENDPROC

    *==========================================================================
    * TECLACDGRESTOQUE - KeyPress: ENTER(13)/TAB(9) valida codigo do grupo
    *==========================================================================
    PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrEstoque()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrEstoque()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TECLADSGRESTOQUE - KeyPress: ENTER(13)/TAB(9) valida descricao do grupo
    *                              F4(115) abre lookup direto
    *==========================================================================
    PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrEstoque()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsGrEstoque()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ABRIRLOOKUPGRESTOQUE - Abre FormBuscaAuxiliar para grupo de estoque
    * Tabela: SigCdGrp | cgrus (cod) | dgrus (desc)
    *==========================================================================
    PROCEDURE AbrirLookupGrEstoque()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", ;
            "cursor_4c_BuscaGrp", ;
            "cgrus", ;
            ALLTRIM(THIS.txt_4c_CdGrEstoque.Value), ;
            "Buscar Grupo de Estoque")

        loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaGrp")
                loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
                loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrp.dgrus)
                THIS.txt_4c_CdGrEstoque.Value   = loc_cCodigo
                THIS.txt_4c_DsGrEstoque.Value   = loc_cDescricao
                THIS.txt_4c_DsGrEstoque.Enabled = .F.
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    *==========================================================================
    * TECLACDCONTAS - KeyPress: ENTER(13)/TAB(9) valida codigo da conta
    *                           F4(115) abre lookup direto
    *==========================================================================
    PROCEDURE TeclaCdContas(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContas()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdContas()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TECLADSCONTAS - KeyPress: ENTER(13)/TAB(9) valida descricao da conta
    *                           F4(115) abre lookup direto
    * Somente ativo quando CdContas estiver vazio (comportamento When original)
    *==========================================================================
    PROCEDURE TeclaDsContas(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContas()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsContas()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDARCDCONTAS - Valida codigo da conta contra cursor_4c_Contas
    * Iclis=codigo, Rclis=nome/razao social
    * Se nao encontrado, abre lookup FormBuscaAuxiliar
    *==========================================================================
    PROCEDURE ValidarCdContas()
        LOCAL loc_cCodigo, loc_nArea
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdContas.Value)

        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsContas.Value   = ""
            THIS.txt_4c_DsContas.Enabled = .T.
            RETURN
        ENDIF

        IF USED("cursor_4c_Contas")
            loc_nArea = SELECT()
            SELECT cursor_4c_Contas
            LOCATE FOR ALLTRIM(Iclis) = loc_cCodigo
            IF FOUND()
                THIS.txt_4c_DsContas.Value   = ALLTRIM(Rclis)
                THIS.txt_4c_DsContas.Enabled = .F.
                SELECT (loc_nArea)
                RETURN
            ENDIF
            SELECT (loc_nArea)
        ENDIF

        THIS.AbrirLookupContas()
    ENDPROC

    *==========================================================================
    * VALIDARDSCONTAS - Valida descricao da conta (busca reversa por nome)
    * Somente ativo quando CdContas estiver vazio (comportamento When original)
    * Se nao encontrado, abre lookup FormBuscaAuxiliar
    *==========================================================================
    PROCEDURE ValidarDsContas()
        LOCAL loc_cDesc, loc_nArea

        IF !EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
            RETURN
        ENDIF

        loc_cDesc = ALLTRIM(THIS.txt_4c_DsContas.Value)

        IF EMPTY(loc_cDesc)
            THIS.txt_4c_CdContas.Value = ""
            RETURN
        ENDIF

        IF USED("cursor_4c_Contas")
            loc_nArea = SELECT()
            SELECT cursor_4c_Contas
            LOCATE FOR UPPER(ALLTRIM(Rclis)) = UPPER(loc_cDesc)
            IF FOUND()
                THIS.txt_4c_CdContas.Value   = ALLTRIM(Iclis)
                THIS.txt_4c_DsContas.Value   = ALLTRIM(Rclis)
                THIS.txt_4c_DsContas.Enabled = .F.
                SELECT (loc_nArea)
                RETURN
            ENDIF
            SELECT (loc_nArea)
        ENDIF

        THIS.AbrirLookupContas()
    ENDPROC

    *==========================================================================
    * ABRIRLOOKUPCONTAS - Abre FormBuscaAuxiliar para conta corrente
    * Tabela: SigCdCli | Iclis (cod) | Rclis (nome/razao social)
    *==========================================================================
    PROCEDURE AbrirLookupContas()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", ;
            "cursor_4c_BuscaContas", ;
            "Iclis", ;
            ALLTRIM(THIS.txt_4c_CdContas.Value), ;
            "Buscar Conta Corrente")

        loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Rclis", "", "Nome / Raz" + CHR(227) + "o Social")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaContas")
                loc_cCodigo    = ALLTRIM(cursor_4c_BuscaContas.Iclis)
                loc_cDescricao = ALLTRIM(cursor_4c_BuscaContas.Rclis)
                THIS.txt_4c_CdContas.Value   = loc_cCodigo
                THIS.txt_4c_DsContas.Value   = loc_cDescricao
                THIS.txt_4c_DsContas.Enabled = .F.
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaContas")
            USE IN cursor_4c_BuscaContas
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    *==========================================================================
    * BTNVISUALIZARCLICK - Buttons(1): Preview do relatorio na tela
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNIMPRIMIRCLICK - Buttons(2): Imprime relatorio na impressora
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNEXCELCLICK - Buttons(3): Exporta dados do relatorio para arquivo Excel
    *==========================================================================
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo
        loc_cArquivo = PUTFILE("Salvar como Excel", ;
            "SigReHtc_" + STRTRAN(DTOC(DATE()), "/", ""), ;
            "XLS")

        IF EMPTY(loc_cArquivo)
            RETURN
        ENDIF

        THIS.FormParaRelatorio()

        IF THIS.this_oRelatorio.ExportarExcel(loc_cArquivo)
            MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, ;
                "Exporta" + CHR(231) + CHR(227) + "o Excel")
        ELSE
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Exportar Excel")
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNSAIRCLICK - Buttons(4): Fecha o formulario
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNINCLUIRCLICK - Alias CRUD: nova consulta (limpa filtros e foca o
    * primeiro campo). Em REPORT nao ha registro a incluir; "Incluir" mapeia
    * para iniciar uma nova consulta com filtros vazios.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.LimparCampos()
        THIS.txt_4c_CdGrEstoque.SetFocus()
    ENDPROC

    *==========================================================================
    * BTNALTERARCLICK - Alias CRUD: modificar saida (imprime na impressora).
    * Em REPORT "Alterar" mapeia para alterar o destino da saida do relatorio
    * preparado (visualizacao na tela -> impressao em papel).
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNEXCLUIRCLICK - Alias CRUD: descartar resultado e fechar formulario.
    * Em REPORT "Excluir" mapeia para abandonar a consulta atual (sair do form),
    * sem efetuar qualquer operacao em banco de dados.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNBUSCARCLICK - Preview do relatorio na tela (alias CRUD para Visualizar)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNENCERRARCLICK - Fecha o formulario (alias de BtnSairClick)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNSALVARCLICK - Alias CRUD: envia relatorio para a impressora
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNCANCELARCLICK - Alias CRUD: limpa filtros e foca primeiro campo
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.txt_4c_CdGrEstoque.SetFocus()
    ENDPROC

    *==========================================================================
    * FORMPARABO - Transfere valores do form para o BO (alias de FormParaRelatorio)
    *==========================================================================
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *==========================================================================
    * BOPARAFORM - Restaura campos do form a partir do estado do BO
    *==========================================================================
    PROCEDURE BOParaForm()
        WITH THIS.this_oRelatorio
            THIS.txt_4c__dt_inicial.Value     = .this_dDtInicial
            THIS.txt_4c__dt_final.Value       = .this_dDtFinal
            THIS.obj_4c_OptDatas.Value        = .this_nTpDat
            THIS.txt_4c_CdGrEstoque.Value     = .this_cGrupo
            THIS.txt_4c_DsGrEstoque.Value     = .this_cDsGrupo
            THIS.txt_4c_CdContas.Value        = .this_cIclis
            THIS.txt_4c_DsContas.Value        = .this_cDsContas
            THIS.obj_4c_Op_Emitido.Value      = .this_nOpEmitido
            THIS.obj_4c_Op_Cancelado.Value    = .this_nOpCancela
            THIS.obj_4c_Op_Ordem.Value        = .this_nOpOrdem
            THIS.obj_4c_Op_Baixados.Value     = .this_nOpBaixas
        ENDWITH
    ENDPROC

    *==========================================================================
    * HABILITARCAMPOS - Habilita/desabilita todos os campos de filtro
    * Em REPORT todos os campos de filtro sao sempre editaveis (par omitido = .T.)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(PCOUNT() < 1 OR VARTYPE(par_lHabilitar) != "L", .T., par_lHabilitar)

        THIS.txt_4c_CdGrEstoque.Enabled  = loc_lHab
        THIS.txt_4c_DsGrEstoque.Enabled  = loc_lHab
        THIS.txt_4c_CdContas.Enabled     = loc_lHab
        THIS.txt_4c_DsContas.Enabled     = loc_lHab
        THIS.txt_4c__dt_inicial.Enabled  = loc_lHab
        THIS.txt_4c__dt_final.Enabled    = loc_lHab
        THIS.obj_4c_OptDatas.Enabled     = loc_lHab
        THIS.obj_4c_Op_Emitido.Enabled   = loc_lHab
        THIS.obj_4c_Op_Cancelado.Enabled = loc_lHab
        THIS.obj_4c_Op_Ordem.Enabled     = loc_lHab
        THIS.obj_4c_Op_Baixados.Enabled  = loc_lHab
    ENDPROC

    *==========================================================================
    * CARREGARLISTA - REPORT nao tem lista CRUD; retorna .T. sempre
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AJUSTARBOTOESPORMODO - REPORT nao tem modos CRUD; botoes sempre ativos
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * DESTROY - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
