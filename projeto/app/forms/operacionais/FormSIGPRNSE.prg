*==============================================================================
* FormSIGPRNSE.prg - Integracao de NF-e Municipal
*==============================================================================
* Form     : FormSIGPRNSE
* BO       : SIGPRNSEBO
* Tipo     : OPERACIONAL - Geracao de arquivo TXT NFS-e (RJ/SP)
* Herda de : FormBase
*==============================================================================
DEFINE CLASS FormSIGPRNSE AS FormBase

    *-- Dimensoes e aparencia identicas ao SCX original SIGPRNSE
    Width       = 1021
    Height      = 699
    AutoCenter  = .T.
    ShowTips    = .T.
    BorderStyle = 2
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    DataSession = 2
    Themes      = .F.

    *-- BO gerenciado por esta classe
    this_oBusinessObject = .NULL.

    *==========================================================================
    * Init - Cria BO e inicializa via FormBase (DODEFAULT obrigatorio para
    *        FormBase.Init() executar SET DATE BRITISH + SET CENTURY ON)
    *==========================================================================
    PROCEDURE Init()
        THIS.this_oBusinessObject = CREATEOBJECT("SIGPRNSEBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SIGPRNSEBO.", ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Activate; constroi UI dinamicamente
    *==========================================================================
    PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.Caption = "Integra" + CHR(231) + CHR(227) + "o de NF-e Municipal"

        TRY
            THIS.ConfigurarFundo()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoesForm()
            THIS.ConfigurarFiltros()
            THIS.ConfigurarBotaoDirs()
            THIS.ConfigurarBotaoSelecionar()
            THIS.ConfigurarGrade()
            THIS.ConfigurarBotoesGrade()
            THIS.ConfigurarErros()
            THIS.TornarControlesVisiveis()
            THIS.ConfigurarBINDEVENTs()
            THIS.InicializarValores()
            THIS.AjustarControles(.T.)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFundo()
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_cTitulo
        loc_cTitulo = "Integra" + CHR(231) + CHR(227) + "o de NF-e Municipal"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = 1068
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .AutoSize    = .F.
            .Width       = THIS.Width
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontUnderline = .F.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = loc_cTitulo
            .Height      = 40
            .Left        = 10
            .Top         = 18
            .ForeColor   = RGB(0, 0, 0)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .AutoSize    = .F.
            .Width       = THIS.Width
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = loc_cTitulo
            .Height      = 46
            .Left        = 10
            .Top         = 17
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesForm()
        LOCAL loc_oCmg
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Botoes
        WITH loc_oCmg
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Height      = 110
            .Left        = 742
            .Top         = -2
            .Width       = 251
            .Themes      = .F.
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 11
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
                .Caption         = "Limpar Sele" + CHR(231) + CHR(227) + "o"
                .ToolTipText     = "Limpar a Sele" + CHR(231) + CHR(227) + "o da Grade Abaixo"
                .PicturePosition = 7
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 86
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .Caption         = "Gerar Arquivo"
                .ToolTipText     = "Gerar o Arquivo de Integra" + CHR(231) + CHR(227) + "o"
                .PicturePosition = 7
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 161
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Sair do Processo"
                .ToolTipText     = "[ESC] Sair"
                .PicturePosition = 7
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        *-- OptionGroup: Processados (Top=100 - acima dos demais filtros)
        THIS.AddObject("obj_4c_OptProcessados", "OptionGroup")
        WITH THIS.obj_4c_OptProcessados
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 15
            .Left        = 127
            .Top         = 100
            .Width       = 235
            .Value       = 1
            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Processadas"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left      = 5
                .Top       = -1
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "J" + CHR(225) + " Processadas"
                .Left      = 126
                .Top       = -1
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Label: Periodo
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Caption    = "Per" + CHR(237) + "odo :"
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Left       = 79
            .Top        = 123
        ENDWITH

        *-- TextBox: Data Inicial
        THIS.AddObject("txt_4c_DtIni", "TextBox")
        WITH THIS.txt_4c_DtIni
            .Left              = 134
            .Top               = 119
            .Height            = 23
            .Width             = 75
            .SpecialEffect     = 1
            .ToolTipText       = "Data Inicial Para Sele" + CHR(231) + CHR(227) + "o das Notas"
            .BorderColor       = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- Label: ate
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Caption    = "at" + CHR(233)
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Left       = 217
            .Top        = 123
        ENDWITH

        *-- TextBox: Data Final
        THIS.AddObject("txt_4c_DtFin", "TextBox")
        WITH THIS.txt_4c_DtFin
            .Left              = 240
            .Top               = 119
            .Height            = 23
            .Width             = 75
            .SpecialEffect     = 1
            .ToolTipText       = "Data Final Para Sele" + CHR(231) + CHR(227) + "o das Notas"
            .BorderColor       = RGB(90, 90, 90)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- Label: Empresa
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Caption    = "Empresa :"
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Left       = 72
            .Top        = 149
        ENDWITH

        *-- TextBox: Codigo da Empresa
        THIS.AddObject("txt_4c_CEmps", "TextBox")
        WITH THIS.txt_4c_CEmps
            .Left              = 134
            .Top               = 145
            .Width             = 31
            .Height            = 23
            .MaxLength         = 3
            .SpecialEffect     = 1
            .ToolTipText       = "Empresa Para Filtro das Notas"
            .BorderColor       = RGB(36, 84, 155)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
        ENDWITH

        *-- TextBox: Descricao da Empresa (somente leitura - populada por ValidarEmpresa)
        THIS.AddObject("txt_4c_DEmps", "TextBox")
        WITH THIS.txt_4c_DEmps
            .Left              = 168
            .Top               = 145
            .Width             = 305
            .Height            = 23
            .SpecialEffect     = 1
            .ReadOnly          = .T.
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
            .BorderColor       = RGB(90, 90, 90)
        ENDWITH

        *-- Label: Municipio
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Caption    = "Munic" + CHR(237) + "pio :"
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Left       = 70
            .Top        = 175
        ENDWITH

        *-- ComboBox: Cidades (RJ / SP)
        THIS.AddObject("cbo_4c_CmbCidades", "ComboBox")
        WITH THIS.cbo_4c_CmbCidades
            .FontName          = "Courier New"
            .RowSourceType     = 1
            .RowSource         = "RJ - Rio de Janeiro,SP - S" + CHR(227) + "o Paulo"
            .BoundTo           = .T.
            .Style             = 2
            .SpecialEffect     = 1
            .Left              = 134
            .Top               = 171
            .Width             = 339
            .Height            = 22
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
            .BorderColor       = RGB(90, 90, 90)
        ENDWITH

        *-- Label: Pasta do Arquivo
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Caption    = "Pasta do Arquivo :"
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontItalic = .F.
            .ForeColor  = RGB(90, 90, 90)
            .Left       = 25
            .Top        = 200
        ENDWITH

        *-- TextBox: Diretorio de gravacao (somente via btn_4c_BtnDirs)
        THIS.AddObject("txt_4c_Dirs", "TextBox")
        WITH THIS.txt_4c_Dirs
            .Left              = 134
            .Top               = 196
            .Width             = 421
            .Height            = 23
            .SpecialEffect     = 1
            .ReadOnly          = .T.
            .ToolTipText       = "Diret" + CHR(243) + "rio / Pasta de grava" + CHR(231) + CHR(227) + "o do Arquivo"
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
            .BorderColor       = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoDirs()
        THIS.AddObject("cmd_4c_BtnDirs", "CommandButton")
        WITH THIS.cmd_4c_BtnDirs
            .Top             = 192
            .Left            = 558
            .Height          = 30
            .Width           = 32
            .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .Caption         = ""
            .ToolTipText     = "Carregar o Diret" + CHR(243) + "rio / Pasta de Grava" + ;
                               CHR(231) + CHR(227) + "o do Arquivo"
            .PicturePosition = 13
            .Themes          = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoSelecionar()
        THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
        WITH THIS.cmd_4c_Selecionar
            .Top             = 106
            .Left            = 484
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption         = "\<Selecionar Notas"
            .ToolTipText     = "Seleciona as Notas Conforme os Filtros Digitados"
            .PicturePosition = 7
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrd
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = THIS.grd_4c_Dados
        WITH loc_oGrd
            .Left              = 21
            .Top               = 230
            .Width             = 929
            .Height            = 346
            .ColumnCount       = 11
            .RecordSource      = "csOperacoes"
            .HeaderHeight      = 19
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .F.
            .ScrollBars        = 2
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.

            *-- Coluna 1: checkbox SelImp
            WITH .Column1
                .Width         = 15
                .ControlSource = "csOperacoes.SelImp"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .F.
                .Sparse        = .F.
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = ""
                ENDWITH
            ENDWITH

            *-- Coluna 2: Codigo (Numes)
            WITH .Column2
                .Width         = 52
                .ControlSource = "csOperacoes.Numes"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "C" + CHR(243) + "digo"
                ENDWITH
            ENDWITH

            *-- Coluna 3: Data
            WITH .Column3
                .Width         = 80
                .ControlSource = "csOperacoes.Datas"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Data"
                ENDWITH
            ENDWITH

            *-- Coluna 4: Valor
            WITH .Column4
                .Width         = 104
                .ControlSource = "csOperacoes.Valos"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Valor"
                ENDWITH
            ENDWITH

            *-- Coluna 5: Documento (NFis)
            WITH .Column5
                .Width         = 75
                .ControlSource = "csOperacoes.Notas"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Documento"
                ENDWITH
            ENDWITH

            *-- Coluna 6: Usuario
            WITH .Column6
                .Width         = 85
                .ControlSource = "csOperacoes.Usuars"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Usu" + CHR(225) + "rio"
                ENDWITH
            ENDWITH

            *-- Coluna 7: Origem (ContaOs)
            WITH .Column7
                .Width         = 85
                .ControlSource = "csOperacoes.ContaOs"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Origem"
                ENDWITH
            ENDWITH

            *-- Coluna 8: Destino (ContaDs)
            WITH .Column8
                .Width         = 85
                .ControlSource = "csOperacoes.ContaDs"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Destino"
                ENDWITH
            ENDWITH

            *-- Coluna 9: Empresa (Emps)
            WITH .Column9
                .Width         = 37
                .ControlSource = "csOperacoes.Emps"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Emp"
                ENDWITH
            ENDWITH

            *-- Coluna 10: E/S (Operas)
            WITH .Column10
                .Width         = 37
                .ControlSource = "csOperacoes.Opers"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "E / S"
                ENDWITH
            ENDWITH

            *-- Coluna 11: Movimentacao (Dopes)
            WITH .Column11
                .Width         = 242
                .ControlSource = "csOperacoes.Dopes"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Courier New"
                WITH .Header1
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                ENDWITH
            ENDWITH

            *-- Cor vermelha quando ha erros na linha
            .SetAll("DynamicForeColor", ;
                    "IIF(EMPTY(ALLTRIM(csOperacoes.Erros)), RGB(0,0,0), RGB(255,0,0))", ;
                    "Column")
        ENDWITH

        *-- Adiciona CheckBox na coluna 1 (fora do WITH para evitar problema de AddObject aninhado)
        loc_oGrd.Column1.AddObject("chk_4c_SelImp", "CheckBox")
        WITH loc_oGrd.Column1.chk_4c_SelImp
            .Caption    = ""
            .AutoSize   = .T.
            .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "chk_4c_SelImp"
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesGrade()
        LOCAL loc_oCmg
        THIS.AddObject("cmg_4c_Grade", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Grade
        WITH loc_oCmg
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Height      = 135
            .Left        = 957
            .Top         = 339
            .Width       = 43
            .Themes      = .F.
            WITH .Buttons(1)
                .Top           = -1
                .Left          = -1
                .Height        = 45
                .Width         = 45
                .FontName      = "Verdana"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Selecionar"
                .ForeColor     = RGB(36, 84, 155)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH
            WITH .Buttons(2)
                .Top           = 45
                .Left          = -1
                .Height        = 45
                .Width         = 45
                .FontName      = "Verdana"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Caption       = ""
                .ToolTipText   = "Desmarcar"
                .ForeColor     = RGB(36, 84, 155)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH
            WITH .Buttons(3)
                .Top           = 91
                .Left          = -1
                .Height        = 45
                .Width         = 45
                .FontName      = "Verdana"
                .FontSize      = 8
                .Picture       = gc_4c_CaminhoIcones + "geral_configuracao_26.jpg"
                .Caption       = ""
                .WordWrap        = .T.
                .ToolTipText   = "Documento"
                .ForeColor     = RGB(36, 84, 155)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarErros()
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Caption    = "Erros dos Dados"
            .FontName   = "Verdana"
            .FontSize   = 8
            .FontItalic = .F.
            .ForeColor  = RGB(255, 255, 255)
            .Left       = 21
            .Top        = 580
        ENDWITH

        THIS.AddObject("edt_4c_Erros", "EditBox")
        WITH THIS.edt_4c_Erros
            .Left          = 21
            .Top           = 595
            .Width         = 929
            .Height        = 77
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ControlSource = "csOperacoes.Erros"
            .BorderColor   = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis()
        THIS.cnt_4c_Sombra.Visible                      = .T.
        THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Visible    = .T.
        THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Visible    = .T.
        THIS.cmg_4c_Botoes.Visible                      = .T.
        THIS.obj_4c_OptProcessados.Visible              = .T.
        THIS.lbl_4c_Label1.Visible                      = .T.
        THIS.txt_4c_DtIni.Visible                       = .T.
        THIS.lbl_4c_Label2.Visible                      = .T.
        THIS.txt_4c_DtFin.Visible                       = .T.
        THIS.lbl_4c_Label4.Visible                      = .T.
        THIS.txt_4c_CEmps.Visible                       = .T.
        THIS.txt_4c_DEmps.Visible                       = .T.
        THIS.lbl_4c_Label3.Visible                      = .T.
        THIS.cbo_4c_CmbCidades.Visible                  = .T.
        THIS.lbl_4c_Label5.Visible                      = .T.
        THIS.txt_4c_Dirs.Visible                        = .T.
        THIS.cmd_4c_BtnDirs.Visible                     = .T.
        THIS.cmd_4c_Selecionar.Visible                  = .T.
        THIS.grd_4c_Dados.Visible                       = .T.
        THIS.cmg_4c_Grade.Visible                       = .T.
        THIS.lbl_4c_Label6.Visible                      = .T.
        THIS.edt_4c_Erros.Visible                       = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.cmd_4c_Selecionar, "Click",              THIS, "BtnSelecionarClick")
        BINDEVENT(THIS.cmg_4c_Botoes,     "Click",              THIS, "CmgBotoesClick")
        BINDEVENT(THIS.cmg_4c_Grade,      "Click",              THIS, "CmgGradeClick")
        BINDEVENT(THIS.cmd_4c_BtnDirs,    "Click",              THIS, "BtnDirsClick")
        BINDEVENT(THIS.txt_4c_CEmps,      "LostFocus",         THIS, "TxtCEmpsLostFocus")
        BINDEVENT(THIS.txt_4c_CEmps,      "KeyPress",          THIS, "TxtCEmpsKeyPress")
        BINDEVENT(THIS.grd_4c_Dados,      "AfterRowColChange",  THIS, "GradeAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_SelImp, "MouseDown", THIS, "CheckMouseDown")
        BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_SelImp, "KeyPress",  THIS, "CheckKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValores()
        THIS.txt_4c_DtIni.Value       = DATE()
        THIS.txt_4c_DtFin.Value       = DATE()
        THIS.cbo_4c_CmbCidades.Value  = "RJ - Rio de Janeiro"
        THIS.txt_4c_Dirs.Value        = "C:\"

        THIS.this_oBusinessObject.CriarCursorOperacoes()
        THIS.this_oBusinessObject.CarregarUfs()
    ENDPROC

    *==========================================================================
    * AjustarControles - .T. = modo entrada (filtros ativos, grade inativa)
    *                    .F. = modo processamento (grade ativa, filtros inativos)
    *==========================================================================
    PROCEDURE AjustarControles(par_lModoEntrada)
        LOCAL loc_lEntrada
        loc_lEntrada = IIF(TYPE("par_lModoEntrada") = "L", par_lModoEntrada, .T.)

        WITH THIS
            .obj_4c_OptProcessados.Enabled            = loc_lEntrada
            .obj_4c_OptProcessados.Buttons(1).Enabled = loc_lEntrada
            .obj_4c_OptProcessados.Buttons(2).Enabled = loc_lEntrada
            .txt_4c_DtIni.Enabled                     = loc_lEntrada
            .txt_4c_DtFin.Enabled                     = loc_lEntrada
            .txt_4c_CEmps.Enabled                     = loc_lEntrada
            .txt_4c_DEmps.Enabled                     = loc_lEntrada
            .cbo_4c_CmbCidades.Enabled                = loc_lEntrada
            .cmd_4c_Selecionar.Enabled                = loc_lEntrada
            .txt_4c_Dirs.Enabled                      = loc_lEntrada
            .cmd_4c_BtnDirs.Enabled                   = loc_lEntrada

            .cmg_4c_Botoes.Buttons(1).Enabled         = !loc_lEntrada
            .cmg_4c_Botoes.Buttons(2).Enabled         = !loc_lEntrada
            .cmg_4c_Grade.Buttons(1).Enabled          = !loc_lEntrada
            .cmg_4c_Grade.Buttons(2).Enabled          = !loc_lEntrada
            .cmg_4c_Grade.Buttons(3).Enabled          = !loc_lEntrada
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnSelecionarClick - coleta filtros e chama BO.Selecionar
    *==========================================================================
    PROCEDURE BtnSelecionarClick()
        LOCAL loc_lSucesso, loc_lNaoProcesados, loc_cEmps, loc_dDtIni, loc_dDtFin, loc_cDir
        loc_lNaoProcesados = (THIS.obj_4c_OptProcessados.Value = 1)
        loc_cEmps          = PADR(ALLTRIM(THIS.txt_4c_CEmps.Value), 3)
        loc_dDtIni         = THIS.txt_4c_DtIni.Value
        loc_dDtFin         = THIS.txt_4c_DtFin.Value
        loc_cDir           = ALLTRIM(THIS.txt_4c_Dirs.Value)

        loc_lSucesso = THIS.this_oBusinessObject.Selecionar( ;
                           loc_cEmps, loc_dDtIni, loc_dDtFin, loc_lNaoProcesados, loc_cDir)

        IF loc_lSucesso
            THIS.AjustarControles(.F.)
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmgBotoesClick - Limpar (1) / Gerar Arquivo (2) / Sair (3)
    *==========================================================================
    PROCEDURE CmgBotoesClick()
        LOCAL loc_nValor, loc_lSelecionados, loc_oErro
        loc_nValor = THIS.cmg_4c_Botoes.Value

        *-- Antes de Gerar, verifica se ha registros selecionados
        IF loc_nValor = 2
            SELECT SelImp, COUNT(1) AS Selecionados ;
              FROM csOperacoes ;
             WHERE SelImp ;
             GROUP BY SelImp ;
              INTO CURSOR cursor_4c_Seles
            loc_lSelecionados = USED("cursor_4c_Seles") AND RECCOUNT("cursor_4c_Seles") > 0 ;
                                AND cursor_4c_Seles.Selecionados > 0
            IF USED("cursor_4c_Seles")
                USE IN cursor_4c_Seles
            ENDIF
            IF !loc_lSelecionados
                MsgAviso("Nenhum lan" + CHR(231) + "amento foi selecionado para " + ;
                         "gera" + CHR(231) + CHR(227) + "o do arquivo!!!")
                RETURN
            ENDIF
        ENDIF

        DO CASE
            CASE loc_nValor = 1 AND THIS.cmg_4c_Botoes.Buttons(1).Enabled
                THIS.AjustarControles(.T.)
                IF USED("csOperacoes")
                    SELECT csOperacoes
                    ZAP
                ENDIF
                THIS.grd_4c_Dados.Refresh()

            CASE loc_nValor = 2 AND THIS.cmg_4c_Botoes.Buttons(2).Enabled
                THIS.this_oBusinessObject.Processamento(ALLTRIM(THIS.cbo_4c_CmbCidades.Value))
                THIS.AjustarControles(.T.)
                IF USED("csOperacoes")
                    SELECT csOperacoes
                    ZAP
                ENDIF
                THIS.grd_4c_Dados.Refresh()

            CASE loc_nValor = 3
                THIS.Release()
        ENDCASE
    ENDPROC

    *==========================================================================
    * CmgGradeClick - Selecionar tudo (1) / Desmarcar (2) / Documento (3)
    *==========================================================================
    PROCEDURE CmgGradeClick()
        LOCAL loc_nValor, loc_oErro
        loc_nValor = THIS.cmg_4c_Grade.Value

        DO CASE
            CASE loc_nValor = 1 AND THIS.cmg_4c_Grade.Buttons(1).Enabled
                SELECT csOperacoes
                REPLACE ALL SelImp WITH .T. FOR EMPTY(ALLTRIM(csOperacoes.Erros))
                GO TOP
                THIS.grd_4c_Dados.Refresh()

            CASE loc_nValor = 2 AND THIS.cmg_4c_Grade.Buttons(2).Enabled
                SELECT csOperacoes
                REPLACE ALL SelImp WITH .F.
                GO TOP
                THIS.grd_4c_Dados.Refresh()

            CASE loc_nValor = 3 AND THIS.cmg_4c_Grade.Buttons(3).Enabled
                IF USED("csOperacoes") AND !EOF("csOperacoes")
                    TRY
                        DO FORM SigMvExp WITH csOperacoes.Dopes, "C", csOperacoes.Numes, ;
                                              csOperacoes.Emps, .T.
                    CATCH TO loc_oErro
                        MsgErro("Form SigMvExp n" + CHR(227) + "o dispon" + CHR(237) + ;
                                "vel: " + loc_oErro.Message, "Aviso")
                    ENDTRY
                ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnDirsClick - abre seletor de pasta
    *==========================================================================
    PROCEDURE BtnDirsClick()
        LOCAL loc_cDir
        loc_cDir = ALLTRIM(THIS.txt_4c_Dirs.Value)
        loc_cDir = ALLTRIM(GETDIR(loc_cDir, ;
                   "Selecione o Diret" + CHR(243) + "rio / Pasta De Grava" + ;
                   CHR(231) + CHR(227) + "o do Arquivo", ;
                   "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rios", 2))
        IF !EMPTY(loc_cDir)
            THIS.txt_4c_Dirs.Value = loc_cDir
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtCEmpsLostFocus - valida codigo da empresa e popula descricao
    *==========================================================================
    PROCEDURE TxtCEmpsLostFocus()
        LOCAL loc_cEmps, loc_cSQL, loc_oErro
        loc_cEmps = PADR(ALLTRIM(THIS.txt_4c_CEmps.Value), 3)

        IF EMPTY(ALLTRIM(loc_cEmps))
            THIS.txt_4c_DEmps.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmps)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpBusca") > 0
                IF USED("cursor_4c_EmpBusca") AND !EOF("cursor_4c_EmpBusca")
                    THIS.txt_4c_DEmps.Value = ALLTRIM(NVL(cursor_4c_EmpBusca.Razas, ""))
                ELSE
                    THIS.txt_4c_DEmps.Value = ""
                    MsgAviso("Empresa " + CHR(34) + ALLTRIM(loc_cEmps) + CHR(34) + ;
                             " n" + CHR(227) + "o encontrada!")
                    THIS.txt_4c_CEmps.SetFocus()
                ENDIF
            ELSE
                THIS.txt_4c_DEmps.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar empresa")
        ENDTRY

        IF USED("cursor_4c_EmpBusca")
            USE IN cursor_4c_EmpBusca
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtCEmpsKeyPress - Enter/Tab/F4 disparam validacao da empresa
    *==========================================================================
    PROCEDURE TxtCEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.TxtCEmpsLostFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - atualiza editbox de erros ao mudar linha
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        IF THIS.edt_4c_Erros.Visible
            THIS.edt_4c_Erros.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CheckMouseDown - toggle do checkbox de selecao via clique do mouse
    *==========================================================================
    PROCEDURE CheckMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        IF USED("csOperacoes") AND !EOF("csOperacoes")
            IF EMPTY(ALLTRIM(csOperacoes.Erros))
                SELECT csOperacoes
                REPLACE SelImp WITH !csOperacoes.SelImp
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
        NODEFAULT
    ENDPROC

    *==========================================================================
    * CheckKeyPress - toggle do checkbox via Enter ou Espaco
    *==========================================================================
    PROCEDURE CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            IF USED("csOperacoes") AND !EOF("csOperacoes")
                IF EMPTY(ALLTRIM(csOperacoes.Erros))
                    SELECT csOperacoes
                    REPLACE SelImp WITH !csOperacoes.SelImp
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - fecha cursores e libera BO
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursores(7), loc_i
        loc_aCursores(1) = "csOperacoes"
        loc_aCursores(2) = "LocalNotas"
        loc_aCursores(3) = "LocalEmp"
        loc_aCursores(4) = "LocalUfs"
        loc_aCursores(5) = "LocalNfS"
        loc_aCursores(6) = "LocalNfE"
        loc_aCursores(7) = "cursor_4c_EmpBusca"

        FOR loc_i = 1 TO 7
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
