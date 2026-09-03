*==============================================================================
* FormCfb.PRG - Fase 7/8: Form - Eventos Principais (completo)
* Formulario de Configuracao de Boletos Bancarios (SIGCDCFB)
*
* Tabela: SIGCNFBL (leitura via SigOpFp com LEFT JOIN)
* Tipo: CRUD especial - somente ALTERAR (INSERT proibido pelo legado)
* BO: CfbBO
*==============================================================================

DEFINE CLASS FormCfb AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Configura" + CHR(231) + CHR(227) + "o de Boletos Banc" + CHR(225) + "rios"
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
            MsgErro(loc_oErro.Message, "FormCfb.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Conecta BO e cria estrutura PageFrame
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CfbBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar CfbBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.InicializarForm")
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
    * ConfigurarPaginaLista - Cria Page1 (Lista) com Grid e botoes CRUD
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza (Top=1 + 29 compensacao = 30)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top           = 30
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
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

        *-- Container botoes CRUD (Left=542, Top=29 - canonico)
        *-- Incluir aparece mas bloqueia com mensagem (legado: pcEscolha='INSERIR')
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top           = 29
            .Left          = 542
            .Width         = 390
            .Height        = 85
            .BackStyle     = 1
            .BackColor     = RGB(53, 53, 53)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Top=29)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top           = 29
            .Left          = 917
            .Width         = 90
            .Height        = 85
            .BackStyle     = 0
            .BorderWidth   = 0
            .Visible       = .T.
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (Top=117 = 88+29 compensacao)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        loc_oGrid.Top         = 117
        loc_oGrid.Left        = 12
        loc_oGrid.Width       = 950
        loc_oGrid.Height      = 476
        loc_oGrid.ColumnCount = 3
        WITH loc_oGrid
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RowHeight          = 16
            .ScrollBars         = 2
            .Visible            = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Width           = 100
            .Resizable       = .T.
            .Alignment       = 0
            .Header1.Caption = "Forma Pgto"
            .Header1.FontName = "Tahoma"
            .Header1.FontSize = 8
        ENDWITH

        WITH loc_oGrid.Column2
            .Width           = 680
            .Resizable       = .T.
            .Alignment       = 0
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Header1.FontName = "Tahoma"
            .Header1.FontSize = 8
        ENDWITH

        WITH loc_oGrid.Column3
            .Width           = 100
            .Resizable       = .T.
            .Alignment       = 0
            .Header1.Caption = "Configurado"
            .Header1.FontName = "Tahoma"
            .Header1.FontSize = 8
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Fase 6/8: Todos os campos completos + BINDEVENTs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oSalva

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container botoes Confirmar/Cancelar (Top=4+29=33, Left=842 canonico)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oSalva = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oSalva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oSalva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Shape2: separador no topo da area de dados (top=138+29=167)
        loc_oPg2.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPg2.shp_4c_Shape2
            .Top       = 167
            .Left      = 54
            .Width     = 577
            .Height    = 2
            .BackColor = RGB(80, 80, 80)
            .FillStyle = 1
            .BackStyle = 1
            .Visible   = .T.
        ENDWITH

        *-- ==============================================================
        *-- SECAO: Condicao de Pagamento (top original=121-144 + 29=150-173)
        *-- ==============================================================
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .AutoSize  = .F.
            .Caption   = " Condi" + CHR(231) + CHR(227) + "o de Pagamento "
            .Top       = 150
            .Left      = 61
            .Width     = 144
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_FPags: codigo da condicao de pagamento (sempre read-only - FK SigOpFp)
        loc_oPg2.AddObject("txt_4c_FPags", "TextBox")
        WITH loc_oPg2.txt_4c_FPags
            .Value    = ""
            .Top      = 173
            .Left     = 64
            .Width    = 94
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- txt_4c_DPags: descricao da condicao (display only, vem de SigOpFp.Descrs)
        loc_oPg2.AddObject("txt_4c_DPags", "TextBox")
        WITH loc_oPg2.txt_4c_DPags
            .Value    = ""
            .Top      = 173
            .Left     = 159
            .Width    = 220
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Shape7: separador entre Condicao e Cabecalho (top=201+29=230)
        loc_oPg2.AddObject("shp_4c_Shape7", "Shape")
        WITH loc_oPg2.shp_4c_Shape7
            .Top       = 230
            .Left      = 54
            .Width     = 577
            .Height    = 2
            .BackColor = RGB(80, 80, 80)
            .FillStyle = 1
            .BackStyle = 1
            .Visible   = .T.
        ENDWITH

        *-- ==============================================================
        *-- SECAO: Cabecalho (top original=184+29=213)
        *-- Campos sao pares linha x coluna para posicionamento no boleto
        *-- ==============================================================
        loc_oPg2.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oPg2.lbl_4c_Label28
            .AutoSize  = .F.
            .Caption   = " Cabe" + CHR(231) + "alho "
            .Top       = 213
            .Left      = 61
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Local de Pagamento (Label2 + Text1 x Text2) top=206+29=235 / 220+29=249
        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .AutoSize  = .F.
            .Caption   = "Local de Pagamento"
            .Top       = 235
            .Left      = 64
            .Width     = 98
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text1", "TextBox")
        WITH loc_oPg2.txt_4c_Text1
            .Value    = 0
            .Top      = 249
            .Left     = 64
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 250
            .Left      = 109
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text2", "TextBox")
        WITH loc_oPg2.txt_4c_Text2
            .Value    = 0
            .Top      = 249
            .Left     = 118
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Vencimento (Label4 + Text3 x Text4)
        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .AutoSize  = .F.
            .Caption   = "Vencimento"
            .Top       = 235
            .Left      = 179
            .Width     = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text3", "TextBox")
        WITH loc_oPg2.txt_4c_Text3
            .Value    = 0
            .Top      = 249
            .Left     = 179
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 250
            .Left      = 224
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text4", "TextBox")
        WITH loc_oPg2.txt_4c_Text4
            .Value    = 0
            .Top      = 249
            .Left     = 233
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Data Documento (Label6 + Text5 x Text6)
        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .AutoSize  = .F.
            .Caption   = "Data Documento"
            .Top       = 235
            .Left      = 294
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text5", "TextBox")
        WITH loc_oPg2.txt_4c_Text5
            .Value    = 0
            .Top      = 249
            .Left     = 294
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg2.lbl_4c_Label7
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 250
            .Left      = 339
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text6", "TextBox")
        WITH loc_oPg2.txt_4c_Text6
            .Value    = 0
            .Top      = 249
            .Left     = 348
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Nro do Documento (Label8 + Text7 x Text8)
        loc_oPg2.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPg2.lbl_4c_Label8
            .AutoSize  = .F.
            .Caption   = "N" + CHR(186) + " do Documento"
            .Top       = 235
            .Left      = 409
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text7", "TextBox")
        WITH loc_oPg2.txt_4c_Text7
            .Value    = 0
            .Top      = 249
            .Left     = 409
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPg2.lbl_4c_Label9
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 250
            .Left      = 454
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text8", "TextBox")
        WITH loc_oPg2.txt_4c_Text8
            .Value    = 0
            .Top      = 249
            .Left     = 463
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Valor do Documento (Label10 + Text9 x Text10)
        loc_oPg2.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPg2.lbl_4c_Label10
            .AutoSize  = .F.
            .Caption   = "Valor do Documento"
            .Top       = 235
            .Left      = 524
            .Width     = 98
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text9", "TextBox")
        WITH loc_oPg2.txt_4c_Text9
            .Value    = 0
            .Top      = 249
            .Left     = 524
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPg2.lbl_4c_Label11
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 250
            .Left      = 569
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text10", "TextBox")
        WITH loc_oPg2.txt_4c_Text10
            .Value    = 0
            .Top      = 249
            .Left     = 578
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Shape6: separador Cabecalho / Texto Responsabilidade (top=275+29=304)
        loc_oPg2.AddObject("shp_4c_Shape6", "Shape")
        WITH loc_oPg2.shp_4c_Shape6
            .Top       = 304
            .Left      = 54
            .Width     = 577
            .Height    = 2
            .BackColor = RGB(80, 80, 80)
            .FillStyle = 1
            .BackStyle = 1
            .Visible   = .T.
        ENDWITH

        *-- ==============================================================
        *-- SECAO: Texto de Responsabilidade do Cedente (top=258+29=287)
        *-- ==============================================================
        loc_oPg2.AddObject("lbl_4c_Label29", "Label")
        WITH loc_oPg2.lbl_4c_Label29
            .AutoSize  = .F.
            .Caption   = " Texto de Responsabilidade do Cedente "
            .Top       = 287
            .Left      = 61
            .Width     = 227
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Texto (Label12 + Text11 x Text12) top=280+29=309 / 295+29=324
        loc_oPg2.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPg2.lbl_4c_Label12
            .AutoSize  = .F.
            .Caption   = "Texto"
            .Top       = 309
            .Left      = 64
            .Width     = 30
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text11", "TextBox")
        WITH loc_oPg2.txt_4c_Text11
            .Value    = 0
            .Top      = 324
            .Left     = 64
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPg2.lbl_4c_Label13
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 325
            .Left      = 109
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text12", "TextBox")
        WITH loc_oPg2.txt_4c_Text12
            .Value    = 0
            .Top      = 324
            .Left     = 118
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Nro Colunas (Label31 + Text13)
        loc_oPg2.AddObject("lbl_4c_Label31", "Label")
        WITH loc_oPg2.lbl_4c_Label31
            .AutoSize  = .F.
            .Caption   = "N" + CHR(186) + " Colunas"
            .Top       = 309
            .Left      = 180
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text13", "TextBox")
        WITH loc_oPg2.txt_4c_Text13
            .Value    = 0
            .Top      = 324
            .Left     = 179
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Nro Linhas (Label30 + Text14)
        loc_oPg2.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oPg2.lbl_4c_Label30
            .AutoSize  = .F.
            .Caption   = "N" + CHR(186) + " Linhas"
            .Top       = 309
            .Left      = 246
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Text14", "TextBox")
        WITH loc_oPg2.txt_4c_Text14
            .Value    = 0
            .Top      = 324
            .Left     = 246
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Shape3: separador Texto / Sacado (top=349+29=378)
        loc_oPg2.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPg2.shp_4c_Shape3
            .Top       = 378
            .Left      = 54
            .Width     = 577
            .Height    = 2
            .BackColor = RGB(80, 80, 80)
            .FillStyle = 1
            .BackStyle = 1
            .Visible   = .T.
        ENDWITH

        *-- ==============================================================
        *-- SECAO: Sacado (top original=332+29=361)
        *-- Campos sao pares linha x coluna para posicionamento no boleto
        *-- ==============================================================
        loc_oPg2.AddObject("lbl_4c_Label32", "Label")
        WITH loc_oPg2.lbl_4c_Label32
            .AutoSize  = .F.
            .Caption   = " Sacado "
            .Top       = 361
            .Left      = 61
            .Width     = 49
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Razao Social (Label14 + Text15 x Text16) top=354+29=383 / 369+29=398
        loc_oPg2.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPg2.lbl_4c_Label14
            .AutoSize  = .F.
            .Caption   = "Raz" + CHR(227) + "o Social"
            .Top       = 383
            .Left      = 64
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text15", "TextBox")
        WITH loc_oPg2.txt_4c_Text15
            .Value    = 0
            .Top      = 398
            .Left     = 64
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH
        loc_oPg2.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPg2.lbl_4c_Label15
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 399
            .Left      = 109
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text16", "TextBox")
        WITH loc_oPg2.txt_4c_Text16
            .Value    = 0
            .Top      = 398
            .Left     = 118
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- C.G.C./C.P.F. (Label16 + Text17 x Text18)
        loc_oPg2.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPg2.lbl_4c_Label16
            .AutoSize  = .F.
            .Caption   = "C.G.C./C.P.F."
            .Top       = 383
            .Left      = 179
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text17", "TextBox")
        WITH loc_oPg2.txt_4c_Text17
            .Value    = 0
            .Top      = 398
            .Left     = 179
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH
        loc_oPg2.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPg2.lbl_4c_Label17
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 399
            .Left      = 224
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text18", "TextBox")
        WITH loc_oPg2.txt_4c_Text18
            .Value    = 0
            .Top      = 398
            .Left     = 233
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Endereco (Label18 + Text19 x Text20)
        loc_oPg2.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPg2.lbl_4c_Label18
            .AutoSize  = .F.
            .Caption   = "Endere" + CHR(231) + "o"
            .Top       = 383
            .Left      = 294
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text19", "TextBox")
        WITH loc_oPg2.txt_4c_Text19
            .Value    = 0
            .Top      = 398
            .Left     = 294
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH
        loc_oPg2.AddObject("lbl_4c_Label37", "Label")
        WITH loc_oPg2.lbl_4c_Label37
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 399
            .Left      = 339
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text20", "TextBox")
        WITH loc_oPg2.txt_4c_Text20
            .Value    = 0
            .Top      = 398
            .Left     = 348
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Bairro (Label20 + Text21 x Text22)
        loc_oPg2.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPg2.lbl_4c_Label20
            .AutoSize  = .F.
            .Caption   = "Bairro"
            .Top       = 383
            .Left      = 409
            .Width     = 30
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text21", "TextBox")
        WITH loc_oPg2.txt_4c_Text21
            .Value    = 0
            .Top      = 398
            .Left     = 409
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH
        loc_oPg2.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPg2.lbl_4c_Label21
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 399
            .Left      = 454
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text22", "TextBox")
        WITH loc_oPg2.txt_4c_Text22
            .Value    = 0
            .Top      = 398
            .Left     = 463
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Cidade (Label22 + Text23 x Text24)
        loc_oPg2.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oPg2.lbl_4c_Label22
            .AutoSize  = .F.
            .Caption   = "Cidade"
            .Top       = 383
            .Left      = 524
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text23", "TextBox")
        WITH loc_oPg2.txt_4c_Text23
            .Value    = 0
            .Top      = 397
            .Left     = 524
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH
        loc_oPg2.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oPg2.lbl_4c_Label23
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 398
            .Left      = 569
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text24", "TextBox")
        WITH loc_oPg2.txt_4c_Text24
            .Value    = 0
            .Top      = 397
            .Left     = 578
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- U.F. (Label24 + Text25 x Text26) top=389+29=418 / 403+29=432
        loc_oPg2.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPg2.lbl_4c_Label24
            .AutoSize  = .F.
            .Caption   = "U.F."
            .Top       = 418
            .Left      = 65
            .Width     = 23
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text25", "TextBox")
        WITH loc_oPg2.txt_4c_Text25
            .Value    = 0
            .Top      = 432
            .Left     = 65
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH
        loc_oPg2.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPg2.lbl_4c_Label25
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 433
            .Left      = 109
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text26", "TextBox")
        WITH loc_oPg2.txt_4c_Text26
            .Value    = 0
            .Top      = 432
            .Left     = 118
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- C.E.P. (Label26 + Text27 x Text28)
        loc_oPg2.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oPg2.lbl_4c_Label26
            .AutoSize  = .F.
            .Caption   = "C.E.P."
            .Top       = 418
            .Left      = 179
            .Width     = 33
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text27", "TextBox")
        WITH loc_oPg2.txt_4c_Text27
            .Value    = 0
            .Top      = 432
            .Left     = 179
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH
        loc_oPg2.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oPg2.lbl_4c_Label27
            .AutoSize  = .F.
            .Caption   = "x"
            .Top       = 433
            .Left      = 224
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text28", "TextBox")
        WITH loc_oPg2.txt_4c_Text28
            .Value    = 0
            .Top      = 432
            .Left     = 233
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Shape4: separador Sacado / Impressora (top=456+29=485)
        loc_oPg2.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPg2.shp_4c_Shape4
            .Top       = 485
            .Left      = 54
            .Width     = 577
            .Height    = 2
            .BackColor = RGB(80, 80, 80)
            .FillStyle = 1
            .BackStyle = 1
            .Visible   = .T.
        ENDWITH

        *-- ==============================================================
        *-- SECAO: Impressora / Fonte (top original=439+29=468)
        *-- ==============================================================
        loc_oPg2.AddObject("lbl_4c_Label36", "Label")
        WITH loc_oPg2.lbl_4c_Label36
            .AutoSize  = .F.
            .Caption   = " Impressora / Fonte "
            .Top       = 468
            .Left      = 61
            .Width     = 118
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Nome da Impressora (Label33 + Text29) top=461+29=490 / 474+29=503
        loc_oPg2.AddObject("lbl_4c_Label33", "Label")
        WITH loc_oPg2.lbl_4c_Label33
            .AutoSize  = .F.
            .Caption   = "Nome da Impressora"
            .Top       = 490
            .Left      = 64
            .Width     = 101
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text29", "TextBox")
        WITH loc_oPg2.txt_4c_Text29
            .Value    = ""
            .Top      = 503
            .Left     = 64
            .Width    = 240
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Fonte Padrao (Label34 + Text30) top=494+29=523 / 508+29=537
        loc_oPg2.AddObject("lbl_4c_Label34", "Label")
        WITH loc_oPg2.lbl_4c_Label34
            .AutoSize  = .F.
            .Caption   = "Fonte Padr" + CHR(227) + "o"
            .Top       = 523
            .Left      = 64
            .Width     = 67
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text30", "TextBox")
        WITH loc_oPg2.txt_4c_Text30
            .Value    = ""
            .Top      = 537
            .Left     = 64
            .Width    = 192
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Tamanho Fonte (Label35 + Text31)
        loc_oPg2.AddObject("lbl_4c_Label35", "Label")
        WITH loc_oPg2.lbl_4c_Label35
            .AutoSize  = .F.
            .Caption   = "Tamanho"
            .Top       = 523
            .Left      = 263
            .Width     = 46
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text31", "TextBox")
        WITH loc_oPg2.txt_4c_Text31
            .Value    = 0
            .Top      = 537
            .Left     = 263
            .Width    = 41
            .Height   = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Tamanho Folha (Label38 + Text40) top=460+29=489 / 473+29=502
        loc_oPg2.AddObject("lbl_4c_Label38", "Label")
        WITH loc_oPg2.lbl_4c_Label38
            .AutoSize  = .F.
            .Caption   = "Tamanho Folha"
            .Top       = 489
            .Left      = 337
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg2.AddObject("txt_4c_Text40", "TextBox")
        WITH loc_oPg2.txt_4c_Text40
            .Value    = ""
            .Top      = 502
            .Left     = 336
            .Width    = 244
            .Height   = 19
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- BINDEVENT: validacao de impressora, fonte e tamanho de folha ao sair do campo
        BINDEVENT(loc_oPg2.txt_4c_Text29, "KeyPress", THIS, "Text29LostFocus")
        BINDEVENT(loc_oPg2.txt_4c_Text30, "KeyPress", THIS, "Text30LostFocus")
        BINDEVENT(loc_oPg2.txt_4c_Text40, "KeyPress", THIS, "Text40LostFocus")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos do Form para o BO
    * Fase 5: Secoes Condicao de Pagamento + Cabecalho + Texto Responsabilidade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Condicao de Pagamento (FPags read-only, mas propaga para garantir consistencia)
            IF PEMSTATUS(loc_oPg2, "txt_4c_FPags", 5)
                THIS.this_oBusinessObject.this_cFPags = ALLTRIM(loc_oPg2.txt_4c_FPags.Value)
            ENDIF

            *-- Secao Cabecalho: Local de Pagamento (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
                THIS.this_oBusinessObject.this_nNlnLocals = loc_oPg2.txt_4c_Text1.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
                THIS.this_oBusinessObject.this_nNclLocals = loc_oPg2.txt_4c_Text2.Value
            ENDIF
            *-- Vencimento (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text3", 5)
                THIS.this_oBusinessObject.this_nNlnDtVencs = loc_oPg2.txt_4c_Text3.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text4", 5)
                THIS.this_oBusinessObject.this_nNclDtVencs = loc_oPg2.txt_4c_Text4.Value
            ENDIF
            *-- Data Documento (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
                THIS.this_oBusinessObject.this_nNlnDtDocs = loc_oPg2.txt_4c_Text5.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
                THIS.this_oBusinessObject.this_nNclDtDocs = loc_oPg2.txt_4c_Text6.Value
            ENDIF
            *-- Nro Documento (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
                THIS.this_oBusinessObject.this_nNlnNrDocs = loc_oPg2.txt_4c_Text7.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
                THIS.this_oBusinessObject.this_nNclNrDocs = loc_oPg2.txt_4c_Text8.Value
            ENDIF
            *-- Valor Documento (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
                THIS.this_oBusinessObject.this_nNlnVlDocs = loc_oPg2.txt_4c_Text9.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
                THIS.this_oBusinessObject.this_nNclVlDocs = loc_oPg2.txt_4c_Text10.Value
            ENDIF

            *-- Secao Texto Responsabilidade do Cedente (linha x coluna + qtd linhas/colunas)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text11", 5)
                THIS.this_oBusinessObject.this_nNlnTxtCds = loc_oPg2.txt_4c_Text11.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text12", 5)
                THIS.this_oBusinessObject.this_nNclTxtCds = loc_oPg2.txt_4c_Text12.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text13", 5)
                THIS.this_oBusinessObject.this_nNTxtCols = loc_oPg2.txt_4c_Text13.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text14", 5)
                THIS.this_oBusinessObject.this_nNTxtLins = loc_oPg2.txt_4c_Text14.Value
            ENDIF

            *-- Secao Sacado: Razao Social (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text15", 5)
                THIS.this_oBusinessObject.this_nNlnRazClis = loc_oPg2.txt_4c_Text15.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text16", 5)
                THIS.this_oBusinessObject.this_nNclRazClis = loc_oPg2.txt_4c_Text16.Value
            ENDIF
            *-- C.G.C./C.P.F. (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text17", 5)
                THIS.this_oBusinessObject.this_nNlnCgcClis = loc_oPg2.txt_4c_Text17.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text18", 5)
                THIS.this_oBusinessObject.this_nNclCgcClis = loc_oPg2.txt_4c_Text18.Value
            ENDIF
            *-- Endereco (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
                THIS.this_oBusinessObject.this_nNlnEndCobs = loc_oPg2.txt_4c_Text19.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
                THIS.this_oBusinessObject.this_nNclEndCobs = loc_oPg2.txt_4c_Text20.Value
            ENDIF
            *-- Bairro (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
                THIS.this_oBusinessObject.this_nNlnBaiCobs = loc_oPg2.txt_4c_Text21.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
                THIS.this_oBusinessObject.this_nNclBaiCobs = loc_oPg2.txt_4c_Text22.Value
            ENDIF
            *-- Cidade (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text23", 5)
                THIS.this_oBusinessObject.this_nNlnCidCobs = loc_oPg2.txt_4c_Text23.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text24", 5)
                THIS.this_oBusinessObject.this_nNclCidCobs = loc_oPg2.txt_4c_Text24.Value
            ENDIF
            *-- U.F. (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text25", 5)
                THIS.this_oBusinessObject.this_nNlnEstCobs = loc_oPg2.txt_4c_Text25.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text26", 5)
                THIS.this_oBusinessObject.this_nNclEstCobs = loc_oPg2.txt_4c_Text26.Value
            ENDIF
            *-- C.E.P. (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
                THIS.this_oBusinessObject.this_nNlnCepCobs = loc_oPg2.txt_4c_Text27.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
                THIS.this_oBusinessObject.this_nNclCepCobs = loc_oPg2.txt_4c_Text28.Value
            ENDIF

            *-- Secao Impressora / Fonte
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
                THIS.this_oBusinessObject.this_cCNomeImps = ALLTRIM(loc_oPg2.txt_4c_Text29.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
                THIS.this_oBusinessObject.this_cCFontePdrs = ALLTRIM(loc_oPg2.txt_4c_Text30.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
                THIS.this_oBusinessObject.this_nNTamFontes = loc_oPg2.txt_4c_Text31.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
                THIS.this_oBusinessObject.this_cCTamFolha = ALLTRIM(loc_oPg2.txt_4c_Text40.Value)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos do Form
    * Fase 5: Secoes Condicao de Pagamento + Cabecalho + Texto Responsabilidade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Condicao de Pagamento (codigo e descricao - sempre read-only)
            IF PEMSTATUS(loc_oPg2, "txt_4c_FPags", 5)
                loc_oPg2.txt_4c_FPags.Value = ALLTRIM(THIS.this_oBusinessObject.this_cFPags)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DPags", 5)
                loc_oPg2.txt_4c_DPags.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
            ENDIF

            *-- Secao Cabecalho: Local de Pagamento
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
                loc_oPg2.txt_4c_Text1.Value = THIS.this_oBusinessObject.this_nNlnLocals
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
                loc_oPg2.txt_4c_Text2.Value = THIS.this_oBusinessObject.this_nNclLocals
            ENDIF
            *-- Vencimento
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text3", 5)
                loc_oPg2.txt_4c_Text3.Value = THIS.this_oBusinessObject.this_nNlnDtVencs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text4", 5)
                loc_oPg2.txt_4c_Text4.Value = THIS.this_oBusinessObject.this_nNclDtVencs
            ENDIF
            *-- Data Documento
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
                loc_oPg2.txt_4c_Text5.Value = THIS.this_oBusinessObject.this_nNlnDtDocs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
                loc_oPg2.txt_4c_Text6.Value = THIS.this_oBusinessObject.this_nNclDtDocs
            ENDIF
            *-- Nro Documento
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
                loc_oPg2.txt_4c_Text7.Value = THIS.this_oBusinessObject.this_nNlnNrDocs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
                loc_oPg2.txt_4c_Text8.Value = THIS.this_oBusinessObject.this_nNclNrDocs
            ENDIF
            *-- Valor Documento
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
                loc_oPg2.txt_4c_Text9.Value = THIS.this_oBusinessObject.this_nNlnVlDocs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
                loc_oPg2.txt_4c_Text10.Value = THIS.this_oBusinessObject.this_nNclVlDocs
            ENDIF

            *-- Secao Texto Responsabilidade do Cedente
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text11", 5)
                loc_oPg2.txt_4c_Text11.Value = THIS.this_oBusinessObject.this_nNlnTxtCds
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text12", 5)
                loc_oPg2.txt_4c_Text12.Value = THIS.this_oBusinessObject.this_nNclTxtCds
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text13", 5)
                loc_oPg2.txt_4c_Text13.Value = THIS.this_oBusinessObject.this_nNTxtCols
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text14", 5)
                loc_oPg2.txt_4c_Text14.Value = THIS.this_oBusinessObject.this_nNTxtLins
            ENDIF

            *-- Secao Sacado: Razao Social (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text15", 5)
                loc_oPg2.txt_4c_Text15.Value = THIS.this_oBusinessObject.this_nNlnRazClis
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text16", 5)
                loc_oPg2.txt_4c_Text16.Value = THIS.this_oBusinessObject.this_nNclRazClis
            ENDIF
            *-- C.G.C./C.P.F. (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text17", 5)
                loc_oPg2.txt_4c_Text17.Value = THIS.this_oBusinessObject.this_nNlnCgcClis
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text18", 5)
                loc_oPg2.txt_4c_Text18.Value = THIS.this_oBusinessObject.this_nNclCgcClis
            ENDIF
            *-- Endereco (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
                loc_oPg2.txt_4c_Text19.Value = THIS.this_oBusinessObject.this_nNlnEndCobs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
                loc_oPg2.txt_4c_Text20.Value = THIS.this_oBusinessObject.this_nNclEndCobs
            ENDIF
            *-- Bairro (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
                loc_oPg2.txt_4c_Text21.Value = THIS.this_oBusinessObject.this_nNlnBaiCobs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
                loc_oPg2.txt_4c_Text22.Value = THIS.this_oBusinessObject.this_nNclBaiCobs
            ENDIF
            *-- Cidade (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text23", 5)
                loc_oPg2.txt_4c_Text23.Value = THIS.this_oBusinessObject.this_nNlnCidCobs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text24", 5)
                loc_oPg2.txt_4c_Text24.Value = THIS.this_oBusinessObject.this_nNclCidCobs
            ENDIF
            *-- U.F. (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text25", 5)
                loc_oPg2.txt_4c_Text25.Value = THIS.this_oBusinessObject.this_nNlnEstCobs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text26", 5)
                loc_oPg2.txt_4c_Text26.Value = THIS.this_oBusinessObject.this_nNclEstCobs
            ENDIF
            *-- C.E.P. (linha x coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
                loc_oPg2.txt_4c_Text27.Value = THIS.this_oBusinessObject.this_nNlnCepCobs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
                loc_oPg2.txt_4c_Text28.Value = THIS.this_oBusinessObject.this_nNclCepCobs
            ENDIF

            *-- Secao Impressora / Fonte
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
                loc_oPg2.txt_4c_Text29.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCNomeImps)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
                loc_oPg2.txt_4c_Text30.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCFontePdrs)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
                loc_oPg2.txt_4c_Text31.Value = THIS.this_oBusinessObject.this_nNTamFontes
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
                loc_oPg2.txt_4c_Text40.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCTamFolha)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    * Fase 5: Cabecalho (Text1-Text10) + Texto Responsabilidade (Text11-Text14)
    * Fase 6 completara com Sacado e Impressora/Fonte
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
            ENDIF
            *-- txt_4c_FPags e txt_4c_DPags sao SEMPRE read-only (FK de SigOpFp)

            *-- Secao Cabecalho - Local de Pagamento
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
                loc_oPg2.txt_4c_Text1.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
                loc_oPg2.txt_4c_Text2.Enabled = par_lHabilitar
            ENDIF
            *-- Vencimento
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text3", 5)
                loc_oPg2.txt_4c_Text3.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text4", 5)
                loc_oPg2.txt_4c_Text4.Enabled = par_lHabilitar
            ENDIF
            *-- Data Documento
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
                loc_oPg2.txt_4c_Text5.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
                loc_oPg2.txt_4c_Text6.Enabled = par_lHabilitar
            ENDIF
            *-- Nro Documento
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
                loc_oPg2.txt_4c_Text7.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
                loc_oPg2.txt_4c_Text8.Enabled = par_lHabilitar
            ENDIF
            *-- Valor Documento
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
                loc_oPg2.txt_4c_Text9.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
                loc_oPg2.txt_4c_Text10.Enabled = par_lHabilitar
            ENDIF
            *-- Secao Texto Responsabilidade
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text11", 5)
                loc_oPg2.txt_4c_Text11.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text12", 5)
                loc_oPg2.txt_4c_Text12.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text13", 5)
                loc_oPg2.txt_4c_Text13.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text14", 5)
                loc_oPg2.txt_4c_Text14.Enabled = par_lHabilitar
            ENDIF
            *-- Secao Sacado
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text15", 5)
                loc_oPg2.txt_4c_Text15.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text16", 5)
                loc_oPg2.txt_4c_Text16.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text17", 5)
                loc_oPg2.txt_4c_Text17.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text18", 5)
                loc_oPg2.txt_4c_Text18.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
                loc_oPg2.txt_4c_Text19.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
                loc_oPg2.txt_4c_Text20.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
                loc_oPg2.txt_4c_Text21.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
                loc_oPg2.txt_4c_Text22.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text23", 5)
                loc_oPg2.txt_4c_Text23.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text24", 5)
                loc_oPg2.txt_4c_Text24.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text25", 5)
                loc_oPg2.txt_4c_Text25.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text26", 5)
                loc_oPg2.txt_4c_Text26.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
                loc_oPg2.txt_4c_Text27.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
                loc_oPg2.txt_4c_Text28.Enabled = par_lHabilitar
            ENDIF
            *-- Secao Impressora / Fonte
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
                loc_oPg2.txt_4c_Text29.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
                loc_oPg2.txt_4c_Text30.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
                loc_oPg2.txt_4c_Text31.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
                loc_oPg2.txt_4c_Text40.Enabled = par_lHabilitar
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    * Fase 5: Secoes Condicao + Cabecalho + Texto Responsabilidade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_FPags", 5)
                loc_oPg2.txt_4c_FPags.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DPags", 5)
                loc_oPg2.txt_4c_DPags.Value = ""
            ENDIF
            *-- Secao Cabecalho
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
                loc_oPg2.txt_4c_Text1.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
                loc_oPg2.txt_4c_Text2.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text3", 5)
                loc_oPg2.txt_4c_Text3.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text4", 5)
                loc_oPg2.txt_4c_Text4.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
                loc_oPg2.txt_4c_Text5.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
                loc_oPg2.txt_4c_Text6.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
                loc_oPg2.txt_4c_Text7.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
                loc_oPg2.txt_4c_Text8.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
                loc_oPg2.txt_4c_Text9.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
                loc_oPg2.txt_4c_Text10.Value = 0
            ENDIF
            *-- Secao Texto Responsabilidade
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text11", 5)
                loc_oPg2.txt_4c_Text11.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text12", 5)
                loc_oPg2.txt_4c_Text12.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text13", 5)
                loc_oPg2.txt_4c_Text13.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text14", 5)
                loc_oPg2.txt_4c_Text14.Value = 0
            ENDIF
            *-- Secao Sacado (campos numericos linha/coluna)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text15", 5)
                loc_oPg2.txt_4c_Text15.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text16", 5)
                loc_oPg2.txt_4c_Text16.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text17", 5)
                loc_oPg2.txt_4c_Text17.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text18", 5)
                loc_oPg2.txt_4c_Text18.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
                loc_oPg2.txt_4c_Text19.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
                loc_oPg2.txt_4c_Text20.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
                loc_oPg2.txt_4c_Text21.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
                loc_oPg2.txt_4c_Text22.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text23", 5)
                loc_oPg2.txt_4c_Text23.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text24", 5)
                loc_oPg2.txt_4c_Text24.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text25", 5)
                loc_oPg2.txt_4c_Text25.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text26", 5)
                loc_oPg2.txt_4c_Text26.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
                loc_oPg2.txt_4c_Text27.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
                loc_oPg2.txt_4c_Text28.Value = 0
            ENDIF
            *-- Secao Impressora / Fonte
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
                loc_oPg2.txt_4c_Text29.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
                loc_oPg2.txt_4c_Text30.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
                loc_oPg2.txt_4c_Text31.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
                loc_oPg2.txt_4c_Text40.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Text29LostFocus - Valida impressora ao sair do campo
    * Equivalente ao Valid do SCX legado (SIGCDCFB.pagina.dados.Text29)
    *--------------------------------------------------------------------------
    PROCEDURE Text29LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2, loc_cNome, loc_nQtd, loc_aPrinters, loc_nI, loc_lEncontrado
        LOCAL loc_cImpressora
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
                RETURN
            ENDIF

            loc_cNome = ALLTRIM(loc_oPg2.txt_4c_Text29.Value)

            IF EMPTY(loc_cNome)
                RETURN
            ENDIF

            *-- Verificar se impressora informada existe na lista do sistema
            loc_nQtd      = APRINTERS(loc_aPrinters)
            loc_lEncontrado = .F.

            IF loc_nQtd > 0
                FOR loc_nI = 1 TO loc_nQtd
                    IF UPPER(ALLTRIM(loc_aPrinters[loc_nI, 1])) == UPPER(loc_cNome)
                        loc_lEncontrado = .T.
                        EXIT
                    ENDIF
                ENDFOR
            ENDIF

            IF !loc_lEncontrado
                *-- Impressora invalida: abrir seletor de impressoras
                loc_cImpressora = GetPrinter()
                IF !EMPTY(loc_cImpressora)
                    loc_oPg2.txt_4c_Text29.Value = loc_cImpressora
                    THIS.this_oBusinessObject.this_cCNomeImps = loc_cImpressora
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.Text29LostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Text30LostFocus - Valida fonte ao sair do campo; atualiza tamanho (Text31)
    * Equivalente ao Valid do SCX legado (SIGCDCFB.pagina.dados.Text30)
    *--------------------------------------------------------------------------
    PROCEDURE Text30LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2, loc_cFonte, loc_nI, loc_nQtd, loc_aFontes, loc_lEncontrado
        LOCAL loc_cResultado, loc_nPos1, loc_nPos2, loc_nTam
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
                RETURN
            ENDIF

            loc_cFonte = ALLTRIM(loc_oPg2.txt_4c_Text30.Value)

            IF EMPTY(loc_cFonte)
                RETURN
            ENDIF

            *-- Verificar se fonte informada existe na lista do sistema
            loc_nQtd      = AFONT(loc_aFontes)
            loc_lEncontrado = .F.

            IF loc_nQtd > 0
                FOR loc_nI = 1 TO loc_nQtd
                    IF UPPER(ALLTRIM(loc_aFontes[loc_nI])) == UPPER(loc_cFonte)
                        loc_lEncontrado = .T.
                        EXIT
                    ENDIF
                ENDFOR
            ENDIF

            IF !loc_lEncontrado
                *-- Fonte invalida: abrir seletor de fontes
                loc_cResultado = GetFont()
                IF !EMPTY(loc_cResultado)
                    *-- GetFont() retorna "FontName,Size,Style"
                    loc_nPos1 = AT(",", loc_cResultado, 1)
                    loc_nPos2 = AT(",", loc_cResultado, 2)
                    IF loc_nPos1 > 0
                        loc_cFonte = LEFT(loc_cResultado, loc_nPos1 - 1)
                        loc_oPg2.txt_4c_Text30.Value = loc_cFonte
                        THIS.this_oBusinessObject.this_cCFontePdrs = loc_cFonte
                        *-- Atualizar tamanho da fonte em Text31
                        IF loc_nPos2 > loc_nPos1 AND PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
                            loc_nTam = VAL(SUBSTR(loc_cResultado, loc_nPos1 + 1, ;
                                loc_nPos2 - loc_nPos1 - 1))
                            loc_oPg2.txt_4c_Text31.Value = loc_nTam
                            THIS.this_oBusinessObject.this_nNTamFontes = loc_nTam
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.Text30LostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Text40LostFocus - Abre seletor de tamanho de papel se campo vazio
    * Equivalente ao Valid do SCX legado (SIGCDCFB.pagina.dados.Text40)
    *--------------------------------------------------------------------------
    PROCEDURE Text40LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2, loc_cTam, loc_cDescricao, loc_lContinuar
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_lContinuar = .T.
        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar

            loc_cTam = ALLTRIM(loc_oPg2.txt_4c_Text40.Value)

            IF EMPTY(loc_cTam)
                *-- Campo vazio: abrir seletor de tamanho de papel
                loc_cTam = GetPaperSize()
                IF !EMPTY(loc_cTam)
                    *-- GetPaperSize() retorna codigo (10 chars) + descricao
                    loc_cDescricao = SUBSTR(loc_cTam, 11)
                    loc_oPg2.txt_4c_Text40.Value = loc_cDescricao
                    THIS.this_oBusinessObject.this_cCTamFolha = loc_cDescricao
                ENDIF
            ELSE
                THIS.this_oBusinessObject.this_cCTamFolha = loc_cTam
            ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.Text40LostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega grid de condicoes de pagamento com indicador
    * de configuracao (LEFT JOIN SigOpFp + SIGCNFBL via Buscar)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                CREATE CURSOR cursor_4c_Dados (FPags C(12), Descrs C(60), TemDados C(12))
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"

                    loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Configurado"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ENDIF

            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - INSERT proibido neste cadastro (regra de negocio legada)
    * Navega para Page2 em modo bloqueado; save e impedido em BtnSalvarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Inserir Dados Atrav" + ;
                CHR(233) + "s Deste Cadastro!!!" + CHR(13) + ;
                "Use a Op" + CHR(231) + CHR(227) + "o Alterar ou o Cadastro de Condi" + ;
                CHR(231) + CHR(245) + "es de Pagamento.", ;
                "Opera" + CHR(231) + CHR(227) + "o Bloqueada")
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega configuracao do boleto para edicao
    * Se nao existir registro em SIGCNFBL, prepara para INSERT
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cFPags, loc_cDescrs, loc_lTemDados

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione uma condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
                RETURN
            ENDIF

            SELECT cursor_4c_Dados
            loc_cFPags   = ALLTRIM(cursor_4c_Dados.FPags)
            loc_cDescrs  = ALLTRIM(cursor_4c_Dados.Descrs)
            loc_lTemDados = !EMPTY(ALLTRIM(NVL(cursor_4c_Dados.TemDados, "")))

            IF loc_lTemDados
                *-- Registro existe -> Atualizar
                IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)
                    MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
                    RETURN
                ENDIF
                THIS.this_oBusinessObject.EditarRegistro()
            ELSE
                *-- Registro nao existe -> Inserir (neste caso o legado permitia via Alterar)
                THIS.this_oBusinessObject.NovoRegistro()
                THIS.this_oBusinessObject.this_cFPags   = loc_cFPags
                THIS.this_oBusinessObject.this_cDescrs  = loc_cDescrs
            ENDIF

            THIS.this_oBusinessObject.this_cDescrs = loc_cDescrs
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega configuracao em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cFPags, loc_cDescrs, loc_lTemDados

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione uma condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
                RETURN
            ENDIF

            SELECT cursor_4c_Dados
            loc_cFPags   = ALLTRIM(cursor_4c_Dados.FPags)
            loc_cDescrs  = ALLTRIM(cursor_4c_Dados.Descrs)
            loc_lTemDados = !EMPTY(ALLTRIM(NVL(cursor_4c_Dados.TemDados, "")))

            IF !loc_lTemDados
                MsgAviso("Esta condi" + CHR(231) + CHR(227) + "o de pagamento ainda n" + ;
                    CHR(227) + "o foi configurada.", "")
                RETURN
            ENDIF

            IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)
                MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
                RETURN
            ENDIF

            THIS.this_oBusinessObject.this_cDescrs = loc_cDescrs
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Remove configuracao de boleto da condicao selecionada
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cFPags, loc_lTemDados, loc_lConfirma

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione uma condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
                RETURN
            ENDIF

            SELECT cursor_4c_Dados
            loc_cFPags   = ALLTRIM(cursor_4c_Dados.FPags)
            loc_lTemDados = !EMPTY(ALLTRIM(NVL(cursor_4c_Dados.TemDados, "")))

            IF !loc_lTemDados
                MsgAviso("Esta condi" + CHR(231) + CHR(227) + "o de pagamento n" + CHR(227) + ;
                    "o possui configura" + CHR(231) + CHR(227) + "o de boleto.", "")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da configura" + ;
                CHR(231) + CHR(227) + "o de boleto para a condi" + CHR(231) + CHR(227) + ;
                "o [" + loc_cFPags + "]?", "Confirmar Exclus" + CHR(227) + "o")

            IF !loc_lConfirma
                RETURN
            ENDIF

            THIS.this_oBusinessObject.this_cFPags = loc_cFPags
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Configura" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + ;
                    "da com sucesso!")
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra a lista de condicoes de pagamento
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_oGrid, loc_lContinuar

        loc_lContinuar = .T.
        TRY
            loc_oGrid  = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
            loc_cFiltro = ""

            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cFiltro = ALLTRIM(cursor_4c_Dados.FPags)
            ENDIF

            IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar

            loc_oGrid.ColumnCount = 3
            loc_oGrid.RecordSource = "cursor_4c_Dados"
            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
            loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"

            loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
            loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oGrid.Column3.Header1.Caption = "Configurado"

            THIS.FormatarGridLista(loc_oGrid)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva configuracao de boleto (somente UPDATE; INSERT bloqueado)
    * Equivalente ao botao Confirmar na Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF THIS.this_cModoAtual = "INCLUIR"
            MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + ;
                "vel Inserir Dados Atrav" + CHR(233) + "s Deste Cadastro!!!" + CHR(13) + ;
                "Use a Op" + CHR(231) + CHR(227) + "o Alterar ou o Cadastro de Condi" + ;
                CHR(231) + CHR(245) + "es de Pagamento.", ;
                "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
            RETURN loc_lResultado
        ENDIF

        THIS.FormParaBO()

        TRY
            loc_lResultado = THIS.this_oBusinessObject.Salvar()
            IF loc_lResultado
                MsgInfo("Configura" + CHR(231) + CHR(227) + "o salva com sucesso!")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lAlterar

        TRY
            loc_oPg2    = THIS.pgf_4c_Paginas.Page2
            loc_lAlterar = (THIS.this_cModoAtual = "ALTERAR")

            IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lAlterar
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCfb.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
