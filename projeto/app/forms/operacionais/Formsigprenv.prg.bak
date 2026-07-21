*==============================================================================
* Formsigprenv.prg - Impressao de Etiquetas de Envelopes
* Tipo: OPERACIONAL
* Form original: SIGPRENV.SCX
*==============================================================================
DEFINE CLASS Formsigprenv AS FormBase

    Width        = 800
    Height       = 400
    AutoCenter   = .T.
    TitleBar     = 0
    BorderStyle  = 2
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    DataSession  = 2

    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Impress" + CHR(227) + "o de etiquetas de envelopes"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("sigprenvBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.TornarControlesVisiveis(THIS)
                THIS.CarregarDados()
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object sigprenvBO", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Coordenador de layout do form OPERACIONAL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarControlesImpressora()
        THIS.ConfigurarEventos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cabecalho e botoes de acao (Imprimir/Encerrar)
    * Em forms OPERACIONAIS de impressao nao existe grid/lista de registros -
    * este metodo agrupa o bloco de topo (equivalente semantico da "Page1"
    * dos forms CRUD): titulos + botoes que disparam a acao do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoesReport()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulos (cntSombra)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesReport - CommandGroup com botoes Imprimir e Encerrar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesReport()
        THIS.AddObject("obj_4c_BtnReport", "CommandGroup")
        WITH THIS.obj_4c_BtnReport
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 110
            .Left          = 636
            .SpecialEffect = 1
            .Top           = -2
            .Width         = 171
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 10
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                .Caption    = "\<Imprimir"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 86
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Primeira metade dos controles do form OPERACIONAL
    * Layout fiel ao SIGPRENV.SCX: TextBoxes Etiqueta Inicial e Quantidade,
    * Label e OptionGroup Tipo de etiqueta.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- Label e TextBox Etiqueta Inicial
        THIS.AddObject("lbl_4c_Lbl_Etq", "Label")
        WITH THIS.lbl_4c_Lbl_Etq
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Etiqueta Inicial :"
            .Height    = 15
            .Left      = 155
            .Top       = 129
            .Width     = 79
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Etq_Ini", "TextBox")
        WITH THIS.txt_4c_Etq_Ini
            .FontName            = "Tahoma"
            .FontSize            = 8
            .Height              = 23
            .InputMask           = "99999999"
            .Left                = 237
            .Top                 = 125
            .Width               = 66
            .Value               = 0
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *-- Label e TextBox Quantidade
        THIS.AddObject("lbl_4c_Lbl_Qtd", "Label")
        WITH THIS.lbl_4c_Lbl_Qtd
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Quantidade :"
            .Height    = 15
            .Left      = 328
            .Top       = 129
            .Width     = 65
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Etq_Qtd", "TextBox")
        WITH THIS.txt_4c_Etq_Qtd
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Format    = "K!"
            .Height    = 23
            .InputMask = "99999999"
            .MaxLength = 8
            .Left      = 397
            .Top       = 125
            .Width     = 66
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Label Tipo de etiqueta
        THIS.AddObject("lbl_4c_Lbl_TpEti", "Label")
        WITH THIS.lbl_4c_Lbl_TpEti
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Tipo de etiqueta "
            .Height    = 15
            .Left      = 150
            .Top       = 166
            .Width     = 97
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Tipo de etiqueta (botoes populados dinamicamente em CarregarDados)
        THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
        WITH THIS.obj_4c_Opt_Tipo
            .AutoSize      = .F.
            .ButtonCount   = 1
            .BackStyle     = 0
            .Height        = 182
            .Left          = 140
            .SpecialEffect = 1
            .Top           = 179
            .Width         = 240
            .Themes        = .F.
            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "\<a. Rabicho"
                .Height    = 22
                .Left      = 10
                .Style     = 0
                .Top       = 10
                .Width     = 222
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Value   = 1
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControlesImpressora - Segunda metade dos controles do form
    * OPERACIONAL: Label e OptionGroup Impressora, Container de ajustes com
    * spinners de posicao/densidade/velocidade e protocolo de impressao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControlesImpressora()

        *-- Label Impressora
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Impressora "
            .Height    = 15
            .Left      = 409
            .Top       = 167
            .Width     = 71
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Impressora (botoes populados dinamicamente em CarregarDados)
        THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
        WITH THIS.obj_4c_Opt_Impressora
            .AutoSize      = .F.
            .ButtonCount   = 1
            .BackStyle     = 0
            .Height        = 105
            .Left          = 396
            .SpecialEffect = 1
            .Top           = 180
            .Width         = 254
            .Themes        = .F.
            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = " \<1. Gen" + CHR(233) + "rico/Somente Texto"
                .Height    = 17
                .Left      = 10
                .Style     = 0
                .Top       = 10
                .Width     = 238
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Value   = 1
            .Visible = .T.
        ENDWITH

        *-- Container Ajustes Impressora (Cnt_Impressora)
        THIS.AddObject("cnt_4c__Impressora", "Container")
        WITH THIS.cnt_4c__Impressora
            .Top         = 289
            .Left        = 396
            .Width       = 254
            .Height      = 67
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            *-- Labels dos spinners
            .AddObject("lbl_4c_Say2", "Label")
            WITH .lbl_4c_Say2
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Caption   = "Vertical"
                .Height    = 13
                .Left      = 12
                .Top       = 25
                .Width     = 33
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Say3", "Label")
            WITH .lbl_4c_Say3
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Caption   = "Horizontal"
                .Height    = 13
                .Left      = 72
                .Top       = 25
                .Width     = 50
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Say1", "Label")
            WITH .lbl_4c_Say1
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Caption   = "Densidade"
                .Height    = 13
                .Left      = 132
                .Top       = 25
                .Width     = 50
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Say20", "Label")
            WITH .lbl_4c_Say20
                .FontName  = "Tahoma"
                .FontSize  = 7
                .BackStyle = 0
                .Caption   = "Velocidade"
                .Height    = 13
                .Left      = 192
                .Top       = 25
                .Width     = 55
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Spinners de ajuste
            .AddObject("obj_4c_Spn_AjVerts", "Spinner")
            WITH .obj_4c_Spn_AjVerts
                .FontName          = "Tahoma"
                .Height            = 26
                .KeyboardHighValue = 999
                .KeyboardLowValue  = 0
                .Left              = 10
                .SpinnerHighValue  = 999
                .SpinnerLowValue   = 0
                .Top               = 36
                .Width             = 56
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            .AddObject("obj_4c_Spn_AjHorzs", "Spinner")
            WITH .obj_4c_Spn_AjHorzs
                .FontName          = "Tahoma"
                .Height            = 26
                .KeyboardHighValue = 999
                .KeyboardLowValue  = 0
                .Left              = 71
                .SpinnerHighValue  = 999
                .SpinnerLowValue   = 0
                .Top               = 36
                .Width             = 56
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            .AddObject("obj_4c_Spn_AjDenss", "Spinner")
            WITH .obj_4c_Spn_AjDenss
                .FontName          = "Tahoma"
                .Height            = 26
                .KeyboardHighValue = 20
                .KeyboardLowValue  = 10
                .Left              = 132
                .SpinnerHighValue  = 20
                .SpinnerLowValue   = 10
                .Top               = 36
                .Width             = 56
                .Value             = 10
                .Visible           = .T.
            ENDWITH

            .AddObject("obj_4c_Spn_AjVelos", "Spinner")
            WITH .obj_4c_Spn_AjVelos
                .FontName          = "Tahoma"
                .Height            = 26
                .KeyboardHighValue = 3
                .KeyboardLowValue  = 1
                .Left              = 192
                .SpinnerHighValue  = 3
                .SpinnerLowValue   = 1
                .Top               = 36
                .Width             = 54
                .Value             = 3
                .Visible           = .T.
            ENDWITH

            *-- OptionGroup protocolo de impressao (Allegro / Zebra ZPL / Zebra EPL)
            .AddObject("obj_4c_Opcao_imp", "OptionGroup")
            WITH .obj_4c_Opcao_imp
                .AutoSize    = .F.
                .ButtonCount = 3
                .Height      = 22
                .Left        = 3
                .Top         = 3
                .Width       = 249
                .Enabled     = .F.
                WITH .Buttons(1)
                    .BackStyle = 0
                    .Caption   = "Allegro"
                    .Left      = 3
                    .Top       = 4
                    .Width     = 51
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(2)
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Zebra ZPL"
                    .Left      = 77
                    .Top       = 4
                    .Width     = 66
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(3)
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = "Zebra EPL"
                    .Height    = 15
                    .Left      = 170
                    .Top       = 4
                    .Width     = 66
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                .Value   = 1
                .Visible = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Registra BINDEVENTs para controles do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.obj_4c_BtnReport.Buttons(1), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.obj_4c_BtnReport.Buttons(2), "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.obj_4c_Opt_Impressora, "InteractiveChange", THIS, "ObjOptImpressoraInteractiveChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega tipos de etiqueta e impressoras dinamicamente
    * Replica logica do Init() legado: APrinters + SigCdTpe + SigCdMp + SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_nTipos, loc_laSysPrn(1, 4), loc_laPrnNames(1), loc_nPrinters
        LOCAL loc_lnI, loc_lnTop, loc_lnHeight, loc_lnBottom1, loc_lnBottom2
        LOCAL loc_nMaxTipos, loc_oBtn, loc_nOk, loc_laImpOk(100)
        LOCAL loc_lnImpOkCount, loc_lSucesso, loc_oErro, loc_oOptTipo, loc_oOptImp

        loc_lSucesso     = .F.
        loc_lnBottom1    = 0
        loc_lnBottom2    = 0
        loc_lnImpOkCount = 0

        TRY
            *-- 1. Parametros gerais de SigCdPam e SigCdPac
            THIS.this_oBusinessObject.CarregarParametros()

            *-- 2. Tipos de etiqueta de SigCdTpe (nTipos=6, nSituas=1)
            loc_nTipos = THIS.this_oBusinessObject.CarregarTiposEtiqueta()

            *-- 3. Impressoras instaladas no sistema via APrinters()
            loc_nPrinters = APrinters(loc_laSysPrn)
            DIMENSION loc_laPrnNames(MAX(loc_nPrinters, 1))
            IF loc_nPrinters > 0
                LOCAL loc_nPi
                FOR loc_nPi = 1 TO loc_nPrinters
                    loc_laSysPrn(loc_nPi, 1) = UPPER(ALLTRIM(loc_laSysPrn(loc_nPi, 1)))
                    loc_laPrnNames(loc_nPi)   = loc_laSysPrn(loc_nPi, 1)
                ENDFOR
            ENDIF

            *-- 4. Impressoras autorizadas do usuario em SigSyImp + SigCdAcG
            THIS.this_oBusinessObject.CarregarImpressoras(gc_4c_UsuarioLogado)

            *-- 5. INDEX em cursor_4c_Imp para scan por nTpImpres
            IF USED("cursor_4c_Imp")
                SELECT cursor_4c_Imp
                GO TOP
            ENDIF

            *-- 6. Preencher obj_4c_Opt_Tipo com tipos de etiqueta do cursor
            loc_oOptTipo = THIS.obj_4c_Opt_Tipo
            loc_lnTop    = 10
            loc_lnHeight = 40
            loc_lnI      = 1

            IF loc_nTipos > 0
                loc_nMaxTipos = MIN(loc_nTipos, MAX(THIS.this_oBusinessObject.this_nMaxTpEtis, 5))
                loc_oOptTipo.ButtonCount = loc_nMaxTipos
                IF USED("cursor_4c_Tpe")
                    SELECT cursor_4c_Tpe
                    GO TOP
                    SCAN WHILE !EOF() AND loc_lnI <= loc_nMaxTipos
                        loc_oBtn           = loc_oOptTipo.Buttons(loc_lnI)
                        loc_oBtn.AutoSize  = .F.
                        loc_oBtn.Width     = 160
                        loc_oBtn.Caption   = "\<" + CHR(96 + loc_lnI) + ". " + ALLTRIM(cEtiquetas)
                        loc_oBtn.FontSize  = 8
                        loc_oBtn.Tag       = ALLTRIM(STR(nTipos))
                        loc_oBtn.Top       = loc_lnTop
                        loc_oBtn.BackStyle = 0
                        loc_oBtn.ForeColor = RGB(90, 90, 90)
                        loc_lnI      = loc_lnI + 1
                        loc_lnTop    = loc_lnTop + 20
                        loc_lnHeight = loc_lnHeight + 20
                    ENDSCAN
                ENDIF
            ELSE
                loc_oOptTipo.ButtonCount = 1
                loc_oBtn           = loc_oOptTipo.Buttons(1)
                loc_oBtn.AutoSize  = .F.
                loc_oBtn.Width     = 160
                loc_oBtn.Caption   = "\<1. Envelope"
                loc_oBtn.FontSize  = 8
                loc_oBtn.Tag       = "6"
                loc_oBtn.Top       = loc_lnTop
                loc_oBtn.BackStyle = 0
                loc_oBtn.ForeColor = RGB(90, 90, 90)
                loc_lnTop    = loc_lnTop + 20
                loc_lnHeight = loc_lnHeight + 20
            ENDIF
            loc_oOptTipo.Enabled = (loc_oOptTipo.ButtonCount > 1)
            loc_oOptTipo.Height  = loc_lnHeight
            loc_oOptTipo.Value   = 1
            loc_lnBottom1 = loc_oOptTipo.Top + loc_oOptTipo.Height

            *-- 7. Construir lista de impressoras termicas instaladas (nTpImpres=2)
            IF loc_nPrinters > 0 AND USED("cursor_4c_Imp")
                SELECT cursor_4c_Imp
                GO TOP
                SCAN
                    IF nTpImpres = 2
                        loc_nOk = ASCAN(loc_laPrnNames, UPPER(ALLTRIM(Impres)))
                        IF loc_nOk > 0 AND loc_lnImpOkCount < 100
                            loc_lnImpOkCount = loc_lnImpOkCount + 1
                            loc_laImpOk(loc_lnImpOkCount) = UPPER(ALLTRIM(Impres))
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 8. Preencher obj_4c_Opt_Impressora dinamicamente
            loc_oOptImp  = THIS.obj_4c_Opt_Impressora
            loc_lnTop    = 10
            loc_lnHeight = 15

            IF loc_lnImpOkCount > 0
                loc_oOptImp.ButtonCount = MIN(loc_lnImpOkCount, MAX(THIS.this_oBusinessObject.this_nMaxImpEti, 5))
                LOCAL loc_lnIi
                FOR loc_lnIi = 1 TO loc_oOptImp.ButtonCount
                    loc_oBtn           = loc_oOptImp.Buttons(loc_lnIi)
                    loc_oBtn.AutoSize  = .F.
                    loc_oBtn.Caption   = " \<" + ALLTRIM(STR(loc_lnIi)) + ". " + loc_laImpOk(loc_lnIi)
                    loc_oBtn.FontSize  = 8
                    loc_oBtn.Tag       = loc_laImpOk(loc_lnIi)
                    loc_oBtn.Top       = loc_lnTop
                    loc_oBtn.Width     = 160
                    loc_oBtn.BackStyle = 0
                    loc_oBtn.ForeColor = RGB(90, 90, 90)
                    loc_lnTop    = loc_lnTop + 20
                    loc_lnHeight = loc_lnHeight + 20
                ENDFOR
            ELSE
                *-- Fallback: impressora generica do sistema
                loc_oOptImp.ButtonCount = 1
                loc_nOk  = ASCAN(loc_laPrnNames, "GEN" + CHR(201) + "RICO/SOMENTE TEXTO")
                loc_oBtn = loc_oOptImp.Buttons(1)
                loc_oBtn.AutoSize  = .F.
                loc_oBtn.Caption   = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
                loc_oBtn.Enabled   = (loc_nOk > 0)
                loc_oBtn.FontSize  = 8
                loc_oBtn.Tag       = "GEN" + CHR(201) + "RICO/SOMENTE TEXTO"
                loc_oBtn.Width     = 160
                loc_oBtn.BackStyle = 0
                loc_oBtn.ForeColor = RGB(90, 90, 90)
                loc_lnHeight = loc_lnHeight + 20
                IF loc_nOk > 0
                    loc_lnImpOkCount = 1
                ENDIF
            ENDIF
            loc_oOptImp.Enabled = (loc_lnImpOkCount > 1)
            loc_oOptImp.Height  = loc_lnHeight
            loc_oOptImp.Value   = 1

            *-- 9. Reposiciona cnt_4c__Impressora abaixo de Opt_Impressora
            THIS.cnt_4c__Impressora.Top = loc_oOptImp.Top + loc_oOptImp.Height - 2
            loc_lnBottom2 = THIS.cnt_4c__Impressora.Top + THIS.cnt_4c__Impressora.Height

            *-- 10. Ajusta altura do form ao conteudo dinamico
            THIS.Height = MAX(loc_lnBottom1, loc_lnBottom2) + 10

            *-- 11. Habilita botao Imprimir somente se ha tipos e impressora disponivel
            THIS.obj_4c_BtnReport.Buttons(1).Enabled = (loc_nTipos > 0 AND loc_lnImpOkCount > 0)
            THIS.obj_4c_BtnReport.Value = IIF(THIS.obj_4c_BtnReport.Buttons(1).Enabled, 1, 2)

            *-- 12. Inicializa cursor de impressao vazio
            THIS.this_oBusinessObject.InicializarCursorImpressao()

            *-- 13. Valor inicial de Etq_Ini
            THIS.txt_4c_Etq_Ini.Value = 1

            *-- 14. Carrega configuracoes da impressora inicial selecionada
            THIS.ObjOptImpressoraInteractiveChange()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao Carregar Dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Nao aplicavel (form OPERACIONAL sem PageFrame)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Nao aplicavel (form OPERACIONAL de impressao de etiquetas)
    * Encaminha para BtnImprimirClick que eh a acao principal do form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Nao aplicavel (form OPERACIONAL sem CRUD)
    * Reposiciona foco no campo Etiqueta Inicial para novo ajuste de lote.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.txt_4c_Etq_Ini.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Nao aplicavel (form OPERACIONAL sem CRUD)
    * Exibe resumo da configuracao atual de impressao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cResumo, loc_cImp
        IF THIS.obj_4c_Opt_Impressora.ButtonCount > 0
            loc_cImp = ALLTRIM(THIS.obj_4c_Opt_Impressora.Buttons(THIS.obj_4c_Opt_Impressora.Value).Tag)
        ELSE
            loc_cImp = "(nenhuma)"
        ENDIF
        loc_cResumo = "Impressora: " + loc_cImp + CHR(13) + ;
                      "Etiqueta Inicial: " + TRANSFORM(THIS.txt_4c_Etq_Ini.Value) + CHR(13) + ;
                      "Quantidade: " + TRANSFORM(THIS.txt_4c_Etq_Qtd.Value)
        MsgInfo(loc_cResumo, "Configura" + CHR(231) + CHR(227) + "o Atual")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Nao aplicavel (form OPERACIONAL sem CRUD)
    * Limpa os campos de quantidade e reseta contador para novo lote.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.txt_4c_Etq_Qtd.Value = 0
        THIS.txt_4c_Etq_Ini.Value = 1
        THIS.this_oBusinessObject.LimparImpressao()
        THIS.txt_4c_Etq_Qtd.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Valida e envia etiquetas para impressao
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_nEtqIni, loc_nEtqQtd, loc_nTpImp, loc_nAjVerts
        LOCAL loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos, loc_cNomeImp
        LOCAL loc_nImpres, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Valida quantidade > 0
        IF THIS.txt_4c_Etq_Qtd.Value <= 0
            MsgAviso("A Quantidade de Etiquetas Precisa Ser Maior Que 0 (Zero)!!!", "")
            THIS.txt_4c_Etq_Qtd.SetFocus
            RETURN
        ENDIF

        *-- Confirma impressao
        IF !MsgConfirma("Confirma a Impress" + CHR(227) + "o Das Etiquetas ?", "Confirmar")
            RETURN
        ENDIF

        loc_nEtqIni = THIS.txt_4c_Etq_Ini.Value
        loc_nEtqQtd = THIS.txt_4c_Etq_Qtd.Value

        *-- Prepara itens no cursor de impressao
        IF !THIS.this_oBusinessObject.PrepararImpressao(loc_nEtqIni, loc_nEtqQtd)
            RETURN
        ENDIF

        *-- Coleta configuracoes do container de impressora
        WITH THIS.cnt_4c__Impressora
            loc_nTpImp   = .obj_4c_Opcao_imp.Value
            loc_nAjVerts = .obj_4c_Spn_AjVerts.Value
            loc_nAjHorzs = .obj_4c_Spn_AjHorzs.Value
            loc_nAjDenss = .obj_4c_Spn_AjDenss.Value
            loc_nAjVelos = .obj_4c_Spn_AjVelos.Value
            .Visible     = .T.
        ENDWITH

        WITH THIS.obj_4c_Opt_Impressora
            loc_nImpres  = .Value
            loc_cNomeImp = .Buttons(loc_nImpres).Tag
        ENDWITH

        *-- Executa impressao via SigOpEtq (funcao do framework legado)
        TRY
            SigOpEtq(gnConnHandle, .F., .F., 6, loc_nTpImp, ;
                     loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, ;
                     .NULL., .NULL., .NULL., loc_cNomeImp, .NULL., .NULL., loc_nAjVelos)

            MsgInfo("Impress" + CHR(227) + "o conclu" + CHR(237) + "da com sucesso!", "Aviso")

            *-- Atualiza contador e reseta quantidade para proximo lote
            THIS.txt_4c_Etq_Ini.Value = loc_nEtqIni + loc_nEtqQtd
            THIS.txt_4c_Etq_Qtd.Value = 0
            THIS.txt_4c_Etq_Ini.Refresh
            THIS.txt_4c_Etq_Qtd.Refresh
            THIS.txt_4c_Etq_Qtd.SetFocus

            THIS.this_oBusinessObject.LimparImpressao()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ao Imprimir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObjOptImpressoraInteractiveChange - Recarrega config ao trocar impressora
    *--------------------------------------------------------------------------
    PROCEDURE ObjOptImpressoraInteractiveChange()
        LOCAL loc_nSel, loc_cNomeImp
        loc_nSel = THIS.obj_4c_Opt_Impressora.Value
        IF loc_nSel > 0 AND loc_nSel <= THIS.obj_4c_Opt_Impressora.ButtonCount
            loc_cNomeImp = THIS.obj_4c_Opt_Impressora.Buttons(loc_nSel).Tag
            THIS.CarregarOpcaoImpressora(loc_cNomeImp)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOpcaoImpressora - Carrega ajustes da impressora selecionada
    * Equivalente ao fCarregarImps do framework legado.
    * Tenta buscar overrides em SigCdMp; fallback nos valores de SigCdPam.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarOpcaoImpressora(par_cNomeImpressora)
        LOCAL loc_cSQL, loc_nOpcao, loc_nAjVerts, loc_nAjHorzs, loc_oErro
        LOCAL loc_lCarregouBD

        loc_lCarregouBD = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 nTpImpres, AjVerts, AjHorzs " + ;
                       "FROM SigCdMp " + ;
                       "WHERE UPPER(RTRIM(Impres)) = " + ;
                       EscaparSQL(UPPER(ALLTRIM(par_cNomeImpressora)))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpConfig") > 0
                IF USED("cursor_4c_ImpConfig") AND !EOF("cursor_4c_ImpConfig")
                    SELECT cursor_4c_ImpConfig
                    GO TOP
                    loc_nOpcao   = NVL(nTpImpres, 1)
                    loc_nAjVerts = NVL(AjVerts, THIS.this_oBusinessObject.this_nAjVerts)
                    loc_nAjHorzs = NVL(AjHorzs, THIS.this_oBusinessObject.this_nAjHorzs)
                    loc_lCarregouBD = .T.
                ENDIF
                IF USED("cursor_4c_ImpConfig")
                    USE IN cursor_4c_ImpConfig
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Coluna pode nao existir em SigCdMp desta versao; usa padrao
        ENDTRY

        *-- Aplica valores: BD se carregou, senao padrao de SigCdPam
        IF !loc_lCarregouBD
            loc_nOpcao   = THIS.this_oBusinessObject.this_nImpEtis
            loc_nAjVerts = THIS.this_oBusinessObject.this_nAjVerts
            loc_nAjHorzs = THIS.this_oBusinessObject.this_nAjHorzs
        ENDIF

        IF loc_nOpcao < 1 OR loc_nOpcao > 3
            loc_nOpcao = 1
        ENDIF

        WITH THIS.cnt_4c__Impressora
            .obj_4c_Opcao_imp.Value   = loc_nOpcao
            .obj_4c_Opcao_imp.Enabled = .F.
            .obj_4c_Spn_AjVerts.Value = loc_nAjVerts
            .obj_4c_Spn_AjHorzs.Value = loc_nAjHorzs
            .obj_4c_Spn_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDenss
            .obj_4c_Spn_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelos
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

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

    *--------------------------------------------------------------------------
    * FormParaBO - Mapeia controles do form para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_nEtqIni = THIS.txt_4c_Etq_Ini.Value
            .this_nEtqQtd = THIS.txt_4c_Etq_Qtd.Value

            IF THIS.obj_4c_Opt_Tipo.ButtonCount >= THIS.obj_4c_Opt_Tipo.Value AND ;
               THIS.obj_4c_Opt_Tipo.Value > 0
                .this_nTipoEtq = ALLTRIM(THIS.obj_4c_Opt_Tipo.Buttons(THIS.obj_4c_Opt_Tipo.Value.Tag))
            ENDIF

            IF THIS.obj_4c_Opt_Impressora.ButtonCount >= THIS.obj_4c_Opt_Impressora.Value AND ;
               THIS.obj_4c_Opt_Impressora.Value > 0
                .this_cNomeImpressora = ALLTRIM(THIS.obj_4c_Opt_Impressora.Buttons(THIS.obj_4c_Opt_Impressora.Value).Tag)
            ENDIF

            WITH THIS.cnt_4c__Impressora
                .this_nOpcaoImp = .obj_4c_Opcao_imp.Value
                .this_nAjVerts  = .obj_4c_Spn_AjVerts.Value
                .this_nAjHorzs  = .obj_4c_Spn_AjHorzs.Value
                .this_nAjDenss  = .obj_4c_Spn_AjDenss.Value
                .this_nAjVelos  = .obj_4c_Spn_AjVelos.Value
                .Visible     = .T.
            ENDWITH
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Mapeia propriedades do BO de volta para os controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        WITH THIS.this_oBusinessObject
            THIS.txt_4c_Etq_Ini.Value = .this_nEtqIni
            THIS.txt_4c_Etq_Qtd.Value = .this_nEtqQtd

            WITH THIS.cnt_4c__Impressora
                IF .this_nOpcaoImp >= 1 AND .this_nOpcaoImp <= 3
                    .obj_4c_Opcao_imp.Value = .this_nOpcaoImp
                ENDIF
                .obj_4c_Spn_AjVerts.Value = .this_nAjVerts
                .obj_4c_Spn_AjHorzs.Value = .this_nAjHorzs
                .obj_4c_Spn_AjDenss.Value = .this_nAjDenss
                .obj_4c_Spn_AjVelos.Value = .this_nAjVelos
                .Visible     = .T.
            ENDWITH
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de entrada do form
    * par_lHabilitar: .T. habilita, .F. desabilita
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        THIS.txt_4c_Etq_Ini.Enabled = par_lHabilitar
        THIS.txt_4c_Etq_Qtd.Enabled = par_lHabilitar
        THIS.obj_4c_BtnReport.Buttons(1).Enabled = par_lHabilitar AND ;
            THIS.obj_4c_BtnReport.Buttons(1).Enabled
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa/reseta os campos de entrada do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c_Etq_Ini.Value = 1
        THIS.txt_4c_Etq_Qtd.Value = 0
        THIS.this_oBusinessObject.LimparImpressao()
        THIS.txt_4c_Etq_Qtd.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel (form OPERACIONAL sem grid de lista)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel (form OPERACIONAL sem modo CRUD)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega dados de tipos e impressoras
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Equivalente a Imprimir neste form OPERACIONAL
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa campos e reseta para novo lote
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
