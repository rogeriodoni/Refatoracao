*==============================================================================
* FormAli.PRG - Fase 7/8: Form - Eventos Principais (completo)
* Formulario de Cadastro de Alineas (SIGCDALI)
*
* Tabela: SigCdAli
* Tipo: CRUD (frmcadastro)
* BO: AliBO
*==============================================================================

DEFINE CLASS FormAli AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Al" + CHR(237) + "neas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("AliBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar AliBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria containers, grid e botoes da Page1 (Lista)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho cinza (Top = 2 + 29 = 31, compensacao PageFrame.Top=-29)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (canonico: Top=29, Left=542, Width=390)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Top=88+29=117, Left=12, Width=890, Height=480)
        *-- RecordSource e ColumnCount FORA do WITH para criar colunas imediatamente
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oPg1.grd_4c_Lista.RecordSource = ""
        loc_oPg1.grd_4c_Lista.ColumnCount  = 4

        WITH loc_oPg1.grd_4c_Lista
            .Top                     = 117
            .Left                    = 12
            .Width                   = 890
            .Height                  = 480
            .FontName                = "Verdana"
            .FontSize                = 8
            .ForeColor               = RGB(90, 90, 90)
            .BackColor               = RGB(255, 255, 255)
            .GridLineColor           = RGB(238, 238, 238)
            .HighlightBackColor      = RGB(255, 255, 255)
            .HighlightForeColor      = RGB(15, 41, 104)
            .HighlightStyle          = 2
            .DeleteMark              = .F.
            .RecordMark              = .F.
            .RowHeight               = 16
            .ScrollBars              = 2
            .GridLines               = 3
            .ReadOnly                = .T.
            .Visible                 = .T.
            .Column1.Width           = 50
            .Column2.Width           = 415
            .Column3.Width           = 200
            .Column4.Width           = 160
            .Column1.ReadOnly        = .T.
            .Column2.ReadOnly        = .T.
            .Column3.ReadOnly        = .T.
            .Column4.ReadOnly        = .T.
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Caption = "Oper. Autom. Cheque"
            .Column4.Header1.Caption = "Cond. Pag. Autom."
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria containers e botoes da Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container botoes Confirmar/Cancelar (Top = 4 + 29 = 33)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label Codigo (Say1: top=171+29=200, left=288, width=42)
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 200
            .Left      = 288
            .Width     = 42
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (getCodigos: top=168+29=197, left=335, width=33)
        loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPg2.txt_4c_Codigos
            .Value         = 0
            .Top           = 197
            .Left          = 335
            .Width         = 33
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "999"
            .Visible       = .T.
        ENDWITH

        *-- Label Descricao (Say2: top=196+29=225, left=275, width=60)
        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 225
            .Left      = 275
            .Width     = 60
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (getDescrs: top=193+29=222, left=335, width=290)
        loc_oPg2.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPg2.txt_4c_Descrs
            .Value         = ""
            .Top           = 222
            .Left          = 335
            .Width         = 290
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label Operacao Cheque Automatica (Say3: top=221+29=250, left=162, width=173)
        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Cheque Autom" + CHR(225) + "tica :"
            .Top       = 250
            .Left      = 162
            .Width     = 173
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Operacao Cheque Automatica (getOpAutos: top=218+29=247, left=335, width=115)
        loc_oPg2.AddObject("txt_4c_OpAutos", "TextBox")
        WITH loc_oPg2.txt_4c_OpAutos
            .Value         = ""
            .Top           = 247
            .Left          = 335
            .Width         = 115
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_OpAutos, "LostFocus", THIS, "ValidarOpAutos")

        *-- Label Operacao Saida de Cheque (Say4: top=246+29=275, left=175)
        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Saida de Cheque :"
            .Top       = 275
            .Left      = 175
            .Width     = 190
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Operacao Saida de Cheque (GetOpSaidas: top=243+29=272, left=335, width=115)
        loc_oPg2.AddObject("txt_4c_OpSaidas", "TextBox")
        WITH loc_oPg2.txt_4c_OpSaidas
            .Value         = ""
            .Top           = 272
            .Left          = 335
            .Width         = 115
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_OpSaidas, "LostFocus", THIS, "ValidarOpSaidas")

        *-- Label Condicao de Pagamento Automatica (Say5: top=271+29=300, left=148)
        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .Caption   = "Condi" + CHR(231) + CHR(227) + "o de Pagamento Automatica :"
            .Top       = 300
            .Left      = 148
            .Width     = 215
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Condicao de Pagamento Automatica (GetFPagSAutos: top=268+29=297, left=335, width=94)
        loc_oPg2.AddObject("txt_4c_FPagSAutos", "TextBox")
        WITH loc_oPg2.txt_4c_FPagSAutos
            .Value         = ""
            .Top           = 297
            .Left          = 335
            .Width         = 94
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_FPagSAutos, "LostFocus", THIS, "ValidarFPagSAutos")

        *-- Label Gera Pendencias Financeiras (Say6: top=295+29=324, left=184)
        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .Caption   = "Gera Pend" + CHR(234) + "ncias Financeiras :"
            .Top       = 324
            .Left      = 184
            .Width     = 180
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Gera Pendencias (optPefins: top=291+29=320, left=335, width=96, height=27)
        *-- Value=2 -> Nao selecionado por default; NAO setar Value em Buttons individuais
        loc_oPg2.AddObject("opt_4c_OptPefins", "OptionGroup")
        WITH loc_oPg2.opt_4c_OptPefins
            .ButtonCount = 2
            .Top         = 320
            .Left        = 335
            .Width       = 96
            .Height      = 27
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .Left      = 51
                .Top       = 5
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca alineas e carrega grid da Page1
    * Fase 3: Chama Buscar(). Fase 4 completa o wire do grid.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.opautos"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.fpagsautos"

                        loc_oGrid.Column1.Width = 50
                        loc_oGrid.Column2.Width = 415
                        loc_oGrid.Column3.Width = 200
                        loc_oGrid.Column4.Width = 160

                        loc_oGrid.Column1.ReadOnly = .T.
                        loc_oGrid.Column2.ReadOnly = .T.
                        loc_oGrid.Column3.ReadOnly = .T.
                        loc_oGrid.Column4.ReadOnly = .T.

                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column3.Header1.Caption = "Oper. Autom. Cheque"
                        loc_oGrid.Column4.Header1.Caption = "Cond. Pag. Autom."

                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Lista (1) e Dados (2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .SetAll("FontName", "Tahoma", "Column")
            .SetAll("FontSize", 8, "Column")
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara form para inclusao de nova alinea
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigo = cursor_4c_Dados.codigos

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigo = cursor_4c_Dados.codigos

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigo = cursor_4c_Dados.codigos

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da al" + CHR(237) + ;
                        "nea " + TRANSFORM(loc_nCodigo) + "?", "Excluir")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Al" + CHR(237) + "nea exclu" + CHR(237) + "da com sucesso!")
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Vai para Page2 no modo BUSCAR (localizar por codigo)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "BUSCAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnBuscarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Salva registro (ou localiza em modo BUSCAR)
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oPg2, loc_nCodBusca, loc_lResultado
        loc_lResultado = .F.

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes ANTES do TRY (RETURN valido aqui)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5) AND ;
           VAL(TRANSFORM(loc_oPg2.txt_4c_Codigos.Value)) = 0 AND ;
           THIS.this_cModoAtual = "INCLUIR"
            MsgAviso("O c" + CHR(243) + "digo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "")
            loc_oPg2.txt_4c_Codigos.SetFocus
            RETURN .F.
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5) AND ;
           EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)) AND ;
           !INLIST(THIS.this_cModoAtual, "BUSCAR", "VISUALIZAR")
            MsgAviso("A descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria.", "")
            loc_oPg2.txt_4c_Descrs.SetFocus
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_cModoAtual = "BUSCAR"
                *-- Localiza pelo codigo digitado e volta para lista
                IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
                    loc_nCodBusca = VAL(TRANSFORM(loc_oPg2.txt_4c_Codigos.Value))
                ELSE
                    loc_nCodBusca = 0
                ENDIF
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                IF USED("cursor_4c_Dados") AND loc_nCodBusca > 0
                    SELECT cursor_4c_Dados
                    LOCATE FOR cursor_4c_Dados.codigos = loc_nCodBusca
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Al" + CHR(237) + "nea salva com sucesso!")
                        THIS.this_cModoAtual = "LISTA"
                        THIS.AlternarPagina(1)
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnConfirmarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.this_oBusinessObject.this_nCodigos    = loc_oPg2.txt_4c_Codigos.Value
            THIS.this_oBusinessObject.this_cDescrs     = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
            THIS.this_oBusinessObject.this_cOpAutos    = ALLTRIM(loc_oPg2.txt_4c_OpAutos.Value)
            THIS.this_oBusinessObject.this_cOpSaidas   = ALLTRIM(loc_oPg2.txt_4c_OpSaidas.Value)
            THIS.this_oBusinessObject.this_cFPagSAutos = ALLTRIM(loc_oPg2.txt_4c_FPagSAutos.Value)
            THIS.this_oBusinessObject.this_nPefins     = loc_oPg2.opt_4c_OptPefins.Value
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg2.txt_4c_Codigos.Value    = THIS.this_oBusinessObject.this_nCodigos
            loc_oPg2.txt_4c_Descrs.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
            loc_oPg2.txt_4c_OpAutos.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cOpAutos)
            loc_oPg2.txt_4c_OpSaidas.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cOpSaidas)
            loc_oPg2.txt_4c_FPagSAutos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cFPagSAutos)
            loc_oPg2.opt_4c_OptPefins.Value  = THIS.this_oBusinessObject.this_nPefins
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Codigos.Value    = 0
            loc_oPg2.txt_4c_Descrs.Value     = ""
            loc_oPg2.txt_4c_OpAutos.Value    = ""
            loc_oPg2.txt_4c_OpSaidas.Value   = ""
            loc_oPg2.txt_4c_FPagSAutos.Value = ""
            loc_oPg2.opt_4c_OptPefins.Value  = 2
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lCodHabilitar
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Codigo habilitado somente em INCLUIR e BUSCAR
            loc_lCodHabilitar = INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
            loc_oPg2.txt_4c_Codigos.Enabled    = loc_lCodHabilitar
            loc_oPg2.txt_4c_Descrs.Enabled     = par_lHabilitar
            loc_oPg2.txt_4c_OpAutos.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_OpSaidas.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_FPagSAutos.Enabled = par_lHabilitar
            loc_oPg2.opt_4c_OptPefins.Enabled  = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        TRY
            *-- Confirmar habilitado em INCLUIR, ALTERAR e BUSCAR; desabilitado em VISUALIZAR
            loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOpAutos - Lookup para Operacao de Cheque Automatica (SigCdOpt)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOpAutos()
        LOCAL loc_oPg2, loc_cValor, loc_oBusca
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_OpAutos.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpt", "cursor_4c_BuscaOp", "Operacaos", loc_cValor, ;
                "Opera" + CHR(231) + CHR(227) + "es de Cheques")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Operacaos", "", "Opera" + CHR(231) + CHR(227) + "es")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOp")
                    SELECT cursor_4c_BuscaOp
                    loc_oPg2.txt_4c_OpAutos.Value = ALLTRIM(cursor_4c_BuscaOp.Operacaos)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.ValidarOpAutos")
        ENDTRY

        IF USED("cursor_4c_BuscaOp")
            USE IN cursor_4c_BuscaOp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOpSaidas - Lookup para Operacao de Saida de Cheque (SigCdOpt)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOpSaidas()
        LOCAL loc_oPg2, loc_cValor, loc_oBusca
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_OpSaidas.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpt", "cursor_4c_BuscaOpSai", "Operacaos", loc_cValor, ;
                "Opera" + CHR(231) + CHR(227) + "es de Saida de Cheque")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Operacaos", "", "Opera" + CHR(231) + CHR(227) + "es")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpSai")
                    SELECT cursor_4c_BuscaOpSai
                    loc_oPg2.txt_4c_OpSaidas.Value = ALLTRIM(cursor_4c_BuscaOpSai.Operacaos)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.ValidarOpSaidas")
        ENDTRY

        IF USED("cursor_4c_BuscaOpSai")
            USE IN cursor_4c_BuscaOpSai
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFPagSAutos - Lookup para Condicao de Pagamento Automatica (SigOpFp)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFPagSAutos()
        LOCAL loc_oPg2, loc_cValor, loc_oBusca
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_FPagSAutos.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpFp", "cursor_4c_BuscaFPag", "Fpags", loc_cValor, ;
                "Condi" + CHR(231) + CHR(227) + "o de Pagamento")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Fpags", "", "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFPag")
                    SELECT cursor_4c_BuscaFPag
                    loc_oPg2.txt_4c_FPagSAutos.Value = ALLTRIM(cursor_4c_BuscaFPag.Fpags)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.ValidarFPagSAutos")
        ENDTRY

        IF USED("cursor_4c_BuscaFPag")
            USE IN cursor_4c_BuscaFPag
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
