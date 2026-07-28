*==============================================================================
* FORMSIGREHPR.PRG
* Formulario: Relat CHR(243)rio de Hist CHR(243)rico de Produtos
* Herda de: FormBase
* Tipo: REPORT (frmrelatorio - layout FLAT, sem PageFrame)
* BO: sigrehprBO
* FRX: SigRehp1.frx (sem peso) / SigRehp2.frx (com peso)
* Migrado de: sigrehpr.SCX (Width=800, Height=320)
*==============================================================================

DEFINE CLASS Formsigrehpr AS FormBase

    *-- Dimensoes exatas do original
    Height       = 320
    Width        = 800
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    BorderStyle  = 2
    AutoCenter   = .T.
    ControlBox   = .F.
    ClipControls = .T.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    Themes       = .F.
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Propriedades customizadas
    this_oRelatorio = .NULL.
    this_cTipo      = "REFERENCIA"

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO, configura interface e inicializa campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
                           "rico de Produtos"

            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    MsgErro("Conex" + CHR(227) + "o com banco de dados inv" + ;
                            CHR(225) + "lida.", "Formsigrehpr.InicializarForm")
                    loc_lSucesso = .F.
                ELSE
                    THIS.this_oRelatorio = CREATEOBJECT("sigrehprBO")
                    IF VARTYPE(THIS.this_oRelatorio) != "O"
                        MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio.", ;
                                "Formsigrehpr.InicializarForm")
                        loc_lSucesso = .F.
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

            IF loc_lSucesso
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoesRelatorio()
                THIS.ConfigurarFiltrosTipo()
                THIS.ConfigurarFiltrosGrEstoque()
                THIS.ConfigurarFiltrosEstoque()
                THIS.ConfigurarFiltrosCodigo()
                THIS.ConfigurarFiltrosPeriodo()
                THIS.ConfigurarFiltrosCdBarra()
                THIS.ConfigurarFiltrosEmpresa()
                THIS.ConfigurarFiltrosOpcoes()
                THIS.ConfigurarEventos()
                THIS.InicializarCampos()
                THIS.AtualizarHabilitacaoCampos()
                THIS.Visible = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrehpr.InicializarForm")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Override para REPORT (sem logica CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo branco (replica cntSombra)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
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
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 20
            .Left      = 14
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
                         "rico de Produtos"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 17
            .Left      = 12
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
                         "rico de Produtos"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesRelatorio - Botoes Visualizar/Imprimir/Excel/Encerrar
    * Posicao original: btnReport.Left=531, Top=0
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
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
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_imprimir_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

        WITH THIS.cmg_4c_Botoes.Buttons(3)
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excel_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

        WITH THIS.cmg_4c_Botoes.Buttons(4)
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosTipo - opt_nr_tipo: Referencia / Codigo de Barras / Geral
    * Original: Left=264, Top=85, Width=360, Height=22, ButtonCount=3
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosTipo()
        THIS.AddObject("opt_4c_NrTipo", "OptionGroup")
        WITH THIS.opt_4c_NrTipo
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 22
            .Left          = 264
            .Top           = 85
            .Width         = 362
            .SpecialEffect = 0
            .AutoSize      = .F.
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.opt_4c_NrTipo.Buttons(1)
            .Caption   = "\<Refer" + CHR(234) + "ncia"
            .Left      = 5
            .Top       = 4
            .Width     = 70
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        WITH THIS.opt_4c_NrTipo.Buttons(2)
            .Caption   = "\<C" + CHR(243) + "digo de Barras"
            .Left      = 90
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        WITH THIS.opt_4c_NrTipo.Buttons(3)
            .Caption   = "\<Geral Por Refer" + CHR(234) + "ncia"
            .WordWrap        = .T.
            .Left      = 216
            .Top       = 4
            .Width     = 136
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosGrEstoque - Say2 + get_Cd_GrEstoque + get_Ds_GrEstoque
    * Original: Say2 L=169,T=115; CdGr L=269,T=110,W=80; DsGr L=351,T=110,W=150
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosGrEstoque()
        THIS.AddObject("lbl_4c_GrEstoque", "Label")
        WITH THIS.lbl_4c_GrEstoque
            .Caption   = "Grupo de Estoque :"
            .Left      = 169
            .Top       = 118
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdGrEstoque", "TextBox")
        WITH THIS.txt_4c_CdGrEstoque
            .Value         = SPACE(10)
            .Left          = 269
            .Top           = 110
            .Width         = 80
            .Height        = 25
            .MaxLength     = 10
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsGrEstoque", "TextBox")
        WITH THIS.txt_4c_DsGrEstoque
            .Value     = SPACE(20)
            .Left      = 351
            .Top       = 110
            .Width     = 150
            .Height    = 25
            .MaxLength = 20
            .Format    = "K!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosEstoque - lbl_estoque + get_cd_estoque + get_ds_estoque
    * Original: lbl L=216,T=142; cd L=269,T=137,W=80; ds L=351,T=137,W=290
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosEstoque()
        THIS.AddObject("lbl_4c_Estoque", "Label")
        WITH THIS.lbl_4c_Estoque
            .Caption   = "Estoque :"
            .Left      = 216
            .Top       = 142
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH THIS.txt_4c_CdEstoque
            .Value         = SPACE(10)
            .Left          = 269
            .Top           = 137
            .Width         = 80
            .Height        = 25
            .MaxLength     = 10
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 0
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH THIS.txt_4c_DsEstoque
            .Value     = SPACE(40)
            .Left      = 351
            .Top       = 137
            .Width     = 290
            .Height    = 25
            .MaxLength = 40
            .Format    = "K!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosCodigo - lbl_codigo + get_cd_codigo + get_ds_codigo
    * Original: lbl L=222,T=169; cd L=269,T=164,W=108; ds L=379,T=164,W=290
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosCodigo()
        THIS.AddObject("lbl_4c_Codigo", "Label")
        WITH THIS.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Left      = 222
            .Top       = 169
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdCodigo", "TextBox")
        WITH THIS.txt_4c_CdCodigo
            .Value         = SPACE(14)
            .Left          = 269
            .Top           = 164
            .Width         = 108
            .Height        = 25
            .MaxLength     = 14
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 0
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsCodigo", "TextBox")
        WITH THIS.txt_4c_DsCodigo
            .Value     = SPACE(40)
            .Left      = 379
            .Top       = 164
            .Width     = 290
            .Height    = 25
            .MaxLength = 40
            .Format    = "K!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosPeriodo - lbl_periodo + dt_inicial + "a" + dt_final
    * Original: lbl L=219,T=196; ini L=269,T=191,W=80; "a" L=354; fin L=366,W=80
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosPeriodo()
        THIS.AddObject("lbl_4c_Periodo", "Label")
        WITH THIS.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 219
            .Top       = 196
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtInicial", "TextBox")
        WITH THIS.txt_4c_DtInicial
            .Value     = DATE()
            .Left      = 269
            .Top       = 191
            .Width     = 80
            .Height    = 25
            .MaxLength = 10
            .Format    = "K"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_PeriodoA", "Label")
        WITH THIS.lbl_4c_PeriodoA
            .Caption   = CHR(224)
            .Left      = 354
            .Top       = 196
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Value     = DATE()
            .Left      = 366
            .Top       = 191
            .Width     = 80
            .Height    = 25
            .MaxLength = 10
            .Format    = "K"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosCdBarra - Say1 + Get_cd_barra
    * Original: Say1 L=173,T=223; barra L=269,T=218,W=108,InputMask=9999999999999
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosCdBarra()
        THIS.AddObject("lbl_4c_CdBarra", "Label")
        WITH THIS.lbl_4c_CdBarra
            .Caption   = "C" + CHR(243) + "digo de Barras :"
            .Left      = 173
            .Top       = 226
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdBarra", "TextBox")
        WITH THIS.txt_4c_CdBarra
            .Value         = 0
            .Left          = 269
            .Top           = 218
            .Width         = 108
            .Height        = 25
            .MaxLength     = 14
            .InputMask     = "9999999999999"
            .Format        = "K"
            .Alignment     = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosEmpresa - Say5 + getEmpresa + getDesEmpresa
    * Original: Say5 L=214,T=248; Empresa L=269,T=245,W=31; DesEmpresa L=302,W=290
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosEmpresa()
        THIS.AddObject("lbl_4c_Empresa", "Label")
        WITH THIS.lbl_4c_Empresa
            .Caption   = "Empresa :"
            .Left      = 214
            .Top       = 251
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH THIS.txt_4c_CdEmpresa
            .Value     = ""
            .Left      = 269
            .Top       = 245
            .Width     = 31
            .Height    = 25
            .MaxLength = 3
            .Format    = "K!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH THIS.txt_4c_DsEmpresa
            .Value     = ""
            .Left      = 302
            .Top       = 245
            .Width     = 290
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosOpcoes - Say3 + Opt_imp_medio + Say4 + optObs
    * Original: Say3 L=156,T=273; ImpMedio L=327,T=267; Say4 L=157,T=293; Obs L=327,T=287
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosOpcoes()
        THIS.AddObject("lbl_4c_ImpMedio", "Label")
        WITH THIS.lbl_4c_ImpMedio
            .Caption   = "Imprime Custo M" + CHR(233) + "dio do \<Produto  :"
            .Left      = 156
            .Top       = 276
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opt_4c_ImpMedio", "OptionGroup")
        WITH THIS.opt_4c_ImpMedio
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 23
            .Left          = 327
            .Top           = 267
            .Width         = 97
            .SpecialEffect = 0
            .AutoSize      = .F.
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.opt_4c_ImpMedio.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 4
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        WITH THIS.opt_4c_ImpMedio.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 51
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_OptObs", "Label")
        WITH THIS.lbl_4c_OptObs
            .Caption   = "Imprime Observa" + CHR(231) + CHR(227) + "o do \<Hist" + ;
                         CHR(243) + "rico :"
            .Left      = 157
            .Top       = 296
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opt_4c_OptObs", "OptionGroup")
        WITH THIS.opt_4c_OptObs
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 25
            .Left          = 327
            .Top           = 287
            .Width         = 185
            .SpecialEffect = 0
            .AutoSize      = .F.
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.opt_4c_OptObs.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        WITH THIS.opt_4c_OptObs.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 51
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        WITH THIS.opt_4c_OptObs.Buttons(3)
            .Caption   = "C/Documento"
            .WordWrap        = .T.
            .Left      = 92
            .Top       = 5
            .Width     = 83
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - BINDEVENT para todos os controles interativos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.opt_4c_NrTipo,      "InteractiveChange", THIS, "TipoAlterado")

        BINDEVENT(THIS.txt_4c_CdGrEstoque, "DblClick",  THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(THIS.txt_4c_CdGrEstoque, "KeyPress",  THIS, "TeclaCdGrEstoque")

        BINDEVENT(THIS.txt_4c_DsGrEstoque, "DblClick",  THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(THIS.txt_4c_DsGrEstoque, "KeyPress",  THIS, "TeclaDsGrEstoque")

        BINDEVENT(THIS.txt_4c_CdEstoque,   "DblClick",  THIS, "AbrirBuscaEstoque")
        BINDEVENT(THIS.txt_4c_CdEstoque,   "KeyPress",  THIS, "TeclaCdEstoque")

        BINDEVENT(THIS.txt_4c_DsEstoque,   "DblClick",  THIS, "AbrirBuscaEstoque")
        BINDEVENT(THIS.txt_4c_DsEstoque,   "KeyPress",  THIS, "TeclaDsEstoque")

        BINDEVENT(THIS.txt_4c_CdCodigo,    "DblClick",  THIS, "AbrirBuscaCodigo")
        BINDEVENT(THIS.txt_4c_CdCodigo,    "KeyPress",  THIS, "TeclaCdCodigo")

        BINDEVENT(THIS.txt_4c_DsCodigo,    "DblClick",  THIS, "AbrirBuscaCodigo")
        BINDEVENT(THIS.txt_4c_DsCodigo,    "KeyPress",  THIS, "TeclaDsCodigo")

        BINDEVENT(THIS.txt_4c_CdBarra,     "KeyPress",  THIS, "TeclaCdBarra")

        BINDEVENT(THIS.txt_4c_CdEmpresa,   "DblClick",  THIS, "AbrirBuscaEmpresa")
        BINDEVENT(THIS.txt_4c_CdEmpresa,   "KeyPress",  THIS, "TeclaEmpresa")

        BINDEVENT(THIS.txt_4c_DsEmpresa,   "DblClick",  THIS, "AbrirBuscaEmpresa")
        BINDEVENT(THIS.txt_4c_DsEmpresa,   "KeyPress",  THIS, "TeclaDesEmpresa")
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCampos - Define valores iniciais equivalentes ao Init do original
    * Original: opt_nr_tipo=1, datas=DATE(), barra=0, empresa da empresa logada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarCampos()
        THIS.opt_4c_NrTipo.Value      = 1
        THIS.txt_4c_CdGrEstoque.Value = SPACE(10)
        THIS.txt_4c_DsGrEstoque.Value = SPACE(20)
        THIS.txt_4c_CdEstoque.Value   = SPACE(10)
        THIS.txt_4c_DsEstoque.Value   = SPACE(40)
        THIS.txt_4c_CdCodigo.Value    = SPACE(14)
        THIS.txt_4c_DsCodigo.Value    = SPACE(40)
        THIS.txt_4c_DtInicial.Value   = DATE()
        THIS.txt_4c_DtFinal.Value     = DATE()
        THIS.txt_4c_CdBarra.Value     = 0
        THIS.opt_4c_ImpMedio.Value    = 1
        THIS.opt_4c_OptObs.Value      = 2
        THIS.this_cTipo               = "REFERENCIA"

        THIS.CarregarEmpresaLogada()
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresaLogada - Busca empresa da sessao atual (equivale _Empr+Requery)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarEmpresaLogada()
        LOCAL loc_cCod, loc_cDs, loc_nResult
        loc_cCod = ""
        loc_cDs  = ""
        IF VARTYPE(go_4c_Sistema) = "O" AND !ISNULL(go_4c_Sistema)
            loc_cCod = ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ENDIF
        IF !EMPTY(loc_cCod) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(loc_cCod), ;
                "cursor_4c_SigrehprEmpLg")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprEmpLg")
                SELECT cursor_4c_SigrehprEmpLg
                loc_cDs = ALLTRIM(cursor_4c_SigrehprEmpLg.razas)
            ENDIF
            IF USED("cursor_4c_SigrehprEmpLg")
                USE IN cursor_4c_SigrehprEmpLg
            ENDIF
        ENDIF
        THIS.txt_4c_CdEmpresa.Value = loc_cCod
        THIS.txt_4c_DsEmpresa.Value = loc_cDs
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarHabilitacaoCampos - Habilita/desabilita campos por tipo
    * Equivale aos When events do original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarHabilitacaoCampos()
        LOCAL loc_lRef, loc_lBarra, loc_lGeral
        loc_lRef   = (THIS.this_cTipo = "REFERENCIA")
        loc_lBarra = (THIS.this_cTipo = "CODIGO DE BARRA")
        loc_lGeral = (THIS.this_cTipo = "GERAL")

        THIS.txt_4c_CdGrEstoque.Enabled = !loc_lBarra
        THIS.txt_4c_DsGrEstoque.Enabled = !loc_lBarra
        THIS.txt_4c_CdEstoque.Enabled   = !loc_lBarra
        THIS.txt_4c_DsEstoque.Enabled   = !loc_lBarra
        THIS.txt_4c_CdCodigo.Enabled    = loc_lRef
        THIS.txt_4c_DsCodigo.Enabled    = loc_lRef
        THIS.txt_4c_CdBarra.Enabled     = loc_lBarra
        THIS.txt_4c_CdEmpresa.Enabled   = loc_lGeral
        THIS.txt_4c_DsEmpresa.Enabled   = loc_lGeral

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere controles para o BO antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oRel
        loc_oRel = THIS.this_oRelatorio
        IF VARTYPE(loc_oRel) != "O"
            RETURN
        ENDIF
        WITH loc_oRel
            .this_nOptTipo     = THIS.opt_4c_NrTipo.Value
            .this_cEmpresa     = PADR(ALLTRIM(THIS.txt_4c_CdEmpresa.Value), 3)
            .this_cDesEmpresa  = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
            .this_cCdGrEstoque = PADR(ALLTRIM(THIS.txt_4c_CdGrEstoque.Value), 10)
            .this_cDsGrEstoque = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
            .this_cCdEstoque   = PADR(ALLTRIM(THIS.txt_4c_CdEstoque.Value), 10)
            .this_cDsEstoque   = ALLTRIM(THIS.txt_4c_DsEstoque.Value)
            .this_cCdCodigo    = PADR(ALLTRIM(THIS.txt_4c_CdCodigo.Value), 14)
            .this_cDsCodigo    = ALLTRIM(THIS.txt_4c_DsCodigo.Value)
            .this_dDtInicial   = THIS.txt_4c_DtInicial.Value
            .this_dDtFinal     = THIS.txt_4c_DtFinal.Value
            .this_nCdBarra     = THIS.txt_4c_CdBarra.Value
            .this_nImpMedio    = THIS.opt_4c_ImpMedio.Value
            .this_nOptObs      = THIS.opt_4c_OptObs.Value
            .this_cTipo        = THIS.this_cTipo
        ENDWITH
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnExcelClick()
        MsgInfo("Exporta" + CHR(231) + CHR(227) + "o Excel n" + CHR(227) + ;
                "o dispon" + CHR(237) + "vel para este relat" + CHR(243) + "rio.", ;
                "Excel")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TROCA DE TIPO DE RELATORIO
    * Equivale ao opt_nr_tipo.Valid do original
    *==========================================================================

    PROCEDURE TipoAlterado()
        LOCAL loc_nTipo
        loc_nTipo = THIS.opt_4c_NrTipo.Value

        DO CASE
        CASE loc_nTipo = 1
            THIS.this_cTipo           = "REFERENCIA"
            THIS.txt_4c_CdBarra.Value = 0
            THIS.CarregarEmpresaLogada()

        CASE loc_nTipo = 2
            THIS.this_cTipo                 = "CODIGO DE BARRA"
            THIS.txt_4c_DsGrEstoque.Value   = ""
            THIS.txt_4c_CdGrEstoque.Value   = ""
            THIS.txt_4c_CdEstoque.Value     = ""
            THIS.txt_4c_DsEstoque.Value     = ""
            THIS.txt_4c_CdCodigo.Value      = ""
            THIS.txt_4c_DsCodigo.Value      = ""
            THIS.txt_4c_CdBarra.Value       = 0
            THIS.CarregarEmpresaLogada()

        CASE loc_nTipo = 3
            THIS.this_cTipo            = "GERAL"
            THIS.txt_4c_CdBarra.Value  = 0
            THIS.txt_4c_CdCodigo.Value = ""
            THIS.txt_4c_DsCodigo.Value = ""
        ENDCASE

        THIS.AtualizarHabilitacaoCampos()
    ENDPROC

    *==========================================================================
    * GRUPO DE ESTOQUE - SigCdGcr (codigos/descrs) - equivale fAcessoContab
    *==========================================================================

    PROCEDURE ValidarCdGrEstoque()
        LOCAL loc_cCodigo, loc_nResult
        TRY
            loc_cCodigo = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            IF EMPTY(loc_cCodigo)
                THIS.txt_4c_DsGrEstoque.Value = ""
                THIS.txt_4c_CdEstoque.Value   = ""
                THIS.txt_4c_DsEstoque.Value   = ""
                RETURN
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                EscaparSQL(loc_cCodigo), ;
                "cursor_4c_SigrehprGcrVl")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprGcrVl")
                SELECT cursor_4c_SigrehprGcrVl
                THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_SigrehprGcrVl.codigos)
                THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_SigrehprGcrVl.descrs)
            ELSE
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaGrEstoque()
            ENDIF
            IF USED("cursor_4c_SigrehprGcrVl")
                USE IN cursor_4c_SigrehprGcrVl
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarDsGrEstoque()
        LOCAL loc_cDescr
        loc_cDescr = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
        IF EMPTY(loc_cDescr)
            THIS.txt_4c_CdGrEstoque.Value = ""
            THIS.txt_4c_CdEstoque.Value   = ""
            THIS.txt_4c_DsEstoque.Value   = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaGrEstoque()
    ENDPROC

    PROCEDURE AbrirBuscaGrEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_cCursor
        loc_cCursor = "cursor_4c_SigrehprGcrBs"
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", loc_cCursor, "codigos", loc_cValor, ;
                "Selecionar Grupo de Estoque", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(codigos)
                    THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(descrs)
                    THIS.txt_4c_CdEstoque.Value   = ""
                    THIS.txt_4c_DsEstoque.Value   = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaGrEstoque()
        ENDIF
    ENDPROC

    *==========================================================================
    * CONTA DE ESTOQUE - SigCdCli (iclis/rclis) - equivale fAcessoContas
    *==========================================================================

    PROCEDURE ValidarCdEstoque()
        LOCAL loc_cCodigo, loc_cGrupo, loc_cFiltro, loc_nResult
        TRY
            loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEstoque.Value)
            IF EMPTY(loc_cCodigo)
                THIS.txt_4c_DsEstoque.Value = ""
                RETURN
            ENDIF
            loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = " AND grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                EscaparSQL(loc_cCodigo) + loc_cFiltro, ;
                "cursor_4c_SigrehprCliVl")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprCliVl")
                SELECT cursor_4c_SigrehprCliVl
                THIS.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_SigrehprCliVl.iclis)
                THIS.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_SigrehprCliVl.rclis)
            ELSE
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaEstoque()
            ENDIF
            IF USED("cursor_4c_SigrehprCliVl")
                USE IN cursor_4c_SigrehprCliVl
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarDsEstoque()
        LOCAL loc_cDescr
        loc_cDescr = ALLTRIM(THIS.txt_4c_DsEstoque.Value)
        IF EMPTY(loc_cDescr)
            THIS.txt_4c_CdEstoque.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaEstoque()
    ENDPROC

    PROCEDURE AbrirBuscaEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_cCursor, loc_cGrupo, loc_cFiltro
        loc_cCursor = "cursor_4c_SigrehprCliBs"
        TRY
            loc_cValor  = ALLTRIM(THIS.txt_4c_CdEstoque.Value)
            loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
                "Selecionar Conta de Estoque", loc_cFiltro)
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    THIS.txt_4c_CdEstoque.Value = ALLTRIM(iclis)
                    THIS.txt_4c_DsEstoque.Value = ALLTRIM(rclis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaEstoque()
        ENDIF
    ENDPROC

    *==========================================================================
    * CODIGO DO PRODUTO - SigCdPro (cpros/dpros) - equivale fwBuscaExt
    *==========================================================================

    PROCEDURE ValidarCdCodigo()
        LOCAL loc_cCodigo, loc_nResult
        TRY
            loc_cCodigo = ALLTRIM(THIS.txt_4c_CdCodigo.Value)
            IF EMPTY(loc_cCodigo)
                THIS.txt_4c_DsCodigo.Value = ""
                RETURN
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 cpros, dpros FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(loc_cCodigo), ;
                "cursor_4c_SigrehprProVl")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprProVl")
                SELECT cursor_4c_SigrehprProVl
                THIS.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl.cpros)
                THIS.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl.dpros)
            ELSE
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaCodigo()
            ENDIF
            IF USED("cursor_4c_SigrehprProVl")
                USE IN cursor_4c_SigrehprProVl
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarDsCodigo()
        LOCAL loc_cDescr
        loc_cDescr = ALLTRIM(THIS.txt_4c_DsCodigo.Value)
        IF EMPTY(loc_cDescr)
            THIS.txt_4c_CdCodigo.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaCodigo()
    ENDPROC

    PROCEDURE AbrirBuscaCodigo()
        LOCAL loc_oBusca, loc_cValor, loc_cCursor
        loc_cCursor = "cursor_4c_SigrehprProBs"
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_CdCodigo.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", loc_cCursor, "cpros", loc_cValor, ;
                "Selecionar Produto", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    THIS.txt_4c_CdCodigo.Value = ALLTRIM(cpros)
                    THIS.txt_4c_DsCodigo.Value = ALLTRIM(dpros)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaCodigo()
        ENDIF
    ENDPROC

    *==========================================================================
    * CODIGO DE BARRAS - SigOpEtq / SigCdPro
    * Equivale ao Get_cd_barra.Valid do original (busca em SigOpEtq e SigCdPro)
    *==========================================================================

    PROCEDURE ValidarCdBarra()
        LOCAL loc_cCdBarra, loc_nResult, loc_cCpros
        TRY
            loc_cCdBarra = ALLTRIM(STR(THIS.txt_4c_CdBarra.Value, 14))

            IF EMPTY(loc_cCdBarra) OR THIS.txt_4c_CdBarra.Value = 0
                THIS.txt_4c_CdCodigo.Value = ""
                THIS.txt_4c_DsCodigo.Value = ""
                RETURN
            ENDIF

            *-- 1. Buscar em SigOpEtq por cbars
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 cpros FROM SigOpEtq WHERE cbars = " + ;
                ALLTRIM(STR(THIS.txt_4c_CdBarra.Value, 14)), ;
                "cursor_4c_SigrehprEtqVl")
            IF loc_nResult < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao validar c" + CHR(243) + ;
                        "digo de barras.", "ValidarCdBarra")
                RETURN
            ENDIF

            SELECT cursor_4c_SigrehprEtqVl
            GO TOP
            IF !EOF("cursor_4c_SigrehprEtqVl")
                *-- Encontrado em SigOpEtq: buscar produto pelo cpros
                loc_cCpros = ALLTRIM(cursor_4c_SigrehprEtqVl.cpros)
                IF USED("cursor_4c_SigrehprEtqVl")
                    USE IN cursor_4c_SigrehprEtqVl
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 cpros, dpros FROM SigCdPro WHERE cpros = " + ;
                    EscaparSQL(loc_cCpros), ;
                    "cursor_4c_SigrehprProVl2")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprProVl2")
                    SELECT cursor_4c_SigrehprProVl2
                    THIS.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl2.cpros)
                    THIS.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl2.dpros)
                ENDIF
                IF USED("cursor_4c_SigrehprProVl2")
                    USE IN cursor_4c_SigrehprProVl2
                ENDIF
            ELSE
                *-- Nao encontrado em SigOpEtq: buscar em SigCdPro por cbars
                IF USED("cursor_4c_SigrehprEtqVl")
                    USE IN cursor_4c_SigrehprEtqVl
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 cpros FROM SigCdPro WHERE cbars = " + ;
                    ALLTRIM(STR(THIS.txt_4c_CdBarra.Value, 14)), ;
                    "cursor_4c_SigrehprPrvVl")
                IF loc_nResult < 1
                    MsgErro("Falha na conex" + CHR(227) + "o ao validar c" + CHR(243) + ;
                            "digo de barras.", "ValidarCdBarra")
                ELSE
                    SELECT cursor_4c_SigrehprPrvVl
                    GO TOP
                    IF EOF("cursor_4c_SigrehprPrvVl")
                        MsgAviso("C" + CHR(243) + "digo de Barra n" + CHR(227) + ;
                                 "o cadastrado!", "C" + CHR(243) + "digo de Barras")
                        THIS.txt_4c_CdCodigo.Value = ""
                        THIS.txt_4c_DsCodigo.Value = ""
                    ELSE
                        IF USED("cursor_4c_SigrehprPrvVl")
                            USE IN cursor_4c_SigrehprPrvVl
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 cpros, dpros FROM SigCdPro WHERE cbars = " + ;
                            ALLTRIM(STR(THIS.txt_4c_CdBarra.Value, 14)), ;
                            "cursor_4c_SigrehprProVl3")
                        IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprProVl3")
                            SELECT cursor_4c_SigrehprProVl3
                            THIS.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl3.cpros)
                            THIS.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl3.dpros)
                        ENDIF
                        IF USED("cursor_4c_SigrehprProVl3")
                            USE IN cursor_4c_SigrehprProVl3
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_SigrehprPrvVl")
                        USE IN cursor_4c_SigrehprPrvVl
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_SigrehprEtqVl")
                USE IN cursor_4c_SigrehprEtqVl
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TeclaCdBarra(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdBarra()
        ENDIF
    ENDPROC

    *==========================================================================
    * EMPRESA - SigCdEmp (cemps/razas) - equivale fAcessoEmpresa
    *==========================================================================

    PROCEDURE ValidarEmpresa()
        LOCAL loc_cCodigo, loc_nResult
        TRY
            loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
            IF EMPTY(loc_cCodigo)
                THIS.txt_4c_DsEmpresa.Value = ""
                RETURN
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(loc_cCodigo), ;
                "cursor_4c_SigrehprEmpVl")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprEmpVl")
                SELECT cursor_4c_SigrehprEmpVl
                THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_SigrehprEmpVl.cemps)
                THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_SigrehprEmpVl.razas)
            ELSE
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaEmpresa()
            ENDIF
            IF USED("cursor_4c_SigrehprEmpVl")
                USE IN cursor_4c_SigrehprEmpVl
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarDesEmpresa()
        LOCAL loc_cDescr
        loc_cDescr = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
        IF THIS.this_cTipo = "GERAL" AND !EMPTY(loc_cDescr)
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_cValor, loc_cCursor
        loc_cCursor = "cursor_4c_SigrehprEmpBs"
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", loc_cCursor, "cemps", loc_cValor, ;
                "Selecionar Empresa", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cemps)
                    THIS.txt_4c_DsEmpresa.Value = ALLTRIM(razas)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDesEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE COM PIPELINE CRUD - Formularios REPORT (frmrelatorio)
    *
    * Forms REPORT possuem layout FLAT (todos os controles direto no Form),
    * sem PageFrame de Lista/Dados como nos forms CRUD (frmcadastro).
    * Os controles equivalentes a "lista de filtros" sao adicionados em
    * InicializarForm() via ConfigurarFiltros*() e os botoes de acao via
    * ConfigurarBotoesRelatorio() (CommandGroup com Visualizar/Imprimir/Excel/Encerrar).
    *
    * Os metodos abaixo existem para compatibilidade com o pipeline de migracao
    * e com BINDEVENTs eventualmente herdados de FormBase.
    *==========================================================================

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- REPORT FLAT: equivalente ja configurado em InicializarForm()
        *-- (ConfigurarFiltros* + ConfigurarBotoesRelatorio).
        RETURN
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- REPORT FLAT: nao ha Page2 de edicao de dados.
        *-- Todos os campos de parametro (filtros) sao adicionados diretamente
        *-- ao form em InicializarForm() via ConfigurarFiltros*().
        *-- Este metodo existe para compatibilidade com FormBase.
        RETURN
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        *-- REPORT FLAT: nao ha PageFrame para alternar. Mantem foco no
        *-- primeiro controle editavel dependendo do tipo selecionado.
        LOCAL loc_oErro
        TRY
            DO CASE
            CASE THIS.this_cTipo = "REFERENCIA"
                IF THIS.txt_4c_CdGrEstoque.Enabled
                    THIS.txt_4c_CdGrEstoque.SetFocus()
                ENDIF
            CASE THIS.this_cTipo = "CODIGO DE BARRA"
                IF THIS.txt_4c_CdBarra.Enabled
                    THIS.txt_4c_CdBarra.SetFocus()
                ENDIF
            CASE THIS.this_cTipo = "GERAL"
                IF THIS.txt_4c_CdEmpresa.Enabled
                    THIS.txt_4c_CdEmpresa.SetFocus()
                ENDIF
            ENDCASE
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS - Compatibilidade com pipeline CRUD
    *
    * Form REPORT (frmrelatorio) NAO possui operacoes CRUD (Incluir/Alterar/
    * Excluir). Acoes reais sao: Visualizar (preview), Imprimir (papel), Excel
    * (exportacao) e Encerrar (fechar).
    *
    * Os metodos abaixo existem para compatibilidade com o pipeline de migracao
    * e delegam para a acao equivalente do form REPORT:
    *   BtnIncluirClick    -> BtnVisualizarClick (gerar/visualizar relatorio)
    *   BtnAlterarClick    -> BtnVisualizarClick (regerar com novos filtros)
    *   BtnVisualizarClick -> ja implementado acima (preview na tela)
    *   BtnExcluirClick    -> limpa os filtros para nova consulta
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        *-- REPORT: "Incluir" equivale a gerar/visualizar um novo relatorio
        *-- com base nos filtros atuais. Delega para Visualizar.
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        *-- REPORT: "Alterar" equivale a regerar o relatorio com filtros
        *-- atualizados. Delega para Visualizar.
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        *-- REPORT: nao ha exclusao de registros. A acao equivalente eh
        *-- limpar os filtros para preparar nova consulta.
        LOCAL loc_oErro
        TRY
            THIS.opt_4c_NrTipo.Value      = 1
            THIS.this_cTipo               = "REFERENCIA"
            THIS.txt_4c_CdGrEstoque.Value = SPACE(10)
            THIS.txt_4c_DsGrEstoque.Value = SPACE(20)
            THIS.txt_4c_CdEstoque.Value   = SPACE(10)
            THIS.txt_4c_DsEstoque.Value   = SPACE(40)
            THIS.txt_4c_CdCodigo.Value    = SPACE(14)
            THIS.txt_4c_DsCodigo.Value    = SPACE(40)
            THIS.txt_4c_DtInicial.Value   = DATE()
            THIS.txt_4c_DtFinal.Value     = DATE()
            THIS.txt_4c_CdBarra.Value     = 0
            THIS.opt_4c_ImpMedio.Value    = 1
            THIS.opt_4c_OptObs.Value      = 2
            THIS.CarregarEmpresaLogada()
            THIS.AtualizarHabilitacaoCampos()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CONSOLIDACAO FASE 8: Metodos finais e compatibilidade com pipeline
    *==========================================================================

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos de filtro (retorna ao estado inicial)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            THIS.opt_4c_NrTipo.Value      = 1
            THIS.this_cTipo               = "REFERENCIA"
            THIS.txt_4c_CdGrEstoque.Value = SPACE(10)
            THIS.txt_4c_DsGrEstoque.Value = SPACE(20)
            THIS.txt_4c_CdEstoque.Value   = SPACE(10)
            THIS.txt_4c_DsEstoque.Value   = SPACE(40)
            THIS.txt_4c_CdCodigo.Value    = SPACE(14)
            THIS.txt_4c_DsCodigo.Value    = SPACE(40)
            THIS.txt_4c_DtInicial.Value   = DATE()
            THIS.txt_4c_DtFinal.Value     = DATE()
            THIS.txt_4c_CdBarra.Value     = 0
            THIS.opt_4c_ImpMedio.Value    = 1
            THIS.opt_4c_OptObs.Value      = 2
            THIS.CarregarEmpresaLogada()
            THIS.AtualizarHabilitacaoCampos()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme tipo de relatorio
    * Delega para AtualizarHabilitacaoCampos (implementacao completa)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        THIS.AtualizarHabilitacaoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Form REPORT nao tem lista CRUD; atualiza habilitacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.AtualizarHabilitacaoCampos()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Form REPORT nao tem modos CRUD; noop
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio para compatibilidade com pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Form REPORT nao carrega registros do BO de volta aos campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - REPORT: buscar = visualizar relatorio com filtros atuais
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - REPORT: salvar = gerar e imprimir relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - REPORT: cancelar = encerrar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos (NAO usar .Release() em Custom/BO)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
