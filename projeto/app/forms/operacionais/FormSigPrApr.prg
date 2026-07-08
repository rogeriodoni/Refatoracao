*============================================================================
* FormSigPrApr.prg - Reajuste de Precifica" + CHR(231) + CHR(227) + "o
* Tipo: OPERACIONAL
* BO: SigPrAprBO (SigCdPro)
*============================================================================

DEFINE CLASS FormSigPrApr AS FormBase

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    WindowType   = 1
    DataSession  = 2
    Themes       = .F.
    ShowWindow   = 1
    FontName     = "Verdana"
    FontSize     = 8

    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_lAllSelected    = .T.
    this_lInCol5         = .F.
    this_nAntValAtu      = 0

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursores de trabalho
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursors, loc_nI
        DIMENSION loc_aCursors[5]
        loc_aCursors[1] = "cursor_4c_Produtos"
        loc_aCursors[2] = "cursor_4c_TmpPro"
        loc_aCursors[3] = "cursor_4c_Pam"
        loc_aCursors[4] = "cursor_4c_Pac"
        loc_aCursors[5] = "cursor_4c_Grp"
        FOR loc_nI = 1 TO 5
            IF USED(loc_aCursors[loc_nI])
                USE IN (loc_aCursors[loc_nI])
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Constru" + CHR(231) + CHR(227) + "o do form operacional
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrAprBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar SigPrAprBO.", "Erro")
            ELSE
                IF !THIS.this_oBusinessObject.CarregarParametros()
                    MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
                ELSE
                    THIS.this_oBusinessObject.this_lLibValAtu = ;
                        THIS.this_oBusinessObject.VerificarAcessoEdicaoManual()

                    *-- Cursor de produtos para o grid (vazio no inicio)
                    IF USED("cursor_4c_Produtos")
                        USE IN cursor_4c_Produtos
                    ENDIF
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Produtos ( ;
                        lMarca  N(1)    NULL, ;
                        CPros   C(14)   NULL, ;
                        DPros   C(40)   NULL, ;
                        ValAnt  N(14,2) NULL, ;
                        ValAtu  N(14,2) NULL, ;
                        fCustos N(8,3)  NULL, ;
                        MoePcs  C(3)    NULL, ;
                        CustoFs N(12,3) NULL, ;
                        Manual  N(1)    NULL  ;
                    )
                    SET NULL OFF
                    INDEX ON CPros TAG CPros
                    SELECT cursor_4c_Produtos
                    SET ORDER TO
                    GO TOP

                    *-- Cursor de produtos temp (SigCdPro) vazio
                    IF USED("cursor_4c_TmpPro")
                        USE IN cursor_4c_TmpPro
                    ENDIF
                    IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                        LOCAL loc_nR
                        loc_nR = SQLEXEC(gnConnHandle, ;
                            "SELECT * FROM SigCdPro WHERE 0 = 1", "cursor_4c_TmpPro")
                        IF loc_nR > 0
                            SELECT cursor_4c_TmpPro
                            INDEX ON CPros TAG CPros
                            GO TOP
                        ENDIF
                    ENDIF

                    THIS.ConfigurarPageFrame()
                    THIS.Caption = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
                    THIS.ConfigurarPaginaLista()
                    THIS.ConfigurarPaginaDados()

                    THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                    THIS.TornarControlesVisiveis(THIS)

                    *-- Visibilidade inicial por tipo (Tipo 1 = Variacao)
                    THIS.AtualizarVisibilidade(1)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Fundo + container cabecalho cinza
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Caption   = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Caption   = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Todos os controles do form operacional
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()

        *----------------------------------------------------------------------
        * CommandGroup: Processar | Atualizar | Encerrar
        *----------------------------------------------------------------------
        THIS.AddObject("cmg_4c_Acao", "CommandGroup")
        WITH THIS.cmg_4c_Acao
            .Top           = 0
            .Left          = 770
            .Width         = 225
            .Height        = 85
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .ButtonCount   = 3
            .Themes        = .F.
            .AutoSize      = .F.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Processar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "Atualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Enabled         = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Acao.Buttons(1), "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmg_4c_Acao.Buttons(2), "Click", THIS, "BtnAtualizarClick")
        BINDEVENT(THIS.cmg_4c_Acao.Buttons(3), "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * OptionGroup: Tipo de reajuste
        *----------------------------------------------------------------------
        THIS.AddObject("opt_4c_Tipo", "OptionGroup")
        WITH THIS.opt_4c_Tipo
            .Top           = 134
            .Left          = 159
            .Width         = 208
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 0
            .AutoSize      = .F.
            .ButtonCount   = 3
            .Value         = 1

            WITH .Buttons(1)
                .Left      = 5
                .Top       = 5
                .Width     = 59
                .Height    = 15
                .Caption   = "Varia" + CHR(231) + CHR(227) + "o"
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Left      = 74
                .Top       = 5
                .Height    = 15
                .Caption   = "MarkUp"
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH

            WITH .Buttons(3)
                .Left      = 139
                .Top       = 5
                .Width     = 53
                .Height    = 15
                .Caption   = "C" + CHR(226) + "mbio"
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.opt_4c_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")

        *----------------------------------------------------------------------
        * Label: "Grupo de Produto :"
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Grupo", "Label")
        WITH THIS.lbl_4c_Grupo
            .Top       = 113
            .Left      = 69
            .Width     = 94
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Grupo de Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Grupo de (codigo)
        THIS.AddObject("txt_4c_CdGrupo", "TextBox")
        WITH THIS.txt_4c_CdGrupo
            .Top           = 109
            .Left          = 165
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_CdGrupo, "DblClick", THIS, "AbrirBuscaCdGrupo")
        BINDEVENT(THIS.txt_4c_CdGrupo, "KeyPress", THIS, "TeclaLookupCdGrupo")

        *-- Label: "at" + CHR(233)
        THIS.AddObject("lbl_4c_Ate", "Label")
        WITH THIS.lbl_4c_Ate
            .Top       = 113
            .Left      = 203
            .Width     = 18
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "at" + CHR(233)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Grupo ate (codigo)
        THIS.AddObject("txt_4c_AteGrupo", "TextBox")
        WITH THIS.txt_4c_AteGrupo
            .Top           = 109
            .Left          = 228
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_AteGrupo, "DblClick", THIS, "AbrirBuscaAteGrupo")
        BINDEVENT(THIS.txt_4c_AteGrupo, "KeyPress", THIS, "TeclaLookupAteGrupo")

        *-- Label: "Ignorar Componentes" (CheckBox)
        THIS.AddObject("chk_4c_Ignorar", "CheckBox")
        WITH THIS.chk_4c_Ignorar
            .Top       = 112
            .Left      = 609
            .Width     = 123
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Ignorar Componentes"
            .BackStyle = 0
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .ToolTipText = "N" + CHR(227) + "o Checa Se o Produto Est" + CHR(225) + ;
                           " em Uso Como Componente de Outros Produtos"
        ENDWITH

        *-- Label: "Grupo de Venda :" (Colecao)
        THIS.AddObject("lbl_4c_GrupoVd", "Label")
        WITH THIS.lbl_4c_GrupoVd
            .Top       = 113
            .Left      = 399
            .Width     = 86
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Cole" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Colecao
        THIS.AddObject("txt_4c_Col", "TextBox")
        WITH THIS.txt_4c_Col
            .Top           = 109
            .Left          = 487
            .Width         = 94
            .Height        = 23
            .MaxLength     = 10
            .Format        = "K"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Col, "DblClick", THIS, "AbrirBuscaCol")
        BINDEVENT(THIS.txt_4c_Col, "KeyPress", THIS, "TeclaLookupCol")

        *----------------------------------------------------------------------
        * Label: "Reajuste por :"
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_TipoLabel", "Label")
        WITH THIS.lbl_4c_TipoLabel
            .Top       = 139
            .Left      = 92
            .Width     = 71
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Reajuste por :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label: "Variacao de Preco :" (Tipo 1)
        THIS.AddObject("lbl_4c_Variacao", "Label")
        WITH THIS.lbl_4c_Variacao
            .Top       = 139
            .Left      = 390
            .Width     = 95
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Variacao (Tipo 1)
        THIS.AddObject("txt_4c_Variacao", "TextBox")
        WITH THIS.txt_4c_Variacao
            .Top           = 135
            .Left          = 487
            .Width         = 94
            .Height        = 23
            .Alignment     = 3
            .Format        = "K99,999.99"
            .InputMask     = "99,999.99"
            .MaxLength     = 9
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
        ENDWITH
        BINDEVENT(THIS.txt_4c_Variacao, "KeyPress", THIS, "TxtVariacaoLostFocus")

        *-- Label: "%" (Tipo 1)
        THIS.AddObject("lbl_4c_Pct", "Label")
        WITH THIS.lbl_4c_Pct
            .Top       = 139
            .Left      = 585
            .Width     = 13
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "%"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- CheckBox: "Incluir Custos" (Tipo 1)
        THIS.AddObject("chk_4c_IncCusts", "CheckBox")
        WITH THIS.chk_4c_IncCusts
            .Top       = 139
            .Left      = 609
            .Width     = 83
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Incluir Custos"
            .BackStyle = 0
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label: "Moeda :" (Tipo 2)
        THIS.AddObject("lbl_4c_Moeda", "Label")
        WITH THIS.lbl_4c_Moeda
            .Top       = 139
            .Left      = 444
            .Width     = 41
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Moeda (Tipo 2)
        THIS.AddObject("txt_4c_Moeda", "TextBox")
        WITH THIS.txt_4c_Moeda
            .Top           = 135
            .Left          = 487
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Moeda, "DblClick", THIS, "AbrirBuscaMoeda")
        BINDEVENT(THIS.txt_4c_Moeda, "KeyPress", THIS, "TeclaLookupMoeda")

        *----------------------------------------------------------------------
        * Row 2: Fator de Custo / MarkUp de / para
        *----------------------------------------------------------------------

        *-- Label: "Fator de Custo:" (Tipo 2)
        THIS.AddObject("lbl_4c_Fator", "Label")
        WITH THIS.lbl_4c_Fator
            .Top       = 165
            .Left      = 85
            .Width     = 78
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Fator de Custo:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Fator (Tipo 2)
        THIS.AddObject("txt_4c_Fator", "TextBox")
        WITH THIS.txt_4c_Fator
            .Top           = 161
            .Left          = 165
            .Width         = 73
            .Height        = 23
            .Alignment     = 3
            .InputMask     = "9999.999"
            .MaxLength     = 8
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
        ENDWITH

        *-- TextBox: Moeda Custo (Tipo 2)
        THIS.AddObject("txt_4c_MoeCusto", "TextBox")
        WITH THIS.txt_4c_MoeCusto
            .Top           = 161
            .Left          = 241
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderColor   = RGB(90, 90, 90)
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoeCusto, "DblClick", THIS, "AbrirBuscaMoeCusto")
        BINDEVENT(THIS.txt_4c_MoeCusto, "KeyPress", THIS, "TeclaLookupMoeCusto")

        *-- Label: "MarkUp :" (Tipo 2)
        THIS.AddObject("lbl_4c_MarkUp", "Label")
        WITH THIS.lbl_4c_MarkUp
            .Top       = 165
            .Left      = 440
            .Width     = 45
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "MarkUp :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: MarkUp1 (Tipo 2)
        THIS.AddObject("txt_4c_MarkUp1", "TextBox")
        WITH THIS.txt_4c_MarkUp1
            .Top           = 161
            .Left          = 487
            .Width         = 52
            .Height        = 23
            .Alignment     = 3
            .InputMask     = "999.99"
            .MaxLength     = 6
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
        ENDWITH

        *-- Label: "para" (Tipo 2)
        THIS.AddObject("lbl_4c_Para", "Label")
        WITH THIS.lbl_4c_Para
            .Top       = 165
            .Left      = 547
            .Width     = 24
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "para"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: MarkUp2 (Tipo 2)
        THIS.AddObject("txt_4c_MarkUp2", "TextBox")
        WITH THIS.txt_4c_MarkUp2
            .Top           = 161
            .Left          = 580
            .Width         = 52
            .Height        = 23
            .Alignment     = 3
            .InputMask     = "999.99"
            .MaxLength     = 6
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
        ENDWITH

        *----------------------------------------------------------------------
        * Row 3: Promocao + Limpar
        *----------------------------------------------------------------------

        *-- Label: "Promo" + CHR(231) + CHR(227) + "o :"
        THIS.AddObject("lbl_4c_Promo", "Label")
        WITH THIS.lbl_4c_Promo
            .Top       = 191
            .Left      = 107
            .Width     = 56
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Promo
        THIS.AddObject("txt_4c_Promo", "TextBox")
        WITH THIS.txt_4c_Promo
            .Top           = 187
            .Left          = 165
            .Width         = 185
            .Height        = 23
            .MaxLength     = 25
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Promo, "DblClick", THIS, "AbrirBuscaPromo")
        BINDEVENT(THIS.txt_4c_Promo, "KeyPress", THIS, "TeclaLookupPromo")

        *-- CheckBox: "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
        THIS.AddObject("chk_4c_Limpar", "CheckBox")
        WITH THIS.chk_4c_Limpar
            .Top       = 191
            .Left      = 362
            .Width     = 157
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
            .BackStyle = 0
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *----------------------------------------------------------------------
        * Row 4: Fornecedor
        *----------------------------------------------------------------------

        *-- Label: "Fornecedor :"
        THIS.AddObject("lbl_4c_Forne", "Label")
        WITH THIS.lbl_4c_Forne
            .Top       = 216
            .Left      = 99
            .Width     = 64
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Fornecedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Conta (codigo fornecedor)
        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Top           = 213
            .Left          = 165
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Conta, "DblClick", THIS, "AbrirBuscaConta")
        BINDEVENT(THIS.txt_4c_Conta, "KeyPress", THIS, "TeclaLookupConta")

        *-- TextBox: DConta (descricao fornecedor)
        THIS.AddObject("txt_4c_DConta", "TextBox")
        WITH THIS.txt_4c_DConta
            .Top           = 213
            .Left          = 248
            .Width         = 290
            .Height        = 23
            .MaxLength     = 50
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_DConta, "DblClick", THIS, "AbrirBuscaDConta")
        BINDEVENT(THIS.txt_4c_DConta, "KeyPress", THIS, "TeclaLookupDConta")

        *----------------------------------------------------------------------
        * Row 5: Moeda Custo Compo / Moeda Preco Ideal / Feitio
        *----------------------------------------------------------------------

        *-- Label: "Moeda Custo Compo. :" (Tipo 2)
        THIS.AddObject("lbl_4c_Moecs", "Label")
        WITH THIS.lbl_4c_Moecs
            .Top       = 244
            .Left      = 51
            .Width     = 112
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda Custo Compo. :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Moecs (Tipo 2)
        THIS.AddObject("txt_4c_Moecs", "TextBox")
        WITH THIS.txt_4c_Moecs
            .Top           = 240
            .Left          = 165
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Moecs, "DblClick", THIS, "AbrirBuscaMoecs")
        BINDEVENT(THIS.txt_4c_Moecs, "KeyPress", THIS, "TeclaLookupMoecs")

        *-- Label: "Moeda Pre" + CHR(231) + "o Ideal :" (Tipo 2)
        THIS.AddObject("lbl_4c_Moedas", "Label")
        WITH THIS.lbl_4c_Moedas
            .Top       = 244
            .Left      = 320
            .Width     = 98
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda Pre" + CHR(231) + "o Ideal :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: Moedas (Tipo 2)
        THIS.AddObject("txt_4c_Moedas", "TextBox")
        WITH THIS.txt_4c_Moedas
            .Top           = 240
            .Left          = 420
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_Moedas, "DblClick", THIS, "AbrirBuscaMoedas")
        BINDEVENT(THIS.txt_4c_Moedas, "KeyPress", THIS, "TeclaLookupMoedas")

        *-- Label: "Feitio :" (Tipo 2)
        THIS.AddObject("lbl_4c_CFtios", "Label")
        WITH THIS.lbl_4c_CFtios
            .Top       = 244
            .Left      = 531
            .Width     = 35
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Feitio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: CFtios (Tipo 2)
        THIS.AddObject("txt_4c_CFtios", "TextBox")
        WITH THIS.txt_4c_CFtios
            .Top           = 240
            .Left          = 568
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_CFtios, "DblClick", THIS, "AbrirBuscaCFtios")
        BINDEVENT(THIS.txt_4c_CFtios, "KeyPress", THIS, "TeclaLookupCFtios")

        *----------------------------------------------------------------------
        * Row 6: Moeda Custo Total / Moeda Preco Atual
        *----------------------------------------------------------------------

        *-- Label: "Moeda Custo Total :" (Tipo 2)
        THIS.AddObject("lbl_4c_MoeCusFs", "Label")
        WITH THIS.lbl_4c_MoeCusFs
            .Top       = 270
            .Left      = 64
            .Width     = 99
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda Custo Total :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: MoeCusFs (Tipo 2)
        THIS.AddObject("txt_4c_MoeCusFs", "TextBox")
        WITH THIS.txt_4c_MoeCusFs
            .Top           = 266
            .Left          = 165
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoeCusFs, "DblClick", THIS, "AbrirBuscaMoeCusFs")
        BINDEVENT(THIS.txt_4c_MoeCusFs, "KeyPress", THIS, "TeclaLookupMoeCusFs")

        *-- Label: "Moeda Pre" + CHR(231) + "o Atual :" (Tipo 2)
        THIS.AddObject("lbl_4c_MoeVs", "Label")
        WITH THIS.lbl_4c_MoeVs
            .Top       = 270
            .Left      = 319
            .Width     = 99
            .Height    = 15
            .AutoSize  = .T.
            .Caption   = "Moeda Pre" + CHR(231) + "o Atual :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox: MoeVs (Tipo 2)
        THIS.AddObject("txt_4c_MoeVs", "TextBox")
        WITH THIS.txt_4c_MoeVs
            .Top           = 266
            .Left          = 420
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoeVs, "DblClick", THIS, "AbrirBuscaMoeVs")
        BINDEVENT(THIS.txt_4c_MoeVs, "KeyPress", THIS, "TeclaLookupMoeVs")

        *----------------------------------------------------------------------
        * CheckBox: Modo manual "Produtos" (chkAuditado)
        *----------------------------------------------------------------------
        THIS.AddObject("chk_4c_Auditado", "CheckBox")
        WITH THIS.chk_4c_Auditado
            .Top           = 307
            .Left          = 763
            .Width         = 75
            .Height        = 75
            .Style         = 1
            .Caption       = "Produtos"
            .Value         = 0
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Picture       = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
        ENDWITH
        BINDEVENT(THIS.chk_4c_Auditado, "Click", THIS, "ChkAuditadoClick")

        *----------------------------------------------------------------------
        * Grid de produtos
        *----------------------------------------------------------------------
        THIS.AddObject("grd_4c_Produtos", "Grid")
        WITH THIS.grd_4c_Produtos
            .Top          = 307
            .Left         = 31
            .Width        = 725
            .Height       = 247
            .FontName     = "Verdana"
            .FontSize     = 8
            .HeaderHeight = 20
            .RowHeight    = 16
            .ScrollBars   = 2
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .GridLines    = 3
            .ColumnCount  = 5

            *-- Column1: CheckBox de selecao (lMarca)
            WITH .Column1
                .Width         = 20
                .Alignment     = 3
                .Movable       = .F.
                .Resizable     = .F.
                .Sparse        = .F.
                .FontName      = "Verdana"
                .FontSize      = 8
                .Header1.Caption   = ""
                .Header1.Picture   = gc_4c_CaminhoIcones + "checkbx.bmp"
                .Header1.Alignment = 2
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
            ENDWITH

            *-- Column2: Codigo do produto (CPros)
            WITH .Column2
                .Width             = 108
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Verdana"
                .FontSize          = 8
                .Header1.Caption   = "Produto"
                .Header1.Alignment = 2
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
            ENDWITH

            *-- Column3: Descricao (DPros)
            WITH .Column3
                .Width             = 350
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Verdana"
                .FontSize          = 8
                .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
            ENDWITH

            *-- Column4: Preco Anterior (ValAnt)
            WITH .Column4
                .Width             = 100
                .Alignment         = 1
                .Movable           = .F.
                .Resizable         = .F.
                .InputMask         = "999,999,999.99"
                .FontName          = "Verdana"
                .FontSize          = 8
                .Header1.Caption   = "Pre" + CHR(231) + "o Anterior"
                .Header1.Alignment = 2
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
            ENDWITH

            *-- Column5: Preco Atual (ValAtu) - editavel se VMANUAL
            WITH .Column5
                .Width             = 111
                .Alignment         = 1
                .Movable           = .F.
                .Resizable         = .F.
                .InputMask         = "999,999,999.99"
                .FontName          = "Verdana"
                .FontSize          = 8
                .Header1.Alignment = 2
                .Header1.FontName  = "Verdana"
                .Header1.FontSize  = 8
            ENDWITH
        ENDWITH

        *-- CheckBox em Column1 DEVE ser adicionado ANTES do ControlSource (regra Error 1767)
        THIS.grd_4c_Produtos.Column1.AddObject("Check1", "CheckBox")
        THIS.grd_4c_Produtos.Column1.Check1.Caption = ""
        THIS.grd_4c_Produtos.Column1.Check1.Value   = 0
        THIS.grd_4c_Produtos.Column1.CurrentControl = "Check1"

        *-- Define RecordSource FORA do WITH para evitar auto-bind sobrescrever ControlSources
        THIS.grd_4c_Produtos.ColumnCount = 5
        THIS.grd_4c_Produtos.RecordSource = "cursor_4c_Produtos"
        THIS.grd_4c_Produtos.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
        THIS.grd_4c_Produtos.Column2.ControlSource = "cursor_4c_Produtos.CPros"
        THIS.grd_4c_Produtos.Column3.ControlSource = "cursor_4c_Produtos.DPros"
        THIS.grd_4c_Produtos.Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
        THIS.grd_4c_Produtos.Column5.ControlSource = "cursor_4c_Produtos.ValAtu"

        *-- Caption e ReadOnly do Column5 conforme acesso VMANUAL
        LOCAL loc_lLibValAtu
        loc_lLibValAtu = THIS.this_oBusinessObject.this_lLibValAtu
        IF loc_lLibValAtu
            THIS.grd_4c_Produtos.Column5.Header1.Caption = "Pre" + CHR(231) + "o Atual"
            THIS.grd_4c_Produtos.Column5.ReadOnly = .F.
        ELSE
            THIS.grd_4c_Produtos.Column5.Header1.Caption = "Pre" + CHR(231) + "o Atual"
            THIS.grd_4c_Produtos.Column5.Header1.Picture = gc_4c_CaminhoIcones + "lock.bmp"
            THIS.grd_4c_Produtos.Column5.ReadOnly = .T.
        ENDIF

        *-- Column2 come?a ReadOnly (modo normal; auditor inverte)
        THIS.grd_4c_Produtos.Column2.ReadOnly = .T.

        BINDEVENT(THIS.grd_4c_Produtos, "AfterRowColChange", THIS, "GrdAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Produtos.Column1.Header1, "Click", THIS, "GrdHeaderClick")

        *----------------------------------------------------------------------
        * Shape e Image para foto do produto
        *----------------------------------------------------------------------
        THIS.AddObject("shp_4c_Foto", "Shape")
        WITH THIS.shp_4c_Foto
            .Top          = 414
            .Left         = 763
            .Width        = 205
            .Height       = 140
            .BackStyle    = 0
            .BorderStyle  = 1
            .FillStyle    = 1
            .SpecialEffect = 1
            .BorderColor  = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("img_4c_Foto", "Image")
        WITH THIS.img_4c_Foto
            .Top     = 415
            .Left    = 764
            .Width   = 203
            .Height  = 138
            .Stretch = 1
            .Visible = .F.
        ENDWITH

    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Form OPERACIONAL nao usa Page2; metodo requerido
    * pela hierarquia FormBase mas sem conteudo aplicavel aqui.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *==========================================================================
    * AlternarPagina - Reset da area operacional (limpa grid, filtros e foco)
    *   par_nPagina = 1 -> reset completo (equivalente a nova consulta)
    *   par_nPagina = 2 -> apenas limpar grid e desabilitar Atualizar
    * OPERACIONAL nao possui Page1/Page2; AlternarPagina age como reset de
    * estado, retornando o form ao ponto inicial de trabalho.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nModo
        loc_nModo = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)

        *-- Zera o cursor do grid de produtos
        IF USED("cursor_4c_Produtos")
            SELECT cursor_4c_Produtos
            IF RECCOUNT() > 0
                ZAP
            ENDIF
        ENDIF

        *-- Desabilita o botao Atualizar (fica ativo apenas apos Processar)
        IF VARTYPE(THIS.cmg_4c_Acao) = "O"
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
            THIS.cmg_4c_Acao.Buttons(2).Refresh
        ENDIF

        *-- Reseta selecao global do header (checkbox da coluna 1)
        THIS.this_lAllSelected = .T.
        THIS.this_lInCol5      = .F.
        THIS.this_nAntValAtu   = 0

        IF loc_nModo = 1
            *-- Reset COMPLETO: limpa TODOS os campos de filtro/parametros
            IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
                THIS.txt_4c_CdGrupo.Value  = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
                THIS.txt_4c_AteGrupo.Value = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Col)      = "O"
                THIS.txt_4c_Col.Value      = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Conta)    = "O"
                THIS.txt_4c_Conta.Value    = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_DConta)   = "O"
                THIS.txt_4c_DConta.Value   = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Variacao) = "O"
                THIS.txt_4c_Variacao.Value = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_Moeda)    = "O"
                THIS.txt_4c_Moeda.Value    = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_MarkUp1)  = "O"
                THIS.txt_4c_MarkUp1.Value  = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_MarkUp2)  = "O"
                THIS.txt_4c_MarkUp2.Value  = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_Fator)    = "O"
                THIS.txt_4c_Fator.Value    = 0
            ENDIF
            IF VARTYPE(THIS.txt_4c_MoeCusto) = "O"
                THIS.txt_4c_MoeCusto.Value = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Moecs)    = "O"
                THIS.txt_4c_Moecs.Value    = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_MoeCusFs) = "O"
                THIS.txt_4c_MoeCusFs.Value = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Moedas)   = "O"
                THIS.txt_4c_Moedas.Value   = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_CFtios)   = "O"
                THIS.txt_4c_CFtios.Value   = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_MoeVs)    = "O"
                THIS.txt_4c_MoeVs.Value    = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Promo)    = "O"
                THIS.txt_4c_Promo.Value    = ""
            ENDIF
            IF VARTYPE(THIS.chk_4c_Ignorar)  = "O"
                THIS.chk_4c_Ignorar.Value  = 0
            ENDIF
            IF VARTYPE(THIS.chk_4c_IncCusts) = "O"
                THIS.chk_4c_IncCusts.Value = 0
            ENDIF
            IF VARTYPE(THIS.chk_4c_Limpar)   = "O"
                THIS.chk_4c_Limpar.Value   = 0
            ENDIF
            IF VARTYPE(THIS.chk_4c_Auditado) = "O"
                THIS.chk_4c_Auditado.Value = 0
            ENDIF

            *-- Volta tipo de reajuste para 1 (Variacao) e atualiza visibilidade
            IF VARTYPE(THIS.opt_4c_Tipo) = "O"
                THIS.opt_4c_Tipo.Value = 1
                THIS.AtualizarVisibilidade(1)
            ENDIF

            *-- Esconde foto de produto (controlada por GrdAfterRowColChange)
            IF PEMSTATUS(THIS, "img_4c_Foto", 5) AND VARTYPE(THIS.img_4c_Foto) = "O"
                THIS.img_4c_Foto.Visible = .F.
                THIS.img_4c_Foto.Picture = ""
            ENDIF

            *-- Foco no primeiro campo de filtro (Grupo de Produto)
            IF VARTYPE(THIS.txt_4c_CdGrupo) = "O"
                THIS.txt_4c_CdGrupo.SetFocus
            ENDIF
        ENDIF

        *-- Refresca a grid e o form
        IF VARTYPE(THIS.grd_4c_Produtos) = "O"
            THIS.grd_4c_Produtos.Refresh
        ENDIF
        THIS.Refresh
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo, respeita a regra de recursao antes do LOOP
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto
        IF VARTYPE(par_oContainer) # "O"
            RETURN
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
                *-- img_4c_Foto comeca oculta; controlada por GrdAfterRowColChange
                *-- cnt_4c_Sombra permanece Visible=.F.; visibilidade controlada externamente
                IF INLIST(UPPER(loc_oObjeto.Name), "IMG_4C_FOTO", "CNT_4C_SOMBRA")
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AtualizarVisibilidade - Mostra/oculta controles pelo tipo de reajuste
    *==========================================================================
    PROCEDURE AtualizarVisibilidade(par_nTipo)
        LOCAL loc_lTipo1, loc_lTipo2

        loc_lTipo1 = (par_nTipo = 1)
        loc_lTipo2 = (par_nTipo = 2)

        *-- Tipo 1: Variacao
        THIS.lbl_4c_Variacao.Visible = loc_lTipo1
        THIS.txt_4c_Variacao.Visible = loc_lTipo1
        THIS.lbl_4c_Pct.Visible      = loc_lTipo1
        THIS.chk_4c_IncCusts.Visible = loc_lTipo1

        *-- Tipo 2: MarkUp
        THIS.lbl_4c_Moeda.Visible    = loc_lTipo2
        THIS.txt_4c_Moeda.Visible    = loc_lTipo2
        THIS.lbl_4c_MarkUp.Visible   = loc_lTipo2
        THIS.txt_4c_MarkUp1.Visible  = loc_lTipo2
        THIS.lbl_4c_Para.Visible     = loc_lTipo2
        THIS.txt_4c_MarkUp2.Visible  = loc_lTipo2
        THIS.lbl_4c_Fator.Visible    = loc_lTipo2
        THIS.txt_4c_Fator.Visible    = loc_lTipo2
        THIS.txt_4c_MoeCusto.Visible = loc_lTipo2
        THIS.lbl_4c_Moecs.Visible    = loc_lTipo2
        THIS.txt_4c_Moecs.Visible    = loc_lTipo2
        THIS.lbl_4c_MoeCusFs.Visible = loc_lTipo2
        THIS.txt_4c_MoeCusFs.Visible = loc_lTipo2
        THIS.lbl_4c_Moedas.Visible   = loc_lTipo2
        THIS.txt_4c_Moedas.Visible   = loc_lTipo2
        THIS.lbl_4c_CFtios.Visible   = loc_lTipo2
        THIS.txt_4c_CFtios.Visible   = loc_lTipo2
        THIS.lbl_4c_MoeVs.Visible    = loc_lTipo2
        THIS.txt_4c_MoeVs.Visible    = loc_lTipo2

        THIS.Refresh
    ENDPROC

    *==========================================================================
    * OptTipoInteractiveChange - Atualiza visibilidade ao mudar tipo
    *==========================================================================
    PROCEDURE OptTipoInteractiveChange()
        THIS.AtualizarVisibilidade(THIS.opt_4c_Tipo.Value)
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Coleta campos, chama ProcessarReajuste()
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) # "O"
            RETURN
        ENDIF

        *-- Transfere campos do form para o BO
        loc_oBO.this_nTipo      = THIS.opt_4c_Tipo.Value
        loc_oBO.this_cCdGrupo   = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
        loc_oBO.this_cAteGrupo  = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
        loc_oBO.this_cCol       = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
        loc_oBO.this_cConta     = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
        loc_oBO.this_cDConta    = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
        loc_oBO.this_nIgnorar   = THIS.chk_4c_Ignorar.Value
        loc_oBO.this_nVariacao  = NVL(THIS.txt_4c_Variacao.Value, 0)
        loc_oBO.this_nIncCusts  = THIS.chk_4c_IncCusts.Value
        loc_oBO.this_cMoeda     = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
        loc_oBO.this_nMarkUp1   = NVL(THIS.txt_4c_MarkUp1.Value,  0)
        loc_oBO.this_nMarkUp2   = NVL(THIS.txt_4c_MarkUp2.Value,  0)
        loc_oBO.this_nFator     = NVL(THIS.txt_4c_Fator.Value,    0)
        loc_oBO.this_cMoeCusto  = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
        loc_oBO.this_cMoecs     = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
        loc_oBO.this_cMoeCusFs  = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
        loc_oBO.this_cMoedas    = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
        loc_oBO.this_cCFtios    = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
        loc_oBO.this_cMoeVs     = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
        loc_oBO.this_cPromo     = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
        loc_oBO.this_nLimpar    = THIS.chk_4c_Limpar.Value
        loc_oBO.this_nAuditado  = THIS.chk_4c_Auditado.Value

        IF loc_oBO.ProcessarReajuste()
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
            THIS.grd_4c_Produtos.Column1.SetFocus
            THIS.grd_4c_Produtos.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAtualizarClick - Chama AtualizarPrecos(), desabilita Atualizar
    *==========================================================================
    PROCEDURE BtnAtualizarClick()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) # "O"
            RETURN
        ENDIF
        IF loc_oBO.AtualizarPrecos()
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
            THIS.cmg_4c_Acao.Buttons(2).Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o form
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release
    ENDPROC

    *==========================================================================
    * TxtVariacaoLostFocus - Move foco para Processar ao sair do campo
    *==========================================================================
    PROCEDURE TxtVariacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.cmg_4c_Acao.Buttons(1).SetFocus
    ENDPROC

    *==========================================================================
    * GrdHeaderClick - Alterna selecao de todos os produtos (lMarca)
    *==========================================================================
    PROCEDURE GrdHeaderClick()
        IF !USED("cursor_4c_Produtos")
            RETURN
        ENDIF
        IF THIS.this_lAllSelected
            UPDATE cursor_4c_Produtos SET lMarca = 0
            THIS.this_lAllSelected = .F.
        ELSE
            UPDATE cursor_4c_Produtos SET lMarca = 1
            THIS.this_lAllSelected = .T.
        ENDIF
        THIS.grd_4c_Produtos.Refresh
        THIS.Refresh
    ENDPROC

    *==========================================================================
    * GrdAfterRowColChange - Manual tracking + auditor lookup + foto produto
    * par_nColIndex = coluna que acabou de ser ENTADA (nova coluna ativa)
    *==========================================================================
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
        LOCAL loc_lcArqFig, loc_nResult, loc_lcFoto, loc_cCPros

        IF !USED("cursor_4c_Produtos")
            RETURN
        ENDIF
        SELECT cursor_4c_Produtos

        *-- Rastreia edicao manual de ValAtu (Column5): detecta saida da coluna
        IF par_nColIndex != 5 AND THIS.this_lInCol5
            IF !EOF("cursor_4c_Produtos") AND ;
               NVL(cursor_4c_Produtos.ValAtu, 0) != THIS.this_nAntValAtu
                REPLACE Manual WITH 1 IN cursor_4c_Produtos
                *-- Em modo LibValAtu: adiciona linha vazia no fundo se ultimo item tem produto
                *-- Equivale ao Column5.Text1.Valid do legado (Insert From MemVar + DNARROW)
                IF THIS.this_oBusinessObject.this_lLibValAtu
                    SET ORDER TO
                    GO BOTTOM
                    IF !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
                        INSERT INTO cursor_4c_Produtos ;
                            (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
                            VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, SPACE(3), 0, 0)
                    ENDIF
                    THIS.grd_4c_Produtos.Refresh
                ENDIF
            ENDIF
            THIS.this_lInCol5 = .F.
        ENDIF
        IF par_nColIndex = 5 AND !EOF("cursor_4c_Produtos")
            THIS.this_nAntValAtu = NVL(cursor_4c_Produtos.ValAtu, 0)
            THIS.this_lInCol5    = .T.
        ENDIF

        *-- Modo auditado: ao sair de Column2 com codigo preenchido, carrega produto
        IF par_nColIndex != 2 AND THIS.chk_4c_Auditado.Value = 1 ;
            AND !EOF("cursor_4c_Produtos")
            loc_cCPros = ALLTRIM(NVL(cursor_4c_Produtos.CPros, ""))
            IF !EMPTY(loc_cCPros)
                THIS.CarregarProdutoAuditado(loc_cCPros)
            ENDIF
        ENDIF

        *-- Carrega foto do produto atual
        IF !EOF("cursor_4c_Produtos") AND !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
            loc_lcArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
            IF USED("cursor_4c_FigTmp")
                USE IN cursor_4c_FigTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(ALLTRIM(cursor_4c_Produtos.CPros)), ;
                "cursor_4c_FigTmp")
            THIS.img_4c_Foto.Visible = .F.
            THIS.img_4c_Foto.Picture = ""
            IF loc_nResult > 0 AND !EOF("cursor_4c_FigTmp")
                SELECT cursor_4c_FigTmp
                IF !ISNULL(cursor_4c_FigTmp.FigJpgs) AND ;
                   !EMPTY(ALLTRIM(NVL(cursor_4c_FigTmp.FigJpgs, "")))
                    CLEAR RESOURCES
                    loc_lcFoto = STRCONV( ;
                        STRTRAN(STRTRAN(STRTRAN( ;
                            cursor_4c_FigTmp.FigJpgs, ;
                            "data:image/png;base64,",  ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,",  ""), 14)
                    STRTOFILE(loc_lcFoto, loc_lcArqFig)
                    THIS.img_4c_Foto.Picture = loc_lcArqFig
                    THIS.img_4c_Foto.Visible = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_FigTmp")
                USE IN cursor_4c_FigTmp
            ENDIF
        ELSE
            THIS.img_4c_Foto.Visible = .F.
            THIS.img_4c_Foto.Picture = ""
        ENDIF

        SELECT cursor_4c_Produtos
    ENDPROC

    *==========================================================================
    * CarregarProdutoAuditado - Modo auditado: busca produto e calcula preco
    * Chamado por GrdAfterRowColChange ao sair de Column2 com um codigo
    *==========================================================================
    PROCEDURE CarregarProdutoAuditado(par_cCPros)
        LOCAL loc_nResult, loc_nTipo, loc_nVariacao, loc_nMarkUp2
        LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPVen, loc_nVlVen

        IF EMPTY(ALLTRIM(par_cCPros))
            RETURN
        ENDIF

        *-- Busca produto em SigCdPro e adiciona a cursor_4c_TmpPro
        IF USED("cursor_4c_ProdAud")
            USE IN cursor_4c_ProdAud
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCPros)), ;
            "cursor_4c_ProdAud")
        IF loc_nResult < 1 OR EOF("cursor_4c_ProdAud")
            IF USED("cursor_4c_ProdAud")
                USE IN cursor_4c_ProdAud
            ENDIF
            THIS.AbrirBuscaProdutoGrd()
            RETURN
        ENDIF

        *-- Insere no cursor_4c_TmpPro se ainda nao existe
        IF USED("cursor_4c_TmpPro")
            IF !SEEK(ALLTRIM(par_cCPros), "cursor_4c_TmpPro", "CPros")
                SELECT cursor_4c_ProdAud
                GO TOP
                LOCAL loc_oErroIns
                TRY
                    SELECT cursor_4c_TmpPro
                    APPEND BLANK
                    *-- Copia campos essenciais manualmente (SCATTER/GATHER pode falhar entre cursores)
                    REPLACE CPros    WITH ALLTRIM(cursor_4c_ProdAud.CPros)
                    REPLACE DPros    WITH ALLTRIM(NVL(cursor_4c_ProdAud.DPros,    ""))
                    REPLACE PVens    WITH NVL(cursor_4c_ProdAud.PVens,    0)
                    REPLACE PVIdeals WITH NVL(cursor_4c_ProdAud.PVIdeals, 0)
                    REPLACE PCuss    WITH NVL(cursor_4c_ProdAud.PCuss,    0)
                    REPLACE CustoFs  WITH NVL(cursor_4c_ProdAud.CustoFs,  0)
                    REPLACE fCustos  WITH NVL(cursor_4c_ProdAud.fCustos,  0)
                    REPLACE Margems  WITH NVL(cursor_4c_ProdAud.Margems,  0)
                    REPLACE MoeVs    WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeVs,    ""))
                    REPLACE MoeCs    WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeCs,    ""))
                    REPLACE MoePcs   WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoePcs,   ""))
                    REPLACE MoeCusFs WITH ALLTRIM(NVL(cursor_4c_ProdAud.MoeCusFs, ""))
                    REPLACE Moedas   WITH ALLTRIM(NVL(cursor_4c_ProdAud.Moedas,   ""))
                    REPLACE MFtios   WITH ALLTRIM(NVL(cursor_4c_ProdAud.MFtios,   ""))
                    REPLACE PFtios   WITH NVL(cursor_4c_ProdAud.PFtios,   0)
                    REPLACE PesoMs   WITH NVL(cursor_4c_ProdAud.PesoMs,   0)
                    REPLACE Encargos WITH NVL(cursor_4c_ProdAud.Encargos, 0)
                    REPLACE CGrus    WITH ALLTRIM(NVL(cursor_4c_ProdAud.CGrus,    ""))
                CATCH TO loc_oErroIns
                    MsgErro("Erro ao inserir produto no buffer: " + loc_oErroIns.Message, "Erro")
                ENDTRY
            ENDIF
        ENDIF

        *-- Calcula novo preco conforme tipo
        IF USED("cursor_4c_TmpPro") AND SEEK(ALLTRIM(par_cCPros), "cursor_4c_TmpPro", "CPros")
            SELECT cursor_4c_TmpPro
            GO TOP
            loc_nTipo     = THIS.opt_4c_Tipo.Value
            loc_nVariacao = NVL(THIS.txt_4c_Variacao.Value, 0)
            loc_nMarkUp2  = NVL(THIS.txt_4c_MarkUp2.Value,  0)

            DO CASE
            CASE loc_nTipo = 1
                loc_nValAtu = NVL(cursor_4c_TmpPro.PVens, 0) + ;
                              (NVL(cursor_4c_TmpPro.PVens, 0) * loc_nVariacao / 100)
            CASE loc_nTipo = 2
                loc_nValAtu = THIS.this_oBusinessObject.CalcPreco(loc_nMarkUp2)
            CASE loc_nTipo = 3
                loc_nCotId = fBuscarCotacao( ;
                    ALLTRIM(NVL(cursor_4c_TmpPro.Moedas, "")), DATE(), gnConnHandle)
                loc_nCotVd = fBuscarCotacao( ;
                    ALLTRIM(NVL(cursor_4c_TmpPro.MoeVs, "")),  DATE(), gnConnHandle)
                loc_nPVen  = NVL(cursor_4c_TmpPro.PVIdeals, 0) * ;
                             IIF(loc_nCotVd <> 0, loc_nCotId / loc_nCotVd, 0)
                loc_nVlVen = IIF(NVL(cursor_4c_TmpPro.Encargos, 0) <> 0, ;
                                 loc_nPVen / cursor_4c_TmpPro.Encargos, loc_nPVen)
                loc_nValAtu = loc_nVlVen
            OTHERWISE
                loc_nValAtu = NVL(cursor_4c_TmpPro.PVens, 0)
            ENDCASE

            *-- Atualiza registro corrente em cursor_4c_Produtos
            SELECT cursor_4c_Produtos
            REPLACE CPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.CPros, ""))
            REPLACE DPros   WITH ALLTRIM(NVL(cursor_4c_TmpPro.DPros, ""))
            REPLACE ValAnt  WITH NVL(cursor_4c_TmpPro.PVens,  0)
            REPLACE ValAtu  WITH loc_nValAtu
            REPLACE lMarca  WITH 1
            REPLACE Manual  WITH 0
            REPLACE fCustos WITH NVL(cursor_4c_TmpPro.fCustos, 0)
            REPLACE CustoFs WITH NVL(cursor_4c_TmpPro.CustoFs, 0)
            REPLACE MoePcs  WITH ALLTRIM(NVL(cursor_4c_TmpPro.MoePcs, ""))

            THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.

            *-- Adiciona linha vazia abaixo se nao houver
            IF !THIS.this_oBusinessObject.this_lLibValAtu
                SELECT cursor_4c_Produtos
                SET ORDER TO
                GO BOTTOM
                IF !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
                    INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAtu, ValAnt) ;
                        VALUES (0, SPACE(14), SPACE(40), 0, 0)
                ENDIF
                SELECT cursor_4c_Produtos
                THIS.grd_4c_Produtos.Refresh
            ENDIF
        ENDIF

        IF USED("cursor_4c_ProdAud")
            USE IN cursor_4c_ProdAud
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkAuditadoClick - Alterna modo de entrada manual de produtos
    *==========================================================================
    PROCEDURE ChkAuditadoClick()
        IF THIS.chk_4c_Auditado.Value = 1
            *-- Modo auditado: limpa grid, Column2 editavel, Column1 readonly
            IF USED("cursor_4c_Produtos")
                LOCAL loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v
                loc_lMarca_v = 0
                loc_cCPros_v = SPACE(14)
                loc_cDPros_v = SPACE(40)
                loc_nValAtu_v = 0
                loc_nValAnt_v = 0
                INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAtu, ValAnt) ;
                    VALUES (loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v)
                SELECT cursor_4c_Produtos
                SET ORDER TO
                GO TOP
            ENDIF
            THIS.txt_4c_CdGrupo.Enabled  = .F.
            THIS.txt_4c_AteGrupo.Enabled = .F.
            THIS.txt_4c_Col.Enabled      = .F.
            THIS.txt_4c_Moeda.Enabled    = .F.
            THIS.txt_4c_MarkUp1.Enabled  = .F.
            THIS.cmg_4c_Acao.Buttons(1).Enabled = .F.
            THIS.grd_4c_Produtos.Column1.ReadOnly = .T.
            THIS.grd_4c_Produtos.Column2.ReadOnly = .F.
            THIS.grd_4c_Produtos.Column2.SetFocus
            THIS.grd_4c_Produtos.Refresh
        ELSE
            *-- Modo normal: limpa grid, Column2 readonly, Column1 editavel
            IF USED("cursor_4c_Produtos")
                DELETE FROM cursor_4c_Produtos
            ENDIF
            THIS.txt_4c_CdGrupo.Enabled  = .T.
            THIS.txt_4c_AteGrupo.Enabled = .T.
            THIS.txt_4c_Col.Enabled      = .T.
            THIS.txt_4c_Moeda.Enabled    = .T.
            THIS.txt_4c_MarkUp1.Enabled  = .T.
            THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
            THIS.grd_4c_Produtos.Column1.ReadOnly = .F.
            THIS.grd_4c_Produtos.Column2.ReadOnly = .T.
            SELECT cursor_4c_Produtos
            SET ORDER TO CPros
            GO TOP
            THIS.grd_4c_Produtos.Refresh
            THIS.txt_4c_CdGrupo.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookup helpers
    *==========================================================================

    *-- Helper generico para SigCdMoe
    PROTECTED PROCEDURE BuscarMoedaHelper(par_oTxt)
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, "Moedas")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CMoes",  "XXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DMoes",  "",       "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * Lookups - SigCdGrp (CdGrupo)
    *==========================================================================
    PROCEDURE AbrirBuscaCdGrupo()
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cValor, ;
            "Grupos de Produto")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
            IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
                THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
            ENDIF
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
                    THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
                ENDIF
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaLookupCdGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCdGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrupo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarCdGrupo()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValGrp")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
            THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
            IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
                THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
            ENDIF
        ELSE
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaCdGrupo()
        ENDIF
        IF USED("cursor_4c_ValGrp")
            USE IN cursor_4c_ValGrp
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdGrp (AteGrupo)
    *==========================================================================
    PROCEDURE AbrirBuscaAteGrupo()
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cValor, ;
            "Grupos de Produto")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaLookupAteGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaAteGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarAteGrupo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarAteGrupo()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValGrp")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
            THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
        ELSE
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaAteGrupo()
        ENDIF
        IF USED("cursor_4c_ValGrp")
            USE IN cursor_4c_ValGrp
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdCol
    *==========================================================================
    PROCEDURE AbrirBuscaCol()
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Col.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCol", "cursor_4c_BuscaCol", "Colecoes", loc_cValor, ;
            "Cole" + CHR(231) + CHR(245) + "es")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Colecoes", "XXXXXXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Descs",    "",           "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCol")
                THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaCol")
            USE IN cursor_4c_BuscaCol
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaLookupCol(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCol()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCol()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarCol()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Col.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT Colecoes FROM SigCdCol WHERE Colecoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValCol")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValCol")
            THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_ValCol.Colecoes)
        ELSE
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaCol()
        ENDIF
        IF USED("cursor_4c_ValCol")
            USE IN cursor_4c_ValCol
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (Moeda - Tipo 2)
    *==========================================================================
    PROCEDURE AbrirBuscaMoeda()
        THIS.BuscarMoedaHelper(THIS.txt_4c_Moeda)
    ENDPROC

    PROCEDURE TeclaLookupMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeda()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeda()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoeda()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moeda.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaMoeda()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (Moecs)
    *==========================================================================
    PROCEDURE AbrirBuscaMoecs()
        THIS.BuscarMoedaHelper(THIS.txt_4c_Moecs)
    ENDPROC

    PROCEDURE TeclaLookupMoecs(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoecs()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoecs()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoecs()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moecs.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_Moecs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaMoecs()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (MoeCusFs)
    *==========================================================================
    PROCEDURE AbrirBuscaMoeCusFs()
        THIS.BuscarMoedaHelper(THIS.txt_4c_MoeCusFs)
    ENDPROC

    PROCEDURE TeclaLookupMoeCusFs(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeCusFs()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeCusFs()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoeCusFs()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_MoeCusFs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaMoeCusFs()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (Moedas = Moeda Preco Ideal)
    *==========================================================================
    PROCEDURE AbrirBuscaMoedas()
        THIS.BuscarMoedaHelper(THIS.txt_4c_Moedas)
    ENDPROC

    PROCEDURE TeclaLookupMoedas(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoedas()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedas()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoedas()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moedas.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_Moedas.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaMoedas()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (MoeCusto = Moeda do Custo)
    *==========================================================================
    PROCEDURE AbrirBuscaMoeCusto()
        THIS.BuscarMoedaHelper(THIS.txt_4c_MoeCusto)
    ENDPROC

    PROCEDURE TeclaLookupMoeCusto(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeCusto()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeCusto()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoeCusto()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_MoeCusto.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaMoeCusto()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigCdMoe (MoeVs = Moeda Preco Atual)
    *==========================================================================
    PROCEDURE AbrirBuscaMoeVs()
        THIS.BuscarMoedaHelper(THIS.txt_4c_MoeVs)
    ENDPROC

    PROCEDURE TeclaLookupMoeVs(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeVs()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeVs()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoeVs()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValMoe")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
            THIS.txt_4c_MoeVs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
        ELSE
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaMoeVs()
        ENDIF
        IF USED("cursor_4c_ValMoe")
            USE IN cursor_4c_ValMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigPrFti (CFtios = Feitio)
    *==========================================================================
    PROCEDURE AbrirBuscaCFtios()
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrFti", "cursor_4c_BuscaFtio", "Cods", loc_cValor, "Feitio")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Cods",  "XXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Descs", "",       "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
                THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaFtio")
            USE IN cursor_4c_BuscaFtio
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaLookupCFtios(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCFtios()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCFtios()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarCFtios()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_CFtios.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT Cods FROM SigPrFti WHERE Cods = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValFtio")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValFtio")
            THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_ValFtio.Cods)
        ELSE
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaCFtios()
        ENDIF
        IF USED("cursor_4c_ValFtio")
            USE IN cursor_4c_ValFtio
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - Fornecedor via fAcessoContas (Conta / DConta)
    *==========================================================================
    PROCEDURE AbrirBuscaConta()
        fAcessoContas(gc_4c_UsuarioLogado, ;
                      THIS.this_oBusinessObject.this_cGrPadFors, ;
                      "C", THIS.txt_4c_Conta.Value, ;
                      THIS.txt_4c_Conta, THIS.txt_4c_DConta)
    ENDPROC

    PROCEDURE TeclaLookupConta(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaConta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarConta()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarConta()
        IF !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Conta.Value, "")))
            IF !fAcessoContas(gc_4c_UsuarioLogado, ;
                              THIS.this_oBusinessObject.this_cGrPadFors, ;
                              "C", THIS.txt_4c_Conta.Value, ;
                              THIS.txt_4c_Conta, THIS.txt_4c_DConta)
                MsgAviso("Acesso Negado !!!", "")
                THIS.txt_4c_Conta.Value  = ""
                THIS.txt_4c_DConta.Value = ""
            ENDIF
        ELSE
            THIS.txt_4c_DConta.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaDConta()
        fAcessoContas(gc_4c_UsuarioLogado, ;
                      THIS.this_oBusinessObject.this_cGrPadFors, ;
                      "D", THIS.txt_4c_DConta.Value, ;
                      THIS.txt_4c_Conta, THIS.txt_4c_DConta)
    ENDPROC

    PROCEDURE TeclaLookupDConta(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaDConta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDConta()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarDConta()
        IF !EMPTY(ALLTRIM(NVL(THIS.txt_4c_DConta.Value, "")))
            IF !fAcessoContas(gc_4c_UsuarioLogado, ;
                              THIS.this_oBusinessObject.this_cGrPadFors, ;
                              "D", THIS.txt_4c_DConta.Value, ;
                              THIS.txt_4c_Conta, THIS.txt_4c_DConta)
                MsgAviso("Acesso Negado !!!", "")
                THIS.txt_4c_DConta.Value = ""
                THIS.txt_4c_Conta.Value  = ""
            ENDIF
        ELSE
            THIS.txt_4c_Conta.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookups - SigPrPmc (Promo)
    *==========================================================================
    PROCEDURE AbrirBuscaPromo()
        LOCAL loc_cValor, loc_oForm
        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Promo.Value, ""))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrPmc", "cursor_4c_BuscaPmc", "Promos", loc_cValor, ;
            "Promo" + CHR(231) + CHR(227) + "o")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPmc.Promos)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaPmc")
                THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPmc.Promos)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaPmc")
            USE IN cursor_4c_BuscaPmc
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE TeclaLookupPromo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaPromo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarPromo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarPromo()
        LOCAL loc_cVal, loc_nR
        loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Promo.Value, "")))
        IF EMPTY(loc_cVal)
            RETURN
        ENDIF
        loc_nR = SQLEXEC(gnConnHandle, ;
            "SELECT Promos FROM SigPrPmc WHERE Promos = " + EscaparSQL(loc_cVal), ;
            "cursor_4c_ValPmc")
        IF loc_nR > 0 AND !EOF("cursor_4c_ValPmc")
            THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_ValPmc.Promos)
        ELSE
            *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
            THIS.AbrirBuscaPromo()
        ENDIF
        IF USED("cursor_4c_ValPmc")
            USE IN cursor_4c_ValPmc
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia novo ciclo: limpa grid e parametros (equivale a
    *   "nova busca" no contexto operacional de reajuste de precificacao)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
            IF VARTYPE(THIS.txt_4c_CdGrupo) = "O"
                THIS.txt_4c_CdGrupo.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Reprocessa com os parametros atuais sem limpar filtros
    *   (equivale a "recalcular" preservando selecao atual do grid)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) # "O"
                RETURN
            ENDIF
            *-- Transfere campos do form para o BO (mesmo fluxo de Processar)
            loc_oBO.this_nTipo      = THIS.opt_4c_Tipo.Value
            loc_oBO.this_cCdGrupo   = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
            loc_oBO.this_cAteGrupo  = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
            loc_oBO.this_cCol       = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
            loc_oBO.this_cConta     = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
            loc_oBO.this_cDConta    = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
            loc_oBO.this_nIgnorar   = THIS.chk_4c_Ignorar.Value
            loc_oBO.this_nVariacao  = NVL(THIS.txt_4c_Variacao.Value, 0)
            loc_oBO.this_nIncCusts  = THIS.chk_4c_IncCusts.Value
            loc_oBO.this_cMoeda     = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
            loc_oBO.this_nMarkUp1   = NVL(THIS.txt_4c_MarkUp1.Value,  0)
            loc_oBO.this_nMarkUp2   = NVL(THIS.txt_4c_MarkUp2.Value,  0)
            loc_oBO.this_nFator     = NVL(THIS.txt_4c_Fator.Value,    0)
            loc_oBO.this_cMoeCusto  = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
            loc_oBO.this_cMoecs     = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
            loc_oBO.this_cMoeCusFs  = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
            loc_oBO.this_cMoedas    = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
            loc_oBO.this_cCFtios    = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
            loc_oBO.this_cMoeVs     = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
            loc_oBO.this_cPromo     = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
            loc_oBO.this_nLimpar    = THIS.chk_4c_Limpar.Value
            loc_oBO.this_nAuditado  = THIS.chk_4c_Auditado.Value
            IF loc_oBO.ProcessarReajuste()
                THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
                THIS.grd_4c_Produtos.Column1.SetFocus
                THIS.grd_4c_Produtos.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe o estado atual do grid (precos antes x depois)
    *   Atualiza o grid a partir do cursor sem reprocessar
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
                SELECT cursor_4c_Produtos
                GO TOP
                THIS.grd_4c_Produtos.Refresh
                THIS.Refresh
            ELSE
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " produtos processados " + ;
                         "para visualizar. Execute o Processar primeiro.", "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Limpa apenas o grid de produtos sem resetar os filtros
    *   Permite reprocessar com os mesmos parametros mas lista limpa
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_oErro
        TRY
            IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
                RETURN
            ENDIF
            loc_lConfirma = MsgConfirma("Limpar a lista de produtos processados?", ;
                                        "Confirmar")
            IF loc_lConfirma
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaProdutoGrd - Lookup de produto para modo auditado (Column2)
    * Equivalente ao fwbuscaext do Column2.Text1.Valid no legado.
    *==========================================================================
    PROCEDURE AbrirBuscaProdutoGrd()
        LOCAL loc_cValAtual, loc_oForm, loc_cSelecionado

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            RETURN
        ENDIF
        SELECT cursor_4c_Produtos
        loc_cValAtual = ALLTRIM(NVL(cursor_4c_Produtos.CPros, ""))

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValAtual, ;
            "Produtos")
        IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
            RETURN
        ENDIF

        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF

        loc_cSelecionado = ""
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaPro")
            loc_cSelecionado = ALLTRIM(cursor_4c_BuscaPro.CPros)
        ENDIF
        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF

        IF !EMPTY(loc_cSelecionado)
            SELECT cursor_4c_Produtos
            REPLACE CPros WITH loc_cSelecionado
            THIS.grd_4c_Produtos.Refresh
            THIS.CarregarProdutoAuditado(loc_cSelecionado)
        ELSE
            SELECT cursor_4c_Produtos
            IF !EOF("cursor_4c_Produtos")
                REPLACE CPros WITH SPACE(14)
            ENDIF
            THIS.grd_4c_Produtos.Refresh
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere todos os campos do form para propriedades do BO
    * Usado por BtnProcessarClick e BtnAlterarClick para evitar duplicacao
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) # "O"
            RETURN
        ENDIF
        loc_oBO.this_nTipo     = THIS.opt_4c_Tipo.Value
        loc_oBO.this_cCdGrupo  = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
        loc_oBO.this_cAteGrupo = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
        loc_oBO.this_cCol      = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
        loc_oBO.this_cConta    = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
        loc_oBO.this_cDConta   = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
        loc_oBO.this_nIgnorar  = THIS.chk_4c_Ignorar.Value
        loc_oBO.this_nVariacao = NVL(THIS.txt_4c_Variacao.Value, 0)
        loc_oBO.this_nIncCusts = THIS.chk_4c_IncCusts.Value
        loc_oBO.this_cMoeda    = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
        loc_oBO.this_nMarkUp1  = NVL(THIS.txt_4c_MarkUp1.Value,  0)
        loc_oBO.this_nMarkUp2  = NVL(THIS.txt_4c_MarkUp2.Value,  0)
        loc_oBO.this_nFator    = NVL(THIS.txt_4c_Fator.Value,    0)
        loc_oBO.this_cMoeCusto = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
        loc_oBO.this_cMoecs    = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
        loc_oBO.this_cMoeCusFs = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
        loc_oBO.this_cMoedas   = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
        loc_oBO.this_cCFtios   = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
        loc_oBO.this_cMoeVs    = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
        loc_oBO.this_cPromo    = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
        loc_oBO.this_nLimpar   = THIS.chk_4c_Limpar.Value
        loc_oBO.this_nAuditado = THIS.chk_4c_Auditado.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Carrega propriedades do BO de volta para os campos do form
    * Util apos recarregar estado do BO ou em modo auditado
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) # "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.opt_4c_Tipo)     = "O"
            THIS.opt_4c_Tipo.Value     = loc_oBO.this_nTipo
            THIS.AtualizarVisibilidade(loc_oBO.this_nTipo)
        ENDIF
        IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
            THIS.txt_4c_CdGrupo.Value  = ALLTRIM(loc_oBO.this_cCdGrupo)
        ENDIF
        IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
            THIS.txt_4c_AteGrupo.Value = ALLTRIM(loc_oBO.this_cAteGrupo)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Col)      = "O"
            THIS.txt_4c_Col.Value      = ALLTRIM(loc_oBO.this_cCol)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Conta)    = "O"
            THIS.txt_4c_Conta.Value    = ALLTRIM(loc_oBO.this_cConta)
        ENDIF
        IF VARTYPE(THIS.txt_4c_DConta)   = "O"
            THIS.txt_4c_DConta.Value   = ALLTRIM(loc_oBO.this_cDConta)
        ENDIF
        IF VARTYPE(THIS.chk_4c_Ignorar)  = "O"
            THIS.chk_4c_Ignorar.Value  = loc_oBO.this_nIgnorar
        ENDIF
        IF VARTYPE(THIS.txt_4c_Variacao) = "O"
            THIS.txt_4c_Variacao.Value = loc_oBO.this_nVariacao
        ENDIF
        IF VARTYPE(THIS.chk_4c_IncCusts) = "O"
            THIS.chk_4c_IncCusts.Value = loc_oBO.this_nIncCusts
        ENDIF
        IF VARTYPE(THIS.txt_4c_Moeda)    = "O"
            THIS.txt_4c_Moeda.Value    = ALLTRIM(loc_oBO.this_cMoeda)
        ENDIF
        IF VARTYPE(THIS.txt_4c_MarkUp1)  = "O"
            THIS.txt_4c_MarkUp1.Value  = loc_oBO.this_nMarkUp1
        ENDIF
        IF VARTYPE(THIS.txt_4c_MarkUp2)  = "O"
            THIS.txt_4c_MarkUp2.Value  = loc_oBO.this_nMarkUp2
        ENDIF
        IF VARTYPE(THIS.txt_4c_Fator)    = "O"
            THIS.txt_4c_Fator.Value    = loc_oBO.this_nFator
        ENDIF
        IF VARTYPE(THIS.txt_4c_MoeCusto) = "O"
            THIS.txt_4c_MoeCusto.Value = ALLTRIM(loc_oBO.this_cMoeCusto)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Moecs)    = "O"
            THIS.txt_4c_Moecs.Value    = ALLTRIM(loc_oBO.this_cMoecs)
        ENDIF
        IF VARTYPE(THIS.txt_4c_MoeCusFs) = "O"
            THIS.txt_4c_MoeCusFs.Value = ALLTRIM(loc_oBO.this_cMoeCusFs)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Moedas)   = "O"
            THIS.txt_4c_Moedas.Value   = ALLTRIM(loc_oBO.this_cMoedas)
        ENDIF
        IF VARTYPE(THIS.txt_4c_CFtios)   = "O"
            THIS.txt_4c_CFtios.Value   = ALLTRIM(loc_oBO.this_cCFtios)
        ENDIF
        IF VARTYPE(THIS.txt_4c_MoeVs)    = "O"
            THIS.txt_4c_MoeVs.Value    = ALLTRIM(loc_oBO.this_cMoeVs)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Promo)    = "O"
            THIS.txt_4c_Promo.Value    = ALLTRIM(loc_oBO.this_cPromo)
        ENDIF
        IF VARTYPE(THIS.chk_4c_Limpar)   = "O"
            THIS.chk_4c_Limpar.Value   = loc_oBO.this_nLimpar
        ENDIF
        IF VARTYPE(THIS.chk_4c_Auditado) = "O"
            THIS.chk_4c_Auditado.Value = loc_oBO.this_nAuditado
        ENDIF
        THIS.Refresh
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de entrada e o grid de produtos
    * Equivalente a resetar o form para o estado inicial (nova consulta)
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita todos os campos de entrada
    * par_lHabilitar = .T. -> habilitar | .F. -> desabilitar
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
            THIS.txt_4c_CdGrupo.Enabled  = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
            THIS.txt_4c_AteGrupo.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Col)      = "O"
            THIS.txt_4c_Col.Enabled      = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Conta)    = "O"
            THIS.txt_4c_Conta.Enabled    = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_DConta)   = "O"
            THIS.txt_4c_DConta.Enabled   = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Variacao) = "O"
            THIS.txt_4c_Variacao.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Moeda)    = "O"
            THIS.txt_4c_Moeda.Enabled    = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_MarkUp1)  = "O"
            THIS.txt_4c_MarkUp1.Enabled  = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_MarkUp2)  = "O"
            THIS.txt_4c_MarkUp2.Enabled  = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Fator)    = "O"
            THIS.txt_4c_Fator.Enabled    = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_MoeCusto) = "O"
            THIS.txt_4c_MoeCusto.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Promo)    = "O"
            THIS.txt_4c_Promo.Enabled    = loc_lHab
        ENDIF
        IF VARTYPE(THIS.opt_4c_Tipo)     = "O"
            THIS.opt_4c_Tipo.Enabled     = loc_lHab
        ENDIF
        IF VARTYPE(THIS.cmg_4c_Acao)     = "O"
            THIS.cmg_4c_Acao.Buttons(1).Enabled = loc_lHab
        ENDIF
        THIS.Refresh
    ENDPROC

    *==========================================================================
    * CarregarLista - Para este form OPERACIONAL o grid so e populado apos
    * executar ProcessarReajuste() via BtnProcessarClick.
    * Exibe o estado atual do cursor sem reprocessar.
    *==========================================================================
    PROCEDURE CarregarLista()
        IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
            SELECT cursor_4c_Produtos
            GO TOP
            IF VARTYPE(THIS.grd_4c_Produtos) = "O"
                THIS.grd_4c_Produtos.Refresh
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo corrente
    * Para o form OPERACIONAL: habilita Processar, desabilita Atualizar
    * apos reset; habilita Atualizar apos Processar com sucesso.
    * par_cModo = "NORMAL"  -> estado inicial (Processar habilitado)
    *           = "PRONTO"  -> apos Processar (Atualizar habilitado)
    *           = "AUDITADO"-> modo entrada manual (Processar desabilitado)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_cModo
        loc_cModo = UPPER(ALLTRIM(NVL(par_cModo, "NORMAL")))

        IF VARTYPE(THIS.cmg_4c_Acao) # "O"
            RETURN
        ENDIF

        DO CASE
        CASE loc_cModo = "PRONTO"
            THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.

        CASE loc_cModo = "AUDITADO"
            THIS.cmg_4c_Acao.Buttons(1).Enabled = .F.
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.

        OTHERWISE
            THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
        ENDCASE

        THIS.cmg_4c_Acao.Buttons(1).Refresh
        THIS.cmg_4c_Acao.Buttons(2).Refresh
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Alias semantico para BtnProcessarClick
    * Aciona o processamento de selecao e calculo de precos
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias semantico para BtnAtualizarClick
    * Confirma e grava os precos calculados no banco de dados
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnAtualizarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela o processamento atual sem gravar
    * Zera o grid mas mantem os parametros de filtro para reprocessar
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(2)
            IF VARTYPE(THIS.txt_4c_CdGrupo) = "O"
                THIS.txt_4c_CdGrupo.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
        ENDTRY
    ENDPROC

ENDDEFINE
