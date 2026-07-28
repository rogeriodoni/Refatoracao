*==============================================================================
* FormCEP.PRG - Fase 8/8: COMPLETO
* Formulario de Cadastro de CEP (SIGCDCEP)
*
* Tabela: Cep (cIdChaves PK, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados)
* Tipo: CRUD (frmcadastro)
* BO: CEPBO
*
* Especial: Page1 tem filtro por UF (txt_4c_Estados) para lidar com o
* grande volume de registros da tabela CEP (comportamento.json: pUFs filter)
*==============================================================================

DEFINE CLASS FormCEP AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 700
    Width       = 1000
    Caption     = "Cadastro de CEP"
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
    this_oBusinessObject       = .NULL.
    this_cModoAtual            = "LISTA"

    *-- Filtro de UF (Page1): vazio = grid vazio (original: pUFs=Chr(254)*2 = sem registros)
    this_cUfFiltro             = ""
    this_cUltimoEstadoValidado = ""

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.Init")
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
            THIS.this_oBusinessObject = CREATEOBJECT("CEPBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar CEPBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.InicializarForm")
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
            .PageCount       = 2
            .Top             = -29
            .Left            = 0
            .Width           = THIS.Width
            .Height          = THIS.Height + 29
            .Tabs            = .F.
            .Visible         = .T.
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
    * ConfigurarPaginaLista - Configura Page1: cabecalho + botoes CRUD + saida
    * Fase 4 adiciona: grid de CEPs + filtro UF
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho cinza (Top = 2 + 29 = 31)
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
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
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
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
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
            .FontName        = "Tahoma"
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
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
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
            .FontName        = "Tahoma"
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
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
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
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
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
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

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
            .FontName        = "Tahoma"
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

        *-- Label "Filtrar Pela UF :" (top=96+29=125, left=71)
        loc_oPg1.AddObject("lbl_4c_FiltrarUF", "Label")
        WITH loc_oPg1.lbl_4c_FiltrarUF
            .Caption   = "Filtrar Pela UF :"
            .Top       = 125
            .Left      = 71
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox UF (top=92+29=121, left=160, width=30, maxlength=2)
        loc_oPg1.AddObject("txt_4c_Estados", "TextBox")
        WITH loc_oPg1.txt_4c_Estados
            .Value     = ""
            .Top       = 121
            .Left      = 160
            .Width     = 30
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Estados, "KeyPress", THIS, "ValidarEstadosLista")

        *-- Nota de filtro (top=96+29=125, left=214)
        loc_oPg1.AddObject("lbl_4c_NotaFiltro", "Label")
        WITH loc_oPg1.lbl_4c_NotaFiltro
            .Caption   = "NOTA: Devido " + CHR(224) + " grande quantidade de dados, " + ;
                         "o processo de filtro pode levar alguns minutos."
            .Top       = 125
            .Left      = 214
            .Width     = 518
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid principal (top=128+29=157, left=11, width=972, height=481)
        *-- RecordSource e ColumnCount fora do WITH para garantir criacao das colunas
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 6

        WITH loc_oGrid
            .Top                = 157
            .Left               = 11
            .Width              = 972
            .Height             = 481
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Header1.Caption = "CEP"
            .Width           = 90
        ENDWITH

        WITH loc_oGrid.Column2
            .Header1.Caption = "Tipo"
            .Width           = 80
        ENDWITH

        WITH loc_oGrid.Column3
            .Header1.Caption = "Endere" + CHR(231) + "o"
            .Width           = 280
        ENDWITH

        WITH loc_oGrid.Column4
            .Header1.Caption = "Bairro"
            .Width           = 200
        ENDWITH

        WITH loc_oGrid.Column5
            .Header1.Caption = "Cidade"
            .Width           = 230
        ENDWITH

        WITH loc_oGrid.Column6
            .Header1.Caption = "UF"
            .Width           = 60
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2: cabecalho + botoes acao
    * Fase 5-6 adiciona: labels + TextBoxes dos campos CEP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oCab, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container cabecalho cinza (Top = 2 + 29 = 31)
        loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg2.cnt_4c_Cabecalho
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
            .FontName        = "Tahoma"
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
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
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
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- === CAMPO: CEP ===
        *-- Label "CEP :" (top=149+29=178, left=243)
        loc_oPg2.AddObject("lbl_4c_LabelCEP", "Label")
        WITH loc_oPg2.lbl_4c_LabelCEP
            .Caption   = "CEP :"
            .Top       = 178
            .Left      = 243
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox CEP (top=145+29=174, left=275, width=80, maxlength=9)
        *-- Editavel apenas em INCLUIR (original: getCEPS.When = InList([INSERIR],[PROCURAR]))
        loc_oPg2.AddObject("txt_4c_CEPS", "TextBox")
        WITH loc_oPg2.txt_4c_CEPS
            .Value     = ""
            .Top       = 174
            .Left      = 275
            .Width     = 80
            .Height    = 23
            .MaxLength = 9
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- === CAMPO: TipoNomes (Tipo de Endereco) ===
        *-- Label "Tipo :" (top=175+29=204, left=242)
        loc_oPg2.AddObject("lbl_4c_LabelTipo", "Label")
        WITH loc_oPg2.lbl_4c_LabelTipo
            .Caption   = "Tipo :"
            .Top       = 204
            .Left      = 242
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Tipo (top=171+29=200, left=275, width=80, maxlength=15)
        loc_oPg2.AddObject("txt_4c_TipoNomes", "TextBox")
        WITH loc_oPg2.txt_4c_TipoNomes
            .Value     = ""
            .Top       = 200
            .Left      = 275
            .Width     = 80
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label hint "(Ex.: R, AV, TV, AL)" (top=175+29=204, left=359)
        loc_oPg2.AddObject("lbl_4c_TipoHint", "Label")
        WITH loc_oPg2.lbl_4c_TipoHint
            .Caption   = "(Ex.: R, AV, TV, AL)"
            .Top       = 204
            .Left      = 359
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- === CAMPO: Nomes (Endereco) ===
        *-- Label "Endereco :" (top=201+29=230, left=217)
        loc_oPg2.AddObject("lbl_4c_LabelNomes", "Label")
        WITH loc_oPg2.lbl_4c_LabelNomes
            .Caption   = "Endere" + CHR(231) + "o :"
            .Top       = 230
            .Left      = 217
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Endereco (top=197+29=226, left=275, width=430, maxlength=72)
        loc_oPg2.AddObject("txt_4c_Nomes", "TextBox")
        WITH loc_oPg2.txt_4c_Nomes
            .Value     = ""
            .Top       = 226
            .Left      = 275
            .Width     = 430
            .Height    = 23
            .MaxLength = 72
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- === CAMPO: Comples (Complemento) ===
        *-- Label "Complemento :" (top=228+29=257, left=197)
        loc_oPg2.AddObject("lbl_4c_LabelComples", "Label")
        WITH loc_oPg2.lbl_4c_LabelComples
            .Caption   = "Complemento :"
            .Top       = 257
            .Left      = 197
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Complemento (top=224+29=253, left=275, width=430, maxlength=72)
        loc_oPg2.AddObject("txt_4c_Comples", "TextBox")
        WITH loc_oPg2.txt_4c_Comples
            .Value     = ""
            .Top       = 253
            .Left      = 275
            .Width     = 430
            .Height    = 23
            .MaxLength = 72
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- === CAMPO: Bairros ===
        *-- Label "Bairro :" (top=254+29=283, left=234)
        loc_oPg2.AddObject("lbl_4c_LabelBairros", "Label")
        WITH loc_oPg2.lbl_4c_LabelBairros
            .Caption   = "Bairro :"
            .Top       = 283
            .Left      = 234
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Bairro (top=250+29=279, left=275, width=220, maxlength=72)
        loc_oPg2.AddObject("txt_4c_Bairros", "TextBox")
        WITH loc_oPg2.txt_4c_Bairros
            .Value     = ""
            .Top       = 279
            .Left      = 275
            .Width     = 220
            .Height    = 23
            .MaxLength = 72
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- === CAMPO: Cidades ===
        *-- Label "Cidade :" (top=281+29=310, left=229)
        loc_oPg2.AddObject("lbl_4c_LabelCidades", "Label")
        WITH loc_oPg2.lbl_4c_LabelCidades
            .Caption   = "Cidade :"
            .Top       = 310
            .Left      = 229
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Cidade (top=277+29=306, left=275, width=430, maxlength=72)
        loc_oPg2.AddObject("txt_4c_Cidades", "TextBox")
        WITH loc_oPg2.txt_4c_Cidades
            .Value     = ""
            .Top       = 306
            .Left      = 275
            .Width     = 430
            .Height    = 23
            .MaxLength = 72
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Cidades, "KeyPress", THIS, "CidadesKeyPress")
        BINDEVENT(loc_oPg2.txt_4c_Cidades, "DblClick", THIS, "CidadesDblClick")

        *-- === CAMPO: Estados (UF em dados - sempre readonly) ===
        *-- Original: getEstados.When = .F. (nunca habilitado)
        *-- Label "UF :" (top=308+29=337, left=249)
        loc_oPg2.AddObject("lbl_4c_LabelEstados", "Label")
        WITH loc_oPg2.lbl_4c_LabelEstados
            .Caption   = "UF :"
            .Top       = 337
            .Left      = 249
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox UF dados (top=304+29=333, left=275, width=24, maxlength=2)
        loc_oPg2.AddObject("txt_4c_Estados", "TextBox")
        WITH loc_oPg2.txt_4c_Estados
            .Value     = ""
            .Top       = 333
            .Left      = 275
            .Width     = 24
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- === CAMPO: Nums (Numero) ===
        *-- Label "N?mero :" (top=334+29=363, left=225)
        loc_oPg2.AddObject("lbl_4c_LabelNums", "Label")
        WITH loc_oPg2.lbl_4c_LabelNums
            .Caption   = "N" + CHR(250) + "mero :"
            .Top       = 363
            .Left      = 225
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Numero (top=330+29=359, left=275, width=80, maxlength=11)
        loc_oPg2.AddObject("txt_4c_Nums", "TextBox")
        WITH loc_oPg2.txt_4c_Nums
            .Value     = ""
            .Top       = 359
            .Left      = 275
            .Width     = 80
            .Height    = 23
            .MaxLength = 11
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
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
    * FormatarGridLista - Formata visual do grid de lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega grid Page1 com CEPs filtrados por UF
    * Fase 4 completa: vincula RecordSource ao grid e configura colunas
    * Comportamento original: grid vazio quando UF nao selecionada
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (cIdChaves C(20), Ceps C(9), TipoNomes C(15), ;
                    Nomes C(72), Bairros C(72), Cidades C(72), Estados C(2), ;
                    Comples C(72), Nums C(11), cBarCeps C(7), TipoCeps C(1))
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            LOCAL loc_oGrid
            IF EMPTY(ALLTRIM(THIS.this_cUfFiltro))
                *-- Original inicia com grid vazio (pUFs = Chr(254)*2 nao retorna nada)
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (cIdChaves C(20), Ceps C(9), TipoNomes C(15), ;
                    Nomes C(72), Bairros C(72), Cidades C(72), Estados C(2), ;
                    Comples C(72), Nums C(11), cBarCeps C(7), TipoCeps C(1))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar(THIS.this_cUfFiltro)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                loc_oGrid.ColumnCount = 6
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Ceps"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.TipoNomes"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Nomes"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Bairros"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Cidades"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Estados"
                loc_oGrid.Column1.Header1.Caption = "CEP"
                loc_oGrid.Column2.Header1.Caption = "Tipo"
                loc_oGrid.Column3.Header1.Caption = "Endere" + CHR(231) + "o"
                loc_oGrid.Column4.Header1.Caption = "Bairro"
                loc_oGrid.Column5.Header1.Caption = "Cidade"
                loc_oGrid.Column6.Header1.Caption = "UF"
                loc_oGrid.Column1.Width = 90
                loc_oGrid.Column2.Width = 80
                loc_oGrid.Column3.Width = 280
                loc_oGrid.Column4.Width = 200
                loc_oGrid.Column5.Width = 230
                loc_oGrid.Column6.Width = 60
                THIS.FormatarGridLista(loc_oGrid)
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
                THIS.this_cModoAtual = "LISTA"
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oBotoes, loc_oPg2, loc_oBotAcao
        loc_oPg1    = THIS.pgf_4c_Paginas.Page1
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_oBotAcao = loc_oPg2.cnt_4c_BotoesAcao

        DO CASE
            CASE THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
                loc_oBotAcao.cmd_4c_Confirmar.Enabled = .T.
                loc_oBotAcao.cmd_4c_Cancelar.Enabled  = .T.

            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oBotAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oBotAcao.cmd_4c_Cancelar.Enabled  = .T.

            OTHERWISE
                *-- LISTA: nada a ajustar em Page2
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCeps      = ALLTRIM(loc_oPg2.txt_4c_CEPS.Value)
        THIS.this_oBusinessObject.this_cTipoNomes = ALLTRIM(loc_oPg2.txt_4c_TipoNomes.Value)
        THIS.this_oBusinessObject.this_cNomes     = ALLTRIM(loc_oPg2.txt_4c_Nomes.Value)
        THIS.this_oBusinessObject.this_cComples   = ALLTRIM(loc_oPg2.txt_4c_Comples.Value)
        THIS.this_oBusinessObject.this_cBairros   = ALLTRIM(loc_oPg2.txt_4c_Bairros.Value)
        THIS.this_oBusinessObject.this_cCidades   = UPPER(ALLTRIM(loc_oPg2.txt_4c_Cidades.Value))
        THIS.this_oBusinessObject.this_cEstados   = ALLTRIM(loc_oPg2.txt_4c_Estados.Value)
        THIS.this_oBusinessObject.this_cNums      = ALLTRIM(loc_oPg2.txt_4c_Nums.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_CEPS.Value      = THIS.this_oBusinessObject.this_cCeps
        loc_oPg2.txt_4c_TipoNomes.Value = THIS.this_oBusinessObject.this_cTipoNomes
        loc_oPg2.txt_4c_Nomes.Value     = THIS.this_oBusinessObject.this_cNomes
        loc_oPg2.txt_4c_Comples.Value   = THIS.this_oBusinessObject.this_cComples
        loc_oPg2.txt_4c_Bairros.Value   = THIS.this_oBusinessObject.this_cBairros
        loc_oPg2.txt_4c_Cidades.Value   = THIS.this_oBusinessObject.this_cCidades
        loc_oPg2.txt_4c_Estados.Value   = THIS.this_oBusinessObject.this_cEstados
        loc_oPg2.txt_4c_Nums.Value      = THIS.this_oBusinessObject.this_cNums
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de edicao
    * CEP: so editavel em INCLUIR (original: getCEPS.When = InList([INSERIR],[PROCURAR]))
    * Estados (UF Dados): nunca habilitado (original: getEstados.When = .F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lHabCEP
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lHabCEP = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

        loc_oPg2.txt_4c_CEPS.Enabled      = loc_lHabCEP
        loc_oPg2.txt_4c_TipoNomes.Enabled = par_lHabilitar
        loc_oPg2.txt_4c_Nomes.Enabled     = par_lHabilitar
        loc_oPg2.txt_4c_Comples.Enabled   = par_lHabilitar
        loc_oPg2.txt_4c_Bairros.Enabled   = par_lHabilitar
        loc_oPg2.txt_4c_Cidades.Enabled   = par_lHabilitar
        *-- Estados (UF) NUNCA habilitado (original: getEstados.When = .F.)
        loc_oPg2.txt_4c_Estados.Enabled   = .F.
        loc_oPg2.txt_4c_Nums.Enabled      = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_CEPS.Value      = ""
        loc_oPg2.txt_4c_TipoNomes.Value = ""
        loc_oPg2.txt_4c_Nomes.Value     = ""
        loc_oPg2.txt_4c_Comples.Value   = ""
        loc_oPg2.txt_4c_Bairros.Value   = ""
        loc_oPg2.txt_4c_Cidades.Value   = ""
        loc_oPg2.txt_4c_Estados.Value   = ""
        loc_oPg2.txt_4c_Nums.Value      = ""
    ENDPROC

    *==========================================================================
    * EVENTOS DOS BOTOES - Page1 (Lista)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo CEP
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            *-- Pre-preencher UF a partir do filtro da lista (original: getEstados copiado no Click)
            IF !EMPTY(THIS.this_cUfFiltro)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Estados.Value = THIS.this_cUfFiltro
            ENDIF
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar CEP selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
            ENDIF

            IF EMPTY(loc_cChave)
                MsgAviso("Selecione um registro na lista.", "Aviso")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar CEP selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
            ENDIF

            IF EMPTY(loc_cChave)
                MsgAviso("Selecione um registro na lista.", "Aviso")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir CEP selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_cCeps
        loc_cChave = ""
        loc_cCeps  = ""

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cChave = ALLTRIM(cursor_4c_Dados.cIdChaves)
                loc_cCeps  = ALLTRIM(cursor_4c_Dados.Ceps)
            ENDIF

            IF EMPTY(loc_cChave)
                MsgAviso("Selecione um registro na lista.", "Aviso")
            ELSE
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do CEP " + loc_cCeps + "?", ;
                               "Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("CEP exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEstadosLista - Valida UF digitada e recarrega grid (LostFocus)
    * Espelha logica original: fwBuscaExt em SigCdUfs + seta CodUFs (IBGE)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEstadosLista
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cEstado, loc_oBusca
        loc_cEstado = ""

        TRY
            IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Estados", 5)
                RETURN
            ENDIF

            loc_cEstado = UPPER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Estados.Value))

            IF loc_cEstado == UPPER(ALLTRIM(THIS.this_cUltimoEstadoValidado))
                RETURN
            ENDIF

            THIS.this_cUltimoEstadoValidado = loc_cEstado

            IF EMPTY(loc_cEstado)
                THIS.this_cUfFiltro = ""
                THIS.CarregarLista()
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdUfs", "cursor_4c_BuscaUf", "Estados", loc_cEstado, ;
                    "Selecionar UF")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Estados", "", "UF")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
                        SELECT cursor_4c_BuscaUf
                        loc_cEstado = ALLTRIM(cursor_4c_BuscaUf.Estados)
                    ENDIF

                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaUf")
                    USE IN cursor_4c_BuscaUf
                ENDIF

                IF EMPTY(loc_cEstado)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Estados.Value = ""
                    THIS.this_cUfFiltro = ""
                ELSE
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Estados.Value = loc_cEstado
                    THIS.this_cUfFiltro = loc_cEstado
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.ValidarEstadosLista")
            IF USED("cursor_4c_BuscaUf")
                USE IN cursor_4c_BuscaUf
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtrar por UF (abre picker de UF)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cUf
        loc_cUf = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUfs", "cursor_4c_BuscaUf", "Estados", "", ;
                "Selecionar UF")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Estados", "", "UF")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
                    SELECT cursor_4c_BuscaUf
                    loc_cUf = ALLTRIM(cursor_4c_BuscaUf.Estados)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaUf")
                USE IN cursor_4c_BuscaUf
            ENDIF

            IF !EMPTY(loc_cUf)
                THIS.this_cUfFiltro = loc_cUf
                THIS.this_cUltimoEstadoValidado = loc_cUf
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.BtnBuscarClick")
            IF USED("cursor_4c_BuscaUf")
                USE IN cursor_4c_BuscaUf
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * EVENTOS DOS BOTOES - Page2 (Dados)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar registro (Confirmar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cCeps, loc_cTipo, loc_cNome, loc_cUF
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cCeps = ALLTRIM(loc_oPg2.txt_4c_CEPS.Value)
        loc_cTipo = ALLTRIM(loc_oPg2.txt_4c_TipoNomes.Value)
        loc_cNome = ALLTRIM(loc_oPg2.txt_4c_Nomes.Value)
        loc_cUF   = ALLTRIM(loc_oPg2.txt_4c_Estados.Value)

        *-- Validacoes obrigatorias ANTES do TRY (original: Click handler valida antes de DoDefault)
        IF THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
            IF EMPTY(loc_cCeps)
                MsgAviso("O CEP N" + CHR(227) + "o Pode Ficar Em Branco!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_CEPS.SetFocus()
                RETURN
            ENDIF

            IF EMPTY(loc_cTipo)
                MsgAviso("O Tipo de Endere" + CHR(231) + "o N" + CHR(227) + "o Pode Ficar Em Branco!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_TipoNomes.SetFocus()
                RETURN
            ENDIF

            IF EMPTY(loc_cNome)
                MsgAviso("O Endere" + CHR(231) + "o N" + CHR(227) + "o Pode Ficar Em Branco!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Nomes.SetFocus()
                RETURN
            ENDIF

            *-- Garantir UF preenchida (original: valida getEstados da lista antes de salvar)
            IF EMPTY(loc_cUF) AND !EMPTY(THIS.this_cUfFiltro)
                loc_oPg2.txt_4c_Estados.Value = THIS.this_cUfFiltro
                loc_cUF = THIS.this_cUfFiltro
            ENDIF

            IF EMPTY(loc_cUF)
                MsgAviso("A UF N" + CHR(227) + "o Foi Preenchida!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                THIS.AlternarPagina(1)
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("CEP salvo com sucesso!", "Sucesso")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar e voltar para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CidadesKeyPress - Trata F4 no campo Cidade para abrir lookup
    *--------------------------------------------------------------------------
    PROCEDURE CidadesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupCidades()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CidadesDblClick - DblClick no campo Cidade abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE CidadesDblClick()
        THIS.AbrirLookupCidades()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCidades - Busca municipio em SigCdMun filtrado por UFIBGES
    * Original: getCidades.Valid usa fwBuscaExt em SigCdMun com filtro laFil[UFIBGES]=CodUFs
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCidades()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPg2.txt_4c_Cidades.Enabled
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cSQL, loc_nResult
        loc_cSQL = ""

        TRY
            loc_cSQL = "SELECT Descs FROM SigCdMun ORDER BY Descs"

            IF USED("cursor_4c_BuscaMun")
                USE IN cursor_4c_BuscaMun
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMun")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar munic" + CHR(237) + "pios:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMun"
                    loc_oBusca.this_cTitulo = "Selecionar Cidade"
                    loc_oBusca.mAddColuna("Descs", "", "Cidade")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMun")
                        SELECT cursor_4c_BuscaMun
                        loc_oPg2.txt_4c_Cidades.Value = UPPER(ALLTRIM(cursor_4c_BuscaMun.Descs))
                    ENDIF

                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.AbrirLookupCidades")
        ENDTRY

        IF USED("cursor_4c_BuscaMun")
            USE IN cursor_4c_BuscaMun
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF USED("cursor_4c_BuscaMun")
                USE IN cursor_4c_BuscaMun
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCEP.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
