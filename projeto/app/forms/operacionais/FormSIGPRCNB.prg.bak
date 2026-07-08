*==============================================================================
* FormSIGPRCNB.prg - Form Operacional: Geracao de Arquivos CNAB - Cobranca
* Migrado de SIGPRCNB.SCX
* Herda de FormBase
* Tabelas: SigMvPar, SigMvCab, SigMvCcr, SigCdCli, SigCdCeb, SigCdEmp, SigCdOpe, SigOpFp, SigPcOol
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado
*   BD   -> Schema IDENTICO (SigPcOol, SigMvCcr, etc.)
*   CODE -> arquitetura em camadas (FormBase / SIGPRCNBBO)
*==============================================================================

DEFINE CLASS FormSIGPRCNB AS FormBase

    *-- Dimensoes e propriedades visuais
    Height      = 600
    Width       = 1000
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    Caption     = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB"
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowState = 0
    ShowWindow  = 1
    WindowType  = 1
    DataSession = 2
    Themes      = .F.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Caminho do arquivo CNAB Itau (preenchido pelo GetFile dialog em GerarCNAB)
    this_cArqCNAB = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = NEWOBJECT("SIGPRCNBBO", gc_4c_CaminhoClasses + "SIGPRCNBBO.prg")

            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF gnConnHandle <= 0
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                            "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                ELSE
                    THIS.ConfigurarPageFrame()
                    THIS.ConfigurarPaginaLista()
                    THIS.pgf_4c_Principal.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.pgf_4c_Principal.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.ConfigurarPaginaDados()
                    THIS.TornarControlesVisiveis()
                    THIS.ConfigurarBINDEVENTs()
                    THIS.InicializarValores()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o PageFrame com 2 paginas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Principal", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Principal

        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = -29
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = 1003
        loc_oPgf.Height    = 635
        loc_oPgf.TabIndex  = 1
        loc_oPgf.Tabs      = .T.

        loc_oPgf.Page1.Caption = "Filtro"
        loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        loc_oPgf.Page2.Caption = "Dados"
        loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.Enabled = .F.

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Constroi controles da Page1 (filtros + grid operacoes)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oP1, loc_oCnt, loc_oCgp

        loc_oP1 = THIS.pgf_4c_Principal.Page1

        *-- Container cabecalho (cntSombra)
        loc_oP1.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = loc_oP1.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = 1100
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100,100,100)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB"
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
                .BackStyle  = 0
                .AutoSize   = .F.
                .Caption    = "Gera" + CHR(231) + CHR(227) + "o de Arquivos CNAB"
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255,255,255)
            ENDWITH
        ENDWITH

        *-- CommandGroup Processar + Encerrar (cmdTestaPos)
        loc_oP1.AddObject("cgp_4c_Filtro", "CommandGroup")
        loc_oCgp = loc_oP1.cgp_4c_Filtro
        WITH loc_oCgp
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 85
            .Left          = 844
            .SpecialEffect = 1
            .Top           = -2
            .Width         = 160
            .TabIndex      = 12
            .BackColor     = RGB(240,240,240)
            .Themes        = .F.
            WITH .Command1
                .Top           = 5
                .Left          = 5
                .Height        = 75
                .Width         = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .WordWrap      = .T.
                .Picture       = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption       = "Processar"
                .MousePointer  = 15
                .SpecialEffect = 0
                .ForeColor     = RGB(90,90,90)
                .BackColor     = RGB(255,255,255)
                .Themes        = .F.
                .Name          = "btnProcessar"
            ENDWITH
            WITH .Command2
                .Top           = 5
                .Left          = 80
                .Height        = 75
                .Width         = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel        = .T.
                .Caption       = "Encerrar"
                .ToolTipText   = "[ESC] Encerrar"
                .ForeColor     = RGB(90,90,90)
                .BackColor     = RGB(255,255,255)
                .Themes        = .F.
                .Name          = "btnsair"
            ENDWITH
        ENDWITH

        *-- Label "Operacoes :" (Label1 - caption com hotkey para optProcessados)
        loc_oP1.AddObject("lbl_4c_LblOper", "Label")
        WITH loc_oP1.lbl_4c_LblOper
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Oper" + CHR(92) + CHR(60) + "a" + CHR(231) + CHR(245) + "es :"
            .Height     = 15
            .Left       = 279
            .Top        = 96
            .Width      = 68
            .TabIndex   = 13
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- OptionGroup processados
        loc_oP1.AddObject("opt_4c_Processados", "OptionGroup")
        WITH loc_oP1.opt_4c_Processados
            .BackStyle   = 0
            .BorderStyle = 0
            .ButtonCount = 2
            .Height      = 19
            .Left        = 344
            .Top         = 95
            .Width       = 235
            .Value       = 1
            .TabIndex    = 1
            WITH .Option1
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Processadas"
                .Left      = 5
                .Top       = 2
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
            ENDWITH
            WITH .Option2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "J" + CHR(225) + " Processadas"
                .Left      = 126
                .Top       = 2
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
            ENDWITH
        ENDWITH

        *-- Label "Empresa :"
        loc_oP1.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oP1.lbl_4c_LblEmpresa
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Empresa :"
            .Left       = 297
            .Top        = 123
            .Width      = 50
            .TabIndex   = 14
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox Codigo Empresa
        loc_oP1.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oP1.txt_4c_CdEmpresa
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 349
            .MaxLength     = 3
            .SpecialEffect = 1
            .TabIndex      = 2
            .Top           = 120
            .Width         = 31
            .Value         = ""
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- TextBox Descricao Empresa
        loc_oP1.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH loc_oP1.txt_4c_DsEmpresa
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 383
            .MaxLength     = 40
            .SpecialEffect = 1
            .TabIndex      = 3
            .Top           = 120
            .Width         = 290
            .Value         = ""
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- Label "Periodo :"
        loc_oP1.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oP1.lbl_4c_LblPeriodo
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Caption    = "Per" + CHR(237) + "odo :"
            .Left       = 302
            .Top        = 151
            .Width      = 45
            .TabIndex   = 16
            .BackStyle  = 0
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox Data Inicial
        loc_oP1.AddObject("txt_4c_Datai", "TextBox")
        WITH loc_oP1.txt_4c_Datai
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Format        = "KD"
            .BorderStyle   = 1
            .Value         = {}
            .Left          = 349
            .SpecialEffect = 1
            .TabIndex      = 4
            .Top           = 148
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- Label "ate"
        loc_oP1.AddObject("lbl_4c_LblAte", "Label")
        WITH loc_oP1.lbl_4c_LblAte
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .Caption   = "at" + CHR(233)
            .Left      = 434
            .Top       = 151
            .TabIndex  = 17
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- TextBox Data Final
        loc_oP1.AddObject("txt_4c_Dataf", "TextBox")
        WITH loc_oP1.txt_4c_Dataf
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Format        = "KD"
            .BorderStyle   = 1
            .Value         = {}
            .Left          = 457
            .SpecialEffect = 1
            .TabIndex      = 5
            .Top           = 148
            .Width         = 80
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- OptionGroup periodo (Vencimento / Emissao)
        loc_oP1.AddObject("opt_4c_Periodo", "OptionGroup")
        WITH loc_oP1.opt_4c_Periodo
            .AutoSize    = .F.
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 25
            .Left        = 544
            .Top         = 146
            .Width       = 168
            .Value       = 1
            .TabIndex    = 6
            WITH .Option1
                .BackStyle = 0
                .Caption   = "Vencimento"
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 73
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
            ENDWITH
            WITH .Option2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Emiss" + CHR(227) + "o"
                .Left      = 96
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
            ENDWITH
        ENDWITH

        *-- Label "Banco :"
        loc_oP1.AddObject("lbl_4c_LblBanco", "Label")
        WITH loc_oP1.lbl_4c_LblBanco
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Caption    = "Banco :"
            .Left       = 309
            .Top        = 180
            .Width      = 38
            .TabIndex   = 18
            .BackStyle  = 0
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox Codigo Conta Bancaria
        loc_oP1.AddObject("txt_4c_CdConta", "TextBox")
        WITH loc_oP1.txt_4c_CdConta
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 349
            .MaxLength     = 10
            .SpecialEffect = 1
            .TabIndex      = 7
            .Top           = 176
            .Width         = 79
            .Value         = ""
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- TextBox Descricao Conta Bancaria
        loc_oP1.AddObject("txt_4c_DsConta", "TextBox")
        WITH loc_oP1.txt_4c_DsConta
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 430
            .MaxLength     = 40
            .SpecialEffect = 1
            .TabIndex      = 8
            .Top           = 176
            .Width         = 290
            .Value         = ""
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- Label "Titulo Banco :"
        loc_oP1.AddObject("lbl_4c_LblTitBan", "Label")
        WITH loc_oP1.lbl_4c_LblTitBan
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Caption    = "T" + CHR(237) + "tulo Banco : "
            .Left       = 280
            .Top        = 206
            .Width      = 70
            .Height     = 15
            .TabIndex   = 19
            .BackStyle  = 0
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox Titulo Banco (FPagsGru)
        loc_oP1.AddObject("txt_4c_TitBan", "TextBox")
        WITH loc_oP1.txt_4c_TitBan
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 23
            .Left          = 348
            .MaxLength     = 12
            .SpecialEffect = 1
            .TabIndex      = 9
            .Top           = 203
            .Width         = 94
            .Value         = ""
            .ForeColor     = RGB(0,0,0)
            .BorderColor   = RGB(100,100,100)
        ENDWITH

        *-- Label "Operacao :" (acima do grid SigCdOpe)
        loc_oP1.AddObject("lbl_4c_LblOperGrid", "Label")
        WITH loc_oP1.lbl_4c_LblOperGrid
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Opera" + CHR(231) + CHR(227) + "o :"
            .Left       = 291
            .Top        = 234
            .TabIndex   = 20
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- Grid de Operacoes SigCdOpe (grdope)
        loc_oP1.AddObject("grd_4c_Operacoes", "Grid")
        WITH loc_oP1.grd_4c_Operacoes
            .ColumnCount       = 2
            .FontName          = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .GridLines         = 3
            .Height            = 344
            .Left              = 350
            .Panel             = 1
            .ScrollBars        = 2
            .SplitBar          = .F.
            .TabIndex          = 10
            .Top               = 232
            .Width             = 202
            .GridLineColor     = RGB(238,238,238)
            .Themes            = .F.
            .Column1.Width     = 18
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.Sparse    = .F.
            .Column1.AddObject("Check1", "CheckBox")
            .Column1.Check1.Caption = ""
            .Column1.Check1.Value   = 0
            .Column1.CurrentControl = "Check1"
            .Column2.Width     = 150
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.
            .RecordMark   = .F.
        ENDWITH

        *-- CommandGroup Marcar/Desmarcar operacoes SigCdOpe (Commandgroup2)
        loc_oP1.AddObject("cgp_4c_MarcaOpe", "CommandGroup")
        WITH loc_oP1.cgp_4c_MarcaOpe
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .Height        = 91
            .Left          = 563
            .SpecialEffect = 1
            .Top           = 315
            .Width         = 50
            .TabIndex      = 11
            .BackColor     = RGB(240,240,240)
            .Themes        = .F.
            WITH .Command1
                .Top         = 5
                .Left        = 5
                .Height      = 40
                .Width       = 40
                .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Caption     = ""
                .ToolTipText = "Marcar tudo"
                .ForeColor   = RGB(36,84,155)
                .BackColor   = RGB(255,255,255)
                .Themes      = .F.
                .Name        = "btnmarca"
            ENDWITH
            WITH .Command2
                .Top         = 46
                .Left        = 5
                .Height      = 40
                .Width       = 40
                .FontName    = "Verdana"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption     = ""
                .ToolTipText = "Desmarcar tudo"
                .ForeColor   = RGB(36,84,155)
                .BackColor   = RGB(255,255,255)
                .Themes      = .F.
                .Name        = "btndesmarca"
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Constroi controles da Page2 (dados de titulos)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oP2, loc_oCgp

        loc_oP2 = THIS.pgf_4c_Principal.Page2

        *-- Indicador EndErro (Botao1 - caixinha vermelha)
        loc_oP2.AddObject("txt_4c_EndErroInd", "TextBox")
        WITH loc_oP2.txt_4c_EndErroInd
            .BackColor     = RGB(255,0,0)
            .BorderStyle   = 0
            .ReadOnly      = .T.
            .SpecialEffect = 0
            .Height        = 16
            .Left          = 370
            .Top           = 14
            .Width         = 17
            .TabStop       = .F.
            .Value         = ""
        ENDWITH

        *-- Label descricao EndErro
        loc_oP2.AddObject("lbl_4c_EndErroInfo", "Label")
        WITH loc_oP2.lbl_4c_EndErroInfo
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .Caption   = "Endere" + CHR(231) + "os com tamanho maior que 40 caracteres"
            .Height    = 15
            .Left      = 390
            .Top       = 15
            .Width     = 238
            .ForeColor = RGB(255,0,0)
        ENDWITH

        *-- Label "Protestar apos :"
        loc_oP2.AddObject("lbl_4c_Protestar", "Label")
        WITH loc_oP2.lbl_4c_Protestar
            .Caption  = "Protestar ap" + CHR(243) + "s :"
            .Enabled  = .F.
            .Height   = 15
            .Left     = 370
            .Top      = 103
            .Width    = 80
            .TabIndex = 5
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- Spinner dias protesto (spndias)
        loc_oP2.AddObject("spn_4c_Dias", "Spinner")
        WITH loc_oP2.spn_4c_Dias
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Enabled           = .F.
            .Height            = 24
            .KeyboardHighValue = 99
            .KeyboardLowValue  = 0
            .Left              = 451
            .SpecialEffect     = 1
            .SpinnerHighValue  = 99
            .SpinnerLowValue   = 0
            .TabIndex          = 7
            .Top               = 98
            .Width             = 45
            .Value             = 5
        ENDWITH

        *-- Label "dias"
        loc_oP2.AddObject("lbl_4c_Dias", "Label")
        WITH loc_oP2.lbl_4c_Dias
            .Caption  = "dias"
            .Enabled  = .F.
            .Height   = 15
            .Left     = 501
            .Top      = 103
            .Width    = 21
            .TabIndex = 6
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- Grid de Titulos (grdope)
        loc_oP2.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oP2.grd_4c_Dados
            .ColumnCount       = 8
            .FontName          = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .Height            = 401
            .Left              = 7
            .Panel             = 1
            .RecordMark        = .F.
            .ScrollBars        = 2
            .SplitBar          = .F.
            .TabIndex          = 1
            .Top               = 134
            .Width             = 981
            .GridLineColor     = RGB(238,238,238)
            .Themes            = .F.
            .Column1.Width     = 18
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column1.Sparse    = .F.
            .Column1.AddObject("Check1", "CheckBox")
            .Column1.Check1.Caption = ""
            .Column1.Check1.Value   = 0
            .Column1.CurrentControl = "Check1"
            .Column2.Width     = 65
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly  = .T.
            .Column3.Width     = 60
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column3.ReadOnly  = .T.
            .Column4.Width     = 140
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
            .Column4.ReadOnly  = .T.
            .Column5.Width     = 75
            .Column5.Movable   = .F.
            .Column5.Resizable = .F.
            .Column5.ReadOnly  = .T.
            .Column6.Width     = 80
            .Column6.Movable   = .F.
            .Column6.Resizable = .F.
            .Column6.ReadOnly  = .T.
            .Column7.Width     = 75
            .Column7.Movable   = .F.
            .Column7.Resizable = .F.
            .Column7.ReadOnly  = .T.
            .Column8.Width     = 460
            .Column8.Movable   = .F.
            .Column8.Resizable = .F.
            .Column8.ReadOnly  = .T.
        ENDWITH

        *-- CommandGroup Encerrar (cmdTestaPos - volta para Page1)
        loc_oP2.AddObject("cgp_4c_Encerrar", "CommandGroup")
        loc_oCgp = loc_oP2.cgp_4c_Encerrar
        WITH loc_oCgp
            .AutoSize      = .T.
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .Height        = 85
            .Left          = 917
            .SpecialEffect = 1
            .Top           = -3
            .Width         = 85
            .TabIndex      = 2
            .BackColor     = RGB(240,240,240)
            .Themes        = .F.
            WITH .Command1
                .Top           = 5
                .Left          = 5
                .Height        = 75
                .Width         = 75
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel        = .T.
                .Caption       = "Encerrar"
                .ToolTipText   = "[ESC] Encerrar"
                .ForeColor     = RGB(90,90,90)
                .BackColor     = RGB(255,255,255)
                .Themes        = .F.
                .Name          = "btnsair"
            ENDWITH
        ENDWITH

        *-- CommandGroup acoes CNAB/Relatorio/Boleto (Commandgroup1)
        loc_oP2.AddObject("cgp_4c_Acoes", "CommandGroup")
        loc_oCgp = loc_oP2.cgp_4c_Acoes
        WITH loc_oCgp
            .AutoSize      = .T.
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .Height        = 85
            .Left          = 692
            .SpecialEffect = 1
            .Top           = -3
            .Width         = 235
            .TabIndex      = 3
            .BackColor     = RGB(240,240,240)
            .Themes        = .F.
            WITH .Command1
                .Top      = 5
                .Left     = 5
                .Height   = 75
                .Width    = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .Picture  = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .Caption  = "Gerar CNAB"
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
                .Themes   = .F.
                .Name     = "btncnab"
            ENDWITH
            WITH .Command2
                .Top      = 5
                .Left     = 80
                .Height   = 75
                .Width    = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .Picture  = gc_4c_CaminhoIcones + "geral_video_60.jpg"
                .Caption  = "Relat" + CHR(243) + "rio"
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
                .Themes   = .F.
                .Name     = "btnrelatorio"
            ENDWITH
            WITH .Command3
                .Top      = 5
                .Left     = 155
                .Height   = 75
                .Width    = 75
                .FontBold = .T.
                .FontItalic = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .Picture  = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                .Caption  = "Boleto"
                .Enabled  = .F.
                .ForeColor = RGB(90,90,90)
                .BackColor = RGB(255,255,255)
                .Themes   = .F.
                .Name     = "btnBoleto"
            ENDWITH
        ENDWITH

        *-- CommandGroup Marcar/Desmarcar titulos (Commandgroup2)
        loc_oP2.AddObject("cgp_4c_MarcaDados", "CommandGroup")
        WITH loc_oP2.cgp_4c_MarcaDados
            .AutoSize      = .F.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 0
            .Height        = 50
            .Left          = 7
            .SpecialEffect = 1
            .Top           = 543
            .Width         = 92
            .TabIndex      = 4
            .BackColor     = RGB(240,240,240)
            .Themes        = .F.
            WITH .Command1
                .Top     = 5
                .Left    = 7
                .Height  = 40
                .Width   = 40
                .Picture  = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Caption  = ""
                .ToolTipText = "Marcar tudo"
                .ForeColor = RGB(36,84,155)
                .BackColor = RGB(255,255,255)
                .Themes   = .F.
                .Name     = "btnmarca"
            ENDWITH
            WITH .Command2
                .Top     = 5
                .Left    = 47
                .Height  = 40
                .Width   = 40
                .FontName = "Verdana"
                .FontSize = 8
                .Picture  = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption  = ""
                .ToolTipText = "Desmarcar tudo"
                .ForeColor = RGB(36,84,155)
                .BackColor = RGB(255,255,255)
                .Themes   = .F.
                .Name     = "btndesmarca"
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oP1, loc_oP2, loc_oPgf

        loc_oPgf = THIS.pgf_4c_Principal
        loc_oPgf.Visible = .T.

        loc_oP1 = loc_oPgf.Page1
        loc_oP1.cnt_4c_Sombra.Visible              = .T.
        loc_oP1.cnt_4c_Sombra.lbl_4c_Sombra.Visible = .T.
        loc_oP1.cnt_4c_Sombra.lbl_4c_Titulo.Visible = .T.
        loc_oP1.cgp_4c_Filtro.Visible              = .T.
        loc_oP1.lbl_4c_LblOper.Visible             = .T.
        loc_oP1.opt_4c_Processados.Visible          = .T.
        loc_oP1.lbl_4c_LblEmpresa.Visible           = .T.
        loc_oP1.txt_4c_CdEmpresa.Visible            = .T.
        loc_oP1.txt_4c_DsEmpresa.Visible            = .T.
        loc_oP1.lbl_4c_LblPeriodo.Visible           = .T.
        loc_oP1.txt_4c_Datai.Visible                = .T.
        loc_oP1.lbl_4c_LblAte.Visible               = .T.
        loc_oP1.txt_4c_Dataf.Visible                = .T.
        loc_oP1.opt_4c_Periodo.Visible              = .T.
        loc_oP1.lbl_4c_LblBanco.Visible             = .T.
        loc_oP1.txt_4c_CdConta.Visible              = .T.
        loc_oP1.txt_4c_DsConta.Visible              = .T.
        loc_oP1.lbl_4c_LblTitBan.Visible            = .T.
        loc_oP1.txt_4c_TitBan.Visible               = .T.
        loc_oP1.lbl_4c_LblOperGrid.Visible          = .T.
        loc_oP1.grd_4c_Operacoes.Visible            = .T.
        loc_oP1.cgp_4c_MarcaOpe.Visible             = .T.

        loc_oP2 = loc_oPgf.Page2
        loc_oP2.txt_4c_EndErroInd.Visible           = .T.
        loc_oP2.lbl_4c_EndErroInfo.Visible          = .T.
        loc_oP2.lbl_4c_Protestar.Visible            = .T.
        loc_oP2.spn_4c_Dias.Visible                 = .T.
        loc_oP2.lbl_4c_Dias.Visible                 = .T.
        loc_oP2.grd_4c_Dados.Visible                = .T.
        loc_oP2.cgp_4c_Encerrar.Visible             = .T.
        loc_oP2.cgp_4c_Acoes.Visible                = .T.
        loc_oP2.cgp_4c_MarcaDados.Visible           = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Liga eventos aos handlers do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        LOCAL loc_oP1, loc_oP2

        loc_oP1 = THIS.pgf_4c_Principal.Page1
        loc_oP2 = THIS.pgf_4c_Principal.Page2

        *-- Botoes filtro
        BINDEVENT(loc_oP1.cgp_4c_Filtro.Command1, "Click", THIS, "ClickProcessar")
        BINDEVENT(loc_oP1.cgp_4c_Filtro.Command2, "Click", THIS, "ClickEncerrarFiltro")

        *-- Validacao e lookup campos filtro
        BINDEVENT(loc_oP1.txt_4c_CdEmpresa, "KeyPress", THIS, "TxtCdEmpresaKeyPress")
        BINDEVENT(loc_oP1.txt_4c_CdEmpresa, "DblClick", THIS, "AbrirLookupEmpresa")
        BINDEVENT(loc_oP1.txt_4c_DsEmpresa, "KeyPress", THIS, "TxtDsEmpresaKeyPress")
        BINDEVENT(loc_oP1.txt_4c_CdConta,   "KeyPress", THIS, "TxtCdContaKeyPress")
        BINDEVENT(loc_oP1.txt_4c_CdConta,   "DblClick", THIS, "AbrirLookupConta")
        BINDEVENT(loc_oP1.txt_4c_DsConta,   "KeyPress", THIS, "TxtDsContaKeyPress")
        BINDEVENT(loc_oP1.txt_4c_TitBan,    "KeyPress", THIS, "TxtTitBanKeyPress")
        BINDEVENT(loc_oP1.txt_4c_TitBan,    "DblClick", THIS, "AbrirLookupTitBan")
        BINDEVENT(loc_oP1.txt_4c_Dataf,     "KeyPress", THIS, "TxtDatafKeyPress")

        *-- Marcar/desmarcar operacoes SigCdOpe
        BINDEVENT(loc_oP1.cgp_4c_MarcaOpe.Command1, "Click", THIS, "ClickMarcarOpe")
        BINDEVENT(loc_oP1.cgp_4c_MarcaOpe.Command2, "Click", THIS, "ClickDesmarcarOpe")

        *-- Botoes Page2
        BINDEVENT(loc_oP2.cgp_4c_Encerrar.Command1, "Click", THIS, "ClickEncerrarDados")
        BINDEVENT(loc_oP2.cgp_4c_Acoes.Command1,    "Click", THIS, "ClickGerarCNAB")
        BINDEVENT(loc_oP2.cgp_4c_Acoes.Command2,    "Click", THIS, "ClickRelatorio")
        BINDEVENT(loc_oP2.cgp_4c_Acoes.Command3,    "Click", THIS, "ClickBoleto")

        *-- Marcar/desmarcar titulos
        BINDEVENT(loc_oP2.cgp_4c_MarcaDados.Command1, "Click", THIS, "ClickMarcarTitulos")
        BINDEVENT(loc_oP2.cgp_4c_MarcaDados.Command2, "Click", THIS, "ClickDesmarcarTitulos")
    ENDPROC

    *==========================================================================
    * InicializarValores - Carrega dados iniciais (operacoes SigCdOpe, formas pagto)
    *==========================================================================
    PROTECTED PROCEDURE InicializarValores()
        LOCAL loc_oGrd

        *-- Carrega operacoes de cobranca (SigCdOpe) no grid da pagina de filtro
        IF THIS.this_oBusinessObject.BuscarOperacoes()
            loc_oGrd = THIS.pgf_4c_Principal.Page1.grd_4c_Operacoes
            loc_oGrd.ColumnCount = 2
            loc_oGrd.RecordSource          = "cursor_4c_Operacoes"
            loc_oGrd.Column1.ControlSource = "cursor_4c_Operacoes.marca"
            loc_oGrd.Column2.ControlSource = "cursor_4c_Operacoes.Dopes"
            loc_oGrd.Column1.Header1.Caption = ""
            loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            loc_oGrd.Column2.Header1.Alignment = 2
            loc_oGrd.Refresh()
        ENDIF

        *-- Pre-carrega formas de pagamento para lookup do Titulo Banco
        THIS.this_oBusinessObject.BuscarFormaPagamento()

        THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.SetFocus()
    ENDPROC

    *==========================================================================
    * VALIDADORES DOS CAMPOS
    *==========================================================================

    PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cCod, loc_cSQL
        loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cCod)
            THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ""
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 RazSocs FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCod)
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
            SELECT cursor_4c_EmpTmpV
            THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
        ELSE
            THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value = ""
            THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ""
            MsgAviso("Empresa inv" + CHR(225) + "lida.")
        ENDIF
        IF USED("cursor_4c_EmpTmpV")
            USE IN cursor_4c_EmpTmpV
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsEmpresa()
        LOCAL loc_cDs, loc_cSQL
        loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cDs)
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 Cemps, RazSocs FROM SigCdEmp WHERE RazSocs LIKE " + EscaparSQL(loc_cDs + "%")
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmpV") >= 1 AND RECCOUNT("cursor_4c_EmpTmpV") > 0
            SELECT cursor_4c_EmpTmpV
            THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.Cemps)
            THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpTmpV.RazSocs)
        ELSE
            THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value = ""
            THIS.pgf_4c_Principal.Page1.txt_4c_DsEmpresa.Value = ""
        ENDIF
        IF USED("cursor_4c_EmpTmpV")
            USE IN cursor_4c_EmpTmpV
        ENDIF
    ENDPROC

    PROCEDURE ValidarCdConta()
        LOCAL loc_cCod, loc_cGrupo, loc_llRet
        loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_CdConta.Value)
        IF EMPTY(loc_cCod)
            THIS.pgf_4c_Principal.Page1.txt_4c_DsConta.Value = ""
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cGrupo = ""
        loc_llRet = fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cCod, ;
                    THIS.pgf_4c_Principal.Page1.txt_4c_CdConta, ;
                    THIS.pgf_4c_Principal.Page1.txt_4c_DsConta)
        IF !loc_llRet
            MsgAviso("Conta inv" + CHR(225) + "lida, acesso negado.")
            THIS.pgf_4c_Principal.Page1.txt_4c_CdConta.Value = ""
            THIS.pgf_4c_Principal.Page1.txt_4c_DsConta.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsConta()
        LOCAL loc_cDs, loc_cGrupo, loc_llRet
        loc_cDs = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_DsConta.Value)
        IF EMPTY(loc_cDs)
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cGrupo = ""
        loc_llRet = fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cDs, ;
                    THIS.pgf_4c_Principal.Page1.txt_4c_CdConta, ;
                    THIS.pgf_4c_Principal.Page1.txt_4c_DsConta)
        IF !loc_llRet
            THIS.pgf_4c_Principal.Page1.txt_4c_CdConta.Value = ""
            THIS.pgf_4c_Principal.Page1.txt_4c_DsConta.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE ValidarTitBan()
        LOCAL loc_cCod
        loc_cCod = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        IF USED("cursor_4c_FormaPagto")
            SELECT cursor_4c_FormaPagto
            SEEK PADR(loc_cCod, 12) ORDER TAG FpagSgru
            IF !FOUND("cursor_4c_FormaPagto")
                MsgAviso("T" + CHR(237) + "tulo Banco inv" + CHR(225) + "lido.")
                THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ValidarDataf()
        LOCAL loc_dDatf, loc_dDati
        loc_dDatf = THIS.pgf_4c_Principal.Page1.txt_4c_Dataf.Value
        loc_dDati = THIS.pgf_4c_Principal.Page1.txt_4c_Datai.Value
        IF !EMPTY(loc_dDati) AND !EMPTY(loc_dDatf) AND loc_dDatf < loc_dDati
            MsgAviso("Data Final Deve Ser Maior Que a Inicial!!!")
            THIS.pgf_4c_Principal.Page1.txt_4c_Dataf.Value = {}
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS KEYPRESS
    *==========================================================================

    PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TxtCdContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdConta()
        ENDIF
    ENDPROC

    PROCEDURE TxtDsContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsConta()
        ENDIF
    ENDPROC

    PROCEDURE TxtTitBanKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupTitBan()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarTitBan()
        ENDIF
    ENDPROC

    PROCEDURE TxtDatafKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDataf()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS
    *==========================================================================

    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_oP1
        loc_oP1 = THIS.pgf_4c_Principal.Page1
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpresa", "Cemps", ;
            ALLTRIM(loc_oP1.txt_4c_CdEmpresa.Value), "Buscar Empresa")
        loc_oBusca.mAddColuna("Cemps",   "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("RazSocs", "", "Raz" + CHR(227) + "o Social")
        loc_oBusca.mAddColuna("Cgcs",    "", "CNPJ")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
            SELECT cursor_4c_BuscaEmpresa
            loc_oP1.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
            loc_oP1.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.RazSocs)
        ENDIF
        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROCEDURE AbrirLookupConta()
        LOCAL loc_oBusca, loc_oP1
        loc_oP1 = THIS.pgf_4c_Principal.Page1
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaConta", "IClis", ;
            ALLTRIM(loc_oP1.txt_4c_CdConta.Value), "Buscar Conta Banc" + CHR(225) + "ria")
        loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
            SELECT cursor_4c_BuscaConta
            loc_oP1.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
            loc_oP1.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
        ENDIF
        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROCEDURE AbrirLookupTitBan()
        LOCAL loc_oBusca, loc_oP1
        loc_oP1 = THIS.pgf_4c_Principal.Page1
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpFp", "cursor_4c_BuscaTitBan", "Fpags", ;
            ALLTRIM(loc_oP1.txt_4c_TitBan.Value), ;
            "Buscar T" + CHR(237) + "tulo Banco", ;
            "Situas IN ('R','A') AND Infos = 'K'")
        loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTitBan")
            SELECT cursor_4c_BuscaTitBan
            loc_oP1.txt_4c_TitBan.Value = PADR(ALLTRIM(cursor_4c_BuscaTitBan.Fpags), 12)
        ENDIF
        IF USED("cursor_4c_BuscaTitBan")
            USE IN cursor_4c_BuscaTitBan
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES
    *==========================================================================

    PROCEDURE ClickProcessar()
        LOCAL loc_cCdEmp, loc_dDati, loc_dDatf, loc_cCdConta, loc_nCont

        loc_cCdEmp   = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.Value)
        loc_dDati    = THIS.pgf_4c_Principal.Page1.txt_4c_Datai.Value
        loc_dDatf    = THIS.pgf_4c_Principal.Page1.txt_4c_Dataf.Value
        loc_cCdConta = ALLTRIM(THIS.pgf_4c_Principal.Page1.txt_4c_CdConta.Value)

        IF EMPTY(loc_cCdEmp)
            MsgAviso("Empresa inv" + CHR(225) + "lida")
            THIS.pgf_4c_Principal.Page1.txt_4c_CdEmpresa.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_dDati) OR EMPTY(loc_dDatf)
            MsgAviso("Per" + CHR(237) + "odo inv" + CHR(225) + "lido")
            THIS.pgf_4c_Principal.Page1.txt_4c_Datai.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cCdConta)
            MsgAviso("Banco inv" + CHR(225) + "lido")
            THIS.pgf_4c_Principal.Page1.txt_4c_CdConta.SetFocus()
            RETURN
        ENDIF

        loc_nCont = 0
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            SCAN
                IF cursor_4c_Operacoes.marca
                    loc_nCont = loc_nCont + 1
                ENDIF
            ENDSCAN
        ENDIF
        IF loc_nCont = 0
            MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o foi selecionada")
            RETURN
        ENDIF

        THIS.Processamento()
    ENDPROC

    PROCEDURE ClickEncerrarFiltro()
        THIS.Release()
    ENDPROC

    PROCEDURE ClickEncerrarDados()
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE ClickGerarCNAB()
        THIS.GerarCNAB("A")
    ENDPROC

    PROCEDURE ClickRelatorio()
        THIS.GerarCNAB("V")
    ENDPROC

    PROCEDURE ClickBoleto()
        THIS.GerarCNAB("I")
        THIS.ImpBoleto(.T.)
    ENDPROC

    PROCEDURE ClickMarcarOpe()
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            REPLACE ALL marca WITH .T.
            GO TOP
            THIS.pgf_4c_Principal.Page1.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ClickDesmarcarOpe()
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            REPLACE ALL marca WITH .F.
            GO TOP
            THIS.pgf_4c_Principal.Page1.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ClickMarcarTitulos()
        IF USED("cursor_4c_Filtro")
            SELECT cursor_4c_Filtro
            REPLACE ALL marca WITH .T.
            GO TOP
            THIS.pgf_4c_Principal.Page2.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ClickDesmarcarTitulos()
        IF USED("cursor_4c_Filtro")
            SELECT cursor_4c_Filtro
            REPLACE ALL marca WITH .F.
            GO TOP
            THIS.pgf_4c_Principal.Page2.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * Processamento - Executa busca de titulos e muda para page2
    *==========================================================================
    PROCEDURE Processamento()
        LOCAL loc_oP1, loc_oP2, loc_oGrd, loc_oBO
        LOCAL loc_cCdEmp, loc_cCdConta, loc_dDati, loc_dDatf
        LOCAL loc_lNaoProc, loc_nPeriodo, loc_cOpeIN

        loc_oP1  = THIS.pgf_4c_Principal.Page1
        loc_oP2  = THIS.pgf_4c_Principal.Page2
        loc_oGrd = loc_oP2.grd_4c_Dados
        loc_oBO  = THIS.this_oBusinessObject

        loc_cCdEmp   = ALLTRIM(loc_oP1.txt_4c_CdEmpresa.Value)
        loc_cCdConta = ALLTRIM(loc_oP1.txt_4c_CdConta.Value)
        loc_dDati    = loc_oP1.txt_4c_Datai.Value
        loc_dDatf    = loc_oP1.txt_4c_Dataf.Value
        loc_lNaoProc = (loc_oP1.opt_4c_Processados.Value = 1)
        loc_nPeriodo = loc_oP1.opt_4c_Periodo.Value

        *-- Monta clausula IN das operacoes marcadas
        loc_cOpeIN = "("
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            SCAN
                IF cursor_4c_Operacoes.marca
                    loc_cOpeIN = loc_cOpeIN + IIF(loc_cOpeIN == "(", "", ",") + ;
                                 "'" + ALLTRIM(cursor_4c_Operacoes.Dopes) + "'"
                ENDIF
            ENDSCAN
        ENDIF
        loc_cOpeIN = loc_cOpeIN + ")"

        *-- Limpa grid
        loc_oGrd.RecordSource = ""
        loc_oGrd.Refresh()

        IF !loc_oBO.BuscarTitulos(loc_cCdEmp, loc_dDati, loc_dDatf, ;
                IIF(loc_lNaoProc, 1, 2), loc_nPeriodo, loc_cOpeIN)
            RETURN
        ENDIF

        IF RECCOUNT("cursor_4c_Filtro") = 0
            MsgAviso("Nenhum dado foi encontrado")
            RETURN
        ENDIF

        *-- Liga grid ao cursor
        loc_oGrd.ColumnCount = 8
        loc_oGrd.RecordSource          = "cursor_4c_Filtro"
        loc_oGrd.Column1.ControlSource = "cursor_4c_Filtro.marca"
        loc_oGrd.Column2.ControlSource = "cursor_4c_Filtro.dopes"
        loc_oGrd.Column3.ControlSource = "cursor_4c_Filtro.numes"
        loc_oGrd.Column4.ControlSource = "cursor_4c_Filtro.rclis"
        loc_oGrd.Column5.ControlSource = "cursor_4c_Filtro.vencs"
        loc_oGrd.Column6.ControlSource = "cursor_4c_Filtro.fpags"
        loc_oGrd.Column7.ControlSource = "cursor_4c_Filtro.valos"
        loc_oGrd.Column8.ControlSource = "cursor_4c_Filtro.titulos"
        loc_oGrd.Column1.Header1.Caption = ""
        loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column3.Header1.Caption = "C" + CHR(243) + "digo"
        loc_oGrd.Column4.Header1.Caption = "Cliente"
        loc_oGrd.Column5.Header1.Caption = "Vencimento"
        loc_oGrd.Column6.Header1.Caption = "Forma Pagto"
        loc_oGrd.Column7.Header1.Caption = "Valor"
        loc_oGrd.Column8.Header1.Caption = "T" + CHR(237) + "tulo"
        loc_oGrd.SetAll("DynamicForeColor", "IIF(cursor_4c_Filtro.EndErro=1,RGB(255,0,0),RGB(0,0,0))", "Column")
        loc_oGrd.Refresh()

        *-- Habilita boleto apenas quando mostrando "Ja Processados"
        loc_oP2.cgp_4c_Acoes.Command3.Enabled = !loc_lNaoProc

        *-- Ativa protestar dias
        loc_oP2.lbl_4c_Protestar.Enabled = .T.
        loc_oP2.spn_4c_Dias.Enabled = .T.
        loc_oP2.lbl_4c_Dias.Enabled = .T.

        *-- Muda para page2
        loc_oP1.Enabled = .F.
        loc_oP2.Enabled = .T.
        THIS.pgf_4c_Principal.ActivePage = 2
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre pagina de filtro (1) e pagina de dados (2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oP1, loc_oP2
        loc_oP1 = THIS.pgf_4c_Principal.Page1
        loc_oP2 = THIS.pgf_4c_Principal.Page2

        IF par_nPagina = 1
            loc_oP2.grd_4c_Dados.RecordSource = ""
            loc_oP1.Enabled = .T.
            loc_oP2.Enabled = .F.
            THIS.pgf_4c_Principal.ActivePage = 1
        ELSE
            loc_oP1.Enabled = .F.
            loc_oP2.Enabled = .T.
            THIS.pgf_4c_Principal.ActivePage = 2
        ENDIF
    ENDPROC

    *==========================================================================
    * GerarCNAB - Despacha geracao de arquivo CNAB por banco ou cria preview
    * par_cTipo: "A"=Gerar arquivo, "V"=Preview relatorio, "I"=Prep boleto
    *==========================================================================
    PROCEDURE GerarCNAB(par_cTipo)
        LOCAL loc_oBO, loc_oP1, loc_oP2
        LOCAL loc_cCdEmp, loc_cCdConta, loc_cTitBan
        LOCAL loc_dDati, loc_dDatf, loc_nCont

        loc_oBO     = THIS.this_oBusinessObject
        loc_oP1     = THIS.pgf_4c_Principal.Page1
        loc_oP2     = THIS.pgf_4c_Principal.Page2
        loc_cCdEmp  = ALLTRIM(loc_oP1.txt_4c_CdEmpresa.Value)
        loc_cCdConta= ALLTRIM(loc_oP1.txt_4c_CdConta.Value)
        loc_cTitBan = loc_oP1.txt_4c_TitBan.Value
        loc_dDati   = loc_oP1.txt_4c_Datai.Value
        loc_dDatf   = loc_oP1.txt_4c_Dataf.Value

        *-- Carrega empresa
        IF !loc_oBO.CarregarEmpresa(loc_cCdEmp)
            MsgAviso("N" + CHR(227) + "o foi encontrada a Raz" + CHR(227) + "o Social e/ou o " + ;
                     "CNPJ da Empresa [" + loc_cCdEmp + "]. " + ;
                     "Complete os dados no Cadastro de Empresas.")
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(loc_oBO.this_cRazSocs)) OR EMPTY(ALLTRIM(loc_oBO.this_cCgcs))
            MsgAviso("N" + CHR(227) + "o foi encontrada a Raz" + CHR(227) + "o Social e/ou o " + ;
                     "CNPJ da Empresa [" + loc_cCdEmp + "].")
            RETURN
        ENDIF

        IF par_cTipo = "A"
            *-- Valida selecao de registros
            loc_nCont = 0
            IF USED("cursor_4c_Filtro")
                SELECT cursor_4c_Filtro
                SCAN
                    IF cursor_4c_Filtro.marca
                        loc_nCont = loc_nCont + 1
                    ENDIF
                ENDSCAN
            ENDIF
            IF loc_nCont = 0
                MsgAviso("Nenhum registro foi selecionado")
                RETURN
            ENDIF

            *-- Confirma geracao
            IF !EMPTY(ALLTRIM(loc_cTitBan))
                IF !MsgConfirma("Confirma gera" + CHR(231) + CHR(227) + "o do arquivo de remessa?")
                    RETURN
                ENDIF
            ELSE
                IF !MsgConfirma("O campo " + CHR(34) + "T" + CHR(237) + "tulo Banco" + CHR(34) + ;
                                " n" + CHR(227) + "o foi preenchido. Continuar?")
                    RETURN
                ENDIF
            ENDIF

            *-- Carrega convenio
            IF !loc_oBO.CarregarConvenio(loc_cCdConta)
                MsgAviso("N" + CHR(227) + "o foi encontrado o N" + CHR(250) + "mero da Ag" + CHR(234) + ;
                         "ncia e/ou o C" + CHR(243) + "digo do Conv" + CHR(234) + "nio para o Banco [" + ;
                         loc_cCdConta + "]. Complete os Dados no Cadastro de Contas.")
                loc_oP1.txt_4c_CdConta.SetFocus()
                RETURN
            ENDIF

            *-- Atualiza spinner dias do convenio
            IF loc_oBO.this_nDiasProtConvenio > 0
                loc_oP2.spn_4c_Dias.Value = loc_oBO.this_nDiasProtConvenio
            ELSE
                loc_oP2.spn_4c_Dias.Value = 5
            ENDIF

            SET SAFETY OFF

            *-- Despacha por banco
            DO CASE
                CASE ALLTRIM(loc_oBO.this_cBancoNr) = "001"
                    THIS.CnabBrasil()

                CASE ALLTRIM(loc_oBO.this_cBancoNr) = "341"
                    THIS.this_cArqCNAB = GETFILE("txt", "Arquivo", "OK", 0, "Arquivo CNAB")
                    IF EMPTY(THIS.this_cArqCNAB)
                        RETURN
                    ENDIF
                    THIS.CnabItau()

                CASE ALLTRIM(loc_oBO.this_cBancoNr) = "237"
                    THIS.CnabBradesco()

                CASE INLIST(ALLTRIM(loc_oBO.this_cBancoNr), "033", "353")
                    THIS.CnabSantander240()
                    *-- Habilita boleto apos Santander
                    loc_oP2.cgp_4c_Acoes.Command3.Enabled = .T.

                OTHERWISE
                    MsgAviso("Banco " + CHR(34) + ALLTRIM(loc_oBO.this_cBancoNr) + CHR(34) + ;
                             " n" + CHR(227) + "o suportado para gera" + CHR(231) + CHR(227) + "o CNAB.")
            ENDCASE

        ELSE
            *-- "V" ou "I": carrega convenio e cria cursor_4c_Filtro2 para relatorio/boleto
            IF !loc_oBO.CarregarConvenio(loc_cCdConta)
                MsgAviso("Conv" + CHR(234) + "nio n" + CHR(227) + "o encontrado para a conta [" + ;
                         loc_cCdConta + "].")
                RETURN
            ENDIF

            IF USED("cursor_4c_Filtro2")
                USE IN cursor_4c_Filtro2
            ENDIF

            SELECT *, SPACE(15) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
                INTO CURSOR cursor_4c_Filtro2 READWRITE

            SELECT cursor_4c_Filtro2
            GO TOP

            IF par_cTipo = "V"
                REPORT FORM sigrecnb PREVIEW
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CnabBrasil - Gera arquivo CNAB 400 para Banco do Brasil (001)
    *==========================================================================
    PROTECTED PROCEDURE CnabBrasil()
        LOCAL loc_oBO, loc_oP2
        LOCAL lcTit, lcBanco, lcCnv, lcAge, lcbco, lcRaz, lcCgc, lctpcgc, lcrazbco
        LOCAL lcDat, lnMor, lcPri, lcprot, lcCdC, lcTpCtArq, lcTpCtBol, lcEnv, lcArq
        LOCAL lcStrg, lnSeq, lcSeq, lcSeqNum, lcVenc, lcValor, lnMora, lcMora
        LOCAL lccgccli, lctpcgccli, lcnome, lcende, lcbair, lccep, lccida, lcesta, lcnumtit
        LOCAL lnCont, lok, llAtu, lcTitBanAtual, loc_oErro

        loc_oBO = THIS.this_oBusinessObject
        loc_oP2 = THIS.pgf_4c_Principal.Page2

        lcTit     = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 12)
        lcBanco   = PADL(ALLTRIM(loc_oBO.this_cBancoNr), 3, "0")
        lcCnv     = PADL(ALLTRIM(loc_oBO.this_cConvenio), 3, "0")
        lcAge     = PADL(ALLTRIM(loc_oBO.this_cAgencia), 5, "0")
        lcbco     = PADL(ALLTRIM(CHRTRAN(ALLTRIM(loc_oBO.this_cContaConv) + ;
                          PADL(loc_oBO.this_cDigitoAgencia, 1, "0"), ".-", "")), 9, "0")
        lcRaz     = PADR(ALLTRIM(loc_oBO.this_cRazSocs), 30)
        lcCgc     = PADL(STRTRAN(STRTRAN(STRTRAN(loc_oBO.this_cCgcs, "/", ""), ".", ""), "-", ""), 14, "0")
        lctpcgc   = IIF(LEN(ALLTRIM(CHRTRAN(loc_oBO.this_cCgcs, "/.-", ""))) = 11, "01", "02")
        lcrazbco  = PADR(ALLTRIM(loc_oBO.this_cBancos), 15)
        lcDat     = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
        lnMor     = IIF(EMPTY(loc_oBO.this_nMoras), 0.23, loc_oBO.this_nMoras)
        lcPri     = PADL(IIF(EMPTY(ALLTRIM(loc_oBO.this_cInstrus)), "00", loc_oBO.this_cInstrus), 2, "0")
        lcprot    = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
        lcprot    = IIF(lcPri = "00", "00", PADL(ALLTRIM(STR(lcprot)), 2, "0"))
        lcCdC     = PADL(ALLTRIM(loc_oBO.this_cConvenio), 7, "0")
        lcTpCtArq = ALLTRIM(loc_oBO.this_cTpCtArq)
        lcTpCtBol = ALLTRIM(loc_oBO.this_cTpCtBol)
        lcEnv     = PADL(fGerUniqueKey("BRASILENV"), 7, "0")
        lcArq     = ALLTRIM(loc_oBO.this_cArqCnabs) + lcEnv + ".REM"

        *-- Header
        lcStrg = "0" + "1" + "REMESSA" + "01" + "COBRANCA" + "       " + ;
                 lcAge + lcbco + "000000" + lcRaz + ;
                 "001BANCO DO BRASIL" + lcDat + lcEnv + SPACE(22) + lcCdC + ;
                 SPACE(258) + "000001" + CHR(13) + CHR(10)
        lcStrg = fLimpaTexto(lcStrg)
        STRTOFILE(lcStrg, lcArq, 0)

        IF USED("cursor_4c_Filtro2")
            USE IN cursor_4c_Filtro2
        ENDIF
        SELECT *, SPACE(5) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
            INTO CURSOR cursor_4c_Filtro2 READWRITE

        lnSeq = 2
        SELECT cursor_4c_Filtro2
        SCAN
            lcSeqNum   = fGerUniqueKey("BBNOSSONUM")
            lcSeq      = TRANSFORM(lnSeq, "@L 999999")
            lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
                         SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
                         SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
            lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
            lnMora     = ROUND((cursor_4c_Filtro2.valos * 0.23) / 100, 2)
            lcMora     = PADL(ALLTRIM(CHRTRAN(STR(lnMora, 11, 2), ",.", "")), 13, "0")
            lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
            lctpcgccli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
            lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 37)
            lcnome     = PADR(CHRTRAN(lcnome, "/.-,", ""), 37)
            IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
               EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
               EMPTY(cursor_4c_Filtro2.cidcobs)
                lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + " " + ;
                              ALLTRIM(cursor_4c_Filtro2.nums) + " " + ;
                              ALLTRIM(cursor_4c_Filtro2.compls), 40)
                lcbair = PADR(cursor_4c_Filtro2.bairs, 12)
                lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
                lccida = PADR(cursor_4c_Filtro2.cidas, 15)
                lcesta = PADR(cursor_4c_Filtro2.estas, 2)
            ELSE
                lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
                lcbair = PADR(cursor_4c_Filtro2.baicobs, 12)
                lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
                lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
                lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
            ENDIF
            lcende   = PADR(CHRTRAN(lcende, "/.-,", ""), 40)
            lcnumtit = PADL(CHRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")

            lcStrg = "7" + lctpcgc + lcCgc + lcAge + lcbco + lcCdC + ;
                     PADR(lcnumtit, 25) + lcCdC + PADL(lcSeqNum, 10, "0") + ;
                     "00" + "00" + "   " + " " + "   " + lcTpCtBol + "0" + "000000" + "     " + ;
                     lcTpCtArq + "01" + PADR(lcnumtit, 10) + lcVenc + lcValor + "001" + ;
                     "0000" + " " + "01" + "N" + lcDat + lcPri + "00" + lcMora + ;
                     "000000" + "0000000000000" + "0000000000000" + "0000000000000" + ;
                     lctpcgccli + lccgccli + UPPER(lcnome) + "   " + UPPER(lcende) + ;
                     UPPER(lcbair) + lccep + UPPER(lccida) + UPPER(lcesta) + ;
                     SPACE(40) + "  " + " " + lcSeq + CHR(13) + CHR(10)

            lcStrg = fLimpaTexto(lcStrg)
            STRTOFILE(lcStrg, lcArq, 1)

            REPLACE SeqNums WITH PADL(lcSeqNum, 5, "0") IN cursor_4c_Filtro2

            loc_oBO.InserirLinhaCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
                cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
                lcStrg, cursor_4c_Filtro2.titulos, VAL(lcSeqNum))

            lnSeq = lnSeq + 1
        ENDSCAN

        *-- Trailer
        lcSeq  = TRANSFORM(lnSeq, "@L 999999")
        lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
        STRTOFILE(lcStrg, lcArq, 1)

        IF FILE(lcArq)
            lok = .T.
            IF !loc_oBO.ConfirmarTransacao()
                loc_oBO.CancelarTransacao()
                lok = .F.
            ENDIF

            IF lok
                SELECT cursor_4c_Filtro2
                SCAN
                    llAtu = .T.
                    lcTitBanAtual = loc_oBO.VerificarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
                    IF !EMPTY(ALLTRIM(lcTitBanAtual))
                        llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
                                            " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco preenchido. Sobrescrever?")
                    ENDIF
                    IF llAtu
                        loc_oBO.AtualizarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
                    ENDIF
                ENDSCAN
            ENDIF

            IF lok
                MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
            ENDIF

            *-- BB auto-imprime boleto apos geracao
            THIS.pgf_4c_Principal.Page2.cgp_4c_Acoes.Command3.Enabled = .T.
            THIS.ImpBoleto(.F.)
        ENDIF
    ENDPROC

    *==========================================================================
    * CnabItau - Gera arquivo CNAB 400 para Itau (341)
    * Arquivo definido pelo usuario via GetFile antes de chamar este metodo
    *==========================================================================
    PROTECTED PROCEDURE CnabItau()
        LOCAL loc_oBO, loc_oP2
        LOCAL lcTit, lcCnv, lcAge, lcbco, lcRaz, lcCgc, lctpcgc, lcrazbco
        LOCAL lcDat, lcprot, lcStrg, lnSeq, lcSeq, lcnumes
        LOCAL lcVenc, lcValor, lccgccli, lctpcgcCli, lcnome
        LOCAL lcende, lcbair, lccep, lccida, lcesta, lcnumtit
        LOCAL lok, llAtu, lcTitBanAtual, loc_oErro
        LOCAL lcarq

        loc_oBO = THIS.this_oBusinessObject
        loc_oP2 = THIS.pgf_4c_Principal.Page2
        lcarq   = THIS.this_cArqCNAB

        lcTit    = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 12)
        lcCnv    = PADL(ALLTRIM(loc_oBO.this_cConvenio), 8, "0")
        lcAge    = PADL(ALLTRIM(loc_oBO.this_cAgencia), 4, "0")
        lcbco    = PADL(ALLTRIM(CHRTRAN(loc_oBO.this_cContaConv, ".-", "")), 5, "0") + loc_oBO.this_cDigitoAgencia
        lcRaz    = PADR(ALLTRIM(loc_oBO.this_cRazSocs), 30)
        lcCgc    = PADL(STRTRAN(STRTRAN(STRTRAN(loc_oBO.this_cCgcs, "/", ""), ".", ""), "-", ""), 14, "0")
        lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(loc_oBO.this_cCgcs, "/.-", ""))) = 11, "01", "02")
        lcrazbco = PADR(ALLTRIM(loc_oBO.this_cBancos), 15)
        lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
        lcprot   = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
        lcprot   = PADL(ALLTRIM(STR(lcprot)), 2, "0")

        *-- Header
        lcStrg = "0" + "1" + "REMESSA" + "01" + "COBRANCA       " + ;
                 lcAge + "00" + lcbco + SPACE(8) + lcRaz + "341" + ;
                 lcrazbco + lcDat + SPACE(294) + "000001" + CHR(13) + CHR(10)
        lcStrg = fLimpaTexto(lcStrg)
        STRTOFILE(lcStrg, lcarq, 0)

        IF USED("cursor_4c_Filtro2")
            USE IN cursor_4c_Filtro2
        ENDIF
        SELECT * FROM cursor_4c_Filtro WHERE marca INTO CURSOR cursor_4c_Filtro2 READWRITE

        lnSeq = 2
        SELECT cursor_4c_Filtro2
        SCAN
            lcSeq      = TRANSFORM(lnSeq, "@L 999999")
            lcnumes    = TRANSFORM(cursor_4c_Filtro2.numes, "@L 9999999999")
            lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
                         SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
                         SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
            lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
            lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
            lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
            lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 30)
            IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
               EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
               EMPTY(cursor_4c_Filtro2.cidcobs)
                lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + "," + cursor_4c_Filtro2.nums, 40)
                lcbair = PADR(cursor_4c_Filtro2.bairs, 12)
                lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
                lccida = PADR(cursor_4c_Filtro2.cidas, 15)
                lcesta = PADR(cursor_4c_Filtro2.estas, 2)
            ELSE
                lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
                lcbair = PADR(cursor_4c_Filtro2.baicobs, 12)
                lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
                lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
                lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
            ENDIF
            lcnumtit = PADL(STRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")

            lcStrg = "1" + lctpcgcCli + lcCgc + lcAge + "00" + lcbco + SPACE(4) + ;
                     "0000" + PADR(lcnumtit, 25) + lcnumtit + ;
                     "0000000000000" + "112" + SPACE(21) + "I" + "01" + ;
                     PADR(lcnumtit, 10) + lcVenc + lcValor + "341" + "00000" + ;
                     "01" + "A" + lcDat + "81" + "19" + "0000000000000" + ;
                     "000000" + "0000000000000" + "0000000000000" + "0000000000000" + ;
                     lctpcgcCli + lccgccli + lcnome + SPACE(10) + ;
                     lcende + lcbair + lccep + lccida + lcesta + ;
                     SPACE(30) + SPACE(4) + "000000" + lcprot + SPACE(1) + ;
                     lcSeq + CHR(13) + CHR(10)

            lcStrg = fLimpaTexto(lcStrg)
            STRTOFILE(lcStrg, lcarq, 1)

            *-- Itau nao usa numeds (par_nNumeDs=0)
            loc_oBO.InserirLinhaCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
                cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
                lcStrg, cursor_4c_Filtro2.titulos, 0)

            lnSeq = lnSeq + 1
        ENDSCAN

        *-- Trailer
        lcSeq  = TRANSFORM(lnSeq, "@L 999999")
        lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
        STRTOFILE(lcStrg, lcarq, 1)

        IF FILE(lcarq)
            lok = .T.
            IF !loc_oBO.ConfirmarTransacao()
                loc_oBO.CancelarTransacao()
                lok = .F.
            ENDIF

            IF lok
                SELECT cursor_4c_Filtro2
                SCAN
                    llAtu = .T.
                    lcTitBanAtual = loc_oBO.VerificarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
                    IF !EMPTY(ALLTRIM(lcTitBanAtual))
                        llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
                                            " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
                    ENDIF
                    IF llAtu
                        loc_oBO.AtualizarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
                    ENDIF
                ENDSCAN
            ENDIF

            IF lok
                MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcarq) + CHR(34) + " gerado com sucesso!")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CnabBradesco - Gera arquivo CNAB 400 para Bradesco (237)
    *==========================================================================
    PROTECTED PROCEDURE CnabBradesco()
        LOCAL loc_oBO, loc_oP2
        LOCAL lcTit, lcBcn, lcCnv, lcAge, lcBco, lcRaz, lcCgc, lcTpC, lcRbc
        LOCAL lcDat, lcEnv, lnMor, lcPri, lcPrt, lcCdC, lcDig, lcArq, lcCar, lcBol
        LOCAL lcStrg, lnSeq, lcSeq, lcSeqNum, lcVenc, lcVal, lcMor
        LOCAL lcCpf, lcNom, lcEnd, lcCep, lcNtt, lcNossoNum, lcDV
        LOCAL lok, llAtu, lcTitBanAtual

        loc_oBO = THIS.this_oBusinessObject
        loc_oP2 = THIS.pgf_4c_Principal.Page2

        lcTit  = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 12)
        lcBcn  = PADL(ALLTRIM(loc_oBO.this_cBancoNr), 3, "0")
        lcCnv  = "009"
        lcAge  = PADL(ALLTRIM(loc_oBO.this_cAgencia), 5, "0")
        lcBco  = PADL(ALLTRIM(CHRTRAN(loc_oBO.this_cContaConv, ".-", "")), 7, "0") + ;
                 PADL(loc_oBO.this_cDigitoAgencia, 1, "0")
        lcRaz  = PADR(ALLTRIM(loc_oBO.this_cRazSocs), 30)
        lcCgc  = PADL(STRTRAN(STRTRAN(STRTRAN(loc_oBO.this_cCgcs, "/", ""), ".", ""), "-", ""), 14, "0")
        lcTpC  = IIF(LEN(ALLTRIM(CHRTRAN(loc_oBO.this_cCgcs, "/.-", ""))) = 11, "01", "02")
        lcRbc  = PADR(ALLTRIM(loc_oBO.this_cBancos), 15)
        lcDat  = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 9, 2)
        lcEnv  = PADL(fGerUniqueKey("BRADESCOENV"), 7, "0")
        lnMor  = IIF(EMPTY(loc_oBO.this_nMoras), 0.17, loc_oBO.this_nMoras)
        lcPri  = PADL(IIF(EMPTY(ALLTRIM(loc_oBO.this_cInstrus)), "00", loc_oBO.this_cInstrus), 2, "0")
        lcPrt  = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
        lcPrt  = IIF(lcPri = "00", "00", PADL(ALLTRIM(STR(lcPrt)), 2, "0"))
        lcCdC  = PADL(ALLTRIM(loc_oBO.this_cConvenio), 20, "0")
        lcDig  = IIF(VAL(SUBSTR(lcEnv, 6, 2)) = 0, ;
                     TRANSFORM(VAL(SUBSTR(lcEnv, 6, 2)) + 1, "@L 99"), ;
                     TRANSFORM(VAL(SUBSTR(lcEnv, 6, 2)), "@L 99"))
        lcArq  = "CB" + SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + lcDig + ".REM"
        lcCar  = PADL(ALLTRIM(loc_oBO.this_cTpCtBol), 2, "0")
        lcBol  = IIF(loc_oBO.this_nBcoImprime = 1, "1", "2")

        *-- Header
        lcStrg = "0" + "1" + "REMESSA" + "01" + "COBRANCA       " + lcCdC + ;
                 lcRaz + lcBcn + lcRbc + lcDat + SPACE(8) + "MX" + ;
                 lcEnv + SPACE(277) + "000001" + CHR(13) + CHR(10)
        lcStrg = fLimpaTexto(lcStrg)
        STRTOFILE(lcStrg, lcArq, 0)

        IF USED("cursor_4c_Filtro2")
            USE IN cursor_4c_Filtro2
        ENDIF
        SELECT *, SPACE(11) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
            INTO CURSOR cursor_4c_Filtro2 READWRITE

        lnSeq = 2
        SELECT cursor_4c_Filtro2
        SCAN
            lcSeqNum  = fGerUniqueKey("BRNOSSONUM")
            REPLACE SeqNums WITH PADL(lcSeqNum, 11, "0") IN cursor_4c_Filtro2

            lcSeq  = TRANSFORM(lnSeq, "@L 999999")
            lcVenc = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
                     SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
                     SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 9, 2)
            lcVal  = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 13, "0")
            lcMor  = PADL(ALLTRIM(CHRTRAN(STR(ROUND((cursor_4c_Filtro2.valos * lnMor) / 100, 2), 11, 2), ",.", "")), 13, "0")
            lcCpf  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 14, "0")
            lcTpC  = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "01", "02")
            lcNom  = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 40)
            lcNom  = PADR(CHRTRAN(lcNom, "/.-,", ""), 40)
            IF EMPTY(cursor_4c_Filtro2.EndCobs) OR EMPTY(cursor_4c_Filtro2.CepCobs)
                lcEnd = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + " " + cursor_4c_Filtro2.nums, 40)
                lcCep = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
            ELSE
                lcEnd = PADR(ALLTRIM(cursor_4c_Filtro2.EndCobs), 40)
                lcCep = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.CepCobs, ".-", "")), 8, "0")
            ENDIF
            lcEnd = PADR(CHRTRAN(lcEnd, "/.-,", ""), 40)
            lcNtt = PADL(STRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0")

            lcNossoNum = "00000000000"
            lcDV = "0"
            IF lcBol = "2"
                lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 11, "0")
                lcDV = fCalcMod11B7(lcCar + lcNossoNum)
            ENDIF

            lcStrg = "1" + SPACE(5) + SPACE(1) + SPACE(5) + SPACE(7) + SPACE(1) + ;
                     "0" + lcCnv + lcAge + lcBco + ;
                     PADR(lcNtt, 25) + "   " + "2" + "0200" + ;
                     lcNossoNum + lcDV + "0000000000" + ;
                     lcBol + " " + SPACE(10) + " " + "2" + "  " + ;
                     "01" + PADR(lcNtt, 10) + lcVenc + lcVal + ;
                     "000" + "00000" + "01" + "N" + lcDat + ;
                     lcPri + lcPrt + lcMor + "000000" + ;
                     "0000000000000" + "0000000000000" + "0000000000000" + ;
                     lcTpC + lcCpf + lcNom + lcEnd + ;
                     SPACE(12) + lcCep + SPACE(60) + lcSeq + CHR(13) + CHR(10)

            lcStrg = fLimpaTexto(lcStrg)
            STRTOFILE(lcStrg, lcArq, 1)

            loc_oBO.InserirLinhaCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
                cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
                lcStrg, cursor_4c_Filtro2.titulos, VAL(lcSeqNum))

            lnSeq = lnSeq + 1
        ENDSCAN

        *-- Trailer
        lcSeq  = TRANSFORM(lnSeq, "@L 999999")
        lcStrg = "9" + SPACE(393) + lcSeq + CHR(13) + CHR(10)
        STRTOFILE(lcStrg, lcArq, 1)

        IF FILE(lcArq)
            lok = .T.
            IF !loc_oBO.ConfirmarTransacao()
                loc_oBO.CancelarTransacao()
                lok = .F.
            ENDIF

            IF lok
                SELECT cursor_4c_Filtro2
                SCAN
                    llAtu = .T.
                    lcTitBanAtual = loc_oBO.VerificarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
                    IF !EMPTY(ALLTRIM(lcTitBanAtual))
                        llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
                                            " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
                    ENDIF
                    IF llAtu
                        loc_oBO.AtualizarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
                    ENDIF
                ENDSCAN
            ENDIF

            IF lok
                MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CnabSantander240 - Gera arquivo CNAB 240 para Santander (033/353)
    *==========================================================================
    PROTECTED PROCEDURE CnabSantander240()
        LOCAL loc_oBO, loc_oP2
        LOCAL lcTit, lcCnv, lcAge, lcDigA, lcCtaC, lcDigC, lcCta
        LOCAL lcRaz, lcCgc, lctpcgc, lcrazbco, lcDat, lcprot, lcEnv, lcArq
        LOCAL lcTpCtArq, lcTpCtBol, lnLot, lcLot, lnSeq, lcSeq
        LOCAL lcStrg, lnSeqL, lcSeqL, lcSeqNum, lcDV, lcNossoNum
        LOCAL lcnumes, lcVenc, lcValor, lnMora, lcMora, lccgccli, lctpcgcCli
        LOCAL lcnome, lcende, lcbair, lccep, lccida, lcesta, lcnumtit, lcChave
        LOCAL lnTotTit
        LOCAL lok, llAtu, lcTitBanAtual

        loc_oBO = THIS.this_oBusinessObject
        loc_oP2 = THIS.pgf_4c_Principal.Page2

        lcTit    = PADR(THIS.pgf_4c_Principal.Page1.txt_4c_TitBan.Value, 13)
        lcCnv    = PADL(ALLTRIM(loc_oBO.this_cConvenio), 11, "0")
        lcAge    = PADL(ALLTRIM(loc_oBO.this_cAgencia), 4, "0")
        lcDigA   = ALLTRIM(loc_oBO.this_cDigitoAgencia)
        lcCtaC   = ALLTRIM(CHRTRAN(loc_oBO.this_cContaConv, ".-", ""))
        lcDigC   = RIGHT(lcCtaC, 1)
        lcCta    = PADL(LEFT(lcCtaC, LEN(lcCtaC) - 1), 9, "0")
        lcRaz    = PADR(ALLTRIM(loc_oBO.this_cRazSocs), 30)
        lcCgc    = PADL(ALLTRIM(STRTRAN(STRTRAN(STRTRAN(loc_oBO.this_cCgcs, "/", ""), ".", ""), "-", "")), 15, "0")
        lctpcgc  = IIF(LEN(ALLTRIM(CHRTRAN(loc_oBO.this_cCgcs, "/.-", ""))) = 11, "1", "2")
        lcrazbco = PADR(ALLTRIM(loc_oBO.this_cBancos), 30)
        lcDat    = SUBSTR(DTOC(DATE()), 1, 2) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 7, 4)
        lcprot   = IIF(loc_oP2.spn_4c_Dias.Value = 0, 5, loc_oP2.spn_4c_Dias.Value)
        lcprot   = PADL(ALLTRIM(STR(lcprot)), 2, "0")
        lcEnv    = PADL(fGerUniqueKey("SANTANDERENV"), 8, "0")
        lcArq    = ALLTRIM(loc_oBO.this_cDrive) + IIF(EMPTY(ALLTRIM(loc_oBO.this_cDrive)), "", "\")
        lcArq    = STRTRAN(lcArq + ALLTRIM(loc_oBO.this_cArqCnabs) + lcEnv + ".REM", "\\", "\")
        lcTpCtArq = ALLTRIM(loc_oBO.this_cTpCtArq)
        lcTpCtBol = ALLTRIM(loc_oBO.this_cTpCtBol)

        lnLot = 0
        lcLot = TRANSFORM(lnLot, "@L 9999")
        lnSeq = 1
        lcSeq = TRANSFORM(lnSeq, "@L 999999")

        *-- Header do arquivo
        lcStrg = "033" + lcLot + "0" + SPACE(8) + lctpcgc + lcCgc + ;
                 lcAge + lcCnv + SPACE(25) + lcRaz + lcrazbco + ;
                 SPACE(10) + "1" + lcDat + SPACE(6) + SUBSTR(lcEnv, 3) + ;
                 "040" + SPACE(74) + CHR(13) + CHR(10)
        lcStrg = fLimpaTexto(lcStrg)
        STRTOFILE(lcStrg, lcArq, 0)

        *-- Header do lote
        lnLot = lnLot + 1
        lcLot = TRANSFORM(lnLot, "@L 9999")
        lnSeq = lnSeq + 1
        lcSeq = TRANSFORM(lnSeq, "@L 999999")

        lcStrg = "033" + lcLot + "1" + "R" + "01" + SPACE(2) + "030" + SPACE(1) + ;
                 lctpcgc + lcCgc + SPACE(20) + lcAge + lcCnv + SPACE(5) + ;
                 lcRaz + SPACE(40) + SPACE(40) + lcEnv + lcDat + SPACE(41) + ;
                 CHR(13) + CHR(10)
        lcStrg = fLimpaTexto(lcStrg)
        STRTOFILE(lcStrg, lcArq, 1)

        IF USED("cursor_4c_Filtro2")
            USE IN cursor_4c_Filtro2
        ENDIF
        SELECT *, SPACE(5) AS SeqNums FROM cursor_4c_Filtro WHERE marca ;
            INTO CURSOR cursor_4c_Filtro2 READWRITE

        lnSeqL = 0
        SELECT cursor_4c_Filtro2
        SCAN
            lcnumes    = TRANSFORM(cursor_4c_Filtro2.numes, "@L 9999999999")
            lcVenc     = SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 1, 2) + ;
                         SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 4, 2) + ;
                         SUBSTR(DTOC(cursor_4c_Filtro2.vencs), 7, 4)
            lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 11, 2), ",.", "")), 15, "0")
            lccgccli   = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-,", "")), 15, "0")
            lctpcgcCli = IIF(LEN(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cpfs, "/.-", ""))) = 11, "1", "2")
            lcnome     = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 40)
            lnMora     = IIF(loc_oBO.this_nMoras = 0, 0.33, loc_oBO.this_nMoras)
            lnMora     = ROUND((cursor_4c_Filtro2.valos * lnMora) / 100, 2)
            lcMora     = PADL(ALLTRIM(CHRTRAN(STR(lnMora, 11, 2), ",.", "")), 15, "0")
            IF EMPTY(cursor_4c_Filtro2.endcobs) OR EMPTY(cursor_4c_Filtro2.cepcobs) OR ;
               EMPTY(cursor_4c_Filtro2.estcobs) OR EMPTY(cursor_4c_Filtro2.baicobs) OR ;
               EMPTY(cursor_4c_Filtro2.cidcobs)
                lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endes) + "," + cursor_4c_Filtro2.nums, 40)
                lcbair = PADR(cursor_4c_Filtro2.bairs, 15)
                lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.ceps, ".-", "")), 8, "0")
                lccida = PADR(cursor_4c_Filtro2.cidas, 15)
                lcesta = PADR(cursor_4c_Filtro2.estas, 2)
            ELSE
                lcende = PADR(ALLTRIM(cursor_4c_Filtro2.endcobs), 40)
                lcbair = PADR(cursor_4c_Filtro2.baicobs, 15)
                lccep  = PADL(ALLTRIM(CHRTRAN(cursor_4c_Filtro2.cepcobs, ".-", "")), 8, "0")
                lccida = PADR(cursor_4c_Filtro2.cidcobs, 15)
                lcesta = PADR(cursor_4c_Filtro2.estcobs, 2)
            ENDIF

            lcnumtit = PADL(ALLTRIM(STRTRAN(cursor_4c_Filtro2.titulos, "/", "")), 15, "0")
            lcChave  = PADR(ALLTRIM(STRTRAN(cursor_4c_Filtro2.titulos, "/", "")), 15) + lcnumes

            lcSeqNum   = fGerUniqueKey("STNOSSONUM")
            lcDV       = fCalcMod11BB(PADL(lcSeqNum, 7, "0"), loc_oBO.this_cBancoNr)
            lcNossoNum = PADL(lcSeqNum, 12, "0") + lcDV

            *-- Detalhe P
            lnSeqL = lnSeqL + 1
            lcSeqL = TRANSFORM(lnSeqL, "@L 99999")
            lnSeq  = lnSeq + 1

            lcStrg = "033" + lcLot + "3" + lcSeqL + "P" + SPACE(1) + "01" + ;
                     lcAge + lcDigA + lcCta + lcDigC + lcCta + lcDigC + ;
                     SPACE(2) + lcNossoNum + "5" + "1" + "1" + SPACE(1) + SPACE(1) + ;
                     lcnumtit + lcVenc + lcValor + ;
                     lcAge + lcDigA + SPACE(1) + "02" + "N" + lcDat + ;
                     "1" + lcVenc + lcMora + "0" + "00000000" + ;
                     "000000000000000" + "000000000000000" + "000000000000000" + ;
                     lcChave + "0" + "00" + "2" + "0" + "00" + "00" + SPACE(11) + ;
                     CHR(13) + CHR(10)
            lcStrg = fLimpaTexto(lcStrg)
            STRTOFILE(lcStrg, lcArq, 1)

            *-- Detalhe Q
            lnSeq  = lnSeq + 1
            lnSeqL = lnSeqL + 1
            lcSeqL = TRANSFORM(lnSeqL, "@L 99999")

            lcStrg = "033" + lcLot + "3" + lcSeqL + "Q" + SPACE(1) + "01" + ;
                     lctpcgcCli + lccgccli + lcnome + ;
                     lcende + lcbair + lccep + lccida + lcesta + ;
                     "0" + "000000000000000" + SPACE(40) + ;
                     "000" + "000" + "000" + "000" + SPACE(19) + ;
                     CHR(13) + CHR(10)
            lcStrg = fLimpaTexto(lcStrg)
            STRTOFILE(lcStrg, lcArq, 1)

            REPLACE SeqNums WITH PADL(lcSeqNum, 5, "0") IN cursor_4c_Filtro2

            loc_oBO.InserirLinhaCNAB(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.emps, ;
                cursor_4c_Filtro2.dopes, cursor_4c_Filtro2.numes, ;
                lcStrg, cursor_4c_Filtro2.titulos, VAL(lcSeqNum))
        ENDSCAN

        *-- Trailer do lote
        lnSeq  = lnSeq + 1
        lnSeqL = lnSeqL + 1
        lcSeqL = TRANSFORM(lnSeqL, "@L 999999")
        lcStrg = "033" + lcLot + "5" + SPACE(9) + lcSeqL + SPACE(217) + CHR(13) + CHR(10)
        lcStrg = fLimpaTexto(lcStrg)
        STRTOFILE(lcStrg, lcArq, 1)

        *-- Trailer do arquivo
        lnSeq = lnSeq + 1
        lcSeq = TRANSFORM(lnSeq, "@L 999999")
        lcStrg = "033" + "9999" + "9" + SPACE(9) + "000001" + lcSeq + SPACE(211) + CHR(13) + CHR(10)
        lcStrg = fLimpaTexto(lcStrg)
        STRTOFILE(lcStrg, lcArq, 1)

        IF FILE(lcArq)
            lok = .T.
            IF !loc_oBO.ConfirmarTransacao()
                loc_oBO.CancelarTransacao()
                lok = .F.
            ENDIF

            IF lok
                SELECT cursor_4c_Filtro2
                SCAN
                    llAtu = .T.
                    lcTitBanAtual = loc_oBO.VerificarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers)
                    IF !EMPTY(ALLTRIM(lcTitBanAtual))
                        llAtu = MsgConfirma("T" + CHR(237) + "tulo " + CHR(34) + lcTitBanAtual + CHR(34) + ;
                                            " j" + CHR(225) + " possui T" + CHR(237) + "tulo do Banco. Sobrescrever?")
                    ENDIF
                    IF llAtu
                        loc_oBO.AtualizarTituloBanco(cursor_4c_Filtro2.empdopnums, cursor_4c_Filtro2.nopers, lcTit)
                    ENDIF
                ENDSCAN
            ENDIF

            IF lok
                MsgInfo("Arquivo " + CHR(34) + ALLTRIM(lcArq) + CHR(34) + " gerado com sucesso!")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ImpBoleto - Imprime boletos dos registros marcados em cursor_4c_Filtro2
    * par_lReimp: .T. = busca SeqNums do SigPcOol (reimprimir), .F. = usa atual
    *==========================================================================
    PROCEDURE ImpBoleto(par_lReimp)
        LOCAL loc_oBO, loc_lSucesso, loc_oErro
        LOCAL lcRaz, lcAge, lcbco, lcCdC, lcTpCtArq, lcTpCtBol
        LOCAL lcNossoNum, lcDV, lcFator, lcValor, lcBarra, lcArqBMP
        LOCAL lcCampo1, lcCampo2, lcCampo3, lcDv1, lcDv2, lcDv3, lcNrDigit
        LOCAL lcAg, lcCar, lcCta, lcDig, lcLivre
        LOCAL lcPri, lcprot, lnMor, lcMora, lcInt1, lcInt2, lcInt7
        LOCAL loc_nNumeDs, loc_cRaz, loc_cTpCtBol, loc_cTpCtArq
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Filtro2") OR RECCOUNT("cursor_4c_Filtro2") = 0
                MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para impress" + CHR(227) + "o de boleto")
            ELSE

            loc_oBO     = THIS.this_oBusinessObject
            lcRaz       = PADR(ALLTRIM(loc_oBO.this_cRazSocs), 30)
            lcAge       = LEFT(ALLTRIM(loc_oBO.this_cAgencia), 4)
            lcbco       = PADL(ALLTRIM(CHRTRAN(loc_oBO.this_cContaConv, ".-", "")), 8, "0")
            lcCdC       = PADL(ALLTRIM(loc_oBO.this_cConvenio), 7, "0")
            lcTpCtArq   = ALLTRIM(loc_oBO.this_cTpCtArq)
            lcTpCtBol   = ALLTRIM(loc_oBO.this_cTpCtBol)
            loc_cRaz     = lcRaz
            loc_cTpCtBol = lcTpCtBol
            loc_cTpCtArq = lcTpCtArq

            *-- Cria cursor extendido com campos de boleto
            SELECT a.*, SPACE(44) AS nBarras, SPACE(30) AS ImgBarra, ;
                    loc_cRaz AS loc_cRaz, SPACE(50) AS NomeCli, ;
                    SPACE(50) AS Instr1, SPACE(50) AS Instr2, SPACE(50) AS Instr3, ;
                    SPACE(50) AS Instr4, SPACE(50) AS Instr5, SPACE(50) AS Instr6, ;
                    SPACE(70) AS Instr7, SPACE(50) AS NrDigit, SPACE(17) AS NossoNum, ;
                    SPACE(15) AS AgCodCed, SPACE(10) AS cTitulos, ;
                    b.Ceps AS CepEmp, b.Endes AS EndEmp, b.Numeros AS NumEmp, ;
                    b.Bairs AS BaiEmp, b.Cidas AS CidEmp, b.Estas AS EstaEmp, ;
                    b.Cgcs AS CpfEmp, b.compls AS compEmp, ;
                    loc_cTpCtBol AS loc_cTpCtBol, loc_cTpCtArq AS loc_cTpCtArq, ;
                    SPACE(2) AS carteira ;
                FROM cursor_4c_Filtro2 a, cursor_4c_Empresa b ;
                INTO CURSOR cursor_4c_Filtro2 READWRITE

            SELECT cursor_4c_Filtro2
            GO TOP

            lcPri  = PADL(IIF(EMPTY(ALLTRIM(loc_oBO.this_cInstrus)), "00", loc_oBO.this_cInstrus), 2, "0")
            lcprot = IIF(THIS.pgf_4c_Principal.Page2.spn_4c_Dias.Value = 0, 5, ;
                         THIS.pgf_4c_Principal.Page2.spn_4c_Dias.Value)
            lcprot = IIF(lcPri = "00", "00", PADL(ALLTRIM(STR(lcprot)), 2, "0"))
            lnMor  = IIF(EMPTY(loc_oBO.this_nMoras), 0.23, loc_oBO.this_nMoras)

            SCAN
                loc_nNumeDs = 0
                IF par_lReimp
                    loc_nNumeDs = loc_oBO.BuscarUltimoNumeDs(ALLTRIM(cursor_4c_Filtro2.titulos))
                    REPLACE SeqNums WITH PADL(ALLTRIM(STR(loc_nNumeDs)), 5, "0") IN cursor_4c_Filtro2
                ENDIF

                IF ALLTRIM(loc_oBO.this_cBancoNr) = "001"
                    lcNossoNum = lcCdC + PADL(cursor_4c_Filtro2.SeqNums, 10, "0")
                    lcFator    = PADL(ALLTRIM(STR(1000 + (TTOD(cursor_4c_Filtro2.vencs) - CTOD("03/07/2000")))), 4, "0")
                    lcValor    = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
                    lcBarra    = "0019" + lcFator + lcValor + "000000" + lcNossoNum + "17"
                    lcDV       = fCalcMod11BB(lcBarra, loc_oBO.this_cBancoNr)

                    lcNossoNum = lcCdC + PADL(cursor_4c_Filtro2.SeqNums, 10, "0")
                    lcBarra    = "0019" + lcDV + lcFator + lcValor + "000000" + lcNossoNum + "17"
                    REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2

                    lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 10, "0") + ".bmp"
                    fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
                    REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2

                    lcCampo1  = "001900000"
                    lcDv1     = fCalcMod10(lcCampo1)
                    lcCampo2  = SUBSTR(lcBarra, 25, 10)
                    lcDv2     = fCalcMod10(lcCampo2)
                    lcCampo3  = SUBSTR(lcBarra, 35, 10)
                    lcDv3     = fCalcMod10(lcCampo3)
                    lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
                    REPLACE NrDigit WITH lcNrDigit IN cursor_4c_Filtro2
                    REPLACE AgCodCed WITH LEFT(ALLTRIM(loc_oBO.this_cAgencia), 4) + "-" + ;
                            RIGHT(ALLTRIM(loc_oBO.this_cAgencia), 1) + "/" + ;
                            ALLTRIM(CHRTRAN(loc_oBO.this_cContaConv, ".-", "")) + "-" + ;
                            PADL(loc_oBO.this_cDigitoAgencia, 1, "0") IN cursor_4c_Filtro2

                    IF TYPE("loc_oBO.this_nMsgMulta") = "N" AND loc_oBO.this_nMsgMulta = 1
                        REPLACE Instr3 WITH "COBRAR MULTA DE 2% AO M" + CHR(202) + "S AP" + CHR(211) + ;
                                "S 1 DIA DE VENCIMENTO " IN cursor_4c_Filtro2
                    ENDIF
                ENDIF

                IF ALLTRIM(loc_oBO.this_cBancoNr) = "033"
                    lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 12, "0")
                    lcDV       = fCalcMod11BB(lcNossoNum, loc_oBO.this_cBancoNr)
                    lcNossoNum = lcNossoNum + lcDV

                    lcFator = PADL(ALLTRIM(STR((TTOD(cursor_4c_Filtro2.vencs) - CTOD("07/10/1997")))), 4, "0")
                    lcValor = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
                    lcBarra = "0339" + lcFator + lcValor + "9" + lcCdC + lcNossoNum + "0" + "101"
                    lcDV    = fCalcMod11BB(lcBarra, loc_oBO.this_cBancoNr, "DVB")

                    lcBarra = "0339" + lcDV + lcFator + lcValor + "9" + lcCdC + lcNossoNum + "0" + "101"
                    REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2

                    lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 12, "0") + ".bmp"
                    fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
                    REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2

                    lcCampo1  = "03399" + SUBSTR(lcCdC, 1, 4)
                    lcDv1     = fCalcMod10(lcCampo1)
                    lcCampo2  = SUBSTR(lcBarra, 25, 10)
                    lcDv2     = fCalcMod10(lcCampo2)
                    lcCampo3  = SUBSTR(lcBarra, 35, 10)
                    lcDv3     = fCalcMod10(lcCampo3)
                    lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
                    REPLACE NrDigit WITH ALLTRIM(lcNrDigit) IN cursor_4c_Filtro2
                    REPLACE AgCodCed WITH ALLTRIM(loc_oBO.this_cAgencia) + "/" + lcCdC IN cursor_4c_Filtro2
                    REPLACE Instr3 WITH "COBRAR 1% DE MULTA A PARTIR DE " + ;
                            DTOC(TTOD(cursor_4c_Filtro2.vencs) + 6) IN cursor_4c_Filtro2
                ENDIF

                IF ALLTRIM(loc_oBO.this_cBancoNr) = "237"
                    IF par_lReimp
                        REPLACE SeqNums WITH PADL(ALLTRIM(TRANSFORM(loc_nNumeDs, "@R 99999999999")), 11, "0") ;
                            IN cursor_4c_Filtro2
                    ENDIF
                    lcFator = PADL(ALLTRIM(STR((TTOD(cursor_4c_Filtro2.vencs) - CTOD("07/10/1997")))), 4, "0")
                    lcValor = PADL(ALLTRIM(CHRTRAN(STR(cursor_4c_Filtro2.valos, 8, 2), ",.", "")), 10, "0")
                    lcAg    = PADL(LEFT(ALLTRIM(loc_oBO.this_cAgencia), 4), 4, "0")
                    lcCar   = PADL(ALLTRIM(loc_oBO.this_cTpCtBol), 2, "0")
                    lcCta   = PADL(ALLTRIM(CHRTRAN(loc_oBO.this_cContaConv, ".-", "")), 7, "0")
                    lcDig   = ALLTRIM(loc_oBO.this_cDigitoAgencia)
                    lcNossoNum = PADL(cursor_4c_Filtro2.SeqNums, 11, "0")
                    lcDV       = fCalcMod11B7(lcCar + lcNossoNum)
                    lcNossoNum = lcNossoNum + lcDV

                    lcLivre = lcAg + lcCar + SUBSTR(lcNossoNum, 1, 11) + lcCta + "0"
                    lcBarra = "2379" + lcFator + lcValor + lcLivre
                    lcDV    = fCalcMod11BB(lcBarra, loc_oBO.this_cBancoNr, "DVB")

                    lcBarra = "2379" + lcDV + lcFator + lcValor + lcLivre
                    REPLACE nBarras WITH lcBarra IN cursor_4c_Filtro2

                    lcArqBMP = "img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 11, "0") + ".bmp"
                    fGerBar2de5(SYS(2023) + "\" + lcArqBMP, lcBarra)
                    REPLACE ImgBarra WITH lcArqBMP IN cursor_4c_Filtro2

                    lcCampo1  = "2379" + SUBSTR(lcLivre, 1, 5)
                    lcDv1     = fCalcMod10(lcCampo1)
                    lcCampo2  = SUBSTR(lcLivre, 6, 10)
                    lcDv2     = fCalcMod10(lcCampo2)
                    lcCampo3  = SUBSTR(lcLivre, 16, 10)
                    lcDv3     = fCalcMod10(lcCampo3)
                    lcNrDigit = lcCampo1 + lcDv1 + lcCampo2 + lcDv2 + lcCampo3 + lcDv3 + lcDV + lcFator + lcValor
                    REPLACE NrDigit WITH lcNrDigit IN cursor_4c_Filtro2
                    REPLACE AgCodCed WITH ALLTRIM(loc_oBO.this_cAgencia) + "/" + lcCta + "-" + lcDig ;
                        IN cursor_4c_Filtro2
                    REPLACE carteira WITH lcCar IN cursor_4c_Filtro2
                ENDIF

                REPLACE NossoNum   WITH lcNossoNum, ;
                        cTitulos   WITH PADL(CHRTRAN(cursor_4c_Filtro2.titulos, "/", ""), 8, "0") ;
                    IN cursor_4c_Filtro2

                lcMora = STR(ROUND((cursor_4c_Filtro2.valos * lnMor) / 100, 2), 8, 2)
                lcInt1 = "AP" + CHR(211) + "S VENCIMENTO, COBRAR JUROS DE R$" + ALLTRIM(lcMora) + " AO DIA."
                lcInt2 = "PROTESTAR NO " + lcprot + CHR(186) + " DIA " + CHR(218) + "TIL AP" + CHR(211) + "S O VENCIMENTO."
                lcInt7 = IIF(ALLTRIM(loc_oBO.this_cBancoNr) = "237", ;
                             "Pag" + CHR(225) + "vel preferencialmente na Rede Bradesco ou Bradesco Expresso", ;
                             "PAG" + CHR(193) + "VEL EM QUALQUER BANCO AT" + CHR(201) + " O VENCIMENTO")

                IF TYPE("loc_oBO.this_nMsgMulta") = "N" AND loc_oBO.this_nMsgMulta = 1
                    lcInt2 = ""
                ENDIF

                LOCAL lcNomeCliTmp
                lcNomeCliTmp = PADR(IIF(EMPTY(cursor_4c_Filtro2.Razaos), cursor_4c_Filtro2.rclis, cursor_4c_Filtro2.Razaos), 37)
                lcNomeCliTmp = PADR(CHRTRAN(lcNomeCliTmp, "/.-,", ""), 37)
                REPLACE NomeCli WITH lcNomeCliTmp IN cursor_4c_Filtro2

                IF !EMPTY(cursor_4c_Filtro2.endcobs) AND !EMPTY(cursor_4c_Filtro2.cepcobs) AND ;
                   !EMPTY(cursor_4c_Filtro2.estcobs) AND !EMPTY(cursor_4c_Filtro2.baicobs) AND ;
                   !EMPTY(cursor_4c_Filtro2.cidcobs)
                    REPLACE endes WITH ALLTRIM(cursor_4c_Filtro2.endcobs), ;
                            bairs WITH cursor_4c_Filtro2.baicobs, ;
                            ceps  WITH cursor_4c_Filtro2.cepcobs, ;
                            cidas WITH cursor_4c_Filtro2.cidcobs, ;
                            estas WITH cursor_4c_Filtro2.estcobs ;
                        IN cursor_4c_Filtro2
                ENDIF

                REPLACE Instr1 WITH lcInt1, Instr2 WITH lcInt2, Instr7 WITH lcInt7 ;
                    IN cursor_4c_Filtro2
            ENDSCAN

            SELECT cursor_4c_Filtro2
            GO TOP

            DO CASE
                CASE ALLTRIM(loc_oBO.this_cBancoNr) = "001"
                    REPORT FORM BloquetoBB2 PREVIEW

                CASE ALLTRIM(loc_oBO.this_cBancoNr) = "033"
                    REPORT FORM BloquetoSt PREVIEW

                CASE ALLTRIM(loc_oBO.this_cBancoNr) = "237"
                    REPORT FORM BloquetoBra PREVIEW
            ENDCASE

            *-- Limpa imagens de barra geradas
            SELECT cursor_4c_Filtro2
            SCAN
                lcArqBMP = SYS(2023) + "\img_barra_" + PADL(cursor_4c_Filtro2.SeqNums, 10, "0") + ".bmp"
                IF FILE(lcArqBMP)
                    ERASE &lcArqBMP
                ENDIF
            ENDSCAN

            loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ImpBoleto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Voltar para pagina de filtros (nova selecao)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Executa processamento dos filtros
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            THIS.ClickProcessar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza relatorio dos titulos selecionados
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Filtro") OR RECCOUNT("cursor_4c_Filtro") = 0
                MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o dispon" + CHR(237) + ;
                         "vel. Execute o processamento primeiro.")
            ELSE
                THIS.ClickRelatorio()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Desmarca todos os titulos
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Filtro") OR RECCOUNT("cursor_4c_Filtro") = 0
                MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o para desmarcar.")
            ELSE
                IF MsgConfirma("Desmarcar todos os t" + CHR(237) + "tulos selecionados?")
                    THIS.ClickDesmarcarTitulos()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados iniciais (operacoes SigCdOpe)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.InicializarValores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia campos de filtro da tela para o BO
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oP1
        loc_oBO = THIS.this_oBusinessObject
        loc_oP1 = THIS.pgf_4c_Principal.Page1

        loc_oBO.this_cCdEmpresa   = ALLTRIM(loc_oP1.txt_4c_CdEmpresa.Value)
        loc_oBO.this_cDsEmpresa   = ALLTRIM(loc_oP1.txt_4c_DsEmpresa.Value)
        loc_oBO.this_dDatai       = loc_oP1.txt_4c_Datai.Value
        loc_oBO.this_dDataf       = loc_oP1.txt_4c_Dataf.Value
        loc_oBO.this_nProcessados = loc_oP1.opt_4c_Processados.Value
        loc_oBO.this_nPeriodo     = loc_oP1.opt_4c_Periodo.Value
        loc_oBO.this_cCdConta     = ALLTRIM(loc_oP1.txt_4c_CdConta.Value)
        loc_oBO.this_cDsConta     = ALLTRIM(loc_oP1.txt_4c_DsConta.Value)
        loc_oBO.this_cTitBan      = loc_oP1.txt_4c_TitBan.Value
        loc_oBO.this_nDiasProt    = THIS.pgf_4c_Principal.Page2.spn_4c_Dias.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Copia propriedades do BO de volta para os campos de filtro
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oP1
        loc_oBO = THIS.this_oBusinessObject
        loc_oP1 = THIS.pgf_4c_Principal.Page1

        loc_oP1.txt_4c_CdEmpresa.Value   = loc_oBO.this_cCdEmpresa
        loc_oP1.txt_4c_DsEmpresa.Value   = loc_oBO.this_cDsEmpresa
        loc_oP1.txt_4c_Datai.Value        = loc_oBO.this_dDatai
        loc_oP1.txt_4c_Dataf.Value        = loc_oBO.this_dDataf
        loc_oP1.opt_4c_Processados.Value  = loc_oBO.this_nProcessados
        loc_oP1.opt_4c_Periodo.Value      = loc_oBO.this_nPeriodo
        loc_oP1.txt_4c_CdConta.Value      = loc_oBO.this_cCdConta
        loc_oP1.txt_4c_DsConta.Value      = loc_oBO.this_cDsConta
        loc_oP1.txt_4c_TitBan.Value       = loc_oBO.this_cTitBan
        THIS.pgf_4c_Principal.Page2.spn_4c_Dias.Value = loc_oBO.this_nDiasProt
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de filtro da Page1
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oP1
        loc_oP1 = THIS.pgf_4c_Principal.Page1

        loc_oP1.txt_4c_CdEmpresa.Enabled  = par_lHabilitar
        loc_oP1.txt_4c_DsEmpresa.Enabled  = par_lHabilitar
        loc_oP1.txt_4c_Datai.Enabled      = par_lHabilitar
        loc_oP1.txt_4c_Dataf.Enabled      = par_lHabilitar
        loc_oP1.opt_4c_Processados.Enabled = par_lHabilitar
        loc_oP1.opt_4c_Periodo.Enabled    = par_lHabilitar
        loc_oP1.txt_4c_CdConta.Enabled    = par_lHabilitar
        loc_oP1.txt_4c_DsConta.Enabled    = par_lHabilitar
        loc_oP1.txt_4c_TitBan.Enabled     = par_lHabilitar
        loc_oP1.grd_4c_Operacoes.Enabled  = par_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de filtro
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oP1
        loc_oP1 = THIS.pgf_4c_Principal.Page1

        loc_oP1.txt_4c_CdEmpresa.Value   = ""
        loc_oP1.txt_4c_DsEmpresa.Value   = ""
        loc_oP1.txt_4c_Datai.Value        = {}
        loc_oP1.txt_4c_Dataf.Value        = {}
        loc_oP1.opt_4c_Processados.Value  = 1
        loc_oP1.opt_4c_Periodo.Value      = 1
        loc_oP1.txt_4c_CdConta.Value      = ""
        loc_oP1.txt_4c_DsConta.Value      = ""
        loc_oP1.txt_4c_TitBan.Value       = ""

        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            REPLACE ALL marca WITH .F.
            GO TOP
            loc_oP1.grd_4c_Operacoes.Refresh()
        ENDIF

        loc_oP1.txt_4c_CdEmpresa.SetFocus()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes de acordo com dados
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oP1, loc_oP2, loc_lTemDados, loc_oErro
        TRY
            loc_lTemDados = USED("cursor_4c_Filtro") AND RECCOUNT("cursor_4c_Filtro") > 0
            loc_oP1 = THIS.pgf_4c_Principal.Page1
            loc_oP2 = THIS.pgf_4c_Principal.Page2

            loc_oP1.cgp_4c_Filtro.Command1.Enabled = .T.
            loc_oP1.cgp_4c_Filtro.Command2.Enabled = .T.

            loc_oP2.cgp_4c_Acoes.Command1.Enabled = loc_lTemDados
            loc_oP2.cgp_4c_Acoes.Command2.Enabled = loc_lTemDados
            loc_oP2.cgp_4c_MarcaDados.Enabled     = loc_lTemDados
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Executa processamento (equivalente ao "Processar")
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.ClickProcessar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Gera arquivo CNAB (acao principal de Page2)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro
        TRY
            THIS.ClickGerarCNAB()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Volta para page de filtros sem gerar arquivo
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF
        IF USED("cursor_4c_FormaPagto")
            USE IN cursor_4c_FormaPagto
        ENDIF
        IF USED("cursor_4c_Filtro")
            USE IN cursor_4c_Filtro
        ENDIF
        IF USED("cursor_4c_Filtro2")
            USE IN cursor_4c_Filtro2
        ENDIF
        IF USED("cursor_4c_Empresa")
            USE IN cursor_4c_Empresa
        ENDIF
        IF USED("cursor_4c_Convenio")
            USE IN cursor_4c_Convenio
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
