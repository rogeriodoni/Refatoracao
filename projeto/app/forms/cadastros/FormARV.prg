*==============================================================================
* FormARV.prg - Fase 7/8: Form - Eventos Principais
* Formulario de Cadastro de Tipos de Arvore (SIGCDARV)
*
* Tabela: SigCdArv
* Tipo: CRUD (frmcadastro)
* BO: ARVBO
*==============================================================================

DEFINE CLASS FormARV AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Tipos de " + CHR(193) + "rvore"
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
            MsgErro(loc_oErro.Message, "FormARV.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura basica do form
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ARVBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar ARVBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormARV.InicializarForm")
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
    * ConfigurarPaginaLista - Cria containers da Page1 (Lista) com grid e botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza (Top = 2+29 = 31, compensacao PageFrame.Top=-29)
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

        *-- Botao Incluir
        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 5
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Botao Visualizar
        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 80
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Botao Alterar
        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 155
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Botao Excluir
        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 230
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Botao Buscar
        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 305
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

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

        *-- Botao Encerrar (canonico)
        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 5
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Grid de listagem
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .Visible            = .T.
        ENDWITH
        loc_oGrid.ColumnCount              = 2
        loc_oGrid.Column1.Width            = 80
        loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digos"
        loc_oGrid.Column2.Width            = 290
        loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"

        *-- BINDEVENT botoes Page1
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oGrid,                      "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2 (Dados): Salva + campos Parte 1/2 (Fase 5)
    * Coordenadas: Top_original + 29 (compensacao PageFrame.Top=-29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oSalva
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container botoes Confirmar/Cancelar (canonico: Top=33, Left=842)
        loc_oPg2.AddObject("cnt_4c_Salva", "Container")
        loc_oSalva = loc_oPg2.cnt_4c_Salva
        WITH loc_oSalva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar
        loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 5
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        *-- Botao Cancelar
        loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top    = 5
            .Left   = 80
            .Width  = 75
            .Height = 75
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90,90,90)
            .BackColor = RGB(255,255,255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap     = .T.
            .AutoSize     = .F.
            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oSalva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *-- CAMPOS PARTE 1/2 ? Say1/get_Cod, Say2/get_descs, Say3/get_formula,
        *--                     Label7/get_perc/Label8, Label1 (Fundicao)
        *----------------------------------------------------------------------

        *-- Label "Codigo :" (Say1, top 171+29=200)
        loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPg2.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 200
            .Left      = 61
            .Width     = 50
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigos (get_Cod, top 168+29=197)
        loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPg2.txt_4c_Codigos
            .Value    = ""
            .Top      = 197
            .Left     = 116
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Label "Descricao :" (Say2, top 198+29=227)
        loc_oPg2.AddObject("lbl_4c_Descs", "Label")
        WITH loc_oPg2.lbl_4c_Descs
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 227
            .Left      = 45
            .Width     = 68
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descs (get_descs, top 192+29=221)
        loc_oPg2.AddObject("txt_4c_Descs", "TextBox")
        WITH loc_oPg2.txt_4c_Descs
            .Value    = ""
            .Top      = 221
            .Left     = 116
            .Width    = 290
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Label "Formula :" (Say3, top 227+29=256)
        loc_oPg2.AddObject("lbl_4c_Formula", "Label")
        WITH loc_oPg2.lbl_4c_Formula
            .Caption   = "F" + CHR(243) + "rmula :"
            .Top       = 256
            .Left      = 55
            .Width     = 58
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- EditBox Formulas (get_formula, top 228+29=257, height=100)
        loc_oPg2.AddObject("obj_4c_Formulas", "EditBox")
        WITH loc_oPg2.obj_4c_Formulas
            .Value      = ""
            .Top        = 257
            .Left       = 115
            .Width      = 290
            .Height     = 100
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackColor  = RGB(255, 255, 255)
            .ForeColor  = RGB(0, 0, 0)
            .ScrollBars = 2
            .Visible    = .T.
        ENDWITH

        *-- Label "Metal Novo :" (Label7, top 170+29=199)
        loc_oPg2.AddObject("lbl_4c_MetalNovo", "Label")
        WITH loc_oPg2.lbl_4c_MetalNovo
            .Caption   = "Metal Novo :"
            .Top       = 199
            .Left      = 435
            .Width     = 74
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Percentual metal novo (get_perc, top 166+29=195, mask 999.99)
        loc_oPg2.AddObject("txt_4c_Percs", "TextBox")
        WITH loc_oPg2.txt_4c_Percs
            .Value     = 0
            .Top       = 195
            .Left      = 514
            .Width     = 52
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999.99"
            .Visible   = .T.
        ENDWITH

        *-- Label "%" (Label8, top 170+29=199)
        loc_oPg2.AddObject("lbl_4c_Pct", "Label")
        WITH loc_oPg2.lbl_4c_Pct
            .Caption   = "%"
            .Top       = 199
            .Left      = 570
            .Width     = 14
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label titulo secao "Fundicao" (Label1, top 208+29=237)
        loc_oPg2.AddObject("lbl_4c_Fundicao", "Label")
        WITH loc_oPg2.lbl_4c_Fundicao
            .Caption   = "Fundi" + CHR(231) + CHR(227) + "o"
            .Top       = 237
            .Left      = 435
            .Width     = 61
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Temperatura Metal" (Label2, top 226+29=255)
        loc_oPg2.AddObject("lbl_4c_TempMet", "Label")
        WITH loc_oPg2.lbl_4c_TempMet
            .Caption   = "Temperatura Metal"
            .Top       = 255
            .Left      = 465
            .Width     = 110
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox TempMets (Get_TempMet, top 242+29=271, MaxLength=15)
        loc_oPg2.AddObject("txt_4c_TempMets", "TextBox")
        WITH loc_oPg2.txt_4c_TempMets
            .Value     = ""
            .Top       = 271
            .Left      = 465
            .Width     = 115
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label "Temperatura Tubo" (Label3, top 226+29=255)
        loc_oPg2.AddObject("lbl_4c_TempTub", "Label")
        WITH loc_oPg2.lbl_4c_TempTub
            .Caption   = "Temperatura Tubo"
            .Top       = 255
            .Left      = 615
            .Width     = 108
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(231, 254, 253)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox TempTubs (Get_TempTub, top 242+29=271, MaxLength=15)
        loc_oPg2.AddObject("txt_4c_TempTubs", "TextBox")
        WITH loc_oPg2.txt_4c_TempTubs
            .Value     = ""
            .Top       = 271
            .Left      = 615
            .Width     = 115
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label "Revestimento" (Label4, top 272+29=301)
        loc_oPg2.AddObject("lbl_4c_Revestimento", "Label")
        WITH loc_oPg2.lbl_4c_Revestimento
            .Caption   = "Revestimento"
            .Top       = 301
            .Left      = 435
            .Width     = 91
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Temperatura Ambiente" (Label5, top 288+29=317)
        loc_oPg2.AddObject("lbl_4c_TempAmb", "Label")
        WITH loc_oPg2.lbl_4c_TempAmb
            .Caption   = "Temperatura Ambiente"
            .Top       = 317
            .Left      = 465
            .Width     = 134
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox TempAmbs (Get_TempAmb, top 304+29=333, MaxLength=15)
        loc_oPg2.AddObject("txt_4c_TempAmbs", "TextBox")
        WITH loc_oPg2.txt_4c_TempAmbs
            .Value     = ""
            .Top       = 333
            .Left      = 465
            .Width     = 115
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label "Temperatura Agua" (Label6, top 288+29=317)
        loc_oPg2.AddObject("lbl_4c_TempAgu", "Label")
        WITH loc_oPg2.lbl_4c_TempAgu
            .Caption   = "Temperatura " + CHR(193) + "gua"
            .Top       = 317
            .Left      = 615
            .Width     = 109
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(231, 254, 253)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Tempagus (Get_TempAgu, top 304+29=333, MaxLength=15)
        loc_oPg2.AddObject("txt_4c_Tempagus", "TextBox")
        WITH loc_oPg2.txt_4c_Tempagus
            .Value     = ""
            .Top       = 333
            .Left      = 615
            .Width     = 115
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say4: instrucoes para formula (Say4, top 349+29=378)
        loc_oPg2.AddObject("lbl_4c_Say4", "Label")
        WITH loc_oPg2.lbl_4c_Say4
            .Caption   = "Para montar a f" + CHR(243) + "rmula tem que usar os seguintes campos :"
            .Top       = 378
            .Left      = 61
            .Width     = 380
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .F.
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say5: BCERAS = Base + Cera (top 369+29=398)
        loc_oPg2.AddObject("lbl_4c_Say5", "Label")
        WITH loc_oPg2.lbl_4c_Say5
            .Caption   = "BCERAS = Base + Cera"
            .Top       = 398
            .Left      = 61
            .Width     = 150
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .F.
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say6: BASES = Base (top 389+29=418)
        loc_oPg2.AddObject("lbl_4c_Say6", "Label")
        WITH loc_oPg2.lbl_4c_Say6
            .Caption   = "BASES = Base"
            .Top       = 418
            .Left      = 61
            .Width     = 93
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .F.
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say7: exemplo de formula (top 409+29=438)
        loc_oPg2.AddObject("lbl_4c_Say7", "Label")
        WITH loc_oPg2.lbl_4c_Say7
            .Caption   = "Ex: (((BCERAS - BASES) * 15,3) - 40)/5"
            .Top       = 438
            .Left      = 61
            .Width     = 268
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .F.
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
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

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no Grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                loc_lResultado = .F.
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource          = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                loc_oGrid.Column1.Width         = 80
                loc_oGrid.Column2.Width         = 290
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormARV.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
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
            MsgErro(loc_oErro.Message, "FormARV.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

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
    * HabilitarCampos - Habilita/desabilita campos de Page2 conforme modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEdicao
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
            loc_oPg2.txt_4c_Descs.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Formulas", 5)
            loc_oPg2.obj_4c_Formulas.ReadOnly = !(par_lHabilitar AND loc_lEdicao)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Percs", 5)
            loc_oPg2.txt_4c_Percs.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempMets", 5)
            loc_oPg2.txt_4c_TempMets.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempTubs", 5)
            loc_oPg2.txt_4c_TempTubs.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempAmbs", 5)
            loc_oPg2.txt_4c_TempAmbs.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tempagus", 5)
            loc_oPg2.txt_4c_Tempagus.Enabled = par_lHabilitar AND loc_lEdicao
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar AND loc_lEdicao
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos de Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
            loc_oPg2.txt_4c_Descs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Formulas", 5)
            loc_oPg2.obj_4c_Formulas.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Percs", 5)
            loc_oPg2.txt_4c_Percs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempMets", 5)
            loc_oPg2.txt_4c_TempMets.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempTubs", 5)
            loc_oPg2.txt_4c_TempTubs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempAmbs", 5)
            loc_oPg2.txt_4c_TempAmbs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tempagus", 5)
            loc_oPg2.txt_4c_Tempagus.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do formulario para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
            THIS.this_oBusinessObject.this_cDescs = ALLTRIM(loc_oPg2.txt_4c_Descs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Formulas", 5)
            THIS.this_oBusinessObject.this_cFormulas = ALLTRIM(loc_oPg2.obj_4c_Formulas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Percs", 5)
            THIS.this_oBusinessObject.this_nPercs = loc_oPg2.txt_4c_Percs.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempMets", 5)
            THIS.this_oBusinessObject.this_cTempMets = ALLTRIM(loc_oPg2.txt_4c_TempMets.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempTubs", 5)
            THIS.this_oBusinessObject.this_cTempTubs = ALLTRIM(loc_oPg2.txt_4c_TempTubs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempAmbs", 5)
            THIS.this_oBusinessObject.this_cTempAmbs = ALLTRIM(loc_oPg2.txt_4c_TempAmbs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tempagus", 5)
            THIS.this_oBusinessObject.this_cTempagus = ALLTRIM(loc_oPg2.txt_4c_Tempagus.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
            loc_oPg2.txt_4c_Codigos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descs", 5)
            loc_oPg2.txt_4c_Descs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Formulas", 5)
            loc_oPg2.obj_4c_Formulas.Value = THIS.this_oBusinessObject.this_cFormulas
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Percs", 5)
            loc_oPg2.txt_4c_Percs.Value = THIS.this_oBusinessObject.this_nPercs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempMets", 5)
            loc_oPg2.txt_4c_TempMets.Value = ALLTRIM(THIS.this_oBusinessObject.this_cTempMets)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempTubs", 5)
            loc_oPg2.txt_4c_TempTubs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cTempTubs)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_TempAmbs", 5)
            loc_oPg2.txt_4c_TempAmbs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cTempAmbs)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Tempagus", 5)
            loc_oPg2.txt_4c_Tempagus.Value = ALLTRIM(THIS.this_oBusinessObject.this_cTempagus)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
            RETURN
        ENDIF

        THIS.BOParaForm()
        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.HabilitarCampos(.F.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Alterar")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.EditarRegistro()
        THIS.BOParaForm()
        THIS.this_cModoAtual = "ALTERAR"
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Descs", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descs.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo   = ""
        loc_lConfirma = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + loc_cCodigo + "'?", "Excluir")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Excluir")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Excluir()
            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
            THIS.CarregarLista()
        ELSE
            MsgErro("Erro ao excluir o registro.", "Excluir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_oBusca  = .NULL.
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdArv", "cursor_4c_BuscaArv", "codigos", "", ;
                "Buscar Tipo de " + CHR(193) + "rvore")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digos")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaArv")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaArv.codigos)
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(cursor_4c_Dados.codigos) = loc_cCodigo
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormARV.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaArv")
            USE IN cursor_4c_BuscaArv
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva registro (chamado pelo cmd_4c_Confirmar da Page2)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cCodigo, loc_nChk, loc_lSucesso
        loc_cCodigo  = ""
        loc_nChk     = 0
        loc_lSucesso = .F.

        THIS.FormParaBO()
        loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)

        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "Salvar")
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
            ENDIF
            RETURN
        ENDIF

        IF THIS.this_cModoAtual = "INCLUIR"
            loc_nChk = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS cnt FROM SigCdArv WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_ChkArv")
            IF loc_nChk >= 0 AND RECCOUNT("cursor_4c_ChkArv") > 0
                SELECT cursor_4c_ChkArv
                IF cursor_4c_ChkArv.cnt > 0
                    MsgAviso("Tipo de " + CHR(225) + "rvore j" + CHR(225) + " cadastrado!", "Salvar")
                    IF USED("cursor_4c_ChkArv")
                        USE IN cursor_4c_ChkArv
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
                    ENDIF
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_ChkArv")
                USE IN cursor_4c_ChkArv
            ENDIF
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Salvar")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEdicao
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
