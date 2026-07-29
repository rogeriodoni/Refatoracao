*==============================================================================
* FormCHM.prg - Formulario de Cadastro de Configuracao do Cheque - Matricial
* Data: 2026-07-28 | Fase 7/8: Form - Eventos Principais (COMPLETO)
* Tabela: SigCqMat | PK: banco (C3)
* Legado: SIGCDCHM.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormCHM AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Cadastro de Configuracao do Cheque - Matricial"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades de instancia
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CHMBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar Business Object CHMBO", ;
                            "Erro Cr" + CHR(237) + "tico")
                loc_lSucesso = .F.
            ELSE
                THIS.Caption = "Cadastro de Configura" + CHR(231) + CHR(227) + ;
                               "o do Cheque - Matricial"

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
                    THIS.Caption

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormCHM:" + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                        loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal
    * Legado: Pagina.Top=-29 (oculta abas), Width=1003, Height=629
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e Botoes CRUD
    * Compensacao PageFrame.Top=-29: Top_original + 29
    * Grade legado: top=119+29=148, left=32, width=940, height=470
    * cnt_4c_Botoes canonico: Left=542, Top=29
    * cnt_4c_Saida canonico: Left=917 (Rule #10)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (cntSombra: Top=2+29=31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 16
            .Left      = 11
            .Width     = THIS.Width
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (canonico Left=542, Top=29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Container de saida/encerrar (canonico Left=917, Width=90, Rule #10)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Encerrar (canonico Width=75, Height=75, Caption="Encerrar")
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid da lista (Grade: top=119+29=148, left=32, width=940, height=470)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista

        loc_oGrid.Top                = 148
        loc_oGrid.Left               = 32
        loc_oGrid.Width              = 940
        loc_oGrid.Height             = 470
        loc_oGrid.FontName           = "Verdana"
        loc_oGrid.FontSize           = 8
        loc_oGrid.ForeColor          = RGB(90, 90, 90)
        loc_oGrid.BackColor          = RGB(255, 255, 255)
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        loc_oGrid.DeleteMark         = .F.
        loc_oGrid.RecordMark         = .F.
        loc_oGrid.RowHeight          = 16
        loc_oGrid.ScrollBars         = 2
        loc_oGrid.GridLines          = 3
        loc_oGrid.ReadOnly           = .T.
        loc_oGrid.Visible            = .T.

        *-- BINDEVENTs para botoes CRUD (metodos PUBLIC - BINDEVENT exige PUBLIC)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Compensacao PageFrame.Top=-29: Top_original + 29
    * Legado: Grupo_Salva.Left=627, Top=6+29=35, Width=172, Height=85
    * Fase 5/8: Botoes Confirmar/Cancelar + 1a metade dos campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Salvar/Cancelar (Grupo_Salva.Left=627, Top=6+29=35)
        loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oPagina.cnt_4c_BotoesDados
            .Top         = 35
            .Left        = 627
            .Width       = 172
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva.Left=11, Top=5)
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 11
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar (Cancelar.Left=88, Top=5)
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 88
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *  BANCO (Get_Banco: top=66+29=95, left=251, width=45)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Banco :"
            .Top       = 99
            .Left      = 204
            .Width     = 42
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Banco", "TextBox")
        WITH loc_oPagina.txt_4c_Banco
            .Value        = ""
            .Top          = 95
            .Left         = 251
            .Width        = 45
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .MaxLength    = 10
            .BackColor    = RGB(255, 255, 255)
            .ForeColor    = RGB(90, 90, 90)
            .Visible      = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *  CABECALHOS DAS COLUNAS (Label3 Linha / Label4 Coluna)
        *  top=116+29=145 / top=115+29=144
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Linha"
            .Top       = 145
            .Left      = 254
            .Width     = 32
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Coluna"
            .Top       = 144
            .Left      = 336
            .Width     = 40
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *  VALOR (Label1: top=137+29=166; fwget1/2: top=133+29=162)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Valor :"
            .Top       = 166
            .Left      = 213
            .Width     = 33
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget1
            .Value     = 0
            .Top       = 162
            .Left      = 250
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget2", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget2
            .Value     = 0
            .Top       = 162
            .Left      = 335
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *  VALOR EXTENSO 1 (Label5: top=163+29=192; fwget3/4: top=159+29=188)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Valor Extenso 1 :"
            .Top       = 192
            .Left      = 162
            .Width     = 84
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget3", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget3
            .Value     = 0
            .Top       = 188
            .Left      = 250
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget4", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget4
            .Value     = 0
            .Top       = 188
            .Left      = 335
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *  VALOR EXTENSO 2 (Label6: top=189+29=218; fwget5/6: top=185+29=214)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Valor Extenso 2 :"
            .Top       = 218
            .Left      = 162
            .Width     = 84
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget5", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget5
            .Value     = 0
            .Top       = 214
            .Left      = 250
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget6", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget6
            .Value     = 0
            .Top       = 214
            .Left      = 335
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *  FAVORECIDO (Label7: top=215+29=244; fwget7/8: top=211+29=240)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Favorecido :"
            .Top       = 244
            .Left      = 184
            .Width     = 62
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget7", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget7
            .Value     = 0
            .Top       = 240
            .Left      = 250
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget8", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget8
            .Value     = 0
            .Top       = 240
            .Left      = 335
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *  LOCALIDADE (Label8: top=241+29=270; fwget9/10: top=236+29=265)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Localidade :"
            .Top       = 270
            .Left      = 187
            .Width     = 59
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget9", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget9
            .Value     = 0
            .Top       = 265
            .Left      = 250
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget10", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget10
            .Value     = 0
            .Top       = 265
            .Left      = 335
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *  DIA (Label9: top=266+29=295; fwget11/12: top=261+29=290)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Dia :"
            .Top       = 295
            .Left      = 222
            .Width     = 24
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget11", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget11
            .Value     = 0
            .Top       = 290
            .Left      = 250
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget12", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget12
            .Value     = 0
            .Top       = 290
            .Left      = 335
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *  MES (Label10: top=291+29=320; fwget13/14: top=286+29=315)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "Mes :"
            .Top       = 320
            .Left      = 218
            .Width     = 28
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget13", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget13
            .Value     = 0
            .Top       = 315
            .Left      = 250
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget14", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget14
            .Value     = 0
            .Top       = 315
            .Left      = 335
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *  ANO (Label11: top=316+29=345; fwget15/16: top=311+29=340)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "Ano :"
            .Top       = 345
            .Left      = 218
            .Width     = 28
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget15", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget15
            .Value     = 0
            .Top       = 340
            .Left      = 250
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget16", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget16
            .Value     = 0
            .Top       = 340
            .Left      = 335
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *  LOCAL (Label12: top=340+29=369; fwget17: top=337+29=366)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Local :"
            .Top       = 369
            .Left      = 213
            .Width     = 33
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget17", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget17
            .Value     = ""
            .Top       = 366
            .Left      = 250
            .Width     = 160
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *  TAMANHO FOLHA (Label13: top=364+29=393; fwget18: top=362+29=391)
        *  Legado: fwget18.Valid -> GetPaperSize() quando vazio (ValidarTamanhoFolha)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Tamanho Folha :"
            .Top       = 393
            .Left      = 164
            .Width     = 82
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget18", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget18
            .Value     = ""
            .Top       = 391
            .Left      = 250
            .Width     = 244
            .Height    = 23
            .MaxLength = 50
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_Fwget18, "KeyPress", THIS, "ValidarTamanhoFolha")

        *----------------------------------------------------------------------
        *  NOME IMPRESSORA (Label14: top=392+29=421; fwget19: top=387+29=416)
        *  Legado: fwget19.Valid -> GetPrinter() quando vazio (ValidarNomeImpressora)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = "Nome Impressora :"
            .Top       = 421
            .Left      = 153
            .Width     = 93
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget19", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget19
            .Value     = ""
            .Top       = 416
            .Left      = 250
            .Width     = 319
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_Fwget19, "KeyPress", THIS, "ValidarNomeImpressora")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no Grid da Page1 via BO.Buscar()
    * Cursor cursor_4c_Dados: banco, local, ctamanho, cnomimpre
    * REGRA Problema 48: RecordSource e ColumnCount FORA do WITH
    * REGRA Problema 32: Redefinir Headers APOS RecordSource
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (banco C(3), local C(20), ctamanho C(50), cnomimpre C(40))
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    *-- RecordSource e ColumnCount FORA do WITH (Problema 36/48)
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 4

                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.banco"
                        .Column1.Width           = 80
                        .Column1.Header1.Caption = "Banco"
                        .Column1.ReadOnly        = .T.

                        .Column2.ControlSource   = "cursor_4c_Dados.local"
                        .Column2.Width           = 160
                        .Column2.Header1.Caption = "Local"
                        .Column2.ReadOnly        = .T.

                        .Column3.ControlSource   = "cursor_4c_Dados.ctamanho"
                        .Column3.Width           = 200
                        .Column3.Header1.Caption = "Tamanho Folha"
                        .Column3.ReadOnly        = .T.

                        .Column4.ControlSource   = "cursor_4c_Dados.cnomimpre"
                        .Column4.Width           = 300
                        .Column4.Header1.Caption = "Nome Impressora"
                        .Column4.ReadOnly        = .T.
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ELSE
                    loc_lResultado = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarLista: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    FUNCTION AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            loc_lResultado = .F.
        ELSE
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
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

    *==========================================================================
    *  HANDLERS DE BOTOES - PUBLIC (BINDEVENT exige PUBLIC, sem PROTECTED)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Abre Page2 para novo registro
    * Legado: DoDefault('INSERIR') -> navega para dados + foco em Get_Banco
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)

        TRY
            THIS.pgf_4c_Paginas.Page2.txt_4c_Banco.SetFocus
        CATCH TO loException
            MsgErro("Erro ao focar campo Banco: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    * Legado: DoDefault('CONSULTAR') -> navega + foco em Salva
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cBanco

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cBanco = ALLTRIM(cursor_4c_Dados.banco)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBanco)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)

            TRY
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.cmd_4c_Cancelar.SetFocus
            CATCH TO loException
                MsgErro("Erro ao focar Cancelar: " + loException.Message, "Erro")
            ENDTRY
        ELSE
            MsgAviso("Erro ao carregar o registro selecionado.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    * Legado: DoDefault('ALTERAR') -> navega + foco em Get_Banco (quando habilitado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cBanco

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cBanco = ALLTRIM(cursor_4c_Dados.banco)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBanco)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)

            TRY
                THIS.pgf_4c_Paginas.Page2.txt_4c_Fwget17.SetFocus
            CATCH TO loException
                MsgErro("Erro ao focar campo Local: " + loException.Message, "Erro")
            ENDTRY
        ELSE
            MsgAviso("Erro ao carregar o registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui o registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cBanco

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cBanco = ALLTRIM(cursor_4c_Dados.banco)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do banco [" + loc_cBanco + "]?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBanco)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Banco exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                THIS.CarregarLista()
            ENDIF
        ELSE
            MsgAviso("Erro ao carregar o registro para exclus" + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre FormBuscaAuxiliar para filtrar a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cBanco, loc_oGrid

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCqMat", "cursor_4c_Busca", "banco", "", ;
            "Busca de Configura" + CHR(231) + CHR(227) + "o de Cheque")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("banco",      "", "Banco")
            loc_oBusca.mAddColuna("local",      "", "Local")
            loc_oBusca.mAddColuna("ctamanho",   "", "Tamanho Folha")
            loc_oBusca.mAddColuna("cnomimpre",  "", "Nome Impressora")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                loc_cBanco = ALLTRIM(cursor_4c_Busca.banco)

                IF THIS.this_oBusinessObject.Buscar(loc_cBanco)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.banco"
                        .Column1.Header1.Caption = "Banco"
                        .Column2.ControlSource   = "cursor_4c_Dados.local"
                        .Column2.Header1.Caption = "Local"
                        .Column3.ControlSource   = "cursor_4c_Dados.ctamanho"
                        .Column3.Header1.Caption = "Tamanho Folha"
                        .Column4.ControlSource   = "cursor_4c_Dados.cnomimpre"
                        .Column4.Header1.Caption = "Nome Impressora"
                    ENDWITH
                ENDIF
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva o registro (Page2)
    * Legado: validacoes de banco duplicado + local obrigatorio antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cBanco, loc_cLocal, loc_oPagina

        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes FORA do TRY (Problema 16)
        TRY
            loc_cBanco = ALLTRIM(loc_oPagina.txt_4c_Banco.Value)
            loc_cLocal = ALLTRIM(loc_oPagina.txt_4c_Fwget17.Value)
        CATCH TO loException
            MsgErro("Erro ao ler campos do formul" + CHR(225) + "rio: " + loException.Message, "Erro")
            RETURN
        ENDTRY

        IF EMPTY(loc_cBanco)
            MsgAviso("Preencher o Banco.", "Aten" + CHR(231) + CHR(227) + "o")

            TRY
                loc_oPagina.txt_4c_Banco.SetFocus
            CATCH
            ENDTRY

            RETURN
        ENDIF

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF EMPTY(loc_cLocal)
                MsgAviso("Preencher o Local.", "Aten" + CHR(231) + CHR(227) + "o")

                TRY
                    loc_oPagina.txt_4c_Fwget17.SetFocus
                CATCH
                ENDTRY

                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Sucesso")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e retorna para a lista (Page2 -> Page1)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    *  DATA BINDING - Transferencia Form <-> BO
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos do form para o BO
    * Mapeamento: fwget1=lvlr(L), fwget2=cvlr(C), fwget3=lvext1, fwget4=cvext1
    *             fwget5=lvext2, fwget6=cvext2, fwget7=lfavo, fwget8=cfavo
    *             fwget9=llocal, fwget10=clocal, fwget11=ldia, fwget12=cdia
    *             fwget13=lmes, fwget14=cmes, fwget15=lano, fwget16=cano
    *             fwget17=local, fwget18=ctamanho, fwget19=cnomimpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina, loc_oBO
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        TRY
            loc_oBO.this_cBanco    = ALLTRIM(loc_oPagina.txt_4c_Banco.Value)
            loc_oBO.this_nLvlr     = TRANSFORM(loc_oPagina.txt_4c_Fwget1.Value)
            loc_oBO.this_nCvlr     = TRANSFORM(loc_oPagina.txt_4c_Fwget2.Value)
            loc_oBO.this_nLvext1   = TRANSFORM(loc_oPagina.txt_4c_Fwget3.Value)
            loc_oBO.this_nCvext1   = TRANSFORM(loc_oPagina.txt_4c_Fwget4.Value)
            loc_oBO.this_nLvext2   = TRANSFORM(loc_oPagina.txt_4c_Fwget5.Value)
            loc_oBO.this_nCvext2   = TRANSFORM(loc_oPagina.txt_4c_Fwget6.Value)
            loc_oBO.this_nLfavo    = TRANSFORM(loc_oPagina.txt_4c_Fwget7.Value)
            loc_oBO.this_nCfavo    = TRANSFORM(loc_oPagina.txt_4c_Fwget8.Value)
            loc_oBO.this_nLlocal   = TRANSFORM(loc_oPagina.txt_4c_Fwget9.Value)
            loc_oBO.this_nClocal   = TRANSFORM(loc_oPagina.txt_4c_Fwget10.Value)
            loc_oBO.this_nLdia     = TRANSFORM(loc_oPagina.txt_4c_Fwget11.Value)
            loc_oBO.this_nCdia     = TRANSFORM(loc_oPagina.txt_4c_Fwget12.Value)
            loc_oBO.this_nLmes     = TRANSFORM(loc_oPagina.txt_4c_Fwget13.Value)
            loc_oBO.this_nCmes     = TRANSFORM(loc_oPagina.txt_4c_Fwget14.Value)
            loc_oBO.this_nLano     = TRANSFORM(loc_oPagina.txt_4c_Fwget15.Value)
            loc_oBO.this_nCano     = TRANSFORM(loc_oPagina.txt_4c_Fwget16.Value)
            loc_oBO.this_cLocal    = ALLTRIM(loc_oPagina.txt_4c_Fwget17.Value)
            loc_oBO.this_cTamanho  = ALLTRIM(loc_oPagina.txt_4c_Fwget18.Value)
            loc_oBO.this_cNomImpre = ALLTRIM(loc_oPagina.txt_4c_Fwget19.Value)
        CATCH TO loException
            MsgErro("Erro em FormParaBO:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_oBO
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        TRY
            loc_oPagina.txt_4c_Banco.Value    = loc_oBO.this_cBanco
            loc_oPagina.txt_4c_Fwget1.Value   = loc_oBO.this_nLvlr
            loc_oPagina.txt_4c_Fwget2.Value   = loc_oBO.this_nCvlr
            loc_oPagina.txt_4c_Fwget3.Value   = loc_oBO.this_nLvext1
            loc_oPagina.txt_4c_Fwget4.Value   = loc_oBO.this_nCvext1
            loc_oPagina.txt_4c_Fwget5.Value   = loc_oBO.this_nLvext2
            loc_oPagina.txt_4c_Fwget6.Value   = loc_oBO.this_nCvext2
            loc_oPagina.txt_4c_Fwget7.Value   = loc_oBO.this_nLfavo
            loc_oPagina.txt_4c_Fwget8.Value   = loc_oBO.this_nCfavo
            loc_oPagina.txt_4c_Fwget9.Value   = loc_oBO.this_nLlocal
            loc_oPagina.txt_4c_Fwget10.Value  = loc_oBO.this_nClocal
            loc_oPagina.txt_4c_Fwget11.Value  = loc_oBO.this_nLdia
            loc_oPagina.txt_4c_Fwget12.Value  = loc_oBO.this_nCdia
            loc_oPagina.txt_4c_Fwget13.Value  = loc_oBO.this_nLmes
            loc_oPagina.txt_4c_Fwget14.Value  = loc_oBO.this_nCmes
            loc_oPagina.txt_4c_Fwget15.Value  = loc_oBO.this_nLano
            loc_oPagina.txt_4c_Fwget16.Value  = loc_oBO.this_nCano
            loc_oPagina.txt_4c_Fwget17.Value  = loc_oBO.this_cLocal
            loc_oPagina.txt_4c_Fwget18.Value  = loc_oBO.this_cTamanho
            loc_oPagina.txt_4c_Fwget19.Value  = loc_oBO.this_cNomImpre
        CATCH TO loException
            MsgErro("Erro em BOParaForm:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPagina.txt_4c_Banco.Value    = ""
            loc_oPagina.txt_4c_Fwget1.Value   = 0
            loc_oPagina.txt_4c_Fwget2.Value   = 0
            loc_oPagina.txt_4c_Fwget3.Value   = 0
            loc_oPagina.txt_4c_Fwget4.Value   = 0
            loc_oPagina.txt_4c_Fwget5.Value   = 0
            loc_oPagina.txt_4c_Fwget6.Value   = 0
            loc_oPagina.txt_4c_Fwget7.Value   = 0
            loc_oPagina.txt_4c_Fwget8.Value   = 0
            loc_oPagina.txt_4c_Fwget9.Value   = 0
            loc_oPagina.txt_4c_Fwget10.Value  = 0
            loc_oPagina.txt_4c_Fwget11.Value  = 0
            loc_oPagina.txt_4c_Fwget12.Value  = 0
            loc_oPagina.txt_4c_Fwget13.Value  = 0
            loc_oPagina.txt_4c_Fwget14.Value  = 0
            loc_oPagina.txt_4c_Fwget15.Value  = 0
            loc_oPagina.txt_4c_Fwget16.Value  = 0
            loc_oPagina.txt_4c_Fwget17.Value  = ""
            loc_oPagina.txt_4c_Fwget18.Value  = ""
            loc_oPagina.txt_4c_Fwget19.Value  = ""
        CATCH TO loException
            MsgErro("Erro em LimparCampos: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    * Legado: Get_Banco.When retorna .F. nos modos ALTERAR/EXCLUIR/CONSULTAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Banco editavel SOMENTE no modo INCLUIR (regra do legado: Get_Banco.When)
            loc_oPagina.txt_4c_Banco.ReadOnly  = !INLIST(THIS.this_cModoAtual, "INCLUIR")
            loc_oPagina.txt_4c_Banco.Enabled   =  INLIST(THIS.this_cModoAtual, "INCLUIR")

            *-- Demais campos seguem par_lHabilitar
            loc_oPagina.txt_4c_Fwget1.ReadOnly   = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget2.ReadOnly   = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget3.ReadOnly   = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget4.ReadOnly   = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget5.ReadOnly   = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget6.ReadOnly   = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget7.ReadOnly   = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget8.ReadOnly   = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget9.ReadOnly   = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget10.ReadOnly  = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget11.ReadOnly  = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget12.ReadOnly  = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget13.ReadOnly  = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget14.ReadOnly  = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget15.ReadOnly  = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget16.ReadOnly  = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget17.ReadOnly  = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget18.ReadOnly  = !par_lHabilitar
            loc_oPagina.txt_4c_Fwget19.ReadOnly  = !par_lHabilitar
        CATCH TO loException
            MsgErro("Erro em HabilitarCampos: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta habilitacao dos botoes Confirmar/Cancelar
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2Botoes

        TRY
            loc_oPg2Botoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados

            DO CASE
            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Confirmar", 5)
                    loc_oPg2Botoes.cmd_4c_Confirmar.Enabled = .T.
                ENDIF
                IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Cancelar", 5)
                    loc_oPg2Botoes.cmd_4c_Cancelar.Enabled  = .T.
                ENDIF
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Confirmar", 5)
                    loc_oPg2Botoes.cmd_4c_Confirmar.Enabled = .F.
                ENDIF
                IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Cancelar", 5)
                    loc_oPg2Botoes.cmd_4c_Cancelar.Enabled  = .T.
                ENDIF
            ENDCASE
        CATCH TO loException
            MsgErro("Erro em AjustarBotoesPorModo: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTamanhoFolha - Obtem tamanho da folha via dialogo se campo vazio
    * Legado: fwget18.Valid - GetPaperSize() quando valor em branco
    * Chamado via BINDEVENT LostFocus de txt_4c_Fwget18 (configurado na Fase 5)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTamanhoFolha(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cTamanho, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cTamanho = ALLTRIM(loc_oPagina.txt_4c_Fwget18.Value)

            IF EMPTY(loc_cTamanho)
                loc_cTamanho = GETPAPERSIZE()

                IF EMPTY(loc_cTamanho)
                    loc_cTamanho = STR(256, 10) + "Personalizado"
                ENDIF

                loc_oPagina.txt_4c_Fwget18.Value = ALLTRIM(SUBSTR(loc_cTamanho, 11))
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarTamanhoFolha: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNomeImpressora - Obtem impressora padrao via dialogo se campo vazio
    * Legado: fwget19.Valid - GetPrinter() quando valor em branco
    * Chamado via BINDEVENT LostFocus de txt_4c_Fwget19 (configurado na Fase 5)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNomeImpressora(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cImpre, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cImpre = ALLTRIM(loc_oPagina.txt_4c_Fwget19.Value)

            IF EMPTY(loc_cImpre)
                loc_cImpre = GETPRINTER()

                IF !EMPTY(loc_cImpre)
                    loc_oPagina.txt_4c_Fwget19.Value = loc_cImpre
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarNomeImpressora: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao destruir FormCHM: " + loException.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
