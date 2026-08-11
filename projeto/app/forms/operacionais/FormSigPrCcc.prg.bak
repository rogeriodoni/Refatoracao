*==============================================================================
* FormSigPrCcc.prg - Recalculo de Saldos (SIGPRCCC)
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRCCC.SCX
* Fase 8/8: COMPLETO - todos os metodos, eventos e integracao finalizados
*==============================================================================

DEFINE CLASS FormSigPrCcc AS FormBase

    *-- Propriedades visuais (copiadas exatamente do original)
    Height       = 600
    Width        = 800
    Caption      = "Rec" + CHR(225) + "lculo de Saldos"
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    ShowTips     = .T.
    KeyPreview   = .T.

    *-- Estado / Negocio
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *-- Largura dos containers flutuantes (para toggle Visible)
    LarguraOpConta   = 536
    LarguraOpEstoque = 536
    LarguraOpCusto   = 536
    LarguraOpCompra  = 536

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        *-- DataSession=2 reseta SET DATE/CENTURY (regra 9.4) - corrigir antes de DODEFAULT
        SET DATE TO BRITISH
        SET CENTURY ON
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCccBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrCcc.", "Erro")
            ELSE
                *-- Inicializa parametros do sistema (SigCdPam)
                THIS.this_oBusinessObject.InicializarDados()

                *-- Monta interface visual
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarControlesPrincipais()
                THIS.ConfigurarContainerOpConta()
                THIS.ConfigurarContainerOpEstoque()
                THIS.ConfigurarContainerOpCusto()
                THIS.ConfigurarContainerOpCompra()
                THIS.TornarControlesVisiveis()
                THIS.ConfigurarBINDEVENTs()

                *-- Propagar titulo para labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Estado inicial do contador de registros
                THIS.txt_4c_Registro.Value = 0

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrCcc.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.Picture     = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
        THIS.ClipControls = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Visible    = .T.
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BorderWidth= 0
            .BackColor  = RGB(100,100,100)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .AutoSize      = .F.
                .BackStyle     = 0
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .AutoSize   = .F.
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255,255,255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarControlesPrincipais - Shape, CheckBoxes, Botoes, LblEnd, Registro
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControlesPrincipais
        *-- Shape decorativo (Shape1 original)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 697
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136,189,188)
        ENDWITH

        *-- CheckBox C.C. (Conta original - Left=350)
        THIS.AddObject("chk_4c_Conta", "CheckBox")
        WITH THIS.chk_4c_Conta
            .Top           = 3
            .Left          = 350
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Picture       = gc_4c_CaminhoIcones + "folder42.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "a_cash1.bmp"
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "C.C."
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ToolTipText   = "Conta Corrente"
            .ForeColor     = RGB(90,90,90)
            .BackColor     = RGB(255,255,255)
            .Themes        = .F.
        ENDWITH

        *-- CheckBox Estoque (Estoque original - Left=425)
        THIS.AddObject("chk_4c_Estoque", "CheckBox")
        WITH THIS.chk_4c_Estoque
            .Top           = 3
            .Left          = 425
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Picture       = gc_4c_CaminhoIcones + "folder22.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "a_diamd1.bmp"
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "Estoque"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ForeColor     = RGB(90,90,90)
            .BackColor     = RGB(255,255,255)
            .Themes        = .F.
        ENDWITH

        *-- CheckBox Custo (btnCusto original - Left=500)
        THIS.AddObject("chk_4c_BtnCusto", "CheckBox")
        WITH THIS.chk_4c_BtnCusto
            .Top           = 3
            .Left          = 500
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Picture       = gc_4c_CaminhoIcones + "folder34.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "d_misc2.bmp"
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "Custo"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ForeColor     = RGB(90,90,90)
            .BackColor     = RGB(255,255,255)
            .Themes        = .F.
        ENDWITH

        *-- CheckBox Ultima Compra (btnCompra original - Left=575)
        THIS.AddObject("chk_4c_BtnCompra", "CheckBox")
        WITH THIS.chk_4c_BtnCompra
            .Top           = 3
            .Left          = 575
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Picture       = gc_4c_CaminhoIcones + "folder27.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "d_misc2.bmp"
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = CHR(218) + "lt. Compra"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ToolTipText   = CHR(218) + "ltima Compra"
            .ForeColor     = RGB(90,90,90)
            .BackColor     = RGB(255,255,255)
            .Themes        = .F.
        ENDWITH

        *-- Botao Processar (Processa original - Left=650)
        *-- Themes=.T. + DisabledPicture obrigatorio para standalone com Picture e Enabled=.F.
        THIS.AddObject("cmd_4c_Processa", "CommandButton")
        WITH THIS.cmd_4c_Processa
            .Top            = 3
            .Left           = 650
            .Height         = 75
            .Width          = 75
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Picture        = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture= gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption        = "Processar"
            .Enabled        = .F.
            .SpecialEffect  = 0
            .ForeColor      = RGB(90,90,90)
            .BackColor      = RGB(255,255,255)
            .Themes         = .T.
            .ToolTipText    = "Processar"
        ENDWITH

        *-- Botao Encerrar/Cancela (Cancela original - Left=725, Cancel=.T.)
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top            = 3
            .Left           = 725
            .Height         = 75
            .Width          = 75
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture= gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel         = .T.
            .Caption        = "Encerrar"
            .SpecialEffect  = 0
            .ForeColor      = RGB(90,90,90)
            .BackColor      = RGB(255,255,255)
            .Themes         = .T.
            .ToolTipText    = "[ESC] Sair"
        ENDWITH

        *-- Label "Processamento Concluido" (LblEnd - inicialmente invisivel)
        THIS.AddObject("lbl_4c_LblEnd", "Label")
        WITH THIS.lbl_4c_LblEnd
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontItalic = .F.
            .FontName   = "Arial"
            .FontSize   = 12
            .WordWrap   = .F.
            .Alignment  = 2
            .BackStyle  = 0
            .Caption    = "Processamento Conclu" + CHR(237) + "do"
            .Height     = 22
            .Left       = 361
            .Top        = 545
            .Width      = 205
            .ForeColor  = RGB(255,0,0)
            .Visible    = .F.
        ENDWITH

        *-- Label "Registros :" (Label1 original)
        THIS.AddObject("lbl_4c_LblRegistros", "Label")
        WITH THIS.lbl_4c_LblRegistros
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontItalic = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .WordWrap   = .F.
            .BackStyle  = 0
            .Caption    = "Registros : "
            .Height     = 15
            .Left       = 171
            .Top        = 547
            .Width      = 65
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox contador de registros (Get_Registro original)
        THIS.AddObject("txt_4c_Registro", "TextBox")
        WITH THIS.txt_4c_Registro
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .InputMask     = "999,999,999"
            .Left          = 238
            .SpecialEffect = 1
            .Top           = 543
            .Width         = 93
            .ReadOnly      = .T.
            .Value         = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerOpConta - Conta Corrente: empresa, grupo, conta, moeda, data
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerOpConta
        THIS.AddObject("cnt_4c_OpConta", "Container")
        WITH THIS.cnt_4c_OpConta
            .Top           = 114
            .Left          = 139
            .Width         = THIS.LarguraOpConta
            .Height        = 81
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .Visible       = .F.
            .BackColor     = RGB(192,192,255)
            .BorderColor   = RGB(90,90,90)

            .AddObject("lbl_4c_TituloOp", "Label")
            WITH .lbl_4c_TituloOp
                .AutoSize      = .T.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontUnderline = .T.
                .BackStyle     = 0
                .Caption       = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
                .Left          = 171
                .Top           = 2
                .ForeColor     = RGB(90,90,90)
            ENDWITH

            .AddObject("lbl_4c_LblEmpresa", "Label")
            WITH .lbl_4c_LblEmpresa
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Empresa :"
                .Height     = 15
                .Left       = 16
                .Top        = 23
                .Width      = 57
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Height        = 23
                .Left          = 75
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 20
                .Width         = 31
                .ForeColor     = RGB(0,0,0)
                .Value         = go_4c_Sistema.cCodEmpresa
            ENDWITH

            .AddObject("lbl_4c_LblGrupos", "Label")
            WITH .lbl_4c_LblGrupos
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Grupo :"
                .Height     = 15
                .Left       = 122
                .Top        = 24
                .Width      = 42
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_TxtGrupos", "TextBox")
            WITH .txt_4c_TxtGrupos
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .Height        = 23
                .Left          = 166
                .MaxLength     = 10
                .SpecialEffect = 1
                .Top           = 20
                .Width         = 80
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_LblContas", "Label")
            WITH .lbl_4c_LblContas
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Conta :"
                .Height     = 15
                .Left       = 255
                .Top        = 24
                .Width      = 41
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_TxtContas", "TextBox")
            WITH .txt_4c_TxtContas
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .Height        = 23
                .Left          = 298
                .MaxLength     = 10
                .SpecialEffect = 1
                .Top           = 20
                .Width         = 80
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_LblMoedas", "Label")
            WITH .lbl_4c_LblMoedas
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Moeda :"
                .Height     = 15
                .Left       = 27
                .Top        = 50
                .Width      = 46
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_TxtMoedas", "TextBox")
            WITH .txt_4c_TxtMoedas
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .Height        = 23
                .Left          = 75
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 46
                .Width         = 31
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_LblData", "Label")
            WITH .lbl_4c_LblData
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "A partir de :"
                .Height     = 15
                .Left       = 121
                .Top        = 50
                .Width      = 68
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_TxtData", "TextBox")
            WITH .txt_4c_TxtData
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Format        = "D"
                .Height        = 23
                .Left          = 191
                .SpecialEffect = 1
                .Top           = 46
                .Width         = 80
                .ForeColor     = RGB(0,0,0)
                .Value         = {}
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerOpEstoque - Estoque: empresa, grupo, estoque, produto, desc, data
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerOpEstoque
        THIS.AddObject("cnt_4c_OpEstoque", "Container")
        WITH THIS.cnt_4c_OpEstoque
            .Top           = 200
            .Left          = 139
            .Width         = THIS.LarguraOpEstoque
            .Height        = 143
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .Visible       = .F.
            .BackColor     = RGB(192,192,255)
            .BorderColor   = RGB(90,90,90)

            .AddObject("lbl_4c_TituloOp", "Label")
            WITH .lbl_4c_TituloOp
                .AutoSize      = .T.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontUnderline = .T.
                .BackStyle     = 0
                .Caption       = "Op" + CHR(231) + CHR(245) + "es de Estoque"
                .Left          = 182
                .Top           = 2
                .ForeColor     = RGB(90,90,90)
            ENDWITH

            .AddObject("lbl_4c_LblEmpresa", "Label")
            WITH .lbl_4c_LblEmpresa
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Empresa :"
                .Height     = 15
                .Left       = 31
                .Top        = 15
                .Width      = 57
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Height        = 23
                .Left          = 90
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 12
                .Width         = 31
                .ForeColor     = RGB(0,0,0)
                .Value         = go_4c_Sistema.cCodEmpresa
            ENDWITH

            .AddObject("lbl_4c_LblGrupos", "Label")
            WITH .lbl_4c_LblGrupos
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Grupo :"
                .Left       = 46
                .Top        = 40
                .Width      = 42
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_TxtGrupos", "TextBox")
            WITH .txt_4c_TxtGrupos
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .Height        = 23
                .Left          = 90
                .MaxLength     = 10
                .SpecialEffect = 1
                .Top           = 37
                .Width         = 80
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_LblEstoque", "Label")
            WITH .lbl_4c_LblEstoque
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Estoque :"
                .Height     = 15
                .Left       = 35
                .Top        = 65
                .Width      = 53
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_Estoque", "TextBox")
            WITH .txt_4c_Estoque
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Height        = 23
                .Left          = 90
                .MaxLength     = 10
                .SpecialEffect = 1
                .Top           = 62
                .Width         = 80
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_LblProduto", "Label")
            WITH .lbl_4c_LblProduto
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Produto :"
                .Left       = 35
                .Top        = 90
                .Width      = 53
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_Produto", "TextBox")
            WITH .txt_4c_Produto
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Height        = 23
                .Left          = 90
                .MaxLength     = 14
                .SpecialEffect = 1
                .Top           = 87
                .Width         = 108
                .ForeColor     = RGB(0,0,0)
            ENDWITH
            .AddObject("txt_4c_Descricao", "TextBox")
            WITH .txt_4c_Descricao
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Height        = 23
                .Left          = 199
                .MaxLength     = 40
                .SpecialEffect = 1
                .Top           = 87
                .Width         = 327
                .ForeColor     = RGB(0,0,0)
                .ReadOnly      = .T.
            ENDWITH

            .AddObject("lbl_4c_LblData", "Label")
            WITH .lbl_4c_LblData
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "A partir de :"
                .Height     = 15
                .Left       = 20
                .Top        = 115
                .Width      = 68
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_TxtData", "TextBox")
            WITH .txt_4c_TxtData
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Format        = "D"
                .Height        = 23
                .Left          = 90
                .SpecialEffect = 1
                .Top           = 112
                .Width         = 80
                .ForeColor     = RGB(0,0,0)
                .Value         = {}
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerOpCusto - Custo de Produto: empresa, produto, desc, data
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerOpCusto
        THIS.AddObject("cnt_4c_OpCusto", "Container")
        WITH THIS.cnt_4c_OpCusto
            .Top           = 349
            .Left          = 139
            .Width         = THIS.LarguraOpCusto
            .Height        = 92
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .Visible       = .F.
            .BackColor     = RGB(192,192,255)
            .BorderColor   = RGB(90,90,90)

            .AddObject("lbl_4c_TituloOp", "Label")
            WITH .lbl_4c_TituloOp
                .AutoSize      = .T.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontUnderline = .T.
                .BackStyle     = 0
                .Caption       = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
                .Left          = 155
                .Top           = 2
                .ForeColor     = RGB(90,90,90)
            ENDWITH

            .AddObject("lbl_4c_LblEmpresa", "Label")
            WITH .lbl_4c_LblEmpresa
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Empresa :"
                .Height     = 15
                .Left       = 31
                .Top        = 14
                .Width      = 57
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Height        = 23
                .Left          = 90
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 11
                .Width         = 31
                .ForeColor     = RGB(0,0,0)
                .Value         = go_4c_Sistema.cCodEmpresa
            ENDWITH

            .AddObject("lbl_4c_LblProduto", "Label")
            WITH .lbl_4c_LblProduto
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Produto :"
                .Left       = 35
                .Top        = 39
                .Width      = 53
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_Produto", "TextBox")
            WITH .txt_4c_Produto
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Height        = 23
                .Left          = 90
                .MaxLength     = 14
                .SpecialEffect = 1
                .Top           = 36
                .Width         = 108
                .ForeColor     = RGB(0,0,0)
            ENDWITH
            .AddObject("txt_4c_Descricao", "TextBox")
            WITH .txt_4c_Descricao
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Height        = 23
                .Left          = 199
                .MaxLength     = 40
                .SpecialEffect = 1
                .Top           = 36
                .Width         = 327
                .ForeColor     = RGB(0,0,0)
                .ReadOnly      = .T.
            ENDWITH

            .AddObject("lbl_4c_LblData", "Label")
            WITH .lbl_4c_LblData
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "A partir de :"
                .Height     = 15
                .Left       = 20
                .Top        = 64
                .Width      = 68
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_TxtData", "TextBox")
            WITH .txt_4c_TxtData
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Format        = "D"
                .Height        = 23
                .Left          = 90
                .SpecialEffect = 1
                .Top           = 61
                .Width         = 80
                .ForeColor     = RGB(0,0,0)
                .Value         = {}
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerOpCompra - Ultima Compra: empresa, produto, desc, data
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerOpCompra
        THIS.AddObject("cnt_4c_OpCompra", "Container")
        WITH THIS.cnt_4c_OpCompra
            .Top           = 447
            .Left          = 139
            .Width         = THIS.LarguraOpCompra
            .Height        = 91
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .Visible       = .F.
            .BackColor     = RGB(192,192,255)
            .BorderColor   = RGB(90,90,90)

            .AddObject("lbl_4c_TituloOp", "Label")
            WITH .lbl_4c_TituloOp
                .AutoSize      = .T.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontUnderline = .T.
                .BackStyle     = 0
                .Caption       = "Op" + CHR(231) + CHR(245) + "es de Ultima Compra do Produto/Cliente"
                .Left          = 140
                .Top           = 2
                .ForeColor     = RGB(90,90,90)
            ENDWITH

            .AddObject("lbl_4c_LblEmpresa", "Label")
            WITH .lbl_4c_LblEmpresa
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Empresa :"
                .Height     = 15
                .Left       = 31
                .Top        = 14
                .Width      = 57
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Height        = 23
                .Left          = 90
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 10
                .Width         = 31
                .ForeColor     = RGB(0,0,0)
                .Value         = go_4c_Sistema.cCodEmpresa
            ENDWITH

            .AddObject("lbl_4c_LblProduto", "Label")
            WITH .lbl_4c_LblProduto
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Produto :"
                .Left       = 35
                .Top        = 39
                .Width      = 53
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_Produto", "TextBox")
            WITH .txt_4c_Produto
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Height        = 23
                .Left          = 90
                .MaxLength     = 14
                .SpecialEffect = 1
                .Top           = 35
                .Width         = 108
                .ForeColor     = RGB(0,0,0)
            ENDWITH
            .AddObject("txt_4c_Descricao", "TextBox")
            WITH .txt_4c_Descricao
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Height        = 23
                .Left          = 199
                .MaxLength     = 40
                .SpecialEffect = 1
                .Top           = 35
                .Width         = 327
                .ForeColor     = RGB(0,0,0)
                .ReadOnly      = .T.
            ENDWITH

            .AddObject("lbl_4c_LblData", "Label")
            WITH .lbl_4c_LblData
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "A partir de :"
                .Height     = 15
                .Left       = 20
                .Top        = 64
                .Width      = 68
                .ForeColor  = RGB(90,90,90)
            ENDWITH
            .AddObject("txt_4c_TxtData", "TextBox")
            WITH .txt_4c_TxtData
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Format        = "D"
                .Height        = 23
                .Left          = 90
                .SpecialEffect = 1
                .Top           = 60
                .Width         = 80
                .ForeColor     = RGB(0,0,0)
                .Value         = {}
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna controles visiveis exceto containers
    * flutuantes que devem comecar ocultos (OpConta, OpEstoque, OpCusto, OpCompra)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_cNome

        IF PCOUNT() = 0
            par_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) # "O"
                LOOP
            ENDIF

            loc_cNome = UPPER(loc_oControl.Name)

            *-- Containers com Visible controlado explicitamente: nao forcar .T.
            IF INLIST(loc_cNome, "CNT_4C_SOMBRA", ;
                                 "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
                                 "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA")
                *-- Tornar filhos visiveis sem tocar Visible do proprio container
                THIS.TornarControlesVisiveis(loc_oControl)
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            *-- Recursar em containers e pageframes
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
               loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - handlers dos checkboxes e botoes
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
        *-- CheckBoxes e botoes principais
        BINDEVENT(THIS.chk_4c_Conta,     "Click", THIS, "ChkContaClick")
        BINDEVENT(THIS.chk_4c_Estoque,   "Click", THIS, "ChkEstoqueClick")
        BINDEVENT(THIS.chk_4c_BtnCusto,  "Click", THIS, "ChkCustoClick")
        BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkCompraClick")
        BINDEVENT(THIS.cmd_4c_Processa,  "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Cancela,   "Click", THIS, "BtnCancelaClick")

        *-- OpConta: Empresa, Grupos, Contas, Moedas
        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_Empresa,   "KeyPress", THIS, "TxtContaEmpresaKeyPress")
        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos, "KeyPress", THIS, "TxtContaGruposKeyPress")
        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtContas, "KeyPress", THIS, "TxtContaContasKeyPress")
        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas, "KeyPress", THIS, "TxtContaMoedasKeyPress")

        *-- OpEstoque: Empresa, Grupos, Estoque, Produto
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_Empresa,   "KeyPress", THIS, "TxtEstEmpresaKeyPress")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos, "KeyPress", THIS, "TxtEstGruposKeyPress")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_Estoque,   "KeyPress", THIS, "TxtEstEstoqueKeyPress")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_Produto,   "KeyPress", THIS, "TxtEstProdutoKeyPress")

        *-- OpCusto: Empresa, Produto
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_Empresa, "KeyPress", THIS, "TxtCustoEmpresaKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_Produto, "KeyPress", THIS, "TxtCustoProdutoKeyPress")

        *-- OpCompra: Empresa, Produto
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_Empresa, "KeyPress", THIS, "TxtCompraEmpresaKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_Produto, "KeyPress", THIS, "TxtCompraProdutoKeyPress")
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - orquestrador do processamento
    *==========================================================================
    PROCEDURE BtnProcessarClick
        LOCAL loc_lSucesso, loc_lAlgum, loc_oBO, loc_oProgress

        loc_lSucesso = .F.
        loc_lAlgum   = .F.
        loc_oProgress = .NULL.

        IF THIS.chk_4c_Conta.Value = 0 AND THIS.chk_4c_Estoque.Value = 0 AND ;
           THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
            MsgAviso("Selecione ao menos uma op" + CHR(231) + CHR(227) + "o de rec" + CHR(225) + "lculo.")
            RETURN .F.
        ENDIF

        TRY
            *-- Desabilitar controles durante processamento
            THIS.chk_4c_Conta.Enabled     = .F.
            THIS.chk_4c_Estoque.Enabled   = .F.
            THIS.chk_4c_BtnCusto.Enabled  = .F.
            THIS.chk_4c_BtnCompra.Enabled = .F.
            THIS.cmd_4c_Processa.Enabled  = .F.
            THIS.cmd_4c_Cancela.Enabled   = .F.
            THIS.lbl_4c_LblEnd.Visible    = .F.
            THIS.txt_4c_Registro.Value    = 0
            DOEVENTS

            loc_oBO = THIS.this_oBusinessObject
            loc_oBO.this_nRegistros = 0

            loc_oProgress = CREATEOBJECT("fwprogressbar")
            IF VARTYPE(loc_oProgress) = "O"
                loc_oProgress.Show()
            ENDIF

            *-- Recalcular Conta Corrente
            IF THIS.chk_4c_Conta.Value = 1
                loc_oBO.this_cEmpConta   = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_Empresa.Value)
                loc_oBO.this_cGrupoConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos.Value)
                loc_oBO.this_cConta      = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_TxtContas.Value)
                loc_oBO.this_cMoedaConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas.Value)
                loc_oBO.this_dDataConta  = THIS.cnt_4c_OpConta.txt_4c_TxtData.Value
                IF VARTYPE(loc_oProgress) = "O"
                    loc_oProgress.Update("Recalculando Conta Corrente...")
                ENDIF
                IF loc_oBO.RecalcularSaldosConta()
                    loc_lAlgum = .T.
                ENDIF
                THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
                DOEVENTS
            ENDIF

            *-- Recalcular Estoque
            IF THIS.chk_4c_Estoque.Value = 1
                loc_oBO.this_cEmpEst   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Empresa.Value)
                loc_oBO.this_cGrupoEst = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos.Value)
                loc_oBO.this_cEstoque  = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Estoque.Value)
                loc_oBO.this_cProdEst  = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_Produto.Value)
                loc_oBO.this_dDataEst  = THIS.cnt_4c_OpEstoque.txt_4c_TxtData.Value
                IF VARTYPE(loc_oProgress) = "O"
                    loc_oProgress.Update("Recalculando Estoque...")
                ENDIF
                IF loc_oBO.RecalcularSaldosEstoque()
                    loc_lAlgum = .T.
                ENDIF
                THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
                DOEVENTS
            ENDIF

            *-- Recalcular Custo de Produto
            IF THIS.chk_4c_BtnCusto.Value = 1
                loc_oBO.this_cEmpCusto  = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_Empresa.Value)
                loc_oBO.this_cProdCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_Produto.Value)
                loc_oBO.this_dDataCusto = THIS.cnt_4c_OpCusto.txt_4c_TxtData.Value
                IF VARTYPE(loc_oProgress) = "O"
                    loc_oProgress.Update("Recalculando Custo de Produto...")
                ENDIF
                IF loc_oBO.RecalcularSaldosCusto()
                    loc_lAlgum = .T.
                ENDIF
                THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
                DOEVENTS
            ENDIF

            *-- Recalcular Ultima Compra
            IF THIS.chk_4c_BtnCompra.Value = 1
                loc_oBO.this_cEmpCompra  = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_Empresa.Value)
                loc_oBO.this_cProdCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_Produto.Value)
                loc_oBO.this_dDataCompra = THIS.cnt_4c_OpCompra.txt_4c_TxtData.Value
                IF VARTYPE(loc_oProgress) = "O"
                    loc_oProgress.Update(CHR(218) + "ltima Compra...")
                ENDIF
                IF loc_oBO.RecalcularSaldosCompra()
                    loc_lAlgum = .T.
                ENDIF
                THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
                DOEVENTS
            ENDIF

            IF loc_lAlgum
                THIS.lbl_4c_LblEnd.Visible = .T.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrCcc.BtnProcessarClick")
        ENDTRY

        *-- Reabilitar controles
        THIS.chk_4c_Conta.Enabled     = .T.
        THIS.chk_4c_Estoque.Enabled   = .T.
        THIS.chk_4c_BtnCusto.Enabled  = .T.
        THIS.chk_4c_BtnCompra.Enabled = .T.
        THIS.cmd_4c_Cancela.Enabled   = .T.
        THIS.AtualizarEstadoProcessa()

        IF VARTYPE(loc_oProgress) = "O"
            loc_oProgress.Release()
            loc_oProgress = .NULL.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnCancelaClick - fecha o formulario
    *==========================================================================
    PROCEDURE BtnCancelaClick
        THISFORM.Release()
    ENDPROC

    *==========================================================================
    * ChkContaClick / ChkEstoqueClick / ChkCustoClick / ChkCompraClick
    *==========================================================================
    PROCEDURE ChkContaClick
        THIS.cnt_4c_OpConta.Visible = (THIS.chk_4c_Conta.Value = 1)
        THIS.AtualizarEstadoProcessa()
    ENDPROC

    PROCEDURE ChkEstoqueClick
        THIS.cnt_4c_OpEstoque.Visible = (THIS.chk_4c_Estoque.Value = 1)
        THIS.AtualizarEstadoProcessa()
    ENDPROC

    PROCEDURE ChkCustoClick
        THIS.cnt_4c_OpCusto.Visible = (THIS.chk_4c_BtnCusto.Value = 1)
        THIS.AtualizarEstadoProcessa()
    ENDPROC

    PROCEDURE ChkCompraClick
        THIS.cnt_4c_OpCompra.Visible = (THIS.chk_4c_BtnCompra.Value = 1)
        THIS.AtualizarEstadoProcessa()
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoProcessa
        LOCAL loc_lAlgum
        loc_lAlgum = (THIS.chk_4c_Conta.Value = 1) OR ;
                     (THIS.chk_4c_Estoque.Value = 1) OR ;
                     (THIS.chk_4c_BtnCusto.Value = 1) OR ;
                     (THIS.chk_4c_BtnCompra.Value = 1)
        THIS.cmd_4c_Processa.Enabled = loc_lAlgum
    ENDPROC

    *==========================================================================
    * KeyPress handlers - OpConta
    *==========================================================================
    PROCEDURE TxtContaEmpresaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpConta.txt_4c_Empresa)
    ENDPROC

    PROCEDURE TxtContaGruposKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupGruposCcr(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos)
    ENDPROC

    PROCEDURE TxtContaContasKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupContas(THIS.cnt_4c_OpConta.txt_4c_TxtContas)
    ENDPROC

    PROCEDURE TxtContaMoedasKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupMoeda(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas)
    ENDPROC

    *==========================================================================
    * KeyPress handlers - OpEstoque
    *==========================================================================
    PROCEDURE TxtEstEmpresaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpEstoque.txt_4c_Empresa)
    ENDPROC

    PROCEDURE TxtEstGruposKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupGruposEst(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos)
    ENDPROC

    PROCEDURE TxtEstEstoqueKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupEstoque(THIS.cnt_4c_OpEstoque.txt_4c_Estoque)
    ENDPROC

    PROCEDURE TxtEstProdutoKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_Produto, THIS.cnt_4c_OpEstoque.txt_4c_Descricao)
    ENDPROC

    *==========================================================================
    * KeyPress handlers - OpCusto
    *==========================================================================
    PROCEDURE TxtCustoEmpresaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCusto.txt_4c_Empresa)
    ENDPROC

    PROCEDURE TxtCustoProdutoKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_Produto, THIS.cnt_4c_OpCusto.txt_4c_Descricao)
    ENDPROC

    *==========================================================================
    * KeyPress handlers - OpCompra
    *==========================================================================
    PROCEDURE TxtCompraEmpresaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCompra.txt_4c_Empresa)
    ENDPROC

    PROCEDURE TxtCompraProdutoKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_Produto, THIS.cnt_4c_OpCompra.txt_4c_Descricao)
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresa - sigcdemp (cemps / razas)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEmpresa(par_oTxt)
        LOCAL loc_oForm, loc_cVal
        loc_cVal  = ALLTRIM(par_oTxt.Value)
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "sigcdemp", "cursor_4c_LkpEmp", "cemps", loc_cVal, "Selecionar Empresa")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF NOT loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("cemps", "", "C" + CHR(243) + "d.")
            loc_oForm.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpEmp")
            par_oTxt.Value = ALLTRIM(cursor_4c_LkpEmp.cemps)
        ENDIF
        IF USED("cursor_4c_LkpEmp")
            USE IN cursor_4c_LkpEmp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * AbrirLookupGruposCcr - SigCdGcr (codigos / descrs)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGruposCcr(par_oTxt)
        LOCAL loc_oForm, loc_cVal
        loc_cVal  = ALLTRIM(par_oTxt.Value)
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_LkpGcr", "codigos", loc_cVal, "Grupo C/C")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF NOT loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
            loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpGcr")
            par_oTxt.Value = ALLTRIM(cursor_4c_LkpGcr.codigos)
        ENDIF
        IF USED("cursor_4c_LkpGcr")
            USE IN cursor_4c_LkpGcr
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * AbrirLookupContas - SigCdCli (Iclis / Rclis)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupContas(par_oTxt)
        LOCAL loc_oForm, loc_cVal
        loc_cVal  = ALLTRIM(par_oTxt.Value)
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_LkpCcr", "Iclis", loc_cVal, "Conta Corrente")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF NOT loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
            loc_oForm.mAddColuna("Rclis", "", "Nome")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpCcr")
            par_oTxt.Value = ALLTRIM(cursor_4c_LkpCcr.Iclis)
        ENDIF
        IF USED("cursor_4c_LkpCcr")
            USE IN cursor_4c_LkpCcr
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * AbrirLookupMoeda - SigCdMoe (cmoes / dmoes)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupMoeda(par_oTxt)
        LOCAL loc_oForm, loc_cVal
        loc_cVal  = ALLTRIM(par_oTxt.Value)
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_LkpMoe", "cmoes", loc_cVal, "Selecionar Moeda")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF NOT loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("cmoes", "", "C" + CHR(243) + "d.")
            loc_oForm.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpMoe")
            par_oTxt.Value = ALLTRIM(cursor_4c_LkpMoe.cmoes)
        ENDIF
        IF USED("cursor_4c_LkpMoe")
            USE IN cursor_4c_LkpMoe
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * AbrirLookupProduto - SigCdPro (cpros / dpros) + atualiza descricao
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupProduto(par_oTxtProd, par_oTxtDesc)
        LOCAL loc_oForm, loc_cVal
        loc_cVal  = ALLTRIM(par_oTxtProd.Value)
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_LkpPro", "cpros", loc_cVal, "Selecionar Produto")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF NOT loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "d.")
            loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpPro")
            par_oTxtProd.Value = ALLTRIM(cursor_4c_LkpPro.cpros)
            IF VARTYPE(par_oTxtDesc) = "O"
                par_oTxtDesc.Value = ALLTRIM(cursor_4c_LkpPro.dpros)
            ENDIF
        ENDIF
        IF USED("cursor_4c_LkpPro")
            USE IN cursor_4c_LkpPro
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * AbrirLookupGruposEst - SigMvHst grupos (grupo de deposito)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGruposEst(par_oTxt)
        LOCAL loc_oForm, loc_cVal
        loc_cVal  = ALLTRIM(par_oTxt.Value)
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigMvHst", "cursor_4c_LkpGruEst", "grupos", loc_cVal, ;
            "Grupo de Dep" + CHR(243) + "sito")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF NOT loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("grupos", "", "Grupo")
            loc_oForm.mAddColuna("estos",  "", "Estoque")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpGruEst")
            par_oTxt.Value = ALLTRIM(cursor_4c_LkpGruEst.grupos)
        ENDIF
        IF USED("cursor_4c_LkpGruEst")
            USE IN cursor_4c_LkpGruEst
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * AbrirLookupEstoque - SigMvHst estos (codigo do deposito)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEstoque(par_oTxt)
        LOCAL loc_oForm, loc_cVal
        loc_cVal  = ALLTRIM(par_oTxt.Value)
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigMvHst", "cursor_4c_LkpEst", "estos", loc_cVal, ;
            "Dep" + CHR(243) + "sito/Estoque")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF NOT loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("estos",  "", "Estoque")
            loc_oForm.mAddColuna("grupos", "", "Grupo")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpEst")
            par_oTxt.Value = ALLTRIM(cursor_4c_LkpEst.estos)
        ENDIF
        IF USED("cursor_4c_LkpEst")
            USE IN cursor_4c_LkpEst
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Reset da UI ao estado inicial de sele" + CHR(231) + CHR(227) + "o
    * Form OPERACIONAL: nao ha Page1/Page2 (layout flat), este metodo
    * restaura o estado limpo equivalente a "voltar para a lista" ??? oculta
    * containers flutuantes, desmarca opcoes, zera contador e mensagem final.
    * Chamado apos processamento concluir OU quando quiser reiniciar selecao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        *-- Desmarca todos os checkboxes de opcao (Conta, Estoque, Custo, Compra)
        THIS.chk_4c_Conta.Value     = 0
        THIS.chk_4c_Estoque.Value   = 0
        THIS.chk_4c_BtnCusto.Value  = 0
        THIS.chk_4c_BtnCompra.Value = 0

        *-- Oculta todos os containers flutuantes de opcoes
        THIS.cnt_4c_OpConta.Visible   = .F.
        THIS.cnt_4c_OpEstoque.Visible = .F.
        THIS.cnt_4c_OpCusto.Visible   = .F.
        THIS.cnt_4c_OpCompra.Visible  = .F.

        *-- Limpa contador de registros e oculta label de conclusao
        THIS.txt_4c_Registro.Value  = 0
        THIS.lbl_4c_LblEnd.Visible  = .F.

        *-- Reabilita controles (caso venham de processamento anterior)
        THIS.chk_4c_Conta.Enabled     = .T.
        THIS.chk_4c_Estoque.Enabled   = .T.
        THIS.chk_4c_BtnCusto.Enabled  = .T.
        THIS.chk_4c_BtnCompra.Enabled = .T.
        THIS.cmd_4c_Cancela.Enabled   = .T.

        *-- Atualiza estado do botao Processar (deve ficar desabilitado sem selecao)
        THIS.AtualizarEstadoProcessa()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Prepara TODOS os campos de entrada do form
    * Form OPERACIONAL: nao ha Page2/Dados; este metodo mapeia o conceito
    * "preparar formulario para entrada de dados" para os 4 containers de
    * opcoes (OpConta, OpEstoque, OpCusto, OpCompra), resetando cada campo
    * para valor default e habilitando edicao. Chamado apos limpeza de UI
    * (ConfigurarPaginaLista) OU quando quiser reiniciar a entrada de dados
    * apos processamento concluir sem fechar o form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        LOCAL loc_cEmp
        loc_cEmp = go_4c_Sistema.cCodEmpresa

        *-- Container OpConta (Conta Corrente): Empresa=default, demais em branco
        WITH THIS.cnt_4c_OpConta
            .txt_4c_Empresa.Value   = loc_cEmp
            .txt_4c_Empresa.Enabled = .T.
            .txt_4c_TxtGrupos.Value = ""
            .txt_4c_TxtGrupos.Enabled = .T.
            .txt_4c_TxtContas.Value = ""
            .txt_4c_TxtContas.Enabled = .T.
            .txt_4c_TxtMoedas.Value = ""
            .txt_4c_TxtMoedas.Enabled = .T.
            .txt_4c_TxtData.Value   = {}
            .txt_4c_TxtData.Enabled = .T.
            .Visible     = .T.
        ENDWITH

        *-- Container OpEstoque: Empresa=default, demais em branco
        WITH THIS.cnt_4c_OpEstoque
            .txt_4c_Empresa.Value   = loc_cEmp
            .txt_4c_Empresa.Enabled = .T.
            .txt_4c_TxtGrupos.Value = ""
            .txt_4c_TxtGrupos.Enabled = .T.
            .txt_4c_Estoque.Value   = ""
            .txt_4c_Estoque.Enabled = .T.
            .txt_4c_Produto.Value   = ""
            .txt_4c_Produto.Enabled = .T.
            .txt_4c_Descricao.Value = ""
            .txt_4c_TxtData.Value   = {}
            .txt_4c_TxtData.Enabled = .T.
            .Visible     = .T.
        ENDWITH

        *-- Container OpCusto: Empresa=default, demais em branco
        WITH THIS.cnt_4c_OpCusto
            .txt_4c_Empresa.Value   = loc_cEmp
            .txt_4c_Empresa.Enabled = .T.
            .txt_4c_Produto.Value   = ""
            .txt_4c_Produto.Enabled = .T.
            .txt_4c_Descricao.Value = ""
            .txt_4c_TxtData.Value   = {}
            .txt_4c_TxtData.Enabled = .T.
            .Visible     = .T.
        ENDWITH

        *-- Container OpCompra: Empresa=default, demais em branco
        WITH THIS.cnt_4c_OpCompra
            .txt_4c_Empresa.Value   = loc_cEmp
            .txt_4c_Empresa.Enabled = .T.
            .txt_4c_Produto.Value   = ""
            .txt_4c_Produto.Enabled = .T.
            .txt_4c_Descricao.Value = ""
            .txt_4c_TxtData.Value   = {}
            .txt_4c_TxtData.Enabled = .T.
            .Visible     = .T.
        ENDWITH

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna qual container de opcoes esta visivel
    * Form OPERACIONAL: nao ha PageFrame; este metodo mapeia o conceito
    * "trocar de pagina" para "trocar qual painel de opcoes esta ativo".
    *   par_nPagina = 1 ??> Conta Corrente     (cnt_4c_OpConta)
    *   par_nPagina = 2 ??> Estoque            (cnt_4c_OpEstoque)
    *   par_nPagina = 3 ??> Custo de Produto   (cnt_4c_OpCusto)
    *   par_nPagina = 4 ??> Ultima Compra      (cnt_4c_OpCompra)
    *   par_nPagina = 0 ??> reset (oculta todos, equivale a ConfigurarPaginaLista)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)

        DO CASE
            CASE loc_nPagina = 1
                THIS.chk_4c_Conta.Value       = 1
                THIS.cnt_4c_OpConta.Visible   = .T.
            CASE loc_nPagina = 2
                THIS.chk_4c_Estoque.Value     = 1
                THIS.cnt_4c_OpEstoque.Visible = .T.
            CASE loc_nPagina = 3
                THIS.chk_4c_BtnCusto.Value    = 1
                THIS.cnt_4c_OpCusto.Visible   = .T.
            CASE loc_nPagina = 4
                THIS.chk_4c_BtnCompra.Value   = 1
                THIS.cnt_4c_OpCompra.Visible  = .T.
            OTHERWISE
                THIS.ConfigurarPaginaLista()
        ENDCASE

        THIS.AtualizarEstadoProcessa()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Reseta o formulario para um novo ciclo de recalculo
    * (Form OPERACIONAL: equivale a "Nova Sessao de Processamento")
    *==========================================================================
    PROCEDURE BtnIncluirClick
        THIS.chk_4c_Conta.Value       = 0
        THIS.chk_4c_Estoque.Value     = 0
        THIS.chk_4c_BtnCusto.Value    = 0
        THIS.chk_4c_BtnCompra.Value   = 0

        THIS.cnt_4c_OpConta.Visible   = .F.
        THIS.cnt_4c_OpEstoque.Visible = .F.
        THIS.cnt_4c_OpCusto.Visible   = .F.
        THIS.cnt_4c_OpCompra.Visible  = .F.

        THIS.LimparCamposContainer(THIS.cnt_4c_OpConta)
        THIS.LimparCamposContainer(THIS.cnt_4c_OpEstoque)
        THIS.LimparCamposContainer(THIS.cnt_4c_OpCusto)
        THIS.LimparCamposContainer(THIS.cnt_4c_OpCompra)

        THIS.txt_4c_Registro.Value    = ""
        THIS.lbl_4c_LblEnd.Visible    = .F.

        THIS.cmd_4c_Processa.Enabled  = .F.
        THIS.cmd_4c_Cancela.Enabled   = .T.

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Habilita novamente os controles apos processamento
    * (Form OPERACIONAL: equivale a "Alterar Selecao apos Processamento")
    *==========================================================================
    PROCEDURE BtnAlterarClick
        THIS.chk_4c_Conta.Enabled     = .T.
        THIS.chk_4c_Estoque.Enabled   = .T.
        THIS.chk_4c_BtnCusto.Enabled  = .T.
        THIS.chk_4c_BtnCompra.Enabled = .T.

        THIS.cnt_4c_OpConta.Enabled   = (THIS.chk_4c_Conta.Value = 1)
        THIS.cnt_4c_OpEstoque.Enabled = (THIS.chk_4c_Estoque.Value = 1)
        THIS.cnt_4c_OpCusto.Enabled   = (THIS.chk_4c_BtnCusto.Value = 1)
        THIS.cnt_4c_OpCompra.Enabled  = (THIS.chk_4c_BtnCompra.Value = 1)

        THIS.cmd_4c_Cancela.Enabled   = .T.
        THIS.AtualizarEstadoProcessa()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe status da ultima sessao de processamento
    * (Form OPERACIONAL: consulta rapida do estado atual)
    *==========================================================================
    PROCEDURE BtnVisualizarClick
        LOCAL loc_cMsg, loc_cSelecoes, loc_nSel

        loc_cSelecoes = ""
        loc_nSel      = 0

        IF THIS.chk_4c_Conta.Value = 1
            loc_cSelecoes = loc_cSelecoes + "- Conta Corrente" + CHR(13)
            loc_nSel      = loc_nSel + 1
        ENDIF
        IF THIS.chk_4c_Estoque.Value = 1
            loc_cSelecoes = loc_cSelecoes + "- Estoque" + CHR(13)
            loc_nSel      = loc_nSel + 1
        ENDIF
        IF THIS.chk_4c_BtnCusto.Value = 1
            loc_cSelecoes = loc_cSelecoes + "- Custo de Produto" + CHR(13)
            loc_nSel      = loc_nSel + 1
        ENDIF
        IF THIS.chk_4c_BtnCompra.Value = 1
            loc_cSelecoes = loc_cSelecoes + "- " + CHR(218) + "ltima Compra" + CHR(13)
            loc_nSel      = loc_nSel + 1
        ENDIF

        IF loc_nSel = 0
            loc_cMsg = "Nenhum tipo de rec" + CHR(225) + "lculo selecionado." + CHR(13) + ;
                       "Marque um dos checkboxes para configurar o processamento."
        ELSE
            loc_cMsg = "Tipos selecionados (" + TRANSFORM(loc_nSel) + "):" + CHR(13) + ;
                       loc_cSelecoes + CHR(13) + ;
                       "Registros processados: " + ALLTRIM(TRANSFORM(THIS.txt_4c_Registro.Value))
        ENDIF

        MsgInfo(loc_cMsg, "Status do Processamento")
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Limpa todas as selecoes e restaura estado inicial
    * (Form OPERACIONAL: equivale a "Cancelar todas as selecoes")
    *==========================================================================
    PROCEDURE BtnExcluirClick
        THIS.chk_4c_Conta.Value       = 0
        THIS.chk_4c_Estoque.Value     = 0
        THIS.chk_4c_BtnCusto.Value    = 0
        THIS.chk_4c_BtnCompra.Value   = 0

        THIS.cnt_4c_OpConta.Visible   = .F.
        THIS.cnt_4c_OpEstoque.Visible = .F.
        THIS.cnt_4c_OpCusto.Visible   = .F.
        THIS.cnt_4c_OpCompra.Visible  = .F.

        THIS.txt_4c_Registro.Value    = ""
        THIS.lbl_4c_LblEnd.Visible    = .F.

        THIS.AtualizarEstadoProcessa()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * LimparCamposContainer - helper para reset das textboxes de um container
    *==========================================================================
    PROTECTED PROCEDURE LimparCamposContainer(par_oContainer)
        LOCAL loc_nI, loc_oCtrl

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)
            IF UPPER(loc_oCtrl.BaseClass) = "TEXTBOX"
                DO CASE
                    CASE VARTYPE(loc_oCtrl.Value) = "C"
                        loc_oCtrl.Value = ""
                    CASE VARTYPE(loc_oCtrl.Value) = "N"
                        loc_oCtrl.Value = 0
                    CASE VARTYPE(loc_oCtrl.Value) = "D"
                        loc_oCtrl.Value = {}
                ENDCASE
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia valores da UI (4 containers) para o BO
    * (OPERACIONAL: nao ha CRUD, mas o BO carrega parametros para o
    * processamento de RecalcularSaldos* e centraliza os valores digitados)
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN .F.
        ENDIF

        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        *-- Container OpConta (Conta Corrente)
        WITH THIS.cnt_4c_OpConta
            loc_oBO.this_cEmpConta   = ALLTRIM(.txt_4c_Empresa.Value)
            loc_oBO.this_cGrupoConta = ALLTRIM(.txt_4c_TxtGrupos.Value)
            loc_oBO.this_cConta      = ALLTRIM(.txt_4c_TxtContas.Value)
            loc_oBO.this_cMoedaConta = ALLTRIM(.txt_4c_TxtMoedas.Value)
            loc_oBO.this_dDataConta  = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
            .Visible     = .T.
        ENDWITH

        *-- Container OpEstoque
        WITH THIS.cnt_4c_OpEstoque
            loc_oBO.this_cEmpEst      = ALLTRIM(.txt_4c_Empresa.Value)
            loc_oBO.this_cGrupoEst    = ALLTRIM(.txt_4c_TxtGrupos.Value)
            loc_oBO.this_cEstoque     = ALLTRIM(.txt_4c_Estoque.Value)
            loc_oBO.this_cProdEst     = ALLTRIM(.txt_4c_Produto.Value)
            loc_oBO.this_cDescProdEst = ALLTRIM(.txt_4c_Descricao.Value)
            loc_oBO.this_dDataEst     = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
            .Visible     = .T.
        ENDWITH

        *-- Container OpCusto
        WITH THIS.cnt_4c_OpCusto
            loc_oBO.this_cEmpCusto      = ALLTRIM(.txt_4c_Empresa.Value)
            loc_oBO.this_cProdCusto     = ALLTRIM(.txt_4c_Produto.Value)
            loc_oBO.this_cDescProdCusto = ALLTRIM(.txt_4c_Descricao.Value)
            loc_oBO.this_dDataCusto     = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
            .Visible     = .T.
        ENDWITH

        *-- Container OpCompra
        WITH THIS.cnt_4c_OpCompra
            loc_oBO.this_cEmpCompra      = ALLTRIM(.txt_4c_Empresa.Value)
            loc_oBO.this_cProdCompra     = ALLTRIM(.txt_4c_Produto.Value)
            loc_oBO.this_cDescProdCompra = ALLTRIM(.txt_4c_Descricao.Value)
            loc_oBO.this_dDataCompra     = IIF(VARTYPE(.txt_4c_TxtData.Value) = "D", .txt_4c_TxtData.Value, {})
            .Visible     = .T.
        ENDWITH

        *-- Contador de registros processados
        IF VARTYPE(THIS.txt_4c_Registro.Value) = "N"
            loc_oBO.this_nRegistros = THIS.txt_4c_Registro.Value
        ELSE
            loc_oBO.this_nRegistros = TRANSFORM(THIS.txt_4c_Registro.Value)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Copia valores do BO para a UI (4 containers)
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN .F.
        ENDIF

        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        *-- Container OpConta (Conta Corrente)
        WITH THIS.cnt_4c_OpConta
            .txt_4c_Empresa.Value   = loc_oBO.this_cEmpConta
            .txt_4c_TxtGrupos.Value = loc_oBO.this_cGrupoConta
            .txt_4c_TxtContas.Value = loc_oBO.this_cConta
            .txt_4c_TxtMoedas.Value = loc_oBO.this_cMoedaConta
            .txt_4c_TxtData.Value   = loc_oBO.this_dDataConta
            .Visible     = .T.
        ENDWITH

        *-- Container OpEstoque
        WITH THIS.cnt_4c_OpEstoque
            .txt_4c_Empresa.Value   = loc_oBO.this_cEmpEst
            .txt_4c_TxtGrupos.Value = loc_oBO.this_cGrupoEst
            .txt_4c_Estoque.Value   = loc_oBO.this_cEstoque
            .txt_4c_Produto.Value   = loc_oBO.this_cProdEst
            .txt_4c_Descricao.Value = loc_oBO.this_cDescProdEst
            .txt_4c_TxtData.Value   = loc_oBO.this_dDataEst
            .Visible     = .T.
        ENDWITH

        *-- Container OpCusto
        WITH THIS.cnt_4c_OpCusto
            .txt_4c_Empresa.Value   = loc_oBO.this_cEmpCusto
            .txt_4c_Produto.Value   = loc_oBO.this_cProdCusto
            .txt_4c_Descricao.Value = loc_oBO.this_cDescProdCusto
            .txt_4c_TxtData.Value   = loc_oBO.this_dDataCusto
            .Visible     = .T.
        ENDWITH

        *-- Container OpCompra
        WITH THIS.cnt_4c_OpCompra
            .txt_4c_Empresa.Value   = loc_oBO.this_cEmpCompra
            .txt_4c_Produto.Value   = loc_oBO.this_cProdCompra
            .txt_4c_Descricao.Value = loc_oBO.this_cDescProdCompra
            .txt_4c_TxtData.Value   = loc_oBO.this_dDataCompra
            .Visible     = .T.
        ENDWITH

        THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros

        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita containers e checkboxes conforme
    * o estado de processamento (par_lHabilitar). Chamado por Processa e
    * ao terminar o processamento para bloquear a UI durante a execucao SQL.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        *-- Checkboxes principais
        THIS.chk_4c_Conta.Enabled     = loc_lHab
        THIS.chk_4c_Estoque.Enabled   = loc_lHab
        THIS.chk_4c_BtnCusto.Enabled  = loc_lHab
        THIS.chk_4c_BtnCompra.Enabled = loc_lHab

        *-- Containers de opcoes: enabled apenas se o checkbox correspondente
        *-- estiver marcado E o form estiver habilitado
        THIS.cnt_4c_OpConta.Enabled   = loc_lHab AND (THIS.chk_4c_Conta.Value     = 1)
        THIS.cnt_4c_OpEstoque.Enabled = loc_lHab AND (THIS.chk_4c_Estoque.Value   = 1)
        THIS.cnt_4c_OpCusto.Enabled   = loc_lHab AND (THIS.chk_4c_BtnCusto.Value  = 1)
        THIS.cnt_4c_OpCompra.Enabled  = loc_lHab AND (THIS.chk_4c_BtnCompra.Value = 1)

        *-- Botoes de acao
        THIS.cmd_4c_Cancela.Enabled  = loc_lHab
        THIS.cmd_4c_Processa.Enabled = loc_lHab AND ( ;
            THIS.chk_4c_Conta.Value = 1 OR THIS.chk_4c_Estoque.Value = 1 OR ;
            THIS.chk_4c_BtnCusto.Value = 1 OR THIS.chk_4c_BtnCompra.Value = 1)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa TODOS os campos dos 4 containers de opcoes
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos
        THIS.LimparCamposContainer(THIS.cnt_4c_OpConta)
        THIS.LimparCamposContainer(THIS.cnt_4c_OpEstoque)
        THIS.LimparCamposContainer(THIS.cnt_4c_OpCusto)
        THIS.LimparCamposContainer(THIS.cnt_4c_OpCompra)

        *-- Restaura empresa padrao apos limpeza (evita campo vazio nas 4 abas)
        LOCAL loc_cEmp
        loc_cEmp = go_4c_Sistema.cCodEmpresa
        THIS.cnt_4c_OpConta.txt_4c_Empresa.Value   = loc_cEmp
        THIS.cnt_4c_OpEstoque.txt_4c_Empresa.Value = loc_cEmp
        THIS.cnt_4c_OpCusto.txt_4c_Empresa.Value   = loc_cEmp
        THIS.cnt_4c_OpCompra.txt_4c_Empresa.Value  = loc_cEmp

        THIS.txt_4c_Registro.Value = 0
        THIS.lbl_4c_LblEnd.Visible = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega parametros do sistema (SigCdPam) via BO e
    * atualiza a UI. Nome vem do padrao CRUD; aqui equivale a "refresh
    * dos parametros centrais que direcionam o processamento".
    *==========================================================================
    PROCEDURE CarregarLista
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN .F.
        ENDIF

        TRY
            THIS.this_oBusinessObject.InicializarDados()
            THIS.BOParaForm()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao recarregar par" + CHR(226) + "metros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta enabled dos botoes conforme o modo de UI
    *   par_cModo = "INICIAL"      -> aguardando selecao (Processa disabled)
    *   par_cModo = "PROCESSANDO"  -> execucao SQL em curso (tudo disabled)
    *   par_cModo = "CONCLUIDO"    -> processamento terminado (Cancela habilita)
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_cModo
        loc_cModo = IIF(VARTYPE(par_cModo) = "C" AND !EMPTY(par_cModo), UPPER(par_cModo), "INICIAL")

        DO CASE
            CASE loc_cModo = "PROCESSANDO"
                THIS.cmd_4c_Processa.Enabled = .F.
                THIS.cmd_4c_Cancela.Enabled  = .F.
                THIS.HabilitarCampos(.F.)
            CASE loc_cModo = "CONCLUIDO"
                THIS.cmd_4c_Processa.Enabled = .F.
                THIS.cmd_4c_Cancela.Enabled  = .T.
                THIS.lbl_4c_LblEnd.Visible   = .T.
                THIS.HabilitarCampos(.F.)
            OTHERWISE
                *-- INICIAL: aguardando selecao
                THIS.cmd_4c_Cancela.Enabled  = .T.
                THIS.lbl_4c_LblEnd.Visible   = .F.
                THIS.HabilitarCampos(.T.)
                THIS.AtualizarEstadoProcessa()
        ENDCASE

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega parametros centrais do sistema (SigCdPam)
    * Util para atualizar moeda central, grupos padrao, etc. sem sair do form
    *==========================================================================
    PROCEDURE BtnBuscarClick
        IF THIS.CarregarLista()
            MsgInfo("Par" + CHR(226) + "metros do sistema recarregados com sucesso.", ;
                    "Atualiza" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o form (equivalente ao botao Cancela/Sair)
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias para BtnProcessarClick (executa recalculo)
    * (OPERACIONAL: nao ha "salvar registro"; o botao de acao positiva
    * eh Processar, entao Salvar mapeia para o mesmo fluxo)
    *==========================================================================
    PROCEDURE BtnSalvarClick
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Alias para BtnCancelaClick (encerra o form)
    *==========================================================================
    PROCEDURE BtnCancelarClick
        THIS.BtnCancelaClick()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
