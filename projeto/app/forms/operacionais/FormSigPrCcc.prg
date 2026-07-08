*==============================================================================
* FormSigPrCcc.prg - Rec" + CHR(225) + "lculo de Saldos (SIGPRCCC)
* Form OPERACIONAL - Herda de FormBase
* Legado: SIGPRCCC.SCX
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado (800px -> 1000px)
*   BD   -> SigOpClU / SigMvCcr / SigMvHst / SigMvCab / SigMvItn
*   CODE -> arquitetura em camadas (FormBase / SigPrCccBO)
*==============================================================================
DEFINE CLASS FormSigPrCcc AS FormBase

    *-- Dimensoes (escala 1000/800 = 1.25 do original)
    Width        = 1000
    Height       = 600

    *-- Form sem barra de titulo (identico ao legado TitleBar=0)
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.

    *-- Aparencia
    AutoCenter   = .T.
    DataSession  = 2
    ShowTips     = .T.
    ClipControls = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *  DODEFAULT() chama FormBase.Init() -> THIS.InicializarForm()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE InicializarForm()
    *  Cria toda a estrutura visual do form OPERACIONAL
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Modo validacao UI: nao executa SQL
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ENDIF

            *-- Verificar conexao principal
            IF gnConnHandle <= 0
                MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                        "o estabelecida.", "Erro de Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCccBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar objeto de neg" + CHR(243) + "cios.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Configuracao base do form (Picture, dimensoes, caption)
            *-- Nome ConfigurarPageFrame mantido por convencao do pipeline mesmo
            *-- nao havendo PageFrame neste form OPERACIONAL (layout flat).
            THIS.ConfigurarPageFrame()

            *-- Criar estrutura visual
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarCheckboxes()
            THIS.ConfigurarBotoesPrincipais()
            THIS.ConfigurarContaineresOpcoes()
            THIS.ConfigurarPaginaDados()
            THIS.ConfigurarBINDEVENTs()
            THIS.ConfigurarRodape()

            *-- Tornar controles visiveis (exceto containers de opcoes e LblEnd)
            THIS.TornarControlesVisiveis(THIS)

            *-- Aplicar estado inicial: checkboxes off, containers ocultos,
            *   contador zerado, botao Processar desabilitado
            THIS.ConfigurarPaginaLista()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *  Configuracao base do form OPERACIONAL (layout flat, sem PageFrame).
    *  Ajusta Picture, Caption, dimensoes e centralizacao. Mantem o nome
    *  ConfigurarPageFrame por convencao do pipeline de migracao.
    *--------------------------------------------------------------------------
        LOCAL loc_cImgFundo

        *-- Titulo do form (para telemetria/tracing; TitleBar=0 nao mostra)
        THIS.Caption = "Rec" + CHR(225) + "lculo de Saldos"

        *-- Imagem de fundo do framework
        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF

        *-- Reforca dimensoes canonicas (escala 1.25x do legado 800x600)
        THIS.Width      = 1000
        THIS.Height     = 600
        THIS.AutoCenter = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *  Container cinza escuro com titulo do form
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = 1000
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(0, 0, 0)
                .Caption   = "Rec" + CHR(225) + "lculo de Saldos"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Rec" + CHR(225) + "lculo de Saldos"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCheckboxes()
    *  Shape de fundo decorativo + 4 checkboxes de selecao de modulo
    *  Posicoes escaladas 1.25x do original (800->1000)
    *--------------------------------------------------------------------------
        *-- Shape decorativo de fundo dos botoes de acao (direita)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 871
            .Height      = 110
            .Width       = 112
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- CheckBox: Conta Corrente (original Left=350 -> 437)
        THIS.AddObject("chk_4c_Conta", "CheckBox")
        WITH THIS.chk_4c_Conta
            .Top           = 3
            .Left          = 437
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "C.C."
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ToolTipText   = "Conta Corrente"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Picture       = gc_4c_CaminhoIcones + "folder42.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "a_cash1.bmp"
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- CheckBox: Estoque (original Left=425 -> 531)
        THIS.AddObject("chk_4c_Estoque", "CheckBox")
        WITH THIS.chk_4c_Estoque
            .Top           = 3
            .Left          = 531
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "Estoque"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Picture       = gc_4c_CaminhoIcones + "folder22.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "a_diamd1.bmp"
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- CheckBox: Custo de Produto (original Left=500 -> 625)
        THIS.AddObject("chk_4c_BtnCusto", "CheckBox")
        WITH THIS.chk_4c_BtnCusto
            .Top           = 3
            .Left          = 625
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "Custo"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Picture       = gc_4c_CaminhoIcones + "folder34.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "d_misc2.bmp"
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- CheckBox: Ultima Compra (original Left=575 -> 718)
        THIS.AddObject("chk_4c_BtnCompra", "CheckBox")
        WITH THIS.chk_4c_BtnCompra
            .Top           = 3
            .Left          = 718
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = CHR(218) + "lt. Compra"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ToolTipText   = CHR(218) + "ltima Compra"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Picture       = gc_4c_CaminhoIcones + "folder27.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "d_misc2.bmp"
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
    *  Botoes Processar e Encerrar (original Left=650/725 -> 812/906)
    *--------------------------------------------------------------------------
        *-- Botao Processar (inicia desabilitado - habilita quando algum checkbox marcado)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 812
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption         = "Processar"
            .Enabled         = .F.
            .ToolTipText     = "Processar"
            .SpecialEffect   = 0
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        *-- Botao Encerrar (Cancel=.T. -> ESC fecha o form)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top           = 3
            .Left          = 906
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel        = .T.
            .Caption       = "Encerrar"
            .ToolTipText   = "[ESC] Sair"
            .SpecialEffect = 0
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes           = .T.
            .WordWrap      = .T.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContaineresOpcoes()
    *  4 containers de parametros - iniciam ocultos, toggled pelos checkboxes
    *  Posicoes escaladas 1.25x: Left=139->173, Width=536->670
    *--------------------------------------------------------------------------

        *-- Container: Opcoes de Conta Corrente (original Top=114)
        THIS.AddObject("cnt_4c_OpConta", "Container")
        WITH THIS.cnt_4c_OpConta
            .Top           = 114
            .Left          = 173
            .Width         = 670
            .Height        = 81
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Container: Opcoes de Estoque (original Top=200)
        THIS.AddObject("cnt_4c_OpEstoque", "Container")
        WITH THIS.cnt_4c_OpEstoque
            .Top           = 200
            .Left          = 173
            .Width         = 670
            .Height        = 143
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Container: Opcoes de Custo de Produto (original Top=349)
        THIS.AddObject("cnt_4c_OpCusto", "Container")
        WITH THIS.cnt_4c_OpCusto
            .Top           = 349
            .Left          = 173
            .Width         = 670
            .Height        = 92
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Container: Opcoes de Ultima Compra (original Top=447)
        THIS.AddObject("cnt_4c_OpCompra", "Container")
        WITH THIS.cnt_4c_OpCompra
            .Top           = 447
            .Left          = 173
            .Width         = 670
            .Height        = 91
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarRodape()
    *  Label "Registros:", contador numerico e label de conclusao
    *  Posicoes escaladas 1.25x do original
    *--------------------------------------------------------------------------
        *-- Label "Registros : " (original Left=171 -> 213)
        THIS.AddObject("lbl_4c_Registros", "Label")
        WITH THIS.lbl_4c_Registros
            .Top       = 547
            .Left      = 213
            .Width     = 65
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Registros : "
            .Visible   = .T.
        ENDWITH

        *-- TextBox contador (original Left=238 -> 297, Width=93 -> 116)
        *  ReadOnly: legado usa When=Return .F. para impedir foco
        THIS.AddObject("txt_4c_Registro", "TextBox")
        WITH THIS.txt_4c_Registro
            .Top           = 543
            .Left          = 297
            .Width         = 116
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999,999,999"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label conclusao (oculto, exibido ao terminar processamento)
        *  original Left=361 -> 451, Width=205 -> 256
        THIS.AddObject("lbl_4c_LblEnd", "Label")
        WITH THIS.lbl_4c_LblEnd
            .Top       = 545
            .Left      = 451
            .Width     = 256
            .Height    = 22
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Arial"
            .FontSize  = 12
            .Alignment = 2
            .ForeColor = RGB(255, 0, 0)
            .Caption   = "Processamento Conclu" + CHR(237) + "do"
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarConteudoOpConta()
    *  Sub-controles de cnt_4c_OpConta (Opcoes Conta Corrente)
    *--------------------------------------------------------------------------
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_OpConta

        loc_oCnt.AddObject("lbl_4c_TituloConta", "Label")
        WITH loc_oCnt.lbl_4c_TituloConta
            .Top       = 2
            .Left      = 213
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 128)
            .Caption   = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_EmpresaConta", "Label")
        WITH loc_oCnt.lbl_4c_EmpresaConta
            .Top       = 23
            .Left      = 20
            .Width     = 71
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_EmpresaConta", "TextBox")
        WITH loc_oCnt.txt_4c_EmpresaConta
            .Top       = 20
            .Left      = 93
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_GruposConta", "Label")
        WITH loc_oCnt.lbl_4c_GruposConta
            .Top       = 24
            .Left      = 152
            .Width     = 52
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grupo :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_GruposConta", "TextBox")
        WITH loc_oCnt.txt_4c_GruposConta
            .Top       = 20
            .Left      = 207
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_ContasConta", "Label")
        WITH loc_oCnt.lbl_4c_ContasConta
            .Top       = 24
            .Left      = 318
            .Width     = 51
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Conta :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_ContasConta", "TextBox")
        WITH loc_oCnt.txt_4c_ContasConta
            .Top       = 20
            .Left      = 372
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_MoedasConta", "Label")
        WITH loc_oCnt.lbl_4c_MoedasConta
            .Top       = 50
            .Left      = 33
            .Width     = 57
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Moeda :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_MoedasConta", "TextBox")
        WITH loc_oCnt.txt_4c_MoedasConta
            .Top       = 46
            .Left      = 93
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_DataConta", "Label")
        WITH loc_oCnt.lbl_4c_DataConta
            .Top       = 50
            .Left      = 151
            .Width     = 85
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "A partir de :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DataConta", "TextBox")
        WITH loc_oCnt.txt_4c_DataConta
            .Top       = 46
            .Left      = 238
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarConteudoOpEstoque()
    *  Sub-controles de cnt_4c_OpEstoque (Opcoes de Estoque)
    *--------------------------------------------------------------------------
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_OpEstoque

        loc_oCnt.AddObject("lbl_4c_TituloEst", "Label")
        WITH loc_oCnt.lbl_4c_TituloEst
            .Top       = 2
            .Left      = 227
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 128)
            .Caption   = "Op" + CHR(231) + CHR(245) + "es de Estoque"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_EmpresaEst", "Label")
        WITH loc_oCnt.lbl_4c_EmpresaEst
            .Top       = 15
            .Left      = 38
            .Width     = 71
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_EmpresaEst", "TextBox")
        WITH loc_oCnt.txt_4c_EmpresaEst
            .Top       = 12
            .Left      = 112
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_GruposEst", "Label")
        WITH loc_oCnt.lbl_4c_GruposEst
            .Top       = 40
            .Left      = 57
            .Width     = 52
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grupo :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_GruposEst", "TextBox")
        WITH loc_oCnt.txt_4c_GruposEst
            .Top       = 37
            .Left      = 112
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_EstoqueEst", "Label")
        WITH loc_oCnt.lbl_4c_EstoqueEst
            .Top       = 65
            .Left      = 43
            .Width     = 66
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Estoque :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_EstoqueEst", "TextBox")
        WITH loc_oCnt.txt_4c_EstoqueEst
            .Top       = 62
            .Left      = 112
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_ProdutoEst", "Label")
        WITH loc_oCnt.lbl_4c_ProdutoEst
            .Top       = 90
            .Left      = 43
            .Width     = 66
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Produto :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_ProdutoEst", "TextBox")
        WITH loc_oCnt.txt_4c_ProdutoEst
            .Top       = 87
            .Left      = 112
            .Width     = 135
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DescsEst", "TextBox")
        WITH loc_oCnt.txt_4c_DescsEst
            .Top       = 87
            .Left      = 248
            .Width     = 408
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_DataEst", "Label")
        WITH loc_oCnt.lbl_4c_DataEst
            .Top       = 115
            .Left      = 25
            .Width     = 85
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "A partir de :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DataEst", "TextBox")
        WITH loc_oCnt.txt_4c_DataEst
            .Top       = 112
            .Left      = 112
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarConteudoOpCusto()
    *  Sub-controles de cnt_4c_OpCusto (Opcoes de Custo de Produto)
    *--------------------------------------------------------------------------
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_OpCusto

        loc_oCnt.AddObject("lbl_4c_TituloCusto", "Label")
        WITH loc_oCnt.lbl_4c_TituloCusto
            .Top       = 2
            .Left      = 193
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 128)
            .Caption   = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_EmpresaCusto", "Label")
        WITH loc_oCnt.lbl_4c_EmpresaCusto
            .Top       = 14
            .Left      = 38
            .Width     = 71
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_EmpresaCusto", "TextBox")
        WITH loc_oCnt.txt_4c_EmpresaCusto
            .Top       = 11
            .Left      = 112
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_ProdutoCusto", "Label")
        WITH loc_oCnt.lbl_4c_ProdutoCusto
            .Top       = 39
            .Left      = 43
            .Width     = 66
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Produto :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_ProdutoCusto", "TextBox")
        WITH loc_oCnt.txt_4c_ProdutoCusto
            .Top       = 36
            .Left      = 112
            .Width     = 135
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DescsCusto", "TextBox")
        WITH loc_oCnt.txt_4c_DescsCusto
            .Top       = 36
            .Left      = 248
            .Width     = 408
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_DataCusto", "Label")
        WITH loc_oCnt.lbl_4c_DataCusto
            .Top       = 64
            .Left      = 25
            .Width     = 85
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "A partir de :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DataCusto", "TextBox")
        WITH loc_oCnt.txt_4c_DataCusto
            .Top       = 61
            .Left      = 112
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarConteudoOpCompra()
    *  Sub-controles de cnt_4c_OpCompra (Opcoes de Ultima Compra)
    *--------------------------------------------------------------------------
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_OpCompra

        loc_oCnt.AddObject("lbl_4c_TituloCompra", "Label")
        WITH loc_oCnt.lbl_4c_TituloCompra
            .Top       = 2
            .Left      = 175
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 128)
            .Caption   = "Op" + CHR(231) + CHR(245) + "es de " + CHR(218) + "ltima Compra do Produto/Cliente"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_EmpresaCompra", "Label")
        WITH loc_oCnt.lbl_4c_EmpresaCompra
            .Top       = 14
            .Left      = 38
            .Width     = 71
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_EmpresaCompra", "TextBox")
        WITH loc_oCnt.txt_4c_EmpresaCompra
            .Top       = 10
            .Left      = 112
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_ProdutoCompra", "Label")
        WITH loc_oCnt.lbl_4c_ProdutoCompra
            .Top       = 39
            .Left      = 43
            .Width     = 66
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Produto :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_ProdutoCompra", "TextBox")
        WITH loc_oCnt.txt_4c_ProdutoCompra
            .Top       = 35
            .Left      = 112
            .Width     = 135
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DescsCompra", "TextBox")
        WITH loc_oCnt.txt_4c_DescsCompra
            .Top       = 35
            .Left      = 248
            .Width     = 408
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_DataCompra", "Label")
        WITH loc_oCnt.lbl_4c_DataCompra
            .Top       = 64
            .Left      = 25
            .Width     = 85
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "A partir de :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DataCompra", "TextBox")
        WITH loc_oCnt.txt_4c_DataCompra
            .Top       = 60
            .Left      = 112
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
    *--------------------------------------------------------------------------
        BINDEVENT(THIS.chk_4c_Conta,     "Click", THIS, "ChkContaClick")
        BINDEVENT(THIS.chk_4c_Estoque,   "Click", THIS, "ChkEstoqueClick")
        BINDEVENT(THIS.chk_4c_BtnCusto,  "Click", THIS, "ChkBtnCustoClick")
        BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkBtnCompraClick")

        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,  "Click", THIS, "CmdEncerrarClick")

        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta, "KeyPress", THIS, "TxtEmpresaContaKeyPress")
        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta, "DblClick", THIS, "TxtEmpresaContaDblClick")
        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_MoedasConta,  "KeyPress", THIS, "TxtMoedasContaKeyPress")
        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_MoedasConta,  "DblClick", THIS, "TxtMoedasContaDblClick")

        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst, "KeyPress", THIS, "TxtEmpresaEstKeyPress")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst, "DblClick", THIS, "TxtEmpresaEstDblClick")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, "KeyPress", THIS, "TxtProdutoEstKeyPress")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, "DblClick", THIS, "TxtProdutoEstDblClick")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst,   "KeyPress", THIS, "TxtDescsEstKeyPress")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst,   "DblClick", THIS, "TxtDescsEstDblClick")

        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto, "KeyPress", THIS, "TxtEmpresaCustoKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto, "DblClick", THIS, "TxtEmpresaCustoDblClick")
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, "KeyPress", THIS, "TxtProdutoCustoKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, "DblClick", THIS, "TxtProdutoCustoDblClick")
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto,   "KeyPress", THIS, "TxtDescsCustoKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto,   "DblClick", THIS, "TxtDescsCustoDblClick")

        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra, "KeyPress", THIS, "TxtEmpresaCompraKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra, "DblClick", THIS, "TxtEmpresaCompraDblClick")
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, "KeyPress", THIS, "TxtProdutoCompraKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, "DblClick", THIS, "TxtProdutoCompraDblClick")
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra,   "KeyPress", THIS, "TxtDescsCompraKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra,   "DblClick", THIS, "TxtDescsCompraDblClick")
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarBotaoProcessar()
    *--------------------------------------------------------------------------
        THIS.cmd_4c_Processar.Enabled = (THIS.chk_4c_Conta.Value     = 1 OR ;
                                         THIS.chk_4c_Estoque.Value   = 1 OR ;
                                         THIS.chk_4c_BtnCusto.Value  = 1 OR ;
                                         THIS.chk_4c_BtnCompra.Value = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *  Reset do estado inicial (equivalente a Page1/LISTA em forms CRUD,
    *  adaptado para o form OPERACIONAL flat): reseta checkboxes de selecao
    *  de modulos, oculta containers de opcoes, esconde label de conclusao
    *  e zera contador de registros processados.
    *--------------------------------------------------------------------------
        *-- Checkboxes de selecao de modulos: desmarcados
        THIS.chk_4c_Conta.Value       = 0
        THIS.chk_4c_Estoque.Value     = 0
        THIS.chk_4c_BtnCusto.Value    = 0
        THIS.chk_4c_BtnCompra.Value   = 0

        *-- Containers de opcoes ocultos (togglados pelos checkboxes)
        THIS.cnt_4c_OpConta.Visible   = .F.
        THIS.cnt_4c_OpEstoque.Visible = .F.
        THIS.cnt_4c_OpCusto.Visible   = .F.
        THIS.cnt_4c_OpCompra.Visible  = .F.

        *-- Rodape: label de conclusao oculto e contador zerado
        THIS.lbl_4c_LblEnd.Visible    = .F.
        THIS.txt_4c_Registro.Value    = 0

        *-- Botao Processar inicia desabilitado (nenhum modulo selecionado)
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *  Fachada que agrupa a construcao dos "campos de dados" do form OPERACIONAL.
    *  Este form nao possui PageFrame CRUD; a entrada de parametros pelo usuario
    *  ocorre dentro dos 4 containers flutuantes de opcoes (Conta Corrente,
    *  Estoque, Custo, Ultima Compra), cada um com seus TextBoxes de empresa,
    *  grupo, conta, moeda, produto, descricao e data. Esta rotina cria todos
    *  esses campos de entrada, agrupando as chamadas ConfigurarConteudoOp*.
    *  Equivale, na semantica CRUD, ao "Page2 Dados" onde o usuario preenche
    *  os campos para a operacao.
    *--------------------------------------------------------------------------
        *-- Container OpConta: Empresa, Grupo, Conta, Moeda, Data
        THIS.ConfigurarConteudoOpConta()

        *-- Container OpEstoque: Empresa, Grupo, Estoque, Produto, Descricao, Data
        THIS.ConfigurarConteudoOpEstoque()

        *-- Container OpCusto: Empresa, Produto, Descricao, Data
        THIS.ConfigurarConteudoOpCusto()

        *-- Container OpCompra: Empresa, Produto, Descricao, Data
        THIS.ConfigurarConteudoOpCompra()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
    *  Alterna entre modos operacionais (adaptacao do padrao AlternarPagina
    *  dos forms CRUD para o form OPERACIONAL flat):
    *     par_nPagina = 1 -> Modo SELECAO: usuario escolhe modulos e opcoes
    *     par_nPagina = 2 -> Modo PROCESSAMENTO: controles bloqueados
    *--------------------------------------------------------------------------
        DO CASE
        CASE par_nPagina = 2
            *-- Modo PROCESSAMENTO: bloqueia todos os controles
            THIS.chk_4c_Conta.Enabled     = .F.
            THIS.chk_4c_Estoque.Enabled   = .F.
            THIS.chk_4c_BtnCusto.Enabled  = .F.
            THIS.chk_4c_BtnCompra.Enabled = .F.
            THIS.cmd_4c_Processar.Enabled = .F.
            THIS.cmd_4c_Encerrar.Enabled  = .F.
            THIS.lbl_4c_LblEnd.Visible    = .F.
            THIS.txt_4c_Registro.Value    = 0
        OTHERWISE
            *-- Modo SELECAO (par_nPagina = 1 ou omitido)
            THIS.chk_4c_Conta.Enabled     = .T.
            THIS.chk_4c_Estoque.Enabled   = .T.
            THIS.chk_4c_BtnCusto.Enabled  = .T.
            THIS.chk_4c_BtnCompra.Enabled = .T.
            THIS.cmd_4c_Encerrar.Enabled  = .T.
            THIS.AtualizarBotaoProcessar()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ChkContaClick()
    *--------------------------------------------------------------------------
        THIS.cnt_4c_OpConta.Visible = (THIS.chk_4c_Conta.Value = 1)
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ChkEstoqueClick()
    *--------------------------------------------------------------------------
        THIS.cnt_4c_OpEstoque.Visible = (THIS.chk_4c_Estoque.Value = 1)
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ChkBtnCustoClick()
    *--------------------------------------------------------------------------
        THIS.cnt_4c_OpCusto.Visible = (THIS.chk_4c_BtnCusto.Value = 1)
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ChkBtnCompraClick()
    *--------------------------------------------------------------------------
        THIS.cnt_4c_OpCompra.Visible = (THIS.chk_4c_BtnCompra.Value = 1)
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CmdProcessarClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oBO, loc_oErro
        loc_oBO      = THIS.this_oBusinessObject
        loc_lSucesso = .F.

        loc_oBO.this_lProcessarConta   = (THIS.chk_4c_Conta.Value     = 1)
        loc_oBO.this_lProcessarEstoque = (THIS.chk_4c_Estoque.Value   = 1)
        loc_oBO.this_lProcessarCusto   = (THIS.chk_4c_BtnCusto.Value  = 1)
        loc_oBO.this_lProcessarCompra  = (THIS.chk_4c_BtnCompra.Value = 1)

        IF loc_oBO.this_lProcessarConta
            loc_oBO.this_cEmpConta    = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value)
            loc_oBO.this_cGruposConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value)
            loc_oBO.this_cContasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value)
            loc_oBO.this_cMoedasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value)
            loc_oBO.this_dDataConta   = THIS.cnt_4c_OpConta.txt_4c_DataConta.Value
        ENDIF
        IF loc_oBO.this_lProcessarEstoque
            loc_oBO.this_cEmpEstoque       = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value)
            loc_oBO.this_cGruposEstoque    = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value)
            loc_oBO.this_cEstoqueEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value)
            loc_oBO.this_cProdutoEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
            loc_oBO.this_cDescricaoEstoque = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value)
            loc_oBO.this_dDataEstoque      = THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value
        ENDIF
        IF loc_oBO.this_lProcessarCusto
            loc_oBO.this_cEmpCusto       = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value)
            loc_oBO.this_cProdutoCusto   = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
            loc_oBO.this_cDescricaoCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value)
            loc_oBO.this_dDataCusto      = THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value
        ENDIF
        IF loc_oBO.this_lProcessarCompra
            loc_oBO.this_cEmpCompra       = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value)
            loc_oBO.this_cProdutoCompra   = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
            loc_oBO.this_cDescricaoCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value)
            loc_oBO.this_dDataCompra      = THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value
        ENDIF

        *-- Modo PROCESSAMENTO: bloqueia controles durante execucao
        THIS.AlternarPagina(2)

        TRY
            loc_lSucesso = loc_oBO.Processar(THIS)
            THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
            IF loc_lSucesso
                THIS.lbl_4c_LblEnd.Visible = .T.
                MsgInfo("Processamento conclu" + CHR(237) + "do com sucesso.", ;
                        "Rec" + CHR(225) + "lculo de Saldos")
            ELSE
                MsgAviso("Processamento conclu" + CHR(237) + "do com erros.", ;
                         "Rec" + CHR(225) + "lculo de Saldos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Processar")
        ENDTRY

        *-- Volta para modo SELECAO
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
    *--------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupEmpresa(par_oTxt)
    *  Lookup generico de empresa (SigCdEmp -> Cemps, Razas)
    *--------------------------------------------------------------------------
        LOCAL loc_oForm, loc_cValor
        TRY
            loc_cValor = ALLTRIM(par_oTxt.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa")
            IF ISNULL(loc_oForm)
                RETURN
            ENDIF
            IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
            ELSE
                IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("Cemps", "XXXXXX", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupProduto(par_oTxtCod, par_oTxtDesc)
    *  Lookup de produto por codigo (SigCdPro -> CPros, DPros)
    *--------------------------------------------------------------------------
        LOCAL loc_oForm, loc_cValor
        TRY
            loc_cValor = ALLTRIM(par_oTxtCod.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto")
            IF ISNULL(loc_oForm)
                RETURN
            ENDIF
            IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
                par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
            ELSE
                IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou
                    par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
                    par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaPro")
                USE IN cursor_4c_BuscaPro
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupDescricao(par_oTxtCod, par_oTxtDesc)
    *  Lookup de produto por descricao (SigCdPro -> DPros, CPros)
    *--------------------------------------------------------------------------
        LOCAL loc_oForm, loc_cValor
        TRY
            loc_cValor = ALLTRIM(par_oTxtDesc.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaDesc", "DPros", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto")
            IF ISNULL(loc_oForm)
                RETURN
            ENDIF
            IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaDesc.CPros)
                par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaDesc.DPros)
            ELSE
                IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou
                    par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaDesc.CPros)
                    par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaDesc.DPros)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaDesc")
                USE IN cursor_4c_BuscaDesc
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupMoeda(par_oTxt)
    *  Lookup de moeda (SigCdMoe -> Cmoes, Dmoes)
    *--------------------------------------------------------------------------
        LOCAL loc_oForm, loc_cValor
        TRY
            loc_cValor = ALLTRIM(par_oTxt.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "Cmoes", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda")
            IF ISNULL(loc_oForm)
                RETURN
            ENDIF
            IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.Cmoes)
            ELSE
                IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("Cmoes", "", "Moe")
                loc_oForm.mAddColuna("Dmoes", "", "Nome")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.Cmoes)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--- Handlers: cnt_4c_OpConta ---
    PROCEDURE TxtEmpresaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta)
        ENDIF
    ENDPROC

    PROCEDURE TxtEmpresaContaDblClick()
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta)
    ENDPROC

    PROCEDURE TxtMoedasContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda(THIS.cnt_4c_OpConta.txt_4c_MoedasConta)
        ENDIF
    ENDPROC

    PROCEDURE TxtMoedasContaDblClick()
        THIS.AbrirLookupMoeda(THIS.cnt_4c_OpConta.txt_4c_MoedasConta)
    ENDPROC

    *--- Handlers: cnt_4c_OpEstoque ---
    PROCEDURE TxtEmpresaEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst)
        ENDIF
    ENDPROC

    PROCEDURE TxtEmpresaEstDblClick()
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst)
    ENDPROC

    PROCEDURE TxtProdutoEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
                                    THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
        ENDIF
    ENDPROC

    PROCEDURE TxtProdutoEstDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
                                THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
    ENDPROC

    PROCEDURE TxtDescsEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            IF EMPTY(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
                THIS.AbrirLookupDescricao(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
                                          THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDescsEstDblClick()
        IF EMPTY(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
            THIS.AbrirLookupDescricao(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
                                      THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
        ENDIF
    ENDPROC

    *--- Handlers: cnt_4c_OpCusto ---
    PROCEDURE TxtEmpresaCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto)
        ENDIF
    ENDPROC

    PROCEDURE TxtEmpresaCustoDblClick()
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto)
    ENDPROC

    PROCEDURE TxtProdutoCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
                                    THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
        ENDIF
    ENDPROC

    PROCEDURE TxtProdutoCustoDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
                                THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
    ENDPROC

    PROCEDURE TxtDescsCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            IF EMPTY(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
                THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
                                          THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDescsCustoDblClick()
        IF EMPTY(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
            THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
                                      THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
        ENDIF
    ENDPROC

    *--- Handlers: cnt_4c_OpCompra ---
    PROCEDURE TxtEmpresaCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra)
        ENDIF
    ENDPROC

    PROCEDURE TxtEmpresaCompraDblClick()
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra)
    ENDPROC

    PROCEDURE TxtProdutoCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
                                    THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
        ENDIF
    ENDPROC

    PROCEDURE TxtProdutoCompraDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
                                THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
    ENDPROC

    PROCEDURE TxtDescsCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            IF EMPTY(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
                THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
                                          THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDescsCompraDblClick()
        IF EMPTY(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
            THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
                                      THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *  Torna controles visiveis recursivamente.
    *  EXCECOES (permanecem ocultos apos InicializarForm):
    *    - cnt_4c_OpConta/OpEstoque/OpCusto/OpCompra: toggled pelos checkboxes
    *    - lbl_4c_LblEnd: exibido apenas ao concluir processamento
    *--------------------------------------------------------------------------
        LOCAL loc_i, loc_p, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) != "O"
                LOOP
            ENDIF

            *-- Containers gerenciados: nao forcar .Visible via este metodo
            *  - CNT_4C_CABECALHO: visivel mas recursao ja garante filhos visiveis
            *  - CNT_4C_OPCONTA/OPESTOQUE/OPCUSTO/OPCOMPRA: toggled pelos checkboxes (inicia .F.)
            *  - LBL_4C_LBLEND: exibido apenas ao concluir processamento (inicia .F.)
            IF INLIST(UPPER(loc_oControl.Name), ;
                "CNT_4C_CABECALHO", ;
                "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
                "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA", ;
                "LBL_4C_LBLEND")
                *-- Recursao nos filhos para que fiquem prontos quando container tornar visivel
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            *-- Recursao para PageFrame (nao usado neste form, mas por padrao)
            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                FOR loc_p = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                ENDFOR
            ENDIF

            *-- Recursao para containers com filhos
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia um novo ciclo de recalculo de saldos
    * Form OPERACIONAL: mapeado para o disparo do processamento (equivalente
    * a "incluir" uma nova execucao). Delega para CmdProcessarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
               THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
                MsgAviso("Selecione ao menos uma op" + CHR(231) + CHR(227) + "o de processamento (Conta, Estoque, Custo ou " + CHR(250) + "lt. Compra).", ;
                         "Rec" + CHR(225) + "lculo de Saldos")
                RETURN
            ENDIF
            THIS.lbl_4c_LblEnd.Visible = .F.
            THIS.txt_4c_Registro.Value = 0
            THIS.CmdProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao iniciar processamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Reexecuta o processamento com as opcoes atuais
    * Form OPERACIONAL: equivalente a "alterar" parametros e reprocessar.
    * Requer que pelo menos uma opcao esteja marcada.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
               THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
                MsgAviso("Nenhuma op" + CHR(231) + CHR(227) + "o marcada para reprocessar.", ;
                         "Rec" + CHR(225) + "lculo de Saldos")
                RETURN
            ENDIF
            IF MsgConfirma("Reexecutar o processamento com as op" + CHR(231) + CHR(245) + "es atuais?", ;
                           "Rec" + CHR(225) + "lculo de Saldos")
                THIS.lbl_4c_LblEnd.Visible = .F.
                THIS.txt_4c_Registro.Value = 0
                THIS.CmdProcessarClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao reexecutar processamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe o resumo do ultimo processamento
    * Form OPERACIONAL: mostra os totais processados sem reexecutar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oBO, loc_nRegistros, loc_cMsg, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            loc_nRegistros = 0
            IF VARTYPE(loc_oBO) = "O" AND !ISNULL(loc_oBO)
                loc_nRegistros = loc_oBO.this_nRegistros
            ENDIF
            THIS.txt_4c_Registro.Value = loc_nRegistros

            loc_cMsg = "Resumo do " + CHR(250) + "ltimo processamento:" + CHR(13) + CHR(13) + ;
                       "Registros processados: " + TRANSFORM(loc_nRegistros) + CHR(13) + ;
                       "Conta Corrente......: " + IIF(THIS.chk_4c_Conta.Value    = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
                       "Estoque.............: " + IIF(THIS.chk_4c_Estoque.Value  = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
                       "Custo...............: " + IIF(THIS.chk_4c_BtnCusto.Value = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
                       CHR(250) + "lt. Compra..........: " + IIF(THIS.chk_4c_BtnCompra.Value = 1, "SIM", "N" + CHR(227) + "O")

            THIS.lbl_4c_LblEnd.Visible = (loc_nRegistros > 0)
            MsgInfo(loc_cMsg, "Rec" + CHR(225) + "lculo de Saldos")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar resumo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Cancela / reinicia a selecao de opcoes
    * Form OPERACIONAL: nao ha exclusao de dados; a acao reseta os
    * checkboxes, esconde os paineis flutuantes e zera o contador.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF !MsgConfirma("Limpar todas as op" + CHR(231) + CHR(245) + "es selecionadas?", ;
                            "Rec" + CHR(225) + "lculo de Saldos")
                RETURN
            ENDIF

            THIS.chk_4c_Conta.Value     = 0
            THIS.chk_4c_Estoque.Value   = 0
            THIS.chk_4c_BtnCusto.Value  = 0
            THIS.chk_4c_BtnCompra.Value = 0

            THIS.cnt_4c_OpConta.Visible   = .F.
            THIS.cnt_4c_OpEstoque.Visible = .F.
            THIS.cnt_4c_OpCusto.Visible   = .F.
            THIS.cnt_4c_OpCompra.Visible  = .F.

            THIS.txt_4c_Registro.Value = 0
            THIS.lbl_4c_LblEnd.Visible = .F.

            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject.this_nRegistros = 0
            ENDIF

            THIS.AtualizarBotaoProcessar()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar op" + CHR(231) + CHR(245) + "es")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
    *  Transfere os valores dos campos visuais para as propriedades do BO.
    *  Para o form OPERACIONAL: copia flags dos checkboxes e parametros
    *  de cada secao ativa para as propriedades this_* do BO.
    *--------------------------------------------------------------------------
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O" OR ISNULL(loc_oBO)
                RETURN
            ENDIF

            loc_oBO.this_lProcessarConta   = (THIS.chk_4c_Conta.Value     = 1)
            loc_oBO.this_lProcessarEstoque = (THIS.chk_4c_Estoque.Value   = 1)
            loc_oBO.this_lProcessarCusto   = (THIS.chk_4c_BtnCusto.Value  = 1)
            loc_oBO.this_lProcessarCompra  = (THIS.chk_4c_BtnCompra.Value = 1)

            IF loc_oBO.this_lProcessarConta
                loc_oBO.this_cEmpConta    = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value)
                loc_oBO.this_cGruposConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value)
                loc_oBO.this_cContasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value)
                loc_oBO.this_cMoedasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value)
                loc_oBO.this_dDataConta   = THIS.cnt_4c_OpConta.txt_4c_DataConta.Value
            ENDIF

            IF loc_oBO.this_lProcessarEstoque
                loc_oBO.this_cEmpEstoque       = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value)
                loc_oBO.this_cGruposEstoque    = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value)
                loc_oBO.this_cEstoqueEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value)
                loc_oBO.this_cProdutoEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
                loc_oBO.this_cDescricaoEstoque = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value)
                loc_oBO.this_dDataEstoque      = THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value
            ENDIF

            IF loc_oBO.this_lProcessarCusto
                loc_oBO.this_cEmpCusto       = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value)
                loc_oBO.this_cProdutoCusto   = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
                loc_oBO.this_cDescricaoCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value)
                loc_oBO.this_dDataCusto      = THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value
            ENDIF

            IF loc_oBO.this_lProcessarCompra
                loc_oBO.this_cEmpCompra       = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value)
                loc_oBO.this_cProdutoCompra   = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
                loc_oBO.this_cDescricaoCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value)
                loc_oBO.this_dDataCompra      = THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
    *  Transfere resultados do BO de volta para os campos visuais.
    *  Para o form OPERACIONAL: exibe o contador de registros processados
    *  e o label de conclusao quando houver resultado.
    *--------------------------------------------------------------------------
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O" OR ISNULL(loc_oBO)
                RETURN
            ENDIF
            THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
            THIS.lbl_4c_LblEnd.Visible = (loc_oBO.this_nRegistros > 0)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
    *  Limpa todos os campos de entrada nos 4 containers de opcoes e
    *  redefine flags/checkboxes para o estado inicial (sem selecao).
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            *-- Checkboxes
            THIS.chk_4c_Conta.Value     = 0
            THIS.chk_4c_Estoque.Value   = 0
            THIS.chk_4c_BtnCusto.Value  = 0
            THIS.chk_4c_BtnCompra.Value = 0

            *-- Campos de Conta Corrente
            THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value = ""
            THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value  = ""
            THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value  = ""
            THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value  = ""
            THIS.cnt_4c_OpConta.txt_4c_DataConta.Value    = {}

            *-- Campos de Estoque
            THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value = ""
            THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value  = ""
            THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value = ""
            THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value = ""
            THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value   = ""
            THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value    = {}

            *-- Campos de Custo
            THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value = ""
            THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value = ""
            THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value   = ""
            THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value    = {}

            *-- Campos de Ultima Compra
            THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value = ""
            THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value = ""
            THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value   = ""
            THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value    = {}

            *-- Rodape
            THIS.txt_4c_Registro.Value = 0
            THIS.lbl_4c_LblEnd.Visible = .F.

            *-- Oculta containers flutuantes
            THIS.cnt_4c_OpConta.Visible   = .F.
            THIS.cnt_4c_OpEstoque.Visible = .F.
            THIS.cnt_4c_OpCusto.Visible   = .F.
            THIS.cnt_4c_OpCompra.Visible  = .F.

            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject.this_nRegistros = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
    *  Habilita ou desabilita todos os controles de entrada do form.
    *  Chamado por AlternarPagina para bloquear durante o processamento.
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            THIS.chk_4c_Conta.Enabled     = par_lHabilitar
            THIS.chk_4c_Estoque.Enabled   = par_lHabilitar
            THIS.chk_4c_BtnCusto.Enabled  = par_lHabilitar
            THIS.chk_4c_BtnCompra.Enabled = par_lHabilitar
            THIS.cmd_4c_Encerrar.Enabled  = par_lHabilitar

            IF par_lHabilitar
                *-- Ao habilitar, Processar depende da selecao dos checkboxes
                THIS.AtualizarBotaoProcessar()
            ELSE
                THIS.cmd_4c_Processar.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
    *  Atualiza o estado do botao Processar conforme selecao atual.
    *  Alias de AtualizarBotaoProcessar() para compatibilidade com
    *  o padrao do pipeline de migracao.
    *--------------------------------------------------------------------------
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
    *  Reinicia o form para o estado inicial: desmarca checkboxes, oculta
    *  containers de opcoes e zera o contador. Equivalente ao "recarregar
    *  a lista" nos forms CRUD, adaptado para o form OPERACIONAL flat.
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            THIS.ConfigurarPaginaLista()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    *  Para o form OPERACIONAL: exibe o resumo do estado atual (opcoes
    *  selecionadas e registros do ultimo processamento). Equivalente ao
    *  "Buscar / Visualizar" nos forms CRUD.
    *--------------------------------------------------------------------------
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
    *  Fecha o form OPERACIONAL. Alias de CmdEncerrarClick() para
    *  compatibilidade com o padrao do pipeline de migracao.
    *--------------------------------------------------------------------------
        THIS.CmdEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    *  Para o form OPERACIONAL: dispara o processamento de recalculo.
    *  Equivale ao "Salvar" nos forms CRUD, adaptado para este contexto.
    *  Valida selecao antes de processar.
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
               THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
                MsgAviso("Selecione ao menos uma op" + CHR(231) + CHR(227) + ;
                         "o de processamento.", "Rec" + CHR(225) + "lculo de Saldos")
                RETURN
            ENDIF
            THIS.FormParaBO()
            THIS.lbl_4c_LblEnd.Visible = .F.
            THIS.txt_4c_Registro.Value = 0
            THIS.CmdProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
    *  Para o form OPERACIONAL: limpa todas as selecoes e reinicia o form
    *  para o estado inicial. Equivale ao "Cancelar" nos forms CRUD.
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            IF !MsgConfirma("Limpar todas as op" + CHR(231) + CHR(245) + ;
                            "es e reiniciar?", "Rec" + CHR(225) + "lculo de Saldos")
                RETURN
            ENDIF
            THIS.LimparCampos()
            THIS.AjustarBotoesPorModo()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao cancelar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
