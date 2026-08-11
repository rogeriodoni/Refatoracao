*==============================================================================
* FormInf.prg - Formulario de Cadastro de Informacoes Complementares
* Migrado de: SigCdInf.SCX (frmcadastro)
* Tabela principal : SigPrInf (Infos C(1), Descrs C(15))
* Tabela secundaria: SigEmInf (Infos FK, Emps C(5), PercEmps N(6,2))
*==============================================================================

DEFINE CLASS FormInf AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Informacoes Complementares"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Cadastro de Informa" + CHR(231) + CHR(245) + ;
                           "es Complementares"

            THIS.this_oBusinessObject = CREATEOBJECT("InfBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar InfBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormInf.InicializarForm")
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

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormInf:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormInf.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles internos compensam +29 no Top
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
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * FASE 3: Containers cabecalho, botoes e saida (grid/botoes CRUD na Fase 4)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra no legado)
        *-- Top original=2 + compensacao PageFrame (+29) = 31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .AutoSize  = .F.
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .AutoSize  = .F.
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op no legado: Left=345, Top=-1, Width=384)
        *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
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

        *-- Container saida - PADRAO CANONICO (Left=917, Width=90, Height=85)
        *-- Legado: Grupo_Saida.Left=719, Top=-1 -> Ignorado (regra #10 CLAUDE.md)
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

        *-- Botoes dentro de cnt_4c_Botoes (5 botoes CRUD)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Encerrar no container saida (padrao canonico)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid de lista SigPrInf (Top=117: 88+29 compensacao PageFrame)
        *-- RecordSource/ColumnCount FORA do WITH (Problem36: colunas criadas imediatamente)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 2

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 490
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
            .Column1.Width              = 60
            .Column1.Header1.Caption    = ""
            .Column2.Width              = 820
            .Column2.Header1.Caption    = ""
        ENDWITH

        *-- BINDEVENTs dos botoes CRUD (metodos PUBLIC - Problem17)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click",   THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click",   THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click",   THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click",   THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click",   THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click",   THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.grd_4c_Lista,                    "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Fase 5: labels + TextBoxes (Infos/Descrs) + botoes Confirmar/Cancelar
    * Fase 6: grid de empresas + botoes inserir/excluir do grid
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cursor local para o grid de empresas (equivalente a xEmInf do legado)
        *-- Estrutura minima: Emps + PercEmps (Infos passado como parametro em SalvarEmpresas)
        IF USED("cursor_4c_Emps")
            USE IN cursor_4c_Emps
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Emps (Emps C(3), PercEmps N(5,2))
        SET NULL OFF
        APPEND BLANK IN cursor_4c_Emps

        *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
        *-- Framework canonico: Top=33, Left=842, Width=160, Height=85
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva.Left=5, Top=5 no legado)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar (Cancelar.Left=80, Top=5 no legado)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Label "Codigo :" (Say8: Left=238, Top=115 + 29 = 144)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo : "
            .Left      = 238
            .Top       = 144
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox txt_4c_Info (Get_Info: Left=287, Top=111 + 29 = 140, Width=20)
        *-- Editavel apenas no modo INCLUIR (When=INSERIR/PROCURAR no legado)
        loc_oPagina.AddObject("txt_4c_Info", "TextBox")
        WITH loc_oPagina.txt_4c_Info
            .Value     = ""
            .Left      = 287
            .Top       = 140
            .Width     = 20
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .MaxLength = 1
            .Visible   = .T.
        ENDWITH

        *-- Label "Descricao :" (Say7: Left=225, Top=139 + 29 = 168)
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Left      = 225
            .Top       = 168
            .Width     = 58
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox txt_4c_Descr (Get_Descr: Left=287, Top=136 + 29 = 165, Width=115)
        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value     = ""
            .Left      = 287
            .Top       = 165
            .Width     = 115
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .MaxLength = 15
            .Visible   = .T.
        ENDWITH

        *-- Label "Empresas :" (Say27: Left=217, Top=166 + 29 = 195, Width=66, Height=15)
        loc_oPagina.AddObject("lbl_4c_Empresas", "Label")
        WITH loc_oPagina.lbl_4c_Empresas
            .Caption   = "Empresas : "
            .Left      = 217
            .Top       = 195
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs Confirmar/Cancelar (metodos PUBLIC - Problem17)
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Grid de empresas vinculadas (Grade: top=164+29=193, left=287, width=161, height=330)
        *-- RecordSource/ColumnCount FORA do WITH para criar colunas imediatamente (Problema36)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oPagina.grd_4c_Dados.RecordSource = ""
        loc_oPagina.grd_4c_Dados.ColumnCount  = 2

        WITH loc_oPagina.grd_4c_Dados
            .Top                = 193
            .Left               = 287
            .Width              = 161
            .Height             = 330
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
            .Column1.ControlSource   = "cursor_4c_Emps.Emps"
            .Column1.Width           = 90
            .Column1.Header1.Caption = "Empresa"
            .Column2.ControlSource   = "cursor_4c_Emps.PercEmps"
            .Column2.Width           = 60
            .Column2.Header1.Caption = "%"
        ENDWITH

        loc_oPagina.grd_4c_Dados.ColumnCount = 2
        loc_oPagina.grd_4c_Dados.RecordSource = "cursor_4c_Emps"

        *-- Botao Inserir linha (inserir: top=259+29=288, left=453, width=45, height=45)
        loc_oPagina.AddObject("cmd_4c_InsEmps", "CommandButton")
        WITH loc_oPagina.cmd_4c_InsEmps
            .Caption     = "+"
            .ToolTipText = "Inserir Empresa"
            .Top         = 288
            .Left        = 453
            .Width       = 45
            .Height      = 45
            .Themes      = .T.
            .FontName    = "Tahoma"
            .FontSize    = 12
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Botao Excluir linha (excluir: top=303+29=332, left=453, width=45, height=45)
        loc_oPagina.AddObject("cmd_4c_DelEmps", "CommandButton")
        WITH loc_oPagina.cmd_4c_DelEmps
            .Caption     = "-"
            .ToolTipText = "Excluir Empresa"
            .Top         = 332
            .Left        = 453
            .Width       = 45
            .Height      = 45
            .Themes      = .T.
            .FontName    = "Tahoma"
            .FontSize    = 12
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- BINDEVENTs grid e botoes de empresas (metodos PUBLIC - Problema17)
        BINDEVENT(loc_oPagina.grd_4c_Dados,   "KeyPress",          THIS, "GridEmpsKeyPress")
        BINDEVENT(loc_oPagina.grd_4c_Dados,   "AfterRowColChange", THIS, "GridEmpsAfterRowColChange")
        BINDEVENT(loc_oPagina.cmd_4c_InsEmps, "Click", THIS, "BtnInsEmpsClick")
        BINDEVENT(loc_oPagina.cmd_4c_DelEmps, "Click", THIS, "BtnDelEmpsClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna controles do container visiveis recursivamente
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oObjeto

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_i)
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

    *===========================================================================
    * FormatarGridLista - Aplica formatacao visual no grid de lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega registros de SigPrInf no grid da Page1
    * Configuracao de ControlSource ativa quando o grid existir (Fase 4+)
    *===========================================================================
    PROCEDURE CarregarLista()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 2

                    loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Infos"
                    loc_oGrid.Column1.Width            = 60
                    loc_oGrid.Column1.Header1.Caption  = ""

                    loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descrs"
                    loc_oGrid.Column2.Width            = 820
                    loc_oGrid.Column2.Header1.Caption  = ""

                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, ;
                "FormInf.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
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
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loc_oErro.Message, "FormInf.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Inclui novo registro de informacao complementar
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
    * BtnVisualizarClick - Visualiza registro selecionado em modo somente leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        LOCAL loc_cInfo, loc_lCarregou
        loc_cInfo    = ALLTRIM(cursor_4c_Dados.Infos)
        loc_lCarregou = .F.

        TRY
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cInfo)
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar registro:" + CHR(13) + loc_oErro.Message, ;
                "FormInf.BtnVisualizarClick")
        ENDTRY

        IF loc_lCarregou
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Altera registro selecionado na lista
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        LOCAL loc_cInfo, loc_lCarregou
        loc_cInfo    = ALLTRIM(cursor_4c_Dados.Infos)
        loc_lCarregou = .F.

        TRY
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cInfo)
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar registro:" + CHR(13) + loc_oErro.Message, ;
                "FormInf.BtnAlterarClick")
        ENDTRY

        IF loc_lCarregou
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao do usuario
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        LOCAL loc_cInfo, loc_lCarregou, loc_lExcluiu
        loc_cInfo    = ALLTRIM(cursor_4c_Dados.Infos)
        loc_lCarregou = .F.
        loc_lExcluiu  = .F.

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da informa" + ;
                CHR(231) + CHR(227) + "o '" + loc_cInfo + "'?", "Excluir")
            RETURN
        ENDIF

        TRY
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cInfo)
            IF loc_lCarregou
                loc_lExcluiu = THIS.this_oBusinessObject.Excluir()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir registro:" + CHR(13) + loc_oErro.Message, ;
                "FormInf.BtnExcluirClick")
        ENDTRY

        IF loc_lExcluiu
            MsgInfo("Informa" + CHR(231) + CHR(227) + "o exclu" + ;
                CHR(237) + "da com sucesso!", "Excluir")
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar registro em SigPrInf
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cInfo, loc_lCarregou
        loc_cInfo    = ""
        loc_lCarregou = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrInf", "cursor_4c_BuscaInf", "Infos", loc_cInfo, ;
                "Buscar Informa" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Infos",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaInf")
                    SELECT cursor_4c_BuscaInf
                    loc_cInfo = ALLTRIM(cursor_4c_BuscaInf.Infos)
                    loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cInfo)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, ;
                "FormInf.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaInf")
            USE IN cursor_4c_BuscaInf
        ENDIF

        IF loc_lCarregou
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva o registro (SigPrInf + SigEmInf via BO)
    * Validacoes: codigo obrigatorio e unico no modo INCLUIR
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_cInfos
        loc_lSucesso = .F.

        *-- Validacoes FORA do TRY (Problem16 - RETURN em TRY nao funciona)
        loc_cInfos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Info.Value)

        IF THIS.this_cModoAtual = "INCLUIR"
            IF EMPTY(loc_cInfos)
                MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.", "Confirmar")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Info.SetFocus
                RETURN
            ENDIF
            IF THIS.this_oBusinessObject.VerificarCodigoDuplicado(loc_cInfos)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado.", "Confirmar")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Info.SetFocus
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            loc_cInfos = THIS.this_oBusinessObject.this_cInfos

            IF THIS.this_oBusinessObject.Salvar()
                IF THIS.this_oBusinessObject.SalvarEmpresas(loc_cInfos, "cursor_4c_Emps")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, ;
                "FormInf.BtnSalvarClick")
        ENDTRY

        IF loc_lSucesso
            MsgInfo("Informa" + CHR(231) + CHR(227) + "o salva com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para a lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos do form para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        THIS.this_oBusinessObject.this_cInfos  = ALLTRIM(loc_oPg2.txt_4c_Info.Value)
        THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BO para os campos do form
    * Usa cursor temporario para carregar empresas sem destruir colunas do Grid (Problema34)
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cInfos
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cInfos = ALLTRIM(THIS.this_oBusinessObject.this_cInfos)

        loc_oPg2.txt_4c_Info.Value  = THIS.this_oBusinessObject.this_cInfos
        loc_oPg2.txt_4c_Descr.Value = THIS.this_oBusinessObject.this_cDescrs

        *-- Usar cursor temporario para preservar colunas do grd_4c_Dados (Problema34)
        IF THIS.this_oBusinessObject.CarregarEmpresas(loc_cInfos, "cursor_4c_EmpsTemp")
            IF USED("cursor_4c_Emps")
                SELECT cursor_4c_Emps
                ZAP
                APPEND FROM DBF("cursor_4c_EmpsTemp")
            ENDIF
            IF USED("cursor_4c_EmpsTemp")
                USE IN cursor_4c_EmpsTemp
            ENDIF
        ENDIF

        IF USED("cursor_4c_Emps") AND RECCOUNT("cursor_4c_Emps") = 0
            APPEND BLANK IN cursor_4c_Emps
        ENDIF

        IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
            loc_oPg2.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis conforme modo
    * par_lHabilitar : .T.=edicao ativa, .F.=somente leitura
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- txt_4c_Info editavel APENAS no modo INCLUIR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Info", 5)
            loc_oPg2.txt_4c_Info.ReadOnly = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        *-- txt_4c_Descr editavel em INCLUIR e ALTERAR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
            loc_oPg2.txt_4c_Descr.ReadOnly = !par_lHabilitar
        ENDIF

        *-- Botao Confirmar habilitado apenas quando editando
        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
            ENDIF
        ENDIF

        *-- Botoes do grid de empresas (adicionados na Fase 6)
        IF PEMSTATUS(loc_oPg2, "cmd_4c_InsEmps", 5)
            loc_oPg2.cmd_4c_InsEmps.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cmd_4c_DelEmps", 5)
            loc_oPg2.cmd_4c_DelEmps.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos do formulario
    * Zera cursor de empresas mantendo linha em branco para edicao
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Info", 5)
            loc_oPg2.txt_4c_Info.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descr", 5)
            loc_oPg2.txt_4c_Descr.Value = ""
        ENDIF

        IF USED("cursor_4c_Emps")
            SELECT cursor_4c_Emps
            ZAP
            APPEND BLANK
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnInsEmpsClick - Insere linha em branco no grid de empresas
    * Legado: SIGCDINF.Pagina.Dados.inserir.Click
    * Adiciona linha apenas se nao houver linha vazia ja existente
    *===========================================================================
    PROCEDURE BtnInsEmpsClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        LOCAL loc_lTemVazio, loc_oGrid
        loc_lTemVazio = .F.
        loc_oGrid     = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados

        TRY
            IF USED("cursor_4c_Emps")
                SELECT cursor_4c_Emps
                LOCATE FOR EMPTY(ALLTRIM(Emps))
                IF FOUND()
                    loc_lTemVazio = .T.
                ENDIF

                IF !loc_lTemVazio
                    APPEND BLANK IN cursor_4c_Emps
                    GO BOTTOM IN cursor_4c_Emps
                ENDIF

                loc_oGrid.Refresh()
                loc_oGrid.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir empresa:" + CHR(13) + loc_oErro.Message, ;
                "FormInf.BtnInsEmpsClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnDelEmpsClick - Remove linha atual do grid de empresas
    * Legado: SIGCDINF.Pagina.Dados.excluir.Click
    *===========================================================================
    PROCEDURE BtnDelEmpsClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        LOCAL loc_oGrid
        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados

        TRY
            IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps") AND !BOF("cursor_4c_Emps")
                SELECT cursor_4c_Emps
                DELETE
                loc_oGrid.Refresh()
                loc_oGrid.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir empresa:" + CHR(13) + loc_oErro.Message, ;
                "FormInf.BtnDelEmpsClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GridEmpsKeyPress - Intercepta F4 na coluna 1 (Empresa) para abrir lookup
    * BINDEVENT requer LPARAMETERS obrigatorios (Problema38)
    *===========================================================================
    PROCEDURE GridEmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            TRY
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados, "ActiveColumn", 5)
                    IF THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.ActiveColumn = 1
                        THIS.AbrirLookupEmpresa()
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MostrarErro("Erro ao abrir lookup empresa:" + CHR(13) + loc_oErro.Message, ;
                    "FormInf.GridEmpsKeyPress")
            ENDTRY
        ENDIF
    ENDPROC

    *===========================================================================
    * GridEmpsAfterRowColChange - Valida empresa duplicada ao mudar de linha
    * Legado: SIGCDINF.Pagina.Dados.Grade.Column1.Text1.LostFocus (COUNT duplicatas)
    * BINDEVENT requer LPARAMETERS obrigatorios (Problema38)
    *===========================================================================
    PROCEDURE GridEmpsAfterRowColChange(par_nColIndex)
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        LOCAL loc_cEmps, loc_nRecAtual, loc_nDup
        loc_cEmps     = ""
        loc_nRecAtual = 0
        loc_nDup      = 0

        TRY
            IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")
                SELECT cursor_4c_Emps
                loc_cEmps     = ALLTRIM(Emps)
                loc_nRecAtual = RECNO("cursor_4c_Emps")

                IF !EMPTY(loc_cEmps)
                    COUNT FOR ALLTRIM(Emps) = loc_cEmps TO loc_nDup

                    IF loc_nDup > 1
                        MsgAviso("Empresa j" + CHR(225) + " lan" + CHR(231) + ;
                            "ada!!!", "Empresas")
                        SELECT cursor_4c_Emps
                        GO loc_nRecAtual
                        REPLACE Emps WITH SPACE(3)
                        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar empresa:" + CHR(13) + loc_oErro.Message, ;
                "FormInf.GridEmpsAfterRowColChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirLookupEmpresa - Abre FormBuscaAuxiliar para selecionar Empresa
    * Substitui fAcessoEmpresa() nao portada (feedback_facessoempresa_nao_portada.md)
    * Tabela: SigCdEmp (cemps C(3) PK, razas C(40))
    *===========================================================================
    PROCEDURE AbrirLookupEmpresa()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cEmps
        loc_cEmps = ""

        IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")
            SELECT cursor_4c_Emps
            loc_cEmps = ALLTRIM(Emps)
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "cemps", loc_cEmps, ;
                "Buscar Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    loc_cEmps = ALLTRIM(cemps)

                    IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")
                        SELECT cursor_4c_Emps
                        REPLACE Emps WITH loc_cEmps
                        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca de empresa:" + CHR(13) + loc_oErro.Message, ;
                "FormInf.AbrirLookupEmpresa")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    * Chamado apos BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick
    * INCLUIR/ALTERAR : Confirmar habilitado, outros CRUD desabilitados
    * VISUALIZAR       : Confirmar desabilitado, Cancelar habilitado
    * LISTA            : Todos os botoes CRUD habilitados
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lEditando, loc_lVisualizando
        loc_oPg1         = THIS.pgf_4c_Paginas.Page1
        loc_oPg2         = THIS.pgf_4c_Paginas.Page2
        loc_lEditando    = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_lVisualizando = (THIS.this_cModoAtual = "VISUALIZAR")

        *-- Page1: botoes CRUD (habilitados so na Lista)
        IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
            WITH loc_oPg1.cnt_4c_Botoes
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir",    5)
                    .cmd_4c_Incluir.Enabled    = .T.
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                    .cmd_4c_Visualizar.Enabled = .T.
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar",    5)
                    .cmd_4c_Alterar.Enabled    = .T.
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir",    5)
                    .cmd_4c_Excluir.Enabled    = .T.
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar",     5)
                    .cmd_4c_Buscar.Enabled     = .T.
                ENDIF
                .Visible     = .T.
            ENDWITH
        ENDIF

        *-- Page2: Confirmar e Cancelar
        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF

        *-- Botoes de linha do grid de empresas
        IF PEMSTATUS(loc_oPg2, "cmd_4c_InsEmps", 5)
            loc_oPg2.cmd_4c_InsEmps.Enabled = loc_lEditando
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cmd_4c_DelEmps", 5)
            loc_oPg2.cmd_4c_DelEmps.Enabled = loc_lEditando
        ENDIF
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos do formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Dados", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.RecordSource = ""
            ENDIF
        CATCH TO loc_oDestroyErr
            MsgErro(loc_oDestroyErr.Message, "FormInf.Destroy")
        ENDTRY
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Emps")
            USE IN cursor_4c_Emps
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
