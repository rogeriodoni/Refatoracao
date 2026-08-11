*==============================================================================
* FormFNF.prg - Formulario de Cadastro de Finalizadoras nao Fiscal
* Migrado de: SIGCDFNF.SCX (frmcadastro)
* Tabela: SIGFINTB | PK: cidchaves
* Colunas grid: imps(Impressora), ordems(Ordem), descrs(Descricao), nfixos(Fixo)
*==============================================================================

DEFINE CLASS FormFNF AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Finalizadoras nao Fiscal"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Finalizadoras n" + CHR(227) + "o Fiscal"

            THIS.this_oBusinessObject = CREATEOBJECT("FNFBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar FNFBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormFNF.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormFNF:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormFNF.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Page1: Cabecalho, Botoes CRUD (5+Encerrar), Grid
    * Layout: cabecalho Top=30, botoes Top=29, grid Top=117 (framework canonico)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho (cntSombra legado): Top=30 (1+29 compensacao PageFrame)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_Op legado): Top=29 (0+29), Left=542
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir: Left=5
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar: Left=80
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar: Left=155
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir: Left=230
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar: Left=305
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (padrao canonico CLAUDE.md #10): Left=917, Width=90
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid lista (Grupo_Grade legado): Top=117 (88+29), Left=26, Width=890
        *-- RecordSource e ColumnCount FORA do WITH (Problema #36)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 4

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
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- Column1: imps (Impressora, 160px)
        WITH loc_oGrid.Column1
            .Width           = 160
            .ReadOnly        = .T.
            .Header1.Caption = "Impressora"
        ENDWITH

        *-- Column2: ordems (Ordem, 80px) alinhado a direita (numerico)
        WITH loc_oGrid.Column2
            .Width           = 80
            .ReadOnly        = .T.
            .Alignment       = 2
            .Header1.Caption = "Ordem"
        ENDWITH

        *-- Column3: descrs (Descricao, 337px)
        WITH loc_oGrid.Column3
            .Width           = 337
            .ReadOnly        = .T.
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- Column4: nfixos (Fixo, 50px) - CheckBox visual para campo 0/1
        WITH loc_oGrid.Column4
            .Width           = 50
            .ReadOnly        = .T.
            .Sparse          = .F.
            .Header1.Caption = "Fixo"
        ENDWITH
        loc_oGrid.Column4.AddObject("Check1", "CheckBox")
        WITH loc_oGrid.Column4.Check1
            .Alignment = 0
            .ReadOnly  = .T.
            .Visible   = .T.
            .Top       = 9
            .Left      = 2
            .Height    = 17
            .Width     = 22
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2: botoes acao + todos os campos do legado
    * Coords = original + 29 (compensacao PageFrame.Top=-29)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Grupo_Salva legado): Top=33 (4+29), Left=842
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva legado): Left=5, Top=5
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar: Left=88, Top=5
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 88
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Say6 (Impressora): Top=162 (133+29), Left=123 ForeColor=RGB(36,84,155)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Impressora : "
            .Top       = 162
            .Left      = 123
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Cmb_Imp (Impressora): Top=158 (129+29), Left=203, Width=105, Height=24
        *-- RowSourceType=0 populado com AddItem (lista fixa do legado)
        loc_oPagina.AddObject("cbo_4c_Imps", "ComboBox")
        WITH loc_oPagina.cbo_4c_Imps
            .Top           = 158
            .Left          = 203
            .Width         = 105
            .Height        = 24
            .RowSourceType = 0
            .RowSource     = ""
            .Style         = 0
            .Value         = ""
            .FontName      = "Verdana"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        *-- Itens identicos ao legado (Init: .AddItem, sem espacos extras)
        loc_oPagina.cbo_4c_Imps.AddItem("DATAREGIS")
        loc_oPagina.cbo_4c_Imps.AddItem("SWEDA")
        loc_oPagina.cbo_4c_Imps.AddItem("BEMATECH")
        loc_oPagina.cbo_4c_Imps.AddItem("BEMA8501")
        loc_oPagina.cbo_4c_Imps.AddItem("NDATAREGIS")
        loc_oPagina.cbo_4c_Imps.AddItem("EPSON")
        loc_oPagina.cbo_4c_Imps.AddItem("DARUMA")
        loc_oPagina.cbo_4c_Imps.AddItem("NSWEDA")
        loc_oPagina.cbo_4c_Imps.AddItem("Em Branco")
        BINDEVENT(loc_oPagina.cbo_4c_Imps, "InteractiveChange", THIS, "ImpInteractiveChange")

        *-- Say1 (Ordem): Top=187 (158+29), Left=150
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Ordem : "
            .Top       = 187
            .Left      = 150
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_ordem (Ordem): Top=184 (155+29), Left=203, Width=24, InputMask="99"
        loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
        WITH loc_oPagina.txt_4c_Ordem
            .Top       = 184
            .Left      = 203
            .Width     = 24
            .Height    = 22
            .Value     = 0
            .InputMask = "99"
            .FontName  = "Verdana"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say4 (Cod.Operacao): Top=212 (183+29), Left=107
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Cod.Opera" + CHR(231) + CHR(227) + "o : "
            .Top       = 212
            .Left      = 107
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Opernf (Cod.Operacao): Top=209 (180+29), Left=203, Width=24, MaxLength=2
        loc_oPagina.AddObject("txt_4c_Opernf", "TextBox")
        WITH loc_oPagina.txt_4c_Opernf
            .Top       = 209
            .Left      = 203
            .Width     = 24
            .Height    = 22
            .Value     = ""
            .MaxLength = 2
            .FontName  = "Verdana"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say5 (Cod.Abertura): Top=212 (183+29), Left=254
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Cod.Abertura : "
            .Top       = 212
            .Left      = 254
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- fwget1 (Cod.Abertura): Top=209 (180+29), Left=346, Width=24, MaxLength=2
        *-- When event do legado: habilitado APENAS para SWEDA/NSWEDA
        loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget1
            .Top       = 209
            .Left      = 346
            .Width     = 24
            .Height    = 22
            .Value     = ""
            .MaxLength = 2
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say2 (Descricao): Top=237 (208+29), Left=133
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 237
            .Left      = 133
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_descr (Descricao): Top=234 (205+29), Left=203, Width=360
        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Top       = 234
            .Left      = 203
            .Width     = 360
            .Height    = 22
            .Value     = ""
            .FontName  = "Verdana"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say3 (Fixo): Top=265 (236+29), Left=166
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Fixo : "
            .Top       = 265
            .Left      = 166
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Opc_fixo (OptionGroup Fixo): Top=260 (231+29), Left=199
        *-- ButtonCount=2: Buttons(1)=Sim, Buttons(2)=Nao; Value=2=Nao (default)
        loc_oPagina.AddObject("opt_4c_Opc_fixo", "OptionGroup")
        WITH loc_oPagina.opt_4c_Opc_fixo
            .ButtonCount = 2
            .Top         = 260
            .Left        = 199
            .Width       = 100
            .Height      = 26
            .Value       = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 47
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Popula cursor via FNFBO.Buscar() e vincula ao Grid
    * Reconfigura Headers APOS RecordSource (Problema #2 FORMCOR_LICOES)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (imps C(20), ordems N(2,0), descrs C(50), nfixos N(1,0))
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- RecordSource FORA de WITH; ControlSource APOS RecordSource (Prob #36/#48)
                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.imps"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.ordems"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.nfixos"

                *-- Redefinir Headers APOS RecordSource (resets ao auto-bind)
                loc_oGrid.Column1.Header1.Caption = "Impressora"
                loc_oGrid.Column2.Header1.Caption = "Ordem"
                loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column4.Header1.Caption = "Fixo"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista (fonte uniforme)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * ImpInteractiveChange - Atualiza ReadOnly de Cod.Abertura (fwget1)
    * Legado: fwget1.When = InList(crSigFiNtb.imps,'SWEDA','NSWEDA')
    * Campo habilitado APENAS quando impressora for SWEDA ou NSWEDA
    *===========================================================================
    PROCEDURE ImpInteractiveChange()
        LOCAL loc_cImps, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cImps   = ""

        IF PEMSTATUS(loc_oPagina, "cbo_4c_Imps", 5)
            loc_cImps = ALLTRIM(NVL(loc_oPagina.cbo_4c_Imps.Value, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Fwget1", 5)
            IF INLIST(loc_cImps, "SWEDA", "NSWEDA")
                loc_oPagina.txt_4c_Fwget1.ReadOnly = .F.
            ELSE
                loc_oPagina.txt_4c_Fwget1.ReadOnly = .T.
                loc_oPagina.txt_4c_Fwget1.Value    = ""
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega dados do grid
    *===========================================================================
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
                THIS.AjustarBotoesPorModo()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara form para inclusao de novo registro
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cImps, loc_nOrdems
        loc_cImps   = ""
        loc_nOrdems = 0

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cImps   = ALLTRIM(cursor_4c_Dados.imps)
            loc_nOrdems = cursor_4c_Dados.ordems
        ENDIF

        IF EMPTY(loc_cImps)
            MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MostrarErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", ;
                        "FormFNF.BtnVisualizarClick")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cImps, loc_nOrdems
        loc_cImps   = ""
        loc_nOrdems = 0

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cImps   = ALLTRIM(cursor_4c_Dados.imps)
            loc_nOrdems = cursor_4c_Dados.ordems
        ENDIF

        IF EMPTY(loc_cImps)
            MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MostrarErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", ;
                        "FormFNF.BtnAlterarClick")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    * Legado valida se ordems esta em uso em SigCdOpe.trnfis (feito no BO)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cImps, loc_nOrdems, loc_lConfirma
        loc_cImps   = ""
        loc_nOrdems = 0
        loc_lConfirma  = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cImps   = ALLTRIM(cursor_4c_Dados.imps)
            loc_nOrdems = cursor_4c_Dados.ordems
        ENDIF

        IF EMPTY(loc_cImps)
            MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
                                    "Confirmar Exclus" + CHR(227) + "o")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                THIS.CarregarLista()
            ENDIF
        ELSE
            MostrarErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", ;
                        "FormFNF.BtnExcluirClick")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega lista completa (busca simples)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva o registro (Confirmar na Page2)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Sucesso")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos do Form para o BO
    * Usa PEMSTATUS para acesso defensivo (campos adicionados na Fase 5)
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "cbo_4c_Imps", 5)
            THIS.this_oBusinessObject.this_cImps = ALLTRIM(NVL(loc_oPagina.cbo_4c_Imps.Value, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordem", 5)
            THIS.this_oBusinessObject.this_nOrdems = NVL(loc_oPagina.txt_4c_Ordem.Value, 0)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Opernf", 5)
            THIS.this_oBusinessObject.this_cOpernf = ALLTRIM(NVL(loc_oPagina.txt_4c_Opernf.Value, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Fwget1", 5)
            THIS.this_oBusinessObject.this_cOpernf2 = ALLTRIM(NVL(loc_oPagina.txt_4c_Fwget1.Value, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(NVL(loc_oPagina.txt_4c_Descr.Value, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "opt_4c_Opc_fixo", 5)
            *-- Database: 1=Sim, 0=Nao (o Value=2 do OptionGroup nao se mapeia para 2 no BD)
            THIS.this_oBusinessObject.this_nNfixos = IIF(loc_oPagina.opt_4c_Opc_fixo.Value = 1, 1, 0)
        ENDIF
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BO para os campos do Form
    * Usa PEMSTATUS para acesso defensivo (campos adicionados na Fase 5)
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "cbo_4c_Imps", 5)
            loc_oPagina.cbo_4c_Imps.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cImps, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordem", 5)
            loc_oPagina.txt_4c_Ordem.Value = NVL(THIS.this_oBusinessObject.this_nOrdems, 0)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Opernf", 5)
            loc_oPagina.txt_4c_Opernf.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cOpernf, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Fwget1", 5)
            loc_oPagina.txt_4c_Fwget1.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cOpernf2, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            loc_oPagina.txt_4c_Descr.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescrs, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "opt_4c_Opc_fixo", 5)
            loc_oPagina.opt_4c_Opc_fixo.Value = IIF(THIS.this_oBusinessObject.this_nNfixos = 1, 1, 2)
        ENDIF

        *-- Atualizar estado Cod.Abertura baseado na impressora carregada
        THIS.ImpInteractiveChange()
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2 (para modo INCLUIR)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "cbo_4c_Imps", 5)
            loc_oPagina.cbo_4c_Imps.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordem", 5)
            loc_oPagina.txt_4c_Ordem.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Opernf", 5)
            loc_oPagina.txt_4c_Opernf.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Fwget1", 5)
            loc_oPagina.txt_4c_Fwget1.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            loc_oPagina.txt_4c_Descr.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Opc_fixo", 5)
            loc_oPagina.opt_4c_Opc_fixo.Value = 2
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEnabled
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEnabled = (par_lHabilitar = .T.)

        IF PEMSTATUS(loc_oPagina, "cbo_4c_Imps", 5)
            loc_oPagina.cbo_4c_Imps.Enabled = loc_lEnabled
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordem", 5)
            loc_oPagina.txt_4c_Ordem.Enabled  = loc_lEnabled
            loc_oPagina.txt_4c_Ordem.ReadOnly = !loc_lEnabled
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Opernf", 5)
            loc_oPagina.txt_4c_Opernf.Enabled  = loc_lEnabled
            loc_oPagina.txt_4c_Opernf.ReadOnly = !loc_lEnabled
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Fwget1", 5)
            IF loc_lEnabled
                *-- Habilitar respeitando regra When do legado (SWEDA/NSWEDA)
                THIS.ImpInteractiveChange()
            ELSE
                loc_oPagina.txt_4c_Fwget1.ReadOnly = .T.
            ENDIF
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            loc_oPagina.txt_4c_Descr.Enabled  = loc_lEnabled
            loc_oPagina.txt_4c_Descr.ReadOnly = !loc_lEnabled
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Opc_fixo", 5)
            loc_oPagina.opt_4c_Opc_fixo.Enabled = loc_lEnabled
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    * Botoes CRUD de Page1 ativos apenas no modo LISTA
    * Confirmar ativo em INCLUIR/ALTERAR; Cancelar sempre ativo em Page2
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lNaLista, loc_lPodeConfirmar
        loc_lNaLista     = (THIS.this_cModoAtual = "LISTA")
        loc_lPodeConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
                    .cmd_4c_Incluir.Enabled    = loc_lNaLista
                    .cmd_4c_Visualizar.Enabled = loc_lNaLista
                    .cmd_4c_Alterar.Enabled    = loc_lNaLista
                    .cmd_4c_Excluir.Enabled    = loc_lNaLista
                    .cmd_4c_Buscar.Enabled     = loc_lNaLista
                    .Visible     = .T.
                ENDWITH
            ENDIF

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lPodeConfirmar
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Percorre Pages de PageFrames e Controls de Containers
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oObjeto
        loc_nP = 0

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

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
