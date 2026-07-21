*==============================================================================
* Formsigregli.prg - Formulario Operacional de Impressao de Relacoes e Etiquetas de OP/OS
* Data: 2026-06-05
* Legado: SIGREGLI.SCX (form operacional)
* Tipo: OPERACIONAL - sem PageFrame, controles direto no form
*==============================================================================

DEFINE CLASS Formsigregli AS FormBase

    DataSession  = 2
    Height       = 600
    Width        = 600
    AutoCenter   = .T.
    ShowWindow   = 1
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    WindowType   = 1
    BorderStyle  = 2
    ClipControls = .F.
    Themes       = .F.

    this_oBusinessObject = .NULL.
    this_nNop            = 0
    this_oParentForm     = .F.

    *===========================================================================
    PROCEDURE Init(par_nNop, par_oParentForm)
    *===========================================================================
        IF VARTYPE(par_nNop) = "N" AND par_nNop <> 0
            THIS.this_nNop = par_nNop
        ENDIF
        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_oParentForm = par_oParentForm
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *===========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigregliBO")

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.AplicarParametrosIniciais()

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oBusinessObject.CarregarParametrosIniciais( ;
                    THIS.this_nNop, ;
                    THIS.obj_4c_TpOrdem.Value, ;
                    THIS.this_oParentForm)
            ENDIF

            THIS.TornarControlesVisiveis(THIS)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *===========================================================================
        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        THIS.Caption = "Impress" + CHR(227) + "o de Rela" + CHR(231) + CHR(245) + "es e Etiquetas"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top      = 18
            .Left     = 10
            .Width    = 360
            .Height   = 40
            .FontName = "Tahoma"
            .FontSize = 14
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(0,0,0)
            .WordWrap = .T.
            .Caption  = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top      = 17
            .Left     = 10
            .Width    = 360
            .Height   = 46
            .FontName = "Tahoma"
            .FontSize = 14
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(255,255,255)
            .WordWrap = .T.
            .Caption  = THIS.Caption
        ENDWITH

        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 46
            .Left        = 369
            .Height      = 18
            .Width       = 225
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136,189,188)
        ENDWITH
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *===========================================================================
        LOCAL loc_oErro
        TRY
            THIS.AddObject("obj_4c_TpOrdem", "OptionGroup")
            WITH THIS.obj_4c_TpOrdem
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 1
                .Height        = 33
                .Left          = 4
                .SpecialEffect = 1
                .Top           = 82
                .Width         = 147
                .BackColor     = RGB(255,255,255)
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH THIS.obj_4c_TpOrdem.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Ordem de Produ" + CHR(231) + CHR(227) + "o :"
                .Value     = 1
                .Height    = 15
                .Left      = 3
                .Top       = 1
                .Width     = 120
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH THIS.obj_4c_TpOrdem.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Ordem de Servi" + CHR(231) + "o "
                .Height    = 15
                .Left      = 3
                .Top       = 17
                .Width     = 106
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH THIS.cmd_4c_Visualizar
                .Top                = 3
                .Left               = 374
                .Height             = 75
                .Width              = 75
                .Picture            = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .Caption            = "\<V" + CHR(237) + "deo"
                .TabIndex           = 26
                .PicturePosition    = 13
                .ForeColor          = RGB(90,90,90)
                .BackColor          = RGB(255,255,255)
                .DisabledBackColor  = RGB(255,255,255)
                .Themes           = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
            WITH THIS.cmd_4c_Imprimir
                .Top             = 3
                .Left            = 449
                .Height          = 75
                .Width           = 75
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .Caption         = "\<Impressora"
                .TabIndex        = 25
                .PicturePosition = 13
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes           = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Saida", "CommandButton")
            WITH THIS.cmd_4c_Saida
                .Top       = 3
                .Left      = 524
                .Height    = 75
                .Width     = 75
                .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel    = .T.
                .Caption   = "Encerrar"
                .TabIndex  = 27
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
                .Themes           = .T.
            ENDWITH

            BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(THIS.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmd_4c_Saida,      "Click", THIS, "BtnEncerrarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *===========================================================================
        LOCAL loc_oErro
        TRY
            THIS.AddObject("lbl_4c_LblOrdem", "Label")
            WITH THIS.lbl_4c_LblOrdem
                .FontName  = "Verdana"
                .BackStyle = 0
                .Caption   = ":"
                .Height    = 16
                .Left      = 142
                .Top       = 97
                .Width     = 7
                .ForeColor = RGB(36,84,155)
                .BackColor = RGB(255,255,255)
            ENDWITH

            THIS.AddObject("lbl_4c_LblAte1", "Label")
            WITH THIS.lbl_4c_LblAte1
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "at" + CHR(233)
                .Height    = 15
                .Left      = 216
                .Top       = 92
                .Width     = 18
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
            ENDWITH

            THIS.AddObject("txt_4c_Ordem", "TextBox")
            WITH THIS.txt_4c_Ordem
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Value         = 0
                .Format        = "KLZ"
                .Height        = 23
                .InputMask     = "999999"
                .Left          = 153
                .SpecialEffect = 1
                .TabIndex      = 2
                .Top           = 88
                .Width         = 55
                .ForeColor     = RGB(0,0,0)
                .BackColor     = RGB(255,255,255)
            ENDWITH

            THIS.AddObject("txt_4c_Ordem2", "TextBox")
            WITH THIS.txt_4c_Ordem2
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Value         = 0
                .Format        = "KLZ"
                .Height        = 23
                .InputMask     = "999999"
                .Left          = 243
                .SpecialEffect = 1
                .TabIndex      = 4
                .Top           = 88
                .Width         = 55
                .ForeColor     = RGB(0,0,0)
                .BackColor     = RGB(255,255,255)
            ENDWITH

            THIS.AddObject("lbl_4c_LblSeqDe", "Label")
            WITH THIS.lbl_4c_LblSeqDe
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Seq" + CHR(252) + CHR(234) + "ncia de :"
                .Height    = 15
                .Left      = 61
                .Top       = 120
                .Width     = 88
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
            ENDWITH

            THIS.AddObject("lbl_4c_LblAte2", "Label")
            WITH THIS.lbl_4c_LblAte2
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "at" + CHR(233)
                .Height    = 15
                .Left      = 216
                .Top       = 119
                .Width     = 18
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
            ENDWITH

            THIS.AddObject("txt_4c_SeqIni", "TextBox")
            WITH THIS.txt_4c_SeqIni
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Value         = 0
                .Format        = "KL"
                .Height        = 23
                .InputMask     = "9999"
                .Left          = 153
                .Margin        = 0
                .SpecialEffect = 1
                .TabIndex      = 6
                .Top           = 114
                .Width         = 55
                .ForeColor     = RGB(0,0,0)
                .BackColor     = RGB(255,255,255)
            ENDWITH

            THIS.AddObject("txt_4c_SeqFim", "TextBox")
            WITH THIS.txt_4c_SeqFim
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Value         = 9999
                .Format        = "KL"
                .Height        = 23
                .InputMask     = "9999"
                .Left          = 244
                .Margin        = 0
                .SpecialEffect = 1
                .TabIndex      = 8
                .Top           = 114
                .Width         = 55
                .ForeColor     = RGB(0,0,0)
                .BackColor     = RGB(255,255,255)
            ENDWITH

            THIS.AddObject("lbl_4c_LblClass", "Label")
            WITH THIS.lbl_4c_LblClass
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
                .Height    = 15
                .Left      = 64
                .Top       = 144
                .Width     = 85
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("txt_4c_Class", "TextBox")
            WITH THIS.txt_4c_Class
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Height        = 23
                .InputMask     = ""
                .Left          = 153
                .MaxLength     = 3
                .SpecialEffect = 1
                .TabIndex      = 10
                .Top           = 140
                .Width         = 31
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            THIS.AddObject("lbl_4c_LblCor", "Label")
            WITH THIS.lbl_4c_LblCor
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Cor :"
                .Left      = 208
                .Top       = 144
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("txt_4c_Cor", "TextBox")
            WITH THIS.txt_4c_Cor
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Height        = 23
                .Left          = 244
                .SpecialEffect = 1
                .TabIndex      = 12
                .Top           = 140
                .Width         = 38
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            THIS.AddObject("lbl_4c_LblLin", "Label")
            WITH THIS.lbl_4c_LblLin
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .Caption   = "Linha :"
                .Height    = 15
                .Left      = 108
                .Top       = 170
                .Width     = 41
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("txt_4c_Lin", "TextBox")
            WITH THIS.txt_4c_Lin
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .Height        = 23
                .InputMask     = ""
                .Left          = 153
                .MaxLength     = 0
                .SpecialEffect = 1
                .TabIndex      = 14
                .Top           = 166
                .Width         = 80
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            THIS.AddObject("txt_4c_DLin", "TextBox")
            WITH THIS.txt_4c_DLin
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .Height        = 23
                .InputMask     = ""
                .Left          = 234
                .MaxLength     = 0
                .SpecialEffect = 1
                .TabIndex      = 15
                .Top           = 166
                .Width         = 318
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            THIS.AddObject("lbl_4c_LblFase", "Label")
            WITH THIS.lbl_4c_LblFase
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .Caption   = "Fase :"
                .Height    = 15
                .Left      = 112
                .Top       = 196
                .Width     = 37
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("txt_4c_Fase", "TextBox")
            WITH THIS.txt_4c_Fase
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .Height        = 23
                .InputMask     = ""
                .Left          = 153
                .MaxLength     = 0
                .SpecialEffect = 1
                .TabIndex      = 17
                .Top           = 192
                .Width         = 80
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            THIS.AddObject("txt_4c_Dfase", "TextBox")
            WITH THIS.txt_4c_Dfase
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K"
                .Height        = 23
                .InputMask     = ""
                .Left          = 234
                .MaxLength     = 0
                .SpecialEffect = 1
                .TabIndex      = 18
                .Top           = 192
                .Width         = 318
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 225
                .Left        = 8
                .Height      = 1
                .Width       = 584
                .BackStyle   = 0
                .BackColor   = RGB(255,255,255)
                .BorderColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("lbl_4c_LblTipo", "Label")
            WITH THIS.lbl_4c_LblTipo
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Tipo de Impress" + CHR(227) + "o :"
                .Height    = 15
                .Left      = 49
                .Top       = 235
                .Width     = 118
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
            ENDWITH

            THIS.AddObject("obj_4c_Get_Tipo", "OptionGroup")
            WITH THIS.obj_4c_Get_Tipo
                .ButtonCount   = 6
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 0
                .Height        = 40
                .Left          = 167
                .SpecialEffect = 1
                .Top           = 231
                .Width         = 425
                .BackColor     = RGB(255,255,255)
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            *-- ButtonsValue NAO seta valor semantico do OptionGroup. .Value do
            *-- OptionButton eh 0/1 (selecionado ou nao); OptionGroup.Value controla
            *-- qual dos N botoes esta selecionado. Setar Value=N em cada botao faz
            *-- todos aparecerem marcados (qualquer nao-zero = truthy).
            WITH THIS.obj_4c_Get_Tipo.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o"
                .Height    = 15
                .Left      = 3
                .Top       = 2
                .Width     = 56
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH THIS.obj_4c_Get_Tipo.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Etiquetas"
                .Height    = 15
                .Left      = 136
                .Top       = 2
                .Width     = 63
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH THIS.obj_4c_Get_Tipo.Buttons(3)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Tiras"
                .Height    = 15
                .Left      = 245
                .Top       = 2
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH THIS.obj_4c_Get_Tipo.Buttons(4)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Tiras com Imagem"
                .Height    = 15
                .Left      = 3
                .Top       = 21
                .Width     = 104
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH THIS.obj_4c_Get_Tipo.Buttons(5)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Boleto Rela" + CHR(231) + CHR(227) + "o"
                .Height    = 15
                .Left      = 136
                .Top       = 21
                .Width     = 89
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH THIS.obj_4c_Get_Tipo.Buttons(6)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Etiquetas com Imagem"
                .Height    = 15
                .Left      = 245
                .Top       = 21
                .Width     = 126
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            BINDEVENT(THIS.obj_4c_Get_Tipo, "InteractiveChange", THIS, "TipoInteractiveChange")
            BINDEVENT(THIS.obj_4c_Get_Tipo, "Click", THIS, "TipoInteractiveChange")

            *-- Container Etiquetas (Visible=.F. - alternado por Get_Tipo)
            THIS.AddObject("cnt_4c_Etiquetas", "Container")
            WITH THIS.cnt_4c_Etiquetas
                .Top         = 274
                .Left        = 5
                .Width       = 584
                .Height      = 249
                .BackStyle   = 0
                .BackColor   = RGB(255,255,255)
                .BorderWidth = 0
                .Visible     = .F.
            ENDWITH
            THIS.CriarContainerEtiquetas()

            *-- Container Relacao (Visible=.F. - alternado por Get_Tipo)
            THIS.AddObject("cnt_4c_Relacao", "Container")
            WITH THIS.cnt_4c_Relacao
                .Top         = 274
                .Left        = 5
                .Width       = 584
                .Height      = 139
                .BackStyle   = 1
                .BackColor   = RGB(255,255,255)
                .BorderWidth = 0
                .Visible     = .F.
            ENDWITH
            THIS.CriarContainerRelacao()

            THIS.AddObject("obj_4c_ObsOper", "EditBox")
            WITH THIS.obj_4c_ObsOper
                .Height      = 65
                .Left        = 8
                .TabIndex    = 22
                .Top         = 529
                .Width       = 583
                .NullDisplay = " "
            ENDWITH

            BINDEVENT(THIS.txt_4c_Class,  "KeyPress", THIS, "TxtClassKeyPress")
            BINDEVENT(THIS.txt_4c_Lin,    "KeyPress", THIS, "TxtLinKeyPress")
            BINDEVENT(THIS.txt_4c_DLin,   "KeyPress", THIS, "TxtDLinKeyPress")
            BINDEVENT(THIS.txt_4c_Cor,    "KeyPress", THIS, "TxtCorKeyPress")
            BINDEVENT(THIS.txt_4c_Fase,   "KeyPress", THIS, "TxtFaseKeyPress")
            BINDEVENT(THIS.txt_4c_Dfase,  "KeyPress", THIS, "TxtDfaseKeyPress")
            BINDEVENT(THIS.txt_4c_SeqIni, "KeyPress", THIS, "TxtSeqIniKeyPress")
            BINDEVENT(THIS.txt_4c_SeqFim, "KeyPress", THIS, "TxtSeqFimKeyPress")
            BINDEVENT(THIS.txt_4c_Ordem2, "KeyPress", THIS, "TxtOrdem2KeyPress")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE CriarContainerEtiquetas()
    *===========================================================================
        LOCAL loc_oE, loc_oErro
        loc_oE = THIS.cnt_4c_Etiquetas

        TRY
            loc_oE.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oE.lbl_4c_Label3
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Somente Divididas :"
                .Height    = 15
                .Left      = 59
                .Top       = 7
                .Width     = 96
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oE.AddObject("obj_4c_Get_Divididas", "OptionGroup")
            WITH loc_oE.obj_4c_Get_Divididas
                .AutoSize      = .T.
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 2
                .Height        = 25
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 2
                .Width         = 115
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Divididas.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Value     = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Divididas.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Value     = 1
                .Height    = 15
                .Left      = 68
                .Top       = 5
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oE.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oE.lbl_4c_Label1
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Imprimir :"
                .Height    = 15
                .Left      = 108
                .Top       = 29
                .Width     = 47
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oE.AddObject("obj_4c_Get_Imprimir", "OptionGroup")
            WITH loc_oE.obj_4c_Get_Imprimir
                .AutoSize      = .T.
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 1
                .Height        = 25
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 24
                .Width         = 167
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Imprimir.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Geral"
                .Value     = 1
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 43
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Imprimir.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Impressas"
                .Height    = 15
                .Left      = 68
                .Top       = 5
                .Width     = 89
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oE.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oE.lbl_4c_Label6
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Imprime Composi" + CHR(231) + CHR(227) + "o :"
                .Height    = 15
                .Left      = 48
                .Top       = 51
                .Width     = 107
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oE.AddObject("obj_4c_Get_Compo", "OptionGroup")
            WITH loc_oE.obj_4c_Get_Compo
                .AutoSize      = .T.
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 1
                .Height        = 25
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 46
                .Width         = 115
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Compo.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Value     = 1
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Compo.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Height    = 15
                .Left      = 68
                .Top       = 5
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oE.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oE.lbl_4c_Label7
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Crava" + CHR(231) + CHR(227) + "o em Cera :"
                .Height    = 15
                .Left      = 57
                .Top       = 73
                .Width     = 98
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oE.AddObject("obj_4c_Get_Cera", "OptionGroup")
            WITH loc_oE.obj_4c_Get_Cera
                .AutoSize      = .T.
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 2
                .Height        = 25
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 68
                .Width         = 115
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Cera.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Value     = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Cera.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Value     = 1
                .Height    = 15
                .Left      = 68
                .Top       = 5
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oE.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oE.lbl_4c_Label8
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Imprimir Pedidos :"
                .Height    = 15
                .Left      = 68
                .Top       = 96
                .Width     = 87
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oE.AddObject("obj_4c_Get_Pedido", "OptionGroup")
            WITH loc_oE.obj_4c_Get_Pedido
                .AutoSize      = .T.
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 2
                .Height        = 25
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 91
                .Width         = 110
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Pedido.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Value     = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Pedido.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Value     = 1
                .Height    = 15
                .Left      = 68
                .Top       = 5
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oE.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oE.lbl_4c_Label9
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Tipo :"
                .Height    = 15
                .Left      = 126
                .Top       = 119
                .Width     = 29
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oE.AddObject("obj_4c_Get_Boleto", "OptionGroup")
            WITH loc_oE.obj_4c_Get_Boleto
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 2
                .Height        = 27
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 114
                .Width         = 255
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Boleto.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Boleto"
                .Value     = 1
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 48
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Boleto.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Laser"
                .Height    = 15
                .Left      = 68
                .Top       = 5
                .Width     = 44
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Boleto.Buttons(3)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Allegro"
                .Height    = 17
                .Left      = 123
                .Top       = 5
                .Width     = 61
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Boleto.Buttons(4)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Colunas"
                .Height    = 15
                .Left      = 188
                .Top       = 5
                .Width     = 56
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            BINDEVENT(loc_oE.obj_4c_Get_Boleto, "InteractiveChange", THIS, "BoletoInteractiveChange")

            loc_oE.AddObject("chk_4c_Chknome", "CheckBox")
            WITH loc_oE.chk_4c_Chknome
                .Top       = 6
                .Left      = 296
                .AutoSize  = .T.
                .Alignment = 0
                .Caption   = "Nome da Conta"
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH

            loc_oE.AddObject("chk_4c_Chk2Linhas", "CheckBox")
            WITH loc_oE.chk_4c_Chk2Linhas
                .Top       = 119
                .Left      = 422
                .AutoSize  = .T.
                .Alignment = 0
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o em 2 linhas"
                .Value     = 0
                .Enabled   = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH

            loc_oE.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oE.lbl_4c_Label10
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Processos :"
                .Height    = 15
                .Left      = 98
                .Top       = 139
                .Width     = 57
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oE.AddObject("obj_4c_Get_Processo", "OptionGroup")
            WITH loc_oE.obj_4c_Get_Processo
                .AutoSize      = .T.
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 2
                .Height        = 25
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 136
                .Width         = 115
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Processo.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Value     = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Processo.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Value     = 1
                .Height    = 15
                .Left      = 68
                .Top       = 5
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oE.AddObject("lbl_4c_Label11", "Label")
            WITH loc_oE.lbl_4c_Label11
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Pedido :"
                .Height    = 15
                .Left      = 38
                .Top       = 162
                .Width     = 117
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oE.AddObject("obj_4c_Get_Complemto", "OptionGroup")
            WITH loc_oE.obj_4c_Get_Complemto
                .AutoSize      = .T.
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 2
                .Height        = 25
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 159
                .Width         = 115
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Complemto.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Value     = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oE.obj_4c_Get_Complemto.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Value     = 1
                .Height    = 15
                .Left      = 68
                .Top       = 5
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oE.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oE.lbl_4c_Label2
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto :"
                .Height    = 15
                .Left      = 44
                .Top       = 185
                .Width     = 111
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oE.AddObject("obj_4c_OptDescs", "OptionGroup")
            WITH loc_oE.obj_4c_OptDescs
                .AutoSize      = .T.
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 1
                .Height        = 25
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 182
                .Width         = 138
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oE.obj_4c_OptDescs.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Normal"
                .Value     = 1
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 51
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oE.obj_4c_OptDescs.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Descritivo"
                .Value     = 0
                .Height    = 15
                .Left      = 68
                .Top       = 5
                .Width     = 65
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oE.AddObject("chk_4c_ChkDatager", "CheckBox")
            WITH loc_oE.chk_4c_ChkDatager
                .Top       = 6
                .Left      = 423
                .AutoSize  = .T.
                .Alignment = 0
                .Caption   = "Data gera" + CHR(231) + CHR(227) + "o OP"
                .Value     = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH

            loc_oE.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oE.lbl_4c_Label4
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 12
                .BackStyle = 0
                .Caption   = "/"
                .Height    = 21
                .Left      = 193
                .Top       = 213
                .Width     = 8
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oE.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oE.lbl_4c_Label5
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Posi" + CHR(231) + CHR(227) + "o (Linha / Coluna) :"
                .Height    = 15
                .Left      = 31
                .Top       = 214
                .Width     = 124
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oE.AddObject("txt_4c_Linha", "TextBox")
            WITH loc_oE.txt_4c_Linha
                .FontSize  = 9
                .Alignment = 3
                .Value     = 1
                .Format    = "KL"
                .Height    = 21
                .InputMask = "99"
                .Left      = 162
                .Margin    = 0
                .Top       = 212
                .Width     = 27
            ENDWITH

            loc_oE.AddObject("txt_4c_Coluna", "TextBox")
            WITH loc_oE.txt_4c_Coluna
                .FontSize  = 9
                .Alignment = 3
                .Value     = 1
                .Format    = "KL"
                .Height    = 21
                .InputMask = "99"
                .Left      = 205
                .Margin    = 0
                .Top       = 213
                .Width     = 27
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE CriarContainerRelacao()
    *===========================================================================
        LOCAL loc_oR, loc_oErro
        loc_oR = THIS.cnt_4c_Relacao

        TRY
            loc_oR.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oR.lbl_4c_Label3
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Pedidos :"
                .Height    = 15
                .Left      = 103
                .Top       = 8
                .Width     = 55
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oR.AddObject("obj_4c_Get_Pedido", "OptionGroup")
            WITH loc_oR.obj_4c_Get_Pedido
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 1
                .Height        = 21
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 5
                .Width         = 160
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oR.obj_4c_Get_Pedido.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Value     = 1
                .Height    = 15
                .Left      = 5
                .Top       = 2
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oR.obj_4c_Get_Pedido.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Height    = 15
                .Left      = 69
                .Top       = 2
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oR.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oR.lbl_4c_Label1
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Resumido :"
                .Height    = 15
                .Left      = 91
                .Top       = 30
                .Width     = 67
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oR.AddObject("obj_4c_Get_Resumo", "OptionGroup")
            WITH loc_oR.obj_4c_Get_Resumo
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 2
                .Height        = 21
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 27
                .Width         = 160
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oR.obj_4c_Get_Resumo.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Value     = 0
                .Height    = 15
                .Left      = 5
                .Top       = 2
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oR.obj_4c_Get_Resumo.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Value     = 1
                .Height    = 15
                .Left      = 69
                .Top       = 2
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oR.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oR.lbl_4c_Label2
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "C" + CHR(243) + "digo de Barras :"
                .Height    = 15
                .Left      = 47
                .Top       = 52
                .Width     = 111
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oR.AddObject("obj_4c_Get_Barra", "OptionGroup")
            WITH loc_oR.obj_4c_Get_Barra
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 2
                .Height        = 21
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 49
                .Width         = 160
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oR.obj_4c_Get_Barra.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Value     = 0
                .Height    = 15
                .Left      = 5
                .Top       = 2
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oR.obj_4c_Get_Barra.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Value     = 1
                .Height    = 15
                .Left      = 69
                .Top       = 2
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oR.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oR.lbl_4c_Label4
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
                .Height    = 15
                .Left      = 85
                .Top       = 74
                .Width     = 73
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oR.AddObject("obj_4c_Opt_Ordem", "OptionGroup")
            WITH loc_oR.obj_4c_Opt_Ordem
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 3
                .Height        = 21
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 71
                .Width         = 281
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oR.obj_4c_Opt_Ordem.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Destino"
                .Value     = 1
                .Height    = 15
                .Left      = 5
                .Top       = 2
                .Width     = 54
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oR.obj_4c_Opt_Ordem.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Cor"
                .Height    = 15
                .Left      = 69
                .Top       = 2
                .Width     = 35
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oR.obj_4c_Opt_Ordem.Buttons(3)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Seq" + CHR(252) + CHR(234) + "ncia"
                .Height    = 15
                .Left      = 114
                .Top       = 2
                .Width     = 67
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oR.obj_4c_Opt_Ordem.Buttons(4)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Refer" + CHR(234) + "ncia"
                .Height    = 15
                .Left      = 198
                .Top       = 1
                .Width     = 70
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oR.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oR.lbl_4c_Label5
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto :"
                .Height    = 15
                .Left      = 25
                .Top       = 95
                .Width     = 133
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oR.AddObject("obj_4c_OptDescs", "OptionGroup")
            WITH loc_oR.obj_4c_OptDescs
                .AutoSize      = .T.
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 1
                .Height        = 25
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 90
                .Width         = 144
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oR.obj_4c_OptDescs.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Normal"
                .Value     = 1
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 51
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oR.obj_4c_OptDescs.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Descritivo"
                .Value     = 0
                .Height    = 15
                .Left      = 69
                .Top       = 5
                .Width     = 65
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            loc_oR.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oR.lbl_4c_Label6
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "C" + CHR(243) + "d. Barras e Imagem :"
                .Height    = 15
                .Left      = 15
                .Top       = 116
                .Width     = 143
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oR.AddObject("obj_4c_OptImagem", "OptionGroup")
            WITH loc_oR.obj_4c_OptImagem
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 2
                .Height        = 21
                .Left          = 157
                .SpecialEffect = 1
                .Top           = 113
                .Width         = 160
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH
            WITH loc_oR.obj_4c_OptImagem.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Value     = 0
                .Height    = 15
                .Left      = 5
                .Top       = 2
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH
            WITH loc_oR.obj_4c_OptImagem.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Value     = 1
                .Height    = 15
                .Left      = 69
                .Top       = 2
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
                .Themes    = .F.
            ENDWITH

            BINDEVENT(loc_oR.obj_4c_Get_Pedido, "InteractiveChange", THIS, "RelPedidoInteractiveChange")
            BINDEVENT(loc_oR.obj_4c_Get_Pedido, "Click",             THIS, "RelPedidoInteractiveChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE AplicarParametrosIniciais()
    *===========================================================================
        IF THIS.this_nNop <> 0
            THIS.txt_4c_Ordem.Value    = THIS.this_nNop
            THIS.txt_4c_Ordem.ReadOnly = .T.
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O"
            LOCAL loc_cNomePai
            loc_cNomePai = UPPER(ALLTRIM(THIS.this_oParentForm.Name))
            IF loc_cNomePai = "SIGPRGLP" OR loc_cNomePai = "SIGPRGLX" OR loc_cNomePai = "FORMSIGPRGLP"
                THIS.obj_4c_TpOrdem.Value = 1
            ELSE
                THIS.obj_4c_TpOrdem.Value = 2
            ENDIF
            THIS.obj_4c_TpOrdem.Enabled = .F.
        ELSE
            THIS.obj_4c_TpOrdem.Enabled = .T.
        ENDIF

        THIS.cnt_4c_Etiquetas.chk_4c_Chk2Linhas.Value   = 0
        THIS.cnt_4c_Etiquetas.chk_4c_Chk2Linhas.Enabled = .F.
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *===========================================================================
        LOCAL loc_i, loc_oControl, loc_p
        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) != "O"
                LOOP
            ENDIF

            IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_SOMBRA", "CNT_4C_ETIQUETAS", "CNT_4C_RELACAO")
                *-- Container preserva estado inicial (cnt_4c_Etiquetas/Relacao ocultos ate
                *-- Tipo ser selecionado). Mas RECURSAR para tornar sub-controles Visible=.T.,
                *-- caso contrario container fica vazio ao ser mostrado.
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                FOR loc_p = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                ENDFOR
            ENDIF

            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    PROCEDURE FormParaBO()
    *===========================================================================
        WITH THIS.this_oBusinessObject
            .this_nOrdem     = THIS.txt_4c_Ordem.Value
            .this_nOrdem2    = THIS.txt_4c_Ordem2.Value
            .this_nSeqIni    = THIS.txt_4c_SeqIni.Value
            .this_nSeqFim    = THIS.txt_4c_SeqFim.Value
            .this_nTipo      = THIS.obj_4c_Get_Tipo.Value
            .this_nTpOrdem   = THIS.obj_4c_TpOrdem.Value
            .this_cClass     = ALLTRIM(THIS.txt_4c_Class.Value)
            .this_cLin       = ALLTRIM(THIS.txt_4c_Lin.Value)
            .this_cDLin      = ALLTRIM(THIS.txt_4c_DLin.Value)
            .this_cCor       = ALLTRIM(THIS.txt_4c_Cor.Value)
            .this_cFase      = ALLTRIM(THIS.txt_4c_Fase.Value)
            .this_cDfase     = ALLTRIM(THIS.txt_4c_Dfase.Value)
            .this_cObsOper   = ALLTRIM(THIS.obj_4c_ObsOper.Value)

            .this_nDivididas  = THIS.cnt_4c_Etiquetas.obj_4c_Get_Divididas.Value
            .this_nImprimir   = THIS.cnt_4c_Etiquetas.obj_4c_Get_Imprimir.Value
            .this_nLinha      = THIS.cnt_4c_Etiquetas.txt_4c_Linha.Value
            .this_nColuna     = THIS.cnt_4c_Etiquetas.txt_4c_Coluna.Value
            .this_nCompo      = THIS.cnt_4c_Etiquetas.obj_4c_Get_Compo.Value
            .this_nCera       = THIS.cnt_4c_Etiquetas.obj_4c_Get_Cera.Value
            .this_nEtqPedido  = THIS.cnt_4c_Etiquetas.obj_4c_Get_Pedido.Value
            .this_nBoleto     = THIS.cnt_4c_Etiquetas.obj_4c_Get_Boleto.Value
            .this_nProcesso   = THIS.cnt_4c_Etiquetas.obj_4c_Get_Processo.Value
            .this_nComplemto  = THIS.cnt_4c_Etiquetas.obj_4c_Get_Complemto.Value
            .this_lNome       = THIS.cnt_4c_Etiquetas.chk_4c_Chknome.Value
            .this_l2Linhas    = THIS.cnt_4c_Etiquetas.chk_4c_Chk2Linhas.Value
            .this_nOptDescs   = THIS.cnt_4c_Etiquetas.obj_4c_OptDescs.Value
            .this_lDatager    = THIS.cnt_4c_Etiquetas.chk_4c_ChkDatager.Value

            .this_nRelPedido   = THIS.cnt_4c_Relacao.obj_4c_Get_Pedido.Value
            .this_nResumo      = THIS.cnt_4c_Relacao.obj_4c_Get_Resumo.Value
            .this_nBarra       = THIS.cnt_4c_Relacao.obj_4c_Get_Barra.Value
            .this_nOptOrdem    = THIS.cnt_4c_Relacao.obj_4c_Opt_Ordem.Value
            .this_nRelOptDescs = THIS.cnt_4c_Relacao.obj_4c_OptDescs.Value
            .this_nOptImagem   = THIS.cnt_4c_Relacao.obj_4c_OptImagem.Value
        ENDWITH
    ENDPROC

    *===========================================================================
    PROCEDURE BOParaForm()
    *===========================================================================
        WITH THIS.this_oBusinessObject
            THIS.txt_4c_Ordem.Value    = .this_nOrdem
            THIS.txt_4c_Ordem2.Value   = .this_nOrdem2
            THIS.txt_4c_SeqIni.Value   = .this_nSeqIni
            THIS.txt_4c_SeqFim.Value   = .this_nSeqFim
            THIS.txt_4c_Class.Value    = .this_cClass
            THIS.txt_4c_Lin.Value      = .this_cLin
            THIS.txt_4c_DLin.Value     = .this_cDLin
            THIS.txt_4c_Cor.Value      = .this_cCor
            THIS.txt_4c_Fase.Value     = .this_cFase
            THIS.txt_4c_Dfase.Value    = .this_cDfase
            THIS.obj_4c_ObsOper.Value  = .this_cObsOper
            THIS.obj_4c_Get_Tipo.Value = .this_nTipo

            THIS.cnt_4c_Etiquetas.obj_4c_Get_Divididas.Value  = .this_nDivididas
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Imprimir.Value   = .this_nImprimir
            THIS.cnt_4c_Etiquetas.txt_4c_Linha.Value          = .this_nLinha
            THIS.cnt_4c_Etiquetas.txt_4c_Coluna.Value         = .this_nColuna
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Compo.Value      = .this_nCompo
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Cera.Value       = .this_nCera
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Pedido.Value     = .this_nEtqPedido
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Boleto.Value     = .this_nBoleto
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Processo.Value   = .this_nProcesso
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Complemto.Value  = .this_nComplemto
            THIS.cnt_4c_Etiquetas.chk_4c_Chknome.Value        = .this_lNome
            THIS.cnt_4c_Etiquetas.chk_4c_Chk2Linhas.Value     = .this_l2Linhas
            THIS.cnt_4c_Etiquetas.obj_4c_OptDescs.Value       = .this_nOptDescs
            THIS.cnt_4c_Etiquetas.chk_4c_ChkDatager.Value     = .this_lDatager

            THIS.cnt_4c_Relacao.obj_4c_Get_Pedido.Value  = .this_nRelPedido
            THIS.cnt_4c_Relacao.obj_4c_Get_Resumo.Value  = .this_nResumo
            THIS.cnt_4c_Relacao.obj_4c_Get_Barra.Value   = .this_nBarra
            THIS.cnt_4c_Relacao.obj_4c_Opt_Ordem.Value   = .this_nOptOrdem
            THIS.cnt_4c_Relacao.obj_4c_OptDescs.Value    = .this_nRelOptDescs
            THIS.cnt_4c_Relacao.obj_4c_OptImagem.Value   = .this_nOptImagem
        ENDWITH
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ValidarEntrada()
    *===========================================================================
        IF THIS.txt_4c_Ordem.Value = 0
            MsgAviso("Informe o n" + CHR(250) + "mero da Ordem!!!")
            THIS.txt_4c_Ordem.SetFocus()
            RETURN .F.
        ENDIF
        IF THIS.obj_4c_Get_Tipo.Value = 0
            MsgAviso("Selecione Um Tipo de Impress" + CHR(227) + "o!!!")
            RETURN .F.
        ENDIF
        IF THIS.txt_4c_Ordem2.Value <> 0 AND ;
           THIS.txt_4c_Ordem2.Value = THIS.txt_4c_Ordem.Value
            MsgAviso("N" + CHR(250) + "mero de OP Inv" + CHR(225) + "lido!!!")
            THIS.txt_4c_Ordem2.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *===========================================================================
    PROCEDURE BtnImprimirClick()
    *===========================================================================
        IF !THIS.ValidarEntrada()
            RETURN
        ENDIF
        THIS.FormParaBO()

        DO CASE
            CASE THIS.obj_4c_Get_Tipo.Value = 1
                IF THIS.txt_4c_Ordem2.Value > 0
                    THIS.this_oBusinessObject.ProcRelacao2('I')
                ELSE
                    THIS.this_oBusinessObject.ProcRelacao('I')
                ENDIF

            CASE THIS.obj_4c_Get_Tipo.Value = 2
                THIS.this_oBusinessObject.ProcEtiquetas('I')

            CASE THIS.obj_4c_Get_Tipo.Value = 3
                IF THIS.txt_4c_Ordem2.Value > 0
                    THIS.this_oBusinessObject.ProcTiraa('I')
                ELSE
                    THIS.this_oBusinessObject.ProcTiraf('I')
                ENDIF

            CASE THIS.obj_4c_Get_Tipo.Value = 4
                IF THIS.txt_4c_Ordem2.Value > 0
                    THIS.this_oBusinessObject.ProcTirad('I')
                ELSE
                    THIS.this_oBusinessObject.ProcTiraf('I')
                ENDIF

            CASE THIS.obj_4c_Get_Tipo.Value = 5
                THIS.this_oBusinessObject.ProcRelacao('I')

            CASE THIS.obj_4c_Get_Tipo.Value = 6
                THIS.this_oBusinessObject.ProcEtiqf('I')
        ENDCASE
    ENDPROC

    *===========================================================================
    PROCEDURE BtnVisualizarClick()
    *===========================================================================
        IF THIS.obj_4c_Get_Tipo.Value = 0
            MsgAviso("Selecione Um Tipo de Impress" + CHR(227) + "o!!!")
            RETURN
        ENDIF
        IF !THIS.ValidarEntrada()
            RETURN
        ENDIF
        THIS.FormParaBO()

        DO CASE
            CASE THIS.obj_4c_Get_Tipo.Value = 1
                IF THIS.txt_4c_Ordem2.Value > 0
                    THIS.this_oBusinessObject.ProcRelacao2('V')
                ELSE
                    THIS.this_oBusinessObject.ProcRelacao('V')
                ENDIF

            CASE THIS.obj_4c_Get_Tipo.Value = 2
                IF THIS.cnt_4c_Etiquetas.obj_4c_Get_Boleto.Value = 3
                    MsgAviso("Impress" + CHR(227) + "o de Allegro n" + CHR(227) + "o tem visualiza" + CHR(231) + CHR(227) + "o!!!")
                    RETURN
                ENDIF
                THIS.this_oBusinessObject.ProcEtiquetas('V')

            CASE THIS.obj_4c_Get_Tipo.Value = 3
                IF THIS.txt_4c_Ordem2.Value > 0
                    THIS.this_oBusinessObject.ProcTiraa('V')
                ELSE
                    THIS.this_oBusinessObject.ProcTiraf('V')
                ENDIF

            CASE THIS.obj_4c_Get_Tipo.Value = 4
                IF THIS.txt_4c_Ordem2.Value > 0
                    THIS.this_oBusinessObject.ProcTirad('V')
                ELSE
                    THIS.this_oBusinessObject.ProcTiraf('V')
                ENDIF

            CASE THIS.obj_4c_Get_Tipo.Value = 6
                THIS.this_oBusinessObject.ProcEtiqf('V')
        ENDCASE
    ENDPROC

    *===========================================================================
    PROCEDURE BtnEncerrarClick()
    *===========================================================================
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *===========================================================================
    PROCEDURE LimparCampos()
    *===========================================================================
        THIS.txt_4c_Ordem.Value    = 0
        THIS.txt_4c_Ordem2.Value   = 0
        THIS.txt_4c_SeqIni.Value   = 0
        THIS.txt_4c_SeqFim.Value   = 0
        THIS.txt_4c_Class.Value    = ""
        THIS.txt_4c_Lin.Value      = ""
        THIS.txt_4c_DLin.Value     = ""
        THIS.txt_4c_Cor.Value      = ""
        THIS.txt_4c_Fase.Value     = ""
        THIS.txt_4c_Dfase.Value    = ""
        THIS.obj_4c_ObsOper.Value  = ""
        THIS.obj_4c_Get_Tipo.Value = 0

        THIS.cnt_4c_Etiquetas.obj_4c_Get_Divididas.Value = 2
        THIS.cnt_4c_Etiquetas.obj_4c_Get_Imprimir.Value  = 1
        THIS.cnt_4c_Etiquetas.txt_4c_Linha.Value         = 0
        THIS.cnt_4c_Etiquetas.txt_4c_Coluna.Value        = 0
        THIS.cnt_4c_Etiquetas.obj_4c_Get_Compo.Value     = 2
        THIS.cnt_4c_Etiquetas.obj_4c_Get_Cera.Value      = 2
        THIS.cnt_4c_Etiquetas.obj_4c_Get_Pedido.Value    = 2
        THIS.cnt_4c_Etiquetas.obj_4c_Get_Boleto.Value    = 1
        THIS.cnt_4c_Etiquetas.obj_4c_Get_Processo.Value  = 1
        THIS.cnt_4c_Etiquetas.obj_4c_Get_Complemto.Value = 1
        THIS.cnt_4c_Etiquetas.chk_4c_Chknome.Value       = 0
        THIS.cnt_4c_Etiquetas.chk_4c_Chk2Linhas.Value    = 0
        THIS.cnt_4c_Etiquetas.obj_4c_OptDescs.Value      = 1
        THIS.cnt_4c_Etiquetas.chk_4c_ChkDatager.Value    = 1

        THIS.cnt_4c_Relacao.obj_4c_Get_Pedido.Value  = 2
        THIS.cnt_4c_Relacao.obj_4c_Get_Resumo.Value  = 2
        THIS.cnt_4c_Relacao.obj_4c_Get_Barra.Value   = 2
        THIS.cnt_4c_Relacao.obj_4c_Opt_Ordem.Value   = 1
        THIS.cnt_4c_Relacao.obj_4c_OptDescs.Value    = 1
        THIS.cnt_4c_Relacao.obj_4c_OptImagem.Value   = 2

        THIS.cnt_4c_Etiquetas.Visible = .F.
        THIS.cnt_4c_Relacao.Visible   = .F.
    ENDPROC

    *===========================================================================
    PROCEDURE HabilitarCampos()
    *===========================================================================
        LOCAL loc_nTipo
        loc_nTipo = THIS.obj_4c_Get_Tipo.Value

        THIS.txt_4c_Ordem.Enabled  = IIF(THIS.this_nNop <> 0, .F., .T.)
        THIS.txt_4c_Ordem2.Enabled = IIF(THIS.txt_4c_Ordem.Value > 0, .T., .F.)

        THIS.cmd_4c_Imprimir.Enabled   = (loc_nTipo > 0)
        THIS.cmd_4c_Visualizar.Enabled = (loc_nTipo > 0 AND loc_nTipo <> 5)
    ENDPROC

    *===========================================================================
    * Form OPERACIONAL (relatorios): nova consulta com limpeza de filtros.
    *===========================================================================
    PROCEDURE BtnIncluirClick()
    *===========================================================================
        THIS.LimparCampos()
        THIS.AplicarParametrosIniciais()
        THIS.HabilitarCampos()
        THIS.txt_4c_Ordem.SetFocus()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnAlterarClick()
    *===========================================================================
        IF !THIS.ValidarEntrada()
            RETURN
        ENDIF
        THIS.FormParaBO()
        THIS.BOParaForm()
        IF THIS.obj_4c_Get_Tipo.Value > 0
            THIS.TipoInteractiveChange()
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE BtnExcluirClick()
    *===========================================================================
        THIS.txt_4c_Class.Value   = ""
        THIS.txt_4c_Lin.Value     = ""
        THIS.txt_4c_DLin.Value    = ""
        THIS.txt_4c_Cor.Value     = ""
        THIS.txt_4c_Fase.Value    = ""
        THIS.txt_4c_Dfase.Value   = ""
        THIS.obj_4c_ObsOper.Value = ""
        THIS.FormParaBO()
        THIS.txt_4c_Class.SetFocus()
    ENDPROC

    *===========================================================================
    PROCEDURE TipoInteractiveChange()
    *===========================================================================
        LOCAL loc_nTipo
        loc_nTipo = THIS.obj_4c_Get_Tipo.Value

        IF INLIST(loc_nTipo, 2, 4)
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Boleto.Visible = .T.
            THIS.cnt_4c_Etiquetas.lbl_4c_Label9.Visible     = .T.
        ELSE
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Boleto.Visible = .F.
            THIS.cnt_4c_Etiquetas.lbl_4c_Label9.Visible     = .F.
        ENDIF

        *-- Get_Compo e Get_Cera apenas ativos para tipos Etiquetas/Tiras (2,3,4)
        IF INLIST(loc_nTipo, 2, 3, 4)
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Compo.Enabled = .T.
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Cera.Enabled  = .T.
        ELSE
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Compo.Enabled = .F.
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Cera.Enabled  = .F.
        ENDIF

        DO CASE
            CASE loc_nTipo = 1
                THIS.cnt_4c_Etiquetas.Visible  = .F.
                THIS.cnt_4c_Relacao.Visible    = .T.
                THIS.cmd_4c_Visualizar.Enabled = .T.

            CASE INLIST(loc_nTipo, 3, 4) AND THIS.txt_4c_Ordem2.Value > 0
                THIS.cnt_4c_Etiquetas.Visible  = .T.
                THIS.cnt_4c_Relacao.Visible    = .F.
                THIS.cmd_4c_Imprimir.SetFocus()

            CASE loc_nTipo = 5
                THIS.cnt_4c_Etiquetas.Visible  = .F.
                THIS.cnt_4c_Relacao.Visible    = .F.
                THIS.cmd_4c_Visualizar.Enabled = .F.
                THIS.cmd_4c_Imprimir.SetFocus()

            OTHERWISE
                THIS.cnt_4c_Etiquetas.Visible  = .T.
                THIS.cnt_4c_Relacao.Visible    = .F.
        ENDCASE
    ENDPROC

    *===========================================================================
    PROCEDURE BoletoInteractiveChange()
    *===========================================================================
        LOCAL loc_nVal
        loc_nVal = THIS.cnt_4c_Etiquetas.obj_4c_Get_Boleto.Value
        IF loc_nVal = 4
            THIS.cnt_4c_Etiquetas.chk_4c_Chk2Linhas.Enabled = .T.
        ELSE
            THIS.cnt_4c_Etiquetas.chk_4c_Chk2Linhas.Value   = 0
            THIS.cnt_4c_Etiquetas.chk_4c_Chk2Linhas.Enabled = .F.
        ENDIF
        *-- optDescs ativo apenas quando Boleto = 2 (Laser)
        IF loc_nVal = 2
            THIS.cnt_4c_Etiquetas.obj_4c_OptDescs.Enabled = .T.
        ELSE
            THIS.cnt_4c_Etiquetas.obj_4c_OptDescs.Value   = 1
            THIS.cnt_4c_Etiquetas.obj_4c_OptDescs.Enabled = .F.
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *===========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupClass()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupClass()
        LOCAL loc_oForm, loc_cValor, loc_oErro
        loc_cValor = ALLTRIM(THIS.txt_4c_Class.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCls", "cursor_4c_cls", "cods", loc_cValor, ;
                "Classifica" + CHR(231) + CHR(227) + "o")
            IF !ISNULL(loc_oForm)
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    THIS.txt_4c_Class.Value = ALLTRIM(cursor_4c_cls.cods)
                ELSE
                    IF !loc_oForm.this_lAchouRegistro
                    loc_oForm.mAddColuna("cods", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou
                        THIS.txt_4c_Class.Value = ALLTRIM(cursor_4c_cls.cods)
                    ELSE
                        THIS.txt_4c_Class.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_cls")
                    USE IN cursor_4c_cls
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROCEDURE TxtLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *===========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupLin()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupLin()
        LOCAL loc_oForm, loc_cValor, loc_oErro
        loc_cValor = ALLTRIM(THIS.txt_4c_Lin.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_Lin.Value  = ""
            THIS.txt_4c_DLin.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLin", "cursor_4c_lin", "Linhas", loc_cValor, "Linha")
            IF !ISNULL(loc_oForm)
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    THIS.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_lin.Linhas)
                    THIS.txt_4c_DLin.Value = ALLTRIM(cursor_4c_lin.Descs)
                ELSE
                    IF !loc_oForm.this_lAchouRegistro
                    loc_oForm.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou
                        THIS.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_lin.Linhas)
                        THIS.txt_4c_DLin.Value = ALLTRIM(cursor_4c_lin.Descs)
                    ELSE
                        THIS.txt_4c_Lin.Value  = ""
                        THIS.txt_4c_DLin.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_lin")
                    USE IN cursor_4c_lin
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROCEDURE TxtDLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *===========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDLin()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupDLin()
        LOCAL loc_oForm, loc_cValor, loc_oErro
        loc_cValor = ALLTRIM(THIS.txt_4c_DLin.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_Lin.Value  = ""
            THIS.txt_4c_DLin.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLin", "cursor_4c_lin", "Descs", loc_cValor, "Linha")
            IF !ISNULL(loc_oForm)
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    THIS.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_lin.Linhas)
                    THIS.txt_4c_DLin.Value = ALLTRIM(cursor_4c_lin.Descs)
                ELSE
                    IF !loc_oForm.this_lAchouRegistro
                    loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou
                        THIS.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_lin.Linhas)
                        THIS.txt_4c_DLin.Value = ALLTRIM(cursor_4c_lin.Descs)
                    ELSE
                        THIS.txt_4c_Lin.Value  = ""
                        THIS.txt_4c_DLin.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_lin")
                    USE IN cursor_4c_lin
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROCEDURE TxtCorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *===========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCor()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupCor()
        LOCAL loc_oForm, loc_cValor, loc_oErro
        loc_cValor = ALLTRIM(THIS.txt_4c_Cor.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_Cor.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "cursor_4c_cor", "Cods", loc_cValor, "Cor")
            IF !ISNULL(loc_oForm)
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    THIS.txt_4c_Cor.Value = ALLTRIM(cursor_4c_cor.Cods)
                ELSE
                    IF !loc_oForm.this_lAchouRegistro
                    loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou
                        THIS.txt_4c_Cor.Value = ALLTRIM(cursor_4c_cor.Cods)
                    ELSE
                        THIS.txt_4c_Cor.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_cor")
                    USE IN cursor_4c_cor
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROCEDURE TxtFaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *===========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupFase()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupFase()
        LOCAL loc_oForm, loc_cValor, loc_oErro, loc_lAchou
        loc_cValor = ALLTRIM(THIS.txt_4c_Fase.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_Fase.Value  = ""
            THIS.txt_4c_Dfase.Value = ""
            RETURN
        ENDIF

        TRY
            loc_lAchou = .F.
            IF USED("crGruposBal")
                SELECT crGruposBal
                SET ORDER TO TAG Codigos
                IF SEEK(loc_cValor)
                    THIS.txt_4c_Dfase.Value = ALLTRIM(crGruposBal.Descrs)
                    loc_lAchou = .T.
                ENDIF
            ENDIF
            IF !loc_lAchou
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_gcr", "Codigos", loc_cValor, ;
                    "Cadastro de Grupos")
                IF !ISNULL(loc_oForm)
                    IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                        THIS.txt_4c_Fase.Value  = ALLTRIM(cursor_4c_gcr.Codigos)
                        THIS.txt_4c_Dfase.Value = ALLTRIM(cursor_4c_gcr.Descrs)
                    ELSE
                        IF !loc_oForm.this_lAchouRegistro
                        loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                        loc_oForm.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oForm.Show()
                        IF loc_oForm.this_lSelecionou
                            THIS.txt_4c_Fase.Value  = ALLTRIM(cursor_4c_gcr.Codigos)
                            THIS.txt_4c_Dfase.Value = ALLTRIM(cursor_4c_gcr.Descrs)
                        ELSE
                            THIS.txt_4c_Fase.Value  = ""
                            THIS.txt_4c_Dfase.Value = ""
                        ENDIF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_gcr")
                        USE IN cursor_4c_gcr
                    ENDIF
                    loc_oForm.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROCEDURE TxtDfaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *===========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDfase()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupDfase()
        LOCAL loc_oForm, loc_cValor, loc_oErro, loc_lAchou
        loc_cValor = ALLTRIM(THIS.txt_4c_Dfase.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_Fase.Value  = ""
            THIS.txt_4c_Dfase.Value = ""
            RETURN
        ENDIF

        TRY
            loc_lAchou = .F.
            IF USED("crGruposBal")
                SELECT crGruposBal
                SET ORDER TO TAG Descrs
                IF SEEK(loc_cValor)
                    THIS.txt_4c_Fase.Value  = ALLTRIM(crGruposBal.Codigos)
                    THIS.txt_4c_Dfase.Value = ALLTRIM(crGruposBal.Descrs)
                    loc_lAchou = .T.
                ENDIF
            ENDIF
            IF !loc_lAchou
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_gcr", "Descrs", loc_cValor, ;
                    "Cadastro de Grupos")
                IF !ISNULL(loc_oForm)
                    IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                        THIS.txt_4c_Fase.Value  = ALLTRIM(cursor_4c_gcr.Codigos)
                        THIS.txt_4c_Dfase.Value = ALLTRIM(cursor_4c_gcr.Descrs)
                    ELSE
                        IF !loc_oForm.this_lAchouRegistro
                        loc_oForm.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                        loc_oForm.Show()
                        IF loc_oForm.this_lSelecionou
                            THIS.txt_4c_Fase.Value  = ALLTRIM(cursor_4c_gcr.Codigos)
                            THIS.txt_4c_Dfase.Value = ALLTRIM(cursor_4c_gcr.Descrs)
                        ELSE
                            THIS.txt_4c_Fase.Value  = ""
                            THIS.txt_4c_Dfase.Value = ""
                        ENDIF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_gcr")
                        USE IN cursor_4c_gcr
                    ENDIF
                    loc_oForm.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROCEDURE TxtSeqIniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *===========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF THIS.txt_4c_SeqIni.Value < 0
                MsgAviso("A Seq" + CHR(252) + CHR(234) + "ncia N" + CHR(227) + "o Pode Ser Um N" + CHR(250) + "mero Negativo!!!")
                THIS.txt_4c_SeqIni.Value = 0
                RETURN
            ENDIF
            IF THIS.txt_4c_SeqFim.Value = 0
                THIS.txt_4c_SeqFim.Value = THIS.txt_4c_SeqIni.Value
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE TxtSeqFimKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *===========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF THIS.txt_4c_SeqFim.Value < 0
                MsgAviso("A Seq" + CHR(252) + CHR(234) + "ncia N" + CHR(227) + "o Pode Ser Um N" + CHR(250) + "mero Negativo!!!")
                THIS.txt_4c_SeqFim.Value = 0
                RETURN
            ENDIF
            IF THIS.txt_4c_SeqFim.Value < THIS.txt_4c_SeqIni.Value AND THIS.txt_4c_SeqIni.Value > 0
                MsgAviso("A Seq" + CHR(252) + CHR(234) + "ncia Final N" + CHR(227) + "o Pode Ser Menor Que a Seq" + CHR(252) + CHR(234) + "ncia Inicial!!!")
                THIS.txt_4c_SeqFim.Value = THIS.txt_4c_SeqIni.Value
                RETURN
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE TxtOrdem2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *===========================================================================
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF THIS.txt_4c_Ordem2.Value <> 0 AND ;
               THIS.txt_4c_Ordem2.Value = THIS.txt_4c_Ordem.Value
                MsgAviso("N" + CHR(250) + "mero de OP Inv" + CHR(225) + "lido!!!")
                THIS.txt_4c_Ordem2.Value = 0
                RETURN
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE RelPedidoInteractiveChange()
    *===========================================================================
        LOCAL loc_nPedido
        loc_nPedido = THIS.cnt_4c_Relacao.obj_4c_Get_Pedido.Value
        IF loc_nPedido = 2
            THIS.cnt_4c_Relacao.obj_4c_Get_Barra.Enabled = .T.
        ELSE
            THIS.cnt_4c_Relacao.obj_4c_Get_Barra.Value   = 2
            THIS.cnt_4c_Relacao.obj_4c_Get_Barra.Enabled = .F.
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE AlternarPagina(par_nTipo)
    *===========================================================================
        LOCAL loc_nTipo
        loc_nTipo = IIF(VARTYPE(par_nTipo) = "N", par_nTipo, THIS.obj_4c_Get_Tipo.Value)

        IF INLIST(loc_nTipo, 2, 4)
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Boleto.Visible = .T.
            THIS.cnt_4c_Etiquetas.lbl_4c_Label9.Visible     = .T.
        ELSE
            THIS.cnt_4c_Etiquetas.obj_4c_Get_Boleto.Visible = .F.
            THIS.cnt_4c_Etiquetas.lbl_4c_Label9.Visible     = .F.
        ENDIF

        DO CASE
            CASE loc_nTipo = 1
                THIS.cnt_4c_Etiquetas.Visible  = .F.
                THIS.cnt_4c_Relacao.Visible    = .T.
                THIS.cmd_4c_Visualizar.Enabled = .T.

            CASE INLIST(loc_nTipo, 3, 4) AND THIS.txt_4c_Ordem2.Value > 0
                THIS.cnt_4c_Etiquetas.Visible  = .T.
                THIS.cnt_4c_Relacao.Visible    = .F.

            CASE loc_nTipo = 5
                THIS.cnt_4c_Etiquetas.Visible  = .F.
                THIS.cnt_4c_Relacao.Visible    = .F.
                THIS.cmd_4c_Visualizar.Enabled = .F.

            OTHERWISE
                THIS.cnt_4c_Etiquetas.Visible  = .T.
                THIS.cnt_4c_Relacao.Visible    = .F.
                THIS.cmd_4c_Visualizar.Enabled = .T.
        ENDCASE
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Form OPERACIONAL (relatorio): "Salvar" dispara a impressao
    * efetiva. Mantido para compatibilidade com pipeline CRUD generico (Fase 8).
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        IF !THIS.ValidarEntrada()
            RETURN
        ENDIF
        THIS.BtnImprimirClick()
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Form OPERACIONAL: reseta os filtros e parametros
    * iniciais sem encerrar o formulario. Equivalente ao botao "Cancelar"
    * de telas CRUD, mantido para compatibilidade com pipeline (Fase 8).
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.AplicarParametrosIniciais()
        THIS.HabilitarCampos()
        THIS.txt_4c_Ordem.SetFocus()
    ENDPROC

    *===========================================================================
    * CarregarLista - Form OPERACIONAL (relatorio): nao possui grid de
    * listagem de registros. Garante que parametros recebidos via Init
    * e estado dos botoes Imprimir/Visualizar estejam corretos. Mantido
    * para compatibilidade com pipeline CRUD generico (Fase 8).
    *===========================================================================
    PROCEDURE CarregarLista()
        THIS.AplicarParametrosIniciais()
        THIS.HabilitarCampos()
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Form OPERACIONAL: nao tem modos INCLUIR/ALTERAR/
    * VISUALIZAR/EXCLUIR; os botoes Imprimir/Visualizar/Encerrar estao sempre
    * disponiveis (controle fino feito em HabilitarCampos via tipo selecionado).
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos()
    ENDPROC

    *===========================================================================
    PROCEDURE Destroy()
    *===========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("crGruposBal")
            USE IN crGruposBal
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
