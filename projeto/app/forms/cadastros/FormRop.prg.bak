*==============================================================================
* FormRop.prg
*
* Formulário: Restrições Por Operação
* Tabela: SigCdRpo
* Herda de: FormBase
*
* PageFrame.Top = -31 (compensação +31 em todos os controles)
*==============================================================================

DEFINE CLASS FormRop AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 597
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de negócio
    this_oBusinessObject = .NULL.
    this_cModoAtual      = ""

    *==========================================================================
    * Init - Ponto de entrada do formulário
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormRop:" + CHR(13) + loc_oErro.Message, "FormRop.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa do formulário
    * Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"

            THIS.this_oBusinessObject = CREATEOBJECT("RopBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar RopBO.", "FormRop.InicializarForm")
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
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formulário:" + CHR(13) + loc_oErro.Message, "FormRop.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 páginas (Lista e Dados)
    * Compensação: PageFrame.Top = -31, todos os controles precisam +31 no Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        THIS.pgf_4c_Paginas.PageCount = 2
        WITH THIS.pgf_4c_Paginas
            .Top    = -31
            .Left   = -2
            .Width  = THIS.Width + 4
            .Height = 631
            .Tabs   = .F.
            .Visible = .T.
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page1
            .Caption = "Lista"
            .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page2
            .Caption = "Dados"
            .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 com grid e botões CRUD completos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabeçalho com título
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 32
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption  = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"
            .Top      = 15
            .Left     = 10
            .Width    = THIS.Width - 20
            .Height   = 46
            .FontName = "Tahoma"
            .FontSize = 16
            .FontBold = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible  = .T.
        ENDWITH
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption  = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"
            .Top      = 18
            .Left     = 10
            .Width    = THIS.Width - 20
            .Height   = 46
            .FontName = "Tahoma"
            .FontSize = 16
            .FontBold = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible  = .T.
        ENDWITH

        *-- Container botões CRUD (canônico Left=520, Width=390)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 31
            .Left        =  542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botão Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
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
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botão Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botão Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botão Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
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
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botão Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
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
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canônico Left=917, Width=90)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 31
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
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
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (Top=117 = 86+31 compensação PageFrame)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.ColumnCount = 9
        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 470
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

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 com campos e botões de edição
    * Todos os 10 campos + BINDEVENTs de lookup (F4/LostFocus) completos
    * Compensação PageFrame.Top=-31: todos os Tops somam +31
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botões Confirmar/Cancelar (canônico: Top=51, Left=842)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 51
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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
            .WordWrap        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *====================================================================
        *-- CAMPO 1: Operação de Produção (Get_Dopp) - original top=98 -> 129
        *====================================================================
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Top       = 133
            .Left      = 242
            .Width     = 85
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dopp", "TextBox")
        WITH loc_oPagina.txt_4c_Dopp
            .Value       = ""
            .Top         = 129
            .Left        = 328
            .Width       = 150
            .Height      = 23
            .MaxLength   = 20
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dopp, "KeyPress", THIS, "ValidarDopp")
        BINDEVENT(loc_oPagina.txt_4c_Dopp, "KeyPress",  THIS, "TeclaPressionadaDopp")

        *====================================================================
        *-- CAMPO 2: Tipo de Material (Get_Tpop) - original top=124 -> 155
        *====================================================================
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o :"
            .Top       = 159
            .Left      = 204
            .Width     = 120
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tpop", "TextBox")
        WITH loc_oPagina.txt_4c_Tpop
            .Value       = ""
            .Top         = 155
            .Left        = 328
            .Width       = 115
            .Height      = 23
            .MaxLength   = 15
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Tpop, "KeyPress", THIS, "ValidarTpop")
        BINDEVENT(loc_oPagina.txt_4c_Tpop, "KeyPress",  THIS, "TeclaPressionadaTpop")

        *====================================================================
        *-- CAMPO 3: Grupo de Produto - código (get_Cgru) + desc (get_ds_grupo)
        *-- original top=150 -> 181
        *====================================================================
        loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_grupo
            .Caption   = "Grupo de Produto :"
            .Top       = 154
            .Left      = 226
            .Width     = 94
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__Cgru", "TextBox")
        WITH loc_oPagina.txt_4c__Cgru
            .Value       = ""
            .Top         = 181
            .Left        = 328
            .Width       = 31
            .Height      = 23
            .MaxLength   = 3
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c__Cgru, "KeyPress", THIS, "ValidarCgru")
        BINDEVENT(loc_oPagina.txt_4c__Cgru, "KeyPress",  THIS, "TeclaPressionadaCgru")

        loc_oPagina.AddObject("txt_4c__ds_grupo", "TextBox")
        WITH loc_oPagina.txt_4c__ds_grupo
            .Value       = ""
            .Top         = 181
            .Left        = 361
            .Width       = 213
            .Height      = 23
            .MaxLength   = 50
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c__ds_grupo, "KeyPress", THIS, "ValidarDsGrupo")

        *====================================================================
        *-- CAMPO 4: Operação Estoque E/S (Get_OpPad) - original top=177 -> 208
        *====================================================================
        loc_oPagina.AddObject("lbl_4c_Label39", "Label")
        WITH loc_oPagina.lbl_4c_Label39
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o Estoque :"
            .Top       = 211
            .Left      = 222
            .Width     = 98
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label40", "Label")
        WITH loc_oPagina.lbl_4c_Label40
            .Caption   = "(E / S)"
            .Top       = 211
            .Left      = 352
            .Width     = 32
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_OpPad", "TextBox")
        WITH loc_oPagina.txt_4c_OpPad
            .Value       = ""
            .Top         = 208
            .Left        = 328
            .Width       = 17
            .Height      = 20
            .MaxLength   = 1
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_OpPad, "KeyPress", THIS, "ValidarOpPad")

        *====================================================================
        *-- CAMPO 5: Grande Grupo (Get_gde) - original top=200 -> 231
        *-- Label lbl_gde_grupo: original top=204 -> 235
        *====================================================================
        loc_oPagina.AddObject("txt_4c_Gde", "TextBox")
        WITH loc_oPagina.txt_4c_Gde
            .Value       = ""
            .Top         = 231
            .Left        = 328
            .Width       = 33
            .Height      = 23
            .MaxLength   = 3
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Gde, "KeyPress", THIS, "ValidarGde")
        BINDEVENT(loc_oPagina.txt_4c_Gde, "KeyPress",  THIS, "TeclaPressionadaGde")

        loc_oPagina.AddObject("lbl_4c_Lbl_gde_grupo", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_gde_grupo
            .Caption   = "Grande Grupo :"
            .Top       = 204
            .Left      = 244
            .Width     = 76
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *====================================================================
        *-- CAMPO 6: Grupo Contábil código (Get_Grupos) + desc (Get_Dgrupos)
        *-- original top=226 -> 257 | Say4 original top=230 -> 261
        *====================================================================
        loc_oPagina.AddObject("lbl_4c_Say4", "Label")
        WITH loc_oPagina.lbl_4c_Say4
            .Caption   = "Grupo :"
            .Top       = 230
            .Left      = 282
            .Width     = 43
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value       = ""
            .Top         = 257
            .Left        = 328
            .Width       = 80
            .Height      = 23
            .MaxLength   = 10
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupos")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "TeclaPressionadaGrupos")

        loc_oPagina.AddObject("txt_4c_Dgrupos", "TextBox")
        WITH loc_oPagina.txt_4c_Dgrupos
            .Value       = ""
            .Top         = 257
            .Left        = 411
            .Width       = 162
            .Height      = 23
            .MaxLength   = 50
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dgrupos, "KeyPress", THIS, "ValidarDgrupos")

        *====================================================================
        *-- CAMPO 7: Conta Destino (Get_Conta) - original top=252 -> 283
        *-- Say34 original top=255 -> 286
        *====================================================================
        loc_oPagina.AddObject("lbl_4c_Say34", "Label")
        WITH loc_oPagina.lbl_4c_Say34
            .Caption   = "Conta Destino :"
            .Top       = 255
            .Left      = 243
            .Width     = 82
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Value       = ""
            .Top         = 283
            .Left        = 328
            .Width       = 80
            .Height      = 21
            .MaxLength   = 10
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress",  THIS, "TeclaPressionadaConta")

        *====================================================================
        *-- CAMPO 8: Conta Origem (Get_ContaOrig) - original top=276 -> 307
        *-- Say3 original top=279 -> 310
        *====================================================================
        loc_oPagina.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oPagina.lbl_4c_Say3
            .Caption   = "Conta Origem :"
            .Top       = 279
            .Left      = 245
            .Width     = 80
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ContaOrig", "TextBox")
        WITH loc_oPagina.txt_4c_ContaOrig
            .Value       = ""
            .Top         = 307
            .Left        = 328
            .Width       = 80
            .Height      = 21
            .MaxLength   = 10
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_ContaOrig, "KeyPress", THIS, "ValidarContaOrig")
        BINDEVENT(loc_oPagina.txt_4c_ContaOrig, "KeyPress",  THIS, "TeclaPressionadaContaOrig")

        *====================================================================
        *-- CAMPO 9: Cor (getCor/SigCdCor.Cods) - original top=300 -> 331
        *-- Say42 original top=304 -> 335
        *====================================================================
        loc_oPagina.AddObject("lbl_4c_Say42", "Label")
        WITH loc_oPagina.lbl_4c_Say42
            .Caption   = "Cor :"
            .Top       = 304
            .Left      = 294
            .Width     = 31
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cor", "TextBox")
        WITH loc_oPagina.txt_4c_Cor
            .Value       = ""
            .Top         = 331
            .Left        = 328
            .Width       = 38
            .Height      = 23
            .MaxLength   = 6
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Cor, "KeyPress", THIS, "ValidarCor")
        BINDEVENT(loc_oPagina.txt_4c_Cor, "KeyPress",  THIS, "TeclaPressionadaCor")

        *====================================================================
        *-- CAMPO 10: Exclusivo (opt_Exclusivo) - original top=325 -> 356
        *-- Say6 original top=329 -> 360
        *====================================================================
        loc_oPagina.AddObject("lbl_4c_Say6", "Label")
        WITH loc_oPagina.lbl_4c_Say6
            .Caption   = "Exclusivo :"
            .Top       = 329
            .Left      = 267
            .Width     = 53
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opt_Exclusivo", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opt_Exclusivo
            .Top         = 325
            .Left        = 326
            .Width       = 86
            .Height      = 23
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_Exclusivo.Option1
            .Caption   = "Sim"
            .Left      = 2
            .Top       = 4
            .Width     = 34
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_Exclusivo.Option2
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 44
            .Top       = 4
            .Width     = 37
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados do BO no grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 9
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dopps"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.tpops"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.opers"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.mercs"
                    loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.grupos"
                    loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.contas"
                    loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.contaorig"
                    loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.codcors"

                    loc_oGrid.Column1.Width = 150
                    loc_oGrid.Column2.Width = 120
                    loc_oGrid.Column3.Width = 80
                    loc_oGrid.Column4.Width = 60
                    loc_oGrid.Column5.Width = 80
                    loc_oGrid.Column6.Width = 80
                    loc_oGrid.Column7.Width = 100
                    loc_oGrid.Column8.Width = 100
                    loc_oGrid.Column9.Width = 60

                    loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column2.Header1.Caption = "Tipo de Material"
                    loc_oGrid.Column3.Header1.Caption = "Grp.Produto"
                    loc_oGrid.Column4.Header1.Caption = "Op.Est."
                    loc_oGrid.Column5.Header1.Caption = "Grande Grp."
                    loc_oGrid.Column6.Header1.Caption = "Gr.Conta"
                    loc_oGrid.Column7.Header1.Caption = "Conta Dest."
                    loc_oGrid.Column8.Header1.Caption = "Conta Orig."
                    loc_oGrid.Column9.Header1.Caption = "Cor"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormRop.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.CarregarLista()
                THIS.this_cModoAtual = "LISTA"
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visíveis recursivamente
    *==========================================================================
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

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia inclusão de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre registro selecionado para edição
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado após confirmação
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_lConfirmado
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF
        loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
        IF !loc_lConfirmado
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista (busca geral)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulário
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva o registro atual (botão Confirmar)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()
        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edição e retorna para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do formulário para o Business Object
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cDopps    = ALLTRIM(loc_oPagina.txt_4c_Dopp.Value)
        THIS.this_oBusinessObject.this_cTpops    = ALLTRIM(loc_oPagina.txt_4c_Tpop.Value)
        THIS.this_oBusinessObject.this_cCgrus    = ALLTRIM(loc_oPagina.txt_4c__Cgru.Value)
        THIS.this_oBusinessObject.this_cOpers    = ALLTRIM(loc_oPagina.txt_4c_OpPad.Value)
        THIS.this_oBusinessObject.this_cMercs    = ALLTRIM(loc_oPagina.txt_4c_Gde.Value)
        THIS.this_oBusinessObject.this_cGrupos   = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cContas   = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
        THIS.this_oBusinessObject.this_cContaorig = ALLTRIM(loc_oPagina.txt_4c_ContaOrig.Value)
        THIS.this_oBusinessObject.this_cCodcors  = ALLTRIM(loc_oPagina.txt_4c_Cor.Value)
        THIS.this_oBusinessObject.this_nExclus   = ;
            IIF(loc_oPagina.obj_4c_Opt_Exclusivo.Value = 1, 1, 2)
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do Business Object para o formulário
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_cSQL, loc_nResult
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Dopp.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cDopps)
        loc_oPagina.txt_4c_Tpop.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cTpops)
        loc_oPagina.txt_4c__Cgru.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cCgrus)
        loc_oPagina.txt_4c_OpPad.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cOpers)
        loc_oPagina.txt_4c_Gde.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cMercs)
        loc_oPagina.txt_4c_Conta.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
        loc_oPagina.txt_4c_ContaOrig.Value = ALLTRIM(THIS.this_oBusinessObject.this_cContaorig)
        loc_oPagina.txt_4c_Cor.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cCodcors)
        loc_oPagina.obj_4c_Opt_Exclusivo.Value = ;
            IIF(THIS.this_oBusinessObject.this_nExclus = 1, 1, 2)

        *-- Carregar descrição do Grupo de Produto via SigCdGrp
        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCgrus))
            loc_cSQL = "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
                EscaparSQL(THIS.this_oBusinessObject.this_cCgrus)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDesc")
            IF loc_nResult >= 0 AND USED("cursor_4c_GrupoDesc") AND !EOF("cursor_4c_GrupoDesc")
                SELECT cursor_4c_GrupoDesc
                loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_GrupoDesc.DGrus)
            ELSE
                loc_oPagina.txt_4c__ds_grupo.Value = ""
            ENDIF
            IF USED("cursor_4c_GrupoDesc")
                USE IN cursor_4c_GrupoDesc
            ENDIF
        ELSE
            loc_oPagina.txt_4c__ds_grupo.Value = ""
        ENDIF

        *-- Carregar descrição do Grupo Contábil via SigCdGcr
        loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cGrupos))
            loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                EscaparSQL(THIS.this_oBusinessObject.this_cGrupos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposDesc")
            IF loc_nResult >= 0 AND USED("cursor_4c_GruposDesc") AND !EOF("cursor_4c_GruposDesc")
                SELECT cursor_4c_GruposDesc
                loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_GruposDesc.Descrs)
            ELSE
                loc_oPagina.txt_4c_Dgrupos.Value = ""
            ENDIF
            IF USED("cursor_4c_GruposDesc")
                USE IN cursor_4c_GruposDesc
            ENDIF
        ELSE
            loc_oPagina.txt_4c_Dgrupos.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Dopp.Value          = ""
        loc_oPagina.txt_4c_Tpop.Value          = ""
        loc_oPagina.txt_4c__Cgru.Value         = ""
        loc_oPagina.txt_4c__ds_grupo.Value     = ""
        loc_oPagina.txt_4c_OpPad.Value         = ""
        loc_oPagina.txt_4c_Gde.Value           = ""
        loc_oPagina.txt_4c_Grupo.Value         = ""
        loc_oPagina.txt_4c_Dgrupos.Value       = ""
        loc_oPagina.txt_4c_Conta.Value         = ""
        loc_oPagina.txt_4c_ContaOrig.Value     = ""
        loc_oPagina.txt_4c_Cor.Value           = ""
        loc_oPagina.obj_4c_Opt_Exclusivo.Value = 2
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edição (Page2)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lReadOnly
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lReadOnly = !par_lHabilitar

        loc_oPagina.txt_4c_Dopp.ReadOnly          = loc_lReadOnly
        loc_oPagina.txt_4c_Tpop.ReadOnly          = loc_lReadOnly
        loc_oPagina.txt_4c__Cgru.ReadOnly         = loc_lReadOnly
        loc_oPagina.txt_4c__ds_grupo.ReadOnly     = loc_lReadOnly
        loc_oPagina.txt_4c_OpPad.ReadOnly         = loc_lReadOnly
        loc_oPagina.txt_4c_Gde.ReadOnly           = loc_lReadOnly
        loc_oPagina.txt_4c_Grupo.ReadOnly         = loc_lReadOnly
        loc_oPagina.txt_4c_Dgrupos.ReadOnly       = loc_lReadOnly
        loc_oPagina.txt_4c_Conta.ReadOnly         = loc_lReadOnly
        loc_oPagina.txt_4c_ContaOrig.ReadOnly     = loc_lReadOnly
        loc_oPagina.txt_4c_Cor.ReadOnly           = loc_lReadOnly
        loc_oPagina.obj_4c_Opt_Exclusivo.Enabled  = par_lHabilitar

        *-- Confirmar habilitado em modo edição ou exclusão
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
            par_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
    ENDPROC

    *==========================================================================
    * ValidarDopp - Valida campo Operação ao perder foco
    * Original Get_Dopp.Valid: Seek em TmpOpe (cursor SigCdRpo.Dopps)
    *==========================================================================
    PROCEDURE ValidarDopp(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDopp
        loc_cDopp = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dopp.Value)

        IF EMPTY(loc_cDopp)
            RETURN
        ENDIF

        *-- Verificar em cursor_4c_Dados (já carregado) antes de abrir browse
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR UPPER(ALLTRIM(dopps)) = UPPER(loc_cDopp)
            IF FOUND()
                THIS.pgf_4c_Paginas.Page2.txt_4c_Dopp.Value = ALLTRIM(cursor_4c_Dados.dopps)
                RETURN
            ENDIF
        ENDIF

        THIS.AbrirBuscaDopp()
    ENDPROC

    *==========================================================================
    * TeclaPressionadaDopp - Captura F4 em txt_4c_Dopp para abrir busca
    *==========================================================================
    PROCEDURE TeclaPressionadaDopp(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaDopp()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaDopp - Abre FormBuscaAuxiliar para selecionar Operação
    * Equivalente a fwBuscaSel em TmpOpe (distinct Dopps de SigCdRpo)
    *==========================================================================
    PROCEDURE AbrirBuscaDopp()
        LOCAL loc_cSQL, loc_nResult, loc_oBusca
        TRY
            loc_cSQL = "SELECT DISTINCT RTRIM(Dopps) AS Dopps" + ;
                " FROM SigCdRpo ORDER BY Dopps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDopp")

            IF loc_nResult >= 0 AND USED("cursor_4c_BuscaDopp")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDopp"
                    loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
                    loc_oBusca.mAddColuna("Dopps", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDopp")
                        SELECT cursor_4c_BuscaDopp
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Dopp.Value = ALLTRIM(cursor_4c_BuscaDopp.Dopps)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de opera" + CHR(231) + CHR(245) + "es:" + ;
                CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaDopp")
        ENDTRY
        IF USED("cursor_4c_BuscaDopp")
            USE IN cursor_4c_BuscaDopp
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarTpop - Valida campo Tipo de Material ao perder foco
    * Original Get_Tpop.Valid: Seek em TmpOpt (SigOpOpt Where Not Situas=2)
    *==========================================================================
    PROCEDURE ValidarTpop(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cTpop, loc_cSQL, loc_nResult
        loc_cTpop = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value)

        IF EMPTY(loc_cTpop)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Cods FROM SigOpOpt" + ;
                " WHERE RTRIM(Cods) = " + EscaparSQL(loc_cTpop) + ;
                " AND NOT Situas = 2"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTpop")

            IF loc_nResult >= 0 AND USED("cursor_4c_ChkTpop")
                SELECT cursor_4c_ChkTpop
                IF !EOF("cursor_4c_ChkTpop")
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value = ALLTRIM(cursor_4c_ChkTpop.Cods)
                ELSE
                    USE IN cursor_4c_ChkTpop
                    THIS.AbrirBuscaTpop()
                ENDIF
                IF USED("cursor_4c_ChkTpop")
                    USE IN cursor_4c_ChkTpop
                ENDIF
            ELSE
                MsgErro("Erro ao validar tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar tipo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarTpop")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TeclaPressionadaTpop - Captura F4 em txt_4c_Tpop para abrir busca
    *==========================================================================
    PROCEDURE TeclaPressionadaTpop(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaTpop()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaTpop - Abre FormBuscaAuxiliar para Tipo de Material
    * Original: fwBuscaSel em TmpOpt (SigOpOpt Where Not Situas=2)
    *==========================================================================
    PROCEDURE AbrirBuscaTpop()
        LOCAL loc_cTpop, loc_cSQL, loc_nResult, loc_oBusca
        loc_cTpop = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value)

        TRY
            loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt" + ;
                " WHERE NOT Situas = 2 ORDER BY Cods"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTpop")

            IF loc_nResult >= 0 AND USED("cursor_4c_BuscaTpop")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTpop"
                    loc_oBusca.this_cTitulo = "Tipos de Opera" + CHR(231) + CHR(227) + "o"
                    loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpop")
                        SELECT cursor_4c_BuscaTpop
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value = ALLTRIM(cursor_4c_BuscaTpop.Cods)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Erro ao carregar tipos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de tipos:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaTpop")
        ENDTRY
        IF USED("cursor_4c_BuscaTpop")
            USE IN cursor_4c_BuscaTpop
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCgru - Valida código do Grupo de Produto ao perder foco
    * Original get_Cgru.Valid: fwBuscaExt em SigCdGrp por CGrus
    * Após seleção: atualiza txt_4c__ds_grupo com DGrus
    *==========================================================================
    PROCEDURE ValidarCgru(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCgru
        loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value)

        IF EMPTY(loc_cCgru)
            THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ""
            RETURN
        ENDIF

        THIS.AbrirBuscaCgru()
    ENDPROC

    *==========================================================================
    * TeclaPressionadaCgru - Captura F4 em txt_4c__Cgru para abrir busca
    *==========================================================================
    PROCEDURE TeclaPressionadaCgru(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaCgru()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaCgru - Abre FormBuscaAuxiliar para Grupo de Produto
    * Tabela: SigCdGrp | Código: CGrus | Descrição: DGrus
    * Após seleção: preenche ambos txt_4c__Cgru e txt_4c__ds_grupo
    *==========================================================================
    PROCEDURE AbrirBuscaCgru()
        LOCAL loc_cCgru, loc_oBusca
        loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaCgru", "CGrus", loc_cCgru, ;
                "Grupos de Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCgru")
                    SELECT cursor_4c_BuscaCgru
                    THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ALLTRIM(cursor_4c_BuscaCgru.CGrus)
                    THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_BuscaCgru.DGrus)
                ELSE
                    THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = " "
                    THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaCgru")
        ENDTRY
        IF USED("cursor_4c_BuscaCgru")
            USE IN cursor_4c_BuscaCgru
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDsGrupo - Valida descrição do Grupo de Produto ao perder foco
    * Original get_ds_grupo.Valid: fwBuscaExt em SigCdGrp por DGrus (bidirecional)
    * Após seleção: preenche txt_4c__Cgru com CGrus correspondente
    *==========================================================================
    PROCEDURE ValidarDsGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDesc, loc_oBusca
        loc_cDesc = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value)

        IF EMPTY(loc_cDesc)
            THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaDsGrp", "DGrus", loc_cDesc, ;
                "Grupos de Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDsGrp")
                    SELECT cursor_4c_BuscaDsGrp
                    THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ALLTRIM(cursor_4c_BuscaDsGrp.CGrus)
                    THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_BuscaDsGrp.DGrus)
                ELSE
                    THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo por descri" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "FormRop.ValidarDsGrupo")
        ENDTRY
        IF USED("cursor_4c_BuscaDsGrp")
            USE IN cursor_4c_BuscaDsGrp
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarOpPad - Valida campo Operação Estoque ao perder foco
    * Original Get_OpPad.Valid: aceita apenas E, S ou espaço
    *==========================================================================
    PROCEDURE ValidarOpPad(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cOpPad
        loc_cOpPad = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_OpPad.Value)

        IF !EMPTY(loc_cOpPad) AND !INLIST(UPPER(loc_cOpPad), "E", "S")
            MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
                "Digite Apenas [E] ou [S] ou [ ] !!!")
            THIS.pgf_4c_Paginas.Page2.txt_4c_OpPad.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarGde - Valida campo Grande Grupo ao perder foco
    * Original Get_gde.Valid: fwBuscaExt em SigCdGpr por codigos
    *==========================================================================
    PROCEDURE ValidarGde(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGde
        loc_cGde = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value)

        IF EMPTY(loc_cGde)
            RETURN
        ENDIF

        THIS.AbrirBuscaGde()
    ENDPROC

    *==========================================================================
    * TeclaPressionadaGde - Captura F4 em txt_4c_Gde para abrir busca
    *==========================================================================
    PROCEDURE TeclaPressionadaGde(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaGde()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaGde - Abre FormBuscaAuxiliar para Grande Grupo
    * Tabela: SigCdGpr | Código: codigos | Descrição: descs
    *==========================================================================
    PROCEDURE AbrirBuscaGde()
        LOCAL loc_cGde, loc_oBusca
        loc_cGde = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGde", "codigos", loc_cGde, ;
                "Grandes Grupos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGde")
                    SELECT cursor_4c_BuscaGde
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value = ALLTRIM(cursor_4c_BuscaGde.codigos)
                ELSE
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grande grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaGde")
        ENDTRY
        IF USED("cursor_4c_BuscaGde")
            USE IN cursor_4c_BuscaGde
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarGrupos - Valida código do Grupo Contábil ao perder foco
    * Tabela: SigCdGcr | Código: Codigos | Descrição: Descrs
    * Após seleção: preenche ambos txt_4c_Grupo e txt_4c_Dgrupos
    *==========================================================================
    PROCEDURE ValidarGrupos(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupos, loc_cSQL, loc_nResult, loc_oPagina, loc_lAbriuBusca
        loc_oPagina     = THIS.pgf_4c_Paginas.Page2
        loc_cGrupos     = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_lAbriuBusca = .F.

        IF EMPTY(loc_cGrupos)
            loc_oPagina.txt_4c_Dgrupos.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = " + ;
                EscaparSQL(loc_cGrupos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkGrupos")
            IF loc_nResult >= 0 AND USED("cursor_4c_ChkGrupos")
                SELECT cursor_4c_ChkGrupos
                IF !EOF("cursor_4c_ChkGrupos")
                    loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_ChkGrupos.Codigos)
                    loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_ChkGrupos.Descrs)
                ELSE
                    loc_lAbriuBusca = .T.
                ENDIF
                IF USED("cursor_4c_ChkGrupos")
                    USE IN cursor_4c_ChkGrupos
                ENDIF
            ELSE
                MsgErro("Erro ao validar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarGrupos")
        ENDTRY

        IF loc_lAbriuBusca
            THIS.AbrirBuscaGrupos()
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaPressionadaGrupos - Captura F4 em txt_4c_Grupo para abrir busca
    *==========================================================================
    PROCEDURE TeclaPressionadaGrupos(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaGrupos()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupos - Abre FormBuscaAuxiliar para Grupo Contábil
    * Tabela: SigCdGcr | Código: Codigos | Descrição: Descrs
    * Após seleção: preenche txt_4c_Grupo e txt_4c_Dgrupos
    *==========================================================================
    PROCEDURE AbrirBuscaGrupos()
        LOCAL loc_cGrupos, loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupos", "Codigos", loc_cGrupos, ;
                "Grupos Cont" + CHR(225) + "beis")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupos")
                    SELECT cursor_4c_BuscaGrupos
                    loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaGrupos.Codigos)
                    loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_BuscaGrupos.Descrs)
                ELSE
                    loc_oPagina.txt_4c_Grupo.Value   = ""
                    loc_oPagina.txt_4c_Dgrupos.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaGrupos")
        ENDTRY
        IF USED("cursor_4c_BuscaGrupos")
            USE IN cursor_4c_BuscaGrupos
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDgrupos - Valida descrição do Grupo Contábil ao perder foco
    * Busca bidirecional em SigCdGcr por Descrs; preenche txt_4c_Grupo com código
    *==========================================================================
    PROCEDURE ValidarDgrupos(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDesc, loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cDesc   = ALLTRIM(loc_oPagina.txt_4c_Dgrupos.Value)

        IF EMPTY(loc_cDesc)
            loc_oPagina.txt_4c_Grupo.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaDgrupos", "Descrs", loc_cDesc, ;
                "Grupos Cont" + CHR(225) + "beis")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDgrupos")
                    SELECT cursor_4c_BuscaDgrupos
                    loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaDgrupos.Codigos)
                    loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_BuscaDgrupos.Descrs)
                ELSE
                    loc_oPagina.txt_4c_Grupo.Value   = ""
                    loc_oPagina.txt_4c_Dgrupos.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarDgrupos")
        ENDTRY
        IF USED("cursor_4c_BuscaDgrupos")
            USE IN cursor_4c_BuscaDgrupos
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarConta - Valida código de Conta Destino ao perder foco
    * Tabela: SigCdCli | Código: IClis
    *==========================================================================
    PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cConta, loc_cSQL, loc_nResult, loc_oPagina, loc_lAbriuBusca
        loc_oPagina     = THIS.pgf_4c_Paginas.Page2
        loc_cConta      = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
        loc_lAbriuBusca = .F.

        IF EMPTY(loc_cConta)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT IClis FROM SigCdCli WHERE RTRIM(IClis) = " + ;
                EscaparSQL(loc_cConta)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
            IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
                SELECT cursor_4c_ChkConta
                IF !EOF("cursor_4c_ChkConta")
                    loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_ChkConta.IClis)
                ELSE
                    loc_lAbriuBusca = .T.
                ENDIF
                IF USED("cursor_4c_ChkConta")
                    USE IN cursor_4c_ChkConta
                ENDIF
            ELSE
                MsgErro("Erro ao validar conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar conta:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarConta")
        ENDTRY

        IF loc_lAbriuBusca
            THIS.AbrirBuscaConta()
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaPressionadaConta - Captura F4 em txt_4c_Conta para abrir busca
    *==========================================================================
    PROCEDURE TeclaPressionadaConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaConta()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaConta - Abre FormBuscaAuxiliar para Conta Destino
    * Tabela: SigCdCli | Código: IClis | Descrição: Nomes
    *==========================================================================
    PROCEDURE AbrirBuscaConta()
        LOCAL loc_cSQL, loc_nResult, loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cSQL = "SELECT TOP 500 RTRIM(IClis) AS IClis, RTRIM(Nomes) AS Nomes" + ;
                " FROM SigCdCli ORDER BY IClis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nResult >= 0 AND USED("cursor_4c_BuscaConta")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
                    loc_oBusca.this_cTitulo = "Contas"
                    loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Nomes",  "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Erro ao carregar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de contas:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaConta")
        ENDTRY
        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarContaOrig - Valida código de Conta Origem ao perder foco
    * Tabela: SigCdCli | Código: IClis
    *==========================================================================
    PROCEDURE ValidarContaOrig(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cConta, loc_cSQL, loc_nResult, loc_oPagina, loc_lAbriuBusca
        loc_oPagina     = THIS.pgf_4c_Paginas.Page2
        loc_cConta      = ALLTRIM(loc_oPagina.txt_4c_ContaOrig.Value)
        loc_lAbriuBusca = .F.

        IF EMPTY(loc_cConta)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT IClis FROM SigCdCli WHERE RTRIM(IClis) = " + ;
                EscaparSQL(loc_cConta)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkContaOrig")
            IF loc_nResult >= 0 AND USED("cursor_4c_ChkContaOrig")
                SELECT cursor_4c_ChkContaOrig
                IF !EOF("cursor_4c_ChkContaOrig")
                    loc_oPagina.txt_4c_ContaOrig.Value = ALLTRIM(cursor_4c_ChkContaOrig.IClis)
                ELSE
                    loc_lAbriuBusca = .T.
                ENDIF
                IF USED("cursor_4c_ChkContaOrig")
                    USE IN cursor_4c_ChkContaOrig
                ENDIF
            ELSE
                MsgErro("Erro ao validar conta origem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar conta origem:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarContaOrig")
        ENDTRY

        IF loc_lAbriuBusca
            THIS.AbrirBuscaContaOrig()
        ENDIF
    ENDPROC

    *==========================================================================
    * TeclaPressionadaContaOrig - Captura F4 em txt_4c_ContaOrig para abrir busca
    *==========================================================================
    PROCEDURE TeclaPressionadaContaOrig(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaContaOrig()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaContaOrig - Abre FormBuscaAuxiliar para Conta Origem
    * Tabela: SigCdCli | Código: IClis | Descrição: Nomes
    *==========================================================================
    PROCEDURE AbrirBuscaContaOrig()
        LOCAL loc_cSQL, loc_nResult, loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cSQL = "SELECT TOP 500 RTRIM(IClis) AS IClis, RTRIM(Nomes) AS Nomes" + ;
                " FROM SigCdCli ORDER BY IClis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaContaOrig")

            IF loc_nResult >= 0 AND USED("cursor_4c_BuscaContaOrig")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaContaOrig"
                    loc_oBusca.this_cTitulo = "Contas"
                    loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Nomes",  "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaOrig")
                        SELECT cursor_4c_BuscaContaOrig
                        loc_oPagina.txt_4c_ContaOrig.Value = ALLTRIM(cursor_4c_BuscaContaOrig.IClis)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Erro ao carregar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir busca de contas:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaContaOrig")
        ENDTRY
        IF USED("cursor_4c_BuscaContaOrig")
            USE IN cursor_4c_BuscaContaOrig
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCor - Valida código de Cor ao perder foco
    * Tabela: SigCdCor | Código: Cods
    *==========================================================================
    PROCEDURE ValidarCor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCor    = ALLTRIM(loc_oPagina.txt_4c_Cor.Value)

        IF EMPTY(loc_cCor)
            RETURN
        ENDIF

        THIS.AbrirBuscaCor()
    ENDPROC

    *==========================================================================
    * TeclaPressionadaCor - Captura F4 em txt_4c_Cor para abrir busca
    *==========================================================================
    PROCEDURE TeclaPressionadaCor(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaCor()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaCor - Abre FormBuscaAuxiliar para Cor
    * Tabela: SigCdCor | Código: Cods | Descrição: Descs
    *==========================================================================
    PROCEDURE AbrirBuscaCor()
        LOCAL loc_cCor, loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCor    = ALLTRIM(loc_oPagina.txt_4c_Cor.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "cursor_4c_BuscaCor", "Cods", loc_cCor, ;
                "Cores")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
                    SELECT cursor_4c_BuscaCor
                    loc_oPagina.txt_4c_Cor.Value = ALLTRIM(cursor_4c_BuscaCor.Cods)
                ELSE
                    loc_oPagina.txt_4c_Cor.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar cor:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaCor")
        ENDTRY
        IF USED("cursor_4c_BuscaCor")
            USE IN cursor_4c_BuscaCor
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta botões da Page2 conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        DO CASE
            CASE THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            OTHERWISE
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDCASE
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulário
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
