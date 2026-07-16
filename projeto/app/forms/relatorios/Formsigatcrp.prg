*==============================================================================
* FORMSIGATCRP.PRG
* Formulario: Analitico de Atendimentos / Pendencias
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Fase A: Layout visual pixel-perfect. Funcionalidade na Fase B.
*==============================================================================

DEFINE CLASS Formsigatcrp AS FormBase

    *-- Propriedades visuais
    Height      = 535
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    BorderStyle = 2
    AutoCenter  = .T.
    ControlBox  = .F.
    ShowTips    = .T.

    *-- Propriedades customizadas
    this_cMensagemErro  = ""
    this_oRelatorio     = .NULL.
    this_oBusinessObject = .NULL.

    *==========================================================================
    * INICIALIZARFORM - Cria todos os controles visuais
    *==========================================================================
    PROCEDURE InicializarForm
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            *-- Garantir variaveis globais de caminho (modo teste)
            IF TYPE('gc_4c_CaminhoIcones') = 'U'
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE('gc_4c_CaminhoBase') = 'U'
                gc_4c_CaminhoBase = ""
            ENDIF
            IF TYPE('go_4c_Sistema') = 'U'
                go_4c_Sistema = .NULL.
            ENDIF

            *-- Caption com acentos
            THIS.Caption = "Anal" + CHR(237) + "tico de Atendimentos / Pend" + CHR(234) + "ncias"

            *-- Instanciar BO
            THIS.this_oBusinessObject = CREATEOBJECT("sigatcrpBO")
            IF ISNULL(THIS.this_oBusinessObject)
                THIS.this_cMensagemErro = "Falha ao instanciar sigatcrpBO"
                loc_lSucesso = .F.
            ENDIF

            IF loc_lSucesso
                THIS.ConfigurarCabecalho()
                THIS.CriarBotoesRelatorio()
                THIS.CriarFiltrosPeriodo()
                THIS.CriarFiltrosAtendente()
                THIS.CriarFiltrosClienteClass()
                THIS.CriarFiltrosSubClass()
                THIS.CriarFiltrosEmpresa()
                THIS.CriarFiltrosDepGerVen()
                THIS.CriarFiltrosProdCol()
                THIS.CriarFiltrosOpcoes()
                THIS.CarregarCursoresAuxiliares()
                THIS.ConfigurarEventos()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ATUALIZARESTADOCONTROLES - Override para REPORT (sem logica CRUD)
    *==========================================================================
    PROCEDURE AtualizarEstadoControles
        RETURN
    ENDPROC

    *==========================================================================
    * CONFIGURARCABECALHO - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *==========================================================================
    PROCEDURE ConfigurarCabecalho
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
                .Width     = THISFORM.Width
                .Height    = 30
                .Caption   = THISFORM.Caption
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
                .Width     = THISFORM.Width
                .Height    = 30
                .Caption   = THISFORM.Caption
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * CRIARBOTOESRELATORIO - Botoes Visualizar / Imprimir / Excel / Sair
    * Posicoes baseadas em btnReport original: Left=495, Top=-2
    * Buttons internos: Visualiza(5,5), Imprime(5,80), DOCEXCEL(5,155), Sair(5,230)
    *==========================================================================
    PROCEDURE CriarBotoesRelatorio

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
                .ToolTipText     = "Visualizar"
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
                .ToolTipText     = "Imprimir"
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
                .ToolTipText     = "Exportar Excel"
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

    *==========================================================================
    * CRIARFILTROSPERIODO - Periodo e Data de Agendamento
    *==========================================================================
    PROCEDURE CriarFiltrosPeriodo

        *-- Say3: "\<Periodo :"
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Caption   = "\<Per" + CHR(237) + "odo :"
            .Left      = 128
            .Top       = 88
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        *-- getDtInicial
        THIS.AddObject("txt_4c_DtInicial", "TextBox")
        WITH THIS.txt_4c_DtInicial
            .Value          = {}
            .Left           = 175
            .Top            = 85
            .Width          = 82
            .Height         = 23
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 2
            .Visible        = .T.
        ENDWITH

        *-- Say6: "a" separador entre datas
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Caption   = CHR(224)
            .Left      = 260
            .Top       = 88
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 3
            .Visible   = .T.
        ENDWITH

        *-- getDtFinal
        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Value          = {}
            .Left           = 273
            .Top            = 85
            .Width          = 82
            .Height         = 23
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 4
            .Visible        = .T.
        ENDWITH

        *-- Say18: "Data do Agendamento:"
        THIS.AddObject("lbl_4c_Label18", "Label")
        WITH THIS.lbl_4c_Label18
            .Caption   = "Data do Agendamento:"
            .Left      = 59
            .Top       = 113
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 5
            .Visible   = .T.
        ENDWITH

        *-- GetPvIni
        THIS.AddObject("txt_4c_PvIni", "TextBox")
        WITH THIS.txt_4c_PvIni
            .Value          = {}
            .Left           = 175
            .Top            = 110
            .Width          = 82
            .Height         = 23
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 6
            .Visible        = .T.
        ENDWITH

        *-- Say20: "a" separador agendamento
        THIS.AddObject("lbl_4c_Label20", "Label")
        WITH THIS.lbl_4c_Label20
            .Caption   = CHR(224)
            .Left      = 260
            .Top       = 113
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 7
            .Visible   = .T.
        ENDWITH

        *-- GetPvFin
        THIS.AddObject("txt_4c_PvFin", "TextBox")
        WITH THIS.txt_4c_PvFin
            .Value          = {}
            .Left           = 273
            .Top            = 110
            .Width          = 82
            .Height         = 23
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 8
            .Visible        = .T.
        ENDWITH

    ENDPROC

    *==========================================================================
    * CRIARFILTROSATENDENTE - Atendente
    *==========================================================================
    PROCEDURE CriarFiltrosAtendente

        *-- Say1: "\<Atendente :"
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Caption   = "\<Atendente :"
            .Left      = 113
            .Top       = 138
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 9
            .Visible   = .T.
        ENDWITH

        *-- getAtendente
        THIS.AddObject("txt_4c_Atendente", "TextBox")
        WITH THIS.txt_4c_Atendente
            .Value          = ""
            .Left           = 175
            .Top            = 135
            .Width          = 80
            .Height         = 23
            .MaxLength      = 10
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 10
            .Visible        = .T.
        ENDWITH

    ENDPROC

    *==========================================================================
    * CRIARFILTROSCLIENTECLASS - Cliente e Classificacao
    *==========================================================================
    PROCEDURE CriarFiltrosClienteClass

        *-- Say5: "Classificacao :"
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
            .Left      = 103
            .Top       = 164
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 11
            .Visible   = .T.
        ENDWITH

        *-- getClass
        THIS.AddObject("txt_4c_Class", "TextBox")
        WITH THIS.txt_4c_Class
            .Value          = ""
            .Left           = 175
            .Top            = 160
            .Width          = 150
            .Height         = 23
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 12
            .Visible        = .T.
        ENDWITH

        *-- Say2: "C\<liente :"
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Caption   = "C\<liente :"
            .Left      = 131
            .Top       = 188
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 13
            .Visible   = .T.
        ENDWITH

        *-- getCliente
        THIS.AddObject("txt_4c_Cliente", "TextBox")
        WITH THIS.txt_4c_Cliente
            .Value          = ""
            .Left           = 175
            .Top            = 185
            .Width          = 80
            .Height         = 23
            .MaxLength      = 10
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 14
            .Visible        = .T.
        ENDWITH

        *-- getNomCli
        THIS.AddObject("txt_4c_NomCli", "TextBox")
        WITH THIS.txt_4c_NomCli
            .Value          = ""
            .Left           = 257
            .Top            = 185
            .Width          = 328
            .Height         = 23
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 15
            .Visible        = .T.
        ENDWITH

    ENDPROC

    *==========================================================================
    * CRIARFILTROSSUBCLASS - Subclassificacoes (geral, entrada, saida)
    *==========================================================================
    PROCEDURE CriarFiltrosSubClass

        *-- Say11: "Subclassificacao :"
        THIS.AddObject("lbl_4c_Label11", "Label")
        WITH THIS.lbl_4c_Label11
            .Caption   = "Subclassifica" + CHR(231) + CHR(227) + "o :"
            .Left      = 87
            .Top       = 214
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 16
            .Visible   = .T.
        ENDWITH

        *-- GetSubClass
        THIS.AddObject("txt_4c_SubClass", "TextBox")
        WITH THIS.txt_4c_SubClass
            .Value          = ""
            .Left           = 175
            .Top            = 210
            .Width          = 410
            .Height         = 23
            .MaxLength      = 50
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 17
            .Visible        = .T.
        ENDWITH

        *-- Say16: "Subclassificacao Entrada :"
        THIS.AddObject("lbl_4c_Label16", "Label")
        WITH THIS.lbl_4c_Label16
            .Caption   = "Subclassifica" + CHR(231) + CHR(227) + "o Entrada :"
            .Left      = 46
            .Top       = 239
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 18
            .Visible   = .T.
        ENDWITH

        *-- GetSubClassE
        THIS.AddObject("txt_4c_SubClassE", "TextBox")
        WITH THIS.txt_4c_SubClassE
            .Value          = ""
            .Left           = 175
            .Top            = 235
            .Width          = 410
            .Height         = 23
            .MaxLength      = 50
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 19
            .Visible        = .T.
        ENDWITH

        *-- Say17: "Subclassificacao Saida :"
        THIS.AddObject("lbl_4c_Label17", "Label")
        WITH THIS.lbl_4c_Label17
            .Caption   = "Subclassifica" + CHR(231) + CHR(227) + "o Sa" + CHR(237) + "da :"
            .Left      = 58
            .Top       = 264
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 20
            .Visible   = .T.
        ENDWITH

        *-- GEtSubClassS
        THIS.AddObject("txt_4c_SubClassS", "TextBox")
        WITH THIS.txt_4c_SubClassS
            .Value          = ""
            .Left           = 175
            .Top            = 260
            .Width          = 410
            .Height         = 23
            .MaxLength      = 50
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 21
            .Visible        = .T.
        ENDWITH

    ENDPROC

    *==========================================================================
    * CRIARFILTROSEMPRESA - Empresa (codigo + descricao)
    *==========================================================================
    PROCEDURE CriarFiltrosEmpresa

        *-- lbl_empresa: "Empresa :"
        THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH THIS.lbl_4c_Lbl_empresa
            .Caption   = "Empresa :"
            .Left      = 123
            .Top       = 290
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 22
            .Visible   = .T.
        ENDWITH

        *-- getemp (codigo empresa)
        THIS.AddObject("txt_4c_Emp", "TextBox")
        WITH THIS.txt_4c_Emp
            .Value          = ""
            .Left           = 175
            .Top            = 285
            .Width          = 31
            .Height         = 25
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Format         = "K"
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 23
            .Visible        = .T.
        ENDWITH

        *-- getdemp (descricao empresa)
        THIS.AddObject("txt_4c_Demp", "TextBox")
        WITH THIS.txt_4c_Demp
            .Value          = ""
            .Left           = 208
            .Top            = 285
            .Width          = 377
            .Height         = 25
            .MaxLength      = 40
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Format         = "K"
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 24
            .Visible        = .T.
        ENDWITH

    ENDPROC

    *==========================================================================
    * CRIARFILTROSDEPGERVEN - Departamento / Gerente / Vendedor
    *==========================================================================
    PROCEDURE CriarFiltrosDepGerVen

        *-- Say8: "Departamento :"
        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .Caption   = "Departamento :"
            .Left      = 95
            .Top       = 316
            .Width     = 78
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 25
            .Visible   = .T.
        ENDWITH

        *-- GetCodDep
        THIS.AddObject("txt_4c_CodDep", "TextBox")
        WITH THIS.txt_4c_CodDep
            .Value          = ""
            .Left           = 175
            .Top            = 312
            .Width          = 79
            .Height         = 23
            .MaxLength      = 10
            .Format         = "K"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 26
            .Visible        = .T.
        ENDWITH

        *-- GetDesDep
        THIS.AddObject("txt_4c_DesDep", "TextBox")
        WITH THIS.txt_4c_DesDep
            .Value          = ""
            .Left           = 256
            .Top            = 312
            .Width          = 329
            .Height         = 23
            .MaxLength      = 30
            .Format         = "K"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 27
            .Visible        = .T.
        ENDWITH

        *-- Say9: "Gerente :"
        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .Caption   = "Gerente :"
            .Left      = 125
            .Top       = 342
            .Width     = 48
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 28
            .Visible   = .T.
        ENDWITH

        *-- GetCodGer
        THIS.AddObject("txt_4c_CodGer", "TextBox")
        WITH THIS.txt_4c_CodGer
            .Value          = ""
            .Left           = 175
            .Top            = 337
            .Width          = 79
            .Height         = 23
            .MaxLength      = 10
            .Format         = "K"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 29
            .Visible        = .T.
        ENDWITH

        *-- GetNomGer
        THIS.AddObject("txt_4c_NomGer", "TextBox")
        WITH THIS.txt_4c_NomGer
            .Value          = ""
            .Left           = 256
            .Top            = 337
            .Width          = 329
            .Height         = 23
            .MaxLength      = 40
            .Format         = "K"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 30
            .Visible        = .T.
        ENDWITH

        *-- Say10: "Vendedor :"
        THIS.AddObject("lbl_4c_Label10", "Label")
        WITH THIS.lbl_4c_Label10
            .Caption   = "Vendedor :"
            .Left      = 118
            .Top       = 366
            .Width     = 55
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 31
            .Visible   = .T.
        ENDWITH

        *-- GetCodVen
        THIS.AddObject("txt_4c_CodVen", "TextBox")
        WITH THIS.txt_4c_CodVen
            .Value          = ""
            .Left           = 175
            .Top            = 362
            .Width          = 79
            .Height         = 23
            .MaxLength      = 10
            .Format         = "K"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 32
            .Visible        = .T.
        ENDWITH

        *-- GetNomVen
        THIS.AddObject("txt_4c_NomVen", "TextBox")
        WITH THIS.txt_4c_NomVen
            .Value          = ""
            .Left           = 256
            .Top            = 362
            .Width          = 329
            .Height         = 23
            .MaxLength      = 40
            .Format         = "K"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 33
            .Visible        = .T.
        ENDWITH

    ENDPROC

    *==========================================================================
    * CRIARFILTROSRODCOL - Produto e Grupo de Venda (Colecao)
    *==========================================================================
    PROCEDURE CriarFiltrosProdCol

        *-- Say12: "Produto :"
        THIS.AddObject("lbl_4c_Label12", "Label")
        WITH THIS.lbl_4c_Label12
            .Caption   = "Produto :"
            .Left      = 126
            .Top       = 391
            .Width     = 47
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 34
            .Visible   = .T.
        ENDWITH

        *-- GetCodProd
        THIS.AddObject("txt_4c_CodProd", "TextBox")
        WITH THIS.txt_4c_CodProd
            .Value          = ""
            .Left           = 175
            .Top            = 387
            .Width          = 108
            .Height         = 23
            .MaxLength      = 14
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 35
            .Visible        = .T.
        ENDWITH

        *-- GetDesProd
        THIS.AddObject("txt_4c_DesProd", "TextBox")
        WITH THIS.txt_4c_DesProd
            .Value          = ""
            .Left           = 285
            .Top            = 387
            .Width          = 300
            .Height         = 23
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 36
            .Visible        = .T.
        ENDWITH

        *-- Say13: "Grupo de Venda :"
        THIS.AddObject("lbl_4c_Label13", "Label")
        WITH THIS.lbl_4c_Label13
            .Caption   = "Grupo de Venda :"
            .Left      = 87
            .Top       = 414
            .Width     = 86
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 37
            .Visible   = .T.
        ENDWITH

        *-- GetCodCol
        THIS.AddObject("txt_4c_CodCol", "TextBox")
        WITH THIS.txt_4c_CodCol
            .Value          = ""
            .Left           = 175
            .Top            = 412
            .Width          = 79
            .Height         = 23
            .MaxLength      = 10
            .Format         = "K"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 38
            .Visible        = .T.
        ENDWITH

        *-- GetDesCol
        THIS.AddObject("txt_4c_DesCol", "TextBox")
        WITH THIS.txt_4c_DesCol
            .Value          = ""
            .Left           = 256
            .Top            = 412
            .Width          = 329
            .Height         = 23
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .BorderStyle    = 1
            .ForeColor      = RGB(0,0,0)
            .BackColor      = RGB(255,255,255)
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 39
            .Visible        = .T.
        ENDWITH

    ENDPROC

    *==========================================================================
    * CRIARFILTROSOPCOES - Ordenacao, Prioridade, Selecao, Tipo, UltimaSubClas
    *==========================================================================
    PROCEDURE CriarFiltrosOpcoes

        *-- Say7: "Ordenacao :"
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
            .Left      = 111
            .Top       = 439
            .Width     = 62
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 40
            .Visible   = .T.
        ENDWITH

        *-- cmbOrdem
        THIS.AddObject("cbo_4c_CmbOrdem", "ComboBox")
        WITH THIS.cbo_4c_CmbOrdem
            .RowSourceType  = 1
            .RowSource      = "por Data, por OS, por Cliente, por Atendente, por Classifica" + CHR(231) + CHR(227) + "o, por Departamento"
            .Value          = 1
            .Left           = 175
            .Top            = 437
            .Width          = 150
            .Height         = 24
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .Style          = 2
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 41
            .Visible        = .T.
        ENDWITH

        *-- Say19: "Prioridade :"
        THIS.AddObject("lbl_4c_Label19", "Label")
        WITH THIS.lbl_4c_Label19
            .Caption   = "Prioridade :"
            .Left      = 334
            .Top       = 443
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 42
            .Visible   = .T.
        ENDWITH

        *-- cmbPrioridade
        THIS.AddObject("cbo_4c_CmbPrioridade", "ComboBox")
        WITH THIS.cbo_4c_CmbPrioridade
            .RowSourceType  = 1
            .RowSource      = ",Normal,M" + CHR(233) + "dia,Alta,Critico"
            .Value          = 1
            .Left           = 405
            .Top            = 438
            .Width          = 67
            .Height         = 25
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .Style          = 2
            .BorderColor    = RGB(100,100,100)
            .TabIndex       = 43
            .Visible        = .T.
        ENDWITH

        *-- Say4: "\<Selecao :"
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Caption   = "\<Sele" + CHR(231) + CHR(227) + "o :"
            .Left      = 127
            .Top       = 463
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 44
            .Visible   = .T.
        ENDWITH

        *-- optSelecao (3 botoes: Encerradas, Nao Encerradas, Todas)
        THIS.AddObject("obj_4c_OptSelecao", "OptionGroup")
        THIS.obj_4c_OptSelecao.ButtonCount = 3

        WITH THIS.obj_4c_OptSelecao
            .BorderStyle = 0
            .Value       = 3
            .Height      = 27
            .Left        = 170
            .Top         = 458
            .Width       = 260
            .BackColor   = RGB(240,240,240)
            .TabIndex    = 45
            .Visible     = .T.
        ENDWITH

        THIS.obj_4c_OptSelecao.Buttons(1).Caption  = "Encerradas"
        THIS.obj_4c_OptSelecao.Buttons(1).Height   = 17
        THIS.obj_4c_OptSelecao.Buttons(1).Left     = 5
        THIS.obj_4c_OptSelecao.Buttons(1).Top      = 5
        THIS.obj_4c_OptSelecao.Buttons(1).Width    = 96
        THIS.obj_4c_OptSelecao.Buttons(1).ForeColor = RGB(90,90,90)
        THIS.obj_4c_OptSelecao.Buttons(1).AutoSize = .F.
        THIS.obj_4c_OptSelecao.Buttons(1).Themes   = .F.
        THIS.obj_4c_OptSelecao.Buttons(1).BackStyle = 0

        THIS.obj_4c_OptSelecao.Buttons(2).Caption  = "N" + CHR(227) + "o Encerradas"
        THIS.obj_4c_OptSelecao.Buttons(2).Height   = 17
        THIS.obj_4c_OptSelecao.Buttons(2).Left     = 90
        THIS.obj_4c_OptSelecao.Buttons(2).Top      = 5
        THIS.obj_4c_OptSelecao.Buttons(2).Width    = 108
        THIS.obj_4c_OptSelecao.Buttons(2).ForeColor = RGB(90,90,90)
        THIS.obj_4c_OptSelecao.Buttons(2).AutoSize = .F.
        THIS.obj_4c_OptSelecao.Buttons(2).Themes   = .F.
        THIS.obj_4c_OptSelecao.Buttons(2).BackStyle = 0

        THIS.obj_4c_OptSelecao.Buttons(3).Caption  = "Todas"
        THIS.obj_4c_OptSelecao.Buttons(3).Height   = 17
        THIS.obj_4c_OptSelecao.Buttons(3).Left     = 200
        THIS.obj_4c_OptSelecao.Buttons(3).Top      = 5
        THIS.obj_4c_OptSelecao.Buttons(3).Width    = 55
        THIS.obj_4c_OptSelecao.Buttons(3).ForeColor = RGB(90,90,90)
        THIS.obj_4c_OptSelecao.Buttons(3).AutoSize = .F.
        THIS.obj_4c_OptSelecao.Buttons(3).Themes   = .F.
        THIS.obj_4c_OptSelecao.Buttons(3).BackStyle = 0
        THIS.obj_4c_OptSelecao.Buttons(3).FontName  = "Verdana"
        THIS.obj_4c_OptSelecao.Buttons(3).FontSize  = 8

        *-- Say14: "Tipo :"
        THIS.AddObject("lbl_4c_Label14", "Label")
        WITH THIS.lbl_4c_Label14
            .Caption   = "Tipo :"
            .Left      = 144
            .Top       = 483
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 46
            .Visible   = .T.
        ENDWITH

        *-- optTipo (2 botoes: Relacao, Detalhado)
        THIS.AddObject("obj_4c_OptTipo", "OptionGroup")
        THIS.obj_4c_OptTipo.ButtonCount = 2

        WITH THIS.obj_4c_OptTipo
            .BorderStyle = 0
            .Value       = 1
            .Height      = 19
            .Left        = 170
            .Top         = 483
            .Width       = 194
            .BackColor   = RGB(240,240,240)
            .TabIndex    = 47
            .Visible     = .T.
        ENDWITH

        THIS.obj_4c_OptTipo.Buttons(1).Caption  = "Rela" + CHR(231) + CHR(227) + "o"
        THIS.obj_4c_OptTipo.Buttons(1).Height   = 17
        THIS.obj_4c_OptTipo.Buttons(1).Left     = 5
        THIS.obj_4c_OptTipo.Buttons(1).Top      = 1
        THIS.obj_4c_OptTipo.Buttons(1).Width    = 96
        THIS.obj_4c_OptTipo.Buttons(1).ForeColor = RGB(90,90,90)
        THIS.obj_4c_OptTipo.Buttons(1).AutoSize = .F.
        THIS.obj_4c_OptTipo.Buttons(1).Themes   = .F.
        THIS.obj_4c_OptTipo.Buttons(1).BackStyle = 0

        THIS.obj_4c_OptTipo.Buttons(2).Caption  = "Detalhado"
        THIS.obj_4c_OptTipo.Buttons(2).Height   = 17
        THIS.obj_4c_OptTipo.Buttons(2).Left     = 90
        THIS.obj_4c_OptTipo.Buttons(2).Top      = 1
        THIS.obj_4c_OptTipo.Buttons(2).Width    = 108
        THIS.obj_4c_OptTipo.Buttons(2).ForeColor = RGB(90,90,90)
        THIS.obj_4c_OptTipo.Buttons(2).BackColor = RGB(240,240,240)
        THIS.obj_4c_OptTipo.Buttons(2).AutoSize = .F.
        THIS.obj_4c_OptTipo.Buttons(2).Themes   = .F.
        THIS.obj_4c_OptTipo.Buttons(2).BackStyle = 0

        *-- Say15: "Ultima Subclassificacao :"
        THIS.AddObject("lbl_4c_Label15", "Label")
        WITH THIS.lbl_4c_Label15
            .Caption   = CHR(218) + "ltima Subclassifica" + CHR(231) + CHR(227) + "o :"
            .Left      = 55
            .Top       = 505
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .TabIndex  = 48
            .Visible   = .T.
        ENDWITH

        *-- OptSubClas (2 botoes: Sim, Nao)
        THIS.AddObject("obj_4c_OptSubClas", "OptionGroup")
        THIS.obj_4c_OptSubClas.ButtonCount = 2

        WITH THIS.obj_4c_OptSubClas
            .BorderStyle = 0
            .Value       = 2
            .Height      = 22
            .Left        = 170
            .Top         = 500
            .Width       = 194
            .BackColor   = RGB(240,240,240)
            .TabIndex    = 49
            .Visible     = .T.
        ENDWITH

        THIS.obj_4c_OptSubClas.Buttons(1).Caption  = "Sim"
        THIS.obj_4c_OptSubClas.Buttons(1).Height   = 17
        THIS.obj_4c_OptSubClas.Buttons(1).Left     = 5
        THIS.obj_4c_OptSubClas.Buttons(1).Top      = 5
        THIS.obj_4c_OptSubClas.Buttons(1).Width    = 96
        THIS.obj_4c_OptSubClas.Buttons(1).ForeColor = RGB(90,90,90)
        THIS.obj_4c_OptSubClas.Buttons(1).AutoSize = .F.
        THIS.obj_4c_OptSubClas.Buttons(1).Themes   = .F.
        THIS.obj_4c_OptSubClas.Buttons(1).BackStyle = 0

        THIS.obj_4c_OptSubClas.Buttons(2).Caption  = "N" + CHR(227) + "o"
        THIS.obj_4c_OptSubClas.Buttons(2).Height   = 17
        THIS.obj_4c_OptSubClas.Buttons(2).Left     = 90
        THIS.obj_4c_OptSubClas.Buttons(2).Top      = 5
        THIS.obj_4c_OptSubClas.Buttons(2).Width    = 108
        THIS.obj_4c_OptSubClas.Buttons(2).ForeColor = RGB(90,90,90)
        THIS.obj_4c_OptSubClas.Buttons(2).AutoSize = .F.
        THIS.obj_4c_OptSubClas.Buttons(2).Themes   = .F.
        THIS.obj_4c_OptSubClas.Buttons(2).BackStyle = 0

    ENDPROC

    *==========================================================================
    * CARREGARCURSORESAUXILIARES - Carrega crSigCdPam via SQLEXEC
    *==========================================================================
    PROCEDURE CarregarCursoresAuxiliares
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .T.

        TRY
            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF

            *-- Carrega parametros de grupo de cliente da tabela SigCdPam
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT GrPadClis FROM SigCdPam", "cursor_4c_Pam_Temp")
            IF loc_nResult > 0
                SELECT * FROM cursor_4c_Pam_Temp INTO CURSOR crSigCdPam READWRITE
                IF USED("cursor_4c_Pam_Temp")
                    USE IN cursor_4c_Pam_Temp
                ENDIF
                IF RECCOUNT("crSigCdPam") > 0
                    SELECT crSigCdPam
                    GO TOP
                ENDIF
            ELSE
                *-- Cursor vazio como fallback
                CREATE CURSOR crSigCdPam (GrPadClis C(10))
                APPEND BLANK
            ENDIF

        CATCH TO loc_oErro
            *-- Cursor vazio como fallback seguro
            IF !USED("crSigCdPam")
                CREATE CURSOR crSigCdPam (GrPadClis C(10))
                APPEND BLANK
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CONFIGURAREVENTOS - BINDEVENT para botoes e handlers LostFocus
    *==========================================================================
    PROCEDURE ConfigurarEventos

        *-- Botoes de relatorio
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

        *-- Atendente
        BINDEVENT(THIS.txt_4c_Atendente,  "KeyPress", THIS, "ValidarAtendente")

        *-- Cliente / NomeCli
        BINDEVENT(THIS.txt_4c_Cliente,    "KeyPress", THIS, "ValidarCliente")
        BINDEVENT(THIS.txt_4c_NomCli,     "KeyPress", THIS, "ValidarNomCli")

        *-- Classificacao
        BINDEVENT(THIS.txt_4c_Class,      "KeyPress", THIS, "ValidarClass")

        *-- Empresa
        BINDEVENT(THIS.txt_4c_Emp,        "KeyPress", THIS, "ValidarEmp")
        BINDEVENT(THIS.txt_4c_Demp,       "KeyPress", THIS, "ValidarDemp")

        *-- Departamento
        BINDEVENT(THIS.txt_4c_CodDep,     "KeyPress", THIS, "ValidarCodDep")
        BINDEVENT(THIS.txt_4c_DesDep,     "KeyPress", THIS, "ValidarDesDep")

        *-- Gerente
        BINDEVENT(THIS.txt_4c_CodGer,     "KeyPress", THIS, "ValidarCodGer")
        BINDEVENT(THIS.txt_4c_NomGer,     "KeyPress", THIS, "ValidarNomGer")

        *-- Vendedor
        BINDEVENT(THIS.txt_4c_CodVen,     "KeyPress", THIS, "ValidarCodVen")
        BINDEVENT(THIS.txt_4c_NomVen,     "KeyPress", THIS, "ValidarNomVen")

        *-- Produto
        BINDEVENT(THIS.txt_4c_CodProd,    "KeyPress", THIS, "ValidarCodProd")
        BINDEVENT(THIS.txt_4c_DesProd,    "KeyPress", THIS, "ValidarDesProd")

        *-- Colecao / Grupo de Venda
        BINDEVENT(THIS.txt_4c_CodCol,     "KeyPress", THIS, "ValidarCodCol")
        BINDEVENT(THIS.txt_4c_DesCol,     "KeyPress", THIS, "ValidarDesCol")

        *-- Subclassificacoes
        BINDEVENT(THIS.txt_4c_SubClass,   "KeyPress", THIS, "ValidarSubClass")
        BINDEVENT(THIS.txt_4c_SubClassE,  "KeyPress", THIS, "ValidarSubClassE")
        BINDEVENT(THIS.txt_4c_SubClassS,  "KeyPress", THIS, "ValidarSubClassS")

    ENDPROC

    *==========================================================================
    * FORMPARARELATORIO - Le valores do form para o BO
    *==========================================================================
    PROCEDURE FormParaRelatorio
        RETURN .T.
    ENDPROC

    *==========================================================================
    * PROCESSAMENTO - Executa SQL e monta cursores para o relatorio
    *==========================================================================
    PROCEDURE Processamento
        LOCAL loc_lSucesso
        LOCAL loc_ldDtIni, loc_ldDtFin, loc_ldPvIni, loc_ldPvFin
        LOCAL loc_lcAtende, loc_lcClient, loc_lcNomCli, loc_lcClass
        LOCAL loc_lnSelecao, loc_lnOrdem, loc_lcCodEmp, loc_lcNomEmp
        LOCAL loc_lcCodDep, loc_lcDesDep, loc_lcCodGer, loc_lcNomGer
        LOCAL loc_lcCodVen, loc_lcNomVen, loc_lcCodPro, loc_lcDesPro
        LOCAL loc_lcCodCol, loc_lcDesCol, loc_lcSubCla, loc_lcSubClaE, loc_lcSubClaS
        LOCAL loc_lnTipo, loc_lnOptSubC, loc_lcPriors
        LOCAL loc_lcEmpresa, loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo
        LOCAL loc_lcSubTit1, loc_lcSubTit2, loc_lcSubTit3, loc_lcSubTit4
        LOCAL loc_lcSubTit5, loc_lcSubTit6, loc_lcSubTit7, loc_lcSubTit8
        LOCAL loc_lcSubTit9, loc_lcSubTit10, loc_lcSubTit11
        LOCAL loc_lcOrder, loc_lcGrupo, loc_lcQuery
        LOCAL loc_nResult, loc_lnEncerradas, loc_lnNaoEncerra, loc_lnTodas, loc_lnNumos

        loc_lSucesso = .T.

        TRY
            *-- Coletar valores dos campos do form
            loc_ldDtIni   = THIS.txt_4c_DtInicial.Value
            loc_ldDtFin   = THIS.txt_4c_DtFinal.Value
            loc_lcAtende  = ALLTRIM(THIS.txt_4c_Atendente.Value)
            loc_lcClient  = ALLTRIM(THIS.txt_4c_Cliente.Value)
            loc_lcNomCli  = ALLTRIM(THIS.txt_4c_NomCli.Value)
            loc_lcCodEmp  = ALLTRIM(THIS.txt_4c_Emp.Value)
            loc_lcNomEmp  = ALLTRIM(THIS.txt_4c_Demp.Value)
            loc_lcCodDep  = ALLTRIM(THIS.txt_4c_CodDep.Value)
            loc_lcDesDep  = ALLTRIM(THIS.txt_4c_DesDep.Value)
            loc_lcCodGer  = ALLTRIM(THIS.txt_4c_CodGer.Value)
            loc_lcNomGer  = ALLTRIM(THIS.txt_4c_NomGer.Value)
            loc_lcCodVen  = ALLTRIM(THIS.txt_4c_CodVen.Value)
            loc_lcNomVen  = ALLTRIM(THIS.txt_4c_NomVen.Value)
            loc_lcCodPro  = ALLTRIM(THIS.txt_4c_CodProd.Value)
            loc_lcDesPro  = ALLTRIM(THIS.txt_4c_DesProd.Value)
            loc_lcCodCol  = ALLTRIM(THIS.txt_4c_CodCol.Value)
            loc_lcDesCol  = ALLTRIM(THIS.txt_4c_DesCol.Value)
            loc_lcClass   = ALLTRIM(THIS.txt_4c_Class.Value)
            loc_lnSelecao = THIS.obj_4c_OptSelecao.Value
            loc_lnOrdem   = THIS.cbo_4c_CmbOrdem.Value
            loc_lcSubCla  = ALLTRIM(THIS.txt_4c_SubClass.Value)
            loc_lcSubClaE = ALLTRIM(THIS.txt_4c_SubClassE.Value)
            loc_lcSubClaS = ALLTRIM(THIS.txt_4c_SubClassS.Value)
            loc_lnTipo    = THIS.obj_4c_OptTipo.Value
            loc_lnOptSubC = THIS.obj_4c_OptSubClas.Value
            loc_lcPriors  = ALLTRIM(THIS.cbo_4c_CmbPrioridade.DisplayValue)

            *-- Datas de agendamento: so usar se AMBOS preenchidos
            IF !EMPTY(THIS.txt_4c_PvIni.Value) AND !EMPTY(THIS.txt_4c_PvFin.Value)
                loc_ldPvIni = THIS.txt_4c_PvIni.Value
                loc_ldPvFin = THIS.txt_4c_PvFin.Value
            ELSE
                loc_ldPvIni = {}
                loc_ldPvFin = {}
            ENDIF

            *-- Buscar empresa para cabecalho
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT Razas FROM SigCdEmp WHERE Cemps = '" + ALLTRIM(go_4c_Sistema.cCodEmpresa) + "'", "cursor_4c_Emp_Hdr")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Emp_Hdr") > 0
                SELECT cursor_4c_Emp_Hdr
                GO TOP
                loc_lcEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(cursor_4c_Emp_Hdr.Razas)
            ELSE
                loc_lcEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF
            IF USED("cursor_4c_Emp_Hdr")
                USE IN cursor_4c_Emp_Hdr
            ENDIF

            *-- Montar strings de cabecalho/periodo
            loc_lcPeriodo = "Per" + CHR(237) + "odo : " + DTOC(loc_ldDtIni) + " " + CHR(224) + " " + DTOC(loc_ldDtFin)
            IF !EMPTY(loc_ldPvIni)
                loc_lcPeriodo = loc_lcPeriodo + "    Prev. de Agendamento : " + DTOC(loc_ldPvIni) + " " + CHR(224) + " " + DTOC(loc_ldPvFin)
            ENDIF

            loc_lcTitulo = "Anal" + CHR(237) + "tico de Atendimentos / Pend" + CHR(234) + "ncias - " + ;
                IIF(loc_lnSelecao = 1, "(Encerradas)", IIF(loc_lnSelecao = 2, "(" + CHR(78) + CHR(227) + "o Encerradas)", "(Todas)"))

            loc_lcSubTit = IIF(!EMPTY(loc_lcAtende), "Atendente : " + loc_lcAtende, "") + "(por "

            DO CASE
                CASE loc_lnOrdem = 1
                    loc_lcSubTit = loc_lcSubTit + " Data"
                    loc_lcOrder  = "a.DtAberts, a.HrAberts, a.Numos"
                CASE loc_lnOrdem = 2
                    loc_lcSubTit = loc_lcSubTit + " OS"
                    loc_lcOrder  = "a.Numos, a.DtAberts, a.HrAberts"
                CASE loc_lnOrdem = 3
                    loc_lcSubTit = loc_lcSubTit + " Cliente"
                    loc_lcOrder  = "a.CodClis, a.DtAberts, a.HrAberts"
                CASE loc_lnOrdem = 4
                    loc_lcSubTit = loc_lcSubTit + " Atendente"
                    loc_lcOrder  = "a.Atends, a.DtAberts, a.HrAberts"
                CASE loc_lnOrdem = 5
                    loc_lcSubTit = loc_lcSubTit + " Classifica" + CHR(231) + CHR(227) + "o"
                    loc_lcOrder  = "a.Class, a.DtAberts, a.HrAberts"
                CASE loc_lnOrdem = 6
                    loc_lcSubTit = loc_lcSubTit + " Departamento"
                    loc_lcOrder  = "a.CodDeps, a.Class, a.DtAberts, a.HrAberts"
                OTHERWISE
                    loc_lcSubTit = loc_lcSubTit + " Data"
                    loc_lcOrder  = "a.DtAberts, a.HrAberts, a.Numos"
            ENDCASE

            loc_lcSubTit1  = IIF(!EMPTY(loc_lcClient), "Cliente : " + loc_lcClient + "-" + loc_lcNomCli, "")
            loc_lcSubTit2  = IIF(!EMPTY(loc_lcClass),  "Classifica" + CHR(231) + CHR(227) + "o : " + loc_lcClass, "")
            loc_lcSubTit3  = IIF(!EMPTY(loc_lcCodEmp), "Empresa : " + loc_lcCodEmp + "-" + loc_lcNomEmp, "")
            loc_lcSubTit4  = IIF(!EMPTY(loc_lcCodDep), "Departamento : " + loc_lcCodDep + "-" + loc_lcDesDep, "")
            loc_lcSubTit5  = IIF(!EMPTY(loc_lcCodGer), "Gerente : " + loc_lcCodGer + "-" + loc_lcNomGer, "")
            loc_lcSubTit6  = IIF(!EMPTY(loc_lcCodVen), "Vendedor : " + loc_lcCodVen + "-" + loc_lcNomVen, "")
            loc_lcSubTit7  = IIF(!EMPTY(loc_lcCodPro), "Produto : " + loc_lcCodPro + "-" + loc_lcDesPro, "")
            loc_lcSubTit8  = IIF(!EMPTY(loc_lcCodCol), "Grupo de Venda : " + loc_lcCodCol + "-" + loc_lcDesCol, "")
            loc_lcSubTit9  = IIF(!EMPTY(loc_lcSubCla),  "SubClassifica" + CHR(231) + CHR(227) + "o : " + loc_lcSubCla, "")
            loc_lcSubTit10 = IIF(!EMPTY(loc_lcSubClaE), "SubClassifica" + CHR(231) + CHR(227) + "o Entrada : " + loc_lcSubClaE, "")
            loc_lcSubTit11 = IIF(!EMPTY(loc_lcSubClaS), "SubClassifica" + CHR(231) + CHR(227) + "o Saida : " + loc_lcSubClaS, "")

            loc_lcSubTit = loc_lcSubTit + ")" + ;
                IIF(EMPTY(loc_lcSubTit1),  "", CHR(13) + loc_lcSubTit1)  + ;
                IIF(EMPTY(loc_lcSubTit2),  "", CHR(13) + loc_lcSubTit2)  + ;
                IIF(EMPTY(loc_lcSubTit3),  "", CHR(13) + loc_lcSubTit3)  + ;
                IIF(EMPTY(loc_lcSubTit4),  "", CHR(13) + loc_lcSubTit4)  + ;
                IIF(EMPTY(loc_lcSubTit5),  "", CHR(13) + loc_lcSubTit5)  + ;
                IIF(EMPTY(loc_lcSubTit6),  "", CHR(13) + loc_lcSubTit6)  + ;
                IIF(EMPTY(loc_lcSubTit7),  "", CHR(13) + loc_lcSubTit7)  + ;
                IIF(EMPTY(loc_lcSubTit8),  "", CHR(13) + loc_lcSubTit8)  + ;
                IIF(EMPTY(loc_lcSubTit9),  "", CHR(13) + loc_lcSubTit9)  + ;
                IIF(EMPTY(loc_lcSubTit10), "", CHR(13) + loc_lcSubTit10) + ;
                IIF(EMPTY(loc_lcSubTit11), "", CHR(13) + loc_lcSubTit11)

            *-- Criar cursor de cabecalho
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (Empresa C(80), Titulo M(4), Subtitulo M(4), Periodo C(100), Fim C(80))
            INSERT INTO csCabecalho (Empresa, Titulo, SubTitulo, Periodo) ;
                VALUES (loc_lcEmpresa, loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo)

            *-- Montar query SQL principal
            loc_lcQuery = "Select a.Numos, a.DtAberts, a.DtEncs, a.HrAberts, a.CodClis, b.RClis, a.Atends, " + ;
                "a.Obss, a.Class, a.Emps, a.CodDeps, a.CodGers, a.CodVens, a.cPros, a.Colecoes, " + ;
                "c.DtAtends, c.Atends As AtendFase, c.HrAtends, c.Obss As ObsFase, c.cSubClas, " + ;
                "a.SubClassS, a.SubClassE, d.DPros, e.rCLis As Fornec, a.Priors, c.DtPrevs, b.cpfs " + ;
                "From SigCdSOs a " + ;
                "Inner Join SigCdCli b on a.CodClis = b.IClis " + ;
                "Left Join SigCdSOi c on a.Numos = c.Numos " + ;
                "Left Join SigCdPro d on a.cPros = d.cPros " + ;
                "Left Join SigCdCli e on d.iFors = e.iCLis " + ;
                "Where a.DtAberts Between " + FormatarDataSQL(loc_ldDtIni) + " And " + FormatarDataSQL(loc_ldDtFin)

            IF !EMPTY(loc_lcAtende)
                loc_lcQuery = loc_lcQuery + " And a.Atends = " + EscaparSQL(loc_lcAtende)
            ENDIF
            IF !EMPTY(loc_lcClient)
                loc_lcQuery = loc_lcQuery + " And a.CodClis = " + EscaparSQL(loc_lcClient)
            ENDIF
            IF !EMPTY(loc_lcClass)
                loc_lcQuery = loc_lcQuery + " And a.Class = " + EscaparSQL(loc_lcClass)
            ENDIF
            IF !EMPTY(loc_lcCodEmp)
                loc_lcQuery = loc_lcQuery + " And a.Emps = " + EscaparSQL(loc_lcCodEmp)
            ENDIF
            IF !EMPTY(loc_lcCodDep)
                loc_lcQuery = loc_lcQuery + " And a.CodDeps = " + EscaparSQL(loc_lcCodDep)
            ENDIF
            IF !EMPTY(loc_lcCodGer)
                loc_lcQuery = loc_lcQuery + " And a.CodGers = " + EscaparSQL(loc_lcCodGer)
            ENDIF
            IF !EMPTY(loc_lcCodVen)
                loc_lcQuery = loc_lcQuery + " And a.CodVens = " + EscaparSQL(loc_lcCodVen)
            ENDIF
            IF !EMPTY(loc_lcCodPro)
                loc_lcQuery = loc_lcQuery + " And a.CPros = " + EscaparSQL(loc_lcCodPro)
            ENDIF
            IF !EMPTY(loc_lcCodCol)
                loc_lcQuery = loc_lcQuery + " And a.Colecoes = " + EscaparSQL(loc_lcCodCol)
            ENDIF
            IF !EMPTY(loc_lcPriors)
                loc_lcQuery = loc_lcQuery + " And a.Priors = " + EscaparSQL(loc_lcPriors)
            ENDIF
            *-- SubClassificacao geral: filtrar por cSubClas apenas quando OptSubClas=2 (Nao = sem filtro por ultima)
            *-- Quando OptSubClas=1 (Sim), o filtro e feito pos-query via DELETE
            IF !EMPTY(loc_lcSubCla) AND loc_lnOptSubC = 2
                loc_lcQuery = loc_lcQuery + " And c.cSubClas = " + EscaparSQL(loc_lcSubCla)
            ENDIF
            IF !EMPTY(loc_lcSubClaE)
                loc_lcQuery = loc_lcQuery + " And a.SubClassE = " + EscaparSQL(loc_lcSubClaE)
            ENDIF
            IF !EMPTY(loc_lcSubClaS)
                loc_lcQuery = loc_lcQuery + " And a.SubClassS = " + EscaparSQL(loc_lcSubClaS)
            ENDIF
            IF loc_lnSelecao = 1
                loc_lcQuery = loc_lcQuery + " And Not a.DtEncs Is Null "
            ENDIF
            IF loc_lnSelecao = 2
                loc_lcQuery = loc_lcQuery + " And a.DtEncs Is Null "
            ENDIF
            IF !EMPTY(loc_ldPvIni) AND !EMPTY(loc_ldPvFin)
                loc_lcQuery = loc_lcQuery + " And a.NumOs in (Select f.Numos From SigCdSOi f Where f.NumOs = a.NumOs And f.DtPrevs Between " + FormatarDataSQL(loc_ldPvIni) + " And " + FormatarDataSQL(loc_ldPvFin) + ")"
            ENDIF
            loc_lcQuery = loc_lcQuery + " Order By " + loc_lcOrder

            *-- Executar query principal via SQLEXEC (padrao READWRITE)
            IF USED("csImprimir")
                USE IN csImprimir
            ENDIF
            IF USED("cursor_4c_csImpr_Temp")
                USE IN cursor_4c_csImpr_Temp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_csImpr_Temp")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!")
                loc_lSucesso = .F.
            ENDIF

            IF loc_lSucesso
                SELECT * FROM cursor_4c_csImpr_Temp INTO CURSOR csImprimir READWRITE
                IF USED("cursor_4c_csImpr_Temp")
                    USE IN cursor_4c_csImpr_Temp
                ENDIF

                *-- Limpar duplicatas de CR/LF nos memos de observacao
                SELECT csImprimir
                SCAN
                    LOCAL loc_lcObsFase, loc_lcObss, loc_llChr
                    loc_lcObsFase = ALLTRIM(csImprimir.ObsFase)
                    *-- Normalizar separadores duplos (CR)
                    loc_lcObsFase = STRTRAN(STRTRAN(STRTRAN(loc_lcObsFase, CHR(13)+CHR(13), CHR(13)), CHR(13)+CHR(13), CHR(13)), CHR(13)+CHR(13), CHR(13))
                    loc_lcObsFase = STRTRAN(STRTRAN(STRTRAN(loc_lcObsFase, CHR(10)+CHR(10), CHR(10)), CHR(10)+CHR(10), CHR(10)), CHR(10)+CHR(10), CHR(10))
                    *-- Remover trailing CR/LF
                    loc_llChr = .T.
                    DO WHILE loc_llChr
                        loc_lcObsFase = ALLTRIM(loc_lcObsFase)
                        IF INLIST(RIGHT(loc_lcObsFase, 1), CHR(13), CHR(10))
                            loc_lcObsFase = SUBSTR(loc_lcObsFase, 1, LEN(loc_lcObsFase)-1)
                        ELSE
                            loc_llChr = .F.
                        ENDIF
                    ENDDO
                    REPLACE ObsFase WITH loc_lcObsFase IN csImprimir

                    loc_lcObss = ALLTRIM(csImprimir.Obss)
                    loc_lcObss = STRTRAN(STRTRAN(STRTRAN(loc_lcObss, CHR(13)+CHR(13), CHR(13)), CHR(13)+CHR(13), CHR(13)), CHR(13)+CHR(13), CHR(13))
                    loc_lcObss = STRTRAN(STRTRAN(STRTRAN(loc_lcObss, CHR(10)+CHR(10), CHR(10)), CHR(10)+CHR(10), CHR(10)), CHR(10)+CHR(10), CHR(10))
                    loc_llChr = .T.
                    DO WHILE loc_llChr
                        loc_lcObss = ALLTRIM(loc_lcObss)
                        IF INLIST(RIGHT(loc_lcObss, 1), CHR(13), CHR(10))
                            loc_lcObss = SUBSTR(loc_lcObss, 1, LEN(loc_lcObss)-1)
                        ELSE
                            loc_llChr = .F.
                        ENDIF
                    ENDDO
                    REPLACE Obss WITH loc_lcObss IN csImprimir
                ENDSCAN

                *-- Limpar pontuacao do CPF
                REPLACE ALL cpfs WITH CHRTRAN(cpfs, ".-/", "") IN csImprimir

                *-- Indexar por NumOs desc para manter ultima fase (mais recente)
                SELECT csImprimir
                INDEX ON STR(Numos) + DTOS(DtAtends) + HrAtends TAG Fases DESCENDING
                SET ORDER TO Fases
                GO TOP

                *-- Excluir duplicatas de NumOs (manter apenas a mais recente)
                loc_lnNumos = 0
                SCAN
                    IF loc_lnNumos <> Numos
                        loc_lnNumos = Numos
                    ELSE
                        DELETE
                    ENDIF
                ENDSCAN

                *-- Reindexar na ordem de exibicao final
                DO CASE
                    CASE loc_lnOrdem = 1
                        INDEX ON DTOS(DtAberts)+HrAberts+STR(Numos) TAG DtHrNum
                        SET ORDER TO DtHrNum
                    CASE loc_lnOrdem = 2
                        INDEX ON STR(Numos)+DTOS(DtAberts)+HrAberts TAG NumDtHr
                        SET ORDER TO NumDtHr
                    CASE loc_lnOrdem = 3
                        INDEX ON CodClis+DTOS(DtAberts)+HrAberts TAG CliDtHr
                        SET ORDER TO CliDtHr
                    CASE loc_lnOrdem = 4
                        INDEX ON Atends+DTOS(DtAberts)+HrAberts TAG AtDtHr
                        SET ORDER TO AtDtHr
                    CASE loc_lnOrdem = 5
                        INDEX ON Class+DTOS(DtAberts)+HrAberts TAG ClDtHr
                        SET ORDER TO ClDtHr
                    CASE loc_lnOrdem = 6
                        INDEX ON CodDeps+Class+DTOS(DtAberts)+HrAberts TAG DpClDtHr
                        SET ORDER TO DpClDtHr
                ENDCASE

                *-- Filtrar por ultima subclassificacao (OptSubClas=1=Sim)
                IF loc_lnOptSubC = 1 AND !EMPTY(loc_lcSubCla)
                    DELETE FOR cSubClas <> loc_lcSubCla
                    GO TOP
                ENDIF

                *-- Contar encerradas/nao-encerradas
                LOCAL loc_lnEncerradas, loc_lnNaoEncerra, loc_lnTodas
                loc_lnEncerradas = 0
                loc_lnNaoEncerra = 0
                COUNT FOR !EMPTY(csImprimir.DtEncs) TO loc_lnEncerradas
                COUNT FOR  EMPTY(csImprimir.DtEncs) TO loc_lnNaoEncerra
                loc_lnTodas = loc_lnEncerradas + loc_lnNaoEncerra

                REPLACE Fim WITH ;
                    "Encerradas : "      + ALLTRIM(STR(loc_lnEncerradas)) + " - " + ;
                    "N" + CHR(227) + "o Encerradas : " + ALLTRIM(STR(loc_lnNaoEncerra)) + " - " + ;
                    "Todas : "           + ALLTRIM(STR(loc_lnTodas)) ;
                    IN csCabecalho

                SELECT csImprimir
                GO TOP

                *-- Se detalhado e ha registros, montar crCabecalho
                IF loc_lnTipo = 2 AND RECCOUNT("csImprimir") > 0
                    THIS.Detalhado()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro no processamento: " + loc_oErro.Message)
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * VISUALIZACAO - Exibe relatorio em tela
    *==========================================================================
    PROCEDURE Visualizacao
        LOCAL loc_lcRelPath
        IF THIS.obj_4c_OptTipo.Value = 1
            loc_lcRelPath = gc_4c_Reports + "SigAtCrp"
            REPORT FORM &loc_lcRelPath PREVIEW NOCONSOLE
        ELSE
            loc_lcRelPath = gc_4c_Reports + "SigAtCrz"
            REPORT FORM &loc_lcRelPath PREVIEW NOCONSOLE
        ENDIF
    ENDPROC

    *==========================================================================
    * IMPRESSAO - Envia relatorio para impressora
    *==========================================================================
    PROCEDURE Impressao
        LOCAL loc_lcRelPath
        IF THIS.obj_4c_OptTipo.Value = 1
            loc_lcRelPath = gc_4c_Reports + "SigAtCrp"
            REPORT FORM &loc_lcRelPath TO PRINTER PROMPT NOCONSOLE
        ELSE
            loc_lcRelPath = gc_4c_Reports + "SigAtCrz"
            REPORT FORM &loc_lcRelPath TO PRINTER PROMPT NOCONSOLE
        ENDIF
    ENDPROC

    *==========================================================================
    * DOCUMENTO - Exporta documento (impressao direta sem prompt)
    *==========================================================================
    PROCEDURE Documento
        LOCAL loc_lcRelPath
        IF THIS.obj_4c_OptTipo.Value = 1
            loc_lcRelPath = gc_4c_Reports + "SigAtCrp"
            REPORT FORM &loc_lcRelPath TO PRINTER PROMPT NOCONSOLE
        ELSE
            loc_lcRelPath = gc_4c_Reports + "SigAtCrz"
            REPORT FORM &loc_lcRelPath TO PRINTER PROMPT NOCONSOLE
        ENDIF
    ENDPROC

    *==========================================================================
    * MEMAIL - Envio por email (gera relatorio e chama DoDefault)
    *==========================================================================
    PROCEDURE MEmail
        LOCAL loc_lcRelPath
        IF THIS.obj_4c_OptTipo.Value = 1
            loc_lcRelPath = gc_4c_Reports + "SigAtCrp"
            REPORT FORM &loc_lcRelPath TO PRINTER NOCONSOLE
        ELSE
            loc_lcRelPath = gc_4c_Reports + "SigAtCrz"
            REPORT FORM &loc_lcRelPath TO PRINTER NOCONSOLE
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * DETALHADO - Monta cursor crCabecalho para relatorio detalhado
    *==========================================================================
    PROCEDURE Detalhado
        LOCAL loc_lSucesso, loc_nResult, loc_lnCnt, loc_i
        LOCAL loc_lcNumOs

        loc_lSucesso = .T.

        TRY
            *-- Criar cursor crCabecalho com estrutura completa
            IF USED("crCabecalho")
                USE IN crCabecalho
            ENDIF

            SET NULL ON
            CREATE CURSOR crCabecalho ( ;
                NumOs      N(10),   ;
                CodClis    C(10),   ;
                Class      C(10),   ;
                DtAberts   D(8),    ;
                HrAberts   C(5),    ;
                CabAtends  C(10),   ;
                Publs      C(10),   ;
                DesPubls   C(50),   ;
                CabObss    M(4),    ;
                Emps       C(10),   ;
                Razas      C(50),   ;
                Cpfs       C(14),   ;
                RClis      C(50),   ;
                Endes      C(50),   ;
                Nums       C(10),   ;
                Compls     C(20),   ;
                Ceps       C(9),    ;
                Cidas      C(30),   ;
                Bairs      C(30),   ;
                Estas      C(2),    ;
                Ddds       C(4),    ;
                Tel1s      C(15),   ;
                Tel2s      C(15),   ;
                eMails     C(60),   ;
                CodDeps    C(10),   ;
                NComps     C(30),   ;
                CodGers    C(10),   ;
                DesGers    C(50),   ;
                CodVens    C(10),   ;
                DesVens    C(50),   ;
                CPros      C(14),   ;
                DPros      C(65),   ;
                Colecoes   C(10),   ;
                DesCol     C(40),   ;
                AtdEncs    C(10),   ;
                DtEncs     D(8),    ;
                HrEncs     C(5),    ;
                DtAtends   D(8),    ;
                Atends     C(10),   ;
                HrAtends   C(5),    ;
                CSubClas   C(50),   ;
                Obss       M(4)     ;
            )
            SET NULL OFF

            *-- SCAN no csImprimir para montar crCabecalho
            SELECT csImprimir
            SCAN
                loc_lcNumOs = csImprimir.Numos

                *-- Buscar dados completos do SigCdSOs
                IF USED("crSigCdSOs")
                    USE IN crSigCdSOs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdSOs WHERE NumOs = " + FormatarNumeroSQL(loc_lcNumOs), ;
                    "cursor_4c_SOs_Temp")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_SOs_Temp") > 0
                    SELECT * FROM cursor_4c_SOs_Temp INTO CURSOR crSigCdSOs READWRITE
                    IF USED("cursor_4c_SOs_Temp")
                        USE IN cursor_4c_SOs_Temp
                    ENDIF
                    SELECT crSigCdSOs
                    GO TOP
                ELSE
                    IF USED("cursor_4c_SOs_Temp")
                        USE IN cursor_4c_SOs_Temp
                    ENDIF
                    LOOP
                ENDIF

                *-- Inserir linha base no crCabecalho
                INSERT INTO crCabecalho (NumOs, CodClis, Class, DtAberts, HrAberts, CabAtends, Publs, CabObss, ;
                    Emps, CodDeps, CodGers, CodVens, CPros, Colecoes, AtdEncs, DtEncs, HrEncs) ;
                    VALUES (crSigCdSOs.NumOs, crSigCdSOs.CodClis, crSigCdSOs.Class, ;
                        NVL(crSigCdSOs.DtAberts, {}), crSigCdSOs.HrAberts, crSigCdSOs.Atends, ;
                        crSigCdSOs.Publs, NVL(crSigCdSOs.Obss, ""), crSigCdSOs.Emps, ;
                        crSigCdSOs.CodDeps, crSigCdSOs.CodGers, crSigCdSOs.CodVens, ;
                        crSigCdSOs.CPros, crSigCdSOs.Colecoes, crSigCdSOs.AtdEncs, ;
                        NVL(crSigCdSOs.DtEncs, {}), crSigCdSOs.HrEncs)

                *-- Preencher dados do cliente
                IF !EMPTY(crSigCdSOs.CodClis)
                    IF USED("cursor_4c_Cli_Det")
                        USE IN cursor_4c_Cli_Det
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT Cpfs, RClis, Endes, Nums, Compls, Ceps, Cidas, Bairs, Estas, Ddds, Tel1s, Tel2s, eMails " + ;
                        "FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(crSigCdSOs.CodClis)), ;
                        "cursor_4c_Cli_Det")
                    IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Cli_Det") > 0
                        SELECT cursor_4c_Cli_Det
                        GO TOP
                        REPLACE Cpfs   WITH cursor_4c_Cli_Det.Cpfs, ;
                                RClis  WITH cursor_4c_Cli_Det.RClis, ;
                                Endes  WITH cursor_4c_Cli_Det.Endes, ;
                                Nums   WITH cursor_4c_Cli_Det.Nums, ;
                                Compls WITH cursor_4c_Cli_Det.Compls, ;
                                Ceps   WITH cursor_4c_Cli_Det.Ceps, ;
                                Cidas  WITH cursor_4c_Cli_Det.Cidas, ;
                                Bairs  WITH cursor_4c_Cli_Det.Bairs, ;
                                Estas  WITH cursor_4c_Cli_Det.Estas, ;
                                Ddds   WITH cursor_4c_Cli_Det.Ddds, ;
                                Tel1s  WITH cursor_4c_Cli_Det.Tel1s, ;
                                Tel2s  WITH cursor_4c_Cli_Det.Tel2s, ;
                                eMails WITH cursor_4c_Cli_Det.eMails ;
                            IN crCabecalho
                    ENDIF
                    IF USED("cursor_4c_Cli_Det")
                        USE IN cursor_4c_Cli_Det
                    ENDIF
                ENDIF

                *-- Preencher descricao do publicador (SigCdFpb)
                IF !EMPTY(crSigCdSOs.CodClis) AND !EMPTY(crSigCdSOs.Publs)
                    IF USED("cursor_4c_FPubl")
                        USE IN cursor_4c_FPubl
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT Descs FROM SigCdFpb WHERE Cods = " + EscaparSQL(ALLTRIM(crSigCdSOs.Publs)), ;
                        "cursor_4c_FPubl")
                    IF loc_nResult > 0 AND RECCOUNT("cursor_4c_FPubl") > 0
                        SELECT cursor_4c_FPubl
                        GO TOP
                        REPLACE DesPubls WITH cursor_4c_FPubl.Descs IN crCabecalho
                    ENDIF
                    IF USED("cursor_4c_FPubl")
                        USE IN cursor_4c_FPubl
                    ENDIF
                ENDIF

                *-- Preencher razao social da empresa (SigCdEmp)
                IF !EMPTY(crSigCdSOs.Emps)
                    IF USED("cursor_4c_Emp_Det")
                        USE IN cursor_4c_Emp_Det
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(crSigCdSOs.Cemps)), ;
                        "cursor_4c_Emp_Det")
                    IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Emp_Det") > 0
                        SELECT cursor_4c_Emp_Det
                        GO TOP
                        REPLACE Razas WITH cursor_4c_Emp_Det.Razas IN crCabecalho
                    ENDIF
                    IF USED("cursor_4c_Emp_Det")
                        USE IN cursor_4c_Emp_Det
                    ENDIF
                ENDIF

                *-- Preencher nome do departamento (SigCdGpr por Grupos=Emps)
                IF !EMPTY(crSigCdSOs.CodDeps)
                    IF USED("cursor_4c_Grp_Det")
                        USE IN cursor_4c_Grp_Det
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT NComps FROM SigCdGpr WHERE Grupos = " + EscaparSQL(ALLTRIM(crSigCdSOs.Emps)), ;
                        "cursor_4c_Grp_Det")
                    IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Grp_Det") > 0
                        SELECT cursor_4c_Grp_Det
                        GO TOP
                        REPLACE NComps WITH cursor_4c_Grp_Det.NComps IN crCabecalho
                    ENDIF
                    IF USED("cursor_4c_Grp_Det")
                        USE IN cursor_4c_Grp_Det
                    ENDIF
                ENDIF

                *-- Preencher nome do gerente (SigCdCli por IClis=CodGers)
                IF !EMPTY(crSigCdSOs.CodGers)
                    IF USED("cursor_4c_Ger_Det")
                        USE IN cursor_4c_Ger_Det
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(crSigCdSOs.CodGers)), ;
                        "cursor_4c_Ger_Det")
                    IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Ger_Det") > 0
                        SELECT cursor_4c_Ger_Det
                        GO TOP
                        REPLACE DesGers WITH cursor_4c_Ger_Det.RClis IN crCabecalho
                    ENDIF
                    IF USED("cursor_4c_Ger_Det")
                        USE IN cursor_4c_Ger_Det
                    ENDIF
                ENDIF

                *-- Preencher nome do vendedor (SigCdCli por IClis=CodVens)
                IF !EMPTY(crSigCdSOs.CodVens)
                    IF USED("cursor_4c_Ven_Det")
                        USE IN cursor_4c_Ven_Det
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(crSigCdSOs.CodVens)), ;
                        "cursor_4c_Ven_Det")
                    IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Ven_Det") > 0
                        SELECT cursor_4c_Ven_Det
                        GO TOP
                        REPLACE DesVens WITH cursor_4c_Ven_Det.RClis IN crCabecalho
                    ENDIF
                    IF USED("cursor_4c_Ven_Det")
                        USE IN cursor_4c_Ven_Det
                    ENDIF
                ENDIF

                *-- Preencher descricao do produto (SigCdPro por CPros)
                IF !EMPTY(crSigCdSOs.CPros)
                    IF USED("cursor_4c_Pro_Det")
                        USE IN cursor_4c_Pro_Det
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(crSigCdSOs.CPros)), ;
                        "cursor_4c_Pro_Det")
                    IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Pro_Det") > 0
                        SELECT cursor_4c_Pro_Det
                        GO TOP
                        REPLACE DPros WITH cursor_4c_Pro_Det.DPros IN crCabecalho
                    ENDIF
                    IF USED("cursor_4c_Pro_Det")
                        USE IN cursor_4c_Pro_Det
                    ENDIF
                ENDIF

                *-- Preencher descricao da colecao (SigCdCol por colecoes)
                IF !EMPTY(crSigCdSOs.Colecoes)
                    IF USED("cursor_4c_Col_Det")
                        USE IN cursor_4c_Col_Det
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT Descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(ALLTRIM(crSigCdSOs.Colecoes)), ;
                        "cursor_4c_Col_Det")
                    IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Col_Det") > 0
                        SELECT cursor_4c_Col_Det
                        GO TOP
                        REPLACE DesCol WITH cursor_4c_Col_Det.Descs IN crCabecalho
                    ENDIF
                    IF USED("cursor_4c_Col_Det")
                        USE IN cursor_4c_Col_Det
                    ENDIF
                ENDIF

                *-- Salvar estado da linha atual do crCabecalho como memvars
                SELECT crCabecalho
                SCATTER MEMVAR MEMO

                *-- Buscar interacoes do SigCdSOI para este NumOs
                IF USED("LocalSacOI")
                    USE IN LocalSacOI
                ENDIF
                IF USED("cursor_4c_SOI_Temp")
                    USE IN cursor_4c_SOI_Temp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT DtAtends, Atends, HrAtends, CSubClas, Obss FROM SigCdSOI WHERE NumOs = " + FormatarNumeroSQL(loc_lcNumOs), ;
                    "cursor_4c_SOI_Temp")

                IF loc_nResult > 0
                    SELECT * FROM cursor_4c_SOI_Temp INTO CURSOR LocalSacOI READWRITE
                    IF USED("cursor_4c_SOI_Temp")
                        USE IN cursor_4c_SOI_Temp
                    ENDIF

                    SELECT LocalSacOI
                    DELETE FROM LocalSacOI WHERE EMPTY(DtAtends)
                    INDEX ON DTOS(DtAtends) TAG DtAtends
                    SET ORDER TO DtAtends

                    loc_lnCnt = 0
                    SELECT LocalSacOI
                    SCAN
                        IF loc_lnCnt > 0
                            INSERT INTO crCabecalho FROM MEMVAR
                        ENDIF

                        IF !EMPTY(LocalSacOI.DtAtends)
                            loc_lnCnt = loc_lnCnt + 1
                            REPLACE DtAtends WITH LocalSacOI.DtAtends, ;
                                    Atends   WITH LocalSacOI.Atends, ;
                                    HrAtends WITH LocalSacOI.HrAtends, ;
                                    CSubClas WITH LocalSacOI.CSubClas, ;
                                    Obss     WITH NVL(LocalSacOI.Obss, "") ;
                                IN crCabecalho
                        ENDIF
                    ENDSCAN

                    IF USED("LocalSacOI")
                        USE IN LocalSacOI
                    ENDIF
                ELSE
                    IF USED("cursor_4c_SOI_Temp")
                        USE IN cursor_4c_SOI_Temp
                    ENDIF
                ENDIF

                *-- Inserir 5 linhas espacadoras
                m.Atends = ""
                m.Obss   = ""
                FOR loc_i = 1 TO 5
                    INSERT INTO crCabecalho FROM MEMVAR
                NEXT loc_i

            ENDSCAN

            SELECT crCabecalho
            GO TOP IN crCabecalho

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro no detalhamento: " + loc_oErro.Message)
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BTNVISUALIZARCLICK - Valida datas e executa Processamento + Visualizacao
    *==========================================================================
    PROCEDURE BtnVisualizarClick
        IF EMPTY(THIS.txt_4c_DtInicial.Value) OR EMPTY(THIS.txt_4c_DtFinal.Value)
            MsgAviso("Datas Inicial e Final Devem Ser Informadas!!!")
            THIS.txt_4c_DtInicial.SetFocus
            RETURN
        ENDIF
        IF THIS.Processamento()
            THIS.Visualizacao()
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNIMPRIMIRCLICK - Valida datas e executa Processamento + Impressao
    *==========================================================================
    PROCEDURE BtnImprimirClick
        IF EMPTY(THIS.txt_4c_DtInicial.Value) OR EMPTY(THIS.txt_4c_DtFinal.Value)
            MsgAviso("Datas Inicial e Final Devem Ser Informadas!!!")
            THIS.txt_4c_DtInicial.SetFocus
            RETURN
        ENDIF
        IF THIS.Processamento()
            THIS.Impressao()
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNEXCELCLICK - Exporta para Excel
    *==========================================================================
    PROCEDURE BtnExcelClick
        IF EMPTY(THIS.txt_4c_DtInicial.Value) OR EMPTY(THIS.txt_4c_DtFinal.Value)
            MsgAviso("Datas Inicial e Final Devem Ser Informadas!!!")
            THIS.txt_4c_DtInicial.SetFocus
            RETURN
        ENDIF
        IF THIS.Processamento()
            THIS.Documento()
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNSAIRCLICK - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnSairClick
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS LOSTFOCUS - PUBLIC para BINDEVENT funcionar
    *==========================================================================

    *--------------------------------------------------------------------------
    * VALIDARATENDENTE - Lookup SigCdUsu por Usuarios
    *--------------------------------------------------------------------------
    PROCEDURE ValidarAtendente(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_Atendente.Value)
        IF !EMPTY(loc_cVal)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUsu", ;
                "cursor_4c_Busca", "Usuarios", loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", .T.)
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        THIS.txt_4c_Atendente.Value = ALLTRIM(cursor_4c_Busca.Usuarios)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rios")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                        THIS.txt_4c_Atendente.Value = ALLTRIM(cursor_4c_Busca.Usuarios)
                    ELSE
                        THIS.txt_4c_Atendente.Value = ""
                    ENDIF
                ELSE
                    THIS.txt_4c_Atendente.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            THIS.txt_4c_Atendente.Refresh
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARCLIENTE - fAcessoContas 'C' -> preenche txt_4c_NomCli
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCliente(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_lcGrupo

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_Cliente.Value)
        IF !EMPTY(loc_cVal)
            loc_lcGrupo = ""
            IF USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
                SELECT crSigCdPam
                GO TOP
                loc_lcGrupo = ALLTRIM(crSigCdPam.GrPadClis)
            ENDIF
            fAcessoContas(gc_4c_UsuarioLogado, loc_lcGrupo, "C", loc_cVal, ;
                THIS.txt_4c_Cliente, THIS.txt_4c_NomCli, .T.)
        ENDIF
        *-- NomCli so editavel quando Cliente estiver vazio
        THIS.txt_4c_NomCli.Enabled = EMPTY(ALLTRIM(THIS.txt_4c_Cliente.Value))
        THIS.txt_4c_NomCli.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARNOMCLI - fAcessoContas 'D' -> preenche txt_4c_Cliente
    * Ativo somente quando txt_4c_Cliente esta vazio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNomCli(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_lcGrupo

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.txt_4c_Cliente.Value))
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.txt_4c_NomCli.Value)
        IF !EMPTY(loc_cVal)
            loc_lcGrupo = ""
            IF USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
                SELECT crSigCdPam
                GO TOP
                loc_lcGrupo = ALLTRIM(crSigCdPam.GrPadClis)
            ENDIF
            fAcessoContas(gc_4c_UsuarioLogado, loc_lcGrupo, "D", loc_cVal, ;
                THIS.txt_4c_Cliente, THIS.txt_4c_NomCli, .T.)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARCLASS - Lookup SigCdSCl por Codigos
    * KeyPress handler: LPARAMETERS obrigatorio (VFP9 passa nKeyCode/nShiftAltCtrl).
    * So processa em ENTER(13)/TAB(9)/F4(115) ??? evita rodar a cada tecla digitada.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarClass(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult, loc_oBusca

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_Class.Value)
        IF !EMPTY(loc_cVal)
            IF USED("cursor_4c_SCl_Temp")
                USE IN cursor_4c_SCl_Temp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descs FROM SigCdSCl WHERE Codigos = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_SCl_Temp")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_SCl_Temp") > 0
                SELECT cursor_4c_SCl_Temp
                GO TOP
                THIS.txt_4c_Class.Value = ALLTRIM(cursor_4c_SCl_Temp.Codigos)
                IF USED("cursor_4c_SCl_Temp")
                    USE IN cursor_4c_SCl_Temp
                ENDIF
            ELSE
                IF USED("cursor_4c_SCl_Temp")
                    USE IN cursor_4c_SCl_Temp
                ENDIF
                *-- Nao encontrou: mostrar lista completa
                IF USED("cursor_4c_SCl_Lista")
                    USE IN cursor_4c_SCl_Lista
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT DISTINCT Codigos, Descs FROM SigCdSCl", "cursor_4c_SCl_Lista")
                IF loc_nResult > 0
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdSCl", ;
                        "cursor_4c_Busca", "Codigos", loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", .F.)
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digos")
                        loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            THIS.txt_4c_Class.Value = ALLTRIM(cursor_4c_Busca.Codigos)
                        ELSE
                            THIS.txt_4c_Class.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                    IF USED("cursor_4c_Busca")
                        USE IN cursor_4c_Busca
                    ENDIF
                    IF USED("cursor_4c_SCl_Lista")
                        USE IN cursor_4c_SCl_Lista
                    ENDIF
                ELSE
                    THIS.txt_4c_Class.Value = ""
                ENDIF
            ENDIF
            THIS.txt_4c_Class.Refresh
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDAREMP - KeyPress em txt_4c_Emp
    *   Enter/Tab -> SQL exato em SigCdEmp.Cemps; hit preenche Demp, miss abre picker
    *   F4        -> abre picker direto
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmp(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmp()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_Emp.Value)
        IF EMPTY(loc_cVal)
            THIS.txt_4c_Demp.Value = ""
            THIS.txt_4c_Demp.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
                SELECT cursor_4c_EmpVal
                THIS.txt_4c_Emp.Value  = ALLTRIM(cursor_4c_EmpVal.Cemps)
                THIS.txt_4c_Demp.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
            ELSE
                THIS.AbrirBuscaEmp()
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.txt_4c_Emp.Refresh
        THIS.txt_4c_Demp.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * ABRIRBUSCAEMP - picker por Cemps em SigCdEmp
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmp()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo
        loc_cValor  = ALLTRIM(THIS.txt_4c_Emp.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF

        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Cemps"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")

            *-- Fallback: se filtro nao trouxe nada, mostra a lista completa
            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
                    "cursor_4c_BuscaEmp")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                RETURN
            ENDIF

            *-- Cria picker sem SQL automatica (sem par_cTabela)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
                loc_oBusca.this_cTitulo        = loc_cTitulo
                loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    THIS.txt_4c_Emp.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    THIS.txt_4c_Demp.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        THIS.txt_4c_Emp.Refresh
        THIS.txt_4c_Demp.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARDEMP - KeyPress em txt_4c_Demp
    *   Ativo apenas quando txt_4c_Emp esta vazio
    *   Enter/Tab -> SQL exato em SigCdEmp.Razas; miss abre picker
    *   F4        -> abre picker direto
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDemp(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaDemp()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.txt_4c_Emp.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_Demp.Value)
        IF EMPTY(loc_cVal)
            THIS.txt_4c_Emp.Value = ""
            THIS.txt_4c_Emp.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_EmpVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
                SELECT cursor_4c_EmpVal
                THIS.txt_4c_Emp.Value  = ALLTRIM(cursor_4c_EmpVal.Cemps)
                THIS.txt_4c_Demp.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
            ELSE
                THIS.AbrirBuscaDemp()
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.txt_4c_Emp.Refresh
        THIS.txt_4c_Demp.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * ABRIRBUSCADEMP - picker por Razas em SigCdEmp
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDemp()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo
        loc_cValor  = ALLTRIM(THIS.txt_4c_Demp.Value)
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Empresa"

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF

        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY Razas"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Razas", ;
                    "cursor_4c_BuscaEmp")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0
                MsgAviso("Nenhuma empresa encontrada.", "Empresa")
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
                loc_oBusca.this_cTitulo        = loc_cTitulo
                loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    THIS.txt_4c_Emp.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    THIS.txt_4c_Demp.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        THIS.txt_4c_Emp.Refresh
        THIS.txt_4c_Demp.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARCODDEP - Lookup SigCdDpt por Codigos -> preenche txt_4c_DesDep
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodDep(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_CodDep.Value)
        IF !EMPTY(loc_cVal)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdDpt", ;
                "cursor_4c_Busca", "Codigos", loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", .T.)
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        THIS.txt_4c_CodDep.Value = ALLTRIM(cursor_4c_Busca.Codigos)
                        THIS.txt_4c_DesDep.Value = ALLTRIM(cursor_4c_Busca.Descricaos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                        THIS.txt_4c_CodDep.Value = ALLTRIM(cursor_4c_Busca.Codigos)
                        THIS.txt_4c_DesDep.Value = ALLTRIM(cursor_4c_Busca.Descricaos)
                    ELSE
                        THIS.txt_4c_CodDep.Value = ""
                        THIS.txt_4c_DesDep.Value = ""
                    ENDIF
                ELSE
                    THIS.txt_4c_CodDep.Value = ""
                    THIS.txt_4c_DesDep.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
        ELSE
            THIS.txt_4c_CodDep.Value = ""
            THIS.txt_4c_DesDep.Value = ""
        ENDIF
        THIS.txt_4c_CodDep.Refresh
        THIS.txt_4c_DesDep.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARDESDEP - Lookup SigCdDpt por Descricaos -> preenche txt_4c_CodDep
    * Ativo somente quando txt_4c_CodDep esta vazio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDesDep(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.txt_4c_CodDep.Value))
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.txt_4c_DesDep.Value)
        IF !EMPTY(loc_cVal)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdDpt", ;
                "cursor_4c_Busca", "Descricaos", loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", .T.)
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        THIS.txt_4c_CodDep.Value = ALLTRIM(cursor_4c_Busca.Codigos)
                        THIS.txt_4c_DesDep.Value = ALLTRIM(cursor_4c_Busca.Descricaos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                        THIS.txt_4c_CodDep.Value = ALLTRIM(cursor_4c_Busca.Codigos)
                        THIS.txt_4c_DesDep.Value = ALLTRIM(cursor_4c_Busca.Descricaos)
                    ELSE
                        THIS.txt_4c_CodDep.Value = ""
                        THIS.txt_4c_DesDep.Value = ""
                    ENDIF
                ELSE
                    THIS.txt_4c_CodDep.Value = ""
                    THIS.txt_4c_DesDep.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
        ELSE
            THIS.txt_4c_CodDep.Value = ""
            THIS.txt_4c_DesDep.Value = ""
        ENDIF
        THIS.txt_4c_CodDep.Refresh
        THIS.txt_4c_DesDep.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARCODGER - KeyPress em txt_4c_CodGer
    *   Enter/Tab -> SQL exato em SigCdCli.IClis; hit preenche NomGer, miss abre picker
    *   F4        -> abre picker direto
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodGer(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaGer()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_CodGer.Value)
        IF EMPTY(loc_cVal)
            THIS.txt_4c_NomGer.Value = ""
            THIS.txt_4c_NomGer.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_GerVal")
            IF loc_nResult > 0 AND USED("cursor_4c_GerVal") AND !EOF("cursor_4c_GerVal")
                SELECT cursor_4c_GerVal
                THIS.txt_4c_CodGer.Value = ALLTRIM(cursor_4c_GerVal.IClis)
                THIS.txt_4c_NomGer.Value = ALLTRIM(cursor_4c_GerVal.RClis)
            ELSE
                THIS.AbrirBuscaGer()
            ENDIF
            IF USED("cursor_4c_GerVal")
                USE IN cursor_4c_GerVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.txt_4c_CodGer.Refresh
        THIS.txt_4c_NomGer.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * ABRIRBUSCAGER - picker por IClis/RClis em SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGer()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo
        loc_cValor  = ALLTRIM(THIS.txt_4c_CodGer.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(THIS.txt_4c_NomGer.Value)
        ENDIF
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Gerente"

        IF USED("cursor_4c_BuscaGer")
            USE IN cursor_4c_BuscaGer
        ENDIF

        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis"
            ELSE
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
                           "WHERE IClis LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY IClis"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGer")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaGer") OR RECCOUNT("cursor_4c_BuscaGer") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaGer")
                    USE IN cursor_4c_BuscaGer
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
                    "cursor_4c_BuscaGer")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaGer") OR RECCOUNT("cursor_4c_BuscaGer") = 0
                MsgAviso("Nenhum gerente encontrado.", "Gerente")
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGer"
                loc_oBusca.this_cTitulo        = loc_cTitulo
                loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGer")
                    SELECT cursor_4c_BuscaGer
                    THIS.txt_4c_CodGer.Value = ALLTRIM(cursor_4c_BuscaGer.IClis)
                    THIS.txt_4c_NomGer.Value = ALLTRIM(cursor_4c_BuscaGer.RClis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGer")
            USE IN cursor_4c_BuscaGer
        ENDIF
        THIS.txt_4c_CodGer.Refresh
        THIS.txt_4c_NomGer.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARNOMGER - KeyPress em txt_4c_NomGer
    *   Ativo apenas quando txt_4c_CodGer esta vazio
    *   Enter/Tab -> SQL exato em SigCdCli.RClis; miss abre picker
    *   F4        -> abre picker direto
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNomGer(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaGer()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.txt_4c_CodGer.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_NomGer.Value)
        IF EMPTY(loc_cVal)
            THIS.txt_4c_CodGer.Value = ""
            THIS.txt_4c_CodGer.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_GerVal")
            IF loc_nResult > 0 AND USED("cursor_4c_GerVal") AND !EOF("cursor_4c_GerVal")
                SELECT cursor_4c_GerVal
                THIS.txt_4c_CodGer.Value = ALLTRIM(cursor_4c_GerVal.IClis)
                THIS.txt_4c_NomGer.Value = ALLTRIM(cursor_4c_GerVal.RClis)
            ELSE
                THIS.AbrirBuscaGer()
            ENDIF
            IF USED("cursor_4c_GerVal")
                USE IN cursor_4c_GerVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.txt_4c_CodGer.Refresh
        THIS.txt_4c_NomGer.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARCODVEN - KeyPress em txt_4c_CodVen
    *   Enter/Tab -> SQL exato em SigCdCli.IClis; hit preenche NomVen, miss abre picker
    *   F4        -> abre picker direto
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodVen(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaVen()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_CodVen.Value)
        IF EMPTY(loc_cVal)
            THIS.txt_4c_NomVen.Value = ""
            THIS.txt_4c_NomVen.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_VenVal")
            IF loc_nResult > 0 AND USED("cursor_4c_VenVal") AND !EOF("cursor_4c_VenVal")
                SELECT cursor_4c_VenVal
                THIS.txt_4c_CodVen.Value = ALLTRIM(cursor_4c_VenVal.IClis)
                THIS.txt_4c_NomVen.Value = ALLTRIM(cursor_4c_VenVal.RClis)
            ELSE
                THIS.AbrirBuscaVen()
            ENDIF
            IF USED("cursor_4c_VenVal")
                USE IN cursor_4c_VenVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.txt_4c_CodVen.Refresh
        THIS.txt_4c_NomVen.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * ABRIRBUSCAVEN - picker por IClis/RClis em SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaVen()
        LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResult, loc_cTitulo
        loc_cValor  = ALLTRIM(THIS.txt_4c_CodVen.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(THIS.txt_4c_NomVen.Value)
        ENDIF
        loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Vendedor"

        IF USED("cursor_4c_BuscaVen")
            USE IN cursor_4c_BuscaVen
        ENDIF

        TRY
            IF EMPTY(loc_cValor)
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis"
            ELSE
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
                           "WHERE IClis LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cValor + "%") + ;
                           " ORDER BY IClis"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaVen")

            IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaVen") OR RECCOUNT("cursor_4c_BuscaVen") = 0) ;
                    AND !EMPTY(loc_cValor)
                IF USED("cursor_4c_BuscaVen")
                    USE IN cursor_4c_BuscaVen
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
                    "cursor_4c_BuscaVen")
            ENDIF

            IF loc_nResult < 1 OR !USED("cursor_4c_BuscaVen") OR RECCOUNT("cursor_4c_BuscaVen") = 0
                MsgAviso("Nenhum vendedor encontrado.", "Vendedor")
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaVen"
                loc_oBusca.this_cTitulo        = loc_cTitulo
                loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
                loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVen")
                    SELECT cursor_4c_BuscaVen
                    THIS.txt_4c_CodVen.Value = ALLTRIM(cursor_4c_BuscaVen.IClis)
                    THIS.txt_4c_NomVen.Value = ALLTRIM(cursor_4c_BuscaVen.RClis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaVen")
            USE IN cursor_4c_BuscaVen
        ENDIF
        THIS.txt_4c_CodVen.Refresh
        THIS.txt_4c_NomVen.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARNOMVEN - KeyPress em txt_4c_NomVen
    *   Ativo apenas quando txt_4c_CodVen esta vazio
    *   Enter/Tab -> SQL exato em SigCdCli.RClis; miss abre picker
    *   F4        -> abre picker direto
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNomVen(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_nResult

        IF par_nKeyCode = 115
            THIS.AbrirBuscaVen()
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.txt_4c_CodVen.Value))
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_NomVen.Value)
        IF EMPTY(loc_cVal)
            THIS.txt_4c_CodVen.Value = ""
            THIS.txt_4c_CodVen.Refresh
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) = " + EscaparSQL(loc_cVal), ;
                "cursor_4c_VenVal")
            IF loc_nResult > 0 AND USED("cursor_4c_VenVal") AND !EOF("cursor_4c_VenVal")
                SELECT cursor_4c_VenVal
                THIS.txt_4c_CodVen.Value = ALLTRIM(cursor_4c_VenVal.IClis)
                THIS.txt_4c_NomVen.Value = ALLTRIM(cursor_4c_VenVal.RClis)
            ELSE
                THIS.AbrirBuscaVen()
            ENDIF
            IF USED("cursor_4c_VenVal")
                USE IN cursor_4c_VenVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.txt_4c_CodVen.Refresh
        THIS.txt_4c_NomVen.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARCODPROD - Lookup SigCdPro CPros -> preenche txt_4c_DesProd
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodProd(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_CodProd.Value)
        IF !EMPTY(loc_cVal)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
                "cursor_4c_Busca", "CPros", loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", .T.)
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        THIS.txt_4c_CodProd.Value = ALLTRIM(cursor_4c_Busca.CPros)
                        THIS.txt_4c_DesProd.Value = ALLTRIM(cursor_4c_Busca.DPros)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                        THIS.txt_4c_CodProd.Value = ALLTRIM(cursor_4c_Busca.CPros)
                        THIS.txt_4c_DesProd.Value = ALLTRIM(cursor_4c_Busca.DPros)
                    ELSE
                        THIS.txt_4c_CodProd.Value = ""
                        THIS.txt_4c_DesProd.Value = ""
                    ENDIF
                ELSE
                    THIS.txt_4c_CodProd.Value = ""
                    THIS.txt_4c_DesProd.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
        ELSE
            THIS.txt_4c_CodProd.Value = ""
            THIS.txt_4c_DesProd.Value = ""
        ENDIF
        THIS.txt_4c_CodProd.Refresh
        THIS.txt_4c_DesProd.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARDESPROD - Lookup SigCdPro DPros -> preenche txt_4c_CodProd
    * Ativo somente quando txt_4c_CodProd esta vazio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDesProd(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.txt_4c_CodProd.Value))
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.txt_4c_DesProd.Value)
        IF !EMPTY(loc_cVal)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
                "cursor_4c_Busca", "DPros", loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", .T.)
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        THIS.txt_4c_CodProd.Value = ALLTRIM(cursor_4c_Busca.CPros)
                        THIS.txt_4c_DesProd.Value = ALLTRIM(cursor_4c_Busca.DPros)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                        THIS.txt_4c_CodProd.Value = ALLTRIM(cursor_4c_Busca.CPros)
                        THIS.txt_4c_DesProd.Value = ALLTRIM(cursor_4c_Busca.DPros)
                    ELSE
                        THIS.txt_4c_CodProd.Value = ""
                        THIS.txt_4c_DesProd.Value = ""
                    ENDIF
                ELSE
                    THIS.txt_4c_CodProd.Value = ""
                    THIS.txt_4c_DesProd.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
        ELSE
            THIS.txt_4c_CodProd.Value = ""
            THIS.txt_4c_DesProd.Value = ""
        ENDIF
        THIS.txt_4c_CodProd.Refresh
        THIS.txt_4c_DesProd.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARCODCOL - Lookup SigCdCol colecoes -> preenche txt_4c_DesCol
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodCol(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_CodCol.Value)
        IF !EMPTY(loc_cVal)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", ;
                "cursor_4c_Busca", "colecoes", loc_cVal, "Cole" + CHR(231) + CHR(245) + "es", .T.)
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        THIS.txt_4c_CodCol.Value = ALLTRIM(cursor_4c_Busca.colecoes)
                        THIS.txt_4c_DesCol.Value = ALLTRIM(cursor_4c_Busca.Descs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("colecoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                        THIS.txt_4c_CodCol.Value = ALLTRIM(cursor_4c_Busca.colecoes)
                        THIS.txt_4c_DesCol.Value = ALLTRIM(cursor_4c_Busca.Descs)
                    ELSE
                        THIS.txt_4c_CodCol.Value = ""
                        THIS.txt_4c_DesCol.Value = ""
                    ENDIF
                ELSE
                    THIS.txt_4c_CodCol.Value = ""
                    THIS.txt_4c_DesCol.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
        ELSE
            THIS.txt_4c_CodCol.Value = ""
            THIS.txt_4c_DesCol.Value = ""
        ENDIF
        THIS.txt_4c_CodCol.Refresh
        THIS.txt_4c_DesCol.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARDESCOL - Lookup SigCdCol Descs -> preenche txt_4c_CodCol
    * Ativo somente quando txt_4c_CodCol esta vazio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDesCol(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.txt_4c_CodCol.Value))
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.txt_4c_DesCol.Value)
        IF !EMPTY(loc_cVal)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", ;
                "cursor_4c_Busca", "Descs", loc_cVal, "Cole" + CHR(231) + CHR(245) + "es", .T.)
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        THIS.txt_4c_CodCol.Value = ALLTRIM(cursor_4c_Busca.colecoes)
                        THIS.txt_4c_DesCol.Value = ALLTRIM(cursor_4c_Busca.Descs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("colecoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                        THIS.txt_4c_CodCol.Value = ALLTRIM(cursor_4c_Busca.colecoes)
                        THIS.txt_4c_DesCol.Value = ALLTRIM(cursor_4c_Busca.Descs)
                    ELSE
                        THIS.txt_4c_CodCol.Value = ""
                        THIS.txt_4c_DesCol.Value = ""
                    ENDIF
                ELSE
                    THIS.txt_4c_CodCol.Value = ""
                    THIS.txt_4c_DesCol.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
        ELSE
            THIS.txt_4c_CodCol.Value = ""
            THIS.txt_4c_DesCol.Value = ""
        ENDIF
        THIS.txt_4c_CodCol.Refresh
        THIS.txt_4c_DesCol.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARSUBCLASS - Lookup SigCdSCl cSubClas (filtrada por getClass se preenchida)
    * Ao limpar: obj_4c_OptSubClas.Value = 2
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSubClass(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_lcChave, loc_lcConteudo, loc_nResult, loc_oBusca

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_SubClass.Value)
        IF !EMPTY(loc_cVal)
            *-- Filtrar por classificacao se preenchida
            IF !EMPTY(ALLTRIM(THIS.txt_4c_Class.Value))
                loc_lcChave    = "Codigos"
                loc_lcConteudo = ALLTRIM(THIS.txt_4c_Class.Value)
            ELSE
                loc_lcChave    = ""
                loc_lcConteudo = ""
            ENDIF

            IF USED("cursor_4c_SubCl_Temp")
                USE IN cursor_4c_SubCl_Temp
            ENDIF
            IF !EMPTY(loc_lcChave)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cSubClas, Codigos FROM SigCdSCl WHERE Codigos = " + EscaparSQL(loc_lcConteudo), ;
                    "cursor_4c_SubCl_Temp")
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cSubClas, Codigos FROM SigCdSCl", ;
                    "cursor_4c_SubCl_Temp")
            ENDIF

            IF loc_nResult > 0
                IF USED("crSubClass")
                    USE IN crSubClass
                ENDIF
                SELECT * FROM cursor_4c_SubCl_Temp INTO CURSOR crSubClass READWRITE
                IF USED("cursor_4c_SubCl_Temp")
                    USE IN cursor_4c_SubCl_Temp
                ENDIF
                SELECT crSubClass
                INDEX ON cSubClas TAG cSubClas
                SET ORDER TO cSubClas
                SET NEAR ON
                IF !SEEK(loc_cVal)
                    SET NEAR OFF
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdSCl", ;
                        "cursor_4c_Busca", "cSubClas", loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", .T.)
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.mAddColuna("cSubClas", "", "Sub-Classifica" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("Codigos",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            THIS.txt_4c_SubClass.Value = ALLTRIM(cursor_4c_Busca.cSubClas)
                        ELSE
                            THIS.txt_4c_SubClass.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                    IF USED("cursor_4c_Busca")
                        USE IN cursor_4c_Busca
                    ENDIF
                ELSE
                    SET NEAR OFF
                    THIS.txt_4c_SubClass.Value = ALLTRIM(crSubClass.cSubClas)
                ENDIF
                IF USED("crSubClass")
                    USE IN crSubClass
                ENDIF
            ELSE
                THIS.txt_4c_SubClass.Value = ""
            ENDIF
        ENDIF

        IF EMPTY(THIS.txt_4c_SubClass.Value)
            THIS.obj_4c_OptSubClas.Value = 2
        ENDIF
        THIS.txt_4c_SubClass.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARSUBCLASSE - Lookup SigCdSCl cSubClas (filtrada por getClass se preenchida)
    * Ao limpar: obj_4c_OptSubClas.Value = 2
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSubClassE(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_lcChave, loc_lcConteudo, loc_nResult, loc_oBusca

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_SubClassE.Value)
        IF !EMPTY(loc_cVal)
            IF !EMPTY(ALLTRIM(THIS.txt_4c_Class.Value))
                loc_lcChave    = "Codigos"
                loc_lcConteudo = ALLTRIM(THIS.txt_4c_Class.Value)
            ELSE
                loc_lcChave    = ""
                loc_lcConteudo = ""
            ENDIF

            IF USED("cursor_4c_SubCl_ETmp")
                USE IN cursor_4c_SubCl_ETmp
            ENDIF
            IF !EMPTY(loc_lcChave)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cSubClas, Codigos FROM SigCdSCl WHERE Codigos = " + EscaparSQL(loc_lcConteudo), ;
                    "cursor_4c_SubCl_ETmp")
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cSubClas, Codigos FROM SigCdSCl", ;
                    "cursor_4c_SubCl_ETmp")
            ENDIF

            IF loc_nResult > 0
                IF USED("crSubClassE")
                    USE IN crSubClassE
                ENDIF
                SELECT * FROM cursor_4c_SubCl_ETmp INTO CURSOR crSubClassE READWRITE
                IF USED("cursor_4c_SubCl_ETmp")
                    USE IN cursor_4c_SubCl_ETmp
                ENDIF
                SELECT crSubClassE
                INDEX ON cSubClas TAG cSubClas
                SET ORDER TO cSubClas
                SET NEAR ON
                IF !SEEK(loc_cVal)
                    SET NEAR OFF
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdSCl", ;
                        "cursor_4c_Busca", "cSubClas", loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", .T.)
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.mAddColuna("cSubClas", "", "Sub-Classifica" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("Codigos",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            THIS.txt_4c_SubClassE.Value = ALLTRIM(cursor_4c_Busca.cSubClas)
                        ELSE
                            THIS.txt_4c_SubClassE.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                    IF USED("cursor_4c_Busca")
                        USE IN cursor_4c_Busca
                    ENDIF
                ELSE
                    SET NEAR OFF
                    THIS.txt_4c_SubClassE.Value = ALLTRIM(crSubClassE.cSubClas)
                ENDIF
                IF USED("crSubClassE")
                    USE IN crSubClassE
                ENDIF
            ELSE
                THIS.txt_4c_SubClassE.Value = ""
            ENDIF
        ENDIF

        IF EMPTY(THIS.txt_4c_SubClassE.Value)
            THIS.obj_4c_OptSubClas.Value = 2
        ENDIF
        THIS.txt_4c_SubClassE.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * VALIDARSUBCLASSS - Lookup SigCdSCl cSubClas (filtrada por getClass se preenchida)
    * Ao limpar: obj_4c_OptSubClas.Value = 2
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSubClassS(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_lcChave, loc_lcConteudo, loc_nResult, loc_oBusca

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cVal = ALLTRIM(THIS.txt_4c_SubClassS.Value)
        IF !EMPTY(loc_cVal)
            IF !EMPTY(ALLTRIM(THIS.txt_4c_Class.Value))
                loc_lcChave    = "Codigos"
                loc_lcConteudo = ALLTRIM(THIS.txt_4c_Class.Value)
            ELSE
                loc_lcChave    = ""
                loc_lcConteudo = ""
            ENDIF

            IF USED("cursor_4c_SubCl_STmp")
                USE IN cursor_4c_SubCl_STmp
            ENDIF
            IF !EMPTY(loc_lcChave)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cSubClas, Codigos FROM SigCdSCl WHERE Codigos = " + EscaparSQL(loc_lcConteudo), ;
                    "cursor_4c_SubCl_STmp")
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cSubClas, Codigos FROM SigCdSCl", ;
                    "cursor_4c_SubCl_STmp")
            ENDIF

            IF loc_nResult > 0
                IF USED("crSubClassS")
                    USE IN crSubClassS
                ENDIF
                SELECT * FROM cursor_4c_SubCl_STmp INTO CURSOR crSubClassS READWRITE
                IF USED("cursor_4c_SubCl_STmp")
                    USE IN cursor_4c_SubCl_STmp
                ENDIF
                SELECT crSubClassS
                INDEX ON cSubClas TAG cSubClas
                SET ORDER TO cSubClas
                SET NEAR ON
                IF !SEEK(loc_cVal)
                    SET NEAR OFF
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdSCl", ;
                        "cursor_4c_Busca", "cSubClas", loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", .T.)
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.mAddColuna("cSubClas", "", "Sub-Classifica" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("Codigos",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            THIS.txt_4c_SubClassS.Value = ALLTRIM(cursor_4c_Busca.cSubClas)
                        ELSE
                            THIS.txt_4c_SubClassS.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                    IF USED("cursor_4c_Busca")
                        USE IN cursor_4c_Busca
                    ENDIF
                ELSE
                    SET NEAR OFF
                    THIS.txt_4c_SubClassS.Value = ALLTRIM(crSubClassS.cSubClas)
                ENDIF
                IF USED("crSubClassS")
                    USE IN crSubClassS
                ENDIF
            ELSE
                THIS.txt_4c_SubClassS.Value = ""
            ENDIF
        ENDIF

        IF EMPTY(THIS.txt_4c_SubClassS.Value)
            THIS.obj_4c_OptSubClas.Value = 2
        ENDIF
        THIS.txt_4c_SubClassS.Refresh
    ENDPROC

    *==========================================================================
    * DESTROY - Limpeza de recursos
    *==========================================================================
    PROCEDURE Destroy
        THIS.this_oRelatorio = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
