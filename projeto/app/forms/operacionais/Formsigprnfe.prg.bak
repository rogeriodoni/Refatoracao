*==============================================================================
* Formsigprnfe.prg - Processamento de NF-e
* Herda de: FormBase
* Tipo: OPERACIONAL (layout flat customizado, sem PageFrame)
* BO: sigprnfeBO
* Migrado de: SIGPRNFE.SCX (Framework Fortyus)
*==============================================================================
DEFINE CLASS Formsigprnfe AS FormBase

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    ShowTips     = .T.
    BorderStyle  = 2
    WindowType   = 1
    ShowWindow   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    DataSession  = 2
    KeyPreview   = .T.

    pMovimentacao      = ""
    pSerie             = ""
    this_cMensagemErro = ""

    *==========================================================================
    PROCEDURE Init(par_cMovimentacao, par_cSerie, par_cOperas)
    *==========================================================================
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprnfeBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigprnfeBO.", ;
                        "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF VARTYPE(par_cMovimentacao) = "C"
                    THIS.pMovimentacao = ALLTRIM(par_cMovimentacao)
                ENDIF
                IF VARTYPE(par_cSerie) = "C"
                    THIS.pSerie = ALLTRIM(par_cSerie)
                ENDIF
                loc_lResultado = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        THIS.Caption = "Processamento de NF-e"
        TRY
            SET NULL ON
            IF USED("csOperacoes")
                USE IN csOperacoes
            ENDIF
            CREATE CURSOR csOperacoes (SelImp l(1), Emps c(3), Dopes c(20), ;
                Numes n(6,0), Datas d(8), Valos n(12,2), Notas c(10), Series c(3), ;
                NFMemo m(4), Erros m(4), Tipos n(1), stats c(3), ids c(47), ;
                lotes c(15), recibos c(15), prots c(15), statts c(1))
            INDEX ON Notas+Emps+Dopes+STR(Numes,6) TAG Notas
            SET NULL OFF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarOperacoes()
            THIS.ConfigurarGrade()
            THIS.ConfigurarBotoesForm()
            THIS.ConfigurarBotoesGrade()
            THIS.ConfigurarCntInu()
            THIS.TornarControlesVisiveis()
            THIS.ConfigurarBINDEVENTs()

            IF !EMPTY(THIS.pMovimentacao)
                THIS.BtnSelecionarClick(.T.)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar form")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        LOCAL loc_cCaption, loc_oCnt
        loc_cCaption = "Processamento de NF-e"
        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = 1004
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCnt.lbl_4c_Sombra
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Caption   = loc_cCaption
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = THIS.Width
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Caption   = loc_cCaption
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = THIS.Width
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOperacoes()
    *==========================================================================
        LOCAL loc_oCnt, loc_oOpt

        THIS.AddObject("cnt_4c_Operacoes", "Container")
        loc_oCnt = THIS.cnt_4c_Operacoes
        WITH loc_oCnt
            .Top          = 83
            .Left         = 4
            .Width        = 824
            .Height       = 161
            .BorderWidth  = 0
            .SpecialEffect = 0
            .BackStyle    = 1
            .BackColor    = RGB(240, 240, 240)
        ENDWITH

        *-- Labels descritivos
        loc_oCnt.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oCnt.lbl_4c_LblEmpresa
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 35
            .Top       = 6
            .Width     = 55
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSerie", "Label")
        WITH loc_oCnt.lbl_4c_LblSerie
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "S" + CHR(233) + "rie :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 135
            .Top       = 6
            .Width     = 40
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblDtEmis", "Label")
        WITH loc_oCnt.lbl_4c_LblDtEmis
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Data de Emiss" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 223
            .Top       = 6
            .Width     = 105
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblAte", "Label")
        WITH loc_oCnt.lbl_4c_LblAte
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 416
            .Top       = 6
            .Width     = 10
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblNotas", "Label")
        WITH loc_oCnt.lbl_4c_LblNotas
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Notas Fiscais :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 14
            .Top       = 33
            .Width     = 75
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblMovimento", "Label")
        WITH loc_oCnt.lbl_4c_LblMovimento
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Movimento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 517
            .Top       = 6
            .Width     = 61
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblAmbiente", "Label")
        WITH loc_oCnt.lbl_4c_LblAmbiente
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Ambiente :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 31
            .Top       = 59
            .Width     = 54
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblVersao", "Label")
        WITH loc_oCnt.lbl_4c_LblVersao
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Versao :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 283
            .Top       = 61
            .Width     = 42
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblImpressao", "Label")
        WITH loc_oCnt.lbl_4c_LblImpressao
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Impress" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 499
            .Top       = 59
            .Width     = 65
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSituacao", "Label")
        WITH loc_oCnt.lbl_4c_LblSituacao
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 35
            .Top       = 83
            .Width     = 50
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblRegime", "Label")
        WITH loc_oCnt.lbl_4c_LblRegime
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Regime Tribut" + CHR(225) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 465
            .Top       = 83
            .Width     = 93
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblAcao", "Label")
        WITH loc_oCnt.lbl_4c_LblAcao
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "A" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 52
            .Top       = 107
            .Width     = 33
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblInuDe", "Label")
        WITH loc_oCnt.lbl_4c_LblInuDe
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Inutilizar de :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 493
            .Top       = 108
            .Width     = 75
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblInuAte", "Label")
        WITH loc_oCnt.lbl_4c_LblInuAte
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 672
            .Top       = 108
            .Width     = 10
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblConting", "Label")
        WITH loc_oCnt.lbl_4c_LblConting
            .AutoSize  = .F.
            .BackStyle = 0
            .Caption   = "Conting" + CHR(234) + "ncia :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 14
            .Top       = 146
            .Width     = 75
        ENDWITH

        *-- TextBoxes de filtro
        loc_oCnt.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oCnt.txt_4c_Emps
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 93
            .Top           = 2
            .Width         = 34
            .MaxLength     = 3
            .SpecialEffect = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Series", "TextBox")
        WITH loc_oCnt.txt_4c_Series
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 178
            .Top           = 2
            .Width         = 34
            .MaxLength     = 3
            .SpecialEffect = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oCnt.txt_4c_DtIni
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 331
            .Top           = 2
            .Width         = 82
            .Value         = {}
            .SpecialEffect = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DtFin", "TextBox")
        WITH loc_oCnt.txt_4c_DtFin
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 428
            .Top           = 2
            .Width         = 82
            .Value         = {}
            .SpecialEffect = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Arquivos", "TextBox")
        WITH loc_oCnt.txt_4c_Arquivos
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Height             = 23
            .Left               = 93
            .Top                = 29
            .Width              = 636
            .ReadOnly           = .T.
            .SpecialEffect      = 1
            .DisabledBackColor  = RGB(255,255,255)
            .DisabledForeColor  = RGB(0,0,0)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_InuIni", "TextBox")
        WITH loc_oCnt.txt_4c_InuIni
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Height            = 23
            .Left              = 572
            .Top               = 104
            .Width             = 91
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255,255,255)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_InuFim", "TextBox")
        WITH loc_oCnt.txt_4c_InuFim
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Height            = 23
            .Left              = 687
            .Top               = 104
            .Width             = 91
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255,255,255)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_IniContin", "TextBox")
        WITH loc_oCnt.txt_4c_IniContin
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 20
            .Left          = 361
            .Top           = 141
            .Width         = 80
            .Value         = {}
            .SpecialEffect = 1
        ENDWITH

        *-- ComboBox Regime Tributario
        loc_oCnt.AddObject("cmb_4c_Regime", "ComboBox")
        WITH loc_oCnt.cmb_4c_Regime
            .FontName      = "Arial"
            .FontSize      = 8
            .Height        = 22
            .Left          = 572
            .Top           = 79
            .Width         = 206
            .RowSourceType = 1
            .RowSource     = "Simples Nacional,Lucro Presumido,Lucro Real,Lucro Arbitrado"
            .Style         = 2
        ENDWITH

        *-- CheckBoxes
        loc_oCnt.AddObject("chk_4c_OptArq", "CheckBox")
        WITH loc_oCnt.chk_4c_OptArq
            .Caption   = "Usar TXT-ALT"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 17
            .Left      = 566
            .Top       = 129
            .Width     = 103
            .Value     = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        loc_oCnt.AddObject("chk_4c_HVerao", "CheckBox")
        WITH loc_oCnt.chk_4c_HVerao
            .Caption   = "Hor" + CHR(225) + "rio de Ver" + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 17
            .Left      = 682
            .Top       = 128
            .Width     = 121
            .Value     = 0
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Venc", "CheckBox")
        WITH loc_oCnt.chk_4c_Venc
            .Caption   = "Venc Futuros"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 17
            .Left      = 726
            .Top       = 58
            .Width     = 121
            .Value     = 0
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("chk_4c_OptSub", "CheckBox")
        WITH loc_oCnt.chk_4c_OptSub
            .Caption   = "Subst. C" + CHR(243) + "digo do Produto por Refer" + CHR(234) + "ncia"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 15
            .Left      = 566
            .Top       = 145
            .Width     = 215
            .Value     = 0
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Themes    = .F.
        ENDWITH

        *-- Botao "..." inutilizacao (oculto por padrao)
        loc_oCnt.AddObject("cmd_4c_Inu", "CommandButton")
        WITH loc_oCnt.cmd_4c_Inu
            .Caption    = "..."
            .Height     = 22
            .Left       = 779
            .Top        = 105
            .Width      = 29
            .Visible    = .F.
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .ForeColor  = RGB(90,90,90)
            .BackColor  = RGB(255,255,255)
            .Themes     = .F.
        ENDWITH

        *-- OptionGroups com WITH ANINHADO
        loc_oCnt.AddObject("opt_4c_Processados", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Processados
        WITH loc_oOpt
            .ButtonCount = 2
            .Top         = 83
            .Left        = 89
            .Width       = 235
            .Height      = 17
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "N" + CHR(227) + "o Processados"
                .Width     = 115
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "J" + CHR(225) + " Processados"
                .Width     = 115
                .Left      = 118
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("opt_4c_Tipos", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Tipos
        WITH loc_oOpt
            .ButtonCount = 2
            .Top         = 6
            .Left        = 590
            .Width       = 142
            .Height      = 15
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Sa" + CHR(237) + "da"
                .Width     = 65
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Entrada"
                .Width     = 65
                .Left      = 68
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("opt_4c_Ambiente", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Ambiente
        WITH loc_oOpt
            .ButtonCount = 2
            .Top         = 54
            .Left        = 89
            .Width       = 173
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Produ" + CHR(231) + CHR(227) + "o"
                .Width     = 85
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Homologa" + CHR(231) + CHR(227) + "o"
                .Width     = 85
                .Left      = 88
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("opt_4c_Impressao", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Impressao
        WITH loc_oOpt
            .ButtonCount = 3
            .Top         = 59
            .Left        = 569
            .Width       = 151
            .Height      = 15
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Retrato"
                .Width     = 48
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Paisagem"
                .Width     = 55
                .Left      = 50
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Sem"
                .Width     = 44
                .Left      = 107
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("opt_4c_Acao", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Acao
        WITH loc_oOpt
            .ButtonCount = 7
            .Top         = 101
            .Left        = 92
            .Width       = 397
            .Height      = 38
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Enviar"
                .Width     = 55
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Consultar"
                .Width     = 60
                .Left      = 57
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Cancelar"
                .Width     = 58
                .Left      = 119
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Inutilizar"
                .Width     = 60
                .Left      = 179
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "PDF"
                .Width     = 36
                .Left      = 241
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(6)
                .Caption   = "E-mail"
                .Width     = 48
                .Left      = 279
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(7)
                .Caption   = "Status"
                .Width     = 48
                .Left      = 329
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH

        loc_oCnt.AddObject("opt_4c_Contin", "OptionGroup")
        loc_oOpt = loc_oCnt.opt_4c_Contin
        WITH loc_oOpt
            .ButtonCount = 3
            .Top         = 140
            .Left        = 92
            .Width       = 258
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Nenhuma"
                .Width     = 75
                .Left      = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "EPEC"
                .Width     = 52
                .Left      = 77
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "SCAN/SVC"
                .Width     = 75
                .Left      = 131
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
    *==========================================================================
        LOCAL loc_oCnt, loc_oGrd

        THIS.AddObject("cnt_4c_Grade", "Container")
        loc_oCnt = THIS.cnt_4c_Grade
        WITH loc_oCnt
            .Top          = 247
            .Left         = 50
            .Width        = 820
            .Height       = 344
            .BorderWidth  = 0
            .SpecialEffect = 0
            .BackStyle    = 1
            .BackColor    = RGB(220, 220, 220)
        ENDWITH

        loc_oCnt.AddObject("grd_4c_Operacoes", "Grid")
        loc_oGrd = loc_oCnt.grd_4c_Operacoes
        WITH loc_oGrd
            .Top           = 1
            .Left          = 3
            .Width         = 813
            .Height        = 340
            .ColumnCount   = 9
            .RecordSource  = "csOperacoes"
            .ReadOnly      = .T.
            .GridLines     = 1
            .GridLineWidth = 1
            .HeaderHeight  = 22
            .RowHeight     = 20
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ScrollBars    = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        *-- Column1: selecao (CheckBox com Sparse=.F.)
        WITH loc_oGrd.Column1
            .Width         = 25
            .ReadOnly      = .F.
            .ControlSource = "csOperacoes.SelImp"
        ENDWITH
        WITH loc_oGrd.Column1.Header1
            .Caption = ""
        ENDWITH
        loc_oGrd.Column1.AddObject("chk_4c_SelImp", "CheckBox")
        WITH loc_oGrd.Column1.chk_4c_SelImp
            .Caption   = ""
            .Width     = 22
            .Height    = 17
            .BackStyle = 0
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "chk_4c_SelImp"
        loc_oGrd.Column1.Sparse         = .F.

        *-- Column2: Codigo (Dopes)
        WITH loc_oGrd.Column2
            .Width         = 185
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Dopes"
        ENDWITH
        WITH loc_oGrd.Column2.Header1
            .Caption = "C" + CHR(243) + "digo"
        ENDWITH

        *-- Column3: Emissao (Datas)
        WITH loc_oGrd.Column3
            .Width         = 80
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Datas"
        ENDWITH
        WITH loc_oGrd.Column3.Header1
            .Caption = "Emiss" + CHR(227) + "o"
        ENDWITH

        *-- Column4: Valor (Valos)
        WITH loc_oGrd.Column4
            .Width         = 100
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Valos"
        ENDWITH
        WITH loc_oGrd.Column4.Header1
            .Caption = "Valor"
        ENDWITH

        *-- Column5: Nota Fiscal (Notas)
        WITH loc_oGrd.Column5
            .Width         = 80
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Notas"
        ENDWITH
        WITH loc_oGrd.Column5.Header1
            .Caption = "Nota Fiscal"
        ENDWITH

        *-- Column6: Serie (Series)
        WITH loc_oGrd.Column6
            .Width         = 50
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Series"
        ENDWITH
        WITH loc_oGrd.Column6.Header1
            .Caption = "S" + CHR(233) + "rie"
        ENDWITH

        *-- Column7: Movimentacao (Tipos)
        WITH loc_oGrd.Column7
            .Width         = 95
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Tipos"
        ENDWITH
        WITH loc_oGrd.Column7.Header1
            .Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- Column8: Empresa (Emps)
        WITH loc_oGrd.Column8
            .Width         = 50
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Emps"
        ENDWITH
        WITH loc_oGrd.Column8.Header1
            .Caption = "Emp"
        ENDWITH

        *-- Column9: Status (stats)
        WITH loc_oGrd.Column9
            .Width         = 148
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.stats"
        ENDWITH
        WITH loc_oGrd.Column9.Header1
            .Caption = "Stat"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesForm()
    *==========================================================================
        *-- Botao Selecionar
        THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
        WITH THIS.cmd_4c_Selecionar
            .Top             = 83
            .Left            = 843
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Selecionar"
            .Picture         = gc_4c_CaminhoIcones + "geral_buscar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_buscar_60.jpg"
            .PicturePosition = 7
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *-- Botao Limpar (desabilitado ate selecionar)
        THIS.AddObject("cmd_4c_BtnLimpar", "CommandButton")
        WITH THIS.cmd_4c_BtnLimpar
            .Top             = 162
            .Left            = 843
            .Width           = 75
            .Height          = 37
            .Caption         = "Limpar"
            .Picture         = gc_4c_CaminhoIcones + "geral_apagar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_apagar_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH

        *-- Botao Processar (desabilitado ate selecionar)
        THIS.AddObject("cmd_4c_BtnCopiar", "CommandButton")
        WITH THIS.cmd_4c_BtnCopiar
            .Top             = 202
            .Left            = 843
            .Width           = 75
            .Height          = 37
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH

        *-- Botao Encerrar
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 499
            .Left            = 917
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 7
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesGrade()
    *==========================================================================
        THIS.AddObject("cmd_4c_MarcaTudo", "CommandButton")
        WITH THIS.cmd_4c_MarcaTudo
            .Top             = 264
            .Left            = 873
            .Width           = 75
            .Height          = 55
            .Caption         = "Marca Tudo"
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_Desmarcar", "CommandButton")
        WITH THIS.cmd_4c_Desmarcar
            .Top             = 322
            .Left            = 873
            .Width           = 75
            .Height          = 55
            .Caption         = "Desmarcar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_Documentos", "CommandButton")
        WITH THIS.cmd_4c_Documentos
            .Top             = 380
            .Left            = 873
            .Width           = 75
            .Height          = 55
            .Caption         = "Documentos"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_consultar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_consultar_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_ImpDSimpl", "CommandButton")
        WITH THIS.cmd_4c_ImpDSimpl
            .Top             = 438
            .Left            = 873
            .Width           = 75
            .Height          = 55
            .Caption         = "Imp. Simpl."
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCntInu()
    *==========================================================================
        LOCAL loc_oCnt, loc_oGrd

        THIS.AddObject("cnt_4c_Inu", "Container")
        loc_oCnt = THIS.cnt_4c_Inu
        WITH loc_oCnt
            .Top          = 156
            .Left         = 203
            .Width        = 504
            .Height       = 392
            .Visible      = .F.
            .BorderWidth  = 2
            .SpecialEffect = 0
            .BackStyle    = 1
            .BackColor    = RGB(255, 255, 255)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_TituloInu", "Label")
        WITH loc_oCnt.lbl_4c_TituloInu
            .AutoSize  = .F.
            .Caption   = "Notas Fiscais para Inutilizar"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .Height    = 20
            .Left      = 117
            .Top       = 2
            .Width     = 380
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BtnCancelaInu", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnCancelaInu
            .Top             = 28
            .Left            = 408
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 7
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BtnProcInu", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnProcInu
            .Top             = 105
            .Left            = 408
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .PicturePosition = 7
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH

        *-- Cria cursor csInutil vazio para validar ControlSource do grid durante Init
        IF !USED("csInutil")
            SET NULL ON
            CREATE CURSOR csInutil (nMarca n(1,0), emps c(3), series c(3), ;
                notai c(9), notaf c(9), cnpj c(14))
            SET NULL OFF
        ENDIF

        loc_oCnt.AddObject("grd_4c_Inu", "Grid")
        loc_oGrd = loc_oCnt.grd_4c_Inu
        WITH loc_oGrd
            .Top           = 28
            .Left          = 17
            .Width         = 382
            .Height        = 355
            .ColumnCount   = 6
            .ReadOnly      = .F.
            .GridLines     = 1
            .GridLineWidth = 1
            .HeaderHeight  = 22
            .RowHeight     = 20
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ScrollBars    = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        WITH loc_oGrd.Column1
            .Width         = 35
            .ControlSource = "csInutil.emps"
        ENDWITH
        WITH loc_oGrd.Column1.Header1
            .Caption = "Emp"
        ENDWITH
        WITH loc_oGrd.Column2
            .Width         = 40
            .ControlSource = "csInutil.series"
        ENDWITH
        WITH loc_oGrd.Column2.Header1
            .Caption = "S" + CHR(233) + "rie"
        ENDWITH
        WITH loc_oGrd.Column3
            .Width         = 70
            .ControlSource = "csInutil.notai"
        ENDWITH
        WITH loc_oGrd.Column3.Header1
            .Caption = "Nota Inicial"
        ENDWITH
        WITH loc_oGrd.Column4
            .Width         = 70
            .ControlSource = "csInutil.notaf"
        ENDWITH
        WITH loc_oGrd.Column4.Header1
            .Caption = "Nota Final"
        ENDWITH
        WITH loc_oGrd.Column5
            .Width         = 105
            .ControlSource = "csInutil.cnpj"
        ENDWITH
        WITH loc_oGrd.Column5.Header1
            .Caption = "CPF/CNPJ"
        ENDWITH
        WITH loc_oGrd.Column6
            .Width         = 62
            .ControlSource = "csInutil.nMarca"
        ENDWITH
        WITH loc_oGrd.Column6.Header1
            .Caption = ""
        ENDWITH
        loc_oGrd.Column6.AddObject("chk_4c_SelInu", "CheckBox")
        WITH loc_oGrd.Column6.chk_4c_SelInu
            .Caption   = ""
            .Width     = 60
            .Height    = 17
            .BackStyle = 0
        ENDWITH
        loc_oGrd.Column6.CurrentControl = "chk_4c_SelInu"
        loc_oGrd.Column6.Sparse         = .F.
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis: torna visiveis todos os controles de nivel raiz.
    * cnt_4c_Inu permanece oculto (gerenciado por AlternarPagina); seus filhos
    * sao tornados visiveis para que funcionem ao exibir o container depois.
    * cmd_4c_Inu em cnt_4c_Operacoes eh reocultado apos o loop.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oErro, loc_oCtrl, loc_oFilho
        TRY
            FOR EACH loc_oCtrl IN THIS.Controls
                IF VARTYPE(loc_oCtrl) = "O"
                    IF INLIST(LOWER(loc_oCtrl.Name), "cnt_4c_inu")
                        FOR EACH loc_oFilho IN loc_oCtrl.Controls
                            IF VARTYPE(loc_oFilho) = "O"
                                loc_oFilho.Visible = .T.
                            ENDIF
                        ENDFOR
                        LOOP
                    ENDIF
                    loc_oCtrl.Visible = .T.
                ENDIF
            ENDFOR
            IF PEMSTATUS(THIS, "cnt_4c_Operacoes", 5)
                IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
                    THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Restaura visao principal do form OPERACIONAL
    * (grade + botoes de acao + filtros) escondendo o painel flutuante de
    * inutilizacao. Equivalente ao Page1=LISTA dos forms CRUD; chamado por
    * AlternarPagina(1) e apos cada processamento para reset visual.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
                THIS.cnt_4c_Inu.Visible = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Operacoes", 5)
                THIS.cnt_4c_Operacoes.Visible = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cnt_4c_Grade", 5)
                THIS.cnt_4c_Grade.Visible = .T.
                IF PEMSTATUS(THIS.cnt_4c_Grade, "grd_4c_Operacoes", 5)
                    THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
                ENDIF
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Selecionar", 5)
                THIS.cmd_4c_Selecionar.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Exibe painel flutuante de inutilizacao (overlay)
    * Form OPERACIONAL nao possui PageFrame; cnt_4c_Inu atua como "Page2=Dados"
    * para captura da grade de inutilizacao. Chamado por AlternarPagina(2) e
    * CmdInuClick apos SelecionarInutilizadas popular csInutil. Refresh() garante
    * repaint do grid apos GO TOP e cursor recem-carregado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cnt_4c_Inu", 5)
                THIS.cnt_4c_Inu.Visible = .T.
                IF PEMSTATUS(THIS.cnt_4c_Inu, "grd_4c_Inu", 5)
                    IF USED("csInutil")
                        THIS.cnt_4c_Inu.grd_4c_Inu.RecordSource = "csInutil"
                    ENDIF
                    THIS.cnt_4c_Inu.grd_4c_Inu.Refresh()
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Inu, "cmd_4c_BtnProcInu", 5)
                    THIS.cnt_4c_Inu.cmd_4c_BtnProcInu.Enabled = ;
                        (USED("csInutil") AND RECCOUNT("csInutil") > 0)
                ENDIF
                THIS.cnt_4c_Inu.ZOrder(0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre visao principal (1) e overlay Inutilizar (2)
    * Form OPERACIONAL nao possui PageFrame; usa cnt_4c_Inu como painel flutuante
    * que funciona logicamente como uma "segunda pagina" para captura de dados
    * de inutilizacao. par_nPagina = 1 restaura visao principal; = 2 abre overlay.
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPag, loc_oErro
        loc_nPag = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
        TRY
            DO CASE
                CASE loc_nPag = 2
                    THIS.ConfigurarPaginaDados()
                OTHERWISE
                    THIS.ConfigurarPaginaLista()
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
    *==========================================================================
        LOCAL loc_oGrd
        BINDEVENT(THIS.cmd_4c_Selecionar, "Click", THIS, "BtnSelecionarClick")
        BINDEVENT(THIS.cmd_4c_BtnLimpar,  "Click", THIS, "BtnLimparClick")
        BINDEVENT(THIS.cmd_4c_BtnCopiar,  "Click", THIS, "BtnCopiarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.cmd_4c_MarcaTudo,  "Click", THIS, "BtnMarcaTudoClick")
        BINDEVENT(THIS.cmd_4c_Desmarcar,  "Click", THIS, "BtnDesmarcarClick")
        BINDEVENT(THIS.cmd_4c_Documentos, "Click", THIS, "BtnDocumentosClick")
        BINDEVENT(THIS.cmd_4c_ImpDSimpl,  "Click", THIS, "BtnImpDSimplClick")
        BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnCancelaInu, "Click", THIS, "BtnCancelaInuClick")
        BINDEVENT(THIS.cnt_4c_Inu.cmd_4c_BtnProcInu,    "Click", THIS, "BtnProcInuClick")
        BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Emps,    "KeyPress", THIS, "EmpsLostFocus")
        BINDEVENT(THIS.cnt_4c_Operacoes.txt_4c_Series,  "KeyPress", THIS, "SeriesLostFocus")
        BINDEVENT(THIS.cnt_4c_Operacoes.opt_4c_Acao, "InteractiveChange", THIS, "AcaoInteractiveChange")
        BINDEVENT(THIS.cnt_4c_Operacoes.cmd_4c_Inu,  "Click", THIS, "CmdInuClick")
        loc_oGrd = THIS.cnt_4c_Grade.grd_4c_Operacoes
        BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "MouseUp",  THIS, "GridChkMouseUp")
        BINDEVENT(loc_oGrd.Column1.chk_4c_SelImp, "KeyPress", THIS, "GridChkKeyPress")
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS
    *==========================================================================

    PROCEDURE BtnSelecionarClick
        LPARAMETERS par_lForcado
        LOCAL loc_cEmps, loc_cSeries, loc_dDtIni, loc_dDtFin
        LOCAL loc_nProcessados, loc_nTipos, loc_nAcao
        LOCAL loc_cInuIni, loc_cInuFim, loc_oBO, loc_oErro, loc_lSelOk

        loc_oBO = THIS.this_oBusinessObject

        loc_cEmps        = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
        loc_cSeries      = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
        loc_dDtIni       = THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value
        loc_dDtFin       = THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value
        loc_nProcessados = THIS.cnt_4c_Operacoes.opt_4c_Processados.Value
        loc_nTipos       = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
        loc_nAcao        = THIS.cnt_4c_Operacoes.opt_4c_Acao.Value
        loc_cInuIni      = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
        loc_cInuFim      = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)

        IF VARTYPE(par_lForcado) != "L" OR !par_lForcado
            IF loc_nProcessados = 2
                IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Opera" + ;
                                CHR(231) + CHR(245) + "es J" + CHR(225) + " Processadas Anteriormente?")
                    THIS.cnt_4c_Operacoes.opt_4c_Processados.Value = 1
                    RETURN
                ENDIF
            ENDIF
        ENDIF

        IF EMPTY(ALLTRIM(loc_cEmps))
            MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!!!")
            THIS.cnt_4c_Operacoes.txt_4c_Emps.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_dDtIni)
            MsgAviso("A Data Inicial N" + CHR(227) + "o Foi Informada!!!")
            THIS.cnt_4c_Operacoes.txt_4c_DtIni.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_dDtFin)
            MsgAviso("A Data Final N" + CHR(227) + "o Foi Informada!!!")
            THIS.cnt_4c_Operacoes.txt_4c_DtFin.SetFocus()
            RETURN
        ENDIF
        IF loc_dDtFin < loc_dDtIni
            MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!")
            THIS.cnt_4c_Operacoes.txt_4c_DtFin.SetFocus()
            RETURN
        ENDIF
        IF INLIST(loc_nAcao, 4, 7)
            IF (loc_cInuFim < loc_cInuIni) OR EMPTY(loc_cInuFim) OR EMPTY(loc_cInuIni)
                MsgAviso("A Numera" + CHR(231) + CHR(227) + "o informada est" + CHR(225) + " inconsistente!!!")
                THIS.cnt_4c_Operacoes.txt_4c_InuFim.SetFocus()
                RETURN
            ENDIF
        ENDIF

        loc_oBO.this_cEmps        = loc_cEmps
        loc_oBO.this_cSeries      = loc_cSeries
        loc_oBO.this_dDtIni       = loc_dDtIni
        loc_oBO.this_dDtFin       = loc_dDtFin
        loc_oBO.this_nProcessados = loc_nProcessados
        loc_oBO.this_nTipos       = loc_nTipos
        loc_oBO.this_nAcao        = loc_nAcao
        loc_oBO.this_cInuIni      = loc_cInuIni
        loc_oBO.this_cInuFim      = loc_cInuFim

        loc_lSelOk = .T.
        TRY
            loc_oBO.Selecionar("csOperacoes")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Selecionar")
            loc_lSelOk = .F.
        ENDTRY
        IF !loc_lSelOk
            RETURN
        ENDIF

        THIS.HabilitarControles(.F.)

        SELECT csOperacoes
        SET ORDER TO Notas
        GO TOP IN csOperacoes
        IF EOF("csOperacoes")
            IF INLIST(loc_nAcao, 1, 2, 3, 5)
                MsgAviso("Nenhuma Nota Foi Encontrada Para Processamento!!!")
                THIS.LimpaSelecao()
                THIS.cnt_4c_Operacoes.txt_4c_Series.SetFocus()
            ENDIF
        ELSE
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnLimparClick()
        THIS.LimpaSelecao()
    ENDPROC

    PROCEDURE BtnCopiarClick()
        LOCAL loc_nAcao, loc_nSel, loc_oBO, loc_oErro
        loc_nAcao = THIS.cnt_4c_Operacoes.opt_4c_Acao.Value
        IF INLIST(loc_nAcao, 1, 2, 3, 5, 6)
            IF USED("cursor_4c_SelChk")
                USE IN cursor_4c_SelChk
            ENDIF
            SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelChk
            loc_nSel = cursor_4c_SelChk.nSel
            USE IN cursor_4c_SelChk
            IF loc_nSel < 1
                MsgAviso("Nenhum Lan" + CHR(231) + "amento Foi Selecionado para Processamento!!!")
                THIS.cnt_4c_Grade.grd_4c_Operacoes.SetFocus()
                RETURN
            ENDIF
        ENDIF
        loc_oBO = THIS.this_oBusinessObject
        loc_oBO.this_nAcao      = loc_nAcao
        loc_oBO.this_nAmbiente  = THIS.cnt_4c_Operacoes.opt_4c_Ambiente.Value
        loc_oBO.this_nTipos     = THIS.cnt_4c_Operacoes.opt_4c_Tipos.Value
        loc_oBO.this_nImpressao = THIS.cnt_4c_Operacoes.opt_4c_Impressao.Value
        loc_oBO.this_nContin    = THIS.cnt_4c_Operacoes.opt_4c_Contin.Value
        loc_oBO.this_cArquivos  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value)
        loc_oBO.this_lHVerao    = (THIS.cnt_4c_Operacoes.chk_4c_HVerao.Value = 1)
        loc_oBO.this_lVenc      = (THIS.cnt_4c_Operacoes.chk_4c_Venc.Value = 1)
        loc_oBO.this_lOptSub    = (THIS.cnt_4c_Operacoes.chk_4c_OptSub.Value = 1)
        loc_oBO.this_lOptArq    = (THIS.cnt_4c_Operacoes.chk_4c_OptArq.Value = 1)
        TRY
            loc_oBO.Processamento( ;
                PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3), ;
                PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3))
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Processar")
        ENDTRY
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnMarcaTudoClick()
        IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
            SELECT csOperacoes
            REPLACE ALL SelImp WITH .T.
            GO TOP IN csOperacoes
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDesmarcarClick()
        IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
            SELECT csOperacoes
            REPLACE ALL SelImp WITH .F.
            GO TOP IN csOperacoes
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnDocumentosClick()
        LOCAL loc_cDopes, loc_nNumes, loc_cEmps, loc_oForm, loc_oErro
        IF !USED("csOperacoes") OR EOF("csOperacoes")
            MsgAviso("Posicione o cursor em um registro.")
            RETURN
        ENDIF
        SELECT csOperacoes
        loc_cDopes = ALLTRIM(csOperacoes.Dopes)
        loc_nNumes = csOperacoes.Numes
        loc_cEmps  = ALLTRIM(csOperacoes.Emps)
        TRY
            loc_oForm = CREATEOBJECT("Formsigmvexp", loc_cDopes, "C", loc_nNumes, loc_cEmps)
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ELSE
                MsgErro("Erro ao criar Formsigmvexp. VARTYPE retornou: " + ;
                        VARTYPE(loc_oForm), "Documentos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao abrir Documentos")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImpDSimplClick()
        LOCAL loc_oBO, loc_oErro
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("Nenhuma nota encontrada para impress" + CHR(227) + "o.")
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject
        TRY
            loc_oBO.ImprimirSimplificado("csOperacoes")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Impress" + CHR(227) + "o")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelaInuClick()
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE BtnProcInuClick()
        LOCAL loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim, loc_oBO, loc_oErro
        IF !INLIST(THIS.cnt_4c_Operacoes.opt_4c_Acao.Value, 4, 7)
            MsgAviso("Selecione a a" + CHR(231) + CHR(227) + "o Inutilizar ou Status.")
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value))
            MsgAviso("Empresa n" + CHR(227) + "o informada.")
            RETURN
        ENDIF
        IF !USED("csInutil") OR RECCOUNT("csInutil") = 0
            MsgAviso("Nenhuma nota fiscal para inutilizar.")
            RETURN
        ENDIF
        loc_cEmps   = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
        loc_cSeries = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), 3)
        loc_cNIni   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuIni.Value)
        loc_cNFim   = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_InuFim.Value)
        SELECT csInutil
        GO TOP IN csInutil
        loc_cCnpj = ALLTRIM(csInutil.cnpj)
        loc_oBO = THIS.this_oBusinessObject
        TRY
            loc_oBO.ProcessaInutilizadas(loc_cEmps, loc_cSeries, loc_cCnpj, loc_cNIni, loc_cNFim)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Inutilizar")
        ENDTRY
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE AcaoInteractiveChange()
        IF PEMSTATUS(THIS.cnt_4c_Operacoes, "cmd_4c_Inu", 5)
            THIS.cnt_4c_Operacoes.cmd_4c_Inu.Visible = ;
                INLIST(THIS.cnt_4c_Operacoes.opt_4c_Acao.Value, 4, 7)
        ENDIF
    ENDPROC

    PROCEDURE CmdInuClick()
        LOCAL loc_cEmps, loc_oBO, loc_oErro
        loc_cEmps = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
        IF EMPTY(ALLTRIM(loc_cEmps))
            MsgAviso("Informe a empresa antes de consultar inutiliza" + CHR(231) + CHR(245) + "es.")
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject
        TRY
            *-- Carrega nfAinu com gap analysis via BO
            loc_oBO.SelecionarInutilizadas(loc_cEmps)
            IF USED("nfAinu")
                SELECT 1 AS nMarca, emps, series, notai, notaf, cnpj ;
                    FROM nfAinu ;
                    WHERE RTRIM(emps) = RTRIM(loc_cEmps) ;
                    INTO CURSOR csInutil READWRITE
                IF USED("csInutil") AND RECCOUNT("csInutil") > 0
                    GO TOP IN csInutil
                    THIS.cnt_4c_Inu.grd_4c_Inu.RecordSource = "csInutil"
                    THIS.cnt_4c_Inu.grd_4c_Inu.Refresh()
                    THIS.AlternarPagina(2)
                ELSE
                    MsgAviso("Nenhuma nota para inutilizar encontrada para esta empresa.")
                ENDIF
            ELSE
                MsgAviso("Nenhuma nota para inutilizar encontrada.")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CmdInu")
        ENDTRY
    ENDPROC

    PROCEDURE EmpsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 115  && F4 - abrir picker direto
            THIS.AbrirBuscaEmps()
            RETURN
        ENDIF
        LOCAL loc_cEmps, loc_oBO, loc_oErro
        loc_cEmps = PADR(ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), 3)
        IF EMPTY(ALLTRIM(loc_cEmps))
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject
        TRY
            IF loc_oBO.CarregarEmpresa(ALLTRIM(loc_cEmps))
                THIS.PreencherRegimeEmpresa(loc_oBO)
            ELSE
                THIS.AbrirBuscaEmps()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar empresa")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE PreencherRegimeEmpresa(par_oBO)
        DO CASE
            CASE par_oBO.this_nRegimeEmp = 1
                THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Simples Nacional"
            CASE par_oBO.this_nRegimeEmp = 2
                THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Presumido"
            CASE par_oBO.this_nRegimeEmp = 3
                THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Real"
            CASE par_oBO.this_nRegimeEmp = 4
                THIS.cnt_4c_Operacoes.cmb_4c_Regime.Value = "Lucro Arbitrado"
        ENDCASE
        IF !EMPTY(par_oBO.this_cArquivos)
            THIS.cnt_4c_Operacoes.txt_4c_Arquivos.Value = par_oBO.this_cArquivos
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmps()
        LOCAL loc_oBusca, loc_cCemps, loc_oBO, loc_oErro
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmp", ;
                "Cemps", ;
                ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value), ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
                .T., .T., "Ativas <> 2")
            loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                loc_cCemps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                THIS.cnt_4c_Operacoes.txt_4c_Emps.Value = loc_cCemps
                loc_oBO = THIS.this_oBusinessObject
                IF loc_oBO.CarregarEmpresa(loc_cCemps)
                    THIS.PreencherRegimeEmpresa(loc_oBO)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaEmps")
        ENDTRY
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    PROCEDURE SeriesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 115  && F4 - abrir picker direto
            THIS.AbrirBuscaSeries()
            RETURN
        ENDIF
        LOCAL loc_cSeries, loc_nResult, loc_oErro
        loc_cSeries = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value)
        IF EMPTY(loc_cSeries)
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Cods FROM SigCdSer WHERE ImpNfs = 3 AND LTRIM(RTRIM(Cods)) = " + ;
                EscaparSQL(loc_cSeries), "cursor_4c_SerValid")
            IF loc_nResult > 0 AND USED("cursor_4c_SerValid") AND !EOF("cursor_4c_SerValid")
                THIS.cnt_4c_Operacoes.txt_4c_Series.Value = ALLTRIM(cursor_4c_SerValid.Cods)
            ELSE
                THIS.AbrirBuscaSeries()
            ENDIF
            IF USED("cursor_4c_SerValid")
                USE IN cursor_4c_SerValid
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar s" + CHR(233) + "rie")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaSeries()
        LOCAL loc_oBusca, loc_cCods, loc_oErro
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdSer", ;
                "cursor_4c_BuscaSeries", ;
                "Cods", ;
                ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Series.Value), ;
                "Sele" + CHR(231) + CHR(227) + "o de S" + CHR(233) + "rie", ;
                .T., .T., "ImpNfs = 3")
            loc_oBusca.mAddColuna("Cods", "", "S" + CHR(233) + "rie")
            loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSeries")
                loc_cCods = ALLTRIM(cursor_4c_BuscaSeries.Cods)
                THIS.cnt_4c_Operacoes.txt_4c_Series.Value = loc_cCods
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaSeries")
        ENDTRY
        IF USED("cursor_4c_BuscaSeries")
            USE IN cursor_4c_BuscaSeries
        ENDIF
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *-- MouseUp no CheckBox de selecao: toggle SelImp do registro corrente
    PROCEDURE GridChkMouseUp
        LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
        IF USED("csOperacoes") AND !EOF("csOperacoes")
            m.SelImp = (NOT csOperacoes.SelImp)
            SELECT csOperacoes
            GATHER MEMVAR FIELDS SelImp
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        ENDIF
        NODEFAULT
    ENDPROC

    *-- KeyPress no CheckBox de selecao: Enter/Space faz toggle
    PROCEDURE GridChkKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF INLIST(par_nKeyCode, 13, 32) AND USED("csOperacoes") AND !EOF("csOperacoes")
            m.SelImp = (NOT csOperacoes.SelImp)
            SELECT csOperacoes
            GATHER MEMVAR FIELDS SelImp
            THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE LimpaSelecao()
        IF USED("csOperacoes")
            ZAP IN csOperacoes
        ENDIF
        THIS.HabilitarControles(.T.)
        THIS.cmd_4c_ImpDSimpl.Enabled = .F.
        THIS.Refresh()
    ENDPROC

    PROCEDURE HabilitarControles(par_lHabilitar)
        WITH THIS.cnt_4c_Operacoes
            .txt_4c_Emps.Enabled                   = par_lHabilitar
            .txt_4c_Series.Enabled                 = par_lHabilitar
            .txt_4c_DtIni.Enabled                  = par_lHabilitar
            .txt_4c_DtFin.Enabled                  = par_lHabilitar
            .txt_4c_InuIni.Enabled                 = par_lHabilitar
            .txt_4c_InuFim.Enabled                 = par_lHabilitar
            .cmb_4c_Regime.Enabled                 = par_lHabilitar
            .opt_4c_Processados.Buttons(1).Enabled = par_lHabilitar
            .opt_4c_Processados.Buttons(2).Enabled = par_lHabilitar
            .Visible     = .T.
        ENDWITH
        THIS.cmd_4c_Selecionar.Enabled = par_lHabilitar
        THIS.cmd_4c_BtnLimpar.Enabled  = !par_lHabilitar
        THIS.cmd_4c_BtnCopiar.Enabled  = !par_lHabilitar
        THIS.cmd_4c_MarcaTudo.Enabled  = !par_lHabilitar
        THIS.cmd_4c_Desmarcar.Enabled  = !par_lHabilitar
        THIS.cmd_4c_Documentos.Enabled = !par_lHabilitar
        THIS.cmd_4c_ImpDSimpl.Enabled  = !par_lHabilitar
    ENDPROC

    *==========================================================================
    * Eventos CRUD adaptados ao contexto OPERACIONAL de processamento de NFe.
    * Em forms de processamento fiscal, as semanticas CRUD tradicionais mapeiam
    * para operacoes especificas do fluxo de trabalho de NFe.
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        * Incluir notas fiscais na fila de processamento.
        * No contexto NFe, "Incluir" equivale a Selecionar registros do banco
        * (SigMvNfi) para o cursor csOperacoes segundo os filtros informados.
        LOCAL loc_cEmps
        loc_cEmps = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value)
        IF EMPTY(loc_cEmps)
            MsgAviso("Informe a Empresa antes de incluir notas na fila.")
            THIS.cnt_4c_Operacoes.txt_4c_Emps.SetFocus()
            RETURN
        ENDIF
        THIS.BtnSelecionarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        * Alterar dados fiscais da nota corrente. Abre Formsigmvexp
        * (mesma janela usada pelo botao "Documentos" do grid) para
        * edicao dos dados fiscais da NF apontada em csOperacoes.
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila. Utilize Incluir primeiro.")
            RETURN
        ENDIF
        SELECT csOperacoes
        IF EOF("csOperacoes")
            GO TOP IN csOperacoes
        ENDIF
        IF EMPTY(csOperacoes.Emps) OR EMPTY(csOperacoes.Dopes)
            MsgAviso("Posicione o cursor sobre uma nota v" + CHR(225) + "lida.")
            RETURN
        ENDIF
        THIS.BtnDocumentosClick()
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        * Visualizar detalhes tecnicos (chave, protocolo, status)
        * da nota fiscal apontada. Consulta SigMvNfi diretamente
        * para exibir dados que nao aparecem no grid principal.
        LOCAL loc_cChave, loc_cSQL, loc_oErro, loc_cMsg
        LOCAL loc_cChv, loc_cProt, loc_cStat, loc_cXml
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas na fila para visualizar.")
            RETURN
        ENDIF
        SELECT csOperacoes
        IF EOF("csOperacoes")
            GO TOP IN csOperacoes
        ENDIF
        loc_cChave = ALLTRIM(csOperacoes.Emps) + ALLTRIM(csOperacoes.Dopes) + ;
                     PADL(ALLTRIM(TRANSFORM(csOperacoes.Numes)), 6, "0")
        loc_cSQL = "SELECT TOP 1 nfechv, nfexml, prots, stats FROM SigMvNfi WHERE empdopnums = " + ;
                   EscaparSQL(loc_cChave)
        TRY
            IF USED("cursor_4c_VisNfe")
                USE IN cursor_4c_VisNfe
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VisNfe") < 1
                MsgErro("Falha ao consultar SigMvNfi para a nota selecionada.", "Visualizar")
                RETURN
            ENDIF
            IF RECCOUNT("cursor_4c_VisNfe") = 0
                MsgAviso("Nota fiscal ainda n" + CHR(227) + "o transmitida (sem registro em SigMvNfi).")
            ELSE
                loc_cChv  = ALLTRIM(NVL(cursor_4c_VisNfe.nfechv, "N/D"))
                loc_cProt = ALLTRIM(NVL(cursor_4c_VisNfe.prots, "N/D"))
                loc_cStat = ALLTRIM(NVL(cursor_4c_VisNfe.stats, "N/D"))
                loc_cXml  = IIF(EMPTY(NVL(cursor_4c_VisNfe.nfexml, "")), "N" + CHR(227) + "o", "Sim")
                loc_cMsg = "Nota: " + ALLTRIM(csOperacoes.Notas) + CHR(13) + ;
                           "S" + CHR(233) + "rie: " + ALLTRIM(csOperacoes.Series) + CHR(13) + ;
                           "Chave: " + loc_cChv + CHR(13) + ;
                           "Protocolo: " + loc_cProt + CHR(13) + ;
                           "Status: " + loc_cStat + CHR(13) + ;
                           "XML dispon" + CHR(237) + "vel: " + loc_cXml
                MsgInfo(loc_cMsg)
            ENDIF
            IF USED("cursor_4c_VisNfe")
                USE IN cursor_4c_VisNfe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Visualizar")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcluirClick()
        * Excluir (limpar) a fila de processamento.
        * NAO remove NFe do banco - apenas limpa csOperacoes e reabilita
        * os filtros para nova selecao. Confirmacao obrigatoria.
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("A fila de processamento j" + CHR(225) + " est" + CHR(225) + " vazia.")
            RETURN
        ENDIF
        IF MsgConfirma("Confirma a limpeza da fila de processamento de NFe?" + CHR(13) + ;
                       "Os registros n" + CHR(227) + "o ser" + CHR(227) + "o removidos do banco de dados.")
            THIS.LimpaSelecao()
        ENDIF
    ENDPROC

    *==========================================================================
    * FASE 8 - FormParaBO / BOParaForm / HabilitarCampos / LimparCampos
    * CarregarLista / AjustarBotoesPorModo / BtnSalvar / BtnCancelar / BtnBuscar
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Copia TODOS os valores da UI para o Business Object.
    * Cobre os 3 blocos de propriedades: parametros de sele" + CHR(231) + CHR(227) + "o
    * (empresa/serie/datas/acao), flags/checkboxes e o registro corrente
    * de csOperacoes (linha selecionada no grid).
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oCnt
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF
        loc_oCnt = THIS.cnt_4c_Operacoes

        *-- Bloco 1: parametros de selecao/processamento
        loc_oBO.this_cEmps        = PADR(ALLTRIM(loc_oCnt.txt_4c_Emps.Value), 3)
        loc_oBO.this_cSeries      = PADR(ALLTRIM(loc_oCnt.txt_4c_Series.Value), 3)
        loc_oBO.this_dDtIni       = loc_oCnt.txt_4c_DtIni.Value
        loc_oBO.this_dDtFin       = loc_oCnt.txt_4c_DtFin.Value
        loc_oBO.this_nProcessados = loc_oCnt.opt_4c_Processados.Value
        loc_oBO.this_nTipos       = loc_oCnt.opt_4c_Tipos.Value
        loc_oBO.this_nAmbiente    = loc_oCnt.opt_4c_Ambiente.Value
        loc_oBO.this_nAcao        = loc_oCnt.opt_4c_Acao.Value
        loc_oBO.this_nImpressao   = loc_oCnt.opt_4c_Impressao.Value
        loc_oBO.this_nContin      = loc_oCnt.opt_4c_Contin.Value
        loc_oBO.this_cInuIni      = ALLTRIM(loc_oCnt.txt_4c_InuIni.Value)
        loc_oBO.this_cInuFim      = ALLTRIM(loc_oCnt.txt_4c_InuFim.Value)
        loc_oBO.this_cRegime      = ALLTRIM(loc_oCnt.cmb_4c_Regime.Value)
        loc_oBO.this_cArquivos    = ALLTRIM(loc_oCnt.txt_4c_Arquivos.Value)
        IF EMPTY(loc_oCnt.txt_4c_IniContin.Value)
            loc_oBO.this_dIniContin = {}
        ELSE
            IF VARTYPE(loc_oCnt.txt_4c_IniContin.Value) = "D"
                loc_oBO.this_dIniContin = loc_oCnt.txt_4c_IniContin.Value
            ELSE
                loc_oBO.this_dIniContin = CTOD(TRANSFORM(loc_oCnt.txt_4c_IniContin.Value))
            ENDIF
        ENDIF

        *-- Bloco 2: flags/checkboxes (Value NUMERICO 0/1 -> LOGICAL no BO)
        loc_oBO.this_lHVerao  = (loc_oCnt.chk_4c_HVerao.Value = 1)
        loc_oBO.this_lVenc    = (loc_oCnt.chk_4c_Venc.Value = 1)
        loc_oBO.this_lOptSub  = (loc_oCnt.chk_4c_OptSub.Value = 1)
        loc_oBO.this_lOptArq  = (loc_oCnt.chk_4c_OptArq.Value = 1)

        *-- Bloco 3: registro corrente do grid csOperacoes
        IF USED("csOperacoes") AND !EOF("csOperacoes") AND !BOF("csOperacoes")
            loc_oBO.this_lSelImp     = NVL(csOperacoes.SelImp, .F.)
            loc_oBO.this_cDopes      = NVL(csOperacoes.Dopes, "")
            loc_oBO.this_nNumes      = NVL(csOperacoes.Numes, 0)
            loc_oBO.this_dDatas      = NVL(csOperacoes.Datas, {})
            loc_oBO.this_nValos      = NVL(csOperacoes.Valos, 0)
            loc_oBO.this_cNotas      = NVL(csOperacoes.Notas, "")
            loc_oBO.this_cNFMemo     = NVL(csOperacoes.NFMemo, "")
            loc_oBO.this_cErros      = NVL(csOperacoes.Erros, "")
            loc_oBO.this_cStats      = NVL(csOperacoes.stats, "")
            loc_oBO.this_cStatts     = NVL(csOperacoes.statts, "")
            loc_oBO.this_cId         = NVL(csOperacoes.ids, "")
            loc_oBO.this_cLote       = NVL(csOperacoes.lotes, "")
            loc_oBO.this_cRecibo     = NVL(csOperacoes.recibos, "")
            loc_oBO.this_cProt       = NVL(csOperacoes.prots, "")
            loc_oBO.this_cEmpDopNums = ALLTRIM(NVL(csOperacoes.Emps, "")) + ;
                                      ALLTRIM(NVL(csOperacoes.Dopes, "")) + ;
                                      PADL(ALLTRIM(TRANSFORM(NVL(csOperacoes.Numes, 0))), 6, "0")
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia TODOS os valores do Business Object para a UI.
    * Espelho de FormParaBO, cobrindo os 3 blocos (parametros, flags e
    * registro corrente do grid).
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oCnt
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF
        loc_oCnt = THIS.cnt_4c_Operacoes

        *-- Bloco 1: parametros de selecao/processamento
        loc_oCnt.txt_4c_Emps.Value       = loc_oBO.this_cEmps
        loc_oCnt.txt_4c_Series.Value     = loc_oBO.this_cSeries
        loc_oCnt.txt_4c_DtIni.Value      = loc_oBO.this_dDtIni
        loc_oCnt.txt_4c_DtFin.Value      = loc_oBO.this_dDtFin
        IF loc_oBO.this_nProcessados > 0
            loc_oCnt.opt_4c_Processados.Value = loc_oBO.this_nProcessados
        ENDIF
        IF loc_oBO.this_nTipos > 0
            loc_oCnt.opt_4c_Tipos.Value = loc_oBO.this_nTipos
        ENDIF
        IF loc_oBO.this_nAmbiente > 0
            loc_oCnt.opt_4c_Ambiente.Value = loc_oBO.this_nAmbiente
        ENDIF
        IF loc_oBO.this_nAcao > 0
            loc_oCnt.opt_4c_Acao.Value = loc_oBO.this_nAcao
        ENDIF
        IF loc_oBO.this_nImpressao > 0
            loc_oCnt.opt_4c_Impressao.Value = loc_oBO.this_nImpressao
        ENDIF
        IF loc_oBO.this_nContin > 0
            loc_oCnt.opt_4c_Contin.Value = loc_oBO.this_nContin
        ENDIF
        loc_oCnt.txt_4c_InuIni.Value   = loc_oBO.this_cInuIni
        loc_oCnt.txt_4c_InuFim.Value   = loc_oBO.this_cInuFim
        loc_oCnt.cmb_4c_Regime.Value   = loc_oBO.this_cRegime
        loc_oCnt.txt_4c_Arquivos.Value = loc_oBO.this_cArquivos
        loc_oCnt.txt_4c_IniContin.Value = loc_oBO.this_dIniContin

        *-- Bloco 2: flags/checkboxes (LOGICAL BO -> NUMERICO 0/1 CheckBox)
        loc_oCnt.chk_4c_HVerao.Value = IIF(loc_oBO.this_lHVerao, 1, 0)
        loc_oCnt.chk_4c_Venc.Value   = IIF(loc_oBO.this_lVenc, 1, 0)
        loc_oCnt.chk_4c_OptSub.Value = IIF(loc_oBO.this_lOptSub, 1, 0)
        loc_oCnt.chk_4c_OptArq.Value = IIF(loc_oBO.this_lOptArq, 1, 0)

        *-- Bloco 3: registro corrente reflete csOperacoes via ControlSource do
        *-- grid. Refresh forca releitura dos ControlSource apos alteracao no BO.
        THIS.cnt_4c_Grade.grd_4c_Operacoes.Refresh()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Interface CRUD-padrao. Delega para HabilitarControles
    * (nome nativo deste form OPERACIONAL) que implementa a logica real de
    * bloquear filtros durante processamento.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        THIS.HabilitarControles(loc_lHab)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Interface CRUD-padrao. Reseta filtros para valores default
    * e limpa a fila de csOperacoes chamando LimpaSelecao.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Operacoes
        loc_oCnt.txt_4c_Emps.Value        = ""
        loc_oCnt.txt_4c_Series.Value      = ""
        loc_oCnt.txt_4c_DtIni.Value       = {}
        loc_oCnt.txt_4c_DtFin.Value       = {}
        loc_oCnt.txt_4c_InuIni.Value      = ""
        loc_oCnt.txt_4c_InuFim.Value      = ""
        loc_oCnt.txt_4c_Arquivos.Value    = ""
        loc_oCnt.opt_4c_Processados.Value = 1
        loc_oCnt.opt_4c_Tipos.Value       = 1
        loc_oCnt.opt_4c_Ambiente.Value    = 1
        loc_oCnt.opt_4c_Acao.Value        = 1
        loc_oCnt.opt_4c_Impressao.Value   = 1
        loc_oCnt.opt_4c_Contin.Value      = 1
        loc_oCnt.chk_4c_HVerao.Value      = 0
        loc_oCnt.chk_4c_Venc.Value        = 0
        loc_oCnt.chk_4c_OptSub.Value      = 0
        loc_oCnt.chk_4c_OptArq.Value      = 0
        THIS.LimpaSelecao()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Interface CRUD-padrao. Executa a selecao inicial das
    * notas fiscais no banco (SigMvNfi) para o cursor csOperacoes que popula
    * o grid principal. Delega para BtnSelecionarClick que reproduz o Selecionar
    * do form legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_cEmps, loc_dDtIni, loc_dDtFin
        loc_cEmps  = ALLTRIM(THIS.cnt_4c_Operacoes.txt_4c_Emps.Value)
        loc_dDtIni = THIS.cnt_4c_Operacoes.txt_4c_DtIni.Value
        loc_dDtFin = THIS.cnt_4c_Operacoes.txt_4c_DtFin.Value
        IF EMPTY(loc_cEmps) OR EMPTY(loc_dDtIni) OR EMPTY(loc_dDtFin)
            RETURN .F.
        ENDIF
        THIS.BtnSelecionarClick(.T.)
        RETURN USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Interface CRUD-padrao. Neste form OPERACIONAL
    * ha 2 modos logicos:
    *   MODO=1 (LIVRE):     filtros habilitados, botoes de acao em grid off.
    *   MODO=2 (SELECAO):   filtros bloqueados, botoes de acao em grid on.
    * A rotina espelha o comportamento de HabilitarControles com semantica
    * de "modo" para compatibilidade com o pipeline CRUD.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo(par_nModo)
        LOCAL loc_nModo
        loc_nModo = IIF(VARTYPE(par_nModo) = "N", par_nModo, 1)
        IF loc_nModo = 1
            THIS.HabilitarControles(.T.)
        ELSE
            THIS.HabilitarControles(.F.)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Interface CRUD-padrao. Em contexto NFe "Salvar" equivale
    * a processar (transmitir SEFAZ / gerar TXT / imprimir DANFE) as notas
    * marcadas no grid. Delega para BtnCopiarClick que aciona o
    * BO.Processar/Processamento conforme opt_4c_Acao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_nSel
        IF !USED("csOperacoes") OR RECCOUNT("csOperacoes") = 0
            MsgAviso("A fila de processamento est" + CHR(225) + " vazia. Use Buscar/Selecionar antes.")
            RETURN
        ENDIF
        SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_SelSalv
        loc_nSel = cursor_4c_SelSalv.nSel
        USE IN cursor_4c_SelSalv
        IF loc_nSel < 1
            MsgAviso("Nenhuma nota est" + CHR(225) + " marcada para processamento.")
            RETURN
        ENDIF
        THIS.FormParaBO()
        THIS.BtnCopiarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Interface CRUD-padrao. Cancela a selecao atual e
    * reabilita os filtros de busca (equivale ao Limpar do form legado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF USED("csOperacoes") AND RECCOUNT("csOperacoes") > 0
            IF !MsgConfirma("Confirma o cancelamento da sele" + CHR(231) + CHR(227) + ;
                            "o? A fila ser" + CHR(225) + " limpa.")
                RETURN
            ENDIF
        ENDIF
        THIS.BtnLimparClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Interface CRUD-padrao. Aciona a selecao no banco
    * segundo os filtros informados. Delega para BtnSelecionarClick que
    * reproduz o Selecionar do form legado (grupo de botoes cmdSelecionar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnSelecionarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF USED("csOperacoes")
            USE IN csOperacoes
        ENDIF
        IF USED("csInutil")
            USE IN csInutil
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
